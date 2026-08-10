local var_0_0 = class("IdolCompetitionSignSelectView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/Competition/IdolCompetitionSelUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.saveClick_ = nil
	arg_4_0.infoPage_ = IdolTraineeTrainInfoPage.New(arg_4_0.heroInfoSubView_)
	arg_4_0.heroList_ = {}
	arg_4_0.selected_ = {}
	arg_4_0.curHeroID_ = 0
	arg_4_0.curHeroIndex_ = 0
	arg_4_0.heroUIList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.heroListGo_, IdolTraineeHeadItem)
	arg_4_0.stageInfoPage = IdolTraineeStageInfoPage.New(arg_4_0.stageInfo)

	arg_4_0.stageInfoPage:ShowPage(true)

	arg_4_0.lockController_ = arg_4_0.mainControllerEx_:GetController("lock")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.saveBtn_, nil, function()
		if arg_5_0.curHeroID_ ~= arg_5_0.params_.info.heroID and arg_5_0.selected_[arg_5_0.curHeroID_] then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("IDOL_COMPETITION_SELECTED_CONFLICT"),
				OkCallback = function()
					if arg_5_0.saveClick_ then
						arg_5_0.saveClick_(arg_5_0.curHeroID_)
					end

					arg_5_0:Back()
				end,
				CancelCallback = function()
					return
				end
			})

			return
		end

		if arg_5_0.saveClick_ then
			arg_5_0.saveClick_(arg_5_0.curHeroID_)
		end

		arg_5_0:Back()
	end)
end

function var_0_0.IndexItem(arg_9_0, arg_9_1, arg_9_2)
	arg_9_2:SetData(arg_9_0.heroList_[arg_9_1], arg_9_0.curHeroID_, function()
		if arg_9_0.curHeroID_ ~= 0 and arg_9_0.curHeroIndex_ ~= 0 then
			local var_10_0 = arg_9_0.heroUIList_:GetItemByIndex(arg_9_0.curHeroIndex_)

			if var_10_0 then
				var_10_0:SelectOff()
			end
		end

		arg_9_0.curHeroIndex_ = arg_9_1

		arg_9_2:SelectOn()
		arg_9_0:UpdateView(arg_9_0.heroList_[arg_9_1])
	end, {
		competitionSel = arg_9_0.selected_[arg_9_0.heroList_[arg_9_1]]
	})
end

function var_0_0.OnEnter(arg_11_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	IdolTraineeCampBridge.SetVCamActive("CamShootAtTrainningPos", true)

	arg_11_0.saveClick_ = arg_11_0.params_.onClick
	arg_11_0.heroList_ = IdolTraineeData:GetIdolHeroList(true) or {}

	table.sort(arg_11_0.heroList_, function(arg_12_0, arg_12_1)
		if HeroTools.GetHeroIsUnlock(arg_12_0) and HeroTools.GetHeroIsUnlock(arg_12_1) then
			local var_12_0 = 0
			local var_12_1 = 0

			for iter_12_0, iter_12_1 in ipairs(IdolTraineeData:GetIdolHeroData(arg_12_0)) do
				var_12_0 = var_12_0 + iter_12_1
			end

			for iter_12_2, iter_12_3 in ipairs(IdolTraineeData:GetIdolHeroData(arg_12_1)) do
				var_12_1 = var_12_1 + iter_12_3
			end

			return var_12_1 < var_12_0
		elseif HeroTools.GetHeroIsUnlock(arg_12_0) then
			return true
		elseif HeroTools.GetHeroIsUnlock(arg_12_1) then
			return false
		else
			return arg_12_0 < arg_12_1
		end
	end)

	arg_11_0.curHeroID_ = arg_11_0.params_.info.heroID
	arg_11_0.selected_ = arg_11_0.params_.selected or {}

	if arg_11_0.curHeroID_ == 0 then
		arg_11_0.curHeroID_ = arg_11_0.heroList_[1]
		arg_11_0.curHeroIndex_ = 1
	else
		arg_11_0.curHeroIndex_ = table.keyof(arg_11_0.heroList_, arg_11_0.curHeroID_)
	end

	arg_11_0.infoPage_:RegisterEvents()
	arg_11_0:UpdateView(arg_11_0.curHeroID_)
	arg_11_0.heroUIList_:StartScroll(#arg_11_0.heroList_)
	arg_11_0.stageInfoPage:SetParams({
		pvpBattle = false,
		idolCompetition = true,
		stageID = arg_11_0.params_.info.stageID
	})
	arg_11_0.stageInfoPage:OnEnter()
end

function var_0_0.UpdateView(arg_13_0, arg_13_1)
	arg_13_0.curHeroID_ = arg_13_1

	local var_13_0 = IdolTraineeTools:GetHeroBattleInfoTemplate(arg_13_0.curHeroID_)

	arg_13_0.infoPage_:RefreshUI(var_13_0)

	if HeroTools.GetHeroIsUnlock(arg_13_1) then
		arg_13_0.lockController_:SetSelectedState("false")
	else
		arg_13_0.lockController_:SetSelectedState("true")
	end
end

function var_0_0.OnExit(arg_14_0)
	arg_14_0.infoPage_:RemoveAllEventListener()
	manager.windowBar:HideBar()
	IdolTraineeCampBridge.SetVCamActive("CamShootAtTrainningPos", false)
end

function var_0_0.Dispose(arg_15_0)
	if arg_15_0.heroUIList_ then
		arg_15_0.heroUIList_:Dispose()

		arg_15_0.heroUIList_ = nil
	end

	if arg_15_0.infoPage_ then
		arg_15_0.infoPage_:Dispose()

		arg_15_0.infoPage_ = nil
	end

	if arg_15_0.stageInfoPage then
		arg_15_0.stageInfoPage:Dispose()

		arg_15_0.stageInfoPage = nil
	end

	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0
