local OasisController = class("OasisController", ControllerBase)
local base = ControllerBase
local cs_ResLoader = CS.ResLoader
local cs_MessageCommon = CS.MessageCommon
local cs_Physics = CS.PhysicsUtility
local cs_InputUtility = CS.InputUtility
local cs_Camera = CS.UnityEngine.Camera
local cs_CameraController = CS.OasisCameraController
local cs_GameObject = CS.UnityEngine.GameObject
local cs_LeanTouch = CS.Lean.Touch.LeanTouch
local cs_SkyController = CS.SkyController
local cs_usky_sun = CS.usky.uSkySun
local OasisEnum = require("Game.Oasis.OasisEnum")
local OasisBuildingItem = require("Game.Oasis.OasisBuildingItem")
local CoordinateConvert = require("Game.Oasis.OasisCoordinateConvert")
local BuildingCanvas = require("Game.Oasis.UI.UIOasisBuildingCanvas")
local BuildingBelong = require("Game.Oasis.Data.BuildingBelong")
local BuildingUIModel = require("Game.Oasis.Data.OasisBuildingUIModel")
local util = require("XLua.Common.xlua_util")
local OasisBuildEffectEntity = require("Game.Oasis.Entity.OasisBuildEffectEntity")
local OasisAreaEntity = require("Game.Oasis.Entity.OasisAreaEntity")
local JumpManager = require("Game.Jump.JumpManager")
local OasisSkyCtrl = require("Game.Oasis.Ctrl.OasisSkyCtrl")
local OasisLittleManCtrl = require("Game.Oasis.Ctrl.OasisLittleManCtrl")
local OasisWeatherCtrl = require("Game.Oasis.Ctrl.OasisWeatherCtrl")
local InputMode = {
  None = 0,
  ConstructBuilding = 1,
  MoveBuilding = 2,
  ClickBuilding = 3
}
local eBuildMapState = {Obstacle = 1, Built = 2}

function OasisController:ctor()
  self.ctrls = {}
  self.oasisSkyCtrl = OasisSkyCtrl.New(self)
  self.__onFingerDown = BindCallback(self, self.OnFingerDown)
  self.__onFingerSet = BindCallback(self, self.OnFingerSet)
  self.__onFingerUp = BindCallback(self, self.OnFingerUp)
  self.__onFingerTap = BindCallback(self, self.OnFingerTap)
  self.__cancelNewBuilding = BindCallback(self, self.CancelNewBuilding)
  self.__startConstruct = BindCallback(self, self.StartConstruct)
  self.__cancelBuildMove = BindCallback(self, self.CancelBuildMove)
  self.__reqBuildMove = BindCallback(self, self.ReqBuildMove)
  self.__ChangeBgmFunc = BindCallback(self, self.__ChangeBgm)
  self.__selectedBuilding = nil
  self.__originalPosition = nil
  self.__inputMode = InputMode.None
end

function OasisController:OnInit()
  self.oasisSkyCtrl:InitOasisSkyCtrl()
  self.__update__handle = BindCallback(self, self.OnUpdate)
  UpdateManager:AddUpdate(self.__update__handle)
  self.__lateUpdateHandle = BindCallback(self, self.OnLateUpdate)
  UpdateManager:AddLateUpdate(self.__lateUpdateHandle)
  self.buildingItems = {}
  self.hidenBuildingItems = {}
  self.networkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Building)
  self.oldBuildingItem = nil
  self.newBuildingItem = nil
  self.resloader = cs_ResLoader.Create()
  self.screenEdge = 20
  self.edgeMoveSpeed = 60
  self:InitData()
  local contentName = "BuildingContent"
  local path = PathConsts:GetOasisBuildingPrefabPath(contentName)
  local prefab = self.resloader:LoadABAsset(path)
  local obj = prefab:Instantiate()
  obj.name = contentName
  self.buildingContent = obj.transform
  self.bind = {}
  UIUtil.LuaUIBindingTable(obj, self.bind)
  self.bind.effects.gameObject:SetActive(false)
  local groundCollider = self.bind.groundCollider
  for k, oasisArea in ipairs(self.oasisAreaList) do
    local areaGo = cs_GameObject("Area" .. tostring(k))
    areaGo.transform:SetParent(self.buildingContent)
    oasisArea.gameObject = areaGo
    oasisArea.transform = areaGo.transform
    local ground = groundCollider:Instantiate(areaGo.transform)
    ground.name = tostring(k)
    local cfg = ConfigData.oasis_area[k]
    if cfg == nil then
      error("Can't find oasis_area, id = " .. tostring(k))
    elseif #cfg.offset ~= 3 then
      error("oasis_area offset error, id = " .. tostring(k))
    else
      areaGo.transform.localPosition = Vector3.New(cfg.offset[1], cfg.offset[2], cfg.offset[3])
      local areaX = cfg.size * 2 * CoordinateConvert.GetHexWidth()
      ground.transform.localScale = Vector3.New(areaX, 1, areaX)
    end
  end
  groundCollider:SetActive(false)
  cs_SkyController.Instance.OnDayChange = self.__ChangeBgmFunc
  self.topViewDirector = cs_CameraController.Instance:GetTopViewDirector()
  self.focusDirector = cs_CameraController.Instance:GetFocusDirector()
  self.__initCo = GR.StartCoroutine(util.cs_generator(BindCallback(self, self.InitBuilding)))
  self.confirmOverEvent = BindCallback(self, self.__SendConfimOver)
  self._returnEffectFunc = BindCallback(self, self.ReturnOasisEffectEntity)
  self._effectPool = {}
  self._effectInUseDic = {}
  self.__oasisState = OasisEnum.OasisState.None
  self.oasisLittleManCtrl = OasisLittleManCtrl.New(self)
  self.oasisLittleManCtrl:InitOasisLittleManCtrl()
  self.weatherCtrl = OasisWeatherCtrl.New(self)
  self.weatherCtrl:InitOasisWeatherCtrl()
end

function OasisController:InitData()
  self.oasisAreaList = {}
  for k, v in ipairs(ConfigData.oasis_area) do
    local oasisArea = {}
    self.oasisAreaList[v.id] = oasisArea
    oasisArea.id = v.id
    oasisArea.buildingMap = {}
    oasisArea.cfg = v
    local radius = oasisArea.cfg.size
    local n = radius - 1
    for x = -n, n do
      oasisArea.buildingMap[x] = {}
    end
    self:BuildInMap(v.id, v.dirty_spots, true, eBuildMapState.Obstacle)
  end
  self.buildingDatas = PlayerDataCenter.AllBuildingData
end

