local DOAYearHotSpringShipSelectLayer = class("DOAYearHotSpringShipSelectLayer", import("view.base.BaseUI"))
local NewYearHotSpringFormationCard = import("view.activity.BackHills.NewYearFestival.NewYearHotSpringFormationCard")

function DOAYearHotSpringShipSelectLayer:getUIName()
	return "DOAYearHotSpringShipSelectUI"
end

function DOAYearHotSpringShipSelectLayer:init()
	self.counterTxt = self._tf:Find("frame/top/value/Text"):GetComponent(typeof(Text))
	self.cardContainer = self._tf:Find("frame/panel")
	self.mainPanel = self._tf:Find("frame")
	self.addShipTpl = self.cardContainer:Find("AddShipTpl")
	self.extendShipTpl = self.cardContainer:Find("ExtendShipTpl")
	self.shipCardTpl = self.cardContainer:Find("ShipCardTpl")

	setActive(self.addShipTpl, false)
	setActive(self.extendShipTpl, false)
	setActive(self.shipCardTpl, false)

	self.cardContainer = self.cardContainer:Find("Scroll View/Content")
	self.shipCards = {}

	setText(self._tf:Find("frame/desc"), i18n("hotspring_tip1"))

	return
end

function DOAYearHotSpringShipSelectLayer:SetActivity(arg_3_1)
	self.activity = arg_3_1

	return
end

function DOAYearHotSpringShipSelectLayer:didEnter()
	self._tf:Find("BG"):SetSiblingIndex(0)
	onButton(self, self._tf:Find("BG"), function()
		self:emit(DOAYearHotSpringShipSelectLayer.ON_CLOSE)

		return
	end, SFX_PANEL)

	local function var_4_0(arg_6_0)
		setActive(self._tf:Find("frame/panel/ArrowRight"), arg_6_0.x < 0.01)
		setActive(self._tf:Find("frame/panel/ArrowLeft"), arg_6_0.x > 0.99)

		return
	end

	onScroll(self, self.cardContainer.parent, var_4_0)
	var_4_0({
		x = 0
	})
	self:BlurPanel(self._tf)
	self:UpdateSlots()

	return
end

function DOAYearHotSpringShipSelectLayer:UpdateSlots()
	local var_7_0 = self.activity
	local var_7_1 = 0
	local var_7_2 = 0

	self:CleanCards()
	_.each(_.range(1, self.activity:GetTotalSlotCount()), function(arg_8_0)
		local var_8_0 = var_7_0:GetShipIds()[arg_8_0] or 0
		local var_8_1 = math.clamp(arg_8_0 - var_7_0:GetSlotCount(), 0, 2)
		local var_8_2 = var_8_0 > 0 and getProxy(BayProxy):RawGetShipById(var_8_0)

		self:AddCard(arg_8_0, var_8_1, var_8_2)

		var_7_1 = var_7_1 + (var_8_1 == 0 and 1 or 0)
		var_7_2 = var_7_2 + (var_8_2 and 1 or 0)

		return
	end)

	self.counterTxt.text = 0 .. "/" .. 0

	return
end

function DOAYearHotSpringShipSelectLayer:AddCard(arg_9_1, arg_9_2, arg_9_3)
	local var_9_0

	if arg_9_2 == 0 and arg_9_3 then
		var_9_0 = cloneTplTo(self.shipCardTpl, self.cardContainer)

		local var_9_1 = var_9_0:Find("content")
		local var_9_2 = NewYearHotSpringFormationCard.New(go(var_9_0))

		onButton(self, var_9_1, function()
			self:emit(DOAYearHotSpringShipSelectMediator.OPEN_CHUANWU, arg_9_1, arg_9_3)

			return
		end, SFX_PANEL)

		local var_9_3 = GetOrAddComponent(var_9_1, typeof(UILongPressTrigger))

		var_9_3.onLongPressed:RemoveAllListeners()
		var_9_3.onLongPressed:AddListener(function()
			if not arg_9_3 then
				return
			end

			self:emit(DOAYearHotSpringShipSelectMediator.LOOG_PRESS_SHIP, arg_9_1, arg_9_3)

			return
		end)
		var_9_2:update(arg_9_3)

		local var_9_4 = arg_9_3:getRecoverEnergyPoint() + self.activity:GetEnergyRecoverAddition()
		local var_9_5 = 0

		if arg_9_3.state == Ship.STATE_REST or arg_9_3.state == Ship.STATE_TRAIN then
			if arg_9_3.state == Ship.STATE_TRAIN then
				var_9_4 = var_9_4 + Ship.BACKYARD_1F_ENERGY_ADDITION
			elseif arg_9_3.state == Ship.STATE_REST then
				var_9_4 = var_9_4 + Ship.BACKYARD_2F_ENERGY_ADDITION
			end

			for iter_9_0, iter_9_1 in ipairs(BuffHelper.GetBackYardEnergyBuffs()) do
				var_9_5 = var_9_5 + tonumber(iter_9_1:getConfig("benefit_effect"))
			end
		end

		local var_9_6 = {
			{
				i18n("word_lv"),
				arg_9_3.level
			},
			{
				i18n("word_nowenergy"),
				arg_9_3.energy
			}
		}
		local var_9_7 = {
			(i18n("word_energy_recov_speed"))
		}

		var_9_7[2] = setColorStr(10 * var_9_4, COLOR_GREEN) .. (var_9_5 > 0 and setColorStr("+" .. 10 * var_9_5, COLOR_GREEN) or "") .. "/h"
		var_9_6[3] = var_9_7

		var_9_2:updateProps1(var_9_6)
		setActive(var_9_2.propsTr, false)
		setActive(var_9_2.propsTr1, true)
		table.insert(self.shipCards, {
			info = var_9_2,
			longpressedTigger = var_9_3
		})
	else
		var_9_0 = cloneTplTo(self.extendShipTpl, self.cardContainer)

		local var_9_8 = var_9_0:Find("content")

		setActive(var_9_8:Find("label/add"), arg_9_2 == 0)
		setActive(var_9_8:Find("label/unlock"), arg_9_2 == 1)
		setActive(var_9_8:Find("label/lock"), arg_9_2 == 2)
		setActive(var_9_8:Find("mask"), arg_9_2 == 2)

		if arg_9_2 == 0 then
			onButton(self, var_9_8, function()
				self:emit(DOAYearHotSpringShipSelectMediator.OPEN_CHUANWU, arg_9_1)

				return
			end, SFX_PANEL)
		elseif arg_9_2 == 1 then
			onButton(self, var_9_8, function()
				self:emit(DOAYearHotSpringShipSelectMediator.EXTEND, arg_9_1)

				return
			end, SFX_PANEL)
		elseif arg_9_2 == 2 then
			-- block empty
		end
	end

	setActive(var_9_0, true)

	return
end

function DOAYearHotSpringShipSelectLayer:CleanCards()
	_.each(self.shipCards, function(arg_15_0)
		arg_15_0.longpressedTigger.onLongPressed:RemoveAllListeners()
		arg_15_0.info:clear()

		return
	end)

	self.shipCards = {}

	removeAllChildren(self.cardContainer)

	return
end

function DOAYearHotSpringShipSelectLayer:willExit()
	self:UnOverlayPanel(self._tf)
	self:CleanCards()

	return
end

return DOAYearHotSpringShipSelectLayer
