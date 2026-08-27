local UINDunLevelDetail = class("UINDunLevelDetail", UIBaseNode)
local base = UIBaseNode
local DungeonLevelEnum = require("Game.DungeonCenter.DungeonLevelEnum")
local UINLevelInfgoTypeTog = require("Game.Sector.SectorLevelDetail.UINLevelInfgoTypeTog")
local UINDunLevelNormalNode = require("Game.DungeonCenter.LevelUI.UINDunLevelNormalNode")
local UINDunLevelChipSuitNode = require("Game.DungeonCenter.LevelUI.UINDunLevelChipSuitNode")
local UINStOUnlockConditionItem = require("Game.StrategyOverview.UI.Side.UINStOUnlockConditionItem")
local DungeonChallengeData = require("Game.StageChallenge.Data.DungeonChallengeData")
local UINCommonSwitchToggle = require("Game.CommonUI.CommonSwitchToggle.UINCommonSwitchToggle")
local DungeonEnterUtil = require("Game.DungeonCenter.Util.DungeonEnterUtil")
local FmtEnum = require("Game.Formation.FmtEnum")
local DungeonInterfaceData = require("Game.BattleDungeon.IData.DungeonInterfaceData")
local JumpManager = require("Game.Jump.JumpManager")
local cs_MessageCommon = CS.MessageCommon

function UINDunLevelDetail:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Battle, self, self.OnClickDungeonBattle)
  UIUtil.AddButtonListener(self.ui.btn_GiveUP, self, self._OnClickGiveup)
  UIUtil.AddButtonListener(self.ui.btn_Recomme, self, self.OnClickDungeonRecomme)
  UIUtil.AddButtonListener(self.ui.btn_AutoBattle, self, self.OnClickDungeonAutoBattle)
  UIUtil.AddButtonListener(self.ui.btn_Unlock, self, self.OnClickUnlock)
  UIUtil.AddButtonListener(self.ui.btn_Challenge, self, self._OnClickChallenge)
  if not IsNull(self.ui.btn_QuickBattle) then
    UIUtil.AddButtonListener(self.ui.btn_QuickBattle, self, self._OnClickQuickBattle)
    self._colorQuickBattle = self.ui.img_QuickBattle.color
  end
  self._switchChallengeTog = UINCommonSwitchToggle.New()
  self._switchChallengeTog:Init(self.ui.tog_SwitchChallenge)
  self._switchChallengeTog:CommonSwitchTogAutoSetValue(false)
  self._changeChallengeFunc = BindCallback(self, self._OnClickChallengeModeTog)
  self.typeTogPool = UIItemPool.New(UINLevelInfgoTypeTog, self.ui.obj_tog_Type)
  self.ui.obj_tog_Type:SetActive(false)
  self.__nodeCfg = {
    [DungeonLevelEnum.eDunLevelInfoNodeType.LevelNormalInfo] = {
      nodeClass = UINDunLevelNormalNode,
      uiNode = self.ui.obj_normalNode
    },
    [DungeonLevelEnum.eDunLevelInfoNodeType.LevelChips] = {
      nodeClass = UINDunLevelChipSuitNode,
      uiNode = self.ui.obj_chipSuitNode
    }
  }
  self.__nodeDic = {}
  self.__togDic = {}
  self.selectedNode = nil
  self.lastDunLevelType = nil
  self.ui.conditionItem:SetActive(false)
  self.conditionItemPool = UIItemPool.New(UINStOUnlockConditionItem, self.ui.conditionItem)
  self.ui.moveTween.onComplete:AddListener(BindCallback(self, self.__OnMoveTweenComplete))
  self.ui.moveTween.onRewind:AddListener(BindCallback(self, self.__OnMoveTweenRewind))
  local position = Vector2.zero
  position.x = self.ui.moveTween.transform.sizeDelta.x + CS.UIManager.Instance.CurNotchValue / 100 * CS.UnityEngine.Screen.width
  self.ui.moveTween.transform.anchoredPosition = position
  self.__isShow = false
  self._colorNormalBattleImg = self.ui.image_battle.color
  self._colorNormalBattleTex = self.ui.tex_Battle.text.color
end

function UINDunLevelDetail:_ResetInit()
  self.ui.obj_ChallengeNode:SetActive(false)
  if not IsNull(self.ui.btn_QuickBattle) then
    self.ui.btn_QuickBattle.gameObject:SetActive(false)
  end
end

function UINDunLevelDetail:BindDetailCommonData(resloader)
  self.__resloader = resloader
