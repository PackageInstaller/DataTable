local PenguinCardCtrl = class("PenguinCardCtrl", BaseCtrl)
local WwiseManger = CS.WwiseAudioManager.Instance
local PenguinCardUtils = require("Game.UI.Play_PenguinCard.PenguinCardUtils")
PenguinCardCtrl._mapNodeConfig = {
  btnPause = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Pause"
  },
  btnOpenQuest = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_OpenQuest"
  },
  Start = {
    sNodeName = "---Start---",
    sCtrlName = "Game.UI.Play_PenguinCard.NormalMode.PenguinCardStartCtrl"
  },
  Prepare = {
    sNodeName = "---Prepare---",
    sCtrlName = "Game.UI.Play_PenguinCard.NormalMode.PenguinCardPrepareCtrl"
  },
  Flip = {
    sNodeName = "---Flip---",
    sCtrlName = "Game.UI.Play_PenguinCard.NormalMode.PenguinCardFlipCtrl"
  },
  Slot = {
    sNodeName = "---Slot---",
    sCtrlName = "Game.UI.Play_PenguinCard.PenguinCardSlotCtrl"
  },
  Result = {
    sNodeName = "---Result---",
    sCtrlName = "Game.UI.Play_PenguinCard.NormalMode.PenguinCardResultCtrl"
  },
  CardInfo = {
    sNodeName = "---CardInfo---",
    sCtrlName = "Game.UI.Play_PenguinCard.NormalMode.PenguinCardInfoCtrl"
  },
  Pause = {
    sNodeName = "---Pause---",
    sCtrlName = "Game.UI.Play_PenguinCard.NormalMode.PenguinCardPauseCtrl"
  },
  HandRank = {
    sNodeName = "---HandRank---",
    sCtrlName = "Game.UI.Play_PenguinCard.PenguinCardHandRankCtrl"
  },
  Log = {
    sNodeName = "---Log---",
    sCtrlName = "Game.UI.Play_PenguinCard.NormalMode.PenguinCardLogCtrl"
  },
  Confirm = {
    sNodeName = "---Confirm---",
    sCtrlName = "Game.UI.Play_PenguinCard.PenguinCardConfirmCtrl"
  },
  Quest = {
    sNodeName = "---Quest---",
    sCtrlName = "Game.UI.Play_PenguinCard.NormalMode.PenguinCardQuestSelectCtrl"
  },
  BuffTips = {
    sNodeName = "---BuffTips---",
    sCtrlName = "Game.UI.Play_PenguinCard.PenguinCardBuffTipsCtrl"
  },
  goCurBuff = {},
  rtBuff = {sNodeName = "---Buff---", sComponentName = "Transform"},
  cgBuff = {
    sNodeName = "---Buff---",
    sComponentName = "CanvasGroup"
  },
  Block = {
    sNodeName = "----Block----"
  }
}
PenguinCardCtrl._mapEventConfig = {
  PenguinCard_RunState_Start = "RunState_Start",
  PenguinCard_RunState_Prepare = "RunState_Prepare",
  PenguinCard_RunState_Dealing = "RunState_Dealing",
  PenguinCard_RunState_Flip = "RunState_Flip",
  PenguinCard_RunState_Settlement = "RunState_Settlement",
  PenguinCard_RunState_Complete = "RunState_Complete",
  PenguinCard_RunState_Quest = "RunState_Quest",
  PenguinCard_QuitState_Start = "QuitState_Start",
  PenguinCard_QuitState_Prepare = "QuitState_Prepare",
  PenguinCard_QuitState_Dealing = "QuitState_Dealing",
  PenguinCard_QuitState_Flip = "QuitState_Flip",
  PenguinCard_QuitState_Settlement = "QuitState_Settlement",
  PenguinCard_QuitState_Complete = "QuitState_Complete",
  PenguinCard_QuitState_Quest = "QuitState_Quest",
  PenguinCard_AddBuff = "OnEvent_AddBuff",
  PenguinCard_DeleteBuff = "OnEvent_DeleteBuff",
  PenguinCard_OpenPause = "OnBtnClick_Pause",
  PenguinCard_QuestSelectOpen = "OnEvent_QuestSelectOpen",
  PenguinCard_Change = "OnEvent_Change",
  PenguinCard_Block = "OnEvent_Block"
}

