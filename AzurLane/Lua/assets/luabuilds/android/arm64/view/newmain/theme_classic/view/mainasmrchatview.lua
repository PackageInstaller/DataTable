local var_0_0 = class("MainAsmrChatView", import("...base.MainBaseView"))

var_0_0.SET_CONTENT = "MainAsmrChatView:SetContent"
var_0_0.START_CHAT = "MainAsmrChatView:Start_Chat"

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2)
	setActive(arg_1_0._tf, true)

	arg_1_0._textTF = findTF(arg_1_0._tf, "text")
	arg_1_0._chatTimer = nil

	setActive(arg_1_0._tf, false)
	arg_1_0:bind(MainAsmrChatView.SET_CONTENT, function(arg_2_0, arg_2_1, arg_2_2)
		setText(arg_1_0._textTF, arg_2_2)

		return
	end)
	arg_1_0:bind(MainAsmrChatView.START_CHAT, function(arg_3_0, arg_3_1, arg_3_2)
		if arg_1_0._chatTimer then
			arg_1_0._chatTimer:Stop()

			arg_1_0._chatTimer = nil
		end

		setActive(arg_1_0._tf, true)

		arg_1_0._chatTimer = Timer.New(function()
			if arg_1_0._chatTimer then
				arg_1_0._chatTimer:Stop()

				arg_1_0._chatTimer = nil

				setActive(arg_1_0._tf, false)
			end

			return
		end, arg_3_1 + arg_3_2, 1)

		arg_1_0._chatTimer:Start()

		return
	end)

	return
end

function var_0_0.Init(arg_5_0, arg_5_1)
	setActive(arg_5_0._tf, false)
	arg_5_0:updateUI()

	return
end

function var_0_0.Refresh(arg_6_0, arg_6_1)
	return
end

function var_0_0.updateUI(arg_7_0)
	return
end

function var_0_0.ShowChat(arg_8_0, arg_8_1, arg_8_2)
	return
end

function var_0_0.SetVisible(arg_9_0, arg_9_1)
	if not arg_9_1 then
		if arg_9_0._chatTimer then
			arg_9_0._chatTimer:Stop()

			arg_9_0._chatTimer = nil
		end

		setText(arg_9_0._textTF, "")
		setActive(arg_9_0._tf, arg_9_1)
	end

	return
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)

	return
end

return var_0_0
