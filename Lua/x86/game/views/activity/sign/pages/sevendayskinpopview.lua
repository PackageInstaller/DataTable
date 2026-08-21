local var_0_0 = class("SevenDaySkinPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/SevenSignSkin/XH3rdSevenPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()

	arg_3_0.items = {}
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0.gameObject_:InjectUI(arg_4_0)
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.BtnMask, nil, handler(arg_5_0, arg_5_0.OpenRewardUI))
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0.msg = arg_6_0.params_.msg
	arg_6_0.reward = arg_6_0.params_.reward

	arg_6_0:RefreshView()
end

function var_0_0.RefreshView(arg_7_0)
	arg_7_0.TxtContent.text = GetTips(arg_7_0.msg.body)
	arg_7_0.TxtName.text = GetTips(arg_7_0.msg.author)

	arg_7_0.Ctrl:SetSelectedState(arg_7_0.msg.name)
end

function var_0_0.OnExit(arg_8_0)
	return
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)
end

function var_0_0.OpenRewardUI(arg_10_0)
	arg_10_0.Back()

	if arg_10_0.reward[1][1] == 1042051 then
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = string.format(GetTips("USE_SKIN_CHANGE"), ItemTools.getItemName(1042051)),
			OkCallback = function()
				CommonAction.TryToUseItem({
					{
						item_info = {
							id = 1042051,
							num = 1
						},
						use_list = {}
					}
				})
			end,
			MaskCallback = function()
				getReward(formatRewardCfgList(arg_10_0.reward))
			end,
			CancelCallback = function()
				getReward(formatRewardCfgList(arg_10_0.reward))
			end
		})
	else
		getReward(formatRewardCfgList(arg_10_0.reward))
	end
end

return var_0_0
