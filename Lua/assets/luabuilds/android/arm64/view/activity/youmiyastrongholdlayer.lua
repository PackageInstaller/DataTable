local var_0_0 = class("YoumiyaStrongholdLayer", import("view.base.BaseUI"))
local var_0_1 = pg.activity_ryza_furniture
local var_0_2 = pg.furniture_data_template

function var_0_0.getUIName(arg_1_0)
	return "YoumiyaStrongholdUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.adapt = arg_2_0._tf:Find("adapt")
	arg_2_0.backBtn = arg_2_0.adapt:Find("backBtn")
	arg_2_0.homeBtn = arg_2_0.adapt:Find("homeBtn")
	arg_2_0.desc = arg_2_0.adapt:Find("desc/text")
	arg_2_0.res = arg_2_0.adapt:Find("res")
	arg_2_0.strongholdPage = arg_2_0._tf:Find("pages/strongholdPage")
	arg_2_0.detailPage = arg_2_0._tf:Find("pages/detailPage")
	arg_2_0.makeFurniturePanel = arg_2_0._tf:Find("pages/makeFurniturePanel")
	arg_2_0.awardList = UIItemList.New(arg_2_0.detailPage:Find("detail/awardList"), arg_2_0.detailPage:Find("detail/awardList/stage"))
	arg_2_0.isOnMake = false

	setText(arg_2_0.desc, i18n("yumia_stronghold_2"))

	for iter_2_0 = 1, 3 do
		setText(arg_2_0.strongholdPage:Find(iter_2_0 .. "/comfort/text"), i18n("yumia_stronghold_3"))

		local var_2_0 = arg_2_0.detailPage:Find("detail/stronghold/furnitures/" .. iter_2_0)

		for iter_2_1 = 1, var_2_0.childCount do
			local var_2_1 = var_2_0:Find(iter_2_1)

			for iter_2_2 = 0, var_2_1.childCount - 1 do
				local var_2_2 = var_2_1:GetChild(iter_2_2)

				setText(var_2_2:Find("comfort/comf/text"), i18n("yumia_stronghold_3"))
			end
		end

		setText(arg_2_0.detailPage:Find("info/" .. iter_2_0 .. "/comfort/text"), i18n("yumia_stronghold_3"))
	end

	setText(arg_2_0.detailPage:Find("detail/progress/Root/text"), i18n("yumia_stronghold_4"))
	setText(arg_2_0.detailPage:Find("detail/awardTitle/text"), i18n("yumia_stronghold_5"))
	setText(arg_2_0.detailPage:Find("detail/awardList/stage/got/text"), i18n("yumia_stronghold_6"))
	setText(arg_2_0.makeFurniturePanel:Find("panel/complete/root/text"), i18n("yumia_stronghold_7"))
	setText(arg_2_0.makeFurniturePanel:Find("panel/comfort/title"), i18n("yumia_stronghold_3"))
	setText(arg_2_0.makeFurniturePanel:Find("panel/consume/title"), i18n("yumia_stronghold_8"))
	setText(arg_2_0.makeFurniturePanel:Find("panel/consume/text"), i18n("yumia_stronghold_9"))
	setText(arg_2_0.makeFurniturePanel:Find("panel/makeBtn/text"), i18n("yumia_stronghold_10"))

	arg_2_0.camEventId = pg.CameraFixMgr.GetInstance():bind(pg.CameraFixMgr.ASPECT_RATIO_UPDATE, function(arg_3_0, arg_3_1)
		arg_2_0:UpdateAdapt()

		return
	end)

	if arg_2_0._tf.rect.height > 1440 then
		arg_2_0.adapt:GetComponent(typeof(RectTransform)).sizeDelta = Vector2(0, 1440 - arg_2_0._tf.rect.height)
		arg_2_0.makeFurniturePanel:GetComponent(typeof(RectTransform)).sizeDelta = Vector2(0, 1440 - arg_2_0._tf.rect.height)
	end

	pg.UIMgr.GetInstance():BlurPanel(arg_2_0._tf, false)
	arg_2_0._tf:GetComponent(typeof(DftAniEvent)):SetTriggerEvent(function()
		for iter_4_0 = 0, 2 do
			arg_2_0.strongholdPage:GetChild(iter_4_0):GetComponent(typeof(Animation)):Play("Anim_YoumiyaStrongholdUI_Strongholdpage01_In")
		end

		return
	end)

	local var_2_3 = arg_2_0.detailPage:GetComponent(typeof(DftAniEvent))

	var_2_3:SetTriggerEvent(function()
		for iter_5_0 = 0, 2 do
			local var_5_0 = arg_2_0.detailPage:Find("info"):GetChild(iter_5_0)
			local var_5_1 = var_5_0:GetComponent(typeof(Animation))

			if isActive(var_5_0) then
				var_5_1:Play("Anim_YoumiyaStrongholdUI_Strongholdpage01_In")
			end
		end

		return
	end)
	var_2_3:SetEndEvent(function()
		for iter_6_0 = 1, 3 do
			local var_6_0 = arg_2_0.detailPage:Find("detail/stronghold/furnitures/" .. iter_6_0)

			for iter_6_1 = 1, var_6_0.childCount do
				local var_6_1 = var_6_0:Find(iter_6_1)

				for iter_6_2 = 0, var_6_1.childCount - 1 do
					local var_6_2 = var_6_1:GetChild(iter_6_2)

					setActive(var_6_2:Find("comfort/icon/VX"), true)
				end
			end
		end

		return
	end)

	return