end

function UINDunLevelDetail:InitDunLevelDetailNode(dunLevelData, isLocked)
  self.__dunLevelData = dunLevelData
  self.isLocked = isLocked
  self:_ResetInit()
  self:_UpdPower()
  self:RefreshEnterBattleCost()
  self:_UpdBattleBtn(self.isLocked)
  self.ui.unlockCondition:SetActive(isLocked)
  self.__initedTypeTog = {}
  local dungeonType = self.__dunLevelData:GetDungeonLevelType()
  if self.lastDunLevelType ~= dungeonType then
    self.lastDunLevelType = dungeonType
    self:GenTypeTogs()
  end
  self:PlayMoveTween(true)
  self:SelectDefaultTog()
  self.ui.btn_Recomme.gameObject:SetActive(dunLevelData:HasRecommendFormation())
  self:RefreshDungeonAutoBattleBtn(isLocked)
  self:__RefreshUnLockBtnState()
  if isLocked then
    if dungeonType == DungeonLevelEnum.DunLevelType.ADC then
      if self.__dunLevelData:GetIsInfinite() then
        cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(8422))
      end
    else
      self:UnlockLevelInfo(self.__dunLevelData:GetSpecialUnlockInfo(), self.__dunLevelData:GetLevelUnlockConditionCfg())
    end
  end
  self:_InitChallengeMode()
  self:_InitQuickBattle()
end

function UINDunLevelDetail:UnlockLevelInfo(specialUnlockInfo, ...)
  self:_UpdUnlockCondition(specialUnlockInfo, ...)
  if select("#", ...) <= 3 then
    local unLockInfo = CheckCondition.GetUnlockInfoLua(...)
    cs_MessageCommon.ShowMessageTipsWithErrorSound(unLockInfo)
  else
    local unLockInfo
    local firstCon, firstParam1, firstParam2 = select("1", ...)
    if 1 < #firstCon then
      unLockInfo = CheckCondition.GetUnlockInfoLua(firstCon, firstParam1, firstParam2)
      unLockInfo = string.format(ConfigData:GetTipContent(8708), unLockInfo)
    else
      local speStr = LanguageUtil.GetLocaleText(specialUnlockInfo)
      if not string.IsNullOrEmpty(speStr) then
        unLockInfo = speStr
      else
        unLockInfo = CheckCondition.GetUnlockInfoLuaByMany(...)
        unLockInfo = string.format(ConfigData:GetTipContent(8708), unLockInfo)
      end
    end
    cs_MessageCommon.ShowMessageTipsWithErrorSound(unLockInfo)
  end
end

function UINDunLevelDetail:_UpdPower()
  local dunLevelType = self.__dunLevelData:GetDungeonLevelType()
  if dunLevelType == DungeonLevelEnum.DunLevelType.SectorIIChallenge or dunLevelType == DungeonLevelEnum.DunLevelType.Bond then
    self.ui.obj_Power:SetActive(false)
  else
    self.ui.obj_Power:SetActive(true)
    self.ui.tex_Power.text = tostring(self.__dunLevelData:GetRecommendCombat())
  end
end

function UINDunLevelDetail:_UpdBattleBtn(isLocked)
  local dunLevelType = self.__dunLevelData:GetDungeonLevelType()
  if dunLevelType ~= DungeonLevelEnum.DunLevelType.ADC then
    self.ui.btn_Battle.gameObject:SetActive(not isLocked)
    self.ui.tex_Battle:SetIndex(0)
  else
    self.ui.btn_Battle.gameObject:SetActive(true)
    self.ui.tex_Battle:SetIndex(4)
    self.ui.tex_Battle.text.color = self.ui.color_lockTex
    self.ui.image_battle.color = self.ui.color_lockImg
  end
  self.ui.btn_GiveUP.gameObject:SetActive(false)
  if isLocked then
    return
  end
  self.ui.tex_Battle.text.color = self._colorNormalBattleTex
  self.ui.image_battle.color = self._colorNormalBattleImg
  self.ui.tex_Battle:SetIndex(0)
  if dunLevelType == DungeonLevelEnum.DunLevelType.SectorIIChallenge then
    local isFinish, inDungeon = self.__dunLevelData:GetSctIIChallengeDgStage()
    if inDungeon then
      self.ui.btn_GiveUP.gameObject:SetActive(true)
      self.ui.tex_GiveUP:SetIndex(1)
      self.ui.tex_Battle:SetIndex(1)
    end
  else
  end
end

