local AwakerStoryType = CommonDefine.AwakerStoryType

local function createAwakerStoryModelState(awakerModel)
  local state = {}
  state.awakerModel = awakerModel
  
  local function CheckStoryUnlock(numTid)
    local rst = CommonDefine.AwakerStoryVoiceState.Lock
    local storieList = awakerModel.selectAwakerData.stories
    if storieList and storieList[numTid] then
      rst = storieList[numTid]
    end
    return rst
  end
  
  state.curSelectVoiceId = 0
  state.curPlayingVoiceName = ""
  state.voiceSelectTab = CommonDefine.AwakerVoiceTab.Daily
  
  function state.storyShowList()
    local storyList = {}
    if not awakerModel.selectAwakerData or not awakerModel.selectAwakerData.voices then
      return storyList
    end
    local curSkin = awakerModel.selectAwakerData.curSkin or cd.DefaultSkinTid
    local skinStoryList = {}
    local HaveSpecificItem = CommonDefine.TaskUnlockCondType.HaveSpecificItem
    for _, config in pairs(DT.AwakerStory) do
      if config.ActorIndex == awakerModel.selectAwakerId and config.StoryType == AwakerStoryType.Story then
        local awakerVoiceData = {
          tid = config.ID,
          title = LT.Text(config.Title),
          content = LT.Text(config.Content),
          unlock = CheckStoryUnlock(config.ID),
          baseSortId = config.BaseSortID
        }
        local unlockSkinItem = AwakerDataUtils.GetVoiceUnlockSkinItem(config)
        if unlockSkinItem then
          if curSkin == unlockSkinItem then
            table.insert(skinStoryList, awakerVoiceData)
          end
        else
          table.insert(storyList, awakerVoiceData)
        end
      end
    end
    if table.next(skinStoryList) then
      storyList = skinStoryList
    end
    table.sort(storyList, function(a, b)
      local aWeight = a.unlock == CommonDefine.AwakerStoryVoiceState.Unlock and 999 or a.unlock
      local bWeight = b.unlock == CommonDefine.AwakerStoryVoiceState.Unlock and 999 or b.unlock
      if aWeight == bWeight then
        return a.baseSortId < b.baseSortId
      end
      return aWeight > bWeight
    end)
    return storyList
  end
  
  function state.awakerVoiceList()
    local returnList = {}
    if not awakerModel.selectAwakerData or not awakerModel.selectAwakerData.voices then
      return returnList
    end
    return awakerModel.selectAwakerData.voices
  end
  
  function state.voiceShowList()
    local voiceList = {}
    if state.voiceSelectTab == CommonDefine.AwakerVoiceTab.Pvp then
      for _, cfg in pairs(DT.PVPOpeningVoice) do
        if awakerModel.selectAwakerId ~= cfg.AwakerID then
        else
          local voiceTid = cfg.ID
          local unlockState = AwakerVoiceModel.Instance:GetPvpVoiceState(voiceTid)
          if unlockState == CommonDefine.AwakerStoryVoiceState.Hide then
          else
            local content = LT.Text(cfg.AwakerVoiceContent)
            if unlockState == CommonDefine.AwakerStoryVoiceState.Lock then
              content = LT.Text("PVPOpeningVoiceUnlockDesc")
            end
            local awakerVoiceData = {
              tid = voiceTid,
              title = PvpOpeningVoiceCfgUtils.GetVoiceName(voiceTid),
              content = content,
              unlock = unlockState
            }
            table.insert(voiceList, awakerVoiceData)
          end
        end
      end
      table.sort(voiceList, function(a, b)
        local aSortVal = DT.PVPOpeningVoice[a.tid].Sort
        local bSortVal = DT.PVPOpeningVoice[b.tid].Sort
        return aSortVal < bSortVal
      end)
      return voiceList
    else
      if not awakerModel.selectAwakerData or not awakerModel.selectAwakerData.voices then
        return voiceList
      end
      local curSkin = awakerModel.selectAwakerData.curSkin or cd.DefaultSkinTid
      local skinVoiceList = {}
      for voiceId, config in pairs(DT.Voice) do
        if config.AwakerID == awakerModel.selectAwakerId and config.AwakerVoiceTab == state.voiceSelectTab and config.ShowInAwakerDate == CommonDefine.IsShowAwakerDate.Yes then
          local soundEventName = AwakerDataUtils.GetAwakerVoiceSound(voiceId)
          local unlockState = awakerModel.selectAwakerData.voices[config.ID] or CommonDefine.AwakerStoryVoiceState.Lock
          local content = LT.Text(config.AwakerVoiceContent)
          if unlockState == CommonDefine.AwakerStoryVoiceState.Lock then
            content = DT.Voice[voiceId].UnlockDesc or ""
          end
          local awakerVoiceData = {
            tid = config.ID,
            title = LT.Text(config.AwakerVoiceTitle),
            content = content,
            soundEventStr = soundEventName,
            unlock = unlockState,
            FacialExpressionSwitch = config.FacialExpressionSwitch
          }
          local unlockSkinItem = AwakerDataUtils.GetVoiceUnlockSkinItem(config)
          if unlockSkinItem then
            if curSkin == unlockSkinItem then
              table.insert(skinVoiceList, awakerVoiceData)
            end
          else
            table.insert(voiceList, awakerVoiceData)
          end
        end
      end
      if table.next(skinVoiceList) then
        voiceList = skinVoiceList
      end
      table.sort(voiceList, function(a, b)
        local aWeight = a.unlock >= CommonDefine.AwakerStoryVoiceState.Unlock and 999 or a.unlock
        local bWeight = b.unlock >= CommonDefine.AwakerStoryVoiceState.Unlock and 999 or b.unlock
        local aSortVal = DT.Voice[a.tid].Sort
        local bSortVal = DT.Voice[b.tid].Sort
        if aWeight == bWeight then
          return aSortVal < bSortVal
        end
        return aWeight > bWeight
      end)
      return voiceList
    end
  end
  
  function state.messageShowList()
    local awakerConfig = DT.AwakerConfig[awakerModel.selectAwakerId]
    local retList = {
      {
        property = LT.Text("AwakerStoryName"),
        message = awakerConfig.Name
      },
      {
        property = LT.Text("AwakerStoryBirth"),
        message = awakerConfig.Age
      },
      {
        property = LT.Text("AwakerStoryGender"),
        message = awakerConfig.Gender
      },
      {
        property = LT.Text("AwakerStoryHeight"),
        message = awakerConfig.Height
      },
      {
        property = LT.Text("AwakerStoryWeight"),
        message = awakerConfig.Weight
      },
      {
        property = LT.Text("AwakerStoryKnowsIndex"),
        message = awakerConfig.Gi
      }
    }
    local tagName
    for _, tagTid in ipairs(awakerConfig.Tag or {}) do
      local tagCfg = DT.TagConfig[tagTid]
      if tagCfg then
        if not tagName then
          tagName = LT.Text(tagCfg.TagName)
        else
          tagName = tagName .. ", " .. LT.Text(tagCfg.TagName)
        end
      end
    end
    if tagName then
      table.insert(retList, {
        property = LT.Text("AwakerTagName"),
        message = tagName
      })
    end
    return retList
  end
  
  function state.messageShowDesc()
    local awakerId = awakerModel.selectAwakerId
    for _, config in pairs(DT.AwakerStory) do
      if awakerId == config.ActorIndex and config.StoryType == AwakerStoryType.BaseMessage then
        return config.Content
      end
    end
    return ""
  end
  
  return state
