-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiaonuoassistant/view/data/AssistData8.lua

module("logic.extensions.xiaonuoassistant.view.data.AssistData8", package.seeall)

local AssistData8 = class("AssistData8", BaseAssistData)

function AssistData8:init()
	self.selectIndex1 = 1
end

function AssistData8:setSelectAll(isOn)
	self:setOpenData(isOn)
end

function AssistData8:getSendCallbackList()
	if self:getOpenData() then
		local sendMo = self:getSendMo()

		if self:getCellSelect(self.selectIndex1) then
			local ins = FriendModel.instance
			local t = ins:getGroupDatas(GameEnum.FriendGroup.Friend)
			local sendedHearts = ins:getSendedHearts()
			local maxSendCount = ins:getMaxSendHeartOneDay()
			local canGainHearts = ins:getCanGainHearts()
			local maxGainCount = ins:getMaxGainHeartOneDay()
			local sendFriendIds = {}
			local gainFriendIds = {}
			local leftSendCount = maxSendCount - ins:getSendedHeartNum()
			local leftGainCount = maxGainCount - ins:getGainedHeartNum()

			for i = 1, #t do
				local friendId = t[i]._id

				if leftSendCount <= #sendFriendIds then
					break
				end

				if sendedHearts[friendId] ~= true then
					table.insert(sendFriendIds, friendId)
				end
			end

			for i = 1, #t do
				local friendId = t[i]._id

				if leftGainCount <= #gainFriendIds then
					break
				end

				if canGainHearts[friendId] == true then
					table.insert(gainFriendIds, friendId)
				end
			end

			if leftSendCount == 0 and leftGainCount == 0 then
				-- block empty
			elseif #sendFriendIds == 0 and #gainFriendIds == 0 then
				-- block empty
			else
				self._sendIds = sendFriendIds
				self._gainIds = gainFriendIds

				if #self._sendIds > 0 then
					local friendIds = {}

					for i = 1, math.min(#self._sendIds, 5) do
						table.insert(friendIds, self._sendIds[1])
						table.remove(self._sendIds, 1)
					end

					local function callback()
						printInfo("test 请求 好友一键赠送好感度")
						FriendAgent.instance:sendSendHeartsReq(friendIds)
					end

					table.insert(sendMo.callbackList, callback)
				end

				if #self._gainIds > 0 then
					local friendIds = {}

					for i = 1, math.min(#self._gainIds, 5) do
						table.insert(friendIds, self._gainIds[1])
						table.remove(self._gainIds, 1)
					end

					local function callback()
						printInfo("test 请求 好友一键获得好感度")
						FriendAgent.instance:sendGainHeartsReq(friendIds)
					end

					table.insert(sendMo.callbackList, callback)
				end
			end
		end

		return sendMo
	end
end

return AssistData8
