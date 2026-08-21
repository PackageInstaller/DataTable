_class("UISeasonS1Collages", UIController)
UISeasonS1Collages = UISeasonS1Collages

function UISeasonS1Collages:OnShow(uiParams)
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
  if self._seasonID ~= UISeasonID.S1 then
    Log.exception("当前赛季不是s1")
  end
  self._collageData = uiModule:GetCollageData()
  self._collageData:FlushAllCollages()
  self:CollectionBtnOnClick()
  local format = "%s<color=#b8956b>/%s</color>"
  local cur, total = self._collageData:GetCollectionProgress()
  self.collectionCount:SetText(string.format(format, cur, total))
  cur, total = self._collageData:GetCgProgress()
  self.cGCount:SetText(string.format(format, cur, total))
  cur, total = self._collageData:GetMusicProgress()
  self.musicCount:SetText(string.format(format, cur, total))
  self:RefreshNew()
  self:AttachEvent(GameEventType.UISeasonS1OnSelectCollageItem, self.RefreshNew)
  self._active = true
end

function UISeasonS1Collages:OnHide()
  self._active = false
end

function UISeasonS1Collages:InitWidget()
  self.topBtns = self:GetUIComponent("UISelectObjectPath", "TopBtns")
  self.collectionTab = self:GetUIComponent("UISelectObjectPath", "CollectionTab")
  self.cGTab = self:GetUIComponent("UISelectObjectPath", "CGlTab")
  self.musicTab = self:GetUIComponent("UISelectObjectPath", "MusicTab")
  self.collectionCount = self:GetUIComponent("UILocalizationText", "CollectionCount")
  self.cGCount = self:GetUIComponent("UILocalizationText", "CGCount")
  self.musicCount = self:GetUIComponent("UILocalizationText", "MusicCount")
  self.collectionNew = self:GetGameObject("CollectionNew")
  self.cGNew = self:GetGameObject("CGNew")
  self.musicNew = self:GetGameObject("MusicNew")
  self._collectionBtn = self:GetUIComponent("Button", "CollectionBtn")
  self._cgBtn = self:GetUIComponent("Button", "CGBtn")
  self._musicBtn = self:GetUIComponent("Button", "MusicBtn")
  self._anim = self:GetUIComponent("Animation", "SafeArea")
end

function UISeasonS1Collages:CollectionBtnOnClick(go)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundSlideDynamic)
  if not self._collection then
    self._collection = self.collectionTab:SpawnObject("UISeasonS1CollectionTab")
    self._collection:SetData(self._collageData)
  end
  self._collection:SetShow(true)
  if self._cg then
    self._cg:SetShow(false)
  end
  if self._music then
    self._music:SetShow(false)
  end
  self._collectionBtn.interactable = false
  self._cgBtn.interactable = true
  self._musicBtn.interactable = true
end

function UISeasonS1Collages:CGBtnOnClick(go)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundSlideDynamic)
  if not self._cg then
    self._cg = self.cGTab:SpawnObject("UISeasonS1CGTab")
    self._cg:SetData(self._collageData, self._curSeasonobj)
  end
  self._cg:SetShow(true)
  if self._collection then
    self._collection:SetShow(false)
  end
  if self._music then
    self._music:SetShow(false)
  end
  self._collectionBtn.interactable = true
  self._cgBtn.interactable = false
  self._musicBtn.interactable = true
end

function UISeasonS1Collages:MusicBtnOnClick(go)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundSlideDynamic)
  if not self._music then
    self._music = self.musicTab:SpawnObject("UISeasonS1MusicTab")
    self._music:SetData(self._collageData)
  end
  self._music:SetShow(true)
  if self._collection then
    self._collection:SetShow(false)
  end
  if self._cg then
    self._cg:SetShow(false)
  end
  self._collectionBtn.interactable = true
  self._cgBtn.interactable = true
  self._musicBtn.interactable = false
end

function UISeasonS1Collages:RefreshNew()
  self.collectionNew:SetActive(self._collageData:CollectionHasNew())
  self.cGNew:SetActive(self._collageData:CGHasNew())
  self.musicNew:SetActive(self._collageData:MusicHasNew())
end

function UISeasonS1Collages:GetGuideItem()
  if self._collection then
    return self._collection:GetGuideItem()
  end
end

function UISeasonS1Collages:_OnExit(TT)
  self:Lock("UISeasonS1Collages._OnExit")
  self._anim:Play("uieffanim_UISeasonS1Collages_out")
  if self._collection then
    self._collection:PlayExitAnim()
  end
  if self._cg then
    self._cg:PlayExitAnim()
  end
  if self._music then
    self._music:PlayExitAnim()
  end
  YIELD(TT, 300)
  self:UnLock("UISeasonS1Collages._OnExit")
  if not self._active then
    return
  end
  self:CloseDialog()
end
