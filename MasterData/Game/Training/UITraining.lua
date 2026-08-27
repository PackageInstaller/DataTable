local UITraining = class("UITraining", UIBaseWindow)
local base = UIBaseWindow
local SlotData = require("Game.Training.Data.TrainingSlotData")
local SlotItem = require("Game.Training.UINode.UITrainingSlot")
local HeroEnterSlot = require("Game.HeroEnter.UINHeroEnterSlotItem")
local UIHeroEnterSelect = require("Game.HeroEnter.UIHeroEnterSelect")
local HeroEnterDataUtil = require("Game.HeroEnter.HeroEnterDataUtil")
local UINHeroEnterBuildingBuffInfo = require("Game.HeroEnter.UINHeroEnterBuildingBuffInfo")
local TrainEnum = require("Game.Training.TrainEnum")
local cs_MessageCommon = CS.MessageCommon
local cs_ResLoader = CS.ResLoader

function UITraining:OnInit()
  self.__trainingCfg = ConfigData.training
  local topStatus = UIManager:ShowWindow(UIWindowTypeID.TopStatus)
  topStatus:AddReturnEvent(BindCallback(self, self.__OnClickClose))
  self.__resloader = cs_ResLoader.Create()
  self.ui.slot_Item:SetActive(false)
  self:InitSlots()
  self:Update()
  self.__timerId = TimerManager:StartTimer(1, function()
    self:Update()
  end)
  self:UpdateTrainingUI()
  self.__onUpdateItem = BindCallback(self, self.OnUpdateItem)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__onUpdateItem)
  local isStaffInfoUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroEnter) and PlayerDataCenter.AllBuildingData.oasisBuilt[eBuildingId.OasisTrainingBuilding] ~= nil and PlayerDataCenter.AllBuildingData.oasisBuilt[eBuildingId.OasisTrainingBuilding].state ~= proto_object_BuildingState.BuildingStateCreate
  self:OnStaffInfoUnlock(isStaffInfoUnlock)
  self.__UpdateStaffInfo = BindCallback(self, self.UpdateStaffInfo)
  MsgCenter:AddListener(eMsgEventId.OnHeroEnterDataUpdate, self.__UpdateStaffInfo)
end

function UITraining:InitSlots()
  self.slotDatas = PlayerDataCenter.trainingSlotDatas
  self.slotItems = {}
  for k, v in ipairs(self.slotDatas) do
    local slotData = v
    local go = self.ui.slot_Item:Instantiate()
    go:SetActive(true)
    local slotItem = SlotItem.New()
    slotItem:Init(go)
    slotItem:InitTrainingSlot(slotData, self.__resloader)
    slotItem.OnSlotHeroEvent = BindCallback(self, self.__SelectSlotHero)
    slotItem.OnSettleEvent = BindCallback(self, self.__StartSettle)
    self.slotItems[k] = slotItem
  end
end

function UITraining:OnUpdateItem(itemUpdate)
  if itemUpdate[ConfigData.game_config.globalExpItemId] ~= nil then
    self:UpdateGlobalExpUI()
  end
end

function UITraining:Update()
  self.__timestamp = PlayerDataCenter.timestamp
  for k, v in ipairs(self.slotItems) do
    v:Update(self.__timestamp)
  end
end

function UITraining:UpdateTrainingUI()
  for k, v in ipairs(self.slotItems) do
    v:UpdateSlot()
  end
  self:UpdateGlobalExpUI()
end

function UITraining:UpdateGlobalExpUI()
  local globalExp = PlayerDataCenter:GetItemCount(ConfigData.game_config.globalExpItemId)
  local globalExpCeiling = PlayerDataCenter.playerBonus:GetGlobalExpCeiling()
  local progress = globalExpCeiling == 0 and 0 or globalExp / globalExpCeiling
  self.ui.tex_EXP:SetIndex(0, tostring(globalExp), tostring(globalExpCeiling))
  self.ui.tex_EpxProcess:SetIndex(0, tostring(math.floor(progress * 100)))
  self.ui.img_Process.fillAmount = progress
end

function UITraining:__SelectSlotHero(slotIndex)
  self.__selectSlotIndex = slotIndex
  local window = UIManager:ShowWindow(UIWindowTypeID.TrainingHeroList)
  window:InitHeroList(self.__resloader, self.__trainingCfg[TrainEnum.eTrainingDataType.Efficiency])
  window.OnTrainingHeroEvent = BindCallback(self, self.__SendSlotHero)
end

function UITraining:__SendSlotHero(heroId, trainingTimeCfgId, costExp)
  local heroCard = PlayerDataCenter.heroDic[heroId]
  if heroCard == nil then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Train_HeroNotExist))
    return
  end
  for k, v in ipairs(self.slotDatas) do
    if k ~= self.__selectSlotIndex and v.heroId == heroId then
      cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Train_HeroIsTraining))
      return
    end
  end
  if heroCard:IsFullLevel() then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Train_HeroLevelFull))
    return
  end
  local levelCeiling = self:__GetTrainingLevelCeiling()
  if levelCeiling <= heroCard.level then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(string.format(ConfigData:GetTipContent(TipContent.Train_HeroReachTheMaxTrainLevel), tostring(heroCard.level), tostring(levelCeiling)))
    return
  end
  if costExp > PlayerDataCenter:GetItemCount(ConfigData.game_config.globalExpItemId) then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Train_GlobleEXPNotEnough))
    return
  end
  self.networkCtrl:SendSlotHero(heroId, self.__selectSlotIndex, ConfigData.game_config.trainingTimeCfg[trainingTimeCfgId])
