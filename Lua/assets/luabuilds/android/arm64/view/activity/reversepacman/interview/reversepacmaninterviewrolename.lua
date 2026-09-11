local ReversePacmanInterviewRoleName = class("ReversePacmanInterviewRoleName", import("view.base.BasePanel"))

function ReversePacmanInterviewRoleName:Ctor(arg_1_1, arg_1_2)
	self._go = arg_1_1.gameObject

	ReversePacmanInterviewRoleName.super.Ctor(self, self._go)

	self._parentClass = arg_1_2

	self:attach(arg_1_2)
	self:Init()

	return
end

function ReversePacmanInterviewRoleName:Init()
	return
end

function ReversePacmanInterviewRoleName:didEnter()
	return
end

function ReversePacmanInterviewRoleName:RefreshUI(arg_4_1)
	local var_4_0 = pg.activity_chasing_character[arg_4_1]

	GetImageSpriteFromAtlasAsync("ui/reversepacmanui_atlas", pg.activity_chasing_character[arg_4_1].ai_type == ReversePacmanHomeConst.ROLE_TYPE.CHASER and "hire_chaser" or var_4_0.ai_type == ReversePacmanHomeConst.ROLE_TYPE.AMBUSHER and "hire_ambusher" or "hire_planner", self.uiTypeImage)
	setImageColor(self.uiQuotesImage, Color.NewHex(var_4_0.color))

	local var_4_2 = ReversePacmanTools.IsUnlockRole(arg_4_1)

	setActive(self.uiNameMaskGo, not var_4_2)
	setActive(self.uiNameGo, var_4_2)
	setScrollText(self.uiScrollNameText, HXSet.hxLan(var_4_0.name))

	return
end

function ReversePacmanInterviewRoleName:willExit()
	self:detach()

	return
end

return ReversePacmanInterviewRoleName
