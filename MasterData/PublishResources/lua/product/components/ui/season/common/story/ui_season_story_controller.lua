_class("UISeasonStoryController", UIController)
UISeasonStoryController = UISeasonStoryController

function UISeasonStoryController:Constructor()
  self._breakIndexList = {}
  self.newName = ""
  self._splitChar = "|"
  self._showTxtGap = 50
  self._defaultBreakTypeTime = 200
  self._curBreakTypeTime = 100
  self._contentEndingTime = 200
  self._targetContent = ""
  self._wordTotalCount = 0
  self._hideTextAnim = false
  self._totalWaitTime = 0
  self._curWaitTime = 0
  self._autoWaitTime = 2000
  self._speakerBody = nil
  self._speakerContent = nil
  self._speakerName = nil
  self._canClick = false
  self._talkIDList = {}
  self._speakerNameStr = ""
  self._isAutoState = false
  self._isEndClick = false
  self._talkEndRan = false
end

function UISeasonStoryController:OnShow(uiParams)
  self._eventID = uiParams[1]
  self._endCallback = uiParams[2]
  self:_GetComponents()
  local taskCfg = Cfg.cfg_season_story_event[self._eventID]
  if not taskCfg then
    Log.exception("在cfg_season_story_event中未找到该配置：" .. self._eventID)
    self:CloseDialog()
    return
  end
  local startTalkID = taskCfg.StartTalkID
  self:InitDialog(startTalkID, true)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnSeasonStoryChanged, true)
end

function UISeasonStoryController:OnHide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnSeasonStoryChanged, false)
end

function UISeasonStoryController:_GetComponents()
  self._content1 = self:GetUIComponent("UILocalizationText", "Content1")
  self._speakerName1 = self:GetUIComponent("UILocalizationText", "SpeakerName1")
  self._body1 = self:GetUIComponent("RawImageLoader", "body1")
  self._content2 = self:GetUIComponent("UILocalizationText", "Content2")
  self._speakerName2 = self:GetUIComponent("UILocalizationText", "SpeakerName2")
  self._body2 = self:GetUIComponent("RawImageLoader", "body2")
  self._choosePool = self:GetUIComponent("UISelectObjectPath", "choosePool")
  self._anim1 = self:GetUIComponent("Animation", "anim1")
  self._anim2 = self:GetUIComponent("Animation", "anim2")
  self._dialogLayout1 = self:GetGameObject("DialogLayout1")
  self._dialogLayout2 = self:GetGameObject("DialogLayout2")
  self._endFlag1Obj = self:GetGameObject("EndFlag1")
  self._endFlag2Obj = self:GetGameObject("EndFlag2")
  self._optionsObj = self:GetGameObject("Options")
  self._fullScreenBtn = self:GetGameObject("FullScreenBtn")
  self._cancelAutoBtn = self:GetGameObject("CancelAutoButton")
  self._full1Obj = self:GetGameObject("Full1")
  self._buttonRootObj = self:GetGameObject("ButtonRoot")
end

function UISeasonStoryController:InitDialog(storyID, isAnim)
  self._canClick = false
  self._curWaitTime = 0
  self._curStoryCfg = Cfg.cfg_season_story_talk[storyID]
  if not self._curStoryCfg then
    Log.exception("在cfg_season_story_talk中未找到该配置：" .. storyID)
    self:CloseDialog()
    return
  end
  table.insert(self._talkIDList, storyID)
  self._content1:SetText("")
  self._content2:SetText("")
  self._endFlag1Obj:SetActive(false)
  self._endFlag2Obj:SetActive(false)
  if self._curStoryCfg.IsMainActorWord == 1 then
    self._dialogLayout1:SetActive(true)
    self._dialogLayout2:SetActive(false)
    self._speakerBody = self._body1
    self._speakerName = self._speakerName1
    self._speakerContent = self._content1
    if isAnim then
      self:StartTask(function(TT)
        self:Lock("uianim_DialogLayout1_in")
        self._anim1:Play("uianim_DialogLayout1_in")
        YIELD(TT, 667)
        self:UnLock("uianim_DialogLayout1_in")
      end)
    end
  else
    self._dialogLayout1:SetActive(false)
    self._dialogLayout2:SetActive(true)
    self._speakerBody = self._body2
    self._speakerName = self._speakerName2
    self._speakerContent = self._content2
    if isAnim then
      self:StartTask(function(TT)
        self:Lock("uianim_DialogLayout2_in")
        self._anim2:Play("uianim_DialogLayout2_in")
        YIELD(TT, 667)
        self:UnLock("uianim_DialogLayout2_in")
      end)
    end
  end
  self._targetContent = StringTable.Get(self._curStoryCfg.ChatWord)
  self._targetContent, self._breakIndexList, self._wordTotalCount, self._hideTextAnim = SeasonStoryHelper.GetContentInfo(self._targetContent)
  self._totalWaitTime = SeasonStoryHelper.SubStringGetTotalIndex(self._targetContent) * self._showTxtGap
  self._speakerNameStr = SeasonStoryHelper.DoEscape(StringTable.Get(self._curStoryCfg.SpeakerName))
  if self._curStoryCfg.SpeakerHead then
    self._speakerBody.gameObject:SetActive(true)
    self._speakerBody:LoadImage(self._curStoryCfg.SpeakerHead)
  else
    self._speakerBody.gameObject:SetActive(false)
  end
  self._speakerName:SetText(self._speakerNameStr)
  self:_CheckAnswerBtn()
