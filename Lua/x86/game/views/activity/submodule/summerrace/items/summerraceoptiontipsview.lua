local var_0_0 = import("game.views.activity.Submodule.SummerRace.Items.SummerRaceTipsPropertyItemView")
local var_0_1 = class("SummerRaceOptionTipsView", ReduxView)

function var_0_1.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.propertiesItemPrefab_ = arg_1_2
	arg_1_0.propertyItemViews_ = {}

	arg_1_0:Init()
end

function var_0_1.Init(arg_2_0)
	arg_2_0:BindCfgUI()

	local var_2_0 = arg_2_0.propertiesListGo_.transform

	for iter_2_0 = var_2_0.childCount - 1, 0, -1 do
		Object.Destroy(var_2_0:GetChild(iter_2_0).gameObject)
	end
end

function var_0_1.EnsurePropertyItemView(arg_3_0, arg_3_1)
	if arg_3_0.propertyItemViews_[arg_3_1] ~= nil then
		return arg_3_0.propertyItemViews_[arg_3_1]
	end

	local var_3_0 = arg_3_0.propertiesListGo_.transform
	local var_3_1 = Object.Instantiate(arg_3_0.propertiesItemPrefab_, var_3_0)

	var_3_1.name = "propertiesItem_" .. tostring(arg_3_1)
	arg_3_0.propertyItemViews_[arg_3_1] = var_0_0.New(var_3_1)

	return arg_3_0.propertyItemViews_[arg_3_1]
end

function var_0_1.RefreshPropertyList(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0.propertiesListGo_.transform

	arg_4_1 = arg_4_1 or {}

	for iter_4_0 = 1, #arg_4_1 do
		arg_4_0:EnsurePropertyItemView(iter_4_0):SetData(arg_4_1[iter_4_0])
	end

	local var_4_1 = #arg_4_0.propertyItemViews_

	for iter_4_1 = #arg_4_1 + 1, var_4_1 do
		arg_4_0:EnsurePropertyItemView(iter_4_1):SetData(nil)
	end
end

function var_0_1.SetData(arg_5_0, arg_5_1)
	if arg_5_1 == nil then
		SetActive(arg_5_0.rootGo_, false)

		return
	end

	SetActive(arg_5_0.rootGo_, true)

	arg_5_0.titleText_.text = tostring(arg_5_1.title or "")
	arg_5_0.titleNum_.text = tostring(arg_5_1.cost or 0)
	arg_5_0.descText_.text = tostring(arg_5_1.desc or "")

	arg_5_0:RefreshPropertyList(arg_5_1.properties)
end

function var_0_1.Dispose(arg_6_0)
	for iter_6_0 = 1, #(arg_6_0.propertyItemViews_ or {}) do
		arg_6_0.propertyItemViews_[iter_6_0]:Dispose()
	end

	arg_6_0.propertyItemViews_ = nil
	arg_6_0.propertiesItemPrefab_ = nil

	var_0_1.super.Dispose(arg_6_0)
end

return var_0_1
