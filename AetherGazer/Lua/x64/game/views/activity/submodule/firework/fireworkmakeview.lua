local var_0_0 = class("FireWorkMakeView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/EmptyDream/Firework/FireworkMakeUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.stateController = ControllerUtil.GetController(arg_4_0.transform_, "state")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.m_makeBtn, nil, function()
		arg_5_0:StartGame()
	end)
	arg_5_0.m_fishEvent:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function(arg_7_0, arg_7_1)
		if arg_5_0.stateController:GetSelectedState() == "1" then
			arg_5_0:EndQte()
		end
	end))
	arg_5_0:AddBtnListener(arg_5_0.m_mask, nil, function()
		if arg_5_0.stateController:GetSelectedState() == "1" then
			return
		end

		arg_5_0:Back()
	end)
end

function var_0_0.OnTop(arg_9_0)
	manager.windowBar:SwitchBar({})
end

function var_0_0.OnEnter(arg_10_0)
	if not arg_10_0.params_.start then
		return
	end

	arg_10_0.params_.start = false

	arg_10_0:NewGame()

	if not getData("FireWork", "showHelp") then
		local var_10_0 = GameSetting.activity_firework_describe and GameSetting.activity_firework_describe.value or {}

		JumpTools.OpenPageByJump("gameHelpPro", {
			startIndex = 2,
			pages = var_10_0
		})
		saveData("FireWork", "showHelp", 1)
	end
end

function var_0_0.OnUpdate(arg_11_0)
	if not arg_11_0.params_.start then
		return
	end

	arg_11_0.params_.start = false

	arg_11_0:NewGame()
end

function var_0_0.OnExit(arg_12_0)
	manager.windowBar:HideBar()

	if arg_12_0.timer then
		arg_12_0.timer:Stop()

		arg_12_0.timer = nil
	end

	arg_12_0:RemoveTween()
	manager.audio:PlayEffect("minigame_activity_spring_festival", "minigame_activity_spring_festival_stop", "")
end

function var_0_0.NewGame(arg_13_0)
	arg_13_0.activity_id = arg_13_0.params_.fire_activity_id

	local var_13_0 = ActivityFireWorkCfg[arg_13_0.activity_id]

	arg_13_0.m_name.text = GetI18NText(var_13_0.name)
	arg_13_0.m_des.text = GetI18NText(var_13_0.desc)
	arg_13_0.m_icon.sprite = pureGetSpriteWithoutAtlas("TextureConfig/EmptyDream/letter_role_title/" .. var_13_0.icon)
	arg_13_0.m_arror.localRotation = Quaternion.Euler(0, 0, 0)
	arg_13_0.m_circle.localRotation = Quaternion.Euler(0, 0, 0)
	arg_13_0.m_countDownLab.text = ""
	arg_13_0.m_countDownProgress.fillAmount = 0
	arg_13_0.m_countLab.text = ""

	arg_13_0.stateController:SetSelectedIndex(0)
	SetActive(arg_13_0.m_baozu, false)
end

function var_0_0.StartGame(arg_14_0)
	arg_14_0.countDown = 3

	if arg_14_0.timer then
		arg_14_0.timer:Stop()

		arg_14_0.timer = nil
	end

	arg_14_0:RefreshCountDown()

	arg_14_0.timer = Timer.New(function()
		arg_14_0.countDown = arg_14_0.countDown - 1

		arg_14_0:RefreshCountDown()

		if arg_14_0.countDown <= 0 then
			arg_14_0:StartQte()
		end
	end, 1, 3)

	arg_14_0.timer:Start()
	arg_14_0.stateController:SetSelectedIndex(4)

	arg_14_0.tagret = arg_14_0:RandomAngle()
	arg_14_0.m_circle.localRotation = Quaternion.Euler(0, 0, arg_14_0.tagret)

	arg_14_0.m_circleAnimator:Play("circle", 0, 0)

	arg_14_0.m_countLab.text = GetTips("ACTIVITY_FIRE_WORK_PHASE") .. "1/3"

	SetActive(arg_14_0.m_baozu, true)

	arg_14_0.m_countDownProgress.fillAmount = 1

	manager.audio:PlayEffect("minigame_activity_spring_festival", "minigame_activity_spring_festival_leader", "")
end

function var_0_0.RefreshCountDown(arg_16_0)
	if arg_16_0.countDown > 0 then
		arg_16_0.m_countDownLab.text = arg_16_0.countDown
	else
		arg_16_0.m_countDownLab.text = ""
	end

	if arg_16_0.countDown == 3 then
		manager.audio:PlayEffect("minigame_activity_spring_festival", "minigame_activity_spring_festival_three", "")
	elseif arg_16_0.countDown == 2 then
		manager.audio:PlayEffect("minigame_activity_spring_festival", "minigame_activity_spring_festival_two", "")
	elseif arg_16_0.countDown == 1 then
		manager.audio:PlayEffect("minigame_activity_spring_festival", "minigame_activity_spring_festival_one", "")
	else
		manager.audio:PlayEffect("minigame_activity_spring_festival", "minigame_activity_spring_festival_pointer", "")
	end
