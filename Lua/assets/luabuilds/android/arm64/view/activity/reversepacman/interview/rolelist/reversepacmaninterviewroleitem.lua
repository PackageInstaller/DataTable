local ReversePacmanInterviewRoleItem = class("ReversePacmanInterviewRoleItem", import("view.base.BasePanel"))

function ReversePacmanInterviewRoleItem:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self._go = arg_1_1.gameObject

	ReversePacmanInterviewRoleItem.super.Ctor(self, self._go)

	self._parentClass = arg_1_2
	self.roleID = arg_1_3

	self:attach(arg_1_2)
	self:Init()
	self:didEnter()

	return
end

function ReversePacmanInterviewRoleItem:Init()
	onButton(self, self.uiBtn, function()
		self:emit(ReversePacmanInterviewScene.ON_SELECTED_ROLE, self.roleID)

		return
	end, SFX_PANEL)

	return
end

function ReversePacmanInterviewRoleItem:didEnter()
	return
end

function ReversePacmanInterviewRoleItem:SetRoleID(arg_5_1)
	self.roleID = arg_5_1

	self:RefreshUI()

	return
end

function ReversePacmanInterviewRoleItem:RefreshUI()
	local var_6_0 = pg.activity_chasing_character[self.roleID]
	local var_6_1 = ShipGroup.getDefaultShipConfig(pg.ship_skin_template[pg.activity_chasing_character[self.roleID].skin_id].ship_group).id
	local var_6_2 = Ship.New({
		id = var_6_1,
		configId = var_6_1,
		skin_id = pg.activity_chasing_character[self.roleID].skin_id
	})

	GetImageSpriteFromAtlasAsync("shipYardIcon/" .. var_6_2:getPainting(), var_6_2:getPainting(), self.uiIconImage)

	local var_6_3 = ReversePacmanTools.IsUnlockRole(self.roleID)

	if not ReversePacmanTools.IsUnlockRole(self.roleID) then
		setImageColor(self.uiIconImage, Color.NewHex("#00000096"))
	elseif ReversePacmanTools.IsHireRole(self.roleID) then
		setImageColor(self.uiIconImage, Color.NewHex("#ffffffff"))
	else
		setImageColor(self.uiIconImage, Color.NewHex("#5E5D5Dff"))
	end

	setActive(self.uiSelectedGo, false)
	setActive(self.uiOwnedGo, getProxy(ShipSkinProxy):hasSkin(var_6_0.skin_id))
	self:Show(true)

	return
end

function ReversePacmanInterviewRoleItem:Show(arg_7_1)
	setActive(self._go, arg_7_1)

	return
end

function ReversePacmanInterviewRoleItem:OnSlectedRole(arg_8_1)
	setActive(self.uiSelectedGo, self.roleID == arg_8_1)

	return
end

function ReversePacmanInterviewRoleItem:willExit()
	self:detach()
	Object.Destroy(self._go)

	self._tf = nil
	self._go = nil

	return
end

return ReversePacmanInterviewRoleItem
