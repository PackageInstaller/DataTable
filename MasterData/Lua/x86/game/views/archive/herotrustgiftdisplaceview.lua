local HeroTrustGiftDisplaceView = class("HeroTrustGiftDisplaceView", ReduxView)

function HeroTrustGiftDisplaceView:UIName()
	return "Widget/System/Hero_coop/HeroCoopGiftUI"
end

function HeroTrustGiftDisplaceView:UIParent()
	return manager.ui.uiMain.transform
end

function HeroTrustGiftDisplaceView:Init()
	self:InitUI()
	self:AddUIListener()
end

function HeroTrustGiftDisplaceView:InitUI()
	self:BindCfgUI()

	self.list = LuaList.New(handler(self, self.IndexItem), self.m_list, HeroTrustGiftDisplaceItem)
	self.item = CommonItemView.New(self.m_item, true)
	self.rareController = ControllerUtil.GetController(self.transform_, "rare")
	self.selectController = ControllerUtil.GetController(self.transform_, "select")
	self.changeController = ControllerUtil.GetController(self.transform_, "change")
	self.clickHandle = handler(self, self.ItemClick)
	self.unSelectHanld = handler(self, self.UnSelect)
end

function HeroTrustGiftDisplaceView:AddUIListener()
	self:AddBtnListener(nil, self.m_star2Btn, function()
		self:SelectItem(2)
	end)
	self:AddBtnListener(nil, self.m_star3Btn, function()
		self:SelectItem(3)
	end)
	self:AddBtnListener(nil, self.m_star4Btn, function()
		self:SelectItem(4)
	end)
	self:AddBtnListener(nil, self.m_star5Btn, function()
		self:SelectItem(5)
	end)
	self:AddBtnListener(nil, self.m_displaceBtn, function()
		local var_10_0 = 0

		for iter_10_0, iter_10_1 in pairs(self.choice_item) do
			var_10_0 = var_10_0 + iter_10_1
		end

		local var_10_1 = self:GetGiftItemId(self.rare)
		local var_10_2 = self:GetRatio(var_10_1)
		local var_10_3 = math.floor(var_10_0 / var_10_2)

		if var_10_3 * var_10_2 < var_10_2 then
			ShowTips("HERO_TRUST_DISPLACE_FAIL")

			return
		end

		if self:GetTrustGiftDisplaceMax(var_10_1) < var_10_3 + ArchiveData:GetTrustGiftDisplaceCount(var_10_1) then
			ShowTips("HERO_TRUST_DISPLACE_UP_LIMIT")

			return
		end

		local var_10_4 = {}

		for iter_10_2, iter_10_3 in pairs(self.choice_item) do
			var_10_4[iter_10_2] = iter_10_3
		end

		local var_10_5 = var_10_0 - var_10_3 * var_10_2

		while var_10_5 > 0 do
			local var_10_6 = table.remove(self.operate_item)

			if var_10_6 then
				if var_10_4[var_10_6] and var_10_4[var_10_6] > 0 then
					var_10_5 = var_10_5 - var_10_4[var_10_6]
					var_10_4[var_10_6] = math.max(0, var_10_4[var_10_6] - var_10_5)
				end
			else
				break
			end
		end

		if var_10_5 > 0 then
			ShowTips("HERO_TRUST_DISPLACE_FAIL")

			return
		end

		local var_10_7 = {}

		for iter_10_4, iter_10_5 in pairs(var_10_4) do
			if iter_10_5 ~= 0 then
				table.insert(var_10_7, {
					id = iter_10_4,
					num = iter_10_5
				})
			end
		end

		ArchiveAction.QueryExChangeTrustItem(var_10_7, {
			{
				id = var_10_1,
				num = var_10_3
			}
		})
		self:RefreshRight()
	end)
	self.m_slider.onValueChanged:AddListener(function()
		local var_11_0 = self.m_slider.value

		if self.m_slider.value < 1 then
			self.m_slider.value = 1
			var_11_0 = 1
		end

		self.choice_item[self.select_item_id] = var_11_0
		self.m_selectNum.text = var_11_0

		if self.select_item_id ~= self.operate_item[#self.operate_item] then
			table.insert(self.operate_item, self.select_item_id)
		end

		self.list:Refresh()
		self:RefreshRight()

		self.m_delBtn.interactable = var_11_0 > 1
		self.m_addBtn.interactable = var_11_0 < self.m_slider.maxValue
	end)
	self:AddBtnListener(nil, self.m_addBtn, function()
		local var_12_0 = self.choice_item[self.select_item_id] or 0

		if var_12_0 >= self.m_slider.maxValue then
			ShowTips("HERO_TRUST_DISPLACE_MAX")

			return
		end

		local var_12_1 = self:GetRatio((self:GetGiftItemId(self.rare)))
		local var_12_2 = 0

		for iter_12_0, iter_12_1 in pairs(self.choice_item) do
			var_12_2 = var_12_2 + iter_12_1
		end

		local var_12_3 = math.floor(var_12_2 / var_12_1) * var_12_1

		if var_12_2 ~= var_12_3 then
			var_12_1 = var_12_1 - var_12_2 + var_12_3
		end

		self.m_slider.value = var_12_0 + math.min(var_12_1, ItemTools.getItemNum(self.select_item_id) - var_12_0)
	end)
	self:AddBtnListener(nil, self.m_delBtn, function()
		local var_13_0 = self.choice_item[self.select_item_id] or 0

		if var_13_0 <= 1 then
			return
		end

		local var_13_1 = self:GetRatio((self:GetGiftItemId(self.rare)))
		local var_13_2 = 0

		for iter_13_0, iter_13_1 in pairs(self.choice_item) do
			var_13_2 = var_13_2 + iter_13_1
		end

		local var_13_3 = math.floor(var_13_2 / var_13_1) * var_13_1

		if var_13_2 ~= var_13_3 then
			var_13_1 = var_13_2 - var_13_3
		end

		self.m_slider.value = var_13_0 - math.min(var_13_1, var_13_0)
	end)
end

function HeroTrustGiftDisplaceView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("HERO_TRUST_DISPLACE_TIP")
end

function HeroTrustGiftDisplaceView:OnEnter()
	self.gifts = self:GetGiftItemList()

	self.list:StartScroll(#self.gifts)

	self.select_item_id = 0
	self.choice_item = {}
	self.operate_item = {}

	self:RefreshSlider()
	self:SelectItem(2)
end

function HeroTrustGiftDisplaceView:GetGiftItemList()
	local var_16_0 = {}

	for iter_16_0, iter_16_1 in ipairs(ItemCfg.get_id_list_by_type[ItemConst.ITEM_TYPE.ARCHIVE_GIFT]) do
		if ItemCfg[iter_16_1].sub_type == 1 and ItemTools.getItemNum(iter_16_1) > 0 then
			table.insert(var_16_0, iter_16_1)
		end
	end

	table.sort(var_16_0, function(arg_17_0, arg_17_1)
		local var_17_0 = self:GetLikeHero(arg_17_0)
		local var_17_1 = self:GetLikeHero(arg_17_1)
		local var_17_2 = var_17_0 ~= 0 and ArchiveData:GetArchive(var_17_0).lv or 0
		local var_17_3 = var_17_1 ~= 0 and ArchiveData:GetArchive(var_17_1).lv or 0

		if var_17_0 ~= var_17_1 then
			if var_17_2 ~= var_17_3 then
				return var_17_3 < var_17_2
			else
				return arg_17_1 < arg_17_0
			end
		else
			return arg_17_1 < arg_17_0
		end
	end)

	return var_16_0
end

function HeroTrustGiftDisplaceView:GetLikeHero(arg_18_1)
	for iter_18_0, iter_18_1 in ipairs(HeroRecordCfg.all) do
		if table.indexof(HeroRecordCfg[iter_18_1].gift_like_id1, arg_18_1) then
			return iter_18_1
		end
	end

	return 0
end

function HeroTrustGiftDisplaceView:OnExit()
	manager.windowBar:HideBar()
end

function HeroTrustGiftDisplaceView:SelectItem(arg_20_1)
	self.choice_item = {}
	self.operate_item = {}
	self.rare = arg_20_1

	self.rareController:SetSelectedState(arg_20_1)
	self:RefreshRight()

	self.select_item_id = 0

	self:RefreshSlider()
end

function HeroTrustGiftDisplaceView:RefreshSlider()
	if self.select_item_id == 0 then
		self.selectController:SetSelectedIndex(0)
	else
		local var_21_0 = self.choice_item[self.select_item_id] or 0
		local var_21_1 = self:GetGiftItemId(self.rare)
		local var_21_2 = 0

		for iter_21_0, iter_21_1 in pairs(self.choice_item) do
			if iter_21_0 ~= self.select_item_id then
				var_21_2 = var_21_2 + iter_21_1
			end
		end

		local var_21_3 = (self:GetTrustGiftDisplaceMax(var_21_1) - ArchiveData:GetTrustGiftDisplaceCount(var_21_1)) * self:GetRatio(var_21_1)

		if var_21_2 < var_21_3 then
			self.selectController:SetSelectedIndex(1)

			self.m_slider.maxValue = math.min(ItemTools.getItemNum(self.select_item_id), var_21_3 - var_21_2)
		elseif var_21_0 == 0 then
			self.selectController:SetSelectedIndex(0)
		else
			self.selectController:SetSelectedIndex(1)

			self.m_slider.maxValue = var_21_0
		end

		self.m_slider.minValue = 0
		self.m_slider.value = math.max(1, var_21_0)
		self.m_selectNum.text = math.max(1, var_21_0)
	end

	self.list:Refresh()
	self:RefreshRight()
end

function HeroTrustGiftDisplaceView:RefreshRight()
	local var_22_0 = self:GetGiftItemId(self.rare)
	local var_22_1 = clone(ItemTemplateData)

	var_22_1.id = var_22_0
	var_22_1.number = 1

	function var_22_1.clickFun()
		ShowPopItem(POP_ITEM, {
			var_22_0,
			1
		})
	end

	self.item:SetData(var_22_1)

	self.m_itemName.text = ItemTools.getItemName(var_22_0)

	local var_22_2 = self:GetRatio(var_22_0)

	self.m_ratioLab.text = var_22_2

	local var_22_3 = 0

	for iter_22_0, iter_22_1 in pairs(self.choice_item) do
		var_22_3 = var_22_3 + iter_22_1
	end

	if var_22_3 == 0 then
		self.m_displaceBtn.interactable = false

		self.changeController:SetSelectedIndex(0)
	else
		self.m_displaceBtn.interactable = true

		self.changeController:SetSelectedIndex(1)
	end

	self.m_displaceNum.text = math.floor(var_22_3 / var_22_2)
	self.m_ceilLab.text = ArchiveData:GetTrustGiftDisplaceCount(var_22_0) .. "/" .. self:GetTrustGiftDisplaceMax(var_22_0)

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.layoutTrs_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.layoutTrs_)
end

function HeroTrustGiftDisplaceView:Dispose()
	self.item:Dispose()
	self.list:Dispose()
	HeroTrustGiftDisplaceView.super.Dispose(self)
end

function HeroTrustGiftDisplaceView:GetGiftItemId(arg_25_1)
	if arg_25_1 == 2 then
		return 30012
	elseif arg_25_1 == 3 then
		return 30013
	elseif arg_25_1 == 4 then
		return 30014
	else
		return 30015
	end
end

function HeroTrustGiftDisplaceView:GetRatio(arg_26_1)
	for iter_26_0, iter_26_1 in ipairs(GameSetting.hero_trust_exchange_need.value) do
		if arg_26_1 == iter_26_1[1] then
			return iter_26_1[2]
		end
	end

	return 1
end

function HeroTrustGiftDisplaceView:GetTrustGiftDisplaceMax(arg_27_1)
	for iter_27_0, iter_27_1 in ipairs(GameSetting.hero_trust_exchange_up_limit.value) do
		if arg_27_1 == iter_27_1[1] then
			return iter_27_1[2]
		end
	end

	return 0
end

function HeroTrustGiftDisplaceView:IndexItem(arg_28_1, arg_28_2)
	arg_28_2:SetData(self.gifts[arg_28_1], self.choice_item[self.gifts[arg_28_1]] or 0)
	arg_28_2:SetSelect(self.select_item_id)
	arg_28_2:RegistCallBack(self.clickHandle)
	arg_28_2:RegistCallBack2(self.unSelectHanld)
end

function HeroTrustGiftDisplaceView:ItemClick(arg_29_1)
	self.select_item_id = arg_29_1

	for iter_29_0, iter_29_1 in pairs((self.list:GetItemList())) do
		iter_29_1:SetSelect(self.select_item_id)
	end

	if not self.choice_item[arg_29_1] or self.choice_item[arg_29_1] == 0 then
		local var_29_0 = self:GetGiftItemId(self.rare)
		local var_29_1 = self:GetRatio(var_29_0)
		local var_29_2 = 0

		for iter_29_2, iter_29_3 in pairs(self.choice_item) do
			var_29_2 = var_29_2 + iter_29_3
		end

		local var_29_3 = (self:GetTrustGiftDisplaceMax(var_29_0) - ArchiveData:GetTrustGiftDisplaceCount(var_29_0)) * var_29_1

		if var_29_2 < var_29_3 then
			self.choice_item[arg_29_1] = math.min(var_29_1, (math.min(var_29_3 - var_29_2, ItemTools.getItemNum(arg_29_1))))

			table.insert(self.operate_item, arg_29_1)
		else
			ShowTips("HERO_TRUST_DISPLACE_MAX")
		end
	end

	self:RefreshSlider()
end

function HeroTrustGiftDisplaceView:UnSelect(arg_30_1)
	self.select_item_id = 0

	for iter_30_0, iter_30_1 in pairs((self.list:GetItemList())) do
		iter_30_1:SetSelect(self.select_item_id)
	end

	self.choice_item[arg_30_1] = 0

	self:RefreshSlider()
end

function HeroTrustGiftDisplaceView:OnHeroTrustItemDisplace()
	self.gifts = self:GetGiftItemList()

	self.list:StartScrollWithoutAnimator(#self.gifts, (self.list:GetScrolledPosition()))

	self.select_item_id = 0
	self.choice_item = {}
	self.operate_item = {}

	self:RefreshSlider()
end

return HeroTrustGiftDisplaceView
