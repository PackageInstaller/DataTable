_class("UIAlbumController", UIController)
UIAlbumController = UIAlbumController
local alog

function UIAlbumController:OnShow(uiParams)
  self._isHomeland = uiParams[1] or false
  
  function alog(...)
    Log.debug("[Album] ", ...)
  end
  
  self:InitWidget()
  self._development = EngineGameHelper.IsDevelopmentBuild()
  self._development = false
  self.topButtonWidget = self.topButtons:SpawnObject("UICommonTopButton")
  self.topButtonWidget:SetData(function()
    self:CloseDialog()
  end, nil, nil, self._isHomeland)
  self._roleModule = self:GetModule(RoleModule)
  local allCfg = Cfg.cfg_role_music({})
  local musics = {
    {},
    {},
    {},
    {},
    {}
  }
  local counts = {
    {0, 0},
    {0, 0},
    {0, 0},
    {0, 0},
    {0, 0}
  }
  local lockInfo = {}
  for _, cfg in pairs(allCfg) do
    local show = self._roleModule:UI_CheckMusicShow(cfg)
    if show then
      local lock = self._roleModule:UI_CheckMusicLock(cfg)
      table.insert(musics[cfg.Tag], cfg)
      counts[cfg.Tag][1] = counts[cfg.Tag][1] + 1
      if not lock then
        counts[cfg.Tag][2] = counts[cfg.Tag][2] + 1
      end
      lockInfo[cfg.ID] = lock
    end
  end
  self.tab1Count:SetText(counts[1][2] .. "/" .. counts[1][1])
  self.tab2Count:SetText(counts[2][2] .. "/" .. counts[2][1])
  self.tab3Count:SetText(counts[3][2] .. "/" .. counts[3][1])
  self.tab4Count:SetText(counts[4][2] .. "/" .. counts[4][1])
  self.tab5Count:SetText(counts[5][2] .. "/" .. counts[5][1])
  
  function self._isLock(id)
    return lockInfo[id]
  end
  
  local function sorter(a, b)
    if self._isLock(a.ID) == self._isLock(b.ID) then
      return a.ID < b.ID
    else
      return not self._isLock(a.ID)
    end
  end
  
  table.sort(musics[1], sorter)
  table.sort(musics[2], sorter)
  table.sort(musics[3], sorter)
  table.sort(musics[4], sorter)
  table.sort(musics[5], sorter)
  if #musics[4] == 0 then
    self._tabBtns[4].gameObject:SetActive(false)
  end
  if #musics[5] == 0 then
    self._tabBtns[5].gameObject:SetActive(false)
  end
  self._music = musics
  self._curMainMusic = self._roleModule:UI_GetMusic(EnumBgmType.E_Bgm_Main)
  self._curAircraftMusic = self._roleModule:UI_GetMusic(EnumBgmType.E_Bgm_AirCraft)
  self._curHomelandMusic = self._roleModule:UI_GetMusic(EnumBgmType.E_Bgm_Homeland)
  local playing = AudioHelperController.GetCurrentBgm()
  local cfgs = Cfg.cfg_role_music({AudioID = playing})
  local curMainID = -1
  if cfgs and next(cfgs) then
    curMainID = cfgs[1].ID
  end
  if Cfg.cfg_role_music[curMainID].AudioID ~= playing then
    Log.exception("当前的背景音不正确：", playing, "，应该播放：", curMainID)
  end
  
  local function onClickItem(idx)
    self:onClickItem(idx)
  end
  
  local function getItem(scrollView, index)
    if index < 0 then
      return nil
    end
    local item = scrollView:NewListViewItem("item")
    local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
    local m = rowPool:SpawnObject("UIAlbumItem")
    local cfg = self._music[self._curTab][index + 1]
    m:SetData(cfg, index + 1, self._isLock(cfg.ID), onClickItem, self._curSelectCfgID == cfg.ID, self._curPlaying == cfg.ID, self._isPause)
    return item
  end
  
  self.scrollList:InitListView(0, getItem)
  self._curPlaying = curMainID
  self._isPause = false
  self._curSelectCfgID = nil
  self._curTab = nil
  self._curPlayingTab = Cfg.cfg_role_music[self._curPlaying].Tag
  self:changeTab(1)
  for idx, cfg in ipairs(self._music[self._curPlayingTab]) do
    if cfg.ID == curMainID then
      self._curPlayingIndex = idx
      break
    end
  end
  self:refreshBtmBar(Cfg.cfg_role_music[self._curPlaying])
  self:refreshSetBtn()
  self:_RefreshSetBtnVisible()
  self:_ChangeBlurBgBegin(Cfg.cfg_role_music[self._curPlaying].Icon)
  self._timerEvent = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    self:musicTimeTick()
  end)
