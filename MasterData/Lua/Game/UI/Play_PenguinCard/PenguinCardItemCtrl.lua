local PenguinCardItemCtrl = class("PenguinCardItemCtrl", BaseCtrl)
local WwiseManger = CS.WwiseAudioManager.Instance
local _, NotMaxLevel = ColorUtility.TryParseHtmlString("#FFF7EA")
local _, MaxLevel = ColorUtility.TryParseHtmlString("#ffe075")
local _, NotMaxLevel_Gray = ColorUtility.TryParseHtmlString("#D1C8D0")
local _, MaxLevel_Gray = ColorUtility.TryParseHtmlString("#a78f70")
PenguinCardItemCtrl._mapNodeConfig = {
  AnimRoot = {sComponentName = "Animator"},
  imgBg = {},
  imgIcon = {sComponentName = "Image"},
  txtLevel = {sComponentName = "TMP_Text"},
  txtDisableLevel = {sComponentName = "TMP_Text"},
  txtName = {sComponentName = "TMP_Text"},
  imgUp = {},
  imgHead = {},
  imgHeadIcon = {sComponentName = "Image"},
  txtTrigger = {nCount = 2, sComponentName = "TMP_Text"},
  aniTrigger = {
    sNodeName = "txtTrigger",
    nCount = 2,
    sComponentName = "Animator"
  },
  goTrigger = {},
  goDisable = {},
  imgHighLight = {},
  btnOpenInfo = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_OpenInfo"
  }
}
PenguinCardItemCtrl._mapEventConfig = {
  PenguinCardTriggered = "OnEvent_Triggered",
  PenguinCardWaitPlay = "OnEvent_WaitPlay",
  PenguinCardGrowth = "OnEvent_Growth",
  PenguinCard_AuraTriggered = "OnEvent_AuraTriggered"
}

function PenguinCardItemCtrl:Refresh_Select(mapCard, nSelectIndex, bRoll)
  self.nSelectIndex = nSelectIndex
  self._mapNode.txtLevel.gameObject:SetActive(false)
  self._mapNode.txtName.gameObject:SetActive(true)
  self._mapNode.imgBg:SetActive(bRoll)
  self._mapNode.imgIcon.gameObject:SetActive(true)
  self._mapNode.goTrigger:SetActive(false)
  self._mapNode.goDisable:SetActive(false)
  self._mapNode.imgHighLight:SetActive(false)
  if mapCard.bHighLight then
    self._mapNode.imgHighLight:SetActive(true)
  end
  self:SetSprite(self._mapNode.imgIcon, "UI/Play_PenguinCard/SpriteAtlas/Sprite/" .. mapCard.sIcon)
  NovaAPI.SetTMPText(self._mapNode.txtName, mapCard.sName)
  local bUpgrade = self._panel.mapLevel:CheckUpgradePenguinCard(mapCard)
  self._mapNode.imgUp:SetActive(bUpgrade)
  self._mapNode.imgHead.gameObject:SetActive(false)
  if self._panel.mapLevel.tbAide ~= nil then
    self.nAideIndex = self._panel.mapLevel:CheckAideUpgrade(mapCard.nGroupId)
    self._mapNode.imgHead.gameObject:SetActive(self.nAideIndex ~= nil)
    if self.nAideIndex ~= nil then
      local mapAide = self._panel.mapLevel.tbAide[self.nAideIndex]
      if mapAide ~= 0 then
        self:SetPngSprite(self._mapNode.imgHeadIcon, mapAide.sIcon .. AllEnum.CharHeadIconSurfix.QSS)
      end
    end
  end
  self._mapNode.AnimRoot:Play("PengUinCard_Bd_Shopin", 0, 0)
end

