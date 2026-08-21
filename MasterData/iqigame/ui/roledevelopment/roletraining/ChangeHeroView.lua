-- chunkname: @IQIGame\\UI\\RoleDevelopment\\RoleTraining\\ChangeHeroView.lua

local m = {
	HeroList = {},
	HeroItemList = {},
	itemList = {}
}
local changeHeroItem = require("IQIGame.UI.RoleDevelopment.ItemCell.ChangeHeroItem")

function m.New(view, callBack)
	local obj = Clone(m)

	obj:Init(view, callBack)

	return obj
end

function m:Init(view, callBack)
	self.View = view
	self.CloseCallBack = callBack

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickCloseBtn()
		self:Hide()
	end

	self.wrapContent = self.HeroScroll:GetComponent("ScrollAreaList")

	function self.wrapContent.onRenderCell(cell)
		self:OnRenderGridCell(cell)
	end

	function self.wrapContent.onSelectedCell(cell)
		self:OnSelectedGridCell(cell)
	end

	self:AddListeners()
end

function m:AddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function m:RemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function m:SetData(heroList, heroCid)
	self.HeroList = heroList
	self.SelectHeroCid = heroCid

	self.wrapContent:Refresh(#self.HeroList)
end

function m:OnRenderGridCell(cell)
	local itemData = self.HeroList[cell.index + 1]
	local instanceId = cell.gameObject:GetInstanceID()
	local item = self.itemList[instanceId]

	if item == nil then
		item = changeHeroItem.New(cell.gameObject)
		self.itemList[instanceId] = item
	end

	item:SetData(itemData, self.SelectHeroCid)

	if itemData.cid == self.SelectHeroCid then
		self:OnSelectedGridCell(cell)
	end
end

function m:OnSelectedGridCell(cell)
	self:CancelAllSelected()

	local instanceId = cell.gameObject:GetInstanceID()
	local itemCell = self.itemList[instanceId]

	itemCell:Selected()

	local itemData = self.HeroList[cell.index + 1]

	EventDispatcher.Dispatch(EventID.ChangeHeroEvent, itemData.cid)

	self.SelectHeroCid = itemData.cid
end

function m:CancelAllSelected()
	for k, v in pairs(self.itemList) do
		v:UnSelect()
	end
end

function m:Show()
	self.View:SetActive(true)
end

function m:Hide()
	self.View:SetActive(false)

	if self.CloseCallBack then
		self.CloseCallBack()
	end
end

function m:Dispose()
	self:RemoveListeners()

	for k, v in pairs(self.itemList) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
