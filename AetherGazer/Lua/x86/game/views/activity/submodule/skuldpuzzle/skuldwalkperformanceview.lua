local var_0_0 = class("SkuldWalkPerformanceView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Skuld/Activity_Skuld_WalkUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.skuldSpine_ = arg_4_0.skuldGo_:GetComponent("Spine.Unity.SkeletonGraphic")
	arg_4_0.adminSpine_ = arg_4_0.adminGo_:GetComponent("Spine.Unity.SkeletonGraphic")
	arg_4_0.peopleController_ = arg_4_0.controllerEx_:GetController("people")
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.bgbtn_, nil, function()
		if arg_5_0.isClickBg then
			arg_5_0.isClickBg = false

			arg_5_0:OnBgBtn()
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnSkip_, nil, function()
		arg_5_0.skuldSpine_.AnimationState:SetAnimation(0, "idle", true)
		arg_5_0.adminSpine_.AnimationState:SetAnimation(0, "idle", true)

		arg_5_0.bgTrans_.localPosition = arg_5_0.startPos

		arg_5_0:StopMoveTimer()
		JumpTools.OpenPageByJump("skuldPuzzleSettleView", {
			levelID = arg_5_0.params_.levelID,
			rewardList = arg_5_0.params_.rewardList
		}, nil, true)
	end)
end

function var_0_0.OnBgBtn(arg_8_0)
	SetActive(arg_8_0.talkGo_, false)

	if arg_8_0.num >= #arg_8_0.actions_list then
		JumpTools.OpenPageByJump("skuldPuzzleSettleView", {
			levelID = arg_8_0.params_.levelID,
			rewardList = arg_8_0.params_.rewardList
		}, nil, true)

		return
	end

	arg_8_0:BgSpriteMove()
end

function var_0_0.OnTop(arg_9_0)
	arg_9_0:UpdateBar()
end

function var_0_0.UpdateBar(arg_10_0)
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
end

function var_0_0.OnEnter(arg_11_0)
	if arg_11_0.params_.stage_id then
		arg_11_0.stage_id = arg_11_0.params_.stage_id
	end

	arg_11_0.pointSpot = {}
	arg_11_0.isClickBg = false
	arg_11_0.isFirst = arg_11_0.params_.isFirst
	arg_11_0.num = 0
	arg_11_0.isMove = true
	arg_11_0.reachList = {}
	arg_11_0.puzzleCfg = SkuldPuzzleStageCfg[arg_11_0.stage_id]
	arg_11_0.characterType = arg_11_0.puzzleCfg.character
	arg_11_0.actions_list = arg_11_0.puzzleCfg.actions_list
	arg_11_0.spot_list = arg_11_0.puzzleCfg.spot_list
	arg_11_0.startPos = arg_11_0.bgTrans_.localPosition

	arg_11_0.peopleController_:SetSelectedIndex(arg_11_0.characterType - 1)

	arg_11_0.skuldPos = arg_11_0.skuldTrans_.localPosition
	arg_11_0.adminPos = arg_11_0.adminTrans_.localPosition
	arg_11_0.skuldSpine_.initialSkinName = arg_11_0.puzzleCfg.skuld_skin

	arg_11_0.skuldSpine_.Initialize(arg_11_0.skuldSpine_, true)

	arg_11_0.lastUpdateTime_role = Time.time

	for iter_11_0 = 1, #arg_11_0.actions_list do
		arg_11_0.reachList[iter_11_0] = {
			isReach = false
		}
	end

	arg_11_0:InstantiatePoint()
	SetActive(arg_11_0.talkGo_, false)
	SetActive(arg_11_0.btnSkip_.gameObject, not arg_11_0.isFirst)
	arg_11_0:RoleStartMove()
end

function var_0_0.OnEnterOver(arg_12_0)
	SkuldSystemAction.RefreshAudio()
end

