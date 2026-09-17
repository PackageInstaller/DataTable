local this = class("pageBigMap", G_UIPageBase)
local debugActions = require("debug.debugActions")
local _worldFilter = L_GameTpl:getWorldFilterTpl()
local _worldPointTpl = L_GameTpl:getWorldBorthposTpl()
local _worldAreaTpl = L_GameTpl:getWorldAreaTpl()
local _worldMapTpl = L_GameTpl:getWorldMapTpl()
local _areaTpl = L_GameTpl:getAreaTpl()
local _exploreTpl = L_GameTpl:getExploreTpl()
local _exploreLevelTpl = L_GameTpl:getExploreLevelTpl()
local _worldFilterMarkTpl = L_GameTpl:getWorldFilterMarkTpl()
local _filterTpl = L_GameTpl:getWorldFilterTpl()
local _filterMarkTpl = L_GameTpl:getWorldFilterMarkTpl()
local _nestcoopSiteTpl = L_GameTpl:getNestcoopSiteTpl()
local _tmpPos = C_Vector3.zero
local _tmpVec2 = C_Vector2.zero
local _collectionTraceTipPath = "UI/Pages/Map/BigMap/moduleMapCollectionTraceTip.prefab"
local _unlockPrefabPath = "UI/Pages/Map/BigMap/unlockFX.prefab"
local _BGPath = "UI/Pages/Map/BigMap/MapBG.prefab"
local _screenPosToUI = Unity.RectTransformUtility.ScreenPointToLocalPointInRectangle
local screenOffset = 100
local changeToNpcType = {
  [L_MapConst.mapSievingType.dungeon] = 1,
  [L_MapConst.mapSievingType.boss] = 1,
  [L_MapConst.mapSievingType.dungeonBoss] = 1,
  [L_MapConst.mapSievingType.fish] = 1,
  [L_MapConst.mapSievingType.kiboDuel] = 1,
  [L_MapConst.mapSievingType.entrustTaskNpc] = 1,
  [L_MapConst.mapSievingType.explore] = 1,
  [L_MapConst.mapSievingType.areaLevel] = 1
}
local mapExploreIconStatus = {
  processing = 1,
  reward = 2,
  finish = 3
}
local mapKiboStatus = {
  notCondition = 1,
  notSamsung = 2,
  notAllCurrently = 1000
}
local levelText = {
  [1] = "I",
  [2] = "II",
  [3] = "III",
  [4] = "IV",
  [5] = "V"
}
local TypeToModuleName = {
  [L_MapConst.mapSievingType.task] = "moduleMapTaskInfo",
  [L_MapConst.mapSievingType.fish] = "moduleMapFishInfo",
  [L_MapConst.mapSievingType.dungeon] = "moduleMapDungeonInfo",
  [L_MapConst.mapSievingType.dynamicDungeon] = "moduleMapDungeonInfo",
  [L_MapConst.mapSievingType.boss] = "moduleMapBossInfo",
  [L_MapConst.mapSievingType.dungeonBoss] = "moduleMapBossInfo",
  [L_MapConst.mapSievingType.kiboGroup] = "moduleMapKiboInfo",
  [L_MapConst.mapSievingType.kiboDuel] = "moduleMapKiBoDuelInfo",
  [L_MapConst.mapSievingType.specialPet] = "moduleMapSpecialPetInfo",
  [L_MapConst.mapSievingType.homeTrace] = "moduleMapHomeTraceInfo",
  [L_MapConst.mapSievingType.entrustTaskNpc] = "moduleMapEntrustTaskNpcInfo",
  [L_MapConst.mapSievingType.wildBuffBuild] = "moduleMapWildBuffBuildInfo",
  [L_MapConst.mapSievingType.mapCollectionItem] = "moduleMapCommonInfo",
  [L_MapConst.mapSievingType.areaLevel] = "moduleMapAreaLevelInfo",
  [L_MapConst.mapSievingType.explore] = "moduleMapExploreInfo",
  [L_MapConst.mapSievingType.nestCoop] = "moduleMapCommonInfo",
  [L_MapConst.mapSievingType.kiboDuelPvp] = "moduleMapCommonInfo"
}
local sharedChoosePrefabPath = "UI/Pages/Map/BigMap/cellMapNodeChoose.prefab"

function this.bind()
  return {
    toggle_isWidthSceneBtns = false,
    go_btnTask = true,
    go_btnTask_sw = true,
    filterBtnActive = false,
    filterBtnActive_sw = false,
    go_bottomRight = true,
    value_sliderScale = 0,
    txtTitle = "",
    go_teleList = false,
    go_randomDungeonMap = false,
    module_randomDungeonMap = {
      moduleName = "pages/Dungeon/moduleRandomDungeonMap"
    },
    moduleMapPoint = {
      moduleName = "pages/map/bigMap/moduleMapPoint"
    },
    scrollList_tele = {
      moduleName = "pages/Map/WorldMap/cellParentTeleItem"
    },
    moduleMapLv = {
      moduleName = "pages/main/moduleMapLv"
    },
    mapDirection = C_Vector3.zero,
    show_nodeDetailPanel = false,
    toggleModule = {
      type = "toggleModule",
      moduleMapCommonInfo = {
        assetName = "UI/Pages/map/bigMap/moduleMapCommonInfo",
        moduleName = "pages/map/bigMap/moduleMapCommonInfo"
      },
      moduleMapPointPanel = {
        assetName = "UI/Pages/map/bigMap/moduleMapPointPanel",
        moduleName = "pages/map/bigMap/moduleMapPointPanel"
      },
      moduleMapTaskInfo = {
        assetName = "UI/Pages/map/bigMap/moduleMapTaskInfo",
        moduleName = "pages/map/bigMap/moduleMapTaskInfo"
      },
      moduleMapFishInfo = {
        assetName = "UI/Pages/map/bigMap/moduleMapFishInfo",
        moduleName = "pages/map/bigMap/moduleMapFishInfo"
      },
      moduleMapDungeonInfo = {
        assetName = "UI/Pages/map/bigMap/moduleMapDungeonInfo",
        moduleName = "pages/map/bigMap/moduleMapDungeonInfo"
      },
      moduleMapBossInfo = {
        assetName = "UI/Pages/map/bigMap/moduleMapBossInfo",
        moduleName = "pages/map/bigMap/moduleMapBossInfo"
      },
      moduleMapKiboInfo = {
        assetName = "UI/Pages/map/bigMap/moduleMapKiboInfo",
        moduleName = "pages/map/bigMap/moduleMapKiboInfo"
      },
      moduleMapKiBoDuelInfo = {
        assetName = "UI/Pages/map/bigMap/moduleMapKiBoDuelInfo",
        moduleName = "pages/map/bigMap/moduleMapKiBoDuelInfo"
      },
      moduleMapSpecialPetInfo = {
        assetName = "UI/Pages/map/bigMap/moduleMapSpecialPetInfo",
        moduleName = "pages/map/bigMap/moduleMapSpecialPetInfo"
      },
      moduleMapHomeTraceInfo = {
        assetName = "UI/Pages/map/bigMap/moduleMapHomeTraceInfo",
        moduleName = "pages/map/bigMap/moduleMapHomeTraceInfo"
      },
      moduleMapEntrustTaskNpcInfo = {
        assetName = "UI/Pages/map/bigMap/moduleMapEntrustTaskNpcInfo",
        moduleName = "pages/map/bigMap/moduleMapEntrustTaskNpcInfo"
      },
      moduleMapWildBuffBuildInfo = {
        assetName = "UI/Pages/map/bigMap/moduleMapWildBuffBuildInfo",
        moduleName = "pages/map/bigMap/moduleMapWildBuffBuildInfo"
      },
      moduleMapAreaLevelInfo = {
        assetName = "UI/Pages/map/bigMap/moduleMapAreaLevelInfo",
        moduleName = "pages/map/bigMap/moduleMapAreaLevelInfo"
      },
      moduleMapExploreInfo = {
        assetName = "UI/Pages/map/bigMap/moduleMapCommonInfo",
        moduleName = "pages/map/bigMap/moduleMapExploreInfo"
      }
    },
    toggleModuleName = "",
    selfAngle = C_Vector3(0, 0, 0),
    arrowAngle = C_Vector3(0, 0, 0),
    moduleMapInteractiveRoot = {
      type = "toggleModule",
      moduleMapInteractive = {
        assetName = "UI/Pages/map/bigMap/moduleMapInteractive",
        moduleName = "pages/map/bigMap/moduleMapInteractive"
      }
    },
    moduleMapInteractiveRootName = "",
    showMapInteractive = false,
    showClosePanelBtn = false,
    moduleMapExplore = {
      moduleName = "pages/map/bigMap/moduleMapExplorePanel"
    },
    moduleMapExplore_show = false,
    mapExploreEntry = false,
    rewardsOn = false,
    finishOn = false,
    processingOn = false,
    process = 0,
    txt_exploreLv = "",
    moduleMapFilterRoot = {
      type = "toggleModule",
      moduleMapFilter = {
        assetName = "UI/Pages/map/bigMap/moduleMapFilter",
        moduleName = "pages/map/bigMap/moduleMapFilter"
      }
    },
    moduleMapFilterRootName = ""
  }
end

function this.methods()
  return {
    onClick_add = function(self)
      local value = math.clamp(self.mapData.sliderValue + 0.01, 0, 1)
      self.bindComponents.slider_scale.value = value
    end,
    onClick_decrease = function(self)
      local value = math.clamp(self.mapData.sliderValue - 0.01, 0, 1)
      self.bindComponents.slider_scale.value = value
    end,
    onClick_openExploreModule = function(self)
      self.bind.moduleMapExplore_show = true
    end,
    onClick_closeExploreModuleBtn = function(self)
      self.bind.moduleMapExplore_show = false
    end,
    onClick_closeExploreModule = function(self)
      self.bind.moduleMapExplore_show = false
    end,
    onClick_upFloor = function(self)
      self.toWorldArea = true
      self.bindComponents.aniPage:Play("anim_bigmap_out")
      L_TimerManager:newOrResetTimer(self, "toWorldAreaMap", function()
        L_UI:open("pageWorldAreaMap", {
          ani = "anim_AreaMap_FromBig",
          mode = "replaceSwiftly"
        })
      end, 0.26)
    end,
    onValueChanged_mapScale = function(self, value)
      self.mapScale = value
      self:setMapScale(self.mapScale)
    end,
    scrollList_tele = {
      onClick_selectItem = function(self, bind)
        local transferList = self:getNodeList(L_MapConst.mapSievingType.transfer)
        for k, v in ipairs(transferList) do
          if v.id == bind.id then
            self:selectTeleNode(v)
            break
          end
        end
        for k, v in ipairs(self.modules.scrollList_tele) do
          v:setChildItemActive(bind.id)
        end
        self:refreshChooseByNodeType(L_MapConst.mapSievingType.transfer, bind.id)
      end,
      onClick_selectArea = function(self, bind)
        for i, v in ipairs(self.bind.scrollList_tele) do
          local item = self.bind.scrollList_tele:getItemCls(i)
          local id = self.bind.scrollList_tele:getValue(i, "id")
          local go_active = self.bind.scrollList_tele:getValue(i, "go_active")
          if id == bind.id and go_active == false then
            self.bind.scrollList_tele:change(i, {go_active = true, go_normal = false})
            local pos = self.bind.scrollList_tele:getValue(i, "areaPos")
            self:focusAreaCenter(pos, id)
          else
            self.bind.scrollList_tele:change(i, {go_active = false, go_normal = true})
            self.bindComponents.list:ReloadData()
          end
          item:refreshRect()
        end
      end
    },
    onClick_MapCollection = function(self)
      L_UI:open("pageMapCollection", {
        sceneId = self.mapData.sceneId
      })
    end,
    onClick_closeNodeDetail = function(self)
      self:activeDetailPanel(false)
      if self.data.nodeType ~= nil then
        self:hideChooseNode()
        self.data.nodeType = nil
      else
        self.modules.moduleMapPoint:initMarkPoint()
        self.modules.moduleMapPoint:refreshSelfMarkState(self.mapData:getFilter(), true)
        self.modules.moduleMapPoint:refreshAllPoints()
      end
      if self.kiBoNode then
        self.kiBoNode:setShow(false)
        self.kiBoNode = nil
      end
    end,
    onClick_worldBuff = function()
      L_UI:open("pageWorldBuff")
    end,
    onClick_worldBuff_sw = function()
      L_UI:open("pageWorldBuff")
    end,
    onClick_focusPlayerPos = function(self)
      local pos = L_PlayerManager:getMainControlEntityPos()
      local centerPos = {
        [1] = pos.x,
        [2] = pos.y,
        [3] = pos.z
      }
      self:focusAreaCenter(centerPos)
    end,
    onClick_filter = function(self)
      self:openFilterModule()
    end,
    onClick_filter_sw = function(self)
      self:openFilterModule()
    end,
    onClick_cancelMapCollectionTrace = function(self)
      local list = self:getNodeList(L_MapConst.mapSievingType.mapCollectionItem)
      if table.isEmpty(list) then
        return
      end
      local data = {
        txtTitle = L_WordsTpl:getValue("residual_code_pagebigmap_01"),
        txtContent = L_Lang:get(L_WordsTpl:getValue("ui_world_collect_cance_track"), {
          [1] = list[1].name
        }),
        confirmCallback = function(txt)
          self:setMapCollectionTraceTip(false, list[1])
        end
      }
      L_GameUtil.showCommonTip(data)
    end,
    moduleMapFilter = {
      refreshFilter = function(self, filters)
        self:refreshMarksByFilter(filters)
      end
    }
  }
