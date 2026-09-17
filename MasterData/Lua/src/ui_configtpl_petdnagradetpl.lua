local this = class("petDnagradeTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getGrade2(tpl)
  return tpl.grade2
end

function this:getGrade4(tpl)
  return tpl.grade4
end

function this:getGrade3(tpl)
  return tpl.grade3
end

function this:getGrade1(tpl)
  return tpl.grade1
end

return this
