local AchievementGridCtrl = class("AchievementGridCtrl", BaseCtrl)
local JumpUtil = require("Game.Common.Utils.JumpUtil")
local nBarLength = 512
local nBarHeight = 512
AchievementGridCtrl._mapNodeConfig = {
  imgCup = {sComponentName = "Image"},
  TMPTitle = {sComponentName = "TMP_Text"},
  TMPDesc = {sComponentName = "TMP_Text"},
  TMPProcess = {sComponentName = "TMP_Text"},
  TMPTimeTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Achievement_Tips_Completed"
  },
  txtBtnJump = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_JumpTo"
  },
  TMPTime = {sComponentName = "TMP_Text"},
  rtBarFill = {
    sComponentName = "RectTransform"
  },
  btnItem = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Item"
  },
  btnReceive = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Receive"
  },
  btnJump = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Jumpto"
  },
  rtItem = {
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl"
  },
  imgCup0 = {nCount = 3},
  txtBtnReceive = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_Receive_Btn_Text"
  },
  TMPUncomplete = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_UnComplete_Text"
  }
}
AchievementGridCtrl._mapEventConfig = {}
AchievementGridCtrl._mapRedDotConfig = {}

function AchievementGridCtrl:Awake()
end

function AchievementGridCtrl:FadeIn()
end

function AchievementGridCtrl:FadeOut()
end

function AchievementGridCtrl:OnEnable()
end

function AchievementGridCtrl:OnDisable()
end

function AchievementGridCtrl:OnDestroy()
end

function AchievementGridCtrl:OnRelease()
end

function AchievementGridCtrl:OnGridRefresh(mapAchievement)
  self.mapAchievement = mapAchievement
  local mapAchievementCfgData = ConfigTable.GetData("Achievement", mapAchievement.nId)
  if mapAchievementCfgData == nil then
    self.gameObject:SetActive(false)
    return
  end
  NovaAPI.SetTMPText(self._mapNode.TMPTitle, mapAchievementCfgData.Title)
  NovaAPI.SetTMPText(self._mapNode.TMPDesc, mapAchievementCfgData.Desc)
  if mapAchievementCfgData.Tid1 ~= 0 then
    self._mapNode.rtItem.gameObject:SetActive(true)
    self._mapNode.rtItem:SetItem(mapAchievementCfgData.Tid1, nil, mapAchievementCfgData.Qty1, nil, mapAchievement.nStatus == 3)
  else
    self._mapNode.rtItem.gameObject:SetActive(false)
  end
  self._mapNode.btnReceive.gameObject:SetActive(mapAchievement.nStatus == 1)
  self._mapNode.btnJump.gameObject:SetActive(mapAchievement.nStatus == 2 and 0 < mapAchievementCfgData.JumpTo)
  self._mapNode.TMPTimeTitle.gameObject:SetActive(mapAchievement.nStatus == 3)
  self._mapNode.TMPUncomplete.gameObject:SetActive(mapAchievement.nStatus == 2 and mapAchievementCfgData.JumpTo == 0)
  NovaAPI.SetTMPText(self._mapNode.TMPProcess, string.format("%d/%d", mapAchievement.nCur, mapAchievement.nMax))
  if mapAchievement.nStatus == 3 then
    self._mapNode.rtBarFill.sizeDelta = Vector2(nBarLength, nBarHeight)
    NovaAPI.SetTMPText(self._mapNode.TMPTime, mapAchievement.sTime)
  elseif 0 < mapAchievement.nMax then
    self._mapNode.rtBarFill.sizeDelta = Vector2(nBarLength * (mapAchievement.nCur / mapAchievement.nMax), nBarHeight)
  else
    self._mapNode.rtBarFill.sizeDelta = Vector2(0, nBarHeight)
  end
  self:SetPngSprite(self._mapNode.imgCup, "UI/big_sprites/zs_achievement_cup_0" .. mapAchievementCfgData.Rarity)
  for i = 1, 3 do
    self._mapNode.imgCup0[i]:SetActive(i == mapAchievementCfgData.Rarity and mapAchievement.nStatus == 3)
  end
end

function AchievementGridCtrl:OnBtnClick_Receive()
  local mapAchievementCfgData = ConfigTable.GetData("Achievement", self.mapAchievement.nId)
  PlayerData.Achievement:SendAchievementRewardReq({
    self.mapAchievement.nId
  }, mapAchievementCfgData.Type, nil)
end

function AchievementGridCtrl:OnBtnClick_Jumpto()
  local mapAchievementCfgData = ConfigTable.GetData("Achievement", self.mapAchievement.nId) or {}
  JumpUtil.JumpTo(mapAchievementCfgData.JumpTo)
end

function AchievementGridCtrl:OnBtnClick_Item(btn)
  local mapAchievementCfgData = ConfigTable.GetData("Achievement", self.mapAchievement.nId)
  if mapAchievementCfgData == nil then
    return
  end
  UTILS.ClickItemGridWithTips(mapAchievementCfgData.Tid1, btn.gameObject, true, true, true)
end

return AchievementGridCtrl
