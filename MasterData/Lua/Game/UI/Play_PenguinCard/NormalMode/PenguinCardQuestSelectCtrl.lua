local PenguinCardQuestSelectCtrl = class("PenguinCardQuestSelectCtrl", BaseCtrl)
local PenguinCardUtils = require("Game.UI.Play_PenguinCard.PenguinCardUtils")
local _, NotMaxLevel = ColorUtility.TryParseHtmlString("#FFF7EA")
local _, MaxLevel = ColorUtility.TryParseHtmlString("#ffe075")
local WwiseManger = CS.WwiseAudioManager.Instance
PenguinCardQuestSelectCtrl._mapNodeConfig = {
  blur = {
    sNodeName = "t_fullscreen_blur_blue"
  },
  aniBlur = {
    sNodeName = "t_fullscreen_blur_blue",
    sComponentName = "Animator"
  },
  btnCloseBg = {
    sNodeName = "snapshot",
    sComponentName = "UIButton",
    callback = "OnBtnClick_Back"
  },
  Select = {sNodeName = "--Select--"},
  txtQuestTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "PenguinCard_Quest_SelectTitle"
  },
  btnConfirm = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Confirm"
  },
  txtBtnConfirm = {
    sComponentName = "TMP_Text",
    sLanguageId = "PenguinCard_Btn_SelectQuest"
  },
  rtBtnConfirm = {
    sNodeName = "btnConfirm",
    sComponentName = "RectTransform"
  },
  goSelectQuest = {
    nCount = 3,
    sCtrlName = "Game.UI.Play_PenguinCard.NormalMode.PenguinCardQuestItemCtrl"
  },
  btnQuest = {
    sComponentName = "UIButton",
    nCount = 3,
    callback = "OnBtnClick_Quest"
  },
  btnBack = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Back"
  },
  btnNext = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Next"
  },
  Count = {sNodeName = "--Count--"},
  goQuest = {
    sCtrlName = "Game.UI.Play_PenguinCard.NormalMode.PenguinCardQuestItemCtrl"
  },
  txtScore = {sComponentName = "TMP_Text"},
  goQuestBuff = {},
  rtQuestBuff = {sComponentName = "Transform"},
  Hp = {sNodeName = "--Hp--"},
  goHp = {nCount = 3, sComponentName = "Animator"},
  txtHpTip = {
    sComponentName = "TMP_Text",
    sLanguageId = "PenguinCard_Quest_FailDesc"
  },
  goInfo = {}
}
PenguinCardQuestSelectCtrl._mapEventConfig = {
  PenguinCard_AddBuff = "OnEvent_AddBuff",
  PenguinCard_DeleteBuff = "OnEvent_DeleteBuff",
  PenguinCard_ChangeScore = "OnEvent_ChangeScore",
  PenguinCard_ChangeHp = "OnEvent_ChangeHp",
  PenguinCard_Pause_SwitchGame = "FastClose",
  PenguinCard_BlockFatalDamage = "OnEvent_BlockFatalDamage"
}

function PenguinCardQuestSelectCtrl:Open(bCur)
  self._panel.mapLevel:Pause()
  local nScore = math.floor(self._panel.mapLevel.nScore)
  NovaAPI.SetTMPText(self._mapNode.txtScore, self:ThousandsNumber(nScore))
  self.bCur = bCur
  self:PlayInAni()
  NovaAPI.SetButtonInteractable(self._mapNode.btnCloseBg, self.bCur)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.goInfo:SetActive(true)
    if bCur then
      self:RefreshCur()
    else
      self:RefreshPhase()
    end
  end
  
  cs_coroutine.start(wait)
end

function PenguinCardQuestSelectCtrl:RefreshCur()
  self._mapNode.Select:SetActive(false)
  self._mapNode.Count:SetActive(true)
  self._mapNode.Hp:SetActive(true)
  self._mapNode.btnNext.gameObject:SetActive(false)
  self._mapNode.goQuest:Refresh(self._panel.mapLevel.mapQuest)
  self:RefreshHp()
  WwiseManger:PostEvent("Mode_Card_mission")
  self._mapNode.goQuest:PlayInAni()
