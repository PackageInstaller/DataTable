local typeof = _ENV.typeof
local Animator = CS.UnityEngine.Animator
local AwakerWeaponRefineSuccessPanel, Super = System.NewClass("AwakerWeaponRefineSuccessPanel", UIBasePanel)
AwakerWeaponRefineSuccessPanel.uiResCls = UI_Awaker_Weapon_Refine_SuccessResource

function AwakerWeaponRefineSuccessPanel:ctor(model, oldLevel, newLevel, returnItems)
  Super.ctor(self)
  self.model = model
  self.oldLevel = oldLevel
  self.newLevel = newLevel
  self.returnItems = returnItems
  self.starTimer = {}
end

function AwakerWeaponRefineSuccessPanel:OnBind(binder)
  self.binder = binder
  self:_SetSafeClose()
  binder:BindComponent(WeaponForEnhanceResult(self.ui.UI_Common_Item_WuPin_Type1, self.model))
  local refineStage1MaxLevel = DT.GetConstant("WeaponRefineSkillParaNum")
  local numStars = math.min(self.newLevel, refineStage1MaxLevel)
  for i = 1, 3 do
    local obj = self.ui["Star_" .. i]
    if obj then
      binder:SetActive(obj, i <= numStars)
    end
  end
  if refineStage1MaxLevel < self.newLevel then
    self.ui.Image_Max:SetActive(true)
    binder:SetText(self.ui.Text_Max, self.newLevel - refineStage1MaxLevel)
  else
    self.ui.Image_Max:SetActive(false)
  end
  for i = 1, 3 do
    local effect = self.ui["UI_Vx_Star_OpenGlow_" .. i]
    local obj = self.ui["Star_" .. i]
    local animCtrl = obj:GetComponent(typeof(CS.Z1Client.UIAnimationController))
    if obj then
      if refineStage1MaxLevel <= self.oldLevel then
        effect:SetActive(false)
      else
        animCtrl:StopPlayableGraph()
        if animCtrl and numStars >= i then
          if 1 == i then
            animCtrl:PlayState("UI_Awake_Group_Star_Open")
          else
            local index = i - 1
            local timer = self.binder:BindTimer(0.5 * index, 0, nil, function()
              animCtrl:PlayState("UI_Awake_Group_Star_Open")
            end)
            table.insert(self.starTimer, timer)
          end
        end
      end
    end
  end
  if refineStage1MaxLevel <= self.oldLevel then
    self.ui.Root_Attribute:SetActive(true)
    self.ui.Text_New_Level_Desc:SetActive(false)
    local weaponCfg = self.model.weaponConfig
    local attriID = weaponCfg.WeaponSubAttribute[1]
    local attriBaseValue = weaponCfg.WeaponSubAttribute[2]
    local attriConfig = DT.ActorAttrType[attriID]
    local attriFactor = CommonDefine.WeaponRefineAttrFactor[weaponCfg.Quality] or 0
    binder:SetImage(self.ui.Image_Attribute_Icon, attriConfig.Icon)
    binder:SetText(self.ui.Text_Attribute_Name, LT.Text(attriConfig.Text))
    self:_SetAttribute(attriID, attriFactor, attriBaseValue, self.oldLevel - refineStage1MaxLevel, self.ui.Text_Attribute_CurrValue)
    self:_SetAttribute(attriID, attriFactor, attriBaseValue, self.newLevel - refineStage1MaxLevel, self.ui.Text_Attribute_NextValue)
  elseif refineStage1MaxLevel < self.newLevel then
    self.ui.Root_Attribute:SetActive(true)
    self.ui.Text_New_Level_Desc:SetActive(true)
    local weaponCfg = self.model.weaponConfig
    local attriID = weaponCfg.WeaponSubAttribute[1]
    local attriBaseValue = weaponCfg.WeaponSubAttribute[2]
    local attriConfig = DT.ActorAttrType[attriID]
    local attriFactor = CommonDefine.WeaponRefineAttrFactor[weaponCfg.Quality] or 0
    binder:SetImage(self.ui.Image_Attribute_Icon, attriConfig.Icon)
    binder:SetText(self.ui.Text_Attribute_Name, LT.Text(attriConfig.Text))
    self:_SetAttribute(attriID, attriFactor, attriBaseValue, 0, self.ui.Text_Attribute_CurrValue)
    self:_SetAttribute(attriID, attriFactor, attriBaseValue, self.newLevel - refineStage1MaxLevel, self.ui.Text_Attribute_NextValue)
    local desc = self.model:GetLevelDesc(refineStage1MaxLevel)
    binder:SetText(self.ui.Text_New_Level_Desc, desc)
  else
    self.ui.Root_Attribute:SetActive(false)
    self.ui.Text_New_Level_Desc:SetActive(true)
    local desc = self.model:GetLevelDesc(self.newLevel)
    binder:SetText(self.ui.Text_New_Level_Desc, desc)
  end
  binder:BindButtonClick(self.ui.Btn_Mask, function()
    self:OnCancelClick()
  end)
  local animator = self.ui.uiNode:GetComponent(typeof(Animator))
  AnimatorUtils.SetStateEndInBehavior(animator, "Close", System.fn(self, self.OnCancelClick))
end

function AwakerWeaponRefineSuccessPanel:_SetAttribute(attriID, attriFactor, attriBaseValue, refineStage2Level, ui)
  local attriCfg = DT.ActorAttrType[attriID]
  local attriValue = attriBaseValue + (attriCfg.Equivalency or 0) * attriFactor * refineStage2Level
  attriValue = ItemDataUtils.RemoveDotZero(attriValue)
  if attriCfg.Percentage then
    attriValue = attriValue .. "%"
  end
  self.binder:SetText(ui, attriValue)
end

function AwakerWeaponRefineSuccessPanel:_SetSafeClose()
  self.binder:BindTimer(3, 0, nil, function()
    self.binder:BindEvent(EventMgr.Instance.TouchEndEvent, function()
      self:Close()
    end)
  end)
end

function AwakerWeaponRefineSuccessPanel:OnUnbind()
  for _, timer in ipairs(self.starTimer) do
    if timer then
      self.binder:StopTimer(timer)
    end
  end
  self.starTimer = nil
end

function AwakerWeaponRefineSuccessPanel:OnCancelClick()
  self:Close()
end

return AwakerWeaponRefineSuccessPanel
