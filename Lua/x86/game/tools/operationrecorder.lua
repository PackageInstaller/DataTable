local var_0_0 = {}

function var_0_0.Record(arg_1_0, arg_1_1)
	if arg_1_0 == "MainHomeView" and arg_1_1 == "message" then
		var_0_0.send("info", "info_open")
	elseif arg_1_0 == "UserInfoView" and arg_1_1 == "btn_copy" then
		var_0_0.send("info", "info_copy")
	elseif arg_1_0 == "userinfo" and arg_1_1 == "backBtn" then
		var_0_0.send("info", "info_back")
	elseif arg_1_0 == "userinfo" and arg_1_1 == "homeBtn" then
		var_0_0.send("info", "info_home")
	elseif arg_1_0 == "UserInfoView" and arg_1_1 == "btn_change_name" then
		var_0_0.send("name_change", "changename_open")
	elseif arg_1_0 == "" and arg_1_1 == "" then
		var_0_0.send("name_change", "changename_type")
	elseif arg_1_0 == "ChangeNameView" and arg_1_1 == "okBtn" then
		var_0_0.send("name_change", "change_name_confirm")
	elseif arg_1_0 == "ChangeNameView" and arg_1_1 == "cancelBtn" then
		var_0_0.send("name_change", "change_name_cancel")
	elseif arg_1_0 == "UserInfoView" and arg_1_1 == "btn_gift" then
		var_0_0.send("gift", "gift_open")
	elseif arg_1_0 == "" and arg_1_1 == "" then
		var_0_0.send("gift", "gift_type")
	elseif arg_1_0 == "GiftPopUpView" and arg_1_1 == "okBtn" then
		var_0_0.send("gift", "gift_comfirm")
	elseif arg_1_0 == "GiftPopUpView" and arg_1_1 == "cancelBtn" then
		var_0_0.send("gift", "gift_cancel")
	elseif arg_1_0 == "UserInfoView" and arg_1_1 == "btn_logout" then
		var_0_0.send("account_change", "account_change_open")
	elseif arg_1_0 == "account_change" and arg_1_1 == "account_change_confirm" then
		var_0_0.send("account_change", "account_change_confirm")
	elseif arg_1_0 == "account_change" and arg_1_1 == "account_change_cancel" then
		var_0_0.send("account_change", "account_change_cancel")
	elseif arg_1_0 == "MainHomeView" and arg_1_1 == "btn_gift" then
		var_0_0.send("sign", "sign_open")
	elseif arg_1_0 == "sign" and arg_1_1 == "sign_type" then
		var_0_0.send("sign", "sign_type")
	elseif arg_1_0 == "SevenSignItem" and arg_1_1 == "signItem" then
		var_0_0.send("sign", "sign_item")
	elseif arg_1_0 == "home/activity" and arg_1_1 == "popSourceItem_sourceBtn" then
		var_0_0.send("sign", "sign_itemsource")
	elseif arg_1_0 == "home/activity" and arg_1_1 == "jump" then
		var_0_0.send("sign", "sign_redirct")
	elseif arg_1_0 == "MainHomeView" and arg_1_1 == "btn_setting" then
		var_0_0.send("setting", "setting_open")
	elseif arg_1_0 == "MainHomeView" and arg_1_1 == "btn_setting" then
		var_0_0.send("setting", "setting_display")
	elseif arg_1_0 == "SettingView" and arg_1_1 == "switch_page_sound" then
		var_0_0.send("setting", "setting_audio")
	elseif arg_1_0 == "SettingView" and arg_1_1 == "switch_page_game" then
		var_0_0.send("setting", "setting_game")
	elseif arg_1_0 == "GraphicSettingView" and arg_1_1 == "setting_switch_toggle" then
		var_0_0.send("setting", "rank")
	elseif arg_1_0 == "GraphicSettingView" and arg_1_1 == "fps1" then
		var_0_0.send("setting", "setting_fps")
	elseif arg_1_0 == "GraphicSettingView" and arg_1_1 == "fps2" then
		var_0_0.send("setting", "setting_fps")
	elseif arg_1_0 == "GraphicSettingView" and arg_1_1 == "resolution3" then
		var_0_0.send("setting", "setting_dpi")
	elseif arg_1_0 == "GraphicSettingView" and arg_1_1 == "resolution1" then
		var_0_0.send("setting", "setting_dpi")
	elseif arg_1_0 == "GraphicSettingView" and arg_1_1 == "resolution2" then
		var_0_0.send("setting", "setting_dpi")
	elseif arg_1_0 == "GraphicSettingView" and arg_1_1 == "teammate1" then
		var_0_0.send("setting", "setting_teammate_effect_")
	elseif arg_1_0 == "GraphicSettingView" and arg_1_1 == "teammate2" then
		var_0_0.send("setting", "setting_teammate_effect_")
	elseif arg_1_0 == "GraphicSettingView" and arg_1_1 == "teammate3" then
		var_0_0.send("setting", "setting_teammate_effect_")
	elseif arg_1_0 == "GraphicSettingView" and arg_1_1 == "btn_user1" then
		var_0_0.send("setting", "setting_user_effect_")
	elseif arg_1_0 == "GraphicSettingView" and arg_1_1 == "btn_user2" then
		var_0_0.send("setting", "setting_user_effect_")
	elseif arg_1_0 == "GraphicSettingView" and arg_1_1 == "btn_user3" then
		var_0_0.send("setting", "setting_user_effect_")
	elseif arg_1_0 == "GraphicSettingView" and arg_1_1 == "antialias" then
		var_0_0.send("setting", "setting_aa")
	elseif arg_1_0 == "GraphicSettingView" and arg_1_1 == "reflect" then
		var_0_0.send("setting", "setting_reflect")
	elseif arg_1_0 == "GraphicSettingView" and arg_1_1 == "hdr" then
		var_0_0.send("setting", "setting_HDR")
	elseif arg_1_0 == "SoundSettingView" and arg_1_1 == "cut0" then
		var_0_0.send("setting", "setting_audio_change")
	elseif arg_1_0 == "SoundSettingView" and arg_1_1 == "add0" then
		var_0_0.send("setting", "setting_audio_change")
	elseif arg_1_0 == "setting" and arg_1_1 == "setting_audio_slide" then
		var_0_0.send("setting", "setting_audio_slide")
	elseif arg_1_0 == "GameSettingView" and arg_1_1 == "switch1" then
		var_0_0.send("setting", "setting_selfdamage")
	elseif arg_1_0 == "GameSettingView" and arg_1_1 == "switch2" then
		var_0_0.send("setting", "setting_tmdamage")
	elseif arg_1_0 == "setting" and arg_1_1 == "setting_lock" then
		var_0_0.send("setting", "setting_lock")
	elseif arg_1_0 == "SettingView" and arg_1_1 == "btn_reset" then
		var_0_0.send("setting", "setting_reset")
	elseif arg_1_0 == "SettingView" and arg_1_1 == "btn_save" then
		var_0_0.send("setting", "setting_save")
	elseif arg_1_0 == "setting" and arg_1_1 == "backBtn" then
		var_0_0.send("setting", "setting_back")
	elseif arg_1_0 == "setting" and arg_1_1 == "homeBtn" then
		var_0_0.send("setting", "setting_home")
	elseif arg_1_0 == "MainHomeView" and arg_1_1 == "btn_Internal_test" then
		var_0_0.send("test_activity", "test_open")
	elseif arg_1_0 == "AlphaActivityView" and arg_1_1 == "rightBtn" then
		var_0_0.send("test_activity", "test_stage")
	elseif arg_1_0 == "AlphaActivityView" and arg_1_1 == "leftBtn" then
		var_0_0.send("test_activity", "test_stage")
	elseif arg_1_0 == "AlphaTaskItem" and arg_1_1 == "receiveBtn" then
		var_0_0.send("test_activity", "test_get_award")
	elseif arg_1_0 == "AlphaTaskItem" and arg_1_1 == "goBtn" then
		var_0_0.send("test_activity", "test_redirct")
	elseif arg_1_0 == "" and arg_1_1 == "" then
		var_0_0.send("test_activity", "test_slide")
	elseif arg_1_0 == "test_activity" and arg_1_1 == "test_item" then
		var_0_0.send("test_activity", "test_item")
	elseif arg_1_0 == "AlphaActivityView" and arg_1_1 == "backBtn" then
		var_0_0.send("test_activity", "test_back")
	elseif arg_1_0 == "AlphaActivityView" and arg_1_1 == "homeBtn" then
		var_0_0.send("test_activity", "test_home")
	elseif arg_1_0 == "MainHomeView" and arg_1_1 == "btn_task" then
		var_0_0.send("task", "task_open")
	elseif arg_1_0 == "TaskSwitchView" and arg_1_1 == "plotTask" then
		var_0_0.send("task", "task_story")
	elseif arg_1_0 == "TaskDailyItemView" and arg_1_1 == "goBtn" then
		var_0_0.send("task", "task_redirct")
	elseif arg_1_0 == "TaskDailyGiftItem" and arg_1_1 == "giftBtn" then
		var_0_0.send("task", "task_activity")
	elseif arg_1_0 == "task" and arg_1_1 == "task_item" then
		var_0_0.send("task", "task_item")
	elseif arg_1_0 == "TaskDailyItemView" and arg_1_1 == "receiveBtn" then
		var_0_0.send("task", "task_get_award")
	elseif arg_1_0 == "TaskDailyContentView" and arg_1_1 == "receiveBtn_all" then
		var_0_0.send("task", "task_get_award_byonce")
	elseif arg_1_0 == "task" and arg_1_1 == "backBtn" then
		var_0_0.send("task", "task_back")
	elseif arg_1_0 == "task" and arg_1_1 == "homeBtn" then
		var_0_0.send("task", "task_home")
	elseif arg_1_0 == "MainHomeView" and arg_1_1 == "btn_draw" then
		var_0_0.send("draw", "draw_open")
	elseif arg_1_0 == "DrawView" and arg_1_1 == "10001" then
		var_0_0.send("draw", "draw_hero")
	elseif arg_1_0 == "DrawView" and arg_1_1 == "10002" then
		var_0_0.send("draw", "draw_spirit")
	elseif arg_1_0 == "DrawView" and arg_1_1 == "btn_info" then
		var_0_0.send("draw", "draw_detail")
	elseif arg_1_0 == "DrawView" and arg_1_1 == "btn_record" then
		var_0_0.send("draw", "draw_record")
	elseif arg_1_0 == "DrawServantPool" and arg_1_1 == "replaceBtn" then
		var_0_0.send("draw", "draw_spirit_type")
	elseif arg_1_0 == "DrawServantSelectItem" and arg_1_1 == "btnrenewal" then
		var_0_0.send("draw", "draw_type_change")
	elseif arg_1_0 == "DrawServantSelectItem" and arg_1_1 == "btnlook1" then
		var_0_0.send("draw", "draw_type_detail")
	elseif arg_1_0 == "DrawServantSelectView" and arg_1_1 == "btnrenewal" then
		var_0_0.send("draw", "draw_type_confirm")
	elseif arg_1_0 == "DrawView" and arg_1_1 == "btn_one" then
		var_0_0.send("draw", "draw_once")
	elseif arg_1_0 == "DrawView" and arg_1_1 == "btn_ten" then
		var_0_0.send("draw", "draw_ten_times")
	elseif arg_1_0 == "draw" and arg_1_1 == "backBtn" then
		var_0_0.send("draw", "draw_back")
	elseif arg_1_0 == "draw" and arg_1_1 == "homeBtn" then
		var_0_0.send("draw", "draw_home")
	elseif arg_1_0 == "home_WindowCurrencyItem" and arg_1_1 == "dundunzhi" then
		var_0_0.send("exchange", "dundun_open")
	elseif arg_1_0 == "exchange" and arg_1_1 == "dundun_material" then
		var_0_0.send("exchange", "dundun_material")
	elseif arg_1_0 == "exchange" and arg_1_1 == "dundun_coolant_type" then
		var_0_0.send("exchange", "dundun_coolant_type")
	elseif arg_1_0 == "CurrencyBuyGoldView" and arg_1_1 == "addBtn0" then
		var_0_0.send("exchange", "dundun_coolant_number")
	elseif arg_1_0 == "CurrencyBuyGoldView" and arg_1_1 == "delBtn0" then
		var_0_0.send("exchange", "dundun_coolant_number")
	elseif arg_1_0 == "exchange" and arg_1_1 == "dundun_coolant_slide" then
		var_0_0.send("exchange", "dundun_coolant_slide")
	elseif arg_1_0 == "home_WindowCurrencyItem" and arg_1_1 == "laidebi" then
		var_0_0.send("exchange", "goldcoin_open")
	elseif arg_1_0 == "exchange" and arg_1_1 == "goldcoin_material" then
		var_0_0.send("exchange", "goldcoin_material")
	elseif arg_1_0 == "exchange" and arg_1_1 == "goldcoin_bond_type" then
		var_0_0.send("exchange", "goldcoin_bond_type")
	elseif arg_1_0 == "CurrencyBuyGoldView" and arg_1_1 == "addBtn0" then
		var_0_0.send("exchange", "goldcoin_bond_number")
	elseif arg_1_0 == "CurrencyBuyGoldView" and arg_1_1 == "delBtn0" then
		var_0_0.send("exchange", "goldcoin_bond_number")
	elseif arg_1_0 == "exchange" and arg_1_1 == "goldcoin_bond_slide" then
		var_0_0.send("exchange", "goldcoin_bond_slide")
	elseif arg_1_0 == "home_WindowCurrencyItem" and arg_1_1 == "hongjing" then
		var_0_0.send("exchange", "diamond")
	elseif arg_1_0 == "MainHomeView" and arg_1_1 == "btn_shop" then
		var_0_0.send("shop", "shop_open")
	elseif arg_1_0 == "shop" and arg_1_1 == "shop_intel" then
		var_0_0.send("shop", "shop_intel")
	elseif arg_1_0 == "shop" and arg_1_1 == "shop_stock_up" then
		var_0_0.send("shop", "shop_stock_up")
	elseif arg_1_0 == "shop" and arg_1_1 == "shop_equip" then
		var_0_0.send("shop", "shop_equip")
	elseif arg_1_0 == "shop" and arg_1_1 == "shop_divine" then
		var_0_0.send("shop", "shop_divine")
	elseif arg_1_0 == "shop" and arg_1_1 == "shop_voucher" then
		var_0_0.send("shop", "shop_voucher")
	elseif arg_1_0 == "shop" and arg_1_1 == "shop_secret" then
		var_0_0.send("shop", "shop_secret")
	elseif arg_1_0 == "shop" and arg_1_1 == "shop_rouge" then
		var_0_0.send("shop", "shop_rouge")
	elseif arg_1_0 == "shop" and arg_1_1 == "shop_equip_star" then
		var_0_0.send("shop", "shop_equip_star")
	elseif arg_1_0 == "" and arg_1_1 == "" then
		var_0_0.send("shop", "shop_equip_set")
	elseif arg_1_0 == "" and arg_1_1 == "" then
		var_0_0.send("shop", "shop_equip_location")
	elseif arg_1_0 == "shop" and arg_1_1 == "shop_equip_all" then
		var_0_0.send("shop", "shop_equip_all")
	elseif arg_1_0 == "shop" and arg_1_1 == "shop_equip_one" then
		var_0_0.send("shop", "shop_equip_one")
	elseif arg_1_0 == "NewShopView" and arg_1_1 == "fresh" then
		var_0_0.send("shop", "shop_divine_refresh")
	elseif arg_1_0 == "shop" and arg_1_1 == "okRefresh" then
		var_0_0.send("shop", "shop_refresh_confirm")
	elseif arg_1_0 == "shop" and arg_1_1 == "cancelRefresh" then
		var_0_0.send("shop", "shop_refresh_cancel")
	elseif arg_1_0 == "shop" and arg_1_1 == "toggle" then
		var_0_0.send("shop", "shop_refresh_nosign")
	elseif arg_1_0 == "ShopItemView" and arg_1_1 == "ExplaintBut" then
		var_0_0.send("shop", "shop_item_detail")
	elseif arg_1_0 == "shop" and arg_1_1 == "PopItemView" then
		var_0_0.send("shop", "shop_source")
	elseif arg_1_0 == "shop" and arg_1_1 == "popSourceItem_sourceBtn" then
		var_0_0.send("shop", "shop_redirct")
	elseif arg_1_0 == "ShopItemView" and arg_1_1 == "shopItemPrefab(Clone)" then
		var_0_0.send("shop", "shop_item_buy")
	elseif arg_1_0 == "ShopBuyView" and arg_1_1 == "addBtn0" then
		var_0_0.send("shop", "shop_number")
	elseif arg_1_0 == "ShopBuyView" and arg_1_1 == "delBtn0" then
		var_0_0.send("shop", "shop_number")
	elseif arg_1_0 == "shop" and arg_1_1 == "shop_number_slide" then
		var_0_0.send("shop", "shop_number_slide")
	elseif arg_1_0 == "ShopBuyView" and arg_1_1 == "btn_ok" then
		var_0_0.send("shop", "shop_buy_confirm")
	elseif arg_1_0 == "NewShopView" and arg_1_1 == "heroPieceExchangeBtn" then
		var_0_0.send("shop", "shop_intel_exchange")
	elseif arg_1_0 == "FragmentExchangeView" and arg_1_1 == "okBtn" then
		var_0_0.send("shop", "shop_intel_exchange_confirm")
	elseif arg_1_0 == "FragmentExchangeView" and arg_1_1 == "cancelBtn" then
		var_0_0.send("shop", "shop_intel_exchange_cacel")
	elseif arg_1_0 == "shop_WindowCurrencyItem" then
		var_0_0.send("shop", "shop_money_exchange")
	elseif arg_1_0 == "shop_WindowMaterialItem" then
		var_0_0.send("shop", "shop_money_exchange")
	elseif arg_1_0 == "" and arg_1_1 == "" then
		var_0_0.send("shop", "shop_slide")
	elseif arg_1_0 == "shop" and arg_1_1 == "backBtn" then
		var_0_0.send("shop", "shop_back")
	elseif arg_1_0 == "shop" and arg_1_1 == "homeBtn" then
		var_0_0.send("shop", "shop_home")
	elseif arg_1_0 == "MainHomeView" and arg_1_1 == "btn_mail" then
		var_0_0.send("mail", "mail_open")
	elseif arg_1_0 == "MailBoxListItem" and arg_1_1 == "bg" then
		var_0_0.send("mail", "mail_select")
	elseif arg_1_0 == "MailBoxRewardItem" and arg_1_1 == "popItem" then
		var_0_0.send("mail", "mail_item")
	elseif arg_1_0 == "MailBoxView" and arg_1_1 == "receiveBtn" then
		var_0_0.send("mail", "mail_get_award")
	elseif arg_1_0 == "MailBoxView" and arg_1_1 == "removeBtn" then
		var_0_0.send("mail", "mail_delete")
	elseif arg_1_0 == "" and arg_1_1 == "" then
		var_0_0.send("mail", "mail_slide")
	elseif arg_1_0 == "MailBoxView" and arg_1_1 == "removeAllRead" then
		var_0_0.send("mail", "mail_delete_all")
	elseif arg_1_0 == "MailBoxView" and arg_1_1 == "receiveAllBtn" then
		var_0_0.send("mail", "mail_get_byonce")
	elseif arg_1_0 == "mailBox" and arg_1_1 == "backBtn" then
		var_0_0.send("mail", "mail_back")
	elseif arg_1_0 == "mailBox" and arg_1_1 == "homeBtn" then
		var_0_0.send("mail", "mail_home")
	elseif arg_1_0 == "MainHomeView" and arg_1_1 == "btn_chip" then
		var_0_0.send("ai", "ai_open")
	elseif arg_1_0 == "ChipManagerItem" then
		var_0_0.send("ai", "ai_select")
	elseif arg_1_0 == "ChipManagerLockView" and arg_1_1 == "upgradeBtn" then
		var_0_0.send("ai", "ai_unlock")
	elseif arg_1_0 == "ChipManagerUnlockView" and arg_1_1 == "upgradeBtn" then
		var_0_0.send("ai", "ai_use")
	elseif arg_1_0 == "" and arg_1_1 == "" then
		var_0_0.send("ai", "ai_slide")
	elseif arg_1_0 == "chipManager" and arg_1_1 == "pageDetail" then
		var_0_0.send("ai", "ai_detail")
	elseif arg_1_0 == "chipManager" and arg_1_1 == "pageStory" then
		var_0_0.send("ai", "ai_story")
	elseif arg_1_0 == "ChipManagerUnlockView" and arg_1_1 == "bth1" then
		var_0_0.send("ai", "module_type")
	elseif arg_1_0 == "ChipManagerUnlockView" and arg_1_1 == "bth2" then
		var_0_0.send("ai", "module_type")
	elseif arg_1_0 == "ChipItem" and arg_1_1 == "bg" then
		var_0_0.send("ai", "module_type_select")
	elseif arg_1_0 == "ChipInfoView" and arg_1_1 == "allType" then
		var_0_0.send("ai", "module_type_all")
	elseif arg_1_0 == "ChipInfoView" and arg_1_1 == "resetBtn" then
		var_0_0.send("ai", "module_type_reset")
	elseif arg_1_0 == "ChipInfoView" and arg_1_1 == "oneType" then
		var_0_0.send("ai", "module_select")
	elseif arg_1_0 == "ChipInfoView" and arg_1_1 == "upgradeBtn" then
		var_0_0.send("ai", "module_unlock")
	elseif arg_1_0 == "ChipInfoView" and arg_1_1 == "btn_go" then
		var_0_0.send("ai", "module_use")
	elseif arg_1_0 == "ChipInfoView" and arg_1_1 == "btn_unload" then
		var_0_0.send("ai", "module_use")
	elseif arg_1_0 == "ChipManagerUnlockView" and arg_1_1 == "btnpointers" then
		var_0_0.send("ai", "module_plan_open")
	elseif arg_1_0 == "ChipSchemeItem" and arg_1_1 == "btnsave" then
		var_0_0.send("ai", "module_plan_save")
	elseif arg_1_0 == "" and arg_1_1 == "" then
		var_0_0.send("ai", "module_plan_type")
	elseif arg_1_0 == "chipScheme" and arg_1_1 == "proposal_okBtn" then
		var_0_0.send("ai", "module_plan_name_confirm")
	elseif arg_1_0 == "chipScheme" and arg_1_1 == "proposal_cancelBtn" then
		var_0_0.send("ai", "module_plan_name_cancel")
	elseif arg_1_0 == "" and arg_1_1 == "" then
		var_0_0.send("ai", "module_plan_name_change")
	elseif arg_1_0 == "ChipSchemeItem" and arg_1_1 == "del" then
		var_0_0.send("ai", "module_plan_delete")
	elseif arg_1_0 == "ChipSchemeItem" and arg_1_1 == "okDelete" then
		var_0_0.send("ai", "module_plan_delete_confirm")
	elseif arg_1_0 == "ChipSchemeItem" and arg_1_1 == "cancelDelete" then
		var_0_0.send("ai", "module_plan_delete_confirm")
	elseif arg_1_0 == "ChipSchemeItem" and arg_1_1 == "btnrenewal" then
		var_0_0.send("ai", "module_plan_change")
	elseif arg_1_0 == "chipManager" and arg_1_1 == "backBtn" then
		var_0_0.send("ai", "ai_back")
	elseif arg_1_0 == "chipManager" and arg_1_1 == "homeBtn" then
		var_0_0.send("ai", "ai_home")
	elseif arg_1_0 == "chipInfo" and arg_1_1 == "backBtn" then
		var_0_0.send("ai", "ai_back")
	elseif arg_1_0 == "chipInfo" and arg_1_1 == "homeBtn" then
		var_0_0.send("ai", "ai_home")
	elseif arg_1_0 == "MainHomeView" and arg_1_1 == "btn_weaponServant" then
		var_0_0.send("spirit", "spirit_open")
	elseif arg_1_0 == "WeaponServantEnterView" and arg_1_1 == "listBth" then
		var_0_0.send("spirit", "spirit_list")
	elseif arg_1_0 == "WeaponServantEnterView" and arg_1_1 == "compoundBth" then
		var_0_0.send("spirit", "spirit_syn")
	elseif arg_1_0 == "WeaponServant" and arg_1_1 == "selectItem" then
		var_0_0.send("spirit", "spirit_select")
	elseif arg_1_0 == "" and arg_1_1 == "" then
		var_0_0.send("spirit", "spirit_slide")
	elseif arg_1_0 == "WeaponServantRaceDropdownView" and arg_1_1 == "equipDropdown" then
		var_0_0.send("spirit", "spirit")
	elseif arg_1_0 == "WeaponServantRaceDropdownView" and arg_1_1 == "one" then
		var_0_0.send("spirit", "spirit_camp_select")
	elseif arg_1_0 == "WeaponServantRaceDropdownView" and arg_1_1 == "all" then
		var_0_0.send("spirit", "spirit_camp_all")
	elseif arg_1_0 == "WeaponServantDetailView" and arg_1_1 == "lockBtn" then
		var_0_0.send("spirit", "spirit_lock")
	elseif arg_1_0 == "WeaponServantListView" and arg_1_1 == "promoteBtn" then
		var_0_0.send("spirit", "spirit_lv_up_open")
	elseif arg_1_0 == "WeaponServantListView" and arg_1_1 == "detailsBth" then
		var_0_0.send("spirit", "spirit_detail_open")
	elseif arg_1_0 == "WeaponServantView" and arg_1_1 == "detail" then
		var_0_0.send("spirit", "spirit_lvup_detail")
	elseif arg_1_0 == "WeaponServantView" and arg_1_1 == "story" then
		var_0_0.send("spirit", "spirit_story")
	elseif arg_1_0 == "WeaponServantView" and arg_1_1 == "upgrade" then
		var_0_0.send("spirit", "spirit_lvup_lv_up")
	elseif arg_1_0 == "WeaponServantView" and arg_1_1 == "addBtn" then
		var_0_0.send("spirit", "spirit_lvup_material_select")
	elseif arg_1_0 == "WeaponServantView" and arg_1_1 == "strength" then
		var_0_0.send("spirit", "spirit_lvup_confirm")
	elseif arg_1_0 == "WeaponServantMergeView" and arg_1_1 == "compoundBth" then
		var_0_0.send("spirit", "spirit_syn_confirm")
	elseif arg_1_0 == "weaponServantMerge" and arg_1_1 == "backBtn" then
		var_0_0.send("spirit", "spirit_back")
	elseif arg_1_0 == "weaponServantMerge" and arg_1_1 == "homeBtn" then
		var_0_0.send("spirit", "spirit_home")
	elseif arg_1_0 == "weaponServantEnter" and arg_1_1 == "backBtn" then
		var_0_0.send("spirit", "spirit_back")
	elseif arg_1_0 == "weaponServantEnter" and arg_1_1 == "homeBtn" then
		var_0_0.send("spirit", "spirit_home")
	elseif arg_1_0 == "weaponServant" and arg_1_1 == "backBtn" then
		var_0_0.send("spirit", "spirit_back")
	elseif arg_1_0 == "weaponServant" and arg_1_1 == "homeBtn" then
		var_0_0.send("spirit", "spirit_home")
	elseif arg_1_0 == "MainHomeView" and arg_1_1 == "btn_backPake" then
		var_0_0.send("warehouse", "wh_open")
	elseif arg_1_0 == "BagView" and arg_1_1 == "material" then
		var_0_0.send("warehouse", "wh_materials")
	elseif arg_1_0 == "BagView" and arg_1_1 == "qingbao" then
		var_0_0.send("warehouse", "wh_intel")
	elseif arg_1_0 == "BagView" and arg_1_1 == "equip" then
		var_0_0.send("warehouse", "wh_equip")
	elseif arg_1_0 == "BagView" and arg_1_1 == "gift" then
		var_0_0.send("warehouse", "wh_gift")
	elseif arg_1_0 == "BagView" and arg_1_1 == "suit" then
		var_0_0.send("warehouse", "wh_set")
	elseif arg_1_0 == "BagView" and arg_1_1 == "skills" then
		var_0_0.send("warehouse", "wh_skill")
	elseif arg_1_0 == "bag" and arg_1_1 == "operateAddBtn" then
		var_0_0.send("warehouse", "wh_item_number")
	elseif arg_1_0 == "bag" and arg_1_1 == "operateDelBtn" then
		var_0_0.send("warehouse", "wh_item_number")
	elseif arg_1_0 == "bag" and arg_1_1 == "operateEndDrag" then
		var_0_0.send("warehouse", "wh_item_slide")
	elseif arg_1_0 == "bag" and arg_1_1 == "operateUseBtn" then
		var_0_0.send("warehouse", "wh_item_use")
	elseif arg_1_0 == "PopItemMergeView" and arg_1_1 == "mergeBtn" then
		var_0_0.send("warehouse", "wh_syn_open")
	elseif arg_1_0 == "SynthesiseView" and arg_1_1 == "addBtn0" then
		var_0_0.send("warehouse", "wh_syn_number")
	elseif arg_1_0 == "SynthesiseView" and arg_1_1 == "delBtn0" then
		var_0_0.send("warehouse", "wh_syn_number")
	elseif arg_1_0 == "bag" and arg_1_1 == "mergeDrag" then
		var_0_0.send("warehouse", "wh_syn_slide")
	elseif arg_1_0 == "SynthesiseView" and arg_1_1 == "okBtn" then
		var_0_0.send("warehouse", "wh_syn_confirm")
	elseif arg_1_0 == "SynthesiseView" and arg_1_1 == "cancelBtn" then
		var_0_0.send("warehouse", "wh_syn_cancel")
	elseif arg_1_0 == "BagView" and arg_1_1 == "suitgt0" then
		var_0_0.send("warehouse", "wh_set_select")
	elseif arg_1_0 == "BagView" and arg_1_1 == "suit0" then
		var_0_0.send("warehouse", "wh_set_all")
	elseif arg_1_0 == "BagView" and arg_1_1 == "skillgt0" then
		var_0_0.send("warehouse", "wh_skill_select")
	elseif arg_1_0 == "BagView" and arg_1_1 == "skill0" then
		var_0_0.send("warehouse", "wh_skill_all")
	elseif arg_1_0 == "BagView" and arg_1_1 == "sortBtn" then
		var_0_0.send("warehouse", "whl_order")
	elseif arg_1_0 == "EquipDecomposeView" and arg_1_1 == "sortbut" then
		var_0_0.send("warehouse", "whl_order")
	elseif arg_1_0 == "BagView" and arg_1_1 == "sort_level" then
		var_0_0.send("warehouse", "wh_foster")
	elseif arg_1_0 == "BagView" and arg_1_1 == "sort_rare" then
		var_0_0.send("warehouse", "wh_star")
	elseif arg_1_0 == "EquipDecomposeView" and arg_1_1 == "starbut" then
		var_0_0.send("warehouse", "wh_foster")
	elseif arg_1_0 == "EquipDecomposeView" and arg_1_1 == "culturetbut" then
		var_0_0.send("warehouse", "wh_star")
	elseif arg_1_0 == "BagView" and arg_1_1 == "btn_decompose" then
		var_0_0.send("warehouse", "wh_delete_open")
	elseif arg_1_0 == "EquipDecomposeView" and arg_1_1 == "quick_select_star" then
		var_0_0.send("warehouse", "wh_delete_star")
	elseif arg_1_0 == "EquipDecomposeView" and arg_1_1 == "btn_decompose" then
		var_0_0.send("warehouse", "wh_delete_confirm")
	elseif arg_1_0 == "EquipDecomposeView" and arg_1_1 == "cancel" then
		var_0_0.send("warehouse", "wh_confirm_cancel")
	elseif arg_1_0 == "EquipDecomposeView" and arg_1_1 == "confirm" then
		var_0_0.send("warehouse", "wh_confirm_confirm")
	elseif arg_1_0 == "bag" and arg_1_1 == "PopItemView" then
		var_0_0.send("warehouse", "wh_item")
	elseif arg_1_0 == "equipDecompose" and arg_1_1 == "PopItemView" then
		var_0_0.send("warehouse", "wh_item")
	elseif arg_1_0 == "bag" and arg_1_1 == "popSourceItem_sourceBtn" then
		var_0_0.send("warehouse", "wh_itemsource")
	elseif arg_1_0 == "bag" and arg_1_1 == "jump" then
		var_0_0.send("warehouse", "wh_redirct")
	elseif arg_1_0 == "bag" and arg_1_1 == "backBtn" then
		var_0_0.send("warehouse", "wh_back")
	elseif arg_1_0 == "bag" and arg_1_1 == "homeBtn" then
		var_0_0.send("warehouse", "wh_home")
	elseif arg_1_0 == "equipDecompose" and arg_1_1 == "backBtn" then
		var_0_0.send("warehouse", "wh_back")
	elseif arg_1_0 == "equipDecompose" and arg_1_1 == "homeBtn" then
		var_0_0.send("warehouse", "wh_home")
	elseif arg_1_0 == "equip" and arg_1_1 == "detailView" then
		var_0_0.send("equip", "equip_detail")
	elseif arg_1_0 == "equip" and arg_1_1 == "strength" then
		var_0_0.send("equip", "equip_lv_up")
	elseif arg_1_0 == "equip" and arg_1_1 == "enabled" then
		var_0_0.send("equip", "equip_enchant")
	elseif arg_1_0 == "equip" and arg_1_1 == "reconstruct" then
		var_0_0.send("equip", "equip_reset")
	elseif arg_1_0 == "equip" and arg_1_1 == "lock" then
		var_0_0.send("equip", "equip_lock")
	elseif arg_1_0 == "equipCultureView/equipDetail" and arg_1_1 == "PopItemView" then
		var_0_0.send("equip", "equip_source")
	elseif arg_1_0 == "EquipEnchantMainView" and arg_1_1 == "skillEnchantPanel(Clone)" then
		var_0_0.send("equip", "enchant_hole")
	elseif arg_1_0 == "equip" and arg_1_1 == "enchantSelectMaterial" then
		var_0_0.send("equip", "enchant_material")
	elseif arg_1_0 == "EquipEnchantView" and arg_1_1 == "GrayableBtn" then
		var_0_0.send("equip", "enchant_open")
	elseif arg_1_0 == "EquipEnchantPreviewItem" and arg_1_1 == "choiceBth" then
		var_0_0.send("equip", "enchant_result_select")
	elseif arg_1_0 == "EquipEnchantPreviewItem" and arg_1_1 == "renounceBth" then
		var_0_0.send("equip", "enchant_result_giveup")
	elseif arg_1_0 == "EquipEnchantView" and arg_1_1 == "renounceBtn" then
		var_0_0.send("equip", "enchant_all_giveup")
	elseif arg_1_0 == "EquipRaceView" and arg_1_1 == "restructureBth" then
		var_0_0.send("equip", "reset_open")
	elseif arg_1_0 == "EquipRaceConfirmView" and arg_1_1 == "choiceBtn" then
		var_0_0.send("equip", "reset_select")
	elseif arg_1_0 == "equipCultureView/equipRaceView" and arg_1_1 == "PopItemView" then
		var_0_0.send("equip", "reset_item")
	elseif arg_1_0 == "equipCultureView/equipRaceView" and arg_1_1 == "popSourceItem_sourceBtn" then
		var_0_0.send("equip", "reset_itemsource")
	elseif arg_1_0 == "equipCultureView/equipRaceView" and arg_1_1 == "jump" then
		var_0_0.send("equip", "reset_redirct")
	elseif arg_1_0 == "equipCultureView/equipUpgradeView" and arg_1_1 == "PopItemView" then
		var_0_0.send("equip", "reset_item")
	elseif arg_1_0 == "equipCultureView/equipUpgradeView" and arg_1_1 == "popSourceItem_sourceBtn" then
		var_0_0.send("equip", "reset_itemsource")
	elseif arg_1_0 == "equipCultureView/equipUpgradeView" and arg_1_1 == "jump" then
		var_0_0.send("equip", "reset_redirct")
	elseif arg_1_0 == "equip" and arg_1_1 == "strengthSelectMaterial" then
		var_0_0.send("equip", "equip_lvup_material")
	elseif arg_1_0 == "equip" and arg_1_1 == "reduceMaterialNumber" then
		var_0_0.send("equip", "equip_lvup_material_dec")
	elseif arg_1_0 == "EquipStrengthView" and arg_1_1 == "quickSelect" then
		var_0_0.send("equip", "equip_lvup_quickly_select")
	elseif arg_1_0 == "EquipStrengthView" and arg_1_1 == "strengthenBtn" then
		var_0_0.send("equip", "equip_lvup_confirm")
	elseif arg_1_0 == "" and arg_1_1 == "" then
		var_0_0.send("equip", "equip_type")
	elseif arg_1_0 == "equip" and arg_1_1 == "equipSortLevel" then
		var_0_0.send("equip", "equip_type_foster")
	elseif arg_1_0 == "equip" and arg_1_1 == "equipSortRare" then
		var_0_0.send("equip", "equip_type_star")
	elseif arg_1_0 == "EquipStrengthView" and arg_1_1 == "sortBtn" then
		var_0_0.send("equip", "equip_order")
	elseif arg_1_0 == "equipStrengthView" and arg_1_1 == "backBtn" then
		var_0_0.send("equip", "equip_back")
	elseif arg_1_0 == "equipStrengthView" and arg_1_1 == "homeBtn" then
		var_0_0.send("equip", "equip_home")
	elseif arg_1_0 == "heroEquipBag" and arg_1_1 == "backBtn" then
		var_0_0.send("equip", "equip_back")
	elseif arg_1_0 == "heroEquipBag" and arg_1_1 == "homeBtn" then
		var_0_0.send("equip", "equip_home")
	elseif arg_1_0 == "equipDetail" and arg_1_1 == "backBtn" then
		var_0_0.send("equip", "equip_back")
	elseif arg_1_0 == "equipDetail" and arg_1_1 == "homeBtn" then
		var_0_0.send("equip", "equip_home")
	elseif arg_1_0 == "equipEnchantMainView" and arg_1_1 == "backBtn" then
		var_0_0.send("equip", "equip_back")
	elseif arg_1_0 == "equipEnchantMainView" and arg_1_1 == "homeBtn" then
		var_0_0.send("equip", "equip_home")
	elseif arg_1_0 == "equipRaceView" and arg_1_1 == "backBtn" then
		var_0_0.send("equip", "equip_back")
	elseif arg_1_0 == "equipRaceView" and arg_1_1 == "homeBtn" then
		var_0_0.send("equip", "equip_home")
	elseif arg_1_0 == "equipUpgradeView" and arg_1_1 == "backBtn" then
		var_0_0.send("equip", "equip_back")
	elseif arg_1_0 == "equipUpgradeView" and arg_1_1 == "homeBtn" then
		var_0_0.send("equip", "equip_home")
	elseif arg_1_0 == "MainHomeView" and arg_1_1 == "btn_goddess" then
		var_0_0.send("hero", "hero_open")
	elseif arg_1_0 == "hero" and arg_1_1 == "propertyPage" then
		var_0_0.send("hero", "hero_attribute")
	elseif arg_1_0 == "hero" and arg_1_1 == "skillPage" then
		var_0_0.send("hero", "hero_skill")
	elseif arg_1_0 == "hero" and arg_1_1 == "weaponPage" then
		var_0_0.send("hero", "hero_weapon")
	elseif arg_1_0 == "hero" and arg_1_1 == "equipPage" then
		var_0_0.send("hero", "hero_equip")
	elseif arg_1_0 == "hero" and arg_1_1 == "astroPage" then
		var_0_0.send("hero", "hero_astrolabe")
	elseif arg_1_0 == "NewHeroView" and arg_1_1 == "allHeroBtn" then
		var_0_0.send("hero", "hero_unfold")
	elseif arg_1_0 == "hero" and arg_1_1 == "selectHero" then
		var_0_0.send("hero", "hero_one")
	elseif arg_1_0 == "" and arg_1_1 == "" then
		var_0_0.send("hero", "hero_slide")
	elseif arg_1_0 == "HeroPropertyPage" and arg_1_1 == "upgradeBtn" then
		var_0_0.send("hero", "hero_lvup_open")
	elseif arg_1_0 == "hero" and arg_1_1 == "selectMaterialItem" then
		var_0_0.send("hero", "hero_lvup_material")
	elseif arg_1_0 == "NewHeroAddExpView" and arg_1_1 == "addBtn0" then
		var_0_0.send("hero", "hero_lvup_number")
	elseif arg_1_0 == "NewHeroAddExpView" and arg_1_1 == "delBtn0" then
		var_0_0.send("hero", "hero_lvup_number")
	elseif arg_1_0 == "hero" and arg_1_1 == "materialStopDrag" then
		var_0_0.send("hero", "hero_lvup_slide")
	elseif arg_1_0 == "NewHeroAddExpView" and arg_1_1 == "okBtn" then
		var_0_0.send("hero", "hero_lvup_confirm")
	elseif arg_1_0 == "NewHeroAddExpView" and arg_1_1 == "cancelBtn" then
		var_0_0.send("hero", "hero_lvup_cancel")
	elseif arg_1_0 == "HeroPropertyPage" and arg_1_1 == "surpassBtn" then
		var_0_0.send("hero", "hero_starup_open")
	elseif arg_1_0 == "HeroSurpassItem" then
		var_0_0.send("hero", "hero_starup_plan")
	elseif arg_1_0 == "NewHeroAddExpView" and arg_1_1 == "upgradeBtn" then
		var_0_0.send("hero", "hero_starup_confirm")
	elseif arg_1_0 == "newHero/newBreak" and arg_1_1 == "PopItemView" then
		var_0_0.send("hero", "hero_break_review")
	elseif arg_1_0 == "HeroPropertyPage" and arg_1_1 == "breakBtn" then
		var_0_0.send("hero", "hero_break_open")
	elseif arg_1_0 == "NewHeroBreakView" and arg_1_1 == "cancelBtn" then
		var_0_0.send("hero", "hero_break_cancel")
	elseif arg_1_0 == "NewHeroBreakView" and arg_1_1 == "okBtn" then
		var_0_0.send("hero", "hero_break_confirm")
	elseif arg_1_0 == "HeroPropertyPage" and arg_1_1 == "archiveBtn" then
		var_0_0.send("hero", "hero_detail_open")
	elseif arg_1_0 == "hero" and arg_1_1 == "archiveMessage" then
		var_0_0.send("hero", "hero_info")
	elseif arg_1_0 == "hero" and arg_1_1 == "archiveArchive" then
		var_0_0.send("hero", "hero_record")
	elseif arg_1_0 == "hero" and arg_1_1 == "archiveGift" then
		var_0_0.send("hero", "hero_gift")
	elseif arg_1_0 == "hero" and arg_1_1 == "archiveVoice" then
		var_0_0.send("hero", "hero_sound")
	elseif arg_1_0 == "HeartLinkItem" and arg_1_1 == "unLockBtn" then
		var_0_0.send("hero", "hero_record_unlock")
	elseif arg_1_0 == "NewHeroSkillPage" and arg_1_1 == "buttonComboSkill" then
		var_0_0.send("hero", "hero_skill_combo")
	elseif arg_1_0 == "HeroSkillItem" then
		var_0_0.send("hero", "hero_skill_select")
	elseif arg_1_0 == "HeroSkillUpgradeView" and arg_1_1 == "btn0" then
		var_0_0.send("hero", "hero_skill_up")
	elseif arg_1_0 == "HeroWeaponPage" and arg_1_1 == "weaponStrength" then
		var_0_0.send("hero", "weapon_up_open")
	elseif arg_1_0 == "hero" and arg_1_1 == "weaponPage1" then
		var_0_0.send("hero", "weapon_up_detail")
	elseif arg_1_0 == "hero" and arg_1_1 == "weaponPage2" then
		var_0_0.send("hero", "weapon_up_up")
	elseif arg_1_0 == "WeaponView" and arg_1_1 == "choiceBtn" then
		var_0_0.send("hero", "weapon_up_quickly_select")
	elseif arg_1_0 == "hero" and arg_1_1 == "weaponUpgradeSelectMaterial" then
		var_0_0.send("hero", "weapon_up_select")
	elseif arg_1_0 == "WeaponView" and arg_1_1 == "upgradeBtn" then
		var_0_0.send("hero", "weapon_up_confirm")
	elseif arg_1_0 == "hero" and arg_1_1 == "weaponCancelUpgrade" then
		var_0_0.send("hero", "weapon_five_star_cancel")
	elseif arg_1_0 == "hero" and arg_1_1 == "weaponOKUpgrade" then
		var_0_0.send("hero", "weapon_five_star_confirm")
	elseif arg_1_0 == "HeroWeaponPage" and arg_1_1 == "emptyReplace" then
		var_0_0.send("hero", "weapon_spirit")
	elseif arg_1_0 == "WeaponServantView" and arg_1_1 == "replaceBtn" then
		var_0_0.send("hero", "weapon_spirit_confirm")
	elseif arg_1_0 == "HeroWeaponPage" and arg_1_1 == "replace" then
		var_0_0.send("hero", "weapon_spirit_change")
	elseif arg_1_0 == "HeroWeaponPage" and arg_1_1 == "replace" then
		var_0_0.send("hero", "weapon_spirit_lock")
	elseif arg_1_0 == "WeaponServantView" and arg_1_1 == "strengthenBtn" then
		var_0_0.send("hero", "weapon_spirit_lvup")
	elseif arg_1_0 == "NewHeroAstrolabePage" and arg_1_1 == "btn_adjust" then
		var_0_0.send("hero", "astrolabe_adjust")
	elseif arg_1_0 == "AstrolabeUnlockView" and arg_1_1 == "unlockBtn" then
		var_0_0.send("hero", "astrolabe_unlock")
	elseif arg_1_0 == "AstrolabeAdjustView" and arg_1_1 == "loadBtn" then
		var_0_0.send("hero", "astrolabe_equip")
	elseif arg_1_0 == "AstrolabeAdjustView" and arg_1_1 == "unloadBtn" then
		var_0_0.send("hero", "astrolabe_equip")
	elseif arg_1_0 == "AstrolabeAdjustView" and arg_1_1 == "unLoadAllBtn" then
		var_0_0.send("hero", "astrolabe_reset")
	elseif arg_1_0 == "equip" and arg_1_1 == "equipInfoView" then
		var_0_0.send("hero", "hequip_open")
	elseif arg_1_0 == "HeroEquipBagView" and arg_1_1 == "btn_unloadAll" then
		var_0_0.send("hero", "hequip_unuse_byonce")
		var_0_0.send("hero", "hequip_unuse")
	elseif arg_1_0 == "EquipBagView" and arg_1_1 == "position" then
		var_0_0.send("hero", "hequip_location")
	elseif arg_1_0 == "EquipBagView" and arg_1_1 == "suit" then
		var_0_0.send("hero", "hequip_set")
	elseif arg_1_0 == "EquipBagView" and arg_1_1 == "skills" then
		var_0_0.send("hero", "hequip_skill")
	elseif arg_1_0 == "" and arg_1_1 == "" then
		var_0_0.send("hero", "hequipl_type")
	elseif arg_1_0 == "hero" and arg_1_1 == "heroEquipSortLevel" then
		var_0_0.send("hero", "hequip_type_foster")
	elseif arg_1_0 == "hero" and arg_1_1 == "heroEquipSortRare" then
		var_0_0.send("hero", "hequip_type_star")
	elseif arg_1_0 == "EquipBagView" and arg_1_1 == "btn_sort" then
		var_0_0.send("hero", "hequip_order")
	elseif arg_1_0 == "EquipBagView" and (arg_1_1 == "pos1" or arg_1_1 == "pos2" or arg_1_1 == "pos3" or arg_1_1 == "pos4" or arg_1_1 == "pos5" or arg_1_1 == "pos6") then
		var_0_0.send("hero", "hequip_location_list")
	elseif arg_1_0 == "HeroEquipBagView" and arg_1_1 == "btn_scheme" then
		var_0_0.send("hero", "hequip_plan_open")
	elseif arg_1_0 == "EquipProposalView" and arg_1_1 == "save" then
		var_0_0.send("hero", "hequip_plan_save")
	elseif arg_1_0 == "" and arg_1_1 == "" then
		var_0_0.send("hero", "hequip_plan_type")
	elseif arg_1_0 == "EquipProposal" and arg_1_1 == "proposal_okBtn" then
		var_0_0.send("hero", "hequip_plan_name_confirm")
	elseif arg_1_0 == "EquipProposal" and arg_1_1 == "proposal_cancelBtn" then
		var_0_0.send("hero", "hequip_plan_name_cancel")
	elseif arg_1_0 == "EquipProposalView" and arg_1_1 == "edit" then
		var_0_0.send("hero", "hequip_plan_rename")
	elseif arg_1_0 == "EquipProposalView" and arg_1_1 == "delete" then
		var_0_0.send("hero", "hequip_plan_delete")
	elseif arg_1_0 == "EquipProposalItem" and arg_1_1 == "proposalItem(Clone)" then
		var_0_0.send("hero", "hequip_plan_change")
	elseif arg_1_0 == "" and arg_1_1 == "" then
		var_0_0.send("hero", "hequip_use")
	elseif arg_1_0 == "EquipNewInfoView" and arg_1_1 == "suit" then
		var_0_0.send("hero", "hequip_effect")
	elseif arg_1_0 == "EquipNewInfoView" and arg_1_1 == "skill" then
		var_0_0.send("hero", "hequip_skill")
	elseif arg_1_0 == "HeroEquipBagView" and arg_1_1 == "btn_recommend" then
		var_0_0.send("hero", "hequip_recommend")
	elseif arg_1_0 == "EquipRecGroupItem" and arg_1_1 == "setAsPresetBtn" then
		var_0_0.send("hero", "hequip_recommend_confirm")
	elseif arg_1_0 == "heroEquipBag" and arg_1_1 == "backBtn" then
		var_0_0.send("hero", "hero_back")
	elseif arg_1_0 == "heroEquipBag" and arg_1_1 == "homeBtn" then
		var_0_0.send("hero", "hero_home")
	elseif arg_1_0 == "newHero" and arg_1_1 == "backBtn" then
		var_0_0.send("hero", "hero_back")
	elseif arg_1_0 == "newHero" and arg_1_1 == "homeBtn" then
		var_0_0.send("hero", "hero_home")
	elseif arg_1_0 == "hero" and arg_1_1 == "hero_record_switch" then
		var_0_0.send("hero", "hero_record_switch")
	elseif arg_1_0 == "HeroPropertyPage" and arg_1_1 == "storyBtn" then
		var_0_0.send("hero", "hero_chain_event_open")
	elseif arg_1_0 == "HeroArchiveStoryItem" and arg_1_1 == "playBtn" then
		var_0_0.send("hero", "hero_chain_event_one")
	elseif arg_1_0 == "MainHomeView" and arg_1_1 == "btn_annc" then
		var_0_0.send("announcement", "announcement_open")
	elseif arg_1_0 == "bulletin" and arg_1_1 == "changeType" then
		var_0_0.send("announcement", "announcement_type")
	elseif arg_1_0 == "BulletinBtnItem" and arg_1_1 == "btnItemPrefab(Clone)" then
		var_0_0.send("announcement", "announcement_select")
	elseif arg_1_0 == "" and arg_1_1 == "" then
		var_0_0.send("announcement", "announcement_slide")
	elseif arg_1_0 == "MainHomeView" and arg_1_1 == "btn_girl" then
		var_0_0.send("poster", "poster_click")
	elseif arg_1_0 == "MainHomeView" and arg_1_1 == "btn_genghuan" then
		var_0_0.send("poster", "poster_open")
	elseif arg_1_0 == "changePoster" and arg_1_1 == "selectHero" then
		var_0_0.send("poster", "poster_select")
	elseif arg_1_0 == "" and arg_1_1 == "" then
		var_0_0.send("poster", "poster_slide")
	elseif arg_1_0 == "ChangePosterView" and arg_1_1 == "showBtn" then
		var_0_0.send("poster", "poster_show")
	elseif arg_1_0 == "changePoster" and arg_1_1 == "backBtn" then
		var_0_0.send("poster", "poster_back")
	elseif arg_1_0 == "changePoster" and arg_1_1 == "homeBtn" then
		var_0_0.send("poster", "poster_home")
	elseif arg_1_0 == "MainHomeView" and arg_1_1 == "btn_combat" then
		var_0_0.send("combat", "combat_open")
	elseif arg_1_0 == "ChapterBtnView" and arg_1_1 == "1" then
		var_0_0.send("combat", "combat_story")
	elseif arg_1_0 == "HardLevelChapterItem" then
		var_0_0.send("combat", "combat_hard")
	elseif arg_1_0 == "ChapterMapItemView" then
		var_0_0.send("combat", "combat_chapter")
	elseif arg_1_0 == "ChapterSectionView" and arg_1_1 == "collectBtn" then
		var_0_0.send("combat", "combat_progress")
	elseif arg_1_0 == "ChapterSectionRewardItemPanel" and arg_1_1 == "collect_get_reward" then
		var_0_0.send("combat", "combat_progress_get")
	elseif arg_1_0 == "chapterSection/chapterSectionReward" and arg_1_1 == "PopItemView" then
		var_0_0.send("combat", "combat_item")
	elseif arg_1_0 == "ChapterBtnView" and arg_1_1 == "2" then
		var_0_0.send("combat", "combat_materials")
	elseif arg_1_0 == "ChapterBtnView" and arg_1_1 == "3" then
		var_0_0.send("combat", "combat_equip")
	elseif arg_1_0 == "ChapterBtnView" and arg_1_1 == "4" then
		var_0_0.send("combat", "combat_challenge")
	elseif arg_1_0 == "DailySectionInfoView" and arg_1_1 == "addBtn" then
		var_0_0.send("combat", "combat_times")
	elseif arg_1_0 == "DailySectionInfoView" and arg_1_1 == "subBtn" then
		var_0_0.send("combat", "combat_times")
	elseif arg_1_0 == "DailySectionInfoView" and arg_1_1 == "maxMultipleBtn" then
		var_0_0.send("combat", "combat_max/min_times")
	elseif arg_1_0 == "DailySectionInfoView" and arg_1_1 == "minMultipleBtn" then
		var_0_0.send("combat", "combat_max/min_times")
	elseif arg_1_0 == "DailySectionInfoView" and arg_1_1 == "battleBtn" then
		var_0_0.send("combat", "combat_ready")
	elseif arg_1_0 == "EquipSectionInfoView" and arg_1_1 == "battleBtn" then
		var_0_0.send("combat", "combat_ready")
	elseif arg_1_0 == "ChapterSectionInfoView" and arg_1_1 == "battleBtn" then
		var_0_0.send("combat", "combat_ready")
	elseif arg_1_0 == "MythicSectionInfoView" and arg_1_1 == "battleBtn" then
		var_0_0.send("combat", "combat_ready")
	elseif arg_1_0 == "BattleBossChallengeView" and arg_1_1 == "startBattleBtn" then
		var_0_0.send("combat", "combat_ready")
	elseif arg_1_0 == "SectionSelectHeroBaseView" and arg_1_1 == "click_add" then
		var_0_0.send("combat", "combat_hero_open")
	elseif arg_1_0 == "HeroTeamHeadItem" then
		var_0_0.send("combat", "combat_hero_select")
	elseif arg_1_0 == "HeroTeamInfoBaseView" and arg_1_1 == "upgradeBtn" then
		var_0_0.send("combat", "combat_hero_detail")
	elseif arg_1_0 == "HeroTeamInfoBaseView" and arg_1_1 == "upgradeBtn" then
		var_0_0.send("combat", "combat_change/unuse")
	elseif arg_1_0 == "SectionSelectHeroChip" and arg_1_1 == "Bg" then
		var_0_0.send("combat", "combat_ai")
	elseif arg_1_0 == "SectionSelectHeroBaseView" and arg_1_1 == "endDrag" then
		var_0_0.send("combat", "combat_slide")
	elseif arg_1_0 == "SectionComboSkillView" and arg_1_1 == "meaning" then
		var_0_0.send("combat", "combat_combo")
	elseif arg_1_0 == "ComboSkillSelectItem" and arg_1_1 == "selectBtn" then
		var_0_0.send("combat", "combat_combo_select")
	elseif arg_1_0 == "SectionSelectHeroBaseView" and arg_1_1 == "startBtn" then
		var_0_0.send("combat", "combat_start")
	elseif arg_1_0 == "EquipSectionView" and arg_1_1 == "btn_switch" then
		var_0_0.send("combat", "combat_equip_up_open")
	elseif arg_1_0 == "" and arg_1_1 == "" then
		var_0_0.send("combat", "combat_equip_up_select")
	elseif arg_1_0 == "SuitSelectView" and arg_1_1 == "btn_up" then
		var_0_0.send("combat", "combat_equip_up_confirm")
	elseif arg_1_0 == "WindowBarMgr" and arg_1_1 == "btn_info" then
		var_0_0.send("combat", "combat_description")
	elseif arg_1_0 == "EnchantmentStageView" and arg_1_1 == "selectDifficultBtn" then
		var_0_0.send("combat", "combat_enchant_hard")
	elseif arg_1_0 == "EnchantmentStageView" and (arg_1_1 == "levelBtn1" or arg_1_1 == "levelBtn2" or arg_1_1 == "levelBtn3") then
		var_0_0.send("combat", "combat_enchant_hard_select")
	elseif arg_1_0 == "MythicView" and arg_1_1 == "Item(Clone)" then
		var_0_0.send("combat", "combat_secret_affix")
	elseif arg_1_0 == "MythicView" and arg_1_1 == "btn" then
		var_0_0.send("combat", "combat_secret_refresh")
	elseif arg_1_0 == "PopCostItemView" and arg_1_1 == "okBtn" then
		var_0_0.send("combat", "combat_secret_refresh_confirm")
	elseif arg_1_0 == "PopCostItemView" and arg_1_1 == "cancelBtn" then
		var_0_0.send("combat", "combat_secret_refresh_cancel")
	elseif arg_1_0 == "MythicView" and arg_1_1 == "shopbtn" then
		var_0_0.send("combat", "combat_secret_shop")
	elseif arg_1_0 == "MythicGiftView" and arg_1_1 == "Item(Clone)" then
		var_0_0.send("combat", "combat_progress_get")
	elseif arg_1_0 == "BattleBossChallengeView" and arg_1_1 == "bossInfoBtn" then
		var_0_0.send("combat", "combat_boss_info")
	elseif arg_1_0 == "BattleBossChallengeBossItem" and arg_1_1 == "bossItem(Clone)" then
		var_0_0.send("combat", "combat_boss_hard")
	elseif arg_1_0 == "TowerItem" and arg_1_1 == "floor(Clone)" then
		var_0_0.send("combat", "combat_tower_no")
	elseif arg_1_0 == "TowerView" and arg_1_1 == "affixItem(Clone)" then
		var_0_0.send("combat", "combat_tower_affix")
	elseif arg_1_0 == "teachStage" and arg_1_1 == "base" then
		var_0_0.send("combat", "combat_basic_tutorial")
	elseif arg_1_0 == "teachStage" and arg_1_1 == "role" then
		var_0_0.send("combat", "combat_character")
	elseif arg_1_0 == "TeachSectionInfoView" and arg_1_1 == "image" then
		var_0_0.send("combat", "combat_basic_gba")
	elseif arg_1_0 == "teachStage" and arg_1_1 == "backBtn" then
		var_0_0.send("combat", "combat_back")
	elseif arg_1_0 == "teachStage" and arg_1_1 == "homeBtn" then
		var_0_0.send("combat", "combat_home")
	elseif arg_1_0 == "BattleCallLua" and arg_1_1 == "combat_pause" then
		var_0_0.send("battle", "battle_stop")
	elseif arg_1_0 == "SettingView" and arg_1_1 == "btn_quitBattle" then
		var_0_0.send("battle", "battle_quit")
	elseif arg_1_0 == "SettingView" and arg_1_1 == "btn_continue" then
		var_0_0.send("battle", "battle_continue")
	elseif arg_1_0 == "SettingView" and arg_1_1 == "switch_page_intelligence" then
		var_0_0.send("battle", "battle_objectives")
	elseif arg_1_0 == "SettingView" and arg_1_1 == "switch_page_skill" then
		var_0_0.send("battle", "battle_skill_description")
	elseif arg_1_0 == "battle" and arg_1_1 == "skillExplain" then
		var_0_0.send("battle", "battle_skill_des_des")
	elseif arg_1_0 == "battle" and arg_1_1 == "recommend" then
		var_0_0.send("battle", "battle_skill_recommend")
	elseif arg_1_0 == "BattleMultipleResultView" and arg_1_1 == "OnceMore" then
		var_0_0.send("battle", "battle_retry")
	elseif arg_1_0 == "battleMultipleResult" and arg_1_1 == "PopItemView" then
		var_0_0.send("battle", "battle_item")
	elseif arg_1_0 == "BattleMultipleResultView" and arg_1_1 == "CloseBtn" then
		var_0_0.send("battle", "battle_back")
	elseif arg_1_0 == "BattleMultipleResultView" and arg_1_1 == "button_count" then
		var_0_0.send("battle", "battle_statistic")
	elseif arg_1_0 == "BattleResultBaseView" and arg_1_1 == "button_count" then
		var_0_0.send("battle", "battle_statistic")
	elseif arg_1_0 == "BattleResultBaseView" and arg_1_1 == "closeCombat" then
		var_0_0.send("battle", "battle_finish")
	elseif arg_1_0 == "home" and arg_1_1 == "activity_slide" then
		var_0_0.send("home", "activity_slide")
	elseif arg_1_0 == "home" and arg_1_1 == "activity_open" then
		var_0_0.send("home", "activity_open")
	elseif arg_1_0 == "MatrixPrepareView" and arg_1_1 == "selectHeroButton" then
		var_0_0.send("rouge", "team_open")
	elseif arg_1_0 == "MatrixSelectHeroItem" and arg_1_1 == "heroItem(Clone)" then
		var_0_0.send("rouge", "team_hero")
	elseif arg_1_0 == "MatrixSelectHeroView" and arg_1_1 == "confirmBtn" then
		var_0_0.send("rouge", "team_confirm")
	elseif arg_1_0 == "MatrixPrepareView" and arg_1_1 == "scoreButton" then
		var_0_0.send("rouge", "point_award_open")
	elseif arg_1_0 == "matrixBlank/matrixPrepare/matrixScoreExchange" and arg_1_1 == "PopItemView" then
		var_0_0.send("rouge", "point_award_item")
	elseif arg_1_0 == "MatrixScoreExchangeItem" and arg_1_1 == "receiveBtn" then
		var_0_0.send("rouge", "point_award_get")
	elseif arg_1_0 == "MatrixScoreExchangeView" and arg_1_1 == "receiveBtn" then
		var_0_0.send("rouge", "point_award_get_by_once")
	elseif arg_1_0 == "MatrixPrepareView" and arg_1_1 == "shopButton" then
		var_0_0.send("rouge", "rouge_shop")
	elseif arg_1_0 == "MatrixPrepareView" and arg_1_1 == "simpleItem" then
		var_0_0.send("rouge", "hard_normal")
	elseif arg_1_0 == "MatrixPrepareView" and arg_1_1 == "difficultItem" then
		var_0_0.send("rouge", "hard_difficult")
	elseif arg_1_0 == "MatrixPrepareView" and arg_1_1 == "startButton" then
		var_0_0.send("rouge", "start")
	elseif arg_1_0 == "matrixMainView" and arg_1_1 == "PointRewardBtn" then
		var_0_0.send("rouge", "start_point_award")
	elseif arg_1_0 == "matrixMainView" and arg_1_1 == "giveUpdBtn" then
		var_0_0.send("rouge", "give_up_open")
	elseif arg_1_0 == "matrixMainMessageBox" and arg_1_1 == "cancelBtn" then
		var_0_0.send("rouge", "give_up_cancel")
	elseif arg_1_0 == "matrixMainMessageBox" and arg_1_1 == "okBtn" then
		var_0_0.send("rouge", "give_up_confirm")
	elseif arg_1_0 == "matrixMainView" and arg_1_1 == "ZdItemsdBtn" then
		var_0_0.send("rouge", "start_shop")
	elseif arg_1_0 == "matrixMainView" and arg_1_1 == "headline_sq_up" then
		var_0_0.send("rouge", "relic_open")
	elseif arg_1_0 == "matrixMainView" and arg_1_1 == "headline_sq_down" then
		var_0_0.send("rouge", "relic_open")
	elseif arg_1_0 == "matrixMainView" and (arg_1_1 == "hero_1" or arg_1_1 == "hero_2" or arg_1_1 == "hero_3" or arg_1_1 == "lastHeroButton" or arg_1_1 == "nextHeroButton") then
		var_0_0.send("rouge", "hero_slide")
	elseif arg_1_0 == "MatrixMainEquipItem" and arg_1_1 == "equipItem(Clone)" then
		var_0_0.send("rouge", "ready_equip")
	elseif arg_1_0 == "MatrixMainAstrolabeItem" and arg_1_1 == "astrolabeItem(Clone)" then
		var_0_0.send("rouge", "ready_astrolabe")
	elseif arg_1_0 == "MatrixMainArtifactRow" and arg_1_1 == "button" then
		var_0_0.send("rouge", "ready_relic")
	elseif arg_1_0 == "MatrixMainEventItem" and arg_1_1 == "eventItem(Clone)" then
		var_0_0.send("rouge", "rouge_combat")
	elseif arg_1_0 == "matrixMainReward" and arg_1_1 == "firstClick" then
		var_0_0.send("rouge", "award_select")
	elseif arg_1_0 == "matrixMainReward" and arg_1_1 == "secondClick" then
		var_0_0.send("rouge", "award_confirm")
	elseif arg_1_0 == "SettingView" and arg_1_1 == "switch_page_artifact" then
		var_0_0.send("rouge", "setting_chara_info")
	elseif arg_1_0 == "matrix" and arg_1_1 == "descTextExtend" then
		var_0_0.send("rouge", "item_info_open")
	elseif arg_1_0 == "matrix" and arg_1_1 == "selectEquip" then
		var_0_0.send("rouge", "rouge_equip_change")
	elseif arg_1_0 == "MatrixEquipReplaceView" and arg_1_1 == "okBtn" then
		var_0_0.send("rouge", "rouge_equip_change_confirm")
	elseif arg_1_0 == "MatrixEquipReplaceView" and arg_1_1 == "cancelBtn" then
		var_0_0.send("rouge", "rouge_equip_change_cancel")
	elseif arg_1_0 == "matrix" and arg_1_1 == "shopFirstClick" then
		var_0_0.send("rouge", "rouge_shop_item")
	elseif arg_1_0 == "matrix" and arg_1_1 == "shopSecondClick" then
		var_0_0.send("rouge", "rouge_shop_item_confirm")
	elseif arg_1_0 == "matrixShopMessageBox" and arg_1_1 == "okBtn" then
		var_0_0.send("rouge", "shop_quit_confirm")
	elseif arg_1_0 == "matrixShopMessageBox" and arg_1_1 == "cancelBtn" then
		var_0_0.send("rouge", "shop_quit_cancel")
	elseif arg_1_0 == "MatrixOverHeroServantItem" and arg_1_1 == "icon" then
		var_0_0.send("rouge", "settle_spirit")
	elseif arg_1_0 == "MatrixOverHeroEquipItem" then
		var_0_0.send("rouge", "settle_equip")
	elseif arg_1_0 == "MatrixShopView" and arg_1_1 == "sellerImg" then
		var_0_0.send("rouge", "rouge_shop_poster")
	elseif arg_1_0 == "MatrixOverView" and arg_1_1 == "iconaffix" then
		var_0_0.send("rouge", "settle_affix")
	elseif arg_1_0 == "MatrixOverView" and arg_1_1 == "statisticsBtn" then
		var_0_0.send("rouge", "settle_statistic")
	elseif arg_1_0 == "MatrixOverView" and arg_1_1 == "shareBtn" then
		var_0_0.send("rouge", "settle_share")
	elseif arg_1_0 == "MatrixOverView" and arg_1_1 == "closeBtn" then
		var_0_0.send("rouge", "settle_finish")
	elseif arg_1_0 == "matrixMain" and arg_1_1 == "backBtn" then
		var_0_0.send("rouge", "rouge_back")
	elseif arg_1_0 == "matrixMain" and arg_1_1 == "homeBtn" then
		var_0_0.send("rouge", "rouge_home")
	elseif arg_1_0 == "ChessHome" and arg_1_1 == "btn_menu" then
		var_0_0.send("chess", "menu_open")
	elseif arg_1_0 == "warChessStageMessageBox" and arg_1_1 == "cancelBtn" then
		var_0_0.send("chess", "finish")
	elseif arg_1_0 == "ChessMenu" and arg_1_1 == "okBtn" then
		var_0_0.send("chess", "leave")
	elseif arg_1_0 == "ChessMenu" and arg_1_1 == "bgmask" then
		var_0_0.send("chess", "blank")
	elseif arg_1_0 == "chess" and arg_1_1 == "grid" then
		var_0_0.send("chess", "grid")
	elseif arg_1_0 == "WarChessMessageBtn" and arg_1_1 == "check" then
		var_0_0.send("chess", "event_confirm")
	elseif arg_1_0 == "warHomeMessageBox" and arg_1_1 == "okBtn" then
		var_0_0.send("chess", "battle_confirm")
	elseif arg_1_0 == "warHomeMessageBox" and arg_1_1 == "cancelBtn" then
		var_0_0.send("chess", "battle_cancel")
	elseif arg_1_0 == "chess" and arg_1_1 == "select_artifact" then
		var_0_0.send("chess", "relic_select")
	elseif arg_1_0 == "chess" and arg_1_1 == "check_select_artifact" then
		var_0_0.send("chess", "relic_confirm")
	elseif arg_1_0 == "ChessHome" and arg_1_1 == "btn_log" then
		var_0_0.send("chess", "log")
	elseif arg_1_0 == "ChessHome" and arg_1_1 == "btn_item" then
		var_0_0.send("chess", "item_open")
	elseif arg_1_0 == "chess" and arg_1_1 == "key" then
		var_0_0.send("chess", "item_key")
	elseif arg_1_0 == "chess" and arg_1_1 == "artifact" then
		var_0_0.send("chess", "item_treasures")
	elseif arg_1_0 == "warChessStage" and arg_1_1 == "backBtn" then
		var_0_0.send("chess", "item_back")
	elseif arg_1_0 == "warChessStage" and arg_1_1 == "homeBtn" then
		var_0_0.send("chess", "item_home")
	elseif arg_1_0 == "OperationView" and arg_1_1 == "btn_uccn" then
		var_0_0.send("direction", "direction_official")
	elseif arg_1_0 == "OperationView" and arg_1_1 == "btn_ myCenter" then
		var_0_0.send("direction", "direction_personal_center")
	elseif arg_1_0 == "OperationView" and arg_1_1 == "btn_suggest" then
		var_0_0.send("direction", "direction_reflection")
	elseif arg_1_0 == "OperationView" and arg_1_1 == "btn_forum" then
		var_0_0.send("direction", "direction_forum")
	elseif arg_1_0 == "OperationView" and arg_1_1 == "btn_psq" then
		var_0_0.send("direction", "direction_psq")
	elseif arg_1_0 == "OperationView" and arg_1_1 == "btn_attention" then
		var_0_0.send("direction", "direction_welfare")
	elseif arg_1_0 == "FollowGiftView" and arg_1_1 == "wechat" then
		var_0_0.send("direction", "direction_welfare_wechat")
	elseif arg_1_0 == "FollowGiftView" and arg_1_1 == "weibo" then
		var_0_0.send("direction", "direction_welfare_sina")
	elseif arg_1_0 == "FollowGiftView" and arg_1_1 == "heropieceTgl" then
		var_0_0.send("direction", "direction_reservation")
	elseif arg_1_0 == "FollowGiftView" and arg_1_1 == "materialTgl" then
		var_0_0.send("direction", "direction_subscription")
	elseif arg_1_0 == "OperationView" and arg_1_1 == "btn_query" then
		var_0_0.send("direction", "direction_refer")
	elseif arg_1_0 == "OperationView" and arg_1_1 == "btn_ cdk" then
		var_0_0.send("direction", "direction_gift")
	end
