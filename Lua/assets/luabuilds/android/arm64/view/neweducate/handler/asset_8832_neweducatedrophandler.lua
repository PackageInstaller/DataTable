local NewEducateDropHandler = class("NewEducateDropHandler")
local var_0_1 = 1

function NewEducateDropHandler:Ctor(arg_1_1)
	self._go = arg_1_1
	self._tf = arg_1_1.transform
	self.dropsTF = self._tf:Find("drops")
	self.dropUIList = UIItemList.New(self.dropsTF, self.dropsTF:Find("tpl"))

	self.dropUIList:make(function(arg_2_0, arg_2_1, arg_2_2)
		if arg_2_0 == UIItemList.EventUpdate then
			local var_2_0 = NewEducateHelper.GetDropConfig(self.drops[arg_2_1 + 1])

			LoadImageSpriteAsync("neweducateicon/" .. (var_2_0.icon or var_2_0.item_icon), arg_2_2:Find("icon"))
			setText(arg_2_2:Find("name"), var_2_0.name)

			if self.drops[arg_2_1 + 1].number > 0 then
				setActive(arg_2_2:Find("reduce"), false)
				setActive(arg_2_2:Find("increase"), true)
				setText(arg_2_2:Find("increase/value"), "+" .. self.drops[arg_2_1 + 1].number)
			else
				setActive(arg_2_2:Find("reduce"), true)
				setActive(arg_2_2:Find("increase"), false)
				setText(arg_2_2:Find("reduce/value"), self.drops[arg_2_1 + 1].number)
			end

			setActive(arg_2_2:Find("benefit"), false)
		end

		return
	end)

	self.polaroidTF = self._tf:Find("polaroid")

	return
end

function NewEducateDropHandler:Play(arg_3_1, arg_3_2)
	setActive(self._go, true)
	setActive(self.dropsTF, true)
	setActive(self.polaroidTF, false)

	self.drops = self:FilterPersonality(arg_3_1)

	self.dropUIList:align(#self.drops)

	self.timer = Timer.New(function()
		existCall(arg_3_2)

		return
	end, var_0_1)

	self.timer:Start()

	return
end

function NewEducateDropHandler:FilterPersonality(arg_5_1)
	return underscore.select(arg_5_1, function(arg_6_0)
		return arg_6_0.type ~= NewEducateConst.DROP_TYPE.ATTR or arg_6_0.type == NewEducateConst.DROP_TYPE.ATTR and pg.child2_attr[arg_6_0.id].type ~= NewEducateChar.ATTR_TYPE.PERSONALITY
	end)
end

function NewEducateDropHandler:PlayPolaroid(arg_7_1, arg_7_2)
	setActive(self._go, true)
	setActive(self.dropsTF, false)
	setActive(self.polaroidTF, true)
	seriesAsync({
		function(arg_8_0)
			LoadImageSpriteAsync("neweducateicon/" .. pg.child2_polaroid[arg_7_1.id].pic, self.polaroidTF:Find("content/mask/icon"), true)
			setText(self.polaroidTF:Find("content/desc"), pg.child2_polaroid[arg_7_1.id].title)
			onDelayTick(function()
				arg_8_0()

				return
			end, var_0_1)

			return
		end
	}, function()
		existCall(arg_7_2)

		return
	end)

	return
end

function NewEducateDropHandler:Reset()
	setActive(self._go, false)
	setActive(self.polaroidTF, false)
	setActive(self.dropsTF, false)

	self.drops = {}

	if self.timer ~= nil then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function NewEducateDropHandler:Destroy()
	return
end

return NewEducateDropHandler
