local StoreItemInfo = class("StoreItemInfo", ReduxView)

function StoreItemInfo:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.storeHeadInfoView_ = StoreHeadInfo.New(self.itemHeadGo_)
	self.hideBtnController_ = self.controllerEx_:GetController("btnState")
	self.btnController_ = self.controllerEx_:GetController("btn")
	self.switchBtnController_ = self.controllerEx_:GetController("tab")
	self.uiList_ = LuaList.New(handler(self, self.IndexSourceItem), self.uiListGo_, StoreItemSource)
	self.selectInfoType_ = StoreConst.ITEM_INFO_TYPE.DESC
end

function StoreItemInfo:OnEnter()
	self.storeHeadInfoView_:OnEnter()
end

function StoreItemInfo:OnExit()
	self.storeHeadInfoView_:OnExit()
end

function StoreItemInfo:Dispose()
	StoreItemInfo.super.Dispose(self)
	self.uiList_:Dispose()

	self.uiList_ = nil

	self.storeHeadInfoView_:Dispose()

	self.storeHeadInfoView_ = nil
end

function StoreItemInfo:AddListeners()
	self:AddBtnListener(self.switchBtn_, nil, function()
		self.selectInfoType_ = self.selectInfoType_ == StoreConst.ITEM_INFO_TYPE.DESC and StoreConst.ITEM_INFO_TYPE.SOURCE or StoreConst.ITEM_INFO_TYPE.DESC

		self:RefreshInfo()
	end)
	self:AddBtnListener(self.useBtn_, nil, function()
		local var_7_0 = ItemTools.GetItemExpiredTimeByInfo(self.itemData_)

		if var_7_0 ~= 0 and var_7_0 <= manager.time:GetServerTime() then
			ShowTips("ITEM_EXPIRE")

			return
		end

		if ItemCfg[self.itemData_.id].sub_type == ItemConst.ITEM_SUB_TYPE.OPTIONAL_ITEM or ItemCfg[self.itemData_.id].sub_type == ItemConst.ITEM_SUB_TYPE.OPTIONAL_ITEM_LIMIT_TIME or ItemCfg[self.itemData_.id].sub_type == ItemConst.ITEM_SUB_TYPE.HERO_OPTIONAL_ONE then
			self:CheckHeroOptionalOne(ItemCfg[self.itemData_.id], var_7_0)

			return
		end

		if ItemCfg[self.itemData_.id].type == ItemConst.ITEM_TYPE.GIFT and ItemConst.ITEM_SUB_TYPE.FUKUBUKURO == ItemCfg[self.itemData_.id].sub_type then
			JumpTools.OpenPageByJump("popFukubukuroSelect", {
				popItemInfo = {
					self.itemData_.id,
					self.itemData_.number,
					0,
					self.itemData_.timeValid
				},
				instance_id = self.itemData_.instance_id
			})

			return
		end

		if ItemCfg[self.itemData_.id].sub_type == ItemConst.ITEM_SUB_TYPE.LIMIT_TIME_SKIN_ITEM then
			JumpTools.OpenPageByJump("limitTimeSkinUsePop", {
				itemData = self.itemData_
			})

			return
		end

		self:CheckItemUse(ItemCfg[self.itemData_.id], var_7_0)
	end)
	self:AddBtnListener(self.composeBtn_, nil, function()
		JumpTools.OpenPageByJump("synthesise", {
			id = ItemCfg[self.itemData_.id].compose_id
		})
	end)
	self:AddBtnListener(self.decomposeBtn_, nil, function()
		JumpTools.OpenPageByJump("synthesise", {
			id = ItemCfg[self.itemData_.id].decompose_id
		})
	end)
end

