pg = pg or {}
pg.ToastMgr = singletonClass("ToastMgr")

local var_0_0 = pg.ToastMgr
local var_0_1 = require("Mgr/Pool/PoolPlural")

pg.ToastMgr.TYPE_ATTIRE = "Attire"
pg.ToastMgr.TYPE_TECPOINT = "Tecpoint"
pg.ToastMgr.TYPE_TROPHY = "Trophy"
pg.ToastMgr.TYPE_META = "Meta"
pg.ToastMgr.TYPE_CRUSING = "Crusing"
pg.ToastMgr.TYPE_VOTE = "Vote"
pg.ToastMgr.TYPE_EMOJI = "Emoji"
pg.ToastMgr.TYPE_COVER = "Cover"
pg.ToastMgr.TYPE_COMBAT_UI = "CombatUI"
pg.ToastMgr.ToastInfo = {
	[pg.ToastMgr.TYPE_ATTIRE] = {
		Attire = "attire_tpl"
	},
	[pg.ToastMgr.TYPE_TECPOINT] = {
		Buff = "buff_tpl",
		Point = "point_tpl"
	},
	[pg.ToastMgr.TYPE_TROPHY] = {
		Trophy = "trophy_tpl"
	},
	[pg.ToastMgr.TYPE_META] = {
		MetaLevel = "meta_level_tpl",
		MetaExp = "meta_exp_tpl"
	},
	[pg.ToastMgr.TYPE_CRUSING] = {
		Crusing = "crusing_pt_tpl"
	},
	[pg.ToastMgr.TYPE_VOTE] = {
		Vote = "vote_tpl"
	},
	[pg.ToastMgr.TYPE_EMOJI] = {
		Emoji = "emoji_tpl"
	},
	[pg.ToastMgr.TYPE_COVER] = {
		Cover = "cover_tpl"
	},
	[pg.ToastMgr.TYPE_COMBAT_UI] = {
		CombatUI = "combatui_tpl"
	}
}

function pg.ToastMgr.Init(arg_1_0, arg_1_1)
	LoadAndInstantiateAsync("ui", "ToastUI", function(arg_2_0)
		arg_1_0._go = arg_2_0

		arg_1_0._go:SetActive(false)

		arg_1_0._tf = arg_1_0._go.transform
		arg_1_0.container = arg_1_0._tf:Find("container")

		arg_1_0._go.transform:SetParent(pg.UIMgr.GetInstance().OverlayToast, false)

		arg_1_0.pools = {}

		for iter_2_0, iter_2_1 in pairs(var_0_0.ToastInfo) do
			for iter_2_2, iter_2_3 in pairs(iter_2_1) do
				({})[iter_2_2 .. "Tpl"] = iter_2_3
			end
		end

		for iter_2_4, iter_2_5 in pairs({}) do
			local var_2_0 = arg_1_0._tf:Find("resources/" .. iter_2_5)

			if iter_2_5 == "meta_exp_tpl" then
				setText(var_2_0:Find("ExpFull/Tip"), i18n("meta_toast_fullexp"))
				setText(var_2_0:Find("ExpAdd/Tip"), i18n("meta_toast_tactics"))
			end

			setActive(var_2_0, false)

			arg_1_0.pools[iter_2_4] = var_0_1.New(var_2_0.gameObject, 5)
		end

		arg_1_0:ResetUIDandHistory()

		if arg_1_1 then
			arg_1_1()
		end

		return
	end, true, true)

	return
end

function pg.ToastMgr.ResetUIDandHistory(arg_3_0)
	arg_3_0.completedJob = 0
	arg_3_0.actionJob = 0
	arg_3_0.buffer = {}

	return
end

function pg.ToastMgr.ShowToast(arg_4_0, arg_4_1, arg_4_2)
	table.insert(arg_4_0.buffer, {
		state = 0,
		type = arg_4_1,
		info = arg_4_2
	})
	setActive(arg_4_0._tf, true)

	if #arg_4_0.buffer == 1 or arg_4_0.buffer[#arg_4_0.buffer].state >= 2 then
		arg_4_0:Toast()
	end

	return
