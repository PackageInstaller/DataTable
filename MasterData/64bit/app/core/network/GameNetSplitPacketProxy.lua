local PacketFrag = class("PacketFrag")

function PacketFrag:ctor(arg_1_1)
	self._fragList = {}
	self._packetHead = nil
	self._msgId = 0
	self._originId = 0
	self._fragAllNum = 0

	self:addPacketFrag(arg_1_1)
end

function PacketFrag:addPacketFrag(arg_2_1)
	if self._fragAllNum == 0 then
		self._fragAllNum = arg_2_1.total
	end

	self._fragList[arg_2_1.current] = arg_2_1

	if arg_2_1.current == 1 then
		self._packetHead = arg_2_1.origin_ph
		self._msgId = self._packetHead.cmd
		self._originId = arg_2_1.origin_id
	end

	if #self._fragList == self._fragAllNum then
		local var_2_0 = ""

		for iter_2_0, iter_2_1 in ipairs(self._fragList) do
			var_2_0 = var_2_0 .. iter_2_1.data
		end

		g.core.network.GameNetProxy:onSplitPacketMessage(self._msgId, require("app.core.network.ProtoBuilder"):decode(self._msgId, var_2_0), self._packetHead.sid, self._packetHead.cid)
		g.core.network.GameNetSplitPacketProxy:clearPacketFrags(self._originId)
	end
end

function PacketFrag:getMsgId()
	if self._msgId == 0 then
		g.core.log:error("Error:packet frag id is 0")
	end

	return self._msgId
end

local var_0_1 = g.core.event.enum
local var_0_2 = g.core.event.EventManager
local GameNetSplitPacketProxy = class("GameNetSplitPacketProxy")

function GameNetSplitPacketProxy:ctor()
	self.splitCollectList = {}

	var_0_2:addEventListener(var_0_1.EVENT_NET_S2C_SPLIT_PACKET, self.onCollectSplitPacket, self)
end

function GameNetSplitPacketProxy:clearPacketFrags(arg_5_1)
	self.splitCollectList[arg_5_1] = nil
end

function GameNetSplitPacketProxy:onCollectSplitPacket(arg_6_1, arg_6_2, arg_6_3)
	if arg_6_3.origin_ph then
		self.splitCollectList[arg_6_3.origin_id] = PacketFrag.new(arg_6_3)
	elseif self.splitCollectList[arg_6_3.origin_id] then
		self.splitCollectList[arg_6_3.origin_id]:addPacketFrag(arg_6_3)
	end
end

return GameNetSplitPacketProxy
