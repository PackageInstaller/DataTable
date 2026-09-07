local IslandSlotHudView = class("IslandSlotHudView", import(".IslandBaseOpView"))
local var_0_1 = 4

function IslandSlotHudView:GetUIName()
	return "IslandSlotHudUI"
end

function IslandSlotHudView:GetUIParent(arg_2_1)
	return self:GetView().hudContainer
end

function IslandSlotHudView:OnInit(arg_3_1)
	self._go = arg_3_1
	self._tf = arg_3_1.transform
	self.parent = self._tf:Find("look")
	self.hideHudDic = {}
	self.unitHideHudQueue = {}

	return
end

function IslandSlotHudView:Update()
	if self.currentHud then
		self.currentHud:Update()
	end

	return
end

function IslandSlotHudView:LateUpdate()
	if self.currentHud then
		self.currentHud:LateUpdate()
	end

	return
end

function IslandSlotHudView:ShowHud(arg_6_1, arg_6_2)
	if arg_6_1 == nil then
		return
	end

	if self.currentHud then
		if self.currentHud.unitId == arg_6_1 then
			return
		end

		self:HideUnitHud(self.currentHud.unitId)
	end

	self:ShowUnitHud(arg_6_1, arg_6_2)

	return
end

function IslandSlotHudView:UpdateHud(arg_7_1, arg_7_2)
	if arg_7_1 == nil then
		return
	end

	local var_7_0 = self.view:GetUnitModuleWithType(IslandConst.UNIT_LIST_OBJ, arg_7_1)

	if not var_7_0 then
		return
	end

	local var_7_1 = var_7_0:GetHudInfo()

	if not self.currentHud then
		self:ShowUnitHud(arg_7_1, arg_7_2)

		return
	end

	if self.currentHud.unitId == arg_7_1 then
		self.currentHud:UpdateUnitHud(var_7_1)
	end

	return
end

function IslandSlotHudView:HideUnitHud(arg_8_1)
	if not self.currentHud then
		return
	end

	if self.currentHud.unitId == arg_8_1 then
		self.currentHud:HideHud()
		self:InPool(self.currentHud)

		self.currentHud = nil
	end

	return
end

function IslandSlotHudView:InPool(arg_9_1)
	local var_9_0

	for iter_9_0, iter_9_1 in ipairs(self.unitHideHudQueue) do
		if iter_9_1 == arg_9_1.unitId then
			var_9_0 = iter_9_0
		end
	end

	if var_9_0 then
		table.remove(self.unitHideHudQueue, var_9_0)
	end

	table.insert(self.unitHideHudQueue, arg_9_1.unitId)

	self.hideHudDic[arg_9_1.unitId] = arg_9_1

	if #self.unitHideHudQueue > var_0_1 then
		table.remove(self.unitHideHudQueue, 1)
		self.hideHudDic[self.unitHideHudQueue[1]]:Dispose()

		self.hideHudDic[self.unitHideHudQueue[1]] = nil
	end

	return
end

function IslandSlotHudView:ShowUnitHud(arg_10_1, arg_10_2)
	local var_10_0 = self.view:GetUnitModuleWithType(IslandConst.UNIT_LIST_OBJ, arg_10_1):GetHudInfo()

	if self.hideHudDic[arg_10_1] then
		self.currentHud = self.hideHudDic[arg_10_1]

		self.currentHud:ShowUnitHud(arg_10_1, var_10_0, arg_10_2)
	else
		if not self.currentHud then
			self.currentHud = IslandHudPanel.New(self.parent, self.view)

			self.currentHud:ShowUnitHud(arg_10_1, var_10_0, arg_10_2)
			self.currentHud:Init()

			return
		end

		self.currentHud:ShowUnitHud(arg_10_1, var_10_0, arg_10_2)
	end

	return
end

function IslandSlotHudView:OnDestroy()
	return
end

return IslandSlotHudView
