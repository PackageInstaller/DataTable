local var_0_0 = class("QWorldHintMgr")
local var_0_1 = false
local var_0_2 = false
local var_0_3 = {}

function var_0_0.Init(arg_1_0)
	var_0_3 = {}
	arg_1_0.isHintDisplaying = false
	QWorldHintView = import("game.qworld.hint.QWorldHintView")

	manager.notify:RegistListener(QWORLD_HINT_UPDATE, function()
		if not arg_1_0.isPlayingQueue then
			arg_1_0:DisplayNextHint()
		end
	end)
end

function var_0_0.AddHint(arg_3_0, arg_3_1)
	QWorldData:AddHint(arg_3_1)
end

function var_0_0.DisplayHintImmediate(arg_4_0, arg_4_1)
	if arg_4_0.isHintDisplaying == true then
		QWorldData:AddHint(arg_4_1)

		return
	end

	arg_4_0.isHintDisplaying = true

	QWorldHintView:DisplayHint(arg_4_1, {})
	arg_4_0:StartTimer(SandplaySettingCfg.pop_hint_display.value[1] / 1000, function()
		QWorldHintView:HideHint()

		arg_4_0.isHintDisplaying = false

		arg_4_0:StartTimer(SandplaySettingCfg.pop_hint_interval.value[1] / 1000, function()
			arg_4_0:DisplayNextHint()
		end)
	end)
end

function var_0_0.DisplayNextHint(arg_7_0)
	if not QWorldData:HasHints() and not QWorldData:HasItemHints() then
		arg_7_0.isPlayingQueue = false
		arg_7_0.isHintDisplaying = false

		return
	end

	if not gameContext:IsOpenRoute("qworldMainHome") then
		arg_7_0.isPlayingQueue = false

		return
	end

	arg_7_0.isPlayingQueue = true

	if QWorldData:HasHints() then
		local var_7_0 = QWorldData:PopHint()

		arg_7_0.isHintDisplaying = true

		QWorldHintView:DisplayHint(var_7_0, QWorldData:GetItemHintList())
		arg_7_0:StartTimer(QWorldData:GetHintData().displayDuration / 1000, function()
			QWorldHintView:HideHint()

			arg_7_0.isHintDisplaying = false

			arg_7_0:StartTimer(QWorldData:GetHintData().intervalDuration / 1000 + 0.1, function()
				arg_7_0:DisplayNextHint()
			end)
		end)
	else
		QWorldHintView:DisplayHint(nil, QWorldData:GetItemHintList())
		arg_7_0:StartTimer(QWorldData:GetHintData().displayDuration / 1000 + 0.1, function()
			QWorldHintView:HideHint()

			arg_7_0.isHintDisplaying = false
			arg_7_0.isPlayingQueue = false
		end)
	end
end

function var_0_0.StopTimerAndHideHint(arg_11_0, arg_11_1)
	arg_11_0.isPlayingQueue = false
	arg_11_0.isHintDisplaying = false

	for iter_11_0, iter_11_1 in ipairs(var_0_3) do
		if iter_11_1 then
			iter_11_1:Stop()

			iter_11_1 = nil
		end
	end

	var_0_3 = {}

	QWorldHintView:HideHint(arg_11_1)
end

function var_0_0.ClearQueueOnExit(arg_12_0)
	QWorldData:CleanHintDataQuque()

	for iter_12_0, iter_12_1 in ipairs(var_0_3) do
		if iter_12_1 then
			iter_12_1:Stop()

			iter_12_1 = nil
		end
	end

	var_0_3 = {}
	arg_12_0.isPlayingQueue = false
	arg_12_0.isHintDisplaying = false
end

function var_0_0.StartTimer(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = Timer.New(function()
		if arg_13_2 then
			arg_13_2()
		end
	end, arg_13_1, 1)

	table.insert(var_0_3, var_13_0)
	var_13_0:Start()
end

function var_0_0.Dispose(arg_15_0)
	arg_15_0:ClearQueueOnExit()
	manager.notify:RemoveListener(QWORLD_HINT_UPDATE, function()
		if not arg_15_0.isPlayingQueue then
			arg_15_0:DisplayNextHint()
		end
	end)
end

return var_0_0
