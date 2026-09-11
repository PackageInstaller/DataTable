local PopItemOperateView = class("PopItemOperateView", import("game.views.pop.sourcePop.PopItemSourceView"))

function PopItemOperateView:CustomInitUI()
	PopItemOperateView.super.CustomInitUI(self)
end

function PopItemOperateView:OnEnter()
	PopItemOperateView.super.OnEnter(self)
	self:RefreshUI()

	self[ON_TRY_TO_USE_ITEM] = self.UseItemFun
end

function PopItemOperateView:OnExit()
	self[ON_TRY_TO_USE_ITEM] = nil

	PopItemOperateView.super.OnExit(self)
end

function PopItemOperateView:Dispose()
	PopItemOperateView.super.Dispose(self)

	self.addBtn_ = nil
	self.delBtn_ = nil
	self.materialCntText_ = nil
	self.useNumSlider_ = nil
end

function PopItemOperateView:AddListeners()
	PopItemOperateView.super.AddListeners(self)
end

function PopItemOperateView:RemoveListeners()
	PopItemOperateView.super.RemoveListeners(self)
end

function PopItemOperateView:AddVitalityCnt(arg_7_1)
	if ItemCfg[arg_7_1].sub_type == 401 or ItemCfg[arg_7_1].sub_type == 403 then
		return ItemCfg[arg_7_1].param[1][2]
	end

	return false
end

function PopItemOperateView:UseItemFun(arg_8_1, arg_8_2)
	if isSuccess(arg_8_1.result) then
		local var_8_0 = ItemTools.getItemNum(self:GetItemID(), (self:GetItemTimeValid()))

		if var_8_0 <= 0 then
			self:Back()
		else
			self:RefreshUI()
			self:RefreshCount()
			self:SetCommonItem(var_8_0)
		end

		local var_8_1 = arg_8_1.drop_list

		if ItemCfg[arg_8_2.use_item_list[1].item_info.id].type == ItemConst.ITEM_TYPE.SKIN_CHANGE then
			getReward(formatRewardCfgList({
				{
					ItemCfg[arg_8_2.use_item_list[1].item_info.id].param[1],
					1
				}
			}))
		elseif ItemCfg[arg_8_2.use_item_list[1].item_info.id].sub_type == ItemConst.ITEM_SUB_TYPE.BIRTHDAY_ITEM then
			manager.story:StartStory(BirthdayCfg[BirthdayCfg.get_id_list_by_commemorative_props_id[arg_8_2.use_item_list[1].item_info.id][1]].story_id)
		elseif ItemCfg[arg_8_2.use_item_list[1].item_info.id].sub_type == ItemConst.ITEM_SUB_TYPE.BITRHDAY_LETTER then
			manager.story:StartStory(BirthdayCfg[BirthdayCfg.get_id_list_by_appendix_id[arg_8_2.use_item_list[1].item_info.id][1]].story_id)
			IllustratedData:ModifyPlot(BirthdayCfg[BirthdayCfg.get_id_list_by_appendix_id[arg_8_2.use_item_list[1].item_info.id][1]].story_id)
			getReward(var_8_1)
			SDKTools.SendMessageToSDK("birthday_received", {
				story_unlock = 1
			})
		elseif ItemCfg[arg_8_2.use_item_list[1].item_info.id].type == ItemConst.ITEM_TYPE.DYNAMIC_STICKER then
			ShowTips("EXCHANGE_SUCCESS")
		elseif ItemCfg[arg_8_2.use_item_list[1].item_info.id].sub_type == ItemConst.ITEM_SUB_TYPE.MOON_CAKE_GIFT then
			getReward(var_8_1)
			MoonCakeAction.OnOpenGift(ItemCfg[arg_8_2.use_item_list[1].item_info.id].time[2][1], arg_8_1.drop_list)
		else
			getReward(var_8_1)
		end

		manager.notify:CallUpdateFunc(NOTIFY_FOR_BAG_REFRESH_BUG)
	else
		ShowTips(arg_8_1.result)
	end
end

function PopItemOperateView:RefreshUI()
	local var_9_0 = self:GetItemID()

	self.useNumSlider_.minValue = 0
	self.useNumSlider_.maxValue = self:GetMaxNum()
	self.useNumSlider_.value = 1

	local var_9_1 = ItemCfg[var_9_0]

	if ItemCfg[var_9_0].sub_type == ItemConst.ITEM_SUB_TYPE.NEWWARCHESS_MOVEPOINT_PACKAGE then
		SetActive(self.operatePanel_, false)
	else
		SetActive(self.operatePanel_, var_9_1 and (var_9_1.use == 1 or var_9_1.use == 2) and MaterialConst.MATERIAL_TYPE.MYTHIC_REFRESH ~= var_9_1.sub_type)
	end

	if var_9_1.sub_type == ItemConst.ITEM_SUB_TYPE.OPTIONAL_ITEM or var_9_1.sub_type == ItemConst.ITEM_SUB_TYPE.HERO_OPTIONAL_ONE or var_9_1.type == ItemConst.ITEM_TYPE.GIFT and var_9_1.sub_type == ItemConst.ITEM_SUB_TYPE.FUKUBUKURO then
		SetActive(self.operateInfoGo_, false)
	else
		SetActive(self.operateInfoGo_, true)
	end
end

function PopItemOperateView:GetMaxNum()
	local var_10_0 = self:GetItemID()

	if ItemCfg[var_10_0].sub_type == ItemConst.ITEM_SUB_TYPE.OPTIONAL_ITEM or ItemCfg[var_10_0].sub_type == ItemConst.ITEM_SUB_TYPE.HERO_OPTIONAL_ONE then
		return 1
	end

	local var_10_1 = ItemTools.getItemNum(var_10_0, self.itemInfo_.timeValid)

	if ItemCfg[var_10_0].type == ItemConst.ITEM_TYPE.PROPS and (ItemConst.ITEM_SUB_TYPE.PROPS_VITALITY == ItemCfg[var_10_0].sub_type or ItemConst.ITEM_SUB_TYPE.PROPS_VITALITY_TIME_VALID == ItemCfg[var_10_0].sub_type) then
		return (math.max(math.min(math.floor((999 - ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY)) / ItemCfg[var_10_0].param[1][2]), var_10_1), 1))
	end

	return var_10_1
end

function PopItemOperateView:UpdateCount()
	if self.useNumSlider_.value < 1 then
		self.useNumSlider_.value = 1
	end

	self.materialCntText_.text = self.useNumSlider_.value
	self.delBtn_.interactable = self.useNumSlider_.value > 1

	local var_11_0 = self:GetItemID()

	self.addBtn_.interactable = self.useNumSlider_.value < self:GetMaxNum()
end

return PopItemOperateView
