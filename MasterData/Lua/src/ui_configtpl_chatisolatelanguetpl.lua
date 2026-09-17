local this = class("chatIsolateLangueTpl")

function this:init(config)
  self.data = config
  self.langToId = {}
  for k, v in pairs(self.data) do
    local lang = self:getIsolateLangue(v)
    self.langToId[lang] = k
  end
end

function this:getTplById(id)
  return self.data[id]
end

function this:getIsolateLangue(tpl)
  return L_Config:provider(tpl.isolateLangue)
end

function this:getLangToId(lang)
  return self.langToId[lang] or 1
end

return this
