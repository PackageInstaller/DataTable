--[[ 
-----------------------------------------------------
@filename       : BuildBaseMemberPanel
@Description    : 基建主界面 进驻总览
@date           : 2023-02
@Author         : 
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('buildBase.BuildBaseSettleInListPanel', Class.impl(View))
UIRes = UrlManager:getUIPrefabPath("buildBase/BuildBaseSettleInListPanel.prefab")
destroyTime = 0 -- 自动销毁时间-1默认
isShow3DBg = 0
panelType = -1

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    -- self:setTxtTitle("进驻总览") --语言包
end

--析构  
function dtor(self)
    super.dtor(self)
end

-- 初始化数据
function initData(self)
    super.initData(self)

    self.mLastSortFilter = hero.HeroManager:getFilterData()
    if self.mLastSortFilter == nil then
        self.mLastSortFilter = {}
        self.mLastSortFilter.isFilterSame = hero.HeroManager:getFilterSameHero() == "1"
        self.mLastSortFilter.isShowAll = false
        self.mLastSortFilter.isFindLike = false
        self.mLastSortFilter.isFindLock = false
        self.mLastSortFilter.isDescending = true
        self.mLastSortFilter.selectSortType = showBoard.panelSortType.LEVEL
        self.mLastSortFilter.selectFilterDic = {}
    end
    if not self.filterData then
        self.filterData = {}
    end
    self.filterData.isFilterSame = hero.HeroManager:getFilterSameHero() == "1"
    self.filterData.isShowAll = false
    self.filterData.isFindLike = false
    self.filterData.isFindLock = false
    self.filterData.isDescending = isDescending ~= nil and isDescending or true
    self.filterData.selectSortType = Type ~= nil and Type or showBoard.panelSortType.BUILDSKILL
    self.filterData.selectFilterDic = {}

    for type in pairs(showBoard.panelFilterTypeDic) do
        self.filterData.selectFilterDic[type] = {}
        self.filterData.selectFilterDic[type][showBoard.filterSubTypeAll] = true
    end

    hero.HeroManager:setFilterData(self.filterData)
    self:updateFilterData()
end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.mScroll = self:getChildGO("Scroll"):GetComponent(ty.LyScroller)
    self.mScroll:SetItemRender(buildBase.BuildBaseListItem)
    self.mHeroListItem = self:getChildGO("HeroListItem")
    self.mTextEmptyTip = self:getChildGO("TextEmptyTip"):GetComponent(ty.Text)
    self.mTxtHeroName = self:getChildGO("mTxtHeroName"):GetComponent(ty.Text)
    self.mTxtState = self:getChildGO("mTxtState"):GetComponent(ty.Text)
    self.mTxtTime = self:getChildGO("mTxtTile_02"):GetComponent(ty.Text)
    self.mTxtLeftTime = self:getChildGO("mTxtLeftTime"):GetComponent(ty.Text)
    self.mImgState = self:getChildGO("mImgState"):GetComponent(ty.AutoRefImage)
    self.mTxtBuildLv = self:getChildGO("mTxtBuildLv"):GetComponent(ty.Text)
    self.mTxtBuildName = self:getChildGO("mTxtBuildName"):GetComponent(ty.Text)
    self.mTxtBuildId = self:getChildGO("mTxtBuildId"):GetComponent(ty.Text)
    self.mBuildEffect1 = self:getChildGO("mBuildEffect1")
    self.mBuildEffect1:SetActive(false)
    self.mTxtEffect1 = self:getChildGO("mTxtEffect1"):GetComponent(ty.Text)
    self.mIconEffect1 = self:getChildGO("mIconEffect1"):GetComponent(ty.AutoRefImage)
    self.mTxEffectDesc1 = self:getChildGO("mTxEffectDesc1"):GetComponent(ty.Text)
    self.mBuildEffect2 = self:getChildGO("mBuildEffect2")
    self.mBuildEffect2:SetActive(false)
    self.mTxtEffect2 = self:getChildGO("mTxtEffect2"):GetComponent(ty.Text)
    self.mIconEffect2 = self:getChildGO("mIconEffect2"):GetComponent(ty.AutoRefImage)
    self.mTxEffectDesc2 = self:getChildGO("mTxEffectDesc2"):GetComponent(ty.Text)
    self.mBtnClear = self:getChildGO("mBtnClear")
    self.mBtnCommit = self:getChildGO("mBtnCommit")
    self.mTxtLeftStamina = self:getChildGO("mTxtLeftStamina"):GetComponent(ty.Text)
    self.mTxtCondition2 = self:getChildGO("mTxtCondition2"):GetComponent(ty.Text)
    self.m_sortView = hero.HeroSortView.new()
    self.m_sortView:setParentTrans(self:getChildTrans("NodeFilter"))
    self.m_sortView:setShowRed(false)
    -- 点击排序item
    local function __onClickSortItemHandler(self)
        local filterData = hero.HeroManager:getFilterData()
        filterData.isFilterSame = self.m_sortView:getIsFilterSame()
        filterData.isShowAll = self.m_sortView:getIsShowAll()
        filterData.isFindLike = self.m_sortView:getIsLike()
        filterData.isFindLock = self.m_sortView:getIsLock()
        filterData.isDescending = self.m_sortView:getIsDescending()
        filterData.selectSortType = self.m_sortView:getSortFilterType()
        hero.HeroManager:setFilterSameHero(self.m_sortView:getIsFilterSame() and "1" or "0")
        hero.HeroManager:setFilterData(filterData)
        self.m_isFilterSame = self.m_sortView:getIsFilterSame()
        self.m_isShowAll = self.m_sortView:getIsShowAll()
        self.m_isDescending = self.m_sortView:getIsDescending()
        self.m_selectSortType = self.m_sortView:getSortFilterType()
        self.m_isFindLike, self.m_isFindLock = self.m_sortView:getIsLike(), self.m_sortView:getIsLock()
        self.m_selectFilterDic = self.m_sortView:getSearchFilterDic()
        self.isFirstSort = false
        self:setData()
    end
    self.m_sortView:setCallBack(self, __onClickSortItemHandler)
    self.isFirstSort = true
    for i = 1, 13 do
        if self.mMiniMapLsic == nil then
            self.mMiniMapLsic = {}
        end
        self.mMiniMapLsic[i] = self:getChildGO("mPos" .. i)
        self.mMiniMapLsic[i]:SetActive(false)
    end

    self:setGuideTrans("funcTips_guide_buildBaseSettleIn_tips", self:getChildTrans("mNormal"))
end

--激活
function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList()
    self.mBuildBaseVo = args.buildBaseVo
    self.mBuildBasePosVo = buildBase.BuildBaseManager:getBuildBasePosDataByPos(self.mBuildBaseVo.id)

    if self.mBuildBasePosVo.buildType == buildBase.BuildBaseType.Dormitory then
        self.mTxtTime.text = _TT(76184)
        self:setBtnLabel(self.mBtnClear, nil, "一键休息")  --语言包
    else
        self.mTxtTime.text = _TT(76185)
        self:setBtnLabel(self.mBtnClear, nil, "清空选择")  --语言包
    end
    self:updateMiniMap(self.mBuildBaseVo)
    self:setSortType()
    self:updateFilterData()
    self:setData()
    GameDispatcher:addEventListener(EventName.SELECT_SETTLEIN_HERO_UI, self.updateBaseDetail, self)
    GameDispatcher:addEventListener(EventName.RESPONSE_BUILDBASE_HERELIST_UPDATE, self.reflashView, self)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    buildBase.BuildBaseHeroManager:clearSettleHero()
    MoneyManager:setMoneyTidList({ MoneyTid.UAV_TID, MoneyTid.POWER_TID, MoneyTid.TITANITE_TID })
    self.m_sortView:resetAll()
    if self.mScroll then
        self.mScroll:CleanAllItem()
    end
    if next(self.mLastSortFilter) == nil then
        self.mLastSortFilter = {}
        self.mLastSortFilter.isFilterSame = hero.HeroManager:getFilterSameHero() == "1"
        self.mLastSortFilter.isShowAll = false
        self.mLastSortFilter.isFindLike = false
        self.mLastSortFilter.isFindLock = false
        self.mLastSortFilter.isDescending = true
        self.mLastSortFilter.selectSortType = showBoard.panelSortType.LEVEL
        self.mLastSortFilter.selectFilterDic = {}
    end
    self.mLastSortFilter.selectSortType = showBoard.panelSortType.LEVEL
    hero.HeroManager:setFilterData(self.mLastSortFilter)
    for type in pairs(showBoard.panelFilterTypeDic) do
        self.mLastSortFilter.selectFilterDic[type] = {}
        self.mLastSortFilter.selectFilterDic[type][showBoard.filterSubTypeAll] = true
    end
    GameDispatcher:removeEventListener(EventName.SELECT_SETTLEIN_HERO_UI, self.updateBaseDetail, self)
    GameDispatcher:removeEventListener(EventName.RESPONSE_BUILDBASE_HERELIST_UPDATE, self.reflashView, self)
    if (self.loopSn) then
        LoopManager:removeTimerByIndex(self.loopSn)
        self.loopSn = nil
    end
end

function initViewText(self)
    self.mTxtBuildLv.text = "<size=14>Lv.</size> " .. self.mBuildBaseVo.lv
    if self.mBuildBaseVo.id < 10 then
        self.mTxtBuildId.text = "0" .. self.mBuildBaseVo.id
    else
        self.mTxtBuildId.text = self.mBuildBaseVo.id
    end
    self.mTxtBuildName.text = _TT(self.mBuildBasePosVo.name)
    self:setBtnLabel(self.mBtnCommit, nil, "确认")
end

-- UI事件管理
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnClear, self.onClearSelect)
    self:addUIEvent(self.mBtnCommit, self.onCommit)
end

function updateFilterData(self)
    local filterData = hero.HeroManager:getFilterData()
    -- 过滤相同战员
    self.m_isFilterSame = filterData.isFilterSame
    -- 显示全部战员
    self.m_isShowAll = filterData.isShowAll
    -- 是否查找喜欢的英雄
    self.m_isFindLike = filterData.isFindLike
    -- 是否查找锁定的英雄
    self.m_isFindLock = filterData.isFindLock
    -- 是否降序
    self.m_isDescending = filterData.isDescending
    -- 选择的排序类型
    self.m_selectSortType = filterData.selectSortType
    -- 提供的筛选字典
    self.m_selectFilterDic = filterData.selectFilterDic
end

function recover(self)
    if self.m_heroScrollList and next(self.m_heroScrollList) then
        for i = 1, #self.m_heroScrollList do
            LuaPoolMgr:poolRecover(self.m_heroScrollList[i])
        end
    end
    self.m_heroScrollList = {}
end


-- 移除
function destroy(self, isAuto)
    super.destroy(self, isAuto)
    if self.m_sortView then
        self.m_sortView:destroy()
        self.m_sortView = nil
    end
end

-- 玩家点击关闭
function onClickClose(self)
    self:__playerClose()
    super.onClickClose(self)
end

-- 玩家关闭所有窗口的c#回调
function onCloseAllCall(self)
    self:__playerClose()
    super.onCloseAllCall(self)
end

function __playerClose(self)
    hero.HeroManager:setRsyncSingleFilterData()
    self.isFirstSort = true
    self:initData()
end

--
function updateMiniMap(self, buildMsgVo)
    for id, go in pairs(self.mMiniMapLsic) do
        if id == buildMsgVo.id then
            go:SetActive(true)
        else
            go:SetActive(false)
        end
    end

end


function setSortType(self, Type, isDescending)
    if not self.filterData then
        self.filterData = {}
    end
    self.filterData.isFilterSame = hero.HeroManager:getFilterSameHero() == "1"
    self.filterData.isShowAll = false
    self.filterData.isFindLike = false
    self.filterData.isFindLock = false

    if buildBase.BuildBaseManager:getNowBuildType() == buildBase.BuildBaseType.Dormitory then
        self.filterData.isDescending = isDescending ~= nil and isDescending or false
        self.filterData.selectSortType = Type ~= nil and Type or showBoard.panelSortType.STAMINA
    else
        self.filterData.isDescending = isDescending ~= nil and isDescending or true
        self.filterData.selectSortType = Type ~= nil and Type or showBoard.panelSortType.BUILDSKILL
    end

    self.filterData.selectFilterDic = {}

    for type in pairs(showBoard.panelFilterTypeDic) do
        self.filterData.selectFilterDic[type] = {}
        self.filterData.selectFilterDic[type][showBoard.filterSubTypeAll] = true
    end
    hero.HeroManager:setFilterData(self.filterData)
end
-- 清空
function onClearSelect(self)

    buildBase.BuildBaseHeroManager:clearSettleHero()

    if buildBase.BuildBaseManager:getNowBuildType() == buildBase.BuildBaseType.Dormitory then
        -- 宿舍保留一键排班
        local list = {}
        local tempList = {}
        local buildType = buildBase.BuildBaseManager:getNowBuildType()
        local orderType = buildBase.BuildBaseManager:getOrderType()
        local staminaMax = sysParam.SysParamManager:getValue(5001)

        for idx, heroSelectVo in pairs(self.m_heroScrollList) do
            local buildBaseHeroMsgVo = buildBase.BuildBaseHeroManager:getBuildHeroInfo(heroSelectVo:getDataVo().tid)
            for _, warshipSkillVo in pairs(buildBaseHeroMsgVo.skillList) do
                if buildType == buildBase.BuildBaseType.Dormitory then
                    if buildBaseHeroMsgVo.buildId == 0 or (buildBaseHeroMsgVo.buildId == buildBase.BuildBaseManager.mNowBuildId and buildBaseHeroMsgVo.stamina < staminaMax) or (buildBase.BuildBaseManager:getBuildType(buildBaseHeroMsgVo.buildId) ~= buildBase.BuildBaseType.Dormitory and buildBaseHeroMsgVo.stamina == 0) then
                        table.insert(list, heroSelectVo)
                    end
                else
                    local skillVo = buildBase.BuildBaseHeroManager:getSkillConfigBySkillId(warshipSkillVo.skill_id)
                    if skillVo.produceType == orderType and buildBaseHeroMsgVo.stamina > 0 and (buildBaseHeroMsgVo.buildId == 0 or (buildBaseHeroMsgVo.buildId == buildBase.BuildBaseType.Dormitory and buildBaseHeroMsgVo.stamina == staminaMax)) then
                        table.insert(tempList, heroSelectVo)
                    end
                    if skillVo.produceType ~= orderType and buildBaseHeroMsgVo.stamina > 0 and (buildBaseHeroMsgVo.buildId == 0 or (buildBaseHeroMsgVo.buildId == buildBase.BuildBaseType.Dormitory and buildBaseHeroMsgVo.stamina == staminaMax)) then
                        table.insert(list, heroSelectVo)
                    end
                end
            end
        end
        if not table.empty(tempList) then
            for i = #tempList, 1 do
                table.insert(list, 1, tempList[i])
            end
        end

        for i, v in ipairs(list) do
            if not buildBase.BuildBaseHeroManager:checkSettleIsFull() then
                buildBase.BuildBaseHeroManager:onClickChangeHero(v:getDataVo().tid, true)
            end
        end
    end

    self:setData()
end

-- 入驻
function onCommit(self)
    if buildBase.BuildBaseHeroManager:checkHeroIsMoved() then
        UIFactory:alertMessge(_TT(76176), true, function()
            buildBase.BuildBaseHeroManager:sendHeroMoveInto()
            self:close()
        end, _TT(1), nil, true,
        nil
        , _TT(2), _TT(5), nil, RemindConst.BUILDBASE_SETTLEIN_HERO
        )
    else
        buildBase.BuildBaseHeroManager:sendHeroMoveInto()
        self:close()
    end
end

function reflashView(self)
    self.mBuildBaseVo = buildBase.BuildBaseManager:getBuildBaseData(buildBase.BuildBaseManager:getNowBuildId())
    self:setData()
end

function setData(self)
    self.m_sortView:setShowAll(false, self.m_isShowAll)
    self.m_sortView:setFilterSame(true, self.m_isFilterSame)
    self.m_sortView:addSortMenu({ showBoard.panelSortType.BUILDSKILL, showBoard.panelSortType.STAMINA }, self.m_selectSortType, self.m_isDescending, false)
    self:updateDatalist()
    self:updateView()
end

function updateDatalist(self)
    self.m_heroScrollList = showBoard.ShowBoardManager:getHeroScrollList(nil, self.m_selectSortType, self.m_isDescending, self.m_selectFilterDic, self.m_isFilterSame, false, self.m_isFindLike, self.m_isFindLock, self.isFirstSort)
    if buildBase.BuildBaseManager:getNowBuildType() == buildBase.BuildBaseType.Factory and self.m_isDescending then
        local orderType = buildBase.BuildBaseManager:getOrderType()
        if orderType then
            local temp = {}
            for idx, Vo in pairs(self.m_heroScrollList) do
                local buildBaseHeroMsgVo = buildBase.BuildBaseHeroManager:getBuildHeroInfo(Vo.m_dataVo.tid)
                local config = hero.HeroCuteManager:getHeroCuteConfigVo(Vo.m_dataVo.tid)
                if config then
                    for _, warshipSkillVo in pairs(buildBaseHeroMsgVo.skillList) do
                        local skillVo = buildBase.BuildBaseHeroManager:getSkillConfigBySkillId(warshipSkillVo.skill_id)
                        if skillVo.produceType == orderType then
                            temp[idx] = Vo
                            break
                        end
                    end
                end
            end
            for _, vo in pairs(temp) do
                table.removebyvalue(self.m_heroScrollList, vo)
            end

            local temp2 = {}
            for _, vo in pairs(temp) do
                table.insert(temp2, vo)
            end
            if next(temp2) then
                for i = #temp2, 1, -1 do
                    table.insert(self.m_heroScrollList, 1, temp2[i])
                end
            end
        end
    end

    -- if buildBase.BuildBaseManager:getNowBuildType() ~= buildBase.BuildBaseType.Dormitory then
    local nowBuildID = buildBase.BuildBaseManager:getNowBuildId()
    local mWorkHeroList = {}
    for _, Vo in pairs(self.m_heroScrollList) do
        local buildBaseHeroMsgVo = buildBase.BuildBaseHeroManager:getBuildHeroInfo(Vo.m_dataVo.tid)
        if buildBaseHeroMsgVo.buildId == nowBuildID then
            mWorkHeroList[#mWorkHeroList + 1] = Vo
        end
    end

    if next(mWorkHeroList) then
        for i = #mWorkHeroList, 1, -1 do
            table.removebyvalue(self.m_heroScrollList, mWorkHeroList[i])
            table.insert(self.m_heroScrollList, 1, mWorkHeroList[i])
        end
    end

    -- end
end

-- 更新界面
function updateView(self)
    if (self.m_heroScrollList) then

        self.mScroll.DataProvider = self.m_heroScrollList

        if (#self.m_heroScrollList <= 0) then
            self.mTextEmptyTip.text = _TT(1338)
        else
            self.mTextEmptyTip.text = ""
        end
        self:__updateGuide(self.m_heroScrollList)
    end

    self:updateBaseDetail({true, nil })
end

-- 更新战员详情
function updateBaseDetail(self, args)
    local isInit = args[1]
    local showData = args[2]
    local heroInfo = nil
    if (isInit) then
        heroInfo = buildBase.BuildBaseHeroManager:getBuildHeroInfo(self.mBuildBaseVo.heroList[#self.mBuildBaseVo.heroList])
    else
        heroInfo = showData
    end
    if (self.loopSn) then
        LoopManager:removeTimerByIndex(self.loopSn)
        self.loopSn = nil
    end
    if (heroInfo) then
        local function updateTime()
            local leftTime = heroInfo.staminaTime - GameManager:getClientTime()
            if (leftTime <= 0) then
                self.mTxtLeftTime.text = "--:--:--"
                if (self.loopSn) then
                    LoopManager:removeTimerByIndex(self.loopSn)
                    self.loopSn = nil
                end
            else
                if self.mTxtLeftTime then
                    self.mTxtLeftTime.text = TimeUtil.getHMSByTime(leftTime)
                end
            end
        end
        self.loopSn = LoopManager:addTimer(1, 0, self, updateTime)
        updateTime()
        if heroInfo.buildId > 0 then
            if buildBase.BuildBaseManager:getBuildType(heroInfo.buildId) == buildBase.BuildBaseType.Dormitory then
                self.mTxtTime.text = _TT(76184)
            else
                self.mTxtTime.text = _TT(76185)
            end
        else
        end

        local heroConfigVo = hero.HeroManager:getHeroConfigVo(heroInfo.tid)
        self.m_childGos["mTxtIsEmpty"]:SetActive(true)
        self.mTxtHeroName.text = heroConfigVo.name
        self.mTxtLeftStamina.gameObject:SetActive(true)
        self.mTxtLeftStamina.text = heroInfo.stamina .. "/" .. buildBase.HeroStaminaMax
        local heroState = buildBase.BuildBaseHeroManager:checkHeroState(heroInfo.tid)
        if heroState == buildBase.HeroState.Ready2MoveIn then
            self.mTxtState.gameObject:SetActive(false)
            self.mImgState.gameObject:SetActive(false)
        else
            self.mTxtState.gameObject:SetActive(true)
            self.mImgState.gameObject:SetActive(true)
            self.mTxtState.text = heroState
            local imgUrl = nil
            if heroState == buildBase.HeroState.Working then
                imgUrl = UrlManager:getPackPath("buildBase/buildbase_icon05.png")
            elseif heroState == buildBase.HeroState.Break or heroState == buildBase.HeroState.Able2Work then
                imgUrl = UrlManager:getPackPath("buildBase/buildbase_icon04.png")
            elseif heroState == buildBase.HeroState.Tired then
                imgUrl = UrlManager:getPackPath("buildBase/buildbase_icon06.png")
            end
            self.mImgState:SetImg(imgUrl, false)
        end
        if heroInfo.staminaTime - GameManager:getClientTime() <= 0 then
            self:getChildGO("mTxtState"):SetActive(false)
        else
            self:getChildGO("mTxtState"):SetActive(true)
        end

        local skillInfo_01, skillInfo_02 = heroInfo:getHeroSkillInfos()
        local heroWarShipSkill = heroConfigVo.warshipSkill

        if skillInfo_01 then
            self.mBuildEffect1:SetActive(true)
            local skillConfigVo_01 = buildBase.BuildBaseHeroManager:getSkillConfigBySkillId(skillInfo_01.id)
            if skillConfigVo_01 then
                local maxLv = skillConfigVo_01.attr and #skillConfigVo_01.attr or 3
                self.mTxtEffect1.text = _TT(skillConfigVo_01.name)
                self.mIconEffect1:SetImg(UrlManager:getBuildBaseSkillIconPath(skillConfigVo_01.icon), false)
                local attrVo = skillConfigVo_01:getCurLvAttr(skillInfo_01.lv > maxLv and maxLv or skillInfo_01.lv)
                self.mTxEffectDesc1.text = attrVo.des
            else
                gs.Message.Show("后端基建技能Id,不在配置表中")
            end
        else
            self.mBuildEffect1:SetActive(false)
        end
        if skillInfo_02 then
            self.mBuildEffect2:SetActive(true)
            self.mTxtCondition2.gameObject:SetActive(false)
            local skillConfigVo_02 = buildBase.BuildBaseHeroManager:getSkillConfigBySkillId(skillInfo_02.id)

            if skillConfigVo_02 then
                local maxLv = skillConfigVo_02.attr and #skillConfigVo_02.attr or 3
                self.mTxtEffect2.text = _TT(skillConfigVo_02.name)
                self.mTxtEffect2.color = gs.ColorUtil.GetColor("FFFFFFFF")
                self.mIconEffect2:SetImg(UrlManager:getBuildBaseSkillIconPath(skillConfigVo_02.icon), false)
                local attrVo2 = skillConfigVo_02:getCurLvAttr(skillInfo_02.lv > maxLv and maxLv or skillInfo_02.lv)
                self.mTxEffectDesc2.text = attrVo2.des
                self.mTxEffectDesc2.color = gs.ColorUtil.GetColor("FFFFFFFF")
            else
                gs.Message.Show("后端基建技能Id,不在配置表中")
            end
        else
            if #heroWarShipSkill > 1 then
                self.mBuildEffect2:SetActive(true)
                local rankVo = hero.HeroMilitaryRankManager:getMilitaryRankDic(heroInfo.tid)
                local unLockLv = 0
                for _, v in pairs(rankVo) do
                    if #v > 0 then
                        break;
                    end
                    unLockLv = unLockLv + 1
                end

                if hero.HeroManager:getHeroVoByTid(heroInfo.tid).militaryRank < unLockLv then

                    self.mTxtCondition2.gameObject:SetActive(true)
                    self.mTxtCondition2.text = _TT(76000, "IV")
                else
                    self.mTxtCondition2.gameObject:SetActive(false)
                end

                local skillConfigVo_02 = buildBase.BuildBaseHeroManager:getSkillConfigBySkillId(heroWarShipSkill[2])
                self.mTxtEffect2.text = _TT(skillConfigVo_02.name)
                self.mTxtEffect2.color = gs.ColorUtil.GetColor("82898cFff")
                self.mIconEffect2:SetImg(UrlManager:getBuildBaseSkillIconPath(skillConfigVo_02.icon), false)
                local attrVo2 = skillConfigVo_02:getCurLvAttr(1)
                self.mTxEffectDesc2.text = attrVo2.des
                self.mTxEffectDesc2.color = gs.ColorUtil.GetColor("82898cFff")
            else
                self.mBuildEffect2:SetActive(false)
            end
        end
    else
        self.m_childGos["mTxtIsEmpty"]:SetActive(false)
    end
end

function __updateGuide(self, scrollList)
    if (#scrollList > 0) then
        for i = 0, #scrollList - 1 do
            local heroVo = scrollList[i + 1]:getDataVo()
            if (heroVo) then
                if (heroVo.id == hero.HeroManager:getMinHeroId()) then
                    local scrollItem = self.mScroll:GetItemLuaClsByIndex(i)
                    -- 是否在显示列表内
                    if (scrollItem) then
                        self:setGuideTrans("hero_list_first_item_1", scrollItem:getGuideTrans())
                    end
                end
                if (heroVo.tid == sysParam.SysParamManager:getValue(SysParamType.TWO_HERO_ID)) then
                    local scrollItem = self.mScroll:GetItemLuaClsByIndex(i)
                    -- 是否在显示列表内
                    if (scrollItem) then
                        self:setGuideTrans("hero_list_first_item_2", scrollItem:getGuideTrans())
                    end
                end
                if (heroVo.tid == sysParam.SysParamManager:getValue(SysParamType.THIRD_HERO_ID)) then
                    local scrollItem = self.mScroll:GetItemLuaClsByIndex(i)
                    -- 是否在显示列表内
                    if (scrollItem) then
                        self:setGuideTrans("hero_list_first_item_3", scrollItem:getGuideTrans())
                    end
                end
            end
        end
    end


    self:setGuideTrans("funcTips_guide_BuildBase_BtnCommit", self.mBtnCommit.transform)
    self:setGuideTrans("funcTips_guide_BuildBase_settledTips", self:getChildTrans("mGuide_point"))
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(1338):	"- 当前暂无战员 -"
]]