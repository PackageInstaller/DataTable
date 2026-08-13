class = var_0_10000

local var_0_0 = "WorldMediaCollectionAlbumGroupLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".WorldMediaCollectionSubLayer"))

var_0_1.ALBUM_TYPE_BASE = 1
var_0_1.ALBUM_TYPE_LOVE_LETTER = 2

function var_0_1.getUIName(arg_1_0)
	return "WorldMediaCollectionAlbumGroupUI"
end

function var_0_1.OnInit(arg_2_0)
	var_0_1.super.OnInit(arg_2_0)

	assert = var_1

	var_1(arg_2_0.viewParent, "Need assign ViewParent for " .. arg_2_0.__cname)

	_ = var_1

	local var_2_0 = var_1.map

	pg = var_2
	arg_2_0.albumGroups = var_2_0(var_2.activity_medal_group.all, function(arg_3_0)
		pg = var_2_10001

		return var_2_10001.activity_medal_group[arg_3_0]
	end)

	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_1.Find(var_2_1, "GroupRect")

	arg_2_0.albumGroupList = var_1.GetComponent(var_2_2, "LScrollRect")

	function arg_2_0.albumGroupList.onInitItem(arg_4_0)
		local var_4_0 = arg_2_0

		var_1.onInitAlbumGroup(var_4_0, arg_4_0)

		return
	end

	function arg_2_0.albumGroupList.onUpdateItem(arg_5_0, arg_5_1)
		local var_5_0 = arg_2_0

		var_2.onUpdateAlbumGroup(var_5_0, arg_5_0 + 1, arg_5_1)

		return
	end

	arg_2_0.albumGroupInfos = {}
	tf = var_1

	local var_2_3 = var_1(arg_2_0.albumGroupList)
	local var_2_4 = var_1.Find(var_2_3, "GroupItem")

	setActive = var_2_3

	var_2_3(var_2_4, false)

	tf = var_2_3

	local var_2_5 = var_2_3(arg_2_0.albumGroupList)

	arg_2_0.albumGroupViewport = var_2.Find(var_2_5, "Viewport")
	tf = var_2

	local var_2_6 = var_2(arg_2_0.albumGroupList)
	local var_2_7 = var_2.Find(var_2_6, "Viewport/Content")
	local var_2_8 = var_2.GetComponent

	typeof = var_4
	GridLayoutGroup = var_1_10005
	arg_2_0.albumGroupsGrid = var_2_8(var_2_7, var_4(var_1_10005))
	AutoLoader = var_2
	arg_2_0.loader = var_2.New()
	setText = var_2

	local var_2_9 = arg_2_0._tf
	local var_2_10 = var_3.Find(var_2_9, "top/expireCheckBox/text")

	i18n = var_2_9

	var_2(var_2_10, var_2_9("word_show_expire_content"))

	local var_2_11 = arg_2_0._tf

	arg_2_0.showExpireBtn = var_2.Find(var_2_11, "top/expireCheckBox/click")

	local var_2_12 = arg_2_0._tf

	arg_2_0.showExpireCheckBox = var_2.Find(var_2_12, "top/expireCheckBox/checkBox/check")
	arg_2_0.showExpire = false
	setActive = var_2

	var_2(arg_2_0.showExpireCheckBox, arg_2_0.showExpire)

	onButton = var_2

	var_2(arg_2_0, arg_2_0.showExpireBtn, function()
		local var_6_0 = arg_2_0

		var_6_0.showExpire = not arg_2_0.showExpire
		setActive = var_6_0

		var_6_0(arg_2_0.showExpireCheckBox, arg_2_0.showExpire)

		local var_6_1 = arg_2_0

		var_0.ExpireFilter(var_6_1)

		local var_6_2 = arg_2_0

		var_0.UpdateView(var_6_2)

		return
	end)

	local var_2_13 = arg_2_0._tf

	arg_2_0.rectAnchorX = var_2.Find(var_2_13, "GroupRect").anchoredPosition.x
	onToggle = var_2

	local var_2_14 = arg_2_0
	local var_2_15 = arg_2_0.toggleBase

	local function var_2_16(arg_7_0)
		if arg_7_0 then
			local var_7_0 = arg_2_0

			var_1.SetPage(var_7_0, false)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_2(var_2_14, var_2_15, var_2_16, var_1_10006)

	onToggle = var_2

	local var_2_17 = arg_2_0
	local var_2_18 = arg_2_0.toggleLoveLetter

	local function var_2_19(arg_8_0)
		if arg_8_0 then
			local var_8_0 = arg_2_0

			var_1.SetPage(var_8_0, true)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_2(var_2_17, var_2_18, var_2_19, var_1_10006)

	arg_2_0.initDic = {}
	arg_2_0.cardItems = {}

	local var_2_20 = arg_2_0.rtScrollRect

	arg_2_0.cardList = var_2.GetComponent(var_2_20, "LScrollRect")

	function arg_2_0.cardList.onInitItem(arg_9_0)
		local var_9_0 = arg_2_0

		var_1.onInitCard(var_9_0, arg_9_0)

		return
	end

	function arg_2_0.cardList.onUpdateItem(arg_10_0, arg_10_1)
		local var_10_0 = arg_2_0

		var_2.onUpdateCard(var_10_0, arg_10_0, arg_10_1)

		return
	end

	local var_2_21 = arg_2_0.cardList

	function var_2_21.onReturnItem(arg_11_0, arg_11_1)
		local var_11_0 = arg_2_0

		var_2.onReturnCard(var_11_0, arg_11_0, arg_11_1)

		return
	end

	pg = var_2_21

	local var_2_22 = var_2_21.EasyRedDotMgr.GetInstance()
	local var_2_23 = var_2.RegisterRedDot
	local var_2_24 = arg_2_0.toggleLoveLetter

	var_2_23(var_2_22, var_4.Find(var_2_24, "tip"), {
		"love_letter_unlock_letter"
	}, function(arg_12_0)
		setActive = var_2_10001

		local var_12_0 = arg_12_0

		getProxy = var_2_10003
		LoveLetterProxy = var_2_10004

		local var_12_1 = var_2_10003(var_2_10004)

		var_2_10001(var_12_0, var_3.IsTipUnlockLetter(var_12_1))

		return
	end)

	if arg_2_0.contextData.albumType == var_0_1.ALBUM_TYPE_LOVE_LETTER then
		triggerToggle = var_2

		var_2(arg_2_0.toggleLoveLetter, true)
	else
		triggerToggle = var_2

		var_2(arg_2_0.toggleBase, true)
	end

	return
