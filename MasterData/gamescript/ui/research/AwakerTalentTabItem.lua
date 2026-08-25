local AwakerTalentTabItem, Super = System.NewComponent("AwakerTalentTabItem")

function AwakerTalentTabItem:ctor(uiNode, tabType, textName, tabIcons)
  Super.ctor(self)
  self.rootUINode = uiNode
  self.ui = UI_Research_Panel_Ceri_Item_ToggleResource(uiNode)
  self.tabType = tabType
  self.textName = textName
  self.isOn = false
  self.tabIcons = tabIcons
end

function AwakerTalentTabItem:SetCallBack(callback)
  self.callback = callback
end

function AwakerTalentTabItem:OnBind(binder)
  self.binder = binder
  binder:SetText(self.ui.Text_Toggle_Normal, LT.Text(self.textName))
  binder:SetText(self.ui.Text_Toggle_Select, LT.Text(self.textName))
  binder:BindToZ1Toggle(self.rootUINode, self.relativeUI, function(isOn)
    binder:SetActive(self.ui.Group_Select, isOn)
    binder:SetActive(self.ui.Com_NormalRedDot, not isOn)
    self.isOn = isOn
    if isOn then
      self.callback(self.tabType)
    end
  end)
  binder:SetImage(self.ui.Image_Icon_Normal, self.tabIcons[1])
  binder:SetImage(self.ui.Image_Icon_Select, self.tabIcons[2])
  self:BindRedDotComponent(self.ui.Com_SelectRedDot)
  self:BindRedDotComponent(self.ui.Com_NormalRedDot)
end

function AwakerTalentTabItem:BindRedDotComponent(uiRed)
  self.binder:BindComponent(RedDotComponent(uiRed, CommonDefine.RedDotType.Dot, System.fn(self, self.ShowRedDot)))
end

function AwakerTalentTabItem:ShowRedDot()
  do return TalentDataUtils.HasCanUnlockTalentBySchool end
  return TalentDataUtils.HasCanUnlockTalentBySchool, self.tabType
end

return AwakerTalentTabItem