function PenguinCardItemCtrl:Refresh_Slot(mapCard)
  self.nSlotIndex = mapCard.nSlotIndex
  self.nEffectCount = 0
  self.bWaitPlay = false
  local bAble = mapCard:GetActiveState()
  self._mapNode.txtLevel.gameObject:SetActive(bAble)
  self._mapNode.txtName.gameObject:SetActive(false)
  self._mapNode.imgBg:SetActive(false)
  self._mapNode.imgUp:SetActive(false)
  self._mapNode.imgHead.gameObject:SetActive(false)
  self._mapNode.goTrigger:SetActive(false)
  self._mapNode.goDisable:SetActive(not bAble)
  self._mapNode.imgHighLight:SetActive(false)
  self:SetSprite(self._mapNode.imgIcon, "UI/Play_PenguinCard/SpriteAtlas/Sprite/" .. mapCard.sIcon)
  if mapCard.nLevel == mapCard.nMaxLevel then
    NovaAPI.SetTMPColor(self._mapNode.txtLevel, MaxLevel)
    NovaAPI.SetTMPColor(self._mapNode.txtDisableLevel, MaxLevel_Gray)
    NovaAPI.SetTMPText(self._mapNode.txtLevel, orderedFormat(ConfigTable.GetUIText("PenguinCard_CardLevelMax"), mapCard.nLevel))
    NovaAPI.SetTMPText(self._mapNode.txtDisableLevel, orderedFormat(ConfigTable.GetUIText("PenguinCard_CardLevelMax"), mapCard.nLevel))
  else
    NovaAPI.SetTMPColor(self._mapNode.txtLevel, NotMaxLevel)
    NovaAPI.SetTMPColor(self._mapNode.txtDisableLevel, NotMaxLevel_Gray)
    NovaAPI.SetTMPText(self._mapNode.txtLevel, orderedFormat(ConfigTable.GetUIText("PenguinCard_CardLevel"), mapCard.nLevel))
    NovaAPI.SetTMPText(self._mapNode.txtDisableLevel, orderedFormat(ConfigTable.GetUIText("PenguinCard_CardLevel"), mapCard.nLevel))
  end
end

function PenguinCardItemCtrl:RefreshUpgrade(nGroupId)
  if self.nSelectIndex == nil then
    return
  end
  local mapCard = self._panel.mapLevel.tbSelectablePenguinCard[self.nSelectIndex]
  if mapCard.nGroupId == nGroupId then
    self._mapNode.imgUp:SetActive(false)
  end
end

function PenguinCardItemCtrl:RefreshHead(nChangeIndex)
  if self.nAideIndex ~= nil and self.nAideIndex == nChangeIndex then
    self._mapNode.imgHead.gameObject:SetActive(false)
  end
end

function PenguinCardItemCtrl:PlaySlotAni()
  self._mapNode.AnimRoot:Play("PengUinCard_Bd_Slotin", 0, 0)
end

function PenguinCardItemCtrl:PlayFlipAni()
  self._mapNode.imgBg:SetActive(true)
  self._mapNode.txtName.gameObject:SetActive(false)
  self._mapNode.imgHighLight:SetActive(false)
  self._mapNode.imgHead.gameObject:SetActive(false)
  self._mapNode.imgUp:SetActive(false)
  self._mapNode.AnimRoot:Play("PengUinCard_Bd_Shopturn", 0, 0)
  local nAnimTime = NovaAPI.GetAnimClipLength(self._mapNode.AnimRoot, {
    "PengUinCard_Bd_Shopturn"
  })
  self:AddTimer(1, nAnimTime, function()
    self._mapNode.imgIcon.gameObject:SetActive(false)
  end, true, true, true)
end

function PenguinCardItemCtrl:PlayHideAni()
  self._mapNode.AnimRoot:Play("PengUinCard_Bd_Shopout", 0, 0)
end

function PenguinCardItemCtrl:PlaySelectAni(callback)
  self._mapNode.AnimRoot:Play("PengUinCard_Bd_Bdin", 0, 0)
  WwiseManger:PostEvent("Mode_Card_appear")
  local nAnimTime = NovaAPI.GetAnimClipLength(self._mapNode.AnimRoot, {
    "PengUinCard_Bd_Bdin"
  })
  self:AddTimer(1, nAnimTime, function()
    if callback then
      callback()
    end
  end, true, true, true)
end

function PenguinCardItemCtrl:PlayLevelAni(bUp, callback)
  local ani_end = dotween_callback_handler(self, function()
    EventManager.Hit("PenguinCard_Block", false)
  end)
  if self.sequence == nil then
    self.sequence = DOTween.Sequence()
    self.sequence:OnComplete(ani_end)
    EventManager.Hit("PenguinCard_Block", true)
  end
  if self.sequence.active == false then
    self.sequence:Kill(true)
    self.sequence = nil
    self.sequence = DOTween.Sequence()
    self.sequence:OnComplete(ani_end)
    EventManager.Hit("PenguinCard_Block", true)
  end
  if bUp then
    self.sequence:AppendCallback(function()
      self:PlayUpgradeAni(callback)
    end)
    local nAnimTime = NovaAPI.GetAnimClipLength(self._mapNode.AnimRoot, {
      "PengUinCard_Bd_Up"
    })
    self.sequence:AppendInterval(nAnimTime)
  else
    self.sequence:AppendCallback(function()
      self:PlayDownAni(callback)
    end)
    local nAnimTime = NovaAPI.GetAnimClipLength(self._mapNode.AnimRoot, {
      "PengUinCard_Bd_Down"
    })
    self.sequence:AppendInterval(nAnimTime)
  end
