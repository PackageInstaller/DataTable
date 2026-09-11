local QWorldBookletMainView = class("QWorldBookletMainView", ReduxView)
local var_0_1 = {
	extraScenic = 1,
	mainQuest = 2
}
local var_0_2 = 5
local var_0_3 = 2003
local var_0_4 = 2005

function QWorldBookletMainView:UIName()
	return "Widget/System/SandPlay_QuanZhou/QuanZhou_CollectBook/QuanZhou_CollectBookUI"
end

function QWorldBookletMainView:UIParent()
	return manager.ui.uiMain.transform
end

function QWorldBookletMainView:Init()
	self:InitUI()
	self:AddUIListener()
end

function QWorldBookletMainView:InitUI()
	self:BindCfgUI()

	self.curTabIndex_ = 0

	self:SetTabExtraScenicTextAndShadow()
	self:SetTabMainQuestTextAndShadow()
	self:SetBookNameTextAndShadow()

	self.idList_ = QWorldBookletTools.GetNdLevelIDList()
	self.curLv_ = 0
	self.maxLv_ = 0
	self.photoBtn_ = {
		[var_0_1.extraScenic] = {},
		[var_0_1.mainQuest] = {}
	}
	self.photoAnimator_ = {
		[var_0_1.extraScenic] = {},
		[var_0_1.mainQuest] = {}
	}
	self.photoImage_ = {
		[var_0_1.extraScenic] = {},
		[var_0_1.mainQuest] = {}
	}

	for iter_4_0 = 1, var_0_2 do
		self.photoBtn_[var_0_1.extraScenic][iter_4_0] = self["nd" .. iter_4_0 .. "Btn_"]
		self.photoBtn_[var_0_1.mainQuest][iter_4_0] = self["ph" .. iter_4_0 .. "Btn_"]
		self.photoAnimator_[var_0_1.extraScenic][iter_4_0] = self["nd" .. iter_4_0 .. "Ctrl_"]
		self.photoAnimator_[var_0_1.mainQuest][iter_4_0] = self["ph" .. iter_4_0 .. "Ctrl_"]
		self.photoImage_[var_0_1.extraScenic][iter_4_0] = self["nd" .. iter_4_0 .. "Img_"]
		self.photoImage_[var_0_1.mainQuest][iter_4_0] = self["ph" .. iter_4_0 .. "Img_"]
	end

	self.photoIdList_ = {
		[var_0_1.extraScenic] = {},
		[var_0_1.mainQuest] = {}
	}

	for iter_4_1, iter_4_2 in ipairs(QuanzhouPhotoCfg.all) do
		if self.photoIdList_[QuanzhouPhotoCfg[iter_4_2].type] then
			table.insert(self.photoIdList_[QuanzhouPhotoCfg[iter_4_2].type], iter_4_2)
		end
	end

	for iter_4_3 = 1, #self.photoImage_[var_0_1.mainQuest] do
		self.photoImage_[var_0_1.mainQuest][iter_4_3].spriteAsync = QuanzhouPhotoCfg[self.photoIdList_[var_0_1.mainQuest][iter_4_3]].pic
	end

	self.tabController_ = self.mainControllerEx_:GetController("tab")
	self.ndlvController_ = self.mainControllerEx_:GetController("ndlv")
end

function QWorldBookletMainView:AddUIListener()
	self:AddBtnListener(self.extraScenicBtn_, nil, function()
		if self.curTabIndex_ ~= var_0_1.extraScenic then
			self:SwitchTab(var_0_1.extraScenic)
		end
	end)
	self:AddBtnListener(self.mainQuestBtn_, nil, function()
		if self.curTabIndex_ ~= var_0_1.mainQuest then
			self:SwitchTab(var_0_1.mainQuest)
		end
	end)

	for iter_5_0 = 1, var_0_2 do
		self:AddBtnListener(self.photoBtn_[var_0_1.extraScenic][iter_5_0], nil, function()
			JumpTools.OpenPageByJump("qWorldBookletPhotoPop", {
				photoId = self.photoIdList_[var_0_1.extraScenic][iter_5_0]
			})
		end)
		self:AddBtnListener(self.photoBtn_[var_0_1.mainQuest][iter_5_0], nil, function()
			if QWorldBookletTools.CheckPhotoUnlock(self.photoIdList_[var_0_1.mainQuest][iter_5_0]) then
				JumpTools.OpenPageByJump("qWorldBookletPhotoPop", {
					photoId = self.photoIdList_[var_0_1.mainQuest][iter_5_0]
				})
			else
				ShowTips("GOON_STORY_TO_GET")
			end
		end)
	end

	self:AddBtnListener(self.levelRewardBtn_, nil, function()
		JumpTools.OpenPageByJump("/qWorldBookletLevel")
	end)
end

function QWorldBookletMainView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	SetActive(self.extraScenicBtn_.gameObject, QWorldSystemData:IsSystemOpened(var_0_3))

	self.curLv_, self.maxLv_ = QWorldBookletTools.GetNdLevelInfo()

	self:RefreshLevelTitle()
	self:SwitchTab(var_0_1.mainQuest)
	manager.redPoint:bindUIandKey(self.levelRewardBtn_.transform, RedPointConst.QWORLD_BOOKLET_LEVEL_REWARD)
end

function QWorldBookletMainView:OnExit()
	manager.windowBar:HideBar()

	if self.stageAnimTimer_ then
		self.stageAnimTimer_:Stop()

		self.stageAnimTimer_ = nil
	end

	manager.redPoint:unbindUIandKey(self.levelRewardBtn_.transform, RedPointConst.QWORLD_BOOKLET_LEVEL_REWARD)
end

