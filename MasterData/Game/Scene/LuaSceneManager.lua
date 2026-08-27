local LuaSceneManager = {}
local cs_GSceneManager_Ins = CS.GSceneManager.Instance

function LuaSceneManager:Init()
  self.__onSceneLoaded = BindCallback(self, self.OnSceneLoaded)
  self.__onAfterSceneLoaded = BindCallback(self, self.OnAfterSceneLoaded)
  self.__onSceneUnloaded = BindCallback(self, self.OnSceneUnloaded)
  self.__onActiveSceneChanged = BindCallback(self, self.OnActiveSceneChanged)
  cs_GSceneManager_Ins:onSceneLoaded("+", self.__onSceneLoaded)
  cs_GSceneManager_Ins:onAfterSceneLoaded("+", self.__onAfterSceneLoaded)
  cs_GSceneManager_Ins:onSceneUnLoaded("+", self.__onSceneUnloaded)
  cs_GSceneManager_Ins:onActiveSceneChanged("+", self.__onActiveSceneChanged)
end

function LuaSceneManager:OnSceneLoaded(scene, loadSceneMode)
  if scene.name == Consts.SceneName.Main then
    local mainCamera = UIManager:GetMainCamera()
    if not IsNull(mainCamera) then
      local bind = mainCamera:FindComponent(eUnityComponentID.LuaBinding)
      local oasisLockNode = bind:GetBind("oasisLockNode")
      local isOasisMask = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_BuildingMask)
      if not IsNull(oasisLockNode) then
        oasisLockNode:SetActive(not isOasisMask)
      end
    end
  end
end

function LuaSceneManager:OnAfterSceneLoaded(scene, loadSceneMode, isBeforeCallback)
  if isBeforeCallback then
    self:OnSceneLoadedBefore(scene, loadSceneMode)
  else
    self:OnSceneLoadedAfter(scene, loadSceneMode)
  end
end

function LuaSceneManager:OnSceneLoadedBefore(scene, loadSceneMode)
  if scene.name ~= Consts.SceneName.Main or GuideManager:TryTriggerGuide(eGuideCondition.InMainScene) then
  end
end

function LuaSceneManager:OnSceneLoadedAfter(scene, loadSceneMode)
  if scene.name == Consts.SceneName.Sector then
    GuideManager:TryTriggerGuide(eGuideCondition.FInSectorScene)
  end
end

function LuaSceneManager:OnSceneUnloaded(scene)
  local name = scene.name
  MsgCenter:Broadcast(eMsgEventId.OnSceneUnload, name)
  UIUtil.ClearTopHome()
end

function LuaSceneManager:OnActiveSceneChanged(scene1, scene2)
end

function LuaSceneManager:GetCurrentScene()
  return CS.UnityEngine.SceneManagement.SceneManager.GetActiveScene()
end

LuaSceneManager:Init()
return LuaSceneManager
