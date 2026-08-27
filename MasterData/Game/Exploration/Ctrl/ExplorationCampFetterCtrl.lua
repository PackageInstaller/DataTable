local ExplorationCampFetterCtrl = class("ExplorationCampFetterCtrl", ExplorationCtrlBase)
local cs_MessageCommon = CS.MessageCommon
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local REFRESH_CHIP_UID = 4294967300
local CDType2TipDic = {
  [ExplorationEnum.eCampFetterCDType.totalEp] = function()
    return ConfigData:GetTipContent(TipContent.CampFetter_ActiveCD1)
  end,
  [ExplorationEnum.eCampFetterCDType.nextFoor] = function(dynCampFetter)
    local _, CD = dynCampFetter:GetActiveFetterSkillCD()
    return string.format(ConfigData:GetTipContent(TipContent.CampFetter_ActiveCD2), tostring(CD))
  end,
  [ExplorationEnum.eCampFetterCDType.afterBattle] = function(dynCampFetter)
    local _, CD = dynCampFetter:GetActiveFetterSkillCD()
    return string.format(ConfigData:GetTipContent(TipContent.CampFetter_ActiveCD3), tostring(CD))
  end,
  [ExplorationEnum.eCampFetterCDType.afterMoveRoom] = function(dynCampFetter)
    local _, CD = dynCampFetter:GetActiveFetterSkillCD()
    return string.format(ConfigData:GetTipContent(TipContent.CampFetter_ActiveCD4), tostring(CD))
  end
}

function ExplorationCampFetterCtrl:ctor(epCtrl)
  local eCampFetterActiveSkillType = ExplorationEnum.eCampFetterActiveSkillType
  self.explorationNetworkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Exploration)
  self.epCtrl = epCtrl
  self.dynPlayer = self.epCtrl.dynPlayer
  self.__buffIds = nil
  self.isHaveActive = nil
  self.activeDynCampFetter = nil
  self.activeShowConditionList = nil
  self.usingCampFetterList = nil
  self.couldUpdateDic = {}
  self.couldShowAciveFetter = true
  self:InItCampFetterCtrlData()
  self.__onEpOpStateChanged = BindCallback(self, self.__OnEpOpStateChanged)
  MsgCenter:AddListener(eMsgEventId.OnEpOpStateChanged, self.__onEpOpStateChanged)
  self.__onBuffChange = BindCallback(self, self.OnBuffChange)
  MsgCenter:AddListener(eMsgEventId.OnEpBuffListChange, self.__onBuffChange)
end

function ExplorationCampFetterCtrl:IsHaveCampFetter()
  local usingCampFetterList, totalUsingNum = self:GetUsingCampFetterList()
  return 0 < totalUsingNum
end

function ExplorationCampFetterCtrl:IsHaveActiveCampFetter()
  return self.isHaveActive
end

function ExplorationCampFetterCtrl:InItCampFetterCtrlData()
  local isCampFetterUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_CampConnection)
  if not isCampFetterUnlock then
    return
  end
  self.activeDynCampFetter = self:GetActiveDynCampFetter()
  self.isHaveActive = self.activeDynCampFetter ~= nil
  self:ConfigIsNeedUpdate()
end

function ExplorationCampFetterCtrl:ConfigIsNeedUpdate()
  local couldGen = self:__GenActiveShowConditionList()
  if not couldGen then
    return
  end
  for _, condition in pairs(self.activeShowConditionList) do
    self.couldUpdateDic[condition] = true
  end
end

function ExplorationCampFetterCtrl:GetUsingCampFetterList()
  if self.usingCampFetterList ~= nil then
    return self.usingCampFetterList, self.totalUsingNum
  end
  local totalUsingNum = 0
  local usingCampFetterList = {}
  for campId, dynCampFetter in pairs(self.dynPlayer.campFetterDic) do
    local campFetterList, usingNum = dynCampFetter:GetAllCampFetter()
    local campHeroCount = dynCampFetter:GetCampHeroNum()
    table.insert(usingCampFetterList, {
      campFetterList = campFetterList,
      campId = campId,
      campHeroCount = campHeroCount
    })
    totalUsingNum = totalUsingNum + usingNum
  end
  table.sort(usingCampFetterList, function(a, b)
    return a.campId < b.campId
  end)
  self.usingCampFetterList = usingCampFetterList
  self.totalUsingNum = totalUsingNum
  return usingCampFetterList, totalUsingNum
end

function ExplorationCampFetterCtrl:GetActiveDynCampFetter()
  if self.dynPlayer.activeCampFetterId ~= nil then
    return self.dynPlayer.campFetterDic[self.dynPlayer.activeCampFetterId]
  end
end

function ExplorationCampFetterCtrl:UseActiveFetterSkill(uid, callback)
  if self.activeDynCampFetter == nil then
    return false
  end
  if self.activeDynCampFetter:GetCouldeUseActiveFetterSkill() then
    self.explorationNetworkCtrl:CS_EXPLORATION_CAMP_FETTER_USE(uid, callback)
    return true
  else
    return false
  end
end

