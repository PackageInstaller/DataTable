local var_0_0 = class("OathCollectionContentView", BaseView)

local function var_0_1()
	local var_1_0 = {
		story = OathHeroStorySubView,
		archieve = OathHeroArchieveSubView,
		plot = OathHeroPlotSubView,
		voice = OathHeroVoiceArchieveSubView
	}
	local var_1_1 = {}

	for iter_1_0, iter_1_1 in pairs(var_1_0) do
		var_1_1[iter_1_0] = {
			cls = iter_1_1
		}
	end

	return var_1_1
end

function var_0_0.Ctor(arg_2_0, arg_2_1)
	arg_2_0.managedObj = {}

	if isNil(arg_2_1) then
		arg_2_1 = Asset.Instantiate(arg_2_0:UIName())

		table.insert(arg_2_0.managedObj, arg_2_1)
	end

	arg_2_0.gameObject_ = arg_2_1
	arg_2_0.transform_ = arg_2_1.transform
	arg_2_0.selectSubPage = nil
	arg_2_0.cache = var_0_1()

	arg_2_0:BindCfgUI()
	arg_2_0:InitUI()
end

function var_0_0.UIName(arg_3_0)
	return "Widget/System/Hero_Oath/OathDetailsView/HeroOathCollectionContent"
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0.subtitleBubble = MainHomeView_SubtitleBubble.New(arg_4_0.dialogBoxGo_)
	arg_4_0.tabs = {
		{
			page = "story",
			com = arg_4_0.storyTab_,
			obj = arg_4_0.storyPage_
		},
		{
			page = "archieve",
			com = arg_4_0.archieveTab_,
			obj = arg_4_0.archievePage_
		},
		{
			page = "plot",
			com = arg_4_0.plotTab_,
			obj = arg_4_0.plotPage_
		},
		{
			page = "voice",
			com = arg_4_0.voiceTab_,
			obj = arg_4_0.voicePage_
		}
	}
	arg_4_0.context = {
		parentView = arg_4_0
	}

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.tabs) do
		local var_4_0 = iter_4_1.com
		local var_4_1 = iter_4_1.page

		arg_4_0:AddToggleListener(var_4_0, function(arg_5_0)
			if arg_5_0 then
				arg_4_0:OnTabSelect(iter_4_0)
			end
		end)
	end
end

function var_0_0.GetDefaultPageIndex(arg_6_0)
	local var_6_0 = 1

	if arg_6_0.params_ and arg_6_0.params_.selectPage then
		var_6_0 = arg_6_0.params_.selectPage
	end

	return var_6_0
end

function var_0_0.OnEnter(arg_7_0, arg_7_1)
	arg_7_0.params_ = arg_7_1

	local var_7_0 = nullable(arg_7_1, "selectPage") or arg_7_0.selectSubPage or 1

	arg_7_0.tabs[var_7_0].com.isOn = true

	arg_7_0:ChangeSubView(var_7_0)

	if arg_7_0.params_ and arg_7_0.params_.selectPage then
		arg_7_0.params_.selectPage = nil
	end
end

function var_0_0.OnExit(arg_8_0)
	for iter_8_0, iter_8_1 in pairs(arg_8_0.tabs) do
		if iter_8_1.com then
			local var_8_0 = OathTools.GetOathContentRedKey(iter_8_1.page, arg_8_0.heroID)

			manager.redPoint:unbindUIandKey(iter_8_1.com.transform, var_8_0)
		end
	end

	arg_8_0:ChangeSubView(nil)
end

function var_0_0.OnShow(arg_9_0)
	return
end

function var_0_0.OnHide(arg_10_0)
	return
end

function var_0_0.GetHeroID(arg_11_0)
	return arg_11_0.heroID
end