end

function this:check(options, callback)
  if not C_IntegrateMgr.SystemUnlockModule:checkAndTip(L_SystemConst.enum.map) then
    callback(false)
    return
  end
  local areaId = options and options.areaId or AzurWorld.areaManager:GetAreaId()
  if math.isEmpty(areaId) or areaId < 0 or AzurWorld.DungeonMgr:CheckIsDungeonScene() then
    L_FlyMsgManager:showNormalMsgByKey("notice_pageBigMap_01")
    callback(false)
    return
  end
  callback(true)
end

function this:created(...)
  this.super.created(self, ...)
  self.data = {id = nil, nodeType = nil}
end

function this:onEvent_MapAreaChange(_, varList)
  local areaId = varList:GetInt(0)
  self.initMap(areaId)
end

function this:preOpen(options)
  options = options or {}
  self.areaId = options.areaId
  self._MapAreaChangeHandler = handler(self, self.onEvent_MapAreaChange)
  AzurWorld.areaManager:RegisterEvent(C_WorldAreaEventDefine.MapAreaChanged, self._MapAreaChangeHandler)
  L_SceneStore:listenCallFunc(L_SceneStore.event.refreshPoint, self.onEvent_refreshTransferNode, self)
  L_HomeStore:listenCallFunc(L_HomeStore.event.syncHomeContentUnlock, self.onEvent_refreshHomeAreaNode, self)
  L_MapStore:listenCallFunc(L_MapStore.event.refreshNodeTrace, self.refreshNodeTraceState, self)
  L_MapStore:listenCallFunc(L_MapStore.event.refreshExploreNodeTrace, self.refreshNodeTraceState, self)
  L_MapStore:listenCallFunc(L_MapStore.event.refreshCollectionTrace, self.refreshCollectionTrace, self)
  L_PetDuelStore:listenCallFunc(L_PetDuelStore.event.refresh_recordInfo, self.refreshPetDuelNodeState, self)
  L_WorldExploreStore:listenCallFunc(L_WorldExploreStore.event.ExplorationSync, self.initMapExplore, self)
  L_GuideManager:addListener(G_GuideClasses.GuideEvent.RefreshWorldMarkFilter, self.onRefreshWorldMarkFilter, self)
  local isSuperWidthScene = C_ResolutionUtility.CheckSuperWidthScreen() or not L_DeviceTpl:getIsPc()
  self.bind.toggle_isWidthSceneBtns = isSuperWidthScene
  self.fromWorldArea = false
  self.toWorldArea = false
  local size = 1
  self.judgeWidth = Unity.Screen.width / size
  self.judgeHeight = Unity.Screen.height / size
  self.middlePoint = L_Vector3.new(Unity.Screen.width / 2, Unity.Screen.height / 2)
  self.vector_up = L_Vector3.new(0, 1)
  if options and options.ani then
    self.bindComponents.lAnimation:SampleAnimation("anim_bigmap_in")
    self.fromWorldArea = true
  else
    self.bindComponents.lAnimation:SampleAnimation("anim_bigmap_open")
  end
  self:configTouch("+")
  self.mapScale = 0
  
  function self._mouseScrollWheelHandle(dv)
    C_MJLog.LogInfo("大地图滚轮缩放Start------")
    if self.bind.showMapInteractive or self.bind.showClosePanelBtn or self.bind.moduleMapExplore_show or self:isFilterModuleOn() then
      return
    end
    self.mapScale = self.mapScale + (0 < dv and 0.05 or dv < 0 and -0.05 or 0)
    self.mapScale = math.clamp(self.mapScale, 0, 1)
    self:setMapScale(self.mapScale)
    C_MJLog.LogInfo("大地图滚轮缩放End-------")
  end
  
  if not L_DeviceTpl:getIsPc() then
    C_MJLog.LogWarning("@手机平台，不注册滚轮事件")
  else
    C_InputManager.AddSingleAxisListener(C_InputManager.EInputSingleAxisType.EMainMouseScroll, self._mouseScrollWheelHandle)
  end
  self.isAccess = nil
  self.kiBoId = nil
  if options.jumpParams then
    local jumpType = tonumber(options.jumpParams[1])
    if jumpType == 1 then
      local cfg = _worldFilterMarkTpl:getTplById(tonumber(options.jumpParams[2]))
      local cityId = _worldFilterMarkTpl:getWorldId(cfg)
      local worldMapId = _worldFilterMarkTpl:getWorldmapId(cfg)
      options.areaId = AzurWorld.WorldMapMgr:GetItemAreaId(cityId, worldMapId)
      if not options.areaId or options.areaId <= 0 then
        options.areaId = _worldAreaTpl:getCurSceneAreaList(_worldFilterMarkTpl:getWorldId(cfg))[1].id
      end
      self.isAccess = true
      self.isAccessAreaId = options.areaId
    elseif jumpType == 2 then
      self.tempWorldLstId = {}
      self:showKiBo(nil, options)
    end
  end
  local areaId = options.areaId or AzurWorld.areaManager:GetMapAreaId()
  self._trueAreaId = options.areaId or AzurWorld.areaManager:GetAreaId()
  local birthPoint = options.birthPoint
  local exitName = options.exitName or self.pageName
  local openMode = options.openMode
  local param = options.unLockParam
  self.timers = {}
  self.mapData = nil
  self.mapBuilder = nil
  self.nodeDic = {}
  self.areaBlockDic = {
    areaBlock = {},
    miniAreaBlock = {},
    sceneBorderTransfer = {},
    areaMask = {},
    areaBoundary = {}
  }
  self.data = {
    birthPoint = birthPoint,
    exitName = exitName,
    openMode = openMode,
    param = param or nil
  }
  self.pool = L_PoolManager:getResPool()
  self:initSharedChooseNode()
  self:initMap(areaId)
  self:initModule()
  self:initSystem()
  local center = self:initMode()
  if options then
    if options.areaPos then
      self:initCenterPos()
    elseif options.taskId and options.areaId then
      local taskNodeList = self:getNodeList(L_MapConst.mapSievingType.task)
      for i, v in ipairs(taskNodeList) do
        if v.id == options.taskId then
          self:triggerMapNode(v)
          break
        end
      end
    elseif options.targetParam then
      for _, mapInfo in pairs(options.targetParam) do
        local taskNodeList = self:getNodeList(mapInfo[1])
        if not taskNodeList then
          self:initCenter(center)
          return
        end
        for _, v in ipairs(taskNodeList) do
          if v.id == mapInfo[2] then
            self:triggerMapNode(v)
            break
          end
        end
      end
    elseif options.specialParams and options.areaId then
      local specialPetNode = self:getNodeList(L_MapConst.mapSievingType.specialPet)
      for _, v in ipairs(specialPetNode) do
        local wpTpl = _worldMapTpl:getTplById(options.specialParams.map_id, options.specialParams.obj_id)
        if v.id == _worldMapTpl:getId(wpTpl) then
          self:triggerSpecialPetMapNodeInOpen(v)
          break
        end
      end
    elseif options.jumpParams then
      local jumpType = tonumber(options.jumpParams[1])
      if jumpType == 1 then
        local needTrigger = true
        for _, v in pairs(self.areaBlockDic.areaMask) do
          local aId = AzurWorld.WorldMapMgr:GetItemAreaId(v.cityId, v.worldMapId)
          if aId == self.isAccessAreaId and not v.isUnLock then
            needTrigger = false
          end
        end
        if needTrigger then
          local cfg = _worldFilterMarkTpl:getTplById(tonumber(options.jumpParams[2]))
          local nodeType = _worldFilterMarkTpl:getMarkType(cfg)
          if changeToNpcType[nodeType] then
            nodeType = L_MapConst.mapSievingType.npc
          end
          local nodeList = self:getNodeList(nodeType)
          if not nodeList then
            self:initCenter(center)
            return
          end
          for _, v in ipairs(nodeList) do
            if not math.isEmpty(_worldFilterMarkTpl:getPosId(cfg)) then
              if v.id == _worldFilterMarkTpl:getPosId(cfg) then
                self:triggerMapNode(v)
                break
              end
            elseif v.id == _worldFilterMarkTpl:getWorldmapId(cfg) then
              self:triggerMapNode(v)
              break
            end
          end
        end
      elseif jumpType == 2 then
        self.kiBoNode = nil
        if self.kiBoId then
          local nodeList = self:getNodeList(L_MapConst.mapSievingType.npc)
          for i, v in pairs(nodeList) do
            if self.kiBoId == v.id then
              v:setShow(true)
              self:triggerMapNode(v)
              if tonumber(options.jumpParams[2]) == mapKiboStatus.notAllCurrently then
                self.kiBoNode = v
              end
              break
            end
          end
        elseif tonumber(options.jumpParams[2]) == mapKiboStatus.notAllCurrently then
          L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_novicetask_kibotask_tip03"))
        elseif tonumber(options.jumpParams[2]) == mapKiboStatus.notCondition then
          L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_novicetask_kibotask_tip01"))
        elseif tonumber(options.jumpParams[2]) == mapKiboStatus.notSamsung then
          L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_novicetask_kibotask_tip02"))
        end
      end
    elseif options.hasHomeTrace then
      local homeTraceNode = self:getNodeList(L_MapConst.mapSievingType.homeTrace)
      for _, v in ipairs(homeTraceNode) do
        if v.type == L_MapConst.mapSievingType.homeTrace then
          self:triggerMapNode(v)
          break
        end
      end
    elseif options.showMythical then
      local mythicalPet = self:getNodeList(L_MapConst.mapSievingType.mythicalPet)
      if mythicalPet[1] then
        self:triggerMapNode(mythicalPet[1])
      end
    elseif options.trackNode then
      self.isJumpFromCatalog = true
      if not options.trackNode.enemyPackId then
        self:triggerMapNode(options.trackNode)
      end
    else
      self:initCenter(center)
    end
  else
    self:initCenter(center)
  end
  if C_IntegrateMgr.SystemUnlockModule:check(L_SystemConst.enum.renameMapMark) then
    self.bind.filterBtnActive = true
    self.bind.filterBtnActive_sw = true
  else
    self.bind.filterBtnActive = false
    self.bind.filterBtnActive_sw = false
  end
  self:createMapBG()
  self.unlockPrefabHandle = nil
