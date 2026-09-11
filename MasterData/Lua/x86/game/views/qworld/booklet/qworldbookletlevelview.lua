local QWorldBookletLevelView = class("QWorldBookletLevelView", ReduxView)

function QWorldBookletLevelView:UIName()
	return "Widget/System/SandPlay_QuanZhou/QuanZhou_Com/QuanZhou_ScheduleUI"
end

function QWorldBookletLevelView:UIParent()
	return manager.ui.uiMain.transform
end

function QWorldBookletLevelView:Init()
	self:InitUI()
	self:AddUIListener()

	self.idList_ = QWorldBookletTools.GetNdLevelIDList()
	self.receiveList_ = {}
	self.showIdList_ = {}
	self.curLv_ = 0
	self.maxLv_ = 0
	self.bookNameText.text = QWorldBookletTools.GetBookletSystemName()
	self.bookNameText_.text = QWorldBookletTools.GetBookletSystemName()
	self.levelLuaList_ = LuaList.New(handler(self, self.IndexItem), self.levelUilist_, QWorldBookletLevelItem)
	self.receivePointRewardHandler_ = handler(self, self.OnReceivePointReward)
	self.onekeyController_ = self.mainControllerEx_:GetController("onekey")
end

function QWorldBookletLevelView:InitUI()
	self:BindCfgUI()
end

function QWorldBookletLevelView:AddUIListener()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		ActivityPointAction.ReceivePointReward(self.receiveList_)
	end)
end

function QWorldBookletLevelView:IndexItem(arg_7_1, arg_7_2)
	arg_7_2:SetData(self.showIdList_[arg_7_1].id, self.showIdList_[arg_7_1].ind, self.showIdList_[arg_7_1].state)
end

function QWorldBookletLevelView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	self.curLv_, self.maxLv_ = QWorldBookletTools.GetNdLevelInfo()
	self.levelText.text = self.curLv_ .. "<size=60>/" .. self.maxLv_ .. "</size>"
	self.levelText_.text = self.curLv_ .. "<size=60>/" .. self.maxLv_ .. "</size>"

	self:UpdateView()
	manager.redPoint:bindUIandKey(self.receiveBtn_.transform, RedPointConst.QWORLD_BOOKLET_LEVEL_REWARD)
	manager.notify:RegistListener(RECEIVE_POINT_REWARD, self.receivePointRewardHandler_)
end

function QWorldBookletLevelView:OnExit()
	manager.windowBar:HideBar()
	manager.redPoint:unbindUIandKey(self.receiveBtn_.transform, RedPointConst.QWORLD_BOOKLET_LEVEL_REWARD)
	manager.notify:RemoveListener(RECEIVE_POINT_REWARD, self.receivePointRewardHandler_)
end

function QWorldBookletLevelView:OnReceivePointReward()
	self:UpdateView()
	QWorldBookletTools.UpdateLevelRewardRedPoint()
end

function QWorldBookletLevelView:UpdateView()
	self.receiveList_ = {}
	self.showIdList_ = {}

	local var_11_0 = 1
	local var_11_1 = false

	for iter_11_0, iter_11_1 in ipairs(self.idList_) do
		local var_11_2 = ""

		if ActivityPointData:IsCompleteID(iter_11_1) then
			var_11_2 = "complete"
		elseif iter_11_0 <= self.curLv_ then
			var_11_2 = "receive"

			table.insert(self.receiveList_, iter_11_1)

			if not var_11_1 then
				var_11_1 = true
				var_11_0 = iter_11_0
			end
		else
			var_11_2 = "lock"

			if not var_11_1 then
				var_11_1 = true
				var_11_0 = iter_11_0
			end
		end

		table.insert(self.showIdList_, {
			id = iter_11_1,
			ind = iter_11_0,
			state = var_11_2
		})
	end

	self.levelLuaList_:StartScroll(#self.showIdList_)
	self.levelLuaList_:ScrollToIndex(var_11_0, false, false)
	self.onekeyController_:SetSelectedState(#self.receiveList_ > 0 and "true" or "false")
end

function QWorldBookletLevelView:Dispose()
	QWorldBookletLevelView.super.Dispose(self)

	if self.levelLuaList_ then
		self.levelLuaList_:Dispose()

		self.levelLuaList_ = nil
	end
end

return QWorldBookletLevelView
