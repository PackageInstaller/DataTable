local ReversePacmanHireSuccessScene = class("ReversePacmanHireSuccessScene", import("view.base.BaseUI"))

function ReversePacmanHireSuccessScene:getUIName()
	return "ReversePacmanHireSuccessUI"
end

function ReversePacmanHireSuccessScene:init()
	onButton(self, self.uiCloseBtn, function()
		self:closeView()

		return
	end, SOUND_BACK)

	self.nameView = ReversePacmanInterviewRoleName.New(self.uiNamePanel, self)

	return
end

function ReversePacmanHireSuccessScene:didEnter()
	self:BlurPanel(self._tf)
	self.nameView:RefreshUI(self.contextData.roleID)

	local var_4_0 = pg.activity_chasing_character[self.contextData.roleID]
	local var_4_2 = ShipGroup.getDefaultShipConfig(pg.ship_skin_template[pg.activity_chasing_character[self.contextData.roleID].skin_id].ship_group).id

	setText(self.uiDescText, (pg.ship_skin_words[var_4_2] or nil) and (pg.ship_skin_words[var_4_2].unlock or ""))

	local var_4_3 = Ship.New({
		id = var_4_2,
		configId = var_4_2,
		skin_id = var_4_0.skin_id
	}):getPrefab()

	pg.UIMgr.GetInstance():LoadingOn()

	local var_4_4 = SpineAnimChar.New()

	var_4_4:SetPaint(var_4_3)
	var_4_4:Load(true, function(arg_5_0)
		pg.UIMgr.GetInstance():LoadingOff()

		self.shipPrefab = var_4_3
		self.shipModel = arg_5_0

		arg_5_0:SetLocalScale(Vector3(1, 1, 1))
		arg_5_0:SetParent(self.uiCharaParent)
		arg_5_0:SetAction("victory", 0)

		return
	end)

	return
end

function ReversePacmanHireSuccessScene:recycleSpineChar()
	if self.shipPrefab and self.shipModel then
		self.shipModel:Dispose()

		self.shipPrefab = nil
		self.shipModel = nil
	end

	return
end

function ReversePacmanHireSuccessScene:willExit()
	self:recycleSpineChar()
	self.nameView:willExit()

	self.nameView = nil

	self:UnOverlayPanel(self._tf)

	return
end

return ReversePacmanHireSuccessScene
