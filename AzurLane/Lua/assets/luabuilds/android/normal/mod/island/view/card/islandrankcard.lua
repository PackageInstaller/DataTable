class = var_0_10000

local var_0_0 = var_0_10000("IslandRankCard")

var_0_0.TYPE_SELF = 1
var_0_0.TYPE_OTHER = 2

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	arg_1_0._type = arg_1_2
	arg_1_0.parent = arg_1_3

	local var_1_0 = arg_1_0._tf

	arg_1_0.bgTF = var_4.Find(var_1_0, "bg")

	local var_1_1 = arg_1_0._tf
	local var_1_2 = var_4.Find(var_1_1, "rank")
	local var_1_3 = var_4.GetComponent

	typeof = var_6
	Text = var_1_10007
	arg_1_0.rankText = var_1_3(var_1_2, var_6(var_1_10007))

	local var_1_4 = arg_1_0._tf

	arg_1_0.notOnTF = var_4.Find(var_1_4, "not_on")

	local var_1_5 = arg_1_0._tf

	arg_1_0.iconTF = var_4.Find(var_1_5, "icon_bg/icon")

	local var_1_6 = arg_1_0._tf
	local var_1_7 = var_4.Find(var_1_6, "name")
	local var_1_8 = var_4.GetComponent

	typeof = var_6
	Text = var_1_10007
	arg_1_0.nameText = var_1_8(var_1_7, var_6(var_1_10007))

	local var_1_9 = arg_1_0._tf
	local var_1_10 = var_4.Find(var_1_9, "level")
	local var_1_11 = var_4.GetComponent

	typeof = var_6
	Text = var_1_10007
	arg_1_0.levelText = var_1_11(var_1_10, var_6(var_1_10007))

	local var_1_12 = arg_1_0._tf
	local var_1_13 = var_4.Find(var_1_12, "pt")
	local var_1_14 = var_4.GetComponent

	typeof = var_6
	Text = var_1_10007
	arg_1_0.ptText = var_1_14(var_1_13, var_6(var_1_10007))
	setText = var_4

	local var_1_15 = arg_1_0._tf
	local var_1_16 = var_5.Find(var_1_15, "island")

	i18n = var_1_15

	var_4(var_1_16, var_1_15("island_season_charts_level"))

	setText = var_4

	local var_1_17 = arg_1_0.notOnTF

	i18n = var_6

	var_4(var_1_17, var_6("island_season_charts_out"))

	local var_1_18 = arg_1_0._tf

	arg_1_0.awardsTF = var_4.Find(var_1_18, "awards")

	return
end

function var_0_0.Update(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.rankVO = arg_2_1

	local var_2_0 = arg_2_0.rankText
	local var_2_1

	if not (arg_2_1.rank > 9) or not arg_2_1.rank then
		var_2_1 = "0" .. arg_2_1.rank
	end

	var_2_0.text = var_2_1
	arg_2_0.nameText.text = arg_2_1.name
	arg_2_0.levelText.text = "Lv." .. arg_2_1.arenaRank
	arg_2_0.ptText.text = arg_2_1.power

	local var_2_2

	if not (arg_2_1.rank < 4) or not arg_2_1.rank then
		var_2_2 = 0
	end

	GetImageSpriteFromAtlasAsync = var_4

	var_4("ui/islandseasonrankui_atlas", "bg" .. var_2_2, arg_2_0.bgTF)

	local var_2_4

	if arg_2_0._type == var_0_0.TYPE_SELF then
		local var_2_3 = arg_2_1.rank

		if not (0 < var_2_3) then
			var_2_4 = false

			goto label_2_0
		end
	end

	var_2_4 = true

	::label_2_0::

	setActive = var_5

	var_5(arg_2_0.rankText, var_2_4 and arg_2_1.rank > 3)

	setActive = var_5

	var_5(arg_2_0.notOnTF, not var_2_4)

	local var_2_5 = "qicon/"

	pg = var_6

	local var_2_6 = var_2_5 .. var_6.ship_skin_template[arg_2_1.skinId].prefab

	GetImageSpriteFromAtlasAsync = var_6

	var_6(var_2_6, "", arg_2_0.iconTF)

	IslandSeason = var_6

	local var_2_7 = var_6.GetAwardsByRank(arg_2_2, arg_2_1.rank)

	UIItemList = var_7

	local var_2_8 = var_7.StaticAlign
	local var_2_9 = arg_2_0.awardsTF
	local var_2_10 = arg_2_0.awardsTF

	var_2_8(var_2_9, var_9.Find(var_2_10, "tpl"), #var_2_7, function(arg_3_0, arg_3_1, arg_3_2)
		UIItemList = var_2_10003

		if arg_3_0 == var_2_10003.EventUpdate then
			updateCustomDrop = var_3

			var_3(arg_3_2, var_2_7[arg_3_1 + 1])

			onButton = var_3

			var_3(arg_2_0.parent, arg_3_2, function()
				local var_4_0 = arg_2_0.parent.contextData
				local var_4_1 = var_0.ShowMsgBox
				local var_4_2 = {}

				i18n = var_3_10003
				var_4_2.title = var_3_10003("island_word_desc")
				IslandMsgBox = var_3
				var_4_2.type = var_3.TYPE_COMMON_DROP_DESCRIBE
				var_4_2.dropData = var_2_7[arg_3_1 + 1]

				var_4_1(var_4_0, var_4_2)

				return
			end)
		end

		return
	end)

	return
end

function var_0_0.Dispose(arg_5_0)
	return
end

return var_0_0
