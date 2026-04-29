_class("UIWorldBossTeam", UICustomWidget)
UIWorldBossTeam = UIWorldBossTeam

function UIWorldBossTeam:Constructor()
  self._atlas = self:GetAsset("UIWorldBoss.spriteatlas", LoadType.SpriteAtlas)
end

function UIWorldBossTeam:OnShow(uiParams)
  self:_GetComponents()
end

function UIWorldBossTeam:_GetComponents()
  self._selectObj = self:GetGameObject("selectObj")
  self._indexText = self:GetUIComponent("UILocalizationText", "Index")
  self._lock = self:GetGameObject("Lock")
end

function UIWorldBossTeam:SetData(index, dan, callBack)
  self._index = index
  self._dan = dan
  self._callBack = callBack
  self._indexText:SetText(StringTable.Get("str_world_boss_team_number", self._index))
end

function UIWorldBossTeam:Refresh(curDan)
  self._curDanLevel = UIWorldBossHelper.GetCurDanLevel(curDan)
  self._lock:SetActive(self._curDanLevel < self._dan)
end

function UIWorldBossTeam:BtnOnClick(go)
  if self._callBack then
    self._callBack(self._index, self._dan)
  end
end

function UIWorldBossTeam:SetSelectMark(isSelect)
  self._selectObj:SetActive(isSelect)
end
