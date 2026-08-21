-- chunkname: @IQIGame\\UI\\TransformUI\\TransformUIItemBagPanel.lua

local TransformUIItemBagPanel = {}
local ItemViewClass = require("IQIGame.UI.TransformUI.TransformUIItemBagPanel_ItemView")
local FilterPopupListView = require("IQIGame.UI.Common.CommonSortingPopupListView")

function TransformUIItemBagPanel.New(go, mainView)
	local o = Clone(TransformUIItemBagPanel)

	o:Initialize(go, mainView)

	return o
end

function TransformUIItemBagPanel:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitMember()
	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function TransformUIItemBagPanel:InitMember()
	self.ItemScrollDataArray = {}
	self.ItemScrollViewList = {}
end

function TransformUIItemBagPanel:InitComponent()
	self.itemBagScroll = self.itemBagScroll:GetComponent("OptimizedGridRect")

	self.itemBagScroll:NormalInit(function(OptimizedParams, OptimizedViewsHolder)
		self:OnItemScrollRefresh(OptimizedParams, OptimizedViewsHolder)
	end)

	self.FilterPopupList = FilterPopupListView.New(self.FilterPopup, function(_index)
		self:_OnFilterChange(_index)
	end)

	self.FilterPopupList:SetData({
		[Constant.TransformUIFilterType.All] = "全部",
		[Constant.TransformUIFilterType.LevelMaterial] = CfgUtil.GetCfgTipsTextWithID(230001),
		[Constant.TransformUIFilterType.SkillMaterial] = CfgUtil.GetCfgTipsTextWithID(230002),
		[Constant.TransformUIFilterType.SoulMaterial] = CfgUtil.GetCfgTipsTextWithID(230003)
	}, 1, false)
end

function TransformUIItemBagPanel:InitDelegate()
	function self.RefreshDelegate()
		self:RefreshByFilter(self.CurrentFilterType)
	end
end

function TransformUIItemBagPanel:AddListener()
	EventDispatcher.AddEventListener(EventID.CompositeItemResultEvent, self.RefreshDelegate)
end

function TransformUIItemBagPanel:RemoveListener()
	EventDispatcher.RemoveEventListener(EventID.CompositeItemResultEvent, self.RefreshDelegate)
end

function TransformUIItemBagPanel:Open()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function TransformUIItemBagPanel:Close()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function TransformUIItemBagPanel:OnDestroy()
	self:RemoveListener()

	self.itemBagScroll = nil

	for _, v in pairs(self.ItemScrollViewList) do
		v:OnDestroy()
	end

	self.ItemScrollViewList = {}

	self.FilterPopupList:Dispose()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function TransformUIItemBagPanel:_OnFilterChange(index)
	if index == Constant.TransformUIFilterType.All then
		self:_Refresh(self.Type)
	elseif index == Constant.TransformUIFilterType.LevelMaterial then
		self:_RefreshByFilter(Constant.TransformUIFilterItemType.roleBreakTrough)
	elseif index == Constant.TransformUIFilterType.SkillMaterial then
		self:_RefreshByFilter(Constant.TransformUIFilterItemType.Skill)
	elseif index == Constant.TransformUIFilterType.SoulMaterial then
		self:_RefreshByFilter(Constant.TransformUIFilterItemType.Soul)
	end
end

function TransformUIItemBagPanel:OnItemScrollRefresh(OptimizedParams, OptimizedViewsHolder)
	local viewGameObject = OptimizedViewsHolder.rootGameObject
	local instanceID = OptimizedViewsHolder.instanceID
	local index = OptimizedViewsHolder.ItemIndex
	local data = self.ItemScrollDataArray[index + 1]

	if not self.ItemScrollViewList[instanceID] then
		self.ItemScrollViewList[instanceID] = ItemViewClass.New(viewGameObject, self)
	end

	self.ItemScrollViewList[instanceID]:Refresh(data, index)
end

function TransformUIItemBagPanel:RefreshCompoundItem()
	self:_Refresh(Constant.CombinationType.ItemCombination)

	self.Type = Constant.CombinationType.ItemCombination

	self.FilterPopupList:ChangeSelect(1)
	self.itemBagScroll:SetNormalizedPosition(1)
end

function TransformUIItemBagPanel:RefreshChangeItem()
	self:_Refresh(Constant.CombinationType.ItemTransform)

	self.Type = Constant.CombinationType.ItemTransform

	self.FilterPopupList:ChangeSelect(1)
	self.itemBagScroll:SetNormalizedPosition(1)
end

function TransformUIItemBagPanel:_Refresh(type)
	TransformModule.BeginCheckPrepare()

	self.ItemScrollDataArray = TransformModule.GetCombinationArrayWithType(type)

	self.itemBagScroll:RefreshByItemCount(#self.ItemScrollDataArray)
	TransformModule.EndCheckPrepare()
end

function TransformUIItemBagPanel:_RefreshByFilter(filterType)
	self.ItemScrollDataArray = TransformModule.GetCombinationArrayWithType(self.Type)

	local array = {}
	local len = #self.ItemScrollDataArray

	for i = 1, len do
		local cfgItem = CfgUtil.GetItemCfgDataWithID(self.ItemScrollDataArray[i].Output[1])

		if cfgItem.ItemSubTypes == filterType then
			table.insert(array, self.ItemScrollDataArray[i])
		end
	end

	self.ItemScrollDataArray = array

	self.itemBagScroll:RefreshByItemCount(#self.ItemScrollDataArray)
end

function TransformUIItemBagPanel:SelectTheFirst()
	for _, v in pairs(self.ItemScrollViewList) do
		if v.ItemIndex == 0 then
			v:OnClickBtnGo()

			break
		end
	end
end

function TransformUIItemBagPanel:RefreshByFilter(filterType)
	if filterType == Constant.TransformUIFilterType.All then
		self:_Refresh(self.Type)
	elseif filterType == Constant.TransformUIFilterType.LevelMaterial then
		self:_RefreshByFilter(Constant.TransformUIFilterItemType.roleBreakTrough)
	elseif filterType == Constant.TransformUIFilterType.SkillMaterial then
		self:_RefreshByFilter(Constant.TransformUIFilterItemType.Skill)
	elseif filterType == Constant.TransformUIFilterType.SoulMaterial then
		self:_RefreshByFilter(Constant.TransformUIFilterItemType.Soul)
	end

	self.CurrentFilterType = filterType
end

function TransformUIItemBagPanel:SetCurrentSelectItemID(itemID)
	self.currentSelectItemID = itemID
end

function TransformUIItemBagPanel:GetCurrentSelectItemID()
	return self.currentSelectItemID
end

return TransformUIItemBagPanel
