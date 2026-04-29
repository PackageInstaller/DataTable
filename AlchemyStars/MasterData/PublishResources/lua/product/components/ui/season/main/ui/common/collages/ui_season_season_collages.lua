_class("UISeasonSeasonCollages", UIController)
UISeasonSeasonCollages = UISeasonSeasonCollages

function UISeasonSeasonCollages:OnShow(uiParams)
  self:InitWidget()
  local obj = UIWidgetHelper.SpawnObject(self, "_backBtns", "UICommonTopButton")
  obj:SetData(function()
    self:StartTask(self._OnExit, self)
  end, nil, nil, true, nil)
  self._collection = nil
  self._cg = nil
  self._music = nil
  self._curSeasonobj = GameGlobal.GetModule(SeasonModule):GetCurSeasonObj()
  local uiModule = GameGlobal.GetUIModule(SeasonModule)
  self._seasonID = self._curSeasonobj:GetSeasonID()
  self._collageData = uiModule:GetCollageData()
  self._collageData:FlushAllCollages()
  local cfg = UISeasonHelper.GetCurCollectionCfg()
  if cfg then
    self.bg:LoadImage(cfg.BgName)
  end
  local cgBtn = self:GetUIComponent("UISelectObjectPath", "CGBtn")
  self._cgBtn = cgBtn:SpawnObject("UISeasonSeasonCollageBtn")
  self._cgBtn:SetData(2, function()
    self:CGBtnOnClick()
  end, self._collageData)
  local musicBtn = self:GetUIComponent("UISelectObjectPath", "MusicBtn")
  self._musicBtn = musicBtn:SpawnObject("UISeasonSeasonCollageBtn")
  self._musicBtn:SetData(3, function()
    self:MusicBtnOnClick()
  end, self._collageData)
  self:CGBtnOnClick(nil, true)
  self:RefreshNew()
  self:AttachEvent(GameEventType.UISeasonS1OnSelectCollageItem, self.RefreshNew)
  self._anim:Play("uieffanim_UISeasonS5Collages_in")
  self._active = true
end

function UISeasonSeasonCollages:OnHide()
  self._active = false
end

function UISeasonSeasonCollages:InitWidget()
  self.cGTab = self:GetUIComponent("UISelectObjectPath", "CGTab")
  self.musicTab = self:GetUIComponent("UISelectObjectPath", "MusicTab")
  self.bg = self:GetUIComponent("RawImageLoader", "bg")
  self._anim = self:GetUIComponent("Animation", "SafeArea")
end

function UISeasonSeasonCollages:CollectionBtnOnClick(go, onEnter)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundSlideDynamic)
  if not self._collection then
    self._collection = self.collectionTab:SpawnObject("UISeasonS3CollectionTab")
    self._collection:SetData(self._collageData, onEnter)
  end
  self._collection:SetShow(true)
  if self._cg then
    self._cg:SetShow(false)
  end
  if self._music then
    self._music:SetShow(false)
  end
  self._cgBtn:SetSelect(false)
  self._musicBtn:SetSelect(false)
end

function UISeasonSeasonCollages:CGBtnOnClick(go)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundSlideDynamic)
  if not self._cg then
    self._cg = self.cGTab:SpawnObject("UISeasonSeasonCGTab")
    self._cg:SetData(self._collageData, self._curSeasonobj)
  end
  self._cg:SetShow(true)
  if self._collection then
    self._collection:SetShow(false)
  end
  if self._music then
    self._music:SetShow(false)
  end
  self._cgBtn:SetSelect(true)
  self._musicBtn:SetSelect(false)
end

function UISeasonSeasonCollages:MusicBtnOnClick(go)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundSlideDynamic)
  if not self._music then
    self._music = self.musicTab:SpawnObject("UISeasonSeasonMusicTab")
    self._music:SetData(self._collageData)
  end
  self._music:SetShow(true)
  if self._collection then
    self._collection:SetShow(false)
  end
  if self._cg then
    self._cg:SetShow(false)
  end
  self._cgBtn:SetSelect(false)
  self._musicBtn:SetSelect(true)
end

function UISeasonSeasonCollages:RefreshNew()
  self._cgBtn:RefreshNew()
  self._musicBtn:RefreshNew()
end

function UISeasonSeasonCollages:GetGuideItem()
  if self._collection then
    return self._collection:GetGuideItem()
  end
end

function UISeasonSeasonCollages:_OnExit(TT)
  self:Lock("UISeasonS3Collages._OnExit")
  self._anim:Play("uieffanim_UISeasonS5Collages_out")
  YIELD(TT, 250)
  self:UnLock("UISeasonS3Collages._OnExit")
  if not self._active then
    return
  end
  self:CloseDialog()
end