function PenguinCardCtrl:RunState_Start()
  self:CloseAll()
  self._mapNode.Start.gameObject:SetActive(true)
  self._mapNode.Start:Refresh()
end

function PenguinCardCtrl:QuitState_Start(nNextState)
  self._mapNode.Start:PlayOutAni()
  if nNextState == PenguinCardUtils.GameState.Start or nNextState == PenguinCardUtils.GameState.Complete then
    self:ClearBuffItem()
  end
end

function PenguinCardCtrl:RunState_Prepare()
  self._mapNode.Start.gameObject:SetActive(false)
  self._mapNode.Prepare.gameObject:SetActive(true)
  self._mapNode.Slot.gameObject:SetActive(true)
  self._mapNode.Result.gameObject:SetActive(false)
  self._mapNode.Flip.gameObject:SetActive(false)
  self._mapNode.Prepare:Refresh()
  self._mapNode.Slot:Refresh()
  WwiseManger:PostEvent("Mode_Card_nextround")
  EventManager.Hit("Guide_PassiveCheck_Msg", "Guide_PenguinCard_301")
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    EventManager.Hit("Guide_PassiveCheck_Msg", "Guide_PenguinCard_303")
  end
  
  cs_coroutine.start(wait)
end

function PenguinCardCtrl:QuitState_Prepare(nNextState)
  if nNextState == PenguinCardUtils.GameState.Start then
    self._mapNode.Slot:PlayOutAni()
    self._mapNode.Prepare:PlayOutAni()
    self:ClearBuffItem()
    WwiseManger:PostEvent("Mode_Card_dissolve")
  elseif nNextState == PenguinCardUtils.GameState.Dealing then
    self._mapNode.Prepare:PlayOutAni()
    WwiseManger:PostEvent("Mode_Card_dissolve")
  elseif nNextState == PenguinCardUtils.GameState.Complete then
    self._mapNode.Slot:PlayOutAni()
    self._mapNode.Prepare:PlayOutAni()
    self.animator:Play("PengUinCard_Bg_Result")
    self:ClearBuffItem()
    WwiseManger:PostEvent("Mode_Card_dissolve")
  end
end

function PenguinCardCtrl:RunState_Dealing()
  self._mapNode.Prepare.gameObject:SetActive(false)
  self._mapNode.Flip.gameObject:SetActive(true)
  self._mapNode.Flip:Refresh_Dealing()
  self._mapNode.Slot:Refresh()
  EventManager.Hit("Guide_PassiveCheck_Msg", "Guide_PenguinCard_302")
end

function PenguinCardCtrl:QuitState_Dealing(nNextState)
  if nNextState == PenguinCardUtils.GameState.Start then
    self._mapNode.Slot:PlayOutAni()
    self._mapNode.Flip:PlayOutAni()
    self:ClearBuffItem()
    WwiseManger:PostEvent("Mode_Card_dissolve")
  elseif nNextState == PenguinCardUtils.GameState.Complete then
    self._mapNode.Slot:PlayOutAni()
    self._mapNode.Flip:PlayOutAni()
    self.animator:Play("PengUinCard_Bg_Result")
    self:ClearBuffItem()
    WwiseManger:PostEvent("Mode_Card_dissolve")
  end
end

function PenguinCardCtrl:RunState_Flip()
  self._mapNode.Flip:Refresh_Flip()
end

