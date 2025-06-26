--[[   
     英雄技能升级材料选择界面
]]
module('hero.HeroSkillUpMaterialPanel', Class.impl(View))
UIRes = UrlManager:getUIPrefabPath('hero/HeroSkillUpMaterialPanel.prefab')

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isBlur = 0 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）
blurTweenTime = 0 --模糊背景的渐变时间（仅2弹窗面板有效，默认不渐变，单位秒）
isScreensave = 0 --是否使用黑屏过渡(仅1全屏UI有效，默认开启，0关闭)

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(nil, nil)
    self:setTxtTitle('')
end

-- 设置全屏透明遮罩
function setMask(self)
    if not self.mask then
        self.mask = AssetLoader.GetGO(UrlManager:getPrefabPath('base/MaskLayer.prefab'))
        if not self.UIRootNode then
            self:createUIRootNode()
        end
        self.mask.transform:SetParent(self.UIRootNode, false)
        -- 屏蔽遮罩层关闭界面逻辑
        -- self:addOnClick(self.mask, self.onClickClose, self:getCloseSoundPath())
        self.mask:GetComponent(ty.Image).raycastTarget = false
    end
    self:__updateSiblingIndex()
end

-- 初始化数据
function initData(self)
    self.mSkillId = nil
    self.mHeroVo = nil
end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.mGroupLeft = self:getChildTrans('GroupLeft')
    self.mScrollerSelect = self:getChildGO('LyScroller'):GetComponent(ty.LyScroller)
    self.mScrollerSelect:SetItemRender(hero.HeroSkillUpScrollItem)
    self.mTextEmptyTip = self:getChildGO("TextEmptyTip"):GetComponent(ty.Text)

    self.mBtnBack = self:getChildGO('BtnBack')
end

-- 激活
function active(self, args)
    super.active(self, args)
    hero.HeroSkillUpManager:addEventListener(hero.HeroSkillUpManager.HERO_SKILL_UP_MATERIAL_SELECT, self.__onMaterialSelectHandler, self)

    self.mSkillId = args.skillId
    self.mHeroVo = args.heroVo
    self:updateView()
end

-- 非激活
function deActive(self)
    super.deActive(self)
    hero.HeroSkillUpManager:removeEventListener(hero.HeroSkillUpManager.HERO_SKILL_UP_MATERIAL_SELECT, self.__onMaterialSelectHandler, self)
    hero.HeroSkillUpManager.needMaterialCount = nil
    hero.HeroSkillUpManager.materialHeroIdList = {}
    -- 通知外部界面刷新下
    hero.HeroSkillUpManager:dispatchEvent(hero.HeroSkillUpManager.HERO_SKILL_UP_MATERIAL_UPDATE, {heroVo = self.mHeroVo, skillId = self.mSkillId})
end

function initViewText(self)
    self.mTextEmptyTip.text = _TT(1119) --"- 暂无可使用的战员 -"
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnBack, self.close)
end

function updateView(self)
    local skillLvl = self.mHeroVo.activeSkillDic[self.mSkillId]
    local skillUpVo = hero.HeroSkillUpManager:getSkillUpConfigVo(self.mHeroVo.tid, self.mSkillId, skillLvl)
    hero.HeroSkillUpManager.needMaterialCount = skillUpVo.needHeroNum
    hero.HeroSkillUpManager.materialHeroIdList = {}
    -- 通知外部界面刷新下
    hero.HeroSkillUpManager:dispatchEvent(hero.HeroSkillUpManager.HERO_SKILL_UP_MATERIAL_UPDATE, {heroVo = self.mHeroVo, skillId = self.mSkillId})

    self:__updateLeftView()
end

function __updateLeftView(self, isInit)
    local skillLvl = self.mHeroVo.activeSkillDic[self.mSkillId]
    local skillUpVo = hero.HeroSkillUpManager:getSkillUpConfigVo(self.mHeroVo.tid, self.mSkillId, skillLvl)
    local list = hero.HeroSkillUpManager:getHeroScrollList(skillUpVo.needHeroTid, skillUpVo.needHeroColor, self.mHeroVo.id)
    local materialIdList = hero.HeroSkillUpManager.materialHeroIdList
    for i = 1, #list do
        local heroScrollVo = list[i]
        heroScrollVo:setSelect(false)
        local heroVo = heroScrollVo:getDataVo()
        for j = 1, #materialIdList do
            if (heroVo.id == materialIdList[j]) then
                heroScrollVo:setSelect(true)
                break
            end
        end
    end
    self:recoverListData(self.mScrollerSelect.DataProvider)
    if self.mScrollerSelect.Count <= 0 or isInit then
        self.mScrollerSelect.DataProvider = list
    else
        self.mScrollerSelect:ReplaceAllDataProvider(list)
    end
    self.mTextEmptyTip.gameObject:SetActive(#list <= 0)
end

function recoverListData(self, list)
    if (list and #list > 0) then
        for i, v in ipairs(list) do
            LuaPoolMgr:poolRecover(v)
        end
    end
end

function __onMaterialSelectHandler(self, heroVo)
    local function select()
        local isAdd, clickHeroVo = self:__materialSelect(heroVo)
        self:__updateLeftView()
        hero.HeroSkillUpManager:dispatchEvent(hero.HeroSkillUpManager.HERO_SKILL_UP_MATERIAL_UPDATE, {heroVo = self.mHeroVo, skillId = self.mSkillId})
    end

    local materialIdList = hero.HeroSkillUpManager.materialHeroIdList
    if table.indexof(materialIdList, heroVo.id) ~= false then
        select()
        return
    end

    if self.mHeroVo.color < heroVo.color then
        -- local isNotRemind = remind.RemindManager:isTodayNotRemain(RemindConst.HERO_SKILL_UP)
        -- if (isNotRemind) then
        --     select()
        -- else
        UIFactory:alertMessge(_TT(1121), true, function() -- "所选战员品质大于待升品战员品质，是否继续添加？"
            select()
        end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, RemindConst.HERO_SKILL_UP
        )
        -- end
    else
        select()
    end
end

function __materialSelect(self, args)
    local isAdd = true
    local clickHeroVo = args
    local materialIdList = hero.HeroSkillUpManager.materialHeroIdList
    local len = #materialIdList
    for i = 1, len do
        if (materialIdList[i] == clickHeroVo.id) then
            table.remove(materialIdList, i)
            isAdd = false
            break
        end
    end

    if (isAdd) then
        local skillLvl = self.mHeroVo.activeSkillDic[self.mSkillId]
        local skillUpVo = hero.HeroSkillUpManager:getSkillUpConfigVo(self.mHeroVo.tid, self.mSkillId, skillLvl)
        if (len >= skillUpVo.needHeroNum) then
            gs.Message.Show(_TT(1071))--"已经选满了"
            return
        else
            table.insert(materialIdList, clickHeroVo.id)
        end
    end
    local isAdd, clickHeroVo
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
