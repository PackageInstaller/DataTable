---@class UISheets
local UISheets = { 
		UI_Battle = {
			path = 'Audio/UI_Battle',
			ui_battle_enemy_01 = 'ui_battle_enemy_01',
			ui_battle_enemy_02 = 'ui_battle_enemy_02',
			ui_battle_gulp = 'ui_battle_gulp',
			ui_battle_select = 'ui_battle_select',
			ui_battle_tips = 'ui_battle_tips',
			ui_skill_card_fusion_01 = 'ui_skill_card_fusion_01',
			ui_skill_card_fusion_02 = 'ui_skill_card_fusion_02',
			ui_skill_card_fusion_03 = 'ui_skill_card_fusion_03',
			ui_skill_card_fusion_04 = 'ui_skill_card_fusion_04',
			ui_skill_card_fusion_05 = 'ui_skill_card_fusion_05',
			ui_skill_card_move = 'ui_skill_card_move',
			ui_skill_card_renew = 'ui_skill_card_renew',
			ui_skill_card_use = 'ui_skill_card_use',
			ui_battle_cuting = "ui_battle_cuting",
			ui_battle_find = "ui_battle_find",
			ui_battle_choice = "ui_battle_choice",
			ui_battle_attribute = "ui_battle_attribute",
			ui_battle_start = "ui_battle_start",
			ui_battle_order = "ui_battle_order",
			ui_battle_deadly = "ui_battle_deadly",
		},
		UI_Click = {
			path = "Audio/sfx_main",
			sfx_main_click = "sfx_main_click",
		},
		UI_Menu = {
			path = 'Audio/UI_Menu',
			ui_achievement_get = 'ui_achievement_get',
			ui_animation_card_draw_base = 'ui_animation_card_draw_base',
			ui_animation_card_draw_ssr = 'ui_animation_card_draw_ssr',
			ui_award_get = 'ui_award_get',
			ui_battle_begin = 'ui_battle_begin',
			ui_card_draw_appear_base = 'ui_card_draw_appear_base',
			ui_card_draw_appear_ssr = 'ui_card_draw_appear_ssr',
			ui_card_draw_one = 'ui_card_draw_one',
			ui_card_draw_ten = 'ui_card_draw_ten',
			ui_card_get = 'ui_card_get',
			ui_continuity_down = 'ui_continuity_down',
			ui_continuity_up = 'ui_continuity_up',
			ui_directional_change = 'ui_directional_change',
			ui_graffiti_change = 'ui_graffiti_change',
			ui_graffiti_open = 'ui_graffiti_open',
			ui_jump_cat = 'ui_jump_cat',
			ui_keystroke_change = 'ui_keystroke_change',
			ui_keystroke_choice = 'ui_keystroke_choice',
			ui_keystroke_false = 'ui_keystroke_false',
			ui_keystroke_true = 'ui_keystroke_true',
			ui_mail_change = 'ui_mail_change',
			ui_patrol_change = 'ui_patrol_change',
			ui_patrol_choice = 'ui_patrol_choice',
			ui_player_level_up = 'ui_player_level_up',
			ui_shop_buy = 'ui_shop_buy',
			ui_shop_change = 'ui_shop_change',
			ui_shop_enter_one = 'ui_shop_enter_one',
			ui_shop_enter_two = 'ui_shop_enter_two',
			ui_shop_refresh = 'ui_shop_refresh',
			ui_strength_animation = 'ui_strength_animation',
			ui_supply_change = 'ui_supply_change',
			ui_world_boss_article = 'ui_world_boss_article',
			ui_menu_click = 'ui_menu_click',
			ui_button_share = 'ui_button_share',
			ui_button_supply = 'ui_button_supply',

			ui_liebiao = "ui_liebiao",
			ui_huadong = "ui_huadong",
			ui_shengji = "ui_shengji",
			ui_shengxing = "ui_shengxing",
			ui_juexing = "ui_juexing",
			ui_anzhuang = "ui_anzhuang",
			ui_jihuo = "ui_jihuo",
			ui_chixu = "ui_chixu",
			ui_zhuangbei = "ui_zhuangbei",
			ui_gongming = "ui_gongming",
			ui_juesejihuo = "ui_juesejihuo",

			ui_peidui = "ui_peidui",
			ui_huode = "ui_huode",
			ui_xunlian = "ui_xunlian",
			ui_jinhua = "ui_jinhua",
			ui_manghehuode = "ui_manghehuode",
			ui_zhuaqi = "ui_zhuaqi",
			ui_tingliu_weichengnian = "ui_tingliu_weichengnian",
			ui_tingliu_chengnian = "ui_tingliu_chengnian",
			ui_fangxia = "ui_fangxia",
		},

		SFX_Fishing = {
			path = 'Audio/SFX_Fishing',
			fishing_throw_ready = "fishing_throw_ready",
			fishing_throw_normal = "fishing_throw_normal",
			fishing_throw_good = "fishing_throw_good",
			fishing_throw_perfect = "fishing_throw_perfect",
			fishing_bait = "fishing_bait",
			fishing_water_small = "fishing_water_small",
			fishing_water_big = "fishing_water_big",
			fishing_pull_rod = "fishing_pull_rod",
			fishing_end = "fishing_end",
			fishing_get_fish = "fishing_get_fish",
			fishing_stringless = "fishing_stringless",
			fishing_fit_rod = "fishing_fit_rod",
			fishing_fit_wheel = "fishing_fit_wheel",
			fishing_fit_line = "fishing_fit_line",
			fishing_fit_bait = "fishing_fit_bait",

			fishing_pingji_s = "fishing_pingji_s",
			fishing_chushui = "fishing_chushui",
			fishing_jinbi = "fishing_jinbi",
		},
		
		SFX_Function_Canteen = {
			path = 'Audio/sfx_function_canteen',
			ui_restaurant_purr = "ui_restaurant_purr",
		},
		
		SFX_UI_SE = {
			path = 'Audio/sfx_ui_se',
			ui_se_card_upgrade = "ui_se_card_upgrade",---	升级角色卡牌UI界面音效
			ui_se_card_up_quality_TL = "ui_se_card_upquality_TL",---	升阶角色动画的音效
			ui_se_card_up_quality_TL_UR = "ui_se_card_upquality_TL_UR",---	升阶角色动画的音效
			ui_se_card_up_quality_success = "ui_se_card_upquality_success",---	升阶动画最后升阶成功界面音效
			ui_se_card_up_star_TL = "ui_se_card_upstar_TL",---	升星动画的音效
			ui_se_skill = "ui_se_skill",---	技能升级成功界面音效
			ui_se_equip_upgrade = "ui_se_equip_upgrade",---	装备升级
			ui_se_equip_up_star = "ui_se_equip_upstar",---	装备升星
			ui_se_love_gift = "ui_se_love_gift",---	好感度送礼音效
			ui_se_love_upgrade = "ui_se_love_upgrade",---	好感度升级界面音效
		},

		SFX_UI_CAT = {
			path = 'Audio/sfx_ui_cat',
			sfx_ui_cat_gachapon = "sfx_ui_cat_gachapon",---	猫球抽卡
			sfx_ui_cat_starup = "sfx_ui_cat_starup",---	猫球升星成功音效
			
		},
		
		SFX_WEAPON = {
			path = 'Audio/sfx_weapon',
			sfx_weapon_draw = "sfx_weapon_draw"
		},

		SFX_TAKEOUT = {
			path = 'Audio/sfx_takeout',
			sfx_takeout_unlock = "sfx_takeout_unlock",---	功能解锁
			
		},

		SFX_COOKING = {
			path = 'Audio/sfx_cooking',
			sfx_cooking_food = "sfx_cooking_food",
			sfx_cooking_sell = "sfx_cooking_sell",
			sfx_cooking_error = "sfx_cooking_error",
			sfx_cooking_finish = "sfx_cooking_finish"
		}

}
return UISheets