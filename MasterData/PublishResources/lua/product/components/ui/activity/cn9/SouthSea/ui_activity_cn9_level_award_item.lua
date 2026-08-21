local CN9SouthSeaRoadType = {Normal = 1, Special = 2}
_enum("CN9SouthSeaRoadType", CN9SouthSeaRoadType)
_class("UIACtivityCN9LevelAwardItem", UICustomWidget)
UIACtivityCN9LevelAwardItem = UIACtivityCN9LevelAwardItem

function UIACtivityCN9LevelAwardItem:OnShow(uiParams)
  self:InitWidget()
end

function UIACtivityCN9LevelAwardItem:InitWidget()
  self.txt = self:GetUIComponent("UILocalizationText", "txt")
  self._trans = self:GetGameObject()
end

function UIACtivityCN9LevelAwardItem:SetData(tyoe, id, pass)
  self._type = tyoe
  self._id = id
  self:SetDetail()
  self:SetPass(pass)
end

function UIACtivityCN9LevelAwardItem:SetDetail()
  if self._type == CN9SouthSeaRoadType.Normal then
    self.cfg = Cfg.cfg_component_asheep_mission
    local awards = self.cfg[self._id].Rewards
    self:_SetIcon(awards)
    self.txt:SetText(StringTable.Get("str_cn9_awards_tip1"))
  else
    self.specialCfg = Cfg.cfg_component_asheep_mission_reward
    local ScoreLimit = self.specialCfg[self._id].ScoreLimit
    local awards = self.specialCfg[self._id].Rewards
    self:_SetIcon(awards)
    self.txt:SetText(StringTable.Get("str_cn9_awards_tip2") .. " " .. ScoreLimit)
  end
end

function UIACtivityCN9LevelAwardItem:SetPass(pass)
  for i, v in ipairs(self.list) do
    v:SetPass(pass)
  end
end

function UIACtivityCN9LevelAwardItem:_SetIcon(awards)
  local pool = self:GetUIComponent("UISelectObjectPath", "awards")
  self.list = pool:SpawnObjects("UIACtivityCN9LevelAwardOneItem", #awards)
  for i, v in ipairs(self.list) do
    v:SetData(awards[i], function(id)
      self:ClickItem(id)
    end)
  end
end

function UIACtivityCN9LevelAwardItem:ClickItem(id)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowItemTips, id, self._trans.transform.position)
end
