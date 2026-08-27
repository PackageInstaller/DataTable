local base = UIBaseNode
local UINFmtSaveChange = class("UINFmtSaveChange", base)
local UINFmtSaveChangePanel = require("Game.Exploration.UI.FormationSave.Change.UINFmtSaveChangePanel")
local FmtSaveEnum = require("Game.Exploration.UI.FormationSave.Enum.FmtSaveEnum")

function UINFmtSaveChange:ctor(fmtSaveRoot)
  self._fmtSaveRoot = fmtSaveRoot
end

function UINFmtSaveChange:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Back, self, self._OnClickBack)
  UIUtil.AddButtonListener(self.ui.btn_Finish, self, self._OnClickExit)
  UIUtil.AddButtonListener(self.ui.btn_Save, self, self._OnClickChange)
  self._panelPool = UIItemPool.New(UINFmtSaveChangePanel, self.ui.panel, false)
  self._PanelBefore = self._panelPool:GetOne()
  self._PanelBefore.transform:SetParent(self.ui.before)
  self._PanelBefore.transform.anchoredPosition = Vector2.zero
  self._PanelAfter = self._panelPool:GetOne()
  self._PanelAfter.transform:SetParent(self.ui.after)
  self._PanelAfter.transform.anchoredPosition = Vector2.zero
end

function UINFmtSaveChange:InitFmtSaveChange(fmtSaveData, oldFmtSvData, resloader)
  self._fmtSaveData = fmtSaveData
  self._PanelAfter:InitFmtSaveChipPanel(FmtSaveEnum.ChangePanelType.Current, fmtSaveData, resloader, self._fmtSaveRoot)
  self._oldFmtSvData = oldFmtSvData
  local idx = oldFmtSvData:IsDefualtFmtSaveData() and FmtSaveEnum.ChangePanelType.History or FmtSaveEnum.ChangePanelType.Default
  self._PanelBefore:InitFmtSaveChipPanel(idx, oldFmtSvData, resloader, self._fmtSaveRoot)
end

function UINFmtSaveChange:_PlayShowTween()
  self.ui.main_cg:DOKill(true)
  self.ui.main_cg:DOFade(0, 0.4):From():SetLink(self.gameObjct)
  self.ui.main_cg.transform:DOKill(true)
  self.ui.main_cg.transform:DOLocalMoveY(-200, 0.4):From():SetLink(self.gameObjct)
  self.ui.bottom_cg:DOKill(true)
  self.ui.bottom_cg:DOFade(0, 0.4):From():SetDelay(0.1):SetLink(self.gameObjct)
  self.ui.bottom_cg.transform:DOKill(true)
  self.ui.bottom_cg.transform:DOLocalMoveY(-200, 0.4):From():SetDelay(0.1):SetLink(self.gameObjct)
end

function UINFmtSaveChange:OnShow()
  base.OnShow(self)
  self:_PlayShowTween()
end

function UINFmtSaveChange:_OnClickBack()
  self._fmtSaveRoot:BackFmtSaveChip()
end

function UINFmtSaveChange:_OnClickExit()
  local function exitFunc()
    self:_ReqRefresh(false)
  end
  
  if self._oldFmtSvData:GetFmtSvScoreCompare(true) < self._fmtSaveData:GetFmtSvScore() then
    local windonw = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
    windonw:ShowTextBoxWithYesAndNo(ConfigData:GetTipContent(57003), exitFunc)
    return
  end
  exitFunc()
end

function UINFmtSaveChange:_OnClickChange()
  local function confirmFunc()
    self:_ReqRefresh(true)
  end
  
  if self._oldFmtSvData:GetFmtSvScoreCompare(false) > self._fmtSaveData:GetFmtSvScore() then
    local windonw = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
    windonw:ShowTextBoxWithYesAndNo(ConfigData:GetTipContent(57004), confirmFunc)
    return
  end
  confirmFunc()
end

function UINFmtSaveChange:_ReqRefresh(save)
  local sectorSatgeId = self._fmtSaveData:GetFmtSvStageId()
  local chipList = self._fmtSaveData:GetFmtSvSelectedChipList()
  local chipDic = {}
  for k, chipData in ipairs(chipList) do
    chipDic[chipData.dataId] = chipData:GetCount()
  end
  local score = self._fmtSaveData:GetFmtSvScore()
  local dropChipIdList = self._fmtSaveData:GetFmtSvDorpChipIdData()
  local net = NetworkManager:GetNetwork(NetworkTypeID.Exploration)
  net:CS_EXPLORATION_HERO_FormationFresh(sectorSatgeId, chipDic, score, save, dropChipIdList, function()
    self:_PlayExitTween(save)
  end)
end

function UINFmtSaveChange:_PlayExitTween(isSave)
  self.ui.arrow.transform:SetParent(self.ui.bottom_cg.transform)
  local seq = CS.DG.Tweening.DOTween.Sequence()
  seq:SetLink(self.gameObjct)
  seq:Append(self.ui.bottom_cg:DOFade(0, 0.4))
  
  local function tweenFunc(cgHide, cgMove)
    cgHide.transform:SetParent(self.ui.bottom_cg.transform)
    seq:Join(cgMove.transform:DOLocalMoveX(0, 0.4))
    seq:AppendInterval(0.2)
    seq:Append(cgMove.transform:DOLocalMoveY(-200, 0.4))
    seq:Join(cgMove:DOFade(0, 0.4))
  end
  
  if isSave then
    tweenFunc(self.ui.before_cg, self.ui.after_cg)
  else
    tweenFunc(self.ui.after_cg, self.ui.before_cg)
  end
  UIUtil.AddOneCover("UINFmtSaveChange")
  seq:AppendCallback(function()
    self._fmtSaveRoot:ExitFmtSave()
  end)
end

function UINFmtSaveChange:OnDelete()
  UIUtil.CloseOneCover("UINFmtSaveChange")
  self._panelPool:DeleteAll()
  base.OnDelete(self)
end

return UINFmtSaveChange
