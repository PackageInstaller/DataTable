local AvgAction = CommonDefine.AvgAction
local AvgActionLine = {
  AvgAction.PlayBgTransAnim,
  {
    AvgAction.PlayVideo,
    AvgAction.PrepareVideo,
    AvgAction.SetBg,
    AvgAction.BgAnim,
    AvgAction.PlayScreenEffect,
    AvgAction.FadeIn,
    AvgAction.SetCaption
  },
  {
    AvgAction.PlayDialogEnterAnim,
    AvgAction.ShowOtherAnim,
    AvgAction.ShakeDialog,
    AvgAction.ShowDialogText,
    AvgAction.AvgRole,
    AvgAction.SetTalkerInfo,
    AvgAction.LongCaption,
    AvgAction.AvgNovel,
    AvgAction.RadioDrama,
    AvgAction.RollCaption,
    AvgAction.RoleHurt,
    AvgAction.ShowItemAnim
  },
  AvgAction.SetOption,
  {
    AvgAction.EndPrefabAnimation,
    AvgAction.HideDialogAnim,
    AvgAction.ExitRoleEffect
  },
  AvgAction.FadeOut
}
local AvgNeedClickAction = {
  AvgAction.HideDialogAnim,
  AvgAction.ExitRoleEffect,
  AvgAction.EndPrefabAnimation
}
local AvgAutoNextAction = {
  AvgAction.FadeOut,
  AvgAction.EndPrefabAnimation,
  AvgAction.HideDialogAnim,
  AvgAction.LongCaption
}

local function createAvgDialogModelState(storyId, chatId)
  local state = {}
  state.storyId = storyId
  state.chatIndex = chatId
  state.isFirstEnter = true
  state.histList = {}
  state.actionDataMap = {}
  state.preDialogInfo = nil
  state.dialogInfo = nil
  state.isSetClose = false
  state.isLockedToJump = false
  state.isLockedInBgTrans = false
  state.isSkipFadeOut = false
  state.isAddQuote = false
  state.actionIndex = 1
  state.isSkippingDialog = true
  state.isAuto = false
  state.isEnableNext = true
  state.optionIds = nil
  state.choosedOptions = {}
  state.finishedChatIdMap = {}
  state.optionEndIndexMap = {}
  state.chatCannotSkipMap = {}
  state.video = nil
  state.videoTimeA = nil
  state.videoTimeB = nil
  state.videoCaption = nil
  state.isVideoLoop = nil
  state.keepDialogInVideo = nil
  state.preparedVideoUrl = nil
  state.isShakeDialog = nil
  state.itemId = nil
  state.bgTransAnim = nil
  state.endTransit = nil
  state.animStr = nil
  state.endAnimStr = nil
  state.bgId = nil
  state.bgLayer = nil
  state.roleList = {}
  state.screenEffectMap = {}
  state.musicAudioList = {}
  state.ambientAudioList = {}
  state.commandList = {}
  state.waitActionIdList = {}
  state.tagIndexMap = AvgStoryManager.Instance:GetTagIndexMap(storyId)
  state.optionChain = AvgStoryManager.Instance:GetOptionChain(storyId)
  return state
end

