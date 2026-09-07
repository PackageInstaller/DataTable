local WSMapFleet = class("WSMapFleet", import(".WSMapTransform"))

WSMapFleet.Fields = {
	rtShadow = "userdata",
	attaches = "table",
	rtArrow = "userdata",
	rtSub = "userdata",
	selected = "boolean",
	rtDamage = "userdata",
	fleet = "table",
	spineRole = "table",
	rtRetreat = "userdata",
	rtFx = "userdata",
	timerHealth = "table",
	theme = "table",
	rtHealth = "userdata",
	moveTurnCount = "number",
	rtMoveTurn = "userdata",
	active = "boolean",
	submarineSupport = "boolean"
}
WSMapFleet.Listeners = {
	onUpdate = "Update"
}
WSMapFleet.EventUpdateSelected = "WSMapFleet.EventUpdateSelected"

function WSMapFleet:GetResName()
	return "ship_tpl"
end

function WSMapFleet:Setup(arg_2_1, arg_2_2)
	self.fleet = arg_2_1

	self.fleet:AddListener(WorldMapFleet.EventUpdateLocation, self.onUpdate)
	self.fleet:AddListener(WorldMapFleet.EventUpdateShipOrder, self.onUpdate)
	self.fleet:AddListener(WorldMapFleet.EventUpdateBuff, self.onUpdate)
	self.fleet:AddListener(WorldMapFleet.EventUpdateDamageLevel, self.onUpdate)

	self.theme = arg_2_2
	self.attaches = {}

	self:Init()

	return
end

function WSMapFleet:Dispose()
	self.fleet:RemoveListener(WorldMapFleet.EventUpdateLocation, self.onUpdate)
	self.fleet:RemoveListener(WorldMapFleet.EventUpdateShipOrder, self.onUpdate)
	self.fleet:RemoveListener(WorldMapFleet.EventUpdateBuff, self.onUpdate)
	self.fleet:RemoveListener(WorldMapFleet.EventUpdateDamageLevel, self.onUpdate)
	self:ClearAttaches()
	self:ClearHealthTimer()
	WSMapFleet.super.Dispose(self)

	return
end

function WSMapFleet:Init()
	self.rtRetreat = self.transform:Find("retreat")
	self.rtArrow = self.transform:Find("arrow")
	self.rtFx = self.transform:Find("fx")
	self.rtShadow = self.transform:Find("shadow")
	self.rtSub = self.transform:Find("marks/sub")
	self.rtDamage = self.transform:Find("marks/damage")
	self.rtMoveTurn = self.transform:Find("marks/move_turn")
	self.rtHealth = self.transform:Find("Health")

	setActive(self.rtRetreat, false)
	setActive(self.rtArrow, false)
	setActive(self.rtSub, false)
	setActive(self.rtDamage, false)
	setActive(self.rtMoveTurn, false)
	setActive(self.rtHealth, false)

	self.transform.name = "fleet_" .. self.fleet.id
	self.transform.localEulerAngles = Vector3(-self.theme.angle, 0, 0)
	self.rtShadow.localPosition = Vector3.zero

	self:Update()
	self:UpdateActive(self.active or true)
	self:UpdateSelected(self.selected or false)
	self:UpdateSubmarineSupport()
	self:UpdateModelScale(Vector3(0.4, 0.4, 1))
	self:UpdateModelAngles(Vector3.zero)

	self.moveTurnCount = 0

	return
end

function WSMapFleet:LoadSpine(arg_5_1)
	local var_5_0 = SpineRole.New((self.fleet:GetFlagShipVO()))

	var_5_0:Load(function()
		if self.modelType ~= WorldConst.ModelSpine then
			var_5_0:Dispose()

			return
		end

		var_5_0:SetRaycastTarget(false)
		var_5_0:SetAnchoredPosition3D(Vector3.zero)
		var_5_0:SetLocalScale(Vector3.one)
		var_5_0:SetLayer(Layer.UI)
		var_5_0:SetParent(self.model)

		self.modelComps = {
			var_5_0
		}
		self.spineRole = var_5_0

		arg_5_1()

		return
	end, self.modelResAsync, var_5_0.ORBIT_KEY_SLG)

	return
end

function WSMapFleet:UnloadSpine()
	if self.spineRole then
		self.spineRole:Dispose()

		self.spineRole = nil
	end

	return
end

