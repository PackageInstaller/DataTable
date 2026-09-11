local var_0_0 = {
	LoadScene = function(self, arg_1_1, arg_1_2)
		self.eventID = arg_1_1
		self.callback_ = arg_1_2
		self.assetSetDone = false

		local var_1_0 = SceneManager.GetSceneByName("X110")

		if var_1_0 and var_1_0.isLoaded == true then
			return
		end

		self.operation_ = Asset.LoadLevelAsync("Levels/X110", true)

		if self.timer_ then
			self.timer_:Stop()

			self.timer_ = nil
		end

		manager.ui:SetMainCamera("tastefood")

		manager.ui.mainCameraCom_.fieldOfView = 1.77 / (Screen.width / Screen.height) * CameraCfg.tastefood.fieldOfView

		if Screen.width / Screen.height <= 1.34 then
			manager.ui.mainCameraCom_.fieldOfView = manager.ui.mainCameraCom_.fieldOfView - 3
		end

		self.timer_ = FrameTimer.New(handler(self, self.Process), 1, -1)

		self.timer_:Start()

		whereami = "battle"
	end,
	UnLoadScene = function(arg_2_0)
		local var_2_0 = SceneManager.GetSceneByName("X110")

		if var_2_0 and var_2_0.isLoaded == true then
			SceneManager.UnloadSceneAsync("X110")
		end
	end,
	Process = function(self)
		local var_3_0 = SceneManager.GetSceneByName("X110")

		if var_3_0 and var_3_0.isLoaded then
			self:LoadPrefab(self.eventID)

			self.assetSetDone = true

			if self.callback_ then
				self.callback_()
			end
		end

		if self.assetSetDone then
			self.timer_:Stop()

			self.timer_ = nil
		end
	end,
	LoadPrefab = function(arg_4_0, arg_4_1)
		local var_4_0 = SummerPubHeroCfg[arg_4_1]
		local var_4_1 = SceneManager.GetSceneByName("X110"):GetRootGameObjects()

		if var_4_1 then
			local var_4_2

			for iter_4_0 = 0, var_4_1.Length - 1 do
				local var_4_3 = var_4_1[iter_4_0].transform:Find("rolePos")

				if var_4_3 then
					var_4_2 = var_4_3
					var_4_3.transform.localPosition = Vector3(SummerPubHeroCfg[arg_4_1].rolePos[1], SummerPubHeroCfg[arg_4_1].rolePos[2], SummerPubHeroCfg[arg_4_1].rolePos[3])

					break
				end
			end

			if var_4_2.childCount > 0 then
				for iter_4_1, iter_4_2 in ipairs(var_4_2:GetChildren()) do
					Object.DestroyImmediate(iter_4_2.gameObject)
				end
			end

			local var_4_4 = Object.Instantiate((Asset.Load("Char/" .. SummerPubHeroCfg[arg_4_1].food_3d_profile .. "ui_story")))
			local var_4_5 = var_4_4:GetComponent(typeof(UnityEngine.Animator))

			if var_4_5 then
				var_4_5:Play("action1_1", 0, 0)
			end

			FrameTimer.New(function()
				local var_5_0 = Quaternion.Euler(0, 180, 0)

				if var_4_0.rolePos_rotate and var_4_0.rolePos_rotate ~= "" then
					var_5_0 = Quaternion.Euler(var_4_0.rolePos_rotate[1], 180 + var_4_0.rolePos_rotate[2], var_4_0.rolePos_rotate[3])
				end

				var_4_4.transform:SetParent(var_4_2)

				var_4_4.transform.localPosition = Vector3.zero
				var_4_4.transform.localRotation = var_5_0
				var_4_4.transform.localScale = Vector3.one
			end, 1, 1):Start()

			for iter_4_3 = 0, var_4_1.Length - 1 do
				local var_4_7 = var_4_1[iter_4_3].transform:Find("Bg")

				if var_4_7 then
					if arg_4_1 == 40301 then
						var_4_7:GetComponent("SpriteRenderer").sprite = pureGetSpriteWithoutAtlas("TextureBg/Activity_SummerPub/MainPub/SummerPub_bg_02.png")

						break
					end

					var_4_7:GetComponent("SpriteRenderer").sprite = pureGetSpriteWithoutAtlas("TextureBg/Activity_SummerPub/MainPub/SummerPub_bg_01.png")

					break
				end
			end
		end
	end,
	LevelIsDone = function(self)
		return not self.operation_ or self.operation_:IsDone()
	end,
	OnLogout = function(self)
		self:UnLoadScene()
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
	local var_10_0 = 0

	for iter_10_0, iter_10_1 in ipairs(AssignmentCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_NYA_SUMMER_PUB]) do
		local var_10_1 = TaskData2:GetTask(iter_10_1)

		if var_10_1 and var_10_1.complete_flag == 1 then
			var_10_0 = var_10_0 + 1
		elseif var_10_1 then
			if AssignmentCfg[iter_10_1].need <= (var_10_1.progress or 0) then
				var_10_0 = var_10_0 + 1
			end
		end
	end

	return var_10_0, #AssignmentCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_NYA_SUMMER_PUB]
end

return var_0_0