function OasisController:InitBuilding()
  self.areaRuinEntityDic = {}
  self.areaRuinGoDic = {}
  self.areaLockFxDic = {}
  while not PlayerDataCenter.AllBuildingData:IsBuildingDataInited() do
    coroutine.yield(nil)
  end
  for k, v in pairs(self.buildingDatas.oasisBuilt) do
    self:CreateBuilding(v)
  end
  for k, item in pairs(self.buildingItems) do
    item:LoadBuildingGo()
    while item:BuildGoIsInLoading() do
      coroutine.yield(nil)
    end
  end
  for areaId, areaData in ipairs(self.oasisAreaList) do
    local areaCfg = areaData.cfg
    local unlock = PlayerDataCenter.AllBuildingData:OsisAreaUnlock(areaId)
    if not unlock then
      local ruinWait = self.resloader:LoadABAssetAsyncAwait(PathConsts:GetOasisPrefabPath("Ruins/" .. areaCfg.lock_prefab))
      coroutine.yield(ruinWait)
      local go = ruinWait.Result:Instantiate(self.bind.ruinsHolder)
      local areaEntity = OasisAreaEntity.New(go)
      areaEntity:InitOasisAreaEntity(areaId)
      self.areaRuinEntityDic[areaId] = areaEntity
      self.areaRuinGoDic[go] = areaEntity
      local fxPath = "Area/" .. areaCfg.lock_fx
      local fxWait = self.resloader:LoadABAssetAsyncAwait(PathConsts:GetOasisBuildingEffetPrefabPath(fxPath))
      coroutine.yield(fxWait)
      local effectEntity = self:GetOasisEffectEntity(fxPath)
      effectEntity:InitOasisBuildEffectEntity(nil, self.bind.effects)
      effectEntity:UpdateOasisAreaFxState(areaId)
      self.areaLockFxDic[areaId] = effectEntity
    end
  end
  if not IsNull(cs_SkyController.Instance) and not IsNull(cs_usky_sun.instance) then
    cs_SkyController.Instance:RefreshEmission()
  end
end

function OasisController:InjectJumpEvent(jumpEvent)
  function self.jumpEvent()
    jumpEvent()
    
    self.jumpEvent = nil
  end
end

function OasisController:IsOasisNormalState()
  return self.__oasisState == OasisEnum.OasisState.Normal
end

function OasisController:__ChangeBgm(isDay)
  local homeCtrl = ControllerManager:GetController(ControllerTypeId.HomeController)
  if homeCtrl ~= nil then
    homeCtrl:ChangeSceneMainBg(isDay)
  end
  if not self.isEnter then
    local isEnd = PlayerDataCenter.sectorStage:IsStageComplete(ConfigData.game_config.warfarEndEpl)
    local isInDuring = not isEnd and PlayerDataCenter.sectorStage:IsStageComplete(ConfigData.game_config.warfarStartEpl)
    if isInDuring then
      AudioManager:PlayAudioById(3004)
      return
    end
  end
  AudioManager:PlayAudioById(3002)
  if isDay then
    AudioManager:SetSourceSelectorLabel(eAudioSourceType.BgmSource, eAuSelct.Home.name, eAuSelct.Home.oasisDay)
  elseif self.isEnter then
    AudioManager:SetSourceSelectorLabel(eAudioSourceType.BgmSource, eAuSelct.Home.name, eAuSelct.Home.oasisNight)
  else
    AudioManager:SetSourceSelectorLabel(eAudioSourceType.BgmSource, eAuSelct.Home.name, eAuSelct.Home.base)
  end
end

function OasisController:EnterOasis()
  JumpManager.couldUseItemJump = true
  if self.oasisUIModel == nil then
    self.oasisUIModel = BuildingUIModel.New(self.buildingDatas)
  else
    self.oasisUIModel:UpdateBuildingData(self.buildingDatas)
  end
  self.__mainCam = cs_CameraController.Instance.MainCamera
  cs_CameraController.Instance:DragEnable(true)
  cs_LeanTouch.OnFingerDown("+", self.__onFingerDown)
  cs_LeanTouch.OnFingerSet("+", self.__onFingerSet)
  cs_LeanTouch.OnFingerUp("+", self.__onFingerUp)
  cs_LeanTouch.OnFingerTap("+", self.__onFingerTap)
  
  local function enterFunc()
    for areaId, areaData in ipairs(self.oasisAreaList) do
      local effectEntity = self.areaLockFxDic[areaId]
      if effectEntity ~= nil and PlayerDataCenter.AllBuildingData:OsisAreaUnlock(areaId) then
        self:ReturnOasisEffectEntity(effectEntity)
        self.areaLockFxDic[areaId] = nil
      end
    end
    self.bind.effects.gameObject:SetActive(true)
    self.canvas = BuildingCanvas.New()
    local canvasWait = self.resloader:LoadABAssetAsyncAwait(PathConsts:GetUIPrefabPath("BuildingCanvasOasis"))
    coroutine.yield(canvasWait)
    local go = canvasWait.Result:Instantiate()
    self.canvas:Init(go)
    for k, v in pairs(self.buildingItems) do
      v:SetCanvas(self.canvas)
      v:UpdateState()
    end
    self.__inputMode = InputMode.ClickBuilding
    self.isEnter = true
    self:__ChangeBgm(cs_SkyController.Instance.IsDay)
    self.__ConfirmOver = BindCallback(self, self.UpgradeConfirmOver)
    MsgCenter:AddListener(eMsgEventId.BuildingUpgradeComplete, self.__ConfirmOver)
    self.__UpdateProcessEvent = BindCallback(self, self.UpdateProcessEvent)
    MsgCenter:AddListener(eMsgEventId.UpdateBuildingProcess, self.__UpdateProcessEvent)
    self.__onItemRefresh = BindCallback(self, self._OnItemRefresh)
    MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__onItemRefresh)
    MsgCenter:AddListener(eMsgEventId.UpdateARGItem, self.__onItemRefresh)
    self.__onSectorStageStateChange = BindCallback(self, self.__OnSctStageStateChange)
    MsgCenter:AddListener(eMsgEventId.OnSectorStageStateChange, self.__onSectorStageStateChange)
    local queueCtrl = ControllerManager:GetController(ControllerTypeId.BuildingQueue, true)
    queueCtrl:InitBuildQueueCtrl(BuildingBelong.Oasis)
    UIManager:ShowWindowAsync(UIWindowTypeID.OasisMain, function(window)
      if window == nil then
        return
      end
      UIManager:HideWindow(UIWindowTypeID.ClickContinue)
      window:InitOasisMain(self)
      self.__oasisState = OasisEnum.OasisState.Normal
      if GuideManager:TryTriggerGuide(eGuideCondition.InOassisBuildingDetail) then
      end
    end)
    coroutine.yield(CS.UnityEngine.WaitForSeconds(2))
    while UIManager:GetWindow(UIWindowTypeID.OasisMain) == nil do
      coroutine.yield(nil)
    end
    for k, v in pairs(self.buildingItems) do
      v:UpdateBuildingResUI()
    end
  end
  
  self:__GenerateLittleMan()
  self.__enterCoroutine = GR.StartCoroutine(util.cs_generator(enterFunc))
  self.weatherCtrl:OnEnterOasis()
end

function OasisController:TopViewTween(toTop)
  self._vcamTop = self._vcamTop or CS.UnityEngine.GameObject.Find("Cinemachine/HomeToOasis/CM vcam/CM vcam OasisTop")
  if toTop then
    self.topViewDirector.gameObject:SetActive(true)
    TimelineUtil.Play(self.topViewDirector, function()
      self._vcamTop:SetActive(true)
    end)
    self:__ShowResidentUI(false)
  else
    TimelineUtil.Rewind(self.topViewDirector, BindCallback(self, self.__TopViewTweenRewindCompelte))
  end
end

function OasisController:__TopViewTweenRewindCompelte()
  self:__ShowResidentUI(true)
  self.topViewDirector.gameObject:SetActive(false)
  self._vcamTop:SetActive(false)
end

function OasisController:EnterEditMode()
  local editWindow = UIManager:ShowWindow(UIWindowTypeID.OasisEditWindow)
  editWindow:InitOasisEditor(self)
  self.__inputMode = InputMode.MoveBuilding
  self.__oasisState = OasisEnum.OasisState.EditorBuild
  self:TopViewTween(true)
  self:RemoveLittleMan(false)
  local window = UIManager:GetWindow(UIWindowTypeID.OasisMain)
  if window ~= nil then
    window.oasisSelectNode:Hide()
  end
  if self.canvas ~= nil then
    self.canvas:SetBuildCanvasTopMode(true)
  end
  self:UnselectOasisBuilding(true)
