local var_0_0 = class("AchievementInfoView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/AchievementsUI/AchievementInfoUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.noticeRectList_ = {
		arg_3_0.rectCultivate_,
		arg_3_0.rectCollect_,
		arg_3_0.rectMission_,
		arg_3_0.rectPlayer_,
		arg_3_0.rectBattle_,
		arg_3_0.rectOther_
	}
	arg_3_0.goButtonList_ = {
		arg_3_0.goCultivate_,
		arg_3_0.goCollect_,
		arg_3_0.goMission_,
		arg_3_0.goPlayer_,
		arg_3_0.goBattle_,
		arg_3_0.goOther_
	}
	arg_3_0.scrollPositionList_ = {}
	arg_3_0.achievementUIList_ = LuaList.New(handler(arg_3_0, arg_3_0.RefreshItem), arg_3_0.uiList_, AchievementInfoItem)
	arg_3_0.achievementButtonList_ = {}

	for iter_3_0, iter_3_1 in pairs(AchievementConst.AchievementType) do
		arg_3_0.achievementButtonList_[iter_3_1] = AchievementInfoButton.New(arg_3_0.goButtonList_[iter_3_1], iter_3_1)
	end

	arg_3_0.oneKeyCon_ = ControllerUtil.GetController(arg_3_0.achievePlotTrans_, "onekey")

	arg_3_0:InitUI()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.receiveAllBtn_, nil, function()
		arg_4_0:ReceiveAll()
	end)
end

function var_0_0.OnEnter(arg_6_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_VITALITY,
		CurrencyConst.CURRENCY_TYPE_GOLD,
		CurrencyConst.CURRENCY_TYPE_DIAMOND
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_VITALITY, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)

	arg_6_0.selectType_ = arg_6_0.params_.achievementType

	arg_6_0:RefreshScroll()
	arg_6_0:RefreshButton()

	for iter_6_0, iter_6_1 in ipairs(AchievementCfg.get_id_list_by_type_id) do
		manager.redPoint:bindUIandKey(arg_6_0.noticeRectList_[iter_6_0], string.format("%s_%s", RedPointConst.ACHIEVEMENT, iter_6_0))
	end

	arg_6_0:RefreshText()
	arg_6_0:RefreshRecivedAll()
end

function var_0_0.OnExit(arg_7_0)
	manager.windowBar:HideBar()

	for iter_7_0, iter_7_1 in ipairs(AchievementCfg.get_id_list_by_type_id) do
		manager.redPoint:unbindUIandKey(arg_7_0.noticeRectList_[iter_7_0])
	end

	arg_7_0.scrollPositionList_ = {}
	arg_7_0.scrollPositionList_[arg_7_0.selectType_] = arg_7_0.achievementUIList_:GetScrolledPosition()
end

function var_0_0.OnUpdate(arg_8_0)
	if arg_8_0.selectType_ == arg_8_0.params_.achievementType then
		arg_8_0.scrollPositionList_[arg_8_0.selectType_] = arg_8_0.achievementUIList_:GetScrolledPosition()

		AchievementData:SetScrollRecord(true)
	end

	arg_8_0.selectType_ = arg_8_0.params_.achievementType

	arg_8_0:RefreshScroll()
	arg_8_0:RefreshButton()
	arg_8_0:RefreshText()
	arg_8_0:RefreshRecivedAll()
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)

	for iter_9_0, iter_9_1 in pairs(arg_9_0.achievementButtonList_) do
		iter_9_1:Dispose()
	end

	arg_9_0.achievementButtonList_ = nil

	if arg_9_0.achievementUIList_ then
		arg_9_0.achievementUIList_:Dispose()

		arg_9_0.achievementUIList_ = nil
	end
end

function var_0_0.RefreshButton(arg_10_0)
	for iter_10_0, iter_10_1 in pairs(arg_10_0.achievementButtonList_) do
		iter_10_1:RefreshSelectType(arg_10_0.selectType_)
	end
end

function var_0_0.RefreshScroll(arg_11_0)
	arg_11_0.achievementIDList_ = AchievementData:GetAchievementIDList(arg_11_0.selectType_)

	local var_11_0

	if AchievementData:GetScrollRecord() == true then
		var_11_0 = arg_11_0.scrollPositionList_[arg_11_0.selectType_] or Vector3.one
	else
		var_11_0 = Vector3.one
	end

	arg_11_0.achievementUIList_:StartScrollByPosition(#arg_11_0.achievementIDList_, var_11_0)
end

function var_0_0.RefreshItem(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0.achievementIDList_[arg_12_1]

	arg_12_2:SetData(var_12_0)
end

function var_0_0.RefreshText(arg_13_0)
	arg_13_0.textAchievement_.text = AchievementData:GetFinishAchievementCnt()
	arg_13_0.textCnt_.text = string.format("/%s", AchievementData:GetAchievementTotalCnt())
	arg_13_0.textPoint_.text = AchievementData:GetAchievementPoint()
end

function var_0_0.RefreshRecivedAll(arg_14_0)
	if #AchievementData:GetReadyAchievementList(arg_14_0.selectType_) >= 1 then
		arg_14_0.oneKeyCon_:SetSelectedState("true")
	else
		arg_14_0.oneKeyCon_:SetSelectedState("false")
	end
end

function var_0_0.ReceiveAll(arg_15_0)
	AchievementAction.TryToSubmitAchievementList(arg_15_0.selectType_)
end

return var_0_0
