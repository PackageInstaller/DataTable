local this = class("cellExploreBoss", G_UIModuleBase)

function this.bind()
  return {
    toggle_finish = false,
    img_bossOn = "",
    img_bossOff = ""
  }
end

function this.methods()
  return {
    onClick = function(self)
      L_UI:open("pageExplore", {
        type = L_MapConst.mapExploreDetailType.boss,
        data = self.bind
      })
    end
  }
end

return this
