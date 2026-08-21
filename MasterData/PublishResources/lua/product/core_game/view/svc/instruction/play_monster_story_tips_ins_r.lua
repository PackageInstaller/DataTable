require("base_ins_r")
_class("PlayMonsterStoryTipsInstruction", BaseInstruction)
PlayMonsterStoryTipsInstruction = PlayMonsterStoryTipsInstruction

function PlayMonsterStoryTipsInstruction:Constructor(paramList)
  self._prob = tonumber(paramList.prob)
  self._storyList = {}
  local paramStr = paramList.tipsList
  local stringLen = string.len(paramStr)
  local tipsStr = string.sub(paramStr, 2, stringLen - 1)
  local splitStrArray = string.split(tipsStr, ",")
  for k, v in ipairs(splitStrArray) do
    self._storyList[#self._storyList + 1] = tonumber(v)
  end
end

function PlayMonsterStoryTipsInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local rand = Mathf.Random(1, 100)
  if rand <= self._prob then
    local index = Mathf.Random(1, #self._storyList)
    local innerStoryService = world:GetService("InnerStory")
    if casterEntity:MonsterID() then
      innerStoryService:DoMonsterStoryTips(casterEntity:MonsterID():GetMonsterID(), casterEntity:GetID(), self._storyList[index])
    elseif casterEntity:TrapRender() then
      innerStoryService:DoTrapStoryTips(casterEntity:TrapRender():GetTrapID(), casterEntity, self._storyList[index])
    end
  end
end