end

function OasisController:ExitEditMode()
  if self.newBuildingItem ~= nil then
    self:CancelNewBuilding()
  end
  self.__inputMode = InputMode.ClickBuilding
  self.__oasisState = OasisEnum.OasisState.Normal
  self:__ResetSelectedBuilding()
  self:UnselectOasisBuilding(false)
  self:TopViewTween(false)
  self:__GenerateLittleMan()
  if self.canvas ~= nil then
    self.canvas:SetBuildCanvasTopMode(false)
  end
end

function OasisController:EnterOasisSkyMode()
  AudioManager:PlayAudioById(1035)
  self.oasisSkyCtrl:ShowOasisSkySetting()
  UIManager:HideWindow(UIWindowTypeID.OasisMain)
  self.__inputMode = InputMode.None
  self.__oasisState = OasisEnum.OasisState.SkyControl
  self:UnselectOasisBuilding(true)
  if self.canvas ~= nil then
    self.canvas:Hide()
  end
end

function OasisController:ExitOasisSkyMode()
  self.__inputMode = InputMode.ClickBuilding
  self.__oasisState = OasisEnum.OasisState.Normal
  AudioManager:PlayAudioById(1036)
  UIManager:ShowWindowOnly(UIWindowTypeID.OasisMain)
  if self.canvas ~= nil then
    self.canvas:Show()
  end
end

function OasisController:ShowOasisUI(show)
  if show then
    self.__inputMode = InputMode.ClickBuilding
    self.__oasisState = OasisEnum.OasisState.Normal
    UIUtil.ReShowTopStatus()
    UIManager:ShowWindowOnly(UIWindowTypeID.OasisMain)
    if self.canvas ~= nil then
      self.canvas:Show()
    end
  else
    self.__inputMode = InputMode.None
    self.__oasisState = OasisEnum.OasisState.HideUI
    AudioManager:PlayAudioById(1104)
    UIUtil.HideTopStatus()
    UIManager:HideWindow(UIWindowTypeID.OasisMain)
    if self.canvas ~= nil then
      self.canvas:Hide()
    end
  end
end

function OasisController:CreateBuilding(buildingData)
  local unityPosition = CoordinateConvert.ToUnityCenterPos(buildingData.position, buildingData.size)
  local item = self:CreateBuildingItem(unityPosition, buildingData.size, buildingData.height, buildingData.area)
  item:SetBuildingData(buildingData)
  self.buildingItems[buildingData.id] = item
  self:UpdateBuildingMap(buildingData)
end

function OasisController:CreateBuildingItem(unityPosition, size, height, areaId)
  local item = OasisBuildingItem.New()
  item:Initialize(unityPosition, size, height, self.oasisAreaList[areaId].transform)
  return item
end

function OasisController:GetOasisEffectEntity(effectName)
  if string.IsNullOrEmpty(effectName) then
    error("OasisEffect name is null")
    return
  end
  if self._effectPool[effectName] == nil then
    self._effectPool[effectName] = {}
  end
  local effectList = self._effectPool[effectName]
  local entity
  if #effectList == 0 then
    local abPath = PathConsts:GetOasisBuildingEffetPrefabPath(effectName)
    local prefab = self.resloader:LoadABAsset(abPath)
    local effectObj = prefab:Instantiate()
    entity = OasisBuildEffectEntity.New(effectObj, effectName)
  else
    entity = table.remove(effectList)
  end
  self._effectInUseDic[entity] = true
  return entity
end

function OasisController:ReturnOasisEffectEntity(effectEntity)
  effectEntity.gameObject:SetActive(false)
  effectEntity.transform:SetParent(self.bind.effects)
  local effectName = effectEntity:GetOasisBuildEffectEntityName()
  local effectList = self._effectPool[effectName]
  table.insert(effectList, effectEntity)
  self._effectInUseDic[effectEntity] = nil
end

function OasisController:__ShowSelectBuildFx(buildItem, size)
  local name = "SelectBuilding/SelectHex" .. size[1]
  if size[1] == 1 then
    name = name .. "-" .. tostring(size[2])
  end
  local effectEntity = self:GetOasisEffectEntity(name)
  effectEntity:InitOasisBuildEffectEntity(buildItem.rootTransform.position, buildItem.rootTransform)
  self.__selectedBuildFx = effectEntity
end

function OasisController:__HideSelectBuildFx()
  if self.__selectedBuildFx == nil then
    return
  end
  self:ReturnOasisEffectEntity(self.__selectedBuildFx)
  self.__selectedBuildFx = nil
end

function OasisController:__GetBuildablePos(oasisPos, size, areaId)
  local oasisArea = self.oasisAreaList[areaId]
  if oasisArea == nil then
    error("Cant't find oasisArea, areaId = " .. tostring(areaId))
    return
  end
  local standbyAreaId, standbyOasisPos
  if PlayerDataCenter.AllBuildingData:OsisAreaUnlock(areaId) then
    local newOasisPos = oasisPos
    local areaList = CoordinateConvert.GetHexArea(newOasisPos, size)
    local overlap = self:CheckBuildingOverlap(areaId, areaList)
    if not overlap then
      return newOasisPos, oasisArea.id
    end
    local radius = oasisArea.cfg.size
    local n = radius - 1
    for x = -n, n do
      for y = math.max(-n, -x - n), math.min(n, -x + n) do
        newOasisPos = Vector2.New(x, y)
        areaList = CoordinateConvert.GetHexArea(newOasisPos, size)
        overlap = self:CheckBuildingOverlap(areaId, areaList)
        if not overlap then
          return newOasisPos, oasisArea.id
        end
      end
    end
    standbyAreaId = areaId
    standbyOasisPos = oasisPos
  end
  for k, oasisArea in ipairs(self.oasisAreaList) do
    if k ~= areaId and PlayerDataCenter.AllBuildingData:OsisAreaUnlock(k) then
      local radius = oasisArea.cfg.size
      local n = radius - 1
      for x = -n, n do
        for y = math.max(-n, -x - n), math.min(n, -x + n) do
          local newOasisPos = Vector2.New(x, y)
          local areaList = CoordinateConvert.GetHexArea(newOasisPos, size)
          local overlap = self:CheckBuildingOverlap(k, areaList)
          if not overlap then
            return newOasisPos, oasisArea.id
          end
        end
      end
      if standbyAreaId == nil then
        standbyAreaId = k
        standbyOasisPos = Vector3.zero
      end
    end
  end
  print("[OasisController:__GetBuildablePos] Cant get buildable position")
  return standbyOasisPos or oasisPos, standbyAreaId or areaId
end

