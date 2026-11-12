local PenguinCardCtrl = class("PenguinCardCtrl", BaseCtrl)
local WwiseManger = CS.WwiseAudioManager.Instance
local PenguinCardUtils = require("Game.UI.Play_PenguinCard.PenguinCardUtils")
PenguinCardCtrl._mapNodeConfig = {
  btnPause = {
    nCount = 3,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Pause"
  },
  Start = {
    sNodeName = "---Start---",
    sCtrlName = "Game.UI.Play_PenguinCard.EndlessMode.PenguinCardStartCtrl"
  },
  Prepare = {
    sNodeName = "---Prepare---",
    sCtrlName = "Game.UI.Play_PenguinCard.EndlessMode.PenguinCardPrepareCtrl"
  },
  Flip = {
    sNodeName = "---Flip---",
    sCtrlName = "Game.UI.Play_PenguinCard.EndlessMode.PenguinCardFlipCtrl"
  },
  Slot = {
    sNodeName = "---Slot---",
    sCtrlName = "Game.UI.Play_PenguinCard.PenguinCardSlotCtrl"
  },
  AideSlot = {
    sNodeName = "---AideSlot---",
    sCtrlName = "Game.UI.Play_PenguinCard.EndlessMode.PenguinCardAideSlotCtrl"
  },
  Result = {
    sNodeName = "---Result---",
    sCtrlName = "Game.UI.Play_PenguinCard.EndlessMode.PenguinCardResultCtrl"
  },
  CardInfo = {
    sNodeName = "---CardInfo---",
    sCtrlName = "Game.UI.Play_PenguinCard.EndlessMode.PenguinCardInfoCtrl"
  },
  AideInfo = {
    sNodeName = "---AideInfo---",
    sCtrlName = "Game.UI.Play_PenguinCard.EndlessMode.PenguinCardAideInfoCtrl"
  },
  Pause = {
    sNodeName = "---Pause---",
    sCtrlName = "Game.UI.Play_PenguinCard.EndlessMode.PenguinCardPauseCtrl"
  },
  HandRank = {
    sNodeName = "---HandRank---",
    sCtrlName = "Game.UI.Play_PenguinCard.PenguinCardHandRankCtrl"
  },
  Log = {
    sNodeName = "---Log---",
    sCtrlName = "Game.UI.Play_PenguinCard.EndlessMode.PenguinCardLogCtrl"
  },
  Confirm = {
    sNodeName = "---Confirm---",
    sCtrlName = "Game.UI.Play_PenguinCard.PenguinCardConfirmCtrl"
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
  PenguinCard_RunState_EndlessCheck = "RunState_EndlessCheck",
  PenguinCard_QuitState_Start = "QuitState_Start",
  PenguinCard_QuitState_Prepare = "QuitState_Prepare",
  PenguinCard_QuitState_Dealing = "QuitState_Dealing",
  PenguinCard_QuitState_Flip = "QuitState_Flip",
  PenguinCard_QuitState_Settlement = "QuitState_Settlement",
  PenguinCard_QuitState_Complete = "QuitState_Complete",
  PenguinCard_QuitState_EndlessCheck = "QuitState_EndlessCheck",
  PenguinCard_AddBuff = "OnEvent_AddBuff",
  PenguinCard_DeleteBuff = "OnEvent_DeleteBuff",
  PenguinCard_OpenPause = "OnBtnClick_Pause",
  PenguinCard_Change = "OnEvent_Change",
  PenguinCard_TryShowBuff = "OnEvent_TryShowBuff",
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
  self._mapNode.Result.gameObject:SetActive(false)
  self._mapNode.Flip.gameObject:SetActive(false)
  if self._mapNode.Slot.gameObject.activeSelf == false then
    self._mapNode.Slot.gameObject:SetActive(true)
    self._mapNode.Slot:PlaySlotAni()
  end
  if self._mapNode.AideSlot.gameObject.activeSelf == false then
    self._mapNode.AideSlot.gameObject:SetActive(true)
  end
  self._mapNode.Prepare:Refresh()
  self._mapNode.Slot:Refresh()
  self._mapNode.AideSlot:Refresh()
  WwiseManger:PostEvent("Mode_Card_nextround")
end

function PenguinCardCtrl:QuitState_Prepare(nNextState)
  if nNextState == PenguinCardUtils.GameState.Start then
    self._mapNode.Slot:PlayOutAni()
    self._mapNode.AideSlot:PlayOutAni()
    self._mapNode.Prepare:PlayOutAni()
    self:ClearBuffItem()
    WwiseManger:PostEvent("Mode_Card_dissolve")
  elseif nNextState == PenguinCardUtils.GameState.Dealing then
    self._mapNode.Prepare:PlayOutAni()
    WwiseManger:PostEvent("Mode_Card_dissolve")
  elseif nNextState == PenguinCardUtils.GameState.Complete then
    self._mapNode.Slot:PlayOutAni()
    self._mapNode.AideSlot:PlayOutAni()
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
  self._mapNode.AideSlot:Refresh()
end

function PenguinCardCtrl:QuitState_Dealing(nNextState)
  if nNextState == PenguinCardUtils.GameState.Start then
    self._mapNode.Slot:PlayOutAni()
    self._mapNode.AideSlot:PlayOutAni()
    self._mapNode.Flip:PlayOutAni()
    self:ClearBuffItem()
    WwiseManger:PostEvent("Mode_Card_dissolve")
  elseif nNextState == PenguinCardUtils.GameState.Complete then
    self._mapNode.Slot:PlayOutAni()
    self._mapNode.AideSlot:PlayOutAni()
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
    self._mapNode.AideSlot:PlayOutAni()
    self._mapNode.Flip:PlayOutAni()
    self:ClearBuffItem()
    WwiseManger:PostEvent("Mode_Card_dissolve")
  elseif nNextState == PenguinCardUtils.GameState.Complete then
    self._mapNode.Slot:PlayOutAni()
    self._mapNode.AideSlot:PlayOutAni()
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
    self._mapNode.AideSlot:PlayOutAni()
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
      self:AddTimer(1, 0.65, function()
        self._mapNode.Flip:PlayRoundAni()
      end, true, true, true)
    end
  elseif nNextState == PenguinCardUtils.GameState.Complete then
    self._mapNode.Slot:PlayOutAni()
    self._mapNode.AideSlot:PlayOutAni()
    self._mapNode.Flip:PlayOutAni()
    self.animator:Play("PengUinCard_Bg_Result")
    self:ClearBuffItem()
    WwiseManger:PostEvent("Mode_Card_dissolve")
  end
end

function PenguinCardCtrl:RunState_EndlessCheck()
  self._mapNode.Log:Open(self._panel.mapLevel.nCurTurn)
end

function PenguinCardCtrl:QuitState_EndlessCheck(nNextState)
  if nNextState == PenguinCardUtils.GameState.Start then
    self._mapNode.Slot:PlayOutAni()
    self._mapNode.AideSlot:PlayOutAni()
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
    self._mapNode.AideSlot:PlayOutAni()
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

function PenguinCardCtrl:CloseAll()
  self._mapNode.Start.gameObject:SetActive(false)
  self._mapNode.Prepare.gameObject:SetActive(false)
  self._mapNode.Slot.gameObject:SetActive(false)
  self._mapNode.AideSlot.gameObject:SetActive(false)
  self._mapNode.Flip.gameObject:SetActive(false)
  self._mapNode.CardInfo.gameObject:SetActive(false)
  self._mapNode.AideInfo.gameObject:SetActive(false)
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
  self.tbWaitShowBuff = {}
end

function PenguinCardCtrl:AddBuff(mapBuff)
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

function PenguinCardCtrl:OnEvent_AddBuff(mapBuff, bWaitShow)
  if bWaitShow then
    if self.tbWaitShowBuff == nil then
      self.tbWaitShowBuff = {}
    end
    table.insert(self.tbWaitShowBuff, mapBuff)
  else
    self:AddBuff(mapBuff)
  end
end

function PenguinCardCtrl:OnEvent_TryShowBuff()
  if next(self.tbWaitShowBuff) == nil then
    return
  end
  local nAll = #self.tbWaitShowBuff
  for i = nAll, 1, -1 do
    local mapBuff = self.tbWaitShowBuff[i]
    table.remove(self.tbWaitShowBuff, i)
    self:AddBuff(mapBuff)
  end
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
