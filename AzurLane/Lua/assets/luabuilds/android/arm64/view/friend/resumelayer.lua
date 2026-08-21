local var_0_0 = class("resumeLayer", import("..base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "resumeUI"
end

function var_0_0.setPlayerVO(arg_2_0, arg_2_1)
	arg_2_0.player = arg_2_1

	return
end

function var_0_0.init(arg_3_0)
	arg_3_0.frame = arg_3_0._tf:Find("frame")
	arg_3_0.resumeIcon = arg_3_0._tf:Find("frame/window/info/circle/head")
	arg_3_0.resumeStars = arg_3_0._tf:Find("frame/window/info/circle/head/stars")
	arg_3_0.resumeStarTpl = arg_3_0._tf:Find("frame/window/info/circle/head/star")
	arg_3_0.resumeLv = arg_3_0._tf:Find("frame/window/info/player_info/level_bg/level"):GetComponent(typeof(Text))
	arg_3_0.resumeName = arg_3_0._tf:Find("frame/window/info/player_info/name_bg/name"):GetComponent(typeof(Text))
	arg_3_0.resumeInfo = arg_3_0._tf:Find("frame/window/summary/content")
	arg_3_0.resumeEmblem = arg_3_0._tf:Find("frame/window/info/rank_bg/rank/Image")
	arg_3_0.resumeEmblemLabel = arg_3_0._tf:Find("frame/window/info/rank_bg/rank/label")
	arg_3_0.resumeMedalList = arg_3_0._tf:Find("frame/window/medalList/container")
	arg_3_0.resumeMedalTpl = arg_3_0._tf:Find("frame/window/medal_tpl")
	arg_3_0.closeBtn = arg_3_0._tf:Find("frame/window/title_bg/close_btn")
	arg_3_0.circle = arg_3_0._tf:Find("frame/window/info/circle/head/frame")
	arg_3_0.titleText = arg_3_0._tf:Find("frame/title/label_cn/text")

	local var_3_0 = i18n("friend_resume_title_detail")

	if var_3_0 then
		setText(arg_3_0.titleText, var_3_0)
	end

	return
end

function var_0_0.didEnter(arg_4_0)
	arg_4_0:display(arg_4_0.player)
	onButton(arg_4_0, arg_4_0._tf, function()
		arg_4_0:emit(var_0_0.ON_CLOSE)

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

function var_0_0.display(arg_6_0, arg_6_1)
	if arg_6_0.contextData.parent then
		setParent(arg_6_0._tf, arg_6_0.contextData.parent)
	else
		pg.UIMgr.GetInstance():BlurPanel(arg_6_0._tf)
	end

	local var_6_0 = SeasonInfo.getMilitaryRank(arg_6_1.score, arg_6_1.rank)
	local var_6_1 = SeasonInfo.getEmblem(arg_6_1.score, arg_6_1.rank)

	LoadImageSpriteAsync("emblem/" .. var_6_1, arg_6_0.resumeEmblem)
	LoadImageSpriteAsync("emblem/n_" .. var_6_1, arg_6_0.resumeEmblemLabel)

	arg_6_0.resumeName.text = arg_6_1.name
	arg_6_0.resumeLv.text = "Lv." .. arg_6_1.level

	LoadSpriteAsync("qicon/" .. arg_6_1:getPainting(), function(arg_7_0)
		if not IsNil(arg_6_0.resumeIcon) then
			local var_7_0 = arg_6_0.resumeIcon:GetComponent(typeof(Image))

			var_7_0.color = Color.white
			var_7_0.sprite = arg_7_0 or LoadSprite("heroicon/unknown")
		end

		return
	end)

	local var_6_2 = arg_6_1.id == getProxy(PlayerProxy):getRawData().id
	local var_6_3 = AttireFrame.attireFrameRes(arg_6_1, var_6_2, AttireConst.TYPE_ICON_FRAME, arg_6_1.propose)

	PoolMgr.GetInstance():GetPrefab("IconFrame/" .. var_6_3, var_6_3, true, function(arg_8_0)
		if IsNil(arg_6_0._tf) then
			return
		end

		if arg_6_0.circle then
			arg_8_0.name = var_6_3
			findTF(arg_8_0.transform, "icon"):GetComponent(typeof(Image)).raycastTarget = false

			setParent(arg_8_0, arg_6_0.circle, false)
		else
			PoolMgr.GetInstance():ReturnPrefab("IconFrame/" .. var_6_3, var_6_3, arg_8_0)
		end

		return
	end)

	local var_6_4 = pg.ship_data_statistics[arg_6_1.icon]

	for iter_6_0 = arg_6_0.resumeStars.childCount, Ship.New({
		configId = pg.ship_data_statistics[arg_6_1.icon].id
	}):getStar() - 1 do
		cloneTplTo(arg_6_0.resumeStarTpl, arg_6_0.resumeStars)
	end

	for iter_6_1 = 0, arg_6_0.resumeStars.childCount - 1 do
		arg_6_0.resumeStars:GetChild(iter_6_1).gameObject:SetActive(iter_6_1 < var_6_4.star)
	end

	removeAllChildren(arg_6_0.resumeMedalList)

	for iter_6_2 = 1, 5 do
		local var_6_5 = cloneTplTo(arg_6_0.resumeMedalTpl, arg_6_0.resumeMedalList)

		setActive(var_6_5:Find("empty"), iter_6_2 > #arg_6_1.displayTrophyList)

		if iter_6_2 <= #arg_6_1.displayTrophyList then
			setActive(var_6_5:Find("icon"), true)

			if Trophy.IsLoveLetterID(arg_6_1.displayTrophyList[iter_6_2]) then
				setLoveLetterMedal(var_6_5, LoveLetterTrophy.New({
					id = arg_6_1.displayTrophyList[iter_6_2]
				}), {
					hideMark = true
				})
			else
				LoadImageSpriteAsync("medal/" .. pg.medal_template[arg_6_1.displayTrophyList[iter_6_2]].icon, var_6_5:Find("icon"), true)
			end
		end
	end

	for iter_6_3, iter_6_4 in ipairs(var_0_1) do
		local var_6_6 = arg_6_0.resumeInfo:GetChild(iter_6_3 - 1)

		setText(var_6_6:Find("tag"), iter_6_4.tag)

		local var_6_7 = var_6_6:Find("value")

		if iter_6_4.type == 1 then
			setText(var_6_7, arg_6_0.player[iter_6_4.value])
		elseif iter_6_4.type == 2 then
			setText(var_6_7, string.format("%0.2f", math.max(arg_6_0.player[iter_6_4.value[2]], 0) / math.max(arg_6_0.player[iter_6_4.value[1]], 1) * 100) .. "%")
		elseif iter_6_4.type == 3 then
			local var_6_8 = arg_6_0.player[iter_6_4.value[1]]
			local var_6_9

			if not arg_6_0.player[iter_6_4.value[1]] then
				var_6_8 = 1
				var_6_9 = getProxy(CollectionProxy)
			end

			setText(var_6_7, string.format("%0.2f", var_6_8 / var_6_9:getCollectionTotal() * 100) .. "%")
		end
	end

	return
end

function var_0_0.willExit(arg_9_0)
	if arg_9_0.contextData.parent then
		-- block empty
	else
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_9_0._tf)
	end

	if arg_9_0.circle.childCount > 0 then
		local var_9_0 = arg_9_0.circle:GetChild(0).gameObject

		PoolMgr.GetInstance():ReturnPrefab("IconFrame/" .. var_9_0.name, var_9_0.name, var_9_0)
	end

	return
end

return var_0_0
