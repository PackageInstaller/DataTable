local YoumiyaStrongholdLayer = class("YoumiyaStrongholdLayer", import("view.base.BaseUI"))
local var_0_1 = pg.activity_ryza_furniture
local var_0_2 = pg.furniture_data_template

function YoumiyaStrongholdLayer:getUIName()
	return "YoumiyaStrongholdUI"
end

function YoumiyaStrongholdLayer:init()
	self.adapt = self._tf:Find("adapt")
	self.backBtn = self.adapt:Find("backBtn")
	self.homeBtn = self.adapt:Find("homeBtn")
	self.desc = self.adapt:Find("desc/text")
	self.res = self.adapt:Find("res")
	self.strongholdPage = self._tf:Find("pages/strongholdPage")
	self.detailPage = self._tf:Find("pages/detailPage")
	self.makeFurniturePanel = self._tf:Find("pages/makeFurniturePanel")
	self.awardList = UIItemList.New(self.detailPage:Find("detail/awardList"), self.detailPage:Find("detail/awardList/stage"))
	self.isOnMake = false

	setText(self.desc, i18n("yumia_stronghold_2"))

	for iter_2_0 = 1, 3 do
		setText(self.strongholdPage:Find(iter_2_0 .. "/comfort/text"), i18n("yumia_stronghold_3"))

		local var_2_0 = self.detailPage:Find("detail/stronghold/furnitures/" .. iter_2_0)

		for iter_2_1 = 1, var_2_0.childCount do
			local var_2_1 = var_2_0:Find(iter_2_1)

			for iter_2_2 = 0, var_2_1.childCount - 1 do
				setText(var_2_1:GetChild(iter_2_2):Find("comfort/comf/text"), i18n("yumia_stronghold_3"))
			end
		end

		setText(self.detailPage:Find("info/" .. iter_2_0 .. "/comfort/text"), i18n("yumia_stronghold_3"))
	end

	setText(self.detailPage:Find("detail/progress/Root/text"), i18n("yumia_stronghold_4"))
	setText(self.detailPage:Find("detail/awardTitle/text"), i18n("yumia_stronghold_5"))
	setText(self.detailPage:Find("detail/awardList/stage/got/text"), i18n("yumia_stronghold_6"))
	setText(self.makeFurniturePanel:Find("panel/complete/root/text"), i18n("yumia_stronghold_7"))
	setText(self.makeFurniturePanel:Find("panel/comfort/title"), i18n("yumia_stronghold_3"))
	setText(self.makeFurniturePanel:Find("panel/consume/title"), i18n("yumia_stronghold_8"))
	setText(self.makeFurniturePanel:Find("panel/consume/text"), i18n("yumia_stronghold_9"))
	setText(self.makeFurniturePanel:Find("panel/makeBtn/text"), i18n("yumia_stronghold_10"))

	self.camEventId = pg.CameraFixMgr.GetInstance():bind(pg.CameraFixMgr.ASPECT_RATIO_UPDATE, function(arg_3_0, arg_3_1)
		self:UpdateAdapt()

		return
	end)

	if self._tf.rect.height > 1440 then
		self.adapt:GetComponent(typeof(RectTransform)).sizeDelta = Vector2(0, 1440 - self._tf.rect.height)
		self.makeFurniturePanel:GetComponent(typeof(RectTransform)).sizeDelta = Vector2(0, 1440 - self._tf.rect.height)
	end

	pg.UIMgr.GetInstance():BlurPanel(self._tf, false)
	self._tf:GetComponent(typeof(DftAniEvent)):SetTriggerEvent(function()
		for iter_4_0 = 0, 2 do
			self.strongholdPage:GetChild(iter_4_0):GetComponent(typeof(Animation)):Play("Anim_YoumiyaStrongholdUI_Strongholdpage01_In")
		end

		return
	end)

	local var_2_2 = self.detailPage:GetComponent(typeof(DftAniEvent))

	var_2_2:SetTriggerEvent(function()
		for iter_5_0 = 0, 2 do
			local var_5_0 = self.detailPage:Find("info"):GetChild(iter_5_0)

			if isActive(var_5_0) then
				var_5_0:GetComponent(typeof(Animation)):Play("Anim_YoumiyaStrongholdUI_Strongholdpage01_In")
			end
		end

		return
	end)
	var_2_2:SetEndEvent(function()
		for iter_6_0 = 1, 3 do
			local var_6_0 = self.detailPage:Find("detail/stronghold/furnitures/" .. iter_6_0)

			for iter_6_1 = 1, var_6_0.childCount do
				local var_6_1 = var_6_0:Find(iter_6_1)

				for iter_6_2 = 0, var_6_1.childCount - 1 do
					setActive(var_6_1:GetChild(iter_6_2):Find("comfort/icon/VX"), true)
				end
			end
		end

		return
	end)

	return
