-------------------------------------------------------------------------------
-- 海外图鉴 - 猫球列表界面
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-08-20 21:49:32
-------------------------------------------------------------------------------

---@type IllustratedHandbookComponent
local illustratedHandbookComp = GameUtils.GetEntityCompByType(ECSComponentType.Constants.IllustratedHandbookComponent)
---@type CatEggComponent
local catBallComp = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CatEggComponent)
---@type CatBallUtils
local CatBallUtils = import("Game.CatBall.CatBallUtils")

local CatBallGridCellPath = 'Game.UI.IllustratedHandbook.IllustratedHandbookCatballListCell'
local CatBallGridCellName = 'IllustbookCatballFilesNode'

--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/IllustratedHandbook/IllustbookCatballListDialog.prefab
---@class IllustratedHandbookCatballListDialog
---@field Env                           	IllustratedHandbookCatballListDialog    
---@field controller                    	Engine.UI.UILuaDialog                   
---@field filterNode                    	UnityEngine.RectTransform               @ 筛选节点
---@field haveNumTxt                    	UnityEngine.RectTransform               @ 拥有数量文本
---@field catBallGridContent            	UnityEngine.RectTransform               @ 猫球网格容器
---@field catBallGridView               	SuperScrollView.LoopGridView            @ 猫球网格视图
---@field rootNode                      	UnityEngine.RectTransform               @ 界面根节点
local IllustratedHandbookCatballListDialog = Class('IllustratedHandbookCatballListDialog')


function IllustratedHandbookCatballListDialog:__init()
    ---@type UICommonFilterMB @ 过滤按钮
    self.collectFilterEnv_ = nil

    ---@type table<Constants.ScreenType, integer[]> @ 过滤结果map（key：收集类型，value：筛选的选择结果）
    self.filterGroupMap_ = {}

    ---@type integer @ 内容容器的偏移值
    self.gridViewOffsetX_ = nil

    ---@type boolean @ 是否自动清除 当前的全部锁定标记
    self.isAutoCleanLocked_ = true
end


function IllustratedHandbookCatballListDialog:__delete()
    self.collectFilterEnv_ = nil
    self.filterGroupMap_   = nil
    self.gridViewOffsetX_  = nil
end


function IllustratedHandbookCatballListDialog:Awake()
    self.collectFilterEnv_ = CfUtils.GetLuaScr(self.filterNode, Constants.UILuaTablePath.ComFilterMB)
    SetGridViewAction(self.catBallGridView, Bind(self, self.OnUpdateCollectGridCellHandler_))
end


function IllustratedHandbookCatballListDialog:OnInitialize()
    return CoWaitDo(function()
        local initParams = CfUtils.DialogSafeParameters(self.controller)

        self.filterGroupMap_  = checkTable(initParams.filterGroupMap)
        self.gridViewOffsetX_ = initParams.gridViewOffsetX

        self:UpdateCollectionProgress_()
        self:UpdateTypeFilterState_()
        self:CreateCollectGridData_()
        self:UpdateCatBallRedPoint_()
    end)
end


