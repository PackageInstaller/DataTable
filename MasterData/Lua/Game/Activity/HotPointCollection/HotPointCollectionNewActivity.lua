
--region global define
local isNull    = isNull
local isNotNull = isNotNull
local CfUtils   = CfUtils
--endregion

--region import
---@type HotPointCollectionConstants
local HotPointCollectionConstants = import("Game.Activity.HotPointCollection.HotPointCollectionConstants")

---@type HotPointCollectionComponent
local component = GameUtils.GetEntityCompByType(ECSComponentType.Constants.HotPointCollectionComponent)

--endregion

--region define
local LeftTop = CS.SuperScrollView.ItemCornerEnum.LeftTop
--endregion

--- from: Assets/BundleResources/Prefabs/Hotpoint/HotpointNewActivityDialog.prefab > name: HotpointNewActivityDialog
---@class HotPointCollectionNewActivity
---@field Env                           	HotPointCollectionNewActivity           
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field ImgPage1                      	UnityEngine.RectTransform               
---@field PageLayout                    	UnityEngine.RectTransform               
---@field ScrollView                    	SuperScrollView.LoopListView2           
local HotPointCollectionNewActivity = Class('HotPointCollectionNewActivity')

function HotPointCollectionNewActivity:__init()
    self._currentPage = 1
end


function HotPointCollectionNewActivity:__delete()

end


function HotPointCollectionNewActivity:Awake()
    self._pageNodes = {self.ImgPage1.gameObject}
end


-- function HotPointCollectionNewActivity:Start()
-- end


function HotPointCollectionNewActivity:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

function HotPointCollectionNewActivity:FreshUI(viewType)
    self._viewType = viewType
    local dataList   = self:GetDataList()
    local count      = math.ceil(#dataList / HotPointCollectionConstants.ActivityPageCellCount)
    self:FreshScrollView(count)
    self:FreshPageLayout(count)

end

function HotPointCollectionNewActivity:FreshScrollView(count)
    local ScrollView = self.ScrollView
    if not ScrollView.IsListViewInit then
        local initParam = CS.SuperScrollView.LoopListViewInitParam.CopyDefaultInitParam()
        initParam.mSnapVecThreshold = 99999
        --self.PageView.mOnBeginDragAction = OnBeginDrag
        --self.PageView.mOnDragingAction = OnDraging
        ScrollView.mOnEndDragAction = Bind(self, self.OnEndDrag)
        ScrollView.mOnSnapNearestChanged = Bind(self, self.OnSnapNearestChanged)
        ScrollView:InitListView(count, Bind(self, self.OnGetItemByIndex), initParam)
    else
        GameUtils.ReloadData(ScrollView, count)
    end

end

function HotPointCollectionNewActivity:OnSnapNearestChanged(listView, item)
    self:UpdateDots()
end

function HotPointCollectionNewActivity:OnEndDrag()
    local ScrollView = self.ScrollView
    local vec = ScrollView.ScrollRect.velocity.x
    local curNearestItemIndex = ScrollView.CurSnapNearestItemIndex
    local item = ScrollView:GetShownItemByItemIndex(curNearestItemIndex)
    if isNull(item) then
        ScrollView:ClearSnapData()
        return
    end
    
    if Mathf.Abs(vec) < 50 then
        ScrollView:SetSnapTargetItemIndex(curNearestItemIndex)
        return
    end
    local pos = ScrollView:GetItemCornerPosInViewPort(item, LeftTop)
    if pos.x > 0 then
        if vec > 0 then
            ScrollView:SetSnapTargetItemIndex(curNearestItemIndex - 1)
        else
            ScrollView:SetSnapTargetItemIndex(curNearestItemIndex)
        end
    elseif pos.x < 0 then
        if vec > 0 then
            ScrollView:SetSnapTargetItemIndex(curNearestItemIndex)
        else
            ScrollView:SetSnapTargetItemIndex(curNearestItemIndex + 1)
        end
    else
        if vec > 0 then
            ScrollView:SetSnapTargetItemIndex(curNearestItemIndex - 1)
        else
            ScrollView:SetSnapTargetItemIndex(curNearestItemIndex + 1)
        end
    end
end

function HotPointCollectionNewActivity:UpdateDots()
    local curNearestItemIndex = self.ScrollView.CurSnapNearestItemIndex
    if curNearestItemIndex < 0 or curNearestItemIndex > HotPointCollectionConstants.ActivityPageCellCount then
        return
    end
    local pageNodes = self._pageNodes
    if curNearestItemIndex > #pageNodes then
        return
    end
    self._currentPage = curNearestItemIndex + 1
    for i = 1, #pageNodes do
        local go = pageNodes[i]
        if i == self._currentPage then
            CfUtils.SetUISwitchImage(go, 2)
        else
            CfUtils.SetUISwitchImage(go, 1)
        end
    end
end

function HotPointCollectionNewActivity:OnGetItemByIndex(listView, index)
    if index < 0 then
        return nil
    end
    local cell = listView:NewListViewItem(HotPointCollectionConstants.DefineName.ItemCell)
    local node = GetLuaBehaviour(cell.gameObject, HotPointCollectionConstants.EnvPath.HotPointCollectionNewActivityItemCell)
    
    ---@type HotPointCollectionNewActivityItemCell
    local nodeEnv
    if not cell.IsInitHandlerCalled then
        cell.IsInitHandlerCalled = true
        node:Init()
        nodeEnv = node.Env
    else
        nodeEnv = node.Env
    end

    if nodeEnv then
        local dataList = self:GetDataList()
        nodeEnv:FreshUI(dataList, index, HotPointCollectionConstants.ActivityPageCellCount)

    end

    return cell
end

function HotPointCollectionNewActivity:FreshPageLayout(count)
    local nodeCount = #self._pageNodes
    local forTimes  = math.max(nodeCount, count)
    local parent    = self.PageLayout.gameObject
    for i = 1, forTimes do
        local pageNode = self._pageNodes[i]
        local isShow = count >= i
        local isExist = isNotNull(pageNode)
        if isShow then
            if not isExist then
                pageNode = parent:AddChild(self._pageNodes[1])
                self._pageNodes[i] = pageNode
            end
            CfUtils.SetActive(pageNode, true)
            CfUtils.SetUISwitchImage(pageNode, self._currentPage == i and 2 or 1)

        elseif isExist then
            CfUtils.SetActive(pageNode, false)
            
        end
    end

end

--endregion 


--region get/set 


---endregion 

function HotPointCollectionNewActivity:GetDataList()
    if self._viewType == HotPointCollectionConstants.ViewType.NewActivity then
        return component:GetActivityList()
    elseif self._viewType == HotPointCollectionConstants.ViewType.NewFunction then
        return component:GetModuleList()
    end
end

--region handler 


---endregion 


return HotPointCollectionNewActivity
