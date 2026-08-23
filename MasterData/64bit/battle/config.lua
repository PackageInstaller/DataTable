CLIENT = 1
SERVER = 2
BATTLE_PLATFORM = CLIENT
BATTLE_CONFIG_TYPE = {
	isOs = false,
	config = {}
}

for iter_0_0, iter_0_1 in pairs({
	palace_altar_info = "palace_altar_info_os",
	knight_base_info = "knight_base_info_os",
	recruit_knight_info = "recruit_knight_info_os",
	knight_info = "knight_info_os",
	recruit_knight_preview_info = "recruit_knight_preview_info_os",
	palace_build_info = "palace_build_info_os",
	recruit_knight_bottom_info = "recruit_knight_bottom_info_os",
	palace_compose_info = "palace_compose_info_os",
	title_info = "title_info_os",
	furniture_book_info = "furniture_book_info_os",
	furniture_info = "furniture_info_os",
	avatar_frame_info = "avatar_frame_info_os",
	shop_score_info = "shop_score_info_os",
	pet_info = "pet_info_os",
	unite_token_info = "unite_token_info_os",
	new_slg_main_city_authority_info = "new_slg_main_city_authority_info_os",
	new_slg_team_authority_info = "new_slg_team_authority_info_os",
	battle_extra_value_info = "battle_extra_value_info_os",
	play_info = "play_info_os",
	skill_mark_info = "skill_mark_info_os",
	skill_enchant_info = "skill_enchant_info_os",
	skill_special_effect_info = "skill_special_effect_info_os",
	buff_info = "buff_info_os",
	passive_skill_info = "passive_skill_info_os",
	skill_info = "skill_info_os",
	avata_info = "avata_info_os",
	skin_shop_info = "skin_shop_info_os",
	skin_info = "skin_info_os",
	wedding_vow_info = "wedding_vow_info_os",
	artifact_compose_advanced_info = "artifact_compose_advanced_info_os",
	place_compose_info = "place_compose_info_os",
	source_type_info = "source_type_info_os",
	artifact_compose_info = "artifact_compose_info_os",
	artifact_info = "artifact_info_os",
	knight_book_info = "knight_book_info_os",
	fragment_info = "fragment_info_os"
}) do
	BATTLE_CONFIG_TYPE.config[iter_0_0] = iter_0_1
	BATTLE_CONFIG_TYPE.config["core.config.cfg." .. iter_0_0] = "core.config.cfg." .. iter_0_1
end
