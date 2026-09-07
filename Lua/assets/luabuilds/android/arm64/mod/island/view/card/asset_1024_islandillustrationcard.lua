local IslandIllustrationCard = class("IslandIllustrationCard")

function IslandIllustrationCard:Ctor(arg_1_1)
	self._go = arg_1_1
	self._tf = arg_1_1.transform
	self.bgTF = self._tf:Find("bg")
	self.bottomTF = self._tf:Find("bottom")
	self.nameTF = self._tf:Find("name")
	self.scrollNameTF = self._tf:Find("scrollName/Text")
	self.iconTF = self._tf:Find("mask/icon")
	self.selectedTF = self._tf:Find("selected")
	self.phaseTF = self._tf:Find("phase")
	self.lockTF = self._tf:Find("lock")
	self.canUnLockTF = self._tf:Find("can_unlock")

	setText(self.canUnLockTF:Find("Text"), i18n("island_guide_active"))

	self.tipTF = self._tf:Find("tip")

	return
end

function IslandIllustrationCard:Update(arg_2_1, arg_2_2)
	self.illustration = arg_2_1
	self._go.name = self.illustration.id

	GetImageSpriteFromAtlasAsync(self.illustration:GetIcon(), "", self.iconTF, true)

	local var_2_0 = self.illustration:getConfig("type")
	local var_2_1 = var_2_0 == IslandIllustration.TYPES.ITEM

	if var_2_0 == IslandIllustration.TYPES.ITEM then
		GetImageSpriteFromAtlasAsync("ui/islandbookui_atlas", "item_bg_" .. self.illustration:getLinkConfig("rarity"), self.bgTF, true)
	end

	local var_2_2 = self.illustration:GetStatus()
	local var_2_3 = var_2_2 == IslandIllustration.STATUS.LOCK

	setActive(self.lockTF, var_2_2 == IslandIllustration.STATUS.LOCK)
	setGray(self.iconTF, var_2_3, true)
	setImageAlpha(self.iconTF, var_2_3 and 0.5 or 1)
	setActive(self.bottomTF, not var_2_3 and not var_2_1 and var_2_0 ~= IslandIllustration.TYPES.FISH)
	setActive(self.canUnLockTF, var_2_2 == IslandIllustration.STATUS.CAN_UNLOCK)
	setActive(self.tipTF, self.illustration:IsTip())

	local var_2_4 = var_2_1 and not var_2_3

	setActive(self.phaseTF, var_2_1 and not var_2_3)

	if var_2_4 then
		local var_2_5 = self.illustration:GetCurPhase()

		setActive(self.phaseTF, var_2_5 > 0)

		if var_2_5 > 0 then
			GetImageSpriteFromAtlasAsync("ui/islandbookui_atlas", "item_phase_" .. var_2_5, self.phaseTF, true)
		end
	end

	if not var_2_3 and var_2_2 ~= IslandIllustration.STATUS.CAN_UNLOCK then
		local var_2_6 = self.illustration:GetName()

		if GetPerceptualSize(var_2_6) < 7 then
			setActive(self.nameTF, true)
			setText(self.nameTF, var_2_6)
			setActive(self.scrollNameTF, false)
		else
			setActive(self.scrollNameTF, true)
			setScrollText(self.scrollNameTF, var_2_6)
			setActive(self.nameTF, false)
		end
	else
		setActive(self.nameTF, false)
		setActive(self.scrollNameTF, false)
	end

	self:UpdateSelected(arg_2_2)

	return
end

function IslandIllustrationCard:UpdateSelected(arg_3_1)
	self.isSel = arg_3_1 and arg_3_1 == self.illustration.id

	setActive(self.selectedTF, self.isSel)

	return
end

function IslandIllustrationCard:PlayUnlockAnim(arg_4_1)
	if not table.contains(arg_4_1, self.illustration.id) then
		return
	end

	self._tf:GetComponent(typeof(Animation)):Play()

	return
end

function IslandIllustrationCard:Dispose()
	return
end

return IslandIllustrationCard
