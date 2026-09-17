local this = class("pageCookGame", G_UIPageBase)
local foodCookTpl = L_GameTpl:getFoodCookTpl()

function this.bind()
  return {}
end

function this.methods()
  return {
    onClick_tempStart = function(self)
    end,
    onClick_perfect = function(self)
    end,
    onClick_normal = function(self)
    end,
    onClick_fail = function(self)
    end
  }
end

function this:created(obj, config)
  this.super.created(self, obj, config)
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self.foodId = options.foodId
end

function this:close(options)
  this.super.close(self, options)
end

return this
