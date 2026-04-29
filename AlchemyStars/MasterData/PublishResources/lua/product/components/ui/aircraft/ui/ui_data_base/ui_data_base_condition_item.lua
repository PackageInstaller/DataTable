_class("UIDataBaseConditionItem", UICustomWidget)
UIDataBaseConditionItem = UIDataBaseConditionItem

function UIDataBaseConditionItem:OnShow(uiParams)
  self:GetComponents()
end

function UIDataBaseConditionItem:GetComponents()
  self._countTex = self:GetUIComponent("UILocalizationText", "count")
  self._icon = self:GetUIComponent("Image", "icon")
end

function UIDataBaseConditionItem:OnValue()
  local id = self._condition:GetID()
  local needCount = self._condition:GetCount()
  local roleModule = GameGlobal.GetModule(RoleModule)
  local assetCount = roleModule:GetAssetCount(id)
  local enough = true
  if needCount > assetCount then
    enough = false
  end
  local tex = ""
  if enough then
    tex = "<color=#EDDB8C>" .. needCount .. "</color>"
  else
    tex = "<color=#FF0000>" .. needCount .. "</color>"
  end
  self._countTex:SetText(tex)
  local cfg_top_tips = Cfg.cfg_top_tips[id]
  if not cfg_top_tips then
    Log.error("###[UIDataBaseConditionItem] cfg_top_tips is nil ! id --> ", id)
  end
  self._icon.sprite = self._srpite
end

function UIDataBaseConditionItem:SetData(idx, condition, sprite)
  self._idx = idx
  self._condition = condition
  self._srpite = sprite
  self:OnValue()
end
