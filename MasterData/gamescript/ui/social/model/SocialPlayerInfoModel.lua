local PlayerInfoPage = SocialDefine.PlayerInfoPage

local function fillSocialPlayerInfoModel(state, initData)
  state.page = initData and initData.page or PlayerInfoPage.Overview
  state.isMyInfo = initData and initData.targetPlayerUid == DataCenter.playerData.DRole.uid
  state.targetPlayerUid = initData and initData.targetPlayerUid
  state.playerPanelType = initData and initData.playerPanelType
  state.assistAwakerWeapons = {0, 0}
  state.assistAwakerTrinkets = {
    0,
    0,
    0,
    0,
    0,
    0
  }
  state.assistAwakerSkills = {
    {},
    {},
    {},
    {},
    {},
    {}
  }
  state.assistAwakerTalents = {
    0,
    0,
    0
  }
  state.pveDetailsList = {}
  if not initData or not initData.otherPlayerData then
    return
  end
  state.playerInfoData = initData.otherPlayerData
end

local function createSocialPlayerInfoModelState(initData)
  local state = {}
  fillSocialPlayerInfoModel(state, initData)
  return state
end

local function createSocialPlayerInfoModelViews(data)
  local views = {}
  
  function views:GetAvatar()
    if not self.playerInfoData or not self.playerInfoData.facade then
      Logger.Warn("[social] data exception:", self.playerInfoData, "facade:", self.playerInfoData and self.playerInfoData.facade)
      return ""
    end
    local avatarItemTid = self.playerInfoData.facade.icon
    local avatarPath = ItemDataUtils.GetAvatarIcon(avatarItemTid)
    return avatarPath
  end
  
  function views:GetAvatarFrame()
    if not self.playerInfoData or not self.playerInfoData.facade then
      Logger.Warn("[social] data exception:", self.playerInfoData, "facade:", self.playerInfoData and self.playerInfoData.facade)
      return ""
    end
    local frameItemTid = self.playerInfoData.facade.avatarFrame
    local framePath = ItemDataUtils.GetItemIcon(frameItemTid)
    return framePath
  end
  
  function views:GetRoleName()
    if not self.playerInfoData or not self.playerInfoData.facade then
      Logger.Warn("[social] data exception:", self.playerInfoData, "facade:", self.playerInfoData and self.playerInfoData.facade)
      return {realName = "", nickName = ""}
    end
    do return SocialDataUtils.GetPlayerNameAndNickName end
    return SocialDataUtils.GetPlayerNameAndNickName, self.playerInfoData.facade, self.playerInfoData, "facade:", self.playerInfoData and self.playerInfoData.facade
  end
  
  function views:GetUid()
    if not self.playerInfoData or not self.playerInfoData.facade then
      Logger.Warn("[social] data exception:", self.playerInfoData, "facade:", self.playerInfoData and self.playerInfoData.facade)
      return ""
    end
    return self.playerInfoData.facade.uid
  end
  
  function views:GetLevel()
    if not self.playerInfoData or not self.playerInfoData.facade then
      Logger.Warn("[social] data exception:", self.playerInfoData, "facade:", self.playerInfoData and self.playerInfoData.facade)
      return ""
    end
    return self.playerInfoData.facade.level
  end
  
  function views:GetCurrExp()
    if not self.playerInfoData or not self.playerInfoData.facade then
      Logger.Warn("[social] data exception:", self.playerInfoData, "facade:", self.playerInfoData and self.playerInfoData.facade)
      return ""
    end
    if self:IsMaxPlayerLevel() then
      do return LT.Text end
      return LT.Text, "MaxLevel_Tips_Exp", self.playerInfoData, "facade:", self.playerInfoData and self.playerInfoData.facade
    end
    return self.playerInfoData.facade.exp
  end
  
  function views:IsMaxPlayerLevel()
    if not self.playerInfoData or not self.playerInfoData.facade then
      Logger.Warn("[social] data exception:", self.playerInfoData, "facade:", self.playerInfoData and self.playerInfoData.facade)
      return false
    end
    local maxLvCfg = PlayerDataUtils.GetMaxAccountLevelCfg()
    return maxLvCfg and maxLvCfg.Level == self.playerInfoData.facade.level
  end
  
  function views:GetExpUpperLimit()
    if not self.playerInfoData or not self.playerInfoData.facade then
      Logger.Warn("[social] data exception:", self.playerInfoData, "facade:", self.playerInfoData and self.playerInfoData.facade)
      return ""
    end
    if self:IsMaxPlayerLevel() then
      return ""
    end
    do return PlayerDataUtils.GetAccountUpgradeExp end
    return PlayerDataUtils.GetAccountUpgradeExp, self.playerInfoData.facade.level, self.playerInfoData, "facade:", self.playerInfoData and self.playerInfoData.facade
  end
  
  function views:GetExpPercent()
    if self:IsMaxPlayerLevel() then
      return 1
    end
    local curr = tonumber(self:GetCurrExp())
    local upperLimit = tonumber(self:GetExpUpperLimit())
    if not curr or not upperLimit then
      return 0
    end
    local percent = curr / upperLimit
    if percent > 1 then
      percent = 1
    end
    return percent
  end
  
  function views:GetFansNum()
    if not self.playerInfoData then
      Logger.Warn("[social] data exception:", self.playerInfoData)
      return ""
    end
    return self.playerInfoData.followerNum or 0
  end
  
  function views:GetAttentionNum()
    if not self.playerInfoData then
      Logger.Warn("[social] data exception:", self.playerInfoData)
      return ""
    end
    return self.playerInfoData.attentionNum or 0
  end
  
  function views:GetTotalGoodNum()
    if not self.playerInfoData then
      Logger.Warn("[social] data exception:", self.playerInfoData)
      return ""
    end
    return self.playerInfoData.goodNum or 0
  end
  
  function views:GetBirth()
    if not self.playerInfoData or not self.playerInfoData.facade then
      Logger.Warn("[social] data exception:", self.playerInfoData, "facade:", self.playerInfoData and self.playerInfoData.facade)
      return ""
    end
    local birthArr = string.split(self.playerInfoData.facade.birthday, "-")
    if not birthArr or #birthArr < 2 then
      return ""
    end
    local month, day = birthArr[1], birthArr[2]
    if not month or not day then
      return ""
    end
    do return LT.Textf, "SocialSystemBirthday", month end
    return LT.Textf, "SocialSystemBirthday", month, day
  end
  
  function views:GetNote()
    if not self.playerInfoData or not self.playerInfoData.facade then
      Logger.Warn("[social] data exception:", self.playerInfoData, "facade:", self.playerInfoData and self.playerInfoData.facade)
      return ""
    end
    return self.playerInfoData.facade.note
  end
  
  function views:GetPlaceHolderText()
    if self.isMyInfo then
      do return LT.Text end
      return LT.Text, "SocialSystemIntroductionNotYetEdited"
    else
      do return LT.Text end
      return LT.Text, "SocialSystemIntroductionNone"
    end
  end
  
  function views:GetMainStageProgress(key)
    local value = self:GetAchieveValue(key)
    if value then
      local nameNumer = CopyDataUtils.GetStageNameNumber(value)
      return nameNumer or "-"
    end
    return "-"
  end
  
  function views:GetSchoolTowerTotalStar(stageGroupType)
    if not self.playerInfoData or not self.playerInfoData.facade then
      Logger.Warn("[social] data exception:", self.playerInfoData, "facade:", self.playerInfoData and self.playerInfoData.facade)
      return ""
    end
    local schoolTowerMaps = self.playerInfoData.facade.achieve and self.playerInfoData.facade.achieve.schoolTower
    local totalStar = 0
    if schoolTowerMaps then
      for stageGroupTid, star in pairs(schoolTowerMaps) do
        if stageGroupType then
          local stageGroupConfig = CopyDataUtils.GetStageGroupConfig(stageGroupTid)
          if not stageGroupConfig then
          elseif stageGroupConfig.Type ~= stageGroupType then
          else
            star = star or 0
            totalStar = totalStar + star
          end
        end
      end
    end
    return totalStar
  end
  
  function views:GetAchieveValue(achieveKey)
    if not self.playerInfoData or not self.playerInfoData.facade then
      Logger.Warn("[social] data exception:", self.playerInfoData, "facade:", self.playerInfoData and self.playerInfoData.facade)
      return ""
    end
    if self.playerInfoData.facade.achieve and self.playerInfoData.facade.achieve.achievement then
      return self.playerInfoData.facade.achieve.achievement[achieveKey] or 0
    end
    return ""
  end
  
  function views:GetCollectionCount()
    if not self.playerInfoData or not self.playerInfoData.facade then
      return 0
    end
    return self.playerInfoData.facade.collectionCount or 0
  end
  
  function views:GetRelation()
    if not self.playerInfoData or not self.playerInfoData.facade then
      Logger.Warn("[social] data exception:", self.playerInfoData, "facade:", self.playerInfoData and self.playerInfoData.facade)
      return ""
    end
    return self.playerInfoData.facade.relation or SocialDefine.SocialRelationType.UnAtten
  end
  
  function views:HasAssistReward()
    do return end
    return SocialDataUtils.HasAssisReward
  end
  
  function views:GetDisplayAwakers()
    if not self.playerInfoData or not self.playerInfoData.facade then
      Logger.Warn("[social] data exception:", self.playerInfoData, "facade:", self.playerInfoData and self.playerInfoData.facade)
      return ""
    end
    local team = self.playerInfoData.facade.team and self.playerInfoData.facade.team.team
    if not team then
      return ""
    end
    local displayAwakers = {}
    for _, awakerInfo in pairs(team) do
      table.insert(displayAwakers, awakerInfo)
    end
    return displayAwakers
  end
  
  function views:GetAssistAwakerWeapons()
    return data.assistAwakerWeapons
  end
  
  function views:GetAssistAwakerSkills()
    return data.assistAwakerSkills
  end
  
  function views:GetAssistAwakerTalents()
    return data.assistAwakerTalents
  end
  
  function views:GetAssistAwakerTrinkets()
    return data.assistAwakerTrinkets
  end
  
  function views:GetAssistAwaker()
    if not self.playerInfoData then
      Logger.Warn("[social] data exception:", self.playerInfoData)
      return
    end
    if not self.playerInfoData.facade or not self.playerInfoData.facade.team then
      Logger.Warn("[social] data exception:", table.tostring(self.playerInfoData.facade), ", team:", self.playerInfoData.facade and table.tostring(self.playerInfoData.facade.team))
      return
    end
    return self.playerInfoData.facade.team.assistAwaker
  end
  
  function views:CheckNameValid(name)
    if not name then
      return
    end
    if name == self:GetRoleName() then
      Alert.Show(10628)
      return false
    end
    if not StrUtils.IsCnJpAlphaNum(name) then
      Alert.Show(10624)
      return false
    end
    local nameLength = DT.GetOriginalConstant("NameLengthRange")
    local nameLengthMin = nameLength[1]
    local nameLengthMax = nameLength[2]
    local length = StrUtils.GetCharLen(name)
    if nameLengthMin > length or nameLengthMax < length then
      local tipCfg = DT.TipsType[10629]
      Alert.ShowStr(LT.Textf(tipCfg.Desc, nameLengthMin, nameLengthMax))
      return false
    end
    return true
  end
  
  function views:GetAwakerInfoByAwakerTid(awakerTid)
    if type(awakerTid) ~= "number" then
      awakerTid = tonumber(awakerTid)
    end
    if not AwakerDataUtils.HasOwnedAwaker(awakerTid) then
      return
    end
    local awakerData = AwakerDataUtils.GetAwakerData(awakerTid)
    if not awakerData then
      return
    end
    local awakerInfo = {
      tid = awakerData.tid,
      level = awakerData.level,
      likeLevel = awakerData.likeLevel,
      potencyLevel = AwakerDataUtils.GetAwakerPotencyIndex(awakerData.tid, awakerData.potency)
    }
    return awakerInfo
  end
  
  function views:GetRelationDropDatas(parentNode, clickMaskCb)
    local facade = self.playerInfoData.facade
    local dropGroupData = {
      dropList = {
        {
          text = LT.Text("FriendGame"),
          callback = function()
            FriendMatchMgr.Instance:LaunchFriendGame(facade)
          end,
          checkUnlockFunc = function()
            do return FriendMatchMgr.Instance.IsCanFriendGame, FriendMatchMgr.Instance end
            return FriendMatchMgr.Instance.IsCanFriendGame, FriendMatchMgr.Instance, facade
          end
        },
        {
          text = LT.Text("SocialSystemModifyRemarks"),
          callback = function()
            local panelData = {
              title = LT.Text("SocialSystemSetRemarks"),
              tips = LT.Textf("SocialSystemLeaveNoteName", SocialDataUtils.GetPlayerName(facade)),
              oriName = LT.Text(SocialDataUtils.GetPlayerName(facade, true)),
              confirmFunc = function(nickName, cb)
                if "" == nickName then
                  SocialDataUtils.ReqOnCancelNote(facade.uid, cb)
                else
                  SocialDataUtils.ReqOnSocialNote(facade.uid, nickName, function()
                    local myPlayer = SocialDataUtils.GetMyPlayer()
                    if myPlayer and myPlayer.uid2NickName then
                      myPlayer.uid2NickName[facade.uid] = nickName
                    end
                    if cb then
                      cb()
                    end
                  end)
                end
              end,
              inputFieldDefaultStr = LT.Text("SocialSystemEnterNoteName")
            }
            UIManager.Instance:Reopen(Urls.SocialRenamePanel, panelData)
          end
        }
      },
      parentNode = parentNode,
      maskClickFunc = function()
        if clickMaskCb then
          clickMaskCb(true)
        end
      end
    }
    if facade.relation == SocialDefine.SocialRelationType.Ban then
      table.insert(dropGroupData.dropList, {
        text = LT.Text("TextCancelBan"),
        callback = function()
          SocialDataUtils.CancelBan(facade.uid)
        end
      })
    else
      table.insert(dropGroupData.dropList, {
        text = LT.Text("SocialSystemCancelFollow"),
        callback = function()
          local tipsId = 20102
          local tipsCfg = DT.TipsType[tipsId]
          Alert.Show(tipsId, nil, function()
            SocialDataUtils.ReqOnSocialCancelAttention(facade.uid)
          end, nil, LT.Textf(tipsCfg.Desc, LT.Text(SocialDataUtils.GetPlayerName(facade))))
        end
      })
    end
    return dropGroupData
  end
  
  return views
