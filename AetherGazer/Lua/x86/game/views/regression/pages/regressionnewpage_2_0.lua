local var_0_0 = class("RegressionNewPage_2_0", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	local var_1_0 = Asset.Load("Widget/System/ReturnTwo/RT2stAdd2UI")
	local var_1_1 = Object.Instantiate(var_1_0, arg_1_1)

	arg_1_0.gameObject_ = var_1_1
	arg_1_0.transform_ = var_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.drawPoolBtn_, nil, function()
		if arg_4_0.drawCfg_ then
			local var_5_0 = arg_4_0.drawCfg_[2]

			if not ActivityData:GetActivityIsOpen(var_5_0) then
				ShowTips("REGRESSION_JUMP")

				return
			end

			local var_5_1 = ActivityDrawPoolCfg[var_5_0].config_list[1]

			JumpTools.GoToSystem("/draw", {
				poolId = var_5_1
			}, ViewConst.SYSTEM_ID.DRAW)
		end
	end)
	arg_4_0:AddBtnListener(arg_4_0.plotBtn_, nil, function()
		local var_6_0 = arg_4_0.plotCfg_[2]

		if not ActivityData:GetActivityIsOpen(var_6_0) then
			ShowTips("REGRESSION_JUMP")

			return
		end

		ChapterTools.GotoChapterStagePage(arg_4_0.plotList_)
	end)
	arg_4_0:AddBtnListener(arg_4_0.progressBtn_, nil, function()
		ChapterTools.GotoMaxChapterClient()
	end)
end

function var_0_0.SetActive(arg_8_0, arg_8_1)
	SetActive(arg_8_0.gameObject_, arg_8_1)
end

function var_0_0.SetData(arg_9_0)
	arg_9_0.drawActivityList_ = {}
	arg_9_0.plotList_ = {}

	local var_9_0 = GameSetting.regression_jump.value

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		if iter_9_1[1] == 3 then
			if ActivityData:GetActivityIsOpen(iter_9_1[2]) == true then
				arg_9_0.drawActivityList_[#arg_9_0.drawActivityList_ + 1] = iter_9_1
			end
		elseif iter_9_1[1] == 4 then
			arg_9_0.progressCfg_ = iter_9_1
		elseif ActivityData:GetActivityIsOpen(iter_9_1[2]) == true then
			arg_9_0.plotList_[#arg_9_0.plotList_ + 1] = iter_9_1
		end
	end

	arg_9_0:RefreshDrawUI()
	arg_9_0:RefreshPlotUI()
	arg_9_0:RefreshProgressUI()
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)
	Object.Destroy(arg_10_0.gameObject_)

	arg_10_0.transform_ = nil
	arg_10_0.gameObject_ = nil
end

function var_0_0.UpdateBar(arg_11_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.RefreshDrawUI(arg_12_0)
	if #arg_12_0.drawActivityList_ > 0 then
		SetActive(arg_12_0.drawItemGo_, true)

		local var_12_0 = 1

		for iter_12_0, iter_12_1 in ipairs(arg_12_0.drawActivityList_) do
			if ActivityData:GetActivityIsOpen(iter_12_1[2]) == true then
				var_12_0 = iter_12_0
			end
		end

		arg_12_0.drawCfg_ = arg_12_0.drawActivityList_[var_12_0]

		local var_12_1 = MainAdvinfoCfg[arg_12_0.drawCfg_[3]].picture

		arg_12_0.drawIcon_.sprite = pureGetSpriteWithoutAtlas("I18NImg/Banner/" .. var_12_1 .. SettingData:GetCurrentLanguageKey())
	else
		SetActive(arg_12_0.drawItemGo_, false)
	end
end

function var_0_0.RefreshPlotUI(arg_13_0)
	if #arg_13_0.plotList_ > 0 then
		SetActive(arg_13_0.plotItemGo_, true)

		local var_13_0 = ChapterTools.GetActivityChapterIndex(arg_13_0.plotList_)

		arg_13_0.plotCfg_ = arg_13_0.plotList_[var_13_0]
		arg_13_0.plotIcon_.sprite = getSpriteViaConfig("ActivityBannerTextures", arg_13_0.plotCfg_[4] .. SettingData:GetCurrentLanguageKey())
	else
		SetActive(arg_13_0.plotItemGo_, false)
	end
end

function var_0_0.RefreshProgressUI(arg_14_0)
	arg_14_0.progressIcon_.sprite = pureGetSpriteWithoutAtlas("TextureBg/ReturnTwo/" .. arg_14_0.progressCfg_[3])
end

return var_0_0
