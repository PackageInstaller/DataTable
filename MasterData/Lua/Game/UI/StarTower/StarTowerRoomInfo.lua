local StarTowerRoomInfo = class("StarTowerRoomInfo", BaseCtrl)
StarTowerRoomInfo._mapNodeConfig = {
  contentRoot = {
    sNodeName = "----SafeAreaRoot----"
  },
  canvasGroup = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "CanvasGroup"
  },
  Title = {},
  txtLevelTitle = {sComponentName = "TMP_Text"},
  txtLevelLayer = {sComponentName = "TMP_Text"},
  TeamLevel = {},
  imgLevelBar = {sComponentName = "Image"},
  imgLevelBarAdd = {sComponentName = "Image"},
  txtLevelCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Reward_Level"
  },
  txtTeamLevel = {sComponentName = "TMP_Text"},
  Tips = {
    sCtrlName = "Game.UI.StarTower.DiscTips.StarTowerTipsCtrl"
  },
  IconSuccessAni = {
    sNodeName = "IconSuccess",
    sComponentName = "Animator"
  },
  ImgIconSuccess = {
    sComponentName = "RectTransform"
  },
  IconSuccess = {
    sComponentName = "RectTransform"
  },
  BossChallenge = {
    sCtrlName = "Game.UI.StarTower.RoomInfo.StarTowerBossChallengeCtrl"
  }
}
StarTowerRoomInfo._mapEventConfig = {
  ShowStarTowerLevelTitle = "OnEvent_ShowLevelTitle",
  ShowStarTowerRoomInfo = "OnEvent_ShowRoomInfo",
  ShowBattleReward = "OnEvent_ShowBattleReward",
  RefreshFateCard = "OnEvent_RefreshFateCard",
  FateCardCountChange = "OnEvent_FateCardCountChange",
  StarTowerSetButtonEnable = "OnEvent_StarTowerSetButtonEnable",
  InputEnable = "OnEvent_InputEnable",
  OpenBossTime = "OnEvent_OpenBossTime",
  CloseBossTime = "OnEvent_CloseBossTime",
  StarTowerEventInteract = "OnEvent_StarTowerEventInteract",
  StarTowerShopInteract = "OnEvent_StarTowerShopInteract",
  RefreshStarTowerCoin = "OnEvent_SetCoin",
  StarTowerShowReward = "OnEvent_StarTowerShowReward",
  ShowShopStrengthFx = "OnEvent_ShowShopStrengthFx",
  ShowNPCAffinity = "OnEvent_AffinityTips",
  ShowDiscLoseTips = "OnEvent_DiscLoseTips",
  PlayEnterShopRoomCharVoice = "PlayEnterRoomCharVoice"
}

function StarTowerRoomInfo:GetTeamNeedExpByLevel(nGroupId, nLevel)
  local bMaxLevel = false
  local nNeedExp = 0
  if CacheTable.GetData("_StarTowerTeamExpGroup", nGroupId) ~= nil then
    local nMaxLevel = #CacheTable.GetData("_StarTowerTeamExpGroup", nGroupId)
    bMaxLevel = nLevel >= nMaxLevel
    if nLevel < nMaxLevel then
      local expCfg = CacheTable.GetData("_StarTowerTeamExpGroup", nGroupId)[nLevel + 1]
      nNeedExp = expCfg.NeedExp
    end
  end
  return nNeedExp, bMaxLevel
end

function StarTowerRoomInfo:RefreshLevel()
  local nAllExp, bMaxLevel = self:GetTeamNeedExpByLevel(1, self.nTeamLevel)
  if bMaxLevel then
    NovaAPI.SetImageFillAmount(self._mapNode.imgLevelBar, 1)
    NovaAPI.SetImageFillAmount(self._mapNode.imgLevelBarAdd, 1)
  else
    NovaAPI.SetImageFillAmount(self._mapNode.imgLevelBar, self.nExp / nAllExp)
    NovaAPI.SetImageFillAmount(self._mapNode.imgLevelBarAdd, self.nExp / nAllExp)
  end
  NovaAPI.SetTMPText(self._mapNode.txtTeamLevel, self.nTeamLevel)
  NovaAPI.SetImageColor(self._mapNode.imgLevelBarAdd, Color(1, 1, 1, 0))