function OasisController:NewBuilding(buildingData)
  local dynData = buildingData.dynData
  local prefabName = ConfigData.oasis_building_model[dynData.levelConfig[1].modol].model
  self.__buildNewOasisPos, self.__newAreaId = self:__GetBuildablePos(dynData.position, dynData.size, dynData.area)
  local unityPosition = CoordinateConvert.ToUnityCenterPos(self.__buildNewOasisPos, dynData.size)
  local item = self:CreateBuildingItem(unityPosition, dynData.size, dynData.height, self.__newAreaId)
  item:SetBuildingData(buildingData)
  item:LoadBuildingGo(prefabName, function()
    if not IsNull(cs_SkyController.Instance) and not IsNull(cs_usky_sun.instance) then
      cs_SkyController.Instance:RefreshEmission()
    end
  end)
  self:__ShowSelectBuildFx(item, dynData.size)
  self.newBuildingItem = item
  self.selectedBuildingData = buildingData
  self.__selectedBuilding = item
  local areaList = CoordinateConvert.GetHexArea(self.__buildNewOasisPos, dynData.size)
  local overlap = self:CheckBuildingOverlap(self.__newAreaId, areaList)
  self.__selectedBuildFx:SetBuildSelectFxValid(not overlap)
  local window = UIManager:GetWindow(UIWindowTypeID.OasisMain)
  if window ~= nil then
    window.oasisSelectNode:InitOasisBuildSelect(buildingData, item, false, false)
    window.oasisSelectNode:SetOasisBuildSelectFunc(self.__startConstruct, self.__cancelNewBuilding)
    window.oasisSelectNode:EnableBuildConfirmBtn(not overlap)
  end
  cs_CameraController.Instance:Cam2BuildingTopPos(item.rootTransform)
  self.__inputMode = InputMode.ConstructBuilding
end

function OasisController:CancelNewBuilding()
  self:__HideSelectBuildFx()
  if self.newBuildingItem ~= nil then
    self.newBuildingItem:OnDelete()
    self.newBuildingItem:DeleteEntity()
    self.newBuildingItem = nil
  end
  self.selectedBuildingData = nil
  self.__selectedBuilding = nil
  local mainWindow = UIManager:GetWindow(UIWindowTypeID.OasisMain)
  if mainWindow ~= nil then
    mainWindow.oasisSelectNode:Hide()
  end
  local editWindow = UIManager:GetWindow(UIWindowTypeID.OasisEditWindow)
  if editWindow ~= nil then
    editWindow:ShowOasisEditorSideTween(true)
  end
  self.__inputMode = InputMode.MoveBuilding
end

function OasisController:StartConstruct()
  local oasisPos = self.__buildNewOasisPos
  local size = self.selectedBuildingData.size
  local areaId = self.__newAreaId
  if not PlayerDataCenter.AllBuildingData.oasisAreaDic[areaId] then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.OaisaAreaUnlock))
    return
  end
  local errorTips
  if self.buildingDatas:FullOasisBuildQue() then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Building_ConstructQueueFull))
    return
  end
  if not self.selectedBuildingData.dynData:CanBuild() then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Building_NotFillConstructCodition))
    return
  end
  local areaList = CoordinateConvert.GetHexArea(oasisPos, size)
  if self:CheckBuildingOverlap(areaId, areaList) then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Oasis_Building_Overlapping))
    return
  end
  self.networkCtrl:SendBuildingConstruct(self.selectedBuildingData.id, oasisPos, areaId)
end

function OasisController:ConstructComplete(id)
  local buildingData = self.buildingDatas.built[id]
  local editWindow = UIManager:GetWindow(UIWindowTypeID.OasisEditWindow)
  if editWindow ~= nil then
    editWindow:ShowOasisEditorSideTween(true)
  end
  local newBuildingItem = self.newBuildingItem
  self.buildingItems[id] = newBuildingItem
  newBuildingItem:SetPosition(buildingData.position)
  newBuildingItem:SetBuildingData(buildingData)
  newBuildingItem:SetCanvas(self.canvas)
  newBuildingItem:UpdateState()
  self:__HideSelectBuildFx()
  self:UpdateBuildingMap(buildingData)
  local effectEntity = self:GetOasisEffectEntity(buildingData.dynData.stcData.construct_effect)
  local buildTrans = newBuildingItem.rootTransform
  effectEntity:InitOasisBuildEffectEntity(buildTrans.position, buildTrans, self._returnEffectFunc)
  self.newBuildingItem = nil
  self.__selectedBuilding = nil
  self.selectedBuildingData = buildingData
  local window = UIManager:GetWindow(UIWindowTypeID.OasisMain)
  if window ~= nil then
    window.oasisSelectNode:Hide()
  end
  self.__inputMode = InputMode.MoveBuilding
end

function OasisController:StartUpgrade(buildingData)
  local nextLevel = buildingData.level + 1
  if nextLevel > buildingData.maxLevel then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Building_LevelFull))
    return
  end
  if self.buildingDatas:FullOasisBuildQue() then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Building_ConstructQueueFull))
    return
  end
  if not buildingData:CanUpgrade() then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Building_NotFitUpgradeStatue))
    return
  end
  self.networkCtrl:SendBuildingUpgrade(buildingData.id)
  return
end

function OasisController:UpgradeComplete(id)
  local builtData = self.buildingDatas.built[id]
  local mainWindow = UIManager:GetWindow(UIWindowTypeID.OasisMain)
  if mainWindow ~= nil then
    mainWindow.buildDetailNode:HideOasisBuildDetail()
    mainWindow.oasisSelectNode:RefreshOasisSelectState()
  end
  local buildingItem = self.buildingItems[id]
  local prefabName = ConfigData.oasis_building_model[builtData.levelConfig[builtData.level].modol].model
  buildingItem:LoadBuildingGo(prefabName, function(buildItem)
    local effectEntity = self:GetOasisEffectEntity(buildItem.buildingData.dynData.stcData.upgrading_effect)
    local buildTrans = buildItem.rootTransform
    effectEntity:InitOasisBuildEffectEntity(buildTrans.position, buildTrans, self._returnEffectFunc)
    local height = buildItem:GetBuildItemHeight()
    effectEntity:SetOasisBuildEffectHeight(height)
  end)
  buildingItem:UpdateState()
end

function OasisController:__OnCancelUpgrade()
  self.networkCtrl:SendBuildingCancel(self.selectedBuildingData.id)
end

function OasisController:__SendConfimAcc(id, cost)
  self.networkCtrl:SendBuildingAccelerate(id, cost)
end

function OasisController:__SendConfimOver(id)
  local builtData = self.buildingDatas.built[id]
  if not builtData.waitConfirmOver then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(TipContent.Building_Incomplete))
    return
  end
  self.networkCtrl:SendBuildingConfirmOver(id)
end

function OasisController:UpgradeConfirmOver(id)
  local builtData = self.buildingDatas.built[id]
  local buildingItem = self.buildingItems[id]
  if buildingItem == nil then
    return
  end
  AudioManager:PlayAudioById(1013)
  buildingItem:UpdateBuildLevel(builtData)
  self:UpdateBuilding(id)
  local tipsId
  if builtData.level == 1 then
    tipsId = 5001
  else
    tipsId = 5002
  end
  cs_MessageCommon.ShowMessageTips(string.format(ConfigData:GetTipContent(tipsId), builtData.name))
end

function OasisController:CancelBuildMove()
  local buildingData = self.__selectedBuilding.buildingData
  self.__selectedBuilding:SetItemArea(self.oasisAreaList[buildingData.area].transform)
  self.__selectedBuilding:SetPosition(buildingData.position, true)
  self:BuildInMap(buildingData.area, buildingData:GetArea(), true, eBuildMapState.Built)
end

function OasisController:ReqBuildMove()
  if self.__selectedBuilding == nil or self.__newAreaId == nil then
    return
  end
  local areaId = self.__newAreaId
  if not PlayerDataCenter.AllBuildingData.oasisAreaDic[areaId] then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.OaisaAreaUnlock))
    return
  end
  self.networkCtrl:SendBuildingMove(self.__selectedBuilding.id, self.__buildNewOasisPos, self.__newAreaId)
end

function OasisController:MoveComplete(id)
  local item = self.buildingItems[id]
  local buildingData = item.buildingData
  self:UpdateBuildingMap(buildingData)
end

