local UINFmtChallengeTask = class("UINFmtChallengeTask", UIBaseNode)
local base = UIBaseNode
local UINCommonSwitchToggle = require("Game.CommonUI.CommonSwitchToggle.UINCommonSwitchToggle")

function UINFmtChallengeTask:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Info, self, self._OnClickInfo)
  self._switchTog = UINCommonSwitchToggle.New()
  self._switchTog:Init(self.ui.tog_Switch)
  self._switchTog:CommonSwitchTogAutoSetValue(false)
  self._changeValueFunc = BindCallback(self, self._OnClickTogSwitch)
  self._OnChallengeTaskChangeFunc = BindCallback(self, self._OnChallengeTaskChange)
  MsgCenter:AddListener(eMsgEventId.OnStageChanllengeTaskChange, self._OnChallengeTaskChangeFunc)
end

function UINFmtChallengeTask:InitFmtChallengeTask(fmtCtrl, enterFmtData, editorNodeUI)
  self.fmtCtrl = fmtCtrl
  self.editorNodeUI = editorNodeUI
  self.stgChallengeData = enterFmtData:GetFmtChallengeModeData()
  local isChallengeMode = self.stgChallengeData:IsStageChallengeOpen()
  self:_UpdChallengeModeUI(isChallengeMode)
  self._switchTog:InitCommonSwitchToggle(isChallengeMode, self._changeValueFunc)
end

function UINFmtChallengeTask:_UpdChallengeModeUI(isChallengeMode)
  self.ui.img_ChallengeBg:SetActive(isChallengeMode)
  self:_UpdRewardNumPrewview()
  self.editorNodeUI:RefreshEnterBattleTip()
  self.editorNodeUI:RefreshBattlePow()
end

function UINFmtChallengeTask:_OnClickInfo()
  UIManager:ShowWindowAsync(UIWindowTypeID.FmtChallengeInfo, function(win)
    if win == nil then
      return
    end
    win:InitFmtChallengeInfo(self.stgChallengeData, function()
      if self.stgChallengeData:IsStageChallengeOpen() then
        return
      end
      self:_SetChallengeMode(true, false)
    end)
  end)
end

function UINFmtChallengeTask:_OnClickTogSwitch(isChallengeMode)
  self:_SetChallengeMode(isChallengeMode, true)
end

function UINFmtChallengeTask:_SetChallengeMode(isChallengeMode, showChallengeInfo)
  self.fmtCtrl:SetFmtChallengeMode(isChallengeMode, showChallengeInfo, function()
    self:_UpdChallengeModeUI(isChallengeMode)
    self._switchTog:SetCommonSwitchToggleValue(isChallengeMode)
    self.editorNodeUI:RefreshBattleBtnState()
    UIManager:ShowWindowAsync(UIWindowTypeID.AniModeChange, function(win)
      if win == nil then
        return
      end
      if isChallengeMode then
        win:ShowAniModeChangeChallengeTask()
      else
        win:ShowAniModeChangeSectorLvDiff(1)
      end
    end)
  end)
end

function UINFmtChallengeTask:_OnChallengeTaskChange()
  self:_UpdRewardNumPrewview()
end

function UINFmtChallengeTask:_UpdRewardNumPrewview()
  local rewardNum = self.stgChallengeData:GetStgChallengeTaskRewardNum()
  if 0 < rewardNum then
    self.ui.reward:SetActive(true)
    self.ui.tex_RewardNum:SetIndex(0, tostring(rewardNum))
  else
    self.ui.reward:SetActive(false)
  end
end

function UINFmtChallengeTask:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.OnStageChanllengeTaskChange, self._OnChallengeTaskChangeFunc)
  UIManager:DeleteWindow(UIWindowTypeID.AniModeChange)
  self._switchTog:Delete()
  base.OnDelete(self)
end

return UINFmtChallengeTask
