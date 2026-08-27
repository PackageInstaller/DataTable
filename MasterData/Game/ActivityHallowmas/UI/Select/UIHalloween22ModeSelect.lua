local UIHalloween22ModeSelect = class("UIHalloween22ModeSelect", UIBaseWindow)
local base = UIBaseWindow
local UINHalloweenSelectMode = require("Game.ActivityHallowmas.UI.Select.UINHalloweenSelectMode")
local UINHalloweenSelectArchive = require("Game.ActivityHallowmas.UI.Select.UINHalloweenSelectArchive")

function UIHalloween22ModeSelect:OnInit()
  UIUtil.SetTopStatus(self, self.OnCloseSelect, nil, nil, nil, true)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.OnClickBackSelect)
  UIUtil.AddButtonListener(self.ui.btn_NewGame, self, self.OnClickSelectComfirm)
  UIUtil.AddButtonListener(self.ui.token, self, self.OnClickToken)
  self.__RefreshPointCallback = BindCallback(self, self.__RefreshPoint)
  MsgCenter:AddListener(eMsgEventId.ActivityHallowmas, self.__RefreshPointCallback)
  self.__ArchiveSelectCallback = BindCallback(self, self.__ArchiveSelect)
  self.__RefreshSelectBtnStateCallback = BindCallback(self, self.__RefreshSelectBtnState)
  self.__ChangeUIStateCallback = BindCallback(self, self.__ChangeUIState)
end

function UIHalloween22ModeSelect:InitModeSelect(hallowmasData, callback)
  self._data = hallowmasData
  self._callback = callback
  local iconId = self._data:GetHallowmasScoreItemId()
  self.ui.tex_TokenName:SetIndex(0, ConfigData:GetItemName(iconId))
  self.ui.tex_TokenIcon.sprite = CRH:GetSpriteByItemId(iconId)
  self:__RefreshPoint()
  local saveData = WarChessSeasonManager:GetWCSSavingData()
  if saveData == nil or table.count(saveData) == 0 then
    self:__EnterModel()
  else
    self:__EnterArchive()
  end
end

function UIHalloween22ModeSelect:__RefreshPoint()
  local exp, expLimit = self._data:GetHallowmasScoreDailyLimit()
  self.ui.tex_TokenNum.text = tostring(exp) .. "/" .. tostring(expLimit)
end

function UIHalloween22ModeSelect:__RefreshSelectBtnState()
  if self._archiveNode ~= nil and self._archiveNode.active then
    self.ui.btn_NewGame.gameObject:SetActive(false)
  else
    self.ui.btn_NewGame.gameObject:SetActive(true)
    self.ui.tex_Text:SetIndex(1)
  end
end

function UIHalloween22ModeSelect:__ChangeUIState()
  if self._archiveNode == nil or not self._archiveNode.active then
    self:__EnterArchive()
  else
    self:__EnterModel()
  end
end

function UIHalloween22ModeSelect:__EnterArchive()
  self.ui.tex_title:SetIndex(0)
  if self._modeNode ~= nil then
    self._modeNode:Hide()
  else
    self.ui.modeSelectNode:SetActive(false)
  end
  if self._archiveNode == nil then
    self.ui.checkPointNode:SetActive(true)
    self._archiveNode = UINHalloweenSelectArchive.New()
    self._archiveNode:Init(self.ui.checkPointNode)
    self._archiveNode:InitHalloweenSelectArchive(self._data, self.__ArchiveSelectCallback)
  else
    self._archiveNode:Show()
  end
  self:__RefreshSelectBtnState()
end

function UIHalloween22ModeSelect:__ArchiveSelect()
  self:OnClickSelectComfirm()
end

function UIHalloween22ModeSelect:__EnterModel()
  self.ui.tex_title:SetIndex(1)
  if self._archiveNode ~= nil then
    self._archiveNode:Hide()
  else
    self.ui.checkPointNode:SetActive(false)
  end
  if self._modeNode == nil then
    self.ui.modeSelectNode:SetActive(true)
    self._modeNode = UINHalloweenSelectMode.New()
    self._modeNode:Init(self.ui.modeSelectNode)
    self._modeNode:InitHalloweenSelectMode(self._data, nil, self.__RefreshSelectBtnStateCallback, self.__ChangeUIStateCallback)
  else
    self._modeNode:Show()
  end
  self:__RefreshSelectBtnState()
end

function UIHalloween22ModeSelect:OnClickSelectComfirm()
  if self._archiveNode ~= nil and self._archiveNode.active then
    local isSelectNew, archive = self._archiveNode:GetArchiveSelect()
    if isSelectNew then
      self:__ChangeUIState()
    elseif archive ~= nil then
      local ctrl = ControllerManager:GetController(ControllerTypeId.ActivityHallowmas)
      ctrl:ArchivehallowmasSeason(archive)
    end
  elseif self._modeNode ~= nil then
    local selectDiffId = self._modeNode:GetSelectHallowDiffId()
    if 0 < (selectDiffId or 0) then
      local ctrl = ControllerManager:GetController(ControllerTypeId.ActivityHallowmas)
      ctrl:EnterhallowmasSeason(self._data:GetActId(), selectDiffId)
    end
  end
end

function UIHalloween22ModeSelect:OnClickToken()
  UIManager:ShowWindowAsync(UIWindowTypeID.Carnival22InfoWindow, function(win)
    if win == nil then
      return
    end
    win:InitCarnivalInfoWindow(self._data:GetHallowmasMainCfg().score_limit_tip)
  end)
end

function UIHalloween22ModeSelect:OnClickBackSelect()
  UIUtil.OnClickBackByUiTab(self)
end

function UIHalloween22ModeSelect:OnCloseSelect()
  self:Delete()
  if self._callback ~= nil then
    self._callback()
  end
end

function UIHalloween22ModeSelect:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.ActivityHallowmas, self.__RefreshPointCallback)
  base.OnDelete(self)
end

return UIHalloween22ModeSelect
