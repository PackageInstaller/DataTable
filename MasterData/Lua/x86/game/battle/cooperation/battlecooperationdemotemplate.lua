local BattleCooperationDemoTemplate = class("BattleCooperationDemoTemplate", BattleBaseCooperationTemplate)

function BattleCooperationDemoTemplate:Ctor(arg_1_1)
	self.activityID_ = arg_1_1

	BattleCooperationDemoTemplate.super.Ctor(self)

	self.id_ = ActivityCooperationDemoCfg[arg_1_1].stage_id
	self.cfg = BattleCooperationDemoCfg[ActivityCooperationDemoCfg[arg_1_1].stage_id]
end

function BattleCooperationDemoTemplate:GetStageId()
	return self.id_
end

function BattleCooperationDemoTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.COOPERATION_DEMO
end

function BattleCooperationDemoTemplate:GetMap()
	return self.cfg.map, false
end

function BattleCooperationDemoTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

function BattleCooperationDemoTemplate:GetRevive()
	if type(self.cfg.is_revive) ~= "table" then
		return false, 0, 0, 0
	end

	local var_6_0 = self.cfg.is_revive

	return not not self.cfg.is_revive[1], self.cfg.is_revive[1] or 0, var_6_0[1] and ItemTools.getItemNum(var_6_0[1]) or 0, var_6_0[2] or 0
end

function BattleCooperationDemoTemplate:GetStageAffix()
	local var_7_0 = {}
	local var_7_1 = {}
	local var_7_2 = {}

	for iter_7_0, iter_7_1 in pairs({
		{
			9491,
			3,
			3
		},
		{
			9492,
			3,
			3
		},
		{
			9493,
			3,
			3
		}
	} or {}) do
		table.insert(var_7_0, iter_7_1[1])
		table.insert(var_7_1, iter_7_1[2])
		table.insert(var_7_2, iter_7_1[3])
	end

	return var_7_0, var_7_1, var_7_2
end

return BattleCooperationDemoTemplate