function var_0_0.RoleStartMove(arg_13_0)
	if arg_13_0.characterType == 1 then
		arg_13_0.skuldSpine_.AnimationState:SetAnimation(0, "walk", true)
		manager.audio:PlayEffect("minigame_activity_4_0", "minigame_activity_4_0_pintu_walk01", "")
	elseif arg_13_0.characterType == 2 then
		arg_13_0.adminSpine_.AnimationState:SetAnimation(0, "walk", true)
		manager.audio:PlayEffect("minigame_activity_4_0", "minigame_activity_4_0_pintu_walk01", "")
	elseif arg_13_0.characterType == 3 then
		arg_13_0.skuldSpine_.AnimationState:SetAnimation(0, "walk", true)
		arg_13_0.adminSpine_.AnimationState:SetAnimation(0, "walk", true)
		manager.audio:PlayEffect("minigame_activity_4_0", "minigame_activity_4_0_pintu_walk03", "")
	elseif arg_13_0.characterType == 4 then
		arg_13_0.skuldSpine_.AnimationState:SetAnimation(0, "walk", true)
		manager.audio:PlayEffect("minigame_activity_4_0", "minigame_activity_4_0_pintu_walk01", "")
	end

	arg_13_0:StopMoveRoleTimer()

	arg_13_0.moveRoleTimer_ = FrameTimer.New(function()
		local var_14_0 = Time.time
		local var_14_1 = var_14_0 - arg_13_0.lastUpdateTime_role
		local var_14_2 = arg_13_0.skuldTrans_.localPosition
		local var_14_3 = arg_13_0.adminTrans_.localPosition
		local var_14_4 = GameSetting.skuld_walk_speed.value[1] * var_14_1

		if arg_13_0.skuldTrans_.localPosition.x >= GameSetting.skuld_walk_distance.value[1] then
			arg_13_0.skuldTrans_.localPosition = Vector3.New(var_14_2.x, var_14_2.y, var_14_2.z)
			arg_13_0.adminTrans_.localPosition = Vector3.New(var_14_3.x, var_14_3.y, var_14_3.z)

			arg_13_0:BgSpriteMove()
			arg_13_0:StopMoveRoleTimer()
		else
			arg_13_0.skuldTrans_.localPosition = Vector3.New(var_14_2.x + var_14_4, var_14_2.y, var_14_2.z)
			arg_13_0.adminTrans_.localPosition = Vector3.New(var_14_3.x + var_14_4, var_14_3.y, var_14_3.z)
		end

		arg_13_0.lastUpdateTime_role = var_14_0
	end, 1, -1)

	arg_13_0.moveRoleTimer_:Start()
end

function var_0_0.StopMoveRoleTimer(arg_15_0)
	if arg_15_0.moveRoleTimer_ then
		arg_15_0.moveRoleTimer_:Stop()

		arg_15_0.moveRoleTimer_ = nil
	end
end

function var_0_0.InstantiatePoint(arg_16_0)
	for iter_16_0 = 1, #arg_16_0.spot_list do
		local var_16_0 = Asset.Load("Widget/System/Activity_Skuld/walking/" .. arg_16_0.spot_list[iter_16_0])
		local var_16_1 = Object.Instantiate(var_16_0, arg_16_0["point_" .. iter_16_0])

		arg_16_0.pointSpot[iter_16_0] = var_16_1
	end
end

function var_0_0.StopMoveTimer(arg_17_0)
	if arg_17_0.moveTimer_ then
		arg_17_0.moveTimer_:Stop()

		arg_17_0.moveTimer_ = nil
	end
end