function ExplorationCampFetterCtrl:__GenActiveShowConditionList()
  if self.activeShowConditionList == nil then
    if self.activeDynCampFetter == nil then
      return false
    end
    local camp_active_skillId = self.activeDynCampFetter:GetActiveFetterSkillID()
    if camp_active_skillId == nil then
      return false
    end
    local camp_active_skillCfg = ConfigData.camp_active_skill[camp_active_skillId]
    if camp_active_skillCfg ~= nil then
      self.activeShowConditionList = camp_active_skillCfg.use_limit
    else
      return false
    end
  end
  return true
end

function ExplorationCampFetterCtrl:CouldShowActiveFetterSkill(eCampFetterUsableConditon)
  if not self.couldShowAciveFetter then
    return false
  end
  local couldGen = self:__GenActiveShowConditionList()
  if not couldGen then
    return false
  end
  for _, condition in ipairs(self.activeShowConditionList) do
    if condition == eCampFetterUsableConditon then
      return true
    elseif condition == ExplorationEnum.eCampFetterUsableConditon.epCouldSelectNextRoom and eCampFetterUsableConditon == ExplorationEnum.eCampFetterUsableConditon.ep then
      return nil
    end
  end
  return false
end

function ExplorationCampFetterCtrl:__OnEpOpStateChanged(opDetail, state)
  if opDetail ~= nil then
    state = opDetail.state
  end
  if state == proto_object_ExplorationCurGridState.ExplorationCurGridState_Over then
    self:OnEpCouldeSelectNextRoom()
  else
    self:OnEpCouldeSelectNextRoom(true)
  end
end

function ExplorationCampFetterCtrl:OnEpBack2Ep()
  if not self.couldUpdateDic[ExplorationEnum.eCampFetterUsableConditon.ep] then
    return
  end
  local stateInfoWin = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if stateInfoWin == nil then
    return
  end
  local epCampFetterNode = stateInfoWin:GetEpCampFetterNode()
  local couldShow = self:CouldShowActiveFetterSkill(ExplorationEnum.eCampFetterUsableConditon.ep)
  if couldShow == nil then
    return
  end
  epCampFetterNode:SetHasEpActiveCampFetter(couldShow)
  if not couldShow then
    return
  end
  local uid, campId, heroNum = self.activeDynCampFetter:GetActiveFetterUID()
  
  local function RefreshCouldUse()
    local CDType = self.activeDynCampFetter:GetActiceFetterCDType()
    local cdStr = CDType2TipDic[CDType](self.activeDynCampFetter)
    local couldUse = self.activeDynCampFetter:GetCouldeUseActiveFetterSkill()
    epCampFetterNode:SetActiveCampFetter(campId, heroNum, couldUse, cdStr)
  end
  
  RefreshCouldUse()
  epCampFetterNode:SetClickActiveCampFetter(function()
    if self.activeDynCampFetter:GetCouldeUseActiveFetterSkill() then
      self:ConfirmBeforeUseActive(self.activeDynCampFetter:GetActiveFetterDes(), function()
        self:UseActiveFetterSkill(uid, function()
          RefreshCouldUse()
        end)
      end)
    else
      RefreshCouldUse()
    end
  end)
end

function ExplorationCampFetterCtrl:OnEpSelectChip()
  local selectChipWindow = UIManager:GetWindow(UIWindowTypeID.SelectChip)
  if selectChipWindow == nil then
    return
  end
  local jumpCat = self.dynPlayer:GetOperatorDetail().jumpCat
  if jumpCat ~= nil and jumpCat ~= 0 then
    return
  end
  if not self.couldUpdateDic[ExplorationEnum.eCampFetterUsableConditon.epChipSelect] then
    return
  end
  local couldShow = self:CouldShowActiveFetterSkill(ExplorationEnum.eCampFetterUsableConditon.epChipSelect)
  selectChipWindow:SetHasEpActiveCampFetter(couldShow)
  if not couldShow then
    return
  end
  local uid, campId, heroNum = self.activeDynCampFetter:GetActiveFetterUID()
  
  local function RefreshCouldUse()
    local CDType = self.activeDynCampFetter:GetActiceFetterCDType()
    local cdStr = CDType2TipDic[CDType](self.activeDynCampFetter)
    local couldUse = self.activeDynCampFetter:GetCouldeUseActiveFetterSkill()
    selectChipWindow:SetActiveCampFetter(campId, heroNum, couldUse, cdStr)
  end
  
  RefreshCouldUse()
  selectChipWindow:SetClickActiveCampFetter(function()
    if self.activeDynCampFetter:GetCouldeUseActiveFetterSkill() then
      self:ConfirmBeforeUseActive(self.activeDynCampFetter:GetActiveFetterDes(), function()
        self:UseActiveFetterSkill(uid, function()
          selectChipWindow:RefreshChipList(self.epCtrl:GetCurrentRoomData():GetRewardChipList(), true)
          RefreshCouldUse()
        end)
      end)
    else
      RefreshCouldUse()
    end
  end)
end

