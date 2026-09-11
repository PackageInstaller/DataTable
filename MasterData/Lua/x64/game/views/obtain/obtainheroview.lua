local ObtainHeroView = class("ObtainHeroView", require("game.views.obtain.ObtainBaseView"))

function ObtainHeroView:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2)
	self.transform_ = self.gameObject_.transform
end

function ObtainHeroView:Init()
	self:InitUI()
	ObtainHeroView.super.Init(self)
end

function ObtainHeroView:InitUI()
	self:BindCfgUI()

	self.portrait_.immediate = true
	self.starController_ = ControllerUtil.GetController(self.starControllerTrs_, "star")
	self.AdaptImg_ = self:FindCom("AdaptImage", nil, self.portrait_.transform)
	self.SimplePlayer_ = self:FindCom("VoiceOfObtainHeroSimplePlayer", "CriwareAudio")
end

function ObtainHeroView:PlayGetHeroVoice()
	local var_4_0 = self:GetHeroID()

	manager.audio:PlayVoice(string.format("vo_sys_%d", var_4_0), string.format("v_s_%d_%s", var_4_0, "get_cg"), string.format("vo_sys_%d.awb", var_4_0))
end

function ObtainHeroView:GetPlayable()
	return self.playableDirector_
end

function ObtainHeroView:GetHeroID()
	return (self.convert or nil) and (self.item.convert_from.id or self.item.id)
end

function ObtainHeroView:OnClick()
	local var_7_0 = self:GetPlayable()

	if not var_7_0 then
		return true
	end

	if var_7_0.time == 0 or var_7_0.time >= self:GetTimeLineEndTime() then
		return true
	else
		var_7_0.time = self:GetTimeLineEndTime()

		return false
	end
end

function ObtainHeroView:Show(arg_8_1)
	self.item = arg_8_1
	self.convert = ItemWillConvert(arg_8_1)

	if self.gameObject_ then
		SetActive(self.gameObject_, true)
	end

	if self.playableDirector_ then
		self.playableDirector_:Evaluate()
		self.playableDirector_:Play()
	end

	self:SetInfo(arg_8_1)
end

function ObtainHeroView:RefreshContent(arg_9_1, arg_9_2)
	self.portrait_.spriteSync = "TextureConfig/Character/Portrait/" .. arg_9_1

	self.AdaptImg_:AdaptImg()

	self.name_.text = HeroTools.GetHeroFullName(arg_9_1)
	self.camp_.sprite = getSprite("Atlas/CampItemAtlas", RaceEffectCfg[arg_9_2.race].icon)

	local var_9_0 = math.min(ItemCfg[arg_9_1].display_rare, 5)

	self.starController_:SetSelectedIndex(var_9_0)

	if var_9_0 == 5 then
		manager.audio:SetObtainGoldSelectorLabel()
	elseif var_9_0 == 4 then
		manager.audio:SetObtainPurpleSelectorLabel()
	else
		manager.audio:SetObtainBlueSelectorLabel()
	end

	self.SimplePlayer_:SetVoiceInfo(string.format("vo_sys_%d", arg_9_1), string.format("v_s_%d_%s", arg_9_1, "get"), string.format("vo_sys_%d.awb", arg_9_1))
end

function ObtainHeroView:SetInfo(arg_10_1)
	if arg_10_1.draw_rebate and arg_10_1.draw_rebate ~= 0 then
		SetActive(self.rebateGo_, true)

		self.rebateLab_.text = "x" .. arg_10_1.draw_rebate
	else
		SetActive(self.rebateGo_, false)
	end

	local var_10_0 = self:GetHeroID()

	if not HeroCfg[var_10_0] then
		return
	end

	self:RefreshContent(var_10_0, HeroCfg[var_10_0])

	if self.convert then
		SetActive(self.convertGo_, true)

		self.convertIcon_.sprite = ItemTools.getItemSprite(arg_10_1.id)
		self.convertLab_.text = "x" .. arg_10_1.num
	else
		SetActive(self.convertGo_, false)
	end
end

function ObtainHeroView:GetTimeLineEndTime()
	return 5.5
end

function ObtainHeroView:Skip2End()
	local var_12_0 = self:GetPlayable()

	if var_12_0 then
		var_12_0.time = 5.5
	end
end

function ObtainHeroView:Dispose()
	if self.commonItem_ then
		self.commonItem_:Dispose()

		self.commonItem_ = nil
	end

	ObtainHeroView.super.Dispose(self)
end

function ObtainHeroView:Hide()
	ObtainHeroView.super.Hide(self)

	self.portrait_.sprite = nil
end

return ObtainHeroView