end

function var_0_1.SetPage(arg_13_0, arg_13_1)
	setActive = var_1_10002

	var_1_10002(arg_13_0.rtGroupRect, not arg_13_1)

	setActive = var_1_10002

	var_1_10002(arg_13_0.rtExpireCheckBox, not arg_13_1)

	setActive = var_1_10002

	var_1_10002(arg_13_0.rtLoveLetterPanel, arg_13_1)

	if not arg_13_0.initDic[arg_13_1] then
		switch = var_2

		var_2(arg_13_1, {
			[false] = function()
				local var_14_0 = arg_13_0

				var_0.ExpireFilter(var_14_0)

				local var_14_1 = arg_13_0

				var_0.UpdateView(var_14_1)

				return
			end,
			[true] = function()
				local var_15_0 = arg_13_0

				var_0.updateLoveLetterPage(var_15_0)

				return
			end
		}, nil)

		arg_13_0.initDic[arg_13_1] = true
	end

	return
end

function var_0_1.onInitAlbumGroup(arg_16_0, arg_16_1)
	if arg_16_0.exited then
		return
	end

	onButton = var_2

	local var_16_0 = arg_16_0
	local var_16_1 = arg_16_1

	local function var_16_2()
		if arg_16_0.albumGroupInfos[arg_16_1] then
			local var_17_0 = arg_16_0.viewParent

			var_1.ShowAlbum(var_17_0, var_0)
		end

		return
	end

	SOUND_BACK = var_1_10006

	var_2(var_16_0, var_16_1, var_16_2, var_1_10006)

	return
end

