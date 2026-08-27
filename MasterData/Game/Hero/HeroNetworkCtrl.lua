local HeroNetworkCtrl = class("HeroNetworkCtrl", NetworkCtrlBase)
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance
local HeroEnterDataUtil = require("Game.HeroEnter.HeroEnterDataUtil")
local CheckerTypeId, _ = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
local util = require("XLua.Common.xlua_util")
local CommonRewardData = require("Game.CommonUI.CommonRewardData")
local LastSendType = {
  HeroLevelUp = 1,
  HeroSkillUp = 3,
  HeroPotential = 4,
  HeroQuest = 5
}

function HeroNetworkCtrl:ctor()
  self.reqHeroDetailTab = {}
  self.lastSendDataList = {}
  self.sendFormationData = {}
  self.fmtNameFreshData = {}
  self.heroSkinChange = {}
  self.heroRecordMsg = {}
  self.heroQuestMsg = {}
  self.mergeMsg = {}
  self.subDungeonMsg = {}
  self.recommandDungeon = {}
  self.talentLevel = {}
  self.talentChoice = {}
  self.changeFavorMsg = {}
  self.changeHideL2dBg = {}
  self._SkinUpgradeTab = {}
  self.changeOpenL2dSfx = {}
  self.heroGoLevel = {}
  self.__onUpdateHeroEvent = BindCallback(self, self.OnUpdateHeroEvent)
  MsgCenter:AddListener(eMsgEventId.UpdateHero, self.__onUpdateHeroEvent)
end

function HeroNetworkCtrl:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_HERO_AddStar, self, proto_csmsg.SC_HERO_AddStar, self.On_SC_HERO_AddStar)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_HERO_SkillUpgrade, self, proto_csmsg.SC_HERO_SkillUpgrade, self.On_SC_HERO_SkillUpgrade)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_HERO_FormationFresh, self, proto_csmsg.SC_HERO_FormationFresh, self.On_SC_HERO_FormationFresh)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_HERO_FormationNameFresh, self, proto_csmsg.SC_HERO_FormationNameFresh, self.SC_HERO_FormationNameFresh)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_RECOMMANDFORMATION_Detail, self, proto_csmsg.SC_RECOMMANDFORMATION_Detail, self.SC_RECOMMANDFORMATION_Detail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_RECOMMANDFORMATION_DungeonDetail, self, proto_csmsg.SC_RECOMMANDFORMATION_DungeonDetail, self.SC_RECOMMANDFORMATION_DungeonDetail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_HERO_PotentialUpgrade, self, proto_csmsg.SC_HERO_PotentialUpgrade, self.SC_HERO_PotentialUpgrade)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_HERO_SkinChange, self, proto_csmsg.SC_HERO_SkinChange, self.SC_HERO_SkinChange)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_HERO_Record, self, proto_csmsg.SC_HERO_Record, self.SC_HERO_Record)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_HERO_Upgrade, self, proto_csmsg.SC_HERO_Upgrade, self.SC_HERO_Upgrade)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_HERO_QuestFinish, self, proto_csmsg.SC_HERO_QuestFinish, self.SC_HERO_QuestFinish)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_QUEST_HeroOneKeyPick, self, proto_csmsg.SC_QUEST_HeroOneKeyPick, self.SC_QUEST_HeroOneKeyPick)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_HERO_MERGE, self, proto_csmsg.SC_HERO_MERGE, self.SC_HERO_MERGE)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_HEROREVERT_Detail, self, proto_csmsg.SC_HEROREVERT_Detail, self.SC_HEROREVERT_Detail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_HEROREVERT_Exec, self, proto_csmsg.SC_HEROREVERT_Exec, self.SC_HEROREVERT_Exec)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_HERO_SUB_DUNGEON, self, proto_csmsg.SC_HERO_SUB_DUNGEON, self.SC_HERO_SUB_DUNGEON)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_HERO_TALENT_Detail, self, proto_csmsg.SC_HERO_TALENT_Detail, self.SC_HERO_TALENT_Detail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_HERO_TALENT_Upgrade, self, proto_csmsg.SC_HERO_TALENT_Upgrade, self.SC_HERO_TALENT_Upgrade)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_HERO_TALENT_CHOICE, self, proto_csmsg.SC_HERO_TALENT_CHOICE, self.SC_HERO_TALENT_CHOICE)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_HERO_FAVOR, self, proto_csmsg.SC_HERO_FAVOR, self.SC_HERO_FAVOR)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_HERO_Skin_L2D_Hide, self, proto_csmsg.SC_HERO_Skin_L2D_Hide, self.SC_HERO_Skin_L2D_Hide)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_HERO_Skin_L2D_Audio_Turn, self, proto_csmsg.SC_HERO_Skin_L2D_Audio_Turn, self.SC_HERO_Skin_L2D_Audio_Turn)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_HERO_Skin_Upgrade, self, proto_csmsg.SC_HERO_Skin_Upgrade, self.SC_HERO_Skin_Upgrade)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_HERO_GoLevel, self, proto_csmsg.SC_HERO_GoLevel, self.SC_HERO_GoLevel)
end

