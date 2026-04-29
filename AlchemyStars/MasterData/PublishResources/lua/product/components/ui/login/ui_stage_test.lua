_class("UIStageTestController", UIController)
UIStageTestController = UIStageTestController

function UIStageTestController:OnShow(uiParams)
  self._sceneInput = self:GetUIComponent("InputField", "InputField")
  self._PetIDInputFieldInput = self:GetUIComponent("InputField", "PetIDInputField")
  self._sceneInput.text = "ftzc"
  UnityEngine.Application.targetFrameRate = 500
  self._petPrefabRes = {}
  self._petBattleAniRes = {}
end

function UIStageTestController:BtnBackOnClick()
  self:SwitchState(UIStateType.Login)
end

function UIStageTestController:BtnSwitchOnClick()
  local nextSceneName = self._sceneInput.text
  if nextSceneName == "pet" then
    self:LoadPet(1400402)
    self:LoadPet(1300521)
    self:LoadPet(1400161)
    self:LoadPet(1400571)
    self:LoadPet(1500331)
  else
    GameGlobal.UIStateManager():ShowBusy(true)
    GameGlobal.UIStateManager():Lock("BtnBackOnClick")
    GameGlobal.TaskManager():StartTask(self.SwitchScene, self, nextSceneName)
  end
end

function UIStageTestController:SwitchScene(TT, nextSceneName)
  GameGlobal.GameLogic():LoadScene(TT, nextSceneName)
  GameGlobal.UIStateManager():UnLock("BtnBackOnClick")
  GameGlobal.UIStateManager():ShowBusy(false)
end

function UIStageTestController:OnHide()
  UnityEngine.Application.targetFrameRate = 30
end

function UIStageTestController:BtnLod0OnClick()
  LODManager.Instance:SetLODLevel(0)
end

function UIStageTestController:BtnLod1OnClick()
  LODManager.Instance:SetLODLevel(1)
end

function UIStageTestController:BtnLod2OnClick()
  LODManager.Instance:SetLODLevel(2)
end

function UIStageTestController:BtnPetOnClick()
  local petid = self._PetIDInputFieldInput.text
  self:LoadPet(petid)
end

function UIStageTestController:BtnUnloadPetOnClick()
  local petid = self._PetIDInputFieldInput.text
  local petrequest = self._petPrefabRes[petid]
  if petrequest ~= nil then
    petrequest:Dispose()
  end
  local anirequest = self._petBattleAniRes[petid]
  if anirequest ~= nil then
    anirequest:Dispose()
  end
end

function UIStageTestController:BtnTeamOnClick()
  self:LoadPet(1400402)
  self:LoadPet(1300521)
  self:LoadPet(1400161)
  self:LoadPet(1400571)
  self:LoadPet(1500331)
end

function UIStageTestController:LoadPet(petID)
  Log.debug("UIStageTestController:LoadPet", petID)
  local assetname = petID .. ".prefab"
  local request = ResourceManager:GetInstance():SyncLoadAsset(assetname, LoadType.GameObject)
  if request == nil then
    Log.fatal("LoadGameObject failed", "[" .. assetname .. "]")
    return
  end
  local u3dGo = request.Obj
  u3dGo:SetActive(true)
  u3dGo.transform.position = Vector3(math.random(-4, 4), 0, math.random(-4, 4))
  self._petPrefabRes[petID] = request
  local ani_battle_name = petID .. "_battle.prefab"
  local ani_request = ResourceManager:GetInstance():SyncLoadAsset(ani_battle_name, LoadType.GameObject)
  if ani_request == nil then
    Log.fatal("LoadGameObject failed", "[" .. ani_battle_name .. "]")
    return
  end
  local animatorController = ani_request.Obj:GetComponent(typeof(UnityEngine.Animator)).runtimeAnimatorController
  if animatorController == nil then
    Log.error("[ani] getAnimatorController Error", ani_request.m_Name)
  end
  u3dGo:GetComponentInChildren(typeof(UnityEngine.Animator)).runtimeAnimatorController = animatorController
  ani_request.Obj:SetActive(false)
  self._petBattleAniRes[petID] = ani_request
end
