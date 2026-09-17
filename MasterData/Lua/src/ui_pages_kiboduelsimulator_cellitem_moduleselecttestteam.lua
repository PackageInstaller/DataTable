local this = class("moduleSelectTestTeam", G_UIModuleBase)

function this:ctor(...)
  this.super.ctor(self, ...)
end

function this.bind()
  return {
    img_select = nil,
    txt_select = "",
    go_list = false,
    go_arrowOpen = false,
    go_arrowClose = true,
    scrollList_filter = {
      moduleName = "pages/kiboDuelSimulator/cellItem/kiboDuelSimulatorClickItem"
    }
  }
end

function this.methods()
  return {
    onClick_filer = function(self)
      self.bind.go_list = not self.bind.go_list
      self.bind.go_arrowClose = not self.bind.go_list
      self.bind.go_arrowOpen = self.bind.go_list
    end,
    scrollList_filter = {
      onClick = function(self, id)
        self.bind.id = id
        self:setActive()
        self:emit("onChoice", self.bind.index, self.bind.id)
      end
    }
  }
end

function this:initModule()
  self:refreshList()
  self:setActive()
end

function this:refresh()
  self:initModule()
end

function this:refreshList()
  self.bind.scrollList_filter:clear()
  self.bind.scrollList_filter:insert_array(self.bind.list)
  self.bind.go_list = false
  self.bind.go_arrowClose = not self.bind.go_list
  self.bind.go_arrowOpen = self.bind.go_list
end

function this:setActive()
  self.bind.go_list = false
  self.bind.go_arrowClose = not self.bind.go_list
  self.bind.go_arrowOpen = self.bind.go_list
  if not self.bind.id then
    self.bind.txt_select = ""
    return
  end
  for i = 1, #self.bind.scrollList_filter do
    if self.bind.id == self.bind.scrollList_filter:getValue(i, "id") then
      self.bind.txt_select = self.bind.scrollList_filter:getValue(i, "txt_name")
    end
  end
end

return this