function OasisController:CollectOasisRes(id)
  if GuideManager.collectResGuideUnComplete and id == 1003 then
    GuideManager:UncompleteCollectResGuide(false)
    local topWindow = UIManager:GetWindow(UIWindowTypeID.TopStatus)
    topWindow.resGroup:UpdateResourceGroupTopCurrencys()
    self._collectResDic = {}
    self._collectResDic[id] = 0.1
    self:CollectComplete(1003, {
      {id = 1004, count = 1}
    })
    return
  end
  local buildingData = self.buildingDatas.built[id]
  if buildingData:CanGetBuildRes(true) then
    local resDatas = buildingData:GetResDatas()
    self._collectResDic = {}
    for k, v in pairs(resDatas) do
      self._collectResDic[id] = v.count / v.countMax
      break
    end
    self.networkCtrl:SendBuildingCollect(id)
  end
end

function OasisController:CollectComplete(id, resTab)
  AudioManager:PlayAudioById(1090)
  local buildingItem = self.buildingItems[id]
  if buildingItem ~= nil then
    buildingItem:UpdateBuildingResUI()
  end
  local resDic = {}
  for k, v in ipairs(resTab) do
    resDic[v.id] = v.count
    local item = ConfigData.item[v.id]
    if not IsNull(item) then
      local msg = ConfigData:GetTipContent(TipContent.Building_GainReward, LanguageUtil.GetLocaleText(item.name), v.count)
      cs_MessageCommon.ShowMessageTips(msg, true)
    end
  end
  local idDic = {}
  idDic[id] = true
  self:_ShowResCollectParticleTween(idDic, resDic)
end

function OasisController:CollectAllOasisBuildingRes()
  local buildIdDict = {}
  local buildingCount = 0
  local fullWareHouseItemDic = {}
  self._collectResDic = {}
  for buildId, buildData in pairs(PlayerDataCenter.AllBuildingData.oasisBuilt) do
    if buildData:IsBuildResPeriodOk() and buildData:CanGetBuildRes(false, fullWareHouseItemDic) then
      buildingCount = buildingCount + 1
      buildIdDict[buildId] = true
      local resDatas = buildData:GetResDatas()
      for k, v in pairs(resDatas) do
        self._collectResDic[buildId] = v.count / v.countMax
        break
      end
    end
  end
  for name, _ in pairs(fullWareHouseItemDic) do
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.ItemInWarehouseFull, name), true)
  end
  self.buildIdDict = buildIdDict
  if 0 < buildingCount then
    if self._CollectAllResCompleteFunc == nil then
      self._CollectAllResCompleteFunc = BindCallback(self, self._OnCollectAllResComplete)
    end
    self.networkCtrl:SendBuildingCollectGroup(buildIdDict, self._CollectAllResCompleteFunc)
  end
end

function OasisController:_OnCollectAllResComplete(objList)
  if objList.Count ~= 1 then
    error("objList.Count error:" .. tostring(objList.Count))
    return
  end
  AudioManager:PlayAudioById(1090)
  local resDic = objList[0]
  for resId, resNum in pairs(resDic) do
    local itemCfg = ConfigData.item[resId]
    if itemCfg ~= nil then
      local msg = ConfigData:GetTipContent(TipContent.Building_GainReward, LanguageUtil.GetLocaleText(itemCfg.name), resNum)
      cs_MessageCommon.ShowMessageTips(msg, true)
    end
  end
  self:_ShowResCollectParticleTween(self.buildIdDict, resDic)
end

function OasisController:_ShowResCollectParticleTween(idDic, resDic)
  local topWin = UIManager:GetWindow(UIWindowTypeID.TopStatus)
  if topWin == nil then
    return
  end
  local selBuildItems = {}
  local buildItem
  for id, boolean in pairs(idDic) do
    buildItem = self.buildingItems[id]
    if buildItem ~= nil then
      selBuildItems[id] = buildItem
    end
  end
  local topResUIPosDic = {}
  local pos
  for resId, resNum in pairs(resDic) do
    pos = topWin:GetResItemPos(resId)
    if pos ~= nil then
      topResUIPosDic[resId] = pos
    end
  end
  local oasisWin = UIManager:GetWindow(UIWindowTypeID.OasisMain)
  if oasisWin ~= nil then
    oasisWin.paticleNode:Show()
    oasisWin.paticleNode:InitOasisParticle(self, topResUIPosDic, selBuildItems, self._collectResDic)
  end
end

function OasisController:SendCancelEvent()
  self.networkCtrl:SendBuildingCancel(self.newBuildingItem.id)
end

function OasisController:CancelComplete(id, oldState)
  local buildingItem = self.buildingItems[id]
  local buildingData = buildingItem.buildingData
  if oldState == proto_object_BuildingState.BuildingStateCreate then
    self.buildingItems[id] = nil
    self:BuildInMap(buildingData.area, buildingData:GetArea(), false)
    local unbuiltData = self.buildingDatas.unbuilt[buildingData.stcData.build_id]
  elseif oldState == proto_object_BuildingState.BuildingStateUpgrade then
    local buildingItem = self.buildingItems[id]
    local prefabName = ConfigData.oasis_building_model[buildingData.levelConfig[buildingData.level].modol].model
    local unityPosition = buildingItem.rootTransform.localPosition
    buildingItem:LoadBuildingGo(prefabName)
    buildingItem:UpdateState()
  end
end

function OasisController:ReqUnlockOasisArea(areaId)
  local areaCfg = ConfigData.oasis_area[areaId]
  if not CheckCondition.CheckLua(areaCfg.pre_condition, areaCfg.pre_para1, areaCfg.pre_para2) then
    local lockInfo = CheckCondition.GetUnlockInfoLua(areaCfg.pre_condition, areaCfg.pre_para1, areaCfg.pre_para2)
    cs_MessageCommon.ShowMessageTipsWithErrorSound(lockInfo)
    return
  end
  self.__OnUnlockAreaFunc = self.__OnUnlockAreaFunc or BindCallback(self, self.__OnUnlockOasisArea)
  self._unlockAreaId = areaId
  self.networkCtrl:CS_BUILDIN_AreaUnlock(areaId, self.__OnUnlockAreaFunc)
end

function OasisController:__OnUnlockOasisArea()
  local areaEntity = self.areaRuinEntityDic[self._unlockAreaId]
  self.areaRuinGoDic[areaEntity.gameObject] = nil
  areaEntity:OnDelete()
  self.areaRuinEntityDic[self._unlockAreaId] = nil
  local effectEntity = self.areaLockFxDic[self._unlockAreaId]
  if effectEntity ~= nil then
    effectEntity:UpdateOasisAreaFxState(self._unlockAreaId)
  end
  local sideNoticeList = NoticeManager:GetSideNoticeList()
  for _, noticeData in pairs(sideNoticeList) do
    if noticeData.type == NoticeManager.eNoticeType.OasisAreaUnlock and self._unlockAreaId == noticeData.extraData.areaId then
      NoticeManager:DeleteNotice(noticeData)
      break
    end
  end
  local msg = ConfigData:GetTipContent(TipContent.Oasis_ArenaUnLock)
  cs_MessageCommon.ShowMessageTips(msg, true)
  local msg = ConfigData:GetTipContent(TipContent.Oasis_LittleManArenaUnLock)
  cs_MessageCommon.ShowMessageTips(msg, true)
end

function OasisController:__UpdateAllAreaUnlcokState()
  for areaId, effectEntity in pairs(self.areaLockFxDic) do
    effectEntity:UpdateOasisAreaFxState(areaId)
  end
end

