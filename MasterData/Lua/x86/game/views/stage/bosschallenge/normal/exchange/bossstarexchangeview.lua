local BossStarExchangeView = class("BossStarExchangeView", ReduxView)

function BossStarExchangeView:UIName()
	return "Widget/System/Challenge_Boss/BossStarExchangeUI"
end

function BossStarExchangeView:UIParent()
	return manager.ui.uiPop.transform
end

function BossStarExchangeView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.itemList_ = {}
	self.refreshHandler_ = handler(self, self.RefreshReward)
	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, BossStarExchangeItem)
end

function BossStarExchangeView:IndexItem(arg_4_1, arg_4_2)
	arg_4_2:SetData(self.cfg_.reward[self.taskList_[arg_4_1]], self.curStarCnt_, self.taskList_[arg_4_1], arg_4_1 == #self.taskList_)
end

function BossStarExchangeView:OnEnter()
	manager.notify:RegistListener(BOSS_CHALLENGE_RECEIVE_STAR_REWARD, self.refreshHandler_)
	self:RefreshItem()
end

function BossStarExchangeView:OnExit()
	manager.notify:RemoveListener(BOSS_CHALLENGE_RECEIVE_STAR_REWARD, self.refreshHandler_)
end

function BossStarExchangeView:AddListeners()
	self:AddBtnListener(self.buttonClose_, nil, function()
		self:Back()
	end)
end

function BossStarExchangeView:RefreshItem()
	self.cfg_ = BattleBossChallengeNormalData:GetBossChallengeCfg()
	self.curStarCnt_ = StageTools.CalcBossChallengeStar()

	local var_9_0 = BattleBossChallengeNormalData:GetReceiveStarList()
	local var_9_1 = {}
	local var_9_2 = 0

	for iter_9_0 = 1, #self.cfg_.reward do
		table.insert(var_9_1, iter_9_0)

		if self.cfg_.reward[iter_9_0][1] <= self.curStarCnt_ and not table.keyof(var_9_0, self.cfg_.reward[iter_9_0][1]) and var_9_2 == 0 then
			var_9_2 = iter_9_0
		end
	end

	self.taskList_ = var_9_1

	self.scrollHelper_:StartScroll(#self.taskList_, var_9_2)
end

function BossStarExchangeView:RefreshReward()
	self.scrollHelper_:Refresh()
end

function BossStarExchangeView:Dispose()
	BossStarExchangeView.super.Dispose(self)

	self.refreshHandler_ = nil

	self.scrollHelper_:Dispose()

	self.itemList_ = nil
end

return BossStarExchangeView