end

function pg.ToastMgr.Toast(arg_5_0)
	if arg_5_0.actionJob >= #arg_5_0.buffer then
		return
	end

	if arg_5_0.buffer[arg_5_0.actionJob] and arg_5_0.buffer[arg_5_0.actionJob].state < 2 then
		return
	elseif arg_5_0.buffer[arg_5_0.actionJob] and arg_5_0.buffer[arg_5_0.actionJob].type ~= arg_5_0.buffer[arg_5_0.actionJob + 1].type and arg_5_0.buffer[arg_5_0.actionJob].state < 3 then
		return
	end

	arg_5_0.actionJob = arg_5_0.actionJob + 1

	local var_5_0 = arg_5_0.buffer[arg_5_0.actionJob]
	local var_5_1 = arg_5_0.actionJob

	arg_5_0.buffer[arg_5_0.actionJob].state = 1

	arg_5_0["Update" .. arg_5_0.buffer[arg_5_0.actionJob].type](arg_5_0, arg_5_0.buffer[arg_5_0.actionJob], function()
		var_5_0.state = 2

		arg_5_0:Toast()

		return
	end, function()
		var_5_0.state = 3

		if arg_5_0.buffer[var_5_1 + 1] and arg_5_0.buffer[var_5_1 + 1].state < 1 then
			arg_5_0:Toast()
		end

		arg_5_0.completedJob = arg_5_0.completedJob + 1

		if arg_5_0.completedJob >= #arg_5_0.buffer then
			arg_5_0:ResetUIDandHistory()
			setActive(arg_5_0._tf, false)

			for iter_7_0, iter_7_1 in pairs(arg_5_0.pools) do
				iter_7_1:ClearItems(false)
			end
		end

		return
	end)

	return
end

