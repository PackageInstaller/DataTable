local LuaComponentContainer = CS.Framework.LuaComponentContainer
local LuaComponentManager, Super = System.NewClass("LuaComponentManager", Manager)
local luaCompMap = {
  EffectAudioPostCtrl = EffectAudioPostCtrl
}

function LuaComponentManager:ctor()
  Super.ctor(self)
end

function LuaComponentManager:Awake(binder)
  Super.Awake(self)
end

function LuaComponentManager:AddLuaComponentOnce(go)
  if not go or IsNil(go) then
    return
  end
  if go:GetComponent(typeof(LuaComponentContainer)) then
    local childTrans = go:GetComponentsInChildren(typeof(CS.UnityEngine.Transform))
    for i = 1, childTrans.Length do
      local childTran = childTrans:GetValue(i - 1)
      local goName = childTran.gameObject.name
      if goName and string.find(goName, "LuaCompParam") then
        local luaCompName = string.match(goName, ".*_(.-):.*")
        if luaCompMap[luaCompName] then
          AddLuaCompOnce(go, luaCompMap[luaCompName])
        end
      end
    end
  end
end

function LuaComponentManager:OnDestroy()
  Super.OnDestroy(self)
end

return LuaComponentManager
