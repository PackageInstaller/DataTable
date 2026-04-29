_class("UIWeChatController", UIController)
UIWeChatController = UIWeChatController

function UIWeChatController:Constructor()
  self._uiMainModule = self:GetUIModule(SignInModule)
  self._roleModule = self:GetModule(RoleModule)
  self:CreateUnLockBGMs()
  self.module = self:GetModule(QuestChatModule)
  self.weChatProxy = self.module:GetWeChatProxy()
  self.speakerId = 0
  self._groupid = 0
  self.roleCell = {}
  self.chatCells = {}
  self.heights = {}
  self.defaultHeight = 875
  self.atlas = self:GetAsset("UIWeChat.spriteatlas", LoadType.SpriteAtlas)
end

function UIWeChatController:CreateUnLockBGMs()
  self._unlockBGMs = {}
  local cfgs = Cfg.cfg_role_music({Tag = 3})
  if cfgs and next(cfgs) then
    for i = 1, #cfgs do
      local cfg = cfgs[i]
      if cfg.LockCondition then
        local condType = cfg.LockCondition[1]
        if condType == ConditionType.CT_QuestChatIsReaded then
          local lock = self._roleModule:UI_CheckMusicLock(cfg)
          if lock then
            table.insert(self._unlockBGMs, cfg.ID)
          end
        end
      end
    end
  end
end

function UIWeChatController:LoadDataOnEnter(TT, res, uiParams)
  self.params = uiParams
  local result = self.module:Request_GetActiveChat(TT)
  if result:GetSucc() then
    res:SetSucc(true)
  else
    res:SetSucc(false)
  end
end

function UIWeChatController:OnShow(uiParams)
  self._ltBtn = self:GetUIComponent("UISelectObjectPath", "ltBtn")
  self._backBtns = self._ltBtn:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    self:CloseDialog()
  end)
  self.roleScrollView = self:GetUIComponent("UIDynamicScrollView", "groupscrollview")
  self.roleScrollView:InitListView(0, function(_groupScrollView, index)
    return self:CreateRoleItem(_groupScrollView, index)
  end)
  self.replyBtnGO = self:GetGameObject("replybtn")
  self.replyRedGO = self:GetGameObject("replyred")
  self.replyBtnIcon = self:GetUIComponent("Image", "replybtn")
  self.msgTex = self:GetUIComponent("UILocalizationText", "txt")
  self.replyBtnBtn = self:GetUIComponent("Button", "replybtn")
  self.replyBtnTxt = self:GetUIComponent("UILocalizationText", "replytxt")
  self.replyMenuGO = self:GetGameObject("replymenu")
  self.replyChooseGO = self:GetGameObject("replychoose")
  self.replyMenuBgGO = self:GetGameObject("menubg")
  self.replyMenuBgGO:SetActive(false)
  self.debugTxt = self:GetUIComponent("UILocalizationText", "debugtxt")
  self.animation = self:GetUIComponent("Animation", "uiAnim")
  self.replyMenuItem = {}
  for index = 1, 3 do
    self.replyMenuItem[index] = {}
    self.replyMenuItem[index].go = self:GetGameObject("replymenubtn" .. index)
    self.replyMenuItem[index].txt = self:GetUIComponent("UILocalizationText", "replymenubtntxt" .. index)
    self.replyMenuItem[index].txt = self:GetUIComponent("UILocalizationText", "replymenubtntxt" .. index)
  end
  self.scrollView = self:GetUIComponent("ScrollRect", "chatscrollview")
  self.sop = self:GetUIComponent("UISelectObjectPath", "Content")
  self.contentRect = self:GetUIComponent("RectTransform", "Content")
  self.layout = self:GetUIComponent("VerticalLayoutGroup", "Content")
  self.replyBgRect = self:GetUIComponent("RectTransform", "replymenu")
  self.replyBtn1Rect = self:GetUIComponent("RectTransform", "replymenubtn1")
  self.replyBtn2Rect = self:GetUIComponent("RectTransform", "replymenubtn2")
  self.replyBtn3Rect = self:GetUIComponent("RectTransform", "replymenubtn3")
  self._affinityWnd = self:GetGameObject("AffinityWnd")
  self._affinityPetHead = self:GetUIComponent("RawImageLoader", "Icon")
  self._petNameTxt = self:GetUIComponent("UILocalizationText", "PetName")
  self._affinityTxt = self:GetUIComponent("UILocalizationText", "Affinity")
  UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.contentRect)
  AudioHelperController.RequestUISound(CriAudioIDConst.WeChatSwitchWindow)
  AudioHelperController.RequestUISound(CriAudioIDConst.WeChatSendMessage)
  AudioHelperController.RequestUISound(CriAudioIDConst.WeChatRecvMessage)
  self:AddListener()
  local gid, sid = self.weChatProxy:GetFirstSpeakerId()
  self:OnClickRoleCell(gid, sid)
  self:RefreshRoleScroll()
