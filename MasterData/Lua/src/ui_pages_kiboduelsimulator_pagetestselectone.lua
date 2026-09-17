local this = class("pageTestSelectOne", G_UIPageBase)

function this:preOpen(options)
  this.super.preOpen(self, options)
  self.searchKey = ""
  if options and options.title then
    self.bind.txt_title = options.title
  end
  if options and options.list then
    self.list = options.list
  end
  if options and options.selectCallback then
    self.selectCallback = options.selectCallback
  end
  if options and options.closeCb then
    self.closeCallback = options.closeCb
  end
  self.renameFlag = false
  if options and options.renameFlag then
    self.renameFlag = options.renameFlag
  end
end

function this.bind()
  return {
    txt_title = "",
    txt_inputSearch = "",
    scrollList = {
      moduleName = "pages/kiboDuelSimulator/cellItem/kiboDuelSimulatorClickItem"
    }
  }
end

function this.methods()
  return {
    onClick_close = function(self)
      L_UI:close(self.pageName)
    end,
    scrollList = {
      onClick = function(self, bind)
        local cb = self.selectCallback
        L_UI:close(self.pageName)
        if cb then
          cb(bind.id)
        end
      end,
      onRename = function(self, bind, text)
        self.list[bind.id] = {
          id = bind.id,
          name = text
        }
      end
    },
    onChanged_search = function(self, text)
      self.searchKey = text
      self:refreshScrollList()
    end
  }
end

function this:ctor()
  this.super.ctor(self)
end

function this:open(options)
  this.super.open(self, options)
  self:refreshScrollList()
end

function this:refreshScrollList()
  self.bind.scrollList:clear()
  for _, v in pairs(self.list) do
    if string.isEmpty(self.searchKey) or string.match(v.name, self.searchKey) then
      self.bind.scrollList:insert({
        id = v.id,
        input_name = v.name,
        txt_name = v.name,
        input_visible = self.renameFlag,
        txt_visible = not self.renameFlag
      })
    end
  end
end

function this:close(options)
  if self.closeCallback then
    self.closeCallback(self.list)
  end
  this.super.close(self, options)
end

return this
