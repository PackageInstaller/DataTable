local var_0_0 = class("BirthdayPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/UserInfor/BirthdayPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.backBtn_, nil, function()
		local var_6_0 = BirthdayCfg[#BirthdayCfg]
		local var_6_1 = BirthdayCfg[#BirthdayCfg].commemorative_props_id
		local var_6_2 = ItemCfg[var_6_1].name

		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = string.format(GetTips("BIRTHDAY_POP_BACK_TIPS"), var_6_2),
			OkCallback = function()
				arg_5_0:Back()
			end,
			CancelCallback = function()
				arg_5_0:Back()
			end
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.yesBtn_, nil, function()
		manager.posterGirl:SetViewTag(PosterGirlConst.ViewTag.null)
		manager.ui:SetMainCamera("null")

		local var_9_0 = BirthdayCfg[#BirthdayCfg].story_id

		manager.story:StartStoryById(var_9_0, function()
			arg_5_0:Back()

			local var_10_0 = gameContext:GetLastOpenPage()

			if var_10_0 == "home" then
				gameContext:GetOpenPageHandler(var_10_0):SetCamera()
			end
		end)
		IllustratedData:ModifyPlot(var_9_0)
	end)
end

function var_0_0.OnEnter(arg_11_0)
	BirthData:SetPopShowState(true)
	arg_11_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_12_0)
	arg_12_0.titleText_.text = GetTips("BIRTHDAY_POP_TITLE")
	arg_12_0.descText_.text = GetTips("BIRTHDAY_POP_DESC")
end

function var_0_0.Dispose(arg_13_0)
	Object.Destroy(arg_13_0.gameObject_)
	var_0_0.super.Dispose(arg_13_0)
end

function var_0_0.Cacheable(arg_14_0)
	return false
end

return var_0_0
