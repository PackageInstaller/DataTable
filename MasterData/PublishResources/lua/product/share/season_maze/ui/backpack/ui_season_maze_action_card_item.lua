_class("UISeasonMazeActionCardItem", UICustomWidget)
UISeasonMazeActionCardItem = UISeasonMazeActionCardItem

function UISeasonMazeActionCardItem:OnShow(uiParams)
  self:InitWidget()
end

function UISeasonMazeActionCardItem:InitWidget()
  self.icon = self:GetUIComponent("RawImageLoader", "icon")
  self.name = self:GetUIComponent("UILocalizationText", "name")
  self.msg1 = self:GetUIComponent("UILocalizationText", "msg1")
  self.new = self:GetGameObject("new")
  self.colorBg = self:GetUIComponent("Image", "colorBg")
  self.colorTex = self:GetUIComponent("UILocalizationText", "colorTex")
  self.profGo = self:GetGameObject("profGo")
  self.profImg = self:GetUIComponent("Image", "profImg")
  self.viewport = self:GetUIComponent("Image", "Viewport")
  self.time = self:GetUIComponent("Image", "Time")
  self.timeTxt = self:GetUIComponent("UILocalizationText", "TimeTxt")
  self.useEnd = self:GetUIComponent("Image", "UseEnd")
  self.effect1Text = self:GetUIComponent("UILocalizationText", "Effect1Text")
  self.effect2Text = self:GetUIComponent("UILocalizationText", "Effect2Text")
end

function UISeasonMazeActionCardItem:SetData(index, cfgid, clickCb)
  self.index = index
  self.cfgid = cfgid
  self.clickCb = clickCb
  self._cfg = Cfg.cfg_component_season_maze_hand[cfgid]
  if not self._cfg then
    Log.fatal("SMazeCard cfg_component_season_maze_hand nil.", cfgid)
  end
  self._actPoint = 0
  self._resValue = 0
  local value1 = self._cfg.Steps[1]
  local value2 = self._cfg.Steps[2]
  if value1 == value2 then
    self.effect1Text:SetText("" .. value1)
  else
    self.effect1Text:SetText("" .. value1 .. "~" .. value2)
  end
  if self._cfg.EffectIDs == nil or #self._cfg.EffectIDs == 0 then
    self.effect2Text.gameObject:SetActive(false)
  else
    self.effect2Text.gameObject:SetActive(true)
    local effId = self._cfg.EffectIDs[1]
    local effCfg = Cfg.cfg_component_season_maze_effect[effId]
    local value3 = effCfg.EffectList[3]
    local value4 = effCfg.EffectList[4]
    if value3 ~= nil and value4 ~= nil then
      if value3 == value4 then
        self.effect2Text:SetText("" .. value3)
      else
        self.effect2Text:SetText("" .. value3 .. "~" .. value4)
      end
    end
  end
  if self._cfg.Lv == SMazeCardQualityType.Blue then
    self.colorBg.color = Color(0.6549019607843137, 1.0, 0.9725490196078431)
  elseif self._cfg.Lv == SMazeCardQualityType.Purple then
    self.colorBg.color = Color(1.0, 0.6549019607843137, 1.0)
  elseif self._cfg.Lv == SMazeCardQualityType.Orange then
    self.colorBg.color = Color(0.9725490196078431, 0.9137254901960784, 0.6549019607843137)
  end
end

function UISeasonMazeActionCardItem:BgOnClick(go)
  if self.clickCb then
    self.clickCb(self._cfg)
  end
end
