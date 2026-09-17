local this = class("moudleOptionMask", G_UIModuleBase)

function this.bind()
  return {}
end

function this.methods()
  return {}
end

function this:open()
end

function this:close()
end

function this:showOrHide(isShow)
  self.gameObject:ActiveTrans(isShow)
end

function this:enter()
  self:showOrHide(true)
end

function this:exit()
  self:showOrHide(false)
end

function this:isEnable()
  return self.gameObject.activeSelf
end

return this
