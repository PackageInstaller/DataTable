local Vector3 = CS.UnityEngine.Vector3
local GameObject = CS.UnityEngine.GameObject
local UIAnimationController = CS.Z1Client.UIAnimationController
local IsNull = CS.Z1Client.UnityEngineObjectExtensionForLua.IsNull
local T_Component = typeof(CS.UnityEngine.Component)
local AwakerWeaponPrefab, Super = System.NewComponent("AwakerWeaponPrefab")

function AwakerWeaponPrefab:ctor(parentNode, path, scale, onCompleted)
  Super.ctor(self)
  self.parentNode = parentNode
  self.path = path
  self.scale = scale
  self.onCompleted = onCompleted
end

function AwakerWeaponPrefab:OnBind(binder)
  self.binder = binder
  self.unbind = false
  local fileName = string.match(self.path, "/([^/]+)%.png")
  local prefabPath = "UI/UI_Weapon_Full/Weapon_Full_Prefab/" .. fileName .. ".prefab"
  binder:LoadAssetAsync(prefabPath, function(prefab)
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
    self:_SetBorderGOActivity(self.borderGO)
    self.animCtrl = self.weaponGO:GetComponent(typeof(UIAnimationController))
    self:_PlayAnim(self.animCtrl)
    if self.onCompleted then
      self.onCompleted(self.weaponGO)
    end
  end)
  binder:BindEvent(EventMgr.Instance.OnFrozenWeaponGyroscope, function()
    if self.gyroscopeCtrl and not IsNil(self.gyroscopeCtrl) then
      self.gyroscopeCtrl.enabled = false
    end
  end)
  binder:BindEvent(EventMgr.Instance.OnUnfrozenWeaponGyroscope, function()
    if self.gyroscopeCtrl and not IsNil(self.gyroscopeCtrl) then
      self.gyroscopeCtrl.enabled = true
    end
  end)
end

function AwakerWeaponPrefab:FrozenGyroscopedCtrl()
  self.isFrozenGyroscopedCtrl = true
  if self.delayGyroscopedCtrl then
    self.delayGyroscopedCtrl:Frozen()
  end
end

function AwakerWeaponPrefab:UnfrozenGyroscopedCtrl()
  self.isFrozenGyroscopedCtrl = false
  if self.delayGyroscopedCtrl then
    self.delayGyroscopedCtrl:Unfrozen()
  end
end

function AwakerWeaponPrefab:OnUnbind()
  if self.weaponGO then
    GameObject.Destroy(self.weaponGO)
    self.weaponGO = nil
  end
  self.unbind = true
end

function AwakerWeaponPrefab:ShowBorder()
  self.showBorder = true
  self:_SetBorderGOActivity(self.borderGO)
end

function AwakerWeaponPrefab:HideBorder()
  self.showBorder = false
  self:_SetBorderGOActivity(self.borderGO)
end

function AwakerWeaponPrefab:_SetBorderGOActivity(borderGO)
  if borderGO then
    if self.showBorder == nil then
      borderGO:SetActive(true)
    else
      borderGO:SetActive(self.showBorder)
    end
  end
end

function AwakerWeaponPrefab:PlayAnim(animName)
  self.animName = animName
  self:_PlayAnim(self.animCtrl)
end

function AwakerWeaponPrefab:_PlayAnim(animCtrl)
  if animCtrl and self.animName then
    animCtrl:PlayState(self.animName)
  end
end

return AwakerWeaponPrefab
