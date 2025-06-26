--[[     阵型英雄选择界面
]]
module("formation.FormationHeroSelectPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("formation/FormationHeroSelectPanel.prefab")
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
isBlur = 0 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）

-- 构造函数
function ctor(self)
    super.ctor(self)
    local w, h = ScreenUtil:getScreenSize()
    self:setSize(w, h)
    self:initData()
end

function getManager(self)
    return self.m_manager
end

function setManager(self, cusManager)
    self.m_manager = cusManager
end

-- 初始化数据
function initData(self)
    self.m_teamId = nil
    self.m_formationId = nil
    self.m_colIndex = nil
    self.m_rowIndex = nil
    self.tileFormationHeroVo = nil
    self.mCloseSn = nil
end

-- 初始化
function configUI(self)
    self.m_groupFormation = self:getChildTrans('GroupFormation')

    self.m_sortView = hero.HeroSortMaxView.new()
    self.m_sortView:setParentTrans(self:getChildTrans("NodeFilter"))
    self.m_sortView:setCallBack(self, self.__onClickSortItemHandler)
    self.m_sortView.m_uiGos["GroupShowAll"]:SetActive(false)
    self.m_scrollerSelect = self:getChildGO("LyScroller"):GetComponent(ty.LyScroller)
    self.m_scrollerSelect:SetItemRender(self:__getHeadSelectItem())


    self.m_imgTitle = self:getChildGO("ImgTitle")
    self.m_groupSort = self:getChildGO("GroupSort")
    self.m_transGroupSort = self:getChildTrans("ContentSort")
    self.m_transGroupFilter = self:getChildTrans("GroupFilter")
    self.m_btnCancel = self:getChildGO("BtnCancel")
    self.m_btnConfirm = self:getChildGO("BtnConfirm")
    self.m_btnFilter = self:getChildGO("BtnFilter")
    self.mBtnClose = self:getChildGO("mBtnClose")
    self.mAni = self:getChildGO("root"):GetComponent(ty.Animator)
end

-- 移除
function destroy(self, isAuto)
    super.destroy(self, isAuto)

    if self.m_sortView then
        self.m_sortView:destroy()
        self.m_sortView = nil
    end
end

-- 设置全屏透明遮罩
function setMask(self)
    self:__updateSiblingIndex()
end

-- 激活
function active(self, args)
    super.active(self, args)
    self:setManager(args.manager)
    local filterDic = self:getManager():getFilterDic()
    self:initSortData(filterDic)
    self:setData(args.data, true)
    self:getManager():addEventListener(self:getManager().HERO_FORMATION_SELECT, self.__onFormationHeroSelectHandler, self)
    self:getManager():addEventListener(self:getManager().CLOSE_FORMATIONHERO_CHOOSE, self.onClickClose, self)
    GameDispatcher:addEventListener(EventName.REFRESH_FORMATION_HERO_SELECT, self.setData, self)
end

function initSortData(self, dic)
    self.mIsFilterUseState = dic.mIsFilterUseState
    -- 过滤相同战员
    self.m_isFilterSame = dic.m_isFilterSame
    -- 是否查找喜欢的英雄
    self.m_isFindLike = dic.m_isFindLike
    -- 是否查找锁定的英雄
    self.m_isFindLock = dic.m_isFindLock
    -- 是否降序
    self.m_isDescending = dic.m_isDescending
    -- 选择的排序类型
    self.m_selectSortType = dic.m_selectSortType
    -- 提供的筛选字典
    self.m_selectFilterDic = dic.m_selectFilterDic
end

function close(self)
    super.close(self)
end

function onClickClose(self)
    super.onClickClose(self)
end

function __closeOpenAction(self)
    if self.mAni and not self.isCloseing then
        self.isCloseing = true
        gs.UIBlurManager.SetSuperBlur(false, self.UIRootNode, self:getUiNodeName(), self.blurTweenTime)
        if self.mBlurMask then
            gs.GameObject.Destroy(self.mBlurMask)
            self.mBlurMask = nil
        end

        self.mAni:SetTrigger("exit")
        local finishCall = function()
            if self.isPop == 1 then
                self:close()
            end
        end
        LoopManager:addTimer(0.12, 1, self, finishCall)
    else
        super.__closeOpenAction(self)
    end
end

-- 非激活
function deActive(self)
    self:__playerClose()
    if self.mAni then
        self.mAni:SetTrigger("exit")
    end
    self:saveFilterDic()
    super.deActive(self)
    -- self.mLongPress.onClick:RemoveAllListeners()
    TweenFactory:move2LPosX(self.m_groupFormation, 600, 0.3)
    self:getManager():removeEventListener(self:getManager().HERO_FORMATION_SELECT, self.__onFormationHeroSelectHandler, self)
    self:getManager():removeEventListener(self:getManager().CLOSE_FORMATIONHERO_CHOOSE, self.onClickClose, self)
    GameDispatcher:removeEventListener(EventName.REFRESH_FORMATION_HERO_SELECT, self.setData, self)
    self.m_sortView:resetAll()

    if (self.m_actionFrameSn) then
        LoopManager:removeFrameByIndex(self.m_actionFrameSn)
    end
end

function saveFilterDic(self)
    local dic = {}
    dic.mIsFilterUseState = self.mIsFilterUseState
    -- 过滤相同战员
    dic.m_isFilterSame = self.m_isFilterSame
    -- 是否查找喜欢的英雄
    dic.m_isFindLike = self.m_isFindLike
    -- 是否查找锁定的英雄
    dic.m_isFindLock = self.m_isFindLock
    -- 是否降序
    dic.m_isDescending = self.m_isDescending
    -- 选择的排序类型
    dic.m_selectSortType = self.m_selectSortType
    -- 提供的筛选字典
    dic.m_selectFilterDic = self.m_selectFilterDic
    self:getManager():setFilterDic(dic)
end

function initViewText(self)
    self:setBtnLabel(self.m_btnCancel, 2, "取消")
    self:setBtnLabel(self.m_btnConfirm, 1, "确定")
    self:setBtnLabel(self.m_btnFilter, 1001, "筛选")
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.m_btnFilter, self.__onOpenSortViewHandler)
    self:addUIEvent(self.m_btnCancel, self.__onClickCancelHandler)
    self:addUIEvent(self.m_btnConfirm, self.__onClickConfirmHandler)
    self:addUIEvent(self.mBtnClose, self.onClickClose)
