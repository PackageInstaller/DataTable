local DormFightCtrlBase = require("Game.Fight.Ctrl.DormFightCtrlBase")
local CS_AnimationEffectController_Ins = CS.AnimationEffectController.Instance
local CS_AnimationEffectConfig = CS.AnimationEffectConfig
local DormFightEffectCtrl = class("DormFightEffectCtrl", DormFightCtrlBase)

function DormFightEffectCtrl:ctor()
end

function DormFightEffectCtrl:AddFighterEffectByDormFightEffectId(fighterController, dormFightEffectId, resName, OriginResName)
  local animationEffectConfig = CS_AnimationEffectConfig()
  local cfg = ConfigData.dorm_fight_fx[dormFightEffectId]
  animationEffectConfig.EffectPath = CS_AnimationEffectConfig.GenEffectSrcPath(cfg.src_name, true, resName, OriginResName)
  animationEffectConfig.ResName = resName
  animationEffectConfig.OriginResName = OriginResName
  animationEffectConfig.BirthType = cfg.birth_type
  animationEffectConfig.BirthPoint = cfg.birth_point
  animationEffectConfig.BindPoint = cfg.bind_point
  animationEffectConfig.BindType = cfg.bind_type
  animationEffectConfig.Duration = cfg.exist_frame / 15
  animationEffectConfig.Layer = LayerMask.Character
  local effect = CS_AnimationEffectController_Ins:AddAnimationEffect(animationEffectConfig, fighterController.gameObject)
  effect:Play()
end

function DormFightEffectCtrl:ClearFighterEffect(fighterController)
  if IsNull(fighterController) then
    return
  end
  CS_AnimationEffectController_Ins:KillRoleEffect(fighterController.gameObject)
  CS_AnimationEffectController_Ins:RecycleRoleEffect(fighterController.gameObject)
end

function DormFightEffectCtrl:OnFightEnd()
  CS_AnimationEffectController_Ins:KillAllEffects()
  CS_AnimationEffectController_Ins:RecycleEffects()
end

return DormFightEffectCtrl
