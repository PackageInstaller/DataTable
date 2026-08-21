local var_0_0 = class("IdolTaskItemSelectView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Common/Pop/UIInquirepopup14_new02"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0.rank_ = arg_4_0.params_.rank

	local var_4_0 = IdolTraineeRewardRankCfg[arg_4_0.rank_]

	arg_4_0.dataList_ = var_4_0.reward
	arg_4_0.selectDic_ = {}
	arg_4_0.selectNum_ = 0
	arg_4_0.maxNum_ = var_4_0.num

	arg_4_0:RefreshUI()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.okBtnController_ = arg_5_0.controllerEx_:GetController("btn")
	arg_5_0.tipsController_ = arg_5_0.controllerEx_:GetController("tips")
	arg_5_0.statusController_ = arg_5_0.controllerEx_:GetController("status")
	arg_5_0.heroRomaController_ = arg_5_0.heroSelectCon_:GetController("roma")
	arg_5_0.heroOwnController_ = arg_5_0.heroSelectCon_:GetController("own")
	arg_5_0.heroSelectQualityController_ = arg_5_0.heroSelectCon_:GetController("quality")
	arg_5_0.notHaveItemList_ = {}
	arg_5_0.haveItemList_ = {}
	arg_5_0.heroInfo_ = {}
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.okBtn_, nil, function()
		if arg_6_0.selectDic_ then
			for iter_7_0, iter_7_1 in pairs(arg_6_0.selectDic_) do
				local var_7_0 = arg_6_0:GetHeroID(iter_7_0)
				local var_7_1 = ItemCfg[iter_7_0]
				local var_7_2 = HeroData:GetHeroOmegaNeedPiece(var_7_0)

				if not (HeroData:GetHeroData(var_7_0).unlock == 0) or not ItemTools.getItemNum(iter_7_0) then
					local var_7_3 = 0
				end

				local var_7_4 = iter_7_1 - var_7_2

				if var_7_4 > 0 then
					ShowMessageBox({
						content = string.format(GetTips("CHOICEBOX_CHOSEN_OVERFLOW"), var_7_4),
						OkCallback = function()
							local var_8_0 = {}

							for iter_8_0, iter_8_1 in pairs(arg_6_0.selectDic_) do
								if iter_8_1 ~= 0 then
									table.insert(var_8_0, {
										id = iter_8_0,
										num = iter_8_1
									})
								end
							end

							IdolTraineeAction.GetQuestRankReward(arg_6_0.rank_, var_8_0, function()
								arg_6_0:SetNextTopExit()
							end)
						end,
						ToggleCallback = function(arg_10_0)
							_G.SkipTip.SkipExchangeHero1 = arg_10_0
						end
					})

					return
				end
			end

			local var_7_5 = {}

			for iter_7_2, iter_7_3 in pairs(arg_6_0.selectDic_) do
				if iter_7_3 ~= 0 then
					table.insert(var_7_5, {
						id = iter_7_2,
						num = iter_7_3
					})
				end
			end

			IdolTraineeAction.GetQuestRankReward(arg_6_0.rank_, var_7_5, function()
				arg_6_0:SetNextTopExit()
			end)
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.lockBtn_, nil, function()
		ShowTips("ITEM_SELECTED")
	end)
end

function var_0_0.SetNextTopExit(arg_13_0)
	arg_13_0.nextTopExit_ = true
end

function var_0_0.OnTop(arg_14_0)
	if arg_14_0.nextTopExit_ then
		arg_14_0.nextTopExit_ = nil

		arg_14_0:Back()
	end
end

function var_0_0.RefreshUI(arg_15_0)
	arg_15_0.notHaveList_ = {}
	arg_15_0.haveList_ = {}

	for iter_15_0 = 1, #arg_15_0.dataList_ do
		local var_15_0 = arg_15_0.dataList_[iter_15_0]
		local var_15_1 = ItemCfg[var_15_0]
		local var_15_2 = arg_15_0:GetHeroID(var_15_0)
		local var_15_3 = HeroCfg[var_15_2]

		if HeroTools.GetIsHide(var_15_0) or HeroTools.GetIsSkinHide(var_15_0) then
			-- block empty
		elseif var_15_3 and (HeroTools.GetHeroIsUnlock(var_15_2) or arg_15_0.isHeroPiece_ and HeroDCommonItemViewata:GetHeroList()[var_15_2].piece >= GameSetting.unlock_hero_need.value[HeroCfg[var_15_2].rare]) then
			table.insert(arg_15_0.haveList_, arg_15_0.dataList_[iter_15_0])
		else
			table.insert(arg_15_0.notHaveList_, arg_15_0.dataList_[iter_15_0])
		end
	end

	arg_15_0:RefreshItemList(false)
	arg_15_0:RefreshItemList(true)
	arg_15_0:RefreshSelect()
