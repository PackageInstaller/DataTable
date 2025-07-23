module("hero.HeroSkillIntroduceTabView", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("hero/tab/HeroSkillTab.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
    self:setUICode(LinkCode.HeroSkill)
end

-- 初始化数据
function initData(self)
    super.initData(self)
    -- 当前英雄id
    self.mHeroTid = nil

    -- -- 技能分类位置列表
    -- self.mSkillNormalPosList = { 1, 2 }
    -- self.mSkillAoyiPosList = { 3, 4 }
    -- self.propItemList = {}
    self.mTalentLst = {}
    -- self.mTalentGrid = nil
    -- self.mTalentGridEvent = nil
    -- self.isTalent = false
end

-- 玩家点击关闭
function onClickClose(self)
    super.onClickClose(self)
    self:__playerClose()
end

-- 玩家关闭所有窗口的c#回调
function onCloseAllCall(self)
    super.onCloseAllCall(self)
    self:__playerClose()
end

function __playerClose(self)
end

function configUI(self)
    super.configUI(self)

    -- 主动技能界面
    self.mGroupInfo = self:getChildGO("mGroupInfo")
    self.mGroupRight = self:getChildGO("mGroupRight")
    -- self.mBtnPromote = self:getChildGO("mBtnPromote")
    -- self.mImgMaxLvBg = self:getChildGO("mImgMaxLvBg")
    -- self.mNextScrollView = self:getChildTrans("mNextScrollView")
    -- self.mGroupActiveSkill = self:getChildGO("mGroupActiveSkill")
    -- self.mTxtLv = self:getChildGO("mTxtLv"):GetComponent(ty.Text)
    -- self.mSkillScrollView = self:getChildTrans("mSkillScrollView")
    -- self.mTxtMaxLv = self:getChildGO("mTxtMaxLv"):GetComponent(ty.Text)
    -- self.mTxtMoney = self:getChildGO("mTxtMoney"):GetComponent(ty.Text)
    -- self.mTxtNextLv = self:getChildGO("mTxtNextLv"):GetComponent(ty.Text)
    -- self.mTxtMaterial = self:getChildGO("mTxtMaterial"):GetComponent(ty.Text)
    -- self.mImgRange = self:getChildGO("mImgRange"):GetComponent(ty.AutoRefImage)
    -- self.mImgMoney = self:getChildGO("mImgMoney"):GetComponent(ty.AutoRefImage)
    -- self.mTxtNextDesc = self:getChildGO("mTxtNextDesc"):GetComponent(ty.RichText)
    -- self.mTxtCoolingDesc = self:getChildGO("mTxtCoolingDesc"):GetComponent(ty.Text)
    -- self.mTxtSkillDesc = self:getChildGO("mTxtSkillDesc"):GetComponent(ty.RichText)
    self.mTxtImgActSkill = self:getChildGO("mTxtImgActSkill"):GetComponent(ty.Text)
    self.mTxtImgBroastSkill = self:getChildGO("mTxtImgBroastSkill"):GetComponent(ty.Text)
    -- self.mTxtSkillDesc:SetEventCall(self, self.onHrefEventCall)
    -- self.mTxtNextDesc:SetEventCall(self, self.onHrefEventCall)
    -- self.mBtnChangeSkill = self:getChildGO("mBtnChangeSkill")

    self:setGuideTrans("funcTips_skill_1", self:getChildTrans("mGroupFuncTipsSkill1"))
    self:setGuideTrans("funcTips_skill_2", self:getChildTrans("mGroupFuncTipsSkill2"))
    self:setGuideTrans("funcTips_skill_3", self:getChildTrans("mGroupFuncTipsSkill3"))

    -- self:setGuideTrans("funcTips_changeSkillBtn", self:getChildTrans("mBtnChangeSkill"))

end

function active(self, args)
    super.active(self, args)
    self.mGroupInfo:SetActive(false)
    self.mGroupRight:SetActive(true)
    self:setData(args.heroTid)
    if not self.mEffParent then
        self.mEffParent = gs.GameObject.Find("ui_effect_bg_01")
    end
    -- UIEffectMgr:addEffect("fx_ui_hero_bg", self.mEffParent.transform)
end

function deActive(self)
    super.deActive(self)
    self:recoverTalentSkill()
    self.isTalent = false
    -- self:onCloseChangeSkillHandler()
    -- UIEffectMgr:removeEffect("fx_ui_hero_bg", self.mEffParent.transform)
    self.mEffParent = nil
end

function initViewText(self)
    self.mTxtImgActSkill.text = _TT(1226)--"主动技能"
    self.mTxtImgBroastSkill.text = _TT(3022)--"源能爆发"
end

function addAllUIEvent(self)
    self:addUIEvent(self:getChildGO("mBtnFuncTips"), self.onClickFuncTipsHandler)
end

-- 是否可以关闭，由父面板触发
function __isCanSubViewClose__(self)
    return true
end

---------------------------------------------------------------------------设置数据更新逻辑 (start)----------------------------------------------------------------------------------
-- 设置数据
function setData(self, heroTid)
    self.mHeroTid = heroTid
    self.heroVo = hero.HeroManager:getHeroConfigVo(self.mHeroTid)
    self:updateView()
end

-- 更新界面
function updateView(self)
    self:updateActiveSkillView()
    -- self:updateSkillMoneyState()
end

-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 更新主动技能界面
function updateActiveSkillView(self)
    self:recoverActiveSkillItem()
    for i = 1, #self.heroVo.baseSkillIdList do
        local skillVo = fight.SkillManager:getSkillRo(self.heroVo.baseSkillIdList[i])
        if (skillVo) then
            local item = hero.HeroSkillIntroduceItem:create(self:getChildTrans("mSkillNode" .. (i)), "SkillItem")
            local isUnlock = 1
            item:setData(self.heroVo, skillVo, isUnlock, 1, true)
            self.mSkillItemDic[skillVo:getRefID()] = {
                item = item,
                eventTrigger = item:getTrans():GetComponent(ty.LongPressOrClickEventTrigger)
            }
            self:addTriggerEvent(skillVo:getRefID())
        end
    end
    self:updateTalentSkill()

end

-- 更新天赋技能
function updateTalentSkill(self)
    self:recoverTalentSkill()
    for k, v in pairs(self.heroVo.inBornSkill) do
        local skillId = v
        local skillVo = fight.SkillManager:getSkillRo(skillId)
        local isUnlock = 1
        local mTalentGrid = hero.HeroSkillIntroduceItem:create(self:getChildTrans("mTalentSkillNode"), "TalentSkillItem")
        mTalentGrid:setData(self.heroVo, skillVo, isUnlock, 1, true)
        mTalentGrid:getChildGO("mImgName"):SetActive(true)
        -- mTalentGrid:getChildGO("mImgLock"):SetActive(true)
        mTalentGrid:getChildGO("mImgSkillLvl"):SetActive(false)
        mTalentGrid:getChildGO("mGroupAdaptive"):SetActive(false)
        mTalentGrid:getChildGO("mGroupRight"):SetActive(false)
        mTalentGrid:getChildGO("mTxtSkillNameDown"):SetActive(true)
        mTalentGrid:getChildGO("mImgSkillBg"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getCommon5Path("common_0055.png"), false)
        local mTalentGridEvent = mTalentGrid:getTrans():GetComponent(ty.LongPressOrClickEventTrigger)
        local function _onClick()
            self:onClickItemHandler(skillVo:getRefID(), isUnlock, true)
        end
        mTalentGridEvent.onClick:AddListener(_onClick)

        table.insert(self.mTalentLst, { item = mTalentGrid, event = mTalentGridEvent })
    end
end

function addTriggerEvent(self, skillId, pos)
    local function _onClick()
        local isUnlock = 1
        if self.mHeroId then
            local skillPos = self.mSkillItemDic[skillId].skillPos
            -- isUnlock = self.heroVo.fightSkillDic[skillPos] == nil and 1 or self.heroVo.fightSkillDic[skillPos].isUnlock
        end

        self:onClickItemHandler(skillId, 1)
    end
    local eventTrigger = self.mSkillItemDic[skillId].eventTrigger
    eventTrigger.onClick:AddListener(_onClick)
end

function removeTriggerEvent(self, skillId)
    local eventTrigger = self.mSkillItemDic[skillId].eventTrigger
    eventTrigger.onClick:RemoveAllListeners()
end

function onClickItemHandler(self, skillId, isUnlock)
    TipsFactory:skillTips(nil, skillId, self.heroVo, false)
    -- self:onUpdateSkillInfo(skillId, isUnlock)
end

function onHrefEventCall(self, pos1, pos2, linkStr, link)
    if linkStr and link then
        TipsFactory:SkillEffectTips({ title = link, des = linkStr })
    end
end

-- 回收项
function recoverActiveSkillItem(self)
    if self.curActiveSkillItem then
        self.curActiveSkillItem:SetActive(false)
        self.curActiveSkillItem = nil
    end

    if self.mSkillItemDic then
        for skillId, data in pairs(self.mSkillItemDic) do
            self:removeTriggerEvent(skillId)
            data.item:poolRecover()
        end
    end
    self.mSkillItemDic = {}
end

function recoverTalentSkill(self)
    for k, v in pairs(self.mTalentLst) do
        if (v) then
            v.event.onClick:RemoveAllListeners()
            v.event = nil
            v.item:poolRecover()
        end
    end
    self.mTalentLst = {}
end

-- 回收项
function recoverPropsListItem(self)
    if #self.propItemList > 0 then
        for k, item in ipairs(self.propItemList) do
            item:poolRecover()
            item = nil
        end
        self.propItemList = {}
    end
end

--------------------------------------------------------------------------------------此处复制出来改的拖拽逻辑 start----------------------------------------------------------------------------------

--打开规则说明界面
function onClickFuncTipsHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_FUNCTIPS_VIEW, { id = LinkCode.HeroSkill })
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]