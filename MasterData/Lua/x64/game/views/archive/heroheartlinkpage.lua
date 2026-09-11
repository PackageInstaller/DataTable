local HeroHeartLinkPage = class("HeroHeartLinkPage", ReduxView)

function HeroHeartLinkPage:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function HeroHeartLinkPage:Init()
	self.itemList_ = {}
	self.dataList_ = {}
	self.heartLinkVoice_ = {
		HeroVoiceCfg.get_id_list_by_file.trust1[1],
		HeroVoiceCfg.get_id_list_by_file.trust2[1],
		HeroVoiceCfg.get_id_list_by_file.trust3[1],
		HeroVoiceCfg.get_id_list_by_file.trust4[1],
		HeroVoiceCfg.get_id_list_by_file.trust5[1]
	}

	self:InitUI()
	self:AddUIListener()
end

function HeroHeartLinkPage:InitUI()
	self:BindCfgUI()

	self.controller_ = ControllerUtil.GetController(self.gameObject_.transform, "conName")
end

function HeroHeartLinkPage:AddUIListener()
	return
end

function HeroHeartLinkPage:UpdateData()
	self.dataList_ = {}

	for iter_5_0 = 1, 100 do
		if not HeroRecordCfg[self.archiveID_]["heart_chain" .. iter_5_0] or HeroRecordCfg[self.archiveID_]["heart_chain" .. iter_5_0] == "" then
			break
		end

		local var_5_0, var_5_1, var_5_2 = IsConditionAchieved(GameSetting.heart_chain_unlock_condition.value[iter_5_0], {
			heroId = self.archiveID_
		})

		self.dataList_[1] = {
			isUnlock = var_5_0,
			current = var_5_1,
			all = var_5_2,
			id = iter_5_0,
			index = 1
		}
	end

	table.sort(self.dataList_, function(arg_6_0, arg_6_1)
		if arg_6_0.isUnlock ~= arg_6_1.isUnlock then
			return arg_6_0.isUnlock
		end

		return arg_6_0.id < arg_6_1.id
	end)
end

function HeroHeartLinkPage:RefreshUI(arg_7_1, arg_7_2)
	self.archiveID_ = arg_7_1
	self.heroID_ = arg_7_2

	if not table.indexof(GameDisplayCfg.heart_chain_missing.value, arg_7_2) then
		self:UpdateData()

		local var_7_0 = 1

		for iter_7_0, iter_7_1 in ipairs(self.dataList_) do
			self.itemList_[iter_7_0] = self.itemList_[iter_7_0] or HeartLinkItem.New(self.itemGo_)

			self.itemList_[iter_7_0]:RegisterRefresh(handler(self, self.UpdateLayout))
			self.itemList_[iter_7_0]:RefreshUI(self.archiveID_, iter_7_1)

			var_7_0 = var_7_0 + 1
		end

		for iter_7_2 = var_7_0, #self.itemList_ do
			self.itemList_[iter_7_2]:Hide()
		end

		self.controller_:SetSelectedState("true")
	else
		self.controller_:SetSelectedState("false")
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.contentTrs_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.contentTrs_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.contentTrs_)
end

function HeroHeartLinkPage:OnExit()
	for iter_8_0 = 1, #self.itemList_ do
		self.itemList_[iter_8_0]:OnExit()
	end
end

function HeroHeartLinkPage:UpdateLayout(arg_9_1)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.contentTrs_)
	self:PlayVoice(arg_9_1)
end

function HeroHeartLinkPage:PlayVoice(arg_10_1)
	local var_10_0 = self.heartLinkVoice_[arg_10_1]

	if self.heartLinkVoice_[arg_10_1] == nil then
		return
	end

	SDKTools.SendMessageToSDK("hero_sound", {
		hero_id = self.heroID_,
		sound_id = self.heartLinkVoice_[arg_10_1]
	})
	self.interruptFunc_()

	if self.delayPlayTimer_ then
		self.delayPlayTimer_:Stop()

		self.delayPlayTimer_ = nil
	end

	self.delayPlayTimer_ = Timer.New(function()
		if manager.audio:IsStoppedOfVoice() then
			self.delayPlayTimer_:Stop()

			self.delayPlayTimer_ = nil

			HeroTools.PlayVoice(self.heroID_, HeroVoiceCfg[var_10_0].file, HeroVoiceCfg[var_10_0].type)

			self.timer_ = TimeTools.StartAfterSeconds(math.max(HeroTools.GetTalkLength(self.heroID_, HeroVoiceCfg[var_10_0].file, HeroVoiceCfg[var_10_0].type), 0.017) / 1000, function()
				self:StopVoice()
			end, {})
		end
	end, 0.033, -1)

	self.delayPlayTimer_:Start()

	self.textinfoText_.text = GetI18NText(HeroVoiceDescCfg.Get(self.heroID_, self.heartLinkVoice_[arg_10_1]))
end

function HeroHeartLinkPage:StopVoice()
	if self.delayPlayTimer_ then
		self.delayPlayTimer_:Stop()

		self.delayPlayTimer_ = nil
	end

	manager.audio:StopVoiceImmediate()

	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function HeroHeartLinkPage:RegisterInterruptVoice(arg_14_1)
	self.interruptFunc_ = arg_14_1
end

function HeroHeartLinkPage:Dispose()
	for iter_15_0, iter_15_1 in pairs(self.itemList_) do
		iter_15_1:Dispose()
	end

	HeroHeartLinkPage.super.Dispose(self)
end

return HeroHeartLinkPage
