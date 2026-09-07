local LanternFestivalView = class("LanternFestivalView", import("..BaseMiniGameView"))

function LanternFestivalView:getUIName()
	return "LanternFestivalUI"
end

function LanternFestivalView:didEnter()
	self.controller = LanternRiddlesController.New()

	self.controller.view:SetUI(self._tf)
	self.controller:SetCallBack(function()
		self:emit(LanternFestivalView.ON_BACK)

		return
	end, function()
		self:emit(LanternFestivalView.ON_HOME)

		return
	end, function()
		if self:GetMGHubData().count > 0 then
			self:SendSuccess(0)
		end

		return
	end, function()
		self:StoreDataToServer((self.controller:GetSaveData()))

		return
	end)
	self.controller:SetUp((self:PackData()))

	return
end

function LanternFestivalView:PackData()
	local var_7_0 = self:GetMGHubData()
	local var_7_1 = self:GetMGData():GetRuntimeData("elements")
	local var_7_2
	local var_7_3

	if var_7_1 and #var_7_1 > 0 then
		var_7_2 = _.slice(var_7_1, 1, 15)
		var_7_3 = _.slice(var_7_1, 15 + 1, var_7_0.usedtime)
	else
		var_7_2 = {}

		for iter_7_0 = 1, 15 do
			table.insert(var_7_2, 0)
		end

		var_7_3 = {}
	end

	return {
		finishCount = var_7_0.usedtime,
		unlockCount = var_7_0.count,
		nextTimes = var_7_2,
		finishList = var_7_3
	}
end

function LanternFestivalView:OnGetAwardDone(arg_8_1)
	if arg_8_1.cmd == MiniGameOPCommand.CMD_COMPLETE then
		local var_8_0 = self:GetMGHubData()

		if var_8_0.ultimate == 0 and var_8_0:getConfig("reward_need") <= var_8_0.usedtime then
			pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
				hubid = var_8_0.id,
				cmd = MiniGameOPCommand.CMD_ULTIMATE,
				args1 = {}
			})
		end
	end

	return
end

function LanternFestivalView:willExit()
	self.controller:Dispose()

	return
end

return LanternFestivalView
