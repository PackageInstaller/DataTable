local IdolTaskItemSelectView = class("IdolTaskItemSelectView", ReduxView)

function IdolTaskItemSelectView:UIName()
	return "Widget/Common/Pop/UIInquirepopup14_new02"
end

function IdolTaskItemSelectView:UIParent()
	return manager.ui.uiPop.transform
end

function IdolTaskItemSelectView:Init()
	self:InitUI()
	self:AddUIListener()
end

function IdolTaskItemSelectView:OnEnter()
	self.rank_ = self.params_.rank
	self.dataList_ = IdolTraineeRewardRankCfg[self.rank_].reward
	self.selectDic_ = {}
	self.selectNum_ = 0
	self.maxNum_ = IdolTraineeRewardRankCfg[self.rank_].num

	self:RefreshUI()
end

function IdolTaskItemSelectView:InitUI()
	self:BindCfgUI()

	self.okBtnController_ = self.controllerEx_:GetController("btn")
	self.tipsController_ = self.controllerEx_:GetController("tips")
	self.statusController_ = self.controllerEx_:GetController("status")
	self.heroRomaController_ = self.heroSelectCon_:GetController("roma")
	self.heroOwnController_ = self.heroSelectCon_:GetController("own")
	self.heroSelectQualityController_ = self.heroSelectCon_:GetController("quality")
	self.notHaveItemList_ = {}
	self.haveItemList_ = {}
	self.heroInfo_ = {}
end