function QWorldBookletMainView:RefreshLevelTitle()
	self:SetLevelTextAndShadow()

	local var_13_0 = 0

	for iter_13_0, iter_13_1 in ipairs(self.idList_) do
		if iter_13_0 > self.curLv_ then
			break
		end

		if not ActivityPointData:IsCompleteID(iter_13_1) then
			var_13_0 = iter_13_1
		end
	end

	if var_13_0 == 0 then
		self.ndlvController_:SetSelectedState("normal")
	else
		self.levelRewardImg_.sprite = ItemTools.getItemSprite(ActivityPointRewardCfg[var_13_0].reward_item_list[1][1])

		self.ndlvController_:SetSelectedState("reward")
	end
end

function QWorldBookletMainView:SwitchTab(arg_14_1)
	self.curTabIndex_ = arg_14_1

	self.tabController_:SetSelectedState(tostring(arg_14_1))

	for iter_14_0 = 1, #self.photoAnimator_[arg_14_1] do
		local var_14_0 = QWorldBookletTools.CheckPhotoUnlock(self.photoIdList_[arg_14_1][iter_14_0])
		local var_14_1 = QuanzhouPhotoCfg[self.photoIdList_[arg_14_1][iter_14_0]]

		if var_14_0 then
			if not getData("QWorldBookletAnimData", "MainViewPhotoUnlock" .. self.photoIdList_[arg_14_1][iter_14_0]) then
				saveData("QWorldBookletAnimData", "MainViewPhotoUnlock" .. self.photoIdList_[arg_14_1][iter_14_0], 1)
				self.photoAnimator_[arg_14_1][iter_14_0]:Play("UI_photo_unlock", 0, 0)
			else
				self.photoAnimator_[arg_14_1][iter_14_0]:Play("UI_photo_unlock_emty_01", 0, 0)
			end
		else
			self.photoAnimator_[arg_14_1][iter_14_0]:Play("UI_photo_unlock_emty", 0, 0)
		end

		if var_14_1 and arg_14_1 == var_0_1.extraScenic then
			if var_14_0 then
				self.photoImage_[arg_14_1][iter_14_0].spriteAsync = var_14_1.pic or var_14_1.pre_pic
			end
		end
	end

	if arg_14_1 == var_0_1.mainQuest then
		self:RefreshProgressBar()
	end
end

local var_0_5 = 90

function QWorldBookletMainView:RefreshProgressBar()
	self.curPhotoStage_ = 0

	if QWorldBookletTools.CheckPhotoUnlock(self.photoIdList_[var_0_1.mainQuest][2]) then
		self.curPhotoStage_ = 1
	end

	if QWorldBookletTools.CheckPhotoUnlock(self.photoIdList_[var_0_1.mainQuest][4]) then
		self.curPhotoStage_ = 2
	end

	if QWorldBookletTools.CheckPhotoUnlock(self.photoIdList_[var_0_1.mainQuest][5]) then
		self.curPhotoStage_ = 3
	end

	local var_15_0 = getData("QWorldBookletAnimData", "MainViewStage") or 0

	self.mainStageAnim_:Play("UI_ndschedule_jieduan0" .. var_15_0, 0, 1)

	if var_15_0 < self.curPhotoStage_ then
		self.animStage_ = var_15_0 + 1
		self.waitingForTick_ = 0
		self.stageAnimTimer_ = FrameTimer.New(function()
			if self.waitingForTick_ < var_0_5 then
				self.waitingForTick_ = self.waitingForTick_ + 1

				return
			elseif self.waitingForTick_ == var_0_5 then
				if self.animStage_ > 0 then
					manager.audio:PlayEffect("minigame_activity_4_0", "minigame_activity_4_0_ui_walk", "")
				end

				self.mainStageAnim_:Play("UI_ndschedule_jieduan0" .. self.animStage_, 0, 0)

				self.waitingForTick_ = self.waitingForTick_ + 1

				return
			end

			if self.mainStageAnim_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
				if self.curPhotoStage_ > self.animStage_ then
					self.animStage_ = self.animStage_ + 1

					if self.animStage_ > 0 then
						manager.audio:PlayEffect("minigame_activity_4_0", "minigame_activity_4_0_ui_walk", "")
					end

					self.mainStageAnim_:Play("UI_ndschedule_jieduan0" .. self.animStage_, 0, 0)
				elseif self.stageAnimTimer_ then
					self.stageAnimTimer_:Stop()

					self.stageAnimTimer_ = nil
				end
			end
		end, 1, -1)

		self.stageAnimTimer_:Start()
		saveData("QWorldBookletAnimData", "MainViewStage", self.curPhotoStage_)
	end
end

function QWorldBookletMainView:SetLevelTextAndShadow()
	for iter_17_0 = 1, 4 do
		self["levelText" .. iter_17_0].text = self.curLv_ .. "<size=60>/" .. self.maxLv_ .. "</size>"
	end
end

function QWorldBookletMainView:SetTabExtraScenicTextAndShadow()
	if not SandPlaySystemCfg[var_0_3] then
		return
	end

	for iter_18_0 = 1, 4 do
		self["tabNameText1_" .. iter_18_0].text = SandPlaySystemCfg[var_0_3].name
	end
end

function QWorldBookletMainView:SetTabMainQuestTextAndShadow()
	if not SandPlaySystemCfg[var_0_4] then
		return
	end

	for iter_19_0 = 1, 4 do
		self["tabNameText2_" .. iter_19_0].text = SandPlaySystemCfg[var_0_4].name
	end
end

function QWorldBookletMainView:SetBookNameTextAndShadow()
	for iter_20_0 = 1, 4 do
		self["bookNameText" .. iter_20_0].text = QWorldBookletTools.GetBookletSystemName()
	end
end

function QWorldBookletMainView:Dispose()
	QWorldBookletMainView.super.Dispose(self)
end

return QWorldBookletMainView