end

function PenguinCardItemCtrl:PlayUpgradeAni(callback)
  self._mapNode.AnimRoot:Play("PengUinCard_Bd_Up", 0, 0)
  WwiseManger:PostEvent("Mode_Card_levelup")
  self:AddTimer(1, 0.2, function()
    if callback then
      callback()
    end
  end, true, true, true)
end

function PenguinCardItemCtrl:PlayDownAni(callback)
  self._mapNode.AnimRoot:Play("PengUinCard_Bd_Down", 0, 0)
  WwiseManger:PostEvent("Mode_Card_leveldown")
  self:AddTimer(1, 0.2, function()
    if callback then
      callback()
    end
  end, true, true, true)
end

function PenguinCardItemCtrl:PlaySaleAni(callback)
  self._mapNode.goTrigger:SetActive(false)
  self._mapNode.AnimRoot:Play("PengUinCard_Bd_Bdout", 0, 0)
  WwiseManger:PostEvent("Mode_Card_giveup")
  local nAnimTime = NovaAPI.GetAnimClipLength(self._mapNode.AnimRoot, {
    "PengUinCard_Bd_Bdout"
  })
  self:AddTimer(1, nAnimTime, function()
    if callback then
      callback()
    end
  end, true, true, true)
end

function PenguinCardItemCtrl:PlayTriggerAni()
  if self.bTriggerCd then
    self:PlayEffectAni()
    return
  end
  self.bTriggerCd = true
  local nAnimTime = NovaAPI.GetAnimClipLength(self._mapNode.AnimRoot, {
    "PengUinCard_Bd_Open"
  })
  self:AddTimer(1, nAnimTime, function()
    self.bTriggerCd = false
    self._mapNode.AnimRoot.speed = 1
  end, true, true, true)
  self._mapNode.AnimRoot:Play("PengUinCard_Bd_Open", 0, 0)
  self._mapNode.AnimRoot.speed = self._panel.mapLevel.nSpeed
  WwiseManger:PostEvent("Mode_Card_cast")
  self.nEffectCount = 0
  self:PlayEffectAni()
end

function PenguinCardItemCtrl:PlayEffectAni()
  if self.nSlotIndex == nil then
    return
  end
  local mapCard = self._panel.mapLevel.tbPenguinCard[self.nSlotIndex]
  if self.nEffectCount == nil then
    self.nEffectCount = 0
  end
  local sDesc = ""
  if mapCard.nEffectType == GameEnum.PenguinCardEffectType.IncreaseBasicChips then
    local nValue = mapCard.tbEffectParam[1]
    if mapCard.nGrowthType ~= GameEnum.PenguinCardGrowthType.None then
      nValue = nValue + mapCard.nGrowthLayer * mapCard.tbGrowthEffectParam[1]
    end
    self.nEffectCount = self.nEffectCount + nValue
    sDesc = orderedFormat(ConfigTable.GetUIText("PenguinCard_Trigger_AddScore"), self.nEffectCount)
  elseif mapCard.nEffectType == GameEnum.PenguinCardEffectType.IncreaseMultiplier then
    local nValue = mapCard.tbEffectParam[1]
    if mapCard.nGrowthType ~= GameEnum.PenguinCardGrowthType.None then
      nValue = nValue + mapCard.nGrowthLayer * mapCard.tbGrowthEffectParam[1]
    end
    self.nEffectCount = self.nEffectCount + nValue
    sDesc = orderedFormat(ConfigTable.GetUIText("PenguinCard_Trigger_AddRatio"), self.nEffectCount)
  elseif mapCard.nEffectType == GameEnum.PenguinCardEffectType.MultiMultiplier then
    local nValue = mapCard.tbEffectParam[1]
    if mapCard.nGrowthType ~= GameEnum.PenguinCardGrowthType.None then
      nValue = nValue + mapCard.nGrowthLayer * mapCard.tbGrowthEffectParam[1]
    end
    self.nEffectCount = self.nEffectCount + nValue
    sDesc = orderedFormat(ConfigTable.GetUIText("PenguinCard_Trigger_MultiRatio"), self.nEffectCount)
  end
  self._mapNode.goTrigger:SetActive(sDesc ~= "")
  if mapCard.nEffectType == GameEnum.PenguinCardEffectType.IncreaseBasicChips then
    self._mapNode.txtTrigger[1].gameObject:SetActive(false)
    self._mapNode.txtTrigger[2].gameObject:SetActive(true)
    NovaAPI.SetTMPText(self._mapNode.txtTrigger[2], sDesc)
    self._mapNode.aniTrigger[2]:Play("PengUinCard_Bd_Trigger_in", 0, 0)
    self._mapNode.aniTrigger[2].speed = self._panel.mapLevel.nSpeed
  elseif mapCard.nEffectType == GameEnum.PenguinCardEffectType.IncreaseMultiplier or mapCard.nEffectType == GameEnum.PenguinCardEffectType.MultiMultiplier then
    self._mapNode.txtTrigger[1].gameObject:SetActive(true)
    self._mapNode.txtTrigger[2].gameObject:SetActive(false)
    NovaAPI.SetTMPText(self._mapNode.txtTrigger[1], sDesc)
    self._mapNode.aniTrigger[1]:Play("PengUinCard_Bd_Trigger_in", 0, 0)
    self._mapNode.aniTrigger[1].speed = self._panel.mapLevel.nSpeed
  end