end

local function _IsSameUidList(oldList, newList)
  if oldList == newList then
    return true
  end
  for pos = 1, CommonDefine.MaxEquipTrinketsNum do
    local oldUid = oldList and oldList[pos] or 0
    local newUid = newList and newList[pos] or 0
    if oldUid ~= newUid then
      return false
    end
  end
  return true
end

local function createSocialPlayerInfoModelActions(data)
  local actions = {}
  
  function actions:RefreshByInitData(initData)
    fillSocialPlayerInfoModel(self, initData)
    self:InitAwakerDetailData()
  end
  
  function actions:InitAwakerDetailData()
    local previewAwakerData = SocialDataUtils.GetPreviewAwakerData()
    if not previewAwakerData then
      return
    end
    if previewAwakerData.awaker then
      self:SetAssistAwakerWeapons(SocialDataUtils.GetPreviewAwakerWeaponUids())
      self:SetAssistAwakerTrinkets(SocialDataUtils.GetPreviewAwakerTrinketUids())
      self:SetAssistAwakerTalents(previewAwakerData.awaker.talents)
      if previewAwakerData.awaker.slots then
        self:SetAssistAwakerSkills(previewAwakerData.awaker.slots)
      end
    end
    if previewAwakerData.items and not data.isMyInfo then
      if ItemDataUtils.HandleMockDataLock then
        ItemDataUtils.AddMockItemData(previewAwakerData.items)
      else
        ItemDataUtils.InitMockItemData(previewAwakerData.items)
        ItemDataUtils.OpenHandleMockDataLock(Urls.SocialPlayerInfoPanel)
      end
    end
  end
  
  function actions:SetBirthday(month, day)
    if not month or not day then
      return
    end
    local birthday = string.format("%s-%s", month, day)
    self.playerInfoData.facade.birthday = birthday
  end
  
  function actions:SetPage(pg)
    if not pg then
      return
    end
    self.page = pg
  end
  
  function actions:UpdateRelation(relation)
    if not relation then
      return
    end
    self.playerInfoData.facade.relation = relation
    EventMgr.Instance.UpdateSocialEvent:Dispatch(self.playerInfoData.facade.uid, relation)
  end
  
  function actions:OnUpdateRelation(uid, relation)
    if uid == self.playerInfoData.facade.uid then
      self:UpdateRelation(relation)
    end
  end
  
  function actions:RequestNextRenameTimestamp(callback)
    ProtoManager.Instance:ReqServer("GameRequest", "OnChangeNameTime", function(svrData)
      callback(svrData.expireTime)
    end)
  end
  
  function actions:RequestRename(name, callback)
    ProtoManager.Instance:ReqServer("GameRequest", "OnChangeName", function()
      self:SetName(name)
      callback()
    end, nil, name)
  end
  
  function actions:SetName(name)
    if not self:CheckNameValid(name) then
      return
    end
    self.playerInfoData.facade.name = name
  end
  
  function actions:SetNote(note)
    self.playerInfoData.facade.note = note
  end
  
  function actions:SetAssistAwakerSkills(tbl)
    data.assistAwakerSkills = tbl
  end
  
  function actions:SetAssistAwakerWeapons(weaponUids)
    if _IsSameUidList(data.assistAwakerWeapons, weaponUids) then
      return
    end
    data.assistAwakerWeapons = weaponUids
  end
  
  function actions:SetAssistAwakerTrinkets(trinketsUids)
    if _IsSameUidList(data.assistAwakerTrinkets, trinketsUids) then
      return
    end
    data.assistAwakerTrinkets = trinketsUids
  end
  
  function actions:SetAssistAwakerTalents(talents)
    data.assistAwakerTalents = talents
  end
  
  function actions:SetAvatar(avatarTid)
    if not avatarTid or type(avatarTid) ~= "number" then
      return
    end
    self.playerInfoData.facade.icon = avatarTid
    DataCenter.playerData.DRole.icon = avatarTid
  end
  
  function actions:SetAvatarFrame(frameTid)
    if not frameTid or type(frameTid) ~= "number" then
      return
    end
    self.playerInfoData.facade.avatarFrame = frameTid
    DataCenter.playerData.DRole.avatarFrame = frameTid
  end
  
  function actions:AddLikeNum(num)
    if not num or num < 0 then
      return
    end
    self.playerInfoData.goodNum = (self.playerInfoData.goodNum or 0) + num
  end
  
  function actions:UpdateAssistAwaker(tid)
    if not tid then
      return
    end
    local myPlayer = SocialDataUtils.GetMyPlayer()
    if not (myPlayer and myPlayer.facade) or not myPlayer.facade.team then
      return
    end
    local awakerInfo = self:GetAwakerInfoByAwakerTid(tid)
    if not awakerInfo then
      return
    end
    myPlayer.facade.team.assistAwaker = awakerInfo
  end
  
  function actions:UpdateGainAssistRewardTimes()
    local myPlayer = SocialDataUtils.GetMyPlayer()
    if not myPlayer then
      return
    end
    myPlayer.gainAssistRewardTime = myPlayer.assistRewardTimes
  end
  
  function actions:UpdatePlayerInfoData(dt)
    if not dt or type(dt) ~= "table" then
      return
    end
    self.playerInfoData = dt
  end
  
  function actions:UpdateShowAwakers(tids)
    if not tids then
      return
    end
    local myPlayer = SocialDataUtils.GetMyPlayer()
    if not (myPlayer and myPlayer.facade) or not myPlayer.facade.team then
      return
    end
    local team = {}
    for i = 1, #tids do
      local tid = tids[i]
      local awakerInfo = self:GetAwakerInfoByAwakerTid(tid)
      if not awakerInfo then
      else
        team[tid] = awakerInfo
      end
    end
    myPlayer.facade.team.team = team
  end
  
  return actions
end

local function onSetup(binder, model)
  binder:BindEvent(EventMgr.Instance.SocialAttention, System.fn(model, model.OnUpdateRelation))
end

local SocialPlayerInfoModel = Vue.model("SocialPlayerInfoModel", createSocialPlayerInfoModelState):views(createSocialPlayerInfoModelViews):actions(createSocialPlayerInfoModelActions):setup(onSetup)
return SocialPlayerInfoModel
