--[[
-----------------------------------------------------
@filename       : HeroSkillTabView
@Description    : 战员技能
@date           : 2023-05-11 16:51:13
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("hero.HeroSkillTabView", Class.impl(TabSubView))

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
    self.mHeroId = nil

    -- 技能分类位置列表
    self.mSkillNormalPosList = {1, 2}
    self.mSkillAoyiPosList = {3, 4}
    self.propItemList = {}
    self.mTalentLst = {}
    self.mTalentGrid = nil
    self.mTalentGridEvent = nil
    self.mSkillMaxHeight = 343
    self.isTalent = false
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
    self:__closeMaterialPanel()
end

function __closeMaterialPanel(self)
    if (self.mMaterialPanel) then
        self.mMaterialPanel:close()
    end
end

function configUI(self)
    super.configUI(self)
    -- 主动技能界面
    self.mBtnMax = self:getChildGO("mBtnMax")
    self.mBtnBack = self:getChildGO("mBtnBack")
    self.mBtnLvUp = self:getChildGO("mBtnLvUp")
    self.mImgLine = self:getChildTrans("mImgLine")
    self.mBtnDetail = self:getChildGO("mBtnDetail")
    self.mGroupInfo = self:getChildGO("mGroupInfo")
    self.mGroupRight = self:getChildGO("mGroupRight")
    self.mBtnPromote = self:getChildGO("mBtnPromote")
    self.mImgMaxLvBg = self:getChildGO("mImgMaxLvBg")
    self.mAni = self.mGroupRight:GetComponent(ty.Animator)
    self.mNextScrollView = self:getChildTrans("mNextScrollView")
    self.mGroupActiveSkill = self:getChildGO("mGroupActiveSkill")
    self.mTxtLv = self:getChildGO("mTxtLv"):GetComponent(ty.Text)
    self.mSkillScrollView = self:getChildTrans("mSkillScrollView")
    self.mTxtMaxLv = self:getChildGO("mTxtMaxLv"):GetComponent(ty.Text)
    self.mTxtMoney = self:getChildGO("mTxtMoney"):GetComponent(ty.Text)
    self.mTxtNextLv = self:getChildGO("mTxtNextLv"):GetComponent(ty.Text)
    self.mTxtMaterial = self:getChildGO("mTxtMaterial"):GetComponent(ty.Text)
    self.mTxtSkillName = self:getChildGO("mTxtSkillName"):GetComponent(ty.Text)
    self.mImgRange = self:getChildGO("mImgRange"):GetComponent(ty.AutoRefImage)
    self.mImgMoney = self:getChildGO("mImgMoney"):GetComponent(ty.AutoRefImage)
    self.mTxtNextDesc = self:getChildGO("mTxtNextDesc"):GetComponent(ty.TMP_Text)
    self.mTxtNextDescLink = self:getChildGO("mTxtNextDesc"):GetComponent(ty.TextMeshProLink)
    self.mTxtNextDescLink:SetEventCall(notice.HrefUtil.commonTitleDesLinkData)
    self.mTxtCoolingDesc = self:getChildGO("mTxtCoolingDesc"):GetComponent(ty.Text)
    self.mTxtSkillDesc = self:getChildGO("mTxtSkillDesc"):GetComponent(ty.TMP_Text)
    self.mTxtSkillDescLink = self:getChildGO("mTxtSkillDesc"):GetComponent(ty.TextMeshProLink)
    self.mTxtSkillDescLink:SetEventCall(notice.HrefUtil.commonTitleDesLinkData)
    self.mTxtImgActSkill = self:getChildGO("mTxtImgActSkill"):GetComponent(ty.Text)
    self.mTxtImgBroastSkill = self:getChildGO("mTxtImgBroastSkill"):GetComponent(ty.Text)
    -- self.mBtnChangeSkill = self:getChildGO("mBtnChangeSkill")

    self:setGuideTrans("funcTips_skill_1", self:getChildTrans("mGroupFuncTipsSkill1"))
    self:setGuideTrans("funcTips_skill_2", self:getChildTrans("mGroupFuncTipsSkill2"))
    self:setGuideTrans("funcTips_skill_3", self:getChildTrans("mGroupFuncTipsSkill3"))

    self.mEffParent = gs.GameObject.Find("ui_effect_bg")
    -- self:setGuideTrans("funcTips_changeSkillBtn", self:getChildTrans("mBtnChangeSkill"))
end

function active(self, args)
    super.active(self, args)
    bag.BagManager:addEventListener(bag.BagManager.BAG_UPDATE, self.updateSkillItemState, self)
    role.RoleManager:getRoleVo():addEventListener(role.RoleVo.CHANGE_PLAYER_MONEY, self.updateView, self)
    GameDispatcher:addEventListener(EventName.UPDATE_SKILL_UP_PANEL, self.onUpdateActiveSkillLvlHandler, self)
    hero.HeroManager:addEventListener(hero.HeroManager.HERO_ADD_FIGHT_SKILL_RESULT, self.onUpdateHeroAddFightSkillHandler, self)
    hero.HeroManager:addEventListener(hero.HeroManager.HERO_DEL_FIGHT_SKILL_RESULT, self.onUpdateHeroDelFightSkillHandler, self)
    self.mGroupInfo:SetActive(false)
    self.mGroupRight:SetActive(true)
    self.isTalent = false
    gs.TransQuick:LPosY(self:getChildTrans("mTxtSkillTrans"), 0)
    gs.TransQuick:LPosY(self:getChildTrans("mTxtNextTrans"), 0)
    self:setData(args.heroId, args.heroTid)
end

function deActive(self)
    super.deActive(self)
    bag.BagManager:removeEventListener(bag.BagManager.BAG_UPDATE, self.updateSkillItemState, self)
    role.RoleManager:getRoleVo():removeEventListener(role.RoleVo.CHANGE_PLAYER_MONEY, self.updateView, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_SKILL_UP_PANEL, self.onUpdateActiveSkillLvlHandler, self)
    hero.HeroManager:removeEventListener(hero.HeroManager.HERO_ADD_FIGHT_SKILL_RESULT, self.onUpdateHeroAddFightSkillHandler, self)
    hero.HeroManager:removeEventListener(hero.HeroManager.HERO_DEL_FIGHT_SKILL_RESULT, self.onUpdateHeroDelFightSkillHandler, self)

    if (self.mTalentGrid ~= nil) then
        self.mTalentGridEvent.onClick:RemoveAllListeners()
        self.mTalentGridEvent = nil
        self.mTalentGrid:poolRecover()
        self.mTalentGrid = nil
    end

    for k, v in pairs(self.mTalentLst) do
        if (v) then
            v.event.onClick:RemoveAllListeners()
            v.event = nil
            v.item:poolRecover()
            v = {}
        end
    end
    self.mTalentLst = {}
    self.isTalent = false
    self:onCloseChangeSkillHandler()

    -- UIEffectMgr:removeEffect("fx_ui_hero_bg", self.mEffParent.transform)

end

function initViewText(self)
    self.mTxtImgActSkill.text = _TT(1226)--"主动技能"
    self.mTxtImgBroastSkill.text = _TT(3022)--"源能爆发"
    self:setBtnLabel(self.mBtnLvUp, 1106, "升级")
    self:setBtnLabel(self.mBtnMax, 1081, "已达满级")
    self:setBtnLabel(self.mBtnPromote, 1057, "前往突破")
end

function addAllUIEvent(self)
    self:addUIEvent(self:getChildGO("mBtnFuncTips"), self.onClickFuncTipsHandler)
    -- self:addUIEvent(self.mBtnChangeSkill, self.onOpenChangeSkillHandler)
    self:addUIEvent(self.mBtnDetail, self.onClickTips)
    self:addUIEvent(self.mBtnLvUp, self.onClickLvlUp)
    self:addUIEvent(self.mBtnBack, self.onCloseSkillInfoHandler)
    self:addUIEvent(self.mBtnPromote, self.onClickPromoteHandler)
    self:addUIEvent(self.mBtnMax, self.onClickMaxHandler)
end

-- 是否可以关闭，由父面板触发
function __isCanSubViewClose__(self)
    return true
end

-- 主动技能等级更新
function onUpdateActiveSkillLvlHandler(self, args)
    if (args.heroId == self.mHeroId and self.mSkillItemDic[args.skillId] ~= nil) then
        self:setData(self.mHeroId)
        self:onUpdateHeroDetailDataHandler(args)
    end
end

-- 更新英雄增加出战技能
function onUpdateHeroAddFightSkillHandler(self, args)
    local heroId = args.heroId
    if (self.mHeroId == heroId) then
        self:setData(self.mHeroId)
        -- 顺便更新下子窗口
        self:updateActiveSkillView()
    end
end

-- 更新英雄删除出战技能
function onUpdateHeroDelFightSkillHandler(self, args)
    local heroId = args.heroId
    if (self.mHeroId == heroId) then
        self:setData(self.mHeroId)
    end
end

---------------------------------------------------------------------------设置数据更新逻辑 (start)----------------------------------------------------------------------------------
-- 设置数据
function setData(self, cusHeroId, heroTid)
    self.mHeroId = cusHeroId
    self.mHeroTid = heroTid

    if self.mHeroId then
        self.heroVo = hero.HeroManager:getHeroVo(self.mHeroId)
        if (self.heroVo:checkIsPreData()) then
            return
        else
            self:updateView()
        end
    else
        -- self.mBtnChangeSkill:SetActive(false)
        self.heroVo = hero.HeroManager:getHeroConfigVo(self.mHeroTid)
        self:updateView()
    end
    self.mAni:SetTrigger("show")
end

-- 更新界面
function updateView(self)
    self:updateActiveSkillView()
    self:updateSkillMoneyState()
end

-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 更新主动技能界面
function updateActiveSkillView(self)
    -- UIEffectMgr:addEffect("fx_ui_hero_bg", self.mEffParent.transform)
    local function getSkillVo(needSkillType, index)
        local _index = 0
        for i = 1, #self.heroVo.baseSkillIdList do
            local skillId = self.heroVo.baseSkillIdList[i]
            if (not self.heroVo.activeSkillDic[skillId]) then
                local skillVo = fight.SkillManager:getSkillRo(skillId)
                local skillType = skillVo:getType()
                if (skillType == needSkillType) then
                    _index = _index + 1
                    if (_index == index) then
                        return skillVo
                    end
                end
            end
        end
        return nil
    end

    self:recoverActiveSkillItem()
    -- local curNormalIndex = 0
    -- local curAoyiIndex = 0
    if self.mHeroId then
        local skillCount = #self.heroVo.activeSkillList
        for i = 1, skillCount do
            local skillVo = fight.SkillManager:getSkillRo(self.heroVo.activeSkillList[i])
            if (skillVo) then
                local item = hero.HeroSkillItem2:create(self:getChildTrans("mSkillNode" .. (i)), "SkillItem")
                if (i > 1) then
                    item:setData(self.heroVo, skillVo, self.heroVo.fightSkillDic[i - 1].isUnlock, 1, true, false)
                else
                    item:setData(self.heroVo, skillVo, 1, 1, true, false)
                end
                item:setSkillDefineDes(i)
                self.mSkillItemDic[skillVo:getRefID()] = {
                    skillPos = i,
                    item = item,
                eventTrigger = item:getTrans():GetComponent(ty.LongPressOrClickEventTrigger)}
                self:addTriggerEvent(skillVo:getRefID())

            end
        end
        self:updateTalentSkill()
    else
        for i = 1, #self.heroVo.baseSkillIdList do
            local skillVo = fight.SkillManager:getSkillRo(self.heroVo.baseSkillIdList[i])
            if (skillVo) then
                local item = hero.HeroSkillItem2:create(self:getChildTrans("mSkillNode" .. (i)), "SkillItem")
                item:setData(self.heroVo, skillVo, 0, 8, true)
                item:setScale(0.7)
                item:setSkillDefineDes(i)
                self.mSkillItemDic[skillVo:getRefID()] = {
                    item = item,
                eventTrigger = item:getTrans():GetComponent(ty.LongPressOrClickEventTrigger)}
                self:addTriggerEvent(skillVo:getRefID())
            end
        end
        self:updateTalentSkill()
    end
end

-- 更新天赋技能
function updateTalentSkill(self)
    for k, v in pairs(self.mTalentLst) do
        if (v) then
            v.event.onClick:RemoveAllListeners()
            v.event = nil
            v.item:poolRecover()
            v = {}
        end
    end
    self.mTalentLst = {}
    for k, v in pairs(self.heroVo.inBornSkill) do
        local skillId = v
        local skillVo = fight.SkillManager:getSkillRo(skillId)
        -- if skillVo.m_subType == 3 then
        local isUnlock = 1
        if (not table.indexof(self.heroVo.activePassSkillList, skillId)) then
            isUnlock = 0
        end
        local mTalentGrid = hero.HeroSkillItem2:create(self:getChildTrans("mTalentSkillNode"), "TalentSkillItem")
        mTalentGrid:setData(self.heroVo, skillVo, isUnlock, 1)
        mTalentGrid:getChildGO("mImgName"):SetActive(true)
        mTalentGrid:getChildGO("mImgSkillLvl"):SetActive(false)
        mTalentGrid:getChildGO("mGroupRight"):SetActive(false)
        mTalentGrid:setIsShowDownName(true)
        mTalentGrid:getChildGO("mImgSkillDefine"):SetActive(false)
        mTalentGrid:getChildGO("mImgSkillBg"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getCommon5Path("common_0055.png"), false)
        local mTalentGridEvent = mTalentGrid:getTrans():GetComponent(ty.LongPressOrClickEventTrigger)
        local function _onClick()
            self:onClickItemHandler(skillVo:getRefID(), isUnlock, true)
        end
        mTalentGridEvent.onClick:AddListener(_onClick)

        table.insert(self.mTalentLst, {item = mTalentGrid, event = mTalentGridEvent})
    end
end

function addTriggerEvent(self, skillId, pos)
    local function _onClick()
        local isUnlock = 1
        if self.mHeroId then
            local skillPos = self.mSkillItemDic[skillId].skillPos
            isUnlock = self.heroVo.fightSkillDic[skillPos] == nil and 1 or self.heroVo.fightSkillDic[skillPos].isUnlock
        end

        self:onClickItemHandler(skillId, isUnlock)
    end
    local eventTrigger = self.mSkillItemDic[skillId].eventTrigger
    eventTrigger.onClick:AddListener(_onClick)
end

function removeTriggerEvent(self, skillId)
    local eventTrigger = self.mSkillItemDic[skillId].eventTrigger
    eventTrigger.onClick:RemoveAllListeners()
end

function onClickItemHandler(self, skillId, isUnlock)
    self:onUpdateSkillInfo(skillId, isUnlock)
end

function onClickTips(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_HERO_STARSKILL_VIEW, {heroTid = self.mHeroTid, curHeroId = self.mHeroId})
end

function onClickPromoteHandler(self)
    if self.goToPromote then
        GameDispatcher:dispatchEvent(EventName.OPEN_HERO_DEVELOP_PANEL, {heroId = self.mHeroId, tabType = hero.DevelopTabType.LVL_UP, subData = {}})
    else
        if self.gotoResonance then
            GameDispatcher:dispatchEvent(EventName.OPEN_HERO_DEVELOP_PANEL, {heroId = self.mHeroId, tabType = hero.DevelopTabType.RESONANCE})
        else
            GameDispatcher:dispatchEvent(EventName.OPEN_HERO_DEVELOP_PANEL, {heroId = self.mHeroId, tabType = hero.DevelopTabType.STAR_UP})
        end
    end
end

function onClickMaxHandler(self)
    gs.Message.Show(_TT(1081))
end

function onClickLvlUp(self)
    local heroVo = self.mCurHeroVo
    local skillVo = self.mCurSkillVo
    local skillLvl = heroVo:getActiveSkill(skillVo:getRefID())
    local skillUpVo = hero.HeroSkillUpManager:getSkillUpConfigVo(heroVo.tid, skillVo:getRefID(), skillLvl)
    local costMoneyTid = skillUpVo.cost[1]
    local costMoneyCount = skillUpVo.cost[2]
    local costItem = skillUpVo.costItem
    local canUp = true
    local mon = MoneyUtil.getMoneyCountByTid(costMoneyTid)
    if mon < costMoneyCount then
        canUp = false
    end
    for i = 1, #costItem do
        local needNum = costItem[i][2]
        local hasNum = bag.BagManager:getPropsCountByTid(costItem[i][1])
        if hasNum < needNum then
            canUp = false
        end
    end

    if canUp then
        if skillLvl >= 7 then
            UIFactory:alertMessge(_TT(27035), true, function()
                GameDispatcher:dispatchEvent(EventName.REQ_HERO_SKILL_UP, {heroId = heroVo.id, skillId = skillVo:getRefID()})
            end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil)
        else
            GameDispatcher:dispatchEvent(EventName.REQ_HERO_SKILL_UP, {heroId = heroVo.id, skillId = skillVo:getRefID()})
        end
    else
        gs.Message.Show(_TT(1231))
    end
end

function onUpdateHeroDetailDataHandler(self, args)
    if (args.skillId == self.mCurSkillVo:getRefID()) then
        local skillPos = self.mSkillItemDic[args.skillId].skillPos
        local isUnlock = self.heroVo.fightSkillDic[skillPos].isUnlock
        self:onUpdateSkillInfo(args.skillId, isUnlock)
    end
end

function onUpdateSkillInfo(self, skillId, isUnlock)
    -- UIEffectMgr:removeEffect("fx_ui_hero_bg", self.mEffParent.transform)
    if self.mGroupInfo.activeSelf == false then
        self.mGroupInfo:SetActive(true)
        self.mGroupRight:SetActive(false)
    end
    self.mBtnMax:SetActive(false)
    if self.mHeroId then
        self.mCurHeroVo = hero.HeroManager:getHeroVo(self.mHeroId)
    else
        self.mCurHeroVo = hero.HeroManager:getHeroConfigVo(self.mHeroTid)
    end

    self.mCurSkillVo = fight.SkillManager:getSkillRo(skillId)
    if self.mCurSkillVo:getType() == fight.FightDef.SKILL_TYPE_PASSIVE_SKILL then
        self.isTalent = true
    end

    local isActiveRes = nil --是否星源提升了技能
    local resCanActive = false --是否可以通过星源提升
    local resSkillConfig = hero.HeroManager:getHeroResonanceConfigVo(self.mCurHeroVo.tid)
    for k, resConfig in pairs(resSkillConfig) do
        if resConfig.type == 2 then
            if resConfig.skill_level[1] == skillId then
                resCanActive = true
                if isActiveRes == nil or isActiveRes == true then
                    isActiveRes = self.mCurHeroVo:getActiveResonancePos(resConfig.pos)
                end
            end
        end
    end

    self.gotoResonance = false
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HERO_RESONANCE) then
        if resCanActive and not isActiveRes then
            self.gotoResonance = true
        end
    end

    self.misUnLock = isUnlock
    local skillId = self.mCurSkillVo:getRefID()

    local extraLv = self.mCurHeroVo:getExtraLv(skillId) --附加等级
    local talentMaxLv = 0 --天赋最大等级
    if self.isTalent then
        if self.mCurHeroVo.color ~= hero.HeroColorType.R_CARD then
            talentMaxLv = sysParam.SysParamManager:getValue(SysParamType.TALENTCEILING)
        else
            talentMaxLv = sysParam.SysParamManager:getValue(SysParamType.RCARDTALENTCEILING)
        end
    end

    local realMax = self.isTalent and talentMaxLv or sysParam.SysParamManager:getValue(SysParamType.SKILLREALYCEILING) -- 所有技能的可养成最大等级
    local maxLvl = realMax --技能最大等级

    if self.mCurSkillVo:getType() == fight.FightDef.SKILL_TYPE_NORMAL_ATTACK then --普工
        if self.mCurHeroVo.color == hero.HeroColorType.R_CARD then
            maxLvl = realMax + sysParam.SysParamManager:getValue(SysParamType.NORMALSKILLREALYCEILING)
        end
    elseif self.mCurSkillVo:getType() ~= fight.FightDef.SKILL_TYPE_PASSIVE_SKILL then --除天赋普工外的技能
        maxLvl = sysParam.SysParamManager:getValue(SysParamType.SKILLCEILING)
    end

    local TalentLv = self.mCurHeroVo:getActivePassiveSkill(skillId) --天赋等级
    local activeSkillLv = self.mCurHeroVo:getActiveSkill(skillId) --技能等级
    local upLv = self.isTalent and TalentLv or activeSkillLv --技能养成等级
    local tureSkillLv = upLv + extraLv --当前的实际等级

    self.mSkillUpVo = hero.HeroSkillUpManager:getSkillUpConfigVo(self.mCurHeroVo.tid, skillId, upLv)
    local isLvEnough = self.mSkillUpVo ~= nil and self.mCurHeroVo.militaryRank >= self.mSkillUpVo.needHeroRank--星级
    local isLock = self.mSkillUpVo ~= nil and self.mCurHeroVo.evolutionLvl < self.mSkillUpVo.needStar--等级

    if self.mItem ~= nil then
        self.mItem:poolRecover()
        self.mItem = nil
    end
    self.mItem = SkillGrid:create(self.mSkillNode, {skillId = skillId, heroVo = self.mCurHeroVo}, 1, false)
    self.mItem:setDetailVisible(false)
    self.mItem:setIsUnLockVisible(isUnlock ~= 1)
    local cdRound = self.mCurSkillVo:getRoundCd()
    if (cdRound == 0) then
        self.mTxtCoolingDesc.text = _TT(27031)
    else
        self.mTxtCoolingDesc.text = _TT(1227, self.mCurSkillVo:getRoundCd())
    end
    --up
    self.mTxtSkillName.text = self.mCurSkillVo:getName()
    self.mImgRange.gameObject:SetActive(self.mCurSkillVo:getScope() > 0)
    self.mImgRange:SetImg(UrlManager:getHeroSkillRangeIconUrl(self.mCurSkillVo:getScope()), true)

    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self:getChildTrans("mTxtSkillDesc"))
    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self:getChildTrans("mTxtNextDesc"))

    -- gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self:getChildTrans("mSkillScrollView"))
    -- gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self:getChildTrans("mNextScrollView"))

    LoopManager:addFrame(1, 2, self, function()
        self:updateScrollViewState(self.mSkillScrollView, self:getChildTrans("mTxtSkillDesc"))
        self:updateScrollViewState(self.mNextScrollView, self:getChildTrans("mTxtNextDesc"))
    end)
    self.mTxtNextDesc.color = gs.ColorUtil.GetColor("C6D4E1ff")
    self.mTxtNextLv.color = gs.ColorUtil.GetColor("C6D4E1ff")
    self.mTxtLv.color = isUnlock and gs.ColorUtil.GetColor("FFFFFffff") or gs.ColorUtil.GetColor("C6D4E1ff")
    self.mTxtSkillDesc.color = isUnlock and gs.ColorUtil.GetColor("FFFFFffff") or gs.ColorUtil.GetColor("C6D4E1ff")
    if self.mSkillItem then
        self.mSkillItem:poolRecover()
        self.mSkillItem = nil
    end
    self.mSkillItem = hero.HeroSkillItem2:create(self:getChildTrans("mSkillTrans"), "SkillItemTrans")
    self.mSkillItem:setData(self.heroVo, self.mCurSkillVo, isUnlock, 1, true, true, false)
    self.mSkillItem:setHideSkillName(true)
    self.mSkillItem:setScale(0.9)

    self.mTxtLv.text = _TT(3072, tureSkillLv)

    local skillUpVo = hero.HeroSkillUpManager:getSkillUpConfigVo(self.mCurHeroVo.tid, skillId, tureSkillLv)
    self.mTxtSkillDesc.text = skillUpVo:getDesc()

    local isMaxLvl = tureSkillLv >= maxLvl
    if isMaxLvl then
        self.mTxtNextLv.gameObject:SetActive(false)
        self.mTxtMaterial.gameObject:SetActive(false)
        self.mBtnMax:SetActive(true)
        self.mImgMaxLvBg:SetActive(false)
        self.mBtnPromote:SetActive(false)
        self.mBtnLvUp:SetActive(false)

        gs.TransQuick:SizeDelta02(self.mImgLine.transform, 171)
        gs.TransQuick:SizeDelta02(self.mSkillScrollView, self.mSkillMaxHeight)
        return
    end

    gs.TransQuick:SizeDelta02(self.mSkillScrollView, 133.97)

    self.mTxtMaterial.text = "消耗道具"
    self.mImgMaxLvBg:SetActive(false)
    self:recoverPropsListItem()
    self:setBtnLabel(self.mBtnPromote, 1057, "前往突破")
    gs.TransQuick:SizeDelta02(self.mImgLine.transform, 473.5)
    self.mTxtNextLv.gameObject:SetActive(true)
    self.mTxtMaterial.gameObject:SetActive(true)

    self.mTxtNextLv.text = _TT(3072, tureSkillLv + 1)
    local nextSkillUpVo = hero.HeroSkillUpManager:getSkillUpConfigVo(self.mCurHeroVo.tid, skillId, tureSkillLv + 1)
    self.mTxtNextDesc.text = nextSkillUpVo:getDesc()

    if (self.isTalent) then
        self.mBtnPromote:SetActive(true)
        self.mBtnLvUp:SetActive((false))
        if isUnlock > 0 then
            if self.gotoResonance then
                self.mTxtMaterial.text = _TT(110019)
                self:setBtnLabel(self.mBtnPromote, 110018, "前往星源")
            else
                self.mTxtMaterial.text = _TT(1372)
                self:setBtnLabel(self.mBtnPromote, 1374, "前往升格")
            end
            self.goToPromote = false
        else
            self.goToPromote = true
            self.mTxtMaterial.text = _TT(1375)
        end
    else
        if upLv >= realMax then
            if self.gotoResonance then
                self.mTxtMaterial.text = _TT(110019)
                self:setBtnLabel(self.mBtnPromote, 110018, "前往星源")
            else
                self.mTxtMaterial.text = _TT(1372)
                self:setBtnLabel(self.mBtnPromote, 1374, "前往升格")
            end

            self.mBtnPromote:SetActive(true)
            self.mBtnLvUp:SetActive((false))
            self.goToPromote = false
        else
            self.goToPromote = true
            self.mBtnPromote:SetActive(false)
            self.mImgMaxLvBg:SetActive(false)
            self.mBtnLvUp:SetActive(true)
            self.mImgMoney.gameObject:SetActive(true)
            --道具格子
            self:updateSkillItemState()
            if (not isLock and isLvEnough) then
                --升级按钮
                self.mImgMoney:SetImg(UrlManager:getPropsIconUrl(self.mSkillUpVo.cost[1]), false)
                self.mTxtMoney.text = self.mSkillUpVo.cost[2]
                self:updateSkillMoneyState()
            else
                if (isLock) then
                    local integerStar, remainderStar = math.modf(self.mSkillUpVo.needStar / 2)
                    local curStar = ""
                    for i = 1, integerStar do
                        curStar = curStar .. "★"
                    end
                    if remainderStar > 0 then
                        curStar = curStar .. "☆"
                    end
                    self.mTxtMaxLv.text = _TT(1058, curStar)
                elseif (not isLvEnough) then
                    self.mTxtMaxLv.text = _TT(27032, self:getRomanConversion(self.mSkillUpVo.needHeroRank))
                    self.mBtnLvUp:SetActive(false)
                    self.mBtnPromote:SetActive(true)
                end
                self.mImgMaxLvBg:SetActive(true)
                self.mImgMoney.gameObject:SetActive(false)
            end
        end
    end