function UINDunLevelDetail:GetDungeonLevelData()
  return self.__dunLevelData
end

function UINDunLevelDetail:_UpdUnlockCondition(specialUnlockInfo, ...)
  local unlockInfoList, isNeedFormat
  if select("#", ...) <= 3 then
    unlockInfoList = CheckCondition.GetUnlockAndInfoList(...)
  else
    local firstCon, firstParam1, firstParam2 = select("1", ...)
    if 1 < #firstCon then
      unlockInfoList = CheckCondition.GetUnlockAndInfoList(firstCon, firstParam1, firstParam2)
      isNeedFormat = true
    else
      unlockInfoList = CheckCondition.GetUnlockAndInfoListByMany(...)
      local speStr = LanguageUtil.GetLocaleText(specialUnlockInfo)
      if not string.IsNullOrEmpty(speStr) then
        unlockInfoList[1].lockReason = speStr
      else
        isNeedFormat = true
      end
    end
  end
  self.conditionItemPool:HideAll()
  for k, condition in ipairs(unlockInfoList) do
    local conditionItem = self.conditionItemPool:GetOne()
    local lockInfo = condition.lockReason
    if isNeedFormat then
      lockInfo = string.format(ConfigData:GetTipContent(8708), lockInfo)
    end
    conditionItem:InitStOUnlockConditionItem(condition.unlock, lockInfo)
  end
end

function UINDunLevelDetail:GenTypeTogs()
  self.typeTogPool:HideAll()
  local dungeonType = self.__dunLevelData:GetDungeonLevelType()
  local nodeTypeList = DungeonLevelEnum.nodeTyps[dungeonType]
  for index, infoNodeType in ipairs(nodeTypeList) do
    if self.__nodeDic[infoNodeType] == nil then
      local nodeCfg = self.__nodeCfg[infoNodeType]
      local nodeItem = nodeCfg.nodeClass.New()
      nodeItem:Init(nodeCfg.uiNode)
      nodeItem:Hide()
      nodeItem:BindDunLevelResloader(self.__resloader)
      self.__nodeDic[infoNodeType] = nodeItem
    end
    local togItem = self.typeTogPool:GetOne()
    local isLast = index == #nodeTypeList
    togItem:InitTog(infoNodeType, isLast, function()
      self:ShowPageNode(infoNodeType)
      if isLast then
        self.ui.img_lastTog.color = self.ui.color_white
      else
        self.ui.img_lastTog.color = self.ui.color_black
      end
    end)
    self.__togDic[infoNodeType] = togItem
  end
  for infoNodeType, nodeCfg in pairs(self.__nodeCfg) do
    if self.__nodeDic[infoNodeType] == nil then
      nodeCfg.uiNode:SetActive(false)
    end
  end
end

function UINDunLevelDetail:ShowPageNode(infoNodeType)
  for typeId, NodeItem in pairs(self.__nodeDic) do
    if infoNodeType == typeId then
      if self.SelectedNode ~= nil then
        self.SelectedNode:Hide()
      end
      NodeItem:Show()
      if self.__initedTypeTog[typeId] == nil then
        self.__initedTypeTog[typeId] = true
        NodeItem:InitDungeonInfoNode(self)
      end
      self.SelectedNode = NodeItem
      break
    end
  end
end

function UINDunLevelDetail:SelectDefaultTog()
  local dungeonType = self.__dunLevelData:GetDungeonLevelType()
  local nodeTypeList = DungeonLevelEnum.nodeTyps[dungeonType]
  local firshNodeType = nodeTypeList[1]
  local togItem = self.__togDic[firshNodeType]
  togItem.ui.tog_Type.isOn = false
  togItem.ui.tog_Type.isOn = true
end

