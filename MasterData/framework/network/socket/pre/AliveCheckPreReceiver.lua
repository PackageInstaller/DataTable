-- chunkname: @framework/network/socket/pre/AliveCheckPreReceiver.lua

module("framework.network.socket.pre.AliveCheckPreReceiver", package.seeall)

local AliveCheckPreReceiver = class("AliveCheckPreReceiver", BasePreReceiver)

function AliveCheckPreReceiver:ctor(aliveCheckPreSender)
	AliveCheckPreReceiver.super.ctor(self)

	self._aliveCheckPreSender = aliveCheckPreSender
	self._currDownTag = nil
	self._currRespName = "nil"
end

function AliveCheckPreReceiver:getCurrDownTag()
	return self._currDownTag
end

function AliveCheckPreReceiver:clearCurrDownTag()
	self._currDownTag = nil
end

function AliveCheckPreReceiver:preReceiveMsg(resultCode, cmd, responseName, msg, downTag, socketId)
	if downTag and downTag ~= 255 then
		if self._currDownTag then
			responseName = responseName or "nil"

			if self._currDownTag == downTag then
				if self._currRespName == responseName then
					local log = string.format("downTag重复: tag=%d name=%s", downTag, responseName)

					logError(log)
				else
					local log = string.format("downTag一样，协议不一样: tag=%d %s->%s", downTag, self._currRespName, responseName)

					logError(log)
				end

				return true
			elseif self._currDownTag == 0 and downTag ~= 1 or self._currDownTag ~= 127 and downTag == 0 or self._currDownTag > 0 and downTag > 0 and downTag - self._currDownTag > 1 then
				local log = string.format("downTag跳跃: tag=%d->%d %s->%s", self._currDownTag, downTag, self._currRespName, responseName)

				logError(log)
				ConnectAliveMgr.instance:lostMessage()

				return
			end
		end

		self._currRespName = responseName or "nil"
		self._currDownTag = downTag
	end

	self._aliveCheckPreSender:onReceiveMsg(cmd)
end

return AliveCheckPreReceiver
