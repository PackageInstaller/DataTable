local Vector2 = CS.UnityEngine.Vector2
local NewBuffListItem, Super = System.NewComponent("NewBuffListItem")

function NewBuffListItem:ctor(uiNode, role, buff, spacing)
  Super.ctor(self)
  self.ui = Item_Battle_Information_NewResource(uiNode)
  self.role = role
  self.buff = buff
  self.spacing = spacing
end

function NewBuffListItem:OnBind(binder)
  local stateDataClient = BattleStateDataClient(self.buff)
  binder:BindToText(self.ui.Text_Information_Explain, function()
    do return stateDataClient.GetDesc end
    return stateDataClient.GetDesc, stateDataClient
  end)
  binder:BindToText(self.ui.Text_Information_Name, function()
    do return stateDataClient.GetBuffName end
    return stateDataClient.GetBuffName, stateDataClient
  end)
  binder:BindToText(self.ui.Text_Buff_Count, function()
    if 0 == self.buff.layer or not self.buff.layer then
      return
    end
    do return stateDataClient.GetLifeText end
    return stateDataClient.GetLifeText, stateDataClient
  end)
  if bg.isPVP then
    binder:BindToRaw(function(_, color)
      if not color then
        return
      end
      binder:SetTextColorByHtml(self.ui.Text_Buff_Count, color)
    end, function()
      local layer = self.buff.layer or 0
      if layer <= 0 then
        return
      end
      do return StateDataUtils.GetPvpStatusLayerColor end
      return StateDataUtils.GetPvpStatusLayerColor, stateDataClient.configData
    end)
  end
  binder:BindToVisible(self.ui.Text_Buff_Count, function()
    local life = self.buff.layer or 0
    return life > 1
  end)
  binder:BindToImage(self.ui.Image_Information_Icon, function()
    if stateDataClient.configData.Icon ~= nil then
      return bc.ICON_PATH_PERFIX .. stateDataClient.configData.Icon
    end
  end)
  self.textComp = binder:GetTextComp(self.ui.Text_Information_Explain)
  self.preSizeDelta = self.preSizeDelta or self.ui.uiNode.transform.sizeDelta
  local height = math.max(120, self.textComp.preferredHeight + (self.spacing or 0))
  local newSizeDelta = Vector2(self.preSizeDelta.x, height)
  self.ui.uiNode.transform.sizeDelta = newSizeDelta
end

return NewBuffListItem
