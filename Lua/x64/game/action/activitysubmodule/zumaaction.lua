local var_0_0 = {}

manager.notify:RegistListener(TASK_LIST_CHANGE_NOTIFY, function()
	var_0_0.CheckZumaRewardRedPoint()
end)
manager.notify:RegistListener(ACTIVITY_UPDATE, function(arg_2_0)
	local var_2_0 = ActivityTools.GetActivityType(arg_2_0)

	if var_2_0 == ActivityTemplateConst.ACTIVITY_ZUMA_ENTER or var_2_0 == ActivityTemplateConst.ACTIVITY_ZUMA then
		var_0_0.CheckZumaRedPoint()
		var_0_0.CheckZumaTalentRedPoint()
	end
end)

function var_0_0.CheckZumaRedPoint()
	local var_3_0 = ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.ACTIVITY_ZUMA] or {}

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		var_0_0.CheckZumaOpenRedPoint(iter_3_1)
	end

	var_0_0.CheckZumaRewardRedPoint()
end

function var_0_0.CheckZumaOpenRedPoint(arg_4_0)
	if not ActivityData:GetActivityIsOpen(arg_4_0) or ZumaData:GetZumaRead(arg_4_0) then
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ZUMA_OPEN, arg_4_0), 0)

		return
	end

	if ActivityData:GetActivityIsOpen(arg_4_0) then
		local var_4_0 = ZumaData:GetZumaIdByActId(arg_4_0)
		local var_4_1 = ActivityZumaLevelCfg[var_4_0]

		if var_4_1 and var_4_1.difficult == 4 then
			return
		end

		local var_4_2 = ZumaData:GetZumaStageScore(var_4_0)

		if ZumaData:GetZumaBeforeIsFinish(var_4_0) and not var_4_2 then
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ZUMA_OPEN, arg_4_0), 1)
		else
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ZUMA_OPEN, arg_4_0), 0)
		end
	else
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ZUMA_OPEN, arg_4_0), 0)
	end
end

function var_0_0.CheckZumaRewardRedPoint()
	if #TaskTools:GetCanGetActivityTaskList(ZumaData:GetZumaActivityID()) <= 0 then
		manager.redPoint:setTip(RedPointConst.ZUMA_REWARD, 0)
	else
		manager.redPoint:setTip(RedPointConst.ZUMA_REWARD, 1)
	end
end

function var_0_0.CheckZumaTalentRedPoint()
	if not ActivityData:GetActivityIsOpen(ZumaData:GetZumaActivityID()) or ZumaData:GetZumaRead(ZumaConst.TalentViewID) or not ZumaData:IsFinishOneZumaLevel() then
		manager.redPoint:setTip(RedPointConst.ZUMA_TALENT, 0)

		return
	end

	local var_6_0 = ZumaData:GetZumaCoin()
	local var_6_1 = ZumaData:GetZumaTalentIDList()
	local var_6_2 = 0

	for iter_6_0, iter_6_1 in ipairs(var_6_1 or {}) do
		local var_6_3 = ActivityZumaTalentCfg[iter_6_1]
		local var_6_4 = false

		if not ZumaData:GetZumaTalentRead(iter_6_1) and not ZumaData:GetZumaTalentIsOpen(iter_6_1) then
			if ZumaData:GetZumaTalentIsCanOpen(iter_6_1) and var_6_0 >= var_6_3.need then
				var_6_4 = true
				var_6_2 = 1
			end

			ZumaData:SetTalentRedList(iter_6_1, var_6_4)
		end
	end

	manager.redPoint:setTip(RedPointConst.ZUMA_TALENT, var_6_2)
end

manager.net:Bind(79001, function(arg_7_0)
	ZumaData:InitZumaData(arg_7_0)
	var_0_0.CheckZumaRedPoint()
	ZumaAction.CheckZumaTalentRedPoint()
end)