end

function UIWeChatController:UI_TestDebug()
  local nSpeakerID = 2100106
  local nChatID = 30302
  local nFindTalkID = 30302001
  local listTalkID = {}
  while 0 < nFindTalkID do
    table.insert(listTalkID, nFindTalkID)
    local pFindTalk = Cfg.cfg_quest_talk[nFindTalkID]
    if nil == pFindTalk then
      break
    end
    nFindTalkID = pFindTalk.NextWord
    if nil == nFindTalkID then
      break
    end
  end
  for i = 1, #listTalkID do
    local nTalkID = listTalkID[i]
    TaskManager:GetInstance():StartTask(function(TT)
      self.module:Request_SetTalkReaded(TT, nSpeakerID, nChatID, nTalkID, i)
    end)
  end
end

function UIWeChatController:OnHide()
  self:StopAudio()
  if GameGlobal:GetInstance().gameLogic then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateWeChatRed)
  end
  AudioHelperController.ReleaseUISoundById(CriAudioIDConst.WeChatSwitchWindow)
  AudioHelperController.ReleaseUISoundById(CriAudioIDConst.WeChatSendMessage)
  AudioHelperController.ReleaseUISoundById(CriAudioIDConst.WeChatRecvMessage)
  if self.weChatProxy then
    self.weChatProxy:CancelSaveData()
  end
end

function UIWeChatController:AddListener()
  self:AttachEvent(GameEventType.WeChatNormalState, self.OnWeChatNormalState)
  self:AttachEvent(GameEventType.WeChatReplyState, self.OnWeChatReplyState)
  self:AttachEvent(GameEventType.WeChatAddAnswerState, self.OnWeChatAddAnswerState)
  self:AttachEvent(GameEventType.WeChatWaitState, self.OnWeChatWaitState)
  self:AttachEvent(GameEventType.WeChatWaitEndState, self.OnWeChatWaitEndState)
  self:AttachEvent(GameEventType.WeChatReaded, self.OnWeChatReaded)
  self:AttachEvent(GameEventType.WeChatChangeName, self.OnWeChatChangeName)
  self:AttachEvent(GameEventType.WeChatUpdateRole, self.OnWeChatUpdateRole)
  self:AttachEvent(GameEventType.WeChatPlayVoice, self.OnWeChatPlayVoice)
  self:AttachEvent(GameEventType.WeChatUpdateLastTime, self.WeChatUpdateLastTime)
  self:AttachEvent(GameEventType.PetDataChangeEvent, self.ObservationRefresh)
end