end

function var_0_0.didEnter(arg_7_0)
	arg_7_0:InitData()
	arg_7_0:UpdateAdapt()
	onButton(arg_7_0, arg_7_0.backBtn, function()
		arg_7_0:GoBack()

		return
	end, SFX_CANCEL)
	onButton(arg_7_0, arg_7_0.homeBtn, function()
		arg_7_0:emit(var_0_0.ON_HOME)

		return
	end, SFX_CANCEL)
	setActive(arg_7_0.strongholdPage, true)
	setActive(arg_7_0.detailPage, false)
	setActive(arg_7_0.makeFurniturePanel, false)
	arg_7_0:RefreshView()

	return
end

function var_0_0.UpdateAdapt(arg_10_0)
	local var_10_0 = pg.CameraFixMgr.GetInstance()

	arg_10_0._tf:GetComponent(typeof(AspectRatioFitter)).aspectRatio = math.clamp(var_10_0.currentWidth / var_10_0.currentHeight, 1.3333333333333333, 2.1666666666666665)

	setSizeDelta(arg_10_0._tf:Find("adapt"), {
		x = 0,
		y = 0
	})

	return
end

function var_0_0.InitData(arg_11_0)
	arg_11_0.activityProxy = getProxy(ActivityProxy)
	arg_11_0.allFurnitureCount = {
		0,
		0,
		0
	}
	arg_11_0.allComfortCount = {
		0,
		0,
		0
	}

	for iter_11_0 = 1, 3 do
		arg_11_0.allFurnitureCount[iter_11_0] = #var_0_1.get_id_list_by_type[iter_11_0]

		for iter_11_1, iter_11_2 in ipairs(var_0_1.get_id_list_by_type[iter_11_0]) do
			arg_11_0.allComfortCount[iter_11_0] = arg_11_0.allComfortCount[iter_11_0] + var_0_1[iter_11_2].com_add
		end
	end

	arg_11_0.awardInfos = pg.activity_template[ActivityConst.YUMIA_BASE_ACT_ID].config_client.rewards

	return
end

function var_0_0.RefreshData(arg_12_0)
	arg_12_0.items = arg_12_0.activityProxy:getActivityByType(ActivityConst.ACTIVITY_TYPE_ATELIER_LINK):GetItems()
	arg_12_0.activity = arg_12_0.activityProxy:getActivityById(ActivityConst.YUMIA_BASE_ACT_ID)
	arg_12_0.okFurnitureIds = arg_12_0.activity:getData1List()
	arg_12_0.gotAwardIndex = {
		0,
		0,
		0
	}

	for iter_12_0 = 1, 3 do
		arg_12_0.gotAwardIndex[iter_12_0] = arg_12_0.activity:getKVPList(1, iter_12_0)
	end

	arg_12_0.furnitureCount = {
		0,
		0,
		0
	}
	arg_12_0.comfortCount = {
		0,
		0,
		0
	}

	for iter_12_1 = 1, 3 do
		for iter_12_2, iter_12_3 in ipairs(var_0_1.get_id_list_by_type[iter_12_1]) do
			if table.contains(arg_12_0.okFurnitureIds, iter_12_3) then
				arg_12_0.furnitureCount[iter_12_1] = arg_12_0.furnitureCount[iter_12_1] + 1
				arg_12_0.comfortCount[iter_12_1] = arg_12_0.comfortCount[iter_12_1] + var_0_1[iter_12_3].com_add
			end
		end
	end

	return
