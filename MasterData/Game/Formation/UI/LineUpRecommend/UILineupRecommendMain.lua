local UILineupRecommendMain = class("UILineupRecommendMain", UIBaseWindow)
local base = UIBaseWindow
local UINLineupTab = require("Game.Formation.UI.LineUpRecommend.UINLineupTab")
local UINLineupHeroGroup = require("Game.Formation.UI.LineUpRecommend.UINLineupHeroGroup")

function UILineupRecommendMain:OnInit()
  UIUtil.SetTopStatus(self, self.Delete)
  self.resloader = CS.ResLoader.Create()
  self.tabPool = UIItemPool.New(UINLineupTab, self.ui.obj_tabItem)
  self.ui.obj_tabItem:SetActive(false)
  self.groupPool = UIItemPool.New(UINLineupHeroGroup, self.ui.obj_groupItem)
  self.ui.obj_groupItem:SetActive(false)
  self.__OnTabSelectCallback = BindCallback(self, self.OnTabSelectCallback)
  UIUtil.AddButtonListener(self.ui.btn_QuickPick, self, self.OnClickQuicPickBtn)
end

function UILineupRecommendMain:InitLineupRecommend(ids)
  local tabList = {}
  for _, cfg in pairs(ConfigData.team_strategy_team) do
    if cfg.is_hide ~= 1 then
      table.insert(tabList, cfg)
    end
  end
  if #tabList <= 0 then
    return
  end
  self.recommendIds = {}
  if ids ~= nil then
    for i, v in ipairs(ids) do
      self.recommendIds[v] = true
    end
  end
  table.sort(tabList, function(acfg, bcfg)
    local aId = acfg.team_id
    local bId = bcfg.team_id
    if self.recommendIds[aId] ~= self.recommendIds[bId] then
      return self.recommendIds[aId] or false
    elseif acfg.order_id ~= bcfg.order_id then
      return acfg.order_id > bcfg.order_id
    end
    return aId < bId
  end)
  self.tabPool:HideAll()
  for _, cfg in ipairs(tabList) do
    local item = self.tabPool:GetOne()
    item:InitLineupTab(cfg, self.__OnTabSelectCallback, self.recommendIds[cfg.team_id])
  end
  if ids == nil or #ids == 0 then
    local tempId = tabList[1].team_id
    self:OnTabSelectCallback(tempId)
  else
    self:OnTabSelectCallback(ids[1])
  end
  local isShowQuickPick = true
  local fmtCtrl = ControllerManager:GetController(ControllerTypeId.Formation)
  if fmtCtrl ~= nil then
    local enterFmtData = fmtCtrl:GetCurEnterFmtData()
    local cfg = enterFmtData:GetStageCfg()
    if cfg ~= nil and cfg.is_hide_team_strategy == true then
      isShowQuickPick = false
    end
  end
  self.ui.btn_QuickPick.gameObject:SetActive(isShowQuickPick)
end

function UILineupRecommendMain:OnTabSelectCallback(id)
  if self.curId == id then
    return
  end
  for _, tab in ipairs(self.tabPool.listItem) do
    if tab.teamCfg.team_id == self.curId then
      tab:SetSelectState(false)
    end
    if tab.teamCfg.team_id == id then
      tab:SetSelectState(true)
    end
  end
  self.curId = id
  self.ui.obj_Tag:SetActive(self.recommendIds[id] == true)
  local teamCfg = ConfigData.team_strategy_team[id]
  if teamCfg ~= nil then
    self.ui.tex_Des.text = LanguageUtil.GetLocaleText(teamCfg.team_des)
  end
  self:UpdateTeamShow()
end

function UILineupRecommendMain:UpdateTeamShow()
  local heroCfgs = ConfigData.team_strategy_team_hero[self.curId]
  local heroList = {}
  for _, cfg in pairs(heroCfgs) do
    if cfg.is_hide ~= 1 then
      table.insert(heroList, cfg)
    end
  end
  table.sort(heroList, function(a, b)
    return a.order_id > b.order_id
  end)
  self.groupPool:HideAll()
  local heroCount = #heroList
  local recommendCount = 5
  if heroCount < 5 then
    recommendCount = heroCount
  end
  local item = self.groupPool:GetOne()
  item:InitLineupHeroGroup(heroList, self.resloader, 0, 1, recommendCount)
  if heroCount > recommendCount then
    local item = self.groupPool:GetOne()
    item:InitLineupHeroGroup(heroList, self.resloader, 1, recommendCount + 1, heroCount)
  end
  self.ui.rect_list.anchoredPosition = Vector2.zero
end

function UILineupRecommendMain:OnClickQuicPickBtn()
  local heroCfgs = ConfigData.team_strategy_team_hero[self.curId]
  local heroIds = {}
  for _, cfg in pairs(heroCfgs) do
    if cfg.is_hide ~= 1 then
      table.insert(heroIds, cfg.hero_id)
    end
  end
  table.sort(heroIds, function(a, b)
    local acfg = heroCfgs[a]
    local bcfg = heroCfgs[b]
    return acfg.order_id > bcfg.order_id
  end)
  UIManager:ShowWindowAsync(UIWindowTypeID.LineupMessageBox, function(window)
    if window ~= nil then
      window:InitLineupMessage(heroIds)
    end
  end)
end

function UILineupRecommendMain:OnDelete()
  self.tabPool:DeleteAll()
  self.groupPool:DeleteAll()
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  base.OnDelete(self)
end

return UILineupRecommendMain
