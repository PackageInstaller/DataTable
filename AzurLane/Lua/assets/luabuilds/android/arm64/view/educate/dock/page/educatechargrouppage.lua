class = var_0_10000

local var_0_0 = "EducateCharGroupPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseEventLogic"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	pg = var_1_10004

	var_1_10004.DelegateInfo.New(arg_1_0)
	var_0_1.super.Ctor(arg_1_0, arg_1_2)

	arg_1_0.contextData = arg_1_3
	arg_1_0.tf = arg_1_1
	arg_1_0.go = arg_1_1.gameObject
	findTF = var_4
	arg_1_0.confirmBtn = var_4(arg_1_1, "confirm_btn")
	findTF = var_4
	arg_1_0.cancelBtn = var_4(arg_1_1, "cancel_btn")
	UIItemList = var_4

	local var_1_0 = var_4.New

	findTF = var_6

	local var_1_1 = var_6(arg_1_1, "main/list")

	findTF = var_7
	arg_1_0.uiItemList = var_1_0(var_1_1, var_7(arg_1_1, "main/list/tpl"))
	UIItemList = var_4

	local var_1_2 = var_4.New

	findTF = var_1_1

	local var_1_3 = var_1_1(arg_1_1, "tab/list")

	findTF = var_7
	arg_1_0.tabItemList = var_1_2(var_1_3, var_7(arg_1_1, "tab/list/tpl"))
	findTF = var_4
	arg_1_0.profileBtn = var_4(arg_1_1, "right/icon")

	local var_1_4 = arg_1_1
	local var_1_5 = arg_1_1.GetComponent

	typeof = var_7
	Animation = var_9
	arg_1_0.animation = var_1_5(var_1_4, var_7(var_9))

	local var_1_6 = arg_1_1
	local var_1_7 = arg_1_1.GetComponent

	typeof = var_7
	DftAniEvent = var_9
	arg_1_0.dftAniEvent = var_1_7(var_1_6, var_7(var_9))
	arg_1_0.timers = {}

	arg_1_0:RegisterEvent()

	return
end

function var_0_1.RegisterEvent(arg_2_0)
	onButton = var_1_10001

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.profileBtn

	local function var_2_2()
		local var_3_0 = arg_2_0
		local var_3_1 = var_0.emit

		EducateCharDockMediator = var_2_10003

		var_3_1(var_3_0, var_2_10003.GO_PROFILE, arg_2_0.selectedCharacterId)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_2_0, var_2_1, var_2_2, var_1_10006)

	local var_2_3 = arg_2_0
	local var_2_4 = arg_2_0.bind

	EducateCharDockScene = var_2_1

	var_2_4(var_2_3, var_2_1.MSG_CLEAR_TIP, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_2_0

		var_2.FlushList(var_4_0, arg_2_0.selectedId)

		return
	end)

	return
end

function var_0_1.Update(arg_5_0)
	arg_5_0:InitData()
	arg_5_0:InitTabs()
	arg_5_0:InitList()
	arg_5_0:CheckChangeFormShop()

	return
end

function var_0_1.Show(arg_6_0)
	setActive = var_1_10001

	var_1_10001(arg_6_0.tf, true)

	return
end

function var_0_1.Hide(arg_7_0)
	setActive = var_1_10001

	var_1_10001(arg_7_0.tf, false)
	arg_7_0:RemoveAllTimer()

	return
end

