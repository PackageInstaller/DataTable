local ClientDataUtils_Test = {}

local function assertEq(actual, expected, msg)
  if actual ~= expected then
    error(string.format("[ClientDataUtils_Test] %s: expected %s, got %s", tostring(msg), tostring(expected), tostring(actual)))
  end
end

local function assertTrue(cond, msg)
  if not cond then
    error(string.format("[ClientDataUtils_Test] %s: expected true", tostring(msg)))
  end
end

local function assertNil(v, msg)
  if nil ~= v then
    error(string.format("[ClientDataUtils_Test] %s: expected nil, got %s", tostring(msg), tostring(v)))
  end
end

local IN_GAME_TEST_MAIN_KEY = "ClientDataUtils_Test_Env"

function ClientDataUtils_Test.RunInGameTests()
  local ok, err
  ok, err = pcall(ClientDataUtils_Test.TestInGame_EnvReady)
  if not ok then
    return false, "TestInGame_EnvReady: " .. tostring(err)
  end
  ok, err = pcall(ClientDataUtils_Test.TestInGame_GetAllDataValid)
  if not ok then
    return false, "TestInGame_GetAllDataValid: " .. tostring(err)
  end
  ok, err = pcall(ClientDataUtils_Test.TestInGame_SetDataWithRealSave)
  if not ok then
    return false, "TestInGame_SetDataWithRealSave: " .. tostring(err)
  end
  ok, err = pcall(ClientDataUtils_Test.TestInGame_DelDataWithRealDel)
  if not ok then
    return false, "TestInGame_DelDataWithRealDel: " .. tostring(err)
  end
  ok, err = pcall(ClientDataUtils_Test.TestInGame_ReqOpenClientDataAsync)
  if not ok then
    return false, "TestInGame_ReqOpenClientDataAsync: " .. tostring(err)
  end
  return true
end

function ClientDataUtils_Test.TestInGame_EnvReady()
  assertTrue(ProtoManager ~= nil and nil ~= ProtoManager.Instance, "ProtoManager.Instance 存在")
  assertTrue(nil ~= PlayerDataUtils and type(PlayerDataUtils.GetPlayerUid) == "function", "PlayerDataUtils.GetPlayerUid 存在")
  assertTrue(nil ~= DataCenter and nil ~= DataCenter.clientData, "DataCenter.clientData 存在")
  assertTrue(nil ~= ClientDataUtils.GetAllData, "ClientDataUtils 已加载")
  local uid = PlayerDataUtils.GetPlayerUid()
  if 0 == uid then
    Logger.Info("[ClientDataUtils_Test] 未登录(uid=0)，存盘/删除请求将不会发出，仅做本地与拉取校验")
  end
end

function ClientDataUtils_Test.TestInGame_GetAllDataValid()
  local all = ClientDataUtils.GetAllData()
  assertTrue(type(all) == "table", "GetAllData() 返回 table")
  local sub = ClientDataUtils.GetSubTable(IN_GAME_TEST_MAIN_KEY)
  if nil ~= sub then
    assertTrue(type(sub) == "table", "GetSubTable 返回 table 或 nil")
  end
end

function ClientDataUtils_Test.TestInGame_SetDataWithRealSave()
  local subKey, value = "k1", 100
  ClientDataUtils.SetData(IN_GAME_TEST_MAIN_KEY, subKey, value, true)
  assertEq(ClientDataUtils.GetData(IN_GAME_TEST_MAIN_KEY, subKey), value, "SetData(..., true) 后本地立即可读")
end

function ClientDataUtils_Test.TestInGame_DelDataWithRealDel()
  local subKey = "k1"
  ClientDataUtils.DelData(IN_GAME_TEST_MAIN_KEY, subKey, true)
  assertNil(ClientDataUtils.GetData(IN_GAME_TEST_MAIN_KEY, subKey), "DelData(..., true) 后本地已删")
end

function ClientDataUtils_Test.TestInGame_ReqOpenClientDataAsync()
  ClientDataUtils.ReqOpenClientData(function()
    local all = ClientDataUtils.GetAllData()
    assertTrue(type(all) == "table", "ReqOpenClientData 回调内 GetAllData 为 table")
    if Logger and Logger.Info then
      Logger.Info("[ClientDataUtils_Test] ReqOpenClientData 回调已执行，真实游戏环境拉取成功")
    end
  end)
end

return ClientDataUtils_Test
