local this = class("cellExploreSight", G_UIModuleBase)

function this.bind()
  return {
    img_sightOn = "",
    img_sightOff = "",
    toggle_finish = false
  }
end

function this.methods()
  return {
    onClick = function(self)
      L_UI:open("pageExplore", {
        type = L_MapConst.mapExploreDetailType.sight,
        data = self.bind
      })
    end
  }
end

return this
