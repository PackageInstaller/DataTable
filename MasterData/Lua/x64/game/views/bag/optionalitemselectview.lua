local OptionalItemSelectView = class("OptionalItemSelectView", ReduxView)

function OptionalItemSelectView:UIName()
	return "Widget/Common/Pop/UIInquirepopup14_new01"
end

function OptionalItemSelectView:UIParent()
	return manager.ui.uiPop.transform
end

function OptionalItemSelectView:Init()
	self:InitUI()
	self:AddUIListener()
end

function OptionalItemSelectView:OnEnter()
	self:RefreshUI()
end

function OptionalItemSelectView:InitUI()
	self:BindCfgUI()

	self.okBtnController_ = self.controllerEx_:GetController("btn")
	self.tipsController_ = self.controllerEx_:GetController("tips")
	self.statusController_ = self.controllerEx_:GetController("status")
	self.itemQualityController_ = self.itemCon_:GetController("quality")
	self.heroPieceInfoController_ = self.itemCon_:GetController("heroPiece")
	self.heroPieceRomaController_ = self.itemCon_:GetController("heroRoma")
	self.heroPieceEmptyController_ = self.itemCon_:GetController("heroPieceEmpty")
	self.heroRomaController_ = self.heroSelectCon_:GetController("roma")
	self.heroOwnController_ = self.heroSelectCon_:GetController("own")
	self.heroTransController_ = self.heroSelectCon_:GetController("trans")
	self.heroSelectQualityController_ = self.heroSelectCon_:GetController("quality")
	self.weaponOwnController_ = self.weaponSelectCon_:GetController("own")
	self.weaponSelectQualityController_ = self.weaponSelectCon_:GetController("quality")
	self.notHaveItemList_ = {}
	self.haveItemList_ = {}
	self.heroInfo_ = {}
end

function OptionalItemSelectView:AddUIListener()
	self:AddBtnListener(self.okBtn_, nil, function()
		if self.selectInfo_ then
			if self.itemCfg_.type == ItemConst.ITEM_TYPE.HERO_SKIN then
				if HeroTools.IsSkinUnlock(itemID) then
					ShowTips("SKIN_HAD_UNLOCKED")

					return
				end

				local var_7_0 = MaterialData:GetMaterialListById((getTicketIDBySkinID(itemID)))

				if var_7_0 then
					for iter_7_0, iter_7_1 in pairs(var_7_0) do
						if iter_7_1 > 0 then
							ShowTips("SKIN_HAD_UNLOCKED")

							return
						end
					end
				end
			end

			local var_7_1 = ItemCfg[self.selectInfo_.id]

			if not _G.SkipTip.SkipExchangeHero1 and not self.params_.noPop and (var_7_1.type == ItemConst.ITEM_TYPE.HERO_PIECE or var_7_1.type == ItemConst.ITEM_TYPE.HERO) then
				local var_7_3 = var_7_1.type == ItemConst.ITEM_TYPE.HERO_PIECE and string.format(GetTips("CHOICEBOX_CHOSEN_OVERFLOW"), ((var_7_1.type == ItemConst.ITEM_TYPE.HERO_PIECE or nil) and ((HeroData:GetHeroData(self.selectHeroId_).unlock == 0 and ItemTools.getItemNum(self.selectInfo_.id) or 0) + self.slider_.value or self.slider_.value * HeroTools.GetHeroRecoveryNum(self.selectHeroId_))) - HeroData:GetHeroOmegaNeedPiece(self.selectHeroId_)) or GetTips("CHOICEBOX_CHOSEN_MAX")

				if ((var_7_1.type == ItemConst.ITEM_TYPE.HERO_PIECE or nil) and ((HeroData:GetHeroData(self.selectHeroId_).unlock == 0 and ItemTools.getItemNum(self.selectInfo_.id) or 0) + self.slider_.value or self.slider_.value * HeroTools.GetHeroRecoveryNum(self.selectHeroId_))) - HeroData:GetHeroOmegaNeedPiece(self.selectHeroId_) > 0 then
					ShowMessageBox({
						content = var_7_3,
						OkCallback = function()
							CommonAction.TryToUseItem({
								{
									item_info = {
										id = self.itemInfo_[1],
										num = self.useNum_,
										time_valid = self.itemInfo_[4]
									},
									use_list = {
										self.trueIndex_
									}
								}
							})
						end,
						ToggleCallback = function(arg_9_0)
							_G.SkipTip.SkipExchangeHero1 = arg_9_0
						end
					})

					return
				end
			end

			CommonAction.TryToUseItem({
				{
					item_info = {
						id = self.itemInfo_[1],
						num = self.useNum_,
						time_valid = self.itemInfo_[4]
					},
					use_list = {
						self.trueIndex_
					}
				}
			})
		end
	end)
	self:AddBtnListener(self.lockBtn_, nil, function()
		ShowTips("ITEM_SELECTED")
	end)
	self:AddBtnListener(self.cancelBtn_, nil, function()
		JumpTools.Back()
	end)
	self:AddBtnListener(self.maskBtn_, nil, function()
		JumpTools.Back()
	end)
	self:AddBtnListener(self.subBtn_, nil, function()
		self.slider_.value = self.slider_.value - 1
	end)
	self:AddBtnListener(self.addBtn_, nil, function()
		self.slider_.value = self.slider_.value + 1
	end)
	self:AddBtnListener(self.itemBtn_, nil, function()
		if self.isHero_ then
			if self.isSelectedItemHave_ then
				JumpTools.OpenPageByJump("/newHero", {
					isEnter = true,
					hid = self.selectHeroId_
				}, ViewConst.SYSTEM_ID.PLAYER_INFO)
			else
				JumpTools.OpenPageByJump("/heroPreviewMain", {
					isEnter = true,
					hid = self.selectHeroId_
				})
			end
		elseif self.selectInfo_ then
			ShowPopItem(POP_ITEM, {
				self.selectInfo_.id
			})
		end
	end)
	self:AddBtnListener(self.heroBtn_, nil, function()
		if self.isHero_ then
			if self.isSelectedItemHave_ then
				JumpTools.OpenPageByJump("/newHero", {
					isEnter = true,
					hid = self.selectHeroId_
				}, ViewConst.SYSTEM_ID.PLAYER_INFO)
			else
				JumpTools.OpenPageByJump("/heroPreviewMain", {
					isEnter = true,
					hid = self.selectHeroId_
				})
			end
		elseif self.selectInfo_ then
			ShowPopItem(POP_ITEM, {
				self.selectInfo_.id
			})
		end
	end)
	self:AddBtnListener(self.weaponBtn_, nil, function()
		if not self.selectInfo_ then
			return
		end

		if self.isSelectedItemHave_ then
			for iter_17_0, iter_17_1 in ipairs((ServantTools:GetServantList(nil, (ServantTools.GetWeaponShowData())))) do
				if iter_17_1.id == self.selectInfo_.id then
					JumpTools.OpenPageByJump("/weaponServant", {
						uid = iter_17_1.uid
					})

					break
				end
			end
		else
			self:Go("/showServantView", {
				state = "onlydetail",
				id = self.selectInfo_.id
			})
		end
	end)