end

function var_0_0.SetRes(arg_13_0, arg_13_1)
	local var_13_0 = getProxy(PlayerProxy):getRawData()

	for iter_13_0 = 0, arg_13_1.childCount - 1 do
		setActive(arg_13_1:GetChild(iter_13_0), false)
	end

	for iter_13_1, iter_13_2 in ipairs({
		{
			138,
			arg_13_0:GetItemCount(138)
		},
		{
			139,
			arg_13_0:GetItemCount(139)
		},
		{
			140,
			arg_13_0:GetItemCount(140)
		},
		{
			141,
			arg_13_0:GetItemCount(141)
		},
		{
			6,
			arg_13_0:GetItemCount(6)
		}
	}) do
		for iter_13_3 = 0, arg_13_1.childCount - 1 do
			local var_13_1 = arg_13_1:GetChild(iter_13_3)

			if var_13_1.name == tostring(iter_13_2[1]) then
				setActive(var_13_1, true)
				setText(var_13_1:Find("Text"), iter_13_2[2])

				break
			end
		end
	end

	return
end

function var_0_0.RefreshView(arg_14_0)
	arg_14_0:RefreshData()
	arg_14_0:SetRes(arg_14_0.res)
	arg_14_0:SetDetailPage()

	for iter_14_0 = 1, 3 do
		local var_14_0 = arg_14_0.strongholdPage:GetChild(iter_14_0 - 1)

		setText(var_14_0:Find("root/name"), i18n("yumia_base_name_" .. iter_14_0))
		setText(var_14_0:Find("comfort/count2/count1"), arg_14_0.comfortCount[iter_14_0])
		setText(var_14_0:Find("comfort/count2"), "/" .. arg_14_0.allComfortCount[iter_14_0])
		GetImageSpriteFromAtlasAsync("ui/CourtyardUI_atlas", "express_" .. arg_14_0:GetComfortableLevel(arg_14_0.comfortCount[iter_14_0]), var_14_0:Find("comfort/icon"))
		onButton(arg_14_0, var_14_0, function()
			arg_14_0:EnterDetailPage(iter_14_0)

			return
		end, SFX_PANEL)

		local var_14_1 = false

		for iter_14_1 = 1, #arg_14_0.awardInfos[iter_14_0] do
			if arg_14_0.awardInfos[iter_14_0][iter_14_1][1] <= arg_14_0.comfortCount[iter_14_0] and iter_14_1 > arg_14_0.gotAwardIndex[iter_14_0] then
				var_14_1 = true

				break
			end
		end

		setActive(var_14_0:Find("tip"), var_14_1)
	end

	if arg_14_0.strongholdIndex then
		arg_14_0:EnterDetailPage(arg_14_0.strongholdIndex)
	end

	return
end

