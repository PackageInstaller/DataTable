require("cutscene_base_ins_r")
_class("CutsceneMonsterAnimationInstruction", CutsceneBaseInstruction)
CutsceneMonsterAnimationInstruction = CutsceneMonsterAnimationInstruction

function CutsceneMonsterAnimationInstruction:Constructor(paramList)
  self._animName = paramList.anim
  self._name = paramList.name
end

function CutsceneMonsterAnimationInstruction:DoInstruction(TT, phaseContext)
  local world = phaseContext:GetCutsceneWorld()
  local cutsceneServiceRender = world:GetService("Cutscene")
  for i, entity in ipairs(cutsceneServiceRender:GetCutsceneMonsterGroupEntity()) do
    local cutsceneMonsterComponent = entity:CutsceneMonster()
    if cutsceneMonsterComponent:GetCutsceneMonsterName() == self._name then
      entity:SetAnimatorControllerTriggers({
        self._animName
      })
    end
  end
  Log.fatal("剧情指令，播放动作")
end