function UINDunLevelDetail:RefreshEnterBattleCost()
  self.ui.obj_point:SetActive(true)
  local dunLevelType = self.__dunLevelData:GetDungeonLevelType()
  if self.__dunLevelData:IsDunCustomTicket() then
    local costId = self.__dunLevelData:GetEnterLevelCost()
    local costItemCfg = ConfigData.item[costId]
    local sprite = CRH:GetSpriteByItemConfig(costItemCfg, true)
    self.ui.obj_img_Key:SetActive(false)
    self.ui.img_EnterBattleCost.gameObject:SetActive(true)
    self.ui.img_EnterBattleCost.sprite = sprite
    self.ui.tex_Point:SetIndex(0, tostring(self.__dunLevelData:GetConsumeKeyNum()))
  elseif dunLevelType == DungeonLevelEnum.DunLevelType.ADC or dunLevelType == DungeonLevelEnum.DunLevelType.HeroGrowChallenge then
    self.ui.obj_point:SetActive(false)
  else
    local costId = self.__dunLevelData:GetEnterLevelCost()
    if costId == ConstGlobalItem.SKey then
      self.ui.obj_img_Key:SetActive(true)
      self.ui.img_EnterBattleCost.gameObject:SetActive(false)
    else
      self.ui.obj_img_Key:SetActive(false)
      self.ui.img_EnterBattleCost.gameObject:SetActive(true)
      local costItemCfg = ConfigData.item[costId]
      local sprite = CRH:GetSpriteByItemConfig(costItemCfg, true)
      self.ui.img_EnterBattleCost.sprite = sprite
    end
    self.ui.tex_Point:SetIndex(0, tostring(self.__dunLevelData:GetConsumeKeyNum()))
  end
end

function UINDunLevelDetail:RefreshDungeonAutoBattleBtn(isLocked)
  if isLocked then
    self.ui.btn_AutoBattle.gameObject:SetActive(false)
    return
  end
  local dungeonType = self.__dunLevelData:GetDungeonLevelType()
  if dungeonType == DungeonLevelEnum.DunLevelType.Tower then
    local dunTowerCtrl = ControllerManager:GetController(ControllerTypeId.DungeonTower)
    if dunTowerCtrl ~= nil then
      local showAuto, unlock = dunTowerCtrl:GetDungonTowerAutoBattleInfo(self.__dunLevelData)
      self.ui.btn_AutoBattle.gameObject:SetActive(showAuto)
      self.ui.img_AutoMask:SetActive(not unlock)
      return
    end
  elseif dungeonType == DungeonLevelEnum.DunLevelType.SectorII or dungeonType == DungeonLevelEnum.DunLevelType.SectorIII or dungeonType == DungeonLevelEnum.DunLevelType.HeroGrow or dungeonType == DungeonLevelEnum.DunLevelType.Season or dungeonType == DungeonLevelEnum.DunLevelType.SeasonI then
    local showAuto = self.__dunLevelData:GetCouldShowAutoPlay()
    local isUnlock = self.__dunLevelData:GetIsLevelCompleteNoSup()
    self.ui.btn_AutoBattle.gameObject:SetActive(showAuto)
    self.ui.img_AutoMask:SetActive(not isUnlock)
    return
  end
  self.ui.btn_AutoBattle.gameObject:SetActive(false)
end

function UINDunLevelDetail:RefreshNormalNodeReward()
  if self.__nodeDic[DungeonLevelEnum.eDunLevelInfoNodeType.LevelNormalInfo] ~= nil then
    self.__nodeDic[DungeonLevelEnum.eDunLevelInfoNodeType.LevelNormalInfo]:RefreshDLevelReward()
  end
end

function UINDunLevelDetail:__RefreshUnLockBtnState()
  local dungeonType = self.__dunLevelData:GetDungeonLevelType()
  if dungeonType ~= DungeonLevelEnum.DunLevelType.ADC then
    self.ui.btn_Unlock.gameObject:SetActive(false)
    return
  end
  if self.__dunLevelData:IsADCDungeonLevelUnlock() or self.__dunLevelData:GetIsInfinite() then
    self.ui.btn_Unlock.gameObject:SetActive(false)
    return
  end
  self.ui.btn_Unlock.gameObject:SetActive(true)
  local unlockItemId, unlockItemCount = self.__dunLevelData:GetADCDunUnlockItemAndCount()
  self.ui.img_unlock_Ticket.sprite = CRH:GetSpriteByItemId(unlockItemId, true)
  self.ui.tex_unlock_Point:SetIndex(0, tostring(unlockItemCount))
end

function UINDunLevelDetail:OnClickDungeonBattle()
  self:__EnterDungeonBattle()
end

