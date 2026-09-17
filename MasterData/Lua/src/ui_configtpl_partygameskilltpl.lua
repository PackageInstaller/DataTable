local this = class("partygameSkillTpl")

local function resolveAssetPath(value)
  if value == nil then
    return ""
  end
  if type(value) == "table" then
    for _, v in ipairs(value) do
      if type(v) == "string" and v ~= "" then
        return v
      end
    end
    return ""
  end
  if type(value) == "number" then
    return L_Config:getPathByHash(value) or ""
  end
  if type(value) == "string" then
    return value
  end
  return ""
end

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getSkillId(tpl)
  return tpl.skillid
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getDesc(tpl)
  return L_Config:provider(tpl.description)
end

function this:getFigureIcon(tpl)
  return resolveAssetPath(tpl.figureicon)
end

function this:getButtonIcon(tpl)
  return resolveAssetPath(tpl.buttonicon)
end

function this:getVideoPath(tpl)
  return resolveAssetPath(tpl.videopath)
end

function this:getOrder(tpl)
  return tonumber(tpl.order) or 0
end

function this:getCd(tpl)
  return tonumber(tpl.CD) or 0
end

function this:getTimes(tpl)
  return tonumber(tpl.times) or 0
end

return this
