local var_0_0 = class("OathBubbleContent", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()

	arg_1_0.bubbleList = {}
	arg_1_0.bubblePool = {}

	arg_1_0:AddListeners()
end

function var_0_0.AddListeners(arg_2_0)
	return
end

function var_0_0.GetBubbleItem(arg_3_0)
	if #arg_3_0.bubblePool > 0 then
		return table.remove(arg_3_0.bubblePool)
	else
		return Object.Instantiate(arg_3_0.bubbleObj_, arg_3_0.bubbleContent_)
	end
end

function var_0_0.AddOptionsBubble(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6)
	local var_4_0 = arg_4_0:GetBubbleItem()

	SetActive(var_4_0, true)

	arg_4_0.bubbleList[arg_4_1] = OathOptionsBubbleItem.New(var_4_0)

	arg_4_0.bubbleList[arg_4_1]:SetData({
		id = arg_4_1,
		tipsKey = arg_4_2,
		icon = arg_4_3,
		order = arg_4_4,
		clickCallback = arg_4_5,
		isFinish = arg_4_6 or false
	})
end

function var_0_0.RemoveOptionsBubble(arg_5_0, arg_5_1)
	if arg_5_0.bubbleList[arg_5_1] then
		arg_5_0.bubbleList[arg_5_1]:Remove()

		local var_5_0 = arg_5_0.bubbleList[arg_5_1].gameObject_

		SetActive(var_5_0, false)
		table.insert(arg_5_0.bubblePool, var_5_0)

		arg_5_0.bubbleList[arg_5_1] = nil
	end
end

function var_0_0.OnExit(arg_6_0)
	return
end

function var_0_0.Dispose(arg_7_0)
	if arg_7_0.bubbleList then
		for iter_7_0, iter_7_1 in pairs(arg_7_0.bubbleList) do
			iter_7_1:Dispose()
		end

		arg_7_0.bubbleList = nil
	end

	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0
