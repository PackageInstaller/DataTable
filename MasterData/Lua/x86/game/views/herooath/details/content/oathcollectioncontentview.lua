local OathCollectionContentView = class("OathCollectionContentView", BaseView)

local function var_0_1()
	local var_1_0 = {}

	for iter_1_0, iter_1_1 in pairs({
		story = OathHeroStorySubView,
		archieve = OathHeroArchieveSubView,
		plot = OathHeroPlotSubView,
		voice = OathHeroVoiceArchieveSubView
	}) do
		var_1_0[iter_1_0] = {
			cls = iter_1_1
		}
	end

	return var_1_0
end

function OathCollectionContentView:Ctor(arg_2_1)
	self.managedObj = {}

	if isNil(arg_2_1) then
		arg_2_1 = Asset.Instantiate(self:UIName())

		table.insert(self.managedObj, arg_2_1)
	end

	self.gameObject_ = arg_2_1
	self.transform_ = arg_2_1.transform
	self.selectSubPage = nil
	self.cache = var_0_1()

	self:BindCfgUI()
	self:InitUI()
end

function OathCollectionContentView:UIName()
	return "Widget/System/Hero_Oath/OathDetailsView/HeroOathCollectionContent"
end

function OathCollectionContentView:InitUI()
	self.subtitleBubble = MainHomeView_SubtitleBubble.New(self.dialogBoxGo_)
	self.tabs = {
		{
			page = "story",
			com = self.storyTab_,
			obj = self.storyPage_
		},
		{
			page = "archieve",
			com = self.archieveTab_,
			obj = self.archievePage_
		},
		{
			page = "plot",
			com = self.plotTab_,
			obj = self.plotPage_
		},
		{
			page = "voice",
			com = self.voiceTab_,
			obj = self.voicePage_
		}
	}
	self.context = {
		parentView = self
	}

	for iter_4_0, iter_4_1 in ipairs(self.tabs) do
		self:AddToggleListener(iter_4_1.com, function(arg_5_0)
			if arg_5_0 then
				self:OnTabSelect(iter_4_0)
			end
		end)
	end
end

function OathCollectionContentView:GetDefaultPageIndex()
	return (self.params_ and self.params_.selectPage or nil) and self.params_.selectPage
end

function OathCollectionContentView:OnEnter(arg_7_1)
	self.params_ = arg_7_1

	local var_7_0 = nullable(arg_7_1, "selectPage") or self.selectSubPage or 1

	self.tabs[var_7_0].com.isOn = true

	self:ChangeSubView(var_7_0)

	if self.params_ and self.params_.selectPage then
		self.params_.selectPage = nil
	end
end

function OathCollectionContentView:OnExit()
	for iter_8_0, iter_8_1 in pairs(self.tabs) do
		if iter_8_1.com then
			manager.redPoint:unbindUIandKey(iter_8_1.com.transform, (OathTools.GetOathContentRedKey(iter_8_1.page, self.heroID)))
		end
	end

	self:ChangeSubView(nil)
end

function OathCollectionContentView:OnShow()
	return
end

function OathCollectionContentView:OnHide()
	return
end

function OathCollectionContentView:GetHeroID()
	return self.heroID
end

function OathCollectionContentView:PlayVoice(arg_12_1, arg_12_2)
	self:StopVoice()

	self.playingVoiceID = arg_12_1

	self:RefreshDialog(arg_12_1)
	self:PlayVoiceByDelayTime(arg_12_1, arg_12_2)
end

function OathCollectionContentView:StopVoice()
	self.playingVoiceID = nil

	self.subtitleBubble:SetVisible(false)
	self:StopDelayTimer()
	self:StopDisplayTimer()
	manager.audio:StopVoiceImmediate()
end

function OathCollectionContentView:IsPlaying()
	return self.playingVoiceID
end

function OathCollectionContentView:GetTalkSeconds(arg_15_1, arg_15_2, arg_15_3)
	return math.max(manager.audio:GetVoiceLength(arg_15_1, arg_15_2, arg_15_3), 3000) / 1000
end

function OathCollectionContentView:PlayVoiceByDelayTime(arg_16_1, arg_16_2)
	self:StopDelayTimer()

	self.delayPlayTimer = Timer.New(function()
		if manager.audio:IsStoppedOfVoice() then
			self:StopDelayTimer()

			local var_17_0, var_17_1, var_17_2, var_17_3 = HeroTools.PlayVoice(self:GetHeroID(), HeroVoiceCfg[arg_16_1].file, HeroVoiceCfg[arg_16_1].type)

			self.timer = TimeTools.StartAfterSeconds(self:GetTalkSeconds(var_17_1, var_17_2, var_17_3), function()
				self:StopVoice()

				if arg_16_2 then
					arg_16_2()
				end
			end, {})
		end
	end, 0.033, -1)

	self.delayPlayTimer:Start()
end

function OathCollectionContentView:RefreshDialog(arg_19_1)
	self.subtitleBubble:SetVisible(true)
	self.subtitleBubble:SetContent((HeroVoiceDescCfg.Get(self:GetHeroID(), arg_19_1)))
end

function OathCollectionContentView:StopDisplayTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end
end

function OathCollectionContentView:StopDelayTimer()
	if self.delayPlayTimer then
		self.delayPlayTimer:Stop()

		self.delayPlayTimer = nil
	end
end

function OathCollectionContentView:RefreshUI(arg_22_1)
	self.heroID = arg_22_1

	if self.subView then
		self.subView:RefreshUI(arg_22_1)
		OathSupportData:SetReadOathContent(self.heroID, self:GetViewFromIdx(self.selectSubPage))
	end

	for iter_22_0, iter_22_1 in pairs(self.tabs) do
		if iter_22_1.com then
			manager.redPoint:bindUIandKey(iter_22_1.com.transform, (OathTools.GetOathContentRedKey(iter_22_1.page, self.heroID)))
		end
	end

	self.subtitleBubble:SetBgStyleByHero(arg_22_1)
end

function OathCollectionContentView:Dispose()
	for iter_23_0, iter_23_1 in pairs(self.cache) do
		if iter_23_1.inst then
			iter_23_1.inst:Dispose()
		end
	end

	self.cache = nil
	self.selectSubPage = nil
	self.subView = nil

	for iter_23_2, iter_23_3 in ipairs(self.managedObj) do
		Object.Destroy(iter_23_3)
	end

	self.managedObj = nil

	self.subtitleBubble:Dispose()
	OathCollectionContentView.super.Dispose(self)
end

function OathCollectionContentView:ChangeSubView(arg_24_1)
	if self.selectSubPage == arg_24_1 then
		return
	end

	self:StopVoice()

	if self.subView then
		self.subView:OnExit()
	end

	local var_24_0 = self.tabs[arg_24_1]

	if self.tabs[arg_24_1] then
		self.subView = self.cache[var_24_0.page].inst or self.cache[var_24_0.page].cls.New(var_24_0.obj, self.context)
		self.cache[var_24_0.page].inst = self.subView

		self.subView:OnEnter()
	else
		self.subView = nil
	end

	self.selectSubPage = arg_24_1
end

function OathCollectionContentView:OnTabSelect(arg_25_1)
	if not self.heroID then
		return
	end

	self:ChangeSubView(arg_25_1)

	if self.subView then
		self.subView:RefreshUI(self.heroID)
		OathSupportData:SetReadOathContent(self.heroID, self:GetViewFromIdx(arg_25_1))
	end
end

function OathCollectionContentView:GetViewFromIdx(arg_26_1)
	return nullable(self.tabs, arg_26_1, "page")
end

return OathCollectionContentView
