local UINTaskBattlePass = class("UINTaskBattlePass", UIBaseNode)
local base = UIBaseNode
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local JumpManager = require("Game.Jump.JumpManager")

function UINTaskBattlePass:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Goto, self, self.OnGotoBattlePassClicked)
  self.__onBattlePassDataChange = BindCallback(self, self.OnBattlePassDataChanged)
  MsgCenter:AddListener(eMsgEventId.BattlePassChange, self.__onBattlePassDataChange)
  self.__onBattlePassReddotRefresh = BindCallback(self, self.OnBattlePassReddotRefresh)
end

function UINTaskBattlePass:InitTaskBattlePass()
  local passInfo = PlayerDataCenter.battlepassData:GetMainBattlePass()
  if passInfo == nil then
    self.passInfo = nil
    self:Hide()
    return
  end
  self:Show()
  if self.passInfo == passInfo then
    return
  end
  self.passInfo = passInfo
  self:RefreshTaskBattlePassNode()
  local redNode = self.passInfo:GetBattlepassReddot()
  if self.__redNodePath ~= nil then
    RedDotController:RemoveListener(self.__redNodePath, self.__onBattlePassReddotRefresh)
    self.__redNodePath = nil
  end
  if redNode == nil then
    self.ui.obj_redDot:SetActive(false)
    return
  end
  self.ui.obj_redDot:SetActive(redNode:GetRedDotCount() > 0)
  self.__redNodePath = redNode.nodePath
  RedDotController:AddListener(self.__redNodePath, self.__onBattlePassReddotRefresh)
end

function UINTaskBattlePass:RefreshTaskBattlePassNode()
  self.ui.tex_BPLevel:SetIndex(0, tostring(self.passInfo.level))
  local fillAmount = self.passInfo.exp / self.passInfo:GetPassCurLevelExp()
  local isFullLevel = self.passInfo:IsPassFullLevel()
  self.ui.tex_BPExpMax:SetActive(isFullLevel)
  self.ui.tex_BPExp.gameObject:SetActive(not isFullLevel)
  if isFullLevel then
    fillAmount = 1
  else
    self.ui.tex_BPExp.text = tostring(self.passInfo.exp) .. "/" .. tostring(self.passInfo:GetPassCurLevelExp())
  end
  self.ui.slider_bPExpBar.value = fillAmount
  self.ui.tex_LimitExp.text = string.format("%d/%d", self.passInfo.weeklyExp, self.passInfo:GetWeeklyExpLimit())
end

function UINTaskBattlePass:OnBattlePassReddotRefresh(redNode)
  self.ui.obj_redDot:SetActive(redNode:GetRedDotCount() > 0)
end

function UINTaskBattlePass:OnBattlePassDataChanged(id)
  if self.passInfo == nil then
    return
  end
  if id ~= self.passInfo.id then
    return
  end
  self:RefreshTaskBattlePassNode()
end

function UINTaskBattlePass:OnGotoBattlePassClicked()
  if self.passInfo == nil then
    return
  end
  if not self.passInfo:IsBattlePassValid() then
    local showingWindow = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
    showingWindow:ShowTextBoxWithConfirm(ConfigData:GetTipContent(323), nil)
    return
  end
  local activityId = self.passInfo:GetBattlePassActivityId()
  if activityId == 0 then
    return
  end
  JumpManager:Jump(JumpManager.eJumpTarget.DynActivity, nil, nil, {activityId})
end

function UINTaskBattlePass:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.BattlePassChange, self.__onBattlePassDataChange)
  if self.__redNodePath ~= nil then
    RedDotController:RemoveListener(self.__redNodePath, self.__onBattlePassReddotRefresh)
  end
  base.OnDelete(self)
end

return UINTaskBattlePass
