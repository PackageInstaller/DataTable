_class("UIN5BattleFieldEnemyInfo", UIController)
UIN5BattleFieldEnemyInfo = UIN5BattleFieldEnemyInfo

function UIN5BattleFieldEnemyInfo:Constructor()
  self._enemyItems = nil
  self._enemyItemsCount = 0
end

function UIN5BattleFieldEnemyInfo:OnShow(uiParams)
  self._cfg_conquest_mission = uiParams[1]
  self._componentInfo = uiParams[2]
  self._cfg_conquest_level_wave = self:_FilterCfg(self._cfg_conquest_mission.LevelID, self._cfg_conquest_mission.WaveCount)
  self._enemyItemsCount = #self._cfg_conquest_level_wave
  self:_GetComponents()
  self:_OnValue()
end

function UIN5BattleFieldEnemyInfo:_FilterCfg(levelId, waveCount)
  local t = {}
  local cfg = Cfg.cfg_conquest_level_wave({LevelID = levelId})
  for key, value in pairs(cfg) do
    if waveCount >= value.WaveIndex then
      table.insert(t, value)
    end
  end
  return t
end

function UIN5BattleFieldEnemyInfo:_GetComponents()
  self._content = self:GetUIComponent("UISelectObjectPath", "Content")
end

function UIN5BattleFieldEnemyInfo:_OnValue()
  self:_CreateEnemyList()
end

function UIN5BattleFieldEnemyInfo:_CreateEnemyList()
  self._content:SpawnObjects("UIN5BattleFieldEnemyInfoItem", self._enemyItemsCount)
  self._enemyItems = self._content:GetAllSpawnList()
  for i = 1, self._enemyItemsCount do
    self._enemyItems[i]:SetData(i, self._enemyItemsCount, self._componentInfo.m_battlefield_info.m_mission_level_wave_map[self._cfg_conquest_mission.MissionID][i], self._cfg_conquest_level_wave[i])
  end
end

function UIN5BattleFieldEnemyInfo:CloseBtnOnClick(go)
  self:CloseDialog()
end

function UIN5BattleFieldEnemyInfo:CloseBgOnClick(go)
  self:CloseDialog()
end
