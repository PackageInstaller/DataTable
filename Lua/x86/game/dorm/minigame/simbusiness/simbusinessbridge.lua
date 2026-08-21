local var_0_0 = {}
local var_0_1, var_0_2 = pcall(require, "bit")

if not var_0_1 then
	local var_0_3

	var_0_3, var_0_2 = pcall(require, "bit32")
end

function var_0_0.Enter(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.bubbleView = SimBusinessBubbleView.New()

	arg_1_0:InitClearObstacleTipsBubble()

	arg_1_0.curMap = arg_1_1
	arg_1_0.cinemachineBrain = manager.ui.mainCamera:GetComponent("CinemachineBrain")
	arg_1_0.cinemachineBrain.enabled = true
	manager.ui.mainCamera:GetComponent("PhysicsRaycaster").eventMask = var_0_2.band(UnityEngine.Physics.DefaultRaycastLayers, var_0_2.bnot(LayerMask.GetMask("obstacle")))

	SimBusinessMgr.SetupCameraEventTriggerAtMainCamFarClip()
	SimBusinessMgr.LoadNavGraph("Map/Dorm/sim_business_graph")
	SimBusinessGame.GetInstance():Init(arg_1_2.stage)
	var_0_0.GoToMainPage(arg_1_2.stage)
	SimBusinessTools.SetFlag("quickEditShelf", true)
end

function var_0_0.Exit(arg_2_0)
	SimBusinessData:CleanupEditCache()
	SimBusinessGame.GetInstance():Reset()
	arg_2_0.bubbleView:Dispose()

	arg_2_0.cinemachineBrain = nil
	arg_2_0.curMap = nil
end

function var_0_0.GoToMainPage(arg_3_0)
	JumpTools.OpenPageByJump("/activitySummerSimBusinessMain", {
		stageID = arg_3_0
	}, nil, true)
end

function var_0_0.EnterLevel(arg_4_0)
	local var_4_0
	local var_4_1 = DormMinigame.GetCurBridgeCls()

	if var_4_1 == var_0_0 then
		var_4_0 = var_4_1.curMap
	end

	local var_4_2 = SimBusinessStageCfg[arg_4_0].scene
	local var_4_3 = SimBusinessMapCfg[var_4_2].scene

	if var_4_3 ~= var_4_0 then
		DormMinigame.Launch(var_4_3, SimBusinessBridge, {
			activity = SimBusinessData.activityID,
			stage = arg_4_0
		})
	else
		SimBusinessGame.GetInstance():ResetStage(arg_4_0)
	end
end

function var_0_0.Back()
	local var_5_0 = SimBusinessGame.GetInstance().stage

	if SimBusinessTools.IsChallengeLevel(var_5_0) then
		local var_5_1 = SimBusinessTools.GetDefaultEnterDailyLevel()

		if var_5_1 then
			var_0_0.EnterLevel(var_5_1)

			return
		end
	end

	DormMinigame.Exit()
end

function var_0_0.ObstacleNamespace(arg_6_0)
	return "sim.obstacle.level_" .. arg_6_0
end

function var_0_0.InitClearObstacleTipsBubble(arg_7_0)
	local var_7_0 = SimBusinessData:GetSimBusinessMaxLevel()

	for iter_7_0 = 1, var_7_0 - 1 do
		local var_7_1 = var_0_0.ObstacleNamespace(iter_7_0)

		for iter_7_1, iter_7_2 in Dorm.storage:ForeachData(var_7_1, pairs) do
			local var_7_2 = iter_7_2.transform

			arg_7_0.bubbleView:EmplaceBubble(var_7_2, SimBusinessClearObstacleTips, iter_7_0, var_7_2)
		end
	end
end

function var_0_0.LevelObstacleTipsSetVisible(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = var_0_0.ObstacleNamespace(arg_8_1)

	for iter_8_0, iter_8_1 in Dorm.storage:ForeachData(var_8_0, pairs) do
		local var_8_1 = iter_8_1.transform

		arg_8_0.bubbleView:GetBubble(var_8_1):SetActive(arg_8_2)

		local var_8_2 = iter_8_1:GetComponent("Collider")

		if arg_8_2 then
			SimBusinessMgr.instance:ShowOccupyRectVfx(var_8_2)
		else
			SimBusinessMgr.instance:RemoveOccupyRectVfx(var_8_2)
		end
	end
end

return var_0_0