function var_0_1.GetSelectedId(arg_8_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_8_0 = var_1_10001(var_1_10003)
	local var_8_1 = var_1.getRawData(var_8_0)

	return var_1.GetEducateCharacter(var_8_1)
end

function var_0_1.GetSelectedCharacterId(arg_9_0)
	local var_9_0 = arg_9_0:GetSelectedId()

	if arg_9_0.contextData.tbSkinId then
		NewEducateHelper = var_2
		var_9_0 = var_2.GetSecIdBySkinId(arg_9_0.contextData.tbSkinId)
	end

	ipairs = var_2

	for iter_9_0, iter_9_1 in var_2(arg_9_0.characterList) do
		if iter_9_1:IsSelected(var_9_0) then
			return iter_9_0
		end
	end

	ipairs = var_2

	for iter_9_2, iter_9_3 in var_2(arg_9_0.characterList) do
		if not iter_9_3:IsLock() then
			return iter_9_2
		end
	end

	return
end

function var_0_1.InitData(arg_10_0)
	NewEducateHelper = var_1_10001
	arg_10_0.characterList = var_1_10001.GetEducateCharacterList()
	arg_10_0.selectedCharacterId = arg_10_0:GetSelectedCharacterId()
	arg_10_0.selectedId = arg_10_0:GetSelectedId()

	return
end

function var_0_1.CheckChangeFormShop(arg_11_0)
	if not arg_11_0.contextData.tbSkinId then
		return
	end

	NewEducateHelper = var_1

	local var_11_0 = var_1.GetSecIdBySkinId(arg_11_0.contextData.tbSkinId)
	local var_11_1 = arg_11_0.characterList[arg_11_0.selectedCharacterId].id

	pg = var_3

	local var_11_2 = var_3.secretary_special_ship[var_11_0].group

	ipairs = var_1_10004

	for iter_11_0, iter_11_1 in var_1_10004(arg_11_0.characterList) do
		if iter_11_1.id == var_11_1 then
			local var_11_3 = iter_11_1:GetGroupById(var_11_2)
			local var_11_4 = arg_11_0
			local var_11_5 = arg_11_0.emit

			EducateCharDockScene = var_1_10013

			var_11_5(var_11_4, var_1_10013.ON_SELECT, var_11_3, arg_11_0.selectedId)

			return
		end
	end

	return
end

function var_0_1.InitTabs(arg_12_0)
	local var_12_0 = arg_12_0.tabItemList

	var_1.make(var_12_0, function(arg_13_0, arg_13_1, arg_13_2)
		local var_13_0 = arg_13_1 + 1
		local var_13_1 = arg_12_0.characterList[var_13_0]

		UIItemList = var_2_10005

		if arg_13_0 == var_2_10005.EventUpdate then
			setActive = var_5

			var_5(arg_13_2:Find("lock"), var_13_1:IsLock())

			setActive = var_5

			var_5(arg_13_2:Find("border/selected"), var_13_0 == arg_12_0.selectedCharacterId)

			setActive = var_5

			var_5(arg_13_2:Find("border/normal"), var_13_0 ~= arg_12_0.selectedCharacterId)

			setActive = var_5

			var_5(arg_13_2:Find("tip"), var_13_1:ShouldTip())
		else
			UIItemList = var_5

			if arg_13_0 == var_5.EventInit then
				GetImageSpriteFromAtlasAsync = var_5

				var_5("qicon/" .. var_13_1:GetDefaultFrame(), "", arg_13_2:Find("frame"))

				onButton = var_5

				var_5(arg_12_0, arg_13_2, function()
					local var_14_0 = var_13_1

					if var_0.IsLock(var_14_0) then
						pg = var_0

						local var_14_1 = var_0.TipsMgr.GetInstance()
						local var_14_2 = var_0.ShowTips

						i18n = var_3_10003

						var_14_2(var_14_1, var_3_10003("secretary_special_character_unlock"))

						return
					end

					if var_13_0 ~= arg_12_0.selectedCharacterId then
						arg_12_0.selectedCharacterId = var_13_0

						local var_14_3 = arg_12_0.tabItemList

						var_0.align(var_14_3, #arg_12_0.characterList)

						local var_14_4 = arg_12_0

						var_0.InitList(var_14_4)
					end

					return
				end)
			end
		end

		return
	end)

	local var_12_1 = arg_12_0.tabItemList

	var_1.align(var_12_1, #arg_12_0.characterList)

	return
end

function var_0_1.InitList(arg_15_0)
	arg_15_0.cards = {}

	local var_15_0 = arg_15_0.characterList[arg_15_0.selectedCharacterId]
	local var_15_1 = var_1.GetGroupList(var_15_0)

	table = var_2

	var_2.sort(var_15_1, function(arg_16_0, arg_16_1)
		return arg_16_0:GetSortWeight() < arg_16_1:GetSortWeight()
	end)
	arg_15_0:RemoveAllTimer()

	local var_15_2 = arg_15_0.uiItemList

	var_2.make(var_15_2, function(arg_17_0, arg_17_1, arg_17_2)
		UIItemList = var_2_10003

		if arg_17_0 == var_2_10003.EventUpdate then
			local var_17_0 = var_15_1[arg_17_1 + 1]
			local var_17_1 = arg_15_0

			var_4.InitCard(var_17_1, arg_17_2, var_17_0, arg_17_1)

			local var_17_2 = arg_15_0

			var_4.UpdateCard(var_17_2, arg_17_2, var_17_0)

			arg_15_0.cards[arg_17_2] = var_17_0
		end

		return
	end)

	local var_15_3 = arg_15_0.uiItemList

	var_2.align(var_15_3, #var_15_1)

	return
end

function var_0_1.FlushList(arg_18_0, arg_18_1)
	arg_18_0.selectedId = arg_18_1

	arg_18_0:InitList()

	local var_18_0 = arg_18_0.tabItemList

	var_2.align(var_18_0, #arg_18_0.characterList)

	return
end

function var_0_1.InitCard(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = arg_19_1
	local var_19_1 = arg_19_1.Find(var_19_0, "anim_root")
	local var_19_2 = arg_19_2
	local var_19_3 = arg_19_2.IsSp(var_19_2)

	setActive = var_19_0

	var_19_0(var_19_1:Find("bg"), not var_19_3)

	setActive = var_19_0

	var_19_0(var_19_1:Find("sp_bg"), var_19_3)

	setActive = var_19_0

	var_19_0(var_19_1:Find("mask"), not var_19_3)

	setActive = var_19_0

	var_19_0(var_19_1:Find("sp_mask"), var_19_3)

	setActive = var_19_0

	var_19_0(var_19_1:Find("sp"), var_19_3)

	setActive = var_19_0

	var_19_0(var_19_1:Find("label"), not var_19_3)

	setActive = var_19_0

	var_19_0(var_19_1:Find("sp_label"), var_19_3)

	local var_19_4 = arg_19_2
	local var_19_5 = arg_19_2.GetShowPainting(var_19_4)

	if var_19_3 then
		setPaintingPrefabAsync = var_19_2

		var_19_2(var_19_1:Find("sp_mask/painting"), var_19_5, "tb2")
	else
		local var_19_6 = var_19_1:Find("label/Text")

		var_19_2 = var_19_2.GetComponent
		typeof = var_10
		Image = var_1_10012
		var_19_2 = var_19_2(var_19_6, var_10(var_1_10012))
		GetSpriteFromAtlas = var_19_4
		var_19_2.sprite = var_19_4("ui/EducateDockUI_atlas", arg_19_2:GetSpriteName())

		var_19_2:SetNativeSize()

		setPaintingPrefabAsync = var_19_4
		var_1_10012 = var_19_1

		var_19_4(var_19_1.Find(var_1_10012, "mask/painting"), var_19_5, "tb2")
	end

	onButton = var_19_2

	local var_19_7 = arg_19_0
	local var_19_8 = var_19_1

	local function var_19_9()
		if arg_19_0.doAnim then
			return
		end

		local var_20_0 = arg_19_2

		if var_0.IsLock(var_20_0) then
			pg = var_0

			local var_20_1

			if var_0.secretary_special_ship[arg_19_2.id].unlock_type == 4 then
				var_20_1 = var_0.unlock[1]
				pg = var_20_0

				if var_20_0.ship_skin_template[var_20_1].shop_id ~= 0 then
					Goods = var_2_10003
					var_2_10003 = var_2_10003.Create

					local var_20_2 = {
						shop_id = var_2
					}

					Goods = var_2_10006
					var_2_10006 = var_2_10003(var_20_2, var_2_10006.TYPE_SKIN)

					if var_2_10003.inTime(var_2_10006) then
						var_2_10004 = {}
						PLATFORM_CODE = var_20_2
						PLATFORM_JP = var_2_10006

						if var_20_2 ~= var_2_10006 then
							table = var_20_2

							var_20_2.insert(var_2_10004, function(arg_21_0)
								pg = var_3_10001

								local var_21_0 = var_3_10001.MsgboxMgr.GetInstance()
								local var_21_1 = var_1.ShowMsgBox
								local var_21_2 = {}

								i18n = var_3_10005
								var_21_2.content = var_3_10005("child2_secretary_skin_confirm")
								var_21_2.onYes = arg_21_0

								var_21_1(var_21_0, var_21_2)

								return
							end)
						end

						seriesAsync = var_20_2

						var_20_2(var_2_10004, function()
							local var_22_0 = arg_19_0
							local var_22_1 = var_0.emit

							EducateCharDockMediator = var_3_10003

							var_22_1(var_22_0, var_3_10003.ON_SKIN_SHOP, var_20_1)

							return
						end)

						return
					end
				end

				pg = var_2_10003

				local var_20_3 = var_2_10003.TipsMgr.GetInstance()
				local var_20_4 = var_3.ShowTips

				i18n = var_2_10006

				var_20_4(var_20_3, var_2_10006("child2_secretary_skin_expire"))

				return
			end

			pg = var_20_1

			local var_20_5 = var_20_1.TipsMgr.GetInstance()
			local var_20_6 = var_1.ShowTips

			i18n = var_2_10004

			var_20_6(var_20_5, var_2_10004("secretary_special_lock_tip"))

			return
		end

		arg_19_0.doAnim = true

		local var_20_7 = arg_19_0.dftAniEvent

		var_0.SetEndEvent(var_20_7, function(arg_23_0)
			arg_19_0.doAnim = nil

			local var_23_0 = arg_19_0.dftAniEvent

			var_1.SetEndEvent(var_23_0, nil)

			local var_23_1 = arg_19_0
			local var_23_2 = var_1.emit

			EducateCharDockScene = var_4

			var_23_2(var_23_1, var_4.ON_SELECT, arg_19_2, arg_19_0.selectedId)

			return
		end)

		local var_20_8 = arg_19_0.animation

		var_0.Play(var_20_8, "anim_educate_chardock_grouppage_out")

		return
	end

	SFX_PANEL = var_1_10012

	var_19_2(var_19_7, var_19_8, var_19_9, var_1_10012)

	setActive = var_19_2

	var_19_2(var_19_1, false)

	local var_19_10 = arg_19_0.timers

	Timer = var_19_4

	local var_19_11 = var_19_4.New

	local function var_19_12()
		setActive = var_2_10000

		var_2_10000(var_19_1, true)

		local var_24_0 = var_19_1
		local var_24_1 = var_0.GetComponent

		typeof = var_3
		Animation = var_2_10005

		local var_24_2 = var_24_1(var_24_0, var_3(var_2_10005))

		var_0.Play(var_24_2, "anim_educate_chardock_tpl")

		return
	end

	math = var_19_9
	var_19_10[arg_19_3] = var_19_11(var_19_12, var_19_9.max(1e-05, arg_19_3 * 0.066), 1)

	local var_19_13 = arg_19_0.timers[arg_19_3]

	var_7.Start(var_19_13)

	return
end

function var_0_1.UpdateCard(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = arg_25_1:Find("anim_root")

	setActive = var_1_10004

	var_1_10004(var_25_0:Find("lock"), arg_25_2:IsLock())

	setActive = var_1_10004

	var_1_10004(var_25_0:Find("mark"), arg_25_2:IsSelected(arg_25_0.selectedId))

	setScrollText = var_1_10004

	var_1_10004(var_25_0:Find("lock/desc/Text"), arg_25_2:GetUnlockDesc())

	setActive = var_1_10004

	var_1_10004(var_25_0:Find("tip"), arg_25_2:ShouldTip())

	return
end

function var_0_1.RemoveAllTimer(arg_26_0)
	pairs = var_1_10001

	for iter_26_0, iter_26_1 in var_1_10001(arg_26_0.timers) do
		iter_26_1:Stop()

		iter_26_1 = nil
	end

	arg_26_0.timers = {}

	return
end

function var_0_1.Destroy(arg_27_0)
	pairs = var_1_10001

	local var_27_0

	if not arg_27_0.cards then
		var_27_0 = {}
	end

	for iter_27_0, iter_27_1 in var_1_10001(var_27_0) do
		local var_27_1 = iter_27_1

		if iter_27_1.IsSp(var_27_1) then
			var_27_1 = iter_27_0

			local var_27_2

			if not iter_27_0.Find(var_27_1, "sp_mask/painting") then
				var_27_1 = iter_27_0
				var_27_2 = iter_27_0.Find(var_27_1, "mask/painting")
			end

			local var_27_3 = iter_27_1:GetShowPainting()

			retPaintingPrefab = var_27_1

			var_27_1(var_27_2, var_27_3)
		end
	end

	pg = var_1

	var_1.DelegateInfo.Dispose(arg_27_0)

	local var_27_4 = arg_27_0.dftAniEvent

	var_1.SetEndEvent(var_27_4, nil)
	arg_27_0:RemoveAllTimer()

	return
end

return var_0_1
