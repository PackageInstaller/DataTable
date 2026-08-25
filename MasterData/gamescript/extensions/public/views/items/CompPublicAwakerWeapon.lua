local TYPEOF_UIAnimationController = typeof(CS.Z1Client.UIAnimationController)
local GameObject = CS.UnityEngine.GameObject
local IsNull = CS.Z1Client.UnityEngineObjectExtensionForLua.IsNull
local Vector3 = CS.UnityEngine.Vector3
local T_Component = typeof(CS.UnityEngine.Component)
local CompPublicAwakerWeapon, Super = NewViewComponent("CompPublicAwakerWeapon")

function CompPublicAwakerWeapon:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  self.parentNode = uiNode
  self.path = data.path
  self.scale = data.scale
  self.onCompleted = data.onCompleted
  self.gyroSpeed = data.gyroSpeed
end

function CompPublicAwakerWeapon:OnEnterComponent()
  CameraManager:SetUICameraModel(true)
  self.unbind = false
  local fileName = string.match(self.path, "/([^/]+)%.png")
  local prefabPath = "UI/UI_Weapon_Full/Weapon_Full_Prefab/" .. fileName .. ".prefab"
  ResLoadMgr.LoadAssetAsync(prefabPath, self, function(prefab)
    if self.unbind then
      return
    end
    if not prefab then
      return
    end
    if not self.parentNode or IsNull(self.parentNode) then
      return
    end
    self.weaponGO = GameObject.Instantiate(prefab)
    self.weaponGO.transform.parent = self.parentNode.transform
    self.weaponGO.transform.localPosition = Vector3.zero
    self.weaponGO.transform.localEulerAngles = Vector3.zero
    self.weaponGO.transform.localScale = Vector3(self.scale, self.scale, self.scale)
    self.borderGO = UIRootMgr.FindChild(self.weaponGO.transform, "Weapon_Full_Ani_Gold_06")
    self:_SetBorderGOActivity(self.borderGO)
    self.animCtrl = self.weaponGO:GetComponent(TYPEOF_UIAnimationController)
    self:_PlayAnim(self.animCtrl)
    self.delayGyroscopedCtrl = AddLuaCompOnce(self.weaponGO, DelayGyroscopedCtrl)
    if self.isFrozenGyroscopedCtrl then
      self:FrozenGyroscopedCtrl()
    end
    if IsNil(self.gyroscopeCtrl) then
      local comps = self.weaponGO:GetComponents(T_Component)
      for i = 0, comps.Length - 1 do
        local tName = comps[i]:GetType().FullName
        if "GyroUtils.GyroController" == tName then
          self.gyroscopeCtrl = comps[i]
          break
        end
      end
    end
    if self.onCompleted then
      self.onCompleted()
    end
  end)
end

function CompPublicAwakerWeapon:RegisterEvents()
  self:BindEvent(EventMgr.Instance.OnFrozenWeaponGyroscope, function()
    if self.gyroscopeCtrl and not IsNil(self.gyroscopeCtrl) then
      self.gyroscopeCtrl.enabled = false
    end
  end)
  self:BindEvent(EventMgr.Instance.OnUnfrozenWeaponGyroscope, function()
    if self.gyroscopeCtrl and not IsNil(self.gyroscopeCtrl) then
      self.gyroscopeCtrl.enabled = true
    end
  end)
end

function CompPublicAwakerWeapon:FrozenGyroscopedCtrl()
  self.isFrozenGyroscopedCtrl = true
  if self.delayGyroscopedCtrl then
    self.delayGyroscopedCtrl:Frozen()
  end
end

function CompPublicAwakerWeapon:UnfrozenGyroscopedCtrl()
  self.isFrozenGyroscopedCtrl = false
  if self.delayGyroscopedCtrl then
    self.delayGyroscopedCtrl:Unfrozen()
  end
end

function CompPublicAwakerWeapon:PlayAnim(animName)
  self.animName = animName
  self:_PlayAnim(self.animCtrl)
end

function CompPublicAwakerWeapon:_PlayAnim(animCtrl)
  if animCtrl and self.animName then
    animCtrl:PlayState(self.animName)
  end
end

function CompPublicAwakerWeapon:ShowBorder()
  self.showBorder = true
  self:_SetBorderGOActivity(self.borderGO)
end

function CompPublicAwakerWeapon:HideBorder()
  self.showBorder = false
  self:_SetBorderGOActivity(self.borderGO)
end

function CompPublicAwakerWeapon:_SetBorderGOActivity(borderGO)
  if borderGO then
    if self.showBorder == nil then
      borderGO:SetActive(true)
    else
      borderGO:SetActive(self.showBorder)
    end
  end
end

function CompPublicAwakerWeapon:OnExitComponent()
  if self.weaponGO then
    GameObject.Destroy(self.weaponGO)
    self.weaponGO = nil
  end
  self.delayGyroscopedCtrl = nil
  self.unbind = true
  CameraManager:SetUICameraModel(false)
  Super.OnExitComponent(self)
end

return CompPublicAwakerWeapon
