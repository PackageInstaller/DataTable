local var_0_0 = class("AttireChatFramePanel", import(".AttireFramePanel"))
local var_0_1 = setmetatable

local function var_0_2(arg_1_0)
	local var_1_0 = AttireFramePanel.Card(arg_1_0)

	local function var_1_1(arg_3_0, arg_3_1, arg_3_2)
		setAnchoredPosition(arg_3_1, Vector2.zero)
		setText(arg_3_1.transform:Find("Text"), "")

		return
	end

	;({}).Update = function(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
		var_1_0:Update(arg_4_1, arg_4_2, arg_4_3)
		arg_4_0:ReturnIconFrame(AttireConst.TYPE_CHAT_FRAME)

		if arg_4_0:isEmpty() then
			return
		end

		arg_4_0:LoadPrefab(arg_4_1, function(arg_5_0)
			var_1_1(arg_4_0, arg_5_0, arg_4_1)

			return
		end)

		return
	end
	;({}).Dispose = function(arg_6_0)
		arg_6_0:ReturnIconFrame(AttireConst.TYPE_CHAT_FRAME)

		return
	end

	;(function(arg_2_0)
		return
	end)({})

	return var_0_1({}, {
		__index = AttireFramePanel.Card(arg_1_0)
	})
end

function var_0_0.getUIName(arg_7_0)
	return "AttireChatFrameUI"
end

function var_0_0.GetData(arg_8_0)
	return arg_8_0.rawAttireVOs.chatFrames
end

function var_0_0.OnInitItem(arg_9_0, arg_9_1)
	local var_9_0 = var_0_2(arg_9_1)

	arg_9_0.cards[arg_9_1] = var_9_0

	onButton(arg_9_0, var_9_0._go, function()
		if var_9_0:isEmpty() then
			return
		end

		if arg_9_0.card then
			arg_9_0.card:UpdateSelected(false)
		end

		arg_9_0.contextData.chatFrameIndex = var_9_0.attireFrame.id

		arg_9_0:UpdateDesc(var_9_0)
		var_9_0:UpdateSelected(true)

		arg_9_0.card = var_9_0

		return
	end, SFX_PANEL)

	return
end

function var_0_0.GetColumn(arg_11_0)
	return 3
end

function var_0_0.OnUpdateItem(arg_12_0, arg_12_1, arg_12_2)
	var_0_0.super.OnUpdateItem(arg_12_0, arg_12_1, arg_12_2)

	local var_12_0 = arg_12_0.contextData.chatFrameIndex or arg_12_0.displayVOs[1].id
	local var_12_1 = arg_12_0.cards[arg_12_2]

	if arg_12_0.cards[arg_12_2].attireFrame.id == var_12_0 then
		triggerButton(var_12_1._go)
		var_12_1:UpdateSelected(true)
	end

	return
end

return var_0_0
