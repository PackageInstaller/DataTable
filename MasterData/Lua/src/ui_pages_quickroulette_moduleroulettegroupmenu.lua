local this = class("moduleRouletteGroupMenu", G_UIModuleBase)
local rouletteTabTpl = L_GameTpl:getRouletteTabTpl()

function this:ctor(...)
  this.super.ctor(self, ...)
end

function this.bind()
  return {
    scrollList_type = {
      moduleName = "pages/quickRoulette/cellRouletteTabBtn"
    }
  }
end

function this.methods()
  return {
    scrollList_type = {
      onClick_tab = function(self, index)
        self:setSelectIndex(index)
        self:setTypeListActive()
      end
    }
  }
end

function this:open(options)
  this.super.open(self)
end

function this:close()
  this.super.close(self)
end

function this:setData(args)
  self.onTabIndexChangeCb = args.onTabIndexChangeCb
  self:setSelectIndex(args.index or 1, true)
  self:initTypeList()
  self:setTypeListActive()
end

function this:setSelectIndex(index, isInit)
  self.curTabIndex = index
  if self.onTabIndexChangeCb and not isInit then
    self.onTabIndexChangeCb(self.curTabIndex)
  end
end

function this:initTypeList()
  local tmp = {}
  local configList = rouletteTabTpl:getConfig()
  for index, data in ipairs(configList or table.empty) do
    local name = rouletteTabTpl:getName(data)
    local icon = rouletteTabTpl:getIcon(data)
    table.insert(tmp, {
      index = index,
      shopNameShow = name,
      shopNameOut = name,
      shopImageShow = icon,
      shopImageOut = icon
    })
  end
  self.bind.scrollList_type:clear()
  self.bind.scrollList_type:insert_array(tmp)
end

function this:setTypeListActive()
  for i = 1, #self.bind.scrollList_type do
    local index = self.bind.scrollList_type:getValue(i, "index")
    local active = index == self.curTabIndex
    self.bind.scrollList_type:change(i, {
      isActive = active,
      isNomarl = not active
    })
  end
end

return this
