local QWorldHintMgr = class("QWorldHintMgr")
local var_0_3 = {}

function QWorldHintMgr:Init()
	var_0_3 = {}
	self.isHintDisplaying = false
	QWorldHintView = import("game.qworld.hint.QWorldHintView")

	manager.notify:RegistListener(QWORLD_HINT_UPDATE, function()
		if not self.isPlayingQueue then
			self:DisplayNextHint()
		end
	end)
end

function QWorldHintMgr:AddHint(arg_3_1)
	QWorldData:AddHint(arg_3_1)
end

function QWorldHintMgr:DisplayHintImmediate(arg_4_1)
	if self.isHintDisplaying == true then
		QWorldData:AddHint(arg_4_1)

		return
	end

	self.isHintDisplaying = true

	QWorldHintView:DisplayHint(arg_4_1, {})
	self:StartTimer(SandplaySettingCfg.pop_hint_display.value[1] / 1000, function()
		QWorldHintView:HideHint()

		self.isHintDisplaying = false

		self:StartTimer(SandplaySettingCfg.pop_hint_interval.value[1] / 1000, function()
			self:DisplayNextHint()
		end)
	end)
end

function QWorldHintMgr:DisplayNextHint()
	if not QWorldData:HasHints() and not QWorldData:HasItemHints() then
		self.isPlayingQueue = false
		self.isHintDisplaying = false

		return
	end

	if not gameContext:IsOpenRoute("qworldMainHome") then
		self.isPlayingQueue = false

		return
	end

	self.isPlayingQueue = true

	if QWorldData:HasHints() then
		self.isHintDisplaying = true

		QWorldHintView:DisplayHint(QWorldData:PopHint(), QWorldData:GetItemHintList())
		self:StartTimer(QWorldData:GetHintData().displayDuration / 1000, function()
			QWorldHintView:HideHint()

			self.isHintDisplaying = false

			self:StartTimer(QWorldData:GetHintData().intervalDuration / 1000 + 0.1, function()
				self:DisplayNextHint()
			end)
		end)
	else
		QWorldHintView:DisplayHint(nil, QWorldData:GetItemHintList())
		self:StartTimer(QWorldData:GetHintData().displayDuration / 1000 + 0.1, function()
			QWorldHintView:HideHint()

			self.isHintDisplaying = false
			self.isPlayingQueue = false
		end)
	end
end

function QWorldHintMgr:StopTimerAndHideHint(arg_11_1)
	self.isPlayingQueue = false
	self.isHintDisplaying = false

	for iter_11_0, iter_11_1 in ipairs(var_0_3) do
		if iter_11_1 then
			iter_11_1:Stop()

			iter_11_1 = nil
		end
	end

	var_0_3 = {}

	QWorldHintView:HideHint(arg_11_1)
end

function QWorldHintMgr:ClearQueueOnExit()
	QWorldData:CleanHintDataQuque()

	for iter_12_0, iter_12_1 in ipairs(var_0_3) do
		if iter_12_1 then
			iter_12_1:Stop()

			iter_12_1 = nil
		end
	end

	var_0_3 = {}
	self.isPlayingQueue = false
	self.isHintDisplaying = false
end

function QWorldHintMgr:StartTimer(arg_13_1, arg_13_2)
	local var_13_0 = Timer.New(function()
		if arg_13_2 then
			arg_13_2()
		end
	end, arg_13_1, 1)

	table.insert(var_0_3, var_13_0)
	var_13_0:Start()
end

function QWorldHintMgr:Dispose()
	self:ClearQueueOnExit()
	manager.notify:RemoveListener(QWORLD_HINT_UPDATE, function()
		if not self.isPlayingQueue then
			self:DisplayNextHint()
		end
	end)
end

return QWorldHintMgr
