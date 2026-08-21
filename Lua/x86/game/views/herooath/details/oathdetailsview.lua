local var_0_0 = class("OathDetailsView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Hero_Oath/OathDetailsView/HeroOathDetailsViewUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.changeBtn_, nil, function()
		local var_5_0

		if arg_4_0.selectModeState == arg_4_0.staticContext.task.state then
			var_5_0 = arg_4_0.staticContext.detail.state
		else
			var_5_0 = arg_4_0.staticContext.task.state
		end

		arg_4_0:UpdateContentShow(var_5_0)
	end)
	arg_4_0:AddBtnListener(arg_4_0.goTaskBtn_, nil, function()
		arg_4_0:UpdateContentShow(arg_4_0.staticContext.task.state)
	end)
	arg_4_0:AddBtnListener(arg_4_0.closeTaskBtn_, nil, function()
		arg_4_0:UpdateContentShow(arg_4_0.staticContext.detail.state)
	end)
end

function var_0_0.InitUI(arg_8_0)
	arg_8_0:BindCfgUI()
	arg_8_0:AddListeners()

	arg_8_0.modecontroller_ = arg_8_0.controller_:GetController("mode")
	arg_8_0.lvInfo_ = OathLvInfo.New(arg_8_0.lvGo_)
	arg_8_0.taskContent_ = OathDetailsTaskContent.New(arg_8_0.taskContentGo_)
	arg_8_0.collectionContent = OathCollectionContentView.New(arg_8_0.collectionContentGo_)
	arg_8_0.staticContext = {
		task = {
			state = "task",
			entity = arg_8_0.taskContent_
		},
		detail = {
			state = "detail",
			entity = arg_8_0.collectionContent
		}
	}
end

function var_0_0.AddEventListeners(arg_9_0)
	arg_9_0:RegistEventListener(OATH_HERO_LEVEL_UP, handler(arg_9_0, arg_9_0.CheckHeroOathLevelUp))
end

function var_0_0.CheckHeroOathLevelUp(arg_10_0)
	local var_10_0, var_10_1 = OathCollectionContentData:HasNewLevelUpdateMsg(arg_10_0.selectHeroID)

	if var_10_1 then
		JumpTools.OpenPageByJump("oathLevelUpPop", {
			heroID = var_10_0,
			level = var_10_1
		})
	end
end

function var_0_0.GetIsHaveTaskUnFinish(arg_11_0)
	local var_11_0, var_11_1 = OathAssignmentData:GetOathAssignmentHeroLevelProgress(arg_11_0.heroID, 1)

	if var_11_0 < var_11_1 then
		return true
	else
		local var_11_2, var_11_3 = OathAssignmentData:GetOathAssignmentHeroLevelProgress(arg_11_0.heroID, 2)

		if var_11_3 > var_11_2 then
			return true
		end
	end

	return false
end

function var_0_0.DefaultSelect(arg_12_0)
	local var_12_0

	if not gameContext:IsRouteBack() then
		if arg_12_0.params_ and arg_12_0.params_.selectModeState then
			var_12_0, arg_12_0.params_.selectModeState = arg_12_0.params_.selectModeState
		else
			var_12_0 = arg_12_0.staticContext.detail.state
		end
	end

	if var_12_0 == nil then
		if arg_12_0.modecontroller_:GetSelectedState() == "task" then
			var_12_0 = arg_12_0.staticContext.task.state
		else
			var_12_0 = arg_12_0.staticContext.detail.state
		end
	end

	arg_12_0:UpdateContentShow(var_12_0)
	arg_12_0:UpdateHeroInfoUI()
end

function var_0_0.UpdateContentShow(arg_13_0, arg_13_1)
	local var_13_0
	local var_13_1

	var_13_1, arg_13_0.selectModeState = arg_13_0.selectModeState, arg_13_1

	arg_13_0.modecontroller_:SetSelectedState(arg_13_1)

	for iter_13_0, iter_13_1 in pairs(arg_13_0.staticContext) do
		if iter_13_1.state == var_13_1 and iter_13_1.entity then
			iter_13_1.entity:OnHide()
		end

		if iter_13_1.state == arg_13_1 and iter_13_1.entity then
			iter_13_1.entity:RefreshUI(arg_13_0.heroID)
			iter_13_1.entity:OnShow()
		end
	end

	arg_13_0:RefreshBar()
end

function var_0_0.UpdateHeroInfoUI(arg_14_0)
	arg_14_0.nameText_.text = HeroTools.GetHeroName(arg_14_0.heroID)
end

function var_0_0.OnEnter(arg_15_0)
	arg_15_0:AddEventListeners()

	arg_15_0.heroID = arg_15_0.params_.heroID

	for iter_15_0, iter_15_1 in pairs(arg_15_0.staticContext) do
		if iter_15_1.entity and iter_15_1.entity.OnEnter then
			iter_15_1.entity:OnEnter(arg_15_0.params_)
		end
	end

	arg_15_0:DefaultSelect()
	arg_15_0.lvInfo_:SetData(arg_15_0.heroID)

	arg_15_0.heroImg_.sprite = OathTools.GetOathCharacterSprite(arg_15_0.heroID)

	arg_15_0:CheckHeroOathLevelUp()
	manager.redPoint:bindUIandKey(arg_15_0.goTaskBtn_.transform, RedPointConst.OATH_TASK_FINISH .. arg_15_0.heroID)
end

function var_0_0.OnTop(arg_16_0)
	arg_16_0:RefreshBar()
end

function var_0_0.OnWinStoryEnd(arg_17_0)
	if gameContext:GetLastOpenPageHandler() == arg_17_0 then
		arg_17_0:RefreshBar()
	end
end

function var_0_0.OnBehind(arg_18_0)
	manager.windowBar:HideBar()
end

function var_0_0.RefreshBar(arg_19_0)
	if arg_19_0.selectModeState == arg_19_0.staticContext.detail.state then
		manager.windowBar:SwitchBar({
			BACK_BAR
		})
	elseif arg_19_0.selectModeState == arg_19_0.staticContext.task.state then
		manager.windowBar:SwitchBar({})
	end
end

function var_0_0.OnExit(arg_20_0)
	manager.redPoint:unbindUIandKey(arg_20_0.goTaskBtn_.transform, RedPointConst.OATH_TASK_FINISH .. arg_20_0.heroID)

	for iter_20_0, iter_20_1 in pairs(arg_20_0.staticContext) do
		if iter_20_1.entity and iter_20_1.entity.OnExit then
			iter_20_1.entity:OnExit()
		end
	end

	arg_20_0.lvInfo_:OnExit()
	manager.windowBar:HideBar()
	arg_20_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_21_0)
	for iter_21_0, iter_21_1 in pairs(arg_21_0.staticContext) do
		if iter_21_1.entity and iter_21_1.entity.Dispose then
			iter_21_1.entity:Dispose()

			iter_21_1.entity = nil
		end
	end

	if arg_21_0.lvInfo_ then
		arg_21_0.lvInfo_:Dispose()

		arg_21_0.lvInfo_ = nil
	end

	arg_21_0.super.Dispose(arg_21_0)
end

return var_0_0
