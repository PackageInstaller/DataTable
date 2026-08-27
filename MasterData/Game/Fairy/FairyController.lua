local base = ControllerBase
local FairyController = class("FairyController", base)
local util = require("XLua.Common.xlua_util")
local FairyCultivateShowCtrl = require("Game.Fairy.SubSystemCtrl.FairyCultivateShowCtrl")
local JumpManager = require("Game.Jump.JumpManager")
local FairyHallCtrl = require("Game.Fairy.SubSystemCtrl.FairyHallCtrl")
local FairyData = require("Game.Fairy.Data.FairyData")
local eFairyEnum = require("Game.Fairy.eFairyEnum")

function FairyController:ctor()
  self._allFairyDataDic = nil
  self.network = NetworkManager:GetNetwork(NetworkTypeID.Fairy)
  self.cultivateShowCtrl = FairyCultivateShowCtrl.New(self)
  self.fairyHallCtrl = FairyHallCtrl.New(self)
end

function FairyController:QuestAllFairyData()
  self.network:CS_Fairy_Detail(function(args)
    if args.Count == 0 then
      error("args.Count == 0")
      return
    end
    local msg = args[0]
    local fairyGroupMsg = msg.data
    self:GenAllFairyData(fairyGroupMsg)
  end)
end

function FairyController:GenAllFairyData(fairyGroupMsg)
  self._allFairyDataDic = {}
  if fairyGroupMsg == nil then
    return
  end
  for fairyUID, fairyMsg in pairs(fairyGroupMsg.data) do
    self._allFairyDataDic[fairyUID] = FairyData.GenFairyData(fairyMsg)
  end
end

function FairyController:UpdateDiffFairyData(fairyGroupMsg)
  if fairyGroupMsg == nil then
    return
  end
  local fairyListChanged = false
  local deleteFairys = fairyGroupMsg.deleteFairy or {}
  for id, fairyMsg in pairs(fairyGroupMsg.data) do
    if self._allFairyDataDic[fairyMsg.base.uid] then
      self._allFairyDataDic[fairyMsg.base.uid]:UpdaetFairyData(fairyMsg)
    else
      self._allFairyDataDic[fairyMsg.base.uid] = FairyData.GenFairyData(fairyMsg)
      fairyListChanged = true
    end
  end
  local haveDelete = 0 < #deleteFairys
  fairyListChanged = fairyListChanged or haveDelete
  for index, id in pairs(deleteFairys) do
    self._allFairyDataDic[id] = nil
  end
  MsgCenter:Broadcast(eMsgEventId.UpdateFairy, fairyListChanged, self)
end

function FairyController:GetFairyDataByUID(fairyUID)
  return self._allFairyDataDic[fairyUID]
end

function FairyController:GetFairyDataDic()
  return self._allFairyDataDic
end

function FairyController:GetFairyCountIsMax()
  local nowNum = self:GetFairyCount()
  local maxNum = self:GetFairyBagMaxNum()
  return nowNum >= maxNum
end

function FairyController:GetFairyBagMaxNum()
  return ConfigData.game_config.fairyMaxCount
end

function FairyController:GetFairyCount()
  local fairyCount = 0
  if not self._allFairyDataDic then
    return fairyCount
  end
  for i, v in pairs(self._allFairyDataDic) do
    fairyCount = fairyCount + 1
  end
  return fairyCount
end

function FairyController:GetPlayerHaveFairy()
  return self:GetFairyCount() > 0
end

function FairyController:GetHallFairyDataTable()
  local showFairyDataTypeTable = {}
  for fairyUID, fairyData in pairs(self._allFairyDataDic) do
    local fairyType = fairyData:GetFairyID()
    if showFairyDataTypeTable[fairyType] == nil then
      showFairyDataTypeTable[fairyType] = fairyData
    elseif showFairyDataTypeTable[fairyType]:GetFairyCurStar() < fairyData:GetFairyCurStar() then
      showFairyDataTypeTable[fairyType] = fairyData
    end
  end
  return showFairyDataTypeTable
end

function FairyController:CalculateRecoveryFairyRewardsAndNum(fairyDataList)
  local rewardIds = {}
  local rewardNums = {}
  local rewardsDic = {}
  for index, fairyData in pairs(fairyDataList) do
    local starLevel = fairyData:GetFairyCurStar()
    local recycleRewards = ConfigData.fairy_star_new[starLevel].recycle_reward
    for rewardId, rewardNum in pairs(recycleRewards) do
      if rewardsDic[rewardId] ~= nil then
        rewardsDic[rewardId] = rewardsDic[rewardId] + rewardNum
      else
        rewardsDic[rewardId] = rewardNum
      end
    end
  end
  for rewardId, rewardNum in pairs(rewardsDic) do
    table.insert(rewardIds, rewardId)
    table.insert(rewardNums, rewardNum)
  end
  return rewardIds, rewardNums
end

function FairyController:ShowFyKeepSkillSelect(fairyData)
  local keepSkillDic, keepStar = fairyData:GetFairyKeepData()
  local fySkillDataList = {}
  local FairySkillData = require("Game.Fairy.Data.FairySkillData")
  local skillDataDic = {}
  for uid, data in pairs(keepSkillDic) do
    local skillData = FairySkillData.GenFairyKeepData(data, uid)
    local realSkillId = skillData:GetFiaryRealSkillId()
    if skillDataDic[realSkillId] == nil or skillDataDic[realSkillId]:GetFairySkillRareLevel() > skillData:GetFairySkillRareLevel() or skillData:IsFySkillMine() then
      skillDataDic[realSkillId] = skillData
    end
  end
  for realSkillId, skillData in pairs(skillDataDic) do
    table.insert(fySkillDataList, skillData)
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.FairyQuickLvSkillSave, function(win)
    if win == nil then
      return
    end
    win:InitFairyQkLvUpSkillSave(fairyData, fySkillDataList, keepStar)
  end)
