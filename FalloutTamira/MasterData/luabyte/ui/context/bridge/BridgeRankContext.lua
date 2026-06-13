local BridgeRankContext = BaseClass("BridgeRankContext", BaseContext)
local M = BridgeRankContext
local MessageId = Proto.MessageId

function M:Open(id,lv)
    self._myBridgeLv = lv
    self._myRank = 0
    self._actId = id
    NetPack:UnRegistResponse(MessageId.ResponseBridgeRank, self._responseBridgeRankHandler)
    NetPack:UnRegistResponse(MessageId.ResponseBridgeMyRank, self._responseMyRankHandler)
    self._responseBridgeRankHandler = NetPack:RegistResponse( MessageId.ResponseBridgeRank, Bind(self, self._ResponseBridgeRank))
    self._responseMyRankHandler = NetPack:RegistResponse( MessageId.ResponseBridgeMyRank, Bind(self, self._ResponseMyRank))
    local request = {}
    request.ActivityId = id;
    NetPack:SendMessage(MessageId.RequestBridgeMyRank,request)
end

function M:_ResponseBridgeRank(messageId, result, msg)
    NetPack:UnRegistResponse(MessageId.ResponseBridgeRank, self._responseBridgeRankHandler)
    if result == 0 then
        self:_Show(msg.Data,msg.TotalCount, msg.ActivityId, self._myRank, self._myBridgeLv)
    end
end

function M:_ResponseMyRank(messageId, result, msg)
    NetPack:UnRegistResponse(MessageId.ResponseBridgeMyRank, self._responseMyRankHandler)
    if result ==0 then
        self._myRank = msg.MyRank
    end
    local request = {}
    request.ActivityId = self._actId;
    request.StartRank = 0
    request.RankCount = 20
    NetPack:SendMessage(MessageId.RequestBridgeRank,request)
end
return BridgeRankContext