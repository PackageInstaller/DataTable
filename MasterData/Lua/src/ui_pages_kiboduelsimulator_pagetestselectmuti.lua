local this = class("pageTestSelectMuti", G_UIPageBase)

function this:preOpen(options)
  this.super.preOpen(self, options)
  self.searchKey = ""
  if options and options.title then
    self.bind.txt_title = options.title
  end
  if options and options.list then
    self.list = options.list
  end
  if options and options.selectList then
    self.selectList = options.selectList
    self.selectNum = 0
    for i, v in pairs(self.selectList) do
      self.selectNum = self.selectNum + 1
    end
  end
  if options and options.maxNum then
    self.maxNum = options.maxNum
  end
  if options and options.selectCallback then
    self.selectCallback = options.selectCallback
  end
end

function this.bind()
  return {
    txt_title = "",
    txt_maxNum = L_WordsTpl:getValue("residual_code_pagetestselectmuti_01"),
    txt_inputSearch = "",
    scrollList = {
      moduleName = "pages/kiboDuelSimulator/cellItem/kiboDuelSimulatorClickItem"
    },
    scrollSelectList = {
      moduleName = "pages/kiboDuelSimulator/cellItem/kiboDuelSimulatorClickItem"
    }
  }
end

function this.methods()
  return {
    onClick_close = function(self)
      L_UI:close(self.pageName)
      local list = {}
      for _, v in pairs(self.selectList) do
        table.insert(list, v.id)
      end
      self.selectCallback(list)
    end,
    scrollList = {
      onClick = function(self, bind)
        if self.selectList[bind.id] or self.selectNum == self.maxNum then
          return
        end
        self.selectNum = self.selectNum + 1
        self.selectList[bind.id] = {
          id = bind.id,
          name = bind.txt_name
        }
        self:refreshScrollSelectList()
      end
    },
    scrollSelectList = {
      onClick = function(self, bind)
        self.selectNum = self.selectNum - 1
        self.selectList[bind.id] = nil
        self:refreshScrollSelectList()
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
  self.bind.txt_maxNum = self.maxNum == 0 and L_WordsTpl:getValue("residual_code_pagetestselectmuti_01") or tostring(self.maxNum)
  self:refreshScrollList()
  self:refreshScrollSelectList()
end

function this:refreshScrollList()
  self.bind.scrollList:clear()
  for _, v in pairs(self.list) do
    if string.isEmpty(self.searchKey) or string.match(v.name, self.searchKey) then
      self.bind.scrollList:insert({
        id = v.id,
        txt_name = v.name
      })
    end
  end
end

function this:refreshScrollSelectList()
  self.bind.scrollSelectList:clear()
  for _, v in pairs(self.selectList) do
    self.bind.scrollSelectList:insert({
      id = v.id,
      txt_name = v.name
    })
  end
end

function this:close(options)
  this.super.close(self, options)
end

return this
