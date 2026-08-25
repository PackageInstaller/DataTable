local FreeTrialAwakerItem, Super = NewViewComponent("FreeTrialAwakerItem")

function FreeTrialAwakerItem:ctor(uiNode, view, stageId)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Dungeous_Item_ExpressionResource(uiNode)
  local awakerId = FreeTrialController.Instance:GetAwakerByStageId(stageId)
  self.awakerId = awakerId
  self.stageId = stageId
end

function FreeTrialAwakerItem:RegisterNotifications()
  self:RegisterLocalNotify(NotifyId.OnSelectTrialAwaker, self.SelectTrialAwaker, self)
  self:RegisterLocalNotify(NotifyId.UpdateTrialAwaker, self.UpdateRed, self)
  self:RegisterLocalNotify(NotifyId.UpdateTrialAwakerFinishState, self.UpdateIcon, self)
end

function FreeTrialAwakerItem:OnEnterComponent()
  self:UpdateIcon()
  local curStageId = FreeTrialModel.Instance.curStageId
  self:UpdateSelected(curStageId, FreeTrialController.Instance:GetAwakerByStageId(curStageId))
  self:UpdateRed()
end

function FreeTrialAwakerItem:UpdateRed()
  local redType = CommonDefine.RedDotType.Dot
  if not self.redCom then
    self.redCom = self:AddViewComponentOnce(self.ui.Com_RedDot_Daily, UICompRedDot, redType, nil)
  end
  local result = RedPointDataUtils.TrialStageHasAward(self.stageId)
  self.redCom:SetRedDotShow(redType, result)
end

function FreeTrialAwakerItem:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Click, function()
    self:LocalNotify(NotifyId.OnSelectTrialAwaker, self.stageId, self.awakerId)
    self:UpdateRed()
  end)
end

function FreeTrialAwakerItem:SelectTrialAwaker(stageId, awakerId)
  self:UpdateSelected(stageId, awakerId)
end

function FreeTrialAwakerItem:UpdateSelected(stageId, awakerId)
  self.ui.Image_Choose:SetActive(stageId == self.stageId and awakerId == self.awakerId)
end

function FreeTrialAwakerItem:UpdateIcon()
  local awakerCfg = DT.AwakerConfig[self.awakerId]
  self:SetImage(self.ui.Image_Icon, awakerCfg.Item_LittleIcon)
  local finish = FreeTrialController.Instance:FinshAndGetedAward(self.stageId)
  self.ui.Group_Get:SetActive(finish)
end

return FreeTrialAwakerItem
