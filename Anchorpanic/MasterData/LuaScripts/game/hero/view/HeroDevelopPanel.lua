module("hero.HeroDevelopPanel", Class.impl(TabView))

UIRes = UrlManager:getUIPrefabPath("hero/HeroDevelopPanel.prefab")
destroyTime = -1 -- 自动销毁时间-1默认
panelType = 1 -- 窗口类型 1 全屏 2 弹窗
isShowBlackBg = 0 --是否显示全屏纯黑防穿帮底图
isShowBlackBg = 0 --是否显示全屏纯黑防穿帮底图

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setBg("", false)
    self:setUICode(LinkCode.HeroCulture)
    self:setTxtTitle(_TT(52005))
    self:setGuideTrans("guide_BtnCloseAll", self.gBtnCloseAll.transform)
    self:setGuideTrans("guide_BtnClose_HeroDevelopPanel", self.gBtnClose.transform)

    for page, item in pairs(self.tabBar.btnMap) do
        self:setGuideTrans("guide_HeroDevelopPanel_tab" .. page, item:getChildTrans("mBtnNomal"))
    end
end

-- 更新页签列表
function updateTabBar(self)
    super.updateTabBar(self)
end

-- 初始化数据
function initData(self)
    super.initData(self)
    self.showTabType = 2

    self.mCurHeroId = nil
    self.mCurTabType = nil
    self.mNewImgDic = {}
    self.teamId = nil
end

function configUI(self)
    super.configUI(self)
    self.mModelPlayer = ModelScenePlayer.new()
    self.mBtnLast = self:getChildGO("mBtnLast")
    self.mBtnNext = self:getChildGO("mBtnNext")
    self.mClickerArea = self:getChildGO("mClickerArea")
    self.mModelClickEvent = self.mClickerArea:GetComponent(ty.LongPressOrClickEventTrigger)
    self.mBtnBackList = self:getChildGO("mBtnBackList")
    self.mTabBarTrans = self:getChildTrans("mTabBarTrans")
    self.mImgHeroIcon = self:getChildGO("mImgHeroIcon"):GetComponent(ty.AutoRefImage)
    self.mImgQualityBar = self:getChildGO("mImgQualityBar"):GetComponent(ty.Image)
    self.mBtnInfo = self:getChildGO("mBtnInfo")
    self.mInfoRed = self:getChildGO("mInfoRed")
    self.mBtnFashion = self:getChildGO("mBtnFashion")
    self.mFashionRed = self:getChildGO("mFashionRed")
    self.mFavorableRed = self:getChildGO("mFavorableRed")
    self.mBtnFavorable = self:getChildGO("mBtnFavorable")
    self.mBtnFavorableTxt = self:getChildGO("mTxtFavorableLv"):GetComponent(ty.Text)
    self.mBtnEquip = self:getChildGO("mBtnEquip")
    -- self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mBtnHandRing = self:getChildGO("mBtnHandRing")

    self.mTxtEquip = self:getChildGO("mTxtEquip"):GetComponent(ty.Text)
    self.mTxtHandRing = self:getChildGO("mTxtHandRing"):GetComponent(ty.Text)
    self.mBackToLvUp = self:getChildGO("mBackToLvUp")

    self.mBtnDna = self:getChildGO("mBtnDna")
    self.mGroupInfo = self:getChildGO("mGroupInfo")
    self.mImgDnaLock = self:getChildGO("mImgDnaLock")
    self.mImgDnaAdd = self:getChildGO("mImgDnaAdd")
    self.mAriDnaIcon = self:getChildGO("mAriDnaIcon"):GetComponent(ty.AutoRefImage)
    self.mAriDnaHead = self:getChildGO("mAriDnaHead"):GetComponent(ty.AutoRefImage)
    self.mTxtDnaName = self:getChildGO("mTxtDnaName"):GetComponent(ty.Text)

    self.mBtnBigHostel = self:getChildGO("mBtnBigHostel")

    self:setGuideTrans("funcTips_guide_HeroDevelop_Btn_HandRing", self.mBtnHandRing.transform)
    self:setGuideTrans("funcTips_guide_HeroDevelop_Btn_Equip", self.mBtnEquip.transform)
end

-- 关闭所有UI
function onCloseAllCall(self)
    self:playerClose()
    super.onCloseAllCall(self)
end

-- 玩家点击关闭
function onClickClose(self)
    if (self:__getIsCanCloseSubView(self.curPage)) then
        if (self.curPage ~= nil) then
            local classIns = self.m_classInsDic[self.curPage]
            if (classIns.onClickClose) then
                classIns:onClickClose()
            end
        end
        self:reset()
        self:playerClose()
        super.onClickClose(self)

        -- 清除记录其他界面的记录
        hero.setSingleSelectOffset(nil)
    end
end

function playerClose(self)
    self.mCurHeroId = nil
    self.mCurTabType = nil
