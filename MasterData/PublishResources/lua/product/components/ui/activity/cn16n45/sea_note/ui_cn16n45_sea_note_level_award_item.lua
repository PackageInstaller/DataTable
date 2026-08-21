_class("UICN16N45SeaNoteLevelAwardItem", UICustomWidget)
UICN16N45SeaNoteLevelAwardItem = UICN16N45SeaNoteLevelAwardItem

function UICN16N45SeaNoteLevelAwardItem:OnShow(uiParams)
  self:InitWidget()
end

function UICN16N45SeaNoteLevelAwardItem:InitWidget()
  self.txt = self:GetUIComponent("UILocalizationText", "txt")
  self._trans = self:GetGameObject()
end

function UICN16N45SeaNoteLevelAwardItem:SetData(tyoe, id, pass, missionId, _aSheepCom)
  self._type = tyoe
  self._id = id
  self._missionId = missionId
  self._ASheepCom = _aSheepCom
  self:SetDetail()
  self:SetPass(pass)
end

function UICN16N45SeaNoteLevelAwardItem:SetDetail()
  if self._type == CN9SouthSeaRoadType.Normal then
    self.cfg = Cfg.cfg_component_asheep_mission
    local awards = self.cfg[self._id].Rewards
    self:_SetIcon(awards)
    self.txt:SetText(StringTable.Get("str_cn9_awards_tip1"))
  else
    local campaignId = self._ASheepCom:GetComponentCfgId()
    self.specialCfg = Cfg.cfg_component_asheep_mission_reward({ComponentID = campaignId})
    local ScoreLimit = self.specialCfg[self._id].ScoreLimit
    local awards = self.specialCfg[self._id].Rewards
    self:_SetIcon(awards)
    self.txt:SetText(StringTable.Get("str_cn9_awards_tip2") .. " " .. ScoreLimit)
  end
end

function UICN16N45SeaNoteLevelAwardItem:SetPass(pass)
  for i, v in ipairs(self.list) do
    v:SetPass(pass)
  end
end

function UICN16N45SeaNoteLevelAwardItem:_SetIcon(awards)
  local pool = self:GetUIComponent("UISelectObjectPath", "awards")
  self.list = pool:SpawnObjects("UICN16N45SeaNoteLevelAwardOneItem", #awards)
  for i, v in ipairs(self.list) do
    v:SetData(awards[i], function(id)
      self:ClickItem(id)
    end, self._missionId, i)
  end
end

function UICN16N45SeaNoteLevelAwardItem:ClickItem(id)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowItemTips, id, self._trans.transform.position)
end
