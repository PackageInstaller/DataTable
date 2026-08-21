local var_0_0 = singletonClass("BackHomeDataManager")
local var_0_1
local var_0_2
local var_0_3 = {
	[DormEnum.DormSystemType.Canteen] = CanteenData,
	[DormEnum.DormSystemType.Dormitory] = DormitoryData,
	[DormEnum.DormSystemType.CricketBattle] = BackHomeCricketBattleData
}

function var_0_0.Init(arg_1_0)
	var_0_1 = DormEnum.DormSystemType.Main
	var_0_2 = false
end

function var_0_0.InitAllSampleData(arg_2_0, arg_2_1)
	DormData:InitSimplaDormData(arg_2_1)

	if not var_0_2 then
		DormitoryData:InitSimpleDormInfo(arg_2_1)
	else
		for iter_2_0, iter_2_1 in ipairs(arg_2_1.dorm) do
			if BackHomeCfg[iter_2_1.id].type == DormConst.BACKHOME_TYPE.PrivateDorm then
				local var_2_0 = DormitoryData:GetDormMapList()

				if var_2_0 and var_2_0[iter_2_1.id] and var_2_0[iter_2_1.id].archiveIDList and var_2_0[iter_2_1.id].archiveIDList[1] then
					DormData:GetHeroInfo(var_2_0[iter_2_1.id].archiveIDList[1]):InitHeroRoomID(iter_2_1.id)
				end
			end
		end
	end

	CanteenData:InitSimpleCanteenInfo(arg_2_1)
	BackHomeCricketBattleData:InitSimpleCricketBattleInfo(arg_2_1)
	DormSkillData:Init()
end

function var_0_0.InitAllDetailData(arg_3_0, arg_3_1)
	DormData:InitDetailDormData(arg_3_1)
	CanteenData:InitDetailCanteenData(arg_3_1)
	DormitoryData:InitDetialDormData(arg_3_1)
	BackHomeCricketBattleData:InitDetailCricketBattleData(arg_3_1)
	DormSkillData:Init()
end

function var_0_0.InitAllVisitData(arg_4_0, arg_4_1)
	DormData:InitVisitDormData(arg_4_1)
end

function var_0_0.EnterBackHomeSystem(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if not var_0_2 then
		var_0_2 = true
		arg_5_3 = arg_5_3 or false

		DormVisitTools:SetIsOtherSystem(arg_5_3)
		BackHomeAction:GetAllDetailInfo(arg_5_1, arg_5_2)
	elseif arg_5_1 then
		arg_5_1(arg_5_2)
	end
end

function var_0_0.ExitBackHomeSystem(arg_6_0, arg_6_1, arg_6_2)
	var_0_2 = false

	if var_0_1 ~= DormEnum.DormSystemType.Main and var_0_1 ~= DormEnum.DormSystemType.Illu then
		var_0_3[var_0_1]:ExitCurSystem()
	end

	var_0_1 = DormEnum.DormSystemType.Main

	DormData:SetCurrentScene(nil)
	CanteenData:ExitBackHomeSystem()
	DormitoryData:ExitBackHomeSystem()
	BackHomeCricketBattleData:ExitBackHomeSystem()

	if arg_6_1 then
		arg_6_1(arg_6_2)
	end
end

function var_0_0.OtherSystemVisitBack(arg_7_0)
	var_0_2 = false

	if var_0_1 ~= DormEnum.DormSystemType.Main and var_0_1 ~= DormEnum.DormSystemType.Illu then
		var_0_3[var_0_1]:ExitCurSystem()
	end

	var_0_1 = DormEnum.DormSystemType.Main

	DormData:SetCurrentScene(nil)
	CanteenData:ExitBackHomeSystem()
	DormitoryData:ExitBackHomeSystem()
	DormitoryData:OtherSystemVisitBack()
end

function var_0_0.ChangeCurSystem(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if arg_8_2 then
		local var_8_0 = var_0_1

		var_0_1 = DormEnum.DormSystemType.CricketBattle

		if var_8_0 ~= var_0_1 then
			if var_8_0 ~= DormEnum.DormSystemType.Main and var_8_0 ~= DormEnum.DormSystemType.Illu then
				var_0_3[var_8_0]:ExitCurSystem()
			end

			if var_0_1 ~= DormEnum.DormSystemType.Main then
				var_0_3[var_0_1]:EnterCurSystem()
			end
		end

		return
	end

	if arg_8_3 then
		local var_8_1 = var_0_1

		var_0_1 = DormEnum.DormSystemType.Illu

		if var_8_1 ~= var_0_1 and var_8_1 ~= DormEnum.DormSystemType.Main and var_8_1 ~= DormEnum.DormSystemType.Illu then
			var_0_3[var_8_1]:ExitCurSystem()
		end

		return
	end

	if arg_8_1 then
		local var_8_2 = BackHomeCfg[arg_8_1].type
		local var_8_3 = var_0_1

		if var_8_2 == DormConst.BACKHOME_TYPE.Canteen then
			var_0_1 = DormEnum.DormSystemType.Canteen
		elseif var_8_2 == DormConst.BACKHOME_TYPE.PublicDorm then
			var_0_1 = DormEnum.DormSystemType.Dormitory
		elseif var_8_2 == DormConst.BACKHOME_TYPE.PrivateDorm then
			var_0_1 = DormEnum.DormSystemType.Dormitory
		end

		if var_8_3 ~= var_0_1 then
			if var_8_3 ~= DormEnum.DormSystemType.Main and var_8_3 ~= DormEnum.DormSystemType.Illu then
				var_0_3[var_8_3]:ExitCurSystem()
			end

			if var_0_1 ~= DormEnum.DormSystemType.Main then
				var_0_3[var_0_1]:EnterCurSystem()
			end
		end
	end
end

function var_0_0.GotoBackHomeScene(arg_9_0, arg_9_1)
	if arg_9_1 then
		BackHomeAction:CheckToEnterDormScene(arg_9_1)
		arg_9_0:ChangeCurSystem(arg_9_1)
	end
end

function var_0_0.GotoBackHomeCricketStage(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 == BackHomeCricketConst.ROOM_TYPE.TRAIN then
		DormMinigame.Launch("WT_RK", nil, "idolTraineeCamp")
		arg_10_0:ChangeCurSystem(nil, true)
		DormData:SetCurrentScene(nil)

		return
	end

	if arg_10_2 and var_0_1 == DormEnum.DormSystemType.CricketBattle then
		local var_10_0

		if arg_10_1 == BackHomeCricketConst.ROOM_TYPE.PVP_STAGE then
			var_10_0 = IdolTraineePvpBattleCfg
		else
			var_10_0 = IdolTraineePveBattleCfg
		end

		local var_10_1 = IdolStageSceneCfg[var_10_0[arg_10_2].scene_id].scene_name

		DormMinigame.Launch(var_10_1, DanceGameBridge)
	end
end

function var_0_0.GotoBackHomeIlluScene(arg_11_0)
	DormIllu.Launch("X100_Illu")
	arg_11_0:ChangeCurSystem(nil, false, true)
	DormData:SetCurrentScene(nil)
end

function var_0_0.GetCurSystem(arg_12_0)
	return var_0_1
end

function var_0_0.IsInDormSystem(arg_13_0)
	return var_0_2
end

return var_0_0