end

function UIAlbumController:OnHide()
  GameGlobal.Timer():CancelEvent(self._timerEvent)
  if self._isHomeland then
    if self._curHomelandMusic ~= self._curPlaying then
      local cfg
      if self._curHomelandMusic <= 0 then
        cfg = Cfg.cfg_role_music[CriAudioIDConst.BGMEnterHomeland]
      else
        cfg = Cfg.cfg_role_music[self._curHomelandMusic]
      end
      AudioHelperController.PlayBGM(cfg.AudioID)
    end
  elseif self._curMainMusic ~= self._curPlaying then
    local cfg
    if 0 >= self._curMainMusic then
      cfg = Cfg.cfg_role_music[UIBgmHelper.GetDefaultBgm(EnumBgmType.E_Bgm_Main)]
    else
      cfg = Cfg.cfg_role_music[self._curMainMusic]
    end
    AudioHelperController.PlayBGM(cfg.AudioID)
  end
  alog = nil
end

function UIAlbumController:InitWidget()
  self.topButtons = self:GetUIComponent("UISelectObjectPath", "TopButtons")
  self.tab1Count = self:GetUIComponent("UILocalizationText", "Tab1Count")
  self.tab2Count = self:GetUIComponent("UILocalizationText", "Tab2Count")
  self.tab3Count = self:GetUIComponent("UILocalizationText", "Tab3Count")
  self.cover = self:GetUIComponent("RawImageLoader", "cover")
  self.scrollList = self:GetUIComponent("UIDynamicScrollView", "ScrollList")
  self.progress = self:GetUIComponent("Image", "progress")
  self.time = self:GetUIComponent("UILocalizationText", "time")
  self.cover_small = self:GetUIComponent("RawImageLoader", "cover_small")
  self.pauseBtn = self:GetGameObject("PauseBtn")
  self.resumeBtn = self:GetGameObject("ResumeBtn")
  self.nameText = self:GetUIComponent("RollingText", "nameText")
  self.authorText = self:GetUIComponent("RollingText", "authorText")
  self.mainMusicText = self:GetUIComponent("RollingText", "MainMusicText")
  self.aircraftMusicText = self:GetUIComponent("RollingText", "AircraftMusicText")
  self.homelandMusicText = self:GetUIComponent("RollingText", "HomelandMusicText")
  self.tab4Count = self:GetUIComponent("UILocalizationText", "Tab4Count")
  self.tab5Count = self:GetUIComponent("UILocalizationText", "Tab5Count")
  self._tabBtns = {
    self:GetUIComponent("Button", "Tab1"),
    self:GetUIComponent("Button", "Tab2"),
    self:GetUIComponent("Button", "Tab3"),
    self:GetUIComponent("Button", "Tab4"),
    self:GetUIComponent("Button", "Tab5")
  }
  self._tabTexts = {
    self.tab1Count,
    self.tab2Count,
    self.tab3Count,
    self.tab4Count,
    self.tab5Count
  }
  self._blurBg = self:GetUIComponent("RawImageLoader", "blurBg")
  self._blurBgNew = self:GetUIComponent("RawImageLoader", "blurBgNew")
  self._blurBgNewImg = self:GetUIComponent("RawImage", "blurBgNew")
  self._anim = self:GetUIComponent("Animation", "UIAlbum")
  self._setBtns = {}
  self._setBtns[EnumBgmType.E_Bgm_Main] = self:GetGameObject("SetMain")
  self._setBtns[EnumBgmType.E_Bgm_AirCraft] = self:GetGameObject("SetAircraft")
  self._setBtns[EnumBgmType.E_Bgm_Homeland] = self:GetGameObject("SetHomeland")