end

function __playerClose(self)
    if self.target then
        self.closeCallBack(self.target)
    end
end

function __getHeadSelectItem(self)
    return formation.FormationHeroSelectItem
end

-- 点击排序item
function __onClickSortItemHandler(self)
    self.mIsFilterUseState = self.m_sortView:getIsFilterUseState()
    -- 过滤相同战员
    self.m_isFilterSame = self.m_sortView:getIsFilterSame()
    self.m_isDescending = self.m_sortView:getIsDescending()
    self.m_selectSortType = self.m_sortView:getSortFilterType()
    self.m_isFindLike, self.m_isFindLock = self.m_sortView:getIsLike(), self.m_sortView:getIsLock()
    self.m_selectFilterDic = self.m_sortView:getSearchFilterDic()
    self:__updateView()
end

function __onFormationHeroSelectHandler(self, args)
    local teamId = self.m_teamId
    local selectHeroId = args.heroId
    local selectHeroTid = args.heroTid
    local selectHeroSourceType = args.heroSourceType
    local selectIsInFormation = args.isInFormation
    local selectIsInAssist = args.isInAssist

    local function reqSelect()
        local targetPos = self:getManager():getFormationTilePos(self.m_formationId, self.m_colIndex, self.m_rowIndex)
        local isFight = self:getManager():setSelectFormationHeroList(teamId, self.m_formationId, selectHeroId, selectHeroTid, selectHeroSourceType, targetPos, true)

        local heroNum = #self:getManager():getSelectFormationHeroList(teamId)
        local formationMaxCount = self:getManager():getFormationHeroMaxCount(self.m_formationId)
        local hasHeroNum = #hero.HeroManager:getAllHeroList()
        if heroNum >= hasHeroNum then
            self:close()
        else
            if heroNum < formationMaxCount and isFight then
                local formationTileCount, row, col = self:getManager():getFormationTileCount()
                local heroPos = -1
                local tempCol, tempRow = 0
                for col_x = 1, col do
                    for row_y = 1, row do
                        local tempPos = self:getManager():getFormationTilePos(self.m_formationId, col_x, row_y)
                        local isLock = self:getManager():getFormationTileLock(self.m_formationId, col_x, row_y)
                        if tempPos > 0 and not isLock then
                            if not self:getManager():getFormationHeroVoByPos(teamId, tempPos) then
                                heroPos = tempPos
                                tempCol = col_x
                                tempRow = row_y
                                break
                            end
                        end
                    end
                    if heroPos > -1 then
                        break
                    end
                end

                if tempCol > 0 and tempRow > 0 then
                    self:getManager():dispatchEvent(self:getManager().HERO_FORMATION_TILE_SELECT, { col = tempCol, row = tempRow })
                else
                    self:getManager():dispatchEvent(self:getManager().HERO_FORMATION_TILE_SELECT)
                    local tilePos = self:getManager():getFormationTilePos(self.m_formationId, self.m_colIndex, self.m_rowIndex)
                    self.tileFormationHeroVo = self:getManager():getFormationHeroVoByPos(self.m_teamId, tilePos)
                    self:__updateView()
                end

            else
                self:getManager():dispatchEvent(self:getManager().HERO_FORMATION_TILE_SELECT)
                local tilePos = self:getManager():getFormationTilePos(self.m_formationId, self.m_colIndex, self.m_rowIndex)
                self.tileFormationHeroVo = self:getManager():getFormationHeroVoByPos(self.m_teamId, tilePos)
                self:__updateView()
            end
        end
    end
    if (selectIsInAssist) then
        UIFactory:alertMessge(_TT(1282),
        true, function() reqSelect() end, _TT(1), nil,
        true, function() end, _TT(2),
        _TT(5), nil, RemindConst.NULL)
    else
        reqSelect()
    end
