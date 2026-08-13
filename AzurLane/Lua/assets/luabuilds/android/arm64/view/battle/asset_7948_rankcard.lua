class = var_0_10000

local var_0_0 = var_0_10000("RankCard")

var_0_0.TYPE_SELF = 1
var_0_0.TYPE_OTHER = 2
var_0_0.COLORS = {
	"#ffde5c",
	"#95b0f9",
	"#cfc1ba",
	"#797d81"
}

local var_0_1 = {
	{
		1,
		0.8705882352941177,
		0.3607843137254902
	},
	{
		0.5843137254901961,
		0.6901960784313725,
		0.9764705882352941
	},
	{
		0.8117647058823529,
		0.7568627450980392,
		0.7294117647058823
	},
	{
		0.4745098039215686,
		0.49019607843137253,
		0.5058823529411764
	}
}

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	go = var_1_10003
	arg_1_0._go = var_1_10003(arg_1_1)
	arg_1_0._tf = arg_1_1
	arg_1_0._type = arg_1_2
	findTF = var_3
	arg_1_0.frameTF = var_3(arg_1_0._tf, "frame")
	findTF = var_3

	local var_1_0 = var_3(arg_1_0._tf, "frame/bg")
	local var_1_1 = var_3.GetComponent

	typeof = var_6
	Image = var_1_10008
	arg_1_0.frameBgTF = var_1_1(var_1_0, var_6(var_1_10008))
	findTF = var_3
	arg_1_0.NumImgTF = var_3(arg_1_0._tf, "frame/number_img")
	findTF = var_3

	local var_1_2 = var_3(arg_1_0._tf, "frame/name")
	local var_1_3 = var_3.GetComponent

	typeof = var_6
	Text = var_1_10008
	arg_1_0.nameTF = var_1_3(var_1_2, var_6(var_1_10008))
	findTF = var_3

	local var_1_4 = var_3(arg_1_0._tf, "frame/number")
	local var_1_5 = var_3.GetComponent

	typeof = var_6
	Text = var_1_10008
	arg_1_0.numberTF = var_1_5(var_1_4, var_6(var_1_10008))
	findTF = var_3
	arg_1_0.notonlistTF = var_3(arg_1_0._tf, "frame/notonlist")
	findTF = var_3

	local var_1_6 = var_3(arg_1_0._tf, "frame/score")
	local var_1_7 = var_3.GetComponent

	typeof = var_6
	Text = var_1_10008
	arg_1_0.scoreTF = var_1_7(var_1_6, var_6(var_1_10008))
	findTF = var_3
	arg_1_0.emblemTF = var_3(arg_1_0._tf, "frame/emblem")
	findTF = var_3

	local var_1_8 = var_3(arg_1_0._tf, "frame/score_icon")
	local var_1_9 = var_3.GetComponent

	typeof = var_6
	Image = var_1_10008
	arg_1_0.scoreIconTF = var_1_9(var_1_8, var_6(var_1_10008))
	findTF = var_3
	arg_1_0.iconTF = var_3(arg_1_0._tf, "icon")
	findTF = var_3

	local var_1_10 = var_3(arg_1_0.iconTF, "level_bg/Text")
	local var_1_11 = var_3.GetComponent

	typeof = var_6
	Text = var_1_10008
	arg_1_0.levelTxt = var_1_11(var_1_10, var_6(var_1_10008))
	ClearTweenItemAlphaAndWhite = var_3

	var_3(arg_1_0._go)

	return
end

