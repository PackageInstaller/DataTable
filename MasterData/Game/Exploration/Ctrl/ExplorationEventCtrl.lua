local ExplorationEventCtrl = class("ExplorationEventCtrl", ExplorationCtrlBase)
local eChoiceCondition = require("Game.Exploration.ExplorationEnum").eChoiceConditionType
local eChoiceDeductType = require("Game.Exploration.ExplorationEnum").eChoiceDeductType
local DynBuff = require("Game.Exploration.Data.DynBuff")
local ChipData = require("Game.PlayerData.Item.ChipData")
local cs_MessageCommon = CS.MessageCommon
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")

function ExplorationEventCtrl:ctor(epCtrl)
  self.netWork = NetworkManager:GetNetwork(NetworkTypeID.EventRoom)
  self.__onChoiceItemClick = BindCallback(self, self.OnChoiceItemClick)
  self.epCtrl = epCtrl
  self.waitRefersh = false
  self.__onEventRoomUpdate = BindCallback(self, self.__OnEventRoomUpdate)
  MsgCenter:AddListener(eMsgEventId.OnEventAndRecoveryRoomUpdate, self.__onEventRoomUpdate)
  self.onChipListUpdate = BindCallback(self, self.__onChipListUpdate)
  MsgCenter:AddListener(eMsgEventId.OnEpChipListChange, self.onChipListUpdate)
  self.onCCUpdate = BindCallback(self, self.__OnCCUpdate)
  MsgCenter:AddListener(eMsgEventId.EpMoneyChange, self.onCCUpdate)
  self.onRareUpdate = BindCallback(self, self.__OnRareMoneyUpdate)
  MsgCenter:AddListener(eMsgEventId.OnRareMoneyChanged, self.onRareUpdate)
end

function ExplorationEventCtrl:OnEventRoomOpen(roomData, isFirstOpen)
  if roomData.eventData == nil then
    error("Can't find eRoomData")
    return
  end
  self.currPosition = roomData.position
  self.eventData = roomData.eventData
  self.dynPlayer = ExplorationManager:GetDynPlayer()
  self._eventCurSelectChoiceIndex = nil
  self:IsEventChoiceAble(self.eventData.choiceDatalist)
  if #self.eventData.assistHeroes > 0 then
    self.epCtrl.epSupportCtrl:EnterSupportRoom(self.eventData.assistHeroes)
    local eventWindow = UIManager:GetWindow(UIWindowTypeID.EpEventRoom)
    if eventWindow ~= nil then
      eventWindow:CloseWindow()
    end
  elseif self.eventData.astCareer ~= nil then
    self.epCtrl.epSupportCtrl:EnterSupportRoomEx(self.eventData.astCareer.careerList)
    local eventWindow = UIManager:GetWindow(UIWindowTypeID.EpEventRoom)
    if eventWindow ~= nil then
      eventWindow:CloseWindow()
    end
  elseif self.eventData.param == nil then
    local eventWindow = UIManager:GetWindow(UIWindowTypeID.EpEventRoom)
    if eventWindow == nil then
      UIManager:ShowWindowAsync(UIWindowTypeID.EpEventRoom, function(window)
        if window == nil then
          return
        end
        window:InitEpEventRoom(self.eventData, self.__onChoiceItemClick)
        self.epCtrl.autoCtrl:OnEnterEpEventRoom(self.eventData, true)
        local actionList = ExplorationManager:GetEpGuideActionList(roomData.x, ExplorationEnum.epGuideMomentType.EnterEpEventRoom)
        if actionList ~= nil and 0 < #actionList then
          local EpGuideUtil = require("Game.Exploration.Util.EpGuideUtil")
          EpGuideUtil.ExecuteEpGuideActions(actionList)
        end
      end)
    else
      eventWindow:InitEpEventRoom(self.eventData, self.__onChoiceItemClick)
      self.epCtrl.autoCtrl:OnEnterEpEventRoom(self.eventData, false)
    end
  else
    local choicelist = self.eventData.choiceDatalist
    if choicelist[self.eventData.param.p1 + 1].catId == ExplorationEnum.eEventRoomChoiceType.Upgrade then
      local upgradeCfg = ConfigData.event_upgrade[self.eventData.param.p2]
      local refreshTime = self.eventData.param.p3
      if self.upgradeWindow == nil then
        local eventWindow = UIManager:GetWindow(UIWindowTypeID.EpEventRoom)
        if eventWindow ~= nil then
          eventWindow:CloseWindow()
        end
        UIManager:ShowWindowAsync(UIWindowTypeID.EpUpgradeRoom, function(window)
          window:InitUpgradeRoom(self, upgradeCfg, refreshTime)
          self.upgradeWindow = window
          self.epCtrl.autoCtrl:OnEnterEpEventRoomUpgrade(self.eventData, true)
        end)
      else
        self.upgradeWindow:InitUpgradeRoom(self, upgradeCfg, refreshTime)
        self.epCtrl.autoCtrl:OnEnterEpEventRoomUpgrade(self.eventData, false)
      end
    end
  end
