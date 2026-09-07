local IslandStoryRecordPanel = class("IslandStoryRecordPanel", import("Mgr.Story.NewStoryRecordPanel"))

function IslandStoryRecordPanel:Ctor(arg_1_1)
	self.view = arg_1_1

	IslandStoryRecordPanel.super.Ctor(self)

	return
end

function IslandStoryRecordPanel:GetUIName()
	return "IslandStoryRecordUI"
end

function IslandStoryRecordPanel:GetParent()
	return self.view._tf
end

function IslandStoryRecordPanel:UpdateIcon(arg_4_1, arg_4_2)
	GetImageSpriteFromAtlasAsync("island/IslandShipIcon/" .. arg_4_1.icon, "", arg_4_2:Find("Image"))

	return
end

function IslandStoryRecordPanel:BlurPanel()
	return
end

function IslandStoryRecordPanel:UnOverlayPanel()
	return
end

return IslandStoryRecordPanel
