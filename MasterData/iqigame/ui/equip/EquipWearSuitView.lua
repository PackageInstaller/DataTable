-- chunkname: @IQIGame\\UI\\Equip\\EquipWearSuitView.lua

local EquipWearSuitView = {
	equipCellList = {}
}
local EquipSuitCell = require("IQIGame.UI.Equip.EquipSuitCell")

function EquipWearSuitView.New(go)
	local o = Clone(EquipWearSuitView)

	o:Initialize(go)

	return o
end

function EquipWearSuitView:Initialize(go)
	self.gameObject = go

	LuaCodeInterface.BindOutlet(go, self)
	self:InitDelegate()

	self.toggleSee = self.toggleSee:GetComponent("Toggle")

	self:OnAddListeners()
end

function EquipWearSuitView:InitDelegate()
	function self.onToggleSeeClick(isOn)
		self:OnToggleSeeClick(isOn)
	end
end

function EquipWearSuitView:OnAddListeners()
	self.toggleSee.onValueChanged:AddListener(self.onToggleSeeClick)
end

function EquipWearSuitView:OnRemoveListeners()
	self.toggleSee.onValueChanged:RemoveListener(self.onToggleSeeClick)
end

function EquipWearSuitView:OnDestroy()
	self:OnRemoveListeners()

	for _, cell in pairs(self.equipCellList) do
		cell:OnDestroy()
	end

	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function EquipWearSuitView:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function EquipWearSuitView:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function EquipWearSuitView:Refresh(cfgEquipSuitArray, id, count, needShowAwakeToggle)
	self.id = id
	self.count = count

	LuaUtility.SetText(self.SuitNameText, cfgEquipSuitArray[1].Name)
	LuaUtility.SetText(self.SuitNumText, string.format("(%s)", count))
	self:RefreshCells(cfgEquipSuitArray, count)
	LuaUtility.SetGameObjectShow(self.toggleSee.gameObject, false)
	LuaUtility.LoadImage(self, EquipApi:GetAwakenBg(not needShowAwakeToggle), self.imageBg:GetComponent("Image"))
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.SuitEffectContent.transform)
end

function EquipWearSuitView:RefreshOnlyAllAwaken(id)
	LuaUtility.SetGameObjectShow(self.toggleSee.gameObject, false)
	LuaUtility.SetGameObjectShow(self.SuitNumText, false)

	local cfgEquipSuitArray = CfgUtil.GetCfgEquipSuitData(id, Constant.Equip.SuitType.Awaken)

	if not cfgEquipSuitArray or #cfgEquipSuitArray <= 0 then
		return
	end

	LuaUtility.SetText(self.SuitNameText, cfgEquipSuitArray[1].Name)
	table.sort(cfgEquipSuitArray, function(a, b)
		return a.Id < b.Id
	end)
	self:RefreshCells(cfgEquipSuitArray, 4)
end

function EquipWearSuitView:_GetCell(index)
	local cell = self.equipCellList[index]

	if not cell then
		local gameObject = UnityEngine.Object.Instantiate(self.SuitEffectItemPrefab, self.SuitEffectContent.transform)

		cell = EquipSuitCell.New(gameObject)
		self.equipCellList[index] = cell
	end

	return cell
end

function EquipWearSuitView:RefreshCells(cfgEquipSuitArray, count)
	local index = 0
	local len = #cfgEquipSuitArray

	for i = 1, len do
		local cell = self:_GetCell(i)

		cell:Refresh(cfgEquipSuitArray[i], count)
		cell:Show()

		index = i
	end

	len = #self.equipCellList

	for i = index + 1, len do
		self.equipCellList[i]:Hide()
	end
end

function EquipWearSuitView:OnToggleSeeClick(isOn)
	EventDispatcher.Dispatch(EventID.ShowAwakenEquipEvent, isOn, {
		self.id
	})
end

return EquipWearSuitView