end

function active(self, args)
    -- 此处确保尽快看到展示的场景
    Perset3dHandler:setupShowData(MainCityConst.ROLE_MODE_OVERVIEW, nil, nil,
    UrlManager:getBgPath("common/common_bg_003.jpg"))
    super.active(self, args)
    MoneyManager:setMoneyTidList({MoneyTid.GOLD_COIN_TID, MoneyTid.HERO_GLOBAL_EXP_TID}, 1)
    GameDispatcher:addEventListener(EventName.CHANGE_HERO_TAB, self.changeTabDatas, self)
    GameDispatcher:addEventListener(EventName.UPDATE_HEAD_CHANGE, self.onUpdateHead, self)
    GameDispatcher:addEventListener(EventName.OPEN_HERO_SPECIAL_TAB, self.onClickMenuHandler, self)
    GameDispatcher:addEventListener(EventName.HERO_DATA_UPDATE, self.onUpdateHeroDetailDataHandler, self)
    hero.HeroFlagManager:addEventListener(hero.HeroFlagManager.FLAG_UPDATE, self.onBubbleUpdateHandler, self)
    hero.HeroManager:addEventListener(hero.HeroManager.PANEL_SHOW_HERO_CHANGE, self.onUpdatePanelShowHeroHandler, self)
    hero.HeroManager:addEventListener(hero.HeroManager.BLOCK_GROUP_TOP_CLICK, self.setGroupTopClickState, self)
    self.mCurHeroId = hero.HeroManager:getPanelShowHeroId()
    self:setTabBar2Parent(self.mTabBarTrans)
    self.teamId = args.teamId
    self.mIsPrepare = args.isPrepare

    if self.teamId then
        local heroIdList = {}
        for k, v in pairs(formation.FormationManager:getSelectFormationHeroList(self.teamId)) do
            table.insert(heroIdList, v.heroId)
        end
        self:updataBtnState()
        hero.HeroManager:setPanelShowHeroIdList(heroIdList, true)
    elseif hero.HeroManager:getIsFormationList() then
        hero.HeroManager:setPanelShowHeroIdList(hero.HeroManager:getAllHeroIdList())
    end
    self.mBtnHandRing:SetActive(funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HERO_BRACELETS, false) ==
    true)
    self.mBtnEquip:SetActive(funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HERO_EQUIP, false) == true)

    if (self.mCurHeroId and self.mCurTabType) then
        self:setData(self.mCurHeroId, self.mCurTabType, args and args.subData or args, false)
    else
        self:changeTabDatas(false)
        -- 这里会从其他功能跳转过来，需要安全判断先设置下展示的英雄id
        if (not self.mCurHeroId and args.heroId) then
            hero.HeroManager:setPanelShowHeroId(args.heroId)
        end
        self:setData(args.heroId, args.tabType, args.subData, true)
    end
    local onClick = function()
        if self.mCurTabType == hero.DevelopTabType.MILITARY_RANK_UP then
            self:changeTabDatas(false)
        end
    end
    self.mModelClickEvent.onClick:AddListener(onClick)
end

function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList()
    GameDispatcher:removeEventListener(EventName.CHANGE_HERO_TAB, self.changeTabDatas, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_HEAD_CHANGE, self.onUpdateHead, self)
    GameDispatcher:removeEventListener(EventName.OPEN_HERO_SPECIAL_TAB, self.onClickMenuHandler, self)
    GameDispatcher:removeEventListener(EventName.HERO_DATA_UPDATE, self.onUpdateHeroDetailDataHandler, self)
    -- hero.HeroFlagManager:removeEventListener(hero.HeroFlagManager.FLAG_UPDATE, self.updateBackListBubble, self)
    hero.HeroFlagManager:removeEventListener(hero.HeroFlagManager.FLAG_UPDATE, self.onBubbleUpdateHandler, self)
    hero.HeroManager:removeEventListener(hero.HeroManager.PANEL_SHOW_HERO_CHANGE, self.onUpdatePanelShowHeroHandler, self)
    hero.HeroManager:removeEventListener(hero.HeroManager.BLOCK_GROUP_TOP_CLICK, self.setGroupTopClickState, self)
    self:recoverModel(true)
    self:recoverNewDic()
    RedPointManager:remove(self.mBtnBackList.transform)
    RedPointManager:remove(self.mBtnDna.transform)
    self.mModelClickEvent.onClick:RemoveAllListeners()
end

function initViewText(self)
    super.initViewText(self)
    self:setBtnLabel(self.mBtnFashion, 62502, "时装")
    self:setBtnLabel(self.mBtnInfo, 1223, "档案")
    self:setBtnLabel(self.mBtnFavorable, 1224, "互动")

    self.mTxtEquip.text = _TT(1383) --关卡进度
    self.mTxtHandRing.text = _TT(4318)
    self.mTxtDnaName.text = _TT(149903)
end

