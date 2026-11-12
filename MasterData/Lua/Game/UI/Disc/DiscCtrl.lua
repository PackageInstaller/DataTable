local DiscCtrl = class("DiscCtrl", BaseCtrl)
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local MoveBarPos = {
  -484.2,
  -159.5,
  161.6,
  484.2
}
local TogAni = {
  [AllEnum.DiscTab.Info] = {
    [AllEnum.DiscTab.Development] = "DiscPanel_Development",
    [AllEnum.DiscTab.BreakLimit] = "DiscPanel_Development",
    [AllEnum.DiscTab.Music] = "DiscPanel_Music"
  },
  [AllEnum.DiscTab.Development] = {
    [AllEnum.DiscTab.Info] = "DiscPanel_in3",
    [AllEnum.DiscTab.BreakLimit] = "DiscPanel_Development1",
    [AllEnum.DiscTab.Music] = "DiscPanel_Music1"
  },
  [AllEnum.DiscTab.BreakLimit] = {
    [AllEnum.DiscTab.Info] = "DiscPanel_in3",
    [AllEnum.DiscTab.Development] = "DiscPanel_Development1",
    [AllEnum.DiscTab.Music] = "DiscPanel_Music1"
  },
  [AllEnum.DiscTab.Music] = {
    [AllEnum.DiscTab.Info] = "DiscPanel_in1",
    [AllEnum.DiscTab.Development] = "DiscPanel_in2",
    [AllEnum.DiscTab.BreakLimit] = "DiscPanel_in2"
  }
}
DiscCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  UIDrag = {
    sComponentName = "UIDrag",
    callback = "OnDrag_Disc"
  },
  imgDiscFrame = {sComponentName = "Image"},
  imgDiscIcon = {sComponentName = "Image"},
  Middle = {
    sNodeName = "---Middle---"
  },
  liveDiscCtrl = {
    sNodeName = "goLiveDisc",
    sCtrlName = "Game.UI.Disc.LiveDiscCtrl"
  },
  FullImage = {
    sNodeName = "----Full----"
  },
  imgFull = {nCount = 2, sComponentName = "Image"},
  rtImgFull2 = {
    sNodeName = "imgFull2",
    sComponentName = "RectTransform"
  },
  imgFullBg = {},
  btnCloseFull = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_CloseFull"
  },
  btnOpenFull2 = {
    sNodeName = "imgDiscFrame",
    sComponentName = "Button",
    callback = "OnBtnClick_OpenFull"
  },
  Development = {
    sNodeName = "---Development---"
  },
  Info = {
    sNodeName = "---Info---",
    sCtrlName = "Game.UI.Disc.DiscInfoCtrl"
  },
  Upgrade = {
    sCtrlName = "Game.UI.Disc.DiscUpgradeCtrl"
  },
  Advance = {
    sCtrlName = "Game.UI.Disc.DiscAdvanceCtrl"
  },
  BreakLimit = {
    sNodeName = "---BreakLimit---",
    sCtrlName = "Game.UI.Disc.DiscBreakLimitCtrl"
  },
  Music = {
    sNodeName = "---Music---",
    sCtrlName = "Game.UI.Disc.DiscMusicCtrl"
  },
  MusicRight = {
    sNodeName = "--MusicRight--"
  },
  cgMiddle = {
    sNodeName = "---Middle---",
    sComponentName = "CanvasGroup"
  },
  cgMusic = {
    sNodeName = "---Music---",
    sComponentName = "CanvasGroup"
  },
  Story = {
    sNodeName = "----Story----",
    sCtrlName = "Game.UI.Disc.DiscStoryCtrl"
  },
  btnTab = {
    nCount = 4,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Tab"
  },
  imgTabOn = {nCount = 4},
  txtTabOn = {nCount = 4, sComponentName = "TMP_Text"},
  txtTabOff = {nCount = 4, sComponentName = "TMP_Text"},
  layoutOff = {nCount = 4},
  reddot = {nCount = 4},
  imgMoveBar = {sComponentName = "Transform"},
  MatList = {
    sCtrlName = "Game.UI.Disc.DiscMatListCtrl"
  },
  btnMask = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Mask"
  },
  aniMatList = {sNodeName = "MatList", sComponentName = "Animator"},
  anibtnMask = {sNodeName = "btnMask", sComponentName = "Animator"},
  aniRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "Animator"
  },
  reddotB = {},
  reddotBreak = {},
  reddotBRead = {},
  reddotBAvg = {},
  btnTabSwitchLeft = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_TabSwitchLeft"
  },
  btnTabSwitchRight = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_TabSwitchRight"
  }
}
DiscCtrl._mapEventConfig = {
  DiscRefresh = "OnEvent_GrowthRefresh",
  DiscOpenMatList = "OnEvent_OpenMatList",
  ClickLiveDisc = "OnEvent_OpenFull",
  Guide_DiscSkill = "OnEvent_Guide_DiscSkill"
}

