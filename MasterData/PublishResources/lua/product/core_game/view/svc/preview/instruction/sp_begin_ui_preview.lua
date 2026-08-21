require("sp_base_inst")
_class("SkillPreviewBeginUIPreviewInstruction", SkillPreviewBaseInstruction)
SkillPreviewBeginUIPreviewInstruction = SkillPreviewBeginUIPreviewInstruction

function SkillPreviewBeginUIPreviewInstruction:Constructor(params)
end

function SkillPreviewBeginUIPreviewInstruction:DoInstruction(TT, casterEntity, previewContext)
  self._world = previewContext:GetWorld()
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  local teamMembers = teamEntity:Team():GetTeamPetEntities()
  local petListInfo = {}
  local effectList = previewContext:GetEffect(SkillEffectType.AppointCastChain)
  local previewEffectCalcService = self._world:GetService("PreviewCalcEffect")
  local effectParam = previewEffectCalcService:CreateSkillEffectParam(SkillEffectType.AppointCastChain, effectList)
  local baseValue = effectParam:GetBaseValue()
  local mulValue = effectParam:GetMulValue()
  local utilDataSvc = self._world:GetService("UtilData")
  for _, petEntity in ipairs(teamMembers) do
    if petEntity:GetID() ~= casterEntity:GetID() and not petEntity:HasDeadMark() then
      local cPstId = petEntity:PetPstID()
      local pstId = cPstId:GetPstID()
      petListInfo[pstId] = utilDataSvc:GetPetExtraChainCastCount(pstId, baseValue, mulValue)
    end
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.IstavanShowPetHeadPreviewUI, petListInfo)
end
