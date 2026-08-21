local var_0_0 = class("NewEducateRankCard")

var_0_0.TYPE_SELF = 1
var_0_0.TYPE_OTHER = 2

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	arg_1_0._type = arg_1_2
	arg_1_0.parent = arg_1_3
	arg_1_0.bg1TF = arg_1_0._tf:Find("1")
	arg_1_0.bg2TF = arg_1_0._tf:Find("2")
	arg_1_0.bg3TF = arg_1_0._tf:Find("3")
	arg_1_0.rankText = arg_1_0._tf:Find("Text"):GetComponent(typeof(Text))
	arg_1_0.notOnTF = arg_1_0._tf:Find("not_on")

	setText(arg_1_0.notOnTF, i18n("child2_rank_not_on"))

	arg_1_0.iconTF = arg_1_0._tf:Find("icon_bg/icon")
	arg_1_0.callNameText = arg_1_0._tf:Find("call_name"):GetComponent(typeof(Text))
	arg_1_0.playerNameText = arg_1_0._tf:Find("player_name/Text"):GetComponent(typeof(Text))
	arg_1_0.valueText = arg_1_0._tf:Find("value"):GetComponent(typeof(Text))

	return
end

function var_0_0.Update(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.rankVO = arg_2_1

	local var_2_0 = arg_2_1.rank

	arg_2_0.rankText.text = arg_2_1.rank > 9 and var_2_0 or "0" .. var_2_0

	local var_2_1 = arg_2_1.power

	if arg_2_2 == PowerRank.TYPE_TB_ENDLESS_WAVE then
		var_2_1 = math.max(0, var_2_1 - getProxy(NewEducateProxy):GetCurChar():GetRoundData():GetGameRoundCnt())
	end

	arg_2_0.valueText.text = var_2_1

	local var_2_2 = string.split(arg_2_1.name, "|")

	arg_2_0.callNameText.text = var_2_2[2]
	arg_2_0.playerNameText.text = var_2_2[1]

	setActive(arg_2_0.bg1TF, var_2_0 == 1)
	setActive(arg_2_0.bg2TF, var_2_0 == 2)
	setActive(arg_2_0.bg3TF, var_2_0 == 3)

	local var_2_3 = arg_2_0._type ~= var_0_0.TYPE_SELF or var_2_0 > 0

	setActive(arg_2_0.rankText, (arg_2_0._type ~= var_0_0.TYPE_SELF or var_2_0 > 0) and var_2_0 > 3)
	setActive(arg_2_0.notOnTF, not var_2_3)
	GetImageSpriteFromAtlasAsync("qicon/" .. pg.ship_skin_template[arg_2_1.skinId].prefab, "", arg_2_0.iconTF)

	return
end

function var_0_0.Dispose(arg_3_0)
	return
end

return var_0_0
