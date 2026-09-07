local DecodeMiniGameView = class("DecodeMiniGameView", import("..BaseMiniGameView"))

function DecodeMiniGameView:getUIName()
	return "DecodeGameUI"
end

function DecodeMiniGameView:didEnter()
	self.controller = DecodeGameController.New()

	self.controller.view:SetUI(self._tf)
	self.controller:SetCallback(function()
		self:emit(DecodeMiniGameView.ON_BACK)

		return
	end, function(arg_4_0)
		if self:GetMGHubData().count > 0 then
			self:StoreDataToServer((self.controller:GetSaveData()))

			self.onGetAward = arg_4_0

			self:SendSuccess(0)
		end

		return
	end, function()
		local var_5_0 = self:GetMGHubData()

		if var_5_0.ultimate == 0 then
			pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
				hubid = var_5_0.id,
				cmd = MiniGameOPCommand.CMD_ULTIMATE,
				args1 = {}
			})
		end

		return
	end)
	self.controller:SetUp((self:PackData()))

	return
end

function DecodeMiniGameView:GetData(arg_6_1)
	local var_6_0 = PlayerPrefs.GetInt("DecodeGameMapId", 1)
	local var_6_1 = arg_6_1:GetRuntimeData("elements")

	local function var_6_2()
		for iter_7_0 = 1, 60 do
			if not table.contains(var_6_1, iter_7_0) then
				table.insert(var_6_1, iter_7_0)

				break
			end
		end

		return
	end

	local function var_6_3()
		table.remove(var_6_1, 1)

		return
	end

	if #var_6_1 ~= self.usedtime then
		for iter_6_0 = 1, self.usedtime - #var_6_1 do
			var_6_2()
		end

		for iter_6_1 = 1, #var_6_1 - self.usedtime do
			var_6_3()
		end
	end

	return {
		mapId = var_6_0,
		unlocks = var_6_1,
		canUseCnt = self.count,
		passwords = DecodeGameConst.MAPS_PASSWORD,
		isFinished = self.ultimate > 0
	}
end

function DecodeMiniGameView:PackData()
	return DecodeMiniGameView.GetData(self:GetMGHubData(), (self:GetMGData()))
end

function DecodeMiniGameView:OnGetAwardDone(arg_10_1)
	if arg_10_1.cmd == MiniGameOPCommand.CMD_COMPLETE and self.onGetAward then
		self.onGetAward()

		self.onGetAward = nil
	end

	return
end

function DecodeMiniGameView:willExit()
	PlayerPrefs.SetInt("DecodeGameMapId", self.controller.mapId or 1)
	PlayerPrefs.Save()
	self.controller:Dispose()

	return
end

return DecodeMiniGameView