function StoreItemInfo:SetData(arg_10_1, arg_10_2)
	self.itemData_ = arg_10_1

	self.storeHeadInfoView_:SetData(arg_10_1)

	local var_10_0 = arg_10_1.id

	self.descText_.text = ItemTools.getItemDesc(arg_10_1.id)

	local var_10_1 = ItemCfg[var_10_0]
	local var_10_2 = false

	if ItemCfg[var_10_0].compose_id ~= 0 and var_10_1.decompose_id ~= 0 then
		self.btnController_:SetSelectedState("state3")
	elseif var_10_1.compose_id ~= 0 then
		self.btnController_:SetSelectedState("state1")
	elseif var_10_1.decompose_id ~= 0 then
		self.btnController_:SetSelectedState("state2")
	elseif ItemTools.isCanUseItem(var_10_0) then
		self.btnController_:SetSelectedState("state0")
	else
		var_10_2 = true
	end

	self.useBtnText_.text = var_10_1.sub_type == ItemConst.ITEM_SUB_TYPE.LIMIT_TIME_SKIN_ITEM and ItemTools.HasOwnAllLimitCardItems(var_10_0) and GetTips("TIP_EXCHANGE") or GetTips("TIP_USE")

	if var_10_2 then
		self.hideBtnController_:SetSelectedState("hide")
	else
		self.hideBtnController_:SetSelectedState("show")
	end

	if not arg_10_2 then
		self.selectInfoType_ = StoreConst.ITEM_INFO_TYPE.DESC
	end

	self:RefreshInfo()

	self.sourceList_ = ItemTools.GetItemSourceList(var_10_0)

	self.uiList_:StartScroll(#self.sourceList_)
end

function StoreItemInfo:RefreshInfo()
	if self.selectInfoType_ == StoreConst.ITEM_INFO_TYPE.DESC then
		self.switchBtnController_:SetSelectedState("desc")
	else
		self.switchBtnController_:SetSelectedState("source")
	end
end

function StoreItemInfo:IndexSourceItem(arg_12_1, arg_12_2)
	arg_12_2:SetData(self.sourceList_[arg_12_1])
end

function StoreItemInfo:CheckSelectItem()
	if ItemCfg[self.itemData_.id].sub_type == ItemConst.ITEM_SUB_TYPE.HERO_OPTIONAL_ONE or ItemCfg[self.itemData_.id].sub_type == ItemConst.ITEM_SUB_TYPE.HERO_OPTIONAL_MULTI and not _G.SkipTip.SkipExchangeHero2 then
		local var_13_0 = true

		for iter_13_0 = 1, #ItemCfg[self.itemData_.id].param do
			local var_13_1 = ItemCfg[self.itemData_.id].param[iter_13_0][1]

			var_13_1 = ItemCfg[ItemCfg[self.itemData_.id].param[iter_13_0][1]].hero_id or var_13_1

			if WeaponServantCfg[var_13_1] or SkinCfg[var_13_1] then
				var_13_0 = false

				break
			end

			if HeroCfg[var_13_1] == nil or HeroData:GetHeroOmegaNeedPiece(var_13_1) > 0 then
				var_13_0 = false

				break
			end
		end

		return var_13_0
	end
end

function StoreItemInfo:CheckHeroOptionalOne(arg_14_1, arg_14_2)
	local var_14_0 = 1

	if arg_14_1.sub_type == ItemConst.ITEM_SUB_TYPE.OPTIONAL_ITEM then
		JumpTools.OpenPageByJump("optionalItemSelect", {
			popItemInfo = {
				self.itemData_.id,
				self.itemData_.number,
				0,
				arg_14_2
			},
			selectNum = 1
		})
	end

	if arg_14_1.sub_type == ItemConst.ITEM_SUB_TYPE.OPTIONAL_ITEM_LIMIT_TIME or arg_14_1.sub_type == ItemConst.ITEM_SUB_TYPE.HERO_OPTIONAL_ONE then
		if self:CheckSelectItem() and not _G.SkipTip.SkipExchangeHero2 then
			ShowMessageBox({
				content = GetTips("CHOICEBOX_CHOSEN_ALL_MAX"),
				OkCallback = function()
					JumpTools.OpenPageByJump("optionalItemSelect", {
						noPop = true,
						popItemInfo = {
							self.itemData_.id,
							self.itemData_.number,
							0,
							arg_14_2
						},
						selectNum = var_14_0
					})
				end,
				ToggleCallback = function(arg_16_0)
					_G.SkipTip.SkipExchangeHero2 = arg_16_0
				end
			})
		else
			JumpTools.OpenPageByJump("optionalItemSelect", {
				popItemInfo = {
					self.itemData_.id,
					self.itemData_.number,
					0,
					arg_14_2
				},
				selectNum = 1,
				noPop = _G.SkipTip.SkipExchangeHero2
			})
		end
	end
end

function StoreItemInfo:CheckItemUse(arg_17_1, arg_17_2)
	if arg_17_1.sub_type == ItemConst.ITEM_SUB_TYPE.HERO_OPTIONAL_MULTI or arg_17_1.sub_type == ItemConst.ITEM_SUB_TYPE.OPTIONAL_ITEM_MULT then
		if self:CheckSelectItem() and not _G.SkipTip.SkipExchangeHero2 then
			ShowMessageBox({
				content = GetTips("CHOICEBOX_CHOSEN_ALL_MAX"),
				OkCallback = function()
					JumpTools.OpenPageByJump("optionalItemSelect", {
						selectNum = 1,
						popItemInfo = {
							self.itemData_.id,
							self.itemData_.number,
							0,
							arg_17_2
						},
						noPop = _G.SkipTip.SkipExchangeHero2
					})
				end,
				ToggleCallback = function(arg_19_0)
					_G.SkipTip.SkipExchangeHero2 = arg_19_0
				end
			})
		else
			JumpTools.OpenPageByJump("optionalItemSelect", {
				selectNum = 1,
				popItemInfo = {
					self.itemData_.id,
					self.itemData_.number,
					0,
					arg_17_2
				},
				noPop = _G.SkipTip.SkipExchangeHero2
			})
		end
	elseif arg_17_1.sub_type == ItemConst.ITEM_SUB_TYPE.BIRTHDAY_ITEM then
		self:UseStoryItem(function()
			manager.story:StartStory(BirthdayCfg[BirthdayCfg.get_id_list_by_commemorative_props_id[self.itemData_.id][1]].story_id)
		end)
	elseif arg_17_1.sub_type == ItemConst.ITEM_SUB_TYPE.STORY_ITEM then
		self:UseStoryItem(function()
			manager.story:StartStory(ItemCfg[self.itemData_.id].param[1])
		end)
	else
		JumpTools.OpenPageByJump("itemUse", {
			itemData = self.itemData_
		})
	end
end

function StoreItemInfo:UseStoryItem(arg_22_1)
	local var_22_0 = {}
	local var_22_1 = {
		id = self.itemData_.id
	}

	var_22_1.num = 1
	var_22_1.time_valid = self.itemData_.timeValid
	var_22_0.item_info = var_22_1
	var_22_0.use_list = {}

	CommonAction.TryToUseItemWitchCallback({
		var_22_0
	}, function(arg_23_0)
		arg_22_1()
	end)
end

return StoreItemInfo