function HeroNetworkCtrl:SC_HERO_Upgrade(msg)
  if msg.ret and msg.ret ~= proto_csmsg_ErrorCode.None then
    table.remove(self.lastSendDataList, 1)
    local err = "add hero exp error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_HERO_Upgrade)
  end
  if msg.syncUpdateDiff == nil then
    error("msg.syncUpdateDiff is nil")
  end
  if msg.syncUpdateDiff.hero == nil then
    error("msg.syncUpdateDiff.hero is nil")
  end
  if msg.syncUpdateDiff.hero.update == nil then
    error("msg.syncUpdateDiff.hero.update is nil")
  end
  local heroUpdateDic = msg.syncUpdateDiff.hero.update
  if heroUpdateDic == nil then
    error("Don't have heroDiff")
  elseif table.count(heroUpdateDic) ~= 1 then
    error("Has mult hero data change, please check")
  end
  local heroDataDiff, heroData
  local dataDiffDic = {}
  for heroId, heroMsg in pairs(heroUpdateDic) do
    heroData = PlayerDataCenter:GetHeroData(heroId)
    local skillLevelDic = {}
    for skillId, skillData in pairs(heroData.skillDic) do
      skillLevelDic[skillId] = skillData.level
    end
    heroDataDiff = {
      heroId = heroId,
      oldLevel = heroData.level,
      oldExp = heroData.curExp
    }
    dataDiffDic[heroId] = heroDataDiff
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_HERO_Upgrade, dataDiffDic)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function HeroNetworkCtrl:On_SC_HERO_SkillUpgrade(msg)
  if msg.ret and msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "add skill level error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    table.remove(self.lastSendDataList, 1)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.CS_HERO_SkillUpgrade)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function HeroNetworkCtrl:On_SC_HERO_FormationFresh(msg)
  if msg.ret and msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "hero formation fresh error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_HERO_FormationFresh)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function HeroNetworkCtrl:SaveLastHeroData(saveLast, heroData)
  saveLast.heroId = heroData.dataId
  saveLast.level = heroData.level
  saveLast.star = heroData.star
  saveLast.rank = heroData.rank
  saveLast.fightingPower = heroData:GetFightingPower()
  saveLast.attr = {}
  saveLast.skill = {}
  saveLast.heroData = heroData
  for k, v in pairs(eHeroShowAttrList) do
    saveLast.attr[v] = heroData:GetAttr(v, nil, true)
  end
  for k, v in pairs(heroData.skillDic) do
    if v:GetIsUnlock() then
      saveLast.skill[k] = v
    end
  end
  saveLast.athslotList = heroData:GetAthSlotList()
end

function HeroNetworkCtrl:CS_HERO_Upgrade(heroId, targetLevel, callback)
  local msgTab = {hero = heroId, aimLv = targetLevel}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_HERO_Upgrade, proto_csmsg.CS_HERO_Upgrade, msgTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_HERO_Upgrade, callback, proto_csmsg_MSG_ID.MSG_SC_HERO_Upgrade)
  local heroData = PlayerDataCenter.heroDic[heroId]
  if heroData ~= nil then
    local saveLast = {}
    saveLast.type = LastSendType.HeroLevelUp
    self:SaveLastHeroData(saveLast, heroData)
    table.insert(self.lastSendDataList, saveLast)
  end
end

function HeroNetworkCtrl:SendHeroAddStar(heroId, callback)
  local msgTab = {hero = heroId}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_HERO_AddStar, proto_csmsg.CS_HERO_AddStar, msgTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_HERO_AddStar, proto_csmsg_MSG_ID.MSG_SC_HERO_AddStar)
  self.heroAddStarCallbacl = callback
end

function HeroNetworkCtrl:On_SC_HERO_AddStar(msg)
  if msg.ret and msg.ret ~= proto_csmsg_ErrorCode.None then
    table.remove(self.lastSendDataList, 1)
    local err = "add hero star error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_HERO_AddStar)
    self.heroAddStarCallbacl = nil
  end
  local starupDataDiff, heroData, itemIds, itemCounts = self:_GetHeroStarDiffData(msg)
  if self.__starUpCoroutine ~= nil then
    GR.StopCoroutine(self.__starUpCoroutine)
    self.__starUpCoroutine = nil
  end
  self.__starUpCoroutine = GR.StartCoroutine(util.cs_generator(BindCallback(self, self._ShowHeroStarWindows, starupDataDiff, heroData, itemIds, itemCounts)))
