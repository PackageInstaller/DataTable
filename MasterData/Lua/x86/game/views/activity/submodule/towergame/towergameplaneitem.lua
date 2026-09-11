local TowerGamePlaneItem = class("TowerGamePlaneItem", ReduxView)

function TowerGamePlaneItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI(arg_1_1)

	self.islockcontroller_ = ControllerUtil.GetController(self.transform_, "islock")
	self.imagecontroller_ = ControllerUtil.GetController(self.transform_, "image")
end

function TowerGamePlaneItem:SetData(arg_2_1, arg_2_2)
	self.cfg = TowerGameData:GetPlaneCfgByTypeAndIndex(arg_2_2, arg_2_1)
	self.nametext_.text = GetI18NText(self.cfg.name)
	self.desctext_.text = GetI18NText(self.cfg.desc)

	self.imagecontroller_:SetSelectedState(self.cfg.id)

	if TowerGameData:GetPlaneIsUnlock(self.cfg.id) then
		self.islockcontroller_:SetSelectedState("false")
	else
		self.islockcontroller_:SetSelectedState("true")

		self.locktext_.text = string.format(GetTips("ACTIVITY_TOWER_DEFENSE_UNLOCK_DESC"), GetI18NText(BattleTowerGameCfg[TowerGameCfg[TowerGamePlaneCfg[self.cfg.id].condition].stage_id].name))
	end
end

return TowerGamePlaneItem
