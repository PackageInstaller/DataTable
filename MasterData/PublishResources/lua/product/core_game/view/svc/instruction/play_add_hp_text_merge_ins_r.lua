require("base_ins_r")
_class("PlayAddHpTextMergeInstruction", BaseInstruction)
PlayAddHpTextMergeInstruction = PlayAddHpTextMergeInstruction

function PlayAddHpTextMergeInstruction:Constructor(paramList)
end

function PlayAddHpTextMergeInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local playDamageService = world:GetService("PlayDamage")
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local addHpResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.AddBlood)
  if not addHpResultArray then
    return
  end
  local addHpResult = addHpResultArray[1]
  local targetID = addHpResult:GetTargetID()
  local targetEntity = world:GetEntityByID(targetID)
  local skillID = skillEffectResultContainer:GetSkillID()
  local gridPos = addHpResult:GetGridPos()
  if not targetEntity then
    Log.error("[PlayInstruction_AddHpText] 没有找到目标， nSkillID = ", skillID, ", TargetID = ", targetID)
  end
  local damageShowType = playDamageService:SingleOrGrid(skillID)
  local addValue = 0
  local mazeDamageList = {}
  local mazeTeamMemberDamageList = {}
  for i = 1, #addHpResultArray do
    local result = addHpResultArray[i]
    addValue = addValue + result:GetAddValue()
    local damageInfo = result:GetDamageInfo()
    if damageInfo:GetMazeDamageList() then
      for entityID, damageValue in pairs(damageInfo:GetMazeDamageList()) do
        if not mazeDamageList[entityID] then
          mazeDamageList[entityID] = 0
        end
        mazeDamageList[entityID] = mazeDamageList[entityID] + damageValue
      end
    end
    if damageInfo:GetMazeTeamMemberDamageList() then
      for entityID, damageInfo in pairs(damageInfo:GetMazeTeamMemberDamageList()) do
        mazeTeamMemberDamageList[entityID] = damageInfo
      end
    end
  end
  local mergeDamageInfo = DamageInfo:New(addValue, DamageType.Recover)
  mergeDamageInfo:SetMazeDamageList(mazeDamageList)
  mergeDamageInfo:SetMazeTeamMemberDamageList(mazeTeamMemberDamageList)
  mergeDamageInfo:SetShowType(damageShowType)
  mergeDamageInfo:SetChangeHP(addValue)
  mergeDamageInfo:SetRenderGridPos(gridPos)
  playDamageService:AsyncUpdateHPAndDisplayDamage(targetEntity, mergeDamageInfo)
end
