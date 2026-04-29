_class("UIHomePetInteract", UIController)
UIHomePetInteract = UIHomePetInteract
UIHomePetInteract.InteractType_Chat = 1
UIHomePetInteract.InteractType_Story = 2
UIHomePetInteract.InteractType_Follow = 3
UIHomePetInteract.InteractType_Byebye = 4
UIHomePetInteract.InteractType_HideChat = 5
UIHomePetInteract.InteractType_RareFish = 6
UIHomePetInteract.InteractType_PetFish = 7
UIHomePetInteract.InteractType_DescribeFishGameRule = 8
UIHomePetInteract.InteractType_FishMatch = 9
UIHomePetInteract.InteractType_FishMatchCancel = 10
UIHomePetInteract.InteractType_FishMatchBye = 11

function UIHomePetInteract:Constructor(ui_root_transform)
  self._fishing_position = nil
  self._rareFishing = nil
  self._petFishing = nil
end

function UIHomePetInteract:GetCfgData()
  self._idleAnimName = "stand"
  self._moveCameraTime = Cfg.cfg_homeland_global.StoryCameraMoveTime.IntValue
  self._rotateBodyTime = Cfg.cfg_homeland_global.StoryPetRotateTime.IntValue
  self._angleMin = Cfg.cfg_homeland_global.StoryCameraAngleMin.IntValue
  self._angleMax = Cfg.cfg_homeland_global.StoryCameraAngleMax.IntValue
  self._cameraZPos = Cfg.cfg_homeland_global.StoryCameraEnterZ.FloatValue
  self._overXRot = Cfg.cfg_homeland_global.StoryCameraOverAngleX.IntValue
  self._enterXRot = Cfg.cfg_homeland_global.StoryCameraEnterAngleX.IntValue
  self._focusOffsetY = Cfg.cfg_homeland_global.StoryCameraFocusOffsetY.FloatValue
  self._autoYieldTime = 2000
  self._moveCameraScreenTime = 0
  self._moveCameraScreenDurn = self._moveCameraTime
end

function UIHomePetInteract:GetComponents()
  local pool = self:GetUIComponent("UISelectObjectPath", "pool")
  self._widget = pool:SpawnObject("UIHomePetInteractEmpty")
  self._chooseGo = self._widget:GetGameObject("Options")
  self._myTalkGo = self._widget:GetGameObject("DialogLayout2")
  self._petTalkGo = self._widget:GetGameObject("DialogLayout1")
  self._canvas = self:GetUIComponent("Canvas", "UICanvas")
  self._myTalkTex = self._widget:GetUIComponent("UIRichText", "Content2")
  self._myTalkTex_Break = UIHomePetInteractBreakText:New()
  self._myTalkTex_Break:SetData(self._myTalkTex, self._canvas)
  self._petTalkTex = self._widget:GetUIComponent("UIRichText", "Content1")
  self._petTalkTex_Break = UIHomePetInteractBreakText:New()
  self._petTalkTex_Break:SetData(self._petTalkTex, self._canvas)
  self._speakerName1 = self._widget:GetUIComponent("UILocalizedTMP", "SpeakerName1")
  self._speakerName2 = self._widget:GetUIComponent("UILocalizedTMP", "SpeakerName2")
  self._matReq1 = UIWidgetHelper.SetLocalizedTMPMaterial(self._widget, "SpeakerName1", "UIHomeStorySpeakerName.mat", self._matReq1)
  self._matReq2 = UIWidgetHelper.SetLocalizedTMPMaterial(self._widget, "SpeakerName2", "UIHomeStorySpeakerName.mat", self._matReq2)
  self._myTalkGo:SetActive(false)
  self._petTalkGo:SetActive(false)
  self._body = self._widget:GetUIComponent("RawImageLoader", "body1")
  self._endFlag = self._widget:GetGameObject("EndFlag")
  self._endFlag:SetActive(false)
  self._pool = self._widget:GetUIComponent("UISelectObjectPath", "choosePool")
  self._poolRect = self._widget:GetUIComponent("RectTransform", "choosePool")
  self._Full1 = self._widget:GetGameObject("Full1")
end

function UIHomePetInteract:OnShow(uiParams)
  self._hasNewFishingPosition = false
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnHomeMainShowUIRoot, false)
  self:GetCfgData()
  self._commonStoryPlaying = HomePetInteractState.None
  self._roleModule = GameGlobal.GetModule(RoleModule)
  self._homelandModule = GameGlobal.GetModule(HomelandModule)
  self._uiHomelandModule = self._homelandModule:GetUIModule()
  self._homelandClient = self._uiHomelandModule:GetClient()
  local inputMgr = self._homelandClient:InputManager()
  inputMgr:ResetCurController()
  local charMgr = inputMgr:GetControllerChar()
  charMgr:SetActive(false)
  self._pet = uiParams[1]
  self._currentStoryPet = self._pet
  self._callback = uiParams[2]
  self._targetChatID = uiParams[3]
  if uiParams[4] then
    self._checkNpcId = uiParams[4][1]
    self._checkChatId = uiParams[4][2]
    self._checkTalkId = uiParams[4][3]
    self._checkItem = uiParams[4][4]
    self._checkItemCount = uiParams[4][5]
  end
  local cameraMgr = self._homelandClient:CameraManager()
  self._cameraCtl = cameraMgr:FollowCameraController()
  self._character = self._homelandClient:CharacterManager():MainCharacterController()
  self._charaTr = self._character:Transform()
  self._character:SetStoryLayer(true)
  self._petTr = self._currentStoryPet:AgentTransform()
  self._self = true
  self:GetComponents()
  self:AddListener()
  self:CreateData()
  self:InitBtns()
  self._commonStoryPlaying = HomePetInteractState.BeginInteract
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUIHomePetInteract, true)
end

function UIHomePetInteract:OnDragBgRoot(pointerEventData)
  self._homelandClient:InputManager():HandleRotateInInteract(pointerEventData.delta * 0.05)
end

function UIHomePetInteract:OnBeginDragBgRoot()
  self._draging = true
end

function UIHomePetInteract:OnEndDragBgRoot()
  self._draging = false
end

function UIHomePetInteract:AddListener()
  self._buttonRoot = self._widget:GetGameObject("ButtonRoot")
  self._buttonRoot:SetActive(false)
  self._bg = self._widget:GetGameObject("FullScreenBtn")
  self._bg:SetActive(true)
  self._bgCanClick = false
  self._bgEtl = UICustomUIEventListener.Get(self._bg)
  self:AddUICustomEventListener(self._bgEtl, UIEvent.Drag, function(pointerEventData)
    self:OnDragBgRoot(pointerEventData)
  end)
  self:AddUICustomEventListener(self._bgEtl, UIEvent.BeginDrag, function(pointerEventData)
    self:OnBeginDragBgRoot(pointerEventData)
  end)
  self:AddUICustomEventListener(self._bgEtl, UIEvent.EndDrag, function(pointerEventData)
    self:OnEndDragBgRoot(pointerEventData)
  end)
  self._cancelAutoButton = self._widget:GetGameObject("CancelAutoButton")
  self._cancelHideButton = self._widget:GetGameObject("CancelHideButton")
  self._buttonReview = self._widget:GetGameObject("ButtonReview")
  self._buttonHide = self._widget:GetGameObject("ButtonHide")
  self._buttonAuto = self._widget:GetGameObject("ButtonAuto")
  self.uiCustomEventListener:AddUICustomEventListener(UICustomUIEventListener.Get(self._bg), UIEvent.Click, function(go)
    if self._bgCanClick and not self._draging then
      self:bgOnClick(go)
    end
  end)
  self.uiCustomEventListener:AddUICustomEventListener(UICustomUIEventListener.Get(self._cancelAutoButton), UIEvent.Click, function(go)
    self:CancelAutoButtonOnClick(go)
  end)
  self.uiCustomEventListener:AddUICustomEventListener(UICustomUIEventListener.Get(self._cancelHideButton), UIEvent.Click, function(go)
    self:CancelHideButtonOnClick(go)
  end)
  self.uiCustomEventListener:AddUICustomEventListener(UICustomUIEventListener.Get(self._buttonReview), UIEvent.Click, function(go)
    self:ButtonReviewOnClick(go)
  end)
  self.uiCustomEventListener:AddUICustomEventListener(UICustomUIEventListener.Get(self._buttonHide), UIEvent.Click, function(go)
    self:ButtonHideOnClick(go)
  end)
  self.uiCustomEventListener:AddUICustomEventListener(UICustomUIEventListener.Get(self._buttonAuto), UIEvent.Click, function(go)
    self:ButtonAutoOnClick(go)
  end)
