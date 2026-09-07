local SailBoatEquipUI = class("SailBoatEquipUI")
local var_0_1

function SailBoatEquipUI:Ctor(arg_1_1, arg_1_2)
	self._tf = arg_1_1
	self._event = arg_1_2
	var_0_1 = SailBoatGameVo
	self._equipUI = findTF(self._tf, "ui/equipUI")
	self.btnBack = findTF(self._equipUI, "back")
	self.btnBack1 = findTF(self._equipUI, "back_1")
	self.btnStart = findTF(self._equipUI, "btnStart")

	onButton(self._event, self.btnBack1, function()
		self:show(false)
		self._event:emit(SailBoatGameView.BACK_MENU)

		return
	end, SFX_CONFIRM)
	onButton(self._event, self.btnStart, function()
		self._event:emit(SailBoatGameView.READY_START)

		return
	end, SFX_CONFIRM)

	self.selectTpl = findTF(self._equipUI, "selectItem")
	self.equipTpl = findTF(self._equipUI, "equipItem")
	self.selectContent = findTF(self._equipUI, "select/ad/list")
	self.equipContent = findTF(self._equipUI, "equip/list")
	self.unEquipFlag = false
	self.baseHp = SailBoatGameConst.game_char[var_0_1.char_id].hp
	self.baseSpeed = SailBoatGameConst.game_char[var_0_1.char_id].speed.x
	self.speedTf = findTF(self._equipUI, "equip/speed")
	self.hpTf = findTF(self._equipUI, "equip/hp")
	self.btnUnEquip = findTF(self._equipUI, "btnUnEquip")

	onButton(self._event, self.btnUnEquip, function()
		self.unEquipFlag = self.curSelectItem and true or not self.unEquipFlag

		if self.unEquipFlag then
			self.curSelectData = nil
			self.curSelectItem = nil
		end

		self:updateUI()

		return
	end)

	self.selects = {}

	for iter_1_0 = 1, #SailBoatGameConst.equip_data do
		local var_1_0 = SailBoatGameConst.equip_data[iter_1_0]
		local var_1_1 = tf(instantiate(self.selectTpl))

		onButton(self._event, var_1_1, function()
			if self.curSelectItem == var_1_1 then
				self.curSelectItem = nil
				self.curSelectData = nil
			else
				self.curSelectItem = var_1_1
				self.curSelectData = var_1_0

				if self.unEquipFlag then
					self.unEquipFlag = false
				end
			end

			self:updateUI()

			return
		end, SFX_CANCEL)

		local var_1_2 = GetComponent(findTF(var_1_1, "icon"), typeof(Image))

		var_1_2.sprite = var_0_1.GetEquipIcon(SailBoatGameConst.equip_data[iter_1_0].icon)

		var_1_2:SetNativeSize()
		SetParent(var_1_1, self.selectContent)
		table.insert(self.selects, var_1_1)
	end

	self.equips = {}
	self.equipItems = {}

	for iter_1_1 = 1, SailBoatGameConst.max_equip_count do
		table.insert(self.equips, 0)
	end

	for iter_1_2 = 1, SailBoatGameConst.max_equip_count do
		local var_1_3 = iter_1_2
		local var_1_4 = tf(instantiate(self.equipTpl))

		onButton(self._event, var_1_4, function()
			local var_6_0 = var_0_1.GetGameUseTimes()

			if var_0_1.GetGameTimes() > 0 then
				var_6_0 = var_6_0 + 1
			end

			if SailBoatGameConst.game_round[var_6_0].equip_count >= var_1_3 then
				if self.curSelectData then
					if not self:checkEquipAble(self.curSelectData.id) then
						return
					end

					self.equips[iter_1_2] = self.curSelectData.id
				elseif self.unEquipFlag then
					self.equips[iter_1_2] = 0
				end

				self:updateUI()
			end

			return
		end, SFX_CANCEL)
		SetParent(var_1_4, self.equipContent)
		table.insert(self.equipItems, var_1_4)
	end

	self.descTf = findTF(self._equipUI, "desc")
	self.descTextTf = findTF(self._equipUI, "desc/bg/desc")
	self.curSelectItem = nil
	self.curSelectData = nil

	self:showUI()
	self:updateUI()

	return
end

function SailBoatEquipUI:show(arg_7_1)
	setActive(self._equipUI, arg_7_1)
	self:showUI()
	self:updateUI()

	return
end

