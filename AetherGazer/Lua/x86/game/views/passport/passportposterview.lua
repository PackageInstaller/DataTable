local var_0_0 = class("PassportPosterView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Passport/PassportPosterUI"
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

	arg_4_0.items_ = {}

	if arg_4_0.itemGo1_ then
		local var_4_0 = CommonItemView.New(arg_4_0.itemGo1_)

		table.insert(arg_4_0.items_, {
			item = var_4_0,
			data = clone(ItemTemplateData)
		})
	end

	if arg_4_0.itemGo2_ then
		local var_4_1 = CommonItemView.New(arg_4_0.itemGo2_)

		table.insert(arg_4_0.items_, {
			item = var_4_1,
			data = clone(ItemTemplateData)
		})
	end

	if arg_4_0.itemGo3_ then
		local var_4_2 = CommonItemView.New(arg_4_0.itemGo3_)

		table.insert(arg_4_0.items_, {
			item = var_4_2,
			data = clone(ItemTemplateData)
		})
	end

	if arg_4_0.itemGo4_ then
		local var_4_3 = CommonItemView.New(arg_4_0.itemGo4_)

		table.insert(arg_4_0.items_, {
			item = var_4_3,
			data = clone(ItemTemplateData)
		})
	end

	if arg_4_0.itemGo5_ then
		local var_4_4 = CommonItemView.New(arg_4_0.itemGo5_)

		table.insert(arg_4_0.items_, {
			item = var_4_4,
			data = clone(ItemTemplateData)
		})
	end

	if arg_4_0.itemGo6_ then
		local var_4_5 = CommonItemView.New(arg_4_0.itemGo6_)

		table.insert(arg_4_0.items_, {
			item = var_4_5,
			data = clone(ItemTemplateData)
		})
	end
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.bgBtn_, nil, function()
		arg_5_0:Back()
	end)

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.items_) do
		function iter_5_1.data.clickFun(arg_7_0)
			ShowPopItem(POP_OTHER_ITEM, {
				arg_7_0.id,
				arg_7_0.number
			})
		end
	end
end

function var_0_0.UpdateBar(arg_8_0)
	return
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0.dataList_ = BattlePassListCfg[PassportData:GetId()].display_reward_01

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.items_) do
		if arg_9_0.dataList_[iter_9_0] then
			SetActive(arg_9_0["itemGo" .. iter_9_0 .. "_"], true)
			CommonTools.SetCommonData(iter_9_1.item, {
				id = arg_9_0.dataList_[iter_9_0][1],
				number = arg_9_0.dataList_[iter_9_0][2] > 1 and arg_9_0.dataList_[iter_9_0][2] or nil
			}, iter_9_1.data)
		else
			SetActive(arg_9_0["itemGo" .. iter_9_0 .. "_"], false)
		end
	end

	local var_9_0 = PassportData:GetId()

	if BattlePassListCfg[var_9_0].battlepass_type >= 17 then
		arg_9_0.rewardTxt_.text = GetTips("BATTLEPASS_REWARD_TIPS_BANNER")
		arg_9_0.rewardTitleTxt_.text = GetTips("BATTLEPASS_REWARD_TIPS_TITLE")
	end

	arg_9_0.bgImg_.sprite = pureGetSpriteWithoutAtlas(BattlePassListCfg[PassportData:GetId()].poster_ui)
	arg_9_0.titleImg_.sprite = pureGetSpriteWithoutAtlas(BattlePassListCfg[PassportData:GetId()].slogan_ui)
end

function var_0_0.OnExit(arg_10_0)
	return
end

function var_0_0.OnTop(arg_11_0)
	arg_11_0:UpdateBar()
end

function var_0_0.Cacheable(arg_12_0)
	return false
end

function var_0_0.OnExitInput(arg_13_0)
	JumpTools.Back()

	return true
end

function var_0_0.Dispose(arg_14_0)
	if arg_14_0.items_ then
		for iter_14_0, iter_14_1 in pairs(arg_14_0.items_) do
			iter_14_1.item:Dispose()
		end

		arg_14_0.items_ = nil
	end

	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