function var_0_0.QueryZumaCompelet(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	arg_8_2 = arg_8_2 or 1

	manager.net:SendWithLoadingNew(79002, {
		activity_id = arg_8_0,
		id = arg_8_1,
		result = arg_8_2,
		score = arg_8_3,
		useseconds = arg_8_4
	}, 79003, var_0_0.OnZumaCampeletCallBack)
end

function var_0_0.OnZumaCampeletCallBack(arg_9_0, arg_9_1)
	if isSuccess(arg_9_0.result) and arg_9_1.result == 1 then
		ZumaData:UpdateZumaStageData(arg_9_1)
		ZumaData:UpdateZumaCoin(arg_9_0.value)
		var_0_0.CheckZumaRedPoint()
		ZumaAction.CheckZumaTalentRedPoint()
	end
end

function var_0_0.OpenZumaTalent(arg_10_0, arg_10_1)
	arg_10_1 = arg_10_1 or ZumaData:GetZumaActivityID()

	manager.net:SendWithLoadingNew(79004, {
		activity_id = arg_10_1,
		talent_id = arg_10_0
	}, 79005, var_0_0.OnOpenZumaTalentCallBack)
end

function var_0_0.OnOpenZumaTalentCallBack(arg_11_0, arg_11_1)
	if isSuccess(arg_11_0.result) then
		ZumaData:SetUseZumaTalent(arg_11_1.talent_id)
		ZumaData:SetZumaCoin(arg_11_0.value)
		manager.notify:CallUpdateFunc(ZUMA_TALENT_UPDATE, arg_11_1.talent_id)
	end
end

function var_0_0.ResetZumaTalent(arg_12_0)
	arg_12_0 = arg_12_0 or ZumaData:GetZumaActivityID()

	manager.net:SendWithLoadingNew(79006, {
		activity_id = arg_12_0
	}, 79007, var_0_0.OnResetZumaTalentCallBack)
end

function var_0_0.OnResetZumaTalentCallBack(arg_13_0, arg_13_1)
	if isSuccess(arg_13_0.result) then
		ZumaData:ResetTalentList()
		ZumaData:UpdateZumaCoin(arg_13_0.value)
		manager.notify:CallUpdateFunc(ZUMA_TALENT_UPDATE)
	end
end

function var_0_0.ReChallengeZumaGame()
	local var_14_0 = ZumaData:GetZumaGameId()
	local var_14_1 = ActivityZumaLevelCfg[var_14_0]
	local var_14_2 = ZumaAction.GetZumaEnterData(var_14_1)

	ZumaLuaBridge.ReChallengeZumaGame(var_14_2)
end

function var_0_0.PlayZumaGame(arg_15_0)
	arg_15_0 = arg_15_0 or 1

	local var_15_0 = ActivityZumaLevelCfg[arg_15_0]

	if not var_15_0 then
		error("can not find mapCfg")

		return
	end

	if not ActivityData:GetActivityIsOpen(var_15_0.activity_id) then
		ShowTips("TIME_OVER")

		return
	end

	ZumaData:SetEndlessMapRandIndex(-1)
	ZumaData:ResetZumaGameData()
	ZumaData:SetZumaBallCount(0)
	ZumaData:SetZumaGameId(arg_15_0)

	local var_15_1 = var_0_0.GetZumaEnterData(var_15_0)

	DestroyLua()
	ZumaLuaBridge.Launcher(var_15_1)
end

function var_0_0.GetZumaEnterData(arg_16_0)
	local var_16_0 = GetZumaDataForExchange()

	var_16_0.mapName = arg_16_0.map
	var_16_0.difficult = arg_16_0.difficult
	var_16_0.effectList = var_0_0.GetZumaEffectList()
	var_16_0.useSkillType = ZumaData:GetZumaSkillTypeID()
	var_16_0.isEndless = ZumaData:GetZumaIsUseEndless()

	return var_16_0
end

function var_0_0.GetZumaEffectList()
	local var_17_0 = {}
	local var_17_1 = ZumaData:GetTalentListBySort()

	for iter_17_0, iter_17_1 in ipairs(var_17_1 or {}) do
		local var_17_2 = ActivityZumaTalentCfg[iter_17_1]

		if var_17_2 and var_17_2.effect_list then
			for iter_17_2, iter_17_3 in pairs(var_17_2.effect_list) do
				table.insert(var_17_0, var_0_0.GetZumaEffectData(iter_17_3))
			end
		end
	end

	if ZumaData:GetZumaIsUseEndless() then
		local var_17_3 = ZumaData:GetEndlessEffectList()

		for iter_17_4, iter_17_5 in pairs(var_17_3 or {}) do
			table.insert(var_17_0, var_0_0.GetZumaEffectData(iter_17_5))
		end
	end

	return var_17_0
end

function var_0_0.GetZumaEffectData(arg_18_0)
	local var_18_0 = ActivityZumaEffectCfg[arg_18_0]
	local var_18_1 = var_18_0.effect_value == "" and {} or var_18_0.effect_value

	if arg_18_0 == 2503 then
		local var_18_2 = math.floor(math.random() * (#var_18_1 - 1)) + 1

		ZumaData:SetEndlessMapRandIndex(var_18_2)

		return var_0_0.GetZumaEffectData(var_18_1[var_18_2])
	end

	local var_18_3 = ZumaEffectData.New()

	var_18_3.effectType = var_18_0.effect_type

	local var_18_4 = {}
	local var_18_5 = {}

	for iter_18_0, iter_18_1 in ipairs(var_18_1) do
		if type(iter_18_1) == "string" then
			table.insert(var_18_5, iter_18_1)
		else
			table.insert(var_18_4, iter_18_1)
		end
	end

	var_18_3.effectValueList = var_18_4
	var_18_3.effectValueStrList = var_18_5

	return var_18_3
end

return var_0_0
