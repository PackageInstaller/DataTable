_class("TestTask", Object)
TestTask = TestTask
local testTaskObj

function TestTask:AsyncLoadGO1(TT, name, loadType)
  LoadAsync(TT, name, loadType)
  YIELD(TT)
end

function TestTask:AsyncLoadGO2(TT, name, loadType)
  local request = ResourceManager:GetInstance():AsyncLoadAsset(TT, name, loadType)
  local go = request.Obj
  go:SetActive(true)
end

function TestTask:UpdateCallers()
  local callCenter = GameGlobal.GameLogic().CallCenter
  callCenter:AddCallerLua(NetCallerBulletin, "bulletin")
  callCenter:AddCallerLua(NetCallerGateway, "gateway")
  callCenter:AddCallerLua(NetCallerGame, "game")
  local callerBL = callCenter:GetCallerLua("bulletin")
  callerBL:SetLinkConn(NetAddrInfo:New("127.0.0.1", 1111))
  local callerGW = callCenter:GetCallerLua("gateway")
  callerGW:SetLink2Conn(NetAddrInfo:New("127.0.0.1", 2222), NetToken:New(NetTokenType.TOKEN_CLIENT))
  local callerGM = callCenter:GetCallerLua("game")
  callerGW:SetPipe2Conn(NetToken:New(NetTokenType.TOKEN_GAME, "GM", 1), "gateway")
end

function TestTask:BtnDemoOnClick(go)
  self:StartTask(self.CallDemoTask, self)
end

function TestTask:CallDemoTask(TT)
  local caller = GameGlobal.GameLogic().CallCenter:GetCallerLua("bulletin")
  local callInfo = AsyncRequestRes:New()
  local reqMsg = NetMessageFactory:GetInstance():CreateMessage(CEventRequestGetLoginInfo)
  local repInfo = caller:Call(TT, reqMsg)
  if repInfo.res ~= CallResultType.Normal then
    callInfo:SetSucc(false)
    return
  end
  callInfo:SetSucc(true)
  local repMsg = repInfo.msg
  callInfo:SetResult(repMsg.ret)
end

require("item_message")

function TestTask:UseItem(TT, res, param)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventMobileUseItem, param)
  local caller = GameGlobal.GameLogic().CallCenter:GetCallerLua("game")
  Log.fatal("1111111111111")
  local reply = caller:Call(TT, request)
  Log.fatal(reply.msg._classname)
  log.fatal(reply.res)
  if reply.res ~= CallResultType.Normal then
    res:SetResult(-1)
    return
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.nRet)
end

function TestTask:RequestUseItemByPstID(TT, res, item_pstid, count, param1, param2, param3)
  YIELD(TT)
  local itemUseParameter = {
    item_pstid = item_pstid,
    count = count,
    param1 = param1,
    param2 = param2,
    param3 = param3
  }
  self:UseItem(TT, res, itemUseParameter)
end

function TestTask:foo(TT, a, c)
  YIELD(TT)
  c[1] = 2 * a
  YIELD(TT)
  local id2 = TaskManager:GetInstance():StartTask(testTaskObj.f2, testTaskObj, 10)
  self.id2 = id2
  local id3 = TaskManager:GetInstance():StartTask(testTaskObj.f3, testTaskObj, 10)
  _ylw("curTaskId " .. GetCurTaskId())
  _ylw(GetCurTaskId() .. " start join " .. id3)
  JOIN(TT, id3)
  _ylw("f1 foo return from f3")
  return 20, "111"
end

function TestTask:f1(TT, a, b)
  local c = {}
  local num, s1 = self:foo(TT, a + 1, c)
  _ylw("f1 return from f3")
  YIELD(TT)
  _ylw("f1 end")
end

function TestTask:f2(TT, n)
  for i = 1, n do
    _ylw("f2 i ", i)
    YIELD(TT)
  end
  _ylw("f2 end")
end

function TestTask:f3(TT, n)
  for i = 1, n do
    _ylw("f3 i ", i)
    if i == 1 then
      local task = TaskManager:GetInstance():FindTask(testTaskObj.id2)
      if task then
        JOIN(TT, testTaskObj.id2)
        _ylw("f3 return from f2")
      end
    end
    YIELD(TT)
  end
  _ylw("f3 end")
end

testTaskObj = TestTask:New()
local EnumABC = {
  A = 1,
  B = 2,
  C = 3
}
_enum("EnumABC", EnumABC)
local EnumArray = {
  "A",
  "B",
  "C"
}
_autoEnum("EnumArray", EnumArray)
