require("cri_audio_help_controller")
AircraftDoorCfg = {
  [1] = {
    name = "fc_door_white.prefab",
    scaleY = 1,
    audioId = CriAudioIDConst.AircraftStoneDoorBUDC
  },
  [2] = {
    name = "fc_door_black.prefab",
    scaleY = 1,
    audioId = CriAudioIDConst.AircraftStoneDoorBUDC
  },
  [3] = {
    name = "fc_door_gray.prefab",
    scaleY = 1,
    audioId = CriAudioIDConst.AircraftStoneDoorBUDC
  },
  [4] = {
    name = "fc_door_nys.prefab",
    scaleY = 10,
    audioId = CriAudioIDConst.AircraftAirDoorBUDC
  }
}
local MaskLayer = {
  [1] = 1,
  [2] = 2,
  [3] = 3,
  [4] = 4,
  [5] = 5,
  [6] = 6,
  [7] = 6,
  [8] = 8,
  [9] = 9,
  [10] = 10,
  [11] = 11,
  [12] = 11,
  [13] = 13,
  [14] = 14,
  [15] = 15,
  [16] = 16
}
_class("AircraftSpaceDoor", Object)
AircraftSpaceDoor = AircraftSpaceDoor

function AircraftSpaceDoor:Constructor(spaceId, parentTrans)
  self.spaceId = spaceId
  local aircraftModule = GameGlobal.GetModule(AircraftModule)
  local cfg = Cfg.cfg_aircraft_space[spaceId]
  local type = cfg.Mat
  local uiCfg = AircraftDoorCfg[type]
  if not uiCfg then
    Log.exception("[AircraftDoor] 找不到门配置：", type)
  end
  local prefab = uiCfg.name
  local scaleY = uiCfg.scaleY
  self.audioId = uiCfg.audioId
  AudioHelperController.RequestUISoundSync(self.audioId)
  self.doorRequest = ResourceManager:GetInstance():SyncLoadAsset(prefab, LoadType.GameObject)
  self.doorGO = self.doorRequest.Obj
  self.doorGO.transform:SetParent(parentTrans, false)
  self.doorGO.transform.localPosition = Vector3.zero
  self.doorGO.transform.localEulerAngles = Vector3.zero
  self.doorGO.transform.localScale = Vector3.one
  local doorAniTrans = self.doorGO.transform:GetChild(0)
  local doorMaskTrans = self.doorGO.transform:GetChild(1)
  self.ac = doorAniTrans:GetComponent("Animator")
  if not cfg.Size then
    Log.exception("找不到门尺寸配置：", spaceId)
  end
  doorMaskTrans.localScale = Vector3(cfg.Size[1], scaleY, cfg.Size[2])
  self:SetDoorMat(doorAniTrans)
  local doorMaskMesh = doorMaskTrans:GetComponent(typeof(UnityEngine.MeshRenderer))
  local _mpb = UnityEngine.MaterialPropertyBlock:New()
  doorMaskMesh.material:SetInt("_StencilRef", MaskLayer[self.spaceId])
  doorMaskMesh:SetPropertyBlock(_mpb)
  local roomData = aircraftModule:GetRoom(self.spaceId)
  if roomData then
    self.doorGO:SetActive(false)
  else
    self.doorGO:SetActive(true)
  end
end

function AircraftSpaceDoor:Dispose()
  if self.doorRequest then
    self.doorRequest:Dispose()
  end
  AudioHelperController.ReleaseUISoundById(self.audioId)
  self.doorRequest = nil
  self.doorGO = nil
  self.ac = nil
end

function AircraftSpaceDoor:SetDoorMat(doorAniTrans, mat)
  local components = doorAniTrans:GetComponentsInChildren(typeof(UnityEngine.SkinnedMeshRenderer))
  if components.Length > 0 then
    for i = 0, components.Length - 1 do
      local skinnedMesh = components[i]
      skinnedMesh.material:SetInt("_StencilRef", MaskLayer[self.spaceId])
    end
  else
    local components2 = doorAniTrans:GetComponentsInChildren(typeof(UnityEngine.MeshRenderer))
    if components2.Length > 0 then
      for i = 0, components2.Length - 1 do
        local mesh = components2[i]
        mesh.material:SetInt("_StencilRef", MaskLayer[self.spaceId])
      end
    end
  end
end

function AircraftSpaceDoor:Open()
  self.doorGO:SetActive(true)
  self.ac:CrossFade("open", 0)
  AudioHelperController.PlayRequestedUISound(self.audioId)
  return 3000
end

function AircraftSpaceDoor:Close()
  self.doorGO:SetActive(true)
  self.ac:CrossFade("close", 0)
  return 3000
end

function AircraftSpaceDoor:AnimStop()
  self.doorGO:SetActive(false)
  AudioHelperController.StopUIVoice(self.audioId, 0)
end
