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
	for iter_3_0, iter_3_1 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.ACTIVITY_ZUMA] or {}) do
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

		if ActivityZumaLevelCfg[var_4_0] and ActivityZumaLevelCfg[var_4_0].difficult == 4 then
			return
		end

		if ZumaData:GetZumaBeforeIsFinish(var_4_0) and not ZumaData:GetZumaStageScore(var_4_0) then
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
	local var_6_1 = 0

	for iter_6_0, iter_6_1 in ipairs(ZumaData:GetZumaTalentIDList() or {}) do
		if not ZumaData:GetZumaTalentRead(iter_6_1) and not ZumaData:GetZumaTalentIsOpen(iter_6_1) then
			if ZumaData:GetZumaTalentIsCanOpen(iter_6_1) and var_6_0 >= ActivityZumaTalentCfg[iter_6_1].need then
				var_6_1 = 1
			end

			ZumaData:SetTalentRedList(iter_6_1, false)
		end
	end

	manager.redPoint:setTip(RedPointConst.ZUMA_TALENT, var_6_1)
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

function var_0_0:OnZumaCampeletCallBack(arg_9_1)
	if isSuccess(self.result) and arg_9_1.result == 1 then
		ZumaData:UpdateZumaStageData(arg_9_1)
		ZumaData:UpdateZumaCoin(self.value)
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

function var_0_0:OnOpenZumaTalentCallBack(arg_11_1)
	if isSuccess(self.result) then
		ZumaData:SetUseZumaTalent(arg_11_1.talent_id)
		ZumaData:SetZumaCoin(self.value)
		manager.notify:CallUpdateFunc(ZUMA_TALENT_UPDATE, arg_11_1.talent_id)
	end
end

function var_0_0.ResetZumaTalent(arg_12_0)
	arg_12_0 = arg_12_0 or ZumaData:GetZumaActivityID()

	manager.net:SendWithLoadingNew(79006, {
		activity_id = arg_12_0
	}, 79007, var_0_0.OnResetZumaTalentCallBack)
end

function var_0_0:OnResetZumaTalentCallBack(arg_13_1)
	if isSuccess(self.result) then
		ZumaData:ResetTalentList()
		ZumaData:UpdateZumaCoin(self.value)
		manager.notify:CallUpdateFunc(ZUMA_TALENT_UPDATE)
	end
end

function var_0_0.ReChallengeZumaGame()
	ZumaLuaBridge.ReChallengeZumaGame((ZumaAction.GetZumaEnterData(ActivityZumaLevelCfg[ZumaData:GetZumaGameId()])))
end

function var_0_0.PlayZumaGame(arg_15_0)
	arg_15_0 = arg_15_0 or 1

	local var_15_0 = ActivityZumaLevelCfg[arg_15_0]

	if not ActivityZumaLevelCfg[arg_15_0] then
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
	DestroyLua()
	ZumaLuaBridge.Launcher((var_0_0.GetZumaEnterData(var_15_0)))
end

function var_0_0:GetZumaEnterData()
	local var_16_0 = GetZumaDataForExchange()

	var_16_0.mapName = self.map
	var_16_0.difficult = self.difficult
	var_16_0.effectList = var_0_0.GetZumaEffectList()
	var_16_0.useSkillType = ZumaData:GetZumaSkillTypeID()
	var_16_0.isEndless = ZumaData:GetZumaIsUseEndless()

	return var_16_0
end

function var_0_0.GetZumaEffectList()
	local var_17_0 = {}

	for iter_17_0, iter_17_1 in ipairs(ZumaData:GetTalentListBySort() or {}) do
		if ActivityZumaTalentCfg[iter_17_1] and ActivityZumaTalentCfg[iter_17_1].effect_list then
			for iter_17_2, iter_17_3 in pairs(ActivityZumaTalentCfg[iter_17_1].effect_list) do
				table.insert(var_17_0, var_0_0.GetZumaEffectData(iter_17_3))
			end
		end
	end

	if ZumaData:GetZumaIsUseEndless() then
		for iter_17_4, iter_17_5 in pairs(ZumaData:GetEndlessEffectList() or {}) do
			table.insert(var_17_0, var_0_0.GetZumaEffectData(iter_17_5))
		end
	end

	return var_17_0
end

function var_0_0.GetZumaEffectData(arg_18_0)
	local var_18_0 = ActivityZumaEffectCfg[arg_18_0]
	local var_18_1 = ActivityZumaEffectCfg[arg_18_0].effect_value == "" and {} or var_18_0.effect_value

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
