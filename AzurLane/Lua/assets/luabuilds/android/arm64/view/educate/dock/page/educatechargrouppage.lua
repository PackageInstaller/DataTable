local var_0_0 = class("EducateCharGroupPage", import("view.base.BaseEventLogic"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	pg.DelegateInfo.New(arg_1_0)
	var_0_0.super.Ctor(arg_1_0, arg_1_2)

	arg_1_0.contextData = arg_1_3
	arg_1_0.tf = arg_1_1
	arg_1_0.go = arg_1_1.gameObject
	arg_1_0.confirmBtn = findTF(arg_1_1, "confirm_btn")
	arg_1_0.cancelBtn = findTF(arg_1_1, "cancel_btn")
	arg_1_0.uiItemList = UIItemList.New(findTF(arg_1_1, "main/list"), findTF(arg_1_1, "main/list/tpl"))
	arg_1_0.tabItemList = UIItemList.New(findTF(arg_1_1, "tab/list"), findTF(arg_1_1, "tab/list/tpl"))
	arg_1_0.profileBtn = findTF(arg_1_1, "right/icon")
	arg_1_0.animation = arg_1_1:GetComponent(typeof(Animation))
	arg_1_0.dftAniEvent = arg_1_1:GetComponent(typeof(DftAniEvent))
	arg_1_0.timers = {}

	arg_1_0:RegisterEvent()

	return
end

function var_0_0.RegisterEvent(arg_2_0)
	onButton(arg_2_0, arg_2_0.profileBtn, function()
		arg_2_0:emit(EducateCharDockMediator.GO_PROFILE, arg_2_0.selectedCharacterId)

		return
	end, SFX_PANEL)
	arg_2_0:bind(EducateCharDockScene.MSG_CLEAR_TIP, function(arg_4_0, arg_4_1)
		arg_2_0:FlushList(arg_2_0.selectedId)

		return
	end)

	return
end

function var_0_0.Update(arg_5_0)
	arg_5_0:InitData()
	arg_5_0:InitTabs()
	arg_5_0:InitList()
	arg_5_0:CheckChangeFormShop()

	return
end

function var_0_0.Show(arg_6_0)
	setActive(arg_6_0.tf, true)

	return
end

function var_0_0.Hide(arg_7_0)
	setActive(arg_7_0.tf, false)
	arg_7_0:RemoveAllTimer()

	return
end

function var_0_0.GetSelectedId(arg_8_0)
	return getProxy(PlayerProxy):getRawData():GetEducateCharacter()
end

function var_0_0.GetSelectedCharacterId(arg_9_0)
	local var_9_0 = arg_9_0:GetSelectedId()

	if arg_9_0.contextData.tbSkinId then
		var_9_0 = NewEducateHelper.GetSecIdBySkinId(arg_9_0.contextData.tbSkinId)
	end

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.characterList) do
		if iter_9_1:IsSelected(var_9_0) then
			return iter_9_0
		end
	end

	for iter_9_2, iter_9_3 in ipairs(arg_9_0.characterList) do
		if not iter_9_3:IsLock() then
			return iter_9_2
		end
	end

	return
end

function var_0_0.InitData(arg_10_0)
	arg_10_0.characterList = NewEducateHelper.GetEducateCharacterList()
	arg_10_0.selectedCharacterId = arg_10_0:GetSelectedCharacterId()
	arg_10_0.selectedId = arg_10_0:GetSelectedId()

	return
end

function var_0_0.CheckChangeFormShop(arg_11_0)
	if not arg_11_0.contextData.tbSkinId then
		return
	end

	local var_11_0 = pg.secretary_special_ship[NewEducateHelper.GetSecIdBySkinId(arg_11_0.contextData.tbSkinId)].group

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.characterList) do
		if iter_11_1.id == arg_11_0.characterList[arg_11_0.selectedCharacterId].id then
			arg_11_0:emit(EducateCharDockScene.ON_SELECT, iter_11_1:GetGroupById(var_11_0), arg_11_0.selectedId)

			return
		end
	end

	return
end