end

function OptionalItemSelectView:SelectItem(arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	if self.selectInex_ == arg_18_3 and self.isSelectedItemHave_ == arg_18_4 then
		return
	end

	if self.lastSelectItem_ then
		self.lastSelectItem_:RefreshSelectState(false)
	end

	self.selectInfo_ = arg_18_1
	self.selectInex_ = arg_18_3
	self.isSelectedItemHave_ = arg_18_4
	self.selectHeroId_ = ItemCfg[arg_18_1.id].hero_id or arg_18_1.id

	for iter_18_0, iter_18_1 in ipairs(self.itemCfg_.param) do
		if arg_18_1.id == iter_18_1[1] then
			self.trueIndex_ = iter_18_0

			break
		end
	end

	self.lastSelectItem_ = arg_18_2

	arg_18_2:RefreshSelectState(true)

	if self.isHero_ or self.isHeroPiece_ then
		self:RefreshHeroInfo()
	end

	self:RefreshSelect()
end

function OptionalItemSelectView:RefreshUI()
	local var_19_0 = ItemCfg[self.params_.popItemInfo[1]]

	if ItemCfg[self.params_.popItemInfo[1]] then
		self.itemInfo_ = self.params_.popItemInfo or self.itemInfo_
	end

	if var_19_0 then
		self.useNum_ = self.params_.selectNum or self.useNum_
	end

	self.itemCfg_ = var_19_0 or self.itemCfg_
	self.notHaveList_ = {}
	self.haveList_ = {}

	for iter_19_0 = 1, #self.itemCfg_.param do
		local var_19_1 = self.itemCfg_.param[iter_19_0][1]
		local var_19_2 = ItemCfg[self.itemCfg_.param[iter_19_0][1]]
		local var_19_3 = WeaponServantData:GetServantSByID(self.itemCfg_.param[iter_19_0][1])
		local var_19_4 = ItemCfg[self.itemCfg_.param[iter_19_0][1]].hero_id or var_19_1
		local var_19_5 = HeroCfg[var_19_4]

		self.isHero_ = self.isHero_ or var_19_5 ~= nil
		self.isHeroPiece_ = self.isHeroPiece_ or var_19_2.type == ItemConst.ITEM_TYPE.HERO_PIECE
		self.isWeapon_ = self.isWeapon_ or WeaponServantCfg[var_19_1] ~= nil

		if not self.isSkin_ and not self.isHero_ and not self.isHeroPiece_ then
			self.isSkin_ = SkinCfg[self.itemCfg_.param[iter_19_0][1]] ~= nil
		end

		if HeroTools.GetIsHide(var_19_1) or HeroTools.GetIsSkinHide(var_19_1) then
			-- block empty
		elseif var_19_5 and (HeroTools.GetHeroIsUnlock(var_19_4) or self.isHeroPiece_ and HeroData:GetHeroList()[var_19_4].piece >= GameSetting.unlock_hero_need.value[HeroCfg[var_19_4].rare]) then
			table.insert(self.haveList_, self.itemCfg_.param[iter_19_0])
		elseif var_19_3 and next(var_19_3) then
			table.insert(self.haveList_, self.itemCfg_.param[iter_19_0])
		else
			table.insert(self.notHaveList_, self.itemCfg_.param[iter_19_0])
		end
	end

	self:RefreshItemList(false)
	self:RefreshItemList(true)
	self:RefreshSelect()
	self:RefreshSlider()
end

function OptionalItemSelectView:RefreshItemList(arg_20_1)
	local var_20_0

	if arg_20_1 then
		var_20_0 = self.haveList_ or self.notHaveList_

		local var_20_1

		if arg_20_1 then
			var_20_1 = self.haveItemList_ or self.notHaveItemList_

			local var_20_2

			if arg_20_1 then
				var_20_2 = self.haveContent_ or self.notHaveContent_

				local var_20_3

				if arg_20_1 then
					var_20_3 = self.haveTitle_ or self.notHaveTitle_
				end
			end
		end
	end

	if #var_20_0 > 0 then
		SetActive(var_20_2.gameObject, true)
		SetActive(var_20_3, not (self.itemCfg_.sub_type == ItemConst.ITEM_SUB_TYPE.OPTIONAL_ITEM_MULT or self.itemCfg_.sub_type == ItemConst.ITEM_SUB_TYPE.OPTIONAL_ITEM))

		for iter_20_0, iter_20_1 in ipairs(var_20_0) do
			local var_20_4 = iter_20_1[1]
			local var_20_5 = iter_20_1[2] * self.useNum_
			local var_20_6

			if not HeroCfg[iter_20_1[1]] then
				var_20_6 = SkinCfg[var_20_4]

				if SkinCfg[var_20_4] then
					var_20_6 = HeroTools.GetHasOwnedSkin(var_20_4)
				end
			else
				var_20_6 = false
			end

			local var_20_7 = clone(ItemTemplateData)

			var_20_7.id = var_20_4
			var_20_7.number = var_20_5
			var_20_7.ownedFlag = var_20_6
			var_20_7.selectStyle = self.selectInfo_ and self.selectInfo_.id == var_20_4

			local var_20_8 = var_20_1[iter_20_0]

			if var_20_1[iter_20_0] == nil then
				var_20_8 = CommonRecommendItemView.New((Object.Instantiate(self.itemGo_, var_20_2)))

				table.insert(var_20_1, var_20_8)
			end

			function var_20_7.clickFun(arg_21_0)
				if var_20_6 then
					return
				end

				self:SelectItem(arg_21_0, var_20_8, iter_20_0, arg_20_1)
			end

			function var_20_7.beginDragFun(arg_22_0, arg_22_1)
				self.scrollRect_:OnBeginDrag(arg_22_1)
			end

			function var_20_7.dragFun(arg_23_0, arg_23_1)
				self.scrollRect_:OnDrag(arg_23_1)
			end

			function var_20_7.endDragFun(arg_24_0, arg_24_1)
				self.scrollRect_:OnEndDrag(arg_24_1)
			end

			var_20_8:SetData(var_20_7)
			var_20_8:RefreshRecommend()
			SetActive(var_20_8.gameObject_, true)
		end

		for iter_20_2 = #var_20_0 + 1, #var_20_1 do
			SetActive(var_20_1[iter_20_2].gameObject_, false)
		end
	else
		SetActive(var_20_2.gameObject, false)
		SetActive(var_20_3, false)
	end
end

function OptionalItemSelectView:RefreshSelect()
	self.okBtnController_:SetSelectedState(tostring(self.selectInfo_ ~= nil))
	SetActive(self.recommendGo_, (self.selectInfo_ and self:GetServantRecommend(self.selectInfo_.id)) ~= nil)

	if self.selectInfo_ then
		if self.isHero_ and not self.isHeroPiece_ then
			self.nameText_.text = HeroTools.GetHeroFullName(self.selectHeroId_)
			self.heroIcon_.sprite = HeroTools.GetHeadSprite(self.selectHeroId_)

			self.heroSelectQualityController_:SetSelectedState(HeroCfg[self.selectHeroId_].rare + 2)

			if self.isSelectedItemHave_ then
				SurpassTools.ChangeIconStarSpirte(self.heroNodeIcon_, self.heroInfo_.nowStar)
				self.heroRomaController_:SetSelectedState(tostring(not string.isNullOrEmpty(self.heroInfo_.nowRoma)))

				self.heroNodeLv_.text = self.heroInfo_.nowRoma

				SurpassTools.ChangeIconStarSpirte(self.heroNextNodeIcon_, self.heroInfo_.nextStar)

				self.heroNeedNum_.text = self.heroInfo_.needNum
				self.heroPieceIcon_.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.HeroPiece.path .. self.selectHeroId_)
				self.heroTransNum_.text = HeroTools.GetHeroRecoveryNum(self.selectHeroId_)
			end

			self.statusController_:SetSelectedState("slectHead")
			self.heroOwnController_:SetSelectedState(tostring(self.isSelectedItemHave_))
			self.heroTransController_:SetSelectedState(tostring(self.isSelectedItemHave_))
		elseif self.isWeapon_ then
			local var_25_0 = self:GetServantRecommend(self.selectInfo_.id)

			self.weaponNameText_.text = ItemCfg[self.selectInfo_.id].name

			if var_25_0 then
				self.recommendIcon_.sprite = HeroTools.GetSmallHeadSprite(var_25_0)
				self.recommendHeroName_.text = HeroCfg[var_25_0].name
			end

			self.weaponSelectQualityController_:SetSelectedState(tostring(ItemCfg[self.selectInfo_.id].rare))

			self.servantIcon_.sprite = ItemTools.getItemSprite(self.selectInfo_.id)

			local var_25_1 = 0
			local var_25_2 = 0

			for iter_25_0, iter_25_1 in pairs(WeaponServantData:GetServantSByID(self.selectInfo_.id) or {}) do
				var_25_1 = var_25_1 + 1

				local var_25_3 = WeaponServantData:GetServantDataByUID(iter_25_0)

				if var_25_3 then
					var_25_2 = math.max(var_25_2, var_25_3.stage)
				end
			end

			self.weaponNumText_.text = var_25_1
			self.maxWeaponLevelText_.text = var_25_2

			self.statusController_:SetSelectedState("slectWeapon")
			self.weaponOwnController_:SetSelectedState(tostring(var_25_1 > 0))
		elseif self.isSkin_ then
			self.nameText_.text = ItemTools.getItemName(self.selectInfo_.id)
			self.heroIcon_.sprite = HeroTools.GetHeadSprite(self.selectInfo_.id)

			self.statusController_:SetSelectedState("slectHead")
			self.heroOwnController_:SetSelectedState("false")
			self.heroTransController_:SetSelectedState("false")
			self.heroSelectQualityController_:SetSelectedState(ItemCfg[self.selectInfo_.id].rare)
		else
			self.itemIconImage_.sprite = ItemTools.getItemSprite(self.selectInfo_.id)
			self.itemNameText_.text = ItemTools.getItemName(self.selectInfo_.id)
			self.itemNumText_.text = ItemTools.getItemNum(self.selectInfo_.id)

			self.itemQualityController_:SetSelectedState(tostring(ItemCfg[self.selectInfo_.id].rare))

			if self.isSelectedItemHave_ and self.isHeroPiece_ then
				self.heroPieceRoma_.text = self.heroInfo_.nowRoma

				self.heroPieceRomaController_:SetSelectedState(tostring(not string.isNullOrEmpty(self.heroInfo_.nowRoma)))
				SurpassTools.ChangeIconStarSpirte(self.heroPieceNowNodeIcon_, self.heroInfo_.nowStar)
				SurpassTools.ChangeIconStarSpirte(self.heroPieceNextNodeIcon_, self.heroInfo_.nextStar)

				self.heroPieceNeedNum_.text = self.heroInfo_.needNum
			end

			self.statusController_:SetSelectedState("selecIMulti")
			self.heroPieceInfoController_:SetSelectedState(tostring(self.isSelectedItemHave_ and self.isHeroPiece_))
			self.heroPieceEmptyController_:SetSelectedState(tostring(not self.isSelectedItemHave_ and self.isHeroPiece_))
		end
	else
		self.statusController_:SetSelectedState((self.isHero_ and not self.isHeroPiece_ or self.isWeapon_ or self.isSkin_) and "unselctOne" or "unselctIMulti")
	end