end

function FairyController:HandleFairyJumpManagerArg(isEnter)
  if isEnter then
    self.lastCouldUseItemJump = JumpManager.couldUseItemJump
    JumpManager.couldUseItemJump = true
  else
    if self.lastCouldUseItemJump == nil then
      return
    end
    JumpManager.couldUseItemJump = self.lastCouldUseItemJump
    self.lastCouldUseItemJump = nil
  end
end

function FairyController:EnterFairyCultivate(enterFunc, exitFunc, defaultUid, showFaiyType)
  local __exitFunc
  if eFairyEnum.ShowFaiyType.FairyHallScene == showFaiyType then
    local fairyData = self:GetFairyDataByUID(defaultUid)
    self.fairyHallCtrl:OnEnterShowFairyMode(fairyData)
    
    function __exitFunc()
      self.fairyHallCtrl:OnExitShowFairyMode()
      if exitFunc ~= nil then
        exitFunc()
      end
    end
  elseif eFairyEnum.ShowFaiyType.CultivateShow == showFaiyType then
    self.cultivateShowCtrl:InitFairyCultivateShowCtrl(nil, nil, defaultUid)
    
    function __exitFunc()
      self.cultivateShowCtrl:ExitFairyCultivateShow()
      if exitFunc ~= nil then
        exitFunc()
      end
    end
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.FairyCultivateMain, function(window)
    local hideWinList = UIManager:HideAllWindow({
      [UIWindowTypeID.TopStatus] = true,
      [UIWindowTypeID.FairyCultivateMain] = true
    })
    local jumpCorverArgs = {hideWinList = hideWinList}
    window:SetFromWhichUI(eBaseWinFromWhere.jumpCorver)
    window.jumpCorverArgs = jumpCorverArgs
    window:InitFairyCultivateMain(defaultUid, __exitFunc)
    if enterFunc ~= nil then
      enterFunc()
    end
  end)
end

function FairyController:HandleFairyJumpArg(targetType, callback)
  if targetType == eFairyEnum.jumpType.cultivate then
    local win = UIManager:GetWindow(UIWindowTypeID.FairyLobbyMain)
    if not UIUtil.CheckIsHaveSpecialMarker(UIWindowTypeID.FairyCultivateMain) then
      UIUtil.ReturnUntil2Marker(UIWindowTypeID.FairyLobbyMain)
      win:OnClickFairyList()
    else
      UIUtil.ReturnUntil2Marker(UIWindowTypeID.FairyCultivateMain)
    end
    if callback ~= nil then
      callback()
    end
  elseif targetType == eFairyEnum.jumpType.lottery then
    UIUtil.ReturnUntil2Marker(UIWindowTypeID.FairyLobbyMain)
    local win = UIManager:GetWindow(UIWindowTypeID.FairyLobbyMain)
    win:OnClickGetFairy(callback)
  end
end

function FairyController:EnterFairyLobby(callback)
  UIManager:DeleteAllWindow()
  self:HandleFairyJumpManagerArg(true)
  
  local function preLoadFunc()
    local showFairyDataTable = self:GetHallFairyDataTable()
    self.fairyHallCtrl:PreLoadFairyPrefab(showFairyDataTable)
    UIManager:ShowWindowAsync(UIWindowTypeID.FairyLobbyMain)
    while UIManager:GetWindow(UIWindowTypeID.FairyLobbyMain) == nil do
      coroutine.yield(nil)
    end
  end
  
  CS.GSceneManager.Instance:LoadSceneAsyncByAB(Consts.SceneName.FairyLobbyMain, function(ok)
    local win = UIManager:GetWindow(UIWindowTypeID.FairyLobbyMain)
    if win == nil then
      return
    end
    win:InitFairyLobbyMain(self)
    self.fairyHallCtrl:InitFairyHallCtrl()
    self.fairyHallCtrl:PlayEnterTimeLine()
    self.fairyHallCtrl:RefreshHallFairyEntity()
    if callback ~= nil then
      callback()
    end
  end, util.cs_generator(preLoadFunc))
end

function FairyController:ExitFairyLobby()
  UIManager:DeleteAllWindow()
  self:HandleFairyJumpManagerArg(false)
  self:Clear()
  CS.GSceneManager.Instance:LoadSceneAsyncByAB(Consts.SceneName.Main, function(ok)
    ControllerManager:GetController(ControllerTypeId.HomeController, true):OnEnterHome()
    UIManager:ShowWindowAsync(UIWindowTypeID.Home, function(window)
      if window == nil then
        return
      end
      window:SetFrom2Home(AreaConst.Sector, true)
    end)
  end)
end

function FairyController:Clear()
  if self.cultivateShowCtrl ~= nil then
    self.cultivateShowCtrl:Delete()
  end
  if self.fairyHallCtrl ~= nil then
    self.fairyHallCtrl:Delete()
  end
end

function FairyController:OnDelete()
  self:Clear()
  base.OnDelete(self)
end

return FairyController
