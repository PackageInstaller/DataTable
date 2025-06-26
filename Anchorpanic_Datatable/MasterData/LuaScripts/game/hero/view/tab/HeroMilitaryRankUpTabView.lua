module("hero.HeroMilitaryRankUpTabView", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("hero/tab/HeroMilitaryRankUpTab.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
    super.initData(self)
    self.mCurHeroId = nil
    -- self.mIsReadyMilitaryUp = false
    self.mIsLongPress = false
    self.mIsQucikLvlUp = false
    self.mSkillGrid1 = nil
    self.mSkillGrid2 = nil
end

function configUI(self)
    super.configUI(self)

    self.mGroupAct = self:getChildGO("mGroupAct")
    self.mBtnAward = self:getChildGO("mBtnAward")
    self.mBtnAni = self.mBtnAward:GetComponent(ty.Animator)
    -- self.mBtnSkillDetail = self:getChildGO("mBtnSkillDetail")
    self.mTxtAttr = self:getChildGO("mTxtAttr"):GetComponent(ty.Text)
    self.mTxtNowMilitary = self:getChildGO("mTxtNowMilitary"):GetComponent(ty.Text)
    self.mTxtNowMilitaryDesc = self:getChildGO("mTxtNowMilitaryDesc"):GetComponent(ty.Text)
    self.mTxtTargetMilitaryName = self:getChildGO("mTxtTargetMilitaryName"):GetComponent(ty.Text)
    self.mTxtTargetMilitaryDesc = self:getChildGO("mTxtTargetMilitaryDesc"):GetComponent(ty.Text)

    -- 属性详情按钮
    -- self.mBtnDetail = self:getChildGO("mBtnDetail")
    -- 属性容器
    self.mGroupSpecialAttr = self:getChildGO("mGroupSpecialAttr")
    self.mGroupAddAttr = self:getChildTrans("mGroupAddAttr")

    -- 军阶技能
    self.mTxtMiliSkillName = self:getChildGO("mTxtMiliSkillName"):GetComponent(ty.Text)
    self.mTxtUnlock = self:getChildGO("mTxtUnlock"):GetComponent(ty.Text)
    self.mTxtMiliSkillName_2 = self:getChildGO("mTxtMiliSkillName_2"):GetComponent(ty.Text)
    self.mTxtUnlock_2 = self:getChildGO("mTxtUnlock_2"):GetComponent(ty.Text)

    self.mBtnRankUp = self:getChildGO("mBtnRankUp")
    self.mImgCostIcon = self:getChildGO("mImgCostIcon"):GetComponent(ty.AutoRefImage)
    self.mTxtCostNum = self:getChildGO("mTxtCostNum"):GetComponent(ty.Text)
    self.mBtnRankUpRect = self.mBtnRankUp:GetComponent(ty.RectTransform)
    self.mGridNode = self:getChildGO("mGridNode")
    self.mGroupSkill_1 = self:getChildGO("mGroupSkill_1")
    self.mGroupSkill_2 = self:getChildGO("mGroupSkill_2")
    self.mTextEmpty = self:getChildGO("mTextEmpty")

    self:setGuideTrans("funcTips_militaryRank_1", self:getChildTrans("mMilitaryRank1"))
    self:setGuideTrans("funcTips_militaryRank_2", self:getChildTrans("mMilitaryRank2"))
end

function active(self, args)
    super.active(self, args)
    bag.BagManager:addEventListener(bag.BagManager.BAG_UPDATE, self.onBagUpdateHandler, self)
    role.RoleManager:getRoleVo():addEventListener(role.RoleVo.CHANGE_PLAYER_MONEY, self.onBagUpdateHandler, self)
    GameDispatcher:addEventListener(EventName.UPDATE_HERO_PREVIEW_ATTR, self.onMilitaryRankUpdateHandler, self)
    GameDispatcher:addEventListener(EventName.UPDATE_MILITARY_RANK_PANEL, self.onMilitaryRankUpdateHandler, self)
    GameDispatcher:addEventListener(EventName.HERO_DATA_UPDATE, self.onUpdateHeroDetailDataHandler, self)
    hero.HeroManager:addEventListener(hero.HeroManager.PANEL_SHOW_HERO_CHANGE, self.__onPlayUpdateAni, self)
    hero.HeroLvlTargetManager:addEventListener(hero.HeroLvlTargetManager.UPDATE_LVL_TARGET_lIST, self.onHeroLvlTargetUpdateHandler, self)
    hero.HeroFlagManager:addEventListener(hero.HeroFlagManager.FLAG_UPDATE, self.onBubbleUpdateHandler, self)
    local heroId = args.heroId
    self:setData(heroId)
end

function deActive(self)
    super.deActive(self)
    bag.BagManager:removeEventListener(bag.BagManager.BAG_UPDATE, self.onBagUpdateHandler, self)
    role.RoleManager:getRoleVo():removeEventListener(role.RoleVo.CHANGE_PLAYER_MONEY, self.onBagUpdateHandler, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_HERO_PREVIEW_ATTR, self.onMilitaryRankUpdateHandler, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_MILITARY_RANK_PANEL, self.onMilitaryRankUpdateHandler, self)
    GameDispatcher:removeEventListener(EventName.HERO_DATA_UPDATE, self.onUpdateHeroDetailDataHandler, self)
    hero.HeroManager:removeEventListener(hero.HeroManager.PANEL_SHOW_HERO_CHANGE, self.__onPlayUpdateAni, self)
    hero.HeroLvlTargetManager:removeEventListener(hero.HeroLvlTargetManager.UPDATE_LVL_TARGET_lIST, self.onHeroLvlTargetUpdateHandler, self)
    hero.HeroFlagManager:removeEventListener(hero.HeroFlagManager.FLAG_UPDATE, self.onBubbleUpdateHandler, self)

    RedPointManager:remove(self.mBtnAward.transform)
    RedPointManager:remove(self.mBtnRankUpRect)
    if (self.mSkillGrid) then
        self.mSkillGrid:poolRecover()
        self.mSkillGrid = nil
    end
    self:recyAllItem()

    hero.HeroController:stopCurPlayCVData()
end

function initViewText(self)
    self.mTxtAttr.text = _TT(1062) --"进化效果"
    self.mTxtUnlock.text = _TT(40025) --"解锁"
    self:setBtnLabel(self.mBtnRankUp, 1061, "晋升")
    -- self:setBtnLabel(self.mBtnDetail, 25027, "详情")
    -- self:setBtnLabel(self.mBtnSkillDetail, 25027, "详情")
    self:setBtnLabel(self.mBtnAward, 48131, "训练目标")
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnAward, self.onClickAwardHandler)
    self:addUIEvent(self.mBtnRankUp, self.onClickRankUpHandler)
    -- self:addUIEvent(self.mBtnDetail, self.onClickBtnDetailHandler)
    -- self:addUIEvent(self.mBtnSkillDetail, self.onClickSkillTipsHandler)
    self:addUIEvent(self:getChildGO("mBtnFuncTips"), self.onClickFuncTipsHandler)
end

-- -- 打开属性详细信息
-- function onClickBtnDetailHandler(self)
--     local curHeroVo = hero.HeroManager:getHeroVo(self.mCurHeroId)
--     GameDispatcher:dispatchEvent(EventName.OPEN_HERO_ATTR_LIST_PANEL, { heroVo = curHeroVo })
-- end

function onClickRankUpHandler(self)
    local canRankUp = true
    local curHeroVo = hero.HeroManager:getHeroVo(self.mCurHeroId)
    local curMilitaryRankVo = hero.HeroMilitaryRankManager:getMilitaryRankConfigVo(curHeroVo.tid, curHeroVo.militaryRank)
    local list = curMilitaryRankVo.costList
    for i = 1, #list do
        local ownNum = bag.BagManager:getPropsCountByTid(list[i][1])
        if (ownNum < list[i][2]) then
            gs.Message.Show(_TT(60518))
            canRankUp = false
            break
        end
    end
    local ownMoney = MoneyUtil.getMoneyCountByTid(curMilitaryRankVo.cost[1])

    local res,tips = MoneyUtil.judgeNeedMoneyCountByTid(curMilitaryRankVo.cost[1],curMilitaryRankVo.cost[2],false,false)
    -- if (ownMoney < curMilitaryRankVo.cost[2]) then
    --     gs.Message.Show(_TT(60518))
    --     canRankUp = false
    -- end

    if res == false then
        gs.Message.Show(tips)
        canRankUp = false
    end
    if canRankUp then
        GameDispatcher:dispatchEvent(EventName.REQ_HERO_MILITARY_RANK_UP, { heroId = self.mCurHeroId, costHeroIdList = hero.HeroMilitaryRankManager.materialHeroIdList })
        self:onClickRankUpCancelHandler()
    end
end

-- 打开战员奖励
function onClickAwardHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_HERO_LVL_TARGET_PANEL, { heroId = self.mCurHeroId })
end

