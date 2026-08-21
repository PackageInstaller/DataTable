_class("UIPetEquipLvIcon", UICustomWidget)
UIPetEquipLvIcon = UIPetEquipLvIcon

function UIPetEquipLvIcon:SetData(pet, showLv, txtLvExtra, posLv)
  if not pet then
    return
  end
  local unlock = pet:GetPetGrade() > 0
  self:_SetLockState(unlock)
  local state = self:_GetIconState(pet)
  self:_SetIconState(state)
  if showLv then
    txtLvExtra = txtLvExtra or ""
    local lv = txtLvExtra .. pet:GetEquipLv()
    self:_SetText(state, lv, posLv)
  end
end

function UIPetEquipLvIcon:_SetLockState(unlock)
  self:GetGameObject("_unlock"):SetActive(unlock)
  self:GetGameObject("_locked"):SetActive(not unlock)
end

function UIPetEquipLvIcon:_GetIconState(pet)
  local grade = -1
  if UIPetEquipHelper.HasRefine(pet:GetTemplateID()) then
    grade = pet:GetEquipRefineLv()
  end
  return grade
end

function UIPetEquipLvIcon:_SetIconState(state)
  local objs = UIWidgetHelper.GetObjGroupByWidgetName(self, {
    [-1] = {"_icon_a", "_locked_a"},
    [0] = {"_icon_b0", "_locked_b"},
    [1] = {"_icon_b1", "_locked_b"},
    [2] = {"_icon_b2", "_locked_b"},
    [3] = {"_icon_b3", "_locked_b"}
  })
  UIWidgetHelper.SetObjGroupShow(objs, state)
end

function UIPetEquipLvIcon:_SetText(state, lv, pos)
  local tb = {"_txtLv_a", "_txtLv_b"}
  for i, v in ipairs(tb) do
    self:GetGameObject(v):SetActive(false)
  end
  local widgetName = state == -1 and tb[1] or tb[2]
  UIWidgetHelper.SetLocalizationText(self, widgetName, lv)
  self:GetGameObject(widgetName):SetActive(true)
  if pos then
    local trans = self:GetUIComponent("RectTransform", widgetName)
    trans.anchoredPosition = pos
  end
end
