local DynChipHolder = require("Game.Exploration.Data.DynChipHolder")
local DynPlayer = class("DynPlayer", DynChipHolder)
local ItemData = require("Game.PlayerData.Item.ItemData")
local ChipData = require("Game.PlayerData.Item.ChipData")
local DynHero = require("Game.Exploration.Data.DynHero")
local DynPlayerData = require("Game.PlayerData.DynPlayer.DynPlayerData")
local DynEpBuffChip = require("Game.Exploration.Data.DynEpBuffChip")
local DynBattleSkill = require("Game.Exploration.Data.DynBattleSkill")
local DynCampFetter = require("Game.Exploration.Data.DynCampFetter")
local DynBuff = require("Game.Exploration.Data.DynBuff")
local AllDynServerGrid = require("Game.Exploration.Data.ServerGrid.AllDynServerGrid")
local DynChipSuitMgr = require("Game.Exploration.Data.ChipSuit.DynChipSuitMgr")
local DynRewardBag = require("Game.Exploration.Data.RewardBag.DynRewardBag")
local HeroData = require("Game.PlayerData.Hero.HeroData")
local DynSpecEffectMgr = require("Game.Exploration.Data.SpecEffect.DynSpecEffectMgr")
local DynFairyData = require("Game.Exploration.Data.DynFairyData")
local CS_BattleManager = CS.BattleManager.Instance
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local ChipEnum = require("Game.PlayerData.Item.ChipEnum")
local HeroAttrUtility = require("Game.Exploration.Data.HeroAttrUtility")
local DeployTeamUtil = require("Game.Exploration.Util.DeployTeamUtil")
local WCScorePredict = require("Game.Exploration.Util.WCScorePredict")
local VowEnum = require("Game.VowSystem.Data.VowEnum")
local FairyHelper = require("Game.Fairy.FairyHelper")

function DynPlayer:ctor()
  self.money = 0
  self.energy = 0
  self.dynData = DynPlayerData.New()
  self.playerSkillMp = 0
  self.playerOriginSkillList = {}
  self.dynName = self:__getDynName()
  self.CSTId = nil
  self.cstDic = nil
  self.allItemDic = {}
  self.allItemTypeDic = {}
  for k, v in pairs(eItemType) do
    self.allItemTypeDic[v] = {}
  end
  self.chipLimitInfo = {
    count = 0,
    limit = 0,
    firstLimit = true,
    discardId = nil
  }
  self.chipList = {}
  self.chipDic = {}
  self.epBuffChipDic = {}
  self.tmpBuffChipDic = {}
  self.campFetterDic = {}
  self.activeCampFetterId = nil
  self.epBuffList = {}
  self.__chipSuitMgr = DynChipSuitMgr.New(self)
  self.allDynServerGrid = AllDynServerGrid.New()
  self.dynRewardBag = DynRewardBag.New()
  self.__specEffectMgr = DynSpecEffectMgr.New()
  self.epBattleSkillLockDic = {}
  self.__cacheFightPower = nil
  self.__isHeroInitReady = false
  self.playerClientState = ExplorationEnum.ePlayerClientState.OutSideRoom
  self.WcCurrentScore = 0
  self._newDropActiveAlg = nil
  self._newDropBuffs = {}
  self.__formationRuleCfg = ConfigData.formation_rule[0]
  self.__dynFairyData = nil
end

function DynPlayer:CreateDefaultPlayer(epRoleStc, epRoleDyc, epStc, epStmGoods)
  local epHeros = epRoleStc.heroes
  local fairyStcData = epRoleStc.fairy
  self:InitDynPlayer(0, epHeros, epRoleDyc, epRoleStc.player)
  self:UpdateFormationDetail(epRoleDyc)
  self:UpdateFormationStc(epStc)
  self:UpdataDynFairyData(fairyStcData)
  self.dynRewardBag:InitEpDynRewardBag(epStmGoods)
end

function DynPlayer:InitDynPlayerAttr(attrData)
  if self.dynData == nil then
    return
  end
  self.dynData:RefreshDynData(attrData)
end

function DynPlayer:InitDynPlayer(money, heroDatas, epRoleDyc, playerSkillInfo)
  self.money = money
  self:InitHeroTeam(heroDatas, epRoleDyc)
  self:InitPlayerSkill(playerSkillInfo)
  self:InitCampFetter()
end

function DynPlayer:UpdataDynFairyData(fairyStcData)
  if self.__dynFairyData ~= nil then
    for key, dynHero in pairs(self.heroList) do
      dynHero:RemoveItemSkillTypeDic({
        [eBattleSkillLogicType.Fiary] = true
      })
    end
    self.__dynFairyData = nil
  end
  if fairyStcData == nil then
    self.__dynFairyData = nil
    return
  end
  self.__dynFairyData = DynFairyData.GenDynFairyData(fairyStcData)
  for key, dynHero in pairs(self.heroList) do
    self.__dynFairyData:AddFairySkill2ChipHolder(dynHero)
  end
  self:RefreshCacheFightPower()
end

function DynPlayer:__getDynName()
  return ConfigData:GetTipContent(TipContent.CommanderDPSName)
end

function DynPlayer:InitHeroTeam(heroDatas, epRoleDyc)
  self.heroList = {}
  self.heroDic = {}
  local tmpHeroIndexDic = {}
  for uid, heroElem in pairs(heroDatas) do
    if heroElem ~= nil then
      local heroTeamIndex = epRoleDyc.role.role[uid].dync.formationIdx
      local roleType = epRoleDyc.role.role[uid].roleType
      local heroCfg = ConfigData.hero_data[heroElem.dataId]
      local heroData = HeroData.New({
        basic = {
          id = heroElem.dataId,
          level = heroElem.level,
          exp = 0,
          star = heroElem.rank,
          potentialLvl = heroElem.potential,
          ts = -1,
          career = heroCfg.career,
          company = heroCfg.camp,
          skinId = heroElem.skinId,
          cat = heroElem.cat,
          serverModel = epRoleDyc.role.role[uid].dync.texture,
          name = heroElem.name
        },
        spWeapon = heroElem.specWeapon,
        vow = {
          vowTime = heroElem.vowed and 1 or 0,
          name = heroElem.name
        }
      })
      heroData:SetHeroOverrideName(heroElem.overrideName)
      for k, v in pairs(heroElem.skillGroup) do
        if heroData.skillDic[k] ~= nil then
          heroData.skillDic[k]:UpdateSkill(v)
        end
      end
      local dynHeroData = DynHero.New(heroData, uid, roleType)
      dynHeroData:SetDynHeroFmtIdx(heroTeamIndex)
      dynHeroData:SetDynHeroTalentLevel(heroElem.talent)
      dynHeroData:SetExtraFixedPower(heroElem.talentEfficiency)
      self.heroDic[heroData.dataId] = dynHeroData
      tmpHeroIndexDic[dynHeroData] = heroTeamIndex
      table.insert(self.heroList, dynHeroData)
    end
  end
  table.sort(self.heroList, function(hero1, hero2)
    return tmpHeroIndexDic[hero1] < tmpHeroIndexDic[hero2]
  end)
  self:InitMirrorHeroTeam()
end

function DynPlayer:CheckRoleTypeAndInsertHeroList(dynHeroData, attrDic, skillDic, hpPer)
  if dynHeroData.cat == BattleUtil.battleRoleCat.waitToCasterHero then
    table.insert(self.heroWaitToCasterList, dynHeroData)
  else
  end
  table.insert(self.heroList, dynHeroData)
  self.heroDic[dynHeroData.dataId] = dynHeroData
end

function DynPlayer:CheckAndSortHeroList(tmpHeroIndexDic)
  if #self.heroList > 0 then
    table.sort(self.heroList, function(hero1, hero2)
      return tmpHeroIndexDic[hero1] < tmpHeroIndexDic[hero2]
    end)
  end
  if 0 < #self.heroWaitToCasterList then
    table.sort(self.heroWaitToCasterList, function(hero1, hero2)
      return tmpHeroIndexDic[hero1] < tmpHeroIndexDic[hero2]
    end)
  end
end

function DynPlayer:CreateSupportDynHero(stc)
  local dyc = {coordination = 0, hpPer = 10000}
  local dynHero = self:CreateDynHero(stc, dyc, proto_object_EplBattleRoleType.BattleRoleAssist)
  return dynHero
end

function DynPlayer:CreateDynHeroHeroData(stc, dyc, roleType, roleCat)
  local heroCfg = ConfigData.hero_data[stc.dataId]
  local heroData = HeroData.New({
    basic = {
      id = stc.dataId,
      level = stc.level,
      exp = 0,
      star = stc.rank,
      potentialLvl = stc.potential,
      ts = -1,
      career = heroCfg.career,
      company = heroCfg.camp,
      skinId = stc.skinId,
      cat = roleCat or 0,
      serverModel = dyc.texture
    },
    spWeapon = stc.specWeapon,
    vow = {
      vowTime = stc.vowed and 1 or 0,
      name = stc.name
    }
  })
  for k, v in pairs(stc.skillGroup) do
    if heroData.skillDic[k] ~= nil then
      heroData.skillDic[k]:UpdateSkill(v)
    end
  end
  return heroData