function OasisController:__OnSctStageStateChange()
  self:__UpdateAllAreaUnlcokState()
end

function OasisController:UpdateBuilding(id)
  local buildingData = self.buildingDatas.built[id]
  if buildingData == nil then
    return
  end
  local editWindow = UIManager:GetWindow(UIWindowTypeID.OasisEditWindow)
  if editWindow ~= nil then
    editWindow:RefreshOasisEditSideBar()
  end
  local mainWindow = UIManager:GetWindow(UIWindowTypeID.OasisMain)
  if mainWindow ~= nil then
    mainWindow.buildDetailNode:RefreshOasisBuildDetailState()
    mainWindow:RefreshOasisEditRedDot()
  end
  if self.canvas ~= nil then
    self.canvas:SetBuildName3dItemCanLevelUp(buildingData.id, buildingData:CanUpgrade())
  end
  if self.buildingItems[id] ~= nil then
    self.buildingItems[id]:UpdateState()
  end
end

function OasisController:_OnItemRefresh(itemIdDic)
  local noChanged = true
  for itemId, _ in pairs(itemIdDic) do
    if ConfigData.buildingLevel.resConsumeDic[itemId] ~= nil then
      noChanged = false
      break
    end
  end
  if noChanged then
    return
  end
  local mainWindow = UIManager:GetWindow(UIWindowTypeID.OasisMain)
  if mainWindow ~= nil then
    mainWindow.buildDetailNode:RefreshOasisBuildDetailState()
    mainWindow:RefreshOasisEditRedDot()
  end
  if self.canvas ~= nil then
    for k, buildingData in pairs(PlayerDataCenter.AllBuildingData.oasisBuilt) do
      self.canvas:SetBuildName3dItemCanLevelUp(buildingData.id, buildingData:CanUpgrade())
    end
  end
end

function OasisController:OnUpdate()
  if not self.isEnter then
    return
  end
  local timestamp = PlayerDataCenter.timestamp
  if self.__timeSecond == nil then
    self.__timeSecond = timestamp
  end
  local isSecond = false
  if timestamp > self.__timeSecond + 1 then
    self.__timeSecond = self.__timeSecond + 1
    isSecond = true
  end
  for k, v in pairs(self.buildingItems) do
    v:Update(timestamp, isSecond)
  end
  local queueCtrl = ControllerManager:GetController(ControllerTypeId.BuildingQueue)
  if queueCtrl ~= nil then
    queueCtrl:UpdateBuildQueueSecond(timestamp, isSecond)
  end
  if self.oasisLittleManCtrl ~= nil then
    self.oasisLittleManCtrl:LittleManAIUpdate()
  end
end

function OasisController:OnLateUpdate()
  if not self.isEnter then
    return
  end
  local canCollect = false
  for k, buildingData in pairs(PlayerDataCenter.AllBuildingData.oasisBuilt) do
    if buildingData:IsBuildResPeriodOk() then
      canCollect = true
      break
    end
  end
  local isCamChange = cs_CameraController.Instance:IsCameraChange() or self.__isDrag
  local window = UIManager:GetWindow(UIWindowTypeID.OasisMain)
  if window ~= nil then
    if isCamChange then
      window.oasisSelectNode:RefreshOasisSelectPos()
    end
    window:ShowOasisMainCollectResBtn(canCollect and not GuideManager.collectResGuideUnComplete)
  end
  if isCamChange then
    local window = UIManager:GetWindow(UIWindowTypeID.OasisMain)
    if window ~= nil then
      window.oasisResNode:OasisResOutputLateUpdate()
      window.paticleNode:UpdateOasisResPaticlePosAll()
    end
  end
end

function OasisController:OnFingerDown(leanFinger)
  if leanFinger.StartedOverGui or leanFinger.IsOverGui or self.__inputMode == InputMode.None then
    return
  end
  self.__lastMousePos = cs_InputUtility.MousePosition
  local hits = cs_Physics.Raycast(self.__mainCam, 1 << LayerMask.Raycast)
  for i = 0, hits.Length - 1 do
    local hitCollider = hits[i].collider
    if not IsNull(hitCollider) and hitCollider.tag == TagConsts.Building then
      local hitObj = hitCollider.gameObject
      local hitName = hitObj.name
      if self.__inputMode == InputMode.ConstructBuilding and self.newBuildingItem ~= nil and hitObj == self.newBuildingItem.gameObject then
        self.__selectedBuildingLastPos = self.selectedBuildingData.position
        self.__selectedBuildingLastAreaId = self.selectedBuildingData.area
        self.__originalPosition = self.newBuildingItem.rootTransform.position
        self.__fingerId = leanFinger.Index
        cs_CameraController.Instance:DragEnable(false)
      elseif self.__inputMode == InputMode.MoveBuilding then
        local item = self:__GetBuildingItemByName(hitName)
        if item ~= nil and item == self.__selectedBuilding then
          self.__fingerId = leanFinger.Index
          cs_CameraController.Instance:DragEnable(false)
        end
      end
    end
  end
end

function OasisController:OnFingerSet(leanFinger)
  if leanFinger.StartedOverGui or leanFinger.IsOverGui or self.__fingerId ~= leanFinger.Index or leanFinger.ScreenDelta.x == 0 and leanFinger.ScreenDelta.y == 0 then
    return
  end
  if not self.__isDrag and self.__lastMousePos ~= cs_InputUtility.MousePosition then
    self.__isDrag = true
    if self.__inputMode == InputMode.MoveBuilding and self.__selectedBuilding ~= nil then
      local buildingData = self.__selectedBuilding.buildingData
      self:BuildInMap(buildingData.area, buildingData:GetArea(), false)
    end
  end
  if self.__isDrag and (self.__inputMode == InputMode.MoveBuilding or self.__inputMode == InputMode.ConstructBuilding) and self.__selectedBuilding ~= nil then
    cs_CameraController.Instance:DragEnable(false)
    cs_CameraController.Instance:OnDragBuildingScreenEdge(self.screenEdge, self.edgeMoveSpeed)
    local hits = cs_Physics.Raycast(self.__mainCam, 1 << LayerMask.Raycast, true)
    for i = 0, hits.Length - 1 do
      local hit = hits[i]
      local hitCollider = hit.collider
      if not IsNull(hitCollider) and hitCollider.tag == TagConsts.BuildingGround then
        local areaId = tonumber(hitCollider.name)
        local oasisArea = self.oasisAreaList[areaId]
        if oasisArea ~= nil and PlayerDataCenter.AllBuildingData:OsisAreaUnlock(areaId) then
          local localPosition = hit.point - oasisArea.transform.position
          local diameter = Vector3.Normalize(localPosition) * ConfigData.game_config.OasisHexSize * 1
          local oasisPos, unityPos, areaList = self.__selectedBuilding:SetRoundPosition(localPosition, false, true)
          local overlap, cantMove = self:CheckBuildingOverlap(areaId, areaList)
          local count = 1
          while cantMove do
            localPosition = localPosition - diameter
            oasisPos, unityPos, areaList = self.__selectedBuilding:SetRoundPosition(localPosition, false, true)
            overlap, cantMove = self:CheckBuildingOverlap(areaId, areaList)
            count = count + 1
            if count > oasisArea.cfg.size * 2 then
              goto lbl_198
            end
          end
          self.__selectedBuilding:SetItemArea(oasisArea.transform)
          self.__buildNewOasisPos = oasisPos
          if self.__inputMode == InputMode.ConstructBuilding then
            local mainWindow = UIManager:GetWindow(UIWindowTypeID.OasisMain)
            if mainWindow ~= nil then
              mainWindow.oasisSelectNode:EnableBuildConfirmBtn(not overlap)
            end
          end
          self.__selectBuildOverlap = overlap
          self.__newAreaList = areaList
          self.__newAreaId = areaId
          self.__selectedBuildFx:SetBuildSelectFxValid(not overlap)
          self.__selectedBuilding:UpdateCanvasItemPos()
          if oasisPos ~= self.__selectedBuildingLastPos or areaId ~= self.__selectedBuildingLastAreaId then
            self.__selectedBuildingLastPos = oasisPos
            self.__selectedBuildingLastAreaId = areaId
            self.__selectedBuilding.rootTransform:DOLocalMove(unityPos, 0.1)
          end
          break
        end
      end
      ::lbl_198::
    end
  end