local function createAvgDialogModelViews(data)
  local views = {}
  
  function views:GetDialogInfo()
    return self.dialogInfo or {}
  end
  
  function views:GetChatIndexesByTags(tags)
    do return AvgStoryManager.Instance.GetChatIndexesByTags, AvgStoryManager.Instance, self.storyId end
    return AvgStoryManager.Instance.GetChatIndexesByTags, AvgStoryManager.Instance, self.storyId, tags
  end
  
  function views:IsPlayFadeIn()
    local Type = CommonDefine.AvgDialogType
    do return self.IsDialogType, self, Type.CaptionDialog end
    return self.IsDialogType, self, Type.CaptionDialog, Type.CaptionDialogWhite
  end
  
  function views:IsPlayFadeOut()
    if self:IsPlayFadeIn() then
      return true
    end
  end
  
  function views:IsEnd()
    if self.isSetClose then
      return true
    end
    local dialogInfo = self:GetDialogInfo()
    return not table.next(dialogInfo or {})
  end
  
  function views:IsNoBgDialog()
    if not self.bgId and not self.video and not self:IsCaption() then
      return true
    end
    if self.bgId == CommonDefine.TransparentBG then
      return true
    end
  end
  
  function views:GetNoSkipOptionId()
    if self.optionIds then
      return
    end
    local dialogInfoList = AvgStoryManager.Instance:GetDialogInfoList(self.storyId)
    for chatIndex, dialogInfo in ipairs(dialogInfoList) do
      if chatIndex > self.chatIndex and self:GetOptionIds(dialogInfo, chatIndex) then
        local isCannotSkip = string.find(dialogInfo.Sequence or "", "CanNotSkip")
        if isCannotSkip then
          return chatIndex
        end
        local optionIds = self:GetOptionIds(dialogInfo, chatIndex)
        for _, optionId in ipairs(optionIds) do
          local optionInfo = AvgStoryManager.Instance:GetDialogInfo(self.storyId, optionId)
          if string.find(optionInfo.Sequence or "", "CanNotSkip") then
            return chatIndex
          end
        end
      end
    end
  end
  
  function views:IsNeedClickActionId(actionId)
    do return table.contains, AvgNeedClickAction end
    return table.contains, AvgNeedClickAction, actionId
  end
  
  function views:CheckActionId(actionId)
    local curLineIdList = AvgActionLine[self.actionIndex]
    if not curLineIdList then
      return false
    end
    if type(curLineIdList) == "number" and curLineIdList == actionId then
      return true
    end
    if table.contains(curLineIdList, actionId) then
      return true
    end
  end
  
  function views:GetDialogType()
    local dialogInfo = self:GetDialogInfo()
    return dialogInfo.DialogType
  end
  
  function views:IsDialogType(...)
    local curType = self:GetDialogType()
    for i, dialogType in ipairs({
      ...
    }) do
      if curType == dialogType then
        return true
      end
    end
    return false
  end
  
  function views:IsBanSpeedingUp()
    local dialogInfo = self:GetDialogInfo()
    return dialogInfo.BanSpeedUp and 1 == dialogInfo.BanSpeedUp
  end
  
  function views:IsCaption()
    local Type = CommonDefine.AvgDialogType
    do return self.IsDialogType, self, Type.CaptionDialog, Type.CaptionDialogWhite, Type.LongCaption end
    return self.IsDialogType, self, Type.CaptionDialog, Type.CaptionDialogWhite, Type.LongCaption, Type.RollCaption
  end
  
  function views:IsAvgNovel()
    local Type = CommonDefine.AvgDialogType
    do return self.IsDialogType, self, Type.Novel end
    return self.IsDialogType, self, Type.Novel, Type.NovelEnd
  end
  
  function views:IsRadioDrama()
    do return self.IsDialogType, self end
    return self.IsDialogType, self, cd.AvgDialogType.RadioDrama
  end
  
  function views:GetRoleData(roleType, pos)
    for _, roleData in pairs(data.roleList) do
      if roleData.roleType == roleType and roleData.rolePos == pos then
        return roleData
      end
    end
  end
  
  function views:GetRoleDataById(roleId)
    for _, roleData in pairs(data.roleList) do
      if roleData.roleId == roleId then
        return roleData
      end
    end
  end
  
  function views:IsNewRole(roleId, roleType)
    if not roleId then
      return false
    end
    local isNew = true
    for _, roleData in pairs(data.roleList) do
      if roleData.roleId == roleId and roleData.roleType == roleType then
        isNew = false
        break
      end
    end
    return isNew
  end
  
  function views:GetTalkRoleInfo(talkRoleCfg)
    talkRoleCfg = talkRoleCfg or {}
    local roleId, secondValue, thirdValue = talkRoleCfg[1], talkRoleCfg[2], talkRoleCfg[3]
    local headEmoj, expression
    if roleId then
      for _, checkField in pairs({secondValue, thirdValue}) do
        if checkField then
          if string.find(checkField, ".png") then
            headEmoj = checkField
          else
            expression = checkField
          end
        end
      end
    end
    return {
      roleId = roleId,
      headEmoj = headEmoj,
      expression = expression,
      roleCfg = DT.AvgRole[roleId] or {}
    }
  end
  
  function views:GetTalkRoleId()
    local roleInfo = self:GetTalkRoleInfo(self:GetDialogInfo().TalkRole)
    return roleInfo.roleId
  end
  
  function views:GetTalkerName(talkRoleInfo)
    local roleInfo = talkRoleInfo or self:GetTalkRoleInfo(self:GetDialogInfo().TalkRole)
    local roleCfg = roleInfo.roleCfg
    local roleName = ""
    if roleCfg and roleCfg.RoleName then
      roleName = LT.Text(roleCfg.RoleName)
    end
    do return StrUtils.ReplaceAvgContent end
    return StrUtils.ReplaceAvgContent, roleName
  end
  
  function views:GetTalkerTitle(talkRoleInfo)
    local roleInfo = talkRoleInfo or self:GetTalkRoleInfo(self:GetDialogInfo().TalkRole)
    local roleCfg = roleInfo.roleCfg
    do return LT.Text end
    return LT.Text, roleCfg.Tittle
  end
  
  function views:GetTalkerIcon(talkRoleInfo)
    local roleInfo = talkRoleInfo or self:GetTalkRoleInfo(self:GetDialogInfo().TalkRole)
    local roleCfg = roleInfo.roleCfg
    local genderItem = GenderDataUtils.GetGenderCfgByRoleData()
    if (roleCfg.ID == CommonDefine.AvgDialogPlayerId or 1 == roleCfg.ShowAsPlayer) and nil ~= genderItem then
      if PlayerDataUtils.IsInAprileFool() then
        local replacementTid = PlayerDataUtils.GetAprileFoolReplaceItem()
        if replacementTid and ItemDataUtils.IsAvatarItem(replacementTid) then
          do return ItemDataUtils.GetAvatarIcon end
          return ItemDataUtils.GetAvatarIcon, replacementTid
        end
      end
      return genderItem.AVGAvatarRes
    else
      if (roleCfg.ID == CommonDefine.AvgDialogPlayerId or 1 == roleCfg.ShowAsPlayer) and nil == genderItem then
        genderItem = GenderDataUtils.GetGenderCfgByKey(CommonDefine.GenderID.Girl)
        if genderItem then
          if PlayerDataUtils.IsInAprileFool() then
            local replacementTid = PlayerDataUtils.GetAprileFoolReplaceItem()
            if replacementTid and ItemDataUtils.IsAvatarItem(replacementTid) then
              do return ItemDataUtils.GetAvatarIcon end
              return ItemDataUtils.GetAvatarIcon, replacementTid
            end
          end
          return genderItem.AVGAvatarRes
        end
      end
      if roleCfg.AwakerResource then
        do return PortraitUtils.GetMiniHead, roleCfg.AwakerResource end
        return PortraitUtils.GetMiniHead, roleCfg.AwakerResource, roleInfo.expression
      end
      if roleCfg.HeadIcon then
        local headUrl = string.format("Portraits/Minihead/%s.png", roleCfg.HeadIcon)
        return headUrl
      end
    end
  end
  
  function views:GetTalkerEmotion(talkRoleInfo)
    local roleInfo = talkRoleInfo or self:GetTalkRoleInfo(self:GetDialogInfo().TalkRole)
    local headEmoj = roleInfo.headEmoj
    if headEmoj then
      local path = DT.GetConstant("AvgEmojPath")
      return path .. headEmoj
    end
  end
  
  function views:GetBgTransAnim()
    return self.bgTransAnim
  end
  
  function views:GetBgId()
    local dialogInfo = self:GetDialogInfo()
    local bgId, bgLayer = table.unpack(dialogInfo.BgID or {})
    return bgId, bgLayer
  end
  
  function views:HasBgIdVideo()
    local bgId = self:GetBgId()
    local hasBgVideo = false
    if bgId and string.contains(bgId, ".mp4") then
      hasBgVideo = true
    end
    return hasBgVideo
  end
  
  function views:GetVideo()
    return self.video
  end
  
  function views:IsPlayingVideo()
    return self.video and self.videoTimeA ~= self.videoTimeB
  end
  
  function views:IsVideoType(type)
    return self.videoType == type
  end
  
  function views:IsPureVideoDialog()
    return self.video and self:IsVideoType(CommonDefine.AvgVideoType.VideoPure)
  end
  
  function views:IsShowDialogAnim()
    local dialogInfo = self:GetDialogInfo()
    if dialogInfo.BgTransition then
      return false
    end
    if 1 == dialogInfo.DialogAnim then
      return true
    end
    if not self:IsCaption() and 1 == #data.roleList then
      local roleData = data.roleList[1]
      local roleCfg = DT.AvgRole[roleData.roleId]
      if not roleData.isHide and roleData.isNew and roleCfg.Prefab and roleData.roleType == CommonDefine.AvgRoleType.Normal then
        return true
      end
    end
  end
  
  function views:IsHaveRoleExit()
    for _, roleData in pairs(data.roleList) do
      if roleData.exitDirection then
        return true
      end
    end
  end
  
  function views:IsHideDialogAnim()
    local isAllRoleExit = true
    local isHaveShowRole = false
    for _, roleData in pairs(data.roleList) do
      if not roleData.isHide then
        isHaveShowRole = true
        if not roleData.exitDirection then
          isAllRoleExit = false
          break
        end
      end
    end
    if isHaveShowRole and isAllRoleExit then
      return true
    end
  end
  
  function views:GetScreenffectMap()
    return self.screenEffectMap
  end
  
  function views:GetCurRolePosAndType()
    local dialogInfo = self:GetDialogInfo()
    local rolePos, roleType = table.unpack(dialogInfo.RolePos or {})
    if rolePos == CommonDefine.AvgRoleType.Big then
      return {
        1,
        CommonDefine.AvgRoleType.Big
      }
    end
    return {
      tonumber(rolePos) or 3,
      roleType or CommonDefine.AvgRoleType.Normal
    }
  end
  
  function views:GetActionIdList()
    local actionIndex = self.actionIndex
    local actionIdList = AvgActionLine[actionIndex]
    if not actionIdList then
      return
    end
    if type(actionIdList) ~= "table" then
      actionIdList = {actionIdList}
    end
    return actionIdList
  end
  
  function views:GetActionData()
    local actionIdList = self:GetActionIdList()
    if not actionIdList then
      return
    end
    local actionData = {}
    for _, action in ipairs(actionIdList) do
      actionData[action] = self:GetActionValue(action)
    end
    return actionData
  end
  
  function views:GetActionValue(action)
    return self.actionDataMap[action]
  end
  
  return views
