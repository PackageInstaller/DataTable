local OtherWorldTempleChars = class("OtherWorldTempleChars")
local var_0_1 = "other_world_temple_char"

function OtherWorldTempleChars:Ctor(arg_1_1, arg_1_2)
	self._tf = arg_1_1
	self._event = arg_1_2

	onButton(self._event, findTF(self._tf, "ad/btnClose"), function()
		self:setActive(false)

		return
	end, SFX_CANCEL)
	onButton(self._event, findTF(self._tf, "ad/clickClose"), function()
		self:setActive(false)

		return
	end, SFX_CANCEL)

	self._charTpl = findTF(self._tf, "ad/chars/content/charTpl")

	setText(findTF(self._charTpl, "got/img/text"), i18n("word_got"))
	setActive(self._charTpl, false)

	self._charItems = {}
	self._charContent = findTF(self._tf, "ad/chars/content")

	return
end

function OtherWorldTempleChars:setData(arg_4_1)
	self.charIds = arg_4_1

	return
end

function OtherWorldTempleChars:updateActivityPool(arg_5_1)
	self.activityPools = arg_5_1

	return
end

function OtherWorldTempleChars:updateSelect()
	self:updateItemsCount(#self.charIds)

	for iter_6_0 = 1, #self._charItems do
		setActive(self._charItems[iter_6_0], false)

		if iter_6_0 <= #self.charIds then
			setActive(self._charItems[iter_6_0], true)
			self:setItemData(self._charItems[iter_6_0], self.charIds[iter_6_0])
		end
	end

	setText(findTF(self._tf, "ad/title/text"), i18n(var_0_1))

	return
end

function OtherWorldTempleChars:setItemData(arg_7_1, arg_7_2)
	local var_7_0 = pg.guardian_template[arg_7_2]
	local var_7_1 = ""
	local var_7_2 = self.activityPools[pg.guardian_template[arg_7_2].guardian_gain_pool]:getGuardianGot(arg_7_2)

	if pg.guardian_template[arg_7_2].type == 1 then
		var_7_1 = string.gsub(var_7_0.guardian_gain_desc, "$1", math.min(self.activityPools[pg.guardian_template[arg_7_2].guardian_gain_pool]:getFetchCount(), var_7_0.guardian_gain[2]))
	elseif var_7_0.type == 2 then
		var_7_1 = var_7_2 and var_7_0.guardian_gain_desc or "???"
	end

	if var_7_0.type == 2 then
		setText(findTF(arg_7_1, "desc/text"), (var_7_2 or nil) and (var_7_0.guardian_desc or "???"))
		setText(findTF(arg_7_1, "name/text"), (var_7_2 or nil) and (var_7_0.guardian_name or "???"))
	else
		setText(findTF(arg_7_1, "name/text"), var_7_0.guardian_name)
		setText(findTF(arg_7_1, "desc/text"), var_7_0.guardian_desc)
	end

	if PLATFORM_CODE ~= PLATFORM_CH then
		GetComponent(findTF(arg_7_1, "name/text"), typeof(Text)).fontSize = 30
		GetComponent(findTF(arg_7_1, "desc/text"), typeof(Text)).fontSize = 24
	end

	if var_7_0.type == 2 then
		setActive(findTF(arg_7_1, "icon/mask/img"), var_7_2)
	end

	LoadImageSpriteAsync("shipyardicon/" .. var_7_0.guardian_painting, findTF(arg_7_1, "icon/mask/img"), true)
	setText(findTF(arg_7_1, "tip/text"), var_7_1)
	setActive(findTF(arg_7_1, "icon/lock"), not var_7_2)
	setActive(findTF(arg_7_1, "got"), var_7_2)

	return
end

function OtherWorldTempleChars:updateItemsCount(arg_8_1)
	for iter_8_0 = 1, (arg_8_1 > #self._charItems or nil) and arg_8_1 - #self._charItems do
		local var_8_1 = tf(instantiate(self._charTpl))

		SetParent(var_8_1, self._charContent)
		table.insert(self._charItems, var_8_1)
	end

	return
end

function OtherWorldTempleChars:setActive(arg_9_1)
	setActive(self._tf, arg_9_1)

	return
end

return OtherWorldTempleChars