end

function UIAlbumController:changeTab(tab)
  if self._curTab == tab then
    return
  end
  if self._curTab then
    self._tabBtns[self._curTab].interactable = true
    self._tabTexts[self._curTab].color = Color(0.8509803921568627, 0.8509803921568627, 0.8509803921568627)
    self._anim:Play("uieff_Album_Switch")
  end
  self._curTab = tab
  self._tabBtns[self._curTab].interactable = false
  self._tabTexts[self._curTab].color = Color(1, 1, 1)
  self.scrollList:SetListItemCount(#self._music[self._curTab], true)
  self:onClickItem(1)
end

function UIAlbumController:onClickItem(idx)
  local cfgID = self._music[self._curTab][idx].ID
  if self._curSelectCfgID == cfgID then
    if self._curPlaying == cfgID then
      if self._isPause then
        alog("当前暂停，继续播:", idx)
        AudioHelperController.UnpauseBGM()
        self.pauseBtn:SetActive(true)
        self.resumeBtn:SetActive(false)
        self._isPause = false
      else
        alog("当前正在播，暂停:", idx)
        AudioHelperController.PauseBGM()
        self.pauseBtn:SetActive(false)
        self.resumeBtn:SetActive(true)
        self._isPause = true
      end
    else
      alog("切音乐，开始播:", idx)
      local cfg = Cfg.cfg_role_music[cfgID]
      self._curPlaying = cfgID
      self._isPause = false
      self._curPlayingIndex = idx
      self._curPlayingTab = cfg.Tag
      AudioHelperController.PlayBGM(cfg.AudioID)
      self:refreshBtmBar(cfg)
      self:_ChangeBlurBgBegin(cfg.Icon)
    end
  else
    alog("点了不同的音乐，切换:", idx)
    local cfg = Cfg.cfg_role_music[cfgID]
    self._curSelectCfgID = cfgID
    self:changeSelect(cfg)
  end
  self.scrollList:RefreshAllShownItem()
end

function UIAlbumController:refreshBtmBar(cfg)
  alog("刷新底条信息")
  self.cover_small:LoadImage(cfg.Icon)
  self.pauseBtn:SetActive(not self._isPause)
  self.resumeBtn:SetActive(self._isPause)
  self:musicTimeTick()
  self.nameText:RefreshText(StringTable.Get(cfg.Name))
  self.authorText:RefreshText(StringTable.Get(cfg.Author))
end

function UIAlbumController:refreshSetBtn(type)
  alog("刷新底部按钮")
  if type == EnumBgmType.E_Bgm_Main then
    if self._curMainMusic == 0 then
      self.mainMusicText:RefreshText(StringTable.Get("str_album_main"))
    else
      local cfg = Cfg.cfg_role_music[self._curMainMusic]
      self.mainMusicText:RefreshText(StringTable.Get(cfg.Name))
    end
  elseif type == EnumBgmType.E_Bgm_AirCraft then
    if self._curAircraftMusic == 0 then
      self.aircraftMusicText:RefreshText(StringTable.Get("str_album_aircraft"))
    else
      local cfg = Cfg.cfg_role_music[self._curAircraftMusic]
      self.aircraftMusicText:RefreshText(StringTable.Get(cfg.Name))
    end
  elseif type == EnumBgmType.E_Bgm_Homeland then
    if self._curHomelandMusic == 0 then
      self.homelandMusicText:RefreshText(StringTable.Get("str_album_homeland"))
    else
      local cfg = Cfg.cfg_role_music[self._curHomelandMusic]
      self.homelandMusicText:RefreshText(StringTable.Get(cfg.Name))
    end
  else
    if self._curMainMusic == 0 then
      self.mainMusicText:RefreshText(StringTable.Get("str_album_main"))
    else
      local cfg = Cfg.cfg_role_music[self._curMainMusic]
      self.mainMusicText:RefreshText(StringTable.Get(cfg.Name))
    end
    if self._curAircraftMusic == 0 then
      self.aircraftMusicText:RefreshText(StringTable.Get("str_album_aircraft"))
    else
      local cfg = Cfg.cfg_role_music[self._curAircraftMusic]
      self.aircraftMusicText:RefreshText(StringTable.Get(cfg.Name))
    end
    if self._curHomelandMusic == 0 then
      self.homelandMusicText:RefreshText(StringTable.Get("str_album_homeland"))
    else
      local cfg = Cfg.cfg_role_music[self._curHomelandMusic]
      self.homelandMusicText:RefreshText(StringTable.Get(cfg.Name))
    end
  end
end

function UIAlbumController:_RefreshSetBtnVisible()
  for _, bgmType in pairs(EnumBgmType) do
    if self._isHomeland then
      self._setBtns[bgmType]:SetActive(bgmType == EnumBgmType.E_Bgm_Homeland)
    else
      self._setBtns[bgmType]:SetActive(bgmType ~= EnumBgmType.E_Bgm_Homeland)
    end
  end
end

function UIAlbumController:changeSelect(cfg)
  self.cover:LoadImage(cfg.Icon)
end

function UIAlbumController:musicTimeTick()
  if AudioHelperController.BGMPlayerIsPlaying() then
    local time = AudioHelperController.GetPlayingBGMTimeSyncedWithAudio()
    if time < 0 then
      time = 0
    end
    local duration = Cfg.cfg_role_music[self._curPlaying].Duration
    if self._development then
      local realDua = AudioHelperController.GetPlayingBGMTotalTimeMs()
      if 0 < realDua and math.abs(realDua / 1000 - duration) > 0.5 then
        ToastManager.ShowToast("音乐配置时长错误！ID:" .. self._curPlaying .. "，真实时长:" .. realDua / 1000)
      end
    end
    time = math.floor(time / 1000 % duration)
    self.time:SetText(UIBgmHelper.FormatTime(time) .. "/<color=#9d9d9d>" .. UIBgmHelper.FormatTime(duration) .. "</color>")
    self.progress.fillAmount = time / duration
  end
end

function UIAlbumController:Tab1OnClick(go)
  alog("切换tab1")
  self:changeTab(1)
end

function UIAlbumController:Tab2OnClick(go)
  alog("切换tab2")
  self:changeTab(2)
end

function UIAlbumController:Tab3OnClick(go)
  alog("切换tab3")
  self:changeTab(3)
end

function UIAlbumController:Tab4OnClick(go)
  alog("切换tab4")
  self:changeTab(4)
end

function UIAlbumController:Tab5OnClick(go)
  alog("切换tab5")
  self:changeTab(5)
end

function UIAlbumController:PauseBtnOnClick(go)
  alog("暂停")
  self._isPause = true
  self.pauseBtn:SetActive(false)
  self.resumeBtn:SetActive(true)
  AudioHelperController.PauseBGM()
  self.scrollList:RefreshAllShownItem()
end

function UIAlbumController:ResumeBtnOnClick(go)
  alog("继续播放")
  self._isPause = false
  self.pauseBtn:SetActive(true)
  self.resumeBtn:SetActive(false)
  AudioHelperController.UnpauseBGM()
  self.scrollList:RefreshAllShownItem()
end

function UIAlbumController:LastBtnOnClick(go)
  alog("上一首")
  local index = self._curPlayingIndex - 1
  if index < 1 then
    local count = #self._music[self._curPlayingTab]
    index = count
  end
  local lastCfgID = self._music[self._curPlayingTab][index].ID
  if self._curPlayingTab == self._curTab then
    if self._curSelectCfgID == lastCfgID then
      self:onClickItem(index)
    else
      self:onClickItem(index)
      self:onClickItem(index)
    end
  else
    local cfg = self._music[self._curPlayingTab][index]
    self._curPlaying = cfg.ID
    self._curPlayingIndex = index
    AudioHelperController.PlayBGM(cfg.AudioID)
    self:refreshBtmBar(cfg)
    self:_ChangeBlurBgBegin(cfg.Icon)
  end
end

function UIAlbumController:NextBtnOnClick(go)
  alog("下一首")
  local index = self._curPlayingIndex + 1
  local count = #self._music[self._curPlayingTab]
  if index > count then
    index = 1
  end
  local nextCfgID = self._music[self._curPlayingTab][index].ID
  if self._curPlayingTab == self._curTab then
    if self._curSelectCfgID == nextCfgID then
      self:onClickItem(index)
    else
      self:onClickItem(index)
      self:onClickItem(index)
    end
  else
    local cfg = self._music[self._curPlayingTab][index]
    self._curPlaying = cfg.ID
    self._curPlayingIndex = index
    AudioHelperController.PlayBGM(cfg.AudioID)
    self:refreshBtmBar(cfg)
    self:_ChangeBlurBgBegin(cfg.Icon)
  end
end

function UIAlbumController:SetMainOnClick(go)
  alog("设置主页背景音")
  local id = 0
  if self._curMainMusic == 0 then
    id = self._curPlaying
  elseif self._curMainMusic == self._curPlaying then
    id = 0
  else
    id = self._curPlaying
  end
  self:StartTask(self.reqChangeBgm, self, EnumBgmType.E_Bgm_Main, id)
end

function UIAlbumController:SetAircraftOnClick(go)
  alog("设置风船背景音")
  local id = 0
  if self._curAircraftMusic == 0 then
    id = self._curPlaying
  elseif self._curAircraftMusic == self._curPlaying then
    id = 0
  else
    id = self._curPlaying
  end
  self:StartTask(self.reqChangeBgm, self, EnumBgmType.E_Bgm_AirCraft, id)
end

function UIAlbumController:SetHomelandOnClick()
  alog("设置家园背景音")
  local id = 0
  if self._curHomelandMusic == 0 then
    id = self._curPlaying
  elseif self._curHomelandMusic == self._curPlaying then
    id = 0
  else
    id = self._curPlaying
  end
  self:StartTask(self.reqChangeBgm, self, EnumBgmType.E_Bgm_Homeland, id)
end

function UIAlbumController:reqChangeBgm(TT, type, id)
  self:Lock(self:GetName())
  local res = self._roleModule:RequestRole_Music(TT, type, id)
  if res:GetSucc() then
    self._curMainMusic = self._roleModule:UI_GetMusic(EnumBgmType.E_Bgm_Main)
    self._curAircraftMusic = self._roleModule:UI_GetMusic(EnumBgmType.E_Bgm_AirCraft)
    self._curHomelandMusic = self._roleModule:UI_GetMusic(EnumBgmType.E_Bgm_Homeland)
    self:refreshSetBtn(type)
    if type == EnumBgmType.E_Bgm_Main then
      if id == 0 then
        ToastManager.ShowToast(StringTable.Get("str_album_main_default"))
      else
        ToastManager.ShowToast(StringTable.Get("str_album_main_changed"))
      end
    elseif type == EnumBgmType.E_Bgm_AirCraft then
      if id == 0 then
        ToastManager.ShowToast(StringTable.Get("str_album_aircraft_default"))
      else
        ToastManager.ShowToast(StringTable.Get("str_album_aircraft_changed"))
      end
    elseif type == EnumBgmType.E_Bgm_Homeland then
      if id == 0 then
        ToastManager.ShowToast(StringTable.Get("str_album_homeland_default"))
      else
        ToastManager.ShowToast(StringTable.Get("str_album_homeland_changed"))
      end
    end
  else
    ToastManager.ShowToast("unkown error:", res:GetResult())
  end
  self:UnLock(self:GetName())
end

function UIAlbumController:_ChangeBlurBgBegin(icon)
  self._blurBgNew:LoadImage(icon)
  self._blurBgNew.gameObject:SetActive(false)
  self._blurBgNew.gameObject:SetActive(true)
  local lockId = "UIAlbumController:_ChangeBlurBg"
  self:Lock(lockId)
  self._blurBgNewImg:DOFade(0, 0)
  local targetFade = 1
  local duration = 0.5
  self._blurBgNewImg:DOFade(targetFade, duration):OnComplete(function()
    self:_ChangeBlurBgEnd(icon)
    self:UnLock(lockId)
  end)
end

function UIAlbumController:_ChangeBlurBgEnd(icon)
  self._blurBg:LoadImage(icon)
  self._blurBg.gameObject:SetActive(false)
  self._blurBg.gameObject:SetActive(true)
  self._blurBgNew.gameObject:SetActive(false)
end
