require("sp_base_inst")
_class("SkillPreviewPlayActiveSkillAddBuffInstruction", SkillPreviewBaseInstruction)
SkillPreviewPlayActiveSkillAddBuffInstruction = SkillPreviewPlayActiveSkillAddBuffInstruction

function SkillPreviewPlayActiveSkillAddBuffInstruction:Constructor(params)
end

function SkillPreviewPlayActiveSkillAddBuffInstruction:DoInstruction(TT, casterEntity, previewContext)
  local world = previewContext:GetWorld()
  local targetIDList = previewContext:GetTargetEntityIDList()
  targetIDList = table.unique(targetIDList)
  local eids = {}
  for _, id in pairs(targetIDList) do
    local e = world:GetEntityByID(id)
    local cPstId = e:PetPstID()
    local pstId = cPstId:GetPstID()
    table.insert(eids, pstId)
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.PetShowPreviewArrow, eids)
end
