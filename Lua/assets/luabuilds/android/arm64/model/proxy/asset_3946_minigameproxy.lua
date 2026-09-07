local MiniGameProxy = class("MiniGameProxy", import(".NetProxy"))

MiniGameProxy.ON_HUB_DATA_UPDATE = "on hub data update"
MiniGameProxy.ON_MINI_GAME_DATA_UPDATE = "on_mini_game_data_update"

function MiniGameProxy:register()
	self.miniGameHubDataDic = {}
	self.miniGameDataDic = {}

	return
end

function MiniGameProxy:timeCall()
	return {
		[ProxyRegister.DayCall] = function(arg_3_0)
			self:sendNotification(GAME.REQUEST_MINI_GAME, {
				type = MiniGameRequestCommand.REQUEST_HUB_DATA
			})

			local var_3_0 = self:GetMiniGameDataByType(MiniGameConst.MG_TYPE_5)

			if var_3_0 then
				self:sendNotification(GAME.SEND_MINI_GAME_OP, {
					hubid = self:GetHubByGameId(var_3_0.id).id,
					cmd = MiniGameOPCommand.CMD_SPECIAL_GAME,
					args1 = {
						var_3_0.id,
						1
					}
				})
			end

			return
		end
	}
end

function MiniGameProxy:CheckHasHub(arg_4_1)
	return self.miniGameHubDataDic[arg_4_1] ~= nil
end

function MiniGameProxy:GetMiniGameData(arg_5_1)
	if self.miniGameDataDic[arg_5_1] == nil then
		self.miniGameDataDic[arg_5_1] = MiniGameData.New({
			id = arg_5_1
		})
	end

	return self.miniGameDataDic[arg_5_1]
end

function MiniGameProxy:GetMiniGameDataByType(arg_6_1)
	for iter_6_0, iter_6_1 in pairs(self.miniGameDataDic) do
		if iter_6_1:getConfig("type") == arg_6_1 and iter_6_1:CheckInTime() then
			return iter_6_1
		end
	end

	return
end

function MiniGameProxy:GetHubByHubId(arg_7_1)
	if self.miniGameHubDataDic[arg_7_1] == nil then
		self.miniGameHubDataDic[arg_7_1] = MiniGameHubData.New({
			id = arg_7_1
		})
	end

	return self.miniGameHubDataDic[arg_7_1]
end

function MiniGameProxy:GetHubByGameId(arg_8_1)
	local var_8_0 = self:GetMiniGameData(arg_8_1):getConfig("hub_id")

	if self.miniGameHubDataDic[var_8_0] == nil then
		self.miniGameHubDataDic[var_8_0] = MiniGameHubData.New({
			id = var_8_0
		})
	end

	return self.miniGameHubDataDic[var_8_0]
end

function MiniGameProxy:UpdataHubData(arg_9_1)
	local var_9_0 = self:GetHubByHubId(arg_9_1.id)

	var_9_0:UpdateData(arg_9_1)
	self.facade:sendNotification(MiniGameProxy.ON_HUB_DATA_UPDATE, var_9_0)

	return
end

function MiniGameProxy:GetHighScore(arg_10_1)
	return self:GetHubByGameId(arg_10_1).highScores[arg_10_1] or {}
end

function MiniGameProxy:UpdataHighScore(arg_11_1, arg_11_2)
	local var_11_0 = self:GetHubByGameId(arg_11_1)
	local var_11_1 = 0

	if var_11_0.highScores[arg_11_1] and var_11_0.highScores[arg_11_1][1] then
		var_11_1 = var_11_0.highScores[arg_11_1][1]
	end

	if var_11_1 > arg_11_2[1] then
		arg_11_2[1] = var_11_1
	end

	if var_11_1 <= arg_11_2[1] then
		var_11_0.highScores[arg_11_1] = arg_11_2

		self:UpdataHubData(var_11_0)

		local var_11_2 = {
			arg_11_1
		}

		for iter_11_0, iter_11_1 in ipairs(arg_11_2) do
			table.insert(var_11_2, iter_11_1)
		end

		self:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = var_11_0.id,
			cmd = MiniGameOPCommand.CMD_HIGH_SCORE,
			args1 = var_11_2
		})
	end

	return
end

function MiniGameProxy:GetRank(arg_12_1)
	return self:GetMiniGameData(arg_12_1):GetRank()
end

function MiniGameProxy:SetRank(arg_13_1, arg_13_2)
	self:GetMiniGameData(arg_13_1):SetRank(arg_13_2)

	return
end

function MiniGameProxy:CanFetchRank(arg_14_1)
	return self:GetMiniGameData(arg_14_1):CanFetchRank()
end

function MiniGameProxy:RequestInitData(arg_15_1, arg_15_2)
	local var_15_0 = self:GetMiniGameData(arg_15_1)

	if arg_15_2 and var_15_0:getConfig("request_data") ~= 1 then
		return
	end

	if var_15_0:CheckInTime() then
		local var_15_1 = var_15_0:getConfig("type")

		if (var_15_1 == MiniGameConst.MG_TYPE_2 or var_15_1 == MiniGameConst.MG_TYPE_3 or var_15_1 == MiniGameConst.MG_TYPE_5) and not var_15_0:GetRuntimeData("fetchData") then
			self:sendNotification(GAME.SEND_MINI_GAME_OP, {
				hubid = self:GetHubByGameId(arg_15_1).id,
				cmd = MiniGameOPCommand.CMD_SPECIAL_GAME,
				args1 = {
					var_15_0.id,
					1
				}
			})
			var_15_0:SetRuntimeData("fetchData", true)
		end
	end

	return
end

function MiniGameProxy:remove()
	return
end

return MiniGameProxy
