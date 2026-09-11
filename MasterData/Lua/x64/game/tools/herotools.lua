HeroSorter = import("game.tools.HeroSorter")

local var_0_0 = {}
local var_0_1 = HeroSorter.New()

function var_0_0.GetNeedPreLoadHeroId()
	local var_1_0 = {}

	if HeroData:GetHeroList() == nil then
		return var_1_0
	end

	local var_1_1 = var_0_0.Sort(HeroData:GetHeroList(), true)
	local var_1_2 = HideInfoData.GetHeroHideList()

	for iter_1_0 = 1, HeroConst.PRELOAD_HERO_NUM do
		if var_1_1[iter_1_0] and var_1_2[var_1_1[iter_1_0]] ~= true then
			var_1_0[var_1_1[iter_1_0]] = true
		end
	end

	var_1_0[PlayerData:GetPlayerInfo().poster_girl] = true

	return var_1_0
end

function var_0_0.Sort(arg_2_0, arg_2_1)
	arg_2_1 = arg_2_1 or false

	local var_2_0 = {}

	for iter_2_0, iter_2_1 in pairs(arg_2_0) do
		if type(iter_2_1) == "table" then
			if arg_2_1 then
				table.insert(var_2_0, iter_2_0)
			elseif iter_2_1.hero_unlock == 1 or iter_2_1.unlock == 1 then
				table.insert(var_2_0, iter_2_0)
			end
		end
	end

	return (var_0_1:SortWithId(var_2_0))
end

function var_0_0.SortHero(arg_3_0)
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_0) do
		table.insert(var_3_0, iter_3_1)
	end

	return (var_0_1:SetUnlockFirst(true):SortWithId(var_3_0))
end

function var_0_0.Count(arg_4_0)
	local var_4_0 = 0
	local var_4_1 = 0

	for iter_4_0, iter_4_1 in pairs(arg_4_0) do
		if type(iter_4_1) == "table" then
			if iter_4_1.hero_unlock == 1 or iter_4_1.unlock == 1 then
				var_4_0 = var_4_0 + 1
			end

			var_4_1 = var_4_1 + 1
		end
	end

	return var_4_0, var_4_1
end

function var_0_0.GetStarCnt(arg_5_0)
	return math.floor(arg_5_0 / 100)
end

function var_0_0.GetStarCfgId(arg_6_0, arg_6_1)
	return arg_6_0 * 100 + arg_6_1
end

function var_0_0.GetNextStarAndPhase(arg_7_0, arg_7_1)
	if arg_7_0 == HeroConst.MAX_STAR then
		return arg_7_0, arg_7_1
	end

	arg_7_1 = arg_7_1 + 1

	if arg_7_1 > HeroConst.PER_STAR_PHASE then
		return arg_7_0 + 1, 0
	end

	return arg_7_0, arg_7_1
end

function var_0_0.GetCanExchangeHero()
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in pairs(HeroData:GetHeroList()) do
		local var_8_1 = 0

		if iter_8_1.unlock == 1 then
			for iter_8_2 = table.keyof(HeroStarCfg.all, (var_0_0.GetStarCfgId(HeroStarCfg[iter_8_1.star].star, HeroStarCfg[iter_8_1.star].phase))), #HeroStarCfg.all do
				var_8_1 = var_8_1 + HeroStarCfg[HeroStarCfg.all[iter_8_2]].star_up
			end

			if var_8_1 < iter_8_1.piece then
				table.insert(var_8_0, {
					id = ItemCfg[iter_8_1.id].fragment,
					number = iter_8_1.piece - var_8_1
				})
			end
		end
	end

	return var_8_0
end

function var_0_0.GetHeroIsUnlock(arg_9_0)
	local var_9_0 = HeroData:GetHeroList()[arg_9_0]

	return var_9_0 and var_9_0.unlock ~= 0 or false
end

function var_0_0.GetHeroIsHideUntilObtained(arg_10_0)
	return HeroCfg[arg_10_0] and HeroCfg[arg_10_0].display_type == 1 or false
end

function var_0_0.EnumerateFilteredAllHeroList(arg_11_0)
	local var_11_0 = HeroCfg.get_id_list_by_private[0]

	return function(arg_12_0, arg_12_1)
		local var_12_0
		local var_12_1

		while arg_12_1 <= arg_12_0 and (not var_12_1 or not arg_11_0(var_12_1)) do
			arg_12_1 = arg_12_1 + 1
			var_12_0 = var_11_0[arg_12_1]
			var_12_1 = HeroCfg[var_11_0[arg_12_1]]
		end

		if arg_12_1 <= arg_12_0 then
			return arg_12_1, var_12_0, var_12_1
		end
	end, #HeroCfg.get_id_list_by_private[0], 0
end

function var_0_0.GetFilteredAllHeroList(arg_13_0)
	local var_13_0 = {}

	for iter_13_0, iter_13_1, iter_13_2 in var_0_0.EnumerateFilteredAllHeroList(arg_13_0) do
		table.insert(var_13_0, iter_13_1)
	end

	return var_13_0
end

function var_0_0.GetFilteredHeroNum(arg_14_0)
	local var_14_0 = 0

	for iter_14_0 in var_0_0.EnumerateFilteredAllHeroList(arg_14_0) do
		var_14_0 = var_14_0 + 1
	end

	return var_14_0
end

function var_0_0.GetSortedIDs(arg_15_0)
	return var_0_1:SortWithId((var_0_0.GetFilteredAllHeroList(arg_15_0)))
end

var_0_0.FilterHeroFunc = {}

function var_0_0.FilterHeroFunc.All(arg_16_0)
	return true
end

function var_0_0.FilterHeroFunc:AllNotHide()
	return not var_0_0.GetIsHide(self.id)
end

function var_0_0.FilterHeroFunc:AllHideUntilObtained()
	return not var_0_0.GetIsHide(self.id) and var_0_0.GetHeroIsUnlock(self.id) or not (self and self.display_type == 1 or false)
end

function var_0_0.FilterHeroFunc:AllHideUntilObtainedWithoutObtainCheck()
	return not (self and self.display_type == 1 or false)
end

function var_0_0.FilterHeroFunc:ObtainedNotHide()
	return not var_0_0.GetIsHide(self.id) and var_0_0.GetHeroIsUnlock(self.id)
end

function var_0_0.GetHeroRecoveryNum(arg_21_0)
	return GameSetting.recovery_fragment.value[HeroCfg[arg_21_0].rare]
end

function var_0_0.FindMatchSkinVoiceID(arg_22_0, arg_22_1)
	return nullable(HeroVoiceCfg.get_id_list_by_file_use_skin_id[arg_22_1], arg_22_0, 1) or nullable(HeroVoiceCfg.get_id_list_by_file_use_skin_id[arg_22_1], 0, 1)
end

function var_0_0.FindMatchSkinVoiceCfg(arg_23_0, arg_23_1)
	return nullable(HeroVoiceCfg, (var_0_0.FindMatchSkinVoiceID(arg_23_0, arg_23_1)))
end

function var_0_0.RecordHeroTalkPlayback(arg_24_0, arg_24_1)
	manager.audio:RecordHeroTalkPlayback(arg_24_0, arg_24_1)
end

local var_0_2 = {
	BATTLE = 2,
	SYS = 1
}
local var_0_3 = {
	[var_0_2.SYS] = {
		awb = "vo_sys_%d.awb",
		name = "v_s_%d_%s",
		sheet = "vo_sys_%d"
	},
	[var_0_2.BATTLE] = {
		awb = "vo_bat_%d.awb",
		name = "v_b_%d_%s",
		sheet = "vo_bat_%d"
	}
}