local enterDunFunc = {
  [DungeonLevelEnum.DunLevelType.Tower] = function(self, isAutoBattle)
    local dunTowerCtrl = ControllerManager:GetController(ControllerTypeId.DungeonTower)
    if dunTowerCtrl ~= nil then
      dunTowerCtrl:EnterDungeonTowerFormation(self.__dunLevelData, isAutoBattle)
    end
  end,
  [DungeonLevelEnum.DunLevelType.SixHeroTower] = function(self, isAutoBattle)
    local sixHeroTowerCtrl = ControllerManager:GetController(ControllerTypeId.DunSixHeroTower)
    if sixHeroTowerCtrl ~= nil then
      sixHeroTowerCtrl:EnterSixHeroDunTowerFormation(self.__dunLevelData, isAutoBattle)
    end
  end,
  [DungeonLevelEnum.DunLevelType.SectorII] = function(self, autoBattleCount)
    local sectorIICtrl = ControllerManager:GetController(ControllerTypeId.SectorII)
    if sectorIICtrl ~= nil then
      sectorIICtrl:EnterActSectorIIDungeonFormation(self.__dunLevelData, autoBattleCount)
    end
  end,
  [DungeonLevelEnum.DunLevelType.SectorIIChallenge] = function(self, isAutoBattle)
    local sectorIICtrl = ControllerManager:GetController(ControllerTypeId.SectorII)
    if sectorIICtrl ~= nil then
      sectorIICtrl:ReqEnterActSctIIChallengeDg(self.__dunLevelData)
    end
  end,
  [DungeonLevelEnum.DunLevelType.AprilFool] = function(self, isAutoBattle)
    local ARDCtrl = ControllerManager:GetController(ControllerTypeId.ActRefreshDungeon)
    if ARDCtrl ~= nil then
      ARDCtrl:EnterARDDungeonFormation(self.__dunLevelData)
    end
  end,
  [DungeonLevelEnum.DunLevelType.Carnival] = function(self, isAutoBattle)
    local carnivalCtrl = ControllerManager:GetController(ControllerTypeId.ActivityCarnival)
    if carnivalCtrl ~= nil then
      carnivalCtrl:OnEnterCarnivalChallenge(self.__dunLevelData)
    end
  end,
  [DungeonLevelEnum.DunLevelType.ADC] = function(self, isAutoBattle)
    if not self.__dunLevelData:IsADCDungeonLevelUnlock() then
      if self.__dunLevelData:GetIsInfinite() then
        cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(8422))
      else
        cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(8411))
      end
      return
    end
    local adcCtrl = ControllerManager:GetController(ControllerTypeId.ActivityDailyChallenge)
    adcCtrl:EnterADCDungeon(self.__dunLevelData)
  end,
  [DungeonLevelEnum.DunLevelType.SectorIII] = function(self, autoBattleCount)
    local sectorIIICtrl = ControllerManager:GetController(ControllerTypeId.ActivitySectorIII)
    if sectorIIICtrl ~= nil then
      sectorIIICtrl:EnterActSectorIIIDungeonFormation(self.__dunLevelData, autoBattleCount)
    end
  end,
  [DungeonLevelEnum.DunLevelType.HeroGrow] = function(self, autoBattleCount)
    local heroGrowCtr = ControllerManager:GetController(ControllerTypeId.ActivityHeroGrow)
    if heroGrowCtr ~= nil then
      heroGrowCtr:EnterHeroGrowDugeon(self.__dunLevelData, autoBattleCount)
    end
  end,
  [DungeonLevelEnum.DunLevelType.Season] = function(self, autoBattleCount)
    local seasonCtrl = ControllerManager:GetController(ControllerTypeId.ActivityHallowmas)
    if seasonCtrl ~= nil then
      seasonCtrl:EnterSeasonDugeon(self.__dunLevelData, autoBattleCount)
    end
  end,
  [DungeonLevelEnum.DunLevelType.Spring] = function(self, autoBattleCount)
    local springCtrl = ControllerManager:GetController(ControllerTypeId.ActivitySpring)
    if springCtrl ~= nil then
      springCtrl:OnEnterSpringChallenge(self.__dunLevelData)
    end
  end,
  [DungeonLevelEnum.DunLevelType.SeasonI] = function(self, autoBattleCount)
    local seasonCtrl = ControllerManager:GetController(ControllerTypeId.ActivitySeason)
    if seasonCtrl ~= nil then
      seasonCtrl:OnEnterActSeasonChallenge(self.__dunLevelData, autoBattleCount)
    end
  end,
  [DungeonLevelEnum.DunLevelType.Repeat] = function(self, autoBattleCount)
    DungeonEnterUtil.EnterCommonRepeatDg(self.__dunLevelData, autoBattleCount, self._stgChallengeData)
  end,
  [DungeonLevelEnum.DunLevelType.ActBlackHole] = function(self, autoBattleCount)
    local blackHoleCtrl = ControllerManager:GetController(ControllerTypeId.ActBlackHole)
    if blackHoleCtrl ~= nil then
      blackHoleCtrl:OnEnterBlackHoleDungeon(self.__dunLevelData)
    end
  end,
  [DungeonLevelEnum.DunLevelType.CommonHard] = function(self, autoBattleCount)
    local ActHardLevelManager = require("Game.ActivityFrame.ActCommonHardLevel.ActHardLevelManager")
    ActHardLevelManager.AHLM_EnterFormation(self.__dunLevelData)
  end,
  [DungeonLevelEnum.DunLevelType.HeroGrowV3Repeat] = function(self, autoBattleCount)
    local function enterFunc()
      UIManager:HideWindow(UIWindowTypeID.DungeonLevelDetail)
      
      UIManager:HideWindow(UIWindowTypeID.CharDunVer3Repeat)
    end
    
    local function exitFunc()
      UIManager:ShowWindowOnly(UIWindowTypeID.DungeonLevelDetail, true)
      UIManager:ShowWindowOnly(UIWindowTypeID.CharDunVer3Repeat, true)
      BattleDungeonManager.autoCtrl:DungeonAutoReset()
    end
    
    DungeonEnterUtil.EnterActCommonRepeatDg(self.__dunLevelData, autoBattleCount, self._stgChallengeData, enterFunc, exitFunc, FmtEnum.eFmtFromModule.HGV3Repeat, DungeonInterfaceData.CreateHGV3RepeatDungeonInterface)
  end,
  [DungeonLevelEnum.DunLevelType.HeroGrowChallenge] = function(self, autoBattleCount)
    local heroGrowV3Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityHeroGrowV3)
    if heroGrowV3Ctrl ~= nil then
      heroGrowV3Ctrl:OnEnterHeroGrowChallenge(self.__dunLevelData)
    end
  end,
  [DungeonLevelEnum.DunLevelType.Bond] = function(self, autoBattleCount)
    local bondCtrl = ControllerManager:GetController(ControllerTypeId.ActivityBond)
    if bondCtrl ~= nil then
      bondCtrl:EnterBondDugeon(self.__dunLevelData)
    end
  end
}