end

function var_0_0.RefreshItemList(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_1 and arg_16_0.haveList_ or arg_16_0.notHaveList_
	local var_16_1 = arg_16_1 and arg_16_0.haveItemList_ or arg_16_0.notHaveItemList_
	local var_16_2 = arg_16_1 and arg_16_0.haveTitle_ or arg_16_0.notHaveTitle_
	local var_16_3 = arg_16_1 and arg_16_0.haveContent_ or arg_16_0.notHaveContent_

	if #var_16_0 > 0 then
		for iter_16_0, iter_16_1 in ipairs(var_16_0) do
			local var_16_4 = iter_16_1
			local var_16_5 = arg_16_0:GetHeroLock(var_16_4)
			local var_16_6 = clone(ItemTemplateData)

			var_16_6.id = var_16_4
			var_16_6.selectStyle = arg_16_0.selectInfo_ and arg_16_0.selectInfo_.id == var_16_4
			var_16_6.hideBottomRightTextFlag = true

			local var_16_7 = var_16_1[iter_16_0]

			if var_16_7 == nil then
				local var_16_8 = Object.Instantiate(arg_16_0.itemGo_, var_16_3)

				var_16_7 = CommonRecommendItemView.New(var_16_8)

				table.insert(var_16_1, var_16_7)
			end

			function var_16_6.clickFun(arg_17_0)
				if var_16_5 then
					return false
				end

				arg_16_0.selectHeroId_ = arg_16_0:GetHeroID(var_16_4)

				arg_16_0:AddSelect(var_16_4)
				var_16_7:RefreshTopAmount(arg_16_0.selectDic_[var_16_4])
				arg_16_0:RefreshHeroInfo()
				arg_16_0:RefreshSelect()

				return true
			end

			function var_16_6.clickAmountFun(arg_18_0)
				if var_16_5 then
					return false
				end

				arg_16_0.selectHeroId_ = arg_16_0:GetHeroID(var_16_4)

				arg_16_0:DeleteSelect(var_16_4)
				var_16_7:RefreshTopAmount(arg_16_0.selectDic_[var_16_4])
				arg_16_0:RefreshHeroInfo()
				arg_16_0:RefreshSelect()

				return true
			end

			function var_16_6.beginDragFun(arg_19_0, arg_19_1)
				arg_16_0.scrollRect_:OnBeginDrag(arg_19_1)
			end

			function var_16_6.dragFun(arg_20_0, arg_20_1)
				arg_16_0.scrollRect_:OnDrag(arg_20_1)
			end

			function var_16_6.endDragFun(arg_21_0, arg_21_1)
				arg_16_0.scrollRect_:OnEndDrag(arg_21_1)
			end

			var_16_7:SetData(var_16_6)
			var_16_7:RefreshRecommend()
			SetActive(var_16_7.gameObject_, true)
		end

		for iter_16_2 = #var_16_0 + 1, #var_16_1 do
			SetActive(var_16_1[iter_16_2].gameObject_, false)
		end
	else
		SetActive(var_16_3.gameObject, false)
		SetActive(var_16_2, false)
	end
end

function var_0_0.AddSelect(arg_22_0, arg_22_1)
	if arg_22_0.selectNum_ >= arg_22_0.maxNum_ then
		return
	end

	if not arg_22_0.selectDic_[arg_22_1] then
		arg_22_0.selectDic_[arg_22_1] = 0
	end

	arg_22_0.selectDic_[arg_22_1] = arg_22_0.selectDic_[arg_22_1] + 1
	arg_22_0.selectNum_ = arg_22_0.selectNum_ + 1
end

function var_0_0.DeleteSelect(arg_23_0, arg_23_1)
	if arg_23_0.selectNum_ <= 0 or not arg_23_0.selectDic_[arg_23_1] or arg_23_0.selectDic_[arg_23_1] <= 0 then
		return
	end

	arg_23_0.selectDic_[arg_23_1] = arg_23_0.selectDic_[arg_23_1] - 1
	arg_23_0.selectNum_ = arg_23_0.selectNum_ - 1
end

function var_0_0.RefreshSelect(arg_24_0)
	arg_24_0.okBtnController_:SetSelectedState(tostring(arg_24_0.selectNum_ >= arg_24_0.maxNum_))

	if arg_24_0.selectNum_ > 0 then
		arg_24_0.nameText_.text = HeroTools.GetHeroFullName(arg_24_0.selectHeroId_)
		arg_24_0.heroIcon_.sprite = HeroTools.GetHeadSprite(arg_24_0.selectHeroId_)

		arg_24_0.heroSelectQualityController_:SetSelectedState(HeroCfg[arg_24_0.selectHeroId_].rare + 2)

		local var_24_0 = arg_24_0:GetHeroLock(arg_24_0.selectHeroId_)

		if var_24_0 then
			SurpassTools.ChangeIconStarSpirte(arg_24_0.heroNodeIcon_, arg_24_0.heroInfo_.nowStar)
			arg_24_0.heroRomaController_:SetSelectedState(tostring(not string.isNullOrEmpty(arg_24_0.heroInfo_.nowRoma)))

			arg_24_0.heroNodeLv_.text = arg_24_0.heroInfo_.nowRoma

			SurpassTools.ChangeIconStarSpirte(arg_24_0.heroNextNodeIcon_, arg_24_0.heroInfo_.nextStar)

			arg_24_0.heroNeedNum_.text = arg_24_0.heroInfo_.needNum
		end

		arg_24_0.statusController_:SetSelectedState("slectHead")
		arg_24_0.heroOwnController_:SetSelectedState(tostring(var_24_0))

		arg_24_0.itemNumText_.text = ItemTools.getItemNum(arg_24_0.selectHeroId_ + 10000)
	else
		arg_24_0.statusController_:SetSelectedState("unselctOne")
	end

	arg_24_0.numText_.text = arg_24_0.selectNum_ .. "/" .. arg_24_0.maxNum_
end

function var_0_0.RefreshHeroInfo(arg_25_0)
	arg_25_0.heroInfo_ = {}

	local var_25_0 = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT):GetHeroData(arg_25_0.selectHeroId_).star
	local var_25_1 = HeroStarCfg[var_25_0]

	arg_25_0.heroInfo_.nowStar = var_25_1.star
	arg_25_0.heroInfo_.nowRoma = SurpassTools.GetSmallStageShow(var_25_1.id)

	local var_25_2, var_25_3 = HeroData:GetHeroNextSurpassNeedPiece(arg_25_0.selectHeroId_)

	arg_25_0.heroInfo_.nextStar = var_25_3
	arg_25_0.heroInfo_.needNum = var_25_2
