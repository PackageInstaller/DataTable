local IslandBaseHudPanel = class("IslandBaseHudPanel", import(".IslandBaseUnit"))

function IslandBaseHudPanel:Ctor(arg_1_1, arg_1_2, arg_1_3)
	IslandBaseHudPanel.super.Ctor(self, arg_1_1)

	self.parentTF = arg_1_3
	self.data = arg_1_2
	self.unitId = arg_1_2.id
	self.unitType = arg_1_2.type
	self.unitTransform = arg_1_2.unitTransform
	self.positionX = arg_1_2.positionX
	self.positionY = arg_1_2.positionY
	self.param1 = arg_1_2.param1

	return
end

function IslandBaseHudPanel:Init(...)
	PoolMgr.GetInstance():GetUI(self:GetUIName(), true, function(arg_3_0)
		self._go = arg_3_0
		self._tf = arg_3_0.transform

		setParent(arg_3_0, self.parentTF)
		IslandBaseHudPanel.super.Init(self, arg_3_0)
		self:Show()
		self:Refresh(self.data)

		return
	end)

	return
end

function IslandBaseHudPanel:GetUIName()
	assert(false, "overwrite me")

	return
end

function IslandBaseHudPanel:OnInit()
	return
end

function IslandBaseHudPanel:OnShow()
	return
end

function IslandBaseHudPanel:Refresh(arg_7_1)
	return
end

function IslandBaseHudPanel:RefreshHud()
	return
end

function IslandBaseHudPanel:Show()
	self.active = true

	if not self._tf then
		return
	end

	setActive(self._tf, true)
	self:OnShow()

	return
end

function IslandBaseHudPanel:Hide()
	if not self._tf then
		return
	end

	self.active = false

	setActive(self._tf, false)

	return
end

function IslandBaseHudPanel:OnDispose()
	PoolMgr.GetInstance():ReturnUI(self:GetUIName(), self._go)

	return
end

return IslandBaseHudPanel
