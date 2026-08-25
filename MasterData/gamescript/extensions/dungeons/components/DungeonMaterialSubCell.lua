local DungeonMaterialSubCell, Super = NewViewComponent("DungeonMaterialCell")

function DungeonMaterialSubCell:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Dungeons_Item_Common_TierResource(uiNode)
  self.data = data
  self.stageId = data.stageID
  self.starNum = 3
end

function DungeonMaterialSubCell:OnEnterComponent()
  self:_RefreshInfo()
end

function DungeonMaterialSubCell:_RefreshInfo()
  local stageCfg = DT.Stage[self.stageId]
  if self.data and stageCfg then
    local curStageId = DungeonMaterialModel.Instance:GetStageId()
    local isSelect = curStageId == self.stageId
    local unlock = DungeonMaterialController.Instance:IsUnLockStage(self.stageId)
    local unlockTips = DungeonMaterialController.Instance:GetStageUnlockTips(self.stageId)
    self:SetText(self.ui.Text_Title, stageCfg.Name)
    self:SetText(self.ui.Text_Tip, unlockTips)
    self:SetText(self.ui.Text_Desc, self.data.Desc)
    self:SetTextColorType(self.ui.Text_Title, unlock and CommonDefine.ColorType.Light or CommonDefine.ColorType.Dark)
    self:SetTextColorType(self.ui.Text_Tip, unlock and CommonDefine.ColorType.Light or CommonDefine.ColorType.Dark)
    self.ui.Image_Select:SetActive(isSelect)
    self.ui.Group_Nor:SetActive(unlock)
    self.ui.Image_Mask:SetActive(not unlock)
    for i = 1, self.starNum do
      self.ui["Image_Star" .. i]:SetActive(i <= self.data.star)
    end
    self:AddButtonClickListener(self.ui.Btn_Click, System.fn(self, self._OnClick))
  end
end

function DungeonMaterialSubCell:OnExitComponent()
  Super.OnExitComponent(self)
end

function DungeonMaterialSubCell:_OnClick()
  self:LocalNotify(NotifyId.OnMaterialStageChange, self.stageId)
end

return DungeonMaterialSubCell