function UINDunLevelDetail:__EnterDungeonBattle()
  local dungeonType = self.__dunLevelData:GetDungeonLevelType()
  local func = enterDunFunc[dungeonType]
  if func == nil then
    error("no enter dungeon func type:" .. tostring(dungeonType))
    return
  end
  func(self)
  if self._stgChallengeData ~= nil then
    self._stgChallengeData:TrySaveStgChallengeTask()
  end
end

function UINDunLevelDetail:OnClickDungeonAutoBattle()
  local dungeonType = self.__dunLevelData:GetDungeonLevelType()
  if dungeonType == DungeonLevelEnum.DunLevelType.Tower then
    enterDunFunc[DungeonLevelEnum.DunLevelType.Tower](self, true)
  elseif dungeonType == DungeonLevelEnum.DunLevelType.SectorII or dungeonType == DungeonLevelEnum.DunLevelType.SectorIII or dungeonType == DungeonLevelEnum.DunLevelType.HeroGrow or dungeonType == DungeonLevelEnum.DunLevelType.Season or dungeonType == DungeonLevelEnum.DunLevelType.SeasonI or dungeonType == DungeonLevelEnum.DunLevelType.Repeat or dungeonType == DungeonLevelEnum.DunLevelType.HeroGrowV3Repeat then
    if not self.__dunLevelData:GetIsLevelCompleteNoSup() then
      local tipId = self.__dunLevelData:GetCantAutoBattleTip() or 7102
      cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(tipId))
      return
    end
    if not self.__dunLevelData:GetIsCouldPlayOnce() then
      if dungeonType == DungeonLevelEnum.DunLevelType.HeroGrowV3Repeat then
        local str = ConfigData:GetTipContent(7916)
        cs_MessageCommon.ShowMessageTipsWithErrorSound(str)
      else
        local itemId = self.__dunLevelData:GetEnterLevelCost()
        if itemId == ConstGlobalItem.SKey then
          JumpManager:Jump(JumpManager.eJumpTarget.BuyStamina)
          return
        end
        local itemName = self.__dunLevelData:GetEnterLevelCostItemName()
        local actName = self.__dunLevelData:GetDungeonActName()
        local str = string.format(ConfigData:GetTipContent(7104), itemName, actName, itemName)
        cs_MessageCommon.ShowMessageTipsWithErrorSound(str)
      end
      return
    end
    UIManager:CreateWindowAsync(UIWindowTypeID.BattleAutoMode, function(window)
      if window == nil then
        return
      end
      self._ReqQuickBattleFunc = self._ReqQuickBattleFunc or BindCallback(self, self._ReqQuickBattle)
      window:InitSectorIIDunAutoSet(self.__dunLevelData, function(autoCount)
        local dungeonType = self.__dunLevelData:GetDungeonLevelType()
        local func = enterDunFunc[dungeonType]
        if func ~= nil then
          func(self, autoCount)
        end
      end, self._ReqQuickBattleFunc)
    end)
  end
