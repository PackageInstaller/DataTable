local RankCard = class("RankCard")

RankCard.TYPE_SELF = 1
RankCard.TYPE_OTHER = 2
RankCard.COLORS = {
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

function RankCard:Ctor(arg_1_1, arg_1_2)
	self._go = go(arg_1_1)
	self._tf = arg_1_1
	self._type = arg_1_2
	self.frameTF = findTF(self._tf, "frame")
	self.frameBgTF = findTF(self._tf, "frame/bg"):GetComponent(typeof(Image))
	self.NumImgTF = findTF(self._tf, "frame/number_img")
	self.nameTF = findTF(self._tf, "frame/name"):GetComponent(typeof(Text))
	self.numberTF = findTF(self._tf, "frame/number"):GetComponent(typeof(Text))
	self.notonlistTF = findTF(self._tf, "frame/notonlist")
	self.scoreTF = findTF(self._tf, "frame/score"):GetComponent(typeof(Text))
	self.emblemTF = findTF(self._tf, "frame/emblem")
	self.scoreIconTF = findTF(self._tf, "frame/score_icon"):GetComponent(typeof(Image))
	self.iconTF = findTF(self._tf, "icon")
	self.levelTxt = findTF(self.iconTF, "level_bg/Text"):GetComponent(typeof(Text))

	ClearTweenItemAlphaAndWhite(self._go)

	return
end

function RankCard:update(arg_2_1, arg_2_2)
	self.rankVO = arg_2_1
	self.nameTF.text = arg_2_1.name

	local var_2_0 = arg_2_1.rank

	self.numberTF.text = arg_2_1.rank

	local var_2_1 = math.min(var_2_0 > 0 and var_2_0 or 4, 4)

	self.levelTxt.text = "Lv." .. arg_2_1.lv

	setActive(self.NumImgTF, var_2_1 < 4)

	if var_2_1 < 4 then
		setImageSprite(self.NumImgTF, GetSpriteFromAtlas("billboardframe", "bgn" .. var_2_1), true)
	end

	setImageSprite(self.frameTF, GetSpriteFromAtlas("billboardframe", "bg" .. var_2_1))

	self.frameBgTF.color = Color.New(var_0_1[var_2_1][1], var_0_1[var_2_1][2], var_0_1[var_2_1][3])

	if self._type == RankCard.TYPE_OTHER then
		setActive(self.numberTF, var_2_1 >= 4)

		self.scoreTF.text = setColorStr(arg_2_1:getPowerTxt(), RankCard.COLORS[var_2_1])
	elseif self._type == RankCard.TYPE_SELF then
		setActive(self.numberTF, var_2_0 ~= 0 and var_2_1 >= 4)
		setActive(self.notonlistTF, var_2_0 == 0)

		self.scoreTF.text = arg_2_1:getPowerTxt()
	end

	local var_2_2 = PowerRank:getScoreIcon(arg_2_1.type)

	setActive(self.scoreIconTF, var_2_2)

	if var_2_2 then
		if arg_2_1.type == PowerRank.TYPE_PT then
			if arg_2_2 then
				local var_2_3 = getProxy(ActivityProxy)

				setImageSprite(self.scoreIconTF, LoadSprite((Drop.New({
					type = DROP_TYPE_RESOURCE,
					id = var_2_3:getActivityById(arg_2_2):getConfig("config_id")
				}).getIcon(var_2_3))))
			end
		else
			setImageSprite(self.scoreIconTF, GetSpriteFromAtlas(var_2_2[1], var_2_2[2]), true)
		end
	end

	LoadImageSpriteAsync("emblem/" .. arg_2_1.arenaRank, self.emblemTF)

	if not go(self.emblemTF).activeSelf then
		setActive(self.emblemTF, true)
	end

	updateDrop(self.iconTF, {
		type = DROP_TYPE_SHIP,
		id = arg_2_1.icon,
		skinId = arg_2_1.skinId,
		remoulded = arg_2_1.remoulded,
		propose = arg_2_1.proposeTime
	})

	if not go(self.iconTF).activeSelf then
		setActive(self.iconTF, true)
	end

	if not go(self._tf).activeSelf then
		setActive(self._tf, true)
	end

	TweenItemAlphaAndWhite(self._go)

	return
end

function RankCard:clear()
	ClearTweenItemAlphaAndWhite(self._go)

	if not IsNil(self.notonlistTF) then
		setActive(self.notonlistTF, false)
	end

	self.scoreTF.text = 0
	self.numberTF.text = 0

	return
end

function RankCard:dispose(...)
	return
end

return RankCard
