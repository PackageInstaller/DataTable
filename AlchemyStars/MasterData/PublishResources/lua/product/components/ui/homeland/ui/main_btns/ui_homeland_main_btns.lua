_class("UIHomelandMainBtns", UICustomWidget)
UIHomelandMainBtns = UIHomelandMainBtns

function UIHomelandMainBtns:Constructor()
  self.mHomeland = GameGlobal.GetModule(HomelandModule)
  self.mUIHomeland = self.mHomeland:GetUIModule()
  self.homelandClient = self.mUIHomeland:GetClient()
  self._isVisit = self.homelandClient:IsVisit()
  if not self._isVisit then
    self.mHomeland = GameGlobal.GetModule(HomelandModule)
    self.data = self.mHomeland:GetHomelandLevelData()
    self.data:Init()
    self.dataBag = self.mHomeland:GetHomelandBackpackData()
    self.dataBag:Init()
    self._dairyEnterData = UIHomelandDairyEnterData:New()
  end
end

function UIHomelandMainBtns:OnShow()
  local btnPool = self:GetUIComponent("UISelectObjectPath", "btnPool")
  self._btnItem = btnPool:SpawnObject("UIHomeCommonCloseBtn")
  self._btnItem:SetData(function()
    self:btnBackOnClick()
  end, nil, true)
  self.txtTips = self:GetUIComponent("UILocalizationText", "txtTips")
  self.goTips = self:GetGameObject("tips")
  self.diaryTips = self:GetGameObject("diaryTips")
  self.msgText = self:GetUIComponent("UILocalizationText", "msgText")
  self.redBag = self:GetGameObject("redBag")
  self.redBag:SetActive(false)
  self.dairyNew = self:GetGameObject("dairyNew")
  self.redLevel = self:GetGameObject("redLevel")
  self.redLevel:SetActive(false)
  self.txtLevel = self:GetUIComponent("UILocalizationText", "txtLevel")
  self.taskRedPoint = self:GetGameObject("TaskRedPoint")
  self._btnFollowShow = self:GetGameObject("btnFollowShow")
  self._btnFollow = self:GetGameObject("btnFollow")
  self:CheckFollowCount()
  self._homeEventTips = {}
  self:AttachEvent(GameEventType.OnHomeEventTips, self.OnHomeEventTips)
  self:AttachEvent(GameEventType.ItemCountChanged, self.ItemCountChanged)
  self:AttachEvent(GameEventType.OnHomePetFollow, self.CheckFollowCount)
  self:AttachEvent(GameEventType.OnHomeStoryFinish, self.OnHomeEventFinish)
  self:AttachEvent(GameEventType.HomeLandEventChange, self.OnHomeEventFinish)
  self:AttachEvent(GameEventType.HomeAfterCollectLevelReward, self.FlushRedLevel)
  self:AttachEvent(GameEventType.HomeLandFunctionUnlock, self.RefreshFuncUnlock)
  self:AttachEvent(GameEventType.HomelandLevelOnLevelInfoChange, self.FlushLevel)
  self:AttachEvent(GameEventType.QuestUpdate, self.OnQuestUpdate)
  self:AttachEvent(GameEventType.AfterUILayerChanged, self.ShowDiaryInfo)
  self.btnBuild = self:GetGameObject("btnBuild")
  self.btnBag = self:GetGameObject("btnBag")
  self.btnFriend = self:GetGameObject("BtnFriend")
  self.tglFollow = self:GetGameObject("tglFollow")
  self.btnShowHide = self:GetGameObject("btnShowHide")
  self.btnDiary = self:GetGameObject("btnDiary")
  self.btnLevel = self:GetGameObject("btnLevel")
  self.btnTask = self:GetGameObject("btnTask")
  self.campaignEnter = self:GetGameObject("campaignEnter")
  if self._isVisit then
    self.btnBuild:SetActive(false)
    self.btnBag:SetActive(false)
    self.tglFollow:SetActive(false)
    self.btnShowHide:SetActive(false)
    self.btnDiary:SetActive(false)
    self.btnLevel:SetActive(false)
    self.btnTask:SetActive(false)
    self.campaignEnter:SetActive(false)
  else
    self:Refresh()
    if self:CheckNewEventTip() then
      self:ShowEventTipTimer()
    end
  end
  self:_RefreshTaskRedPoint()
end

function UIHomelandMainBtns:OnHide()
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
  self:DetachEvent(GameEventType.ItemCountChanged, self.ItemCountChanged)
  self:DetachEvent(GameEventType.OnHomeStoryFinish, self.OnHomeEventFinish)
  self:DetachEvent(GameEventType.HomeLandEventChange, self.OnHomeEventFinish)
  self:DetachEvent(GameEventType.AfterUILayerChanged, self.ShowDiaryInfo)
