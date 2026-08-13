class = var_0_10000

local var_0_0 = "GuildMemberInfoPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".GuildMemberBasePage"))

function var_0_1.getUIName(arg_1_0)
	return "GuildMemberInfoPage"
end

local var_0_2 = {}
local var_0_3 = {
	value = "shipCount",
	type = 1
}

i18n = var_3
var_0_3.tag = var_3("friend_resume_ship_count")
var_0_2[1] = var_0_3

local var_0_4 = {
	type = 3
}

i18n = var_3
var_0_4.tag = var_3("friend_resume_collection_rate")
var_0_4.value = {
	"collectionCount"
}
var_0_2[2] = var_0_4

local var_0_5 = {
	value = "attackCount",
	type = 1
}

i18n = var_3
var_0_5.tag = var_3("friend_resume_attack_count")
var_0_2[3] = var_0_5

local var_0_6 = {
	type = 2
}

i18n = var_3
var_0_6.tag = var_3("friend_resume_attack_win_rate")
var_0_6.value = {
	"attackCount",
	"winCount"
}
var_0_2[4] = var_0_6

local var_0_7 = {
	value = "pvp_attack_count",
	type = 1
}

i18n = var_3
var_0_7.tag = var_3("friend_resume_manoeuvre_count")
var_0_2[5] = var_0_7

local var_0_8 = {
	type = 2
}

i18n = var_3
var_0_8.tag = var_3("friend_resume_manoeuvre_win_rate")
var_0_8.value = {
	"pvp_attack_count",
	"pvp_win_count"
}
var_0_2[6] = var_0_8

local var_0_9 = {
	value = "collect_attack_count",
	type = 1
}

i18n = var_3
var_0_9.tag = var_3("friend_event_count")
var_0_2[7] = var_0_9

function var_0_1.OnLoaded(arg_2_0)
	var_0_1.super.OnLoaded(arg_2_0)

	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "frame/info/name/Text")
	local var_2_2 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.infonameTF = var_2_2(var_2_1, var_3(var_1_10004))

	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_1.Find(var_2_3, "frame/info/shipicon/icon")
	local var_2_5 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004
	arg_2_0.infoiconTF = var_2_5(var_2_4, var_3(var_1_10004))

	local var_2_6 = arg_2_0._tf
	local var_2_7 = var_1.Find(var_2_6, "frame/duty")
	local var_2_8 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004
	arg_2_0.infoduty = var_2_8(var_2_7, var_3(var_1_10004))

	local var_2_9 = arg_2_0._tf

	arg_2_0.infostarsTF = var_1.Find(var_2_9, "frame/info/shipicon/stars")

	local var_2_10 = arg_2_0._tf

	arg_2_0.infostarTF = var_1.Find(var_2_10, "frame/info/shipicon/stars/star")

	local var_2_11 = arg_2_0._tf
	local var_2_12 = var_1.Find(var_2_11, "frame/info/level/Text")
	local var_2_13 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.infolevelTF = var_2_13(var_2_12, var_3(var_1_10004))

	local var_2_14 = arg_2_0._tf

	arg_2_0.circle = var_1.Find(var_2_14, "frame/info/shipicon/frame")

	local var_2_15 = arg_2_0._tf

	arg_2_0.resumeInfo = var_1.Find(var_2_15, "frame/content")

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_CONFIRM = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	return
end

