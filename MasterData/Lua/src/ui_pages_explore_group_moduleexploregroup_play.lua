local this = class("moduleExploreGroup_play", G_UIModuleBase)
local _exploreTpl = L_GameTpl:getExploreTpl()
local _homeCollectionWorldTpl = L_GameTpl:getHomeCollectionWorldTpl()
local _worldMapTpl = L_GameTpl:getWorldMapTpl()
local _worldSpawnerTpl = L_GameTpl:getWorldSpawnerTpl()

function this.bind()
  return {
    toggle_finish = false,
    txt_nameOn = "",
    txt_nameOff = "",
    list_detail = {
      moduleName = "pages/explore/cell/cellExploreDetail"
    }
  }
end

function this.methods()
  return {}
end

function this:open()
end

function this:close()
end

function this:refresh()
end

function this:initGroupContent(data)
  local cur = 0
  local total = 0
  local dataList = {}
  for i, v in pairs(data.groupData) do
    local isFinish = false
    local curNum = 0
    local serverData = L_WorldExploreStore:getMissionInfoById(_exploreTpl:getId(v))
    if not table.isEmpty(serverData) then
      isFinish = serverData.complete
      curNum = serverData.num
    end
    local targetNum = 0
    local filterType = _exploreTpl:getFiller(v)
    local curSceneId = self.parent.parent.parent:getMapSceneId()
    local _domainTpl = L_GameTpl:getDomainTpl()
    if filterType == L_MapConst.mapExploreFilter.spawner then
      local objectTypeIds = _exploreTpl:getFillerSpawner(v)
      if not table.isEmpty(objectTypeIds) then
        for i, objectType in pairs(objectTypeIds) do
          local spawnerDatas = _worldSpawnerTpl:getAllTplByObjectType(objectType)
          for i, tpl in pairs(spawnerDatas) do
            local spawnerId = _worldSpawnerTpl:getId(tpl)
            local spawnerData = _worldMapTpl:getAllTplBySpawnerId(curSceneId, spawnerId)
            if not table.isEmpty(spawnerData) then
              targetNum = targetNum + #spawnerData
            end
          end
        end
      end
    elseif filterType == L_MapConst.mapExploreFilter.collectionBuilding then
      local sourceData = _homeCollectionWorldTpl:getAllTplByType()
      local allTargetData = sourceData[_exploreTpl:getFillerSpawner(v)[1]] or {}
      local targetData = {}
      for _, tpl in pairs(allTargetData) do
        local domainId = _homeCollectionWorldTpl:getDomainId(tpl)
        local tpl_domain = _domainTpl:getTplById(domainId)
        local sceneId = _domainTpl:getSceneId(tpl_domain)
        if sceneId == curSceneId then
          table.insert(targetData, tpl)
        end
      end
      targetNum = #targetData
    elseif filterType == L_MapConst.mapExploreFilter.singleCount then
      targetNum = _exploreTpl:getFillerCount(v)
    end
    cur = cur + curNum
    total = total + targetNum
    table.insert(dataList, {
      toggle_finish = isFinish,
      txt_detailOn = _exploreTpl:getExploreName(v),
      txt_numOn = string.format("%d/%d", curNum, targetNum),
      txt_detailOff = _exploreTpl:getExploreName(v),
      txt_numOff = string.format("%d/%d", curNum, targetNum),
      id = _exploreTpl:getId(v),
      data = v
    })
  end
  table.sort(dataList, function(a, b)
    return a.id < b.id
  end)
  self.bind.toggle_finish = cur >= total and not math.isEmpty(cur)
  local limit = cur > total and total or cur
  self.bind.txt_nameOn = string.format("%s【%d/%d】", data.name, limit, total)
  self.bind.txt_nameOff = self.bind.txt_nameOn
  self.bind.list_detail:clear()
  self.bind.list_detail:insert_array(dataList)
end

return this
