local WeaponAttrComp, Super = System.NewComponent("WeaponAttrComp")

function WeaponAttrComp:ctor(uiNode, model, showEnhanceAttr)
  Super.ctor(self)
  self.ui = UI_Awaker_Item_Weapon_AttributeResource(uiNode)
  self.model = model
  self.showEnhanceAttr = showEnhanceAttr
end

function WeaponAttrComp:OnBind(binder)
  binder:BindToRaw(function(_, preview)
    if not preview then
      return
    end
    local uiName = self.ui.Text_Sec_Attr_Name
    local uiValueBefore = self.ui.Text_Sec_Attr_Value_Before
    local uiValueAfter = self.ui.Text_Sec_Attr_Value_After
    local uiHArrow = self.ui.Image_Sec_Attr_H_Arrow
    local uiVArrow = self.ui.Image_Sec_Attr_V_Arrow
    self:_SetAttr(binder, preview.sec, uiName, uiValueBefore, uiValueAfter, uiHArrow, uiVArrow)
    local uiName_1 = self.ui.Text_Prim_Attr_Name_1
    local uiValueBefore_1 = self.ui.Text_Prim_Attr_Value_1_Before
    local uiValueAfter_1 = self.ui.Text_Prim_Attr_Value_1_After
    local uiHArrow_1 = self.ui.Image_Prim_Attr_H_Arrow_1
    local uiVArrow_1 = self.ui.Image_Prim_Attr_V_Arrow_1
    self:_SetAttr(binder, preview.prim[1], uiName_1, uiValueBefore_1, uiValueAfter_1, uiHArrow_1, uiVArrow_1)
    local uiName_2 = self.ui.Text_Prim_Attr_Name_2
    local uiValueBefore_2 = self.ui.Text_Prim_Attr_Value_2_Before
    local uiValueAfter_2 = self.ui.Text_Prim_Attr_Value_2_After
    local uiHArrow_2 = self.ui.Image_Prim_Attr_H_Arrow_2
    local uiVArrow_2 = self.ui.Image_Prim_Attr_V_Arrow_2
    self:_SetAttr(binder, preview.prim[2], uiName_2, uiValueBefore_2, uiValueAfter_2, uiHArrow_2, uiVArrow_2)
    local uiName_3 = self.ui.Text_Prim_Attr_Name_3
    local uiValueBefore_3 = self.ui.Text_Prim_Attr_Value_3_Before
    local uiValueAfter_3 = self.ui.Text_Prim_Attr_Value_3_After
    local uiHArrow_3 = self.ui.Image_Prim_Attr_H_Arrow_3
    local uiVArrow_3 = self.ui.Image_Prim_Attr_V_Arrow_3
    self:_SetAttr(binder, preview.prim[3], uiName_3, uiValueBefore_3, uiValueAfter_3, uiHArrow_3, uiVArrow_3)
  end, function()
    if self.showEnhanceAttr then
      do return self.model.GetEnhanceAttrPreview end
      return self.model.GetEnhanceAttrPreview, self.model
    else
      do return self.model.GetBreakthroughAttrPreview end
      return self.model.GetBreakthroughAttrPreview, self.model
    end
  end)
end

function WeaponAttrComp:_SetAttr(binder, attr, uiName, uiValueBefore, uiValueAfter, uiHArrow, uiVArrow)
  if not attr or not attr.id then
    return
  end
  local attrCfg = DT.ActorAttrType[attr.id]
  local text = attrCfg and attrCfg.Text or ""
  binder:SetText(uiName, LT.Text(text))
  local percentage = attrCfg and attrCfg.Percentage
  local before = percentage and math.ceil(attr.before) .. "%" or math.ceil(attr.before)
  binder:SetText(uiValueBefore, before)
  if attr.after > 0 and attr.after ~= attr.before then
    uiHArrow:SetActive(true)
    uiVArrow:SetActive(true)
    uiValueAfter:SetActive(true)
    local after = percentage and math.ceil(attr.after) .. "%" or math.ceil(attr.after)
    binder:SetText(uiValueAfter, after)
  else
    uiHArrow:SetActive(false)
    uiVArrow:SetActive(false)
    uiValueAfter:SetActive(false)
  end
end

function WeaponAttrComp:OnUnbind()
  Super.OnUnbind(self)
end

return WeaponAttrComp