-- UI事件管理
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnLast, self.onClickLastHeroHandler)
    self:addUIEvent(self.mBtnNext, self.onClickNextHeroHandler)
    self:addUIEvent(self.mBtnBackList, self.onClickBackListHandler)

    self:addUIEvent(self.mBtnInfo, self.onClickInfoHandler)
    self:addUIEvent(self.mBtnFashion, self.onClickFashionHandler)
    self:addUIEvent(self.mBtnFavorable, self.onClickFavorableHandler)
    self:addUIEvent(self.mBtnEquip, self.onClickEquipHandler)
    self:addUIEvent(self.mBtnHandRing, self.onClickBraceletsHandler)
    self:addUIEvent(self.mBackToLvUp, self.onBackToLvUp)
    self:addUIEvent(self.mBtnDna, self.onClickBtnDnaHandler)

    self:addUIEvent(self.mBtnBigHostel, self.onClickBigHostel)
end

function isHorizon(self)
    return false
end

-- 页签父节点
function getTabBarParent(self)
    return self:getChildTrans("TabBarNode")
end

function getTabDatas(self)
    local funcOpenList = {}

    table.insert(funcOpenList, funcopen.FuncOpenConst.FUNC_ID_HERO_LV_UP)
    table.insert(funcOpenList, funcopen.FuncOpenConst.FUNC_ID_HERO_LV_UP)
    table.insert(funcOpenList, funcopen.FuncOpenConst.FUNC_ID_HERO_SKILL)
    table.insert(funcOpenList, funcopen.FuncOpenConst.FUNC_ID_HERO_STAR)
    table.insert(funcOpenList, funcopen.FuncOpenConst.FUNC_ID_HERO_RESONANCE)

    self.tabDataList = {}
    table.insert(self.tabDataList, hero.DevelopTabType.LVL_UP)
    table.insert(self.tabDataList, hero.DevelopTabType.MILITARY_RANK_UP)
    table.insert(self.tabDataList, hero.DevelopTabType.SKILL)
    table.insert(self.tabDataList, hero.DevelopTabType.STAR_UP)
    table.insert(self.tabDataList, hero.DevelopTabType.RESONANCE)

    for i = 1, #self.tabDataList do
        local tabType = self.tabDataList[i]
        if funcopen.FuncOpenManager:isOpen(funcOpenList[i]) then
            self.tabDataList[i] = {
                type = tabType,
                content = {hero.getDevelopName(tabType)},
                nomalIcon = hero
                .getDevelopIcon(tabType),
            selectIcon = hero.getDevelopIcon(tabType)}
        else
            self.tabDataList[i] = nil
        end
    end
    return self.tabDataList
end

function getTabClass(self)
    self.tabClassDic[hero.DevelopTabType.LVL_UP] = hero.HeroLvlUpTabView
    self.tabClassDic[hero.DevelopTabType.MILITARY_RANK_UP] = hero.HeroMilitaryRankUpTabView
    self.tabClassDic[hero.DevelopTabType.SKILL] = hero.HeroSkillTabView
    self.tabClassDic[hero.DevelopTabType.STAR_UP] = hero.HeroStarUpTabView
    self.tabClassDic[hero.DevelopTabType.RESONANCE] = hero.HeroResonanceTabView

    return self.tabClassDic
end

function changeTabDatas(self, isFullLevel)
    if isFullLevel then
        if self.tabBar.curSelectPage ~= hero.DevelopTabType.MILITARY_RANK_UP then
            self.tabBar:setPage(hero.DevelopTabType.MILITARY_RANK_UP)
        end
        self.tabBar:setHideItem({hero.DevelopTabType.LVL_UP})
    else
        if self.tabBar.curSelectPage ~= hero.DevelopTabType.LVL_UP then
            self.tabBar:setPage(hero.DevelopTabType.LVL_UP)
        end
        self.tabBar:setHideItem({hero.DevelopTabType.MILITARY_RANK_UP})
    end
    self.mBackToLvUp:SetActive(isFullLevel)
end

-- 点击菜单
function onClickMenuHandler(self, cusTabType)
    if (cusTabType ~= nil and cusTabType ~= self.mCurTabType) then
        if self.mCurTabType == hero.DevelopTabType.MILITARY_RANK_UP then
            self.tabBar:setHideItem({hero.DevelopTabType.MILITARY_RANK_UP})
            self.mBackToLvUp:SetActive(false)
        end
        self.mCurTabType = cusTabType
    end
    self:updateTabView(nil)
end

-- 点击切换查看前一个英雄
function onClickLastHeroHandler(self)
    local lastHeroId = hero.HeroManager:getPanelShowLastHeroId(self.mCurHeroId)
    if (lastHeroId) then
        hero.HeroManager:setPanelShowHeroId(lastHeroId)
    else
        print("不存在前一个英雄")
    end
end

