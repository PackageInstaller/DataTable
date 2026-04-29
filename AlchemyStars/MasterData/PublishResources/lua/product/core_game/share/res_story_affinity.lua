_class("ResStoryAffinity", Object)
ResStoryAffinity = ResStoryAffinity

function ResStoryAffinity:Constructor()
  self:Init()
end

function ResStoryAffinity:Init()
  self._Res = {}
  self._ResOption = {}
  self._ResIds = {}
  local cfg = Cfg.cfg_story_affinity({})
  for k, v in pairs(cfg) do
    if self._Res[v.StoryID] == nil then
      self._Res[v.StoryID] = {}
    end
    if self._Res[v.StoryID][v.ParagraphID] == nil then
      self._Res[v.StoryID][v.ParagraphID] = {}
    end
    if self._Res[v.StoryID][v.ParagraphID][v.SectionID] == nil then
      self._Res[v.StoryID][v.ParagraphID][v.SectionID] = {}
    end
    self._Res[v.StoryID][v.ParagraphID][v.SectionID][v.OptionID] = v
    if self._ResOption[v.StoryID] == nil then
      self._ResOption[v.StoryID] = {}
    end
    if self._ResOption[v.StoryID][v.ParagraphID] == nil then
      self._ResOption[v.StoryID][v.ParagraphID] = {}
    end
    if self._ResOption[v.StoryID][v.ParagraphID][v.SectionID] == nil then
      self._ResOption[v.StoryID][v.ParagraphID][v.SectionID] = {}
    end
    self._ResOption[v.StoryID][v.ParagraphID][v.SectionID][v.ID] = v
    if self._ResIds[v.StoryID] == nil then
      self._ResIds[v.StoryID] = {}
    end
    self._ResIds[v.StoryID][v.ID] = v
  end
end

function ResStoryAffinity:GetCfgID(StoryID, ParagraphID, SectionID, OptionID)
  if self._Res[StoryID] == nil then
    Log.error("ResStoryAffinity:GetCfg StoryID error ", StoryID)
    return nil
  end
  if self._Res[StoryID][ParagraphID] == nil then
    Log.error("ResStoryAffinity:GetCfg StoryID ParagraphID error ", StoryID, ParagraphID)
    return nil
  end
  if self._Res[StoryID][ParagraphID][SectionID] == nil then
    Log.error("ResStoryAffinity:GetCfg StoryID ParagraphID SectionID error ", StoryID, ParagraphID, SectionID)
    return nil
  end
  local cfg = self._Res[StoryID][ParagraphID][SectionID][OptionID]
  if cfg == nil then
    Log.error("ResStoryAffinity:GetCfg StoryID ParagraphID SectionID OptionID error ", StoryID, ParagraphID, SectionID)
    return nil
  end
  return cfg
end

function ResStoryAffinity:GetStoryIds(StoryID)
  return self._ResIds[StoryID]
end

function ResStoryAffinity:GetStoryOptionIds(StoryID, ParagraphID, SectionID)
  if self._ResOption[StoryID] == nil then
    Log.error("ResStoryAffinity:GetStoryOptionIds StoryID error ", StoryID)
    return nil
  end
  if self._ResOption[StoryID][ParagraphID] == nil then
    Log.error("ResStoryAffinity:GetStoryOptionIds StoryID ParagraphID error ", StoryID, ParagraphID)
    return nil
  end
  if self._ResOption[StoryID][ParagraphID][SectionID] == nil then
    Log.error("ResStoryAffinity:GetStoryOptionIds StoryID ParagraphID SectionID error ", StoryID, ParagraphID, SectionID)
    return nil
  end
  return self._ResOption[StoryID][ParagraphID][SectionID]
end

function ResStoryAffinity:GetStoryOptionIdsById(cfgID)
  local cfg = Cfg.cfg_story_affinity[cfgID]
  if cfg == nil then
    Log.error("ResStoryAffinity:GetStoryOptionIdsById error ", cfgID)
    return nil
  end
  return self:GetStoryOptionIds(cfg.StoryID, cfg.ParagraphID, cfg.SectionID)
end
