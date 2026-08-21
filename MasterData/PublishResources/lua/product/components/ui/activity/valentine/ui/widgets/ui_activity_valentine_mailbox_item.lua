_class("UIActivityValentineMailboxItem", UICustomWidget)
UIActivityValentineMailboxItem = UIActivityValentineMailboxItem

function UIActivityValentineMailboxItem:Constructor()
  self._mailInfo = nil
  self._data = nil
  self._openTime = 1000
  self._spineAnimState = nil
end

function UIActivityValentineMailboxItem:OnShow(uiParams)
  self:_GetComponents()
end

function UIActivityValentineMailboxItem:_GetComponents()
  self._letterTxt = self:GetUIComponent("UILocalizationText", "letterTxt")
  self._petHeadImg = self:GetUIComponent("RawImageLoader", "petHeadImg")
  self._spine = self:GetUIComponent("SpineLoader", "spine")
  self._anim = self:GetUIComponent("Animation", "anim")
  self._spine:LoadSpine("n27_g_xin_spine_idle")
  self._spineAnimState = self._spine.CurrentSkeleton.AnimationState
end

function UIActivityValentineMailboxItem:SetData(mailInfo, data)
  local questId = Cfg.cfg_Component_mini_mail[mailInfo.id].QuestId
  self._mailInfo = mailInfo
  self._data = data
  self._letterCfg = Cfg.cfg_valentine_letter({QuestId = questId})[1]
  self._state = mailInfo.state
  local aniName = self._letterCfg.UnReadSpine
  if self._state == MiniMailStateType.MMST_Unread then
    aniName = aniName .. "_1"
  elseif self._state == MiniMailStateType.MMST_Read then
    aniName = aniName .. "_3"
  end
  self._spineAnimState:SetAnimation(0, aniName, false)
  local name = StringTable.Get(self._letterCfg.Name)
  self._letterTxt:SetText(StringTable.Get("str_n27_valentine_y_mailbox_1", name))
  self._petHeadImg:LoadImage(self._letterCfg.Head)
end

function UIActivityValentineMailboxItem:SetLetterOpen()
  if self._state == MiniMailStateType.MMST_Unread then
    self:StartTask(self._SetLetterOpen, self)
  end
end

function UIActivityValentineMailboxItem:_SetLetterOpen(TT)
  local mailComponent = self._data:GetMailComponent()
  local res = AsyncRequestRes:New()
  local code = mailComponent:HandleReadMiniMail(TT, res, self._mailInfo.id)
  if res:GetSucc() then
    local mainController = GameGlobal.UIStateManager():GetController("UIActivityValentineMainController")
    local endController = GameGlobal.UIStateManager():GetController("UIActivityValentineEndController")
    if mainController then
      mainController:CheckMailRed()
    elseif endController then
      endController:CheckMailRed()
    end
  else
    Log.fatal("设置信件已读失败：", code)
  end
end

function UIActivityValentineMailboxItem:LetterBtnOnClick()
  if self._data:CheckMailIsOver() then
    ToastManager.ShowToast(StringTable.Get("str_n27_valentine_y_offline"))
    self:SwitchState(UIStateType.UIMain)
    return
  end
  local isUnRead = self._state == MiniMailStateType.MMST_Unread
  self:SetLetterOpen()
  GameGlobal.TaskManager():StartTask(self._OpenLetter, self, isUnRead)
end

function UIActivityValentineMailboxItem:_OpenLetter(TT, isUnRead)
  if isUnRead then
    local aniName = self._letterCfg.UnReadSpine .. "_2"
    self._spineAnimState:SetAnimation(0, aniName, false)
    self._anim:Play("uieff_UIActivityValentineMailboxItem_eff")
    YIELD(TT, self._openTime)
  else
    self._anim:Play("uieff_UIActivityValentineMailboxItem_eff")
    YIELD(TT, 200)
  end
  self._state = self._mailInfo.state
  self:ShowDialog("UIActivityValentineLetterController", self._letterCfg)
end
