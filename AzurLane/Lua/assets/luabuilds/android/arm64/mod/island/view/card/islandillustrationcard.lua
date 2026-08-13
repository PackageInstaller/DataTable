class = var_0_10000

local var_0_0 = var_0_10000("IslandIllustrationCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform

	local var_1_0 = arg_1_0._tf

	arg_1_0.bgTF = var_2.Find(var_1_0, "bg")

	local var_1_1 = arg_1_0._tf

	arg_1_0.bottomTF = var_2.Find(var_1_1, "bottom")

	local var_1_2 = arg_1_0._tf

	arg_1_0.nameTF = var_2.Find(var_1_2, "name")

	local var_1_3 = arg_1_0._tf

	arg_1_0.scrollNameTF = var_2.Find(var_1_3, "scrollName/Text")

	local var_1_4 = arg_1_0._tf

	arg_1_0.iconTF = var_2.Find(var_1_4, "mask/icon")

	local var_1_5 = arg_1_0._tf

	arg_1_0.selectedTF = var_2.Find(var_1_5, "selected")

	local var_1_6 = arg_1_0._tf

	arg_1_0.phaseTF = var_2.Find(var_1_6, "phase")

	local var_1_7 = arg_1_0._tf

	arg_1_0.lockTF = var_2.Find(var_1_7, "lock")

	local var_1_8 = arg_1_0._tf

	arg_1_0.canUnLockTF = var_2.Find(var_1_8, "can_unlock")
	setText = var_2

	local var_1_9 = arg_1_0.canUnLockTF
	local var_1_10 = var_4.Find(var_1_9, "Text")

	i18n = var_5

	var_2(var_1_10, var_5("island_guide_active"))

	local var_1_11 = arg_1_0._tf

	arg_1_0.tipTF = var_2.Find(var_1_11, "tip")

	return
end

function var_0_0.Update(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.illustration = arg_2_1

	local var_2_0 = arg_2_0._go

	var_2_0.name = arg_2_0.illustration.id
	GetImageSpriteFromAtlasAsync = var_2_0

	local var_2_1 = arg_2_0.illustration

	var_2_0(var_5.GetIcon(var_2_1), "", arg_2_0.iconTF, true)

	local var_2_2 = arg_2_0.illustration
	local var_2_3 = var_3.getConfig(var_2_2, "type")

	IslandIllustration = var_4

	if var_2_3 == var_4.TYPES.ITEM then
		local var_2_4 = arg_2_0.illustration
		local var_2_5 = var_5.getLinkConfig(var_2_4, "rarity")

		GetImageSpriteFromAtlasAsync = var_6

		var_6("ui/islandbookui_atlas", "item_bg_" .. var_2_5, arg_2_0.bgTF, true)
	end

	local var_2_6 = arg_2_0.illustration
	local var_2_7 = var_5.GetStatus(var_2_6)

	IslandIllustration = var_6

	local var_2_8 = var_2_7 == var_6.STATUS.LOCK

	setActive = var_2_6

	var_2_6(arg_2_0.lockTF, var_2_8)

	setGray = var_2_6

	var_2_6(arg_2_0.iconTF, var_2_8, true)

	setImageAlpha = var_2_6

	var_2_6(arg_2_0.iconTF, var_2_8 and 0.5 or 1)

	setActive = var_2_6

	local var_2_9 = arg_2_0.bottomTF

	if not var_2_8 and not var_4 then
		IslandIllustration = var_10

		local var_2_10

		if var_2_3 == var_10.TYPES.FISH then
			var_2_10 = false
		else
			var_2_10 = true
		end

		var_2_6(var_2_9, var_2_10)

		setActive = var_2_6

		local var_2_11 = arg_2_0.canUnLockTF

		IslandIllustration = var_2_10

		var_2_6(var_2_11, var_2_7 == var_2_10.STATUS.CAN_UNLOCK)

		setActive = var_2_6

		local var_2_12 = arg_2_0.tipTF
		local var_2_13 = arg_2_0.illustration

		var_2_6(var_2_12, var_10.IsTip(var_2_13))

		local var_2_14 = var_4 and not var_2_8

		setActive = var_2_16

		var_2_16(arg_2_0.phaseTF, var_2_14)

		local var_2_15, var_2_16

		if var_2_14 then
			var_2_15 = arg_2_0.illustration
			var_2_16 = var_2_16.GetCurPhase(var_2_15)
			setActive = var_2_12

			var_2_12(arg_2_0.phaseTF, var_2_16 > 0)

			if 0 < var_2_16 then
				GetImageSpriteFromAtlasAsync = var_2_12

				var_2_12("ui/islandbookui_atlas", "item_phase_" .. var_2_16, arg_2_0.phaseTF, true)
			end
		end

		if not var_2_8 then
			IslandIllustration = var_2_16

			local var_2_17

			if var_2_7 == var_2_16.STATUS.CAN_UNLOCK then
				var_2_17 = false
			else
				var_2_17 = true
			end

			if var_2_17 then
				local var_2_18 = arg_2_0.illustration

				var_2_12 = var_2_12.GetName(var_2_18)
				GetPerceptualSize = var_2_15

				if var_2_15(var_2_12) < 7 then
					setActive = var_10

					var_10(arg_2_0.nameTF, true)

					setText = var_10

					var_10(arg_2_0.nameTF, var_2_12)

					setActive = var_10

					var_10(arg_2_0.scrollNameTF, false)
				else
					setActive = var_10

					var_10(arg_2_0.scrollNameTF, true)

					setScrollText = var_10

					var_10(arg_2_0.scrollNameTF, var_2_12)

					setActive = var_10

					var_10(arg_2_0.nameTF, false)
				end
			else
				setActive = var_2_12

				var_2_12(arg_2_0.nameTF, false)

				setActive = var_2_12

				var_2_12(arg_2_0.scrollNameTF, false)
			end

			arg_2_0:UpdateSelected(arg_2_2)

			return
		end
	end
end

function var_0_0.UpdateSelected(arg_3_0, arg_3_1)
	arg_3_0.isSel = arg_3_1 and arg_3_1 == arg_3_0.illustration.id
	setActive = var_2

	var_2(arg_3_0.selectedTF, arg_3_0.isSel)

	return
end

function var_0_0.PlayUnlockAnim(arg_4_0, arg_4_1)
	table = var_1_10002

	if not var_1_10002.contains(arg_4_1, arg_4_0.illustration.id) then
		return
	end

	local var_4_0 = arg_4_0._tf
	local var_4_1 = var_2.GetComponent

	typeof = var_5
	Animation = var_1_10007

	local var_4_2 = var_4_1(var_4_0, var_5(var_1_10007))

	var_2.Play(var_4_2)

	return
end

function var_0_0.Dispose(arg_5_0)
	return
end

return var_0_0
