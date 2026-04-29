_class("UIN5BattleFieldEnemyMsg", UICustomWidget)
UIN5BattleFieldEnemyMsg = UIN5BattleFieldEnemyMsg

function UIN5BattleFieldEnemyMsg:OnShow(uiParams)
  self:_GetComponents()
end

function UIN5BattleFieldEnemyMsg:_GetComponents()
  self.content = self:GetUIComponent("UISelectObjectPath", "Content")
  self._restrainBtn = self:GetGameObject("restrainBtn")
end

function UIN5BattleFieldEnemyMsg:SetData(monsterIDs, showRestrainBtn)
  self._ids = monsterIDs
  self._restrainBtn:SetActive(showRestrainBtn)
  self.content:SpawnObjects("UIEnemyItem", #self._ids)
  local items = self.content:GetAllSpawnList()
  for idx, value in ipairs(self._ids) do
    local item = items[idx]
    item:SetData(self._ids[idx], idx, function(idx)
      self:ShowDialog("UIEnemyTip", self._ids, idx)
    end)
  end
end

function UIN5BattleFieldEnemyMsg:restrainBtnOnClick()
  self:ShowDialog("UIRestrainTips")
end