-- 英雄等级更新
function onLvlUpUpdateHandler(self, args)
    local heroId = args.heroId
    if (self.mCurHeroId == heroId) then
        self:updateView()
    end
end

-- 英雄军衔更新
function onMilitaryRankUpdateHandler(self, args)
    local heroId = args.heroId
    if (self.mCurHeroId == heroId) then
        self:updateView()
    end
end

function onBagUpdateHandler(self, args)
    self:updateView()
end

function onUpdateHeroDetailDataHandler(self, args)
    local heroId = args.heroId
    if (self.mCurHeroId == heroId) then
        self:updateView()
    end
end

function onHeroLvlTargetUpdateHandler(self, args)
    local heroVo = hero.HeroManager:getHeroVo(self.mCurHeroId)
    if (not args.heroTid or args.heroTid == heroVo.tid) then
        self:updateLvlTargetBubbleView()
    end
end

function onBubbleUpdateHandler(self, args)
    local heroId = args.heroId
    if (heroId == self.mCurHeroId) then
        if (args.flagType == hero.HeroFlagManager.FLAG_CAN_MILITARY_RANK_UP) then
            self:updateMilitaryBubbleView(args.flagType, args.isFlag)
        end
    end
end

--打开规则说明界面
function onClickFuncTipsHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_FUNCTIPS_VIEW, { id = LinkCode.HeroMilitaryRankUp })
end

