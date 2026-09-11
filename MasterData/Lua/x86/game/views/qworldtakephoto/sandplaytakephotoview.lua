local SandPlayTakePhotoView = class("SandPlayTakePhotoView", ReduxView)
local var_0_1 = "UI_QuanZhou_CollectBookMapPopUI_"
local var_0_2 = {
	extraScenic = 1,
	mainQuest = 2
}
local var_0_3 = 5

function SandPlayTakePhotoView:UIName()
	return "Widget/System/SandPlay_QuanZhou/QuanZhou_CollectBook/QuanZhou_CollectBookMapPopUI"
end

function SandPlayTakePhotoView:UIParent()
	return manager.ui.uiPop.transform
end

function SandPlayTakePhotoView:Init()
	self:InitUI()
	self:AddUIListener()
end

function SandPlayTakePhotoView:InitUI()
	self:BindCfgUI()

	self.stateController_ = self.mainController_:GetController("state")
	self.photoIDList_ = {
		[var_0_2.extraScenic] = {},
		[var_0_2.mainQuest] = {}
	}
	self.photoControllerList_ = {}
	self.photoImgList_ = {
		[var_0_2.extraScenic] = {},
		[var_0_2.mainQuest] = {}
	}

	for iter_4_0, iter_4_1 in ipairs(QuanzhouPhotoCfg.all) do
		if self.photoIDList_[QuanzhouPhotoCfg[iter_4_1].type] then
			table.insert(self.photoIDList_[QuanzhouPhotoCfg[iter_4_1].type], iter_4_1)
		end
	end

	for iter_4_2 = 1, var_0_3 do
		self.photoControllerList_[iter_4_2] = self.mainController_:GetController("phphoto" .. iter_4_2)
		self.photoImgList_[var_0_2.extraScenic][iter_4_2] = self["nd" .. iter_4_2 .. "Img_"]
		self.photoImgList_[var_0_2.mainQuest][iter_4_2] = self["ph" .. iter_4_2 .. "Img_"]
	end
end

function SandPlayTakePhotoView:AddUIListener()
	self:AddBtnListener(self.fullScreenBtn_, nil, function()
		if self.isTaking_ then
			return
		end

		SetActive(self.textBackGo_, false)

		if not self.isAni_ then
			self.isAni_ = true

			self:PlayAni(self.photoID_)
		end
	end)
end

function SandPlayTakePhotoView:OnEnter()
	self.lvAnimator_:Play("default")
	self.mainAnimator_:Play("UI_QuanZhou_CollectBookMapPopUI_empty")

	self.startLv_ = QWorldBookletTools.GetNdLevelInfo()
	self.thingID_ = self.params_.configID
	self.photoID_ = QuanzhouPhotoCfg.get_id_list_by_thing_id[self.thingID_][1]
	self.photoCfg_ = QuanzhouPhotoCfg[self.photoID_]
	self.photoType_ = self.photoCfg_.type
	self.photoIndex_ = -1

	SetActive(self.textBackGo_, true)

	for iter_7_0, iter_7_1 in ipairs(self.photoIDList_[self.photoType_]) do
		if iter_7_1 == self.photoID_ then
			self.photoIndex_ = iter_7_0
		end
	end

	self.stateController_:SetSelectedState("photo")

	self.isTaking_ = true
	self.isAni_ = false
	self.canClose_ = false

	manager.windowBar:HideBar()
	self:RefreshUI()
	self:DoTakingPhoto()
end

function SandPlayTakePhotoView:DoTakingPhoto()
	self.isTaking_ = false

	self.stateController_:SetSelectedState("ani")

	if self.photoID_ == 2005 then
		self.mainAnimator_:Play("UI_QuanZhou_CollectBookMapPopUI_emty_photo5")
	else
		self.mainAnimator_:Play("UI_QuanZhou_CollectBookMapPopUI_emty")
	end

	QWorldData:AddHint(323641001)
end

function SandPlayTakePhotoView:RefreshUI()
	self.photoImg_.sprite = pureGetSpriteWithoutAtlas(self.photoCfg_.pic)
	self.photoText_.text = self.photoCfg_.desc
	self.lvText_.text = tostring(self.startLv_)
	self.lvShadowText_.text = tostring(self.startLv_)
	self.lvAfterText_.text = tostring(self.startLv_ + 1)
	self.lvShadowAfterText_.text = tostring(self.startLv_ + 1)

	for iter_9_0, iter_9_1 in pairs(var_0_2) do
		for iter_9_2 = 1, var_0_3 do
			if QWorldBookletTools.CheckPhotoUnlock(self.photoIDList_[iter_9_1][iter_9_2]) then
				if iter_9_1 == var_0_2.mainQuest then
					self.photoControllerList_[iter_9_2]:SetSelectedState("unlock")
				end

				self.photoImgList_[iter_9_1][iter_9_2].sprite = pureGetSpriteWithoutAtlas(QuanzhouPhotoCfg[self.photoIDList_[iter_9_1][iter_9_2]].pic)
			elseif iter_9_1 == var_0_2.mainQuest then
				self.photoControllerList_[iter_9_2]:SetSelectedState("lock")
			end
		end
	end
end

function SandPlayTakePhotoView:PlayAni(arg_10_1)
	self.mainAnimator_:Play(var_0_1 .. tostring(arg_10_1))

	self.aniTimer_ = FrameTimer.New(function()
		if self.mainAnimator_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 0.8 then
			self:StopPhotoTimer()

			self.canClose_ = true
			self.photoImgList_[self.photoType_][self.photoIndex_].sprite = pureGetSpriteWithoutAtlas(self.photoCfg_.pic)

			if self.photoType_ == var_0_2.mainQuest then
				self.photoControllerList_[self.photoIndex_]:SetSelectedState("unlock")
			end

			self:PlayLvUpAni()
		end
	end, 1, -1)

	self.aniTimer_:Start()
end

function SandPlayTakePhotoView:PlayLvUpAni()
	self.lvAnimator_:Play("UI_lv1_cx")

	self.lvTimer_ = FrameTimer.New(function()
		local var_13_0 = self.lvAnimator_:GetCurrentAnimatorStateInfo(0)

		if var_13_0:IsName("UI_lv1_cx") and var_13_0.normalizedTime >= 1 then
			self:StopLvTimer()
			self.lvAnimator_:Play("default")
			self.mainAnimator_:Play("UI_QuanZhou_CollectBookMapPopUI_empty")

			self.bookCanvas_.alpha = 0

			TimeTools.StartAfterSeconds(0.01, function()
				JumpTools.Back()
				manager.notify:Invoke(QWORLD_TAKE_PHOTO)
			end, {})
		end
	end, 1, -1)

	self.lvTimer_:Start()
end

function SandPlayTakePhotoView:StopAllTimer()
	self:StopPhotoTimer()
	self:StopLvTimer()
end

function SandPlayTakePhotoView:StopPhotoTimer()
	if self.aniTimer_ then
		self.aniTimer_:Stop()

		self.aniTimer_ = nil
	end
end

function SandPlayTakePhotoView:StopLvTimer()
	if self.lvTimer_ then
		self.lvTimer_:Stop()

		self.lvTimer_ = nil
	end
end

function SandPlayTakePhotoView:OnExit()
	self:StopAllTimer()
	manager.windowBar:HideBar()
end

return SandPlayTakePhotoView