function PenguinCardCtrl:QuitState_Flip(nNextState)
  self._mapNode.Flip:StopShowAllOn()
  if nNextState == PenguinCardUtils.GameState.Start then
    self._mapNode.Slot:PlayOutAni()
    self._mapNode.Flip:PlayOutAni()
    self:ClearBuffItem()
    WwiseManger:PostEvent("Mode_Card_dissolve")
  elseif nNextState == PenguinCardUtils.GameState.Complete then
    self._mapNode.Slot:PlayOutAni()
    self._mapNode.Flip:PlayOutAni()
    self.animator:Play("PengUinCard_Bg_Result")
    self:ClearBuffItem()
    WwiseManger:PostEvent("Mode_Card_dissolve")
  end
end

function PenguinCardCtrl:RunState_Settlement()
  self._mapNode.Flip:Refresh_Settlement()
end

function PenguinCardCtrl:QuitState_Settlement(nNextState)
  if nNextState == PenguinCardUtils.GameState.Start then
    self._mapNode.Slot:PlayOutAni()
    self._mapNode.Flip:PlayOutAni()
    self:ClearBuffItem()
    WwiseManger:PostEvent("Mode_Card_dissolve")
  elseif nNextState == PenguinCardUtils.GameState.Prepare then
    self._mapNode.Flip:PlayOutAni()
    WwiseManger:PostEvent("Mode_Card_dissolve")
  elseif nNextState == PenguinCardUtils.GameState.Dealing then
    if self._panel.mapLevel.bRestoreSnapshot then
      self._mapNode.Flip:PlayRoundBackAni()
    else
      self._mapNode.Flip:PlayRoundAni()
    end
  elseif nNextState == PenguinCardUtils.GameState.Complete then
    self._mapNode.Slot:PlayOutAni()
    self._mapNode.Flip:PlayOutAni()
    self.animator:Play("PengUinCard_Bg_Result")
    self:ClearBuffItem()
    WwiseManger:PostEvent("Mode_Card_dissolve")
  end
end

function PenguinCardCtrl:RunState_Complete()
  self._mapNode.Result:Open()
end

function PenguinCardCtrl:QuitState_Complete()
end

function PenguinCardCtrl:RunState_Quest(bSkip)
  if bSkip then
    return
  end
  self._mapNode.Quest:Open()
end

function PenguinCardCtrl:QuitState_Quest(nNextState)
  if nNextState == PenguinCardUtils.GameState.Start then
    self._mapNode.Slot:PlayOutAni()
    self._mapNode.Flip:PlayOutAni()
    self:ClearBuffItem()
    WwiseManger:PostEvent("Mode_Card_dissolve")
  elseif nNextState == PenguinCardUtils.GameState.Prepare then
    self._mapNode.Flip:PlayOutAni()
    WwiseManger:PostEvent("Mode_Card_dissolve")
  elseif nNextState == PenguinCardUtils.GameState.Complete then
    self._mapNode.Slot:PlayOutAni()
    self._mapNode.Flip:PlayOutAni()
    self.animator:Play("PengUinCard_Bg_Result")
    self:ClearBuffItem()
    WwiseManger:PostEvent("Mode_Card_dissolve")
  end
end

function PenguinCardCtrl:CloseAll()
  self._mapNode.Start.gameObject:SetActive(false)
  self._mapNode.Prepare.gameObject:SetActive(false)
  self._mapNode.Slot.gameObject:SetActive(false)
  self._mapNode.Flip.gameObject:SetActive(false)
  self._mapNode.Quest.gameObject:SetActive(false)
  self._mapNode.CardInfo.gameObject:SetActive(false)
  self._mapNode.Pause.gameObject:SetActive(false)
  self._mapNode.HandRank.gameObject:SetActive(false)
  self._mapNode.Result.gameObject:SetActive(false)
  self._mapNode.Log.gameObject:SetActive(false)
  self._mapNode.Confirm.gameObject:SetActive(false)
  self.nBlockRC = 0
  self._mapNode.Block:SetActive(false)
end

function PenguinCardCtrl:ClearBuffItem()
  delChildren(self._mapNode.rtBuff)
  self.tbBuffItem = {}
  self._mapNode.Quest:ClearBuffItem()