function ExplorationCampFetterCtrl:OnEpBattleDeploy()
  if not self.couldUpdateDic[ExplorationEnum.eCampFetterUsableConditon.epBattleDeploy] then
    return
  end
  local battleWin = UIManager:GetWindow(UIWindowTypeID.Battle)
  if battleWin == nil then
    return
  end
  local couldShow = self:CouldShowActiveFetterSkill(ExplorationEnum.eCampFetterUsableConditon.epBattleDeploy)
  battleWin:SetHasBattleActiveCampFetter(couldShow)
  if not couldShow then
    return
  end
  local uid, campId, heroNum = self.activeDynCampFetter:GetActiveFetterUID()
  
  local function RefreshCouldUse()
    local CDType = self.activeDynCampFetter:GetActiceFetterCDType()
    local cdStr = CDType2TipDic[CDType](self.activeDynCampFetter)
    local couldUse = self.activeDynCampFetter:GetCouldeUseActiveFetterSkill()
    battleWin:SetCampFetter(campId, heroNum, couldUse, cdStr)
  end
  
  RefreshCouldUse()
  battleWin:SetClickCampFetter(function()
    if self.activeDynCampFetter:GetCouldeUseActiveFetterSkill() then
      self:ConfirmBeforeUseActive(self.activeDynCampFetter:GetActiveFetterDes(), function()
        self:UseActiveFetterSkill(uid, function()
          RefreshCouldUse()
        end)
      end)
    else
      RefreshCouldUse()
    end
  end)
end

function ExplorationCampFetterCtrl:OnEpCouldeSelectNextRoom(isExitThisConditon)
  if not self.couldUpdateDic[ExplorationEnum.eCampFetterUsableConditon.epCouldSelectNextRoom] then
    return
  end
  local stateInfoWin = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if stateInfoWin == nil then
    return
  end
  local epCampFetterNode = stateInfoWin:GetEpCampFetterNode()
  local couldShow = self:CouldShowActiveFetterSkill(ExplorationEnum.eCampFetterUsableConditon.epCouldSelectNextRoom) and not isExitThisConditon
  epCampFetterNode:SetHasEpActiveCampFetter(couldShow)
  if not couldShow then
    return
  end
  local uid, campId, heroNum = self.activeDynCampFetter:GetActiveFetterUID()
  
  local function Refresh(cdStr)
    local CDType = self.activeDynCampFetter:GetActiceFetterCDType()
    local cdStr = CDType2TipDic[CDType](self.activeDynCampFetter)
    local couldUse = self.activeDynCampFetter:GetCouldeUseActiveFetterSkill()
    epCampFetterNode:SetActiveCampFetter(campId, heroNum, couldUse, cdStr)
  end
  
  Refresh()
  epCampFetterNode:SetClickActiveCampFetter(function()
    if self.activeDynCampFetter:GetCouldeUseActiveFetterSkill() then
      self:ConfirmBeforeUseActive(self.activeDynCampFetter:GetActiveFetterDes(), function()
        self:UseActiveFetterSkill(uid, function()
          Refresh()
        end)
      end)
    else
      Refresh()
    end
  end)
end

function ExplorationCampFetterCtrl:OnBuffChange(buffList)
  self:OnOpenStore()
end

function ExplorationCampFetterCtrl:OnOpenStore()
  self:__ChangeStoreLeonMoneyState()
end

function ExplorationCampFetterCtrl:__ChangeStoreLeonMoneyState()
  local stateInfoWin = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if stateInfoWin == nil then
    return
  end
  local bool, logic_num, logic_per = self.dynPlayer:IsHaveSpecificTypeBuff(ExplorationEnum.eBuffLogicId.couldLeonMoney)
  local storeWin = UIManager:GetWindow(UIWindowTypeID.EpStoreRoom)
  bool = bool and storeWin ~= nil
  if bool then
    if logic_num ~= nil then
      local couldLeonMoney = logic_num[1]
      self:SetCouldLeonMoney(couldLeonMoney)
      stateInfoWin:SetLoanMoneyActive(bool, couldLeonMoney)
      storeWin:RefreshSelectItemDetail()
    end
  else
    self:SetCouldLeonMoney(0)
    stateInfoWin:SetLoanMoneyActive(false)
  end
end

function ExplorationCampFetterCtrl:SetCouldLeonMoney(value)
  self.couldLeonMoney = value or 0
end

function ExplorationCampFetterCtrl:GetCouldLeonMoney()
  return self.couldLeonMoney or 0
end

function ExplorationCampFetterCtrl:ConfirmBeforeUseActive(msg, yesFunc, noFunc)
  local window = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
  window:ShowTextBoxWithYesAndNo(msg, yesFunc, noFunc)
end

function ExplorationCampFetterCtrl:SetAllActiveFetterVisible(bool)
  self.couldShowAciveFetter = bool
  self:OnEpBack2Ep()
  self:OnEpSelectChip()
  self:OnEpBattleDeploy()
  self:OnEpCouldeSelectNextRoom()
  self:OnOpenStore()
end

function ExplorationCampFetterCtrl:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.OnEpOpStateChanged, self.__onEpOpStateChanged)
  MsgCenter:RemoveListener(eMsgEventId.OnEpBuffListChange, self.__onBuffChange)
end

return ExplorationCampFetterCtrl