function var_0_0.SetDetailPage(arg_16_0)
	for iter_16_0 = 1, 3 do
		setText(arg_16_0.detailPage:Find("info/" .. iter_16_0 .. "/root/name"), i18n("yumia_base_name_" .. iter_16_0))
		setText(arg_16_0.detailPage:Find("info/" .. iter_16_0 .. "/comfort/count2/count1"), arg_16_0.comfortCount[iter_16_0])
		setText(arg_16_0.detailPage:Find("info/" .. iter_16_0 .. "/comfort/count2"), "/" .. arg_16_0.allComfortCount[iter_16_0])
		GetImageSpriteFromAtlasAsync("ui/CourtyardUI_atlas", "express_" .. arg_16_0:GetComfortableLevel(arg_16_0.comfortCount[iter_16_0]), arg_16_0.detailPage:Find("info/" .. iter_16_0 .. "/comfort/icon"))

		local var_16_0 = arg_16_0.detailPage:Find("detail/stronghold/furnitures/" .. iter_16_0)

		for iter_16_1 = 0, var_16_0.childCount - 1 do
			local var_16_1 = var_16_0:GetChild(iter_16_1)
			local var_16_2 = true

			for iter_16_2 = 0, var_16_1.childCount - 1 do
				local var_16_3 = var_16_1:GetChild(iter_16_2)
				local var_16_4 = tonumber(var_16_3.name)
				local var_16_5 = table.contains(arg_16_0.okFurnitureIds, var_16_4)

				setActive(var_16_3:Find("fur"), var_16_5)
				setActive(var_16_3:Find("lockFur"), not var_16_5)
				setActive(var_16_3:Find("comfort"), not var_16_5)
				setText(var_16_3:Find("comfort/comf/count"), var_0_1[var_16_4].com_add)

				if not var_16_5 then
					var_16_2 = false

					onButton(arg_16_0, var_16_3, function()
						arg_16_0:ShowMakePanel(var_16_4)

						return
					end, SFX_PANEL)
				else
					removeOnButton(var_16_3)
				end
			end

			setActive(var_16_1, not false)

			local var_16_6

			if not false and not var_16_2 then
				var_16_6 = true
			end
		end
	end

	onButton(arg_16_0, arg_16_0.detailPage:Find("leftChange"), function()
		arg_16_0:EnterDetailPage(arg_16_0.strongholdIndex - 1 == 0 and 3 or arg_16_0.strongholdIndex - 1)

		return
	end, SFX_PANEL)
	onButton(arg_16_0, arg_16_0.detailPage:Find("rightChange"), function()
		arg_16_0:EnterDetailPage(arg_16_0.strongholdIndex + 1 == 4 and 1 or arg_16_0.strongholdIndex + 1)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.EnterDetailPage(arg_20_0, arg_20_1)
	arg_20_0.strongholdIndex = arg_20_1

	setActive(arg_20_0.strongholdPage, false)
	setActive(arg_20_0.detailPage, true)

	for iter_20_0 = 1, 3 do
		setActive(arg_20_0.detailPage:Find("info/" .. iter_20_0), iter_20_0 == arg_20_1)
	end

	setText(arg_20_0.detailPage:Find("detail/progress/countBg/furnitureCount"), arg_20_0.furnitureCount[arg_20_1] .. "/" .. arg_20_0.allFurnitureCount[arg_20_1])

	for iter_20_1 = 1, 3 do
		setActive(arg_20_0.detailPage:Find("detail/stronghold/furnitures/" .. iter_20_1), iter_20_1 == arg_20_1)
	end

	local var_20_0 = false
	local var_20_1 = 0
	local var_20_2 = arg_20_0.awardInfos[arg_20_1]

	arg_20_0.awardList:make(function(arg_21_0, arg_21_1, arg_21_2)
		if arg_21_0 == UIItemList.EventUpdate then
			local var_21_0 = var_20_2[arg_21_1 + 1][1]

			updateDrop(arg_21_2:Find("award"), {
				type = var_20_2[arg_21_1 + 1][2][1],
				id = var_20_2[arg_21_1 + 1][2][2],
				count = var_20_2[arg_21_1 + 1][2][3]
			})
			onButton(arg_20_0, arg_21_2:Find("award"), function()
				arg_20_0:emit(BaseUI.ON_DROP, var_0)

				return
			end, SFX_PANEL)
			setText(arg_21_2:Find("comfort"), var_21_0)
			setActive(arg_21_2:Find("got"), arg_21_1 < arg_20_0.gotAwardIndex[arg_20_1])
			setActive(arg_21_2:Find("canGet"), var_21_0 <= arg_20_0.comfortCount[arg_20_1] and arg_21_1 >= arg_20_0.gotAwardIndex[arg_20_1])

			if var_21_0 <= arg_20_0.comfortCount[arg_20_1] and arg_21_1 >= arg_20_0.gotAwardIndex[arg_20_1] then
				var_20_0 = true
				var_20_1 = arg_21_1 + 1
			end
		end

		return
	end)
	arg_20_0.awardList:align(#arg_20_0.awardInfos[arg_20_1])
	setActive(arg_20_0.detailPage:Find("detail/allGetBtn/VX"), false)

	if false then
		setGray(arg_20_0.detailPage:Find("detail/allGetBtn"), false, false)
		onButton(arg_20_0, arg_20_0.detailPage:Find("detail/allGetBtn"), function()
			arg_20_0:emit(YoumiyaStrongholdMediator.GET_AWARD, arg_20_1, var_20_1)

			return
		end, SFX_PANEL)
	else
		setGray(arg_20_0.detailPage:Find("detail/allGetBtn"), true, false)
		removeOnButton(arg_20_0.detailPage:Find("detail/allGetBtn"))
	end

	if isActive(arg_20_0.makeFurniturePanel) then
		triggerButton(arg_20_0.makeFurniturePanel:Find("panel/closeBtn"))
	end

	return
end

function var_0_0.ShowMakePanel(arg_24_0, arg_24_1)
	setActive(arg_24_0.makeFurniturePanel, true)

	local var_24_0 = var_0_1[arg_24_1]
	local var_24_1 = arg_24_0.makeFurniturePanel:GetComponent(typeof(Animation))
	local var_24_2 = arg_24_0.makeFurniturePanel:GetComponent(typeof(DftAniEvent))

	onButton(arg_24_0, arg_24_0.makeFurniturePanel:Find("panel/closeBtn"), function()
		if arg_24_0.isOnMake then
			return
		end

		var_24_2:SetEndEvent(function()
			setActive(arg_24_0.makeFurniturePanel, false)

			return
		end)
		var_24_1:Play("Anim_YoumiyaStrongholdUI_makeFurniture_Out")

		return
	end, SFX_PANEL)
	onButton(arg_24_0, arg_24_0._tf:Find("bg"), function()
		triggerButton(arg_24_0.makeFurniturePanel:Find("panel/closeBtn"))

		return
	end, SFX_PANEL)
	setText(arg_24_0.makeFurniturePanel:Find("panel/name"), var_0_2[var_0_1[arg_24_1].fur_id].name)

	local var_24_3, var_24_4 = HXSet.autoHxShiftPath("furnitures/" .. var_0_2[var_0_1[arg_24_1].fur_id].picture, "")
	local var_24_5 = arg_24_0.makeFurniturePanel:Find("panel/icon"):GetComponent(typeof(Image))

	GetSpriteFromAtlasAsync(var_24_3, var_24_4, function(arg_28_0)
		var_24_5.sprite = arg_28_0

		var_24_5:SetNativeSize()

		if var_24_5.sprite.rect.height <= var_24_5.sprite.rect.width then
			local var_28_0 = 300 / var_24_5.sprite.rect.width or 300 / var_24_5.sprite.rect.height

			arg_24_0.makeFurniturePanel:Find("panel/icon").localScale = Vector3(var_28_0, var_28_0, 1)

			return
		end
	end)
	setText(arg_24_0.makeFurniturePanel:Find("panel/comfort/count"), var_0_1[arg_24_1].com_add)
	setText(arg_24_0.makeFurniturePanel:Find("panel/desc"), var_0_2[var_0_1[arg_24_1].fur_id].describe)
	setActive(arg_24_0.makeFurniturePanel:Find("panel/complete"), false)
	onButton(arg_24_0, arg_24_0.makeFurniturePanel:Find("panel/consume/goBtn"), function()
		arg_24_0:emit(YoumiyaStrongholdMediator.YOUMIA_GO_SCENE, SCENE.ATELIER_COMPOSITE, {
			activityID = 50043,
			versionIndex = 2
		})

		return
	end, SFX_PANEL)
	arg_24_0:SetConsumeList(var_0_1[arg_24_1].material)

	local var_24_6 = true

	for iter_24_0, iter_24_1 in ipairs(var_0_1[arg_24_1].material) do
		if iter_24_1[3] > arg_24_0:GetItemCount(iter_24_1[2]) then
			var_24_6 = false
		end
	end

	if var_24_6 then
		setGray(arg_24_0.makeFurniturePanel:Find("panel/makeBtn"), false, true)
		onButton(arg_24_0, arg_24_0.makeFurniturePanel:Find("panel/makeBtn"), function()
			arg_24_0.isOnMake = true

			var_24_2:SetTriggerEvent(function()
				arg_24_0:emit(YoumiyaStrongholdMediator.MAKE_FURNITURE, arg_24_1, var_24_0.material)

				arg_24_0.isOnMake = false

				triggerButton(arg_24_0.makeFurniturePanel:Find("panel/closeBtn"))

				return
			end)
			setActive(arg_24_0.makeFurniturePanel:Find("panel/complete"), true)
			arg_24_0.makeFurniturePanel:GetComponent(typeof(Animation)):Play("Anim_YoumiyaStrongholdUI_makeFurniture_Complete")
			removeOnButton(arg_24_0.makeFurniturePanel:Find("panel/makeBtn"))

			return
		end, SFX_PANEL)
	else
		setGray(arg_24_0.makeFurniturePanel:Find("panel/makeBtn"), true, true)
		removeOnButton(arg_24_0.makeFurniturePanel:Find("panel/makeBtn"))
	end

	return
end

function var_0_0.SetConsumeList(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_0.makeFurniturePanel:Find("panel/consume/consumeList")

	for iter_32_0, iter_32_1 in ipairs(arg_32_1) do
		table.insert({}, {
			iter_32_1[2],
			iter_32_1[3]
		})
	end

	for iter_32_2 = 0, var_32_0.childCount - 1 do
		setActive(var_32_0:GetChild(iter_32_2), false)
	end

	for iter_32_3, iter_32_4 in ipairs({}) do
		for iter_32_5 = 0, var_32_0.childCount - 1 do
			local var_32_1 = var_32_0:GetChild(iter_32_5)

			if var_32_1.name == tostring(iter_32_4[1]) then
				setActive(var_32_1, true)
				setText(var_32_1:Find("count1"), arg_32_0:GetItemCount(iter_32_4[1]))
				setText(var_32_1:Find("count2"), "/" .. iter_32_4[2])

				break
			end
		end
	end

	return
end

function var_0_0.GetComfortableLevel(arg_33_0, arg_33_1)
	if arg_33_1 < 30 then
		return 1
	elseif arg_33_1 >= 30 and arg_33_1 < 68 then
		return 2
	else
		return 3
	end

	return
end

function var_0_0.GetItemCount(arg_34_0, arg_34_1)
	local var_34_0 = 0

	if arg_34_1 == 6 then
		var_34_0 = getProxy(PlayerProxy):getRawData():getResource(PlayerConst.ResDormMoney)
	elseif arg_34_0.items[arg_34_1] then
		var_34_0 = arg_34_0.items[arg_34_1].count
	end

	return var_34_0
end

function var_0_0.GoBack(arg_35_0)
	if isActive(arg_35_0.detailPage) then
		setActive(arg_35_0.strongholdPage, true)
		setActive(arg_35_0.detailPage, false)

		arg_35_0.strongholdIndex = nil

		if isActive(arg_35_0.makeFurniturePanel) then
			triggerButton(arg_35_0.makeFurniturePanel:Find("panel/closeBtn"))
		end

		for iter_35_0 = 1, 3 do
			local var_35_0 = arg_35_0.detailPage:Find("detail/stronghold/furnitures/" .. iter_35_0)

			for iter_35_1 = 1, var_35_0.childCount do
				local var_35_1 = var_35_0:Find(iter_35_1)

				for iter_35_2 = 0, var_35_1.childCount - 1 do
					local var_35_2 = var_35_1:GetChild(iter_35_2)

					setActive(var_35_2:Find("comfort/icon/VX"), false)
				end
			end
		end

		return
	end

	arg_35_0:closeView()

	return
end

function var_0_0.willExit(arg_36_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_36_0._tf)

	if arg_36_0.camEventId then
		pg.CameraFixMgr.GetInstance():disconnect(arg_36_0.camEventId)

		arg_36_0.camEventId = nil
	end

	return
end

function var_0_0.onBackPressed(arg_37_0)
	arg_37_0:GoBack()

	return
end

function var_0_0.ShouldShowTip()
	local var_38_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.YUMIA_BASE_ACT_ID)
	local var_38_1 = var_38_0:getData1List()

	for iter_38_0 = 1, 3 do
		({
			0,
			0,
			0
		})[iter_38_0] = var_38_0:getKVPList(1, iter_38_0)
	end

	for iter_38_1 = 1, 3 do
		for iter_38_2, iter_38_3 in ipairs(var_0_1.get_id_list_by_type[iter_38_1]) do
			if table.contains(var_38_1, iter_38_3) then
				({
					0,
					0,
					0
				})[iter_38_1] = ({
					0,
					0,
					0
				})[iter_38_1] + var_0_1[iter_38_3].com_add
			end
		end
	end

	local var_38_2 = false

	for iter_38_4 = 1, 3 do
		local var_38_3 = false

		for iter_38_5 = 1, #pg.activity_template[ActivityConst.YUMIA_BASE_ACT_ID].config_client.rewards[iter_38_4] do
			if pg.activity_template[ActivityConst.YUMIA_BASE_ACT_ID].config_client.rewards[iter_38_4][iter_38_5][1] <= ({
				0,
				0,
				0
			})[iter_38_4] and iter_38_5 > ({
				0,
				0,
				0
			})[iter_38_4] then
				var_38_3 = true

				break
			end
		end

		if var_38_3 then
			var_38_2 = true

			break
		end
	end

	return var_38_2
end

return var_0_0
