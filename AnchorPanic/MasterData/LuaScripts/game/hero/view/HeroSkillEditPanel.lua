module("hero.HeroSkillEditPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("hero/HeroSkillEditPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isBlur = 1 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）

--构造函数
function ctor(self)
    super.ctor(self)
    self:setTxtTitle(_TT(1296))
    self:setSize(1117, 520)
end

-- 初始化数据
function initData(self)
    super.initData(self)
    
    -- 技能分类位置列表
    self.mSkillNormalPosList = {1, 2}
    self.mSkillAoyiPosList = {3, 4}
end

function configUI(self)
	super.configUI(self)
    self.mTxtSkillTip1 = self:getChildGO("mTxtSkillTip1"):GetComponent(ty.Text)
    self.mTxtSkillTip2 = self:getChildGO("mTxtSkillTip2"):GetComponent(ty.Text)
    self.mSkillShow = self:getChildTrans("mSkillShow")
    self.mSkillShowSize = self:getChildGO("mSkillShow"):GetComponent(ty.RectTransform).sizeDelta
end

function active(self, args)
    super.active(self, args)
    hero.HeroManager:addEventListener(hero.HeroManager.HERO_ADD_FIGHT_SKILL_RESULT, self.onUpdateHeroAddFightSkillHandler, self)
    hero.HeroManager:addEventListener(hero.HeroManager.HERO_DEL_FIGHT_SKILL_RESULT, self.onUpdateHeroDelFightSkillHandler, self)

    self.mHeroId = args.heroId
    self:__updateView()
end

function deActive(self)
	super.deActive(self)
    hero.HeroManager:removeEventListener(hero.HeroManager.HERO_ADD_FIGHT_SKILL_RESULT, self.onUpdateHeroAddFightSkillHandler, self)
    hero.HeroManager:removeEventListener(hero.HeroManager.HERO_DEL_FIGHT_SKILL_RESULT, self.onUpdateHeroDelFightSkillHandler, self)
    self:recoverShowActiveSkillItem()
end

function initViewText(self)
    self.mTxtSkillTip1.text = _TT(27001)--"拖动技能图标以改变技能的释放顺序"
    self.mTxtSkillTip2.text = _TT(1232)--"技能自左向右，依次释放"
end

function onUpdateHeroAddFightSkillHandler(self, args)
    local heroId = args.heroId
    if (self.mHeroId == heroId) then
        self:__updateView()
    end
end

function onUpdateHeroDelFightSkillHandler(self, args)
    local heroId = args.heroId
    if (self.mHeroId == heroId) then
        self:__updateView()
    end
end

-- 更新主动技能界面
function __updateView(self)
    local heroVo = hero.HeroManager:getHeroVo(self.mHeroId)
    local function getSkillVo(needSkillType, index)
        local _index = 0
        for i = 1, #heroVo.baseSkillIdList do
            local skillId = heroVo.baseSkillIdList[i]
            if(not heroVo.activeSkillDic[skillId])then
                local skillVo = fight.SkillManager:getSkillRo(skillId)
                local skillType = skillVo:getType()
                if(skillType == needSkillType)then
                    _index = _index + 1
                    if(_index == index)then
                        return skillVo
                    end
                end
            end
        end
        return nil
    end
    self:recoverShowActiveSkillItem()
    -- local curNormalIndex = 0
    -- local curAoyiIndex = 0
    local heroVo = hero.HeroManager:getHeroVo(self.mHeroId)
    local skillCount = #heroVo.baseSkillIdList
    for i = 2, skillCount do -- 跳过第一个默认普攻
        local skillPos = i - 1
        local skillVo = nil
        -- 出战技能先显示，空余的自动填顺序
        local skillPosVo = heroVo.fightSkillDic[skillPos]
        skillVo = fight.SkillManager:getSkillRo(skillPosVo.skillId)
        if(skillVo)then
            local item = hero.HeroSkillItem2:create(self:getChildTrans("mSkillNode"..(i-1)), "SkillItem")
            item:setData(heroVo, skillVo, heroVo.fightSkillDic[skillPos].isUnlock, 3)
            -- local item = hero.HeroSkillItem2:create(self:getChildTrans("mSkillNode"..(i-1)), {heroVo = heroVo, skillVo = skillVo}, heroVo.fightSkillDic[skillPos].isUnlock, 3, false)
            self.mSkillItemDic[skillVo:getRefID()] = {
                skillPos = skillPos, 
                item = item, 
                skillGoBg = item:getChildGO("mImgSkillBg"),
                rect = self:getChildGO("mSkillNode"..(i-1)):GetComponent(ty.RectTransform), 
                eventTrigger = item:getTrans():GetComponent(ty.LongPressOrClickEventTrigger)
                }
            self:addShowTriggerEvent(skillVo:getRefID())
        end
    end
end

function addShowTriggerEvent(self, skillId)
    local function _onPointDownHandler()
        self:__onShowPointDownHandler(skillId)
    end
    local function _onPointUpHandler()
        self:__onShowPointUpHandler(skillId)
    end
    local eventTrigger = self.mSkillItemDic[skillId].eventTrigger
    eventTrigger.onPointerDown:AddListener(_onPointDownHandler)
    eventTrigger.onPointerUp:AddListener(_onPointUpHandler)
end

function __removeShowTriggerEvent(self, skillId)
    local eventTrigger = self.mSkillItemDic[skillId].eventTrigger
    eventTrigger.onPointerDown:RemoveAllListeners()
    eventTrigger.onPointerUp:RemoveAllListeners()
end

function __onShowPointDownHandler(self, skillId)
    -- 设置穿透
    -- self.mSkillItemDic[skillId].eventTrigger:SetIsPassEvent(true)
    -- 设置拖拽的技能id
    self.mShowDragActiveSkillId = skillId
    self.mStartMousePos = gs.Vector2(gs.Input.mousePosition.x, gs.Input.mousePosition.y)
    self:__removeShowFrameSn()
    self:__addShowFrameSn()

    -- 设置禁用提示
    local downSkillPos= self.mSkillItemDic[skillId].skillPos
    for showSkillId, showData in pairs(self.mSkillItemDic) do
        if(table.indexof(self.mSkillNormalPosList, showData.skillPos) ~= false)then
            if(table.indexof(self.mSkillNormalPosList, downSkillPos) ~= false)then
                showData.item:setForbid(false)
            else
                showData.item:setForbid(true)
            end
        elseif(table.indexof(self.mSkillAoyiPosList, showData.skillPos) ~= false)then
            if(table.indexof(self.mSkillAoyiPosList, downSkillPos) ~= false)then
                showData.item:setForbid(false)
            else
                showData.item:setForbid(true)
            end
        end
    end
end

function __addShowFrameSn(self)
    if(not self.mShowFrameSn)then
        self.mShowFrameSn = LoopManager:addFrame(1, 0, self, self.__onShowMoveSkillFrameHandler)
    end
end

function __removeShowFrameSn(self)
    if (self.mShowFrameSn) then
        LoopManager:removeFrameByIndex(self.mShowFrameSn)
        self.mShowFrameSn = nil
    end
end

function __onShowMoveSkillFrameHandler(self)
    if(self:isActiveSkillDrag())then
        if(self.mShowDragActiveSkillId)then
            if(not self.mShowDragGoBg)then
                local data = self.mSkillItemDic[self.mShowDragActiveSkillId]
                self.mShowDragGoBg = gs.GameObject.Instantiate(data.skillGoBg)
                local pos = data.rect.anchoredPosition
                gs.TransQuick:UIPos(self.mShowDragGoBg:GetComponent(ty.RectTransform), pos.x, pos.y)
                self.mShowDragGoBg.transform:SetParent(self.mSkillShow, false)
                -- self.mShowDragGo.transform:SetParent(self.mSkillShow, false)
            end
            if (self.mShowDragGoBg and not gs.GoUtil.IsGoNull(self.mShowDragGoBg)) then
                -- 把当前鼠标的屏幕坐标转换成世界坐标
                local screenPos = gs.Vector3(gs.Input.mousePosition.x, gs.Input.mousePosition.y, gs.Input.mousePosition.z)
                local worldPos = gs.CameraMgr:ScreenToWorldByUICamera(screenPos)
                gs.TransQuick:PosXY(self.mShowDragGoBg.transform, worldPos.x, worldPos.y)
            end
        end
    end
end

function __onShowPointUpHandler(self, skillId)
    self:__removeShowFrameSn()
    -- 判断是否解锁了，未解锁不给长按
    -- local heroVo = hero.HeroManager:getHeroVo(self.mHeroId)
    -- local skillLvl = heroVo.activeSkillDic[skillId]
    -- if(skillLvl)then
    local enterSkillId = self:getShowCollisionSkillId()
    if (enterSkillId) then
        local dragSkillPos = self.mSkillItemDic[skillId].skillPos
        local enterSkillPos = self.mSkillItemDic[enterSkillId].skillPos
        if((table.indexof(self.mSkillNormalPosList, dragSkillPos) and table.indexof(self.mSkillNormalPosList, enterSkillPos)) or 
            (table.indexof(self.mSkillAoyiPosList, dragSkillPos) and table.indexof(self.mSkillAoyiPosList, enterSkillPos)))then
            GameDispatcher:dispatchEvent(EventName.REQ_HERO_ADD_FIGHT_SKILL, { heroId = self.mHeroId, skillId = skillId, skillPos = enterSkillPos })
        else
            gs.Message.Show2(_TT(27019)) --"请保证技能类型一致"
        end
    end
    -- end
    self.mShowDragActiveSkillId = nil

    if (self.mShowDragGoBg and not gs.GoUtil.IsGoNull(self.mShowDragGoBg)) then
        gs.GameObject.Destroy(self.mShowDragGoBg)
        self.mShowDragGoBg = nil
    end

    -- 去掉禁用提示
    for showSkillId, showData in pairs(self.mSkillItemDic) do
        showData.item:setForbid(false)
    end
end

-- 获取进入的区域技能id
function getShowCollisionSkillId(self)
    if (self.mShowDragGoBg and not gs.GoUtil.IsGoNull(self.mShowDragGoBg)) then
        local uiPos = self.mShowDragGoBg:GetComponent(ty.RectTransform).anchoredPosition
        -- 将拖拽物的左边转成左上角对齐，和父容器一致
        uiPos.x = uiPos.x + self.mSkillShowSize.x / 2
        uiPos.y = uiPos.y - self.mSkillShowSize.y / 2
        for skillId, data in pairs(self.mSkillItemDic) do
            
            local slotSize = data.rect.sizeDelta
            local slotUiPos = data.rect.anchoredPosition
            if (uiPos.x >= slotUiPos.x - slotSize.x / 2 and uiPos.x <= slotUiPos.x + slotSize.x / 2 and uiPos.y >= slotUiPos.y - slotSize.y / 2 and uiPos.y <= slotUiPos.y + slotSize.y / 2) then
                return skillId
            end
        end
    end
end

function isActiveSkillDrag(self)
    if(self.mStartMousePos)then
        if(self.mStartMousePos.x == gs.Input.mousePosition.x and self.mStartMousePos.y == gs.Input.mousePosition.y)then
            return false
        else
            return true
        end
    else
        return false
    end
end

-- 回收项
function recoverShowActiveSkillItem(self)
    if self.mSkillItemDic then
        for skillId, data in pairs(self.mSkillItemDic) do
            self:__removeShowTriggerEvent(skillId)
            data.item:poolRecover()
        end
    end
    self.mSkillItemDic = {}
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(1296):	"<size=24>战</size>员技能"
]]