function IdolTaskItemSelectView:AddUIListener()
	self:AddBtnListener(self.okBtn_, nil, function()
		if self.selectDic_ then
			for iter_7_0, iter_7_1 in pairs(self.selectDic_) do
				local var_7_0 = self:GetHeroID(iter_7_0)
				local var_7_2 = HeroData:GetHeroOmegaNeedPiece(var_7_0)

				if HeroData:GetHeroData(var_7_0).unlock ~= 0 or not ItemTools.getItemNum(iter_7_0) then
					-- block empty
				end

				local var_7_4 = iter_7_1 - var_7_2

				if iter_7_1 - var_7_2 > 0 then
					ShowMessageBox({
						content = string.format(GetTips("CHOICEBOX_CHOSEN_OVERFLOW"), var_7_4),
						OkCallback = function()
							local var_8_0 = {}

							for iter_8_0, iter_8_1 in pairs(self.selectDic_) do
								if iter_8_1 ~= 0 then
									table.insert(var_8_0, {
										id = iter_8_0,
										num = iter_8_1
									})
								end
							end

							IdolTraineeAction.GetQuestRankReward(self.rank_, var_8_0, function()
								self:SetNextTopExit()
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

			for iter_7_2, iter_7_3 in pairs(self.selectDic_) do
				if iter_7_3 ~= 0 then
					table.insert(var_7_5, {
						id = iter_7_2,
						num = iter_7_3
					})
				end
			end

			IdolTraineeAction.GetQuestRankReward(self.rank_, var_7_5, function()
				self:SetNextTopExit()
			end)
		end
	end)
	self:AddBtnListener(self.lockBtn_, nil, function()
		ShowTips("ITEM_SELECTED")
	end)
end

function IdolTaskItemSelectView:SetNextTopExit()
	self.nextTopExit_ = true
end

function IdolTaskItemSelectView:OnTop()
	if self.nextTopExit_ then
		self.nextTopExit_ = nil

		self:Back()
	end
end

function IdolTaskItemSelectView:RefreshUI()
	self.notHaveList_ = {}
	self.haveList_ = {}

	for iter_15_0 = 1, #self.dataList_ do
		local var_15_1 = self:GetHeroID(self.dataList_[iter_15_0])

		if HeroTools.GetIsHide(self.dataList_[iter_15_0]) or HeroTools.GetIsSkinHide(self.dataList_[iter_15_0]) then
			-- block empty
		elseif HeroCfg[var_15_1] and (HeroTools.GetHeroIsUnlock(var_15_1) or self.isHeroPiece_ and HeroDCommonItemViewata:GetHeroList()[var_15_1].piece >= GameSetting.unlock_hero_need.value[HeroCfg[var_15_1].rare]) then
			table.insert(self.haveList_, self.dataList_[iter_15_0])
		else
			table.insert(self.notHaveList_, self.dataList_[iter_15_0])
		end
	end

	self:RefreshItemList(false)
	self:RefreshItemList(true)
	self:RefreshSelect()
end

function IdolTaskItemSelectView:RefreshItemList(arg_16_1)
	if arg_16_1 then
		local var_16_0 = self.haveList_ or self.notHaveList_

		if arg_16_1 then
			local var_16_1 = self.haveItemList_ or self.notHaveItemList_
			local var_16_2

			if arg_16_1 then
				var_16_2 = self.haveTitle_ or self.notHaveTitle_

				local var_16_3

				if arg_16_1 then
					var_16_3 = self.haveContent_ or self.notHaveContent_

					if #var_16_0 > 0 then
						for iter_16_0, iter_16_1 in ipairs(var_16_0) do
							local var_16_4 = iter_16_1
							local var_16_5 = self:GetHeroLock(iter_16_1)
							local var_16_6 = clone(ItemTemplateData)

							var_16_6.id = iter_16_1
							var_16_6.selectStyle = self.selectInfo_ and self.selectInfo_.id == iter_16_1
							var_16_6.hideBottomRightTextFlag = true

							local var_16_7 = var_16_1[iter_16_0]

							if var_16_1[iter_16_0] == nil then
								var_16_7 = CommonRecommendItemView.New((Object.Instantiate(self.itemGo_, var_16_3)))

								table.insert(var_16_1, var_16_7)
							end

							function var_16_6.clickFun(arg_17_0)
								if var_16_5 then
									return false
								end

								self.selectHeroId_ = self:GetHeroID(var_16_4)

								self:AddSelect(var_16_4)
								var_16_7:RefreshTopAmount(self.selectDic_[var_16_4])
								self:RefreshHeroInfo()
								self:RefreshSelect()

								return true
							end

							function var_16_6.clickAmountFun(arg_18_0)
								if var_16_5 then
									return false
								end

								self.selectHeroId_ = self:GetHeroID(var_16_4)

								self:DeleteSelect(var_16_4)
								var_16_7:RefreshTopAmount(self.selectDic_[var_16_4])
								self:RefreshHeroInfo()
								self:RefreshSelect()

								return true
							end

							function var_16_6.beginDragFun(arg_19_0, arg_19_1)
								self.scrollRect_:OnBeginDrag(arg_19_1)
							end

							function var_16_6.dragFun(arg_20_0, arg_20_1)
								self.scrollRect_:OnDrag(arg_20_1)
							end

							function var_16_6.endDragFun(arg_21_0, arg_21_1)
								self.scrollRect_:OnEndDrag(arg_21_1)
							end

							var_16_7:SetData(var_16_6)
							var_16_7:RefreshRecommend()
							SetActive(var_16_7.gameObject_, true)
						end

						for iter_16_2 = #var_16_0 + 1, #var_16_1 do
							SetActive(var_16_1[iter_16_2].gameObject_, false)
						end

						goto label_16_0
					end
				end
			end
		end
	end

	SetActive(var_16_3.gameObject, false)
	SetActive(var_16_2, false)

	::label_16_0::
end

function IdolTaskItemSelectView:AddSelect(arg_22_1)
	if self.selectNum_ >= self.maxNum_ then
		return
	end

	self.selectDic_[arg_22_1] = self.selectDic_[arg_22_1] or 0
	self.selectDic_[arg_22_1] = self.selectDic_[arg_22_1] + 1
	self.selectNum_ = self.selectNum_ + 1
end

function IdolTaskItemSelectView:DeleteSelect(arg_23_1)
	if self.selectNum_ <= 0 or not self.selectDic_[arg_23_1] or self.selectDic_[arg_23_1] <= 0 then
		return
	end

	self.selectDic_[arg_23_1] = self.selectDic_[arg_23_1] - 1
	self.selectNum_ = self.selectNum_ - 1
end

function IdolTaskItemSelectView:RefreshSelect()
	self.okBtnController_:SetSelectedState(tostring(self.selectNum_ >= self.maxNum_))

	if self.selectNum_ > 0 then
		self.nameText_.text = HeroTools.GetHeroFullName(self.selectHeroId_)
		self.heroIcon_.sprite = HeroTools.GetHeadSprite(self.selectHeroId_)

		self.heroSelectQualityController_:SetSelectedState(HeroCfg[self.selectHeroId_].rare + 2)

		local var_24_0 = self:GetHeroLock(self.selectHeroId_)

		if var_24_0 then
			SurpassTools.ChangeIconStarSpirte(self.heroNodeIcon_, self.heroInfo_.nowStar)
			self.heroRomaController_:SetSelectedState(tostring(not string.isNullOrEmpty(self.heroInfo_.nowRoma)))

			self.heroNodeLv_.text = self.heroInfo_.nowRoma

			SurpassTools.ChangeIconStarSpirte(self.heroNextNodeIcon_, self.heroInfo_.nextStar)

			self.heroNeedNum_.text = self.heroInfo_.needNum
		end

		self.statusController_:SetSelectedState("slectHead")
		self.heroOwnController_:SetSelectedState(tostring(var_24_0))

		self.itemNumText_.text = ItemTools.getItemNum(self.selectHeroId_ + 10000)
	else
		self.statusController_:SetSelectedState("unselctOne")
	end

	self.numText_.text = self.selectNum_ .. "/" .. self.maxNum_
end

function IdolTaskItemSelectView:RefreshHeroInfo()
	self.heroInfo_ = {}

	local var_25_0 = HeroStarCfg[HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT):GetHeroData(self.selectHeroId_).star]

	self.heroInfo_.nowStar = var_25_0.star
	self.heroInfo_.nowRoma = SurpassTools.GetSmallStageShow(var_25_0.id)

	local var_25_1, var_25_2 = HeroData:GetHeroNextSurpassNeedPiece(self.selectHeroId_)

	self.heroInfo_.nextStar = var_25_2
	self.heroInfo_.needNum = var_25_1
end

function IdolTaskItemSelectView:OnTryToUseItem(arg_26_1, arg_26_2)
	if isSuccess(arg_26_1.result) then
		JumpTools:Back()
		getReward(arg_26_1.drop_list)
	else
		ShowTips(arg_26_1.result)
	end
end

function IdolTaskItemSelectView:OnExit()
	self.selectDic_ = {}
	self.scrollRect_.verticalNormalizedPosition = 1

	self.slider_.onValueChanged:RemoveAllListeners()
end

function IdolTaskItemSelectView:GetHeroID(arg_28_1)
	return arg_28_1 - 10000
end

function IdolTaskItemSelectView:GetHeroLock(arg_29_1)
	return not HeroTools.GetHeroIsUnlock(arg_29_1 - 10000)
end

function IdolTaskItemSelectView:Dispose()
	for iter_30_0, iter_30_1 in ipairs(self.notHaveItemList_) do
		iter_30_1:Dispose()
	end

	self.notHaveItemList_ = nil

	for iter_30_2, iter_30_3 in ipairs(self.haveItemList_) do
		iter_30_3:Dispose()
	end

	self.haveItemList_ = nil

	IdolTaskItemSelectView.super.Dispose(self)
end

return IdolTaskItemSelectView
