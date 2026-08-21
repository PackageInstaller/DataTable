_class("UIBattlePassCN1SkinBtn", UICustomWidget)
UIBattlePassCN1SkinBtn = UIBattlePassCN1SkinBtn

function UIBattlePassCN1SkinBtn:SetData(campaign, index, tipsCallback)
  self._campaign = campaign
  self._index = index
  self._tipsCallback = tipsCallback
  self:_SetDesc(index)
end

function UIBattlePassCN1SkinBtn:SetPos(pos)
  UIWidgetHelper.SetAnchoredPosition(self, "_root", pos[1], pos[2])
end

function UIBattlePassCN1SkinBtn:_SetDesc(index)
  local widget = {
    "_txtDesc1",
    "_txtDesc2",
    "_txtDesc3"
  }
  local tb = {
    [1] = {
      "str_activity_battlepass_skinbtn_A_desc_1",
      "str_activity_battlepass_skinbtn_A_desc_2",
      "str_activity_battlepass_skinbtn_A_desc_3"
    },
    [2] = {
      "str_activity_battlepass_skinbtn_B_desc_1",
      "str_activity_battlepass_skinbtn_B_desc_2"
    }
  }
  for i, v in ipairs(tb[index]) do
    local widgetName = widget[i]
    local strId = UIActivityBattlePassHelper.GetStrIdInCampaign(self._campaign, v)
    UIWidgetHelper.SetLocalizationText(self, widgetName, StringTable.Get(strId))
  end
  if index == 1 then
    local obj = self:GetUIComponent("RollingText", "_txtDesc3")
    obj:RefreshText(nil)
  end
end

function UIBattlePassCN1SkinBtn:BtnOnClick(go)
  Log.info("UIBattlePassCN1SkinBtn:BtnOnClick() " .. self._index)
  local cfg1, cfg2 = UIActivityBattlePassHelper.GetLvRewardCfg(self._campaign)
  local cfg = self._index == 1 and cfg1 or cfg2
  local matid = cfg.RewardInfo[1]
  self._tipsCallback(matid, nil)
end
