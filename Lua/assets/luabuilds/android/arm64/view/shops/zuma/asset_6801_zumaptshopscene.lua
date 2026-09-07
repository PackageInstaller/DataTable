local ZumaPTShopScene = class("ZumaPTShopScene", import("...base.BaseUI"))

function ZumaPTShopScene:getUIName()
	return "ZumaPTShopUI"
end

function ZumaPTShopScene:getBGM()
	return "cw-story"
end

function ZumaPTShopScene:init()
	self:initData()
	self:findUI()
	self:addListener()

	return
end

function ZumaPTShopScene:didEnter()
	self:updatePTPanel()
	self:updateGoodPanel()

	return
end

function ZumaPTShopScene:onBackPressed()
	self:closeView()

	return
end

function ZumaPTShopScene:willExit()
	return
end

function ZumaPTShopScene:initData()
	self.actID = ActivityConst.MINIGAME_ZUMA_PT_SHOP_ID
	self.ptID = LaunchBallActivityMgr.GetGamePtId(ActivityConst.MINIGAME_ZUMA)
	self.ptItemID = id2ItemId(self.ptID)
	self.actShopVO = nil
	self.goodVOListForShow = nil
	self.goodIDList = pg.activity_template[self.actID].config_data
	self.goodTFList = {}

	self:updateData()

	return
end

function ZumaPTShopScene:findUI()
	self.tpl = self._tf:Find("Tpl")
	self.containerTF = self._tf:Find("Shop/Panel/ScrollView/Viewport/Content")
	self.backBtn = self._tf:Find("Adapt/Back")
	self.helpBtn = self._tf:Find("Adapt/Help")
	self.ptInfoIcon = self._tf:Find("Shop/PTInfo/Icon")
	self.ptInfoCountText = self._tf:Find("Shop/PTInfo/Count")

	setText(self.tpl:Find("Tip"), i18n("islandshop_tips2"))

	return
end

function ZumaPTShopScene:addListener()
	onButton(self, self.backBtn, function()
		self:closeView()

		return
	end, SFX_PANEL)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("card_pairs_help_tip")
		})

		return
	end, SFX_PANEL)

	self.goodUIItemList = UIItemList.New(self.containerTF, self.tpl)

	self.goodUIItemList:make(function(arg_12_0, arg_12_1, arg_12_2)
		arg_12_1 = arg_12_1 + 1

		if arg_12_0 == UIItemList.EventInit then
			self.goodTFList[arg_12_1] = arg_12_2

			onButton(self, arg_12_2, function()
				if not isActive(arg_12_2:Find("Mask")) then
					self:emit(ZumaPTShopMediator.OPEN_ZUMA_PT_SHOP_BUY_WINDOW, self:getGoodVOByIndex(arg_12_1))
				else
					pg.TipsMgr.GetInstance():ShowTips(i18n("launchball_minigame_shop"))
				end

				return
			end, SFX_PANEL)
		elseif arg_12_0 == UIItemList.EventUpdate then
			self:updateTpl(arg_12_1, arg_12_2)
		end

		return
	end)

	return
end

function ZumaPTShopScene:updateData()
	self.actShopVO = ActivityShop.New((getProxy(ActivityProxy):getActivityById(self.actID)))
	self.goodVOListForShow = self.actShopVO:getSortGoods()

	return
end

function ZumaPTShopScene:getGoodVOByIndex(arg_15_1)
	return self.goodVOListForShow[arg_15_1]
end

function ZumaPTShopScene:updatePTPanel()
	setText(self.ptInfoCountText, (Drop.New({
		type = 1,
		id = self.ptID
	}):getOwnedCount()))

	return
end

function ZumaPTShopScene:updateGoodPanel()
	self.goodUIItemList:align(#self.goodVOListForShow)

	return
end

function ZumaPTShopScene:updateTpl(arg_18_1, arg_18_2)
	local var_18_0 = arg_18_2:Find("BuyCount")
	local var_18_1 = self.goodVOListForShow[arg_18_1]
	local var_18_2 = Drop.New({
		type = self.goodVOListForShow[arg_18_1]:getConfig("commodity_type"),
		id = self.goodVOListForShow[arg_18_1]:getConfig("commodity_id"),
		count = self.goodVOListForShow[arg_18_1]:getConfig("num")
	})

	updateDrop(arg_18_2:Find("Item"), var_18_2)
	setScrollText(arg_18_2:Find("Name/Name"), var_18_2:getName())
	setText(arg_18_2:Find("PTCount"), (var_18_1:getConfig("resource_num")))

	local var_18_3 = var_18_1:getConfig("num_limit")

	if var_18_3 == 0 then
		setText(var_18_0, i18n("common_no_limit"))
	else
		setText(var_18_0, math.max(var_18_1:GetPurchasableCnt(), 0) .. "/" .. var_18_3)
	end

	local var_18_4 = arg_18_2:Find("Mask")
	local var_18_5 = var_18_4:Find("Lock")
	local var_18_6 = var_18_4:Find("SellOut")
	local var_18_7 = var_18_3 > 0 and var_18_1:GetPurchasableCnt() <= 0

	setActive(var_18_4, var_18_7)
	setActive(var_18_6, var_18_7)
	setActive(var_18_5, false)

	return
end

function ZumaPTShopScene:updateTplByGoodID(arg_19_1)
	local var_19_0 = 0

	for iter_19_0, iter_19_1 in ipairs(self.goodVOListForShow) do
		if iter_19_1.id == arg_19_1 then
			var_19_0 = iter_19_0
		end
	end

	self:updateTpl(var_19_0, self.goodTFList[var_19_0])

	return
end

return ZumaPTShopScene
