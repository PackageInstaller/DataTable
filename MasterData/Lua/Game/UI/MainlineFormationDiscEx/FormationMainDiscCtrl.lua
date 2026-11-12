local FormationMainDiscCtrl = class("FormationMainDiscCtrl", BaseCtrl)
FormationMainDiscCtrl._mapNodeConfig = {
  rtDisc = {
    nCount = 3,
    sCtrlName = "Game.UI.MainlineFormationDiscEx.FormationDisc_MainDiscCtrl"
  },
  imgMainTitleActive = {},
  TMPMainTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "DiscFormation_MainTitle"
  },
  rtDiscBtn = {
    nCount = 3,
    sNodeName = "rtDisc",
    sComponentName = "UIButton",
    callback = "OnBtnClick_Disc"
  },
  auDiscBtnAudio = {
    nCount = 3,
    sNodeName = "rtDisc",
    sComponentName = "AkAudioUI"
  }
}
FormationMainDiscCtrl._mapEventConfig = {}
FormationMainDiscCtrl._mapRedDotConfig = {}

function FormationMainDiscCtrl:Awake()
  self.animator = self.gameObject:GetComponent("Animator")
end

function FormationMainDiscCtrl:FadeIn()
end

function FormationMainDiscCtrl:FadeOut()
end

function FormationMainDiscCtrl:OnEnable()
end

function FormationMainDiscCtrl:OnDisable()
end

function FormationMainDiscCtrl:OnDestroy()
end

function FormationMainDiscCtrl:OnRelease()
end

function FormationMainDiscCtrl:Refresh(tbMainDisc, mapNoteNeed)
  for i = 1, 3 do
    self._mapNode.rtDisc[i]:SetDisc(PlayerData.Disc:GetDiscById(tbMainDisc[i]), mapNoteNeed)
  end
end

function FormationMainDiscCtrl:SetCurSelect(bCur)
  self._mapNode.imgMainTitleActive:SetActive(bCur)
end

function FormationMainDiscCtrl:SetTitle(bEnable)
  self._mapNode.imgMainTitleActive:SetActive(bEnable)
end

function FormationMainDiscCtrl:OnBtnClick_Disc(btn, nIdx)
  EventManager.Hit("DiscFormation_OpenList", 1)
end

function FormationMainDiscCtrl:PlayAnim(bIn)
  if bIn then
    self.animator:Play("rtMainDisc_in")
  else
    self.animator:Play("rtMainDisc_out")
  end
end

function FormationMainDiscCtrl:SetDiscBtnEnable(bEnable)
  self._mapNode.auDiscBtnAudio[1].enabled = bEnable
  self._mapNode.auDiscBtnAudio[2].enabled = bEnable
  self._mapNode.auDiscBtnAudio[3].enabled = bEnable
  self._mapNode.rtDisc[1]:SetDownButton(not bEnable)
  self._mapNode.rtDisc[2]:SetDownButton(not bEnable)
  self._mapNode.rtDisc[3]:SetDownButton(not bEnable)
end

return FormationMainDiscCtrl
