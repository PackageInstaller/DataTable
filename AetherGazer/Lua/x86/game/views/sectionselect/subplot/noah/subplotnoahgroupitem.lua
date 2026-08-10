local var_0_0 = class("SubPlotNoahGroupItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.numController_ = arg_3_0.controller_:GetController("stage")
	arg_3_0.stageItemList = {}

	for iter_3_0 = 1, 3 do
		arg_3_0.stageItemList[iter_3_0] = SubPlotNoahSectionItem.New(arg_3_0[string.format("stageGo%s_", iter_3_0)].gameObject)
	end
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = #arg_4_3

	arg_4_0.numController_:SetSelectedIndex(var_4_0 - 1)

	for iter_4_0, iter_4_1 in pairs(arg_4_0.stageItemList) do
		local var_4_1 = arg_4_3[iter_4_0]

		if var_4_1 then
			iter_4_1:SetData(arg_4_2, var_4_1)
		end
	end

	arg_4_0.titleText_.text = GetTips(string.format("HODR_CHAPTER_PART_TITLE_%s", arg_4_1))

	local var_4_2 = string.format("TextureConfig/Operation/V4_7_Hodr_num_%s", arg_4_1)

	SetSpriteWithoutAtlasAsync(arg_4_0.stageNumImg_, var_4_2)
end

function var_0_0.SelectorItem(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.stageItemList) do
		iter_5_1:SelectorItem(arg_5_1)
	end
end

function var_0_0.Show(arg_6_0, arg_6_1)
	arg_6_0.gameObject_:SetActive(arg_6_1)
end

function var_0_0.OnExit(arg_7_0)
	for iter_7_0, iter_7_1 in pairs(arg_7_0.stageItemList) do
		if iter_7_1 then
			iter_7_1:OnExit()
		end
	end
end

function var_0_0.Dispose(arg_8_0)
	for iter_8_0, iter_8_1 in pairs(arg_8_0.stageItemList) do
		if iter_8_1 then
			iter_8_1:Dispose()

			iter_8_1 = nil
		end
	end

	arg_8_0.stageItemList = nil

	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
