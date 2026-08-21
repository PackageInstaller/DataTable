local var_0_0 = class("ActivityPtScrollAffixSelectView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Common/Pop/SuitSelectUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddListeners()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.tgl_ = {}
	arg_5_0.tglCon_ = {}
	arg_5_0.todayCon_ = {}

	for iter_5_0 = 1, 7 do
		local var_5_0 = Object.Instantiate(arg_5_0.tempBtn_.gameObject, arg_5_0.contentGo_.transform)

		var_5_0.transform:Find("text").gameObject:GetComponent("Text").text = GetTips("ACTIVITY_ROULETTE_WEEK_" .. iter_5_0)
		var_5_0.name = "tgl_" .. iter_5_0

		SetActive(var_5_0, true)

		arg_5_0.tgl_[iter_5_0] = var_5_0.transform:GetComponent("Toggle")
		arg_5_0.tglCon_[iter_5_0] = ControllerUtil.GetController(arg_5_0.tgl_[iter_5_0].transform, "toggle")
		arg_5_0.todayCon_[iter_5_0] = ControllerUtil.GetController(arg_5_0.tgl_[iter_5_0].transform, "isToday")
	end

	arg_5_0.scrollHelper_ = LuaList.New(handler(arg_5_0, arg_5_0.IndexItem), arg_5_0.itempanelGo_, SuitSelectItem)
	arg_5_0.autoDecomposeController_ = arg_5_0.controllerEx_:GetController("autoDecompose")
	arg_5_0.autoFlagController_ = arg_5_0.controllerEx_:GetController("autoFlag")

	arg_5_0.autoDecomposeController_:SetSelectedState("true")
end

function var_0_0.IndexItem(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0.curSuitList_[arg_6_1]

	arg_6_2:ShowSelect(var_6_0 == arg_6_0.selectSuitId_)
	arg_6_2:ShowCurrentUp(var_6_0 == arg_6_0.upID_ and arg_6_0.selectDay_ == arg_6_0.nowDay_)
	arg_6_2:RefreshData(arg_6_0, {
		id = var_6_0
	})
	arg_6_2:RegistCallBack(function(arg_7_0)
		arg_6_0:SetSelect(arg_7_0)
	end)
end

function var_0_0.AddListeners(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.bgMaskBtn_, nil, function()
		JumpTools.Back()
	end)
	arg_8_0:AddBtnListenerScale(arg_8_0.upBtn_, nil, function()
		ActivityPtScrollAction.SetSelectSuit(arg_8_0.activityID_, arg_8_0.selectSuitId_)
	end)
	arg_8_0:AddBtnListener(arg_8_0.selectBtn_, nil, function()
		if arg_8_0.buttonUp_ and arg_8_0.buttonUp_ > 0 then
			arg_8_0:HidePop()
			FuncTimerManager.inst:RemoveFuncTimer(arg_8_0.clickTimer_)

			arg_8_0.clickTimer_ = nil

			return
		end

		SetActive(arg_8_0.contentGo_, true)
		arg_8_0:AddClickTimer()
	end)

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.tgl_) do
		arg_8_0:AddToggleListener(iter_8_1, function(arg_12_0)
			if arg_12_0 then
				arg_8_0:RefreshDay(iter_8_0)
			end
		end)
	end

	arg_8_0:AddBtnListener(arg_8_0.autoDecomposeBtn_, nil, function()
		if not EquipData:GetAutoDecompose(BattleConst.BATTLE_EQUIP_TYPE.PT) then
			ShowMessageBox({
				isTop = true,
				title = GetTips("PROMPT"),
				content = GetTips("AUTO_DECOMPOSE_TIPS"),
				OkCallback = function()
					EquipAction.SetAutoDecomposeState(BattleConst.BATTLE_EQUIP_TYPE.PT, true, function()
						ShowTips("AUTO_DECOMPOSE_OPEN")
						arg_8_0:RefreshAutoState()
					end)
				end,
				CancelCallback = function()
					return
				end
			})
		else
			EquipAction.SetAutoDecomposeState(BattleConst.BATTLE_EQUIP_TYPE.PT, false, function()
				ShowTips("AUTO_DECOMPOSE_CLOSE")
				arg_8_0:RefreshAutoState()
			end)
		end
	end)
end

function var_0_0.OnEnter(arg_18_0)
	arg_18_0.scrollList_ = {}
	arg_18_0.activityID_ = arg_18_0.params_.mainActivityID

	local var_18_0 = ActivityPtRouletteStageCfg.get_id_list_by_activity_id[arg_18_0.activityID_]

	for iter_18_0, iter_18_1 in ipairs(var_18_0) do
		if ActivityPtRouletteStageCfg[iter_18_1].mode == 2 then
			arg_18_0.scrollList_ = ActivityPtRouletteStageCfg[iter_18_1].roulette_id

			break
		end
	end

	arg_18_0.isSelect_, arg_18_0.upID_ = ActivityPtScrollData:GetUpSelect(arg_18_0.activityID_)

	local var_18_1 = ActivityPtScrollData:GetPoolID(arg_18_0.activityID_)

	arg_18_0.nowDay_ = ActivityPtRouletteRandomCfg[var_18_1].time

	arg_18_0:RefreshDay(arg_18_0.nowDay_)
	arg_18_0:ResetSort()

	local var_18_2 = manager.time:GetServerTime()

	saveData("activityPtScroll", "last_check_up", var_18_2)
	manager.redPoint:setTip(RedPointConst.ACTIVITY_PT_SCROLL_UP_SELECT .. "_" .. arg_18_0.activityID_, 0)
	arg_18_0:RefreshAutoState()
end

function var_0_0.RefreshDay(arg_19_0, arg_19_1)
	arg_19_0.selectDay_ = arg_19_1
	arg_19_0.selectText_.text = GetTips("ACTIVITY_ROULETTE_WEEK_" .. arg_19_0.selectDay_)

	arg_19_0:RefreshList()
	arg_19_0:RefreshInfo()
end

function var_0_0.ResetSort(arg_20_0)
	arg_20_0.tgl_[arg_20_0.selectDay_].isOn = true

	for iter_20_0, iter_20_1 in ipairs(arg_20_0.tglCon_) do
		iter_20_1:SetSelectedState(iter_20_0 == arg_20_0.selectDay_ and "on" or "off")
		arg_20_0.todayCon_[iter_20_0]:SetSelectedState(iter_20_0 == arg_20_0.selectDay_ and "true" or "false")
	end
end

function var_0_0.RefreshList(arg_21_0)
	arg_21_0.curSuitList_ = {}

	for iter_21_0, iter_21_1 in ipairs(arg_21_0.scrollList_) do
		local var_21_0 = ActivityPtRouletteRandomCfg[iter_21_1]

		if var_21_0.time == arg_21_0.selectDay_ then
			arg_21_0.curSuitList_ = var_21_0.equip_suit_list

			break
		end
	end

	arg_21_0.selectSuitId_ = arg_21_0.selectDay_ == arg_21_0.nowDay_ and arg_21_0.upID_ or arg_21_0.curSuitList_[1]

	arg_21_0.scrollHelper_:StartScroll(#arg_21_0.curSuitList_)
end

function var_0_0.RefreshInfo(arg_22_0)
	local var_22_0 = EquipSuitCfg[arg_22_0.selectSuitId_]

	if not var_22_0 then
		SetActive(arg_22_0.infoGo_, false)

		return
	end

	SetActive(arg_22_0.infoGo_, true)

	arg_22_0.nameText_.text = var_22_0.name
	arg_22_0.numText_.text = var_22_0.need
	arg_22_0.contentText_.text = EquipTools.GetEffectDesc(var_22_0.suit_effect[1])

	SetActive(arg_22_0.upBtn_.gameObject, arg_22_0.selectSuitId_ ~= arg_22_0.upID_ and arg_22_0.selectDay_ == arg_22_0.nowDay_)
	SetActive(arg_22_0.tipGo_, arg_22_0.selectDay_ ~= arg_22_0.nowDay_)
end

function var_0_0.SetSelect(arg_23_0, arg_23_1)
	arg_23_0.selectSuitId_ = arg_23_1.id

	for iter_23_0, iter_23_1 in ipairs(arg_23_0.scrollHelper_:GetItemList()) do
		iter_23_1:ShowSelect(iter_23_1.info_.id == arg_23_0.selectSuitId_)
	end

	arg_23_0:RefreshInfo()
end

function var_0_0.AddClickTimer(arg_24_0)
	arg_24_0:StopTimer()

	arg_24_0.buttonUp_ = 0
	arg_24_0.clickTimer_ = FuncTimerManager.inst:CreateFuncFrameTimer(function()
		if Input.GetMouseButtonUp(0) then
			arg_24_0.buttonUp_ = arg_24_0.buttonUp_ + 1

			if arg_24_0.buttonUp_ >= 2 then
				arg_24_0:HidePop()
				FuncTimerManager.inst:RemoveFuncTimer(arg_24_0.clickTimer_)

				arg_24_0.clickTimer_ = nil
			end
		end
	end, -1, true)
end

function var_0_0.StopTimer(arg_26_0)
	if arg_26_0.clickTimer_ then
		FuncTimerManager.inst:RemoveFuncTimer(arg_26_0.clickTimer_)

		arg_26_0.clickTimer_ = nil
	end
end

function var_0_0.HidePop(arg_27_0)
	arg_27_0.buttonUp_ = 0

	SetActive(arg_27_0.contentGo_, false)
end

function var_0_0.OnSetSelectSuit(arg_28_0)
	arg_28_0.isSelect_, arg_28_0.upID_ = ActivityPtScrollData:GetUpSelect(arg_28_0.activityID_)

	arg_28_0:RefreshDay(arg_28_0.nowDay_)
end

function var_0_0.OnExit(arg_29_0)
	arg_29_0.selectSuitId_ = nil
end

function var_0_0.Dispose(arg_30_0)
	arg_30_0.scrollHelper_:Dispose()
	var_0_0.super.Dispose(arg_30_0)
end

function var_0_0.RefreshAutoState(arg_31_0)
	local var_31_0 = EquipData:GetAutoDecompose(BattleConst.BATTLE_EQUIP_TYPE.PT)

	arg_31_0.autoFlagController_:SetSelectedState(tostring(var_31_0))
end

return var_0_0