-- 点击切换查看后一个英雄
function onClickNextHeroHandler(self)
    local nextHeroId = hero.HeroManager:getPanelShowNextHeroId(self.mCurHeroId)
    if (nextHeroId) then
        hero.HeroManager:setPanelShowHeroId(nextHeroId)
    else
        print("不存在后一个英雄")
    end
end

function onClickEquipHandler(self)
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HERO_EQUIP, true) == false then
        return
    end
    GameDispatcher:dispatchEvent(EventName.OPEN_HERO_EQUIP_PANEL, {heroId = self.mCurHeroId, tabType = nil})
end

function onClickBraceletsHandler(self)
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HERO_BRACELETS, true) == false then
        return
    end
    GameDispatcher:dispatchEvent(EventName.OPEN_BRACELETS_BAG_PANEL, {heroId = self.mCurHeroId, slotPos = 7})
end

-- 打开英雄选择界面
function onClickBackListHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_HERO_SHOW_SELECT_PANEL, {teamId = self.teamId})
end

function onClickFavorableHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_FAVORABLE_PANEL)
end

function onClickFashionHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI,
    {linkId = LinkCode.HeroFashion, param = {heroId = self.mCurHeroId, type = nil}})
end

function onClickInfoHandler(self)
    local heroVo = hero.HeroManager:getHeroVo(self.mCurHeroId)
    GameDispatcher:dispatchEvent(EventName.OPEN_HERO_DETAILS_PANEL, {heroId = self.mCurHeroId, heroTid = heroVo.tid})
end

function onBackToLvUp(self)
    self:changeTabDatas(false)
end

function onClickBigHostel(self)
    local curHeroVo = hero.HeroManager:getHeroVo(self.mCurHeroId)
    GameDispatcher:dispatchEvent(EventName.OPEN_BIGHOSTEL_SCENE, {model_id = curHeroVo:getHostelModel(), heroConfigVo = hero.HeroManager:getHeroConfigVo(curHeroVo.tid)})
end

--打开dna培育界面
function onClickBtnDnaHandler(self)
    if dna.DnaManager:checkHeroDnaFuncOpen(self.mCurHeroId, true) then
        GameDispatcher:dispatchEvent(EventName.OPEN_DNA_CULTIVATE_PANEL, {
            teamId = self.teamId
        })
    end
end

-- 当前查看的英雄改变
function onUpdatePanelShowHeroHandler(self)
    self:recoverModel(false)
    self.mCurHeroId = hero.HeroManager:getPanelShowHeroId()
    self:setData(self.mCurHeroId, self.mCurTabType, nil, true)
end

function onUpdateHead(self)
    local curHeroVo = hero.HeroManager:getHeroVo(self.mCurHeroId)
    -- if (curHeroVo.head) then
    --     self.mImgHeroIcon:SetImg(UrlManager:getIconPath(curHeroVo.head), false)
    -- elseif curHeroVo.headUrl then
    --     self.mImgHeroIcon:SetImg(curHeroVo.headUrl, false)
    -- else
    --     self.mImgHeroIcon:SetImg(UrlManager:getHeroHeadUrl(curHeroVo.tid), false)
    -- end
    self.mImgHeroIcon:SetImg(UrlManager:getHeroHeadUrlByModel(curHeroVo:getHeroModel()), false)

    self.mImgQualityBar.color = gs.ColorUtil.GetColor(ColorUtil:getPropColor(curHeroVo.color))
    -- self.mTxtName.text = curHeroVo.name
end

-- 当前查看的英雄详细数据更新
function onUpdateHeroDetailDataHandler(self, args)
    if (self.mCurHeroId == args.heroId) then
        self:setData(self.mCurHeroId, self.mCurTabType, nil, true)
    end
end

function onBubbleUpdateHandler(self, args)
    local heroId = args.heroId
    if (heroId == self.mCurHeroId) then
        if (args.flagType == hero.HeroFlagManager.FLAG_TAB_LVL_UP or args.flagType == hero.HeroFlagManager.FLAG_TAB_STAR_UP or args.flagType == hero.HeroFlagManager.FLAG_BTN_EQUIP or
        args.flagType == hero.HeroFlagManager.FLAG_BTN_BRACELETS) or args.flagType == hero.HeroFlagManager.FLAG_TAB_GROW or
        args.flagType == hero.HeroFlagManager.FLAG_TAB_RANK_UP or args.flagType == hero.HeroFlagManager.FLAG_CAN_LVL_TARGET_LIST or args.flagType == hero.HeroFlagManager.FLAG_TAB_SKILL_UP or
        args.flagType == hero.HeroFlagManager.FLAG_CAN_DNA
        then
        self:updateTabBubble(args.flagType, args.isFlag)
    end
end
end

