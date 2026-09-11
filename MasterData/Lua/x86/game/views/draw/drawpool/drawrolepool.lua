local DrawRolePool = class("DrawRolePool", ReduxView)

function DrawRolePool:OnCtor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.poolId = arg_1_2
	self.showId = arg_1_3

	self:Init()
end

function DrawRolePool:Init()
	self:InitUI()
	self:AddUIListener()
	self:InitRole()
end

function DrawRolePool:InitUI()
	self:AdaptScreen()
	self:BindCfgUI()
	self:InitController()
end

function DrawRolePool:InitRole()
	self.roleItemDic_ = {}
end

function DrawRolePool:AddUIListener()
	self:AddBtnListener(self.detailBtn_, nil, function()
		JumpTools.OpenPageByJump("/heroPreviewMain", {
			isEnter = true,
			isDraw = true,
			hid = self.upId_
		})
	end)

	if self.changeUpBtn_ then
		self:AddBtnListener(self.changeUpBtn_, nil, function()
			DrawTools:GoToSelectUpHeroView(self.poolId, self.showId)
		end)
	end
end

function DrawRolePool:InitController()
	self.firstController_ = self.controllerEx_:GetController("first")
	self.chooseController_ = self.controllerEx_:GetController("choose")
end

function DrawRolePool:Dispose()
	for iter_9_0, iter_9_1 in pairs(self.roleItemDic_) do
		Object.Destroy(iter_9_1)
	end

	self.roleItemDic_ = {}

	Object.Destroy(self.gameObject_)
	DrawRolePool.super.Dispose(self)
end

function DrawRolePool:Refresh(arg_10_1)
	self.upId_ = DrawData:GetPollUpID(self.poolId)

	self:UpdateChooseStatus()
	self:UpdateFirstStatus()
	self:UpdateChangeCount()
	self:UpdateRole()
end

function DrawRolePool:UpdateChooseStatus()
	self.chooseController_:SetSelectedState(self.upId_ == 0 and "NotSelected" or "Choose")
end

function DrawRolePool:UpdateFirstStatus()
	local var_12_0 = DrawData:GetIsFirstSSR()

	self.firstController_:SetSelectedState(var_12_0 and "true" or "false")

	if var_12_0 then
		self:UpdateFirstUI()
	end
end

function DrawRolePool:UpdateFirstUI()
	self.drawTime_.text = string.format("%d/%d", DrawData:GetPoolDrawTimes(self.poolId), GameSetting.draw_ssr_lucky_num_first_time.value[1])
end

function DrawRolePool:UpdateChangeCount()
	local var_14_0 = DrawPoolCfg[self.poolId].pool_change

	SetActive(self.changeCountText_.gameObject, DrawPoolCfg[self.poolId].pool_change > 0)

	if var_14_0 > 0 then
		self.changeCountText_.text = string.format(GetTips("DRAW_REMAIN_UP_TIMES"), tostring(var_14_0 - DrawData:GetPoolUpTimes(self.poolId)))
	end
end

function DrawRolePool:UpdateRole()
	self:TryCreateRoleItem()
	self:UpdateRoleActive()
	self:UpdateRoleInfo()
end

function DrawRolePool:TryCreateRoleItem()
	if self.upId_ == 0 then
		return
	end

	self.roleItemDic_[self.upId_] = self.roleItemDic_[self.upId_] or self:CreateRoleItemGo()
end

function DrawRolePool:UpdateRoleActive()
	for iter_17_0, iter_17_1 in pairs(self.roleItemDic_) do
		SetActive(iter_17_1, iter_17_0 == self.upId_)
	end
end

function DrawRolePool:UpdateRoleInfo()
	if self.upId_ == 0 then
		return
	end

	self.heroName_.text = HeroTools.GetHeroFullName(self.upId_)
	self.heroRareIcon_.sprite = HeroTools.GetHeroRareSprite(self.upId_)
	self.heroRaceIcon_.sprite = HeroTools.GetHeroRaceIcon(self.upId_)
end

function DrawRolePool:CreateRoleItemGo()
	return GameObject.Instantiate(Asset.Load("Widget/System/PoolRole/PoolRole_" .. self.upId_), self.roleContentTrans_)
end

function DrawRolePool:ShowCountDownText(arg_20_1)
	if self.countdownText_ then
		SetActive(self.countdownText_.gameObject, arg_20_1)
	end

	if self.countDownGo_ then
		SetActive(self.countDownGo_, arg_20_1)
	end
end

function DrawRolePool:SetCountDownText(arg_21_1)
	if self.countdownText_ then
		self.countdownText_.text = string.format(GetTips("TIME_DISPLAY_14"), manager.time:GetLostTimeStrWith3Unit(arg_21_1))
	end
end

function DrawRolePool:GetPoolId()
	return self.poolId
end

function DrawRolePool:GetShowId()
	return self.showId
end

function DrawRolePool:ShowRightPanel()
	return true
end

function DrawRolePool:SetActive(arg_25_1)
	SetActive(self.gameObject_, arg_25_1)
end

return DrawRolePool
