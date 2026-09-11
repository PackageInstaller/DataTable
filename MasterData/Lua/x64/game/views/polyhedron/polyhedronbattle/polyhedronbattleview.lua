local PolyhedronBattleView = class("PolyhedronBattleView", ReduxView)

function PolyhedronBattleView:UIName()
	return "Widget/System/PolyhedronBattle/PolyhedronBattleUI"
end

function PolyhedronBattleView:UIParent()
	return manager.ui.uiMain.transform
end

function PolyhedronBattleView:Init()
	self:InitUI()
	self:AddUIListener()
end

function PolyhedronBattleView:InitUI()
	self:BindCfgUI()

	self.headList = {}

	for iter_4_0 = 1, 3 do
		table.insert(self.headList, polyhedronBattleHeadItem.New(self["m_role" .. iter_4_0]))
	end

	self.tipsItems_ = {}
	self.tipsDispose_ = handler(self, self.OnTipsDispose)
end

function PolyhedronBattleView:AddUIListener()
	self:AddBtnListener(self.m_teamBtn, nil, function()
		JumpTools.OpenPageByJump("polyhedronTeamInfo")
	end)
end

function PolyhedronBattleView:OnTop()
	return
end

function PolyhedronBattleView:OnEnter()
	self:RefreshUI()
	self:CheckTeamRedPoint()
	PolyhedronData:ResetCacheTipInfoIndex()
	self:StartTimer()
end

function PolyhedronBattleView:CheckTeamRedPoint()
	local var_9_0 = self.polyhedronInfo:GetFightHeroList()
	local var_9_1 = #var_9_0 < 3
	local var_9_2 = false

	for iter_9_0, iter_9_1 in ipairs((self.polyhedronInfo:GetHeroList())) do
		local var_9_3 = self.polyhedronInfo:GetHeroPolyData(iter_9_1)

		if table.indexof(var_9_0, iter_9_1) then
			if var_9_3:IsDead() then
				var_9_1 = true
			end
		elseif not var_9_3:IsDead() then
			var_9_2 = true
		end
	end

	if var_9_1 and var_9_2 then
		manager.redPoint:SetRedPointIndependent(self.m_teamBtn.transform, true)
	else
		manager.redPoint:SetRedPointIndependent(self.m_teamBtn.transform, false)
	end
end

function PolyhedronBattleView:RefreshUI()
	local var_10_0 = PolyhedronData:GetPolyhedronInfo()

	self.polyhedronInfo = var_10_0

	local var_10_1 = PolyhedronTierCfg[var_10_0:GetTierId()]

	self.m_stageName.text = GetI18NText(var_10_1.tier) .. "-" .. GetI18NText(var_10_1.level)
	self.m_difficultyLab.text = GetI18NText((var_10_0:GetDifficulty()))

	local var_10_2 = var_10_0:GetFightHeroList()

	for iter_10_0, iter_10_1 in ipairs(self.headList) do
		iter_10_1:SetData(var_10_0, var_10_2[iter_10_0] or 0)
	end

	self.coinId = var_10_0:GetPolyhedronCoinId()
	self.m_coinIcon.sprite = ItemTools.getItemLittleSprite(self.coinId)
	self.m_coinLab.text = GetI18NText(self.polyhedronInfo:GetCoinCount())
end

function PolyhedronBattleView:OnUpdate()
	self.m_coinLab.text = GetI18NText(self.polyhedronInfo:GetCoinCount())

	self:CheckTeamRedPoint()
end

function PolyhedronBattleView:OnExit()
	self:StopTimer()
end

function PolyhedronBattleView:Dispose()
	self:StopTimer()

	for iter_13_0, iter_13_1 in ipairs(self.headList) do
		iter_13_1:Dispose()
	end

	self.headList = nil

	PolyhedronBattleView.super.Dispose(self)

	for iter_13_2, iter_13_3 in pairs(self.tipsItems_) do
		iter_13_3:Dispose()
	end

	self.creatFlag = false
end

function PolyhedronBattleView:OnPolyhedronGameUpdate()
	self:RefreshUI()
end

function PolyhedronBattleView:OnPolyhedronProcessUpdate()
	self:RefreshUI()
end

function PolyhedronBattleView:StartTimer()
	if self.timer_ == nil then
		self.timer_ = Timer.New(function()
			self:UpdateTimer()
		end, 1, -1)
	end

	self.timer_:Start()
end

function PolyhedronBattleView:UpdateTimer()
	local var_18_0 = PolyhedronData:GetTipsData()

	if var_18_0 then
		self:CreatTips(var_18_0)
	end
end

function PolyhedronBattleView:CreatTips(arg_19_1)
	if not self.creatFlag then
		for iter_19_0, iter_19_1 in pairs(self.tipsItems_) do
			if not iter_19_1:GetIsShow() then
				iter_19_1:SetData(arg_19_1)
				iter_19_1:SetIsShow(true)
				LayoutRebuilder.ForceRebuildLayoutImmediate(self.contentTrans_)

				self.creatFlag = true

				return
			end
		end

		local var_19_0 = PolyhedronBattleTipItem.New((GameObject.Instantiate(self.tipsGo_, self.contentTrans_)))

		var_19_0:SetDisposeHandler(self.tipsDispose_)
		var_19_0:SetData(arg_19_1)
		var_19_0:SetIsShow(true)
		table.insert(self.tipsItems_, var_19_0)
		LayoutRebuilder.ForceRebuildLayoutImmediate(self.contentTrans_)

		self.creatFlag = true
	end
end

function PolyhedronBattleView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end

	for iter_20_0, iter_20_1 in pairs(self.tipsItems_) do
		iter_20_1:OnExit()
	end
end

function PolyhedronBattleView:OnTipsDispose(arg_21_1)
	LayoutRebuilder.ForceRebuildLayoutImmediate(self.contentTrans_)
end

return PolyhedronBattleView
