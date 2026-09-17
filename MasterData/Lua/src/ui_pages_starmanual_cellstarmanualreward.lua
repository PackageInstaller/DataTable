local this = class("cellStarmanualReward", G_UIModuleBase)

function this.bind()
  return {
    img_icon = nil,
    txt_num = "",
    img_frame = nil,
    img_bg = nil
  }
end

function this.methods()
  return {
    onClick = function(self)
      L_ItemTplManager:showInfoTip(self.bind.type, self.bind.id)
    end
  }
end

return this
