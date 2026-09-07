local MainAsmrChatView = class("MainAsmrChatView", import("...base.MainBaseView"))

MainAsmrChatView.SET_CONTENT = "MainAsmrChatView:SetContent"
MainAsmrChatView.START_CHAT = "MainAsmrChatView:Start_Chat"

function MainAsmrChatView:Ctor(arg_1_1, arg_1_2)
	MainAsmrChatView.super.Ctor(self, arg_1_1, arg_1_2)
	setActive(self._tf, true)

	self._textTF = findTF(self._tf, "text")
	self._chatTimer = nil

	setActive(self._tf, false)
	self:bind(MainAsmrChatView.SET_CONTENT, function(arg_2_0, arg_2_1, arg_2_2)
		setText(self._textTF, arg_2_2)

		return
	end)
	self:bind(MainAsmrChatView.START_CHAT, function(arg_3_0, arg_3_1, arg_3_2)
		if self._chatTimer then
			self._chatTimer:Stop()

			self._chatTimer = nil
		end

		setActive(self._tf, true)

		self._chatTimer = Timer.New(function()
			if self._chatTimer then
				self._chatTimer:Stop()

				self._chatTimer = nil

				setActive(self._tf, false)
			end

			return
		end, arg_3_1 + arg_3_2, 1)

		self._chatTimer:Start()

		return
	end)

	return
end

function MainAsmrChatView:Init(arg_5_1)
	setActive(self._tf, false)
	self:updateUI()

	return
end

function MainAsmrChatView:Refresh(arg_6_1)
	return
end

function MainAsmrChatView:updateUI()
	return
end

function MainAsmrChatView:ShowChat(arg_8_1, arg_8_2)
	return
end

function MainAsmrChatView:SetVisible(arg_9_1)
	if not arg_9_1 then
		if self._chatTimer then
			self._chatTimer:Stop()

			self._chatTimer = nil
		end

		setText(self._textTF, "")
		setActive(self._tf, arg_9_1)
	end

	return
end

function MainAsmrChatView:Dispose()
	MainAsmrChatView.super.Dispose(self)

	return
end

return MainAsmrChatView
