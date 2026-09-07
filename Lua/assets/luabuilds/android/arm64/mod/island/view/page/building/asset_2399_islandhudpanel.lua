local IslandHudPanel = class("IslandHudPanel", import("Mod.Island.Core.View.IslandBaseUnit"))

function IslandHudPanel:Init(...)
	PoolMgr.GetInstance():GetUI(self:GetUIName(), true, function(arg_2_0)
		self._go = arg_2_0
		self._tf = arg_2_0.transform

		IslandHudPanel.super.Init(self, arg_2_0)
		setParent(arg_2_0, self.parentTF)
		arg_2_0.transform:SetAsFirstSibling()

		return
	end)

	return
end

function IslandHudPanel:Ctor(arg_3_1, arg_3_2)
	self.super.Ctor(self, arg_3_2)

	self.parentTF = arg_3_1

	self:InitHudHeight()

	return
end

function IslandHudPanel:GetUIName()
	return "IslandCollectHud"
end

function IslandHudPanel:OnInit(arg_5_1)
	assert(arg_5_1)

	self._go = arg_5_1
	self._tf = arg_5_1.transform
	self.name = self._tf:Find("name_bg/name")
	self.productIcon = self._tf:Find("productIcon")
	self.timeTF = self._tf:Find("process/layout/time")
	self.energyTF = self._tf:Find("process/layout/enrgy_bar")
	self.numProcessTF = self._tf:Find("name_bg/name/numer")
	self.timeMgr = pg.TimeMgr.GetInstance()

	self:UpdateHudDisplay()

	return
end

function IslandHudPanel:InitHudHeight()
	self.heightUnitDic = {}

	for iter_6_0, iter_6_1 in pairs(pg.island_set.information_hud_height.key_value_varchar[1]) do
		self.heightUnitDic[iter_6_1] = pg.island_set.information_hud_height.key_value_varchar[2]
	end

	return
end

function IslandHudPanel:ShowUnitHud(arg_7_1, arg_7_2, arg_7_3)
	self.unitId = arg_7_1
	self.position = pg.island_world_objects[self.unitId].param.position
	self.height = arg_7_3 or 1

	self:UpdateUnitHud(arg_7_2)

	return
end

function IslandHudPanel:UpdateUnitHud(arg_8_1)
	self.hudInfo = arg_8_1

	if self:IsLoaded() then
		self:UpdateHudDisplay()
	end

	return
end

function IslandHudPanel:UpdateHudDisplay()
	setActive(self._tf, self.active)

	if self.hudInfo.name then
		setActive(self.name, true)
		setText(self.name, self.hudInfo.name)
	else
		setActive(self.name, false)
	end

	if self.hudInfo.hudState then
		setActive(self.timeTF, true)

		if self.hudInfo.hudState.stateEndTime then
			self:UpdateTime(self.hudInfo.hudState)
		else
			setText(self.timeTF, self.hudInfo.hudState.stateText)
		end
	else
		setActive(self.timeTF, false)
	end

	if self.hudInfo.process then
		setActive(self.energyTF, true)
		setSlider(self.energyTF, 0, 1, self.hudInfo.process)
	else
		setActive(self.energyTF, false)
	end

	if self.hudInfo.numProcess then
		setActive(self.numProcessTF, true)
		setText(self.numProcessTF, self.hudInfo.numProcess)
	else
		setActive(self.numProcessTF, false)
	end

	if self.hudInfo.itemIcon then
		GetImageSpriteFromAtlasAsync(self.hudInfo.itemIcon, "", self.productIcon)
	end

	return
end

function IslandHudPanel:HideHud()
	if self._tf then
		setActive(self._tf, false)

		self.active = false
	end

	return
end

function IslandHudPanel:UpdateTime(arg_11_1)
	if not arg_11_1 then
		return
	end

	if arg_11_1.stateEndTime then
		local var_11_0 = arg_11_1.stateEndTime - self.timeMgr:GetServerTime()

		if var_11_0 > 0 then
			setText(self.timeTF, self.timeMgr:DescCDTime(var_11_0))
		end
	end

	return
end

function IslandHudPanel:Update()
	if not self:IsLoaded() then
		return
	end

	self:UpdateTime(self.hudInfo.hudState)

	return
end

function IslandHudPanel:LateUpdate()
	if not self:IsLoaded() then
		return
	end

	local var_13_0 = Vector3(self.position[1], self.position[2], self.position[3]) + Vector3(0, self.height, 0)

	if not IslandCalcUtil.IsInViewport(var_13_0) then
		setActive(self._tf, false)
	else
		setActive(self._tf, true)

		self._tf.localPosition = IslandCalcUtil.WorldPosition2LocalPosition(self.parentTF, var_13_0)
	end

	return
end

function IslandHudPanel:OnDispose()
	PoolMgr.GetInstance():ReturnUI(self:GetUIName(), self._go)

	return
end

function IslandHudPanel:Clear()
	return
end

return IslandHudPanel
