local TMP_Text = CS.TMPro.TMP_Text
local RoleFloatingText = System.NewClass("RoleFloatingText")
local GameObject = CS.UnityEngine.GameObject
local Text = CS.UnityEngine.UI.Text
local Animator = CS.UnityEngine.Animator
local UIAnimationController = CS.Z1Client.UIAnimationController
local Image = CS.UnityEngine.UI.Image
local Vector3 = CS.UnityEngine.Vector3
local Vector2 = CS.UnityEngine.Vector2
local StatusUIFollow = CS.Z1Client.StatusUIFollow
RoleFloatingText.VectorZero = Vector2.zero
RoleFloatingText.FloatStyle = {
  Damage = Animator.StringToHash("Base Layer.UA_Tiaozi_Rpg_Rise"),
  Fix = Animator.StringToHash("Base Layer.UA_Battle_kouxue_xin"),
  RpgSkill = Animator.StringToHash("Base Layer.UA_Tiaozi_Rpgskill"),
  DbgCrit = Animator.StringToHash("Base Layer.UA_Battle_baoji_dbg")
}

function RoleFloatingText.Preload(poolRoot)
  for type in pairs(bc.FloatRes) do
    Pool.CreateWithTag(RoleFloatingText, type, 3, poolRoot)
  end
end

function RoleFloatingText:ctor(tag, poolRoot)
  local floatConfig = bc.FloatRes
  local resConfig = floatConfig[tag]
  assert(resConfig, "找不到对应的prefab tag:" .. tag)
  self.assetPath = resConfig.prefab
  self.poolRoot = poolRoot
  self.defaultText = resConfig.defaultText or tag
  local prefab = ResLoadMgr.LoadAsset(self.assetPath, self)
  local obj = GameObject.Instantiate(prefab, poolRoot)
  self.root = obj
  self.ui = require("UI.UIPackages." .. resConfig.uiRes)(obj)
  self.textComp = self.ui.Text:GetComponent(typeof(Text)) or self.ui.Text:GetComponent(typeof(TMP_Text))
  assert(self.textComp, "飘字UI预制体没有Text组件 prefab " .. resConfig.prefab)
  self.outlineOrinColor = self.textComp.outlineColor
  self.uiAnimController = obj:GetComponentInChildren(typeof(UIAnimationController))
  assert(self.uiAnimController, "飘字UI预制体没有 UIAnimationController 组件 prefab " .. resConfig.prefab)
  if self.ui.Icon ~= nil then
    self.iconComp = self.ui.Icon:GetComponent(typeof(Image))
  end
  obj.transform.localScale = Vector3.one * (resConfig.dbgScale or 1)
  self.anim = resConfig.anim
  self.fastAnim = resConfig.fastAnim
  self.uiFollow = self.root:GetComponent(typeof(StatusUIFollow))
  if not self.uiFollow then
    self.uiFollow = self.root:AddComponent(typeof(StatusUIFollow))
    self.uiFollow.enabled = false
  end
  obj:SetActive(false)
end

function RoleFloatingText:GetBinder()
  if bg.battleScene then
    return bg.battleScene.binder
  end
end

function RoleFloatingText:InitFloat(text, icon, parent, position, freeCallback, awakerUid, isFastAnim, outlineColor)
  if not self.ui or IsNil(self.ui.Text) then
    return
  end
  text = StrUtils.RestoreSpaceTag(text)
  local binder = self:GetBinder()
  if binder then
    binder:SetText(self.ui.Text, text or self.defaultText)
  else
    self.textComp.text = text or self.defaultText
  end
  if outlineColor then
    local outlineColorHex = outlineColor:startswith("#") and outlineColor or "#" .. LT.Text(outlineColor)
    local olColor = ColorUtils.ColorToColor32(ColorUtils.ParseHtmlStringToUnityColor(outlineColorHex, 1))
    self.textComp.outlineColor = olColor
  else
    self.textComp.outlineColor = self.outlineOrinColor
  end
  if self.iconComp then
    self.ui.Icon:SetActive(nil ~= icon)
    if icon then
      self.iconComp.sprite = ResLoadMgr.LoadAsset(icon, self)
    end
  end
  self.freeCallback = freeCallback
  self.root.transform:SetParent(parent, false)
  if binder then
    binder:CheckUpdatePanelResource(self.root, DataCenter.gameData.CurrTextLanguage)
    binder:LoadAllLangFont(self.ui.Text)
  end
  self.root:SetActive(true)
  if not awakerUid then
    self.uiFollow.enabled = false
    self.root.transform.anchoredPosition = position or RoleFloatingText.VectorZero
  else
    self.uiFollow.enabled = true
    local awaker = bg.battleScene:GetAwakerByUid(awakerUid)
    local followTarget = awaker.rootNode.transform
    local offset
    if position then
      offset = Vector3(position.x, position.y, 0)
    else
      offset = Vector3(0, 1, 0)
    end
    self.uiFollow:Follow(followTarget, offset, bg.mainCamera, bg.uiCamera)
  end
  if self.uiAnimController then
    local anim = isFastAnim and self.fastAnim or self.anim
    self.uiAnimController:PlayState(anim, function()
      self:OnFree()
    end)
  end
end

function RoleFloatingText:ChangeToFastAnim()
  if self.fastAnim then
    self.uiAnimController:StopPlayableGraph(false)
    self.uiAnimController:PlayState(self.fastAnim, function()
      self:OnFree()
    end)
  end
end

function RoleFloatingText:OnFree()
  if self.freeCallback then
    self.freeCallback()
    self.freeCallback = nil
    self.uiFollow.enabled = false
  end
  self.pool:Free(self)
end

function RoleFloatingText:OnRecycle()
  self.root:SetActive(false)
  self.freeCallback = nil
  if bg.battleScene then
    self.root.transform:SetParent(self.poolRoot, false)
  end
  if self.freeTimer and bg.battleRender then
    bg.battleRender:UnperformWithDelay(self.freeTimer)
    self.freeTimer = nil
  end
end

function RoleFloatingText:Dispose()
  if not IsNil(self.uiAnimController) then
    self.uiAnimController:StopPlayableGraph()
    self.uiAnimController = nil
  end
  GameObject.Destroy(self.root)
  ResLoadMgr.UnloadAssetByTarget(self)
end

return RoleFloatingText
