local DynChipSuitMgr = class("DynChipSuitMgr")
local DynChipSuit = require("Game.Exploration.Data.ChipSuit.DynChipSuit")

function DynChipSuitMgr:ctor(dynplayer)
  self.__chipSuitDic = {}
  self.__chipSuitList = {}
  self.__dynplayer = dynplayer
end

function DynChipSuitMgr.CreateSuitWithChips(chipList)
  local tagDic = {}
  for _, chipData in pairs(chipList) do
    local tagId = chipData:GetChipFuncTag()
    if tagId ~= 0 then
      tagDic[tagId] = (tagDic[tagId] or 0) + 1
    end
  end
  local chipSuitDic = {}
  for tagId, count in pairs(tagDic) do
    local chipSuit = DynChipSuit.New(tagId, count)
    chipSuitDic[tagId] = chipSuit
  end
  return chipSuitDic
end

local function ChipSuitSortFunc(suit1, suit2)
  local c1 = suit1:GetChipSuitCount()
  local c2 = suit2:GetChipSuitCount()
  if c1 ~= c2 then
    return c1 > c2
  end
  return suit1.tagId < suit2.tagId
end

function DynChipSuitMgr:UpdateAllChipSuit(chipList)
  while #self.__chipSuitList > 0 do
    table.remove(self.__chipSuitList)
  end
  self.__chipSuitDic = DynChipSuitMgr.CreateSuitWithChips(chipList)
  for k, chipSuit in pairs(self.__chipSuitDic) do
    chipSuit:UpdateChipSuitEffector(self.__dynplayer)
    table.insert(self.__chipSuitList, chipSuit)
  end
  table.sort(self.__chipSuitList, ChipSuitSortFunc)
  MsgCenter:Broadcast(eMsgEventId.OnEpChipSuitUpdate)
end

function DynChipSuitMgr:UpdateAllChipSuitNoDynPlayer(chipList)
  while #self.__chipSuitList > 0 do
    table.remove(self.__chipSuitList)
  end
  self.__chipSuitDic = DynChipSuitMgr.CreateSuitWithChips(chipList)
  for k, chipSuit in pairs(self.__chipSuitDic) do
    table.insert(self.__chipSuitList, chipSuit)
  end
  table.sort(self.__chipSuitList, ChipSuitSortFunc)
end

function DynChipSuitMgr:UpdateChipSuitDiff(chipDel, chipAdd)
  local updateTag = {}
  for chipId, _ in pairs(chipDel) do
    local chipCfg = ConfigData.chip[chipId]
    local tagId = chipCfg.fun_tag
    if tagId ~= 0 then
      local chipSuit = self.__chipSuitDic[tagId]
      chipSuit:AddChipSuitCount(-1)
      updateTag[tagId] = true
    end
  end
  for chipId, _ in pairs(chipAdd) do
    local chipCfg = ConfigData.chip[chipId]
    local tagId = chipCfg.fun_tag
    if tagId ~= 0 then
      local chipSuit = self.__chipSuitDic[tagId]
      if chipSuit == nil then
        chipSuit = DynChipSuit.New(tagId, 1)
        self.__chipSuitDic[tagId] = chipSuit
      else
        chipSuit:AddChipSuitCount(1)
      end
      updateTag[tagId] = true
    end
  end
  for tagId, _ in pairs(updateTag) do
    local chipSuit = self.__chipSuitDic[tagId]
    if 0 < chipSuit:GetChipSuitCount() then
      chipSuit:UpdateChipSuitEffector(self.__dynplayer)
    else
      chipSuit:ClearChipSuitEffector(self.__dynplayer)
      self.__chipSuitDic[tagId] = nil
    end
  end
  while 0 < #self.__chipSuitList do
    table.remove(self.__chipSuitList)
  end
  for tagId, chipSuit in pairs(self.__chipSuitDic) do
    table.insert(self.__chipSuitList, chipSuit)
  end
  table.sort(self.__chipSuitList, ChipSuitSortFunc)
  for _, chipSuit in ipairs(self.__chipSuitList) do
    chipSuit:UpdateChipSuitTotalQty(self.__dynplayer)
  end
  MsgCenter:Broadcast(eMsgEventId.OnEpChipSuitUpdate)
end

function DynChipSuitMgr:TempAddChipSuit(chipData)
  local tagId = chipData:GetChipFuncTag()
  if tagId ~= 0 then
    local chipSuit = self.__chipSuitDic[tagId]
    if chipSuit == nil then
      chipSuit = DynChipSuit.New(tagId, 1)
      self.__chipSuitDic[tagId] = chipSuit
    else
      chipSuit:AddChipSuitCount(1)
    end
    chipSuit:UpdateChipSuitEffector(self.__dynplayer)
  end
end

function DynChipSuitMgr:TempSubChipSuit(chipData, needClear)
  local tagId = chipData:GetChipFuncTag()
  if tagId ~= 0 then
    local chipSuit = self.__chipSuitDic[tagId]
    if chipSuit == nil then
      error("try del null chip suit,tagId:" .. tostring(tagId))
      return
    end
    chipSuit:AddChipSuitCount(-1)
    if 0 < chipSuit:GetChipSuitCount() then
      chipSuit:UpdateChipSuitEffector(self.__dynplayer)
    else
      chipSuit:ClearChipSuitEffector(self.__dynplayer)
      if needClear then
        self.__chipSuitDic[tagId] = nil
      end
    end
  end
end

function DynChipSuitMgr:ExecuteAllSuitChipForList(heroList, dynplayer)
  for k, chipSuit in pairs(self.__chipSuitDic) do
    chipSuit:ExecuteSuitChipForList(heroList, dynplayer)
  end
end

function DynChipSuitMgr:GetChipSuitListData()
  return self.__chipSuitList
end

function DynChipSuitMgr:GetChipTagIdCount(tagId)
  local chipSuit = self.__chipSuitDic[tagId]
  if chipSuit ~= nil then
    return chipSuit:GetChipSuitCount(), chipSuit:GetChipSuitMaxCount()
  end
  local chipTagCfg = ConfigData.chip_tag[tagId]
  return 0, chipTagCfg.chip_max_count
end

function DynChipSuitMgr:GetChipSuitTotalQty(tagId)
  local chipSuit = self.__chipSuitDic[tagId]
  local totalQty = chipSuit ~= nil and chipSuit:GetTotalQty() or 0
  return totalQty
end

function DynChipSuitMgr:RemoveAllChipSuitTemp()
  for _, chipSuit in pairs(self.__chipSuitList) do
    chipSuit:ClearChipSuitEffector(self.__dynplayer)
  end
end

function DynChipSuitMgr:ExecuteAllSuitChipForListOutBattle(chipList, heroList, specEffectMgr)
  self.__chipSuitDic = DynChipSuitMgr.CreateSuitWithChips(chipList)
  for k, chipSuit in pairs(self.__chipSuitDic) do
    chipSuit:SetValidRoleList(heroList, specEffectMgr)
    table.insert(self.__chipSuitList, chipSuit)
  end
  table.sort(self.__chipSuitList, ChipSuitSortFunc)
  return self.__chipSuitList
end

function DynChipSuitMgr:UpdateAllSuitChipVaildRoleList(heroList, dynplayer)
  for k, chipSuit in pairs(self.__chipSuitDic) do
    chipSuit:UpdateValidRoleList(heroList, dynplayer)
  end
end

return DynChipSuitMgr
