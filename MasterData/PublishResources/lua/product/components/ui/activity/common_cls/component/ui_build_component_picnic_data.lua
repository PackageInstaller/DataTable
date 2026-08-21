_class("UIBuildComponentPicnicData", Object)
UIBuildComponentPicnicData = UIBuildComponentPicnicData

function UIBuildComponentPicnicData:Constructor(componentCfgID)
  self._componentCfgID = componentCfgID
  local cfgs = Cfg.cfg_component_picnic({ComponentID = componentCfgID})
  self._picnicDataList = self:_InitPicnicDataList(cfgs)
  self._picnicDataStoryReviewIdMap = self:_InitPicnicDataStoryReviewIdMap(cfgs)
end

function UIBuildComponentPicnicData:_InitPicnicDataList(tb_in)
  local tb_map = {}
  for _, v in pairs(tb_in) do
    local id = v.Seq
    if not tb_map[id] then
      tb_map[id] = v
    else
      Log.exception("UIBuildComponentPicnicData:_InitPicnicDataList()", " repeat [Seq] in cfg_component_picnic", " componentCfgID = " .. self._componentCfgID)
    end
  end
  local tb_out = table.collect(tb_map)
  for i, v in ipairs(tb_out) do
    if i ~= v.Seq then
      Log.exception("UIBuildComponentPicnicData:_InitPicnicDataList()", " [Seq] = " .. i .. " has not found in cfg_component_picnic", " componentCfgID = " .. self._componentCfgID)
    end
  end
  return tb_out
end

function UIBuildComponentPicnicData:_InitPicnicDataStoryReviewIdMap(tb_in)
  local tb_out = {}
  for _, v in pairs(tb_in) do
    local reviewId = v.StoryReviewId
    if reviewId then
      if tb_out[reviewId] then
        Log.exception("UIBuildComponentPicnicData:_InitPicnicDataStoryReviewIdMap()", " repeat [StoryReviewId] in cfg_component_picnic", " componentCfgID = " .. self._componentCfgID, " StoryReviewId = " .. reviewId)
      end
      tb_out[reviewId] = {
        seq = v.Seq
      }
    end
  end
  return tb_out
end

function UIBuildComponentPicnicData:GetPicnicData(seq)
  return self._picnicDataList[seq]
end

function UIBuildComponentPicnicData:GetPicnicFixedPetIdList(seq, count)
  local tb_out = {}
  for i = seq, seq + count - 1 do
    local pet = self:GetPicnicPet(i)
    if pet then
      table.insert(tb_out, pet)
    end
  end
  return tb_out
end

function UIBuildComponentPicnicData:GetPicnicPet(seq)
  local data = self:GetPicnicData(seq)
  return data and data.Pets and data.Pets[1]
end

function UIBuildComponentPicnicData:GetPicnicRewardList(seq)
  local tb_out = {}
  local data = self:GetPicnicData(seq)
  if data then
    for i = 1, #data.Reward do
      local roleAsset = RoleAsset:New()
      roleAsset.assetid = data.Reward[i][1]
      roleAsset.count = data.Reward[i][2]
      table.insert(tb_out, roleAsset)
    end
  end
  return tb_out
end

function UIBuildComponentPicnicData:GetPicnicStory(seq)
  local data = self:GetPicnicData(seq)
  return data and data.StoryId
end

function UIBuildComponentPicnicData:GetStoryReviewId(seq)
  local data = self:GetPicnicData(seq)
  return data and data.StoryReviewId
end

function UIBuildComponentPicnicData:GetPicnicDataStoryReviewIdMap()
  return self._picnicDataStoryReviewIdMap
end