end

function UINDunLevelDetail:OnClickDungeonRecomme()
  local recommeCtrl = ControllerManager:GetController(ControllerTypeId.RecommeFormation, true)
  recommeCtrl:ReqDunRecommeFormation(self.__dunLevelData:GetDungeonLevelStageId(), false)
  recommeCtrl:SetTopStatusHide(false)
end

function UINDunLevelDetail:_OnClickGiveup()
  local dungeonType = self.__dunLevelData:GetDungeonLevelType()
  if dungeonType == DungeonLevelEnum.DunLevelType.SectorIIChallenge then
    local sectorIICtrl = ControllerManager:GetController(ControllerTypeId.SectorII)
    if sectorIICtrl ~= nil then
      sectorIICtrl:ReqSettleActSctIIChallengeDg(self.__dunLevelData, function(objList)
        self:_UpdBattleBtn(self.isLocked)
        if objList.Count <= 0 then
          error("CS_DUNGEONWinterVerify_Settle objList.Count error:" .. tostring(objList.Count))
          return
        end
        local msg = objList[0]
        
        local function showRewardFunc()
          UIUtil.ReShowTopStatus()
          if table.count(msg.rewards) > 0 then
            UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
              if window == nil then
                return
              end
              local CommonRewardData = require("Game.CommonUI.CommonRewardData")
              local CRData = CommonRewardData.CreateCRDataUseDic(msg.rewards)
              window:AddAndTryShowReward(CRData)
            end)
          end
        end
        
        local historyMaxScore = self.__dunLevelData:GetSctIIChallengeDgMaxScore()
        UIManager:ShowWindowAsync(UIWindowTypeID.WCDebuffResult, function(window)
          if window == nil then
            return
          end
          window:InitWinChallengeScoreShow(msg, false, historyMaxScore, showRewardFunc)
          UIUtil.HideTopStatus()
        end)
      end)
    end
  end
end

function UINDunLevelDetail:OnClickUnlock()
  local dungeonType = self.__dunLevelData:GetDungeonLevelType()
  if dungeonType == DungeonLevelEnum.DunLevelType.ADC then
    self.__dunLevelData:ReqADCDunUnlock(function()
      if not IsNull(self.transform) then
        self:_UpdBattleBtn(false)
        self:__RefreshUnLockBtnState()
      end
    end)
  end
end

function UINDunLevelDetail:_InitChallengeMode()
  self._stgChallengeData = nil
  if self.isLocked then
    return
  end
  local dungeonId = self.__dunLevelData:GetDungeonLevelStageId()
  if not PlayerDataCenter.dungeonCenterData:HasDungeonChallengeTask(dungeonId) then
    return
  end
  self.ui.obj_ChallengeNode:SetActive(true)
  self._stgChallengeData = DungeonChallengeData.Create(dungeonId)
  local isChallengeMode = false
  if PlayerDataCenter.dungeonCenterData:IsDungeonChallengeTaskOpen(dungeonId) then
    local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
    isChallengeMode = saveUserData:GetChallengeDgSwitch(dungeonId)
  end
  self._stgChallengeData:SetStageChallengeOpen(isChallengeMode)
  self._switchChallengeTog:InitCommonSwitchToggle(isChallengeMode, self._changeChallengeFunc)
  self:_UpdClgRewardNumPrewview()
end

function UINDunLevelDetail:_OnClickChallenge()
  UIManager:ShowWindowAsync(UIWindowTypeID.FmtChallengeInfo, function(win)
    if win == nil then
      return
    end
    win:InitFmtChallengeInfo(self._stgChallengeData, function()
      if self._stgChallengeData:IsStageChallengeOpen() then
        self:_UpdClgRewardNumPrewview()
        return
      end
      self:_SetChallengeModeOpen(true)
    end)
  end)
end

