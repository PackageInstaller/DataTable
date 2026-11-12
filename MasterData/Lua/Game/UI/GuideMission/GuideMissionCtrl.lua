local GuideMissionCtrl = class("GuideMissionCtrl", BaseCtrl)
local GuideMissionData = PlayerData.GuideMission
GuideMissionCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  rtChapterList = {
    sComponentName = "LoopScrollView"
  },
  tog = {
    nCount = 3,
    sComponentName = "UIButton",
    callback = "OnToggleChange"
  },
  rtReview = {
    sCtrlName = "Game.UI.GuideMission.GuideMissionQuestCtrl"
  },
  rtShop = {
    sCtrlName = "Game.UI.GuideMission.GuideMissionShopCtrl"
  }
}
GuideMissionCtrl._mapEventConfig = {
  GuideMissionQuestGoBack = "OnGuideMissionQuestGoBack",
  GuideMissionQuestGroupChange = "OnGuideMissionQuestGroupChange"
}
local ToggleText = {
  [1] = "GuideMission_Boss_Record",
  [2] = "GuideMission_Item_Change",
  [3] = "GuideMission_Disc_Change"
}
local nLastReviewChapterId, nLastReviewGroupIndex

function GuideMissionCtrl:FadeIn(bPlayFadeIn)
  EventManager.Hit(EventId.SetTransition)
end

function GuideMissionCtrl:Awake()
  self.tbRedDotLastChapterId = self.tbRedDotLastChapterId or {}
end

function GuideMissionCtrl:OnEnable()
  self:SetContentVisible(false)
  local tbParam = self:GetPanelParam()
  local nJumpTog = 1
  if tbParam ~= nil and tbParam[1] ~= nil then
    nJumpTog = tbParam[1]
  end
  self.nJumpTogIndex = nJumpTog
  PlayerData.Quest:RequestGuideMissionInfo(function()
    self:RefreshPanel()
  end)
end

function GuideMissionCtrl:OnDisable()
end

function GuideMissionCtrl:OnDestroy()
end

function GuideMissionCtrl:SetContentVisible(bVisible)
  for _, tog in ipairs(self._mapNode.tog) do
    tog.gameObject:SetActive(bVisible)
  end
  self._mapNode.rtChapterList.gameObject:SetActive(false)
  self._mapNode.rtReview.gameObject:SetActive(false)
  self._mapNode.rtShop.gameObject:SetActive(false)
end

function GuideMissionCtrl:RefreshPanel()
  self:SetContentVisible(true)
  self:RefreshChapterList()
  self:RefreshTog()
  self.nCurTogIndex = nil
  self.bInReview = false
  self:OnToggleChange(nil, self.nJumpTogIndex or 1)
  if self.nJumpTogIndex == nil or self.nJumpTogIndex == 1 then
    if nLastReviewChapterId ~= nil then
      local bUnlock = GuideMissionData:IsChapterUnlock(nLastReviewChapterId)
      if bUnlock then
        self:EnterReview(nLastReviewChapterId, nLastReviewGroupIndex)
      else
        nLastReviewChapterId = nil
        nLastReviewGroupIndex = nil
      end
    else
      local nChapterId = GuideMissionData:FindReceivableChapter()
      if nChapterId ~= nil then
        self:EnterReview(nChapterId)
      end
    end
  end
end

function GuideMissionCtrl:RefreshTog()
  for nIndex, tog in ipairs(self._mapNode.tog) do
    local animSwitch = tog.gameObject.transform:Find("AnimRoot/AnimSwitch")
    local txtSelect = animSwitch:Find("txt_Select"):GetComponent("TMP_Text")
    local txtUnSelect = animSwitch:Find("txt_unSelect"):GetComponent("TMP_Text")
    local sText = ConfigTable.GetUIText(ToggleText[nIndex])
    NovaAPI.SetTMPText(txtSelect, sText)
    NovaAPI.SetTMPText(txtUnSelect, sText)
  end
end

