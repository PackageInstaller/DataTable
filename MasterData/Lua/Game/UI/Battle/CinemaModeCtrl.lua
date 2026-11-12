local CinemaModeCtrl = class("CinemaModeCtrl", BaseCtrl)
CinemaModeCtrl._mapNodeConfig = {
  Cinema = {sNodeName = "Cinema"},
  Letterbox_Top = {
    sNodeName = "Letterbox_Top",
    sComponentName = "RectTransform"
  },
  Letterbox_Bottom = {
    sNodeName = "Letterbox_Bottom",
    sComponentName = "RectTransform"
  }
}
CinemaModeCtrl._mapEventConfig = {}

function CinemaModeCtrl:Awake()
  self.cinemaModeUpPosOffset = Vector2(0, 130)
  self.cinemaModeDownPosOffset = Vector2(0, -130)
  self.cinemaModeBoardAnimTime = 1
end

function CinemaModeCtrl:OnEnable()
  self._mapNode.Cinema:SetActive(false)
end

function CinemaModeCtrl:OnDisable()
end

function CinemaModeCtrl:OnDestroy()
end

function CinemaModeCtrl:OpenUI()
  self._mapNode.Cinema:SetActive(true)
  self._mapNode.Letterbox_Top.anchoredPosition = self.cinemaModeUpPosOffset
  self._mapNode.Letterbox_Bottom.anchoredPosition = self.cinemaModeDownPosOffset
  self._mapNode.Letterbox_Top:DOAnchorPos(Vector2.zero, self.cinemaModeBoardAnimTime):SetUpdate(true)
  self._mapNode.Letterbox_Bottom:DOAnchorPos(Vector2.zero, self.cinemaModeBoardAnimTime):SetUpdate(true)
end

function CinemaModeCtrl:CloseUI()
  self._mapNode.Letterbox_Top.anchoredPosition = Vector2.zero
  self._mapNode.Letterbox_Bottom.anchoredPosition = Vector2.zero
  self._mapNode.Letterbox_Top:DOAnchorPos(self.cinemaModeUpPosOffset, self.cinemaModeBoardAnimTime):SetUpdate(true)
  self._mapNode.Letterbox_Bottom:DOAnchorPos(self.cinemaModeDownPosOffset, self.cinemaModeBoardAnimTime):OnComplete(function()
    self._mapNode.Cinema:SetActive(false)
  end):SetUpdate(true)
end

return CinemaModeCtrl
