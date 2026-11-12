local PenguinCardInfoCtrl = class("PenguinCardInfoCtrl", BaseCtrl)
local PenguinCardUtils = require("Game.UI.Play_PenguinCard.PenguinCardUtils")
local _, NotMaxLevel = ColorUtility.TryParseHtmlString("#FFF7EA")
local _, MaxLevel = ColorUtility.TryParseHtmlString("#ffe075")
PenguinCardInfoCtrl._mapNodeConfig = {
  blur = {
    sNodeName = "t_fullscreen_blur_blue"
  },
  aniBlur = {
    sNodeName = "t_fullscreen_blur_blue",
    sComponentName = "Animator"
  },
  goInfo = {},
  imgIcon = {sComponentName = "Image"},
  txtLevel = {sComponentName = "TMP_Text"},
  txtName = {sComponentName = "TMP_Text"},
  imgUp = {},
  txtDesc = {sComponentName = "TMP_Text"},
  srDesc = {sComponentName = "ScrollRect"},
  aniInfo = {sNodeName = "goInfo", sComponentName = "Animator"},
  btnRight = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Right"
  },
  btnLeft = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Left"
  },
  btnSale = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Sale"
  },
  btnBack = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Back"
  },
  txtBtnBack = {
    sComponentName = "TMP_Text",
    sLanguageId = "PenguinCard_Btn_Back"
  },
  btnSelect = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Select"
  },
  txtBtnSelect = {sComponentName = "TMP_Text"}
}
PenguinCardInfoCtrl._mapEventConfig = {
  PenguinCard_OpenInfo = "Open",
  PenguinCard_SelectPenguinCard = "OnEvent_Select",
  PenguinCard_SalePenguinCard = "OnEvent_Sale"
}

function PenguinCardInfoCtrl:Open(mapCard, nSelectIndex)
  self._panel.mapLevel:Pause()
  self.mapCard = clone(mapCard)
  self.bSelect = nSelectIndex ~= nil
  self.nSelectIndex = nSelectIndex
  if self.bSelect then
    local nMax = #self._panel.mapLevel.tbSelectablePenguinCard
    self._mapNode.btnRight.gameObject:SetActive(1 < nMax)
    self._mapNode.btnLeft.gameObject:SetActive(1 < nMax)
    self._mapNode.btnSale.gameObject:SetActive(false)
    self._mapNode.btnSelect.gameObject:SetActive(true)
    self._mapNode.imgUp:SetActive(false)
  else
    self.tbHasIndex = {}
    for i = 1, 6 do
      if self._panel.mapLevel.tbPenguinCard[i] ~= 0 then
        table.insert(self.tbHasIndex, i)
      end
    end
    local nMax = #self.tbHasIndex
    self._mapNode.btnRight.gameObject:SetActive(1 < nMax)
    self._mapNode.btnLeft.gameObject:SetActive(1 < nMax)
    self._mapNode.btnSale.gameObject:SetActive(self._panel.mapLevel.nGameState == PenguinCardUtils.GameState.Prepare)
    self._mapNode.btnSelect.gameObject:SetActive(false)
    self._mapNode.imgUp:SetActive(false)
  end
  self:PlayInAni()
  self:Refresh()
end

