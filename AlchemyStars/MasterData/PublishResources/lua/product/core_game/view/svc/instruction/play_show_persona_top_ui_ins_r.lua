require("base_ins_r")
_class("PlayShowPersonaTopUiInstruction", BaseInstruction)
PlayShowPersonaTopUiInstruction = PlayShowPersonaTopUiInstruction

function PlayShowPersonaTopUiInstruction:Constructor(paramList)
  self._show = tonumber(paramList.show)
  self._tarCamera = paramList.tarCamera
  self._petHead = paramList.petHead
  self._petWord = paramList.petWord
  self._animName = paramList.anim
end

function PlayShowPersonaTopUiInstruction:DoInstruction(TT, casterEntity, phaseContext)
  if self._show and self._show == 1 then
    local effCam
    if self._tarCamera then
      local camera1 = UnityEngine.GameObject.Find(self._tarCamera)
      if camera1 then
        effCam = camera1:GetComponent("Camera")
      end
    end
    GameGlobal.UIStateManager():ShowDialog("UIBattlePersonaSkillEffTop", effCam, self._petHead, self._petWord, false, self._animName)
  else
    GameGlobal.UIStateManager():CloseDialog("UIBattlePersonaSkillEffTop")
  end
end
