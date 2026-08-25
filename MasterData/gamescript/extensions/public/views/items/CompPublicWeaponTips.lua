local CompPublicWeaponTips, Super = NewViewComponent("CompPublicWeaponTips")

function CompPublicWeaponTips:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Bag_Item_DetailResource(uiNode)
  self.itemTid = data.itemTid
end

function CompPublicWeaponTips:OnEnterComponent()
  self.ui.UI_Common_Btn_Lock:SetActive(false)
  self.ui.Group_Weapon:SetActive(true)
  self.ui.Group_Normal:SetActive(false)
  self.ui.Image_Possess:SetActive(false)
  self:SetImage(self.ui.Image_Icon, ItemDataUtils.GetItemIcon(self.itemTid))
  self:SetImage(self.ui.Image_Bg_Quality, ItemDataUtils.GetBgQualityFramePath(self.itemTid))
  self:SetImage(self.ui.Image_Title_Quality, ItemDataUtils.GetTitleQualityFramePath(self.itemTid))
  self:SetText(self.ui.Text_Name, ItemDataUtils.GetItemName(self.itemTid))
  self:SetImageColorByHtml(self.ui.bg1, "#000000")
  local colorStr = "#ffffff"
  self:SetTextColorByHtml(self.ui.Text_Name, colorStr)
  self:SetTextColorByHtml(self.ui.Text_Type, colorStr)
  self:SetTextColorByHtml(self.ui.Text_Possess, colorStr)
  self:SetText(self.ui.Text_Desc_Sec, ItemDataUtils.GetItemStory(self.itemTid))
  self:SetText(self.ui.Text_Type, ItemDataUtils.GetItemSubTypeName(self.itemTid))
  self:SetText(self.ui.Text_Normal_Desc, ItemDataUtils.GetItemDesc(self.itemTid))
  StrUtils.SetPreferredHeight(self.ui.Text_Normal_Desc, 30)
  local weaponData = ItemDataUtils.ConstructWeaponItem(self.itemTid)
  local secAttr = ItemDataUtils.GetWeaponSecAttr(weaponData)
  if secAttr.id then
    local attrConfig = DT.ActorAttrType[secAttr.id]
    local name = LT.Text(attrConfig.Text)
    local value = ItemDataUtils.RemoveDotZero(secAttr.value)
    value = attrConfig.Percentage and value .. "%" or value
    self:SetText(self.ui.Text_Main_Property, LT.Text(name))
    self:SetText(self.ui.Textt_Main_Property_Count, LT.Text(value))
  else
    self:SetText(self.ui.Text_Main_Property, "")
    self:SetText(self.ui.Textt_Main_Property_Count, "")
  end
  self.ui.Text_Weapon_Prim_Attr_Name_1:SetActive(false)
  self.ui.Text_Weapon_Prim_Attr_Name_2:SetActive(false)
  self.ui.Text_Weapon_Prim_Attr_Name_3:SetActive(false)
  local weaponLevel = weaponData.level or 0
  local refineStage1MaxLevel = DT.GetConstant("WeaponRefineSkillParaNum")
  local numStars = math.min(weaponLevel, refineStage1MaxLevel)
  for i = 1, 3 do
    local obj = self.ui["Star_" .. i]
    if obj then
      obj:SetActive(i <= numStars)
    end
  end
  if weaponLevel > refineStage1MaxLevel then
    self.ui.Image_Max:SetActive(true)
    self:SetText(self.ui.Text_Max, weaponLevel - refineStage1MaxLevel)
  else
    self.ui.Image_Max:SetActive(false)
  end
  local stateDesc = SkillUtils.GetWeaponStateDesc(weaponData.tid, weaponData.level)
  if "" == stateDesc then
    self.ui.Text_Weapon_Desc_1:SetActive(false)
  else
    self:SetText(self.ui.Text_Weapon_Desc_1, stateDesc, nil, nil, true)
  end
  self.ui.Text_Weapon_Desc_2:SetActive(false)
  local storyDesc = DT.Item[weaponData.tid].StoryDesc
  self.ui.Text_Desc_Sec:SetActive(true)
  self:SetText(self.ui.Text_Desc_Sec, storyDesc)
  self:BindTimer(0.1, 0, nil, function()
    StrUtils.SetPreferredHeight(self.ui.Text_Weapon_Desc_1, 30)
    StrUtils.SetPreferredHeight(self.ui.Text_Weapon_Desc_2, 30)
    StrUtils.SetPreferredHeight(self.ui.Text_Desc_Sec, 30)
    CS.Framework.UIUtilTool.RefreshLayoutImmediate(self.ui.Group_Weapon)
    CS.Framework.UIUtilTool.RefreshLayoutImmediate(self.ui.bg1)
  end)
end

function CompPublicWeaponTips:CalTMPFontSizeHeight(fontObj, lineSpaceScale, offset)
  local compTMP = fontObj:GetComponent(typeof(CS.TMPro.TMP_Text))
  compTMP:ForceMeshUpdate()
  local fontSize = compTMP.fontSize
  local fontSpaceing = compTMP.lineSpacing
  local lineCount = compTMP.textInfo.lineCount
  local tran = compTMP.transform
  local sizeDelta = tran.sizeDelta
  sizeDelta.y = fontSize * lineCount + (lineCount - 1) * fontSpaceing * lineSpaceScale + (offset or 0)
  tran.sizeDelta = sizeDelta
end

function CompPublicWeaponTips:OnExitComponent()
  Super.OnExitComponent(self)
end

return CompPublicWeaponTips