end

function DynPlayer:CreateDynHero(stc, dyc, roleType, roleCat)
  local heroData = self:CreateDynHeroHeroData(stc, dyc, roleType, roleCat)
  local dynHeroData = DynHero.New(heroData, stc.uid, roleType)
  dynHeroData:UpdateHpPer(dyc.hpPer)
  dynHeroData:UpdateBaseHeroData(stc.attr, stc.skillGroup, stc.athSkillGroup, stc.additionSkillGroup, stc.rawAttr)
  dynHeroData:SetDynHeroTalentLevel(stc.talent)
  dynHeroData:SetExtraFixedPower(stc.talentEfficiency)
  return dynHeroData
end

function DynPlayer:ChangeDynPlayerHeroList(enter, quit, change)
  local addHeroList = {}
  local removeHeroList = {}
  for k, role in pairs(change) do
    local changeModle = self:UpdateDynPlayerHeroFull(role)
    if changeModle then
      local dynHeroData = self.heroDic[role.data.stc.dataId]
      table.insert(addHeroList, dynHeroData)
      table.insert(removeHeroList, dynHeroData)
    end
  end
  local newHeroList = {}
  local heroUidDic = {}
  local mirrorHeroDic = {}
  local heroNum = 0
  local benchX = ConfigData.buildinConfig.BenchX
  for k, dynHero in ipairs(self.heroList) do
    local mirrorHero = self.mirrorHeroList[k]
    if quit[dynHero.uid] ~= nil then
      table.insert(removeHeroList, dynHero)
    else
      table.insert(newHeroList, dynHero)
      mirrorHeroDic[mirrorHero.uid] = mirrorHero
      if not dynHero:IsBench() then
        heroNum = heroNum + 1
      end
    end
  end
  local maxStageNum = self:GetEnterFiledNum()
  for k, role in pairs(enter) do
    local dynHero = self:CreateDynHero(role.data.stc, role.data.dyc, role.roleType)
    dynHero:SetDynHeroFmtIdx(role.data.dyc.formationIdx)
    dynHero:SetCoord(role.data.dyc.coordination, benchX)
    dynHero.onBench = heroNum >= maxStageNum
    if not dynHero:IsBench() then
      heroNum = heroNum + 1
    end
    table.insert(newHeroList, dynHero)
    table.insert(addHeroList, dynHero)
    local stc = role.data.stc
    local mirrorHero = DynHero.New(dynHero.heroData, dynHero.uid, role.roleType)
    mirrorHero:UpdateBaseHeroData(stc.attr, stc.skillGroup, stc.athSkillGroup, stc.additionSkillGroup, stc.rawAttr)
    mirrorHero:SetDynHeroTalentLevel(stc.talent)
    mirrorHero:SetExtraFixedPower(stc.talentEfficiency)
    mirrorHeroDic[mirrorHero.uid] = mirrorHero
  end
  table.sort(newHeroList, function(a, b)
    return a:GetDynHeroFmtIdx() < b:GetDynHeroFmtIdx()
  end)
  local newMirrorHeroList = {}
  for k, dynHero in ipairs(newHeroList) do
    newMirrorHeroList[k] = mirrorHeroDic[dynHero.uid]
    heroUidDic[dynHero.uid] = dynHero
  end
  self:SetPlayerNewHeroList(newHeroList, newMirrorHeroList, heroUidDic, mirrorHeroDic, enter)
  for _, dynHero in pairs(removeHeroList) do
    if dynHero.__bindItemSkillDataDic ~= nil then
      for dynSkillData, _ in pairs(dynHero.__bindItemSkillDataDic) do
        self:RemoveItemSkill(dynSkillData)
      end
    end
  end
  return addHeroList, newHeroList, removeHeroList
end

function DynPlayer:SetPlayerNewHeroList(newHeroList, newMirrorHeroList, heroUidDic, mirrorHeroDic, enterHeroUidDic)
  local changeRole = #self.heroList ~= #newHeroList
  self.heroDic = {}
  for k, dynHero in ipairs(newHeroList) do
    self.heroDic[dynHero.dataId] = dynHero
    if not changeRole and self.heroList[k].dataId ~= dynHero.dataId then
      changeRole = true
    end
  end
  self.heroList = newHeroList
  self.mirrorHeroList = newMirrorHeroList
  if changeRole then
    local size_row, size_col, deploy_rows = BattleUtil.GetCurSceneBattleFieldSize()
    DeployTeamUtil.DeployHeroTeam(self.heroList, size_row, size_col, deploy_rows)
  end
  local addHeroList = {}
  for uid, _ in pairs(enterHeroUidDic) do
    local dynHero = heroUidDic[uid]
    table.insert(addHeroList, dynHero)
  end
  if self.__dynFairyData ~= nil then
    for key, dynHero in pairs(addHeroList) do
      self.__dynFairyData:AddFairySkill2ChipHolder(dynHero)
    end
  end
  self:ExecuteAllChip2NewHeroList(addHeroList)
  CS_BattleManager:UpdateBattleRoleData()
  MsgCenter:Broadcast(eMsgEventId.OnEpPlayerHeroDataChange)
  self:RefreshCacheFightPower()
end

function DynPlayer:ExecuteAllChip2NewHeroList(newHeroList)
  for k, chipData in pairs(self.chipList) do
    local validRoleList = chipData:GetValidRoleList(newHeroList, eBattleRoleBelong.player, self.__specEffectMgr)
    for k, v in pairs(validRoleList) do
      chipData:ExecuteChipData(v)
    end
  end
  for k, buffChip in pairs(self.epBuffChipDic) do
    local validRoleList = buffChip:GetValidRoleList(newHeroList, eBattleRoleBelong.player)
    for k, v in pairs(validRoleList) do
      buffChip:ExecuteBuffChip(v)
    end
  end
  self:ExecuteAllSuitChip2NewHeroList(newHeroList)
end

function DynPlayer:ExecuteAllSuitChip2NewHeroList(newHeroList)
  self.__chipSuitMgr:ExecuteAllSuitChipForList(newHeroList, self)
end

function DynPlayer:InitMirrorHeroTeam()
  self.mirrorHeroList = {}
  for k, dynHero in pairs(self.heroList) do
    local dynHeroData = DynHero.New(dynHero.heroData, dynHero.uid, dynHero.roleType)
    table.insert(self.mirrorHeroList, dynHeroData)
  end
  self.mirrorDynPlayer = DynPlayer.New()
end

function DynPlayer:UpdateDynPlayerHeroFull(role)
  local dynHeroData = self.heroDic[role.data.stc.dataId]
  if dynHeroData == nil then
    error("Cant get dynHeroData, heroId:" .. tostring(role.data.stc.dataId))
    return
  end
  local oldModelPath = PathConsts:GetCharacterModelPathEx(dynHeroData:GetResModelName())
  local stc = role.data.stc
  local dyc = role.data.dyc
  local heroData = self:CreateDynHeroHeroData(role.data.stc, role.data.dyc, role.roleType)
  dynHeroData:InitDynHeroData(heroData, stc.uid, role.roleType)
  dynHeroData:UpdateHpPer(dyc.hpPer)
  dynHeroData:UpdateBaseHeroData(stc.attr, stc.skillGroup, stc.athSkillGroup, stc.additionSkillGroup, stc.rawAttr)
  dynHeroData:SetDynHeroTalentLevel(stc.talent)
  dynHeroData:SetExtraFixedPower(stc.talentEfficiency)
  local newModelPath = PathConsts:GetCharacterModelPathEx(dynHeroData:GetResModelName())
  local changeModel = oldModelPath ~= newModelPath
  return changeModel
end

function DynPlayer:GetDeployAliveHeroCount()
  local count = 0
  for k, dynHero in pairs(self.heroList) do
    if not dynHero:IsBench() and not dynHero:IsDead() then
      count = count + 1
    end
  end
  return count
end

function DynPlayer:UpdatePlayerSkillInBattke(commandTrees, CSTId)
  self.CSTId = CSTId
  self.cstDic = commandTrees
  if table.count(self.__CSTSkillDataDic) then
    for data, _ in pairs(self.__CSTSkillDataDic) do
      table.removebyvalue(self.playerOriginSkillList, data)
    end
    self.__CSTSkillDataDic = {}
  end
  local curTreeMsg = commandTrees[CSTId]
  if curTreeMsg ~= nil then
    for _, csteMsg in ipairs(curTreeMsg.skills) do
      local level = csteMsg.lv
      if level == nil or level == 0 then
        level = 1
      end
      local data = DynBattleSkill.New(csteMsg.skillId, level, eBattleSkillLogicType.Original)
      table.insert(self.playerOriginSkillList, data)
      self.__CSTSkillDataDic[data] = true
    end
  end
end