end

function updateSkillMoneyState(self)
    if self.mGroupInfo.activeSelf == true then
        if (MoneyUtil.getMoneyCountByTid(self.mSkillUpVo.cost[1]) < self.mSkillUpVo.cost[2]) then
            self.mTxtMoney.color = gs.ColorUtil.GetColor("DE1E1Eff")
        else
            self.mTxtMoney.color = gs.ColorUtil.GetColor("ffffffff")
        end
        self.mSkillUpVo = hero.HeroSkillUpManager:getSkillUpConfigVo(self.mCurHeroVo.tid, self.mCurSkillVo:getRefID(), self.mCurHeroVo:getActiveSkill(self.mCurSkillVo:getRefID()))
        if self.mSkillItem then
            self.mSkillItem:setData(self.heroVo, self.mCurSkillVo, self.misUnLock, 1, true, true, false)
            self.mSkillItem:setScale(0.9)
        end
    end
end

function updateSkillItemState(self)
    if self.mGroupInfo.activeSelf == true then
        self:recoverPropsListItem()
        local trueSkillLv = self.mCurHeroVo:getActiveSkill(self.mCurSkillVo:getRefID())
        self.mSkillUpVo = hero.HeroSkillUpManager:getSkillUpConfigVo(self.mCurHeroVo.tid, self.mCurSkillVo:getRefID(), self.mCurHeroVo:getActiveSkill(self.mCurSkillVo:getRefID()))
        for i = 1, #self.mSkillUpVo.costItem do
            local item = PropsGrid:createByData({tid = self.mSkillUpVo.costItem[i][1], parent = self:getChildTrans("mGroupProps"), scale = 1, showUseInTip = false})
            item:setCount(nil, self.mSkillUpVo.costItem[i][2])
            table.insert(self.propItemList, item)
        end
        if self.mSkillItem then
            self.mSkillItem:setData(self.heroVo, self.mCurSkillVo, self.misUnLock, 1, true, true, false)
            self.mSkillItem:setScale(0.9)
        end
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

