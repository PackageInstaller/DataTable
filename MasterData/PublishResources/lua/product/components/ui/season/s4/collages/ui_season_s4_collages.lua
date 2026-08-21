_class("UISeasonS4Collages", UIController)
UISeasonS4Collages = UISeasonS4Collages

function UISeasonS4Collages:OnShow(uiParams)
  self:InitWidget()
  local obj = UIWidgetHelper.SpawnObject(self, "_backBtns", "UICommonTopButton")
  obj:SetData(function()
    self:StartTask(self._OnExit, self)
  end, function()
    UISeasonHelper.ShowSeasonHelperBook(UISeasonHelperTabIndex.Collage)
  end, nil, true, nil)
  self._collection = nil
  self._cg = nil
  self._music = nil
  self._curSeasonobj = GameGlobal.GetModule(SeasonModule):GetCurSeasonObj()
  local uiModule = GameGlobal.GetUIModule(SeasonModule)
  self._seasonID = self._curSeasonobj:GetSeasonID()
  if self._seasonID ~= UISeasonID.S4 then
    Log.exception("当前赛季不是s4")
  end
  self._collageData = uiModule:GetCollageData()
  self._collageData:FlushAllCollages()
  local cgBtn = self:GetUIComponent("UISelectObjectPath", "CGBtn")
  self._cgBtn = cgBtn:SpawnObject("UISeasonS4CollageBtn")
  self._cgBtn:SetData(2, function()
    self:CGBtnOnClick()
  end, self._collageData)
  local musicBtn = self:GetUIComponent("UISelectObjectPath", "MusicBtn")
  self._musicBtn = musicBtn:SpawnObject("UISeasonS4CollageBtn")
  self._musicBtn:SetData(3, function()
    self:MusicBtnOnClick()
  end, self._collageData)
  self:CGBtnOnClick(nil, true)
  self:RefreshNew()
  self:AttachEvent(GameEventType.UISeasonS1OnSelectCollageItem, self.RefreshNew)
  self._anim:Play("uieffanim_UISeasonS3Collages_in")
  self._active = true
end

function UISeasonS4Collages:OnHide()
  self._active = false
end

function UISeasonS4Collages:InitWidget()
  self.topBtns = self:GetUIComponent("UISelectObjectPath", "TopBtns")
  self.collectionTab = self:GetUIComponent("UISelectObjectPath", "CollectionTab")
  self.cGTab = self:GetUIComponent("UISelectObjectPath", "CGTab")
  self.musicTab = self:GetUIComponent("UISelectObjectPath", "MusicTab")
  self.collectionCount = self:GetUIComponent("UILocalizationText", "CollectionCount")
  self.cGCount = self:GetUIComponent("UILocalizationText", "CGCount")
  self.musicCount = self:GetUIComponent("UILocalizationText", "MusicCount")
  self.collectionNew = self:GetGameObject("CollectionNew")
  self.cGNew = self:GetGameObject("CGNew")
  self.musicNew = self:GetGameObject("MusicNew")
  self._anim = self:GetUIComponent("Animation", "SafeArea")
end

function UISeasonS4Collages:CollectionBtnOnClick(go, onEnter)
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

function UISeasonS4Collages:CGBtnOnClick(go)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundSlideDynamic)
  if not self._cg then
    self._cg = self.cGTab:SpawnObject("UISeasonS4CGTab")
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

function UISeasonS4Collages:MusicBtnOnClick(go)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundSlideDynamic)
  if not self._music then
    self._music = self.musicTab:SpawnObject("UISeasonS4MusicTab")
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

function UISeasonS4Collages:RefreshNew()
  self._cgBtn:RefreshNew()
  self._musicBtn:RefreshNew()
end

function UISeasonS4Collages:GetGuideItem()
  if self._collection then
    return self._collection:GetGuideItem()
  end
end

function UISeasonS4Collages:_OnExit(TT)
  self:Lock("UISeasonS3Collages._OnExit")
  self._anim:Play("uieffanim_UISeasonS3Collages_out")
  YIELD(TT, 250)
  self:UnLock("UISeasonS3Collages._OnExit")
  if not self._active then
    return
  end
  self:CloseDialog()
end