end

function var_0_0.StartQte(arg_17_0)
	arg_17_0:RemoveTween()

	arg_17_0.max = 3
	arg_17_0.count = 1
	arg_17_0.m_countLab.text = GetTips("ACTIVITY_FIRE_WORK_PHASE") .. arg_17_0.count .. "/" .. arg_17_0.max

	arg_17_0:DoTween(arg_17_0.tagret)
	arg_17_0.stateController:SetSelectedIndex(1)
	manager.audio:PlayEffect("minigame_activity_spring_festival", "minigame_activity_spring_festival_pointer", "")
end

function var_0_0.DoTween(arg_18_0, arg_18_1)
	arg_18_0.tagret = arg_18_1
	arg_18_0.m_circle.localRotation = Quaternion.Euler(0, 0, arg_18_0.tagret)

	local var_18_0 = arg_18_0.m_arror.localEulerAngles.z

	arg_18_0.m_countDownProgress.transform.localRotation = Quaternion.Euler(0, 0, var_18_0)
	arg_18_0.tween = LeanTween.rotateAroundLocal(arg_18_0.m_arror.gameObject, Vector3.New(0, 0, -1), 360, 2):setOnUpdate(LuaHelper.FloatAction(function(arg_19_0)
		arg_18_0.m_countDownProgress.fillAmount = (360 - arg_19_0) / 360
	end)):setOnComplete(LuaHelper.VoidAction(function()
		arg_18_0:RemoveTween()
		arg_18_0:GotoFail()
	end))
end

function var_0_0.EndQte(arg_21_0)
	local var_21_0 = (arg_21_0.m_arror.localEulerAngles.z + 360) % 360
	local var_21_1 = (arg_21_0.tagret + 360 - var_21_0) % 360

	if var_21_1 <= 35 or var_21_1 >= 325 then
		if var_21_1 <= 15 or var_21_1 >= 345 then
			arg_21_0.count = arg_21_0.count + 1

			SDKTools.SendMessageToSDK("activity_firework_opt", {
				result = 2,
				activity_id = arg_21_0.activity_id
			})

			arg_21_0.m_effectTransform.localRotation = arg_21_0.m_arror.localRotation

			arg_21_0.m_animator:Play("arrow", 0, 0)
			manager.audio:PlayEffect("minigame_activity_spring_festival", "minigame_activity_spring_festival_sign", "")
		else
			SDKTools.SendMessageToSDK("activity_firework_opt", {
				result = 1,
				activity_id = arg_21_0.activity_id
			})
		end

		if arg_21_0.max < arg_21_0.count then
			arg_21_0:RemoveTween()
			arg_21_0:GotoWin()
		else
			arg_21_0.m_countLab.text = GetTips("ACTIVITY_FIRE_WORK_PHASE") .. arg_21_0.count .. "/" .. arg_21_0.max

			local var_21_2 = arg_21_0:RandomAngle()

			arg_21_0:RemoveTween()
			arg_21_0:DoTween(var_21_2)
			arg_21_0.m_circleAnimator:Play("circle", 0, 0)
		end
	else
		SDKTools.SendMessageToSDK("activity_firework_opt", {
			result = 0,
			activity_id = arg_21_0.activity_id
		})
		arg_21_0:RemoveTween()
		arg_21_0:GotoFail()
	end
end

function var_0_0.GotoFail(arg_22_0)
	arg_22_0.stateController:SetSelectedIndex(1)
	JumpTools.OpenPageByJump("fireWorkResult", {
		isWin = false,
		fire_activity_id = arg_22_0.activity_id
	})
	SDKTools.SendMessageToSDK("activity_firework_over", {
		is_success = 0,
		activity_id = arg_22_0.activity_id
	})
	manager.audio:PlayEffect("minigame_activity_spring_festival", "minigame_activity_spring_festival_stop", "")
end

function var_0_0.GotoWin(arg_23_0)
	arg_23_0.stateController:SetSelectedIndex(1)

	if FireWorkData:GetInvited(arg_23_0.activity_id) then
		JumpTools.OpenPageByJump("fireWorkResult", {
			isWin = true,
			fire_activity_id = arg_23_0.activity_id
		})
	else
		FireWorkAction.QueryInvite(arg_23_0.activity_id)
	end

	SDKTools.SendMessageToSDK("activity_firework_over", {
		is_success = 1,
		activity_id = arg_23_0.activity_id
	})
	manager.audio:PlayEffect("minigame_activity_spring_festival", "minigame_activity_spring_festival_stop", "")
end

function var_0_0.RemoveTween(arg_24_0)
	if arg_24_0.tween then
		arg_24_0.tween:setOnComplete(nil)
		LeanTween.cancel(arg_24_0.m_arror.gameObject)

		arg_24_0.tween = nil
	end
end

function var_0_0.RandomAngle(arg_25_0)
	return -((-arg_25_0.m_arror.localEulerAngles.z + 360) % 360 + math.random(120, 300)) % 360
end

function var_0_0.Dispose(arg_26_0)
	var_0_0.super.Dispose(arg_26_0)
end

return var_0_0
