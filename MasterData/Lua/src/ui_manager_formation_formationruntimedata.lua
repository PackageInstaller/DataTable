local this = class("formationRuntimeData")
local tInsert = table.insert
local sConcat = string.concat
local lfuCache = require("ui.manager.formation.lfuCache")
local camBlendPath = "Program/UIScene/ast_FormationBlends.asset"
local anyCamName = "**ANY CAMERA**"

function this:ctor(sceneGo)
  self.formationScene = sceneGo
  self.editStatus = L_FormationConst.FormationEditStatus.Overlook
  self.isPetStatus = false
  self.heroPoints = {}
  self.petPoints = {}
  self.modelCache = nil
  self.heroCache = {}
  self.heroPrefabIds = {}
  self.heroEntityCache = {}
  self.petCache = {}
  self.petPrefabIds = {}
  self.selectEffectPoint = {}
  self.petFlashObj = {}
  self.placeHeroes = {}
  self.placePets = {}
  self.focusIndex = nil
  self.focusEffect = {}
  self.admissionEffectMap = {}
  self.cameraNodeData = {}
  self.isLowMemory = C_DeviceGradeHelper.IsLowMemoryDevice()
  local lfuCacheMaxCount = 3
  if self.isLowMemory then
    lfuCacheMaxCount = 3
  end
  self.heroLfuCache = lfuCache.new(lfuCacheMaxCount)
  self.heroEntityDicLfu = {}
  self.cameraDurationMap = {}
  self.formationType = nil
  self.formationIndex = nil
  self.needRevertFormationScene = false
  self.loadingEntityId = {}
  self:_parseSceneModel()
end

function this:_parseSceneModel()
  local sceneTrans = self.formationScene.transform
  self.modelCache = sceneTrans:Find("pre_formation_ui_default/Model/Cache")
  self.cameraBlend = sceneTrans:Find("pre_formation_ui_default/CameraBlend").gameObject
  local pointTrans = sceneTrans:Find("pre_formation_ui_default/Model/Points")
  local selectEffectPointsTrans = sceneTrans:Find("pre_formation_ui_default/Model/SelectEffect")
  for i = 1, 3 do
    tInsert(self.heroPoints, pointTrans:Find(sConcat("point_hero_", i)))
    tInsert(self.petPoints, pointTrans:Find(sConcat("point_pet_", i)))
    tInsert(self.selectEffectPoint, selectEffectPointsTrans:Find(sConcat("pos", i)))
  end
  local cameraNode = sceneTrans:Find("pre_formation_ui_default/Camera")
  self.cameraNodeData = {}
  for _, name in pairs(L_FormationConst.FormationCamName) do
    self.cameraNodeData[name] = {}
    self.cameraNodeData[name].obj = cameraNode:Find(name).gameObject
    self.cameraNodeData[name].camera = cameraNode:Find(name):GetComponent(typeof(CS.Cinemachine.CinemachineVirtualCameraBase))
    if L_FormationConst.FormationCamTargetName[name] then
      self.cameraNodeData[name].targetObj = cameraNode:Find(L_FormationConst.FormationCamTargetName[name]).gameObject
    end
  end
  self.cameraDurationMap = {}
  local blenderSettingsHandle = C_LuaUtility.LoadBattleCinemachineBlenderSettingsConfig(camBlendPath)
  local blenderSettings = blenderSettingsHandle.config
  local customBlends = blenderSettings.m_CustomBlends
  for ii = 0, customBlends.Length - 1 do
    local blend = customBlends[ii]
    local fromName = blend.m_From
    local toName = blend.m_To
    local time = blend.m_Blend.BlendTime
    if fromName == anyCamName and toName ~= anyCamName then
      for _, name in pairs(L_FormationConst.FormationCamName) do
        self.cameraDurationMap[name] = self.cameraDurationMap[name] or {}
        self.cameraDurationMap[name][toName] = time
      end
    elseif toName == anyCamName and fromName ~= anyCamName then
      self.cameraDurationMap[fromName] = self.cameraDurationMap[fromName] or {}
      for _, name in pairs(L_FormationConst.FormationCamName) do
        self.cameraDurationMap[fromName][name] = time
      end
    elseif toName ~= anyCamName and fromName ~= anyCamName then
      self.cameraDurationMap[fromName] = self.cameraDurationMap[fromName] or {}
      self.cameraDurationMap[fromName][toName] = time
    end
  end
  C_LuaUtility.DestroyBattleCinemachineBlenderSettingsConfig(blenderSettingsHandle)
end

function this:refreshBlend()
  if self.cameraBlend then
    self.cameraBlend:SetActive(false)
    self.cameraBlend:SetActive(true)
  end
end

function this:destroy()
  C_EntityManager.ClearUIHeroEntity()
  for i, v in pairs(self.loadingEntityId) do
    C_EntityManager.RemoveEntityWithEntityId(v)
  end
  self.loadingEntityId = nil
  for i, v in pairs(self.heroEntityCache) do
    if v then
      C_MJLog.LogInfo(string.format("编队UI角色entity销毁 entityId:%d", v.entityId), C_ELogModule.FormationUI)
      v:onDestroy()
      v = nil
    end
  end
  table.clear(self.heroEntityCache)
  self.heroEntityCache = nil
  for guid, obj in pairs(self.petCache or {}) do
    if L_CommonUtil.isValid(obj) then
      C_GameObject.Destroy(obj)
    end
  end
  table.clear(self.petCache)
  self.petCache = nil
  for i, v in pairs(self.placeHeroes) do
    if v.entity then
      C_MJLog.LogInfo(string.format("编队UI角色entity销毁 entityId:%d", v.entity.entityId), C_ELogModule.FormationUI)
      v.entity:setActive(false)
      v.entity:onDestroy()
      v.entity = nil
    end
  end
  table.clear(self.placeHeroes)
  self.placeHeroes = nil
  for i, v in pairs(self.heroPrefabIds) do
    C_PrefabManager:RecycleByLoader(v)
  end
  for i, v in pairs(self.petPrefabIds) do
    C_PrefabManager:RecycleByLoader(v)
  end
  if L_CommonUtil.isValid(self.formationScene) then
    C_GameObject.Destroy(self.formationScene)
  end
  self.formationScene = nil
  for _, go in pairs(self.focusEffect) do
    if L_CommonUtil.isValid(go) then
      C_GameObject.Destroy(go)
    end
  end
  table.clear(self.focusEffect)
  self.focusEffect = nil
  for _, v in pairs(self.placePets) do
    if L_CommonUtil.isValid(v.obj) then
      v.entity:onDestroy()
      C_GameObject.Destroy(v.obj)
    end
    v.obj = nil
  end
  table.clear(self.placePets)
  self.placePets = nil
  for i, v in pairs(self.petFlashObj) do
    if L_CommonUtil.isValid(v) then
      C_GameObject.Destroy(v)
    end
    self.petFlashObj[i] = nil
  end
  table.clear(self.petFlashObj)
  self.petFlashObj = nil
  self.cameraBlend = nil
  self.heroLfuCache:Clear()
  self.heroLfuCache = nil
  self.heroEntityDicLfu = nil
end

return this