function var_0_1.Show(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	arg_5_0.guildVO = arg_5_1
	arg_5_0.playerVO = arg_5_2
	arg_5_0.memberVO = arg_5_3

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.emit

	GuildMemberMediator = var_1_10007

	var_5_1(var_5_0, var_1_10007.OPEN_DESC_INFO, arg_5_3)

	if arg_5_4 then
		arg_5_4()
	end

	return
end

function var_0_1.Flush(arg_6_0, arg_6_1)
	pg = var_1_10002

	local var_6_0 = var_1_10002.UIMgr.GetInstance()

	var_2.BlurPanel(var_6_0, arg_6_0._tf)

	setActive = var_2

	var_2(arg_6_0._tf, true)

	local var_6_1 = arg_6_0._tf

	var_2.SetAsLastSibling(var_6_1)
	arg_6_0.onShowCallBack(arg_6_0.buttonPos)

	local var_6_2 = arg_6_0.guildVO
	local var_6_3 = arg_6_0.memberVO
	local var_6_4 = arg_6_0.infonameTF

	var_6_4.text = var_6_3.name
	AttireFrame = var_6_4

	local var_6_5 = var_6_4.attireFrameRes
	local var_6_6 = var_6_3
	local var_6_7 = var_6_3.id

	getProxy = var_1_10007
	PlayerProxy = var_1_10008

	local var_6_8 = var_1_10007(var_1_10008)
	local var_6_9 = var_6_7 == var_7.getRawData(var_6_8).id

	AttireConst = var_7

	local var_6_10 = var_6_5(var_6_6, var_6_9, var_7.TYPE_ICON_FRAME, var_6_3.propose)

	PoolMgr = var_6_6

	local var_6_11 = var_6_6.GetInstance()

	var_5.GetPrefab(var_6_11, "IconFrame/" .. var_6_10, var_6_10, true, function(arg_7_0)
		IsNil = var_2_10001

		if var_2_10001(arg_6_0._tf) then
			return
		end

		if arg_6_0.circle then
			arg_7_0.name = var_6_10
			findTF = var_1

			local var_7_0 = var_1(arg_7_0.transform, "icon")
			local var_7_1 = var_1.GetComponent

			typeof = var_2_10004
			Image = var_2_10005
			var_7_1(var_7_0, var_2_10004(var_2_10005)).raycastTarget = false
			setParent = var_3

			var_3(arg_7_0, arg_6_0.circle, false)
		else
			PoolMgr = var_1

			local var_7_2 = var_1.GetInstance()

			var_1.ReturnPrefab(var_7_2, "IconFrame/" .. var_6_10, var_6_10, arg_7_0)
		end

		return
	end)

	pg = var_5

	local var_6_12 = var_5.ship_data_statistics[var_6_3.icon]

	Ship = var_6

	local var_6_13 = var_6.New({
		configId = var_6_3.icon,
		skin_id = var_6_3.skinId
	})

	LoadSpriteAsync = var_7

	var_7("qicon/" .. var_6_13:getPainting(), function(arg_8_0)
		IsNil = var_2_10001

		if not var_2_10001(arg_6_0.infoiconTF) then
			arg_6_0.infoiconTF.sprite = arg_8_0
		end

		return
	end)

	GetSpriteFromAtlas = var_7

	local var_6_14 = var_7("dutyicon", "icon_" .. var_6_3.duty)

	arg_6_0.infoduty.sprite = var_6_14

	for iter_6_0 = arg_6_0.infostarsTF.childCount, var_6_12.star - 1 do
		cloneTplTo = var_1_10013

		var_1_10013(arg_6_0.infostarTF, arg_6_0.infostarsTF)
	end

	for iter_6_1 = 1, var_8 do
		local var_6_15 = arg_6_0.infostarsTF
		local var_6_16 = var_13.GetChild(var_6_15, iter_6_1 - 1)

		setActive = var_6_15

		var_6_15(var_6_16, iter_6_1 <= var_6_12.star)
	end

	local var_6_17 = arg_6_0.infolevelTF

	var_6_17.text = "Lv." .. var_6_3.level
	ipairs = var_6_17

	for iter_6_2, iter_6_3 in var_6_17(var_0_2) do
		local var_6_18 = arg_6_0.resumeInfo
		local var_6_19 = var_14.GetChild(var_6_18, iter_6_2 - 1)

		setText = var_6_18

		var_6_18(var_6_19:Find("tag"), iter_6_3.tag)

		local var_6_20 = var_6_19:Find("tag (1)")

		if iter_6_3.type == 1 then
			setText = var_16

			var_16(var_6_20, arg_6_1[iter_6_3.value])
		else
			local var_6_22

			if iter_6_3.type == 2 then
				math = var_16

				local var_6_21 = var_16.max(arg_6_1[iter_6_3.value[1]], 1)

				math = var_6_22
				var_6_22 = var_6_22.max(arg_6_1[iter_6_3.value[2]], 0)
				setText = var_18
				var_1_10019 = var_6_20
				string = var_1_10020

				var_18(var_1_10019, var_1_10020.format("%0.2f", var_6_22 / var_6_21 * 100) .. "%")
			elseif iter_6_3.type == 3 then
				local var_6_23

				if not arg_6_1[iter_6_3.value[1]] then
					var_6_23 = 1
				end

				setText = var_6_22

				local var_6_24 = var_6_20

				string = var_1_10019
				var_1_10019 = var_1_10019.format
				var_1_10020 = "%0.2f"
				getProxy = var_1_10021
				CollectionProxy = var_1_10022
				var_1_10022 = var_1_10021(var_1_10022)

				var_6_22(var_6_24, var_1_10019(var_1_10020, var_6_23 / var_1_10021.getCollectionTotal(var_1_10022) * 100) .. "%")
			end
		end
	end

	return
end

return var_0_1