end

function ExplorationEventCtrl:GetEpEventData()
  return self.eventData
end

function ExplorationEventCtrl:GetEpEventChoiceCfg(choiceData)
  local choiceCfg
  if choiceData.catId == ExplorationEnum.eEventRoomChoiceType.Normal then
    choiceCfg = ConfigData.event_choice[choiceData.choiceId]
    if choiceCfg == nil then
      error("Can`t find choiceCfg id:" .. tostring(choiceData.choiceId))
      return
    end
  elseif choiceData.catId == ExplorationEnum.eEventRoomChoiceType.Upgrade then
    choiceCfg = ConfigData.event_upgrade[choiceData.choiceId]
  elseif choiceData.catId == ExplorationEnum.eEventRoomChoiceType.Jump then
    choiceCfg = ConfigData.event_jump[choiceData.choiceId]
  elseif choiceData.catId == ExplorationEnum.eEventRoomChoiceType.Assist then
    choiceCfg = ConfigData.event_assist[choiceData.choiceId]
  elseif choiceData.catId == ExplorationEnum.eEventRoomChoiceType.AssistEx then
    choiceCfg = ConfigData.event_assist_ex[choiceData.choiceId]
  else
    error("Unsupported eEventRoomChoiceType, id = " .. tostring(choiceData.choiceId))
    return
  end
  return choiceCfg
end

function ExplorationEventCtrl:IsEventChoiceAble(choiceDatalist)
  self._hasUpdChip = false
  self.dynPlayData = ExplorationManager:GetDynPlayer()
  local choiceCfg
  for _, choiceData in ipairs(choiceDatalist) do
    if choiceData.catId == ExplorationEnum.eEventRoomChoiceType.Upgrade then
      do
        self._hasUpdChip = true
        local allChipMaxLevel = true
        for k, chipData in ipairs(self.dynPlayData.chipList) do
          if not chipData:IsChipFullLevel() and not chipData:IsConsumeSkillChip() then
            allChipMaxLevel = false
            break
          end
        end
        choiceData:SetIsAble(not allChipMaxLevel)
      end
    elseif choiceData.catId == ExplorationEnum.eEventRoomChoiceType.Jump or choiceData.catId == ExplorationEnum.eEventRoomChoiceType.Assist then
      choiceData:SetIsAble(true)
    else
      choiceCfg = ConfigData.event_choice[choiceData.choiceId]
      if choiceCfg == nil then
        error("Can't find choiceCfg ID:" .. choiceData.choiceId)
        break
      end
      local isAble = true
      local dataID
      local itemCount = 0
      local dataNum = 0
      if choiceCfg.condition == eChoiceCondition.NotRequired then
        isAble = true
      elseif choiceCfg.choiceDeductList == nil then
        isAble = true
      else
        for k, deductData in ipairs(choiceCfg.choiceDeductList) do
          if choiceCfg.condition == eChoiceCondition.Required then
            dataNum = deductData.dataNum
          elseif choiceCfg.condition == eChoiceCondition.NotRequiredAtLeastOne then
            dataNum = 1
          end
          dataID = deductData.dataID
          if deductData.deductType == eChoiceDeductType.Item then
            itemCount = self.dynPlayData:GetItemCount(dataID)
            if itemCount <= 0 then
              itemCount = self.dynPlayData:GetChipCount(dataID)
            end
          elseif deductData.deductType == eChoiceDeductType.Buff then
            itemCount = self.dynPlayData:GetEpBuffCount(dataID)
          end
          if dataNum > itemCount then
            isAble = false
          end
        end
      end
      choiceData:SetIsAble(isAble)
    end
  end
