-------------------------------------------------------------------------------
-- 海外图鉴 - 主界面
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-04-10 14:59:00
-------------------------------------------------------------------------------

---@type IllustratedHandbookComponent
local illustratedHandbookComp = GameUtils.GetEntityCompByType(ECSComponentType.Constants.IllustratedHandbookComponent)
---@type CardConfMgr
local cardConfMgr = CardConfMgr:GetInstance()

local TypeCellNodePath = 'Game.UI.IllustratedHandbook.IllustratedHandbookCardArchivesTypeListCell'
local TypeCellNodeName = 'LabelNode'

local CollectionTypeDefines = {}
if Constants.HandbookCollectionType.ROLE ~= nil then
    CollectionTypeDefines[Constants.HandbookCollectionType.ROLE] = {
        cellSourcePath = 'Game.UI.IllustratedHandbook.IllustratedHandbookCardArchivesGridRoleCell',
        cellSourceName = 'RoleCell',
        dataFilterFunc = 'FilterCollectRoleDataMap_',
        cellClickFunc  = 'OnClickCollectionRoleCellHandler_',
        filterType     = Constants.UIFilterType.HandbookRole,
        redCheckFunc   = Bind(illustratedHandbookComp, illustratedHandbookComp.CheckHandbookRoleRedPoint),
    }
end
if Constants.HandbookCollectionType.SKIN ~= nil then
    CollectionTypeDefines[Constants.HandbookCollectionType.SKIN] = {
        cellSourcePath = 'Game.UI.IllustratedHandbook.IllustratedHandbookCardArchivesGridSkinCell',
        cellSourceName = 'FashionCell',
        dataFilterFunc = 'FilterCollectSkinDataMap_',
        cellClickFunc  = 'OnClickCollectionSkinCellHandler_',
        filterType     = Constants.UIFilterType.HandbookSkin,
        redCheckFunc   = Bind(illustratedHandbookComp, illustratedHandbookComp.CheckHandbookSkinRedPoint),
    }
end
if Constants.HandbookCollectionType.CAT ~= nil then
    CollectionTypeDefines[Constants.HandbookCollectionType.CAT] = {
        cellSourcePath = 'Game.UI.IllustratedHandbook.IllustratedHandbookCardArchivesGridCatCell',
        cellSourceName = 'CatCell',
        dataFilterFunc = 'FilterCollectCatDataMap_',
        cellClickFunc  = 'OnClickCollectionCatCellHandler_',
        redCheckFunc   = Bind(illustratedHandbookComp, illustratedHandbookComp.CheckHandbookCatRedPoint),
    }
end

--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/IllustratedHandbook/IllustratedHandbookMainDialog.prefab > name: IllustratedHandbookMainDialog
---@class IllustratedHandbookMainDialog
---@field Env                           	IllustratedHandbookMainDialog           
---@field controller                    	Engine.UI.UILuaDialog                   
---@field CellScrollViewContent         	UnityEngine.RectTransform               	@ 0    收集内容列表容器
---@field CellScrollView                	SuperScrollView.LoopGridView            	@ 1    收集内容列表
---@field FilterNode                    	UnityEngine.RectTransform               	@ 2    筛选过滤按钮
---@field TypeScrollView                	SuperScrollView.LoopListView2           	@ 3    类型滚动列表
---@field RootNode                      	UnityEngine.RectTransform               	@ 4    界面的根节点
---@field BtnEmpty                      	UnityEngine.RectTransform               	@ 5    "深度互动" 和谐模式 解禁秘密按钮
local IllustratedHandbookMainDialog = Class('IllustratedHandbookMainDialog')


