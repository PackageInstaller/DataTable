local var_0_0 = class("IslandSelfCardLayer", import("view.base.BaseUI"))

var_0_0.LABEL_SHOW_CNT = 2
var_0_0.ACHV_SHOW_CNT = 4
var_0_0.COLORS = {
	"#A38759",
	"#AB7B7B",
	"#B1B284",
	"#8B99AC",
	"#8AAD8B",
	"#9D87A9"
}

function var_0_0.getUIName(arg_1_0)
	return "IslandSelfCardUI"
end

function var_0_0.preload(arg_2_0, arg_2_1)
	local var_2_0 = getProxy(PlayerProxy):getData().id

	seriesAsync({
		function(arg_3_0)
			local var_3_0 = getProxy(IslandProxy):GetIsland()

			if var_3_0 then
				arg_2_0.island = var_3_0

				arg_3_0()
			else
				pg.m02:sendNotification(GAME.ISLAND_GET_DATA, {
					isCardRequest = true,
					id = var_2_0,
					list = {},
					callback = function()
						arg_2_0.island = getProxy(IslandProxy):GetIsland()

						arg_3_0()

						return
					end
				})
			end

			return
		end,
		function(arg_5_0)
			pg.m02:sendNotification(GAME.ISLAND_GET_CARD_DATA, {
				userId = var_2_0,
				callback = function(arg_6_0)
					arg_2_0.card = arg_6_0

					arg_5_0()

					return
				end
			})

			return
		end
	}, function()
		arg_2_1()

		return
	end)

	return
end

function var_0_0.init(arg_8_0)
	arg_8_0.uiAnim = arg_8_0._tf:GetComponent(typeof(Animation))
	arg_8_0.uiAnimEvent = arg_8_0._tf:GetComponent(typeof(DftAniEvent))

	arg_8_0.uiAnimEvent:SetEndEvent(function()
		arg_8_0.playingHideAnim = false

		arg_8_0.closeView(arg_8_0, arg_8_0)

		return
	end)
	setText(arg_8_0._tf:Find("tip"), i18n("island_card_close"))

	local var_8_0 = arg_8_0._tf:Find("panel")

	arg_8_0.photoTF = var_8_0:Find("photo/Image")
	arg_8_0.photoSwitchBtn = var_8_0:Find("photo/switch")
	arg_8_0.likeTF = var_8_0:Find("photo/like")
	arg_8_0.labelsTF = var_8_0:Find("labels")
	arg_8_0.visitTF = var_8_0:Find("btns/visit/Text")
	arg_8_0.diyBtn = var_8_0:Find("btns/diy")
	arg_8_0.whitelistBtn = var_8_0:Find("btns/whitelist")
	arg_8_0.blacklistBtn = var_8_0:Find("btns/blacklist")
	arg_8_0.levelTF = var_8_0:Find("level")
	arg_8_0.wordTF = var_8_0:Find("word")
	arg_8_0.nameTF = var_8_0:Find("name")
	arg_8_0.addBtn = arg_8_0.nameTF:Find("add")
	arg_8_0.removeBtn = arg_8_0.nameTF:Find("remove")
	arg_8_0.editBtn = arg_8_0.nameTF:Find("edit")
	arg_8_0.editPanel = arg_8_0._tf:Find("editPanel")
	arg_8_0.editNameBtn = arg_8_0.editPanel:Find("content/name")

	setText(arg_8_0.editNameBtn:Find("Text"), i18n("island_card_edit_name"))

	arg_8_0.editWordBtn = arg_8_0.editPanel:Find("content/word")

	setText(arg_8_0.editWordBtn:Find("Text"), i18n("island_card_edit_word"))

	arg_8_0.shipTF = var_8_0:Find("counts/ship/Text")
	arg_8_0.achvTF = var_8_0:Find("counts/achv/Text")
	arg_8_0.bookTF = var_8_0:Find("counts/book/Text")
	arg_8_0.achvUIList = UIItemList.New(var_8_0:Find("achvs"), var_8_0:Find("achvs/tpl"))

	setText(var_8_0:Find("achvs/tpl/empty/Text"), i18n("island_card_no_achv_self"))
	arg_8_0:InitBoxs()

	return