end

function HeroNetworkCtrl:_GetHeroStarDiffData(msg)
  local heroDiffMsg = msg.syncUpdateDiff.hero
  if heroDiffMsg == nil then
    error("star up don't have heroDiff")
  end
  local heroUpdateDic = heroDiffMsg.update
  if heroUpdateDic == nil then
    error("star up don't have heroDiff")
  elseif table.count(heroUpdateDic) ~= 1 then
    error("starup has mult hero data change, please check")
  end
  local starupDataDiff, heroData, rewardDiff
  for heroId, heroMsg in pairs(heroUpdateDic) do
    heroData = PlayerDataCenter:GetHeroData(heroId)
    local skillLevelDic = {}
    for skillId, skillData in pairs(heroData.skillDic) do
      skillLevelDic[skillId] = skillData.level
    end
    starupDataDiff = {
      heroId = heroId,
      oldRank = heroData.rank,
      oldpower = heroData:GetFightingPower(),
      oldAthslotList = heroData:GetAthSlotList(),
      oldSkillLevelDic = skillLevelDic
    }
  end
  local updatesMsg = msg.syncUpdateDiff.resource.backpack.updates
  if updatesMsg ~= nil then
    rewardDiff = {}
    for itemId, count in pairs(updatesMsg) do
      rewardDiff[itemId] = PlayerDataCenter:GetItemCount(itemId)
    end
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  MsgCenter:Broadcast(eMsgEventId.PreCondition, CheckerTypeId.MinHeroStar)
  MsgCenter:Broadcast(eMsgEventId.PreCondition, CheckerTypeId.MaxHeroStar)
  starupDataDiff.curRank = heroData.rank
  starupDataDiff.curPower = heroData:GetFightingPower()
  starupDataDiff.curAthslotList = heroData:GetAthSlotList()
  local skillLevelDic = {}
  for skillId, skillData in pairs(heroData.skillDic) do
    skillLevelDic[skillId] = skillData.level
  end
  starupDataDiff.skillLevelDic = skillLevelDic
  MsgCenter:Broadcast(eMsgEventId.OnHeroRankChange, starupDataDiff.heroId)
  local itemIds, itemCounts
  if rewardDiff ~= nil then
    itemIds = {}
    itemCounts = {}
    for itemId, data in pairs(updatesMsg) do
      local count = data.count - rewardDiff[itemId]
      if 0 < count then
        table.insert(itemIds, itemId)
        table.insert(itemCounts, count)
      end
    end
  end
  return starupDataDiff, heroData, itemIds, itemCounts
end

function HeroNetworkCtrl:_ShowHeroStarWindows(starupDataDiff, heroData, itemIds, itemCounts)
  local getHeroComplete = false
  UIManager:ShowWindowAsync(UIWindowTypeID.GetHero, function(window)
    if window == nil then
      return
    end
    local skinId = heroData.skinId or 0
    local preRankCfg = ConfigData.hero_star[starupDataDiff.heroId][starupDataDiff.curRank]
    if preRankCfg ~= nil then
      for index, itemId in ipairs(preRankCfg.rank_itemIds) do
        local itemConfig = ConfigData.item[itemId]
        if itemConfig ~= nil and itemConfig.type == eItemType.Skin and PlayerDataCenter.skinData:IsSkinUnlocked(itemId) then
          skinId = itemId
          self:CS_HERO_SkinChange(starupDataDiff.heroId, skinId or 0)
          break
        end
      end
    end
    window:InitGetHeroList({
      starupDataDiff.heroId
    }, true, nil, nil, nil, nil, {
      [starupDataDiff.heroId] = skinId
    })
    window:SetCloseFunction(function()
      getHeroComplete = true
    end)
    AudioManager:PlayAudioById(1024)
    if self.heroAddStarCallbacl ~= nil then
      self.heroAddStarCallbacl()
      self.heroAddStarCallbacl = nil
    end
  end)
  while not getHeroComplete do
    coroutine.yield()
  end
  local starUpSuccess = false
  UIManager:ShowWindowAsync(UIWindowTypeID.HeroStarUpSuccess, function(win)
    win:InitStarUpSuccess(starupDataDiff)
    win:SetStarUpSuccessCloseCallBack(function()
      starUpSuccess = true
    end)
  end)
  while not starUpSuccess do
    coroutine.yield()
  end
  local PowerUpSuccess = false
  UIManager:ShowWindowAsync(UIWindowTypeID.HeroPowerUpSuccess, function(win)
    if win ~= nil then
      win:InitHeroPowerUpSuccess(starupDataDiff.oldpower, starupDataDiff.curPower)
      win:SetBackClickAction(function()
        PowerUpSuccess = true
      end)
    end
  end)
  while not PowerUpSuccess do
    coroutine.yield()
  end
  if #itemIds <= 0 then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
    local CRData = CommonRewardData.CreateCRDataUseList(itemIds, itemCounts)
    window:AddAndTryShowReward(CRData)
  end)