function DiscCtrl:Refresh()
  self:ClosePopup()
  self:RefreshMiddle()
  self:SwitchTog()
  self:RefreshIndex()
end

function DiscCtrl:ClosePopup()
  self._mapNode.MatList:Open(false)
  self._mapNode.btnMask.gameObject:SetActive(false)
end

function DiscCtrl:RefreshMiddle()
  local mapCfg = ConfigTable.GetData("Disc", self._panel.nId)
  local mapData = PlayerData.Disc:GetDiscById(self._panel.nId)
  if not mapCfg then
    return
  end
  self._mapNode.imgDiscIcon.gameObject:SetActive(false)
  self._mapNode.liveDiscCtrl:SetDiscActive(true, mapCfg.DiscBg ~= "")
  self._mapNode.liveDiscCtrl:SetRawImage(mapCfg.DiscBg, mapData.nRarity)
  if mapCfg.DiscBg ~= "" then
    local bSSR = mapData.nRarity == GameEnum.itemRarity.SSR
    self._mapNode.imgFull[1].gameObject:SetActive(bSSR)
    self._mapNode.imgFull[2].gameObject:SetActive(not bSSR)
    if bSSR then
      self:SetPngSprite(self._mapNode.imgFull[1], mapCfg.DiscBg .. AllEnum.DiscBgSurfix.Image)
    else
      self:SetPngSprite(self._mapNode.imgFull[2], mapCfg.DiscBg .. AllEnum.DiscBgSurfix.Image)
      local nH = Settings.CURRENT_CANVAS_FULL_RECT_HEIGHT
      self._mapNode.rtImgFull2.sizeDelta = Vector2(nH, nH)
    end
  end
end

function DiscCtrl:SwitchTog()
  self._mapNode.TopBar:SetCoinVisible(self._panel.nCurTog == AllEnum.DiscTab.Development)
  local mapData = PlayerData.Disc:GetDiscById(self._panel.nId)
  local bMaxLv = mapData.nLevel == mapData.nMaxLv
  local bAdvance = mapData.nPhase < mapData.nMaxPhase and bMaxLv
  NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.cgMusic, self._panel.nCurTog == AllEnum.DiscTab.Music)
  NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.cgMiddle, self._panel.nCurTog ~= AllEnum.DiscTab.Music)
  self._mapNode.Info.gameObject:SetActive(self._panel.nCurTog == AllEnum.DiscTab.Info)
  self._mapNode.Development:SetActive(self._panel.nCurTog == AllEnum.DiscTab.Development)
  self._mapNode.BreakLimit.gameObject:SetActive(self._panel.nCurTog == AllEnum.DiscTab.BreakLimit)
  self._mapNode.MusicRight:SetActive(self._panel.nCurTog == AllEnum.DiscTab.Music)
  if self._panel.nCurTog == AllEnum.DiscTab.Info then
    self._mapNode.Info:RefreshContent()
  elseif self._panel.nCurTog == AllEnum.DiscTab.Development then
    self._mapNode.Upgrade.gameObject:SetActive(not bAdvance)
    self._mapNode.Advance.gameObject:SetActive(bAdvance)
    if bAdvance then
      self._mapNode.Advance:Refresh()
    else
      self._mapNode.Upgrade:Refresh()
    end
  elseif self._panel.nCurTog == AllEnum.DiscTab.BreakLimit then
    self._mapNode.BreakLimit:Refresh()
  elseif self._panel.nCurTog == AllEnum.DiscTab.Music then
    self._mapNode.Music:Refresh()
  end
end

function DiscCtrl:PlayBGM()
  local mapCfg = ConfigTable.GetData("DiscIP", self._panel.nId)
  if mapCfg == nil then
    return
  end
  local sState = mapCfg.VoFile
  WwiseAudioMgr:SetState_Custom("outfit", sState)
  self._mapNode.Music:InitMusic()
end

function DiscCtrl:QuitBGM()
  if self._panel.bPause and not self._panel.bAvg then
    WwiseAudioMgr:PostEvent("music_outfit_resume")
  end
end

function DiscCtrl:ClosePanel()
  EventManager.Hit(EventId.CloesCurPanel)
end