end

function UIHomePetInteract:Destroy()
  self._matReq1 = UIWidgetHelper.DisposeLocalizedTMPMaterial(self._matReq1)
  self._matReq2 = UIWidgetHelper.DisposeLocalizedTMPMaterial(self._matReq2)
end

function UIHomePetInteract:ButtonAutoOnClick()
  self._auto = true
  self._cancelAutoButton:SetActive(true)
  self._buttonRoot:SetActive(false)
  self:AutoBgOnClick(0)
end

function UIHomePetInteract:ButtonHideOnClick()
  self._Full1:SetActive(false)
  self._cancelHideButton:SetActive(true)
end

function UIHomePetInteract:CancelAutoButtonOnClick()
  self._auto = false
  self._cancelAutoButton:SetActive(false)
  self._buttonRoot:SetActive(true)
  if self._event then
    GameGlobal.Timer():CancelEvent(self._event)
    self._event = nil
  end
end

function UIHomePetInteract:CancelHideButtonOnClick()
  self._Full1:SetActive(true)
  self._cancelHideButton:SetActive(false)
end

function UIHomePetInteract:ButtonReviewOnClick()
  GameGlobal.UIStateManager():ShowDialog("UIHomePetStoryReview", self._dialogRecord)
end

function UIHomePetInteract:CreateData()
  self._datas = {}
  if HomelandPet:IsInstanceOfType(self._pet) then
    self:CreatePetInteractData()
  elseif HomelandTaskNPC:IsInstanceOfType(self._pet) then
    self:CreateNpcInteractData()
  end
end

