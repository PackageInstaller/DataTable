ActivityRewardItemBase = import("game.views.activity.Submodule.destroyBoxGame.rewardBase.ActivityRewardItemBase")

local var_0_0 = class("DestroyBoxGameRewardItem", ActivityRewardItemBase)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.list_ = LuaList.New(handler(arg_1_0, arg_1_0.IndexItem), arg_1_0.uiListGo_, CommonItemView)
	arg_1_0.buttonController = ControllerUtil.GetController(arg_1_0.transform_, "status")
end

function var_0_0.SetData(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.index_ = arg_2_2

	arg_2_0:Show(true)

	arg_2_0.rewardID_ = arg_2_1

	local var_2_0 = DestroyBoxGameRewardCfg[arg_2_1]

	arg_2_0.descText_.text = string.format(var_2_0.desc, var_2_0.complete_num)
	arg_2_0.rewardList_ = var_2_0 and var_2_0.item_list or {}

	arg_2_0.list_:StartScroll(#arg_2_0.rewardList_)

	if table.keyof(DestroyBoxGameData:GetReceiveRewardList(var_2_0.main_activity_id), arg_2_1) then
		arg_2_0.buttonController:SetSelectedState("haveGet")
	elseif DestroyBoxGameTools.IsUnlockReward(arg_2_1) then
		arg_2_0.buttonController:SetSelectedState("canGet")
	else
		arg_2_0.buttonController:SetSelectedState("unFinish")
	end
end

function var_0_0.Dispose(arg_3_0)
	arg_3_0.list_:Dispose()

	arg_3_0.list_ = nil

	var_0_0.super.Dispose(arg_3_0)
	Object.Destroy(arg_3_0.gameObject_)

	arg_3_0.transform_ = nil
	arg_3_0.gameObject_ = nil
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.getBtn_, nil, function()
		local var_5_0 = DestroyBoxGameRewardCfg[arg_4_0.rewardID_]

		DestroyBoxGameAction.RequestReward(var_5_0.main_activity_id, {
			arg_4_0.rewardID_
		}, function()
			manager.notify:Invoke(ACTIVITY_REWARD_REFRESH)
		end)
	end)
end

function var_0_0.IndexItem(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0.rewardList_[arg_7_1]
	local var_7_1 = clone(ItemTemplateData)

	var_7_1.id = var_7_0[1]
	var_7_1.number = var_7_0[2]

	function var_7_1.clickFun(arg_8_0)
		ShowPopItem(POP_ITEM, var_7_0)
	end

	arg_7_2:SetData(var_7_1)
end

function var_0_0.Update(arg_9_0)
	arg_9_0:SetData(arg_9_0.rewardID_, arg_9_0.index_)
end

return var_0_0
