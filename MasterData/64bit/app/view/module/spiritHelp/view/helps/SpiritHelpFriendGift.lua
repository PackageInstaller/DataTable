local var_0_0 = g.core.model.User.resourceData
local var_0_1 = g.core.const.ConstMgr.SpiritHelpConst
local var_0_2 = g.core.event.enum
local var_0_3 = g.core.model.User.friendData
local SpiritHelpFriendGift = class("SpiritHelpFriendGift", require("app.view.module.spiritHelp.view.helps.SpiritHelpDoingBase"))
local var_0_5 = 0

function SpiritHelpFriendGift:initData()
	self._cellName = "SpiritHelpCell1"
	self._isSelect = true
	self._needAddEventList = {
		[var_0_2.EVENT_NET_S2C_FRIEND_SENDGIFT] = handler(self, self._onRevSendGift),
		[var_0_2.EVENT_NET_S2C_FRIEND_RECEIVEGIFT] = handler(self, self._onRevGetGift)
	}
end

function SpiritHelpFriendGift:refreshState()
	self._state = var_0_1.STATE.FINISH
	self._isTip = false
	self._tipStr = ""

	local var_2_0 = var_0_3:getCurTabList(var_0_5)

	if table.nums(var_2_0) <= 0 then
		self._state = var_0_1.STATE.LOCK
		self._isTip = true
		self._tipStr = g.core.lang:get(409515)

		return
	end

	if self:hasGifted(var_2_0) then
		self._state = var_0_1.STATE.NORMAL
	else
		if var_0_0:getVit() >= 1000 then
			self._state = var_0_1.STATE.LOCK
			self._isTip = true
			self._tipStr = g.core.lang:get(409518)

			return
		end

		self._state = #self:getGiftList() > 0 and var_0_1.STATE.NORMAL or var_0_1.STATE.FINISH
	end
end

function SpiritHelpFriendGift:hasGifted(arg_3_1)
	for iter_3_0, iter_3_1 in pairs(arg_3_1) do
		if not iter_3_1:isGifted() then
			return true
		end
	end

	return false
end

function SpiritHelpFriendGift:doing()
	if self:hasGifted((var_0_3:getCurTabList(var_0_5))) then
		self:send(function()
			g.core.network.GameNetProxy:send_C2S_Friend_SendGift({
				id = 0
			})
		end)
	end

	local var_4_0 = self:getGiftList()

	if #var_4_0 > 0 then
		self:send(function()
			g.core.network.GameNetProxy:send_C2S_Friend_ReceiveGift({
				id = var_4_0
			})
		end)
	end

	self._isFinish = true
end

function SpiritHelpFriendGift:getGiftList()
	local var_7_0 = {}
	local var_7_1 = var_0_3:getGiftList()

	if #var_7_1 > 0 then
		local var_7_2 = g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.FRIEND_GIFT_LIMIT).parameter - var_0_3:getGiftedNum()

		if var_7_2 > 0 then
			for iter_7_0, iter_7_1 in pairs(var_7_1) do
				if not iter_7_1:isReceived() then
					table.insert(var_7_0, iter_7_1:getFriendId())

					if var_7_2 <= #var_7_0 then
						return var_7_0
					end
				end
			end
		end
	end

	return var_7_0
end

function SpiritHelpFriendGift:_onRevSendGift(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	if not self:hasSending() then
		self:setDoingState(var_0_1.DOING_STATE.SUCCESS)
	end
end

function SpiritHelpFriendGift:_onRevGetGift(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	self:addCurDoAward(arg_9_4.awards)

	if not self:hasSending() then
		self:setDoingState(var_0_1.DOING_STATE.SUCCESS)
	end
end

return SpiritHelpFriendGift
