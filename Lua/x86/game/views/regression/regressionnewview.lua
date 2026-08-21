local var_0_0 = import("game.views.regression.RegressionView")
local var_0_1 = class("RegressionNewView", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "Widget/System/ReturnTwo/RT2stBackflowNavigationUI"
end

function var_0_1.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()

	arg_2_0.pageClass = {
		RegressionSignNewPage,
		RegressionTaskNewPage,
		RegressionCapsuleToysPage,
		RegressionSupplyPage,
		RegressionBPTaskPage,
		RegressionNewPage_2_0
	}
	arg_2_0.needEnterAnim_ = {
		[2] = true,
		[5] = true
	}
	arg_2_0.needExitAnim_ = {
		true,
		nil,
		true,
		true,
		nil,
		true
	}
	arg_2_0.playAnimTypeConst_ = {
		EXIT = 2,
		ENTER = 1
	}
	arg_2_0.animConst_ = {
		[1] = "Fx_adron_cx",
		[2] = "Fx_adron_xs"
	}
	arg_2_0.animation_ = arg_2_0.animPanelGo_:GetComponent("Animation")
	arg_2_0.lastPlayType_ = -1
end

function var_0_1.AddUIListener(arg_3_0)
	arg_3_0:RegistEventListener(SHOP_LIST_UPDATE, function(arg_4_0)
		arg_3_0:ShopRefresh()
	end)
	arg_3_0:RegistEventListener(SHOP_REFRESH_ALL_SHOP, function(arg_5_0)
		if arg_3_0.curPage then
			arg_3_0.curPage:SetData()
		end
	end)
	arg_3_0:RegistEventListener(SHOP_ITEM_UPDATE, function(arg_6_0, arg_6_1)
		arg_3_0:ShopRefresh()
	end)
end

function var_0_1.OnTop(arg_7_0)
	arg_7_0.curPage:UpdateBar()
end

function var_0_1.OnEnter(arg_8_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	if arg_8_0.params_.selectIndex then
		arg_8_0.tree:SelectGroup(arg_8_0.params_.selectIndex)

		arg_8_0.params_.selectIndex = nil
		arg_8_0.params_.Inited = true
	elseif arg_8_0.params_.isBack == true then
		local var_8_0 = arg_8_0.params_.lastIndex
		local var_8_1 = arg_8_0.params_.lastItemIndex

		arg_8_0.selectIndex = -1
		arg_8_0.selectItemIndex = -1

		if var_8_1 > 0 then
			arg_8_0.tree:SelectItem(var_8_0, var_8_1)
		else
			arg_8_0.tree:SelectGroup(var_8_0)
		end
	elseif not arg_8_0.params_.Inited then
		arg_8_0.params_.Inited = true
		arg_8_0.selectIndex = -1
		arg_8_0.selectItemIndex = -1

		arg_8_0.tree:SelectGroup(1)
	end

	manager.redPoint:bindUIandKey(arg_8_0.tree:GetGroupRedPointContainerById(1), RedPointConst.REGRESSION_SIGN)
	manager.redPoint:bindUIandKey(arg_8_0.tree:GetGroupRedPointContainerById(2), RedPointConst.REGRESSION_TASK)
	manager.redPoint:bindUIandKey(arg_8_0.tree:GetItemRedPointContainerById(2, 201), string.format("%s_%s", RedPointConst.REGRESSION_TASK, TaskConst.TASK_TYPE.REGRESSION_DAILY))
	manager.redPoint:bindUIandKey(arg_8_0.tree:GetItemRedPointContainerById(2, 202), string.format("%s_%s", RedPointConst.REGRESSION_TASK, TaskConst.TASK_TYPE.REGRESSION_WEEK))
	manager.redPoint:bindUIandKey(arg_8_0.tree:GetItemRedPointContainerById(2, 203), string.format("%s_%s", RedPointConst.REGRESSION_TASK, TaskConst.TASK_TYPE.REGRESSION_CHALLENGE))
	manager.redPoint:bindUIandKey(arg_8_0.tree:GetGroupRedPointContainerById(4), RedPointConst.REGRESSION_SUPPLY_FREE)
	manager.redPoint:bindUIandKey(arg_8_0.tree:GetGroupRedPointContainerById(5), RedPointConst.REGRESSION_BP)
	arg_8_0:RefreshTime()

	arg_8_0.timer = Timer.New(function()
		arg_8_0:RefreshTime()
	end, 1, -1)

	arg_8_0.timer:Start()
end

function var_0_1.OnExit(arg_10_0)
	manager.windowBar:HideBar()

	arg_10_0.params_.lastIndex = arg_10_0.selectIndex
	arg_10_0.params_.lastItemIndex = arg_10_0.selectItemIndex

	arg_10_0:RemoveAllEventListener()
	manager.redPoint:unbindUIandKey(arg_10_0.tree:GetGroupRedPointContainerById(1), RedPointConst.REGRESSION_SIGN)
	manager.redPoint:unbindUIandKey(arg_10_0.tree:GetGroupRedPointContainerById(2), RedPointConst.REGRESSION_TASK)
	manager.redPoint:unbindUIandKey(arg_10_0.tree:GetItemRedPointContainerById(2, 201), string.format("%s_%s", RedPointConst.REGRESSION_TASK, TaskConst.TASK_TYPE.REGRESSION_DAILY))
	manager.redPoint:unbindUIandKey(arg_10_0.tree:GetItemRedPointContainerById(2, 202), string.format("%s_%s", RedPointConst.REGRESSION_TASK, TaskConst.TASK_TYPE.REGRESSION_WEEK))
	manager.redPoint:unbindUIandKey(arg_10_0.tree:GetItemRedPointContainerById(2, 203), string.format("%s_%s", RedPointConst.REGRESSION_TASK, TaskConst.TASK_TYPE.REGRESSION_CHALLENGE))
	manager.redPoint:unbindUIandKey(arg_10_0.tree:GetGroupRedPointContainerById(4), RedPointConst.REGRESSION_SUPPLY_FREE)
	manager.redPoint:unbindUIandKey(arg_10_0.tree:GetGroupRedPointContainerById(5), RedPointConst.REGRESSION_BP)

	if arg_10_0.timer then
		arg_10_0.timer:Stop()

		arg_10_0.timer = nil
	end

	if arg_10_0.curPage and arg_10_0.curPage.OnExit then
		arg_10_0.curPage:OnExit()
		arg_10_0.curPage:SetActive(false)
	end

	arg_10_0.lastPlayType_ = -1
end

function var_0_1.OnGroupSelect(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	if arg_11_1 == arg_11_0.selectIndex then
		return
	end

	arg_11_0:SetSelectPage(arg_11_1, nil)
end

function var_0_1.OnItemSelect(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	arg_12_0.selectItemIndex = arg_12_1

	arg_12_0.curPage:SetData(arg_12_2)
end

function var_0_1.SetSelectPage(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0.selectIndex = arg_13_1
	arg_13_0.selectItemIndex = -1

	if arg_13_0.curPage then
		arg_13_0.curPage:SetActive(false)
	end

	if not arg_13_0.pages[arg_13_1] then
		arg_13_0.pages[arg_13_1] = arg_13_0.pageClass[arg_13_1].New(arg_13_0.m_content)
	end

	arg_13_0.curPage = arg_13_0.pages[arg_13_1]

	local var_13_0 = arg_13_0.params_.isBack

	if arg_13_0.params_.isBack == true then
		if arg_13_0.curPage.SetIsBack then
			arg_13_0.curPage:SetIsBack(arg_13_0.params_.isBack)
		end

		arg_13_0.params_.isBack = false
	end

	arg_13_0.curPage:SetData(arg_13_2)
	arg_13_0.curPage:SetActive(true)
	arg_13_0.curPage:UpdateBar()
	arg_13_0:PlayAnim(var_13_0)
end

function var_0_1.PlayAnim(arg_14_0, arg_14_1)
	local var_14_0 = false
	local var_14_1 = -1

	if arg_14_0.params_.isEnter == true then
		if arg_14_0.needExitAnim_[arg_14_0.selectIndex] == true then
			var_14_0 = false
			var_14_1 = arg_14_0.playAnimTypeConst_.EXIT
		elseif arg_14_0.needEnterAnim_[arg_14_0.selectIndex] == true then
			var_14_0 = true
			var_14_1 = arg_14_0.playAnimTypeConst_.ENTER
			arg_14_0.params_.isEnter = false
		end
	elseif arg_14_0.needEnterAnim_[arg_14_0.selectIndex] == true and arg_14_0.lastPlayType_ ~= arg_14_0.playAnimTypeConst_.ENTER then
		var_14_1 = arg_14_0.playAnimTypeConst_.ENTER
		var_14_0 = true
	elseif arg_14_0.needExitAnim_[arg_14_0.selectIndex] == true and arg_14_0.lastPlayType_ ~= arg_14_0.playAnimTypeConst_.EXIT then
		var_14_1 = arg_14_0.playAnimTypeConst_.EXIT

		if not arg_14_1 then
			var_14_0 = true
		end
	end

	SetActive(arg_14_0.animPanelGo_, var_14_0)

	if var_14_0 == true and var_14_1 ~= -1 then
		arg_14_0.lastPlayType_ = var_14_1

		arg_14_0.animation_:Play(arg_14_0.animConst_[var_14_1])
	end
end

return var_0_1
