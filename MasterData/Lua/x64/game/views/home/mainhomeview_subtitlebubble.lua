local var_0_0 = class("MainHomeView.SubtitleBubble", BaseView)

function var_0_0:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function var_0_0:Init()
	self:BindCfgUI()

	self.bgController = self.controllers_:GetController("bg")
end

function var_0_0:Dispose()
	self:RemoveAllEventListener()
	var_0_0.super.Dispose(self)
end

function var_0_0:OnEnter()
	self:RegisterEvents()
end

function var_0_0:OnExit()
	self:RemoveAllEventListener()
end

function var_0_0:RegisterEvents()
	self:RegistEventListener(HOME_POSTER_TALK, handler(self, self.OnHomePosterTalk))
end

function var_0_0:SetVisible(arg_7_1)
	SetActive(self.gameObject_, arg_7_1)
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

function var_0_0:Clear()
	self:SetVisible(false)
	var_0_1(self)
end

function var_0_0:Show(arg_12_1, arg_12_2)
	self:SetVisible(true)
	var_0_2(self, arg_12_1, arg_12_2)
end

function var_0_0:StartBubble(arg_13_1, arg_13_2, arg_13_3)
	self:SetContent(arg_13_1)
	self:Show(arg_13_2, arg_13_3)
end

function var_0_0:OnHomePosterTalk(arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = HeroVoiceDescCfg.GetConfig(arg_14_1, arg_14_2)

	if var_14_0 then
		if (var_14_0.hide_word or 0) ~= 0 or var_14_0.content == "" then
			self:Clear()
		else
			self:SetBgStyleBySkin(arg_14_1)
			self:StartBubble(var_14_0.content, arg_14_3 / 1000)
		end
	end
end

function var_0_0:SetContent(arg_15_1)
	if not isNil(self.talkLabel_) then
		self.talkLabel_.text = arg_15_1
	end

	if not isNil(self.scrollRect_) then
		self.scrollRect_.normalizedPosition = Vector2(0, 1)
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

function var_0_0:SetBgStyleBySkin(arg_17_1)
	self:SetBgStyleByHero((HeroCfg[SkinCfg[arg_17_1].hero] or HeroCfg[var_0_3(arg_17_1)]).id)
end

function var_0_0:SetBgStyleByHero(arg_18_1)
	self:SetBgStyle((OathTools.IsOath(arg_18_1) or nil) and (var_0_0.BgStyle.Oath or var_0_0.BgStyle.Normal))
end

var_0_0.BgStyle = {
	Oath = "oath",
	Normal = "normal"
}

function var_0_0:SetBgStyle(arg_19_1)
	self.bgController:SetSelectedState(arg_19_1)
end

return var_0_0
