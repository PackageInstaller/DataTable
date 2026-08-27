local UIResultSkada = class("UIResultSkada", UIBaseWindow)
local base = UIBaseWindow
local SkadaEnum = require("Game.BattleResult.SkadaSystem.SkadaEnum")
local UINSkadaType = require("Game.BattleResult.SkadaSystem.UINSkadaType")
local UISkadaTeamPage = require("Game.BattleResult.SkadaSystem.UISkadaTeamPage")
local UISkadaInfoPage = require("Game.BattleResult.SkadaSystem.UISkadaInfoPage")

function UIResultSkada:OnInit()
  UIUtil.SetTopStatus(self, self.BackAction, nil, nil, nil, true)
  UIUtil.AddButtonListener(self.ui.btn_background, self, self.OnBtnCloseClicked)
  self.ui.tog_DataType:SetActive(false)
  self.resloader = CS.ResLoader.Create()
  self.panelSkadaTeamPage = UISkadaTeamPage.New()
  self.panelSkadaTeamPage:Init(self.ui.skadaTeamPage)
  self.panelSkadaInfoPage = UISkadaInfoPage.New()
  self.panelSkadaInfoPage:Init(self.ui.skadaInfoPage)
  self:InitSkadaTypeGroup()
end

function UIResultSkada:InitSkadaTypeGroup()
  self.__skadaTypeGroup = {}
  self.__OnSkadaTypeChanged = BindCallback(self, self.OnSkadaTypeChanged)
  for id = 1, SkadaEnum.MaxSkadaTypeNum do
    local go = self.ui.tog_DataType:Instantiate()
    go:SetActive(true)
    local skadaTypeItem = UINSkadaType.New()
    skadaTypeItem:Init(go)
    skadaTypeItem:InitSkadaType(id, self.__OnSkadaTypeChanged)
    table.insert(self.__skadaTypeGroup, skadaTypeItem)
  end
end

function UIResultSkada:OnSkadaTypeChanged(value, item)
  if value then
    self.skadaType = item.typeId
    if self.panelSkadaTeamPage ~= nil then
      self.panelSkadaTeamPage:OnSkadaTypeChanged(self.skadaType)
    end
    if self.panelSkadaInfoPage ~= nil then
      self.panelSkadaInfoPage:OnSkadaTypeChanged(self.skadaType)
    end
  end
end

function UIResultSkada:GetSkadaType()
  return self.skadaType
end

function UIResultSkada:InitBattleSkada(battleStatistics, playerRoleList, enemyRoleList)
  self.panelSkadaTeamPage:InitSkadaTeamPage(battleStatistics, playerRoleList, enemyRoleList, self.resloader, self.panelSkadaInfoPage)
  self.panelSkadaInfoPage:FirstInitSkadaInfoPage(self.resloader, battleStatistics)
  self.__skadaTypeGroup[1]:SetSkadaTypeOpen(true)
  self.ui.tex_stageText.gameObject:SetActive(false)
  if ExplorationManager:IsInExploration() then
    local msg
    local infoData = ExplorationManager:TryToGetCurrentLevelInfo()
    if infoData.moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration then
      self.ui.tex_stageText.gameObject:SetActive(true)
      msg = ConfigData:GetSectorInfoMsg(infoData.sector, infoData.num, infoData.difficulty)
    elseif infoData.moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Endless then
      self.ui.tex_stageText.gameObject:SetActive(true)
      msg = ConfigData:GetEndlessInfoMsg(infoData.cfg, infoData.index)
    end
    self.ui.tex_stageText.text = msg
  end
end

function UIResultSkada:SetSkadaCloseCallback(closeCallback)
  self.closeCallback = closeCallback
end

function UIResultSkada:BackAction()
  if self.closeCallback ~= nil then
    self.closeCallback()
  end
  self:Delete()
end

function UIResultSkada:OnBtnCloseClicked()
  UIUtil.OnClickBackByUiTab(self)
end

function UIResultSkada:OnDelete()
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  base.OnDelete(self)
end

return UIResultSkada
