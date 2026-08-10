local var_0_0 = class("SwitchHeroRewardView", RewardView)

function var_0_0.OnCtor(arg_1_0)
	var_0_0.super.OnCtor(arg_1_0)

	arg_1_0.timerList = {}
end

function var_0_0.InitUI(arg_2_0)
	var_0_0.super.InitUI(arg_2_0)

	arg_2_0.effctItem_ = Asset.Load("Widget/Common/Com_Prefab/ZhuanHuaAni")
end

local function var_0_1(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_2.idx == arg_3_1 then
		var_0_0.super.indexItem(arg_3_0, arg_3_1, arg_3_2)
	end
end

function var_0_0.indexItem(arg_4_0, arg_4_1, arg_4_2)
	arg_4_2.idx = arg_4_1

	local var_4_0 = arg_4_0.itemList_[arg_4_1]

	var_0_0.super.indexItem(arg_4_0, arg_4_1, arg_4_2)
end

function var_0_0.IsConvertAnimePlayed(arg_5_0, arg_5_1)
	return arg_5_0.timerList[arg_5_1] ~= nil
end

function var_0_0.PlayConvertAnime(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_0:IsConvertAnimePlayed(arg_6_1) then
		return false
	end

	local var_6_0 = arg_6_2:FindTrs("ZhuanHuaAni")

	if var_6_0 then
		SetActive(var_6_0.gameObject, false)
	end

	if not var_6_0 then
		local var_6_1 = Object.Instantiate(arg_6_0.effctItem_, arg_6_2.transform_)

		var_6_0 = var_6_1.transform
		var_6_1.name = "ZhuanHuaAni"

		SetActive(var_6_1, false)
	end

	SetActive(var_6_0.gameObject, true)

	var_6_0.localPosition = Vector3.New(127, -124, 0)

	var_6_0:GetComponent("Animator"):Play("CommonItem_zhuanhua", 0, 0)
	manager.audio:PlayEffect("ui_system_search", "search_itemTransform", "")

	return true
end

function var_0_0.AddTimer(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.timerList[arg_7_1] = arg_7_2
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0:RefreshUI(arg_8_0.params_.list)

	arg_8_0.callBack_ = arg_8_0.params_.callBack

	if not arg_8_0.params_.isBack then
		manager.audio:PlayEffect("ui_system_3_0", "ui_item_get", "")
	end
end

function var_0_0.AddUIListener(arg_9_0)
	arg_9_0:AddBtnListener(arg_9_0.bgBtn_, nil, function()
		if arg_9_0.params_.lateCallback then
			arg_9_0:StopTime()
			arg_9_0:Back(arg_9_0.callBack_)
		else
			arg_9_0:Back(arg_9_0.params_.callBack)
		end
	end)
end

function var_0_0.StopTime(arg_11_0)
	for iter_11_0, iter_11_1 in pairs(arg_11_0.timerList) do
		iter_11_1:Stop()
	end
end

function var_0_0.OnExit(arg_12_0)
	arg_12_0.params_.callBack = nil

	for iter_12_0, iter_12_1 in pairs(arg_12_0.timerList) do
		if iter_12_1 then
			iter_12_1:Stop()

			iter_12_1 = nil
		end
	end

	arg_12_0.timerList = {}

	var_0_0.super.OnExit(arg_12_0)
end

return var_0_0
