local IslandProxy = class("IslandProxy", import("model.proxy.NetProxy"))

IslandProxy.STORY_START = "IslandProxy:STORY_START"
IslandProxy.STORY_END = "IslandProxy:STORY_END"
IslandProxy.PERFORMANCE_START = "IslandProxy:PERFORMANCE_START"
IslandProxy.PERFORMANCE_END = "IslandProxy:PERFORMANCE_END"
IslandProxy.START_PATHFINDER = "IslandProxy:START_PATHFINDER"
IslandProxy.END_PATHFINDER = "IslandProxy:END_PATHFINDER"
IslandProxy.ACTIVE_OR_DISABLE_UNIT = "IslandProxy:ACTIVE_OR_DISABLE_UNIT"
IslandProxy.LINK_CORE = "IslandProxy:LINK_CORE"
IslandProxy.GEN_RECYCLEITEM = "IslandProxy:GEN_RECYCLEITEM"
IslandProxy.LOCK_NPC_REFRESH = "IslandProxy:LOCK_NPC_REFRESH"
IslandProxy.RELEASE_NPC_REFRESH = "IslandProxy:RELEASE_NPC_REFRESH"
IslandProxy.RESET_SP = "IslandProxy:RESET_SP"
IslandProxy.PRESS_BACK = "IslandProxy:PRESS_BACK"
IslandProxy.CHAT_MSG_UPDATE = "IslandProxy:CHAT_MSG_UPDATE"

function IslandProxy:register()
	self.cahce = {}
	self.giftCache = {}
	self.chatMsgs = {}
	self.islandHeartBeatMgr = IslandHearBeatMgr.New()

	self:on(21216, function(arg_2_0)
		local var_2_0 = self:GetIsland()

		if not var_2_0 then
			return
		end

		for iter_2_0, iter_2_1 in ipairs(arg_2_0.visitor_list) do
			local var_2_1 = IslandVisitorLog.New(iter_2_1)

			if not var_2_1:IsSelf() then
				var_2_0:GetAccessAgency():AddVisitorLog(var_2_1)
				pg.IslandVisitorNotificationMgr.GetInstance():Enqueue(var_2_1)
			end
		end

		return
	end)

	return
end

function IslandProxy:AddChatMsg(arg_3_1, arg_3_2)
	self.chatMsgs[arg_3_1] = self.chatMsgs[arg_3_1] or {}

	table.insert(self.chatMsgs[arg_3_1], arg_3_2)
	self:sendNotification(IslandProxy.CHAT_MSG_UPDATE, {
		islandId = arg_3_1,
		msg = arg_3_2
	})

	return
end

function IslandProxy:GetChatMsgList(arg_4_1)
	return self.chatMsgs[arg_4_1] or {}
end

function IslandProxy:SetIsland(arg_5_1)
	self.island = arg_5_1

	return
end

function IslandProxy:GetIsland()
	return self.island
end

function IslandProxy:remove()
	self.island = nil

	return
end

function IslandProxy:ShouldTip()
	return (function()
		local var_9_0 = self:GetIsland()

		return var_9_0 and var_9_0:CanLevelUp()
	end)() or (function()
		local var_10_0 = self:GetIsland()

		return var_10_0 and var_10_0:AnyProsperityAwardCanGet()
	end)()
end

function IslandProxy:AddPlayerDataCache(arg_11_1)
	self.cahce[arg_11_1.id] = arg_11_1

	return
end

function IslandProxy:GetPlayerDataCache(arg_12_1)
	return self.cahce[arg_12_1]
end

function IslandProxy:ClearAllPlayerDataCache()
	self.cahce = {}

	return
end

function IslandProxy:AddGiftTagInfoCache(arg_14_1)
	self.giftCache[arg_14_1.playerId] = arg_14_1

	return
end

function IslandProxy:GetGiftTagInfoCache(arg_15_1)
	return self.giftCache[arg_15_1]
end

function IslandProxy:UpdateGiftTagCache(arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = self:GetGiftTagInfoCache(arg_16_1)

	if var_16_0 then
		var_16_0:Flush(arg_16_2, arg_16_3)
	else
		self:AddGiftTagInfoCache((IslandGiftTagInfo.New({
			key = arg_16_1,
			value1 = arg_16_3,
			value2 = arg_16_2
		})))
	end

	return
end

function IslandProxy:ClearAllGiftTagInfo()
	self.giftCache = {}

	return
end

function IslandProxy:SetSharedIsland(arg_18_1)
	self.sharedIsland = arg_18_1

	return
end

function IslandProxy:GetSharedIsland()
	return self.sharedIsland
end

function IslandProxy:SetSyncObjInitData(arg_20_1)
	self.syncObjInitData = arg_20_1

	return
end

function IslandProxy:GetSyncObjInitData()
	return (self.syncObjInitData or nil) and (self.syncObjInitData or {})
end

function IslandProxy:timeCall()
	return {
		[ProxyRegister.SecondCall] = function(arg_23_0)
			if not self.island then
				return
			end

			self.island:UpdatePerSecond()

			if not self.sharedIsland then
				return
			end

			self.sharedIsland:UpdatePerSecond()

			return
		end,
		[ProxyRegister.HourCall] = function(arg_24_0)
			if not self.island then
				return
			end

			self.island:UpdatePerHour(arg_24_0)

			if not self.sharedIsland then
				return
			end

			self.sharedIsland:UpdatePerHour(arg_24_0)

			return
		end,
		[ProxyRegister.DayCall] = function(arg_25_0)
			if not self.island then
				return
			end

			self.island:UpdatePerDay()

			return
		end
	}
end

function IslandProxy:RecordEnterTime()
	self.enterTimeStamp = pg.TimeMgr.GetInstance():GetServerTime()

	return
end

function IslandProxy:GetEnterTime()
	return self.enterTimeStamp
end

function IslandProxy:RecordTempPlayerPosition(arg_28_1, arg_28_2, arg_28_3)
	self.tempPlayerPosition = {
		arg_28_1,
		arg_28_2,
		arg_28_3
	}

	return
end

function IslandProxy:GetTempPlayerPosition()
	return self.tempPlayerPosition
end

function IslandProxy:EnterIsland(arg_30_1)
	self.islandHeartBeatMgr:EnterIsland(arg_30_1)

	return
end

function IslandProxy:ExitIsland()
	self.islandHeartBeatMgr:ExitIsland()

	return
end

function IslandProxy:remove()
	self.islandHeartBeatMgr:Dispose()

	self.islandHeartBeatMgr = nil

	return
end

return IslandProxy
