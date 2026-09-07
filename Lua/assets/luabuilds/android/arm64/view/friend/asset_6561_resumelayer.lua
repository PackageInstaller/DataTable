local resumeLayer = class("resumeLayer", import("..base.BaseUI"))

function resumeLayer:getUIName()
	return "resumeUI"
end

function resumeLayer:setPlayerVO(arg_2_1)
	self.player = arg_2_1

	return
end

function resumeLayer:init()
	self.frame = self._tf:Find("frame")
	self.resumeIcon = self._tf:Find("frame/window/info/circle/head")
	self.resumeStars = self._tf:Find("frame/window/info/circle/head/stars")
	self.resumeStarTpl = self._tf:Find("frame/window/info/circle/head/star")
	self.resumeLv = self._tf:Find("frame/window/info/player_info/level_bg/level"):GetComponent(typeof(Text))
	self.resumeName = self._tf:Find("frame/window/info/player_info/name_bg/name"):GetComponent(typeof(Text))
	self.resumeInfo = self._tf:Find("frame/window/summary/content")
	self.resumeEmblem = self._tf:Find("frame/window/info/rank_bg/rank/Image")
	self.resumeEmblemLabel = self._tf:Find("frame/window/info/rank_bg/rank/label")
	self.resumeMedalList = self._tf:Find("frame/window/medalList/container")
	self.resumeMedalTpl = self._tf:Find("frame/window/medal_tpl")
	self.closeBtn = self._tf:Find("frame/window/title_bg/close_btn")
	self.circle = self._tf:Find("frame/window/info/circle/head/frame")
	self.titleText = self._tf:Find("frame/title/label_cn/text")

	local var_3_0 = i18n("friend_resume_title_detail")

	if var_3_0 then
		setText(self.titleText, var_3_0)
	end

	return
end

function resumeLayer:didEnter()
	self:display(self.player)
	onButton(self, self._tf, function()
		self:emit(resumeLayer.ON_CLOSE)

		return
	end, SOUND_BACK)

	return
end

local var_0_1 = {
	{
		value = "shipCount",
		type = 1,
		tag = i18n("friend_resume_ship_count")
	},
	{
		type = 3,
		tag = i18n("friend_resume_collection_rate"),
		value = {
			"collectionCount"
		}
	},
	{
		value = "attackCount",
		type = 1,
		tag = i18n("friend_resume_attack_count")
	},
	{
		type = 2,
		tag = i18n("friend_resume_attack_win_rate"),
		value = {
			"attackCount",
			"winCount"
		}
	},
	{
		value = "pvp_attack_count",
		type = 1,
		tag = i18n("friend_resume_manoeuvre_count")
	},
	{
		type = 2,
		tag = i18n("friend_resume_manoeuvre_win_rate"),
		value = {
			"pvp_attack_count",
			"pvp_win_count"
		}
	},
	{
		value = "collect_attack_count",
		type = 1,
		tag = i18n("friend_event_count")
	}
}