end

function StarTowerRoomInfo:RefreshFateCard()
  self.tbFateCard = {}
  for k, v in pairs(self.mapFateCard) do
    local nCount = math.max(v[1], v[2])
    if 0 < nCount then
      table.insert(self.tbFateCard, {
        nId = k,
        nCount = nCount,
        nSort = 0 < nCount and 1 or 0
      })
    end
  end
  table.sort(self.tbFateCard, function(a, b)
    if a.nSort == b.nSort then
      if a.nCount == b.nCount then
        return a.nId < b.nId
      end
      return a.nCount < b.nCount
    end
    return a.nSort > b.nSort
  end)
  if #self.tbFateCard > 0 then
    self._mapNode.FateCard.gameObject:SetActive(true)
    for k, v in ipairs(self._mapNode.goFateCardItem) do
      v.gameObject:SetActive(self.tbFateCard[k] ~= nil)
      if self.tbFateCard[k] ~= nil then
        v:SetFateCardItem(self.tbFateCard[k].nId, self.tbFateCard[k].nCount)
      end
    end
  else
    self._mapNode.FateCard.gameObject:SetActive(false)
  end
end

function StarTowerRoomInfo:ShowTips(mapItem)
  local tbTips = {}
  if next(mapItem) ~= nil then
    for nId, nCount in pairs(mapItem) do
      table.insert(tbTips, {
        bSkill = false,
        nTid = nId,
        nCount = nCount,
        nTipType = AllEnum.StarTowerTipsType.ItemTip
      })
    end
  end
  self._mapNode.Tips:StartShowTips(tbTips)
end

function StarTowerRoomInfo:ShowTipsAffinity(nNpcId, nAffinity)
  local tbTips = {}
  table.insert(tbTips, {
    nNPCId = nNpcId,
    nAffinity = nAffinity,
    nTipType = AllEnum.StarTowerTipsType.NPCAffinity
  })
  self._mapNode.Tips:StartShowTips(tbTips)
end

function StarTowerRoomInfo:ShowLevelChange(nLevelChange, nExpChange)
  NovaAPI.SetImageColor(self._mapNode.imgLevelBarAdd, Color(1, 1, 1, 0))
  local nTime = 0
  local sequence = DOTween.Sequence()
  if nLevelChange ~= nil and 0 < nLevelChange then
    local nCurLv = self.nTeamLevel
    self.nTeamLevel = self.nTeamLevel + nLevelChange
    for i = 1, nLevelChange do
      nTime = nTime + 0.2
      sequence:Append(NovaAPI.ImageDoFillAmount(self._mapNode.imgLevelBar, 1, 0.2), false)
      sequence:Join(NovaAPI.ImageDoFillAmount(self._mapNode.imgLevelBarAdd, 1, 0.2), false)
      sequence:Join(NovaAPI.ImageDoColor(self._mapNode.imgLevelBarAdd, Color(1, 1, 1, 1), 0.2), false)
      sequence:AppendCallback(function()
        NovaAPI.SetImageFillAmount(self._mapNode.imgLevelBar, 0)
        NovaAPI.SetImageFillAmount(self._mapNode.imgLevelBarAdd, 0)
        NovaAPI.SetImageColor(self._mapNode.imgLevelBarAdd, Color(1, 1, 1, 0))
        NovaAPI.SetTMPText(self._mapNode.txtTeamLevel, nCurLv + i)
        CS.AdventureModuleHelper.PlayTeamUpgradeFX()
      end)
      sequence:SetUpdate(true)
    end
  end
  self.nExp = nExpChange
  if 0 < nExpChange then
    nTime = nTime + 0.2
    local nAllExp = self:GetTeamNeedExpByLevel(1, self.nTeamLevel)
    sequence:Append(NovaAPI.ImageDoFillAmount(self._mapNode.imgLevelBar, nExpChange / nAllExp, 0.2, true))
    sequence:Join(NovaAPI.ImageDoFillAmount(self._mapNode.imgLevelBarAdd, nExpChange / nAllExp, 0.2, true))
    sequence:Join(NovaAPI.ImageDoColor(self._mapNode.imgLevelBarAdd, Color(1, 1, 1, 1), 0.2, true))
    sequence:Append(NovaAPI.ImageDoColor(self._mapNode.imgLevelBarAdd, Color(1, 1, 1, 0), 0.2, true))
    sequence:AppendCallback(function()
      NovaAPI.SetImageColor(self._mapNode.imgLevelBarAdd, Color(1, 1, 1, 0))
    end)
    sequence:SetUpdate(true)
  end
  return nTime
