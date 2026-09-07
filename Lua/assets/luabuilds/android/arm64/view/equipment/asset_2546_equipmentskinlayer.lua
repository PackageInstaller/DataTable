local EquipmentSkinLayer = class("EquipmentSkinLayer", import("..base.BaseUI"))

EquipmentSkinLayer.DISPLAY = 1
EquipmentSkinLayer.REPLACE = 2

function EquipmentSkinLayer:getUIName()
	return "EquipmentSkinInfoUI"
end

function EquipmentSkinLayer:setShip(arg_2_1)
	self.shipVO = arg_2_1

	return
end

function EquipmentSkinLayer:init()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	self.displayPanel = self._tf:Find("display")

	setActive(self.displayPanel, false)

	self.displayActions = self.displayPanel:Find("actions")
	self.skinViewOnShipTF = self._tf:Find("replace/equipment_on_ship")
	self.skinViewTF = self._tf:Find("replace/equipment")
	self.replacePanel = self._tf:Find("replace")

	setActive(self.replacePanel, false)

	return
end

function EquipmentSkinLayer:didEnter()
	onButton(self, self._tf, function()
		self:emit(EquipmentSkinLayer.ON_CLOSE)

		return
	end, SOUND_BACK)
	onButton(self, self._tf:Find("display/top/btnBack"), function()
		self:emit(EquipmentSkinLayer.ON_CLOSE)

		return
	end, SFX_CANCEL)
	onButton(self, self.replacePanel:Find("actions/cancel_button"), function()
		self:emit(EquipmentSkinLayer.ON_CLOSE)

		return
	end, SFX_PANEL)
	onButton(self, self.replacePanel:Find("actions/action_button_2"), function()
		if not self.contextData.oldShipInfo then
			self:emit(EquipmentSkinMediator.ON_EQUIP)
		else
			self:emit(EquipmentSkinMediator.ON_EQUIP_FORM_SHIP)
		end

		return
	end, SFX_PANEL)

	local var_4_0 = self.contextData.mode or EquipmentSkinLayer.DISPLAY

	if var_4_0 == EquipmentSkinLayer.REPLACE and self.shipVO then
		self:initReplace()
	elseif var_4_0 == EquipmentSkinLayer.DISPLAY then
		self:initDisplay()
	end

	return
end

function EquipmentSkinLayer:initDisplay()
	setActive(self.displayPanel, true)
	setActive(self.replacePanel, false)

	if self.shipVO then
		self:initDisplay4Ship()
	else
		eachChild(self.displayActions, function(arg_10_0)
			local var_10_0 = arg_10_0.gameObject.name == "confirm"

			setActive(arg_10_0, arg_10_0.gameObject.name == "confirm")

			if var_10_0 then
				onButton(self, arg_10_0, function()
					self:emit(EquipmentSkinLayer.ON_CLOSE)

					return
				end, SFX_PANEL)
			end

			return
		end)
	end

	self:updateSkinView(self.displayPanel, self.contextData.skinId)

	return
end

function EquipmentSkinLayer:initDisplay4Ship()
	eachChild(self.displayActions, function(arg_13_0)
		local var_13_0 = arg_13_0.gameObject.name

		setActive(arg_13_0, arg_13_0.gameObject.name ~= "confirm")
		onButton(self, arg_13_0, function()
			if var_13_0 == "unload" then
				self:emit(EquipmentSkinMediator.ON_UNEQUIP)
			elseif var_13_0 == "replace" then
				self:emit(EquipmentSkinMediator.ON_SELECT)
			end

			return
		end, SFX_PANEL)

		return
	end)

	return
end

function EquipmentSkinLayer:initReplace()
	setActive(self.displayPanel, false)
	setActive(self.replacePanel, true)

	local var_15_0 = self.contextData.skinId

	self:updateSkinView(self.skinViewOnShipTF, self.shipVO:getEquipSkin(self.contextData.pos) or 0)

	if self.contextData.oldShipInfo then
		self:updateSkinView(self.skinViewTF, var_15_0, self.contextData.oldShipInfo)
	else
		self:updateSkinView(self.skinViewTF, var_15_0)
	end

	return
end

function EquipmentSkinLayer:updateSkinView(arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = arg_16_2 ~= 0
	local var_16_1 = arg_16_1:Find("empty")

	if var_16_1 then
		setActive(var_16_1, not var_16_0)
	end

	setActive(arg_16_1:Find("info"), var_16_0)

	arg_16_1:GetComponent(typeof(Image)).enabled = var_16_0

	if var_16_0 then
		assert(pg.equip_skin_template[arg_16_2], "miss config equip_skin_template >> " .. arg_16_2)

		arg_16_1:Find("info/display_panel/name_container/name"):GetComponent(typeof(Text)).text = pg.equip_skin_template[arg_16_2].name
		arg_16_1:Find("info/display_panel/desc"):GetComponent(typeof(Text)).text = pg.equip_skin_template[arg_16_2].desc

		setScrollText(arg_16_1:Find("info/display_panel/equip_type/mask/Text"), table.concat(_.map(pg.equip_skin_template[arg_16_2].equip_type, function(arg_17_0)
			return EquipType.Type2Name2(arg_17_0)
		end), ","))

		local var_16_2 = arg_16_1:Find("info/play_btn")

		setActive(var_16_2, true)
		onButton(self, var_16_2, function()
			self:emit(EquipmentSkinMediator.ON_PREVIEW, arg_16_2)

			return
		end, SFX_PANEL)
		updateDrop(arg_16_1:Find("info/equip"), Drop.New({
			type = DROP_TYPE_EQUIPMENT_SKIN,
			id = arg_16_2
		}))

		local var_16_3 = arg_16_1:Find("info/head")

		if var_16_3 then
			setActive(var_16_3, arg_16_3)

			if arg_16_3 then
				assert(arg_16_3.id, "old ship id is nil")
				assert(arg_16_3.pos, "old ship pos is nil")

				local var_16_4 = getProxy(BayProxy):getShipById(arg_16_3.id)

				if var_16_4 then
					setImageSprite(var_16_3:Find("Image"), LoadSprite("qicon/" .. var_16_4:getPainting()))
				end
			end
		end
	end

	return
end

function EquipmentSkinLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self.UIMain)

	return
end

return EquipmentSkinLayer