function IllustratedHandbookMainDialog:__init()
    ---@type UICommonFilterMB @ 过滤按钮
    self.collectionFilterEnv_ = nil

    ---@type table<Constants.HandbookCollectionType, table<Constants.ScreenType, integer[]>> @ 过滤结果map（key：收集类型，value：筛选的选择结果）
    self.filterGroupDataMap_ = {}

    ---@type string @ 当前的 内容单元名字
    self.gridCellSourceName_ = nil
    
    ---@type string @ 当前的 内容单元路径
    self.gridCellSourcePath_ = nil
    
    ---@type fun():table<integer, table> @ 当前的 内容数据过滤方法
    self.gridDataFilterFunc_ = nil

    ---@type fun(gridIndex:integer):void @ 当前的 内容单元点击回调
    self.gridCellClickFunc_ = nil

    ---@type boolean @ 是否自动清除 当前的全部锁定标记
    self.isAutoCleanLocked_ = true
end


function IllustratedHandbookMainDialog:__delete()
    self.collectionFilterEnv_ = nil
    self.filterGroupDataMap_  = nil
    self.gridDataFilterFunc_  = nil
    self.gridCellSourceName_  = nil
    self.gridCellSourcePath_  = nil
    self.gridCellClickFunc_   = nil
    self.isAutoCleanLocked_   = nil
end


function IllustratedHandbookMainDialog:Awake()
    self.collectionFilterEnv_ = CfUtils.GetLuaScr(self.FilterNode, Constants.UILuaTablePath.ComFilterMB)

    SetListViewAction(self.TypeScrollView, Bind(self, self.OnUpdateTypeListCellHandler_), TypeCellNodeName)
    SetGridViewAction(self.CellScrollView, Bind(self, self.OnUpdateCollectionGridCellHandler_))

    -- "深度互动" 和谐模式 解禁秘密按钮:
    CfUtils.SetActive(self.BtnEmpty.gameObject, true)
    SetButtonAction(self.BtnEmpty, Bind(self, self.OnClickBtnEmpty))
    self.live3DSecretBtnEnv = AddLuaBehaviour(self.BtnEmpty.gameObject, "Game.IdolLive3D.IdolLive3D_SecretBtn").Env
end


function IllustratedHandbookMainDialog:OnInitialize()
    return CoWaitDo(function()
        local initParams = CfUtils.DialogSafeParameters(self.controller)

        -- load filterGroupData
        self.filterGroupDataMap_ = checkTable(initParams.filterGroupData)
        
        -- update views
        self:UpdateTypeListData_()

        local initTypeSelectIndex = initParams.typeSelectIndex or Constants.HandbookCollectionType.ROLE
        self:SetTypeSelectIndex(initTypeSelectIndex)
    end)
end