end

function ExplorationEventCtrl:OnChoiceItemClick(choiceCfg, index, isAble, catId)
  if not isAble then
    local msg
    if catId == ExplorationEnum.eEventRoomChoiceType.Upgrade then
      msg = ConfigData:GetTipContent(1015)
    else
      msg = ConfigData:GetTipContent(TipContent.exploration_Event_NotAchieved)
    end
    cs_MessageCommon.ShowMessageTipsWithErrorSound(msg)
    return
  end
  self.choiceCfg = choiceCfg
  self.eventCatId = catId
  self.waitRefersh = true
  if self.eventCatId == ExplorationEnum.eEventRoomChoiceType.Assist and self.choiceCfg.show_tips then
    self.__playerPowerBefore = self.epCtrl.dynPlayer:GetCacheFightPower()
  end
  self:RequestEpEventSelect(index)
end

function ExplorationEventCtrl:RequestEpEventSelect(index)
  self._eventSelectChoiceIndex = index
  self._eventCurSelectChoiceIndex = index
  self.epCtrl:RecordLastSelectChoiceCtrl(self)
  self.netWork:CS_EXPLORATION_EVENT_Select(self.currPosition, index)
end

function ExplorationEventCtrl:RegistEventSelectSuccessFunc(func)
  self.__eventSelectSuccessFunc = func
end

function ExplorationEventCtrl:CancleEventSelectSuccessFunc()
  self.__eventSelectSuccessFunc = nil
end

function ExplorationEventCtrl:OnChoiceItemSelectSuccess(msg)
  local choicelist = self.eventData.choiceDatalist
  if self._eventCurSelectChoiceIndex ~= nil then
    local tempIndex = self._eventCurSelectChoiceIndex + 1
    local choiceData = choicelist[tempIndex]
    if choiceData ~= nil then
      choiceData.isUesed = true
      local eventWindow = UIManager:GetWindow(UIWindowTypeID.EpEventRoom)
      if eventWindow ~= nil then
        local choiceItem = eventWindow:GetEventChoiceItem(tempIndex)
        if choiceItem ~= nil then
          choiceItem:RefreshIsUesed()
        end
      end
    end
  end
  
  local function completeFunc()
    if msg.result ~= nil and msg.buff ~= nil then
      local showTime = self.choiceCfg.choice_showtime or 0
      self:__ShowItemsMessageTips(msg.result, msg.algBack, showTime)
      self:__ShowBuffMessageTips(msg.buff, showTime)
    end
    if self.choiceCfg.jump then
      return
    end
    local needExit = false
    if self.choiceCfg.event_exit == 1 or msg.roleSync ~= nil then
      local eventWindow = UIManager:GetWindow(UIWindowTypeID.EpEventRoom)
      if eventWindow ~= nil then
        eventWindow:CloseWindow()
      end
      self.waitRefersh = false
      if msg.roleSync ~= nil then
        self.epCtrl.epSupportCtrl:ChangeEpHero(msg.roleSync)
      end
      needExit = true
    end
    if not self.epCtrl.autoCtrl:IsAutoModeRunning() and self.eventCatId == ExplorationEnum.eEventRoomChoiceType.Assist and self.choiceCfg.show_tips then
      local playerPowerAfter = self.epCtrl.dynPlayer:GetCacheFightPower()
      UIManager:ShowWindowAsync(UIWindowTypeID.HeroPowerUpSuccess, function(win)
        if win ~= nil then
          win:InitHeroPowerUpSuccess(self.__playerPowerBefore, playerPowerAfter)
          if needExit then
            win:SetBackClickAction(function()
              MsgCenter:Broadcast(eMsgEventId.OnExitRoomComplete, ExplorationEnum.eExitRoomCompleteType.EventRoom)
            end)
          end
        end
      end)
      return
    end
    if needExit then
      local function broadcastCompleteFunc()
        MsgCenter:Broadcast(eMsgEventId.OnExitRoomComplete, ExplorationEnum.eExitRoomCompleteType.EventRoom)
      end
      
      local buffIdList = {}
      for buffId, num in pairs(msg.collectBuff) do
        local buffCfg = ConfigData.exploration_buff[buffId]
        if buffCfg == nil then
          error("exploration buff cfg is null,id:" .. tostring(buffId))
        else
          local buffLogicCfg = ConfigData.exploration_buff_logic[buffCfg.logic]
          if buffCfg.is_listshow and buffLogicCfg.event_show then
            table.insert(buffIdList, buffId)
          end
        end
      end
      table.sort(buffIdList)
      if 0 < #buffIdList and not self.epCtrl.autoCtrl:IsAutoModeRunning() then
        local epBuffList = {}
        for k, buffId in ipairs(buffIdList) do
          local epBuff = DynBuff.CreateByEpBuffId(buffId)
          table.insert(epBuffList, epBuff)
        end
        if self.epCtrl:IsInDiscardChip() then
          self.epCtrl:SetNextDiscardChipFunc(function()
            UIManager:ShowWindowAsync(UIWindowTypeID.EpBuffDesc, function(win)
              if win == nil then
                return
              end
              win:InitGetEpBuffShow(epBuffList, broadcastCompleteFunc)
            end)
          end)
        else
          UIManager:ShowWindowAsync(UIWindowTypeID.EpBuffDesc, function(win)
            if win == nil then
              return
            end
            win:InitGetEpBuffShow(epBuffList, broadcastCompleteFunc)
          end)
        end
      else
        broadcastCompleteFunc()
      end
    end
  end
  
  if self.__eventSelectSuccessFunc ~= nil then
    self.__eventSelectSuccessFunc(self._eventSelectChoiceIndex, completeFunc)
  else
    completeFunc()
  end
