local _GameEventTpl = L_GameTpl:getGameEventsTpl()
local this = class("moduleActivityBg", G_UIModuleBase)

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {}
end

function this:setPath(actId)
  local path = _GameEventTpl:getBgPrefab(_GameEventTpl:getTplById(actId))
  if path == nil or path == "" or path == " " then
    print("策划没有配资源路径！！！！")
    return
  end
  C_LuaUtility.InstantiateAsync(path, function(go)
    if not L_CommonUtil.isValid(go) then
      print("策划配的路径" .. path .. "找不到对应资源！！！！！！")
      return
    end
    local obj = go
    obj.transform:SetParent(self.bindComponents.bgRoot.transform)
  end)
end

return this
