class = var_0_10000

local var_0_0 = var_0_10000("NewEducateRankCard")

var_0_0.TYPE_SELF = 1
var_0_0.TYPE_OTHER = 2

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	arg_1_0._type = arg_1_2
	arg_1_0.parent = arg_1_3

	local var_1_0 = arg_1_0._tf

	arg_1_0.bg1TF = var_4.Find(var_1_0, "1")

	local var_1_1 = arg_1_0._tf

	arg_1_0.bg2TF = var_4.Find(var_1_1, "2")

	local var_1_2 = arg_1_0._tf

	arg_1_0.bg3TF = var_4.Find(var_1_2, "3")

	local var_1_3 = arg_1_0._tf
	local var_1_4 = var_4.Find(var_1_3, "Text")
	local var_1_5 = var_4.GetComponent

	typeof = var_6
	Text = var_1_10007
	arg_1_0.rankText = var_1_5(var_1_4, var_6(var_1_10007))

	local var_1_6 = arg_1_0._tf

	arg_1_0.notOnTF = var_4.Find(var_1_6, "not_on")
	setText = var_4

	local var_1_7 = arg_1_0.notOnTF

	i18n = var_6

	var_4(var_1_7, var_6("child2_rank_not_on"))

	local var_1_8 = arg_1_0._tf

	arg_1_0.iconTF = var_4.Find(var_1_8, "icon_bg/icon")

	local var_1_9 = arg_1_0._tf
	local var_1_10 = var_4.Find(var_1_9, "call_name")
	local var_1_11 = var_4.GetComponent

	typeof = var_6
	Text = var_7
	arg_1_0.callNameText = var_1_11(var_1_10, var_6(var_7))

	local var_1_12 = arg_1_0._tf
	local var_1_13 = var_4.Find(var_1_12, "player_name/Text")
	local var_1_14 = var_4.GetComponent

	typeof = var_6
	Text = var_7
	arg_1_0.playerNameText = var_1_14(var_1_13, var_6(var_7))

	local var_1_15 = arg_1_0._tf
	local var_1_16 = var_4.Find(var_1_15, "value")
	local var_1_17 = var_4.GetComponent

	typeof = var_6
	Text = var_7
	arg_1_0.valueText = var_1_17(var_1_16, var_6(var_7))

	return
end

function var_0_0.Update(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.rankVO = arg_2_1

	local var_2_0 = arg_2_1.rank

	arg_2_0.rankText.text = var_2_0 > 9 and var_2_0 or "0" .. var_2_0

	local var_2_1 = arg_2_1.power

	PowerRank = var_5

	if arg_2_2 == var_5.TYPE_TB_ENDLESS_WAVE then
		math = var_5

		local var_2_2 = var_5.max
		local var_2_3 = 0

		getProxy = var_1_10007
		NewEducateProxy = var_1_10008

		local var_2_4 = var_1_10007(var_1_10008)
		local var_2_5 = var_7.GetCurChar(var_2_4)
		local var_2_6 = var_7.GetRoundData(var_2_5)

		var_2_1 = var_2_2(var_2_3, var_2_1 - var_7.GetGameRoundCnt(var_2_6))
	end

	local var_2_7 = arg_2_0.valueText

	var_2_7.text = var_2_1
	string = var_2_7

	local var_2_8 = var_2_7.split(arg_2_1.name, "|")

	arg_2_0.callNameText.text = var_2_8[2]

	local var_2_9 = arg_2_0.playerNameText

	var_2_9.text = var_2_8[1]
	setActive = var_2_9

	var_2_9(arg_2_0.bg1TF, var_2_0 == 1)

	setActive = var_2_9

	var_2_9(arg_2_0.bg2TF, var_2_0 == 2)

	setActive = var_2_9

	var_2_9(arg_2_0.bg3TF, var_2_0 == 3)

	local var_2_10 = arg_2_0._type ~= var_0_0.TYPE_SELF or var_2_0 > 0

	setActive = var_7

	var_7(arg_2_0.rankText, var_2_10 and var_2_0 > 3)

	setActive = var_7

	var_7(arg_2_0.notOnTF, not var_2_10)

	local var_2_11 = "qicon/"

	pg = var_8

	local var_2_12 = var_2_11 .. var_8.ship_skin_template[arg_2_1.skinId].prefab

	GetImageSpriteFromAtlasAsync = var_8

	var_8(var_2_12, "", arg_2_0.iconTF)

	return
end

function var_0_0.Dispose(arg_3_0)
	return
end

return var_0_0
