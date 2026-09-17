local this = class("petCatchItemTpl")

function this:init(config)
  self.data = config
end

function this:getValue()
  return self.data
end

function this:getTplById(id)
  return self.data[id]
end

function this:getCardBackGround(tpl)
  return tpl.cardBackGround
end

function this:getCardType(tpl)
  return tpl.type
end

function this:getCardBgImg(tpl, index)
  if not index then
    return L_Config:getPathByHash(tpl.cardBgImg)[1]
  end
  return L_Config:getPathByHash(tpl.cardBgImg)[index]
end

return this
