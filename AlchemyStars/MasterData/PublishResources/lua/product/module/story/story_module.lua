_class("StoryModule", GameModule)
StoryModule = StoryModule
StoryModule = StoryModule

function StoryModule:Constructor()
end

function StoryModule:Init()
  self.mStoryAffinity = {}
  self.mStoryAffinityRes = ResourceHelper:GetInstance():GetStoryAffinity()
end

function StoryModule:StartStory(storyID, endCallback, closeSelf)
  GameGlobal.UIStateManager():ShowDialog("UIStoryController", storyID, endCallback, closeSelf)
end

function StoryModule:IsFinish(storyId)
  local ids = self.mStoryAffinityRes:GetStoryIds(storyId)
  if ids == nil then
    return true
  end
  for k, v in pairs(ids) do
    if self.mStoryAffinity[k] ~= true then
      return false
    end
  end
  return true
end

function StoryModule:IsAdded(StoryID, ParagraphID, SectionID)
  local ids = self.mStoryAffinityRes:GetStoryOptionIds(StoryID, ParagraphID, SectionID)
  if ids == nil then
    return true
  end
  for k, v in pairs(ids) do
    if self.mStoryAffinity[k] == true then
      return true
    end
  end
  return false
end

function StoryModule:ReqAddMsg(TT, StoryID, ParagraphID, SectionID, OptionID)
  local res = AsyncRequestRes:New()
  local cfg = self.mStoryAffinityRes:GetCfgID(StoryID, ParagraphID, SectionID, OptionID)
  if cfg == nil then
    res:SetSucc(false)
    res:SetResult(ROLE_RESULT_CODE.ROLE_STORYAFFINITY_NO_ID)
    return res
  end
  if self:IsFinishSPO(cfg.ID) == true then
    res:SetSucc(false)
    res:SetResult(ROLE_RESULT_CODE.ROLE_STORYAFFINITY_RECEIVED)
    return res
  end
  if self:GetModule(PetModule):HasPet(cfg.PetID) ~= true then
    res:SetSucc(false)
    res:SetResult(ROLE_RESULT_CODE.ROLE_STORYAFFINITY_NO_PET)
    return res
  end
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventAddStoryAffinity)
  request.id = cfg.ID
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res
  end
  local replyEvent = reply.msg
  if replyEvent.ret == ROLE_RESULT_CODE.ROLE_SUCCESS then
    res:SetSucc(true)
    self:AddSAData(replyEvent.id)
  else
    res:SetSucc(false)
  end
  res:SetResult(replyEvent.ret)
  return res
end

function StoryModule:SetSAData(info)
  if info == nil then
    return
  end
  for key, value in pairs(info) do
    self:AddSAData(value)
  end
end

function StoryModule:AddSAData(cfgID)
  local ids = self.mStoryAffinityRes:GetStoryOptionIdsById(cfgID)
  if ids == nil then
    return
  end
  for k, v in pairs(ids) do
    self.mStoryAffinity[k] = true
  end
end

function StoryModule:IsFinishSPO(cfgID)
  local ids = self.mStoryAffinityRes:GetStoryOptionIdsById(cfgID)
  if ids == nil then
    return true
  end
  for k, v in pairs(ids) do
    if self.mStoryAffinity[k] == true then
      return true
    end
  end
  return false
end
