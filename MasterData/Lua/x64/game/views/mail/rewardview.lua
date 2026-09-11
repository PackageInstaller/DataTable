local RewardView = class("RewardView", ReduxView)

function RewardView:UIName()
	return "Widget/Common/Pop/RewardpopUI"
end

function RewardView:UIParent()
	return manager.ui.uiPop.transform
end

function RewardView:InitUI()
	self:BindCfgUI()

	self.uiList = LuaList.New(handler(self, self.indexItem), self.uiListGo_, CommonItemView)
	self.rowCountController_ = self.conExCollection_:GetController("rowCount")
end

function RewardView:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		RewardView.super.Back(self)
	end)
end

function RewardView:indexItem(arg_6_1, arg_6_2)
	local var_6_0 = self:ConvertToItemData(self.itemList_[arg_6_1])

	if (ItemCfg[self.itemList_[arg_6_1].id].sub_type == ItemConst.ITEM_SUB_TYPE.LIMIT_SKIN or ItemCfg[self.itemList_[arg_6_1].id].sub_type == ItemConst.ITEM_SUB_TYPE.SCENE_NORMAL) and ItemCfg[self.itemList_[arg_6_1].id].time then
		var_6_0.need_count_down = true
		var_6_0.count_down_use_floor = true
		var_6_0.count_down_time_text = ItemCfg[self.itemList_[arg_6_1].id].time[2][1] .. GetTips("DAY")
	end

	arg_6_2:SetData(var_6_0)
end

function RewardView:RefreshUI(arg_7_1)
	self:CheckBack()

	if arg_7_1 then
		arg_7_1 = formatRewardCfgList(arg_7_1)
		arg_7_1 = ItemTools.SortRewardItemList(arg_7_1)

		local var_7_0 = #arg_7_1

		self.itemList_ = arg_7_1
		self.itemPool_ = self.itemPool1_
		self.listScrollRect_.enabled = var_7_0 > 10

		self.uiList:StartScroll(var_7_0)

		if var_7_0 > 5 then
			self.rowCountController_:SetSelectedState("2")
			self.uiList:SetAlignment(UIListAlignment.Center)
		else
			self.rowCountController_:SetSelectedState("1")
			self.uiList:SetAlignment(UIListAlignment.Center2)
		end

		self:CollectSkinList()
	end
end

function RewardView:Init()
	self:InitUI()
	self:AddUIListener()
end

function RewardView:OnEnter()
	self:RefreshUI(self.params_.list)
end

function RewardView:OnExit()
	self:ShowVitalityBox(function()
		self:ShowEquipBox(function()
			self:ShowSkinBox(function()
				return
			end)
		end)
	end)
end

function RewardView:ShowVitalityBox(arg_14_1)
	if self.params_.needShowVitalityBox then
		showVitalitySendMail(arg_14_1)
	else
		arg_14_1()
	end
end

function RewardView:ShowEquipBox(arg_15_1)
	if self.params_.needShowEquipBox then
		showEquipSendMail(arg_15_1)
	else
		arg_15_1()
	end
end

function RewardView:CollectSkinList()
	if not self.itemList_ then
		self.skinItemList_ = nil

		return
	end

	self.skinItemList_ = {}

	for iter_16_0, iter_16_1 in ipairs(self.itemList_) do
		if ItemCfg[iter_16_1.id].type == ItemConst.ITEM_TYPE.HERO_SKIN then
			table.insert(self.skinItemList_, iter_16_1.id)
		end
	end
end

function RewardView:ShowSkinBox(arg_17_1)
	if self.skinItemList_ and #self.skinItemList_ > 0 then
		local var_17_0 = SkinCfg[id] or SkinCfg[ItemCfg[self.skinItemList_[1]].param[1]]
		local var_17_1 = var_17_0.id
		local var_17_2 = var_17_0.hero

		table.remove(self.skinItemList_, 1)

		if not HeroTools.GetHeroIsUnlock(var_17_0.hero) then
			arg_17_1()

			return
		end

		ShowMessageBox({
			isTop = true,
			title = GetTips("PROMPT"),
			content = GetTipsF("SHOP_BUY_SKIN_TIPS", HeroTools.GetHeroFullName(var_17_0.hero), GetI18NText(var_17_0.name)),
			OkCallback = function()
				HeroAction.SelectSkin(var_17_2, var_17_1)
				HeroAction.ChangeBattleSkin(var_17_2, var_17_1)

				if PlayerData:IsRandomHero() then
					CustomCenterTools.UpdateCacheRandomHeroSkinID(var_17_1)
					CustomCenterAction.SaveRandomHeroSkinList(function()
						return
					end)
					PlayerData:SetForceRandomHeroID(var_17_1)
				else
					PlayerAction.ChangePosterGirlWithCallback(var_17_2, function()
						HomeSceneSettingAction.AutoSwitchMatchSkinScene(var_17_2)
					end)
				end

				self:ShowSkinBox(arg_17_1)
			end,
			CancelCallback = function()
				self:ShowSkinBox(arg_17_1)
			end
		})
	else
		arg_17_1()
	end
end

function RewardView:Dispose()
	if self.uiList ~= nil then
		self.uiList:Dispose()

		self.uiList = nil
	end

	if self.itemPool1_ ~= nil then
		self.itemPool1_:Dispose()

		self.itemPool1_ = nil
	end

	if self.backTimer_ then
		self.backTimer_:Stop()

		self.backTimer_ = nil
	end

	RewardView.super.Dispose(self)
end

function RewardView:DisablebgBtn()
	self.bgBtn_.enabled = false
end

function RewardView:ConvertToItemData(arg_24_1)
	local var_24_0 = rewardToItemTemplate(arg_24_1, nil, true)

	var_24_0.number = var_24_0.number or arg_24_1.number
	var_24_0.animatorType = ItemConst.ITEM_ANIMATOR_TYPE.ADVANCED

	return var_24_0
end

function RewardView:CheckBack()
	if not manager.guide:IsPlaying() then
		if self.backTimer_ then
			self.backTimer_:Stop()

			self.backTimer_ = nil
		end

		self.bgBtn_.enabled = false
		self.backTimer_ = Timer.New(function()
			self.bgBtn_.enabled = true
		end, GameSetting.reward_pop_view_time.value[1], 1)

		self.backTimer_:Start()
	end
end

function RewardView:Back(arg_27_1)
	if manager.guide:IsPlaying() then
		RewardView.super.Back(self)

		return
	end

	if self:IsAnimEnd() then
		RewardView.super.Back(self)

		if arg_27_1 then
			arg_27_1()
		end
	else
		self:StopAllAnim()
	end
end

local function var_0_1(arg_28_0)
	if arg_28_0 == nil then
		return true
	end

	if arg_28_0:GetCurrentAnimatorStateInfo(0).normalizedTime >= 0.999 then
		return true
	end

	return false
end

local function var_0_2(arg_29_0)
	if arg_29_0 == nil then
		return
	end

	arg_29_0:Update(99999)
end

function RewardView:IsAnimEnd()
	if #self.params_.list == 0 then
		return true
	end

	if not var_0_1(self.animator_) then
		return false
	end

	local var_30_0, var_30_1 = self.uiList:GetHeadAndTail()

	if var_30_0 == 0 then
		return false
	end

	return var_0_1(self.uiList:GetItemByIndex(var_30_0).animator_)
end

function RewardView:StopAllAnim()
	var_0_2(self.animator_)

	for iter_31_0, iter_31_1 in pairs((self.uiList:GetItemList())) do
		var_0_2(iter_31_1.animator_)
	end
end

return RewardView
