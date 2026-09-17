local this = class("petGradeTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getGrade(tpl)
  return tpl.grade
end

function this:getIconSquare(tpl)
  return tpl.iconSquare
end

function this:getAllData()
  return self.data
end

function this:getIcon(tpl)
  return tpl.icon
end

function this:getPetPixelBase(tpl)
  return tpl.petPixelBase
end

function this:getPetGradeFrame(tpl)
  return tpl.petGradeFrame
end

function this:getGradeScore(tpl)
  return tpl.gradeScore
end

function this:getGradeBackground(tpl)
  return tpl.gradeBackground
end

function this:getGradeIcon(tpl)
  return tpl.gradeIcon
end

function this:getLevel(tpl)
  return tpl.level
end

return this