-- function updateBackListBubble(self)
--     local list = self.mIsPrepare and hero.HeroManager:getPanelShowHeroIdList() or nil
--     if (hero.HeroFlagManager:getAllFlagExceptHero(self.mCurHeroId, hero.HeroFlagManager.FLAG_BTN_DEVELOP, list)) then
--         RedPointManager:add(self.mBtnBackList.transform, nil, -27, 16.5)
--     else
--         RedPointManager:remove(self.mBtnBackList.transform)
--     end
-- end

function updateTabBubble(self, flagType, isFlag)
    local function getTabType(_flagType)
        if (_flagType == hero.HeroFlagManager.FLAG_TAB_LVL_UP) then
            return hero.DevelopTabType.LVL_UP
        elseif (_flagType == hero.HeroFlagManager.FLAG_TAB_SKILL_UP) then
            return hero.DevelopTabType.SKILL
        elseif (_flagType == hero.HeroFlagManager.FLAG_TAB_STAR_UP) then
            return hero.DevelopTabType.STAR_UP
        elseif (_flagType == hero.HeroFlagManager.FLAG_TAB_GROW) then
            return hero.DevelopTabType.GROW
        elseif (_flagType == hero.HeroFlagManager.FLAG_TAB_RANK_UP) then
            return hero.DevelopTabType.MILITARY_RANK_UP
        elseif (_flagType == hero.HeroFlagManager.FLAG_CAN_LVL_TARGET_LIST or _flagType == hero.HeroFlagManager.FLAG_CAN_DNA) then
            return self.tabBar.curSelectPage
        end
    end
    local function updateBubble(tabType, isFlag, flagType)
        if (isFlag) then
            self:addBubble(tabType)
        else
            self:removeBubble(tabType)
        end
    end
    if (not flagType and not isFlag) then
        updateBubble(getTabType(flagType), isFlag, flagType)
        flagType = hero.HeroFlagManager.FLAG_TAB_STAR_UP
        isFlag = hero.HeroFlagManager:getFlag(self.mCurHeroId, flagType)
        updateBubble(getTabType(flagType), isFlag, flagType)
        flagType = hero.HeroFlagManager.FLAG_BTN_EQUIP
        isFlag = hero.HeroFlagManager:getFlag(self.mCurHeroId, flagType)
        updateBubble(getTabType(flagType), isFlag, flagType)
        flagType = hero.HeroFlagManager.FLAG_BTN_BRACELETS
        isFlag = hero.HeroFlagManager:getFlag(self.mCurHeroId, flagType)
        updateBubble(getTabType(flagType), isFlag, flagType)
        flagType = hero.HeroFlagManager.FLAG_TAB_GROW
        isFlag = hero.HeroFlagManager:getFlag(self.mCurHeroId, flagType)
        updateBubble(getTabType(flagType), isFlag, flagType)
        flagType = hero.HeroFlagManager.FLAG_TAB_SKILL_UP
        isFlag = hero.HeroFlagManager:getFlag(self.mCurHeroId, flagType)
        updateBubble(getTabType(flagType), isFlag, flagType)
        flagType = hero.HeroFlagManager.FLAG_CAN_LVL_TARGET_LIST
        local awardIsFlag = hero.HeroFlagManager:getFlag(self.mCurHeroId, flagType)
        flagType = hero.HeroFlagManager.FLAG_CAN_DNA
        local dnaIsFlag = hero.HeroFlagManager:getFlag(self.mCurHeroId, flagType)

        flagType = hero.HeroFlagManager.FLAG_TAB_LVL_UP
        isFlag = hero.HeroFlagManager:getFlag(self.mCurHeroId, flagType) or
        hero.HeroFlagManager:getFlag(self.mCurHeroId, hero.HeroFlagManager.FLAG_TAB_RANK_UP)
        updateBubble(getTabType(flagType), isFlag or awardIsFlag or dnaIsFlag, flagType)

        flagType = hero.HeroFlagManager.FLAG_TAB_RANK_UP
        isFlag = hero.HeroFlagManager:getFlag(self.mCurHeroId, flagType)
        updateBubble(getTabType(flagType), isFlag or awardIsFlag, flagType)

        flagType = hero.HeroFlagManager.FLAG_CAN_WEAR_EQUIP
        isFlag = hero.HeroFlagManager:getFlag(self.mCurHeroId, flagType)
        if (isFlag) then
            RedPointManager:add(self.mBtnEquip.transform, nil, 92, 23)
        else
            RedPointManager:remove(self.mBtnEquip.transform)
        end

        flagType = hero.HeroFlagManager.FLAG_CAN_WEAR_BRACELETS
        isFlag = hero.HeroFlagManager:getFlag(self.mCurHeroId, flagType)
        if (isFlag) then
            RedPointManager:add(self.mBtnHandRing.transform, nil, 92, 23)
        else
            RedPointManager:remove(self.mBtnHandRing.transform)
        end

        -- 更新好感度资料红点
        flagType = hero.HeroFlagManager.FLAG_BTN_FAVORABLE
        isFlag = hero.HeroFlagManager:getFlag(self.mCurHeroId, flagType)
        if isFlag then
            RedPointManager:add(self.mInfoRed.transform, nil, 20, 14)
        else
            RedPointManager:remove(self.mInfoRed.transform)
        end

        -- 更新好感度资料剧情红点
        flagType = hero.HeroFlagManager.FLAG_BTN_STORY
        isFlag = hero.HeroFlagManager:getFlag(self.mCurHeroId, flagType)
        if isFlag then
            RedPointManager:add(self.mFavorableRed.transform, nil, 20, 14)
        else
            RedPointManager:remove(self.mFavorableRed.transform)
        end

        -- 更新时装红点
        local curHeroVo = hero.HeroManager:getHeroVo(self.mCurHeroId)
        local fashionEnable = fashion.FashionManager:getFashionEnable(curHeroVo.tid)
        if (fashionEnable) then
            local isFlag = fashion.FashionManager:isHeroFashionBubble(self.mCurHeroId)
            if (isFlag) then
                RedPointManager:add(self.mFashionRed.transform, nil, 20, 14)
            else
                RedPointManager:remove(self.mFashionRed.transform)
            end
        end
    else
        if flagType == hero.HeroFlagManager.FLAG_TAB_LVL_UP then
            local awardIsFlag = hero.HeroFlagManager:getFlag(self.mCurHeroId,
            hero.HeroFlagManager.FLAG_CAN_LVL_TARGET_LIST)
            isFlag = hero.HeroFlagManager:getFlag(self.mCurHeroId, flagType) or
            hero.HeroFlagManager:getFlag(self.mCurHeroId, hero.HeroFlagManager.FLAG_TAB_RANK_UP)
            updateBubble(getTabType(flagType), isFlag or awardIsFlag, flagType)
        elseif flagType == hero.HeroFlagManager.FLAG_TAB_RANK_UP then
            local awardIsFlag = hero.HeroFlagManager:getFlag(self.mCurHeroId,
            hero.HeroFlagManager.FLAG_CAN_LVL_TARGET_LIST)
            isFlag = hero.HeroFlagManager:getFlag(self.mCurHeroId, flagType)
            updateBubble(getTabType(flagType), isFlag or awardIsFlag, flagType)
        elseif flagType == hero.HeroFlagManager.FLAG_CAN_LVL_TARGET_LIST or flagType == hero.HeroFlagManager.FLAG_CAN_DNA then
            local awardIsFlag = hero.HeroFlagManager:getFlag(self.mCurHeroId,
            hero.HeroFlagManager.FLAG_CAN_LVL_TARGET_LIST)
            local dnaIsFlag = hero.HeroFlagManager:getFlag(self.mCurHeroId, flagType)
            updateBubble(getTabType(flagType), awardIsFlag or dnaIsFlag, flagType)

            flagType = hero.HeroFlagManager.FLAG_TAB_LVL_UP
            isFlag = hero.HeroFlagManager:getFlag(self.mCurHeroId, flagType)
            updateBubble(getTabType(flagType), isFlag or awardIsFlag or dnaIsFlag, flagType)

            flagType = hero.HeroFlagManager.FLAG_TAB_RANK_UP
            isFlag = hero.HeroFlagManager:getFlag(self.mCurHeroId, flagType)
            updateBubble(getTabType(flagType), isFlag or awardIsFlag or dnaIsFlag, flagType)
        else
            updateBubble(getTabType(flagType), isFlag, flagType)
        end
    end