end

function PenguinCardCtrl:Awake()
  self.animator = self.gameObject:GetComponent("Animator")
  self:CloseAll()
end

function PenguinCardCtrl:OnEnable()
  self._panel.mapLevel:StartGame()
  self._mapNode.Flip:RefreshButton()
end

function PenguinCardCtrl:OnDisable()
  self._panel.mapLevel = nil
end

function PenguinCardCtrl:OnBtnClick_Pause(btn)
  self._mapNode.Pause:Open()
end

function PenguinCardCtrl:OnBtnClick_OpenQuest(btn)
  if self._panel.mapLevel.mapQuest == nil then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("PenguinCard_Tip_NoneQuest"))
    return
  end
  self._mapNode.Quest:Open(true)
end

function PenguinCardCtrl:OnEvent_AddBuff(mapBuff)
  if not self.tbBuffItem then
    self.tbBuffItem = {}
  end
  local goItemObj = instantiate(self._mapNode.goCurBuff, self._mapNode.rtBuff)
  goItemObj:SetActive(true)
  table.insert(self.tbBuffItem, goItemObj)
  local btn = goItemObj.transform:Find("btnOpenInfo"):GetComponent("UIButton")
  local imgSelect = goItemObj.transform:Find("btnOpenInfo/AnimRoot/imgSelect").gameObject
  local imgIcon = goItemObj.transform:Find("btnOpenInfo/AnimRoot/imgIcon"):GetComponent("Image")
  local ani = goItemObj.transform:Find("btnOpenInfo/AnimRoot"):GetComponent("Animator")
  self:SetSprite(imgIcon, "UI/Play_PenguinCard/SpriteAtlas/Sprite/" .. mapBuff.sIcon)
  ani:Play("PenguinCardBuff_in", 0, 0)
  
  local function click()
    imgSelect:SetActive(true)
    EventManager.Hit("PenguinCard_OpenBuffTips", mapBuff, function()
      imgSelect:SetActive(false)
    end)
  end
  
  btn.onClick:AddListener(click)
end

function PenguinCardCtrl:OnEvent_DeleteBuff(nIndex, nDelayTime, bSkipAni)
  if not self.tbBuffItem or next(self.tbBuffItem) == nil then
    return
  end
  local goBuff = self.tbBuffItem[nIndex]
  table.remove(self.tbBuffItem, nIndex)
  
  local function play()
    local ani = goBuff.transform:Find("btnOpenInfo/AnimRoot"):GetComponent("Animator")
    ani:Play("PenguinCardBuff_out", 0, 0)
    self:AddTimer(1, 0.4, function()
      destroy(goBuff)
    end, true, true, true)
  end
  
  if goBuff:IsNull() == false then
    if bSkipAni then
      destroy(goBuff)
      return
    end
    if nDelayTime and 0 < nDelayTime then
      self:AddTimer(1, nDelayTime, play, true, true, true)
    else
      play()
    end
  end
end

function PenguinCardCtrl:OnEvent_QuestSelectOpen()
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.cgBuff, 0)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.cgBuff, 1)
  end
  
  cs_coroutine.start(wait)
end

function PenguinCardCtrl:OnEvent_Block(bBlock)
  if self.nBlockRC == nil then
    self.nBlockRC = 0
  end
  if bBlock then
    if self.nBlockRC == 0 then
      self._mapNode.Block:SetActive(true)
    end
    self.nBlockRC = self.nBlockRC + 1
  else
    self.nBlockRC = self.nBlockRC - 1
    if self.nBlockRC == 0 then
      self._mapNode.Block:SetActive(false)
    elseif self.nBlockRC < 0 then
      self.nBlockRC = 0
      self._mapNode.Block:SetActive(false)
    end
  end
end

function PenguinCardCtrl:OnEvent_Change(callback)
  callback(self, self._panel.mapLevel)
end

return PenguinCardCtrl