function resumeLayer:display(arg_6_1)
	if self.contextData.parent then
		setParent(self._tf, self.contextData.parent)
	else
		pg.UIMgr.GetInstance():BlurPanel(self._tf)
	end

	local var_6_0 = SeasonInfo.getMilitaryRank(arg_6_1.score, arg_6_1.rank)
	local var_6_1 = SeasonInfo.getEmblem(arg_6_1.score, arg_6_1.rank)

	LoadImageSpriteAsync("emblem/" .. var_6_1, self.resumeEmblem)
	LoadImageSpriteAsync("emblem/n_" .. var_6_1, self.resumeEmblemLabel)

	self.resumeName.text = arg_6_1.name
	self.resumeLv.text = "Lv." .. arg_6_1.level

	LoadSpriteAsync("qicon/" .. arg_6_1:getPainting(), function(arg_7_0)
		if not IsNil(self.resumeIcon) then
			local var_7_0 = self.resumeIcon:GetComponent(typeof(Image))

			var_7_0.color = Color.white
			var_7_0.sprite = arg_7_0 or LoadSprite("heroicon/unknown")
		end

		return
	end)

	local var_6_2 = AttireFrame.attireFrameRes(arg_6_1, arg_6_1.id == getProxy(PlayerProxy):getRawData().id, AttireConst.TYPE_ICON_FRAME, arg_6_1.propose)

	PoolMgr.GetInstance():GetPrefab("IconFrame/" .. var_6_2, var_6_2, true, function(arg_8_0)
		if IsNil(self._tf) then
			return
		end

		if self.circle then
			arg_8_0.name = var_6_2
			findTF(arg_8_0.transform, "icon"):GetComponent(typeof(Image)).raycastTarget = false

			setParent(arg_8_0, self.circle, false)
		else
			PoolMgr.GetInstance():ReturnPrefab("IconFrame/" .. var_6_2, var_6_2, arg_8_0)
		end

		return
	end)

	local var_6_3 = pg.ship_data_statistics[arg_6_1.icon]

	for iter_6_0 = self.resumeStars.childCount, Ship.New({
		configId = pg.ship_data_statistics[arg_6_1.icon].id
	}):getStar() - 1 do
		cloneTplTo(self.resumeStarTpl, self.resumeStars)
	end

	for iter_6_1 = 0, self.resumeStars.childCount - 1 do
		self.resumeStars:GetChild(iter_6_1).gameObject:SetActive(iter_6_1 < var_6_3.star)
	end

	removeAllChildren(self.resumeMedalList)

	for iter_6_2 = 1, 5 do
		local var_6_4 = cloneTplTo(self.resumeMedalTpl, self.resumeMedalList)

		setActive(var_6_4:Find("empty"), iter_6_2 > #arg_6_1.displayTrophyList)

		if iter_6_2 <= #arg_6_1.displayTrophyList then
			setActive(var_6_4:Find("icon"), true)

			if Trophy.IsLoveLetterID(arg_6_1.displayTrophyList[iter_6_2]) then
				setLoveLetterMedal(var_6_4, LoveLetterTrophy.New({
					id = arg_6_1.displayTrophyList[iter_6_2]
				}), {
					hideMark = true
				})
			else
				LoadImageSpriteAsync("medal/" .. pg.medal_template[arg_6_1.displayTrophyList[iter_6_2]].icon, var_6_4:Find("icon"), true)
			end
		end
	end

	for iter_6_3, iter_6_4 in ipairs(var_0_1) do
		local var_6_5 = self.resumeInfo:GetChild(iter_6_3 - 1)

		setText(var_6_5:Find("tag"), iter_6_4.tag)

		local var_6_6 = var_6_5:Find("value")

		if iter_6_4.type == 1 then
			setText(var_6_6, self.player[iter_6_4.value])
		elseif iter_6_4.type == 2 then
			setText(var_6_6, string.format("%0.2f", math.max(self.player[iter_6_4.value[2]], 0) / math.max(self.player[iter_6_4.value[1]], 1) * 100) .. "%")
		elseif iter_6_4.type == 3 then
			local var_6_7 = self.player[iter_6_4.value[1]]
			local var_6_8

			if not self.player[iter_6_4.value[1]] then
				var_6_7 = 1
				var_6_8 = getProxy(CollectionProxy)
			end

			setText(var_6_6, string.format("%0.2f", var_6_7 / var_6_8:getCollectionTotal() * 100) .. "%")
		end
	end

	return
end

function resumeLayer:willExit()
	if self.contextData.parent then
		-- block empty
	else
		pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)
	end

	if self.circle.childCount > 0 then
		local var_9_0 = self.circle:GetChild(0).gameObject

		PoolMgr.GetInstance():ReturnPrefab("IconFrame/" .. var_9_0.name, var_9_0.name, var_9_0)
	end

	return
end

return resumeLayer
