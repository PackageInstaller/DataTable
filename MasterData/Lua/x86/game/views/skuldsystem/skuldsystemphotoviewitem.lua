local SkuldSystemPhotoViewItem = class("SkuldSystemPhotoViewItem", ReduxView)

function SkuldSystemPhotoViewItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.index_ = arg_1_2

	self:Init()
end

function SkuldSystemPhotoViewItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function SkuldSystemPhotoViewItem:InitUI()
	self:BindCfgUI()

	self.controller_ = self.controllerEx_:GetController("lock")
end

function SkuldSystemPhotoViewItem:RefreshUI()
	self.photoImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_Skuld/Skuld_Photos/" .. GameSetting["skuld_photo" .. self.index_].value[1])
	self.nameText_.text = GetTips(GameSetting["skuld_photo" .. self.index_].value[2])

	if SkuldSystemData:GetLevelIDIsClear(GameSetting["skuld_photo" .. self.index_].value[5]) then
		self.controller_:SetSelectedState("false")
	else
		self.controller_:SetSelectedState("true")
	end

	manager.redPoint:bindUIandKey(self.transform_, RedPointConst.SKULD_SYSTEM_PHOTO .. self.index_)
end

function SkuldSystemPhotoViewItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if SkuldSystemData:GetLevelIDIsClear(GameSetting["skuld_photo" .. self.index_].value[5]) then
			SkuldSystemAction.SendMark("PhotoClick" .. self.index_)
			manager.redPoint:setTip(RedPointConst.SKULD_SYSTEM_PHOTO .. self.index_, 0)
			JumpTools.OpenPageByJump("skuldSystemPhotoPopView", {
				index = self.index_
			})
		else
			ShowTips(GameSetting["skuld_photo" .. self.index_].value[4])
		end
	end)
end

function SkuldSystemPhotoViewItem:OnExit()
	manager.redPoint:unbindUIandKey(self.transform_, RedPointConst.SKULD_SYSTEM_PHOTO .. self.index_)
end

function SkuldSystemPhotoViewItem:Dispose()
	SkuldSystemPhotoViewItem.super.Dispose(self)
end

return SkuldSystemPhotoViewItem
