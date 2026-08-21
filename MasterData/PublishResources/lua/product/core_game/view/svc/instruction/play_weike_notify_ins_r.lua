require("notify_extends")
require("base_ins_r")
_class("PlayWeikeNotifyInstruction", BaseInstruction)
PlayWeikeNotifyInstruction = PlayWeikeNotifyInstruction
local notifyClsDic = {
  [NotifyType.Pet1601781SkillHolder1] = NTPet1601781SkillHolder1,
  [NotifyType.Pet1601781SkillHolder2] = NTPet1601781SkillHolder2,
  [NotifyType.Pet1601781SkillHolder3] = NTPet1601781SkillHolder3
}

function PlayWeikeNotifyInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local results = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.WeikeNotify)
  for _, result in ipairs(results) do
    local notifyType = result:GetNotifyType()
    local skillType = result:GetSkillType()
    local casterPos = result:GetCasterPos()
    local multiCastCount = result:GetMultiCastCount()
    local notifyCls = notifyClsDic[notifyType]
    if notifyCls then
      local notify = notifyCls:New(skillType, casterPos, multiCastCount)
      world:GetService("PlayBuff"):PlayBuffView(TT, notify)
    end
  end
end