function SailBoatEquipUI:showUI()
	local var_8_0 = var_0_1.GetGameUseTimes()

	if var_0_1.GetGameTimes() > 0 then
		var_8_0 = var_8_0 + 1
	end

	self.roundEquipData = SailBoatGameConst.game_equip_round[var_8_0]

	for iter_8_0 = 1, #self.selects do
		if self.roundEquipData[iter_8_0][2] == 0 then
			setActive(self.selects[iter_8_0], false)
		else
			setActive(self.selects[iter_8_0], true)
		end
	end

	return
end

function SailBoatEquipUI:checkEquipAble(arg_9_1)
	local var_9_0 = 0
	local var_9_1 = var_0_1.GetGameUseTimes()

	if var_0_1.GetGameTimes() > 0 then
		var_9_1 = var_9_1 + 1
	end

	local var_9_2 = SailBoatGameConst.game_equip_round[var_9_1]

	for iter_9_0 = 1, #SailBoatGameConst.game_equip_round[var_9_1] do
		if var_9_2[iter_9_0][1] == arg_9_1 then
			var_9_0 = var_9_2[iter_9_0][2]
		end
	end

	if var_9_0 == 0 then
		return false, 0, 0
	end

	local var_9_3 = 0

	for iter_9_1 = 1, #self.equips do
		if self.equips[iter_9_1] == arg_9_1 then
			var_9_3 = var_9_3 + 1
		end
	end

	if var_9_0 <= var_9_3 then
		return false, var_9_3, var_9_0
	end

	return true, var_9_3, var_9_0
end

function SailBoatEquipUI:updateUI()
	for iter_10_0 = 1, #self.selects do
		local var_10_0 = self.selects[iter_10_0]

		setActive(findTF(self.selects[iter_10_0], "select"), self.curSelectItem == self.selects[iter_10_0])

		local var_10_1, var_10_2, var_10_3 = self:checkEquipAble(iter_10_0)

		setText(findTF(var_10_0, "amount"), var_10_3 - var_10_2)
	end

	setActive(self.descTf, self.curSelectItem ~= nil)

	if self.curSelectItem then
		self.descTf.anchoredPosition = self._equipUI:InverseTransformPoint(self.curSelectItem.position)

		setText(self.descTextTf, i18n(self.curSelectData.desc))
	end

	local var_10_4 = var_0_1.GetGameUseTimes()

	if var_0_1.GetGameTimes() > 0 then
		var_10_4 = var_10_4 + 1
	end

	local var_10_5 = SailBoatGameConst.game_round[var_10_4].equip_count

	for iter_10_1 = 1, SailBoatGameConst.max_equip_count do
		local var_10_7 = self.equips[iter_10_1]
		local var_10_8 = self.equipItems[iter_10_1]

		setActive(findTF(self.equipItems[iter_10_1], "lock"), var_10_5 < iter_10_1)
		setActive(findTF(var_10_8, "empty"), false)
		setActive(findTF(var_10_8, "bg"), false)
		setActive(findTF(var_10_8, "icon"), false)
		setActive(findTF(var_10_8, "unEquip"), false)
		setActive(findTF(var_10_8, "add"), false)
		setActive(findTF(var_10_8, "add_2"), false)

		local var_10_9 = true

		if var_10_7 ~= 0 then
			local var_10_10 = GetComponent(findTF(var_10_8, "icon"), typeof(Image))

			var_10_10.sprite = var_0_1.GetEquipIcon(SailBoatGameConst.equip_data[var_10_7].icon)

			var_10_10:SetNativeSize()
			setActive(findTF(var_10_8, "bg"), true)
			setActive(findTF(var_10_8, "icon"), true)

			if self.unEquipFlag then
				setActive(findTF(var_10_8, "unEquip"), true)
			end

			var_10_9 = false
		else
			setActive(findTF(var_10_8, "empty"), true)
		end

		if self.curSelectItem and iter_10_1 <= var_10_5 then
			if var_10_9 then
				setActive(findTF(var_10_8, "add"), true)
			else
				setActive(findTF(var_10_8, "add_2"), true)
			end
		end
	end

	local var_10_11 = self.baseHp
	local var_10_12 = self.baseSpeed

	for iter_10_2 = 1, #self.equips do
		if self.equips[iter_10_2] ~= 0 then
			var_10_11 = var_10_11 + SailBoatGameConst.equip_data[self.equips[iter_10_2]].hp
			var_10_12 = var_10_12 + SailBoatGameConst.equip_data[self.equips[iter_10_2]].speed
		end
	end

	setText(self.speedTf, tostring(var_10_12))
	setText(self.hpTf, tostring(var_10_11))

	var_0_1.equips = self.equips

	return
end

return SailBoatEquipUI