function var_0_0.BgSpriteMove(arg_18_0)
	arg_18_0:StopMoveTimer()

	arg_18_0.moveTimer_ = FrameTimer.New(function()
		arg_18_0:StopMoveRoleTimer()

		if arg_18_0.characterType == 1 then
			if arg_18_0.skuldSpine_.AnimationState:GetCurrent(0).Animation.Name ~= "walk" then
				arg_18_0.skuldSpine_.AnimationState:SetAnimation(0, "walk", true)

				if #arg_18_0.actions_list > 1 then
					manager.audio:PlayEffect("minigame_activity_4_0", "minigame_activity_4_0_pintu_walk02", "")
				end
			end
		elseif arg_18_0.characterType == 2 then
			if arg_18_0.adminSpine_.AnimationState:GetCurrent(0).Animation.Name ~= "walk" then
				arg_18_0.adminSpine_.AnimationState:SetAnimation(0, "walk", true)

				if #arg_18_0.actions_list > 1 then
					manager.audio:PlayEffect("minigame_activity_4_0", "minigame_activity_4_0_pintu_walk02", "")
				end
			end
		elseif arg_18_0.characterType == 3 then
			if arg_18_0.skuldSpine_.AnimationState:GetCurrent(0).Animation.Name ~= "walk" then
				arg_18_0.skuldSpine_.AnimationState:SetAnimation(0, "walk", true)
				arg_18_0.adminSpine_.AnimationState:SetAnimation(0, "walk", true)

				if #arg_18_0.actions_list > 1 then
					manager.audio:PlayEffect("minigame_activity_4_0", "minigame_activity_4_0_pintu_walk04", "")
				end
			end
		elseif arg_18_0.characterType == 4 and arg_18_0.skuldSpine_.AnimationState:GetCurrent(0).Animation.Name ~= "walk" then
			arg_18_0.skuldSpine_.AnimationState:SetAnimation(0, "walk", true)

			if #arg_18_0.actions_list > 1 then
				manager.audio:PlayEffect("minigame_activity_4_0", "minigame_activity_4_0_pintu_walk02", "")
			end
		end

		local var_19_0 = arg_18_0.skuldTrans_.localPosition
		local var_19_1 = arg_18_0.adminTrans_.localPosition

		arg_18_0.skuldTrans_.localPosition = Vector3.New(var_19_0.x, var_19_0.y, var_19_0.z)
		arg_18_0.adminTrans_.localPosition = Vector3.New(var_19_1.x, var_19_1.y, var_19_1.z)

		local var_19_2 = Time.time
		local var_19_3 = var_19_2 - arg_18_0.lastUpdateTime_bg
		local var_19_4 = arg_18_0.bgTrans_.localPosition
		local var_19_5 = GameSetting.skuld_walk_speed.value[1] * var_19_3

		arg_18_0.bgTrans_.localPosition = Vector3.New(var_19_4.x - var_19_5, var_19_4.y, var_19_4.z)

		arg_18_0:IsReachTargetPoint(arg_18_0.bgTrans_.localPosition.x)

		arg_18_0.lastUpdateTime_bg = var_19_2
	end, 1, -1)
	arg_18_0.lastUpdateTime_bg = Time.time

	arg_18_0.moveTimer_:Start()
end

