local var_0_0 = class("ObtainHeroView", require("game.views.obtain.ObtainBaseView"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	var_0_0.super.Init(arg_2_0)
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.portrait_.immediate = true
	arg_3_0.starController_ = ControllerUtil.GetController(arg_3_0.starControllerTrs_, "star")
	arg_3_0.AdaptImg_ = arg_3_0:FindCom("AdaptImage", nil, arg_3_0.portrait_.transform)
	arg_3_0.SimplePlayer_ = arg_3_0:FindCom("VoiceOfObtainHeroSimplePlayer", "CriwareAudio")
end

function var_0_0.PlayGetHeroVoice(arg_4_0)
	local var_4_0 = arg_4_0:GetHeroID()

	manager.audio:PlayVoice(string.format("vo_sys_%d", var_4_0), string.format("v_s_%d_%s", var_4_0, "get_cg"), string.format("vo_sys_%d.awb", var_4_0))
end

function var_0_0.GetPlayable(arg_5_0)
	return arg_5_0.playableDirector_
end

function var_0_0.GetHeroID(arg_6_0)
	return arg_6_0.convert and arg_6_0.item.convert_from.id or arg_6_0.item.id
end

function var_0_0.OnClick(arg_7_0)
	local var_7_0 = arg_7_0:GetPlayable()

	if not var_7_0 then
		return true
	end

	if var_7_0.time == 0 or var_7_0.time >= arg_7_0:GetTimeLineEndTime() then
		return true
	else
		var_7_0.time = arg_7_0:GetTimeLineEndTime()

		return false
	end
end

function var_0_0.Show(arg_8_0, arg_8_1)
	arg_8_0.item = arg_8_1
	arg_8_0.convert = ItemWillConvert(arg_8_1)

	if arg_8_0.gameObject_ then
		SetActive(arg_8_0.gameObject_, true)
	end

	if arg_8_0.playableDirector_ then
		arg_8_0.playableDirector_:Evaluate()
		arg_8_0.playableDirector_:Play()
	end

	arg_8_0:SetInfo(arg_8_1)
end

function var_0_0.RefreshContent(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.portrait_.spriteSync = "TextureConfig/Character/Portrait/" .. arg_9_1

	arg_9_0.AdaptImg_:AdaptImg()

	arg_9_0.name_.text = HeroTools.GetHeroFullName(arg_9_1)

	local var_9_0 = RaceEffectCfg[arg_9_2.race]

	arg_9_0.camp_.sprite = getSprite("Atlas/CampItemAtlas", var_9_0.icon)

	local var_9_1 = ItemCfg[arg_9_1]
	local var_9_2 = math.min(var_9_1.display_rare, 5)

	arg_9_0.starController_:SetSelectedIndex(var_9_2)

	if var_9_2 == 5 then
		manager.audio:SetObtainGoldSelectorLabel()
	elseif var_9_2 == 4 then
		manager.audio:SetObtainPurpleSelectorLabel()
	else
		manager.audio:SetObtainBlueSelectorLabel()
	end

	arg_9_0.SimplePlayer_:SetVoiceInfo(string.format("vo_sys_%d", arg_9_1), string.format("v_s_%d_%s", arg_9_1, "get"), string.format("vo_sys_%d.awb", arg_9_1))
end

function var_0_0.SetInfo(arg_10_0, arg_10_1)
	if arg_10_1.draw_rebate and arg_10_1.draw_rebate ~= 0 then
		SetActive(arg_10_0.rebateGo_, true)

		arg_10_0.rebateLab_.text = "x" .. arg_10_1.draw_rebate
	else
		SetActive(arg_10_0.rebateGo_, false)
	end

	local var_10_0 = arg_10_0:GetHeroID()
	local var_10_1 = HeroCfg[var_10_0]

	if not var_10_1 then
		return
	end

	arg_10_0:RefreshContent(var_10_0, var_10_1)

	if arg_10_0.convert then
		SetActive(arg_10_0.convertGo_, true)

		arg_10_0.convertIcon_.sprite = ItemTools.getItemSprite(arg_10_1.id)
		arg_10_0.convertLab_.text = "x" .. arg_10_1.num
	else
		SetActive(arg_10_0.convertGo_, false)
	end
end

function var_0_0.GetTimeLineEndTime(arg_11_0)
	return 5.5
end

function var_0_0.Skip2End(arg_12_0)
	local var_12_0 = arg_12_0:GetPlayable()

	if var_12_0 then
		var_12_0.time = 5.5
	end
end

function var_0_0.Dispose(arg_13_0)
	if arg_13_0.commonItem_ then
		arg_13_0.commonItem_:Dispose()

		arg_13_0.commonItem_ = nil
	end

	var_0_0.super.Dispose(arg_13_0)
end

function var_0_0.Hide(arg_14_0)
	var_0_0.super.Hide(arg_14_0)

	arg_14_0.portrait_.sprite = nil
end

return var_0_0
