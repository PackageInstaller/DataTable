_class("UIXiaoLinJiaStoryController", UIController)
UIXiaoLinJiaStoryController = UIXiaoLinJiaStoryController

function UIXiaoLinJiaStoryController:OnShow(uiParams)
  self.missionID = uiParams[1]
  self.uiMainController = uiParams[2]
  local cfg = Cfg.cfg_xiaolinjia_mission({
    ID = self.missionID
  })
  if cfg then
    self.missionCfg = cfg[1]
  else
    Log.exception("story cfg is nil", self.missionID)
  end
  self._campaign = self.uiMainController:GetCampaign()
  local componentID = self.uiMainController:GetTacitTestComponentCfgId()
  self.collectionCfg = Cfg.cfg_xiaolinjia_collection({ComponentID = componentID})
  self.roleName = StringTable.Get(self.missionCfg.RoleName)
  self.MAX_QUESTION_COUNT = 3
  self.curGetStarCount = 0
  self.curAnswerRightRecord = {}
  self.curAnswerIsRight = false
  self.getReward = nil
  self.recordPos = 1
  self.atlas = self:GetAsset("XiaoLinJia.spriteatlas", LoadType.SpriteAtlas)
  self.storyManager = XiaoLinJiaStoryManager:New(self.missionCfg.StoryCfgName, self)
  self.playerCtrlMap = {
    [1] = UIXiaoLinJiaPlayer:New(self:GetUIComponent("UIView", "player1"), self, self.atlas, 1),
    [2] = UIXiaoLinJiaPlayer:New(self:GetUIComponent("UIView", "player2"), self, self.atlas, 2),
    [3] = UIXiaoLinJiaPlayer:New(self:GetUIComponent("UIView", "player3"), self, self.atlas, 3),
    [4] = UIXiaoLinJiaPlayer:New(self:GetUIComponent("UIView", "player4"), self, self.atlas, 4)
  }
  self.optionsPool = self:GetUIComponent("UISelectObjectPath", "options")
  self.questionStart = self:GetGameObject("questionStart")
  self.questionRoot = self:GetGameObject("questionRoot")
  self.questionShow = self:GetGameObject("questionShow")
  self.questionResult = self:GetGameObject("questionResult")
  self.fullScreenBtn = self:GetGameObject("fullScreenBtn")
  self.lcBtnGroup = self:GetGameObject("lcBtnGroup")
  self.questionStartText1 = self:GetUIComponent("UILocalizationText", "questionStartText1")
  self.questionStartText2 = self:GetUIComponent("UILocalizationText", "questionStartText2")
  self.questionTitleText1 = self:GetUIComponent("UILocalizationText", "questionTitleText1")
  self.questionTitleText2 = self:GetUIComponent("UILocalizationText", "questionTitleText2")
  self.questionTitleStr = self:GetUIComponent("UILocalizationText", "titleStr")
  self.questionResultTitle = self:GetUIComponent("UILocalizationText", "questionResultTitle")
  self.questionResultStar = self:GetGameObject("questionResultStar")
  self.questionResultHead = self:GetUIComponent("Image", "questionResultHead")
  self.endPanel = self:GetGameObject("endPanel")
  self.endPanelStar = self:GetGameObject("endPanelStar")
  self.endPanelEvaluateText1 = self:GetUIComponent("UILocalizationText", "endPanelEvaluateText1")
  self.endPanelEvaluateText2 = self:GetUIComponent("UILocalizationText", "endPanelEvaluateText2")
  self.endPanelHeadIcon = self:GetUIComponent("Image", "endPanelHeadIcon")
  self.endPanelTitle = self:GetUIComponent("UILocalizationText", "endPanelTitle")
  self.endPanelContent = self:GetUIComponent("UILocalizationText", "endPanelContent")
  self.autoShow = self:GetGameObject("autoShow")
  self.anim = self:GetUIComponent("Animation", "anim")
  self.questionRootAnim = self:GetUIComponent("Animation", "questionRootAnim")
  self.questionStartAnim = self:GetUIComponent("Animation", "questionStartAnim")
  self.questionShowAnim = self:GetUIComponent("Animation", "questionShowAnim")
  self.questionResultAnim = self:GetUIComponent("Animation", "questionResultAnim")
  self.endPanelAnim = self:GetUIComponent("Animation", "endPanelAnim")
  local backBtns = self:GetUIComponent("UISelectObjectPath", "backBtns")
  self._backBtns = backBtns:SpawnObject("UINewCommonTopButton")
  self._backBtns:SetData(function()
    PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, "", StringTable.Get("str_xiaolinjia_text_quit_2"), function(param)
      self:Lock("UIXiaoLinJiaStoryController_Close")
      self.anim:Play("uieffanim_UIXiaoLinJiaStoryController_out")
      self:StartTask(function(TT)
        YIELD(TT, 333)
        self:CloseDialog()
        self:UnLock("UIXiaoLinJiaStoryController_Close")
        self:UnLock("WaitForOtherPlayerSelectFinish")
        if self._campaign:CheckCampaignClose_ShowClientError() then
          return
        end
      end)
    end, nil, function(param)
      Log.debug("###[UIXiaoLinJiaStoryController] 取消")
    end, nil)
  end, nil, nil, false, nil, nil, nil)
  local firstMission = self.storyManager:GetFirstMissionData()
  for i = 1, #self.playerCtrlMap do
    self.playerCtrlMap[i]:SetFaceIcon(firstMission.FaceIcon[i])
  end
  self:StartTask(function(TT)
    self:Lock("UIXiaoLinJiaStoryController_StartSession")
    YIELD(TT, 800)
    self:UnLock("UIXiaoLinJiaStoryController_StartSession")
    self.storyManager:StartSession()
  end)