function var_0_0.update(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.rankVO = arg_2_1
	arg_2_0.nameTF.text = arg_2_1.name

	local var_2_0 = arg_2_1.rank
	local var_2_1 = arg_2_0.numberTF

	var_2_1.text = var_2_0
	math = var_2_1

	local var_2_2 = var_2_1.min(var_2_0 > 0 and var_2_0 or 4, 4)
	local var_2_3 = arg_2_0.levelTxt

	var_2_3.text = "Lv." .. arg_2_1.lv
	setActive = var_2_3

	var_2_3(arg_2_0.NumImgTF, var_2_2 < 4)

	if var_2_2 < 4 then
		setImageSprite = var_5

		local var_2_4 = arg_2_0.NumImgTF

		GetSpriteFromAtlas = var_8

		var_5(var_2_4, var_8("billboardframe", "bgn" .. var_2_2), true)
	end

	setImageSprite = var_5

	local var_2_5 = arg_2_0.frameTF

	GetSpriteFromAtlas = var_8

	var_5(var_2_5, var_8("billboardframe", "bg" .. var_2_2))

	local var_2_6 = var_0_1[var_2_2]
	local var_2_7 = arg_2_0.frameBgTF

	Color = var_2_5
	var_2_7.color = var_2_5.New(var_2_6[1], var_2_6[2], var_2_6[3])

	local var_2_8, var_2_9

	if arg_2_0._type == var_0_0.TYPE_OTHER then
		setActive = var_2_8

		var_2_8(arg_2_0.numberTF, var_2_2 >= 4)

		var_2_8 = arg_2_0.scoreTF
		setColorStr = var_2_12
		var_2_9 = arg_2_1
		var_2_8.text = var_2_12(arg_2_1.getPowerTxt(var_2_9), var_0_0.COLORS[var_2_2])
	elseif arg_2_0._type == var_0_0.TYPE_SELF then
		setActive = var_2_8

		var_2_8(arg_2_0.numberTF, var_2_0 ~= 0 and var_2_2 >= 4)

		setActive = var_2_8

		var_2_8(arg_2_0.notonlistTF, var_2_0 == 0)

		var_2_8 = arg_2_0.scoreTF
		var_2_8.text = arg_2_1:getPowerTxt()
	end

	PowerRank = var_2_8

	local var_2_10 = var_2_8
	local var_2_11 = var_2_8.getScoreIcon(var_2_10, arg_2_1.type)

	setActive = var_2_12

	var_2_12(arg_2_0.scoreIconTF, var_2_11)

	local var_2_12

	if var_2_11 then
		var_2_12 = arg_2_1.type
		PowerRank = var_2_10

		local var_2_14

		if var_2_12 == var_2_10.TYPE_PT then
			if arg_2_2 then
				getProxy = var_2_12
				ActivityProxy = var_9

				local var_2_13 = var_2_12(var_9)

				var_2_14 = var_2_12.getActivityById(var_2_13, arg_2_2)

				local var_2_15 = var_2_12.getConfig(var_2_14, "config_id")

				Drop = var_2_13

				local var_2_16 = var_2_13.New

				var_2_9 = {}
				DROP_TYPE_RESOURCE = var_12
				var_2_9.type = var_12
				var_2_9.id = var_2_15
				var_2_9 = var_2_16(var_2_9)

				local var_2_17 = var_9.getIcon(var_2_9)

				setImageSprite = var_2_14

				local var_2_18 = arg_2_0.scoreIconTF

				LoadSprite = var_1_10013

				var_2_14(var_2_18, var_1_10013(var_2_17))
			end
		else
			setImageSprite = var_2_12

			local var_2_19 = arg_2_0.scoreIconTF

			GetSpriteFromAtlas = var_2_14

			var_2_12(var_2_19, var_2_14(var_2_11[1], var_2_11[2]), true)
		end
	end

	LoadImageSpriteAsync = var_2_12

	var_2_12("emblem/" .. arg_2_1.arenaRank, arg_2_0.emblemTF)

	go = var_2_12

	if not var_2_12(arg_2_0.emblemTF).activeSelf then
		setActive = var_7

		var_7(arg_2_0.emblemTF, true)
	end

	updateDrop = var_7

	local var_2_20 = arg_2_0.iconTF
	local var_2_21 = {}

	DROP_TYPE_SHIP = var_2_9
	var_2_21.type = var_2_9
	var_2_21.id = arg_2_1.icon
	var_2_21.skinId = arg_2_1.skinId
	var_2_21.remoulded = arg_2_1.remoulded
	var_2_21.propose = arg_2_1.proposeTime

	var_7(var_2_20, var_2_21)

	go = var_7

	if not var_7(arg_2_0.iconTF).activeSelf then
		setActive = var_7

		var_7(arg_2_0.iconTF, true)
	end

	go = var_7

	if not var_7(arg_2_0._tf).activeSelf then
		setActive = var_7

		var_7(arg_2_0._tf, true)
	end

	TweenItemAlphaAndWhite = var_7

	var_7(arg_2_0._go)

	return
end

function var_0_0.clear(arg_3_0)
	ClearTweenItemAlphaAndWhite = var_1_10001

	var_1_10001(arg_3_0._go)

	IsNil = var_1_10001

	if not var_1_10001(arg_3_0.notonlistTF) then
		setActive = var_1

		var_1(arg_3_0.notonlistTF, false)
	end

	arg_3_0.scoreTF.text = 0
	arg_3_0.numberTF.text = 0

	return
end

function var_0_0.dispose(arg_4_0, ...)
	return
end

return var_0_0
