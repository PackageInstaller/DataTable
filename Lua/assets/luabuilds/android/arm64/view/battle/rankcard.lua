local var_0_0 = class("RankCard")

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
	arg_1_0._go = go(arg_1_1)
	arg_1_0._tf = arg_1_1
	arg_1_0._type = arg_1_2
	arg_1_0.frameTF = findTF(arg_1_0._tf, "frame")
	arg_1_0.frameBgTF = findTF(arg_1_0._tf, "frame/bg"):GetComponent(typeof(Image))
	arg_1_0.NumImgTF = findTF(arg_1_0._tf, "frame/number_img")
	arg_1_0.nameTF = findTF(arg_1_0._tf, "frame/name"):GetComponent(typeof(Text))
	arg_1_0.numberTF = findTF(arg_1_0._tf, "frame/number"):GetComponent(typeof(Text))
	arg_1_0.notonlistTF = findTF(arg_1_0._tf, "frame/notonlist")
	arg_1_0.scoreTF = findTF(arg_1_0._tf, "frame/score"):GetComponent(typeof(Text))
	arg_1_0.emblemTF = findTF(arg_1_0._tf, "frame/emblem")
	arg_1_0.scoreIconTF = findTF(arg_1_0._tf, "frame/score_icon"):GetComponent(typeof(Image))
	arg_1_0.iconTF = findTF(arg_1_0._tf, "icon")
	arg_1_0.levelTxt = findTF(arg_1_0.iconTF, "level_bg/Text"):GetComponent(typeof(Text))

	ClearTweenItemAlphaAndWhite(arg_1_0._go)

	return
end

function var_0_0.update(arg_2_0, arg_2_1, arg_2_2)
	local var_2_9000

	arg_2_0.rankVO = arg_2_1
	arg_2_0.nameTF.text = arg_2_1.name

	local var_2_0 = arg_2_1.rank

	arg_2_0.numberTF.text = arg_2_1.rank

	local var_2_1 = math.min(var_2_0 > 0 and var_2_0 or 4, 4)

	arg_2_0.levelTxt.text = "Lv." .. arg_2_1.lv

	setActive(arg_2_0.NumImgTF, var_2_1 < 4)

	if var_2_1 < 4 then
		setImageSprite(arg_2_0.NumImgTF, GetSpriteFromAtlas("billboardframe", "bgn" .. var_2_1), true)
	end

	setImageSprite(arg_2_0.frameTF, GetSpriteFromAtlas("billboardframe", "bg" .. var_2_1))

	arg_2_0.frameBgTF.color = Color.New(var_0_1[var_2_1][1], var_0_1[var_2_1][2], var_0_1[var_2_1][3])

	if arg_2_0._type == var_0_0.TYPE_OTHER then
		setActive(arg_2_0.numberTF, var_2_1 >= 4)

		arg_2_0.scoreTF.text = setColorStr(arg_2_1:getPowerTxt(), var_0_0.COLORS[var_2_1])
	elseif arg_2_0._type == var_0_0.TYPE_SELF then
		setActive(arg_2_0.numberTF, var_2_0 ~= 0 and var_2_1 >= 4)
		setActive(arg_2_0.notonlistTF, var_2_0 == 0)

		arg_2_0.scoreTF.text = arg_2_1:getPowerTxt()
	end

	local var_2_2 = PowerRank:getScoreIcon(arg_2_1.type)

	setActive(arg_2_0.scoreIconTF, var_2_2)

	if var_2_2 then
		if arg_2_1.type == PowerRank.TYPE_PT then
			if arg_2_2 then
				local var_2_3 = getProxy(ActivityProxy)

				setImageSprite(arg_2_0.scoreIconTF, LoadSprite((Drop.New({
					type = DROP_TYPE_RESOURCE,
					id = var_2_3.getActivityById(var_2_9000, arg_2_2):getConfig("config_id")
				}).getIcon(var_2_3))))
			end
		else
			setImageSprite(arg_2_0.scoreIconTF, GetSpriteFromAtlas(var_2_2[1], var_2_2[2]), true)
		end
	end

	LoadImageSpriteAsync("emblem/" .. arg_2_1.arenaRank, arg_2_0.emblemTF)

	if not go(arg_2_0.emblemTF).activeSelf then
		setActive(arg_2_0.emblemTF, true)
	end

	updateDrop(arg_2_0.iconTF, {
		type = DROP_TYPE_SHIP,
		id = arg_2_1.icon,
		skinId = arg_2_1.skinId,
		remoulded = arg_2_1.remoulded,
		propose = arg_2_1.proposeTime
	})

	if not go(arg_2_0.iconTF).activeSelf then
		setActive(arg_2_0.iconTF, true)
	end

	if not go(arg_2_0._tf).activeSelf then
		setActive(arg_2_0._tf, true)
	end

	TweenItemAlphaAndWhite(arg_2_0._go)

	return
end

function var_0_0.clear(arg_3_0)
	ClearTweenItemAlphaAndWhite(arg_3_0._go)

	if not IsNil(arg_3_0.notonlistTF) then
		setActive(arg_3_0.notonlistTF, false)
	end

	arg_3_0.scoreTF.text = 0
	arg_3_0.numberTF.text = 0

	return
end

function var_0_0.dispose(arg_4_0, ...)
	return
end

return var_0_0