end

function this:escHandle()
  if self:isFilterModuleOn() then
    self:hideFilterModule()
    return
  end
  L_MapManager:sandwichClose(self.pageName, self.data.exitName)
end

function this:showKiBo(worldId, options)
  local nodeTmpDic = {}
  local kiboLst = {}
  local worldLst = {}
  local nowSceneWorld = worldId or AzurWorld.areaManager:GetMapSceneId()
  local kiboType = tonumber(options.jumpParams[2])
  nodeTmpDic = L_MapManager:getMapNodeDic(nowSceneWorld, true)
  for _, list in pairs(nodeTmpDic) do
    for _, v in ipairs(list) do
      if v.type == L_MapConst.mapSievingType.kiboDuel then
        table.insert(kiboLst, v)
      end
    end
  end
  local closestDistance = math.maxinteger
  local mainPos
  local mainControl = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(true)
  if mainControl then
    local transform = mainControl.transform:GetRawTransform()
    mainPos = L_Vector3.getPos(transform)
  end
  for i, v in ipairs(kiboLst) do
    if self:isKiboUnLockArea(v.id, v.sceneId, nowSceneWorld) then
      if kiboType == mapKiboStatus.notCondition and not v:getIsNotCondition() then
        self.kiBoId = v.id
        break
      elseif kiboType == mapKiboStatus.notSamsung and (not v:getIsNotConditionFinish() or not v:getIsNotCondition()) then
        self.kiBoId = v.id
        break
      elseif kiboType == mapKiboStatus.notAllCurrently then
        if mainPos then
          local dis = C_Vector3.Distance(mainPos, v.configPos)
          if closestDistance > dis then
            closestDistance = dis
            self.kiBoId = v.id
          end
        else
          self.kiBoId = v.id
          break
        end
      end
    end
  end
  if self.kiBoId == nil and kiboType ~= mapKiboStatus.notAllCurrently then
    table.insert(self.tempWorldLstId, nowSceneWorld)
    worldLst = _filterMarkTpl:getTplByWorldId(self.tempWorldLstId, L_MapConst.mapSievingType.kiboDuel)
    local worldCount = #worldLst
    if worldCount == 0 then
      return
    elseif worldLst[1] then
      self:showKiBo(worldLst[1], options)
    end
  else
    if self.kiBoId then
      options.areaId = _worldAreaTpl:getCurSceneAreaList(nowSceneWorld)[1].id
    end
    return
  end
end

function this:isKiboUnLockArea(cityId, worldMapId, sceneId)
  local needTrigger = true
  local areaMask = {}
  areaMask = L_MapManager:getMapAreaMask(sceneId, areaMask)
  local accessAreaId = AzurWorld.WorldMapMgr:GetItemAreaId(worldMapId, cityId)
  if not accessAreaId or accessAreaId <= 0 then
    accessAreaId = _worldAreaTpl:getCurSceneAreaList(worldMapId)[1].id
  end
  if areaMask then
    for _, v in pairs(areaMask) do
      local aId = AzurWorld.WorldMapMgr:GetItemAreaId(v.cityId, v.worldMapId)
      if aId == accessAreaId and not v.isUnLock then
        needTrigger = false
      end
    end
  end
  return needTrigger
end

function this:initSystem()
  self.systemToTrans = {
    [L_SystemConst.enum.mapCollectionTrace] = {
      self.bindComponents.rTransMapCollection
    }
  }
  for systemId, v in pairs(self.systemToTrans) do
    v.locker = C_IntegrateMgr.SystemUnlockModule:tryGenerateLocker(systemId)
    if v.locker then
      self:refreshSystem(systemId, false)
      v.locker:setCallback(self.refreshSystem, self, self.gameObject)
    end
  end
end

function this:destroyAllLocker()
  for _, v in pairs(self.systemToTrans) do
    local locker = v.locker
    if locker then
      C_IntegrateMgr.SystemUnlockModule:removeLocker(locker)
    end
  end
end

function this:refreshSystem(systemId, isUnlock)
  local node = self.systemToTrans[systemId]
  local locker = node.locker
  for _, v in ipairs(node) do
    local isNeedShow = locker:tryShowOrHide(v, isUnlock)
    if isNeedShow then
      local lock = v:Find("lock")
      local unlock = v:Find("unlock")
      if lock then
        lock.gameObject:ActiveTrans(not isUnlock)
      end
      if unlock then
        unlock.gameObject:ActiveTrans(isUnlock)
      end
    end
  end
end

function this:initSharedChooseNode()
  if not string.isEmpty(sharedChoosePrefabPath) then
    local chooseGo = self.pool:syncGameObject(sharedChoosePrefabPath)
    if chooseGo then
      self.sharedChooseGo = chooseGo
      self.sharedChooseTrans = chooseGo:GetComponent(typeof(C_RectTransform))
      self.sharedChooseGo:SetActive(false)
      if self.bindComponents.entityNode then
        self.sharedChooseTrans:SetParent(self.bindComponents.entityNode.transform)
      end
    end
  end
  self.currentChooseNode = nil
end

function this:showChooseOnNode(mapNode)
  if not self.sharedChooseGo or not mapNode then
    return
  end
  self.currentChooseNode = mapNode
  mapNode:setChoose(self.sharedChooseTrans)
end

function this:hideChooseNode()
  if not self.sharedChooseGo then
    return
  end
  self.sharedChooseGo:SetActive(false)
  if self.bindComponents.entityNode then
    self.sharedChooseTrans:SetParent(self.bindComponents.entityNode.transform)
  end
  self.currentChooseNode = nil
end

function this:refreshChooseByNodeType(nodeType, selectedNodeId)
  if not self.nodeDic[nodeType] then
    return
  end
  local hasShown = false
  for k, v in pairs(self.nodeDic[nodeType]) do
    if selectedNodeId and v.id == selectedNodeId then
      self:showChooseOnNode(v)
      hasShown = true
      break
    end
  end
  if not hasShown then
    self:hideChooseNode()
  end
end

function this:initCenter(center)
  if center then
    self:focusTargetPoint(center)
  else
    self:focusPlayerPos()
  end
end

function this:open(options)
  if self.fromWorldArea == true then
    self.bindComponents.aniPage:Play("anim_bigmap_in")
  else
    self.bindComponents.aniPage:Play("anim_bigmap_open")
  end
  if self.unlockAreaNode ~= nil then
    self:setMapScale(0)
    if not self.unlockPrefabHandle then
      self.unlockPrefabHandle = C_UIMgr.uiLoader:Spawn(_unlockPrefabPath, self.bindComponents.unlockFXTrans)
      self.unlockPrefabHandle.name = "unlockFX"
    end
    self.bindComponents.pre_AreaMask_FX.gameObject:ActiveTrans(true)
    L_AudioUtil.playSound("Play_SFX_System_UI_Map_Mist_Dissipate")
    L_TimerManager:newOrResetTimer(self, "unlockAreaMask", function()
      self.unlockAreaNode:setEffectStatus(false)
    end, 1.4)
  end
  if options and options.openCallback then
    options.openCallback()
  end
end

function this:show()
  if self.mapData == nil then
    return
  end
  if self.mapData.sceneId == AzurWorldInstance.CurWorldId then
    self:checkShowNestCoopTip()
  end
end

function this:update()
  self:checkSelfPointIsOutScreen()
end

function this:close()
  AzurWorld.areaManager:UnregisterEvent(C_WorldAreaEventDefine.MapAreaChanged, self._MapAreaChangeHandler)
  L_MapStore:unListenCallFunc(L_MapStore.event.refreshNodeTrace, self.refreshNodeTraceState)
  L_MapStore:unListenCallFunc(L_MapStore.event.refreshExploreNodeTrace, self.refreshNodeTraceState)
  L_SceneStore:unListenCallFunc(L_SceneStore.event.refreshPoint, self.onEvent_refreshTransferNode)
  L_MapStore:unListenCallFunc(L_MapStore.event.refreshCollectionTrace, self.refreshCollectionTrace)
  L_HomeStore:unListenCallFunc(L_HomeStore.event.syncHomeContentUnlock, self.onEvent_refreshHomeAreaNode)
  L_PetDuelStore:unListenCallFunc(L_PetDuelStore.event.refresh_recordInfo, self.refreshPetDuelNodeState, self)
  L_WorldExploreStore:unListenCallFunc(L_WorldExploreStore.event.ExplorationSync, self.initMapExplore)
  C_InputManager.RemoveSingleAxisListener(C_InputManager.EInputSingleAxisType.EMainMouseScroll, self._mouseScrollWheelHandle)
  L_GuideManager:removeListener(G_GuideClasses.GuideEvent.RefreshWorldMarkFilter, self.onRefreshWorldMarkFilter, self)
  self.bind.show_nodeDetailPanel = false
  self.bind.moduleMapExplore_show = false
  self:configTouch("-")
  L_TimerManager:clearTimer(self)
  self:clearMap()
  if self.sharedChooseGo then
    C_BoundGameObject.Destroy(self.sharedChooseGo)
    self.sharedChooseGo = nil
    self.sharedChooseTrans = nil
    self.currentChooseNode = nil
  end
  self.pool:dispose()
  if self.unlockAreaNode ~= nil and self.unlockAreaNode.controlByUnlockEffect == true then
    self.bindComponents.pre_AreaMask_FX.gameObject:ActiveTrans(false)
    self.bindComponents.pre_AreaMask_anim:Stop()
    C_PrefabManager:RecycleByLoader(self.unlockPrefabHandle)
    self.unlockPrefabHandle = nil
  end
  if self.mats_areaMask then
    C_UnityObject.Destroy(self.mats_areaMask)
    self.mats_areaMask = nil
  end
  if self.mats_blackBg then
    C_UnityObject.Destroy(self.mats_blackBg)
    self.mats_blackBg = nil
  end
  if self.mats_outline1 then
    C_UnityObject.Destroy(self.mats_outline1)
    self.mats_outline1 = nil
  end
  if self.mats_outline2 then
    C_UnityObject.Destroy(self.mats_outline2)
    self.mats_outline2 = nil
  end
  if self.mats_outline3 then
    C_UnityObject.Destroy(self.mats_outline3)
    self.mats_outline3 = nil
  end
  if self.mats_outline4 then
    C_UnityObject.Destroy(self.mats_outline4)
    self.mats_outline4 = nil
  end
  self.unlockTexture = nil
  if self.cancelCollectionTraceBtn then
    self.cancelCollectionTraceBtn.onClick:RemoveAllListeners()
    self.cancelCollectionTraceBtn = nil
  end
  AzurWorld.TaskMgr:SetForceShowTaskId(-1)
end

function this:onEvent_refreshTransferNode()
  self:refreshAllNodeLockState(L_MapConst.mapSievingType.transfer)
end