end

function StarTowerRoomInfo:FateCardChange(mapFateCard)
  local nFailureCount = 0
  local nFailureId = 0
  for _, v in ipairs(mapFateCard) do
    local nId = v[1]
    if v[4] == -1 then
      self.mapFateCard[nId] = nil
      nFailureCount = nFailureCount + 1
      nFailureId = nId
      printLog("移除命运卡" .. nId)
    elseif v[4] == 0 then
      self.mapFateCard[nId] = {
        v[2],
        v[3]
      }
      printLog(string.format("命运卡层数变化  id = [%s]  层数[%s]", nId, math.max(v[2], v[3])))
    elseif v[4] == 1 then
      printLog("新获得命运卡" .. nId)
      self.mapFateCard[nId] = {
        v[2],
        v[3]
      }
    end
  end
  return 0
end

function StarTowerRoomInfo:PlayEnterRoomCharVoice(nLevel, nRoomType)
  if self._panel.nStarTowerId == 999 then
    return
  end
  local sVoiceKey = ""
  if nLevel == 1 then
    local tbPool = {"chat"}
    if self._panel.nLastStarTowerId ~= 0 then
      local mapLastCfg = ConfigTable.GetData("StarTower", self._panel.nLastStarTowerId)
      local mapCurCfg = ConfigTable.GetData("StarTower", self._panel.nStarTowerId)
      if mapCurCfg.Difficulty > mapLastCfg.Difficulty then
        table.insert(tbPool, "chatLvUp")
      end
      if mapCurCfg.GroupId ~= mapLastCfg.GroupId then
        table.insert(tbPool, "chatNext")
      end
    end
    local tbSortPool = {}
    for _, v in ipairs(tbPool) do
      local mapVoiceCfg = ConfigTable.GetData("CharacterVoiceControl", v)
      local nPriority = mapVoiceCfg.priority
      table.insert(tbSortPool, {sKey = v, nPriority = nPriority})
    end
    table.sort(tbSortPool, function(a, b)
      return a.nPriority > b.nPriority
    end)
    sVoiceKey = tbSortPool[1].sKey
  elseif nRoomType == GameEnum.starTowerRoomType.ShopRoom then
    math.randomseed(os.time())
    local bRes = 1 < math.random(1, 2)
    if bRes then
      local tbLines = ConfigTable.GetData("NPCConfig", 9133).Lines
      local nAffinity = PlayerData.StarTower:GetNpcAffinityData(9133).nTotalExp
      local tbChat = {}
      if nAffinity ~= nil then
        local function fcTalk(mapTalkCfg)
          local sVoice = mapTalkCfg.Voice
          
          if #mapTalkCfg.Affinity == 2 and string.find(sVoice, "vo_npc133_event_lv") ~= nil and nAffinity >= mapTalkCfg.Affinity[1] and nAffinity <= mapTalkCfg.Affinity[2] then
            table.insert(tbChat, mapTalkCfg.Id)
          end
        end
        
        ForEachTableLine(DataTable.StarTowerTalk, fcTalk)
      end
      if #tbChat < 1 then
        table.insert(tbChat, tbLines[1])
      end
      local nCount = #tbChat
      local nTalkId = tbChat[1]
      if 1 < nCount then
        nTalkId = tbChat[math.random(1, #tbChat)]
      end
      if nTalkId == nil then
        nTalkId = 0
      end
      if 0 < nTalkId then
        mapTalkData = ConfigTable.GetData("StarTowerTalk", nTalkId)
        if mapTalkData ~= nil then
          CS.WwiseAudioManager.Instance:WwiseVoice_PlayInAVG(mapTalkData.Voice)
          return
        end
      end
    else
      sVoiceKey = "shopRoom"
    end
  elseif nRoomType == GameEnum.starTowerRoomType.EventRoom then
    sVoiceKey = "eventRoom"
  end
  if sVoiceKey ~= "" then
    PlayerData.Voice:PlayCharVoice(sVoiceKey, 0)
  end
end

function StarTowerRoomInfo:PlayBattleResultVoice()
  PlayerData.Voice:PlayCharVoice("battleClear", 0)
end

function StarTowerRoomInfo:Awake()
  self.mapNoteCount = {}
  self.mapFateCard = {}
end

function StarTowerRoomInfo:OnEnable()
  self._mapNode.TeamLevel.gameObject:SetActive(false)
  self._mapNode.Tips.gameObject:SetActive(false)
  self._mapNode.IconSuccess.gameObject:SetActive(false)
  self._mapNode.Title.gameObject:SetActive(false)
  self._mapNode.BossChallenge.gameObject:SetActive(false)
end

function StarTowerRoomInfo:OnEvent_ShowRoomInfo(bShow, nTeamLevel, nExp, mapNote, mapFateCard)
  self:OnEvent_StarTowerSetButtonEnable(_, bShow)
  self._mapNode.TeamLevel.gameObject:SetActive(bShow)
  self._mapNode.Tips.gameObject:SetActive(bShow)
  EventManager.Hit("ShowRoomInfoNote", bShow, mapNote)
  if bShow then
    self.nTeamLevel = nTeamLevel
    self.nExp = nExp
    self:RefreshLevel()
    self.mapNoteCount = mapNote
    self:OnEvent_RefreshFateCard(mapFateCard)
  else
  end
end

function StarTowerRoomInfo:OnEvent_ShowBattleReward(nLevelChange, nExpChange, mapFateCard, mapNoteChange, mapItem, callback)
  local nTime = 0
  if 0 < nLevelChange then
    nTime = nTime + nLevelChange * 0.2
  end
  if 0 < nExpChange then
    nTime = nTime + 0.2
  end
  if mapNoteChange ~= nil and next(mapNoteChange) ~= nil then
    nTime = nTime + 0.2
  end
  self:ShowLevelChange(nLevelChange, nExpChange)
  nTime = math.max(nTime, 2)
  self:AddTimer(1, nTime + 0.5, function()
    self:ShowTips(mapItem)
  end, true, true)
  EventManager.Hit("ShowRoomInfoNote", true)
  EventManager.Hit("StarTowerSetButtonEnable", true, false)
  
  local function showFinishCall()
    EventManager.Hit("StarTowerSetButtonEnable", true, true)
  end
  
  if callback ~= nil and type(callback) == "function" then
    callback(nTime, showFinishCall)
  end
  self:PlayBattleResultVoice()
  CS.WwiseAudioManager.Instance:SetState("combat", "explore")
end

function StarTowerRoomInfo:OnEvent_ShowLevelTitle(nLevel, nTotalLevel, nRoomType)
  local function delayShowTitle()
    self._mapNode.Title.gameObject:SetActive(true)
    
    local sTitle = ConfigTable.GetUIText(AllEnum.StarTowerRoomName[nRoomType].Language)
    NovaAPI.SetTMPText(self._mapNode.txtLevelTitle, sTitle)
    local sLayer = ""
    if nRoomType == GameEnum.starTowerRoomType.HorrorRoom or nRoomType == GameEnum.starTowerRoomType.DangerRoom then
      sLayer = "?"
    else
      sLayer = orderedFormat("{0}/{1}", nLevel, nTotalLevel)
    end
    NovaAPI.SetTMPText(self._mapNode.txtLevelLayer, orderedFormat(ConfigTable.GetUIText("StarTower_Level_Title_Layer") or "", sLayer))
    self:AddTimer(1, 2, function()
      self._mapNode.Title.gameObject:SetActive(false)
    end, true, true, true)
  end
  
  self:AddTimer(1, 0.5, delayShowTitle, true, true, true)
  if nRoomType ~= GameEnum.starTowerRoomType.ShopRoom then
    local nVoiceDelay = ConfigTable.GetConfigNumber("StarTowerPlayerVoiceDelay")
    self:AddTimer(1, nVoiceDelay, function()
      self:PlayEnterRoomCharVoice(nLevel, nRoomType)
    end, true, true, true)
  end
end

function StarTowerRoomInfo:OnEvent_IconSuccessAni(rtTransform, callback)
  self._mapNode.IconSuccess.gameObject:SetActive(true)
  self._mapNode.ImgIconSuccess.gameObject:SetActive(true)
  self._mapNode.IconSuccessAni:Play("ImgIconSuccess_in")
  CS.WwiseAudioManager.Instance:PostEvent("ui_roguelike_feedback_clean")
  
  local function TweenAnim()
    local tweener = self._mapNode.ImgIconSuccess:DOMove(rtTransform.position, 0.3):SetUpdate(true)
    
    local function _cb()
      self._mapNode.ImgIconSuccess.gameObject:SetActive(false)
      self._mapNode.ImgIconSuccess.anchoredPosition = Vector2.zero
      if callback ~= nil then
        callback()
      end
    end
    
    tweener.onComplete = dotween_callback_handler(self, _cb)
  end
  
  self:AddTimer(1, 0.6, TweenAnim, true, true, true)
  
  local function EndCallback()
    self._mapNode.IconSuccess.gameObject:SetActive(false)
  end
  
  self:AddTimer(1, 3, EndCallback, true, true, true)
end

function StarTowerRoomInfo:OnEvent_RefreshFateCard(mapFateCard)
  local mapFateCardChange = {}
  local nFateCardId = 0
  if next(self.mapFateCard) ~= nil then
    for id, v in pairs(mapFateCard) do
      if nil ~= self.mapFateCard[id] and v[2] == 0 and 0 < self.mapFateCard[id][2] then
        table.insert(mapFateCardChange, id)
        nFateCardId = id
      end
    end
  end
  if 0 < nFateCardId then
    local fateCardCfg = ConfigTable.GetData_Item(nFateCardId)
    local tbTips = {}
    for _, id in ipairs(mapFateCardChange) do
      table.insert(tbTips, {
        nFateCardId = id,
        nTipType = AllEnum.StarTowerTipsType.FateCardTip
      })
    end
    self._mapNode.Tips:StartShowTips(tbTips)
  end
  self.mapFateCard = mapFateCard
end

function StarTowerRoomInfo:OnEvent_FateCardCountChange(nFateCardId)
  if nil ~= self.mapFateCard[nFateCardId] then
    self.mapFateCard[nFateCardId][1] = self.mapFateCard[nFateCardId][1] - 1
    if self.mapFateCard[nFateCardId][1] == 0 then
      local tbTips = {}
      table.insert(tbTips, {
        nFateCardId = nFateCardId,
        nTipType = AllEnum.StarTowerTipsType.FateCardTip
      })
      self._mapNode.Tips:StartShowTips(tbTips)
    end
  end
end

function StarTowerRoomInfo:OnEvent_AffinityTips(nNpcId, nAffinity)
  self:ShowTipsAffinity(nNpcId, nAffinity)
end

function StarTowerRoomInfo:OnEvent_DiscLoseTips(tbTips)
  self._mapNode.Tips:StartShowTips(tbTips)
end

function StarTowerRoomInfo:OnEvent_InputEnable(bEnable)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.canvasGroup, bEnable == true and 1 or 0)
  NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.canvasGroup, bEnable == true)
  NovaAPI.SetCanvasGroupInteractable(self._mapNode.canvasGroup, bEnable == true)
