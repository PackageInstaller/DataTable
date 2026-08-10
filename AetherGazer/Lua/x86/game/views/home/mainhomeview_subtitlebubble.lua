local var_0_0 = class("MainHomeView.SubtitleBubble", BaseView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.bgController = arg_2_0.controllers_:GetController("bg")
end

function var_0_0.Dispose(arg_3_0)
	arg_3_0:RemoveAllEventListener()
	var_0_0.super.Dispose(arg_3_0)
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0:RegisterEvents()
end

function var_0_0.OnExit(arg_5_0)
	arg_5_0:RemoveAllEventListener()
end

function var_0_0.RegisterEvents(arg_6_0)
	arg_6_0:RegistEventListener(HOME_POSTER_TALK, handler(arg_6_0, arg_6_0.OnHomePosterTalk))
end

function var_0_0.SetVisible(arg_7_0, arg_7_1)
	SetActive(arg_7_0.gameObject_, arg_7_1)
end

local function var_0_1(arg_8_0)
	if arg_8_0.talkBubbleTimer ~= nil then
		arg_8_0.talkBubbleTimer:Stop()

		arg_8_0.talkBubbleTimer = nil
	end
end

local function var_0_2(arg_9_0, arg_9_1, arg_9_2)
	var_0_1(arg_9_0)

	arg_9_0.talkBubbleTimer = TimeTools.StartAfterSeconds(arg_9_1, function()
		arg_9_0:Clear()

		if arg_9_2 then
			arg_9_2()
		end
	end, {})
end

function var_0_0.Clear(arg_11_0)
	arg_11_0:SetVisible(false)
	var_0_1(arg_11_0)
end

function var_0_0.Show(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0:SetVisible(true)
	var_0_2(arg_12_0, arg_12_1, arg_12_2)
end

function var_0_0.StartBubble(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	arg_13_0:SetContent(arg_13_1)
	arg_13_0:Show(arg_13_2, arg_13_3)
end

function var_0_0.OnHomePosterTalk(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = HeroVoiceDescCfg.GetConfig(arg_14_1, arg_14_2)

	if var_14_0 then
		if (var_14_0.hide_word or 0) ~= 0 or var_14_0.content == "" then
			arg_14_0:Clear()
		else
			arg_14_0:SetBgStyleBySkin(arg_14_1)
			arg_14_0:StartBubble(var_14_0.content, arg_14_3 / 1000)
		end
	end
end

function var_0_0.SetContent(arg_15_0, arg_15_1)
	if not isNil(arg_15_0.talkLabel_) then
		arg_15_0.talkLabel_.text = arg_15_1
	end

	if not isNil(arg_15_0.scrollRect_) then
		arg_15_0.scrollRect_.normalizedPosition = Vector2(0, 1)
	end
end

local function var_0_3(arg_16_0)
	for iter_16_0, iter_16_1 in pairs(HeroSkinExtraFormCfg.get_id_list_by_original_hero_form_id) do
		for iter_16_2, iter_16_3 in pairs(iter_16_1) do
			if iter_16_2 == arg_16_0 then
				return iter_16_0
			end
		end
	end
end

function var_0_0.SetBgStyleBySkin(arg_17_0, arg_17_1)
	local var_17_0 = (HeroCfg[SkinCfg[arg_17_1].hero] or HeroCfg[var_0_3(arg_17_1)]).id

	arg_17_0:SetBgStyleByHero(var_17_0)
end

function var_0_0.SetBgStyleByHero(arg_18_0, arg_18_1)
	local var_18_0 = OathTools.IsOath(arg_18_1)

	arg_18_0:SetBgStyle(var_18_0 and var_0_0.BgStyle.Oath or var_0_0.BgStyle.Normal)
end

var_0_0.BgStyle = {
	Oath = "oath",
	Normal = "normal"
}

function var_0_0.SetBgStyle(arg_19_0, arg_19_1)
	arg_19_0.bgController:SetSelectedState(arg_19_1)
end

return var_0_0
