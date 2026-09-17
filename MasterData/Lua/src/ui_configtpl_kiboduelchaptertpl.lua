local this = class("kiboDuelChapterTpl")

function this:init(config)
  self.data = config
  self.modeInfo = {}
  for chapterId, v in pairs(config) do
    if not self.modeInfo[v.mode] then
      self.modeInfo[v.mode] = {}
    end
    self.modeInfo[v.mode][v.index] = v
  end
end

function this:getValue()
  return self.data
end

function this:getChapterId(tpl)
  return tpl.id
end

function this:getTplById(id)
  return self.data[id]
end

function this:getModeInfo(modeId)
  return self.modeInfo[modeId]
end

function this:getModeNum()
  return table.count(self.modeInfo)
end

function this:getChapterName(tpl)
  return L_Config:provider(tpl.type)
end

function this:getModeId(tpl)
  return tpl.mode
end

function this:getIndex(tpl)
  return tpl.index
end

function this:getCondition(tpl)
  return tpl.condition
end

function this:getKiBoDuelGroupId(tpl)
  return tpl.kiboDuelGroupId
end

return this