function UIWeChatController:RefreshRoleScroll(speakerid)
  self.roleCell = {}
  self._groups = self:GetAndSortGroups(speakerid)
  if self:GetModule(GuideModule):IsGuideProcessKey("guide_wechat") then
    local cfg = Cfg.cfg_guide_const.guide_wechat
    local temp
    for i = 1, #self._groups do
      local find = false
      for j = 1, self._groups[i]:RoleCount() do
        if self._groups[i]._roleList[j].speakerId == cfg.ArrayValue[1] then
          find = true
          temp = self._groups[i]
          table.removev(self._groups, self._groups[i])
          break
        end
      end
      if find then
        break
      end
    end
    if temp then
      table.insert(self._groups, 1, temp)
    end
  end
  self.roleScrollView:SetListItemCount(#self._groups, false)
  self.roleScrollView:RefreshAllShownItem()
end

function UIWeChatController:RefreshChatScroll(addOne)
  local talks = self.weChatProxy:GetTalks(self.speakerId)
  local role = self.weChatProxy:GetRole(self.speakerId)
  self:UpdateChatItems(talks, role, addOne)
  self:ChangeBgm(talks)
end

function UIWeChatController:OnClickRoleCell(groupid, speakerId)
  if self.speakerId == speakerId then
    return
  end
  self:SwitchAnim()
  self:Select(groupid, speakerId)
  self:ShowReplyMenuGO(false)
  self.weChatProxy:SendAllTalkReaded(speakerId)
  self.weChatProxy:SetInitState(speakerId, true)
  self.contentRect.anchoredPosition = Vector2.zero
  self:StopAudio()
  AudioHelperController.PlayRequestedUISound(CriAudioIDConst.WeChatSwitchWindow)
end

function UIWeChatController:SwitchAnim()
  self.animation:Play("Uieff_WeChat_Switch")
end

function UIWeChatController:Select(groupid, speakerid, force)
  if not force and self.speakerId == speakerid then
    return
  end
  if self.roleCell[self._groupid] then
    self.roleCell[self._groupid]:Select(false)
  end
  self.weChatProxy:EndCurWaitStat()
  self._groupid = groupid
  self.speakerId = speakerid
  if self.roleCell[self._groupid] then
    self.roleCell[self._groupid]:Select(true)
  end
end

function UIWeChatController:SetChoose(speakerId)
end

function UIWeChatController:OnUpdate(deltaTimeMS)
  if self.mCurVoiceId == nil then
    return
  end
  local isPlaying = AudioHelperController.CheckUIVoicePlaying(self.mCurVoiceId)
  if isPlaying ~= false then
    return
  end
  self.mCurVoiceId = nil
  self:StopVoiceAni()
end

function UIWeChatController:CreateRoleItem(_groupScrollView, _index)
  if _index < 0 then
    return
  end
  _index = _index + 1
  local item = _groupScrollView:NewListViewItem("item")
  local pool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  local widget = pool:SpawnObject("UIWeChatRoleCell")
  local group = self._groups[_index]
  self._tmpHeight = widget:SetData(group, function(weChatRole)
    local groupid = weChatRole:GetGroupId()
    local speakerid = weChatRole:GetSpeakerId()
    self:OnClickRoleCell(groupid, speakerid)
  end, function(weChatRole)
    self:ShowDialog("UIWeChatChangeNameController", weChatRole)
  end, self.speakerId)
  local role = group:CurrentRole()
  self.roleCell[role:GetGroupId()] = widget
  return item
end

function UIWeChatController:RefreshReplyBtn(enable)
  if enable then
    self.replyBtnIcon.sprite = self.atlas:GetSprite("terminal_zhongduan_btn3")
    self.replyBtnTxt.color = Color(0.996078431372549, 0.996078431372549, 0.996078431372549)
    self.msgTex.color = Color(0.996078431372549, 0.996078431372549, 0.996078431372549)
    self.replyBtnIcon.raycastTarget = true
    self.replyBtnBtn.enabled = true
    self:RefreshReplyRed(true)
  else
    self.replyBtnIcon.sprite = self.atlas:GetSprite("terminal_zhongduan_btn4")
    self.replyBtnTxt.color = Color(0.3137254901960784, 0.3137254901960784, 0.3137254901960784)
    self.msgTex.color = Color(0.3137254901960784, 0.3137254901960784, 0.3137254901960784)
    self.replyBtnIcon.raycastTarget = false
    self.replyBtnBtn.enabled = false
    self:RefreshReplyRed(false)
  end
end

function UIWeChatController:RefreshReplyRed(red)
  self.replyRedGO:SetActive(red)
end

function UIWeChatController:ShowReplyMenuGO(show)
  if self.replyMenuGO then
    self.replyMenuGO:SetActive(show)
    self.replyChooseGO:SetActive(show)
    self.replyMenuBgGO:SetActive(show)
    if show then
      UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.replyBgRect)
      UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.replyBtn1Rect)
      UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.replyBtn2Rect)
      UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.replyBtn3Rect)
    end
  end
end

function UIWeChatController:RefreshReplyMenu()
  local talk = self.weChatProxy:GetLastTalk(self.speakerId)
  if not talk.options then
    return
  end
  for index = 1, 3 do
    local option = talk.options[index]
    if option then
      self.replyMenuItem[index].go:SetActive(true)
      self.replyMenuItem[index].txt:SetText(self:_DoEscape(option.txt))
    else
      self.replyMenuItem[index].go:SetActive(false)
    end
  end
end

