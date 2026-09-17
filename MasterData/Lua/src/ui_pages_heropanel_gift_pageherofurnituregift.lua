local this = class("pageHeroFurnitureGift", G_UIPageBase)

function this.bind()
  return {}
end

function this.methods()
  return {}
end

function this:open()
  L_TimerManager:newOrResetTimer(self, "furniture", function()
    L_UI:close(self.pageName)
  end, 4.55)
end

function this:close()
  print("=====================close")
end

function this:escHandle()
  return
end

return this