end

function StarTowerRoomInfo:OnEvent_StarTowerSetButtonEnable(bShow, bEnable)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.canvasGroup, bShow == true and 1 or 0)
  NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.canvasGroup, bEnable == true)
  NovaAPI.SetCanvasGroupInteractable(self._mapNode.canvasGroup, bEnable == true)
end

function StarTowerRoomInfo:OnEvent_OpenBossTime(nStage, nType, callback)
  local nStarTowerId = self._panel.nStarTowerId
  if CacheTable.GetData("_StarTowerLimitReward", nStarTowerId) == nil then
    printError("StarTowerLimitReward表中找不到星塔配置！！！星塔id = " .. tostring(nStarTowerId))
    return
  elseif CacheTable.GetData("_StarTowerLimitReward", nStarTowerId)[nStage] == nil then
    printError("StarTowerLimitReward表中找不到星塔stage配置!!!  stage = " .. tostring(nStage))
    return
  end
  local mapData = CacheTable.GetData("_StarTowerLimitReward", nStarTowerId)[nStage][nType]
  if mapData == nil then
    return
  end
  self._mapNode.BossChallenge:StartEvent(mapData.TimeLimit, 2)
  self._mapNode.BossChallenge.gameObject:SetActive(true)
  self.nEventId = 99