end

function UITraining:OnSlotHeroComplete(slotIndex)
  self.__selectSlotIndex = nil
  UIManager:DeleteWindow(UIWindowTypeID.TrainingHeroList)
  local item = self.slotItems[slotIndex]
  item:UpdateSlot()
end

function UITraining:__StartSettle(slotIndex, complete)
  local window = UIManager:ShowWindow(UIWindowTypeID.TrainingState)
  local slotData = self.slotDatas[slotIndex]
  local heroCard = PlayerDataCenter.heroDic[slotData.heroId]
  if heroCard ~= nil then
    local efficiencyCfg = self.__trainingCfg[TrainEnum.eTrainingDataType.Efficiency]
    window:InitState(slotData, heroCard, self.__timestamp, efficiencyCfg)
    window.OnSettleEvent = BindCallback(self, self.__SendSlotSettle)
  else
    error("找不到角色，id=" .. tostring(slotData.heroId))
  end
end

function UITraining:__SendSlotSettle(slotIndex, complete)
  if self.__trainingCfg[TrainEnum.eTrainingDataType.Slot][slotIndex] == nil then
    error("没有该槽位，index=" .. tostring(slotIndex))
    return
  end
  self.networkCtrl:SendTrainingSettle(slotIndex)
end

function UITraining:OnSlotSettleComplete(slotIndex)
  local item = self.slotItems[slotIndex]
  item:UpdateSlot()
end

function UITraining:__GetTrainingLevelCeiling()
  local levelCeilingCfg = self.__trainingCfg[TrainEnum.eTrainingDataType.LevelCeiling]
  for i = #levelCeilingCfg, 1, -1 do
    local cfg = levelCeilingCfg[i]
    if CheckCondition.CheckLua(cfg.pre_condition, cfg.pre_para1, cfg.pre_para2) then
      return cfg.training_para
    end
  end
  error("没有符合的训练等级上限")
end

function UITraining:__OnClickClose()
  UIManager:DeleteWindow(UIWindowTypeID.Training)
end

function UITraining:OnStaffInfoUnlock(active)
  self.ui.staffInfo:SetActive(active)
  self.HeroEnterSlotPool = UIItemPool.New(HeroEnterSlot, self.ui.HeroEnterSlot)
  self.ui.HeroEnterSlot:SetActive(false)
  self.buildingBuffPool = UIItemPool.New(UINHeroEnterBuildingBuffInfo, self.ui.Item_buffItem)
  self.ui.Item_buffItem:SetActive(false)
  self.buildingBuffList = {}
  if active then
    UIHeroEnterSelect.CreateBuffItems(self, eBuildingId.OasisTrainingBuilding)
    self:UpdateStaffInfo()
  end
end

function UITraining:UpdateStaffInfo()
  self.HeroEnterSlotPool:HideAll()
  local slotList = {}
  local buildingData = PlayerDataCenter.AllBuildingData.built[eBuildingId.OasisTrainingBuilding]
  if buildingData == nil then
    error("无建筑数据" .. eBuildingId.OasisFactory)
    return
  end
  local allEnterData = PlayerDataCenter.allEnterData
  local level = buildingData.level
  local UnlockedSlotNum = buildingData.levelConfig[level].hero_job_slot
  local heroScoreRate = 0
  for i = 1, UnlockedSlotNum do
    local enterSlot = self.HeroEnterSlotPool:GetOne(true)
    enterSlot:SetSlotClickEvent(function(isUnlock, heroId)
      if isUnlock then
        UIManager:ShowWindowAsync(UIWindowTypeID.HeroEnter, function(window)
          window:InitHeroEnterSelect(nil, eBuildingId.OasisTrainingBuilding, slotList, i)
        end)
      end
    end)
    if allEnterData[eBuildingId.OasisTrainingBuilding] ~= nil then
      local heros = table.keys(allEnterData[eBuildingId.OasisTrainingBuilding].data)
      heroScoreRate = heroScoreRate + HeroEnterDataUtil:CalRateById(heros[i])
      enterSlot:InitHeroEnterSlot(self.__resloader, true, heros[i])
      table.insert(slotList, {
        isUnlock = true,
        heroID = heros[i]
      })
    else
      enterSlot:InitHeroEnterSlot(self.__resloader, true)
      table.insert(slotList, {isUnlock = true})
    end
  end
  for _, Item in ipairs(self.buildingBuffList) do
    Item:SetValue(heroScoreRate)
  end
end

function UITraining:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__onUpdateItem)
  MsgCenter:RemoveListener(eMsgEventId.OnHeroEnterDataUpdate, self.__UpdateStaffInfo)
  self.networkCtrl:UpdateRedDotCompleteSlot()
  TimerManager:StopTimer(self.__timerId)
  self.__timerId = nil
  base.OnDelete(self)
end

return UITraining