-- --打开技能小弹窗
-- function onClickSkillTipsHandler(self)
--     if (self.mCurHeroId and self.skillId) then
--         local heroVo = hero.HeroManager:getHeroVo(self.mCurHeroId)  --防止弱网状态下数据不存在
--         TipsFactory:skillTips(nil, self.skillId, heroVo, false)
--     end
-- end

function updateMilitaryBubbleView(self, flagType, isFlag)
    if (not flagType and not isFlag) then
        local heroVo = hero.HeroManager:getHeroVo(self.mCurHeroId)
        isFlag = isFlag and isFlag or hero.HeroFlagManager:isHeroCanMilitaryUp(heroVo)
    end
    if (isFlag) then
        RedPointManager:add(self.mBtnRankUpRect, nil, 129, 19)
    else
        RedPointManager:remove(self.mBtnRankUpRect)
    end
end

function setData(self, cusHeroId)
    self.mCurHeroId = cusHeroId
    local heroVo = hero.HeroManager:getHeroVo(cusHeroId)
    if (heroVo:checkIsPreData()) then
        return
    else
        self:updateView()
        self:updateMilitaryBubbleView()
    end
end

function recyAllItem(self)
    self:recoverPropsGrid()
    if (self.mItemList) then
        for i = 1, #self.mItemList do
            local item = self.mItemList[i]
            item:poolRecover()
        end
    end
    self.mItemList = {}
end

-- 回收材料道具格子
function recoverPropsGrid(self)
    if (self.mGridList) then
        for i = 1, #self.mGridList do
            if (self.mGridList[i]) then
                local item = self.mGridList[i]
                if (item.m_uiGo) then
                    local rect = item.m_uiGo:GetComponent(ty.RectTransform)
                    gs.TransQuick:Anchor(rect, 0.5, 0.5, 0.5, 0.5)
                    gs.TransQuick:Pivot(rect, 0.5, 0.5)
                    gs.TransQuick:UIPos(rect, 0, 0)
                end
                item:poolRecover()
            end
        end
    end
    self.mGridList = {}
end

