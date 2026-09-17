local this = class("pageWorldBuff", G_UIPageBase)
local _HomeBuffCountTpl = L_GameTpl:getHomeBuffCountTpl()
local _homeCollectionWorldTpl = L_GameTpl:getHomeCollectionWorldTpl()
local _domainTpl = L_GameTpl:getDomainTpl()
local _worldMapTpl = L_GameTpl:getWorldMapTpl()
local _homeBuildingBuffWorldTpl = L_GameTpl:getHomeBuildingBuffWorldTpl()
local _homeBuffTpl = L_GameTpl:getHomeBuffTpl()

function this.bind()
  return {
    rl_activateBuff = {
      moduleName = "pages/worldBuff/cellActivateWorldBuff"
    },
    rl_overviewBuff = {
      moduleName = "pages/worldBuff/cellOverviewWorldBuffInfo"
    }
  }
end

function this.methods()
  return {
    onClick_close = function(self)
      L_UI:close(self.pageName)
    end,
    onClick_mask = function(self)
      L_UI:close(self.pageName)
    end,
    onClick_activate = function(self)
      self:_OnEventBtnActivate()
    end,
    onClick_overview = function(self)
      self:_OnEventBtnOverview()
    end
  }
end

function this:open()
  self._isShowActivate = true
  self._isShowOverview = true
  self:OnRefreshActivateBuff()
  self:OnRefreshOverviewBuff()
end

function this:OnRefreshActivateBuff()
  if not self.isBind then
    return
  end
  if self._isShowActivate then
    local buffList = L_HomeBuffManager:getWildBuffBuildList()
    local dataList = {}
    for _, value in pairs(buffList) do
      local buffValue = value.buffValue
      local buffId = value.buffId
      local buffTpl = _homeBuffTpl:getTplById(buffId)
      local valueType = _homeBuffTpl:getType(buffTpl)
      if valueType == L_HomeConst.buffValueType.PERCENT then
        buffValue = buffValue * 100
      end
      buffValue = math.modf(buffValue)
      local buffDesc = L_Config:providerLua(value.desc, buffValue)
      local item = {buffId = buffId, buffDesc = buffDesc}
      table.insert(dataList, item)
    end
    if #dataList == 0 then
      local item = {
        buffId = 0,
        buffDesc = L_WordsTpl:getValue("residual_code_pageworldbuff_01")
      }
      table.insert(dataList, item)
    end
    self.bind.rl_activateBuff:refresh_array(dataList)
    self.bindComponents.rect_BtnActivate.rotation = C_Quaternion.Euler(C_Vector3(0, 0, 0))
  else
    self.bind.rl_activateBuff:clear()
    self.bindComponents.rect_BtnActivate.rotation = C_Quaternion.Euler(C_Vector3(0, 0, 180))
  end
end

function this:OnRefreshOverviewBuff()
  if not self.isBind then
    return
  end
  if self._isShowOverview then
    local listPoint = self:OnGetAllWildBuffBuildPoint()
    local listData = {}
    for worldCityId, valueList in pairs(listPoint) do
      local item = {
        worldCityId = worldCityId,
        collectionList = {}
      }
      table.insert(listData, item)
      for _, value in ipairs(valueList) do
        table.insert(item.collectionList, value.collectId)
      end
    end
    self.bind.rl_overviewBuff:refresh_array(listData)
    self.bindComponents.rect_BtnOverview.rotation = C_Quaternion.Euler(C_Vector3(0, 0, 0))
  else
    self.bind.rl_overviewBuff:clear()
    self.bindComponents.rect_BtnOverview.rotation = C_Quaternion.Euler(C_Vector3(0, 0, 180))
  end
end

function this:_OnEventBtnActivate()
  if self._isShowActivate == nil then
    self._isShowActivate = true
  end
  self._isShowActivate = not self._isShowActivate
  self:OnRefreshActivateBuff()
end

function this:_OnEventBtnOverview()
  if self._isShowOverview == nil then
    self._isShowOverview = true
  end
  self._isShowOverview = not self._isShowOverview
  self:OnRefreshOverviewBuff()
end

function this:OnGetAllWildBuffBuildPoint()
  local list = {}
  local allData = _homeCollectionWorldTpl.data
  for _, tpl in pairs(allData) do
    local type = _homeCollectionWorldTpl:getType(tpl)
    if type == 2 then
      local domainId = _homeCollectionWorldTpl:getDomainId(tpl)
      local tpl_domain = _domainTpl:getTplById(domainId)
      local sceneId = _domainTpl:getSceneId(tpl_domain)
      if list[sceneId] == nil then
        list[sceneId] = {}
      end
      local collectId = _homeCollectionWorldTpl:getId(tpl)
      local isHadBuild = L_HomeBuffManager:getIsHadWildBuffBuild(collectId)
      local item = {
        worldCityId = sceneId,
        collectId = collectId,
        isHadBuild = isHadBuild
      }
      table.insert(list[sceneId], item)
    end
  end
  for _, value in pairs(list) do
    table.sort(value, function(a, b)
      if a.isHadBuild and not b.isHadBuild then
        return true
      end
      return false
    end)
  end
  return list
end

return this
