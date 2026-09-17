local this = class("petLevelDecayTpl")

function this:init(config)
  self.data = config
  self.lvDifMap = {}
  for _, tpl in pairs(config) do
    self.lvDifMap[tpl.lvDif] = tpl
  end
end

function this:getAllTpl()
  return self.data
end

function this:getTplById(id)
  return self.data[id]
end

function this:getTplByLvDif(lvDif)
  return self.lvDifMap[lvDif]
end

function this:getLvDif(tpl)
  return tpl.lvDif
end

function this:getNormalSkillFail(tpl)
  return tpl.normalSkillFail
end

function this:getNormalAttriDown(tpl)
  return tpl.normalAttriDown
end

function this:getEliteSkillFail(tpl)
  return tpl.eliteSkillFail
end

function this:getEliteAttriDown(tpl)
  return tpl.eliteAttriDown
end

function this:getBossSkillFail(tpl)
  return tpl.bossSkillFail
end

function this:getBossAttriDown(tpl)
  return tpl.bossAttriDown
end

function this:getNormalCatchDeacy(tpl)
  return tpl.normalCatchDeacy
end

function this:getElitelCatchDeacy(tpl)
  return tpl.elitelCatchDeacy
end

function this:getBossCatchDeacy(tpl)
  return tpl.bossCatchDeacy
end

return this