end

local function createAwakerStoryModelViews(data)
  local views = {}
  
  function views:GetCurVoiceTitle()
    for _, tb in pairs(data.voiceShowList) do
      if tb.tid == data.curSelectVoiceId then
        return tb.title
      end
    end
    return nil
  end
  
  function views:GetCurVoiceContent()
    for _, tb in pairs(data.voiceShowList) do
      if tb.tid == data.curSelectVoiceId then
        return tb.content
      end
    end
    return nil
  end
  
  function views:GetCurStoryTitle()
    return DT.AwakerStory[data.curSelectVoiceId] and DT.AwakerStory[data.curSelectVoiceId].Title or ""
  end
  
  function views:GetCurStoryContent()
    return DT.AwakerStory[data.curSelectVoiceId] and DT.AwakerStory[data.curSelectVoiceId].Content or ""
  end
  
  function views:GetStoryLockList()
    return data.storyLockList
  end
  
  function views:GetVoiceLockList()
    return data.voiceLockList
  end
  
  return views
end

local function createAwakerStoryModelActions(data)
  local actions = {}
  
  function actions:SetVoiceSelectTab(val)
    data.voiceSelectTab = val
  end
  
  function actions:UpdateVoiceLockList()
    local retList = {}
    local config = DT.Voice[self.curSelectVoiceId]
    if config then
      if config.ConditionType and config.UnlockDesc then
        table.insert(retList, {
          desc = LT.Text(config.UnlockDesc),
          unlock = AwakerAffectDataUtils.StoryOrVoiceUnlockCheck(data.awakerModel.selectAwakerId, config.ConditionType, config.ConditionPara)
        })
      end
      if config.ConditionType_1 and config.UnlockDesc_1 then
        table.insert(retList, {
          desc = LT.Text(config.UnlockDesc_1),
          unlock = AwakerAffectDataUtils.StoryOrVoiceUnlockCheck(data.awakerModel.selectAwakerId, config.ConditionType_1, config.ConditionPara_1)
        })
      end
    end
    data.voiceLockList = retList
  end
  
  function actions:UpdateStoryLockList()
    local retList = {}
    local config = DT.AwakerStory[self.curSelectVoiceId]
    if config then
      if config.ConditionType and config.UnlockDesc then
        table.insert(retList, {
          desc = LT.Text(config.UnlockDesc),
          unlock = AwakerAffectDataUtils.StoryOrVoiceUnlockCheck(data.awakerModel.selectAwakerId, config.ConditionType, config.ConditionPara)
        })
      end
      if config.ConditionType_1 and config.UnlockDesc_1 then
        table.insert(retList, {
          desc = LT.Text(config.UnlockDesc_1),
          unlock = AwakerAffectDataUtils.StoryOrVoiceUnlockCheck(data.awakerModel.selectAwakerId, config.ConditionType_1, config.ConditionPara_1)
        })
      end
    end
    data.storyLockList = retList
  end
  
  function actions:SetCurSelectVoiceId(val)
    if not val then
      return
    end
    data.curSelectVoiceId = val
  end
  
  function actions:SetCurPlayingVoiceName(val)
    if not val then
      return
    end
    data.curPlayingVoiceName = val
  end
  
  return actions
end

local function onSetup(_, _)
end

local AwakerStoryModel = Vue.model("AwakerStoryModel", createAwakerStoryModelState):views(createAwakerStoryModelViews):actions(createAwakerStoryModelActions):setup(onSetup)
return AwakerStoryModel