function UIHomePetInteract:CreatePetInteractData()
  local petid = self._pet:TemplateID()
  local _self = 1
  if not self._self then
    _self = 2
  end
  local cfgs = Cfg.cfg_home_pet_interact({PetID = petid, Self = _self})
  if cfgs and next(cfgs) then
    local cfg = cfgs[1]
    local totalChatIds = {}
    if cfg.ChatIDs then
      for k, v in pairs(cfg.ChatIDs) do
        totalChatIds[#totalChatIds + 1] = v
      end
    end
    if cfg.EnterAudio ~= nil then
      AudioHelperController.PlayUISoundAutoRelease(cfg.EnterAudio)
    end
    if cfg.RandomIDs then
      for k, v in pairs(cfg.RandomIDs) do
        totalChatIds[#totalChatIds + 1] = v
      end
    end
    local completeIds = self._homelandModule:GetPetComplatedChatList(petid)
    if completeIds then
      for i = 1, #completeIds do
        for j = 1, #totalChatIds do
          if totalChatIds[j] == completeIds[i] then
            table.remove(totalChatIds, j)
            break
          end
        end
      end
    end
    if #totalChatIds <= 0 then
      local eventCfg = Cfg.cfg_homeland_event[cfg.HideChatEventId]
      if cfg.HideChatEventId and eventCfg and not self._homelandModule:CheckEventFinished(cfg.HideChatEventId) and not table.icontains(completeIds, eventCfg.ChatID) then
        local lData = {}
        lData.type = self.InteractType_HideChat
        lData.id = eventCfg.ChatID
        lData.event_id = cfg.HideChatEventId
        lData.fishing_pisitoin = eventCfg.AppendWishingCoinFishingPosition
        table.insert(self._datas, lData)
        local behaviourMgr = self._pet:GetPetBehavior()
        local behaviour = behaviourMgr:GetCurBehavior()
        local bubbleCmp = behaviour:GetComponent(HomelandPetComponentType.Bubble)
        if bubbleCmp then
          local bubbleId = Cfg.cfg_homeland_global.HasHideChatBubbleId.IntValue
          if bubbleId then
            bubbleCmp:ShowBubble(bubbleId)
          end
        end
      end
    end
    local storyid = self._pet:GetStoryID()
    if storyid then
      local lData = {}
      lData.type = self.InteractType_Story
      lData.id = storyid
      table.insert(self._datas, lData)
    end
    if cfg.ChatIDs then
      for i = 1, #cfg.ChatIDs do
        local lData = {}
        lData.type = self.InteractType_Chat
        lData.id = cfg.ChatIDs[i]
        table.insert(self._datas, lData)
      end
    end
    if cfg.RandomIDs and #cfg.RandomIDs > 0 then
      local randomIdx = math.random(1, #cfg.RandomIDs)
      local lData = {}
      lData.type = self.InteractType_Chat
      lData.id = cfg.RandomIDs[randomIdx]
      table.insert(self._datas, lData)
    end
    if cfg.RareClueIDs ~= nil then
      local homeLandModule = GameGlobal.GetUIModule(HomelandModule)
      local homelandClient = homeLandModule:GetClient()
      local fishingManager = homelandClient:FishingManager()
      local rareCfgs = Cfg.cfg_homeland_rare_clue
      for k, v in pairs(cfg.RareClueIDs) do
        local rareCfg = rareCfgs[v]
        if rareCfg ~= nil then
          local rareFishing = fishingManager:GetRareFishing(v)
          local lData = {}
          local tmp = rareCfgs[v].type
          if rareCfgs[v].type == 1 then
            lData.type = self.InteractType_RareFish
            lData.id = v
            lData.rareFishing = rareFishing
            table.insert(self._datas, lData)
          elseif rareCfgs[v].type == 2 then
            lData.type = self.InteractType_PetFish
            lData.id = v
            lData.rareFishing = rareFishing
            if rareCfgs[v].GameRuleEventId ~= nil then
              local GameRuleEventId = rareCfgs[v].GameRuleEventId
              local eventCfg = Cfg.cfg_homeland_event[GameRuleEventId]
              if GameRuleEventId and eventCfg and not self._homelandModule:CheckEventFinished(GameRuleEventId) and not table.icontains(completeIds, eventCfg.ChatID) then
                lData.type = self.InteractType_DescribeFishGameRule
                lData.id = eventCfg.ChatID
                lData.event_id = GameRuleEventId
              end
            end
            table.insert(self._datas, lData)
          end
        end
      end
    end
    local matchCfg = Cfg.cfg_homeland_fishmatch_main({
      PetID = petid,
      Type = FishingEntryType.FET_FishingPetChallenge
    })
    local eventFinish = false
    if matchCfg then
      eventFinish = true
      local taskID = matchCfg[1].PreTaskId
      if taskID then
        local questModule = GameGlobal.GetModule(QuestModule)
        local quest = questModule:GetQuest(taskID)
        if quest then
          local res = quest:Status()
          eventFinish = res == QuestStatus.QUEST_Completed or res == QuestStatus.QUEST_Taken
        end
      end
    end
    if matchCfg and eventFinish then
      local lData = {}
      lData.type = self.InteractType_FishMatch
      local match = HomelandFishMatchManager:GetInstance():GetMatchItem(matchCfg[1], self._pet, false)
      lData.match = match
      lData.id = match:GetChatID()
      lData.isSec = self._pet:GetMatchChatID()
      if lData.isSec then
        lData.id = lData.isSec
        table.clear(self._datas)
        table.insert(self._datas, lData)
        lData = {}
        lData.match = match
        lData.type = self.InteractType_FishMatchCancel
        lData.id = match:GetCancelChatID()
        table.insert(self._datas, lData)
        lData = {}
        lData.match = match
        lData.type = self.InteractType_FishMatchBye
        lData.id = 1
        table.insert(self._datas, lData)
        return
      end
      table.insert(self._datas, lData)
    end
    if self._homelandModule:CheckFunctionUnlock(HomelandUnlockType.E_HOMELAND_UNLOCK_FOLLOW_UI) and not storyid and not self._pet:IsOccupied() then
      local lData = {}
      lData.type = self.InteractType_Follow
      lData.id = 1
      table.insert(self._datas, lData)
    end
    do
      local lData = {}
      lData.type = self.InteractType_Byebye
      lData.id = 1
      table.insert(self._datas, lData)
    end
    self:ShowHallo(cfg.EnterTalk, cfg.Face)
  else
    if EDITOR then
      Log.exception("###[UIHomePetInteract] cfg_home_pet_interact家园交互表未配置该光灵,光灵ID【,", petid, ",】")
    end
    self:CloseDialog()
    Log.error("###[UIHomePetInteract] cfg_home_pet_interact is nil ! id --> ", petid, "| self --> ", _self)
  end
end

function UIHomePetInteract:CreateNpcInteractData()
  self._taskChooseId = nil
  self._canGameStart = false
  local petid = self._pet:PetID()
  local task = self._pet:GetTask()
  if not task then
    return
  end
  local matchCfg = Cfg.cfg_homeland_fishmatch_main({})
  local cfg = matchCfg[task:GetGameFinish()]
  if cfg then
    self._taskChooseId = cfg.TaskChooseId
    
    function self._callback()
      if not self._canGameStart then
        return
      end
      local match = HomelandFishMatchManager:GetInstance():GetMatchItem(cfg, self._pet, true)
      HomelandFishMatchManager:GetInstance():ChangeMatch(match)
      self._commonStoryPlaying = HomePetInteractState.EndInteract
      match:StartMatchTalkCallBack()
      match:EndTalkCallback()
      self._canGameStart = false
    end
  end
end

function UIHomePetInteract:ShowHallo(str, face)
  if str then
    self:ActiveEndFlag(false)
    self:ShowPetTalk()
    self._breakTextDoing = true
    self._breakText = self._petTalkTex_Break
    self._petTalkTex_Break:SetText(self:CheckPlayerName(StringTable.Get(str)), function(pos, offset)
      self._breakTextDoing = false
      self:ActiveEndFlag(true, pos, offset)
    end)
    local name = self._pet:PetName()
    self._speakerName1:SetText(name)
    self._body:LoadImage(self:GetBody(face))
  end
end

function UIHomePetInteract:ActiveEndFlag(active, pos, offset)
  self._endFlag:SetActive(active)
end

function UIHomePetInteract:CheckPlayerName(str)
  local name = self._roleModule:GetName()
  str = string.gsub(str, "PlayerName", name)
  return str
end

function UIHomePetInteract:InitBtns()
  self._petLastFace = nil
  self._bgCanClick = false
  self:ActiveChoose(true)
  local count = #self._datas
  if count == 0 then
    return
  end
  self._pool:SpawnObjects("UIHomeStoryChooseItem", count)
  self._pools = self._pool:GetAllSpawnList()
  for i = 1, #self._pools do
    local btn = self._pools[i]
    if count >= i then
      btn:Active(true)
      local lData = self._datas[i]
      local lType = lData.type
      local title, chatIcon
      local showType = false
      local isShowNew = false
      if lType == self.InteractType_Story then
        local storyid = lData.id
        local cfg_event = Cfg.cfg_homeland_event[storyid]
        local chatid = cfg_event.ChatID
        local cfg = self:GetChatCfg(chatid)
        title = StringTable.Get(cfg.Title)
        chatIcon = cfg.Icon
        showType = true
      elseif lType == self.InteractType_Follow then
        title = StringTable.Get("str_homeland_pet_interact_follow")
      elseif lType == self.InteractType_Byebye then
        title = StringTable.Get("str_homeland_pet_interact_close")
      elseif lType == self.InteractType_HideChat then
        local cfg = self:GetChatCfg(lData.id)
        title = StringTable.Get(cfg.Title)
        chatIcon = cfg.Icon
        local newStatus = self._homelandModule:HideDialogNew(self._pet:TemplateID())
        btn:SetNewStatus(newStatus)
        isShowNew = true
      elseif lType == self.InteractType_RareFish then
        local rareFishing = lData.rareFishing
        title = rareFishing:GetInteractTitle()
        chatIcon = rareFishing:GetInteractIcon()
      elseif lType == self.InteractType_PetFish then
        local rareFishing = lData.rareFishing
        title = rareFishing:GetInteractTitle()
        chatIcon = rareFishing:GetInteractIcon()
      elseif lType == self.InteractType_DescribeFishGameRule then
        local cfg = self:GetChatCfg(lData.id)
        title = StringTable.Get(cfg.Title)
        chatIcon = cfg.Icon
      elseif lType == self.InteractType_FishMatch then
        local cfg = self:GetChatCfg(lData.id)
        chatIcon = cfg.Icon
        local match = lData.match
        if lData.isSec then
          title = StringTable.Get(match:GetFishMatchPlayInteractTitle())
        else
          title = StringTable.Get(match:GetFishMatchInteractTitle())
        end
      elseif lType == self.InteractType_FishMatchCancel then
        local match = lData.match
        title = StringTable.Get(match:GetCancelFishMatchInteractTitle())
      elseif lType == self.InteractType_FishMatchBye then
        local match = lData.match
        title = StringTable.Get(match:GetByeFishMatchInteractTitle())
      else
        local chatid = lData.id
        local cfg = self:GetChatCfg(chatid)
        title = StringTable.Get(cfg.Title)
        chatIcon = cfg.Icon
      end
      local txt = title
      if isShowNew then
        btn:SetData(i, txt, function(idx)
          self._homelandModule:OnOpenHideDialog(self._pet:TemplateID())
          self:ItemClick(idx)
        end, showType)
        btn:ShowChatIcon(chatIcon ~= nil, chatIcon)
      else
        btn:SetData(i, txt, function(idx)
          self:ItemClick(idx)
        end, showType)
        btn:ShowChatIcon(chatIcon ~= nil, chatIcon)
      end
    else
      btn:Active(false)
    end
  end
  self._poolRect.anchoredPosition = Vector2(self._poolRect.anchoredPosition.x, 0)
end

function UIHomePetInteract:ActiveChoose(active)
  self._chooseGo:SetActive(active)
end

function UIHomePetInteract:ItemClick(idx)
  self._fishing_position = nil
  self._rareFishing = nil
  self._petFishing = nil
  local lData = self._datas[idx]
  local chatid = lData.id
  if lData.type == self.InteractType_Story then
    self._dialogRecord = {}
    self._cfg_event = Cfg.cfg_homeland_event[chatid]
    if not self._cfg_event then
      Log.error("###[UIHomePetInteract] _cfg_event is nil ! id --> ", chatid)
      return
    end
    local type = self._cfg_event.Type
    if type == 1 then
      self._myTalkTex_Break:SetActive(true)
      self._petTalkTex_Break:SetActive(true)
      self:StartDefaultStory(chatid)
    elseif type == 2 then
      CutsceneManager.ExcuteCutsceneIn(UIStateType.UIHomeStoryController, function()
        self:SwitchState(UIStateType.UIHomeStoryController, chatid)
      end)
    end
    self._following = true
  elseif lData.type == self.InteractType_Byebye then
    self._following = false
    self._commonStoryPlaying = HomePetInteractState.EndInteract
  elseif lData.type == self.InteractType_Follow then
    self:btnFollowClick()
  elseif lData.type == self.InteractType_HideChat then
    self._myTalkTex_Break:SetActive(true)
    self._petTalkTex_Break:SetActive(true)
    local eventid = lData.event_id
    self._dialogRecord = {}
    self._cfg_event = Cfg.cfg_homeland_event[eventid]
    self:StartDefaultStory(eventid)
  elseif lData.type == self.InteractType_RareFish then
    local rareFishing = lData.rareFishing
    self._rareFishing = rareFishing
    local fishingState = rareFishing:GetCurrentState()
    local chatId
    if fishingState == rareFishing.Fishing_Submit then
      self:RareFishingSubmitClick()
    elseif fishingState == rareFishing.Fishing_Fishing then
      self._rareFishing = nil
      chatId = Cfg.cfg_homeland_global.RareFishingFishingChatID.IntValue
    elseif fishingState == rareFishing.Fishing_Limit then
      self._rareFishing = nil
      chatId = Cfg.cfg_homeland_global.RareFishingLimitChatID.IntValue
    else
      local rareCfg = rareFishing:GetRareCfg()
      chatId = rareCfg.ChatID
    end
    if chatId ~= nil then
      self._myTalkTex_Break:SetActive(true)
      self._petTalkTex_Break:SetActive(true)
      self:ActiveChoose(false)
      self:CreateTalks(chatId)
      self:ShowTalk()
    end
  elseif lData.type == self.InteractType_PetFish then
    local petid = self._pet:TemplateID()
    local rareFishing = lData.rareFishing
    self._petFishing = rareFishing
    local fishingState = rareFishing:GetCurrentState()
    local chatId
    local rareCfgs = Cfg.cfg_homeland_rare_clue
    local homeModule = GameGlobal.GetModule(HomelandModule)
    local allFishingClue = homeModule:GetAllRareFishingClue()
    local rareCfg = rareFishing:GetRareCfg()
    if allFishingClue == 0 then
      chatId = rareCfg.ChatID
    else
      for k, v in pairs(allFishingClue) do
        if v.rare_fishing_position ~= 0 then
          self._fishingPosition = v.rare_fishing_position
          local type = rareCfgs[k]
          if type.type == 2 and type.PetID == petid then
            self._petfishClue = k
            break
          end
        end
      end
      if self._petfishClue == nil then
        chatId = rareCfg.ChatID
      else
        local data = rareCfgs({
          ID = self._petfishClue
        })
        for _, rareFishClue in pairs(data) do
          local fishType = rareFishClue.type
          if fishType == 2 and self._petfishClue ~= nil then
            if fishingState == rareFishing.Fishing_Fishing then
              self._rareFishing = nil
              chatId = rareCfgs[self._petfishClue].HavePositionChatId
            elseif fishingState == rareFishing.Fishing_Chat then
              chatId = rareCfg.ChatID
            end
          else
            chatId = rareCfg.ChatID
          end
        end
      end
    end
    if chatId ~= nil then
      self._myTalkTex_Break:SetActive(true)
      self._petTalkTex_Break:SetActive(true)
      self:ActiveChoose(false)
      self:CreateTalks(chatId)
      self:ShowTalk()
    end
  elseif lData.type == self.InteractType_DescribeFishGameRule then
    local rareFishing = lData.rareFishing
    self._petFishing = rareFishing
    local chatId
    chatId = lData.id
    self._myTalkTex_Break:SetActive(true)
    self._petTalkTex_Break:SetActive(true)
    self:ActiveChoose(false)
    self:CreateTalks(chatId)
    self:ShowTalk()
  elseif lData.type == self.InteractType_FishMatch then
    local chatId = lData.id
    
    function self._talkCallback()
      self._commonStoryPlaying = HomePetInteractState.EndInteract
      if lData.isSec then
        self._backBehavior = HomelandPetBehaviorType.FishingMatch
        lData.match:StartMatchTalkCallBack()
      else
        HomelandFishMatchManager:GetInstance():ChangeMatch(lData.match)
        self._pet:SetOccupied(HomelandPetOccupiedType.FishingMatch)
        self._backBehavior = HomelandPetBehaviorType.FishingPrepare
        lData.match:EndTalkCallback()
      end
    end
    
    if chatId ~= nil then
      self._myTalkTex_Break:SetActive(true)
      self._petTalkTex_Break:SetActive(true)
      self:ActiveChoose(false)
      self:CreateTalks(chatId)
      self:ShowTalk()
    end
  elseif lData.type == self.InteractType_FishMatchCancel then
    local chatId = lData.id
    if chatId ~= nil then
      self._myTalkTex_Break:SetActive(true)
      self._petTalkTex_Break:SetActive(true)
      self:ActiveChoose(false)
      self:CreateTalks(chatId)
      self:ShowTalk()
    end
    
    function self._talkCallback()
      self._commonStoryPlaying = HomePetInteractState.EndInteract
      lData.match:PetMatchCancel()
      self._backBehavior = 0
      HomelandFishMatchManager:GetInstance():Dispose()
    end
  elseif lData.type == self.InteractType_FishMatchBye then
    self._commonStoryPlaying = HomePetInteractState.EndInteract
    self._backBehavior = HomelandPetBehaviorType.FishingPrepare
  else
    self._myTalkTex_Break:SetActive(true)
    self._petTalkTex_Break:SetActive(true)
    self:ActiveChoose(false)
    self:CreateTalks(chatid)
    self:ShowTalk()
  end
end

function UIHomePetInteract:ReplyPetOldBe()
  local pstid = self._pet:PstID()
  local templateID = self._pet:TemplateID()
  local behavior = self._pet:GetPetBehavior()
  local curBehavior = behavior:GetCurBehavior()
  local beforeBehaviorType = self._pet:GetBeforeTalkBahaviorType()
  local cfg = Cfg.cfg_homeland_pet_behavior_lib({
    TemplateID = templateID,
    BehaviorType = curBehavior:GetBehaviorType()
  })
  cfg = cfg or Cfg.cfg_homeland_pet_behavior_lib({
    TemplateID = 0,
    BehaviorType = curBehavior:GetBehaviorType()
  })
  if cfg and self._homelandClient:GetHomelandPetInviteManager():CheckUIHomelandPetInteract(self._pet) then
    local eventMgr = self._homelandClient:HomeEventManager()
    local oldBebaviorType = eventMgr:GetReplyType(pstid)
    local building = self._homelandClient:GetHomelandPetInviteManager():GetUIHomelandPetInteract()
    if oldBebaviorType and building then
      behavior:ChangeBehavior(oldBebaviorType, building, true)
      local triggerSuccParam = curBehavior:GetTriggerSuccParam()
      if triggerSuccParam then
        curBehavior:TriggerSucc(table.unpack(triggerSuccParam))
      end
      return
    end
  end
  if cfg and not cfg[1].NextBehaviorType then
    local eventMgr = self._homelandClient:HomeEventManager()
    local oldBebaviorType = eventMgr:GetReplyType(pstid)
    if oldBebaviorType then
      behavior:ChangeBehavior(oldBebaviorType, nil, true)
      local triggerSuccParam = curBehavior:GetTriggerSuccParam()
      if triggerSuccParam then
        curBehavior:TriggerSucc(table.unpack(triggerSuccParam))
      end
      return
    end
  end
  if beforeBehaviorType == HomelandPetBehaviorType.InteractingFurniture or HomelandPetBehaviorType.StoryWaitingBuild or HomelandPetBehaviorType.StoryWaitingBuildStand or HomelandPetBehaviorType.StoryWaitingStand or HomelandPetBehaviorType.StoryWaitingWalk then
    behavior:RecoverBehaviorToLast()
  else
    behavior:RandomBehavior()
  end
end

function UIHomePetInteract:CreateTalks(chatid)
  self._currentChatID = chatid
  local cfg = self:GetChatCfg(chatid)
  self._startTalk = cfg.StartTalk
  self._myTalkGo:SetActive(false)
  self._petTalkGo:SetActive(false)
  self._endFlag:SetActive(false)
end

function UIHomePetInteract:GetTalkCfg(talkid)
  local cfg_talk = Cfg.cfg_home_pet_talk[talkid]
  if not cfg_talk then
    Log.error("###[UIHomePetInteract] cfg_talk is nil ! id --> ", talkid)
  end
  return cfg_talk
end

function UIHomePetInteract:GetChatCfg(chatid)
  local cfg_chat = Cfg.cfg_home_pet_chat[chatid]
  if not cfg_chat then
    Log.error("###[UIHomePetInteract] cfg_chat is nil ! id --> ", chatid)
  end
  return cfg_chat
end

function UIHomePetInteract:CheckLastTalk()
end

function UIHomePetInteract:ShowMyTalk(withoutContent)
  self._choose = false
  if not withoutContent then
    self._myTalkGo:SetActive(true)
    self._petTalkGo:SetActive(false)
  end
end

function UIHomePetInteract:ShowPetTalk()
  self._petTalkGo:SetActive(true)
  self._myTalkGo:SetActive(false)
end

function UIHomePetInteract:RefreshMyTalk(withoutContent)
  local cfg = self:GetTalkCfg(self._myTalk)
  self:ActiveEndFlag(false)
  local time = 0
  local name = ""
  if cfg.SpeakerName then
    name = StringTable.Get(name)
  else
    name = self._roleModule:GetName()
  end
  local tex = StringTable.Get(cfg.ChatWord)
  if self._checkItem ~= nil then
    local count = self:_GetItemInfo(self._checkItem)
    if count < self._checkItemCount then
      count = string.format("<color=#ff0000>%s</color>", count)
    end
    tex = StringTable.Get(cfg.ChatWord, count, self._checkItemCount)
  end
  if not withoutContent then
    self._speakerName2:SetText(name)
    self._breakTextDoing = true
    self._breakText = self._myTalkTex_Break
    local _time = self._myTalkTex_Break:SetText(self:CheckPlayerName(tex), function(pos, offset)
      self._breakTextDoing = false
      self:ActiveEndFlag(true, pos, offset)
    end)
    if _time and time < _time then
      time = _time
    end
  end
  local time1 = self:RefreshMyAnim(cfg.PlayerAnim)
  if time1 and time < time1 then
    time = time1
  end
  local time2 = self:RefreshMyAudio(cfg.Audio)
  if time2 and time < time2 then
    time = time2
  end
  local time3 = self:RefreshMyBubble(cfg.PlayerBubble)
  if time3 and time < time3 then
    time = time3
  end
  local time4 = self:RefreshPetBubble(cfg.PetBubble)
  if time4 and time < time4 then
    time = time4
  end
  local time5 = self:RefreshPetAnim(cfg.PetAnim)
  if time5 and time < time5 then
    time = time5
  end
  self._reviewSpeakerName = name
  self._reviewSpeakerContent = self:CheckPlayerName(tex)
  self._reviewSpeakerIcon = nil
  self._isPlayer = true
  return time
end

local homeStoryAnimationTime = {
  idle = 2000,
  walk = 1200,
  move = 800,
  talk = 2833,
  awkward = 2500,
  happy = 2000,
  surprise = 2000,
  think = 3367,
  sigh = 3167,
  fail = 2067
}

function UIHomePetInteract:_GetAnimationTime(anim)
  local time = homeStoryAnimationTime[anim] or 0
  return time
end

function UIHomePetInteract:RefreshMyAnim(anim)
  if anim then
    local animName = anim[1]
    local animLoop = anim[2]
    local character = self._homelandClient:CharacterManager():MainCharacterController()
    character:PlayAnimAndReturnTime(animName)
    local time = self:_GetAnimationTime(animName)
    if animLoop then
    else
      if self._myAnimEvent then
        GameGlobal.Timer():CancelEvent(self._myAnimEvent)
        self._myAnimEvent = nil
      end
      self._myAnimEvent = GameGlobal.Timer():AddEvent(time - 100, function()
        local character = self._homelandClient:CharacterManager():MainCharacterController()
        character:PlayAnimAndReturnTime("idle")
      end)
    end
    return time
  end
end

function UIHomePetInteract:RefreshMyAudio(audioid)
  local time = 0
  if audioid then
    AudioHelperController.RequestAndPlayUIVoiceAutoRelease(audioid)
  end
  return time
end

function UIHomePetInteract:RefreshMyBubble(bubble)
  if bubble then
    local character = self._homelandClient:CharacterManager():MainCharacterController()
    local time = character:PlayBubble(bubble)
    self:PlayBubbleAudio(bubble)
    return time
  end
end

function UIHomePetInteract:PlayBubbleAudio(bubble)
  local cfg = Cfg.cfg_home_pet_bubble[bubble]
  if cfg then
    local audio = cfg.Audio
    if audio ~= nil and 0 < audio then
      AudioHelperController.RequestAndPlayUIVoiceAutoRelease(audio)
    elseif audio == nil or audio == 0 then
      AudioHelperController.RequestAndPlayUIVoiceAutoRelease(CriAudioIDConst.HomelandAudioBubble)
    end
  end
end

function UIHomePetInteract:RefreshPetFace(face)
  local time = 0
  local icon = self:GetBody(face)
  self._body:LoadImage(icon)
  return time
end

function UIHomePetInteract:RefreshPetAnim(anim)
  if anim then
    local animName = anim[1]
    local animLoop = anim[2]
    local time = self._pet:PlayAnimAndReturnTime(animName)
    if animLoop then
    else
      if self._petAnimEvent then
        GameGlobal.Timer():CancelEvent(self._petAnimEvent)
        self._petAnimEvent = nil
      end
      self._petAnimEvent = GameGlobal.Timer():AddEvent(time * 1000 - 100, function()
        self._pet:PlayAnimAndReturnTime(self._idleAnimName)
      end)
    end
    return time * 1000
  end
end

function UIHomePetInteract:RefreshPetAudio(audioid)
  local time = 0
  if audioid then
    AudioHelperController.RequestAndPlayUIVoiceAutoRelease(audioid)
  end
  return time
end

function UIHomePetInteract:RefreshPetBubble(bubble)
  if bubble then
    local time = self._pet:PlayBubble(bubble)
    self:PlayBubbleAudio(bubble)
    return time
  end
end

function UIHomePetInteract:RefreshPetTalk()
  local cfg = self:GetTalkCfg(self._petTalk)
  local tex = StringTable.Get(cfg.ChatWord)
  local name = ""
  if cfg.SpeakerName then
    name = StringTable.Get(cfg.SpeakerName)
  else
    name = self._pet:PetName()
  end
  self._speakerName1:SetText(name)
  local time = 0
  self:ActiveEndFlag(false)
  self._breakTextDoing = true
  self._breakText = self._petTalkTex_Break
  local time5 = self._petTalkTex_Break:SetText(self:CheckPlayerName(tex), function(pos, offset)
    self._breakTextDoing = false
    self:ActiveEndFlag(true, pos, offset)
  end)
  if time5 and time < time5 then
    time = time5
  end
  local time1 = self:RefreshPetFace(cfg.Face)
  if time1 and time < time1 then
    time = time1
  end
  local time2 = self:RefreshPetAnim(cfg.PetAnim)
  if time2 and time < time2 then
    time = time2
  end
  local time3 = self:RefreshPetAudio(cfg.Audio)
  if time3 and time < time3 then
    time = time3
  end
  local time4 = self:RefreshPetBubble(cfg.PetBubble)
  if time4 and time < time4 then
    time = time4
  end
  local time5 = self:RefreshMyBubble(cfg.PlayerBubble)
  if time5 and time < time5 then
    time = time5
  end
  local time6 = self:RefreshMyAnim(cfg.PlayerAnim)
  if time6 and time < time6 then
    time = time6
  end
  self._reviewSpeakerName = name
  self._reviewSpeakerContent = self:CheckPlayerName(tex)
  local icon = self:GetBody(cfg.Face)
  self._reviewSpeakerIcon = icon
  return time
end

function UIHomePetInteract:ShowRareSubmit()
  local count = 2
  local btnSubmit, btnByebye
  self._pool:SpawnObjects("UIHomeStoryChooseItem", count)
  self._pools = self._pool:GetAllSpawnList()
  for i = 1, #self._pools do
    local btn = self._pools[i]
    if i == 1 then
      btnSubmit = btn
      btn:Active(true)
    elseif i == 2 then
      btnByebye = btn
      btn:Active(true)
    else
      btn:Active(false)
    end
  end
  local title = self._rareFishing:GetSubmitTitle()
  btnSubmit:SetData(1, title, function(idx)
    self:RareFishingSubmitClick()
  end)
  btnSubmit:ShowChatIcon(true, self._rareFishing:GetInteractIcon())
  local title = StringTable.Get("str_homeland_pet_interact_close")
  btnByebye:SetData(2, title, function(idx)
    self._following = false
    self._commonStoryPlaying = HomePetInteractState.EndInteract
  end)
  btnByebye:ShowChatIcon(false, nil)
  self._poolRect.anchoredPosition = Vector2(self._poolRect.anchoredPosition.x, 0)
  self._rareFishing:FinishClueChat()
end

function UIHomePetInteract:RareFishingSubmitClick()
  local submitId = self._rareFishing:SubmitAssetId()
  local submitCount = self._rareFishing:SubmitAssetCount()
  local haveCount = GameGlobal.GetModule(ItemModule):GetItemCount(submitId)
  if submitCount <= haveCount then
    self._rareFishing:OnSubmitAssetClick()
    self._following = false
    self._commonStoryPlaying = HomePetInteractState.EndInteract
  end
end

function UIHomePetInteract:ShowChoose()
  local count = #self._chooseTalk
  self._pool:SpawnObjects("UIHomeStoryChooseItem", count)
  self._pools = self._pool:GetAllSpawnList()
  for i = 1, #self._pools do
    local btn = self._pools[i]
    if count >= i then
      btn:Active(true)
      local talkid = self._chooseTalk[i]
      local txt
      local cfg = self:GetTalkCfg(talkid)
      local haveCount, submitCount, petFishClue
      local rareCfgs = Cfg.cfg_homeland_rare_clue
      local data = rareCfgs({TalkId = talkid})
      if cfg.Title then
        txt = StringTable.Get(cfg.Title)
      else
        txt = StringTable.Get(cfg.ChatWord)
        if self._petFishing ~= nil or data ~= nil then
          txt, haveCount, submitCount, petFishClue = self._petFishing:GetFishIdTitle(talkid, txt, cfg.ChatWord)
        end
        btn:ShowChatIcon(false, nil)
      end
      if self._checkItem ~= nil then
        local count = self:_GetItemInfo(self._checkItem)
        if count < self._checkItemCount then
          count = string.format("<color=#ff0000>%s</color>", count)
        end
        txt = StringTable.Get(cfg.ChatWord, count, self._checkItemCount)
      end
      btn:SetData(i, txt, function(idx, leftCount, rightCount, petFishClue)
        if self._checkItem ~= nil then
          local count = self:_GetItemInfo(self._checkItem)
          if count < self._checkItemCount and self._chooseTalk[i] == self._checkTalkId then
            return
          end
        end
        self:ChooseClick(idx, leftCount, rightCount, petFishClue)
      end, nil, haveCount, submitCount, petFishClue)
    else
      btn:Active(false)
    end
  end
  self._poolRect.anchoredPosition = Vector2(self._poolRect.anchoredPosition.x, 0)
end

function UIHomePetInteract:ChooseClick(idx, leftCount, rightCount, petFishClue)
  self._myTalk = self._chooseTalk[idx]
  if leftCount and rightCount and leftCount < rightCount then
    return
  end
  if self._taskChooseId and not self._canGameStart then
    self._canGameStart = self._myTalk == self._taskChooseId
  end
  if petFishClue ~= nil then
    self._petFishing:PetFishingSubmitAsset(petFishClue)
  end
  self._me = true
  local withoutContent = true
  self:ActiveChoose(false)
  self:ShowMyTalk(withoutContent)
  local time = self:RefreshMyTalk(withoutContent)
  if self._checkChatId and self._checkTalkId and self._targetChatID == self._checkChatId and self._checkTalkId == self._myTalk then
    if self._checkItem ~= nil then
      local count = self:_GetItemInfo(self._checkItem)
      if count >= self._checkItemCount then
        GameGlobal.EventDispatcher():Dispatch(GameEventType.OnTalkCheck, self._checkNpcId, self._checkChatId, self._checkTalkId)
      end
    else
      GameGlobal.EventDispatcher():Dispatch(GameEventType.OnTalkCheck, self._checkNpcId, self._checkChatId, self._checkTalkId)
    end
  end
  if withoutContent then
    if time and 0 < time then
      if self._bgEvent then
        GameGlobal.Timer():CancelEvent(self._bgEvent)
        self._bgEvent = nil
      end
      self._bgEvent = GameGlobal.Timer():AddEvent(time, function()
        self:bgOnClick()
      end)
    else
      self:bgOnClick()
    end
  else
    self:ActiveClickBg(true, time)
  end
end

function UIHomePetInteract:ActiveClickBg(active, yieldTime)
  if active then
    if yieldTime and 0 < yieldTime then
      self._bgCanClick = false
      if self._bgEvent then
        GameGlobal.Timer():CancelEvent(self._bgEvent)
        self._bgEvent = nil
      end
      self._bgEvent = GameGlobal.Timer():AddEvent(yieldTime, function()
        self._bgCanClick = true
      end)
    else
      self._bgCanClick = true
    end
  else
    self._bgCanClick = false
  end
end

function UIHomePetInteract:ShowTalk()
  self._cfg_talk = self:GetTalkCfg(self._startTalk[1])
  self._me = self._cfg_talk.IsMainActorWord ~= nil
  self._reviewSpeakerName = nil
  self._reviewSpeakerContent = nil
  self._reviewSpeakerIcon = nil
  self._isPlayer = false
  local yieldTime
  if self._me then
    self._myTalk = self._startTalk[1]
    self:ShowMyTalk()
    yieldTime = self:RefreshMyTalk()
    self:ActiveClickBg(true, yieldTime)
  else
    self._petTalk = self._startTalk[1]
    self:ShowPetTalk()
    yieldTime = self:RefreshPetTalk()
    self:ActiveClickBg(true, yieldTime)
  end
  if self._checkChatId and self._checkTalkId and self._targetChatID == self._checkChatId and self._checkTalkId == self._startTalk[1] then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnTalkCheck, self._checkNpcId, self._checkChatId, self._checkTalkId)
  end
  self:AutoBgOnClick(yieldTime)
end

function UIHomePetInteract:AutoBgOnClick(yieldTime)
  if not self._auto or self._choose then
  else
    if self._event then
      GameGlobal.Timer():CancelEvent(self._event)
      self._event = nil
    end
    local yTime = 0
    if yieldTime then
      yTime = yieldTime + self._autoYieldTime
    end
    self._event = GameGlobal.Timer():AddEvent(yTime, function()
      self:bgOnClick()
    end)
  end
end

function UIHomePetInteract:AddDialogRecord(speaker, content, speakerBG, isPlayer)
  if speaker then
    self._dialogRecord[#self._dialogRecord + 1] = {
      speaker,
      content,
      speakerBG,
      isPlayer
    }
  end
end

function UIHomePetInteract:bgOnClick()
  if self._breakTextDoing then
    self._breakTextDoing = false
    self._breakText:Stop()
    return
  end
  local cfg
  if self._me then
    cfg = self:GetTalkCfg(self._myTalk)
  else
    cfg = self:GetTalkCfg(self._petTalk)
  end
  if cfg.LastTalk and self._rareFishing ~= nil then
    self:ActiveChoose(true)
    self:ShowRareSubmit()
    self:ActiveClickBg(false)
  elseif cfg.LastTalk and self._petFishing ~= nil then
    self._commonStoryPlaying = HomePetInteractState.EndInteract
  elseif cfg.LastTalk then
    self._myTalkGo:SetActive(false)
    self._petTalkGo:SetActive(false)
    self._endFlag:SetActive(false)
    self._bgCanClick = false
    if self._currentStoryID then
      if self._targetChatID then
        self._commonStoryPlaying = HomePetInteractState.EndInteract
        if self._callback then
          self._callback()
        end
        return
      else
        self:StopDefaultStory()
      end
    else
      self:InitBtns()
    end
    if self._talkCallback then
      self._talkCallback()
    end
  end
  if cfg.LastTalk then
    local chaitd = self._currentChatID
    local petid = self._pet:TemplateID()
    Log.debug("###[UIHomePetInteract] petid[", petid, "] complete chaitd[", chaitd, "]")
    local module = GameGlobal.GetModule(HomelandModule)
    module:PushFinishHomeChatId(petid, chaitd)
  else
    if self._currentStoryID and not self._choose then
      self:AddDialogRecord(self._reviewSpeakerName, self._reviewSpeakerContent, self._isPlayer, self._reviewSpeakerIcon)
    end
    if cfg.ShowChoose then
      self._chooseTalk = cfg.AnswerID
      self:ActiveChoose(true)
      self:ShowChoose()
      self:ActiveClickBg(false)
    else
      if cfg.NextWord then
        self._startTalk = cfg.NextWord
      else
        self._startTalk = cfg.AnswerID
        Log.error("###[UIHomePetInteract] 没有选项，但是也没有NextWord,talk-->", cfg.ID)
      end
      self:ShowTalk()
    end
  end
end

function UIHomePetInteract:btnFollowClick()
  local petMgr = self._homelandClient:PetManager()
  if petMgr:FollowFull() then
    ToastManager.ShowHomeToast(StringTable.Get("str_homeland_interact_follow_max_tips"))
  elseif petMgr:RoleAndPetSeparatedBySwimPool(self._pet) then
    ToastManager.ShowHomeToast(StringTable.Get("str_homeland_invite_unable"))
  else
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnHomeInteractFollow, true, self._pet)
    self._following = true
    self._commonStoryPlaying = HomePetInteractState.EndInteract
  end
end

function UIHomePetInteract:OnHide()
  if self._hasNewFishingPosition then
  end
  if self._event then
    GameGlobal.Timer():CancelEvent(self._event)
    self._event = nil
  end
  if self._myAnimEvent then
    GameGlobal.Timer():CancelEvent(self._myAnimEvent)
    self._myAnimEvent = nil
  end
  if self._petAnimEvent then
    GameGlobal.Timer():CancelEvent(self._petAnimEvent)
    self._petAnimEvent = nil
  end
  self:UnLock("UIHomePetInteract:_MoveCamera")
  self:UnLock("UIHomePetInteract:_MoveCamera_End")
  self:UnLock("UIHomePetInteract:StopDefaultStory")
  local homeLandModule = GameGlobal.GetUIModule(HomelandModule)
  local homelandClient = homeLandModule:GetClient()
  if not homelandClient then
    return
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnHomeInteractClose, false)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnHomeMainShowUIRoot, true)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUIHomePetInteract, false)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUIHomePetInteractTaskClose, self._checkNpcId, self._checkChatId, self._checkTalkId)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnHomePetInteractCloseForInivte, self._pet)
  local inputMgr = self._homelandClient:InputManager()
  local charMgr = inputMgr:GetControllerChar()
  charMgr:SetActive(true)
  local character = self._homelandClient:CharacterManager():MainCharacterController()
  character:SetStoryLayer(false)