function UIWeChatController:_DoEscape(strContent)
  if string.isnullorempty(self.roleName) then
    self.roleName = GameGlobal.GetModule(RoleModule):GetName()
  end
  strContent = string.gsub(strContent, "PlayerName", self.roleName)
  return strContent
end

function UIWeChatController:replybtnOnClick(go)
  if self.weChatProxy:GetCurStateType() == WeChatState.Reply then
    self:RefreshReplyMenu()
    self:ShowReplyMenuGO(true)
  end
end

function UIWeChatController:replymenubtn1OnClick(go)
  self:_ReplyMenuBtnOnClick(1)
end

function UIWeChatController:replymenubtn2OnClick(go)
  self:_ReplyMenuBtnOnClick(2)
end

function UIWeChatController:replymenubtn3OnClick(go)
  self:_ReplyMenuBtnOnClick(3)
end

function UIWeChatController:_ReplyMenuBtnOnClick(index)
  AudioHelperController.PlayRequestedUISound(CriAudioIDConst.WeChatSendMessage)
  self:ShowReplyMenuGO(false)
  self.contentRect.anchoredPosition = Vector3.zero
  self.weChatProxy:Reply(self.speakerId, index)
end

function UIWeChatController:menubgOnClick()
  self:ShowReplyMenuGO(false)
end

function UIWeChatController:OnWeChatNormalState(speakerId)
  self:SetDebugText()
  if speakerId ~= self.speakerId then
    return
  end
  for key, roleCell in pairs(self.roleCell) do
    roleCell:SetData(nil, nil, nil, self.speakerId)
  end
  self:RefreshChatScroll()
  self:RefreshReplyBtn(false)
end

