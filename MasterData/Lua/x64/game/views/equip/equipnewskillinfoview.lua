local EquipNewSkillInfoView = class("EquipNewSkillInfoView", ReduxView)

function EquipNewSkillInfoView:Ctor(arg_1_1)
	self.transform_ = arg_1_1.transform
	self.gameObject_ = arg_1_1

	self:InitUI()
	self:AddUIListener()
end

function EquipNewSkillInfoView:InitUI()
	self:BindCfgUI()

	self.skillInfoList_ = {}
	self.locationList = {}
	self.infoScrollHelper_ = LuaList.New(handler(self, self.indexInfoItem), self.skillListGo_, EquipSkillInfoItem)
	self.locationScrollHelper_ = LuaList.New(handler(self, self.indexLocationItem), self.locationListGo_, EquipSkillLocationItem)
	self.stateController_ = self.skillCon_:GetController("state")
	self.tabController_ = self.skillCon_:GetController("tab")
end

function EquipNewSkillInfoView:AddUIListener()
	self:AddBtnListener(self.btnSkill_, nil, function()
		self.tabController_:SetSelectedState("skill")
	end)
	self:AddBtnListener(self.btnLoacation_, nil, function()
		self.tabController_:SetSelectedState("location")
	end)
end

function EquipNewSkillInfoView:RefreshData(arg_6_1, arg_6_2, arg_6_3)
	self.handler_ = arg_6_1
	self.info_ = arg_6_2
	self.isShowLocate_ = arg_6_3

	self:RefreshInfoList()
	self:RefreshUI()
end

function EquipNewSkillInfoView:RefreshUI()
	self.icon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Equip/EquipSkillIcon/" .. self.skillCfg_.icon)
	self.name_.text = GetI18NText(self.skillCfg_.name)
	self.lv_.text = string.format("%s/%s", self.info_.num > self.skillCfg_.lvmax and string.format("<color=#FF000B>%s</color>", self.info_.num) or self.info_.num, self.skillCfg_.lvmax)

	self.stateController_:SetSelectedState(self.isShowLocate_ and "on" or "off")
	self.tabController_:SetSelectedState("skill")
	self.infoScrollHelper_:StartScroll(#self.skillInfoList_)

	if self.isShowLocate_ and self.info_.location then
		self.locationScrollHelper_:StartScroll(#self.info_.location)
	end
end

function EquipNewSkillInfoView:RefreshInfoList()
	self.skillInfoList_ = {}
	self.skillCfg_ = EquipSkillCfg[self.info_.id]

	for iter_8_0 = 1, self.skillCfg_.lvmax do
		local var_8_0 = {
			level = GetTips("LEVEL") .. string.format("%d", iter_8_0)
		}

		var_8_0.desc = GetCfgDescriptionWithValue(self.skillCfg_.desc[1], tostring(self.skillCfg_.upgrade / self.skillCfg_.percent * iter_8_0))

		if self.skillCfg_.desc_spec_value ~= nil and self.skillCfg_.desc_spec_value ~= "" then
			var_8_0.desc = string.gsub(desc, tostring(self.skillCfg_.upgrade / self.skillCfg_.percent * iter_8_0), self.skillCfg_.desc_spec_value[iter_8_0])
		end

		var_8_0.alpha = iter_8_0 <= self.info_.num and 1 or 0.5

		table.insert(self.skillInfoList_, var_8_0)
	end
end

function EquipNewSkillInfoView:indexInfoItem(arg_9_1, arg_9_2)
	arg_9_2:RefreshData(self, self.skillInfoList_[arg_9_1])
end

function EquipNewSkillInfoView:indexLocationItem(arg_10_1, arg_10_2)
	arg_10_2:RefreshData(self, self.info_.location[arg_10_1])
end

function EquipNewSkillInfoView:Dispose()
	if self.infoScrollHelper_ then
		self.infoScrollHelper_:Dispose()

		self.infoScrollHelper_ = nil
	end

	if self.locationScrollHelper_ then
		self.locationScrollHelper_:Dispose()

		self.locationScrollHelper_ = nil
	end

	EquipNewSkillInfoView.super.Dispose(self)
end

return EquipNewSkillInfoView