function this:onEvent_refreshHomeAreaNode()
  self:refreshAllNodeLockState(L_MapConst.mapSievingType.homeArea)
end

function this:refreshPetDuelNodeState()
  if not table.isEmpty(self.nodeDic[L_MapConst.mapSievingType.npc]) then
    for _, node in pairs(self.nodeDic[L_MapConst.mapSievingType.npc]) do
      node:refreshState(self.mapData)
    end
  end
end

function this:clearAllTimer()
  for _, v in pairs(self.timers) do
    Timer.remove(v)
  end
  self.timers = {}
  if self.doTweenMap then
    self.doTweenMap:Kill()
  end
end

function this:initModule()
  self.modules.moduleMapPoint:initModule(self.mapData.areaId, self.bindComponents.rectSafeLd, self.bindComponents.rectSafeRu, 1 / self.mapData.imgScale, self.mapData)
  local str = string.format(L_ReddotManager.DotDef.WorldExplore, self.mapData.sceneId)
  L_ReddotManager:registerReddot(self.bindComponents.reddotExplore, str)
end

function this:initMode()
  local showTaskBtn = self.data.openMode ~= L_MapConst.OpenMode.UnlockHomeArea
  self.bind.go_btnTask_sw = showTaskBtn
  self.bind.go_btnTask = showTaskBtn
  self.bind.go_bottomRight = self.data.openMode ~= L_MapConst.OpenMode.UnlockHomeArea
  if self.data.openMode == L_MapConst.OpenMode.UnlockHomeArea then
    local homeList = self:getNodeList(L_MapConst.mapSievingType.homeArea)
    local tempMap = L_HomeStore:getTempUnlockBlock()
    local blockTpl = L_GameTpl:getHomeBlockTpl()
    local objMap = {}
    for id, v in pairs(tempMap) do
      local tpl = blockTpl:getTplById(id)
      local objId = blockTpl:getWorldMapId(tpl)
      objMap[objId] = true
    end
    local center
    local count = 0
    for _, v in pairs(homeList) do
      if objMap[v.entityId] then
        v:showUnlockEffect()
        if count == 0 then
          center = v.configPos
        else
          center = center + v.configPos
        end
        count = count + 1
      end
    end
    center = center and center / count
    return center
  elseif self.data.openMode == L_MapConst.OpenMode.UnlockAreaMask then
    for i, v in pairs(self.areaBlockDic.areaMask) do
      if v.order == self.data.param then
        v:setEffectStatus(true)
        self.unlockAreaNode = v
        break
      end
    end
    if self.unlockAreaNode then
      self.mats_areaMask = C_UnityObject.Instantiate(self.bindComponents.areaMask_material.material)
      self.mats_blackBg = C_UnityObject.Instantiate(self.bindComponents.blackBg_material.material)
      self.mats_outline1 = C_UnityObject.Instantiate(self.bindComponents.outline1_material.material)
      self.mats_outline2 = C_UnityObject.Instantiate(self.bindComponents.outline2_material.material)
      self.mats_outline3 = C_UnityObject.Instantiate(self.bindComponents.outline3_material.material)
      self.mats_outline4 = C_UnityObject.Instantiate(self.bindComponents.outline4_material.material)
      self.bindComponents.areaMask_material.material = self.mats_areaMask
      self.bindComponents.blackBg_material.material = self.mats_blackBg
      self.bindComponents.outline1_material.material = self.mats_outline1
      self.bindComponents.outline2_material.material = self.mats_outline2
      self.bindComponents.outline3_material.material = self.mats_outline3
      self.bindComponents.outline4_material.material = self.mats_outline4
      self.unlockTexture = C_LuaUtility.LoadTexture(self.unlockAreaNode.iconPath, nil)
      self.mats_areaMask:SetTexture("_MainTex", self.unlockTexture)
      self.mats_blackBg:SetTexture("_MainTex", self.unlockTexture)
      self.mats_outline1:SetTexture("_MaskTex", self.unlockTexture)
      self.mats_outline2:SetTexture("_MainTex", self.unlockTexture)
      self.mats_outline3:SetTexture("_MainTex", self.unlockTexture)
      self.mats_outline4:SetTexture("_MainTex", self.unlockTexture)
      return self.unlockAreaNode.configPos
    end
  end
end

function this:initMap(areaId)
  if not areaId or areaId < 0 then
    return
  end
  self:initMapData(areaId)
  local isRandomDungeon = false
  self.modules.module_randomDungeonMap.gameObject:ActiveTrans(isRandomDungeon)
  self.mapBuilder = L_MapManager:createMapBuilder(self.mapData)
  self.mapBuilder:paint(self.bindComponents.imgMap)
  local tpl = _worldAreaTpl:getTplById(self.mapData.areaId)
  local isCut = _worldAreaTpl:getIsCut(tpl)
  if self.mapData.isStream and isCut then
    self.mapBuilder:setTargetTrans(self.bindComponents.mapShowRect)
  end
  if isRandomDungeon then
    self:setRandomDungeonMapInit()
  else
    self:setMapInit(areaId)
  end
  self:initAllMapNode(areaId)
  self:setInitPosition()
  self:refreshWorldLevel()
  self:initMapExplore()
  self.modules.moduleMapLv:RefreshByMapId(self.mapData.sceneId, areaId)
  self.modules.moduleMapExplore:setMapExploreData(self.mapData.sceneId)
end

function this:refreshWorldLevel()
end

function this:initMapExplore()
  local exploreData = _exploreTpl:getExploreTplByMapId(self.mapData.sceneId)
  if table.isEmpty(exploreData) then
    self.bind.mapExploreEntry = false
    return
  end
  self.bind.mapExploreEntry = true
  local exploreInfo = L_WorldExploreStore:getExploreInfo(self.mapData.sceneId)
  local curStatus = mapExploreIconStatus.processing
  local curLevel = exploreInfo.lv or 1
  local param = levelText[curLevel] or levelText[1]
  self.bind.txt_exploreLv = L_WordsTpl:getValue("notice_pageBigMap_03", {
    [0] = param
  })
  local allTpl = _exploreLevelTpl:getExploreRewardTplByMapId(self.mapData.sceneId)
  if curLevel >= #allTpl then
    curStatus = mapExploreIconStatus.finish
  else
    local tpl = _exploreLevelTpl:getExploreRewardTplByMapId(self.mapData.sceneId, curLevel + 1)
    self.bind.process = (exploreInfo.exp or 0) / _exploreLevelTpl:getExp(tpl)
  end
  local rewardIds = {}
  for i, v in pairs(allTpl) do
    if curLevel >= _exploreLevelTpl:getLv(v) then
      rewardIds[_exploreLevelTpl:getId(v)] = _exploreLevelTpl:getId(v)
    end
  end
  if L_WorldExploreStore:getExploreHaveRewards(rewardIds, self.mapData.sceneId) then
    curStatus = mapExploreIconStatus.reward
  end
  self.bind.rewardsOn = curStatus == mapExploreIconStatus.reward
  self.bind.finishOn = curStatus == mapExploreIconStatus.finish
  self.bind.processingOn = curStatus == mapExploreIconStatus.processing
end

function this:initMapData(areaId)
  local tpl = _worldAreaTpl:getTplById(areaId)
  local curAreaId = areaId
  if string.isEmpty(_worldAreaTpl:getAreaMap(tpl)) then
    local sceneId = _worldAreaTpl:getSceneId(tpl)
    local list = {}
    for i, v in pairs(_worldAreaTpl:getAllArea(sceneId)) do
      table.insert(list, v)
    end
    table.sort(list, function(a, b)
      return _worldAreaTpl:getId(a) < _worldAreaTpl:getId(b)
    end)
    curAreaId = _worldAreaTpl:getId(list[1])
  end
  self.mapData = L_MapManager:createMapData(curAreaId)
  self.mapData.isStream = true
  self.bind.mapDirection = C_Vector3(0, 0, -self.mapData.mapDirection)
  local rect = self.bindComponents.mapShowRect.rect
  self.mapData:setShowSize(rect.width / 2, rect.height / 2)
  L_Vector3.setSize(self.bindComponents.imgMap, self.mapData.imgScale)
  L_Vector3.setAnchored(self.bindComponents.imgMap, L_Vector3.zero)
end

function this:clearMap()
  self:clearAllTimer()
  self:clearAllNode()
  if self.mapBuilder then
    self.mapBuilder:removePaint()
    self.mapBuilder:onDestroy()
  end
end

function this:setMapInit(areaId)
  local tpl = _worldAreaTpl:getTplById(self.mapData.areaId)
  if tpl then
    self.mapScale = L_GameConstTpl:getData("MAP_ENTER_SCALE", L_Const.GameTplType.float) or 0
    self.mapData:checkResolutionRatio()
    self:setMapScale(self.mapScale)
  end
  local truetpl = _worldAreaTpl:getTplById(areaId)
  if truetpl then
    local sceneId = _worldAreaTpl:getSceneId(truetpl)
    local id = _worldAreaTpl:getId(truetpl)
    local areaData = _areaTpl:getConfig()
    for i, v in ipairs(areaData) do
      if _areaTpl:getWorldAreaId(v) == id and _areaTpl:getSceneId(v) == sceneId then
        self.bind.txtTitle = _areaTpl:getAreaName(v)
        return
      end
    end
    self.bind.txtTitle = _worldAreaTpl:getName(truetpl)
  end
end

function this:setRandomDungeonMapInit()
  local dungeonTpl = L_GameTpl:getDungeonTpl()
  local tpl = dungeonTpl:getTplById(AzurWorld.DungeonMgr.DungeonID)
  self.bind.txtTitle = dungeonTpl:getName(tpl)
  self.modules.module_randomDungeonMap:initModule(AzurWorldInstance.CurWorldId)
  self.bindComponents.imgMap.sizeDelta = self.mapData.imgSize
end

function this:setInitPosition()
  if self.data.birthPoint == nil then
    return
  end
  local tpl = _worldPointTpl:getTplById(self.data.birthPoint)
  local position = _worldPointTpl:getPosition(tpl)
  local w2L = self.mapData:worldToLocal(position)
  self:setMapPosition(w2L)
end

function this:setMapPosition(deltaPos)
  if self.bMovingAnim then
    return
  end
  local imgPos = L_Vector3.getAnchored(self.bindComponents.imgMap)
  imgPos.x = imgPos.x + deltaPos.x
  imgPos.y = imgPos.y + deltaPos.y
  imgPos = self.mapData:clampImgPos(imgPos)
  L_Vector3.setAnchored(self.bindComponents.imgMap, imgPos)
  self:refreshAllNodePos()
end

function this:setMapScale(value)
  self.mapData:setSlider(value)
  self.mapBuilder.painter:onSlider(self.mapData.imgScale)
  self.bind.value_sliderScale = value
  local size = L_Vector3.getSize(self.bindComponents.imgMap)
  local pos = L_GameUtil.spToLpInRectangle(self.bindComponents.imgMap, self.mapData.showSize)
  local offset = pos * (size - self.mapData.imgScale)
  L_Vector3.setSize(self.bindComponents.imgMap.transform, self.mapData.imgScale)
  self:setMapPosition(offset)
  self.modules.moduleMapPoint:setScale(self.mapData)
  for nodeType, list in pairs(self.nodeDic) do
    if nodeType == L_MapConst.mapSievingType.mapFxEffect then
      for _, node in pairs(list) do
        node:refreshScope(value, ratio)
      end
    end
  end
end

