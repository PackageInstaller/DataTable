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
  txtTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "PenguinCard_AideInfo_Title"
  },
  goInfo = {},
  aniInfo = {sNodeName = "goInfo", sComponentName = "Animator"},
  imgIcon = {sComponentName = "Image"},
  txtLevel = {sComponentName = "TMP_Text"},
  txtName = {sComponentName = "TMP_Text"},
  txtPassive = {
    sComponentName = "TMP_Text",
    sLanguageId = "PenguinCard_AideInfo_Passive"
  },
  txtSkill = {
    sComponentName = "TMP_Text",
    sLanguageId = "PenguinCard_AideInfo_Skill"
  },
  txtFavorite = {
    sComponentName = "TMP_Text",
    sLanguageId = "PenguinCard_AideInfo_Favorite"
  },
  txtDesc = {nCount = 3, sComponentName = "TMP_Text"},
  srDesc = {sComponentName = "ScrollRect"},
  goCard = {nCount = 2},
  goCardOff = {nCount = 2},
  goCardOn = {nCount = 2},
  imgCardIconOff = {nCount = 2, sComponentName = "Image"},
  imgCardIconOn = {nCount = 2, sComponentName = "Image"},
  txtCardNameOff = {nCount = 2, sComponentName = "TMP_Text"},
  txtCardNameOn = {nCount = 2, sComponentName = "TMP_Text"},
  imgProcessBarFill = {
    nCount = 2,
    sComponentName = "RectTransform"
  },
  imgBarBg = {
    nCount = 2,
    sComponentName = "RectTransform"
  },
  txtProcess = {nCount = 2, sComponentName = "TMP_Text"},
  txtCardAdd = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "PenguinCard_AideInfo_LevelUpDesc"
  },
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
  txtBtnSelect = {
    sComponentName = "TMP_Text",
    sLanguageId = "PenguinCard_Btn_SelectAide"
  }
}
PenguinCardInfoCtrl._mapEventConfig = {
  PenguinCard_OpenAideInfo = "Open",
  PenguinCard_SelectAide = "OnEvent_Select",
  PenguinCard_SaleAide = "OnEvent_Sale"
}

function PenguinCardInfoCtrl:Open(mapAide, nSelectIndex)
  self._panel.mapLevel:Pause()
  self.mapAide = mapAide
  self.bSelect = nSelectIndex ~= nil
  self.nSelectIndex = nSelectIndex
  if self.bSelect then
    local nMax = #self._panel.mapLevel.tbSelectableAide
    self._mapNode.btnRight.gameObject:SetActive(1 < nMax)
    self._mapNode.btnLeft.gameObject:SetActive(1 < nMax)
    self._mapNode.btnSale.gameObject:SetActive(false)
    self._mapNode.btnSelect.gameObject:SetActive(true)
  else
    self.tbHasIndex = {}
    for i = 1, 3 do
      if self._panel.mapLevel.tbAide[i] ~= 0 then
        table.insert(self.tbHasIndex, i)
      end
    end
    local nMax = #self.tbHasIndex
    self._mapNode.btnRight.gameObject:SetActive(1 < nMax)
    self._mapNode.btnLeft.gameObject:SetActive(1 < nMax)
    self._mapNode.btnSale.gameObject:SetActive(self._panel.mapLevel.nGameState == PenguinCardUtils.GameState.Prepare)
    self._mapNode.btnSelect.gameObject:SetActive(false)
  end
  self:PlayInAni()
  self:Refresh()
end

function PenguinCardInfoCtrl:Refresh()
  self:SetPngSprite(self._mapNode.imgIcon, self.mapAide.sIcon .. AllEnum.CharHeadIconSurfix.Q)
  NovaAPI.SetTMPText(self._mapNode.txtName, self.mapAide.sName)
  if self.mapAide.nLevel == self.mapAide.nMaxLevel then
    NovaAPI.SetTMPColor(self._mapNode.txtLevel, MaxLevel)
    NovaAPI.SetTMPText(self._mapNode.txtLevel, orderedFormat(ConfigTable.GetUIText("PenguinCard_AideLevel"), self.mapAide.nLevel))
  else
    NovaAPI.SetTMPColor(self._mapNode.txtLevel, NotMaxLevel)
    NovaAPI.SetTMPText(self._mapNode.txtLevel, orderedFormat(ConfigTable.GetUIText("PenguinCard_AideLevel"), self.mapAide.nLevel))
  end
  NovaAPI.SetTMPText(self._mapNode.txtDesc[1], PenguinCardUtils.SetAideAddScoreDesc(self.mapAide.tbScore, self.mapAide.nLevel))
  NovaAPI.SetTMPText(self._mapNode.txtDesc[2], self.mapAide:GetDesc())
  NovaAPI.SetTMPText(self._mapNode.txtDesc[3], ConfigTable.GetUIText("PenguinCard_AideInfo_FavoriteDesc"))
  for i = 1, 2 do
    local nGroupId = self.mapAide.tbUpgradeGroupId[i]
    if nGroupId ~= nil and nGroupId ~= 0 then
      self._mapNode.goCard[i]:SetActive(true)
      self:RefreshCard(i, nGroupId)
    else
      self._mapNode.goCard[i]:SetActive(false)
    end
  end
  NovaAPI.SetVerticalNormalizedPosition(self._mapNode.srDesc, 1)
end