end

function PenguinCardQuestSelectCtrl:RefreshPhase()
  self._mapNode.btnNext.gameObject:SetActive(false)
  self.callbackNext = nil
  local bPlayHpAni = false
  local bEmptySelect = next(self._panel.mapLevel.tbSelectableQuest) == nil
  
  local function next_select()
    self:TryShowBuff()
    self._mapNode.goQuest:PlayOutAni()
    if bEmptySelect then
      self:Close()
      self:AddTimer(1, 0.4, function()
        self._panel.mapLevel:SwitchGameState()
      end, true, true, true)
    else
      EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
      self:AddTimer(1, 0.2, function()
        self:RefreshSelect()
      end, true, true, true)
    end
  end
  
  if self._panel.mapLevel.mapQuestForShow then
    local bComplete = self._panel.mapLevel.mapQuestForShow:CheckComplete()
    if bComplete then
      self:RefreshCount(true)
      self:AddTimer(1, 0.5, function()
        self:TryShowBuff()
      end, true, true, true)
      self.callbackNext = next_select
      self._mapNode.btnNext.gameObject:SetActive(true)
    else
      local bExpired = self._panel.mapLevel.mapQuestForShow:CheckExpired()
      if bExpired then
        bPlayHpAni = true
        if self._panel.mapLevel.nHp > 0 then
          self:RefreshCount(false)
          self.callbackNext = next_select
          self._mapNode.btnNext.gameObject:SetActive(true)
        else
          self:RefreshCount(false)
          
          function self.callbackNext()
            self:FastClose()
            self:AddTimer(1, 0.2, function()
              self._panel.mapLevel:SwitchGameState()
            end, true, true, true)
          end
          
          self._mapNode.btnNext.gameObject:SetActive(true)
        end
      end
    end
  else
    self:RefreshSelect()
  end
  if bPlayHpAni then
    if self.bBlockFatalDamage then
      self.bBlockFatalDamage = false
      for i = 2, 3 do
        self._mapNode.goHp[i]:Play("PenguinCardHp_Null", 0, 0)
      end
      self:AddTimer(1, 0.5, function()
        self._mapNode.goHp[1]:Play("PenguinCardHp_Del", 0, 0)
        WwiseManger:PostEvent("Mode_Card_hurt")
        self:AddTimer(1, 1, function()
          self._mapNode.goHp[1]:Play("PenguinCardHp_Add")
          WwiseManger:PostEvent("Mode_Card_heal")
        end, true, true, true)
      end, true, true, true)
    else
      local nIndex = self._panel.mapLevel.nHp + 1
      for i = 1, 3 do
        if i > nIndex then
          self._mapNode.goHp[i]:Play("PenguinCardHp_Null", 0, 0)
        end
      end
      self:AddTimer(1, 0.5, function()
        self._mapNode.goHp[nIndex]:Play("PenguinCardHp_Del", 0, 0)
        WwiseManger:PostEvent("Mode_Card_hurt")
      end, true, true, true)
    end
  end
end

function PenguinCardQuestSelectCtrl:RefreshSelect()
  self._mapNode.Select:SetActive(true)
  self._mapNode.Count:SetActive(false)
  self._mapNode.Hp:SetActive(true)
  self.nSelectIndex = 0
  self._mapNode.btnConfirm.gameObject:SetActive(false)
  local nMax = #self._panel.mapLevel.tbSelectableQuest
  for i = 1, 3 do
    self._mapNode.goSelectQuest[i].gameObject:SetActive(i <= nMax)
    if i <= nMax then
      self._mapNode.goSelectQuest[i]:Refresh(self._panel.mapLevel.tbSelectableQuest[i])
      self._mapNode.goSelectQuest[i]:PlayInAni()
    end
  end
  self:RefreshHp()
  WwiseManger:PostEvent("Mode_Card_mission")
end