end

function HeroNetworkCtrl:SendHeroSkillUp(heroId, skillId, callback)
  local msgTab = {hero = heroId, skill = skillId}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_HERO_SkillUpgrade, proto_csmsg.CS_HERO_SkillUpgrade, msgTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_HERO_SkillUpgrade, callback, proto_csmsg_MSG_ID.MSG_SC_HERO_SkillUpgrade)
  local saveLast = {}
  saveLast.type = LastSendType.HeroSkillUp
  saveLast.heroId = heroId
  saveLast.skillId = skillId
  saveLast.fightingPower = PlayerDataCenter:GetHeroData(heroId):GetFightingPower()
  table.insert(self.lastSendDataList, saveLast)
end

function HeroNetworkCtrl:OnUpdateHeroEvent(heroList)
  if #self.lastSendDataList == 0 then
    return
  end
  local lastData = table.remove(self.lastSendDataList, 1)
  if lastData.type == LastSendType.HeroLevelUp then
    if lastData.level < lastData.heroData.level then
      local win = UIManager:ShowWindow(UIWindowTypeID.MessageSide)
      if win ~= nil then
        local number = lastData.heroData:GetFightingPower() - lastData.fightingPower
        win:ShowTips(number, 2.5, eMessageSideType.efficiency)
      end
    end
  elseif lastData.type == LastSendType.HeroSkillUp then
    local curHeroData = PlayerDataCenter.heroDic[lastData.heroId]
    if curHeroData ~= nil then
      local win = UIManager:ShowWindow(UIWindowTypeID.MessageSide)
      if win ~= nil then
        local number = curHeroData:GetFightingPower() - lastData.fightingPower
        win:ShowTips(number, 2.5, eMessageSideType.efficiency)
      end
      local skillData = curHeroData.skillDic[lastData.skillId]
      if skillData ~= nil and skillData.type == eHeroSkillType.LifeSkill then
        HeroEnterDataUtil:OnLifeSkillLevelUp(skillData)
      end
    end
  elseif lastData.type == LastSendType.HeroPotential then
  end
end

function HeroNetworkCtrl:SendFormationFresh(formationId, data, fairyUid)
  self.sendFormationData.id = formationId
  self.sendFormationData.data = data
  self.sendFormationData.fairyUid = fairyUid
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_HERO_FormationFresh, proto_csmsg.CS_HERO_FormationFresh, self.sendFormationData)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_HERO_FormationFresh, proto_csmsg_MSG_ID.MSG_SC_HERO_FormationFresh)
  self.sendFormationData.data = nil
end

function HeroNetworkCtrl:CS_HERO_FormationNameFresh(fmtId, name, callBack)
  self.fmtNameFreshData.id = fmtId
  self.fmtNameFreshData.name = name
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_HERO_FormationNameFresh, proto_csmsg.CS_HERO_FormationNameFresh, self.fmtNameFreshData)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_HERO_FormationNameFresh, callBack, proto_csmsg_MSG_ID.MSG_SC_HERO_FormationNameFresh)
end

function HeroNetworkCtrl:SC_HERO_FormationNameFresh(msg)
  if msg.ret == proto_csmsg_ErrorCode.None then
  elseif msg.ret == proto_csmsg_ErrorCode.INVALID_CHARACTER_INPUT then
    CS.MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.name_Illegal))
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_HERO_FormationNameFresh)
    local formationUI = UIManager:GetWindow(UIWindowTypeID.Formation)
    if formationUI ~= nil then
      formationUI.topNode:OnEditFormationNameError()
    end
  else
    local errorMsg = "HeroNetworkCtrl:SC_HERO_FormationNameFresh error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(errorMsg)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_HERO_FormationNameFresh)
    local formationUI = UIManager:GetWindow(UIWindowTypeID.Formation)
    if formationUI ~= nil then
      formationUI.topNode:OnEditFormationNameError()
    end
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function HeroNetworkCtrl:_OnShowbackpackUpdates(msgUpdates)
  if msgUpdates == nil then
    return
  end
  local itemIds = {}
  local itemCounts = {}
  for itemId, count in pairs(msgUpdates) do
    if 0 < count then
      table.insert(itemIds, itemId)
      table.insert(itemCounts, count)
    end
  end
  if #itemIds <= 0 then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
    local CRData = CommonRewardData.CreateCRDataUseList(itemIds, itemCounts)
    window:AddAndTryShowReward(CRData)
  end)
end

