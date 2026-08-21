require("base_ins_r")
_class("PlayAttachMonsterNotify", BaseInstruction)
PlayAttachMonsterNotify = PlayAttachMonsterNotify

function PlayAttachMonsterNotify:Constructor(paramList)
end

function PlayAttachMonsterNotify:DoInstruction(TT, casterEntity, phaseContext)
  self._world:GetService("PlayBuff"):PlayBuffView(TT, NTAttachMonster:New(casterEntity))
end
