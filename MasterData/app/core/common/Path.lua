local var_0_0 = g.core.config.resource_info
local var_0_1 = g.core.config.knight_info
local var_0_2 = g.core.config.item_info
local var_0_3 = g.core.config.unite_token_info
local var_0_4 = g.core.config.fragment_info
local var_0_5 = g.core.config.knight_base_info
local var_0_6 = g.core.config.knight_advance_material_info
local var_0_7 = g.core.config.treasure_info
local var_0_8 = g.core.config.equipment_info
local var_0_9 = g.core.config.dress_info
local var_0_10 = g.core.config.redpacket_info
local var_0_11 = g.core.config.pet_equipment_info
local var_0_12 = g.core.config.knight_favorability_item_info
local var_0_13 = g.core.config.play_num_info
local var_0_14 = g.core.config.furniture_info
local var_0_15 = g.core.config.avata_info
local var_0_16 = g.core.config.avatar_frame_info
local var_0_17 = g.core.config.bg_book_info
local var_0_18 = g.core.config.talk_show_group_info
local var_0_19 = g.core.config.gve_equipment_info
local var_0_20 = g.core.const.ConstMgr
local var_0_21 = g.core.const.ConstMgr.ThemeConst
local var_0_22 = cc.FileUtils:getInstance()
local var_0_23 = table.concat
local var_0_24 = {
	getBackground = function(arg_1_0, arg_1_1)
		return var_0_23({
			"bg/story/",
			arg_1_1,
			".jpg"
		})
	end,
	getHomeBackground = function(arg_2_0, arg_2_1)
		return var_0_23({
			"bg/home/",
			arg_2_1,
			".jpg"
		})
	end,
	getBgMask = function(arg_3_0, arg_3_1)
		return var_0_23({
			"bg/common/mask/",
			arg_3_1,
			".png"
		})
	end,
	getCommanderWorldRes = function(arg_4_0, arg_4_1)
		return var_0_23({
			"pic/order_world/",
			arg_4_1,
			".png"
		})
	end,
	getLoadingIcon = function(arg_5_0, arg_5_1, arg_5_2)
		return var_0_23({
			config.PUBLISH_REGION == g.core.const.ConstMgr.PlatformConst.REGION.CHINA and "pic/loading/rule/" or "pic/loading/",
			arg_5_1,
			"_",
			arg_5_2,
			".png"
		})
	end,
	getLoadingDayAndNightBg = function(arg_6_0, arg_6_1)
		if arg_6_1 then
			return "bg/loading/bg_loading_zhenying_2.jpg"
		else
			return "bg/loading/bg_loading_zhenying_1.jpg"
		end
	end,
	getLoadingBackground = function(arg_7_0, arg_7_1)
		return var_0_23({
			"pic/loadingBg/",
			arg_7_1,
			".jpg"
		})
	end,
	getDungeonStagePicById = function(arg_8_0, arg_8_1)
		return var_0_23({
			"pic/knight_painted/",
			arg_8_1,
			".png"
		})
	end,
	getProgressBoxIcon = function(arg_9_0, arg_9_1, arg_9_2)
		return var_0_23({
			"icon/box/box_",
			arg_9_1,
			"_",
			arg_9_2,
			".png"
		})
	end,
	getChestByLevelAndState = function(arg_10_0, arg_10_1, arg_10_2)
		arg_10_1 = arg_10_1 or 1
		arg_10_2 = arg_10_2 or 1

		return (var_0_23({
			"icon/box/box_",
			arg_10_1,
			"_",
			arg_10_2,
			".png"
		}))
	end,
	getDungeonChapterIconById = function(arg_11_0, arg_11_1)
		return var_0_23({
			"pic/dungeon_chapter/",
			arg_11_1,
			".png"
		})
	end,
	getStoryReplayCellPic = function(arg_12_0, arg_12_1)
		return var_0_23({
			"pic/dungeon_chapter/",
			arg_12_1,
			".jpg"
		})
	end,
	getThemeReplayCellPic = function(arg_13_0, arg_13_1)
		return var_0_23({
			"pic/dungeon_chapter/",
			arg_13_1,
			".jpg"
		})
	end,
	getThemeExplorePic = function(arg_14_0, arg_14_1)
		return var_0_23({
			"pic/explore/",
			arg_14_1,
			".png"
		})
	end,
	getThemeExplorePowerPic = function(arg_15_0, arg_15_1)
		return var_0_23({
			"icon/buff_icon/",
			arg_15_1,
			".png"
		})
	end,
	getThemeTurnCardIcon = function(arg_16_0, arg_16_1, arg_16_2)
		if arg_16_2 == var_0_21.THEME_VALUE.LEVIA then
			return var_0_23({
				"icon/turncard/pic_levia_fanpai_",
				arg_16_1,
				".png"
			})
		elseif arg_16_2 == var_0_21.THEME_VALUE.GOLDENDANCE then
			return var_0_23({
				"icon/turncard/pic_dance_fanpai_",
				arg_16_1,
				".png"
			})
		elseif arg_16_2 == var_0_21.THEME_VALUE.VEDFOLNIR then
			return var_0_23({
				"icon/turncard/pic_vedfolnir_fanpai_",
				arg_16_1,
				".png"
			})
		elseif arg_16_2 == var_0_21.THEME_VALUE.PLINY then
			return var_0_23({
				"icon/turncard/pic_levia_fanpai_",
				arg_16_1,
				".png"
			})
		else
			return var_0_23({
				"icon/turncard/pic_horus_fanpai_",
				arg_16_1,
				".png"
			})
		end
	end,
	getThemePuzzlePic = function(arg_17_0, arg_17_1, arg_17_2)
		if arg_17_2 then
			return var_0_23({
				"pic/puzzleDisplay/",
				arg_17_1,
				".png"
			})
		else
			return var_0_23({
				"icon/puzzle/",
				arg_17_1,
				".png"
			})
		end
	end,
	getThemeBioIllustration = function(arg_18_0, arg_18_1)
		return var_0_23({
			"pic/theme_bio/",
			arg_18_1,
			".png"
		})
	end,
	getThemeBioVoteRes = function(arg_19_0, arg_19_1)
		return var_0_23({
			"pic/theme_bio/option/",
			arg_19_1,
			".png"
		})
	end,
	getOpenScreenPic = function(self, arg_20_1)
		if require("app.core.lang.MultilingualMgr"):getUseLang() == "cn" and config.PUBLISH_REGION ~= g.core.const.ConstMgr.PlatformConst.REGION.CHINA then
			local var_20_0 = var_0_23({
				"pic/openscreen_en/",
				arg_20_1,
				".png"
			})

			if self:isFileExist(var_20_0) then
				return var_20_0
			end
		end

		return var_0_23({
			"pic/openscreen/",
			arg_20_1,
			".png"
		})
	end,
	getTreasurePicById = function(arg_21_0, arg_21_1)
		return var_0_23({
			"pic/treasure/",
			arg_21_1,
			".png"
		})
	end,
	getPicRes = function(self, arg_22_1, arg_22_2)
		if arg_22_1 == g.core.common.Goods.TYPE_EQUIP then
			return var_0_23({
				"pic/equipment/",
				arg_22_2,
				".png"
			})
		elseif arg_22_1 == g.core.common.Goods.TYPE_TREASURE then
			return var_0_23({
				"pic/treasure/",
				arg_22_2,
				".png"
			})
		elseif arg_22_1 == g.core.common.Goods.TYPE_UNITETOKEN then
			return var_0_23({
				"pic/unitetoken/",
				arg_22_2,
				".png"
			})
		elseif arg_22_1 == g.core.common.Goods.TYPE_ARTIFACT then
			return var_0_23({
				"pic/artifact/",
				arg_22_2,
				".png"
			})
		elseif arg_22_1 == g.core.common.Goods.TYPE_PET_EQUIP then
			return var_0_23({
				"pic/equipment/",
				arg_22_2,
				".png"
			})
		elseif arg_22_1 == g.core.common.Goods.TYPE_PET then
			return var_0_23({
				"icon/pet_fragment_256/",
				arg_22_2,
				".png"
			})
		elseif arg_22_1 == g.core.common.Goods.TYPE_SUCCUBA then
			return self:getSuccubaFragmentIconById(arg_22_2, 256)
		else
			if self:isCensorByResId(arg_22_2) and self:isFileExist(var_0_23({
				"pic/fragment_censor/",
				arg_22_2,
				".png"
			})) then
				return var_0_23({
					"pic/fragment_censor/",
					arg_22_2,
					".png"
				})
			end

			if self:isUseRemoteByResId(arg_22_2) and self:isFileExist(var_0_23({
				"pic/fragment_remote/",
				arg_22_2,
				".png"
			})) then
				return var_0_23({
					"pic/fragment_remote/",
					arg_22_2,
					".png"
				})
			end

			return var_0_23({
				"pic/fragment/",
				arg_22_2,
				".png"
			})
		end
	end,
	getRunePicById = function(arg_23_0, arg_23_1)
		return var_0_23({
			"icon/rune/",
			arg_23_1,
			".png"
		})
	end,
	getGroupPicById = function(arg_24_0, arg_24_1)
		return var_0_23({
			"icon/group/icon_group_",
			arg_24_1,
			".png"
		})
	end,
	getResourceIconById = function(arg_25_0, arg_25_1, arg_25_2)
		return var_0_23({
			"icon/",
			arg_25_2 and "mini_item/" or "item/",
			arg_25_1,
			".png"
		})
	end,
	getItemIconById = function(arg_26_0, arg_26_1, arg_26_2)
		return var_0_23({
			"icon/",
			arg_26_2 and "mini_item/" or "item/",
			arg_26_1,
			".png"
		})
	end,
	getMiddleItemIconById = function(arg_27_0, arg_27_1)
		return var_0_23({
			"icon/item_256p/",
			arg_27_1,
			".png"
		})
	end,
	getKnightFragmentIconById = function(self, arg_28_1)
		if self:isCensorByResId(arg_28_1) and self:isFileExist(var_0_23({
			"icon/fragment_censor/",
			arg_28_1,
			".png"
		})) then
			return var_0_23({
				"icon/fragment_censor/",
				arg_28_1,
				".png"
			})
		end

		if self:isUseRemoteByResId(arg_28_1) and self:isFileExist(var_0_23({
			"icon/fragment_remote/",
			arg_28_1,
			".png"
		})) then
			return var_0_23({
				"icon/fragment_remote/",
				arg_28_1,
				".png"
			})
		end

		return var_0_23({
			"icon/fragment/",
			arg_28_1,
			".png"
		})
	end,
	getKnightIconById = function(self, arg_29_1)
		return self:getRoleHeadIcon(arg_29_1)
	end,
	getKnightQQIconById = function(arg_30_0, arg_30_1)
		return var_0_23({
			"icon/knight_q_avatar/",
			arg_30_1,
			".png"
		})
	end,
	getKnightPicById = function(self, arg_31_1)
		local var_31_0 = g.core.utils.Rule.matchChannelAndLv()

		if var_31_0 and arg_31_1 == 510030 then
			return var_0_23({
				"icon/knight_big/",
				arg_31_1,
				".png"
			})
		end

		if not var_31_0 and self:isCensorByResId(arg_31_1) and self:isFileExist(var_0_23({
			"icon/knight_big_censor/",
			arg_31_1,
			".png"
		})) then
			return var_0_23({
				"icon/knight_big_censor/",
				arg_31_1,
				".png"
			})
		end

		if (var_31_0 or self:isUseRemoteByResId(arg_31_1)) and self:isFileExist(var_0_23({
			"icon/knight_big_remote/",
			arg_31_1,
			".png"
		})) then
			if arg_31_1 == 600020 and var_31_0 then
				arg_31_1 = 510010
			end

			return var_0_23({
				"icon/knight_big_remote/",
				arg_31_1,
				".png"
			})
		end

		return var_0_23({
			"icon/knight_big/",
			arg_31_1,
			".png"
		})
	end,
	getKnightAvatarById = function(self, arg_32_1)
		if self:isCensorByResId(arg_32_1) and self:isFileExist(var_0_23({
			"pic/knightAvatar_censor/",
			arg_32_1,
			".png"
		})) then
			return var_0_23({
				"pic/knightAvatar_censor/",
				arg_32_1,
				".png"
			})
		end

		if self:isUseRemoteByResId(arg_32_1) and self:isFileExist(var_0_23({
			"pic/knightAvatar_remote/",
			arg_32_1,
			".png"
		})) then
			return var_0_23({
				"pic/knightAvatar_remote/",
				arg_32_1,
				".png"
			})
		end

		return var_0_23({
			"pic/knightAvatar/",
			arg_32_1,
			".png"
		})
	end,
	getMiddleKnightPicById = function(self, arg_33_1)
		if self:isCensorByResId(arg_33_1) and self:isFileExist(var_0_23({
			"icon/middleknight_censor/",
			arg_33_1,
			".png"
		})) then
			return var_0_23({
				"icon/middleknight_censor/",
				arg_33_1,
				".png"
			})
		end

		if self:isUseRemoteByResId(arg_33_1) and self:isFileExist(var_0_23({
			"icon/middleknight_remote/",
			arg_33_1,
			".png"
		})) then
			return var_0_23({
				"icon/middleknight_remote/",
				arg_33_1,
				".png"
			})
		end

		return var_0_23({
			"icon/middleknight/",
			arg_33_1,
			".png"
		})
	end,
	getKnightSoulIconBgByQuality = function(arg_34_0, arg_34_1, arg_34_2)
		arg_34_1 = math.clamp(arg_34_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

		if not arg_34_2 then
			return var_0_23({
				"ui://base_new/bg_mx_touxiang_",
				arg_34_1 + 1,
				"_1"
			})
		else
			return var_0_23({
				"ui://base_new/bg_mx_touxiang_",
				arg_34_1 + 1,
				"_2"
			})
		end
	end,
	getKnightPlotId = function(arg_35_0, arg_35_1)
		return var_0_23({
			"icon/plot/",
			arg_35_1,
			".png"
		})
	end,
	getKnightImgById = function(arg_36_0, arg_36_1)
		return var_0_23({
			"pic/knight_painted/",
			arg_36_1,
			".png"
		})
	end,
	getKnightImgJsonById = function(arg_37_0, arg_37_1)
		return var_0_23({
			"pic/knight_painted/",
			arg_37_1,
			".json"
		})
	end,
	getKingdomIconById = function(arg_38_0, arg_38_1)
		return var_0_23({
			"icon/maingrowth/title_",
			arg_38_1,
			".png"
		})
	end,
	getKingdomBeadsIconById = function(arg_39_0, arg_39_1)
		return var_0_23({
			"icon/maingrowth/icon_",
			arg_39_1,
			".png"
		})
	end,
	getTitleIcon = function(arg_40_0, arg_40_1)
		return var_0_23({
			"icon/title/",
			arg_40_1,
			".png"
		})
	end,
	getTitleMidIcon = function(arg_41_0, arg_41_1)
		return var_0_23({
			"icon/title_128/",
			arg_41_1,
			".png"
		})
	end,
	getTitleQualityIcon = function(arg_42_0, arg_42_1)
		arg_42_1 = math.clamp(arg_42_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

		return var_0_23({
			"ui://base_new/bg_xd_pinzhi",
			arg_42_1 + 1,
			"_1"
		})
	end,
	getTitleSmallIcon = function(arg_43_0, arg_43_1)
		return var_0_23({
			"icon/item/",
			arg_43_1,
			".png"
		})
	end,
	getSuccubaIconById = function(arg_44_0, arg_44_1)
		return var_0_23({
			"icon/succuba/",
			arg_44_1,
			".png"
		})
	end,
	getSuccubaFragmentIconById = function(arg_45_0, arg_45_1, arg_45_2)
		return var_0_23({
			"icon/succubaFragment",
			"_",
			arg_45_2,
			"/",
			arg_45_1,
			".png"
		})
	end,
	getStarTrainIcon = function(arg_46_0, arg_46_1, arg_46_2)
		local var_46_0 = g.core.model.User.trainData:getTrainInfoByLevel(arg_46_2)

		if var_46_0.tab_group == 1 then
			return var_0_23({
				"icon/star_train/",
				arg_46_1,
				".png"
			}), var_0_23({
				"icon/star_train/train_txt",
				arg_46_1,
				".png"
			})
		elseif var_46_0.tab_group == 2 then
			return var_0_23({
				"icon/star_train/",
				arg_46_1,
				".png"
			}), var_0_23({
				"icon/star_train/train_tab_txt",
				arg_46_1,
				".png"
			})
		end
	end,
	getKnightLineUpImgByPosition = function(arg_47_0, arg_47_1)
		return arg_47_1 > 0 and arg_47_1 <= 6 and "ui://knight/pic_shangzhen" or "ui://knight/pic_yuanjun"
	end,
	getKnightAdvMatIconById = function(arg_48_0, arg_48_1)
		return var_0_23({
			"icon/advance_material/",
			arg_48_1,
			".png"
		})
	end,
	getSkillIconById = function(arg_49_0, arg_49_1)
		return var_0_23({
			"icon/skill/",
			arg_49_1,
			".png"
		})
	end,
	getUniteTokenSkillById = function(arg_50_0, arg_50_1)
		return var_0_23({
			"pic/unite_token_skill/",
			arg_50_1,
			".png"
		})
	end,
	getUniteTokenSkillMidPicById = function(arg_51_0, arg_51_1)
		return var_0_23({
			"icon/unitetoken_256/",
			arg_51_1,
			".png"
		})
	end,
	getUniteTokenSkillQualityImg = function(arg_52_0, arg_52_1)
		arg_52_1 = math.clamp(arg_52_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

		return var_0_23({
			"ui://base_new/pic_gw_pinzhi",
			arg_52_1 + 1
		})
	end,
	getTreasureIconById = function(arg_53_0, arg_53_1, arg_53_2)
		return arg_53_2 and var_0_23({
			"icon/mini_item/",
			arg_53_1.mini_icon,
			".png"
		}) or var_0_23({
			"icon/treasure/",
			arg_53_1.res_id,
			".png"
		})
	end,
	getTreasureFragmentIconById = function(arg_54_0, arg_54_1)
		return var_0_23({
			"icon/treasure_fragment/",
			arg_54_1,
			".png"
		})
	end,
	getWingFragmentIconById = function(arg_55_0, arg_55_1)
		return var_0_23({
			"icon/item/",
			arg_55_1,
			".png"
		})
	end,
	getDressIconById = function(arg_56_0, arg_56_1)
		return var_0_23({
			"icon/dress/",
			arg_56_1,
			".png"
		})
	end,
	getWushBuffIconById = function(arg_57_0, arg_57_1)
		return var_0_23({
			"icon/buff_icon/",
			arg_57_1,
			".png"
		})
	end,
	getWushCardIconById = function(arg_58_0, arg_58_1)
		return var_0_23({
			"icon/wushTower/",
			arg_58_1,
			".png"
		})
	end,
	getWushTowerMonsterIcon = function(arg_59_0, arg_59_1, arg_59_2)
		if arg_59_2 == 1 then
			return var_0_23({
				"ui://wushTower/icon_srhy_boss",
				arg_59_1
			})
		else
			return var_0_23({
				"ui://wushTower/icon_srhy_boss",
				arg_59_1,
				"_1"
			})
		end
	end,
	getWushTowerCardIcon = function(arg_60_0, arg_60_1)
		if arg_60_1 == 1 then
			return "ui://wushTower/icon_srhy_card"
		else
			return "ui://wushTower/icon_srhy_card_1"
		end
	end,
	getEquipmentIconById = function(arg_61_0, arg_61_1)
		return var_0_23({
			"icon/equipment/",
			arg_61_1,
			".png"
		})
	end,
	getEquipSmallIconByQuality = function(arg_62_0, arg_62_1, arg_62_2)
		return var_0_23({
			"icon/equipposIcon/icon_zhuangbei_",
			arg_62_1,
			"_",
			arg_62_2,
			".png"
		})
	end,
	getTreasureSmallIconByQuality = function(arg_63_0, arg_63_1)
		return var_0_23({
			"ui://lineUp/pic_rhw_",
			(math.min(math.max(arg_63_1, 1), 4))
		})
	end,
	getEquipEntranceQualityBg = function(arg_64_0, arg_64_1)
		return var_0_23({
			"ui://base_new/bg_zhuangbeipz_0",
			(math.min(math.max(arg_64_1, 1), 6))
		})
	end,
	getEmptyTreasurePicIconById = function(arg_65_0, arg_65_1)
		if arg_65_1 then
			return "ui://base_new/bg_zhuangbeidi_02_1"
		else
			return "ui://lineUp/bg_zhuangbeidi_01"
		end
	end,
	getEmptyEquipPicIconByPos = function(arg_66_0, arg_66_1)
		return var_0_23({
			"ui://base_new/",
			({
				"icon_lizhua",
				"icon_shiying",
				"icon_fusheng",
				"icon_zhongjia"
			})[arg_66_1]
		})
	end,
	getFavoIconById = function(arg_67_0, arg_67_1)
		return var_0_23({
			"icon/favorability_item/",
			arg_67_1,
			".png"
		})
	end,
	getFavoMiddleIconById = function(arg_68_0, arg_68_1)
		return var_0_23({
			"icon/favorability_item_256/",
			arg_68_1,
			".png"
		})
	end,
	getEquipMoudleBg = function(arg_69_0)
		return "bg/equip/pic_zb_tanchuangbg.png"
	end,
	getCityBgById = function(arg_70_0, arg_70_1)
		return var_0_23({
			"pic/city_inside/",
			arg_70_1,
			".png"
		})
	end,
	getDressNodePicById = function(arg_71_0, arg_71_1)
		return ({
			"ui://icon/icon_xueliang",
			"ui://icon/icon_gongji",
			"ui://icon/icon_wufang",
			"ui://icon/icon_fafang",
			"ui://icon/icon_yuanman"
		})[arg_71_1]
	end,
	getGuildSignOrFrameById = function(arg_72_0, arg_72_1)
		return var_0_23({
			"icon/guild/",
			arg_72_1,
			".png"
		})
	end,
	getGuildMidIconById = function(arg_73_0, arg_73_1)
		return var_0_23({
			"icon/guild_128/",
			arg_73_1,
			".png"
		})
	end,
	getRedPacketPicByState = function(arg_74_0, arg_74_1)
		return var_0_23({
			"ui://redPacket/pic_hongbao",
			arg_74_1
		})
	end,
	getRedPacketIconById = function(arg_75_0, arg_75_1, arg_75_2)
		return arg_75_2 and var_0_23({
			"icon/mini_item/",
			arg_75_1,
			".png"
		}) or var_0_23({
			"icon/item/",
			arg_75_1,
			".png"
		})
	end,
	getEmojiPath = function(arg_76_0, arg_76_1)
		return var_0_23({
			"icon/emoji/",
			arg_76_1,
			".png"
		})
	end,
	getGuildDungeonSkillIcon = function(arg_77_0, arg_77_1)
		return var_0_23({
			"icon/buff_icon/",
			arg_77_1,
			".png"
		})
	end,
	getGuildDungeonSkillIconBg = function(arg_78_0, arg_78_1)
		return var_0_23({
			"ui://base_new/",
			arg_78_1
		})
	end,
	getRoleHeadFrameIcon = function(arg_79_0, arg_79_1)
		return var_0_23({
			"icon/avatar_frame/",
			arg_79_1,
			".png"
		})
	end,
	getRoleHeadIcon = function(self, arg_80_1)
		if self:isCensorByResId(arg_80_1) and self:isFileExist(var_0_23({
			"icon/avatar_censor/",
			arg_80_1,
			".png"
		})) then
			return var_0_23({
				"icon/avatar_censor/",
				arg_80_1,
				".png"
			})
		end

		if self:isUseRemoteByResId(arg_80_1) and self:isFileExist(var_0_23({
			"icon/avatar_remote/",
			arg_80_1,
			".png"
		})) then
			return var_0_23({
				"icon/avatar_remote/",
				arg_80_1,
				".png"
			})
		end

		return var_0_23({
			"icon/avatar/",
			arg_80_1,
			".png"
		})
	end,
	getChatEmojiIcon = function(arg_81_0, arg_81_1)
		return var_0_23({
			"icon/emoji/",
			arg_81_1,
			".png"
		})
	end,
	getTalkImg = function(arg_82_0, arg_82_1)
		local var_82_0 = {
			nil,
			".png"
		}

		var_82_0[1] = "icon/talk_pic/%s/%s"

		return string.format(var_0_23(var_82_0), arg_82_1, arg_82_1)
	end,
	getEmojiGroupIcon = function(arg_83_0, arg_83_1, arg_83_2)
		return string.format((arg_83_2 or nil) and "icon/talk_pic_256/%s.png", arg_83_1)
	end,
	getMainSceneIcon = function(arg_84_0, arg_84_1)
		return var_0_23({
			"bg/home/",
			arg_84_1,
			".jpg"
		})
	end,
	getGetStaminaIcon = function(arg_85_0, arg_85_1)
		return var_0_23({
			"icon/activity/get_stamina/food_icon/pic_shiwu_",
			arg_85_1,
			".png"
		})
	end,
	getDungeonMainRoute = function(arg_86_0, arg_86_1, arg_86_2)
		return var_0_23({
			"parallax/dungeon_stage/",
			arg_86_1,
			"/",
			arg_86_1,
			"_route_",
			arg_86_2,
			".rcfg"
		})
	end,
	getDungeonMonsterPos = function(arg_87_0, arg_87_1, arg_87_2)
		return var_0_23({
			"parallax/dungeon_stage/",
			arg_87_1,
			"/",
			arg_87_1,
			"_monster_",
			arg_87_2,
			".mcfg"
		})
	end,
	getThemeDungeonMonsterPos = function(arg_88_0, arg_88_1, arg_88_2)
		return var_0_23({
			"parallax/themeDungeon/",
			arg_88_1,
			"/",
			arg_88_1,
			"_monster_",
			arg_88_2,
			".mcfg"
		})
	end,
	getThemeDungeonChapterIcon = function(arg_89_0, arg_89_1)
		return var_0_23({
			"icon/theme/",
			arg_89_1,
			".png"
		})
	end,
	getThemeDungeonChapterTab = function(arg_90_0, arg_90_1)
		return var_0_23({
			"icon/theme/tab/",
			arg_90_1,
			".png"
		})
	end,
	getDungeonCameraRoute = function(arg_91_0, arg_91_1)
		return var_0_23({
			"parallax/dungeon_stage/",
			arg_91_1,
			"/",
			arg_91_1,
			"_camera.scfg"
		})
	end,
	getDungeonArea = function(arg_92_0, arg_92_1)
		return var_0_23({
			"parallax/dungeon_stage/",
			arg_92_1,
			"/",
			arg_92_1,
			"_area.scfg"
		})
	end,
	getGuildDungeonPicById = function(arg_93_0, arg_93_1)
		return var_0_23({
			"pic/guild_dungeon/bg_juntuantuwei_",
			arg_93_1,
			".png"
		})
	end,
	getDungeonLandMapBg = function(arg_94_0, arg_94_1)
		return var_0_23({
			"bg/dungeon/dungeon_landBg_",
			arg_94_1,
			".jpg"
		})
	end,
	getModuleMapFile = function(arg_95_0, arg_95_1, arg_95_2)
		arg_95_2 = arg_95_2 or 1

		return var_0_23({
			"parallax_bg/",
			arg_95_1,
			"/",
			arg_95_2,
			"/",
			arg_95_1,
			".pcfg"
		})
	end,
	getModuleMapFileByTime = function(self, arg_96_1)
		return self:getModuleMapFile(arg_96_1, (g.core.utils.Time.getTimeIndex()))
	end,
	getGuildBgByTime = function(arg_97_0)
		if g.core.utils.Time.getTimeIndex() == 1 then
			return "biomap/99999"
		else
			return "biomap/99998"
		end
	end,
	getBioEventPic = function(arg_98_0, arg_98_1)
		return var_0_23({
			"pic/biography/",
			arg_98_1,
			".png"
		})
	end,
	getBioEventIcon = function(arg_99_0, arg_99_1)
		return var_0_23({
			"icon/biography/",
			arg_99_1,
			".png"
		})
	end,
	getBioDarkItemIcon = function(arg_100_0, arg_100_1)
		return var_0_23({
			"icon/theme/bio/",
			arg_100_1,
			"_dark.png"
		})
	end,
	getRechargeIconById = function(arg_101_0, arg_101_1)
		return var_0_23({
			"icon/recharge/",
			arg_101_1,
			".png"
		})
	end,
	getRecruitIconById = function(arg_102_0, arg_102_1)
		return var_0_23({
			"icon/recruit/",
			arg_102_1,
			".png"
		})
	end,
	getRecruitShowArtifactIconById = function(arg_103_0, arg_103_1)
		return var_0_23({
			"icon/recruitShowIcon/artifact/",
			arg_103_1,
			".png"
		})
	end,
	getRecruitShowKnightIconById = function(self, arg_104_1)
		local var_104_0 = var_0_23({
			"icon/recruitShowIcon/knight_remote/",
			arg_104_1,
			".png"
		})

		if self:isUseRemoteByResId(arg_104_1) and self:isFileExist(var_104_0) then
			return var_104_0
		end

		return (var_0_23({
			"icon/recruitShowIcon/knight/",
			arg_104_1,
			".png"
		}))
	end,
	getRecruitShowSuccubaIconById = function(arg_105_0, arg_105_1)
		return var_0_23({
			"icon/recruitShowIcon/succuba/",
			arg_105_1,
			".png"
		})
	end,
	getPrimaryLimitShowKnightIconById = function(arg_106_0, arg_106_1)
		return var_0_23({
			"icon/recruitShowIcon/primaryLimit/pic_zm_xs_",
			arg_106_1,
			".png"
		})
	end,
	getRecruitShowKnightSoulIconById = function(arg_107_0, arg_107_1)
		return var_0_23({
			"icon/recruitShowIcon/knightSoul/",
			arg_107_1,
			".png"
		})
	end,
	getRecruitShowPetIconById = function(arg_108_0, arg_108_1)
		return var_0_23({
			"icon/recruitShowIcon/pet/",
			arg_108_1,
			".png"
		})
	end,
	getDungeonAchieveTxt = function(arg_109_0, arg_109_1)
		return var_0_23({
			"pic/dungeon_achievement/",
			arg_109_1
		})
	end,
	getStatePartRes = function(arg_110_0, arg_110_1, arg_110_2)
		return var_0_23({
			"pic/guild/",
			arg_110_1,
			"_",
			arg_110_2,
			".png"
		})
	end,
	getSceneStatuePartRes = function(arg_111_0, arg_111_1, arg_111_2)
		return var_0_23({
			"pic/guild/cj_",
			arg_111_1,
			"_",
			arg_111_2,
			".png"
		})
	end,
	getStatueRes = function(arg_112_0, arg_112_1)
		return var_0_23({
			"pic/guild/",
			arg_112_1,
			".png"
		})
	end,
	getCustomActivityArtTxt = function(arg_113_0, arg_113_1)
		return var_0_23({
			"pic/selling/",
			arg_113_1,
			".png"
		})
	end
}

function var_0_24:getIconByTypeValue(arg_114_1, arg_114_2, arg_114_3, arg_114_4)
	local var_114_0

	if arg_114_1 == g.core.common.Goods.TYPE_GOLD then
		arg_114_1 = g.core.common.Goods.TYPE_RESOURCE
		arg_114_2 = arg_114_2 == 0 and g.core.common.Goods.RESOURCE.TYPE_FREE_GOLD or arg_114_2 == 1 and g.core.common.Goods.RESOURCE.TYPE_GOLD or arg_114_2 or g.core.common.Goods.RESOURCE.TYPE_FREE_GOLD
	end

	if arg_114_1 == g.core.common.Goods.TYPE_RESOURCE then
		var_114_0 = var_0_24:getResourceIconById(var_0_0.get(arg_114_2).icon, arg_114_3)
	elseif arg_114_1 == g.core.common.Goods.TYPE_FRAGMENT then
		local var_114_1 = var_0_4.get(arg_114_2)

		if var_114_1.fragment_type == g.core.common.Goods.FRAGMENT.TYPE_KNIGHT then
			var_114_0 = var_0_24:getIconByTypeValue(g.core.common.Goods.TYPE_KNIGHT, var_114_1.fragment_value, false, true)
		elseif var_114_1.fragment_type == g.core.common.Goods.FRAGMENT.TYPE_UNITETOKEN then
			var_114_0 = var_0_24:getIconByTypeValue(g.core.common.Goods.TYPE_UNITETOKEN, var_114_1.fragment_value)
		elseif var_114_1.fragment_type == g.core.common.Goods.FRAGMENT.TYPE_EQUIP then
			var_114_0 = var_0_24:getIconByTypeValue(g.core.common.Goods.TYPE_EQUIP, var_114_1.fragment_value)
		elseif var_114_1.fragment_type == g.core.common.Goods.FRAGMENT.TYPE_TREASURE then
			var_114_0 = var_0_24:getTreasureFragmentIconById(var_114_1.res_id)
		elseif var_114_1.fragment_type == g.core.common.Goods.FRAGMENT.TYPE_ARTIFACT then
			var_114_0 = arg_114_3 and var_0_24:getArtifactMiniIconByTypeValue(g.core.common.Goods.TYPE_ARTIFACT, var_114_1.fragment_value) or var_0_24:getIconByTypeValue(g.core.common.Goods.TYPE_ARTIFACT, var_114_1.fragment_value)
		elseif var_114_1.fragment_type == g.core.common.Goods.FRAGMENT.TYPE_PET then
			var_114_0 = var_0_24:getIconByTypeValue(g.core.common.Goods.TYPE_PET, var_114_1.fragment_value, false, true)
		elseif var_114_1.fragment_type == g.core.common.Goods.FRAGMENT.TYPE_WING then
			var_114_0 = var_0_24:getWingFragmentIconById(var_114_1.res_id)
		elseif var_114_1.fragment_type == g.core.common.Goods.FRAGMENT.TYPE_PRECIOUS then
			var_114_0 = var_0_24:getPreciousSmallIconByResId(var_114_1.res_id)
		elseif var_114_1.fragment_type == g.core.common.Goods.TYPE_SUCCUBA then
			var_114_0 = var_0_24:getSuccubaFragmentIconById(var_114_1.res_id, (arg_114_3 or nil) and 36)
		end
	elseif arg_114_1 == g.core.common.Goods.TYPE_ITEM then
		var_114_0 = var_0_24:getItemIconById(var_0_2.get(arg_114_2).icon, arg_114_3)
	elseif arg_114_1 == g.core.common.Goods.TYPE_EXPIRABLE_ITEM then
		var_114_0 = var_0_24:getItemIconById(g.core.config.expirable_item_info.get(arg_114_2).icon, arg_114_3)
	elseif arg_114_1 == g.core.common.Goods.TYPE_KNIGHT then
		local var_114_3 = var_0_1.get(arg_114_2)
		local var_114_4 = var_0_5.get(var_114_3.res_id)
		local var_114_5

		if var_114_3 and var_114_4 then
			var_114_5 = var_114_4.icon_id or 0

			if arg_114_4 then
				var_114_0 = var_0_24:getKnightFragmentIconById(var_114_5)

				goto label_114_0
			end
		end

		var_114_0 = var_0_24:getKnightIconById(var_114_5)
	elseif arg_114_1 == g.core.common.Goods.TYPE_UNITETOKEN then
		var_114_0 = var_0_24:getUniteTokenIconById(var_0_3.get(arg_114_2).res_id)
	elseif arg_114_1 == g.core.common.Goods.TYPE_KNIGHT_ADVANCE then
		var_114_0 = var_0_24:getKnightAdvMatIconById(var_0_6.get(arg_114_2).icon)
	elseif arg_114_1 == g.core.common.Goods.TYPE_EQUIP then
		var_114_0 = var_0_24:getEquipmentIconById(var_0_8.get(arg_114_2).res_id)
	elseif arg_114_1 == g.core.common.Goods.TYPE_TREASURE then
		var_114_0 = var_0_24:getTreasureIconById(var_0_7.get(arg_114_2), arg_114_3)
	elseif arg_114_1 == g.core.common.Goods.TYPE_REDPACKET then
		var_114_0 = var_0_24:getRedPacketIconById(var_0_10.get(arg_114_2).icon, arg_114_3)
	elseif arg_114_1 == g.core.common.Goods.TYPE_DRESS then
		var_114_0 = var_0_24:getDressIconById(var_0_9.get(arg_114_2).dress_icon)
	elseif arg_114_1 == g.core.common.Goods.TYPE_TITLE then
		var_114_0 = var_0_24:getItemIconById(g.core.config.title_info.get(arg_114_2).item_icon)
	elseif arg_114_1 == g.core.common.Goods.TYPE_BIO then
		var_114_0 = var_0_24:getItemIconById(g.core.config.biography_item_info.get(arg_114_2).icon, arg_114_3)
	elseif arg_114_1 == g.core.common.Goods.TYPE_ARTIFACT then
		var_114_0 = var_0_24:getArtifactIconById(g.core.config.artifact_info.get(arg_114_2).res_id, arg_114_3)
	elseif arg_114_1 == g.core.common.Goods.TYPE_SKIN then
		var_114_0 = var_0_24:getKnightIconById(g.core.config.skin_info.get(arg_114_2).icon)
	elseif arg_114_1 == g.core.common.Goods.TYPE_INCARNATIIN then
		local var_114_6 = g.core.config.knight_info.get(g.core.config.transformation_card_info.get(arg_114_2).advance_id)
		local var_114_7 = var_0_5.get(var_114_6.res_id)

		var_114_0 = var_0_24:getKnightIconById((var_114_6 and var_114_7 or nil) and (var_114_7.icon_id or 0))
	elseif arg_114_1 == g.core.common.Goods.TYPE_WING then
		var_114_0 = var_0_24:getWingIconByResId(g.core.config.wing_info.get(arg_114_2).icon_res)
	elseif arg_114_1 == g.core.common.Goods.TYPE_PET then
		local var_114_8 = g.core.config.pet_info.get(arg_114_2)

		var_114_0 = arg_114_4 and self:getPetFragment(var_114_8.resource) or var_0_24:getPetIcon(var_114_8.resource)
	elseif arg_114_1 == g.core.common.Goods.TYPE_PET_EQUIP then
		var_114_0 = var_0_24:getPetEquipmentIcon(var_0_11.get(arg_114_2).res_id)
	elseif arg_114_1 == g.core.common.Goods.TYPE_KNIGHT_FAVORABILITY_ITEM then
		var_114_0 = var_0_24:getFavoIconById(var_0_12.get(arg_114_2).icon)
	elseif arg_114_1 == g.core.common.Goods.TYPE_FUNCTION_NUM then
		var_114_0 = var_0_24:getResourceIconById(var_0_13.get(arg_114_2).icon, true)
	elseif arg_114_1 == g.core.common.Goods.TYPE_FURNITURE then
		var_114_0 = var_0_24:getFurnitureIconByResId(var_0_14.get(arg_114_2).icon)
	elseif arg_114_1 == g.core.common.Goods.TYPE_AVATAR then
		var_114_0 = var_0_24:getRoleHeadIcon(var_0_15.get(arg_114_2).res)
	elseif arg_114_1 == g.core.common.Goods.TYPE_AVATAR_FRAME then
		var_114_0 = var_0_24:getRoleHeadFrameIcon(var_0_16.get(arg_114_2).res)
	elseif arg_114_1 == g.core.common.Goods.TYPE_SCENE_SKIN then
		var_114_0 = var_0_24:getSceneSkinIcon(var_0_17.get(arg_114_2).item_icon)
	elseif arg_114_1 == g.core.common.Goods.TYPE_FACE_GROUP then
		var_114_0 = var_0_24:getEmojiGroupIcon(var_0_18.get(arg_114_2).icon)
	elseif arg_114_1 == g.core.common.Goods.TYPE_HALIDOM then
		var_114_0 = var_0_24:getHalidom128ById(var_0_19.get(arg_114_2).icon)
	elseif arg_114_1 == g.core.common.Goods.TYPE_THEME_BIO_ITEM then
		var_114_0 = var_0_24:getItemIconById(g.core.config.theme_biography_item_info.get(arg_114_2).icon)
	elseif arg_114_1 == g.core.common.Goods.TYPE_PRECIOUS then
		var_114_0 = var_0_24:getPreciousSmallIconByResId(g.core.config.precious_info.get(arg_114_2).res_id)
	elseif arg_114_1 == g.core.common.Goods.TYPE_ROLE_SKIN then
		var_114_0 = var_0_24:getRoleSkinIcon(g.core.config.role_skin_info.get(arg_114_2).icon)
	elseif arg_114_1 == g.core.common.Goods.TYPE_SUCCUBA then
		local var_114_9 = g.core.config.succuba_show_info.get(g.core.config.succuba_info.get(arg_114_2).advance_id)

		if not var_114_9 then
			return ""
		end

		return var_0_24:getSuccubaIconById(var_114_9.res)
	elseif arg_114_1 == g.core.common.Goods.TYPE_OUTPOST_ITEM then
		return var_0_24:getOutpostItemIcon(g.core.config.outpost_item_info.get(arg_114_2).icon, arg_114_3)
	end

	::label_114_0::

	return var_114_0
end

function var_0_24.getArtifactMiniIconByTypeValue(arg_115_0, arg_115_1, arg_115_2)
	return var_0_23({
		"icon/artifactMini/",
		g.core.config.artifact_info.get(arg_115_2).res_id,
		".png"
	})
end

function var_0_24.getIconEffByTypeValue(arg_116_0, arg_116_1, arg_116_2)
	local var_116_0

	if arg_116_1 == g.core.common.Goods.TYPE_ITEM then
		local var_116_1 = var_0_2.get(arg_116_2)

		if var_116_1.item_type == 26 then
			local var_116_2 = var_0_16.get(var_116_1.item_value)

			if var_116_2.resEffect ~= "0" then
				var_116_0 = {
					anim = "play",
					isLoop = true,
					name = var_116_2.resEffect
				}
			end
		end
	end

	return var_116_0
end

function var_0_24.getSevenDaysEventPic(arg_117_0, arg_117_1)
	return var_0_23({
		"pic/sevendays/",
		arg_117_1,
		".png"
	})
end

function var_0_24.getSevenDaysIcon(arg_118_0, arg_118_1)
	return var_0_23({
		"icon/sevendays/",
		arg_118_1,
		".png"
	})
end

function var_0_24.getCustomActivityIcon(arg_119_0, arg_119_1)
	return var_0_23({
		"icon/activity/activity_icon/",
		arg_119_1,
		".png"
	})
end

function var_0_24.getCustomActivityPic(arg_120_0, arg_120_1)
	return var_0_23({
		"pic/activity/",
		arg_120_1,
		".png"
	})
end

function var_0_24.getKnightName(arg_121_0, arg_121_1)
	return var_0_23({
		"text/knight_name/",
		arg_121_1,
		".png"
	})
end

function var_0_24.getVoice(arg_122_0, arg_122_1)
	return var_0_23({
		"voice/",
		arg_122_1,
		".mp3"
	})
end

function var_0_24.getRechargeGuideIcon(arg_123_0, arg_123_1)
	return var_0_23({
		"icon/recharge_guide/",
		arg_123_1,
		".png"
	})
end

function var_0_24.getStormMainBgCfg(arg_124_0, arg_124_1)
	return var_0_23({
		"storm_map/",
		arg_124_1,
		"/",
		arg_124_1,
		".json"
	})
end

function var_0_24.getStormMainBasePath(arg_125_0)
	return "maps/storm/"
end

function var_0_24.getStormPicFolder(arg_126_0)
	return "pic/storm_city/"
end

function var_0_24.getStormPic(arg_127_0, arg_127_1)
	return var_0_23({
		"pic/storm/bg_xinyangjiefang_",
		arg_127_1,
		".png"
	})
end

function var_0_24.getGridMapCfg(arg_128_0, arg_128_1)
	return var_0_23({
		"grid_map/",
		arg_128_1,
		"/",
		arg_128_1,
		".json"
	})
end

function var_0_24.getStormEventPic(arg_129_0, arg_129_1)
	return var_0_23({
		"pic/storm_event/",
		arg_129_1,
		".png"
	})
end

function var_0_24.getStormGridPic(arg_130_0, arg_130_1)
	local var_130_0 = var_0_23({
		"ui://gridPic/",
		(string.match(arg_130_1, "^[^%.]*"))
	})

	if fgui.UIPackage:getItemByURL(var_130_0) then
		return var_130_0
	else
		return var_0_23({
			"pic/grid_map/",
			arg_130_1
		})
	end
end

function var_0_24.getOfficialIcon(arg_131_0, arg_131_1)
	return var_0_23({
		"icon/city_lord/",
		arg_131_1,
		".png"
	})
end

function var_0_24.getGlyphIcon(arg_132_0, arg_132_1)
	return var_0_23({
		"ui://base_new/",
		arg_132_1
	})
end

function var_0_24.getStormCityTabIcon(arg_133_0, arg_133_1)
	return var_0_23({
		"icon/storm_city/",
		arg_133_1,
		"_on.png"
	}), var_0_23({
		"icon/storm_city/",
		arg_133_1,
		"_off.png"
	})
end

function var_0_24.getArtifactIconById(arg_134_0, arg_134_1)
	return var_0_23({
		"icon/artifact/",
		arg_134_1,
		".png"
	})
end

function var_0_24.getArtifactBagPic(arg_135_0, arg_135_1)
	return var_0_23({
		"pic/artifact/bag_",
		arg_135_1,
		".png"
	})
end

function var_0_24.getArtifactPic(arg_136_0, arg_136_1)
	return var_0_23({
		"pic/artifact/",
		arg_136_1,
		".png"
	})
end

function var_0_24.getArtifactBattlePic(arg_137_0, arg_137_1)
	return var_0_23({
		"pic/artifact_battle/",
		arg_137_1,
		".png"
	})
end

function var_0_24.getArtifactSkillIcon(arg_138_0, arg_138_1)
	return var_0_23({
		"icon/artifact_skill/",
		arg_138_1,
		".png"
	})
end

function var_0_24.getArtifactSkillName(arg_139_0, arg_139_1)
	return var_0_23({
		"text/artifact_skill/",
		arg_139_1,
		".png"
	})
end

function var_0_24.getArtifactEquipPic(arg_140_0, arg_140_1)
	return var_0_23({
		"icon/artifact_equiped/",
		arg_140_1,
		".png"
	})
end

function var_0_24.getPendantIcon(arg_141_0, arg_141_1)
	return var_0_23({
		"icon/knight_awake/pendant_",
		arg_141_1,
		".png"
	})
end

function var_0_24.getCityBuildingPic(arg_142_0, arg_142_1)
	return var_0_23({
		"pic/mine_icon/pic_qsmy_dian",
		arg_142_1,
		".png"
	})
end

function var_0_24.getWrestCityBuildingPic(arg_143_0, arg_143_1)
	return var_0_23({
		"pic/wrest_icon/",
		arg_143_1,
		".png"
	})
end

function var_0_24.getCityTreasurePic(arg_144_0, arg_144_1)
	return var_0_23({
		"pic/mine_icon/mini_",
		arg_144_1,
		".png"
	})
end

function var_0_24.getWrestCityTreasurePic(arg_145_0, arg_145_1)
	return var_0_23({
		"pic/mine_icon/",
		arg_145_1,
		".png"
	})
end

function var_0_24.getMineStateIcon(arg_146_0, arg_146_1)
	return var_0_23({
		"pic/mine_icon/event_",
		arg_146_1,
		".png"
	})
end

function var_0_24.getMineCityBgPic(arg_147_0, arg_147_1)
	return var_0_23({
		"pic/mine_icon/bg_",
		arg_147_1,
		".png"
	})
end

function var_0_24.getWrestCityBgPic(arg_148_0, arg_148_1)
	return var_0_23({
		"pic/mine_icon/",
		arg_148_1,
		".png"
	})
end

function var_0_24.getRedPacketRainRes(arg_149_0, arg_149_1)
	return var_0_23({
		"pic/redpacket_rain/",
		arg_149_1,
		".png"
	})
end

function var_0_24.getFunctionIcon(arg_150_0, arg_150_1)
	return g.core.config.function_info.get(arg_150_1).icon
end

function var_0_24.getScrollStoryRes(arg_151_0, arg_151_1)
	return var_0_23({
		"pic/scroll_play/",
		arg_151_1,
		".png"
	})
end

function var_0_24.getHolidayTitleBg(arg_152_0, arg_152_1)
	return var_0_23({
		"pic/holiday/",
		arg_152_1,
		".png"
	})
end

function var_0_24:getWarriorsWindRes(arg_153_1)
	if self:isFileExist(var_0_23({
		"pic/story_pic_remote/",
		arg_153_1,
		".jpg"
	})) then
		return var_0_23({
			"pic/story_pic_remote/",
			arg_153_1,
			".jpg"
		})
	end

	return var_0_23({
		"pic/story_pic/",
		arg_153_1,
		".jpg"
	})
end

function var_0_24.getWarriorsMainPageRes(arg_154_0, arg_154_1)
	return var_0_23({
		"bg/story/",
		arg_154_1,
		".jpg"
	})
end

function var_0_24.getWingIconByResId(arg_155_0, arg_155_1)
	return var_0_23({
		"icon/wing/",
		arg_155_1,
		".png"
	})
end

function var_0_24.getMysteryChapterPic(arg_156_0, arg_156_1)
	return var_0_23({
		"pic/mystery/",
		arg_156_1,
		".png"
	})
end

function var_0_24.getMysteryBossIcon(arg_157_0, arg_157_1)
	return var_0_23({
		"pic/mystery_boss_icon/",
		arg_157_1,
		".png"
	})
end

function var_0_24.getMysteryBossAwardEffect(arg_158_0, arg_158_1)
	local var_158_0 = {
		"effect_award_light_green",
		"effect_award_light_blue",
		"effect_award_light_purple",
		"effect_award_light_orange",
		"effect_award_light_red",
		"effect_award_light_gold"
	}

	arg_158_1 = arg_158_1 or 2
	arg_158_1 = math.max(2, math.min(2 + #var_158_0 - 1, arg_158_1))

	return var_158_0[arg_158_1 - 2 + 1]
end

function var_0_24.getMysteryBossParallaxBg(arg_159_0, arg_159_1)
	return var_0_23({
		"parallax_bg/mjsszcboss/",
		arg_159_1,
		"/mjsszcboss.pcfg"
	})
end

function var_0_24.getNightMareMpaCfg(arg_160_0, arg_160_1, arg_160_2)
	return var_0_23({
		"space_map/",
		arg_160_2,
		"/",
		arg_160_1,
		".json"
	})
end

function var_0_24.getNightMareBorderRes(arg_161_0, arg_161_1)
	return var_0_23({
		"pic/spacetime_dungeon/landbg/",
		arg_161_1
	})
end

function var_0_24.getNightMareItemPicRes(arg_162_0, arg_162_1)
	return var_0_23({
		"pic/spacetime_dungeon/obstacle/",
		arg_162_1
	})
end

function var_0_24.getNightMareIconRes(arg_163_0, arg_163_1)
	return var_0_23({
		"icon/item/",
		arg_163_1
	})
end

function var_0_24.getKnightTissuePic(arg_164_0, arg_164_1)
	return var_0_23({
		"pic/knightTissue/tissuePic/",
		arg_164_1,
		".png"
	})
end

function var_0_24.getArtifactTissuePic(arg_165_0, arg_165_1)
	return var_0_23({
		"pic/knightTissue/ArtifactPic/",
		arg_165_1,
		".png"
	})
end

function var_0_24.getGoldRecruitShowPic(arg_166_0, arg_166_1)
	return var_0_23({
		"pic/goldrecruit/",
		arg_166_1,
		".png"
	})
end

function var_0_24.getRobTreasureNum(arg_167_0, arg_167_1)
	return var_0_23({
		"ui://text_new/pic_ts_",
		arg_167_1
	})
end

function var_0_24.getGoldRecruitShowTitlePic(arg_168_0, arg_168_1)
	return var_0_23({
		"pic/goldrecruit_title/",
		arg_168_1,
		".png"
	})
end

function var_0_24.getTeamPvpTitle(arg_169_0, arg_169_1)
	return var_0_23({
		"icon/group_battle_title/",
		arg_169_1,
		".png"
	})
end

function var_0_24.getGodBoxTitleNum(arg_170_0, arg_170_1)
	return var_0_23({
		"pic/godbox/title_mffl_",
		arg_170_1,
		".png"
	})
end

function var_0_24.getWeekGiftPictureId(arg_171_0, arg_171_1)
	return var_0_23({
		"icon/item/",
		arg_171_1,
		".png"
	})
end

function var_0_24.getKnightSoulChapterPic(arg_172_0, arg_172_1)
	return var_0_23({
		"pic/ksoulChapter/pic_mingxing_tj_",
		arg_172_1,
		".png"
	})
end

function var_0_24:getKnightSoulBookPic(arg_173_1, arg_173_2)
	if arg_173_2 == g.core.common.Goods.TYPE_KNIGHT then
		return self:getRoleHeadIcon(arg_173_1)
	elseif self._info.type == g.core.common.Goods.TYPE_ARTIFACT then
		return self:getArtifactIconById(arg_173_1)
	end
end

function var_0_24.getKnightSoulCardIcon(arg_174_0, arg_174_1)
	arg_174_1 = math.clamp(arg_174_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

	return var_0_23({
		"ui://knightSoul/icon_mx_mxp_zuhe_jihuo_",
		arg_174_1 + 1
	})
end

function var_0_24.getKnightSoulCardBgAndFg(arg_175_0, arg_175_1)
	arg_175_1 = math.clamp(arg_175_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

	return string.format("pic/ksoulQuality/bg_mx_card_%d_1.png", arg_175_1 + 1), (string.format("pic/ksoulQuality/bg_mx_card_%d_2.png", arg_175_1 + 1))
end

function var_0_24.getKnightSoulBookCellBg(arg_176_0, arg_176_1)
	arg_176_1 = math.clamp(arg_176_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

	return "ui://knightSoul/pic_mx_mxp_zuhe_bg_" .. arg_176_1 + 1
end

function var_0_24.getKnightSoulCardGroupIcon(arg_177_0, arg_177_1, arg_177_2)
	arg_177_1 = arg_177_1 + 1

	return string.format("icon/knight_soul_icon/icon_mx_%d_%d.png", arg_177_1, arg_177_2)
end

function var_0_24.getYouthDayStorePic(arg_178_0, arg_178_1)
	return var_0_23({
		"pic/young_txt/",
		arg_178_1,
		".png"
	})
end

function var_0_24.getYouthDayMainTitlePic(arg_179_0, arg_179_1)
	return var_0_23({
		"pic/young_txt/",
		arg_179_1,
		".png"
	})
end

function var_0_24.getHotImg(arg_180_0, arg_180_1)
	return var_0_23({
		"pic/activity_hot_image/",
		arg_180_1,
		".png"
	})
end

function var_0_24.getCriMoviePath(arg_181_0, arg_181_1, arg_181_2)
	if arg_181_2 then
		return var_0_23({
			"movie/",
			arg_181_2,
			"/",
			arg_181_1,
			".usm"
		})
	else
		return var_0_23({
			"movie/",
			arg_181_1,
			".usm"
		})
	end
end

function var_0_24.getBioBasePath(arg_182_0)
	return "maps/bio/"
end

function var_0_24.getEditorHexTest(arg_183_0)
	return "maps/editor_hexTest/"
end

function var_0_24.getRiskBasePath(arg_184_0)
	return "maps/risk/"
end

function var_0_24.getMapImagePath(arg_185_0, arg_185_1)
	return var_0_23({
		"pic/",
		arg_185_1,
		"/"
	})
end

function var_0_24.getMapImageDescPath(arg_186_0, arg_186_1)
	return var_0_23({
		"maps/",
		arg_186_1,
		"/tex/pic_desc.json"
	})
end

function var_0_24.getMapEffectPath(arg_187_0)
	return "effect_spine/"
end

function var_0_24.getMapKnightPath(arg_188_0)
	return "battle/knight_spine/"
end

function var_0_24.getExploreBasePath(arg_189_0)
	return "maps/explore/"
end

function var_0_24.getRedCliffBasePath(arg_190_0)
	return "maps/redCliff/"
end

function var_0_24.getHomeIconPath(arg_191_0, arg_191_1)
	return var_0_23({
		"icon/function/",
		arg_191_1,
		".png"
	})
end

function var_0_24.getHomeExpandIconPath(arg_192_0, arg_192_1)
	return var_0_23({
		"pic/homeExpand/",
		arg_192_1,
		".png"
	})
end

function var_0_24.getHomeCultivationIconPath(arg_193_0, arg_193_1)
	return var_0_23({
		"pic/homeCultivation/",
		arg_193_1,
		".png"
	})
end

function var_0_24.getBaseBuyPopItemBg(arg_194_0, arg_194_1)
	arg_194_1 = math.clamp(arg_194_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

	return var_0_23({
		"pic/base_new/quality/bg_itemsdiwen_",
		arg_194_1 + 1,
		".png"
	})
end

function var_0_24.getBaseBuyPopNameBg(arg_195_0, arg_195_1)
	arg_195_1 = math.clamp(arg_195_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

	return var_0_23({
		"ui://base_new/bg_itemsname_",
		arg_195_1 + 1
	})
end

function var_0_24.getBaseIconQualityBg(arg_196_0, arg_196_1)
	arg_196_1 = math.clamp(arg_196_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

	return var_0_23({
		"ui://base_new/pic_bg_touxiangpinzhi_",
		arg_196_1 + 1
	})
end

function var_0_24.getBaseItemIconQualityBg(arg_197_0, arg_197_1)
	arg_197_1 = math.clamp(arg_197_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

	return var_0_23({
		"ui://base_new/pic_bg_pinzhi_",
		arg_197_1 + 1
	})
end

function var_0_24.getBaseBagItemQualityBg(arg_198_0, arg_198_1)
	arg_198_1 = math.clamp(arg_198_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

	return var_0_23({
		"ui://base_new/pic_bag_pinzhi_",
		arg_198_1 + 1
	})
end

function var_0_24.getEquipIconQualityBlackBg(arg_199_0, arg_199_1)
	arg_199_1 = math.clamp(arg_199_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

	return var_0_23({
		"ui://base_new/pic_bg_bwpz_",
		arg_199_1 + 1
	})
end

function var_0_24.getEquipIconQualityDiamondBg(arg_200_0, arg_200_1)
	arg_200_1 = math.clamp(arg_200_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

	return var_0_23({
		"pic/base_new/quality/pic_bg_zbpz_",
		arg_200_1 + 1,
		".png"
	})
end

function var_0_24.getGuildDungeonAwardIconBg(arg_201_0, arg_201_1)
	if arg_201_1 then
		arg_201_1 = math.clamp(arg_201_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

		return var_0_23({
			"ui://guildDungeon/pic_wupindi_",
			arg_201_1 + 1
		})
	else
		return "ui://guildDungeon/pic_wupindi"
	end
end

function var_0_24.getEquipIconQualityBg1(arg_202_0, arg_202_1)
	arg_202_1 = math.clamp(arg_202_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

	return var_0_23({
		"pic/base_new/quality/bg_xd_pinzhizs_",
		arg_202_1 + 1,
		".png"
	}), (var_0_23({
		"ui://base_new/bg_xd_pinzhi_",
		arg_202_1 + 1
	}))
end

function var_0_24.getLineUpIconQualityBg(arg_203_0, arg_203_1)
	arg_203_1 = math.clamp(arg_203_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

	return var_0_23({
		"pic/base_new/bg_xd_pinzhizs_",
		arg_203_1 + 1,
		".png"
	}), (var_0_23({
		"ui://base_new/bg_xd_pinzhi_",
		arg_203_1 + 1
	}))
end

function var_0_24.getIconQualityZS(arg_204_0, arg_204_1)
	return var_0_23({
		"pic/base_new/quality/bg_xd_pinzhizs_",
		arg_204_1,
		".png"
	})
end

function var_0_24.getLineUpQualityBg(arg_205_0, arg_205_1)
	arg_205_1 = math.clamp(arg_205_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

	return var_0_23({
		"ui://base_new/bg_xd_pinzhi",
		arg_205_1 + 1,
		"_1"
	}), var_0_23({
		"ui://base_new/bg_xd_pinzhi",
		arg_205_1 + 1,
		"_3"
	}), (var_0_23({
		"ui://base_new/bg_xd_pinzhi",
		arg_205_1 + 1,
		"_2"
	}))
end

function var_0_24.getUserIconQualityNewBg(arg_206_0, arg_206_1)
	arg_206_1 = math.clamp(arg_206_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

	return var_0_23({
		"ui://base_new/pic_bg_touxiangpinzhi_",
		arg_206_1 + 1
	})
end

function var_0_24.getUserIconQualityStarBg(arg_207_0, arg_207_1)
	arg_207_1 = math.clamp(arg_207_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

	return var_0_23({
		"ui://base_new/pic_js_pinzhi_",
		arg_207_1 + 1
	})
end

function var_0_24.getWitchQualityStarBg(arg_208_0, arg_208_1)
	arg_208_1 = math.clamp(arg_208_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

	return var_0_23({
		"ui://base_new/pic_mnzj_shoppinzhi",
		arg_208_1 + 1
	})
end

function var_0_24.getSummerShopItemQualityCellBg(arg_209_0, arg_209_1)
	return var_0_23({
		"ui://shop/bg_summershop_",
		arg_209_1
	})
end

function var_0_24.getNewYearShopItemQualityCellBg(arg_210_0, arg_210_1)
	return var_0_23({
		"ui://shop/bg_newyear_shop_",
		arg_210_1
	})
end

function var_0_24.getAkiraShopItemQualityCellBg(arg_211_0, arg_211_1)
	return var_0_23({
		"ui://shop/bg_akira_shop_",
		arg_211_1
	})
end

function var_0_24.getTenmaShopItemQualityCellBg(arg_212_0, arg_212_1)
	return var_0_23({
		"ui://shop/bg_tm_shop_",
		arg_212_1
	})
end

function var_0_24.getOverlordShopItemQualityCellBg(arg_213_0, arg_213_1)
	return var_0_23({
		"ui://shop/bg_overlord_shop_",
		arg_213_1
	})
end

function var_0_24.getLindellShopItemQualityCellBg(arg_214_0, arg_214_1)
	return var_0_23({
		"ui://shop/bg_lwch_shop_",
		arg_214_1
	})
end

function var_0_24.getRhainaShopItemQualityCellBg(arg_215_0, arg_215_1)
	return var_0_23({
		"ui://shop/bg_rhaina_shop_",
		arg_215_1
	})
end

function var_0_24.getLilithShopItemQualityCellBg(arg_216_0, arg_216_1)
	return var_0_23({
		"ui://shop/bg_hqwdyx_shop_",
		arg_216_1
	})
end

function var_0_24.getAnubisShopItemQualityCellBg(arg_217_0, arg_217_1)
	return var_0_23({
		"ui://shop/bg_shop_",
		arg_217_1
	})
end

function var_0_24.getAnubisShopItemRepoBg(arg_218_0, arg_218_1)
	return var_0_23({
		"ui://shop/bg_shop_kucun",
		arg_218_1
	})
end

function var_0_24.getDiessShopItemQualityCellBg(arg_219_0, arg_219_1)
	return var_0_23({
		"ui://shop/bg_holiday_shop_",
		arg_219_1
	})
end

function var_0_24.getMeteorShopItemQualityCellBg(arg_220_0, arg_220_1)
	return var_0_23({
		"ui://shop/bg_meteor_shop_",
		arg_220_1
	})
end

function var_0_24.getMirrorShopItemQualityCellBg(arg_221_0, arg_221_1)
	return var_0_23({
		"ui://shop/bg_mirror_shop_",
		arg_221_1
	})
end

function var_0_24.getPrayShopItemQualityCellBg(arg_222_0, arg_222_1)
	return var_0_23({
		"ui://shop/bg_pray_shop_",
		arg_222_1
	})
end

function var_0_24.getLinkShopItemQualityCellBg(arg_223_0, arg_223_1)
	return var_0_23({
		"ui://shop/pic_bzhx1_shop_di_pinjie_",
		arg_223_1
	})
end

function var_0_24.getLingShopItemQualityCellBg(arg_224_0, arg_224_1)
	return var_0_23({
		"ui://shop/pic_bzhx2_shop_di_pinjie_",
		arg_224_1
	})
end

function var_0_24.getSpringShopItemQualityCellBg(arg_225_0, arg_225_1)
	return var_0_23({
		"ui://shop/bg_spring_shop_",
		arg_225_1
	})
end

function var_0_24.getCloudsShopItemQualityCellBg(arg_226_0, arg_226_1)
	return var_0_23({
		"ui://shop/bg_fyxm_shopdi",
		arg_226_1
	})
end

function var_0_24.getAnnaShopItemQualityCellBg(arg_227_0, arg_227_1)
	return var_0_23({
		"ui://shop/bg_crow_shop_",
		arg_227_1
	})
end

function var_0_24.getFeifeiShopItemQualityCellBg(arg_228_0, arg_228_1)
	return var_0_23({
		"ui://shop/bg_travel_shop_",
		arg_228_1
	})
end

function var_0_24.getCarlaShopItemQualityCellBg(arg_229_0, arg_229_1)
	return var_0_23({
		"ui://shop/bg_swan_shop_",
		arg_229_1
	})
end

function var_0_24.getYuanDanItemQualityCellBg(arg_230_0, arg_230_1)
	return var_0_23({
		"ui://shop/bg_xsqq_shop_",
		arg_230_1
	})
end

function var_0_24.getPengpengItemQualityCellBg(arg_231_0, arg_231_1)
	return var_0_23({
		"ui://shop/bg_jszm1_shop_",
		arg_231_1
	})
end

function var_0_24.getJulietItemQualityCellBg(arg_232_0, arg_232_1)
	return var_0_23({
		"ui://shop/bg_jszm2_shop_",
		arg_232_1
	})
end

function var_0_24.getBaiYuItemQualityCellBg(arg_233_0, arg_233_1)
	return var_0_23({
		"ui://shop/bg_sgcr1_shop_",
		arg_233_1
	})
end

function var_0_24.getWeiYangItemQualityCellBg(arg_234_0, arg_234_1)
	return var_0_23({
		"ui://shop/bg_sgcr2_shop_",
		arg_234_1
	})
end

function var_0_24.getIliyiItemQualityCellBg(arg_235_0, arg_235_1)
	return var_0_23({
		"ui://shop/bg_dzfdxr_shop_",
		arg_235_1
	})
end

function var_0_24.getSummerShopItemQualityBg(arg_236_0, arg_236_1)
	return var_0_23({
		"ui://shop/bg_summershop_kucun_",
		arg_236_1
	})
end

function var_0_24:getKnightNameQualityBg(arg_237_1)
	return self:getNameQualityBg(arg_237_1)
end

function var_0_24.getNameQualityBg(arg_238_0, arg_238_1)
	arg_238_1 = math.clamp(arg_238_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

	return var_0_23({
		"pic/base_new/quality/bg_name_pinzhi_",
		arg_238_1 + 1,
		".png"
	})
end

function var_0_24.getCardQualityLine(arg_239_0, arg_239_1)
	arg_239_1 = math.clamp(arg_239_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

	return var_0_23({
		"pic/base_new/quality/pic_yht_pinzhi_",
		arg_239_1 + 1,
		".png"
	})
end

function var_0_24.getKnightNameQualityBg2(arg_240_0, arg_240_1)
	arg_240_1 = math.clamp(arg_240_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

	return var_0_23({
		"ui://base_new/bg_yht_name_pinzhi",
		arg_240_1 + 1
	})
end

function var_0_24.getKnightSkinSpineCompBg(arg_241_0, arg_241_1)
	arg_241_1 = math.clamp(arg_241_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

	return var_0_23({
		"ui://base_new/pic_yht_huanzhuang_pz_",
		arg_241_1 + 1
	})
end

function var_0_24.getKnightSkinBookSpineCompBg(arg_242_0, arg_242_1)
	arg_242_1 = math.clamp(arg_242_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

	return var_0_23({
		"ui://base_new/pic_yht_huanzhuang_pz_",
		arg_242_1 + 1
	})
end

function var_0_24.getFormationKnightNameBg(arg_243_0, arg_243_1)
	return var_0_23({
		"ui://base_new/pic_bz_pinzhi",
		arg_243_1 + 1
	})
end

function var_0_24:getFormationUniteTokenBg(arg_244_1)
	return self:getPreciousSuitCellQualityUrl(arg_244_1)
end

function var_0_24.getKnightProfessionAndDamageTypeIcon(arg_245_0, arg_245_1, arg_245_2)
	arg_245_1 = arg_245_1 or 1
	arg_245_2 = arg_245_2 or 1

	local var_245_0 = arg_245_2 + 1
	local var_245_1 = "ui://base_new/icon_zhiye"

	if arg_245_1 == 1 then
		var_245_1 = var_0_23({
			var_245_1,
			"shuchu_",
			var_245_0
		})
	elseif arg_245_1 == 2 then
		var_245_1 = var_0_23({
			var_245_1,
			"fuzhu_",
			var_245_0
		})
	elseif arg_245_1 == 3 then
		var_245_1 = var_0_23({
			var_245_1,
			"zhiliao_",
			var_245_0
		})
	elseif arg_245_1 == 4 then
		var_245_1 = var_0_23({
			var_245_1,
			"tanke_",
			var_245_0
		})
	elseif arg_245_1 == 5 then
		var_245_1 = var_0_23({
			var_245_1,
			"kongzhi_",
			var_245_0
		})
	end

	return var_245_1
end

function var_0_24:getKnightPicRes(arg_246_1)
	if self:isCensorByResId(arg_246_1) and self:isFileExist(var_0_23({
		"icon/knight_pictorial_book_censor/",
		arg_246_1,
		".png"
	})) then
		return var_0_23({
			"icon/knight_pictorial_book_censor/",
			arg_246_1,
			".png"
		})
	end

	if self:isUseRemoteByResId(arg_246_1) and self:isFileExist(var_0_23({
		"icon/knight_pictorial_book_remote/",
		arg_246_1,
		".png"
	})) then
		return var_0_23({
			"icon/knight_pictorial_book_remote/",
			arg_246_1,
			".png"
		})
	end

	return var_0_23({
		"icon/knight_pictorial_book/",
		arg_246_1,
		".png"
	})
end

function var_0_24:getKnightBookPicRes(arg_247_1)
	if self:isCensorByResId(arg_247_1) and self:isFileExist(var_0_23({
		"icon/knight_pictorial_book_censor/",
		arg_247_1,
		".png"
	})) then
		return var_0_23({
			"icon/knight_pictorial_book_censor/",
			arg_247_1,
			".png"
		})
	end

	if self:isUseRemoteByResId(arg_247_1) and self:isFileExist(var_0_23({
		"icon/knight_pictorial_book_remote/",
		arg_247_1,
		".png"
	})) then
		return var_0_23({
			"icon/knight_pictorial_book_remote/",
			arg_247_1,
			".png"
		})
	end

	return var_0_23({
		"icon/knight_pictorial_book/",
		arg_247_1,
		".png"
	})
end

function var_0_24.getCampURL(arg_248_0, arg_248_1, arg_248_2)
	arg_248_2 = arg_248_2 or 1

	return (string.format("%s%02d", arg_248_1 == var_0_20.KNIGHT_CONST.GROUP_TYPE.JIAO_GUO and "ui://base_new/icon_jiaoguo_" or arg_248_1 == var_0_20.KNIGHT_CONST.GROUP_TYPE.LIN_DONG and "ui://base_new/icon_lindong_" or arg_248_1 == var_0_20.KNIGHT_CONST.GROUP_TYPE.DONG_XI and "ui://base_new/icon_dongxi_" or "ui://base_new/icon_lijin_", arg_248_2))
end

function var_0_24.getCampActiveURL(arg_249_0, arg_249_1)
	local var_249_0 = var_0_20.KNIGHT_CONST

	return arg_249_1 == var_0_20.KNIGHT_CONST.GROUP_TYPE.JIAO_GUO and "ui://base_new/icon_bz_jiaoguo" or arg_249_1 == var_249_0.GROUP_TYPE.LI_JIN and "ui://base_new/icon_bz_lijin" or arg_249_1 == var_249_0.GROUP_TYPE.DONG_XI and "ui://base_new/icon_bz_dongxi" or "ui://base_new/icon_bz_lindong"
end

function var_0_24.getBigCampURL(arg_250_0, arg_250_1)
	return var_0_23({
		"icon/group/icon_group_",
		arg_250_1,
		".png"
	})
end

function var_0_24.getCampURLNew(arg_251_0, arg_251_1)
	return var_0_23({
		"ui://base_new/pic_zhenying_0",
		arg_251_1
	})
end

function var_0_24.getQualityArtTxtURL(arg_252_0, arg_252_1)
	return var_0_23({
		"ui://text_new/pic_pinzhi_",
		arg_252_1 + 1
	})
end

function var_0_24.getQualityArtTxtURLNew(arg_253_0, arg_253_1)
	return var_0_23({
		"ui://text_new/pic_pinzhi_",
		arg_253_1 + 1
	})
end

function var_0_24.getQualityTxtAndBg(arg_254_0, arg_254_1)
	local var_254_0 = {
		[0] = "N",
		"R",
		"SR",
		"SSR"
	}
	local var_254_1 = tostring(arg_254_1 + 1)

	if var_254_0[arg_254_1] then
		return var_254_0[arg_254_1], var_0_23({
			"ui://knight/bg_shengpin_",
			var_254_1
		}), (var_0_23({
			"ui://knight/bg_pinzhi_",
			var_254_1
		}))
	else
		return ""
	end
end

function var_0_24.getNewTextImg(arg_255_0, arg_255_1)
	return var_0_23({
		"ui://text_new/",
		arg_255_1
	})
end

function var_0_24:getAttrIcon(arg_256_1, arg_256_2)
	arg_256_2 = arg_256_2 ~= false

	local var_256_0 = var_0_20.BASE_CONST.ATTRIBUTE_TYPE
	local var_256_1

	if arg_256_1 == var_0_20.BASE_CONST.ATTRIBUTE_TYPE.LIFE then
		var_256_1 = "icon_shengming"
	elseif arg_256_1 == var_256_0.ATTACK then
		var_256_1 = "icon_gongji"
	elseif arg_256_1 == var_256_0.ARMOR then
		var_256_1 = "icon_fangyu"
	elseif arg_256_1 == var_256_0.RESISTANCE then
		var_256_1 = "icon_mokang"
	elseif arg_256_1 == var_256_0.DEFENSE then
		var_256_1 = "icon_fangyu"
	end

	if var_256_1 then
		if not arg_256_2 then
			var_256_1 = var_0_23({
				var_256_1,
				"_2"
			})
		end

		return self:getAttrIconByName(var_256_1)
	end
end

function var_0_24.getAttrIconByName(arg_257_0, arg_257_1, arg_257_2)
	return var_0_23({
		"icon/attrIcon/",
		arg_257_1,
		arg_257_2 and "1" or "",
		".png"
	})
end

function var_0_24:getSpineKnightPath(arg_258_1)
	if not (tonumber(arg_258_1) == 20700720 or tonumber(arg_258_1) == 20500050) then
		if not g.core.utils.Rule.matchChannelAndLv() and self:isCensorByResId(arg_258_1) and self:isFileExist(var_0_23({
			"censor/knight_spine/",
			arg_258_1,
			"/",
			arg_258_1,
			".skel"
		})) then
			return var_0_23({
				"censor/knight_spine/",
				arg_258_1,
				"/",
				arg_258_1
			})
		end

		if not g.core.utils.Rule.matchChannelAndLv() and self:isUseRemoteByResId(arg_258_1) and self:isFileExist(var_0_23({
			"knight_spine_remote/",
			arg_258_1,
			"/",
			arg_258_1,
			".skel"
		})) then
			return var_0_23({
				"knight_spine_remote/",
				arg_258_1,
				"/",
				arg_258_1
			})
		end
	end

	return var_0_23({
		"knight_spine/",
		arg_258_1,
		"/",
		arg_258_1
	})
end

function var_0_24.getBattleSpineKnightPath(arg_259_0, arg_259_1)
	return var_0_23({
		"battle/knight_spine/",
		arg_259_1,
		"/",
		arg_259_1
	})
end

function var_0_24:getSpineKnightBgPath(arg_260_1)
	if self:isCensorByResId(arg_260_1) and self:isFileExist(var_0_23({
		"censor/knight_spine/",
		arg_260_1,
		"/",
		arg_260_1,
		"_bg.skel"
	})) then
		return var_0_23({
			"censor/knight_spine/",
			arg_260_1,
			"/",
			arg_260_1,
			"_bg"
		})
	end

	if self:isUseRemoteByResId(arg_260_1) and self:isFileExist(var_0_23({
		"knight_spine_remote/",
		arg_260_1,
		"/",
		arg_260_1,
		"_bg.skel"
	})) then
		return var_0_23({
			"knight_spine_remote/",
			arg_260_1,
			"/",
			arg_260_1,
			"_bg"
		})
	end

	return var_0_23({
		"knight_spine/",
		arg_260_1,
		"/",
		arg_260_1,
		"_bg"
	})
end

function var_0_24.getUniteTokenSpineFolderPath(arg_261_0, arg_261_1)
	return var_0_23({
		"unite_token_spine/",
		arg_261_1
	})
end

function var_0_24:getUniteTokenSpinePath(arg_262_1)
	return var_0_23({
		self:getUniteTokenSpineFolderPath(arg_262_1),
		"/",
		arg_262_1
	})
end

function var_0_24.getEffSpine(arg_263_0, arg_263_1)
	return var_0_23({
		"effect_spine/",
		arg_263_1,
		"/",
		arg_263_1
	})
end

function var_0_24.getStoryAutoURL(arg_264_0, arg_264_1)
	return arg_264_1 and "ui://base_new/icon_jq_zanting" or "ui://base_new/icon_jq_bofang"
end

function var_0_24.getBattleUnitProgBar(arg_265_0)
	return "ui/battle/battle_atlas_hcfp9.png"
end

function var_0_24.getBattleUnitSkillProgBar(arg_266_0)
	return "ui/battle/battle_atlas_hcfp0.png"
end

function var_0_24.getUniteTokenIconById(arg_267_0, arg_267_1)
	return var_0_23({
		"icon/unitetoken/",
		arg_267_1,
		".png"
	})
end

function var_0_24.getUniteTokenCardImg(arg_268_0, arg_268_1)
	return var_0_23({
		"pic/unitetoken/",
		arg_268_1,
		".png"
	})
end

function var_0_24.getUniteTokenMidCardImg(arg_269_0, arg_269_1)
	return var_0_23({
		"pic/unitetoken_128/",
		arg_269_1,
		".png"
	})
end

function var_0_24.getSettingPicById(arg_270_0, arg_270_1)
	return var_0_23({
		"ui://setting/",
		arg_270_1
	})
end

function var_0_24.getEntrancePicById(arg_271_0, arg_271_1)
	return var_0_23({
		"pic/",
		"campaign/",
		arg_271_1,
		".png"
	})
end

function var_0_24.getOutPutIconById(arg_272_0, arg_272_1)
	return var_0_23({
		"icon/",
		"campaign/",
		arg_272_1,
		".png"
	})
end

function var_0_24.getBioTeamQualityBg(arg_273_0, arg_273_1)
	return var_0_23({
		"ui://biography/pic_lzzy_pinzhi_",
		arg_273_1
	})
end

function var_0_24.getDailyDungeonImg(arg_274_0, arg_274_1)
	return var_0_23({
		"ui://dailyDungeon/",
		arg_274_1
	})
end

function var_0_24.getFurnitureTypeIcon(arg_275_0, arg_275_1, arg_275_2)
	return var_0_23({
		"ui://furniture/icon_furniture_",
		arg_275_1,
		"_",
		arg_275_2
	})
end

function var_0_24.getFurnitureIconByResId(arg_276_0, arg_276_1)
	return var_0_23({
		"icon/furniture/",
		arg_276_1,
		".png"
	})
end

function var_0_24.getFurniturePicByRes(arg_277_0, arg_277_1)
	return var_0_23({
		"pic/furniture/",
		arg_277_1,
		".png"
	})
end

function var_0_24.getFurnitureRightPicByRes(arg_278_0, arg_278_1)
	return var_0_23({
		"pic/furniture/",
		arg_278_1,
		"_r.png"
	})
end

function var_0_24.getFurnitureRoomBgByRes(arg_279_0, arg_279_1)
	return var_0_23({
		"pic/furniture/",
		arg_279_1,
		".jpg"
	})
end

function var_0_24.getFurnitureLightPicByRes(arg_280_0, arg_280_1)
	return var_0_23({
		"pic/furniture/highlight_",
		arg_280_1,
		".png"
	})
end

function var_0_24.getBagNewQualityBgPath(arg_281_0, arg_281_1)
	return var_0_23({
		"ui://base_new/pic_bb_namebg_",
		arg_281_1 + 1
	})
end

function var_0_24.getAchievementIconByResId(arg_282_0, arg_282_1)
	return var_0_23({
		"pic/achievement/",
		arg_282_1,
		".png"
	})
end

function var_0_24.getKnightKnightTextByQuality(arg_283_0, arg_283_1)
	return var_0_23({
		"ui://text_new/pic_pinzhi_",
		arg_283_1
	})
end

function var_0_24:getKnightPictorialBook(arg_284_1)
	if self:isCensorByResId(arg_284_1) and self:isFileExist(var_0_23({
		"icon/knight_pictorial_book_censor/",
		arg_284_1,
		".png"
	})) then
		return var_0_23({
			"icon/knight_pictorial_book_censor/",
			arg_284_1,
			".png"
		})
	end

	if self:isUseRemoteByResId(arg_284_1) and self:isFileExist(var_0_23({
		"icon/knight_pictorial_book_remote/",
		arg_284_1,
		".png"
	})) then
		return var_0_23({
			"icon/knight_pictorial_book_remote/",
			arg_284_1,
			".png"
		})
	end

	return var_0_23({
		"icon/knight_pictorial_book/",
		arg_284_1,
		".png"
	})
end

function var_0_24.getGuildCampaignPicById(arg_285_0, arg_285_1)
	return var_0_23({
		"pic/",
		"guildCampaign/",
		arg_285_1,
		".png"
	})
end

function var_0_24:getBannerImg(arg_286_1)
	if require("app.core.lang.MultilingualMgr"):getUseLang() == "cn" and config.PUBLISH_REGION ~= g.core.const.ConstMgr.PlatformConst.REGION.CHINA then
		local var_286_0 = var_0_23({
			"pic/home_en/pic_banner_",
			arg_286_1,
			".png"
		})

		if self:isFileExist(var_286_0) then
			return var_286_0
		end
	end

	return var_0_23({
		"pic/home/pic_banner_",
		arg_286_1,
		".png"
	})
end

function var_0_24.getSkinConditionImg(arg_287_0, arg_287_1)
	return var_0_23({
		"pic/skinTheme/",
		arg_287_1,
		".png"
	})
end

function var_0_24.getActivityIcon(arg_288_0, arg_288_1)
	return var_0_23({
		"icon/activity/",
		arg_288_1,
		".png"
	})
end

function var_0_24.getActivityBg(arg_289_0, arg_289_1)
	return var_0_23({
		"pic/activity_bg/",
		arg_289_1,
		".png"
	})
end

function var_0_24.getStoryInsertDialogPic(arg_290_0, arg_290_1)
	return var_0_23({
		"pic/story/",
		arg_290_1,
		".png"
	})
end

function var_0_24.getWarriorsMainChapterPic(arg_291_0, arg_291_1)
	return var_0_23({
		"pic/warriors/",
		arg_291_1,
		".png"
	})
end

function var_0_24.getBioTeamCampaignBgRes(arg_292_0, arg_292_1)
	return var_0_23({
		"bg/story/",
		arg_292_1,
		".jpg"
	})
end

function var_0_24.getGmTotalRechargeBg(arg_293_0, arg_293_1)
	return var_0_23({
		"bg/activity/",
		arg_293_1,
		".jpg"
	})
end

function var_0_24.getGmTotalRechargeKnightPic(arg_294_0, arg_294_1)
	return var_0_23({
		"ui://gmTotalRecharge/",
		arg_294_1
	})
end

function var_0_24.getPeakArenaDanGradingPic(arg_295_0, arg_295_1)
	return var_0_23({
		"pic/peakArena/danGrading_",
		arg_295_1,
		".png"
	})
end

function var_0_24.getPassCardRewardIconQuality(arg_296_0, arg_296_1)
	arg_296_1 = math.clamp(arg_296_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

	return var_0_23({
		"ui://themePasscard/pic_pinzhi_",
		arg_296_1 + 1,
		".png"
	})
end

function var_0_24.getPassCardTitlePic(arg_297_0, arg_297_1)
	return var_0_23({
		"pic/passCard/",
		arg_297_1,
		".png"
	})
end

function var_0_24.getPassCardTitleBgPic(arg_298_0, arg_298_1)
	return var_0_23({
		"bg/passCard/",
		arg_298_1,
		".png"
	})
end

function var_0_24.getPassCardBgPic(arg_299_0, arg_299_1)
	return var_0_23({
		"bg/passCard/",
		arg_299_1,
		".png"
	})
end

function var_0_24.getPassCardBonusPic(arg_300_0, arg_300_1)
	return var_0_23({
		"pic/passCard/",
		arg_300_1,
		".png"
	})
end

function var_0_24.getPassCardGiftPic(arg_301_0, arg_301_1)
	return ""
end

function var_0_24:getGuideTaskPic(arg_302_1)
	if require("app.core.lang.MultilingualMgr"):getUseLang() == "cn" and config.PUBLISH_REGION ~= g.core.const.ConstMgr.PlatformConst.REGION.CHINA then
		local var_302_0 = var_0_23({
			"pic/guideTask_en/",
			arg_302_1,
			".png"
		})

		if self:isFileExist(var_302_0) then
			return var_302_0
		end
	end

	return var_0_23({
		"pic/guideTask/",
		arg_302_1,
		".png"
	})
end

function var_0_24.getPassCardEntranceIconByCharge(arg_303_0, arg_303_1)
	return var_0_23({
		"ui://base_new/icon_pass0",
		arg_303_1 + 1
	})
end

function var_0_24.getAttrQualityBgByQuality(arg_304_0, arg_304_1)
	arg_304_1 = math.clamp(arg_304_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

	if arg_304_1 == var_0_20.QUALITY_TYPE.NONE then
		return "ui://base_new/bg_shuxingdi"
	else
		local var_304_0 = {
			"pic/base_new/quality/bg_shuxingdi_",
			nil,
			".png"
		}

		var_304_0[2] = arg_304_1 + 1

		return var_0_23(var_304_0)
	end
end

function var_0_24.getActivityDailyGiftIconById(arg_305_0, arg_305_1)
	return var_0_23({
		"pic/dailySale/",
		arg_305_1,
		".png"
	})
end

function var_0_24:getStoryIllustrationPicRes(arg_306_1)
	if self:isFileExist(var_0_23({
		"pic/story_pic_remote/",
		arg_306_1
	})) then
		return var_0_23({
			"pic/story_pic_remote/",
			arg_306_1
		})
	end

	return var_0_23({
		"pic/story_pic/",
		arg_306_1
	})
end

function var_0_24.getParticleRes(arg_307_0, arg_307_1)
	return var_0_23({
		"particle/",
		arg_307_1,
		".plist"
	})
end

function var_0_24.getFurnitureBookCellPicBg(arg_308_0, arg_308_1)
	return var_0_23({
		"pic/furniture_book/",
		arg_308_1,
		".png"
	})
end

function var_0_24.getIconByUserSnapshot(arg_309_0, arg_309_1)
	if not arg_309_1 then
		return ""
	end

	local var_309_0
	local var_309_1, var_309_2 = g.core.common.GlobalFunc.checkAndGetRobotData(arg_309_1)

	var_309_0 = var_309_1 and (var_309_2.resId == nil and g.core.config.knight_info.get(var_309_2.showId) or g.core.config.robot_info.get(arg_309_1.base_id)) or g.core.config.knight_info.get(arg_309_1.base_id)

	local var_309_3 = g.core.config.knight_base_info.get(var_309_0.res_id)

	if arg_309_1.skin and arg_309_1.skin > 0 and arg_309_1.skin_ts and (arg_309_1.skin_ts == 0 or arg_309_1.skin_ts > g.core.common.ServerTime:getTime()) then
		var_309_3 = g.core.config.knight_base_info.get(g.core.config.skin_info.get(arg_309_1.skin).res)
	end

	return g.core.common.Path:getRoleHeadIcon(arg_309_1.dress_id and arg_309_1.dress_id ~= 0 and g.core.config.knight_base_info.get((var_309_0.sex == 0 or nil) and g.core.config.dress_info.get(arg_309_1.dress_id).woman_res_id).icon_id or arg_309_1.avata_id and arg_309_1.avata_id > 0 and g.core.config.avata_info.get(arg_309_1.avata_id).res or var_309_3.icon_id)
end

function var_0_24.getArtifactImg(arg_310_0, arg_310_1)
	return var_0_23({
		"pic/artifact/",
		arg_310_1,
		".png"
	})
end

function var_0_24.getArtifactRebornImg(arg_311_0, arg_311_1)
	return var_0_23({
		"pic/artifact_256/",
		arg_311_1,
		".png"
	})
end

function var_0_24.getArtifactFormationImg(arg_312_0, arg_312_1)
	return var_0_23({
		"pic/artifact_bz/",
		arg_312_1,
		".png"
	})
end

function var_0_24.getBigQualityBgByQuality(arg_313_0, arg_313_1)
	arg_313_1 = math.clamp(arg_313_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

	return var_0_23({
		"pic/base_new/quality/bg_cs_chaoyueguwu_pinzhi",
		arg_313_1 + 1,
		".png"
	})
end

function var_0_24.getArtifactGroupIcon(arg_314_0, arg_314_1)
	return var_0_23({
		"icon/group/artifact/",
		arg_314_1,
		".png"
	})
end

function var_0_24.getArtifactGroupIcon2(arg_315_0, arg_315_1)
	return var_0_23({
		"icon/group/artifact/",
		arg_315_1,
		"_1.png"
	})
end

function var_0_24:getArtifactEntranceIcon(arg_316_1)
	return self:getArtifactIconById(arg_316_1)
end

function var_0_24.getKnightCartoonById(arg_317_0, arg_317_1)
	return var_0_23({
		"icon/knight_cartoon/",
		arg_317_1,
		".png"
	})
end

function var_0_24.getInteractJsonFile(arg_318_0, arg_318_1)
	return var_0_23({
		"parallax/dungeon_stage/interact/",
		arg_318_1,
		"_monster_interact.json"
	})
end

function var_0_24.getDungeonInteractResByType(arg_319_0, arg_319_1)
	return var_0_23({
		"icon/dungeon_interact/icon_",
		arg_319_1,
		".png"
	})
end

function var_0_24.getProfileIconById(arg_320_0, arg_320_1)
	return var_0_23({
		"icon/database/",
		arg_320_1,
		".png"
	})
end

function var_0_24.getDailyTaskBoxIconById(arg_321_0, arg_321_1)
	return var_0_23({
		"icon/item/richangrenwu_",
		arg_321_1,
		".png"
	})
end

function var_0_24.getSceneSkinIcon(arg_322_0, arg_322_1)
	return var_0_23({
		"icon/scene_skin/scene_skin128/",
		arg_322_1,
		".png"
	})
end

function var_0_24.getSceneSkinBigIcon(arg_323_0, arg_323_1)
	return var_0_23({
		"icon/scene_skin/scene_skin256/",
		arg_323_1,
		".png"
	})
end

function var_0_24.getEasterEggImage(arg_324_0, arg_324_1)
	if config.PUBLISH_REGION == g.core.const.ConstMgr.PlatformConst.REGION.KR and arg_324_1 == "05_2" then
		return "pic/easterEgg/05_2_kr.png"
	elseif config.PUBLISH_REGION == g.core.const.ConstMgr.PlatformConst.REGION.EN and arg_324_1 == "05_2" then
		return "pic/easterEgg/05_2_en.png"
	elseif config.PUBLISH_REGION == g.core.const.ConstMgr.PlatformConst.REGION.JAPAN and arg_324_1 == "05_2" then
		return "pic/easterEgg/05_2_os.png"
	elseif config.PUBLISH_REGION == g.core.const.ConstMgr.PlatformConst.REGION.SEA and arg_324_1 == "05_2" then
		return "pic/easterEgg/05_2_os.png"
	elseif config.PUBLISH_REGION == g.core.const.ConstMgr.PlatformConst.REGION.TW and arg_324_1 == "05_2" then
		return "pic/easterEgg/05_2_os.png"
	else
		return var_0_23({
			"pic/easterEgg/",
			arg_324_1,
			".png"
		})
	end
end

function var_0_24.getEasterEggPlotReplayImage(arg_325_0, arg_325_1)
	return var_0_23({
		"pic/easterEgg/plotReplay/",
		arg_325_1,
		".jpg"
	})
end

function var_0_24.getGuildWarBuild(arg_326_0, arg_326_1)
	return var_0_23({
		"pic/guildWar/",
		arg_326_1,
		".png"
	})
end

function var_0_24.getGuildWarRealBuild(arg_327_0, arg_327_1, arg_327_2, arg_327_3)
	return var_0_23({
		"pic/guildWarSmall/",
		arg_327_2,
		"/",
		arg_327_1,
		"_",
		arg_327_3,
		".png"
	})
end

function var_0_24:getMineCityBuildingIconQualityPic(arg_328_1)
	return self:getPreciousSuitCellQualityUrl(arg_328_1)
end

function var_0_24.getFogNightmareKeepsakePicRes(arg_329_0, arg_329_1)
	return var_0_23({
		"icon/fogNightmare/keepsake/",
		arg_329_1,
		".png"
	})
end

function var_0_24.getFogNightmareTalentPicRes(arg_330_0, arg_330_1)
	return var_0_23({
		"icon/fogNightmare/talent/",
		arg_330_1,
		".png"
	})
end

function var_0_24.getFogNightmareKeepsakeSuitPicRes(arg_331_0, arg_331_1)
	return var_0_23({
		"icon/fogNightmare/keepsakeSuit/",
		arg_331_1,
		".png"
	})
end

function var_0_24.getGveBasePath(arg_332_0)
	return "maps/gve/"
end

function var_0_24.getGveBossPath(arg_333_0, arg_333_1)
	return var_0_23({
		"pic/gve/boss/bg_pshc_bz_boss_",
		arg_333_1,
		".png"
	})
end

function var_0_24.getGveApplyPreviewPic(arg_334_0, arg_334_1)
	return var_0_23({
		"pic/gve/registration/",
		arg_334_1,
		".png"
	})
end

function var_0_24.getHalidomById(arg_335_0, arg_335_1)
	return var_0_23({
		"icon/halidom/",
		arg_335_1,
		".png"
	})
end

function var_0_24.getHalidom128ById(arg_336_0, arg_336_1)
	return var_0_23({
		"icon/halidom_128/",
		arg_336_1,
		".png"
	})
end

function var_0_24.getHalidomResourceById(arg_337_0, arg_337_1)
	return var_0_23({
		"icon/halidom_resource/",
		arg_337_1,
		".png"
	})
end

function var_0_24.getHalidomMaskById(arg_338_0, arg_338_1)
	return "icon/halidom/icon_pshc_shengwu1_256.png"
end

function var_0_24.getBigHalidomJobIconByBranch(arg_339_0, arg_339_1)
	if arg_339_1 == 0 then
		return "ui://gve/icon_pshc_gudianxingxing"
	elseif arg_339_1 == 1 then
		return "ui://gve/icon_pshc_gudianxingxing"
	elseif arg_339_1 == 2 then
		return "ui://gve/icon_pshc_huangdaoxingzuo"
	elseif arg_339_1 == 3 then
		return "ui://gve/icon_pshc_xiaoxingtianti"
	end
end

function var_0_24.getColorHalidomJobIconByBranch(arg_340_0, arg_340_1)
	if arg_340_1 == 0 then
		return "ui://gve/icon_pshc_xiaoxingtianti"
	elseif arg_340_1 == 1 then
		return "ui://gve/icon_pshc_gudianxingxing"
	elseif arg_340_1 == 2 then
		return "ui://gve/icon_pshc_huangdaoxingzuo"
	elseif arg_340_1 == 3 then
		return "ui://gve/icon_pshc_xiaoxingtianti"
	end
end

function var_0_24.getHalidomSkillIconById(arg_341_0, arg_341_1)
	return var_0_23({
		"icon/halidom_skill/",
		arg_341_1,
		".png"
	})
end

function var_0_24.getGveTeamBigIconRes(arg_342_0, arg_342_1, arg_342_2)
	return var_0_23({
		arg_342_1,
		"/",
		arg_342_2,
		".png"
	})
end

function var_0_24.getGveTeamSmallIconRes(arg_343_0, arg_343_1, arg_343_2)
	return var_0_23({
		arg_343_1,
		"_128/",
		arg_343_2,
		".png"
	})
end

function var_0_24.getPetTeamIcon(arg_344_0, arg_344_1)
	return var_0_23({
		"icon/pet_team/",
		arg_344_1,
		".png"
	})
end

function var_0_24.getPetDrawing(arg_345_0, arg_345_1)
	return var_0_23({
		"icon/pet_drawing/",
		arg_345_1,
		".png"
	})
end

function var_0_24.getPetFragment(arg_346_0, arg_346_1)
	return var_0_23({
		"icon/pet_fragment_128/",
		arg_346_1,
		".png"
	})
end

function var_0_24.getPetIcon(arg_347_0, arg_347_1)
	return var_0_23({
		"icon/pet_icon/",
		arg_347_1,
		".png"
	})
end

function var_0_24.getPetPictorialBook(arg_348_0, arg_348_1)
	return var_0_23({
		"icon/pet_pictorial_book/",
		arg_348_1,
		".png"
	})
end

function var_0_24.getPetEquipmentIcon(arg_349_0, arg_349_1)
	return var_0_23({
		"icon/pet_equipment/",
		arg_349_1,
		".png"
	})
end

function var_0_24:getPetSpinePath(arg_350_1)
	return var_0_23({
		self:getMapKnightPath(),
		arg_350_1,
		"/",
		arg_350_1
	})
end

function var_0_24:getPetNameQualityBg(arg_351_1)
	return self:getNameQualityBg(arg_351_1)
end

function var_0_24.getPetRecruitPic(arg_352_0, arg_352_1)
	return var_0_23({
		"icon/pet_recruit/",
		arg_352_1,
		".png"
	})
end

function var_0_24.getPetMiddle(arg_353_0, arg_353_1)
	return var_0_23({
		"icon/pet_middle/",
		arg_353_1,
		".png"
	})
end

function var_0_24.getSuccubaImg(arg_354_0, arg_354_1)
	return var_0_23({
		"icon/succuba_mini/",
		arg_354_1,
		".png"
	})
end

function var_0_24.getPetQualityDian(arg_355_0, arg_355_1)
	arg_355_1 = math.clamp(arg_355_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

	return var_0_23({
		"pic/base_new/pet/pic_zm_yzs_dian",
		arg_355_1 + 1,
		".png"
	})
end

function var_0_24.getPetQualityKuang1(arg_356_0, arg_356_1)
	arg_356_1 = math.clamp(arg_356_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

	return var_0_23({
		"pic/base_new/pet/pic_zm_yzs_pinzhikuang1-",
		arg_356_1 + 1,
		".png"
	})
end

function var_0_24.getPetQualityKuang2(arg_357_0, arg_357_1)
	arg_357_1 = math.clamp(arg_357_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

	return var_0_23({
		"pic/base_new/pet/pic_zm_yzs_pinzhikuang2-",
		arg_357_1 + 1,
		".png"
	})
end

function var_0_24.getGMSignPopRes(arg_358_0, arg_358_1)
	return var_0_23({
		"pic/gmSign/",
		arg_358_1,
		"/"
	})
end

function var_0_24.getGMSignBigRewardRes(arg_359_0, arg_359_1)
	return var_0_23({
		"pic/gmSign/reward/",
		arg_359_1,
		".png"
	})
end

function var_0_24.getGMWishResultPopRes(arg_360_0, arg_360_1)
	return var_0_23({
		"pic/gmWish/",
		arg_360_1,
		"/"
	})
end

function var_0_24.getGMWishRechargeIcon(arg_361_0, arg_361_1, arg_361_2)
	return string.format("icon/gmWish/icon_%s_libao%d_1.png", arg_361_1, arg_361_2)
end

function var_0_24.getMulTeamLeftVerticalQualityBarURL(arg_362_0, arg_362_1)
	arg_362_1 = math.clamp(arg_362_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

	return var_0_23({
		"ui://base_new/pic_wjmy_bz_yht_l_",
		arg_362_1 + 1
	})
end

function var_0_24.getMulTeamArtifactQualityBgURL(arg_363_0, arg_363_1)
	arg_363_1 = math.clamp(arg_363_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

	return var_0_23({
		"ui://base_new/pic_wjmy_bz_yht_r_",
		arg_363_1 + 1
	})
end

function var_0_24.getPermanentRechargeBuilding(arg_364_0, arg_364_1)
	return var_0_23({
		"icon/permanentRecharge/",
		arg_364_1,
		".png"
	}), (var_0_23({
		"icon/permanentRecharge/",
		arg_364_1,
		"_1.png"
	}))
end

function var_0_24.getPermanentRechargeGiftRightIcon(arg_365_0, arg_365_1)
	return var_0_23({
		"icon/permanentRecharge/mini-icon/",
		arg_365_1,
		".png"
	})
end

function var_0_24.getShareLogoByRegionId(arg_366_0, arg_366_1)
	if arg_366_1 == 0 then
		arg_366_1 = 1
	end

	local var_366_0 = "logo"

	if config.PUBLISH_REGION == g.core.const.ConstMgr.PlatformConst.REGION.KR then
		var_366_0 = "logoKr"
	end

	if config.PUBLISH_REGION == g.core.const.ConstMgr.PlatformConst.REGION.JAPAN or config.PUBLISH_REGION == g.core.const.ConstMgr.PlatformConst.REGION.SEA or config.PUBLISH_REGION == g.core.const.ConstMgr.PlatformConst.REGION.TW then
		return var_0_23({
			"pic/",
			"logoOS",
			"/pic_logo",
			arg_366_1,
			".png"
		})
	end

	local var_366_1 = g.core.const.ConstMgr.BASE_CONST.LOGO

	if g.core.const.ConstMgr.BASE_CONST.LOGO > 0 then
		return var_0_23({
			"pic/",
			var_366_0,
			"/pic_logo_",
			var_366_1,
			".png"
		})
	end

	return var_0_23({
		"pic/",
		var_366_0,
		"/pic_logo.png"
	})
end

function var_0_24.getBattleCardBgByRegionId(arg_367_0, arg_367_1)
	if arg_367_1 == 0 then
		arg_367_1 = 1
	end

	local var_367_0 = "logo"

	if config.PUBLISH_REGION == g.core.const.ConstMgr.PlatformConst.REGION.KR then
		var_367_0 = "logoKr"
	end

	if config.PUBLISH_REGION == g.core.const.ConstMgr.PlatformConst.REGION.JAPAN or config.PUBLISH_REGION == g.core.const.ConstMgr.PlatformConst.REGION.SEA or config.PUBLISH_REGION == g.core.const.ConstMgr.PlatformConst.REGION.TW then
		return var_0_23({
			"pic/",
			"logoOS",
			"/pic_lzzy_kapaiweixuanze",
			arg_367_1,
			".png"
		})
	end

	local var_367_1 = g.core.const.ConstMgr.BASE_CONST.LOGO

	if g.core.const.ConstMgr.BASE_CONST.LOGO > 0 then
		return var_0_23({
			"pic/",
			var_367_0,
			"/pic_lzzy_kapaiweixuanze_",
			var_367_1,
			".png"
		})
	end

	return var_0_23({
		"pic/",
		var_367_0,
		"/pic_lzzy_kapaiweixuanze.png"
	})
end

function var_0_24.getLoginLogoByRegionId(arg_368_0)
	local var_368_0 = "logo"

	if config.PUBLISH_REGION == g.core.const.ConstMgr.PlatformConst.REGION.KR then
		var_368_0 = "logoKr"
	end

	if config.PUBLISH_REGION == g.core.const.ConstMgr.PlatformConst.REGION.JAPAN or config.PUBLISH_REGION == g.core.const.ConstMgr.PlatformConst.REGION.SEA or config.PUBLISH_REGION == g.core.const.ConstMgr.PlatformConst.REGION.TW then
		return var_0_23({
			"pic/",
			"logoOS",
			"/icon_dl_logo",
			config.PUBLISH_REGION,
			".png"
		})
	end

	local var_368_1 = g.core.const.ConstMgr.BASE_CONST.LOGO

	if g.core.const.ConstMgr.BASE_CONST.LOGO > 0 then
		return var_0_23({
			"pic/",
			var_368_0,
			"/icon_dl_logo_",
			var_368_1,
			".png"
		})
	end

	return var_0_23({
		"pic/",
		var_368_0,
		"/icon_dl_logo.png"
	})
end

function var_0_24.getEggLogoByRegionId(arg_369_0)
	return var_0_23({
		"pic/logo_egg/logo_black_",
		config.PUBLISH_REGION,
		".png"
	})
end

function var_0_24.getEchoLabTalentIcon(arg_370_0, arg_370_1, arg_370_2)
	local var_370_0 = ""

	if arg_370_2 == 2 then
		arg_370_1 = var_0_23({
			arg_370_1,
			"1"
		})
		var_370_0 = var_0_23({
			"icon/echoLab/",
			arg_370_1,
			".png"
		})
	elseif arg_370_2 == 1 then
		arg_370_1 = var_0_23({
			arg_370_1,
			"_2"
		})
		var_370_0 = var_0_23({
			"icon/attrIcon/",
			arg_370_1,
			".png"
		})
	else
		arg_370_1 = string.sub(arg_370_1, 1, -2)
		var_370_0 = var_0_23({
			"icon/attrIcon/",
			arg_370_1,
			".png"
		})
	end

	return var_370_0
end

function var_0_24.getEchoLabTalent256Icon(arg_371_0, arg_371_1)
	local var_371_1

	if arg_371_1.node_type == var_0_20.EchoLabConst.NODE_TYPE1.VALUE2 then
		var_371_1 = "icon/echoLab/huixiangzhongduan.png"
	else
		local var_371_2 = {
			"icon/attrIcon/",
			nil,
			".png"
		}

		var_371_2[2] = g.core.config.attribute_info.get(arg_371_1.affect_type_1).icon_big
		var_371_1 = var_0_23(var_371_2)
	end

	return var_371_1
end

function var_0_24.getGenePicByResId(arg_372_0, arg_372_1)
	return var_0_23({
		"pic/gene/",
		arg_372_1,
		".png"
	})
end

function var_0_24.getGeneFragIconByType(arg_373_0, arg_373_1, arg_373_2)
	if arg_373_2 == 0 then
		return var_0_23({
			"ui://gene/icon_swjx_",
			arg_373_1,
			"_1"
		})
	else
		return var_0_23({
			"ui://gene/icon_swjx_",
			arg_373_1,
			"_0"
		})
	end
end

function var_0_24.getGeneCollectCardQuality(arg_374_0, arg_374_1)
	arg_374_1 = math.clamp(arg_374_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

	return var_0_23({
		"ui://base_new/pic_echo_tujian_pinzhi_",
		arg_374_1 + 1
	})
end

function var_0_24.getCompetitionTabIcon(arg_375_0, arg_375_1)
	return var_0_23({
		"pic/competition/tab/",
		arg_375_1,
		".png"
	})
end

function var_0_24.getCompetitionRankIcon(arg_376_0, arg_376_1)
	return var_0_23({
		"pic/competition/rank/",
		arg_376_1,
		".png"
	})
end

function var_0_24.getCompetitionActivityIcon(arg_377_0, arg_377_1)
	return var_0_23({
		"pic/competition/activity/",
		arg_377_1,
		".png"
	})
end

function var_0_24.isCensorByResId(arg_378_0, arg_378_1)
	if g.core.const.ConstMgr.BASE_CONST.CENSOR_USER_LIST[tostring((g.core.model.User:getPlatUserId()))] or g.core.model.User.homeData:getStorageCensorStatus() then
		return true
	end

	local var_378_0 = g.core.utils.Rule.isForceUseRulePath() or g.core.utils.Rule.isForceUseRulePath(g.core.utils.Rule.matchChannelOther)

	var_378_0 = not var_378_0 and g.core.model.User.homeData:isHarmoniousMystery() or false

	return var_378_0
end

function var_0_24.isUseRemoteByResId(arg_379_0, arg_379_1)
	if g.core.model.User.homeData:isCensorRigid() then
		return true
	end

	local var_379_0 = var_0_23
	local var_379_1 = {
		nil,
		"highquality/"
	}

	var_379_1[1] = cc.FileUtils:getInstance():getWritablePath()

	local var_379_2 = var_379_0(var_379_1)

	if not cc.FileUtils:getInstance():isDirectoryExist(var_0_23({
		var_379_2,
		"res/common/"
	})) then
		if cc.FileUtils:getInstance():isDirectoryExist(var_0_23({
			var_379_2,
			"knight_spine/"
		})) then
			return false
		end

		if g.core.utils.Rule.isForceUseRulePath(g.core.utils.Rule.matchChannelOther) then
			return true
		end

		if g.core.const.ConstMgr.BASE_CONST.USE_REMOTE then
			return true
		end

		if not arg_379_1 then
			return false
		end

		if g.core.const.ConstMgr.BASE_CONST.USE_REMOTE_ID_LIST[var_0_23({
			"s",
			tostring(arg_379_1)
		})] then
			return true
		end
	end

	return false
end

function var_0_24.getChiefArenaBg(arg_380_0, arg_380_1)
	return string.format("bg/arena/%s.jpg", arg_380_1)
end

function var_0_24.getChiefArenaSkillIcon(arg_381_0, arg_381_1)
	return var_0_23({
		"icon/buff_icon/",
		arg_381_1,
		".png"
	})
end

function var_0_24.getChiefArenaSkillIconBg(arg_382_0, arg_382_1)
	return var_0_23({
		"ui://base_new/",
		arg_382_1
	})
end

function var_0_24.getTeamPVPMainBg(arg_383_0, arg_383_1)
	return string.format("bg/teamPVP/main_map_%02d.jpg", arg_383_1)
end

function var_0_24.getTeamPVPTeamBg(arg_384_0, arg_384_1)
	return string.format("bg/teamPVP/team_map_%02d.jpg", arg_384_1)
end

function var_0_24.getTeamPVPTeamRoute(arg_385_0, arg_385_1)
	return string.format("bg/teamPVP/lineup_route_%02d.png", arg_385_1)
end

function var_0_24.getTeamPVPBadge300(arg_386_0, arg_386_1)
	return var_0_23({
		"icon/teamPVP/badge_300/",
		arg_386_1,
		".png"
	})
end

function var_0_24.getTeamPVPBadge128(arg_387_0, arg_387_1)
	return var_0_23({
		"icon/teamPVP/badge_128/",
		arg_387_1,
		".png"
	})
end

function var_0_24.getTeamPVPThumbnail(arg_388_0, arg_388_1)
	return string.format("pic/teamPVP/thumbnail/pic_djs_youce_ditu_%d.png", arg_388_1)
end

function var_0_24.getTeamPVPBattleBg(arg_389_0, arg_389_1)
	return var_0_23({
		"bg/teamPVP/bg_teamPVP_0",
		arg_389_1,
		".jpg"
	})
end

function var_0_24.getTeamPVPExtraBattleLineBg(arg_390_0, arg_390_1)
	return var_0_23({
		"ui://teamPVP/pic_batlle_road_",
		arg_390_1
	})
end

function var_0_24.getTeamPVPVideoPreview(arg_391_0, arg_391_1)
	return var_0_23({
		"pic/teamPVP/videoPreview/pic_djs_shipintu",
		arg_391_1,
		".png"
	})
end

function var_0_24.getExplorationShowCardQuality(arg_392_0, arg_392_1)
	arg_392_1 = math.clamp(arg_392_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

	return var_0_23({
		"ui://base_new/pic_slmj_pinzhi",
		arg_392_1 + 1
	})
end

function var_0_24.getExplorationBuffIconQuality(arg_393_0, arg_393_1)
	arg_393_1 = math.clamp(arg_393_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

	return var_0_23({
		"ui://exploration/pic_bg_touxiangpinzhi_",
		arg_393_1 + 1
	})
end

function var_0_24.getBuffNameQuality(arg_394_0, arg_394_1)
	arg_394_1 = math.clamp(arg_394_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

	return var_0_23({
		"ui://base_new/pic_bb_namebg_",
		arg_394_1 + 1
	})
end

function var_0_24.getExplorationGuildBuffQuality(arg_395_0, arg_395_1)
	arg_395_1 = math.clamp(arg_395_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

	return var_0_23({
		"ui://base_new/pic_slmj_buffpinzhi",
		arg_395_1 + 1
	})
end

function var_0_24.getExplorationShopItemQuality(arg_396_0, arg_396_1)
	arg_396_1 = math.clamp(arg_396_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

	return var_0_23({
		"ui://base_new/",
		"pic_slmj_" .. arg_396_1 + 1 .. "pinzhisddi"
	}), var_0_23({
		"ui://base_new/",
		"pic_slmj_" .. arg_396_1 + 1 .. "pinzhisd"
	})
end

function var_0_24.getRedCliffExplainPic(arg_397_0, arg_397_1)
	return var_0_23({
		"pic/redCliff/pic_hdzb_shuoming",
		arg_397_1,
		".png"
	})
end

function var_0_24.getPreciousSmallIconByResId(arg_398_0, arg_398_1)
	return var_0_23({
		"icon/precious_128/",
		arg_398_1,
		".png"
	})
end

function var_0_24.getPreciousIconByResId(arg_399_0, arg_399_1)
	return var_0_23({
		"icon/precious_256/",
		arg_399_1,
		".png"
	})
end

function var_0_24.getPreciousBigIconByResId(arg_400_0, arg_400_1)
	return var_0_23({
		"icon/precious_512/",
		arg_400_1,
		".png"
	})
end

function var_0_24.getPreciousSuitIconByResId(arg_401_0, arg_401_1)
	return var_0_23({
		"icon/precious_suit/",
		arg_401_1,
		".png"
	})
end

function var_0_24.getPreciousQualityUrl(arg_402_0, arg_402_1)
	arg_402_1 = math.clamp(arg_402_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

	return var_0_23({
		"ui://base_new/pic_gzp_wupin",
		arg_402_1 + 1
	})
end

function var_0_24.getPreciousSuitCellQualityUrl(arg_403_0, arg_403_1)
	arg_403_1 = math.clamp(arg_403_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

	return var_0_23({
		"ui://base_new/pic_bzcl_pinzhi",
		arg_403_1 + 1
	})
end

function var_0_24.getCultivateImage(arg_404_0, arg_404_1, arg_404_2)
	return var_0_23({
		"ui_cocos/cultivate/",
		arg_404_2,
		"/",
		arg_404_1,
		".png"
	})
end

function var_0_24.getCultivateMulLangImage(arg_405_0, arg_405_1, arg_405_2)
	return var_0_23({
		"pic/cultivate/",
		arg_405_2,
		"/",
		arg_405_1,
		".png"
	})
end

function var_0_24.getCultivateCardImage(arg_406_0, arg_406_1, arg_406_2)
	return var_0_23({
		"ui_cocos/cultivateCard/",
		arg_406_2,
		"/",
		arg_406_1,
		".png"
	})
end

function var_0_24.getCultivateCardMulLangImage(arg_407_0, arg_407_1, arg_407_2)
	return var_0_23({
		"pic/cultivateCard/",
		arg_407_2,
		"/",
		arg_407_1,
		".png"
	})
end

function var_0_24.isFileExist(arg_408_0, arg_408_1)
	return var_0_22:isFileExist(arg_408_1)
end

function var_0_24.getThemePassCardMulLangImage(arg_409_0, arg_409_1, arg_409_2)
	return var_0_23({
		"pic/themePassCard/",
		arg_409_2,
		"/",
		arg_409_1,
		".png"
	})
end

function var_0_24.getThemePassCardImage(arg_410_0, arg_410_1, arg_410_2)
	return var_0_23({
		"ui_cocos/themePassCard/",
		arg_410_2,
		"/",
		arg_410_1,
		".png"
	})
end

function var_0_24.getWeddingVowText(arg_411_0, arg_411_1)
	return var_0_23({
		"pic/wedding_vow/text/",
		arg_411_1,
		".png"
	})
end

function var_0_24.getWeddingVowBaseIcon(arg_412_0)
	return "pic/wedding_vow/frame/pic_bg_touxiangpinzhi_shiyue_2.png"
end

function var_0_24.getWeddingVowLineUpIcon(arg_413_0)
	return "pic/wedding_vow/frame/bg_xd_leftdi_shiyue_2.png"
end

function var_0_24.getWeddingVowFormationIcon(arg_414_0, arg_414_1)
	return var_0_23({
		"pic/wedding_vow/frame/pic_bz_pinzhi_shiyue_",
		arg_414_1,
		".png"
	})
end

function var_0_24.getWeddingVowBagIcon(arg_415_0)
	return "pic/wedding_vow/frame/bg_yht_di_shiyue_2.png"
end

function var_0_24.getRerunObstacleRes(arg_416_0, arg_416_1)
	return var_0_23({
		"ui_cocos/rerun/",
		arg_416_1,
		".png"
	})
end

function var_0_24.getTeamBattlePicRes(arg_417_0, arg_417_1)
	return var_0_23({
		"ui_cocos/teamBattle/",
		arg_417_1,
		".png"
	})
end

function var_0_24.getRichmanBuildRes(arg_418_0, arg_418_1, arg_418_2)
	if arg_418_1 == 1 then
		return var_0_23({
			"pic/richman/preview/",
			arg_418_2,
			".png"
		})
	elseif arg_418_1 == 3 then
		return var_0_23({
			"pic/richman/mini/",
			arg_418_2,
			".png"
		})
	else
		return var_0_23({
			"pic/richman/construct/",
			arg_418_2,
			".png"
		})
	end
end

function var_0_24.getTalentIcon(arg_419_0, arg_419_1)
	return var_0_23({
		"icon/talent/",
		arg_419_1,
		".png"
	})
end

function var_0_24:getTreeIcon(arg_420_1, arg_420_2)
	if arg_420_1 == g.core.const.ConstMgr.TreeConst.NODE_TYPE.SMALL then
		return self:getAttrIconByName(arg_420_2)
	elseif arg_420_1 == g.core.const.ConstMgr.TreeConst.NODE_TYPE.BIG then
		return self:getAttrIconByName(arg_420_2)
	elseif arg_420_1 == g.core.const.ConstMgr.TreeConst.NODE_TYPE.CENTER then
		return var_0_23({
			"icon/tree/",
			arg_420_2,
			".png"
		})
	end
end

function var_0_24.getTeamBattleReadyPic(arg_421_0, arg_421_1)
	return var_0_23({
		"pic/teamBattle/ready/",
		arg_421_1,
		".png"
	})
end

function var_0_24.getTeamBattleShopItemQuality(arg_422_0, arg_422_1)
	return var_0_23({
		"ui://base_new/pic_hjtj_shop_pinzhi",
		arg_422_1
	})
end

function var_0_24.getTeamBattleBagItemQuality(arg_423_0, arg_423_1)
	return var_0_23({
		"ui://base_new/pic_hjtj_bb_pinzhi",
		arg_423_1 + 1
	})
end

function var_0_24.getTeamBattleBuffIconQuality(arg_424_0, arg_424_1)
	return var_0_23({
		"ui://teamBattle/pic_bg_touxiangpinzhi_",
		arg_424_1
	})
end

function var_0_24.getTeamBattleDiffIcon(arg_425_0, arg_425_1)
	return var_0_23({
		"ui://teamBattle/icon_hjtj_nandu",
		arg_425_1
	})
end

function var_0_24.getTeamBattleIcon(arg_426_0, arg_426_1)
	return var_0_23({
		"icon/teamBattle/",
		arg_426_1,
		".png"
	})
end

function var_0_24.getCommonGuidePic(arg_427_0, arg_427_1)
	return var_0_23({
		"pic/commonGuide/",
		arg_427_1,
		".png"
	})
end

function var_0_24.getCommonGuideVideo(arg_428_0, arg_428_1)
	return var_0_23({
		"pic/commonGuide/",
		arg_428_1,
		".png"
	})
end

function var_0_24.getCelebrationLoginBanner(arg_429_0, arg_429_1)
	return var_0_23({
		"pic/celebrationLogin/",
		arg_429_1,
		".png"
	})
end

function var_0_24.getCelebrationLoginSlogan(arg_430_0, arg_430_1)
	return var_0_23({
		"ui://text_new/",
		arg_430_1
	})
end

function var_0_24.getCelebrationLoginDailyQualityLine(arg_431_0, arg_431_1)
	arg_431_1 = math.clamp(arg_431_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

	return var_0_23({
		"ui://activity/pic_hd_znqqd_pinzhi",
		arg_431_1 + 1
	})
end

function var_0_24.getCelebrationLoginImage(arg_432_0, arg_432_1, arg_432_2)
	return var_0_23({
		"ui_cocos/celebrationLogin/",
		arg_432_2,
		"/",
		arg_432_1,
		".png"
	})
end

function var_0_24.getCelebrationLoginMulLangImage(arg_433_0, arg_433_1, arg_433_2)
	return var_0_23({
		"pic/celebrationLogin/",
		arg_433_2,
		"/",
		arg_433_1,
		".png"
	})
end

function var_0_24.getWakeLoginDailyQualityLine(arg_434_0, arg_434_1)
	arg_434_1 = math.clamp(arg_434_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

	return var_0_23({
		"ui://activity/pic_hxzl_pinzhi",
		arg_434_1 + 1
	})
end

function var_0_24.getPetHandbookQualityBg(arg_435_0, arg_435_1)
	arg_435_1 = math.clamp(arg_435_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

	return var_0_23({
		"ui://base_new/bg_tj_pinzhi",
		arg_435_1 + 1
	})
end

function var_0_24.getPetHandbookQualityFrame(arg_436_0, arg_436_1)
	arg_436_1 = math.clamp(arg_436_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

	return var_0_23({
		"ui://base_new/pic_tj_pinzhi",
		arg_436_1 + 1,
		"-2"
	})
end

function var_0_24.getPerCardQualityQualityFrame(arg_437_0, arg_437_1)
	arg_437_1 = math.clamp(arg_437_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

	return var_0_23({
		"pic/base_new/quality/pic_zcck_pinzhi",
		arg_437_1 + 1,
		".png"
	})
end

function var_0_24.getHandBookTitleQuality(arg_438_0, arg_438_1)
	arg_438_1 = math.clamp(arg_438_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

	return var_0_23({
		"ui://base_new/pic_tj_title_",
		arg_438_1 + 1
	})
end

function var_0_24.getQualityLineByQualityAndIndex(arg_439_0, arg_439_1, arg_439_2)
	arg_439_1 = math.clamp(arg_439_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

	return string.format("ui://base_new/pic_pinzhi%d_%d", arg_439_1 + 1, arg_439_2)
end

function var_0_24.getKnightHandBookCardQualityBg(arg_440_0, arg_440_1)
	arg_440_1 = math.clamp(arg_440_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

	return var_0_23({
		"ui://base_new/bg_tj_pinzhi_",
		arg_440_1 + 1,
		"_1"
	}), var_0_23({
		"ui://base_new/bg_tj_pinzhi_",
		arg_440_1 + 1,
		"_2"
	})
end

function var_0_24.getRecruitQualityLine(arg_441_0, arg_441_1, arg_441_2)
	arg_441_1 = math.clamp(arg_441_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)
	arg_441_2 = arg_441_2 or "ui://base_new/bg_zm_pinzhixian_"

	return var_0_23({
		arg_441_2,
		arg_441_1 + 1
	})
end

function var_0_24.getRecruitCampTxt(arg_442_0, arg_442_1, arg_442_2)
	arg_442_2 = math.clamp(arg_442_2, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

	return var_0_23({
		"pic/base_new/campText/txt_zm_zhenying",
		arg_442_1,
		"_",
		arg_442_2 + 1,
		".png"
	})
end

function var_0_24.getRecruitBgTipText(arg_443_0, arg_443_1)
	arg_443_1 = math.clamp(arg_443_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

	return var_0_23({
		"pic/base_new/quality/txt_zm_echo_",
		arg_443_1 + 1,
		".png"
	})
end

function var_0_24.getRecruitQualitySquareBg(arg_444_0, arg_444_1)
	arg_444_1 = math.clamp(arg_444_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

	return (var_0_23({
		"ui://base_new/bg_zm_pinzhi_",
		arg_444_1 + 1
	}))
end

function var_0_24.getRecruitQualitySquareBgByParam(arg_445_0, arg_445_1)
	local var_445_0 = math.clamp(arg_445_1.quality, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY) + 1

	if arg_445_1.package then
		return var_0_23({
			"ui://",
			arg_445_1.package,
			"/bg_zm_pinzhi_",
			var_445_0
		})
	else
		return var_0_23({
			"ui://base_new/bg_zm_pinzhi_",
			var_445_0
		})
	end
end

function var_0_24.getActRecruitQualitySquareBg(arg_446_0, arg_446_1)
	arg_446_1 = math.clamp(arg_446_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

	return var_0_23({
		"ui://base_new/bg_zm_pinzhi_",
		arg_446_1 + 1
	})
end

function var_0_24.getRecruitQualityDiamondBg(arg_447_0, arg_447_1)
	arg_447_1 = math.clamp(arg_447_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

	return var_0_23({
		"ui://base_new/bg_zm_pinzhi_",
		arg_447_1 + 1,
		"_1"
	})
end

function var_0_24.getInfoPopQualityLine(arg_448_0, arg_448_1)
	arg_448_1 = math.clamp(arg_448_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

	return var_0_23({
		"ui://base_new/bg_xx_pinzhi",
		arg_448_1 + 1
	})
end

function var_0_24.getBelongKnightQualityBg(arg_449_0, arg_449_1)
	arg_449_1 = math.clamp(arg_449_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

	return var_0_23({
		"pic/base_new/quality/bg_xx2_pinzhi",
		arg_449_1 + 1,
		".png"
	})
end

function var_0_24.getRecruitPetCornerMark(arg_450_0, arg_450_1)
	arg_450_1 = math.clamp(arg_450_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

	return var_0_23({
		"ui://base_new/pic_yzs_jiaobiao",
		arg_450_1 + 1
	})
end

function var_0_24.getRecruitPetBg(arg_451_0, arg_451_1)
	arg_451_1 = math.clamp(arg_451_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

	return var_0_23({
		"ui://base_new/pic_yzs_slc_pinzhi",
		arg_451_1 + 1
	})
end

function var_0_24.getRecruitPetFragmentBg(arg_452_0, arg_452_1)
	arg_452_1 = math.clamp(arg_452_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

	return var_0_23({
		"ui://base_new/pic_yzs_sp_pinzhi",
		arg_452_1 + 1
	})
end

function var_0_24.getRecruitPetQualityLine(arg_453_0, arg_453_1)
	arg_453_1 = math.clamp(arg_453_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

	return var_0_23({
		"ui://base_new/pic_zm_yzs_pinzhiline",
		arg_453_1 + 1
	})
end

function var_0_24.getPetShowQualityBg(arg_454_0, arg_454_1)
	arg_454_1 = math.clamp(arg_454_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

	return var_0_23({
		"ui://base_new/pic_zm_yzs_pinzhi",
		arg_454_1 + 1
	})
end

function var_0_24.getTxtRecruitLogo(arg_455_0, arg_455_1)
	arg_455_1 = math.clamp(arg_455_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

	return var_0_23({
		"pic/recruit/txt_zm_logo",
		arg_455_1 + 1,
		".png"
	})
end

function var_0_24.getArtifactRecruitBg(arg_456_0, arg_456_1)
	arg_456_1 = math.clamp(arg_456_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

	return var_0_23({
		"ui://base_new/bg_zm_gmwz_pinzhidi_",
		arg_456_1 + 1
	})
end

function var_0_24.getArtifactRecruitWord(arg_457_0, arg_457_1)
	arg_457_1 = math.clamp(arg_457_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

	return var_0_23({
		"ui://base_new/bg_zm_gmwz_pinzhidi_word_",
		arg_457_1 + 1
	})
end

function var_0_24.getPetRewardLayerItemColorBlock(arg_458_0, arg_458_1)
	arg_458_1 = math.clamp(arg_458_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

	return var_0_23({
		"ui://base_new/pic_zm_yzs_pinzhisekuai",
		arg_458_1 + 1
	})
end

function var_0_24.getRecruitRewardCellLeftQualityLine(arg_459_0, arg_459_1, arg_459_2)
	arg_459_1 = math.clamp(arg_459_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

	if not arg_459_2 then
		return var_0_23({
			"ui://base_new/pic_zm_sppinzhi_",
			arg_459_1 + 1
		})
	else
		return var_0_23({
			"ui://",
			arg_459_2,
			"/pic_zm_sppinzhi_",
			arg_459_1 + 1
		})
	end
end

function var_0_24.getAllianceFlag128(arg_460_0, arg_460_1)
	return var_0_23({
		"icon/guildAlliance/flag_128/",
		arg_460_1,
		".png"
	})
end

function var_0_24.getAllianceFlag256(arg_461_0, arg_461_1)
	return var_0_23({
		"icon/guildAlliance/flag_256/",
		arg_461_1,
		".png"
	})
end

function var_0_24.getAllianceBox128(arg_462_0, arg_462_1)
	return var_0_23({
		"icon/guildAlliance/box_128/",
		arg_462_1,
		".png"
	})
end

function var_0_24.getAllianceBox400(arg_463_0, arg_463_1)
	return var_0_23({
		"icon/guildAlliance/box_400/",
		arg_463_1,
		".png"
	})
end

function var_0_24.getAllianceMinNumBox(arg_464_0, arg_464_1)
	return var_0_23({
		"icon/guildAlliance/box_midNum/",
		arg_464_1,
		".png"
	})
end

function var_0_24.getAllianceBigNumBox(arg_465_0, arg_465_1)
	return var_0_23({
		"icon/guildAlliance/box_bigNum/",
		arg_465_1,
		".png"
	})
end

function var_0_24.getAllianceOpenBox(arg_466_0, arg_466_1)
	return var_0_23({
		"icon/guildAlliance/box_open/",
		arg_466_1,
		".png"
	})
end

function var_0_24.getAllianceSendQuality(arg_467_0, arg_467_1)
	return var_0_23({
		"ui://alliance/pic_ghlm_number",
		arg_467_1
	})
end

function var_0_24.getAllianceBuildIcon(arg_468_0, arg_468_1, arg_468_2)
	if arg_468_2 then
		return var_0_23({
			"icon/guildAlliance/buildings_black/",
			arg_468_1,
			".png"
		})
	else
		return var_0_23({
			"icon/guildAlliance/buildings_white/",
			arg_468_1,
			".png"
		})
	end
end

function var_0_24.getAllianceBoxQualityBg(arg_469_0, arg_469_1)
	return var_0_23({
		"ui://alliance/pic_ghlm_pinzhi",
		arg_469_1 - 1
	})
end

function var_0_24.getPlayerInfoUniteQualityBg(arg_470_0, arg_470_1)
	arg_470_1 = math.clamp(arg_470_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

	return var_0_23({
		"ui://base_new/pic_info_gf_guwu_pinzhi",
		arg_470_1 + 1
	})
end

function var_0_24.getPlayerInfoTitleQualityBg(arg_471_0, arg_471_1)
	arg_471_1 = math.clamp(arg_471_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

	return var_0_23({
		"ui://playerInfo/pic_info_gf_xunzhang_pinzhi",
		arg_471_1 + 1
	})
end

function var_0_24.getPhoenixHomeBtnIconUrl(arg_472_0, arg_472_1)
	return var_0_23({
		"icon/firstRecharge/",
		arg_472_1,
		".png"
	})
end

function var_0_24.getNewSlgMapPath(arg_473_0, arg_473_1, arg_473_2, arg_473_3)
	return string.format("tile_map/new_slg/slg%d/tiled/slg%d_%s_%s.tmx", arg_473_1, arg_473_1, arg_473_2, arg_473_3)
end

function var_0_24.getNewSlgCsvPath(arg_474_0, arg_474_1, arg_474_2)
	return string.format("tile_map/new_slg/slg%d/csvs/%s.csv", arg_474_1, arg_474_2)
end

function var_0_24.getNewSlgSelect(arg_475_0, arg_475_1)
	return string.format("tile_map/pic_ddtwf_dige_xuanzhong0%s.png", arg_475_1)
end

function var_0_24.getNewSlgMonster(arg_476_0, arg_476_1)
	return arg_476_1 .. ".png"
end

function var_0_24.getNewSlgBuilding(arg_477_0, arg_477_1)
	return arg_477_1 .. ".png"
end

function var_0_24.getNewSlgChariot(arg_478_0, arg_478_1)
	return "pic/new_slg/new_slg_chariot/" .. arg_478_1 .. ".png"
end

function var_0_24.getNewSlgFarm(arg_479_0, arg_479_1)
	return "pic/new_slg/farm/gengdi_0" .. arg_479_1 .. ".png"
end

function var_0_24.getNewSlgSiegeCity(arg_480_0, arg_480_1)
	if not arg_480_1 then
		return ""
	end

	return "pic/new_slg/siege/city/" .. arg_480_1 .. ".png"
end

function var_0_24.getNewSlgSiegeTerrain(arg_481_0, arg_481_1)
	if not arg_481_1 then
		return ""
	end

	return "pic/new_slg/siege/terrain/" .. arg_481_1 .. ".png"
end

function var_0_24.getNewSlgSiegeBoss(arg_482_0, arg_482_1)
	if not arg_482_1 then
		return ""
	end

	return "pic/new_slg/siege/boss/" .. arg_482_1 .. ".png"
end

function var_0_24.getNewSlgMonsterHead(arg_483_0, arg_483_1, arg_483_2)
	if not arg_483_1 then
		return ""
	end

	if arg_483_2 then
		return "pic/new_slg/head/boss/" .. arg_483_1 .. ".png"
	else
		return "pic/new_slg/head/monster/" .. arg_483_1 .. ".png"
	end
end

function var_0_24.getNewSlgGroupIcon(arg_484_0, arg_484_1)
	return "pic/new_slg/group/pic_hzts_guanai" .. arg_484_1 .. ".png"
end

function var_0_24.getNewSlgTroopIconUI(arg_485_0, arg_485_1)
	if arg_485_1 == 1 then
		return "#icon_bingzhong1.png"
	elseif arg_485_1 == 2 then
		return "#icon_bingzhong2.png"
	elseif arg_485_1 == 3 then
		return "#icon_bingzhong3.png"
	elseif arg_485_1 == 4 then
		return "#icon_bingzhong4.png"
	end
end

function var_0_24.getNewSlgTroopIcon(arg_486_0, arg_486_1)
	if arg_486_1 == 1 then
		return "ui://newSlg/icon_bingzhong1"
	elseif arg_486_1 == 2 then
		return "ui://newSlg/icon_bingzhong2"
	elseif arg_486_1 == 3 then
		return "ui://newSlg/icon_bingzhong3"
	elseif arg_486_1 == 4 then
		return "ui://newSlg/icon_bingzhong4"
	end
end

function var_0_24.getNewSlgBuildPic(arg_487_0, arg_487_1)
	return "pic/new_slg/build/" .. arg_487_1 .. ".png"
end

function var_0_24.getNewSlgMainCityPic(arg_488_0, arg_488_1)
	return "pic/new_slg/main_city/" .. arg_488_1 .. ".png"
end

function var_0_24.getMainCitySelect(arg_489_0, arg_489_1)
	return "pic/new_slg/main_city_select/" .. arg_489_1 .. ".png"
end

function var_0_24.getNewSlgMainCityBigPic(arg_490_0, arg_490_1)
	return "pic/new_slg/main_city_gov/" .. arg_490_1 .. ".png"
end

function var_0_24.getNewSlgEmbryoQualityBg(arg_491_0, arg_491_1)
	arg_491_1 = math.clamp(arg_491_1, var_0_20.QUALITY_TYPE.NONE, var_0_20.QUALITY_TYPE.MAX_QUALITY)

	return var_0_23({
		"ui://newSlg/pic_hzts_sz_pinzhi",
		arg_491_1 + 1
	})
end

function var_0_24.getNewSlgEmbryoPic(arg_492_0, arg_492_1)
	if arg_492_1 == g.core.common.Goods.TYPE_KNIGHT then
		return "ui://newSlg/icon_echo1_youhuati"
	elseif arg_492_1 == g.core.common.Goods.TYPE_ARTIFACT then
		return "ui://newSlg/icon_echo2_gongming"
	elseif arg_492_1 == g.core.common.Goods.TYPE_UNITETOKEN then
		return "ui://newSlg/icon_echo4_guwu"
	elseif arg_492_1 == g.core.common.Goods.TYPE_PET then
		return "ui://newSlg/icon_echo3_yuanzhishou"
	elseif arg_492_1 == g.core.common.Goods.TYPE_SUCCUBA then
		return "ui://newSlg/icon_hzts_monvzj"
	end

	return ""
end

function var_0_24.getGroupWarSelectImg(arg_493_0, arg_493_1, arg_493_2)
	if arg_493_1 == 1 then
		return "tile_map/pic_ddtwf_dige_xuanzhong.png"
	else
		return string.format("tile_map/pic_ddtwf_dige_xuanzhong0%d.png", arg_493_1)
	end
end

function var_0_24.getGroupWarPathImg(arg_494_0, arg_494_1)
	if arg_494_1 then
		return "tile_map/pic_ddtwf_luxian.png"
	else
		return "tile_map/pic_ddtwf_luxian_hong.png"
	end
end

function var_0_24.getTipsIcon(arg_495_0, arg_495_1)
	return var_0_23({
		"icon/tips",
		var_0_23({
			arg_495_1,
			"png"
		}, ".")
	}, "/")
end

function var_0_24.getCommonPassCardIcon(arg_496_0, arg_496_1, arg_496_2)
	return var_0_23({
		"icon/commonPassCard/icon_zhanling",
		arg_496_1,
		"_",
		arg_496_2,
		".png"
	})
end

function var_0_24.getAllianceTrialBasePath(arg_497_0)
	return "maps/trial/"
end

function var_0_24.getAllianceHonourBg(arg_498_0, arg_498_1)
	return var_0_23({
		"ui://alliance/",
		arg_498_1
	})
end

function var_0_24.getRoleSkinIcon(arg_499_0, arg_499_1, arg_499_2)
	if arg_499_2 and arg_499_2 == 512 then
		return var_0_23({
			"icon/roleSkin_512/",
			arg_499_1,
			".png"
		})
	end

	return var_0_23({
		"icon/roleSkin/",
		arg_499_1,
		".png"
	})
end

function var_0_24.getRoleSkinQualityBg(arg_500_0, arg_500_1)
	return var_0_23({
		"ui://roleSkin/bg_zstz_pinzhi_",
		arg_500_1 + 1
	})
end

function var_0_24.getMainRoleBackSpinePath(arg_501_0, arg_501_1)
	return var_0_23({
		"back_spine/",
		arg_501_1,
		"/",
		arg_501_1
	})
end

function var_0_24.getWeddingActivityIcon(arg_502_0, arg_502_1)
	return var_0_23({
		"icon/weddingActivity/",
		arg_502_1,
		".png"
	})
end

function var_0_24.getAbvertPageAwardRoleBg(arg_503_0, arg_503_1)
	return var_0_23({
		"pic/abvertPageAward/",
		arg_503_1,
		".png"
	})
end

function var_0_24.getPubgBasePath(arg_504_0)
	return "maps/pubg/"
end

function var_0_24.getPubgBuff(arg_505_0, arg_505_1)
	return var_0_23({
		"icon/pubg/",
		arg_505_1,
		".png"
	})
end

function var_0_24.getPubgAirBuff(arg_506_0, arg_506_1)
	return var_0_23({
		"icon/pubg/",
		arg_506_1,
		".png"
	})
end

function var_0_24.getPubgRulePic(arg_507_0, arg_507_1)
	return var_0_23({
		"pic/pubg/pic_pubg_shuoming",
		arg_507_1,
		".png"
	})
end

function var_0_24.getPubgMiniMapBg(arg_508_0, arg_508_1)
	return var_0_23({
		"pic/pubgMiniMap/",
		arg_508_1,
		".png"
	})
end

function var_0_24.getSuccubaHeadIcon(arg_509_0, arg_509_1)
	return var_0_23({
		"icon/succuba/",
		arg_509_1,
		".png"
	})
end

function var_0_24.getNewSlgSkillIconByName(arg_510_0, arg_510_1)
	return var_0_23({
		"icon/newSlgSkill/",
		arg_510_1,
		".png"
	})
end

function var_0_24.getNewSlgStrategyIcon(arg_511_0, arg_511_1)
	return var_0_23({
		"icon/slgStrategy/",
		arg_511_1,
		".png"
	})
end

function var_0_24.getKnightElementIcon(arg_512_0, arg_512_1, arg_512_2)
	local var_512_0 = ""

	arg_512_2 = arg_512_2 or "ui://base_new/"

	if arg_512_1 == 1 then
		var_512_0 = "icon_shui_s"
	elseif arg_512_1 == 2 then
		var_512_0 = "icon_huo_s"
	elseif arg_512_1 == 3 then
		var_512_0 = "icon_feng_s"
	elseif arg_512_1 == 4 then
		var_512_0 = "icon_lei_s"
	elseif arg_512_1 == 5 then
		var_512_0 = "icon_di_s"
	end

	return var_0_23({
		arg_512_2,
		var_512_0
	})
end

function var_0_24.getBigElementIcon(arg_513_0, arg_513_1)
	local var_513_0 = ""

	if arg_513_1 == 1 then
		var_513_0 = "icon_shui"
	elseif arg_513_1 == 2 then
		var_513_0 = "icon_huo"
	elseif arg_513_1 == 3 then
		var_513_0 = "icon_feng"
	elseif arg_513_1 == 4 then
		var_513_0 = "icon_lei"
	elseif arg_513_1 == 5 then
		var_513_0 = "icon_di"
	end

	return var_0_23({
		"ui://base_new/",
		var_513_0
	})
end

function var_0_24.getElderBossBuffById(arg_514_0, arg_514_1)
	return var_0_23({
		"pic/elderBoss/buff/",
		arg_514_1,
		".png"
	})
end

function var_0_24.getElderBossBuffMiniIcon(arg_515_0, arg_515_1)
	return var_0_23({
		"icon/elderBoss/",
		arg_515_1,
		".png"
	})
end

function var_0_24.getElderBossPicById(arg_516_0, arg_516_1)
	return var_0_23({
		"pic/elderBoss/boss/pic_ljqs_boss_0",
		arg_516_1,
		".png"
	})
end

function var_0_24.getReleaseActivityPreviewBg(arg_517_0, arg_517_1)
	return var_0_23({
		"ui://release/pic_wxmy_zpyl",
		arg_517_1
	})
end

function var_0_24.getReleaseActivityTitle(arg_518_0, arg_518_1)
	return var_0_23({
		"ui://text_new/txt_wxmy_suo",
		arg_518_1
	})
end

function var_0_24.getOutpostMapPath(arg_519_0)
	return "maps/outpost/"
end

function var_0_24.getOutpostBuildIcon(arg_520_0, arg_520_1)
	return var_0_23({
		"ui_cocos/outpost/build/",
		arg_520_1,
		".png"
	})
end

function var_0_24.getOutpostEffectTween(arg_521_0, arg_521_1)
	return var_0_23({
		"battleOutpost/tween/",
		arg_521_1
	})
end

function var_0_24.getOutpostEffectSpine(arg_522_0, arg_522_1)
	return var_0_23({
		"battleOutpost/effect_spine/",
		arg_522_1,
		"/",
		arg_522_1
	})
end

function var_0_24.getOutpostItemQualityBg(arg_523_0, arg_523_1)
	return var_0_23({
		"ui://outpost/pic_hxsz_pinzhi",
		arg_523_1
	})
end

function var_0_24.getQualityLineByQuality(arg_524_0, arg_524_1)
	return var_0_23({
		"ui://outpost/pic_hxsz_dztzpz",
		arg_524_1
	})
end

function var_0_24.getOutpostItemIcon(arg_525_0, arg_525_1, arg_525_2)
	if arg_525_2 then
		return var_0_23({
			"icon/miniOutpostItem/",
			arg_525_1,
			".png"
		})
	else
		return var_0_23({
			"icon/outpostItem/",
			arg_525_1,
			".png"
		})
	end
end

function var_0_24.getOutpostItemBigIcon(arg_526_0, arg_526_1)
	return var_0_23({
		"icon/bigOutpostItem/",
		arg_526_1,
		".png"
	})
end

function var_0_24.getOutpostEquipIcon(arg_527_0, arg_527_1)
	return var_0_23({
		"icon/outpostEquip/",
		arg_527_1,
		".png"
	})
end

function var_0_24.getOutpostEquipBookIcon(arg_528_0, arg_528_1)
	return var_0_23({
		"icon/outpostEquipBook/",
		arg_528_1,
		".png"
	})
end

function var_0_24.getOutpostSmallBuildIcon(arg_529_0, arg_529_1)
	return var_0_23({
		"icon/outpostBuild/",
		arg_529_1,
		".png"
	})
end

function var_0_24.getOutpostTxtSlot(arg_530_0, arg_530_1)
	return var_0_23({
		"ui_cocos/outpost/txtSlot/",
		arg_530_1,
		".png"
	})
end

function var_0_24.getDomainSlotIcon(arg_531_0, arg_531_1, arg_531_2, arg_531_3)
	local var_531_0 = tostring(arg_531_2)

	if arg_531_3 then
		var_531_0 = var_531_0 .. "_1"
	end

	return var_0_23({
		"icon/domain/",
		arg_531_1,
		"/",
		var_531_0,
		".png"
	})
end

function var_0_24.getAncientsTeamIconByNum(arg_532_0, arg_532_1)
	return "pic/ancients/pic_wxlj_0" .. arg_532_1 .. ".png"
end

function var_0_24.getAncientsTeamBoxIcon(arg_533_0, arg_533_1)
	return "pic/ancients/iocn_wxlj_baoxiang_0" .. arg_533_1 .. ".png"
end

function var_0_24.getAncientsDicePointRes(arg_534_0, arg_534_1)
	return "pic/ancients/pic_wxlj_dice_0" .. arg_534_1 .. ".png"
end

function var_0_24.getAncientsBattlePetRes(arg_535_0, arg_535_1)
	return "pic/ancients/pic_wxlj_shenshou" .. arg_535_1 .. ".png"
end

function var_0_24.getAncientsGuessPetRes(arg_536_0, arg_536_1)
	return "pic/ancients/pic_shenshou" .. arg_536_1 .. ".png"
end

function var_0_24.getLeaderCurtain(arg_537_0, arg_537_1)
	return var_0_23({
		"icon/leader_curtain/",
		arg_537_1,
		".png"
	})
end

function var_0_24.getProfessionBg(arg_538_0, arg_538_1)
	return var_0_23({
		"ui://knightBag/pic_jsdwdi0",
		arg_538_1
	})
end

return var_0_24
