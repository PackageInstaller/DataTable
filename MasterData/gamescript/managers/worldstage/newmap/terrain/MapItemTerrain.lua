local AnimatorType = typeof(CS.UnityEngine.Animator)
local RepeatButton = CS.RepeatButton
local Vector3 = CS.UnityEngine.Vector3
local Vector3_Zero = Vector3.zero
local Vector3_015Y = Vector3(0, 0.15, 0)
local Instantiate = CS.UnityEngine.GameObject.Instantiate
local MapItemTerrain, Super = System.NewClass("MapItemTerrain", MapItemBase)

function MapItemTerrain:ctor(mgr, x, y, binder)
  Super.ctor(self)
  self.manager = mgr
  self.played = {}
  self.gear = nil
  self.grid = nil
  self.gridMaterial = nil
  self.openLevel = -1
  self.timer = nil
  self.gridX = x
  self.gridY = y
  self.binder = binder
  self.isVisible = true
  EventMgr.Instance.RoleMove:RegisterEvent(System.fn(self, self.DestoryGmTips))
  EventMgr.Instance.GMShowWorldStageGridPos:RegisterEvent(System.fn(self, self.GMShowGridPos))
end

function MapItemTerrain:SetVisible(visibility)
  if self.isVisible == visibility then
    return
  end
  if visibility and not self:CheckGridCanReshow() then
    return
  end
  self.isVisible = visibility
  if self.gridMeshRender then
    self.gridMeshRender.enabled = visibility
  end
  if self.grid then
    self.grid:SetActive(visibility)
  end
end

function MapItemTerrain:CheckGridCanReshow()
  local gearData = MapModel.Instance:GetGearDataByPos(self:GetGridPos())
  if not gearData then
    return true
  end
  if gearData and 6 == gearData.state and gearData.type == CommonDefine.GearItemType.DropTerrain then
    return false
  end
  return true
end

function MapItemTerrain:EnableOutLineMeshRender(visibility)
  if not self.tf or visibility and not self:CheckGridCanReshow() then
    return
  end
  if not self.outlineTrans then
    self.outlineTrans = self.tf:Find("Grid/MScene_LightSide_01")
  end
  self.outlineTrans:GetComponent(typeof(CS.UnityEngine.MeshRenderer)).enabled = visibility
end

function MapItemTerrain:OpenMist(level, notAnim)
  Logger.Info("OpenMist", level)
  assert(type(level) == "number", "Error OpenMist param error")
  local oldLevel = self:GetLevel()
  if level <= oldLevel then
    return
  end
  local speedTime = self.manager.parent:GetMistOpenSpeed()
  self:SetLevel(level)
  local effectMgr = self.manager:GetComponent(MapArtEffectManager)
  effectMgr:SetOpeningMistItem(self, true)
  self:StopMistTweenAndTimer()
  
  local function finalSetMinProgress()
    self.mistTween = nil
    self:_SetMaskProgress(level)
    self:StopMistTweenAndTimer()
    self.timer = TimerManager.Instance:CreateTimer(0.1, 1, nil, function()
      if effectMgr and effectMgr.rtCamera then
        effectMgr:SetOpeningMistItem(self, false)
      end
    end)
  end
  
  if notAnim then
    finalSetMinProgress()
  else
    local duration = math.abs(level - oldLevel) * speedTime
    AudioManager.Instance:PostSoundEvent("Play_Explore_Vfx_MistDispel")
    self:_DoMaskProgressFloat(level, duration, finalSetMinProgress)
  end
end

function MapItemTerrain:_SetMaskProgress(level)
  self.maskMaterial:SetFloat("_MinProgress", level)
  self.maskMeshRender.enabled = -1 ~= level
end

function MapItemTerrain:_DoMaskProgressFloat(level, duration, callback)
  self.maskMeshRender.enabled = true
  self.mistTween = self.maskMaterial:DOFloat(level, "_MinProgress", duration):OnComplete(function()
    if callback then
      callback()
    end
    self.maskMeshRender.enabled = -1 ~= level
  end)
end

function MapItemTerrain:EnableClick(isEnable)
  if self.isReadyDestroy then
    return
  end
  local button = self.grid:GetComponent(typeof(RepeatButton))
  if button then
    button.enabled = isEnable
  end
end

function MapItemTerrain:SetLevel(level)
  self.openLevel = level
end

function MapItemTerrain:GetLevel()
  return self.openLevel
end

function MapItemTerrain:SetGear(gear)
  self.gear = gear
  self:SetGearToGrid()
end

function MapItemTerrain:SetGearToGrid()
  if self.gear and self.grid then
    self.gear:SetParent(self.grid.transform)
    self.gear.tf.localPosition = Vector3_015Y
  end
end

