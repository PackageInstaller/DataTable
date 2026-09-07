local NewEducateTopRes = class("NewEducateTopRes")

function NewEducateTopRes:Ctor(arg_1_1, arg_1_2)
	self._go = arg_1_1
	self._tf = arg_1_1.transform
	self.event = arg_1_2
	self.bgImage = self._tf:GetComponent(typeof(Image))
	self.resUIList = UIItemList.New(self._tf, self._tf:Find("tpl"))

	self.resUIList:make(function(arg_2_0, arg_2_1, arg_2_2)
		if arg_2_0 == UIItemList.EventInit then
			self:OnInitItem(arg_2_1, arg_2_2)
		elseif arg_2_0 == UIItemList.EventUpdate then
			self:OnUpdateItem(arg_2_1, arg_2_2)
		end

		return
	end)

	return
end

function NewEducateTopRes:SetBgEnable(arg_3_1)
	self.bgImage.enabled = arg_3_1

	return
end

function NewEducateTopRes:OnInitItem(arg_4_1, arg_4_2)
	local var_4_0 = self.resIds[arg_4_1 + 1]

	setActive(arg_4_2:Find("line"), arg_4_1 + 1 ~= #self.resIds)
	LoadImageSpriteAsync("neweducateicon/" .. pg.child2_resource[var_4_0].icon, arg_4_2:Find("icon"))
	onButton(self.event, arg_4_2, function()
		self.event:emit(NewEducateBaseUI.ON_ITEM, {
			drop = {
				number = 1,
				type = NewEducateConst.DROP_TYPE.RES,
				id = var_4_0
			}
		})

		return
	end, SFX_PANEL)

	return
end

function NewEducateTopRes:OnUpdateItem(arg_6_1, arg_6_2)
	local var_6_0 = pg.child2_resource[self.resIds[arg_6_1 + 1]]
	local var_6_1

	if pg.child2_resource[self.resIds[arg_6_1 + 1]].type == NewEducateChar.RES_TYPE.MOOD then
		var_6_1 = "/" .. var_6_0.max_value or ""
	end

	local var_6_2 = self.char:GetRes(var_6_0.id)

	if var_6_0.type == NewEducateChar.RES_TYPE.MOOD then
		setText(arg_6_2:Find("value"), setColorStr(var_6_2, self:GetMoodColor(var_6_2)) .. var_6_1)
	elseif var_6_0.type == NewEducateChar.RES_TYPE.ACTION then
		setText(arg_6_2:Find("value"), var_6_2 == 0 and setColorStr(var_6_2, "#ee4a4a") or var_6_2)
	else
		setText(arg_6_2:Find("value"), var_6_2 .. var_6_1)
	end

	return
end

function NewEducateTopRes:Update(arg_7_1)
	self.char = arg_7_1
	self.resIds = self.resIds or {
		self.char:GetResIdByType(NewEducateChar.RES_TYPE.MONEY),
		self.char:GetResIdByType(NewEducateChar.RES_TYPE.MOOD),
		self.char:GetResIdByType(NewEducateChar.RES_TYPE.ACTION)
	}

	self.resUIList:align(#self.resIds)

	return
end

function NewEducateTopRes:GetMoodColor(arg_8_1)
	if arg_8_1 < 20 then
		return "#ee4a4a"
	elseif arg_8_1 < 40 then
		return "#ab4734"
	elseif arg_8_1 < 60 then
		return "#393A3C"
	else
		return "#00c79b"
	end

	return
end

function NewEducateTopRes:Dispose()
	return
end

return NewEducateTopRes
