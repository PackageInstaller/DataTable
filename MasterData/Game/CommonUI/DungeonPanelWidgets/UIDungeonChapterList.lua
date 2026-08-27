local UIDungeonChapterList = class("UIDungeonChapterList", UIBaseNode)
local base = UIBaseNode
local eDungeonStageState = require("Game.Dungeon.DungeonStageData").eDungeonStageState
local eDungeonEnum = require("Game.Dungeon.eDungeonEnum")
local UINStOUnlockConditionItem = require("Game.StrategyOverview.UI.Side.UINStOUnlockConditionItem")
local cs_MessageCommon = CS.MessageCommon
local JumpManager = require("Game.Jump.JumpManager")

function UIDungeonChapterList:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Battle, self, self.__onBattleStart)
  UIUtil.AddButtonListener(self.ui.btn_AutoBattle, self, self.__onAutoBattleSet)
  self.__RefreshAutoBattleBtnState = BindCallback(self, self.RefreshAutoBattleBtnState)
  MsgCenter:AddListener(eMsgEventId.StaminaUpdate, self.__RefreshAutoBattleBtnState)
  MsgCenter:AddListener(eMsgEventId.OnBattleDungeonLimitChange, self.__RefreshAutoBattleBtnState)
  self.ui.obj_conditItem:SetActive(false)
  self.conditionItemPool = UIItemPool.New(UINStOUnlockConditionItem, self.ui.obj_conditItem)
  if self.ui.obj_ChallengeNode ~= nil then
    local UINDgChallengeTaskNode = require("Game.CommonUI.ChallengeTaskNode.UINDgChallengeTaskNode")
    self._dgChallengeNode = UINDgChallengeTaskNode.New()
    self._dgChallengeNode:Init(self.ui.obj_ChallengeNode)
  end
  self.isShowDetailRect = false
end

function UIDungeonChapterList:CreatePool(chapterItemClass, fstRewardItemClass, mbDropItemClass)
  local itemPool, fstRewardPool, mbDropPool
  if chapterItemClass ~= nil then
    itemPool = UIItemPool.New(chapterItemClass, self.ui.chapterItem)
  end
  if fstRewardItemClass ~= nil then
    fstRewardPool = UIItemPool.New(fstRewardItemClass, self.ui.firstReward)
  end
  if mbDropItemClass ~= nil then
    mbDropPool = UIItemPool.New(mbDropItemClass, self.ui.maybeReward)
  end
  return itemPool, fstRewardPool, mbDropPool
end

