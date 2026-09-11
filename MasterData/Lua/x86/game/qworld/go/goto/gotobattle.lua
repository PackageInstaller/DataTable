local GotoBattle = class("GotoBattle", BaseGoto)

function GotoBattle:GetBasePath()
	return "game.qworld.go.gotoBattleImpl."
end

function GotoBattle:Ctor()
	self.template = {
		DEFAULT = "GotoBattleBase",
		[BattleConst.STAGE_TYPE_NEW.SEA_WARFARE] = "GotoSeaWarfareBattle",
		[BattleConst.STAGE_TYPE_NEW.SAND_PLAY] = "GotoSandPlayBattle"
	}
end

function GotoBattle:GetTemplateName(arg_3_1)
	return self.template[arg_3_1] or self.template.DEFAULT
end

function GotoBattle:Go(arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, ...)
	self:InstantiateEntity(arg_4_2[1]):OnEnter(arg_4_2, arg_4_3)
end

return GotoBattle
