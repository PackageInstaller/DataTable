class = var_0_10000

local var_0_0 = var_0_10000("DecodeGameController")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	DecodeGameModel = var_1_10002
	arg_1_0.model = var_1_10002.New(arg_1_0)
	DecodeGameView = var_2
	arg_1_0.view = var_2.New(arg_1_0)

	return
end

function var_0_0.SetCallback(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.exitCallBack = arg_2_1
	arg_2_0.saveDataCallback = arg_2_2
	arg_2_0.successCallback = arg_2_3

	return
end

function var_0_0.SetUp(arg_3_0, arg_3_1)
	seriesAsync = var_1_10002

	var_1_10002({
		function(arg_4_0)
			arg_3_0.isIniting = true

			local var_4_0 = arg_3_0.model

			var_1.SetData(var_4_0, arg_3_1)

			local var_4_1 = arg_3_0

			var_1.UpdateProgress(var_4_1)

			local var_4_2 = arg_3_0.view

			var_1.UpdateCanUseCnt(var_4_2, arg_3_0.model.canUseCnt)

			local var_4_3 = arg_3_0

			var_1.SwitchMap(var_4_3, arg_3_0.model.map.id, arg_4_0())

			return
		end,
		function(arg_5_0)
			local var_5_0 = arg_3_0
			local var_5_1 = var_1.PlayVoice

			DecodeGameConst = var_2_10004

			var_5_1(var_5_0, var_2_10004.OPEN_DOOR_VOICE)

			local var_5_2 = arg_3_0.view

			var_1.DoEnterAnim(var_5_2, arg_5_0)

			return
		end,
		function(arg_6_0)
			pg = var_2_10001

			local var_6_0 = var_2_10001.NewStoryMgr.GetInstance()
			local var_6_1 = var_1.Play

			DecodeGameConst = var_2_10004

			var_6_1(var_6_0, var_2_10004.STORYID, arg_6_0)

			return
		end,
		function(arg_7_0)
			local var_7_0 = arg_3_0.view

			var_1.ShowHelper(var_7_0, 1, arg_7_0)

			return
		end,
		function(arg_8_0)
			arg_3_0.isIniting = nil

			local var_8_0 = arg_3_0

			var_1.ShowTip(var_8_0)

			local var_8_1 = arg_3_0.view

			var_1.Inited(var_8_1, arg_3_0.model.isFinished)

			return
		end
	})

	return
end

function var_0_0.ShowTip(arg_9_0)
	local var_9_0 = arg_9_0.model
	local var_9_1 = var_1.GetUnlockMapCnt(var_9_0)
	local var_9_2

	if arg_9_0.model.isFinished then
		var_9_2 = 0
	else
		DecodeGameConst = var_3

		if var_9_1 < var_3.MAX_MAP_COUNT and arg_9_0.model.canUseCnt <= 0 then
			var_9_2 = 1
		else
			DecodeGameConst = var_3

			if var_9_1 < var_3.MAX_MAP_COUNT and arg_9_0.model.canUseCnt > 0 then
				var_9_2 = 2
			else
				if not arg_9_0.isInDecodeMap and not arg_9_0.isInComparison then
					DecodeGameConst = var_3

					if var_9_1 == var_3.MAX_MAP_COUNT then
						var_9_2 = 3

						goto label_9_0
					end
				end

				if arg_9_0.isInDecodeMap and not arg_9_0.isInComparison then
					DecodeGameConst = var_3

					if var_9_1 == var_3.MAX_MAP_COUNT then
						var_9_2 = 4

						goto label_9_0
					end
				end

				if arg_9_0.isInDecodeMap and arg_9_0.isInComparison then
					DecodeGameConst = var_3

					if var_9_1 == var_3.MAX_MAP_COUNT then
						var_9_2 = 5
					end
				end
			end
		end
	end

	::label_9_0::

	local var_9_3 = arg_9_0.view

	var_3.ShowTip(var_9_3, var_9_2)

	return
end

function var_0_0.UpdateProgress(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.model
	local var_10_1 = var_2.GetUnlockedCnt(var_10_0)
	local var_10_2 = arg_10_0.model
	local var_10_3 = var_3.GetUnlockMapCnt(var_10_2)
	local var_10_4 = arg_10_0.model
	local var_10_5, var_10_6 = var_4.GetPassWordProgress(var_10_4)

	arg_10_1 = arg_10_1 or function()
		return
	end

	local var_10_7

	if not arg_10_0.finishCnt then
		var_10_7 = 0
	end

	if var_10_7 < var_10_6 and var_10_6 ~= #var_10_5 then
		arg_10_0.finishCnt = var_10_6

		local var_10_8 = arg_10_0
		local var_10_9 = arg_10_0.PlayVoice

		DecodeGameConst = var_1_10009

		var_10_9(var_10_8, var_1_10009.INCREASE_PASSWORD_PROGRESS_VOICE)
	end

	local var_10_10 = arg_10_0.view

	var_6.UpdateProgress(var_10_10, var_10_1, var_10_3, var_10_5, arg_10_1)

	return
end

function var_0_0.SwitchMap(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_0.inSwitching then
		return
	end

	if arg_12_0.mapId ~= arg_12_1 then
		local function var_12_0(arg_13_0)
			parallelAsync = var_2_10001

			var_2_10001({
				function(arg_14_0)
					if not arg_12_0.isInDecodeMap then
						local var_14_0 = arg_12_0.view

						var_1.OnSwitchMap(var_14_0, arg_14_0)
					else
						arg_14_0()
					end

					return
				end,
				function(arg_15_0)
					if not arg_12_0.mapId then
						arg_15_0()

						return
					end

					local var_15_0 = arg_12_0.model

					var_1.ExitMap(var_15_0)

					local var_15_1 = arg_12_0.view

					var_1.OnExitMap(var_15_1, arg_12_0.mapId, arg_12_0.isInDecodeMap, arg_15_0)

					return
				end,
				function(arg_16_0)
					arg_12_0.mapId = nil

					local var_16_0 = arg_12_0.model

					var_1.SwitchMap(var_16_0, arg_12_1)

					local var_16_1 = arg_12_0.view

					var_1.UpdateMap(var_16_1, arg_12_0.model.map)

					local var_16_2 = arg_12_0.view

					var_1.OnEnterMap(var_16_2, arg_12_1, arg_12_0.isInDecodeMap, arg_16_0)

					return
				end
			}, arg_13_0)

			return
		end

		seriesAsync = var_1_10004

		var_1_10004({
			function(arg_17_0)
				if not arg_12_0.isIniting then
					local var_17_0 = arg_12_0
					local var_17_1 = var_1.PlayVoice

					DecodeGameConst = var_2_10004

					var_17_1(var_17_0, var_2_10004.SWITCH_MAP_VOCIE)
				end

				arg_12_0.inSwitching = true

				var_12_0(arg_17_0)

				return
			end,
			function(arg_18_0)
				arg_12_0.mapId = arg_12_1

				if not arg_12_0.isInDecodeMap then
					arg_18_0()

					return
				end

				arg_12_0.isInComparison = true

				local var_18_0 = arg_12_0
				local var_18_1 = var_1.PlayVoice

				DecodeGameConst = var_2_10004

				var_18_1(var_18_0, var_2_10004.SCAN_MAP_VOICE)

				local var_18_2 = arg_12_0.view

				var_1.OnDecodeMap(var_18_2, arg_12_0.model.map, arg_18_0)

				return
			end,
			function(arg_19_0)
				arg_12_0.inSwitching = nil

				if arg_12_0.isInDecodeMap then
					local var_19_0 = arg_12_0

					var_1.ShowTip(var_19_0)

					local var_19_1 = arg_12_0.view

					var_1.ShowHelper(var_19_1, 3, arg_19_0)
				else
					arg_19_0()
				end

				return
			end
		}, arg_12_2)
	end

	return
end

function var_0_0.Unlock(arg_20_0, arg_20_1)
	if arg_20_0.inSwitching then
		return
	end

	if arg_20_0.isInDecodeMap then
		arg_20_0:EnterPassWord(arg_20_1)
	else
		arg_20_0:UnlockMapItem(arg_20_1)
	end

	return
end

function var_0_0.EnterPassWord(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0.model

	if not var_2.IsMapKey(var_21_0, arg_21_1) then
		return
	end

	local var_21_1 = arg_21_0.model

	if var_2.IsUsedMapKey(var_21_1, arg_21_1) then
		return
	end

	local var_21_2 = arg_21_0.model
	local var_21_6

	if var_2.CheckIndex(var_21_2, arg_21_1) then
		local var_21_3 = arg_21_0.model

		var_2.InsertMapKey(var_21_3, arg_21_1)

		local var_21_4 = arg_21_0.model
		local var_21_5 = var_2.GetCurrMapKeyIndex(var_21_4, arg_21_1)

		var_21_6 = arg_21_0.model

		local var_21_7 = var_3.GetMapKeyStr(var_21_6, arg_21_1)
		local var_21_8 = arg_21_0.view

		var_4.OnRightCode(var_21_8, arg_21_1, var_21_7, var_21_5)

		local var_21_9 = arg_21_0.model

		if var_4.IsSuccess(var_21_9) then
			local var_21_10 = arg_21_0.model

			var_4.Finish(var_21_10)

			local var_21_11 = arg_21_0
			local var_21_12 = arg_21_0.PlayVoice

			DecodeGameConst = var_7

			var_21_12(var_21_11, var_7.GET_AWARD_DONE_VOICE)

			local var_21_13 = arg_21_0.view

			var_4.OnSuccess(var_21_13, function()
				pg = var_2_10000

				local var_22_0 = var_2_10000.NewStoryMgr.GetInstance()
				local var_22_1 = var_0.Play

				DecodeGameConst = var_2_10003

				var_22_1(var_22_0, var_2_10003.LAST_STORYID)

				if arg_21_0.successCallback then
					arg_21_0.successCallback()
				end

				return
			end)
		else
			local var_21_14 = arg_21_0
			local var_21_15 = arg_21_0.PlayVoice

			DecodeGameConst = var_7

			var_21_15(var_21_14, var_7.PASSWORD_IS_RIGHT_VOICE)
		end

		arg_21_0:UpdateProgress()
	else
		local var_21_16 = arg_21_0
		local var_21_17 = arg_21_0.PlayVoice

		DecodeGameConst = var_21_6

		var_21_17(var_21_16, var_21_6.PASSWORD_IS_FALSE_VOICE)

		local var_21_18 = arg_21_0.view

		var_2.OnFalseCode(var_21_18, arg_21_1)
	end

	return
end

function var_0_0.UnlockMapItem(arg_23_0, arg_23_1)
	if arg_23_0.model.canUseCnt > 0 then
		local var_23_0 = arg_23_0.model

		if not var_2.IsUnlock(var_23_0, arg_23_1) then
			seriesAsync = var_2

			var_2({
				function(arg_24_0)
					arg_23_0.inSwitching = true

					local var_24_0 = arg_23_0.model

					var_1.UnlockMapItem(var_24_0, arg_23_1)

					local var_24_1 = arg_23_0.view

					var_1.UnlockMapItem(var_24_1, arg_23_1, arg_24_0)

					return
				end,
				function(arg_25_0)
					local var_25_0 = arg_23_0

					var_1.PlayStory(var_25_0, arg_25_0)

					return
				end,
				function(arg_26_0)
					local var_26_0 = arg_23_0.view

					var_1.UpdateCanUseCnt(var_26_0, arg_23_0.model.canUseCnt)

					local var_26_1 = arg_23_0.model

					if var_1.IsUnlockMap(var_26_1, arg_23_0.model.map.id) then
						local var_26_2 = arg_23_0

						var_1.RepairMap(var_26_2)
					else
						local var_26_3 = arg_23_0
						local var_26_4 = var_1.PlayVoice

						DecodeGameConst = var_4

						var_26_4(var_26_3, var_4.INCREASE_PROGRESS_VOICE)

						local var_26_5 = arg_23_0

						var_1.UpdateProgress(var_26_5)

						if arg_23_0.saveDataCallback then
							arg_23_0.saveDataCallback()
						end

						arg_23_0.inSwitching = nil
					end

					local var_26_6 = arg_23_0

					var_1.ShowTip(var_26_6)
					arg_26_0()

					return
				end
			})
		end
	end

	return
end

function var_0_0.PlayStory(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_0.model
	local var_27_1 = var_2.GetUnlockedCnt(var_27_0)

	DecodeGameConst = var_1_10003

	if var_1_10003.UNLOCK_STORYID[var_27_1] then
		pg = var_27_0

		local var_27_2 = var_27_0.NewStoryMgr.GetInstance()

		var_4.Play(var_27_2, var_3, arg_27_1)
	else
		arg_27_1()
	end

	return
end

function var_0_0.RepairMap(arg_28_0)
	seriesAsync = var_1_10001

	var_1_10001({
		function(arg_29_0)
			local var_29_0 = arg_28_0.model

			var_1.OnRepairMap(var_29_0)

			local var_29_1 = arg_28_0.view

			var_1.OnMapRepairing(var_29_1, arg_29_0)

			return
		end,
		function(arg_30_0)
			if arg_28_0.saveDataCallback then
				arg_28_0.saveDataCallback(arg_30_0)
			else
				arg_30_0()
			end

			return
		end,
		function(arg_31_0)
			local var_31_0 = arg_28_0
			local var_31_1 = var_1.PlayVoice

			DecodeGameConst = var_2_10004

			var_31_1(var_31_0, var_2_10004.INCREASE_PROGRESS_VOICE)

			local var_31_2 = arg_28_0.view

			var_1.UpdateMap(var_31_2, arg_28_0.model.map)

			local var_31_3 = arg_28_0

			var_1.UpdateProgress(var_31_3, arg_31_0)

			return
		end,
		function(arg_32_0)
			local var_32_0 = arg_28_0.model
			local var_32_1 = var_1.GetUnlockMapCnt(var_32_0)

			DecodeGameConst = var_2_10002

			if var_32_1 == var_2_10002.MAX_MAP_COUNT then
				local var_32_2 = arg_28_0.view

				var_2.ShowHelper(var_32_2, 2, arg_32_0)
			end

			arg_28_0.inSwitching = nil

			return
		end
	})

	return
end

function var_0_0.CanSwitch(arg_33_0)
	return not arg_33_0.inSwitching
end

function var_0_0.SwitchToDecodeMap(arg_34_0, arg_34_1)
	if arg_34_0.inSwitching then
		return
	end

	if arg_34_1 then
		arg_34_0:EnterDecodeMap()
	else
		arg_34_0:ExitDeCodeMap()
	end

	return
end

function var_0_0.ExitDeCodeMap(arg_35_0)
	arg_35_0.isFirstSwitch = false
	seriesAsync = var_1

	var_1({
		function(arg_36_0)
			local var_36_0 = arg_35_0
			local var_36_1 = var_1.PlayVoice

			DecodeGameConst = var_2_10004

			var_36_1(var_36_0, var_2_10004.PRESS_UP_PASSWORDBTN)

			arg_35_0.finishCnt = 0
			arg_35_0.isInComparison = nil
			arg_35_0.inSwitching = true

			local var_36_2 = arg_35_0.view

			var_1.OnEnterNormalMapBefore(var_36_2, arg_36_0)

			return
		end,
		function(arg_37_0)
			parallelAsync = var_2_10001

			var_2_10001({
				function(arg_38_0)
					local var_38_0 = arg_35_0.view

					var_1.OnEnterNormalMap(var_38_0, arg_35_0.model.map, arg_38_0)

					return
				end,
				function(arg_39_0)
					arg_35_0.mapId = arg_35_0.model.map.id

					local var_39_0 = arg_35_0.view

					var_1.OnEnterMap(var_39_0, arg_35_0.mapId, false, arg_39_0)

					return
				end
			}, arg_37_0)

			return
		end,
		function()
			local var_40_0 = arg_35_0.model

			var_0.ClearMapKeys(var_40_0)

			local var_40_1 = arg_35_0

			var_0.UpdateProgress(var_40_1)

			arg_35_0.isInDecodeMap = nil
			arg_35_0.inSwitching = nil

			local var_40_2 = arg_35_0

			var_0.ShowTip(var_40_2)

			return
		end
	})

	return
end

function var_0_0.EnterDecodeMap(arg_41_0)
	arg_41_0.isInDecodeMap = true
	arg_41_0.isFirstSwitch = true
	seriesAsync = var_1

	var_1({
		function(arg_42_0)
			local var_42_0 = arg_41_0
			local var_42_1 = var_1.PlayVoice

			DecodeGameConst = var_2_10004

			var_42_1(var_42_0, var_2_10004.PRESS_DOWN_PASSWORDBTN)

			local var_42_2 = arg_41_0

			var_42_2.inSwitching = true
			parallelAsync = var_42_2

			var_42_2({
				function(arg_43_0)
					local var_43_0 = arg_41_0.view

					var_1.OnEnterDecodeMapBefore(var_43_0, arg_43_0)

					return
				end,
				function(arg_44_0)
					local var_44_0 = arg_41_0.view

					var_1.OnExitMap(var_44_0, arg_41_0.mapId, true, arg_44_0)

					return
				end
			}, arg_42_0)

			return
		end,
		function(arg_45_0)
			arg_41_0.mapId = nil

			local var_45_0 = arg_41_0.model
			local var_45_1 = var_1.GetMapKeyStrs(var_45_0)
			local var_45_2 = arg_41_0.view

			var_2.OnEnterDecodeMap(var_45_2, var_45_1, arg_45_0)

			return
		end,
		function(arg_46_0)
			local var_46_0 = arg_41_0

			var_1.ShowTip(var_46_0)

			arg_41_0.inSwitching = nil

			return
		end
	})

	return
end

function var_0_0.ExitGame(arg_47_0)
	if arg_47_0.inSwitching then
		return
	end

	if arg_47_0.exitCallBack then
		arg_47_0.exitCallBack()
	end

	return
end

function var_0_0.PlayVoice(arg_48_0, arg_48_1)
	if arg_48_1 and arg_48_1 ~= "" then
		local var_48_0 = arg_48_0.view

		var_2.PlayVoice(var_48_0, arg_48_1)
	end

	return
end

function var_0_0.GetSaveData(arg_49_0)
	return arg_49_0.model.unlocks
end

function var_0_0.Dispose(arg_50_0)
	local var_50_0 = arg_50_0.model

	var_1.Dispose(var_50_0)

	local var_50_1 = arg_50_0.view

	var_1.Dispose(var_50_1)

	return
end

return var_0_0
