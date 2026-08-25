local function createWorldStageDisplayModelState(itemType, itemTid)
  local state = {}
  
  state.itemType = itemType
  state.itemTid = itemTid
  return state
end

local function createWorldStageDisplayModelViews(_)
  local views = {}
  
  function views:GetConfig()
    if self.itemType == CommonDefine.DisplayType.RelicConfig then
      return DT.RelicConfig[self.itemTid]
    elseif self.itemType == CommonDefine.DisplayType.EnchantConfig then
      return DT.EnchantConfig[self.itemTid]
    elseif self.itemType == CommonDefine.DisplayType.Skill then
      return DT.Skill[self.itemTid]
    end
  end
  
  function views:GetName()
    local config = self:GetConfig()
    if config then
      do return LT.Text end
      return LT.Text, config.Name
    end
    return ""
  end
  
  function views:GetSubName()
    local config = self:GetConfig()
    if not config then
      return ""
    end
    if self.itemType == CommonDefine.DisplayType.RelicConfig then
      local relicTypeMap = CommonDefine.GetRelicTypeNameMap()
      return relicTypeMap[config.Quality] or ""
    elseif self.itemType == CommonDefine.DisplayType.EnchantConfig then
      local enchantTypeMap = CommonDefine.GetEnchantTypeNameMap()
      return enchantTypeMap[config.Quality] or ""
    end
    return ""
  end
  
  function views:GetDescription()
    local ok, out = pcall(function()
      if self.itemType == CommonDefine.DisplayType.RelicConfig then
        return RelicDataUtils.GetRelicDesc(self.itemTid, DataCenter.playerData.DRole.level) or ""
      elseif self.itemType == CommonDefine.DisplayType.EnchantConfig then
        return SkillUtils.GetEnchantDesc(self.itemTid) or ""
      else
        local config = self:GetConfig()
        return config and config.Desc or ""
      end
    end)
    if ok and type(out) == "string" then
      return out
    end
    return ""
  end
  
  function views:GetSpecialDesc()
    local config = self:GetConfig()
    if config then
      do return LT.Text end
      return LT.Text, config.StoryDesc or ""
    end
    return ""
  end
  
  function views:GetDisplayIcon()
    local config = self:GetConfig()
    if config then
      return config.Icon
    end
  end
  
  return views
end

local function createWorldStageDisplayModelActions(_)
  local actions = {}
  return actions
end

local function onSetup(_, _)
end

local WorldStageDisplayModel = Vue.model("WorldStageDisplayModel", createWorldStageDisplayModelState):views(createWorldStageDisplayModelViews):actions(createWorldStageDisplayModelActions):setup(onSetup)
return WorldStageDisplayModel