end

function var_0_0.OnTryToUseItem(arg_26_0, arg_26_1, arg_26_2)
	if isSuccess(arg_26_1.result) then
		JumpTools:Back()
		getReward(arg_26_1.drop_list)
	else
		ShowTips(arg_26_1.result)
	end
end

function var_0_0.OnExit(arg_27_0)
	arg_27_0.selectDic_ = {}
	arg_27_0.scrollRect_.verticalNormalizedPosition = 1

	arg_27_0.slider_.onValueChanged:RemoveAllListeners()
end

function var_0_0.GetHeroID(arg_28_0, arg_28_1)
	return arg_28_1 - 10000
end

function var_0_0.GetHeroLock(arg_29_0, arg_29_1)
	return not HeroTools.GetHeroIsUnlock(arg_29_1 - 10000)
end

function var_0_0.Dispose(arg_30_0)
	for iter_30_0, iter_30_1 in ipairs(arg_30_0.notHaveItemList_) do
		iter_30_1:Dispose()
	end

	arg_30_0.notHaveItemList_ = nil

	for iter_30_2, iter_30_3 in ipairs(arg_30_0.haveItemList_) do
		iter_30_3:Dispose()
	end

	arg_30_0.haveItemList_ = nil

	var_0_0.super.Dispose(arg_30_0)
end

return var_0_0
