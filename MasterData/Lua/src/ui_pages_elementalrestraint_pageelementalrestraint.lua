local page = class("pageElementalRestraint", G_UIPageBase)
local tabGroupModule = {
  [0] = "moduleElementalRestraint",
  [1] = "moduleProfession"
}

function page.bind()
  return {
    tabList = {
      moduleName = "pages/elementalRestraint/cellPropertyTab"
    },
    selectTabGroupId = nil,
    moduleElementalRestraint = {
      moduleName = "pages/elementalRestraint/moduleElementalRestraint"
    },
    moduleProfession = {
      moduleName = "pages/elementalRestraint/moduleProfession"
    }
  }
end

function page.methods()
  return {
    onClick_closeBtn = function(self)
      L_UI:close(self.pageName)
    end,
    onClick_bg = function(self)
      L_UI:close(self.pageName)
    end
  }
end

function page:preOpen(options)
  if options then
    self.data = options
    self.heroTplId = options.heroTplId
    self.elements = options.elements
    self.initTab = options.initTab
  end
  self:initPage()
end

function page:initPage()
  if not self.heroTplId then
    self.modules.moduleElementalRestraint:initUI(self.elements)
    self.bind.selectTabGroupId = 0
    return
  end
  local onClickCellTab = handler(self, self.changeTab)
  local tabListData = {
    {
      txt_name = L_WordsTpl:getValue("ui_systemMessage_14"),
      txt_decoration = "SUHIXNG KEZHIBIJI",
      tabGroupId = 1,
      onClickTab = onClickCellTab
    },
    {
      txt_name = L_WordsTpl:getValue("ui_systemMessage_15"),
      txt_decoration = "SHUXING",
      tabGroupId = 0,
      onClickTab = onClickCellTab
    }
  }
  self.bind.tabList:clear()
  self.bind.tabList:insert_array(tabListData)
  self:changeTab(self.initTab or 0)
end

function page:changeTab(tabId)
  if self.bind.selectTabGroupId == tabId or not self.heroTplId then
    return
  end
  self.bind.selectTabGroupId = tabId
  for i = 1, #self.bind.tabList do
    local cellPropertyTab = self.bind.tabList:getItemCls(i)
    if cellPropertyTab.bind.tabGroupId == tabId then
      self.modules[tabGroupModule[tabId]]:initModule(self.heroTplId)
      if self.isModuleInit ~= nil then
        self.modules[tabGroupModule[tabId]]:playAnim()
      end
      cellPropertyTab.bind.toggle_isChoose = true
    else
      cellPropertyTab.bind.toggle_isChoose = false
    end
  end
  self.isModuleInit = true
end

return page