function var_0_0.PlayVoice(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0:StopVoice()

	arg_12_0.playingVoiceID = arg_12_1

	arg_12_0:RefreshDialog(arg_12_1)
	arg_12_0:PlayVoiceByDelayTime(arg_12_1, arg_12_2)
end

function var_0_0.StopVoice(arg_13_0)
	arg_13_0.playingVoiceID = nil

	arg_13_0.subtitleBubble:SetVisible(false)
	arg_13_0:StopDelayTimer()
	arg_13_0:StopDisplayTimer()
	manager.audio:StopVoiceImmediate()
end

function var_0_0.IsPlaying(arg_14_0)
	return arg_14_0.playingVoiceID
end

function var_0_0.GetTalkSeconds(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = manager.audio:GetVoiceLength(arg_15_1, arg_15_2, arg_15_3)

	return math.max(var_15_0, 3000) / 1000
end

function var_0_0.PlayVoiceByDelayTime(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0:StopDelayTimer()

	arg_16_0.delayPlayTimer = Timer.New(function()
		if manager.audio:IsStoppedOfVoice() then
			arg_16_0:StopDelayTimer()

			local var_17_0, var_17_1, var_17_2, var_17_3 = HeroTools.PlayVoice(arg_16_0:GetHeroID(), HeroVoiceCfg[arg_16_1].file, HeroVoiceCfg[arg_16_1].type)
			local var_17_4 = arg_16_0:GetTalkSeconds(var_17_1, var_17_2, var_17_3)

			arg_16_0.timer = TimeTools.StartAfterSeconds(var_17_4, function()
				arg_16_0:StopVoice()

				if arg_16_2 then
					arg_16_2()
				end
			end, {})
		end
	end, 0.033, -1)

	arg_16_0.delayPlayTimer:Start()
end

function var_0_0.RefreshDialog(arg_19_0, arg_19_1)
	local var_19_0 = HeroVoiceDescCfg.Get(arg_19_0:GetHeroID(), arg_19_1)

	arg_19_0.subtitleBubble:SetVisible(true)
	arg_19_0.subtitleBubble:SetContent(var_19_0)
end

function var_0_0.StopDisplayTimer(arg_20_0)
	if arg_20_0.timer then
		arg_20_0.timer:Stop()

		arg_20_0.timer = nil
	end
end

function var_0_0.StopDelayTimer(arg_21_0)
	if arg_21_0.delayPlayTimer then
		arg_21_0.delayPlayTimer:Stop()

		arg_21_0.delayPlayTimer = nil
	end
end

function var_0_0.RefreshUI(arg_22_0, arg_22_1)
	arg_22_0.heroID = arg_22_1

	if arg_22_0.subView then
		arg_22_0.subView:RefreshUI(arg_22_1)
		OathSupportData:SetReadOathContent(arg_22_0.heroID, arg_22_0:GetViewFromIdx(arg_22_0.selectSubPage))
	end

	for iter_22_0, iter_22_1 in pairs(arg_22_0.tabs) do
		if iter_22_1.com then
			local var_22_0 = OathTools.GetOathContentRedKey(iter_22_1.page, arg_22_0.heroID)

			manager.redPoint:bindUIandKey(iter_22_1.com.transform, var_22_0)
		end
	end

	arg_22_0.subtitleBubble:SetBgStyleByHero(arg_22_1)
end

function var_0_0.Dispose(arg_23_0)
	for iter_23_0, iter_23_1 in pairs(arg_23_0.cache) do
		if iter_23_1.inst then
			iter_23_1.inst:Dispose()
		end
	end

	arg_23_0.cache = nil
	arg_23_0.selectSubPage = nil
	arg_23_0.subView = nil

	for iter_23_2, iter_23_3 in ipairs(arg_23_0.managedObj) do
		Object.Destroy(iter_23_3)
	end

	arg_23_0.managedObj = nil

	arg_23_0.subtitleBubble:Dispose()
	var_0_0.super.Dispose(arg_23_0)
end

function var_0_0.ChangeSubView(arg_24_0, arg_24_1)
	if arg_24_0.selectSubPage == arg_24_1 then
		return
	end

	arg_24_0:StopVoice()

	if arg_24_0.subView then
		arg_24_0.subView:OnExit()
	end

	local var_24_0 = arg_24_0.tabs[arg_24_1]

	if var_24_0 then
		local var_24_1 = var_24_0.page
		local var_24_2 = var_24_0.obj
		local var_24_3 = arg_24_0.cache[var_24_1]

		arg_24_0.subView = var_24_3.inst or var_24_3.cls.New(var_24_2, arg_24_0.context)
		var_24_3.inst = arg_24_0.subView

		arg_24_0.subView:OnEnter()
	else
		arg_24_0.subView = nil
	end

	arg_24_0.selectSubPage = arg_24_1
end

function var_0_0.OnTabSelect(arg_25_0, arg_25_1)
	if not arg_25_0.heroID then
		return
	end

	arg_25_0:ChangeSubView(arg_25_1)

	if arg_25_0.subView then
		arg_25_0.subView:RefreshUI(arg_25_0.heroID)
		OathSupportData:SetReadOathContent(arg_25_0.heroID, arg_25_0:GetViewFromIdx(arg_25_1))
	end
end

function var_0_0.GetViewFromIdx(arg_26_0, arg_26_1)
	return nullable(arg_26_0.tabs, arg_26_1, "page")
end

return var_0_0
