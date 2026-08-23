local AllianceMenuBtn = class("AllianceMenuBtn", require("app.fairyGUI.alliance.UI_AllianceMenuBtn"))

function AllianceMenuBtn:ctor()
	self._callback = nil
	self._guildSnapshot = nil

	self:addClickListener(handler(self, self._onClickMenuBtn))
end

function AllianceMenuBtn:updateBtn(arg_2_1, arg_2_2)
	if arg_2_1 then
		self._guildSnapshot = arg_2_2

		self:setTitle(arg_2_1.title)

		self._callback = arg_2_1.callback
	end
end

function AllianceMenuBtn:_onClickMenuBtn()
	if self._callback then
		self._callback(self._guildSnapshot)
	end
end

return AllianceMenuBtn
