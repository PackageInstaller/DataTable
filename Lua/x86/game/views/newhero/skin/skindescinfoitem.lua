local var_0_0 = class("SkinDescInfoItem", ReduxView)
local var_0_1 = "Atlas/HeroAtlas"

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.tagList_ = arg_1_2
	arg_1_0.type_ = arg_1_3
	arg_1_0.descItemList_ = nil

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.OnEnter(arg_4_0)
	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_4_0.infoTransform_)
end

function var_0_0.RefreshUI(arg_5_0)
	local var_5_0 = arg_5_0.tagList_[1]
	local var_5_1 = SkinTagDescCfg[var_5_0]

	arg_5_0.text_.text = var_5_1.type_desc
	arg_5_0.image_.sprite = getSprite(var_0_1, var_5_1.type_icon)

	arg_5_0:LoadDescItem()
	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_5_0.infoTransform_)
end

function var_0_0.LoadDescItem(arg_6_0)
	arg_6_0.descItemList_ = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.tagList_) do
		if not arg_6_0.descItemList_[iter_6_0] then
			local var_6_0 = Object.Instantiate(arg_6_0.descTemplate_, arg_6_0.infoTransform_)

			arg_6_0.descItemList_[iter_6_0] = SkinDescItem.New(var_6_0)
		end

		arg_6_0.descItemList_[iter_6_0]:RefreshUI(iter_6_1)
		arg_6_0.descItemList_[iter_6_0]:Show(true)
	end
end

function var_0_0.Show(arg_7_0, arg_7_1)
	SetActive(arg_7_0.gameObject_, arg_7_1)
	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_0.infoTransform_)
end

function var_0_0.OnExit(arg_8_0)
	return
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0:RemoveAllListeners()

	for iter_9_0, iter_9_1 in pairs(arg_9_0.descItemList_) do
		iter_9_1:Dispose()
	end

	arg_9_0.descItemList_ = {}

	Object.Destroy(arg_9_0.gameObject_)
	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
