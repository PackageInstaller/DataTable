require("sp_base_inst")
_class("SkillPreviewPlayCasterActiveInstruction", SkillPreviewBaseInstruction)
SkillPreviewPlayCasterActiveInstruction = SkillPreviewPlayCasterActiveInstruction

function SkillPreviewPlayCasterActiveInstruction:Constructor(params)
  self._enable = params.Enable
  self._syncHP = params.SyncHP
end

function SkillPreviewPlayCasterActiveInstruction:DoInstruction(TT, casterEntity, previewContext)
  if self._enable == "false" then
    casterEntity:View():GetGameObject():SetActive(false)
  end
  if self._enable == "true" then
    casterEntity:View():GetGameObject():SetActive(true)
  end
  if self._syncHP then
    local world = casterEntity:GetOwnerWorld()
    local teamEntity
    if casterEntity:HasPet() then
      teamEntity = casterEntity:Pet():GetOwnerTeamEntity()
    end
    local hpComponent = teamEntity:HP()
    if not hpComponent then
      return
    end
    local sliderEntityId = hpComponent:GetHPSliderEntityID()
    local sliderEntity = world:GetEntityByID(sliderEntityId)
    if not sliderEntity then
      return
    end
    local isHide = self._enable == "false"
    hpComponent:SetHPBarTempHide(isHide)
    hpComponent:SetHPPosDirty(true)
    if not isHide then
      teamEntity:ReplaceHPComponent()
    end
  end
end