end

local function createAvgDialogModelActions(data)
  local actions = {}
  local cmdComp = AvgCmdComponent(data)
  cmdComp:Awake()
  
  function actions:OnChangeChatId()
    local dialogInfo = AvgStoryManager.Instance:GetDialogInfo(self.storyId, self.chatIndex) or {}
    self:SetDialogInfo(dialogInfo)
    self:ResetOnChangeChatId()
    self:UpdateRoleListOnChatId()
    self:DealAudioEventOnChatId()
    self:UpdateScreenEffect()
    self:UpdateOptionIds()
    self:SetBgTransAnim(dialogInfo.BgTransition)
    self:UpdateBg()
    self.preparedVideoUrl = AvgStoryManager.Instance:GetReadyVideoUrl(self.storyId, self.chatIndex)
    if dialogInfo.Sequence then
      cmdComp:InitSequence(dialogInfo.Sequence)
    end
    self:PutIntoHistory(self.chatIndex)
    self:SetActionDataMap()
    if not self.isLockedToJump and not self:IsEnd() then
      self:StartStoryAction()
    end
    if 1 == self.chatIndex and not self.video then
      EventMgr.Instance.OnStoryRealStart:Dispatch(self.storyId)
    end
  end
  
  function actions:SetDialogInfo(dialogInfo)
    data.preDialogInfo = data.dialogInfo
    data.dialogInfo = table.clone(dialogInfo or {})
    data.isAddQuote = false
    self:SetCaptionAnimByDialogType(dialogInfo.DialogType)
  end
  
  function actions:SetActionDataMap()
    local dialogInfo = self:GetDialogInfo() or {}
    local actionDataMap = {}
    actionDataMap[AvgAction.FadeIn] = {
      isFadeIn = self:IsPlayFadeIn()
    }
    actionDataMap[AvgAction.FadeOut] = self:IsPlayFadeOut()
    actionDataMap[AvgAction.PlayBgTransAnim] = self.bgTransAnim
    actionDataMap[AvgAction.SetBg] = {
      bgId = self.bgId,
      bgLayer = self.bgLayer
    }
    actionDataMap[AvgAction.PlayVideo] = self.video
    actionDataMap[AvgAction.PrepareVideo] = data.preparedVideoUrl
    actionDataMap[AvgAction.AvgRole] = self.roleList
    actionDataMap[AvgAction.RadioDrama] = self:IsDialogType(CommonDefine.AvgDialogType.RadioDrama)
    local isPureVideoDialog = self:IsPureVideoDialog()
    if not isPureVideoDialog then
      actionDataMap[AvgAction.ShowDialogText] = dialogInfo.Content
      actionDataMap[AvgAction.SetCaption] = true
      actionDataMap[AvgAction.ShowItemAnim] = self.itemId or 0
      actionDataMap[AvgAction.SetOption] = self.optionIds
      actionDataMap[AvgAction.PlayScreenEffect] = self.screenEffectMap
      actionDataMap[AvgAction.PlayDialogEnterAnim] = {
        isShowAnim = self:IsShowDialogAnim()
      }
      actionDataMap[AvgAction.SetTalkerInfo] = self:GetTalkRoleInfo(dialogInfo.TalkRole)
      local animStr = self.animStr or dialogInfo.AnimState
      actionDataMap[AvgAction.BgAnim] = animStr and animStr:startswith("BG.") and animStr
      actionDataMap[AvgAction.ShowOtherAnim] = not actionDataMap[AvgAction.BgAnim] and animStr
      actionDataMap[AvgAction.ExitRoleEffect] = self:IsHaveRoleExit()
      actionDataMap[AvgAction.ShakeDialog] = self.isShakeDialog
      actionDataMap[AvgAction.EndPrefabAnimation] = self.endAnimStr or dialogInfo.EndAnim
      actionDataMap[AvgAction.HideDialogAnim] = self:IsHideDialogAnim()
      if dialogInfo.DialogType == CommonDefine.AvgDialogType.LongCaption then
        actionDataMap[AvgAction.LongCaption] = dialogInfo.Content
      end
      if dialogInfo.DialogType == CommonDefine.AvgDialogType.RollCaption then
        actionDataMap[AvgAction.RollCaption] = dialogInfo.Content
      end
      actionDataMap[AvgAction.AvgNovel] = dialogInfo.Content
    end
    self.actionDataMap = actionDataMap
    self:DebugLog("ActionDataMap:", table.tostring(self.actionDataMap))
  end
  
  function actions:SetWaitActionIdList(actionList)
    self.waitActionIdList = table.clone(actionList)
  end
  
  function actions:FinishAction(actionId)
    if not AvgActionLine[self.actionIndex] then
      return
    end
    for i, waitId in ipairs(self.waitActionIdList) do
      if waitId == actionId then
        table.remove(self.waitActionIdList, i)
        break
      end
    end
    self.actionDataMap[actionId] = nil
    if 0 == #self.waitActionIdList then
      self:DebugLog("Action:收到 %s, 所有动作完成消息，执行下一行", actionId)
      self:NextActionIndex()
      if table.contains(AvgAutoNextAction, actionId) then
        self:DebugLog("Action:收到 %s 自动执行段对话", actionId)
        self:NextDialog()
      end
      if self.isSetGameName then
        self:NextDialog()
      end
    else
      self:DebugLog("Action:收到 %s[%s] 等待 %s", actionId, TimerManager.totalTime, table.tostring(self.waitActionIdList, ",", ","))
    end
  end
  
  function actions:DebugLog(...)
    if GmClientUtils.IsEnableAvgLog then
      Logger.Info(...)
    end
  end
  
  function actions:StartStoryAction()
    self:DebugLog("Action:开始执行chatId", self.chatIndex)
    self.actionIndex = 1
  end
  
  function actions:NextActionIndex()
    self.actionIndex = self.actionIndex + 1
  end
  
  function actions:ResetOnChangeChatId()
    self.itemId = nil
    self.isForbidHideRoleAnim = nil
    self.isShakeDialog = nil
    self.optionIds = nil
    self.video = nil
    self.videoTimeA = nil
    self.videoTimeB = nil
    self.videoCaption = nil
    self.isVideoLoop = nil
    self.videoType = nil
    self.isVideoAutoNext = nil
    self.keepDialogInVideo = nil
  end
  
  function actions:SetKeepPreDialog(isKeep)
    self.keepDialogInVideo = isKeep
    if isKeep then
      local keepFields = {
        "TalkRole",
        "Content",
        "DialogType"
      }
      for _, field in ipairs(keepFields) do
        self.dialogInfo[field] = self.preDialogInfo[field]
      end
    end
  end
  
  function actions:SetKeepDialogInVideo(isKeep)
    self.keepDialogInVideo = isKeep
  end
  
  function actions:SetCaptionAnim(animType)
    local animList = DT.GetOriginalConstant(animType, {})
    self.captionBeginAnim = animList[1]
    self.captionEndAnim = animList[2]
  end
  
  function actions:SetSkipFadeOut(isSkipFadeOut)
    self.isSkipFadeOut = isSkipFadeOut
  end
  
  function actions:SetOptionEndIndex(endTag)
    local list = self:GetChatIndexesByTags({endTag})
    local endIndex = list and list[1]
    if self.chatIndex and endIndex then
      self.optionEndIndexMap[self.chatIndex] = endIndex
    end
  end
  
  function actions:SetCanNotSkip()
    self.chatCannotSkipMap[self.chatIndex] = true
  end
  
  function actions:SetEndTransit(transitType)
    if "WhiteTransit" == transitType then
      self.endTransit = "UI_Story_End_Transition_White"
    end
  end
  
  function actions:SetCaptionAnimByDialogType(dialogType)
    self.captionBeginAnim = nil
    self.captionEndAnim = nil
    local animType = CommonDefine.AvgCaptionAnim.Slow
    if dialogType == CommonDefine.AvgDialogType.CaptionDialogWhite then
      animType = CommonDefine.AvgCaptionAnim.Middle
    end
    self:SetCaptionAnim(animType)
  end
  
  function actions:SetVideo(video, videoTimeA, videoTimeB, videoCaption, isVideoLoop)
    self.video = video
    self.videoTimeA = videoTimeA
    self.videoTimeB = videoTimeB
    self.videoCaption = videoCaption
    self.isVideoLoop = isVideoLoop
  end
  
  function actions:SetVideoAutoNext(isVideoAutoNext)
    self.isVideoAutoNext = isVideoAutoNext
  end
  
  function actions:SetGameName()
    self.isSetGameName = true
  end
  
  function actions:SetVideoLoop(isVideoLoop)
    self.isVideoLoop = isVideoLoop
  end
  
  function actions:SetVideoType(videoType)
    self.videoType = videoType
  end
  
  function actions:SetShakeDialog(isShake)
    self.isShakeDialog = isShake
  end
  
  function actions:SetWaterColorOffset(roleId, enabled, x, y)
    local roleData = self:GetRoleDataById(roleId)
    if enabled then
      roleData.waterColorOffset = {x = x, y = y}
    else
      roleData.waterColorOffset = nil
    end
  end
  
  function actions:SetItem(itemId)
    data.itemId = itemId
  end
  
  function actions:NextDialog()
    data.isFirstEnter = false
    if self.optionIds then
      return
    end
    if self:IsEnd() then
      return
    end
    local dialogInfo = self:GetDialogInfo()
    if not table.next(dialogInfo or {}) then
      return
    end
    local nextIndex = self:GetNextChatIndex(self.chatIndex)
    self:SetChatIndex(nextIndex)
  end
  
  function actions:GetNextChatIndex(curIndex)
    local nextIndex
    local dialogInfo = AvgStoryManager.Instance:GetDialogInfo(self.storyId, curIndex)
    if dialogInfo.NextChatID then
      local nextIndexes = self:GetChatIndexesByTags(dialogInfo.NextChatID)
      nextIndex = nextIndexes and nextIndexes[1]
    else
      local curTag = dialogInfo.ChatID
      if curTag then
        local nextTag = curTag .. "_TO"
        local nextIndexes = self:GetChatIndexesByTags({nextTag})
        nextIndex = nextIndexes and nextIndexes[1]
      end
    end
    nextIndex = nextIndex or curIndex + 1
    if self.finishedChatIdMap[nextIndex] then
      if self.optionEndIndexMap[nextIndex] then
        nextIndex = self.optionEndIndexMap[nextIndex]
      else
        local nextDialogInfo = AvgStoryManager.Instance:GetDialogInfo(self.storyId, nextIndex)
        local nextTag = nextDialogInfo.ChatID
        if nextTag then
          nextTag = nextTag .. "_END"
          local nextIndexes = self:GetChatIndexesByTags({nextTag})
          nextIndex = nextIndexes and nextIndexes[1]
        end
      end
    end
    return nextIndex
  end
  
  function actions:UpdateOptionIds()
    local dialogInfo = self:GetDialogInfo()
    self.optionIds = self:GetOptionIds(dialogInfo, self.chatIndex)
  end
  
  function actions:GetOptionIds(dialogInfo, chatIndex)
    local optionIds = {}
    local nextIds = self:GetChatIndexesByTags(dialogInfo.NextChatID) or {
      chatIndex + 1
    }
    local isOption = false
    if #nextIds > 1 then
      isOption = true
    else
      local nextId = nextIds[1]
      local nextDialogInfo = AvgStoryManager.Instance:GetDialogInfo(self.storyId, nextId)
      if nextDialogInfo and nextDialogInfo.DialogType == CommonDefine.AvgDialogType.OptionDialog then
        isOption = true
      end
    end
    if isOption then
      for _, optionId in ipairs(nextIds) do
        if not self.choosedOptions[optionId] then
          table.insert(optionIds, optionId)
        end
      end
    end
    if #optionIds > 0 then
      return optionIds
    end
  end
  
  function actions:SetChatIndex(chatIndex, forceSet)
    if forceSet then
      self.chatIndex = chatIndex
    elseif chatIndex < self.chatIndex then
      if not self.isLockedToJump then
        self:JumpToDialog(chatIndex)
      else
        self.chatIndex = chatIndex
      end
    else
      self.chatIndex = chatIndex
    end
    self:JfStoryCommitEvent(CommonDefine.SdkJfStoryActionType.Read)
    AvgStoryManager.Instance:PlayTimelineByEntityCfgId(self.storyId, self.chatIndex)
  end
  
  function actions:OnChooseOption(index)
    local optionId = self.optionIds[index]
    if optionId then
      table.remove(self.optionIds, index)
      self.choosedOptions[optionId] = true
      self:PutIntoHistory(optionId, index)
      if 0 == #self.optionIds then
        self.finishedChatIdMap[self.chatIndex] = true
      end
      local nextIndex = self:GetNextChatIndex(optionId)
      local isForceOptionIndex = self._isForceOptionIndex
      self._isForceOptionIndex = nil
      self:SetChatIndex(nextIndex, isForceOptionIndex)
    end
  end
  
  function actions:PutIntoHistory(chatIndex, chosenIndex)
    local storyId = self.storyId
    local dialogInfo = AvgStoryManager.Instance:GetDialogInfo(storyId, chatIndex)
    if not dialogInfo then
      return
    end
    for _, info in ipairs(self.histList) do
      if info.chatIndex == chatIndex then
        return
      end
    end
    local dialogType = dialogInfo.DialogType
    if nil == dialogType then
      return
    end
    local AvgDialogType = CommonDefine.AvgDialogType
    local actorIdList = dialogInfo.TalkRole
    local actorId = actorIdList and actorIdList[1]
    local actorCfg = actorId and DT.AvgRole[actorId] or {}
    local actorName = actorCfg.RoleName
    local content = dialogInfo.Content
    table.insert(self.histList, {
      chatIndex = chatIndex,
      actor = actorName,
      content = self:HandleHistoryContent(LT.Text(content)),
      isOption = dialogInfo.DialogType == AvgDialogType.OptionDialog,
      chosenIndex = chosenIndex
    })
    local numLimit = tonumber(DT.GetConstant("AvgDialog_NumLimit"))
    local totalCount = #(self.histList or {})
    if numLimit < totalCount then
      table.remove(self.histList, 1)
    end
  end
  
  function actions:HandleHistoryContent(content)
    if not content then
      return ""
    end
    local isChange = string.find(content, "<Change>", 0, true)
    if isChange then
      content = string.replace(content, "<Change>", "", true)
    end
    content = StrUtils.RemoveAvgHtmlTag(content)
    content = StrUtils.ClearRichText(content)
    if isChange then
      local replaceStr = ""
      for i = 1, #content, 3 do
        replaceStr = string.format("%s■", replaceStr)
      end
      content = replaceStr
    end
    return content
  end
  
  function actions:ClearFirstEnter()
    data.isFirstEnter = false
  end
  
  function actions:SetBgTransAnim(anim)
    data.bgTransAnim = anim
    self:SetLockInBgTrans(nil ~= anim)
  end
  
  function actions:SetBg(bgId)
    self.bgId = bgId
  end
  
  function actions:SetAnim(animStr)
    self.animStr = animStr
  end
  
  function actions:SetEndAnim(animStr)
    self.endAnimStr = animStr
  end
  
  function actions:SetBgScale(scale)
    data.bgScale = scale
  end
  
  function actions:UpdateBg()
    local dialogInfo = self:GetDialogInfo()
    local bgId, bgLayer = table.unpack(dialogInfo.BgID or {})
    if bgId then
      self.bgId = bgId
      self.bgLayer = bgLayer
      self.bgScale = 1
    end
  end
  
  function actions:UpdateRoleListOnChatId()
    for i = #data.roleList, 1, -1 do
      local roleData = data.roleList[i]
      roleData.playEnterAnim = nil
      roleData.isNew = nil
      roleData.oldPos = nil
      roleData.isShake = nil
      roleData.isTalker = false
      if roleData.isHide or roleData.exitDirection then
        table.remove(data.roleList, i)
      end
    end
    local curRoleData = self:GetCurTalkerRoleData()
    self:AddRoleData(curRoleData)
    self:DebugLog("AvgRoleList:", self.chatIndex, table.tostring(data.roleList))
  end
  
  function actions:SetTestRoleId(roleId, roleType, expression)
    roleType = roleType or CommonDefine.AvgRoleType.Normal
    local roleData = {
      roleId = roleId,
      isTalker = true,
      rolePos = roleType == CommonDefine.AvgRoleType.Normal and 3 or 1,
      roleType = roleType,
      isHide = false,
      isBlackOutLine = false,
      isLightRole = false,
      isFadeDark = false,
      playEnterAnim = false,
      waterColorOffset = nil,
      expression = expression,
      isNew = true
    }
    data.roleList = {roleData}
  end
  
  function actions:SetTestEmoj(Emoj)
    if data.roleList and data.roleList[1] then
      data.roleList[1].expression = Emoj
    end
  end
  
  function actions:GetCurTalkerRoleData()
    local dialogInfo = self:GetDialogInfo()
    local roleInfo = self:GetTalkRoleInfo(dialogInfo.TalkRole)
    local roleId = roleInfo.roleId
    local expression = roleInfo.expression
    local rolePos, roleType = table.unpack(self:GetCurRolePosAndType() or {})
    if dialogInfo.DialogType == CommonDefine.AvgDialogType.HeadIconDialog or 0 == rolePos then
      roleId = nil
    end
    local oldRoleData = self:GetRoleDataById(roleId) or {}
    local curRoleData = {}
    curRoleData.roleId = roleId
    curRoleData.isTalker = true
    curRoleData.roleName = roleId and (DT.AvgRole[roleId] or {}).RoleName
    curRoleData.rolePos, curRoleData.roleType = rolePos, roleType
    curRoleData.expression = expression
    curRoleData.playEnterAnim = dialogInfo.PlayEnterAnim
    curRoleData.isNew = self:IsNewRole(roleId, curRoleData.roleType)
    curRoleData.roleScale = oldRoleData.roleScale
    curRoleData.isMirrorFlip = oldRoleData.isMirrorFlip
    return curRoleData
  end
  
  function actions:AddRoleData(newRoleData)
    local dialogInfo = self:GetDialogInfo()
    for index = #data.roleList, 1, -1 do
      local roleData = data.roleList[index]
      if newRoleData.roleId and newRoleData.roleId ~= roleData.roleId and roleData.rolePos == newRoleData.rolePos and roleData.roleType == newRoleData.roleType then
        table.remove(data.roleList, index)
      elseif roleData.roleId == newRoleData.roleId and roleData.roleType == newRoleData.roleType then
        newRoleData.oldPos = roleData.rolePos
        newRoleData.isBlackOutLine = roleData.isBlackOutLine
        newRoleData.isLightRole = roleData.isLightRole
        newRoleData.isFadeDark = roleData.isFadeDark
        newRoleData.isMirrorFlip = roleData.isMirrorFlip
        newRoleData.waterColorOffset = roleData.waterColorOffset
        table.remove(data.roleList, index)
      else
        self:SetRoleHide(roleData, dialogInfo.RoleHide, roleData.isTalker)
        self:SetRoleExit(roleData, dialogInfo.RoleExit, dialogInfo.ExitDirection, roleData.isTalker)
        self:SetRoleShake(roleData, dialogInfo.RoleShake, roleData.isTalker)
        self:SetRoleShakeDirection(roleData, dialogInfo.ShakeDirection)
      end
    end
    if newRoleData.roleId then
      self:SetRoleHide(newRoleData, dialogInfo.RoleHide, newRoleData.isTalker)
      self:SetRoleExit(newRoleData, dialogInfo.RoleExit, dialogInfo.ExitDirection, newRoleData.isTalker)
      self:SetRoleShake(newRoleData, dialogInfo.RoleShake, newRoleData.isTalker)
      self:SetRoleShakeDirection(newRoleData, dialogInfo.ShakeDirection)
      table.insert(data.roleList, newRoleData)
    end
  end
  
  function actions:DarkTalkerRole(roleId, darkValue)
    local role = self:GetRoleDataById(roleId)
    if role then
      role.isBlackOutLine = 1 == darkValue
    end
  end
  
  function actions:FadeDarkTalkerRole(roleId, darkValue)
    local role = self:GetRoleDataById(roleId)
    if role then
      role.isFadeDark = 1 == darkValue
    end
  end
  
  function actions:LightTalkerRole(roleId, lightValue)
    local role = self:GetRoleDataById(roleId)
    if role then
      role.isLightRole = 1 == lightValue
    end
  end
  
  function actions:SetRoleHide(roleData, roleHide, isTalker)
    local hidingRoleType = {}
    if roleHide then
      for idx = #roleHide, 1, -1 do
        local value = roleHide[idx]
        if self:_IsRoleType(value) then
          local roleId = roleHide[idx - 1]
          hidingRoleType[roleId] = value
        end
      end
    end
    for _, tag in ipairs(roleHide or {}) do
      if tag == CommonDefine.AvgRoleTag.Talker and isTalker then
        roleData.isHide = true
      end
      if tag == CommonDefine.AvgRoleTag.All then
        roleData.isHide = true
      end
      if tag == CommonDefine.AvgRoleTag.AllExceptTalker and not isTalker then
        roleData.isHide = true
      end
      if tag == roleData.roleId then
        local roleType = hidingRoleType[tag]
        if not roleType or roleType == roleData.roleType then
          roleData.isHide = true
        end
      end
    end
  end
  
  function actions:_IsRoleType(value)
    if not self.roleTypeDict then
      self.roleTypeDict = {}
      for _, t in pairs(CommonDefine.AvgRoleType) do
        self.roleTypeDict[t] = true
      end
    end
    return self.roleTypeDict[value]
  end
  
  function actions:SetRoleExit(roleData, roleExit, roleExitDirections, isTalker)
    for _, tag in ipairs(roleExit or {}) do
      local isFind = false
      if tag == CommonDefine.AvgRoleTag.Talker and isTalker then
        isFind = true
      end
      if tag == CommonDefine.AvgRoleTag.All then
        isFind = true
      end
      if tag == CommonDefine.AvgRoleTag.AllExceptTalker and not isTalker then
        isFind = true
      end
      if tag == roleData.roleId then
        isFind = true
      end
      if isFind then
        roleData.exitDirection = 3 == roleData.rolePos and 0 or roleData.rolePos < 3 and 1 or 2
      end
    end
    for i = 1, #(roleExitDirections or {}) do
      local list = string.split(roleExitDirections[i], ":")
      local roleId, dir = tonumber(list[1]), tonumber(list[2])
      if roleData.roleId == roleId and dir then
        roleData.exitDirection = dir
      end
    end
  end
  
  function actions:SetRoleShake(roleData, roleShakeTags, isTalker)
    roleData.isShake = nil
    for _, tag in ipairs(roleShakeTags or {}) do
      if tag == CommonDefine.AvgRoleTag.Talker and isTalker then
        roleData.isShake = 1
      end
      if tag == CommonDefine.AvgRoleTag.All then
        roleData.isShake = 1
      end
      if tag == CommonDefine.AvgRoleTag.AllExceptTalker and not isTalker then
        roleData.isShake = 1
      end
      if tag == roleData.roleId then
        roleData.isShake = 1
      end
    end
  end
  
  function actions:SetRoleShakeDirection(roleData, roleShakeDirection)
    roleData.shakeDirection = nil
    if roleShakeDirection then
      if 1 == #roleShakeDirection then
        roleData.shakeDirection = roleShakeDirection[1]
      else
        for i = 1, #roleShakeDirection, 2 do
          if roleShakeDirection[i] == roleData.roleId then
            roleData.shakeDirection = roleShakeDirection[i + 1]
            break
          end
        end
      end
    end
  end
  
  function actions:SetRoleScale(roleId, scale, dura)
    local roleData = self:GetRoleDataById(roleId)
    if roleData then
      roleData.roleScale = scale
      roleData.roleScaleDura = dura
    end
  end
  
  function actions:SetRoleMirrorFlip(roleId, enable)
    local roleData = self:GetRoleDataById(roleId)
    if roleData then
      roleData.isMirrorFlip = enable
    end
  end
  
  function actions:SetForbidHideRoleAnim(isForbid)
    self.isForbidHideRoleAnim = isForbid
  end
  
  function actions:SetClose()
    self.isSetClose = true
  end
  
  function actions:AddQuote()
    self.isAddQuote = true
  end
  
  function actions:CloseDispatchEvent()
    EventMgr.Instance.OnStoryEnd:Dispatch(self.storyId)
    EventMgr.Instance.BattleBottomUI:Dispatch(true)
    EventMgr.Instance.GameEvent:Dispatch(CommonDefine.GameEvent.ExitAvg)
  end
  
  function actions:JumpToDialog(newChatIndex)
    if self.isLockedToJump then
      return
    end
    self.isLockedToJump = true
    if newChatIndex < self.chatIndex then
      self:Reset()
    end
    local optionChain = self.optionChain
    local count = 0
    while newChatIndex > self.chatIndex do
      count = count + 1
      if count >= 100 then
        break
      end
      self:NextDialog()
      if self.chatIndex == newChatIndex then
        break
      end
      for _, optionId in ipairs(self.optionIds or {}) do
        if optionId == newChatIndex then
          break
        end
      end
      for index, optionId in ipairs(self.optionIds or {}) do
        local chains = optionChain[optionId]
        if table.contains(chains, newChatIndex) then
          self:OnChooseOption(index)
          break
        end
      end
      if not self:GetDialogInfo() then
        break
      end
    end
    self.isLockedToJump = false
    self:StartStoryAction()
  end
  
  function actions:SetLockInBgTrans(isLock)
    self.isLockedInBgTrans = isLock
  end
  
  function actions:Reset()
    self.optionIds = nil
    self.video = nil
    self.videoTimeA = nil
    self.videoTimeB = nil
    self.videoCaption = nil
    self.isVideoLoop = nil
    self.keepDialogInVideo = nil
    self.itemId = nil
    self.bgTransAnim = nil
    self.isShakeDialog = nil
    self.captionBeginAnim = nil
    self.captionEndAnim = nil
    self.animStr = nil
    self.endAnimStr = nil
    self.bgId = nil
    self.bgLayer = nil
    self.roleList = {}
    self.screenEffectMap = {}
    self.musicAudioList = {}
    self.ambientAudioList = {}
    self.commandList = {}
    self:SetChatIndex(AvgStoryManager.Instance:GetStartChatId(self.storyId))
  end
  
  function actions:ResetChoosedOption()
    self.choosedOptions = {}
    self.finishedChatIdMap = {}
    self.optionEndIndexMap = {}
    self._isForceOptionIndex = true
  end
  
  function actions:UpdateScreenEffect()
    self.screenEffectMap[CommonDefine.AvgScreenEffect.Awake] = nil
    local dialogInfo = self:GetDialogInfo()
    if dialogInfo.ScreenEffect then
      for index = 1, #dialogInfo.ScreenEffect, 2 do
        local effectName, effectValue = table.unpack(dialogInfo.ScreenEffect, index, index + 1)
        self.screenEffectMap[effectName] = effectValue == CommonDefine.NumberTrue
      end
    end
  end
  
  function actions:DealAudioManagerEvent(listOfList)
    local isStopMusic = false
    local isStopAmbient = false
    for i, list in ipairs(listOfList) do
      for _, audioInfo in ipairs(list) do
        if "Stop_Avg_Amb" == audioInfo then
          isStopAmbient = true
        end
        if "Stop_Avg_Mus" == audioInfo then
          isStopMusic = true
        end
      end
    end
    if isStopMusic then
      self.musicAudioList = {}
    end
    if isStopAmbient then
      self.ambientAudioList = {}
    end
  end
  
  function actions:IsMusic(soundEvent)
    local eventLower = soundEvent:lower()
    return string.match(eventLower, string.lower("Play_A_MUS")) or string.match(eventLower, string.lower("Set_Avg_Mus"))
  end
  
  function actions:DealAudioEventOnChatId()
    local dialogInfo = self:GetDialogInfo()
    for _, audioInfo in ipairs(dialogInfo.Audio or {}) do
      if self:IsMusic(audioInfo) then
        table.insert(self.musicAudioList, audioInfo)
      else
        table.insert(self.ambientAudioList, audioInfo)
      end
    end
    for _, audioInfo in ipairs(dialogInfo.AudioAmbient or {}) do
      table.insert(self.ambientAudioList, audioInfo)
    end
    self:DealAudioManagerEvent({
      dialogInfo.Audio or {},
      dialogInfo.AudioAmbient or {},
      dialogInfo.AudioManageEvent or {}
    })
  end
  
  function actions:GetBubbleItemDatas()
    local tBubbleDatas = {}
    while not self:IsEnd() do
      local itemData = {
        talkerIcon = self:GetTalkerIcon(),
        dialogInfo = self:GetDialogInfo(),
        talkerName = self:GetTalkerName()
      }
      table.insert(tBubbleDatas, itemData)
      self:NextDialog()
    end
    return tBubbleDatas
  end
  
  function actions:JfStoryCommitEvent(action)
    local event_params = {
      action = action,
      storyId = data.storyId,
      storyId2 = data.chatIndex
    }
    local uuStr = tostring(data.storyId)
    local playId = SdkMgr.MD5Sumhexa(uuStr)
    event_params.playId = playId
    SdkMgr.Instance:JfCommitEvent(CommonDefine.SdkJfEventNameType.Story, event_params)
  end
  
  function actions:SetLongCapAutoDuration(duration)
    self.longCapAutoDuration = duration
  end
  
  function actions:GetLongCapAutoDuration()
    return self.longCapAutoDuration
  end
  
  return actions
end

local function onSetup(binder, model)
  binder:BindToRaw(function(_, newChatId, oldChatId)
    if model.chatIndex then
      model:OnChangeChatId()
    end
  end, function()
    return model.chatIndex
  end, true)
  if not model.chatIndex then
    model.chatIndex = AvgStoryManager.Instance:GetStartChatId(model.storyId)
  else
    local jumpToChatId = model.chatIndex
    model.chatIndex = AvgStoryManager.Instance:GetStartChatId(model.storyId)
    model:JumpToDialog(jumpToChatId)
  end
  model:JfStoryCommitEvent(CommonDefine.SdkJfStoryActionType.StartStory)
  model:JfStoryCommitEvent(CommonDefine.SdkJfStoryActionType.Read)
end

local AvgDialogModel = Vue.model("AvgDialogModel", createAvgDialogModelState):views(createAvgDialogModelViews):actions(createAvgDialogModelActions):setup(onSetup)
return AvgDialogModel
