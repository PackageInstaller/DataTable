local ChapterMapView = class("ChapterMapView", ReduxView)
local BattleConst = import("game.const.BattleConst")

function ChapterMapView:UIName()
	return "Widget/System/Operation/OperationOvUI"
end

function ChapterMapView:UIParent()
	return manager.ui.uiMain.transform
end

function ChapterMapView:Init()
	self.toggleView_ = {}
	self.contentView_ = {}

	self:InitUI()
end

function ChapterMapView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		NAVI_BAR,
		INVITE_BAR
	})
end

function ChapterMapView:OnEnter(arg_5_1)
	SetActive(self.mainContent_, false)
	SetActive(self.resourceContent_, false)
	SetActive(self.equipContent_, false)
	SetActive(self.challengeContent_, false)
	SetActive(self.plotExPanel_, false)
	SetActive(self.eventContent_, false)
	manager.ui:SetMainCamera("chapterSelect")

	for iter_5_0, iter_5_1 in pairs(self.contentView_) do
		iter_5_1:OnEnter(self.params_)
	end

	for iter_5_2, iter_5_3 in pairs(self.toggleView_) do
		iter_5_3:OnEnter()
	end

	self:SwitchToggle(self.params_.chapterToggle)
end

function ChapterMapView:OnExit()
	if self.multiView then
		self.multiView:OnExit()
	end

	manager.windowBar:HideBar()

	for iter_6_0, iter_6_1 in pairs(self.contentView_) do
		iter_6_1:OnExit()
	end

	manager.ui:ResetMainCamera()

	for iter_6_2, iter_6_3 in pairs(self.toggleView_) do
		iter_6_3:OnExit()
	end

	self:RecordStay(self.curToggle)
	LuaForCursor.SetFullscreenScrollObject(nil)
end

function ChapterMapView:Dispose()
	if self.clickListenerTimer_ then
		self.clickListenerTimer_:Stop()

		self.clickListenerTimer_ = nil
	end

	if self.multiView then
		self.multiView:Dispose()

		self.multiView = nil
	end

	for iter_7_0, iter_7_1 in pairs(self.toggleView_) do
		iter_7_1:Dispose()
	end

	self.toggleView_ = nil

	for iter_7_2, iter_7_3 in pairs(self.contentView_) do
		iter_7_3:Dispose()
	end

	self.contentView_ = nil

	ChapterMapView.super.Dispose(self)

	self.mainToggle_ = nil
	self.resourceToggle_ = nil
	self.equipToggle_ = nil
	self.challengeToggle_ = nil
	self.mapContent_ = nil
	self.resourceContent_ = nil
	self.challengeContent_ = nil
	self.equipContent_ = nil
end

function ChapterMapView:OnUpdate()
	self:SwitchToggle(self.params_.chapterToggle)
end

function ChapterMapView:InitUI()
	self:BindCfgUI()

	self.toggleView_[BattleConst.TOGGLE.MAIN] = ChapterBtnView.New(self.mainButton_, BattleConst.TOGGLE.MAIN)
	self.toggleView_[BattleConst.TOGGLE.RESOURCE] = ChapterBtnView.New(self.resourceButton_, BattleConst.TOGGLE.RESOURCE)
	self.toggleView_[BattleConst.TOGGLE.CHALLENGE] = ChapterBtnView.New(self.challengeButton_, BattleConst.TOGGLE.CHALLENGE)
	self.toggleView_[BattleConst.TOGGLE.EQUIP] = ChapterBtnView.New(self.equipButton_, BattleConst.TOGGLE.EQUIP)
	self.toggleView_[BattleConst.TOGGLE.RESIDENT_ACT] = ChapterBtnView.New(self.eventButton_, BattleConst.TOGGLE.RESIDENT_ACT)
	self.multiView = OperationMultiView.New(self.doubleGo_)
end

function ChapterMapView:SwitchToggle(arg_10_1)
	self:HideWeakGuide()

	if self.contentView_[arg_10_1] == nil then
		self:CreateContentView(arg_10_1)
	end

	for iter_10_0, iter_10_1 in pairs(self.contentView_) do
		self.contentView_[iter_10_0]:SetActive(iter_10_0 == arg_10_1)
	end

	for iter_10_2, iter_10_3 in pairs(self.toggleView_) do
		self.toggleView_[iter_10_2]:SelectChapterToggle(iter_10_2 == arg_10_1)
	end

	if self.curToggle and arg_10_1 ~= self.curToggle then
		self:RecordStay(self.curToggle)
	end

	self.curToggle = arg_10_1

	self.multiView:RefreshUI(nil, self.curToggle)

	if arg_10_1 == BattleConst.TOGGLE.RESOURCE or arg_10_1 == BattleConst.TOGGLE.EQUIP or arg_10_1 == BattleConst.TOGGLE.CHALLENGE then
		LuaForCursor.SetFullscreenScrollObject(self.contentView_[arg_10_1].scrollView_.gameObject)
	else
		LuaForCursor.SetFullscreenScrollObject(nil)
	end
end

function ChapterMapView:CreateContentView(arg_11_1)
	if arg_11_1 == BattleConst.TOGGLE.MAIN then
		self.contentView_[arg_11_1] = ChapterMainContentView.New(self.mainContent_, arg_11_1)
	elseif arg_11_1 == BattleConst.TOGGLE.RESOURCE then
		self.contentView_[arg_11_1] = ChapterDailyContentView.New(self.resourceContent_, arg_11_1)
	elseif arg_11_1 == BattleConst.TOGGLE.EQUIP then
		self.contentView_[arg_11_1] = ChapterEquipContentView.New(self.equipContent_, arg_11_1)
	elseif arg_11_1 == BattleConst.TOGGLE.CHALLENGE then
		self.contentView_[arg_11_1] = ChapterChallengeContentView.New(self.challengeContent_, arg_11_1, self)
	elseif arg_11_1 == BattleConst.TOGGLE.RESIDENT_ACT then
		self.contentView_[arg_11_1] = ChapterResidentActContentView.New(self.eventContent_, arg_11_1)
	end

	self.contentView_[arg_11_1]:OnEnter(self.params_)
end

function ChapterMapView:RecordStay(arg_12_1)
	local var_12_0 = self:GetStayTime()

	if var_12_0 == 0 then
		return
	end

	local var_12_1 = 0

	if arg_12_1 == BattleConst.TOGGLE.MAIN then
		var_12_1 = 70
	elseif arg_12_1 == BattleConst.TOGGLE.RESOURCE then
		var_12_1 = 20
	elseif arg_12_1 == BattleConst.TOGGLE.EQUIP then
		var_12_1 = 30
	elseif arg_12_1 == BattleConst.TOGGLE.CHALLENGE then
		var_12_1 = 40
	end

	OperationRecorder.RecordStayView("STAY_VIEW_CHAPTER_MAP", var_12_0, var_12_1)
	self:UpdateLastOpenTime()
end

function ChapterMapView:OnAssetPendDownloadEnd(arg_13_1, arg_13_2)
	if self.contentView_[self.curToggle] and self.contentView_[self.curToggle].RefreshUI then
		self.contentView_[self.curToggle]:RefreshUI()
	end
end

return ChapterMapView
