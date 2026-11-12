local ActivityReengagement_101004PopUpCtrl = class("ActivityReengagement_101004PopUpCtrl", BaseCtrl)
local LocalData = require("GameCore.Data.LocalData")
local ClientManager = CS.ClientManager.Instance
ActivityReengagement_101004PopUpCtrl._mapNodeConfig = {
  txtTips = {
    sComponentName = "TMP_Text",
    sLanguageId = "Reengagement_Popup_Tip"
  },
  goRewardItem = {
    nCount = 4,
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl"
  },
  btnRewardItem = {
    nCount = 4,
    sNodeName = "goRewardItem",
    sComponentName = "UIButton",
    callback = "OnClickBtnRewardItem"
  },
  rtBtn = {},
  btnWelcome = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Welcome"
  },
  txtBtnWelcome = {
    sComponentName = "TMP_Text",
    sLanguageId = "Reengagement_Popup_Welcome"
  }
}
ActivityReengagement_101004PopUpCtrl._mapEventConfig = {}

function ActivityReengagement_101004PopUpCtrl:ShowPopUp(actId, callback, index)
  self.popUpIndex = index
  self.nCurActId = actId
  self.callback = callback
  local bCanReceive = PlayerData.Reengagement:CheckCanReceive()
  self._mapNode.rtBtn:SetActive(bCanReceive)
  local nActId = PlayerData.Reengagement:GetActId()
  local mapActData = ConfigTable.GetData("ActivityReturneeReunionReward", nActId)
  if mapActData == nil then
    if self.callback ~= nil then
      self.callback()
    end
    return
  end
  local tbRewards = {}
  self.tbItemReward = {}
  for i = 1, 3 do
    local nId = mapActData["Reward" .. i .. "Tid"]
    local nQty = mapActData["Reward" .. i .. "Qty"]
    if 0 < nId then
      table.insert(tbRewards, {nId = nId, nQty = nQty})
      table.insert(self.tbItemReward, nId)
    end
  end
  for i = 1, #self._mapNode.goRewardItem do
    local item = self._mapNode.goRewardItem[i]
    if i <= #tbRewards then
      item:SetItem(tbRewards[i].nId, nil, tbRewards[i].nQty)
      self._mapNode.btnRewardItem[i].gameObject:SetActive(true)
    else
      self._mapNode.btnRewardItem[i].gameObject:SetActive(false)
    end
  end
  self.anim = self.gameObject:GetComponent("Animator")
  self:PlayOpenAnim()
end

function ActivityReengagement_101004PopUpCtrl:PlayOpenAnim()
  if self.anim then
    self.anim:Play("open", 0, 0)
  end
end

function ActivityReengagement_101004PopUpCtrl:ClosePopUp(callback)
  if self.anim ~= nil then
    self.anim:Play("close", 0, 0)
    self:AddTimer(1, 0.1, function()
      if callback ~= nil then
        callback()
      end
    end, true, true, true)
    EventManager.Hit(EventId.TemporaryBlockInput, 0.1)
  elseif callback ~= nil then
    callback()
  end
end

function ActivityReengagement_101004PopUpCtrl:OnBtnClick_Close()
  self:ClosePopUp(self.callback)
end

function ActivityReengagement_101004PopUpCtrl:OnBtnClick_Goto()
  local function callback()
    if nil ~= self.nCurActId then
      PlayerData.Activity:SendActivityDetailMsg()
      
      local endTime = PlayerData.Reengagement:GetReengagementCloseTime()
      local curTime = ClientManager.serverTimeStamp
      local remainTime = endTime - curTime
      if remainTime <= 0 then
        EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Activity_Invalid_Tip_3"))
        if self.callback ~= nil then
          self.callback()
        end
        return
      end
      PopUpManager.PauseAfterCurrent()
      
      local function openAct()
        EventManager.Hit(EventId.OpenPanel, PanelId.ReengagementPanel)
      end
      
      if self.callback ~= nil then
        self.callback(openAct, true)
      else
        openAct()
      end
    end
  end
  
  self:ClosePopUp(callback)
end

function ActivityReengagement_101004PopUpCtrl:OnClickBtnRewardItem(btn, index)
  UTILS.ClickItemGridWithTips(self.tbItemReward[index], self._mapNode.btnRewardItem[index].transform, true, true, false)
end

function ActivityReengagement_101004PopUpCtrl:OnBtnClick_Welcome()
  local function cb()
    self:OnBtnClick_Goto()
  end
  
  PlayerData.Reengagement:RequestReceiveReunionReward(cb)
end

return ActivityReengagement_101004PopUpCtrl