function this:initAllMapNode(areaId)
  local mapManager = L_MapManager
  local aeraBlockDict = self.areaBlockDic
  local maskNodeTrans = self.bindComponents.mapMaskNode.transform
  local noMaskNodeTrans = self.bindComponents.noMaskNode.transform
  local entityNodeTrans = self.bindComponents.entityNode.transform
  local sceneId = self.mapData.sceneId
  self.initAllFinished = false
  self.nodeDic = mapManager:getMapNodeDic(sceneId, true)
  aeraBlockDict.areaBlock = mapManager:getMapAreaBlockList(sceneId, aeraBlockDict.areaBlock)
  aeraBlockDict.miniAreaBlock = mapManager:getMiniAreaBlockList(sceneId, aeraBlockDict.miniAreaBlock)
  aeraBlockDict.sceneBorderTransfer = mapManager:getAllSceneBorderTransferNode(sceneId, aeraBlockDict.sceneBorderTransfer)
  aeraBlockDict.areaMask = mapManager:getMapAreaMask(sceneId, aeraBlockDict.areaMask)
  aeraBlockDict.areaBoundary = mapManager:getMapAreaBoundary(self.mapData.areaId, aeraBlockDict.areaBoundary)
  if self.isAccess then
    self.isAccess = nil
    for _, v in pairs(aeraBlockDict.areaMask) do
      local aId = AzurWorld.WorldMapMgr:GetItemAreaId(v.cityId, v.worldMapId)
      if aId == self.isAccessAreaId and not v.isUnLock then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getTplById("notice_commonjump_lock_map"), 3)
      end
    end
  end
  for nodeType, list in pairs(self.nodeDic) do
    for _, v in ipairs(list) do
      v.mapAreaName = self.bind.txtTitle
      if mapManager:checkIsNoMaskNode(nodeType) then
        v:generate(noMaskNodeTrans, self.pool)
      else
        v:generate(entityNodeTrans, self.pool)
      end
      if v.id == self.data.id and v.type == self.data.nodeType then
        self:showChooseOnNode(v)
      end
      if mapManager:checkIsNoMaskNode(nodeType) then
        v:addClick(function()
          self:checkSurroundingNodes(v, true)
        end)
      else
        v:addClick(function()
          self:checkSurroundingNodes(v)
        end)
      end
    end
  end
  local trackNode = self:getNodeList(L_MapConst.mapSievingType.kiboGroup)
  if 0 < #trackNode then
    self.isJumpFromCatalog = true
    self:triggerMapNode(trackNode[1])
  end
  self.beforeRefresh = true
  self:refreshCollectionTrace()
  self.beforeRefresh = false
  if table.isEmpty(aeraBlockDict.areaMask) then
    maskNodeTrans.gameObject:ActiveTrans(false)
  else
    maskNodeTrans.gameObject:ActiveTrans(true)
  end
  for i, list in pairs(aeraBlockDict) do
    for _, v in ipairs(list) do
      if v.type == L_MapConst.mapSievingType.areaMask or v.type == L_MapConst.mapSievingType.areaBoundary then
        v:generate(maskNodeTrans, self.pool)
      else
        v:generate(entityNodeTrans, self.pool)
      end
    end
  end
  self:refreshAllNodeLockState()
  self:refreshAllNodeState()
  self:refreshAllNodePos()
  self:refreshNodeTraceState()
  self.initAllFinished = true
end

function this:generateSingleNode(node, type)
  node.mapAreaName = self.bind.txtTitle
  if L_MapManager:checkIsNoMaskNode(type) then
    node:generate(self.bindComponents.noMaskNode.transform, self.pool)
  else
    node:generate(self.bindComponents.entityNode.transform, self.pool)
  end
  if node.id == self.data.id and node.type == self.data.nodeType then
    self:showChooseOnNode(node)
  end
  if L_MapManager:checkIsNoMaskNode(type) then
    node:addClick(function()
      self:checkSurroundingNodes(node, true)
    end)
  else
    node:addClick(function()
      self:checkSurroundingNodes(node)
    end)
  end
end

function this:refreshCollectionTrace()
  local mapCollectionTraceId = L_MapStore:getCurTraceCollectionId()
  if math.isEmpty(mapCollectionTraceId) then
    self:clearNode(L_MapConst.mapSievingType.mapCollectionItem)
    self:showCollectionTraceTip(false)
    return
  end
  local list = self:getNodeList(L_MapConst.mapSievingType.mapCollectionItem)
  if not table.isEmpty(list) then
    if list[1].id ~= mapCollectionTraceId then
      self:clearNode(L_MapConst.mapSievingType.mapCollectionItem)
      self:generateMapCollectionItem(mapCollectionTraceId)
    end
  else
    self:generateMapCollectionItem(mapCollectionTraceId)
  end
end

function this:generateMapCollectionItem(mapCollectionTraceId)
  local focused = false
  local datas = L_MapManager:getCurMapCollectionItemNode(self.mapData.sceneId, mapCollectionTraceId)
  for _, v in ipairs(datas) do
    v.mapAreaName = self.bind.txtTitle
    if L_MapManager:checkIsNoMaskNode(L_MapConst.mapSievingType.mapCollectionItem) then
      v:generate(self.bindComponents.noMaskNode.transform, self.pool)
    else
      v:generate(self.bindComponents.entityNode.transform, self.pool)
    end
    if v.id == self.data.id and v.type == self.data.nodeType then
      self:showChooseOnNode(v)
    end
    v:addClick(function()
      self:checkSurroundingNodes(v)
    end)
    v:refreshPosByMapData(self.mapData)
    v:refreshLockState()
    local serverData = AzurWorld.service.map:GetServerData(v.id, self.mapData.sceneId)
    if not serverData or not serverData.complete then
      v.hideNode = false
      if not focused and self.initAllFinished then
        self:focusTargetPoint(v.configPos)
        focused = true
      end
    else
      v.hideNode = true
    end
    v:refreshState(self.mapData)
  end
  self.nodeDic[L_MapConst.mapSievingType.mapCollectionItem] = datas
  if 0 < #datas then
    self:setMapCollectionTraceTip(true, datas[1])
    if not self.beforeRefresh then
      self:showNodeDetail(datas[1])
    end
  end
end

function this:setMapCollectionTraceTip(bool, nodeInfo)
  if bool then
    self:showCollectionTraceTip(true, L_Lang:get(L_WordsTpl:getValue("ui_world_collecting"), {
      [1] = nodeInfo.name
    }) .. "..")
  else
    self:showCollectionTraceTip(false)
    L_FlyMsgManager:showNormalMsg(L_Lang:get(L_WordsTpl:getValue("ui_world_collect_cance_track_tips"), {
      [1] = nodeInfo.name
    }))
    L_MapStore:setMapCollectionTrace(nil)
    L_MapStore:disposeCollectionTrace()
  end
end

function this:getNodeList(nodeType)
  return self.nodeDic[nodeType]
end

function this:clearAllNode()
  for nodeType, v in pairs(self.nodeDic) do
    self:clearNode(nodeType)
  end
  for _, list in pairs(self.areaBlockDic) do
    for _, v in pairs(list) do
      v:onDestroy()
    end
  end
  self.areaBlockDic = {}
end

function this:clearNode(nodeType)
  local list = self.nodeDic[nodeType]
  if list then
    for _, v in ipairs(list) do
      v:onDestroy()
    end
    self.nodeDic[nodeType] = {}
  end
end

function this:checkSurroundingNodes(mapNode, needCheckMask)
  if self.mapPointDelete then
    return
  end
  local sceneId = self.mapData.sceneId
  if needCheckMask then
    local list = _worldFilterMarkTpl:getTplListByWorldId(sceneId, L_MapConst.mapSievingType.transfer)
    local areaMaskDict = {}
    for _, tpl in ipairs(list) do
      local wpTpl = _worldMapTpl:getTplById(sceneId, _worldFilterMarkTpl:getWorldmapId(tpl))
      if wpTpl then
        local birthPosId = _worldFilterMarkTpl:getPosId(tpl)
        local isUnLock = L_SceneStore:getPointIsUnlock(birthPosId)
        local cityId = _worldFilterMarkTpl:getWorldId(tpl)
        local worldMapId = _worldFilterMarkTpl:getWorldmapId(tpl)
        local areaId = AzurWorld.WorldMapMgr:GetItemAreaId(cityId, worldMapId)
        areaMaskDict[areaId] = isUnLock
      end
    end
    if mapNode.worldMapId then
      local nodeAreaId = AzurWorld.WorldMapMgr:GetItemAreaId(sceneId, mapNode.worldMapId)
      if not areaMaskDict[nodeAreaId] then
        self:triggerMapNode(mapNode)
        return
      end
    else
      local nodeAreaId = AzurWorld.WorldMapMgr:GetItemAreaIdWithPos(sceneId, Unity.Vector3(mapNode.configPos.x, mapNode.configPos.y, mapNode.configPos.z))
      if not areaMaskDict[nodeAreaId] then
        self:triggerMapNode(mapNode)
        return
      end
    end
  end
  local curScreenPos = mapNode:getNodeScreenPos(self.bindComponents.mapShowRect)
  local suroundingNodes = {}
  for _, list in pairs(self.nodeDic) do
    for _, v in ipairs(list) do
      if v.id ~= mapNode.id or v.type ~= mapNode.type then
        local suroundingPos = v:getNodeScreenPos(self.bindComponents.mapShowRect)
        if suroundingPos ~= nil then
          local x = curScreenPos.x - suroundingPos.x
          local y = curScreenPos.y - suroundingPos.y
          local distance = x * x + y * y
          if distance <= 4225 then
            table.insert(suroundingNodes, v)
          end
        end
      end
    end
  end
  local suroundingSelfNodes = self.modules.moduleMapPoint:checkStaticNodeRange(curScreenPos, self.bindComponents.mapShowRect)
  if table.isEmpty(suroundingNodes) and table.isEmpty(suroundingSelfNodes) then
    self:triggerMapNode(mapNode)
  else
    local tmp = {}
    for i, v in pairs(suroundingNodes) do
      table.insert(tmp, {
        type = v.type,
        nodeData = v,
        onClick = function()
          self:closeInteractive()
          self:triggerMapNode(v)
        end
      })
    end
    for i, v in pairs(suroundingSelfNodes) do
      table.insert(tmp, {
        type = v.type,
        nodeData = v,
        onClick = function()
          self:closeInteractive()
          self:setMarkPanelPos(false, v.guid, v.markId)
          self.modules.moduleMapPoint:refreshChoosePoint(v.guid)
        end
      })
    end
    self:sortNodeLayer(tmp)
    table.insert(tmp, 1, {
      type = mapNode.type,
      nodeData = mapNode,
      onClick = function()
        self:closeInteractive()
        self:triggerMapNode(mapNode)
      end
    })
    self:setCurStaticNode(mapNode)
    self:refreshInteractive(tmp)
    self.bind.showMapInteractive = true
  end
end

function this:setCurStaticNode(mapNode)
  local type = mapNode:getType()
  self.bind.show_nodeDetailPanel = false
  if self.data.nodeType ~= nil then
    if changeToNpcType[self.data.nodeType] == 1 then
      self.data.nodeType = L_MapConst.mapSievingType.npc
    end
    self:hideChooseNode()
  end
  if changeToNpcType[type] == 1 then
    type = L_MapConst.mapSievingType.npc
  end
  local centerPos = {
    [1] = mapNode.configPos.x,
    [2] = mapNode.configPos.y,
    [3] = mapNode.configPos.z
  }
  self:focusAreaCenter(centerPos, 0.3)
  self.data.nodeType = type
  self.data.id = mapNode.id
  if self.data.nodeType ~= nil then
    self:showChooseOnNode(mapNode)
  end
  self:playNodeAudio(type)
