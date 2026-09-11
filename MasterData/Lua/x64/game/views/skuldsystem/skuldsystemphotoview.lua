local SkuldSystemPhotoView = class("SkuldSystemPhotoView", ReduxView)

function SkuldSystemPhotoView:UIName()
	return "Widget/System/Activity_Skuld/Activity_Skuld_PhotoUI"
end

function SkuldSystemPhotoView:UIParent()
	return manager.ui.uiMain.transform
end

function SkuldSystemPhotoView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function SkuldSystemPhotoView:InitUI()
	self:BindCfgUI()

	for iter_4_0 = 1, 4 do
		self["photoItem" .. iter_4_0 .. "_"] = SkuldSystemPhotoViewItem.New(self["photoGo" .. iter_4_0 .. "_"], iter_4_0)
	end
end

function SkuldSystemPhotoView:AddUIListeners()
	return
end

function SkuldSystemPhotoView:OnEnter()
	for iter_6_0 = 1, 4 do
		self["photoItem" .. iter_6_0 .. "_"]:RefreshUI()
	end
end

function SkuldSystemPhotoView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function SkuldSystemPhotoView:OnExit()
	manager.windowBar:HideBar()

	for iter_8_0 = 1, 4 do
		self["photoItem" .. iter_8_0 .. "_"]:OnExit()
	end
end

function SkuldSystemPhotoView:Dispose()
	for iter_9_0 = 1, 4 do
		self["photoItem" .. iter_9_0 .. "_"]:Dispose()
	end

	self.super.Dispose(self)
end

return SkuldSystemPhotoView
