local this = class("cellExploreDetail", G_UIModuleBase)

function this.bind()
  return {
    toggle_finish = false,
    txt_detailOn = "",
    txt_numOn = "",
    txt_detailOff = "",
    txt_numOff = ""
  }
end

function this.methods()
  return {}
end

return this
