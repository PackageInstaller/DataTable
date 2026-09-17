local this = class("pagePetDuelStatistics", G_UIPageBase)

function this.bind()
  return {
    active_playerTitle = true,
    active_enemyTitle = true,
    active_noneInfo = false,
    statisticsList = {
      moduleName = "pages/petDuel/cellPetStatistics"
    }
  }
end

function this.methods()
  return {
    onClick_closeBtn = function(self)
      L_UI:close(self.pageName)
    end,
    onClick_bg = function(self)
      L_UI:close(self.pageName)
    end
  }
end

function this:preOpen(options)
  self:initPage()
end

function this:initPage()
  local statisticsData = C_KiboDuelSystemMgr:GetPetStatistics(C_ERecordValueType.None, 9999999)
  if statisticsData.enemyData.Count == 0 and statisticsData.playerData.Count == 0 then
    self.bind.active_playerTitle = false
    self.bind.active_enemyTitle = false
    self.bind.active_noneInfo = true
    self.bind.statisticsList:clear()
    return
  end
  local playerMaxDamge, playerMaxDamgeTaken, playerMaxHealing = self:getMaxValues(statisticsData.playerData)
  local enemyMaxDamge, enemyMaxDamgeTaken, enemyMaxHealing = self:getMaxValues(statisticsData.enemyData)
  local maxDamge = playerMaxDamge + enemyMaxDamge
  local maxDamgeTaken = playerMaxDamgeTaken + enemyMaxDamgeTaken
  local maxHealing = playerMaxHealing + enemyMaxHealing
  local length = statisticsData.playerData.Count
  if length < statisticsData.enemyData.Count then
    length = statisticsData.enemyData.Count
  end
  local data = {}
  for i = 1, length do
    local item = {}
    if i <= statisticsData.playerData.Count then
      item.playerData = statisticsData.playerData[i - 1]
    end
    if i <= statisticsData.enemyData.Count then
      item.enemyData = statisticsData.enemyData[i - 1]
    end
    table.insert(data, item)
    if data[i].playerData ~= nil then
      data[i].playerData.maxDamge = maxDamge
      data[i].playerData.maxDamgeTaken = maxDamgeTaken
      data[i].playerData.maxHealing = maxHealing
    end
    if data[i].enemyData ~= nil then
      data[i].enemyData.maxDamge = maxDamge
      data[i].enemyData.maxDamgeTaken = maxDamgeTaken
      data[i].enemyData.maxHealing = maxHealing
    end
  end
  self.bind.statisticsList:clear()
  self.bind.statisticsList:insert_array(data)
end

function this:getMaxValues(data)
  local maxDamge, maxDamgeTaken, maxHealing = C_KiboDuelSystemMgr:GetMaxValues(data)
  return maxDamge, maxDamgeTaken, maxHealing
end

return this
