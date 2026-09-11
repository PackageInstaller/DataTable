local var_0_0 = {}
local var_0_1, var_0_2 = pcall(require, "bit")

if not var_0_1 then
	local var_0_3

	var_0_3, var_0_2 = pcall(require, "bit32")
end

function var_0_0:Enter(arg_1_1, arg_1_2)
	self.bubbleView = SimBusinessBubbleView.New()

	self:InitClearObstacleTipsBubble()

	self.curMap = arg_1_1
	self.cinemachineBrain = manager.ui.mainCamera:GetComponent("CinemachineBrain")
	self.cinemachineBrain.enabled = true
	manager.ui.mainCamera:GetComponent("PhysicsRaycaster").eventMask = var_0_2.band(UnityEngine.Physics.DefaultRaycastLayers, var_0_2.bnot(LayerMask.GetMask("obstacle")))

	SimBusinessMgr.SetupCameraEventTriggerAtMainCamFarClip()
	SimBusinessMgr.LoadNavGraph("Map/Dorm/sim_business_graph")
	SimBusinessGame.GetInstance():Init(arg_1_2.stage)
	var_0_0.GoToMainPage(arg_1_2.stage)
	SimBusinessTools.SetFlag("quickEditShelf", true)
end

function var_0_0:Exit()
	SimBusinessData:CleanupEditCache()
	SimBusinessGame.GetInstance():Reset()
	self.bubbleView:Dispose()

	self.cinemachineBrain = nil
	self.curMap = nil
end

function var_0_0.GoToMainPage(arg_3_0)
	JumpTools.OpenPageByJump("/activitySummerSimBusinessMain", {
		stageID = arg_3_0
	}, nil, true)
end

function var_0_0.EnterLevel(arg_4_0)
	local var_4_1 = DormMinigame.GetCurBridgeCls()

	if SimBusinessMapCfg[SimBusinessStageCfg[arg_4_0].scene].scene ~= ((var_4_1 == var_0_0 or nil) and var_4_1.curMap) then
		DormMinigame.Launch(SimBusinessMapCfg[SimBusinessStageCfg[arg_4_0].scene].scene, SimBusinessBridge, {
			activity = SimBusinessData.activityID,
			stage = arg_4_0
		})
	else
		SimBusinessGame.GetInstance():ResetStage(arg_4_0)
	end
end

function var_0_0.Back()
	if SimBusinessTools.IsChallengeLevel(SimBusinessGame.GetInstance().stage) then
		local var_5_0 = SimBusinessTools.GetDefaultEnterDailyLevel()

		if var_5_0 then
			var_0_0.EnterLevel(var_5_0)

			return
		end
	end

	DormMinigame.Exit()
end

function var_0_0.ObstacleNamespace(arg_6_0)
	return "sim.obstacle.level_" .. arg_6_0
end

function var_0_0:InitClearObstacleTipsBubble()
	for iter_7_0 = 1, SimBusinessData:GetSimBusinessMaxLevel() - 1 do
		for iter_7_1, iter_7_2 in Dorm.storage:ForeachData(var_0_0.ObstacleNamespace(iter_7_0), pairs) do
			self.bubbleView:EmplaceBubble(iter_7_2.transform, SimBusinessClearObstacleTips, iter_7_0, iter_7_2.transform)
		end
	end
end

function var_0_0:LevelObstacleTipsSetVisible(arg_8_1, arg_8_2)
	for iter_8_0, iter_8_1 in Dorm.storage:ForeachData(var_0_0.ObstacleNamespace(arg_8_1), pairs) do
		self.bubbleView:GetBubble(iter_8_1.transform):SetActive(arg_8_2)

		local var_8_0 = iter_8_1:GetComponent("Collider")

		if arg_8_2 then
			SimBusinessMgr.instance:ShowOccupyRectVfx(var_8_0)
		else
			SimBusinessMgr.instance:RemoveOccupyRectVfx(var_8_0)
		end
	end
end

return var_0_0