function UIWeChatController:OnWeChatReplyState(speakerId)
  self:SetDebugText()
  if speakerId ~= self.speakerId then
    return
  end
  for key, roleCell in pairs(self.roleCell) do
    roleCell:SetData(nil, nil, nil, self.speakerId)
  end
  self:RefreshChatScroll()
  local btnState = true
  local role = self.weChatProxy:GetRole(self.speakerId)
  local chats = role.chats
  local currentChat = chats[#chats]
  local talks = currentChat.talks
  for i = 1, #talks do
    local talk = talks[i]
    if talk.voiceId and not talk.readed then
      btnState = false
      break
    end
  end
  self:RefreshReplyBtn(btnState)
end

function UIWeChatController:OnWeChatAddAnswerState(data)
  self:SetDebugText()
  if data.speakerId ~= self.speakerId then
    Log.error("Find SpeakerID Not Match In UIWeChatController:OnWeChatAddAnswerState : ", "data.speakerId[", data.speakerId, "] ~= self.speakerId[", self.speakerId, "]")
    return
  end
  local groupid = self:GetGroupIDFromSpeakerID(data.speakerId)
  if self.roleCell[groupid] then
    self.roleCell[groupid]:SetData(nil, nil, nil, self.speakerId)
  end
  self:RefreshChatScroll()
  self:Select(groupid, self.speakerId)
end

function UIWeChatController:GetGroupIDFromSpeakerID(sid)
  local cfg_pet = Cfg.cfg_pet[sid]
  if cfg_pet and cfg_pet.BinderPetID then
    return cfg_pet.BinderPetID
  end
  return sid
end

function UIWeChatController:OnWeChatWaitState(data)
  self:SetDebugText()
  if data.speakerId ~= self.speakerId then
    Log.error("Find SpeakerID Not Match In UIWeChatController:OnWeChatWaitState : ", "data.speakerId[", data.speakerId, "] ~= self.speakerId[", self.speakerId, "]")
    return
  end
  self:RefreshReplyBtn(false)
  self:RefreshChatScroll(true)
end

function UIWeChatController:OnWeChatWaitEndState(data, count)
  self:SetDebugText()
  if data.speakerId ~= self.speakerId then
    Log.error("Find SpeakerID Not Match In UIWeChatController:OnWeChatWaitEndState : ", "data.speakerId[", data.speakerId, "] ~= self.speakerId[", self.speakerId, "]")
    return
  end
  local talk = self.weChatProxy:GetTalk(data.speakerId, data.chatId, data.talkId, data.triggerIndex)
  self:UpdateItem(talk)
end

function UIWeChatController:OnWeChatReaded(speakerId, chatId, talkId, triggerIndex)
  if speakerId ~= self.speakerId then
    return
  end
  local groupid = self:GetGroupIDFromSpeakerID(speakerId)
  local roleList = self._groups[groupid]
  if self.roleCell[groupid] then
    self.roleCell[groupid]:SetData(roleList, nil, nil, self.speakerId)
  end
  local talk = self.weChatProxy:GetTalk(speakerId, chatId, talkId, triggerIndex)
  self:UpdateItem(talk)
end

function UIWeChatController:OnWeChatChangeName(speakerId)
  if speakerId ~= self.speakerId then
    return
  end
  local talks = self.weChatProxy:GetTalks(speakerId)
  for _, talk in ipairs(talks) do
    self:UpdateItem(talk)
  end
  local groupid = self:GetGroupIDFromSpeakerID(speakerId)
  if self.roleCell[groupid] then
    self.roleCell[groupid]:ChangeName()
  end
end

function UIWeChatController:OnWeChatUpdateRole(speakerid)
  self:RefreshRoleScroll(speakerid)
end

function UIWeChatController:WeChatUpdateLastTime(speakerid)
  local group2idx = {}
  for i = 1, #self._groups do
    local group = self._groups[i]
    if 1 < group:CurrentIdx() then
      local groupid = group:RoleList()[1]:GetGroupId()
      group2idx[groupid] = group:CurrentIdx()
    end
  end
  self._groups = self:GetAndSortGroups(speakerid)
  for i = 1, #self._groups do
    local group = self._groups[i]
    if 1 < group:RoleCount() then
      local gid = group:GroupID()
      local idx = group2idx[gid]
      if idx then
        group:SetIdx(idx)
      end
    end
  end
  self.contentRect.anchoredPosition = Vector2.zero
  self.roleScrollView:MovePanelToItemIndex(0, 0)
end

function UIWeChatController:OnWeChatPlayVoice(voiceId, chatCell)
  local oid = self:PlayAudio(voiceId)
  if oid == nil then
    return nil
  end
  self.curPlayVoiceAniChatCell = chatCell
  self:AddVoiceAniTimer()
  self.mCurVoiceId = oid
end

function UIWeChatController:AddVoiceAniTimer()
  if self.curPlayVoiceAniChatCell then
    self.timer = GameGlobal.Timer():AddEventTimes(500, TimerTriggerCount.Infinite, self.curPlayVoiceAniChatCell.OnVoiceAniLoop, self.curPlayVoiceAniChatCell)
    self.curPlayVoiceAniChatCell:StartVoiceAni()
  end
end

function UIWeChatController:StopVoiceAni()
  if self.timer then
    GameGlobal.Timer():CancelEvent(self.timer)
    self.timer = nil
  end
  if self.curPlayVoiceAniChatCell then
    self.curPlayVoiceAniChatCell:StopVoiceAni()
  end
  self.curPlayVoiceAniChatCell = nil
end

function UIWeChatController:PlayAudio(audioResId)
  if audioResId == nil then
    return nil
  end
  self:StopAudio()
  local id = AudioHelperController.RequestAndPlayUIVoiceAutoRelease(audioResId)
  return id
end

function UIWeChatController:StopAudio()
  if self.mCurVoiceId ~= nil then
    AudioHelperController.StopUIVoice(self.mCurVoiceId, 0)
    self.mCurVoiceId = nil
  end
  self:StopVoiceAni()
end

function UIWeChatController:SetDebugText()
  self.debugTxt:SetText(WeChatStateName[self.weChatProxy:GetCurStateType()])
end

function UIWeChatController:UpdateChatItems(talks, weChatRole, addOne)
  self.heights = {}
  if addOne then
    self.count = self.count + 1
  else
    self.count = #talks
  end
  self.sop:SpawnObjects("UIWeChatCell", self.count)
  self.chatCells = self.sop:GetAllSpawnList()
  for index, cell in ipairs(self.chatCells) do
    if index <= self.count then
      local talk = talks[index]
      if talk then
        cell:Enable(true)
        local height = cell:SetData(talk, weChatRole, nil, self.speakerId)
        table.insert(self.heights, height)
      else
        cell:Enable(false)
      end
    else
      cell:Enable(false)
    end
  end
  self:UpdateContentHeight()
end

function UIWeChatController:ChangeBgm(talks)
  local ts = talks
  local playid
  for i = 1, #ts do
    local talk = ts[i]
    if talk.readed then
      if talk.startBgm then
        playid = talk.startBgm
        self:AddUnLockBGM(talk.startBgm)
      end
      if talk.endBgm and talk.endBgm == playid then
        playid = nil
      end
    end
  end
  if playid then
    local cfg = Cfg.cfg_role_music[playid]
    if not cfg then
      Log.error("###[UIWeChatCell] cfg_role_music is nil ! id --> ", playid)
    end
    AudioHelperController.PlayBGM(cfg.AudioID)
  end
end

function UIWeChatController:AddUnLockBGM(id)
  if table.icontains(self._unlockBGMs, id) then
    self._uiMainModule:AddBGM(id)
  end
end

function UIWeChatController:GetItem(talk)
  for index, cell in ipairs(self.chatCells) do
    if cell.talk.talkId == talk.talkId and cell.talk.triggerIndex == talk.triggerIndex then
      return cell, index
    end
  end
  return nil
end

function UIWeChatController:UpdateItem(talk)
  local cell, index = self:GetItem(talk)
  if cell then
    local height = cell:SetData(talk, nil, nil, self.speakerId)
    self.heights[index] = height
    self:UpdateContentHeight()
  end
end

function UIWeChatController:UpdateContentHeight()
  local contentHeight = 0
  for index, height in ipairs(self.heights) do
    contentHeight = contentHeight + height
  end
  self.contentRect.sizeDelta = Vector2(1227, contentHeight)
  UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.contentRect)
