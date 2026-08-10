local var_0_0 = {}
local var_0_1 = false
local var_0_2
local var_0_3

function var_0_0.InitRedActivityID(arg_1_0)
	var_0_2 = arg_1_0
	var_0_3 = MusicData:GetActivityTaskID(arg_1_0)
end

function var_0_0.InitMusicRedPoint(arg_2_0)
	MusicAction.InitRedActivityID(arg_2_0)

	if var_0_1 then
		return
	end

	var_0_1 = true

	local var_2_0 = ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.ACTIVITY_MUSIC] or {}

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		local var_2_1 = {}

		if ActivityData:GetActivityIsOpen(iter_2_1) then
			local var_2_2 = ActivityCfg[iter_2_1].sub_activity_list or {}

			for iter_2_2, iter_2_3 in pairs(var_2_2) do
				table.insert(var_2_1, string.format("%s_%s", RedPointConst.MUSIC_OPEN, iter_2_3))
			end
		end

		local var_2_3 = string.format("%s_%s", RedPointConst.MUSIC_OPEN, iter_2_1)

		manager.redPoint:addGroup(var_2_3, var_2_1)
		manager.redPoint:addGroup(string.format("%s_%s", RedPointConst.MUSIC, iter_2_1), {
			var_2_3,
			string.format("%s_%s", RedPointConst.MUSIC_REWARD, iter_2_1)
		})
	end
end

manager.net:Bind(61047, function(arg_3_0)
	MusicData:InitMusicData(arg_3_0)
	MusicAction.CheckRedPoint()
end)
manager.notify:RegistListener(ACTIVITY_UPDATE, function(arg_4_0)
	local var_4_0 = ActivityTools.GetActivityType(arg_4_0)

	if var_4_0 == ActivityTemplateConst.ACTIVITY_MUSIC or var_4_0 == ActivityTemplateConst.ACTIVITY_MUSIC_GAME then
		MusicAction.CheckRedPoint()
	end
end)
manager.notify:RegistListener(TASK_LIST_CHANGE_NOTIFY, function()
	MusicAction.UpdateTaskRed()
end)

function var_0_0.QueryCompelet(arg_6_0, arg_6_1)
	local var_6_0 = MusicConst.MusicFinishState.Unfinished
	local var_6_1 = MusicData:GetGameRecord(MusicConst.MusicNodeHitRating.Miss)

	if MusicData:GetGameRecord(MusicConst.MusicNodeHitRating.Good) == 0 and var_6_1 == 0 then
		var_6_0 = MusicConst.MusicFinishState.Perfect
	elseif var_6_1 == 0 then
		var_6_0 = MusicConst.MusicFinishState.NoMistake
	else
		var_6_0 = MusicConst.MusicFinishState.Finished
	end

	manager.net:SendWithLoadingNew(61048, {
		id = arg_6_0,
		score = arg_6_1,
		other_data = MusicData:GetSpectralSendData(),
		state = var_6_0
	}, 61049, var_0_0.OnCampeletCallBack)
end

function var_0_0.OnCampeletCallBack(arg_7_0, arg_7_1)
	if isSuccess(arg_7_0.result) then
		local var_7_0 = arg_7_1.id
		local var_7_1 = ActivityMusicCfg[var_7_0]
		local var_7_2 = var_7_1.activity_id
		local var_7_3 = var_7_1.difficult
		local var_7_4 = MusicData:GetScore(var_7_0)

		if var_7_4 <= arg_7_1.score or var_7_4 == 0 then
			MusicData:SetScore(var_7_0, arg_7_1.score, arg_7_1.state)
			MusicAction.CheckRedPoint()
			var_0_0.OpenSettlement(var_7_2, arg_7_1.score, arg_7_1.score, true)
		else
			var_0_0.OpenSettlement(var_7_2, arg_7_1.score, var_7_4, false)
		end
	else
		MusicLuaBridge.EndMusicGame()
		ShowTips(arg_7_0.result)
	end
end

function var_0_0.OpenSettlement(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	if MusicData:GetSpecialEffectState() then
		return
	end

	local var_8_0 = MusicData:GetMusicViewPathList(arg_8_0)

	gameContext:Go(var_8_0.settlement, {
		cur = arg_8_1,
		max = arg_8_2,
		new = arg_8_3,
		isSpecialPerformance = arg_8_4
	})
end

function var_0_0.QueryReward(arg_9_0)
	manager.net:SendWithLoadingNew(61050, {
		id_list = arg_9_0
	}, 61051, var_0_0.OnRewardCallBack)
end

function var_0_0.OnRewardCallBack(arg_10_0, arg_10_1)
	if isSuccess(arg_10_0.result) then
		local var_10_0 = mergeReward2(arg_10_0.reward_list or {})

		if #var_10_0 > 0 then
			getReward2(var_10_0)
		end

		MusicAction.CheckRedPoint()
		manager.notify:CallUpdateFunc(MUSIC_REWARD_UPDATE)
	else
		ShowTips(arg_10_0.result)
	end
end

function var_0_0.CheckRedPoint()
	if var_0_2 and MusicData:IsInitMusicData() then
		MusicAction.CheckOpenRedPoint(var_0_2)
	end

	MusicAction.UpdateTaskRed()
end

function var_0_0.UpdateTaskRed()
	if var_0_3 then
		MusicAction.CheckRewardRedPoint(var_0_3)
	end
end

function var_0_0.CheckTargetMusicRedPoint(arg_13_0)
	if ActivityData:GetActivityIsOpen(arg_13_0) and not MusicData:GetRead(arg_13_0) then
		local var_13_0 = ActivityMusicCfg.get_id_list_by_activity_id[arg_13_0]
		local var_13_1 = true

		for iter_13_0, iter_13_1 in ipairs(var_13_0) do
			local var_13_2 = ActivityMusicCfg[iter_13_1]

			if MusicData:GetIsComplete(iter_13_1) ~= 0 then
				var_13_1 = false

				break
			end
		end

		if var_13_1 then
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MUSIC_OPEN, arg_13_0), 1)
		else
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MUSIC_OPEN, arg_13_0), 0)
		end
	end
