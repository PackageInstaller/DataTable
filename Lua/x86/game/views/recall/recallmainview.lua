local var_0_0 = class("RecallMainView", ReduxView)
local var_0_1 = {
	"recalled",
	"recall",
	"mission",
	"treasure"
}

function var_0_0.UIName(arg_1_0)
	return "Widget/System/RecallUI/RC1stMenuUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.curPageIndex_ = -1
	arg_3_0.params_ = {}
	arg_3_0.prefabList_ = {
		"Widget/System/RecallUI/RC1stReturnUI",
		"Widget/System/RecallUI/RC1stInitiateUI",
		"Widget/System/RecallUI/RC1stMissionUI",
		"Widget/System/RecallUI/RC1stTreasureUI"
	}
	arg_3_0.ClassList_ = {
		RecallSystemRecalledView,
		RecallSystemRecallView,
		RecallSystemTaskView,
		RecallSystemShopView
	}

	arg_3_0:InitUI()
	arg_3_0:AddUIListener()

	arg_3_0.needExitAnim = {
		[2] = true,
		[4] = true
	}
	arg_3_0.needEnterAnim = {
		[1] = true,
		[3] = true
	}
	arg_3_0.playAnimTypeConst = {
		EXIT = 2,
		ENTER = 1
	}
	arg_3_0.animConst = {
		[1] = "Fx_adron_cx",
		[2] = "Fx_adron_xs"
	}
	arg_3_0.animation = arg_3_0.animPanelGo_:GetComponent("Animation")
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.pages_ = {}
end