end

function UIHomelandMainBtns:SetCampaignEnter(latestCampObj)
  if not self._isVisit then
    local obj = UIWidgetHelper.SpawnObject(self, "campaignEnter", "UIHomelandMainBtnsCampaignEnter")
    obj:SetData(self.campaignEnter)
  end
end

function UIHomelandMainBtns:CheckFollowCount()
  local show = false
  local followList = self.homelandClient:PetManager():GetFollowPets()
  if table.count(followList) > 0 then
    show = true
  end
  self._btnFollow:SetActive(show)
end

function UIHomelandMainBtns:btnBackOnClick(go)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ExitHomeland)
  HomeLoading.Exit()
end

function UIHomelandMainBtns:BtnFollowOnClick(go)
  local followList = self.homelandClient:PetManager():GetFollowPets()
  if table.count(followList) > 0 then
    self._btnFollowShow:SetActive(true)
    self:ShowDialog("UIHomePetFollowList", function()
      self._btnFollowShow:SetActive(false)
    end)
  end
end

function UIHomelandMainBtns:BtnShowHideOnClick(go)
  self.uiOwner:SetShowHide(false)
end

function UIHomelandMainBtns:BtnBuildOnClick(go)
  self:StartTask(self._EnterBuildMode, self)
end

function UIHomelandMainBtns:_EnterBuildMode(TT)
  self:SwitchState(UIStateType.UIHomelandBuild)
  while GameGlobal.UIStateManager():IsLocked() do
    YIELD(TT)
  end
  self.homelandClient:StartBuild()
end

function UIHomelandMainBtns:btnBagOnClick(go)
  self:ShowDialog("UIHomelandBackpack")
end