function WSMapFleet:Update(arg_8_1)
	if arg_8_1 == nil or arg_8_1 == WorldMapFleet.EventUpdateLocation and not self.isMoving then
		self.transform.anchoredPosition3D = self.theme:GetLinePosition(self.fleet.row, self.fleet.column)
	end

	if arg_8_1 == nil or arg_8_1 == WorldMapFleet.EventUpdateLocation then
		self:SetModelOrder(WorldConst.LOFleet, self.fleet.row)
		underscore.each(self.attaches, function(arg_9_0)
			arg_9_0.modelOrder = self.modelOrder

			return
		end)
	end

	if arg_8_1 == nil or arg_8_1 == WorldMapFleet.EventUpdateShipOrder then
		self:LoadModel(WorldConst.ModelSpine, self.fleet:GetPrefab(), nil, true, function()
			self.model:SetParent(self.transform:Find("ship"), false)

			return
		end)
	end

	if arg_8_1 == nil or arg_8_1 == WorldMapFleet.EventUpdateBuff then
		self:UpdateAttaches()
	end

	if arg_8_1 == nil or arg_8_1 == WorldMapFleet.EventUpdateDamageLevel then
		self:UpdateDamageLevel()
	end

	return
end

function WSMapFleet:UpdateActive(arg_11_1)
	if self.active ~= arg_11_1 then
		self.active = arg_11_1

		setActive(self.transform, self.active)
	end

	return
end

function WSMapFleet:UpdateSelected(arg_12_1)
	if self.selected ~= arg_12_1 then
		self.selected = arg_12_1

		setActive(self.rtArrow, self.selected)
		self:DispatchEvent(WSMapFleet.EventUpdateSelected)
	end

	return
end

function WSMapFleet:UpdateSubmarineSupport()
	local var_13_0 = nowWorld()
	local var_13_1 = var_13_0:IsSubmarineSupporting()

	setActive(self.rtSub, var_13_1)

	if var_13_1 then
		setGray(self.rtSub, not var_13_0:GetSubAidFlag(), false)
	end

	return
end

function WSMapFleet:UpdateAttaches()
	local var_14_0 = self.fleet:GetBuffFxList()

	for iter_14_0 = #var_14_0 + 1, #self.attaches do
		self.attaches[iter_14_0]:Unload()
	end

	for iter_14_1 = #self.attaches + 1, #var_14_0 do
		local var_14_1 = WPool:Get(WSMapEffect)

		var_14_1.transform = createNewGameObject("mapEffect")

		var_14_1.transform:SetParent(self.rtFx, false)

		var_14_1.modelOrder = self.modelOrder

		table.insert(self.attaches, var_14_1)
	end

	for iter_14_2 = 1, #var_14_0 do
		self.attaches[iter_14_2]:Setup(WorldConst.GetBuffEffect(var_14_0[iter_14_2]))
		self.attaches[iter_14_2]:Load()
	end

	return
end

function WSMapFleet:ClearAttaches()
	WPool:ReturnArray(self.attaches)

	for iter_15_0, iter_15_1 in ipairs((_.map(self.attaches, function(arg_16_0)
		return arg_16_0.transform
	end))) do
		Destroy(iter_15_1)
	end

	self.attaches = {}

	return
end

function WSMapFleet:UpdateDamageLevel()
	local var_17_0 = self.fleet.damageLevel

	setActive(self.rtDamage, self.fleet.damageLevel > 0)

	for iter_17_0 = 1, #WorldConst.DamageBuffList do
		setActive(self.rtDamage:Find(iter_17_0), var_17_0 == iter_17_0)
	end

	return
end

function WSMapFleet:PlusMoveTurn()
	self.moveTurnCount = self.moveTurnCount + 1

	setText(self.rtMoveTurn:Find("Text"), self.moveTurnCount)
	setActive(self.rtMoveTurn, self.moveTurnCount > 0)

	return
end

function WSMapFleet:ClearMoveTurn()
	self.moveTurnCount = 0

	setActive(self.rtMoveTurn, false)

	return
end

function WSMapFleet:DisplayHealth()
	self:ClearHealthTimer()
	setActive(self.rtHealth, true)

	self.timerHealth = Timer.New(function()
		setActive(self.rtHealth, false)

		self.timerHealth = nil

		return
	end, 2)

	self.timerHealth:Start()

	return
end

function WSMapFleet:ClearHealthTimer()
	if self.timerHealth then
		self.timerHealth:Stop()

		self.timerHealth = nil

		setActive(self.rtHealth, false)
	end

	return
end

return WSMapFleet