function GuideMissionCtrl:RefreshChapterList()
  self.tbChapterList = GuideMissionData:GetChapterList()
  self._mapNode.rtChapterList:Init(#self.tbChapterList + 1, self, self.OnChapterGridRefresh)
end

function GuideMissionCtrl:OnChapterGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local mapChapter = self.tbChapterList[nIndex]
  local btn = goGrid.transform:Find("btn"):GetComponent("UIButton")
  btn.onClick:RemoveAllListeners()
  btn.onClick:AddListener(function()
    self:OnChapterGridBtnClick(goGrid, gridIndex)
  end)
  local rootTrans = goGrid.transform:Find("btn/AnimRoot")
  local goUnlock = rootTrans:Find("goUnlock")
  local goLock = rootTrans:Find("goLock")
  local goComplete = rootTrans:Find("goComplete")
  local goEmpty = rootTrans:Find("goEmpty")
  local bEmpty = mapChapter == nil
  local imgTitle4Lock = rootTrans:Find("imgTitle4Lock"):GetComponent("Image")
  local imgTitle4 = rootTrans:Find("imgTitle4"):GetComponent("Image")
  local txtTitleEmpty = goEmpty:Find("txtTitleEmpty"):GetComponent("TMP_Text")
  goEmpty.gameObject:SetActive(bEmpty)
  NovaAPI.SetTMPText(txtTitleEmpty, ConfigTable.GetUIText("StorySet_Chapter_Empty"))
  if bEmpty then
    goLock.gameObject:SetActive(false)
    goComplete.gameObject:SetActive(false)
    return
  end
  local bUnlock, sLockReson = GuideMissionData:IsChapterUnlock(mapChapter.Id)
  goLock.gameObject:SetActive(not bUnlock)
  imgTitle4Lock.gameObject:SetActive(not bUnlock)
  imgTitle4.gameObject:SetActive(bUnlock)
  local imgChapterPic = goUnlock:Find("imgChapterPic"):GetComponent("Image")
  local imgStar = goUnlock:Find("imgChapterPic/imgStar"):GetComponent("Image")
  local txtChapterIndex = goUnlock:Find("imgTitle1/txtChapterIndex"):GetComponent("TMP_Text")
  local txtTitle = goUnlock:Find("txtTitle"):GetComponent("TMP_Text")
  self:SetPngSprite(imgChapterPic, mapChapter.IconPath)
  self:SetPngSprite(imgStar, mapChapter.IconPath)
  NovaAPI.SetTMPText(txtChapterIndex, mapChapter.Index)
  NovaAPI.SetTMPText(txtTitle, mapChapter.Title)
  if not bUnlock then
    local txtLock = goLock:Find("txtLock"):GetComponent("TMP_Text")
    NovaAPI.SetTMPText(txtLock, sLockReson)
  end
  local isComplete = GuideMissionData:IsChapterComplete(mapChapter.Id)
  goComplete.gameObject:SetActive(isComplete)
  if isComplete then
    local txtComplete = goComplete:Find("imgBg/txtComplete"):GetComponent("TMP_Text")
    NovaAPI.SetTMPText(txtComplete, ConfigTable.GetUIText("PerActivity_Quest_Complete"))
  end
  local goRedDot = rootTrans:Find("ChapterRedDot")
  local nGoInstanceId = goRedDot.gameObject:GetInstanceID()
  local nLastChapterId = self.tbRedDotLastChapterId[nGoInstanceId]
  if nLastChapterId ~= nil and nLastChapterId ~= mapChapter.Id then
    RedDotManager.UnRegisterNode(RedDotDefine.GuideMission_Chapter, nLastChapterId, goRedDot.gameObject)
  end
  self.tbRedDotLastChapterId[nGoInstanceId] = mapChapter.Id
  RedDotManager.RegisterNode(RedDotDefine.GuideMission_Chapter, mapChapter.Id, goRedDot.gameObject)
end

function GuideMissionCtrl:OnChapterGridBtnClick(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local mapChapter = self.tbChapterList[nIndex]
  if mapChapter == nil then
    return
  end
  local bUnlock, sLockReson = GuideMissionData:IsChapterUnlock(mapChapter.Id)
  if not bUnlock then
    EventManager.Hit(EventId.OpenMessageBox, sLockReson)
    return
  end
  self:EnterReview(mapChapter.Id)
end

function GuideMissionCtrl:EnterReview(nChapterId, nGroupIndex)
  nLastReviewChapterId = nChapterId
  nLastReviewGroupIndex = nGroupIndex
  self.bInReview = true
  self._mapNode.rtReview:RefreshPanel(nChapterId, nGroupIndex)
  self._mapNode.rtReview.gameObject:SetActive(true)
  self._mapNode.rtChapterList.gameObject:SetActive(false)
end

function GuideMissionCtrl:OnToggleChange(btn, nIndex)
  if self.nCurTogIndex == nIndex then
    return
  end
  if self.nCurTogIndex ~= nil then
    local animSwitchOff = self._mapNode.tog[self.nCurTogIndex].gameObject.transform:Find("AnimRoot/AnimSwitch"):GetComponent("Animator")
    animSwitchOff:Play("t_tog_01_switch_off")
  end
  local animSwitchOn = self._mapNode.tog[nIndex].gameObject.transform:Find("AnimRoot/AnimSwitch"):GetComponent("Animator")
  animSwitchOn:Play("t_tog_01_switch_in")
  self.nCurTogIndex = nIndex
  self._mapNode.rtReview.gameObject:SetActive(false)
  if nIndex == 2 or nIndex == 3 then
    self._mapNode.rtChapterList.gameObject:SetActive(false)
    self._mapNode.rtShop.gameObject:SetActive(true)
    self._mapNode.rtShop:EnterShop(nIndex)
  else
    self._mapNode.rtShop:ExitShop()
    self._mapNode.rtShop.gameObject:SetActive(false)
    if self.bInReview then
      self._mapNode.rtReview.gameObject:SetActive(true)
      self._mapNode.rtChapterList.gameObject:SetActive(false)
    else
      self._mapNode.rtChapterList.gameObject:SetActive(true)
    end
  end
end

function GuideMissionCtrl:OnGuideMissionQuestGroupChange(nChapterId, nGroupIndex)
  nLastReviewChapterId = nChapterId
  nLastReviewGroupIndex = nGroupIndex
end

function GuideMissionCtrl:OnGuideMissionQuestGoBack()
  nLastReviewChapterId = nil
  nLastReviewGroupIndex = nil
  self.bInReview = false
  self._mapNode.rtReview.gameObject:SetActive(false)
  self._mapNode.rtChapterList.gameObject:SetActive(true)
  self:RefreshChapterList()
end

return GuideMissionCtrl