end

function OasisController:OnFingerUp(leanFinger)
  if leanFinger.StartedOverGui or self.__fingerId ~= leanFinger.Index then
    return
  end
  if self.__selectedBuilding ~= nil and self.__isDrag then
    local buildingData = self.__selectedBuilding.buildingData
    if self.__inputMode == InputMode.MoveBuilding then
      local overlap = self:CheckBuildingOverlap(self.__newAreaId, self.__newAreaList)
      self.__selectedBuildFx:SetBuildSelectFxValid(not overlap)
      if overlap then
      elseif buildingData.position == self.__buildNewOasisPos and buildingData.area == self.__newAreaId then
        self:BuildInMap(buildingData.area, buildingData:GetArea(), true, eBuildMapState.Built)
      else
        self:ReqBuildMove()
      end
      self.__selectedBuilding:UpdateCanvasItemPos()
    end
    self.__isDrag = false
  end
  cs_CameraController.Instance:DragEnable(true)
  self.__fingerId = nil
end

function OasisController:OnFingerTap(leanFinger)
  if self.__oasisState == OasisEnum.OasisState.HideUI and not leanFinger.StartedOverGui then
    self:ShowOasisUI(true)
    return
  end
  if self.__oasisState == OasisEnum.OasisState.SkyControl and not leanFinger.StartedOverGui and not leanFinger.IsOverGui then
    UIUtil.OnClickBackByUiTab(self)
    return
  end
  if leanFinger.StartedOverGui or leanFinger.IsOverGui or self.__inputMode == InputMode.None then
    return
  end
  if self.__inputMode == InputMode.ClickBuilding then
    local hits = cs_Physics.Raycast(self.__mainCam, 1 << LayerMask.Raycast)
    for i = 0, hits.Length - 1 do
      local hitCollider = hits[i].collider
      if not IsNull(hitCollider) and not self:_ClickAreaRuin(hitCollider.gameObject) and hitCollider.tag == TagConsts.Building then
        local hitName = hitCollider.gameObject.name
        local buildingItem = self:__GetBuildingItemByName(hitName)
        if buildingItem ~= nil then
          if self.isFocusBuilding then
            return
          end
          if buildingItem.buildingData:CanGetBuildRes() then
            self:CollectOasisRes(buildingItem.id)
          else
            self:SelectOasisBuilding(buildingItem, true)
          end
          return
        end
      end
    end
    self:UnselectOasisBuilding(true)
  elseif self.__inputMode == InputMode.MoveBuilding then
    local hits = cs_Physics.Raycast(self.__mainCam, 1 << LayerMask.Raycast)
    for i = 0, hits.Length - 1 do
      local hitCollider = hits[i].collider
      if not IsNull(hitCollider) and not self:_ClickAreaRuin(hitCollider.gameObject) and hitCollider.tag == TagConsts.Building then
        local hitName = hitCollider.gameObject.name
        local buildingItem = self:__GetBuildingItemByName(hitName)
        if buildingItem ~= nil then
          local buildingData = buildingItem.buildingData
          self:__ResetSelectedBuilding()
          self:SelectOasisBuilding(buildingItem, false)
          self.__selectedBuildingLastPos = buildingData.position
          self.__selectedBuildingLastAreaId = buildingData.area
          self.__originalPosition = buildingItem.rootTransform.position
          self:__ShowSelectBuildFx(buildingItem, buildingData.size)
          self.__selectedBuildFx:SetBuildSelectFxValid(true)
          self.__selectBuildOverlap = false
          return
        end
      end
    end
    self:__ResetSelectedBuilding()
    self:UnselectOasisBuilding(false)
  end
end

function OasisController:_ClickAreaRuin(gameObject)
  local areaEntity = self.areaRuinGoDic[gameObject]
  if areaEntity == nil then
    return false
  end
  local areaId = areaEntity:GetOasisAreaEntityId()
  local areaData = self.oasisAreaList[areaEntity.areaId]
  local unlock = PlayerDataCenter.AllBuildingData:OsisAreaUnlock(areaId)
  if not unlock then
    local cfg = areaData.cfg
    if CheckCondition.CheckLua(cfg.pre_condition, cfg.pre_para1, cfg.pre_para2) then
      self:ReqUnlockOasisArea(areaId)
    else
      local lockInfo = CheckCondition.GetUnlockInfoLua(cfg.pre_condition, cfg.pre_para1, cfg.pre_para2)
      cs_MessageCommon.ShowMessageTipsWithErrorSound(lockInfo)
    end
  end
  return true
end

function OasisController:SelectOasisBuilding(buildingItem, isInfo)
  if self.__selectedBuilding == buildingItem then
    return
  end
  AudioManager:PlayAudioById(1091)
  local mainWindow = UIManager:GetWindow(UIWindowTypeID.OasisMain)
  if self.__selectedBuilding ~= nil then
    if self.canvas ~= nil then
      self.canvas:ShowBuildingName3dItem(self.__selectedBuilding.id, true)
    end
    if isInfo and mainWindow ~= nil then
      mainWindow.oasisResNode:ShowOasisResUIItem(self.__selectedBuilding.id, true)
    end
  end
  self.__selectedBuilding = buildingItem
  if self.canvas ~= nil then
    self.canvas:ShowBuildingName3dItem(buildingItem.id, false)
  end
  if mainWindow ~= nil then
    mainWindow.oasisSelectNode:InitOasisBuildSelect(buildingItem.buildingData, buildingItem, not isInfo, isInfo)
  end
  if isInfo then
    if mainWindow ~= nil then
      mainWindow.oasisResNode:ShowOasisResUIItem(buildingItem.id, false)
    end
  else
    local editWindow = UIManager:GetWindow(UIWindowTypeID.OasisEditWindow)
    if editWindow ~= nil then
      editWindow:ShowOasisEditorSideTween(false)
    end
  end
end

function OasisController:UnselectOasisBuilding(isInfo)
  if self.__selectedBuilding == nil then
    return
  end
  self:__HideSelectBuildFx()
  if self.canvas ~= nil then
    self.canvas:ShowBuildingName3dItem(self.__selectedBuilding.id, true)
  end
  local mainWindow = UIManager:GetWindow(UIWindowTypeID.OasisMain)
  if mainWindow ~= nil then
    mainWindow.oasisSelectNode:Hide()
  end
  if isInfo then
    if mainWindow ~= nil then
      mainWindow.oasisResNode:ShowOasisResUIItem(self.__selectedBuilding.id, true)
    end
  else
    local editWindow = UIManager:GetWindow(UIWindowTypeID.OasisEditWindow)
    if editWindow ~= nil then
      editWindow:ShowOasisEditorSideTween(true)
    end
  end
  self.__selectedBuilding = nil
end

