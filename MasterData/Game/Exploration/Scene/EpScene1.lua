local base = require("Game.Exploration.Scene.EpSceneA")
local EpScene1 = class("EpSceneA", base)
local CS_CameraController = CS.CameraController

function EpScene1:OnSceneLoadCompleted(onSceneLoadCompletedGeneral)
  base.OnSceneLoadCompleted(self, onSceneLoadCompletedGeneral)
  self.__ambienceAuBack = AudioManager:PlayAudioById(2000)
  CS_CameraController.Instance:SetCamHeightChangeFunc(BindCallback(self, self.__OnCamHeightChange))
  self.__onBattleEnter = BindCallback(self, self.OnBattleEnter)
  MsgCenter:AddListener(eMsgEventId.OnEnterBattle, self.__onBattleEnter)
  self.__onBattleExit = BindCallback(self, self.OnBattleExit)
  MsgCenter:AddListener(eMsgEventId.OnExitBattle, self.__onBattleExit)
end

function EpScene1:__OnCamHeightChange(heightRatio)
  AudioManager:SetSourceAisacControl(eAudioSourceType.SfxSource, "AisacControl_DistanceOfCameraLens", heightRatio)
end

function EpScene1:OnBattleEnter()
  AudioManager:SetSourceAisacControl(eAudioSourceType.SfxSource, "AisacControl_IsInCombat", 1)
end

function EpScene1:OnBattleExit()
  AudioManager:SetSourceAisacControl(eAudioSourceType.SfxSource, "AisacControl_IsInCombat", 0)
end

function EpScene1:OnDelete()
  if self.__ambienceAuBack ~= nil then
    AudioManager:StopAudioByBack(self.__ambienceAuBack)
    self.__ambienceAuBack = nil
  end
  CS_CameraController.Instance:SetCamHeightChangeFunc(nil)
  MsgCenter:RemoveListener(eMsgEventId.OnEnterBattle, self.__onBattleEnter)
  MsgCenter:RemoveListener(eMsgEventId.OnExitBattle, self.__onBattleExit)
  base.OnDelete(self)
end

return EpScene1