end

function ExplorationEventCtrl:JumpEpEventRoomComplete()
  local eventWindow = UIManager:GetWindow(UIWindowTypeID.EpEventRoom)
  if eventWindow ~= nil then
    eventWindow:CloseWindow()
  end
  self.waitRefersh = false
  self.epCtrl.autoCtrl:OnEpExitRoomComplete(ExplorationEnum.eExitRoomCompleteType.JumpRoomComplete)
end

function ExplorationEventCtrl:__ShowItemsMessageTips(itemDic, algBack, showTime)
  self.showAniList = {}
  local cfg, name
  local tipText = ConfigData:GetTipContent(TipContent.exploration_Event_GetItem)
  for id, count in pairs(itemDic) do
    cfg = ConfigData.item[id]
    if cfg == nil then
      error("Can`t find itemCfg Data Id:" .. id)
    else
      name = LanguageUtil.GetLocaleText(cfg.name)
      cs_MessageCommon.ShowMessageTips(string.format(tipText, name, tostring(count)), true, showTime)
      if cfg.type == eItemType.GlobalChip then
        table.insert(self.showAniList, cfg.id)
      end
    end
  end
  self:__ShowGetAnimation(self.showAniList, algBack)
end

function ExplorationEventCtrl:__ShowGetAnimation(aniList, algBack)
  if #aniList <= 0 then
    return
  end
  local dungeonStateWindow = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if dungeonStateWindow == nil then
    return
  end
  local eventWindow = UIManager:GetWindow(UIWindowTypeID.EpEventRoom)
  if eventWindow == nil then
    return
  end
  local pos, scale = eventWindow:GetAniItemPosAndScale()
  for _, chipId in pairs(aniList) do
    local chipData = ChipData.NewChipForLocal(chipId)
    dungeonStateWindow:ShowGetChipAni(chipData, pos, scale, algBack[chipId] or 0)
  end
end