end

function var_0_0.InitBoxs(arg_10_0)
	arg_10_0.editNameBox = IslandEditCardNameBox.New(arg_10_0._tf, arg_10_0.event)
	arg_10_0.editWordBox = IslandEditCardWordBox.New(arg_10_0._tf, arg_10_0.event)
	arg_10_0.setPhotoBox = IslandSetCardPhotoBox.New(arg_10_0._tf, arg_10_0.event)
	arg_10_0.setAchvsBox = IslandSetCardAchvsBox.New(arg_10_0._tf, arg_10_0.event)
	arg_10_0.showLabelBox = IslandShowCardLabelBox.New(arg_10_0._tf, arg_10_0.event)

	return
end

function var_0_0.didEnter(arg_11_0)
	if not arg_11_0.contextData.isIslandPage then
		pg.UIMgr.GetInstance():BlurPanel(arg_11_0._tf)
	end

	onButton(arg_11_0, arg_11_0._tf:Find("panel/help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.island_helpbtn_card.tip
		})

		return
	end, SFX_PANEL)
	onButton(arg_11_0, arg_11_0._tf:Find("close"), function()
		arg_11_0:PlayHideAnim()

		return
	end, SFX_PANEL)
	onButton(arg_11_0, arg_11_0.photoSwitchBtn, function()
		arg_11_0.setPhotoBox:ExecuteAction("Show", arg_11_0.island:GetCardDiyAgency():GetIds(), arg_11_0.photoId)

		return
	end, SFX_PANEL)
	onButton(arg_11_0, arg_11_0.editBtn, function()
		arg_11_0:ShowEditPanel()

		return
	end, SFX_PANEL)
	onButton(arg_11_0, arg_11_0.editPanel:Find("close"), function()
		arg_11_0:HideEditPanel()

		return
	end, SFX_PANEL)
	onButton(arg_11_0, arg_11_0.editNameBtn, function()
		arg_11_0.editNameBox:ExecuteAction("Show")

		return
	end, SFX_PANEL)
	onButton(arg_11_0, arg_11_0.editWordBtn, function()
		arg_11_0.editWordBox:ExecuteAction("Show")

		return
	end, SFX_PANEL)
	arg_11_0:InitAchvUIList()
	arg_11_0:Flush()

	return
end

function var_0_0.InitAchvUIList(arg_19_0)
	arg_19_0.achvUIList:make(function(arg_20_0, arg_20_1, arg_20_2)
		if arg_20_0 == UIItemList.EventInit then
			onButton(arg_19_0, arg_20_2, function()
				arg_19_0.setAchvsBox:ExecuteAction("Show", arg_19_0.island:GetAchievementAgency():GetGotGroupMaxStageList(), Clone(arg_19_0.card.achvList))

				return
			end, SFX_PANEL)
		elseif arg_20_0 == UIItemList.EventUpdate then
			arg_19_0:UpdataAchvItem(arg_20_1, arg_20_2)
		end

		return
	end)

	return
end

function var_0_0.ShowEditPanel(arg_22_0)
	setAnchoredPosition(arg_22_0.editPanel:Find("content"), (arg_22_0._tf:InverseTransformPoint(arg_22_0.editBtn.position)))
	setActive(arg_22_0.editPanel, true)

	return
end

function var_0_0.HideEditPanel(arg_23_0)
	setActive(arg_23_0.editPanel, false)

	return
end