function PenguinCardQuestSelectCtrl:MoveConfirmButton(nIndex)
  local rtBtn = self._mapNode.goSelectQuest[nIndex].gameObject.transform:GetComponent("RectTransform")
  self._mapNode.rtBtnConfirm.localPosition = Vector3(rtBtn.localPosition.x, self.btnConfirmPosY, 0)
  if self._mapNode.btnConfirm.gameObject.activeSelf == false then
    self._mapNode.btnConfirm.gameObject:SetActive(true)
  else
    local animCtrl = self._mapNode.btnConfirm.transform:Find("AnimRoot/Show"):GetComponent("Animator")
    animCtrl:Play("btnConfirm_in", 0, 0)
  end
end

function PenguinCardQuestSelectCtrl:RefreshCount(bSuc)
  self._mapNode.Select:SetActive(false)
  self._mapNode.Count:SetActive(true)
  if bSuc == true then
    self._mapNode.Hp:SetActive(false)
    self._mapNode.goQuest:RefreshSuc(self._panel.mapLevel.mapQuestForShow)
    WwiseManger:PostEvent("Mode_Card_mission_com")
  elseif bSuc == false then
    self._mapNode.Hp:SetActive(true)
    self._mapNode.goQuest:RefreshFail(self._panel.mapLevel.mapQuestForShow)
    WwiseManger:PostEvent("Mode_Card_mission")
  end
  self._mapNode.goQuest:PlayInAni()
end

function PenguinCardQuestSelectCtrl:RefreshHp()
  for i = 1, 3 do
    if i > self._panel.mapLevel.nHp then
      self._mapNode.goHp[i]:Play("PenguinCardHp_Null", 0, 0)
    end
  end
end

function PenguinCardQuestSelectCtrl:ClearBuffItem()
  delChildren(self._mapNode.rtQuestBuff)
  self.tbBuffItem = {}
  self.tbWaitShowBuff = {}
end

function PenguinCardQuestSelectCtrl:PlayInAni()
  self.gameObject:SetActive(true)
  self._mapNode.blur:SetActive(true)
  EventManager.Hit("PenguinCard_QuestSelectOpen")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function PenguinCardQuestSelectCtrl:Close()
  self.animator:Play("PengUinCard_Quest_out", 0, 0)
  self._mapNode.aniBlur:SetTrigger("tOut")
  self._mapNode.btnConfirm.gameObject:SetActive(false)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.4)
  self:AddTimer(1, 0.4, function()
    self._panel.mapLevel:Resume()
    self._mapNode.goInfo:SetActive(false)
    self.gameObject:SetActive(false)
  end, true, true, true)
end

function PenguinCardQuestSelectCtrl:FastClose()
  if self.gameObject.activeSelf == false then
    return
  end
  self.animator:Play("PengUinCard_Quest_out_fast", 0, 0)
  self._mapNode.aniBlur:SetTrigger("tOut")
  self._mapNode.btnConfirm.gameObject:SetActive(false)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
  self:AddTimer(1, 0.2, function()
    self._panel.mapLevel:Resume()
    self._mapNode.goInfo:SetActive(false)
    self.gameObject:SetActive(false)
  end, true, true, true)
end

function PenguinCardQuestSelectCtrl:TryShowBuff()
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

function PenguinCardQuestSelectCtrl:AddBuff(mapBuff)
  if not self.tbBuffItem then
    self.tbBuffItem = {}
  end
  local goItemObj = instantiate(self._mapNode.goQuestBuff, self._mapNode.rtQuestBuff)
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

function PenguinCardQuestSelectCtrl:Awake()
  self._mapNode.goInfo:SetActive(false)
  self.animator = self.gameObject:GetComponent("Animator")
  self.btnConfirmPosY = self._mapNode.rtBtnConfirm.localPosition.y
  self.tbWaitShowBuff = {}
end

function PenguinCardQuestSelectCtrl:OnEnable()
end

function PenguinCardQuestSelectCtrl:OnDisable()
end

