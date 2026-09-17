local this = class("pageExplore", G_UIPageBase)
local _worldCityTpl = L_GameTpl:getWorldCityTpl()
local _exploreTpl = L_GameTpl:getExploreTpl()
local _exploreLevelTpl = L_GameTpl:getExploreLevelTpl()

function this.bind()
  return {
    moduleExploreSight = false,
    moduleExploreReward = false,
    moduleExploreBoss = false,
    toggle_bossExplore = false,
    txt_boss_name = "",
    txt_boss_describe = "",
    toggle_sightExplore = false,
    txt_sight_name = "",
    txt_sight_describe = "",
    list_reward = {
      moduleName = "pages/explore/cell/cellExploreReward"
    },
    focusIndexItem = 0
  }
end

function this.methods()
  return {
    onClick_close = function(self)
      L_UI:close(self.pageName)
    end
  }
end

function this:created(...)
  this.super.created(self, ...)
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self.mapExploreTypeFunc = {
    [L_MapConst.mapExploreDetailType.boss] = self.initBossPanel,
    [L_MapConst.mapExploreDetailType.sight] = self.initSightPanel,
    [L_MapConst.mapExploreDetailType.reward] = self.initRewardPanel
  }
  self.type = options.type
  self.sourceData = options.data
  self:initPage()
end

function this:close()
  this.super.close(self)
end

function this:initPage()
  if math.isEmpty(self.type) then
    return
  end
  self.bind.moduleExploreBoss = self.type == L_MapConst.mapExploreDetailType.boss
  self.bind.moduleExploreSight = self.type == L_MapConst.mapExploreDetailType.sight
  self.bind.moduleExploreReward = self.type == L_MapConst.mapExploreDetailType.reward
  self.mapExploreTypeFunc[self.type](self)
end

function this:initBossPanel()
  self.bind.toggle_bossExplore = self.sourceData.toggle_finish
  local path = _exploreTpl:getExploreTexture(self.sourceData.data)
  self.bindComponents.img_bossOn:LoadSprite(path, false)
  self.bindComponents.img_bossOff:LoadSprite(path, false)
  self.bind.txt_boss_name = _exploreTpl:getExploreName(self.sourceData.data)
  self.bind.txt_boss_describe = _exploreTpl:getIntroduceText(self.sourceData.data)
end

function this:initSightPanel()
  self.bind.toggle_sightExplore = self.sourceData.toggle_finish
  local path = _exploreTpl:getExploreTexture(self.sourceData.data)
  self.bindComponents.img_sightOn:LoadSprite(path, false)
  self.bindComponents.img_sightOff:LoadSprite(path, false)
  self.bind.txt_sight_name = _exploreTpl:getExploreName(self.sourceData.data)
  self.bind.txt_sight_describe = _exploreTpl:getIntroduceText(self.sourceData.data)
end

function this:initRewardPanel()
  local tmp = {}
  local explorationMapInfo = self.sourceData
  local rewardData = _exploreLevelTpl:getExploreRewardTplByMapId(explorationMapInfo.map_id)
  table.sort(rewardData, function(a, b)
    return _exploreLevelTpl:getLv(a) < _exploreLevelTpl:getLv(b)
  end)
  local index = 0
  local voidIndex = 0
  for i, v in ipairs(rewardData) do
    if not table.isEmpty(_exploreLevelTpl:getReward(v)) or _exploreLevelTpl:getLffly(v) == 1 then
      voidIndex = voidIndex + 1
      table.insert(tmp, {
        sceneId = explorationMapInfo.map_id,
        go_curLevel = explorationMapInfo.lv == _exploreLevelTpl:getLv(v),
        levelIcon = _exploreLevelTpl:getExploreLevel(v),
        id = _exploreLevelTpl:getId(v),
        reward = L_DataUtil.parseRewardConfig(_exploreLevelTpl:getReward(v)),
        iffly = _exploreLevelTpl:getLffly(v)
      })
      if explorationMapInfo.lv == _exploreLevelTpl:getLv(v) then
        index = voidIndex - 1
      end
    end
  end
  self.bind.list_reward:clear()
  self.bind.list_reward:insert_array(tmp)
  self.bind.focusIndexItem = index
end

return this