end

function var_0_0.send(arg_2_0, arg_2_1)
	return
end

function var_0_0.RecordCombatOpers(arg_3_0)
	local var_3_0 = {}

	for iter_3_0 = 0, arg_3_0.Length - 1 do
		local var_3_1 = arg_3_0[iter_3_0]

		if var_3_1 == 6 then
			table.insert(var_3_0, {
				op_type = "combat",
				oper = "combat_shanbi"
			})
		elseif var_3_1 == 5 then
			table.insert(var_3_0, {
				op_type = "combat",
				oper = "combat_pugong"
			})
		elseif var_3_1 == 0 then
			table.insert(var_3_0, {
				op_type = "combat",
				oper = "combat_jineng1"
			})
		elseif var_3_1 == 1 then
			table.insert(var_3_0, {
				op_type = "combat",
				oper = "combat_jineng2"
			})
		elseif var_3_1 == 2 then
			table.insert(var_3_0, {
				op_type = "combat",
				oper = "combat_jineng3"
			})
		elseif var_3_1 == 7 then
			table.insert(var_3_0, {
				op_type = "combat",
				oper = "combat_QTE"
			})
		elseif var_3_1 == 8 then
			table.insert(var_3_0, {
				op_type = "combat",
				oper = "combat_suoding"
			})
		end
	end

	if #var_3_0 >= 1 then
		-- block empty
	end
