local var_0_0 = {}

manager.net:Bind(68181, function(arg_1_0)
	AshSystemData:SetData(arg_1_0.pass_stages or {}, true)
end)
manager.net:Bind(68183, function(arg_2_0)
	AshSystemData:SetData({
		arg_2_0.pass_stage
	})
end)
manager.net:Bind(12119, function(arg_3_0)
	AshSystemData:SetMomotalkData(arg_3_0.momotalk_list or {})
end)

function var_0_0.ReadMomotalk(arg_4_0, arg_4_1)
	manager.net:SendWithLoadingNew(12120, {
		momotalk = arg_4_1
	}, 12121, function(arg_5_0, arg_5_1)
		var_0_0:OnReadMomotalk(arg_5_0, arg_5_1)
	end)
end

function var_0_0.OnReadMomotalk(arg_6_0, arg_6_1, arg_6_2)
	if isSuccess(arg_6_1.result) then
		AshSystemData:AddMomotalkData(arg_6_2.momotalk)
	else
		ShowTips(GetTips(arg_6_1.result))
	end
end

function var_0_0:LaunchBattle(arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5)
	local var_7_0 = {
		stageId = arg_7_1,
		realStage = AshShootStageCfg[arg_7_1].stage_id,
		skill = arg_7_2,
		item = arg_7_3,
		weapon = arg_7_4
	}

	self:CacheBattleData(var_7_0)
	AshSystemData:CacheHomologyRate()
	BattleController.GetInstance():LaunchBattle(BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.ASH_BATTLE, AshShootStageCfg[arg_7_1].stage_id, var_7_0), nil, nil, arg_7_5)
end

function var_0_0.CacheBattleData(arg_8_0, arg_8_1)
	arg_8_0.lastBattleData = arg_8_1
end

function var_0_0:GetLastBattleData()
	return self.lastBattleData
end

function var_0_0.InitRedPoint()
	AshSystemData:InitRedPointGroup()
	AshSystemData:UpdateTaskRedPoint()
end

return var_0_0
