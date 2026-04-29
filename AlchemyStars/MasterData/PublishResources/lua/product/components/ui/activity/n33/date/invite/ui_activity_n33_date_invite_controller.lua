_class("UIActivityN33DateInviteController", UIController)
UIActivityN33DateInviteController = UIActivityN33DateInviteController

function UIActivityN33DateInviteController:LoadDataOnEnter(TT, res, uiParams)
end

function UIActivityN33DateInviteController:OnShow(uiParams)
  self._cfg = uiParams[1]
  self._isStart = uiParams[2]
  self._callback = uiParams[3]
  self:_GetComponent()
  self:_Init()
end

function UIActivityN33DateInviteController:_GetComponent()
  self._petImg = self:GetUIComponent("RawImageLoader", "petImg")
  self._talkInfo = self:GetUIComponent("UILocalizationText", "talkInfo")
  self._inviteTxt = self:GetUIComponent("UILocalizationText", "inviteTxt")
  self._inviteTitle = self:GetUIComponent("UILocalizationText", "inviteTitle")
  self._inviteTxt1 = self:GetUIComponent("UILocalizationText", "inviteTxt1")
  self._inviteTitle1 = self:GetUIComponent("UILocalizationText", "inviteTitle1")
  self._anim = self:GetUIComponent("Animation", "anim")
  self._tiptxt2Obj = self:GetGameObject("tiptxt2")
end

function UIActivityN33DateInviteController:_Init()
  self._petImg:LoadImage(self._cfg.PetImg)
  self._inviteTitle:SetText(StringTable.Get(self._cfg.EventTitle))
  self._inviteTitle1:SetText(StringTable.Get(self._cfg.EventTitle))
  if self._isStart then
    self._talkInfo:SetText(StringTable.Get(self._cfg.StartEventTxt))
    self._inviteTxt:SetText(StringTable.Get("str_n33_date_invite_title1"))
    self._inviteTxt1:SetText(StringTable.Get("str_n33_date_invite_title1"))
    self._tiptxt2Obj:SetActive(false)
  else
    self._talkInfo:SetText(StringTable.Get(self._cfg.EndEventTxt))
    self._inviteTxt:SetText(StringTable.Get("str_n33_date_invite_title2"))
    self._inviteTxt1:SetText(StringTable.Get("str_n33_date_invite_title2"))
    self._tiptxt2Obj:SetActive(true)
  end
end

function UIActivityN33DateInviteController:SetControllerEnd()
  self._isStart = false
  self:_Init()
  self:StartTask(function(TT)
    self:Lock("uieffanim_UIActivityN33DateInviteController_in")
    self._anim:Play("uieffanim_UIActivityN33DateInviteController_in")
    YIELD(TT, 734)
    self:UnLock("uieffanim_UIActivityN33DateInviteController_in")
  end, self)
end

function UIActivityN33DateInviteController:BgBtnOnClick()
  if self._isStart then
    self:ShowDialog("UIStoryController", self._cfg.StoryID, function()
      self:SetControllerEnd()
    end)
  else
    self:CloseDialog()
    if self._callback then
      self._callback()
    end
  end
end

function UIActivityN33DateInviteController:_CloseAnim(TT)
  self._anim:Play("uieffanim_UIActivityN33DateInviteController_out")
  self:Lock("uieffanim_UIActivityN33DateInviteController_out")
  YIELD(TT, 334)
  self:UnLock("uieffanim_UIActivityN33DateInviteController_out")
  self:CloseDialog()
end
