local var_0_0 = class("CommanderCatCard")

var_0_0.MARK_TYPE_CIRCLE = 1
var_0_0.MARK_TYPE_TICK = 2

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = tf(arg_1_1)
	arg_1_0.infoTF = arg_1_0._tf:Find("info")
	arg_1_0.emptyTF = arg_1_0._tf:Find("empty")
	arg_1_0.quitTF = arg_1_0._tf:Find("quit")
	arg_1_0.scrollTxt = arg_1_0.infoTF:Find("name_bg/mask/Text"):GetComponent("ScrollText")
	arg_1_0.levelTF = arg_1_0.infoTF:Find("level_bg/Text"):GetComponent(typeof(Text))
	arg_1_0.iconTF = arg_1_0.infoTF:Find("icon")
	arg_1_0.marks = {
		arg_1_0.infoTF:Find("mark1"),
		arg_1_0.infoTF:Find("mark2")
	}
	arg_1_0.expUp = arg_1_0._tf:Find("up")
	arg_1_0.formationTF = arg_1_0.infoTF:Find("formation")

	setActive(arg_1_0.formationTF, false)

	arg_1_0.inbattleTF = arg_1_0.infoTF:Find("inbattle")

	setActive(arg_1_0.inbattleTF, false)

	arg_1_0.tip = arg_1_0._tf:Find("tip")

	setActive(arg_1_0.tip, false)

	arg_1_0.lockTr = arg_1_0._tf:Find("lock")

	for iter_1_0, iter_1_1 in ipairs(arg_1_0.marks) do
		setActive(iter_1_1, false)
	end

	arg_1_0.mark = arg_1_0.marks[arg_1_2] or arg_1_0.marks[1]

	setActive(arg_1_0.expUp, false)

	return
end

function var_0_0.Update(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	if not IsNil(arg_2_0.lockTr) then
		setActive(arg_2_0.lockTr, false)
	end

	if arg_2_1 then
		arg_2_0.commanderVO = arg_2_1

		if arg_2_1.id ~= 0 then
			arg_2_0:UpdateCommander(arg_2_2, arg_2_3)
		end
	end

	local var_2_1

	if arg_2_1 then
		::label_2_0::

		var_2_1 = arg_2_1.inFleet and not arg_2_1.inBattle
	end

	var_2_0(arg_2_0.formationTF, var_2_1)
	setActive(arg_2_0.inbattleTF, arg_2_1 and arg_2_1.inBattle)
	setActive(arg_2_0.infoTF, arg_2_1 and arg_2_1.id ~= 0)
	setActive(arg_2_0.emptyTF, not arg_2_1)
	setActive(arg_2_0.quitTF, arg_2_1 and arg_2_1.id == 0)
	setActive(arg_2_0.tip, arg_2_1 and arg_2_1.id ~= 0 and arg_2_1:getTalentPoint() > 0 and not LOCK_COMMANDER_TALENT_TIP)

	return
end

function var_0_0.UpdateCommander(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.levelTF.text = arg_3_0.commanderVO.level

	GetImageSpriteFromAtlasAsync("commandericon/" .. arg_3_0.commanderVO:getPainting(), "", arg_3_0.iconTF)

	if not IsNil(arg_3_0.lockTr) then
		setActive(arg_3_0.lockTr, arg_3_0.commanderVO:isLocked())
	end

	arg_3_0:UpdateSelected(arg_3_1, arg_3_2)

	return
end

function var_0_0.UpdateSelected(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0

	if not arg_4_0.commanderVO then
		setActive(arg_4_0.mark, false)

		do return end

		var_4_0 = table.contains
	end

	local var_4_1 = var_4_0(arg_4_1 or {}, arg_4_0.commanderVO.id)

	setActive(arg_4_0.mark, var_4_1)
	arg_4_0:UpdateCommanderName(var_4_1, arg_4_2)

	return
end

function var_0_0.UpdateCommanderName(arg_5_0, arg_5_1, arg_5_2)
	if not arg_5_0.commanderVO or arg_5_0.commanderVO.id == 0 then
		arg_5_0.scrollTxt:SetText("")

		return
	end

	if arg_5_1 then
		arg_5_0.scrollTxt:SetText(arg_5_0.commanderVO:getName(arg_5_2))
	else
		arg_5_0.scrollTxt:SetText(CommanderCatUtil.ShortenString(arg_5_0.commanderVO:getName(arg_5_2), 6))
	end

	return
end

function var_0_0.Dispose(arg_6_0)
	return
end

return var_0_0
