local var_0_0 = class("NewChessTipsManager")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.gameObject_ = Object.Instantiate(Asset.Load("UI/NewWarChess/NewWarChessTipsManager"), manager.ui.canvas.transform)

	ComponentBinder.GetInstance():BindCfgUI(arg_1_0, arg_1_0.gameObject_)

	arg_1_0.tipsItems_ = {}
	arg_1_0.tipsDispose_ = handler(arg_1_0, arg_1_0.OnTipsDispose)
end

function var_0_0.CreateTips(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in pairs(arg_2_0.tipsItems_) do
		if not iter_2_1:GetIsShow() then
			iter_2_1:SetData(arg_2_1)
			iter_2_1:SetIsShow(true)
			LayoutRebuilder.ForceRebuildLayoutImmediate(arg_2_0.contentTrans_)

			return
		end
	end

	local var_2_0 = GameObject.Instantiate(arg_2_0.tipsGo_, arg_2_0.contentTrans_)
	local var_2_1 = NewChessTipsItem.New(var_2_0)

	var_2_1:SetDisposeHandler(arg_2_0.tipsDispose_)
	var_2_1:SetData(arg_2_1)
	var_2_1:SetIsShow(true)
	table.insert(arg_2_0.tipsItems_, var_2_1)
	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_2_0.contentTrans_)
end

function var_0_0.OnTipsDispose(arg_3_0, arg_3_1)
	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_3_0.contentTrans_)
end

function var_0_0.Dispose(arg_4_0)
	for iter_4_0, iter_4_1 in pairs(arg_4_0.tipsItems_) do
		iter_4_1:Dispose()
	end

	arg_4_0.tipsItems_ = {}
	arg_4_0.tipsDispose_ = nil

	Object.Destroy(arg_4_0.gameObject_)

	arg_4_0.gameObject_ = nil
end

return var_0_0
