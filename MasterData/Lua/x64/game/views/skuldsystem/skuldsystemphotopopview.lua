local SkuldSystemPhotoPopView = class("SkuldSystemPhotoPopView", ReduxView)

function SkuldSystemPhotoPopView:UIName()
	return "Widget/System/Activity_Skuld/Activity_Skuld_PhotoPopUI"
end

function SkuldSystemPhotoPopView:UIParent()
	return manager.ui.uiPop.transform
end

function SkuldSystemPhotoPopView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function SkuldSystemPhotoPopView:InitUI()
	self:BindCfgUI()
end

function SkuldSystemPhotoPopView:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		JumpTools.Back()
	end)
end

function SkuldSystemPhotoPopView:OnEnter()
	self.index_ = self.params_.index
	self.image_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_Skuld/Skuld_Photos/" .. GameSetting["skuld_photo" .. self.index_].value[1])
	self.nameText_.text = GetTips(GameSetting["skuld_photo" .. self.index_].value[2])
	self.desText_.text = formatText(GetTips(GameSetting["skuld_photo" .. self.index_].value[3]))
end

function SkuldSystemPhotoPopView:OnExit()
	return
end

function SkuldSystemPhotoPopView:Dispose()
	self.super.Dispose(self)
end

return SkuldSystemPhotoPopView