function UINDunLevelDetail:_OnClickChallengeModeTog(isChallengeMode)
  self:_SetChallengeModeOpen(isChallengeMode)
  if isChallengeMode then
    UIManager:ShowWindowAsync(UIWindowTypeID.FmtChallengeInfo, function(win)
      if win == nil then
        return
      end
      win:InitFmtChallengeInfo(self._stgChallengeData, function()
        self:_UpdClgRewardNumPrewview()
      end)
    end)
  end
end

function UINDunLevelDetail:_SetChallengeModeOpen(isChallengeMode)
  if self._stgChallengeData:IsStageChallengeOpen() == isChallengeMode then
    return
  end
  self._stgChallengeData:SetStageChallengeOpen(isChallengeMode)
  self._switchChallengeTog:SetCommonSwitchToggleValue(isChallengeMode)
  self:_UpdClgRewardNumPrewview()
end

function UINDunLevelDetail:_UpdClgRewardNumPrewview()
  if self._stgChallengeData == nil then
    return
  end
  local rewardNum = self._stgChallengeData:GetStgChallengeTaskRewardNum()
  if 0 < rewardNum then
    self.ui.obj_ClgReward:SetActive(true)
    self.ui.tex_ClgRewardNum:SetIndex(0, tostring(rewardNum))
  else
    self.ui.obj_ClgReward:SetActive(false)
  end
end

function UINDunLevelDetail:_InitQuickBattle()
  if self.isLocked then
    return
  end
  if IsNull(self.ui.btn_QuickBattle) then
    return
  end
  if not self.__dunLevelData:IsDgQuickBattleOpen() then
    return
  end
  self.ui.btn_QuickBattle.gameObject:SetActive(true)
  local unlock = self.__dunLevelData:GetIsLevelCompleteNoSup()
  self.ui.img_QuickBattle.color = unlock and self._colorQuickBattle or self.ui.color_lockQuickBattle
end

function UINDunLevelDetail:_OnClickQuickBattle()
  self:OnClickDungeonAutoBattle()
end

function UINDunLevelDetail:_ReqQuickBattle(autoCount)
  UIManager:DeleteWindow(UIWindowTypeID.BattleAutoMode)
  local dungeonId = self.__dunLevelData:GetDungeonLevelStageId()
  NetworkManager:GetNetwork(NetworkTypeID.BattleDungeon):CS_Dungeon_Quick(dungeonId, autoCount, function(objList)
    if objList.Count ~= 1 then
      error("objList.Count error:" .. tostring(objList.Count))
      return
    end
    local msg = objList[0]
    local rewardDic = msg.rewards
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonQuickBattle, function(win)
      if win == nil then
        return
      end
      win:InitCmQuickBattle(rewardDic, nil, msg.DZDK)
    end)
  end)
end

function UINDunLevelDetail:GetDNLevelDetailWidthAndDuration()
  return self.transform.sizeDelta.x, self.ui.moveTween.duration
end

function UINDunLevelDetail:CloseDgLvDetailNodeShowAudio()
  self._closeShowAudio = true
end

function UINDunLevelDetail:PlayMoveTween(isShow)
  if isShow then
    if self.__isShow then
      return
    end
    self.__isShow = true
    self.ui.moveTween:DOPlayForward()
    if not self._closeShowAudio then
      AudioManager:PlayAudioById(1033)
    end
  else
    self.ui.moveTween:DOPlayBackwards()
    AudioManager:PlayAudioById(1034)
  end
  UIUtil.AddOneCover("DLevelDetailTween")
end

function UINDunLevelDetail:__OnMoveTweenComplete()
  UIUtil.CloseOneCover("DLevelDetailTween")
end

function UINDunLevelDetail:__OnMoveTweenRewind()
  UIUtil.CloseOneCover("DLevelDetailTween")
  UIManager:HideWindow(UIWindowTypeID.ClickContinue)
  UIManager:HideWindow(UIWindowTypeID.DungeonLevelDetail)
  self.__isShow = false
end

function UINDunLevelDetail:OnShow()
  if self._stgChallengeData ~= nil then
    self._switchChallengeTog:SetCommonSwitchToggleValue(self._stgChallengeData:IsStageChallengeOpen())
    self:_UpdClgRewardNumPrewview()
  end
  base.OnShow(self)
end

function UINDunLevelDetail:OnHide()
  UIUtil.CloseOneCover("DLevelDetailTween")
end

function UINDunLevelDetail:OnDelete()
  if self.__nodeDic ~= nil then
    for k, v in pairs(self.__nodeDic) do
      v:Delete()
    end
    self.__nodeDic = nil
  end
  base.OnDelete(self)
end

return UINDunLevelDetail
