local var_0_0 = class("CommanderCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = tf(arg_1_1)
	arg_1_0.infoTF = arg_1_0._tf:Find("info")
	arg_1_0.emptyTF = arg_1_0._tf:Find("empty")
	arg_1_0.quitTF = arg_1_0._tf:Find("quit")
	arg_1_0.scrollTxt = arg_1_0.infoTF:Find("name_bg/mask/Text"):GetComponent("ScrollText")
	arg_1_0.levelTF = arg_1_0.infoTF:Find("level_bg/Text"):GetComponent(typeof(Text))
	arg_1_0.iconTF = arg_1_0.infoTF:Find("icon")
	arg_1_0.mark2 = arg_1_0.infoTF:Find("mark1")
	arg_1_0.mark1 = arg_1_0.infoTF:Find("mark2")

	setActive(arg_1_0.mark1, false)
	setActive(arg_1_0.mark2, false)

	arg_1_0.expUp = arg_1_0._tf:Find("up")

	setActive(arg_1_0.expUp, false)

	arg_1_0.formationTF = arg_1_0.infoTF:Find("formation")
	arg_1_0.inbattleTF = arg_1_0.infoTF:Find("inbattle")

	setActive(arg_1_0.inbattleTF, false)
	setActive(arg_1_0.formationTF, false)

	arg_1_0.tip = arg_1_0._tf:Find("tip")

	setActive(arg_1_0.tip, false)

	arg_1_0.lockTr = arg_1_0._tf:Find("lock")

	return
end

function var_0_0.clearSelected(arg_2_0)
	setActive(arg_2_0.mark1, false)
	setActive(arg_2_0.mark2, false)
	setActive(arg_2_0.expUp, false)
	arg_2_0:UpdateCommanderName(arg_2_0.commanderVO, false)

	return
end

function var_0_0.selectedAnim(arg_3_0)
	if LeanTween.isTweening(arg_3_0.infoTF) then
		LeanTween.cancel(arg_3_0.infoTF)
	end

	LeanTween.moveY(rtf(arg_3_0.infoTF), 20, 0.1):setOnComplete(System.Action(function()
		LeanTween.moveY(rtf(arg_3_0.infoTF), 0, 0.1)

		return
	end))
	arg_3_0:UpdateCommanderName(arg_3_0.commanderVO, true)

	return
end

function var_0_0.update(arg_5_0, arg_5_1)
	if not IsNil(arg_5_0.lockTr) then
		setActive(arg_5_0.lockTr, false)
	end

	if arg_5_1 then
		arg_5_0.commanderVO = arg_5_1

		if arg_5_1.id ~= 0 then
			arg_5_0:updateCommander()
		end
	end

	local var_5_1

	if arg_5_1 then
		::label_5_0::

		var_5_1 = arg_5_1.inFleet and not arg_5_1.inBattle
	end

	var_5_0(arg_5_0.formationTF, var_5_1)
	setActive(arg_5_0.inbattleTF, arg_5_1 and arg_5_1.inBattle)
	setActive(arg_5_0.infoTF, arg_5_1 and arg_5_1.id ~= 0)
	setActive(arg_5_0.emptyTF, not arg_5_1)
	setActive(arg_5_0.quitTF, arg_5_1 and arg_5_1.id == 0)
	setActive(arg_5_0.tip, arg_5_1 and arg_5_1.id ~= 0 and arg_5_1:getTalentPoint() > 0 and not LOCK_COMMANDER_TALENT_TIP)

	return
end

function var_0_0.updateCommander(arg_6_0)
	arg_6_0:UpdateCommanderName(arg_6_0.commanderVO, false)

	arg_6_0.levelTF.text = arg_6_0.commanderVO.level

	GetImageSpriteFromAtlasAsync("commandericon/" .. arg_6_0.commanderVO:getPainting(), "", arg_6_0.iconTF)

	if not IsNil(arg_6_0.lockTr) then
		setActive(arg_6_0.lockTr, arg_6_0.commanderVO:isLocked())
	end

	return
end

function var_0_0.UpdateCommanderName(arg_7_0, arg_7_1, arg_7_2)
	if not arg_7_1 or arg_7_1.id == 0 then
		return
	end

	if arg_7_2 then
		arg_7_0.scrollTxt:SetText(arg_7_1:getName())
	else
		arg_7_0.scrollTxt:SetText(arg_7_0:ShortenString(arg_7_1:getName(), 6))
	end

	return
end

function var_0_0.ShortenString(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = 1
	local var_8_1 = 0
	local var_8_2 = 0
	local var_8_3 = false

	while var_8_0 <= #arg_8_1 do
		local var_8_4, var_8_5 = (function(arg_9_0)
			if not arg_9_0 then
				return 0, 1
			elseif arg_9_0 > 240 then
				return 4, 1
			elseif arg_9_0 > 225 then
				return 3, 1
			elseif arg_9_0 > 192 then
				return 2, 1
			elseif arg_9_0 < 126 then
				return 1, 0.75
			else
				return 1, 1
			end

			return
		end)((string.byte(arg_8_1, var_8_0)))

		var_8_0 = var_8_0 + var_8_4
		var_8_1 = var_8_1 + var_8_5

		local var_8_6 = math.ceil(var_8_1)

		if var_8_6 == arg_8_2 - 1 then
			var_8_2 = var_8_0
		elseif arg_8_2 < var_8_6 then
			var_8_3 = true

			break
		end
	end

	if var_8_2 == 0 or #arg_8_1 < var_8_2 or not var_8_3 then
		return arg_8_1
	end

	return string.sub(arg_8_1, 1, var_8_2 - 1) .. ".."
end

function var_0_0.clear(arg_10_0)
	if LeanTween.isTweening(arg_10_0.infoTF) then
		LeanTween.cancel(arg_10_0.infoTF)
	end

	return
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0:clear()

	return
end

return var_0_0
