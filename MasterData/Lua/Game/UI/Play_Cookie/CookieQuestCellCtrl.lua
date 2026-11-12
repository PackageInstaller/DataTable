local CookieQuestCellCtrl = class("CookieQuestCellCtrl", BaseCtrl)
local JumpUtil = require("Game.Common.Utils.JumpUtil")
CookieQuestCellCtrl._mapNodeConfig = {
  txtQuestName = {sComponentName = "TMP_Text"},
  imgTrophy = {sComponentName = "Image"},
  btnReceive = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Receive"
  },
  txtBtnReceive = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_Receive_Btn_Text"
  },
  btnJumpTo = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_JumpTo"
  },
  txtBtnJumpTo = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_JumpTo_Text"
  },
  goReceived = {},
  goBtns = {},
  imgBarFill = {
    sComponentName = "RectTransform"
  },
  txtProgress = {sComponentName = "TMP_Text"},
  btnRewardItem = {nCount = 2, sComponentName = "UIButton"},
  item = {
    nCount = 2,
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl"
  },
  btnItem = {
    sNodeName = "btnRewardItem",
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_RewardItem"
  }
}
local tbTrophySprite = {
  "UI/big_sprites/bg_activity_cookie_task_01",
  "UI/big_sprites/bg_activity_cookie_task_02",
  "UI/big_sprites/bg_activity_cookie_task_03"
}
local nProgressBarLength = 562
local nProgressBarMin = 48
local nProgressBarHeight = 37

function CookieQuestCellCtrl:Init(questData, nActId)
  self.questData = questData
  if self.questData == nil then
    return
  end
  self.actData = PlayerData.Activity:GetActivityDataById(nActId)
  self.mapStatus = self.actData:GetQuestDataById(questData.Id)
  if self.mapStatus == nil then
    local tbJson = decodeJson(questData.CompleteCondParams)
    self.mapStatus = {
      nId = questData.Id,
      nStatus = AllEnum.ActQuestStatus.UnComplete,
      progress = {
        Cur = 0,
        Max = tbJson[#tbJson]
      }
    }
  end
  self.tbReward = {}
  for i = 1, 2 do
    local nRewardId = self.questData["Reward" .. i .. "Tid"]
    local nRewardQty = self.questData["Reward" .. i .. "Qty"]
    if nRewardId ~= nil and 0 < nRewardId and nRewardQty ~= nil and 0 < nRewardQty then
      table.insert(self.tbReward, {nRewardId, nRewardQty})
      self._mapNode.btnRewardItem[i].gameObject:SetActive(true)
    else
      self._mapNode.btnRewardItem[i].gameObject:SetActive(false)
    end
  end
  self.tbBtn = self._mapNode.btnRewardItem
  for k, v in pairs(self.tbReward) do
    self._mapNode.item[k]:SetItem(v[1], nil, v[2])
  end
  NovaAPI.SetTMPText(self._mapNode.txtQuestName, self.questData.Desc)
  self:SetPngSprite(self._mapNode.imgTrophy, tbTrophySprite[self.questData.Rarity] or tbTrophySprite[1])
  self:UpdateCellStatus()
end

function CookieQuestCellCtrl:Awake(...)
end

function CookieQuestCellCtrl:OnDisable()
end

function CookieQuestCellCtrl:UpdateCellStatus()
  self._mapNode.btnReceive.gameObject:SetActive(false)
  self._mapNode.btnJumpTo.gameObject:SetActive(false)
  self._mapNode.goReceived:SetActive(false)
  NovaAPI.SetTMPText(self._mapNode.txtProgress, orderedFormat("{0}/{1}", self.mapStatus.progress.Cur, self.mapStatus.progress.Max))
  if self.mapStatus.nStatus == AllEnum.ActQuestStatus.Complete then
    self._mapNode.btnReceive.gameObject:SetActive(true)
    self._mapNode.imgBarFill.sizeDelta = Vector2(nProgressBarLength, nProgressBarHeight)
  elseif self.mapStatus.nStatus == AllEnum.ActQuestStatus.UnComplete then
    local nLength = self.mapStatus.progress.Cur / self.mapStatus.progress.Max * nProgressBarLength
    if nLength < nProgressBarMin then
      if 0 < nLength then
        nLength = nProgressBarMin
      else
        nLength = 0
      end
    end
    self._mapNode.imgBarFill.sizeDelta = Vector2(nLength, nProgressBarHeight)
    if self.questData.JumpTo ~= nil then
      self.nJumpTo = self.questData.JumpTo
      self._mapNode.btnJumpTo.gameObject:SetActive(true)
    end
  elseif self.mapStatus.nStatus == AllEnum.ActQuestStatus.Received then
    self._mapNode.goReceived:SetActive(true)
    self._mapNode.imgBarFill.sizeDelta = Vector2(nProgressBarLength, nProgressBarHeight)
  end
end

function CookieQuestCellCtrl:OnBtnClick_RewardItem(btn, nIndex)
  local nRewardId
  if self.tbReward ~= nil and self.tbReward[nIndex] ~= nil then
    nRewardId = self.tbReward[nIndex][1]
  end
  if nRewardId ~= nil then
    UTILS.ClickItemGridWithTips(nRewardId, btn.transform, true, true, false)
  end
end

function CookieQuestCellCtrl:OnBtnClick_Receive()
  self.actData:SendQuestReceive(self.mapStatus.nId)
end

function CookieQuestCellCtrl:OnBtnClick_JumpTo()
  if nil ~= self.nJumpTo and 0 ~= self.nJumpTo then
    JumpUtil.JumpTo(self.nJumpTo)
  end
end

return CookieQuestCellCtrl