end

-- 特殊助战页签红点
function onUpdateAsssistTabBubble(self, args)
    if (funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HERO_ASSIST, false)) then
        if (not self.mImgNew) then
            self.mImgNew = self:getChildTrans("mImgNew")
        end
        local isNew = false
        local curHeroVo = hero.HeroManager:getHeroVo(self.mCurHeroId)
        local assistConfigList = hero.HeroAssistManager:getHeroAssistConfigList(curHeroVo.tid)
        for i = 1, #assistConfigList do
            if (hero.HeroAssistManager:isShowNew(self.mCurHeroId, assistConfigList[i].skillId)) then
                isNew = true
                break
            end
        end
        if (isNew) then
            local newGo = self.mNewImgDic[hero.DevelopTabType.ASSIST] or
            gs.GameObject
            .Instantiate(self.mImgNew,
            self.tabBar:getItemByPage(hero.DevelopTabType.ASSIST):getTrans()).gameObject
            gs.TransQuick:LPosXY(newGo.transform, 65, 30)
            newGo:SetActive(true)
            self.mNewImgDic[hero.DevelopTabType.ASSIST] = newGo
        else
            local newGo = nil
            newGo, self.mNewImgDic[hero.DevelopTabType.ASSIST] = self.mNewImgDic[hero.DevelopTabType.ASSIST], nil
            if (newGo and not gs.GoUtil.IsGoNull(newGo)) then
                gs.GameObject.Destroy(newGo)
            end
        end
    else
        self:recoverNewDic()
    end
