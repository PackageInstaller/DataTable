local this = class("cellWorldAreaItem", G_UIModuleBase)

function this.bind()
  return {
    go_active = false,
    go_normal = false,
    go_lock = false,
    goVxActive = true,
    goNew = false,
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

return this