end

function PenguinCardItemCtrl:Awake()
end

function PenguinCardItemCtrl:OnEnable()
end

function PenguinCardItemCtrl:OnDisable()
  if self.sequence ~= nil then
    if self.sequence.active then
      self.sequence:Kill(true)
    end
    self.sequence = nil
  end
end

function PenguinCardItemCtrl:OnBtnClick_OpenInfo()
  if self.nSelectIndex and not self._panel.mapLevel.bSelectedPenguinCard then
    local mapCard = self._panel.mapLevel.tbSelectablePenguinCard[self.nSelectIndex]
    EventManager.Hit("PenguinCard_OpenInfo", mapCard, self.nSelectIndex)
  elseif self.nSlotIndex then
    local mapCard = self._panel.mapLevel.tbPenguinCard[self.nSlotIndex]
    EventManager.Hit("PenguinCard_OpenInfo", mapCard)
  end
end

function PenguinCardItemCtrl:OnEvent_Triggered(nSlotIndex)
  if self.nSlotIndex == nil then
    return
  end
  local mapCard = self._panel.mapLevel.tbPenguinCard[self.nSlotIndex]
  if mapCard == 0 or nSlotIndex ~= mapCard.nSlotIndex then
    return
  end
  if mapCard.nTriggerPhase == GameEnum.PenguinCardTriggerPhase.Aura then
    return
  end
  if mapCard.nTriggerPhase == GameEnum.PenguinCardTriggerPhase.Settlement then
    self.bWaitPlay = true
    return
  end
  self:PlayTriggerAni()
end

function PenguinCardItemCtrl:OnEvent_AuraTriggered()
  if self.nSlotIndex == nil then
    return
  end
  local mapCard = self._panel.mapLevel.tbPenguinCard[self.nSlotIndex]
  if mapCard == 0 then
    return
  end
  if mapCard.nTriggerPhase ~= GameEnum.PenguinCardTriggerPhase.Aura then
    return
  end
  self:PlayTriggerAni()
end

function PenguinCardItemCtrl:OnEvent_Growth(nSlotIndex)
  if self.nSlotIndex == nil then
    return
  end
  local mapCard = self._panel.mapLevel.tbPenguinCard[self.nSlotIndex]
  if mapCard == 0 or nSlotIndex ~= mapCard.nSlotIndex then
    return
  end
  local bAble = mapCard:GetActiveState()
  self._mapNode.goDisable:SetActive(not bAble)
  self._mapNode.txtLevel.gameObject:SetActive(bAble)
end

function PenguinCardItemCtrl:OnEvent_WaitPlay()
  if self.bWaitPlay == true then
    self.bWaitPlay = false
    self:PlayTriggerAni()
  end
end

return PenguinCardItemCtrl