function UIHomelandMainBtns:OnHomeEventTips(petid, text)
  self._homeEventTips[#self._homeEventTips + 1] = {petid, text}
  self:PlayTips(true)
end

function UIHomelandMainBtns:PlayTips(isStart)
  if self._isPlayingTips and isStart then
    return
  end
  local t = self._homeEventTips[1]
  if not t then
    self._isPlayingTips = false
    self.goTips:SetActive(false)
    return
  end
  table.remove(self._homeEventTips, 1)
  if isStart then
    self._isPlayingTips = true
    self.goTips:SetActive(true)
  end
  local canvasGroup = self.goTips:GetComponent("CanvasGroup")
  self.txtTips:SetText(t[2])
  canvasGroup:DOFade(1, 1.5):OnComplete(function()
    canvasGroup:DOFade(0, 1.5):OnComplete(function()
      self:PlayTips(false)
    end)
  end)
end

function UIHomelandMainBtns:ShowDiaryInfo()
  if not self._isVisit then
    self._homelandDairyCount, self._finishDairys = self._dairyEnterData:GetDairyEventCount()
    local isNew = self._dairyEnterData:CheckNew()
    self.diaryTips:SetActive(self._homelandDairyCount > 0 and not isNew)
    self.dairyNew:SetActive(isNew)
    self._homelandDairyCount = self._homelandDairyCount > 99 and 99 or self._homelandDairyCount
    self.msgText:SetText(self._homelandDairyCount)
  end
end

function UIHomelandMainBtns:BtnDiaryOnClick(go)
  self:ShowDialog("UIHomeLandDiaryEnterController")
end

function UIHomelandMainBtns:RefreshFuncUnlock(functionType)
  if functionType == HomelandUnlockType.E_HOMELAND_UNLOCK_BAG_UI then
    self.btnBag:SetActive(true)
  elseif functionType == HomelandUnlockType.E_HOMELAND_UNLOCK_BUILD_UI then
    self.btnBuild:SetActive(true)
  elseif functionType == HomelandUnlockType.E_HOMELAND_UNLOCK_LEVEL_BTN_UI then
    self.btnLevel:SetActive(true)
  elseif functionType == HomelandUnlockType.E_HOMELAND_UNLOCK_DAIRY_UI then
    self.btnDiary:SetActive(true)
  elseif functionType == HomelandUnlockType.E_HOMELAND_UNLOCK_VISIT_UI then
    self.btnFriend:SetActive(true)
  elseif functionType == HomelandUnlockType.E_HOMELAND_UNLOCK_QUEST_BTN then
    self.btnTask:SetActive(true)
  elseif functionType == HomelandUnlockType.E_HOMELAND_UNLOCK_FOLLOW_UI then
    self.tglFollow:SetActive(true)
  end
end

function UIHomelandMainBtns:Refresh()
  self.btnBag:SetActive(self.mHomeland:CheckFunctionUnlock(HomelandUnlockType.E_HOMELAND_UNLOCK_BAG_UI))
  self.btnBuild:SetActive(self.mHomeland:CheckFunctionUnlock(HomelandUnlockType.E_HOMELAND_UNLOCK_BUILD_UI))
  self.btnLevel:SetActive(self.mHomeland:CheckFunctionUnlock(HomelandUnlockType.E_HOMELAND_UNLOCK_LEVEL_BTN_UI))
  self.btnDiary:SetActive(self.mHomeland:CheckFunctionUnlock(HomelandUnlockType.E_HOMELAND_UNLOCK_DAIRY_UI))
  self.btnFriend:SetActive(self.mHomeland:CheckFunctionUnlock(HomelandUnlockType.E_HOMELAND_UNLOCK_VISIT_UI))
  self.btnTask:SetActive(self.mHomeland:CheckFunctionUnlock(HomelandUnlockType.E_HOMELAND_UNLOCK_QUEST_BTN))
  self.tglFollow:SetActive(self.mHomeland:CheckFunctionUnlock(HomelandUnlockType.E_HOMELAND_UNLOCK_FOLLOW_UI))
  self:ShowDiaryInfo()
  self:FlushRedBag()
  self:FlushLevel()
end

function UIHomelandMainBtns:ItemCountChanged()
  if not self._isVisit then
    self.dataBag:InitList()
    self:FlushRedBag()
  end
end

function UIHomelandMainBtns:FlushRedBag()
  if not self._isVisit then
    if self.dataBag:IsNew() then
      self.redBag:SetActive(true)
    else
      self.redBag:SetActive(false)
    end
  end
end

function UIHomelandMainBtns:btnLevelOnClick(go)
  self:ShowDialog("UIHomelandLevel")
end

function UIHomelandMainBtns:FlushLevel()
  self.txtLevel:SetText(self.data.level)
  self:FlushRedLevel()
end

function UIHomelandMainBtns:FlushRedLevel()
  if self.data:HasAward2Get() then
    self.redLevel:SetActive(true)
  else
    self.redLevel:SetActive(false)
  end
end

function UIHomelandMainBtns:BtnFriendOnClick(go)
  self:ShowDialog("UIHomeVisitFriends")
end

function UIHomelandMainBtns:btnTaskOnClick(go)
  self:ShowDialog("UIHomelandTask", function()
    self:_RefreshTaskRedPoint()
  end)
end

function UIHomelandMainBtns:_RefreshTaskRedPoint()
  local questModule = self:GetModule(QuestModule)
  local show, functionType = questModule:HomeLandTaskRedPoint()
  if show then
    local unlock = true
    if functionType == QuestType.QT_Homeland_Stage or functionType == QuestType.QT_Homeland_Stage_Num then
      unlock = self.mHomeland:CheckFunctionUnlock(HomelandUnlockType.E_HOMELAND_UNLOCK_QUEST_STAGE_UI)
    elseif functionType == QuestType.QT_Homeland_Common then
      unlock = self.mHomeland:CheckFunctionUnlock(HomelandUnlockType.E_HOMELAND_UNLOCK_QUEST_COMMON_UI)
    end
    self.taskRedPoint:SetActive(show and unlock)
  else
    self.taskRedPoint:SetActive(show)
  end
end

function UIHomelandMainBtns:OnHomeEventFinish()
  self:ShowDiaryInfo()
  self:ShowEventTipTimer()
end

function UIHomelandMainBtns:CheckNewEventTip()
  local mRole = GameGlobal.GetModule(RoleModule)
  local pstid = mRole:GetPstId()
  local key = "CheckNewEventTip" .. pstid
  if not UnityEngine.PlayerPrefs.HasKey(key) then
    UnityEngine.PlayerPrefs.SetInt(key, 0)
  end
  local res = false
  local count = UnityEngine.PlayerPrefs.GetInt(key)
  if #self._finishDairys ~= count then
    res = true
  end
  return res
end

function UIHomelandMainBtns:ShowEventTip()
  local mRole = GameGlobal.GetModule(RoleModule)
  local pstid = mRole:GetPstId()
  local key = "CheckNewEventTip" .. pstid
  local count = UnityEngine.PlayerPrefs.GetInt(key)
  if #self._finishDairys ~= count then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUIHomeEventTips, UIHomeEventTipsType.Dairy, {
      StringTable.Get("str_homeland_diarynew_tips")
    })
    UnityEngine.PlayerPrefs.SetInt(key, #self._finishDairys)
  end
end

function UIHomelandMainBtns:ShowEventTipTimer()
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
  if not self._timerHandler then
    self._timerHandler = GameGlobal.Timer():AddEventTimes(500, TimerTriggerCount.Once, function()
      self:ShowEventTip()
    end)
  end
end

function UIHomelandMainBtns:OnQuestUpdate(quests)
  self:_RefreshTaskRedPoint()
end
