_class("UIN28AVGMain", UIController)
UIN28AVGMain = UIN28AVGMain

function UIN28AVGMain:Constructor()
  self.mCampaign = GameGlobal.GetModule(CampaignModule)
  self.data = self.mCampaign:GetN28AVGData()
  self.strsCD = {
    "str_avg_n28_left_d_h",
    "str_avg_n28_left_d",
    "str_avg_n28_left_h_m",
    "str_avg_n28_left_h",
    "str_avg_n28_left_m"
  }
end

function UIN28AVGMain:LoadDataOnEnter(TT, res, uiParams)
  self.data:RequestCampaign(TT)
  if self.data:IsActiveOpen() then
    self.data:Init()
    self.data:Update()
  else
    res:SetSucc(false)
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
  end
end

function UIN28AVGMain:OnShow(uiParams)
  self.txtLeftTime = self:GetUIComponent("RollingText", "txtLeftTime")
  self.btnNew = self:GetGameObject("btnNew")
  self.btnContinue = self:GetGameObject("btnContinue")
  self.newSelect = self:GetGameObject("newSelect")
  self.newCollection = self:GetGameObject("newCollection")
  self.redCollection = self:GetGameObject("redCollection")
  self.eff = self:GetGameObject("eff")
  self.effTrans = self:GetUIComponent("RectTransform", "eff")
  self:AttachEvent(GameEventType.AVGFlushNewRed, self.AVGFlushNewRed)
  self:Flush()
  self:_CheckGuide()
end

function UIN28AVGMain:OnHide()
  self:DetachEvent(GameEventType.AVGFlushNewRed, self.AVGFlushNewRed)
end

function UIN28AVGMain:Flush()
  local info = self.data:GetComponentInfoAVG()
  UIForge.FlushCDText(self.txtLeftTime, info.m_close_time, self.strsCD, false)
  if self.data:OnTheWay() then
    self.btnNew:SetActive(false)
    self.btnContinue:SetActive(true)
  else
    self.btnNew:SetActive(true)
    self.btnContinue:SetActive(false)
  end
  self.collectionHasNew = false
  self:FlushNew()
  self:FlushRed()
end

function UIN28AVGMain:FlushNew()
  if self.data:HasNewNode() then
    self.newSelect:SetActive(true)
  else
    self.newSelect:SetActive(false)
  end
  if self.data:HasNewBadge() or self.data:HasNewCG() or self.data:HasNewEvidence() then
    self.collectionHasNew = true
  else
    self.collectionHasNew = false
  end
  self.newCollection:SetActive(self.collectionHasNew)
end

function UIN28AVGMain:FlushRed()
  if self.data:HasRed() and not self.collectionHasNew then
    self.redCollection:SetActive(true)
  else
    self.redCollection:SetActive(false)
  end
end

function UIN28AVGMain:AVGFlushNewRed()
  self:FlushNew()
  self:FlushRed()
end

function UIN28AVGMain:BtnIntroOnClick(go)
  self:ShowDialog("UIN28AVGIntro")
end

function UIN28AVGMain:BtnNewOnClick(go)
  self:PlayBtnAnim(1, go)
end

function UIN28AVGMain:BtnContinueOnClick(go)
  self:PlayBtnAnim(2, go)
end

function UIN28AVGMain:BtnSelectOnClick(go)
  self:PlayBtnAnim(3, go)
end

function UIN28AVGMain:BtnCollectionOnClick(go)
  self:PlayBtnAnim(4, go)
end

function UIN28AVGMain:BtnExitOnClick(go)
  self:PlayBtnAnim(5, go)
end

function UIN28AVGMain:PlayBtnAnim(id, go)
  local anchY = go:GetComponent(typeof(UnityEngine.RectTransform)).anchoredPosition.y
  self.effTrans.anchoredPosition = Vector2(-200, anchY)
  self.eff:SetActive(true)
  GameGlobal.UIStateManager():Lock("UIN28AVGMainBtnClick")
  GameGlobal.TaskManager():StartTask(function(TT)
    YIELD(TT, 400)
    if id == 1 then
      local curNode = self.data:CurNode()
      self:SwitchState(UIStateType.UIN28AVGStory, curNode.id)
    elseif id == 2 then
      self:ShowDialog("UIN28AVGNodeDetails", self.data:CurNodeId())
    elseif id == 3 then
      self:ShowDialog("UIN28AVGGraph")
    elseif id == 4 then
      self:ShowDialog("UIN28AVGCollection")
    elseif id == 5 then
      CutsceneManager.ExcuteCutsceneIn_Shot()
      self:SwitchState(UIStateType.UIActivityN28MainController)
    end
    GameGlobal.UIStateManager():UnLock("UIN28AVGMainBtnClick")
    self.eff:SetActive(false)
  end, self)
end

function UIN28AVGMain:_CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIN42AVGMain)
end