function var_0_0.AddUIListener(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs(var_0_1) do
		arg_5_0:AddToggleListener(arg_5_0[iter_5_1 .. "Btn_"], function(arg_6_0)
			if arg_6_0 then
				arg_5_0:SwitchPage(iter_5_0)
				ControllerUtil.GetController(arg_5_0[iter_5_1 .. "Btn_"].transform, "toggle"):SetSelectedState("on")
			end
		end)
	end

	arg_5_0:RegistEventListener(MATERIAL_MODIFY, function(arg_7_0)
		if arg_7_0 == arg_5_0.id then
			manager.windowBar:SwitchBar(arg_5_0.barList)
		end
	end)
end

function var_0_0.SwitchPage(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.pages_[arg_8_0.curPageIndex_]

	if var_8_0 then
		var_8_0:Hide()
	end

	arg_8_0.curPageIndex_ = arg_8_1
	arg_8_0.params_.page = arg_8_1

	if not arg_8_0.pages_[arg_8_1] and arg_8_0.prefabList_[arg_8_1] and arg_8_0.ClassList_[arg_8_1] then
		local var_8_1 = Asset.Load(arg_8_0.prefabList_[arg_8_1])
		local var_8_2 = Object.Instantiate(var_8_1, arg_8_0.container_)

		arg_8_0.pages_[arg_8_1] = arg_8_0.ClassList_[arg_8_1].New(var_8_2)
	end

	arg_8_0.pages_[arg_8_0.curPageIndex_]:Show()
	arg_8_0.pages_[arg_8_1]:OnEnter()
	arg_8_0:PlayAnim()
end

function var_0_0.PlayAnim(arg_9_0)
	local var_9_0 = false
	local var_9_1 = -1

	if arg_9_0.params_.isEnter == true then
		if arg_9_0.needExitAnim[arg_9_0.curPageIndex_] == true then
			var_9_0 = false
			var_9_1 = arg_9_0.playAnimTypeConst.EXIT
		elseif arg_9_0.needEnterAnim[arg_9_0.curPageIndex_] == true then
			var_9_0 = true
			var_9_1 = arg_9_0.playAnimTypeConst.ENTER
			arg_9_0.params_.isEnter = false
		end
	else
		var_9_0 = true

		if arg_9_0.needEnterAnim[arg_9_0.curPageIndex_] == true and arg_9_0.lastPlayType ~= arg_9_0.playAnimTypeConst.ENTER then
			var_9_1 = arg_9_0.playAnimTypeConst.ENTER
		elseif arg_9_0.needExitAnim[arg_9_0.curPageIndex_] == true and arg_9_0.lastPlayType ~= arg_9_0.playAnimTypeConst.EXIT then
			var_9_1 = arg_9_0.playAnimTypeConst.EXIT
		end
	end

	SetActive(arg_9_0.animPanelGo_, var_9_0)

	if var_9_0 == true and var_9_1 ~= -1 then
		arg_9_0.lastPlayType = var_9_1

		arg_9_0.animation:Play(arg_9_0.animConst[var_9_1])
	end
end

function var_0_0.CheckPageEnter(arg_10_0, arg_10_1)
	if not arg_10_0.enteredPage_[arg_10_1] then
		arg_10_0.pages_[arg_10_1]:OnEnter()

		arg_10_0.enteredPage_[arg_10_1] = true
	end
end

function var_0_0.SetFirstPage(arg_11_0)
	local var_11_0 = ActivityRecallData:GetDataByPara("firstPage")

	SetActive(arg_11_0.recalledBtn_.gameObject, var_11_0)

	if arg_11_0.curPageIndex_ == -1 then
		arg_11_0.curPageIndex_ = var_11_0 and 1 or 2
	end

	arg_11_0:SwitchPage(arg_11_0.curPageIndex_)
end

function var_0_0.OnTop(arg_12_0)
	local var_12_0 = ActivityRecallData:GetDataByPara("shopID")

	arg_12_0.barList = {}

	table.insert(arg_12_0.barList, INFO_BAR)
	table.insert(arg_12_0.barList, BACK_BAR)
	table.insert(arg_12_0.barList, HOME_BAR)
	table.insert(arg_12_0.barList, NAVI_BAR)

	local var_12_1 = {}
	local var_12_2 = ShopListCfg[var_12_0]

	for iter_12_0 = 1, #var_12_2.cost_id do
		arg_12_0.id = nil

		if CurrencyIdMapCfg[var_12_2.cost_id[iter_12_0]] then
			arg_12_0.id = CurrencyIdMapCfg[var_12_2.cost_id[iter_12_0]].item_id
		else
			arg_12_0.id = var_12_2.cost_id[iter_12_0]
		end

		table.insert(arg_12_0.barList, arg_12_0.id)
		table.insert(var_12_1, arg_12_0.id)
	end

	manager.windowBar:SwitchBar(arg_12_0.barList)

	for iter_12_1 = 1, #var_12_1 do
		manager.windowBar:SetBarCanClick(var_12_1[iter_12_1], true)
	end

	manager.windowBar:SetGameHelpKey("RECALLED_DESC")
end

function var_0_0.OnSign(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_0.pages_[arg_13_0.curPageIndex_] and arg_13_0.pages_[arg_13_0.curPageIndex_].OnSign then
		arg_13_0.pages_[arg_13_0.curPageIndex_]:OnSign(arg_13_1, arg_13_2)
	end
end

function var_0_0.OnReceivedCodeReward(arg_14_0)
	if arg_14_0.pages_[arg_14_0.curPageIndex_] and arg_14_0.pages_[arg_14_0.curPageIndex_].OnReceivedCodeReward then
		arg_14_0.pages_[arg_14_0.curPageIndex_]:OnReceivedCodeReward()
	end
end

function var_0_0.OnRecallRewardUpdate(arg_15_0)
	if arg_15_0.pages_[arg_15_0.curPageIndex_] and arg_15_0.pages_[arg_15_0.curPageIndex_].OnRecallRewardUpdate then
		arg_15_0.pages_[arg_15_0.curPageIndex_]:OnRecallRewardUpdate()
	end
end

function var_0_0.OnRecallSignUpdate(arg_16_0)
	if arg_16_0.pages_[arg_16_0.curPageIndex_] and arg_16_0.pages_[arg_16_0.curPageIndex_].OnRecallSignUpdate then
		arg_16_0.pages_[arg_16_0.curPageIndex_]:OnRecallSignUpdate()
	end
end

function var_0_0.OnEnter(arg_17_0)
	arg_17_0.enteredPage_ = {}

	for iter_17_0, iter_17_1 in pairs(arg_17_0.pages_) do
		arg_17_0:CheckPageEnter(iter_17_0)
	end

	arg_17_0:SetFirstPage()
	arg_17_0:BindRedPoint()
end

function var_0_0.OnExit(arg_18_0)
	arg_18_0:RemoveAllEventListener()

	for iter_18_0, iter_18_1 in pairs(arg_18_0.pages_) do
		if iter_18_1 ~= nil then
			iter_18_1:OnExit()
		end
	end

	arg_18_0:UnbindRedPoint()
	manager.windowBar:HideBar()
end

function var_0_0.BindRedPoint(arg_19_0)
	manager.redPoint:bindUIandKey(arg_19_0.recalledBtn_.transform, RedPointConst.RECALL_SIGN, {
		x = 160,
		y = 45
	})
	manager.redPoint:bindUIandKey(arg_19_0.recallBtn_.transform, RedPointConst.RECALL_REWARD, {
		x = 160,
		y = 45
	})
	manager.redPoint:bindUIandKey(arg_19_0.missionBtn_.transform, RedPointConst.RECALL_TASK, {
		x = 160,
		y = 45
	})
end

function var_0_0.UnbindRedPoint(arg_20_0)
	manager.redPoint:unbindUIandKey(arg_20_0.recalledBtn_.transform, RedPointConst.RECALL_SIGN)
	manager.redPoint:unbindUIandKey(arg_20_0.recallBtn_.transform, RedPointConst.RECALL_REWARD)
	manager.redPoint:unbindUIandKey(arg_20_0.missionBtn_.transform, RedPointConst.RECALL_TASK)
end

function var_0_0.Dispose(arg_21_0)
	if arg_21_0.pages_ then
		for iter_21_0, iter_21_1 in pairs(arg_21_0.pages_) do
			iter_21_1:Dispose()
		end

		arg_21_0.pages_ = nil
	end

	var_0_0.super.Dispose(arg_21_0)
end

return var_0_0
