class = var_0_10000

local var_0_0 = var_0_10000("CommanderCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	tf = var_1_10002
	arg_1_0._tf = var_1_10002(arg_1_1)

	local var_1_0 = arg_1_0._tf

	arg_1_0.infoTF = var_2.Find(var_1_0, "info")

	local var_1_1 = arg_1_0._tf

	arg_1_0.emptyTF = var_2.Find(var_1_1, "empty")

	local var_1_2 = arg_1_0._tf

	arg_1_0.quitTF = var_2.Find(var_1_2, "quit")

	local var_1_3 = arg_1_0.infoTF
	local var_1_4 = var_2.Find(var_1_3, "name_bg/mask/Text")

	arg_1_0.scrollTxt = var_2.GetComponent(var_1_4, "ScrollText")

	local var_1_5 = arg_1_0.infoTF
	local var_1_6 = var_2.Find(var_1_5, "level_bg/Text")
	local var_1_7 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.levelTF = var_1_7(var_1_6, var_5(var_1_10007))

	local var_1_8 = arg_1_0.infoTF

	arg_1_0.iconTF = var_2.Find(var_1_8, "icon")

	local var_1_9 = arg_1_0.infoTF

	arg_1_0.mark2 = var_2.Find(var_1_9, "mark1")

	local var_1_10 = arg_1_0.infoTF

	arg_1_0.mark1 = var_2.Find(var_1_10, "mark2")
	setActive = var_2

	var_2(arg_1_0.mark1, false)

	setActive = var_2

	var_2(arg_1_0.mark2, false)

	local var_1_11 = arg_1_0._tf

	arg_1_0.expUp = var_2.Find(var_1_11, "up")
	setActive = var_2

	var_2(arg_1_0.expUp, false)

	local var_1_12 = arg_1_0.infoTF

	arg_1_0.formationTF = var_2.Find(var_1_12, "formation")

	local var_1_13 = arg_1_0.infoTF

	arg_1_0.inbattleTF = var_2.Find(var_1_13, "inbattle")
	setActive = var_2

	var_2(arg_1_0.inbattleTF, false)

	setActive = var_2

	var_2(arg_1_0.formationTF, false)

	local var_1_14 = arg_1_0._tf

	arg_1_0.tip = var_2.Find(var_1_14, "tip")
	setActive = var_2

	var_2(arg_1_0.tip, false)

	local var_1_15 = arg_1_0._tf

	arg_1_0.lockTr = var_2.Find(var_1_15, "lock")

	return
end

function var_0_0.clearSelected(arg_2_0)
	setActive = var_1_10001

	var_1_10001(arg_2_0.mark1, false)

	setActive = var_1_10001

	var_1_10001(arg_2_0.mark2, false)

	setActive = var_1_10001

	var_1_10001(arg_2_0.expUp, false)
	arg_2_0:UpdateCommanderName(arg_2_0.commanderVO, false)

	return
end

function var_0_0.selectedAnim(arg_3_0)
	LeanTween = var_1_10001

	if var_1_10001.isTweening(arg_3_0.infoTF) then
		LeanTween = var_1

		var_1.cancel(arg_3_0.infoTF)
	end

	local var_3_0 = 20

	LeanTween = var_1_10002

	local var_3_1 = var_1_10002.moveY

	rtf = var_1_10004

	local var_3_2 = var_3_1(var_1_10004(arg_3_0.infoTF), var_3_0, 0.1)
	local var_3_3 = var_2.setOnComplete

	System = var_5

	var_3_3(var_3_2, var_5.Action(function()
		LeanTween = var_2_10000

		local var_4_0 = var_2_10000.moveY

		rtf = var_2_10002

		var_4_0(var_2_10002(arg_3_0.infoTF), 0, 0.1)

		return
	end))
	arg_3_0:UpdateCommanderName(arg_3_0.commanderVO, true)

	return
end

function var_0_0.update(arg_5_0, arg_5_1)
	IsNil = var_1_10002

	if not var_1_10002(arg_5_0.lockTr) then
		setActive = var_2

		var_2(arg_5_0.lockTr, false)
	end

	if arg_5_1 then
		arg_5_0.commanderVO = arg_5_1

		if arg_5_1.id ~= 0 then
			arg_5_0:updateCommander()
		end
	end

	setActive = var_2

	local var_5_0 = arg_5_0.formationTF
	local var_5_1

	if arg_5_1 and arg_5_1.inFleet then
		var_5_1 = not arg_5_1.inBattle
	end

	var_2(var_5_0, var_5_1)

	setActive = var_2

	var_2(arg_5_0.inbattleTF, arg_5_1 and arg_5_1.inBattle)

	setActive = var_2

	var_2(arg_5_0.infoTF, arg_5_1 and arg_5_1.id ~= 0)

	setActive = var_2

	var_2(arg_5_0.emptyTF, not arg_5_1)

	setActive = var_2

	var_2(arg_5_0.quitTF, arg_5_1 and arg_5_1.id == 0)

	setActive = var_2

	local var_5_2 = arg_5_0.tip
	local var_5_3

	if arg_5_1 then
		::label_5_1::

		if arg_5_1.id ~= 0 and arg_5_1:getTalentPoint() > 0 then
			LOCK_COMMANDER_TALENT_TIP = var_5_3
			var_5_3 = not var_5_3
		else
			var_5_3 = false
		end

		if false then
			var_5_3 = true
		end
	end

	var_2(var_5_2, var_5_3)

	return
end

function var_0_0.updateCommander(arg_6_0)
	local var_6_0 = arg_6_0.commanderVO

	arg_6_0:UpdateCommanderName(var_6_0, false)

	local var_6_1 = arg_6_0.levelTF

	var_6_1.text = var_6_0.level
	GetImageSpriteFromAtlasAsync = var_6_1

	var_6_1("commandericon/" .. var_6_0:getPainting(), "", arg_6_0.iconTF)

	IsNil = var_6_1

	if not var_6_1(arg_6_0.lockTr) then
		setActive = var_2

		var_2(arg_6_0.lockTr, var_6_0:isLocked())
	end

	return
end

function var_0_0.UpdateCommanderName(arg_7_0, arg_7_1, arg_7_2)
	if not arg_7_1 or arg_7_1.id == 0 then
		return
	end

	if arg_7_2 then
		local var_7_0 = arg_7_0.scrollTxt

		var_3.SetText(var_7_0, arg_7_1:getName())
	else
		local var_7_1 = arg_7_0.scrollTxt

		var_3.SetText(var_7_1, arg_7_0:ShortenString(arg_7_1:getName(), 6))
	end

	return
end

function var_0_0.ShortenString(arg_8_0, arg_8_1, arg_8_2)
	local function var_8_0(arg_9_0)
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
	end

	local var_8_1 = 1
	local var_8_2 = 0
	local var_8_3 = 0
	local var_8_4 = #arg_8_1
	local var_8_5 = false

	while var_8_1 <= var_8_4 do
		string = var_1_10009
		var_1_10009 = var_1_10009.byte(arg_8_1, var_8_1)

		local var_8_6, var_8_7 = var_8_0(var_1_10009)

		var_8_1 = var_8_1 + var_8_6
		var_8_2 = var_8_2 + var_8_7
		math = var_12

		if var_12.ceil(var_8_2) == arg_8_2 - 1 then
			var_8_3 = var_8_1
		elseif arg_8_2 < var_12 then
			var_8_5 = true

			break
		end
	end

	if var_8_3 == 0 or var_8_4 < var_8_3 or not var_8_5 then
		return arg_8_1
	end

	string = var_1_10009

	return var_1_10009.sub(arg_8_1, 1, var_8_3 - 1) .. ".."
end

function var_0_0.clear(arg_10_0)
	LeanTween = var_1_10001

	if var_1_10001.isTweening(arg_10_0.infoTF) then
		LeanTween = var_1

		var_1.cancel(arg_10_0.infoTF)
	end

	return
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0:clear()

	return
end

return var_0_0