end

function YoumiyaStrongholdLayer:didEnter()
	self:InitData()
	self:UpdateAdapt()
	onButton(self, self.backBtn, function()
		self:GoBack()

		return
	end, SFX_CANCEL)
	onButton(self, self.homeBtn, function()
		self:emit(YoumiyaStrongholdLayer.ON_HOME)

		return
	end, SFX_CANCEL)
	setActive(self.strongholdPage, true)
	setActive(self.detailPage, false)
	setActive(self.makeFurniturePanel, false)
	self:RefreshView()

	return
end

function YoumiyaStrongholdLayer:UpdateAdapt()
	local var_10_0 = pg.CameraFixMgr.GetInstance()

	self._tf:GetComponent(typeof(AspectRatioFitter)).aspectRatio = math.clamp(var_10_0.currentWidth / var_10_0.currentHeight, 1.3333333333333333, 2.1666666666666665)

	setSizeDelta(self._tf:Find("adapt"), {
		x = 0,
		y = 0
	})

	return
end

function YoumiyaStrongholdLayer:InitData()
	self.activityProxy = getProxy(ActivityProxy)
	self.allFurnitureCount = {
		0,
		0,
		0
	}
	self.allComfortCount = {
		0,
		0,
		0
	}

	for iter_11_0 = 1, 3 do
		self.allFurnitureCount[iter_11_0] = #var_0_1.get_id_list_by_type[iter_11_0]

		for iter_11_1, iter_11_2 in ipairs(var_0_1.get_id_list_by_type[iter_11_0]) do
			self.allComfortCount[iter_11_0] = self.allComfortCount[iter_11_0] + var_0_1[iter_11_2].com_add
		end
	end

	self.awardInfos = pg.activity_template[ActivityConst.YUMIA_BASE_ACT_ID].config_client.rewards

	return
end

function YoumiyaStrongholdLayer:RefreshData()
	self.items = self.activityProxy:getActivityByType(ActivityConst.ACTIVITY_TYPE_ATELIER_LINK):GetItems()
	self.activity = self.activityProxy:getActivityById(ActivityConst.YUMIA_BASE_ACT_ID)
	self.okFurnitureIds = self.activity:getData1List()
	self.gotAwardIndex = {
		0,
		0,
		0
	}

	for iter_12_0 = 1, 3 do
		self.gotAwardIndex[iter_12_0] = self.activity:getKVPList(1, iter_12_0)
	end

	self.furnitureCount = {
		0,
		0,
		0
	}
	self.comfortCount = {
		0,
		0,
		0
	}

	for iter_12_1 = 1, 3 do
		for iter_12_2, iter_12_3 in ipairs(var_0_1.get_id_list_by_type[iter_12_1]) do
			if table.contains(self.okFurnitureIds, iter_12_3) then
				self.furnitureCount[iter_12_1] = self.furnitureCount[iter_12_1] + 1
				self.comfortCount[iter_12_1] = self.comfortCount[iter_12_1] + var_0_1[iter_12_3].com_add
			end
		end
	end

	return
end