function DynPlayer:InitPlayerSkill(playerSkillInfo)
  local skillGroup = playerSkillInfo.skillGroup
  local commandTrees = playerSkillInfo.commandTrees
  local CSTId = playerSkillInfo.tree
  local extraSkill = playerSkillInfo.extraSkill
  self.playerOriginSkillList = {}
  self.playerExtraSkillDic = {}
  self.__CSTSkillDataDic = {}
  if BattleUtil.TryGetFixedCstSkills() and skillGroup ~= nil then
    for skillId, level in pairs(skillGroup) do
      local data = DynBattleSkill.New(skillId, level, eBattleSkillLogicType.Original)
      table.insert(self.playerOriginSkillList, data)
    end
  else
    self.CSTId = CSTId
    self.cstDic = commandTrees
    local curTreeMsg = commandTrees[CSTId]
    if curTreeMsg ~= nil then
      for _, csteMsg in ipairs(curTreeMsg.skills) do
        local level = csteMsg.lv
        if level == nil or level == 0 then
          level = 1
        end
        local data = DynBattleSkill.New(csteMsg.skillId, level, eBattleSkillLogicType.Original)
        table.insert(self.playerOriginSkillList, data)
        self.__CSTSkillDataDic[data] = true
      end
    end
  end
  if extraSkill ~= nil then
    for skillId, level in pairs(extraSkill) do
      local data = DynBattleSkill.New(skillId, level, eBattleSkillLogicType.Original)
      table.insert(self.playerOriginSkillList, data)
      self.playerExtraSkillDic[skillId] = level
    end
  end
end

function DynPlayer:GetCSTId()
  return self.CSTId
end

function DynPlayer:GetCSTDic()
  return self.cstDic
end

function DynPlayer:RefreshCacheFightPower()
  if not self.__isHeroInitReady then
    return
  end
  local curPower = self:GetTotalFightingPower()
  if self.__cacheFightPower == curPower then
    return
  end
  self.__cacheFightPower = curPower
  MsgCenter:Broadcast(eMsgEventId.OnEpPlayerFightPowerChang, curPower)
end

function DynPlayer:GetCacheFightPower()
  return self.__cacheFightPower or 0
end

function DynPlayer:UpdateHeroAttr(heroBattleData)
  for k, dynHero in ipairs(self.heroList) do
    local battle = heroBattleData[dynHero.dataId]
    if battle ~= nil then
      dynHero:UpdateBaseHeroData(battle.attr, battle.skillGroup, battle.athSkillGroup, battle.additionSkillGroup, battle.rawAttr)
      dynHero:SetDynHeroTalentLevel(battle.talent)
      dynHero:SetExtraFixedPower(battle.talentEfficiency)
      local mirrorDynHero = self.mirrorHeroList[k]
      mirrorDynHero:UpdateBaseHeroData(battle.attr, battle.skillGroup, battle.athSkillGroup, battle.additionSkillGroup, battle.rawAttr)
      mirrorDynHero:SetDynHeroTalentLevel(battle.talent)
      mirrorDynHero:SetExtraFixedPower(battle.talentEfficiency)
    end
  end
  self.__isHeroInitReady = true
  self:RefreshCacheFightPower()
end

function DynPlayer:UpdateOperatorDetail(operatorDetail)
  self.operatorDetail = operatorDetail
  if ExplorationManager.epCtrl ~= nil then
    local epSpecialRoomData = ExplorationManager.epCtrl.mapData:GetEpSpecialRoomData()
    epSpecialRoomData:SetEpRoomType(operatorDetail.specialCat)
  end
end

function DynPlayer:GetOperatorDetail()
  return self.operatorDetail
end

function DynPlayer:GetOperatorDetailState()
  return self.operatorDetail.state
end

function DynPlayer:UpdateEpBackpack(epBackpack)
  if epBackpack == nil then
    return
  end
  epBackpack.item[ConstGlobalItem.EpMoney] = epBackpack.eplGold
  epBackpack.item[ConstGlobalItem.RareMoney] = epBackpack.rareMoney
  local oldRareMoney = self:GetItemCount(ConstGlobalItem.RareMoney)
  self.allItemDic = {}
  for k, v in pairs(self.allItemTypeDic) do
    self.allItemTypeDic[k] = {}
  end
  for k, num in pairs(epBackpack.item) do
    local itemData = ItemData.New(k, num)
    self.allItemDic[k] = itemData
    local typeDic = self.allItemTypeDic[itemData.type]
    if typeDic == nil then
      error("Can't find itemType:" .. tostring(itemData.type))
    else
      typeDic[k] = itemData
    end
  end
  local focusItemNum = self:GetItemCount(ConfigData.game_config.RandomBeforeBatteleRejudgeItem) or 0
  local focusLimit = epBackpack.focusLimit or 0
  if self.focusItemNum ~= focusItemNum or self.focusLimit ~= focusLimit then
    self.focusItemNum = focusItemNum
    self.focusLimit = focusLimit
    MsgCenter:Broadcast(eMsgEventId.EpFocusPointChange, self.focusItemNum, focusLimit)
  end
  local money = epBackpack.eplGold
  if self.money ~= money then
    self._lastMoneyAdd = money - self.money
    self.money = money
    MsgCenter:Broadcast(eMsgEventId.EpMoneyChange, self.money)
  end
  local curRareMoney = epBackpack.rareMoney
  if curRareMoney ~= nil and oldRareMoney ~= curRareMoney then
    MsgCenter:Broadcast(eMsgEventId.OnRareMoneyChanged, curRareMoney)
  end
  local algData = epBackpack.algData
  if algData ~= nil then
    self:__UpdateAllChip(algData.alg, nil, algData.tmp, nil, algData.tmpBuff, nil)
  end
  if epBackpack.algUpperLimit ~= self.chipLimitInfo.limit then
    self.chipLimitInfo.limit = epBackpack.algUpperLimit
    MsgCenter:Broadcast(eMsgEventId.OnChipLimitChange)
  end
end

function DynPlayer:UpdateChipDiff(diffData)
  local update = diffData.update
  local delete = diffData.delete
  local tmpUpdate = diffData.tmpUpdate
  local tmpDelete = diffData.tmpDelete
  local tmpBuffUpdate = diffData.tmpBuffUpdate
  local tmpBuffDelete = diffData.tmpBuffDelete
  self:__UpdateAllChip(update, delete, tmpUpdate, tmpDelete, tmpBuffUpdate, tmpBuffDelete)
end

function DynPlayer:InitDynPlayerChip(chipUpdate)
  self:__UpdateAllChip(chipUpdate)
end

function DynPlayer:__UpdateAllChip(chipUpdate, chipDelete, tmpChipUpdate, tmpChipDelete, tmpBuffUpdate, tmpBuffDelete)
  if ExplorationManager.epCtrl ~= nil then
    ExplorationManager.epCtrl:RollbackNormalChipBattleRoom()
  end
  local haveTmpChipUpdate = false
  if tmpChipUpdate ~= nil and table.count(tmpChipUpdate) > 0 or tmpChipDelete ~= nil and table.count(tmpChipDelete) > 0 then
    haveTmpChipUpdate = true
    if ExplorationManager.epCtrl ~= nil then
      ExplorationManager.epCtrl:RollbackTempChipCurBattleRoom(self.epBuffChipDic)
    end
  end
  local chipShowDel = {}
  local chipShowAdd = {}
  if chipDelete ~= nil then
    for chipId, v in pairs(chipDelete) do
      local chipData = self.chipDic[chipId]
      if chipData ~= nil then
        self:__RollBackChipInternal(chipData)
      end
      self.chipDic[chipId] = nil
      chipShowDel[chipId] = true
    end
  end
  if tmpChipDelete ~= nil then
    for chipId, num in pairs(tmpChipDelete) do
      local buffChip = self.epBuffChipDic[chipId]
      if buffChip ~= nil then
        self:__RollBackBuffChip(buffChip)
      end
      self.epBuffChipDic[chipId] = nil
    end
  end
  if tmpBuffDelete ~= nil then
    for chipId, num in pairs(tmpBuffDelete) do
      local chipData = self.tmpBuffChipDic[chipId]
      if chipData ~= nil then
        self:__RollBackChipInternal(chipData)
      end
      self.tmpBuffChipDic[chipId] = nil
      chipShowDel[chipId] = true
    end
  end
  if chipUpdate ~= nil then
    for chipId, num in pairs(chipUpdate) do
      local chipData = self.chipDic[chipId]
      if chipData ~= nil then
        self:__RollBackChipInternal(chipData)
        chipData:SetCount(num)
        self:__ExecuteChipInternal(chipData)
      else
        local chipData = ChipData.New(chipId, num)
        self.chipDic[chipId] = chipData
        self:__ExecuteChipInternal(chipData)
        chipShowAdd[chipId] = true
      end
    end
  end
  if tmpChipUpdate ~= nil then
    for chipId, num in pairs(tmpChipUpdate) do
      local buffChip = self.epBuffChipDic[chipId]
      if buffChip ~= nil then
        self:__RollBackBuffChip(buffChip)
        buffChip:SetCount(num)
        self:__ExecuteBuffChip(buffChip)
      else
        local buffChip = DynEpBuffChip.New(chipId, num)
        self.epBuffChipDic[chipId] = buffChip
        self:__ExecuteBuffChip(buffChip)
      end
    end
  end
  if tmpBuffUpdate ~= nil then
    for chipId, num in pairs(tmpBuffUpdate) do
      local chipData = self.tmpBuffChipDic[chipId]
      if chipData ~= nil then
        self:__RollBackChipInternal(chipData)
        chipData:SetCount(num)
        self:__ExecuteChipInternal(chipData)
      else
        local chipData = ChipData.New(chipId, num)
        chipData:SetIsShowTemp(true)
        self.tmpBuffChipDic[chipId] = chipData
        self:__ExecuteChipInternal(chipData)
        chipShowAdd[chipId] = true
      end
    end
  end
  local chipList = {}
  for chipId, chipData in pairs(self.chipDic) do
    table.insert(chipList, chipData)
  end
  for k, chipData in pairs(self.tmpBuffChipDic) do
    table.insert(chipList, chipData)
  end
  self.chipList = chipList
  self:__SortChipList()
  self:UpdateChipLimitNum()
  if ExplorationManager.epCtrl ~= nil then
    ExplorationManager.epCtrl:ExecuteNormalChipBattleRoom()
  end
  if haveTmpChipUpdate and ExplorationManager.epCtrl ~= nil then
    ExplorationManager.epCtrl:ExecuteTempChipCurBattleRoom(self:GetEpBuffChipDic())
  end
  self:__UpdateChipSuitDiff(chipShowDel, chipShowAdd)
  MsgCenter:Broadcast(eMsgEventId.OnEpChipListChange, self.chipList)
  CS_BattleManager:UpdateBattleRoleData()
  self:RefreshCacheFightPower()
  self:_TryModifyBuffInfoByChip()
