local UILevelRewards = class("UILevelRewards", UIBaseNode)
local base = UIBaseNode
local UICommonItem = require("Game.CommonUI.Item.UICommonItem")
local cs_ResLoader = CS.ResLoader

function UILevelRewards.Create(gameObject)
  local node = UILevelRewards.New()
  node:Init(gameObject)
  return node
end

function UILevelRewards:OnInit()
  self.OnShowItemDetailEvent = nil
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.mask_Close, self, self.__OnClickClose)
  UIUtil.AddButtonListener(self.ui.getReward, self, self.__OnClickGetReward)
  self.ui.firstItem:SetActive(false)
  self.ui.regularItem:SetActive(false)
  self.resloader = cs_ResLoader.Create()
  self.firstRewardItems = {}
  self.firstRewardItemPool = {}
  self.regularRewardItems = {}
  self.regularRewardItemPool = {}
  self.sectorNetworkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Sector)
  self.__OnGetRewardComplete = BindCallback(self, self.OnGetRewardComplete)
  self.__OnSectorStageUpdate = BindCallback(self, self.OnSectorStageUpdate)
  MsgCenter:AddListener(eMsgEventId.PickFirstReward, self.__OnGetRewardComplete)
  MsgCenter:AddListener(eMsgEventId.SectorStateUpdate, self.__OnSectorStageUpdate)
end

function UILevelRewards:InitLevelRewards(sectorStageCfg)
  self.__sectorStageCfg = sectorStageCfg
  for _, rewardId in ipairs(sectorStageCfg.first_reward_ids) do
    local rewardNum = sectorStageCfg.first_reward_nums[rewardId]
    local itemCfg = ConfigData.item[rewardId]
    local rewardItem
    if #self.firstRewardItemPool > 0 then
      rewardItem = table.remove(self.firstRewardItemPool, 1)
    else
      local go = self.ui.firstItem:Instantiate()
      rewardItem = UICommonItem.New()
      rewardItem:Init(go)
    end
    rewardItem:Show()
    rewardItem:InitItem(itemCfg, rewardNum, self.resloader)
    rewardItem.clickEvent = BindCallback(self, self.__OnClickRewardItem)
    table.insert(self.firstRewardItems, rewardItem)
  end
  self:OnSectorStageUpdate()
  for _, itemId in ipairs(sectorStageCfg.normal_drop) do
    local itemCfg = ConfigData.item[itemId]
    local rewardItem
    if 0 < #self.regularRewardItemPool then
      rewardItem = table.remove(self.regularRewardItemPool, 1)
    else
      local go = self.ui.regularItem:Instantiate()
      rewardItem = UICommonItem.New()
      rewardItem:Init(go)
    end
    rewardItem:Show()
    rewardItem:InitItem(itemCfg, nil, self.resloader)
    rewardItem.clickEvent = BindCallback(self, self.__OnClickRewardItem)
    table.insert(self.regularRewardItems, rewardItem)
  end
end

function UILevelRewards:__OnClickRewardItem(item)
  if self.OnShowItemDetailEvent ~= nil then
    if self.__clickedItemId ~= item then
      self.__clickedItemId = item
      self.OnShowItemDetailEvent(true, item.itemCfg)
    else
      self.OnShowItemDetailEvent(false)
      self.__clickedItemId = nil
    end
  end
end

function UILevelRewards:__OnClickClose()
  self:Hide()
  if self.OnShowItemDetailEvent ~= nil then
    self.OnShowItemDetailEvent(false)
  end
end

function UILevelRewards:__OnClickGetReward()
  self._heroIdSnapShoot = PlayerDataCenter:GetHeroIdSnapShoot()
  self.sectorNetworkCtrl:Send_SECTOR_BattleFirstRewardPick(self.__sectorStageCfg.id)
end

function UILevelRewards:OnGetRewardComplete(rewards)
  if not self.active then
    return
  end
  local rewardIds = {}
  local rewardNums = {}
  for k, v in pairs(rewards) do
    local itemCfg = ConfigData.item[k]
    if itemCfg == nil then
      error("Can't find item, id = " .. tostring(k))
      break
    end
    table.insert(rewardIds, k)
    table.insert(rewardNums, v)
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
    if window == nil then
      return
    end
    local CommonRewardData = require("Game.CommonUI.CommonRewardData")
    local CRData = CommonRewardData.CreateCRDataUseList(rewardIds, rewardNums):SetCRHeroSnapshoot(self._heroIdSnapShoot)
    window:AddAndTryShowReward(CRData)
  end)
end

function UILevelRewards:OnSectorStageUpdate()
  if not self.active then
    return
  end
  local stageState = PlayerDataCenter.sectorStage:GetStageState(self.__sectorStageCfg.id)
  self.ui.tet_getReward:SetIndex(stageState)
  self.ui.getReward_image:SetIndex(stageState)
  self.ui.getReward.enabled = stageState == proto_object_DungeonStageState.DungeonStageStateCompleted
end

function UILevelRewards:OnHide()
  for k, v in ipairs(self.firstRewardItems) do
    v:Hide()
    table.insert(self.firstRewardItemPool, v)
  end
  self.firstRewardItems = {}
  for k, v in ipairs(self.regularRewardItems) do
    v:Hide()
    table.insert(self.regularRewardItemPool, v)
  end
  self.regularRewardItems = {}
end

function UILevelRewards:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.PickFirstReward, self.__OnGetRewardComplete)
  MsgCenter:RemoveListener(eMsgEventId.SectorStateUpdate, self.__OnSectorStageUpdate)
  base.OnDelete(self)
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
end

return UILevelRewards