function HeroNetworkCtrl:CS_RECOMMANDFORMATION_Detail(stageId)
  local sendData = {Id = stageId, version = 2}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_RECOMMANDFORMATION_Detail, proto_csmsg.CS_RECOMMANDFORMATION_Detail, sendData)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_RECOMMANDFORMATION_Detail, proto_csmsg_MSG_ID.MSG_SC_RECOMMANDFORMATION_Detail)
end

function HeroNetworkCtrl:SC_RECOMMANDFORMATION_Detail(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local errorMsg = "HeroNetworkCtrl:SC_RECOMMANDFORMATION_Detail error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(errorMsg)
    return
  end
  NetworkManager.networkDiffDeliver:HandleDiff(msg.syncUpdateDiff)
  local recommeCtr = ControllerManager:GetController(ControllerTypeId.RecommeFormation, true)
  recommeCtr:ReceiveRecommeFormationNew(msg)
end

function HeroNetworkCtrl:CS_RECOMMANDFORMATION_DungeonDetail(dungeonId)
  self.recommandDungeon.id = dungeonId
  self.recommandDungeon.version = 2
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_RECOMMANDFORMATION_DungeonDetail, proto_csmsg.CS_RECOMMANDFORMATION_DungeonDetail, self.recommandDungeon)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_RECOMMANDFORMATION_DungeonDetail, proto_csmsg_MSG_ID.MSG_SC_RECOMMANDFORMATION_DungeonDetail)
end

function HeroNetworkCtrl:SC_RECOMMANDFORMATION_DungeonDetail(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local errorMsg = "HeroNetworkCtrl:SC_RECOMMANDFORMATION_DungeonDetail error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(errorMsg)
    return
  end
  NetworkManager.networkDiffDeliver:HandleDiff(msg.syncUpdateDiff)
  local recommeCtr = ControllerManager:GetController(ControllerTypeId.RecommeFormation, true)
  recommeCtr:ReceiveDunRecommeFormationNew(msg)
end

function HeroNetworkCtrl:CS_HERO_PotentialUpgrade(heroId, callBack)
  local sendData = {hero = heroId}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_HERO_PotentialUpgrade, proto_csmsg.CS_HERO_PotentialUpgrade, sendData)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_HERO_PotentialUpgrade, callBack, proto_csmsg_MSG_ID.MSG_SC_HERO_PotentialUpgrade)
  local heroData = PlayerDataCenter.heroDic[heroId]
  if heroData ~= nil then
    local saveLast = {}
    saveLast.type = LastSendType.HeroPotential
    self:SaveLastHeroData(saveLast, heroData)
    table.insert(self.lastSendDataList, saveLast)
  end
end

function HeroNetworkCtrl:SC_HERO_PotentialUpgrade(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local errorMsg = "HeroNetworkCtrl:SC_HERO_PotentialUpgrade error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(errorMsg)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_HERO_PotentialUpgrade)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_HERO_PotentialUpgrade, self.lastSendDataList[#self.lastSendDataList])
  NetworkManager.networkDiffDeliver:HandleDiff(msg.syncUpdateDiff)
end

function HeroNetworkCtrl:CS_HERO_SkinChange(heroId, skinId, callback)
  local isSkinUnlcok = false
  if skinId == 0 then
    local heroCfg = ConfigData.hero_data[heroId]
    if heroCfg == nil then
      error("hero not exist heroId:" .. tostring(heroId))
      return
    end
    local realSkinId = heroCfg.default_skin
    isSkinUnlcok = PlayerDataCenter.skinData:IsSkinUnlocked(realSkinId)
  else
    isSkinUnlcok = PlayerDataCenter.skinData:IsSkinUnlocked(skinId)
  end
  if not isSkinUnlcok then
    error("skin is locked")
    return
  end
  self.heroSkinChange = {hero = heroId, skin = skinId}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_HERO_SkinChange, proto_csmsg.CS_HERO_SkinChange, self.heroSkinChange)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_HERO_PotentialUpgrade, callback, proto_csmsg_MSG_ID.MSG_SC_HERO_SkinChange)
end

function HeroNetworkCtrl:SC_HERO_SkinChange(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local errorMsg = "HeroNetworkCtrl:SC_HERO_SkinChange error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(errorMsg)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_HERO_SkinChange)
  end
  NetworkManager.networkDiffDeliver:HandleDiff(msg.syncUpdateDiff)
  if msg.ret == proto_csmsg_ErrorCode.None then
    MsgCenter:Broadcast(eMsgEventId.OnHeroSkinChange, self.heroSkinChange.hero, self.heroSkinChange.skin)
  end
end

function HeroNetworkCtrl:CS_HERO_Skin_Upgrade(heroId, skinId, callback)
  self._SkinUpgradeTab.hero = heroId
  self._SkinUpgradeTab.skin = skinId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_HERO_Skin_Upgrade, proto_csmsg.CS_HERO_Skin_Upgrade, self._SkinUpgradeTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_HERO_Skin_Upgrade, callback, proto_csmsg_MSG_ID.MSG_SC_HERO_Skin_Upgrade)
