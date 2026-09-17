local cls = {}

function cls:state()
  return {}
end

function cls:init()
  cls.super.init(self)
  self.data = {}
end

return cls