function PenguinCardQuestSelectCtrl:OnBtnClick_Quest(btn, nIndex)
  if self.nSelectIndex == nIndex then
    return
  end
  self:MoveConfirmButton(nIndex)
  if self.nSelectIndex ~= 0 then
    self._mapNode.goSelectQuest[self.nSelectIndex]:SetSelect(false)
    self._mapNode.goSelectQuest[self.nSelectIndex]:PlaySelectAni(false)
  end
  self._mapNode.goSelectQuest[nIndex]:SetSelect(true)
  self._mapNode.goSelectQuest[nIndex]:PlaySelectAni(true)
  self.nSelectIndex = nIndex
end

function PenguinCardQuestSelectCtrl:OnBtnClick_Confirm()
  if not self.nSelectIndex or self.nSelectIndex == 0 then
    return
  end
  local nMax = #self._panel.mapLevel.tbSelectableQuest
  for i = 1, nMax do
    if i == self.nSelectIndex then
      self._mapNode.goSelectQuest[i]:PlaySelectOutAni()
      self._mapNode.goSelectQuest[i]:SetSelect(false)
    else
      self._mapNode.goSelectQuest[i]:PlayOutAni()
    end
  end
  self._panel.mapLevel:SelectQuest(self.nSelectIndex)
  self:Close()
  self:AddTimer(1, 0.4, function()
    self._panel.mapLevel:SwitchGameState()
  end, true, true, true)
end

function PenguinCardQuestSelectCtrl:OnBtnClick_Back()
  if self.bCur then
    self._mapNode.goQuest:PlayOutAni()
    self:Close()
  else
    EventManager.Hit("PenguinCard_OpenPause")
  end
end

function PenguinCardQuestSelectCtrl:OnBtnClick_Next()
  if self.callbackNext then
    self.callbackNext()
  end
  self._mapNode.btnNext.gameObject:SetActive(false)
end

function PenguinCardQuestSelectCtrl:OnEvent_AddBuff(mapBuff, bWaitShow)
  if bWaitShow then
    table.insert(self.tbWaitShowBuff, mapBuff)
  else
    self:AddBuff(mapBuff)
  end
end

function PenguinCardQuestSelectCtrl:OnEvent_DeleteBuff(nIndex)
  if not self.tbBuffItem or next(self.tbBuffItem) == nil then
    return
  end
  local goBuff = self.tbBuffItem[nIndex]
  table.remove(self.tbBuffItem, nIndex)
  if goBuff:IsNull() == false then
    local ani = goBuff.transform:Find("btnOpenInfo/AnimRoot"):GetComponent("Animator")
    ani:Play("PenguinCardBuff_out", 0, 0)
    self:AddTimer(1, 0.4, function()
      destroy(goBuff)
    end, true, true, true)
  end
end

function PenguinCardQuestSelectCtrl:OnEvent_ChangeScore(nBefore)
  if self._panel.mapLevel.nGameState ~= PenguinCardUtils.GameState.Quest then
    return
  end
  if nBefore < self._panel.mapLevel.nScore and self._panel.mapLevel.nGameState == PenguinCardUtils.GameState.Quest then
    WwiseManger:PostEvent("Mode_Card_coin")
  end
  local callback = dotween_callback_handler(self, function()
    if nBefore < self._panel.mapLevel.nScore and self._panel.mapLevel.nGameState == PenguinCardUtils.GameState.Quest then
      WwiseManger:PostEvent("Mode_Card_coin_stop")
    end
  end)
  DOTween.To(function()
    return nBefore
  end, function(v)
    local nScore = math.floor(v)
    NovaAPI.SetTMPText(self._mapNode.txtScore, self:ThousandsNumber(nScore))
  end, self._panel.mapLevel.nScore, 0.5):OnComplete(callback)
end

function PenguinCardQuestSelectCtrl:OnEvent_ChangeHp(nChange)
end

function PenguinCardQuestSelectCtrl:OnEvent_BlockFatalDamage()
  self.bBlockFatalDamage = true
end

return PenguinCardQuestSelectCtrl
