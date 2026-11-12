local VampireLevelSelect_TalentPointHintCtrl = class("VampireLevelSelect_TalentPointHintCtrl", BaseCtrl)
VampireLevelSelect_TalentPointHintCtrl._mapNodeConfig = {
  rtProperty = {sComponentName = "Animator"},
  TMPFateCardCount = {sComponentName = "TMP_Text"},
  TMPTalentPointCount = {sComponentName = "TMP_Text"},
  TMPFateCardHintTitle1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "VampireTalent_FateCardTrans_NewCardTitle"
  },
  TMPFateCardHintTitle2 = {
    sComponentName = "TMP_Text",
    sLanguageId = "VampireTalent_FateCardTrans_TalentTitle"
  },
  TMPPointMaxHint = {
    sComponentName = "TMP_Text",
    sLanguageId = "VampireTalent_FateCardTrans_TalentPointMaxCount"
  },
  btnHIntClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  SuccessBar = {
    sNodeName = "imgBg",
    sCtrlName = "Game.UI.SuccessBarEx.SuccessBarCtrl"
  }
}
VampireLevelSelect_TalentPointHintCtrl._mapEventConfig = {}
VampireLevelSelect_TalentPointHintCtrl._mapRedDotConfig = {}

function VampireLevelSelect_TalentPointHintCtrl:Awake()
end

function VampireLevelSelect_TalentPointHintCtrl:FadeIn()
end

function VampireLevelSelect_TalentPointHintCtrl:FadeOut()
end

function VampireLevelSelect_TalentPointHintCtrl:OnEnable()
end

function VampireLevelSelect_TalentPointHintCtrl:OnDisable()
end

function VampireLevelSelect_TalentPointHintCtrl:OnDestroy()
end

function VampireLevelSelect_TalentPointHintCtrl:OnRelease()
end

function VampireLevelSelect_TalentPointHintCtrl:OpenHint(nFateCardCount, nPoint)
  local nFateCardPoint = ConfigTable.GetConfigNumber("FateCardBookToVampireTalentPoint")
  if nFateCardPoint == nil then
    nFateCardPoint = 1
  end
  local nTotalPoint = nFateCardCount * nFateCardPoint
  self._mapNode.TMPPointMaxHint.gameObject:SetActive(nPoint < nTotalPoint)
  local nFateCardCount = math.floor(nPoint / nFateCardPoint)
  NovaAPI.SetTMPText(self._mapNode.TMPFateCardCount, nFateCardCount)
  NovaAPI.SetTMPText(self._mapNode.TMPTalentPointCount, nPoint)
  self.gameObject:SetActive(true)
  self._mapNode.SuccessBar:PlayAni(AllEnum.SuccessBar.Purple, {
    self._mapNode.rtProperty
  })
end

function VampireLevelSelect_TalentPointHintCtrl:OnBtnClick_Close()
  self.gameObject:SetActive(false)
end

return VampireLevelSelect_TalentPointHintCtrl