end

function OptionalItemSelectView:RefreshSlider()
	local var_26_0 = self.itemCfg_.sub_type == ItemConst.ITEM_SUB_TYPE.OPTIONAL_ITEM or ItemTools.getItemNum(self.itemInfo_[1]) == 1

	self.slider_.minValue = var_26_0 and 0 or self.useNum_
	self.slider_.maxValue = var_26_0 and 1 or ItemTools.getItemNum(self.itemInfo_[1])
	self.slider_.value = var_26_0 and 1 or self.params_.selectNum
	self.useNumText_.text = string.format(GetTips("CHOICE_LOOT_CONSUME_NUM"), self.params_.selectNum)
	self.subBtn_.interactable = not var_26_0 and self.useNum_ > 1 or false
	self.addBtn_.interactable = not var_26_0 and self.useNum_ < ItemTools.getItemNum(self.itemInfo_[1]) or false

	self.slider_.onValueChanged:AddListener(function(arg_27_0)
		self.subBtn_.interactable = not var_26_0 and arg_27_0 > 1 or false
		self.addBtn_.interactable = not var_26_0 and arg_27_0 < ItemTools.getItemNum(self.itemInfo_[1]) or false

		if arg_27_0 < 1 then
			self.slider_.value = 1
		else
			self.useNum_ = arg_27_0
			self.useNumText_.text = string.format(GetTips("CHOICE_LOOT_CONSUME_NUM"), self.useNum_)

			self:RefreshItemNum()
		end
	end)
