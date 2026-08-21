local var_0_0 = class("IslandIllustrationCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	arg_1_0.bgTF = arg_1_0._tf:Find("bg")
	arg_1_0.bottomTF = arg_1_0._tf:Find("bottom")
	arg_1_0.nameTF = arg_1_0._tf:Find("name")
	arg_1_0.scrollNameTF = arg_1_0._tf:Find("scrollName/Text")
	arg_1_0.iconTF = arg_1_0._tf:Find("mask/icon")
	arg_1_0.selectedTF = arg_1_0._tf:Find("selected")
	arg_1_0.phaseTF = arg_1_0._tf:Find("phase")
	arg_1_0.lockTF = arg_1_0._tf:Find("lock")
	arg_1_0.canUnLockTF = arg_1_0._tf:Find("can_unlock")

	setText(arg_1_0.canUnLockTF:Find("Text"), i18n("island_guide_active"))

	arg_1_0.tipTF = arg_1_0._tf:Find("tip")

	return
end

function var_0_0.Update(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.illustration = arg_2_1
	arg_2_0._go.name = arg_2_0.illustration.id

	GetImageSpriteFromAtlasAsync(arg_2_0.illustration:GetIcon(), "", arg_2_0.iconTF, true)

	local var_2_0 = arg_2_0.illustration:getConfig("type")
	local var_2_1 = var_2_0 == IslandIllustration.TYPES.ITEM

	if var_2_0 == IslandIllustration.TYPES.ITEM then
		GetImageSpriteFromAtlasAsync("ui/islandbookui_atlas", "item_bg_" .. arg_2_0.illustration:getLinkConfig("rarity"), arg_2_0.bgTF, true)
	end

	local var_2_2 = arg_2_0.illustration:GetStatus()
	local var_2_3 = var_2_2 == IslandIllustration.STATUS.LOCK

	setActive(arg_2_0.lockTF, var_2_2 == IslandIllustration.STATUS.LOCK)
	setGray(arg_2_0.iconTF, var_2_3, true)
	setImageAlpha(arg_2_0.iconTF, var_2_3 and 0.5 or 1)
	setActive(arg_2_0.bottomTF, not var_2_3 and not var_2_1 and var_2_0 ~= IslandIllustration.TYPES.FISH)
	setActive(arg_2_0.canUnLockTF, var_2_2 == IslandIllustration.STATUS.CAN_UNLOCK)
	setActive(arg_2_0.tipTF, arg_2_0.illustration:IsTip())

	local var_2_4 = var_2_1 and not var_2_3

	setActive(arg_2_0.phaseTF, var_2_1 and not var_2_3)

	if var_2_4 then
		local var_2_5 = arg_2_0.illustration:GetCurPhase()

		setActive(arg_2_0.phaseTF, var_2_5 > 0)

		if var_2_5 > 0 then
			GetImageSpriteFromAtlasAsync("ui/islandbookui_atlas", "item_phase_" .. var_2_5, arg_2_0.phaseTF, true)
		end
	end

	if not var_2_3 and var_2_2 ~= IslandIllustration.STATUS.CAN_UNLOCK then
		local var_2_6 = arg_2_0.illustration:GetName()

		if GetPerceptualSize(var_2_6) < 7 then
			setActive(arg_2_0.nameTF, true)
			setText(arg_2_0.nameTF, var_2_6)
			setActive(arg_2_0.scrollNameTF, false)
		else
			setActive(arg_2_0.scrollNameTF, true)
			setScrollText(arg_2_0.scrollNameTF, var_2_6)
			setActive(arg_2_0.nameTF, false)
		end
	else
		setActive(arg_2_0.nameTF, false)
		setActive(arg_2_0.scrollNameTF, false)
	end

	arg_2_0:UpdateSelected(arg_2_2)

	return
end

function var_0_0.UpdateSelected(arg_3_0, arg_3_1)
	arg_3_0.isSel = arg_3_1 and arg_3_1 == arg_3_0.illustration.id

	setActive(arg_3_0.selectedTF, arg_3_0.isSel)

	return
end

function var_0_0.PlayUnlockAnim(arg_4_0, arg_4_1)
	if not table.contains(arg_4_1, arg_4_0.illustration.id) then
		return
	end

	arg_4_0._tf:GetComponent(typeof(Animation)):Play()

	return
end

function var_0_0.Dispose(arg_5_0)
	return
end

return var_0_0
