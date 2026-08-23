local var_0_0 = g.core.model.User.furnitureData
local var_0_1 = g.core.const.ConstMgr.SpiritHelpConst
local var_0_2 = g.core.event.enum
local var_0_3 = g.core.model.User.friendData
local SpiritHelpFriendRoomClear = class("SpiritHelpFriendRoomClear", require("app.view.module.spiritHelp.view.helps.SpiritHelpDoingBase"))
local var_0_5 = 0

function SpiritHelpFriendRoomClear:initData()
	self._cellName = "SpiritHelpCell1"
	self._isSelect = true
	self._needAddEventList = {
		[var_0_2.EVENT_NET_S2C_FURNITURE_ROOM_ONEKEYSWEEP] = handler(self, self._onRcvFriendRoomClear)
	}
	self._clearCount = 0
end

function SpiritHelpFriendRoomClear:refreshState()
	self._isTip = false
	self._tipStr = ""

	if var_0_0:getCurSweepTime() <= 0 then
		self._state = var_0_1.STATE.FINISH

		return
	end

	local var_2_0 = var_0_3:getCurTabList(var_0_5)

	if #var_2_0 > 0 then
		for iter_2_0, iter_2_1 in pairs(var_2_0) do
			if var_0_0:isCanCleanFurnitureByUserId(iter_2_1:getFriendId(), true) then
				self._state = var_0_1.STATE.NORMAL

				return
			end
		end

		self._state = var_0_1.STATE.FINISH
	else
		self._isTip = true
		self._tipStr = g.core.lang:get(409519)
		self._state = var_0_1.STATE.LOCK
	end
end

function SpiritHelpFriendRoomClear:doing()
	local var_3_0 = var_0_0:getCurSweepTime()
	local var_3_1 = {}

	for iter_3_0, iter_3_1 in pairs((var_0_3:getCurTabList(var_0_5))) do
		local var_3_2 = iter_3_1:getFriendId()

		if var_0_0:isCanCleanFurnitureByUserId(var_3_2, true) then
			table.insert(var_3_1, var_3_2)

			if var_3_0 <= #var_3_1 then
				break
			end
		end
	end

	self._clearCount = #var_3_1

	if self._clearCount > 0 then
		self:send(function()
			g.core.network.GameNetProxy:send_C2S_FurnitureRoom_OneKeySweep({
				friend_ids = var_3_1
			})
		end)
	end

	self._isFinish = true
end

function SpiritHelpFriendRoomClear:getAwardText(arg_5_1)
	return {
		langId = 409517,
		param = {
			maxTime = var_0_0:getSweepDailyMaxTime(),
			finishTime = self._clearCount
		}
	}
end

function SpiritHelpFriendRoomClear:_onRcvFriendRoomClear(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	self:addCurDoAward(arg_6_4.awards)
	self:setDoingState(var_0_1.DOING_STATE.SUCCESS)
end

return SpiritHelpFriendRoomClear