function UIDungeonChapterList:UpdateWithChapterList(chapterItemList, dungeonData, onStartBattleEvent)
  self.chapterItemList = chapterItemList
  self.onStartBattleEvent = onStartBattleEvent
  self.dungeonData = dungeonData
  local lastSelectStageId = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):GetLastDungeonStageId(dungeonData:GetDungeonId())
  local completeCount = dungeonData:GetDungeonStageCompletedCount()
  local totalCount = dungeonData:GetDungeonStageCount()
  self.chapterCount = totalCount
  local itemClickEvent = BindCallback(self, self.OnShowDetailRectAndSetSelectChapter)
  local updateLimitDisplayEvent = BindCallback(self, self.UpdateChapterLimitDisplay)
  if 0 < #chapterItemList then
    local availableItem
    local lastUnlockedItems = {}
    for k, v in ipairs(chapterItemList) do
      if v ~= nil then
        v.onClickAction = itemClickEvent
        v.updateLimitDisplayEvent = updateLimitDisplayEvent
        if v.state ~= eDungeonStageState.lock then
          table.insert(lastUnlockedItems, v)
          if availableItem == nil and lastSelectStageId == v.chapterId then
            availableItem = v
          end
        end
      end
    end
    if availableItem == nil and self.dungeonData.isFrageDungeon and 0 < #lastUnlockedItems then
      for _, _item in ipairs(lastUnlockedItems) do
        if _item ~= nil and _item.state ~= eDungeonStageState.noData and not _item.dungeonStageData:GetIsReach2Limit() then
          availableItem = _item
        end
      end
      if availableItem == nil then
        availableItem = lastUnlockedItems[#lastUnlockedItems]
      end
    elseif availableItem == nil then
      if 0 < #lastUnlockedItems then
        availableItem = lastUnlockedItems[#lastUnlockedItems]
      else
        availableItem = chapterItemList[1]
      end
    end
    if availableItem ~= nil then
      availableItem:__onClick()
    end
  end
  self:UpdateChapterProgress(completeCount, totalCount)
end

function UIDungeonChapterList:RefreshAutoBattleBtnState()
  if self.dungeonData == nil or self.dungeonData.dungeonTypeData == nil or self.selectChapterItem == nil then
    self.ui.btn_AutoBattle.gameObject:SetActive(false)
    return
  end
  local hasAutoBattle = false
  if self.dungeonData:IsFrageDungeon() then
    hasAutoBattle = self.selectChapterItem.state ~= eDungeonStageState.lock
  else
    local dungeonType = self.dungeonData.dungeonTypeData:GetDungeonType()
    local materialCfg = ConfigData.material_dungeon[self.dungeonData.dungeonId]
    hasAutoBattle = materialCfg ~= nil and materialCfg.auto and self.selectChapterItem.state ~= eDungeonStageState.lock
  end
  self.ui.btn_AutoBattle.gameObject:SetActive(hasAutoBattle)
  if hasAutoBattle then
    local locked = not PlayerDataCenter:IsDungeonCompletedWithoutSupport(self.selectChapterItem.chapterId)
    self.ui.img_Locked:SetActive(locked)
    if self.selectChapterItem.dungeonStageData:GetIsReach2Limit() then
      self.ui.img_Mask:SetActive(true)
    else
      local sKeyEmpty = PlayerDataCenter:GetItemCount(ConstGlobalItem.SKey) < self.selectChapterItem.costStrengthNum
      local flag, limitTimes = self.dungeonData:GetDungeonAutoBattleMaxLimit()
      self.ui.img_Mask:SetActive(locked or sKeyEmpty or flag and limitTimes == 0)
    end
  end
end

function UIDungeonChapterList:UpdateChapterLimitDisplay(matDungeonItem)
  self.ui.tex_LimitCount:SetIndex(0, tostring(matDungeonItem.usedLimit), tostring(matDungeonItem.dailyLimit))
end

function UIDungeonChapterList:UpdateChapterProgress(completeCount, totalCount)
  self.ui.img_Bar.fillAmount = (completeCount - 1) / (totalCount - 1)
end

function UIDungeonChapterList:OnShowDetailRectAndSetSelectChapter(show, chapterItem)
  self._autoBattleCount = 0
  self.conditionItemPool:HideAll()
  if chapterItem ~= nil then
    self.selectChapterItem = chapterItem
    self.ui.tex_Point:SetIndex(0, tostring(chapterItem.costStrengthNum))
    if chapterItem.state == eDungeonStageState.lock then
      self.ui.btn_Battle.gameObject:SetActive(false)
      self.ui.obj_conditNode:SetActive(true)
      if not IsNull(self.ui.obj_ATHDecompose) then
        self.ui.obj_ATHDecompose:SetActive(false)
      end
      self:__GetLockItem(chapterItem.lockDatas)
      cs_MessageCommon.ShowMessageTipsWithErrorSound(chapterItem.lockReason)
    else
      self.ui.btn_Battle.gameObject:SetActive(true)
      self.ui.obj_conditNode:SetActive(false)
      if not IsNull(self.ui.obj_ATHDecompose) then
        self.ui.obj_ATHDecompose:SetActive(true)
      end
    end
    self.ui.img_chapterSelect.transform:SetParent(chapterItem.transform, false)
    self.ui.img_chapterSelect:SetActive(true)
    self:RefreshAutoBattleBtnState()
    self:_InitChallengeTask()
  end
  if self.isShowDetailRect == show then
    return chapterItem ~= nil
  end
  if show then
    self.isShowDetailRect = true
    self.ui.levelDetailTween:DOPlayForward()
  end
  return show
end

function UIDungeonChapterList:_InitChallengeTask()
  if self._dgChallengeNode == nil then
    return
  end
  local dungeonId = self.selectChapterItem.chapterId
  local isLock = self.selectChapterItem.state == eDungeonStageState.lock
  self._OnChallengeInfoShowFunc = self._OnChallengeInfoShowFunc or BindCallback(self, self._OnChallengeInfoShow)
  self._dgChallengeNode:SetDgClgInfoShowFunc(self._OnChallengeInfoShowFunc)
  self._dgChallengeNode:InitChallengeTaskNode(dungeonId, isLock)
  if self._UpdClgRedDotFunc == nil then
    function self._UpdClgRedDotFunc(node)
      local dgStageData = self.selectChapterItem:GetDungeonStageItemData()
      
      local dungeonType = dgStageData.dungeonData.dungeonTypeData.dungeonType
      local dungeonId = dgStageData.dungeonData.dungeonId
      local dungeonStageId = dgStageData:GetDungeonStageId()
      local ok, dotNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.SectorEntrance, RedDotStaticTypeId.SectorEntranceSrcDun, dungeonType, dungeonId, dungeonStageId, RedDotStaticTypeId.SctDgChallengeTask)
      self._dgChallengeNode:ShowDgChallengeTaskBlueDot(ok and dotNode:GetBlueDotCount() > 0)
    end
    
    RedDotController:AddListener(RedDotDynPath.SctDgStageCfgPath, self._UpdClgRedDotFunc)
  end
  self._UpdClgRedDotFunc()
end

function UIDungeonChapterList:_OnChallengeInfoShow()
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local dungeonId = self.selectChapterItem.chapterId
  saveUserData:SetDgChallengeRead(dungeonId, true)
  local dgStageData = self.selectChapterItem:GetDungeonStageItemData()
  dgStageData:UpdSgStageRedDot()
end

function UIDungeonChapterList:__GetLockItem(lockDatas)
  for k, condition in ipairs(lockDatas) do
    if 3 <= k then
      error("UIDungeonChapterList 不支持3条 需要改UI")
      break
    end
    local conditionItem = self.conditionItemPool:GetOne()
    conditionItem:InitStOUnlockConditionItem(condition.unlock, condition.lockReason)
  end
end

function UIDungeonChapterList:__onBattleStart()
  local stgChallengeData = self._dgChallengeNode and self._dgChallengeNode:GetDgChallengeNodeData()
  if self.onStartBattleEvent ~= nil then
    self.onStartBattleEvent(nil, stgChallengeData)
  end
end

function UIDungeonChapterList:__onAutoBattleSet()
  if not PlayerDataCenter:IsDungeonCompletedWithoutSupport(self.selectChapterItem.chapterId) then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(8101))
    return
  end
  if self.selectChapterItem.dungeonStageData:GetIsReach2Limit() then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.BattleDungeon_DailyLimit))
    return
  end
  if self.dungeonData:GetDungeonPlayLeftLimitNum() == 0 then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.BattleDungeon_DailyLimit))
    return
  end
  if PlayerDataCenter:GetItemCount(ConstGlobalItem.SKey) < self.selectChapterItem.costStrengthNum then
    JumpManager:Jump(JumpManager.eJumpTarget.BuyStamina)
    return
  end
  UIManager:CreateWindowAsync(UIWindowTypeID.BattleAutoMode, function(window)
    if window == nil then
      return
    end
    self._quickBattleFunc = self._quickBattleFunc or BindCallback(self, self._TryQuickBattle)
    window:InitDungeonAutoSet(self.selectChapterItem.dungeonStageData, function(autoCount)
      local stgChallengeData = self._dgChallengeNode and self._dgChallengeNode:GetDgChallengeNodeData()
      if self.onStartBattleEvent ~= nil then
        self.onStartBattleEvent(autoCount, stgChallengeData)
      end
    end, self._quickBattleFunc)
  end)