function updateView(self)
    local curHeroVo = hero.HeroManager:getHeroVo(self.mCurHeroId)
    if curHeroVo:getMilitaryRankPreviewAttrDic() == nil then
        return
    end
    self:recyAllItem()
    local showAttrList = { AttConst.HP_MAX, AttConst.ATTACK, AttConst.DEFENSE, AttConst.SPEED }
    for i = 1, #showAttrList do
        local attrKey = showAttrList[i - 1]
        if curHeroVo.attrDic[attrKey] then
            local attrVo = { key = attrKey, value = curHeroVo.attrDic[attrKey] }
            local item = hero.HeroRankUpAttrItem:poolGet()
            item:setData(i, attrVo, curHeroVo:getMilitaryRankPreviewAttrDic()[attrKey], true)
            item:setParent(self.mGroupSpecialAttr.transform)
            table.insert(self.mItemList, item)
        end
    end

    self.mGroupAct:SetActive(true)
    self.mBtnRankUp:SetActive(false)
    self.mGridNode:SetActive(false)
    local curMilitaryRankVo = hero.HeroMilitaryRankManager:getMilitaryRankConfigVo(curHeroVo.tid, curHeroVo.militaryRank)
    local maxMilitaryRank = hero.HeroMilitaryRankManager:getMaxMilitaryRankLvl(curHeroVo.tid)
    if (curHeroVo.militaryRank >= maxMilitaryRank) then
        GameDispatcher:dispatchEvent(EventName.CHANGE_HERO_TAB, false)
    else
        self.mTxtNowMilitary.text = curMilitaryRankVo:getName()
        self.mTxtNowMilitaryDesc.text = _TT(1219, curHeroVo:getMaxMilitaryLvl()) --"等级上限" .. curHeroVo:getMaxMilitaryLvl() .. "级"

        local targetMilitaryVo = hero.HeroMilitaryRankManager:getMilitaryRankConfigVo(curHeroVo.tid, curHeroVo.militaryRank + 1)
        self.mTxtTargetMilitaryName.text = targetMilitaryVo:getName()
        self.mTxtTargetMilitaryDesc.text = _TT(1371, targetMilitaryVo.heroMaxLvl)--"等级上限" .. targetMilitaryVo.heroMaxLvl .. "级"

        if (curHeroVo.lvl < curHeroVo:getMaxMilitaryLvl()) then
            GameDispatcher:dispatchEvent(EventName.CHANGE_HERO_TAB, false)
        else

            GameDispatcher:dispatchEvent(EventName.CHANGE_HERO_TAB, true)
            self:onClickRankUpCancelHandler()
            self.mBtnRankUp:SetActive(true)
            self.mImgCostIcon:SetImg(UrlManager:getPropsIconUrl(curMilitaryRankVo.cost[1]), false)
            local ownNum = MoneyUtil.getMoneyCountByTid(curMilitaryRankVo.cost[1])
            self.mTxtCostNum.text = curMilitaryRankVo.cost[2]
            if curMilitaryRankVo.cost[2] > ownNum then
                self.mTxtCostNum.color = gs.ColorUtil.GetColor("DE1E1Eff")
            else
                self.mTxtCostNum.color = gs.ColorUtil.GetColor("FFFFFFFF")
            end
            self:updateMilitaryUnlockSkillView()
            self:updateMilitaryMaterialView()
        end
    end
    self:updateLvlTargetBubbleView()
    self:__updateGuide()
end

function __recoverMilitaryAddAttrList(self)
    if (self.mMilitaryAddAttrList) then
        for i = 1, #self.mMilitaryAddAttrList do
            self.mMilitaryAddAttrList[i]:poolRecover()
        end
    end
    self.mMilitaryAddAttrList = {}
end

