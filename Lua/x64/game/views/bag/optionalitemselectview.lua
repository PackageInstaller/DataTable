local var_0_0 = class("OptionalItemSelectView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Common/Pop/UIInquirepopup14_new01"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0:RefreshUI()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.okBtnController_ = arg_5_0.controllerEx_:GetController("btn")
	arg_5_0.tipsController_ = arg_5_0.controllerEx_:GetController("tips")
	arg_5_0.statusController_ = arg_5_0.controllerEx_:GetController("status")
	arg_5_0.itemQualityController_ = arg_5_0.itemCon_:GetController("quality")
	arg_5_0.heroPieceInfoController_ = arg_5_0.itemCon_:GetController("heroPiece")
	arg_5_0.heroPieceRomaController_ = arg_5_0.itemCon_:GetController("heroRoma")
	arg_5_0.heroPieceEmptyController_ = arg_5_0.itemCon_:GetController("heroPieceEmpty")
	arg_5_0.heroRomaController_ = arg_5_0.heroSelectCon_:GetController("roma")
	arg_5_0.heroOwnController_ = arg_5_0.heroSelectCon_:GetController("own")
	arg_5_0.heroTransController_ = arg_5_0.heroSelectCon_:GetController("trans")
	arg_5_0.heroSelectQualityController_ = arg_5_0.heroSelectCon_:GetController("quality")
	arg_5_0.weaponOwnController_ = arg_5_0.weaponSelectCon_:GetController("own")
	arg_5_0.weaponSelectQualityController_ = arg_5_0.weaponSelectCon_:GetController("quality")
	arg_5_0.notHaveItemList_ = {}
	arg_5_0.haveItemList_ = {}
	arg_5_0.heroInfo_ = {}
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.okBtn_, nil, function()
		if arg_6_0.selectInfo_ then
			if arg_6_0.itemCfg_.type == ItemConst.ITEM_TYPE.HERO_SKIN then
				if HeroTools.IsSkinUnlock(itemID) then
					ShowTips("SKIN_HAD_UNLOCKED")

					return
				end

				local var_7_0 = getTicketIDBySkinID(itemID)
				local var_7_1 = MaterialData:GetMaterialListById(var_7_0)

				if var_7_1 then
					for iter_7_0, iter_7_1 in pairs(var_7_1) do
						if iter_7_1 > 0 then
							ShowTips("SKIN_HAD_UNLOCKED")

							return
						end
					end
				end
			end

			local var_7_2 = ItemCfg[arg_6_0.selectInfo_.id]

			if not _G.SkipTip.SkipExchangeHero1 and not arg_6_0.params_.noPop and (var_7_2.type == ItemConst.ITEM_TYPE.HERO_PIECE or var_7_2.type == ItemConst.ITEM_TYPE.HERO) then
				local var_7_3 = HeroData:GetHeroOmegaNeedPiece(arg_6_0.selectHeroId_)
				local var_7_4 = HeroData:GetHeroData(arg_6_0.selectHeroId_).unlock == 0 and ItemTools.getItemNum(arg_6_0.selectInfo_.id) or 0
				local var_7_5 = (var_7_2.type == ItemConst.ITEM_TYPE.HERO_PIECE and var_7_4 + arg_6_0.slider_.value or arg_6_0.slider_.value * HeroTools.GetHeroRecoveryNum(arg_6_0.selectHeroId_)) - var_7_3
				local var_7_6 = var_7_2.type == ItemConst.ITEM_TYPE.HERO_PIECE and string.format(GetTips("CHOICEBOX_CHOSEN_OVERFLOW"), var_7_5) or GetTips("CHOICEBOX_CHOSEN_MAX")

				if var_7_5 > 0 then
					ShowMessageBox({
						content = var_7_6,
						OkCallback = function()
							CommonAction.TryToUseItem({
								{
									item_info = {
										id = arg_6_0.itemInfo_[1],
										num = arg_6_0.useNum_,
										time_valid = arg_6_0.itemInfo_[4]
									},
									use_list = {
										arg_6_0.trueIndex_
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
						id = arg_6_0.itemInfo_[1],
						num = arg_6_0.useNum_,
						time_valid = arg_6_0.itemInfo_[4]
					},
					use_list = {
						arg_6_0.trueIndex_
					}
				}
			})
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.lockBtn_, nil, function()
		ShowTips("ITEM_SELECTED")
	end)
	arg_6_0:AddBtnListener(arg_6_0.cancelBtn_, nil, function()
		JumpTools.Back()
	end)
	arg_6_0:AddBtnListener(arg_6_0.maskBtn_, nil, function()
		JumpTools.Back()
	end)
	arg_6_0:AddBtnListener(arg_6_0.subBtn_, nil, function()
		local var_13_0 = arg_6_0.slider_.value

		arg_6_0.slider_.value = var_13_0 - 1
	end)
	arg_6_0:AddBtnListener(arg_6_0.addBtn_, nil, function()
		local var_14_0 = arg_6_0.slider_.value

		arg_6_0.slider_.value = var_14_0 + 1
	end)
	arg_6_0:AddBtnListener(arg_6_0.itemBtn_, nil, function()
		if arg_6_0.isHero_ then
			if arg_6_0.isSelectedItemHave_ then
				JumpTools.OpenPageByJump("/newHero", {
					isEnter = true,
					hid = arg_6_0.selectHeroId_
				}, ViewConst.SYSTEM_ID.PLAYER_INFO)
			else
				JumpTools.OpenPageByJump("/heroPreviewMain", {
					isEnter = true,
					hid = arg_6_0.selectHeroId_
				})
			end
		elseif arg_6_0.selectInfo_ then
			ShowPopItem(POP_ITEM, {
				arg_6_0.selectInfo_.id
			})
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.heroBtn_, nil, function()
		if arg_6_0.isHero_ then
			if arg_6_0.isSelectedItemHave_ then
				JumpTools.OpenPageByJump("/newHero", {
					isEnter = true,
					hid = arg_6_0.selectHeroId_
				}, ViewConst.SYSTEM_ID.PLAYER_INFO)
			else
				JumpTools.OpenPageByJump("/heroPreviewMain", {
					isEnter = true,
					hid = arg_6_0.selectHeroId_
				})
			end
		elseif arg_6_0.selectInfo_ then
			ShowPopItem(POP_ITEM, {
				arg_6_0.selectInfo_.id
			})
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.weaponBtn_, nil, function()
		if not arg_6_0.selectInfo_ then
			return
		end

		if arg_6_0.isSelectedItemHave_ then
			local var_17_0 = ServantTools.GetWeaponShowData()
			local var_17_1 = ServantTools:GetServantList(nil, var_17_0)

			for iter_17_0, iter_17_1 in ipairs(var_17_1) do
				if iter_17_1.id == arg_6_0.selectInfo_.id then
					JumpTools.OpenPageByJump("/weaponServant", {
						uid = iter_17_1.uid
					})

					break
				end
			end
		else
			arg_6_0:Go("/showServantView", {
				state = "onlydetail",
				id = arg_6_0.selectInfo_.id
			})
		end
	end)
end

function var_0_0.SelectItem(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	if arg_18_0.selectInex_ == arg_18_3 and arg_18_0.isSelectedItemHave_ == arg_18_4 then
		return
	end

	if arg_18_0.lastSelectItem_ then
		arg_18_0.lastSelectItem_:RefreshSelectState(false)
	end

	arg_18_0.selectInfo_ = arg_18_1
	arg_18_0.selectInex_ = arg_18_3
	arg_18_0.isSelectedItemHave_ = arg_18_4
	arg_18_0.selectHeroId_ = ItemCfg[arg_18_1.id].hero_id or arg_18_1.id

	for iter_18_0, iter_18_1 in ipairs(arg_18_0.itemCfg_.param) do
		if arg_18_1.id == iter_18_1[1] then
			arg_18_0.trueIndex_ = iter_18_0

			break
		end
	end

	arg_18_0.lastSelectItem_ = arg_18_2

	arg_18_2:RefreshSelectState(true)

	if arg_18_0.isHero_ or arg_18_0.isHeroPiece_ then
		arg_18_0:RefreshHeroInfo()
	end

	arg_18_0:RefreshSelect()
end

function var_0_0.RefreshUI(arg_19_0)
	local var_19_0 = arg_19_0.params_.popItemInfo[1]
	local var_19_1 = ItemCfg[var_19_0]

	arg_19_0.itemInfo_ = var_19_1 and arg_19_0.params_.popItemInfo or arg_19_0.itemInfo_
	arg_19_0.useNum_ = var_19_1 and arg_19_0.params_.selectNum or arg_19_0.useNum_
	arg_19_0.itemCfg_ = var_19_1 or arg_19_0.itemCfg_
	arg_19_0.notHaveList_ = {}
	arg_19_0.haveList_ = {}

	for iter_19_0 = 1, #arg_19_0.itemCfg_.param do
		local var_19_2 = arg_19_0.itemCfg_.param[iter_19_0][1]
		local var_19_3 = ItemCfg[var_19_2]
		local var_19_4 = WeaponServantData:GetServantSByID(var_19_2)
		local var_19_5 = SkinCfg[var_19_2]
		local var_19_6 = var_19_3.hero_id or var_19_2
		local var_19_7 = HeroCfg[var_19_6]

		if not arg_19_0.isHero_ then
			arg_19_0.isHero_ = var_19_7 ~= nil
		end

		if not arg_19_0.isHeroPiece_ then
			arg_19_0.isHeroPiece_ = var_19_3.type == ItemConst.ITEM_TYPE.HERO_PIECE
		end

		if not arg_19_0.isWeapon_ then
			arg_19_0.isWeapon_ = WeaponServantCfg[var_19_2] ~= nil
		end

		if not arg_19_0.isSkin_ and not arg_19_0.isHero_ and not arg_19_0.isHeroPiece_ then
			arg_19_0.isSkin_ = var_19_5 ~= nil
		end

		if HeroTools.GetIsHide(var_19_2) or HeroTools.GetIsSkinHide(var_19_2) then
			-- block empty
		elseif var_19_7 and (HeroTools.GetHeroIsUnlock(var_19_6) or arg_19_0.isHeroPiece_ and HeroData:GetHeroList()[var_19_6].piece >= GameSetting.unlock_hero_need.value[HeroCfg[var_19_6].rare]) then
			table.insert(arg_19_0.haveList_, arg_19_0.itemCfg_.param[iter_19_0])
		elseif var_19_4 and next(var_19_4) then
			table.insert(arg_19_0.haveList_, arg_19_0.itemCfg_.param[iter_19_0])
		else
			table.insert(arg_19_0.notHaveList_, arg_19_0.itemCfg_.param[iter_19_0])
		end
	end

	arg_19_0:RefreshItemList(false)
	arg_19_0:RefreshItemList(true)
	arg_19_0:RefreshSelect()
	arg_19_0:RefreshSlider()
end

function var_0_0.RefreshItemList(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_1 and arg_20_0.haveList_ or arg_20_0.notHaveList_
	local var_20_1 = arg_20_1 and arg_20_0.haveItemList_ or arg_20_0.notHaveItemList_
	local var_20_2 = arg_20_1 and arg_20_0.haveContent_ or arg_20_0.notHaveContent_
	local var_20_3 = arg_20_1 and arg_20_0.haveTitle_ or arg_20_0.notHaveTitle_
	local var_20_4 = arg_20_0.itemCfg_.sub_type == ItemConst.ITEM_SUB_TYPE.OPTIONAL_ITEM_MULT or arg_20_0.itemCfg_.sub_type == ItemConst.ITEM_SUB_TYPE.OPTIONAL_ITEM

	if #var_20_0 > 0 then
		SetActive(var_20_2.gameObject, true)
		SetActive(var_20_3, not var_20_4)

		for iter_20_0, iter_20_1 in ipairs(var_20_0) do
			local var_20_5 = iter_20_1[1]
			local var_20_6 = iter_20_1[2] * arg_20_0.useNum_
			local var_20_7 = not HeroCfg[var_20_5] and SkinCfg[var_20_5] and HeroTools.GetHasOwnedSkin(var_20_5)
			local var_20_8 = clone(ItemTemplateData)

			var_20_8.id = var_20_5
			var_20_8.number = var_20_6
			var_20_8.ownedFlag = var_20_7
			var_20_8.selectStyle = arg_20_0.selectInfo_ and arg_20_0.selectInfo_.id == var_20_5

			local var_20_9 = var_20_1[iter_20_0]

			if var_20_9 == nil then
				local var_20_10 = Object.Instantiate(arg_20_0.itemGo_, var_20_2)

				var_20_9 = CommonRecommendItemView.New(var_20_10)

				table.insert(var_20_1, var_20_9)
			end

			function var_20_8.clickFun(arg_21_0)
				if var_20_7 then
					return
				end

				arg_20_0:SelectItem(arg_21_0, var_20_9, iter_20_0, arg_20_1)
			end

			function var_20_8.beginDragFun(arg_22_0, arg_22_1)
				arg_20_0.scrollRect_:OnBeginDrag(arg_22_1)
			end

			function var_20_8.dragFun(arg_23_0, arg_23_1)
				arg_20_0.scrollRect_:OnDrag(arg_23_1)
			end

			function var_20_8.endDragFun(arg_24_0, arg_24_1)
				arg_20_0.scrollRect_:OnEndDrag(arg_24_1)
			end

			var_20_9:SetData(var_20_8)
			var_20_9:RefreshRecommend()
			SetActive(var_20_9.gameObject_, true)
		end

		for iter_20_2 = #var_20_0 + 1, #var_20_1 do
			SetActive(var_20_1[iter_20_2].gameObject_, false)
		end
	else
		SetActive(var_20_2.gameObject, false)
		SetActive(var_20_3, false)
	end
end

function var_0_0.RefreshSelect(arg_25_0)
	arg_25_0.okBtnController_:SetSelectedState(tostring(arg_25_0.selectInfo_ ~= nil))

	local var_25_0 = arg_25_0.selectInfo_ and arg_25_0:GetServantRecommend(arg_25_0.selectInfo_.id)

	SetActive(arg_25_0.recommendGo_, var_25_0 ~= nil)

	if arg_25_0.selectInfo_ then
		if arg_25_0.isHero_ and not arg_25_0.isHeroPiece_ then
			arg_25_0.nameText_.text = HeroTools.GetHeroFullName(arg_25_0.selectHeroId_)
			arg_25_0.heroIcon_.sprite = HeroTools.GetHeadSprite(arg_25_0.selectHeroId_)

			arg_25_0.heroSelectQualityController_:SetSelectedState(HeroCfg[arg_25_0.selectHeroId_].rare + 2)

			if arg_25_0.isSelectedItemHave_ then
				SurpassTools.ChangeIconStarSpirte(arg_25_0.heroNodeIcon_, arg_25_0.heroInfo_.nowStar)
				arg_25_0.heroRomaController_:SetSelectedState(tostring(not string.isNullOrEmpty(arg_25_0.heroInfo_.nowRoma)))

				arg_25_0.heroNodeLv_.text = arg_25_0.heroInfo_.nowRoma

				SurpassTools.ChangeIconStarSpirte(arg_25_0.heroNextNodeIcon_, arg_25_0.heroInfo_.nextStar)

				arg_25_0.heroNeedNum_.text = arg_25_0.heroInfo_.needNum
				arg_25_0.heroPieceIcon_.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.HeroPiece.path .. arg_25_0.selectHeroId_)
				arg_25_0.heroTransNum_.text = HeroTools.GetHeroRecoveryNum(arg_25_0.selectHeroId_)
			end

			arg_25_0.statusController_:SetSelectedState("slectHead")
			arg_25_0.heroOwnController_:SetSelectedState(tostring(arg_25_0.isSelectedItemHave_))
			arg_25_0.heroTransController_:SetSelectedState(tostring(arg_25_0.isSelectedItemHave_))
		elseif arg_25_0.isWeapon_ then
			local var_25_1 = arg_25_0:GetServantRecommend(arg_25_0.selectInfo_.id)

			arg_25_0.weaponNameText_.text = ItemCfg[arg_25_0.selectInfo_.id].name

			if var_25_1 then
				arg_25_0.recommendIcon_.sprite = HeroTools.GetSmallHeadSprite(var_25_1)
				arg_25_0.recommendHeroName_.text = HeroCfg[var_25_1].name
			end

			arg_25_0.weaponSelectQualityController_:SetSelectedState(tostring(ItemCfg[arg_25_0.selectInfo_.id].rare))

			arg_25_0.servantIcon_.sprite = ItemTools.getItemSprite(arg_25_0.selectInfo_.id)

			local var_25_2 = WeaponServantData:GetServantSByID(arg_25_0.selectInfo_.id) or {}
			local var_25_3 = 0
			local var_25_4 = 0

			for iter_25_0, iter_25_1 in pairs(var_25_2) do
				var_25_3 = var_25_3 + 1

				local var_25_5 = WeaponServantData:GetServantDataByUID(iter_25_0)

				if var_25_5 then
					var_25_4 = math.max(var_25_4, var_25_5.stage)
				end
			end

			arg_25_0.weaponNumText_.text = var_25_3
			arg_25_0.maxWeaponLevelText_.text = var_25_4

			arg_25_0.statusController_:SetSelectedState("slectWeapon")
			arg_25_0.weaponOwnController_:SetSelectedState(tostring(var_25_3 > 0))
		elseif arg_25_0.isSkin_ then
			arg_25_0.nameText_.text = ItemTools.getItemName(arg_25_0.selectInfo_.id)
			arg_25_0.heroIcon_.sprite = HeroTools.GetHeadSprite(arg_25_0.selectInfo_.id)

			arg_25_0.statusController_:SetSelectedState("slectHead")
			arg_25_0.heroOwnController_:SetSelectedState("false")
			arg_25_0.heroTransController_:SetSelectedState("false")
			arg_25_0.heroSelectQualityController_:SetSelectedState(ItemCfg[arg_25_0.selectInfo_.id].rare)
		else
			arg_25_0.itemIconImage_.sprite = ItemTools.getItemSprite(arg_25_0.selectInfo_.id)
			arg_25_0.itemNameText_.text = ItemTools.getItemName(arg_25_0.selectInfo_.id)
			arg_25_0.itemNumText_.text = ItemTools.getItemNum(arg_25_0.selectInfo_.id)

			arg_25_0.itemQualityController_:SetSelectedState(tostring(ItemCfg[arg_25_0.selectInfo_.id].rare))

			if arg_25_0.isSelectedItemHave_ and arg_25_0.isHeroPiece_ then
				arg_25_0.heroPieceRoma_.text = arg_25_0.heroInfo_.nowRoma

				arg_25_0.heroPieceRomaController_:SetSelectedState(tostring(not string.isNullOrEmpty(arg_25_0.heroInfo_.nowRoma)))
				SurpassTools.ChangeIconStarSpirte(arg_25_0.heroPieceNowNodeIcon_, arg_25_0.heroInfo_.nowStar)
				SurpassTools.ChangeIconStarSpirte(arg_25_0.heroPieceNextNodeIcon_, arg_25_0.heroInfo_.nextStar)

				arg_25_0.heroPieceNeedNum_.text = arg_25_0.heroInfo_.needNum
			end

			arg_25_0.statusController_:SetSelectedState("selecIMulti")
			arg_25_0.heroPieceInfoController_:SetSelectedState(tostring(arg_25_0.isSelectedItemHave_ and arg_25_0.isHeroPiece_))
			arg_25_0.heroPieceEmptyController_:SetSelectedState(tostring(not arg_25_0.isSelectedItemHave_ and arg_25_0.isHeroPiece_))
		end
	else
		arg_25_0.statusController_:SetSelectedState((arg_25_0.isHero_ and not arg_25_0.isHeroPiece_ or arg_25_0.isWeapon_ or arg_25_0.isSkin_) and "unselctOne" or "unselctIMulti")
	end
end

function var_0_0.RefreshSlider(arg_26_0)
	local var_26_0 = arg_26_0.itemCfg_.sub_type == ItemConst.ITEM_SUB_TYPE.OPTIONAL_ITEM or ItemTools.getItemNum(arg_26_0.itemInfo_[1]) == 1

	arg_26_0.slider_.minValue = var_26_0 and 0 or arg_26_0.useNum_
	arg_26_0.slider_.maxValue = var_26_0 and 1 or ItemTools.getItemNum(arg_26_0.itemInfo_[1])
	arg_26_0.slider_.value = var_26_0 and 1 or arg_26_0.params_.selectNum
	arg_26_0.useNumText_.text = string.format(GetTips("CHOICE_LOOT_CONSUME_NUM"), arg_26_0.params_.selectNum)
	arg_26_0.subBtn_.interactable = not var_26_0 and arg_26_0.useNum_ > 1 or false
	arg_26_0.addBtn_.interactable = not var_26_0 and arg_26_0.useNum_ < ItemTools.getItemNum(arg_26_0.itemInfo_[1]) or false

	arg_26_0.slider_.onValueChanged:AddListener(function(arg_27_0)
		arg_26_0.subBtn_.interactable = not var_26_0 and arg_27_0 > 1 or false
		arg_26_0.addBtn_.interactable = not var_26_0 and arg_27_0 < ItemTools.getItemNum(arg_26_0.itemInfo_[1]) or false

		if arg_27_0 < 1 then
			arg_26_0.slider_.value = 1
		else
			arg_26_0.useNum_ = arg_27_0
			arg_26_0.useNumText_.text = string.format(GetTips("CHOICE_LOOT_CONSUME_NUM"), arg_26_0.useNum_)

			arg_26_0:RefreshItemNum()
		end
	end)
end

function var_0_0.RefreshItemNum(arg_28_0)
	for iter_28_0, iter_28_1 in ipairs(arg_28_0.haveList_) do
		arg_28_0.haveItemList_[iter_28_0]:SetBottomAmountText(arg_28_0.useNum_ * iter_28_1[2])
	end

	for iter_28_2, iter_28_3 in ipairs(arg_28_0.notHaveList_) do
		arg_28_0.notHaveItemList_[iter_28_2]:SetBottomAmountText(arg_28_0.useNum_ * iter_28_3[2])
	end
end

function var_0_0.RefreshHeroInfo(arg_29_0)
	arg_29_0.heroInfo_ = {}

	local var_29_0 = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT):GetHeroData(arg_29_0.selectHeroId_).star
	local var_29_1 = HeroStarCfg[var_29_0]

	arg_29_0.heroInfo_.nowStar = var_29_1.star
	arg_29_0.heroInfo_.nowRoma = SurpassTools.GetSmallStageShow(var_29_1.id)

	local var_29_2, var_29_3 = HeroData:GetHeroNextSurpassNeedPiece(arg_29_0.selectHeroId_)

	arg_29_0.heroInfo_.nextStar = var_29_3
	arg_29_0.heroInfo_.needNum = var_29_2
end

function var_0_0.GetServantRecommend(arg_30_0, arg_30_1)
	local var_30_0 = string.format(GetTips("TIP_SELECT"), ItemTools.getItemName(arg_30_1))
	local var_30_1 = ItemCfg[arg_30_1]

	if var_30_1 and var_30_1.type == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
		local var_30_2 = WeaponServantCfg[arg_30_1].effect[1]
		local var_30_3 = 0

		if var_30_2 > 0 then
			var_30_3 = WeaponEffectCfg[var_30_2].spec_char[1]
		end

		if var_30_3 ~= nil and var_30_3 > 0 then
			return var_30_3
		end
	end
end

function var_0_0.OnTryToUseItem(arg_31_0, arg_31_1, arg_31_2)
	if isSuccess(arg_31_1.result) then
		JumpTools.Back()
		getReward(arg_31_1.drop_list)
	else
		ShowTips(arg_31_1.result)
	end
end

function var_0_0.OnExit(arg_32_0)
	arg_32_0.selectInex_ = 0
	arg_32_0.lastSelectItem_ = nil
	arg_32_0.selectInfo_ = nil
	arg_32_0.trueIndex_ = 0
	arg_32_0.scrollRect_.verticalNormalizedPosition = 1
	arg_32_0.isHero_ = false
	arg_32_0.isWeapon_ = false
	arg_32_0.isHeroPiece_ = false
	arg_32_0.isSkin_ = false

	arg_32_0.slider_.onValueChanged:RemoveAllListeners()
end

function var_0_0.Dispose(arg_33_0)
	for iter_33_0, iter_33_1 in ipairs(arg_33_0.notHaveItemList_) do
		iter_33_1:Dispose()
	end

	arg_33_0.notHaveItemList_ = nil

	for iter_33_2, iter_33_3 in ipairs(arg_33_0.haveItemList_) do
		iter_33_3:Dispose()
	end

	arg_33_0.haveItemList_ = nil

	var_0_0.super.Dispose(arg_33_0)
end

return var_0_0
