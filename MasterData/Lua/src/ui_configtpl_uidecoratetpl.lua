local this = class("uiDecorateTpl")

function this:init(config)
  self.data = config
end

function this:onLanguageChange()
  self.map = {}
  for _, v in ipairs(self.data) do
    local chinese = self:getChinese(v)
    self.map[chinese] = v.decoEnglish
  end
end

function this:getTplById(id)
  return self.data[id]
end

function this:getChinese(tpl)
  return L_Config:provider(tpl.chinese)
end

function this:getDecoEnglish(str)
  if self.map == nil then
    self:onLanguageChange()
  end
  return self.map[str]
end

return this
