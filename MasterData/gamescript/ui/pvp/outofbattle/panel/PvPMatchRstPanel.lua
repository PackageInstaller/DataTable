local UIAnimationController = CS.Z1Client.UIAnimationController
local PvPMatchRstPanel, Super = System.NewClass("DBGTeamRenamePanel", DBGTeamRenamePanel)
PvPMatchRstPanel.uiResCls = UI_Pvp_Panel_lineup_ShowResource

function PvPMatchRstPanel:ctor()
  Super.ctor(self)
  self.playerData = PvPMatchDataUtils.GetPlayerData()
  self.enermyData = PvPMatchDataUtils.GetEnermyData()
  self.countDownEnd = false
  self.battlePrepared = false
end

function PvPMatchRstPanel:OnBind(binder)
  binder:LoadAllLangFont(self.ui.Text_Myself)
  binder:LoadAllLangFont(self.ui.Text_Enemy)
  self:Init(binder)
  self:OnBindPlayerInfo()
  self:OnBindEnermyInfo()
  self:OnBindPlayerTeam()
  self:OnBindEnermyTeam()
  binder:BindEvent(EventMgr.Instance.BattleAssetsLoaded, function()
    self.battlePrepared = true
    self:CheckClose()
  end)
  self.timer = binder:BindTimer(1, DT.GetConstant("PVPLoadingDisplayTime"), nil, function()
    if PvPSettleDataUtils.GetSettleData() then
      PvpController.Instance:OpenPvpSettlePanels()
      self:Close()
      return
    end
    EventMgr.Instance.PvPEnterBattle:Dispatch()
    self.countDownEnd = true
    self:CheckClose()
  end)
  binder:BindEvent(EventMgr.Instance.BattleStart, function()
    self:Close()
  end)
  binder:BindTimer(15, 0, nil, function()
    if PvPSettleDataUtils.GetSettleData() then
      PvpController.Instance:OpenPvpSettlePanels()
    else
      EventMgr.Instance.PvPEnterBattle:Dispatch()
    end
    self.countDownEnd = true
    self:Close()
  end)
end

function PvPMatchRstPanel:Init(binder)
  self.binder = binder
  self.playerAwakersUI = {
    self.ui.Item_lineup_4,
    self.ui.Item_lineup_3,
    self.ui.Item_lineup_2,
    self.ui.Item_lineup_1
  }
  self.enermyAwakersUI = {
    self.ui.Item_lineup_5,
    self.ui.Item_lineup_6,
    self.ui.Item_lineup_7,
    self.ui.Item_lineup_8
  }
  self.uiAnimController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  self.uiAnimController:PlayState("UI_Pvp_Panel_lineup_Show_Open")
end

function PvPMatchRstPanel:OnBindPlayerInfo()
  local binder = self.binder
  binder:BindComponent((CommonHeadItem(self.ui.Myself_Head, {
    headIcon = ItemDataUtils.GetAvatarIcon(self.playerData.icon),
    frameIcon = ItemDataUtils.GetItemIcon(self.playerData.avatarFrame)
  })))
  binder:BindToText(self.ui.Text_Myself, function()
    do return LT.Text end
    return LT.Text, self.playerData.name
  end)
  binder:SetText(self.ui.Text_Integral_01, self.playerData.score)
  local isInDraftPvp = PvpDraftModel.Instance:IsInDraftPvp()
  binder:SetActive(self.ui.Image_MySelf_Pvp, not isInDraftPvp)
  binder:SetActive(self.ui.Image_MySelf_RotationMode, isInDraftPvp)
end

function PvPMatchRstPanel:OnBindEnermyInfo()
  local binder = self.binder
  binder:BindComponent((CommonHeadItem(self.ui.Enemy_Head, {
    headIcon = ItemDataUtils.GetAvatarIcon(self.enermyData.icon),
    frameIcon = ItemDataUtils.GetItemIcon(self.enermyData.avatarFrame)
  })))
  binder:BindToText(self.ui.Text_Enemy, function()
    do return LT.Text end
    return LT.Text, self.enermyData.name
  end)
  binder:SetText(self.ui.Text_Integral_02, self.enermyData.score)
  local isInDraftPvp = PvpDraftModel.Instance:IsInDraftPvp()
  binder:SetActive(self.ui.Image_Enemy_Pvp, not isInDraftPvp)
  binder:SetActive(self.ui.Image_Enemy_RotationMode, isInDraftPvp)
end

function PvPMatchRstPanel:OnBindPlayerTeam()
  for idx, ui in pairs(self.playerAwakersUI) do
    self:BindPreviewItemData(self.playerData.awakerList[idx], ui, true)
  end
end

function PvPMatchRstPanel:OnBindEnermyTeam()
  for idx, ui in pairs(self.enermyAwakersUI) do
    self:BindPreviewItemData(self.enermyData.awakerList[idx], ui, false)
  end
end

function PvPMatchRstPanel:BindPreviewItemData(awakerData, ui, isMine)
  local binder = self.binder
  local itemData = {awakerData = awakerData, isMine = isMine}
  binder:BindComponent(PvPMatchPrevewItem(ui, itemData))
end

function PvPMatchRstPanel:OnUnbind()
  if self.timer then
    self.binder:StopTimer(self.timer)
    self.timer = nil
  end
end

function PvPMatchRstPanel:CheckClose()
  if self.countDownEnd and self.battlePrepared then
    self:Close()
  end
end

return PvPMatchRstPanel
