local var_0_0 = class("RedPointMgr")

function var_0_0.Ctor(arg_1_0)
	arg_1_0._redPointHelper = require("manager/redPoint/RedPointController")

	arg_1_0._redPointHelper:Init(function(arg_2_0)
		return not arg_1_0:checkAnyRedPointSystemIsLocked(arg_2_0)
	end)
	arg_1_0:Init()
end

function var_0_0.Init(arg_3_0)
	arg_3_0.redPointRelateSystem = {}

	arg_3_0:addGroup(RedPointConst.BULLETIN_UNREAD, {
		RedPointConst.BULLETIN_UNREAD_101,
		RedPointConst.BULLETIN_UNREAD_102,
		RedPointConst.BULLETIN_UNREAD_104
	})
	arg_3_0:addGroup(RedPointConst.TASK, {
		RedPointConst.TASK_DAILY,
		RedPointConst.TASK_PLOT,
		RedPointConst.TASK_WEEK,
		RedPointConst.EXPLORE_MAIN
	})
	arg_3_0:addGroup(RedPointConst.DRAW_HOME, {
		RedPointConst.DRAW,
		RedPointConst.DRAW_BONUS
	})
	arg_3_0:addGroup(RedPointConst.COMBAT, {
		RedPointConst.COMBAT_PLOT,
		RedPointConst.COMBAT_SUB_PLOT,
		RedPointConst.COMBAT_CHALLENGE,
		RedPointConst.COMBAT_EQUIP,
		RedPointConst.COMBAT_EQUIP,
		RedPointConst.RESOURSE_STAGE,
		RedPointConst.RESIDENT_ACT
	})
	arg_3_0:setRelateSystem(RedPointConst.RESIDENT_ACT, ViewConst.SYSTEM_ID.RESIDENT_ACT)

	local var_3_0 = {}
	local var_3_1 = {}

	for iter_3_0 = 1, BattleConst.HARD_CNT do
		var_3_1[iter_3_0] = {}
	end

	for iter_3_1, iter_3_2 in pairs(ChapterClientCfg.get_id_list_by_toggle[BattleConst.TOGGLE.PLOT]) do
		local var_3_2 = {}
		local var_3_3 = 1

		for iter_3_3, iter_3_4 in pairs(ChapterClientCfg[iter_3_2].chapter_list) do
			table.insert(var_3_2, string.format("%s_%s", RedPointConst.COMBAT_PLOT_CHAPTER, iter_3_4))

			local var_3_4 = ChapterCfg[iter_3_4]
			local var_3_5 = {
				string.format("%s_%s", RedPointConst.COMBAT_PLOT_CHAPTER_STAR, iter_3_4)
			}

			if var_3_1[var_3_4.difficulty] then
				var_3_3 = var_3_4.difficulty

				if var_3_4.sub_type == 13 and var_3_4.difficulty == 1 then
					arg_3_0:addGroup(string.format("%s_%s", RedPointConst.COMBAT_PLOT, iter_3_4), {
						RedPointConst.TRAVEL_SKULD_CHAPTER .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL
					})
				elseif var_3_4.clientID == ChapterConst.CHAPTER_CLIENT_19 then
					arg_3_0:addGroup(string.format("%s_%s", RedPointConst.COMBAT_PLOT, iter_3_4), {
						RedPointConst.COMBAT_PLOT_CHAPTER_19_STAR
					})
				elseif var_3_4.clientID == ChapterConst.CHAPTER_CLIENT_23 then
					arg_3_0:addGroup(string.format("%s_%s", RedPointConst.COMBAT_PLOT, iter_3_4), {
						RedPointConst.CHAPTER_MAP_V2_MAIN
					})
				elseif var_3_4.clientID == ChapterConst.CHAPTER_CLIENT_24 then
					arg_3_0:addGroup(string.format("%s_%s", RedPointConst.COMBAT_PLOT, iter_3_4), {
						RedPointConst.CHAPTER_MAP_V2_MAIN
					})
				elseif var_3_4.clientID == ChapterConst.CHAPTER_CLIENT_25 then
					arg_3_0:addGroup(string.format("%s_%s", RedPointConst.COMBAT_PLOT, iter_3_4), {
						RedPointConst.CHAPTER_MAP_V2_MAIN
					})
				end
			end

			local var_3_6

			if var_3_4.unlock_activity_id ~= 0 then
				var_3_6 = var_3_4.unlock_activity_id
			else
				var_3_6 = var_3_4.activity_id
			end

			if var_3_6 ~= 0 then
				table.insert(var_3_5, string.format("%s%s", ActivityTools.GetRedPointKey(var_3_4.activity_id), var_3_6))
			end

			arg_3_0:addGroup(string.format("%s_%s", RedPointConst.COMBAT_PLOT_CHAPTER, iter_3_4), var_3_5)
		end

		arg_3_0:addGroup(string.format("%s_%s", RedPointConst.COMBAT_PLOT, iter_3_2), var_3_2)
		table.insert(var_3_0, string.format("%s_%s", RedPointConst.COMBAT_PLOT, iter_3_2))
		table.insert(var_3_1[var_3_3], string.format("%s_%s", RedPointConst.COMBAT_PLOT, iter_3_2))
	end

	arg_3_0:addGroup(RedPointConst.COMBAT_PLOT, var_3_0)

	for iter_3_5 = 1, BattleConst.HARD_CNT do
		arg_3_0:addGroup(string.format("%s_%s", RedPointConst.COMBAT_PLOT_LEVEL, iter_3_5), var_3_1[iter_3_5])
	end

	local var_3_7 = {}

	for iter_3_6, iter_3_7 in pairs(ChapterClientCfg.get_id_list_by_toggle[BattleConst.TOGGLE.SUB_PLOT] or {}) do
		table.insert(var_3_7, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT, iter_3_7))

		local var_3_8 = {}

		for iter_3_8, iter_3_9 in pairs(ChapterClientCfg[iter_3_7].chapter_list) do
			table.insert(var_3_8, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER, iter_3_9))
		end

		arg_3_0:addGroup(string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER_LIST, iter_3_7), var_3_8)

		local var_3_9 = {
			string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER_LIST, iter_3_7),
			string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_EXTRA_STORY, iter_3_7)
		}

		if iter_3_7 == 6010003 then
			table.insert(var_3_9, string.format("%s_%s", RedPointConst.WAR_CHESS, 71012))
			table.insert(var_3_9, string.format("%s_%s", RedPointConst.WAR_CHESS, 71011))
			table.insert(var_3_9, string.format("%s_%s", RedPointConst.ACTIVITY_SIDE_STORY, ActivityConst.THEME.SUMMER))
		elseif iter_3_7 == 6010012 then
			local var_3_10 = ActivityConst.SUMMER_CHESS_BOARD_MAIN

			table.insert(var_3_9, string.format("%s%s", ActivityTools.GetRedPointKey(var_3_10), var_3_10))
		elseif ChapterConst.NEW_TAG_CLIENT[iter_3_7] then
			table.insert(var_3_9, string.format("%s_%s", RedPointConst.COMBAT_SUB_POLT_NEW_TAG, iter_3_7))
		end

		arg_3_0:addGroup(string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT, iter_3_7), var_3_9)
	end

	arg_3_0:addGroup(RedPointConst.COMBAT_SUB_PLOT, var_3_7)
	arg_3_0:addGroup(RedPointConst.BOSS_CHALLENGE, {
		RedPointConst.BOSS_CHALLENGE_NORMAL,
		RedPointConst.BOSS_CHALLENGE_ADVANCE
	})

	local var_3_11 = {}

	for iter_3_10, iter_3_11 in pairs(BattleBaseTeachStageCfg.all or {}) do
		local var_3_12 = RedPointConst.TEACH_BASE_TEACHING .. "_" .. iter_3_11

		table.insert(var_3_11, var_3_12)
	end

	arg_3_0:addGroup(RedPointConst.TEACH_BASE_TEACHING, var_3_11)
	arg_3_0:addGroup(RedPointConst.COMBAT_CHALLENGE, {
		RedPointConst.CHALLENGE_COMMON,
		RedPointConst.CHALLENGE_DEMO
	})

	local var_3_13 = {}
	local var_3_14 = ChapterClientCfg.get_id_list_by_toggle[401]

	for iter_3_12, iter_3_13 in ipairs(var_3_14) do
		table.insert(var_3_13, RedPointConst.TOWER_NEW_LEVEL + iter_3_13)
	end

	arg_3_0:addGroup(RedPointConst.TOWER, var_3_13)
	arg_3_0:addGroup(RedPointConst.CHALLENGE_COMMON, {
		RedPointConst.MYTHIC_TIMES_AWARD,
		RedPointConst.MYTHIC_FINAL_AWARD,
		RedPointConst.BOSS_CHALLENGE,
		RedPointConst.MATRIX_EXCHANGE_BONUS,
		RedPointConst.POLYHEDRON,
		RedPointConst.ABYSS,
		RedPointConst.TOWER,
		RedPointConst.WARCHESS,
		RedPointConst.TEACH,
		RedPointConst.CORE_VERIFICATION,
		RedPointConst.CHALLENGE_ROGUE_TEAM
	})
	arg_3_0:addGroup(RedPointConst.CHALLENGE_DEMO, {
		RedPointConst.COOPERATION_DEMO
	})
	arg_3_0:addGroup(RedPointConst.TEACH, {
		RedPointConst.TEACH_BASE,
		RedPointConst.TEACH_CHARACTER,
		RedPointConst.TEACH_BASE_TEACHING
	})
	arg_3_0:AddRogueTeamGroup()

	local var_3_15 = ChapterTools.GetRedPoint(ChapterConst.DAILY_EQUIP_EXPERIENCE)

	arg_3_0:addGroup(RedPointConst.COMBAT_EQUIP, {
		RedPointConst.BATTLE_EQUIP,
		RedPointConst.EQUIP_SEIZURE,
		var_3_15,
		RedPointConst.DAILY_EQUIP_ENCHANT
	})
	arg_3_0:addGroup(var_3_15, {
		GetSystemNewRedKeyByChapter(ChapterConst.DAILY_EQUIP_EXPERIENCE)
	})
	arg_3_0:addGroup(RedPointConst.DAILY_EQUIP_ENCHANT, {
		GetSystemNewRedKeyByChapter(ChapterConst.DAILY_EQUIP_ENCHANT)
	})
	arg_3_0:addGroup(RedPointConst.EQUIP_SEIZURE, {
		RedPointConst.EQUIP_SEIZURE_REWARD,
		RedPointConst.EQUIP_SEIZURE_UNREAD
	})

	local var_3_16 = {}

	for iter_3_14, iter_3_15 in pairs(ChapterClientCfg.get_id_list_by_toggle[BattleConst.TOGGLE.RESOURCE] or {}) do
		local var_3_17 = ChapterTools.GetRedPoint(iter_3_15)

		table.insert(var_3_16, var_3_17)
		arg_3_0:addGroup(var_3_17, {
			GetSystemNewRedKeyByChapter(iter_3_15)
		})
	end

	arg_3_0:addGroup(RedPointConst.RESOURSE_STAGE, var_3_16)

	local var_3_18 = ActivityCfg[ActivityConst.SUMMER_CHESS_BOARD_ENTRY].sub_activity_list
	local var_3_19 = {}

	for iter_3_16, iter_3_17 in ipairs(var_3_18) do
		table.insert(var_3_19, string.format("%s%s", ActivityTools.GetRedPointKey(iter_3_17), iter_3_17))
	end

	local var_3_20 = string.format("%s%s", ActivityTools.GetRedPointKey(ActivityConst.SUMMER_CHESS_BOARD_ENTRY), ActivityConst.SUMMER_CHESS_BOARD_ENTRY)

	arg_3_0:addGroup(var_3_20, var_3_19)

	local var_3_21 = {}
	local var_3_22 = {}

	for iter_3_18, iter_3_19 in pairs(WeddingCfg.all) do
		local var_3_23 = RedPointConst.OATH_HERO .. iter_3_19

		arg_3_0:addGroup(var_3_23, {
			RedPointConst.OATH_NEW_HERO .. iter_3_19,
			RedPointConst.OATH_TASK_FINISH .. iter_3_19
		})

		local var_3_24 = RedPointConst.OATH_HERO_CAN_COMPLETE .. iter_3_19

		table.insert(var_3_21, var_3_23)
		table.insert(var_3_21, var_3_24)

		local var_3_25 = RedPointConst.OATH_NEW_CONTENT .. iter_3_19

		arg_3_0:addGroup(var_3_25, {
			OathTools.GetOathContentRedKey(OathConst.OATH_CONTENT_TAG_KEY.story, iter_3_19),
			OathTools.GetOathContentRedKey(OathConst.OATH_CONTENT_TAG_KEY.archieve, iter_3_19),
			OathTools.GetOathContentRedKey(OathConst.OATH_CONTENT_TAG_KEY.plot, iter_3_19),
			OathTools.GetOathContentRedKey(OathConst.OATH_CONTENT_TAG_KEY.voice, iter_3_19)
		})

		local var_3_26 = RedPointConst.OATH_CONTENT .. iter_3_19

		arg_3_0:addGroup(var_3_26, {
			RedPointConst.OATH_TASK_FINISH .. iter_3_19,
			var_3_25
		})

		var_3_22[iter_3_19] = true
	end

	arg_3_0:addGroup(RedPointConst.OATH_MAIN, var_3_21)

	local var_3_27 = {}
	local var_3_28 = {}

	for iter_3_20, iter_3_21 in pairs(HeroCfg.get_id_list_by_private[0]) do
		local var_3_29 = RedPointConst.HERO_ID .. iter_3_21

		table.insert(var_3_28, var_3_29)

		local var_3_30 = RedPointConst.HERO_WEAPON_BREAK_ID .. iter_3_21
		local var_3_31 = RedPointConst.WEAPON_MODULE_UNLOCK .. "_" .. iter_3_21
		local var_3_32 = RedPointConst.HERO_WEAPON .. iter_3_21

		arg_3_0:addGroup(var_3_32, {
			var_3_30
		})

		local var_3_33 = RedPointConst.HERO_UNLOCK_ID .. iter_3_21
		local var_3_34 = RedPointConst.HERO_PROPERTY_PAGE .. iter_3_21
		local var_3_35 = RedPointConst.HERO_STAR_ID .. iter_3_21
		local var_3_36 = RedPointConst.HERO_SKIN_ID .. iter_3_21
		local var_3_37 = {}
		local var_3_38 = SkinCfg.get_id_list_by_hero[iter_3_21]

		for iter_3_22, iter_3_23 in pairs(var_3_38) do
			table.insert(var_3_37, RedPointConst.HERO_SKIN_ROUTE_ID .. iter_3_23)
		end

		arg_3_0:addGroup(var_3_36, var_3_37)

		local var_3_39 = {}
		local var_3_40 = {}

		for iter_3_24, iter_3_25 in pairs(SkinCfg.get_id_list_by_hero[iter_3_21]) do
			local var_3_41 = RedPointConst.HERO_SKIN_ID_EXTEND .. iter_3_25

			table.insert(var_3_39, var_3_41)

			if #SkinCfg[iter_3_25].gift > 0 then
				local var_3_42 = RedPointConst.SKIN_GIFT .. "_" .. iter_3_25

				table.insert(var_3_40, var_3_42)
			end
		end

		local var_3_43 = {}

		table.insertto(var_3_43, var_3_39)
		table.insertto(var_3_43, var_3_40)
		arg_3_0:addGroup(var_3_36, var_3_43)

		local var_3_44 = string.format("%s_%s", RedPointConst.HERO_REALTION, iter_3_21)
		local var_3_45 = string.format("%s_%s", RedPointConst.HERO_REALTION_UNLOCK, iter_3_21)
		local var_3_46 = string.format("%s_%s", RedPointConst.HERO_RELATION_STORY, iter_3_21)
		local var_3_47 = string.format("%s_%s", RedPointConst.HERO_RELATION_COMBO_SKILL, iter_3_21)

		arg_3_0:addGroup(var_3_44, {
			var_3_45,
			var_3_46,
			var_3_47
		})
		arg_3_0:addGroup(var_3_34, {
			var_3_35,
			var_3_36,
			var_3_33,
			var_3_31
		})
		table.insert(var_3_27, RedPointConst.HERO_HEART_STORY_ROOT_ID .. iter_3_21)

		local var_3_48 = HeroTools.GetHeroOntologyID(iter_3_21)

		arg_3_0:addGroup(RedPointConst.HERO_ARCHIVE_ID .. iter_3_21, {
			RedPointConst.HERO_HEARTLINK_ID .. var_3_48,
			string.format("%s_%s", RedPointConst.HERO_TRUST_UP_LEVEL, iter_3_21),
			var_3_44
		})

		for iter_3_26 = 1, HeroConst.HERO_HEARTLINK_STORY_MAX_COUNT do
			local var_3_49 = table.concat({
				RedPointConst.HERO_HEARTLINK_ID,
				var_3_48,
				"_",
				iter_3_26
			})

			arg_3_0:addGroup(RedPointConst.HERO_HEARTLINK_ID .. var_3_48, {
				var_3_49
			})
		end

		if var_3_22[iter_3_21] then
			arg_3_0:addGroup(var_3_29, {
				RedPointConst.OATH_HERO .. iter_3_21
			})
		end

		arg_3_0:addGroup(var_3_29, {
			var_3_35,
			var_3_36,
			var_3_33
		})
	end

	arg_3_0:addGroup(RedPointConst.HERO, var_3_28)
	arg_3_0:addGroup(RedPointConst.HERO_HEART_STORY_ROOT_FULL, var_3_27)
	arg_3_0:addGroup(RedPointConst.SIGN_DAILY, {
		RedPointConst.ACCUMULATE_LOGIN
	})

	local var_3_50 = {
		RedPointConst.TAROT_SIGN,
		RedPointConst.BIG_MONTH_CARD,
		RedPointConst.SIGN_DAILY
	}
	local var_3_51 = ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.SEVEN_SIGN] or {}

	for iter_3_27, iter_3_28 in ipairs(var_3_51) do
		table.insert(var_3_50, string.format("%s_%s", RedPointConst.SIGN_SEVEN_DAY, iter_3_28))
	end

	arg_3_0:addGroup(RedPointConst.SIGN, var_3_50)

	local var_3_52 = {}
	local var_3_53 = ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.SEVEN_DAY_SIGN_SKIN] or {}

	for iter_3_29, iter_3_30 in ipairs(var_3_53) do
		table.insert(var_3_52, string.format("%s_%s", RedPointConst.SEVEN_DAY_SIGN_SKIN, iter_3_30))
	end

	arg_3_0:addGroup(RedPointConst.SEVEN_DAY_SIGN_SKIN, var_3_52)

	local var_3_54 = {}
	local var_3_55 = ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.SEVEN_DAY_SIGN_SKIN_LUWU] or {}

	for iter_3_31, iter_3_32 in ipairs(var_3_55) do
		table.insert(var_3_54, string.format("%s_%s", RedPointConst.SEVEN_DAY_SIGN_SKIN, iter_3_32))
	end

	arg_3_0:addGroup(RedPointConst.SEVEN_DAY_SIGN_SKIN, var_3_54)

	local var_3_56 = {}
	local var_3_57 = ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.SEVEN_DAY_SIGN_SKIN_WORLD_LINE] or {}

	for iter_3_33, iter_3_34 in ipairs(var_3_57) do
		table.insert(var_3_56, string.format("%s_%s", RedPointConst.SEVEN_DAY_SIGN_SKIN, iter_3_34))
	end

	arg_3_0:addGroup(RedPointConst.SEVEN_DAY_SIGN_SKIN, var_3_56)

	local var_3_58 = {}
	local var_3_59 = ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.SEVEN_DAY_SIGN_SKIN_NEW] or {}

	for iter_3_35, iter_3_36 in ipairs(var_3_59) do
		table.insert(var_3_58, string.format("%s_%s", RedPointConst.SEVEN_DAY_SIGN_SKIN, iter_3_36))
	end

	arg_3_0:addGroup(RedPointConst.SEVEN_DAY_SIGN_SKIN, var_3_58)

	local var_3_60 = 4300102

	arg_3_0:addGroup(string.format("%s_%s", RedPointConst.SEVEN_DAY_SIGN_SKIN, var_3_60), {
		string.format("%s_%s", RedPointConst.SEVEN_DAY_SIGN_SKIN_GIFT, var_3_60)
	})

	local var_3_61 = {}
	local var_3_62 = ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.SEVEN_DAY_SIGN_SKIN_NEW] or {}

	for iter_3_37, iter_3_38 in ipairs(var_3_62) do
		if iter_3_38 == ActivityConst.ACTIVITY_4_0_SEVEN_DAY_SKIN_SIGN then
			table.insert(var_3_61, string.format("%s_%s", RedPointConst.SEVEN_DAY_SIGN_SKIN_NEWSIGN, iter_3_38))
			table.insert(var_3_61, string.format("%s_%s", RedPointConst.SEVEN_DAY_SIGN_SKIN_GIFT, iter_3_38))
			arg_3_0:addGroup(string.format("%s_%s", RedPointConst.SEVEN_DAY_SIGN_SKIN, iter_3_38), var_3_61)
		end
	end

	arg_3_0:addGroup(RedPointConst.SEVEN_DAY_SIGN_SKIN, var_3_61)

	local var_3_63 = {}
	local var_3_64 = ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.ACTIVITY_SPRING_FESTIVAL_GIVE_2100] or {}

	for iter_3_39, iter_3_40 in ipairs(var_3_64) do
		table.insert(var_3_63, string.format("%s_%s", RedPointConst.ACTIVITY_SPRING_FESTIVAL_GIVE_2100, iter_3_40))
	end

	arg_3_0:addGroup(RedPointConst.ACTIVITY_SPRING_FESTIVAL_GIVE_2100, var_3_63)

	local var_3_65 = ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.NORSE_SURPRISE_GIFT_DRAW] or {}

	for iter_3_41, iter_3_42 in ipairs(var_3_65) do
		local var_3_66 = string.format("%s_%s", RedPointConst.ACTIVITY_3_0_SURPRISE_GIFT_DRAW, iter_3_42)
		local var_3_67 = string.format("%s_%s", RedPointConst.ACTIVITY_3_0_SURPRISE_GIFT_RECEIVE, iter_3_42)
		local var_3_68 = string.format("%s_%s", RedPointConst.ACTIVITY_3_0_SURPRISE_GIFT, iter_3_42)

		arg_3_0:addGroup(var_3_68, {
			var_3_66,
			var_3_67
		})
	end

	local var_3_69 = string.format("%s_%s", RedPointConst.ACTIVITY_3_0_SURPRISE_GIFT, ActivityConst.ACTIVITY_3_0_SURPRISE_GIFT_DRAW)

	arg_3_0:addGroup(string.format("%s_%s", RedPointConst.SEVEN_DAY_SIGN_SKIN, ActivityConst.ACTIVITY_3_0_SEVEN_DAY_SKIN_SIGN), {
		var_3_69
	})

	local var_3_70 = {}
	local var_3_71 = {}
	local var_3_72 = {}

	for iter_3_43, iter_3_44 in ipairs(ChipCfg.get_id_list_by_type_id[ChipConst.TYPE_MANAGER]) do
		table.insert(var_3_71, string.format("%s_%s", RedPointConst.CHIP_MANAGER, iter_3_44))
		table.insert(var_3_72, string.format("%s_%s", RedPointConst.CHIP_MANAGER, iter_3_44))
	end

	for iter_3_45, iter_3_46 in ipairs(ChipCfg.get_id_list_by_type_id[ChipConst.TYPE_CHIP]) do
		table.insert(var_3_70, string.format("%s_%s", RedPointConst.CHIP_CHIP, iter_3_46))
		table.insert(var_3_72, string.format("%s_%s", RedPointConst.CHIP_CHIP, iter_3_46))
	end

	local var_3_73 = {}
	local var_3_74 = {}

	local function var_3_75(arg_4_0, arg_4_1)
		if not var_3_74[arg_4_0] then
			var_3_74[arg_4_0] = {}
		end

		table.insert(var_3_74[arg_4_0], arg_4_1)
	end

	for iter_3_47, iter_3_48 in ipairs(ChipCfg.get_id_list_by_type_id[ChipConst.TYPE_CHAR_CHIP]) do
		local var_3_76 = ChipCfg[iter_3_48]

		if var_3_76.role_type_id == ChipConst.ROLE_TYPE_CHAR_CHIP_BASE then
			table.insert(var_3_73, string.format("%s_%s", RedPointConst.CHIP_CHAR_CHIP, iter_3_48))
			var_3_75(iter_3_48, string.format("%s_%s", RedPointConst.CHIP_CHAR_BASE_CHIP, iter_3_48))
		elseif var_3_76.role_type_id == ChipConst.ROLE_TYPE_CHAR_CHIP_EXTRA then
			var_3_75(var_3_76.spec_char, string.format("%s_%s", RedPointConst.CHIP_CHAR_EXTRA_CHIP, iter_3_48))
		end
	end

	for iter_3_49, iter_3_50 in pairs(var_3_74) do
		arg_3_0:addGroup(string.format("%s_%s", RedPointConst.CHIP_CHAR_CHIP, iter_3_49), iter_3_50)
	end

	arg_3_0:addGroup(RedPointConst.CHIP_CHIP, var_3_70)
	arg_3_0:addGroup(RedPointConst.CHIP_MANAGER_CHIP, var_3_71)
	arg_3_0:addGroup(RedPointConst.CHIP_MANAGER, var_3_72)
	arg_3_0:addGroup(RedPointConst.CHIP_CHAR_CHIP, var_3_73)
	arg_3_0:addGroup(RedPointConst.ADMIN_HELP_BATTLE, {
		RedPointConst.CHIP_CHAR_CHIP,
		RedPointConst.CHIP_MANAGER
	})
	arg_3_0:addGroup(RedPointConst.ADMIN_MAIN_ENTER, {
		RedPointConst.ADMIN_HELP_BATTLE,
		RedPointConst.OATH_MAIN
	})

	for iter_3_51, iter_3_52 in pairs(ChipCfg.get_id_list_by_spec_char) do
		if iter_3_51 > 0 then
			local var_3_77 = RedPointConst.CHIP_HERO_CHIP .. "_" .. iter_3_51
			local var_3_78 = {}
			local var_3_79 = {}

			for iter_3_53, iter_3_54 in pairs(iter_3_52) do
				local var_3_80 = RedPointConst.CHIP_HERO_CHIP .. "_" .. iter_3_51 .. "_" .. ChipCfg[iter_3_54].role_type_id .. "_" .. iter_3_54

				if var_3_78[ChipCfg[iter_3_54].role_type_id] then
					table.insert(var_3_78[ChipCfg[iter_3_54].role_type_id], var_3_80)
				else
					var_3_78[ChipCfg[iter_3_54].role_type_id] = {
						var_3_80
					}
				end

				local var_3_81 = RedPointConst.CHIP_HERO_CURRENCY_CHIP .. "_" .. iter_3_51 .. "_" .. ChipCfg[iter_3_54].role_type_id .. "_" .. iter_3_54

				if var_3_79[ChipCfg[iter_3_54].role_type_id] then
					table.insert(var_3_79[ChipCfg[iter_3_54].role_type_id], var_3_81)
				else
					var_3_79[ChipCfg[iter_3_54].role_type_id] = {
						var_3_81
					}
				end
			end

			local var_3_82 = {}

			for iter_3_55, iter_3_56 in pairs(var_3_78) do
				local var_3_83 = RedPointConst.CHIP_HERO_CHIP .. "_" .. iter_3_51 .. "_" .. iter_3_55

				arg_3_0:addGroup(var_3_83, var_3_78[iter_3_55])
				table.insert(var_3_82, var_3_83)
			end

			for iter_3_57, iter_3_58 in pairs(var_3_79) do
				local var_3_84 = RedPointConst.CHIP_HERO_CURRENCY_CHIP .. "_" .. iter_3_51 .. "_" .. iter_3_57

				arg_3_0:addGroup(var_3_84, var_3_79[iter_3_57])
			end

			arg_3_0:addGroup(var_3_77, var_3_82)
		end
	end

	arg_3_0:addGroup(RedPointConst.FRIEND, {
		RedPointConst.FRIEND_FRIEND_REQUESTS
	})

	local var_3_85 = {}

	for iter_3_59, iter_3_60 in ipairs(ItemCfg.get_id_list_by_type[ItemConst.ITEM_TYPE.SCENE]) do
		local var_3_86 = HomeSceneSettingCfg[iter_3_60]

		if var_3_86 and var_3_86.limit_display == 1 then
			table.insert(var_3_85, RedPointConst.SCENE .. "_" .. iter_3_60)
		end
	end

	arg_3_0:addGroup(RedPointConst.SCENE_NORMAL, var_3_85)

	local var_3_87 = {}

	for iter_3_61, iter_3_62 in pairs(SkinSceneActionCfg.get_id_list_by_special_scene_id) do
		local var_3_88 = HomeSceneSettingCfg[iter_3_61]

		if var_3_88 and var_3_88.limit_display and var_3_88.limit_display == 0 then
			table.insert(var_3_87, RedPointConst.SCENE .. "_" .. iter_3_61)
		end
	end

	arg_3_0:addGroup(RedPointConst.SCENE_DLC, var_3_87)
	arg_3_0:addGroup(RedPointConst.SCENE, {
		RedPointConst.SCENE_NORMAL,
		RedPointConst.SCENE_DLC
	})
	arg_3_0:addGroup(RedPointConst.FORUM_PLATFORM, {
		RedPointConst.FORUM,
		RedPointConst.FORUM_UNREAD
	})
	arg_3_0:addGroup(RedPointConst.MAIN_HOME_FUNC, {
		RedPointConst.ADMIN_MAIN_ENTER,
		RedPointConst.SETTING_NEW_FUNCTION,
		RedPointConst.WEAPON_SERVANT_MERGE,
		RedPointConst.SIGN,
		RedPointConst.BULLETIN_UNREAD,
		RedPointConst.EXPLORE_MAIN,
		RedPointConst.COOPERATION_INVIT,
		RedPointConst.ACHIEVEMENT,
		RedPointConst.ILLU_USER,
		RedPointConst.FRIEND
	})
	arg_3_0:addGroup(RedPointConst.MAIN_HOME_MENU, {
		RedPointConst.MAIN_HOME_FUNC,
		RedPointConst.MAIN_HOME_SDK
	})

	local var_3_89 = {}

	for iter_3_63, iter_3_64 in pairs(AchievementCfg.get_id_list_by_type_id) do
		table.insert(var_3_89, string.format("%s_%s", RedPointConst.ACHIEVEMENT, iter_3_63))
	end

	local var_3_90 = {}

	for iter_3_65, iter_3_66 in pairs(AchievementStoryCfg.all) do
		table.insert(var_3_90, string.format("%s_%s", RedPointConst.ACHIEVEMENT_STORY, iter_3_66))
	end

	arg_3_0:addGroup(RedPointConst.ACHIEVEMENT_STORY, var_3_90)
	table.insertto(var_3_89, var_3_90)
	arg_3_0:addGroup(RedPointConst.ACHIEVEMENT, var_3_89)

	local var_3_91 = {}
	local var_3_92 = {}
	local var_3_93 = {}
	local var_3_94 = {}

	for iter_3_67, iter_3_68 in ipairs(ProfileDecorateItemCfg.all) do
		local var_3_95 = ProfileDecorateItemCfg[iter_3_68]

		if var_3_95.item_type == 4 then
			table.insert(var_3_91, RedPointConst.CUSTOM_STICKER_ITEM .. "_" .. iter_3_68)
		elseif var_3_95.item_type == 5 then
			table.insert(var_3_93, RedPointConst.CUSTOM_STICKER_ITEM .. "_" .. iter_3_68)
		elseif var_3_95.item_type == 6 then
			table.insert(var_3_92, RedPointConst.CUSTOM_STICKER_ITEM .. "_" .. iter_3_68)
		end
	end

	for iter_3_69, iter_3_70 in ipairs(StickerSuitCfg.all) do
		table.insert(var_3_94, RedPointConst.CUSTOM_STICKER_SUIT_REWARD .. "_" .. iter_3_70)
	end

	arg_3_0:addGroup(RedPointConst.CUSTOM_STICKER_BG, var_3_91)
	arg_3_0:addGroup(RedPointConst.CUSTOM_STICKER_FG, var_3_92)
	arg_3_0:addGroup(RedPointConst.CUSTOM_STICKER_ST, var_3_93)
	arg_3_0:addGroup(RedPointConst.CUSTOM_STICKER_SUIT_REWARD, var_3_94)
	arg_3_0:addGroup(RedPointConst.CUSTOM_STICKER_CATEGORY, {
		RedPointConst.CUSTOM_STICKER_ST,
		RedPointConst.CUSTOM_STICKER_BG,
		RedPointConst.CUSTOM_STICKER_FG
	})
	arg_3_0:addGroup(RedPointConst.CUSTOM_STICKER_ROOT, {
		RedPointConst.CUSTOM_STICKER_CATEGORY,
		RedPointConst.CUSTOM_STICKER_SUIT_REWARD
	})
	arg_3_0:addGroup(RedPointConst.PASSPORT_TASKS, {
		RedPointConst.PASSPORT_TASK_BONUS_7,
		RedPointConst.PASSPORT_TASK_BONUS_8,
		RedPointConst.PASSPORT_TASK_BONUS_9
	})
	arg_3_0:addGroup(RedPointConst.PASSPORT, {
		RedPointConst.PASSPORT_BONUS,
		RedPointConst.PASSPORT_TASKS,
		RedPointConst.PASSPORT_NEW_SEASON
	})
	arg_3_0:addGroup(RedPointConst.SHOP, {
		RedPointConst.HERO_PIECE_EXCHANGE,
		RedPointConst.NEW_SHOP_SHOP
	})
	arg_3_0:addGroup(RedPointConst.CYCLE_BONUS, {
		RedPointConst.CYCLE_BONUS_FREE,
		RedPointConst.CYCLE_BONUS_UNLOCK
	})
	arg_3_0:addGroup(RedPointConst.ACTIVITY_BONUS, {
		RedPointConst.ACTIVITY_BONUS_FREE,
		RedPointConst.ACTIVITY_BONUS_UNLOCK
	})
	arg_3_0:addGroup(RedPointConst.NEWBIE_BONUS, {
		RedPointConst.NEWBIE_BONUS_FREE,
		RedPointConst.NEWBIE_BONUS_UNLOCK
	})
	arg_3_0:addGroup(RedPointConst.NORMAL_BONUS, {
		RedPointConst.NORMAL_BONUS_FREE,
		RedPointConst.NORMAL_BONUS_UNLOCK
	})
	arg_3_0:addGroup(RedPointConst.RECHARGE_BONUS, {
		RedPointConst.ACTIVITY_BONUS,
		RedPointConst.CYCLE_BONUS,
		RedPointConst.NEWBIE_BONUS,
		RedPointConst.NORMAL_BONUS,
		RedPointConst.SKIN_DISCOUNT_GIFT
	})
	arg_3_0:addGroup(RedPointConst.RECHARGE_DOUBLE_AND_NOOB_MONTHLY_RECHARGE_SIGN, {
		RedPointConst.NOOB_MONTHLY_RECHARGE_SIGN,
		RED_POINT_ID.RECHARGE
	})
	arg_3_0:addGroup(RedPointConst.NOOB_RECHARGE, {
		RedPointConst.NOOB_FIRST_RECHARGE,
		RedPointConst.NOOB_MONTHLY_RECHARGE,
		RedPointConst.NOOB_BP_RECHARGE
	})
	arg_3_0:addGroup(RedPointConst.RECHARGE, {
		RedPointConst.RECHARGE_BONUS,
		RedPointConst.TOTAL_CHARGE_BONUS,
		RedPointConst.RECHARGE_DOUBLE_AND_NOOB_MONTHLY_RECHARGE_SIGN,
		RedPointConst.NOOB_RECHARGE,
		RedPointConst.NEW_SHOP_RECHARGE,
		RedPointConst.OATH_RING_COUPON_WILL_EXPIRE
	})
	arg_3_0:addGroup(RedPointConst.RECHARGE_ENTER, {
		RedPointConst.RECHARGE,
		RedPointConst.SHOP,
		RedPointConst.RECHARGE_RECOMMEND
	})
	arg_3_0:addGroup(RedPointConst.ILLU_ILLUSTRATION, {
		RedPointConst.ILLU_ILLUSTRATION1,
		RedPointConst.ILLU_ILLUSTRATION2,
		RedPointConst.ILLU_ILLUSTRATION3,
		RedPointConst.ILLU_ILLUSTRATION4,
		RedPointConst.ILLU_ILLUSTRATION5,
		RedPointConst.ILLU_ILLUSTRATION6
	})
	arg_3_0:addGroup(RedPointConst.ILLU_USER, {
		RedPointConst.ILLU_ILLUSTRATION,
		RedPointConst.ILLU_HERO
	})

	local var_3_96 = {}
	local var_3_97 = ItemCfg.get_id_list_by_type[ItemConst.ITEM_TYPE.TAG]

	for iter_3_71, iter_3_72 in ipairs(var_3_97) do
		if ItemCfg[iter_3_72].sub_type ~= ItemConst.ITEM_SUB_TYPE.TAG_LIMIT then
			table.insert(var_3_96, RedPointConst.TAG .. "_" .. iter_3_72)
		end
	end

	arg_3_0:addGroup(RedPointConst.TAG, var_3_96)

	local var_3_98 = {}
	local var_3_99 = ItemCfg.get_id_list_by_type[ItemConst.ITEM_TYPE.CARD_BG]

	for iter_3_73, iter_3_74 in ipairs(var_3_99) do
		table.insert(var_3_98, RedPointConst.CARD_BG .. "_" .. iter_3_74)
	end

	arg_3_0:addGroup(RedPointConst.CARD_BG, var_3_98)

	local var_3_100 = {}
	local var_3_101 = ItemCfg.get_id_list_by_type[ItemConst.ITEM_TYPE.PORTRAIT]

	for iter_3_75, iter_3_76 in ipairs(var_3_101) do
		table.insert(var_3_100, RedPointConst.PORTRAIT .. "_" .. iter_3_76)
	end

	arg_3_0:addGroup(RedPointConst.PORTRAIT, var_3_100)

	local var_3_102 = {}
	local var_3_103 = ItemCfg.get_id_list_by_type[ItemConst.ITEM_TYPE.FRAME]

	for iter_3_77, iter_3_78 in ipairs(var_3_103) do
		table.insert(var_3_102, RedPointConst.FRAME .. "_" .. iter_3_78)
	end

	arg_3_0:addGroup(RedPointConst.FRAME, var_3_102)

	local var_3_104 = {}
	local var_3_105 = GameSetting.profile_chat_bubble_default.value[1]

	for iter_3_79, iter_3_80 in ipairs(ItemCfg.get_id_list_by_type[ItemConst.ITEM_TYPE.CHAT_BUBBLE]) do
		if iter_3_80 ~= var_3_105 then
			table.insert(var_3_104, string.format("%s_%s", RedPointConst.CHAT_BUBBLE, iter_3_80))
		end
	end

	arg_3_0:addGroup(RedPointConst.CHAT_BUBBLE, var_3_104)
	arg_3_0:addGroup(RedPointConst.USER_CUSTOM, {
		RedPointConst.CHAT_BUBBLE,
		RedPointConst.PORTRAIT,
		RedPointConst.FRAME,
		RedPointConst.CARD_BG
	})
	arg_3_0:addGroup(RedPointConst.ILLU_MAIN, {
		RedPointConst.BRITHDAY,
		RedPointConst.TAG,
		RedPointConst.USER_CUSTOM
	})
	arg_3_0:addGroup(RedPointConst.ILLU_HERO, {
		RedPointConst.HERO_RACE_COLLECT_REWARD
	})

	local var_3_106 = {}

	for iter_3_81, iter_3_82 in ipairs(ActivityMonsterCosplayCfg.all) do
		local var_3_107 = ActivityMonsterCosplayCfg[iter_3_82]

		var_3_106[iter_3_82] = {}

		for iter_3_83, iter_3_84 in ipairs(var_3_107.skill_list) do
			table.insert(var_3_106[iter_3_82], "MonsterCosPlay" .. iter_3_84)
		end
	end

	local var_3_108 = {}

	for iter_3_85, iter_3_86 in ipairs(ActivityMonsterCosplayCfg.all) do
		arg_3_0:addGroup("MonsterCosPlayMonsterID" .. iter_3_86, var_3_106[iter_3_86])
		table.insert(var_3_108, "MonsterCosPlayMonsterID" .. iter_3_86)
	end

	arg_3_0:addGroup(RedPointConst.MONSTER_COSPLAY_SKILL, var_3_108)
	arg_3_0:addGroup(RedPointConst.NOOB_FIRST_RECHARGE, {
		RedPointConst.NOOB_FIRST_RECHARGE_1,
		RedPointConst.NOOB_FIRST_RECHARGE_2
	})
	arg_3_0:addGroup(RedPointConst.NEWBIE_POINT, {
		RedPointConst.NEWBIE_SIGN,
		RedPointConst.NEWBIE_TASK,
		RedPointConst.NEWBIE_UPGRADE,
		RedPointConst.NEWBIE_DAILY_TASK,
		RedPointConst.NOOB_FIRST_RECHARGE,
		RedPointConst.NOOB_MONTHLY_RECHARGE,
		RedPointConst.NOOB_BP_RECHARGE
	})

	local var_3_109 = {}

	for iter_3_87, iter_3_88 in ipairs(NoobVersionCfg.all) do
		local var_3_110 = NoobVersionCfg[iter_3_88]
		local var_3_111 = var_3_110.noob_advance_task_type

		if type(var_3_111) == "table" then
			for iter_3_89, iter_3_90 in ipairs(var_3_111) do
				local var_3_112 = string.format("%s_%d", RedPointConst.NOOB_ADVANCE, iter_3_90)

				var_3_109[#var_3_109 + 1] = var_3_112

				local var_3_113 = var_3_110.noob_advance_task_phase[iter_3_89]
				local var_3_114 = NoobAdvanceTaskPhaseListCfg[var_3_113].phase_list
				local var_3_115 = {}

				for iter_3_91, iter_3_92 in ipairs(var_3_114) do
					local var_3_116 = string.format("%s_%d_%d", RedPointConst.NOOB_ADVANCE, iter_3_90, iter_3_91)

					var_3_115[#var_3_115 + 1] = var_3_116

					local var_3_117 = {}

					for iter_3_93, iter_3_94 in ipairs(iter_3_92[2]) do
						var_3_117[#var_3_117 + 1] = string.format("%s_%d_%d_%d", RedPointConst.NOOB_ADVANCE, iter_3_90, iter_3_91, iter_3_94[1])
					end

					arg_3_0:addGroup(var_3_116, var_3_117)
				end

				arg_3_0:addGroup(var_3_112, var_3_115)
			end

			arg_3_0:addGroup(RedPointConst.NOOB_ADVANCE, var_3_109)
		end
	end

	arg_3_0:addGroup(RedPointConst.GUILD, {
		RedPointConst.GUILD_REQUEST,
		RedPointConst.CLUB_TASK,
		RedPointConst.CLUB_WELFARE,
		RedPointConst.GUILD_MANAGER,
		RedPointConst.GUILD_BOSS
	})
	arg_3_0:addGroup(RedPointConst.GUILD_MANAGER, {
		RedPointConst.GUILD_IMPEACH,
		RedPointConst.GUILD_REQUEST
	})
	arg_3_0:addGroup(RedPointConst.DORM_MAIN, {
		RedPointConst.DORM_HERO_MOOD,
		RedPointConst.DORM_TOTAL_EARN,
		RedPointConst.DORM_SPECIAL_EVENT
	})
	arg_3_0:addGroup(RedPointConst.MATRIX_TERMINAL_GIFT, {
		RedPointConst.MATRIX_TERMINAL_GIFT_STRUGGLE,
		RedPointConst.MATRIX_TERMINAL_GIFT_SHELTER
	})

	local var_3_118 = {}

	for iter_3_95, iter_3_96 in pairs(WarchessLevelCfg.get_id_list_by_type) do
		if iter_3_95 ~= 0 then
			local var_3_119 = {}

			for iter_3_97, iter_3_98 in ipairs(iter_3_96) do
				table.insert(var_3_119, string.format("%s_%s_%s", RedPointConst.WAR_CHESS, iter_3_95, iter_3_98))
			end

			arg_3_0:addGroup(string.format("%s_%s", RedPointConst.WAR_CHESS, iter_3_95), var_3_119)
		end
	end

	local var_3_120 = {}

	for iter_3_99, iter_3_100 in ipairs(StageGroupCfg.get_id_list_by_type[BattleConst.STAGE_TYPE_NEW.OSIRIS_DEMON]) do
		table.insert(var_3_120, DemonChallengeData:GetRedPointConst(iter_3_99))
	end

	arg_3_0:addGroup(RedPointConst.OSIRIS_DEMON, var_3_120)

	for iter_3_101, iter_3_102 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.HERO_TRIAL]) do
		local var_3_121 = ActivityCfg[iter_3_102].sub_activity_list
		local var_3_122 = {}

		for iter_3_103, iter_3_104 in pairs(var_3_121) do
			local var_3_123 = ActivityHeroTrialCfg.get_id_list_by_activity_id[iter_3_104]

			if var_3_123 == nil then
				print(iter_3_104)
			else
				for iter_3_105, iter_3_106 in ipairs(var_3_123) do
					table.insert(var_3_122, string.format("%s_%s", RedPointConst.HERO_TRIAL, iter_3_106))
				end
			end
		end

		arg_3_0:addGroup(string.format("%s_%s", RedPointConst.HERO_TRIAL, iter_3_102), var_3_122)
	end

	arg_3_0:addGroup(RedPointConst.OSIRIS_ACTIVITY, {
		string.format("%s_%s", RedPointConst.ACTIVITY_TASK, ActivityConst.OSIRIS_TASK_DAILY),
		string.format("%s_%s", RedPointConst.WAR_CHESS, ActivityConst.OSIRIS_CHESS),
		RedPointConst.OSIRIS_DEMON,
		RedPointConst.OSIRIS_RACE_TRIAL,
		string.format("%s_%s", RedPointConst.HERO_TRIAL, ActivityConst.OSIRIS_HERO_TRIAL_STAGE)
	})

	for iter_3_107, iter_3_108 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.SKIN_TRIAL]) do
		local var_3_124 = ActivityCfg[iter_3_108].sub_activity_list
		local var_3_125 = {}

		for iter_3_109, iter_3_110 in pairs(var_3_124) do
			local var_3_126 = ActivitySkinTrialCfg.get_id_list_by_activity_id[iter_3_110]

			for iter_3_111, iter_3_112 in ipairs(var_3_126 or {}) do
				table.insert(var_3_125, string.format("%s_%s", RedPointConst.SKIN_TRIAL, iter_3_112))
			end
		end

		arg_3_0:addGroup(string.format("%s_%s", RedPointConst.SKIN_TRIAL, iter_3_108), var_3_125)
	end

	local var_3_127 = ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.SLAYER] or {}

	for iter_3_113, iter_3_114 in ipairs(var_3_127) do
		local var_3_128 = ActivityCfg[iter_3_114].sub_activity_list

		if #var_3_128 > 0 then
			local var_3_129 = {}

			for iter_3_115, iter_3_116 in ipairs(var_3_128) do
				arg_3_0:addGroup(string.format("%s_%s", RedPointConst.SLYAER_REGIONS, iter_3_116), {
					string.format("%s_%s", RedPointConst.SLAYER_REGIONS_SELECT, iter_3_116),
					string.format("%s_%s", RedPointConst.SLAYER_REGIONS_REWARD, iter_3_116)
				})

				var_3_129[#var_3_129 + 1] = string.format("%s_%s", RedPointConst.SLYAER_REGIONS, iter_3_116)
			end

			arg_3_0:addGroup(string.format("%s_%s", RedPointConst.SLYAER_REGIONS, iter_3_114), var_3_129)
		end

		arg_3_0:addGroup(string.format("%s_%s", RedPointConst.SLAYER, iter_3_114), {
			string.format("%s_%s", RedPointConst.SLYAER_REGIONS, iter_3_114),
			string.format("%s_%s", RedPointConst.SLYAER_REWARD, iter_3_114)
		})
	end

	local var_3_130 = ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.PARKOUR] or {}

	for iter_3_117, iter_3_118 in ipairs(var_3_130) do
		arg_3_0:addGroup(string.format("%s_%s", RedPointConst.PARKOUR, iter_3_118), {
			string.format("%s_%s", RedPointConst.PARKOUR_ENTRUST_ALL, iter_3_118)
		})
		arg_3_0:addGroup(string.format("%s_%s", RedPointConst.PARKOUR_ENTRUST_ALL, iter_3_118), {
			string.format("%s_%s", RedPointConst.PARKOUR_REWARD, iter_3_118),
			string.format("%s_%s", RedPointConst.PARKOUR_ENTRUST, iter_3_118)
		})

		local var_3_131 = ActivityCfg[iter_3_118].sub_activity_list
		local var_3_132 = {}

		for iter_3_119, iter_3_120 in ipairs(var_3_131) do
			table.insert(var_3_132, string.format("%s_%s", RedPointConst.PARKOUR_ENTRUST_REWARD, iter_3_120))
		end

		arg_3_0:addGroup(string.format("%s_%s", RedPointConst.PARKOUR_REWARD, iter_3_118), var_3_132)
	end

	arg_3_0:addGroup(RedPointConst.REGRESSION, {
		RedPointConst.REGRESSION_SIGN,
		RedPointConst.REGRESSION_SURVEY,
		RedPointConst.REGRESSION_TASK,
		RedPointConst.REGRESSION_BP,
		RedPointConst.REGRESSION_SUPPLY_FREE
	})
	arg_3_0:addGroup(RedPointConst.REGRESSION_TASK, {
		string.format("%s_%s", RedPointConst.REGRESSION_TASK, TaskConst.TASK_TYPE.REGRESSION_DAILY),
		string.format("%s_%s", RedPointConst.REGRESSION_TASK, TaskConst.TASK_TYPE.REGRESSION_WEEK),
		string.format("%s_%s", RedPointConst.REGRESSION_TASK, TaskConst.TASK_TYPE.REGRESSION_CHALLENGE)
	})
	arg_3_0:addGroup(RedPointConst.NEW_REGRESSION, {
		RedPointConst.NEW_REGRESSION_TASK,
		RedPointConst.NEW_REGRESSION_PRIVILEGE
	})

	local var_3_133 = {
		TaskConst.TASK_TYPE.REGRESSION_CURRENT_ACT,
		TaskConst.TASK_TYPE.REGRESSION_DRAW,
		TaskConst.TASK_TYPE.REGRESSION_TILI
	}
	local var_3_134 = {
		RedPointConst.NEW_REGRESSION_SIGN
	}

	for iter_3_121, iter_3_122 in pairs(var_3_133) do
		local var_3_135 = string.format("%s_%s", RedPointConst.NEW_REGRESSION_TASK_TOGGLE, iter_3_122)

		table.insert(var_3_134, var_3_135)
		arg_3_0:addGroup(var_3_135, {
			var_3_134,
			string.format("%s_%s", RedPointConst.NEW_REGRESSION_TASK_REWARD, iter_3_122),
			var_3_134,
			string.format("%s_%s", RedPointConst.NEW_REGRESSION_TASK_FIRST, iter_3_122)
		})
	end

	arg_3_0:addGroup(RedPointConst.NEW_REGRESSION_TASK, var_3_134)
	arg_3_0:addGroup(RedPointConst.NEW_REGRESSION_SIGN, {
		RedPointConst.NEW_REGRESSION_SIGN_REWARD,
		RedPointConst.NEW_REGRESSION_SIGN_FIRST
	})
	arg_3_0:addGroup(RedPointConst.NEW_REGRESSION_PRIVILEGE, {
		RedPointConst.NEW_REGRESSION_RES_FIND,
		RedPointConst.NEW_REGRESSION_SHOP,
		RedPointConst.NEW_REGRESSION_DRAW_NEW_TAG,
		RedPointConst.NEW_REGRESSION_GIFT_NET_TAG
	})
	arg_3_0:addGroup(RedPointConst.NEW_REGRESSION_GIFT_NET_TAG, {
		RedPointConst.NEW_REGRESSION_MONTHCARD_NEW_TAG,
		RedPointConst.NEW_REGRESSION_PASSPORT_NEW_TAG
	})
	arg_3_0:addGroup(RedPointConst.NEW_REGRESSION_SHOP, {
		RedPointConst.NEW_REGRESSION_FREE_DAILY_REWARD,
		RedPointConst.NEW_REGRESSION_FREE_REWARD
	})
	arg_3_0:addGroup(RedPointConst.NEW_REGRESSION, {
		RedPointConst.NEW_REGRESSION_TASK,
		RedPointConst.NEW_REGRESSION_PRIVILEGE
	})
	arg_3_0:addGroup(RedPointConst.GUILD_BOSS, {
		RedPointConst.GUILD_BOSS_PREPOSE_FIRST_BONUS,
		RedPointConst.GUILD_BOSS_PERSONAL_BONUS,
		RedPointConst.GUILD_BOSS_COMMON_BONUS,
		RedPointConst.GUILD_BOSS_PREPOSE_OPEN,
		RedPointConst.GUILD_BOSS_CHALLENGE_OPEN
	})
	arg_3_0:addGroup(RedPointConst.GUILD_BOSS_BOSS_BTN, {
		RedPointConst.GUILD_BOSS_PERSONAL_BONUS,
		RedPointConst.GUILD_BOSS_COMMON_BONUS,
		RedPointConst.GUILD_BOSS_CHALLENGE_OPEN
	})

	local var_3_136 = ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.SINGLE_MATRIX] or {}

	for iter_3_123, iter_3_124 in ipairs(var_3_136) do
		arg_3_0:addGroup(string.format("%s_%s", RedPointConst.ACTIVITY_MATRIX, iter_3_124), {
			string.format("%s_%s", RedPointConst.ACTIVITY_MATRIX_REWARD, iter_3_124),
			string.format("%s_%s", RedPointConst.ACTIVITY_MATRIX_CLUE, iter_3_124),
			string.format("%s_%s", RedPointConst.ACTIVITY_MATRIX_READ, iter_3_124)
		})
	end

	if not ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.ACTIVITY_ZUMA] then
		local var_3_137 = {}
	end

	local var_3_138 = {}

	table.insert(var_3_138, RedPointConst.ZUMA_REWARD)
	table.insert(var_3_138, RedPointConst.ZUMA_TALENT)

	local var_3_139 = ZumaData:GetZumaCfgData()

	for iter_3_125, iter_3_126 in pairs(ZumaConst.ZUMA_DIFFICULT or {}) do
		local var_3_140 = var_3_139[iter_3_126]
		local var_3_141 = {}

		for iter_3_127, iter_3_128 in ipairs(var_3_140 or {}) do
			table.insert(var_3_141, string.format("%s_%s", RedPointConst.ZUMA_OPEN, iter_3_128.activity_id))
		end

		local var_3_142 = string.format("%s_%s", RedPointConst.ZUMA_DIFFICULT, iter_3_126)

		arg_3_0:addGroup(var_3_142, var_3_141)
		table.insert(var_3_138, var_3_142)
	end

	arg_3_0:addGroup(RedPointConst.ZUMA .. ActivityConst.ACTIVITY_ZUMA, var_3_138)
	arg_3_0:addGroup(RedPointConst.ZUMA .. ActivityConst.ACTIVITY_3_11_ZUMA, var_3_138)

	local var_3_143 = ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.STRATEGY_MATRIX] or {}

	for iter_3_129, iter_3_130 in ipairs(var_3_143) do
		local var_3_144 = StrategyMatrixCfg[iter_3_130]

		if var_3_144.activity_difficulty == 1 then
			arg_3_0:addGroup(string.format("%s_%s", RedPointConst.STRATEGY_MATRIX, iter_3_130), {
				string.format("%s_%s", RedPointConst.STRATEGY_MATRIX_OPEN, iter_3_130),
				string.format("%s_%s", RedPointConst.STRATEGY_MATRIX_REWARD, iter_3_130)
			})
		else
			local var_3_145 = var_3_144.pre_condition_args[1] and var_3_144.pre_condition_args[1][2][1]

			if var_3_145 then
				arg_3_0:addGroup(string.format("%s_%s", RedPointConst.STRATEGY_MATRIX, var_3_145), {
					string.format("%s_%s", RedPointConst.STRATEGY_MATRIX_OPEN, iter_3_130),
					string.format("%s_%s", RedPointConst.STRATEGY_MATRIX_REWARD, iter_3_130)
				})
			else
				print("困难模式的肉鸽，无法取到前置活动id,联系活动肉鸽策划")
			end
		end
	end

	local var_3_146 = ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.GUILD_ACTIVITY] or {}

	for iter_3_131, iter_3_132 in ipairs(var_3_146) do
		arg_3_0:addGroup(string.format("%s_%s", RedPointConst.GUILD_ACTIVITY, iter_3_132), {
			string.format("%s_%s", RedPointConst.GUILD_ACTIVITY_RATE, iter_3_132),
			RedPointConst.GUILD_ACTIVITY_UNREGISTER,
			string.format("%s_%s", RedPointConst.GUILD_ACTIVITY_UNGET_COIN, iter_3_132)
		})

		local var_3_147 = {}

		for iter_3_133, iter_3_134 in pairs(TalentTreeCfg.get_id_list_by_activity_id_and_race[iter_3_132]) do
			local var_3_148 = string.format("%s_%d_%d", RedPointConst.GUILD_ACTIVITY_AFFIX, iter_3_132, iter_3_133)

			var_3_147[#var_3_147 + 1] = var_3_148

			local var_3_149 = {}

			for iter_3_135, iter_3_136 in pairs(iter_3_134) do
				var_3_149[#var_3_149 + 1] = string.format("%s_%d_%d_%d", RedPointConst.GUILD_ACTIVITY_AFFIX, iter_3_132, iter_3_133, iter_3_136)
			end

			arg_3_0:addGroup(var_3_148, var_3_149)
		end

		arg_3_0:addGroup(string.format("%s_%d", RedPointConst.GUILD_ACTIVITY_AFFIX, iter_3_132), var_3_147)
	end

	local var_3_150 = GuildActivitySPTools:GetActivityState()

	for iter_3_137, iter_3_138 in pairs(var_3_150) do
		arg_3_0:addGroup(string.format("%s_%s", RedPointConst.GUILD_ACTIVITY_SP, iter_3_137), {
			RedPointConst.GUILD_ACTIVITY_SP_UNREGISTER
		})

		local var_3_151 = iter_3_138.start

		arg_3_0:addGroup(string.format("%s_%s", RedPointConst.GUILD_ACTIVITY_SP, iter_3_137), {
			string.format("%s_%s", RedPointConst.GUILD_ACTIVITY_SP_BONUS, var_3_151),
			string.format("%s_%s", RedPointConst.GUILD_ACTIVITY_SP_UNGET_COIN, var_3_151),
			string.format("%s_%s", RedPointConst.GUILD_ACTIVITY_SP_HERO_FIGHT, var_3_151)
		})

		local var_3_152 = {}

		if TalentTreeCfg.get_id_list_by_activity_id_and_race[var_3_151] then
			for iter_3_139, iter_3_140 in pairs(TalentTreeCfg.get_id_list_by_activity_id_and_race[var_3_151]) do
				local var_3_153 = string.format("%s_%d_%d", RedPointConst.GUILD_ACTIVITY_SP_AFFIX, var_3_151, iter_3_139)

				var_3_152[#var_3_152 + 1] = var_3_153

				local var_3_154 = {}

				for iter_3_141, iter_3_142 in pairs(iter_3_140) do
					var_3_154[#var_3_154 + 1] = string.format("%s_%d_%d_%d", RedPointConst.GUILD_ACTIVITY_SP_AFFIX, var_3_151, iter_3_139, iter_3_142)
				end

				arg_3_0:addGroup(var_3_153, var_3_154)
			end

			arg_3_0:addGroup(string.format("%s_%d", RedPointConst.GUILD_ACTIVITY_SP_AFFIX, var_3_151), var_3_152)
		end
	end

	local var_3_155 = ActivityCfg[ActivityConst.FACTORY_MARDUK].sub_activity_list
	local var_3_156 = {}

	for iter_3_143, iter_3_144 in ipairs(var_3_155) do
		table.insert(var_3_156, string.format("%s_%d", RedPointConst.MARDUK_SPECIAL_NOT_FIGHT, iter_3_144))
	end

	arg_3_0:addGroup(string.format("%s_%d", RedPointConst.MARDUK_SPECIAL_NOT_FIGHT, ActivityConst.FACTORY_MARDUK), var_3_156)
	arg_3_0:addGroup(string.format("%s_%d", RedPointConst.MARDUK_SPECIAL, ActivityConst.FACTORY_MARDUK), {
		string.format("%s_%d", RedPointConst.MARDUK_SPECIAL_NOT_FIGHT, ActivityConst.FACTORY_MARDUK),
		string.format("%s_%d", RedPointConst.MARDUK_SPECIAL_REWARD, ActivityConst.FACTORY_MARDUK)
	})

	local var_3_157 = ActivityCfg[ActivityConst.ACTIVITY_2_2_SPECIAL].sub_activity_list
	local var_3_158 = {}

	for iter_3_145, iter_3_146 in ipairs(var_3_157) do
		table.insert(var_3_158, string.format("%s_%d", RedPointConst.MARDUK_SPECIAL_NOT_FIGHT, iter_3_146))
	end

	arg_3_0:addGroup(string.format("%s_%d", RedPointConst.MARDUK_SPECIAL_NOT_FIGHT, ActivityConst.ACTIVITY_2_2_SPECIAL), var_3_158)
	arg_3_0:addGroup(string.format("%s_%d", RedPointConst.MARDUK_SPECIAL, ActivityConst.ACTIVITY_2_2_SPECIAL), {
		string.format("%s_%d", RedPointConst.MARDUK_SPECIAL_NOT_FIGHT, ActivityConst.ACTIVITY_2_2_SPECIAL),
		string.format("%s_%d", RedPointConst.MARDUK_SPECIAL_REWARD, ActivityConst.ACTIVITY_2_2_SPECIAL)
	})

	local var_3_159 = ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.FIRE_WORK_MAIN] or {}

	for iter_3_147, iter_3_148 in ipairs(var_3_159) do
		local var_3_160 = ActivityCfg[iter_3_148].sub_activity_list
		local var_3_161 = {}

		for iter_3_149, iter_3_150 in ipairs(var_3_160) do
			if ActivityCfg[iter_3_150].activity_template == ActivityTemplateConst.FIRE_WORK then
				local var_3_162 = string.format("%s_%s", RedPointConst.FIRE_WORK, iter_3_150)

				arg_3_0:addGroup(var_3_162, {
					string.format("%s_%s", RedPointConst.FIRE_WORK_OPEN, iter_3_150),
					string.format("%s_%s", RedPointConst.FIRE_WORK_REWARD, iter_3_150)
				})
				table.insert(var_3_161, var_3_162)
			end
		end

		arg_3_0:addGroup(string.format("%s_%s", RedPointConst.FIRE_WORK_MAIN, iter_3_148), var_3_161)
	end

	local var_3_163 = {}

	for iter_3_151 = 1, 4 do
		table.insert(var_3_163, string.format("%s_%s", RedPointConst.CANTEEN_DISPATCH_FINISHED, iter_3_151))
	end

	arg_3_0:addGroup(RedPointConst.CANTEEN_DISPATCH, {
		RedPointConst.CANTEEN_DISPATCH_FINISHED,
		RedPointConst.CANTEEN_DISPATCH_NONE,
		RedPointConst.CANTEEN_UNLOCK_ENTRUST
	})
	arg_3_0:addGroup(RedPointConst.CANTEEN, var_3_163)
	arg_3_0:addGroup(RedPointConst.CANTEEN, {
		RedPointConst.CANTEEN_MAX,
		RedPointConst.CANTEEN_DISPATCH,
		RedPointConst.CANTEEN_BUSINESS_STOPPED,
		RedPointConst.CANTEEN_JOB_AVAILABLE,
		RedPointConst.CANTEEN_UPGRADE_AVAILABLE,
		RedPointConst.CANTEEN_UNLOCK_FOOD,
		RedPointConst.CANTEEN_UNLOCK_ENTRUST
	})
	arg_3_0:addGroup(ActivityTools.GetRedPointKey(ActivityConst.SPRING_CANTEEN) .. ActivityConst.SPRING_CANTEEN, {
		RedPointConst.CANTEEN
	})
	arg_3_0:addGroup(RedPointConst.BACKHOME_INFO, {
		RedPointConst.CANTEEN_MAX,
		RedPointConst.CANTEEN_DISPATCH
	})

	local var_3_164 = #GameSetting.dorm_canteen_task_unlock.value
	local var_3_165 = {}

	for iter_3_152 = 1, var_3_164 do
		var_3_165[iter_3_152] = string.format("%s_%s", RedPointConst.CANTEEN_UNLOCK_ENTRUST, tostring(iter_3_152))
	end

	arg_3_0:addGroup(RedPointConst.CANTEEN_UNLOCK_ENTRUST, var_3_165)

	local var_3_166 = {}
	local var_3_167 = 1

	for iter_3_153, iter_3_154 in pairs(DormEnum.FurnitureTypeNum) do
		var_3_166[var_3_167] = string.format("%s_%s", RedPointConst.CANTEEN_UNLOCK_FOOD, tostring(iter_3_154))
		var_3_167 = var_3_167 + 1
	end

	arg_3_0:addGroup(RedPointConst.CANTEEN_UNLOCK_FOOD, var_3_166)

	for iter_3_155, iter_3_156 in pairs(DormEnum.FurnitureTypeNum) do
		local var_3_168 = {}

		for iter_3_157, iter_3_158 in ipairs(BackHomeCanteenFoodCfg.all) do
			if BackHomeCanteenFoodCfg[iter_3_158].cook_type == iter_3_156 then
				local var_3_169 = string.format("%s_%s_%s", RedPointConst.CANTEEN_UNLOCK_FOOD, tostring(iter_3_156), iter_3_158)

				table.insert(var_3_168, var_3_169)
			end
		end

		arg_3_0:addGroup(string.format("%s_%s", RedPointConst.CANTEEN_UNLOCK_FOOD, iter_3_156), var_3_168)
	end

	local var_3_170 = {}

	for iter_3_159, iter_3_160 in pairs(DormEnum.FurnitureMainType) do
		local var_3_171 = string.format("%s_%s", RedPointConst.CANTEEN_UPGRADE_AVAILABLE, tostring(iter_3_160))

		table.insert(var_3_170, var_3_171)
	end

	arg_3_0:addGroup(RedPointConst.CANTEEN_UPGRADE_AVAILABLE, var_3_170)
	arg_3_0:addGroup(RedPointConst.DORM, {
		RedPointConst.DORM_PLACEMENT
	})
	arg_3_0:addGroup(RedPointConst.DORM_NAVI, {
		RedPointConst.DORM_ILLU,
		RedPointConst.CANTEEN,
		RedPointConst.IDOL_TRAINEE
	})

	local var_3_172 = {}

	for iter_3_161, iter_3_162 in ipairs(BackHomeCfg.all) do
		if BackHomeCfg[iter_3_162].type == 3 then
			table.insert(var_3_172, RedPointConst.DORM_PLACEMENT_ROOM .. iter_3_162)
		end
	end

	arg_3_0:addGroup(RedPointConst.DORM_PLACEMENT, var_3_172)

	local var_3_173 = {}

	for iter_3_163 = DormConst.DORM_FUR_TYPE_START, DormConst.DORM_FUR_TYPE_END do
		table.insert(var_3_173, string.format("%s_%s", RedPointConst.DORM_FURNITURE, tostring(iter_3_163)))
	end

	table.insert(var_3_173, RedPointConst.DORM_SUIT)
	arg_3_0:addGroup(RedPointConst.DORM_FURNITURE, var_3_173)

	local var_3_174 = {}
	local var_3_175 = {}
	local var_3_176 = DormSuitData:GetSuitIDListByType(DormSuitTools.DORM_SUIT_TYPE.FULL_SET)

	for iter_3_164, iter_3_165 in ipairs(var_3_176) do
		local var_3_177 = BackHomeSuitCfg[iter_3_165].scene_id[1]

		if var_3_177 == DormConst.BACKHOME_TYPE.PublicDorm then
			table.insert(var_3_175, string.format("%s_%s", RedPointConst.DORM_FULL_PUBLIC_SUIT, tostring(iter_3_165)))
		elseif var_3_177 == DormConst.BACKHOME_TYPE.PrivateDorm then
			table.insert(var_3_174, string.format("%s_%s", RedPointConst.DORM_FULL_PRIVATE_SUIT, tostring(iter_3_165)))
		end
	end

	arg_3_0:addGroup(RedPointConst.DORM_FULL_PUBLIC_SUIT, var_3_175)
	arg_3_0:addGroup(RedPointConst.DORM_FULL_PRIVATE_SUIT, var_3_174)

	local var_3_178 = {}
	local var_3_179 = DormSuitData:GetSuitIDListByType(DormSuitTools.DORM_SUIT_TYPE.PART_SET)

	for iter_3_166, iter_3_167 in ipairs(var_3_179) do
		table.insert(var_3_178, string.format("%s_%s", RedPointConst.DORM_PART_SUIT, tostring(iter_3_167)))
	end

	arg_3_0:addGroup(RedPointConst.DORM_PART_SUIT, var_3_178)

	local var_3_180 = {}
	local var_3_181 = DormTools:GetAllDormShopIDList()

	for iter_3_168, iter_3_169 in ipairs(var_3_181) do
		local var_3_182 = DormSuitTools:GetFurSuitGoodListByShopID(iter_3_169)
		local var_3_183 = {}

		if #var_3_182 > 0 then
			for iter_3_170, iter_3_171 in ipairs(var_3_182) do
				table.insert(var_3_183, DormRedPointTools.FurnitureItemRedPoint(iter_3_169, iter_3_171))
			end

			local var_3_184 = ShopTools.GetShopRedPointKey(iter_3_169)

			arg_3_0:addGroup(var_3_184, var_3_183)
			table.insert(var_3_180, var_3_184)
		end
	end

	arg_3_0:addGroup(RedPointConst.DORM_SUIT_SHOP, var_3_180)

	local var_3_185 = {}
	local var_3_186 = {}
	local var_3_187 = {}

	table.insert(var_3_185, RedPointConst.DORM_ILLU_HERO)
	table.insert(var_3_185, RedPointConst.DORM_ILLU_REWARD_1)
	arg_3_0:addGroup(RedPointConst.DORM_ILLU_HERO_ALL, var_3_185)

	local var_3_188 = {}

	for iter_3_172, iter_3_173 in ipairs(BackHomeFurnitureThemeCfg.all) do
		local var_3_189 = RedPointConst.DORM_ILLU_FUR_THEME .. iter_3_173

		table.insert(var_3_188, var_3_189)
	end

	arg_3_0:addGroup(RedPointConst.DORM_ILLU_FUR, var_3_188)
	table.insert(var_3_186, RedPointConst.DORM_ILLU_FUR)
	table.insert(var_3_186, RedPointConst.DORM_ILLU_REWARD_3)
	arg_3_0:addGroup(RedPointConst.DORM_ILLU_FUR_ALL, var_3_186)
	table.insert(var_3_187, RedPointConst.DORM_ILLU_DANCE)
	table.insert(var_3_187, RedPointConst.DORM_ILLU_REWARD_2)
	arg_3_0:addGroup(RedPointConst.DORM_ILLU_DANCE_ALL, var_3_187)
	arg_3_0:addGroup(RedPointConst.DORM_ILLU_NEW, {
		RedPointConst.DORM_ILLU_HERO_ALL,
		RedPointConst.DORM_ILLU_FUR_ALL,
		RedPointConst.DORM_ILLU_DANCE_ALL
	})
	arg_3_0:addGroup(RedPointConst.DORM_ILLU_REWARD, {
		RedPointConst.DORM_ILLU_REWARD_1,
		RedPointConst.DORM_ILLU_REWARD_2,
		RedPointConst.DORM_ILLU_REWARD_3
	})
	arg_3_0:addGroup(RedPointConst.DORM_ILLU, {
		RedPointConst.DORM_ILLU_REWARD,
		RedPointConst.DORM_ILLU_NEW
	})

	local var_3_190 = {}

	for iter_3_174, iter_3_175 in ipairs(IdolTraineeChapterCfg.all) do
		table.insert(var_3_190, string.format("%s_%s", RedPointConst.IDOL_TRAINEE_CHAPTER_TASK, iter_3_175))
	end

	arg_3_0:addGroup(RedPointConst.IDOL_TRAINEE_CHAPTER_TASK, var_3_190)
	arg_3_0:addGroup(RedPointConst.IDOL_TASK, {
		RedPointConst.IDOL_TASK_GAIN,
		RedPointConst.IDOL_TRAINEE_DAY_AND_WEEK_TASK
	})
	arg_3_0:addGroup(RedPointConst.IDOL_TRAINEE, {
		RedPointConst.IDOL_TRAINEE_CHAPTER_TASK
	})
	arg_3_0:addGroup(RedPointConst.BACKHOME, {
		RedPointConst.DORM,
		RedPointConst.CANTEEN,
		RedPointConst.DORM_ILLU,
		RedPointConst.IDOL_TRAINEE,
		RedPointConst.IDOL_TASK
	})
	arg_3_0:addGroup(RedPointConst.ABYSS, {
		RedPointConst.ABYSS_REWARD,
		RedPointConst.ABYSS_CHALLENGE,
		string.format(ServerRedPointPrefix, ServerRedPoint.DISORDER_TRAP_NEW_RED, "ROOT")
	})

	local var_3_191 = MailSpecialLetterCfg.get_id_list_by_letter_belongs
	local var_3_192 = {}

	for iter_3_176, iter_3_177 in pairs(var_3_191) do
		table.insert(var_3_192, RedPointConst.LETTER_SENDER_ID .. iter_3_176)

		local var_3_193 = {}

		for iter_3_178, iter_3_179 in pairs(iter_3_177) do
			table.insert(var_3_193, RedPointConst.LETTER_ID .. iter_3_179)
		end

		arg_3_0:addGroup(RedPointConst.LETTER_SENDER_ID .. iter_3_176, var_3_193)
	end

	arg_3_0:addGroup(RedPointConst.LETTER_UNREAD, var_3_192)
	arg_3_0:addGroup(RedPointConst.MAIL_UNREAD, {
		RedPointConst.LETTER_UNREAD
	})
	arg_3_0:addGroup(RedPointConst.POLYHEDRON, {
		RedPointConst.POLYHEDRON_BEACON_UNLOCK,
		RedPointConst.POLYHEDRON_POLICY_LEVEL_REWARD,
		RedPointConst.POLYHEDRON_HERO_UNLOCK,
		RedPointConst.POLYHEDRON_RESIDENT_TASK,
		RedPointConst.POLYHEDRON_TERMINAL_GIFT,
		RedPointConst.POLYHEDRON_NEW_SECTION
	})
	arg_3_0:addGroup(RedPointConst.RECALL, {
		RedPointConst.RECALL_SIGN,
		RedPointConst.RECALL_TASK,
		RedPointConst.RECALL_REWARD
	})

	local var_3_194 = {}

	for iter_3_180 = 1, #ExploreMeowCfg.all do
		local var_3_195 = ExploreMeowCfg.all[iter_3_180]

		var_3_194[iter_3_180] = RedPointConst.EXPLORE_UNLOCK_ADMIN_CAT .. var_3_195
	end

	local var_3_196 = {}

	for iter_3_181 = 1, #ExploreAreaCfg.all do
		local var_3_197 = ExploreAreaCfg.all[iter_3_181]

		var_3_196[iter_3_181] = RedPointConst.EXPLORE_FINISH .. var_3_197
	end

	arg_3_0:addGroup(RedPointConst.EXPLORE_UNLOCK_ADMIN_CAT, var_3_194)
	arg_3_0:addGroup(RedPointConst.EXPLORE_FINISH, var_3_196)
	arg_3_0:addGroup(RedPointConst.EXPLORE_MAIN, {
		RedPointConst.EXPLORE_REWARD,
		RedPointConst.EXPLORE_UNLOCK_ADMIN_CAT,
		RedPointConst.EXPLORE_FINISH,
		RedPointConst.EXPLORE_QUEUE
	})
	arg_3_0:addGroup(RedPointConst.INVITE_MAIN, {
		RedPointConst.INVITE_DRAW,
		RedPointConst.INVITE_PLOT
	})
	arg_3_0:addGroup(RedPointConst.SETTING_SCREEN, {
		RedPointConst.HIGH_FPS_DEVICE_SURRPORT
	})
	arg_3_0:addGroup(RedPointConst.SETING_GAME_RED, {
		RedPointConst.DLC_BTN_RED
	})
	arg_3_0:addGroup(RedPointConst.SETTING_NEW_FUNCTION, {
		RedPointConst.SETTING_SCREEN,
		RedPointConst.SETTING_REMIND,
		RedPointConst.SETING_GAME_RED
	})

	local var_3_198 = {}

	for iter_3_182, iter_3_183 in ipairs(RechargeRecommendCfg.all) do
		table.insert(var_3_198, RedPointConst.RECHARGE_RECOMMEND .. iter_3_183)
	end

	arg_3_0:addGroup(RedPointConst.RECHARGE_RECOMMEND, var_3_198)

	for iter_3_184, iter_3_185 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.STRONGHOLD]) do
		arg_3_0:addGroup(string.format("%s_%s", RedPointConst.STRONGHOLD, iter_3_185), {
			string.format("%s_%s", RedPointConst.STRONGHOLD_REWARD, iter_3_185),
			string.format("%s_%s", RedPointConst.STRONGHOLD_INCREASE, iter_3_185),
			string.format("%s_%s", RedPointConst.STRONGHOLD_TASK, iter_3_185)
		})
	end

	arg_3_0:addGroup(RedPointConst.SOLO_HEART_DEMON, {
		RedPointConst.SOLO_HEART_DEMON_FIRST_VIEW,
		RedPointConst.SOLO_HEART_DEMON_REWARD
	})
	arg_3_0:addGroup(RedPointConst.MULT_HEART_DEMON, {
		RedPointConst.MULT_HEART_DEMON_FIRST_VIEW,
		RedPointConst.MULT_HEART_DEMON_REWARD
	})
	arg_3_0:addGroup(RedPointConst.MULT_HEART_DEMON, {
		RedPointConst.MULT_HEART_DEMON_FIRST_VIEW,
		RedPointConst.MULT_HEART_DEMON_REWARD
	})

	local var_3_199 = {}

	for iter_3_186, iter_3_187 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.ACTIVITY_SKIN_DRAW]) do
		table.insert(var_3_199, RedPointConst.ACTIVITY_DRAW .. "_" .. iter_3_187)
	end

	arg_3_0:addGroup(RedPointConst.ACTIVITY_DRAW, var_3_199)

	local var_3_200 = ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.ACTIVITY_ATTRIBUTE_ARENA] or {}

	for iter_3_188, iter_3_189 in ipairs(var_3_200) do
		arg_3_0:addGroup(string.format("%s_%s", RedPointConst.ACTIVITY_ATTRIBUTE_ARENA, iter_3_189), {
			string.format("%s_%s", RedPointConst.ACTIVITY_ATTRIBUTE_ARENA_TASK, iter_3_189),
			string.format("%s_%s", RedPointConst.ACTIVITY_ATTRIBUTE_ARENA_ENTER, iter_3_189)
		})
	end

	arg_3_0:addGroup(RedPointConst.CORE_VERIFICATION, {
		RedPointConst.CORE_VERIFICATION_REWARD,
		RedPointConst.CORE_VERIFICATION_CHALLENGE
	})
	arg_3_0:addGroup(RedPointConst.CORE_VERIFICATION_CHALLENGE, {
		RedPointConst.CORE_VERIFICATION_CHALLENGE_NEXT
	})

	local var_3_201 = {}
	local var_3_202 = CoreVerificationChallengeTools.GetAllCoreVerificationChallengeMode()

	for iter_3_190, iter_3_191 in ipairs(var_3_202) do
		local var_3_203 = ActivityCfg.get_id_list_by_activity_template[iter_3_191] or {}

		for iter_3_192, iter_3_193 in ipairs(var_3_203) do
			table.insert(var_3_201, RedPointConst.CORE_VERIFICATION_CHALLENGE_NEXT .. "_" .. iter_3_193)
		end
	end

	arg_3_0:addGroup(RedPointConst.CORE_VERIFICATION_CHALLENGE_NEXT, var_3_201)
	arg_3_0:addGroup(RedPointConst.CORE_VERIFICATION_REWARD, {
		RedPointConst.CORE_VERIFICATION_CHALLENGE_NORMAL_REWARD,
		RedPointConst.CORE_VERIFICATION_CHALLENGE_MODE_REWARD
	})
	arg_3_0:addGroup(RedPointConst.CORE_VERIFICATION_CHALLENGE_NORMAL_REWARD, {
		RedPointConst.CORE_VERIFICATION_REWARD1,
		RedPointConst.CORE_VERIFICATION_REWARD2,
		RedPointConst.CORE_VERIFICATION_REWARD3,
		RedPointConst.CORE_VERIFICATION_REWARD4
	})
	arg_3_0:addGroup(RedPointConst.CORE_VERIFICATION_CHALLENGE_MODE_REWARD, {
		RedPointConst.CORE_VERIFICATION_REWARD5
	})

	local var_3_204 = SPHeroChallengeData.activityCfg[ActivityConst.ACTIVITY_HERO_CHALLENGE_3_1].heroChipActivityID
	local var_3_205 = SPHeroChallengeData.activityCfg[ActivityConst.ACTIVITY_HERO_CHALLENGE_3_1].taskActivityID

	arg_3_0:addGroup(RedPointConst.SP_HERO_CHALLENGE_3_1, {
		RedPointConst.SP_HERO_CHALLENGE_3_1_ENTRUST,
		string.format("%s_%s", RedPointConst.ACTIVITY_TASK, var_3_204),
		string.format("%s_%s", RedPointConst.ACTIVITY_TASK, var_3_205)
	})

	local var_3_206 = {}

	for iter_3_194, iter_3_195 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.ACTIVITY_SWIMSUIT_BATTLE_HERO_STAGE]) do
		table.insert(var_3_206, string.format("%s_%s", RedPointConst.ACTIVITY_SWIMSUIT_BATTLE_HERO, iter_3_195))
	end

	table.insert(var_3_206, RedPointConst.ACTIVITY_SWIMSUIT_BATTLE_REWARD)
	arg_3_0:addGroup(string.format("%s%s", ActivityTools.GetRedPointKey(282951), 282951), var_3_206)
	arg_3_0:addGroup(string.format("%s%s", ActivityTools.GetRedPointKey(282961), 282961), {
		RedPointConst.ACTIVITY_SWIMSUIT_VOTE_TICKET,
		RedPointConst.ACTIVITY_SWIMSUIT_VOTE_REWARD
	})

	local var_3_207 = {}
	local var_3_208 = {}
	local var_3_209 = {
		RedPointConst.CAPTURE_GAME_UNLOCK_STAGE,
		"_",
		0
	}
	local var_3_210 = {
		RedPointConst.CAPTURE_GAME_UNLOCK_SECTION,
		"_",
		0
	}

	for iter_3_196, iter_3_197 in ipairs(ActivitySwimSkinSectionCfg.all) do
		local var_3_211 = ActivitySwimSkinSectionCfg[iter_3_197]
		local var_3_212 = {}

		var_3_210[3] = iter_3_197

		local var_3_213 = table.concat(var_3_210)

		if var_3_211.mode == CaptureGameConst.CaptureGameMode.Single then
			for iter_3_198, iter_3_199 in ipairs(var_3_211.sub_section_list) do
				var_3_209[3] = iter_3_199

				table.insert(var_3_212, table.concat(var_3_209))
			end

			table.insert(var_3_207, var_3_213)
		elseif var_3_211.mode == CaptureGameConst.CaptureGameMode.Multiple then
			for iter_3_200, iter_3_201 in ipairs(var_3_211.sub_section_list) do
				var_3_209[3] = iter_3_201

				table.insert(var_3_212, table.concat(var_3_209))
			end

			table.insert(var_3_208, var_3_213)
		end

		arg_3_0:addGroup(var_3_213, var_3_212)
	end

	arg_3_0:addGroup(RedPointConst.CAPTURE_GAME_UNLOCK_SINGLE_ROOT, var_3_207)
	arg_3_0:addGroup(RedPointConst.CAPTURE_GAME_UNLOCK_MULTI_ROOT, var_3_208)
	arg_3_0:addGroup(RedPointConst.CAPTURE_GAME_UNLOCK_ROOT, {
		RedPointConst.CAPTURE_GAME_UNLOCK_SINGLE_ROOT,
		RedPointConst.CAPTURE_GAME_UNLOCK_MULTI_ROOT,
		RedPointConst.CAPTURE_GAME_TASK_REWARD
	})
	arg_3_0:addGroup(ActivityTools.GetRedPointKey(ActivityConst.ACTIVITY_SWIM_SKIN) .. ActivityConst.ACTIVITY_SWIM_SKIN, {
		RedPointConst.CAPTURE_GAME_UNLOCK_ROOT
	})
	arg_3_0:addGroup(RedPointConst.ACTIVITY_3_5_CATCH_DUCK, {
		RedPointConst.ACTIVITY_3_5_CATCH_DUCK_STAGE,
		RedPointConst.ACTIVITY_3_5_CATCH_DUCK_TASK
	})
	arg_3_0:addGroup(ActivityTools.GetRedPointKey(ActivityConst.SUMMER_CHESS_BOARD_PLUZZE) .. ActivityConst.SUMMER_CHESS_BOARD_PLUZZE, {
		RedPointConst.ACTIVITY_3_5_TANGRAM_GAME
	})
	arg_3_0:addGroup(RedPointConst.ACTIVITY_3_5_TANGRAM_GAME, {
		RedPointConst.ACTIVITY_3_5_TANGRAM_GAME_CHAPTER,
		string.format("%s_%s", RedPointConst.ACTIVITY_TASK, ActivityConst.SUMMER_CHESS_BOARD_PLUZZE_TASK)
	})
	arg_3_0:addGroup(string.format("%s_%s", RedPointConst.ACTIVITY_TASK, ActivityConst.SUMMER_CHESS_BOARD_PLUZZE_TASK), {
		string.format("%s_%s", RedPointConst.ACTIVITY_TASK, ActivityConst.ACTIVITY_3_5_TANGRAM_GAME_TASK1),
		string.format("%s_%s", RedPointConst.ACTIVITY_TASK, ActivityConst.ACTIVITY_3_5_TANGRAM_GAME_TASK2)
	})
	arg_3_0:addGroup(string.format("%s%s", ActivityTools.GetRedPointKey(2932801), 2932801), {
		RedPointConst.ACTIVITY_IDOL_COMPETITION_SIGN,
		RedPointConst.ACTIVITY_IDOL_COMPETITION_REWARD
	})

	local var_3_214 = {}

	for iter_3_202, iter_3_203 in ipairs(ActivityTangramGameChapterCfg.all) do
		local var_3_215 = string.format("%s_%s", RedPointConst.ACTIVITY_3_5_TANGRAM_GAME_CHAPTER, iter_3_203)

		table.insert(var_3_214, var_3_215)
		arg_3_0:addGroup(var_3_215, {
			string.format("%s_%s", RedPointConst.ACTIVITY_3_5_TANGRAM_GAME_FULL_CLUE, iter_3_203),
			string.format("%s_%s", RedPointConst.ACTIVITY_3_5_TANGRAM_GAME_STAGE, iter_3_203)
		})
	end

	arg_3_0:addGroup(RedPointConst.ACTIVITY_3_5_TANGRAM_GAME_CHAPTER, var_3_214)

	local var_3_216 = {}

	for iter_3_204, iter_3_205 in ipairs(ActivityWaterPipeStageCfg.all) do
		local var_3_217 = string.format("%s_%s", RedPointConst.ACTIVITY_WATER_PIPE_STAGE, iter_3_205)

		table.insert(var_3_216, var_3_217)
	end

	arg_3_0:addGroup(ActivityTools.GetRedPointKey(WaterPipeData:GetMainActivityID()) .. WaterPipeData:GetMainActivityID(), var_3_216)
	arg_3_0:addGroup(ActivityTools.GetRedPointKey(ActivityConst.ACTIVITY_WATER_PIPE_HOME) .. ActivityConst.ACTIVITY_WATER_PIPE_HOME, var_3_216)

	local var_3_218 = {}
	local var_3_219 = {}
	local var_3_220 = ActivityCfg[ActivityConst.ACTIVITY_RED_ENVELOPE].sub_activity_list

	for iter_3_206, iter_3_207 in ipairs(var_3_220) do
		table.insert(var_3_218, RedPointConst.ACTIVITY_RED_ENVELOPE_NEW_DAY .. "_" .. iter_3_207)
		table.insert(var_3_219, RedPointConst.ACTIVITY_RED_ENVELOPE_CAN_CLAIMED .. "_" .. iter_3_207)
	end

	local var_3_221 = ActivityTools.GetRedPointKey(ActivityConst.ACTIVITY_RED_ENVELOPE) .. ActivityConst.ACTIVITY_RED_ENVELOPE

	arg_3_0:addGroup(RedPointConst.ACTIVITY_RED_ENVELOPE_NEW_DAY .. "_" .. ActivityConst.ACTIVITY_RED_ENVELOPE, var_3_218)
	arg_3_0:addGroup(RedPointConst.ACTIVITY_RED_ENVELOPE_CAN_CLAIMED .. "_" .. ActivityConst.ACTIVITY_RED_ENVELOPE, var_3_219)
	arg_3_0:addGroup(var_3_221, {
		RedPointConst.ACTIVITY_RED_ENVELOPE_NEW_DAY .. "_" .. ActivityConst.ACTIVITY_RED_ENVELOPE,
		RedPointConst.ACTIVITY_RED_ENVELOPE_CAN_CLAIMED .. "_" .. ActivityConst.ACTIVITY_RED_ENVELOPE
	})
	arg_3_0:BindQWorldRedPoint()
