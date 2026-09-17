local this = class("pageWorldAreaMap", G_UIPageBase)
local areaTpl = L_GameTpl:getAreaTpl()
local domainTpl = L_GameTpl:getDomainTpl()
local worldAreaTpl = L_GameTpl:getWorldAreaTpl()
local levelText = {
  [1] = "I",
  [2] = "II",
  [3] = "III",
  [4] = "IV",
  [5] = "V"
}

local function refreshStackTopState()
  local stack = C_UIMgr.GetGroup(CS.Azur.Gameplay.EUIGroup.Stack)
  if stack then
    stack:OnTopUIChange()
  end
end

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {
    curSelectMap = nil,
    lastSelectAreaItem = nil,
    allAreaConfig = {},
    offsetBorder = 195
  }
end

function this.bind()
  return {
    go_btnAreaList = true,
    go_areaList = false,
    go_moduleAreaMap = true,
    go_moduleWorldMap = true,
    moduleWorldMap = {
      moduleName = "pages/map/worldMap/moduleWorldMap"
    },
    moduleAreaMap = {
      moduleName = "pages/map/worldMap/moduleAreaMap"
    },
    scrollList_area = {
      moduleName = "pages/map/worldMap/cellAreaItem"
    },
    scrollList_world = {
      moduleName = "pages/map/worldMap/cellWorldAreaItem"
    },
    show_worldList = false,
    show_AreaList = false,
    txt_area = false,
    btn_upper = false,
    buttonIcon = false,
    txt_areaName = "",
    txt_level = ""
  }
end

function this.methods()
  return {
    onClick_openAreaList = function(self)
      self:toggleAreaList(true)
    end,
    onClick_closeAreaList = function(self)
      self:toggleAreaList(false)
    end,
    onClick_world = function()
      L_UI:open("pageWorldLevel")
    end,
    onAnimEvent_worldBg = function(self, name)
      if name == "OnNumChange" then
        self:refreshWorldLevel()
      end
    end,
    onClick_worldMap = function(self)
      self:switchMap(1)
    end,
    scrollList_world = {
      onClick_selectItem = function(self, bind)
        for k, v in pairs(self.modules.scrollList_world) do
          if v.bind.config.areaId == bind.config.areaId then
            v.bind.go_normal = false
            v.bind.go_active = true
          else
            v.bind.go_normal = true
            v.bind.go_active = false
          end
        end
        self.modules.moduleWorldMap:refreshWorldList(bind)
      end
    }
  }
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self.fromBigMap = false
  if options and options.ani then
    self.fromBigMap = true
  end
  if self.fromBigMap then
    refreshStackTopState()
  end
  L_WorldLevelStore:listenCallFunc(L_WorldLevelStore.event.syncWorldLevel, self.refreshWorldLevel, self, self.gameObject)
  L_WorldLevelStore:listenCallFunc(L_WorldLevelStore.event.animWorldLevel, self.playRefreshWorldLevelAnim, self)
  C_IntegrateMgr.TopBarModule:SetTopBarCanvasSortOrder(23)
  self.data.curSelectMap = self.data.curSelectMap or 1
  self:init()
end

function this:close(options)
  L_WorldLevelStore:unListenCallFunc(L_WorldLevelStore.event.syncWorldLevel, self.refreshWorldLevel)
  L_WorldLevelStore:unListenCallFunc(L_WorldLevelStore.event.animWorldLevel, self.playRefreshWorldLevelAnim)
  L_TimerManager:clearTimer(self)
  this.super.close(self, options)
end

function this:toggleAreaList(b)
  if b then
    self.bind.go_areaList = true
    self.bindComponents.aniAreaList:Play("anim_AreaMap_listin")
  else
    self.bindComponents.aniAreaList:Play("anim_AreaMap_listout")
    if self.data.areaListCloseTimer then
      self.data.areaListCloseTimer:stop()
      Timer.remove(self.data.areaListCloseTimer)
      self.data.areaListCloseTimer = nil
    end
    self.data.areaListCloseTimer = Timer.once(0.4, function()
      self.bind.go_areaList = false
      self.data.areaListCloseTimer = nil
    end)
  end
  self.bind.go_btnAreaList = not b
end

function this:init()
  self:initPage()
end

function this:initPage()
  self.bind.go_areaList = false
  self.bind.go_btnAreaList = true
  self:initMap(self.data.curSelectMap)
  self:refreshWorldLevel()
end

function this:playRefreshWorldLevelAnim()
  self.bindComponents.aniWorldLevel:Play("anim_AreaMap_lvup")
end

function this:initMap(mapIndex, areaId)
  L_TimerManager:clearTimer(self)
  if mapIndex == 1 then
    self.bind.go_moduleWorldMap = true
    self.bind.go_moduleAreaMap = false
    self:initWorldMapScrollList()
    self:activeComponents(false)
  else
  end
end

function this:switchMap(mapIndex, areaId)
  L_TimerManager:clearTimer(self)
  self.modules.moduleAreaMap.bindComponents.aniPage:Stop()
  self.modules.moduleWorldMap.bindComponents.aniPage:Stop()
  if mapIndex == 1 then
    self.bind.go_moduleWorldMap = true
    self.modules.moduleAreaMap.bindComponents.aniPage:Play("anim_AreaMap_ToWorld")
    L_TimerManager:newOrResetTimer(self, "A2W", function()
      self.bind.go_moduleAreaMap = false
    end, 0.64)
    self:initWorldMapScrollList()
    self:activeComponents(false)
  else
  end
end

function this:refreshWorldLevel()
  self.bind.txt_level = levelText[L_WorldLevelStore:getNowLevel()]
end

function this:refreshAreaName(areaId)
  local tpl = areaTpl:getTplById(areaId)
  self.bind.txt_areaName = areaTpl:getAreaName(tpl)
end

function this:activeComponents(b)
  self.bind.txt_area = b
  self.bind.btn_upper = b
  self.bind.show_worldList = not b
  self.bind.show_AreaList = b
  self.bind.buttonIcon = not b
end

function this:initWorldMapScrollList()
  local tempData = {}
  local data = areaTpl:getConfig()
  for k, v in pairs(data) do
    local bShow = false
    local conds = areaTpl:getUnlockCondition(v)
    if conds then
      local complete = L_ConditionManager:isComplete(conds)
      bShow = complete
    else
      bShow = true
    end
    if bShow then
      local icon = areaTpl:getIcon(v)
      local name = areaTpl:getAreaName(v)
      table.insert(tempData, {
        config = v,
        go_active = false,
        go_normal = true,
        go_lock = false,
        txt_name_active = name,
        txt_name_normal = name,
        txt_name_lock = name
      })
    end
  end
  self.bind.scrollList_world:clear()
  self.bind.scrollList_world:insert_array(tempData)
end

function this:check(options, callback)
  local result = C_IntegrateMgr.SystemUnlockModule:CheckAndTip(L_SystemConst.enum.adventure)
  callback(result)
end

function this:update()
  self.modules.moduleWorldMap:update()
end

return this