end

function OptionalItemSelectView:RefreshItemNum()
	for iter_28_0, iter_28_1 in ipairs(self.haveList_) do
		self.haveItemList_[iter_28_0]:SetBottomAmountText(self.useNum_ * iter_28_1[2])
	end

	for iter_28_2, iter_28_3 in ipairs(self.notHaveList_) do
		self.notHaveItemList_[iter_28_2]:SetBottomAmountText(self.useNum_ * iter_28_3[2])
	end
end

function OptionalItemSelectView:RefreshHeroInfo()
	self.heroInfo_ = {}

	local var_29_0 = HeroStarCfg[HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT):GetHeroData(self.selectHeroId_).star]

	self.heroInfo_.nowStar = var_29_0.star
	self.heroInfo_.nowRoma = SurpassTools.GetSmallStageShow(var_29_0.id)

	local var_29_1, var_29_2 = HeroData:GetHeroNextSurpassNeedPiece(self.selectHeroId_)

	self.heroInfo_.nextStar = var_29_2
	self.heroInfo_.needNum = var_29_1
end

function OptionalItemSelectView:GetServantRecommend(arg_30_1)
	local var_30_0 = string.format(GetTips("TIP_SELECT"), ItemTools.getItemName(arg_30_1))

	if ItemCfg[arg_30_1] and ItemCfg[arg_30_1].type == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
		local var_30_1 = 0

		if WeaponServantCfg[arg_30_1].effect[1] > 0 then
			var_30_1 = WeaponEffectCfg[WeaponServantCfg[arg_30_1].effect[1]].spec_char[1]
		end

		if var_30_1 ~= nil and var_30_1 > 0 then
			return var_30_1
		end
	end
end

function OptionalItemSelectView:OnTryToUseItem(arg_31_1, arg_31_2)
	if isSuccess(arg_31_1.result) then
		JumpTools.Back()
		getReward(arg_31_1.drop_list)
	else
		ShowTips(arg_31_1.result)
	end
end

function OptionalItemSelectView:OnExit()
	self.selectInex_ = 0
	self.lastSelectItem_ = nil
	self.selectInfo_ = nil
	self.trueIndex_ = 0
	self.scrollRect_.verticalNormalizedPosition = 1
	self.isHero_ = false
	self.isWeapon_ = false
	self.isHeroPiece_ = false
	self.isSkin_ = false

	self.slider_.onValueChanged:RemoveAllListeners()
end

function OptionalItemSelectView:Dispose()
	for iter_33_0, iter_33_1 in ipairs(self.notHaveItemList_) do
		iter_33_1:Dispose()
	end

	self.notHaveItemList_ = nil

	for iter_33_2, iter_33_3 in ipairs(self.haveItemList_) do
		iter_33_3:Dispose()
	end

	self.haveItemList_ = nil

	OptionalItemSelectView.super.Dispose(self)
end

return OptionalItemSelectView