function IllustratedHandbookCatballListDialog:OnFinalize()
    return CoWaitDo(function()
        local initParams = self.controller.Argument.parameters or {}
        -- save filterGroupData
        initParams.filterGroupMap = self.filterGroupMap_
        -- save last gridViewOffX
        initParams.gridViewOffsetX = self.catBallGridContent.anchoredPosition.x

        -- 当点击顶部的home按钮时，会跳过OnBackAction的执行，所以为了这种情况需要补调一下
        if self.isAutoCleanLocked_ then
            self:CleanCollectionGridLocked_()
        end

        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


function IllustratedHandbookCatballListDialog:OnBackAction()
    -- 当点击后退按钮时，入口界面会先初始化，再执行这个界面的析构
    -- 所以为了让入口界面初始时已经清空好数据了，所以需要写在后退按钮执行时处理
    self:CleanCollectionGridLocked_()
    -- 如果是后退关闭，则这里清除一次后标记一下，避免析构函数再次执行
    self.isAutoCleanLocked_ = false
end


-------------------------------------------------
-- get / set

---@return table[]
function IllustratedHandbookCatballListDialog:GetCollectGridDataList()
    return checkTable(self.collectGridDataList_)
end
function IllustratedHandbookCatballListDialog:SetCollectGridDataList(gridDataList)
    self.collectGridDataList_ = checkTable(gridDataList)
    self:UpdateCollectionGridView_()
end


-------------------------------------------------
-- private

function IllustratedHandbookCatballListDialog:UpdateTypeFilterState_()
    self.collectFilterEnv_:SetFilterClass(Constants.UIFilterType.HandbookCatBall)
    self.collectFilterEnv_:SetStyleType(2)
    self.collectFilterEnv_:SetDefGroups({})
    self.collectFilterEnv_:SetInitGroups(self.filterGroupMap_)
    self.collectFilterEnv_:FreshCloseShowState()
    self.collectFilterEnv_:SetCallback({}, function()
        self.filterGroupMap_ = self.collectFilterEnv_:GetGroups()
        self:CreateCollectGridData_()
    end)
end


function IllustratedHandbookCatballListDialog:CreateCollectGridData_()
    local collectType    = Constants.HandbookCollectionType.CAT_BALL
    local filterDataMap  = self:FilterCollectCatBallDataMap_()
    local gridDataIdList = table.keys(filterDataMap)
    -- sort dataIdList
    table.sort(gridDataIdList, function(aFilterId, bFilterId)
        local aPriority  = 0
        local bPriority  = 0
        local aDataRefId = checkInt(aFilterId)
        local bDataRefId = checkInt(bFilterId)
        ---@type CatBallVo
        local aCatBallVo = filterDataMap[aFilterId].catBallVo
        ---@type CatBallVo
        local bCatBallVo = filterDataMap[bFilterId].catBallVo
        aPriority = aPriority + (aDataRefId < bDataRefId and 1 or 0)
        bPriority = bPriority + (bDataRefId < aDataRefId and 1 or 0)
        aPriority = aPriority + (aCatBallVo.rare > bCatBallVo.rare and 10 or 0)
        bPriority = bPriority + (bCatBallVo.rare > aCatBallVo.rare and 10 or 0)
        aPriority = aPriority + (illustratedHandbookComp:IsHandbookLocked(collectType, aDataRefId) and 0 or 100)
        bPriority = bPriority + (illustratedHandbookComp:IsHandbookLocked(collectType, bDataRefId) and 0 or 100)
        aPriority = aPriority + (illustratedHandbookComp:IsHandbookOwned(collectType, aDataRefId) and 1000 or 0)
        bPriority = bPriority + (illustratedHandbookComp:IsHandbookOwned(collectType, bDataRefId) and 1000 or 0)
        return aPriority > bPriority
    end)
    -- mapData to list
    local gridDataList = {}
    for dataIndex, dataRefId in ipairs(gridDataIdList) do
        gridDataList[dataIndex] = filterDataMap[dataRefId]
    end
    self:SetCollectGridDataList(gridDataList)
end


---@return table<integer, table>
function IllustratedHandbookCatballListDialog:FilterCollectCatBallDataMap_()
    local dataMap    = {}
    local cellType   = Constants.HandbookCollectionType.CAT_BALL
    local typeDojo   = illustratedHandbookComp:GetHandbookCollectDojo(cellType)
    local filterData = checkTable(self.filterGroupMap_)
    -- check filter
    if next(filterData) ~= nil then
        local rareFilterMap  = {}
        local typeFilterMap  = {}
        local stypeFilterMap = {}
        local otherFilterMap = {}
        for _, rare in ipairs(filterData[Constants.ScreenType.HandbookCatBallRare] or {}) do
            rareFilterMap[tostring(rare)] = true
        end
        for _, type in ipairs(filterData[Constants.ScreenType.HandbookCatBallType] or {}) do
            typeFilterMap[tostring(type)] = true
        end
        for _, stype in ipairs(filterData[Constants.ScreenType.HandbookCatBallSType] or {}) do
            stypeFilterMap[tostring(stype)] = true
        end
        for _, other in ipairs(filterData[Constants.ScreenType.HandbookCatBallOther] or {}) do
            otherFilterMap[tostring(other)] = true
        end
        for refId, _ in pairs(typeDojo.totalMap) do
            local cardBallVo     = CatBallUtils.GetCatBallVo(refId)
            local isOwnedCatBall = illustratedHandbookComp:IsHandbookOwned(cellType, refId)
            local isMatchRare    = next(rareFilterMap) == nil and true or rareFilterMap[tostring(cardBallVo.rare)]
            local isMatchType    = next(typeFilterMap) == nil and true or typeFilterMap[tostring(cardBallVo.types)]
            local isMatchSType   = next(stypeFilterMap) == nil and true or stypeFilterMap[tostring(cardBallVo.subtype)]
            local isMatchOther   = next(otherFilterMap) == nil and true or otherFilterMap[tostring(isOwnedCatBall and 1 or 2)]
            if isMatchRare and isMatchType and isMatchSType and isMatchOther then
                dataMap[checkInt(refId)] = {catBallVo = cardBallVo, typeDojo = typeDojo}
            end
        end
    else
        for refId, _ in pairs(typeDojo.totalMap) do
            dataMap[tostring(refId)] = {catBallVo = CatBallUtils.GetCatBallVo(refId), typeDojo = typeDojo}
        end
    end
    return dataMap
end


function IllustratedHandbookCatballListDialog:UpdateCollectionProgress_()
    local catBallTypeDojo   = illustratedHandbookComp:GetHandbookCollectDojo(Constants.HandbookCollectionType.CAT_BALL)
    local catBallTargetNum  = table.count(catBallTypeDojo.totalMap)
    local catBallCurrentNum = table.count(catBallTypeDojo.ownedMap)
    CfUtils.FillText(self.haveNumTxt, string.fmt('<size=60><color=#20ffed>%1</color></size>/%2', catBallCurrentNum, catBallTargetNum))
end


function IllustratedHandbookCatballListDialog:UpdateCollectionGridView_()
    -- check recover offsetX
    if self.gridViewOffsetX_ then
        -- 防止要做动画
        self.catBallGridView.DisplayItemNumber = self.catBallGridView.DisplayItemCount
        CfUtils.WaitCallbackSafeTo(function()
            CoYield()  -- 需要等待1帧，让reload列表内容计算生效，才能正确移动到目标为止
            self.catBallGridView:MovePanelToItemByIndex(0, self.gridViewOffsetX_ + self.catBallGridView.Padding.left)
            self.gridViewOffsetX_ = nil
        end)
    else
        -- 重新计数动画
        self.catBallGridView.DisplayItemNumber = 0
    end

    -- reload gridView
    local gridDataLength = #self:GetCollectGridDataList()
    GameUtils.ReloadData(self.catBallGridView, gridDataLength)

    -- 如果这里不重置一下的话，保持原地位置反复进出界面，会发现这个列表一直累计偏移值，导致越来越越偏
    self.catBallGridView.ContainerTrans.anchoredPosition3D = Vector3(0,0,0)
    self.catBallGridView:VaildAndSetContainerPos()
end


function IllustratedHandbookCatballListDialog:UpdateCatBallRedPoint_()
    illustratedHandbookComp:CheckHandbookCatBallRedPoint()
end


function IllustratedHandbookCatballListDialog:CleanCollectionGridLocked_()
    local collectType = Constants.HandbookCollectionType.CAT_BALL
    illustratedHandbookComp:CleanHandBookUnlock(collectType)
end


-------------------------------------------------
-- hander

---@param gridView SuperScrollView.LoopGridView
---@param luaIndex integer @ start at 1
---@return SuperScrollView.LoopGridViewItem
function IllustratedHandbookCatballListDialog:OnUpdateCollectGridCellHandler_(gridView, luaIndex)
    local cellNode = gridView:NewListViewItem(CatBallGridCellName)
    local cellData = self:GetCollectGridDataList()[luaIndex]
    ---@type IllustratedHandbookCatballListCell
    local cellEnv = CfUtils.GetLuaScr(cellNode, CatBallGridCellPath)
    if isNotNull(cellEnv) then
        -- init cell
        cellEnv:SetLuaIndex(luaIndex)
        cellEnv:SetCellData(cellData)
        cellEnv:SetClickGridCellCB(Bind(self, self.OnClickCollectionCatBallCellHandler_))
        -- play anim
        if gridView.DisplayItemNumber < gridView.DisplayItemCount then
            cellEnv:PlayDelayAnimByShow(math.floor(gridView.DisplayItemNumber/2))
            gridView.DisplayItemNumber = gridView.DisplayItemNumber + 1
        else
            cellEnv:PlayAnimByIdle()
        end
    end
    return cellNode
end


---@param gridIndex integer @ start at 1
---@param sender IllustratedHandbookCatballListCell
function IllustratedHandbookCatballListDialog:OnClickCollectionCatBallCellHandler_(luaIndex, sender)
    local cellData = checkTable(self:GetCollectGridDataList()[luaIndex])
    
    ---@type CatBallVo
    local catBallVo  = cellData.catBallVo
    local catBallId  = checkInt(catBallVo.roleId)
    local unlockType = Constants.HandbookCollectionType.CAT_BALL
    local isOwned    = illustratedHandbookComp:IsHandbookOwned(unlockType, catBallId)
    local isUnlock   = illustratedHandbookComp:IsHandbookUnlock(unlockType, catBallId)

    -- if not isOwned then
    --     return
    -- end

    -- to unlock
    if not isUnlock then
        -- update cache
        illustratedHandbookComp:UpdateHandbookUnlock(unlockType, catBallId)
    
        -- check redPoint
        self:UpdateCatBallRedPoint_()
    end

    -- to preview
    self.isAutoCleanLocked_ = false
    CfUtils.DialogOpen(Constants.UITypeIds.CatBallPreviewDialog, {catBallId = catBallId}, {{id = Constants.UITypeIds.IllustratedHandbookCatballListDialog}})
end


return IllustratedHandbookCatballListDialog