function PenguinCardInfoCtrl:Refresh()
  NovaAPI.SetTMPText(self._mapNode.txtName, self.mapCard.sName)
  self:SetSprite(self._mapNode.imgIcon, "UI/Play_PenguinCard/SpriteAtlas/Sprite/" .. self.mapCard.sIcon)
  if self.bSelect then
    local mapSelectCard = self._panel.mapLevel.tbSelectablePenguinCard[self.nSelectIndex]
    local bUpgrade, nAimIndex = self._panel.mapLevel:CheckUpgradePenguinCard(mapSelectCard)
    if bUpgrade then
      self._mapNode.imgUp:SetActive(true)
      local mapUpgradeCard = self._panel.mapLevel.tbPenguinCard[nAimIndex]
      local nAfter = mapUpgradeCard.nLevel + mapSelectCard.nLevel
      nAfter = nAfter > mapUpgradeCard.nMaxLevel and mapUpgradeCard.nMaxLevel or nAfter
      NovaAPI.SetTMPText(self._mapNode.txtLevel, orderedFormat(ConfigTable.GetUIText(nAfter == mapUpgradeCard.nMaxLevel and "PenguinCard_CardLevelMax" or "PenguinCard_CardLevel"), nAfter))
      NovaAPI.SetTMPColor(self._mapNode.txtLevel, nAfter == mapUpgradeCard.nMaxLevel and MaxLevel or NotMaxLevel)
      local nId = mapUpgradeCard:GetIdByLevel(mapUpgradeCard.nGroupId, nAfter)
      local mapCfg = ConfigTable.GetData("PenguinCard", nId)
      if mapCfg then
        local sDesc = ""
        if mapCfg.UpgradeResetGrowth then
          sDesc = PenguinCardUtils.SetEffectDesc(mapCfg)
        else
          sDesc = PenguinCardUtils.SetEffectDesc(mapCfg, mapUpgradeCard.nGrowthLayer)
        end
        NovaAPI.SetTMPText(self._mapNode.txtDesc, sDesc)
      end
      NovaAPI.SetTMPText(self._mapNode.txtBtnSelect, ConfigTable.GetUIText("PenguinCard_Btn_Upgrade"))
    else
      self._mapNode.imgUp:SetActive(false)
      NovaAPI.SetTMPText(self._mapNode.txtLevel, orderedFormat(ConfigTable.GetUIText(self.mapCard.nLevel == self.mapCard.nMaxLevel and "PenguinCard_CardLevelMax" or "PenguinCard_CardLevel"), self.mapCard.nLevel))
      NovaAPI.SetTMPColor(self._mapNode.txtLevel, self.mapCard.nLevel == self.mapCard.nMaxLevel and MaxLevel or NotMaxLevel)
      NovaAPI.SetTMPText(self._mapNode.txtDesc, self.mapCard:GetDesc())
      NovaAPI.SetTMPText(self._mapNode.txtBtnSelect, ConfigTable.GetUIText("PenguinCard_Btn_Select"))
    end
  else
    NovaAPI.SetTMPText(self._mapNode.txtLevel, orderedFormat(ConfigTable.GetUIText(self.mapCard.nLevel == self.mapCard.nMaxLevel and "PenguinCard_CardLevelMax" or "PenguinCard_CardLevel"), self.mapCard.nLevel))
    NovaAPI.SetTMPColor(self._mapNode.txtLevel, self.mapCard.nLevel == self.mapCard.nMaxLevel and MaxLevel or NotMaxLevel)
    NovaAPI.SetTMPText(self._mapNode.txtDesc, self.mapCard:GetDesc())
  end
  NovaAPI.SetVerticalNormalizedPosition(self._mapNode.srDesc, 1)
end

function PenguinCardInfoCtrl:PlayInAni()
  self.gameObject:SetActive(true)
  self._mapNode.blur:SetActive(true)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.goInfo:SetActive(true)
  end
  
  cs_coroutine.start(wait)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function PenguinCardInfoCtrl:Close(bBuy)
  self.animator:Play("PengUinCard_CardInfo_out")
  if bBuy == true then
    self._mapNode.aniInfo:Play("PengUinCard_CardInfo_Card_Give", 0, 0)
  else
    self._mapNode.aniInfo:Play("PengUinCard_CardInfo_Card_out", 0, 0)
  end
  self._mapNode.aniBlur:SetTrigger("tOut")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.4)
  self:AddTimer(1, 0.4, function()
    self._mapNode.goInfo:SetActive(false)
    self.gameObject:SetActive(false)
    self._panel.mapLevel:Resume()
  end, true, true, true)
end

function PenguinCardInfoCtrl:Awake()
  self._mapNode.goInfo:SetActive(false)
  self.animator = self.gameObject:GetComponent("Animator")
end

function PenguinCardInfoCtrl:OnEnable()
end

function PenguinCardInfoCtrl:OnDisable()
end