end

function setData(self, cusHeroId, cusTabType, cusTabArgs, isInit)
    self.mCurHeroId = cusHeroId and cusHeroId or hero.HeroManager:getFirstHeroId()
    self.mCurTabType = cusTabType and cusTabType or hero.DevelopTabType.LVL_UP
    local heroVo = hero.HeroManager:getHeroVo(self.mCurHeroId)
    if (not heroVo) then
        logError("数据异常，测试赶紧重现下", "hero.HeroDevelopPanel")
        return
    elseif (heroVo:checkIsPreData()) then
        return
    else
        self:updateTabView(cusTabArgs)
        self:updateTabBubble()
        -- self:updateBackListBubble()
        self:updateGuide()
        if cusTabType == hero.DevelopTabType.STAR_UP then
            self.mBtnLast:SetActive(false)
            self.mBtnNext:SetActive(false)
        end
        self:onUpdateHead()
        self:updateDnaInfo()

    end
end

-- 更新大宿舍按钮文本
function updateBigHostelBtn(self)
    if self.mCurTabType ~= hero.DevelopTabType.LVL_UP and self.mCurTabType ~= hero.DevelopTabType.MILITARY_RANK_UP then
        self.mBtnBigHostel:SetActive(false)
    else
        local curHeroVo = hero.HeroManager:getHeroVo(self.mCurHeroId)
        local sceneData = purchase.FashionShopManager:getFashionSceneDataByModelId(curHeroVo.tid, curHeroVo:getHostelModel())
        self.mBtnBigHostel:SetActive(sceneData ~= nil)
    end
end

function updateTabView(self, subData)
    -- self:changeTabDatas(false)
    self:setType(self.mCurTabType, {
        heroId = self.mCurHeroId,
        subData = subData
    }, false)
    if self.mCurTabType ~= hero.DevelopTabType.LVL_UP and self.mCurTabType ~= hero.DevelopTabType.MILITARY_RANK_UP then
        self.mBtnInfo:SetActive(false)
        self.mBtnFashion:SetActive(false)
        self.mBtnFavorable:SetActive(false)
    else
        self.mBtnInfo:SetActive(funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_MANUAL, false))
        self.mBtnFashion:SetActive(funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HERO_FASHION, false))
        self.mBtnFavorable:SetActive(funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_FAVORABLE, false))
        local curHeroVo = hero.HeroManager:getHeroVo(self.mCurHeroId)
        if (curHeroVo) then
            self.mBtnFavorableTxt.text = curHeroVo.favorableLevel
        end
    end
    self:updateDnaInfo()
    self:updateBigHostelBtn()
end

function setType(self, cusTabType, cusArgs, cusIsDispatch)
    self.args[cusTabType] = cusArgs
    -- 设置为不派发，避免死循环
    super.setType(self, cusTabType, cusArgs, false)
    if cusTabType == hero.DevelopTabType.STAR_UP or cusTabType == hero.DevelopTabType.RESONANCE then
        -- self.m_childGos["mImgBgHeroStarUp"]:SetActive(true)
        self.mBtnLast:SetActive(false)
        self.mBtnNext:SetActive(false)

        self.mFlagOpen = true
        self:recoverModel(false)
    else
        if self.mFlagOpen then
            Perset3dHandler:setupShowData(MainCityConst.ROLE_MODE_OVERVIEW, nil, nil,
            UrlManager:getBgPath("common/common_bg_003.jpg"))
            if (self.mModelPlayer:getModelTrans()) then
                self.mModelPlayer.m_modelView:setModeType(MainCityConst.ROLE_MODE_OVERVIEW)
            end
            self.mFlagOpen = nil
        end
        -- self.m_childGos["mImgBgHeroStarUp"]:SetActive(false)
        self:updataBtnState()
        if (not self.mModelPlayer:getModelTrans()) then
            self:__updateModelView()
        end
    end
end

function updataBtnState(self)
    if self.mCurTabType == hero.DevelopTabType.STAR_UP then
        self.mBtnLast:SetActive(false)
        self.mBtnNext:SetActive(false)
    else
        self.mBtnLast:SetActive(hero.HeroManager:getPanelShowLastHeroId(self.mCurHeroId) ~= nil)
        self.mBtnNext:SetActive(hero.HeroManager:getPanelShowNextHeroId(self.mCurHeroId) ~= nil)
    end
end

