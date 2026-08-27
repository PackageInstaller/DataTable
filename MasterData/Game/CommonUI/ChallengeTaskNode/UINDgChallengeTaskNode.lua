local base = UIBaseNode
local UINDgChallengeTaskNode = class("UINDgChallengeTaskNode", base)
local DungeonChallengeData = require("Game.StageChallenge.Data.DungeonChallengeData")
local UINCommonSwitchToggle = require("Game.CommonUI.CommonSwitchToggle.UINCommonSwitchToggle")

function UINDgChallengeTaskNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Challenge, self, self._OnClickChallenge)
  self._switchChallengeTog = UINCommonSwitchToggle.New()
  self._switchChallengeTog:Init(self.ui.tog_SwitchChallenge)
  self._switchChallengeTog:CommonSwitchTogAutoSetValue(false)
  self._changeChallengeFunc = BindCallback(self, self._OnClickChallengeModeTog)
  self._imgProgressSingleWidth = self.ui.bgProgrss.sizeDelta.x
end

function UINDgChallengeTaskNode:SetDgClgInfoShowFunc(showFunc)
  self._showClgInfoShowFunc = showFunc
end

function UINDgChallengeTaskNode:InitChallengeTaskNode(dungeonId, isLock)
  self:Hide()
  self._stgChallengeData = nil
  if isLock then
    return
  end
  self._dungeonId = dungeonId
  if not PlayerDataCenter.dungeonCenterData:HasDungeonChallengeTask(dungeonId) then
    return
  end
  self:Show()
  self._stgChallengeData = DungeonChallengeData.Create(dungeonId)
  local isChallengeMode = false
  if PlayerDataCenter.dungeonCenterData:IsDungeonChallengeTaskOpen(dungeonId) then
    local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
    isChallengeMode = saveUserData:GetChallengeDgSwitch(dungeonId)
  end
  self._stgChallengeData:SetStageChallengeOpen(isChallengeMode)
  self._switchChallengeTog:InitCommonSwitchToggle(isChallengeMode, self._changeChallengeFunc)
  self:_UpdClgRewardNumPrewview()
  self:_UpdTaskProgress()
end

function UINDgChallengeTaskNode:_UpdTaskProgress()
  local taskIdList = self._stgChallengeData:GetStgChallengeTaskList()
  local taskNumAll = #taskIdList
  local completeNum = PlayerDataCenter.dungeonCenterData:GetDgChallengeTaskCompleteNum(self._dungeonId)
  local height = self.ui.bgProgrss.sizeDelta.y
  self.ui.bgProgrss.sizeDelta = Vector2.Temp(taskNumAll * self._imgProgressSingleWidth, height)
  self.ui.curProgrss.sizeDelta = Vector2.Temp(completeNum * self._imgProgressSingleWidth, height)
end

function UINDgChallengeTaskNode:_OnClickChallenge()
  if self._showClgInfoShowFunc ~= nil then
    self._showClgInfoShowFunc()
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.FmtChallengeInfo, function(win)
    if win == nil then
      return
    end
    win:InitFmtChallengeInfo(self._stgChallengeData, function()
      if self._stgChallengeData:IsStageChallengeOpen() then
        self:_UpdClgRewardNumPrewview()
        return
      end
      self:_SetChallengeModeOpen(true)
    end)
  end)
end

function UINDgChallengeTaskNode:_OnClickChallengeModeTog(isChallengeMode)
  if self._showClgInfoShowFunc ~= nil then
    self._showClgInfoShowFunc()
  end
  self:_SetChallengeModeOpen(isChallengeMode)
  if isChallengeMode then
    UIManager:ShowWindowAsync(UIWindowTypeID.FmtChallengeInfo, function(win)
      if win == nil then
        return
      end
      win:InitFmtChallengeInfo(self._stgChallengeData, function()
        self:_UpdClgRewardNumPrewview()
      end)
    end)
  end
end

function UINDgChallengeTaskNode:_SetChallengeModeOpen(isChallengeMode)
  if self._stgChallengeData:IsStageChallengeOpen() == isChallengeMode then
    return
  end
  self._stgChallengeData:SetStageChallengeOpen(isChallengeMode)
  self._switchChallengeTog:SetCommonSwitchToggleValue(isChallengeMode)
  self:_UpdClgRewardNumPrewview()
end

function UINDgChallengeTaskNode:_UpdClgRewardNumPrewview()
  if self._stgChallengeData == nil then
    return
  end
  local rewardNum = self._stgChallengeData:GetStgChallengeTaskRewardNum()
  if 0 < rewardNum then
    self.ui.obj_ClgReward:SetActive(true)
    self.ui.tex_ClgRewardNum:SetIndex(0, tostring(rewardNum))
  else
    self.ui.obj_ClgReward:SetActive(false)
  end
end

function UINDgChallengeTaskNode:UpdDgChallengeTask()
  if self._stgChallengeData ~= nil then
    self._switchChallengeTog:SetCommonSwitchToggleValue(self._stgChallengeData:IsStageChallengeOpen())
    self:_UpdClgRewardNumPrewview()
  end
end

function UINDgChallengeTaskNode:GetDgChallengeNodeData()
  return self._stgChallengeData
end

function UINDgChallengeTaskNode:ShowDgChallengeTaskBlueDot(isShow)
  self.ui.obj_blueDot:SetActive(isShow)
end

function UINDgChallengeTaskNode:OnDelete()
  base.OnDelete(self)
end

return UINDgChallengeTaskNode
