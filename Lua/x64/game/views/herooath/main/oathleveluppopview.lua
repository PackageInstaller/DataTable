local var_0_0 = class("OathLevelUpPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Hero_Oath/OathCaptureView/HeroOathlvlpopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

local var_0_1 = {
	ONLY_SHOW_IN_LEVEL_UP_POP = 1,
	ONLY_SHOW_IN_RIGHT_DETAIL_POP = 0,
	ALL = 2
}

function var_0_0.Init(arg_3_0)
	arg_3_0.items = {}

	arg_3_0:BindCfgUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.Dispose(arg_4_0)
	arg_4_0:RemoveAllListeners()

	if arg_4_0.items then
		for iter_4_0, iter_4_1 in pairs(arg_4_0.items) do
			iter_4_1:Dispose()
			Object.Destroy(iter_4_1.gameObject_)
		end
	end

	var_0_0.super.Dispose(arg_4_0)
end

local function var_0_2(arg_5_0, arg_5_1)
	for iter_5_0 = arg_5_0.list_.childCount + 1, arg_5_1 do
		local var_5_0 = Object.Instantiate(arg_5_0.itemPrefab_, arg_5_0.list_)
	end

	local var_5_1 = arg_5_0.list_.childCount

	for iter_5_1 = 1, var_5_1 do
		local var_5_2 = arg_5_0.list_:GetChild(iter_5_1 - 1).gameObject

		arg_5_0.items[iter_5_1] = arg_5_0.items[iter_5_1] or var_0_0.Item.New(var_5_2)

		arg_5_0.items[iter_5_1]:SetIsShow(iter_5_1 <= arg_5_1)
	end
end

function var_0_0.OnEnter(arg_6_0)
	local var_6_0 = arg_6_0.params_.heroID
	local var_6_1 = arg_6_0.params_.level
	local var_6_2 = arg_6_0.params_.prevLevel or var_6_1 - 1

	arg_6_0.prevLevel_.text = OathTools.GetOathLvShowTips(var_6_2) or ""
	arg_6_0.curLevel_.text = OathTools.GetOathLvShowTips(var_6_1)

	local var_6_3 = arg_6_0:CalcLevelUpUnlockedRight(var_6_0, var_6_1, var_6_2)

	var_0_2(arg_6_0, #var_6_3)

	for iter_6_0, iter_6_1 in ipairs(var_6_3) do
		arg_6_0.items[iter_6_0]:SetData(iter_6_1)
	end
end

function var_0_0.OnExit(arg_7_0)
	OathCollectionContentData:OnLevelUpdateMsgRead(arg_7_0.params_.heroID)
end

function var_0_0.AddUIListeners(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.maskBtn_, nil, JumpTools.Back)
end

function var_0_0.CalcLevelUpUnlockedRight(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = {}
	local var_9_1 = WeddingRightCfg.get_id_list_by_hero_id[arg_9_1]

	if var_9_1 then
		for iter_9_0, iter_9_1 in ipairs(var_9_1) do
			local var_9_2 = WeddingRightCfg[iter_9_1]

			if var_9_2.is_show ~= var_0_1.ONLY_SHOW_IN_RIGHT_DETAIL_POP and arg_9_3 < var_9_2.level and arg_9_2 >= var_9_2.level then
				table.insert(var_9_0, iter_9_1)
			end
		end
	end

	return var_9_0
end

local var_0_3 = class("OathLevelUpRightItem", BaseView)

var_0_0.Item = var_0_3

function var_0_3.Ctor(arg_10_0, arg_10_1)
	arg_10_0.gameObject_ = arg_10_1
	arg_10_0.transform_ = arg_10_1.transform

	arg_10_0:BindCfgUI()
end

function var_0_3.SetData(arg_11_0, arg_11_1)
	local var_11_0 = WeddingRightCfg[arg_11_1]

	arg_11_0.desc_.text = var_11_0.desc
end

function var_0_3.SetIsShow(arg_12_0, arg_12_1)
	SetActive(arg_12_0.gameObject_, arg_12_1)
end

return var_0_0
