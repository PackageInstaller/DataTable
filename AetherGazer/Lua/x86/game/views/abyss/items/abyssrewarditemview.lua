local var_0_0 = class("AbyssRewardItemView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.uiList_ = LuaList.New(handler(arg_3_0, arg_3_0.indexItem), arg_3_0.uilistGo_, CommonItemView)
	arg_3_0.statusController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "status")
end

function var_0_0.indexItem(arg_4_0, arg_4_1, arg_4_2)
	CommonTools.SetCommonData(arg_4_2, {
		id = arg_4_0.cfg_.reward_list[arg_4_1][1],
		number = arg_4_0.cfg_.reward_list[arg_4_1][2],
		clickFun = function(arg_5_0)
			ShowPopItem(POP_ITEM, {
				arg_5_0.id,
				arg_5_0.number,
				0,
				arg_5_0.time_valid
			})
		end
	})
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.receivebtn_, nil, function()
		AbyssAction.GetLayerBonus({
			arg_6_0.id_
		})
	end)
end

function var_0_0.AddEventListeners(arg_8_0)
	return
end

function var_0_0.SetData(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.index_ = arg_9_1
	arg_9_0.id_ = arg_9_2
	arg_9_0.cfg_ = AbyssData:GetAbyssCfg(arg_9_2)

	arg_9_0:UpdateView()
end

function var_0_0.UpdateView(arg_10_0)
	if arg_10_0.id_ == #AbyssData:GetCurrentIdList() then
		arg_10_0.itemtext_.text = string.format(GetTips("ABYSS_LAYER_MAX_AWARD_TIP"), arg_10_0.id_)
	else
		arg_10_0.itemtext_.text = string.format(GetTips("ABYSS_LAYER_AWARD_TIP"), arg_10_0.id_)
	end

	arg_10_0.uiList_:StartScroll(#arg_10_0.cfg_.reward_list)

	if AbyssData:IsLayerBonusGet(arg_10_0.cfg_.level) then
		arg_10_0.statusController_:SetSelectedState("haveGet")
	elseif AbyssData:GetMaxLayer() >= arg_10_0.id_ then
		arg_10_0.statusController_:SetSelectedState("canGet")
	else
		arg_10_0.statusController_:SetSelectedState("cannotGet")
	end
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0:AddEventListeners()
end

function var_0_0.OnExit(arg_12_0)
	arg_12_0:RemoveAllEventListener()
end

function var_0_0.OnMainHomeViewTop(arg_13_0)
	return
end

function var_0_0.Dispose(arg_14_0)
	arg_14_0.data_ = nil

	if arg_14_0.uiList_ then
		arg_14_0.uiList_:Dispose()

		arg_14_0.uiList_ = nil
	end

	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
