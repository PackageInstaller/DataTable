_class("UICN14N43FrogCollect", UIController)
UICN14N43FrogCollect = UICN14N43FrogCollect

function UICN14N43FrogCollect:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UICN14N43FrogCollect:OnShow(uiParams)
  self.CollectFrogData = {}
  self.CollectFrogNum = 0
  self.RecycleFrogNum = 0
  self.FrogNumMax = 0
  self.frogInfo = uiParams[1]
  self.clickCallFun = uiParams[2]
  self.canClick = true
  self:InitWidget()
  self.FrogNumMax = table.count(Cfg.cfg_frog_info())
  self._svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  GameGlobal.TaskManager():StartTask(function(TT)
    local res = UIStateSwitchReq:New()
    res:SetSucc(true)
    local campaign = UIActivityCampaign.New()
    campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_COLLECT_FROG, ECampaignCollectFrogComponentID.ECAMPAIGN_COLLECT_FROG_PERSON_PROCESS)
    self._localProcess = campaign:GetLocalProcess()
    self._personProgressComponent = self._localProcess:GetComponent(ECampaignCollectFrogComponentID.ECAMPAIGN_COLLECT_FROG_PERSON_PROCESS)
    self.cmpInfo = self._personProgressComponent:ComponentInfo()
    local sample = campaign:GetSample()
    self._endTime = sample.end_time
    self:_CollectFrogFormatData()
    self.RecycleFrogNum = self.cmpInfo.m_mark_else
    Log.debug("[Frog] [CreateFrog]  mark:", self.cmpInfo.m_mark, ", self.RecycleFrogNum:", self.RecycleFrogNum)
    self:RefUI()
  end)
end

function UICN14N43FrogCollect:_CollectFrogFormatData()
  self.CollectFrogData = {}
  self.CollectFrogNum = 0
  local mark = self.cmpInfo.m_mark
  for i = self.FrogNumMax, 1, -1 do
    self.CollectFrogData[i] = mark & 1
    mark = mark >> 1
    if self.CollectFrogData[i] == 1 then
      self.CollectFrogNum = self.CollectFrogNum + 1
    end
  end
end

function UICN14N43FrogCollect:InitWidget()
  self.moveNode = self:GetGameObject("MoveNode")
  self._ContentTxt = self:GetUIComponent("UILocalizationText", "ContentTxt")
  self._animation = self:GetUIComponent("Animation", "Anim")
  self._TestTips = self:GetUIComponent("UILocalizationText", "TestTips")
end

function UICN14N43FrogCollect:RefUI()
  self.moveNode.transform.localPosition = self.frogInfo.PopPos
  self._ContentTxt:SetText(StringTable.Get(self.frogInfo.PopTxtKey))
  self._TestTips:SetText(self.CollectFrogNum .. "/" .. self.FrogNumMax)
end

function UICN14N43FrogCollect:CollectBtnOnClick(go)
  if not self.canClick then
    return
  end
  if self.clickCallFun then
    self.clickCallFun(self.frogInfo.ID)
  end
  self:CloseBtnOnClick()
end

function UICN14N43FrogCollect:CloseBtnOnClick(go)
  if not self.canClick then
    return
  end
  self.canClick = false
  self:StartTask(function(TT)
    self._animation:Play("effanim_UICN14N43FrogCollect_out")
    YIELD(TT, 220)
    self:CloseDialog()
  end, self)
end
