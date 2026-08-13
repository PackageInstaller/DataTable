class = var_0_10000

local var_0_0 = "AttireChatFramePanel"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".AttireFramePanel"))

setmetatable = var_0_0

local function var_0_2(arg_1_0)
	local var_1_0 = {}

	AttireFramePanel = var_1_10002

	local var_1_1 = var_1_10002.Card(arg_1_0)

	local function var_1_2(arg_2_0)
		return
	end

	local function var_1_3(arg_3_0, arg_3_1, arg_3_2)
		setAnchoredPosition = var_2_10003

		local var_3_0 = arg_3_1

		Vector2 = var_2_10005

		var_2_10003(var_3_0, var_2_10005.zero)

		setText = var_2_10003

		local var_3_1 = arg_3_1.transform

		var_2_10003(var_4.Find(var_3_1, "Text"), "")

		return
	end

	function var_1_0.Update(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
		local var_4_0 = var_1_1

		var_4.Update(var_4_0, arg_4_1, arg_4_2, arg_4_3)

		local var_4_1 = arg_4_0
		local var_4_2 = arg_4_0.ReturnIconFrame

		AttireConst = var_6

		var_4_2(var_4_1, var_6.TYPE_CHAT_FRAME)

		if arg_4_0:isEmpty() then
			return
		end

		arg_4_0:LoadPrefab(arg_4_1, function(arg_5_0)
			var_1_3(arg_4_0, arg_5_0, arg_4_1)

			return
		end)

		return
	end

	function var_1_0.Dispose(arg_6_0)
		local var_6_0 = arg_6_0
		local var_6_1 = arg_6_0.ReturnIconFrame

		AttireConst = var_2_10003

		var_6_1(var_6_0, var_2_10003.TYPE_CHAT_FRAME)

		return
	end

	var_1_2(var_1_0)

	return var_0_0(var_1_0, {
		__index = var_1_1
	})
end

function var_0_1.getUIName(arg_7_0)
	return "AttireChatFrameUI"
end

function var_0_1.GetData(arg_8_0)
	return arg_8_0.rawAttireVOs.chatFrames
end

function var_0_1.OnInitItem(arg_9_0, arg_9_1)
	local var_9_0 = var_0_2(arg_9_1)
	local var_9_1 = arg_9_0.cards

	var_9_1[arg_9_1] = var_9_0
	onButton = var_9_1

	local var_9_2 = arg_9_0
	local var_9_3 = var_9_0._go

	local function var_9_4()
		local var_10_0 = var_9_0

		if var_0.isEmpty(var_10_0) then
			return
		end

		if arg_9_0.card then
			local var_10_1 = arg_9_0.card

			var_0.UpdateSelected(var_10_1, false)
		end

		arg_9_0.contextData.chatFrameIndex = var_9_0.attireFrame.id

		local var_10_2 = arg_9_0

		var_0.UpdateDesc(var_10_2, var_9_0)

		local var_10_3 = var_9_0

		var_0.UpdateSelected(var_10_3, true)

		arg_9_0.card = var_9_0

		return
	end

	SFX_PANEL = var_1_10007

	var_9_1(var_9_2, var_9_3, var_9_4, var_1_10007)

	return
end

function var_0_1.GetColumn(arg_11_0)
	return 3
end

function var_0_1.OnUpdateItem(arg_12_0, arg_12_1, arg_12_2)
	var_0_1.super.OnUpdateItem(arg_12_0, arg_12_1, arg_12_2)

	local var_12_0

	if not arg_12_0.contextData.chatFrameIndex then
		var_12_0 = arg_12_0.displayVOs[1].id
	end

	if arg_12_0.cards[arg_12_2].attireFrame.id == var_12_0 then
		triggerButton = var_5

		var_5(var_4._go)
		var_4:UpdateSelected(true)
	end

	return
end

return var_0_1