function pg.ToastMgr.GetAndSet(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0.pools[arg_8_1 .. "Tpl"]:Dequeue()

	setActive(var_8_0, true)
	setParent(var_8_0, arg_8_2)
	var_8_0.transform:SetAsLastSibling()

	return var_8_0
end

function pg.ToastMgr.UpdateAttire(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = arg_9_0:GetAndSet(arg_9_1.type, arg_9_0.container)
	local var_9_1 = var_9_0:GetComponent(typeof(DftAniEvent))

	var_9_1:SetTriggerEvent(function(arg_10_0)
		if arg_9_2 then
			arg_9_2()
		end

		var_9_1:SetTriggerEvent(nil)

		return
	end)
	var_9_1:SetEndEvent(function(arg_11_0)
		setActive(var_9_0, false)
		arg_9_0.pools[arg_9_1.type .. "Tpl"]:Enqueue(var_9_0)
		var_9_1:SetEndEvent(nil)

		if arg_9_3 then
			arg_9_3()
		end

		return
	end)
	var_9_0:GetComponent(typeof(Animation)):Play("attire")
	assert(isa(arg_9_1.info, AttireFrame))

	local var_9_3 = var_9_2:getType()

	setActive(var_9_0.transform:Find("bg/icon_frame"), var_9_3 == AttireConst.TYPE_ICON_FRAME)
	setActive(var_9_0.transform:Find("bg/chat_frame"), var_9_3 == AttireConst.TYPE_CHAT_FRAME)
	setText(var_9_0.transform:Find("bg/Text"), HXSet.hxLan(var_9_2:getConfig("name")))

	return
end

function pg.ToastMgr.UpdateCombatUI(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = arg_12_0:GetAndSet(arg_12_1.type, arg_12_0.container)

	LoadImageSpriteAsync("Props/" .. pg.item_data_battleui[arg_12_1.info.id].display_icon, var_12_0.transform:Find("content/icon"), true)
	setText(var_12_0.transform:Find("content/name"), pg.item_data_battleui[arg_12_1.info.id].name)
	setText(var_12_0.transform:Find("content/label"), i18n("battle_ui_unlock"))

	local var_12_1 = var_12_0.transform:Find("content")

	var_12_1.anchoredPosition = Vector2(-550, 0)

	LeanTween.moveX(rtf(var_12_1), 0, 0.5)
	LeanTween.moveX(rtf(var_12_1), -550, 0.5):setDelay(5):setOnComplete(System.Action(function()
		setActive(var_12_0, false)
		arg_12_0.pools[arg_12_1.type .. "Tpl"]:Enqueue(var_12_0)

		if arg_12_3 then
			arg_12_3()
		end

		return
	end))

	if arg_12_2 then
		arg_12_2()
	end

	return
end

function pg.ToastMgr.UpdateEmoji(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = arg_14_0:GetAndSet(arg_14_1.type, arg_14_0.container)
	local var_14_1 = var_14_0:GetComponent(typeof(DftAniEvent))

	var_14_1:SetTriggerEvent(function(arg_15_0)
		if arg_14_2 then
			arg_14_2()
		end

		var_14_1:SetTriggerEvent(nil)

		return
	end)
	var_14_1:SetEndEvent(function(arg_16_0)
		setActive(var_14_0, false)
		arg_14_0.pools[arg_14_1.type .. "Tpl"]:Enqueue(var_14_0)
		var_14_1:SetEndEvent(nil)

		if arg_14_3 then
			arg_14_3()
		end

		return
	end)
	var_14_0:GetComponent(typeof(Animation)):Play("attire")
	setText(var_14_0.transform:Find("bg/label"), i18n("word_emoji_unlock"))
	setText(var_14_0.transform:Find("bg/Text"), i18n("word_get_emoji", arg_14_1.info.item_name))

	return
end

pg.ToastMgr.FADE_TIME = 0.4
pg.ToastMgr.FADE_OUT_TIME = 1
pg.ToastMgr.SHOW_TIME = 1.5
pg.ToastMgr.DELAY_TIME = 0.3

function pg.ToastMgr.UpdateTecpoint(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = arg_17_1.info.typeList
	local var_17_1 = arg_17_0:GetAndSet("Point", arg_17_0.container)

	GetComponent(var_17_1.transform, "CanvasGroup").alpha = 0

	setText(findTF(var_17_1, "PointText"), "+" .. arg_17_1.info.point)

	local var_17_2 = {}

	if arg_17_1.info.typeList then
		for iter_17_0 = 1, #arg_17_1.info.typeList do
			local var_17_3 = arg_17_0:GetAndSet("Buff", arg_17_0.container)

			GetComponent(var_17_3.transform, "CanvasGroup").alpha = 0

			local var_17_4 = var_17_3.transform:Find("AttrText")
			local var_17_5 = var_17_3.transform:Find("ValueText")

			setImageSprite(var_17_3.transform:Find("TypeImg").transform, (GetSpriteFromAtlas("ShipType", "buffitem_tec_" .. arg_17_1.info.typeList[iter_17_0])))
			setText(var_17_4.transform, AttributeType.Type2Name(pg.attribute_info_by_type[arg_17_1.info.attr].name))
			setText(var_17_5.transform, "+" .. arg_17_1.info.value)

			;({})[iter_17_0] = go(var_17_3)
		end
	end

	local function var_17_6()
		if arg_17_2 then
			arg_17_2()
		end

		if arg_17_3 then
			arg_17_3()
		end

		return
	end

	local var_17_7 = go(var_17_1)
	local var_17_8 = GetComponent(var_17_1, "CanvasGroup")

	local function var_17_9()
		LeanTween.moveX(rtf(var_17_7), 0, var_0_0.FADE_OUT_TIME)
		LeanTween.value(var_17_7, 1, 0, var_0_0.FADE_OUT_TIME):setOnUpdate(System.Action_float(var_0)):setOnComplete(System.Action(function()
			setActive(var_17_1, false)
			arg_17_0.pools.PointTpl:Enqueue(var_17_1)

			if not var_17_0 then
				var_17_6()
			end

			return
		end))

		return
	end

	LeanTween.value(var_17_7, 0, 1, var_0_0.FADE_TIME):setOnUpdate(System.Action_float(function(arg_19_0)
		var_17_8.alpha = arg_19_0

		return
	end)):setOnComplete(System.Action(function()
		LeanTween.delayedCall(var_17_7, var_0_0.SHOW_TIME, System.Action(var_17_9))

		return
	end))

	local function var_17_10(arg_23_0, arg_23_1, arg_23_2)
		local var_23_0 = GetComponent(arg_23_0.transform, "CanvasGroup")

		local function var_23_1()
			LeanTween.moveX(rtf(arg_23_0), 0, var_0_0.FADE_OUT_TIME)
			LeanTween.value(arg_23_0, 1, 0, var_0_0.FADE_OUT_TIME):setOnUpdate(System.Action_float(var_0)):setOnComplete(System.Action(function()
				setActive(arg_23_0, false)
				arg_17_0.pools.BuffTpl:Enqueue(arg_23_0)

				if arg_23_2 then
					var_17_6()
				end

				return
			end))

			return
		end

		LeanTween.value(arg_23_0, 0, 1, var_0_0.FADE_TIME):setOnUpdate(System.Action_float(function(arg_24_0)
			var_23_0.alpha = arg_24_0

			return
		end)):setOnComplete(System.Action(function()
			LeanTween.delayedCall(arg_23_0, var_0_0.SHOW_TIME + (var_0_0.FADE_OUT_TIME - var_0_0.DELAY_TIME) * arg_23_1, System.Action(var_23_1))

			return
		end))

		return
	end

	for iter_17_1, iter_17_2 in ipairs({}) do
		LeanTween.delayedCall(var_17_7, iter_17_1 * var_0_0.DELAY_TIME, System.Action(function()
			var_17_10(iter_17_2, iter_17_1, iter_17_1 == #var_17_2)

			return
		end))
	end

	return
end

function pg.ToastMgr.UpdateTrophy(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	local var_29_0 = arg_29_1.info.sound or SFX_UI_TIP

	pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_29_0)

	local var_29_1 = arg_29_0:GetAndSet(arg_29_1.type, arg_29_0.container)

	LoadImageSpriteAsync("medal/s_" .. pg.medal_template[arg_29_1.info.id].icon, var_29_1.transform:Find("content/icon"), true)
	setText(var_29_1.transform:Find("content/name"), pg.medal_template[arg_29_1.info.id].name)
	setText(var_29_1.transform:Find("content/label"), i18n("trophy_achieved"))

	local var_29_2 = var_29_1.transform:Find("content")

	var_29_2.anchoredPosition = Vector2(-550, 0)

	LeanTween.moveX(rtf(var_29_2), 0, 0.5)
	LeanTween.moveX(rtf(var_29_2), -550, 0.5):setDelay(5):setOnComplete(System.Action(function()
		setActive(var_29_1, false)
		arg_29_0.pools[arg_29_1.type .. "Tpl"]:Enqueue(var_29_1)

		if arg_29_3 then
			arg_29_3()
		end

		return
	end))

	if arg_29_2 then
		arg_29_2()
	end

	return
end

function pg.ToastMgr.UpdateMeta(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	local var_31_0 = arg_31_0:GetAndSet("MetaExp", arg_31_0.container)
	local var_31_1 = arg_31_0:GetAndSet("MetaLevel", arg_31_0.container)
	local var_31_2, var_31_3 = MetaCharacterConst.GetMetaCharacterToastPath((MetaCharacterConst.GetMetaShipGroupIDByConfigID(arg_31_1.info.metaShipVO.configId)))

	setImageSprite(var_31_0.transform:Find("ShipImg"), LoadSprite(var_31_2, var_31_3))

	local var_31_5 = pg.gameset.meta_skill_exp_max.key_value <= arg_31_1.info.newDayExp

	setSlider(var_31_0.transform:Find("Progress"), 0, pg.gameset.meta_skill_exp_max.key_value, arg_31_1.info.newDayExp)

	local var_31_6 = arg_31_1.info.curSkillID
	local var_31_8 = arg_31_1.info.newSkillLevel
	local var_31_9 = arg_31_1.info.oldSkillLevel < arg_31_1.info.newSkillLevel
	local var_31_10 = var_31_0.transform:Find("ExpFull")
	local var_31_11 = var_31_0.transform:Find("ExpAdd")

	if var_31_5 then
		setActive(var_31_10, true)
		setActive(var_31_11, false)
	else
		setText(var_31_0.transform:Find("ExpAdd/Value"), string.format("+%d", var_31_4))
		setActive(var_31_10, false)
		setActive(var_31_11, var_31_9)
	end

	if var_31_9 then
		setImageSprite(var_31_1.transform:Find("Skill/Icon"), LoadSprite("skillicon/" .. getSkillConfig(var_31_6).icon))

		local var_31_12 = var_31_1.transform:Find("LevelUp")
		local var_31_13 = var_31_1.transform:Find("LevelMax")

		if var_31_8 >= pg.skill_data_template[var_31_6].max_level then
			setActive(var_31_12, false)
			setActive(var_31_13, true)
		else
			setText(var_31_1.transform:Find("LevelUp/Value"), string.format("+%d", var_31_8 - var_31_7))
			setActive(var_31_12, true)
			setActive(var_31_13, false)
		end
	end

	local function var_31_14()
		if arg_31_2 then
			arg_31_2()
		end

		if arg_31_3 then
			arg_31_3()
		end

		return
	end

	local var_31_15 = GetComponent(var_31_0, "CanvasGroup")
	local var_31_16 = GetComponent(var_31_1, "CanvasGroup")

	GetComponent(var_31_0, "CanvasGroup").alpha = 0
	GetComponent(var_31_1, "CanvasGroup").alpha = 0

	if var_31_5 or var_31_9 then
		local function var_31_17()
			LeanTween.moveX(rtf(var_31_0.transform), 0, var_0_0.FADE_OUT_TIME)
			LeanTween.value(var_31_0, 1, 0, var_0_0.FADE_OUT_TIME):setOnUpdate(System.Action_float(var_0)):setOnComplete(System.Action(function()
				arg_31_0.pools.MetaExpTpl:Enqueue(var_31_0)

				if not var_31_9 then
					arg_31_0.pools.MetaLevelTpl:Enqueue(var_31_1)
					var_31_14()
				end

				return
			end))

			return
		end

		LeanTween.value(var_31_0, 0, 1, var_0_0.FADE_TIME):setOnUpdate(System.Action_float(function(arg_33_0)
			var_31_15.alpha = arg_33_0

			return
		end)):setOnComplete(System.Action(function()
			LeanTween.delayedCall(var_31_0, var_0_0.SHOW_TIME, System.Action(var_31_17))

			return
		end))
	end

	if var_31_9 then
		local function var_31_18(arg_37_0)
			var_31_16.alpha = arg_37_0

			return
		end

		local function var_31_19()
			LeanTween.moveX(rtf(var_31_1.transform), 0, var_0_0.FADE_OUT_TIME)
			LeanTween.value(var_31_1, 1, 0, var_0_0.FADE_OUT_TIME):setOnUpdate(System.Action_float(var_31_18)):setOnComplete(System.Action(function()
				arg_31_0.pools.MetaLevelTpl:Enqueue(var_31_1)
				var_31_14()

				return
			end))

			return
		end

		local function var_31_20()
			LeanTween.delayedCall(var_31_1, var_0_0.SHOW_TIME, System.Action(var_31_19))

			return
		end

		LeanTween.delayedCall(var_31_1, var_0_0.DELAY_TIME, System.Action(function()
			LeanTween.value(var_31_1, 0, 1, var_0_0.FADE_TIME):setOnUpdate(System.Action_float(var_31_18)):setOnComplete(System.Action(var_31_20))

			return
		end))
	end

	return
end

function pg.ToastMgr.UpdateCrusing(arg_42_0, arg_42_1, arg_42_2, arg_42_3)
	local var_42_0 = arg_42_1.info.sound or SFX_UI_TIP

	pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_42_0)

	local var_42_1 = tf(arg_42_0:GetAndSet(arg_42_1.type, arg_42_0.container))
	local var_42_2 = Drop.New({
		type = DROP_TYPE_VITEM,
		id = arg_42_1.info.ptId
	})

	LoadImageSpriteAtlasAsync(var_42_2:getIcon(), "", var_42_1:Find("PointIcon"), true)
	setText(var_42_1:Find("info/name"), var_42_2:getName())
	setText(var_42_1:Find("info/pt"), "+" .. arg_42_1.info.ptCount)
	setAnchoredPosition(var_42_1, {
		x = var_42_1.rect.width
	})
	LeanTween.alphaCanvas(GetComponent(var_42_1, typeof(CanvasGroup)), 1, 0.5):setFrom(0):setOnComplete(System.Action(function()
		LeanTween.alphaCanvas(var_0, 0, 0.5):setDelay(5):setOnComplete(System.Action(function()
			setActive(var_42_1, false)
			arg_42_0.pools[arg_42_1.type .. "Tpl"]:Enqueue(go(var_42_1))

			if arg_42_3 then
				arg_42_3()
			end

			return
		end))

		if arg_42_2 then
			arg_42_2()
		end

		return
	end))

	return
end

function pg.ToastMgr.UpdateVote(arg_45_0, arg_45_1, arg_45_2, arg_45_3)
	local var_45_0 = Drop.New({
		type = DROP_TYPE_ITEM,
		id = arg_45_1.info.ptId
	})
	local var_45_1 = tf(arg_45_0:GetAndSet(arg_45_1.type, arg_45_0.container))

	LoadImageSpriteAtlasAsync(var_45_0:getIcon(), "", var_45_1:Find("PointIcon"), true)
	setText(var_45_1:Find("info/name"), var_45_0:getName())
	setText(var_45_1:Find("info/pt"), "+" .. arg_45_1.info.ptCount)
	setAnchoredPosition(var_45_1, {
		x = var_45_1.rect.width
	})
	LeanTween.alphaCanvas(GetComponent(var_45_1, typeof(CanvasGroup)), 1, 0.5):setFrom(0):setOnComplete(System.Action(function()
		LeanTween.alphaCanvas(var_0, 0, 0.5):setDelay(5):setOnComplete(System.Action(function()
			setActive(var_45_1, false)
			arg_45_0.pools[arg_45_1.type .. "Tpl"]:Enqueue(go(var_45_1))

			if arg_45_3 then
				arg_45_3()
			end

			return
		end))

		if arg_45_2 then
			arg_45_2()
		end

		return
	end))

	return
end

function pg.ToastMgr.UpdateCover(arg_48_0, arg_48_1, arg_48_2, arg_48_3)
	local var_48_0 = arg_48_0:GetAndSet(arg_48_1.type, arg_48_0.container)
	local var_48_1 = var_48_0:GetComponent(typeof(DftAniEvent))

	var_48_1:SetTriggerEvent(function(arg_49_0)
		if arg_48_2 then
			arg_48_2()
		end

		var_48_1:SetTriggerEvent(nil)

		return
	end)
	var_48_1:SetEndEvent(function(arg_50_0)
		setActive(var_48_0, false)
		arg_48_0.pools[arg_48_1.type .. "Tpl"]:Enqueue(var_48_0)
		var_48_1:SetEndEvent(nil)

		if arg_48_3 then
			arg_48_3()
		end

		return
	end)
	var_48_0:GetComponent(typeof(Animation)):Play("attire")
	setText(var_48_0.transform:Find("bg/Text"), HXSet.hxLan(arg_48_1.info:getConfig("get_tips")))

	return
end

function pg.ToastMgr.Dispose(arg_51_0)
	setActive(arg_51_0._tf, false)
	arg_51_0:ResetUIDandHistory()

	for iter_51_0, iter_51_1 in pairs(arg_51_0.pools) do
		iter_51_1:Clear(false)
	end

	return
end

return