end

function UISeasonStoryController:_CheckAnswerBtn()
  local answerIDTb = self._curStoryCfg.AnswerID
  if answerIDTb then
    self:SetAuto(false)
    self._fullScreenBtn:SetActive(false)
    self._optionsObj:SetActive(true)
    local answerBtns = self._choosePool:SpawnObjects("UISeasonStoryChooseItem", #answerIDTb)
    for i, btn in pairs(answerBtns) do
      local answerBtnTxt = self._curStoryCfg.AnswerBtnTxt
      btn:SetData(answerIDTb[i], StringTable.Get(answerBtnTxt[i]), function(storyID)
        self:AnswerBtnCallback(storyID)
      end)
    end
  else
    self._fullScreenBtn:SetActive(true)
    self._optionsObj:SetActive(false)
  end
end

function UISeasonStoryController:AnswerBtnCallback(storyID)
  self._isEndClick = false
  self:InitDialog(storyID)
end

function UISeasonStoryController:OnUpdate(deltaTimeMS)
  if self._curBreakTypeTime > 0 then
    self._curBreakTypeTime = self._curBreakTypeTime - deltaTimeMS
  else
    self._curWaitTime = deltaTimeMS + self._curWaitTime
    if self._curWaitTime < self._totalWaitTime + self._contentEndingTime and not self._canClick then
      local index = math.floor(self._curWaitTime / self._totalWaitTime * SeasonStoryHelper.SubStringGetTotalIndex(self._targetContent))
      if table.icontains(self._breakIndexList, index) then
        self._curBreakTypeTime = self._defaultBreakTypeTime
      end
      self:_UpdateAnimation(index)
    else
      self._endFlag1Obj:SetActive(not self._curStoryCfg.AnswerID)
      self._endFlag2Obj:SetActive(not self._curStoryCfg.AnswerID)
      self:_PlayEndFlagInAnim(function()
        self._canClick = true
      end)
      self:AutoRunning()
    end
  end
end

function UISeasonStoryController:_PlayEndFlagInAnim(callback)
  if not self._isEndClick then
    self._isEndClick = true
    self:StartTask(function(TT)
      if self._curStoryCfg.IsMainActorWord == 1 then
        self._anim1:Play("uianim_DialogLayout1_TextIn")
      else
        self._anim2:Play("uianim_DialogLayout2_TextIn")
      end
      YIELD(TT, 834)
      if callback then
        callback()
      end
    end)
  end
end

function UISeasonStoryController:_PlayEndFlagOutAnim(callback)
  if self._isEndClick then
    self._isEndClick = false
    self:StartTask(function(TT)
      if callback then
        callback()
      end
    end)
  end
end

function UISeasonStoryController:_UpdateAnimation(index)
  local showText = SeasonStoryHelper.SubStringUTF8(self._targetContent, 1, index)
  self._speakerContent:SetText(showText)
end

function UISeasonStoryController:SetAuto(isAuto)
  self._cancelAutoBtn:SetActive(isAuto)
  self._buttonRootObj:SetActive(not isAuto)
  self._isAutoState = isAuto
end

function UISeasonStoryController:AutoRunning()
  if self._isAutoState and self._curWaitTime > self._totalWaitTime + self._autoWaitTime and self._isEndClick then
    if self._curStoryCfg.LastTalk then
      self:_TalkEnd()
    else
      if self._curStoryCfg.NextWord then
        self:_PlayEndFlagOutAnim(function()
          self:InitDialog(self._curStoryCfg.NextWord)
        end)
      else
      end
    end
  end
end

function UISeasonStoryController:_TalkEnd()
  if self._talkEndRan then
    return
  end
  self._talkEndRan = true
  self:StartTask(function(TT)
    self:Lock("uianim_DialogLayout2_out")
    if self._curStoryCfg.IsMainActorWord == 1 then
      self._anim1:Play("uianim_DialogLayout2_out")
    else
      self._anim2:Play("uianim_DialogLayout2_out")
    end
    YIELD(TT, 334)
    self:UnLock("uianim_DialogLayout2_out")
    self:CloseDialog()
    if self._endCallback then
      self._endCallback()
    end
  end)
end

function UISeasonStoryController:FullScreenBtnOnClick()
  if self._canClick then
    if self._curStoryCfg.LastTalk then
      self:_TalkEnd()
    else
      self:_PlayEndFlagOutAnim(function()
        self:InitDialog(self._curStoryCfg.NextWord)
      end)
    end
  end
end

function UISeasonStoryController:CancelAutoButtonOnClick()
  self:SetAuto(false)
end

function UISeasonStoryController:ButtonSkipOnClick()
  local cfg = Cfg.cfg_season_story_event[self._eventID]
  PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, StringTable.Get("str_season_story_skip_title"), StringTable.Get(cfg.SkipTxt), function()
    self:_TalkEnd()
  end, nil, function(param)
  end, nil)
end

function UISeasonStoryController:ButtonReviewOnClick()
  self:ShowDialog("UISeasonStoryReviewController", self._talkIDList)
end

function UISeasonStoryController:ButtonAutoOnClick()
  self:SetAuto(true)
end
