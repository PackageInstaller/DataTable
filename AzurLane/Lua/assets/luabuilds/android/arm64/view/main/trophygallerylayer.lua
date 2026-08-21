local var_0_0 = class("TrophyGalleryLayer", import("..base.BaseUI"))

var_0_0.Filter = {
	"all",
	"claimed"
}
var_0_0.PAGE_COMMON = 1
var_0_0.PAGE_LIMITED = 2

function var_0_0.getUIName(arg_1_0)
	return "TrophyGalleryUI"
end

function var_0_0.setTrophyGroups(arg_2_0, arg_2_1)
	arg_2_0.trophyGroups = arg_2_1

	return
end

function var_0_0.setTrophyList(arg_3_0, arg_3_1)
	arg_3_0.trophyList = arg_3_1

	return
end

function var_0_0.init(arg_4_0)
	arg_4_0._bg = arg_4_0._tf:Find("bg")
	arg_4_0._blurPanel = arg_4_0._tf:Find("blur_panel")
	arg_4_0._topPanel = arg_4_0._blurPanel:Find("adapt/top")
	arg_4_0._backBtn = arg_4_0._topPanel:Find("back_btn")
	arg_4_0._helpBtn = arg_4_0._topPanel:Find("help_btn")
	arg_4_0._center = arg_4_0._tf:Find("bg/taskBGCenter")
	arg_4_0._trophyUpperTpl = arg_4_0:getTpl("trophy_upper", arg_4_0._center)
	arg_4_0._trophyLowerTpl = arg_4_0:getTpl("trophy_lower", arg_4_0._center)
	arg_4_0._trophyContainer = arg_4_0._tf:Find("bg/taskBGCenter/right_panel/Grid")
	arg_4_0._scrllPanel = arg_4_0._tf:Find("bg/taskBGCenter/right_panel")
	arg_4_0._scrollView = arg_4_0._scrllPanel:GetComponent("LScrollRect")
	arg_4_0._trophyDetailPanel = TrophyDetailPanel.New(arg_4_0._tf:Find("trophyPanel"), arg_4_0._tf)
	arg_4_0._filterBtn = arg_4_0._topPanel:Find("filter/toggle")
	arg_4_0._trophyCounter = arg_4_0._topPanel:Find("filter/counter/Text")
	arg_4_0._reminderRes = arg_4_0._tf:Find("bg/resource")
	arg_4_0._pageToggle = {
		arg_4_0._tf:Find("blur_panel/adapt/left_length/frame/root/common_toggle"),
		arg_4_0._tf:Find("blur_panel/adapt/left_length/frame/root/limited_toggle"),
		arg_4_0.toggleLoveLetter
	}
	arg_4_0._hideExpireBtn = arg_4_0._tf:Find("blur_panel/adapt/top/expireCheckBox")
	arg_4_0._hideExpireCheck = arg_4_0._hideExpireBtn:Find("check")
	arg_4_0._pageIndex = arg_4_0.contextData.index or 1
	arg_4_0._hideExpire = false
	arg_4_0._trophyTFList = {}
	arg_4_0._trophyViewCache = {}
	arg_4_0._trophyMatCache = {}
	arg_4_0.cardItems = {}
	arg_4_0.cardList = arg_4_0.rtScrollContent:GetComponent("LScrollRect")

	function arg_4_0.cardList.onInitItem(arg_5_0)
		arg_4_0:onInitCard(arg_5_0)

		return
	end

	function arg_4_0.cardList.onUpdateItem(arg_6_0, arg_6_1)
		arg_4_0:onUpdateCard(arg_6_0, arg_6_1)

		return
	end

	function arg_4_0.cardList.onReturnItem(arg_7_0, arg_7_1)
		arg_4_0:onReturnCard(arg_7_0, arg_7_1)

		return
	end

	arg_4_0._loader = AutoLoader.New()

	return
end