end

function this:checkSelfPointSurroundingNodes(uiPos, suroundingSelfNodes, curSelfNode)
  if self.mapPointDelete then
    self.mapPointDelete:ToggleSeletedNode(curSelfNode.guid)
    return
  end
  local curScreenPos = uiPos
  local suroundingNodes = {}
  for _, list in pairs(self.nodeDic) do
    for _, v in ipairs(list) do
      local suroundingPos = v:getNodeScreenPos(self.bindComponents.mapShowRect)
      if suroundingPos ~= nil then
        local x = curScreenPos.x - suroundingPos.x
        local y = curScreenPos.y - suroundingPos.y
        local distance = x * x + y * y
        if distance <= 4225 then
          table.insert(suroundingNodes, v)
        end
      end
    end
  end
  if table.isEmpty(suroundingNodes) and table.isEmpty(suroundingSelfNodes) then
    self:setMarkPanelPos(false, curSelfNode.guid, curSelfNode.markId)
  else
    local tmp = {}
    for i, v in pairs(suroundingNodes) do
      table.insert(tmp, {
        type = v.type,
        nodeData = v,
        onClick = function()
          self:closeInteractive()
          self:triggerMapNode(v)
        end
      })
    end
    for i, v in pairs(suroundingSelfNodes) do
      table.insert(tmp, {
        type = v.type,
        nodeData = v,
        onClick = function()
          self:closeInteractive()
          self:setMarkPanelPos(false, v.guid, v.markId)
          self.modules.moduleMapPoint:refreshChoosePoint(v.guid)
        end
      })
    end
    self:sortNodeLayer(tmp)
    table.insert(tmp, 1, {
      type = curSelfNode.type,
      nodeData = curSelfNode,
      onClick = function()
        self:closeInteractive()
        self:setMarkPanelPos(false, curSelfNode.guid, curSelfNode.markId)
        self.modules.moduleMapPoint:refreshChoosePoint(curSelfNode.guid)
      end
    })
    self:refreshInteractive(tmp)
    self.bind.showMapInteractive = true
  end
end

local TempTriggerNodeConfig = {
  [200940] = {
    pos = {
      -242.866,
      106.22,
      -188.999
    },
    scale = 0.35
  }
}

function this:handleTempTriggerMapNode(mapNode)
  local cfg = TempTriggerNodeConfig[mapNode.id]
  if not cfg then
    return false
  end
  if cfg.scale ~= nil then
    self:setMapScale(cfg.scale)
  end
  if cfg.pos ~= nil then
    self:focusAreaCenter(cfg.pos, 0.3)
  end
  return true
end

function this:triggerMapNode(mapNode)
  local type = mapNode:getType()
  if type == L_MapConst.mapSievingType.target then
    L_MapStore:removeTarget()
  else
    self:setCurStaticNode(mapNode)
    self:showNodeDetail(mapNode)
  end
end

function this:triggerSpecialPetMapNodeInOpen(mapNode)
  local type = mapNode:getType()
  if type == L_MapConst.mapSievingType.target then
    L_MapStore:removeTarget()
  else
    self:setCurStaticNode(mapNode)
    self:showNodeDetail(mapNode)
  end
end

function this:onRefreshWorldMarkFilter(data)
  local taskNodeList = self:getNodeList(data.targetParam[1])
  for _, v in ipairs(taskNodeList) do
    if v.id == data.targetParam[2] then
      self:triggerMapNode(v)
      break
    end
  end
end

function this:setMarkPanelPos(isNew, guid, markId, posInfo)
  if self.data.nodeType ~= nil then
    self.methods.onClick_closeNodeDetail(self)
  end
  self:activeDetailPanel(true)
  self.bind.toggleModuleName = "moduleMapPointPanel"
  self.modules.toggleModule.moduleMapPointPanel:initModule(self.mapData.areaId, self.curModule)
  if isNew then
    self.modules.toggleModule.moduleMapPointPanel:setMark(posInfo.markPos, posInfo.worldPos)
  end
  self.modules.toggleModule.moduleMapPointPanel:setMarkPanelPos(isNew, guid, markId)
end

function this:refreshMarkIconClient(id)
  self.modules.moduleMapPoint:refreshMarkIconClient(id)
end

function this:closePointPanel()
  self.modules.moduleMapPoint:initMarkPoint()
  self.modules.moduleMapPoint:refreshSelfMarkState(self.mapData:getFilter(), true)
end

function this:showNodeDetail(node)
  self.transferData = nil
  local sceneId = node.sceneId or AzurWorldInstance.CurWorldId
  local name = node.name
  self:activeDetailPanel(true)
  if TypeToModuleName[node.type] then
    self.bind.toggleModuleName = TypeToModuleName[node.type]
    self.modules.toggleModule[TypeToModuleName[node.type]]:initModule(node)
  else
    self.bind.toggleModuleName = "moduleMapCommonInfo"
    self.modules.toggleModule.moduleMapCommonInfo:initModule(node)
  end
  self.transferData = {
    sceneId = sceneId,
    type = node.type,
    node = node,
    name = name
  }
  if self.isJumpFromCatalog and node.type == L_MapConst.mapSievingType.kiboGroup then
    self:excuteNodeFunction()
    self.isJumpFromCatalog = false
  end
end

function this:excuteNodeFunction()
  if table.isEmpty(self.transferData) then
    return
  end
  local sceneId = self.transferData.sceneId
  local node = self.transferData.node
  if node.type == L_MapConst.mapSievingType.transfer then
    if node.isUnLock == true then
      L_SceneStore:transferToPoint(sceneId, node.id, C_LoginManager.lineId, function()
        L_UI:close("pageBigMap")
      end)
    elseif sceneId == AzurWorldInstance.CurWorldId then
      if node.type == L_MapConst.mapSievingType.task then
        L_TaskStore:setTraceTask(node.id)
      else
        L_MapStore:setNodeTargetTracing(sceneId, node)
      end
    else
      local content = L_WordsTpl:getValue("ui_chuansong_des_1", {
        [0] = node.mapAreaName
      })
      local data = {
        txtContent = content,
        confirmCallback = function()
          if node.type == L_MapConst.mapSievingType.task then
            L_TaskStore:setTraceTask(node.id)
          else
            L_MapStore:setNodeTargetTracing(sceneId, node)
          end
          L_SceneStore:transferToPoint(sceneId, node.id, C_LoginManager.lineId, function()
            L_UI:close("pageBigMap")
          end)
        end
      }
      L_GameUtil.showCommonTip(data)
    end
  elseif L_MapManager:getCanTelePortNodeEnum()[node.type] == 1 then
    if node.isUnLock == true then
      L_SceneStore:transferToPoint(sceneId, node.id, C_LoginManager.lineId, function()
        L_UI:close("pageBigMap")
      end)
    else
      self:traceNodeLogic(sceneId, node)
    end
  else
    self:traceNodeLogic(sceneId, node)
  end
end

function this:traceNodeLogic(sceneId, node)
  local nearestNode = self:getNearestNode(sceneId, node)
  if sceneId == AzurWorldInstance.CurWorldId then
    if node.type == L_MapConst.mapSievingType.task then
      L_TaskStore:setTraceTask(node.id)
    else
      L_MapStore:setNodeTargetTracing(sceneId, node)
    end
  else
    if table.isEmpty(nearestNode) then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("bigworld_unlock_zhuizong"))
      return
    end
    local content = L_WordsTpl:getValue("ui_chuansong_des_1", {
      [0] = node.mapAreaName
    })
    local data = {
      txtContent = content,
      confirmCallback = function()
        if node.type == L_MapConst.mapSievingType.task then
          L_TaskStore:setTraceTask(node.id)
        else
          L_MapStore:setNodeTargetTracing(sceneId, node)
        end
        L_SceneStore:transferToPoint(sceneId, nearestNode.id, C_LoginManager.lineId, function()
          L_UI:close("pageBigMap")
        end)
      end
    }
    L_GameUtil.showCommonTip(data)
  end
end

function this:teleportNodeLogic()
  if table.isEmpty(self.transferData) then
    return
  end
  local sceneId = self.transferData.sceneId
  local node = self.transferData.node
  local nearestNode = self:getNearestNode(sceneId, node)
  if table.isEmpty(nearestNode) then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("bigworld_unlock_zhuizong"))
    return
  end
  local content = ""
  if sceneId == AzurWorldInstance.CurWorldId then
    content = L_WordsTpl:getValue("notice_task_goto")
  else
    content = L_WordsTpl:getValue("ui_chuansong_des_1", {
      [0] = node.mapAreaName
    })
  end
  local data = {
    txtContent = content,
    confirmCallback = function()
      L_SceneStore:transferToPoint(sceneId, nearestNode.id, C_LoginManager.lineId, function()
      end, nil, true)
    end
  }
  L_GameUtil.showCommonTip(data)
end

function this:getNearestNode(sceneId, node)
  local transferNodeList = {}
  for i, v in pairs(L_MapManager:getAllTransferNode(sceneId)) do
    if v.isUnLock == false then
    else
      table.insert(transferNodeList, v)
    end
  end
  local nearestNode
  if 0 < #transferNodeList then
    for i, v in pairs(transferNodeList) do
      if nearestNode == nil then
        nearestNode = v
      else
        local distance1 = L_Vector3.distance(v.configPos, node.configPos)
        local distance2 = L_Vector3.distance(nearestNode.configPos, node.configPos)
        if distance1 < distance2 then
          nearestNode = v
        end
      end
    end
    return nearestNode
  end
  if table.isEmpty(transferNodeList) then
    nearestNode = L_MapManager:getMainBorthNode(sceneId)
    if nearestNode then
      return nearestNode
    end
  end
  local nodeList = L_MapManager:getVoidTransferNode(sceneId)
  for i, v in pairs(nodeList) do
    if nearestNode == nil then
      nearestNode = v
    else
      local distance1 = L_Vector3.distance(v.configPos, node.configPos)
      local distance2 = L_Vector3.distance(nearestNode.configPos, node.configPos)
      if distance1 < distance2 then
        nearestNode = v
      end
    end
  end
  return nearestNode
end

function this:choiceSelfNode(position)
  if L_MapManager:getEnableMark() == false then
    return
  end
  local pos = L_GameUtil.spToLpInRectangle(self.bindComponents.imgMap, position)
  local worldPos = self.mapData:localToWorld(pos)
  worldPos.y = 0
  local height = _worldAreaTpl:getHeight(_worldAreaTpl:getTplById(self.mapData.areaId))
  local bSuccess, gotPos = C_NavMeshManager.VerticalSamplePosition(worldPos + L_Vector3.getTemp(0, height, 0), Unity.AI.NavMesh.AllAreas, height * 20, 0.05)
  if not bSuccess then
    local playerPos = L_PlayerManager:getMainControlEntityPos()
    gotPos = worldPos
    gotPos.y = playerPos.y
    bSuccess = true
  end
  L_AudioUtil.playSound("Play_SFX_System_UI_Map_General_Click")
  self.modules.moduleMapPoint:setMark(pos, bSuccess and gotPos or {
    x = worldPos.x,
    z = worldPos.z
  })
end

