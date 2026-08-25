local UICompPvpCollectionDetailSkillItem, Super = NewViewComponent("UICompPvpCollectionDetailSkillItem")

function UICompPvpCollectionDetailSkillItem:ctor(uiNode, view, viewData)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Pvp_Btn_CardResource(uiNode)
  self:_InitViewData(viewData)
end

function UICompPvpCollectionDetailSkillItem:OnEnterComponent()
  self:_RefreshView()
end

function UICompPvpCollectionDetailSkillItem:RegisterNotifications()
  self:RegisterNotify(NotifyId.OnPvpCollectionSelectSkillChange, self._RefreshSelectState, self)
end

function UICompPvpCollectionDetailSkillItem:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Card, System.fn(self, self._OnClick))
end

function UICompPvpCollectionDetailSkillItem:_OnClick()
  if self._clickCallback then
    self._clickCallback()
  end
end

function UICompPvpCollectionDetailSkillItem:_InitViewData(viewData)
  self._skillTid = viewData.skillTid
  self._num = viewData.num
  self._clickCallback = viewData.clickCallback
end

function UICompPvpCollectionDetailSkillItem:_IsSelected()
  return PvpCollectionModel.Instance:GetSelectAwakerSkillTid() == self._skillTid
end

function UICompPvpCollectionDetailSkillItem:_IsNumVisible()
  return self._num and self._num > 1
end

function UICompPvpCollectionDetailSkillItem:_RefreshView()
  local skillCfg = SkillCfgUtils.GetCfg(self._skillTid)
  local skillName = BattleSkillUtils.GetSkillName(skillCfg, 0, 0)
  self:SetText(self.ui.Text_Expenses, skillCfg.Cost)
  self:SetText(self.ui.Text_Sheet, ItemNumUtils.GetStr(self._num or ""))
  self:SetText(self.ui.Text_Name, skillName)
  self:SetActive(self.ui.Group_Sheet, self:_IsNumVisible())
  local comp = AutoAdaptionText.StartAutoAdaptionText(self.ui.Text_Name)
  if comp then
    comp:SetBtn(self.ui.Btn_Card)
  end
  self:_RefreshSelectState()
end

function UICompPvpCollectionDetailSkillItem:_RefreshSelectState()
  self:SetActive(self.ui.Image_Selected, self:_IsSelected())
end

return UICompPvpCollectionDetailSkillItem
