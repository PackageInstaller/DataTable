local HeartLinkItem = class("HeartLinkItem", ReduxView)

function HeartLinkItem:OnCtor(arg_1_1)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_1.transform.parent.transform)
	self.transform_ = arg_1_1.transform

	SetActive(self.gameObject_, true)
	self:Init()
end

function HeartLinkItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function HeartLinkItem:InitUI()
	self:BindCfgUI()

	self.canRead_ = false
	self.controller_ = ControllerUtil.GetController(self.gameObject_.transform, "conName")
end

function HeartLinkItem:RegisterRefresh(arg_4_1)
	self.RefreshParentLayout_ = arg_4_1
end

function HeartLinkItem:AddUIListener()
	self:AddBtnListener(self.unlockbtnBtn_, nil, function()
		self:SetUnlockState(true)
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.itemTrs_)
		self.RefreshParentLayout_(self.ID_)
		SDKTools.SendMessageToSDK("record_unlock", {
			record_id = self.archiveID_,
			chain_id = self.ID_
		})

		if self.canRead_ then
			HeroAction.ReadHeartLink(self.archiveID_, self.ID_)

			self.canRead_ = false
		end
	end)
end

function HeartLinkItem:RefreshUI(arg_7_1, arg_7_2)
	self.archiveID_ = arg_7_1
	self.ID_ = arg_7_2.id

	local var_7_3 = arg_7_2.isUnlock

	if not arg_7_2.isUnlock then
		self.controller_:SetSelectedState("lock")

		self.locktexttitleText_.text = string.format(GetTips("HERO_RECORD_HEART_CHAIN"), self.ID_)
		self.textconditionText_.text = GetI18NText(ConditionCfg[GameSetting.heart_chain_unlock_condition.value[self.ID_]].desc)
	else
		self:SetUnlockState()

		self.locktexttitleText_.text = string.format(GetTips("HERO_RECORD_HEART_CHAIN"), self.ID_)
		self.unlocktexttitleText_.text = string.format(GetTips("HERO_RECORD_HEART_CHAIN"), self.ID_)
		self.textinfoText_.text = HeroRecordCfg[self.archiveID_]["heart_chain" .. self.ID_]
	end

	self.canRead_ = not ArchiveData:IsHeartRead(self.archiveID_, self.ID_) and var_7_3
end

function HeartLinkItem:SetUnlockState(arg_8_1)
	arg_8_1 = arg_8_1 or ArchiveData:IsHeartRead(self.archiveID_, self.ID_)

	if arg_8_1 then
		self.controller_:SetSelectedState("unlock_open")
	else
		self.controller_:SetSelectedState("unlock_close")
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.itemTrs_)
	self.RefreshParentLayout_()
end

function HeartLinkItem:Hide()
	SetActive(self.gameObject_, false)
end

function HeartLinkItem:OnExit()
	return
end

function HeartLinkItem:Dispose()
	HeartLinkItem.super.Dispose(self)
end

return HeartLinkItem