function var_0_0.PlaySkinTalk(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	arg_25_2 = arg_25_2 or var_0_2.SYS

	local var_25_0 = var_0_3[arg_25_2]

	if HeroTools.FindMatchSkinVoiceCfg(arg_25_0, arg_25_1) then
		HeroTools.PlayTalkBySkinID(arg_25_0, arg_25_1, nil, arg_25_3)
	else
		if arg_25_3 ~= nil then
			var_0_0.RecordHeroTalkPlayback(arg_25_0, LuaForUtil.PlayVoiceWithCriLipsync(arg_25_3, string.format(var_25_0.sheet, arg_25_0), string.format(var_25_0.name, arg_25_0, arg_25_1), (string.format(var_25_0.awb, arg_25_0))))
		end

		manager.notify:Invoke(HERO_SOUND_PLAY, arg_25_0, arg_25_1, 1)
	end
end

local function var_0_4(arg_26_0, arg_26_1, arg_26_2, arg_26_3, arg_26_4)
	arg_26_3 = arg_26_3 or var_0_2.SYS

	local var_26_0 = HeroTools.StopTalk(arg_26_0, arg_26_4)

	manager.audio:PlayUIAudioByVoice(arg_26_2)

	local var_26_1 = var_0_0.FindMatchSkinVoiceCfg(arg_26_0, arg_26_2)
	local var_26_2

	if var_26_1.use_skin_id ~= 0 then
		var_26_2 = var_26_1.use_skin_id
	end

	local var_26_4
	local var_26_3

	do
		var_26_2 = arg_26_1
		var_26_3 = string.format(var_0_3[arg_26_3].sheet, var_26_2)
		var_26_4 = string.format(var_0_3[arg_26_3].name, var_26_2, arg_26_2)
	end

	local var_26_5 = string.format(var_0_3[arg_26_3].awb, var_26_2)

	local function var_26_6()
		var_0_0.RecordHeroTalkPlayback(arg_26_0, arg_26_3 == 1 and (arg_26_4 ~= nil and LuaForUtil.PlayVoiceWithCriLipsync(arg_26_4, var_26_3, var_26_4, var_26_5) or manager.audio:PlayVoice(var_26_3, var_26_4, var_26_5)) or manager.audio:PlayVoice(var_26_3, var_26_4, var_26_5))
	end

	if var_26_0 > 0 then
		manager.delayed:Add(var_26_6, var_26_0, true)
	else
		var_26_6()
	end

	manager.notify:Invoke(HERO_SOUND_PLAY, arg_26_1, arg_26_2, arg_26_3)

	return var_26_3, var_26_4, var_26_5
end

function var_0_0.PlayTalk(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	return var_0_4(nullable(HeroData:GetHeroData(arg_28_0), "using_skin"), arg_28_0, arg_28_1, arg_28_2, arg_28_3)
end

function var_0_0.PlayTalkBySkinID(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	return var_0_4(arg_29_0, SkinCfg[arg_29_0].hero, arg_29_1, arg_29_2, arg_29_3)
end

function var_0_0.PlayTalkForceUseOriginalSkinID(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	return var_0_4(arg_30_0, arg_30_0, arg_30_1, arg_30_2, arg_30_3)
end

function var_0_0.PlayVoice(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	arg_31_2 = arg_31_2 or var_0_2.SYS

	local var_31_2
	local var_31_1

	if not arg_31_3 then
		HeroTools.StopTalk()

		var_31_1 = string.format(var_0_3[arg_31_2].sheet, arg_31_0)
		var_31_2 = string.format(var_0_3[arg_31_2].name, arg_31_0, arg_31_1)
	end

	local var_31_3 = string.format(var_0_3[arg_31_2].awb, arg_31_0)

	manager.notify:Invoke(HERO_SOUND_PLAY, arg_31_0, arg_31_1, arg_31_2)

	return manager.audio:PlayVoice(var_31_1, var_31_2, var_31_3), var_31_1, var_31_2, var_31_3
end

function var_0_0.GetTalkLength(arg_32_0, arg_32_1, arg_32_2)
	arg_32_2 = arg_32_2 or 1

	if arg_32_2 == 1 then
		return manager.audio:GetVoiceLength(string.format("vo_sys_%d", arg_32_0), string.format("v_s_%d_%s", arg_32_0, arg_32_1), string.format("vo_sys_%d.awb", arg_32_0))
	else
		return manager.audio:GetVoiceLength(string.format("vo_bat_%d", arg_32_0), string.format("v_b_%d_%s", arg_32_0, arg_32_1), string.format("vo_bat_%d.awb", arg_32_0))
	end
end

function var_0_0.PlaySectionHeroTeamVoice(arg_33_0)
	local var_33_0, var_33_1, var_33_2 = var_0_0.GetSectionHeroTeamVoiceFileName(arg_33_0)

	return manager.audio:PlayVoice(var_33_0, var_33_1, var_33_2)
end

function var_0_0.GetSectionHeroTeamTalkLength(arg_34_0)
	local var_34_0, var_34_1, var_34_2 = var_0_0.GetSectionHeroTeamVoiceFileName(arg_34_0)

	return manager.audio:GetVoiceLength(var_34_0, var_34_1, var_34_2)
end

function var_0_0:GetSectionHeroTeamVoiceFileName()
	local var_35_0 = {}

	for iter_35_0 = 2, #self do
		var_35_0[#var_35_0 + 1] = self[iter_35_0]
	end

	table.sort(var_35_0, function(arg_36_0, arg_36_1)
		return arg_36_0 < arg_36_1
	end)

	local var_35_1 = ""

	for iter_35_1, iter_35_2 in ipairs(var_35_0) do
		var_35_1 = var_35_1 .. "_" .. iter_35_2
	end

	return string.format("vo_sys_%d", self[1]), string.format("v_s_%d_tag%s", self[1], var_35_1), (string.format("vo_sys_%d.awb", self[1]))
end

local var_0_5 = 1
local var_0_6 = {}

var_0_6[1054] = 1
var_0_6[6148] = 1
var_0_6[105401] = 1
var_0_6[614801] = 1
var_0_6[104402] = 1
var_0_6[121102] = 1
var_0_6[117001] = 1

local function var_0_7(arg_37_0)
	local var_37_0 = nullable(var_0_6, arg_37_0)

	if var_37_0 then
		if var_37_0 == var_0_5 then
			return string.format(var_0_3[var_0_2.SYS].sheet, arg_37_0), string.format(var_0_3[var_0_2.SYS].name, arg_37_0, "stop"), string.format(var_0_3[var_0_2.SYS].awb, arg_37_0)
		else
			return var_37_0.sheet, var_37_0.name, var_37_0.awb
		end
	end

	return nil
end

function var_0_0.StopTalk(arg_38_0, arg_38_1)
	if arg_38_0 then
		local var_38_0 = manager.audio:RemoveRecorededHeroTalkPlayback(arg_38_0)

		if var_38_0 then
			var_38_0:Stop()
			print("StopTalk", "by playback", 0)

			return 0
		end

		local var_38_1, var_38_2, var_38_3 = var_0_7(arg_38_0)

		if var_38_1 then
			manager.audio:PlayVoice(var_38_1, var_38_2, var_38_3)

			if arg_38_1 ~= nil and not isNil(arg_38_1) then
				LuaForUtil.StopCriLipsync(arg_38_1)
			end

			print("StopTalk", "by asset", 2)

			return 0.05
		end
	end

	manager.audio:Stop("voice")
	print("StopTalk", "stop all", 0)

	return 0
end

function var_0_0.PlayTalkWithLips(arg_39_0, arg_39_1, arg_39_2, arg_39_3, arg_39_4)
	local var_39_0 = var_0_0.StopTalk(arg_39_0, arg_39_1)

	local function var_39_1()
		var_0_0.RecordHeroTalkPlayback(arg_39_0, (LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1, arg_39_2, arg_39_3, arg_39_4)))
	end

	if var_39_0 > 0 then
		manager.delayed:Add(var_39_1, var_39_0, true)
	else
		var_39_1()
	end
end

function var_0_0:GetConstructHero()
	self.using_skin = self.skin > 0 and self.skin or self.id

	return self
end

function var_0_0.InitTransitionByCfg(arg_42_0, arg_42_1)
	local var_42_0 = {}

	arg_42_0 = type(arg_42_0) == "table" and arg_42_0 or {}
	arg_42_1 = type(arg_42_1) == "table" and arg_42_1 or {}

	for iter_42_0, iter_42_1 in pairs(arg_42_0) do
		local var_42_1 = {}
		local var_42_2 = 0

		for iter_42_2, iter_42_3 in pairs(iter_42_1) do
			local var_42_3

			if arg_42_1[iter_42_0] then
				var_42_3 = arg_42_1[iter_42_0][iter_42_2] or 0
			end

			var_42_2 = var_42_2 + var_42_3

			table.insert(var_42_1, {
				skill_id = iter_42_3,
				skill_level = var_42_3
			})
		end

		var_42_0[iter_42_0] = {
			slot_id = iter_42_0,
			talent_points = var_42_2,
			skill_list = var_42_1
		}
	end

	return var_42_0
end

function var_0_0.AttributeAdd(arg_43_0, arg_43_1, arg_43_2)
	arg_43_1 = arg_43_1 or 0
	arg_43_2 = arg_43_2 or 0

	if arg_43_0 == HeroConst.SUB_MUL_ATTRIBUTE_ID then
		return HeroConst.ATTRIBUTE_PRECISION - (HeroConst.ATTRIBUTE_PRECISION - arg_43_1) * (HeroConst.ATTRIBUTE_PRECISION - arg_43_2) / HeroConst.ATTRIBUTE_PRECISION
	elseif arg_43_0 == HeroConst.SUB_MUL_INJURY_ID or arg_43_0 == HeroConst.SUB_MUL_SELF_INJURY_ID then
		return (HeroConst.ATTRIBUTE_PRECISION + arg_43_1) * (HeroConst.ATTRIBUTE_PRECISION + arg_43_2) / HeroConst.ATTRIBUTE_PRECISION
	else
		return arg_43_1 + arg_43_2
	end
end

function var_0_0:GetHeroAttribute()
	local var_44_0 = {}
	local var_44_1 = var_0_0.GetStageDicWithStarTemplateAndStarSkillType(HeroCfg[self.id].star_up_skill_template, HeroConst.HERO_STAR_SKILL_TYPE.ATTRIBUTE_UP)

	for iter_44_0, iter_44_1 in ipairs((var_0_0.GetStageListWithStarTemplateAndStarSkillType(HeroCfg[self.id].star_up_skill_template, HeroConst.HERO_STAR_SKILL_TYPE.ATTRIBUTE_UP))) do
		if iter_44_1 <= self.star then
			for iter_44_2, iter_44_3 in pairs(HeroStarSkillCfg[var_44_1[iter_44_1]].params) do
				var_44_0[iter_44_3[1]] = (var_44_0[iter_44_3[1]] or 0) + iter_44_3[2]
			end
		else
			break
		end
	end

	var_44_0[HeroConst.HERO_ATTRIBUTE.CRITICAL] = (var_44_0[HeroConst.HERO_ATTRIBUTE.CRITICAL] or 0) + HeroCfg[self.id].base_crit2[(self.break_level or 0) + 1]

	for iter_44_4, iter_44_5 in pairs(PublicAttrCfg.all) do
		local var_44_3 = 0

		if HeroConst.HERO_ATTRIBUTE_MAP[iter_44_5] then
			if HeroConst.HERO_ATTRIBUTE_MAP[iter_44_5].base then
				var_44_3 = var_44_3 + HeroCfg[self.id][HeroConst.HERO_ATTRIBUTE_MAP[iter_44_5].base][HeroStarCfg[self.star].star]
			end

			if HeroConst.HERO_ATTRIBUTE_MAP[iter_44_5].grow_fixed then
				var_44_3 = var_44_3 + (self.level - 1) * HeroCfg[self.id][HeroConst.HERO_ATTRIBUTE_MAP[iter_44_5].grow_fixed][HeroStarCfg[self.star].star]
			end
		end

		if var_44_0[iter_44_5] == nil then
			var_44_0[iter_44_5] = 0
		end

		var_44_0[iter_44_5] = var_44_0[iter_44_5] + var_44_3
	end

	return var_44_0
end

function var_0_0:CaculateHeroAttribute(arg_45_1)
	local var_45_0 = {}
	local var_45_1 = self.star or self.hero_star
	local var_45_2 = self.hero_level

	if not self.hero_level then
		var_45_2 = self.level

		if not self.level then
			var_45_2 = var_0_0.CheckExp(1, self.exp)
			var_45_2 = var_45_2 or 1
		end
	end

	local var_45_3 = self.hero_id or self.id
	local var_45_4 = HeroCfg[var_45_3]

	for iter_45_0, iter_45_1 in pairs(arg_45_1) do
		var_45_0[iter_45_0] = (var_45_0[iter_45_0] or 0) + iter_45_1
	end

	local var_45_6 = var_0_0.GetStageDicWithStarTemplateAndStarSkillType(var_45_4.star_up_skill_template, HeroConst.HERO_STAR_SKILL_TYPE.ATTRIBUTE_UP)

	for iter_45_2, iter_45_3 in ipairs((var_0_0.GetStageListWithStarTemplateAndStarSkillType(var_45_4.star_up_skill_template, HeroConst.HERO_STAR_SKILL_TYPE.ATTRIBUTE_UP))) do
		if iter_45_3 <= var_45_1 then
			for iter_45_4, iter_45_5 in pairs(HeroStarSkillCfg[var_45_6[iter_45_3]].params) do
				var_45_0[iter_45_5[1]] = (var_45_0[iter_45_5[1]] or 0) + iter_45_5[2]
			end
		else
			break
		end
	end

	var_45_0[HeroConst.HERO_ATTRIBUTE.CRITICAL] = (var_45_0[HeroConst.HERO_ATTRIBUTE.CRITICAL] or 0) + var_45_4.base_crit2[(self.break_level or 0) + 1]

	local var_45_8 = {}
	local var_45_9 = self:GetWeaponInfo()
	local var_45_10 = self:GetServantInfo()

	if var_45_9 then
		var_45_8[1] = WeaponTools.WeaponAtk(var_45_9.level, var_45_9.breakthrough)
		var_45_8[HeroCfg[var_45_3].weapon_break_attribute[var_45_9.breakthrough + 1][1]] = HeroCfg[var_45_3].weapon_break_attribute[var_45_9.breakthrough + 1][2]

		if var_45_10.id ~= 0 then
			var_45_8[1] = var_45_8[1] + var_45_8[1] * WeaponServantCfg[var_45_10.id].attrib_addition / 100
			var_45_8[WeaponServantCfg[var_45_10.id].attribute[1]] = var_45_8[WeaponServantCfg[var_45_10.id].attribute[1]] + WeaponServantCfg[var_45_10.id].attribute[2]
		end

		for iter_45_6, iter_45_7 in pairs(var_45_8) do
			var_45_0[iter_45_6] = var_45_0[iter_45_6] or iter_45_7
			var_45_0[iter_45_6] = var_45_0[iter_45_6] + iter_45_7
		end
	end

	local var_45_11 = HeroStarCfg[var_45_1].star

	for iter_45_8, iter_45_9 in pairs(PublicAttrCfg.all) do
		local var_45_12 = 0

		if HeroConst.HERO_ATTRIBUTE_MAP[iter_45_9] then
			if HeroConst.HERO_ATTRIBUTE_MAP[iter_45_9].base then
				var_45_12 = var_45_12 + var_45_4[HeroConst.HERO_ATTRIBUTE_MAP[iter_45_9].base][var_45_11]
			end

			if HeroConst.HERO_ATTRIBUTE_MAP[iter_45_9].grow_fixed then
				var_45_12 = var_45_12 + (var_45_2 - 1) * var_45_4[HeroConst.HERO_ATTRIBUTE_MAP[iter_45_9].grow_fixed][var_45_11]
			end
		end

		if var_45_0[iter_45_9] == nil then
			var_45_0[iter_45_9] = 0
		end

		var_45_0[iter_45_9] = var_45_0[iter_45_9] + var_45_12
	end

	return var_45_0
end

function var_0_0:CalFinalAttribute()
	for iter_46_0, iter_46_1 in pairs(HeroConst.HERO_ATTRIBUTE_MAP) do
		if iter_46_1.ratio and self[iter_46_0] then
			self[iter_46_0] = self[iter_46_0] * (1 + (self[iter_46_1.ratio] / GameSetting.hp_ratio_percent.value[1] or 1))
		end
	end

	for iter_46_2, iter_46_3 in ipairs(self) do
		self[iter_46_2] = PublicAttrCfg[iter_46_2].percent and PublicAttrCfg[iter_46_2].percent == 1 and self[iter_46_2] or math.floor(self[iter_46_2])
	end
end

function var_0_0.Format(arg_47_0, arg_47_1)
	local var_47_0 = {}

	for iter_47_0, iter_47_1 in ipairs(arg_47_0) do
		var_47_0[iter_47_0] = {}

		for iter_47_2, iter_47_3 in ipairs(arg_47_1) do
			var_47_0[iter_47_0][iter_47_3] = iter_47_1[iter_47_3]
		end
	end

	return var_47_0
end

function var_0_0.CheckBlankTable(arg_48_0)
	local var_48_0 = true

	for iter_48_0, iter_48_1 in pairs(arg_48_0 or {}) do
		var_48_0 = false

		break
	end

	return var_48_0
end

function var_0_0.GetEquipMap(arg_49_0)
	local var_49_0 = {}

	for iter_49_0, iter_49_1 in pairs(arg_49_0) do
		if type(iter_49_1) == "table" then
			for iter_49_2, iter_49_3 in pairs(iter_49_1.equip) do
				var_49_0[iter_49_3.equip_id] = iter_49_0
			end
		end
	end

	return var_49_0
end

function var_0_0.GetHeroEquipS(arg_50_0)
	return deepClone(HeroData:GetHeroData(arg_50_0).equip)
end

function var_0_0.CheckExp(arg_51_0, arg_51_1)
	if GameLevelSetting[arg_51_0] == nil or GameLevelSetting[arg_51_0 + 1] == nil then
		return arg_51_0
	end

	if GameLevelSetting[arg_51_0].hero_level_exp1 <= arg_51_1 then
		return var_0_0.CheckExp(arg_51_0 + 1, arg_51_1 - GameLevelSetting[arg_51_0].hero_level_exp1)
	else
		return arg_51_0
	end
end

function var_0_0.GetUnlockSkill(arg_52_0)
	local var_52_0 = {}
	local var_52_1 = HeroData:GetHeroList()[arg_52_0].skill

	table.insert(var_52_0, {
		lv = 1,
		id = arg_52_0,
		type = HeroConst.SKILL_TYPE.ATTACK
	})

	for iter_52_0 = 1, #var_52_1 do
		local var_52_2 = {
			id = var_52_1[iter_52_0].skill_id
		}

		var_52_2.lv = var_52_1[iter_52_0].lv or 0
		var_52_2.type = HeroConst.SKILL_TYPE.SKILL

		table.insert(var_52_0, var_52_2)
	end

	return var_52_0
end

function var_0_0.GetExSkillId(arg_53_0)
	return arg_53_0 * 1000 + 209
end

function var_0_0.GetTotalSkillLv(arg_54_0, arg_54_1)
	return var_0_0.GetSkillLv(arg_54_0, arg_54_1) + var_0_0.GetHeroSkillAddLevel(HeroData:GetHeroData(arg_54_0), arg_54_1)
end

function var_0_0.GetSkillLv(arg_55_0, arg_55_1)
	for iter_55_0, iter_55_1 in ipairs(HeroData:GetHeroData(arg_55_0).skill) do
		if iter_55_1.skill_id == arg_55_1 then
			return iter_55_1.skill_level
		end
	end

	return 0
end

function var_0_0.GetSkillAttrLv(arg_56_0, arg_56_1)
	for iter_56_0, iter_56_1 in ipairs(HeroData:GetHeroData(arg_56_0).skillAttrList or {}) do
		if iter_56_1.index == arg_56_1 then
			return iter_56_1.level
		end
	end

	return 0
end

function var_0_0.CountHeroTotalSkillAttrLv(arg_57_0)
	local var_57_0 = 0

	for iter_57_0, iter_57_1 in ipairs(HeroData:GetHeroData(arg_57_0).skillAttrList or {}) do
		var_57_0 = var_57_0 + iter_57_1.level
	end

	return var_57_0
end

function var_0_0.GetIsCanSkillUpNew(arg_58_0, arg_58_1)
	for iter_58_0, iter_58_1 in ipairs(HeroData:GetHeroData(arg_58_0).skill) do
		if SkillTools.GetIsCanUpNew(iter_58_1.skill_id, iter_58_1.skill_level, arg_58_1) then
			return true
		end
	end

	return false
end

function var_0_0.GetHeroSkillInfo(arg_59_0, arg_59_1)
	local var_59_0 = {}
	local var_59_1 = HeroData:GetHeroData(arg_59_0)

	for iter_59_0, iter_59_1 in ipairs(var_59_1.skill) do
		var_59_0[iter_59_1.skill_id] = iter_59_1.skill_level
	end

	local var_59_2 = {}

	for iter_59_2, iter_59_3 in ipairs(HeroCfg[arg_59_0].skills) do
		local var_59_3 = var_0_0.GetHeroSkillAddLevel(var_59_1, iter_59_3)

		table.insert(var_59_2, {
			id = iter_59_3,
			heroId = arg_59_0,
			lv = var_59_0[iter_59_3],
			isCanUp = SkillTools.GetIsCanUp(iter_59_3, var_59_0[iter_59_3]),
			addSkillLv = (SkillTools.GetIsDodgeSkill(iter_59_3) or nil) and 0
		})
	end

	if arg_59_1 == true then
		for iter_59_4, iter_59_5 in ipairs(var_59_2) do
			iter_59_5.lv = 1
			iter_59_5.isCanUp = false
			iter_59_5.addSkillLv = 0
		end
	end

	return var_59_2
end

function var_0_0:GetHeroSkillAddLevel(arg_60_1)
	local var_60_1 = HeroCfg[self.id or self.hero_id]
	local var_60_2 = table.indexof(HeroCfg[self.id or self.hero_id].skills, arg_60_1)

	if var_60_2 then
		local var_60_3 = {}
		local var_60_4 = var_0_0.GetStageDicWithStarTemplateAndStarSkillType(var_60_1.star_up_skill_template, HeroConst.HERO_STAR_SKILL_TYPE.SKILL_UP)

		for iter_60_0, iter_60_1 in ipairs((var_0_0.GetStageListWithStarTemplateAndStarSkillType(var_60_1.star_up_skill_template, HeroConst.HERO_STAR_SKILL_TYPE.SKILL_UP))) do
			if iter_60_1 <= self.star then
				for iter_60_2, iter_60_3 in pairs(HeroStarSkillCfg[var_60_4[iter_60_1]].params) do
					var_60_3[iter_60_3[1]] = (var_60_3[iter_60_3[1]] or 0) + iter_60_3[2]
				end
			else
				break
			end
		end

		return var_60_3[var_60_2] or 0
	end

	return 0
end

function var_0_0:CountTransitionTotalSkill(arg_61_1)
	local var_61_0 = HeroTools.GetHeroEquipTransitionAddLevel(self)
	local var_61_1 = {}
	local var_61_2 = {}

	for iter_61_0, iter_61_1 in ipairs(arg_61_1 or {}) do
		if iter_61_1.prefab_id ~= 0 then
			var_61_2[EquipCfg[iter_61_1.prefab_id].pos] = iter_61_1
		end
	end

	for iter_61_2, iter_61_3 in ipairs(self.transition) do
		if var_61_2[iter_61_3.slot_id] and GameSetting.exclusive_open_need.value[1] <= var_61_2[iter_61_3.slot_id]:GetLevel() then
			for iter_61_4, iter_61_5 in ipairs(iter_61_3.skill_list) do
				var_61_1[iter_61_5.skill_id] = var_61_1[iter_61_5.skill_id] or 0
				var_61_1[iter_61_5.skill_id] = var_61_1[iter_61_5.skill_id] + iter_61_5.skill_level
			end
		end
	end

	local var_61_3 = 0

	for iter_61_6, iter_61_7 in pairs(var_61_1) do
		var_61_3 = var_61_3 + iter_61_7 + var_61_0
	end

	return var_61_3
end

function var_0_0:CalTransitionSkillAttribute(arg_62_1)
	local var_62_0 = {}
	local var_62_1 = {}
	local var_62_2 = {}
	local var_62_3 = HeroTools.GetHeroEquipTransitionAddLevel(self)
	local var_62_4 = {}

	for iter_62_0, iter_62_1 in ipairs(arg_62_1) do
		if iter_62_1.prefab_id ~= 0 then
			var_62_4[EquipCfg[iter_62_1.prefab_id].pos] = iter_62_1
		end
	end

	local var_62_5 = {}
	local var_62_6 = {}
	local var_62_7 = {}

	for iter_62_2, iter_62_3 in pairs(self.transition) do
		if var_62_4[iter_62_2] and EquipTools.CountEquipLevel(var_62_4[iter_62_2]) >= GameSetting.exclusive_open_need.value[1] then
			for iter_62_4, iter_62_5 in ipairs(iter_62_3.skill_list) do
				if EquipSkillCfg[iter_62_5.skill_id].equip_effect_id == 0 then
					local var_62_8 = false

					for iter_62_6, iter_62_7 in ipairs(GameSetting.exclusive_skill_level_up_type.value) do
						if iter_62_5.skill_id == iter_62_7[1] then
							var_62_8 = iter_62_7[2]

							break
						end
					end

					if var_62_8 then
						var_62_7[iter_62_5.skill_id] = (var_62_7[iter_62_5.skill_id] or 0) + iter_62_5.skill_level
					else
						var_62_5[iter_62_5.skill_id] = (var_62_5[iter_62_5.skill_id] or 0) + iter_62_5.skill_level
					end
				else
					var_62_6[iter_62_5.skill_id] = (var_62_6[iter_62_5.skill_id] or 0) + iter_62_5.skill_level
				end
			end
		end
	end

	for iter_62_8, iter_62_9 in pairs(var_62_5) do
		var_62_0[EquipSkillCfg[iter_62_8].attribute] = (var_62_0[EquipSkillCfg[iter_62_8].attribute] or 0) + EquipSkillCfg[iter_62_8].upgrade * (iter_62_9 + var_62_3)
	end

	for iter_62_10, iter_62_11 in pairs(var_62_6) do
		var_62_1[iter_62_10] = (var_62_1[iter_62_10] or 0) + (iter_62_11 + var_62_3)
	end

	for iter_62_12, iter_62_13 in pairs(var_62_7) do
		for iter_62_14, iter_62_15 in ipairs(GameSetting.exclusive_skill_level_up_type.value) do
			if iter_62_12 == iter_62_15[1] then
				var_62_2[HeroCfg[self.id].skills[iter_62_15[2]]] = EquipSkillCfg[iter_62_12].upgrade * (iter_62_13 + var_62_3)

				break
			end
		end
	end

	return var_62_0, var_62_1, var_62_2
end

function var_0_0:GetHeroEquipSkillAddLevel()
	local var_63_0 = 0
	local var_63_1 = HeroCfg[self.id or self.hero_id].star_up_skill_template

	for iter_63_0, iter_63_1 in ipairs((var_0_0.GetStageListWithStarTemplateAndStarSkillType(HeroCfg[self.id or self.hero_id].star_up_skill_template, HeroConst.HERO_STAR_SKILL_TYPE.EQUIP_UP))) do
		if iter_63_1 <= self.star then
			var_63_0 = var_63_0 + 1
		end
	end

	for iter_63_2, iter_63_3 in ipairs((var_0_0.GetStageListWithStarTemplateAndStarSkillType(var_63_1, HeroConst.HERO_STAR_SKILL_TYPE.EQUIP_SKILL_UP))) do
		if iter_63_3 <= self.star then
			var_63_0 = var_63_0 + 1
		end
	end

	return var_63_0
end

function var_0_0:GetHeroEquipTransitionAddLevel()
	local var_64_0 = 0
	local var_64_1 = HeroCfg[self.id or self.hero_id].star_up_skill_template

	for iter_64_0, iter_64_1 in ipairs((var_0_0.GetStageListWithStarTemplateAndStarSkillType(HeroCfg[self.id or self.hero_id].star_up_skill_template, HeroConst.HERO_STAR_SKILL_TYPE.EQUIP_UP))) do
		if iter_64_1 <= self.star then
			var_64_0 = var_64_0 + 1
		end
	end

	for iter_64_2, iter_64_3 in ipairs((var_0_0.GetStageListWithStarTemplateAndStarSkillType(var_64_1, HeroConst.HERO_STAR_SKILL_TYPE.EQUIP_TRANSITION_UP))) do
		if iter_64_3 <= self.star then
			var_64_0 = var_64_0 + 1
		end
	end

	return var_64_0
end

function var_0_0:GetHeroWeaponAddLevel()
	if self.star >= var_0_0.GetStageListWithStarTemplateAndStarSkillType(HeroCfg[self.id].star_up_skill_template, HeroConst.HERO_STAR_SKILL_TYPE.WEAPON_UP)[1] then
		return 2
	end

	return 0
end

function var_0_0:GetIsSuitNumCut()
	if not self then
		return false
	end

	local var_66_0 = self.star or self.hero_star

	if var_66_0 and HeroStarCfg[var_66_0] and var_66_0 >= var_0_0.GetStageListWithStarTemplateAndStarSkillType(HeroCfg[self.id or self.hero_id].star_up_skill_template, HeroConst.HERO_STAR_SKILL_TYPE.EQUIP_SUIT)[1] then
		return true
	end

	return false
end

function var_0_0.CountHeroTotalSkilllv(arg_67_0)
	local var_67_0 = HeroData:GetHeroList()[arg_67_0]
	local var_67_1 = 0

	for iter_67_0, iter_67_1 in ipairs(var_67_0.skill) do
		var_67_1 = var_67_1 + iter_67_1.skill_level + var_0_0.GetHeroSkillAddLevel(var_67_0, iter_67_1.skill_id)
	end

	return var_67_1
end

function var_0_0.GetEquipSuitEffect(arg_68_0)
	local var_68_0 = {}

	for iter_68_0, iter_68_1 in ipairs(arg_68_0) do
		if iter_68_1.equip_id ~= 0 then
			local var_68_1 = EquipCfg[EquipData:GetEquipList()[iter_68_1.equip_id].prefab_id].type

			var_68_0[var_68_1] = (var_68_0[var_68_1] or 0) + 1
		end
	end

	local var_68_2 = {}
	local var_68_3 = 0

	for iter_68_2, iter_68_3 in pairs(var_68_0) do
		for iter_68_4, iter_68_5 in ipairs(EquipSuitCfg.get_id_list_by_suit[iter_68_2]) do
			if iter_68_3 >= EquipSuitCfg[iter_68_5].need then
				if var_68_2[EquipSuitCfg[iter_68_5].suit] == nil then
					var_68_2[EquipSuitCfg[iter_68_5].suit] = {}
					var_68_3 = var_68_3 + 1
				end

				table.insert(var_68_2[EquipSuitCfg[iter_68_5].suit], EquipSuitCfg[iter_68_5])
			end
		end
	end

	return var_68_2, var_68_3
end

function var_0_0:GetIsCanSkillUp()
	if self.unlock == 0 then
		return false
	end

	local var_69_0 = {}

	for iter_69_0, iter_69_1 in ipairs(self.skill) do
		var_69_0[iter_69_1.skill_id] = iter_69_1.skill_level
	end

	for iter_69_2, iter_69_3 in ipairs(HeroCfg[self.id].skills) do
		if SkillTools.GetIsCanUp(iter_69_3, var_69_0[iter_69_3]) then
			return true
		end
	end

	return false
end

function var_0_0:GetIsCanUpStar()
	if self.unlock == 0 then
		if GameSetting.unlock_hero_need.value[HeroCfg[self.id].rare] <= self.piece then
			return true
		end
	else
		local var_70_0 = self.star

		if self.star >= HeroConst.MAX_STAR_UP_ID then
			return false
		end

		if HeroStarCfg[var_70_0].star_up <= self.piece and HeroStarCfg[var_70_0].gold_cost <= ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_GOLD) then
			return true
		end
	end

	return false
end

function var_0_0.SortByChat(arg_71_0, arg_71_1, arg_71_2)
	local var_71_0 = {}
	local var_71_1 = {}

	for iter_71_0, iter_71_1 in pairs(arg_71_0) do
		if type(iter_71_1) == "table" and iter_71_1.unlock == 1 then
			var_71_1[iter_71_0] = iter_71_1.chat_unread

			table.insert(var_71_0, iter_71_0)
		end
	end

	table.sort(var_71_0)
	table.sort(var_71_0, function(arg_72_0, arg_72_1)
		return var_71_1[arg_72_0] > var_71_1[arg_72_1]
	end)

	if var_0_0.lastList then
		if var_0_0.lastList[arg_71_2 - arg_71_1] and var_0_0.lastList[arg_71_2 - arg_71_1] ~= var_71_0[arg_71_2 - arg_71_1] then
			local var_71_2 = table.indexof(var_71_0, var_0_0.lastList[arg_71_2 - arg_71_1])

			if var_71_2 then
				table.remove(var_71_0, var_71_2)
				table.insert(var_71_0, arg_71_2 - arg_71_1, var_0_0.lastList[arg_71_2 - arg_71_1])
			end
		end
	end

	var_0_0.lastList = var_71_0

	return var_71_0
end

function var_0_0.SortByChat2(arg_73_0)
	if var_0_0.chatList then
		return var_0_0.chatList
	end

	local var_73_0 = {}
	local var_73_1 = {}

	for iter_73_0, iter_73_1 in pairs(arg_73_0) do
		if type(iter_73_1) == "table" and iter_73_1.unlock == 1 then
			var_73_1[iter_73_0] = iter_73_1.chat_unread

			table.insert(var_73_0, iter_73_0)
		end
	end

	table.sort(var_73_0)
	table.sort(var_73_0, function(arg_74_0, arg_74_1)
		return var_73_1[arg_74_0] > var_73_1[arg_74_1]
	end)

	var_0_0.chatList = var_73_0

	return var_73_0
end

function var_0_0.HeroUsingSkinInfo(arg_75_0)
	local var_75_0 = HeroData:GetHeroData(arg_75_0)
	local var_75_1

	if var_75_0 then
		var_75_1 = var_75_0.using_skin or 0

		if var_75_1 == 0 then
			var_75_1 = arg_75_0
		end
	end

	return SkinCfg[var_75_1]
end

function var_0_0.SetHeroModelWeaponActivity(arg_76_0, arg_76_1)
	LuaForUtil.ShowWeapon(arg_76_0, arg_76_1)
end

function var_0_0.HeroUnlockSkinS(arg_77_0)
	local var_77_0 = {}

	for iter_77_0, iter_77_1 in ipairs(HeroData:GetHeroData(arg_77_0).unlocked_skin) do
		table.insert(var_77_0, iter_77_1.skin_id)
	end

	table.insert(var_77_0, arg_77_0)

	return var_77_0
end

function var_0_0.CanChangeSkin(arg_78_0)
	if var_0_0.GetSkinIsUnlock(arg_78_0) then
		return false
	end

	local var_78_0 = var_0_0.GetSkinChangeItem(arg_78_0)

	if not var_78_0 then
		return false
	end

	if ItemTools.getItemNum(var_78_0) > 0 then
		return true
	end
end

function var_0_0.GetSkinIsHide(arg_79_0)
	if HideInfoData:GetSkinHideList()[arg_79_0] then
		return true
	end

	if var_0_0.GetIsHide(SkinCfg[arg_79_0].hero) then
		return true
	end

	return false
end

function var_0_0.GetSkinIsUnlock(arg_80_0)
	for iter_80_0, iter_80_1 in ipairs((HeroTools.HeroUnlockSkinS(SkinCfg[arg_80_0].hero))) do
		if iter_80_1 == arg_80_0 then
			return true
		end
	end

	return false
end

function var_0_0.GetSkinIsCanUnLock(arg_81_0)
	if SkinCfg[arg_81_0].unlock_id_list[1] then
		return true
	end

	return false
end

function var_0_0.GetHasOwnedSkin(arg_82_0)
	if arg_82_0 == SkinCfg[arg_82_0].hero then
		return true
	end

	for iter_82_0, iter_82_1 in ipairs(HeroData:GetHeroData(SkinCfg[arg_82_0].hero).unlocked_skin) do
		if iter_82_1.skin_id == arg_82_0 and iter_82_1.time == 0 then
			return true
		end
	end

	return false
end

function var_0_0.GetIsLimitTimeSkin(arg_83_0)
	for iter_83_0, iter_83_1 in ipairs(HeroData:GetHeroData(SkinCfg[arg_83_0].hero).unlocked_skin) do
		if iter_83_1.skin_id == arg_83_0 and iter_83_1.time ~= 0 then
			return true
		end
	end

	return false
end

function var_0_0.GetAllOwnedHeroSkinList()
	local var_84_0 = {}
	local var_84_1 = {}
	local var_84_2 = {}

	for iter_84_0, iter_84_1 in pairs((HeroData:GetHeroList())) do
		if iter_84_1.unlock > 0 then
			var_84_2[iter_84_0] = iter_84_1
		end
	end

	for iter_84_2, iter_84_3 in pairs(var_84_2) do
		local var_84_3 = {}

		for iter_84_4, iter_84_5 in ipairs(SkinCfg.get_id_list_by_hero[iter_84_2] or {}) do
			if var_0_0.GetSkinIsUnlock(iter_84_5) then
				table.insert(var_84_3, iter_84_5)
				table.insert(var_84_1, iter_84_5)
			end
		end

		var_84_0[iter_84_2] = var_84_3
	end

	return var_84_1, var_84_0
end

function var_0_0.GetSkinChangeItem(arg_85_0)
	return SkinCfg[arg_85_0].change_item
end

function var_0_0.GetHeadSprite(arg_86_0)
	return getSpriteViaConfig("HeroLittleIcon", arg_86_0)
end

function var_0_0.GetSmallHeadSprite(arg_87_0)
	return getSpriteViaConfig("HeroItemshead", arg_87_0)
end

function var_0_0.GetHeroAttackRangeIcon(arg_88_0)
	local var_88_0

	for iter_88_0, iter_88_1 in ipairs(GameDisplayCfg.hero_range_type_tag.value) do
		if iter_88_1[1] == CharactorParamCfg[arg_88_0].RangeType then
			var_88_0 = iter_88_1[2]

			break
		end
	end

	return getSprite("Atlas/Hero_arrtAtlas", var_88_0)
end

function var_0_0.GetHeroRaceIcon(arg_89_0)
	return var_0_0.GetRaceIcon(HeroCfg[arg_89_0].race)
end

function var_0_0.GetRaceIcon(arg_90_0)
	local var_90_0

	for iter_90_0, iter_90_1 in ipairs(GameDisplayCfg.hero_race_type_tag.value) do
		if iter_90_1[1] == arg_90_0 then
			var_90_0 = iter_90_1[2]
		end
	end

	return getSprite("Atlas/CampItemAtlas", var_90_0)
end

function var_0_0.GetHeroNormalAtkAttributeIdList()
	local var_91_0 = {}

	for iter_91_0, iter_91_1 in pairs(HeroConst.HERO_ATTACK_TYPE) do
		if var_0_0.IsNormalAtkAttributeId(iter_91_1) then
			table.insert(var_91_0, iter_91_1)
		end
	end

	return var_91_0
end

function var_0_0.IsNormalAtkAttributeId(arg_92_0)
	return arg_92_0 ~= HeroConst.HERO_ATTACK_TYPE.MIX and arg_92_0 ~= HeroConst.HERO_ATTACK_TYPE.RANDOM and arg_92_0 ~= HeroConst.HERO_ATTACK_TYPE.ALL
end

function var_0_0.GetHeroBattleAtkAttributeId(arg_93_0)
	if not HeroCfg[arg_93_0] then
		Debug.LogError("不存在该英雄：" .. arg_93_0)

		return nil
	end

	if type(HeroCfg[arg_93_0].ATK_attribute) == "table" then
		if HeroCfg[arg_93_0].ATK_attribute[1] == HeroConst.HERO_ATTACK_TYPE.RANDOM then
			local var_93_0 = HeroTools.GetHeroNormalAtkAttributeIdList()

			return var_93_0[math.random(1, #var_93_0)]
		else
			return HeroCfg[arg_93_0].ATK_attribute[1]
		end
	else
		Debug.LogError("不存在该英雄的攻击属性：" .. arg_93_0)

		return nil
	end
end

function var_0_0.IsRandomAtkAttribute(arg_94_0)
	if type(HeroCfg[arg_94_0].ATK_attribute) == "table" then
		for iter_94_0, iter_94_1 in ipairs(HeroCfg[arg_94_0].ATK_attribute) do
			if iter_94_1 == HeroConst.HERO_ATTACK_TYPE.RANDOM then
				return true
			end
		end
	end

	return false
end

function var_0_0.GetHeroSkillAttributeIcon(arg_95_0, arg_95_1)
	if type(HeroCfg[arg_95_0].ATK_attribute) ~= "table" or not HeroCfg[arg_95_0].ATK_attribute[1] then
		print(string.format("%s角色表未配置ATK_attribute", arg_95_0))

		return nil
	end

	return var_0_0.GetSkillAttributeIcon(HeroCfg[arg_95_0].ATK_attribute[1], arg_95_1)
end

function var_0_0.GetSkillAttributeIcon(arg_96_0, arg_96_1)
	if not arg_96_0 then
		return getSprite("Atlas/Hero_arrtAtlas", "icon_none")
	end

	if not SkillElementCfg[arg_96_0] then
		Debug.LogError("SkillElementCfg不存在该属性: " .. tostring(arg_96_0))

		return nil
	end

	return var_0_0.LoadSkillAttributeIcon(arg_96_1 and SkillElementCfg[arg_96_0].icon_white or SkillElementCfg[arg_96_0].icon)
end

function var_0_0.LoadSkillAttributeIcon(arg_97_0)
	return getSprite("Atlas/Hero_arrtAtlas", arg_97_0)
end

function var_0_0.GetSkillAttributeName(arg_98_0)
	if SkillElementCfg[arg_98_0] then
		return GetI18NText(SkillElementCfg[arg_98_0].name)
	end

	Debug.LogError("SkillElementCfg不存在该属性: " .. tostring(arg_98_0))
end

function var_0_0.GetHeroSkillMechanismIcon(arg_99_0)
	local var_99_0

	for iter_99_0, iter_99_1 in ipairs(GameDisplayCfg.hero_mechanism_type_tag.value) do
		if iter_99_1[1] == HeroCfg[arg_99_0].mechanism_type[1] then
			var_99_0 = iter_99_1[2]

			break
		end
	end

	return getSprite("Atlas/Hero_arrtAtlas", var_99_0)
end

function var_0_0.GetHeroRareSprite(arg_100_0)
	return var_0_0.GetRareSprite(HeroCfg[arg_100_0].rare)
end

function var_0_0.GetRareSprite(arg_101_0)
	return getSprite("Atlas/SystemHeroGradeAtlas", string.format("star_%s", arg_101_0))
end

function var_0_0:GetHeroCurrentMaxLevel()
	return HeroTools.GetHeroBreakConfig(HeroCfg[self.id].race, self.break_level or 0).max_level
end

function var_0_0:GetHeroMaxLevel()
	return HeroBreakCfg[HeroBreakCfg.get_id_list_by_race[HeroCfg[self.id].race][#HeroBreakCfg.get_id_list_by_race[HeroCfg[self.id].race]]].max_level
end

function var_0_0.GetHeroBreakConfig(arg_104_0, arg_104_1)
	for iter_104_0, iter_104_1 in ipairs(HeroBreakCfg.all) do
		if HeroBreakCfg[iter_104_1].race == arg_104_0 and HeroBreakCfg[iter_104_1].break_times == arg_104_1 then
			return HeroBreakCfg[iter_104_1]
		end
	end

	error(string.format("在hero_break.csv中找不到race=%d,breakLevel=%d的项", arg_104_0, arg_104_1))

	return nil
end

function var_0_0.GetHeroServantInfo(arg_105_0)
	local var_105_0 = HeroData:GetHeroList()[arg_105_0].servant_uid

	if var_105_0 == 0 then
		return nil
	end

	return WeaponServantData.GetWeaponServantList()[var_105_0]
end

function var_0_0.GetHeroSpecServant(arg_106_0)
	return HeroCfg[arg_106_0].spec_servant
end

function var_0_0.GetHeroProficiency(arg_107_0)
	return (math.min(HeroData:GetHeroData(arg_107_0).clear_times, GameSetting.mastery_level_max.value[1]))
end

function var_0_0.CanBreakHero(arg_108_0)
	local var_108_0 = HeroData:GetHeroData(arg_108_0)

	if var_108_0.unlock and var_108_0.level < HeroConst.HERO_LV_MAX and var_108_0.level >= HeroTools.GetHeroCurrentMaxLevel(var_108_0) then
		-- block empty
	else
		return false
	end

	local var_108_1 = HeroTools.GetHeroBreakConfig(HeroCfg[arg_108_0].race, var_108_0.break_level or 0)

	if PlayerData:GetPlayerInfo().userLevel < var_108_1.user_level then
		return false
	end

	for iter_108_0 = 1, #var_108_1.cost do
		if ItemTools.getItemNum(var_108_1.cost[iter_108_0][1]) < var_108_1.cost[iter_108_0][2] then
			return false
		end
	end

	if ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_GOLD) < var_108_1.cost_gold then
		return false
	end

	return true
end

function var_0_0.GetHeroOntologyID(arg_109_0)
	for iter_109_0, iter_109_1 in ipairs(HeroRecordCfg.all) do
		if arg_109_0 == iter_109_1 then
			return iter_109_1, true
		end

		for iter_109_2, iter_109_3 in ipairs(HeroRecordCfg[iter_109_1].hero_id) do
			if arg_109_0 == iter_109_3 then
				return iter_109_1, false
			end
		end
	end
end

function var_0_0.GetHeroTeachVideo(arg_110_0)
	if HeroData:GetHeroData(arg_110_0).unlock == 0 then
		return nil
	end

	if HeroCfg[arg_110_0].study_stage[1] then
		if TeachStageExInfoCfg[HeroCfg[arg_110_0].study_stage[1]] and TeachStageExInfoCfg[HeroCfg[arg_110_0].study_stage[1]].video_url then
			return TeachStageExInfoCfg[HeroCfg[arg_110_0].study_stage[1]].video_url
		end
	end
end

function var_0_0.IsSkinUnlock(arg_111_0)
	for iter_111_0, iter_111_1 in ipairs((HeroTools.HeroUnlockSkinS(SkinCfg[arg_111_0].hero))) do
		if iter_111_1 == arg_111_0 then
			return true
		end
	end

	return false
end

function var_0_0.GetShopIdBySkinId(arg_112_0)
	if SkinIDToGoodIDCfg[arg_112_0] == nil then
		return 0
	end

	for iter_112_0, iter_112_1 in ipairs(SkinIDToGoodIDCfg[arg_112_0].goods_id) do
		local var_112_0 = getShopCfg(iter_112_1)

		if var_112_0 and var_112_0.shop_refresh == 3 then
			return iter_112_1
		end
	end

	return 0
end

function var_0_0.IsSkinOnlySellDLC(arg_113_0)
	return var_0_0.GetShopIdBySkinId(arg_113_0) < 0
end

function var_0_0.IsSkinOutOfDate(arg_114_0)
	local var_114_0 = var_0_0.GetShopIdBySkinId(arg_114_0)

	if var_114_0 and var_114_0 > 0 then
		return ShopData.IsGoodOutOfDate(var_114_0, getShopCfg(var_114_0).shop_id)
	else
		return true
	end
end

function var_0_0.CanBeDraw(arg_115_0, arg_115_1)
	for iter_115_0, iter_115_1 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.DRAW] or {}) do
		if ActivityData:GetActivityIsOpen(iter_115_1) then
			if ActivityDrawPoolCfg[iter_115_1] then
				for iter_115_2, iter_115_3 in ipairs(ActivityDrawPoolCfg[iter_115_1].config_list) do
					if arg_115_1 == iter_115_3 then
						return true
					end
				end
			end
		end
	end

	return false
end

function var_0_0.GetHeroUnlockOrPieceEnoughToUnlock(arg_116_0)
	local var_116_0 = HeroData:GetHeroData(arg_116_0)

	if var_116_0 == nil then
		return false
	end

	if var_116_0.unlock == 0 then
		return GameSetting.unlock_hero_need.value[HeroCfg[arg_116_0].rare] <= var_116_0.piece
	else
		return true
	end
end

function var_0_0.GetIsHide(arg_117_0, arg_117_1)
	if HideInfoData:GetHeroHideList()[arg_117_0] then
		return true
	end

	if not arg_117_1 and var_0_0.GetHeroIsHideUntilObtained(arg_117_0) and not var_0_0.GetHeroUnlockOrPieceEnoughToUnlock(arg_117_0) then
		return true
	end

	return false
end

function var_0_0.GetIsSkinHide(arg_118_0)
	return HideInfoData:GetSkinHideList()[arg_118_0] or false
end

function var_0_0.GetSkinIsCanUnlockAndGet(arg_119_0)
	if SkinCfg[arg_119_0].unlock_id_list[1] then
		for iter_119_0, iter_119_1 in pairs(SkinCfg[arg_119_0].unlock_id_list) do
			local var_119_0, var_119_1, var_119_2 = IsConditionAchieved(iter_119_1, {
				heroId = SkinCfg[arg_119_0].hero
			})

			if not var_119_0 then
				return false
			end
		end

		return true
	else
		return false
	end
end

local var_0_8 = {}
local var_0_9 = 0

local function var_0_11(arg_121_0)
	local var_121_0 = false

	for iter_121_0 = var_0_9 + 1, #HeroRecordCfg.all do
		for iter_121_1, iter_121_2 in pairs(HeroRecordCfg[HeroRecordCfg.all[iter_121_0]].hero_id) do
			var_0_8[iter_121_2] = HeroRecordCfg.all[iter_121_0]

			if arg_121_0 == iter_121_2 then
				var_121_0 = true
			end
		end

		var_0_9 = iter_121_0

		if var_121_0 then
			return HeroRecordCfg.all[iter_121_0]
		end
	end

	return nil
end

local function var_0_12(arg_122_0)
	return (var_0_8[arg_122_0] == nil or nil) and var_0_11(arg_122_0)
end

function var_0_0.IsSamePerson(arg_123_0, arg_123_1)
	local var_123_0 = var_0_12(arg_123_0)
	local var_123_1 = var_0_12(arg_123_1)

	return var_123_0 ~= nil and var_123_1 ~= nil and var_123_0 == var_123_1
end

function var_0_0.GetInteractionVoiceFileName(arg_124_0)
	if arg_124_0 == nil then
		return nil
	end

	local var_124_0 = string.find(arg_124_0, "_")

	return var_124_0 and string.sub(arg_124_0, var_124_0 + 1) or nil
end

function var_0_0.GetIntHeroIDAndInteractionVoiceFileName(arg_125_0)
	if arg_125_0 ~= nil then
		local var_125_0 = string.find(arg_125_0, "_")

		if var_125_0 then
			return tonumber(string.sub(arg_125_0, 1, var_125_0 - 1)), (string.sub(arg_125_0, var_125_0 + 1))
		end
	end

	return nil, nil
end

local function var_0_13(arg_126_0, arg_126_1)
	if arg_126_1 == nil or next(arg_126_1) == nil then
		return arg_126_0[math.random(#arg_126_0)]
	end

	local var_126_0 = 0

	for iter_126_0, iter_126_1 in ipairs(arg_126_1) do
		var_126_0 = var_126_0 + iter_126_1
	end

	if var_126_0 > 0 then
		local var_126_1 = math.random() * var_126_0
		local var_126_2 = 1

		while var_126_1 > arg_126_1[var_126_2] do
			var_126_1 = var_126_1 - arg_126_1[var_126_2]
			var_126_2 = var_126_2 + 1
		end

		return arg_126_0[var_126_2], var_126_2
	end
end

local function var_0_14(arg_127_0, arg_127_1)
	local var_127_0 = HeroTools.GetOldInteractionCfg(arg_127_0)

	if var_127_0[arg_127_1 .. "_talk"] then
		local var_127_1, var_127_2 = var_0_13(var_127_0[arg_127_1 .. "_talk"], var_127_0[arg_127_1 .. "_weight"])

		if var_127_1 and var_127_2 then
			return var_127_1, var_127_0[arg_127_1 .. "_delay"][var_127_2]
		end
	end

	local var_127_3 = nullable(HeroInteractionConvertedCfg.get_id_list_by_skinId_interaction_type, arg_127_0, arg_127_1, 1)

	if var_127_3 then
		local var_127_4, var_127_5 = var_0_13(HeroInteractionConvertedCfg[var_127_3].interaction_talk, HeroInteractionConvertedCfg[var_127_3].interaction_weight)

		if var_127_4 and var_127_5 then
			return var_127_4, HeroInteractionConvertedCfg[var_127_3].interaction_delay[var_127_5]
		end
	end

	return nil, 0
end

local function var_0_15(arg_128_0, arg_128_1, arg_128_2)
	local var_128_0 = HeroTools.GetOldInteractionCfg(arg_128_0)

	if var_128_0[arg_128_1 .. "_talk"] then
		local var_128_1 = table.indexof(var_128_0[arg_128_1], arg_128_2)

		if var_128_1 then
			return var_128_0[arg_128_1 .. "_talk"][var_128_1], var_128_0[arg_128_1 .. "_delay"][var_128_1]
		end
	end

	local var_128_2 = nullable(HeroInteractionConvertedCfg.get_id_list_by_skinId_interaction_type, arg_128_0, arg_128_1, 1)

	if var_128_2 then
		local var_128_3 = table.indexof(HeroInteractionConvertedCfg[var_128_2].interaction_id, arg_128_2)

		if var_128_3 then
			return HeroInteractionConvertedCfg[var_128_2].interaction_talk[var_128_3], HeroInteractionConvertedCfg[var_128_2].interaction_delay[var_128_3]
		end
	end

	return nil, 0
end

function var_0_0.GetTalkInfoFromInteractionCfg(arg_129_0, arg_129_1, arg_129_2)
	if arg_129_2 then
		return var_0_15(arg_129_0, arg_129_1, arg_129_2)
	else
		return var_0_14(arg_129_0, arg_129_1)
	end
end

function var_0_0.GetHeroIDFromFormID(arg_130_0)
	for iter_130_0, iter_130_1 in pairs(HeroSkinExtraFormCfg.get_id_list_by_original_hero_form_id) do
		for iter_130_2, iter_130_3 in pairs(iter_130_1) do
			if iter_130_2 == arg_130_0 then
				return iter_130_0
			end
		end
	end
end

local var_0_16 = {
	[99108501] = 1085
}

function var_0_0.GetUnlockInteractionCfg(arg_131_0, arg_131_1, arg_131_2)
	local var_131_0 = var_0_0.GetHeroIDFromFormID(arg_131_1) or var_0_16[arg_131_1] or SkinCfg[arg_131_1].hero
	local var_131_1 = var_0_0.GetOldInteractionCfg(arg_131_1)
	local var_131_2 = {}

	for iter_131_0, iter_131_1 in pairs(var_131_1) do
		if string.find(iter_131_0, "_talk") then
			local var_131_3 = string.split(iter_131_0, "_")[1]
			local var_131_4 = {}
			local var_131_5 = {}
			local var_131_6 = {}
			local var_131_7 = {}

			var_131_2[var_131_3] = var_131_4
			var_131_2[var_131_3 .. "_talk"] = var_131_5
			var_131_2[var_131_3 .. "_delay"] = var_131_6
			var_131_2[var_131_3 .. "_weight"] = var_131_7

			for iter_131_2, iter_131_3 in ipairs(var_131_1[iter_131_0]) do
				local var_131_8 = HeroTools.GetInteractionVoiceFileName(iter_131_3)

				if HeroVoiceCfg.get_id_list_by_file[var_131_8] then
					local var_131_9 = var_0_0.FindMatchSkinVoiceCfg(arg_131_1, var_131_8).id

					if HeroVoiceCfg[var_131_9].use_skin_id == 0 and not var_0_0.IsUnlockVoice(var_131_0, var_131_9) then
						-- block empty
					elseif var_131_1[var_131_3] and var_131_1[var_131_3][iter_131_2] then
						local var_131_11 = string.split(var_131_1[var_131_3][iter_131_2], "__")
						local var_131_12 = true

						if var_131_11[2] then
							if #arg_131_2 > 0 then
								local var_131_13 = string.split(var_131_11[2], "_")

								for iter_131_4, iter_131_5 in ipairs(arg_131_2) do
									if not table.indexof(var_131_13, iter_131_5) then
										var_131_12 = false

										break
									end
								end
							else
								var_131_12 = false
							end
						end

						if var_131_12 then
							table.insert(var_131_4, var_131_1[var_131_3][iter_131_2])
							table.insert(var_131_5, var_131_1[var_131_3 .. "_talk"][iter_131_2])

							if var_131_1[var_131_3 .. "_delay"] then
								table.insert(var_131_6, var_131_1[var_131_3 .. "_delay"][iter_131_2])
							end

							if var_131_1[var_131_3 .. "_weight"] then
								table.insert(var_131_7, var_131_1[var_131_3 .. "_weight"][iter_131_2])
							end
						end
					end
				end
			end
		end
	end

	return var_131_2
end

function var_0_0.IsUnlockVoice(arg_132_0, arg_132_1)
	if DormHeroTools:IsVoiceNeedUnlock(arg_132_1, arg_132_0) and DormHeroTools:GetDormLevelByHeroID(arg_132_0) < DormHeroTools:GetVoiceUnlockLevel(arg_132_0, arg_132_1) then
		return false
	end

	return IsConditionAchieved(HeroVoiceCfg[arg_132_1].unlock_condition, {
		heroId = arg_132_0
	})
end

function var_0_0:GetModuleAttribute()
	local var_133_0 = {
		0,
		0,
		0,
		0
	}

	for iter_133_0, iter_133_1 in pairs((HeroTools.GetModuleEffectByHeroAndLevel(self.id, self.weapon_module_level))) do
		if WeaponModuleEffectCfg[iter_133_1].type == 1 then
			for iter_133_2, iter_133_3 in pairs(WeaponModuleEffectCfg[iter_133_1].attributes) do
				var_133_0[iter_133_3[1]] = var_133_0[iter_133_3[1]] + iter_133_3[2]
			end
		end
	end

	return var_133_0
end

function var_0_0:GetSkillAttribute()
	local var_134_0 = {}

	for iter_134_0, iter_134_1 in ipairs(self.skillAttrList) do
		local var_134_1 = SkillTools.GetSkillAttrCfg(self.id, iter_134_1.index, iter_134_1.level)

		if var_134_1 then
			for iter_134_2, iter_134_3 in pairs(var_134_1.attr) do
				var_134_0[iter_134_3[1]] = iter_134_3[2]
			end
		end
	end

	return var_134_0
end

local function var_0_17(arg_135_0, arg_135_1, arg_135_2)
	if arg_135_1 == nil then
		return arg_135_0
	end

	arg_135_2 = arg_135_2 or "\n"

	if arg_135_0 == nil then
		return arg_135_1
	else
		return arg_135_0 .. arg_135_2 .. arg_135_1
	end
end

function var_0_0.GetModuleAllDes(arg_136_0, arg_136_1, arg_136_2)
	local var_136_0
	local var_136_1
	local var_136_2
	local var_136_3
	local var_136_4 = HeroData:GetHeroList()[arg_136_1].servant_uid

	if var_136_4 ~= HeroTools.GetHeroSpecServant(arg_136_1) then
		var_136_4 = 0
	end

	for iter_136_0, iter_136_1 in pairs(arg_136_0) do
		if WeaponModuleEffectCfg[iter_136_1].type == 1 then
			if var_136_0 == nil then
				var_136_0 = {
					iter_136_1
				}
			else
				table.insert(var_136_0, iter_136_1)
			end
		elseif WeaponModuleEffectCfg[iter_136_1].type == 2 then
			var_136_1 = var_0_17(var_136_1, SkillTools.GetSkillModuleDes(iter_136_1))
		elseif WeaponModuleEffectCfg[iter_136_1].type == 3 then
			var_136_2 = var_0_17(var_136_2, AstrolabeTools.GetAstrolabeModuleDes(iter_136_1, var_136_4), "\n\n")
		elseif WeaponModuleEffectCfg[iter_136_1].type == 4 then
			var_136_3 = var_0_17(var_136_3, WeaponTools.GetWeaponModuleDes(iter_136_1, arg_136_2), "\n\n")
		elseif WeaponModuleEffectCfg[iter_136_1].type == 5 then
			var_136_1 = var_0_17(var_136_1, SkillTools.GetServantSkillModuleDes(iter_136_1))
		elseif WeaponModuleEffectCfg[iter_136_1].type == 6 then
			var_136_1 = var_0_17(var_136_1, SkillTools.GetAstrolabeSkillModuleDes(iter_136_1))
		end
	end

	return var_136_0, var_136_1, var_136_2, var_136_3
end

function var_0_0.MergeModuleAttribute(arg_137_0)
	local var_137_0 = {}

	for iter_137_0, iter_137_1 in pairs(arg_137_0) do
		for iter_137_2, iter_137_3 in pairs(WeaponModuleEffectCfg[iter_137_1].attributes) do
			var_137_0[iter_137_3[1]] = var_137_0[iter_137_3[1]] and var_137_0[iter_137_3[1]] + iter_137_3[2] or iter_137_3[2]
		end
	end

	return var_137_0
end

function var_0_0.CheckModulePieceCanEnter()
	for iter_138_0, iter_138_1 in pairs(ItemCfg.get_id_list_by_sub_type[ItemConst.ITEM_SUB_TYPE.MODULE_PIECE]) do
		if ItemTools.getItemNum(iter_138_1) > 0 then
			return true
		end
	end

	return false
end

function var_0_0.GetModuleEffectByHeroAndLevel(arg_139_0, arg_139_1)
	local var_139_0 = {}

	if arg_139_0 and arg_139_1 then
		if WeaponModuleCfg[arg_139_0] then
			for iter_139_0 = 1, arg_139_1 do
				for iter_139_1, iter_139_2 in pairs(WeaponModuleCfg[arg_139_0].skill[iter_139_0]) do
					table.insert(var_139_0, iter_139_2)
				end
			end
		end
	end

	return var_139_0
end

function var_0_0.GetStageDicWithStarTemplateAndStarSkillType(arg_140_0, arg_140_1)
	if HeroStarUpTemplateCfg.template_dic[arg_140_0] and HeroStarUpTemplateCfg.template_dic[arg_140_0][arg_140_1] then
		return HeroStarUpTemplateCfg.template_dic[arg_140_0][arg_140_1].stage_dic
	end

	return {}
end

function var_0_0.GetStageListWithStarTemplateAndStarSkillType(arg_141_0, arg_141_1)
	if HeroStarUpTemplateCfg.template_dic[arg_141_0] and HeroStarUpTemplateCfg.template_dic[arg_141_0][arg_141_1] then
		return HeroStarUpTemplateCfg.template_dic[arg_141_0][arg_141_1].stage_list
	end

	return {}
end

function var_0_0.GetHeroNameLinkChar()
	local var_142_1 = SettingData:GetCurrentLanguage()

	return (var_142_1 == "en" or var_142_1 == "fr" or var_142_1 == "de") and " - " or var_142_1 == "jp" and "·" or "·"
end

local function var_0_18(arg_143_0)
	return OathCollectionContentData:GetOathCustomNickName(arg_143_0)
end

local function var_0_19(arg_144_0)
	return nil
end

function var_0_0.GetHeroSuffixName(arg_145_0)
	return GetI18NText(nullable(HeroCfg, arg_145_0, "suffix") or "")
end

function var_0_0.GetHeroName(arg_146_0, arg_146_1)
	arg_146_1 = arg_146_1 or var_0_18

	return arg_146_1(arg_146_0) or var_0_0.GetHeroSuffixName(arg_146_0)
end

function var_0_0.GetHeroFullName(arg_147_0, arg_147_1)
	return GetI18NText(HeroCfg[arg_147_0].name) .. HeroTools.GetHeroNameLinkChar() .. var_0_0.GetHeroName(arg_147_0, (arg_147_1 or nil) and (var_0_18 or var_0_19))
end

function var_0_0.GetModulePowersByHeroIDAndLevel(arg_148_0, arg_148_1, arg_148_2)
	local var_148_0 = {}

	if WeaponModuleCfg[arg_148_1] then
		for iter_148_0 = 1, arg_148_2 do
			for iter_148_1, iter_148_2 in pairs(WeaponModuleCfg[arg_148_1].skill[iter_148_0]) do
				table.insert(var_148_0, iter_148_2)
			end
		end
	end

	return var_148_0
end

function var_0_0.FindOriginalFormHeroID(arg_149_0)
	for iter_149_0, iter_149_1 in pairs(HeroSkinExtraFormCfg.get_id_list_by_original_hero_form_id) do
		for iter_149_2, iter_149_3 in pairs(iter_149_1) do
			if iter_149_2 == arg_149_0 then
				return iter_149_0
			end
		end
	end
end

function var_0_0.SetHeroNewTagRed(arg_150_0, arg_150_1, arg_150_2, arg_150_3)
	local var_150_0 = getData("heroNew", arg_150_1) or {}

	if var_150_0 then
		local var_150_1 = 0

		for iter_150_0, iter_150_1 in ipairs(var_150_0) do
			if iter_150_1 == arg_150_0 then
				var_150_1 = iter_150_0

				break
			end
		end

		local var_150_2 = false

		if var_150_1 > 0 then
			if not arg_150_3 then
				var_150_2 = true

				table.remove(var_150_0, var_150_1)
				manager.redPoint:setTip(arg_150_2, 0, RedPointStyle.SHOW_NEW_TAG)
			end
		elseif arg_150_3 then
			var_150_2 = true

			table.insert(var_150_0, arg_150_0)
			manager.redPoint:setTip(arg_150_2, 1, RedPointStyle.SHOW_NEW_TAG)
		end

		if var_150_2 then
			saveData("heroNew", arg_150_1, var_150_0)
		end
	end
end

function var_0_0.DispatchAllHeroNewRed(arg_151_0, arg_151_1)
	for iter_151_0, iter_151_1 in ipairs(getData("heroNew", arg_151_0) or {}) do
		manager.redPoint:setTip(arg_151_1 .. iter_151_1, 1, RedPointStyle.SHOW_NEW_TAG)
	end
end

function var_0_0.NeedToHideHero(arg_152_0, arg_152_1)
	return var_0_0.GetIsHide(arg_152_0, arg_152_1 ~= HeroConst.HERO_DATA_TYPE.DEFAULT and arg_152_1 ~= HeroConst.HERO_DATA_TYPE.PREVIEW)
end

function var_0_0.GetHeroShowData(arg_153_0, arg_153_1, arg_153_2)
	local var_153_0 = arg_153_2 or Filter_Root_Define.Hero_Filter_List.filter_id
	local var_153_1 = {}

	if arg_153_1 then
		CommonFilterData:ClearFilter(var_153_0)
	end

	local var_153_2 = CommonFilterData:IsAll(var_153_0) or arg_153_1

	for iter_153_0, iter_153_1 in pairs(arg_153_0) do
		local var_153_3 = HeroConst.HERO_DATA_TYPE.DEFAULT

		if iter_153_1.type then
			var_153_3 = iter_153_1.type
		elseif iter_153_1.heroViewProxy then
			var_153_3 = iter_153_1.heroViewProxy:GetViewDataType()
		end

		local var_153_4 = not var_0_0.NeedToHideHero(iter_153_1.id, var_153_3)

		if var_153_4 and not var_153_2 then
			local var_153_5 = CommonFilterData:SpecificHasFlag(var_153_0, Filter_Group_Define.RACE.groupID, {
				Filter_Tags_Define["Race" .. HeroCfg[iter_153_1.id].race]
			})
			local var_153_6 = CommonFilterData:SpecificHasFlag(var_153_0, Filter_Group_Define.ARRT.groupID, {
				Filter_Tags_Define["ARRT" .. HeroCfg[iter_153_1.id].ATK_attribute[1]]
			})
			local var_153_7 = CommonFilterData:SpecificHasFlag(var_153_0, Filter_Group_Define.MECHAINISMTYPE.groupID, {
				Filter_Tags_Define["MECHAINISM" .. HeroCfg[iter_153_1.id].mechanism_type[1]]
			})

			var_153_4 = var_153_5 and var_153_6 and var_153_7

			if var_153_0 == Filter_Root_Define.Osiris_Hero_Filter_List.filter_id then
				local var_153_8 = {}

				for iter_153_2 = 1, #ActivityGeneralityCharactorCfg[iter_153_1.id].generality do
					table.insert(var_153_8, Filter_Tags_Define["OsirisPlayGameTag" .. ActivityGeneralityCharactorCfg[iter_153_1.id].generality[iter_153_2]])
				end

				var_153_4 = var_153_5 and var_153_6 and var_153_7 and CommonFilterData:SpecificHasFlag(var_153_0, Filter_Group_Define.OSIRIS_PLAY_GAME_TAG.groupID, var_153_8)
			end
		end

		if var_153_4 then
			table.insert(var_153_1, iter_153_1)
		end
	end

	return var_153_1
end

function var_0_0.GetHeroShowIDList(arg_154_0, arg_154_1)
	local var_154_0 = {}

	if arg_154_1 then
		CommonFilterData:ClearFilter(Filter_Root_Define.Hero_Filter_List.filter_id)
	end

	local var_154_1 = CommonFilterData:IsAll(Filter_Root_Define.Hero_Filter_List.filter_id) or arg_154_1

	if var_154_1 then
		return arg_154_0
	end

	for iter_154_0, iter_154_1 in pairs(arg_154_0) do
		local var_154_2 = not var_0_0.GetIsHide(iter_154_1)

		if var_154_2 and not var_154_1 then
			var_154_2 = CommonFilterData:SpecificHasFlag(Filter_Root_Define.Hero_Filter_List.filter_id, Filter_Group_Define.RACE.groupID, {
				Filter_Tags_Define["Race" .. HeroCfg[iter_154_1].race]
			}) and CommonFilterData:SpecificHasFlag(Filter_Root_Define.Hero_Filter_List.filter_id, Filter_Group_Define.ARRT.groupID, {
				Filter_Tags_Define["ARRT" .. HeroCfg[iter_154_1].ATK_attribute[1]]
			}) and CommonFilterData:SpecificHasFlag(Filter_Root_Define.Hero_Filter_List.filter_id, Filter_Group_Define.MECHAINISMTYPE.groupID, {
				Filter_Tags_Define["MECHAINISM" .. HeroCfg[iter_154_1].mechanism_type[1]]
			})
		end

		if var_154_2 then
			table.insert(var_154_0, iter_154_1)
		end
	end

	return var_154_0
end

function var_0_0.IsSpHero(arg_155_0)
	if HeroCfg[arg_155_0] then
		return HeroCfg[arg_155_0].role_type == 1
	end

	return false
end

function var_0_0.FormatFilterHeroDataList(arg_156_0, arg_156_1, arg_156_2, arg_156_3)
	local var_156_0 = HeroViewDataProxy.New(arg_156_0)

	var_156_0:SetTempHeroList(arg_156_3)

	local var_156_1 = {}

	for iter_156_0, iter_156_1 in ipairs(arg_156_1) do
		var_156_1[iter_156_0] = {
			id = iter_156_1,
			trialID = var_156_0:GetHeroData(iter_156_1).tempID,
			type = arg_156_2,
			heroViewProxy = var_156_0
		}
	end

	return var_156_1
end

function var_0_0.IsNPC(arg_157_0)
	if arg_157_0 and HeroCfg[arg_157_0] then
		return HeroCfg[arg_157_0].private ~= 0
	end

	return false
end

function var_0_0.NeedHideInfo(arg_158_0)
	if arg_158_0 and HeroCfg[arg_158_0] then
		return HeroCfg[arg_158_0].hide_info == 1
	end

	return false
end

function var_0_0.GetSectionHeroTeamVoiceIDList(arg_159_0)
	return (var_0_0.TryGetCacheSectionHeroTeamVoiceList(arg_159_0))
end

function var_0_0.GetCacheKeyOfSectionHeroTeamVoice(arg_160_0)
	local var_160_0 = clone(arg_160_0)

	table.sort(var_160_0, function(arg_161_0, arg_161_1)
		return arg_161_0 < arg_161_1
	end)

	local var_160_1 = ""

	for iter_160_0, iter_160_1 in ipairs(var_160_0) do
		if iter_160_1 ~= 0 then
			var_160_1 = var_160_1 .. "_" .. iter_160_1
		end
	end

	return var_160_1
end

function var_0_0.TryGetCacheSectionHeroTeamVoiceList(arg_162_0)
	var_0_0.cacheHeroTeamVoiceDic = var_0_0.cacheHeroTeamVoiceDic or {}

	local var_162_0 = var_0_0.GetCacheKeyOfSectionHeroTeamVoice(arg_162_0)

	if var_0_0.cacheHeroTeamVoiceDic[var_162_0] then
		return var_0_0.cacheHeroTeamVoiceDic[var_162_0]
	end

	local var_162_1 = var_0_0.GetMatchSectionHeroTeamVoiceList(arg_162_0)

	var_0_0.SetCacheSectionHeroTeamVoiceList(var_162_0, var_162_1)

	return var_162_1
end

function var_0_0.SetCacheSectionHeroTeamVoiceList(arg_163_0, arg_163_1)
	var_0_0.cacheHeroTeamVoiceDic = var_0_0.cacheHeroTeamVoiceDic or {}
	var_0_0.cacheHeroTeamVoiceDic[arg_163_0] = arg_163_1
end

function var_0_0.GetMatchSectionHeroTeamVoiceList(arg_164_0)
	local var_164_0 = {}
	local var_164_1 = {}

	for iter_164_0, iter_164_1 in pairs(arg_164_0) do
		if iter_164_1 ~= 0 then
			var_164_1[iter_164_1] = true
		end
	end

	for iter_164_2, iter_164_3 in pairs(var_164_1) do
		if HeroVoiceDescCfg.get_id_list_by_chara_id[iter_164_2] then
			for iter_164_4, iter_164_5 in ipairs(HeroVoiceDescCfg.get_id_list_by_chara_id[iter_164_2]) do
				if type(HeroVoiceDescCfg[iter_164_5].team_hero_id_list) == "table" then
					local var_164_2 = true

					for iter_164_6, iter_164_7 in ipairs(HeroVoiceDescCfg[iter_164_5].team_hero_id_list) do
						if not var_164_1[iter_164_7] then
							var_164_2 = false

							break
						end
					end

					if var_164_2 then
						var_164_0[#var_164_0 + 1] = iter_164_5
					end
				end
			end
		end
	end

	return var_164_0
end

function var_0_0.GetOldInteractionCfg(arg_165_0)
	local var_165_0 = {}

	if HeroInteractionConvertedCfg.get_id_list_by_skinId[arg_165_0] then
		for iter_165_0, iter_165_1 in ipairs(HeroInteractionConvertedCfg.get_id_list_by_skinId[arg_165_0]) do
			if HeroInteractionConvertedCfg[iter_165_1] then
				var_165_0[HeroInteractionConvertedCfg[iter_165_1].interaction_type] = HeroInteractionConvertedCfg[iter_165_1].interaction_id
				var_165_0[HeroInteractionConvertedCfg[iter_165_1].interaction_type .. "_talk"] = HeroInteractionConvertedCfg[iter_165_1].interaction_talk
				var_165_0[HeroInteractionConvertedCfg[iter_165_1].interaction_type .. "_delay"] = HeroInteractionConvertedCfg[iter_165_1].interaction_delay
				var_165_0[HeroInteractionConvertedCfg[iter_165_1].interaction_type .. "_weight"] = HeroInteractionConvertedCfg[iter_165_1].interaction_weight
			end
		end
	end

	return var_165_0
end

function var_0_0.GetChargeTextByType(arg_166_0)
	local var_166_0

	if arg_166_0 == HeroConst.HERO_CHARGE_TYPE.NONE then
		var_166_0 = GetTips("NOTE_ENERGYTYPE_0")
	elseif arg_166_0 == HeroConst.HERO_CHARGE_TYPE.RAGE then
		var_166_0 = GetTips("NOTE_ENERGYTYPE_1")
	elseif arg_166_0 == HeroConst.HERO_CHARGE_TYPE.ENERGY then
		var_166_0 = GetTips("NOTE_ENERGYTYPE_2")
	elseif arg_166_0 == HeroConst.HERO_CHARGE_TYPE.TRACES then
		var_166_0 = GetTips("NOTE_ENERGYTYPE_3")
	elseif arg_166_0 == HeroConst.HERO_CHARGE_TYPE.DIVINE_GRACE then
		var_166_0 = GetTips("NOTE_ENERGYTYPE_4")
	elseif arg_166_0 == HeroConst.HERO_CHARGE_TYPE.XIELV then
		var_166_0 = GetTips("NOTE_ENERGYTYPE_5")
	end

	return var_166_0
end

function var_0_0.IsNeedDisplayAdult(arg_167_0)
	local var_167_0 = HeroRecordCfg.get_id_list_by_hero_id[arg_167_0][1]

	if not HeroRecordCfg.get_id_list_by_hero_id[arg_167_0][1] then
		return false
	end

	return HeroRecordCfg[var_167_0].age_en ~= ""
end

return var_0_0