function MapItemTerrain:OnLoad()
  self.mistAnimator = self.tf:GetComponent(AnimatorType)
  self.upAnimator = self.tf:Find("Grid"):GetComponent(AnimatorType)
  self:SetAnimEndFunc()
  self.grid = self.tf:Find("Grid").gameObject
  self:SetGearToGrid()
  self.gridMeshRender = self.grid:GetComponent(typeof(CS.UnityEngine.MeshRenderer))
  self.outlineTrans = self.tf:Find("Grid/MScene_LightSide_01")
  self.gridMaterial = self.outlineTrans:GetComponent(typeof(CS.UnityEngine.MeshRenderer)).material
  self.maskMeshRender = self.tf:Find("RT-Mask"):GetComponent(typeof(CS.UnityEngine.MeshRenderer))
  self.maskMeshRender.enabled = false
  self.maskMaterial = self.maskMeshRender.material
  self:EnableClick(false)
  self:EnableOutLineMeshRender(false)
  local rotateIdx = math.random(1, 5)
  local angle = (rotateIdx - 1) * 60
  if 0 ~= angle then
    self.grid.transform:Rotate(CS.UnityEngine.Vector3(0, angle, 0))
  end
  self.go.name = string.format("(%s, %s)", self.gridX, self.gridY)
  self.binder:BindLongPressButton(self.grid, function()
    self.manager:OnGridLongPress(self:GetGridPos())
  end, function()
    self.manager:OnGridClick(self:GetGridPos())
  end, 0.4)
  self.binder:BindPressUp(self.grid, function()
    self.manager:OnPressUp()
  end)
end

function MapItemTerrain:SetAnimEndFunc()
  if self.upAnimator then
    AnimatorUtils.SetStateEndInBehavior(self.upAnimator, "end", System.fn(self, self.OnAnimEnd))
  end
end

function MapItemTerrain:OnAnimEnd()
  local mgr = self.manager:GetComponent(MapGearManager)
  if nil == mgr then
    return
  end
  local x, y = self:GetGridPos()
  local gear = mgr:GetGearByPos(x, y)
  if gear and gear.PlayShowAnim then
    gear:PlayShowAnim(self.played["Up-Y-B"])
  end
end

function MapItemTerrain:PlayAnim(animName, noAnim)
  if self.played[animName] then
    return
  end
  self:SetVisible(true)
  local offset = 0
  if noAnim then
    offset = 1
  end
  local animator
  if "OpenMapHexagon" == animName then
    animator = self.mistAnimator
  else
    animator = self.upAnimator
  end
  if animator then
    self.played[animName] = true
    if "Up-Y-B" == animName then
      self.played["Up-Y-A"] = true
    end
    AnimatorUtils.PlayState(animator, string.format("Base Layer.%s", animName), -1, offset)
  end
end

function MapItemTerrain:PlayDropAnim()
  if self.dropItem then
    return
  end
  self:SetVisible(false)
  local obj = ResLoadMgr.LoadAsset("MUnit/MUnit_02/Grid/MUnit_Grid_M0005/MUnit_Grid_M0005PS.prefab", self)
  local effectGo = Instantiate(obj, self.tf)
  local effectTf = effectGo.transform
  effectTf.localPosition = CS.UnityEngine.Vector3.zero
  if self.gear and self.gear.tf then
    effectTf.localRotation = self.gear.tf.localRotation
  end
  self.dropItem = effectGo
  local animator = effectGo:GetComponent(typeof(CS.UnityEngine.Animator))
  AnimatorUtils.SetStateEndInBehavior(animator, "end", System.fn(self, self.OnDropAnimEnd))
  AudioManager.Instance:PostSoundEvent("SFX_EXP_BLOCK_CRACK_LEAVE")
end

function MapItemTerrain:OnDropAnimEnd()
  if self.dropItem then
    CS.UnityEngine.GameObject.Destroy(self.dropItem)
    self.dropItem = nil
  end
  EventMgr.Instance.TerrainDropDone:Dispatch()
end

function MapItemTerrain:PlayTerrainTriggerEffect()
  local prefabPath = self:GetTriggerEffectPath(CommonDefine.TerrainTriggerType.Trigger)
  if not prefabPath then
    return
  end
  if not self.triggerEffectGo then
    local prefab = ResLoadMgr.LoadAsset(prefabPath, self)
    self.triggerEffectGo = CS.UnityEngine.GameObject.Instantiate(prefab, self.tf)
    self.triggerEffectGo.transform.localPosition = Vector3_Zero
  end
  self.triggerEffectGo:SetActive(true)
  self.binder:BindTimer(1.5, 0, nil, function()
    self.triggerEffectGo:SetActive(false)
  end)
end

function MapItemTerrain:GetTriggerEffectPath(triggerType)
  for _, info in pairs(DT.MapTileMaterial) do
    for _, cfg in pairs(info.data_list or {}) do
      if cfg.Path == self.prefabPath and cfg.Trigger == triggerType then
        return cfg.Effect
      end
    end
  end
end