function var_0_0.checkTrophyVisible(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if arg_8_1:GetTrophyPage() ~= arg_8_2 then
		return false
	end

	local var_8_0 = false

	if arg_8_3 == "all" then
		var_8_0 = true
	elseif arg_8_3 == "claimed" then
		var_8_0 = arg_8_1:getMaxClaimedTrophy() ~= nil
	end

	if arg_8_2 == var_0_0.PAGE_LIMITED and arg_8_0._hideExpire and arg_8_1:IsExpire() == 1 then
		if not arg_8_1:getProgressTrophy():isClaimed() then
			var_8_0 = false
		end
	end

	return var_8_0
end

function var_0_0.ensureTrophyViewCache(arg_9_0, arg_9_1)
	if arg_9_0._trophyViewCache[arg_9_1] then
		return arg_9_0._trophyViewCache[arg_9_1]
	end

	local var_9_0 = cloneTplTo(arg_9_0._trophyUpperTpl, arg_9_0._trophyContainer)
	local var_9_1 = cloneTplTo(arg_9_0._trophyLowerTpl, arg_9_0._trophyContainer)
	local var_9_2 = TrophyView.New(var_9_0)
	local var_9_3 = TrophyView.New(var_9_1)

	onButton(arg_9_0, var_9_0.transform:Find("frame"), function()
		local var_10_0 = arg_9_0.trophyGroups[arg_9_1]:getProgressTrophy()

		if not arg_9_0._trophyTFList[arg_9_1] then
			return
		end

		if var_10_0:canClaimed() and not var_10_0:isClaimed() then
			if not arg_9_0._trophyTFList[arg_9_1]:IsPlaying() then
				arg_9_0:emit(TrophyGalleryMediator.ON_TROPHY_CLAIM, var_10_0.id)
			end
		elseif not arg_9_0._trophyTFList[arg_9_1]:IsPlaying() then
			arg_9_0:openTrophyDetail(arg_9_0.trophyGroups[arg_9_1], var_10_0)
		end

		return
	end)
	onButton(arg_9_0, var_9_1.transform:Find("frame"), function()
		local var_10_0 = arg_9_0.trophyGroups[arg_9_1]:getProgressTrophy()

		if not arg_9_0._trophyTFList[arg_9_1] then
			return
		end

		if var_10_0:canClaimed() and not var_10_0:isClaimed() then
			if not arg_9_0._trophyTFList[arg_9_1]:IsPlaying() then
				arg_9_0:emit(TrophyGalleryMediator.ON_TROPHY_CLAIM, var_10_0.id)
			end
		elseif not arg_9_0._trophyTFList[arg_9_1]:IsPlaying() then
			arg_9_0:openTrophyDetail(arg_9_0.trophyGroups[arg_9_1], var_10_0)
		end

		return
	end)
	setActive(var_9_0, false)
	setActive(var_9_1, false)

	arg_9_0._trophyViewCache[arg_9_1] = {
		upperGO = var_9_0,
		lowerGO = var_9_1,
		upperView = var_9_2,
		lowerView = var_9_3
	}

	return {
		upperGO = var_9_0,
		lowerGO = var_9_1,
		upperView = var_9_2,
		lowerView = var_9_3
	}
end

function var_0_0.updateTrophyViewByFilter(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if arg_11_3 == "all" then
		arg_11_1:UpdateTrophyGroup(arg_11_2)
	elseif arg_11_3 == "claimed" then
		arg_11_1:ClaimForm(arg_11_2)
	elseif arg_11_3 == "unclaim" then
		arg_11_1:ProgressingForm(arg_11_2)
	end

	return
end

function var_0_0.updateTrophyReminderMaterial(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1:GetTrophyClaimTipsID()

	if arg_12_0._trophyMatCache[var_12_0] then
		arg_12_1:SetTrophyReminderMaterial(arg_12_0._trophyMatCache[var_12_0])

		return
	end

	local var_12_1 = "artresource/effect/xunzhang/materials/" .. var_12_0

	if checkABExist("artresource/effect/xunzhang/materials/" .. var_12_0) then
		arg_12_0._loader:LoadBundle(var_12_1, function(arg_13_0)
			local var_13_0 = arg_13_0:LoadAssetSync(var_12_0, typeof(Material), false, false)

			arg_12_0._trophyMatCache[var_12_0] = var_13_0

			arg_12_1:SetTrophyReminderMaterial(var_13_0)

			return
		end)
	end

	return
end

function var_0_0.didEnter(arg_14_0)
	arg_14_0:OverlayPanel(arg_14_0._tf)
	onButton(arg_14_0, arg_14_0._backBtn, function()
		arg_14_0:emit(var_0_0.ON_CLOSE)

		return
	end, SFX_CANCEL)
	onButton(arg_14_0, arg_14_0._filterBtn, function()
		arg_14_0:onFilter()

		return
	end, SFX_PANEL)
	onButton(arg_14_0, arg_14_0._helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.medal_help_tip.tip
		})

		return
	end, SFX_PANEL)
	onButton(arg_14_0, arg_14_0._hideExpireBtn, function()
		arg_14_0._hideExpire = not arg_14_0._hideExpire

		setActive(arg_14_0._hideExpireCheck, not arg_14_0._hideExpire)
		arg_14_0:updateTrophyList()

		return
	end, SFX_PANEL)
	triggerButton(arg_14_0._hideExpireBtn)

	for iter_14_0, iter_14_1 in ipairs(arg_14_0._pageToggle) do
		onButton(arg_14_0, iter_14_1, function()
			arg_14_0:updatePage(iter_14_0)

			return
		end, SFX_PANEL)
	end

	pg.EasyRedDotMgr.GetInstance():RegisterRedDot(arg_14_0.toggleLoveLetter:Find("tip"), {
		"love_letter_level_up",
		"love_letter_level_reward"
	}, function(arg_20_0)
		local var_20_0 = getProxy(LoveLetterProxy)
		local var_20_1 = var_20_0:IsTipLevelUp() or var_20_0:IsTipAllLevelReward()

		setActive(arg_20_0, var_20_1)

		return
	end)
	pg.EasyRedDotMgr.GetInstance():RegisterRedDot(arg_14_0.rtCountLevelPanel:Find("info/icon/tip"), {
		"love_letter_level_up",
		"love_letter_level_reward"
	}, function(arg_21_0)
		setActive(arg_21_0, getProxy(LoveLetterProxy):IsTipAllLevelReward())

		return
	end)

	arg_14_0._filterIndex = 0

	triggerButton(arg_14_0._filterBtn)
	triggerButton(arg_14_0._pageToggle[arg_14_0._pageIndex])
	arg_14_0:updateTrophyCounter()

	return
end

function var_0_0.updatePage(arg_22_0, arg_22_1)
	for iter_22_0, iter_22_1 in ipairs(arg_22_0._pageToggle) do
		setActive(iter_22_1:Find("selected"), iter_22_0 == arg_22_1)
		setActive(iter_22_1:Find("Image"), iter_22_0 ~= arg_22_1)
	end

	arg_22_0._pageIndex = arg_22_1

	local var_22_0 = arg_22_1 == 3

	setActive(arg_22_0._center, not (arg_22_1 == 3))
	setActive(arg_22_0._topPanel:Find("filter"), not var_22_0)
	setActive(arg_22_0.rtLoveLetterPanel, var_22_0)
	setActive(arg_22_0.rtCountLevelPanel, var_22_0)
	setActive(arg_22_0.rtCountLevelBg, var_22_0)

	if var_22_0 then
		arg_22_0:updateLoveLetterPage()
	else
		arg_22_0:updateTrophyList()
	end

	setActive(arg_22_0._hideExpireBtn, arg_22_1 == var_0_0.PAGE_LIMITED)

	return
end

function var_0_0.updateTrophyList(arg_23_0)
	arg_23_0._trophyTFList = {}

	for iter_23_0, iter_23_1 in pairs(arg_23_0._trophyViewCache) do
		setActive(iter_23_1.upperGO, false)
		setActive(iter_23_1.lowerGO, false)
	end

	local var_23_0 = var_0_0.Filter[arg_23_0._filterIndex]
	local var_23_1 = 1

	for iter_23_2, iter_23_3 in pairs(arg_23_0.trophyGroups) do
		if arg_23_0:checkTrophyVisible(iter_23_3, arg_23_0._pageIndex, var_23_0) then
			local var_23_2 = arg_23_0:ensureTrophyViewCache(iter_23_2)
			local var_23_3 = math.fmod(var_23_1, 2) == 1

			if var_23_3 then
				local var_23_4 = var_23_2.upperGO or var_23_2.lowerGO

				if var_23_3 then
					local var_23_5 = var_23_2.lowerGO or var_23_2.upperGO

					if var_23_3 then
						local var_23_6 = var_23_2.upperView or var_23_2.lowerView

						setActive(var_23_4, true)
						setActive(var_23_5, false)
						var_23_4.transform:SetSiblingIndex(var_23_1 - 1)
						arg_23_0:updateTrophyViewByFilter(var_23_6, iter_23_3, var_23_0)
						arg_23_0:updateTrophyReminderMaterial(var_23_6)

						arg_23_0._trophyTFList[iter_23_2] = var_23_6
						var_23_1 = var_23_1 + 1
					end
				end
			end
		end
	end

	return
end

function var_0_0.PlayTrophyClaim(arg_24_0, arg_24_1)
	arg_24_0._trophyTFList[arg_24_1]:PlayClaimAnima(arg_24_0.trophyGroups[arg_24_1], Instantiate(arg_24_0._reminderRes:Find("claim_fx")), function()
		arg_24_0:updateTrophyByGroup(arg_24_1)
		arg_24_0:updateTrophyCounter()

		return
	end)

	return
end

function var_0_0.updateTrophyByGroup(arg_26_0, arg_26_1)
	arg_26_0._trophyTFList[arg_26_1]:UpdateTrophyGroup(arg_26_0.trophyGroups[arg_26_1])

	return
end

function var_0_0.openTrophyDetail(arg_27_0, arg_27_1, arg_27_2)
	arg_27_0._trophyDetailPanel:SetTrophyGroup(arg_27_1)
	arg_27_0._trophyDetailPanel:UpdateTrophy(arg_27_2)
	arg_27_0._trophyDetailPanel:SetActive(true)

	return
end

function var_0_0.updateTrophyCounter(arg_28_0)
	local var_28_0 = 0

	for iter_28_0, iter_28_1 in pairs(arg_28_0.trophyList) do
		if iter_28_1:isClaimed() and not iter_28_1:isHide() then
			var_28_0 = var_28_0 + 1
		end
	end

	setText(arg_28_0._trophyCounter, var_28_0)

	return
end

function var_0_0.onFilter(arg_29_0)
	arg_29_0._filterIndex = arg_29_0._filterIndex + 1

	if arg_29_0._filterIndex > #var_0_0.Filter then
		arg_29_0._filterIndex = 1
	end

	for iter_29_0 = 1, #var_0_0.Filter do
		setActive(arg_29_0._filterBtn:GetChild(iter_29_0 - 1), iter_29_0 == arg_29_0._filterIndex)
	end

	arg_29_0:updateTrophyList()

	return
end

function var_0_0.updateLoveLetterPage(arg_30_0)
	if not arg_30_0.contextData.checkRalizeGift then
		arg_30_0.contextData.checkRalizeGift = true

		if getProxy(LoveLetterProxy):IsTipRealizeGift() then
			arg_30_0:emit(TrophyGalleryMediator.OPEN_REALIZE_GIFT_LAYER)
		end
	end

	arg_30_0.cardInfos = getProxy(LoveLetterProxy):GetDisplayGroupList()

	arg_30_0.cardList:SetTotalCount(#arg_30_0.cardInfos, -1)

	local var_30_0 = getProxy(LoveLetterProxy)
	local var_30_1 = arg_30_0.rtCountLevelPanel:Find("info")

	setText(var_30_1:Find("word"), i18n("loveactivity_ui_10"))
	setText(var_30_1:Find("count"), (var_30_0:GetAllLevel()))

	local var_30_2, var_30_3 = var_30_0:GetAllLevelProgress()

	if var_30_3 == 0 then
		setSlider(var_30_1:Find("Slider"), 0, 1, 1)
	else
		setSlider(var_30_1:Find("Slider"), 0, var_30_3, var_30_2)
	end

	setText(var_30_1:Find("Slider/Text"), var_30_2 .. "/" .. var_30_3)
	updateDrop(var_30_1:Find("icon/mask/IconTpl"), var_30_0:GetAllLevelNextAward()[1])
	onButton(arg_30_0, var_30_1:Find("icon/mask/IconTpl"), function()
		arg_30_0:emit(BaseUI.ON_DROP, drop[1])

		return
	end, SFX_PANEL)
	setActive(var_30_1:Find("icon/got"), var_30_3 == 0)
	onButton(arg_30_0, var_30_1:Find("click"), function()
		local var_32_0 = pg.NewStyleMsgboxMgr.GetInstance()
		local var_32_1 = var_32_0
		local var_32_3 = pg.NewStyleMsgboxMgr.TYPE_LOVE_LETTER_LEVEL_REWARD
		local var_32_4 = {}

		var_32_4.btnList = #getProxy(LoveLetterProxy):GetAllLevelReadyReward() > 0 and {
			{
				type = pg.NewStyleMsgboxMgr.BUTTON_TYPE.cancel,
				name = i18n("msgbox_text_cancel"),
				sound = SFX_CANCEL
			},
			{
				type = pg.NewStyleMsgboxMgr.BUTTON_TYPE.confirm,
				name = i18n("mail_get_oneclick"),
				func = function()
					arg_30_0:emit(TrophyGalleryMediator.ON_GET_ALL_LOVE_LETTER_REWARD, var_0)

					return
				end,
				sound = SFX_CONFIRM
			}
		} or nil

		var_32_2(var_32_1, var_32_3, var_32_4)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.onInitCard(arg_34_0, arg_34_1)
	local var_34_0 = LoveLetterShipCard.New(arg_34_1)

	onButton(arg_34_0, var_34_0.go, function()
		if var_34_0.shipGroup then
			arg_34_0:emit(TrophyGalleryMediator.OPEN_DISPLAY_WINDOW, var_34_0.shipGroup.id)
		end

		return
	end)

	arg_34_0.cardItems[arg_34_1] = var_34_0

	return
end

function var_0_0.onUpdateCard(arg_36_0, arg_36_1, arg_36_2)
	if not arg_36_0.cardItems[arg_36_2] then
		arg_36_0:onInitCard(arg_36_2)
	end

	arg_36_0.cardItems[arg_36_2]:update(arg_36_0.cardInfos[arg_36_1 + 1])
	pg.EasyRedDotMgr.GetInstance():RegisterRedDot(arg_36_2.transform:Find("content/pick_up"), {
		"love_letter_level_up"
	}, function(arg_37_0)
		local var_37_0 = getProxy(LoveLetterProxy):GetGroupData(var_0.id)

		setActive(arg_37_0, var_37_0:GetDisplayLevel() < var_37_0:GetMaxLevel() and var_37_0:CanLevelUp())

		return
	end)

	return
end

function var_0_0.onReturnCard(arg_38_0, arg_38_1, arg_38_2)
	if arg_38_0.exited then
		return
	end

	if arg_38_0.cardItems[arg_38_2] then
		var_38_0:clear()
	end

	arg_38_0.cardItems[arg_38_2] = nil

	return
end

function var_0_0.onBackPressed(arg_39_0)
	if arg_39_0._trophyDetailPanel:IsActive() then
		arg_39_0._trophyDetailPanel:SetActive(false)
	else
		var_0_0.super.onBackPressed(arg_39_0)
	end

	return
end

function var_0_0.willExit(arg_40_0)
	arg_40_0._loader:Clear()
	pg.EasyRedDotMgr.GetInstance():UnRegisterRedDot(arg_40_0.toggleLoveLetter:Find("tip"))
	pg.EasyRedDotMgr.GetInstance():UnRegisterRedDot(arg_40_0.rtCountLevelPanel:Find("info/icon/tip"))

	for iter_40_0, iter_40_1 in pairs(arg_40_0.cardItems) do
		pg.EasyRedDotMgr.GetInstance():UnRegisterRedDot(iter_40_0.transform:Find("content/pick_up"))
	end

	arg_40_0:UnOverlayPanel(arg_40_0._blurPanel, arg_40_0._tf)
	arg_40_0._trophyDetailPanel:Dispose()

	return
end

return var_0_0