function ExplorationEventCtrl:__ShowBuffMessageTips(buffDic, showTime)
  local cfg, name, count
  local tipText = ConfigData:GetTipContent(TipContent.exploration_Event_GetBuff)
  for id, count in pairs(buffDic) do
    cfg = ConfigData.exploration_buff[id]
    if cfg == nil then
      error("Can`t find buffCfg Data Id:" .. id)
    else
      local buffLogicCfg = ConfigData.exploration_buff_logic[cfg.logic]
      if cfg.is_listshow and not buffLogicCfg.event_show then
        AudioManager:PlayAudioById(1127)
        name = LanguageUtil.GetLocaleText(cfg.name)
        cs_MessageCommon.ShowMessageTips(string.format(tipText, name), true, showTime)
      end
      if cfg.logic == 4 or cfg.logic == 5 then
        if cfg.logic_per[1] > 0 then
          AudioManager:PlayAudioById(1010)
        elseif cfg.logic_per[1] < 0 then
          AudioManager:PlayAudioById(1025)
        end
      end
    end
  end
end

function ExplorationEventCtrl:SendRejudge()
  self.netWork:CS_EXPLORATION_EVENT_Focus(self.currPosition)
end

function ExplorationEventCtrl:SetRejudegeOverCallback(callback)
  self.rejudegeOverCallback = callback
end

function ExplorationEventCtrl:OnRejudegeOver(judgeValue)
  print(judgeValue)
  if self.rejudegeOverCallback ~= nil then
    self.rejudegeOverCallback(judgeValue)
  end
end

function ExplorationEventCtrl:SendCollectReward(passNumDes, couldContinue)
  self.passNumDes = passNumDes
  self.couldContinue = couldContinue
  self.waitRefersh = true
  self.netWork:CS_EXPLORATION_EVENT_RandomConfirm(self.currPosition)
end

function ExplorationEventCtrl:OnCollectRewardSuccess()
  cs_MessageCommon.ShowMessageTips(self.passNumDes)
  if not self.couldContinue then
    local eventWindow = UIManager:GetWindow(UIWindowTypeID.EpEventRoom)
    if eventWindow ~= nil then
      eventWindow:CloseWindow()
    end
    self.waitRefersh = false
    MsgCenter:Broadcast(eMsgEventId.OnExitRoomComplete, ExplorationEnum.eExitRoomCompleteType.EventRoom)
  end
end

function ExplorationEventCtrl:__OnEventRoomUpdate(roomData)
  if self.waitRefersh and self.currPosition == roomData.position then
    self.waitRefersh = false
    self:OnEventRoomOpen(roomData)
  end
end

function ExplorationEventCtrl:__OnCCUpdate(itemUpdate)
  local roomData = self.epCtrl:GetCurrentRoomData()
  if roomData.eventData == nil or roomData.eventData ~= self.eventData then
    return
  end
  local isNeedUpdate = false
  for index, choiceData in ipairs(self.eventData.choiceDatalist) do
    if choiceData.catId == ConstGlobalItem.EpMoney then
      isNeedUpdate = true
    end
  end
  if not isNeedUpdate then
    return
  end
  self:IsEventChoiceAble(self.eventData.choiceDatalist)
  local eventWindow = UIManager:GetWindow(UIWindowTypeID.EpEventRoom)
  if eventWindow ~= nil then
    eventWindow:UpdEpEventRoom(self.eventData, self.__onChoiceItemClick)
  end
end

function ExplorationEventCtrl:__OnRareMoneyUpdate()
  local roomData = self.epCtrl:GetCurrentRoomData()
  if roomData.eventData == nil or roomData.eventData ~= self.eventData then
    return
  end
  local isNeedUpdate = false
  for index, choiceData in ipairs(self.eventData.choiceDatalist) do
    if choiceData.catId == ConstGlobalItem.EpMoney then
      isNeedUpdate = true
    end
  end
  if not isNeedUpdate then
    return
  end
  self:IsEventChoiceAble(self.eventData.choiceDatalist)
  local eventWindow = UIManager:GetWindow(UIWindowTypeID.EpEventRoom)
  if eventWindow ~= nil then
    eventWindow:UpdEpEventRoom(self.eventData, self.__onChoiceItemClick)
    eventWindow:OnRareMoneyChange()
  end
end

