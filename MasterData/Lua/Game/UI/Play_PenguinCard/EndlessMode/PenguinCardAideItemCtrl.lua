local PenguinCardAideItemCtrl = class("PenguinCardAideItemCtrl", BaseCtrl)
local WwiseManger = CS.WwiseAudioManager.Instance
local _, NotMaxLevel = ColorUtility.TryParseHtmlString("#FFF7EA")
local _, MaxLevel = ColorUtility.TryParseHtmlString("#ffe075")
PenguinCardAideItemCtrl._mapNodeConfig = {
  AnimRoot = {sComponentName = "Animator"},
  imgIcon = {sComponentName = "Image"},
  txtLevel = {sComponentName = "TMP_Text"},
  txtName = {sComponentName = "TMP_Text"},
  btnOpenInfo = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_OpenInfo"
  }
}
PenguinCardAideItemCtrl._mapEventConfig = {}

function PenguinCardAideItemCtrl:Refresh(mapAide, nSelectIndex)
  self.nSelectIndex = nSelectIndex
  self:SetPngSprite(self._mapNode.imgIcon, mapAide.sIcon .. AllEnum.CharHeadIconSurfix.Q)
  NovaAPI.SetTMPText(self._mapNode.txtName, mapAide.sName)
  if mapAide.nLevel == mapAide.nMaxLevel then
    NovaAPI.SetTMPColor(self._mapNode.txtLevel, MaxLevel)
    NovaAPI.SetTMPText(self._mapNode.txtLevel, orderedFormat(ConfigTable.GetUIText("PenguinCard_AideLevel"), mapAide.nLevel))
  else
    NovaAPI.SetTMPColor(self._mapNode.txtLevel, NotMaxLevel)
    NovaAPI.SetTMPText(self._mapNode.txtLevel, orderedFormat(ConfigTable.GetUIText("PenguinCard_AideLevel"), mapAide.nLevel))
  end
end

function PenguinCardAideItemCtrl:PlayHideAni()
  self._mapNode.AnimRoot:Play("PenguinCardAide_out", 0, 0)
  local nAnimTime = NovaAPI.GetAnimClipLength(self._mapNode.AnimRoot, {
    "PenguinCardAide_out"
  })
  return nAnimTime
end

function PenguinCardAideItemCtrl:Awake()
end

function PenguinCardAideItemCtrl:OnEnable()
end

function PenguinCardAideItemCtrl:OnDisable()
end

function PenguinCardAideItemCtrl:OnBtnClick_OpenInfo()
  if self.nSelectIndex and self._panel.mapLevel.bSelectedAide then
    return
  end
  local mapAide = self._panel.mapLevel.tbSelectableAide[self.nSelectIndex]
  EventManager.Hit("PenguinCard_OpenAideInfo", mapAide, self.nSelectIndex)
end

return PenguinCardAideItemCtrl