end

function UIXiaoLinJiaStoryController:HandleStartQuestionSession()
  local curSessionData = self.storyManager:GetCurSessionData()
  local curQuestionData = curSessionData[1]
  local otherPlayerSelects = curQuestionData.OtherPlayerAnswer
  local curQuestionIndex = self.storyManager:GetCurQuestionIndex()
  self.lcBtnGroup:SetActive(false)
  self.questionSessionTask = self:StartTask(function(TT)
    self.questionStartText1:SetText(StringTable.Get("str_xiaolinjia_text_question_num", curQuestionIndex))
    self.questionStartText2:SetText(StringTable.Get("str_xiaolinjia_text_question_num", curQuestionIndex))
    self.questionTitleText1:SetText(StringTable.Get("str_xiaolinjia_text_question_num", curQuestionIndex))
    self.questionTitleText2:SetText(StringTable.Get("str_xiaolinjia_text_question_num", curQuestionIndex))
    self.questionStart:SetActive(true)
    YIELD(TT, 800)
    if tolua.isnull(self.questionStartAnim) then
      return
    end
    self.questionStartAnim:Play("uieffanim_UIXiaoLinJiaStoryController_QuestionStart_out")
    YIELD(TT, 300)
    if tolua.isnull(self.questionStart) then
      return
    end
    self.questionStart:SetActive(false)
    self.questionRoot:SetActive(true)
    self.questionTitleStr:SetText(StringTable.Get(curQuestionData.Topic))
    self.optionsPool:SpawnObjects("UIXiaoLinJiaStoryOptionItem", #curQuestionData.Options)
    self.options = self.optionsPool:GetAllSpawnList()
    for i = 1, #self.playerCtrlMap do
      self.playerCtrlMap[i]:SetFaceIcon(self.missionCfg.SelectingFaceIcon[i])
    end
    for i = 2, #self.playerCtrlMap do
      self.playerCtrlMap[i]:SetPlayerSelect(otherPlayerSelects[i - 1])
      self.playerCtrlMap[i]:DoSelectingAnim()
    end
    for i, v in pairs(curQuestionData.Options) do
      self.options[i]:SetData(i, v, curQuestionData.OtherPlayerAnswer, self.missionCfg, function(index)
        self.storyManager:SetCurPlayerSelectIndex(index)
        self.playerCtrlMap[1]:SetPlayerSelect(index)
        if index == curQuestionData.Answer then
          self.curAnswerRightRecord[curQuestionIndex] = curQuestionData.Answer
          self.curGetStarCount = self.curGetStarCount + 1
          self.curAnswerIsRight = true
        else
          self.curAnswerIsRight = false
        end
        if curQuestionIndex == self.MAX_QUESTION_COUNT then
          self.uiMainController:SaveTacitTestResult(self.missionID, self.curGetStarCount, function(reward)
            self.getReward = reward
            self:AfterPlayerSelectOption()
          end)
          local record = self.uiMainController:GetMissionQuestionRecord(self.missionID)
          if record then
            for idx, v in pairs(record) do
              self.curAnswerRightRecord[idx] = v
            end
          end
          self.uiMainController:UpdateTacitTestAnswer(self.missionID, self.curAnswerRightRecord)
        else
          self:AfterPlayerSelectOption()
        end
      end)
    end
    self.questionSessionTask = nil
  end)
end

function UIXiaoLinJiaStoryController:GetOtherPlayerIsSelectFinish()
  local isFinish = true
  for i = 2, #self.playerCtrlMap do
    isFinish = self.playerCtrlMap[i]:IsFinishSelect()
  end
  return isFinish
end

function UIXiaoLinJiaStoryController:AfterPlayerSelectOption()
  local curSessionData = self.storyManager:GetCurSessionData()
  local curQuestionData = curSessionData[1]
  self.afterQuestionSessionTask = self:StartTask(function(TT)
    self:Lock("WaitForOtherPlayerSelectFinish")
    while not self:GetOtherPlayerIsSelectFinish() do
      YIELD(TT)
    end
    self.questionShow:SetActive(true)
    YIELD(TT, 1000)
    self.questionShowAnim:Play("uieffanim_UIXiaoLinJiaStoryController_QuestionShow_out")
    YIELD(TT, 333)
    self.questionShow:SetActive(false)
    for _, v in pairs(self.playerCtrlMap) do
      v:ChangeToSelectBG()
    end
    for _, v in pairs(self.options) do
      v:ShowAllSelectResult()
    end
    local titleStr = self.curAnswerIsRight and "str_xiaolinjia_text_good_result" or "str_xiaolinjia_text_bad_result"
    self.questionResultTitle:SetText(StringTable.Get(titleStr, self.roleName))
    self.questionResultHead.sprite = self.atlas:GetSprite(self.missionCfg.ClosingHeadIcon)
    for i = 1, self.curGetStarCount do
      local trans = self.questionResultStar.transform:GetChild(i - 1)
      trans:Find("star").gameObject:SetActive(true)
    end
    YIELD(TT, 1000)
    self.questionResult:SetActive(true)
    AudioHelperController.RequestAndPlayUIVoiceAutoRelease(CriAudioIDConst.HomelandAudioBubble)
    self:UnLock("WaitForOtherPlayerSelectFinish")
    self.afterQuestionSessionTask = nil
  end)
end

function UIXiaoLinJiaStoryController:HandleStartDialogSession()
  local curSessionData = self.storyManager:GetCurSessionData()
  for _, data in pairs(curSessionData) do
    for i = 1, #self.playerCtrlMap do
      if i == data.Speaker then
        local content = self:_DoEscape(StringTable.Get(data.Content))
        self.playerCtrlMap[i]:SetSpeakContent(content, data.ContentBG)
      end
      self.playerCtrlMap[i]:SetFaceIcon(data.FaceIcon[i])
    end
  end
end

function UIXiaoLinJiaStoryController:HandleEndQuestionSession(TT)
  local curSession = self.storyManager:GetCurSessionID()
  self.recordPos = curSession
  self.lcBtnGroup:SetActive(true)
end

function UIXiaoLinJiaStoryController:HandleEndDialogSession(TT)
  local curSessionData = self.storyManager:GetCurSessionData()
  for _, data in pairs(curSessionData) do
    local player = self.playerCtrlMap[data.Speaker]
    player:ShowDialogAnim(false)
  end
  YIELD(TT, 333)
  for _, data in pairs(curSessionData) do
    local player = self.playerCtrlMap[data.Speaker]
    if player then
      player:ShowDialog(false)
    end
  end
end

function UIXiaoLinJiaStoryController:ShowClosingPanel()
  local str = StringTable.Get(self.uiMainController:GetEvaluate(self.curGetStarCount))
  self.endPanelEvaluateText1:SetText(str)
  self.endPanelEvaluateText2:SetText(str)
  self.endPanelTitle:SetText(StringTable.Get("str_xiaolinjia_text_rank_result", self.roleName))
  self.endPanelContent:SetText(StringTable.Get("str_xiaolinjia_rankdesc_" .. self.curGetStarCount))
  self.endPanelHeadIcon.sprite = self.atlas:GetSprite(self.missionCfg.ClosingHeadIcon)
  for i = 1, self.curGetStarCount do
    local trans = self.endPanelStar.transform:GetChild(i - 1)
    trans:Find("star").gameObject:SetActive(true)
  end
  self.endPanel:SetActive(true)
  self.lcBtnGroup:SetActive(false)
  AudioHelperController.RequestAndPlayUIVoiceAutoRelease(CriAudioIDConst.SoundXiaoLinJiaClosing)
end

function UIXiaoLinJiaStoryController:_DoEscape(strContent)
  strContent = string.gsub(strContent, "$$", "$")
  local name = GameGlobal.GetModule(RoleModule):GetName()
  if string.isnullorempty(name) then
    name = StringTable.Get("str_guide_moren_name")
  end
  strContent = string.gsub(strContent, "PlayerName", name)
  return strContent
end

function UIXiaoLinJiaStoryController:OnSessionStart()
  local isQuestion = self.storyManager:GetCurSessionIsQuestion()
  if isQuestion then
    self:HandleStartQuestionSession()
  else
    self:HandleStartDialogSession()
  end
end

function UIXiaoLinJiaStoryController:OnSessionEnd(TT)
  local isQuestion = self.storyManager:GetCurSessionIsQuestion()
  if isQuestion then
    self:HandleEndQuestionSession(TT)
  else
    self:HandleEndDialogSession(TT)
  end
end

function UIXiaoLinJiaStoryController:OnUpdate(deltaTimeMS)
  self.storyManager:Update(deltaTimeMS)
end

function UIXiaoLinJiaStoryController:OnHide()
  if self.afterQuestionSessionTask then
    GameGlobal.TaskManager():KillTask(self.afterQuestionSessionTask)
    self.afterQuestionSessionTask = nil
  end
  if self.questionSessionTask then
    GameGlobal.TaskManager():KillTask(self.questionSessionTask)
    self.questionSessionTask = nil
  end
  for _, v in pairs(self.playerCtrlMap) do
    v:OnDispose()
  end
  self.storyManager:OnDispose()
end

function UIXiaoLinJiaStoryController:OnExit()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnXiaoLinJiaMainPanelRefresh, true)
  self:Lock("UIXiaoLinJiaStoryController_Close")
  self.anim:Play("uieffanim_UIXiaoLinJiaStoryController_out")
  self:StartTask(function(TT)
    YIELD(TT, 333)
    self:CloseDialog()
    self:UnLock("UIXiaoLinJiaStoryController_Close")
    self:UnLock("WaitForOtherPlayerSelectFinish")
  end)
