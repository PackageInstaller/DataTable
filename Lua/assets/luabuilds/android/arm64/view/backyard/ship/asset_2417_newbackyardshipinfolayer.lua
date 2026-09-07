local NewBackYardShipInfoLayer = class("NewBackYardShipInfoLayer", import("...base.BaseUI"))

function NewBackYardShipInfoLayer:getUIName()
	return "NewBackYardShipInfoUI"
end

function NewBackYardShipInfoLayer:init()
	self.descTxt = self._tf:Find("frame/desc"):GetComponent(typeof(Text))
	self.counterTxt = self._tf:Find("frame/top/value/Text"):GetComponent(typeof(Text))
	self.cardContainer = self._tf:Find("frame/panel")
	self.closeBtn = self._tf:Find("frame/top/close")
	self.mainPanel = self._tf:Find("frame")
	self.toggles = {
		[DormShip.FLOOR_2] = self._tf:Find("frame/top/rest"),
		[DormShip.FLOOR_1] = self._tf:Find("frame/top/train")
	}

	local var_2_0 = {}

	var_2_0[DormShip.FLOOR_2] = self._tf:Find("frame/top/rest"):GetComponent(typeof(Animation))
	var_2_0[DormShip.FLOOR_1] = self._tf:Find("frame/top/train"):GetComponent(typeof(Animation))
	self.animations = var_2_0
	self.animationName = {
		[DormShip.FLOOR_2] = {
			"anim_backyard_shipinfo_rest_Select",
			"anim_backyard_shipinfo_rest_unSelect"
		},
		[DormShip.FLOOR_1] = {
			"anim_backyard_shipinfo_train_Select",
			"anim_backyard_shipinfo_train_unSelect"
		}
	}
	self.addShipTpl = self.cardContainer:Find("AddShipTpl")
	self.extendShipTpl = self.cardContainer:Find("ExtendShipTpl")
	self.shipCardTpl = self.cardContainer:Find("ShipCardTpl")
	self.cards = {
		{},
		{},
		{}
	}

	table.insert(self.cards[1], BackYardShipCard.New(self.shipCardTpl, self.event))
	table.insert(self.cards[2], BackYardEmptyCard.New(self.addShipTpl, self.event))
	table.insert(self.cards[3], BackYardExtendCard.New(self.extendShipTpl, self.event))
	setText(self._tf:Find("frame/desc1"), i18n("backyard_longpress_ship_tip"))
	setText(self._tf:Find("frame/top/rest/Text"), i18n("courtyard_label_rest"))
	setText(self._tf:Find("frame/top/train/Text"), i18n("courtyard_label_train"))
	setText(self._tf:Find("frame/top/rest/Text_un"), i18n("courtyard_label_rest"))
	setText(self._tf:Find("frame/top/train/Text_un"), i18n("courtyard_label_train"))

	return
end

function NewBackYardShipInfoLayer:didEnter()
	onButton(self, self._tf, function()
		self:emit(NewBackYardShipInfoLayer.ON_CLOSE)

		return
	end, SFX_PANEL)
	onButton(self, self.closeBtn, function()
		self:emit(NewBackYardShipInfoLayer.ON_CLOSE)

		return
	end, SFX_PANEL)

	local var_3_0 = Color.New(0.2235294, 0.227451, 0.2352941, 1)
	local var_3_1 = Color.New(0.5137255, 0.5137255, 0.5137255, 1)

	for iter_3_0, iter_3_1 in pairs(self.toggles) do
		onToggle(self, iter_3_1, function(arg_6_0)
			if arg_6_0 then
				self:SwitchToPage(iter_3_0)
			end

			if arg_6_0 then
				iter_3_1:Find("icon"):GetComponent(typeof(Image)).color = var_3_0 or var_3_1
			end

			local var_6_0 = self.animationName[iter_3_0]
			local var_6_1 = arg_6_0 and 1 or 2

			self.animations[iter_3_0]:Play(self.animationName[iter_3_0][arg_6_0 and 1 or 2])
			print(var_6_0[var_6_1])

			return
		end, SFX_PANEL)
	end

	setActive(self.toggles[2], getProxy(DormProxy):getRawData():isUnlockFloor(2))
	onNextTick(function()
		if self.exited then
			return
		end

		local var_7_0 = self.contextData.type or DormShip.FLOOR_1

		for iter_7_0, iter_7_1 in ipairs({
			DormShip.FLOOR_1,
			DormShip.FLOOR_2
		}) do
			triggerToggle(self.toggles[iter_7_1], iter_7_1 == var_7_0)
		end

		return
	end)

	return
end

function NewBackYardShipInfoLayer:GetCardTypeCnt(arg_8_1)
	local var_8_0 = getProxy(DormProxy):getRawData()
	local var_8_1 = 0
	local var_8_2 = 0

	if arg_8_1 == DormShip.FLOOR_1 then
		var_8_1 = var_8_0.exp_pos
		var_8_2 = var_8_0:getConfig("training_ship_number")
	elseif arg_8_1 == DormShip.FLOOR_2 then
		var_8_1 = var_8_0.rest_pos
		var_8_2 = var_8_0:getConfig("fix_ship_number")
	end

	local var_8_4 = var_8_0:GetFloorShipCnt(arg_8_1)

	return {
		var_8_4,
		var_8_1 - var_8_4,
		var_8_2 - var_8_1
	}
end

function NewBackYardShipInfoLayer:SwitchToPage(arg_9_1)
	if self.type == arg_9_1 then
		return
	end

	self.type = arg_9_1

	self:UpdateSlots()

	if arg_9_1 == DormShip.FLOOR_1 then
		self.descTxt.text = i18n("backyard_traning_tip")
	elseif arg_9_1 == DormShip.FLOOR_2 then
		self.descTxt.text = i18n("backyard_rest_tip")
	end

	return
end

function NewBackYardShipInfoLayer:UpdateSlots()
	local var_10_0 = self:GetCardTypeCnt(self.type)
	local var_10_1 = getProxy(DormProxy):getRawData():GetBayShipOnFloor(self.type)
	local var_10_2 = 0

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		for iter_10_2, iter_10_3 in ipairs((self:GetTypeCards(iter_10_0, iter_10_1))) do
			var_10_2 = var_10_2 + 1

			iter_10_3:Flush(self.type, var_10_1[iter_10_2])
			iter_10_3:SetSiblingIndex(var_10_2)
		end
	end

	self.counterTxt.text = var_10_0[1] .. "/" .. var_10_0[2] + var_10_0[1]

	return
end

function NewBackYardShipInfoLayer:GetTypeCards(arg_11_1, arg_11_2)
	for iter_11_0 = #self.cards[arg_11_1], arg_11_2 - 1 do
		table.insert(self.cards[arg_11_1], self.cards[arg_11_1][1]:Clone())
	end

	for iter_11_1 = #self.cards[arg_11_1], arg_11_2 + 1, -1 do
		self.cards[arg_11_1][iter_11_1]:Disable()
	end

	local var_11_0 = {}

	for iter_11_2 = 1, arg_11_2 do
		self.cards[arg_11_1][iter_11_2]:Enable()

		var_11_0[iter_11_2] = self.cards[arg_11_1][iter_11_2]
	end

	return var_11_0
end

function NewBackYardShipInfoLayer:willExit()
	for iter_12_0, iter_12_1 in ipairs(self.cards) do
		for iter_12_2, iter_12_3 in ipairs(iter_12_1) do
			iter_12_3:Dispose()
		end
	end

	return
end

return NewBackYardShipInfoLayer
