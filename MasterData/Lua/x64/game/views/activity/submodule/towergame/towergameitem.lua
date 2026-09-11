local TowerGameItem = class("TowerGameItem", ReduxView)

function TowerGameItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function TowerGameItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function TowerGameItem:InitUI()
	self:BindCfgUI()

	self.numcontroller_ = ControllerUtil.GetController(self.transform_, "num")
	self.statucontroller_ = ControllerUtil.GetController(self.transform_, "statu")
	self.isshowpointcontroller_ = ControllerUtil.GetController(self.transform_, "showpoint")
	self.selectcontroller_ = ControllerUtil.GetController(self.transform_, "select")
end

function TowerGameItem:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if ActivityData:GetActivityIsOpen(self.levelid_) then
			if self.selectCallBack_ ~= nil then
				self.selectCallBack_(self.levelid_, self.index_)
			end

			TowerGameData:SetLevel(self.levelid_)
			self:Go("towerGameSectionInfoView", {
				levelid = self.levelid_
			})
		elseif ActivityData:GetActivityData(self.levelid_).stopTime < manager.time:GetServerTime() then
			ShowTips(GetTips("TIME_OVER"))
		else
			ShowTips(string.format(GetTips("OPEN_TIME"), (manager.time:GetLostTimeStr(ActivityData:GetActivityData(self.levelid_).startTime))))
		end
	end)
end

function TowerGameItem:SetSelectCallBack(arg_6_1)
	self.selectCallBack_ = arg_6_1
end

function TowerGameItem:SetData(arg_7_1)
	self.index_ = arg_7_1
	self.levelid_ = TowerGameCfg.all[arg_7_1]
	self.nametext_.text = GetI18NText(BattleTowerGameCfg[TowerGameCfg[self.levelid_].stage_id].name)

	self.numcontroller_:SetSelectedState(string.format(arg_7_1))
	self.statucontroller_:SetSelectedState(TowerGameData:GetLevelStatuByLevelId(self.levelid_))

	local var_7_0, var_7_1 = TowerGameData:GetLevelIsShowPointByLevelID(self.levelid_)

	self.isshowpointcontroller_:SetSelectedState(var_7_0)

	self.pointtext_.text = var_7_1

	self:UpdateTime()
	manager.redPoint:bindUIandKey(self.transform_, string.format("%s_%s", RedPointConst.MARDUK_TOWERGAME_NOT_FIGHT, self.levelid_))
end

function TowerGameItem:RefreshSelect(arg_8_1)
	if self.levelid_ == arg_8_1 then
		self.selectcontroller_:SetSelectedState("true")
	else
		self.selectcontroller_:SetSelectedState("false")
	end
end

function TowerGameItem:UpdateTime()
	self.timetext_.text = ActivityData:GetActivityData(self.levelid_).stopTime < manager.time:GetServerTime() and GetTips("TIME_OVER") or string.format(GetTips("OPEN_TIME"), (manager.time:GetLostTimeStr(ActivityData:GetActivityData(self.levelid_).startTime)))
end

function TowerGameItem:Dispose()
	TowerGameItem.super.Dispose(self)
	manager.redPoint:unbindUIandKey(self.transform_, string.format("%s_%s", RedPointConst.MARDUK_TOWERGAME_NOT_FIGHT, self.levelid_))

	self.selectCallBack_ = nil
end

return TowerGameItem
