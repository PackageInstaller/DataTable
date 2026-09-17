local this = class("cellAccessoryRecommendItem", G_UIModuleBase)

function this.bind()
  return {
    txt_name = "",
    go_select = true,
    go_selectLight = false,
    accesoryList = {
      moduleName = "pages/accessory/cellAccessoryRecChildItem"
    }
  }
end

function this.methods()
  return {
    onclick_Filter = function(self)
      self:emit("onclick_Filter", self.bind)
    end,
    onclick_CancelFilter = function(self)
      self:emit("onclick_Filter", self.bind)
    end
  }
end

function this:open()
  this.super.open(self)
  self:refreshView()
end

function this:refreshView()
  if not self.isBind then
    return
  end
  self.bind.txt_name = string.format("<color=#dcd5c4>%s</color>", self.bind.name)
  self.bind.accesoryList:clear()
  self.bind.accesoryList:insert_array(self.bind.accessoryList)
  self:refreshSelUI(self.bind.sel)
end

function this:refreshSelUI(bSel)
  self.bind.go_selectLight = bSel
  self.bind.go_select = not bSel
end

return this
