local AssistantCtrl = class("AssistantCtrl", BaseCtrl)
AssistantCtrl._mapNodeConfig = {
  imgBg = {},
  txtAssistant = {sComponentName = "TMP_Text"},
  imgLight = {}
}
AssistantCtrl._mapEventConfig = {}
AssistantCtrl._mapRedDotConfig = {}

function AssistantCtrl:Awake()
end

function AssistantCtrl:OnEnable()
end

function AssistantCtrl:OnDisable()
end

function AssistantCtrl:OnDestroy()
end

function AssistantCtrl:OnRelease()
end

return AssistantCtrl