function updateScrollViewState(self, scroll, textTrans)
    local isShow = scroll.rect.height < textTrans.rect.height
    scroll.gameObject:GetComponent(ty.ScrollRect).enabled = isShow
end

--------------------------------------------------------------------------------------此处复制出来改的拖拽逻辑 start----------------------------------------------------------------------------------
-- 打开技能修改
function onOpenChangeSkillHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_HERO_SKILL_EDIT_PANEL, {heroId = self.mHeroId})
end

-- 关闭技能修改
function onCloseChangeSkillHandler(self)
    self.mIsAllowDrag = false
end

-- 关闭SkillInfo
function onCloseSkillInfoHandler(self)
    self.mGroupInfo:SetActive(false)
    self.mGroupRight:SetActive(true)
    self.mAni:SetTrigger("show")
    self.isTalent = false
    gs.TransQuick:LPosY(self:getChildTrans("mTxtSkillTrans"), 0)
    gs.TransQuick:LPosY(self:getChildTrans("mTxtNextTrans"), 0)
    self:updateActiveSkillView()
end
--打开规则说明界面
function onClickFuncTipsHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_FUNCTIPS_VIEW, {id = LinkCode.HeroSkill})
end
-- 罗马数字转换
function getRomanConversion(self, Value)
    local list = {"Ⅰ", "Ⅱ", "Ⅲ", "Ⅳ", "Ⅴ", "Ⅵ", "Ⅶ", "Ⅷ", "Ⅸ", "Ⅹ"}
    return list[Value]
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