function this:gmPointTeleport(position)
  if not debugActions.enableMapPointTeleport then
    return
  end
  local pos = L_GameUtil.spToLpInRectangle(self.bindComponents.imgMap, position)
  local worldPos = self.mapData:localToWorld(pos)
  worldPos.y = 0
  local height = _worldAreaTpl:getHeight(_worldAreaTpl:getTplById(self.mapData.areaId))
  local bSuccess, gotPos = C_NavMeshManager.VerticalSamplePosition(worldPos + L_Vector3.getTemp(0, height, 0), Unity.AI.NavMesh.AllAreas, height * 20, 0.05)
  if not bSuccess then
    L_FlyMsgManager:showNormalMsg("该地为不合法地表，禁止传送")
    return
  end
  local tpPos = bSuccess and gotPos or worldPos
  if not tpPos then
    return
  end
  local msg = {
    command = "SameMapTeleport",
    args = {
      tostring(tpPos.x * 100),
      tostring(tpPos.y * 100),
      tostring(tpPos.z * 100)
    }
  }
  L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg, nil)
end

function this:refreshAllNodeLockState(mapType)
  if mapType then
    local transferList = self:getNodeList(mapType)
    for _, v in ipairs(transferList) do
      v:refreshLockState()
    end
    if mapType == L_MapConst.mapSievingType.transfer then
      for i, node in ipairs(self.areaBlockDic.areaMask) do
        node:refreshLockState()
      end
    end
  else
    for _, v in pairs(self.nodeDic) do
      for _, node in pairs(v) do
        node:refreshLockState()
      end
    end
    for i, node in ipairs(self.areaBlockDic.areaMask) do
      node:refreshLockState()
    end
  end
end

function this:refreshAllNodeState()
  for _, v in pairs(self.nodeDic) do
    for _, node in pairs(v) do
      node:refreshState(self.mapData)
    end
  end
  for _, list in pairs(self.areaBlockDic) do
    for _, node in pairs(list) do
      node:refreshState(self.mapData)
    end
  end
end

function this:refreshAllNodePos()
  for _, v in pairs(self.nodeDic) do
    for _, node in pairs(v) do
      if not self.isDragInMapPos then
        node:refreshPosByMapData(self.mapData)
        node:refreshState(self.mapData)
      end
    end
  end
  for _, list in pairs(self.areaBlockDic) do
    for _, node in pairs(list) do
      if not self.isDragInMapPos then
        node:refreshPosByMapData(self.mapData)
        node:refreshState(self.mapData)
      end
    end
  end
  self:refreshPlayerNodePos()
end

function this:refreshNodeTraceState()
  for _, v in pairs(self.nodeDic) do
    for _, node in pairs(v) do
      node:refreshNodeTraceState()
    end
  end
  if table.isEmpty(L_MapStore:getCurNodeTargetTracing()) then
    self:clearNode(L_MapConst.mapSievingType.homeTrace)
  end
  if table.isEmpty(L_MapStore:getCurExploreNodeTargetTracing()) then
    self:clearNode(L_MapConst.mapSievingType.explore)
  end
end

function this:refreshTaskNodeState()
  if not table.isEmpty(self.nodeDic[L_MapConst.mapSievingType.task]) then
    for _, node in pairs(self.nodeDic[L_MapConst.mapSievingType.task]) do
      node:refreshNodeTraceState()
    end
  end
end

function this:refreshPlayerNodePos()
  local mainControl = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(false)
  if mainControl == nil then
    self.bindComponents.player.gameObject:ActiveTrans(false)
    return
  end
  if self.mapData.sceneId ~= AzurWorldInstance.CurWorldId then
    self.bindComponents.player.gameObject:ActiveTrans(false)
    return
  end
  self.bindComponents.player.gameObject:ActiveTrans(true)
  local pos = L_PlayerManager:getMainControlEntityPos()
  local rot = L_PlayerManager:getMainControlEntityRot()
  local w2l = self.mapData:worldToLocal(pos)
  L_Vector3.setAnchored(self.bindComponents.player, w2l)
  L_Vector3.setRot(self.bindComponents.playerDir, L_Vector3.getTemp(0, 0, -rot.y + self.mapData.zRot))
  self.bind.selfAngle = L_Vector3.new(0, 0, -rot.y + self.mapData.zRot)
  L_Vector3.setSize(self.bindComponents.playerDir, 1 / self.mapData.imgScale)
  local camTrans = C_CameraManager.mainCamera.transform
  L_Vector3.setRot(self.bindComponents.cameraDir.transform, L_Vector3.getTemp(0, 0, -camTrans.eulerAngles.y + self.mapData.zRot))
end

function this:checkSelfPointIsOutScreen()
  if self.mapData.areaId ~= AzurWorld.areaManager:GetMapAreaId() then
    self.bindComponents.playerTarget.gameObject:ActiveTrans(false)
    return
  end
  local screenPos = C_CameraManager.uiCamera:WorldToScreenPoint(self.bindComponents.player.position)
  if screenPos.x <= self.judgeWidth and screenPos.x >= 0 and screenPos.y <= self.judgeHeight and 0 <= screenPos.y then
    self.bindComponents.playerTarget.gameObject:ActiveTrans(false)
    return
  end
  local target = (screenPos - self.middlePoint).normalized
  local cos = math.clamp(L_Vector3.dot(target, self.vector_up), -1, 1)
  local deg = math.acos(cos) * (180 / math.pi)
  local cross = self.vector_up.x * target.y - self.vector_up.y * target.x
  if cross < 0 then
    deg = -deg
  end
  _tmpPos.z = deg
  self.bind.arrowAngle = _tmpPos
  self.bindComponents.playerTarget.gameObject:ActiveTrans(true)
  local k = (screenPos.y - self.middlePoint.y) / (screenPos.x - self.middlePoint.x)
  if screenPos.y > self.judgeHeight - screenOffset then
    screenPos.y = self.judgeHeight - screenOffset
    screenPos.x = self.middlePoint.x + (screenPos.y - self.middlePoint.y) / k
  elseif screenPos.y < screenOffset then
    screenPos.y = screenOffset
    screenPos.x = self.middlePoint.x + (screenPos.y - self.middlePoint.y) / k
  end
  if screenPos.x > self.judgeWidth - screenOffset then
    screenPos.x = self.judgeWidth - screenOffset
    screenPos.y = self.middlePoint.y + (screenPos.x - self.middlePoint.x) * k
  elseif screenPos.x < screenOffset then
    screenPos.x = screenOffset
    screenPos.y = self.middlePoint.y + (screenPos.x - self.middlePoint.x) * k
  end
  _tmpVec2.x = screenPos.x
  _tmpVec2.y = screenPos.y
  local rect = self.bindComponents.mapShowRect
  local _, uiPos = _screenPosToUI(rect, _tmpVec2, C_CameraManager.uiCamera)
  L_Vector3.setAnchored(self.bindComponents.playerTarget, uiPos)
end

function this:focusPlayerPos()
  if self.mapData.sceneId ~= AzurWorldInstance.CurWorldId then
    self:initCenterPos()
    return
  end
  L_Vector3.setAnchored(self.bindComponents.imgMap, L_Vector3.zero)
  local w2L = -self.mapData:worldToLocal(L_PlayerManager:getMainControlEntityPos())
  local offset = w2L * self.mapData.imgScale
  self:setMapPosition(offset)
end

function this:focusTargetPoint(pos)
  L_Vector3.setAnchored(self.bindComponents.imgMap, L_Vector3.zero)
  local w2L = -self.mapData:worldToLocal(pos)
  local offset = w2L * self.mapData.imgScale
  self:setMapPosition(offset)
end

function this:focusAreaCenter(pos, duration)
  local areaPos = L_Vector3.new(pos[1], pos[2], pos[3])
  local w2L = self.mapData:worldToLocal(areaPos) * self.mapData.imgScale
  local duration = duration or 0.5
  local startPos = self.bindComponents.imgMap.anchoredPosition
  local endPos = C_Vector2(0 - w2L.x, 0 - w2L.y)
  endPos = self.mapData:clampImgPos(endPos)
  if self.doTweenMap then
    self.doTweenMap:Kill()
  end
  self.bMovingAnim = true
  
  local function getter()
    return startPos
  end
  
  local function setter(r)
    self.bindComponents.imgMap.anchoredPosition = r
  end
  
  self.doTweenMap = DOTween.To(getter, setter, endPos, duration):OnComplete(function()
    self.bMovingAnim = false
  end)
  self.doTweenMap:SetEase(Tweening.Ease.OutQuint)
end

function this:initCenterPos()
  local transferNodeList = L_MapManager:getAllTransferNode(self.mapData.sceneId)
  if transferNodeList then
    self:focusTargetPoint(transferNodeList[1].configPos)
  else
    self.bindComponents.imgMap.anchoredPosition = C_Vector2(0, 0)
  end
end

function this:configTouch(operator)
  self.onUITouchHandle = self.onUITouchHandle or L_CommonUtil.handle(self.onUI_touchHandle, self)
  self.onUIDragStartHandle = self.onUIDragStartHandle or L_CommonUtil.handle(self.onUI_dragStartHandle, self)
  self.onUIDragHandle = self.onUIDragHandle or L_CommonUtil.handle(self.onUI_dragHandle, self)
  self.onUIDragEndHandle = self.onUIDragEndHandle or L_CommonUtil.handle(self.onUI_dragEndHandle, self)
  self.onClickHandle = self.onClickHandle or L_CommonUtil.handle(self.on_clickHandle, self)
  C_ScreenTouch.OnUI_Touch(operator, self.onUITouchHandle)
  C_ScreenTouch.OnUI_DragStart(operator, self.onUIDragStartHandle)
  C_ScreenTouch.OnUI_Drag(operator, self.onUIDragHandle)
  C_ScreenTouch.OnUI_DragEnd(operator, self.onUIDragEndHandle)
  C_ScreenTouch.OnUI_Click(operator, self.onClickHandle)
end

function this:onUI_touchHandle(gesture)
  if L_DeviceTpl:getIsPc() then
    return
  end
  if self.data.openMode == L_MapConst.OpenMode.UnlockHomeArea or self.mapPointDelete or not debugActions.enableMapPointTeleport then
    return
  end
  if gesture.go ~= self.bindComponents.imgMap.gameObject then
    return
  end
  L_FlyMsgManager:startLongPress(gesture, 5, function()
    self:gmPointTeleport(gesture.position)
  end)
end

function this:onUI_dragStartHandle(gesture)
  if not L_CommonUtil.isValid(gesture.go) then
    return
  end
  if gesture.go ~= self.bindComponents.imgMap.gameObject and gesture.go:GetComponent(typeof(C_LMaskImage)) == nil then
    self.isDragInMapPos = false
    return
  end
  self.isDragInMapPos = true
end

function this:onUI_dragHandle(gesture)
  if not L_CommonUtil.isValid(gesture.go) then
    return
  end
  if gesture.go ~= self.bindComponents.imgMap.gameObject and gesture.go:GetComponent(typeof(C_LMaskImage)) == nil then
    if self.dragClickPos ~= nil then
      self.dragClickPos = nil
    end
    self.isDragInMapPos = false
    return
  end
  if self.isDragInMapPos ~= true then
    return
  end
  local pos = gesture.deltaPosition
  self:setMapPosition(pos)
  self.modules.moduleMapPoint:onMapDrag()
end

function this:onUI_dragEndHandle(gesture)
  if not L_CommonUtil.isValid(gesture.go) then
    return
  end
  if gesture.go ~= self.bindComponents.imgMap.gameObject and gesture.go:GetComponent(typeof(C_LMaskImage)) == nil then
    return
  end
end