function MapItemTerrain:PlayMonitedEffect()
  local prefabPath = self:GetMonitedEffect()
  if not prefabPath then
    return
  end
  if not self.extraEffectGo then
    local tf = self.grid and self.grid.transform or self.tf
    if tf then
      local prefab = ResLoadMgr.LoadAsset(prefabPath, self)
      self.extraEffectGo = CS.UnityEngine.GameObject.Instantiate(prefab, tf)
      self.extraEffectGo.transform.localPosition = Vector3_Zero
      self.extraEffectGo.transform.rotation = CS.UnityEngine.Quaternion.identity
    end
  end
end

function MapItemTerrain:StopMonitedEffect()
  if self.extraEffectGo and not IsNil(self.extraEffectGo) then
    CS.UnityEngine.GameObject.Destroy(self.extraEffectGo)
  end
  self.extraEffectGo = nil
end

function MapItemTerrain:GetMonitedEffect()
  do return DT.GetConstant end
  return DT.GetConstant, "MapNodeScanEffect"
end

function MapItemTerrain:PlayClickAnim()
  self:EnableOutLineMeshRender(true)
  AnimatorUtils.PlayState(self.upAnimator, "Base Layer.Click", -1, 0)
  local sequence = CS.DG.Tweening.DOTween.Sequence(self)
  sequence:Append(self.gridMaterial:DOFloat(8, "_TexPower", 0.2))
  sequence:Append(self.gridMaterial:DOFloat(5, "_TexPower", 0.6))
end

function MapItemTerrain:DOMaterialProperty(value, playAnim)
  self:EnableOutLineMeshRender(true)
  if 0 == value then
    if playAnim then
      self:PlayAnim("Sink")
      self.played["Up-Y-B"] = nil
    end
    self.gridMaterial:DOFloat(value, "_AlphaAll", 0.2)
    TimerManager.Instance:CreateTimer(0.2, 0, nil, function()
      self:EnableOutLineMeshRender(false)
    end)
  else
    if playAnim then
      self:PlayAnim("Up-Y-B")
      self.played.Sink = nil
    end
    self.gridMaterial:DOFloat(value, "_AlphaAll", 0.2)
  end
end

function MapItemTerrain:PlayUpAndNoOutline()
  self:EnableOutLineMeshRender(true)
  self:PlayAnim("Up-Y-B")
  self.played.Sink = nil
  self.gridMaterial:DOFloat(0, "_AlphaAll", 0.2)
end

function MapItemTerrain:DOOutlineScale()
  self:EnableOutLineMeshRender(true)
  self.outlineTrans.localScale = CS.UnityEngine.Vector3(1.15, 1.15, 1.15)
  self.outlineTrans:DOScale(CS.UnityEngine.Vector3(1, 1, 1), 0.3)
  local sequence = CS.DG.Tweening.DOTween.Sequence(self)
  sequence:Append(self.gridMaterial:DOFloat(9, "_TexPower", 0.2))
  sequence:Append(self.gridMaterial:DOFloat(5, "_TexPower", 0.1))
end

function MapItemTerrain:StopMistTweenAndTimer()
  if self.timer then
    TimerManager.Instance:StopTimer(self.timer)
    self.timer = nil
  end
  if self.mistTween then
    self.mistTween:Kill(false)
    self.mistTween = nil
  end
end

function MapItemTerrain:SetReadyDestroy()
  self:EnableClick(false)
  self.isReadyDestroy = true
end

function MapItemTerrain:Dispose()
  self.maskMaterial = nil
  self.maskMeshRender = nil
  self.gridMaterial = nil
  self.gridRenderer = nil
  self.binder:teardown()
  self:StopMistTweenAndTimer()
  if self.grid then
    CS.UnityEngine.GameObject.Destroy(self.grid)
    self.grid = nil
  end
  DOTweenUtils.KillAllTweensByTarget(self)
  Super.Dispose(self)
end

function MapItemTerrain:GMShowGridPos()
  local worldPosX, worldPosY = self.manager.parent:GetWorldPosByGridPos(self.gridX, self.gridY)
  local worldPos = CS.UnityEngine.Vector3(worldPosX, 0, worldPosY)
  if not self.tipGo then
    local obj = ResLoadMgr.LoadAsset("UI/UI_Common/UI_Common_Prefab/UI_Common_Pop_Text.prefab", self)
    self.tipGo = GameObject.Instantiate(obj, CS.UnityEngine.GameObject.Find("NormalRoot").transform)
    local anchoredPos = CS.Framework.UIUtilTool.ConvertSceneToUIWorldPos(worldPos, self.tipGo:GetComponent(typeof(CS.UnityEngine.RectTransform)), UIRootMgr.GetMainCamera(), UIRootMgr.GetUICamera())
    self.tipGo.transform.anchoredPosition = anchoredPos
    local showPos = string.format("(%s, %s)", self.gridX, self.gridY)
    self.tipGo:GetComponent(typeof(CS.UnityEngine.UI.Text)).text = showPos
  else
    self:DestoryGmTips()
  end
end

function MapItemTerrain:DestoryGmTips()
  if self.tipGo then
    GameObject.Destroy(self.tipGo)
    self.tipGo = nil
  end
end

return MapItemTerrain
