local this = class("pageHomeScienceMain", G_UIPageBase)
this:importPartialClass(require("ui/pages/home/homeScience/pageHomeScienceNewItem"))
local _homeTechnologyLevelTpl = L_GameTpl:getHomeTechnologyLevelTpl()
local _homeTechnologyTypeTpl = L_GameTpl:getHomeTechnologyTypeTpl()

function this.bind()
  return {
    moduleCommonTab = {
      moduleName = "pages/home/homeScience/moduleHomeScienceNewTabList"
    },
    listScienceGroup = {
      moduleName = "pages/home/homeScience/cellScienceTreeGroup"
    },
    moduleRight = {
      moduleName = "pages/home/homeScience/moduleHomeScienceRight"
    },
    txt_level = "",
    pro_value = 0,
    txt_point = "",
    txt_point_cnt = "",
    img_point_icon = "",
    img_info_bg = "",
    txt_name = "",
    txt_name_english = "",
    color_Slider = nil
  }
end

function this.methods()
  return {
    onClick_close = function(self)
      L_UI:close(self.pageName)
    end,
    onClick_point = function(self)
      L_ItemTplManager:showInfoTip(L_Const.resType.currency, self.currencyID)
    end,
    listScienceGroup = {
      selectItem = function(self, techTreeId)
        self:onSelectItem(techTreeId)
      end
    },
    onClick_scrollView = function(self)
      self:setTipShow(false)
    end
  }
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  if options then
    if options.selectId then
      self.selectId = options.selectId
    end
    if options.isTopLayer then
      self.bindComponents.rootTrans.gameObject.layer = 15
    end
  end
  L_TechnologyStore:listenCallFunc(L_TechnologyStore.event.refresh, self.onEventRefreshData, self)
  self:initPage()
end

function this:open(options)
  L_AudioUtil.playSound("Play_SFX_System_UI_TechLine_Switch")
end

function this:close(options)
  this.super.close(self)
  L_AudioUtil.playSound("Play_SFX_System_UI_TechLine_Close")
  L_TechnologyStore:unListenCallFunc(L_TechnologyStore.event.refresh, self.onEventRefreshData)
  L_TechnologyStore:call(L_TechnologyStore.event.refreshDot)
  self.hadPlayTabSound = nil
end

function this:initPage()
  self.listTechnologyTreeItem = {}
  self:InitTabs()
  self:setPendingNode(nil, nil, true)
end

function this:InitTabs()
  self.tabId2TechType = {}
  local datas = {}
  for _, v in pairs(_homeTechnologyTypeTpl.data) do
    local tabId = _homeTechnologyTypeTpl:getCommentTabId(v) or v.categroy + 600
    table.insert(datas, tabId)
    self.tabId2TechType[tabId] = _homeTechnologyTypeTpl:getCategroy(v)
  end
  table.sort(datas)
  local redKeys = {}
  self.modules.moduleCommonTab:setData(datas, function(tabId)
    if self.selectTabId == tabId then
      return
    end
    self.selectTechTreeId = nil
    self:setPendingNode(nil, nil, true)
    self:onSelectTabItem(tabId)
    self:setTipShow(false)
    L_TechnologyStore:call(L_TechnologyStore.event.refreshDot)
  end, self.selectId, redKeys)
  if self.selectTabId then
    self:onSelectTabItem(self.selectTabId)
  end
end

function this:onSelectTabItem(tabId)
  if self.selectTabId ~= tabId then
    if self.hadPlayTabSound then
      L_AudioUtil.playSound("Play_SFX_System_UI_Tech_Tab_Click")
    end
    self.hadPlayTabSound = true
  end
  self.selectTabId = tabId
  local type = self.tabId2TechType[tabId]
  if not self.listTechnologyTreeItem[type] then
    L_TechnologyStore:req_homeTechnologyTypeInfo(type)
  end
  self:updateScienceTree(type, true)
  self:refreshTabInfo(type)
end

function this:onSelectItem(techTreeId)
  if self.selectTechTreeId == techTreeId then
    self:setTipShow(false)
    return
  end
  self.selectTechTreeId = techTreeId
  for _, v in ipairs(self.bind.listScienceGroup:getItemCls()) do
    v:selectByParent(techTreeId)
  end
  L_AudioUtil.playSound("Play_SFX_System_UI_Tech_Icon_Choose")
  self:showPageTechnologyDetail(techTreeId)
end

function this:clearSelect()
  self.selectTechTreeId = nil
  for _, v in ipairs(self.bind.listScienceGroup:getItemCls()) do
    v:selectByParent(0)
  end
end

function this:showPageTechnologyDetail(techTreeId)
  L_AudioUtil.playSound("Play_SFX_System_UI_Tech_Detail_Show")
  self:setTipShow(true, techTreeId)
end

function this:onEventRefreshData()
  local type = self.tabId2TechType[self.selectTabId]
  self:updateScienceTree()
  self:refreshTabInfo(type)
end

function this:check(options, callback)
  local result = C_IntegrateMgr.SystemUnlockModule:CheckAndTip(L_SystemConst.enum.homeScience)
  callback(result)
end

local _tabBgColor = {
  [1] = {"#4B4343", "#655555"},
  [2] = {"#494441", "#645B54"},
  [3] = {"#3D3E40", "#556165"},
  [4] = {"#4C5146", "#5E6555"}
}

function this:refreshTabInfo(technologyType)
  local techTypeInfo = L_TechnologyStore:getTechTypeInfo(technologyType)
  local techTypeLevel = techTypeInfo.level
  local techTypeExp = techTypeInfo.exp
  local point = techTypeInfo.point
  local tplTechnologyType = _homeTechnologyTypeTpl:getTplById(technologyType)
  self.bind.txt_name = _homeTechnologyTypeTpl:getTechnologyName(tplTechnologyType)
  self.bind.txt_name_english = _homeTechnologyTypeTpl:getEnglish(tplTechnologyType)
  self.bind.img_info_bg = _homeTechnologyTypeTpl:getTypeBg(tplTechnologyType)
  local lvBgColor = _homeTechnologyTypeTpl:getLvBgColor(tplTechnologyType)
  self.bind.color_Slider = lvBgColor
  self.currencyID = _homeTechnologyTypeTpl:getTechnologyCurrencyId(tplTechnologyType)
  local currencyTpl = L_GameTpl:getCurrencyTpl()
  local tplItem = currencyTpl:getTplById(self.currencyID)
  self.bind.txt_point = currencyTpl:getName(tplItem)
  self.bind.img_point_icon = _homeTechnologyTypeTpl:getTechnologyCurrencyPageIcon(tplTechnologyType)
  self.bind.txt_point_cnt = tostring(point)
  self.bind.txt_level = string.format("Lv.%d", techTypeLevel)
  local tplTechnologyLevel = _homeTechnologyLevelTpl:getLevelInfo(technologyType, techTypeLevel)
  local levelNeedExp = _homeTechnologyLevelTpl:getTechnologyExp(tplTechnologyLevel)
  self.bind.pro_value = techTypeExp / levelNeedExp
end

function this:setTipShow(isShow, techTreeId)
  if isShow then
    self.modules.moduleRight:open(techTreeId)
  else
    self.modules.moduleRight:close()
  end
end

return this