function IllustratedHandbookMainDialog:OnFinalize()
    return CoWaitDo(function()
        local initParams = self.controller.Argument.parameters or {}
        initParams.typeSelectIndex = self:GetTypeSelectIndex()
        initParams.gridViewOffsetX = self.CellScrollViewContent.anchoredPosition.x
        initParams.filterGroupData = clone(self.filterGroupDataMap_)

        -- 当点击顶部的home按钮时，会跳过OnBackAction的执行，所以为了这种情况需要补调一下
        if self.isAutoCleanLocked_ then
            self:CleanCollectionGridLocked_()
        end

        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


function IllustratedHandbookMainDialog:OnBackAction()
    -- 当点击后退按钮时，入口界面会先初始化，再执行这个界面的析构
    -- 所以为了让入口界面初始时已经清空好数据了，所以需要写在后退按钮执行时处理
    self:CleanCollectionGridLocked_()
    -- 如果是后退关闭，则这里清除一次后标记一下，避免析构函数再次执行
    self.isAutoCleanLocked_ = false
end


-------------------------------------------------
-- get / set

---@return table[]
function IllustratedHandbookMainDialog:GetTypeDataList()
    return checkTable(self.typeDataList_)
end
function IllustratedHandbookMainDialog:SetTypeDataList(dataList)
    self.typeDataList_ = checkTable(dataList)
    self:UpdateTypeListView_()
end


---@return integer
function IllustratedHandbookMainDialog:GetTypeSelectIndex()
    return checkInt(self.typeSelectIndex_)
end
function IllustratedHandbookMainDialog:SetTypeSelectIndex(selectIndex)
    local oldSelectIndex  = self:GetTypeSelectIndex()
    self.typeSelectIndex_ = checkInt(selectIndex)
    self:UpdateTypeSelectIndex_(oldSelectIndex)
end


---@return table[]
function IllustratedHandbookMainDialog:GetCollectionGridData()
    return checkTable(self.collectionGridData_)
end
function IllustratedHandbookMainDialog:SetCollectionGridData(gridData)
    self.collectionGridData_ = checkTable(gridData)
    self:UpdateCollectionGridView_()
end


-------------------------------------------------
-- private

function IllustratedHandbookMainDialog:UpdateTypeListData_()
    local collectTypeList = {}
    if Constants.HandbookCollectionType.ROLE ~= nil then
        table.insert(collectTypeList, Constants.HandbookCollectionType.ROLE)
    end
    if Constants.HandbookCollectionType.SKIN ~= nil then
        ---@type SDKService
        local SDKService = import('Game.Entry.SDKService')
        if not (SDKService:GetInstance():IsDuoLe() and checkInt(IS_REVIEW_INT) > 0) then
            table.insert(collectTypeList, Constants.HandbookCollectionType.SKIN)
        end
        
    end
    if Constants.HandbookCollectionType.CAT ~= nil then
        table.insert(collectTypeList, Constants.HandbookCollectionType.CAT)
    end
    local typeDataList = {}
    for typeIndex, collectType in ipairs(collectTypeList) do
        typeDataList[typeIndex] = {
            collectType  = collectType,
            redCheckFunc = CollectionTypeDefines[checkInt(collectType)].redCheckFunc,
            collectDojo  = illustratedHandbookComp:GetHandbookCollectDojo(collectType),
        }
    end
    self:SetTypeDataList(typeDataList)
end


function IllustratedHandbookMainDialog:UpdateCollectionGridData_()
    local filterDataMap  = self.gridDataFilterFunc_()
    local filterIdList   = table.keys(filterDataMap)
    local selectTypeData = checkTable(self:GetTypeDataList()[self:GetTypeSelectIndex()])
    table.sort(filterIdList, function(aFilterId, bFilterId)
        local aPriority = 0
        local bPriority = 0
        local aRefId    = checkInt(aFilterId)
        local bRefId    = checkInt(bFilterId)
        aPriority = aPriority + (aRefId < bRefId and 1 or 0)
        bPriority = bPriority + (bRefId < aRefId and 1 or 0)
        aPriority = aPriority + (illustratedHandbookComp:IsHandbookLocked(selectTypeData.collectType, aRefId) and 0 or 10)
        bPriority = bPriority + (illustratedHandbookComp:IsHandbookLocked(selectTypeData.collectType, bRefId) and 0 or 10)
        aPriority = aPriority + (illustratedHandbookComp:IsHandbookOwned(selectTypeData.collectType, aRefId) and 100 or 0)
        bPriority = bPriority + (illustratedHandbookComp:IsHandbookOwned(selectTypeData.collectType, bRefId) and 100 or 0)
        return aPriority > bPriority
    end)
    local filterGridData = {}
    for dataIndex, dataRefId in ipairs(filterIdList) do
        filterGridData[dataIndex] = filterDataMap[dataRefId]
    end
    self:SetCollectionGridData(filterGridData)
end


---@return table<integer, CardVo>
function IllustratedHandbookMainDialog:FilterCollectRoleDataMap_()
    local dataMap    = {}
    local cellType   = Constants.HandbookCollectionType.ROLE
    local typeData   = checkTable(self:GetTypeDataList()[cellType])
    local filterData = checkTable(self.filterGroupDataMap_[cellType])
    -- check filter
    if next(filterData) == nil then
        for refId, _ in pairs(typeData.collectDojo.totalMap) do
            dataMap[checkInt(refId)] = {refId = refId, cardVo = cardConfMgr:GetCardByRefId(refId)}
        end
    else
        local rareFilterMap  = {}
        local attrFilterMap  = {}
        local raceFilterMap  = {}
        local otherFilterMap = {}
        for _, rare in ipairs(filterData[Constants.ScreenType.HandbookRoleRare] or {}) do
            rareFilterMap[tostring(rare)] = true
        end
        for _, attr in ipairs(filterData[Constants.ScreenType.HandbookRoleAttr] or {}) do
            attrFilterMap[tostring(attr)] = true
        end
        for _, race in ipairs(filterData[Constants.ScreenType.HandbookRoleRace] or {}) do
            raceFilterMap[tostring(race)] = true
        end
        for _, other in ipairs(filterData[Constants.ScreenType.HandbookRoleOther] or {}) do
            otherFilterMap[tostring(other)] = true
        end
        for refId, _ in pairs(typeData.collectDojo.totalMap) do
            local cardVo       = cardConfMgr:GetCardByRefId(refId)
            local isOwnedRole  = illustratedHandbookComp:IsHandbookOwned(cellType, refId)
            local isMatchRare  = next(rareFilterMap) == nil and true or rareFilterMap[tostring(cardVo.rare)]
            local isMatchRace  = next(raceFilterMap) == nil and true or raceFilterMap[tostring(cardVo.race)]
            local isMatchAttr  = next(attrFilterMap) == nil and true or attrFilterMap[tostring(cardVo.attributeType)]
            local isMatchOther = next(otherFilterMap) == nil and true or otherFilterMap[tostring(isOwnedRole and 1 or 2)]
            if isMatchRare and isMatchRace and isMatchAttr and isMatchOther then
                dataMap[checkInt(cardVo.roleId)] = {refId = refId, cardVo = cardVo}
            end
        end
    end
    return dataMap
end


---@return table<integer, CardSkinVo>
function IllustratedHandbookMainDialog:FilterCollectSkinDataMap_()
    local dataMap    = {}
    local cellType   = Constants.HandbookCollectionType.SKIN
    local typeData   = checkTable(self:GetTypeDataList()[cellType])
    local filterData = checkTable(self.filterGroupDataMap_[cellType])
    -- check filter
    if next(filterData) == nil then
        for refId, _ in pairs(typeData.collectDojo.totalMap) do
            dataMap[checkInt(refId)] = {refId = refId, skinVo = cardConfMgr:GetCardSkinBySkinId(refId)}
        end
    else
        local tagFilterMap   = {}
        local otherFilterMap = {}
        for _, tag in ipairs(filterData[Constants.ScreenType.HandbookSkinTag] or {}) do
            tagFilterMap[tostring(tag)] = true
        end
        for _, other in ipairs(filterData[Constants.ScreenType.HandbookSkinOther] or {}) do
            otherFilterMap[tostring(other)] = true
        end
        for refId, _ in pairs(typeData.collectDojo.totalMap) do
            local skinVo       = cardConfMgr:GetCardSkinBySkinId(refId)
            local isOwnedSkin  = illustratedHandbookComp:IsHandbookOwned(cellType, refId)
            local isMatchRare  = next(tagFilterMap) == nil and true or tagFilterMap[tostring(skinVo.tag)]
            local isMatchOther = next(otherFilterMap) == nil and true or otherFilterMap[tostring(isOwnedSkin and 1 or 2)]
            if isMatchRare and isMatchOther then
                dataMap[skinVo.skinId] = {refId = refId, skinVo = skinVo}
            end
        end
    end
    return dataMap
end


---@return table<integer, CatTypeVo>
function IllustratedHandbookMainDialog:FilterCollectCatDataMap_()
    local dataMap    = {}
    local cellType   = Constants.HandbookCollectionType.CAT
    local typeData   = checkTable(self:GetTypeDataList()[cellType])
    local filterData = checkTable(self.filterGroupDataMap_[cellType])
    for refId, _ in pairs(typeData.collectDojo.totalMap) do
        dataMap[checkInt(refId)] = {refId = refId, typeVo = cardConfMgr:GetCatTypeVoById(refId)}
    end
    return dataMap
end


-------------------------------------------------------------------------------
-- update type view
-------------------------------------------------------------------------------

function IllustratedHandbookMainDialog:UpdateTypeListView_()
    local initParams = self.controller.Argument.parameters or {}
    if initParams.typeSelectIndex ~= nil then
        -- 防止要做动画
        self.TypeScrollView.DisplayItemNumber = self.TypeScrollView.DisplayItemCount
    end

    -- reload listView
    local typeDataLength = #self:GetTypeDataList()
    GameUtils.ReloadData(self.TypeScrollView, typeDataLength)
end


function IllustratedHandbookMainDialog:UpdateTypeSelectIndex_(oldSelectIndex)
    local newSelectIndex = self:GetTypeSelectIndex()
    local selectTypeData = checkTable(self:GetTypeDataList()[newSelectIndex])
    local collTypeDefine = CollectionTypeDefines[checkInt(selectTypeData.collectType)]

    -- update vars
    self.gridCellSourceName_ = collTypeDefine.cellSourceName
    self.gridCellSourcePath_ = collTypeDefine.cellSourcePath
    self.gridDataFilterFunc_ = Bind(self, self[collTypeDefine.dataFilterFunc])
    self.gridCellClickFunc_  = Bind(self, self[collTypeDefine.cellClickFunc])

    -- update views
    local oldTypeCellNode = self.TypeScrollView:GetShownItemByItemIndex(oldSelectIndex - 1)
    local newTypeCellNode = self.TypeScrollView:GetShownItemByItemIndex(newSelectIndex - 1)
    if isNotNull(oldTypeCellNode) then
        ---@type IllustratedHandbookCardArchivesTypeListCell
        local oldTypeCellEnv = CfUtils.GetLuaScr(oldTypeCellNode, TypeCellNodePath)
        oldTypeCellEnv:SetSelected(false)
    end
    if isNotNull(newTypeCellNode) then
        ---@type IllustratedHandbookCardArchivesTypeListCell
        local newTypeCellEnv = CfUtils.GetLuaScr(newTypeCellNode, TypeCellNodePath)
        newTypeCellEnv:SetSelected(true)
    end
    self:UpdateCollectionGridData_()

    -- reset filter 
    local typeFilterType = checkInt(collTypeDefine.filterType)
    if typeFilterType > 0 then
        local selectTypeId = checkInt(selectTypeData.collectType)
        local nowGroupData = checkTable(self.filterGroupDataMap_[selectTypeId])
        self.collectionFilterEnv_:SetFilterClass(typeFilterType)
        self.collectionFilterEnv_:SetStyleType(2)
        self.collectionFilterEnv_:SetDefGroups({})
        self.collectionFilterEnv_:SetInitGroups(nowGroupData)
        self.collectionFilterEnv_:FreshCloseShowState()
        self.collectionFilterEnv_:SetCallback({}, function()
            self.filterGroupDataMap_[selectTypeId] = self.collectionFilterEnv_:GetGroups()
            self:UpdateCollectionGridData_()
        end)
    end
    CfUtils.SetActive(self.FilterNode, typeFilterType > 0)
end


function IllustratedHandbookMainDialog:CheckSelectTypeRedPoint_()
    local typeCellNode = self.TypeScrollView:GetShownItemByItemIndex(self:GetTypeSelectIndex() - 1)
    if isNotNull(typeCellNode) then
        ---@type IllustratedHandbookCardArchivesTypeListCell
        local typeCellEnv = CfUtils.GetLuaScr(typeCellNode, TypeCellNodePath)
        typeCellEnv:UpdateRedPointState()
    end
end


-------------------------------------------------------------------------------
-- update grid view
-------------------------------------------------------------------------------

function IllustratedHandbookMainDialog:UpdateCollectionGridView_()
    -- check recover offsetX
    local initParams = self.controller.Argument.parameters or {}
    if initParams.gridViewOffsetX ~= nil then
        -- 防止要做动画
        self.CellScrollView.DisplayItemNumber = self.CellScrollView.DisplayItemCount
        CfUtils.WaitCallbackSafeTo(function()
            CoYield()  -- 需要等待1帧，让reload列表内容计算生效，才能正确移动到目标为止
            self.CellScrollView:MovePanelToItemByIndex(0, initParams.gridViewOffsetX + self.CellScrollView.Padding.left)
            initParams.gridViewOffsetX = nil
        end)
    else
        -- 重新计数动画
        self.CellScrollView.DisplayItemNumber = 0
        self.CellScrollView:MovePanelToItemByIndex(0)  -- 因为3中cell复用的容器，所以切换类型后，需要先重置回0位置
    end

    -- reload gridView
    local gridDataLength = #self:GetCollectionGridData()
    GameUtils.ReloadData(self.CellScrollView, gridDataLength)

    -- 因为之前没有碰到多个cell切换复用的先例，所以这次碰到了再次刷新时 Padding 的设置计算让内容发生向内偏移的情况，故此手动重置一下坐标来解决。
    self.CellScrollView.ContainerTrans.anchoredPosition3D = Vector3(0,0,0)
    self.CellScrollView:VaildAndSetContainerPos()
end


function IllustratedHandbookMainDialog:CleanCollectionGridLocked_()
    local selectTypeData = checkTable(self:GetTypeDataList()[self:GetTypeSelectIndex()])
    local collectType    = checkInt(selectTypeData.collectType)
    if collectType > 0 then
        illustratedHandbookComp:CleanHandBookUnlock(collectType)
    end
end


-------------------------------------------------
-- handler

---@param listView SuperScrollView.LoopListView2
---@param luaIndex integer @ start at 1
---@return SuperScrollView.LoopListViewItem2
function IllustratedHandbookMainDialog:OnUpdateTypeListCellHandler_(listView, luaIndex)
    local cellNode = listView:NewListViewItem(TypeCellNodeName)
    local cellData = checkTable(self:GetTypeDataList()[luaIndex])
    ---@type IllustratedHandbookCardArchivesTypeListCell
    local cellEnv = CfUtils.GetLuaScr(cellNode, TypeCellNodePath)
    if isNotNull(cellNode) then
        -- init cell
        cellEnv:SetLuaIndex(luaIndex)
        cellEnv:SetCellData(cellData)
        cellEnv:SetSelected(self:GetTypeSelectIndex() == luaIndex)
        cellEnv:SetClickTypeCellCB(Bind(self, self.OnClickTypeListCellHandler_))
        -- play anim
        if listView.DisplayItemNumber < listView.DisplayItemCount then
            cellEnv:PlayDelayAnimByShow(listView.DisplayItemNumber)
            listView.DisplayItemNumber = listView.DisplayItemNumber + 1
        else
            cellEnv:PlayAnimByIdle()
        end
    end
    return cellNode
end


function IllustratedHandbookMainDialog:OnClickTypeListCellHandler_(listIndex)
    if self:GetTypeSelectIndex() ~= listIndex then
        -- 切换类型时，先清除当前的待解锁记录
        self:CleanCollectionGridLocked_()
        self:CheckSelectTypeRedPoint_()
        self:SetTypeSelectIndex(listIndex)
    end
end


---@param gridView SuperScrollView.LoopGridView
---@param gridIndex integer @ start at 1
---@return SuperScrollView.LoopGridViewItem
function IllustratedHandbookMainDialog:OnUpdateCollectionGridCellHandler_(gridView, luaIndex)
    local cellNode = gridView:NewListViewItem(self.gridCellSourceName_)
    local cellData = checkTable(self:GetCollectionGridData()[luaIndex])
    ---@type IllustratedHandbookCardArchivesGridRoleCell | IllustratedHandbookCardArchivesGridSkinCell | IllustratedHandbookCardArchivesGridCatCell
    local cellEnv = CfUtils.GetLuaScr(cellNode, self.gridCellSourcePath_)
    if isNotNull(cellNode) then
        -- init cell
        cellEnv:SetLuaIndex(luaIndex)
        cellEnv:SetCellData(cellData)
        cellEnv:SetClickGridCellCB(self.gridCellClickFunc_)
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
function IllustratedHandbookMainDialog:OnClickCollectionRoleCellHandler_(gridIndex)
    local cellData  = checkTable(self:GetCollectionGridData()[gridIndex])
    local dataRefId = checkInt(cellData.refId)

    self:DoClickCollectionCellHandler_(gridIndex, dataRefId, function()
        self.isAutoCleanLocked_ = false
        local GachaponUtils = import('Game.Gachapon.GachaponUtils')
        GachaponUtils.OpenDetail(dataRefId, {{id = Constants.UITypeIds.IllustratedHandbookMainDialog}}, {handbookMode = true})
    end)
end


---@param gridIndex integer @ start at 1
function IllustratedHandbookMainDialog:OnClickCollectionSkinCellHandler_(gridIndex)
    local cellData  = checkTable(self:GetCollectionGridData()[gridIndex])
    local dataRefId = checkInt(cellData.refId)

    self:DoClickCollectionCellHandler_(gridIndex, dataRefId, function()
        self.isAutoCleanLocked_ = false
        CfUtils.DialogOpen(Constants.UITypeIds.CommonStylePreView, {skinId = dataRefId}, {{id = Constants.UITypeIds.IllustratedHandbookMainDialog}})
    end)
end


---@param gridIndex integer @ start at 1
function IllustratedHandbookMainDialog:OnClickCollectionCatCellHandler_(gridIndex)
    local cellData  = checkTable(self:GetCollectionGridData()[gridIndex])
    local dataRefId = checkInt(cellData.refId)

    self:DoClickCollectionCellHandler_(gridIndex, dataRefId, function()
        self.isAutoCleanLocked_ = false
        CfUtils.DialogOpen(Constants.UITypeIds.CardCatTypePreviewDialog, {catTypeId = dataRefId}, {{id = Constants.UITypeIds.IllustratedHandbookMainDialog}})
    end)
end


---@param gridIndex integer @ start at 1
---@param refId integer
---@param previewCb fun():void | nil
function IllustratedHandbookMainDialog:DoClickCollectionCellHandler_(gridIndex, refId, previewCb)
    local selectTypeData = checkTable(self:GetTypeDataList()[self:GetTypeSelectIndex()])
    local unlockType     = selectTypeData.collectType
    local isCellOwned    = illustratedHandbookComp:IsHandbookOwned(unlockType, refId)
    local isCellUnlock   = illustratedHandbookComp:IsHandbookUnlock(unlockType, refId)

    -- if not isCellOwned then
    --     return
    -- end

    if not isCellUnlock then
        -- update cache
        illustratedHandbookComp:UpdateHandbookUnlock(unlockType, refId)

        -- check selectType redPoint
        self:CheckSelectTypeRedPoint_()
    end

    -- do preview callback
    if previewCb then previewCb() end
end



function IllustratedHandbookMainDialog:OnClickBtnEmpty()
    self.live3DSecretBtnEnv:OnClickBtn()
end


return IllustratedHandbookMainDialog
