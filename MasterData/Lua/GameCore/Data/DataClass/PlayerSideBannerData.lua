local PlayerSideBannerData = class("PlayerSideBannerData")
local ModuleManager = require("GameCore.Module.ModuleManager")

function PlayerSideBannerData:Init()
  self.tbDictionaryEntry = {}
  self.tbAchievement = {}
  self.tbFavour = {}
  self.tbItem = {}
  EventManager.Add("DispatchMsgDone", self, self.OnEvent_TryOpenSideBanner)
end

function PlayerSideBannerData:UnInit()
  EventManager.Remove("DispatchMsgDone", self, self.OnEvent_TryOpenSideBanner)
end

function PlayerSideBannerData:OnEvent_TryOpenSideBanner()
  self:TryOpenSideBanner(true)
end

function PlayerSideBannerData:TryOpenSideBanner(bLimit)
  if bLimit and (ModuleManager.GetIsAdventure() or PanelManager.GetCurPanelId() == PanelId.Login or PanelManager.GetCurPanelId() == PanelId.GachaSpin or PanelManager.CheckPanelOpen(PanelId.DatingLandmark) or PanelManager.CheckPanelOpen(PanelId.Dating)) then
    return
  end
  local mapData = {}
  if next(self.tbAchievement) ~= nil then
    local nAchievementCount = #self.tbAchievement
    if nAchievementCount == 1 then
      table.insert(mapData, {
        nType = AllEnum.SideBaner.Achievement,
        nId = self.tbAchievement[1]
      })
    else
      local function comp(a, b)
        local aRarity = ConfigTable.GetData("Achievement", a).Rarity
        
        local bRarity = ConfigTable.GetData("Achievement", b).Rarity
        if aRarity ~= bRarity then
          return aRarity < bRarity
        elseif a ~= b then
          return a < b
        end
      end
      
      table.sort(self.tbAchievement, comp)
      table.insert(mapData, {
        nType = AllEnum.SideBaner.Achievement,
        nId = self.tbAchievement[1],
        nOtherCount = nAchievementCount - 1
      })
    end
  end
  if next(self.tbDictionaryEntry) ~= nil then
    local nEntryCount = #self.tbDictionaryEntry
    if nEntryCount == 1 then
      table.insert(mapData, {
        nType = AllEnum.SideBaner.DictionaryEntry,
        nId = self.tbDictionaryEntry[1]
      })
    else
      table.insert(mapData, {
        nType = AllEnum.SideBaner.DictionaryEntry,
        nId = self.tbDictionaryEntry[1],
        nOtherCount = nEntryCount - 1
      })
    end
  end
  if next(self.tbFavour) ~= nil then
    local tbChar = {}
    local nFavourCount = 0
    for _, v in ipairs(self.tbFavour) do
      if tbChar[v] == nil then
        tbChar[v] = 1
        nFavourCount = nFavourCount + 1
      end
    end
    if nFavourCount == 1 then
      table.insert(mapData, {
        nType = AllEnum.SideBaner.Favour,
        nId = self.tbFavour[1]
      })
    else
      table.insert(mapData, {
        nType = AllEnum.SideBaner.Favour,
        nId = self.tbFavour[1],
        nOtherCount = nFavourCount - 1
      })
    end
  end
  if next(self.tbItem) ~= nil then
    for _, v in ipairs(self.tbItem) do
      table.insert(mapData, {
        nType = AllEnum.SideBaner.Item,
        mapReward = {
          id = v.nId,
          count = v.nCount
        }
      })
    end
  end
  if next(mapData) == nil then
    return
  end
  self.tbDictionaryEntry = {}
  self.tbAchievement = {}
  self.tbFavour = {}
  self.tbItem = {}
  EventManager.Hit("OpenSideBanner", mapData)
end

function PlayerSideBannerData:AddDictionaryEntry(nId)
  table.insert(self.tbDictionaryEntry, nId)
end

function PlayerSideBannerData:AddAchievement(nId)
  table.insert(self.tbAchievement, nId)
end

function PlayerSideBannerData:AddFavour(nId)
  table.insert(self.tbFavour, nId)
end

function PlayerSideBannerData:AddItem(nId, nCount)
  table.insert(self.tbItem, {nId = nId, nCount = nCount})
end

return PlayerSideBannerData
