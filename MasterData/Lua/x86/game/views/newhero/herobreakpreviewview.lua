local HeroBreakPreviewView = class("HeroBreakPreviewView", ReduxView)

function HeroBreakPreviewView:UIName()
	return "Widget/System/Hero_arrt/HeroArrtBreakPreviewPopUI"
end

function HeroBreakPreviewView:UIParent()
	return manager.ui.uiPop.transform
end

function HeroBreakPreviewView:Init()
	self:InitUI()
	self:AddUIListener()
end

function HeroBreakPreviewView:InitUI()
	self:BindCfgUI()

	self.needList_ = LuaList.New(handler(self, self.indexNeedItem), self.needListGo_, CommonItemView)
end

function HeroBreakPreviewView:indexNeedItem(arg_5_1, arg_5_2)
	local var_5_0 = clone(ItemTemplateData)

	var_5_0.id = self.breakCfg_.cost[arg_5_1][1]

	function var_5_0:clickFun()
		ShowPopItem(POP_SOURCE_ITEM, {
			self.id
		})
	end

	arg_5_2:SetData(var_5_0)

	if ItemTools.getItemNum(self.breakCfg_.cost[arg_5_1][1]) < self.breakCfg_.cost[arg_5_1][2] then
		arg_5_2:RefreshBottomText(string.format("<color=#F76866>%d</color>", self.breakCfg_.cost[arg_5_1][2]))
	else
		arg_5_2:RefreshBottomText(string.format(self.breakCfg_.cost[arg_5_1][2]))
	end
end

function HeroBreakPreviewView:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.preBtn_, nil, function()
		self:SwitchBreakLevel(self.curBreakIndex_ - 1)
	end)
	self:AddBtnListener(self.nextBtn_, nil, function()
		self:SwitchBreakLevel(self.curBreakIndex_ + 1)
	end)
end

function HeroBreakPreviewView:InitData()
	self.heroInfo_ = self.params_.heroInfo
	self.heroCfg_ = HeroCfg[self.heroInfo_.id]
	self.breakIdList_ = clone(HeroBreakCfg.get_id_list_by_race[self.heroCfg_.race])
	self.curBreakId_ = HeroTools.GetHeroBreakConfig(self.heroCfg_.race, self.heroInfo_.break_level or 0).id

	for iter_11_0 = 1, #self.breakIdList_ do
		if HeroBreakCfg[self.breakIdList_[iter_11_0]].cost_gold == 0 then
			table.remove(self.breakIdList_, iter_11_0)

			break
		end
	end

	self.curBreakIndex_ = table.indexof(self.breakIdList_, self.curBreakId_) or #self.breakIdList_
end

function HeroBreakPreviewView:SwitchBreakLevel(arg_12_1)
	self.curBreakIndex_ = arg_12_1
	self.curBreakId_ = self.breakIdList_[arg_12_1]
	self.breakCfg_ = HeroBreakCfg[self.curBreakId_]

	if self.breakCfg_.break_times < #self.breakIdList_ then
		self.nextBreakCfg_ = HeroTools.GetHeroBreakConfig(self.heroCfg_.race, self.breakCfg_.break_times + 1 or 0)
		self.upLevelText_.text = GetTips("LEVEL") .. self.nextBreakCfg_.max_level
	end

	self.needList_:StartScroll(#self.breakCfg_.cost)

	self.conditionLabel_.text = PlayerData:GetPlayerInfo().userLevel >= self.breakCfg_.user_level and string.format(GetTips("UPGRADE_LIMIT_LEVEL"), self.breakCfg_.user_level) or string.format(GetTips("UPGRADE_LIMIT_LEVEL_RED"), self.breakCfg_.user_level)

	local var_12_1 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_GOLD)

	self.needIcon_.sprite = ItemTools.getItemLittleSprite(CurrencyConst.CURRENCY_TYPE_GOLD)
	self.needCountLabel_.text = var_12_1 < self.breakCfg_.cost_gold and string.format("<color=#F76866>%d</color>", self.breakCfg_.cost_gold) or tostring(self.breakCfg_.cost_gold)

	SetActive(self.preBtn_.gameObject, arg_12_1 > 1)
	SetActive(self.nextBtn_.gameObject, arg_12_1 < #self.breakIdList_)
end

function HeroBreakPreviewView:OnEnter()
	self:InitData()
	self:SwitchBreakLevel(self.curBreakIndex_)
end

function HeroBreakPreviewView:CameraEnter()
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		1,
		2
	})
end

function HeroBreakPreviewView:OnTop()
	self:SwitchBreakLevel(self.curBreakIndex_)
end

function HeroBreakPreviewView:OnExit()
	return
end

function HeroBreakPreviewView:Dispose()
	if self.needList_ then
		self.needList_:Dispose()

		self.needList_ = nil
	end

	HeroBreakPreviewView.super.Dispose(self)
end

return HeroBreakPreviewView