end

function UIXiaoLinJiaStoryController:ClosingPanelBtnOnClick()
  self:Lock("UIXiaoLinJiaStoryController_ClosingPanelBtnOnClick")
  self.endPanelAnim:Play("uieffanim_UIXiaoLinJiaStoryController_endPanel_out")
  self:StartTask(function(TT)
    YIELD(TT, 500)
    self:UnLock("UIXiaoLinJiaStoryController_ClosingPanelBtnOnClick")
    self.endPanel:SetActive(false)
    if self.curGetStarCount == 3 then
      self.storyManager:ForceEnd()
      GameGlobal.GetModule(StoryModule):StartStory(self.missionCfg.EndingStory, function()
        if self.getReward and #self.getReward > 0 then
          local id = self.getReward[1].assetid
          local cfg
          for _, v in pairs(self.collectionCfg) do
            if v.ItemID == id then
              cfg = v
            end
          end
          self.questionResultHead = self.atlas:GetSprite(self.missionCfg.ClosingHeadIcon)
          self:ShowDialog("UIXiaoLinJiaGetCollectionController", function()
          end, cfg, self.missionCfg.ClosingHeadIcon, self.roleName)
        else
        end
        self:OnExit()
      end, true)
    else
      self.lcBtnGroup:SetActive(true)
      self.storyManager:TouchQuestionResultPanelAndJumpToNextSession()
      self.recordPos = self.storyManager:GetCurSessionID()
    end
  end)
