class = var_0_10000

local var_0_0 = var_0_10000("CommanderCatCard")

var_0_0.MARK_TYPE_CIRCLE = 1
var_0_0.MARK_TYPE_TICK = 2

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1
	tf = var_1_10003
	arg_1_0._tf = var_1_10003(arg_1_1)

	local var_1_0 = arg_1_0._tf

	arg_1_0.infoTF = var_3.Find(var_1_0, "info")

	local var_1_1 = arg_1_0._tf

	arg_1_0.emptyTF = var_3.Find(var_1_1, "empty")

	local var_1_2 = arg_1_0._tf

	arg_1_0.quitTF = var_3.Find(var_1_2, "quit")

	local var_1_3 = arg_1_0.infoTF
	local var_1_4 = var_3.Find(var_1_3, "name_bg/mask/Text")

	arg_1_0.scrollTxt = var_3.GetComponent(var_1_4, "ScrollText")

	local var_1_5 = arg_1_0.infoTF
	local var_1_6 = var_3.Find(var_1_5, "level_bg/Text")
	local var_1_7 = var_3.GetComponent

	typeof = var_5
	Text = var_1_10006
	arg_1_0.levelTF = var_1_7(var_1_6, var_5(var_1_10006))

	local var_1_8 = arg_1_0.infoTF

	arg_1_0.iconTF = var_3.Find(var_1_8, "icon")

	local var_1_9 = {}
	local var_1_10 = arg_1_0.infoTF

	var_1_9[1] = var_4.Find(var_1_10, "mark1")

	local var_1_11 = arg_1_0.infoTF

	var_1_9[2] = var_4.Find(var_1_11, "mark2")
	arg_1_0.marks = var_1_9

	local var_1_12 = arg_1_0._tf

	arg_1_0.expUp = var_3.Find(var_1_12, "up")

	local var_1_13 = arg_1_0.infoTF

	arg_1_0.formationTF = var_3.Find(var_1_13, "formation")
	setActive = var_3

	var_3(arg_1_0.formationTF, false)

	local var_1_14 = arg_1_0.infoTF

	arg_1_0.inbattleTF = var_3.Find(var_1_14, "inbattle")
	setActive = var_3

	var_3(arg_1_0.inbattleTF, false)

	local var_1_15 = arg_1_0._tf

	arg_1_0.tip = var_3.Find(var_1_15, "tip")
	setActive = var_3

	var_3(arg_1_0.tip, false)

	local var_1_16 = arg_1_0._tf

	arg_1_0.lockTr = var_3.Find(var_1_16, "lock")
	ipairs = var_3

	for iter_1_0, iter_1_1 in var_3(arg_1_0.marks) do
		setActive = var_1_10008

		var_1_10008(iter_1_1, false)
	end

	local var_1_17

	if not arg_1_0.marks[arg_1_2] then
		var_1_17 = arg_1_0.marks[1]
	end

	arg_1_0.mark = var_1_17
	setActive = var_1_17

	var_1_17(arg_1_0.expUp, false)

	return
end

function var_0_0.Update(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	IsNil = var_1_10004

	if not var_1_10004(arg_2_0.lockTr) then
		setActive = var_4

		var_4(arg_2_0.lockTr, false)
	end

	if arg_2_1 then
		arg_2_0.commanderVO = arg_2_1

		if arg_2_1.id ~= 0 then
			arg_2_0:UpdateCommander(arg_2_2, arg_2_3)
		end
	end

	setActive = var_4

	local var_2_0 = arg_2_0.formationTF
	local var_2_1

	if arg_2_1 and arg_2_1.inFleet then
		var_2_1 = not arg_2_1.inBattle
	end

	var_4(var_2_0, var_2_1)

	setActive = var_4

	var_4(arg_2_0.inbattleTF, arg_2_1 and arg_2_1.inBattle)

	setActive = var_4

	var_4(arg_2_0.infoTF, arg_2_1 and arg_2_1.id ~= 0)

	setActive = var_4

	var_4(arg_2_0.emptyTF, not arg_2_1)

	setActive = var_4

	var_4(arg_2_0.quitTF, arg_2_1 and arg_2_1.id == 0)

	setActive = var_4

	local var_2_2 = arg_2_0.tip
	local var_2_3

	if arg_2_1 then
		::label_2_1::

		if arg_2_1.id ~= 0 and arg_2_1:getTalentPoint() > 0 then
			LOCK_COMMANDER_TALENT_TIP = var_2_3
			var_2_3 = not var_2_3
		else
			var_2_3 = false
		end

		if false then
			var_2_3 = true
		end
	end

	var_4(var_2_2, var_2_3)

	return
end

function var_0_0.UpdateCommander(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0.commanderVO
	local var_3_1 = arg_3_0.levelTF

	var_3_1.text = var_3_0.level
	GetImageSpriteFromAtlasAsync = var_3_1

	var_3_1("commandericon/" .. var_3_0:getPainting(), "", arg_3_0.iconTF)

	IsNil = var_3_1

	if not var_3_1(arg_3_0.lockTr) then
		setActive = var_4

		var_4(arg_3_0.lockTr, var_3_0:isLocked())
	end

	arg_3_0:UpdateSelected(arg_3_1, arg_3_2)

	return
end

function var_0_0.UpdateSelected(arg_4_0, arg_4_1, arg_4_2)
	if not arg_4_0.commanderVO then
		setActive = var_3

		var_3(arg_4_0.mark, false)

		return
	end

	local var_4_0 = arg_4_1 or {}

	table = var_1_10004

	local var_4_1 = var_1_10004.contains(var_4_0, arg_4_0.commanderVO.id)

	setActive = var_5

	var_5(arg_4_0.mark, var_4_1)
	arg_4_0:UpdateCommanderName(var_4_1, arg_4_2)

	return
end

function var_0_0.UpdateCommanderName(arg_5_0, arg_5_1, arg_5_2)
	if not arg_5_0.commanderVO or var_3.id == 0 then
		local var_5_0 = arg_5_0.scrollTxt

		var_4.SetText(var_5_0, "")

		return
	end

	if arg_5_1 then
		local var_5_1 = arg_5_0.scrollTxt

		var_4.SetText(var_5_1, var_3:getName(arg_5_2))
	else
		local var_5_2 = arg_5_0.scrollTxt
		local var_5_3 = var_4.SetText

		CommanderCatUtil = var_1_10006

		var_5_3(var_5_2, var_1_10006.ShortenString(var_3:getName(arg_5_2), 6))
	end

	return
end

function var_0_0.Dispose(arg_6_0)
	return
end

return var_0_0