function var_0_1.onUpdateAlbumGroup(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_0.exited then
		return
	end

	local var_18_0 = arg_18_0.albumGroups[arg_18_1]

	arg_18_0.albumGroupInfos[arg_18_2] = var_18_0

	local var_18_1 = arg_18_0.loader
	local var_18_2 = var_4.GetSpriteQuiet
	local var_18_3 = var_18_0.entrance_picture
	local var_18_4 = ""

	tf = var_1_10008

	local var_18_5 = var_1_10008(arg_18_2)

	var_18_2(var_18_1, var_18_3, var_18_4, var_8.Find(var_18_5, "BG"))

	ActivityMedalGroup = var_18_2

	local var_18_6, var_18_7

	if var_18_2.IsMedalGroupCollectionGrey(var_18_0.id) then
		ActivityMedalGroup = var_18_6
		var_18_6 = var_18_6.GetMedalGroupStateByID(var_18_0.id)
		ActivityMedalGroup = var_18_3
		var_18_7 = var_18_6 < var_18_3.STATE_ACTIVE
	end

	setActive = var_18_6
	tf = var_18_3

	local var_18_8 = var_18_3(arg_18_2)

	var_18_6(var_6.Find(var_18_8, "expireMask"), var_18_7)

	return
end

function var_0_1.Return2MemoryGroup(arg_19_0)
	local var_19_0 = 0
	local var_19_1 = arg_19_0:GetIndexRatio(var_19_0)
	local var_19_2 = arg_19_0.albumGroupList

	var_3.SetTotalCount(var_19_2, #arg_19_0.albumGroups, var_19_1)

	return
end

function var_0_1.SwitchReddotMemory(arg_20_0)
	local var_20_0 = 0

	getProxy = var_1_10002
	PlayerProxy = var_1_10003

	local var_20_1 = var_1_10002(var_1_10003)
	local var_20_2 = var_2.getRawData(var_20_1).id

	ipairs = var_20_1

	for iter_20_0, iter_20_1 in var_20_1(arg_20_0.albumGroups) do
		PlayerPrefs = var_1_10008

		if var_1_10008.GetInt("ALBUM_GROUP_NOTIFICATION" .. var_20_2 .. " " .. iter_20_1.id, 0) == 1 then
			var_20_0 = iter_20_0

			break
		end
	end

	if var_20_0 == 0 then
		return
	end

	local var_20_3 = arg_20_0:GetIndexRatio(var_20_0)
	local var_20_4 = arg_20_0.albumGroupList

	var_4.SetTotalCount(var_20_4, #arg_20_0.albumGroups, var_20_3)

	return
end

function var_0_1.GetIndexRatio(arg_21_0, arg_21_1)
	local var_21_0 = 0

	if arg_21_1 > 0 then
		local var_21_1 = arg_21_0.albumGroupList
		local var_21_2 = arg_21_0.albumGroupsGrid.cellSize.y + arg_21_0.albumGroupsGrid.spacing.y
		local var_21_3 = arg_21_0.albumGroupsGrid.constraintCount

		math = var_1_10006

		local var_21_4 = var_21_2 * var_1_10006.ceil(#arg_21_0.albumGroups / var_21_3)

		math = var_7
		var_21_0 = (var_21_2 * var_7.floor((arg_21_1 - 1) / var_21_3) + var_21_1.paddingFront) / (var_21_4 - arg_21_0.albumGroupViewport.rect.height)
		Mathf = var_7
		var_21_0 = var_7.Clamp01(var_21_0)
	end

	return var_21_0
end

function var_0_1.ExpireFilter(arg_22_0)
	local var_22_0 = {}

	ipairs = var_1_10002
	pg = var_1_10003

	for iter_22_0, iter_22_1 in var_1_10002(var_1_10003.activity_medal_group.all) do
		pg = var_1_10007
		var_1_10007 = var_1_10007.activity_medal_group[iter_22_1]
		ActivityMedalGroup = var_1_10008
		var_1_10008 = var_1_10008.GetMedalGroupStateByID(var_1_10007.id)

		if not arg_22_0.showExpire then
			ActivityMedalGroup = var_9

			if var_9.STATE_ACTIVE <= var_1_10008 then
				table = var_9

				var_9.insert(var_22_0, var_1_10007)
			end
		end
	end

	arg_22_0.albumGroups = var_22_0

	return
end

function var_0_1.UpdateView(arg_23_0)
	WorldMediaCollectionScene = var_1_10001

	local var_23_0 = var_1_10001.WorldRecordLock()

	setAnchoredPosition = var_1_10002

	local var_23_1 = arg_23_0._tf

	var_1_10002(var_3.Find(var_23_1, "GroupRect"), {
		x = var_23_0 and 0 or arg_23_0.rectAnchorX
	})

	local var_23_2 = arg_23_0.albumGroupList

	var_2.SetTotalCount(var_23_2, #arg_23_0.albumGroups, 0)

	return
end

function var_0_1.updateLoveLetterPage(arg_24_0)
	getProxy = var_1_10001
	LoveLetterProxy = var_1_10002

	local var_24_0 = var_1_10001(var_1_10002)

	arg_24_0.cardInfos = var_1.GetDisplayLetterList(var_24_0)
	onDelayTick = var_1

	var_1(function()
		arg_24_0.cardList.enabled = true

		local var_25_0 = arg_24_0.cardList

		var_0.SetTotalCount(var_25_0, #arg_24_0.cardInfos, 0)

		return
	end, 0.001)

	return
end

function var_0_1.onInitCard(arg_26_0, arg_26_1)
	LoveLetterShipCard = var_1_10002

	local var_26_0 = var_1_10002.New(arg_26_1)
	local var_26_1 = arg_26_0.cardItems

	var_26_1[arg_26_1] = var_26_0
	onButton = var_26_1

	var_26_1(arg_26_0, var_26_0.go, function()
		if var_26_0.shipGroup then
			local var_27_0 = arg_26_0
			local var_27_1 = var_0.emit

			WorldMediaCollectionMediator = var_2_10002

			var_27_1(var_27_0, var_2_10002.OPEN_LOVE_LETTER_DISPLAY, var_26_0.shipGroup.id)
		end

		return
	end)

	return
end

function var_0_1.onUpdateCard(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0

	if not arg_28_0.cardItems[arg_28_2] then
		arg_28_0:onInitCard(arg_28_2)

		var_28_0 = arg_28_0.cardItems[arg_28_2]
	end

	local var_28_1 = arg_28_1 + 1
	local var_28_2 = arg_28_0.cardInfos[var_28_1]

	var_28_0:update(var_28_2)

	pg = var_6

	local var_28_3 = var_6.EasyRedDotMgr.GetInstance()
	local var_28_4 = var_6.RegisterRedDot
	local var_28_5 = arg_28_2.transform

	var_28_4(var_28_3, var_8.Find(var_28_5, "content/pick_up"), {
		"love_letter_unlock_letter"
	}, function(arg_29_0)
		getProxy = var_2_10001
		LoveLetterProxy = var_2_10002

		local var_29_0 = var_2_10001(var_2_10002)
		local var_29_1 = var_1.GetGroupData(var_29_0, var_28_2.id)

		setActive = var_29_0

		local var_29_2 = arg_29_0

		underscore = var_2_10004

		var_29_0(var_29_2, var_2_10004.any(var_29_1:GetDisplayLetterList(), function(arg_30_0)
			local var_30_0 = var_29_1

			return not var_1.GetLetterUnlock(var_30_0, arg_30_0)
		end))

		return
	end)

	return
end

function var_0_1.onReturnCard(arg_31_0, arg_31_1, arg_31_2)
	if arg_31_0.exited then
		return
	end

	if arg_31_0.cardItems[arg_31_2] then
		var_3:clear()
	end

	arg_31_0.cardItems[arg_31_2] = nil

	return
end

function var_0_1.OnDestroy(arg_32_0)
	pairs = var_1_10001

	for iter_32_0, iter_32_1 in var_1_10001(arg_32_0.cardItems) do
		pg = var_1_10006

		local var_32_0 = var_1_10006.EasyRedDotMgr.GetInstance()

		var_1_10006 = var_1_10006.UnRegisterRedDot

		local var_32_1 = iter_32_0.transform

		var_1_10006(var_32_0, var_8.Find(var_32_1, "content/pick_up"))
	end

	pg = var_1

	local var_32_2 = var_1.EasyRedDotMgr.GetInstance()
	local var_32_3 = var_1.UnRegisterRedDot
	local var_32_4 = arg_32_0.toggleLoveLetter

	var_32_3(var_32_2, var_3.Find(var_32_4, "tip"))

	return
end

return var_0_1
