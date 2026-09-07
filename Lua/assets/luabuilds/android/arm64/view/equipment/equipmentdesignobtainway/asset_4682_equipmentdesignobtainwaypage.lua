local EquipmentDesignObtainWayPage = class("EquipmentDesignObtainWayPage", import("view.base.BaseSubView"))
local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3
local var_0_4 = {
	i18n("equipment_design_chapter"),
	i18n("equipment_design_tech"),
	(i18n("equipment_design_shop"))
}

function EquipmentDesignObtainWayPage:getUIName()
	return "EquipmentDesignObtainWayUI"
end

function EquipmentDesignObtainWayPage:OnLoaded()
	self.animationPlayer = self._tf:GetComponent(typeof(Animation))
	self.dropTF = self._tf:Find("main_page/item/left/IconTpl")
	self.nameTxt = self._tf:Find("main_page/item/name_container/name/Text")
	self.descTxt = self._tf:Find("main_page/item/Text")
	self.closeBtn = self._tf:Find("main_page/top/btnBack")
	self.uiWayList = UIItemList.New(self._tf:Find("main_page/obtainWay/list/content"), self._tf:Find("main_page/obtainWay/list/content/tpl"))
	self.uiChapterWayList = UIItemList.New(self._tf:Find("sub_page/list/content"), self._tf:Find("sub_page/list/content/tpl"))

	setText(self._tf:Find("main_page/obtainWay/list/content/tpl/expand/Text"), i18n("equipment_design_btn_expand"))
	setText(self._tf:Find("main_page/obtainWay/list/content/tpl/fold/Text"), i18n("equipment_design_btn_fold"))
	setText(self._tf:Find("main_page/obtainWay/list/content/tpl/skip/Text"), i18n("equipment_design_btn_skip"))
	setText(self._tf:Find("sub_page/list/content/tpl/skip_btn/Text"), i18n("equipment_design_btn_skip"))
	setText(self._tf:Find("main_page/obtainWay/title"), i18n("equipment_design_sub_title"))
	setText(self._tf:Find("main_page/top/bg/infomation/title"), i18n("words_information"))

	return
end

function EquipmentDesignObtainWayPage:OnInit()
	onButton(self, self._tf:Find("bg"), function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)

	self.isOpenSubPage = false

	return
end

function EquipmentDesignObtainWayPage:Show(arg_6_1)
	EquipmentDesignObtainWayPage.super.Show(self)

	self.designId = arg_6_1

	self:UpdateObtainWay((self:GetObtainWayData(arg_6_1)))
	self:UpdateEquipmentDesignInfo(arg_6_1)
	self:ResetSubPage()
	self:BlurPanel(self._tf)

	return
end

function EquipmentDesignObtainWayPage:UpdateEquipmentDesignInfo(arg_7_1)
	local var_7_0 = Item.New({
		count = 0,
		id = pg.compose_data_template[arg_7_1].material_id
	})

	setText(self.nameTxt, HXSet.hxLan(shortenString(var_7_0:getConfig("name"), 12)))
	setText(self.descTxt, HXSet.hxLan(var_7_0:getConfig("display")))
	updateItem(self.dropTF, var_7_0)
	setActive(self.dropTF:Find("icon_bg/count"), false)

	return
end

function EquipmentDesignObtainWayPage:ResetSubPage()
	self.animationPlayer:Stop()
	self.animationPlayer:Play("reset_sub_page")

	self.isOpenSubPage = false

	return
end

function EquipmentDesignObtainWayPage:Hide()
	EquipmentDesignObtainWayPage.super.Hide(self)
	self:ResetSubPage()
	self:UnOverlayPanel(self._tf, self._parentTf)

	return
end

function EquipmentDesignObtainWayPage:GetObtainWayData(arg_10_1)
	local var_10_0 = getProxy(EquipmentProxy):GetObtainWay4EquipmentDesign(arg_10_1)
	local var_10_1 = {}

	if var_10_0[2] then
		table.insert(var_10_1, var_0_2)
	end

	if var_10_0[3] then
		table.insert(var_10_1, var_0_3)
	end

	if #var_10_0[1] > 0 then
		table.insert(var_10_1, 1, var_0_1)
	end

	return var_10_1
end

