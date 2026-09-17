local this = {}

function this:init()
  this.super.init(self)
  self.data = {
    forceDic = {}
  }
end

function this:getDataById(forceId)
  for k, v in pairs(self.data.forceDic) do
    if v.forceId == forceId then
      return v
    end
  end
  return nil
end

return this
