local UINBattleDungeonAutoResult = class("UINBattleDungeonAutoResult", UIBaseNode)
local base = UIBaseNode
local UICommonRewardItem = require("Game.CommonUI.Item.UICommonRewardItem")
local ItemData = require("Game.PlayerData.Item.ItemData")
local DungeonLevelEnum = require("Game.DungeonCenter.DungeonLevelEnum")

function UINBattleDungeonAutoResult:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self.OnClickConfirm)
  self.ui.loopScrollRect.onInstantiateItem = BindCallback(self, self.__OnInstantiateItem)
  self.ui.loopScrollRect.onChangeItem = BindCallback(self, self.__OnChangeItem)
end

function UINBattleDungeonAutoResult:InitAutoResultTitle(dungeonLevelData, dungeonStageData)
  if dungeonLevelData ~= nil and dungeonLevelData:GetDungeonLevelType() == DungeonLevelEnum.DunLevelType.Tower then
    self.ui.tex_DungeonName.text.text = dungeonLevelData:GetTowerTypeName()
    return
  end
  if dungeonStageData ~= nil then
    local name
    if dungeonStageData.dungeonData:IsFrageDungeon() then
      self.ui.tex_DungeonName:SetIndex(1, dungeonStageData.dungeonData:GetDungeonName())
    else
      self.ui.tex_DungeonName:SetIndex(0, LanguageUtil.GetLocaleText(dungeonStageData:GetDungeonStageCfg().name))
    end
    return
  end
  self.ui.tex_DungeonName.text.text = ""
end

function UINBattleDungeonAutoResult:InitAutoResult(count, rewardDic, athDic, callback)
  self.callback = callback
  self.ui.tex_Times:SetIndex(0, tostring(count))
  local itemDataList = {}
  for rewardId, rewardCount in pairs(rewardDic) do
    local itemCfg = ConfigData.item[rewardId]
    if itemCfg ~= nil then
      local isAthItem = itemCfg.type == eItemType.Arithmetic or ConfigData.item.athGiftDic[rewardId] ~= nil
      if not isAthItem then
        table.insert(itemDataList, {
          id = rewardId,
          itemCfg = itemCfg,
          count = rewardCount
        })
      end
    end
  end
  for uid, _ in pairs(athDic) do
    local athData = PlayerDataCenter.allAthData.athDic[uid]
    if athData ~= nil then
      table.insert(itemDataList, {
        id = athData.id,
        count = 1,
        itemCfg = athData.itemCfg,
        isAth = true,
        athData = athData
      })
    end
  end
  ExplorationManager:RewardSort(itemDataList)
  self.itemDic = {}
  self.itemDataList = itemDataList
  self._heroIdSnapShoot = PlayerDataCenter:TakeHeroIdSnapShoot()
  self.ui.loopScrollRect.totalCount = #self.itemDataList
  self.ui.loopScrollRect:RefillCells()
end

function UINBattleDungeonAutoResult:__OnInstantiateItem(go)
  local item = UICommonRewardItem.New()
  item:Init(go)
  self.itemDic[go] = item
end

function UINBattleDungeonAutoResult:__OnChangeItem(go, index)
  local item = self.itemDic[go]
  if item == nil then
    error("UINBattleDungeonAutoResult error:Can't find item")
  end
  local data = self.itemDataList[index + 1]
  if data == nil then
    error("UINBattleDungeonAutoResult error:Can't find data")
  end
  item:InitCommonRewardItem(data.itemCfg, data.count, self._heroIdSnapShoot, function()
    UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(win)
      if win ~= nil then
        win:InitListDetail(self.itemDataList, index + 1, true)
      end
    end)
  end)
end

function UINBattleDungeonAutoResult:OnClickConfirm()
  if self.callback == nil then
    return
  end
  self.callback()
end

return UINBattleDungeonAutoResult