end

function var_0_0.BindQWorldRedPoint(arg_5_0)
	local var_5_0 = SandPlayMapCfg.all

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		local var_5_1 = SandPlayMapCfg[iter_5_1].activity_id
		local var_5_2 = ActivityCfg[var_5_1].sub_activity_list
		local var_5_3 = {}

		for iter_5_2, iter_5_3 in ipairs(var_5_2) do
			table.insert(var_5_3, ActivityTools.GetRedPointKey(iter_5_3) .. iter_5_3)
			arg_5_0:appendGroup(ActivityTools.GetRedPointKey(var_5_1) .. var_5_1, ActivityTools.GetRedPointKey(iter_5_3) .. iter_5_3, true)
		end
	end

	local var_5_4 = {
		RedPointConst.QWORLD_BOOKLET_LEVEL_REWARD,
		RedPointConst.QUANZHOU_LIMIT_TASK_ALL
	}

	arg_5_0:addGroup(RedPointConst.QWORLD_ACTIVITY_ENTRY, var_5_4)
	arg_5_0:appendGroup(ActivityTools.GetRedPointKey(ActivityConst.ACTIVITY_QUANZHOU_ENTRY) .. ActivityConst.ACTIVITY_QUANZHOU_ENTRY, RedPointConst.QWORLD_ACTIVITY_ENTRY)
