local MainlineChapterSelectCtrl = class("MainlineChapterSelectCtrl", BaseCtrl)
MainlineChapterSelectCtrl._mapNodeConfig = {
  Page1 = {
    sCtrlName = "Game.UI.MainlineEx.MainlineChapterPage1"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Cancle"
  },
  btnConfirm1 = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Confirm"
  },
  txtBtnConfirm1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainLine_Select_Btn_Confirm"
  },
  btnCancel = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Cancle"
  },
  txtBtnCancel = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainLine_Select_Btn_Cancel"
  },
  txtTitle = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "MainLine_Select_Title"
  }
}
MainlineChapterSelectCtrl._mapEventConfig = {
  SelectChapter = "OnEvent_SelectChapter"
}

function MainlineChapterSelectCtrl:Awake()
end

function MainlineChapterSelectCtrl:FadeOut(callback)
  if type(callback) == "function" then
    callback()
  end
end

function MainlineChapterSelectCtrl:OnEnable()
end

function MainlineChapterSelectCtrl:OnDisable()
end

function MainlineChapterSelectCtrl:OnDestroy()
end

function MainlineChapterSelectCtrl:OnRelease()
end

function MainlineChapterSelectCtrl:OpenPanel(nCurChapter)
  self.tbChapter, self.nCurChapterIdx = PlayerData.Mainline:GetAllMainlineChapter(nCurChapter)
  self.gameObject:SetActive(true)
  self._mapNode.Page1:Init(self.tbChapter, nCurChapter)
  self.nCurChapter = nCurChapter
end

function MainlineChapterSelectCtrl:OnEvent_SelectChapter(nChapter)
  self.nCurChapter = nChapter
end

function MainlineChapterSelectCtrl:OnBtnClick_Confirm(btn)
  EventManager.Hit("ConfirmChapter", self.nCurChapter)
  self.gameObject:SetActive(false)
  self.tbChapter = nil
  self.nCurChapterIdx = 0
end

function MainlineChapterSelectCtrl:OnBtnClick_Cancle(btn)
  EventManager.Hit("ConfirmChapter", 0)
  self.gameObject:SetActive(false)
  self.tbChapter = nil
  self.nCurChapterIdx = 0
end

return MainlineChapterSelectCtrl
