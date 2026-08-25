local DungeonBattleTeachingSubCell, Super = NewViewComponent("DungeonBattleTeachingSubCell")

function DungeonBattleTeachingSubCell:ctor(uiNode, view, stageData)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Dungeons_Item_Common_ElementResource(uiNode)
  self.stageData = stageData
  self.stageId = stageData.stageID
end

function DungeonBattleTeachingSubCell:OnEnterComponent()
  self:_RefreshView()
end

function DungeonBattleTeachingSubCell:_RefreshView()
  local stageCfg = DT.Stage[self.stageId]
  if not stageCfg then
    return
  end
  self:SetText(self.ui.Text_Title, LT.Text(stageCfg.Name))
  self:SetText(self.ui.Text_Tip, LT.Text(""))
  local curStageId = DungeonMaterialModel.Instance:GetStageId()
  self:SetActive(self.ui.Group_Select, self.stageId == curStageId)
  if self.stageId == curStageId then
    RedPointDataUtils.ClearBattleTeachingItemRed(self.stageId)
  end
  self:SetActive(self.ui.Group_Complete, self.stageData.firstRewardDraw)
  if self.stageData.firstRewardDraw then
    RedPointDataUtils.ClearBattleTeachingItemRed(self.stageId)
  end
  self:SetImage(self.ui.Image_D_Icon, stageCfg.StageNodeIcon)
  self:AddButtonClickListener(self.ui.Btn_Click, System.fn(self, self._OnClick))
  self.binder:BindComponent(RedDotComponent(self.ui.Com_RedDot, CommonDefine.RedDotType.TextNew, nil, function()
    do return RedPointDataUtils.IsShowBattleTeachingItemRed end
    return RedPointDataUtils.IsShowBattleTeachingItemRed, self.stageId
  end))
end

function DungeonBattleTeachingSubCell:_OnClick()
  self:LocalNotify(NotifyId.OnMaterialStageChange, self.stageId)
end

return DungeonBattleTeachingSubCell
