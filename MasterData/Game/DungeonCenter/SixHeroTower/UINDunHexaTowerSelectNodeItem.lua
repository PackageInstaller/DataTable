local UINDunHexaTowerSelectNodeItem = class("UINDunHexaTowerSelectNodeItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local UINDunHexaTowerSelectNodeBuffItem = require("Game.DungeonCenter.SixHeroTower.UINDunHexaTowerSelectNodeBuffItem")

function UINDunHexaTowerSelectNodeItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_State, self, self.OnClick)
  self.rewardPool = UIItemPool.New(UINBaseItemWithCount, self.ui.uINBaseItem, false)
  self.bufferPool = UIItemPool.New(UINDunHexaTowerSelectNodeBuffItem, self.ui.BuffItem, false)
end

function UINDunHexaTowerSelectNodeItem:InitHexaLevelItem(towerCfg, isPeriodic, dunSixHeroCtrl, curTowerId, onSelectTower)
  self.towerCfg = towerCfg
  self.dunSixHeroCtrl = dunSixHeroCtrl
  self.curTowerId = curTowerId
  self.onSelectTower = onSelectTower
  self.ui.Img_PeriodMask:SetActive(isPeriodic)
  self.ui.obj_PeriodTime:SetActive(isPeriodic)
  if isPeriodic then
    self.ui.Tex_PeroidicTime.text = TimeUtil:TimestampToDateString(towerCfg.end_time, false, true, ConfigData:GetTipContent(6052))
    self:__RefreshReddot()
  else
    self.ui.redDot_Twin:SetActive(false)
    self.ui.blueDot_Twin:SetActive(false)
  end
  self.ui.tex_TowerName.text = LanguageUtil.GetLocaleText(self.towerCfg.tower_name)
  self.ui.tex_Details.text = LanguageUtil.GetLocaleText(self.towerCfg.tower_des)
  local cn, tn = self.dunSixHeroCtrl:GetProgressByTowerId(towerCfg.id)
  self.ui.tex_Progress:SetIndex(0, tostring(cn), tostring(tn))
  self.ui.sl_Progress.value = cn / tn
  local isCurrentTower = curTowerId == towerCfg.id
  self.ui.btn_State.gameObject:SetActive(not isCurrentTower)
  self.ui.obj_challenge:SetActive(isCurrentTower)
  if curTowerId == nil then
    self.ui.tex_State:SetIndex(1)
  else
    self.ui.tex_State:SetIndex(0)
  end
  local allComplete = tn <= cn
  self.ui.obj_received:SetActive(allComplete)
  self.ui.obj_reward:SetActive(not allComplete)
  if not allComplete then
    self.rewardPool:HideAll()
    for _, itemId in pairs(self.towerCfg.show_rewards_list) do
      local itmeCfg = ConfigData.item[itemId]
      local item = self.rewardPool:GetOne()
      item:InitItemWithCount(itmeCfg)
    end
  end
  local dunBuffIdList = self.towerCfg.show_protocol_list
  self.bufferPool:HideAll()
  for index, buffId in ipairs(dunBuffIdList) do
    local dunBuffCfg = ConfigData.dungeon_buff[buffId]
    if dunBuffCfg == nil then
      error("不存在的dungeon buff Id:" .. tostring(buffId))
    else
      local buffItem = self.bufferPool:GetOne(true)
      buffItem:InitHeaxTowerBuffItem(dunBuffCfg)
    end
  end
end

function UINDunHexaTowerSelectNodeItem:__RefreshReddot()
  local towerId = self.towerCfg.id
  local _, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.SectorEntrance, RedDotStaticTypeId.SectorEntranceChallenge, RedDotStaticTypeId.DungeonSixTower, RedDotStaticTypeId.DunSixTowerTimeLimit)
  local rewardNode = node:GetChild(towerId)
  if rewardNode ~= nil then
    local hasRedot = rewardNode:GetRedDotCount() > 0
    self.ui.redDot_Twin:SetActive(hasRedot)
  else
    self.ui.redDot_Twin:SetActive(false)
  end
  local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local isRade = userDataCache:GetTwinTowerNewReaded(towerId)
  self.ui.blueDot_Twin:SetActive(not isRade)
end

function UINDunHexaTowerSelectNodeItem:OnClick()
  if self.onSelectTower ~= nil then
    self.onSelectTower(self.towerCfg.id)
  end
end

return UINDunHexaTowerSelectNodeItem