function DiscCtrl:InitTab()
  if self._panel.nCurTog == nil then
    self._panel.nCurTog = AllEnum.DiscTab.Info
  end
  self._mapNode.imgMoveBar.localPosition = Vector3(MoveBarPos[self._panel.nCurTog], 4.5, 0)
  for i = 1, 4 do
    NovaAPI.SetTMPText(self._mapNode.txtTabOn[i], ConfigTable.GetUIText("Disc_Tab" .. i))
    NovaAPI.SetTMPText(self._mapNode.txtTabOff[i], ConfigTable.GetUIText("Disc_Tab" .. i))
    self._mapNode.imgTabOn[i]:SetActive(self._panel.nCurTog == i)
    self._mapNode.txtTabOn[i].gameObject:SetActive(self._panel.nCurTog == i)
    self._mapNode.layoutOff[i].gameObject:SetActive(self._panel.nCurTog ~= i)
  end
end

function DiscCtrl:RefreshIndex()
  for index, discId in ipairs(self._panel.tbId) do
    if self._panel.nId == discId then
      self.curDiscIndex = index
      break
    end
  end
end

function DiscCtrl:RegisterRedDot()
  RedDotManager.RegisterNode(RedDotDefine.Disc_BreakLimit, self._panel.nId, self._mapNode.reddot[3])
  RedDotManager.RegisterNode(RedDotDefine.Disc_Music, self._panel.nId, self._mapNode.reddot[4])
  RedDotManager.RegisterNode(RedDotDefine.Disc_SideB, self._panel.nId, self._mapNode.reddotB)
  RedDotManager.RegisterNode(RedDotDefine.Disc_BreakBtn, self._panel.nId, self._mapNode.reddotBreak)
  RedDotManager.RegisterNode(RedDotDefine.Disc_SideB_Read, self._panel.nId, self._mapNode.reddotBRead)
  RedDotManager.RegisterNode(RedDotDefine.Disc_SideB_Avg, self._panel.nId, self._mapNode.reddotBAvg)
end

function DiscCtrl:FadeIn()
  if self._panel._nFadeInType == 1 then
    self._mapNode.aniRoot:Play("DiscPanel_in")
  elseif self._panel.nCurTog == AllEnum.DiscTab.Development or self._panel.nCurTog == AllEnum.DiscTab.BreakLimit then
    self._mapNode.aniRoot:Play("DiscPanel_Development", 0, 1)
  elseif self._panel.nCurTog == AllEnum.DiscTab.Music then
    self._mapNode.aniRoot:Play("DiscPanel_Music", 0, 1)
  else
    self._mapNode.aniRoot:Play("DiscPanel_in")
  end
end

function DiscCtrl:Awake()
  self.aniFull = self.gameObject.transform:GetComponent("Animator")
  self.aniFull.enabled = false
  self.nDragStartPosX = nil
  self.nDragThreshold = ConfigTable.GetConfigNumber("DiscDragThreshold")
  self.curDiscIndex = nil
  self:InitTab()
end

function DiscCtrl:OnEnable()
  self:RegisterRedDot()
  self:PlayBGM()
  self:Refresh()
  self.nTabCount = 0
  for k, v in pairs(AllEnum.DiscTab) do
    self.nTabCount = self.nTabCount + 1
  end
end

function DiscCtrl:OnDisable()
  self:QuitBGM()
end

function DiscCtrl:OnDestroy()
end

function DiscCtrl:OnBtnClick_Tab(btn, nIndex)
  if nIndex == self._panel.nCurTog then
    return
  end
  if self._panel.nCurTog == AllEnum.DiscTab.Music then
    self._mapNode.Music:PlayOutMusic()
  end
  local sAni = TogAni[self._panel.nCurTog][nIndex]
  self._mapNode.aniRoot:Play(sAni, 0, 0)
  self._mapNode.imgMoveBar:DOLocalMoveX(MoveBarPos[nIndex], 0.1):SetUpdate(true)
  self._mapNode.imgTabOn[self._panel.nCurTog]:SetActive(false)
  self._mapNode.txtTabOn[self._panel.nCurTog].gameObject:SetActive(false)
  self._mapNode.layoutOff[self._panel.nCurTog].gameObject:SetActive(true)
  self._mapNode.imgTabOn[nIndex]:SetActive(true)
  self._mapNode.txtTabOn[nIndex].gameObject:SetActive(true)
  self._mapNode.layoutOff[nIndex].gameObject:SetActive(false)
  self._panel.nCurTog = nIndex
  self:SwitchTog()
end

function DiscCtrl:OnBtnClick_TabSwitchLeft()
  if #self._panel.tbId <= 1 then
    return
  end
  self.curDiscIndex = self.curDiscIndex - 1
  if 1 > self.curDiscIndex then
    self.curDiscIndex = #self._panel.tbId
  end
  self._panel.nId = self._panel.tbId[self.curDiscIndex]
  self:OnEvent_Drag()
  self._mapNode.Info:RefreshShow()