function var_0_0.InitTabs(arg_12_0)
	arg_12_0.tabItemList:make(function(arg_13_0, arg_13_1, arg_13_2)
		local var_13_0 = arg_13_1 + 1
		local var_13_1 = arg_12_0.characterList[arg_13_1 + 1]

		if arg_13_0 == UIItemList.EventUpdate then
			setActive(arg_13_2:Find("lock"), var_13_1:IsLock())
			setActive(arg_13_2:Find("border/selected"), arg_13_1 + 1 == arg_12_0.selectedCharacterId)
			setActive(arg_13_2:Find("border/normal"), arg_13_1 + 1 ~= arg_12_0.selectedCharacterId)
			setActive(arg_13_2:Find("tip"), var_13_1:ShouldTip())
		elseif arg_13_0 == UIItemList.EventInit then
			GetImageSpriteFromAtlasAsync("qicon/" .. var_13_1:GetDefaultFrame(), "", arg_13_2:Find("frame"))
			onButton(arg_12_0, arg_13_2, function()
				if var_13_1:IsLock() then
					pg.TipsMgr.GetInstance():ShowTips(i18n("secretary_special_character_unlock"))

					return
				end

				if var_13_0 ~= arg_12_0.selectedCharacterId then
					arg_12_0.selectedCharacterId = var_13_0

					arg_12_0.tabItemList:align(#arg_12_0.characterList)
					arg_12_0:InitList()
				end

				return
			end)
		end

		return
	end)
	arg_12_0.tabItemList:align(#arg_12_0.characterList)

	return
end

function var_0_0.InitList(arg_15_0)
	arg_15_0.cards = {}

	local var_15_0 = arg_15_0.characterList[arg_15_0.selectedCharacterId]:GetGroupList()

	table.sort(var_15_0, function(arg_16_0, arg_16_1)
		return arg_16_0:GetSortWeight() < arg_16_1:GetSortWeight()
	end)
	arg_15_0:RemoveAllTimer()
	arg_15_0.uiItemList:make(function(arg_17_0, arg_17_1, arg_17_2)
		if arg_17_0 == UIItemList.EventUpdate then
			arg_15_0:InitCard(arg_17_2, var_15_0[arg_17_1 + 1], arg_17_1)
			arg_15_0:UpdateCard(arg_17_2, var_15_0[arg_17_1 + 1])

			arg_15_0.cards[arg_17_2] = var_15_0[arg_17_1 + 1]
		end

		return
	end)
	arg_15_0.uiItemList:align(#var_15_0)

	return
end

function var_0_0.FlushList(arg_18_0, arg_18_1)
	arg_18_0.selectedId = arg_18_1

	arg_18_0:InitList()
	arg_18_0.tabItemList:align(#arg_18_0.characterList)

	return
end

function var_0_0.InitCard(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = arg_19_1:Find("anim_root")
	local var_19_1 = arg_19_2:IsSp()

	setActive(var_19_0:Find("bg"), not var_19_1)
	setActive(var_19_0:Find("sp_bg"), var_19_1)
	setActive(var_19_0:Find("mask"), not var_19_1)
	setActive(var_19_0:Find("sp_mask"), var_19_1)
	setActive(var_19_0:Find("sp"), var_19_1)
	setActive(var_19_0:Find("label"), not var_19_1)
	setActive(var_19_0:Find("sp_label"), var_19_1)

	local var_19_2 = arg_19_2:GetShowPainting()

	if var_19_1 then
		setPaintingPrefabAsync(var_19_0:Find("sp_mask/painting"), var_19_2, "tb2")
	else
		local var_19_3 = var_19_0:Find("label/Text"):GetComponent(typeof(Image))

		var_19_3.sprite = GetSpriteFromAtlas("ui/EducateDockUI_atlas", arg_19_2:GetSpriteName())

		var_19_3:SetNativeSize()
		setPaintingPrefabAsync(var_19_0:Find("mask/painting"), var_19_2, "tb2")
	end

	onButton(arg_19_0, var_19_0, function()
		if arg_19_0.doAnim then
			return
		end

		if arg_19_2:IsLock() then
			if pg.secretary_special_ship[arg_19_2.id].unlock_type == 4 then
				if pg.ship_skin_template[pg.secretary_special_ship[arg_19_2.id].unlock[1]].shop_id ~= 0 then
					if Goods.Create({
						shop_id = pg.ship_skin_template[pg.secretary_special_ship[arg_19_2.id].unlock[1]].shop_id
					}, Goods.TYPE_SKIN):inTime() then
						if PLATFORM_CODE ~= PLATFORM_JP then
							table.insert({}, function(arg_21_0)
								pg.MsgboxMgr.GetInstance():ShowMsgBox({
									content = i18n("child2_secretary_skin_confirm"),
									onYes = arg_21_0
								})

								return
							end)
						end

						seriesAsync({}, function()
							arg_19_0:emit(EducateCharDockMediator.ON_SKIN_SHOP, var_0)

							return
						end)

						return
					end
				end

				pg.TipsMgr.GetInstance():ShowTips(i18n("child2_secretary_skin_expire"))

				return
			end

			pg.TipsMgr.GetInstance():ShowTips(i18n("secretary_special_lock_tip"))

			return
		end

		arg_19_0.doAnim = true

		arg_19_0.dftAniEvent:SetEndEvent(function(arg_23_0)
			arg_19_0.doAnim = nil

			arg_19_0.dftAniEvent:SetEndEvent(nil)
			arg_19_0:emit(EducateCharDockScene.ON_SELECT, arg_19_2, arg_19_0.selectedId)

			return
		end)
		arg_19_0.animation:Play("anim_educate_chardock_grouppage_out")

		return
	end, SFX_PANEL)
	setActive(var_19_0, false)

	arg_19_0.timers[arg_19_3] = Timer.New(function()
		setActive(var_19_0, true)
		var_19_0:GetComponent(typeof(Animation)):Play("anim_educate_chardock_tpl")

		return
	end, math.max(1e-05, arg_19_3 * 0.066), 1)

	arg_19_0.timers[arg_19_3]:Start()

	return
end

function var_0_0.UpdateCard(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = arg_25_1:Find("anim_root")

	setActive(var_25_0:Find("lock"), arg_25_2:IsLock())
	setActive(var_25_0:Find("mark"), arg_25_2:IsSelected(arg_25_0.selectedId))
	setScrollText(var_25_0:Find("lock/desc/Text"), arg_25_2:GetUnlockDesc())
	setActive(var_25_0:Find("tip"), arg_25_2:ShouldTip())

	return
end

function var_0_0.RemoveAllTimer(arg_26_0)
	for iter_26_0, iter_26_1 in pairs(arg_26_0.timers) do
		iter_26_1:Stop()

		iter_26_1 = nil
	end

	arg_26_0.timers = {}

	return
end

function var_0_0.Destroy(arg_27_0)
	local var_27_0 = arg_27_0.cards or {}

	for iter_27_0, iter_27_1 in pairs(var_27_0) do
		local var_27_1 = iter_27_1:IsSp() and iter_27_0:Find("sp_mask/painting") or iter_27_0:Find("mask/painting")

		retPaintingPrefab(var_27_1, (iter_27_1:GetShowPainting()))
	end

	pg.DelegateInfo.Dispose(arg_27_0)
	arg_27_0.dftAniEvent:SetEndEvent(nil)
	arg_27_0:RemoveAllTimer()

	return
end

return var_0_0