function var_0_0.UpdataAchvItem(arg_24_0, arg_24_1, arg_24_2)
	setActive(arg_24_2:Find("empty"), not arg_24_0.card.achvList[arg_24_1 + 1])
	setActive(arg_24_2:Find("content"), arg_24_0.card.achvList[arg_24_1 + 1])

	if arg_24_0.card.achvList[arg_24_1 + 1] then
		LoadImageSpriteAtlasAsync("islandachievement", "achv_stage_" .. pg.island_achievement[arg_24_0.card.achvList[arg_24_1 + 1]].stage, arg_24_2:Find("content/Image"), true)
		setText(arg_24_2:Find("content/Text"), pg.island_achievement[arg_24_0.card.achvList[arg_24_1 + 1]].name)
	end

	return
end

function var_0_0.Flush(arg_25_0)
	arg_25_0.card.achvList = getProxy(IslandProxy):GetIsland():GetAchievementAgency():UpdataAchLv(arg_25_0.card.achvList)

	arg_25_0:UpdataPhoto()
	arg_25_0:UpdataLabels()
	arg_25_0:UpdataInfos()

	return
end

function var_0_0.UpdataPhoto(arg_26_0)
	arg_26_0.photoId = tonumber(arg_26_0.card.photoStr)

	if arg_26_0.photoId then
		LoadImageSpriteAsync(pg.island_card_diy[arg_26_0.photoId].resource, arg_26_0.photoTF, true)
	end

	return
end

