local ReversePacmanTechnologyHrItem = class("ReversePacmanTechnologyHrItem", import("view.base.BasePanel"))

function ReversePacmanTechnologyHrItem:Ctor(arg_1_1, arg_1_2)
	self._go = arg_1_1.gameObject

	ReversePacmanTechnologyHrItem.super.Ctor(self, self._go)

	self._parentClass = arg_1_2

	self:attach(arg_1_2)
	self:Init()

	return
end

function ReversePacmanTechnologyHrItem:Init()
	onButton(self, self.uiGiftBtn, function()
		if not ReversePacmanTools.IsUnlockRole(self.roleID) then
			pg.TipsMgr:GetInstance():ShowTips(i18n("reverse_pacman_unlock_role"))

			return
		end

		if not ReversePacmanTools.IsHireRole(self.roleID) then
			pg.TipsMgr:GetInstance():ShowTips(i18n("reverse_pacman_unhire_role"))

			return
		end

		if self.maxFavorabilityValue <= self.curFavorabilityValue then
			print("满级", self.maxFavorabilityValue, self.curFavorabilityValue)

			return
		end

		local var_3_0 = ReversePacmanTools.GetGiftItemID()

		if ReversePacmanTools.GetItemCnt(var_3_0) < 1 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("reverse_pacman_ not_enough_gifts"))

			return
		end

		self:emit(ReversePacmanTechnologyMediator.CMD_GIFT, {
			roleID = self.roleID,
			itemID = var_3_0
		})

		return
	end, SFX_PANEL)
	setText(self.uiGiftText, i18n("reverse_pacman_send_gift"))

	return
end

function ReversePacmanTechnologyHrItem:didEnter(arg_4_1)
	self.roleID = arg_4_1

	local var_4_0 = ShipGroup.getDefaultShipConfig(pg.ship_skin_template[pg.activity_chasing_character[arg_4_1].skin_id].ship_group).id
	local var_4_1 = Ship.New({
		id = var_4_0,
		configId = var_4_0,
		skin_id = pg.activity_chasing_character[arg_4_1].skin_id
	})

	GetImageSpriteFromAtlasAsync("shipYardIcon/" .. var_4_1:getPainting(), var_4_1:getPainting(), self.uiIconImage)

	if not ReversePacmanTools.IsUnlockRole(arg_4_1) then
		setImageColor(self.uiIconImage, Color.NewHex("#00000096"))
	elseif ReversePacmanTools.IsHireRole(arg_4_1) then
		setImageColor(self.uiIconImage, Color.NewHex("#ffffffff"))
	else
		setImageColor(self.uiIconImage, Color.NewHex("#5E5D5Dff"))
	end

	self.maxFavorabilityValue = ReversePacmanTools.GetMaxFavorabilityValue(arg_4_1)
	self.curFavorabilityValue = ReversePacmanTools.GetFavorabilityValue(arg_4_1)

	self:RefreshFavorability()
	self:RefreshTip()
	self:RefreshBtn()

	return
end

function ReversePacmanTechnologyHrItem:RefreshFavorability()
	for iter_5_0, iter_5_1 in ipairs(pg.activity_chasing_character[self.roleID].love_level) do
		if self.curFavorabilityValue >= iter_5_1[2] then
			setFillAmount(self[string.format("uiHeartImage%s", iter_5_0)], 1)
		else
			setFillAmount(self[string.format("uiHeartImage%s", iter_5_0)], ((self.curFavorabilityValue - 0 < 0 or nil) and 0) / (iter_5_1[2] - 0))
		end
	end

	return
end

function ReversePacmanTechnologyHrItem:RefreshBtn()
	if not ReversePacmanTools.IsHireRole(self.roleID) then
		setGray(self.uiGiftBtn, true)

		return
	end

	if self.maxFavorabilityValue <= self.curFavorabilityValue then
		setGray(self.uiGiftBtn, true)

		return
	end

	setGray(self.uiGiftBtn, false)

	return
end

function ReversePacmanTechnologyHrItem:RefreshTip()
	setActive(self.uiGiftTipGo, self:HasTip())

	return
end

function ReversePacmanTechnologyHrItem:HasTip()
	if not ReversePacmanTools.IsHireRole(self.roleID) then
		return false
	end

	if self.maxFavorabilityValue <= self.curFavorabilityValue then
		return false
	end

	return ReversePacmanTools.GetActivity():GetGiftTip()
end

function ReversePacmanTechnologyHrItem:willExit()
	self:detach()

	return
end

return ReversePacmanTechnologyHrItem