end

function HeroNetworkCtrl:SC_HERO_Skin_Upgrade(msg)
  NetworkManager.networkDiffDeliver:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local errorMsg = "HeroNetworkCtrl:SC_HERO_Skin_Upgrade error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(errorMsg)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_HERO_Skin_Upgrade)
    return
  end
  PlayerDataCenter.skinData:UpdSkinUpgrade(self._SkinUpgradeTab.skin)
  ControllerManager:GetController(ControllerTypeId.Skin, true):TryAdjSkinUpgrage(self._SkinUpgradeTab.hero, self._SkinUpgradeTab.skin)
  MsgCenter:Broadcast(eMsgEventId.OnHeroSkinUpgrade, self._SkinUpgradeTab.hero, self._SkinUpgradeTab.skin)
end

function HeroNetworkCtrl:CS_HERO_Record(heroId, type, val, callBack)
  self.heroRecordMsg.heroId = heroId
  self.heroRecordMsg.typ = type
  self.heroRecordMsg.val = val
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_HERO_Record, proto_csmsg.CS_HERO_Record, self.heroRecordMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_HERO_Record, callBack, proto_csmsg_MSG_ID.MSG_SC_HERO_Record)
end

function HeroNetworkCtrl:SC_HERO_Record(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local errorMsg = "HeroNetworkCtrl:SC_HERO_Record error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(errorMsg)
    return
  end
  NetworkManager.networkDiffDeliver:HandleDiff(msg.syncUpdateDiff)
end

function HeroNetworkCtrl:CS_HERO_QuestFinish(heroId, idx, callBack)
  self.heroQuestMsg.heroId = heroId
  self.heroQuestMsg.idx = idx
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_HERO_QuestFinish, proto_csmsg.CS_HERO_QuestFinish, self.heroQuestMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_HERO_QuestFinish, callBack, proto_csmsg_MSG_ID.MSG_SC_HERO_QuestFinish)
end

function HeroNetworkCtrl:SC_HERO_QuestFinish(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local errorMsg = "HeroNetworkCtrl:SC_HERO_QuestFinish error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(errorMsg)
    return
  end
  NetworkManager.networkDiffDeliver:HandleDiff(msg.syncUpdateDiff)
end

function HeroNetworkCtrl:CS_QUEST_HeroOneKeyPick(heroId, idxs, backAction)
  local msg = {}
  msg.heroId = heroId
  msg.idx = idxs
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_QUEST_HeroOneKeyPick, proto_csmsg.CS_QUEST_HeroOneKeyPick, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_QUEST_HeroOneKeyPick, backAction, proto_csmsg_MSG_ID.MSG_SC_QUEST_HeroOneKeyPick)
end

function HeroNetworkCtrl:SC_QUEST_HeroOneKeyPick(msg)
  local items = {}
  for itemId, num in pairs(msg.rewards) do
    local itemCfg = ConfigData.item[itemId]
    if not itemCfg.is_shielded then
      table.insert(items, {
        id = itemId,
        warehouse_order = itemCfg.warehouse_order,
        count = num
      })
    end
  end
  table.sort(items, function(a, b)
    if a.warehouse_order == b.warehouse_order then
      return a.id < b.id
    else
      return a.warehouse_order < b.warehouse_order
    end
  end)
  local rewardIds = {}
  local rewardNums = {}
  for k, v in pairs(items) do
    table.insert(rewardIds, v.id)
    table.insert(rewardNums, v.count)
  end
  if 0 < #rewardIds then
    self._heroIdSnapShoot = PlayerDataCenter:TakeHeroIdSnapShoot()
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      if window == nil then
        return
      end
      local CRData = CommonRewardData.CreateCRDataUseList(rewardIds, rewardNums):SetCRHeroSnapshoot(self._heroIdSnapShoot, false):SetCRNotHandledGreat(true)
      window:AddAndTryShowReward(CRData)
    end)
  end
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local errorMsg = "HeroNetworkCtrl:SC_QUEST_HeroOneKeyPick error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(errorMsg)
    return
  end
  NetworkManager.networkDiffDeliver:HandleDiff(msg.syncUpdateDiff)
end

function HeroNetworkCtrl:CS_HERO_MERGE(frageItemId, callBack)
  self.mergeMsg.itemId = frageItemId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_HERO_MERGE, proto_csmsg.CS_HERO_MERGE, self.mergeMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_HERO_MERGE, callBack, proto_csmsg_MSG_ID.MSG_SC_HERO_MERGE)
end