function var_0_0.IsReachTargetPoint(arg_20_0, arg_20_1)
	for iter_20_0 = 1, #arg_20_0.actions_list do
		if math.abs(arg_20_0["point_" .. iter_20_0].position.x - arg_20_0.skuldTrans_.position.x) <= 1 and not arg_20_0.reachList[iter_20_0].isReach then
			arg_20_0.isClickBg = true

			local var_20_0 = arg_20_0.actions_list[iter_20_0]
			local var_20_1 = var_20_0[math.random(1, #var_20_0)]
			local var_20_2 = ActivitySkuldWalkingCfg[var_20_1]

			if arg_20_0.characterType == 1 then
				arg_20_0.skuldSpine_.AnimationState:SetAnimation(0, var_20_2.skuld_action, false)
				manager.audio:StopEffect()
				arg_20_0:SetOnceSkuldTimer()
			elseif arg_20_0.characterType == 2 then
				arg_20_0.adminSpine_.AnimationState:SetAnimation(0, var_20_2.admin_action, false)
				manager.audio:StopEffect()
				arg_20_0:SetOnceAdminTimer()
			elseif arg_20_0.characterType == 3 then
				arg_20_0.skuldSpine_.AnimationState:SetAnimation(0, var_20_2.skuld_action, false)
				arg_20_0.adminSpine_.AnimationState:SetAnimation(0, var_20_2.admin_action, false)
				manager.audio:StopEffect()
				arg_20_0:SetOnceSkuldTimer()
				arg_20_0:SetOnceAdminTimer()
			elseif arg_20_0.characterType == 4 then
				arg_20_0.skuldSpine_.AnimationState:SetAnimation(0, var_20_2.skuld_action, false)
				manager.audio:StopEffect()
				arg_20_0:SetOnceSkuldTimer()
			end

			arg_20_0:StopMoveTimer()
			SetActive(arg_20_0.talkGo_, true)
			arg_20_0:RefreshTalk(iter_20_0)

			arg_20_0.num = arg_20_0.num + 1
			arg_20_0.reachList[iter_20_0] = {
				isReach = true
			}

			break
		end
	end
end

function var_0_0.StopOnceTimer(arg_21_0)
	if arg_21_0.onceTimer_ then
		arg_21_0.onceTimer_:Stop()

		arg_21_0.onceTimer_ = nil
	end
end

function var_0_0.SetOnceSkuldTimer(arg_22_0)
	arg_22_0:StopOnceTimer()

	arg_22_0.onceTimer_ = FrameTimer.New(function()
		local var_23_0 = arg_22_0.skuldSpine_.AnimationState:GetCurrent(0)

		if var_23_0.Animation.Name ~= "idle" and var_23_0.IsComplete == true then
			arg_22_0.skuldSpine_.AnimationState:SetAnimation(0, "idle", true)
			manager.audio:StopEffect()
			arg_22_0:StopOnceTimer()
		end
	end, 1, -1)

	arg_22_0.onceTimer_:Start()
end

function var_0_0.StopOnceAdminTimer(arg_24_0)
	if arg_24_0.onceAdminTimer_ then
		arg_24_0.onceAdminTimer_:Stop()

		arg_24_0.onceAdminTimer_ = nil
	end
end

function var_0_0.SetOnceAdminTimer(arg_25_0)
	arg_25_0:StopOnceAdminTimer()

	arg_25_0.onceAdminTimer_ = FrameTimer.New(function()
		local var_26_0 = arg_25_0.adminSpine_.AnimationState:GetCurrent(0)

		if var_26_0.Animation.Name ~= "idle" and var_26_0.IsComplete == true then
			arg_25_0.adminSpine_.AnimationState:SetAnimation(0, "idle", true)
			manager.audio:StopEffect()
			arg_25_0:StopOnceAdminTimer()
		end
	end, 1, -1)

	arg_25_0.onceAdminTimer_:Start()
end

function var_0_0.RefreshTalk(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_0.actions_list[arg_27_1]
	local var_27_1 = var_27_0[math.random(1, #var_27_0)]
	local var_27_2 = ActivitySkuldWalkingCfg[var_27_1]

	arg_27_0.talkText_.text = var_27_2.skuld_chat
end

function var_0_0.OnExit(arg_28_0)
	arg_28_0:RemoveAllEventListener()
	arg_28_0:StopMoveTimer()
	arg_28_0:StopOnceTimer()
	arg_28_0:StopOnceAdminTimer()
	arg_28_0:StopMoveRoleTimer()
	arg_28_0.skuldSpine_.AnimationState:SetAnimation(0, "idle", true)
	arg_28_0.adminSpine_.AnimationState:SetAnimation(0, "idle", true)

	arg_28_0.bgTrans_.localPosition = arg_28_0.startPos
	arg_28_0.skuldTrans_.localPosition = arg_28_0.skuldPos
	arg_28_0.adminTrans_.localPosition = arg_28_0.adminPos

	for iter_28_0 = 1, #arg_28_0.pointSpot do
		Object.Destroy(arg_28_0.pointSpot[iter_28_0])

		arg_28_0.pointSpot[iter_28_0] = nil
	end
end

function var_0_0.Dispose(arg_29_0)
	if arg_29_0.reachList then
		arg_29_0.reachList = nil
	end

	for iter_29_0 = 1, #arg_29_0.pointSpot do
		Object.Destroy(arg_29_0.pointSpot[iter_29_0])

		arg_29_0.pointSpot[iter_29_0] = nil
	end

	arg_29_0.pointSpot = nil

	arg_29_0.super.Dispose(arg_29_0)
end

return var_0_0