end

function UIHomePetInteract:GetBody(face)
  if HomelandPet:IsInstanceOfType(self._pet) then
    if face then
      self._petLastFace = face
    end
    local pstid = self._pet:PstID()
    local icon = HelperProxy:GetInstance():HomeGetBody(pstid, self._petLastFace)
    return icon
  elseif HomelandTaskNPC:IsInstanceOfType(self._pet) then
    return self._pet:GetBody(face)
  end
end

function UIHomePetInteract:StopDefaultStory()
  if self._currentStoryID then
    self:Lock("UIHomePetInteract:StopDefaultStory")
    GameGlobal.TaskManager():StartTask(self._OnStopDefaultStory, self)
  else
    self._commonStoryPlaying = HomePetInteractState.EndInteract
  end
end

function UIHomePetInteract:_OnStopDefaultStory(TT)
  local fishingPosition = {}
  self._fishing_position = nil
  local cfg_event = Cfg.cfg_homeland_event[self._currentStoryID]
  if cfg_event then
    self._fishing_position = cfg_event.AppendWishingCoinFishingPosition
  end
  if self._fishing_position then
    local posList = self._homelandModule:GetWishingCoinPostionData()
    if posList then
      for i = 1, #posList do
        fishingPosition[#fishingPosition + 1] = posList[i]
      end
    end
  end
  local res = self._homelandModule:HandleClientFinishEventReq(TT, self._currentStoryID)
  self:UnLock("UIHomePetInteract:StopDefaultStory")
  if res:GetSucc() then
    Log.debug("###[UIHomePetInteract] HandleClientFinishEventReq succ !")
    if self._fishing_position then
      local posList = self._homelandModule:GetWishingCoinPostionData()
      local hasNew = false
      if posList then
        for i = 1, #posList do
          local find = false
          for j = 1, #fishingPosition do
            if fishingPosition[j] == posList[i] then
              find = true
              break
            end
          end
          if not find then
            hasNew = true
            break
          end
        end
      end
      self._hasNewFishingPosition = hasNew
    end
  else
    Log.error("###[UIHomePetInteract] HandleClientFinishEventReq fail !")
  end
  self._commonStoryPlaying = HomePetInteractState.EndInteract
end

function UIHomePetInteract:StartDefaultStory(chatid)
  self._buttonRoot:SetActive(true)
  self._currentStoryID = chatid
  self._commonStoryPlaying = HomePetInteractState.BeginStory
end

function UIHomePetInteract:_Rotate_End()
  if self._petOldRotation then
    local tr = self._pet:AgentTransform()
    local v3 = self._petOldRotation:ToEulerAngles()
    tr:DORotate(v3, self._rotateBodyTime * 0.001, DG.Tweening.RotateMode.Fast)
  end
  self._petOldRotation = nil
end

function UIHomePetInteract:_Rotate(dms)
  if not self._rotate then
    self._rotate = true
    self._rotateTime = self._rotateBodyTime
    self._petOldRotation = self._currentStoryPet:GetRotation()
    self._middle = (self._charaTr.position - self._petTr.position) * 0.5 + self._petTr.position
    local dir2 = self._middle - self._petTr.position
    self._currentPetRot = self._currentStoryPet:GetRotation()
    self._targetPetRot = Quaternion.Euler(Vector3(dir2.x, 0, dir2.z))
    self._charaTr:DOLookAt(Vector3(self._middle.x, self._charaTr.position.y, self._middle.z), self._rotateTime * 0.001):OnComplete(function()
      self._character:SetForward(self._charaTr.forward, true)
    end)
    self._petTr:DOLookAt(Vector3(self._middle.x, self._petTr.position.y, self._middle.z), self._rotateTime * 0.001)
  end
  if self._rotateTime > 0 then
    self._rotateTime = self._rotateTime - dms
  else
    self._rotateTime = 0
  end
end

function UIHomePetInteract:_MoveCamera(dms)
  if not self._cameraPlaying then
    self:Lock("UIHomePetInteract:_MoveCamera")
    self._cameraPlaying = true
    self._moveCameraScreenTime = 0
    self._moveCameraScreenDurn = self._moveCameraTime
    self._ori_xAngle = self._enterXRot
    self._now_xAngle = self._cameraCtl:NowXAngle()
    self._oldZ = self._cameraCtl:CurrentScale()
    self._gaps = self._cameraZPos
    self._horRotInner = self:_CheckTwoDirAngle()
    local focusOffsetY = self._focusOffsetY
    if self._character:IsSwimming() then
      focusOffsetY = 0
    end
    self._focusOffset = Vector3(0, focusOffsetY, 0)
  end
  if self._moveCameraScreenDurn > self._moveCameraScreenTime then
    self._moveCameraScreenTime = self._moveCameraScreenTime + dms
    local middle = self._middle + self._focusOffset
    local _pos = Vector3.Lerp(self._charaTr.position, middle, self._moveCameraScreenTime / self._moveCameraScreenDurn)
    self._cameraCtl:UpdatePos(_pos)
    local xAngle = Mathf.Lerp(self._now_xAngle, self._ori_xAngle, self._moveCameraScreenTime / self._moveCameraScreenDurn)
    self._cameraCtl:SetXRotation(xAngle)
    if not self._horRotInner then
      local rot = Quaternion.Lerp(self._horNowRot, self._horRot, self._moveCameraScreenTime / self._moveCameraScreenDurn)
      self._cameraCtl:SetRotation(rot)
    end
    local gaps = Mathf.Lerp(self._oldZ, self._gaps, self._moveCameraScreenTime / self._moveCameraScreenDurn)
    self._cameraCtl:HandleScaleForStory(gaps)
  else
    self:UnLock("UIHomePetInteract:_MoveCamera")
    self._cameraPlaying = false
    self._commonStoryPlaying = HomePetInteractState.None
  end
end

function UIHomePetInteract:_CheckTwoDirAngle()
  local camRot = self._cameraCtl:Rotation()
  local withYDir1 = camRot * Vector3(0, 0, 1)
  local camDir = Vector3(withYDir1.x, 0, withYDir1.z)
  local withYDir2 = self._petTr.position - self._charaTr.position
  local petDir = Vector3(withYDir2.x, 0, withYDir2.z)
  local angle = Vector3.Angle(petDir, camDir)
  if angle >= self._angleMin and angle <= self._angleMax then
    return true
  else
    local cross = Vector3.Cross(camDir, petDir)
    if angle < self._angleMin then
      local detla = self._angleMin - angle
      if 0 < cross.y then
        self._horRot = Quaternion.AngleAxis(detla, Vector3(0, -1, 0)) * camRot
        self._horNowRot = camRot
      else
        self._horRot = Quaternion.AngleAxis(detla, Vector3(0, 1, 0)) * camRot
        self._horNowRot = camRot
      end
    elseif angle > self._angleMax then
      local detla = self._angleMax - angle
      if 0 < cross.y then
        self._horRot = Quaternion.AngleAxis(detla, Vector3(0, -1, 0)) * camRot
        self._horNowRot = camRot
      else
        self._horRot = Quaternion.AngleAxis(detla, Vector3(0, 1, 0)) * camRot
        self._horNowRot = camRot
      end
    end
    return false
  end
end

function UIHomePetInteract:_MoveCamera_End(dms)
  if not self._cameraPlaying then
    self._cameraPlaying = true
    self:Lock("UIHomePetInteract:_MoveCamera_End")
    self._moveCameraScreenTime = 0
    self._moveCameraScreenDurn = self._moveCameraTime
    self._nowZ = self._cameraCtl:CurrentScale()
    self._gaps = self._oldZ
    self._ori_xAngle = self._overXRot
    self._now_xAngle = self._cameraCtl:NowXAngle()
  end
  if self._moveCameraScreenDurn > self._moveCameraScreenTime then
    self._moveCameraScreenTime = self._moveCameraScreenTime + dms
    local focusOffsetY = self._focusOffsetY
    if self._character:IsSwimming() then
      focusOffsetY = 0
    end
    local middle = self._middle + Vector3(0, focusOffsetY, 0)
    local _pos = Vector3.Lerp(middle, self._charaTr.position, self._moveCameraScreenTime / self._moveCameraScreenDurn)
    self._cameraCtl:UpdatePos(_pos)
    local xAngle = Mathf.Lerp(self._now_xAngle, self._ori_xAngle, self._moveCameraScreenTime / self._moveCameraScreenDurn)
    self._cameraCtl:SetXRotation(xAngle)
    local gaps = Mathf.Lerp(self._nowZ, self._gaps, self._moveCameraScreenTime / self._moveCameraScreenDurn)
    self._cameraCtl:HandleScaleForStory(gaps)
  else
    self._cameraPlaying = false
    self:UnLock("UIHomePetInteract:_MoveCamera_End")
    if self._currentStoryID and not self._targetChatID then
      self._commonStoryPlaying = HomePetInteractState.EndStory
    else
      self._commonStoryPlaying = HomePetInteractState.Close
    end
  end
end

function UIHomePetInteract:OnUpdate(dms)
  if self._myTalkTex_Break then
    self._myTalkTex_Break:Update(dms)
  end
  if self._petTalkTex_Break then
    self._petTalkTex_Break:Update(dms)
  end
  if self._commonStoryPlaying == HomePetInteractState.None then
    if self._targetChatID then
      self._dialogRecord = {}
      self._myTalkTex_Break:SetActive(true)
      self._petTalkTex_Break:SetActive(true)
      self:StartDefaultStory(self._targetChatID)
    end
  elseif self._commonStoryPlaying == HomePetInteractState.BeginInteract then
    self:_Rotate(dms)
    self:_MoveCamera(dms)
  elseif self._commonStoryPlaying == HomePetInteractState.BeginStory then
    self:_PlayStory()
    self._commonStoryPlaying = HomePetInteractState.Storying
  elseif self._commonStoryPlaying == HomePetInteractState.Storying then
  elseif self._commonStoryPlaying == HomePetInteractState.EndInteract then
    self:_Rotate_End(dms)
    self:_MoveCamera_End(dms)
  elseif self._commonStoryPlaying == HomePetInteractState.EndStory then
    if not self._commonStoryGetting then
      self:_GetAwards()
    end
  elseif self._commonStoryPlaying == HomePetInteractState.Close then
    self._commonStoryPlaying = HomePetInteractState.None
    if not self._targetChatID then
      if self._currentStoryID then
        self:_OverStory()
      end
      if self._backBehavior then
        if self._backBehavior == 0 then
          self._backBehavior = nil
        end
        self._pet:GetPetBehavior():StartBehavior(self._backBehavior)
        self._backBehavior = nil
      elseif not self._following then
        self:ReplyPetOldBe()
      end
    end
    self:CloseDialog()
  end
end

function UIHomePetInteract:_OverStory()
  self._homelandClient:HomeEventManager():StopStory(self._currentStoryID)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnHomeStoryFinish, self._currentStoryID)
  self:ShowEndEventTips()