end

function StarTowerRoomInfo:OnEvent_CloseBossTime(bSuccess)
  if self.nEventId == 99 then
    if bSuccess then
      self._mapNode.BossChallenge:Success()
    else
      self._mapNode.BossChallenge:EventEnd()
    end
    self.nEventId = nil
  end
end

function StarTowerRoomInfo:OnEvent_StarTowerEventInteract(mapNoteChange, mapItemChange, mapPotentialChange, tbChangeFateCard, mapChangeSecondarySkill)
  local tbRewardList = {}
  if mapItemChange ~= nil then
    for nTid, nCount in pairs(mapItemChange) do
      local itemCfg = ConfigTable.GetData_Item(nTid)
      if itemCfg ~= nil and itemCfg.Stype ~= GameEnum.itemStype.SubNoteSkill then
        if nCount < 0 then
          local sIcon = string.gsub(itemCfg.Icon2, "Icon/ZZZOther/", "")
          local sTip = orderedFormat(ConfigTable.GetUIText("StarTower_Coin_Reduce_Tip") or "", math.abs(nCount), sIcon)
          EventManager.Hit(EventId.OpenMessageBox, {
            nType = AllEnum.MessageBox.Tips,
            sContent = sTip
          })
        elseif 0 < nCount then
          local nHasCount = self.nCoinCount or 0
          table.insert(tbRewardList, {
            id = nTid,
            count = nCount,
            nHasCount = nHasCount
          })
        end
      end
    end
  end
  if 0 < #tbRewardList then
    local mapReward = {
      tbReward = tbRewardList,
      tbSpReward = {},
      tbSrc = {},
      tbDst = {}
    }
    EventManager.Hit("StarTowerReward", mapReward)
  end
  if next(mapPotentialChange) ~= nil then
    local tbPotential = {}
    local tbConsumePotential = {}
    for nId, v in pairs(mapPotentialChange) do
      if v.nNextLevel < v.nLevel then
        table.insert(tbConsumePotential, {
          nId = nId,
          nLevel = v.nLevel,
          nNextLevel = v.nNextLevel
        })
      else
        table.insert(tbPotential, {
          nId = nId,
          nLevel = v.nLevel,
          nNextLevel = v.nNextLevel
        })
      end
    end
    if 0 < #tbConsumePotential then
      local sTips = ""
      for k, v in ipairs(tbConsumePotential) do
        local itemCfg = ConfigTable.GetData_Item(v.nId)
        if itemCfg ~= nil then
          sTips = sTips .. itemCfg.Title
          if k ~= #tbConsumePotential then
            sTips = sTips .. "、"
          end
        end
      end
      sTips = orderedFormat(ConfigTable.GetUIText("StarTower_Potential_Consume_Tips") or "", sTips)
      EventManager.Hit(EventId.OpenMessageBox, {
        nType = AllEnum.MessageBox.Tips,
        sContent = sTips
      })
    end
    if 0 < #tbPotential then
      EventManager.Hit("PotentialLevelUp", tbPotential)
    end
  end
  local tbRemove = {}
  local tbAdd = {}
  if nil ~= tbChangeFateCard then
    for _, v in ipairs(tbChangeFateCard) do
      local nId = v[1]
      if v[4] == -1 then
        table.insert(tbRemove, nId)
      elseif v[4] == 2 then
        table.insert(tbAdd, nId)
      end
    end
    if 0 < #tbRemove then
      local sName = ""
      for k, v in ipairs(tbRemove) do
        local mapFateCardCfg = ConfigTable.GetData("FateCard", v)
        if mapFateCardCfg ~= nil then
          sName = sName .. mapFateCardCfg.Name
          if k < #tbRemove then
            sName = sName .. "、"
          end
        end
      end
      local sTip = orderedFormat(ConfigTable.GetUIText("StarTower_FateCard_Remove") or "", sName)
      EventManager.Hit(EventId.OpenMessageBox, {
        nType = AllEnum.MessageBox.Tips,
        sContent = sTip
      })
    end
    if 0 < #tbAdd then
      local sName = ""
      for k, v in ipairs(tbAdd) do
        local mapFateCardCfg = ConfigTable.GetData("FateCard", v)
        if mapFateCardCfg ~= nil then
          sName = sName .. mapFateCardCfg.Name
          if k < #tbAdd then
            sName = sName .. "、"
          end
        end
      end
      local sTip = orderedFormat(ConfigTable.GetUIText("StarTower_FateCard_Add") or "", sName)
      EventManager.Hit(EventId.OpenMessageBox, {
        nType = AllEnum.MessageBox.Tips,
        sContent = sTip
      })
    end
  end