function HeroNetworkCtrl:SC_HERO_MERGE(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local errorMsg = "HeroNetworkCtrl:SC_HERO_MERGE error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(errorMsg)
    return
  end
  NetworkManager.networkDiffDeliver:HandleDiff(msg.syncUpdateDiff)
end

function HeroNetworkCtrl:CS_HEROREVERT_Detail()
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_HEROREVERT_Detail, proto_csmsg.CS_HEROREVERT_Detail, table.emptytable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_HEROREVERT_Detail, proto_csmsg_MSG_ID.MSG_SC_HEROREVERT_Detail)
end

function HeroNetworkCtrl:SC_HEROREVERT_Detail(msg)
  NetworkManager.networkDiffDeliver:HandleDiff(msg.syncUpdateDiff)
  PlayerDataCenter:UpdateHeroBackOffData(msg.data)
end

function HeroNetworkCtrl:CS_HEROREVERT_Exec(actId, heroId)
  local sendMsg = {}
  sendMsg.actId = actId
  sendMsg.heroId = heroId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_HEROREVERT_Exec, proto_csmsg.CS_HEROREVERT_Exec, sendMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_HEROREVERT_Exec, proto_csmsg_MSG_ID.MSG_SC_HEROREVERT_Exec)
end

function HeroNetworkCtrl:SC_HEROREVERT_Exec(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local errorMsg = "HeroNetworkCtrl:SC_HEROREVERT_Exec error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(errorMsg)
    return
  end
  NetworkManager.networkDiffDeliver:HandleDiff(msg.syncUpdateDiff)
end

function HeroNetworkCtrl:CS_HERO_SUB_DUNGEON(heroId, callback)
  self.subDungeonMsg.heroId = heroId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_HERO_SUB_DUNGEON, proto_csmsg.CS_HERO_SUB_DUNGEON, self.subDungeonMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_HERO_SUB_DUNGEON, callback, proto_csmsg_MSG_ID.MSG_SC_HERO_SUB_DUNGEON)
end

function HeroNetworkCtrl:SC_HERO_SUB_DUNGEON(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local errorMsg = "HeroNetworkCtrl:SC_HERO_SUB_DUNGEON error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(errorMsg)
    return
  end
  NetworkManager.networkDiffDeliver:HandleDiff(msg.syncUpdateDiff)
end

function HeroNetworkCtrl:CS_HERO_TALENT_Detail()
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_HERO_TALENT_Detail, proto_csmsg.CS_HERO_TALENT_Detail, table.emptytable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_HERO_TALENT_Detail, proto_csmsg_MSG_ID.MSG_SC_HERO_TALENT_Detail)
end

function HeroNetworkCtrl:SC_HERO_TALENT_Detail(msg)
  if msg.data ~= nil then
    PlayerDataCenter.allHeroTalentData:UpdateHeroTalent(msg.data.talents)
  end
end

function HeroNetworkCtrl:CS_HERO_TALENT_Upgrade(heroId, nodeId, callback)
  self.talentLevel.heroId = heroId
  self.talentLevel.nodeId = nodeId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_HERO_TALENT_Upgrade, proto_csmsg.CS_HERO_TALENT_Upgrade, self.talentLevel)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_HERO_TALENT_Upgrade, callback, proto_csmsg_MSG_ID.MSG_SC_HERO_TALENT_Upgrade)
end

function HeroNetworkCtrl:SC_HERO_TALENT_Upgrade(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local errorMsg = "HeroNetworkCtrl:SC_HERO_TALENT_Upgrade error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(errorMsg)
  elseif msg.reward ~= nil and table.count(msg.reward) > 0 then
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      if window == nil then
        return
      end
      local rewardIds = {}
      local rewardNums = {}
      for itemId, itemNum in pairs(msg.reward) do
        table.insert(rewardIds, itemId)
        table.insert(rewardNums, itemNum)
      end
      local CommonRewardData = require("Game.CommonUI.CommonRewardData")
      local CRData = CommonRewardData.CreateCRDataUseList(rewardIds, rewardNums)
      window:AddAndTryShowReward(CRData)
    end)
  end
  NetworkManager.networkDiffDeliver:HandleDiff(msg.syncUpdateDiff)
end

function HeroNetworkCtrl:CS_HERO_TALENT_CHOICE(heroId, nodeId, branchId)
  self.talentChoice.heroId = heroId
  self.talentChoice.nodeId = nodeId
  self.talentChoice.newIdx = branchId - 1
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_HERO_TALENT_CHOICE, proto_csmsg.CS_HERO_TALENT_CHOICE, self.talentChoice)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_HERO_TALENT_CHOICE, proto_csmsg_MSG_ID.MSG_SC_HERO_TALENT_CHOICE)
end

