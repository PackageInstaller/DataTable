local BaseCtrl = require("GameCore.UI.BaseCtrl")
local CharacterFavourCtrl = class("CharacterFavourCtrl", BaseCtrl)
CharacterFavourCtrl._mapNodeConfig = {
  txtFavourLevel = {
    sNodeName = "txtFavourLevel",
    sComponentName = "TMP_Text"
  },
  transFavourBarCenter = {
    sNodeName = "FavourBarCenter",
    sComponentName = "Transform"
  },
  txtFavourNum = {sNodeName = "txtFavour", sComponentName = "TMP_Text"},
  txtFavourBubble = {
    sNodeName = "txtFavourBubble",
    sComponentName = "TMP_Text"
  },
  btnFavourTask = {
    sNodeName = "btnFavourTask",
    sComponentName = "UIButton",
    callback = "OnBtn_ClickOpenTask"
  },
  txtFavourTask = {
    sComponentName = "TMP_Text",
    sLanguageId = "CharacterRelation_Favour_Task"
  },
  btnFavourReward = {
    sNodeName = "btnFavourReward",
    sComponentName = "UIButton",
    callback = "OnBtn_ClickOpenRewardPreview"
  },
  txtFavourReward = {
    sComponentName = "TMP_Text",
    sLanguageId = "CharacterRelation_Favour_Reward"
  },
  txtGiveGift = {
    sComponentName = "TMP_Text",
    sLanguageId = "CharacterRelation_Favour_Gift"
  },
  btnGiveGift = {
    sNodeName = "btnGiveGift",
    sComponentName = "UIButton",
    callback = "OnBtn_ClickOpenGiftPanel"
  },
  imgHeart = {sNodeName = "imgHeart", sComponentName = "Image"},
  aniFavour = {
    sNodeName = "aniFavourRoot",
    sComponentName = "Animator"
  },
  rectImgFavourBar = {
    sNodeName = "imgFavourBar",
    sComponentName = "RectTransform"
  },
  txtFavourTitle = {
    sNodeName = "txtFavourTitle",
    sComponentName = "TMP_Text",
    sLanguageId = "CharacterRelation_Favour_Title"
  }
}
CharacterFavourCtrl._mapEventConfig = {
  [EventId.AffinityChange] = "OnEvent_AffinityChange"
}

function CharacterFavourCtrl:Awake()
  self.progressBarWidth = 162
  self.progressBarMinWidth = 0
end

function CharacterFavourCtrl:OnEnable()
end

function CharacterFavourCtrl:OnBtn_ClickOpenTask()
  EventManager.Hit(EventId.OpenPanel, PanelId.CharFavourTask, self.curCharId)
end

function CharacterFavourCtrl:OnBtn_ClickOpenRewardPreview()
  EventManager.Hit(EventId.OpenPanel, PanelId.CharFavourReward, self.curCharId)
end

function CharacterFavourCtrl:OnBtn_ClickOpenGiftPanel()
  local function openCallback()
    local function callback()
      local bSetGridPos = true
      
      EventManager.Hit(EventId.OpenPanel, PanelId.Phone, 3, self.curCharId, bSetGridPos)
    end
    
    PlayerData.Phone:TrySendAddressListReq(callback)
  end
  
  PlayerData.Base:CheckFunctionBtn(GameEnum.OpenFuncType.Phone, openCallback)
end

function CharacterFavourCtrl:Refresh(nCharId)
  self.curCharId = nCharId
  local affinityData = PlayerData.Char:GetCharAffinityData(nCharId)
  self.curFavourLevel = affinityData.Level
  self.curFavourExp = affinityData.Exp
  local data = {}
  local needExp = 0
  
  local function forEachAffinityLevel(mapData)
    if mapData.AffinityLevel == self.curFavourLevel then
      data = mapData
    elseif mapData.AffinityLevel == self.curFavourLevel + 1 then
      needExp = mapData.NeedExp
    end
  end
  
  ForEachTableLine(DataTable.AffinityLevel, forEachAffinityLevel)
  NovaAPI.SetTMPText(self._mapNode.txtFavourLevel, self.curFavourLevel)
  NovaAPI.SetTMPText(self._mapNode.txtFavourNum, self.curFavourExp .. "/" .. needExp)
  self._mapNode.txtFavourNum.gameObject:SetActive(needExp ~= 0)
  NovaAPI.SetTMPText(self._mapNode.txtFavourBubble, data.AffinityLevelName)
  if data.AffinityLevelIcon ~= "" then
  end
  self._mapNode.aniFavour.gameObject:SetActive(false)
  self._mapNode.aniFavour.gameObject:SetActive(true)
  self._mapNode.aniFavour:SetInteger("affinity_lv", data.AffinityLevelStage)
  local percent = 0
  if needExp ~= 0 then
    percent = self.curFavourExp / needExp
  else
    percent = 1
  end
  self:RefreshProgressBar(percent, 0)
end

function CharacterFavourCtrl:RefreshProgressBar(nPercent, nDuration)
  local sizeDelta = self._mapNode.rectImgFavourBar.sizeDelta
  local nWidth = self.progressBarWidth * nPercent < self.progressBarMinWidth and self.progressBarMinWidth or self.progressBarWidth * nPercent
  self._mapNode.rectImgFavourBar.sizeDelta = Vector2(nWidth, sizeDelta.y)
end

function CharacterFavourCtrl:ResetData()
  self._mapNode.transFavourBarCenter.localEulerAngles = Vector3(0, 0, 0)
end

function CharacterFavourCtrl:OnEvent_AffinityChange(charId, curLevel, lastFavourLevel, curExp, lastExp)
  if self._panel.nPanelId == PanelId.CharacterRelation then
    self:Refresh(self.curCharId)
    if lastFavourLevel < curLevel and charId == self.curCharId then
      EventManager.Hit(EventId.OpenPanel, PanelId.CharFavourLevelUp, charId, curLevel, lastFavourLevel, curExp, lastExp)
    end
  end
end

return CharacterFavourCtrl