end

function DynPlayer:__UpdateChipSuitDiff(chipShowDel, chipShowAdd)
  self.__chipSuitMgr:UpdateChipSuitDiff(chipShowDel, chipShowAdd)
end

function DynPlayer:__SortChipList()
  table.sort(self.chipList, function(a, b)
    return a.dataId < b.dataId
  end)
end

function DynPlayer:SetChipDiscardId(id)
  self.chipLimitInfo.discardId = id
end

function DynPlayer:GetChipDiscardId()
  return self.chipLimitInfo.discardId
end

function DynPlayer:GetChipUpgradeLimitPrice()
  local discardId = self:GetChipDiscardId()
  local discardCfg = ConfigData.exploration_discard[discardId]
  if discardCfg == nil then
    error("can't read discardCfg with discardId=" .. tostring(discardId))
    return ConstGlobalItem.EpMoney, 0
  end
  local costItemId = discardCfg.upgrade_scaleId or ConstGlobalItem.EpMoney
  local costItemNum = 0
  local levelCfg = discardCfg.upgrade_level
  local scaleValuesCfg = discardCfg.upgrade_scaleValues
  local levelCount = #levelCfg
  local chipDiscardLimit = self:GetChipDiscardLimit()
  for i = 1, levelCount do
    if i <= 1 then
      if chipDiscardLimit <= levelCfg[1] then
        costItemNum = scaleValuesCfg[1]
      end
    elseif i >= levelCount then
      if chipDiscardLimit >= levelCfg[i - 1] then
        costItemNum = scaleValuesCfg[i]
      end
    elseif chipDiscardLimit >= levelCfg[i - 1] and chipDiscardLimit < levelCfg[i] then
      costItemNum = scaleValuesCfg[i]
    end
  end
  costItemNum = costItemNum - PlayerDataCenter.playerBonus:GetChipCeilingCostReduce()
  local scaleNum = self:GetSpecificBuffLogicPerPara(ExplorationEnum.eBuffLogicId.buyChipLimitNum)
  costItemNum = math.floor(costItemNum * ((100 + scaleNum) / 100))
  return costItemId, costItemNum
end

function DynPlayer:GetChipDiscardLimit()
  return self.chipLimitInfo.limit
end

function DynPlayer:UpdateChipLimitNum()
  local count = 0
  if self.tmpBuffChipDic ~= nil then
    count = table.count(self.tmpBuffChipDic)
  end
  for _, chipData in pairs(self.chipDic) do
    if not chipData:IsConsumeSkillChip() then
      count = count + 1
    end
  end
  self.chipLimitInfo.count = count
end

function DynPlayer:IsChipOverLimitNum()
  return self.chipLimitInfo.count > self.chipLimitInfo.limit, self.chipLimitInfo.count, self.chipLimitInfo.limit
end

function DynPlayer:IsChipFull()
  return self.chipLimitInfo.count >= self.chipLimitInfo.limit
end

function DynPlayer:GetItemBag(type)
  return self.allItemTypeDic[type]
end

function DynPlayer:GetItemCount(dataId)
  local itemData = self:GetItemById(dataId)
  return itemData == nil and 0 or itemData:GetCount()
end

function DynPlayer:GetItemCountByType(type, dataId)
  local itemData = self:GetItemById(type, dataId)
  return itemData == nil and 0 or itemData:GetCount()
end

function DynPlayer:SetWeekExtrReward(weekExtrReward)
  self.weekExtrReward = weekExtrReward or {}
end

function DynPlayer:GetWeekExtrReward()
  return self.weekExtrReward
end

function DynPlayer:GetEpRewardItemDic()
  local rewardsDic = {}
  for k, itemData in pairs(self.allItemDic) do
    if itemData:IsExplorationHold() then
      rewardsDic[k] = itemData:GetCount()
    end
  end
  if ExplorationManager:GetIsInWeeklyChallenge() and self.weekExtrReward ~= nil then
    for id, num in pairs(self.weekExtrReward) do
      if 0 < num then
        if rewardsDic[id] == nil then
          rewardsDic[id] = num
        else
          rewardsDic[id] = rewardsDic[id] + num
        end
      end
    end
  end
  return rewardsDic
end

function DynPlayer:GetItemById(dataId)
  local itemCfg = ConfigData.item[dataId]
  if itemCfg == nil then
    error("item cfg is null,Id:" .. tostring(dataId))
    return
  end
  return self.allItemDic[dataId]
end

function DynPlayer:GetMoneyIconId()
  local cfg = ConfigData.item[ConstGlobalItem.EpMoney]
  return cfg ~= nil and cfg.icon or nil
end

function DynPlayer:GetMoneyCount()
  return self.money
end

function DynPlayer:AddCacheMoneyCount(goldCount)
  if self.cacheMoney == nil then
    self.cacheMoney = 0
  end
  self.cacheMoney = self.cacheMoney + goldCount
end

function DynPlayer:SetCacheMoneyCount(goldCount)
  self.cacheMoney = goldCount
end

function DynPlayer:GetCacheMoneyCount()
  return self.cacheMoney or 0
end

function DynPlayer:RestNotPickupMoneyCount()
  self.notPickUpMoney = self.__cacheRemainGold or 0
end

function DynPlayer:SetNotPickupMoneyCount(goldCount)
  self.notPickUpMoney = goldCount
end

function DynPlayer:GetNotPickupMoneyCount()
  return self.notPickUpMoney or 0
end

function DynPlayer:GetEpMoneyLastAddNum()
  return self._lastMoneyAdd or 0
end

function DynPlayer:GetChipList()
  return self.chipList
end

function DynPlayer:GetChipLimitInfo()
  return self.chipLimitInfo
end

function DynPlayer:GetNormalChipDic()
  return self.chipDic
end

function DynPlayer:GetEpBuffChipDic()
  return self.epBuffChipDic
end

function DynPlayer:GetTmpBuffChipDic()
  return self.tmpBuffChipDic
end

function DynPlayer:GetChipSuitSortList()
  return self.__chipSuitMgr:GetChipSuitListData()
end

function DynPlayer:GetChipTagIdCount(tagId)
  return self.__chipSuitMgr:GetChipTagIdCount(tagId)
end

function DynPlayer:GetChipSuitTotalQty(tagId)
  return self.__chipSuitMgr:GetChipSuitTotalQty(tagId)
end

function DynPlayer:__RollBackChipInternal(chipData)
  if self:ContainChip(chipData) then
    chipData:RollbackChipData(self)
    return
  end
  for k, v in pairs(self.heroList) do
    chipData:RollbackChipData(v)
  end
end

function DynPlayer:__ExecuteChipInternal(chipData)
  local isForDynPlayer = chipData:IsValidDynPlayer()
  if isForDynPlayer then
    chipData:ExecuteChipData(self)
    return
  end
  local validRoleList
  validRoleList = chipData:GetValidRoleList(self.heroList, eBattleRoleBelong.player, self.__specEffectMgr)
  for k, v in pairs(validRoleList) do
    chipData:ExecuteChipData(v)
  end
end

