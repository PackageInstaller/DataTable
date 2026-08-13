class = var_0_10000

local var_0_0 = "MainAsmrChatView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.MainBaseView"))

var_0_1.SET_CONTENT = "MainAsmrChatView:SetContent"
var_0_1.START_CHAT = "MainAsmrChatView:Start_Chat"

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	setActive = var_3

	var_3(arg_1_0._tf, true)

	findTF = var_3
	arg_1_0._textTF = var_3(arg_1_0._tf, "text")
	arg_1_0._chatTimer = nil
	setActive = var_3

	var_3(arg_1_0._tf, false)

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.bind

	MainAsmrChatView = var_5

	var_1_1(var_1_0, var_5.SET_CONTENT, function(arg_2_0, arg_2_1, arg_2_2)
		setText = var_2_10003

		var_2_10003(arg_1_0._textTF, arg_2_2)

		return
	end)

	local var_1_2 = arg_1_0
	local var_1_3 = arg_1_0.bind

	MainAsmrChatView = var_5

	var_1_3(var_1_2, var_5.START_CHAT, function(arg_3_0, arg_3_1, arg_3_2)
		local var_3_1

		if arg_1_0._chatTimer then
			local var_3_0 = arg_1_0._chatTimer

			var_3_1.Stop(var_3_0)

			var_3_1 = arg_1_0
			var_3_1._chatTimer = nil
		end

		setActive = var_3_1

		var_3_1(arg_1_0._tf, true)

		local var_3_2 = arg_1_0

		Timer = var_4
		var_3_2._chatTimer = var_4.New(function()
			if arg_1_0._chatTimer then
				local var_4_0 = arg_1_0._chatTimer

				var_0.Stop(var_4_0)

				local var_4_1 = arg_1_0

				var_4_1._chatTimer = nil
				setActive = var_4_1

				var_4_1(arg_1_0._tf, false)
			end

			return
		end, arg_3_1 + arg_3_2, 1)

		local var_3_3 = arg_1_0._chatTimer

		var_3.Start(var_3_3)

		return
	end)

	return
end

function var_0_1.Init(arg_5_0, arg_5_1)
	setActive = var_1_10002

	var_1_10002(arg_5_0._tf, false)
	arg_5_0:updateUI()

	return
end

function var_0_1.Refresh(arg_6_0, arg_6_1)
	return
end

function var_0_1.updateUI(arg_7_0)
	return
end

function var_0_1.ShowChat(arg_8_0, arg_8_1, arg_8_2)
	return
end

function var_0_1.SetVisible(arg_9_0, arg_9_1)
	if not arg_9_1 then
		if arg_9_0._chatTimer then
			local var_9_0 = arg_9_0._chatTimer

			var_2.Stop(var_9_0)

			arg_9_0._chatTimer = nil
		end

		setText = var_2

		var_2(arg_9_0._textTF, "")

		setActive = var_2

		var_2(arg_9_0._tf, arg_9_1)
	end

	return
end

function var_0_1.Dispose(arg_10_0)
	var_0_1.super.Dispose(arg_10_0)

	return
end

return var_0_1
