local AwakerSpecialSkillActivePanel, Super = System.NewClass("AwakerSpecialSkillActivePanel", UIBasePanel)
AwakerSpecialSkillActivePanel.uiResCls = UI_Awaker_Special_Skill_PopupResource

function AwakerSpecialSkillActivePanel:ctor(effectType, funcModule)
  Super.ctor(self)
  self.funcModule = funcModule
  self.skillEffectType = effectType
  self.skillEffectList = nil
end

function AwakerSpecialSkillActivePanel:OnBind(binder)
  self.model = binder:createModel(AwakerSpecialSkillModel)
  binder:BindToCircularListView(self.ui.ScrollView_Item, System.fn(self, self._GetEffectList), System.fn(self, self._OnEffectListItemUpdate))
  local commonPopupConfirmTipsData = {
    textTitleCN = self.model:GetSpecialSkillEffectTypeName(self.skillEffectType),
    sizeType = CommonDefine.PopupTipsType.L,
    clickFunc = System.fn(self, self.ClosePanel)
  }
  self.binder:BindComponent(CommonPopupTips(self.ui.UI_Common_Popup_Tips_L, commonPopupConfirmTipsData))
end

function AwakerSpecialSkillActivePanel:_GetEffectList()
  if self.skillEffectList then
    return self.skillEffectList
  end
  self.skillEffectList = self.model:GetEffectListByType(self.skillEffectType, self.funcModule)
  return self.skillEffectList
end

function AwakerSpecialSkillActivePanel:_OnEffectListItemUpdate(itemBinder, go, index)
  local data = self.skillEffectList[index]
  itemBinder:BindComponent(AwakerSpecialSkillListItem(go, data, self.model))
end

function AwakerSpecialSkillActivePanel:ClosePanel()
  self:Close()
end

return AwakerSpecialSkillActivePanel
