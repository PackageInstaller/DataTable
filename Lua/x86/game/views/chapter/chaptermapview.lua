local var_0_0 = class("ChapterMapView", ReduxView)
local var_0_1 = import("game.const.BattleConst")

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Operation/OperationOvUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.toggleView_ = {}
	arg_3_0.contentView_ = {}

	arg_3_0:InitUI()
end

function var_0_0.OnTop(arg_4_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		NAVI_BAR,
		INVITE_BAR
	})
end

function var_0_0.OnEnter(arg_5_0, arg_5_1)
	SetActive(arg_5_0.mainContent_, false)
	SetActive(arg_5_0.resourceContent_, false)
	SetActive(arg_5_0.equipContent_, false)
	SetActive(arg_5_0.challengeContent_, false)
	SetActive(arg_5_0.plotExPanel_, false)
	SetActive(arg_5_0.eventContent_, false)
	manager.ui:SetMainCamera("chapterSelect")

	for iter_5_0, iter_5_1 in pairs(arg_5_0.contentView_) do
		iter_5_1:OnEnter(arg_5_0.params_)
	end

	for iter_5_2, iter_5_3 in pairs(arg_5_0.toggleView_) do
		iter_5_3:OnEnter()
	end

	arg_5_0:SwitchToggle(arg_5_0.params_.chapterToggle)
end

function var_0_0.OnExit(arg_6_0)
	if arg_6_0.multiView then
		arg_6_0.multiView:OnExit()
	end

	manager.windowBar:HideBar()

	for iter_6_0, iter_6_1 in pairs(arg_6_0.contentView_) do
		iter_6_1:OnExit()
	end

	manager.ui:ResetMainCamera()

	for iter_6_2, iter_6_3 in pairs(arg_6_0.toggleView_) do
		iter_6_3:OnExit()
	end

	arg_6_0:RecordStay(arg_6_0.curToggle)
	LuaForCursor.SetFullscreenScrollObject(nil)
end

function var_0_0.Dispose(arg_7_0)
	if arg_7_0.clickListenerTimer_ then
		arg_7_0.clickListenerTimer_:Stop()

		arg_7_0.clickListenerTimer_ = nil
	end

	if arg_7_0.multiView then
		arg_7_0.multiView:Dispose()

		arg_7_0.multiView = nil
	end

	for iter_7_0, iter_7_1 in pairs(arg_7_0.toggleView_) do
		iter_7_1:Dispose()
	end

	arg_7_0.toggleView_ = nil

	for iter_7_2, iter_7_3 in pairs(arg_7_0.contentView_) do
		iter_7_3:Dispose()
	end

	arg_7_0.contentView_ = nil

	var_0_0.super.Dispose(arg_7_0)

	arg_7_0.mainToggle_ = nil
	arg_7_0.resourceToggle_ = nil
	arg_7_0.equipToggle_ = nil
	arg_7_0.challengeToggle_ = nil
	arg_7_0.mapContent_ = nil
	arg_7_0.resourceContent_ = nil
	arg_7_0.challengeContent_ = nil
	arg_7_0.equipContent_ = nil
end

function var_0_0.OnUpdate(arg_8_0)
	arg_8_0:SwitchToggle(arg_8_0.params_.chapterToggle)
end

function var_0_0.InitUI(arg_9_0)
	arg_9_0:BindCfgUI()

	arg_9_0.toggleView_[var_0_1.TOGGLE.MAIN] = ChapterBtnView.New(arg_9_0.mainButton_, var_0_1.TOGGLE.MAIN)
	arg_9_0.toggleView_[var_0_1.TOGGLE.RESOURCE] = ChapterBtnView.New(arg_9_0.resourceButton_, var_0_1.TOGGLE.RESOURCE)
	arg_9_0.toggleView_[var_0_1.TOGGLE.CHALLENGE] = ChapterBtnView.New(arg_9_0.challengeButton_, var_0_1.TOGGLE.CHALLENGE)
	arg_9_0.toggleView_[var_0_1.TOGGLE.EQUIP] = ChapterBtnView.New(arg_9_0.equipButton_, var_0_1.TOGGLE.EQUIP)
	arg_9_0.toggleView_[var_0_1.TOGGLE.RESIDENT_ACT] = ChapterBtnView.New(arg_9_0.eventButton_, var_0_1.TOGGLE.RESIDENT_ACT)
	arg_9_0.multiView = OperationMultiView.New(arg_9_0.doubleGo_)
