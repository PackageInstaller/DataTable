_class("GameHelper", Singleton)
GameHelper = GameHelper
GameHelper.EMPTY_TABLE = setmetatable({}, {
  __newindex = function(t, k, v)
    error("readonly!")
  end
})

function GameHelper:Constructor()
  self.callbackID = 0
end

function GameHelper:CreateCallback(func, ...)
  self.callbackID = self.callbackID + 1
  return Callback:New(self.callbackID, func, ...)
end

function GameHelper:CreateEventCallback(gameEventType, func, ...)
  self.callbackID = self.callbackID + 1
  local callBack = EventCallback:New(self.callbackID, func, ...)
  callBack:SetEventType(gameEventType)
  return callBack
end

function GameHelper.IsNull(...)
  local len = select("#", ...)
  local t = {}
  for i = 1, len do
    local v = select(i, ...)
    if v then
      t[#t + 1] = v
    end
  end
  return #t == 0
end

function GameHelper.StringSplit(str, separatorPatten)
  local list = {}
  local s = 1
  repeat
    local i, j = string.find(str, separatorPatten, s)
    if i then
      list[#list + 1] = string.sub(str, s, i - 1)
      s = j + 1
    else
      list[#list + 1] = string.sub(str, s)
    end
  until not i
  return list
end

function GameHelper.ComputeLogicDir(posDir)
  local nMax = math.max(math.abs(posDir.x), math.abs(posDir.y))
  if nMax ~= 0 then
    posDir.x = posDir.x / nMax
    posDir.y = posDir.y / nMax
  end
  return posDir
end

function GameHelper.ComputeLogicDistance(posA, posB)
  local nX = posA.x - posB.x
  local nY = posA.y - posB.y
  return nX * nX + nY * nY
end

function GameHelper.ComputeLogicStep(posA, posB)
  local nX = posA.x - posB.x
  local nY = posA.y - posB.y
  return math.abs(nX) + math.abs(nY)
end

function GameHelper.IsPointOneLine(posA, posB, posC)
  local posDirAB = GameHelper.ComputeLogicDir(posA - posB)
  local posDirBC = GameHelper.ComputeLogicDir(posB - posC)
  return posDirAB == posDirBC
end

function GameHelper.MakePosString(posWork)
  local stReturn = "(" .. posWork.x .. "," .. posWork.y .. ")"
  return stReturn
end

function GameHelper.GetFrameCount()
  local gameGlobal = GameGlobal:GetInstance()
  if gameGlobal.GetMainWorld then
    return UnityEngine.Time.frameCount
  else
    return gameGlobal:GetFrameCount()
  end
end

function GameHelper.AddShaderNames()
  local BindingFlags = System.Reflection.BindingFlags
  local flag = System.Reflection.BindingFlags.GetMask(BindingFlags.Public, BindingFlags.NonPublic, BindingFlags.Static, BindingFlags.Instance)
  require("tolua.reflection")
  tolua.loadassembly("Assembly-CSharp")
  local type1 = typeof("GraphicUtli")
  local s_ShaderNameToAssets_field = tolua.getfield(type1, "s_ShaderNameToAssets", flag)
  if not s_ShaderNameToAssets_field then
    Log.fatal("get s_ShaderNameToAssets field failed!")
    return
  end
  local instance = tolua.createinstance(type1)
  local s_ShaderNameToAssets = s_ShaderNameToAssets_field:Get(instance)
  if not s_ShaderNameToAssets then
    Log.fatal("get s_ShaderNameToAssets failed!")
    return
  end
  s_ShaderNameToAssets:Add("H3D/UI/Transparent Alpha Colored", "Transparent Alpha Colored.shader")
end