function YoumiyaStrongholdLayer:SetRes(arg_13_1)
	local var_13_0 = getProxy(PlayerProxy):getRawData()

	for iter_13_0 = 0, arg_13_1.childCount - 1 do
		setActive(arg_13_1:GetChild(iter_13_0), false)
	end

	for iter_13_1, iter_13_2 in ipairs({
		{
			138,
			self:GetItemCount(138)
		},
		{
			139,
			self:GetItemCount(139)
		},
		{
			140,
			self:GetItemCount(140)
		},
		{
			141,
			self:GetItemCount(141)
		},
		{
			6,
			self:GetItemCount(6)
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

function YoumiyaStrongholdLayer:RefreshView()
	self:RefreshData()
	self:SetRes(self.res)
	self:SetDetailPage()

	for iter_14_0 = 1, 3 do
		local var_14_0 = self.strongholdPage:GetChild(iter_14_0 - 1)

		setText(var_14_0:Find("root/name"), i18n("yumia_base_name_" .. iter_14_0))
		setText(var_14_0:Find("comfort/count2/count1"), self.comfortCount[iter_14_0])
		setText(var_14_0:Find("comfort/count2"), "/" .. self.allComfortCount[iter_14_0])
		GetImageSpriteFromAtlasAsync("ui/CourtyardUI_atlas", "express_" .. self:GetComfortableLevel(self.comfortCount[iter_14_0]), var_14_0:Find("comfort/icon"))
		onButton(self, var_14_0, function()
			self:EnterDetailPage(iter_14_0)

			return
		end, SFX_PANEL)

		local var_14_1 = false

		for iter_14_1 = 1, #self.awardInfos[iter_14_0] do
			if self.awardInfos[iter_14_0][iter_14_1][1] <= self.comfortCount[iter_14_0] and iter_14_1 > self.gotAwardIndex[iter_14_0] then
				var_14_1 = true

				break
			end
		end

		setActive(var_14_0:Find("tip"), var_14_1)
	end

	if self.strongholdIndex then
		self:EnterDetailPage(self.strongholdIndex)
	end

	return
end

function YoumiyaStrongholdLayer:SetDetailPage()
	for iter_16_0 = 1, 3 do
		setText(self.detailPage:Find("info/" .. iter_16_0 .. "/root/name"), i18n("yumia_base_name_" .. iter_16_0))
		setText(self.detailPage:Find("info/" .. iter_16_0 .. "/comfort/count2/count1"), self.comfortCount[iter_16_0])
		setText(self.detailPage:Find("info/" .. iter_16_0 .. "/comfort/count2"), "/" .. self.allComfortCount[iter_16_0])
		GetImageSpriteFromAtlasAsync("ui/CourtyardUI_atlas", "express_" .. self:GetComfortableLevel(self.comfortCount[iter_16_0]), self.detailPage:Find("info/" .. iter_16_0 .. "/comfort/icon"))

		local var_16_0 = self.detailPage:Find("detail/stronghold/furnitures/" .. iter_16_0)

		for iter_16_1 = 0, var_16_0.childCount - 1 do
			local var_16_1 = var_16_0:GetChild(iter_16_1)
			local var_16_2 = true

			for iter_16_2 = 0, var_16_1.childCount - 1 do
				local var_16_3 = var_16_1:GetChild(iter_16_2)
				local var_16_4 = tonumber(var_16_3.name)
				local var_16_5 = table.contains(self.okFurnitureIds, var_16_4)

				setActive(var_16_3:Find("fur"), var_16_5)
				setActive(var_16_3:Find("lockFur"), not var_16_5)
				setActive(var_16_3:Find("comfort"), not var_16_5)
				setText(var_16_3:Find("comfort/comf/count"), var_0_1[var_16_4].com_add)

				if not var_16_5 then
					var_16_2 = false

					onButton(self, var_16_3, function()
						self:ShowMakePanel(var_16_4)

						return
					end, SFX_PANEL)
				else
					removeOnButton(var_16_3)
				end
			end

			setActive(var_16_1, not false)

			if not false and not var_16_2 then
				-- block empty
			end
		end
	end

	onButton(self, self.detailPage:Find("leftChange"), function()
		self:EnterDetailPage(self.strongholdIndex - 1 == 0 and 3 or self.strongholdIndex - 1)

		return
	end, SFX_PANEL)
	onButton(self, self.detailPage:Find("rightChange"), function()
		self:EnterDetailPage(self.strongholdIndex + 1 == 4 and 1 or self.strongholdIndex + 1)

		return
	end, SFX_PANEL)

	return
end

function YoumiyaStrongholdLayer:EnterDetailPage(arg_20_1)
	self.strongholdIndex = arg_20_1

	setActive(self.strongholdPage, false)
	setActive(self.detailPage, true)

	for iter_20_0 = 1, 3 do
		setActive(self.detailPage:Find("info/" .. iter_20_0), iter_20_0 == arg_20_1)
	end

	setText(self.detailPage:Find("detail/progress/countBg/furnitureCount"), self.furnitureCount[arg_20_1] .. "/" .. self.allFurnitureCount[arg_20_1])

	for iter_20_1 = 1, 3 do
		setActive(self.detailPage:Find("detail/stronghold/furnitures/" .. iter_20_1), iter_20_1 == arg_20_1)
	end

	local var_20_0 = false
	local var_20_1 = 0
	local var_20_2 = self.awardInfos[arg_20_1]

	self.awardList:make(function(arg_21_0, arg_21_1, arg_21_2)
		if arg_21_0 == UIItemList.EventUpdate then
			local var_21_0 = var_20_2[arg_21_1 + 1][1]
			local var_21_1 = {
				type = var_20_2[arg_21_1 + 1][2][1],
				id = var_20_2[arg_21_1 + 1][2][2],
				count = var_20_2[arg_21_1 + 1][2][3]
			}

			updateDrop(arg_21_2:Find("award"), var_21_1)
			onButton(self, arg_21_2:Find("award"), function()
				self:emit(BaseUI.ON_DROP, var_21_1)

				return
			end, SFX_PANEL)
			setText(arg_21_2:Find("comfort"), var_21_0)
			setActive(arg_21_2:Find("got"), arg_21_1 < self.gotAwardIndex[arg_20_1])
			setActive(arg_21_2:Find("canGet"), var_21_0 <= self.comfortCount[arg_20_1] and arg_21_1 >= self.gotAwardIndex[arg_20_1])

			if var_21_0 <= self.comfortCount[arg_20_1] and arg_21_1 >= self.gotAwardIndex[arg_20_1] then
				var_20_0 = true
				var_20_1 = arg_21_1 + 1
			end
		end

		return
	end)
	self.awardList:align(#self.awardInfos[arg_20_1])
	setActive(self.detailPage:Find("detail/allGetBtn/VX"), false)

	if false then
		setGray(self.detailPage:Find("detail/allGetBtn"), false, false)
		onButton(self, self.detailPage:Find("detail/allGetBtn"), function()
			self:emit(YoumiyaStrongholdMediator.GET_AWARD, arg_20_1, var_20_1)

			return
		end, SFX_PANEL)
	else
		setGray(self.detailPage:Find("detail/allGetBtn"), true, false)
		removeOnButton(self.detailPage:Find("detail/allGetBtn"))
	end

	if isActive(self.makeFurniturePanel) then
		triggerButton(self.makeFurniturePanel:Find("panel/closeBtn"))
	end

	return
end

function YoumiyaStrongholdLayer:ShowMakePanel(arg_24_1)
	setActive(self.makeFurniturePanel, true)

	local var_24_0 = var_0_1[arg_24_1]
	local var_24_1 = self.makeFurniturePanel:GetComponent(typeof(Animation))
	local var_24_2 = self.makeFurniturePanel:GetComponent(typeof(DftAniEvent))

	onButton(self, self.makeFurniturePanel:Find("panel/closeBtn"), function()
		if self.isOnMake then
			return
		end

		var_24_2:SetEndEvent(function()
			setActive(self.makeFurniturePanel, false)

			return
		end)
		var_24_1:Play("Anim_YoumiyaStrongholdUI_makeFurniture_Out")

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("bg"), function()
		triggerButton(self.makeFurniturePanel:Find("panel/closeBtn"))

		return
	end, SFX_PANEL)
	setText(self.makeFurniturePanel:Find("panel/name"), var_0_2[var_0_1[arg_24_1].fur_id].name)

	local var_24_3, var_24_4 = HXSet.autoHxShiftPath("furnitures/" .. var_0_2[var_0_1[arg_24_1].fur_id].picture, "")
	local var_24_5 = self.makeFurniturePanel:Find("panel/icon"):GetComponent(typeof(Image))

	GetSpriteFromAtlasAsync(var_24_3, var_24_4, function(arg_28_0)
		var_24_5.sprite = arg_28_0

		var_24_5:SetNativeSize()

		local var_28_0

		if var_24_5.sprite.rect.height <= var_24_5.sprite.rect.width then
			var_28_0 = 300 / var_24_5.sprite.rect.width or 300 / var_24_5.sprite.rect.height
		end

		self.makeFurniturePanel:Find("panel/icon").localScale = Vector3(var_28_0, var_28_0, 1)

		return
	end)
	setText(self.makeFurniturePanel:Find("panel/comfort/count"), var_0_1[arg_24_1].com_add)
	setText(self.makeFurniturePanel:Find("panel/desc"), var_0_2[var_0_1[arg_24_1].fur_id].describe)
	setActive(self.makeFurniturePanel:Find("panel/complete"), false)
	onButton(self, self.makeFurniturePanel:Find("panel/consume/goBtn"), function()
		self:emit(YoumiyaStrongholdMediator.YOUMIA_GO_SCENE, SCENE.ATELIER_COMPOSITE, {
			activityID = 50043,
			versionIndex = 2
		})

		return
	end, SFX_PANEL)
	self:SetConsumeList(var_0_1[arg_24_1].material)

	local var_24_6 = true

	for iter_24_0, iter_24_1 in ipairs(var_0_1[arg_24_1].material) do
		if iter_24_1[3] > self:GetItemCount(iter_24_1[2]) then
			var_24_6 = false
		end
	end

	if var_24_6 then
		setGray(self.makeFurniturePanel:Find("panel/makeBtn"), false, true)
		onButton(self, self.makeFurniturePanel:Find("panel/makeBtn"), function()
			self.isOnMake = true

			var_24_2:SetTriggerEvent(function()
				self:emit(YoumiyaStrongholdMediator.MAKE_FURNITURE, arg_24_1, var_24_0.material)

				self.isOnMake = false

				triggerButton(self.makeFurniturePanel:Find("panel/closeBtn"))

				return
			end)
			setActive(self.makeFurniturePanel:Find("panel/complete"), true)
			self.makeFurniturePanel:GetComponent(typeof(Animation)):Play("Anim_YoumiyaStrongholdUI_makeFurniture_Complete")
			removeOnButton(self.makeFurniturePanel:Find("panel/makeBtn"))

			return
		end, SFX_PANEL)
	else
		setGray(self.makeFurniturePanel:Find("panel/makeBtn"), true, true)
		removeOnButton(self.makeFurniturePanel:Find("panel/makeBtn"))
	end

	return
end

function YoumiyaStrongholdLayer:SetConsumeList(arg_32_1)
	local var_32_0 = self.makeFurniturePanel:Find("panel/consume/consumeList")
	local var_32_1 = {}

	for iter_32_0, iter_32_1 in ipairs(arg_32_1) do
		table.insert(var_32_1, {
			iter_32_1[2],
			iter_32_1[3]
		})
	end

	for iter_32_2 = 0, var_32_0.childCount - 1 do
		setActive(var_32_0:GetChild(iter_32_2), false)
	end

	for iter_32_3, iter_32_4 in ipairs(var_32_1) do
		for iter_32_5 = 0, var_32_0.childCount - 1 do
			local var_32_2 = var_32_0:GetChild(iter_32_5)

			if var_32_2.name == tostring(iter_32_4[1]) then
				setActive(var_32_2, true)
				setText(var_32_2:Find("count1"), self:GetItemCount(iter_32_4[1]))
				setText(var_32_2:Find("count2"), "/" .. iter_32_4[2])

				break
			end
		end
	end

	return
end

function YoumiyaStrongholdLayer:GetComfortableLevel(arg_33_1)
	if arg_33_1 < 30 then
		return 1
	elseif arg_33_1 >= 30 and arg_33_1 < 68 then
		return 2
	else
		return 3
	end

	return
end

function YoumiyaStrongholdLayer:GetItemCount(arg_34_1)
	local var_34_0 = 0

	if arg_34_1 == 6 then
		var_34_0 = getProxy(PlayerProxy):getRawData():getResource(PlayerConst.ResDormMoney)
	elseif self.items[arg_34_1] then
		var_34_0 = self.items[arg_34_1].count
	end

	return var_34_0
end

function YoumiyaStrongholdLayer:GoBack()
	if isActive(self.detailPage) then
		setActive(self.strongholdPage, true)
		setActive(self.detailPage, false)

		self.strongholdIndex = nil

		if isActive(self.makeFurniturePanel) then
			triggerButton(self.makeFurniturePanel:Find("panel/closeBtn"))
		end

		for iter_35_0 = 1, 3 do
			local var_35_0 = self.detailPage:Find("detail/stronghold/furnitures/" .. iter_35_0)

			for iter_35_1 = 1, var_35_0.childCount do
				local var_35_1 = var_35_0:Find(iter_35_1)

				for iter_35_2 = 0, var_35_1.childCount - 1 do
					setActive(var_35_1:GetChild(iter_35_2):Find("comfort/icon/VX"), false)
				end
			end
		end

		return
	end

	self:closeView()

	return
end

function YoumiyaStrongholdLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	if self.camEventId then
		pg.CameraFixMgr.GetInstance():disconnect(self.camEventId)

		self.camEventId = nil
	end

	return
end

function YoumiyaStrongholdLayer:onBackPressed()
	self:GoBack()

	return
end

function YoumiyaStrongholdLayer.ShouldShowTip()
	local var_38_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.YUMIA_BASE_ACT_ID)
	local var_38_1 = var_38_0:getData1List()
	local var_38_2 = {
		0,
		0,
		0
	}

	for iter_38_0 = 1, 3 do
		var_38_2[iter_38_0] = var_38_0:getKVPList(1, iter_38_0)
	end

	local var_38_3 = {
		0,
		0,
		0
	}

	for iter_38_1 = 1, 3 do
		for iter_38_2, iter_38_3 in ipairs(var_0_1.get_id_list_by_type[iter_38_1]) do
			if table.contains(var_38_1, iter_38_3) then
				var_38_3[iter_38_1] = var_38_3[iter_38_1] + var_0_1[iter_38_3].com_add
			end
		end
	end

	local var_38_4 = false

	for iter_38_4 = 1, 3 do
		local var_38_5 = false

		for iter_38_5 = 1, #pg.activity_template[ActivityConst.YUMIA_BASE_ACT_ID].config_client.rewards[iter_38_4] do
			if pg.activity_template[ActivityConst.YUMIA_BASE_ACT_ID].config_client.rewards[iter_38_4][iter_38_5][1] <= var_38_3[iter_38_4] and iter_38_5 > var_38_2[iter_38_4] then
				var_38_5 = true

				break
			end
		end

		if var_38_5 then
			var_38_4 = true

			break
		end
	end

	return var_38_4
end

return YoumiyaStrongholdLayer