end

function UIWeChatController:GetWeChatRoleBtn(petTempId)
  local groupid = self:GetGroupIDFromSpeakerID(petTempId)
  return self.roleCell and self.roleCell[groupid] and self.roleCell[groupid]:GetGameObject("bgbtn")
end

function UIWeChatController:ShowAddAffinity(petID, affinity)
  if not self._tweenQueue then
    local pet = self:GetModule(PetModule):GetPetByTemplateId(petID)
    if not pet then
      Log.fatal("[story] missing pet info, tplid:" .. petID)
      return
    end
    self._affinityPetHead:LoadImage(pet:GetPetHead(PetSkinEffectPath.HEAD_ICON_WE_CHAT))
    self._petNameTxt:SetText(StringTable.Get(pet:GetPetName()))
    self._affinityTxt:SetText(StringTable.Get("str_story_add_affinity", affinity))
    self._affinityWnd:SetActive(true)
    if self._tweenQueue then
      self._tweenQueue:Complete(false)
      self._tweenQueue = nil
    end
    self._tweenQueue = DG.Tweening.DOTween.Sequence()
    self._tweenQueue:Append(self._affinityWnd.transform:DOAnchorPosX(0, 0.2))
    self._tweenQueue:AppendInterval(3)
    if self._affinityWnd then
      self._tweenQueue:Append(self._affinityWnd.transform:DOAnchorPosX(600, 0.2)):AppendCallback(function()
        if self._affinityWnd then
          self._affinityWnd:SetActive(false)
        end
        self._tweenQueue = nil
      end)
    end
  end
end

function UIWeChatController:ObservationRefresh(pstid_list)
  if pstid_list then
    local pet = self:GetModule(PetModule):GetPetByTemplateId(self.speakerId)
    if pet then
      for key, value in pairs(pstid_list) do
        if value == pet:GetPstID() then
          self:ShowAddAffinity(self.speakerId, 5)
          break
        end
      end
    end
  end
end

function UIWeChatController:GetAndSortGroups(speakerid)
  if speakerid and self._groups then
    local tmpGroups = {}
    local tmpGroup
    for index, value in ipairs(self._groups) do
      local roleList = value:RoleList()
      local isit_idx = false
      for _, role in pairs(roleList) do
        local spid = role:GetSpeakerId()
        if spid == speakerid then
          isit_idx = index
          break
        end
      end
      if isit_idx then
        tmpGroup = self._groups[isit_idx]
        table.remove(self._groups, isit_idx)
        break
      end
    end
    table.insert(tmpGroups, tmpGroup)
    for index, value in ipairs(self._groups) do
      table.insert(tmpGroups, value)
    end
    return tmpGroups
  else
    return self.weChatProxy:GetSortedGroup(speakerid)
  end
end