end

function var_0_0.CheckOpenRedPoint(arg_14_0)
	local var_14_0 = ActivityCfg[arg_14_0]
	local var_14_1 = var_14_0 and var_14_0.sub_activity_list or {}

	if not ActivityData:GetActivityIsOpen(arg_14_0) then
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MUSIC_OPEN, arg_14_0), 0)

		for iter_14_0, iter_14_1 in ipairs(var_14_1) do
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MUSIC_OPEN, iter_14_1), 0)
		end

		return
	end

	for iter_14_2, iter_14_3 in ipairs(var_14_1) do
		local var_14_2 = ActivityCfg[iter_14_3]

		if var_14_2 and var_14_2.activity_template == ActivityTemplateConst.ACTIVITY_MUSIC_GAME then
			MusicAction.CheckTargetMusicRedPoint(iter_14_3)
		end
	end
end

function var_0_0.CheckRewardRedPoint(arg_15_0)
	if not ActivityData:GetActivityIsOpen(arg_15_0) then
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MUSIC_REWARD, var_0_2), 0)

		return
	end

	if #TaskTools:GetCanGetActivityTaskList(arg_15_0) <= 0 then
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MUSIC_REWARD, var_0_2), 0)
	else
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MUSIC_REWARD, var_0_2), 1)
	end
end

function var_0_0.SetMusicRead(arg_16_0)
	MusicData:SetRead(arg_16_0)
	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MUSIC_OPEN, arg_16_0), 0)
end

function var_0_0.Play(arg_17_0)
	local var_17_0 = ActivityMusicCfg[arg_17_0]

	if not var_17_0 then
		error("can not find ActivityMusicCfg")

		return
	end

	local var_17_1 = GetMusicDataForExchange()

	var_17_1.musicPath = var_17_0.path
	var_17_1.cueSheetName = var_17_0.cueSheetName
	var_17_1.cueName = var_17_0.cueName
	var_17_1.awbFile = var_17_0.awbFile
	var_17_1.aisacKey = var_17_0.aisacKey
	var_17_1.aisacValue = var_17_0.aisacValue
	var_17_1.isVertical = MusicData:GetTrackPathType() == MusicConst.MusicTrackType.Vertical
	var_17_1.latency = MusicData:GetJudgeData()
	var_17_1.stayTime = MusicData:GetSpeedData(MusicData:GetTrackPathType())
	var_17_1.constantSpeed = MusicData:GetConstantSpeed()
	var_17_1.isConstant = MusicData:GetTrackPathType() == MusicConst.MusicTrackType.Constant_Slope
	var_17_1.judgeLatency = MusicData:GetScreanData()
	var_17_1.goodArea = GameSetting.attach_music_judgment_good.value[1]
	var_17_1.prefectArea = GameSetting.attach_music_judgment_perfect.value[1]
	var_17_1.perfectPlusArea = GameSetting.attach_music_judgment_perfect_plus.value[1]
	var_17_1.longStartArea = GameSetting.attach_music_judgment_good.value[1]
	var_17_1.longEndArea = GameSetting.attach_music_judgment_good.value[1]
	var_17_1.interval = GameSetting.attach_music_longnote.value[1]
	var_17_1.preparationTime = 2000
	var_17_1.spectralType = MusicData:GetSpectralType()
	var_17_1.mixRange = MusicData:GetMixValue()

	SDKTools.SendMessageToSDK("activity_music_start", {
		is_restart = false,
		activity_id = var_17_0.activity_id,
		difficulty_id = var_17_0.difficult,
		other_data = MusicData:GetSpectralAndVercialSDKKey()
	})
	MusicData:SetGameId(arg_17_0)
	DestroyLua()
	MusicLuaBridge.Launcher(var_17_1)
end

function var_0_0.GoToMusicMain()
	DestroyLua()

	local var_18_0 = MusicData:GetGameId()
	local var_18_1 = ActivityMusicCfg[var_18_0].activity_id
	local var_18_2 = MusicData:GetMusicViewPathList(var_18_1)
	local var_18_3 = MusicData:GetPageActivityID()

	if ActivityTools.GetActivityTheme(var_18_3) == ActivityConst.THEME.ACTIVITY_3_11 then
		LaunchQWorld(true)
	else
		LuaExchangeHelper.GoToMain()
		OpenPageUntilLoaded(var_18_2.musicMain, {
			activity_id = var_18_2.activityID
		})
	end
end

return var_0_0
