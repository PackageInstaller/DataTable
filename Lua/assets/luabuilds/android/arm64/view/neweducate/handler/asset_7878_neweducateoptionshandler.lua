local NewEducateOptionsHandler = class("NewEducateOptionsHandler")

function NewEducateOptionsHandler:Ctor(arg_1_1)
	pg.DelegateInfo.New(self)

	self._go = arg_1_1
	self._tf = arg_1_1.transform
	self.tpl = self._tf:Find("tpl")
	self.optionUIList = UIItemList.New(self._tf, self.tpl)

	self.optionUIList:make(function(arg_2_0, arg_2_1, arg_2_2)
		if arg_2_0 == UIItemList.EventUpdate then
			self:UpdateOption(arg_2_1, arg_2_2)
		end

		return
	end)

	return
end

function NewEducateOptionsHandler:Play(arg_3_1, arg_3_2)
	self.callName = self.callName or getProxy(NewEducateProxy):GetCurChar():GetCallName()

	setActive(self._go, true)

	self.optionIds = arg_3_1
	self.callback = arg_3_2

	self.optionUIList:align(#self.optionIds)

	return
end

function NewEducateOptionsHandler:_GetText(arg_4_1)
	return string.gsub(pg.child2_word[arg_4_1].word, "$1", self.callName)
end

function NewEducateOptionsHandler:UpdateOption(arg_5_1, arg_5_2)
	local var_5_0 = self.optionIds[arg_5_1 + 1]

	setScrollText(arg_5_2:Find("mask/Text"), self:_GetText(pg.child2_node[self.optionIds[arg_5_1 + 1]].text))
	onButton(self, arg_5_2, function()
		existCall(self.callback(var_5_0))
		self:Reset()

		return
	end, SFX_PANEL)

	return
end

function NewEducateOptionsHandler:UpdateCallName()
	self.callName = getProxy(NewEducateProxy):GetCurChar():GetCallName()

	return
end

function NewEducateOptionsHandler:Reset()
	self.callback = nil

	setActive(self._go, false)

	return
end

function NewEducateOptionsHandler:Destroy()
	pg.DelegateInfo.Dispose(self)

	return
end

return NewEducateOptionsHandler