function PenguinCardInfoCtrl:OnBtnClick_Right()
  local function switch(callback)
    self._mapNode.aniInfo:Play("PengUinCard_CardInfo_Card_out_l", 0, 0)
    
    local nAnimTime = NovaAPI.GetAnimClipLength(self._mapNode.aniInfo, {
      "PengUinCard_CardInfo_Card_out_l"
    })
    self:AddTimer(1, nAnimTime, function()
      callback()
      self._mapNode.aniInfo:Play("PengUinCard_CardInfo_Card_in_r", 0, 0)
    end, true, true, true)
  end
  
  if self.bSelect then
    local function callback()
      local nMax = #self._panel.mapLevel.tbSelectablePenguinCard
      
      if nMax > self.nSelectIndex then
        self.nSelectIndex = self.nSelectIndex + 1
      else
        self.nSelectIndex = 1
      end
      self.mapCard = clone(self._panel.mapLevel.tbSelectablePenguinCard[self.nSelectIndex])
      self:Refresh()
    end
    
    switch(callback)
  else
    local function callback()
      local nMax = #self.tbHasIndex
      
      local nIndex = table.indexof(self.tbHasIndex, self.mapCard.nSlotIndex)
      if nMax > nIndex then
        nIndex = nIndex + 1
      else
        nIndex = 1
      end
      if self._panel.mapLevel.tbPenguinCard[self.tbHasIndex[nIndex]] == 0 then
        return
      end
      self.mapCard = clone(self._panel.mapLevel.tbPenguinCard[self.tbHasIndex[nIndex]])
      self:Refresh()
    end
    
    switch(callback)
  end
end

function PenguinCardInfoCtrl:OnBtnClick_Left()
  local function switch(callback)
    self._mapNode.aniInfo:Play("PengUinCard_CardInfo_Card_out_r", 0, 0)
    
    local nAnimTime = NovaAPI.GetAnimClipLength(self._mapNode.aniInfo, {
      "PengUinCard_CardInfo_Card_out_r"
    })
    self:AddTimer(1, nAnimTime, function()
      callback()
      self._mapNode.aniInfo:Play("PengUinCard_CardInfo_Card_in_l", 0, 0)
    end, true, true, true)
  end
  
  if self.bSelect then
    local function callback()
      local nMax = #self._panel.mapLevel.tbSelectablePenguinCard
      
      if self.nSelectIndex > 1 then
        self.nSelectIndex = self.nSelectIndex - 1
      else
        self.nSelectIndex = nMax
      end
      self.mapCard = clone(self._panel.mapLevel.tbSelectablePenguinCard[self.nSelectIndex])
      self:Refresh()
    end
    
    switch(callback)
  else
    local function callback()
      local nMax = #self.tbHasIndex
      
      local nIndex = table.indexof(self.tbHasIndex, self.mapCard.nSlotIndex)
      if 1 < nIndex then
        nIndex = nIndex - 1
      else
        nIndex = nMax
      end
      if self._panel.mapLevel.tbPenguinCard[self.tbHasIndex[nIndex]] == 0 then
        return
      end
      self.mapCard = clone(self._panel.mapLevel.tbPenguinCard[self.tbHasIndex[nIndex]])
      self:Refresh()
    end
    
    switch(callback)
  end
end

function PenguinCardInfoCtrl:OnBtnClick_Sale()
  if not self.mapCard.nSlotIndex then
    return
  end
  self._panel.mapLevel:SalePenguinCard(self.mapCard.nSlotIndex)
end

function PenguinCardInfoCtrl:OnBtnClick_Back()
  self:Close()
  EventManager.Hit("PenguinCard_CloseCardInfo")
end

function PenguinCardInfoCtrl:OnBtnClick_Select()
  if not self.nSelectIndex then
    return
  end
  self._panel.mapLevel:SelectPenguinCard(self.nSelectIndex)
end

function PenguinCardInfoCtrl:OnEvent_Select()
  self:Close(true)
end

function PenguinCardInfoCtrl:OnEvent_Sale()
  self:Close(false)
end

return PenguinCardInfoCtrl