-- 更新军阶激活技能
function updateMilitaryUnlockSkillView(self)
    self.mGroupSkill_1:SetActive(false)
    self.mGroupSkill_2:SetActive(false)
    self.mTextEmpty:SetActive(true)

    local curHeroVo = hero.HeroManager:getHeroVo(self.mCurHeroId)
    local nextMilitaryRankVo = hero.HeroMilitaryRankManager:getMilitaryRankConfigVo(curHeroVo.tid, curHeroVo.militaryRank + 1)
    if nextMilitaryRankVo and (nextMilitaryRankVo.unlockSkillId > 0 or not table.empty(nextMilitaryRankVo.warshipSkill)) then
        if nextMilitaryRankVo.unlockSkillId > 0 then
            self.mGroupSkill_1:SetActive(true)
            self.mTextEmpty:SetActive(false)

            local skillVo = fight.SkillManager:getSkillRo(nextMilitaryRankVo.unlockSkillId)
            if (skillVo) then
                self.mTxtMiliSkillName.text = skillVo:getName()
            end
        end

        if not table.empty(nextMilitaryRankVo.warshipSkill) then
            self.mGroupSkill_2:SetActive(true)
            self.mTextEmpty:SetActive(false)

            local skillId = nextMilitaryRankVo.warshipSkill[1]
            local buildBaseSkillVo = buildBase.BuildBaseHeroManager:getSkillConfigBySkillId(skillId)
            if (buildBaseSkillVo) then
                self.mTxtMiliSkillName_2.text = _TT(buildBaseSkillVo.name)
                if nextMilitaryRankVo.warshipSkill[2] then
                    self.mTxtUnlock_2.text = _TT(1369)
                else
                    self.mTxtUnlock_2.text = _TT(1368)
                end
            end
        end
    end
end

-- 更新晋升材料界面
function updateMilitaryMaterialView(self)
    self:recoverPropsGrid()
    self.mGridNode:SetActive(true)
    local curHeroVo = hero.HeroManager:getHeroVo(self.mCurHeroId)
    local curMilitaryRankVo = hero.HeroMilitaryRankManager:getMilitaryRankConfigVo(curHeroVo.tid, curHeroVo.militaryRank)
    local parent = self:getChildTrans("mGridNode")
    local list = curMilitaryRankVo.costList
    for i = 1, #list do
        local propsGrid = PropsGrid:createByData({ tid = list[i][1], parent = parent, scale = 0.6, showUseInTip = false })
        propsGrid:setCount(nil, list[i][2])
        table.insert(self.mGridList, propsGrid)
    end
end

function updateLvlTargetBubbleView(self)
    local heroVo = hero.HeroManager:getHeroVo(self.mCurHeroId)
    local targetFlag = hero.HeroFlagManager:isHeroCanRecLvlTarget(heroVo)
    local targetAllFlag = hero.HeroFlagManager:isHeroAllRecLvlTarget(heroVo)
    -- self.mBtnAward:SetActive(targetAllFlag == false)
    if (targetFlag) then
        RedPointManager:add(self.mBtnAward.transform, nil, 20, 23)
        self.mBtnAni:ResetTrigger("puv")
        self.mBtnAni:SetTrigger("show")
    else
        RedPointManager:remove(self.mBtnAward.transform)
        self.mBtnAni:SetTrigger("puv")
    end
end

function __updateGuide(self)
    local curHeroVo = hero.HeroManager:getHeroVo(self.mCurHeroId)
    if (curHeroVo.id == 1) then
        self:setGuideTrans("hero_lvlup_btn_lvlup_" .. curHeroVo.id, self.mBtnRankUpRect)
    end
    self:setGuideTrans("hero_lvlup_btn_lvlup", self.mBtnRankUpRect)
end

function onClickRankUpCancelHandler(self)
    -- 此处的升级按钮有概率会缩小，强制手动还原下大小
    gs.TransQuick:Scale(self.mBtnRankUpRect, 1, 1, 1)
end

function __checkNeedPassStage(self)
    local curHeroVo = hero.HeroManager:getHeroVo(self.mCurHeroId)
    local curMilitaryRankVo = hero.HeroMilitaryRankManager:getMilitaryRankConfigVo(curHeroVo.tid, curHeroVo.militaryRank)
    if battleMap.MainMapManager:isStagePass(curMilitaryRankVo.stageId) then
        return 0
    end
    return curMilitaryRankVo.stageId
end

function __onPlayUpdateAni(self)
    if not self.m_UIObjectAni then
        self.m_UIObjectAni = self.UIObject:GetComponent(ty.Animator)
    end
    if not gs.GoUtil.IsCompNull(self.m_UIObjectAni) then
        self.m_UIObjectAni:SetTrigger("show")
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]