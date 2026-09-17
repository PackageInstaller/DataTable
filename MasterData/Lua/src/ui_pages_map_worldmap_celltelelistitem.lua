local this = class("cellTeleListItem", G_UIModuleBase)

function this.bind()
  return {
    go_active = false,
    go_normal = false,
    go_lock = false,
    goVxActive = true,
    txt_name_active = nil,
    txt_name_normal = nil,
    txt_name_lock = nil
  }
end

function this.methods()
  return {
    onClick_selectItem = function(self)
      if not self.bind.go_lock then
        self:emit("onClick_selectItem", self.bind)
      end
    end
  }
end

function this:close(options)
  this.super.close(self, options)
  self.bind.goVxActive = false
end

function this:setSelect(b)
  self.bind.go_active = b
  self.bind.go_normal = not b
end

return this