function ExplorationEventCtrl:__onChipListUpdate(chipList)
  local roomData = self.epCtrl:GetCurrentRoomData()
  if roomData.eventData == nil or roomData.eventData ~= self.eventData then
    return
  end
  if not self._hasUpdChip then
    return
  end
  self:IsEventChoiceAble(self.eventData.choiceDatalist)
  local eventWindow = UIManager:GetWindow(UIWindowTypeID.EpEventRoom)
  if eventWindow ~= nil then
    eventWindow:UpdEpEventRoom(self.eventData, self.__onChoiceItemClick)
  end
end

function ExplorationEventCtrl:SendChipUpgrade(chipItem, currencyId, callback)
  local chipData = chipItem.chipData
  local price = chipItem.upgradePrice
  if chipData == nil or currencyId == nil or price == nil then
    return
  end
  local money = self.dynPlayer:GetMoneyCount()
  if price <= money or price <= 0 then
    self:SendMsgChipUpgrade(chipData, callback)
  else
    local currencyName = LanguageUtil.GetLocaleText(ConfigData.item[currencyId].name)
    cs_MessageCommon.ShowMessageTips(string.format(ConfigData:GetTipContent(TipContent.exploration_Upgrade_UpgradeItemInsufficient), currencyName))
  end
end

function ExplorationEventCtrl:SendMsgChipUpgrade(chipData, callback)
  self.waitRefersh = true
  self.netWork:CS_EXPLORATION_EVENT_AlgUpgrade(self.currPosition, chipData.dataId, function()
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(TipContent.exploration_Upgrade_UpgradeItemSuccess))
    if callback ~= nil then
      callback()
    end
  end)
end

function ExplorationEventCtrl:SendMsgShopRefresh(chipData, callback)
  local opDetail = self.dynPlayer:GetOperatorDetail()
  local position = opDetail.curPostion
  self.waitRefersh = true
  self.netWork:CS_EXPLORATION_EVENT_ReFresh(position, callback)
end

function ExplorationEventCtrl:SendExit()
  self.netWork:CS_EXPLORATION_EVENT_Exit(self.currPosition, function()
    if self.upgradeWindow ~= nil then
      self.upgradeWindow:Delete()
      self.upgradeWindow = nil
    end
    local eventWindow = UIManager:GetWindow(UIWindowTypeID.EpEventRoom)
    if eventWindow ~= nil then
      eventWindow:CloseWindow()
    end
    MsgCenter:Broadcast(eMsgEventId.OnExitRoomComplete, ExplorationEnum.eExitRoomCompleteType.EventRoom)
  end)
end

function ExplorationEventCtrl:SendSpecifyExit()
  self.netWork:CS_EXPLORATION_EVENT_SpecifyExit(self.currPosition, function()
    if self.upgradeWindow ~= nil then
      self.upgradeWindow:Delete()
      self.upgradeWindow = nil
    end
    MsgCenter:Broadcast(eMsgEventId.OnExitRoomComplete, ExplorationEnum.eExitRoomCompleteType.EventRoom)
  end)
end

function ExplorationEventCtrl:ReqChipUpgradeReturn()
  self.waitRefersh = true
  self._OnChipUpgradeReturnFunc = self._OnChipUpgradeReturnFunc or BindCallback(self, self._OnChipUpgradeReturn)
  self.netWork:CS_EXPLORATION_EVENT_AlgUpgradeBack(self.currPosition, self._OnChipUpgradeReturnFunc)
end

function ExplorationEventCtrl:_OnChipUpgradeReturn()
  if self.upgradeWindow ~= nil then
    self.upgradeWindow:Delete()
    self.upgradeWindow = nil
  end
end

function ExplorationEventCtrl:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.OnEventAndRecoveryRoomUpdate, self.__OnEventRoomUpdate)
  MsgCenter:RemoveListener(eMsgEventId.OnEpChipListChange, self.onChipListUpdate)
  MsgCenter:RemoveListener(eMsgEventId.EpMoneyChange, self.onCCUpdate)
  MsgCenter:RemoveListener(eMsgEventId.OnRareMoneyChanged, self.onRareUpdate)
  self.waitRefersh = false
end

return ExplorationEventCtrl