function OasisController:__ResetSelectedBuilding()
  if self.__selectedBuilding ~= nil then
    self:__HideSelectBuildFx()
    if self.__selectBuildOverlap then
      self:CancelBuildMove()
    end
  end
end

function OasisController:__LerpMoveBuilding(from, to)
  Vector3.Slerp(from, to, Time.deltaTime)
end

function OasisController:GetBuildingItemByGo(gameObject)
  for _, v in pairs(self.buildingItems) do
    if v.gameObject == gameObject then
      return v
    end
  end
  return nil
end

function OasisController:GetOasisBuildItemById(id)
  return self.buildingItems[id]
end

function OasisController:CheckBuildingOverlap(areaId, areaList)
  local oasisArea = self.oasisAreaList[areaId]
  local oasisAreaCfg = ConfigData.oasis_area[areaId]
  if oasisAreaCfg == nil then
    error("Can't find oasisAreaCfg, id = " .. tostring(areaId))
    return
  end
  local radius = oasisAreaCfg.size
  local used = false
  local cantMove = false
  for k, position in ipairs(areaList) do
    local distance = CoordinateConvert.HexDistance2Center(position)
    if radius <= distance then
      used = true
      cantMove = true
    end
    if oasisArea.buildingMap[position.x] ~= nil then
      if oasisArea.buildingMap[position.x][position.y] ~= nil then
        used = true
      end
      if oasisArea.buildingMap[position.x][position.y] == eBuildMapState.Obstacle then
        cantMove = true
      end
    end
  end
  return used, cantMove
end

function OasisController:UpdateBuildingMap(buildingData, oldAreaId, oldPosList)
  if oldPosList ~= nil then
    self:BuildInMap(oldAreaId, oldPosList, false)
  end
  local posList = buildingData:GetArea()
  self:BuildInMap(buildingData.area, posList, true, eBuildMapState.Built)
end

function OasisController:BuildInMap(areaId, positionList, build, buildMapState)
  local oasisArea = self.oasisAreaList[areaId]
  local oasisAreaCfg = ConfigData.oasis_area[areaId]
  if oasisAreaCfg == nil then
    error("Can't find oasisAreaCfg, id = " .. tostring(areaId))
    return
  end
  local radius = oasisAreaCfg.size
  for k, position in ipairs(positionList) do
    local distance = CoordinateConvert.HexDistance2Center(position)
    if radius < distance then
      error(string.format("oasis hex position out of range, areaId:%s, position(%s,%s)", areaId, position.x, position.y))
      return
    end
    if oasisArea.buildingMap[position.x] == nil then
      oasisArea.buildingMap[position.x] = {}
    end
    local value
    if build then
      value = buildMapState
    end
    oasisArea.buildingMap[position.x][position.y] = value
  end
end

function OasisController:__GenerateLittleMan()
  if self.oasisLittleManCtrl ~= nil then
    self.oasisLittleManCtrl:GenerateLittleMan(self.buildingItems, self.oasisAreaList)
  end
end

function OasisController:RemoveLittleMan(isClearCache)
  if self.oasisLittleManCtrl ~= nil then
    self.oasisLittleManCtrl:RemoveLittleMan(isClearCache)
  end
end

function OasisController:__GetBuildingItemByName(name)
  if string.IsNullOrEmpty(name) then
    return nil
  end
  local id
  if string.sub(name, 1, 1) == "#" then
    id = name
  else
    id = tonumber(name)
  end
  return self.buildingItems[id]
end

function OasisController:__ShowResidentUI(show)
  if show then
    local mainWindow = UIManager:GetWindow(UIWindowTypeID.OasisMain)
    if mainWindow ~= nil then
      mainWindow:OnEnterOasisEditMode(false)
    end
  end
end

function OasisController:UpdateProcessEvent(id, progress, remainTimeText, waitConfirmOver)
  local buildingItem = self.buildingItems[id]
  if buildingItem ~= nil then
    buildingItem:UpdateProcessUI(progress, remainTimeText, waitConfirmOver)
  end
end

function OasisController:OasisBackToHome()
  if self.backToHomeEvent ~= nil then
    self.backToHomeEvent()
    self.backToHomeEvent = nil
  end
end

function OasisController:OnExitOasis()
  JumpManager.couldUseItemJump = false
  self.__selectedBuilding = nil
  self.__oasisState = OasisEnum.OasisState.None
  if self.__enterCoroutine ~= nil then
    GR.StopCoroutine(self.__enterCoroutine)
  end
  MsgCenter:RemoveListener(eMsgEventId.BuildingUpgradeComplete, self.__ConfirmOver)
  MsgCenter:RemoveListener(eMsgEventId.UpdateBuildingProcess, self.__UpdateProcessEvent)
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__onItemRefresh)
  MsgCenter:RemoveListener(eMsgEventId.UpdateARGItem, self.__onItemRefresh)
  MsgCenter:RemoveListener(eMsgEventId.OnSectorStageStateChange, self.__onSectorStageStateChange)
  self.isEnter = false
  self:__ChangeBgm(cs_SkyController.Instance.IsDay)
  cs_CameraController.Instance:DragEnable(false)
  self:RemoveLittleMan(true)
  UIManager:DeleteWindow(UIWindowTypeID.OasisEditWindow)
  UIManager:DeleteWindow(UIWindowTypeID.OasisMain)
  UIManager:DeleteWindow(UIWindowTypeID.USkySystem)
  ControllerManager:DeleteController(ControllerTypeId.BuildingQueue)
  if self.canvas ~= nil then
    self.canvas:OnDelete()
    self.canvas = nil
  end
  if self.focusDirector ~= nil and self.focusDirectorStopped ~= nil then
    self.focusDirector:stopped("-", self.focusDirectorStopped)
  end
  cs_LeanTouch.OnFingerDown("-", self.__onFingerDown)
  cs_LeanTouch.OnFingerSet("-", self.__onFingerSet)
  cs_LeanTouch.OnFingerUp("-", self.__onFingerUp)
  cs_LeanTouch.OnFingerTap("-", self.__onFingerTap)
  self.bind.effects.gameObject:SetActive(false)
  self.__inputMode = InputMode.None
  self.weatherCtrl:OnExitOasis()
end

function OasisController:OnDelete()
  UpdateManager:RemoveUpdate(self.__update__handle)
  UpdateManager:RemoveLateUpdate(self.__lateUpdateHandle)
  if self.isEnter then
    self:OnExitOasis()
  end
  if self.oasisLittleManCtrl ~= nil then
    self:RemoveLittleMan(true)
    self.oasisLittleManCtrl:RemoveLittleManPoint()
  end
  if self.oasisWeatherCtrl ~= nil then
    self.oasisWeatherCtrl:OnDelete()
  end
  if self.__initCo ~= nil then
    GR.StopCoroutine(self.__initCo)
    self.__initCo = nil
  end
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  for k, v in pairs(self.buildingItems) do
    v:OnDelete()
  end
  self.buildingItems = {}
  self.oasisUIModel = nil
  if self._effectPool ~= nil then
    for k, effectList in pairs(self._effectPool) do
      for k2, effectEntity in ipairs(effectList) do
        effectEntity:OnDelete()
      end
    end
    self._effectPool = nil
  end
  if self._effectInUseDic ~= nil then
    for effectEntity, _ in pairs(self._effectInUseDic) do
      effectEntity:OnDelete()
    end
    self._effectInUseDic = nil
  end
  self.jumpEvent = nil
  cs_SkyController.Instance.OnDayChange = nil
  for k, v in pairs(self.ctrls) do
    v:OnDelete()
  end
  base.OnDelete(self)
end

return OasisController