function PenguinCardInfoCtrl:RefreshCard(nIndex, nGroupId)
  local nCardId = nGroupId * 100 + 1
  local mapCfg = ConfigTable.GetData("PenguinCard", nCardId)
  if not mapCfg then
    return
  end
  local nHas = self.mapAide.mapUpgradeCount[tostring(nGroupId)]
  local nNeed = self.mapAide.mapUpgradeNeed[nGroupId]
  local bMax = nHas >= nNeed
  self._mapNode.goCardOn[nIndex]:SetActive(bMax)
  self._mapNode.goCardOff[nIndex]:SetActive(not bMax)
  if bMax then
    self:SetSprite(self._mapNode.imgCardIconOn[nIndex], "UI/Play_PenguinCard/SpriteAtlas/Sprite/" .. mapCfg.Icon)
    NovaAPI.SetTMPText(self._mapNode.txtCardNameOn[nIndex], mapCfg.Title)
  else
    self:SetSprite(self._mapNode.imgCardIconOff[nIndex], "UI/Play_PenguinCard/SpriteAtlas/Sprite/" .. mapCfg.Icon)
    NovaAPI.SetTMPText(self._mapNode.txtCardNameOff[nIndex], mapCfg.Title)
    NovaAPI.SetTMPText(self._mapNode.txtProcess[nIndex], string.format("%d/%d", nHas, nNeed))
    local nWidth = self._mapNode.imgBarBg[nIndex].rect.width
    self._mapNode.imgProcessBarFill[nIndex].sizeDelta = Vector2(nHas / nNeed * nWidth, 28)
  end
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
  self._mapNode.aniInfo:Play("PenguinCard_AideInfo_out", 0, 0)
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
    self._mapNode.aniInfo:Play("PenguinCard_AideInfo_out_L", 0, 0)
    
    local nAnimTime = NovaAPI.GetAnimClipLength(self._mapNode.aniInfo, {
      "PenguinCard_AideInfo_out_L"
    })
    self:AddTimer(1, nAnimTime, function()
      callback()
      self._mapNode.aniInfo:Play("PenguinCard_AideInfo_in_R", 0, 0)
    end, true, true, true)
  end
  
  if self.bSelect then
    local function callback()
      local nMax = #self._panel.mapLevel.tbSelectableAide
      
      if nMax > self.nSelectIndex then
        self.nSelectIndex = self.nSelectIndex + 1
      else
        self.nSelectIndex = 1
      end
      self.mapAide = self._panel.mapLevel.tbSelectableAide[self.nSelectIndex]
      self:Refresh()
    end
    
    switch(callback)
  else
    local function callback()
      local nMax = #self.tbHasIndex
      
      local nIndex = table.indexof(self.tbHasIndex, self.mapAide.nSlotIndex)
      if nMax > nIndex then
        nIndex = nIndex + 1
      else
        nIndex = 1
      end
      if self._panel.mapLevel.tbAide[self.tbHasIndex[nIndex]] == 0 then
        return
      end
      self.mapAide = self._panel.mapLevel.tbAide[self.tbHasIndex[nIndex]]
      self:Refresh()
    end
    
    switch(callback)
  end
end

function PenguinCardInfoCtrl:OnBtnClick_Left()
  local function switch(callback)
    self._mapNode.aniInfo:Play("PenguinCard_AideInfo_out_R", 0, 0)
    
    local nAnimTime = NovaAPI.GetAnimClipLength(self._mapNode.aniInfo, {
      "PenguinCard_AideInfo_out_R"
    })
    self:AddTimer(1, nAnimTime, function()
      callback()
      self._mapNode.aniInfo:Play("PenguinCard_AideInfo_in_L", 0, 0)
    end, true, true, true)
  end
  
  if self.bSelect then
    local function callback()
      local nMax = #self._panel.mapLevel.tbSelectableAide
      
      if self.nSelectIndex > 1 then
        self.nSelectIndex = self.nSelectIndex - 1
      else
        self.nSelectIndex = nMax
      end
      self.mapAide = self._panel.mapLevel.tbSelectableAide[self.nSelectIndex]
      self:Refresh()
    end
    
    switch(callback)
  else
    local function callback()
      local nMax = #self.tbHasIndex
      
      local nIndex = table.indexof(self.tbHasIndex, self.mapAide.nSlotIndex)
      if 1 < nIndex then
        nIndex = nIndex - 1
      else
        nIndex = nMax
      end
      if self._panel.mapLevel.tbAide[self.tbHasIndex[nIndex]] == 0 then
        return
      end
      self.mapAide = self._panel.mapLevel.tbAide[self.tbHasIndex[nIndex]]
      self:Refresh()
    end
    
    switch(callback)
  end
end

function PenguinCardInfoCtrl:OnBtnClick_Sale()
  if not self.mapAide.nSlotIndex then
    return
  end
  self._panel.mapLevel:SaleAide(self.mapAide.nSlotIndex)
end

function PenguinCardInfoCtrl:OnBtnClick_Back()
  self:Close()
end

function PenguinCardInfoCtrl:OnBtnClick_Select()
  if not self.nSelectIndex then
    return
  end
  self._panel.mapLevel:SelectAide(self.nSelectIndex)
end

function PenguinCardInfoCtrl:OnEvent_Select()
  self:Close(true)
end

function PenguinCardInfoCtrl:OnEvent_Sale()
  self:Close(false)
end

return PenguinCardInfoCtrl
