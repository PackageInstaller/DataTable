local CopySettleTeamDataItem, Super = NewViewComponent("CopySettleTeamDataItem")

function CopySettleTeamDataItem:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Dungeons_Item_TeamDataResource(uiNode)
  self.stageDataId = data.stageDataId
  self.lightVal = data.lightVal
  self.darkVal = data.darkVal
  self.stageDataCfg = DT.StageData[self.stageDataId]
end

function CopySettleTeamDataItem:OnEnterComponent()
  local stageDataName = LT.Text(self.stageDataCfg.Name)
  local stageDataDesc = LT.Text(self.stageDataCfg.Desc)
  self:SetText(self.ui.Text_Val_Light, self:GetLightShowVal())
  self:SetText(self.ui.Text_Val_Dark, self.darkVal)
  self:SetText(self.ui.Text_Name, stageDataName)
  StrUtils.SetPreferedWidthFontSize(self.ui.Text_Name, nil, 300)
  if self.stageDataCfg.Desc then
    self.ui.Group_Icon:SetActive(true)
    self:AddButtonClickListener(self.ui.Group_Icon, function()
      local tipData = {title = stageDataName, desc = stageDataDesc}
      Alert.ShowToolTipsByData(tipData, self.ui.Group_Icon)
    end)
  else
    self.ui.Group_Icon:SetActive(false)
  end
end

local oriRecordDataGroup = {
  "maxHp",
  "leftHp",
  "bossBattleRoundCount",
  "deathResistCount",
  "respawnedNum"
}

function CopySettleTeamDataItem:GetLightShowVal()
  local key = self.stageDataCfg.Key or ""
  local recordTime = CopySettleModel.Instance:Get_recordTime()
  if not table.contains(oriRecordDataGroup, key) and self.lightVal == "0" and 0 == recordTime then
    return "-"
  end
  return self.lightVal
end

function CopySettleTeamDataItem:OnExitComponent()
  Super.OnExitComponent(self)
end

return CopySettleTeamDataItem