end

function setData(self, cusData, isInit)
    if cusData then
        self.m_teamId = cusData.teamId
        self.m_formationId = cusData.formationId
        self.m_colIndex = cusData.colIndex
        self.m_rowIndex = cusData.rowIndex
        if cusData.closeCall then
            self.target = cusData.closeCall.target
            self.closeCallBack = cusData.closeCall.func
            self.mGroup = cusData.closeCall.group
            self.mGroup:SetParent(self.UITrans, false)
            self.mGroup:SetAsFirstSibling()
        end
        local tilePos = self:getManager():getFormationTilePos(self.m_formationId, self.m_colIndex, self.m_rowIndex)
        self.tileFormationHeroVo = self:getManager():getFormationHeroVoByPos(self.m_teamId, tilePos)
    end
    self:__updateView(isInit)
end

function __updateView(self, isInit)
    self.m_sortView:setFilterUseState(false, self.mIsFilterUseState)
    self.m_sortView:setFilterSame(false, self.m_isFilterSame, -10, -600)
    self.m_sortView:addFilterMenu(showBoard.panelFilterTypeList, showBoard.panelFilterTypeDic, self.m_selectFilterDic, self.m_isFindLike, self.m_isFindLock, false)
    self.m_sortView:addSortMenu(showBoard.panelSortTypeList, self.m_selectSortType, self.m_isDescending, false)

    self:recoverListData(self.m_scrollerSelect.DataProvider)
    local scrollList = self:getDataList()
    if isInit == true or self.m_scrollerSelect.Count <= 0 then
        self.m_scrollerSelect.DataProvider = scrollList
    else
        self.m_scrollerSelect:ReplaceAllDataProvider(scrollList)
    end

    local function _onDelayHandler()
        self:__updateGuide()
    end
    if (self.m_actionFrameSn) then
        LoopManager:removeFrameByIndex(self.m_actionFrameSn)
    end
    self.m_actionFrameSn = LoopManager:addFrame(5, 1, self, _onDelayHandler)
end

function getDataList(self)
    -- 通用英雄列表
    local scrollList = {}
    local fomationList = {}
    local heroList, idDic = showBoard.ShowBoardManager:getHeroScrollList(nil, self.m_selectSortType, self.m_isDescending, self.m_selectFilterDic, self.m_isFilterSame, self.mIsFilterUseState, self.m_isFindLike, self.m_isFindLock)
    local showRemoveVo = nil
    for i = 1, #heroList do
        local heroVo = heroList[i]:getDataVo()
        local isShowRemove = false
        if (self.tileFormationHeroVo and self.tileFormationHeroVo.sourceType == formation.HERO_SOURCE_TYPE.OWN
        and self.tileFormationHeroVo.heroId == heroVo.id and self.tileFormationHeroVo:getHeroTid() == heroVo.tid) then
            isShowRemove = true
        end

        local scrollVo = LuaPoolMgr:poolGet(LyScrollerSelectVo)
        scrollVo:setDataVo({ dataVo = heroVo, teamId = self.m_teamId, formationId = self.m_formationId, isShowRemove = isShowRemove, manager = self:getManager() })
        if (isShowRemove) then
            showRemoveVo = scrollVo
        else
            local isInFormation = self:getManager():isHeroInFormation(self.m_teamId, heroVo.id)
            if (isInFormation) then
                table.insert(fomationList, scrollVo)
            else
                local isInAssist = self:getManager():isHeroInAssist(self.m_teamId, heroVo.id)
                if (isInAssist) then
                    table.insert(fomationList, scrollVo)
                else
                    table.insert(scrollList, scrollVo)
                end
            end
        end
    end
    for i, v in pairs(scrollList) do
        table.insert(fomationList, v)
    end

    scrollList = fomationList

    if (showRemoveVo) then
        table.insert(scrollList, 1, showRemoveVo)
    end

    return scrollList
end

function recoverListData(self, list)
    if (list and #list > 0) then
        for i, v in ipairs(list) do
            LuaPoolMgr:poolRecover(v)
        end
    end
end

function __updateGuide(self)
    if (self.m_scrollerSelect.Count > 0) then
        local scrollList = self.m_scrollerSelect.DataProvider
        for i = 0, #scrollList - 1 do
            local data = scrollList[i + 1]:getDataVo()
            local teamId = data.teamId
            local formationId = data.formationId
            local manager = data.manager
            local dataVo = data.dataVo
            if (dataVo) then
                local data = manager:getData()
                -- 是否在显示列表内
                local scrollItem = self.m_scrollerSelect:GetItemLuaClsByIndex(i)
                if (scrollItem and data and type(data) == "table" and data.battleType and data.dupId) then
                    if (data.battleType == PreFightBattleType.MainMapStage) then
                        self:setGuideTrans(string.format("tofight_formation_2_%s_select_head_%s", data.dupId, dataVo.tid), scrollItem:getGuideTrans())
                    end
                end
            end
        end
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(1282):	"是否解除所选战员助战状态，并重新上阵为出战状态？"
]]