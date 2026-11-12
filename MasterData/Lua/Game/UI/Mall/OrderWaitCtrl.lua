local OrderWaitCtrl = class("OrderWaitCtrl", BaseCtrl)
OrderWaitCtrl._mapNodeConfig = {
  blur = {
    sNodeName = "t_fullscreen_blur_blue"
  },
  aniBlur = {
    sNodeName = "t_fullscreen_blur_blue",
    sComponentName = "Animator"
  },
  txtConnecting = {
    sComponentName = "TMP_Text",
    sLanguageId = "Mall_OrderWait"
  }
}
OrderWaitCtrl._mapEventConfig = {}

function OrderWaitCtrl:Open()
end

function OrderWaitCtrl:Awake()
end

function OrderWaitCtrl:OnEnable()
  self:Open()
end

function OrderWaitCtrl:OnDisable()
end

function OrderWaitCtrl:OnDestroy()
end

return OrderWaitCtrl
