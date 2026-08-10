local var_0_0 = import("manager.message.MessageBoxItem")
local var_0_1 = class("ShowMessageMgr", import("game.extend.BaseView"))

function var_0_1.Ctor(arg_1_0)
	arg_1_0:OnCtor()
end

function var_0_1.OnCtor(arg_2_0)
	print("initializing show message manager ...")

	arg_2_0.itemList_ = {}
end

function var_0_1.ShowMessage(arg_3_0, arg_3_1)
	if manager.ui.uiMessage == nil then
		return
	end

	if arg_3_1.boxType == nil or arg_3_1.boxType == NORMAL_MESSAGE_BOX then
		arg_3_0:ShowNormalBox(arg_3_1)
	end
end

function var_0_1.ShowNormalBox(arg_4_0, arg_4_1)
	arg_4_0:GetFreeItem(arg_4_1):SetData(arg_4_1)
end

function var_0_1.GetFreeItem(arg_5_0, arg_5_1)
	if arg_5_0.itemList_ == nil then
		print("弹窗已经被销毁，被调用")

		arg_5_0.itemList_ = {}
	end

	local var_5_0 = "Widget/Common/Pop/UIInquirepopup12"

	if arg_5_1.prefabPath and arg_5_1.prefabPath ~= "" then
		var_5_0 = arg_5_1.prefabPath
	end

	if not arg_5_0.itemList_[var_5_0] then
		arg_5_0.itemList_[var_5_0] = {}
	end

	local var_5_1

	for iter_5_0, iter_5_1 in pairs(arg_5_0.itemList_[var_5_0]) do
		if iter_5_1:IsFree() then
			return iter_5_1
		end
	end

	arg_5_0.gameObject_ = Object.Instantiate(Asset.Load(var_5_0), manager.ui.uiMessage.transform)

	SetActive(arg_5_0.gameObject_, false)

	local var_5_2 = var_0_0.New(arg_5_0.gameObject_)

	table.insert(arg_5_0.itemList_[var_5_0], var_5_2)

	return var_5_2
end

function var_0_1.HideAll(arg_6_0)
	if arg_6_0.itemList_ then
		for iter_6_0, iter_6_1 in pairs(arg_6_0.itemList_) do
			for iter_6_2, iter_6_3 in pairs(iter_6_1) do
				iter_6_3:Hide()
			end
		end
	end
end

function var_0_1.GetItemList(arg_7_0)
	return arg_7_0.itemList_
end

function var_0_1.GetIsAllFree(arg_8_0)
	for iter_8_0, iter_8_1 in pairs(arg_8_0.itemList_) do
		for iter_8_2, iter_8_3 in pairs(iter_8_1) do
			if not iter_8_3:IsFree() then
				return false
			end
		end
	end

	return true
end

function var_0_1.Dispose(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(arg_9_0.itemList_) do
		for iter_9_2, iter_9_3 in pairs(iter_9_1) do
			iter_9_3:Dispose()
		end
	end

	arg_9_0.itemList_ = nil

	if arg_9_0.gameObject_ then
		Object.Destroy(arg_9_0.gameObject_)

		arg_9_0.gameObject_ = nil
	end

	var_0_1.super.Dispose(arg_9_0)
end

return var_0_1