function EquipmentDesignObtainWayPage:UpdateObtainWay(arg_11_1)
	self.uiWayList:make(function(arg_12_0, arg_12_1, arg_12_2)
		if arg_12_0 == UIItemList.EventUpdate then
			self:UpdateWayTpl(arg_12_2, arg_11_1[arg_12_1 + 1])
		end

		return
	end)
	self.uiWayList:align(#arg_11_1)

	return
end

function EquipmentDesignObtainWayPage:UpdateWayTpl(arg_13_1, arg_13_2)
	local var_13_0 = arg_13_1:Find("expand")
	local var_13_1 = arg_13_1:Find("fold")
	local var_13_2 = arg_13_1:Find("skip")

	local function var_13_3()
		setActive(var_13_0, arg_13_2 == var_0_1 and not self.isOpenSubPage)
		setActive(var_13_1, arg_13_2 == var_0_1 and self.isOpenSubPage)
		setActive(var_13_2, arg_13_2 == var_0_2 or arg_13_2 == var_0_3)

		return
	end

	onButton(self, var_13_0, function()
		self.animationPlayer:Stop()
		self.animationPlayer:Play("open_sub_page")
		self:UpdateChapterWays()

		self.isOpenSubPage = true

		var_13_3()

		return
	end, SFX_PANEL)
	onButton(self, var_13_1, function()
		self.animationPlayer:Stop()
		self.animationPlayer:Play("close_sub_page")

		self.isOpenSubPage = false

		var_13_3()

		return
	end, SFX_PANEL)
	var_13_3()
	onButton(self, var_13_2, function()
		if arg_13_2 == var_0_2 then
			self:GoTechScene()
		elseif arg_13_2 == var_0_3 then
			self:GoShopScene()
		end

		return
	end, SFX_PANEL)
	setText(arg_13_1:Find("title"), var_0_4[arg_13_2])

	return
end

function EquipmentDesignObtainWayPage:UpdateChapterWays()
	local var_18_0 = getProxy(EquipmentProxy):GetObtainWay4EquipmentDesign(self.designId)[1]

	self.uiChapterWayList:make(function(arg_19_0, arg_19_1, arg_19_2)
		if arg_19_0 == UIItemList.EventUpdate then
			local var_19_0 = var_18_0[arg_19_1 + 1]

			setScrollText(arg_19_2:Find("mask/Text"), i18n("equipment_design_chapter") .. ":" .. pg.chapter_template[var_18_0[arg_19_1 + 1]].name)
			onButton(self, arg_19_2:Find("skip_btn"), function()
				self:GoChapterScene(var_19_0)

				return
			end, SFX_PANEL)
		end

		return
	end)
	self.uiChapterWayList:align(#var_18_0)

	return
end

function EquipmentDesignObtainWayPage:GoChapterScene(arg_21_1)
	if pg.chapter_template[arg_21_1].act_id ~= 0 and pg.chapter_template[arg_21_1].act_id ~= 100001 then
		local var_21_0 = getProxy(ActivityProxy):RawGetActivityById(pg.chapter_template[arg_21_1].act_id)

		if not var_21_0 or var_21_0:isEnd() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_notStartOrEnd"))

			return
		end

		local var_21_1, var_21_2 = chapterProxy:getLastMapForActivity()

		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.LEVEL, {
			chapterId = var_21_2,
			mapIdx = var_21_1
		})

		return
	end

	local var_21_3 = getProxy(ChapterProxy):getChapterById(arg_21_1)

	if not var_21_3 or not var_21_3:isUnlock() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("battle_levelScene_chapter_lock"))

		return
	end

	pg.m02:sendNotification(GAME.GO_SCENE, SCENE.LEVEL, {
		chapterId = arg_21_1,
		mapIdx = pg.chapter_template[arg_21_1].map
	})

	return
end

function EquipmentDesignObtainWayPage:GoTechScene()
	pg.m02:sendNotification(GAME.GO_SCENE, SCENE.TECHNOLOGY)

	return
end

function EquipmentDesignObtainWayPage:GoShopScene()
	pg.m02:sendNotification(GAME.GO_SCENE, SCENE.SHOP, {
		warp = ShopConst.TYPE_FRAGMENT,
		type = ShopConst.SHOP_TYPE.SUPPLY
	})

	return
end

function EquipmentDesignObtainWayPage:OnDestroy()
	if self:isShowing() then
		self:Hide()
	end

	return
end

return EquipmentDesignObtainWayPage
