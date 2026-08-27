local ExplorationResetRoomCtrl = class("ExplorationResetRoomCtrl", ExplorationCtrlBase)
local cs_MessageCommon = CS.MessageCommon
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")

function ExplorationResetRoomCtrl:ctor(epCtrl)
  self.netWork = NetworkManager:GetNetwork(NetworkTypeID.ResetRoom)
  self.epCtrl = epCtrl
  self.playerChipDatas = nil
  self.waitRefersh = false
  self.__onResetRoomUpdate = BindCallback(self, self.__OnResetRoomUpdate)
  MsgCenter:AddListener(eMsgEventId.OnResetRoomUpdate, self.__onResetRoomUpdate)
  self.__onChipListUpdate = BindCallback(self, self.__OnChipListUpdate)
  MsgCenter:AddListener(eMsgEventId.OnEpChipListChange, self.__onChipListUpdate)
  self.__onChipToHeroQuict = BindCallback(self, self.AddChipToHeroClose)
  self.__onChipToHeroConfirm = BindCallback(self, self.ChipToHeroConfirm)
end

function ExplorationResetRoomCtrl:OnResetRoomOpen(roomData)
  if roomData.roomRecordList == nil then
    return
  end
  self.currPosition = roomData.position
  self.dynPlayer = ExplorationManager:GetDynPlayer()
  if self.playerChipDatas == nil then
    self.playerChipDatas = self.dynPlayer:GetChipList()
  end
  self.resetRoomDataList = {}
  for id, cfg in ipairs(ConfigData.exploration_reconsitution) do
    local resetRoomData = {}
    for i, time in ipairs(cfg.times) do
      local record = roomData.roomRecordList[id]
      if record == nil then
        record = 0
      end
      if time > record or time == -1 then
        resetRoomData.costId = cfg.costId
        resetRoomData.costNum = cfg.costNums[i]
        break
      end
    end
    table.insert(self.resetRoomDataList, resetRoomData)
  end
  self.uiWindow = UIManager:ShowWindow(UIWindowTypeID.ResetRoom)
  if self.uiWindow ~= nil then
    self.uiWindow:InitResetRoom(self, self.resetRoomDataList)
    self.uiWindow:UpdateMoney(self.dynPlayer:GetMoneyCount())
  end
end

function ExplorationResetRoomCtrl:SendInfomationOperation(btnInfo, selectChipItemList)
  if btnInfo.currBtnId == ExplorationEnum.eResetRoomType.Duplicate then
    self.uiHeroWindow = UIManager:ShowWindow(UIWindowTypeID.AddChipToHero)
    if self.uiHeroWindow ~= nil then
      self.uiHeroWindow:InitAddChipToHero(self, self.dynPlayer.heroList, selectChipItemList[1].chipData, self.__onChipToHeroQuict, self.__onChipToHeroConfirm)
    end
  elseif btnInfo.currBtnId == ExplorationEnum.eResetRoomType.Mix then
    self.netWork:CS_EXPLORATION_RECONSTITUTION_Fusion(self.currPosition, selectChipItemList)
  else
    self.netWork:CS_EXPLORATION_RECONSTITUTION_Reconstitution(self.currPosition, selectChipItemList[1].chipData)
  end
  self.waitRefersh = true
end

function ExplorationResetRoomCtrl:SendDuplicateOperation(chipData, heroId)
  self.netWork:CS_EXPLORATION_RECONSTITUTION_Reproduction(self.currPosition, chipData, heroId)
end

function ExplorationResetRoomCtrl:SendResetRoomQuit()
  self.netWork:CS_EXPLORATION_RECONSTITUTION_Quit(self.currPosition)
end

function ExplorationResetRoomCtrl:OnSendMsgSuccess(algId)
  if algId ~= nil then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(TipContent.exploration_Reconstitution_AchieveChip) .. LanguageUtil.GetLocaleText(ConfigData.item[algId].name))
  else
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(TipContent.exploration_Reconstitution_ChipOperateSuccess))
  end
  if self.uiHeroWindow ~= nil then
    self.uiHeroWindow:CloseAddChipToHero()
  end
end

function ExplorationResetRoomCtrl:CloseResetRoom()
  if self.uiWindow ~= nil then
    self.uiWindow:CloseResetRoom(self, self.resetRoomDataList)
  end
  self.uiWindow = nil
  MsgCenter:Broadcast(eMsgEventId.OnExitRoomComplete, ExplorationEnum.eExitRoomCompleteType.ResetRoom)
end

function ExplorationResetRoomCtrl:AddChipToHeroClose(uiWindow)
  self.uiHeroWindow = uiWindow
  self.uiHeroWindow:CloseAddChipToHero()
  self.uiHeroWindow = nil
  if self.uiWindow ~= nil then
    self.uiWindow:InitResetRoom(self, self.resetRoomDataList)
  end
end

function ExplorationResetRoomCtrl:ChipToHeroConfirm(uiWindow)
  self.uiHeroWindow = uiWindow
  if uiWindow.currHeroItem ~= nil then
    self:SendDuplicateOperation(uiWindow.currChipData, uiWindow.currHeroItem.heroId)
  else
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(TipContent.exploration_Reconstitution_SelectOneHero))
  end
end

function ExplorationResetRoomCtrl:__OnResetRoomUpdate(roomData)
  if self.waitRefersh and self.currPosition == roomData.position then
    self:OnResetRoomOpen(roomData)
    self.waitRefersh = false
  end
end

function ExplorationResetRoomCtrl:__OnChipListUpdate(chipList)
  self.playerChipDatas = chipList
end

function ExplorationResetRoomCtrl:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.OnResetRoomUpdate, self.__onResetRoomUpdate)
  MsgCenter:RemoveListener(eMsgEventId.OnEpChipListChange, self.__onChipListUpdate)
  self.uiWindow = nil
  self.uiHeroWindow = nil
end

return ExplorationResetRoomCtrl