end

function UIDungeonChapterList:_TryQuickBattle(autoCount, activateDrop, autoDecoAth)
  local dungeonStageData = self.selectChapterItem.dungeonStageData
  local allAthNum = #PlayerDataCenter.allAthData:GetAllAthList()
  if dungeonStageData:IsHaveATHReward() and allAthNum >= ConfigData.game_config.athMaxNum then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Ath_MaxCount))
    return
  end
  
  local function reqQuickFunc()
    self:_ReqQuickBattle(autoCount, activateDrop, autoDecoAth)
  end
  
  if dungeonStageData:IsHaveATHReward() and allAthNum >= ConfigData.game_config.athMaxNum - autoCount * ConfigData.game_config.athNumWarningQuickBattle then
    cs_MessageCommon.ShowMessageBox(ConfigData:GetTipContent(145), reqQuickFunc, nil)
  else
    reqQuickFunc()
  end
end

function UIDungeonChapterList:_ReqQuickBattle(autoCount, activateDrop, autoDecoAth)
  UIManager:DeleteWindow(UIWindowTypeID.BattleAutoMode)
  local dungeonId = self.selectChapterItem.chapterId
  NetworkManager:GetNetwork(NetworkTypeID.BattleDungeon):CS_Dungeon_Quick(dungeonId, autoCount, function(objList)
    if objList.Count ~= 1 then
      error("objList.Count error:" .. tostring(objList.Count))
      return
    end
    local msg = objList[0]
    local rewardDic = table.GetDefaulValueTable(0)
    local athDic = {}
    if msg.syncUpdateDiff ~= nil and msg.syncUpdateDiff.ath ~= nil then
      for key, sthEle in pairs(msg.syncUpdateDiff.ath.updateAth) do
        local athData = PlayerDataCenter.allAthData.athDic[sthEle.uid]
        if athData then
          athDic[sthEle.uid] = athData
        end
      end
    end
    for id, num in pairs(msg.rewards) do
      local itemCfg = ConfigData.item[id]
      if itemCfg == nil then
        error("can't read itemCfg with id=" .. id)
      elseif not ConfigData:IsRewardNotShowATH(itemCfg) then
        rewardDic[id] = rewardDic[id] + num
      end
    end
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonQuickBattle, function(win)
      if win == nil then
        return
      end
      win:InitCmQuickBattle(rewardDic, athDic, msg.DZDK)
    end)
  end, activateDrop, autoDecoAth)
end

function UIDungeonChapterList:OnShow()
  if self._dgChallengeNode then
    self._dgChallengeNode:UpdDgChallengeTask()
  end
end

function UIDungeonChapterList:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.StaminaUpdate, self.__RefreshAutoBattleBtnState)
  MsgCenter:RemoveListener(eMsgEventId.OnBattleDungeonLimitChange, self.__RefreshAutoBattleBtnState)
  if self._UpdClgRedDotFunc then
    RedDotController:RemoveListener(RedDotDynPath.SctDgStageCfgPath, self._UpdClgRedDotFunc)
    self._UpdClgRedDotFunc = nil
  end
  self.conditionItemPool:DeleteAll()
  base.OnDelete(self)
end

return UIDungeonChapterList
