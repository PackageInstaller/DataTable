local NewHeroWallPaperItemView = class("NewHeroWallPaperItemView", ReduxView)

function NewHeroWallPaperItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function NewHeroWallPaperItemView:Init()
	self:InitUI()
end

function NewHeroWallPaperItemView:InitUI()
	self:BindCfgUI()

	self.roleImg_.immediate = true
	self.roleController_ = ControllerUtil.GetController(self.transform_, "role")

	self:AddUIListener()
end

function NewHeroWallPaperItemView:OnTop()
	return
end

function NewHeroWallPaperItemView:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if self.clickCallBack_ then
			SDKTools.SendMessageToSDK("chain_story_picture_change", {
				chain_story_picture_id = self.roleName_.text,
				record_id = self.data_.id
			})
			self.clickCallBack_(self.id_, self.type_)
		end
	end)
	self:AddBtnListener(self.maskBtn_, nil, function()
		ShowTips(self.lockTips_)
	end)
end

function NewHeroWallPaperItemView:SetClickFunc(arg_8_1)
	self.clickCallBack_ = arg_8_1
end

function NewHeroWallPaperItemView:SetData(arg_9_1, arg_9_2, arg_9_3)
	self.data_ = arg_9_1
	self.index_ = arg_9_2
	self.id_ = arg_9_1.id
	self.type_ = arg_9_1.type
	self.archiveID_ = arg_9_3

	self:RefreshUI()
end

function NewHeroWallPaperItemView:RefreshUI()
	local var_10_0 = ArchiveData:GetSelectPicture(self.archiveID_)

	if var_10_0.id == self.id_ then
		self.roleController_:SetSelectedState("yes")
	elseif var_10_0.id ~= self.id_ then
		self.roleController_:SetSelectedState("no")
	end

	local var_10_1 = ArchiveTools.CheckWallPaperIsUnlock(self.data_)

	self.lockPicGo_:SetActive(false)

	if not var_10_1 then
		self.roleController_:SetSelectedState("lock")

		if self.type_ == 3 then
			self.lockPicGo_:SetActive(true)
		else
			self.lockPicGo_:SetActive(false)
		end
	end

	if self.type_ == 1 then
		self.roleImg_.spriteSync = "TextureConfig/Character/Icon/" .. self.id_
		self.lockText_.text = GetTips("HERO_HEART_CHAIN_PLOT_COVER_UNLOCK_HERO")
		self.roleName_.text = HeroCfg[self.data_.id].name
		self.lockTips_ = string.format(GetTips("HERO_HEART_CHAIN_PLOT_COVER_UNLOCK_HERO_NAME"), GetI18NText(HeroCfg[self.data_.id].name))
	elseif self.type_ == 2 then
		self.roleImg_.spriteSync = "TextureConfig/Character/Icon/" .. self.id_
		self.lockText_.text = GetTips("HERO_HEART_CHAIN_PLOT_COVER_UNLOCK_SKIN")
		self.roleName_.text = SkinCfg[self.data_.id].name
		self.lockTips_ = string.format(GetTips("HERO_HEART_CHAIN_PLOT_COVER_UNLOCK_SKIN_NAME"), GetI18NText(SkinCfg[self.data_.id].name))
	elseif self.type_ == 3 then
		self.roleImg_.spriteSync = "TextureConfig/IllustratedHandbook/Portrait/" .. CollectPictureCfg[self.id_].picture
		self.lockText_.text = GetTips("HERO_HEART_CHAIN_PLOT_COVER_UNLOCK_PICTURE")
		self.roleName_.text = CollectPictureCfg[self.data_.id].name
		self.lockTips_ = string.format(GetTips("HERO_HEART_CHAIN_PLOT_COVER_UNLOCK_PICTURE_NAME"), GetI18NText(CollectPictureCfg[self.data_.id].name))
	end
end

function NewHeroWallPaperItemView:OnExit()
	return
end

function NewHeroWallPaperItemView:Dispose()
	NewHeroWallPaperItemView.super.Dispose(self)
end

return NewHeroWallPaperItemView