end

function StarTowerRoomInfo:OnEvent_StarTowerShopInteract(mapNoteChange)
  local tbRewardList = {}
  local tbNoteReduceTips = {}
  for nNoteId, mapChangeInfo in pairs(mapNoteChange) do
    if mapChangeInfo.Qty < 0 then
      table.insert(tbNoteReduceTips, {
        nNoteId = nNoteId,
        nNoteQty = mapChangeInfo.Qty,
        nTipType = AllEnum.StarTowerTipsType.NoteTip
      })
    elseif mapChangeInfo.Qty > 0 then
    end
  end
  if 0 < #tbNoteReduceTips then
    EventManager.Hit("StarTowerDiscTips", tbNoteReduceTips)
  end
end

function StarTowerRoomInfo:OnEvent_SetCoin(nCount)
  self.nCoinCount = nCount
end

function StarTowerRoomInfo:OnEvent_StarTowerShowReward(mapReward, callback)
  if mapReward ~= nil then
    UTILS.OpenReceiveByReward(mapReward, callback)
  end
end

function StarTowerRoomInfo:OnEvent_ShowShopStrengthFx(tbParam, callback)
  local nCost = tbParam.nCost
  EventManager.Hit(EventId.OpenMessageBox, orderedFormat(ConfigTable.GetUIText("StarTower_StrengthHint"), nCost))
  CS.AdventureModuleHelper.PlayTeamUpgradeFX()
  NovaAPI.InputDisable()
  self:AddTimer(1, 0.5, function()
    NovaAPI.InputEnable()
    if callback then
      callback()
    end
  end, true, true, true)
end

function StarTowerRoomInfo:OnEvent_InitStarTowerNote(mapNote)
  if mapNote ~= nil then
    self.mapNoteCount = clone(mapNote)
  end
end

return StarTowerRoomInfo
