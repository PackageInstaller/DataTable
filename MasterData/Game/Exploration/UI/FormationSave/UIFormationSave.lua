local base = UIBaseWindow
local UIFormationSave = class("UIFormationSave", base)
local UINFmtSaveChipDetail = require("Game.Exploration.UI.FormationSave.ChipDetail.UINFmtSaveChipDetail")
local UINFmtSaveChip = require("Game.Exploration.UI.FormationSave.SaveChip.UINFmtSaveChip")
local UINFmtSaveChange = require("Game.Exploration.UI.FormationSave.Change.UINFmtSaveChange")
local EpFormationSaveData = require("Game.Exploration.UI.FormationSave.Data.EpFormationSaveData")

function UIFormationSave:OnInit()
  self.resloader = CS.ResLoader.Create()
  self._saveChipNode = UINFmtSaveChip.New(self)
  self._saveChipNode:Init(self.ui.SaveChipNode)
  self._changeNode = UINFmtSaveChange.New(self)
  self._changeNode:Init(self.ui.ChangeNode)
  self._changeNode:Hide()
  self._chipDetailNode = UINFmtSaveChipDetail.New()
  self._chipDetailNode:Init(self.ui.ChipDetail)
  self._chipDetailNode:Hide()
end

function UIFormationSave:InitFormationSave(fmtSaveData)
  self._fmtSaveData = fmtSaveData
  self._saveChipNode:InitFmtSaveChip(fmtSaveData, self.resloader)
  self._saveChipNode:Show()
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self._BackAction):PushTopStatusDataToBackStack(true)
  self:_ReqHistoryData()
end

function UIFormationSave:ShowFmtSaveChipDetail(chipData)
  local dynChipSuitMgr = self._fmtSaveData:GetFmtSvChipSuitMgr()
  self._chipDetailNode:InitFmtSaveChipDetail(chipData, dynChipSuitMgr, self.resloader)
end

function UIFormationSave:EnterFmtSaveChange()
  self._saveChipNode:Hide()
  self._changeNode:Show()
  self._changeNode:InitFmtSaveChange(self._fmtSaveData, self._oldFmtSvData, self.resloader)
end

function UIFormationSave:BackFmtSaveChip()
  self._saveChipNode:Show()
  self._changeNode:Hide()
end

function UIFormationSave:SetFormationSaveCloseFunc(closeFunc)
  self._closeFunc = closeFunc
end

function UIFormationSave:_ReqHistoryData()
  local net = NetworkManager:GetNetwork(NetworkTypeID.Exploration)
  local envCfg = self._fmtSaveData:GetFmtSvEnvCfg()
  net:CS_EXPLORATION_HERO_Formation_Detail(envCfg.env_id, function(objList)
    if objList == nil or objList.Count == 0 then
      error("objList error")
      return
    end
    local msg = objList[0]
    self._oldFmtSvData = EpFormationSaveData.CreateFmtSvDataByMsg(msg, envCfg)
  end)
end

function UIFormationSave:ExitFmtSave()
  UIUtil.OnClickBackByUiTab(self)
end

function UIFormationSave:_BackAction()
  if not self._changeNode.active then
    UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self._BackAction):PushTopStatusDataToBackStack(true)
  end
  self:Delete()
  if self._closeFunc then
    self._closeFunc()
  end
end

function UIFormationSave:OnDelete()
  self.resloader:Put2Pool()
  self.resloader = nil
  self._chipDetailNode:Delete()
  self._saveChipNode:Delete()
  self._changeNode:Delete()
  base.OnDelete(self)
end

return UIFormationSave
