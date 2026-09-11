local ReversePacmanResumeScene = class("ReversePacmanResumeScene", import("view.base.BasePanel"))

function ReversePacmanResumeScene:Ctor(arg_1_1, arg_1_2)
	self._go = arg_1_1.gameObject

	ReversePacmanResumeScene.super.Ctor(self, self._go)

	self._parentClass = arg_1_2

	self:attach(arg_1_2)
	self:Init()

	return
end

function ReversePacmanResumeScene:Init()
	onButton(self, self.uiCloseBtn, function()
		self:emit(ReversePacmanInterviewScene.ON_CLOSE_RESUME)

		return
	end, SOUND_BACK)
	setText(self.uiSpeedTitleText, i18n("reverse_pacman_resume_speed"))
	setText(self.uiTypeTitleText, i18n("reverse_pacman_resume_ai_type"))
	setText(self.uiTypeDescTitleText, i18n("reverse_pacman_resume_ai_desc"))
	setText(self.uiCloseText, i18n("reverse_pacman_resume_close_1"))

	return
end

function ReversePacmanResumeScene:didEnter(arg_4_1)
	local var_4_0 = pg.activity_chasing_character[arg_4_1]
	local var_4_1 = ShipGroup.getDefaultShipConfig(pg.ship_skin_template[pg.activity_chasing_character[arg_4_1].skin_id].ship_group).id
	local var_4_2 = Ship.New({
		id = var_4_1,
		configId = var_4_1,
		skin_id = pg.activity_chasing_character[arg_4_1].skin_id
	})

	GetImageSpriteFromAtlasAsync("shipYardIcon/" .. var_4_2:getPainting(), var_4_2:getPainting(), self.uiIconImage)

	local var_4_3 = ReversePacmanTools.GetFavorabilityValue(arg_4_1)

	for iter_4_0, iter_4_1 in ipairs(var_4_0.love_level) do
		if var_4_3 >= iter_4_1[2] then
			setFillAmount(self[string.format("uiHeartImage%s", iter_4_0)], 1)
		else
			setFillAmount(self[string.format("uiHeartImage%s", iter_4_0)], ((var_4_3 - 0 < 0 or nil) and 0) / (iter_4_1[2] - 0))
		end
	end

	setText(self.uiNameText, HXSet.hxLan(var_4_0.name))

	local var_4_6 = ReversePacmanHomeConst.GetSpeedLevel(var_4_0.base_speed)

	setText(self.uiSpeedText, i18n("reverse_pacman_speed_level", var_4_6.color, var_4_6.value))
	setText(self.uiTypeText, i18n(var_4_0.ai_type == ReversePacmanHomeConst.ROLE_TYPE.CHASER and "reverse_pacman_type_chaser_1" or var_4_0.ai_type == ReversePacmanHomeConst.ROLE_TYPE.AMBUSHER and "reverse_pacman_type_ambusher_1" or "reverse_pacman_type_planner_1"))
	setText(self.uiTypeDescText, var_4_0.trait_text)
	setText(self.uiDescText, var_4_0.resume_text)

	return
end

function ReversePacmanResumeScene:willExit()
	self:detach()

	return
end

return ReversePacmanResumeScene
