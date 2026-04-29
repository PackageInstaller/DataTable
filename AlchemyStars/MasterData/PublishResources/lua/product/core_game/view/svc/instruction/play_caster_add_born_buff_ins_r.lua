require("base_ins_r")
_class("PlayCasterAddBornBuffInstruction", BaseInstruction)
PlayCasterAddBornBuffInstruction = PlayCasterAddBornBuffInstruction

function PlayCasterAddBornBuffInstruction:Constructor(paramList)
end

function PlayCasterAddBornBuffInstruction:DoInstruction(TT, casterEntity, phaseContext)
  if casterEntity:MonsterID() then
    local sPlayBuff = casterEntity:GetOwnerWorld():GetService("PlayBuff")
    local buffViewComponent = casterEntity:BuffView()
    if buffViewComponent then
      local viewIns = buffViewComponent:GetBuffViewInstanceArray()
      for _, inst in ipairs(viewIns) do
        local context = inst:GetBuffViewContext()
        if context and context.isMonsterBornBuff then
          sPlayBuff:PlayAddBuff(TT, inst)
        end
      end
    end
  end
end
