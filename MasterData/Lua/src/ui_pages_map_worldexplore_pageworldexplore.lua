local page = class("pageWorldExplore", G_UIPageBase)
local _worldCityTpl = L_GameTpl:getWorldCityTpl()
local _exploreRewardTpl = L_GameTpl:getExploreRewardTpl()

function page.bind()
  return {
    scrollExplore = {
      moduleName = "pages/Map/WorldExplore/cellWorldExplore"
    },
    txt_name = "",
    txt_explore = "",
    float_progress = 0
  }
end

function page.methods()
  return {
    onClick_close = function(self)
      L_UI:close(self.pageName)
    end,
    scrollExplore = {
      onClick = function(self, bind)
        self:OnClick_point(bind)
      end
    }
  }
end

function page:created(...)
  page.super.created(self, ...)
  L_WorldExploreStore:listenCallFunc(L_WorldExploreStore.event.ExplorationSync, self.OnEvent_ExplorationSync, self)
  L_WorldExploreStore:listenCallFunc(L_WorldExploreStore.event.MapExploreReward, self.OnEvent_ExplorationSync, self)
end

function page:preOpen(options)
  page.super.preOpen(self, options)
  self.data = {
    sceneId = options.sceneId,
    tplList = _exploreRewardTpl:getTplListBySceneId(options.sceneId)
  }
  local tpl = _worldCityTpl:getTplById(self.data.sceneId)
  self.bind.txt_name = _worldCityTpl:getCity(tpl)
  self.bind.txt_explore = L_WordsTpl:getValue("notice_pageWorldExplore", {
    [0] = math.floor(L_WorldExploreStore:getCurExplore(self.data.sceneId)) .. "%"
  })
  self.bind.float_progress = math.floor(L_WorldExploreStore:getCurExplore(self.data.sceneId)) / 100
  self:initPanel()
end

function page:close()
  page.super.close(self)
  L_WorldExploreStore:unListenCallFunc(L_WorldExploreStore.event.ExplorationSync, self.OnEvent_ExplorationSync)
  L_WorldExploreStore:unListenCallFunc(L_WorldExploreStore.event.MapExploreReward, self.OnEvent_ExplorationSync)
end

function page:initPanel()
  self.bind.scrollExplore:clear()
  local list = self:getShowItemList()
  self.bind.scrollExplore:insert_array(list)
end

function page:refreshPanel()
  local list = self:getShowItemList()
  for i, v in ipairs(list) do
    self.bind.scrollExplore:change(i, v)
  end
end

function page:OnEvent_ExplorationSync()
  self:refreshPanel()
end

function page:getShowItemList()
  local showList = {}
  local nowExplore = L_WorldExploreStore:getCurExplore(self.data.sceneId)
  for i, v in ipairs(self.data.tplList) do
    local item = {}
    item.id = _exploreRewardTpl:getId(v)
    local needExplore = _exploreRewardTpl:getExplore(v) // 100
    item.txt_explore = tostring(needExplore) .. "%"
    item.rewardList = {}
    item.status = L_Const.commonRewardStatus.notComp
    if nowExplore >= needExplore then
      if L_WorldExploreStore:getExploreGotId(item.id, self.data.sceneId) then
        item.status = L_Const.commonRewardStatus.got
      else
        item.status = L_Const.commonRewardStatus.complete
      end
    end
    local rewards = _exploreRewardTpl:getReward(v)
    item.rewardList = L_DataUtil.parseRewardConfig(rewards)
    table.insert(showList, item)
  end
  table.sort(showList, function(a, b)
    if a.status ~= b.status then
      return a.status < b.status
    end
    return a.id < b.id
  end)
  return showList
end

function page:OnClick_point(bind)
  if bind.status ~= L_Const.commonRewardStatus.complete then
    return
  end
  L_WorldExploreStore:req_worldExploreReward(bind.id)
end

return page
