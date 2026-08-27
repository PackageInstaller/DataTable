local base = require("Game.Exploration.UI.ChipDiscard.UIEpChipDiscardBase")
local UIEpChallengeDiscard = class("UIEpChallengeDiscard", base)

function UIEpChallengeDiscard:OnInit()
  base.OnInit(self)
  UIUtil.AddButtonListener(self.ui.btn_background, self, self.CloseEpDiscard)
end

function UIEpChallengeDiscard:OnShow()
  base.OnShow(self)
  if not ExplorationManager:IsInTDExp() then
    MsgCenter:Broadcast(eMsgEventId.DungeonHeroListActiveSet, false)
  end
end

function UIEpChallengeDiscard:OnHide()
  base.OnHide(self)
  if not ExplorationManager:IsInTDExp() then
    MsgCenter:Broadcast(eMsgEventId.DungeonHeroListActiveSet, true)
  end
end

function UIEpChallengeDiscard:InitEpChipDiscard(dynPlayer, closeCallback, needConsumeSkill)
  base.InitEpChipDiscard(self, dynPlayer, closeCallback, needConsumeSkill)
  self.ui.btn_AddTotalCount.gameObject:SetActive(false)
  self.ui.btn_Map.gameObject:SetActive(false)
end

function UIEpChallengeDiscard:OnChipListChange(isFirstOpen)
  base.OnChipListChange(self, isFirstOpen)
  self:SetEmptyUI(#self.chipDataList <= 0)
end

function UIEpChallengeDiscard:CloseEpDiscard()
  base.CloseEpDiscard(self)
  if self.isOverLimit then
    return
  end
  self:OnWinClose()
end

function UIEpChallengeDiscard:OnWinClose()
  base.OnWinClose(self)
end

function UIEpChallengeDiscard:OnDiscardChip()
  base.OnDiscardChip(self)
  local msg = string.format(ConfigData:GetTipContent(288), self.selectedData:GetName(), tostring(self.selectChipPrice))
  CS.MessageCommon.ShowMessageBox(msg, function()
    local netCtrl = NetworkManager:GetNetwork(NetworkTypeID.Exploration)
    netCtrl:CS_EXPLORATION_Alg_Sold(self.selectedData.dataId, function()
      AudioManager:PlayAudioById(1040)
    end)
    self.selectedData = nil
  end, nil)
end

function UIEpChallengeDiscard:InitDiscardChipItem(item, chipData, index)
  item:InitDiscardChipItemInSellout(self.discardId, chipData, self._onDiscardItemClick, self.dynPlayer)
  item:SetItemSelect(self.selectedData == chipData)
  if self.selectedData == nil and index == 0 then
    self:_OnDiscardItemClick(item)
  end
end

function UIEpChallengeDiscard:OnDelete()
  self.selectedData = nil
  base.OnDelete(self)
end

return UIEpChallengeDiscard
