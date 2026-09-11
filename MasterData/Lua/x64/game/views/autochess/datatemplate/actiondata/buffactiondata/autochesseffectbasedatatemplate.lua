local AutoChessEffectBaseDataTemplate = class("AutoChessEffectBaseDataTemplate", (import("game.views.autoChess.dataTemplate.actionData.AutoChessActionBaseDataTemplate")))

function AutoChessEffectBaseDataTemplate:Init(arg_1_1)
	AutoChessEffectBaseDataTemplate.super.Init(self, arg_1_1)

	self.actionEffectType = AutoChessConst.ACTION_EFFECT_TYPE.ADD_ATTR
	self.buffUid = arg_1_1.buff_uid

	self:InitActionEffectData(arg_1_1.action_effect_info)
end

function AutoChessEffectBaseDataTemplate:InitActionEffectData(arg_2_1)
	self.actionEffectType = arg_2_1.effect_enum
	self.buffUid = arg_2_1.buff_uid
end

return AutoChessEffectBaseDataTemplate