end

function var_0_0.InitData(arg_6_0)
	arg_6_0._redPointHelper:InitData()
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0._redPointHelper:Dispose()
end

function var_0_0.checkAnyRedPointSystemIsLocked(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.redPointRelateSystem[arg_8_1]

	if var_8_0 then
		for iter_8_0, iter_8_1 in pairs(var_8_0) do
			if JumpTools.IsSystemLocked(iter_8_0) then
				return true
			end
		end
	end

	return false
end

function var_0_0.setRelateSystem(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0.redPointRelateSystem[arg_9_1] or {}

	var_9_0[arg_9_2] = true
	arg_9_0.redPointRelateSystem[arg_9_1] = var_9_0
end

function var_0_0.setTip(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	return arg_10_0._redPointHelper:setTip(arg_10_1, arg_10_2, arg_10_3)
end

function var_0_0.getTipValue(arg_11_0, arg_11_1)
	return arg_11_0._redPointHelper:getTipValue(arg_11_1)
end

function var_0_0.getchildKeys(arg_12_0, arg_12_1)
	return arg_12_0._redPointHelper:getchildKeys(arg_12_1)
end

function var_0_0.getTipBoolean(arg_13_0, arg_13_1)
	return arg_13_0._redPointHelper:getTipBoolean(arg_13_1)
end

function var_0_0.addGroup(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	arg_14_0._redPointHelper:addGroup(arg_14_1, arg_14_2, arg_14_3)
end

function var_0_0.appendGroup(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	arg_15_0._redPointHelper:appendToGroup(arg_15_1, arg_15_2, arg_15_3)
end

function var_0_0.delGroup(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0._redPointHelper:delGroup(arg_16_1, arg_16_2)
end

function var_0_0.updateKey(arg_17_0, arg_17_1)
	arg_17_0._redPointHelper:updateKey(arg_17_1)
end

function var_0_0.bindUIandKey(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	arg_18_0._redPointHelper:bindUIandKey(arg_18_1, arg_18_2, arg_18_3)
end

function var_0_0.unbindUIandKey(arg_19_0, arg_19_1, arg_19_2)
	arg_19_0._redPointHelper:unbindUIandKey(arg_19_1, arg_19_2)
end

function var_0_0.setRedPoint(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	if arg_20_2 then
		arg_20_0._redPointHelper:ChangeRedStyle(arg_20_1, arg_20_3 or RedPointStyle.NORMAL, nil, nil, arg_20_2)
	else
		arg_20_0._redPointHelper:ChangeRedStyle(arg_20_1, RedPointStyle.None, nil, nil, arg_20_2)
	end
end

function var_0_0.ForceHideRedPoint(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_1:Find("notice_img")

	if var_21_0 then
		SetActive(var_21_0.gameObject, false)
	end
end

function var_0_0.SetRedPointIndependent(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	if arg_22_2 then
		arg_22_0._redPointHelper:ChangeRedStyle({
			display = arg_22_1
		}, arg_22_4 or RedPointStyle.NORMAL, arg_22_3, nil, arg_22_2)
	else
		arg_22_0._redPointHelper:ChangeRedStyle({
			display = arg_22_1
		}, RedPointStyle.None, arg_22_3, nil, arg_22_2)
	end
end

function var_0_0.ShowRedGraph(arg_23_0, arg_23_1)
	return manager.redPoint._redPointHelper:GetRedGraphWithKey(arg_23_0)
end

function var_0_0.PrintAllRedNode()
	return {
		data = "HHH"
	}
end

function var_0_0.PrintAllKey()
	local var_25_0 = manager.redPoint._redPointHelper:GetAllKey()

	for iter_25_0, iter_25_1 in ipairs(var_25_0) do
		var_25_0 = var_25_0 .. ","
	end

	return {
		data = table.concat(var_25_0)
	}
end

function var_0_0.PrintAllNilKey()
	local var_26_0 = manager.redPoint._redPointHelper:GetAllKey()

	for iter_26_0, iter_26_1 in ipairs(var_26_0) do
		if string.find(iter_26_1, "nil") then
			Debug.LogError(iter_26_1)
		end
	end
end

function var_0_0.AddRogueTeamGroup(arg_27_0)
	local var_27_0 = {}

	for iter_27_0, iter_27_1 in ipairs(RogueTeamCfg.all) do
		local var_27_1 = ChallengeRogueTeamTools.GetCollectActivityIDByType(iter_27_1, ChallengeRogueTeamConst.COLLECTION_TASK_TYPE.RELIC)
		local var_27_2 = ChallengeRogueTeamTools.GetCollectActivityIDByType(iter_27_1, ChallengeRogueTeamConst.COLLECTION_TASK_TYPE.EVENT)
		local var_27_3 = ChallengeRogueTeamTools.GetTaskActivityID(iter_27_1)
		local var_27_4 = string.format("%s_%s", RedPointConst.CHALLENGE_ROGUE_TEAM, iter_27_1)
		local var_27_5 = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, var_27_3)
		local var_27_6 = string.format("%s_%s", RedPointConst.CHALLENGE_ROGUE_TEAM_ILLUSTRATED, iter_27_1)
		local var_27_7 = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, var_27_1)
		local var_27_8 = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, var_27_2)
		local var_27_9 = string.format("%s_%s", RedPointConst.CHALLENGE_ROGUE_TEAM_ILLUSTRATED_CAMP, iter_27_1)
		local var_27_10 = string.format("%s_%s", RedPointConst.CHALLENGE_ROGUE_TEAM_ILLUSTRATED_END, iter_27_1)
		local var_27_11, var_27_12 = ChallengeRogueTeamData:GetAllCampTreasureIDListByTemp(RogueTeamCfg[iter_27_1].item_temp)
		local var_27_13 = {}

		for iter_27_2, iter_27_3 in ipairs(var_27_12) do
			local var_27_14 = ChallengeRogueTeamTools.GetTreasureCollectionActivityIDByCamp(iter_27_1, iter_27_3)
			local var_27_15 = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, var_27_14)
			local var_27_16 = {}

			if AssignmentCfg.get_id_list_by_activity_id[var_27_14] then
				for iter_27_4, iter_27_5 in ipairs(AssignmentCfg.get_id_list_by_activity_id[var_27_14]) do
					table.insert(var_27_16, string.format("%s_%s", RedPointConst.ACTIVITY_TASK, iter_27_5))
				end

				arg_27_0:addGroup(var_27_15, var_27_16)
			else
				Debug.LogError("队伍肉鸽流派未配置收集任务，流派ID： " .. iter_27_3)
			end

			table.insert(var_27_13, var_27_15)
		end

		arg_27_0:addGroup(var_27_9, var_27_13)

		local var_27_17 = ChallengeRogueTeamData:GetAllCollectionTaskByType(iter_27_1, ChallengeRogueTeamConst.COLLECTION_TASK_TYPE.END)
		local var_27_18 = {}

		for iter_27_6, iter_27_7 in ipairs(var_27_17) do
			local var_27_19 = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, iter_27_7)

			table.insert(var_27_18, var_27_19)
		end

		arg_27_0:addGroup(var_27_10, var_27_18)

		local var_27_20 = AssignmentCfg.get_id_list_by_activity_id[var_27_1]
		local var_27_21 = {}

		for iter_27_8, iter_27_9 in ipairs(var_27_20) do
			local var_27_22 = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, iter_27_9)

			table.insert(var_27_21, var_27_22)
		end

		arg_27_0:addGroup(var_27_7, var_27_21)

		local var_27_23 = AssignmentCfg.get_id_list_by_activity_id[var_27_2]
		local var_27_24 = {}

		for iter_27_10, iter_27_11 in ipairs(var_27_23) do
			local var_27_25 = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, iter_27_11)

			table.insert(var_27_24, var_27_25)
		end

		arg_27_0:addGroup(var_27_8, var_27_24)

		local var_27_26 = AssignmentCfg.get_id_list_by_activity_id[var_27_3]
		local var_27_27 = {}

		for iter_27_12, iter_27_13 in ipairs(var_27_26) do
			local var_27_28 = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, iter_27_13)

			table.insert(var_27_27, var_27_28)
		end

		arg_27_0:addGroup(var_27_5, var_27_27)
		arg_27_0:addGroup(var_27_6, {
			var_27_7,
			var_27_8,
			var_27_9,
			var_27_10
		})
		arg_27_0:addGroup(var_27_4, {
			string.format("%s_%s", RedPointConst.ACTIVITY_POINT_REWARD, ChallengeRogueTeamTools.GetPointActivityID(iter_27_1)),
			var_27_5,
			var_27_6
		})
		table.insert(var_27_0, var_27_4)
	end

	arg_27_0:addGroup(RedPointConst.CHALLENGE_ROGUE_TEAM, var_27_0)
end

return var_0_0
