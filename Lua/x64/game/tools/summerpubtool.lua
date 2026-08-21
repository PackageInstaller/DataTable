local var_0_0 = {
	LoadScene = function(arg_1_0, arg_1_1, arg_1_2)
		arg_1_0.eventID = arg_1_1
		arg_1_0.callback_ = arg_1_2
		arg_1_0.assetSetDone = false

		local var_1_0 = SceneManager.GetSceneByName("X110")

		if var_1_0 and var_1_0.isLoaded == true then
			return
		end

		arg_1_0.operation_ = Asset.LoadLevelAsync("Levels/X110", true)

		if arg_1_0.timer_ then
			arg_1_0.timer_:Stop()

			arg_1_0.timer_ = nil
		end

		manager.ui:SetMainCamera("tastefood")

		local var_1_1 = manager.ui.mainCameraCom_
		local var_1_2 = Screen.width / Screen.height

		var_1_1.fieldOfView = 1.77 / var_1_2 * CameraCfg.tastefood.fieldOfView

		if var_1_2 <= 1.34 then
			var_1_1.fieldOfView = var_1_1.fieldOfView - 3
		end

		arg_1_0.timer_ = FrameTimer.New(handler(arg_1_0, arg_1_0.Process), 1, -1)

		arg_1_0.timer_:Start()

		whereami = "battle"
	end,
	UnLoadScene = function(arg_2_0)
		local var_2_0 = SceneManager.GetSceneByName("X110")

		if var_2_0 and var_2_0.isLoaded == true then
			SceneManager.UnloadSceneAsync("X110")
		end
	end,
	Process = function(arg_3_0)
		local var_3_0 = SceneManager.GetSceneByName("X110")

		if var_3_0 and var_3_0.isLoaded then
			arg_3_0:LoadPrefab(arg_3_0.eventID)

			arg_3_0.assetSetDone = true

			if arg_3_0.callback_ then
				arg_3_0.callback_()
			end
		end

		if arg_3_0.assetSetDone then
			arg_3_0.timer_:Stop()

			arg_3_0.timer_ = nil
		end
	end,
	LoadPrefab = function(arg_4_0, arg_4_1)
		local var_4_0 = SceneManager.GetSceneByName("X110")
		local var_4_1 = SummerPubHeroCfg[arg_4_1]
		local var_4_2 = "Char/" .. var_4_1.food_3d_profile .. "ui_story"
		local var_4_3 = var_4_0:GetRootGameObjects()

		if var_4_3 then
			local var_4_4

			for iter_4_0 = 0, var_4_3.Length - 1 do
				local var_4_5 = var_4_3[iter_4_0].transform:Find("rolePos")

				if var_4_5 then
					var_4_4 = var_4_5
					var_4_4.transform.localPosition = Vector3(var_4_1.rolePos[1], var_4_1.rolePos[2], var_4_1.rolePos[3])

					break
				end
			end

			if var_4_4.childCount > 0 then
				for iter_4_1, iter_4_2 in ipairs(var_4_4:GetChildren()) do
					Object.DestroyImmediate(iter_4_2.gameObject)
				end
			end

			local var_4_6 = Asset.Load(var_4_2)
			local var_4_7 = Object.Instantiate(var_4_6)
			local var_4_8 = var_4_7:GetComponent(typeof(UnityEngine.Animator))

			if var_4_8 then
				var_4_8:Play("action1_1", 0, 0)
			end

			FrameTimer.New(function()
				local var_5_0 = Quaternion.Euler(0, 180, 0)

				if var_4_1.rolePos_rotate and var_4_1.rolePos_rotate ~= "" then
					var_5_0 = Quaternion.Euler(var_4_1.rolePos_rotate[1], 180 + var_4_1.rolePos_rotate[2], var_4_1.rolePos_rotate[3])
				end

				var_4_7.transform:SetParent(var_4_4)

				var_4_7.transform.localPosition = Vector3.zero
				var_4_7.transform.localRotation = var_5_0
				var_4_7.transform.localScale = Vector3.one
			end, 1, 1):Start()

			local var_4_9

			for iter_4_3 = 0, var_4_3.Length - 1 do
				local var_4_10 = var_4_3[iter_4_3].transform:Find("Bg")

				if var_4_10 then
					local var_4_11 = var_4_10

					if arg_4_1 == 40301 then
						var_4_11:GetComponent("SpriteRenderer").sprite = pureGetSpriteWithoutAtlas("TextureBg/Activity_SummerPub/MainPub/SummerPub_bg_02.png")

						break
					end

					var_4_11:GetComponent("SpriteRenderer").sprite = pureGetSpriteWithoutAtlas("TextureBg/Activity_SummerPub/MainPub/SummerPub_bg_01.png")

					break
				end
			end
		end
	end,
	LevelIsDone = function(arg_6_0)
		return not arg_6_0.operation_ or arg_6_0.operation_:IsDone()
	end,
	OnLogout = function(arg_7_0)
		arg_7_0:UnLoadScene()
	end
}

local function var_0_1()
	gameContext:SetUrlAndParams("/summerPubEnterView")
end

function var_0_0.MainToEnterView(arg_9_0)
	local var_9_0 = SummerPubData:getWaitCook()
	local var_9_1 = SummerPubCookCfg[var_9_0]
	local var_9_2 = SummerPubData:GetCookStateByStageID(var_9_0) == SummerPubConst.COOK_STATE.FINISH_COOK

	if SummerPubData:GetClearNumByStageID(SummerPubConst.FIRST_LEVEL_ID) <= 0 then
		SummerPubAction.OpenBattle(SummerPubConst.FIRST_LEVEL_ID, 1, BattleConst.STAGE_TYPE_NEW.SUMMER_PUB, var_0_1)
	elseif SummerPubData:GetClearNumByStageID(SummerPubConst.SECOND_LEVEL_ID) <= 0 then
		gameContext:SetUrlAndParams("/summerPubEnterView")
		JumpTools.OpenPageByJump("/summerPubStageView")
	elseif var_9_1 and var_9_1.taste_cg_id and var_9_1.taste_cg_id ~= "" and var_9_2 then
		gameContext:SetUrlAndParams("/summerPubEnterView")
		gameContext:SetUrlAndParams("/summerPubPartnerView", {
			isBack = true
		})
		JumpTools.OpenPageByJump("/summerPubToTaskView", {
			cookDishId = var_9_0
		})
	elseif SummerPubData:GetClearNumByStageID(SummerPubConst.SECOND_LEVEL_ID) > 0 and SummerPubData:GetClearNumByStageID(SummerPubConst.THIRD_LEVEL_ID) <= 0 and var_9_0 == 0 then
		SummerPubAction.OpenBattle(SummerPubConst.THIRD_LEVEL_ID, 1, BattleConst.STAGE_TYPE_NEW.SUMMER_PUB, var_0_1)
	else
		JumpTools.OpenPageByJump("/summerPubEnterView")
	end
end

function var_0_0.GetTaskInfo(arg_10_0)
	local var_10_0 = AssignmentCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_NYA_SUMMER_PUB]
	local var_10_1 = 0

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		local var_10_2 = TaskData2:GetTask(iter_10_1)
		local var_10_3 = AssignmentCfg[iter_10_1]

		if var_10_2 and var_10_2.complete_flag == 1 then
			var_10_1 = var_10_1 + 1
		elseif var_10_2 and var_10_3.need <= (var_10_2.progress or 0) then
			var_10_1 = var_10_1 + 1
		end
	end

	return var_10_1, #var_10_0
end

return var_0_0