function DynPlayer:ExecuteChip(chipData, isOwnData)
  local oldChip = self.chipDic[chipData.dataId]
  if oldChip ~= nil then
    self:__RollBackChipInternal(oldChip)
    local count = isOwnData and 1 or chipData:GetCount()
    oldChip:AddCount(count)
    self:__ExecuteChipInternal(oldChip)
  else
    self:__ExecuteChipInternal(chipData)
    self.chipDic[chipData.dataId] = chipData
    table.insert(self.chipList, chipData)
    table.sort(self.chipList, function(a, b)
      return a.dataId < b.dataId
    end)
  end
end

function DynPlayer:RollBackChip(chipData, isOwnData)
  local oldChip = self.chipDic[chipData.dataId]
  if oldChip ~= nil then
    local chipCount = isOwnData and 1 or chipData:GetCount()
    local count = oldChip:GetCount() - chipCount
    if count < 0 then
      error("Chip:卸载的数量大于已有的数量")
      return
    end
    self:__RollBackChipInternal(oldChip)
    if 0 < count then
      oldChip:SetCount(count)
      self:__ExecuteChipInternal(oldChip)
    else
      self.chipDic[chipData.dataId] = nil
      table.removebyvalue(self.chipList, oldChip)
    end
  else
    error("没有该芯片可以卸载,id = " .. tostring(chipData.dataId))
  end
end

function DynPlayer:__RollBackBuffChip(buffChip)
  buffChip:RollbackBuffChip(self)
  for k, v in pairs(self.heroList) do
    buffChip:RollbackBuffChip(v)
  end
end

function DynPlayer:__ExecuteBuffChip(buffChip)
  if buffChip:IsValidDynPlayer() then
    buffChip:ExecuteBuffChip(self)
    return
  end
  local validRoleList = buffChip:GetValidRoleList(self.heroList, eBattleRoleBelong.player)
  for k, v in pairs(validRoleList) do
    buffChip:ExecuteBuffChip(v)
  end
end

function DynPlayer:GetChipCount(chipId)
  local chipData = self.chipDic[chipId]
  if chipData ~= nil then
    return chipData:GetCount()
  else
    return 0
  end
end

local FightingPowerNumber = 100

function DynPlayer:GetChipCombatEffect(chipData, isOwnData, noContainBench)
  local containBench = not noContainBench
  local originPower = self:GetMirrorTeamFightPower(true, containBench)
  local oldPower = self:GetTotalFightingPower(true, containBench)
  local noOldChip = self.chipDic[chipData.dataId] == nil
  self:ExecuteChip(chipData, isOwnData)
  if noOldChip then
    self.__chipSuitMgr:TempAddChipSuit(chipData)
  end
  local powerChange = self:GetTotalFightingPower(true, containBench) - oldPower
  self:RollBackChip(chipData, isOwnData)
  if noOldChip then
    self.__chipSuitMgr:TempSubChipSuit(chipData, true)
  end
  local combatEffect = 0
  if 0 < originPower then
    combatEffect = powerChange / originPower * FightingPowerNumber
  end
  return combatEffect
end

function DynPlayer:GetChipDiscardFightPower(chipData, noContainBench)
  local containBench = not noContainBench
  chipData = self.chipDic[chipData.dataId]
  local originPower = self:GetMirrorTeamFightPower(true, containBench)
  local oldPower = self:GetTotalFightingPower(true, containBench)
  self:__RollBackChipInternal(chipData)
  self.__chipSuitMgr:TempSubChipSuit(chipData, false)
  local powerChange = oldPower - self:GetTotalFightingPower(true, containBench)
  self:__ExecuteChipInternal(chipData)
  self.__chipSuitMgr:TempAddChipSuit(chipData)
  local combatEffect = 0
  if 0 < originPower then
    combatEffect = powerChange / originPower * FightingPowerNumber
  end
  return combatEffect
end

function DynPlayer:GetMirrorTeamFightPower(fullHpPower, includeOnBench)
  fullHpPower = fullHpPower or false
  local fightingPower = 0
  for k, mirrDynHero in ipairs(self.mirrorHeroList) do
    local dynHero = self.heroList[k]
    if (not dynHero:IsDead() or fullHpPower) and (not dynHero.onBench or includeOnBench) then
      fightingPower = fightingPower + mirrDynHero:GetFightingPower(fullHpPower)
    end
  end
  local dynPlayerFightingPower = self.mirrorDynPlayer:GetPlayerFightingPower(fightingPower)
  fightingPower = fightingPower + dynPlayerFightingPower
  return fightingPower
end

function DynPlayer:GetTotalFightingPower(fullHpPower, includeOnBench)
  fullHpPower = fullHpPower or false
  local heroNum = 0
  local fightingPower = 0
  for k, dynHero in pairs(self.heroList) do
    if (not dynHero:IsDead() or fullHpPower) and (not dynHero.onBench or includeOnBench) then
      fightingPower = fightingPower + dynHero:GetFightingPower(fullHpPower)
      heroNum = heroNum + 1
    end
  end
  local dynPlayerFightingPower = self:GetPlayerFightingPower(fightingPower)
  local dynFiaryPow = 0
  if self.__dynFairyData ~= nil then
    dynFiaryPow = FairyHelper.GetFairyBattlePow(self.__dynFairyData) * heroNum
  end
  fightingPower = fightingPower + dynPlayerFightingPower + dynFiaryPow
  return fightingPower
end

function DynPlayer:UpdatePlayerDyncForRestartSkill(mp, hmp, buffs)
  self.cacheUltSkillMp = hmp
  self.cacheSkillMp = mp
  self.cacheHeroBuffs = buffs
end

function DynPlayer:GetRestartSkillPlayerDync()
  local ultSkillMp = self.cacheUltSkillMp or self.playerUltSkillMp
  local skillMp = self.cacheSkillMp or self.playerSkillMp
  local buffs = self.cacheHeroBuffs
  self.cacheUltSkillMp = nil
  self.cacheSkillMp = nil
  self.cacheHeroBuffs = nil
  return ultSkillMp, skillMp, buffs
end

