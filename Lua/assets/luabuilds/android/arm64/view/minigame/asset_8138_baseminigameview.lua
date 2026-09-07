local BaseMiniGameView = class("BaseMiniGameView", import("..base.BaseUI"))

function BaseMiniGameView:SetExtraData(arg_1_1)
	self.mg_extraData = arg_1_1

	return
end

function BaseMiniGameView:GetExtraValue(arg_2_1)
	if self.mg_extraData[arg_2_1] then
		return self.mg_extraData[arg_2_1]
	else
		return nil
	end

	return
end

function BaseMiniGameView:SetMGData(arg_3_1)
	self.mg_data = arg_3_1

	return
end

function BaseMiniGameView:GetMGData()
	return self.mg_data
end

function BaseMiniGameView:SetMGHubData(arg_5_1)
	self.mg_hubData = arg_5_1

	return
end

function BaseMiniGameView:GetMGHubData()
	return self.mg_hubData
end

function BaseMiniGameView:setGameRoomData(arg_7_1)
	self.gameRoomData = arg_7_1

	return
end

function BaseMiniGameView:getGameRoomData()
	return self.gameRoomData or nil
end

function BaseMiniGameView:SendSuccess(...)
	self:emit(BaseMiniGameMediator.MINI_GAME_SUCCESS, ...)

	return
end

function BaseMiniGameView:SendFailure(...)
	self:emit(BaseMiniGameMediator.MINI_GAME_FAILURE, ...)

	return
end

function BaseMiniGameView:StoreDataToServer(arg_11_1)
	if self.mg_data:getConfig("type") == MiniGameConst.MG_TYPE_2 then
		local var_11_0 = {
			self.mg_data.id,
			2
		}

		table.insertto(var_11_0, arg_11_1)
		self.mg_data:SetRuntimeData("elements", arg_11_1)
		self:emit(BaseMiniGameMediator.MINI_GAME_OPERATOR, MiniGameOPCommand.CMD_SPECIAL_GAME, var_11_0)
	end

	return
end

function BaseMiniGameView:SendOperator(arg_12_1, arg_12_2)
	self:emit(BaseMiniGameMediator.MINI_GAME_OPERATOR, arg_12_1, arg_12_2)

	return
end

function BaseMiniGameView:OnSendMiniGameOPDone(arg_13_1)
	return
end

function BaseMiniGameView:OnModifyMiniGameDataDone(arg_14_1)
	return
end

function BaseMiniGameView:loadCoinLayer()
	if not self.coinLayer then
		self:emit(BaseMiniGameMediator.MINI_GAME_COIN)
	end

	return
end

function BaseMiniGameView:setCoinLayer()
	if self.coinLayer then
		return
	end

	self:checkTicktRemind()

	self.coinLayer = true

	return
end

function BaseMiniGameView:openCoinLayer(arg_17_1)
	if not self.coinLayer then
		return
	end

	if arg_17_1 then
		self:checkTicktRemind()
	end

	self.coinLayerVisible = arg_17_1

	self:emit(BaseMiniGameMediator.COIN_WINDOW_CHANGE, arg_17_1)

	return
end

function BaseMiniGameView:checkTicktRemind()
	local var_18_0 = getProxy(GameRoomProxy):ticketMaxTip()

	if var_18_0 and not GameRoomProxy.ticket_remind then
		GameRoomProxy.ticket_remind = true

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = var_18_0,
			onYes = function()
				return
			end,
			onNo = function()
				self:closeView()

				return
			end
		})
	end

	return
end

function BaseMiniGameView:OnGetAwardDone(arg_21_1)
	return
end

function BaseMiniGameView:OnApplicationPaused(arg_22_1)
	return
end

return BaseMiniGameView
