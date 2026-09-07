local ChangeSkinToggle = class("ChangeSkinToggle")
local var_0_1 = 2

function ChangeSkinToggle:Ctor(arg_1_1)
	self._tf = arg_1_1
	self._toggles = {}
	self._toggleTfs = {}

	for iter_1_0 = 1, var_0_1 do
		local var_1_0 = findTF(self._tf, "ad/toggle/" .. iter_1_0)
		local var_1_1 = GetComponent(var_1_0, typeof(Toggle))

		var_1_1.isOn = false

		table.insert(self._toggles, var_1_1)
		table.insert(self._toggleTfs, var_1_0)
	end

	self._toggleContainer = findTF(self._tf, "ad/toggle")
	self._asmrContainer = findTF(self._tf, "ad/asmr")

	self:UpdateVisible(false)

	self._asmrTurnning = false

	return
end

function ChangeSkinToggle:setShipData(arg_2_1, arg_2_2)
	self._skinId = arg_2_1

	local var_2_0 = ShipSkin.GetStoreChangeSkinId(ShipSkin.GetChangeSkinGroupId(self._skinId), arg_2_2)

	self._toggleIndex = 1

	if var_2_0 then
		self._toggleIndex = ShipSkin.GetChangeSkinIndex(var_2_0)
	end

	self._nextSkinId = ShipSkin.GetChangeSkinNextId(self._skinId)

	self:UpdateVisible(true)
	self:updateUI()

	return
end

function ChangeSkinToggle:setSkinData(arg_3_1)
	self._skinId = arg_3_1
	self._toggleIndex = ShipSkin.GetChangeSkinIndex(arg_3_1)
	self._nextSkinId = ShipSkin.GetChangeSkinNextId(self._skinId)

	self:UpdateVisible(true)
	self:updateUI()

	return
end

function ChangeSkinToggle:updateUI()
	for iter_4_0 = 1, #self._toggles do
		local var_4_0 = self._toggles[iter_4_0]

		var_4_0.isOn = iter_4_0 == self._toggleIndex

		setActive(findTF(self._toggleTfs[iter_4_0], "bg"), var_4_0.isOn)
	end

	self:updateToggleUI()
	self:updateAsmrUI()

	return
end

function ChangeSkinToggle:updateToggleUI()
	local var_5_0 = ShipSkin.GetChangeSkinCustomDataId(self._skinId, "toggle_skin") or 1

	for iter_5_0 = 1, #self._toggleTfs do
		self:setChildVisible(findTF(self._toggleTfs[iter_5_0], "bg"), false)

		local var_5_1 = findTF(self._toggleTfs[iter_5_0], "bg/Checkmark_" .. var_5_0)

		setActive(var_5_1, true)

		if iter_5_0 == self._toggleIndex then
			setActive(findTF(var_5_1, "l2d"), table.contains(pg.ship_skin_template[self._skinId].tag, ShipSkin.WITH_LIVE2D) or table.contains(pg.ship_skin_template[self._skinId].tag, ShipSkin.WITH_LIVE2D_PLUS))
			setActive(findTF(var_5_1, "spine"), table.contains(pg.ship_skin_template[self._skinId].tag, ShipSkin.WITH_SPINE) or table.contains(pg.ship_skin_template[self._skinId].tag, ShipSkin.WITH_SPINE_PLUS))
		else
			setActive(findTF(self._toggleTfs[iter_5_0], "tag/l2d"), table.contains(pg.ship_skin_template[self._nextSkinId].tag, ShipSkin.WITH_LIVE2D) or table.contains(pg.ship_skin_template[self._nextSkinId].tag, ShipSkin.WITH_LIVE2D_PLUS))
			setActive(findTF(self._toggleTfs[iter_5_0], "tag/spine"), table.contains(pg.ship_skin_template[self._nextSkinId].tag, ShipSkin.WITH_SPINE) or table.contains(pg.ship_skin_template[self._nextSkinId].tag, ShipSkin.WITH_SPINE_PLUS))
		end
	end

	setActive(self._toggleContainer, not self:IsAsmrSkin())

	return
end

function ChangeSkinToggle:updateAsmrUI()
	setActive(self._asmrContainer, self:IsAsmrSkin())

	local var_6_0 = ShipSkin.GetChangeSkinCustomDataId(self._skinId, "asmr") == 1

	setActive(findTF(self._asmrContainer, "on"), var_6_0)
	setActive(findTF(self._asmrContainer, "off"), not var_6_0)

	return
end

function ChangeSkinToggle:setChildVisible(arg_7_1, arg_7_2)
	for iter_7_0 = 1, arg_7_1.childCount do
		setActive(arg_7_1:GetChild(iter_7_0 - 1), arg_7_2)
	end

	return
end

function ChangeSkinToggle:SetAsmrTurnning(arg_8_1)
	self._asmrTurnning = arg_8_1

	self:UpdateVisible(true)

	if self._skinId then
		self:updateUI()
	end

	return
end

function ChangeSkinToggle:UpdateVisible(arg_9_1)
	if not self._skinId then
		setActive(self._tf, false)

		return
	end

	if self:IsAsmrSkin() and not self._asmrTurnning then
		setActive(self._tf, false)

		return
	end

	setActive(self._tf, arg_9_1)

	return
end

function ChangeSkinToggle:IsAsmrSkin()
	if not self._skinId then
		return false
	end

	return ShipSkin.GetChangeSkinCustomDataId(self._skinId, "asmr") == 1 or ShipSkin.GetChangeSkinCustomDataId(self._nextSkinId, "asmr") == 1 or false
end

return ChangeSkinToggle