function __updateModelView(self)
    local heroVo = hero.HeroManager:getHeroVo(self.mCurHeroId)
    --防模型没加载完，切换到升格场景，摄像机关闭问题
    local onModelFinishLoadCall = function()
        if self.mCurTabType == hero.DevelopTabType.STAR_UP or self.mCurTabType == hero.DevelopTabType.RESONANCE then
            Perset3dHandler:toNormalShowData()
            self.mFlagOpen = true
        end

        local data = fashion.FashionManager:getModelHarData(heroVo:getHeroModel())
        if (RefMgr:getSpecialConfig() and sdk.SdkManager:getIsChannelHarmonious()) and data then
            -- 替换材质球预览
            self.mHarFrameSn = LoopManager:addFrame(1, 1, self, function()
                self.mModelPlayer:setMaterial(data.pos, data.materials, {})
            end)
        end
    end

    self:recoverModel(false)
    if (heroVo) then
        self.mModelPlayer:setData(heroVo.id, true, 1, true, MainCityConst.ROLE_MODE_OVERVIEW,
        UrlManager:getBgPath("common/common_bg_003.jpg"), self.mClickerArea, true, onModelFinishLoadCall)
        self:updateTabShow(heroVo)
    end
end

function updateTabShow(self, heroVo)
    if self.tabBar.curSelectPage ~= hero.DevelopTabType.MILITARY_RANK_UP or self.tabBar.curSelectPage ~= hero.DevelopTabType.LVL_UP then
        -- if (heroVo.lvl >= heroVo:getMaxMilitaryLvl()) then
        --     local maxMilitaryRank = hero.HeroMilitaryRankManager:getMaxMilitaryRankLvl(heroVo.tid)
        --     if (heroVo.militaryRank < maxMilitaryRank) then
        --         self.tabBar:setHideItem({ hero.DevelopTabType.LVL_UP })
        --     else
        --         self.tabBar:setHideItem({ hero.DevelopTabType.MILITARY_RANK_UP })
        --     end
        -- else
        self.tabBar:setHideItem({hero.DevelopTabType.MILITARY_RANK_UP})
        -- end
    end
end

--设置顶层返回按钮能否出发点击
function setGroupTopClickState(self, isEnable)
    if not self.mGroupTopRayCast then
        self.mGroupTopRayCast = self.base_childGos["mGroupTop"]:GetComponent(ty.GraphicRaycaster)
    end
    self.mGroupTopRayCast.enabled = isEnable
end

function recoverModel(self, isResetMaincity)
    self.mModelPlayer:reset(isResetMaincity)
    if self.mHarFrameSn then
        LoopManager:removeFrameByIndex(self.mHarFrameSn)
        self.mHarFrameSn = nil
    end
end

function recoverNewDic(self)
    for tabType, newGo in pairs(self.mNewImgDic) do
        if (newGo and not gs.GoUtil.IsGoNull(newGo)) then
            gs.GameObject.Destroy(newGo)
        end
    end
    self.mNewImgDic = {}
end

function updateGuide(self)
    for type, item in pairs(self.tabBar.btnMap) do
        self:setGuideTrans("guide_HeroDevelopTab_" .. type, item:getChildTrans("mBtnNomal"))
    end
end

function updateDnaInfo(self)
    --只在详情界面显示
    local isShow = dna.DnaManager:checkFuncIsOpen(false) and
    self.mCurTabType == hero.DevelopTabType.LVL_UP or self.mCurTabType == hero.DevelopTabType.MILITARY_RANK_UP
    self.mBtnDna:SetActive(isShow)
    if isShow then
        RedPointManager:remove(self.mBtnDna.transform)
        local isHeroDnaFuncOpen = dna.DnaManager:checkHeroDnaFuncOpen(self.mCurHeroId)
        self.mGroupInfo:SetActive(isHeroDnaFuncOpen)
        self.mImgDnaLock:SetActive(not isHeroDnaFuncOpen)
        if isHeroDnaFuncOpen then
            local curHeroVo = hero.HeroManager:getHeroVo(self.mCurHeroId)
            local isNone = curHeroVo:checkDnaStatus(hero.eggType.none)
            local isEgg = curHeroVo:checkDnaStatus(hero.eggType.egg)
            local isRole = curHeroVo:checkDnaStatus(hero.eggType.role)
            self.mImgDnaAdd:SetActive(isNone)
            self.mAriDnaIcon.gameObject:SetActive(isEgg)
            self.mAriDnaHead.gameObject:SetActive(isRole)
            if isEgg then
                local eggDataCfgVo = dna.DnaManager:getSingleEggDataCfgVoByHeroId(self.mCurHeroId)
                self.mAriDnaIcon:SetImg(eggDataCfgVo:getDnaEggIconUrl())
            end
            if isRole then
                local heroEggDataCfgVo = dna.DnaManager:getSingleHeroEggDataCfgVoByHeroId(self.mCurHeroId)
                self.mAriDnaHead:SetImg(heroEggDataCfgVo:getDnaHeroHeadUrl())
            end
            local isFlag = dna.DnaManager:getHeroDnaFuncRedFlag(curHeroVo)
            if isFlag then
                RedPointManager:add(self.mBtnDna.transform, nil, 40, 40)
            end
        end
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