function this:on_clickHandle(gesture)
  if self.data.openMode == L_MapConst.OpenMode.UnlockHomeArea or self.mapPointDelete then
    return
  end
  if gesture.go ~= self.bindComponents.imgMap.gameObject then
    return
  end
  local isPc = L_DeviceTpl:getIsPc()
  if isPc and debugActions.enableMapPointTeleport then
    local input = Unity.Input
    local keyCode = Unity.KeyCode
    if input and keyCode and (input.GetKey(keyCode.LeftControl) or input.GetKey(keyCode.RightControl)) then
      self:gmPointTeleport(gesture.position)
      return
    end
  end
  self:choiceSelfNode(gesture.position)
end

function this:onUI_pinchIn(gesture)
  self:refreshAllNodePos()
end

function this:onUI_pinchOut(gesture)
  self:refreshAllNodePos()
end

function this:onUI_pinch(gesture)
  self:refreshAllNodePos()
end

function this:initTeleScrollList()
end

function this:selectTeleNode(mapNode)
  local duration = 0.5
  local interval = 0.02
  local loop = duration / interval
  local counter = 1
  local nodeScreen = C_CameraManager.uiCamera:WorldToScreenPoint(mapNode.trans.position)
  local startPos = self.bindComponents.imgMap.anchoredPosition
  local endPos = startPos + C_Vector2(Unity.Screen.width / 2 - nodeScreen.x, Unity.Screen.height / 2 - nodeScreen.y)
  endPos = self.mapData:clampImgPos(endPos)
  if self.timers.selectTele then
    Timer.remove(self.timers.selectTele)
  end
  self.timers.selectTele = Timer.new(function()
    self.bindComponents.imgMap.anchoredPosition = C_Vector2.Lerp(startPos, endPos, counter / loop)
    self.modules.moduleMapPoint:onMapDrag()
    counter = counter + 1
    self.bMovingAnim = counter <= loop
  end, interval, loop)
  self.timers.selectTele.autoDestroy = true
  self.timers.selectTele:start()
end

function this:sortNodeLayer(nodeList)
  table.sort(nodeList, function(a, b)
    local fitler_a = _worldFilter:getTplById(a.type)
    local fitler_b = _worldFilter:getTplById(b.type)
    if fitler_a ~= nil and fitler_b ~= nil then
      return _worldFilter:getSort(fitler_a) > _worldFilter:getSort(fitler_b)
    elseif fitler_a == nil then
      return false
    else
      return true
    end
  end)
end

function this:activeDetailPanel(bool)
  if bool == true then
    if self.mapPointDelete then
      self:closeBatchDelete()
    end
    self.bind.show_nodeDetailPanel = true
    self.bind.showClosePanelBtn = true
    self.bindComponents.detailPanelAnim:Stop()
    self.bindComponents.detailPanelAnim:Play("anim_bigmap_tip_in")
    L_AudioUtil.playSound("Play_SFX_System_UI_Map_Detail_Open")
  else
    self.bindComponents.detailPanelAnim:Stop()
    self.bind.showClosePanelBtn = false
    self.bindComponents.detailPanelAnim:Play("anim_bigmap_tip_out")
    L_AudioUtil.playSound("Play_SFX_System_UI_Map_Detail_Close")
  end
end

function this:playNodeAudio(nodeType)
  if nodeType == L_MapConst.mapSievingType.collection or nodeType == L_MapConst.mapSievingType.dungeon then
    L_AudioUtil.playSound("Play_SFX_System_UI_Map_Resource_Click")
  elseif nodeType == L_MapConst.mapSievingType.npc then
    L_AudioUtil.playSound("Play_SFX_System_UI_Map_Task_Click")
  end
end

function this:refreshMarksByFilter(filters)
  for type, isOn in pairs(filters) do
    local realType = type
    if changeToNpcType[type] then
      realType = L_MapConst.mapSievingType.npc
    end
    self.mapData:setFilter(type, isOn)
    if not table.isEmpty(self.nodeDic[realType]) then
      for _, node in pairs(self.nodeDic[realType]) do
        if node.type == type then
          node:refreshState(self.mapData)
        end
      end
    end
  end
  self.modules.moduleMapPoint:refreshSelfMarkState(filters)
end

function this:openBatchDelete(transform)
  if self.bind.toggleModuleName == "moduleMapPointPanel" then
    self.modules.toggleModule.moduleMapPointPanel:revertChange()
  end
  self.bind.toggleModuleName = ""
  self.modules.moduleMapPoint:setNoClearSelection(true)
  self.modules.moduleMapPoint:initMarkPoint()
  self.modules.moduleMapPoint:refreshSelfMarkState(self.mapData:getFilter(), true)
  self.mapPointDelete = CS.Lens.Gameplay.UI.ModuleMapPointPanelDelete.CreateModule(self.csharpPage, self, transform)
  self.bind.showClosePanelBtn = false
  local curGuid = self.modules.moduleMapPoint.curGuid
  local areaId = self.mapData.areaId
  self:chageMarkArea(areaId)
  self.mapPointDelete:SetMapArea(self.mapData.sceneId, areaId, table.count(L_MapStore:getMarkBymapId(areaId)))
  if curGuid ~= 0 then
    self.mapPointDelete:ToggleSeletedNode(curGuid)
  end
end

function this:isWholeMap(areaId)
  local areas = _worldAreaTpl:getAllArea(self.mapData.sceneId)
  local count = 0
  local findId = 0
  for id, tpl in pairs(areas) do
    local hasMain = _worldAreaTpl:getHasMainArea(tpl)
    local size = _worldAreaTpl:getMapSize(tpl)
    if not hasMain and size ~= nil and 0 < #size then
      count = count + 1
      findId = id
    end
  end
  if count ~= 1 then
    return false
  end
  return findId == areaId
end

function this:chageMarkArea(areaId)
  local isWholeMap = self:isWholeMap(areaId)
  if not isWholeMap then
    local tpl = _worldAreaTpl:getTplById(areaId)
    local position = _worldAreaTpl:getAreaPos(tpl, true)
    local w2L = self.mapData:worldToLocal(position) * self.mapData.imgScale
    local imgPos = L_Vector3.getAnchored(self.bindComponents.imgMap)
    w2L.x = -w2L.x - imgPos.x
    w2L.y = -w2L.y - imgPos.y
    self:setMapPosition(w2L)
    local scale = _worldAreaTpl:getEnterScale(tpl)
    self:setMapScale(scale)
  end
  local areaMapPoints = self.modules.moduleMapPoint:getAreaPoints(self.mapData.sceneId, isWholeMap and 0 or areaId)
  self.mapPointDelete:SetMarkTypeTable(areaMapPoints)
end

function this:selectMark(guid, isSelected)
  self.modules.moduleMapPoint:setChoosePoint(guid, isSelected)
end

function this:closeBatchDelete()
  self:activeDetailPanel(false)
  self.modules.moduleMapPoint:setNoClearSelection(false)
  self.modules.moduleMapPoint:initMarkPoint()
  self.modules.moduleMapPoint:refreshSelfMarkState(self.mapData:getFilter(), true)
  CS.Lens.Gameplay.UI.ModuleMapPointPanelDelete.DeleteModule(self.csharpPage)
  self.mapPointDelete = nil
end

function this:openFilterModule()
  self.bind.moduleMapFilterRootName = "moduleMapFilter"
  local filterModule = self.modules.moduleMapFilterRoot.moduleMapFilter
  if filterModule and filterModule.isBind then
    filterModule:showFilterPage(self.mapData)
  end
end

function this:isFilterModuleOn()
  local filterModule = self.modules.moduleMapFilterRoot.moduleMapFilter
  if filterModule and filterModule.isBind and filterModule.gameObject then
    return filterModule.gameObject.activeSelf
  end
  return false
end

function this:hideFilterModule()
  local filterModule = self.modules.moduleMapFilterRoot.moduleMapFilter
  if filterModule and filterModule.isBind then
    filterModule:hideFilterPage()
  end
end

function this:refreshInteractive(datas)
  self.bind.moduleMapInteractiveRootName = "moduleMapInteractive"
  local moduleMapInteractive = self.modules.moduleMapInteractiveRoot.moduleMapInteractive
  if moduleMapInteractive and moduleMapInteractive.isBind then
    moduleMapInteractive:refreshButtons(datas)
  end
end

function this:hideInteractive()
  local moduleMapInteractive = self.modules.moduleMapInteractiveRoot.moduleMapInteractive
  if moduleMapInteractive and moduleMapInteractive.isBind then
    moduleMapInteractive:hideButtons()
  end
end

function this:closeInteractive()
  self:hideInteractive()
  self.bind.showMapInteractive = false
  if self.data.nodeType ~= nil then
    self:hideChooseNode()
    self.data.nodeType = nil
  else
    self.modules.moduleMapPoint:refreshAllPoints()
  end
end

function this:showCollectionTraceTip(isOn, txt)
  if isOn then
    if not L_CommonUtil.isValid(self.collectionTraceTipObj) then
      self.collectionTraceTipObj = C_UIMgr.uiLoader:Spawn(_collectionTraceTipPath, self.bindComponents.CollectionTraceTipRoot)
      self.cancelCollectionTraceBtn = self.collectionTraceTipObj.transform:Find("root/animroot/btn_cancelTrace"):GetComponent(typeof(C_LButton))
      self.cancelCollectionTraceBtn.onClick:AddListener(function()
        self:onClick_cancelMapCollectionTrace()
      end)
      self.collectionTraceTiptxt = self.collectionTraceTipObj.transform:Find("root/animroot/txt_tip"):GetComponent(typeof(C_LTextMeshProUGUI))
    end
    self.collectionTraceTiptxt.text = txt
  elseif L_CommonUtil.isValid(self.collectionTraceTipObj) then
    self.cancelCollectionTraceBtn.onClick:RemoveAllListeners()
    C_PrefabManager:RecycleByLoader(self.collectionTraceTipObj)
    self.collectionTraceTipObj = nil
    self.cancelCollectionTraceBtn = nil
  end
end

function this:onClick_cancelMapCollectionTrace()
  local list = self:getNodeList(L_MapConst.mapSievingType.mapCollectionItem)
  if table.isEmpty(list) then
    return
  end
  local data = {
    txtTitle = L_WordsTpl:getValue("residual_code_pagebigmap_01"),
    txtContent = L_Lang:get(L_WordsTpl:getValue("ui_world_collect_cance_track"), {
      [1] = list[1].name
    }),
    confirmCallback = function(txt)
      self:setMapCollectionTraceTip(false, list[1])
    end
  }
  L_GameUtil.showCommonTip(data)
end

function this:haveLockArea()
  local list = _worldFilterMarkTpl:getTplListByWorldId(self.mapData.sceneId, L_MapConst.mapSievingType.transfer)
  for _, v in pairs(list) do
    local id = _worldFilterMarkTpl:getPosId(v)
    if not L_SceneStore:getPointIsUnlock(id) then
      return true
    end
  end
  return false
end

function this:createMapBG()
  if self:haveLockArea() then
    local obj = C_UIMgr.uiLoader:Spawn(_BGPath, self.bindComponents.board)
    obj.transform:SetSiblingIndex(1)
    obj.name = "MapBG"
  end
end

function this:checkShowNestCoopTip()
  local nearestNestCoopId = L_MapManager:getNearestActiveNestCoopNode()
  if nearestNestCoopId then
    local nestCoopTpl = _nestcoopSiteTpl:getTplById(nearestNestCoopId)
    local areaId = _nestcoopSiteTpl:getAreaId(nestCoopTpl)
    local areaTpl = _worldAreaTpl:getTplById(areaId)
    local areaStr = _worldAreaTpl:getName(areaTpl)
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("nestcoop_worldmap_notice1", {
      [0] = tostring(areaStr)
    }))
  end
end

return this
