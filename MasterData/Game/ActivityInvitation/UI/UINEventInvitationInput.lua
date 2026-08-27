local UINEventInvitationInput = class("UINEventInvitationInput", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")
local cs_MessageCommon = CS.MessageCommon

function UINEventInvitationInput:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Confim, self, self.OnClickCommit)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.Hide)
  self._itemPool = UIItemPool.New(UINBaseItemWithReceived, self.ui.uINBaseItemWithReceived)
  self.ui.uINBaseItemWithReceived:SetActive(false)
end

function UINEventInvitationInput:InitInvitationInput(invitationData)
  self._invitationData = invitationData
  self.ui.tex_Title.text = invitationData:GetInvitationInputName()
  self._itemPool:HideAll()
  local rewardIds, rewardNums = self._invitationData:GetInvitationReward()
  if rewardIds ~= nil then
    for i, itemId in ipairs(rewardIds) do
      local item = self._itemPool:GetOne()
      local itemCfg = ConfigData.item[itemId]
      local itemNum = rewardNums[i]
      item:InitItemWithCount(itemCfg, itemNum)
    end
  end
end

function UINEventInvitationInput:OnClickCommit()
  PlayerClickCollectManager:BtnClickNumCollect(1002)
  if self._invitationData:IsInvitationCommonUser() or self._invitationData:IsInvitationReturnPicked() then
    return
  end
  local code = self.ui.inputField.text
  if #code == 0 then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(7704))
    return
  end
  if code == self._invitationData:GetInvitationCode() then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(7706))
    return
  end
  self._invitationData:ReqInvitationRegister(code)
end

return UINEventInvitationInput
