local var_0_0 = class("EatSnakesGameView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/CORGUI_SandPlay_Com/SandPlay_3_10_SnakegameUI/SandPlay_3_10_SnakegameUI"
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

	arg_4_0.controller_ = {}

	for iter_4_0 = 1, 3 do
		arg_4_0.controller_[iter_4_0] = arg_4_0["controller_" .. iter_4_0]:GetController("status")
	end

	arg_4_0.titleController_ = arg_4_0.titleCon_:GetController("title")
end

function var_0_0.AddUIListener(arg_5_0)
	return
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0.tools = EatSnakeMain.Instance
	arg_6_0.tools.gamePause = false
	arg_6_0.type = 0

	arg_6_0:UpdateData()
	arg_6_0:UpdateView()
	arg_6_0.tools:LoadGame(arg_6_0.cfg.stage)
end

function var_0_0.UpdateData(arg_7_0)
	arg_7_0.cfg = ActivityEatSnakeCfg[arg_7_0.params_.id]
	arg_7_0.mapID = arg_7_0.cfg.stage
	arg_7_0.finishStar = 0
	arg_7_0.type = nil

	function arg_7_0.cancelFunc_()
		arg_7_0.tools.gamePause = false
	end

	function arg_7_0.failFunc()
		TimeTools.StartAfterSeconds(1, function()
			JumpTools.GoToSystem("eatSnakeResult", {
				type = 2,
				time = arg_7_0.tools.showTime,
				id = arg_7_0.params_.id,
				parent = arg_7_0
			})
		end, {})
		arg_7_0.titleController_:SetSelectedState("lose")

		arg_7_0.type = 2
		arg_7_0.finishStar = 0

		local var_9_0 = arg_7_0.tools:CalculateSnakePartCount()
		local var_9_1 = string.format("[%s, %s, %s]", var_9_0[0], var_9_0[1], var_9_0[2])

		SDKTools.SendMessageToSDK("activity_combat_over", {
			combat_star = 0,
			activity_id = arg_7_0.cfg.activity_id,
			stage_id = arg_7_0.cfg.id,
			result = arg_7_0.type,
			use_seconds = string.format("%.1f", arg_7_0.tools.showTime),
			score = arg_7_0.tools.currentIndex,
			other_data = var_9_1
		})

		for iter_9_0 = 1, 3 do
			arg_7_0.controller_[iter_9_0]:SetSelectedState("notpass")
		end
	end

	function arg_7_0.battAgainFunc()
		arg_7_0.type = 4

		local var_11_0 = arg_7_0.tools:CalculateSnakePartCount()
		local var_11_1 = string.format("[%s, %s, %s]", var_11_0[0], var_11_0[1], var_11_0[2])

		SDKTools.SendMessageToSDK("activity_combat_over", {
			combat_star = 0,
			activity_id = arg_7_0.cfg.activity_id,
			stage_id = arg_7_0.cfg.id,
			result = arg_7_0.type,
			use_seconds = string.format("%.1f", arg_7_0.tools.showTime),
			score = arg_7_0.tools.currentIndex,
			other_data = var_11_1
		})
		arg_7_0:OnEnter()
	end

	function arg_7_0.tools.winGameAction()
		TimeTools.StartAfterSeconds(0.5, function()
			JumpTools.OpenPageByJump("eatSnakeAnimation", {
				type = 1,
				time = arg_7_0.tools.showTime,
				id = arg_7_0.params_.id,
				parent = arg_7_0
			})
		end, {})
		arg_7_0.titleController_:SetSelectedState("win")

		arg_7_0.type = 1

		local var_12_0 = 1

		for iter_12_0 = 2, 3 do
			local var_12_1 = ConditionCfg[arg_7_0.cfg.target_list[iter_12_0]]

			if arg_7_0.tools.showTime < var_12_1.params[2] then
				var_12_0 = var_12_0 + 1
			end
		end

		EatSnakeAction.GetReward({
			activity_id = EatSnakeData:GetDataByPara("activityID"),
			stage_id = arg_7_0.cfg.id,
			star = var_12_0
		})

		local var_12_2 = arg_7_0.tools:CalculateSnakePartCount()
		local var_12_3 = string.format("[%s, %s, %s]", var_12_2[0], var_12_2[1], var_12_2[2])

		SDKTools.SendMessageToSDK("activity_combat_over", {
			activity_id = arg_7_0.cfg.activity_id,
			stage_id = arg_7_0.cfg.id,
			result = arg_7_0.type,
			use_seconds = string.format("%.1f", arg_7_0.tools.showTime),
			score = arg_7_0.tools.currentIndex,
			combat_star = var_12_0,
			other_data = var_12_3
		})
	end

	arg_7_0.tools.failGameAction = arg_7_0.failFunc
end

function var_0_0.UpdateView(arg_14_0)
	for iter_14_0, iter_14_1 in ipairs(arg_14_0.cfg.target_list) do
		arg_14_0["condition" .. iter_14_0 .. "Txt_"].text = ConditionCfg[iter_14_1].desc
	end

	for iter_14_2 = 1, 3 do
		arg_14_0.controller_[iter_14_2]:SetSelectedState("pass")
	end

	if arg_14_0.timer then
		arg_14_0.timer:Stop()

		arg_14_0.timer = nil
	end

	arg_14_0.countDown_:Play("normal")

	arg_14_0.timer = Timer.New(function()
		arg_14_0.countDown_:Play("normal")

		for iter_15_0 = 2, #arg_14_0.cfg.target_list do
			local var_15_0 = ConditionCfg[arg_14_0.cfg.target_list[iter_15_0]]

			if var_15_0.params[2] - arg_14_0.tools.showTime <= 5 and var_15_0.params[2] - arg_14_0.tools.showTime >= 0 then
				arg_14_0.countDown_:Play("countdown", 0, 0)
			end

			if var_15_0.params[2] - arg_14_0.tools.showTime <= 0 then
				arg_14_0.controller_[iter_15_0]:SetSelectedState("notpass")
			end
		end
	end, 1, -1, 1)

	arg_14_0.timer:Start()
end

function var_0_0.OnExit(arg_16_0)
	arg_16_0:BuryPoint()
	manager.windowBar:HideBar()

	if arg_16_0.timer then
		arg_16_0.timer:Stop()

		arg_16_0.timer = nil
	end
end

function var_0_0.BuryPoint(arg_17_0)
	if arg_17_0.type == nil then
		arg_17_0.type = 3

		local var_17_0 = arg_17_0.tools:CalculateSnakePartCount()
		local var_17_1 = string.format("[%s, %s, %s]", var_17_0[0], var_17_0[1], var_17_0[2])

		SDKTools.SendMessageToSDK("activity_combat_over", {
			combat_star = 0,
			activity_id = arg_17_0.cfg.activity_id,
			stage_id = arg_17_0.cfg.id,
			result = arg_17_0.type,
			use_seconds = string.format("%.1f", arg_17_0.tools.showTime),
			score = arg_17_0.tools.currentIndex,
			other_data = var_17_1
		})
	end
end

function var_0_0.OnTop(arg_18_0)
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		arg_18_0.tools.gamePause = true

		JumpTools.OpenPageByJump("eatSnakeQuitPop", {
			reBattleBtn_ = true,
			content = GetTips("SNAKEGAME_GIVE_UP"),
			cancelAction = handler(arg_18_0, arg_18_0.cancelFunc_),
			battleAction = handler(arg_18_0, arg_18_0.battAgainFunc),
			failAction = handler(arg_18_0, arg_18_0.failFunc)
		})
	end)
end

function var_0_0.Dispose(arg_20_0)
	if arg_20_0.list then
		arg_20_0.list:Dispose()

		arg_20_0.list = nil
	end

	var_0_0.super.Dispose(arg_20_0)
	Object.Destroy(arg_20_0.gameObject_)
end

return var_0_0
