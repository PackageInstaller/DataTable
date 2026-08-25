local TalentOverViewPanel, Super = System.NewClass("TalentOverViewPanel", UIBasePanel)
TalentOverViewPanel.uiResCls = UI_Research_Popup_DispatchResource

function TalentOverViewPanel:ctor(skillEffectType, funcModule)
  Super.ctor(self)
  self.funcModule = funcModule
  self.skillEffectType = skillEffectType
  self.itemList = TalentDataUtils.GetTalentsByParams(skillEffectType, funcModule, nil)
end

function TalentOverViewPanel:OnBind(binder)
  self.binder = binder
  self:BindCloseBtn()
  self:BindScrollView()
  self:BindTitle()
end

function TalentOverViewPanel:BindTitle()
  local title = DT.CommonID[self.skillEffectType].Desc
  self.binder:SetText(self.ui.Text_Title, title)
end

function TalentOverViewPanel:BindCloseBtn()
  local binder = self.binder
  binder:BindButtonClick(self.ui.UI_Common_Btn_Back1, System.fn(self, self.Close))
end

function TalentOverViewPanel:BindScrollView()
  self.binder:BindToCircularListView(self.ui.ScrollView_Content, System.fn(self, self._GetEffectList), System.fn(self, self._OnEffectListItemUpdate))
end

function TalentOverViewPanel:_GetEffectList()
  return self.itemList
end

function TalentOverViewPanel:_OnEffectListItemUpdate(itemBinder, gameObj, index)
  local curList = self.itemList
  local talentData = curList[index]
  local bCanOperate = true
  itemBinder:BindComponent(AwakerTalentItem(gameObj, self.model, talentData.configId, talentData.awakerId, bCanOperate))
end

function TalentOverViewPanel:ClosePanel()
  self.closeBtn:PlayCloseAnim()
  self:Close()
end

return TalentOverViewPanel