end

function var_0_0.SwitchToggle(arg_10_0, arg_10_1)
	arg_10_0:HideWeakGuide()

	if arg_10_0.contentView_[arg_10_1] == nil then
		arg_10_0:CreateContentView(arg_10_1)
	end

	for iter_10_0, iter_10_1 in pairs(arg_10_0.contentView_) do
		arg_10_0.contentView_[iter_10_0]:SetActive(iter_10_0 == arg_10_1)
	end

	for iter_10_2, iter_10_3 in pairs(arg_10_0.toggleView_) do
		arg_10_0.toggleView_[iter_10_2]:SelectChapterToggle(iter_10_2 == arg_10_1)
	end

	if arg_10_0.curToggle and arg_10_1 ~= arg_10_0.curToggle then
		arg_10_0:RecordStay(arg_10_0.curToggle)
	end

	arg_10_0.curToggle = arg_10_1

	arg_10_0.multiView:RefreshUI(nil, arg_10_0.curToggle)

	if arg_10_1 == var_0_1.TOGGLE.RESOURCE or arg_10_1 == var_0_1.TOGGLE.EQUIP or arg_10_1 == var_0_1.TOGGLE.CHALLENGE then
		local var_10_0 = arg_10_0.contentView_[arg_10_1]

		LuaForCursor.SetFullscreenScrollObject(var_10_0.scrollView_.gameObject)
	else
		LuaForCursor.SetFullscreenScrollObject(nil)
	end
end

function var_0_0.CreateContentView(arg_11_0, arg_11_1)
	if arg_11_1 == var_0_1.TOGGLE.MAIN then
		arg_11_0.contentView_[arg_11_1] = ChapterMainContentView.New(arg_11_0.mainContent_, arg_11_1)
	elseif arg_11_1 == var_0_1.TOGGLE.RESOURCE then
		arg_11_0.contentView_[arg_11_1] = ChapterDailyContentView.New(arg_11_0.resourceContent_, arg_11_1)
	elseif arg_11_1 == var_0_1.TOGGLE.EQUIP then
		arg_11_0.contentView_[arg_11_1] = ChapterEquipContentView.New(arg_11_0.equipContent_, arg_11_1)
	elseif arg_11_1 == var_0_1.TOGGLE.CHALLENGE then
		arg_11_0.contentView_[arg_11_1] = ChapterChallengeContentView.New(arg_11_0.challengeContent_, arg_11_1, arg_11_0)
	elseif arg_11_1 == var_0_1.TOGGLE.RESIDENT_ACT then
		arg_11_0.contentView_[arg_11_1] = ChapterResidentActContentView.New(arg_11_0.eventContent_, arg_11_1)
	end

	arg_11_0.contentView_[arg_11_1]:OnEnter(arg_11_0.params_)
end

function var_0_0.RecordStay(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0:GetStayTime()

	if var_12_0 == 0 then
		return
	end

	local var_12_1 = 0

	if arg_12_1 == var_0_1.TOGGLE.MAIN then
		var_12_1 = 70
	elseif arg_12_1 == var_0_1.TOGGLE.RESOURCE then
		var_12_1 = 20
	elseif arg_12_1 == var_0_1.TOGGLE.EQUIP then
		var_12_1 = 30
	elseif arg_12_1 == var_0_1.TOGGLE.CHALLENGE then
		var_12_1 = 40
	end

	OperationRecorder.RecordStayView("STAY_VIEW_CHAPTER_MAP", var_12_0, var_12_1)
	arg_12_0:UpdateLastOpenTime()
end

function var_0_0.OnAssetPendDownloadEnd(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_0.contentView_[arg_13_0.curToggle] and arg_13_0.contentView_[arg_13_0.curToggle].RefreshUI then
		arg_13_0.contentView_[arg_13_0.curToggle]:RefreshUI()
	end
end

return var_0_0
