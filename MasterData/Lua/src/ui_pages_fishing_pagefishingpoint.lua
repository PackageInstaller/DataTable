local this = class("pageFishingPoint", G_UIPageBase)
local _fishPondTpl = L_GameTpl:getFishPondTpl()
local _fishGroupTpl = L_GameTpl:getFishGroupTpl()
local _commonItemTpl = L_GameTpl:getCommonItemTpl()
local _fishRodTpl = L_GameTpl:getFishRodTpl()
local _fishRodBuffTpl = L_GameTpl:getFishRodBuffTpl()

function this.bind()
  return {
    txt_pointName = "",
    txt_pointDesc = "",
    txt_fishLeftNum = "",
    module_fishingGear = {
      moduleName = "pages/fishing/moduleFishingGear"
    },
    list_rodBuff = {
      moduleName = "pages/fishing/cellFishingRodBuff"
    },
    scrollList_fish = {
      moduleName = "pages/fishing/cellPointFish"
    }
  }
end

function this.methods()
  return {
    onClick_close = function(self)
      self.bindComponents.ani_pageFishingPoint:Play("anim_fishingpoint_close")
      L_TimerManager:newOrResetTimer(self, "closeFX", function()
        L_UI:close(self.pageName)
      end, 0.333)
    end,
    onClick_fishing = function(self)
      if L_FishingManager:checkFishing(self._pointId) then
        self.bindComponents.ani_pageFishingPoint:Play("anim_fishingpoint_startfish")
        L_TimerManager:newOrResetTimer(self, "reqFishing", function()
          L_LoadingManager:openSaveFormationLoading(nil, function()
            L_FishingManager:reqFishing(true, self._pointId)
          end, true)
        end, 0.2)
      end
    end,
    onClick_replaceRod = function(self)
      L_FishingManager:replaceRod(self._pointId)
    end,
    onClick_replaceBait = function(self)
      L_FishingManager:replaceBait(self._pointId)
    end
  }
end

function this:escHandle()
  self.methods.onClick_close(self)
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  L_FishingStore:listenCallFunc(L_FishingStore.event.refreshFishingGear, self.onEvent_refreshFishingGear, self)
  L_FishingStore:listenCallFunc(L_FishingStore.event.refreshFishPoint, self.onEvent_refreshFishPoint, self)
  L_GameStore:listenCallFunc(L_GameStore.event.refreshDayChange, self.onEvent_refreshFishPoint, self)
  self._pointId = tonumber(options.pondId)
  self:initPage()
end

function this:close(options)
  this.super.close(self, options)
  L_FishingStore:unListenCallFunc(L_FishingStore.event.refreshFishingGear, self.onEvent_refreshFishingGear)
  L_FishingStore:unListenCallFunc(L_FishingStore.event.refreshFishPoint, self.onEvent_refreshFishPoint)
  L_GameStore:unListenCallFunc(L_GameStore.event.refreshDayChange, self.onEvent_refreshFishPoint)
  L_TimerManager:clearTimer(self)
end

function this:initPage()
  local tpl = _fishPondTpl:getTplById(self._pointId)
  self.bind.txt_pointName = _fishPondTpl:getFishPondName(tpl)
  self.bind.txt_pointDesc = _fishPondTpl:getDescription(tpl)
  self.bind.txt_fishLeftNum = L_WordsTpl:getValue("info_fish_stilllastfish", {
    [0] = L_FishingManager:getFishPointFishCountSum(self._pointId)
  })
  local moduleFishingGear = self.modules.module_fishingGear
  moduleFishingGear:initModule(self._pointId)
  self:initFishList()
  self:initRodBuff()
end

function this:initFishList()
  local tpl_pond = _fishPondTpl:getTplById(self._pointId)
  local groupId = _fishPondTpl:getFishGroup(tpl_pond)
  local fishGroup = _fishGroupTpl:getGroupFish(groupId)
  local tmp = {}
  for i, v in pairs(fishGroup) do
    local isLock = table.isEmpty(L_FishingStore:getFishHandbook(v))
    table.insert(tmp, {
      itemId = v,
      noTip = table.isEmpty(L_FishingStore:getFishHandbook(v)),
      go_lock = isLock,
      go_unLock = not isLock
    })
  end
  table.sort(tmp, function(a, b)
    local lockA = table.isEmpty(L_FishingStore:getFishHandbook(a.itemId)) and 1 or 0
    local lockB = table.isEmpty(L_FishingStore:getFishHandbook(b.itemId)) and 1 or 0
    local confA = L_ItemTplManager:getCommonItem(a.itemId)
    local confB = L_ItemTplManager:getCommonItem(b.itemId)
    if lockA == lockB then
      local qualityA = confA.quality
      local qualityB = confB.quality
      if qualityA == qualityB then
        return a.itemId < b.itemId
      else
        return qualityA > qualityB
      end
    else
      return lockA < lockB
    end
  end)
  self.bind.scrollList_fish:clear()
  self.bind.scrollList_fish:insert_array(tmp)
end

function this:initRodBuff()
  local rodId = L_FishingStore:getCurRodId()
  local buffInfo = {}
  if not math.isEmpty(rodId) then
    local tpl_commonItem = _commonItemTpl:getTplById(rodId)
    local subId = _commonItemTpl:getSubId(tpl_commonItem)
    local tpl_rod = _fishRodTpl:getTplById(subId)
    buffInfo = _fishRodTpl:getBuffInfo(tpl_rod)
  end
  local tmp = {}
  for i, v in pairs(buffInfo) do
    local tpl_buff = _fishRodBuffTpl:getTplById(v)
    local pondIdList = _fishRodBuffTpl:getPondId(tpl_buff)
    local node, index = table.ipairsFind(pondIdList, function(id)
      return id == self._pointId
    end)
    if index then
      table.insert(tmp, {
        img_icon = _fishRodBuffTpl:getIconLight(tpl_buff),
        txt_desc = _fishRodBuffTpl:getDesc(tpl_buff)
      })
    end
  end
  self.bind.list_rodBuff:clear()
  self.bind.list_rodBuff:insert_array(tmp)
end

function this:onEvent_refreshFishingGear()
  self:initRodBuff()
end

function this:onEvent_refreshFishPoint()
  self:initPage()
end

return this