end

function UIXiaoLinJiaStoryController:QuestionResultBtnOnClick()
  self:Lock("UIXiaoLinJiaStoryController_QuestionResult_out")
  self.questionResultAnim:Play("uieffanim_UIXiaoLinJiaStoryController_QuestionResult_out")
  self:StartTask(function(TT)
    YIELD(TT, 300)
    self.questionResult:SetActive(false)
    self.questionRoot:SetActive(false)
    self.storyManager:TouchQuestionResultPanelAndJumpToNextSession()
    for _, v in pairs(self.playerCtrlMap) do
      v:ResetSelectBG()
    end
    self:UnLock("UIXiaoLinJiaStoryController_QuestionResult_out")
  end)
end

function UIXiaoLinJiaStoryController:FullScreenBtnOnClick()
  if self.storyManager:GetAuto() then
    self.storyManager:SetAuto(false)
    self.autoShow:SetActive(false)
  else
    self.storyManager:TouchScreenAndJumpToNextSession()
  end
end

function UIXiaoLinJiaStoryController:RecordBtnOnClick()
  local auto = self.storyManager:GetAuto()
  if auto then
    self.storyManager:SetAuto(false)
    self.autoShow:SetActive(false)
  end
  local dialogList = self.storyManager:GetDialogList()
  local curSession = self.storyManager:GetCurSessionID()
  local curQuestionIndex = self.storyManager:GetCurQuestionIndex()
  self:ShowDialog("UIXiaoLinJiaReview", curSession, dialogList, self.recordPos, function()
    if auto then
      self.storyManager:SetAuto(true)
      self.autoShow:SetActive(true)
    end
  end)
end

function UIXiaoLinJiaStoryController:AutoBtnOnClick()
  local auto = self.storyManager:GetAuto()
  self.storyManager:SetAuto(not auto)
  self.autoShow:SetActive(not auto)
end

function UIXiaoLinJiaStoryController:JumpBtnOnClick()
  if self.storyManager:GetCanJumpSession() then
    PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, "", StringTable.Get("str_story_skip_confirm"), function(param)
      local auto = self.storyManager:GetAuto()
      if auto then
        self.storyManager:SetAuto(false)
        self.autoShow:SetActive(false)
      end
      self.storyManager:JumpSession()
    end, nil, function(param)
      Log.debug("###[UIXiaoLinJiaStoryController] 取消")
    end, nil)
  end
end
