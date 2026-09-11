local GuildActivitySPDispatchItemView = class("GuildActivitySPDispatchItemView", ReduxView)

function GuildActivitySPDispatchItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function GuildActivitySPDispatchItemView:Init()
	self:InitUI()
	self:AddUIListener()
end

function GuildActivitySPDispatchItemView:InitUI()
	self:BindCfgUI()

	self.statusController_ = ControllerUtil.GetController(self.gameObject_.transform, "status")
	self.selectController_ = ControllerUtil.GetController(self.gameObject_.transform, "select")
	self.dispatchTypeController_ = ControllerUtil.GetController(self.gameObject_.transform, "dispatchType")
end

function GuildActivitySPDispatchItemView:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if not table.indexof(ActivityClubSPLevelSettingCfg[GuildActivitySPData:GetCurRateID((GuildActivitySPData:GetCurRunActivityID()))].dispatch, self.catId_) then
			ShowTips(string.format(GetTips("ACTIVITY_CLUB_FIGHT_MEMBER_LOCK_TIP"), tostring((GuildActivitySPData:GetCatUnlockLevel(self.catId_)))))

			return
		end

		if self.selectHandler_ ~= nil then
			self.selectHandler_(self.index_, self.nodeId_)
		end
	end)
end

function GuildActivitySPDispatchItemView:AddEventListeners()
	return
end

function GuildActivitySPDispatchItemView:SetSelect(arg_7_1)
	self.selectController_:SetSelectedState(arg_7_1 and "true" or "false")
end

function GuildActivitySPDispatchItemView:SetSelectHandler(arg_8_1)
	self.selectHandler_ = arg_8_1
end

function GuildActivitySPDispatchItemView:SetData(arg_9_1, arg_9_2, arg_9_3)
	self.index_ = arg_9_1
	self.nodeId_ = arg_9_3
	self.nodeData_ = GuildActivitySPData:GetNodeData(arg_9_3)
	self.nodeCfg_ = ActivityClubSPCfg[arg_9_3]
	self.cfg_ = ChipCfg[arg_9_2]
	self.catId_ = arg_9_2

	self:UpdateView()

	self.iconImg_.sprite = ItemTools.getItemSprite(tonumber((GuildActivitySpTools.GetCurCurrencyID(GuildActivitySPData:GetCurMainActivityID(), 1))))
end

function GuildActivitySPDispatchItemView:UpdateView()
	self.energyLabel_.text = self.nodeCfg_.token_get
	self.nameLabel_.text = self.cfg_.suit_name
	self.icon_.sprite = getSpriteViaConfig("ChipSkillIcon", ChipCfg[self.catId_].picture_id)

	local var_10_0, var_10_1 = GuildActivitySPData:IsCatDispatched(self.catId_)

	if var_10_0 then
		local var_10_2 = GuildActivitySPData:GetNodeData(var_10_1)

		self.energyLabel_.text = "+" .. ActivityClubSPCfg[var_10_1].token_get .. "/"
		self.levelLabel_.text = "Lv." .. ActivityClubSPCfg[var_10_1].level

		self.statusController_:SetSelectedState("dispatch")

		self.grideName.text = GetTips(GuildActivitySPConst.NodeType[ActivityClubSPCfg[var_10_1].type])
	elseif (table.indexof(ActivityClubSPLevelSettingCfg[GuildActivitySPData:GetCurRateID((GuildActivitySPData:GetCurRunActivityID()))].dispatch, self.catId_) or nil) and true then
		self.statusController_:SetSelectedState("notdispatched")
	else
		self.statusController_:SetSelectedState("lock")

		self.lockLabel_.text = string.format(GetTips("ACTIVITY_CLUB_FIGHT_MEMBER_LOCK_TIP"), tostring((GuildActivitySPData:GetCatUnlockLevel(self.catId_))))
	end
end

function GuildActivitySPDispatchItemView:OnEnter()
	self:AddEventListeners()
end

function GuildActivitySPDispatchItemView:OnExit()
	self:RemoveAllEventListener()
end

function GuildActivitySPDispatchItemView:OnMainHomeViewTop()
	return
end

function GuildActivitySPDispatchItemView:Dispose()
	self.data_ = nil

	GuildActivitySPDispatchItemView.super.Dispose(self)
end

return GuildActivitySPDispatchItemView
