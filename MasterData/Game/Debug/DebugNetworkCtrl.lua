local DebugNetworkCtrl = class("DebugNetworkCtrl", NetworkCtrlBase)
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance

function DebugNetworkCtrl:ctor()
  self.heroAttrTab = {}
end

function DebugNetworkCtrl:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_HERO_Debug_Attr, self, proto_csmsg.SC_HERO_Debug_Attr, self.SC_HERO_Debug_Attr)
end

function DebugNetworkCtrl:CS_HERO_Debug_Attr(heroDic, callBack)
  self.heroAttrTab.hero = heroDic
  self.__HERO_Debug_Attr_callBack = callBack
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_HERO_Debug_Attr, proto_csmsg.CS_HERO_Debug_Attr, self.heroAttrTab)
end

function DebugNetworkCtrl:SC_HERO_Debug_Attr(msg)
  if self.__HERO_Debug_Attr_callBack ~= nil then
    self.__HERO_Debug_Attr_callBack(msg)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function DebugNetworkCtrl:Reset()
end

return DebugNetworkCtrl
