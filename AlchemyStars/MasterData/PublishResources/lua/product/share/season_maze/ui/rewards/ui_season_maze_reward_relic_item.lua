_class("UIseasonMazeRewardRelicItem", UICustomWidget)
UIseasonMazeRewardRelicItem = UIseasonMazeRewardRelicItem

function UIseasonMazeRewardRelicItem:OnShow(uiParams)
  self:InitWidget()
end

function UIseasonMazeRewardRelicItem:InitWidget()
  self.relicPool = self:GetUIComponent("UISelectObjectPath", "RelicPool")
  self.select = self:GetUIComponent("Image", "Select")
  self.UIseasonMazeRewardRelicItem = self:GetGameObject("UIseasonMazeSelectRelicItem")
  self.DetailObj = self:GetGameObject("Detail")
  self.DetailObj:SetActive(false)
  self._anim = self:GetUIComponent("Animation", "anim")
end

function UIseasonMazeRewardRelicItem:SetData(relicCfg, selectFunc, index, detailFunc)
  self.relicItemCfg = relicCfg
  self.selectFunc = selectFunc
  self.detailFunc = detailFunc
  self.index = index
  self._relic = UIWidgetHelper.SpawnObject(self, "RelicPool", "UISeasonMazeRelicItem")
  local cfg = self.relicItemCfg
  self._relic:GetGameObject():SetActive(true)
  if cfg ~= nil then
    self._relic:SetData(index, cfg, function(tIndex)
      if self.selectFunc then
        self.selectFunc(tIndex)
        self:SelectItem()
      end
    end, false, true, false, true)
    self._relic:DisableAnimation()
  end
  self.DetailObj:SetActive(false)
  local itemcfg = Cfg.cfg_item_relic[cfg]
  if itemcfg.DetailPopTips ~= nil then
    self.DetailObj:SetActive(true)
  end
  if itemcfg.SuiteID == nil or itemcfg.SuiteID == 0 then
  else
    self.DetailObj:SetActive(true)
  end
  self.UIseasonMazeRewardRelicItem:SetActive(false)
  local time = (index - 1) * 50
  self._timerHandler = GameGlobal.Timer():AddEventTimes(time, TimerTriggerCount.Once, function()
    self.UIseasonMazeRewardRelicItem:SetActive(true)
    self._anim:Play("uieffanim_UIseasonMazeSelectRelicItem_in")
  end)
end

function UIseasonMazeRewardRelicItem:SelectItem()
  self.select.gameObject:SetActive(true)
end

function UIseasonMazeRewardRelicItem:UnSelectItem()
  self.select.gameObject:SetActive(false)
end

function UIseasonMazeRewardRelicItem:DetailOnClick(go)
  if self.detailFunc then
    self.detailFunc(self.index)
  end
end

function UIseasonMazeRewardRelicItem:SelectOnClick(go)
end