end

function UIHomePetInteract:ShowEndEventTips()
  local cfg = Cfg.cfg_homeland_event[self._currentStoryID]
  if cfg and cfg.EndEventTipTex then
    local face = cfg.EndEventTipIcon or "Norm"
    local pstid = self._currentStoryPet:PstID()
    local icon = HelperProxy:GetInstance():HomeGetBody(pstid, face)
    local tex = ""
    tex = StringTable.Get(cfg.EndEventTipTex)
    local param = {}
    param[1] = icon
    param[2] = tex
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUIHomeEventTips, UIHomeEventTipsType.PetBody, param)
  end
end

function UIHomePetInteract:_GetAwards()
  self._commonStoryGetting = true
  local awards = self._cfg_event.Rewards
  if awards then
    Log.error("###[UIHomePetInteract] 获得奖励 ！")
    local roleAssetList = {}
    for i = 1, #awards do
      local roleAsset = RoleAsset:New()
      roleAsset.assetid = awards[i][1]
      roleAsset.count = awards[i][2]
      table.insert(roleAssetList, roleAsset)
    end
    if 0 < #roleAssetList then
      self:ShowDialog("UIHomeShowAwards", roleAssetList, function()
        self:_OnGetAwards()
      end)
    else
      self:_OnGetAwards()
    end
  else
    self:_OnGetAwards()
  end
end

function UIHomePetInteract:_OnGetAwards()
  self._commonStoryPlaying = HomePetInteractState.Close
  self._commonStoryGetting = false
end

function UIHomePetInteract:_PlayStory()
  local chatidw
  if self._targetChatID then
    chatid = self._targetChatID
  else
    chatid = self._cfg_event.ChatID
  end
  local cfg_chat = Cfg.cfg_home_pet_chat[chatid]
  if not cfg_chat then
    Log.error("###[UIHomePetInteract] cfg is nil ! id --> ", chatid)
    return
  end
  self:ActiveChoose(false)
  self:CreateTalks(chatid)
  self:ShowTalk()
end

function UIHomePetInteract:_GetItemInfo(itemId)
  local itemModule = GameGlobal.GetModule(ItemModule)
  local haveCount = itemModule:GetItemCount(itemId)
  return haveCount
end
