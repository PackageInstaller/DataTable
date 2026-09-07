local EducateBaseUI = class("EducateBaseUI", import("view.base.BaseUI"))

EducateBaseUI.EDUCATE_GO_SCENE = "EDUCATE_GO_SCENE"
EducateBaseUI.EDUCATE_CHANGE_SCENE = "EDUCATE_CHANGE_SCENE"
EducateBaseUI.EDUCATE_GO_SUBLAYER = "EDUCATE_GO_SUBLAYER"
EducateBaseUI.EDUCATE_ON_AWARD = "EDUCATE_ON_AWARD"
EducateBaseUI.EDUCATE_ON_ITEM = "EDUCATE_ON_ITEM"
EducateBaseUI.EDUCATE_ON_MSG_TIP = "EDUCATE_ON_MSG_TIP"
EducateBaseUI.EDUCATE_ON_UNLOCK_TIP = "EDUCATE_ON_UNLOCK_TIP"

function EducateBaseUI:getGroupName()
	return "EducateBaseUI"
end

return EducateBaseUI
