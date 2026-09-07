local NewEducateBaseUI = class("NewEducateBaseUI", import("view.base.BaseUI"))

NewEducateBaseUI.GO_SCENE = "NewEducateBaseUI.EDUCATE_GO_SCENE"
NewEducateBaseUI.CHANGE_SCENE = "NewEducateBaseUI.CHANGE_SCENE"
NewEducateBaseUI.GO_SUBLAYER = "NewEducateBaseUI.GO_SUBLAYER"
NewEducateBaseUI.ON_DROP = "NewEducateBaseUI.ON_DROP"
NewEducateBaseUI.ON_ITEM = "NewEducateBaseUI.ON_ITEM"
NewEducateBaseUI.ON_BOX = "NewEducateBaseUI.ON_BOX"
NewEducateBaseUI.ON_SHOP = "NewEducateBaseUI.ON_SHOP"
NewEducateBaseUI.ON_PRIORITY_STATE = "NewEducateBaseUI.ON_PRIORITY_STATE"

function NewEducateBaseUI:getGroupName()
	return "NewEducateBaseUI"
end

return NewEducateBaseUI