function var_0_0.UpdataLabels(arg_27_0)
	arg_27_0.labels = arg_27_0.card:GetLabelList()

	table.sort(arg_27_0.labels, CompareFuncs({
		function(arg_28_0)
			return -arg_28_0.num
		end,
		function(arg_29_0)
			return arg_29_0.id
		end
	}))

	for iter_27_0 = 1, var_0_0.LABEL_SHOW_CNT + 1 do
		local var_27_0 = arg_27_0.labelsTF:GetChild(iter_27_0 - 1)
		local var_27_1 = iter_27_0 <= #arg_27_0.labels + 1

		setActive(var_27_0, iter_27_0 <= #arg_27_0.labels + 1)

		if var_27_1 then
			if iter_27_0 <= #arg_27_0.labels then
				arg_27_0:UpdateNoramlLabel(var_27_0, arg_27_0.labels[iter_27_0])
			else
				arg_27_0:UpdateGrayLabel(var_27_0)
			end
		end
	end

	return
end

function var_0_0.UpdateNoramlLabel(arg_30_0, arg_30_1, arg_30_2)
	LoadImageSpriteAtlasAsync("ui/islandcardui_atlas", "label_bg_" .. pg.island_card_label[arg_30_2.id].color, arg_30_1, true)
	setTextColor(arg_30_1:Find("name"), Color.NewHex(var_0_0.COLORS[pg.island_card_label[arg_30_2.id].color]))
	setTextColor(arg_30_1:Find("value"), Color.NewHex(var_0_0.COLORS[pg.island_card_label[arg_30_2.id].color]))
	setText(arg_30_1:Find("name"), pg.island_card_label[arg_30_2.id].name)
	setText(arg_30_1:Find("value"), arg_30_2.num)
	removeOnButton(arg_30_1)

	return
end

function var_0_0.UpdateGrayLabel(arg_31_0, arg_31_1)
	LoadImageSpriteAtlasAsync("ui/islandcardui_atlas", "bg_label_gray", arg_31_1, true)

	local var_31_0 = #arg_31_0.labels == 0

	setTextColor(arg_31_1:Find("name"), Color.NewHex("#F7F7F7"))

	local var_31_1 = var_31_0 and i18n("island_card_no_label") or i18n("island_card_view_detaills")

	setText(arg_31_1:Find("name"), var_31_1)
	setText(arg_31_1:Find("value"), "")

	if not var_31_0 then
		onButton(arg_31_0, arg_31_1, function()
			arg_31_0.showLabelBox:ExecuteAction("Show", arg_31_0.labels)

			return
		end, SFX_PANEL)
	else
		removeOnButton(arg_31_1)
	end

	return
end

function var_0_0.UpdataInfos(arg_33_0)
	setText(arg_33_0.nameTF, arg_33_0.card.name)
	setText(arg_33_0.levelTF, "Lv." .. arg_33_0.card.level)
	setText(arg_33_0.wordTF, arg_33_0.card.word)
	setText(arg_33_0.likeTF, arg_33_0.card.likeCnt)
	setText(arg_33_0.visitTF, arg_33_0.card.visitCnt)
	setText(arg_33_0.shipTF, arg_33_0.card.shipCnt)
	setText(arg_33_0.achvTF, arg_33_0.card.achvCnt)
	setText(arg_33_0.bookTF, arg_33_0.card.bookCnt)
	arg_33_0.achvUIList:align(var_0_0.ACHV_SHOW_CNT)

	return
end

function var_0_0.OnSetNameDone(arg_34_0, arg_34_1)
	arg_34_0:HideEditPanel()
	arg_34_0.editNameBox:ExecuteAction("Hide")

	arg_34_0.card.name = arg_34_1

	setText(arg_34_0.nameTF, arg_34_0.card.name)

	return
end

function var_0_0.OnSetWordDone(arg_35_0, arg_35_1)
	arg_35_0:HideEditPanel()
	arg_35_0.editWordBox:ExecuteAction("Hide")

	arg_35_0.card.word = arg_35_1

	setText(arg_35_0.wordTF, arg_35_0.card.word)

	return
end

function var_0_0.OnSetPhotoDone(arg_36_0, arg_36_1)
	arg_36_0.setPhotoBox:ExecuteAction("Hide")

	arg_36_0.card.photoStr = arg_36_1

	arg_36_0:UpdataPhoto()

	return
end

function var_0_0.OnSetAchvsDone(arg_37_0, arg_37_1)
	arg_37_0.setAchvsBox:ExecuteAction("Hide")

	arg_37_0.card.achvList = getProxy(IslandProxy):GetIsland():GetAchievementAgency():UpdataAchLv(arg_37_1)

	arg_37_0.achvUIList:align(var_0_0.ACHV_SHOW_CNT)

	local var_37_0 = {}

	arg_37_0.achvUIList:eachActive(function(arg_38_0, arg_38_1)
		if arg_37_0.card.achvList[arg_38_0 + 1] then
			local var_38_0 = arg_38_1:Find("content/Image")

			arg_38_1:Find("content/Image"):GetComponent(typeof(CanvasGroup)).alpha = 0

			table.insert(var_37_0, function(arg_39_0)
				arg_38_1:GetComponent(typeof(Animation)):Play()

				var_38_0:GetComponent(typeof(CanvasGroup)).alpha = 1

				arg_37_0:managedTween(LeanTween.delayedCall, function()
					arg_39_0()

					return
				end, 0.08, nil)

				return
			end)
		end

		return
	end)
	seriesAsync({})

	return
end

function var_0_0.PlayHideAnim(arg_41_0)
	if arg_41_0.playingHideAnim then
		return
	end

	arg_41_0.uiAnim:Play("anim_IslandSelfCardUI_out")

	arg_41_0.playingHideAnim = true

	return
end

function var_0_0.willExit(arg_42_0)
	arg_42_0.uiAnimEvent:SetEndEvent(nil)

	if not arg_42_0.contextData.isIslandPage then
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_42_0._tf)
	end

	if arg_42_0.editNameBox then
		arg_42_0.editNameBox:Destroy()

		arg_42_0.editNameBox = nil
	end

	if arg_42_0.editWordBox then
		arg_42_0.editWordBox:Destroy()

		arg_42_0.editWordBox = nil
	end

	if arg_42_0.setPhotoBox then
		arg_42_0.setPhotoBox:Destroy()

		arg_42_0.setPhotoBox = nil
	end

	if arg_42_0.setAchvsBox then
		arg_42_0.setAchvsBox:Destroy()

		arg_42_0.setAchvsBox = nil
	end

	if arg_42_0.showLabelBox then
		arg_42_0.showLabelBox:Destroy()

		arg_42_0.showLabelBox = nil
	end

	return
end

return var_0_0
