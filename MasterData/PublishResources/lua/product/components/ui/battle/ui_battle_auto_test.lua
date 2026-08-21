_class("UIBattleAutoTest", UIController)
UIBattleAutoTest = UIBattleAutoTest

function UIBattleAutoTest:OnShow()
  self._infoPanelGo = self:GetGameObject("InfoPanel")
  self._infoContent = self:GetGameObject("Content")
  self._infoLabel = self:GetGameObject("InfoLabel")
  self._infoLabels = {
    self._infoLabel
  }
  self._logs = GameGlobal.GetModule(AutoTestModule):GetResultLogs()
  self._logIndex = 1
  self:_ShowLog()
end

function UIBattleAutoTest:PrevLogOnClick()
  if self._logIndex > 1 then
    self._logIndex = self._logIndex - 1
  end
  self:_ShowLog()
end

function UIBattleAutoTest:NextLogOnClick()
  if self._logIndex < #self._logs then
    self._logIndex = self._logIndex + 1
  end
  self:_ShowLog()
end

function UIBattleAutoTest:_ShowLog()
  local log = self._logs[self._logIndex] or ""
  self._infoLabel:GetComponent("UILocalizationText"):SetText(log)
end

function UIBattleAutoTest:CloseOnClick()
  self:CloseDialog()
end

function UIBattleAutoTest:OutPutOnClick()
  local dir = EngineGameHelper.StoragePath .. "AutoTestLog/"
  App.MakeDir(dir)
  local _filePath = dir .. "AutoTestLog" .. os.date("%y%m%d%H%M%S") .. ".log"
  local file = io.open(_filePath, "w")
  for i, log in ipairs(self._logs) do
    file:write(log)
    file:write("\n")
  end
  io.close(file)
  SmokingTestHub.OpenLogFile(_filePath)
end
