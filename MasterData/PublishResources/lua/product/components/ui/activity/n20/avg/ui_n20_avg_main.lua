_class("UIN20AVGMain", UIController)
UIN20AVGMain = UIN20AVGMain

function UIN20AVGMain:Constructor()
  self.mCampaign = GameGlobal.GetModule(CampaignModule)
  self.data = self.mCampaign:GetN20AVGData()
  self.strsCD = {
    "str_avg_n20_left_d_h",
    "str_avg_n20_left_d",
    "str_avg_n20_left_h_m",
    "str_avg_n20_left_h",
    "str_avg_n20_left_m"
  }
end

function UIN20AVGMain:LoadDataOnEnter(TT, res, uiParams)
  self.data:RequestCampaign(TT)
  if self.data:IsActiveOpen() then
    self.data:Init()
    self.data:Update()
  else
    res:SetSucc(false)
    ToastManager.ShowToast(StringTable.Get("str_n20_component_close_tips"))
  end
end

function UIN20AVGMain:OnShow(uiParams)
  self.txtLeftTime = self:GetUIComponent("RollingText", "txtLeftTime")
  self.btnNew = self:GetGameObject("btnNew")
  self.btnContinue = self:GetGameObject("btnContinue")
  self.newSelect = self:GetGameObject("newSelect")
  self.newCollection = self:GetGameObject("newCollection")
  self.redCollection = self:GetGameObject("redCollection")
  self:AttachEvent(GameEventType.AVGFlushNewRed, self.AVGFlushNewRed)
  self:Flush()
end

function UIN20AVGMain:OnHide()
  self:DetachEvent(GameEventType.AVGFlushNewRed, self.AVGFlushNewRed)
end

function UIN20AVGMain:Flush()
  local info = self.data:GetComponentInfoAVG()
  UIForge.FlushCDText(self.txtLeftTime, info.m_close_time, self.strsCD, false)
  if self.data:OnTheWay() then
    self.btnNew:SetActive(false)
    self.btnContinue:SetActive(true)
  else
    self.btnNew:SetActive(true)
    self.btnContinue:SetActive(false)
  end
  self:FlushNew()
  self:FlushRed()
end

function UIN20AVGMain:FlushNew()
  if self.data:HasNewNode() then
    self.newSelect:SetActive(true)
  else
    self.newSelect:SetActive(false)
  end
  if self.data:HasNewBadge() or self.data:HasNewCG() then
    self.newCollection:SetActive(true)
  else
    self.newCollection:SetActive(false)
  end
end

function UIN20AVGMain:FlushRed()
  if self.data:HasRed() then
    self.redCollection:SetActive(true)
  else
    self.redCollection:SetActive(false)
  end
end

function UIN20AVGMain:AVGFlushNewRed()
  self:FlushNew()
  self:FlushRed()
end

function UIN20AVGMain:btnIntroOnClick(go)
  self:ShowDialog("UIN20AVGIntro")
end

function UIN20AVGMain:btnNewOnClick(go)
  local curNode = self.data:CurNode()
  self:SwitchState(UIStateType.UIN20AVGStory, curNode.id)
end

function UIN20AVGMain:btnContinueOnClick(go)
  self:ShowDialog("UIN20AVGNodeDetails", self.data:CurNodeId())
end

function UIN20AVGMain:btnSelectOnClick(go)
  self:ShowDialog("UIN20AVGGraph")
end

function UIN20AVGMain:btnCollectionOnClick(go)
  self:ShowDialog("UIN20AVGCollection")
end

function UIN20AVGMain:btnExitOnClick(go)
  self:SwitchState(UIStateType.UIActivityN20MainController)
end
