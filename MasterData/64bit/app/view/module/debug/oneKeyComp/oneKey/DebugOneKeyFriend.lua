local var_0_0 = g.core.model.User.furnitureData
local var_0_1 = g.core.model.User.friendData
local DebugOneKeyFriend = class("DebugOneKeyFriend", require("app.view.module.debug.oneKeyComp.oneKey.DebugOneKeyBase"))

function DebugOneKeyFriend:initData()
	self._oneKeyName = "一键好友操作"
	self._needAddEventList = {
		[g.core.event.enum.EVENT_NET_S2C_FRIEND_SENDGIFT] = handler(self, self._onS2CSendGift),
		[g.core.event.enum.EVENT_NET_S2C_FRIEND_RECEIVEGIFT] = handler(self, self._onS2CGetGift),
		[g.core.event.enum.EVENT_NET_S2C_FURNITURE_ROOM_SWEEP] = handler(self, self._onFriendClear)
	}
end

function DebugOneKeyFriend:doOneKey()
	local var_2_0 = var_0_1:getCurTabList(0)

	if not self:isGifted(var_2_0) then
		self:send(function()
			g.core.network.GameNetProxy:send_C2S_Friend_SendGift({
				id = 0
			})
		end)

		return
	end

	local var_2_1 = self:getGiftList(var_2_0)

	if #var_2_1 > 0 then
		self:send(function()
			g.core.network.GameNetProxy:send_C2S_Friend_ReceiveGift({
				id = var_2_1
			})
		end)

		return
	end

	local var_2_2 = self:getClearFriendId(var_2_0)

	if var_2_2 > 0 then
		self:send(function()
			g.core.network.GameNetProxy:send_C2S_FurnitureRoom_Sweep({
				num = 1,
				friend_id = var_2_2
			})
		end)

		return
	end

	self._isFinish = true
end

function DebugOneKeyFriend:_onS2CSendGift(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	return "赠送好友成功"
end

function DebugOneKeyFriend:_onS2CGetGift(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	return "领取好友体力成功"
end

function DebugOneKeyFriend:_onFriendClear(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	return "好友打扫成功" .. ",剩余次数" .. var_0_0:getCurSweepTime()
end

function DebugOneKeyFriend:getGiftList()
	local var_9_0 = {}
	local var_9_1 = var_0_1:getGiftList()

	if #var_9_1 > 0 and math.max(0, g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.FRIEND_GIFT_LIMIT).parameter - var_0_1:getGiftedNum()) > 0 then
		for iter_9_0, iter_9_1 in pairs(var_9_1) do
			if not iter_9_1:isReceived() then
				table.insert(var_9_0, iter_9_1:getFriendId())
			end
		end
	end

	return var_9_0
end

function DebugOneKeyFriend:isGifted(arg_10_1)
	local var_10_0 = true

	if table.nums(arg_10_1) == 0 then
		self._isFinish = true

		return g.core.lang:get(102509)
	else
		for iter_10_0, iter_10_1 in pairs(arg_10_1) do
			if not iter_10_1:isGifted() then
				var_10_0 = false

				break
			end
		end
	end

	return var_10_0
end

function DebugOneKeyFriend:getClearFriendId(arg_11_1)
	if var_0_0:getCurSweepTime() > 0 then
		for iter_11_0, iter_11_1 in pairs(arg_11_1) do
			local var_11_0 = iter_11_1:getFriendId()

			if var_0_0:isCanCleanFurnitureByUserId(var_11_0) then
				return var_11_0
			end
		end
	end

	return 0
end

return DebugOneKeyFriend