function HeroNetworkCtrl:SC_HERO_TALENT_CHOICE(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local errorMsg = "HeroNetworkCtrl:SC_HERO_TALENT_CHOICE error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(errorMsg)
  else
    PlayerDataCenter.allHeroTalentData:SetHeroTalentBranch(self.talentChoice.heroId, self.talentChoice.nodeId, self.talentChoice.newIdx + 1)
  end
  NetworkManager.networkDiffDeliver:HandleDiff(msg.syncUpdateDiff)
end

function HeroNetworkCtrl:SC_HERO_TALENT_SyncDiff(msg)
  PlayerDataCenter.allHeroTalentData:UpdateHeroTalent(msg.update)
end

function HeroNetworkCtrl:CS_HERO_FAVOR(favorList, removeList, callback)
  self.changeFavorMsg.toFavorId = favorList
  self.changeFavorMsg.toRemoveId = removeList
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_HERO_FAVOR, proto_csmsg.CS_HERO_FAVOR, self.changeFavorMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_HERO_FAVOR, callback, proto_csmsg_MSG_ID.MSG_SC_HERO_FAVOR)
end

function HeroNetworkCtrl:SC_HERO_FAVOR(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local errorMsg = "HeroNetworkCtrl:SC_HERO_FAVOR error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(errorMsg)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.CS_HERO_FAVOR)
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.CS_HERO_FAVOR, msg)
end

function HeroNetworkCtrl:CS_HERO_Skin_L2D_Hide(heroId, skinId, isHide)
  self.changeHideL2dBg.hero = heroId
  self.changeHideL2dBg.skin = skinId
  self.changeHideL2dBg.hide = isHide
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_HERO_Skin_L2D_Hide, proto_csmsg.CS_HERO_Skin_L2D_Hide, self.changeHideL2dBg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_HERO_Skin_L2D_Hide, proto_csmsg_MSG_ID.MSG_SC_HERO_Skin_L2D_Hide)
end

function HeroNetworkCtrl:SC_HERO_Skin_L2D_Hide(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local errorMsg = "HeroNetworkCtrl:SC_HERO_Skin_L2D_Hide error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(errorMsg)
  else
    PlayerDataCenter.skinData:UpdateHideL2dBg(self.changeHideL2dBg.hero, self.changeHideL2dBg.skin, self.changeHideL2dBg.hide)
  end
  NetworkManager.networkDiffDeliver:HandleDiff(msg.syncUpdateDiff)
end

function HeroNetworkCtrl:CS_HERO_Skin_L2D_Audio_Turn(heroId, skinId, isClose)
  self.changeOpenL2dSfx.hero = heroId
  self.changeOpenL2dSfx.skin = skinId
  self.changeOpenL2dSfx.off = isClose
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_HERO_Skin_L2D_Audio_Turn, proto_csmsg.CS_HERO_Skin_L2D_Audio_Turn, self.changeOpenL2dSfx)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_HERO_Skin_L2D_Audio_Turn, proto_csmsg_MSG_ID.MSG_SC_HERO_Skin_L2D_Audio_Turn)
end

function HeroNetworkCtrl:SC_HERO_Skin_L2D_Audio_Turn(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local errorMsg = "HeroNetworkCtrl:SC_HERO_Skin_L2D_Audio_Turn error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(errorMsg)
  else
    PlayerDataCenter.skinData:UpdateOpenLive2dSfx(self.changeOpenL2dSfx.skin, self.changeOpenL2dSfx.off)
  end
  NetworkManager.networkDiffDeliver:HandleDiff(msg.syncUpdateDiff)
end

function HeroNetworkCtrl:CS_HERO_GoLevel(heroId, itemId, callback)
  self.heroGoLevel.heroId = heroId
  self.heroGoLevel.itemId = itemId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_HERO_GoLevel, proto_csmsg.CS_HERO_GoLevel, self.heroGoLevel)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_HERO_GoLevel, callback, proto_csmsg_MSG_ID.MSG_SC_HERO_GoLevel)
end

function HeroNetworkCtrl:SC_HERO_GoLevel(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local errorMsg = "HeroNetworkCtrl:SC_HERO_GoLevel error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_HERO_GoLevel)
  end
  local starupDataDiff = self:_GetHeroStarDiffData(msg)
  UIManager:ShowWindowAsync(UIWindowTypeID.HeroPowerUpSuccess, function(win)
    if win ~= nil then
      win:InitHeroPowerUpSuccess(starupDataDiff.oldpower, starupDataDiff.curPower)
    end
  end)
end

function HeroNetworkCtrl:Reset()
  self.lastSendDataList = {}
  self.lastSendFormation = {}
  if self.__starUpCoroutine ~= nil then
    GR.StopCoroutine(self.__starUpCoroutine)
    self.__starUpCoroutine = nil
  end
end

return HeroNetworkCtrl
