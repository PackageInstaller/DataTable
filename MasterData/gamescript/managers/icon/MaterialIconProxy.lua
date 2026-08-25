local MaterialIconProxy = NewClass("MaterialIconProxy")
local GameObject = CS.UnityEngine.GameObject
local Type_RectTransform = typeof(CS.UnityEngine.RectTransform)
local UILayer = CS.UnityEngine.LayerMask.NameToLayer("UI")
local Vector2_Center = CS.UnityEngine.Vector2(0.5, 0.5)
local _SetWidth = CS.Framework.TransformUtil.SetWidth
local _SetHeight = CS.Framework.TransformUtil.SetHeight
local _SetLocalPos = CS.Framework.TransformUtil.SetLocalPos
local _SetLocalScale = CS.Framework.TransformUtil.SetLocalScale
local _GetLocalScale = CS.Framework.TransformUtil.GetLocalScale
local UnityTime = CS.UnityEngine.Time

function MaterialIconProxy:ctor(iconCls)
  self.iconCls = iconCls
  self.gameObject = nil
  self.iconGameObject = nil
  self.deactiveTime = 0
  self.iconInstance = nil
  self.binder = nil
  self.isActive = true
  self.bridge = nil
  self:_InitBridge()
end

function MaterialIconProxy:LoadIcon(prefabPath)
  self.gameObject = GameObject(self.iconCls.__name)
  self.gameObject.layer = UILayer
  self.prefabPath = prefabPath
  self:ResetTransform()
  local flag = AddLuaCompOnce(self.gameObject, MaterialIconFlag)
  flag:SetProxy(self)
  self:SetFlag(flag)
  MaterialIconMgr.Instance:LoadProxyIcon(self)
end

function MaterialIconProxy:ResetTransform()
  if IsNil(self.gameObject) then
    return
  end
  local trans = self.gameObject:GetComponent(Type_RectTransform)
  trans = trans or self.gameObject:AddComponent(Type_RectTransform)
  trans.anchorMin = Vector2_Center
  trans.anchorMax = Vector2_Center
  trans.pivot = Vector2_Center
  _SetWidth(trans, 0)
  _SetHeight(trans, 0)
end

function MaterialIconProxy:CallAllBridges()
  if not self.iconInstance then
    return
  end
  local list = self.bridge._getterList
  local getter = self.bridge._getter
  for i = 1, #list do
    local key = list[i]
    local arg = getter[key]
    local func = self.iconInstance[key]
    if nil ~= func then
      func(self.iconInstance, unpack(arg))
    else
      error("Icon 中 没有找到 方法：" .. key)
    end
  end
  self.bridge._getter = {}
  self.bridge._getterList = {}
end

function MaterialIconProxy:ClearAllBridges()
  self.bridge._getter = {}
  self.bridge._getterList = {}
end

function MaterialIconProxy:SetGameObject(go)
  if IsNil(self.gameObject) then
    Destroy(go)
    return
  end
  self.iconGameObject = go
  if self.view and self.view.binder then
    self.view.binder:UpdateLocalizedTextAndResouce(go)
  end
  local trans2 = go:GetComponent(Type_RectTransform)
  trans2.pivot = Vector2_Center
  go.transform:SetParent(self.gameObject.transform, false)
  _SetLocalPos(go.transform, 0, 0, 0)
  if self.iconCls then
    self.iconInstance = AddLuaCompOnce(go, self.iconCls)
  end
  if self.iconInstance then
    self.iconInstance:SetProxy(self)
    self:CallAllBridges()
  end
end

function MaterialIconProxy:OnActive()
  self.isActive = true
  self.deactiveTime = 0
  self.bridge:OnActive()
end

function MaterialIconProxy:OnDeative()
  self.isActive = false
  self.deactiveTime = UnityTime.time
  self.bridge:OnDeative()
  self:ClearAllBridges()
end

function MaterialIconProxy:GetData()
  return self.data
end

function MaterialIconProxy:SetData(data)
  self.data = data
  self.bridge:SetData(data)
end

function MaterialIconProxy:SetFlag(flag)
  self.flag = flag
end

function MaterialIconProxy:SetBinder(binder)
  self.binder = binder
  self.bridge:SetBinder(binder)
end

function MaterialIconProxy:SetView(view)
  self.view = view
  self.bridge:SetView(view)
end

function MaterialIconProxy:Dispose()
  self.bridge:Dispose()
  RemoveLuaComp(self.iconGameObject, self.iconCls)
  RemoveLuaComp(self.gameObject, MaterialIconFlag)
  MaterialIconMgr.Instance:UnloadProxyIcon(self)
  Destroy(self.gameObject)
  self.gameObject = nil
  self.prefabPath = nil
  self.iconGameObject = nil
  self.iconCls = nil
end

function MaterialIconProxy:SetParent(parent)
  if IsNil(self.gameObject) or IsNil(parent) or parent.transform == self.gameObject.transform then
    return
  end
  self.gameObject.transform:SetParent(parent.transform, false)
  local rect = parent.transform.rect
  local sx, sy, _ = _GetLocalScale(parent.transform, nil, nil, nil)
  _SetLocalPos(self.gameObject.transform, rect.width * 0.5 * sx, -rect.height * sy * 0.5, 0)
end

function MaterialIconProxy:SetActive(isActive)
  if IsNil(self.gameObject) then
    return
  end
  SetScaledActive(self.gameObject, isActive or false)
end

function MaterialIconProxy:_InitBridge()
  local this = self
  local mytable = setmetatable({
    _getter = {},
    _getterList = {}
  }, {
    __index = function(mytable, key)
      return function(mytable, ...)
        local arg = {
          ...
        }
        if this.iconInstance ~= nil then
          local func = this.iconInstance[key]
          if nil ~= func then
            do return func, this.iconInstance, unpack(arg) end
            return func, this.iconInstance, unpack(arg)
          end
        else
          mytable._getter[key] = arg
          table.insert(mytable._getterList, key)
        end
        return 0
      end
    end
  })
  self.bridge = mytable
end

return MaterialIconProxy