function DynPlayer:UpdateFormationDetail(epRoleDyc)
  local size_row, size_col, deploy_rows = ExplorationManager:GetEpSceneBattleFieldSize()
  if epRoleDyc.player ~= nil then
    if self.playerUltSkillMp ~= epRoleDyc.player.hmp then
      self.playerUltSkillMp = epRoleDyc.player.hmp
      local playerCtrl = CS_BattleManager:GetBattlePlayerController()
      if playerCtrl ~= nil then
        playerCtrl.UltSkillHandle:UpdateUltMpFromItem(self.playerUltSkillMp)
      end
    end
    if self.playerSkillMp ~= epRoleDyc.player.mp then
      self.playerSkillMp = epRoleDyc.player.mp
    end
    CS_BattleManager:UpdatePlayerData()
  end
  if epRoleDyc.role ~= nil then
    local benchX = ConfigData.buildinConfig.BenchX
    if epRoleDyc.role.initial then
      local maxStageNum = self:GetEnterFiledNum()
      local curOnStage = 0
      for _, heroData in pairs(self.heroList) do
        local roleMsg = epRoleDyc.role.role[heroData.uid]
        if roleMsg ~= nil then
          heroData:SetCoord(roleMsg.dync.coordination, benchX)
        end
        if not heroData:IsBench() then
          curOnStage = curOnStage + 1
        end
      end
      if maxStageNum < curOnStage then
        for i = #self.heroList, 1, -1 do
          local heroData = self.heroList[i]
          if not heroData:IsBench() then
            heroData.onBench = true
            curOnStage = curOnStage - 1
            if curOnStage == maxStageNum then
              break
            end
          end
        end
      end
      DeployTeamUtil.DeployHeroTeam(self.heroList, size_row, size_col, deploy_rows)
    end
    local emptyBenchPos = {}
    for i = 0, ConfigData.game_config.battleMap_bench_count - 1 do
      table.insert(emptyBenchPos, i)
    end
    local newSet2BenchDynRole = {}
    for k, v in pairs(epRoleDyc.role.role) do
      local dynHero = self:GetDynHeroByUid(k)
      if dynHero == nil then
        error("Can't find dynHero, id = " .. tostring(k))
      else
        dynHero:UpdateHpPer(v.dync.hpPer)
        if dynHero.onBench then
          table.removebyvalue(emptyBenchPos, dynHero.y)
        elseif benchX <= BattleUtil.Pos2XYCoord(v.dync.coordination) then
          table.insert(newSet2BenchDynRole, dynHero)
        end
        if not epRoleDyc.role.initial then
          if dynHero.onBench and dynHero.coord ~= nil then
            dynHero:SetCoord(dynHero.coord, benchX)
          else
            dynHero:SetCoord(v.dync.coordination, benchX)
          end
        end
      end
    end
    if #newSet2BenchDynRole > #emptyBenchPos then
      error("have to move " .. tostring(#newSet2BenchDynRole) .. " hero to bench, but bench only have " .. tostring(#emptyBenchPos) .. " empyt slots")
    end
    local isHaveRoleMove = false
    for index, dynHero in ipairs(newSet2BenchDynRole) do
      if emptyBenchPos[index] ~= nil then
        dynHero:SetCoordXY(benchX, emptyBenchPos[index], benchX)
        isHaveRoleMove = true
      end
    end
    CS_BattleManager:UpdateBattleRoleData()
    MsgCenter:Broadcast(eMsgEventId.OnEpPlayerHeroDataChange)
    if isHaveRoleMove then
      MsgCenter:Broadcast(eMsgEventId.OnDeployCoordChanged, nil)
    end
    self:RefreshCacheFightPower()
  end
end

function DynPlayer:UpdateFormationStc(epStc)
  for k, v in pairs(epStc.record) do
    local dynHero = self:GetDynHeroByUid(k)
    if dynHero == nil then
      error("Can't find dynHero, id = " .. tostring(k))
    else
      dynHero:UpdateTotalDamage(v.record[2])
    end
  end
end

function DynPlayer:UpdateRolePos(formData, stageCfg)
  if formData == nil then
    return
  end
  for k, v in pairs(formData) do
    local dynHero = self:GetDynHeroByUid(k)
    if dynHero == nil then
      error("Can't find dynHero, id = " .. tostring(k))
    else
      dynHero:SetCoord(v.dync.coordination, ConfigData.buildinConfig.BenchX)
    end
  end
end

function DynPlayer:ExistDynHeroByDataId(id)
  return self.heroDic[id] ~= nil
end

function DynPlayer:GetDynHeroByDataId(id)
  return self.heroDic[id]
end

function DynPlayer:GetDynHeroByUid(id)
  for k, v in pairs(self.heroDic) do
    if v.uid == id then
      return v
    end
  end
  return nil
end

function DynPlayer:GetChipReturnMoney(chipId, count)
  local haveChipData = self.chipDic[chipId]
  if haveChipData ~= nil and not haveChipData:IsConsumeSkillChip() then
    local maxLevel = haveChipData:GetChipMaxLevel()
    local overflowCount = haveChipData:GetCount() + count - maxLevel
    overflowCount = math.min(overflowCount, maxLevel)
    if 0 < overflowCount then
      local epTypeCfg
      if ExplorationManager:IsInExploration() then
        epTypeCfg = ExplorationManager:GetEpTypeCfg()
      end
      if epTypeCfg == nil then
        return 0
      end
      local moneyReturn = epTypeCfg.chip_return_price[overflowCount]
      return moneyReturn
    end
  end
  return 0
end

function DynPlayer:IsNormalChipFullLevel(chipId)
  local haveChipData = self.chipDic[chipId]
  if haveChipData ~= nil and haveChipData:IsChipFullLevel() then
    return true
  end
  return false
end

function DynPlayer:IsChipNewAndUpgradeState(chipId)
  local haveChip = self.chipDic[chipId]
  if haveChip == nil then
    return true, false
  end
  return false, not haveChip:IsChipFullLevel()
end

function DynPlayer:GetPlayerFightingPower(rolesFighter)
  if self._rolesPowerTab == nil then
    self._rolesPowerTab = {}
  end
  self._rolesPowerTab.power = rolesFighter or 0
  local rolePower = ConfigData.GetFormulaValue(eFormulaType.Commander, self._rolesPowerTab)
  local skillFight = self:GetSkillFightingPower(rolePower)
  local fightingPower = rolePower + skillFight
  fightingPower = math.floor(fightingPower)
  self.fightingPower = fightingPower
  return fightingPower
end

function DynPlayer:GetSkillFightingPower(heroPower)
  local skillList = {}
  local skillDic = {}
  if self.playerOriginSkillList ~= nil then
    for k, v in pairs(self.playerOriginSkillList) do
      table.insert(skillList, v)
      skillDic[v.dataId] = v
    end
  end
  if self.__itemSkillDic ~= nil then
    for k, v in pairs(self.__itemSkillDic) do
      local oldSkill = skillDic[k.dataId]
      if oldSkill == nil or k.level > oldSkill.level then
        if oldSkill then
          table.removebyvalue(skillList, oldSkill)
        end
        table.insert(skillList, k)
        skillDic[k.dataId] = k
      end
    end
  end
  local fightingPower = 0
  for k, battleSkill in pairs(skillList) do
    local battleCfg = ConfigData.battle_skill[battleSkill.dataId]
    if battleCfg ~= nil and battleCfg.skill_comat ~= "" then
      local isChipType = battleSkill.type == eBattleSkillLogicType.Chip or battleSkill.type == eBattleSkillLogicType.TempChip
      fightingPower = fightingPower + PlayerDataCenter:GetBattleSkillFightPower(battleSkill.dataId, battleSkill.level, heroPower, isChipType)
    end
  end
  return fightingPower
end

function DynPlayer:GetHeroList()
  return self.heroList
end

function DynPlayer:InitCampFetter()
  self.campFetterDic = {}
  self.activeCampFetterId = nil
  local campCount = {}
  for k, dynHero in pairs(self.heroList) do
    local campId = dynHero:GetCamp()
    campCount[campId] = (campCount[campId] or 0) + 1
  end
  for campId, campCount in pairs(campCount) do
    local campConnCfg = ConfigData:GetCampFetter(campId, campCount)
    if campConnCfg ~= nil then
      local dynCampFetter = DynCampFetter.New(campId, campConnCfg, campCount)
      if dynCampFetter:GetIsHaveActiveFetterSkill() then
        if self.activeCampFetterId ~= nil then
          error("Has mult active campFeetter")
        else
          self.activeCampFetterId = campId
        end
      end
      self.campFetterDic[campId] = dynCampFetter
    end
  end
end

function DynPlayer:UpdateEpBuff(epBuff)
  if epBuff == nil then
    return
  end
  self.epBuffList = {}
  for groupId, buffGroup in pairs(epBuff.data) do
    for _, buff in pairs(buffGroup.data) do
      local epBuff = DynBuff.CreateByEpBuffId(buff.id)
      epBuff:InitDynEpBuffInfo(buff)
      table.insert(self.epBuffList, epBuff)
    end
  end
  for uid, value in pairs(epBuff.campFetter) do
    local campId = uid >> 32
    local heroNum = uid & CommonUtil.UInt32Max
    local dynCampFetter = self.campFetterDic[campId]
    if dynCampFetter:GetActiveFetterUID() ~= uid then
      dynCampFetter:SetActiveValue(value, uid)
    else
      dynCampFetter:SetActiveValue(value)
    end
  end
  self.initBuffIdDic = {}
  for k, buffId in ipairs(epBuff.initBuffId) do
    self.initBuffIdDic[buffId] = true
  end
  MsgCenter:Broadcast(eMsgEventId.OnEpBuffListChange, self.epBuffList)
  self:_TryModifyBuffInfoByChip()
end

function DynPlayer:_TryModifyBuffInfoByChip()
  if #self.epBuffList == 0 then
    return
  end
  local buffDic = {}
  for _, epBuff in pairs(self.epBuffList) do
    local buffId = epBuff:GetBuffDataId()
    buffDic[buffId] = epBuff
  end
  local isModified = false
  for chipId, buffChip in pairs(self.epBuffChipDic) do
    if buffChip.chipCfg.buff_id ~= 0 then
      local epBuff = buffDic[buffChip.chipCfg.buff_id]
      if epBuff ~= nil then
        epBuff.cnt = buffChip:GetCount()
        epBuff.customDes = ConfigData:GetChipDescriptionById(chipId, buffChip:GetCount(), true)
        isModified = true
      end
    end
  end
  if isModified then
    MsgCenter:Broadcast(eMsgEventId.OnEpBuffListChange, self.epBuffList)
  end
end

function DynPlayer:GetEpBuffListFromEp()
  local buffList = {}
  for k, epBuff in ipairs(self.epBuffList) do
    if not self.initBuffIdDic[epBuff.dataId] then
      table.insert(buffList, epBuff)
    end
  end
  return buffList
end

function DynPlayer:GetEpBuffList()
  return self.epBuffList
end

function DynPlayer:GetEpBuffCount(buffId)
  local num = 0
  for index, epBuff in ipairs(self.epBuffList) do
    if buffId == epBuff.dataId then
      num = num + 1
    end
  end
  return num
end

function DynPlayer:IsHaveSpecificTypeBuff(logicType)
  for _, DynBuff in ipairs(self.epBuffList) do
    local bool, logic_num, logic_per = DynBuff:GetSpecificLogicPara(logicType)
    if bool then
      return true, logic_num, logic_per
    end
  end
  return false
end

function DynPlayer:GetSpecificBuffLogicPerPara(logicType)
  local perNum = 0
  for _, DynBuff in ipairs(self.epBuffList) do
    local bool, logic_num, logic_per = DynBuff:GetSpecificLogicPara(logicType)
    if bool then
      perNum = logic_per[1]
    end
  end
  return perNum
end

function DynPlayer:UpdateAllDynServerGrid(epBattleGrid)
  self.allDynServerGrid:UpdateAllServerGrid(epBattleGrid, self)
end

function DynPlayer:UpdateEpCommonData(epCommonData)
  if epCommonData == nil then
    return
  end
  local haveUpdateMonster = false
  if self.epCommonData ~= nil then
    local monster = self.epCommonData.monster
    if monster ~= nil and (monster.lv ~= epCommonData.monster.lv or monster.exp ~= epCommonData.monster.exp) then
      haveUpdateMonster = true
      self.epMonsterLvUp = monster.lv < epCommonData.monster.lv
      self:SetHasDebuffSelect(self.epMonsterLvUp and epCommonData.buffChoices ~= nil)
      self.epMonsterOldLevel = monster.lv
      self._lastEpMonsterLvExpAdd = math.max(epCommonData.monster.exp - monster.exp, 0)
    end
  end
  local lastEpCommonData = self.epCommonData
  self.epCommonData = epCommonData
  if lastEpCommonData == nil or epCommonData.data[proto_object_EplCommon.EplCommonAlgPurchaseRate] ~= lastEpCommonData.data[proto_object_EplCommon.EplCommonAlgPurchaseRate] or epCommonData.data[proto_object_EplCommon.EplCommonResStoreRefresh] ~= lastEpCommonData.data[proto_object_EplCommon.EplCommonResStoreRefresh] then
    MsgCenter:Broadcast(eMsgEventId.EpMoneyChange, self.money)
  end
  self._questChoiceDic = self.epCommonData.questChoices
  if haveUpdateMonster then
    MsgCenter:Broadcast(eMsgEventId.UpdateEpMonsterLevel, self.epCommonData.monster)
  end
  self.__cacheRemainGold = self.epCommonData.remainGold
  self:SetNotPickupMoneyCount(self.epCommonData.remainGold or 0)
end

function DynPlayer:GetEnterFiledNum()
  local enterFieldNum = self:GetMaxRoleCountInStageLocally()
  enterFieldNum = self.epCommonData ~= nil and self.epCommonData.data[proto_object_EplCommon.EplCommonEnterFiledNum] or enterFieldNum
  return enterFieldNum
end

function DynPlayer:SetPlayerFormationRuleCfg(formationRuleCfg)
  if formationRuleCfg ~= nil then
    self.__formationRuleCfg = formationRuleCfg
  end
end

function DynPlayer:GetMaxRoleCountInStageLocally()
  if BattleUtil.IsInTDBattle() then
    return ConfigData.game_config.max_stage_hero_in_td
  else
    return self.__formationRuleCfg.stage_num
  end
end

function DynPlayer:GetFmtMaxHeroNum()
  local benchNum = 0
  for benchId = 1, self.__formationRuleCfg.bench_num do
    if FunctionUnlockMgr.BenchUnlock(benchId) then
      benchNum = benchNum + 1
    end
  end
  return self.__formationRuleCfg.stage_num + benchNum
end

function DynPlayer:HasEpMonsterLvUp(isCloseNextTip)
  if self.epMonsterLvUp then
    if isCloseNextTip then
      self.epMonsterLvUp = false
    end
    return true, self.epMonsterOldLevel, self.epCommonData.monster.lv
  end
end

function DynPlayer:GetEpMonsterLevelLastExpAdd()
  return self._lastEpMonsterLvExpAdd or 0
end

function DynPlayer:GetMonsterLevelData()
  if self.epCommonData ~= nil then
    return self.epCommonData.monster
  end
end

function DynPlayer:HasDebuffSelect()
  return self.__IsHaveRandomDebuff and self:GetOperatorDetailState() == proto_object_ExplorationCurGridState.ExplorationCurGridState_MonsterLvUpgrade
end

function DynPlayer:SetHasDebuffSelect(bool)
  self.__IsHaveRandomDebuff = bool
end

function DynPlayer:TryGetNewEpBuffSelect()
  if self:GetOperatorDetailState() ~= proto_object_ExplorationCurGridState.ExplorationCurGridState_OpeningBuffSelect then
    return false
  end
  if ExplorationManager:GetEpModuleId() ~= proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration then
    return false
  end
  local stageCfg = ExplorationManager:GetSectorStageCfg()
  local flag, buffIdList = ExplorationManager:GetEpNewEpBuffSelect(stageCfg.sector)
  if not flag then
    return false
  end
  local epBuffList = {}
  for _, buffId in pairs(buffIdList) do
    local epBuff = DynBuff.CreateByEpBuffId(buffId)
    table.insert(epBuffList, epBuff)
  end
  return flag, epBuffList, self.epCommonData.opengingWaitingSelectBuffs
end

function DynPlayer:GetEpDebuffSelectDic()
  if self.epCommonData ~= nil then
    return self.epCommonData.buffChoices
  end
end

function DynPlayer:RecordLastMoney()
  self.__lastMoney = self:GetMoneyCount()
end

function DynPlayer:GetLastMoney()
  return self.__lastMoney
end

function DynPlayer:GetPlayerSkillMp()
  return self.playerSkillMp
end

function DynPlayer:GetDynPlayerName()
  return ConfigData.GetTipCp
end

function DynPlayer:GetOriginMaxMp()
  if self.dynData ~= nil then
    return self.dynData:GetOriginAttr(eHeroAttr.moveSpeed)
  end
end

function DynPlayer:UpdateWcCurrentScore(epWCscore)
  self.WcCurrentScore = epWCscore
end

function DynPlayer:GetWcCurrentScore(epWCscore)
  return self.WcCurrentScore or 0
end

function DynPlayer:GetWcScoreScope()
  local CurEpLevel = ExplorationManager:GetCurLevelIndex() + 1
  local CurExp = ExplorationManager.epCtrl.residentStoreCtrl.storeExp
  local CurStoreLevel = ExplorationManager.epCtrl.residentStoreCtrl.storeLevel
  local MaxStorLevel = ExplorationManager.epCtrl.residentStoreCtrl:GetResidentStoreCfg().maxLevel
  local CurChipLimit = self.chipLimitInfo.limit
  local CurMonLevel = self.epCommonData.monster.lv
  local CurCoin = self:GetMoneyCount()
  local wcData = PlayerDataCenter.allWeeklyChallengeData:GetWeeklyChallengeDataByDungeonId(ExplorationManager:GetEpDungeonId())
  local fmtBuffSelect = wcData:GetFmtBuffSelectData()
  local effectAll = 0
  local isPickHugeIncrease = false
  local AllBuffSum = 0
  local epBuffList = self:GetEpBuffList()
  for index, dynBuff in ipairs(epBuffList) do
    if fmtBuffSelect:IsFmtEffectBuff(dynBuff.dataId) then
      effectAll = effectAll + (fmtBuffSelect:GetFmtBuffEffect(dynBuff.dataId) or 0)
      if fmtBuffSelect:IsFmtBuffAssis(dynBuff.dataId) then
        isPickHugeIncrease = true
      end
    end
  end
  if not isPickHugeIncrease then
    AllBuffSum = fmtBuffSelect:GetFmtBuffHighestSum()
    AllBuffSum = AllBuffSum / 1000
  end
  local CurBuffMult = effectAll / 1000
  local CurChipScore = 0
  local chipList = self:GetChipList()
  for index, chipData in ipairs(chipList) do
    if chipData:GetChipType() == ChipEnum.eChipType.Normal then
      local quality = chipData:GetQuality()
      if quality == eItemQualityType.Blue then
        CurChipScore = CurChipScore + 5
      elseif quality == eItemQualityType.Purple then
        CurChipScore = CurChipScore + 15
      elseif quality == eItemQualityType.Orange then
        CurChipScore = CurChipScore + 30
      end
    end
  end
  local CurScore = self:GetWcCurrentScore()
  local curRoomData = ExplorationManager.epCtrl:GetCurrentRoomData(true)
  local StepLefts = {
    10,
    10,
    10
  }
  for i = CurEpLevel, 3 do
    StepLefts[i] = StepLefts[i] - curRoomData.x
  end
  local BattleStepLefts = {
    8,
    8,
    8
  }
  for i = CurEpLevel, 3 do
    BattleStepLefts[i] = BattleStepLefts[i] - curRoomData.x
  end
  local max = WCScorePredict.GetWCPredictScore(true, StepLefts, BattleStepLefts, CurCoin, CurExp, CurChipScore, CurStoreLevel, MaxStorLevel, CurChipLimit, CurEpLevel, CurBuffMult, CurMonLevel, CurScore, AllBuffSum)
  local min = WCScorePredict.GetWCPredictScore(false, StepLefts, BattleStepLefts, CurCoin, CurExp, CurChipScore, CurStoreLevel, MaxStorLevel, CurChipLimit, CurEpLevel, CurBuffMult, CurMonLevel, CurScore, AllBuffSum)
  return min, max
end

function DynPlayer:InitDynSpecEffect(epEffect)
  self.__specEffectMgr:InitSpecEffect(epEffect)
end

function DynPlayer:UpdateDynSpecEffect(diff)
  for k, chipData in pairs(self.chipList) do
    local validRoleList = chipData:GetValidRoleList(self.heroList, eBattleRoleBelong.player, self.__specEffectMgr)
    for k, v in pairs(validRoleList) do
      chipData:RollbackChipData(v)
    end
  end
  self.__chipSuitMgr:RemoveAllChipSuitTemp()
  self.__specEffectMgr:UpdateSpecEffectDiff(diff)
  for k, chipData in pairs(self.chipList) do
    local validRoleList = chipData:GetValidRoleList(self.heroList, eBattleRoleBelong.player, self.__specEffectMgr)
    for k, v in pairs(validRoleList) do
      chipData:ExecuteChipData(v)
    end
  end
  self.__chipSuitMgr:UpdateAllChipSuit(self.chipList)
  CS_BattleManager:UpdateBattleRoleData()
  self:RefreshCacheFightPower()
end

function DynPlayer:GetSpecEffectMgr()
  return self.__specEffectMgr
end

function DynPlayer:GetOriginAttrMaxRatio(attrId)
  if attrId < 100 then
    return ConfigData.attribute[attrId].uplimit_multy
  end
end

function DynPlayer:GetAttrMaxNum(attrId)
  if attrId < 100 then
    if self:IsInBrotatoGame() and attrId == eHeroAttr.moveSpeed then
      return 0
    end
    return ConfigData.attribute[attrId].uplimit_num
  end
end

function DynPlayer:GetAttrMinRatio(attrId)
  if attrId < 100 then
    return ConfigData.attribute[attrId].downlimit_multy
  end
end

function DynPlayer:OffsetAttrFromChip(property, value)
  HeroAttrUtility.OffsetAttrFormDynPlayer(self.dynData, property, value)
end

function DynPlayer:GetOriginAttr(attrId)
  if self.dynData ~= nil then
    return self.dynData:GetOriginAttr(attrId)
  end
end

function DynPlayer:GetBaseAttr(attrId)
  if self.dynData ~= nil then
    return self.dynData:GetBaseAttr(attrId)
  end
end

function DynPlayer:GetRatioAttr(attrId)
  if self.dynData ~= nil then
    return self.dynData:GetRatioAttr(attrId)
  end
end

function DynPlayer:GetExtraAttr(attrId)
  if self.dynData ~= nil then
    return self.dynData:GetExtraAttr(attrId)
  end
end

function DynPlayer:UpdateEpEventData(epOp)
  if epOp.deco then
    if epOp.deco[1] then
      self:UpdateEpSaveMoneyList(epOp.deco[1].arrParams, epOp.curPostion, epOp.path)
    else
      self:UpdateEpSaveMoneyList()
    end
    if epOp.deco[2] then
      self:UpdateEpBattleSkillLockDic(epOp.deco[2].mapParams)
    else
      self:UpdateEpBattleSkillLockDic()
    end
  else
    self:UpdateEpSaveMoneyList()
    self:UpdateEpBattleSkillLockDic()
  end
end

function DynPlayer:UpdateEpSaveMoneyList(arrParams, curPostion, path)
  self.epSaveMoneyList = arrParams
end

function DynPlayer:GetEpSaveMoney()
  local saveMoney = 0
  if not self.epSaveMoneyList then
    return saveMoney
  end
  if #self.epSaveMoneyList % 3 ~= 0 then
    error("#self.epSaveMoneyList % 3 ~= 0")
    return saveMoney
  end
  for index = 1, #self.epSaveMoneyList, 3 do
    local param1 = self.epSaveMoneyList[index]
    local param2 = self.epSaveMoneyList[index + 1]
    local param3 = self.epSaveMoneyList[index + 2]
    saveMoney = saveMoney + param2 * (100 + param1 * param3)
  end
  saveMoney = saveMoney // 100
  return saveMoney
end

function DynPlayer:UpdateEpBattleSkillLockDic(mapParams)
  self.epBattleSkillLockDic = mapParams
end

function DynPlayer:IsEpBattleSkillLock(skillId)
  if self.epBattleSkillLockDic then
    return self.epBattleSkillLockDic[skillId]
  else
    return false
  end
end

function DynPlayer:GetQuestChioceDic()
  return self._questChoiceDic
end

function DynPlayer:GetQuestId()
  return self.operatorDetail.questID
end

function DynPlayer:IsInterestDepress()
  return self.epCommonData.data[proto_object_EplCommon.EplCommonInterestDepress]
end

function DynPlayer:GetChipItemCommonPriceArg()
  if self.epCommonData == nil then
    return 100
  end
  return self.epCommonData.data[proto_object_EplCommon.EplCommonAlgPurchaseRate] or 100
end

function DynPlayer:GetEpStoreRefreshCommonPriceArg()
  if self.epCommonData == nil then
    return 100
  end
  return self.epCommonData.data[proto_object_EplCommon.EplCommonResStoreRefresh] or 100
end

function DynPlayer:GetChipCountAndLevelSum()
  if self.chipList == nil or #self.chipList <= 0 then
    return 0, 0
  end
  local chipCount = 0
  local chipLevelSum = 0
  for _, v in ipairs(self.chipList) do
    if not v:IsConsumeSkillChip() then
      chipCount = chipCount + 1
      chipLevelSum = chipLevelSum + v:GetCount()
    end
  end
  return chipCount, chipLevelSum
end

function DynPlayer:GetEpUnlimitChooseRoom()
  if self.epCommonData == nil then
    return false
  end
  return self.epCommonData.data[proto_object_EplCommon.EplCommonUnlimitChooseRoom] == 1
end

function DynPlayer:GetEpFreshStoreFreeNumExtra()
  if self.epCommonData == nil then
    return 0
  end
  return self.epCommonData.data[proto_object_EplCommon.EplCommonModifyFreshStoreFree] or 0
end

function DynPlayer:IsEpQuickBattleRoomType(roomType)
  if self.epCommonData == nil then
    return false
  end
  return self.epCommonData.quickBattleRoom[roomType] ~= nil
end

function DynPlayer:GetRoleSkinId(roleDataId)
  if self.heroDic == nil or self.heroDic[roleDataId] == nil then
    return nil
  end
  local heroDta = self.heroDic[roleDataId].heroData
  if heroDta == nil then
    return nil
  end
  return heroDta.skinId
end

function DynPlayer:SetResultSettlementData()
  local treeId = self:GetCSTId()
  local allFriendshipData = PlayerDataCenter.allFriendshipData
  local oldHeroLevelDic = {}
  local oldHeroExpDic = {}
  for heroId, dynHeroData in pairs(self.heroDic) do
    oldHeroLevelDic[dynHeroData.dataId] = dynHeroData.heroData.level
    oldHeroExpDic[dynHeroData.dataId] = dynHeroData.heroData.curExp
  end
  local resultSettlementData = {oldHeroLevelDic = oldHeroLevelDic, oldHeroExpDic = oldHeroExpDic}
  return resultSettlementData
end

function DynPlayer:SetDropActiveAlg(activeAlg)
  self._newDropActiveAlg = activeAlg
end

function DynPlayer:GetDropActiveAlg()
  return self._newDropActiveAlg
end

function DynPlayer:ClearDropActiveAlg()
  self._newDropActiveAlg = nil
end

function DynPlayer:GetDropBuffs()
  return self._newDropBuffs
end

function DynPlayer:AddDropBuff(buffId)
  table.insert(self._newDropBuffs, buffId)
end

function DynPlayer:ClearDropBuffs()
  self._newDropBuffs = {}
end

function DynPlayer:SetFloorStartRandomBuff(buffId)
  self._floorStartRandomBuff = buffId
end

function DynPlayer:GetFloorStartRandomBuff()
  if self._floorStartRandomBuff == 0 then
    return nil
  end
  local epBuff = DynBuff.CreateByEpBuffId(self._floorStartRandomBuff)
  return epBuff
end

function DynPlayer:GetEplGoldNum()
  if ExplorationManager:IsInExploration() then
    return ExplorationManager:GetDynPlayer():GetMoneyCount()
  elseif BattleDungeonManager:InBattleDungeon() then
    return BattleDungeonManager:GetDungeonDynPlayer():GetMoneyCount()
  elseif WarChessManager:GetIsInWarChess() then
    return WarChessManager:GetWCCoinNum()
  end
end

function DynPlayer:IsInBrotatoGame()
  if self.isInBrotato == nil then
    self.isInBrotato = ExplorationManager:IsInBrotatoExp()
  end
  return self.isInBrotato
end

function DynPlayer:GetDynFairyData()
  return self.__dynFairyData
end

function DynPlayer:GetDeployHeroCount()
  local count = 0
  for k, dynHero in pairs(self.heroList) do
    if not dynHero:IsBench() then
      count = count + 1
    end
  end
  return count
end

function DynPlayer:UpdateChipValidRoleList()
  for k, chipData in pairs(self.chipList) do
    chipData:GetValidRoleList(self.heroList, eBattleRoleBelong.player, self.__specEffectMgr)
  end
  self.__chipSuitMgr:UpdateAllSuitChipVaildRoleList(self.heroList, self)
end

function DynPlayer:GetEpBuffWithOutInitBuff()
  local tempBuffList = {}
  for i, v in ipairs(self.epBuffList) do
    if self.initBuffIdDic[v.dataId] ~= true then
      table.insert(tempBuffList, v)
    end
  end
  return tempBuffList
end

return DynPlayer