end

function var_0_0.RecordStayView(arg_4_0, arg_4_1, ...)
	local var_4_0 = {
		...
	}

	if arg_4_0 == "" then
		-- block empty
	elseif arg_4_0 == "STAY_VIEW_GAME_HELP" then
		local var_4_1 = var_4_0[1] or 0

		var_0_0.sendStayViewWithType("duration_explain", arg_4_1, var_4_1)
	elseif arg_4_0 == "STAY_VIEW_SETTING_SKILL" then
		local var_4_2 = var_4_0[1] or 0

		var_0_0.sendStayViewWithType("duration_skill_description", arg_4_1, var_4_2)
	end
end

function var_0_0.sendStayView(arg_5_0, arg_5_1)
	SDKTools.SendMessageToSDK(arg_5_0, {
		duration = arg_5_1
	})
end

function var_0_0.sendStayViewWithType(arg_6_0, arg_6_1, arg_6_2)
	SDKTools.SendMessageToSDK(arg_6_0, {
		duration = arg_6_1,
		duration_type = arg_6_2
	})
end

function var_0_0.sendStayHeroView(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	SDKTools.SendMessageToSDK(arg_7_0, {
		duration = arg_7_1,
		duration_type = arg_7_2,
		hero_id = arg_7_3
	})
end

function var_0_0.sendStayHeroChess(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = WarChessData:GetCurrentWarChessMapData().mapId

	SDKTools.SendMessageToSDK(arg_8_0, {
		duration = arg_8_1,
		duration_type = arg_8_2,
		map_id = var_8_0
	})
end

function var_0_0.RecordButtonTouch(arg_9_0)
	if OperationData:IsFunctionStoped(RECORD_OPERATION_ID) then
		return
	end

	local var_9_0

	if type(arg_9_0) == "table" and next(arg_9_0) ~= nil then
		var_9_0 = arg_9_0
	elseif type(arg_9_0) == "string" and not string.isNullOrEmpty(arg_9_0) then
		var_9_0 = {
			button_name = arg_9_0
		}
	else
		Debug.LogError("The record key is empty")
	end

	if var_9_0 then
		SDKTools.SendMessageToSDK("button_touch", var_9_0)
	end
end

return var_0_0