end

function DiscCtrl:OnBtnClick_TabSwitchRight()
  if #self._panel.tbId <= 1 then
    return
  end
  self.curDiscIndex = self.curDiscIndex + 1
  if self.curDiscIndex > #self._panel.tbId then
    self.curDiscIndex = 1
  end
  self._panel.nId = self._panel.tbId[self.curDiscIndex]
  self:OnEvent_Drag()
  self._mapNode.Info:RefreshShow()
end

function DiscCtrl:OnBtnClick_Mask(btn)
  self._mapNode.anibtnMask:SetTrigger("tOut")
  self._mapNode.aniMatList:Play("MatList_out")
  
  local function ani_end()
    self._mapNode.MatList:Open(false)
    self._mapNode.btnMask.gameObject:SetActive(false)
  end
  
  self:AddTimer(1, 0.2, ani_end, true, true, true)
end

function DiscCtrl:OnBtnClick_OpenFull()
  if self._mapNode.liveDiscCtrl:GetCanOpenFullState() then
    self.aniFull.enabled = true
    self._mapNode.FullImage.gameObject:SetActive(true)
    if self._mapNode.imgFull[2].gameObject.activeSelf then
      self._mapNode.imgFullBg.gameObject:SetActive(true)
    end
    if self._panel.nCurTog == AllEnum.DiscTab.Info then
      self.aniFull:Play("DiscPanel_Full_in", 0, 0)
    elseif self._panel.nCurTog == AllEnum.DiscTab.Development or self._panel.nCurTog == AllEnum.DiscTab.BreakLimit then
      self.aniFull:Play("DiscPanel_Full_in1", 0, 0)
    end
  end
end

function DiscCtrl:OnBtnClick_CloseFull()
  if self._panel.nCurTog == AllEnum.DiscTab.Info then
    self.aniFull:Play("DiscPanel_Full_out")
  elseif self._panel.nCurTog == AllEnum.DiscTab.Development or self._panel.nCurTog == AllEnum.DiscTab.BreakLimit then
    self.aniFull:Play("DiscPanel_Full_out1")
  end
  
  local function ani_end()
    self.aniFull.enabled = false
    self._mapNode.FullImage.gameObject:SetActive(false)
    self._mapNode.imgFullBg.gameObject:SetActive(false)
  end
  
  self:AddTimer(1, 0.4, ani_end, true, true, true)
end

function DiscCtrl:OnDrag_Disc(mDrag)
  if mDrag.DragEventType == AllEnum.UIDragType.DragStart then
    self.nDragStartPosX = mDrag.EventData.position.x
  elseif mDrag.DragEventType == AllEnum.UIDragType.DragEnd then
    local dragEndPosX = mDrag.EventData.position.x
    if dragEndPosX - self.nDragStartPosX > self.nDragThreshold then
      self:OnBtnClick_TabSwitchLeft()
    elseif dragEndPosX - self.nDragStartPosX < -self.nDragThreshold then
      self:OnBtnClick_TabSwitchRight()
    end
  end
end

function DiscCtrl:OnEvent_OpenMatList()
  self._mapNode.btnMask.gameObject:SetActive(true)
  self._mapNode.MatList:Open(true)
end

function DiscCtrl:OnEvent_Drag()
  self:RefreshMiddle()
  self:RegisterRedDot()
  self:PlayBGM()
  local mapData = PlayerData.Disc:GetDiscById(self._panel.nId)
  local bMaxLv = mapData.nLevel == mapData.nMaxLv
  local bAdvance = mapData.nPhase < mapData.nMaxPhase and bMaxLv
  if self._panel.nCurTog == AllEnum.DiscTab.Development then
    self._mapNode.Upgrade.gameObject:SetActive(not bAdvance)
    self._mapNode.Advance.gameObject:SetActive(bAdvance)
    if bAdvance then
      self._mapNode.Advance:Refresh()
    else
      self._mapNode.Upgrade:Refresh()
    end
  elseif self._panel.nCurTog == AllEnum.DiscTab.BreakLimit then
    self._mapNode.BreakLimit:Refresh()
  elseif self._panel.nCurTog == AllEnum.DiscTab.Music then
    self._mapNode.Music:Refresh()
  end
end

function DiscCtrl:OnEvent_OpenFull()
  self:OnBtnClick_OpenFull()
end

function DiscCtrl:OnEvent_Guide_DiscSkill()
  EventManager.Hit("Guide_SelectDisc", self._panel.nId)
end

function DiscCtrl:OnEvent_GrowthRefresh()
  self:ClosePopup()
  self:SwitchTog()
end

return DiscCtrl
