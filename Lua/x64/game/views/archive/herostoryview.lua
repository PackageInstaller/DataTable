local var_0_0 = class("HeroStoryView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/HeroArchive/ArchiveStoryUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.itemInstance_ = {}

	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.controller_ = ControllerUtil.GetController(arg_4_0.transform_, "conName")
end

function var_0_0.AddUIListener(arg_5_0)
	return
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0:ShowDefaultBar()
	manager.ui:SetMainCamera("hero")

	arg_6_0.heroID_ = arg_6_0.params_.heroID
	arg_6_0.archiveID_ = HeroTools.GetHeroOntologyID(arg_6_0.heroID_)

	if #HeroRecordCfg[arg_6_0.archiveID_].plot_id > 1 then
		arg_6_0.controller_:SetSelectedState("unlock")

		arg_6_0.itemList_ = HeroRecordCfg[arg_6_0.archiveID_].plot_id
		arg_6_0.picImg_.sprite = getSpriteViaConfig("HeroIcon", arg_6_0.heroID_)

		for iter_6_0 = 1, #arg_6_0.itemList_ do
			local var_6_0 = arg_6_0["itemGo_" .. iter_6_0]

			if not arg_6_0.itemInstance_[iter_6_0] then
				arg_6_0.itemInstance_[iter_6_0] = HeroArchiveStoryItem.New(var_6_0)
			end

			arg_6_0.itemInstance_[iter_6_0]:RefreshUI(iter_6_0, arg_6_0.archiveID_)
		end
	else
		arg_6_0.controller_:SetSelectedState("lock")
	end
end

function var_0_0.OnExit(arg_7_0)
	manager.windowBar:HideBar()
	manager.ui:ResetMainCamera()

	local var_7_0 = arg_7_0:GetStayTime()

	OperationRecorder.RecordStayView("STAY_VIEW_HERO_STORY", var_7_0, arg_7_0.heroID_)
end

function var_0_0.Dispose(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0.itemInstance_) do
		iter_8_1:Dispose()
	end

	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
