local UIChristmas22ModeSelect = class("UIChristmas22ModeSelect", UIBaseWindow)
local base = UIBaseWindow
local UINHalloweenSelectArchive = require("Game.ActivityHallowmas.UI.Select.UINHalloweenSelectArchive")
local UINHalloweenSelectMode = require("Game.ActivityHallowmas.UI.Select.UINHalloweenSelectMode")
local UINChristmas22EnvNode = require("Game.ActivityChristmas.UI.ModeSelect.UINChristmas22EnvNode")
local cs_MessageCommon = CS.MessageCommon
local SubNodeType = {
  Archieve = 1,
  SelectEnv = 2,
  SelectDiff = 3
}

function UIChristmas22ModeSelect:OnInit()
  UIUtil.SetTopStatus(self, self.OnCloseChristmasSelect, nil, nil, nil, true)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.OnClickCloseModeSelect)
  UIUtil.AddButtonListener(self.ui.btn_Back, self, self.OnClickRollback)
  UIUtil.AddButtonListener(self.ui.btn_NewGame, self, self.OnClickConfirm)
  self.__OnSelectArchiveCallback = BindCallback(self, self.__OnSelectArchive)
  self.__OnSelectEnvCallback = BindCallback(self, self.__OnSelectEnv)
  self.__OnOpenEnvTaskCallback = BindCallback(self, self.__OnOpenEnvTask)
end

function UIChristmas22ModeSelect:InitChristmas22ModeSelect(hallowmasData)
  self._data = hallowmasData
  self._envId = nil
  self._callback = callback
  local saveData = WarChessSeasonManager:GetWCSSavingData()
  if saveData == nil or table.count(saveData) == 0 then
    self:__OpenEnv()
  else
    self:__OpenArchive()
  end
end

function UIChristmas22ModeSelect:__OpenArchive()
  self._subType = SubNodeType.Archieve
  if self._archiveNode == nil then
    self.ui.checkPointNode:SetActive(true)
    self._archiveNode = UINHalloweenSelectArchive.New()
    self._archiveNode:Init(self.ui.checkPointNode)
    self._archiveNode:InitHalloweenSelectArchive(self._data, self.__OnSelectArchiveCallback)
    self._archiveNode:SetFileNameByEnvName()
  else
    self._archiveNode:Show()
  end
  if self._envNode ~= nil then
    self._envNode:Hide()
  else
    self.ui.environmentSelectNode:SetActive(false)
  end
  if self._diffNode ~= nil then
    self._diffNode:Hide()
  else
    self.ui.modeSelectNode:SetActive(false)
  end
  self.ui.btn_Back.gameObject:SetActive(false)
  self.ui.btn_NewGame.gameObject:SetActive(false)
  self.ui.textEN:SetIndex(0)
  self.ui.textCN:SetIndex(0)
end

function UIChristmas22ModeSelect:__OpenEnv()
  self._subType = SubNodeType.SelectEnv
  self._envId = nil
  if self._envNode == nil then
    self.ui.environmentSelectNode:SetActive(true)
    self._envNode = UINChristmas22EnvNode.New()
    self._envNode:Init(self.ui.environmentSelectNode)
    self._envNode:InitChristmas22EnvNode(self._data, self.__OnSelectEnvCallback, self.__OnOpenEnvTaskCallback)
  else
    self._envNode:Show()
    self._envNode:RefreshChristmas22EnvNode()
  end
  if self._archiveNode ~= nil then
    self._archiveNode:Hide()
  else
    self.ui.checkPointNode:SetActive(false)
  end
  if self._diffNode ~= nil then
    self._diffNode:Hide()
  else
    self.ui.modeSelectNode:SetActive(false)
  end
  local saveData = WarChessSeasonManager:GetWCSSavingData()
  self.ui.btn_Back.gameObject:SetActive(saveData ~= nil and table.count(saveData) > 0)
  self.ui.btn_NewGame.gameObject:SetActive(false)
  self.ui.textEN:SetIndex(1)
  self.ui.textCN:SetIndex(1)
end

function UIChristmas22ModeSelect:__OpenDiff()
  self._subType = SubNodeType.SelectDiff
  if self._diffNode == nil then
    self.ui.modeSelectNode:SetActive(true)
    self._diffNode = UINHalloweenSelectMode.New()
    self._diffNode:Init(self.ui.modeSelectNode)
  else
    self._diffNode:Show()
  end
  self._diffNode:InitHalloweenSelectMode(self._data, self._envId)
  if self._archiveNode ~= nil then
    self._archiveNode:Hide()
  else
    self.ui.checkPointNode:SetActive(false)
  end
  if self._envNode ~= nil then
    self._envNode:Hide()
  else
    self.ui.environmentSelectNode:SetActive(false)
  end
  self.ui.btn_Back.gameObject:SetActive(true)
  self.ui.btn_NewGame.gameObject:SetActive(true)
  self.ui.tex_Text:SetIndex(2)
  self.ui.textEN:SetIndex(2)
  self.ui.textCN:SetIndex(2)
end

function UIChristmas22ModeSelect:__OnSelectArchive()
  self:OnClickConfirm()
end

function UIChristmas22ModeSelect:__OnSelectEnv(envId)
  self._envId = envId
  self:__OpenDiff()
end

function UIChristmas22ModeSelect:__OnOpenEnvTask(envCfg)
  UIManager:ShowWindowAsync(UIWindowTypeID.ChristmasEnvTask, function(window)
    if window == nil then
      return
    end
    window:InitChristmasEnvTask(envCfg.env_task, BindCallback(self._data, self._data.ReqHallowmasCommitEnvTaskList), BindCallback(self._data, self._data.ReqHallowmasCommitTask))
    local nameCfg = ConfigData.activity_hallowmas_name
    window:SetChristmasEnvTaskTitle(LanguageUtil.GetLocaleText(nameCfg[5].name))
  end)
end

function UIChristmas22ModeSelect:OnClickRollback()
  if self._subType == SubNodeType.SelectDiff then
    self:__OpenEnv()
  elseif self._subType == SubNodeType.SelectEnv then
    self:__OpenArchive()
  end
end

function UIChristmas22ModeSelect:OnClickConfirm()
  if self._subType == SubNodeType.Archieve then
    local selectNewGame, selectArchive = self._archiveNode:GetArchiveSelect()
    if selectNewGame then
      self:__OpenEnv()
    else
      cs_MessageCommon.ShowMessageBox(ConfigData:GetTipContent(8717), function()
        local ctrl = ControllerManager:GetController(ControllerTypeId.ActivityHallowmas)
        ctrl:ArchivehallowmasSeason(selectArchive)
      end, nil)
    end
  elseif self._subType == SubNodeType.SelectDiff then
    local diffId = self._diffNode:GetSelectHallowDiffId()
    local ctrl = ControllerManager:GetController(ControllerTypeId.ActivityHallowmas)
    ctrl:EnterhallowmasSeason(self._data:GetActId(), diffId, self._envId)
  end
end

function UIChristmas22ModeSelect:OnClickCloseModeSelect()
  UIUtil.OnClickBackByUiTab(self)
end

function UIChristmas22ModeSelect:OnCloseChristmasSelect()
  self:Delete()
end

function UIChristmas22ModeSelect:OnDelete()
  if self._archiveNode ~= nil then
    self._archiveNode:OnDelete()
  end
  if self._diffNode ~= nil then
    self._diffNode:OnDelete()
  end
  if self._envNode ~= nil then
    self._envNode:OnDelete()
  end
  base.OnDelete(self)
end

return UIChristmas22ModeSelect
