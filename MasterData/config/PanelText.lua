local System = require("System.System")
local readonly = System.readonly
local PanelText = readonly({
  UI_Login_Text_C_Enter = {
    ID = "UI_Login_Text_C_Enter",
    Content = "PanelText_UI_Login_Text_C_Enter_Content|进入大学"
  },
  UI_Login_Text_C_Plot = {
    ID = "UI_Login_Text_C_Plot",
    Content = "PanelText_UI_Login_Text_C_Plot_Content|Avg剧情测试"
  },
  UI_Login_Text_C_Fight = {
    ID = "UI_Login_Text_C_Fight",
    Content = "PanelText_UI_Login_Text_C_Fight_Content|战斗2.0"
  },
  UI_Awaker_Item_Potency_Detail_Text_C_Survey = {
    ID = "UI_Awaker_Item_Potency_Detail_Text_C_Survey",
    Content = "PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Survey_Content|调查模式"
  },
  UI_Awaker_Item_Potency_Detail_Text_C_Survey_Click = {
    ID = "UI_Awaker_Item_Potency_Detail_Text_C_Survey_Click",
    Content = "PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Survey_Click_Content|调查模式"
  },
  UI_Awaker_Item_Potency_Detail_Text_C_Course = {
    ID = "UI_Awaker_Item_Potency_Detail_Text_C_Course",
    Content = "PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Course_Content|课题模式"
  },
  UI_Awaker_Item_Potency_Detail_Text_C_Course_Click = {
    ID = "UI_Awaker_Item_Potency_Detail_Text_C_Course_Click",
    Content = "PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Course_Click_Content|课题模式"
  },
  UI_Awaker_Item_Potency_Detail_Text_C_Common = {
    ID = "UI_Awaker_Item_Potency_Detail_Text_C_Common",
    Content = "PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Common_Content|通用"
  },
  UI_Awaker_Item_Potency_Detail_Text_C_Common_Click = {
    ID = "UI_Awaker_Item_Potency_Detail_Text_C_Common_Click",
    Content = "PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Common_Click_Content|通用"
  },
  UI_Awaker_Item_Voice_Text_C_Daily_Normal = {
    ID = "UI_Awaker_Item_Voice_Text_C_Daily_Normal",
    Content = "PanelText_UI_Awaker_Item_Voice_Text_C_Daily_Normal_Content|日常"
  },
  UI_Awaker_Item_Voice_Text_C_Daily_Select = {
    ID = "UI_Awaker_Item_Voice_Text_C_Daily_Select",
    Content = "PanelText_UI_Awaker_Item_Voice_Text_C_Daily_Select_Content|日常"
  },
  UI_Awaker_Item_Voice_Text_C_Battle_Normal = {
    ID = "UI_Awaker_Item_Voice_Text_C_Battle_Normal",
    Content = "PanelText_UI_Awaker_Item_Voice_Text_C_Battle_Normal_Content|战斗"
  },
  UI_Awaker_Item_Voice_Text_C_Battle_Select = {
    ID = "UI_Awaker_Item_Voice_Text_C_Battle_Select",
    Content = "PanelText_UI_Awaker_Item_Voice_Text_C_Battle_Select_Content|战斗"
  },
  UI_Awaker_Item_Voice_Text_C_Information = {
    ID = "UI_Awaker_Item_Voice_Text_C_Information",
    Content = "PanelText_UI_Awaker_Item_Voice_Text_C_Information_Content|Information"
  },
  UI_Awaker_Item_Story_Text_C_Bg = {
    ID = "UI_Awaker_Item_Story_Text_C_Bg",
    Content = "PanelText_UI_Awaker_Item_Story_Text_C_Bg_Content|Information"
  },
  UI_Awaker_PanelStory_Main_Text_C_Title = {
    ID = "UI_Awaker_PanelStory_Main_Text_C_Title",
    Content = "PanelText_UI_Awaker_PanelStory_Main_Text_C_Title_Content|基础信息"
  },
  UI_Awaker_Popup_Trinket_Change_Text_C_Equipped = {
    ID = "UI_Awaker_Popup_Trinket_Change_Text_C_Equipped",
    Content = "PanelText_UI_Awaker_Popup_Trinket_Change_Text_C_Equipped_Content|已装备"
  },
  UI_Awaker_Popup_Trinket_Intensify_Detail_Text_C_Shortcut = {
    ID = "UI_Awaker_Popup_Trinket_Intensify_Detail_Text_C_Shortcut",
    Content = "PanelText_UI_Awaker_Popup_Trinket_Intensify_Detail_Text_C_Shortcut_Content|快捷放入"
  },
  UI_Awaker_Popup_Trinket_Intensify_Detail_Text_C_Filtrate = {
    ID = "UI_Awaker_Popup_Trinket_Intensify_Detail_Text_C_Filtrate",
    Content = "PanelText_UI_Awaker_Popup_Trinket_Intensify_Detail_Text_C_Filtrate_Content|SSR及以下的素材"
  },
  UI_Awaker_Popup_Trinket_Select_List_Text_C_1_Normal = {
    ID = "UI_Awaker_Popup_Trinket_Select_List_Text_C_1_Normal",
    Content = "PanelText_UI_Awaker_Popup_Trinket_Select_List_Text_C_1_Normal_Content|Ⅰ"
  },
  UI_Awaker_Popup_Trinket_Select_List_Text_C_1_Select = {
    ID = "UI_Awaker_Popup_Trinket_Select_List_Text_C_1_Select",
    Content = "PanelText_UI_Awaker_Popup_Trinket_Select_List_Text_C_1_Select_Content|Ⅰ"
  },
  UI_Awaker_Popup_Trinket_Select_List_Text_C_2_Normal = {
    ID = "UI_Awaker_Popup_Trinket_Select_List_Text_C_2_Normal",
    Content = "PanelText_UI_Awaker_Popup_Trinket_Select_List_Text_C_2_Normal_Content|Ⅱ"
  },
  UI_Awaker_Popup_Trinket_Select_List_Text_C_2_Select = {
    ID = "UI_Awaker_Popup_Trinket_Select_List_Text_C_2_Select",
    Content = "PanelText_UI_Awaker_Popup_Trinket_Select_List_Text_C_2_Select_Content|Ⅱ"
  },
  UI_Awaker_Popup_Trinket_Select_List_Text_C_3_Normal = {
    ID = "UI_Awaker_Popup_Trinket_Select_List_Text_C_3_Normal",
    Content = "PanelText_UI_Awaker_Popup_Trinket_Select_List_Text_C_3_Normal_Content|Ⅲ"
  },
  UI_Awaker_Popup_Trinket_Select_List_Text_C_3_Select = {
    ID = "UI_Awaker_Popup_Trinket_Select_List_Text_C_3_Select",
    Content = "PanelText_UI_Awaker_Popup_Trinket_Select_List_Text_C_3_Select_Content|Ⅲ"
  },
  UI_Awaker_Popup_Trinket_Select_List_Text_C_4_Normal = {
    ID = "UI_Awaker_Popup_Trinket_Select_List_Text_C_4_Normal",
    Content = "PanelText_UI_Awaker_Popup_Trinket_Select_List_Text_C_4_Normal_Content|Ⅳ"
  },
  UI_Awaker_Popup_Trinket_Select_List_Text_C_4_Select = {
    ID = "UI_Awaker_Popup_Trinket_Select_List_Text_C_4_Select",
    Content = "PanelText_UI_Awaker_Popup_Trinket_Select_List_Text_C_4_Select_Content|Ⅳ"
  },
  UI_Awaker_Popup_Trinket_Select_List_Text_C_5_Normal = {
    ID = "UI_Awaker_Popup_Trinket_Select_List_Text_C_5_Normal",
    Content = "PanelText_UI_Awaker_Popup_Trinket_Select_List_Text_C_5_Normal_Content|Ⅴ"
  },
  UI_Awaker_Popup_Trinket_Select_List_Text_C_5_Select = {
    ID = "UI_Awaker_Popup_Trinket_Select_List_Text_C_5_Select",
    Content = "PanelText_UI_Awaker_Popup_Trinket_Select_List_Text_C_5_Select_Content|Ⅴ"
  },
  UI_Awaker_Popup_Trinket_Select_List_Text_C_6_Normal = {
    ID = "UI_Awaker_Popup_Trinket_Select_List_Text_C_6_Normal",
    Content = "PanelText_UI_Awaker_Popup_Trinket_Select_List_Text_C_6_Normal_Content|Ⅵ"
  },
  UI_Awaker_Popup_Trinket_Select_List_Text_C_6_Select = {
    ID = "UI_Awaker_Popup_Trinket_Select_List_Text_C_6_Select",
    Content = "PanelText_UI_Awaker_Popup_Trinket_Select_List_Text_C_6_Select_Content|Ⅵ"
  },
  UI_Awaker_Item_Weapon_Refine_Text_C_Coin_Need = {
    ID = "UI_Awaker_Item_Weapon_Refine_Text_C_Coin_Need",
    Content = "PanelText_UI_Awaker_Item_Weapon_Refine_Text_C_Coin_Need_Content|需要"
  },
  UI_Weapon_Item_Select_List_Text_C_1_Normal = {
    ID = "UI_Weapon_Item_Select_List_Text_C_1_Normal",
    Content = "PanelText_UI_Weapon_Item_Select_List_Text_C_1_Normal_Content|叠位排序"
  },
  UI_Weapon_Item_Select_List_Text_C_1_Select = {
    ID = "UI_Weapon_Item_Select_List_Text_C_1_Select",
    Content = "PanelText_UI_Weapon_Item_Select_List_Text_C_1_Select_Content|叠位排序"
  },
  UI_Weapon_Item_Select_List_Text_C_2_Normal = {
    ID = "UI_Weapon_Item_Select_List_Text_C_2_Normal",
    Content = "PanelText_UI_Weapon_Item_Select_List_Text_C_2_Normal_Content|顺序"
  },
  UI_Weapon_Item_Select_List_Text_C_2_Select = {
    ID = "UI_Weapon_Item_Select_List_Text_C_2_Select",
    Content = "PanelText_UI_Weapon_Item_Select_List_Text_C_2_Select_Content|顺序"
  },
  UI_Bag_Helicopter_Tips_Text_C_Choose = {
    ID = "UI_Bag_Helicopter_Tips_Text_C_Choose",
    Content = "PanelText_UI_Bag_Helicopter_Tips_Text_C_Choose_Content|·选择唤醒体"
  },
  UI_Bag_Helicopter_Tips_Text_C_Helicopter = {
    ID = "UI_Bag_Helicopter_Tips_Text_C_Helicopter",
    Content = "PanelText_UI_Bag_Helicopter_Tips_Text_C_Helicopter_Content|·增幅预览"
  },
  UI_Bag_Helicopter_Tips_Text_C_Attribute = {
    ID = "UI_Bag_Helicopter_Tips_Text_C_Attribute",
    Content = "PanelText_UI_Bag_Helicopter_Tips_Text_C_Attribute_Content|属性"
  },
  UI_Bag_Helicopter_Tips_Text_C_Skill = {
    ID = "UI_Bag_Helicopter_Tips_Text_C_Skill",
    Content = "PanelText_UI_Bag_Helicopter_Tips_Text_C_Skill_Content|技能"
  },
  UI_Battle_Panel_Dbg_Text_C_End_EN_No = {
    ID = "UI_Battle_Panel_Dbg_Text_C_End_EN_No",
    Content = "PanelText_UI_Battle_Panel_Dbg_Text_C_End_EN_No_Content|结束"
  },
  UI_Battle_Popup_Elite_Tips_Text_C_Title = {
    ID = "UI_Battle_Popup_Elite_Tips_Text_C_Title",
    Content = "PanelText_UI_Battle_Popup_Elite_Tips_Text_C_Title_Content|最高警报"
  },
  UI_Battle_Popup_Open_Tips_Text_C_Title = {
    ID = "UI_Battle_Popup_Open_Tips_Text_C_Title",
    Content = "PanelText_UI_Battle_Popup_Open_Tips_Text_C_Title_Content|战斗开始"
  },
  UI_Battle_Popup_Open_Tips_Text_C_Hang = {
    ID = "UI_Battle_Popup_Open_Tips_Text_C_Hang",
    Content = "PanelText_UI_Battle_Popup_Open_Tips_Text_C_Hang_Content|Battle  Begin"
  },
  UI_Battle_Popup_Elite_Tips_Text_C_Hang = {
    ID = "UI_Battle_Popup_Elite_Tips_Text_C_Hang",
    Content = "PanelText_UI_Battle_Popup_Elite_Tips_Text_C_Hang_Content|Battle  Begin"
  },
  UI_Battle_Popup_Round_Mine_Text_C_Our = {
    ID = "UI_Battle_Popup_Round_Mine_Text_C_Our",
    Content = "PanelText_UI_Battle_Popup_Round_Mine_Text_C_Our_Content|我方行动"
  },
  UI_Battle_Popup_SelectAwaker_Text_C_Title = {
    ID = "UI_Battle_Popup_SelectAwaker_Text_C_Title",
    Content = "PanelText_UI_Battle_Popup_SelectAwaker_Text_C_Title_Content|请选择唤醒体"
  },
  UI_Battle_Popup_Settle_Text_C_Victory = {
    ID = "UI_Battle_Popup_Settle_Text_C_Victory",
    Content = "PanelText_UI_Battle_Popup_Settle_Text_C_Victory_Content|Victory"
  },
  UI_Chapter_Item_Chapter_Big_Text_C_Tips = {
    ID = "UI_Chapter_Item_Chapter_Big_Text_C_Tips",
    Content = "PanelText_UI_Chapter_Item_Chapter_Big_Text_C_Tips_Content|关卡进度"
  },
  UI_Chapter_Item_Chapter_Small_Text_C_Tips = {
    ID = "UI_Chapter_Item_Chapter_Small_Text_C_Tips",
    Content = "PanelText_UI_Chapter_Item_Chapter_Small_Text_C_Tips_Content|关卡进度"
  },
  UI_Chaper_Popup_Particulars_Text_C_Monster = {
    ID = "UI_Chaper_Popup_Particulars_Text_C_Monster",
    Content = "PanelText_UI_Chaper_Popup_Particulars_Text_C_Monster_Content|怪物"
  },
  UI_Chapter_Panel_Main2_Text_C_Title = {
    ID = "UI_Chapter_Panel_Main2_Text_C_Title",
    Content = "PanelText_UI_Chapter_Panel_Main2_Text_C_Title_Content|调查"
  },
  UI_Common_Btn_Back1_Text_C_Name = {
    ID = "UI_Common_Btn_Back1_Text_C_Name",
    Content = "PanelText_UI_Common_Btn_Back1_Text_C_Name_Content|Exit"
  },
  UI_Common_Btn_Back2_Text_C_Name = {
    ID = "UI_Common_Btn_Back2_Text_C_Name",
    Content = "PanelText_UI_Common_Btn_Back2_Text_C_Name_Content|Exit"
  },
  UI_Common_Btn_Back3_Text_C_Name = {
    ID = "UI_Common_Btn_Back3_Text_C_Name",
    Content = "PanelText_UI_Common_Btn_Back3_Text_C_Name_Content|Exit"
  },
  UI_Common_Btn_Receive_Small_Text_C_Name = {
    ID = "UI_Common_Btn_Receive_Small_Text_C_Name",
    Content = "PanelText_UI_Common_Btn_Receive_Small_Text_C_Name_Content|领取"
  },
  UI_Common_Item_Btn_Back_1_Text_C_Name = {
    ID = "UI_Common_Item_Btn_Back_1_Text_C_Name",
    Content = "PanelText_UI_Common_Item_Btn_Back_1_Text_C_Name_Content|Exit"
  },
  UI_Common_Item_Tip_Bg_Text_C_Name = {
    ID = "UI_Common_Item_Tip_Bg_Text_C_Name",
    Content = "PanelText_UI_Common_Item_Tip_Bg_Text_C_Name_Content|排序"
  },
  UI_Common_Item_Tip_Bg_Text_C_Label = {
    ID = "UI_Common_Item_Tip_Bg_Text_C_Label",
    Content = "PanelText_UI_Common_Item_Tip_Bg_Text_C_Label_Content|Sort."
  },
  UI_Common_Popup_Tip_01_Text_C_Screening = {
    ID = "UI_Common_Popup_Tip_01_Text_C_Screening",
    Content = "PanelText_UI_Common_Popup_Tip_01_Text_C_Screening_Content|今日不再提示"
  },
  UI_Dbgcopy_Item_Select_Goods_Text_C_Sellout = {
    ID = "UI_Dbgcopy_Item_Select_Goods_Text_C_Sellout",
    Content = "PanelText_UI_Dbgcopy_Item_Select_Goods_Text_C_Sellout_Content|售罄"
  },
  UI_Dbgcopy_Panel_Select_Arousal_Text_C_Precautions = {
    ID = "UI_Dbgcopy_Panel_Select_Arousal_Text_C_Precautions",
    Content = "PanelText_UI_Dbgcopy_Panel_Select_Arousal_Text_C_Precautions_Content|Notice"
  },
  UI_Dbgcopy_Panel_Select_Awaken_Text_C_Precautions = {
    ID = "UI_Dbgcopy_Panel_Select_Awaken_Text_C_Precautions",
    Content = "PanelText_UI_Dbgcopy_Panel_Select_Awaken_Text_C_Precautions_Content|Notice"
  },
  UI_Dbgcopy_Panel_Select_Curse_Text_C_Precautions = {
    ID = "UI_Dbgcopy_Panel_Select_Curse_Text_C_Precautions",
    Content = "PanelText_UI_Dbgcopy_Panel_Select_Curse_Text_C_Precautions_Content|Notice"
  },
  UI_Dbgcopy_Panel_Select_Extra_Text_C_Precautions = {
    ID = "UI_Dbgcopy_Panel_Select_Extra_Text_C_Precautions",
    Content = "PanelText_UI_Dbgcopy_Panel_Select_Extra_Text_C_Precautions_Content|Notice"
  },
  UI_Dbgcopy_Panel_Store_Text_C_exit = {
    ID = "UI_Dbgcopy_Panel_Store_Text_C_exit",
    Content = "PanelText_UI_Dbgcopy_Panel_Store_Text_C_exit_Content|Exit"
  },
  UI_Dbgcopy_Popup_Remove_Enchantment_Text_C_Precautions = {
    ID = "UI_Dbgcopy_Popup_Remove_Enchantment_Text_C_Precautions",
    Content = "PanelText_UI_Dbgcopy_Popup_Remove_Enchantment_Text_C_Precautions_Content|Notice"
  },
  UI_Dungeous_Panel_SecEntrance_Text_C_Special = {
    ID = "UI_Dungeous_Panel_SecEntrance_Text_C_Special",
    Content = "PanelText_UI_Dungeous_Panel_SecEntrance_Text_C_Special_Content|初始造物"
  },
  UI_Dungeous_Panel_SecEntrance_Text_C_Award = {
    ID = "UI_Dungeous_Panel_SecEntrance_Text_C_Award",
    Content = "PanelText_UI_Dungeous_Panel_SecEntrance_Text_C_Award_Content|任务报酬"
  },
  UI_Dungeous_Weekly_Difficulty_Text_C_Title = {
    ID = "UI_Dungeous_Weekly_Difficulty_Text_C_Title",
    Content = "PanelText_UI_Dungeous_Weekly_Difficulty_Text_C_Title_Content|初始造物"
  },
  UI_Dungeous_Weekly_Difficulty_Text_C_Monster = {
    ID = "UI_Dungeous_Weekly_Difficulty_Text_C_Monster",
    Content = "PanelText_UI_Dungeous_Weekly_Difficulty_Text_C_Monster_Content|怪物预览"
  },
  Panel_Announcement_Text_C_Panel_Title = {
    ID = "Panel_Announcement_Text_C_Panel_Title",
    Content = "PanelText_Panel_Announcement_Text_C_Panel_Title_Content|告示"
  },
  UI_Mail_Text_C_Title = {
    ID = "UI_Mail_Text_C_Title",
    Content = "PanelText_UI_Mail_Text_C_Title_Content|信箱"
  },
  UI_Mail_Text_C_All = {
    ID = "UI_Mail_Text_C_All",
    Content = "PanelText_UI_Mail_Text_C_All_Content|全部领取"
  },
  UI_Mail_Text_C_Delete = {
    ID = "UI_Mail_Text_C_Delete",
    Content = "PanelText_UI_Mail_Text_C_Delete_Content|删除已读"
  },
  UI_Mail_Text_C_Select_Letter = {
    ID = "UI_Mail_Text_C_Select_Letter",
    Content = "PanelText_UI_Mail_Text_C_Select_Letter_Content|选择一封邮件"
  },
  UI_Mail_Text_C_Empty = {
    ID = "UI_Mail_Text_C_Empty",
    Content = "PanelText_UI_Mail_Text_C_Empty_Content|没有新的邮件"
  },
  UI_Mail_Text_C_Tips = {
    ID = "UI_Mail_Text_C_Tips",
    Content = "PanelText_UI_Mail_Text_C_Tips_Content|去其他地方看看吧"
  },
  UI_Mail_Text_C_Collection = {
    ID = "UI_Mail_Text_C_Collection",
    Content = "PanelText_UI_Mail_Text_C_Collection_Content|邮件珍藏箱"
  },
  UI_Mail_Text_C_Mail = {
    ID = "UI_Mail_Text_C_Mail",
    Content = "PanelText_UI_Mail_Text_C_Mail_Content|邮件数"
  },
  UI_Summon_Btn_Jump_Text_C_Look = {
    ID = "UI_Summon_Btn_Jump_Text_C_Look",
    Content = "PanelText_UI_Summon_Btn_Jump_Text_C_Look_Content|查看"
  },
  UI_Task_Item_Detail_List_New_Text_C_Get = {
    ID = "UI_Task_Item_Detail_List_New_Text_C_Get",
    Content = "PanelText_UI_Task_Item_Detail_List_New_Text_C_Get_Content|领取"
  },
  UI_Task_Panel_Main_New_Text_C_Title = {
    ID = "UI_Task_Panel_Main_New_Text_C_Title",
    Content = "PanelText_UI_Task_Panel_Main_New_Text_C_Title_Content|暂时没有任务"
  },
  UI_Task_Panel_Main_New_Text_C_Tips = {
    ID = "UI_Task_Panel_Main_New_Text_C_Tips",
    Content = "PanelText_UI_Task_Panel_Main_New_Text_C_Tips_Content|每日任务已完成"
  },
  UI_Task_Panel_Main_New_Text_C_Tips2 = {
    ID = "UI_Task_Panel_Main_New_Text_C_Tips2",
    Content = "PanelText_UI_Task_Panel_Main_New_Text_C_Tips2_Content|Task List Empty"
  },
  UI_Task_Popup_Career_New_Text_C_1 = {
    ID = "UI_Task_Popup_Career_New_Text_C_1",
    Content = "PanelText_UI_Task_Popup_Career_New_Text_C_1_Content|当前进度"
  },
  UI_Task_Popup_Challenge_New_Text_C_Title = {
    ID = "UI_Task_Popup_Challenge_New_Text_C_Title",
    Content = "PanelText_UI_Task_Popup_Challenge_New_Text_C_Title_Content|解锁成就"
  },
  UI_Task_Popup_Challenge_New_Text_C_1 = {
    ID = "UI_Task_Popup_Challenge_New_Text_C_1",
    Content = "PanelText_UI_Task_Popup_Challenge_New_Text_C_1_Content|守秘人"
  },
  UI_Task_Popup_Challenge_New_Text_C_2 = {
    ID = "UI_Task_Popup_Challenge_New_Text_C_2",
    Content = "PanelText_UI_Task_Popup_Challenge_New_Text_C_2_Content|录入时间"
  },
  UI_Task_Popup_Challenge_New_Text_C_3 = {
    ID = "UI_Task_Popup_Challenge_New_Text_C_3",
    Content = "PanelText_UI_Task_Popup_Challenge_New_Text_C_3_Content|调查等级"
  },
  UI_Task_Popup_Entrust_New_Text_C_Special = {
    ID = "UI_Task_Popup_Entrust_New_Text_C_Special",
    Content = "PanelText_UI_Task_Popup_Entrust_New_Text_C_Special_Content|派遣条件"
  },
  UI_Task_Popup_Entrust_New_Text_C_Award = {
    ID = "UI_Task_Popup_Entrust_New_Text_C_Award",
    Content = "PanelText_UI_Task_Popup_Entrust_New_Text_C_Award_Content|任务报酬"
  },
  UI_Team_Panel_Awaker_Main_Text_C_Zhanli = {
    ID = "UI_Team_Panel_Awaker_Main_Text_C_Zhanli",
    Content = "PanelText_UI_Team_Panel_Awaker_Main_Text_C_Zhanli_Content|战力"
  },
  UI_Team_Item_Talent_Text_C_Activate = {
    ID = "UI_Team_Item_Talent_Text_C_Activate",
    Content = "PanelText_UI_Team_Item_Talent_Text_C_Activate_Content|已激活"
  },
  UI_Dungeous_Popup_Prop_Award_Text_C_Title = {
    ID = "UI_Dungeous_Popup_Prop_Award_Text_C_Title",
    Content = "PanelText_UI_Dungeous_Popup_Prop_Award_Text_C_Title_Content|星级奖励预览"
  },
  UI_Dungeous_Popup_Prop_Award_Text_C_Title_En = {
    ID = "UI_Dungeous_Popup_Prop_Award_Text_C_Title_En",
    Content = "PanelText_UI_Dungeous_Popup_Prop_Award_Text_C_Title_En_Content|May Obtain"
  },
  UI_Team_Panel_Main_Text_C_Lives_Desc = {
    ID = "UI_Team_Panel_Main_Text_C_Lives_Desc",
    Content = "PanelText_UI_Team_Panel_Main_Text_C_Lives_Desc_Content|应急灵知体剩余次数："
  },
  UI_Summon_Panel_Main_Text_C_System_Name = {
    ID = "UI_Summon_Panel_Main_Text_C_System_Name",
    Content = "PanelText_UI_Summon_Panel_Main_Text_C_System_Name_Content|唤醒"
  },
  UI_Summon_Panel_Main_Text_C_Difficult_Title = {
    ID = "UI_Summon_Panel_Main_Text_C_Difficult_Title",
    Content = "PanelText_UI_Summon_Panel_Main_Text_C_Difficult_Title_Content|上手难度"
  },
  UI_Summon_Popup_Prob_Tip_Text_C_Up = {
    ID = "UI_Summon_Popup_Prob_Tip_Text_C_Up",
    Content = "PanelText_UI_Summon_Popup_Prob_Tip_Text_C_Up_Content|UP物品"
  },
  UI_Summon_Popup_Prob_Tip_Text_C_Detail = {
    ID = "UI_Summon_Popup_Prob_Tip_Text_C_Detail",
    Content = "PanelText_UI_Summon_Popup_Prob_Tip_Text_C_Detail_Content|详情说明"
  },
  UI_Summon_Popup_Prob_Tip_Text_C_Inventory = {
    ID = "UI_Summon_Popup_Prob_Tip_Text_C_Inventory",
    Content = "PanelText_UI_Summon_Popup_Prob_Tip_Text_C_Inventory_Content|物品清单"
  },
  UI_Bag_Panel_Main_Text_C_None2 = {
    ID = "UI_Bag_Panel_Main_Text_C_None2",
    Content = "PanelText_UI_Bag_Panel_Main_Text_C_None2_Content|Inventory Empty"
  },
  UI_Task_Popup_Career_New_Text_C_Chapter_Award = {
    ID = "UI_Task_Popup_Career_New_Text_C_Chapter_Award",
    Content = "PanelText_UI_Task_Popup_Career_New_Text_C_Chapter_Award_Content|完成奖励"
  },
  UI_Team_Panel_Main_Text_C_Lv1 = {
    ID = "UI_Team_Panel_Main_Text_C_Lv1",
    Content = "PanelText_UI_Team_Panel_Main_Text_C_Lv1_Content|Lv"
  },
  UI_Team_Panel_Main_Text_C_Lv2 = {
    ID = "UI_Team_Panel_Main_Text_C_Lv2",
    Content = "PanelText_UI_Team_Panel_Main_Text_C_Lv2_Content|Lv"
  },
  UI_Team_Panel_Main_Text_C_Lv3 = {
    ID = "UI_Team_Panel_Main_Text_C_Lv3",
    Content = "PanelText_UI_Team_Panel_Main_Text_C_Lv3_Content|Lv"
  },
  UI_Team_Panel_Main_Text_C_Lv4 = {
    ID = "UI_Team_Panel_Main_Text_C_Lv4",
    Content = "PanelText_UI_Team_Panel_Main_Text_C_Lv4_Content|Lv"
  },
  UI_Chaper_Popup_Award_Text_C_Title_En = {
    ID = "UI_Chaper_Popup_Award_Text_C_Title_En",
    Content = "PanelText_UI_Chaper_Popup_Award_Text_C_Title_En_Content|May Obtain"
  },
  UI_Awaker_Item_Info_Text_C_Title = {
    ID = "UI_Awaker_Item_Info_Text_C_Title",
    Content = "PanelText_UI_Awaker_Item_Info_Text_C_Title_Content|Realm ."
  },
  UI_Awaker_Item_Info_Text_C_Name1 = {
    ID = "UI_Awaker_Item_Info_Text_C_Name1",
    Content = "PanelText_UI_Awaker_Item_Info_Text_C_Name1_Content|Name ."
  },
  UI_Awaker_Item_Info_Text_C_Attributes_Title = {
    ID = "UI_Awaker_Item_Info_Text_C_Attributes_Title",
    Content = "PanelText_UI_Awaker_Item_Info_Text_C_Attributes_Title_Content|Attributes ."
  },
  UI_Awaker_Item_Info_Text_C_Configuration = {
    ID = "UI_Awaker_Item_Info_Text_C_Configuration",
    Content = "PanelText_UI_Awaker_Item_Info_Text_C_Configuration_Content|队伍配置"
  },
  UI_Awaker_Item_Info_Text_C_Love_Title = {
    ID = "UI_Awaker_Item_Info_Text_C_Love_Title",
    Content = "PanelText_UI_Awaker_Item_Info_Text_C_Love_Title_Content|Affinity ."
  },
  UI_Awaker_Item_Info_Text_C_No = {
    ID = "UI_Awaker_Item_Info_Text_C_No",
    Content = "PanelText_UI_Awaker_Item_Info_Text_C_No_Content|未获得"
  },
  UI_Awaker_Item_Skill_Detail_Text_C_Survey = {
    ID = "UI_Awaker_Item_Skill_Detail_Text_C_Survey",
    Content = "PanelText_UI_Awaker_Item_Skill_Detail_Text_C_Survey_Content|调查模式"
  },
  UI_Awaker_Item_Skill_Detail_Text_C_Survey_Click = {
    ID = "UI_Awaker_Item_Skill_Detail_Text_C_Survey_Click",
    Content = "PanelText_UI_Awaker_Item_Skill_Detail_Text_C_Survey_Click_Content|调查模式"
  },
  UI_Awaker_Item_Skill_Detail_Text_C_Problem = {
    ID = "UI_Awaker_Item_Skill_Detail_Text_C_Problem",
    Content = "PanelText_UI_Awaker_Item_Skill_Detail_Text_C_Problem_Content|课题模式"
  },
  UI_Awaker_Item_Skill_Detail_Text_C_Problem_Click = {
    ID = "UI_Awaker_Item_Skill_Detail_Text_C_Problem_Click",
    Content = "PanelText_UI_Awaker_Item_Skill_Detail_Text_C_Problem_Click_Content|课题模式"
  },
  UI_Awaker_Item_Skill_Detail_Text_C_Introduce = {
    ID = "UI_Awaker_Item_Skill_Detail_Text_C_Introduce",
    Content = "PanelText_UI_Awaker_Item_Skill_Detail_Text_C_Introduce_Content|Requirement"
  },
  UI_Awaker_Item_Potency_Detail_Text_C_Warning_EN = {
    ID = "UI_Awaker_Item_Potency_Detail_Text_C_Warning_EN",
    Content = "PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Warning_EN_Content|Requirement"
  },
  UI_Awaker_Item_Potency_Detail_Text_C_Warning_CN = {
    ID = "UI_Awaker_Item_Potency_Detail_Text_C_Warning_CN",
    Content = "PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Warning_CN_Content|已激活"
  },
  UI_Awaker_Item_Potency_Detail_Text_C_Warning_ZN = {
    ID = "UI_Awaker_Item_Potency_Detail_Text_C_Warning_ZN",
    Content = "PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Warning_ZN_Content|Requirement"
  },
  UI_Awaker_Item_Trinket_Change_Text_C_Prop_Title = {
    ID = "UI_Awaker_Item_Trinket_Change_Text_C_Prop_Title",
    Content = "PanelText_UI_Awaker_Item_Trinket_Change_Text_C_Prop_Title_Content|属性"
  },
  ["UI_Awaker_Item_Voice_Text_C_ Voice"] = {
    ID = "UI_Awaker_Item_Voice_Text_C_ Voice",
    Content = "PanelText_UI_Awaker_Item_Voice_Text_C_ Voice_Content|Voiced By ."
  },
  UI_Awaker_PanelStory_Main_Text_C_Message = {
    ID = "UI_Awaker_PanelStory_Main_Text_C_Message",
    Content = "PanelText_UI_Awaker_PanelStory_Main_Text_C_Message_Content|Awaker Info."
  },
  ["UI_Awaker_PanelStory_Main_Text_C_ Describe"] = {
    ID = "UI_Awaker_PanelStory_Main_Text_C_ Describe",
    Content = "PanelText_UI_Awaker_PanelStory_Main_Text_C_ Describe_Content|Description."
  },
  UI_Awaker_Item_Minihead_List_Text_C_State = {
    ID = "UI_Awaker_Item_Minihead_List_Text_C_State",
    Content = "PanelText_UI_Awaker_Item_Minihead_List_Text_C_State_Content|状态"
  },
  UI_Awaker_Item_Minihead_List_Text_C_State_Click = {
    ID = "UI_Awaker_Item_Minihead_List_Text_C_State_Click",
    Content = "PanelText_UI_Awaker_Item_Minihead_List_Text_C_State_Click_Content|状态"
  },
  UI_Awaker_Item_Minihead_List_Text_C_Skill = {
    ID = "UI_Awaker_Item_Minihead_List_Text_C_Skill",
    Content = "PanelText_UI_Awaker_Item_Minihead_List_Text_C_Skill_Content|技能"
  },
  UI_Awaker_Item_Minihead_List_Text_C_Skill_Click = {
    ID = "UI_Awaker_Item_Minihead_List_Text_C_Skill_Click",
    Content = "PanelText_UI_Awaker_Item_Minihead_List_Text_C_Skill_Click_Content|技能"
  },
  UI_Awaker_Item_Minihead_List_Text_C_Enlightenment = {
    ID = "UI_Awaker_Item_Minihead_List_Text_C_Enlightenment",
    Content = "PanelText_UI_Awaker_Item_Minihead_List_Text_C_Enlightenment_Content|启灵"
  },
  UI_Awaker_Item_Minihead_List_Text_C_Enlightenment_Click = {
    ID = "UI_Awaker_Item_Minihead_List_Text_C_Enlightenment_Click",
    Content = "PanelText_UI_Awaker_Item_Minihead_List_Text_C_Enlightenment_Click_Content|启灵"
  },
  UI_Awaker_Item_Minihead_List_Text_C_Weapons = {
    ID = "UI_Awaker_Item_Minihead_List_Text_C_Weapons",
    Content = "PanelText_UI_Awaker_Item_Minihead_List_Text_C_Weapons_Content|命轮"
  },
  UI_Awaker_Item_Minihead_List_Text_C_Weapons_Click = {
    ID = "UI_Awaker_Item_Minihead_List_Text_C_Weapons_Click",
    Content = "PanelText_UI_Awaker_Item_Minihead_List_Text_C_Weapons_Click_Content|命轮"
  },
  UI_Awaker_Item_Minihead_List_Text_C_Michi = {
    ID = "UI_Awaker_Item_Minihead_List_Text_C_Michi",
    Content = "PanelText_UI_Awaker_Item_Minihead_List_Text_C_Michi_Content|密契"
  },
  UI_Awaker_Item_Minihead_List_Text_C_Michi_Click = {
    ID = "UI_Awaker_Item_Minihead_List_Text_C_Michi_Click",
    Content = "PanelText_UI_Awaker_Item_Minihead_List_Text_C_Michi_Click_Content|密契"
  },
  UI_Awaker_Item_Minihead_List_Text_C_Information = {
    ID = "UI_Awaker_Item_Minihead_List_Text_C_Information",
    Content = "PanelText_UI_Awaker_Item_Minihead_List_Text_C_Information_Content|档案"
  },
  UI_Awaker_Item_Minihead_List_Text_C_Information_Click = {
    ID = "UI_Awaker_Item_Minihead_List_Text_C_Information_Click",
    Content = "PanelText_UI_Awaker_Item_Minihead_List_Text_C_Information_Click_Content|档案"
  },
  UI_Battle_Panel_Dbg_Text_C_Slash = {
    ID = "UI_Battle_Panel_Dbg_Text_C_Slash",
    Content = "PanelText_UI_Battle_Panel_Dbg_Text_C_Slash_Content|/"
  },
  UI_Awaker_Popup_Levelup_Tip_Text_C_Title = {
    ID = "UI_Awaker_Popup_Levelup_Tip_Text_C_Title",
    Content = "PanelText_UI_Awaker_Popup_Levelup_Tip_Text_C_Title_Content|等级提升"
  },
  UI_Awaker_Item_Info_Text_C_Score_Force = {
    ID = "UI_Awaker_Item_Info_Text_C_Score_Force",
    Content = "PanelText_UI_Awaker_Item_Info_Text_C_Score_Force_Content|战力"
  },
  UI_Awaker_Item_Info_Text_C_Level = {
    ID = "UI_Awaker_Item_Info_Text_C_Level",
    Content = "PanelText_UI_Awaker_Item_Info_Text_C_Level_Content|Lv."
  },
  UI_Awaker_Item_Info_Text_C_Attribute = {
    ID = "UI_Awaker_Item_Info_Text_C_Attribute",
    Content = "PanelText_UI_Awaker_Item_Info_Text_C_Attribute_Content|属性"
  },
  UI_Awaker_Item_Info_Text_C_Love = {
    ID = "UI_Awaker_Item_Info_Text_C_Love",
    Content = "PanelText_UI_Awaker_Item_Info_Text_C_Love_Content|同调率"
  },
  UI_Awaker_Item_Trinket_Change_Text_C_Tips = {
    ID = "UI_Awaker_Item_Trinket_Change_Text_C_Tips",
    Content = "PanelText_UI_Awaker_Item_Trinket_Change_Text_C_Tips_Content|详细信息"
  },
  UI_Mail_Text_C_Name = {
    ID = "UI_Mail_Text_C_Name",
    Content = "PanelText_UI_Mail_Text_C_Name_Content|领取"
  },
  UI_PopMsg_Text_C_Precautions = {
    ID = "UI_PopMsg_Text_C_Precautions",
    Content = "PanelText_UI_PopMsg_Text_C_Precautions_Content|Notice"
  },
  UI_Common_Popup_Tip_3_Text_C_Screening = {
    ID = "UI_Common_Popup_Tip_3_Text_C_Screening",
    Content = "PanelText_UI_Common_Popup_Tip_3_Text_C_Screening_Content|今日不再提示"
  },
  UI_Alchemy_Popup_Resolve_Text_C_Name = {
    ID = "UI_Alchemy_Popup_Resolve_Text_C_Name",
    Content = "PanelText_UI_Alchemy_Popup_Resolve_Text_C_Name_Content|分解"
  },
  UI_Alchemy_Popup_Recast_Text_C_Name = {
    ID = "UI_Alchemy_Popup_Recast_Text_C_Name",
    Content = "PanelText_UI_Alchemy_Popup_Recast_Text_C_Name_Content|重印"
  },
  UI_Setting_Popup_Code_Text_C_Paste = {
    ID = "UI_Setting_Popup_Code_Text_C_Paste",
    Content = "PanelText_UI_Setting_Popup_Code_Text_C_Paste_Content|粘贴"
  },
  UI_Setting_Popup_Code_Text_C_Clean = {
    ID = "UI_Setting_Popup_Code_Text_C_Clean",
    Content = "PanelText_UI_Setting_Popup_Code_Text_C_Clean_Content|清除"
  },
  UI_Setting_Popup_Code_Text_C_Tips = {
    ID = "UI_Setting_Popup_Code_Text_C_Tips",
    Content = "PanelText_UI_Setting_Popup_Code_Text_C_Tips_Content|输入兑换码"
  },
  UI_Setting_Popup_Down_Text_C_Downing = {
    ID = "UI_Setting_Popup_Down_Text_C_Downing",
    Content = "PanelText_UI_Setting_Popup_Down_Text_C_Downing_Content|资源下载中…"
  },
  UI_Setting_Popup_Examine_Text_C_Examine = {
    ID = "UI_Setting_Popup_Examine_Text_C_Examine",
    Content = "PanelText_UI_Setting_Popup_Examine_Text_C_Examine_Content|正在检查游戏资源的完整性"
  },
  UI_Other_Popup_Key_Time_Revert_Text_C_Title = {
    ID = "UI_Other_Popup_Key_Time_Revert_Text_C_Title",
    Content = "PanelText_UI_Other_Popup_Key_Time_Revert_Text_C_Title_Content|密钥获取"
  },
  UI_Other_Popup_Key_Time_Revert_Text_C_Question = {
    ID = "UI_Other_Popup_Key_Time_Revert_Text_C_Question",
    Content = "PanelText_UI_Other_Popup_Key_Time_Revert_Text_C_Question_Content|要获取密钥吗？"
  },
  UI_Other_Popup_Key_Time_Revert_Text_C_Restore_Title_Now = {
    ID = "UI_Other_Popup_Key_Time_Revert_Text_C_Restore_Title_Now",
    Content = "PanelText_UI_Other_Popup_Key_Time_Revert_Text_C_Restore_Title_Now_Content|持有密钥"
  },
  UI_Other_Popup_Key_Time_Revert_Text_C_Restore_Title_Next = {
    ID = "UI_Other_Popup_Key_Time_Revert_Text_C_Restore_Title_Next",
    Content = "PanelText_UI_Other_Popup_Key_Time_Revert_Text_C_Restore_Title_Next_Content|消耗密钥"
  },
  UI_Other_Popup_Key_Time_Revert_Text_C_Cost_Title_Now = {
    ID = "UI_Other_Popup_Key_Time_Revert_Text_C_Cost_Title_Now",
    Content = "PanelText_UI_Other_Popup_Key_Time_Revert_Text_C_Cost_Title_Now_Content|当前银芯结晶"
  },
  UI_Other_Popup_Key_Time_Revert_Text_C_Cost_Title_Next = {
    ID = "UI_Other_Popup_Key_Time_Revert_Text_C_Cost_Title_Next",
    Content = "PanelText_UI_Other_Popup_Key_Time_Revert_Text_C_Cost_Title_Next_Content|消耗银芯结晶"
  },
  UI_Awaker_Item_Topped_Detail_Text_C_Material = {
    ID = "UI_Awaker_Item_Topped_Detail_Text_C_Material",
    Content = "PanelText_UI_Awaker_Item_Topped_Detail_Text_C_Material_Content|升格材料"
  },
  UI_Awaker_Item_Topped_Detail_Text_C_New = {
    ID = "UI_Awaker_Item_Topped_Detail_Text_C_New",
    Content = "PanelText_UI_Awaker_Item_Topped_Detail_Text_C_New_Content|可激活新技能"
  },
  UI_Battle_Popup_Record_Tip_Text_C_Title_Awakening = {
    ID = "UI_Battle_Popup_Record_Tip_Text_C_Title_Awakening",
    Content = "PanelText_UI_Battle_Popup_Record_Tip_Text_C_Title_Awakening_Content|灵知觉醒"
  },
  UI_Battle_Popup_Record_Tip_Text_C_Title_Weapon = {
    ID = "UI_Battle_Popup_Record_Tip_Text_C_Title_Weapon",
    Content = "PanelText_UI_Battle_Popup_Record_Tip_Text_C_Title_Weapon_Content|命轮"
  },
  UI_Battle_Popup_Record_Tip_Text_C_Title_Trinket = {
    ID = "UI_Battle_Popup_Record_Tip_Text_C_Title_Trinket",
    Content = "PanelText_UI_Battle_Popup_Record_Tip_Text_C_Title_Trinket_Content|密契"
  },
  UI_Battle_Panel_Dbg_Text_C_Zongshanghai = {
    ID = "UI_Battle_Panel_Dbg_Text_C_Zongshanghai",
    Content = "PanelText_UI_Battle_Panel_Dbg_Text_C_Zongshanghai_Content|总伤害"
  },
  Item_Battle_AwakerSkill_1_Text_C_Ready = {
    ID = "Item_Battle_AwakerSkill_1_Text_C_Ready",
    Content = "PanelText_Item_Battle_AwakerSkill_1_Text_C_Ready_Content|狂气爆发"
  },
  GmEntryPanel_Text_C_Gm = {
    ID = "GmEntryPanel_Text_C_Gm",
    Content = "PanelText_GmEntryPanel_Text_C_Gm_Content|GM"
  },
  GmPanel_Text_C_Gb = {
    ID = "GmPanel_Text_C_Gb",
    Content = "PanelText_GmPanel_Text_C_Gb_Content|关闭"
  },
  GmPanel_Text_C_Placeholder = {
    ID = "GmPanel_Text_C_Placeholder",
    Content = "PanelText_GmPanel_Text_C_Placeholder_Content|输入搜索"
  },
  GmPanel_Text_C_Yc = {
    ID = "GmPanel_Text_C_Yc",
    Content = "PanelText_GmPanel_Text_C_Yc_Content|隐藏GM面板"
  },
  GmPanel_Text_C_Hm = {
    ID = "GmPanel_Text_C_Hm",
    Content = "PanelText_GmPanel_Text_C_Hm_Content|切换画面效果高/低配"
  },
  GmPanel_Text_C_Xy = {
    ID = "GmPanel_Text_C_Xy",
    Content = "PanelText_GmPanel_Text_C_Xy_Content|测试协议"
  },
  GmParamEquipPanel_Text_C_Tc = {
    ID = "GmParamEquipPanel_Text_C_Tc",
    Content = "PanelText_GmParamEquipPanel_Text_C_Tc_Content|退 出"
  },
  GmParamEquipPanel_Text_C_Fs = {
    ID = "GmParamEquipPanel_Text_C_Fs",
    Content = "PanelText_GmParamEquipPanel_Text_C_Fs_Content|发 送"
  },
  GmParamPanel_Text_C_Tc = {
    ID = "GmParamPanel_Text_C_Tc",
    Content = "PanelText_GmParamPanel_Text_C_Tc_Content|退 出"
  },
  Icon_Common_Text_C_New = {
    ID = "Icon_Common_Text_C_New",
    Content = "PanelText_Icon_Common_Text_C_New_Content|新"
  },
  Icon_Common_Text_C_NoEquip = {
    ID = "Icon_Common_Text_C_NoEquip",
    Content = "PanelText_Icon_Common_Text_C_NoEquip_Content|无法装备"
  },
  GmParamPanel_Text_C_Fs = {
    ID = "GmParamPanel_Text_C_Fs",
    Content = "PanelText_GmParamPanel_Text_C_Fs_Content|发 送"
  },
  UI_Dungeous_Weekly_Main_Text_C_Again = {
    ID = "UI_Dungeous_Weekly_Main_Text_C_Again",
    Content = "PanelText_UI_Dungeous_Weekly_Main_Text_C_Again_Content|重置挑战"
  },
  UI_Chapter_Panel_Main_Text_C_Tishi = {
    ID = "UI_Chapter_Panel_Main_Text_C_Tishi",
    Content = "PanelText_UI_Chapter_Panel_Main_Text_C_Tishi_Content|关卡评分"
  },
  UI_Chapter_Popup_Monster_Details_Text_C_Title = {
    ID = "UI_Chapter_Popup_Monster_Details_Text_C_Title",
    Content = "PanelText_UI_Chapter_Popup_Monster_Details_Text_C_Title_Content|敌方详情"
  },
  UI_Chapter_Popup_Achievement_Text_C_Title = {
    ID = "UI_Chapter_Popup_Achievement_Text_C_Title",
    Content = "PanelText_UI_Chapter_Popup_Achievement_Text_C_Title_Content|成就"
  },
  UI_Chaper_Popup_Particulars_Text_C_Title = {
    ID = "UI_Chaper_Popup_Particulars_Text_C_Title",
    Content = "PanelText_UI_Chaper_Popup_Particulars_Text_C_Title_Content|奖励预览"
  },
  UI_Chaper_Popup_StageAchieve_View_Text_C_OneKey = {
    ID = "UI_Chaper_Popup_StageAchieve_View_Text_C_OneKey",
    Content = "PanelText_UI_Chaper_Popup_StageAchieve_View_Text_C_OneKey_Content|一键领取"
  },
  UI_Awaker_Item_Info_Text_C_Xx = {
    ID = "UI_Awaker_Item_Info_Text_C_Xx",
    Content = "PanelText_UI_Awaker_Item_Info_Text_C_Xx_Content|详细信息"
  },
  UI_Awaker_Popup_Skillup_Tip_Text_C_Content = {
    ID = "UI_Awaker_Popup_Skillup_Tip_Text_C_Content",
    Content = "PanelText_UI_Awaker_Popup_Skillup_Tip_Text_C_Content_Content|等级上限"
  },
  UI_Awaker_Popup_Skillup_Tip_Text_C_Xuyao = {
    ID = "UI_Awaker_Popup_Skillup_Tip_Text_C_Xuyao",
    Content = "PanelText_UI_Awaker_Popup_Skillup_Tip_Text_C_Xuyao_Content|需要"
  },
  UI_Awaker_Popup_Skillup_Tip_Text_C_Title = {
    ID = "UI_Awaker_Popup_Skillup_Tip_Text_C_Title",
    Content = "PanelText_UI_Awaker_Popup_Skillup_Tip_Text_C_Title_Content|技能升级"
  },
  UI_Awaker_Popup_Levelup_Tip_Text_C_Xuyao = {
    ID = "UI_Awaker_Popup_Levelup_Tip_Text_C_Xuyao",
    Content = "PanelText_UI_Awaker_Popup_Levelup_Tip_Text_C_Xuyao_Content|需要"
  },
  UI_Awaker_Popup_Levelup_Tip_Text_C_Content = {
    ID = "UI_Awaker_Popup_Levelup_Tip_Text_C_Content",
    Content = "PanelText_UI_Awaker_Popup_Levelup_Tip_Text_C_Content_Content|升至上限"
  },
  UI_Chaper_Popup_Award_Text_C_Title = {
    ID = "UI_Chaper_Popup_Award_Text_C_Title",
    Content = "PanelText_UI_Chaper_Popup_Award_Text_C_Title_Content|累计奖励"
  },
  UI_Battle_Panel_CardStack_Text_C_Normal_CN = {
    ID = "UI_Battle_Panel_CardStack_Text_C_Normal_CN",
    Content = "PanelText_UI_Battle_Panel_CardStack_Text_C_Normal_CN_Content|确 认"
  },
  UI_Battle_Panel_CardStack_Text_C_High_CN = {
    ID = "UI_Battle_Panel_CardStack_Text_C_High_CN",
    Content = "PanelText_UI_Battle_Panel_CardStack_Text_C_High_CN_Content|确 认"
  },
  UI_Battle_Panel_CardStack_Text_C_Disabled_CN = {
    ID = "UI_Battle_Panel_CardStack_Text_C_Disabled_CN",
    Content = "PanelText_UI_Battle_Panel_CardStack_Text_C_Disabled_CN_Content|确 认"
  },
  UI_Dungeous_Item_Popup_Award_Text_C_Lost = {
    ID = "UI_Dungeous_Item_Popup_Award_Text_C_Lost",
    Content = "PanelText_UI_Dungeous_Item_Popup_Award_Text_C_Lost_Content|未达成"
  },
  UI_Dungeous_Item_Popup_Award_Text_C_Title = {
    ID = "UI_Dungeous_Item_Popup_Award_Text_C_Title",
    Content = "PanelText_UI_Dungeous_Item_Popup_Award_Text_C_Title_Content|本关评分星级达"
  },
  UI_Homeland_Item_Building_Text_C_Done = {
    ID = "UI_Homeland_Item_Building_Text_C_Done",
    Content = "PanelText_UI_Homeland_Item_Building_Text_C_Done_Content|已满"
  },
  UI_Announcement_Item_Title_Text_New_Info = {
    ID = "UI_Announcement_Item_Title_Text_New_Info",
    Content = "PanelText_UI_Announcement_Item_Title_Text_New_Info_Content|新"
  },
  UI_Pocket_Mail_Text_C_Tips = {
    ID = "UI_Pocket_Mail_Text_C_Tips",
    Content = "PanelText_UI_Pocket_Mail_Text_C_Tips_Content|珍藏数"
  },
  UI_Pocket_Mail_Text_C_Title = {
    ID = "UI_Pocket_Mail_Text_C_Title",
    Content = "PanelText_UI_Pocket_Mail_Text_C_Title_Content|暂无信件"
  },
  UI_Pocket_Mail_Text_C_Title2 = {
    ID = "UI_Pocket_Mail_Text_C_Title2",
    Content = "PanelText_UI_Pocket_Mail_Text_C_Title2_Content|去其他地方看看吧"
  },
  UI_Pocket_Mail_Text_C_select_Title = {
    ID = "UI_Pocket_Mail_Text_C_select_Title",
    Content = "PanelText_UI_Pocket_Mail_Text_C_select_Title_Content|选择一封信件"
  },
  UI_Dungeous_Weekly_Difficulty_Text_C_Again = {
    ID = "UI_Dungeous_Weekly_Difficulty_Text_C_Again",
    Content = "PanelText_UI_Dungeous_Weekly_Difficulty_Text_C_Again_Content|重置挑战"
  },
  UI_Recharge_Exchange_Text_C_Buy_Title = {
    ID = "UI_Recharge_Exchange_Text_C_Buy_Title",
    Content = "PanelText_UI_Recharge_Exchange_Text_C_Buy_Title_Content|兑换银芯数量"
  },
  UI_Recharge_Exchange_Text_C_Cost_Tips = {
    ID = "UI_Recharge_Exchange_Text_C_Cost_Tips",
    Content = "PanelText_UI_Recharge_Exchange_Text_C_Cost_Tips_Content|消耗"
  },
  UI_Recharge_Exchange_Text_C_Least = {
    ID = "UI_Recharge_Exchange_Text_C_Least",
    Content = "PanelText_UI_Recharge_Exchange_Text_C_Least_Content|最小"
  },
  UI_Recharge_Exchange_Text_C_Utmost = {
    ID = "UI_Recharge_Exchange_Text_C_Utmost",
    Content = "PanelText_UI_Recharge_Exchange_Text_C_Utmost_Content|最大"
  },
  UI_Recharge_Panel_Main_Text_C_Title = {
    ID = "UI_Recharge_Panel_Main_Text_C_Title",
    Content = "PanelText_UI_Recharge_Panel_Main_Text_C_Title_Content|弥萨格商店"
  },
  UI_Recharge_Panel_Main_Text_C_Extra = {
    ID = "UI_Recharge_Panel_Main_Text_C_Extra",
    Content = "PanelText_UI_Recharge_Panel_Main_Text_C_Extra_Content|额外"
  },
  UI_Recharge_Panel_Main_Text_C_Double = {
    ID = "UI_Recharge_Panel_Main_Text_C_Double",
    Content = "PanelText_UI_Recharge_Panel_Main_Text_C_Double_Content|额外"
  },
  UI_Recharge_Panel_Main_Text_C_Buttom_Tips = {
    ID = "UI_Recharge_Panel_Main_Text_C_Buttom_Tips",
    Content = "PanelText_UI_Recharge_Panel_Main_Text_C_Buttom_Tips_Content|每档首充额外赠送等量「源液」，仅限一次"
  },
  UI_Recharge_Panel_Main_Text_C_Bigtitle = {
    ID = "UI_Recharge_Panel_Main_Text_C_Bigtitle",
    Content = "PanelText_UI_Recharge_Panel_Main_Text_C_Bigtitle_Content|月相观测"
  },
  UI_Recharge_Panel_Main_Text_C_Get1_Title = {
    ID = "UI_Recharge_Panel_Main_Text_C_Get1_Title",
    Content = "PanelText_UI_Recharge_Panel_Main_Text_C_Get1_Title_Content|立即获得"
  },
  UI_Recharge_Panel_Main_Text_C_Get2_Title = {
    ID = "UI_Recharge_Panel_Main_Text_C_Get2_Title",
    Content = "PanelText_UI_Recharge_Panel_Main_Text_C_Get2_Title_Content|每日赠送"
  },
  UI_Recharge_Panel_Main_Text_C_Get2_Title2 = {
    ID = "UI_Recharge_Panel_Main_Text_C_Get2_Title2",
    Content = "PanelText_UI_Recharge_Panel_Main_Text_C_Get2_Title2_Content|（30天）"
  },
  UI_Recharge_Panel_Main_Text_C_Tips = {
    ID = "UI_Recharge_Panel_Main_Text_C_Tips",
    Content = "PanelText_UI_Recharge_Panel_Main_Text_C_Tips_Content|*累计可获得「银芯」× 300 +「银芯」× 6000"
  },
  UI_Recharge_Panel_Main_Text_C_Buy = {
    ID = "UI_Recharge_Panel_Main_Text_C_Buy",
    Content = "PanelText_UI_Recharge_Panel_Main_Text_C_Buy_Content|购买"
  },
  UI_Recharge_Panel_Main_Text_C_Illustrate = {
    ID = "UI_Recharge_Panel_Main_Text_C_Illustrate",
    Content = "PanelText_UI_Recharge_Panel_Main_Text_C_Illustrate_Content|可累计购买"
  },
  UI_Recharge_Panel_Main_Text_C_Expired = {
    ID = "UI_Recharge_Panel_Main_Text_C_Expired",
    Content = "PanelText_UI_Recharge_Panel_Main_Text_C_Expired_Content|已过期"
  },
  UI_Recharge_Panel_Main_Text_C_Toggle_Normal_Month = {
    ID = "UI_Recharge_Panel_Main_Text_C_Toggle_Normal_Month",
    Content = "PanelText_UI_Recharge_Panel_Main_Text_C_Toggle_Normal_Month_Content|月相观测"
  },
  UI_Recharge_Panel_Main_Text_C_Toggle_Select_Month = {
    ID = "UI_Recharge_Panel_Main_Text_C_Toggle_Select_Month",
    Content = "PanelText_UI_Recharge_Panel_Main_Text_C_Toggle_Select_Month_Content|月相观测"
  },
  UI_Recharge_Panel_Main_Text_C_Toggle_Normal_Root = {
    ID = "UI_Recharge_Panel_Main_Text_C_Toggle_Normal_Root",
    Content = "PanelText_UI_Recharge_Panel_Main_Text_C_Toggle_Normal_Root_Content|根源浮沫"
  },
  UI_Recharge_Panel_Main_Text_C_Toggle_Select_Root = {
    ID = "UI_Recharge_Panel_Main_Text_C_Toggle_Select_Root",
    Content = "PanelText_UI_Recharge_Panel_Main_Text_C_Toggle_Select_Root_Content|根源浮沫"
  },
  UI_Recharge_Panel_Main_Text_C_Toggle_Normal_Recharge = {
    ID = "UI_Recharge_Panel_Main_Text_C_Toggle_Normal_Recharge",
    Content = "PanelText_UI_Recharge_Panel_Main_Text_C_Toggle_Normal_Recharge_Content|充值"
  },
  UI_Recharge_Panel_Main_Text_C_Toggle_Select_Recharge = {
    ID = "UI_Recharge_Panel_Main_Text_C_Toggle_Select_Recharge",
    Content = "PanelText_UI_Recharge_Panel_Main_Text_C_Toggle_Select_Recharge_Content|充值"
  },
  UI_Recharge_Panel_Main_Text_C_Refresh = {
    ID = "UI_Recharge_Panel_Main_Text_C_Refresh",
    Content = "PanelText_UI_Recharge_Panel_Main_Text_C_Refresh_Content|联系客服"
  },
  UI_Recharge_Reset_Item_Text_C_Extra = {
    ID = "UI_Recharge_Reset_Item_Text_C_Extra",
    Content = "PanelText_UI_Recharge_Reset_Item_Text_C_Extra_Content|额外"
  },
  UI_Recharge_Reset_Item_Text_C_Double = {
    ID = "UI_Recharge_Reset_Item_Text_C_Double",
    Content = "PanelText_UI_Recharge_Reset_Item_Text_C_Double_Content|首充"
  },
  UI_Recharge_Panel_Main_Text_C_Bigitle = {
    ID = "UI_Recharge_Panel_Main_Text_C_Bigitle",
    Content = "PanelText_UI_Recharge_Panel_Main_Text_C_Bigitle_Content|月相观测"
  },
  UI_Recharge_Panel_Main_Text_Toggle_Normal_Month = {
    ID = "UI_Recharge_Panel_Main_Text_Toggle_Normal_Month",
    Content = "PanelText_UI_Recharge_Panel_Main_Text_Toggle_Normal_Month_Content|月相观测"
  },
  UI_Recharge_Panel_Main_Text_Toggle_Select_Month = {
    ID = "UI_Recharge_Panel_Main_Text_Toggle_Select_Month",
    Content = "PanelText_UI_Recharge_Panel_Main_Text_Toggle_Select_Month_Content|月相观测"
  },
  UI_Recharge_Panel_Main_Text_Toggle_Normal_Root = {
    ID = "UI_Recharge_Panel_Main_Text_Toggle_Normal_Root",
    Content = "PanelText_UI_Recharge_Panel_Main_Text_Toggle_Normal_Root_Content|根源浮沫"
  },
  UI_Recharge_Panel_Main_Text_Toggle_Select_Root = {
    ID = "UI_Recharge_Panel_Main_Text_Toggle_Select_Root",
    Content = "PanelText_UI_Recharge_Panel_Main_Text_Toggle_Select_Root_Content|根源浮沫"
  },
  UI_Recharge_Panel_Main_Text_Toggle_Normal_Recharge = {
    ID = "UI_Recharge_Panel_Main_Text_Toggle_Normal_Recharge",
    Content = "PanelText_UI_Recharge_Panel_Main_Text_Toggle_Normal_Recharge_Content|充值"
  },
  UI_Recharge_Panel_Main_Text_Toggle_Select_Recharge = {
    ID = "UI_Recharge_Panel_Main_Text_Toggle_Select_Recharge",
    Content = "PanelText_UI_Recharge_Panel_Main_Text_Toggle_Select_Recharge_Content|充值"
  },
  UI_Awaker_Popup_Tip_Succeed_Text_C_Succeed = {
    ID = "UI_Awaker_Popup_Tip_Succeed_Text_C_Succeed",
    Content = "PanelText_UI_Awaker_Popup_Tip_Succeed_Text_C_Succeed_Content|升格成功"
  },
  UI_Awaker_Popup_Tip_Succeed_Text_C_New = {
    ID = "UI_Awaker_Popup_Tip_Succeed_Text_C_New",
    Content = "PanelText_UI_Awaker_Popup_Tip_Succeed_Text_C_New_Content|可激活新技能"
  },
  UI_Dbgcopy_Panel_Action_Text_C_Arousal_Sellout = {
    ID = "UI_Dbgcopy_Panel_Action_Text_C_Arousal_Sellout",
    Content = "PanelText_UI_Dbgcopy_Panel_Action_Text_C_Arousal_Sellout_Content|售罄"
  },
  UI_Dbgcopy_Panel_Action_Text_C_Sell_Sellout = {
    ID = "UI_Dbgcopy_Panel_Action_Text_C_Sell_Sellout",
    Content = "PanelText_UI_Dbgcopy_Panel_Action_Text_C_Sell_Sellout_Content|售罄"
  },
  UI_Dbgcopy_Panel_Action_Text_C_Curse = {
    ID = "UI_Dbgcopy_Panel_Action_Text_C_Curse",
    Content = "PanelText_UI_Dbgcopy_Panel_Action_Text_C_Curse_Content|诅咒之间"
  },
  UI_Battle_Popup_Record_Tip_New_Text_C_Skill_Tag = {
    ID = "UI_Battle_Popup_Record_Tip_New_Text_C_Skill_Tag",
    Content = "PanelText_UI_Battle_Popup_Record_Tip_New_Text_C_Skill_Tag_Content|狂气爆发"
  },
  UI_Bag_Item_Detail_Text_C_Weapon_Physique = {
    ID = "UI_Bag_Item_Detail_Text_C_Weapon_Physique",
    Content = "PanelText_UI_Bag_Item_Detail_Text_C_Weapon_Physique_Content|基础体质"
  },
  UI_Bag_Item_Detail_Text_C_Weapon_Attack = {
    ID = "UI_Bag_Item_Detail_Text_C_Weapon_Attack",
    Content = "PanelText_UI_Bag_Item_Detail_Text_C_Weapon_Attack_Content|基础攻击"
  },
  UI_Bag_Item_Detail_Text_C_Weapon_Defense = {
    ID = "UI_Bag_Item_Detail_Text_C_Weapon_Defense",
    Content = "PanelText_UI_Bag_Item_Detail_Text_C_Weapon_Defense_Content|基础防御"
  },
  UI_Bag_Item_Detail_Text_C_Source = {
    ID = "UI_Bag_Item_Detail_Text_C_Source",
    Content = "PanelText_UI_Bag_Item_Detail_Text_C_Source_Content|获取来源"
  },
  UI_Common_Item_Detail_Text_C_Source = {
    ID = "UI_Common_Item_Detail_Text_C_Source",
    Content = "PanelText_UI_Common_Item_Detail_Text_C_Source_Content|获取来源"
  },
  UI_Shop_Popup_Tips_Text_C_Tips = {
    ID = "UI_Shop_Popup_Tips_Text_C_Tips",
    Content = "PanelText_UI_Shop_Popup_Tips_Text_C_Tips_Content|货币不足"
  },
  UI_Shop_Popup_Tips_Text_C_Quantity = {
    ID = "UI_Shop_Popup_Tips_Text_C_Quantity",
    Content = "PanelText_UI_Shop_Popup_Tips_Text_C_Quantity_Content|1"
  },
  UI_Chapter_Popup_Chapter_Text_C_Need = {
    ID = "UI_Chapter_Popup_Chapter_Text_C_Need",
    Content = "PanelText_UI_Chapter_Popup_Chapter_Text_C_Need_Content|需要"
  },
  UI_Chapter_Popup_Vibes_List_Text_C_Need = {
    ID = "UI_Chapter_Popup_Vibes_List_Text_C_Need",
    Content = "PanelText_UI_Chapter_Popup_Vibes_List_Text_C_Need_Content|需要"
  },
  UI_Awaker_Item_Skill_Detail_Text_C_Special = {
    ID = "UI_Awaker_Item_Skill_Detail_Text_C_Special",
    Content = "PanelText_UI_Awaker_Item_Skill_Detail_Text_C_Special_Content|特殊"
  },
  UI_Awaker_Item_Skill_Detail_Text_C_Special_Click = {
    ID = "UI_Awaker_Item_Skill_Detail_Text_C_Special_Click",
    Content = "PanelText_UI_Awaker_Item_Skill_Detail_Text_C_Special_Click_Content|特殊"
  },
  UI_Awaker_Button_Addition_Text_C_Tips = {
    ID = "UI_Awaker_Button_Addition_Text_C_Tips",
    Content = "PanelText_UI_Awaker_Button_Addition_Text_C_Tips_Content|加成"
  },
  UI_Homeland_Panel_Main_Text_C_Tips = {
    ID = "UI_Homeland_Panel_Main_Text_C_Tips",
    Content = "PanelText_UI_Homeland_Panel_Main_Text_C_Tips_Content|加成总览"
  },
  UI_Other_Popup_Trinket_LevelUp_Text_C_Success = {
    ID = "UI_Other_Popup_Trinket_LevelUp_Text_C_Success",
    Content = "PanelText_UI_Other_Popup_Trinket_LevelUp_Text_C_Success_Content|强化成功"
  },
  Item_Battle_AwakerSkill_1_Text_C_CD = {
    ID = "Item_Battle_AwakerSkill_1_Text_C_CD",
    Content = "PanelText_Item_Battle_AwakerSkill_1_Text_C_CD_Content|冷却中"
  },
  UI_Battle_Popup_Anger_Text_C_CD = {
    ID = "UI_Battle_Popup_Anger_Text_C_CD",
    Content = "PanelText_UI_Battle_Popup_Anger_Text_C_CD_Content|冷却中"
  },
  UI_Awaker_Special_Skill_Main_Text_C_Title = {
    ID = "UI_Awaker_Special_Skill_Main_Text_C_Title",
    Content = "PanelText_UI_Awaker_Special_Skill_Main_Text_C_Title_Content|唤醒体天赋"
  },
  UI_Awaker_Special_Skill_Main_Text_C_Type = {
    ID = "UI_Awaker_Special_Skill_Main_Text_C_Type",
    Content = "PanelText_UI_Awaker_Special_Skill_Main_Text_C_Type_Content|类型"
  },
  UI_Awaker_Special_Skill_Main_Text_C_Tips = {
    ID = "UI_Awaker_Special_Skill_Main_Text_C_Tips",
    Content = "PanelText_UI_Awaker_Special_Skill_Main_Text_C_Tips_Content|总览"
  },
  UI_Awaker_Item_Weapon_Strengthen_Text_C_Fast = {
    ID = "UI_Awaker_Item_Weapon_Strengthen_Text_C_Fast",
    Content = "PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Fast_Content|快捷置入"
  },
  UI_Awaker_Item_Weapon_Strengthen_Text_C_Breakthrough = {
    ID = "UI_Awaker_Item_Weapon_Strengthen_Text_C_Breakthrough",
    Content = "PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Breakthrough_Content|升格"
  },
  UI_Awaker_Item_Weapon_Strengthen_Text_C_Equip = {
    ID = "UI_Awaker_Item_Weapon_Strengthen_Text_C_Equip",
    Content = "PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Equip_Content|装备中"
  },
  UI_Awaker_Item_Weapon_Strengthen_Text_C_Enhance = {
    ID = "UI_Awaker_Item_Weapon_Strengthen_Text_C_Enhance",
    Content = "PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Enhance_Content|强化"
  },
  UI_Other_Physical_Tips_Text_Name = {
    ID = "UI_Other_Physical_Tips_Text_Name",
    Content = "PanelText_UI_Other_Physical_Tips_Text_Name_Content|取消"
  },
  UI_Passport_Panel_Main_Text_C_Mail = {
    ID = "UI_Passport_Panel_Main_Text_C_Mail",
    Content = "PanelText_UI_Passport_Panel_Main_Text_C_Mail_Content|规则说明"
  },
  UI_Passport_Panel_Main_Text_C_Instructions_Grade = {
    ID = "UI_Passport_Panel_Main_Text_C_Instructions_Grade",
    Content = "PanelText_UI_Passport_Panel_Main_Text_C_Instructions_Grade_Content|课题等级"
  },
  UI_Passport_Panel_Main_Text_C_Experience = {
    ID = "UI_Passport_Panel_Main_Text_C_Experience",
    Content = "PanelText_UI_Passport_Panel_Main_Text_C_Experience_Content|课题经验"
  },
  UI_Passport_Panel_Main_Text_C_Online = {
    ID = "UI_Passport_Panel_Main_Text_C_Online",
    Content = "PanelText_UI_Passport_Panel_Main_Text_C_Online_Content|本周经验上限"
  },
  UI_Passport_Panel_Main_Text_C_Full = {
    ID = "UI_Passport_Panel_Main_Text_C_Full",
    Content = "PanelText_UI_Passport_Panel_Main_Text_C_Full_Content|已满级"
  },
  UI_Passport_Exchange_Text_C_Cost_Tips = {
    ID = "UI_Passport_Exchange_Text_C_Cost_Tips",
    Content = "PanelText_UI_Passport_Exchange_Text_C_Cost_Tips_Content|需要"
  },
  UI_Passport_Exchange_Text_C_Buy_Title = {
    ID = "UI_Passport_Exchange_Text_C_Buy_Title",
    Content = "PanelText_UI_Passport_Exchange_Text_C_Buy_Title_Content|提升等级"
  },
  UI_Passport_Exchange_Text_C_Title = {
    ID = "UI_Passport_Exchange_Text_C_Title",
    Content = "PanelText_UI_Passport_Exchange_Text_C_Title_Content|提升课题等级"
  },
  UI_Passport_Exchange_Text_C_Title_En = {
    ID = "UI_Passport_Exchange_Text_C_Title_En",
    Content = "PanelText_UI_Passport_Exchange_Text_C_Title_En_Content|Level Up."
  },
  UI_Passport_Panel_Main_Text_C_Name = {
    ID = "UI_Passport_Panel_Main_Text_C_Name",
    Content = "PanelText_UI_Passport_Panel_Main_Text_C_Name_Content|提升等级"
  },
  UI_Passport_Reward_Item_Text_C_Ordinary_Title = {
    ID = "UI_Passport_Reward_Item_Text_C_Ordinary_Title",
    Content = "PanelText_UI_Passport_Reward_Item_Text_C_Ordinary_Title_Content|基础课题"
  },
  UI_Passport_Reward_Item_Text_C_Senior_Title = {
    ID = "UI_Passport_Reward_Item_Text_C_Senior_Title",
    Content = "PanelText_UI_Passport_Reward_Item_Text_C_Senior_Title_Content|高阶课题"
  },
  UI_Passport_Reward_Item_Text_C_Tab_Special = {
    ID = "UI_Passport_Reward_Item_Text_C_Tab_Special",
    Content = "PanelText_UI_Passport_Reward_Item_Text_C_Tab_Special_Content|高级"
  },
  UI_Passport_Reward_Item_Text_C_Timing = {
    ID = "UI_Passport_Reward_Item_Text_C_Timing",
    Content = "PanelText_UI_Passport_Reward_Item_Text_C_Timing_Content|本期剩余时间"
  },
  UI_Passport_Reward_Item_Text_C_Senior = {
    ID = "UI_Passport_Reward_Item_Text_C_Senior",
    Content = "PanelText_UI_Passport_Reward_Item_Text_C_Senior_Content|课题进阶"
  },
  UI_Passport_Reward_Item_Text_C_Name = {
    ID = "UI_Passport_Reward_Item_Text_C_Name",
    Content = "PanelText_UI_Passport_Reward_Item_Text_C_Name_Content|一键领取"
  },
  UI_Passport_Task_Description_Text_C_Name = {
    ID = "UI_Passport_Task_Description_Text_C_Name",
    Content = "PanelText_UI_Passport_Task_Description_Text_C_Name_Content|领取"
  },
  UI_Passport_Task_Choose_Text_C_Tab_Special = {
    ID = "UI_Passport_Task_Choose_Text_C_Tab_Special",
    Content = "PanelText_UI_Passport_Task_Choose_Text_C_Tab_Special_Content|活动"
  },
  UI_Login_Popup_Tips_Text_C_Game = {
    ID = "UI_Login_Popup_Tips_Text_C_Game",
    Content = "PanelText_UI_Login_Popup_Tips_Text_C_Game_Content|公告"
  },
  UI_Login_Popup_Tips_Text_C_Activity = {
    ID = "UI_Login_Popup_Tips_Text_C_Activity",
    Content = "PanelText_UI_Login_Popup_Tips_Text_C_Activity_Content|活动告示"
  },
  UI_Awaker_Item_Weapon_Strengthen_Text_C_Refine = {
    ID = "UI_Awaker_Item_Weapon_Strengthen_Text_C_Refine",
    Content = "PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Refine_Content|叠位"
  },
  UI_Passport_illustrate_Tip_Text_C_Title = {
    ID = "UI_Passport_illustrate_Tip_Text_C_Title",
    Content = "PanelText_UI_Passport_illustrate_Tip_Text_C_Title_Content|规则说明"
  },
  UI_Passport_Money_Item_Text_C_Name = {
    ID = "UI_Passport_Money_Item_Text_C_Name",
    Content = "PanelText_UI_Passport_Money_Item_Text_C_Name_Content|课题礼匣"
  },
  UI_Passport_Money_Item_Text_C_Senior = {
    ID = "UI_Passport_Money_Item_Text_C_Senior",
    Content = "PanelText_UI_Passport_Money_Item_Text_C_Senior_Content|高阶课题"
  },
  UI_Passport_Money_Item_Text_C_Super = {
    ID = "UI_Passport_Money_Item_Text_C_Super",
    Content = "PanelText_UI_Passport_Money_Item_Text_C_Super_Content|核心课题"
  },
  UI_Passport_Money_Item_Text_C_Introduce = {
    ID = "UI_Passport_Money_Item_Text_C_Introduce",
    Content = "PanelText_UI_Passport_Money_Item_Text_C_Introduce_Content|封装着珍贵命轮的精制礼匣，纯手工打造。\n解锁高阶课题并提升到40级，可在课题礼匣中挑选一个命轮或「流明之芯」×5作为奖励。"
  },
  UI_Passport_Money_Item_Text_C_Prompt = {
    ID = "UI_Passport_Money_Item_Text_C_Prompt",
    Content = "PanelText_UI_Passport_Money_Item_Text_C_Prompt_Content|请适度娱乐，理性消费"
  },
  UI_Passport_Money_Item_Text_C_Purchase_1 = {
    ID = "UI_Passport_Money_Item_Text_C_Purchase_1",
    Content = "PanelText_UI_Passport_Money_Item_Text_C_Purchase_1_Content|已购买"
  },
  UI_Passport_Money_Item_Text_C_Purchase_2 = {
    ID = "UI_Passport_Money_Item_Text_C_Purchase_2",
    Content = "PanelText_UI_Passport_Money_Item_Text_C_Purchase_2_Content|已购买"
  },
  UI_Passport_Popup_Player_LevelUp_Text_C_Title = {
    ID = "UI_Passport_Popup_Player_LevelUp_Text_C_Title",
    Content = "PanelText_UI_Passport_Popup_Player_LevelUp_Text_C_Title_Content|课题等级提升"
  },
  UI_Passport_Praising_Item_Text_C_Title = {
    ID = "UI_Passport_Praising_Item_Text_C_Title",
    Content = "PanelText_UI_Passport_Praising_Item_Text_C_Title_Content|课题礼匣"
  },
  UI_Passport_Praising_Item_Text_C_Content = {
    ID = "UI_Passport_Praising_Item_Text_C_Content",
    Content = "PanelText_UI_Passport_Praising_Item_Text_C_Content_Content|封装着珍贵命轮的精制礼匣，纯手工打造。\n解锁高阶课题并提升到40级，可在课题礼匣中挑选一个命轮或「流明之芯」×5作为奖励。"
  },
  UI_Passport_Show_Item_Text_C_Time_1 = {
    ID = "UI_Passport_Show_Item_Text_C_Time_1",
    Content = "PanelText_UI_Passport_Show_Item_Text_C_Time_1_Content|本期剩余活动时间"
  },
  UI_Passport_Show_Item_Text_C_Reward = {
    ID = "UI_Passport_Show_Item_Text_C_Reward",
    Content = "PanelText_UI_Passport_Show_Item_Text_C_Reward_Content|本期礼匣预览"
  },
  UI_Passport_Show_Item_Text_C_Introduce = {
    ID = "UI_Passport_Show_Item_Text_C_Introduce",
    Content = "PanelText_UI_Passport_Show_Item_Text_C_Introduce_Content|解锁高阶课题并提升到40级，可在课题礼匣中选一个命轮或「流明之芯」×5作为奖励"
  },
  UI_Passport_Task_Description_Text_C_Tab_Special = {
    ID = "UI_Passport_Task_Description_Text_C_Tab_Special",
    Content = "PanelText_UI_Passport_Task_Description_Text_C_Tab_Special_Content|活动"
  },
  UI_Main_Panel_1_Text_C_Close = {
    ID = "UI_Main_Panel_1_Text_C_Close",
    Content = "PanelText_UI_Main_Panel_1_Text_C_Close_Content|关闭中"
  },
  UI_Awaker_Item_Weapon_Refining_Text_C_Refine_Level = {
    ID = "UI_Awaker_Item_Weapon_Refining_Text_C_Refine_Level",
    Content = "PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Refine_Level_Content|命轮叠位等阶"
  },
  UI_Awaker_Item_Weapon_Refining_Text_C_Cost = {
    ID = "UI_Awaker_Item_Weapon_Refining_Text_C_Cost",
    Content = "PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Cost_Content|消耗材料"
  },
  UI_Awaker_Item_Weapon_Refining_Text_C_Warning = {
    ID = "UI_Awaker_Item_Weapon_Refining_Text_C_Warning",
    Content = "PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Warning_Content|已达叠位等级上限"
  },
  UI_Awaker_Item_Weapon_Refining_Text_C_Refine_Name = {
    ID = "UI_Awaker_Item_Weapon_Refining_Text_C_Refine_Name",
    Content = "PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Refine_Name_Content|叠位"
  },
  UI_Awaker_Item_Weapon_Refining_Text_C_Current = {
    ID = "UI_Awaker_Item_Weapon_Refining_Text_C_Current",
    Content = "PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Current_Content|当前效果"
  },
  UI_Awaker_Item_Weapon_Refining_Text_C_Next = {
    ID = "UI_Awaker_Item_Weapon_Refining_Text_C_Next",
    Content = "PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Next_Content|<Blue:下一阶效果>"
  },
  UI_Other_Physical_Tips_Text_C_Name = {
    ID = "UI_Other_Physical_Tips_Text_C_Name",
    Content = "PanelText_UI_Other_Physical_Tips_Text_C_Name_Content|取消"
  },
  UI_Passport_Task_Item_Text_C_Name = {
    ID = "UI_Passport_Task_Item_Text_C_Name",
    Content = "PanelText_UI_Passport_Task_Item_Text_C_Name_Content|一键领取"
  },
  UI_Login_Popup_Tips_Text_C_Title = {
    ID = "UI_Login_Popup_Tips_Text_C_Title",
    Content = "PanelText_UI_Login_Popup_Tips_Text_C_Title_Content|暂无告示"
  },
  UI_Login_Popup_Tips_Text_C_Title2 = {
    ID = "UI_Login_Popup_Tips_Text_C_Title2",
    Content = "PanelText_UI_Login_Popup_Tips_Text_C_Title2_Content|去其他地方看看吧"
  },
  UI_Login_Popup_Tips_Text_C_Title_En = {
    ID = "UI_Login_Popup_Tips_Text_C_Title_En",
    Content = "PanelText_UI_Login_Popup_Tips_Text_C_Title_En_Content|Inbox Empty"
  },
  UI_Passport_Money_Item_Text_C_ThisIssue = {
    ID = "UI_Passport_Money_Item_Text_C_ThisIssue",
    Content = "PanelText_UI_Passport_Money_Item_Text_C_ThisIssue_Content|包含当期高阶课题全部内容"
  },
  UI_Passport_Money_Item_Text_C_Hoist_1 = {
    ID = "UI_Passport_Money_Item_Text_C_Hoist_1",
    Content = "PanelText_UI_Passport_Money_Item_Text_C_Hoist_1_Content|立即提升"
  },
  UI_Passport_Money_Item_Text_C_Hoist_2 = {
    ID = "UI_Passport_Money_Item_Text_C_Hoist_2",
    Content = "PanelText_UI_Passport_Money_Item_Text_C_Hoist_2_Content|10"
  },
  UI_Passport_Money_Item_Text_C_Hoist_3 = {
    ID = "UI_Passport_Money_Item_Text_C_Hoist_3",
    Content = "PanelText_UI_Passport_Money_Item_Text_C_Hoist_3_Content|级"
  },
  UI_Passport_Money_Item_Text_C_Hoist_4 = {
    ID = "UI_Passport_Money_Item_Text_C_Hoist_4",
    Content = "PanelText_UI_Passport_Money_Item_Text_C_Hoist_4_Content|课题等级，并获得"
  },
  UI_Passport_Task_Item_Text_C_Time = {
    ID = "UI_Passport_Task_Item_Text_C_Time",
    Content = "PanelText_UI_Passport_Task_Item_Text_C_Time_Content|本期剩余时间"
  },
  UI_Awaker_Weapon_Refine_Success_Text_C_Succeed = {
    ID = "UI_Awaker_Weapon_Refine_Success_Text_C_Succeed",
    Content = "PanelText_UI_Awaker_Weapon_Refine_Success_Text_C_Succeed_Content|叠位成功"
  },
  UI_Awaker_Weapon_Enhance_Success_Text_C_Succeed = {
    ID = "UI_Awaker_Weapon_Enhance_Success_Text_C_Succeed",
    Content = "PanelText_UI_Awaker_Weapon_Enhance_Success_Text_C_Succeed_Content|强化成功"
  },
  UI_Team_Item_Awaker_List_Text_C_Lv = {
    ID = "UI_Team_Item_Awaker_List_Text_C_Lv",
    Content = "PanelText_UI_Team_Item_Awaker_List_Text_C_Lv_Content|Lv"
  },
  UI_Story_Item_History_Text_Text_C_Current = {
    ID = "UI_Story_Item_History_Text_Text_C_Current",
    Content = "PanelText_UI_Story_Item_History_Text_Text_C_Current_Content|Current."
  },
  UI_Story_Item_History_Text_Text_C_Choice_1 = {
    ID = "UI_Story_Item_History_Text_Text_C_Choice_1",
    Content = "PanelText_UI_Story_Item_History_Text_Text_C_Choice_1_Content|Choice."
  },
  UI_Story_Item_History_Text_Text_C_Choice_2 = {
    ID = "UI_Story_Item_History_Text_Text_C_Choice_2",
    Content = "PanelText_UI_Story_Item_History_Text_Text_C_Choice_2_Content|Choice."
  },
  UI_Story_Item_History_Text_Text_C_Choice_3 = {
    ID = "UI_Story_Item_History_Text_Text_C_Choice_3",
    Content = "PanelText_UI_Story_Item_History_Text_Text_C_Choice_3_Content|Choice."
  },
  UI_Summon_Panel_Main_Text_C_Look = {
    ID = "UI_Summon_Panel_Main_Text_C_Look",
    Content = "PanelText_UI_Summon_Panel_Main_Text_C_Look_Content|查看"
  },
  UI_Summon_Panel_Main_Text_C_School_Intro_Title = {
    ID = "UI_Summon_Panel_Main_Text_C_School_Intro_Title",
    Content = "PanelText_UI_Summon_Panel_Main_Text_C_School_Intro_Title_Content|界域特性——"
  },
  UI_Awaker_Item_List_Text_C_Disable = {
    ID = "UI_Awaker_Item_List_Text_C_Disable",
    Content = "PanelText_UI_Awaker_Item_List_Text_C_Disable_Content|不可更换"
  },
  UI_Summon_Btn_Realms_Text_C_Difficulty = {
    ID = "UI_Summon_Btn_Realms_Text_C_Difficulty",
    Content = "PanelText_UI_Summon_Btn_Realms_Text_C_Difficulty_Content|上手难度"
  },
  UI_Summon_Btn_Realms_Text_C_Directional = {
    ID = "UI_Summon_Btn_Realms_Text_C_Directional",
    Content = "PanelText_UI_Summon_Btn_Realms_Text_C_Directional_Content|当前定向"
  },
  UI_Summon_Popup_Realms_Text_C_Title = {
    ID = "UI_Summon_Popup_Realms_Text_C_Title",
    Content = "PanelText_UI_Summon_Popup_Realms_Text_C_Title_Content|指定界域"
  },
  UI_Summon_Popup_Realms_Text_C_Introduce = {
    ID = "UI_Summon_Popup_Realms_Text_C_Introduce",
    Content = "PanelText_UI_Summon_Popup_Realms_Text_C_Introduce_Content|选择界域后，唤醒所获角色必定为该界域的唤醒体，之后可随时修改。"
  },
  UI_Summon_Popup_Main_Text_C_Not = {
    ID = "UI_Summon_Popup_Main_Text_C_Not",
    Content = "PanelText_UI_Summon_Popup_Main_Text_C_Not_Content|暂无记录"
  },
  UI_Summon_Popup_Main_Text_C_Type = {
    ID = "UI_Summon_Popup_Main_Text_C_Type",
    Content = "PanelText_UI_Summon_Popup_Main_Text_C_Type_Content|类型"
  },
  UI_Summon_Popup_Main_Text_C_Name = {
    ID = "UI_Summon_Popup_Main_Text_C_Name",
    Content = "PanelText_UI_Summon_Popup_Main_Text_C_Name_Content|名称"
  },
  UI_Summon_Popup_Main_Text_C_Role = {
    ID = "UI_Summon_Popup_Main_Text_C_Role",
    Content = "PanelText_UI_Summon_Popup_Main_Text_C_Role_Content|唤醒类型"
  },
  UI_Summon_Popup_Main_Text_C_Time = {
    ID = "UI_Summon_Popup_Main_Text_C_Time",
    Content = "PanelText_UI_Summon_Popup_Main_Text_C_Time_Content|唤醒时间"
  },
  UI_Summon_Popup_Main_Text_C_Prompt = {
    ID = "UI_Summon_Popup_Main_Text_C_Prompt",
    Content = "PanelText_UI_Summon_Popup_Main_Text_C_Prompt_Content|可在本页面查询近6个月的唤醒记录，数据可能有1小时左右延误。"
  },
  UI_Summon_Popup_Main_Text_C_Title = {
    ID = "UI_Summon_Popup_Main_Text_C_Title",
    Content = "PanelText_UI_Summon_Popup_Main_Text_C_Title_Content|唤醒历史记录"
  },
  UI_Team_Item_Awaker_List_Text_C_Disable = {
    ID = "UI_Team_Item_Awaker_List_Text_C_Disable",
    Content = "PanelText_UI_Team_Item_Awaker_List_Text_C_Disable_Content|禁用"
  },
  UI_Passport_Choose_Tip_Text_C_Title = {
    ID = "UI_Passport_Choose_Tip_Text_C_Title",
    Content = "PanelText_UI_Passport_Choose_Tip_Text_C_Title_Content|请选择获得的奖励"
  },
  UI_Summon_Btn_Realms_Text_C_Name = {
    ID = "UI_Summon_Btn_Realms_Text_C_Name",
    Content = "PanelText_UI_Summon_Btn_Realms_Text_C_Name_Content|选 择"
  },
  UI_Awaker_Popup_Tip_Preview_Text_C_Title = {
    ID = "UI_Awaker_Popup_Tip_Preview_Text_C_Title",
    Content = "PanelText_UI_Awaker_Popup_Tip_Preview_Text_C_Title_Content|升格材料预览"
  },
  UI_Summon_Popup_Recording_Text_C_Prompt = {
    ID = "UI_Summon_Popup_Recording_Text_C_Prompt",
    Content = "PanelText_UI_Summon_Popup_Recording_Text_C_Prompt_Content|可在本页面查询近6个月的唤醒记录，数据可能有1小时左右延误。"
  },
  UI_Awaker_Item_Weapon_Strengthen_Text_C_Need = {
    ID = "UI_Awaker_Item_Weapon_Strengthen_Text_C_Need",
    Content = "PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Need_Content|需要"
  },
  UI_Awaker_Item_Weapon_Refining_Text_C_Need = {
    ID = "UI_Awaker_Item_Weapon_Refining_Text_C_Need",
    Content = "PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Need_Content|需要"
  },
  UI_Awaker_Item_Weapon_Strengthen_Text_C_Need_1 = {
    ID = "UI_Awaker_Item_Weapon_Strengthen_Text_C_Need_1",
    Content = "PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Need_1_Content|需要"
  },
  UI_Awaker_Popup_Jewelry_Text_C_Title = {
    ID = "UI_Awaker_Popup_Jewelry_Text_C_Title",
    Content = "PanelText_UI_Awaker_Popup_Jewelry_Text_C_Title_Content|选择密契"
  },
  UI_Awaker_Item_Weapon_Refining_Text_C_Title = {
    ID = "UI_Awaker_Item_Weapon_Refining_Text_C_Title",
    Content = "PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Title_Content|选择叠位素材"
  },
  UI_Chapter_Item_Skill_Text_C_Level = {
    ID = "UI_Chapter_Item_Skill_Text_C_Level",
    Content = "PanelText_UI_Chapter_Item_Skill_Text_C_Level_Content|状态"
  },
  UI_Awaker_Popup_Jewelry_Text_C_No_Trinket = {
    ID = "UI_Awaker_Popup_Jewelry_Text_C_No_Trinket",
    Content = "PanelText_UI_Awaker_Popup_Jewelry_Text_C_No_Trinket_Content|暂无可选素材"
  },
  UI_Chaper_Popup_Detailed_Text_C_Begone = {
    ID = "UI_Chaper_Popup_Detailed_Text_C_Begone",
    Content = "PanelText_UI_Chaper_Popup_Detailed_Text_C_Begone_Content|去其他地方看看吧"
  },
  UI_Chaper_Popup_Detailed_Text_C_mail = {
    ID = "UI_Chaper_Popup_Detailed_Text_C_mail",
    Content = "PanelText_UI_Chaper_Popup_Detailed_Text_C_mail_Content|Inbox Empty"
  },
  UI_Chaper_Popup_Detailed_Text_C_Activity_Bright = {
    ID = "UI_Chaper_Popup_Detailed_Text_C_Activity_Bright",
    Content = "PanelText_UI_Chaper_Popup_Detailed_Text_C_Activity_Bright_Content|刻印"
  },
  UI_Chaper_Popup_Detailed_Text_C_Activity = {
    ID = "UI_Chaper_Popup_Detailed_Text_C_Activity",
    Content = "PanelText_UI_Chaper_Popup_Detailed_Text_C_Activity_Content|刻印"
  },
  UI_Chaper_Popup_Detailed_Text_C_Game_Bright = {
    ID = "UI_Chaper_Popup_Detailed_Text_C_Game_Bright",
    Content = "PanelText_UI_Chaper_Popup_Detailed_Text_C_Game_Bright_Content|造物"
  },
  UI_Chaper_Popup_Detailed_Text_C_Game = {
    ID = "UI_Chaper_Popup_Detailed_Text_C_Game",
    Content = "PanelText_UI_Chaper_Popup_Detailed_Text_C_Game_Content|造物"
  },
  UI_Dungeons_Panel_Try_Text_C_Activity_Awaker = {
    ID = "UI_Dungeons_Panel_Try_Text_C_Activity_Awaker",
    Content = "PanelText_UI_Dungeons_Panel_Try_Text_C_Activity_Awaker_Content|忘却篇·限定"
  },
  UI_Dungeons_Panel_Try_Text_C_Normal_Awaker = {
    ID = "UI_Dungeons_Panel_Try_Text_C_Normal_Awaker",
    Content = "PanelText_UI_Dungeons_Panel_Try_Text_C_Normal_Awaker_Content|常驻"
  },
  UI_Dungeons_Panel_Try_Text_C_Emoji = {
    ID = "UI_Dungeons_Panel_Try_Text_C_Emoji",
    Content = "PanelText_UI_Dungeons_Panel_Try_Text_C_Emoji_Content|表情"
  },
  UI_Awaker_Item_Topped_Detail_Text_C_Need = {
    ID = "UI_Awaker_Item_Topped_Detail_Text_C_Need",
    Content = "PanelText_UI_Awaker_Item_Topped_Detail_Text_C_Need_Content|需要"
  },
  UI_Home_Panel_Main_Text_C_Title = {
    ID = "UI_Home_Panel_Main_Text_C_Title",
    Content = "PanelText_UI_Home_Panel_Main_Text_C_Title_Content|研究中心"
  },
  UI_Battle_Popup_Record_Tip_New_Text_C_Arousal = {
    ID = "UI_Battle_Popup_Record_Tip_New_Text_C_Arousal",
    Content = "PanelText_UI_Battle_Popup_Record_Tip_New_Text_C_Arousal_Content|觉醒"
  },
  UI_Dungeons_Panel_Out_Text_C_Finish = {
    ID = "UI_Dungeons_Panel_Out_Text_C_Finish",
    Content = "PanelText_UI_Dungeons_Panel_Out_Text_C_Finish_Content|调查完成"
  },
  Com_RedDot_Text_C_New = {
    ID = "Com_RedDot_Text_C_New",
    Content = "PanelText_Com_RedDot_Text_C_New_Content|新"
  },
  Com_Text_New_Text_C_New = {
    ID = "Com_Text_New_Text_C_New",
    Content = "PanelText_Com_Text_New_Text_C_New_Content|新"
  },
  UI_Main_Panel_1_Text_C_Main = {
    ID = "UI_Main_Panel_1_Text_C_Main",
    Content = "PanelText_UI_Main_Panel_1_Text_C_Main_Content|调查"
  },
  UI_Shop_Item_Commodity_Text_C_Value = {
    ID = "UI_Shop_Item_Commodity_Text_C_Value",
    Content = "PanelText_UI_Shop_Item_Commodity_Text_C_Value_Content|超值"
  },
  UI_Team_Panel_Main_Text_C_Boundaries_Tips = {
    ID = "UI_Team_Panel_Main_Text_C_Boundaries_Tips",
    Content = "PanelText_UI_Team_Panel_Main_Text_C_Boundaries_Tips_Content|界域推荐"
  },
  UI_Dungeous_Weekly_Difficulty_Text_C_Boundaries_Tips = {
    ID = "UI_Dungeous_Weekly_Difficulty_Text_C_Boundaries_Tips",
    Content = "PanelText_UI_Dungeous_Weekly_Difficulty_Text_C_Boundaries_Tips_Content|推荐界域"
  },
  UI_Dungeous_Weekly_Difficulty_Text_C_Hd = {
    ID = "UI_Dungeous_Weekly_Difficulty_Text_C_Hd",
    Content = "PanelText_UI_Dungeous_Weekly_Difficulty_Text_C_Hd_Content|混沌"
  },
  UI_Dungeous_Weekly_Difficulty_Text_C_Cw = {
    ID = "UI_Dungeous_Weekly_Difficulty_Text_C_Cw",
    Content = "PanelText_UI_Dungeous_Weekly_Difficulty_Text_C_Cw_Content|超维"
  },
  UI_Dungeous_Weekly_Difficulty_Text_C_Xr = {
    ID = "UI_Dungeous_Weekly_Difficulty_Text_C_Xr",
    Content = "PanelText_UI_Dungeous_Weekly_Difficulty_Text_C_Xr_Content|血肉"
  },
  UI_Dungeous_Weekly_Difficulty_Text_C_Sh = {
    ID = "UI_Dungeous_Weekly_Difficulty_Text_C_Sh",
    Content = "PanelText_UI_Dungeous_Weekly_Difficulty_Text_C_Sh_Content|深海"
  },
  UI_Dungeous_Panel_SecEntrance_Text_C_Recommend = {
    ID = "UI_Dungeous_Panel_SecEntrance_Text_C_Recommend",
    Content = "PanelText_UI_Dungeous_Panel_SecEntrance_Text_C_Recommend_Content|推荐界域"
  },
  UI_Dungeous_Panel_SecEntrance_Text_C_Boundaries_Tips = {
    ID = "UI_Dungeous_Panel_SecEntrance_Text_C_Boundaries_Tips",
    Content = "PanelText_UI_Dungeous_Panel_SecEntrance_Text_C_Boundaries_Tips_Content|推荐界域"
  },
  UI_Dungeous_Panel_SecEntrance_Text_C_Hd = {
    ID = "UI_Dungeous_Panel_SecEntrance_Text_C_Hd",
    Content = "PanelText_UI_Dungeous_Panel_SecEntrance_Text_C_Hd_Content|混沌"
  },
  UI_Dungeous_Panel_SecEntrance_Text_C_Cw = {
    ID = "UI_Dungeous_Panel_SecEntrance_Text_C_Cw",
    Content = "PanelText_UI_Dungeous_Panel_SecEntrance_Text_C_Cw_Content|超维"
  },
  UI_Dungeous_Panel_SecEntrance_Text_C_Xr = {
    ID = "UI_Dungeous_Panel_SecEntrance_Text_C_Xr",
    Content = "PanelText_UI_Dungeous_Panel_SecEntrance_Text_C_Xr_Content|血肉"
  },
  UI_Dungeous_Panel_SecEntrance_Text_C_Sh = {
    ID = "UI_Dungeous_Panel_SecEntrance_Text_C_Sh",
    Content = "PanelText_UI_Dungeous_Panel_SecEntrance_Text_C_Sh_Content|深海"
  },
  UI_Common_Btn_Level1_Special_Text_C_Upgrade = {
    ID = "UI_Common_Btn_Level1_Special_Text_C_Upgrade",
    Content = "PanelText_UI_Common_Btn_Level1_Special_Text_C_Upgrade_Content|Enlighten"
  },
  UI_Setting_Popup_Main_Text_C_Title = {
    ID = "UI_Setting_Popup_Main_Text_C_Title",
    Content = "PanelText_UI_Setting_Popup_Main_Text_C_Title_Content|设置"
  },
  UI_Dbgcopy_Popup_ydbj_yty_01_Text_C_Dcks = {
    ID = "UI_Dbgcopy_Popup_ydbj_yty_01_Text_C_Dcks",
    Content = "PanelText_UI_Dbgcopy_Popup_ydbj_yty_01_Text_C_Dcks_Content|调查开始"
  },
  UI_Battle_Popup_Round_Enemy_Text_C_Our = {
    ID = "UI_Battle_Popup_Round_Enemy_Text_C_Our",
    Content = "PanelText_UI_Battle_Popup_Round_Enemy_Text_C_Our_Content|敌方行动"
  },
  UI_Dungeous_Weekly_Main_Text_C_Title = {
    ID = "UI_Dungeous_Weekly_Main_Text_C_Title",
    Content = "PanelText_UI_Dungeous_Weekly_Main_Text_C_Title_Content|奖励预览"
  },
  UI_Event_Challenge_Item_Text_C_Finish = {
    ID = "UI_Event_Challenge_Item_Text_C_Finish",
    Content = "PanelText_UI_Event_Challenge_Item_Text_C_Finish_Content|上次通关"
  },
  UI_Dungeous_Weekly_Main_Text_C_Tips = {
    ID = "UI_Dungeous_Weekly_Main_Text_C_Tips",
    Content = "PanelText_UI_Dungeous_Weekly_Main_Text_C_Tips_Content|奖励详情"
  },
  UI_Dungeons_Panel_Daily_Text_C_Award = {
    ID = "UI_Dungeons_Panel_Daily_Text_C_Award",
    Content = "PanelText_UI_Dungeons_Panel_Daily_Text_C_Award_Content|通关奖励"
  },
  UI_Awaker_Popup_Trinket_Intensify_Detail_Text_C_Upper_Limit = {
    ID = "UI_Awaker_Popup_Trinket_Intensify_Detail_Text_C_Upper_Limit",
    Content = "PanelText_UI_Awaker_Popup_Trinket_Intensify_Detail_Text_C_Upper_Limit_Content|已达等级上限"
  },
  UI_Awaker_Popup_Trinket_Intensify_List_Text_C_None = {
    ID = "UI_Awaker_Popup_Trinket_Intensify_List_Text_C_None",
    Content = "PanelText_UI_Awaker_Popup_Trinket_Intensify_List_Text_C_None_Content|尚未拥有未装备的命轮"
  },
  UI_Awaker_Popup_Trinket_Select_List_Text_C_None = {
    ID = "UI_Awaker_Popup_Trinket_Select_List_Text_C_None",
    Content = "PanelText_UI_Awaker_Popup_Trinket_Select_List_Text_C_None_Content|尚未拥有未装备的密契"
  },
  UI_Login_Text_C_Title1 = {
    ID = "UI_Login_Text_C_Title1",
    Content = "PanelText_UI_Login_Text_C_Title1_Content|忘却前夜"
  },
  UI_Chaper_Popup_Particulars_New_Text_C_Monster = {
    ID = "UI_Chaper_Popup_Particulars_New_Text_C_Monster",
    Content = "PanelText_UI_Chaper_Popup_Particulars_New_Text_C_Monster_Content|关卡造物"
  },
  UI_Chaper_Popup_Particulars_New_Text_C_Title = {
    ID = "UI_Chaper_Popup_Particulars_New_Text_C_Title",
    Content = "PanelText_UI_Chaper_Popup_Particulars_New_Text_C_Title_Content|奖励预览"
  },
  UI_Chaper_Popup_Particulars_New_Text_C_Grade = {
    ID = "UI_Chaper_Popup_Particulars_New_Text_C_Grade",
    Content = "PanelText_UI_Chaper_Popup_Particulars_New_Text_C_Grade_Content|推荐等级"
  },
  UI_Chaper_Popup_Particulars_New_Text_C_Recommend = {
    ID = "UI_Chaper_Popup_Particulars_New_Text_C_Recommend",
    Content = "PanelText_UI_Chaper_Popup_Particulars_New_Text_C_Recommend_Content|界域推荐"
  },
  UI_Chaper_Popup_Particulars_New_Text_C_Achievement = {
    ID = "UI_Chaper_Popup_Particulars_New_Text_C_Achievement",
    Content = "PanelText_UI_Chaper_Popup_Particulars_New_Text_C_Achievement_Content|敌方预览"
  },
  UI_Chaper_Popup_Particulars_New_Text_C_Reward = {
    ID = "UI_Chaper_Popup_Particulars_New_Text_C_Reward",
    Content = "PanelText_UI_Chaper_Popup_Particulars_New_Text_C_Reward_Content|奖励预览"
  },
  UI_Battle_Popup_Anger_Text_Title = {
    ID = "UI_Battle_Popup_Anger_Text_Title",
    Content = "PanelText_UI_Battle_Popup_Anger_Text_Title_Content|狂气爆发"
  },
  UI_Research_Panel_Ceri_Text_C_Title = {
    ID = "UI_Research_Panel_Ceri_Text_C_Title",
    Content = "PanelText_UI_Research_Panel_Ceri_Text_C_Title_Content|天赋总览"
  },
  UI_Research_Panel_Ceri_Text_C_Activate = {
    ID = "UI_Research_Panel_Ceri_Text_C_Activate",
    Content = "PanelText_UI_Research_Panel_Ceri_Text_C_Activate_Content|已激活"
  },
  UI_Chaper_Popup_Detailed_Text_C_Demon = {
    ID = "UI_Chaper_Popup_Detailed_Text_C_Demon",
    Content = "PanelText_UI_Chaper_Popup_Detailed_Text_C_Demon_Content|暂无刻印"
  },
  UI_Chaper_Popup_Detailed_Text_C_No = {
    ID = "UI_Chaper_Popup_Detailed_Text_C_No",
    Content = "PanelText_UI_Chaper_Popup_Detailed_Text_C_No_Content|No Engravements"
  },
  UI_Chaper_Popup_Detailed_Text_C_Darkgame = {
    ID = "UI_Chaper_Popup_Detailed_Text_C_Darkgame",
    Content = "PanelText_UI_Chaper_Popup_Detailed_Text_C_Darkgame_Content|造物"
  },
  UI_Chaper_Popup_Detailed_Text_C_Darkactivity = {
    ID = "UI_Chaper_Popup_Detailed_Text_C_Darkactivity",
    Content = "PanelText_UI_Chaper_Popup_Detailed_Text_C_Darkactivity_Content|刻印"
  },
  UI_Chaper_Popup_Detailed_Text_C_Creation = {
    ID = "UI_Chaper_Popup_Detailed_Text_C_Creation",
    Content = "PanelText_UI_Chaper_Popup_Detailed_Text_C_Creation_Content|造物"
  },
  UI_Chaper_Popup_Detailed_Text_C_Mail = {
    ID = "UI_Chaper_Popup_Detailed_Text_C_Mail",
    Content = "PanelText_UI_Chaper_Popup_Detailed_Text_C_Mail_Content|No Relics"
  },
  UI_Chaper_Popup_Detailed_Text_C_Walk = {
    ID = "UI_Chaper_Popup_Detailed_Text_C_Walk",
    Content = "PanelText_UI_Chaper_Popup_Detailed_Text_C_Walk_Content|去其他地方看看吧"
  },
  UI_Summon_Panel_Main_Text_C_Directional = {
    ID = "UI_Summon_Panel_Main_Text_C_Directional"
  },
  UI_Chaper_Popup_Detailed_Text_C_Not = {
    ID = "UI_Chaper_Popup_Detailed_Text_C_Not",
    Content = "PanelText_UI_Chaper_Popup_Detailed_Text_C_Not_Content|暂无造物"
  },
  UI_Dungeous_Weekly_Difficulty_Text_C_Creation = {
    ID = "UI_Dungeous_Weekly_Difficulty_Text_C_Creation",
    Content = "PanelText_UI_Dungeous_Weekly_Difficulty_Text_C_Creation_Content|关卡造物"
  },
  UI_Research_Panel_Ceri_Item_Text_C_Activate = {
    ID = "UI_Research_Panel_Ceri_Item_Text_C_Activate",
    Content = "PanelText_UI_Research_Panel_Ceri_Item_Text_C_Activate_Content|已激活"
  },
  UI_Research_Panel_Ceri_Item_Text_C_NoeGet = {
    ID = "UI_Research_Panel_Ceri_Item_Text_C_NoeGet",
    Content = "PanelText_UI_Research_Panel_Ceri_Item_Text_C_NoeGet_Content|未获得该唤醒体"
  },
  UI_Common_Btn_Small_240x90_Text_Name = {
    ID = "UI_Common_Btn_Small_240x90_Text_Name",
    Content = "PanelText_UI_Common_Btn_Small_240x90_Text_Name_Content|激活天赋"
  },
  UI_Research_Popup_Dispatch_Text_Title = {
    ID = "UI_Research_Popup_Dispatch_Text_Title",
    Content = "PanelText_UI_Research_Popup_Dispatch_Text_Title_Content|派遣加成总览"
  },
  UI_Common_Item_WuPin_Type1_Text_C_Dispatch = {
    ID = "UI_Common_Item_WuPin_Type1_Text_C_Dispatch",
    Content = "PanelText_UI_Common_Item_WuPin_Type1_Text_C_Dispatch_Content|派遣中"
  },
  UI_Guide_ChangeName_Text_C_Return = {
    ID = "UI_Guide_ChangeName_Text_C_Return",
    Content = "PanelText_UI_Guide_ChangeName_Text_C_Return_Content|返回选择性别"
  },
  UI_Common_Popup_Card_List_Text_C_Empty = {
    ID = "UI_Common_Popup_Card_List_Text_C_Empty",
    Content = "PanelText_UI_Common_Popup_Card_List_Text_C_Empty_Content|当前抽牌堆为空"
  },
  UI_Summon_Popup_Detail_Tip_Text_C_Up = {
    ID = "UI_Summon_Popup_Detail_Tip_Text_C_Up",
    Content = "PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Up_Content|UP物品"
  },
  UI_Summon_Popup_Detail_Tip_Text_C_Detail = {
    ID = "UI_Summon_Popup_Detail_Tip_Text_C_Detail",
    Content = "PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Detail_Content|规则说明"
  },
  UI_Summon_Popup_Detail_Tip_Text_C_Inventory = {
    ID = "UI_Summon_Popup_Detail_Tip_Text_C_Inventory",
    Content = "PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Inventory_Content|物品清单"
  },
  UI_Guide_ChangeName_Text_Confim_Nor = {
    ID = "UI_Guide_ChangeName_Text_Confim_Nor",
    Content = "PanelText_UI_Guide_ChangeName_Text_Confim_Nor_Content|镌刻"
  },
  UI_Guide_ChangeName_Image_Confim_Dis_Bg = {
    ID = "UI_Guide_ChangeName_Image_Confim_Dis_Bg",
    Content = "PanelText_UI_Guide_ChangeName_Image_Confim_Dis_Bg_Content|镌刻"
  },
  UI_Events_Panel_Main_Text_C_SevenDays = {
    ID = "UI_Events_Panel_Main_Text_C_SevenDays",
    Content = "PanelText_UI_Events_Panel_Main_Text_C_SevenDays_Content|七日签到"
  },
  UI_Events_Panel_Main_Text_C_illustrate = {
    ID = "UI_Events_Panel_Main_Text_C_illustrate",
    Content = "PanelText_UI_Events_Panel_Main_Text_C_illustrate_Content|活动说明"
  },
  UI_Events_Panel_Try_Text_C_Fail = {
    ID = "UI_Events_Panel_Try_Text_C_Fail",
    Content = "PanelText_UI_Events_Panel_Try_Text_C_Fail_Content|未完成"
  },
  UI_Events_illustrate_Tip_Text_C_Title = {
    ID = "UI_Events_illustrate_Tip_Text_C_Title",
    Content = "PanelText_UI_Events_illustrate_Tip_Text_C_Title_Content|唤醒体说明"
  },
  UI_Research_Popup_Recall_Text_C_Special = {
    ID = "UI_Research_Popup_Recall_Text_C_Special",
    Content = "PanelText_UI_Research_Popup_Recall_Text_C_Special_Content|达成条件"
  },
  UI_Research_Popup_Recall_Text_C_Award = {
    ID = "UI_Research_Popup_Recall_Text_C_Award",
    Content = "PanelText_UI_Research_Popup_Recall_Text_C_Award_Content|任务奖励"
  },
  UI_Research_Popup_Recall_Text_C_Dispatch = {
    ID = "UI_Research_Popup_Recall_Text_C_Dispatch",
    Content = "PanelText_UI_Research_Popup_Recall_Text_C_Dispatch_Content|当前总等级"
  },
  UI_Research_Popup_Recall_Text_C_Level = {
    ID = "UI_Research_Popup_Recall_Text_C_Level",
    Content = "PanelText_UI_Research_Popup_Recall_Text_C_Level_Content|已派遣总等级"
  },
  UI_Common_Popup_Tips_Confirm_S_Text_Title_En = {
    ID = "UI_Common_Popup_Tips_Confirm_S_Text_Title_En",
    Content = "PanelText_UI_Common_Popup_Tips_Confirm_S_Text_Title_En_Content|Notice"
  },
  UI_PopMsg_Text_C_Precautions2 = {
    ID = "UI_PopMsg_Text_C_Precautions2",
    Content = "PanelText_UI_PopMsg_Text_C_Precautions2_Content|Notice"
  },
  UI_Login_Text_C_Ver_Title = {
    ID = "UI_Login_Text_C_Ver_Title",
    Content = "PanelText_UI_Login_Text_C_Ver_Title_Content|Ver:"
  },
  UI_Login_Text_C_Build_Title = {
    ID = "UI_Login_Text_C_Build_Title",
    Content = "PanelText_UI_Login_Text_C_Build_Title_Content|Bvn:"
  },
  UI_Awaker_Item_Topped_DetailUp_Text_C_Material = {
    ID = "UI_Awaker_Item_Topped_DetailUp_Text_C_Material",
    Content = "PanelText_UI_Awaker_Item_Topped_DetailUp_Text_C_Material_Content|消耗素材"
  },
  UI_Awaker_Item_Topped_DetailUp_Text_C_Tips = {
    ID = "UI_Awaker_Item_Topped_DetailUp_Text_C_Tips",
    Content = "PanelText_UI_Awaker_Item_Topped_DetailUp_Text_C_Tips_Content|自动置入"
  },
  UI_Common_Group_Coin_Text_C_Text = {
    ID = "UI_Common_Group_Coin_Text_C_Text",
    Content = "PanelText_UI_Common_Group_Coin_Text_C_Text_Content|需要"
  },
  UI_Awaker_Panel_Weapon_Main_Text_C_Info1 = {
    ID = "UI_Awaker_Panel_Weapon_Main_Text_C_Info1",
    Content = "PanelText_UI_Awaker_Panel_Weapon_Main_Text_C_Info1_Content|Apprehend Destiny"
  },
  UI_Awaker_Panel_Weapon_Main_Text_C_Info2 = {
    ID = "UI_Awaker_Panel_Weapon_Main_Text_C_Info2",
    Content = "PanelText_UI_Awaker_Panel_Weapon_Main_Text_C_Info2_Content|Wheel of Destiny"
  },
  UI_Awaker_Panel_Weapon_Main_Text_C_Info3 = {
    ID = "UI_Awaker_Panel_Weapon_Main_Text_C_Info3",
    Content = "PanelText_UI_Awaker_Panel_Weapon_Main_Text_C_Info3_Content|Wheel of Destiny"
  },
  UI_Awaker_Panel_Weapon_Main_Text_C_Info4 = {
    ID = "UI_Awaker_Panel_Weapon_Main_Text_C_Info4",
    Content = "PanelText_UI_Awaker_Panel_Weapon_Main_Text_C_Info4_Content|Alignment"
  },
  UI_Vx_Battle_Chaowei_Butter_Text_C_ExtraTurn = {
    ID = "UI_Vx_Battle_Chaowei_Butter_Text_C_ExtraTurn",
    Content = "PanelText_UI_Vx_Battle_Chaowei_Butter_Text_C_ExtraTurn_Content|额外回合"
  },
  UI_Login_Text_C_Enter2 = {
    ID = "UI_Login_Text_C_Enter2",
    Content = "PanelText_UI_Login_Text_C_Enter2_Content|Enter"
  },
  UI_Login_Text_C_Announcement = {
    ID = "UI_Login_Text_C_Announcement",
    Content = "PanelText_UI_Login_Text_C_Announcement_Content|公告"
  },
  UI_Login_Text_C_Deal = {
    ID = "UI_Login_Text_C_Deal",
    Content = "PanelText_UI_Login_Text_C_Deal_Content|协议"
  },
  UI_Login_Text_C_Repair = {
    ID = "UI_Login_Text_C_Repair",
    Content = "PanelText_UI_Login_Text_C_Repair_Content|修复"
  },
  UI_Login_Text_C_Service = {
    ID = "UI_Login_Text_C_Service",
    Content = "PanelText_UI_Login_Text_C_Service_Content|客服"
  },
  UI_Login_Text_C_Sweep = {
    ID = "UI_Login_Text_C_Sweep",
    Content = "PanelText_UI_Login_Text_C_Sweep_Content|扫码"
  },
  UI_Login_Text_C_Set = {
    ID = "UI_Login_Text_C_Set",
    Content = "PanelText_UI_Login_Text_C_Set_Content|设置"
  },
  UI_Login_Text_C_Quit = {
    ID = "UI_Login_Text_C_Quit",
    Content = "PanelText_UI_Login_Text_C_Quit_Content|退出"
  },
  UI_Dungeons_Panel_Daily_Out_Text_C_Finish = {
    ID = "UI_Dungeons_Panel_Daily_Out_Text_C_Finish",
    Content = "PanelText_UI_Dungeons_Panel_Daily_Out_Text_C_Finish_Content|调查成功"
  },
  UI_Dungeons_Panel_Daily_Out_Text_C_Score = {
    ID = "UI_Dungeons_Panel_Daily_Out_Text_C_Score",
    Content = "PanelText_UI_Dungeons_Panel_Daily_Out_Text_C_Score_Content|总评分"
  },
  UI_Dungeons_Panel_Daily_Out_Text_C_High = {
    ID = "UI_Dungeons_Panel_Daily_Out_Text_C_High",
    Content = "PanelText_UI_Dungeons_Panel_Daily_Out_Text_C_High_Content|新高!"
  },
  UI_Dungeons_Panel_Daily_Out_Text_C_Synthesis = {
    ID = "UI_Dungeons_Panel_Daily_Out_Text_C_Synthesis",
    Content = "PanelText_UI_Dungeons_Panel_Daily_Out_Text_C_Synthesis_Content|（总评分为以下总和×3）"
  },
  UI_Dungeons_Panel_Daily_Out_Text_C_Appraise = {
    ID = "UI_Dungeons_Panel_Daily_Out_Text_C_Appraise",
    Content = "PanelText_UI_Dungeons_Panel_Daily_Out_Text_C_Appraise_Content|评分统计"
  },
  UI_Dungeons_Panel_Daily_Out_Text_C_Remind = {
    ID = "UI_Dungeons_Panel_Daily_Out_Text_C_Remind",
    Content = "PanelText_UI_Dungeons_Panel_Daily_Out_Text_C_Remind_Content|提升唤醒体能力后，再来挑战强敌吧！"
  },
  UI_Dungeous_Popup_Score_Tip_Text_C_Title = {
    ID = "UI_Dungeous_Popup_Score_Tip_Text_C_Title",
    Content = "PanelText_UI_Dungeous_Popup_Score_Tip_Text_C_Title_Content|评分统计"
  },
  UI_Dungeous_Popup_Score_Tip_Text_C_Total = {
    ID = "UI_Dungeous_Popup_Score_Tip_Text_C_Total",
    Content = "PanelText_UI_Dungeous_Popup_Score_Tip_Text_C_Total_Content|当前总评分"
  },
  UI_Dungeous_Item_Ranking_Text_C_Uid_Title = {
    ID = "UI_Dungeous_Item_Ranking_Text_C_Uid_Title",
    Content = "PanelText_UI_Dungeous_Item_Ranking_Text_C_Uid_Title_Content|UID :"
  },
  UI_Dungeons_Popup_Rules_Tip_Text_C_Title = {
    ID = "UI_Dungeons_Popup_Rules_Tip_Text_C_Title",
    Content = "PanelText_UI_Dungeons_Popup_Rules_Tip_Text_C_Title_Content|玩法说明"
  },
  UI_Dungeons_Popup_Reward_Tip_Text_C_Big = {
    ID = "UI_Dungeons_Popup_Reward_Tip_Text_C_Big",
    Content = "PanelText_UI_Dungeons_Popup_Reward_Tip_Text_C_Big_Content|大于"
  },
  UI_Dungeons_Popup_Reward_Tip_Text_C_Small = {
    ID = "UI_Dungeons_Popup_Reward_Tip_Text_C_Small",
    Content = "PanelText_UI_Dungeons_Popup_Reward_Tip_Text_C_Small_Content|小于等于"
  },
  UI_Dungeons_Popup_Reward_Tip_Text_C_Reward = {
    ID = "UI_Dungeons_Popup_Reward_Tip_Text_C_Reward",
    Content = "PanelText_UI_Dungeons_Popup_Reward_Tip_Text_C_Reward_Content|奖励"
  },
  UI_Dungeons_Popup_Reward_Tip_Text_C_Title = {
    ID = "UI_Dungeons_Popup_Reward_Tip_Text_C_Title",
    Content = "PanelText_UI_Dungeons_Popup_Reward_Tip_Text_C_Title_Content|排行奖励"
  },
  UI_Dungeons_Popup_List_Tip_Text_C_Me = {
    ID = "UI_Dungeons_Popup_List_Tip_Text_C_Me",
    Content = "PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Me_Content|我的排行"
  },
  UI_Dungeons_Popup_List_Tip_Text_C_Highest = {
    ID = "UI_Dungeons_Popup_List_Tip_Text_C_Highest",
    Content = "PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Highest_Content|最高记录"
  },
  UI_Dungeons_Popup_List_Tip_Text_C_Grade = {
    ID = "UI_Dungeons_Popup_List_Tip_Text_C_Grade",
    Content = "PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Grade_Content|调查头衔"
  },
  UI_Dungeons_Popup_List_Tip_Text_C_Ranking = {
    ID = "UI_Dungeons_Popup_List_Tip_Text_C_Ranking",
    Content = "PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Ranking_Content|排名"
  },
  UI_Dungeons_Popup_List_Tip_Text_C_Current = {
    ID = "UI_Dungeons_Popup_List_Tip_Text_C_Current",
    Content = "PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Current_Content|当前奖励"
  },
  UI_Dungeons_Popup_List_Tip_Text_C_Prompt = {
    ID = "UI_Dungeons_Popup_List_Tip_Text_C_Prompt",
    Content = "PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Prompt_Content|每周一9:00根据调查头衔发送奖励邮件"
  },
  UI_Dungeons_Popup_List_Tip_Text_C_Award = {
    ID = "UI_Dungeons_Popup_List_Tip_Text_C_Award",
    Content = "PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Award_Content|高分排名"
  },
  UI_Dungeons_Popup_List_Tip_Text_C_Information_1 = {
    ID = "UI_Dungeons_Popup_List_Tip_Text_C_Information_1",
    Content = "PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Information_1_Content|守密人信息"
  },
  UI_Dungeons_Popup_List_Tip_Text_C_Information_3 = {
    ID = "UI_Dungeons_Popup_List_Tip_Text_C_Information_3",
    Content = "PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Information_3_Content|最高记录"
  },
  UI_Dungeons_Popup_List_Tip_Text_C_Information_4 = {
    ID = "UI_Dungeons_Popup_List_Tip_Text_C_Information_4",
    Content = "PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Information_4_Content|排名"
  },
  UI_Dungeons_Popup_List_Tip_Text_C_Information_5 = {
    ID = "UI_Dungeons_Popup_List_Tip_Text_C_Information_5",
    Content = "PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Information_5_Content|编队"
  },
  UI_Dungeons_Popup_List_Tip_Text_C_Empty = {
    ID = "UI_Dungeons_Popup_List_Tip_Text_C_Empty",
    Content = "PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Empty_Content|暂无记录"
  },
  UI_Dungeons_Popup_List_Tip_Text_C_Title = {
    ID = "UI_Dungeons_Popup_List_Tip_Text_C_Title",
    Content = "PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Title_Content|调查排行"
  },
  UI_Dungeons_Panel_Daily_Text_C_Record = {
    ID = "UI_Dungeons_Panel_Daily_Text_C_Record",
    Content = "PanelText_UI_Dungeons_Panel_Daily_Text_C_Record_Content|本日成绩"
  },
  UI_Dungeons_Panel_Daily_Text_C_Highest = {
    ID = "UI_Dungeons_Panel_Daily_Text_C_Highest",
    Content = "PanelText_UI_Dungeons_Panel_Daily_Text_C_Highest_Content|最高记录"
  },
  UI_Dungeons_Panel_Daily_Text_C_Title = {
    ID = "UI_Dungeons_Panel_Daily_Text_C_Title",
    Content = "PanelText_UI_Dungeons_Panel_Daily_Text_C_Title_Content|调查头衔"
  },
  UI_Dungeons_Panel_Daily_Text_C_Score = {
    ID = "UI_Dungeons_Panel_Daily_Text_C_Score",
    Content = "PanelText_UI_Dungeons_Panel_Daily_Text_C_Score_Content|本周累计评分"
  },
  UI_Dungeons_Panel_Daily_Text_C_Store = {
    ID = "UI_Dungeons_Panel_Daily_Text_C_Store",
    Content = "PanelText_UI_Dungeons_Panel_Daily_Text_C_Store_Content|兑换商店"
  },
  UI_Dungeons_Panel_Daily_Text_C_Reward = {
    ID = "UI_Dungeons_Panel_Daily_Text_C_Reward",
    Content = "PanelText_UI_Dungeons_Panel_Daily_Text_C_Reward_Content|每周试炼"
  },
  UI_Common_Popup_Tip_4_Text_C_Lv1 = {
    ID = "UI_Common_Popup_Tip_4_Text_C_Lv1",
    Content = "PanelText_UI_Common_Popup_Tip_4_Text_C_Lv1_Content|Lv."
  },
  UI_Common_Popup_Tip_4_Text_C_Lv2 = {
    ID = "UI_Common_Popup_Tip_4_Text_C_Lv2",
    Content = "PanelText_UI_Common_Popup_Tip_4_Text_C_Lv2_Content|Lv."
  },
  UI_Common_Popup_Tip_4_Text_C_Level1 = {
    ID = "UI_Common_Popup_Tip_4_Text_C_Level1",
    Content = "PanelText_UI_Common_Popup_Tip_4_Text_C_Level1_Content|Lv."
  },
  UI_Common_Popup_Tip_4_Text_C_Level2 = {
    ID = "UI_Common_Popup_Tip_4_Text_C_Level2",
    Content = "PanelText_UI_Common_Popup_Tip_4_Text_C_Level2_Content|Lv."
  },
  UI_Awaker_Item_Trinket_Show_Text_C_Accessories = {
    ID = "UI_Awaker_Item_Trinket_Show_Text_C_Accessories",
    Content = "PanelText_UI_Awaker_Item_Trinket_Show_Text_C_Accessories_Content|Covenants"
  },
  UI_Awaker_Item_Trinket_Show_Text_C_Covenant = {
    ID = "UI_Awaker_Item_Trinket_Show_Text_C_Covenant",
    Content = "PanelText_UI_Awaker_Item_Trinket_Show_Text_C_Covenant_Content|Covenants"
  },
  UI_Awaker_Item_Topped_DetailUp_Text_Confirm = {
    ID = "UI_Awaker_Item_Topped_DetailUp_Text_Confirm",
    Content = "PanelText_UI_Awaker_Item_Topped_DetailUp_Text_Confirm_Content|升级"
  },
  UI_Research_Panel_Challenge_Text_C_ReachName = {
    ID = "UI_Research_Panel_Challenge_Text_C_ReachName",
    Content = "PanelText_UI_Research_Panel_Challenge_Text_C_ReachName_Content|全部成就达成"
  },
  UI_Research_Panel_Challenge_Text_C_PlanName = {
    ID = "UI_Research_Panel_Challenge_Text_C_PlanName",
    Content = "PanelText_UI_Research_Panel_Challenge_Text_C_PlanName_Content|当前进展"
  },
  UI_Research_Panel_Challenge_Text_Title = {
    ID = "UI_Research_Panel_Challenge_Text_Title",
    Content = "PanelText_UI_Research_Panel_Challenge_Text_Title_Content|成就"
  },
  UI_Task_Popup_Challenge_Item_Text_C_Info = {
    ID = "UI_Task_Popup_Challenge_Item_Text_C_Info",
    Content = "PanelText_UI_Task_Popup_Challenge_Item_Text_C_Info_Content|提升调查等级可获得奖励"
  },
  UI_Task_Popup_Challenge_Item_Text_C_Level = {
    ID = "UI_Task_Popup_Challenge_Item_Text_C_Level",
    Content = "PanelText_UI_Task_Popup_Challenge_Item_Text_C_Level_Content|等级"
  },
  UI_Task_Popup_Challenge_Item_Text_Name = {
    ID = "UI_Task_Popup_Challenge_Item_Text_Name",
    Content = "PanelText_UI_Task_Popup_Challenge_Item_Text_Name_Content|领取"
  },
  UI_Task_Popup_Challenge_Item1_Text_C_Undone1 = {
    ID = "UI_Task_Popup_Challenge_Item1_Text_C_Undone1",
    Content = "PanelText_UI_Task_Popup_Challenge_Item1_Text_C_Undone1_Content|未完成"
  },
  UI_Task_Popup_Challenge_Item1_Text_C_Info1 = {
    ID = "UI_Task_Popup_Challenge_Item1_Text_C_Info1",
    Content = "PanelText_UI_Task_Popup_Challenge_Item1_Text_C_Info1_Content|提升调查等级可获得奖励"
  },
  UI_Task_Popup_Challenge_Item1_Text_C_Level1 = {
    ID = "UI_Task_Popup_Challenge_Item1_Text_C_Level1",
    Content = "PanelText_UI_Task_Popup_Challenge_Item1_Text_C_Level1_Content|等级"
  },
  Btn_Get_Text_Name = {
    ID = "Btn_Get_Text_Name",
    Content = "PanelText_Btn_Get_Text_Name_Content|领取"
  },
  UI_Task_Popup_Challenge_Text_C_Title = {
    ID = "UI_Task_Popup_Challenge_Text_C_Title",
    Content = "PanelText_UI_Task_Popup_Challenge_Text_C_Title_Content|学员证书"
  },
  UI_Task_Popup_Challenge_Text_C_1 = {
    ID = "UI_Task_Popup_Challenge_Text_C_1",
    Content = "PanelText_UI_Task_Popup_Challenge_Text_C_1_Content|守密人"
  },
  UI_Task_Popup_Challenge_Text_C_2 = {
    ID = "UI_Task_Popup_Challenge_Text_C_2",
    Content = "PanelText_UI_Task_Popup_Challenge_Text_C_2_Content|录入时间"
  },
  UI_Task_Popup_Challenge_Text_C_3 = {
    ID = "UI_Task_Popup_Challenge_Text_C_3",
    Content = "PanelText_UI_Task_Popup_Challenge_Text_C_3_Content|调查等级"
  },
  UI_Task_Popup_Challenge_Text_C_OneKey = {
    ID = "UI_Task_Popup_Challenge_Text_C_OneKey",
    Content = "PanelText_UI_Task_Popup_Challenge_Text_C_OneKey_Content|一键领取"
  },
  UI_Task_Popup_Career_Item_Text_C_Undone = {
    ID = "UI_Task_Popup_Career_Item_Text_C_Undone",
    Content = "PanelText_UI_Task_Popup_Career_Item_Text_C_Undone_Content|未完成"
  },
  UI_Task_Popup_Career_Item_Text_Name = {
    ID = "UI_Task_Popup_Career_Item_Text_Name",
    Content = "PanelText_UI_Task_Popup_Career_Item_Text_Name_Content|领取"
  },
  UI_Task_Popup_Career_Text_C_Award = {
    ID = "UI_Task_Popup_Career_Text_C_Award",
    Content = "PanelText_UI_Task_Popup_Career_Text_C_Award_Content|完成奖励"
  },
  UI_Task_Popup_Career_Text_C_1 = {
    ID = "UI_Task_Popup_Career_Text_C_1",
    Content = "PanelText_UI_Task_Popup_Career_Text_C_1_Content|当前进度"
  },
  UI_Task_Popup_Career_Text_C_Get = {
    ID = "UI_Task_Popup_Career_Text_C_Get",
    Content = "PanelText_UI_Task_Popup_Career_Text_C_Get_Content|奖励已领取"
  },
  UI_Task_Popup_Career_Text_C_OneKey = {
    ID = "UI_Task_Popup_Career_Text_C_OneKey",
    Content = "PanelText_UI_Task_Popup_Career_Text_C_OneKey_Content|一键领取"
  },
  UI_Task_Popup_Challenge_Item1_Text_Name = {
    ID = "UI_Task_Popup_Challenge_Item1_Text_Name",
    Content = "PanelText_UI_Task_Popup_Challenge_Item1_Text_Name_Content|领取"
  },
  UI_Common_Popup_Tip_4_Text_C_Info = {
    ID = "UI_Common_Popup_Tip_4_Text_C_Info",
    Content = "PanelText_UI_Common_Popup_Tip_4_Text_C_Info_Content|<WhiteQuality:点击空白处关闭>"
  },
  UI_Main_Panel_1_Text_C_Activity = {
    ID = "UI_Main_Panel_1_Text_C_Activity",
    Content = "PanelText_UI_Main_Panel_1_Text_C_Activity_Content|活动"
  },
  UI_Card_Panel_Discard_Text_C_Title = {
    ID = "UI_Card_Panel_Discard_Text_C_Title",
    Content = "PanelText_UI_Card_Panel_Discard_Text_C_Title_Content|手牌堆"
  },
  UI_Chaper_Popup_Award_Optimized_Text_C_OneKey = {
    ID = "UI_Chaper_Popup_Award_Optimized_Text_C_OneKey",
    Content = "PanelText_UI_Chaper_Popup_Award_Optimized_Text_C_OneKey_Content|一键领取"
  },
  UI_Chaper_Popup_Award_Text_C_OneKey = {
    ID = "UI_Chaper_Popup_Award_Text_C_OneKey",
    Content = "PanelText_UI_Chaper_Popup_Award_Text_C_OneKey_Content|一键领取"
  },
  Text_C_Activate_Text_C_Activate = {
    ID = "Text_C_Activate_Text_C_Activate",
    Content = "PanelText_Text_C_Activate_Text_C_Activate_Content|激发材料"
  },
  UI_Awaker_Item_Skill_Detail_Text_C_Warning_CN = {
    ID = "UI_Awaker_Item_Skill_Detail_Text_C_Warning_CN",
    Content = "PanelText_UI_Awaker_Item_Skill_Detail_Text_C_Warning_CN_Content|已激发"
  },
  UI_Awaker_Item_Skill_Detail_Text_C_Warning_ZN = {
    ID = "UI_Awaker_Item_Skill_Detail_Text_C_Warning_ZN",
    Content = "PanelText_UI_Awaker_Item_Skill_Detail_Text_C_Warning_ZN_Content|Requirement"
  },
  UI_Task_Popup_Challenge_Text_C_Reach = {
    ID = "UI_Task_Popup_Challenge_Text_C_Reach",
    Content = "PanelText_UI_Task_Popup_Challenge_Text_C_Reach_Content|愿银钥指引我们"
  },
  UI_Research_Panel_Ceri_Item_Text_Name = {
    ID = "UI_Research_Panel_Ceri_Item_Text_Name",
    Content = "PanelText_UI_Research_Panel_Ceri_Item_Text_Name_Content|激活天赋"
  },
  UI_Research_Panel_Dispatch_Item_Text_C_Underway = {
    ID = "UI_Research_Panel_Dispatch_Item_Text_C_Underway",
    Content = "PanelText_UI_Research_Panel_Dispatch_Item_Text_C_Underway_Content|进行中"
  },
  UI_Research_Panel_Dispatch_Item_Text_C_Tip = {
    ID = "UI_Research_Panel_Dispatch_Item_Text_C_Tip",
    Content = "PanelText_UI_Research_Panel_Dispatch_Item_Text_C_Tip_Content|待领取"
  },
  UI_Research_Panel_Dispatch_Item_Text_Tine_Title = {
    ID = "UI_Research_Panel_Dispatch_Item_Text_Tine_Title",
    Content = "PanelText_UI_Research_Panel_Dispatch_Item_Text_Tine_Title_Content|剩余"
  },
  UI_Research_Panel_Dispatch_Item_Text_Tine_Title_Normal = {
    ID = "UI_Research_Panel_Dispatch_Item_Text_Tine_Title_Normal",
    Content = "PanelText_UI_Research_Panel_Dispatch_Item_Text_Tine_Title_Normal_Content|消耗"
  },
  UI_Dungeous_Panel_BossSel_Text_C_AwardText = {
    ID = "UI_Dungeous_Panel_BossSel_Text_C_AwardText",
    Content = "PanelText_UI_Dungeous_Panel_BossSel_Text_C_AwardText_Content|本周可以领取奖励次数"
  },
  UI_Dungeous_Panel_BossSel_Text_C_Award = {
    ID = "UI_Dungeous_Panel_BossSel_Text_C_Award",
    Content = "PanelText_UI_Dungeous_Panel_BossSel_Text_C_Award_Content|敌方详情"
  },
  UI_Dungeous_Panel_BossSel_Text_C_Reward = {
    ID = "UI_Dungeous_Panel_BossSel_Text_C_Reward",
    Content = "PanelText_UI_Dungeous_Panel_BossSel_Text_C_Reward_Content|通关奖励"
  },
  UI_Dungeous_Panel_BossSel_Text_C_Special = {
    ID = "UI_Dungeous_Panel_BossSel_Text_C_Special",
    Content = "PanelText_UI_Dungeous_Panel_BossSel_Text_C_Special_Content|初始造物"
  },
  UI_Dungeous_Panel_BossSel_Text_C_Boundaries_Tips = {
    ID = "UI_Dungeous_Panel_BossSel_Text_C_Boundaries_Tips",
    Content = "PanelText_UI_Dungeous_Panel_BossSel_Text_C_Boundaries_Tips_Content|推荐界域"
  },
  UI_Dungeous_Panel_BossSel_Text_Title = {
    ID = "UI_Dungeous_Panel_BossSel_Text_Title",
    Content = "PanelText_UI_Dungeous_Panel_BossSel_Text_Title_Content|超验存在"
  },
  UI_Dungeous_Panel_BossSel1_Text_C_AwardText = {
    ID = "UI_Dungeous_Panel_BossSel1_Text_C_AwardText",
    Content = "PanelText_UI_Dungeous_Panel_BossSel1_Text_C_AwardText_Content|本周可以领取奖励次数"
  },
  UI_Dungeous_Panel_BossSel1_Text_C_Special = {
    ID = "UI_Dungeous_Panel_BossSel1_Text_C_Special",
    Content = "PanelText_UI_Dungeous_Panel_BossSel1_Text_C_Special_Content|初始造物"
  },
  UI_Dungeous_Panel_BossSel1_Text_C_Recommend = {
    ID = "UI_Dungeous_Panel_BossSel1_Text_C_Recommend",
    Content = "PanelText_UI_Dungeous_Panel_BossSel1_Text_C_Recommend_Content|推荐界域"
  },
  UI_Dungeous_Panel_BossSel1_Text_C_Boundaries_Tips = {
    ID = "UI_Dungeous_Panel_BossSel1_Text_C_Boundaries_Tips",
    Content = "PanelText_UI_Dungeous_Panel_BossSel1_Text_C_Boundaries_Tips_Content|推荐界域"
  },
  UI_Dungeous_Panel_BossSel1_Text_C_School_1 = {
    ID = "UI_Dungeous_Panel_BossSel1_Text_C_School_1",
    Content = "PanelText_UI_Dungeous_Panel_BossSel1_Text_C_School_1_Content|混沌"
  },
  UI_Dungeous_Panel_BossSel1_Text_C_School_2 = {
    ID = "UI_Dungeous_Panel_BossSel1_Text_C_School_2",
    Content = "PanelText_UI_Dungeous_Panel_BossSel1_Text_C_School_2_Content|超维"
  },
  UI_Dungeous_Panel_BossSel1_Text_C_School_3 = {
    ID = "UI_Dungeous_Panel_BossSel1_Text_C_School_3",
    Content = "PanelText_UI_Dungeous_Panel_BossSel1_Text_C_School_3_Content|血肉"
  },
  UI_Dungeous_Panel_BossSel1_Text_C_School_4 = {
    ID = "UI_Dungeous_Panel_BossSel1_Text_C_School_4",
    Content = "PanelText_UI_Dungeous_Panel_BossSel1_Text_C_School_4_Content|深海"
  },
  UI_Dungeous_Panel_BossSel1_Text_C_Award = {
    ID = "UI_Dungeous_Panel_BossSel1_Text_C_Award",
    Content = "PanelText_UI_Dungeous_Panel_BossSel1_Text_C_Award_Content|任务报酬"
  },
  UI_Alchemy_Panel_Main_Text_Title = {
    ID = "UI_Alchemy_Panel_Main_Text_Title",
    Content = "PanelText_UI_Alchemy_Panel_Main_Text_Title_Content|冶炼室"
  },
  UI_Alchemy_Popup_Resolve_Text_Tips = {
    ID = "UI_Alchemy_Popup_Resolve_Text_Tips",
    Content = "PanelText_UI_Alchemy_Popup_Resolve_Text_Tips_Content|尚未拥有可以分解的素材"
  },
  UI_Alchemy_Popup_Resolve_Text_Title = {
    ID = "UI_Alchemy_Popup_Resolve_Text_Title",
    Content = "PanelText_UI_Alchemy_Popup_Resolve_Text_Title_Content|分解可获得材料"
  },
  UI_Alchemy_Popup_Resolve_Text_Slider_Tips = {
    ID = "UI_Alchemy_Popup_Resolve_Text_Slider_Tips",
    Content = "PanelText_UI_Alchemy_Popup_Resolve_Text_Slider_Tips_Content|分解次数"
  },
  UI_Alchemy_Popup_Resolve_Text_Possess_Tips = {
    ID = "UI_Alchemy_Popup_Resolve_Text_Possess_Tips",
    Content = "PanelText_UI_Alchemy_Popup_Resolve_Text_Possess_Tips_Content|即将分解"
  },
  UI_Alchemy_Popup_Resolve_Text_Need = {
    ID = "UI_Alchemy_Popup_Resolve_Text_Need",
    Content = "PanelText_UI_Alchemy_Popup_Resolve_Text_Need_Content|需要"
  },
  UI_Alchemy_Popup_Resolve_Text_None_Tips = {
    ID = "UI_Alchemy_Popup_Resolve_Text_None_Tips",
    Content = "PanelText_UI_Alchemy_Popup_Resolve_Text_None_Tips_Content|请从左侧选择需要分解的素材"
  },
  UI_Dungeons_Panel_Daily_Challenge_Text_list = {
    ID = "UI_Dungeons_Panel_Daily_Challenge_Text_list",
    Content = "PanelText_UI_Dungeons_Panel_Daily_Challenge_Text_list_Content|赛季排行"
  },
  UI_Battle_Popup_Settle_Text_C_Succeed = {
    ID = "UI_Battle_Popup_Settle_Text_C_Succeed",
    Content = "PanelText_UI_Battle_Popup_Settle_Text_C_Succeed_Content|战斗胜利"
  },
  UI_Battle_Popup_Settle_Text_C_Pendants = {
    ID = "UI_Battle_Popup_Settle_Text_C_Pendants",
    Content = "PanelText_UI_Battle_Popup_Settle_Text_C_Pendants_Content|Victory"
  },
  UI_Battle_Popup_Elite_Text_C_Victory = {
    ID = "UI_Battle_Popup_Elite_Text_C_Victory",
    Content = "PanelText_UI_Battle_Popup_Elite_Text_C_Victory_Content|危险警报"
  },
  UI_Battle_Popup_Elite_Text_C_Failure = {
    ID = "UI_Battle_Popup_Elite_Text_C_Failure",
    Content = "PanelText_UI_Battle_Popup_Elite_Text_C_Failure_Content|Retreat"
  },
  Panel_Loading_Text_C_Repair = {
    ID = "Panel_Loading_Text_C_Repair",
    Content = "PanelText_Panel_Loading_Text_C_Repair_Content|Fix"
  },
  UI_Awaker_Item_Voice_Text_1 = {
    ID = "UI_Awaker_Item_Voice_Text_1",
    Content = "PanelText_UI_Awaker_Item_Voice_Text_1_Content|Entry"
  },
  UI_Awaker_Item_Story_Text_1 = {
    ID = "UI_Awaker_Item_Story_Text_1",
    Content = "PanelText_UI_Awaker_Item_Story_Text_1_Content|Entry"
  },
  UI_Chapter_Item_Chapter_Small_Text_C_Expect = {
    ID = "UI_Chapter_Item_Chapter_Small_Text_C_Expect",
    Content = "PanelText_UI_Chapter_Item_Chapter_Small_Text_C_Expect_Content|敬请期待"
  },
  UI_Chapter_Item_Chapter_Big_Text_C_Expect = {
    ID = "UI_Chapter_Item_Chapter_Big_Text_C_Expect",
    Content = "PanelText_UI_Chapter_Item_Chapter_Big_Text_C_Expect_Content|敬请期待"
  },
  UI_Dungeons_Panel_Daily_Challenge_Text_C_Store = {
    ID = "UI_Dungeons_Panel_Daily_Challenge_Text_C_Store",
    Content = "PanelText_UI_Dungeons_Panel_Daily_Challenge_Text_C_Store_Content|兑换商店"
  },
  UI_Dungeons_Panel_Trinket_Text_C_Award = {
    ID = "UI_Dungeons_Panel_Trinket_Text_C_Award",
    Content = "PanelText_UI_Dungeons_Panel_Trinket_Text_C_Award_Content|任务报酬"
  },
  UI_Awaker_Popup_Topped_Tip_Text_C_Title = {
    ID = "UI_Awaker_Popup_Topped_Tip_Text_C_Title",
    Content = "PanelText_UI_Awaker_Popup_Topped_Tip_Text_C_Title_Content|升格预览"
  },
  UI_Awaker_Popup_Topped_Tip_Text_C_Material = {
    ID = "UI_Awaker_Popup_Topped_Tip_Text_C_Material",
    Content = "PanelText_UI_Awaker_Popup_Topped_Tip_Text_C_Material_Content|升格材料"
  },
  UI_Awaker_Popup_Topped_Tip_Text_C_Reward = {
    ID = "UI_Awaker_Popup_Topped_Tip_Text_C_Reward",
    Content = "PanelText_UI_Awaker_Popup_Topped_Tip_Text_C_Reward_Content|升格奖励"
  },
  UI_Battle_Panel_Dbg_Text_C_Unclickable = {
    ID = "UI_Battle_Panel_Dbg_Text_C_Unclickable",
    Content = "PanelText_UI_Battle_Panel_Dbg_Text_C_Unclickable_Content|结束"
  },
  UI_Battle_Panel_Dbg_Text_C_Name = {
    ID = "UI_Battle_Panel_Dbg_Text_C_Name",
    Content = "PanelText_UI_Battle_Panel_Dbg_Text_C_Name_Content|结束"
  },
  UI_Dungeous_Panel_BossSel1_Text_AwardNumLine = {
    ID = "UI_Dungeous_Panel_BossSel1_Text_AwardNumLine",
    Content = "PanelText_UI_Dungeous_Panel_BossSel1_Text_AwardNumLine_Content|/"
  },
  UI_Dungeous_Panel_BossSel1_Text_C_Creation = {
    ID = "UI_Dungeous_Panel_BossSel1_Text_C_Creation",
    Content = "PanelText_UI_Dungeous_Panel_BossSel1_Text_C_Creation_Content|关卡造物"
  },
  UI_Summon_Panel_Main_Text_C_Limited = {
    ID = "UI_Summon_Panel_Main_Text_C_Limited",
    Content = "PanelText_UI_Summon_Panel_Main_Text_C_Limited_Content|Limited Tme Role"
  },
  UI_Chapter_Popup_Yuanxing_Text_Title = {
    ID = "UI_Chapter_Popup_Yuanxing_Text_Title",
    Content = "PanelText_UI_Chapter_Popup_Yuanxing_Text_Title_Content|调查评价"
  },
  UI_Dungeons_Panel_Out_Text_C_Limit = {
    ID = "UI_Dungeons_Panel_Out_Text_C_Limit",
    Content = "PanelText_UI_Dungeons_Panel_Out_Text_C_Limit_Content|※物品已达上限"
  },
  Btn_Block_Window_Text_C_Display = {
    ID = "Btn_Block_Window_Text_C_Display",
    Content = "PanelText_Btn_Block_Window_Text_C_Display_Content|显示卡牌"
  },
  Btn_Block_Window_Text_C_Hide = {
    ID = "Btn_Block_Window_Text_C_Hide",
    Content = "PanelText_Btn_Block_Window_Text_C_Hide_Content|隐藏卡牌"
  },
  UI_Awaker_Item_Weapon_Strengthen_Text_C_Skill = {
    ID = "UI_Awaker_Item_Weapon_Strengthen_Text_C_Skill",
    Content = "PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Skill_Content|叠位"
  },
  UI_Awaker_Item_Weapon_Strengthen_Text_C_Skill_Click = {
    ID = "UI_Awaker_Item_Weapon_Strengthen_Text_C_Skill_Click",
    Content = "PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Skill_Click_Content|叠位"
  },
  ["UI_Dungeons_Popup_List_Tip_Text_C_Haven't"] = {
    ID = "UI_Dungeons_Popup_List_Tip_Text_C_Haven't",
    Content = "PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Haven't_Content|暂无奖励"
  },
  UI_Battle_Popup_Anger_Text_C_Cooling = {
    ID = "UI_Battle_Popup_Anger_Text_C_Cooling",
    Content = "PanelText_UI_Battle_Popup_Anger_Text_C_Cooling_Content|冷却中，下回合才可以再次使用"
  },
  UI_Dungeons_Panel_Out_Text_C_Score = {
    ID = "UI_Dungeons_Panel_Out_Text_C_Score",
    Content = "PanelText_UI_Dungeons_Panel_Out_Text_C_Score_Content|总评分"
  },
  UI_Dungeons_Panel_Out_Text_C_High = {
    ID = "UI_Dungeons_Panel_Out_Text_C_High",
    Content = "PanelText_UI_Dungeons_Panel_Out_Text_C_High_Content|新高!"
  },
  UI_Dungeons_Panel_Out_Text_C_Huodewuzi = {
    ID = "UI_Dungeons_Panel_Out_Text_C_Huodewuzi",
    Content = "PanelText_UI_Dungeons_Panel_Out_Text_C_Huodewuzi_Content|结算获得"
  },
  UI_Dungeons_Panel_Out_Text_C_Synthesis = {
    ID = "UI_Dungeons_Panel_Out_Text_C_Synthesis",
    Content = "PanelText_UI_Dungeons_Panel_Out_Text_C_Synthesis_Content|（总评分为以下总和×3）"
  },
  UI_Dungeons_Panel_Out_Text_C_Appraise = {
    ID = "UI_Dungeons_Panel_Out_Text_C_Appraise",
    Content = "PanelText_UI_Dungeons_Panel_Out_Text_C_Appraise_Content|评分统计"
  },
  UI_Common_Popup_Tips_6_Text_null = {
    ID = "UI_Common_Popup_Tips_6_Text_null",
    Content = "PanelText_UI_Common_Popup_Tips_6_Text_null_Content|（已损毁）"
  },
  UI_Dungeons_Popup_List_Tip_Text_C_illustrate = {
    ID = "UI_Dungeons_Popup_List_Tip_Text_C_illustrate",
    Content = "PanelText_UI_Dungeons_Popup_List_Tip_Text_C_illustrate_Content|排行奖励"
  },
  UI_Bag_Helicopter_Tips_Text_C_Title = {
    ID = "UI_Bag_Helicopter_Tips_Text_C_Title",
    Content = "PanelText_UI_Bag_Helicopter_Tips_Text_C_Title_Content|唤醒体增幅"
  },
  UI_Dungeous_Panel_Difficulty_Text_C_Creation = {
    ID = "UI_Dungeous_Panel_Difficulty_Text_C_Creation",
    Content = "PanelText_UI_Dungeous_Panel_Difficulty_Text_C_Creation_Content|关卡造物"
  },
  UI_Common_Popup_Tip_6_Text_C_Tips = {
    ID = "UI_Common_Popup_Tip_6_Text_C_Tips",
    Content = "PanelText_UI_Common_Popup_Tip_6_Text_C_Tips_Content|更改名称后，72小时内不能再做修改"
  },
  UI_Common_Popup_Tip_6_Text_Title = {
    ID = "UI_Common_Popup_Tip_6_Text_Title",
    Content = "PanelText_UI_Common_Popup_Tip_6_Text_Title_Content|更改名称"
  },
  UI_Common_Popup_Tip_6_Text_Placeholder = {
    ID = "UI_Common_Popup_Tip_6_Text_Placeholder",
    Content = "PanelText_UI_Common_Popup_Tip_6_Text_Placeholder_Content|请输入您的名字"
  },
  UI_Common_Popup_Tip_6_Text_NameCancel = {
    ID = "UI_Common_Popup_Tip_6_Text_NameCancel",
    Content = "PanelText_UI_Common_Popup_Tip_6_Text_NameCancel_Content|取消"
  },
  UI_Common_Popup_Tip_6_Text_NameConfirm = {
    ID = "UI_Common_Popup_Tip_6_Text_NameConfirm",
    Content = "PanelText_UI_Common_Popup_Tip_6_Text_NameConfirm_Content|确认"
  },
  UI_Dungeous_illustrate_Tip_Text_C_Title = {
    ID = "UI_Dungeous_illustrate_Tip_Text_C_Title",
    Content = "PanelText_UI_Dungeous_illustrate_Tip_Text_C_Title_Content|无光之境"
  },
  UI_Dungeous_Weekly_Main_Text_C_illustrate = {
    ID = "UI_Dungeous_Weekly_Main_Text_C_illustrate",
    Content = "PanelText_UI_Dungeous_Weekly_Main_Text_C_illustrate_Content|玩法规则"
  },
  UI_Dungeous_Weekly_Difficulty_Text_C_illustrate = {
    ID = "UI_Dungeous_Weekly_Difficulty_Text_C_illustrate",
    Content = "PanelText_UI_Dungeous_Weekly_Difficulty_Text_C_illustrate_Content|玩法规则"
  },
  UI_Dungeous_Popup_Swept_Tip_Text_C_Title = {
    ID = "UI_Dungeous_Popup_Swept_Tip_Text_C_Title",
    Content = "PanelText_UI_Dungeous_Popup_Swept_Tip_Text_C_Title_Content|重现确认"
  },
  UI_Dungeous_Popup_Swept_Tip_Text_C_Deplete = {
    ID = "UI_Dungeous_Popup_Swept_Tip_Text_C_Deplete",
    Content = "PanelText_UI_Dungeous_Popup_Swept_Tip_Text_C_Deplete_Content|重现消耗"
  },
  UI_Dungeous_Popup_Swept_Tip_Text_C_Team = {
    ID = "UI_Dungeous_Popup_Swept_Tip_Text_C_Team",
    Content = "PanelText_UI_Dungeous_Popup_Swept_Tip_Text_C_Team_Content|调查队伍"
  },
  UI_Dungeous_Popup_Swept_Tip_Text_C_Swept = {
    ID = "UI_Dungeous_Popup_Swept_Tip_Text_C_Swept",
    Content = "PanelText_UI_Dungeous_Popup_Swept_Tip_Text_C_Swept_Content|重现次数"
  },
  UI_Chapter_Panel_Main_Text_Progress = {
    ID = "UI_Chapter_Panel_Main_Text_Progress",
    Content = "PanelText_UI_Chapter_Panel_Main_Text_Progress_Content|/"
  },
  UI_Chapter_Panel_Main_Text_Progressline2 = {
    ID = "UI_Chapter_Panel_Main_Text_Progressline2",
    Content = "PanelText_UI_Chapter_Panel_Main_Text_Progressline2_Content|/"
  },
  UI_Dungeous_Panel_BossSel1_Text_C_Name = {
    ID = "UI_Dungeous_Panel_BossSel1_Text_C_Name",
    Content = "PanelText_UI_Dungeous_Panel_BossSel1_Text_C_Name_Content|重现"
  },
  UI_Dungeous_Panel_SecEntrance_Text_Name = {
    ID = "UI_Dungeous_Panel_SecEntrance_Text_Name",
    Content = "PanelText_UI_Dungeous_Panel_SecEntrance_Text_Name_Content|重现"
  },
  UI_Recharge_Panel_Main_Text_C_Get1_Num = {
    ID = "UI_Recharge_Panel_Main_Text_C_Get1_Num",
    Content = "PanelText_UI_Recharge_Panel_Main_Text_C_Get1_Num_Content|×100"
  },
  UI_Recharge_Panel_Main_Text_C_Get1_NumName = {
    ID = "UI_Recharge_Panel_Main_Text_C_Get1_NumName",
    Content = "PanelText_UI_Recharge_Panel_Main_Text_C_Get1_NumName_Content|源液"
  },
  UI_Recharge_Panel_Main_Text_C_Get2_Num = {
    ID = "UI_Recharge_Panel_Main_Text_C_Get2_Num",
    Content = "PanelText_UI_Recharge_Panel_Main_Text_C_Get2_Num_Content|×100"
  },
  UI_Recharge_Panel_Main_Text_C_Get2_NumName = {
    ID = "UI_Recharge_Panel_Main_Text_C_Get2_NumName",
    Content = "PanelText_UI_Recharge_Panel_Main_Text_C_Get2_NumName_Content|银芯"
  },
  UI_Recharge_Panel_Main_Text_C_Today = {
    ID = "UI_Recharge_Panel_Main_Text_C_Today",
    Content = "PanelText_UI_Recharge_Panel_Main_Text_C_Today_Content|今天已领取"
  },
  UI_Recharge_Panel_Main_Text_Tips = {
    ID = "UI_Recharge_Panel_Main_Text_Tips",
    Content = "PanelText_UI_Recharge_Panel_Main_Text_Tips_Content|*累计可获得「银芯」× 300 +「银芯」× 6000"
  },
  UI_Recharge_Panel_Main_Text_Name = {
    ID = "UI_Recharge_Panel_Main_Text_Name",
    Content = "PanelText_UI_Recharge_Panel_Main_Text_Name_Content|购买"
  },
  UI_Summon_Result_Panel_Text_C_Title = {
    ID = "UI_Summon_Result_Panel_Text_C_Title",
    Content = "PanelText_UI_Summon_Result_Panel_Text_C_Title_Content|ID:"
  },
  UI_Summon_Popup_Share_Text_C_Share = {
    ID = "UI_Summon_Popup_Share_Text_C_Share",
    Content = "PanelText_UI_Summon_Popup_Share_Text_C_Share_Content|分享至："
  },
  UI_Chapter_Item_Chapter_Small_Text_C_Expect1 = {
    ID = "UI_Chapter_Item_Chapter_Small_Text_C_Expect1",
    Content = "PanelText_UI_Chapter_Item_Chapter_Small_Text_C_Expect1_Content|尚未解锁"
  },
  UI_Chapter_Item_Chapter_Small_Text_C_Expect2 = {
    ID = "UI_Chapter_Item_Chapter_Small_Text_C_Expect2",
    Content = "PanelText_UI_Chapter_Item_Chapter_Small_Text_C_Expect2_Content|尚未解锁"
  },
  UI_Alchemy_Popup_Resolve_Text_C_Whole = {
    ID = "UI_Alchemy_Popup_Resolve_Text_C_Whole",
    Content = "PanelText_UI_Alchemy_Popup_Resolve_Text_C_Whole_Content|全选"
  },
  UI_Recharge_Courtesy_Item_Text_C_Sellout = {
    ID = "UI_Recharge_Courtesy_Item_Text_C_Sellout",
    Content = "PanelText_UI_Recharge_Courtesy_Item_Text_C_Sellout_Content|已售罄"
  },
  UI_Recharge_Exchange_Tips_Text_C_Title = {
    ID = "UI_Recharge_Exchange_Tips_Text_C_Title",
    Content = "PanelText_UI_Recharge_Exchange_Tips_Text_C_Title_Content|确定兑换"
  },
  UI_Alchemy_Popup_Permute_Text_C_Tips = {
    ID = "UI_Alchemy_Popup_Permute_Text_C_Tips",
    Content = "PanelText_UI_Alchemy_Popup_Permute_Text_C_Tips_Content|当前没有可以分解的道具"
  },
  UI_Alchemy_Popup_Permute_Text_C_Possess_Tips = {
    ID = "UI_Alchemy_Popup_Permute_Text_C_Possess_Tips",
    Content = "PanelText_UI_Alchemy_Popup_Permute_Text_C_Possess_Tips_Content|即将置换"
  },
  UI_Alchemy_Popup_Permute_Text_C_Title = {
    ID = "UI_Alchemy_Popup_Permute_Text_C_Title",
    Content = "PanelText_UI_Alchemy_Popup_Permute_Text_C_Title_Content|置换所需材料"
  },
  UI_Alchemy_Popup_Permute_Text_C_Whole = {
    ID = "UI_Alchemy_Popup_Permute_Text_C_Whole",
    Content = "PanelText_UI_Alchemy_Popup_Permute_Text_C_Whole_Content|全选"
  },
  UI_Alchemy_Popup_Permute_Text_C_Name = {
    ID = "UI_Alchemy_Popup_Permute_Text_C_Name",
    Content = "PanelText_UI_Alchemy_Popup_Permute_Text_C_Name_Content|置换"
  },
  UI_Shop_Item_Toggle_Text_C_Recommend = {
    ID = "UI_Shop_Item_Toggle_Text_C_Recommend",
    Content = "PanelText_UI_Shop_Item_Toggle_Text_C_Recommend_Content|推荐"
  },
  UI_Summon_Popup_Total_Show_Text_C_Title = {
    ID = "UI_Summon_Popup_Total_Show_Text_C_Title",
    Content = "PanelText_UI_Summon_Popup_Total_Show_Text_C_Title_Content|ID:"
  },
  UI_Recharge_Panel_Month_Tips_Text_C_Today = {
    ID = "UI_Recharge_Panel_Month_Tips_Text_C_Today",
    Content = "PanelText_UI_Recharge_Panel_Month_Tips_Text_C_Today_Content|点击领取月相观测奖励"
  },
  UI_Summon_Popup_Total_Show_Text_C_Share = {
    ID = "UI_Summon_Popup_Total_Show_Text_C_Share",
    Content = "PanelText_UI_Summon_Popup_Total_Show_Text_C_Share_Content|首次分享得"
  },
  UI_Summon_Result_Panel_Text_C_Share = {
    ID = "UI_Summon_Result_Panel_Text_C_Share",
    Content = "PanelText_UI_Summon_Result_Panel_Text_C_Share_Content|首次分享得"
  },
  UI_Common_Btn_Share_Text_C_Share = {
    ID = "UI_Common_Btn_Share_Text_C_Share",
    Content = "PanelText_UI_Common_Btn_Share_Text_C_Share_Content|首次分享得"
  },
  UI_Recharge_Exchange_Tips_Text_C_illustrate = {
    ID = "UI_Recharge_Exchange_Tips_Text_C_illustrate",
    Content = "PanelText_UI_Recharge_Exchange_Tips_Text_C_illustrate_Content|玩法规则"
  },
  UI_Recharge_Panel_Main_Text_C_Need = {
    ID = "UI_Recharge_Panel_Main_Text_C_Need",
    Content = "PanelText_UI_Recharge_Panel_Main_Text_C_Need_Content|需要"
  },
  UI_Main_Helicopter_Tips_Text_C_Title = {
    ID = "UI_Main_Helicopter_Tips_Text_C_Title",
    Content = "PanelText_UI_Main_Helicopter_Tips_Text_C_Title_Content|宿舍"
  },
  UI_Main_Helicopter_Tips_Text_C_Awaken = {
    ID = "UI_Main_Helicopter_Tips_Text_C_Awaken",
    Content = "PanelText_UI_Main_Helicopter_Tips_Text_C_Awaken_Content|唤醒日期"
  },
  UI_Main_Helicopter_Tips_Text_C_Favor = {
    ID = "UI_Main_Helicopter_Tips_Text_C_Favor",
    Content = "PanelText_UI_Main_Helicopter_Tips_Text_C_Favor_Content|当前同调率"
  },
  UI_Main_Helicopter_Tips_Text_C_Tip = {
    ID = "UI_Main_Helicopter_Tips_Text_C_Tip",
    Content = "PanelText_UI_Main_Helicopter_Tips_Text_C_Tip_Content|邀请唤醒体后，每隔一段时间该唤醒体可获得同调率"
  },
  UI_Main_Panel_1_Text_C_Acclaim = {
    ID = "UI_Main_Panel_1_Text_C_Acclaim",
    Content = "PanelText_UI_Main_Panel_1_Text_C_Acclaim_Content|好评"
  },
  UI_Main_Panel_1_Text_C_Community = {
    ID = "UI_Main_Panel_1_Text_C_Community",
    Content = "PanelText_UI_Main_Panel_1_Text_C_Community_Content|社区"
  },
  UI_Recharge_Panel_Main_Text_C_Upgrade = {
    ID = "UI_Recharge_Panel_Main_Text_C_Upgrade",
    Content = "PanelText_UI_Recharge_Panel_Main_Text_C_Upgrade_Content|Upgrade"
  },
  UI_Bag_Obtain_Awaken_Tips_Text_C_Title = {
    ID = "UI_Bag_Obtain_Awaken_Tips_Text_C_Title",
    Content = "PanelText_UI_Bag_Obtain_Awaken_Tips_Text_C_Title_Content|选择唤醒体残片"
  },
  UI_Bag_Obtain_Awaken_Tips_Text_C_Yes = {
    ID = "UI_Bag_Obtain_Awaken_Tips_Text_C_Yes",
    Content = "PanelText_UI_Bag_Obtain_Awaken_Tips_Text_C_Yes_Content|已拥有"
  },
  UI_Bag_Obtain_Awaken_Tips_Text_C_Full = {
    ID = "UI_Bag_Obtain_Awaken_Tips_Text_C_Full",
    Content = "PanelText_UI_Bag_Obtain_Awaken_Tips_Text_C_Full_Content|启灵已满"
  },
  UI_Events_Panel_Main_Text_Title = {
    ID = "UI_Events_Panel_Main_Text_Title",
    Content = "PanelText_UI_Events_Panel_Main_Text_Title_Content|活动"
  },
  UI_Events_Panel_Spur_Text_C_Limit = {
    ID = "UI_Events_Panel_Spur_Text_C_Limit",
    Content = "PanelText_UI_Events_Panel_Spur_Text_C_Limit_Content|调查奖励"
  },
  UI_Summon_Popup_Presented_Tip_Text_C_Game = {
    ID = "UI_Summon_Popup_Presented_Tip_Text_C_Game",
    Content = "PanelText_UI_Summon_Popup_Presented_Tip_Text_C_Game_Content|唤醒体赠送"
  },
  UI_Summon_Popup_Presented_Tip_Text_C_Activity = {
    ID = "UI_Summon_Popup_Presented_Tip_Text_C_Activity",
    Content = "PanelText_UI_Summon_Popup_Presented_Tip_Text_C_Activity_Content|命轮赠送"
  },
  UI_Summon_Popup_Presented_Tip_Text_C_Line = {
    ID = "UI_Summon_Popup_Presented_Tip_Text_C_Line",
    Content = "PanelText_UI_Summon_Popup_Presented_Tip_Text_C_Line_Content|/"
  },
  UI_Summon_Popup_Presented_Tip_Text_C_Plan = {
    ID = "UI_Summon_Popup_Presented_Tip_Text_C_Plan",
    Content = "PanelText_UI_Summon_Popup_Presented_Tip_Text_C_Plan_Content|进度"
  },
  UI_Summon_Popup_Presented_Tip_Text_C_Info = {
    ID = "UI_Summon_Popup_Presented_Tip_Text_C_Info",
    Content = "PanelText_UI_Summon_Popup_Presented_Tip_Text_C_Info_Content|每进行150次【界域研习】唤醒后，可额外获取以上任意一个唤醒体/命轮"
  },
  UI_Summon_Popup_Presented_Tip_Text_Check = {
    ID = "UI_Summon_Popup_Presented_Tip_Text_Check",
    Content = "PanelText_UI_Summon_Popup_Presented_Tip_Text_Check_Content|查看详情"
  },
  UI_Summon_Popup_Presented_Tip_Text_Git = {
    ID = "UI_Summon_Popup_Presented_Tip_Text_Git",
    Content = "PanelText_UI_Summon_Popup_Presented_Tip_Text_Git_Content|领取"
  },
  UI_Summon_Panel_Main_Text_Award = {
    ID = "UI_Summon_Panel_Main_Text_Award",
    Content = "PanelText_UI_Summon_Panel_Main_Text_Award_Content|额外奖励"
  },
  UI_Awaker_Item_List_Text_C_Full = {
    ID = "UI_Awaker_Item_List_Text_C_Full",
    Content = "PanelText_UI_Awaker_Item_List_Text_C_Full_Content|人格深化已满"
  },
  UI_Awaker_Item_List_Text_C_Already = {
    ID = "UI_Awaker_Item_List_Text_C_Already",
    Content = "PanelText_UI_Awaker_Item_List_Text_C_Already_Content|已拥有"
  },
  UI_Chapter_Panel_Main2_ItemBranch_Text_C_Award = {
    ID = "UI_Chapter_Panel_Main2_ItemBranch_Text_C_Award",
    Content = "PanelText_UI_Chapter_Panel_Main2_ItemBranch_Text_C_Award_Content|所有奖励条件已达成"
  },
  UI_Chapter_Panel_Spur_Text_C_Simple = {
    ID = "UI_Chapter_Panel_Spur_Text_C_Simple",
    Content = "PanelText_UI_Chapter_Panel_Spur_Text_C_Simple_Content|普通"
  },
  UI_Chapter_Panel_Spur_Text_C_Difficulty = {
    ID = "UI_Chapter_Panel_Spur_Text_C_Difficulty",
    Content = "PanelText_UI_Chapter_Panel_Spur_Text_C_Difficulty_Content|困难"
  },
  UI_Chapter_Panel_Spur_Text_C_Nightmare = {
    ID = "UI_Chapter_Panel_Spur_Text_C_Nightmare",
    Content = "PanelText_UI_Chapter_Panel_Spur_Text_C_Nightmare_Content|癫狂"
  },
  UI_Chapter_Panel_Spur_Text_C_Progress = {
    ID = "UI_Chapter_Panel_Spur_Text_C_Progress",
    Content = "PanelText_UI_Chapter_Panel_Spur_Text_C_Progress_Content|调查进度"
  },
  UI_Chapter_Panel_Spur_Text_C_Tab_Special = {
    ID = "UI_Chapter_Panel_Spur_Text_C_Tab_Special",
    Content = "PanelText_UI_Chapter_Panel_Spur_Text_C_Tab_Special_Content|限时活动"
  },
  UI_Events_Panel_Branch_Text_C_Title = {
    ID = "UI_Events_Panel_Branch_Text_C_Title",
    Content = "PanelText_UI_Events_Panel_Branch_Text_C_Title_Content|奖励预览"
  },
  UI_Events_Panel_Branch_Text_C_Over = {
    ID = "UI_Events_Panel_Branch_Text_C_Over",
    Content = "PanelText_UI_Events_Panel_Branch_Text_C_Over_Content|所有奖励已领取"
  },
  UI_Chaper_Popup_Particulars_New_Text_C_Cost_Tips = {
    ID = "UI_Chaper_Popup_Particulars_New_Text_C_Cost_Tips",
    Content = "PanelText_UI_Chaper_Popup_Particulars_New_Text_C_Cost_Tips_Content|队伍要求："
  },
  UI_Team_Panel_Main_Text_C_Cost_Tips = {
    ID = "UI_Team_Panel_Main_Text_C_Cost_Tips",
    Content = "PanelText_UI_Team_Panel_Main_Text_C_Cost_Tips_Content|队伍要求："
  },
  UI_Dungeons_Panel_Realms_Text_C_illustrate = {
    ID = "UI_Dungeons_Panel_Realms_Text_C_illustrate",
    Content = "PanelText_UI_Dungeons_Panel_Realms_Text_C_illustrate_Content|玩法规则"
  },
  UI_Dungeons_Panel_Realms_Text_C_Name_1 = {
    ID = "UI_Dungeons_Panel_Realms_Text_C_Name_1",
    Content = "PanelText_UI_Dungeons_Panel_Realms_Text_C_Name_1_Content|混沌之域"
  },
  UI_Dungeons_Panel_Realms_Text_C_Name_2 = {
    ID = "UI_Dungeons_Panel_Realms_Text_C_Name_2",
    Content = "PanelText_UI_Dungeons_Panel_Realms_Text_C_Name_2_Content|血月之塔"
  },
  UI_Dungeons_Panel_Realms_Text_C_Name_3 = {
    ID = "UI_Dungeons_Panel_Realms_Text_C_Name_3",
    Content = "PanelText_UI_Dungeons_Panel_Realms_Text_C_Name_3_Content|暗海之渊"
  },
  UI_Dungeons_Panel_Realms_Text_C_Name_4 = {
    ID = "UI_Dungeons_Panel_Realms_Text_C_Name_4",
    Content = "PanelText_UI_Dungeons_Panel_Realms_Text_C_Name_4_Content|超维之旅"
  },
  UI_Dungeous_Panel_Realms_Text_C_Award = {
    ID = "UI_Dungeous_Panel_Realms_Text_C_Award",
    Content = "PanelText_UI_Dungeous_Panel_Realms_Text_C_Award_Content|敌方详情"
  },
  UI_Dungeous_Panel_Realms_Text_C_Reward = {
    ID = "UI_Dungeous_Panel_Realms_Text_C_Reward",
    Content = "PanelText_UI_Dungeous_Panel_Realms_Text_C_Reward_Content|奖励预览"
  },
  UI_Dungeous_Panel_Realms_Text_C_Special = {
    ID = "UI_Dungeous_Panel_Realms_Text_C_Special",
    Content = "PanelText_UI_Dungeous_Panel_Realms_Text_C_Special_Content|初始造物"
  },
  UI_Dungeous_Panel_Realms_Text_C_Boundaries_Tips = {
    ID = "UI_Dungeous_Panel_Realms_Text_C_Boundaries_Tips",
    Content = "PanelText_UI_Dungeous_Panel_Realms_Text_C_Boundaries_Tips_Content|推荐界域"
  },
  UI_Dungeous_Panel_Realms_Text_C_Cost_Tips = {
    ID = "UI_Dungeous_Panel_Realms_Text_C_Cost_Tips",
    Content = "PanelText_UI_Dungeous_Panel_Realms_Text_C_Cost_Tips_Content|队伍要求"
  },
  UI_Dungeous_Panel_Realms_Text_C_Tishi = {
    ID = "UI_Dungeous_Panel_Realms_Text_C_Tishi",
    Content = "PanelText_UI_Dungeous_Panel_Realms_Text_C_Tishi_Content|星级进度"
  },
  UI_Dungeous_Panel_Realms_Text_C_Creation = {
    ID = "UI_Dungeous_Panel_Realms_Text_C_Creation",
    Content = "PanelText_UI_Dungeous_Panel_Realms_Text_C_Creation_Content|关卡造物"
  },
  UI_Other_Popup_Key_Obtain_Text_C_Info = {
    ID = "UI_Other_Popup_Key_Obtain_Text_C_Info",
    Content = "PanelText_UI_Other_Popup_Key_Obtain_Text_C_Info_Content|点击空白处关闭"
  },
  UI_Other_Popup_Key_Obtain_Text_C_Energy = {
    ID = "UI_Other_Popup_Key_Obtain_Text_C_Energy",
    Content = "PanelText_UI_Other_Popup_Key_Obtain_Text_C_Energy_Content|消耗能量："
  },
  UI_Protagonist_Item_Skill_Text_C_No = {
    ID = "UI_Protagonist_Item_Skill_Text_C_No",
    Content = "PanelText_UI_Protagonist_Item_Skill_Text_C_No_Content|未获得"
  },
  UI_Protagonist_Item_Skill_Text_C_Current = {
    ID = "UI_Protagonist_Item_Skill_Text_C_Current",
    Content = "PanelText_UI_Protagonist_Item_Skill_Text_C_Current_Content|当前"
  },
  UI_Chapter_Panel_Main2_Text_C_Simple = {
    ID = "UI_Chapter_Panel_Main2_Text_C_Simple",
    Content = "PanelText_UI_Chapter_Panel_Main2_Text_C_Simple_Content|普通"
  },
  UI_Chapter_Panel_Main2_Text_C_Time = {
    ID = "UI_Chapter_Panel_Main2_Text_C_Time",
    Content = "PanelText_UI_Chapter_Panel_Main2_Text_C_Time_Content|2023/12/21 05:00上新，敬请期待"
  },
  UI_Chapter_Panel_Main2_Text_C_Difficulty = {
    ID = "UI_Chapter_Panel_Main2_Text_C_Difficulty",
    Content = "PanelText_UI_Chapter_Panel_Main2_Text_C_Difficulty_Content|困难"
  },
  UI_Chapter_Panel_Main2_Text_C_Nightmare = {
    ID = "UI_Chapter_Panel_Main2_Text_C_Nightmare",
    Content = "PanelText_UI_Chapter_Panel_Main2_Text_C_Nightmare_Content|癫狂"
  },
  UI_Chapter_Panel_Main2_Text_C_NoTask = {
    ID = "UI_Chapter_Panel_Main2_Text_C_NoTask",
    Content = "PanelText_UI_Chapter_Panel_Main2_Text_C_NoTask_Content|暂无特遣纪录"
  },
  UI_Chapter_Item_Achievement_List_Text_C_Lost = {
    ID = "UI_Chapter_Item_Achievement_List_Text_C_Lost",
    Content = "PanelText_UI_Chapter_Item_Achievement_List_Text_C_Lost_Content|未达成"
  },
  UI_Team_Panel_Main_Text_C_Skill = {
    ID = "UI_Team_Panel_Main_Text_C_Skill",
    Content = "PanelText_UI_Team_Panel_Main_Text_C_Skill_Content|钥令"
  },
  UI_Keeper_Skill_Panel_Text_C_Name_1 = {
    ID = "UI_Keeper_Skill_Panel_Text_C_Name_1",
    Content = "PanelText_UI_Keeper_Skill_Panel_Text_C_Name_1_Content|选择"
  },
  UI_Keeper_Skill_Panel_Text_C_Name_2 = {
    ID = "UI_Keeper_Skill_Panel_Text_C_Name_2",
    Content = "PanelText_UI_Keeper_Skill_Panel_Text_C_Name_2_Content|取消"
  },
  UI_Course_Panel_Main_Text_C_Placeholder = {
    ID = "UI_Course_Panel_Main_Text_C_Placeholder",
    Content = "PanelText_UI_Course_Panel_Main_Text_C_Placeholder_Content|搜索教学..."
  },
  UI_Course_Panel_Main_Text_C_NumLine = {
    ID = "UI_Course_Panel_Main_Text_C_NumLine",
    Content = "PanelText_UI_Course_Panel_Main_Text_C_NumLine_Content|/"
  },
  UI_Course_Panel_Text_Title = {
    ID = "UI_Course_Panel_Text_Title",
    Content = "PanelText_UI_Course_Panel_Text_Title_Content|教学"
  },
  UI_Course_Panel_Main_Text_C_NoTask = {
    ID = "UI_Course_Panel_Main_Text_C_NoTask",
    Content = "PanelText_UI_Course_Panel_Main_Text_C_NoTask_Content|暂时没有此类型教学"
  },
  UI_Recharge_Panel_Extract_Text_C_Title = {
    ID = "UI_Recharge_Panel_Extract_Text_C_Title",
    Content = "PanelText_UI_Recharge_Panel_Extract_Text_C_Title_Content|源液提取"
  },
  UI_Recharge_Panel_Extract_Text_PayTip = {
    ID = "UI_Recharge_Panel_Extract_Text_PayTip",
    Content = "PanelText_UI_Recharge_Panel_Extract_Text_PayTip_Content|当前展示价格为默认货币价格，仅供参考。支付时请以实际货币和价格为准。"
  },
  UI_Recharge_Panel_Extract_Text_C_Buttom = {
    ID = "UI_Recharge_Panel_Extract_Text_C_Buttom",
    Content = "PanelText_UI_Recharge_Panel_Extract_Text_C_Buttom_Content|每档首充额外赠送等额「源液」，仅限一次"
  },
  UI_Recharge_Panel_Extract_Text_C_Refresh = {
    ID = "UI_Recharge_Panel_Extract_Text_C_Refresh",
    Content = "PanelText_UI_Recharge_Panel_Extract_Text_C_Refresh_Content|联系客服"
  },
  UI_Recharge_Instructions_Text_Name = {
    ID = "UI_Recharge_Instructions_Text_Name",
    Content = "PanelText_UI_Recharge_Instructions_Text_Name_Content|前往"
  },
  UI_Chapter_Panel_Main_Text_C_Tishi_2 = {
    ID = "UI_Chapter_Panel_Main_Text_C_Tishi_2",
    Content = "PanelText_UI_Chapter_Panel_Main_Text_C_Tishi_2_Content|关卡成就"
  },
  UI_Battle_Popup_Keeper_Skill_Tip_Text_C_Awaker_School = {
    ID = "UI_Battle_Popup_Keeper_Skill_Tip_Text_C_Awaker_School",
    Content = "PanelText_UI_Battle_Popup_Keeper_Skill_Tip_Text_C_Awaker_School_Content|守密人"
  },
  UI_Chaper_Popup_Level_Success_Text_C_Title = {
    ID = "UI_Chaper_Popup_Level_Success_Text_C_Title",
    Content = "PanelText_UI_Chaper_Popup_Level_Success_Text_C_Title_Content|关卡成就"
  },
  UI_Dbgcopy_Panel_Select_Extra_Text_C_Name = {
    ID = "UI_Dbgcopy_Panel_Select_Extra_Text_C_Name",
    Content = "PanelText_UI_Dbgcopy_Panel_Select_Extra_Text_C_Name_Content|放弃"
  },
  UI_Awaker_Item_Skill_Upgrades_Text_C_Or_1 = {
    ID = "UI_Awaker_Item_Skill_Upgrades_Text_C_Or_1",
    Content = "PanelText_UI_Awaker_Item_Skill_Upgrades_Text_C_Or_1_Content|/"
  },
  UI_Awaker_Item_Skill_Upgrades_Text_C_Maniac = {
    ID = "UI_Awaker_Item_Skill_Upgrades_Text_C_Maniac",
    Content = "PanelText_UI_Awaker_Item_Skill_Upgrades_Text_C_Maniac_Content|狂气爆发"
  },
  UI_Awaker_Item_Skill_Upgrades_Text_C_Or_2 = {
    ID = "UI_Awaker_Item_Skill_Upgrades_Text_C_Or_2",
    Content = "PanelText_UI_Awaker_Item_Skill_Upgrades_Text_C_Or_2_Content|/"
  },
  UI_Awaker_Item_Skill_Upgrades_Text_C_Name_1 = {
    ID = "UI_Awaker_Item_Skill_Upgrades_Text_C_Name_1",
    Content = "PanelText_UI_Awaker_Item_Skill_Upgrades_Text_C_Name_1_Content|当前"
  },
  UI_Awaker_Item_Skill_Upgrades_Text_C_Name_2 = {
    ID = "UI_Awaker_Item_Skill_Upgrades_Text_C_Name_2",
    Content = "PanelText_UI_Awaker_Item_Skill_Upgrades_Text_C_Name_2_Content|当前"
  },
  UI_Awaker_Item_Skill_Upgrades_Text_C_Name_3 = {
    ID = "UI_Awaker_Item_Skill_Upgrades_Text_C_Name_3",
    Content = "PanelText_UI_Awaker_Item_Skill_Upgrades_Text_C_Name_3_Content|下一级"
  },
  UI_Awaker_Item_Skill_Upgrades_Text_C_Name_4 = {
    ID = "UI_Awaker_Item_Skill_Upgrades_Text_C_Name_4",
    Content = "PanelText_UI_Awaker_Item_Skill_Upgrades_Text_C_Name_4_Content|下一级"
  },
  UI_Awaker_Item_Skill_Upgrades_Text_C_Attribute = {
    ID = "UI_Awaker_Item_Skill_Upgrades_Text_C_Attribute",
    Content = "PanelText_UI_Awaker_Item_Skill_Upgrades_Text_C_Attribute_Content|属性"
  },
  UI_Awaker_Item_Skill_Upgrades_Text_C_Material = {
    ID = "UI_Awaker_Item_Skill_Upgrades_Text_C_Material",
    Content = "PanelText_UI_Awaker_Item_Skill_Upgrades_Text_C_Material_Content|消耗材料"
  },
  UI_Awaker_Item_Skill_Upgrades_Text_C_Tale = {
    ID = "UI_Awaker_Item_Skill_Upgrades_Text_C_Tale",
    Content = "PanelText_UI_Awaker_Item_Skill_Upgrades_Text_C_Tale_Content|故事"
  },
  UI_Awaker_Item_Skill_Upgrades_Text_C_Text = {
    ID = "UI_Awaker_Item_Skill_Upgrades_Text_C_Text",
    Content = "PanelText_UI_Awaker_Item_Skill_Upgrades_Text_C_Text_Content|需要"
  },
  UI_Awaker_Item_Skill_Training_Text_C_Maniac = {
    ID = "UI_Awaker_Item_Skill_Training_Text_C_Maniac",
    Content = "PanelText_UI_Awaker_Item_Skill_Training_Text_C_Maniac_Content|狂气爆发"
  },
  UI_Awaker_Item_Skill_Training_Text_C_Lv = {
    ID = "UI_Awaker_Item_Skill_Training_Text_C_Lv",
    Content = "PanelText_UI_Awaker_Item_Skill_Training_Text_C_Lv_Content|Lv."
  },
  UI_Awaker_Popup_illustrate_Tips_Text_C_Title = {
    ID = "UI_Awaker_Popup_illustrate_Tips_Text_C_Title",
    Content = "PanelText_UI_Awaker_Popup_illustrate_Tips_Text_C_Title_Content|词缀说明"
  },
  UI_Chapter_Panel_Spur_Text_C_Tishi = {
    ID = "UI_Chapter_Panel_Spur_Text_C_Tishi",
    Content = "PanelText_UI_Chapter_Panel_Spur_Text_C_Tishi_Content|关卡成就"
  },
  UI_Alchemy_Panel_Main_Text_C_Alchemy = {
    ID = "UI_Alchemy_Panel_Main_Text_C_Alchemy",
    Content = "PanelText_UI_Alchemy_Panel_Main_Text_C_Alchemy_Content|材料合成"
  },
  UI_Alchemy_Panel_Main_Text_C_Recast = {
    ID = "UI_Alchemy_Panel_Main_Text_C_Recast",
    Content = "PanelText_UI_Alchemy_Panel_Main_Text_C_Recast_Content|密契重印"
  },
  UI_Alchemy_Panel_Main_Text_C_Permute = {
    ID = "UI_Alchemy_Panel_Main_Text_C_Permute",
    Content = "PanelText_UI_Alchemy_Panel_Main_Text_C_Permute_Content|材料置换"
  },
  UI_Alchemy_Panel_Main_Text_C_ResolveWeapon = {
    ID = "UI_Alchemy_Panel_Main_Text_C_ResolveWeapon",
    Content = "PanelText_UI_Alchemy_Panel_Main_Text_C_ResolveWeapon_Content|命轮分解"
  },
  UI_Alchemy_Panel_Main_Text_C_Achievement = {
    ID = "UI_Alchemy_Panel_Main_Text_C_Achievement",
    Content = "PanelText_UI_Alchemy_Panel_Main_Text_C_Achievement_Content|密契分解"
  },
  UI_Task_Panel_Main_New_Text_C_ActionReports = {
    ID = "UI_Task_Panel_Main_New_Text_C_ActionReports",
    Content = "PanelText_UI_Task_Panel_Main_New_Text_C_ActionReports_Content|行动报告"
  },
  UI_Task_Panel_Main_New_Text_C_GrowUp = {
    ID = "UI_Task_Panel_Main_New_Text_C_GrowUp",
    Content = "PanelText_UI_Task_Panel_Main_New_Text_C_GrowUp_Content|成长记录"
  },
  UI_Task_Panel_Main_New_Text_C_Master = {
    ID = "UI_Task_Panel_Main_New_Text_C_Master",
    Content = "PanelText_UI_Task_Panel_Main_New_Text_C_Master_Content|界域精通"
  },
  UI_Task_Panel_Main_New_Text_C_Achievement = {
    ID = "UI_Task_Panel_Main_New_Text_C_Achievement",
    Content = "PanelText_UI_Task_Panel_Main_New_Text_C_Achievement_Content|生涯成就"
  },
  UI_Awaker_Item_Skill_Training_Text_C_Lv_1 = {
    ID = "UI_Awaker_Item_Skill_Training_Text_C_Lv_1",
    Content = "PanelText_UI_Awaker_Item_Skill_Training_Text_C_Lv_1_Content|Lv."
  },
  UI_Awaker_Item_Skill_Training_Text_C_Name_1 = {
    ID = "UI_Awaker_Item_Skill_Training_Text_C_Name_1",
    Content = "PanelText_UI_Awaker_Item_Skill_Training_Text_C_Name_1_Content|当前"
  },
  UI_Awaker_Item_Skill_Training_Text_C_Name_2 = {
    ID = "UI_Awaker_Item_Skill_Training_Text_C_Name_2",
    Content = "PanelText_UI_Awaker_Item_Skill_Training_Text_C_Name_2_Content|当前"
  },
  UI_Awaker_Item_Skill_Training_Text_C_Name_3 = {
    ID = "UI_Awaker_Item_Skill_Training_Text_C_Name_3",
    Content = "PanelText_UI_Awaker_Item_Skill_Training_Text_C_Name_3_Content|下一级"
  },
  UI_Awaker_Item_Skill_Training_Text_C_Name_4 = {
    ID = "UI_Awaker_Item_Skill_Training_Text_C_Name_4",
    Content = "PanelText_UI_Awaker_Item_Skill_Training_Text_C_Name_4_Content|下一级"
  },
  UI_Awaker_Item_Skill_Training_Text_C_Attribute = {
    ID = "UI_Awaker_Item_Skill_Training_Text_C_Attribute",
    Content = "PanelText_UI_Awaker_Item_Skill_Training_Text_C_Attribute_Content|属性"
  },
  UI_Awaker_Item_Skill_Training_Text_C_Material = {
    ID = "UI_Awaker_Item_Skill_Training_Text_C_Material",
    Content = "PanelText_UI_Awaker_Item_Skill_Training_Text_C_Material_Content|消耗材料"
  },
  UI_Awaker_Item_Skill_Training_Text_C_Tale = {
    ID = "UI_Awaker_Item_Skill_Training_Text_C_Tale",
    Content = "PanelText_UI_Awaker_Item_Skill_Training_Text_C_Tale_Content|故事"
  },
  UI_Awaker_Item_Skill_Training_Text_C_Full = {
    ID = "UI_Awaker_Item_Skill_Training_Text_C_Full",
    Content = "PanelText_UI_Awaker_Item_Skill_Training_Text_C_Full_Content|已达等级上限"
  },
  UI_Dungeons_Panel_Out_Text_C_Sync = {
    ID = "UI_Dungeons_Panel_Out_Text_C_Sync",
    Content = "PanelText_UI_Dungeons_Panel_Out_Text_C_Sync_Content|唤醒体同调率提升"
  },
  UI_Awaker_Item_Trinket_Refinement_Text_C_Refinement = {
    ID = "UI_Awaker_Item_Trinket_Refinement_Text_C_Refinement",
    Content = "PanelText_UI_Awaker_Item_Trinket_Refinement_Text_C_Refinement_Content|密契详情"
  },
  UI_Awaker_Item_Trinket_Refinement_Text_C_Deplete = {
    ID = "UI_Awaker_Item_Trinket_Refinement_Text_C_Deplete",
    Content = "PanelText_UI_Awaker_Item_Trinket_Refinement_Text_C_Deplete_Content|消耗材料"
  },
  UI_Awaker_Item_Trinket_Refinement_Text_C_Fast = {
    ID = "UI_Awaker_Item_Trinket_Refinement_Text_C_Fast",
    Content = "PanelText_UI_Awaker_Item_Trinket_Refinement_Text_C_Fast_Content|快速放入"
  },
  UI_Awaker_Item_Trinket_Refinement_Text_C_Name_3 = {
    ID = "UI_Awaker_Item_Trinket_Refinement_Text_C_Name_3",
    Content = "PanelText_UI_Awaker_Item_Trinket_Refinement_Text_C_Name_3_Content|升级"
  },
  UI_Awaker_Item_Trinket_Refinement_Text_C_Name_1 = {
    ID = "UI_Awaker_Item_Trinket_Refinement_Text_C_Name_1",
    Content = "PanelText_UI_Awaker_Item_Trinket_Refinement_Text_C_Name_1_Content|升级"
  },
  UI_Awaker_Item_Trinket_Refinement_Text_C_Name_2 = {
    ID = "UI_Awaker_Item_Trinket_Refinement_Text_C_Name_2",
    Content = "PanelText_UI_Awaker_Item_Trinket_Refinement_Text_C_Name_2_Content|转录"
  },
  UI_Awaker_Popup_Trinket_Upgrade_Text_C_Deplete = {
    ID = "UI_Awaker_Popup_Trinket_Upgrade_Text_C_Deplete",
    Content = "PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_Deplete_Content|消耗材料"
  },
  UI_Awaker_Popup_Trinket_Upgrade_Text_C_Fast = {
    ID = "UI_Awaker_Popup_Trinket_Upgrade_Text_C_Fast",
    Content = "PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_Fast_Content|快速放入"
  },
  UI_Awaker_Popup_Trinket_Upgrade_Text_C_Name_3 = {
    ID = "UI_Awaker_Popup_Trinket_Upgrade_Text_C_Name_3",
    Content = "PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_Name_3_Content|升级"
  },
  UI_Awaker_Popup_Trinket_Conversion_Text_C_Foundation = {
    ID = "UI_Awaker_Popup_Trinket_Conversion_Text_C_Foundation",
    Content = "PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_Foundation_Content|原副属性"
  },
  UI_Awaker_Popup_Trinket_Conversion_Text_C_Hoist = {
    ID = "UI_Awaker_Popup_Trinket_Conversion_Text_C_Hoist",
    Content = "PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_Hoist_Content|新副属性"
  },
  UI_Awaker_Popup_Trinket_Conversion_Text_C_Empty = {
    ID = "UI_Awaker_Popup_Trinket_Conversion_Text_C_Empty",
    Content = "PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_Empty_Content|点击转录获得新副属性"
  },
  UI_Awaker_Popup_Trinket_Conversion_Text_C_Text = {
    ID = "UI_Awaker_Popup_Trinket_Conversion_Text_C_Text",
    Content = "PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_Text_Content|需要"
  },
  UI_Awaker_Popup_Trinket_Conversion_Text_C_Name_1 = {
    ID = "UI_Awaker_Popup_Trinket_Conversion_Text_C_Name_1",
    Content = "PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_Name_1_Content|转录"
  },
  UI_Awaker_Popup_Trinket_Conversion_Text_C_Name_2 = {
    ID = "UI_Awaker_Popup_Trinket_Conversion_Text_C_Name_2",
    Content = "PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_Name_2_Content|替换"
  },
  UI_Common_Item_WuPin_Type1_Text_C_NoEquip = {
    ID = "UI_Common_Item_WuPin_Type1_Text_C_NoEquip",
    Content = "PanelText_UI_Common_Item_WuPin_Type1_Text_C_NoEquip_Content|无法装备"
  },
  UI_Common_Item_WuPin_Type1_Text_C_NotActive = {
    ID = "UI_Common_Item_WuPin_Type1_Text_C_NotActive",
    Content = "PanelText_UI_Common_Item_WuPin_Type1_Text_C_NotActive_Content|未生效"
  },
  UI_Common_Item_WuPin_Type1_Text_C_Using = {
    ID = "UI_Common_Item_WuPin_Type1_Text_C_Using",
    Content = "PanelText_UI_Common_Item_WuPin_Type1_Text_C_Using_Content|使用中"
  },
  UI_Community_Acclaim_Tips_Text_C_Name_1 = {
    ID = "UI_Community_Acclaim_Tips_Text_C_Name_1",
    Content = "PanelText_UI_Community_Acclaim_Tips_Text_C_Name_1_Content|前往评价"
  },
  UI_Bag_Panel_Main_Text_Normotopia = {
    ID = "UI_Bag_Panel_Main_Text_Normotopia",
    Content = "PanelText_UI_Bag_Panel_Main_Text_Normotopia_Content|叠位"
  },
  UI_Bag_Panel_Main_Text_Intensify = {
    ID = "UI_Bag_Panel_Main_Text_Intensify",
    Content = "PanelText_UI_Bag_Panel_Main_Text_Intensify_Content|强化"
  },
  UI_Pvp_Item_Card_Text_C_Replace = {
    ID = "UI_Pvp_Item_Card_Text_C_Replace",
    Content = "PanelText_UI_Pvp_Item_Card_Text_C_Replace_Content|替换"
  },
  UI_Pvp_Panel_Main_Text_C_Unclickable = {
    ID = "UI_Pvp_Panel_Main_Text_C_Unclickable",
    Content = "PanelText_UI_Pvp_Panel_Main_Text_C_Unclickable_Content|结束"
  },
  UI_Pvp_Panel_Main_Text_C_Name = {
    ID = "UI_Pvp_Panel_Main_Text_C_Name",
    Content = "PanelText_UI_Pvp_Panel_Main_Text_C_Name_Content|结束"
  },
  UI_Pvp_Panel_Main_Text_C_Zongshanghai = {
    ID = "UI_Pvp_Panel_Main_Text_C_Zongshanghai",
    Content = "PanelText_UI_Pvp_Panel_Main_Text_C_Zongshanghai_Content|总伤害"
  },
  UI_Pvp_Popup_Replacement_Text_C_Initial = {
    ID = "UI_Pvp_Popup_Replacement_Text_C_Initial",
    Content = "PanelText_UI_Pvp_Popup_Replacement_Text_C_Initial_Content|初始手牌"
  },
  UI_Pvp_Popup_Replacement_Text_C_Prompt = {
    ID = "UI_Pvp_Popup_Replacement_Text_C_Prompt",
    Content = "PanelText_UI_Pvp_Popup_Replacement_Text_C_Prompt_Content|点击替换不想要的手牌"
  },
  UI_Pvp_Blood_Share_Text_C_Release = {
    ID = "UI_Pvp_Blood_Share_Text_C_Release",
    Content = "PanelText_UI_Pvp_Blood_Share_Text_C_Release_Content|点击释放"
  },
  UI_Pvp_Popup_Victory_Text_C_Victory = {
    ID = "UI_Pvp_Popup_Victory_Text_C_Victory",
    Content = "PanelText_UI_Pvp_Popup_Victory_Text_C_Victory_Content|胜利"
  },
  UI_Pvp_Popup_Victory_Text_C_Fail = {
    ID = "UI_Pvp_Popup_Victory_Text_C_Fail",
    Content = "PanelText_UI_Pvp_Popup_Victory_Text_C_Fail_Content|失败"
  },
  UI_Pvp_Popup_Victory_Text_C_Yellow = {
    ID = "UI_Pvp_Popup_Victory_Text_C_Yellow",
    Content = "PanelText_UI_Pvp_Popup_Victory_Text_C_Yellow_Content|点击继续"
  },
  UI_Pvp_Team_Main_Text_C_Name = {
    ID = "UI_Pvp_Team_Main_Text_C_Name",
    Content = "PanelText_UI_Pvp_Team_Main_Text_C_Name_Content|快速编队"
  },
  UI_Pvp_Popup_Victory_Text_C_Red = {
    ID = "UI_Pvp_Popup_Victory_Text_C_Red",
    Content = "PanelText_UI_Pvp_Popup_Victory_Text_C_Red_Content|点击继续"
  },
  UI_Pvp_Popup_Breaking_Text_C_Breaking = {
    ID = "UI_Pvp_Popup_Breaking_Text_C_Breaking",
    Content = "PanelText_UI_Pvp_Popup_Breaking_Text_C_Breaking_Content|与服务器链接已断开"
  },
  UI_Pvp_Popup_Breaking_Text_C_Quit = {
    ID = "UI_Pvp_Popup_Breaking_Text_C_Quit",
    Content = "PanelText_UI_Pvp_Popup_Breaking_Text_C_Quit_Content|回到登录界面"
  },
  UI_Awaker_Popup_Attribute_Detail_Text_C_Title = {
    ID = "UI_Awaker_Popup_Attribute_Detail_Text_C_Title",
    Content = "PanelText_UI_Awaker_Popup_Attribute_Detail_Text_C_Title_Content|属性详情"
  },
  UI_Pvp_Panel_Settlement_Text_C_Fail = {
    ID = "UI_Pvp_Panel_Settlement_Text_C_Fail",
    Content = "PanelText_UI_Pvp_Panel_Settlement_Text_C_Fail_Content|失败"
  },
  UI_Pvp_Panel_Settlement_Text_C_Victory = {
    ID = "UI_Pvp_Panel_Settlement_Text_C_Victory",
    Content = "PanelText_UI_Pvp_Panel_Settlement_Text_C_Victory_Content|胜利"
  },
  UI_Pvp_Panel_Settlement_Text_C_Harm = {
    ID = "UI_Pvp_Panel_Settlement_Text_C_Harm",
    Content = "PanelText_UI_Pvp_Panel_Settlement_Text_C_Harm_Content|伤害"
  },
  UI_Pvp_Panel_Settlement_Text_C_Treat = {
    ID = "UI_Pvp_Panel_Settlement_Text_C_Treat",
    Content = "PanelText_UI_Pvp_Panel_Settlement_Text_C_Treat_Content|治疗"
  },
  UI_Pvp_Panel_Settlement_Text_C_Shields = {
    ID = "UI_Pvp_Panel_Settlement_Text_C_Shields",
    Content = "PanelText_UI_Pvp_Panel_Settlement_Text_C_Shields_Content|护盾"
  },
  UI_Alchemy_Popup_ResolveWeapon_Text_C_WeaponNull = {
    ID = "UI_Alchemy_Popup_ResolveWeapon_Text_C_WeaponNull",
    Content = "PanelText_UI_Alchemy_Popup_ResolveWeapon_Text_C_WeaponNull_Content|尚无相关命轮"
  },
  UI_Alchemy_Popup_ResolveWeapon_Text_C_All = {
    ID = "UI_Alchemy_Popup_ResolveWeapon_Text_C_All",
    Content = "PanelText_UI_Alchemy_Popup_ResolveWeapon_Text_C_All_Content|全选"
  },
  UI_Alchemy_Popup_ResolveWeapon_Text_C_Cap = {
    ID = "UI_Alchemy_Popup_ResolveWeapon_Text_C_Cap",
    Content = "PanelText_UI_Alchemy_Popup_ResolveWeapon_Text_C_Cap_Content|已强化至当前等级上限"
  },
  UI_Alchemy_Popup_ResolveWeapon_Text_C_NormotopiaCap = {
    ID = "UI_Alchemy_Popup_ResolveWeapon_Text_C_NormotopiaCap",
    Content = "PanelText_UI_Alchemy_Popup_ResolveWeapon_Text_C_NormotopiaCap_Content|叠位已达上限"
  },
  UI_Alchemy_Popup_ResolveWeapon_Text_C_Resolve = {
    ID = "UI_Alchemy_Popup_ResolveWeapon_Text_C_Resolve",
    Content = "PanelText_UI_Alchemy_Popup_ResolveWeapon_Text_C_Resolve_Content|分解获得"
  },
  UI_Alchemy_Popup_ResolveWeapon_Text_C_Null = {
    ID = "UI_Alchemy_Popup_ResolveWeapon_Text_C_Null",
    Content = "PanelText_UI_Alchemy_Popup_ResolveWeapon_Text_C_Null_Content|请选择要分解的物品"
  },
  UI_Alchemy_Popup_ResolveWeapon_Text_C_Sel = {
    ID = "UI_Alchemy_Popup_ResolveWeapon_Text_C_Sel",
    Content = "PanelText_UI_Alchemy_Popup_ResolveWeapon_Text_C_Sel_Content|已选"
  },
  UI_Alchemy_Popup_ResolveWeapon_Text_C_AmountLine = {
    ID = "UI_Alchemy_Popup_ResolveWeapon_Text_C_AmountLine",
    Content = "PanelText_UI_Alchemy_Popup_ResolveWeapon_Text_C_AmountLine_Content|/"
  },
  UI_Alchemy_Popup_ResolveWeapon_Text_C_GoodsNum = {
    ID = "UI_Alchemy_Popup_ResolveWeapon_Text_C_GoodsNum",
    Content = "PanelText_UI_Alchemy_Popup_ResolveWeapon_Text_C_GoodsNum_Content|数量"
  },
  UI_Alchemy_Popup_ResolveWeapon_Text_C_GoodsNumLine = {
    ID = "UI_Alchemy_Popup_ResolveWeapon_Text_C_GoodsNumLine",
    Content = "PanelText_UI_Alchemy_Popup_ResolveWeapon_Text_C_GoodsNumLine_Content|/"
  },
  UI_Alchemy_Popup_ResolveMaterials_Text_C_MaterialsNull = {
    ID = "UI_Alchemy_Popup_ResolveMaterials_Text_C_MaterialsNull",
    Content = "PanelText_UI_Alchemy_Popup_ResolveMaterials_Text_C_MaterialsNull_Content|尚无相关密契"
  },
  UI_Alchemy_Popup_ResolveMaterials_Text_C_Cap = {
    ID = "UI_Alchemy_Popup_ResolveMaterials_Text_C_Cap",
    Content = "PanelText_UI_Alchemy_Popup_ResolveMaterials_Text_C_Cap_Content|已强化至当前等级上限"
  },
  UI_Alchemy_Popup_ResolveMaterials_Text_C_NormotopiaCap = {
    ID = "UI_Alchemy_Popup_ResolveMaterials_Text_C_NormotopiaCap",
    Content = "PanelText_UI_Alchemy_Popup_ResolveMaterials_Text_C_NormotopiaCap_Content|叠位已达上限"
  },
  UI_Alchemy_Popup_ResolveMaterials_Text_C_Resolve = {
    ID = "UI_Alchemy_Popup_ResolveMaterials_Text_C_Resolve",
    Content = "PanelText_UI_Alchemy_Popup_ResolveMaterials_Text_C_Resolve_Content|分解获得"
  },
  UI_Alchemy_Popup_ResolveMaterials_Text_C_All = {
    ID = "UI_Alchemy_Popup_ResolveMaterials_Text_C_All",
    Content = "PanelText_UI_Alchemy_Popup_ResolveMaterials_Text_C_All_Content|全选"
  },
  UI_Alchemy_Popup_ResolveMaterials_Text_C_Sel = {
    ID = "UI_Alchemy_Popup_ResolveMaterials_Text_C_Sel",
    Content = "PanelText_UI_Alchemy_Popup_ResolveMaterials_Text_C_Sel_Content|已选"
  },
  UI_Alchemy_Popup_ResolveMaterials_Text_C_AmountLine = {
    ID = "UI_Alchemy_Popup_ResolveMaterials_Text_C_AmountLine",
    Content = "PanelText_UI_Alchemy_Popup_ResolveMaterials_Text_C_AmountLine_Content|/"
  },
  UI_Alchemy_Popup_ResolveMaterials_Text_C_GoodsNum = {
    ID = "UI_Alchemy_Popup_ResolveMaterials_Text_C_GoodsNum",
    Content = "PanelText_UI_Alchemy_Popup_ResolveMaterials_Text_C_GoodsNum_Content|数量"
  },
  UI_Alchemy_Popup_ResolveMaterials_Text_C_GoodsNumLine = {
    ID = "UI_Alchemy_Popup_ResolveMaterials_Text_C_GoodsNumLine",
    Content = "PanelText_UI_Alchemy_Popup_ResolveMaterials_Text_C_GoodsNumLine_Content|/"
  },
  UI_Alchemy_Popup_ResolveMaterials_Text_C_Null = {
    ID = "UI_Alchemy_Popup_ResolveMaterials_Text_C_Null",
    Content = "PanelText_UI_Alchemy_Popup_ResolveMaterials_Text_C_Null_Content|请选择要分解的物品"
  },
  UI_Bag_Panel_Main_Text_C_Cap = {
    ID = "UI_Bag_Panel_Main_Text_C_Cap",
    Content = "PanelText_UI_Bag_Panel_Main_Text_C_Cap_Content|已强化至当前等级上限"
  },
  UI_Bag_Panel_Main_Text_C_NormotopiaCap = {
    ID = "UI_Bag_Panel_Main_Text_C_NormotopiaCap",
    Content = "PanelText_UI_Bag_Panel_Main_Text_C_NormotopiaCap_Content|叠位已达上限"
  },
  UI_Bag_Panel_Main_Text_C_Synthesis = {
    ID = "UI_Bag_Panel_Main_Text_C_Synthesis",
    Content = "PanelText_UI_Bag_Panel_Main_Text_C_Synthesis_Content|合成"
  },
  UI_Bag_Panel_Main_Text_C_Replacement = {
    ID = "UI_Bag_Panel_Main_Text_C_Replacement",
    Content = "PanelText_UI_Bag_Panel_Main_Text_C_Replacement_Content|置换"
  },
  UI_Bag_Panel_Main_Text_C_recast = {
    ID = "UI_Bag_Panel_Main_Text_C_recast",
    Content = "PanelText_UI_Bag_Panel_Main_Text_C_recast_Content|重铸"
  },
  UI_Bag_Panel_Main_Text_C_Resolve = {
    ID = "UI_Bag_Panel_Main_Text_C_Resolve",
    Content = "PanelText_UI_Bag_Panel_Main_Text_C_Resolve_Content|分解"
  },
  UI_Bag_Panel_Main_Text_C_2_Select = {
    ID = "UI_Bag_Panel_Main_Text_C_2_Select",
    Content = "PanelText_UI_Bag_Panel_Main_Text_C_2_Select_Content|顺序"
  },
  UI_Awaker_Panel_Weapon_Main_Text_Empty = {
    ID = "UI_Awaker_Panel_Weapon_Main_Text_Empty",
    Content = "PanelText_UI_Awaker_Panel_Weapon_Main_Text_Empty_Content|左侧选择命轮装备"
  },
  UI_Awaker_Panel_Weapon_Main_Text_Unlock = {
    ID = "UI_Awaker_Panel_Weapon_Main_Text_Unlock",
    Content = "PanelText_UI_Awaker_Panel_Weapon_Main_Text_Unlock_Content|升格唤醒体\n解锁第二命轮"
  },
  UI_Awaker_Item_Skill_Training_Text_C_Insufficient = {
    ID = "UI_Awaker_Item_Skill_Training_Text_C_Insufficient",
    Content = "PanelText_UI_Awaker_Item_Skill_Training_Text_C_Insufficient_Content|唤醒体升格等级不足"
  },
  UI_Summon_Panel_Main_Text_C_Realms = {
    ID = "UI_Summon_Panel_Main_Text_C_Realms",
    Content = "PanelText_UI_Summon_Panel_Main_Text_C_Realms_Content|选定界域"
  },
  UI_Summon_Panel_Main_Text_Recommend = {
    ID = "UI_Summon_Panel_Main_Text_Recommend",
    Content = "PanelText_UI_Summon_Panel_Main_Text_Recommend_Content|新生推荐唤醒"
  },
  UI_Summon_Panel_Main_Text_Desc_2 = {
    ID = "UI_Summon_Panel_Main_Text_Desc_2",
    Content = "PanelText_UI_Summon_Panel_Main_Text_Desc_2_Content|描述"
  },
  UI_Bag_Panel_Main_Text_Title = {
    ID = "UI_Bag_Panel_Main_Text_Title",
    Content = "PanelText_UI_Bag_Panel_Main_Text_Title_Content|物资"
  },
  UI_Weapon_Item_Select_List_Text_No_Weapon2 = {
    ID = "UI_Weapon_Item_Select_List_Text_No_Weapon2",
    Content = "PanelText_UI_Weapon_Item_Select_List_Text_No_Weapon2_Content|无可装备命轮"
  },
  UI_Awaker_Panel_Weapon_Main_Text_Empty1 = {
    ID = "UI_Awaker_Panel_Weapon_Main_Text_Empty1",
    Content = "PanelText_UI_Awaker_Panel_Weapon_Main_Text_Empty1_Content|左侧选择命轮装备"
  },
  UI_Awaker_Popup_Trinket_Main3_Text_C_Empty_1 = {
    ID = "UI_Awaker_Popup_Trinket_Main3_Text_C_Empty_1",
    Content = "PanelText_UI_Awaker_Popup_Trinket_Main3_Text_C_Empty_1_Content|请选择密契装备"
  },
  UI_Awaker_Popup_Trinket_Main3_Text_C_Foundation = {
    ID = "UI_Awaker_Popup_Trinket_Main3_Text_C_Foundation",
    Content = "PanelText_UI_Awaker_Popup_Trinket_Main3_Text_C_Foundation_Content|属性"
  },
  UI_Awaker_Popup_Trinket_Main3_Text_C_Empty_2 = {
    ID = "UI_Awaker_Popup_Trinket_Main3_Text_C_Empty_2",
    Content = "PanelText_UI_Awaker_Popup_Trinket_Main3_Text_C_Empty_2_Content|暂无生效的套装效果"
  },
  UI_Awaker_Popup_Trinket_Main3_Text_C_Suit = {
    ID = "UI_Awaker_Popup_Trinket_Main3_Text_C_Suit",
    Content = "PanelText_UI_Awaker_Popup_Trinket_Main3_Text_C_Suit_Content|套装效果"
  },
  UI_Awaker_Popup_Trinket_Replace_Text_C_1_Normal = {
    ID = "UI_Awaker_Popup_Trinket_Replace_Text_C_1_Normal",
    Content = "PanelText_UI_Awaker_Popup_Trinket_Replace_Text_C_1_Normal_Content|Ⅰ"
  },
  UI_Awaker_Popup_Trinket_Replace_Text_C_1_Select = {
    ID = "UI_Awaker_Popup_Trinket_Replace_Text_C_1_Select",
    Content = "PanelText_UI_Awaker_Popup_Trinket_Replace_Text_C_1_Select_Content|Ⅰ"
  },
  UI_Awaker_Popup_Trinket_Replace_Text_C_2_Normal = {
    ID = "UI_Awaker_Popup_Trinket_Replace_Text_C_2_Normal",
    Content = "PanelText_UI_Awaker_Popup_Trinket_Replace_Text_C_2_Normal_Content|Ⅱ"
  },
  UI_Awaker_Popup_Trinket_Replace_Text_C_2_Select = {
    ID = "UI_Awaker_Popup_Trinket_Replace_Text_C_2_Select",
    Content = "PanelText_UI_Awaker_Popup_Trinket_Replace_Text_C_2_Select_Content|Ⅱ"
  },
  UI_Awaker_Popup_Trinket_Replace_Text_C_3_Normal = {
    ID = "UI_Awaker_Popup_Trinket_Replace_Text_C_3_Normal",
    Content = "PanelText_UI_Awaker_Popup_Trinket_Replace_Text_C_3_Normal_Content|Ⅲ"
  },
  UI_Awaker_Popup_Trinket_Replace_Text_C_3_Select = {
    ID = "UI_Awaker_Popup_Trinket_Replace_Text_C_3_Select",
    Content = "PanelText_UI_Awaker_Popup_Trinket_Replace_Text_C_3_Select_Content|Ⅲ"
  },
  UI_Awaker_Popup_Trinket_Replace_Text_C_4_Normal = {
    ID = "UI_Awaker_Popup_Trinket_Replace_Text_C_4_Normal",
    Content = "PanelText_UI_Awaker_Popup_Trinket_Replace_Text_C_4_Normal_Content|Ⅳ"
  },
  UI_Awaker_Popup_Trinket_Replace_Text_C_4_Select = {
    ID = "UI_Awaker_Popup_Trinket_Replace_Text_C_4_Select",
    Content = "PanelText_UI_Awaker_Popup_Trinket_Replace_Text_C_4_Select_Content|Ⅳ"
  },
  UI_Awaker_Popup_Trinket_Replace_Text_C_5_Normal = {
    ID = "UI_Awaker_Popup_Trinket_Replace_Text_C_5_Normal",
    Content = "PanelText_UI_Awaker_Popup_Trinket_Replace_Text_C_5_Normal_Content|Ⅴ"
  },
  UI_Awaker_Popup_Trinket_Replace_Text_C_5_Select = {
    ID = "UI_Awaker_Popup_Trinket_Replace_Text_C_5_Select",
    Content = "PanelText_UI_Awaker_Popup_Trinket_Replace_Text_C_5_Select_Content|Ⅴ"
  },
  UI_Awaker_Popup_Trinket_Replace_Text_C_6_Normal = {
    ID = "UI_Awaker_Popup_Trinket_Replace_Text_C_6_Normal",
    Content = "PanelText_UI_Awaker_Popup_Trinket_Replace_Text_C_6_Normal_Content|Ⅵ"
  },
  UI_Awaker_Popup_Trinket_Replace_Text_C_6_Select = {
    ID = "UI_Awaker_Popup_Trinket_Replace_Text_C_6_Select",
    Content = "PanelText_UI_Awaker_Popup_Trinket_Replace_Text_C_6_Select_Content|Ⅵ"
  },
  UI_Awaker_Popup_Trinket_Replace_Text_C_None = {
    ID = "UI_Awaker_Popup_Trinket_Replace_Text_C_None",
    Content = "PanelText_UI_Awaker_Popup_Trinket_Replace_Text_C_None_Content|当前部位无可用密契"
  },
  UI_Awaker_Popup_Trinket_Replace_Text_C_Notselected = {
    ID = "UI_Awaker_Popup_Trinket_Replace_Text_C_Notselected",
    Content = "PanelText_UI_Awaker_Popup_Trinket_Replace_Text_C_Notselected_Content|请选择密契装备"
  },
  UI_Awaker_Popup_Trinket_Replace_Text_C_Contrast = {
    ID = "UI_Awaker_Popup_Trinket_Replace_Text_C_Contrast",
    Content = "PanelText_UI_Awaker_Popup_Trinket_Replace_Text_C_Contrast_Content|对比"
  },
  UI_Awaker_Popup_Trinket_Replace_Text_C_Suit = {
    ID = "UI_Awaker_Popup_Trinket_Replace_Text_C_Suit",
    Content = "PanelText_UI_Awaker_Popup_Trinket_Replace_Text_C_Suit_Content|套装效果"
  },
  UI_Michi_Popup_Strengthen_Succeed_Text_C_Info = {
    ID = "UI_Michi_Popup_Strengthen_Succeed_Text_C_Info",
    Content = "PanelText_UI_Michi_Popup_Strengthen_Succeed_Text_C_Info_Content|点击空白处关闭"
  },
  UI_Battle_Popup_Record_Tip_New_Text_C_Property = {
    ID = "UI_Battle_Popup_Record_Tip_New_Text_C_Property",
    Content = "PanelText_UI_Battle_Popup_Record_Tip_New_Text_C_Property_Content|属性详情"
  },
  UI_Battle_Popup_Record_Tip_New_Text_C_Gnosisi = {
    ID = "UI_Battle_Popup_Record_Tip_New_Text_C_Gnosisi",
    Content = "PanelText_UI_Battle_Popup_Record_Tip_New_Text_C_Gnosisi_Content|灵知觉醒"
  },
  UI_Battle_Popup_Record_Tip_New_Text_C_Destiny = {
    ID = "UI_Battle_Popup_Record_Tip_New_Text_C_Destiny",
    Content = "PanelText_UI_Battle_Popup_Record_Tip_New_Text_C_Destiny_Content|命轮"
  },
  UI_Battle_Popup_Record_Tip_New_Text_C_Secret = {
    ID = "UI_Battle_Popup_Record_Tip_New_Text_C_Secret",
    Content = "PanelText_UI_Battle_Popup_Record_Tip_New_Text_C_Secret_Content|密契"
  },
  UI_Battle_Popup_Record_Tip_New_Text_C_AffixInfo = {
    ID = "UI_Battle_Popup_Record_Tip_New_Text_C_AffixInfo",
    Content = "PanelText_UI_Battle_Popup_Record_Tip_New_Text_C_AffixInfo_Content|词缀说明"
  },
  UI_Common_Btn_Share_Text_C_Across = {
    ID = "UI_Common_Btn_Share_Text_C_Across",
    Content = "PanelText_UI_Common_Btn_Share_Text_C_Across_Content|首次分享得"
  },
  Panel_Battle_Monster_Information_Text_C_Monster = {
    ID = "Panel_Battle_Monster_Information_Text_C_Monster",
    Content = "PanelText_Panel_Battle_Monster_Information_Text_C_Monster_Content|怪物意图"
  },
  Panel_Battle_Monster_Information_Text_C_Story = {
    ID = "Panel_Battle_Monster_Information_Text_C_Story",
    Content = "PanelText_Panel_Battle_Monster_Information_Text_C_Story_Content|怪物故事"
  },
  UI_Recharge_Panel_Main_Text_C_Flushed = {
    ID = "UI_Recharge_Panel_Main_Text_C_Flushed",
    Content = "PanelText_UI_Recharge_Panel_Main_Text_C_Flushed_Content|刷新"
  },
  UI_Recharge_Panel_Main_Text_C_Cost_Tips = {
    ID = "UI_Recharge_Panel_Main_Text_C_Cost_Tips",
    Content = "PanelText_UI_Recharge_Panel_Main_Text_C_Cost_Tips_Content|消耗"
  },
  UI_Research_Panel_Dispatch_Item_Text_C_Unclickable = {
    ID = "UI_Research_Panel_Dispatch_Item_Text_C_Unclickable",
    Content = "PanelText_UI_Research_Panel_Dispatch_Item_Text_C_Unclickable_Content|未解锁"
  },
  UI_Research_Panel_Dispatch_Content_Text_C_Special = {
    ID = "UI_Research_Panel_Dispatch_Content_Text_C_Special",
    Content = "PanelText_UI_Research_Panel_Dispatch_Content_Text_C_Special_Content|达成条件"
  },
  UI_Research_Panel_Dispatch_Content_Text_C_Extra = {
    ID = "UI_Research_Panel_Dispatch_Content_Text_C_Extra",
    Content = "PanelText_UI_Research_Panel_Dispatch_Content_Text_C_Extra_Content|【额外】"
  },
  UI_Research_Panel_Dispatch_Content_Text_C_NoTask = {
    ID = "UI_Research_Panel_Dispatch_Content_Text_C_NoTask",
    Content = "PanelText_UI_Research_Panel_Dispatch_Content_Text_C_NoTask_Content|暂时没有新的派遣任务"
  },
  UI_Research_Panel_Dispatch_Content_Text_C_Special2 = {
    ID = "UI_Research_Panel_Dispatch_Content_Text_C_Special2",
    Content = "PanelText_UI_Research_Panel_Dispatch_Content_Text_C_Special2_Content|派遣总等级每超出20级，可获得1份额外奖励"
  },
  UI_Research_Panel_Dispatch_Content_Text_C_Count = {
    ID = "UI_Research_Panel_Dispatch_Content_Text_C_Count",
    Content = "PanelText_UI_Research_Panel_Dispatch_Content_Text_C_Count_Content|规则说明"
  },
  UI_Research_Panel_Dispatch_Content_Text_C_Award = {
    ID = "UI_Research_Panel_Dispatch_Content_Text_C_Award",
    Content = "PanelText_UI_Research_Panel_Dispatch_Content_Text_C_Award_Content|任务报酬"
  },
  UI_Research_Popup_Recall_Text_C_Special2 = {
    ID = "UI_Research_Popup_Recall_Text_C_Special2",
    Content = "PanelText_UI_Research_Popup_Recall_Text_C_Special2_Content|派遣总等级每超出20级，可获得1份额外奖励"
  },
  UI_Awaker_Popup_MyTeam_List_Text_C_William = {
    ID = "UI_Awaker_Popup_MyTeam_List_Text_C_William",
    Content = "PanelText_UI_Awaker_Popup_MyTeam_List_Text_C_William_Content|暂无升级材料"
  },
  UI_Common_Popup_Card_List_Text_C_DrawCard = {
    ID = "UI_Common_Popup_Card_List_Text_C_DrawCard",
    Content = "PanelText_UI_Common_Popup_Card_List_Text_C_DrawCard_Content|抽牌堆"
  },
  UI_Common_Popup_Card_List_Text_C_AbandonCard = {
    ID = "UI_Common_Popup_Card_List_Text_C_AbandonCard",
    Content = "PanelText_UI_Common_Popup_Card_List_Text_C_AbandonCard_Content|弃牌堆"
  },
  UI_Awaker_Item_Trinket_Detail_Text_C_Empty = {
    ID = "UI_Awaker_Item_Trinket_Detail_Text_C_Empty",
    Content = "PanelText_UI_Awaker_Item_Trinket_Detail_Text_C_Empty_Content|请选择密契装备"
  },
  UI_Awaker_Popup_Trinket_Replace_Text_C_Empty = {
    ID = "UI_Awaker_Popup_Trinket_Replace_Text_C_Empty",
    Content = "PanelText_UI_Awaker_Popup_Trinket_Replace_Text_C_Empty_Content|请选择密契装备"
  },
  UI_Awaker_Popup_Trinket_Conversion_Text_C_illustrate = {
    ID = "UI_Awaker_Popup_Trinket_Conversion_Text_C_illustrate",
    Content = "PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_illustrate_Content|转录说明"
  },
  UI_Guide_ChangeName_Text_C_Myself = {
    ID = "UI_Guide_ChangeName_Text_C_Myself",
    Content = "PanelText_UI_Guide_ChangeName_Text_C_Myself_Content|您的名字"
  },
  UI_Guide_ChangeName_Text_C_Tips = {
    ID = "UI_Guide_ChangeName_Text_C_Tips",
    Content = "PanelText_UI_Guide_ChangeName_Text_C_Tips_Content|请输入您的名字"
  },
  UI_Battle_Popup_Keeper_Skill_Tip_Text_C_Skill_Tag = {
    ID = "UI_Battle_Popup_Keeper_Skill_Tip_Text_C_Skill_Tag",
    Content = "PanelText_UI_Battle_Popup_Keeper_Skill_Tip_Text_C_Skill_Tag_Content|钥令"
  },
  UI_Battle_Popup_Keeper_Skill_Tip_Text_C_Property = {
    ID = "UI_Battle_Popup_Keeper_Skill_Tip_Text_C_Property",
    Content = "PanelText_UI_Battle_Popup_Keeper_Skill_Tip_Text_C_Property_Content|应急物资"
  },
  UI_Awaker_Item_Potency_Detail_Text_C_Current = {
    ID = "UI_Awaker_Item_Potency_Detail_Text_C_Current",
    Content = "PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Current_Content|当前"
  },
  UI_Awaker_Item_Potency_Detail_Text_C_Lower = {
    ID = "UI_Awaker_Item_Potency_Detail_Text_C_Lower",
    Content = "PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Lower_Content|下一级"
  },
  UI_Dungeons_Panel_Realms_Text_C_NotUnlocked_1 = {
    ID = "UI_Dungeons_Panel_Realms_Text_C_NotUnlocked_1",
    Content = "PanelText_UI_Dungeons_Panel_Realms_Text_C_NotUnlocked_1_Content|未解锁"
  },
  UI_Dungeons_Panel_Realms_Text_C_NotUnlocked_2 = {
    ID = "UI_Dungeons_Panel_Realms_Text_C_NotUnlocked_2",
    Content = "PanelText_UI_Dungeons_Panel_Realms_Text_C_NotUnlocked_2_Content|未解锁"
  },
  UI_Dungeons_Panel_Realms_Text_C_NotUnlocked_3 = {
    ID = "UI_Dungeons_Panel_Realms_Text_C_NotUnlocked_3",
    Content = "PanelText_UI_Dungeons_Panel_Realms_Text_C_NotUnlocked_3_Content|未解锁"
  },
  UI_Dungeons_Panel_Realms_Text_C_NotUnlocked_4 = {
    ID = "UI_Dungeons_Panel_Realms_Text_C_NotUnlocked_4",
    Content = "PanelText_UI_Dungeons_Panel_Realms_Text_C_NotUnlocked_4_Content|未解锁"
  },
  UI_Dungeous_Panel_Realms_Text_C_Progressline2 = {
    ID = "UI_Dungeous_Panel_Realms_Text_C_Progressline2",
    Content = "PanelText_UI_Dungeous_Panel_Realms_Text_C_Progressline2_Content|/"
  },
  UI_Awaker_Item_Potency_Detail_Text_C_Lv = {
    ID = "UI_Awaker_Item_Potency_Detail_Text_C_Lv",
    Content = "PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Lv_Content|Lv."
  },
  UI_Battle_Popup_Record_Tip_New_Text_C_Maniac = {
    ID = "UI_Battle_Popup_Record_Tip_New_Text_C_Maniac",
    Content = "PanelText_UI_Battle_Popup_Record_Tip_New_Text_C_Maniac_Content|狂气值"
  },
  UI_Battle_Popup_Keeper_Skill_Tip_Text_C_Skill2 = {
    ID = "UI_Battle_Popup_Keeper_Skill_Tip_Text_C_Skill2",
    Content = "PanelText_UI_Battle_Popup_Keeper_Skill_Tip_Text_C_Skill2_Content|银钥能量"
  },
  UI_Awaker_Item_Potency_Detail_Text_C_Originally_Lv = {
    ID = "UI_Awaker_Item_Potency_Detail_Text_C_Originally_Lv",
    Content = "PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Originally_Lv_Content|Lv."
  },
  UI_Awaker_Item_Weapon_Refining_Text_C_Full = {
    ID = "UI_Awaker_Item_Weapon_Refining_Text_C_Full",
    Content = "PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Full_Content|满级"
  },
  UI_Awaker_Item_Weapon_Refining_Text_C_Expend = {
    ID = "UI_Awaker_Item_Weapon_Refining_Text_C_Expend",
    Content = "PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Expend_Content|消耗材料"
  },
  UI_Awaker_Item_Weapon_Refining_Text_C_Fast = {
    ID = "UI_Awaker_Item_Weapon_Refining_Text_C_Fast",
    Content = "PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Fast_Content|快速放入"
  },
  UI_Dbgcopy_Item_Target_Title_Text_C_Star = {
    ID = "UI_Dbgcopy_Item_Target_Title_Text_C_Star",
    Content = "PanelText_UI_Dbgcopy_Item_Target_Title_Text_C_Star_Content|星级评分"
  },
  UI_Dbgcopy_Item_Target_Title_Text_C_Achievement = {
    ID = "UI_Dbgcopy_Item_Target_Title_Text_C_Achievement",
    Content = "PanelText_UI_Dbgcopy_Item_Target_Title_Text_C_Achievement_Content|关卡成就"
  },
  UI_Awaker_Item_Weapon_Refining_Text_C_Name_1 = {
    ID = "UI_Awaker_Item_Weapon_Refining_Text_C_Name_1",
    Content = "PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Name_1_Content|当前"
  },
  UI_Awaker_Item_Weapon_Refining_Text_C_Name_2 = {
    ID = "UI_Awaker_Item_Weapon_Refining_Text_C_Name_2",
    Content = "PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Name_2_Content|当前"
  },
  UI_Awaker_Item_Weapon_Refining_Text_C_Name_3 = {
    ID = "UI_Awaker_Item_Weapon_Refining_Text_C_Name_3",
    Content = "PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Name_3_Content|叠位后"
  },
  UI_Awaker_Item_Weapon_Refining_Text_C_Name_4 = {
    ID = "UI_Awaker_Item_Weapon_Refining_Text_C_Name_4",
    Content = "PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Name_4_Content|叠位后"
  },
  UI_Team_Popup_Awaker_List_Text_C_Level = {
    ID = "UI_Team_Popup_Awaker_List_Text_C_Level",
    Content = "PanelText_UI_Team_Popup_Awaker_List_Text_C_Level_Content|Lv."
  },
  UI_Team_Popup_Awaker_List_Text_C_Attribute = {
    ID = "UI_Team_Popup_Awaker_List_Text_C_Attribute",
    Content = "PanelText_UI_Team_Popup_Awaker_List_Text_C_Attribute_Content|属性"
  },
  UI_Team_Popup_Awaker_List_Text_C_Xx = {
    ID = "UI_Team_Popup_Awaker_List_Text_C_Xx",
    Content = "PanelText_UI_Team_Popup_Awaker_List_Text_C_Xx_Content|详细信息"
  },
  UI_Team_Popup_Awaker_List_Text_C_Name = {
    ID = "UI_Team_Popup_Awaker_List_Text_C_Name",
    Content = "PanelText_UI_Team_Popup_Awaker_List_Text_C_Name_Content|唤醒体详情"
  },
  ["GmPanel_Text_C_Battle_Test (1)"] = {
    ID = "GmPanel_Text_C_Battle_Test (1)",
    Content = "PanelText_GmPanel_Text_C_Battle_Test (1)_Content|战斗2.0"
  },
  GmPanel_Text_C_Battle_Test = {
    ID = "GmPanel_Text_C_Battle_Test",
    Content = "PanelText_GmPanel_Text_C_Battle_Test_Content|PvP匹配"
  },
  UI_Pvp_Popup_Fail_Text_C_Fail = {
    ID = "UI_Pvp_Popup_Fail_Text_C_Fail",
    Content = "PanelText_UI_Pvp_Popup_Fail_Text_C_Fail_Content|失败"
  },
  UI_Pvp_Popup_Fail_Text_C_Failure = {
    ID = "UI_Pvp_Popup_Fail_Text_C_Failure",
    Content = "PanelText_UI_Pvp_Popup_Fail_Text_C_Failure_Content|Failure"
  },
  UI_Pvp_Popup_Fail_Text_C_Victory = {
    ID = "UI_Pvp_Popup_Fail_Text_C_Victory",
    Content = "PanelText_UI_Pvp_Popup_Fail_Text_C_Victory_Content|战斗失败"
  },
  UI_Pvp_Popup_Fail_Text_C_Continue = {
    ID = "UI_Pvp_Popup_Fail_Text_C_Continue",
    Content = "PanelText_UI_Pvp_Popup_Fail_Text_C_Continue_Content|点击继续"
  },
  UI_Pvp_Popup_Fail_Text_Quantity_1 = {
    ID = "UI_Pvp_Popup_Fail_Text_Quantity_1",
    Content = "PanelText_UI_Pvp_Popup_Fail_Text_Quantity_1_Content|10"
  },
  UI_Pvp_Popup_Fail_Text_Reward_1 = {
    ID = "UI_Pvp_Popup_Fail_Text_Reward_1",
    Content = "PanelText_UI_Pvp_Popup_Fail_Text_Reward_1_Content|战斗风格奖励"
  },
  UI_Dungeous_Popup_Swept_Tip2_Text_C_Tips = {
    ID = "UI_Dungeous_Popup_Swept_Tip2_Text_C_Tips",
    Content = "PanelText_UI_Dungeous_Popup_Swept_Tip2_Text_C_Tips_Content|调查评价达到三星后解锁"
  },
  UI_Dungeous_Popup_Swept_Tip2_Text_C_Explain = {
    ID = "UI_Dungeous_Popup_Swept_Tip2_Text_C_Explain",
    Content = "PanelText_UI_Dungeous_Popup_Swept_Tip2_Text_C_Explain_Content|规则说明"
  },
  UI_Dungeous_Popup_Swept_Tip2_Text_C_Text = {
    ID = "UI_Dungeous_Popup_Swept_Tip2_Text_C_Text",
    Content = "PanelText_UI_Dungeous_Popup_Swept_Tip2_Text_C_Text_Content|需要"
  },
  UI_Dungeous_Popup_Swept_Tip2_Text_Title = {
    ID = "UI_Dungeous_Popup_Swept_Tip2_Text_Title",
    Content = "PanelText_UI_Dungeous_Popup_Swept_Tip2_Text_Title_Content|重现确认"
  },
  UI_Dungeous_Popup_Swept_Tip2_Text_C_Swept = {
    ID = "UI_Dungeous_Popup_Swept_Tip2_Text_C_Swept",
    Content = "PanelText_UI_Dungeous_Popup_Swept_Tip2_Text_C_Swept_Content|重现次数"
  },
  UI_Dungeous_Panel_SecEntrance_Text_C_AwardNum = {
    ID = "UI_Dungeous_Panel_SecEntrance_Text_C_AwardNum",
    Content = "PanelText_UI_Dungeous_Panel_SecEntrance_Text_C_AwardNum_Content|今日双倍奖励次数"
  },
  UI_Dungeous_Panel_SecEntrance_Text_C_TextLine = {
    ID = "UI_Dungeous_Panel_SecEntrance_Text_C_TextLine",
    Content = "PanelText_UI_Dungeous_Panel_SecEntrance_Text_C_TextLine_Content|/"
  },
  UI_Bag_Panel_Main_Text_AmountName = {
    ID = "UI_Bag_Panel_Main_Text_AmountName",
    Content = "PanelText_UI_Bag_Panel_Main_Text_AmountName_Content|数量"
  },
  UI_Bag_Panel_Main_Text_AmountLine = {
    ID = "UI_Bag_Panel_Main_Text_AmountLine",
    Content = "PanelText_UI_Bag_Panel_Main_Text_AmountLine_Content|/"
  },
  UI_Pvp_Item_Dan_Text_C_Current = {
    ID = "UI_Pvp_Item_Dan_Text_C_Current",
    Content = "PanelText_UI_Pvp_Item_Dan_Text_C_Current_Content|当前段位"
  },
  UI_Pvp_Item_Formation_Text_C_Conflict = {
    ID = "UI_Pvp_Item_Formation_Text_C_Conflict",
    Content = "PanelText_UI_Pvp_Item_Formation_Text_C_Conflict_Content|定位冲突"
  },
  UI_Pvp_Item_List_Text_C_Uid_Title = {
    ID = "UI_Pvp_Item_List_Text_C_Uid_Title",
    Content = "PanelText_UI_Pvp_Item_List_Text_C_Uid_Title_Content|UID :"
  },
  UI_Pvp_Panel_Detail_Text_C_Role_Wins = {
    ID = "UI_Pvp_Panel_Detail_Text_C_Role_Wins",
    Content = "PanelText_UI_Pvp_Panel_Detail_Text_C_Role_Wins_Content|胜场"
  },
  UI_Pvp_Panel_Detail_Text_C_Maniac = {
    ID = "UI_Pvp_Panel_Detail_Text_C_Maniac",
    Content = "PanelText_UI_Pvp_Panel_Detail_Text_C_Maniac_Content|狂气"
  },
  UI_Pvp_Panel_Detail_Text_C_Decks = {
    ID = "UI_Pvp_Panel_Detail_Text_C_Decks",
    Content = "PanelText_UI_Pvp_Panel_Detail_Text_C_Decks_Content|牌组"
  },
  UI_Pvp_Panel_Detail_Text_C_Wins = {
    ID = "UI_Pvp_Panel_Detail_Text_C_Wins",
    Content = "PanelText_UI_Pvp_Panel_Detail_Text_C_Wins_Content|胜场"
  },
  UI_Pvp_Panel_Detail_Text_C_Effect = {
    ID = "UI_Pvp_Panel_Detail_Text_C_Effect",
    Content = "PanelText_UI_Pvp_Panel_Detail_Text_C_Effect_Content|效果"
  },
  UI_Pvp_Panel_Formation_Text_C_Empty = {
    ID = "UI_Pvp_Panel_Formation_Text_C_Empty",
    Content = "PanelText_UI_Pvp_Panel_Formation_Text_C_Empty_Content|请从左侧选择上场"
  },
  UI_Pvp_Panel_lineup_Show_Text_C_VS = {
    ID = "UI_Pvp_Panel_lineup_Show_Text_C_VS",
    Content = "PanelText_UI_Pvp_Panel_lineup_Show_Text_C_VS_Content|VS"
  },
  UI_Pvp_Panel_Match_Text_C_Second = {
    ID = "UI_Pvp_Panel_Match_Text_C_Second",
    Content = "PanelText_UI_Pvp_Panel_Match_Text_C_Second_Content|秒"
  },
  UI_Pvp_Panel_Match_Text_Name = {
    ID = "UI_Pvp_Panel_Match_Text_Name",
    Content = "PanelText_UI_Pvp_Panel_Match_Text_Name_Content|开始匹配"
  },
  UI_Pvp_Popup_Dan_Text_C_Bonus = {
    ID = "UI_Pvp_Popup_Dan_Text_C_Bonus",
    Content = "PanelText_UI_Pvp_Popup_Dan_Text_C_Bonus_Content|赛季加成"
  },
  UI_Pvp_Popup_Dan_Text_C_Streak = {
    ID = "UI_Pvp_Popup_Dan_Text_C_Streak",
    Content = "PanelText_UI_Pvp_Popup_Dan_Text_C_Streak_Content|连胜加成"
  },
  UI_Pvp_Popup_Dan_Text_C_Continue = {
    ID = "UI_Pvp_Popup_Dan_Text_C_Continue",
    Content = "PanelText_UI_Pvp_Popup_Dan_Text_C_Continue_Content|点击继续"
  },
  UI_Pvp_Popup_Enlightenment_Adjust_Text_C_Title = {
    ID = "UI_Pvp_Popup_Enlightenment_Adjust_Text_C_Title",
    Content = "PanelText_UI_Pvp_Popup_Enlightenment_Adjust_Text_C_Title_Content|启灵"
  },
  UI_Pvp_Popup_Enlightenment_Adjust_Text_C_Use = {
    ID = "UI_Pvp_Popup_Enlightenment_Adjust_Text_C_Use",
    Content = "PanelText_UI_Pvp_Popup_Enlightenment_Adjust_Text_C_Use_Content|当前使用中"
  },
  UI_Pvp_Popup_Enlightenment_Tips_Text_C_Title = {
    ID = "UI_Pvp_Popup_Enlightenment_Tips_Text_C_Title",
    Content = "PanelText_UI_Pvp_Popup_Enlightenment_Tips_Text_C_Title_Content|启灵"
  },
  UI_Pvp_Popup_Fail_Text_C_Close = {
    ID = "UI_Pvp_Popup_Fail_Text_C_Close",
    Content = "PanelText_UI_Pvp_Popup_Fail_Text_C_Close_Content|点击空白处继续"
  },
  UI_Pvp_Popup_list_Tips_Text_C_Title = {
    ID = "UI_Pvp_Popup_list_Tips_Text_C_Title",
    Content = "PanelText_UI_Pvp_Popup_list_Tips_Text_C_Title_Content|排行榜"
  },
  UI_Pvp_Popup_list_Tips_Text_C_Uid_Title = {
    ID = "UI_Pvp_Popup_list_Tips_Text_C_Uid_Title",
    Content = "PanelText_UI_Pvp_Popup_list_Tips_Text_C_Uid_Title_Content|UID :"
  },
  UI_Pvp_Popup_Reward_Tips_Text_C_Title = {
    ID = "UI_Pvp_Popup_Reward_Tips_Text_C_Title",
    Content = "PanelText_UI_Pvp_Popup_Reward_Tips_Text_C_Title_Content|段位奖励"
  },
  UI_Pvp_Popup_Settle_Text_C_Close = {
    ID = "UI_Pvp_Popup_Settle_Text_C_Close",
    Content = "PanelText_UI_Pvp_Popup_Settle_Text_C_Close_Content|点击空白处继续"
  },
  UI_Pvp_Popup_Settle_Text_C_Pendants = {
    ID = "UI_Pvp_Popup_Settle_Text_C_Pendants",
    Content = "PanelText_UI_Pvp_Popup_Settle_Text_C_Pendants_Content|Victory"
  },
  UI_Pvp_Popup_Settle_Text_C_Succeed = {
    ID = "UI_Pvp_Popup_Settle_Text_C_Succeed",
    Content = "PanelText_UI_Pvp_Popup_Settle_Text_C_Succeed_Content|战斗胜利"
  },
  UI_Dungeous_Panel_BossSel1_Text_C_AwardNum = {
    ID = "UI_Dungeous_Panel_BossSel1_Text_C_AwardNum",
    Content = "PanelText_UI_Dungeous_Panel_BossSel1_Text_C_AwardNum_Content|今日双倍奖励次数"
  },
  UI_Dungeous_Panel_BossSel1_Text_C_TextLine = {
    ID = "UI_Dungeous_Panel_BossSel1_Text_C_TextLine",
    Content = "PanelText_UI_Dungeous_Panel_BossSel1_Text_C_TextLine_Content|/"
  },
  UI_Events_Panel_Spur_Text_C_Title = {
    ID = "UI_Events_Panel_Spur_Text_C_Title",
    Content = "PanelText_UI_Events_Panel_Spur_Text_C_Title_Content|完成该唤醒体试用后可获得奖励"
  },
  UI_Events_Panel_Spur_Text_C_Over = {
    ID = "UI_Events_Panel_Spur_Text_C_Over",
    Content = "PanelText_UI_Events_Panel_Spur_Text_C_Over_Content|所有奖励条件已达成"
  },
  UI_Events_Panel_Spur_Text_C_Pass = {
    ID = "UI_Events_Panel_Spur_Text_C_Pass",
    Content = "PanelText_UI_Events_Panel_Spur_Text_C_Pass_Content|通关奖励"
  },
  UI_Dungeous_Popup_Swept_Tip2_Text_C_Coin = {
    ID = "UI_Dungeous_Popup_Swept_Tip2_Text_C_Coin",
    Content = "PanelText_UI_Dungeous_Popup_Swept_Tip2_Text_C_Coin_Content|货币不足"
  },
  UI_Dungeons_Panel_Out_Text_C_TeamInfo = {
    ID = "UI_Dungeons_Panel_Out_Text_C_TeamInfo",
    Content = "PanelText_UI_Dungeons_Panel_Out_Text_C_TeamInfo_Content|队伍信息"
  },
  UI_Pvp_Item_Role_Text_C_Role_Wins = {
    ID = "UI_Pvp_Item_Role_Text_C_Role_Wins",
    Content = "PanelText_UI_Pvp_Item_Role_Text_C_Role_Wins_Content|胜场"
  },
  UI_Pvp_Item_Role_Text_C_Maniac = {
    ID = "UI_Pvp_Item_Role_Text_C_Maniac",
    Content = "PanelText_UI_Pvp_Item_Role_Text_C_Maniac_Content|狂气"
  },
  UI_Pvp_Item_Role_Text_C_Decks = {
    ID = "UI_Pvp_Item_Role_Text_C_Decks",
    Content = "PanelText_UI_Pvp_Item_Role_Text_C_Decks_Content|牌组"
  },
  UI_Pvp_Popup_Collection_Detail_Text_C_Role_Wins = {
    ID = "UI_Pvp_Popup_Collection_Detail_Text_C_Role_Wins",
    Content = "PanelText_UI_Pvp_Popup_Collection_Detail_Text_C_Role_Wins_Content|胜场"
  },
  UI_Pvp_Popup_Collection_Detail_Text_C_Maniac = {
    ID = "UI_Pvp_Popup_Collection_Detail_Text_C_Maniac",
    Content = "PanelText_UI_Pvp_Popup_Collection_Detail_Text_C_Maniac_Content|狂气"
  },
  UI_Pvp_Popup_Collection_Detail_Text_C_Decks = {
    ID = "UI_Pvp_Popup_Collection_Detail_Text_C_Decks",
    Content = "PanelText_UI_Pvp_Popup_Collection_Detail_Text_C_Decks_Content|牌组"
  },
  UI_Pvp_Popup_Collection_Detail_Text_C_Wins = {
    ID = "UI_Pvp_Popup_Collection_Detail_Text_C_Wins",
    Content = "PanelText_UI_Pvp_Popup_Collection_Detail_Text_C_Wins_Content|胜场"
  },
  UI_Pvp_Popup_Collection_Detail_Text_C_Effect = {
    ID = "UI_Pvp_Popup_Collection_Detail_Text_C_Effect",
    Content = "PanelText_UI_Pvp_Popup_Collection_Detail_Text_C_Effect_Content|效果"
  },
  UI_Main_Panel_1_Text_C_Pvp = {
    ID = "UI_Main_Panel_1_Text_C_Pvp",
    Content = "PanelText_UI_Main_Panel_1_Text_C_Pvp_Content|相位对弈\n"
  },
  GmPanel_Text_C_Battle_Test2 = {
    ID = "GmPanel_Text_C_Battle_Test2",
    Content = "PanelText_GmPanel_Text_C_Battle_Test2_Content|PvP战斗"
  },
  UI_Pvp_Panel_Main_1_Text_C_Title = {
    ID = "UI_Pvp_Panel_Main_1_Text_C_Title",
    Content = "PanelText_UI_Pvp_Panel_Main_1_Text_C_Title_Content|相位对弈"
  },
  UI_Pvp_Panel_Main_1_Text_C_Weekly = {
    ID = "UI_Pvp_Panel_Main_1_Text_C_Weekly",
    Content = "PanelText_UI_Pvp_Panel_Main_1_Text_C_Weekly_Content|每周奖励"
  },
  UI_Pvp_Panel_Main_1_Text_C_Time = {
    ID = "UI_Pvp_Panel_Main_1_Text_C_Time",
    Content = "PanelText_UI_Pvp_Panel_Main_1_Text_C_Time_Content|当前赛季剩余"
  },
  UI_Pvp_Panel_Main_1_Text_C_Store = {
    ID = "UI_Pvp_Panel_Main_1_Text_C_Store",
    Content = "PanelText_UI_Pvp_Panel_Main_1_Text_C_Store_Content|商店"
  },
  UI_Pvp_Panel_Main_1_Text_C_Collection = {
    ID = "UI_Pvp_Panel_Main_1_Text_C_Collection",
    Content = "PanelText_UI_Pvp_Panel_Main_1_Text_C_Collection_Content|收藏"
  },
  UI_Pvp_Panel_Main_1_Text_C_list = {
    ID = "UI_Pvp_Panel_Main_1_Text_C_list",
    Content = "PanelText_UI_Pvp_Panel_Main_1_Text_C_list_Content|排行"
  },
  UI_Pvp_Panel_Main_1_Text_C_Bonus = {
    ID = "UI_Pvp_Panel_Main_1_Text_C_Bonus"
  },
  UI_Pvp_Panel_Main_1_Text_C_Bracket_Bar = {
    ID = "UI_Pvp_Panel_Main_1_Text_C_Bracket_Bar",
    Content = "PanelText_UI_Pvp_Panel_Main_1_Text_C_Bracket_Bar_Content|/"
  },
  UI_Pvp_Panel_Main_1_Text_C_Bracket_Left = {
    ID = "UI_Pvp_Panel_Main_1_Text_C_Bracket_Left",
    Content = "PanelText_UI_Pvp_Panel_Main_1_Text_C_Bracket_Left_Content|("
  },
  UI_Pvp_Panel_Main_1_Text_C_Bracket_Right = {
    ID = "UI_Pvp_Panel_Main_1_Text_C_Bracket_Right",
    Content = "PanelText_UI_Pvp_Panel_Main_1_Text_C_Bracket_Right_Content|)"
  },
  UI_Pvp_Panel_Main_1_Text_C_Matching = {
    ID = "UI_Pvp_Panel_Main_1_Text_C_Matching",
    Content = "PanelText_UI_Pvp_Panel_Main_1_Text_C_Matching_Content|开始匹配"
  },
  UI_Pvp_Panel_Main_1_Text_C_Progress = {
    ID = "UI_Pvp_Panel_Main_1_Text_C_Progress",
    Content = "PanelText_UI_Pvp_Panel_Main_1_Text_C_Progress_Content|段位奖励"
  },
  UI_Pvp_Panel_Main_1_Text_C_Reward = {
    ID = "UI_Pvp_Panel_Main_1_Text_C_Reward",
    Content = "PanelText_UI_Pvp_Panel_Main_1_Text_C_Reward_Content|到达更高段位获得更多奖励"
  },
  UI_Awaker_Item_Topped_Detail_Text_C_Condition = {
    ID = "UI_Awaker_Item_Topped_Detail_Text_C_Condition",
    Content = "PanelText_UI_Awaker_Item_Topped_Detail_Text_C_Condition_Content|升格条件"
  },
  UI_Pvp_Panel_Formation_Text_C_Name = {
    ID = "UI_Pvp_Panel_Formation_Text_C_Name",
    Content = "PanelText_UI_Pvp_Panel_Formation_Text_C_Name_Content|详情"
  },
  UI_Pvp_Panel_Battle_Text_High = {
    ID = "UI_Pvp_Panel_Battle_Text_High",
    Content = "PanelText_UI_Pvp_Panel_Battle_Text_High_Content|投降"
  },
  UI_Common_Popup_Card_List_Text_C_Time = {
    ID = "UI_Common_Popup_Card_List_Text_C_Time",
    Content = "PanelText_UI_Common_Popup_Card_List_Text_C_Time_Content|去其他地方看看吧"
  },
  UI_Common_Popup_Card_List_Text_C_NoTask = {
    ID = "UI_Common_Popup_Card_List_Text_C_NoTask",
    Content = "PanelText_UI_Common_Popup_Card_List_Text_C_NoTask_Content|暂无卡牌"
  },
  UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_C_Screen = {
    ID = "UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_C_Screen",
    Content = "PanelText_UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_C_Screen_Content|筛选"
  },
  UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_SiftTitle1 = {
    ID = "UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_SiftTitle1",
    Content = "PanelText_UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_SiftTitle1_Content|套装"
  },
  UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_SiftTitle2 = {
    ID = "UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_SiftTitle2",
    Content = "PanelText_UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_SiftTitle2_Content|位置"
  },
  UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_SiftTitle3 = {
    ID = "UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_SiftTitle3",
    Content = "PanelText_UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_SiftTitle3_Content|主属性"
  },
  UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_SiftTitle4 = {
    ID = "UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_SiftTitle4",
    Content = "PanelText_UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_SiftTitle4_Content|副属性"
  },
  UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_Confirm = {
    ID = "UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_Confirm",
    Content = "PanelText_UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_Confirm_Content|确认"
  },
  UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_Reset = {
    ID = "UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_Reset",
    Content = "PanelText_UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_Reset_Content|重置"
  },
  UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_C_Tips1 = {
    ID = "UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_C_Tips1",
    Content = "PanelText_UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_C_Tips1_Content|Ⅰ"
  },
  UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_C_Tips2 = {
    ID = "UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_C_Tips2",
    Content = "PanelText_UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_C_Tips2_Content|Ⅱ"
  },
  UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_C_Tips3 = {
    ID = "UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_C_Tips3",
    Content = "PanelText_UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_C_Tips3_Content|Ⅲ"
  },
  UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_C_Tips4 = {
    ID = "UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_C_Tips4",
    Content = "PanelText_UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_C_Tips4_Content|Ⅳ"
  },
  UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_C_Tips5 = {
    ID = "UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_C_Tips5",
    Content = "PanelText_UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_C_Tips5_Content|Ⅴ"
  },
  UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_C_Tips6 = {
    ID = "UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_C_Tips6",
    Content = "PanelText_UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_C_Tips6_Content|Ⅵ"
  },
  UI_Alchemy_Popup_Suit_Item1_Text_C_Not = {
    ID = "UI_Alchemy_Popup_Suit_Item1_Text_C_Not",
    Content = "PanelText_UI_Alchemy_Popup_Suit_Item1_Text_C_Not_Content|无"
  },
  UI_Alchemy_Popup_Suit_Item1_Text_C_Have = {
    ID = "UI_Alchemy_Popup_Suit_Item1_Text_C_Have",
    Content = "PanelText_UI_Alchemy_Popup_Suit_Item1_Text_C_Have_Content|有"
  },
  UI_Pvp_Team_Main_Text_C_Realms = {
    ID = "UI_Pvp_Team_Main_Text_C_Realms",
    Content = "PanelText_UI_Pvp_Team_Main_Text_C_Realms_Content|未激活界域"
  },
  UI_Pvp_Team_Main_Text_C_Title = {
    ID = "UI_Pvp_Team_Main_Text_C_Title",
    Content = "PanelText_UI_Pvp_Team_Main_Text_C_Title_Content|预组编队"
  },
  UI_Keeper_Skill_Panel_Text_C_Title = {
    ID = "UI_Keeper_Skill_Panel_Text_C_Title",
    Content = "PanelText_UI_Keeper_Skill_Panel_Text_C_Title_Content|钥令"
  },
  UI_Team_Popup_Prop_Award_Text_C_Title = {
    ID = "UI_Team_Popup_Prop_Award_Text_C_Title",
    Content = "PanelText_UI_Team_Popup_Prop_Award_Text_C_Title_Content|职业天赋"
  },
  UI_Pvp_Panel_Collection_Detail_Text_C_Role_Wins = {
    ID = "UI_Pvp_Panel_Collection_Detail_Text_C_Role_Wins",
    Content = "PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_Role_Wins_Content|本月胜场"
  },
  UI_Pvp_Panel_Collection_Detail_Text_C_Maniac = {
    ID = "UI_Pvp_Panel_Collection_Detail_Text_C_Maniac",
    Content = "PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_Maniac_Content|狂气"
  },
  UI_Pvp_Panel_Collection_Detail_Text_C_Decks = {
    ID = "UI_Pvp_Panel_Collection_Detail_Text_C_Decks",
    Content = "PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_Decks_Content|牌组"
  },
  UI_Pvp_Panel_Collection_Detail_Text_C_Wins = {
    ID = "UI_Pvp_Panel_Collection_Detail_Text_C_Wins",
    Content = "PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_Wins_Content|本赛季胜场"
  },
  UI_Pvp_Panel_Collection_Detail_Text_C_Effect = {
    ID = "UI_Pvp_Panel_Collection_Detail_Text_C_Effect",
    Content = "PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_Effect_Content|效果"
  },
  UI_Pvp_Panel_Collection_Detail_Text_C_Skill_Tag = {
    ID = "UI_Pvp_Panel_Collection_Detail_Text_C_Skill_Tag",
    Content = "PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_Skill_Tag_Content|狂气爆发"
  },
  UI_Awaker_Popup_Topped_Tip2_Text_C_Unlock = {
    ID = "UI_Awaker_Popup_Topped_Tip2_Text_C_Unlock",
    Content = "PanelText_UI_Awaker_Popup_Topped_Tip2_Text_C_Unlock_Content|档案解锁"
  },
  UI_Awaker_Popup_Topped_Tip2_Text_C_Reward = {
    ID = "UI_Awaker_Popup_Topped_Tip2_Text_C_Reward",
    Content = "PanelText_UI_Awaker_Popup_Topped_Tip2_Text_C_Reward_Content|等级奖励"
  },
  UI_Awaker_Popup_Topped_Tip2_Text_C_illustrate = {
    ID = "UI_Awaker_Popup_Topped_Tip2_Text_C_illustrate",
    Content = "PanelText_UI_Awaker_Popup_Topped_Tip2_Text_C_illustrate_Content|规则说明"
  },
  UI_Awaker_Popup_Topped_Tip2_Text_C_Title = {
    ID = "UI_Awaker_Popup_Topped_Tip2_Text_C_Title",
    Content = "PanelText_UI_Awaker_Popup_Topped_Tip2_Text_C_Title_Content|同调率"
  },
  UI_Pocket_Mail_Text_C_Del = {
    ID = "UI_Pocket_Mail_Text_C_Del",
    Content = "PanelText_UI_Pocket_Mail_Text_C_Del_Content|删除"
  },
  UI_Main_Panel_1_Text_C_Daily = {
    ID = "UI_Main_Panel_1_Text_C_Daily",
    Content = "PanelText_UI_Main_Panel_1_Text_C_Daily_Content|每日试训"
  },
  UI_Main_Panel_1_Text_C_Lever = {
    ID = "UI_Main_Panel_1_Text_C_Lever",
    Content = "PanelText_UI_Main_Panel_1_Text_C_Lever_Content|/"
  },
  UI_Main_Daily_Tips_Text_C_Finish = {
    ID = "UI_Main_Daily_Tips_Text_C_Finish",
    Content = "PanelText_UI_Main_Daily_Tips_Text_C_Finish_Content|今日已完成"
  },
  UI_Main_Daily_Tips_Text_C_Receive = {
    ID = "UI_Main_Daily_Tips_Text_C_Receive",
    Content = "PanelText_UI_Main_Daily_Tips_Text_C_Receive_Content|已领取"
  },
  UI_Main_Daily_Tips_Text_C_Close = {
    ID = "UI_Main_Daily_Tips_Text_C_Close",
    Content = "PanelText_UI_Main_Daily_Tips_Text_C_Close_Content|点击屏幕关闭"
  },
  UI_Main_Daily_Tips_Text_C_Reward = {
    ID = "UI_Main_Daily_Tips_Text_C_Reward",
    Content = "PanelText_UI_Main_Daily_Tips_Text_C_Reward_Content|完成奖励"
  },
  UI_Main_Daily_Tips_Text_C_Daily = {
    ID = "UI_Main_Daily_Tips_Text_C_Daily",
    Content = "PanelText_UI_Main_Daily_Tips_Text_C_Daily_Content|每日试训"
  },
  UI_Main_Daily_Tips_Text_C_Skill_Tag = {
    ID = "UI_Main_Daily_Tips_Text_C_Skill_Tag",
    Content = "PanelText_UI_Main_Daily_Tips_Text_C_Skill_Tag_Content|调查途径"
  },
  UI_Pvp_Panel_Collection_Main_Text_C_Toggle_1 = {
    ID = "UI_Pvp_Panel_Collection_Main_Text_C_Toggle_1",
    Content = "PanelText_UI_Pvp_Panel_Collection_Main_Text_C_Toggle_1_Content|详情"
  },
  UI_Pvp_Panel_Collection_Main_Text_C_Toggle_2 = {
    ID = "UI_Pvp_Panel_Collection_Main_Text_C_Toggle_2",
    Content = "PanelText_UI_Pvp_Panel_Collection_Main_Text_C_Toggle_2_Content|排行"
  },
  UI_Pvp_Panel_Collection_Main_Text_C_Toggle_3 = {
    ID = "UI_Pvp_Panel_Collection_Main_Text_C_Toggle_3",
    Content = "PanelText_UI_Pvp_Panel_Collection_Main_Text_C_Toggle_3_Content|评论"
  },
  UI_Pvp_Panel_Collection_Detail_Text_C_Hoist = {
    ID = "UI_Pvp_Panel_Collection_Detail_Text_C_Hoist",
    Content = "PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_Hoist_Content|算力消耗"
  },
  UI_Research_Popup_Recall2_Text_C_Title = {
    ID = "UI_Research_Popup_Recall2_Text_C_Title",
    Content = "PanelText_UI_Research_Popup_Recall2_Text_C_Title_Content|派遣报告"
  },
  UI_Research_Popup_Recall2_Text_C_Dispatch = {
    ID = "UI_Research_Popup_Recall2_Text_C_Dispatch",
    Content = "PanelText_UI_Research_Popup_Recall2_Text_C_Dispatch_Content|派遣唤醒体"
  },
  UI_Research_Popup_Recall2_Text_C_Reward = {
    ID = "UI_Research_Popup_Recall2_Text_C_Reward",
    Content = "PanelText_UI_Research_Popup_Recall2_Text_C_Reward_Content|任务奖励"
  },
  UI_Awaker_Popup_Tip_Succeed_Text_C_Info = {
    ID = "UI_Awaker_Popup_Tip_Succeed_Text_C_Info",
    Content = "PanelText_UI_Awaker_Popup_Tip_Succeed_Text_C_Info_Content|点击空白处关闭"
  },
  UI_Pvp_Panel_Collection_Main_Text_C_Awaker_Name = {
    ID = "UI_Pvp_Panel_Collection_Main_Text_C_Awaker_Name",
    Content = "PanelText_UI_Pvp_Panel_Collection_Main_Text_C_Awaker_Name_Content|唤醒体"
  },
  UI_Main_Panel_1_Text_C_Full = {
    ID = "UI_Main_Panel_1_Text_C_Full",
    Content = "PanelText_UI_Main_Panel_1_Text_C_Full_Content|已完成"
  },
  UI_Research_Popup_Recall2_Text_Close = {
    ID = "UI_Research_Popup_Recall2_Text_Close",
    Content = "PanelText_UI_Research_Popup_Recall2_Text_Close_Content|关闭"
  },
  UI_Research_Popup_Recall2_Text_Agin = {
    ID = "UI_Research_Popup_Recall2_Text_Agin",
    Content = "PanelText_UI_Research_Popup_Recall2_Text_Agin_Content|再次派遣"
  },
  UI_Pvp_Panel_Collection_Main_Text_C_Weapon_Name = {
    ID = "UI_Pvp_Panel_Collection_Main_Text_C_Weapon_Name",
    Content = "PanelText_UI_Pvp_Panel_Collection_Main_Text_C_Weapon_Name_Content|命轮"
  },
  UI_Pvp_Panel_Collection_Main_Text_C_KeeperSkill_Name = {
    ID = "UI_Pvp_Panel_Collection_Main_Text_C_KeeperSkill_Name",
    Content = "PanelText_UI_Pvp_Panel_Collection_Main_Text_C_KeeperSkill_Name_Content|钥令"
  },
  UI_Team_Panel_Main_Text_C_Activated = {
    ID = "UI_Team_Panel_Main_Text_C_Activated",
    Content = "PanelText_UI_Team_Panel_Main_Text_C_Activated_Content|已激活"
  },
  UI_Team_Panel_Main_Text_C_NoActivate = {
    ID = "UI_Team_Panel_Main_Text_C_NoActivate",
    Content = "PanelText_UI_Team_Panel_Main_Text_C_NoActivate_Content|未激活"
  },
  UI_Team_Panel_Main_Text_C_Tips = {
    ID = "UI_Team_Panel_Main_Text_C_Tips",
    Content = "PanelText_UI_Team_Panel_Main_Text_C_Tips_Content|解除助战"
  },
  UI_Awaker_Popup_Topped_Tip2_Text_Name = {
    ID = "UI_Awaker_Popup_Topped_Tip2_Text_Name",
    Content = "PanelText_UI_Awaker_Popup_Topped_Tip2_Text_Name_Content|领取"
  },
  UI_Team_Popup_Prop_Award_Text_C_Name01 = {
    ID = "UI_Team_Popup_Prop_Award_Text_C_Name01",
    Content = "PanelText_UI_Team_Popup_Prop_Award_Text_C_Name01_Content|混沌"
  },
  UI_Team_Popup_Prop_Award_Text_C_Name02 = {
    ID = "UI_Team_Popup_Prop_Award_Text_C_Name02",
    Content = "PanelText_UI_Team_Popup_Prop_Award_Text_C_Name02_Content|深海"
  },
  UI_Team_Popup_Prop_Award_Text_C_Name03 = {
    ID = "UI_Team_Popup_Prop_Award_Text_C_Name03",
    Content = "PanelText_UI_Team_Popup_Prop_Award_Text_C_Name03_Content|血肉"
  },
  UI_Team_Popup_Prop_Award_Text_C_Name04 = {
    ID = "UI_Team_Popup_Prop_Award_Text_C_Name04",
    Content = "PanelText_UI_Team_Popup_Prop_Award_Text_C_Name04_Content|超维"
  },
  UI_Dungeous_Panel_Realms_Text_C_Award2 = {
    ID = "UI_Dungeous_Panel_Realms_Text_C_Award2",
    Content = "PanelText_UI_Dungeous_Panel_Realms_Text_C_Award2_Content|密境法则"
  },
  UI_Dungeous_Popup_Tips_Text_C_Game = {
    ID = "UI_Dungeous_Popup_Tips_Text_C_Game",
    Content = "PanelText_UI_Dungeous_Popup_Tips_Text_C_Game_Content|累积奖励"
  },
  UI_Dungeous_Popup_Tips_Text_C_Activity = {
    ID = "UI_Dungeous_Popup_Tips_Text_C_Activity",
    Content = "PanelText_UI_Dungeous_Popup_Tips_Text_C_Activity_Content|首通奖励"
  },
  UI_Dungeous_Popup_Tips_Text_C_Game2 = {
    ID = "UI_Dungeous_Popup_Tips_Text_C_Game2",
    Content = "PanelText_UI_Dungeous_Popup_Tips_Text_C_Game2_Content|累积奖励"
  },
  UI_Dungeous_Popup_Tips_Text_C_Activity2 = {
    ID = "UI_Dungeous_Popup_Tips_Text_C_Activity2",
    Content = "PanelText_UI_Dungeous_Popup_Tips_Text_C_Activity2_Content|首通奖励"
  },
  UI_Common_Popup_Tip_3_Text_C_ShopNeed = {
    ID = "UI_Common_Popup_Tip_3_Text_C_ShopNeed",
    Content = "PanelText_UI_Common_Popup_Tip_3_Text_C_ShopNeed_Content|当前商品券数量"
  },
  UI_Social_Panel_Data_Text_C_Squiggle = {
    ID = "UI_Social_Panel_Data_Text_C_Squiggle",
    Content = "PanelText_UI_Social_Panel_Data_Text_C_Squiggle_Content|Silver begets knowledge."
  },
  UI_Social_Panel_Data_Text_C_Not = {
    ID = "UI_Social_Panel_Data_Text_C_Not",
    Content = "PanelText_UI_Social_Panel_Data_Text_C_Not_Content|未设置助战唤醒体"
  },
  UI_Social_Panel_Data_Text_C_Lv_1 = {
    ID = "UI_Social_Panel_Data_Text_C_Lv_1",
    Content = "PanelText_UI_Social_Panel_Data_Text_C_Lv_1_Content|Lv."
  },
  UI_Social_Panel_Data_Text_C_Help = {
    ID = "UI_Social_Panel_Data_Text_C_Help",
    Content = "PanelText_UI_Social_Panel_Data_Text_C_Help_Content|助战唤醒体"
  },
  UI_Social_Panel_Data_Text_C_Team = {
    ID = "UI_Social_Panel_Data_Text_C_Team",
    Content = "PanelText_UI_Social_Panel_Data_Text_C_Team_Content|唤醒体展示"
  },
  UI_Social_Panel_Data_Text_C_Null_1 = {
    ID = "UI_Social_Panel_Data_Text_C_Null_1",
    Content = "PanelText_UI_Social_Panel_Data_Text_C_Null_1_Content|未展示唤醒体"
  },
  UI_Social_Panel_Data_Text_C_Society = {
    ID = "UI_Social_Panel_Data_Text_C_Society",
    Content = "PanelText_UI_Social_Panel_Data_Text_C_Society_Content|所属公会"
  },
  UI_Social_Panel_Data_Text_C_Birthday = {
    ID = "UI_Social_Panel_Data_Text_C_Birthday",
    Content = "PanelText_UI_Social_Panel_Data_Text_C_Birthday_Content|生日"
  },
  UI_Social_Panel_Data_Text_C_Awaker = {
    ID = "UI_Social_Panel_Data_Text_C_Awaker",
    Content = "PanelText_UI_Social_Panel_Data_Text_C_Awaker_Content|链接唤醒体"
  },
  UI_Social_Panel_Data_Text_C_Conclude = {
    ID = "UI_Social_Panel_Data_Text_C_Conclude",
    Content = "PanelText_UI_Social_Panel_Data_Text_C_Conclude_Content|达成成就"
  },
  UI_Social_Panel_Data_Text_C_Register = {
    ID = "UI_Social_Panel_Data_Text_C_Register",
    Content = "PanelText_UI_Social_Panel_Data_Text_C_Register_Content|登录天数"
  },
  UI_Social_Panel_Data_Text_C_Assist = {
    ID = "UI_Social_Panel_Data_Text_C_Assist",
    Content = "PanelText_UI_Social_Panel_Data_Text_C_Assist_Content|助战次数"
  },
  UI_Social_Panel_Data_Text_C_Concern = {
    ID = "UI_Social_Panel_Data_Text_C_Concern",
    Content = "PanelText_UI_Social_Panel_Data_Text_C_Concern_Content|UID"
  },
  UI_Social_Panel_Data_Text_C_Lv_2 = {
    ID = "UI_Social_Panel_Data_Text_C_Lv_2",
    Content = "PanelText_UI_Social_Panel_Data_Text_C_Lv_2_Content|Lv."
  },
  UI_Social_Panel_Data_Text_C_Fans = {
    ID = "UI_Social_Panel_Data_Text_C_Fans",
    Content = "PanelText_UI_Social_Panel_Data_Text_C_Fans_Content|追随者"
  },
  UI_Social_Panel_Data_Text_C_Concern2 = {
    ID = "UI_Social_Panel_Data_Text_C_Concern2",
    Content = "PanelText_UI_Social_Panel_Data_Text_C_Concern2_Content|关注"
  },
  UI_Social_Panel_Data_Text_C_Survey = {
    ID = "UI_Social_Panel_Data_Text_C_Survey",
    Content = "PanelText_UI_Social_Panel_Data_Text_C_Survey_Content|调查状况"
  },
  UI_Social_Panel_Data_Text_C_Difficulty = {
    ID = "UI_Social_Panel_Data_Text_C_Difficulty",
    Content = "PanelText_UI_Social_Panel_Data_Text_C_Difficulty_Content|困难"
  },
  UI_Social_Panel_Data_Text_C_Dream = {
    ID = "UI_Social_Panel_Data_Text_C_Dream",
    Content = "PanelText_UI_Social_Panel_Data_Text_C_Dream_Content|幻梦深潜"
  },
  UI_Social_Panel_Data_Text_C_Pagoda = {
    ID = "UI_Social_Panel_Data_Text_C_Pagoda",
    Content = "PanelText_UI_Social_Panel_Data_Text_C_Pagoda_Content|无光之塔"
  },
  UI_Social_Panel_Data_Text_C_Indestructible = {
    ID = "UI_Social_Panel_Data_Text_C_Indestructible",
    Content = "PanelText_UI_Social_Panel_Data_Text_C_Indestructible_Content|不可名状"
  },
  UI_Social_Panel_Data_Text_C_Privacy = {
    ID = "UI_Social_Panel_Data_Text_C_Privacy",
    Content = "PanelText_UI_Social_Panel_Data_Text_C_Privacy_Content|守密人已设置调查状况为隐私"
  },
  UI_Social_Panel_Main_Text_C_Concern = {
    ID = "UI_Social_Panel_Main_Text_C_Concern",
    Content = "PanelText_UI_Social_Panel_Main_Text_C_Concern_Content|新增"
  },
  UI_Social_Panel_Main_Text_C_Tips_1 = {
    ID = "UI_Social_Panel_Main_Text_C_Tips_1",
    Content = "PanelText_UI_Social_Panel_Main_Text_C_Tips_1_Content|输入名称搜索"
  },
  UI_Social_Panel_Main_Text_C_Tips_2 = {
    ID = "UI_Social_Panel_Main_Text_C_Tips_2",
    Content = "PanelText_UI_Social_Panel_Main_Text_C_Tips_2_Content|输入名称搜索"
  },
  UI_Social_Panel_Main_Text_C_Stranger = {
    ID = "UI_Social_Panel_Main_Text_C_Stranger",
    Content = "PanelText_UI_Social_Panel_Main_Text_C_Stranger_Content|陌生人"
  },
  UI_Social_Panel_Main_Item_Text_C_Done = {
    ID = "UI_Social_Panel_Main_Item_Text_C_Done",
    Content = "PanelText_UI_Social_Panel_Main_Item_Text_C_Done_Content|已关注我"
  },
  UI_Social_Panel_Main_Item_Text_C_Mutual = {
    ID = "UI_Social_Panel_Main_Item_Text_C_Mutual",
    Content = "PanelText_UI_Social_Panel_Main_Item_Text_C_Mutual_Content|互相关注"
  },
  UI_Social_Popup_Birthday_Text_C_Title = {
    ID = "UI_Social_Popup_Birthday_Text_C_Title",
    Content = "PanelText_UI_Social_Popup_Birthday_Text_C_Title_Content|编辑生日"
  },
  UI_Social_Popup_Birthday_Text_C_Month = {
    ID = "UI_Social_Popup_Birthday_Text_C_Month",
    Content = "PanelText_UI_Social_Popup_Birthday_Text_C_Month_Content|月"
  },
  UI_Social_Popup_Birthday_Text_C_Day = {
    ID = "UI_Social_Popup_Birthday_Text_C_Day",
    Content = "PanelText_UI_Social_Popup_Birthday_Text_C_Day_Content|日"
  },
  UI_Battle_Popup_Fail_Text_C_Victory = {
    ID = "UI_Battle_Popup_Fail_Text_C_Victory",
    Content = "PanelText_UI_Battle_Popup_Fail_Text_C_Victory_Content|战斗失败"
  },
  UI_Battle_Popup_Fail_Text_C_Failure = {
    ID = "UI_Battle_Popup_Fail_Text_C_Failure",
    Content = "PanelText_UI_Battle_Popup_Fail_Text_C_Failure_Content|Failure"
  },
  UI_Battle_Popup_Fail_Text_C_Continue = {
    ID = "UI_Battle_Popup_Fail_Text_C_Continue",
    Content = "PanelText_UI_Battle_Popup_Fail_Text_C_Continue_Content|点击继续"
  },
  UI_Events_Popup_Optional_Text_C_Title = {
    ID = "UI_Events_Popup_Optional_Text_C_Title",
    Content = "PanelText_UI_Events_Popup_Optional_Text_C_Title_Content|自选命轮"
  },
  UI_Events_Stage_Tip_Text_C_Title = {
    ID = "UI_Events_Stage_Tip_Text_C_Title",
    Content = "PanelText_UI_Events_Stage_Tip_Text_C_Title_Content|调查奖励"
  },
  UI_Events_Item_Optional_Text_C_Have = {
    ID = "UI_Events_Item_Optional_Text_C_Have",
    Content = "PanelText_UI_Events_Item_Optional_Text_C_Have_Content|已拥有"
  },
  UI_Events_Item_Stage_Text_C_Undone = {
    ID = "UI_Events_Item_Stage_Text_C_Undone",
    Content = "PanelText_UI_Events_Item_Stage_Text_C_Undone_Content|未完成"
  },
  UI_Events_Panel_Award_Text_C_Award = {
    ID = "UI_Events_Panel_Award_Text_C_Award",
    Content = "PanelText_UI_Events_Panel_Award_Text_C_Award_Content|幻梦深潜"
  },
  UI_Events_Panel_Award_Text_C_Award_1 = {
    ID = "UI_Events_Panel_Award_Text_C_Award_1",
    Content = "PanelText_UI_Events_Panel_Award_Text_C_Award_1_Content|幻梦深潜"
  },
  UI_Events_Panel_Award_Text_C_Award_2 = {
    ID = "UI_Events_Panel_Award_Text_C_Award_2",
    Content = "PanelText_UI_Events_Panel_Award_Text_C_Award_2_Content|相位对弈"
  },
  UI_Events_Panel_Award_Text_C_Over = {
    ID = "UI_Events_Panel_Award_Text_C_Over",
    Content = "PanelText_UI_Events_Panel_Award_Text_C_Over_Content|今日守密人经验已获得："
  },
  UI_Events_Panel_Award_Text_C_Title = {
    ID = "UI_Events_Panel_Award_Text_C_Title",
    Content = "PanelText_UI_Events_Panel_Award_Text_C_Title_Content|今日守密人经验已获得："
  },
  UI_Events_Item_Optional_Text_C_Full = {
    ID = "UI_Events_Item_Optional_Text_C_Full",
    Content = "PanelText_UI_Events_Item_Optional_Text_C_Full_Content|叠位已满"
  },
  UI_Keeper_Panel_Acquire_Text_C_Acquire = {
    ID = "UI_Keeper_Panel_Acquire_Text_C_Acquire",
    Content = "PanelText_UI_Keeper_Panel_Acquire_Text_C_Acquire_Content|获得新钥令"
  },
  UI_Keeper_Panel_Acquire_Text_C_Tips = {
    ID = "UI_Keeper_Panel_Acquire_Text_C_Tips",
    Content = "PanelText_UI_Keeper_Panel_Acquire_Text_C_Tips_Content|点击屏幕关闭"
  },
  UI_Mail_Text_C_Time = {
    ID = "UI_Mail_Text_C_Time",
    Content = "PanelText_UI_Mail_Text_C_Time_Content|时间："
  },
  UI_Pocket_Mail_Text_C_Time = {
    ID = "UI_Pocket_Mail_Text_C_Time",
    Content = "PanelText_UI_Pocket_Mail_Text_C_Time_Content|时间："
  },
  UI_Mail_Text_C_NoTask1 = {
    ID = "UI_Mail_Text_C_NoTask1",
    Content = "PanelText_UI_Mail_Text_C_NoTask1_Content|暂无信件"
  },
  UI_Mail_Text_C_Delete01 = {
    ID = "UI_Mail_Text_C_Delete01",
    Content = "PanelText_UI_Mail_Text_C_Delete01_Content|删除"
  },
  UI_Pvp_Panel_Formation_Text_C_Detail = {
    ID = "UI_Pvp_Panel_Formation_Text_C_Detail",
    Content = "PanelText_UI_Pvp_Panel_Formation_Text_C_Detail_Content|请从左侧选择上场"
  },
  UI_Passport_Reward_Item_Text_C_Experience = {
    ID = "UI_Passport_Reward_Item_Text_C_Experience",
    Content = "PanelText_UI_Passport_Reward_Item_Text_C_Experience_Content|课题经验"
  },
  UI_Passport_Reward_Item_Text_C_Online = {
    ID = "UI_Passport_Reward_Item_Text_C_Online",
    Content = "PanelText_UI_Passport_Reward_Item_Text_C_Online_Content|本周上限"
  },
  UI_Passport_Reward_Item_Text_C_Full = {
    ID = "UI_Passport_Reward_Item_Text_C_Full",
    Content = "PanelText_UI_Passport_Reward_Item_Text_C_Full_Content|已满级"
  },
  UI_Pvp_Panel_Out_Text_C_Sync = {
    ID = "UI_Pvp_Panel_Out_Text_C_Sync",
    Content = "PanelText_UI_Pvp_Panel_Out_Text_C_Sync_Content|唤醒体同调率提升"
  },
  UI_Dungeons_Panel_WeekBOSS_Text_C_AwardText = {
    ID = "UI_Dungeons_Panel_WeekBOSS_Text_C_AwardText",
    Content = "PanelText_UI_Dungeons_Panel_WeekBOSS_Text_C_AwardText_Content|本周可以领取奖励次数"
  },
  UI_Dungeons_Panel_WeekBOSS_Text_C_Award = {
    ID = "UI_Dungeons_Panel_WeekBOSS_Text_C_Award",
    Content = "PanelText_UI_Dungeons_Panel_WeekBOSS_Text_C_Award_Content|任务报酬"
  },
  UI_Dungeons_Panel_Realms_Text_C_Interval1 = {
    ID = "UI_Dungeons_Panel_Realms_Text_C_Interval1",
    Content = "PanelText_UI_Dungeons_Panel_Realms_Text_C_Interval1_Content|间隙"
  },
  UI_Dungeons_Panel_Realms_Text_C_Interval2 = {
    ID = "UI_Dungeons_Panel_Realms_Text_C_Interval2",
    Content = "PanelText_UI_Dungeons_Panel_Realms_Text_C_Interval2_Content|轮转间隙"
  },
  UI_Dungeons_Panel_Realms_Text_C_Tips = {
    ID = "UI_Dungeons_Panel_Realms_Text_C_Tips",
    Content = "PanelText_UI_Dungeons_Panel_Realms_Text_C_Tips_Content|无光兑换"
  },
  ["UI_Passport_Money_Item_Text_C_Senior (1)"] = {
    ID = "UI_Passport_Money_Item_Text_C_Senior (1)",
    Content = "PanelText_UI_Passport_Money_Item_Text_C_Senior (1)_Content|高级"
  },
  UI_Passport_Money_Item_Text_C_Condition = {
    ID = "UI_Passport_Money_Item_Text_C_Condition",
    Content = "PanelText_UI_Passport_Money_Item_Text_C_Condition_Content|升级后可领取"
  },
  ["UI_Passport_Money_Item_Text_C_Super (1)"] = {
    ID = "UI_Passport_Money_Item_Text_C_Super (1)",
    Content = "PanelText_UI_Passport_Money_Item_Text_C_Super (1)_Content|特级"
  },
  UI_Dungeons_Panel_Material_Text_Award = {
    ID = "UI_Dungeons_Panel_Material_Text_Award",
    Content = "PanelText_UI_Dungeons_Panel_Material_Text_Award_Content|任务报酬"
  },
  UI_Summon_Panel_Share_Role2_Text_C_Title = {
    ID = "UI_Summon_Panel_Share_Role2_Text_C_Title",
    Content = "PanelText_UI_Summon_Panel_Share_Role2_Text_C_Title_Content|UID:"
  },
  UI_Summon_Panel_Share_Role1_Text_C_Title = {
    ID = "UI_Summon_Panel_Share_Role1_Text_C_Title",
    Content = "PanelText_UI_Summon_Panel_Share_Role1_Text_C_Title_Content|UID:"
  },
  UI_Summon_Panel_Share_Weapon1_Text_C_Title = {
    ID = "UI_Summon_Panel_Share_Weapon1_Text_C_Title",
    Content = "PanelText_UI_Summon_Panel_Share_Weapon1_Text_C_Title_Content|UID:"
  },
  UI_Summon_Panel_Share_Weapon2_Text_C_Title = {
    ID = "UI_Summon_Panel_Share_Weapon2_Text_C_Title",
    Content = "PanelText_UI_Summon_Panel_Share_Weapon2_Text_C_Title_Content|UID:"
  },
  UI_Summon_Popup_Share_Text_C_Title = {
    ID = "UI_Summon_Popup_Share_Text_C_Title",
    Content = "PanelText_UI_Summon_Popup_Share_Text_C_Title_Content|UID:"
  },
  UI_Dungeons_Popup_List_Tip_Text_C_SurveyRanking1 = {
    ID = "UI_Dungeons_Popup_List_Tip_Text_C_SurveyRanking1",
    Content = "PanelText_UI_Dungeons_Popup_List_Tip_Text_C_SurveyRanking1_Content|赛季排行"
  },
  UI_Dungeons_Popup_List_Tip_Text_C_SurveyRanking2 = {
    ID = "UI_Dungeons_Popup_List_Tip_Text_C_SurveyRanking2",
    Content = "PanelText_UI_Dungeons_Popup_List_Tip_Text_C_SurveyRanking2_Content|赛季排行"
  },
  UI_Dungeons_Popup_List_Tip_Text_C_RankAward1 = {
    ID = "UI_Dungeons_Popup_List_Tip_Text_C_RankAward1",
    Content = "PanelText_UI_Dungeons_Popup_List_Tip_Text_C_RankAward1_Content|排行奖励"
  },
  UI_Dungeons_Popup_List_Tip_Text_C_RankAward2 = {
    ID = "UI_Dungeons_Popup_List_Tip_Text_C_RankAward2",
    Content = "PanelText_UI_Dungeons_Popup_List_Tip_Text_C_RankAward2_Content|排行奖励"
  },
  UI_Dungeons_Popup_List_Tip_Text_C_Big = {
    ID = "UI_Dungeons_Popup_List_Tip_Text_C_Big",
    Content = "PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Big_Content|排名范围"
  },
  UI_Dungeons_Popup_List_Tip_Text_C_Small = {
    ID = "UI_Dungeons_Popup_List_Tip_Text_C_Small",
    Content = "PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Small_Content|小于等于"
  },
  UI_Dungeons_Popup_List_Tip_Text_C_Reward = {
    ID = "UI_Dungeons_Popup_List_Tip_Text_C_Reward",
    Content = "PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Reward_Content|奖励"
  },
  UI_Dungeons_Popup_List_Tip_Text_C_NoTask = {
    ID = "UI_Dungeons_Popup_List_Tip_Text_C_NoTask",
    Content = "PanelText_UI_Dungeons_Popup_List_Tip_Text_C_NoTask_Content|暂无记录"
  },
  UI_Passport_Instructions_Text_C_Remainder = {
    ID = "UI_Passport_Instructions_Text_C_Remainder",
    Content = "PanelText_UI_Passport_Instructions_Text_C_Remainder_Content|本期剩余时间"
  },
  UI_Team_Panel_Main_Text_C_Tips2 = {
    ID = "UI_Team_Panel_Main_Text_C_Tips2",
    Content = "PanelText_UI_Team_Panel_Main_Text_C_Tips2_Content|队伍信息"
  },
  UI_Battle_Popup_Keeper_Skill_Tip_Text_C_Nature = {
    ID = "UI_Battle_Popup_Keeper_Skill_Tip_Text_C_Nature",
    Content = "PanelText_UI_Battle_Popup_Keeper_Skill_Tip_Text_C_Nature_Content|队伍信息"
  },
  UI_Pvp_Panel_Out_Text_C_Show = {
    ID = "UI_Pvp_Panel_Out_Text_C_Show",
    Content = "PanelText_UI_Pvp_Panel_Out_Text_C_Show_Content|下一步"
  },
  UI_Recharge_Instructions_Text_C_Title = {
    ID = "UI_Recharge_Instructions_Text_C_Title",
    Content = "PanelText_UI_Recharge_Instructions_Text_C_Title_Content|学期课题"
  },
  UI_Passport_Instructions_Text_C_Title = {
    ID = "UI_Passport_Instructions_Text_C_Title",
    Content = "PanelText_UI_Passport_Instructions_Text_C_Title_Content|学期课题"
  },
  UI_Guide_ChangeName_Text_C_Confim_Nor = {
    ID = "UI_Guide_ChangeName_Text_C_Confim_Nor",
    Content = "PanelText_UI_Guide_ChangeName_Text_C_Confim_Nor_Content|签名"
  },
  UI_Passport_Task_Item_Text_C_Experience = {
    ID = "UI_Passport_Task_Item_Text_C_Experience",
    Content = "PanelText_UI_Passport_Task_Item_Text_C_Experience_Content|课题经验"
  },
  UI_Passport_Task_Item_Text_C_Online = {
    ID = "UI_Passport_Task_Item_Text_C_Online",
    Content = "PanelText_UI_Passport_Task_Item_Text_C_Online_Content|本周上限"
  },
  UI_Passport_Task_Item_Text_C_Full = {
    ID = "UI_Passport_Task_Item_Text_C_Full",
    Content = "PanelText_UI_Passport_Task_Item_Text_C_Full_Content|已满级"
  },
  UI_Pvp_Panel_Out_Text_C_Huodewuzi = {
    ID = "UI_Pvp_Panel_Out_Text_C_Huodewuzi",
    Content = "PanelText_UI_Pvp_Panel_Out_Text_C_Huodewuzi_Content|结算获得"
  },
  UI_Guide_ChangeName_Text_C_Confim_Dis = {
    ID = "UI_Guide_ChangeName_Text_C_Confim_Dis",
    Content = "PanelText_UI_Guide_ChangeName_Text_C_Confim_Dis_Content|签名"
  },
  UI_Pvp_Panel_Settlement_Text_C_Ourside = {
    ID = "UI_Pvp_Panel_Settlement_Text_C_Ourside",
    Content = "PanelText_UI_Pvp_Panel_Settlement_Text_C_Ourside_Content|我方"
  },
  UI_Pvp_Panel_Settlement_Text_C_Enemy = {
    ID = "UI_Pvp_Panel_Settlement_Text_C_Enemy",
    Content = "PanelText_UI_Pvp_Panel_Settlement_Text_C_Enemy_Content|敌方"
  },
  UI_Pvp_Panel_Settlement_Text_C_Outcome = {
    ID = "UI_Pvp_Panel_Settlement_Text_C_Outcome",
    Content = "PanelText_UI_Pvp_Panel_Settlement_Text_C_Outcome_Content|胜利"
  },
  UI_Summon_Panel_Main_Text_C_Hint = {
    ID = "UI_Summon_Panel_Main_Text_C_Hint",
    Content = "PanelText_UI_Summon_Panel_Main_Text_C_Hint_Content|可点击此处更换界域"
  },
  UI_Dbgcopy_Panel_Action_Text_C_Spend = {
    ID = "UI_Dbgcopy_Panel_Action_Text_C_Spend",
    Content = "PanelText_UI_Dbgcopy_Panel_Action_Text_C_Spend_Content|花费"
  },
  UI_Pvp_Panel_Collection_List_Text_C_None = {
    ID = "UI_Pvp_Panel_Collection_List_Text_C_None",
    Content = "PanelText_UI_Pvp_Panel_Collection_List_Text_C_None_Content|暂无相关收藏"
  },
  UI_Pvp_Panel_Collection_List_Text_C_Time = {
    ID = "UI_Pvp_Panel_Collection_List_Text_C_Time",
    Content = "PanelText_UI_Pvp_Panel_Collection_List_Text_C_Time_Content|该界域在相位对弈暂未开放"
  },
  UI_Pvp_Panel_Formation_Text_C_None = {
    ID = "UI_Pvp_Panel_Formation_Text_C_None",
    Content = "PanelText_UI_Pvp_Panel_Formation_Text_C_None_Content|无相关筛选结果"
  },
  UI_Dbgcopy_Popup_Event_New_Text_C_Display = {
    ID = "UI_Dbgcopy_Popup_Event_New_Text_C_Display",
    Content = "PanelText_UI_Dbgcopy_Popup_Event_New_Text_C_Display_Content|显示事件"
  },
  UI_Dbgcopy_Popup_Event_New_Text_C_Hide = {
    ID = "UI_Dbgcopy_Popup_Event_New_Text_C_Hide",
    Content = "PanelText_UI_Dbgcopy_Popup_Event_New_Text_C_Hide_Content|隐藏事件"
  },
  UI_Summon_Popup_Detail_Tip_Text_C_REcording = {
    ID = "UI_Summon_Popup_Detail_Tip_Text_C_REcording",
    Content = "PanelText_UI_Summon_Popup_Detail_Tip_Text_C_REcording_Content|历史记录"
  },
  UI_Summon_Popup_Detail_Tip_Text_C_Not = {
    ID = "UI_Summon_Popup_Detail_Tip_Text_C_Not",
    Content = "PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Not_Content|暂无记录"
  },
  UI_Summon_Popup_Detail_Tip_Text_C_Type = {
    ID = "UI_Summon_Popup_Detail_Tip_Text_C_Type",
    Content = "PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Type_Content|类型"
  },
  UI_Summon_Popup_Detail_Tip_Text_C_Name = {
    ID = "UI_Summon_Popup_Detail_Tip_Text_C_Name",
    Content = "PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Name_Content|名称"
  },
  UI_Summon_Popup_Detail_Tip_Text_C_Role = {
    ID = "UI_Summon_Popup_Detail_Tip_Text_C_Role",
    Content = "PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Role_Content|唤醒类型"
  },
  UI_Summon_Popup_Detail_Tip_Text_C_Time = {
    ID = "UI_Summon_Popup_Detail_Tip_Text_C_Time",
    Content = "PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Time_Content|唤醒时间"
  },
  UI_Summon_Popup_Detail_Tip_Text_C_Type_1 = {
    ID = "UI_Summon_Popup_Detail_Tip_Text_C_Type_1",
    Content = "PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Type_1_Content|唤醒类型"
  },
  UI_Summon_Popup_Detail_Tip_Text_C_Prompt = {
    ID = "UI_Summon_Popup_Detail_Tip_Text_C_Prompt",
    Content = "PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Prompt_Content|可在本页面查询近6个月的唤醒记录，数据可能有1小时左右延误。"
  },
  UI_Research_Popup_Recall_Text_C_Title = {
    ID = "UI_Research_Popup_Recall_Text_C_Title",
    Content = "PanelText_UI_Research_Popup_Recall_Text_C_Title_Content|选择唤醒体派遣"
  },
  UI_Dbgcopy_Panel_Select_Arousal_Text_C_Name = {
    ID = "UI_Dbgcopy_Panel_Select_Arousal_Text_C_Name",
    Content = "PanelText_UI_Dbgcopy_Panel_Select_Arousal_Text_C_Name_Content|选择"
  },
  UI_Awaker_Item_Skill_Training_Text_C_Or = {
    ID = "UI_Awaker_Item_Skill_Training_Text_C_Or",
    Content = "PanelText_UI_Awaker_Item_Skill_Training_Text_C_Or_Content|/"
  },
  UI_Awaker_Item_Skill_Training_Text_C_Or_1 = {
    ID = "UI_Awaker_Item_Skill_Training_Text_C_Or_1",
    Content = "PanelText_UI_Awaker_Item_Skill_Training_Text_C_Or_1_Content|/"
  },
  UI_Awaker_Item_Skill_Training_Text_C_Skill_Tag = {
    ID = "UI_Awaker_Item_Skill_Training_Text_C_Skill_Tag",
    Content = "PanelText_UI_Awaker_Item_Skill_Training_Text_C_Skill_Tag_Content|狂气爆发"
  },
  UI_Awaker_Item_Skill_Training_Text_C_Or_2 = {
    ID = "UI_Awaker_Item_Skill_Training_Text_C_Or_2",
    Content = "PanelText_UI_Awaker_Item_Skill_Training_Text_C_Or_2_Content|/"
  },
  UI_Battle_Panel_CardStack_Text_C_Display = {
    ID = "UI_Battle_Panel_CardStack_Text_C_Display",
    Content = "PanelText_UI_Battle_Panel_CardStack_Text_C_Display_Content|显示卡牌"
  },
  UI_Battle_Panel_CardStack_Text_C_Hide = {
    ID = "UI_Battle_Panel_CardStack_Text_C_Hide",
    Content = "PanelText_UI_Battle_Panel_CardStack_Text_C_Hide_Content|隐藏卡牌"
  },
  UI_Passport_Panel_Main_Text_C_Title = {
    ID = "UI_Passport_Panel_Main_Text_C_Title",
    Content = "PanelText_UI_Passport_Panel_Main_Text_C_Title_Content|学期课题"
  },
  UI_Dungeons_Panel_Daily_Challenge_Text_C_Record2 = {
    ID = "UI_Dungeons_Panel_Daily_Challenge_Text_C_Record2",
    Content = "PanelText_UI_Dungeons_Panel_Daily_Challenge_Text_C_Record2_Content|本周成绩"
  },
  UI_Dungeons_Panel_Daily_Challenge_Text_C_Reward2 = {
    ID = "UI_Dungeons_Panel_Daily_Challenge_Text_C_Reward2",
    Content = "PanelText_UI_Dungeons_Panel_Daily_Challenge_Text_C_Reward2_Content|深潜纪录"
  },
  UI_Common_Item_WuPin_Type2_Text_C_Tab_Nor = {
    ID = "UI_Common_Item_WuPin_Type2_Text_C_Tab_Nor",
    Content = "PanelText_UI_Common_Item_WuPin_Type2_Text_C_Tab_Nor_Content|额外"
  },
  UI_Common_Item_WuPin_Type2_Text_C_Tab_Double = {
    ID = "UI_Common_Item_WuPin_Type2_Text_C_Tab_Double",
    Content = "PanelText_UI_Common_Item_WuPin_Type2_Text_C_Tab_Double_Content|双倍"
  },
  UI_Pvp_Item_Out_Obtain_Text_C_Tab_Double = {
    ID = "UI_Pvp_Item_Out_Obtain_Text_C_Tab_Double",
    Content = "PanelText_UI_Pvp_Item_Out_Obtain_Text_C_Tab_Double_Content|福利双倍"
  },
  UI_Pvp_Item_Out_Obtain_Text_C_Tab_Topic = {
    ID = "UI_Pvp_Item_Out_Obtain_Text_C_Tab_Topic",
    Content = "PanelText_UI_Pvp_Item_Out_Obtain_Text_C_Tab_Topic_Content|课题特权"
  },
  UI_Dungeous_Item_Popup_Award2_Text_C_Title = {
    ID = "UI_Dungeous_Item_Popup_Award2_Text_C_Title",
    Content = "PanelText_UI_Dungeous_Item_Popup_Award2_Text_C_Title_Content|本关星级数目达"
  },
  UI_Dungeous_Item_Popup_Award2_Text_C_Title2 = {
    ID = "UI_Dungeous_Item_Popup_Award2_Text_C_Title2",
    Content = "PanelText_UI_Dungeous_Item_Popup_Award2_Text_C_Title2_Content|分数累计至"
  },
  UI_Dungeous_Item_Popup_Award2_Text_C_Lost = {
    ID = "UI_Dungeous_Item_Popup_Award2_Text_C_Lost",
    Content = "PanelText_UI_Dungeous_Item_Popup_Award2_Text_C_Lost_Content|未达成"
  },
  UI_Passport_Reward_Item_Text_C_Name_2 = {
    ID = "UI_Passport_Reward_Item_Text_C_Name_2",
    Content = "PanelText_UI_Passport_Reward_Item_Text_C_Name_2_Content|购买等级"
  },
  UI_Passport_Task_Item_Text_C_Name_3 = {
    ID = "UI_Passport_Task_Item_Text_C_Name_3",
    Content = "PanelText_UI_Passport_Task_Item_Text_C_Name_3_Content|购买等级"
  },
  UI_Summon_Item_Probability_Text_C_Type = {
    ID = "UI_Summon_Item_Probability_Text_C_Type",
    Content = "PanelText_UI_Summon_Item_Probability_Text_C_Type_Content|类型"
  },
  UI_Summon_Item_Probability_Text_C_Name = {
    ID = "UI_Summon_Item_Probability_Text_C_Name",
    Content = "PanelText_UI_Summon_Item_Probability_Text_C_Name_Content|名称"
  },
  UI_Summon_Item_Probability_Text_C_Role = {
    ID = "UI_Summon_Item_Probability_Text_C_Role",
    Content = "PanelText_UI_Summon_Item_Probability_Text_C_Role_Content|综合概率"
  },
  UI_Summon_Item_Probability_Text_C_Time = {
    ID = "UI_Summon_Item_Probability_Text_C_Time",
    Content = "PanelText_UI_Summon_Item_Probability_Text_C_Time_Content|名称"
  },
  UI_Main_Helicopter_Tips_Text_Name_1 = {
    ID = "UI_Main_Helicopter_Tips_Text_Name_1",
    Content = "PanelText_UI_Main_Helicopter_Tips_Text_Name_1_Content|邀请来客"
  },
  UI_Main_Helicopter_Tips_Text_Name_2 = {
    ID = "UI_Main_Helicopter_Tips_Text_Name_2",
    Content = "PanelText_UI_Main_Helicopter_Tips_Text_Name_2_Content|取消"
  },
  UI_Team_Panel_Main_Text_C_Prohibit = {
    ID = "UI_Team_Panel_Main_Text_C_Prohibit",
    Content = "PanelText_UI_Team_Panel_Main_Text_C_Prohibit_Content|本关禁用钥令"
  },
  UI_Login_Text_C_User = {
    ID = "UI_Login_Text_C_User",
    Content = "PanelText_UI_Login_Text_C_User_Content|用户中心"
  },
  UI_Dungeons_Panel_Daily_Challenge_Text_C_illustrate = {
    ID = "UI_Dungeons_Panel_Daily_Challenge_Text_C_illustrate",
    Content = "PanelText_UI_Dungeons_Panel_Daily_Challenge_Text_C_illustrate_Content|玩法规则"
  },
  UI_Social_Item_Data_Left_Text_C_Society = {
    ID = "UI_Social_Item_Data_Left_Text_C_Society",
    Content = "PanelText_UI_Social_Item_Data_Left_Text_C_Society_Content|所属公会"
  },
  UI_Social_Item_Data_Left_Text_C_Birthday = {
    ID = "UI_Social_Item_Data_Left_Text_C_Birthday",
    Content = "PanelText_UI_Social_Item_Data_Left_Text_C_Birthday_Content|生日"
  },
  UI_Social_Item_Data_Left_Text_C_Awaker = {
    ID = "UI_Social_Item_Data_Left_Text_C_Awaker",
    Content = "PanelText_UI_Social_Item_Data_Left_Text_C_Awaker_Content|链接唤醒体"
  },
  UI_Social_Item_Data_Left_Text_C_Conclude = {
    ID = "UI_Social_Item_Data_Left_Text_C_Conclude",
    Content = "PanelText_UI_Social_Item_Data_Left_Text_C_Conclude_Content|达成成就"
  },
  UI_Social_Item_Data_Left_Text_C_Register = {
    ID = "UI_Social_Item_Data_Left_Text_C_Register",
    Content = "PanelText_UI_Social_Item_Data_Left_Text_C_Register_Content|登录天数"
  },
  UI_Social_Item_Data_Left_Text_C_Assist = {
    ID = "UI_Social_Item_Data_Left_Text_C_Assist",
    Content = "PanelText_UI_Social_Item_Data_Left_Text_C_Assist_Content|助战次数"
  },
  UI_Social_Item_Data_Left_Text_C_Lv_2 = {
    ID = "UI_Social_Item_Data_Left_Text_C_Lv_2",
    Content = "PanelText_UI_Social_Item_Data_Left_Text_C_Lv_2_Content|Lv."
  },
  UI_Social_Item_Data_Left_Text_C_Fans = {
    ID = "UI_Social_Item_Data_Left_Text_C_Fans",
    Content = "PanelText_UI_Social_Item_Data_Left_Text_C_Fans_Content|追随者"
  },
  UI_Social_Item_Data_Left_Text_C_Concern2 = {
    ID = "UI_Social_Item_Data_Left_Text_C_Concern2",
    Content = "PanelText_UI_Social_Item_Data_Left_Text_C_Concern2_Content|关注"
  },
  UI_Social_Item_Data_Left_Text_C_Survey = {
    ID = "UI_Social_Item_Data_Left_Text_C_Survey",
    Content = "PanelText_UI_Social_Item_Data_Left_Text_C_Survey_Content|调查状况"
  },
  UI_Social_Item_Data_Left_Text_C_Difficulty = {
    ID = "UI_Social_Item_Data_Left_Text_C_Difficulty",
    Content = "PanelText_UI_Social_Item_Data_Left_Text_C_Difficulty_Content|调查行动"
  },
  UI_Social_Item_Data_Left_Text_C_Dream = {
    ID = "UI_Social_Item_Data_Left_Text_C_Dream",
    Content = "PanelText_UI_Social_Item_Data_Left_Text_C_Dream_Content|幻梦深潜"
  },
  UI_Social_Item_Data_Left_Text_C_Highest = {
    ID = "UI_Social_Item_Data_Left_Text_C_Highest",
    Content = "PanelText_UI_Social_Item_Data_Left_Text_C_Highest_Content|最高纪录"
  },
  UI_Social_Item_Data_Left_Text_C_Pagoda = {
    ID = "UI_Social_Item_Data_Left_Text_C_Pagoda",
    Content = "PanelText_UI_Social_Item_Data_Left_Text_C_Pagoda_Content|无光之境"
  },
  UI_Social_Item_Data_Left_Text_C_Indestructible = {
    ID = "UI_Social_Item_Data_Left_Text_C_Indestructible",
    Content = "PanelText_UI_Social_Item_Data_Left_Text_C_Indestructible_Content|无光之境·轮转间隙"
  },
  UI_Social_Item_Data_Left_Text_C_Privacy = {
    ID = "UI_Social_Item_Data_Left_Text_C_Privacy",
    Content = "PanelText_UI_Social_Item_Data_Left_Text_C_Privacy_Content|守密人已设置调查状况为隐私"
  },
  UI_Social_Item_Data_Right_Text_C_Squiggle = {
    ID = "UI_Social_Item_Data_Right_Text_C_Squiggle",
    Content = "PanelText_UI_Social_Item_Data_Right_Text_C_Squiggle_Content|Silver begets knowledge."
  },
  UI_Social_Item_Data_Right_Text_C_Not = {
    ID = "UI_Social_Item_Data_Right_Text_C_Not",
    Content = "PanelText_UI_Social_Item_Data_Right_Text_C_Not_Content|未设置助战唤醒体"
  },
  UI_Social_Item_Data_Right_Text_C_Lv_1 = {
    ID = "UI_Social_Item_Data_Right_Text_C_Lv_1",
    Content = "PanelText_UI_Social_Item_Data_Right_Text_C_Lv_1_Content|Lv."
  },
  UI_Social_Item_Data_Right_Text_C_Help = {
    ID = "UI_Social_Item_Data_Right_Text_C_Help",
    Content = "PanelText_UI_Social_Item_Data_Right_Text_C_Help_Content|助战唤醒体"
  },
  UI_Social_Item_Data_Right_Text_C_Team = {
    ID = "UI_Social_Item_Data_Right_Text_C_Team",
    Content = "PanelText_UI_Social_Item_Data_Right_Text_C_Team_Content|唤醒体展示"
  },
  UI_Social_Item_Data_Right_Text_C_Null_1 = {
    ID = "UI_Social_Item_Data_Right_Text_C_Null_1",
    Content = "PanelText_UI_Social_Item_Data_Right_Text_C_Null_1_Content|未展示唤醒体"
  },
  UI_Social_Item_Data_Right_Text_C_Concern = {
    ID = "UI_Social_Item_Data_Right_Text_C_Concern",
    Content = "PanelText_UI_Social_Item_Data_Right_Text_C_Concern_Content|UID"
  },
  UI_Awaker_Popup_Topped_Tip2_Text_C_Now = {
    ID = "UI_Awaker_Popup_Topped_Tip2_Text_C_Now",
    Content = "PanelText_UI_Awaker_Popup_Topped_Tip2_Text_C_Now_Content|当前"
  },
  UI_Awaker_Popup_Topped_Tip2_Text_C_Screening = {
    ID = "UI_Awaker_Popup_Topped_Tip2_Text_C_Screening",
    Content = "PanelText_UI_Awaker_Popup_Topped_Tip2_Text_C_Screening_Content|奖励已领取"
  },
  UI_Pvp_Team_Main_Text_C_Name_1 = {
    ID = "UI_Pvp_Team_Main_Text_C_Name_1",
    Content = "PanelText_UI_Pvp_Team_Main_Text_C_Name_1_Content|装备钥令"
  },
  UI_Pvp_Team_Main_Text_C_Name_2 = {
    ID = "UI_Pvp_Team_Main_Text_C_Name_2",
    Content = "PanelText_UI_Pvp_Team_Main_Text_C_Name_2_Content|4号位唤醒体"
  },
  UI_Pvp_Team_Main_Text_C_Name_3 = {
    ID = "UI_Pvp_Team_Main_Text_C_Name_3",
    Content = "PanelText_UI_Pvp_Team_Main_Text_C_Name_3_Content|3号位唤醒体"
  },
  UI_Pvp_Team_Main_Text_C_Name_4 = {
    ID = "UI_Pvp_Team_Main_Text_C_Name_4",
    Content = "PanelText_UI_Pvp_Team_Main_Text_C_Name_4_Content|2号位唤醒体"
  },
  UI_Pvp_Team_Main_Text_C_Name_5 = {
    ID = "UI_Pvp_Team_Main_Text_C_Name_5",
    Content = "PanelText_UI_Pvp_Team_Main_Text_C_Name_5_Content|1号位唤醒体"
  },
  UI_Pvp_Team_Main_Text_C_Name_6 = {
    ID = "UI_Pvp_Team_Main_Text_C_Name_6",
    Content = "PanelText_UI_Pvp_Team_Main_Text_C_Name_6_Content|装备钥令"
  },
  UI_Pvp_Team_Main_Text_C_Name_7 = {
    ID = "UI_Pvp_Team_Main_Text_C_Name_7",
    Content = "PanelText_UI_Pvp_Team_Main_Text_C_Name_7_Content|装备命轮"
  },
  UI_Pvp_Team_Main_Text_C_Name_8 = {
    ID = "UI_Pvp_Team_Main_Text_C_Name_8",
    Content = "PanelText_UI_Pvp_Team_Main_Text_C_Name_8_Content|装备命轮"
  },
  UI_Pvp_Team_Main_Text_C_Name_9 = {
    ID = "UI_Pvp_Team_Main_Text_C_Name_9",
    Content = "PanelText_UI_Pvp_Team_Main_Text_C_Name_9_Content|装备命轮"
  },
  UI_Pvp_Team_Main_Text_C_Name_10 = {
    ID = "UI_Pvp_Team_Main_Text_C_Name_10",
    Content = "PanelText_UI_Pvp_Team_Main_Text_C_Name_10_Content|装备命轮"
  },
  UI_Recharge_Exchange_Tips_Text_C_Not = {
    ID = "UI_Recharge_Exchange_Tips_Text_C_Not",
    Content = "PanelText_UI_Recharge_Exchange_Tips_Text_C_Not_Content|货币不足"
  },
  UI_Events_Popup_Optional_Text_C_Name_1 = {
    ID = "UI_Events_Popup_Optional_Text_C_Name_1",
    Content = "PanelText_UI_Events_Popup_Optional_Text_C_Name_1_Content|查看详情"
  },
  UI_Events_Popup_Optional_Text_C_Name_2 = {
    ID = "UI_Events_Popup_Optional_Text_C_Name_2",
    Content = "PanelText_UI_Events_Popup_Optional_Text_C_Name_2_Content|领取"
  },
  UI_Awaker_Panel_Main_Text_C_Ordinary_1 = {
    ID = "UI_Awaker_Panel_Main_Text_C_Ordinary_1",
    Content = "PanelText_UI_Awaker_Panel_Main_Text_C_Ordinary_1_Content|普通形态"
  },
  UI_Awaker_Panel_Main_Text_C_Origin_1 = {
    ID = "UI_Awaker_Panel_Main_Text_C_Origin_1",
    Content = "PanelText_UI_Awaker_Panel_Main_Text_C_Origin_1_Content|本源形态"
  },
  UI_Awaker_Panel_Main_Text_C_Ordinary_2 = {
    ID = "UI_Awaker_Panel_Main_Text_C_Ordinary_2",
    Content = "PanelText_UI_Awaker_Panel_Main_Text_C_Ordinary_2_Content|普通形态"
  },
  UI_Awaker_Panel_Main_Text_C_Origin_2 = {
    ID = "UI_Awaker_Panel_Main_Text_C_Origin_2",
    Content = "PanelText_UI_Awaker_Panel_Main_Text_C_Origin_2_Content|本源形态"
  },
  UI_Awaker_Panel_Main_Text_C_Ordinary_3 = {
    ID = "UI_Awaker_Panel_Main_Text_C_Ordinary_3",
    Content = "PanelText_UI_Awaker_Panel_Main_Text_C_Ordinary_3_Content|普通形态"
  },
  UI_Awaker_Panel_Main_Text_C_Origin_3 = {
    ID = "UI_Awaker_Panel_Main_Text_C_Origin_3",
    Content = "PanelText_UI_Awaker_Panel_Main_Text_C_Origin_3_Content|本源形态"
  },
  UI_Awaker_Panel_Weapon_Main_Text_C_Contrast = {
    ID = "UI_Awaker_Panel_Weapon_Main_Text_C_Contrast",
    Content = "PanelText_UI_Awaker_Panel_Weapon_Main_Text_C_Contrast_Content|对比"
  },
  UI_Awaker_Item_Origin_Tip_Text_C_Title = {
    ID = "UI_Awaker_Item_Origin_Tip_Text_C_Title",
    Content = "PanelText_UI_Awaker_Item_Origin_Tip_Text_C_Title_Content|解锁本源确认"
  },
  UI_Awaker_Item_Origin_Tip_Text_C_Consume = {
    ID = "UI_Awaker_Item_Origin_Tip_Text_C_Consume",
    Content = "PanelText_UI_Awaker_Item_Origin_Tip_Text_C_Consume_Content|解锁本源形态需要消耗以下道具，是否确认？"
  },
  UI_Social_Popup_Situation_Tips_Text_C_AffixInfo = {
    ID = "UI_Social_Popup_Situation_Tips_Text_C_AffixInfo",
    Content = "PanelText_UI_Social_Popup_Situation_Tips_Text_C_AffixInfo_Content|调查状况"
  },
  UI_Summon_Popup_Show_Rare_Text_C_Name = {
    ID = "UI_Summon_Popup_Show_Rare_Text_C_Name",
    Content = "PanelText_UI_Summon_Popup_Show_Rare_Text_C_Name_Content|唤醒一次"
  },
  UI_Summon_Popup_Show_Ordinary_Text_C_Name = {
    ID = "UI_Summon_Popup_Show_Ordinary_Text_C_Name",
    Content = "PanelText_UI_Summon_Popup_Show_Ordinary_Text_C_Name_Content|唤醒一次"
  },
  UI_Summon_Popup_Show_Legend_Text_C_Name = {
    ID = "UI_Summon_Popup_Show_Legend_Text_C_Name",
    Content = "PanelText_UI_Summon_Popup_Show_Legend_Text_C_Name_Content|唤醒一次"
  },
  UI_Summon_Result_Panel_Text_C_Name = {
    ID = "UI_Summon_Result_Panel_Text_C_Name",
    Content = "PanelText_UI_Summon_Result_Panel_Text_C_Name_Content|唤醒一次"
  },
  UI_Social_Panel_HelpList_Text_C_Mail = {
    ID = "UI_Social_Panel_HelpList_Text_C_Mail",
    Content = "PanelText_UI_Social_Panel_HelpList_Text_C_Mail_Content|规则说明"
  },
  UI_Social_Panel_HelpList_Text_C_Confim_Nor = {
    ID = "UI_Social_Panel_HelpList_Text_C_Confim_Nor",
    Content = "PanelText_UI_Social_Panel_HelpList_Text_C_Confim_Nor_Content|上场"
  },
  UI_Social_Panel_HelpList_Text_C_Confim_Dis = {
    ID = "UI_Social_Panel_HelpList_Text_C_Confim_Dis",
    Content = "PanelText_UI_Social_Panel_HelpList_Text_C_Confim_Dis_Content|上场"
  },
  UI_Social_Panel_HelpList_Text_C_Confim_Nor_1 = {
    ID = "UI_Social_Panel_HelpList_Text_C_Confim_Nor_1",
    Content = "PanelText_UI_Social_Panel_HelpList_Text_C_Confim_Nor_1_Content|刷新"
  },
  UI_Social_Panel_HelpList_Text_C_Confim_Dis_1 = {
    ID = "UI_Social_Panel_HelpList_Text_C_Confim_Dis_1",
    Content = "PanelText_UI_Social_Panel_HelpList_Text_C_Confim_Dis_1_Content|刷新"
  },
  UI_Awaker_Item_Origin_Tip_Text_C_Name_1 = {
    ID = "UI_Awaker_Item_Origin_Tip_Text_C_Name_1",
    Content = "PanelText_UI_Awaker_Item_Origin_Tip_Text_C_Name_1_Content|取消"
  },
  UI_Awaker_Item_Origin_Tip_Text_C_Name_2 = {
    ID = "UI_Awaker_Item_Origin_Tip_Text_C_Name_2",
    Content = "PanelText_UI_Awaker_Item_Origin_Tip_Text_C_Name_2_Content|确定"
  },
  UI_Social_Panel_HelpList_Item_Text_C_Lv = {
    ID = "UI_Social_Panel_HelpList_Item_Text_C_Lv",
    Content = "PanelText_UI_Social_Panel_HelpList_Item_Text_C_Lv_Content|Lv."
  },
  UI_Social_Panel_HelpList_Item_Text_C_Fans = {
    ID = "UI_Social_Panel_HelpList_Item_Text_C_Fans",
    Content = "PanelText_UI_Social_Panel_HelpList_Item_Text_C_Fans_Content|追随者"
  },
  UI_Social_Panel_HelpList_Item_Text_C_Attention = {
    ID = "UI_Social_Panel_HelpList_Item_Text_C_Attention",
    Content = "PanelText_UI_Social_Panel_HelpList_Item_Text_C_Attention_Content|关注"
  },
  ["UI_Social_Panel_HelpList_Item_Text_C_ Interrelated"] = {
    ID = "UI_Social_Panel_HelpList_Item_Text_C_ Interrelated",
    Content = "PanelText_UI_Social_Panel_HelpList_Item_Text_C_ Interrelated_Content|互相关注"
  },
  UI_Social_Item_Avatar_Text_C_Lv = {
    ID = "UI_Social_Item_Avatar_Text_C_Lv",
    Content = "PanelText_UI_Social_Item_Avatar_Text_C_Lv_Content|Lv."
  },
  UI_Social_Panel_HelpList_Item_Text_C_Following = {
    ID = "UI_Social_Panel_HelpList_Item_Text_C_Following",
    Content = "PanelText_UI_Social_Panel_HelpList_Item_Text_C_Following_Content|已关注"
  },
  UI_Social_Panel_HelpList_Item_Text_C_Conflict = {
    ID = "UI_Social_Panel_HelpList_Item_Text_C_Conflict",
    Content = "PanelText_UI_Social_Panel_HelpList_Item_Text_C_Conflict_Content|界域冲突"
  },
  UI_Common_Popup_Tips_Confirm_S_Text_C_Month = {
    ID = "UI_Common_Popup_Tips_Confirm_S_Text_C_Month",
    Content = "PanelText_UI_Common_Popup_Tips_Confirm_S_Text_C_Month_Content|月"
  },
  UI_Common_Popup_Tips_Confirm_S_Text_C_Day = {
    ID = "UI_Common_Popup_Tips_Confirm_S_Text_C_Day",
    Content = "PanelText_UI_Common_Popup_Tips_Confirm_S_Text_C_Day_Content|日"
  },
  UI_Team_Panel_Main_Text_C_Name_1 = {
    ID = "UI_Team_Panel_Main_Text_C_Name_1",
    Content = "PanelText_UI_Team_Panel_Main_Text_C_Name_1_Content|解除"
  },
  UI_Team_Panel_Main_Text_C_Name_2 = {
    ID = "UI_Team_Panel_Main_Text_C_Name_2",
    Content = "PanelText_UI_Team_Panel_Main_Text_C_Name_2_Content|助战"
  },
  UI_Team_Panel_Main_Text_C_Tips_1 = {
    ID = "UI_Team_Panel_Main_Text_C_Tips_1",
    Content = "PanelText_UI_Team_Panel_Main_Text_C_Tips_1_Content|助战"
  },
  UI_Team_Panel_Main_Text_C_Tips_2 = {
    ID = "UI_Team_Panel_Main_Text_C_Tips_2",
    Content = "PanelText_UI_Team_Panel_Main_Text_C_Tips_2_Content|助战"
  },
  UI_Social_Item_Data_Overview_Left_Text_C_Society = {
    ID = "UI_Social_Item_Data_Overview_Left_Text_C_Society",
    Content = "PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Society_Content|所属公会"
  },
  UI_Social_Item_Data_Overview_Left_Text_C_Notset = {
    ID = "UI_Social_Item_Data_Overview_Left_Text_C_Notset",
    Content = "PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Notset_Content|未设置"
  },
  UI_Social_Item_Data_Overview_Left_Text_C_Birthday = {
    ID = "UI_Social_Item_Data_Overview_Left_Text_C_Birthday",
    Content = "PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Birthday_Content|生日"
  },
  UI_Social_Item_Data_Overview_Left_Text_C_Awaker = {
    ID = "UI_Social_Item_Data_Overview_Left_Text_C_Awaker",
    Content = "PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Awaker_Content|链接唤醒体"
  },
  UI_Social_Item_Data_Overview_Left_Text_C_Conclude = {
    ID = "UI_Social_Item_Data_Overview_Left_Text_C_Conclude",
    Content = "PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Conclude_Content|达成成就"
  },
  UI_Social_Item_Data_Overview_Left_Text_C_Register = {
    ID = "UI_Social_Item_Data_Overview_Left_Text_C_Register",
    Content = "PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Register_Content|登录天数"
  },
  UI_Social_Item_Data_Overview_Left_Text_C_Assist = {
    ID = "UI_Social_Item_Data_Overview_Left_Text_C_Assist",
    Content = "PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Assist_Content|助战次数"
  },
  UI_Social_Item_Data_Overview_Left_Text_C_Lv_2 = {
    ID = "UI_Social_Item_Data_Overview_Left_Text_C_Lv_2",
    Content = "PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Lv_2_Content|Lv."
  },
  UI_Social_Item_Data_Overview_Left_Text_C_Fans = {
    ID = "UI_Social_Item_Data_Overview_Left_Text_C_Fans",
    Content = "PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Fans_Content|追随者"
  },
  UI_Social_Item_Data_Overview_Left_Text_C_Concern2 = {
    ID = "UI_Social_Item_Data_Overview_Left_Text_C_Concern2",
    Content = "PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Concern2_Content|关注"
  },
  UI_Social_Item_Data_Overview_Left_Text_C_Attention = {
    ID = "UI_Social_Item_Data_Overview_Left_Text_C_Attention",
    Content = "PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Attention_Content|关注"
  },
  UI_Social_Item_Data_Overview_Left_Text_C_Interrelated = {
    ID = "UI_Social_Item_Data_Overview_Left_Text_C_Interrelated",
    Content = "PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Interrelated_Content|互相关注"
  },
  UI_Social_Item_Data_Overview_Left_Text_C_Survey = {
    ID = "UI_Social_Item_Data_Overview_Left_Text_C_Survey",
    Content = "PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Survey_Content|调查状况"
  },
  UI_Social_Item_Data_Overview_Left_Text_C_Difficulty = {
    ID = "UI_Social_Item_Data_Overview_Left_Text_C_Difficulty",
    Content = "PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Difficulty_Content|调查行动"
  },
  UI_Social_Item_Data_Overview_Left_Text_C_Dream = {
    ID = "UI_Social_Item_Data_Overview_Left_Text_C_Dream",
    Content = "PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Dream_Content|幻梦深潜"
  },
  UI_Social_Item_Data_Overview_Left_Text_C_Highest = {
    ID = "UI_Social_Item_Data_Overview_Left_Text_C_Highest",
    Content = "PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Highest_Content|最高纪录"
  },
  UI_Social_Item_Data_Overview_Left_Text_C_Pagoda = {
    ID = "UI_Social_Item_Data_Overview_Left_Text_C_Pagoda",
    Content = "PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Pagoda_Content|无光之境"
  },
  UI_Social_Item_Data_Overview_Left_Text_C_Indestructible = {
    ID = "UI_Social_Item_Data_Overview_Left_Text_C_Indestructible",
    Content = "PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Indestructible_Content|无光之境·轮转间隙"
  },
  UI_Social_Item_Data_Overview_Left_Text_C_Privacy = {
    ID = "UI_Social_Item_Data_Overview_Left_Text_C_Privacy",
    Content = "PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Privacy_Content|守密人已设置调查状况为隐私"
  },
  UI_Social_Popup_PlayerHead_Text_C_Using = {
    ID = "UI_Social_Popup_PlayerHead_Text_C_Using",
    Content = "PanelText_UI_Social_Popup_PlayerHead_Text_C_Using_Content|使用中"
  },
  UI_Social_Panel_Main_Text_C_NoTask = {
    ID = "UI_Social_Panel_Main_Text_C_NoTask",
    Content = "PanelText_UI_Social_Panel_Main_Text_C_NoTask_Content|暂无关注"
  },
  UI_Social_Panel_Main_Text_C_Time = {
    ID = "UI_Social_Panel_Main_Text_C_Time",
    Content = "PanelText_UI_Social_Panel_Main_Text_C_Time_Content|去其他地方看看吧"
  },
  UI_Social_Panel_Main_SubPanel_2_Text_C_NoTask = {
    ID = "UI_Social_Panel_Main_SubPanel_2_Text_C_NoTask",
    Content = "PanelText_UI_Social_Panel_Main_SubPanel_2_Text_C_NoTask_Content|暂无相关搜索"
  },
  UI_Social_Panel_Main_SubPanel_2_Text_C_Time = {
    ID = "UI_Social_Panel_Main_SubPanel_2_Text_C_Time",
    Content = "PanelText_UI_Social_Panel_Main_SubPanel_2_Text_C_Time_Content|去其他地方看看吧"
  },
  UI_Social_Panel_Main_SubPanel_1_Text_C_NoTask = {
    ID = "UI_Social_Panel_Main_SubPanel_1_Text_C_NoTask",
    Content = "PanelText_UI_Social_Panel_Main_SubPanel_1_Text_C_NoTask_Content|暂无关注任何人"
  },
  UI_Social_Panel_Main_SubPanel_1_Text_C_Time = {
    ID = "UI_Social_Panel_Main_SubPanel_1_Text_C_Time",
    Content = "PanelText_UI_Social_Panel_Main_SubPanel_1_Text_C_Time_Content|去其他地方看看吧"
  },
  UI_Pvp_Panel_Match_Text_C_Win = {
    ID = "UI_Pvp_Panel_Match_Text_C_Win",
    Content = "PanelText_UI_Pvp_Panel_Match_Text_C_Win_Content|匹配成功"
  },
  UI_Social_Popup_WatchList_Text_C_NoTask = {
    ID = "UI_Social_Popup_WatchList_Text_C_NoTask",
    Content = "PanelText_UI_Social_Popup_WatchList_Text_C_NoTask_Content|暂无新增追随者"
  },
  UI_Awaker_Item_Weapon_Refining_Text_C_Name_5 = {
    ID = "UI_Awaker_Item_Weapon_Refining_Text_C_Name_5",
    Content = "PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Name_5_Content|下一阶"
  },
  UI_Awaker_Item_Weapon_Refining_Text_C_Name_6 = {
    ID = "UI_Awaker_Item_Weapon_Refining_Text_C_Name_6",
    Content = "PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Name_6_Content|下一阶"
  },
  UI_Story_Popup_Curtain_Call_Text_C_Continue = {
    ID = "UI_Story_Popup_Curtain_Call_Text_C_Continue",
    Content = "PanelText_UI_Story_Popup_Curtain_Call_Text_C_Continue_Content|继续启程"
  },
  UI_Social_Panel_Data_Text_C_Title = {
    ID = "UI_Social_Panel_Data_Text_C_Title",
    Content = "PanelText_UI_Social_Panel_Data_Text_C_Title_Content|守密人档案"
  },
  UI_Social_Panel_Main_Item_Text_C_Attention = {
    ID = "UI_Social_Panel_Main_Item_Text_C_Attention",
    Content = "PanelText_UI_Social_Panel_Main_Item_Text_C_Attention_Content|关注"
  },
  UI_Social_Panel_Main_Item_Text_C_Interrelated = {
    ID = "UI_Social_Panel_Main_Item_Text_C_Interrelated",
    Content = "PanelText_UI_Social_Panel_Main_Item_Text_C_Interrelated_Content|互相关注"
  },
  UI_Social_Panel_Main_Item_Text_C_Following = {
    ID = "UI_Social_Panel_Main_Item_Text_C_Following",
    Content = "PanelText_UI_Social_Panel_Main_Item_Text_C_Following_Content|已关注"
  },
  UI_Story_Popup_Curtain_Call_Text_C_Title = {
    ID = "UI_Story_Popup_Curtain_Call_Text_C_Title",
    Content = "PanelText_UI_Story_Popup_Curtain_Call_Text_C_Title_Content|记忆归档"
  },
  UI_Events_Panel_Branch_Text_C_Award = {
    ID = "UI_Events_Panel_Branch_Text_C_Award",
    Content = "PanelText_UI_Events_Panel_Branch_Text_C_Award_Content|限时奖励"
  },
  UI_Events_Panel_Branch_Text_C_Limit = {
    ID = "UI_Events_Panel_Branch_Text_C_Limit",
    Content = "PanelText_UI_Events_Panel_Branch_Text_C_Limit_Content|调查奖励"
  },
  UI_Events_Panel_Branch_Text_C_Pass = {
    ID = "UI_Events_Panel_Branch_Text_C_Pass",
    Content = "PanelText_UI_Events_Panel_Branch_Text_C_Pass_Content|通关奖励"
  },
  UI_Dungeous_Item_Ranking_Text_C_Null = {
    ID = "UI_Dungeous_Item_Ranking_Text_C_Null",
    Content = "PanelText_UI_Dungeous_Item_Ranking_Text_C_Null_Content|暂无编队"
  },
  UI_Dungeous_Item_Ranking_Text_C_Underway = {
    ID = "UI_Dungeous_Item_Ranking_Text_C_Underway",
    Content = "PanelText_UI_Dungeous_Item_Ranking_Text_C_Underway_Content|战斗数据通讯中"
  },
  UI_Social_Panel_HelpList_Text_C_Title = {
    ID = "UI_Social_Panel_HelpList_Text_C_Title",
    Content = "PanelText_UI_Social_Panel_HelpList_Text_C_Title_Content|选择助战"
  },
  UI_Dungeous_Panel_SecEntrance_Text_C_Additional = {
    ID = "UI_Dungeous_Panel_SecEntrance_Text_C_Additional",
    Content = "PanelText_UI_Dungeous_Panel_SecEntrance_Text_C_Additional_Content|今日奖励额外+50% 不限次"
  },
  UI_Dungeons_Item_Common_Element_Text_C_Award = {
    ID = "UI_Dungeons_Item_Common_Element_Text_C_Award",
    Content = "PanelText_UI_Dungeons_Item_Common_Element_Text_C_Award_Content|奖励+100%"
  },
  UI_Dungeous_Panel_BossSel1_Text_C_Additional = {
    ID = "UI_Dungeous_Panel_BossSel1_Text_C_Additional",
    Content = "PanelText_UI_Dungeous_Panel_BossSel1_Text_C_Additional_Content|今日奖励额外+50% 不限次"
  },
  UI_Common_Item_Hint_Text_C_Recommend = {
    ID = "UI_Common_Item_Hint_Text_C_Recommend",
    Content = "PanelText_UI_Common_Item_Hint_Text_C_Recommend_Content|今日推荐"
  },
  UI_Chapter_Panel_Spur_Text_C_Simple_Now = {
    ID = "UI_Chapter_Panel_Spur_Text_C_Simple_Now",
    Content = "PanelText_UI_Chapter_Panel_Spur_Text_C_Simple_Now_Content|普通"
  },
  UI_Chapter_Panel_Spur_Text_C_Difficulty_Now = {
    ID = "UI_Chapter_Panel_Spur_Text_C_Difficulty_Now",
    Content = "PanelText_UI_Chapter_Panel_Spur_Text_C_Difficulty_Now_Content|困难"
  },
  UI_Chapter_Panel_Spur_Text_C_Nightmare_Now = {
    ID = "UI_Chapter_Panel_Spur_Text_C_Nightmare_Now",
    Content = "PanelText_UI_Chapter_Panel_Spur_Text_C_Nightmare_Now_Content|癫狂"
  },
  UI_Team_Panel_Main_Popup_Team_Text_C_AffixInfo = {
    ID = "UI_Team_Panel_Main_Popup_Team_Text_C_AffixInfo",
    Content = "PanelText_UI_Team_Panel_Main_Popup_Team_Text_C_AffixInfo_Content|队伍信息"
  },
  UI_Social_Item_Data_Overview_Left_Text_C_Total_1 = {
    ID = "UI_Social_Item_Data_Overview_Left_Text_C_Total_1",
    Content = "PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Total_1_Content|总计"
  },
  UI_Social_Item_Data_Overview_Left_Text_C_Total_2 = {
    ID = "UI_Social_Item_Data_Overview_Left_Text_C_Total_2",
    Content = "PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Total_2_Content|最高记录"
  },
  UI_Awaker_Popup_Potential_Text_C_Name = {
    ID = "UI_Awaker_Popup_Potential_Text_C_Name",
    Content = "PanelText_UI_Awaker_Popup_Potential_Text_C_Name_Content|灵知深化"
  },
  UI_Awaker_Popup_Potential_Text_C_Coin_Count = {
    ID = "UI_Awaker_Popup_Potential_Text_C_Coin_Count",
    Content = "PanelText_UI_Awaker_Popup_Potential_Text_C_Coin_Count_Content|需要"
  },
  UI_Awaker_Popup_Potential_Text_C_Title = {
    ID = "UI_Awaker_Popup_Potential_Text_C_Title",
    Content = "PanelText_UI_Awaker_Popup_Potential_Text_C_Title_Content|等级上限提升"
  },
  UI_Awaker_Popup_Potential_Text_C_Material = {
    ID = "UI_Awaker_Popup_Potential_Text_C_Material",
    Content = "PanelText_UI_Awaker_Popup_Potential_Text_C_Material_Content|消耗材料"
  },
  UI_Dungeous_Popup_Team_Tip_Text_C_Title = {
    ID = "UI_Dungeous_Popup_Team_Tip_Text_C_Title",
    Content = "PanelText_UI_Dungeous_Popup_Team_Tip_Text_C_Title_Content|挑战队伍"
  },
  UI_Dungeous_Popup_Tips_New_Text_C_OneKey = {
    ID = "UI_Dungeous_Popup_Tips_New_Text_C_OneKey",
    Content = "PanelText_UI_Dungeous_Popup_Tips_New_Text_C_OneKey_Content|一键领取"
  },
  UI_Dungeous_Popup_Team_Tip_Text_C_NoTask = {
    ID = "UI_Dungeous_Popup_Team_Tip_Text_C_NoTask",
    Content = "PanelText_UI_Dungeous_Popup_Team_Tip_Text_C_NoTask_Content|暂无记录"
  },
  UI_Dungeous_Popup_Team_Tip_Text_C_Difficulty = {
    ID = "UI_Dungeous_Popup_Team_Tip_Text_C_Difficulty",
    Content = "PanelText_UI_Dungeous_Popup_Team_Tip_Text_C_Difficulty_Content|重置"
  },
  UI_Dungeous_Popup_Awaker_List_Text_C_Hint_1 = {
    ID = "UI_Dungeous_Popup_Awaker_List_Text_C_Hint_1",
    Content = "PanelText_UI_Dungeous_Popup_Awaker_List_Text_C_Hint_1_Content|暂未选择命轮"
  },
  UI_Dungeous_Popup_Awaker_List_Text_C_Hint_2 = {
    ID = "UI_Dungeous_Popup_Awaker_List_Text_C_Hint_2",
    Content = "PanelText_UI_Dungeous_Popup_Awaker_List_Text_C_Hint_2_Content|点击左侧进行选择"
  },
  UI_Dungeous_Panel_Melt_Erosion_Text_C_Weekly = {
    ID = "UI_Dungeous_Panel_Melt_Erosion_Text_C_Weekly",
    Content = "PanelText_UI_Dungeous_Panel_Melt_Erosion_Text_C_Weekly_Content|特训奖励"
  },
  UI_Dungeous_Panel_Melt_Erosion_Text_C_Hint = {
    ID = "UI_Dungeous_Panel_Melt_Erosion_Text_C_Hint",
    Content = "PanelText_UI_Dungeous_Panel_Melt_Erosion_Text_C_Hint_Content|*通关后，本次出战的唤醒体、命轮和钥令将无法在其他融灾禁区中上场。"
  },
  UI_Dungeons_Item_Level_Content_Text_C_Undone = {
    ID = "UI_Dungeons_Item_Level_Content_Text_C_Undone",
    Content = "PanelText_UI_Dungeons_Item_Level_Content_Text_C_Undone_Content|未完成挑战"
  },
  UI_Dungeons_Item_Level_Content_Text_C_Name = {
    ID = "UI_Dungeons_Item_Level_Content_Text_C_Name",
    Content = "PanelText_UI_Dungeons_Item_Level_Content_Text_C_Name_Content|重置"
  },
  UI_Team_Item_Awaker_List_Text_C_Lv_Dissolution = {
    ID = "UI_Team_Item_Awaker_List_Text_C_Lv_Dissolution",
    Content = "PanelText_UI_Team_Item_Awaker_List_Text_C_Lv_Dissolution_Content|Lv."
  },
  UI_Team_Item_Awaker_List_Text_C_Help = {
    ID = "UI_Team_Item_Awaker_List_Text_C_Help",
    Content = "PanelText_UI_Team_Item_Awaker_List_Text_C_Help_Content|助战唤醒体"
  },
  UI_Team_Panel_Main_Text_C_Hint = {
    ID = "UI_Team_Panel_Main_Text_C_Hint",
    Content = "PanelText_UI_Team_Panel_Main_Text_C_Hint_Content|*通关后，本次出战的唤醒体、命轮和钥令将无法在其他融灾禁区中上场。"
  },
  UI_Battle_ShenHai_Switch_Text_C_Title = {
    ID = "UI_Battle_ShenHai_Switch_Text_C_Title",
    Content = "PanelText_UI_Battle_ShenHai_Switch_Text_C_Title_Content|请选择触腕姿态"
  },
  UI_Battle_ShenHai_Switch_Text_C_Name = {
    ID = "UI_Battle_ShenHai_Switch_Text_C_Name",
    Content = "PanelText_UI_Battle_ShenHai_Switch_Text_C_Name_Content|战斗"
  },
  UI_Battle_ShenHai_Switch_Text_C_Activate = {
    ID = "UI_Battle_ShenHai_Switch_Text_C_Activate",
    Content = "PanelText_UI_Battle_ShenHai_Switch_Text_C_Activate_Content|当前指令"
  },
  UI_Battle_ShenHai_Switch_Text_C_Defense = {
    ID = "UI_Battle_ShenHai_Switch_Text_C_Defense",
    Content = "PanelText_UI_Battle_ShenHai_Switch_Text_C_Defense_Content|防御"
  },
  UI_Battle_ShenHai_Switch_Text_C_Disable_1 = {
    ID = "UI_Battle_ShenHai_Switch_Text_C_Disable_1",
    Content = "PanelText_UI_Battle_ShenHai_Switch_Text_C_Disable_1_Content|无法选择"
  },
  UI_Battle_ShenHai_Switch_Text_C_Disable_2 = {
    ID = "UI_Battle_ShenHai_Switch_Text_C_Disable_2",
    Content = "PanelText_UI_Battle_ShenHai_Switch_Text_C_Disable_2_Content|无法选择"
  },
  UI_Awaker_Popup_Preview_Tip_Text_C_Title = {
    ID = "UI_Awaker_Popup_Preview_Tip_Text_C_Title",
    Content = "PanelText_UI_Awaker_Popup_Preview_Tip_Text_C_Title_Content|返还预览"
  },
  UI_Awaker_Popup_Preview_Tip_Text_C_Preview = {
    ID = "UI_Awaker_Popup_Preview_Tip_Text_C_Preview",
    Content = "PanelText_UI_Awaker_Popup_Preview_Tip_Text_C_Preview_Content|回溯后可获得以下材料"
  },
  UI_Awaker_Popup_Backtrace_Tip_Text_C_Title = {
    ID = "UI_Awaker_Popup_Backtrace_Tip_Text_C_Title",
    Content = "PanelText_UI_Awaker_Popup_Backtrace_Tip_Text_C_Title_Content|选择开启回溯目标"
  },
  UI_Awaker_Popup_Backtrace_Tip_Text_C_NoTask = {
    ID = "UI_Awaker_Popup_Backtrace_Tip_Text_C_NoTask",
    Content = "PanelText_UI_Awaker_Popup_Backtrace_Tip_Text_C_NoTask_Content|暂无可回溯的物品"
  },
  UI_Awaker_Item_Preview_Text_C_Preview_1 = {
    ID = "UI_Awaker_Item_Preview_Text_C_Preview_1",
    Content = "PanelText_UI_Awaker_Item_Preview_Text_C_Preview_1_Content|返还预览"
  },
  UI_Awaker_Item_Preview_Text_C_Preview_2 = {
    ID = "UI_Awaker_Item_Preview_Text_C_Preview_2",
    Content = "PanelText_UI_Awaker_Item_Preview_Text_C_Preview_2_Content|返还预览"
  },
  UI_Awaker_Item_Preview_Text_C_Preview_3 = {
    ID = "UI_Awaker_Item_Preview_Text_C_Preview_3",
    Content = "PanelText_UI_Awaker_Item_Preview_Text_C_Preview_3_Content|返还预览"
  },
  UI_Bag_Item_Detail_Text_C_Time = {
    ID = "UI_Bag_Item_Detail_Text_C_Time",
    Content = "PanelText_UI_Bag_Item_Detail_Text_C_Time_Content|剩余有效时间"
  },
  UI_Common_Item_WuPin_Type1_Text_C_Expired = {
    ID = "UI_Common_Item_WuPin_Type1_Text_C_Expired",
    Content = "PanelText_UI_Common_Item_WuPin_Type1_Text_C_Expired_Content|已过期"
  },
  UI_Awaker_Popup_Expired_Tip_Text_C_Title = {
    ID = "UI_Awaker_Popup_Expired_Tip_Text_C_Title",
    Content = "PanelText_UI_Awaker_Popup_Expired_Tip_Text_C_Title_Content|物品过期"
  },
  UI_Awaker_Popup_Expired_Tip_Text_C_Expired = {
    ID = "UI_Awaker_Popup_Expired_Tip_Text_C_Expired",
    Content = "PanelText_UI_Awaker_Popup_Expired_Tip_Text_C_Expired_Content|以下物品已过期，将无法使用"
  },
  UI_Awaker_Item_Weapon_Refining_Text_C_Blackpool = {
    ID = "UI_Awaker_Item_Weapon_Refining_Text_C_Blackpool",
    Content = "PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Blackpool_Content|返回预览"
  },
  UI_Awaker_Item_Weapon_Refining_Text_C_Overlay = {
    ID = "UI_Awaker_Item_Weapon_Refining_Text_C_Overlay",
    Content = "PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Overlay_Content|返回预览"
  },
  UI_Awaker_Item_Info_Text_C_Name2 = {
    ID = "UI_Awaker_Item_Info_Text_C_Name2",
    Content = "PanelText_UI_Awaker_Item_Info_Text_C_Name2_Content|Style ."
  },
  UI_Awaker_Item_Info_Text_C_Score = {
    ID = "UI_Awaker_Item_Info_Text_C_Score",
    Content = "PanelText_UI_Awaker_Item_Info_Text_C_Score_Content|Score ."
  },
  UI_Awaker_Item_Info_Text_C_Potential = {
    ID = "UI_Awaker_Item_Info_Text_C_Potential",
    Content = "PanelText_UI_Awaker_Item_Info_Text_C_Potential_Content|灵知深化"
  },
  UI_Dungeous_Panel_Molten_Text_C_Special = {
    ID = "UI_Dungeous_Panel_Molten_Text_C_Special",
    Content = "PanelText_UI_Dungeous_Panel_Molten_Text_C_Special_Content|初始造物"
  },
  UI_Dungeous_Panel_Molten_Text_C_Integral = {
    ID = "UI_Dungeous_Panel_Molten_Text_C_Integral",
    Content = "PanelText_UI_Dungeous_Panel_Molten_Text_C_Integral_Content|通关特训值"
  },
  UI_Dungeous_Panel_Molten_Text_C_LineUp = {
    ID = "UI_Dungeous_Panel_Molten_Text_C_LineUp",
    Content = "PanelText_UI_Dungeous_Panel_Molten_Text_C_LineUp_Content|通关编队"
  },
  UI_Dungeous_Panel_Molten_Text_C_Monster = {
    ID = "UI_Dungeous_Panel_Molten_Text_C_Monster",
    Content = "PanelText_UI_Dungeous_Panel_Molten_Text_C_Monster_Content|怪物预览"
  },
  UI_Dungeous_Panel_Molten_Text_C_Name = {
    ID = "UI_Dungeous_Panel_Molten_Text_C_Name",
    Content = "PanelText_UI_Dungeous_Panel_Molten_Text_C_Name_Content|重置"
  },
  UI_Battle_ShenHai_Switch_Text_C_Frantic = {
    ID = "UI_Battle_ShenHai_Switch_Text_C_Frantic",
    Content = "PanelText_UI_Battle_ShenHai_Switch_Text_C_Frantic_Content|疯狂"
  },
  UI_Events_Panel_MagicStory_Text_C_Record = {
    ID = "UI_Events_Panel_MagicStory_Text_C_Record",
    Content = "PanelText_UI_Events_Panel_MagicStory_Text_C_Record_Content|特遣纪录"
  },
  UI_Events_Panel_MagicStory_Text_C_Challenge = {
    ID = "UI_Events_Panel_MagicStory_Text_C_Challenge",
    Content = "PanelText_UI_Events_Panel_MagicStory_Text_C_Challenge_Content|剧本迷思"
  },
  UI_Events_Panel_MagicStory_Text_C_Reward = {
    ID = "UI_Events_Panel_MagicStory_Text_C_Reward",
    Content = "PanelText_UI_Events_Panel_MagicStory_Text_C_Reward_Content|成就奖励"
  },
  UI_Events_Panel_MagicStory_Text_C_Shop = {
    ID = "UI_Events_Panel_MagicStory_Text_C_Shop",
    Content = "PanelText_UI_Events_Panel_MagicStory_Text_C_Shop_Content|魔法剧本商店"
  },
  UI_Events_Panel_MagicStory_Text_C_Own = {
    ID = "UI_Events_Panel_MagicStory_Text_C_Own",
    Content = "PanelText_UI_Events_Panel_MagicStory_Text_C_Own_Content|当前拥有"
  },
  UI_Events_Panel_MagicStory_Text_C_Resonance = {
    ID = "UI_Events_Panel_MagicStory_Text_C_Resonance",
    Content = "PanelText_UI_Events_Panel_MagicStory_Text_C_Resonance_Content|共鸣:导演密码"
  },
  UI_Events_Panel_MagicStory_Text_C_RecordTip = {
    ID = "UI_Events_Panel_MagicStory_Text_C_RecordTip",
    Content = "PanelText_UI_Events_Panel_MagicStory_Text_C_RecordTip_Content|限时免费解锁"
  },
  UI_Events_Panel_MagicStory_Text_C_ChallengeTip = {
    ID = "UI_Events_Panel_MagicStory_Text_C_ChallengeTip",
    Content = "PanelText_UI_Events_Panel_MagicStory_Text_C_ChallengeTip_Content|玩法限时开放"
  },
  UI_Events_Panel_MagicStory_Text_C_Topic = {
    ID = "UI_Events_Panel_MagicStory_Text_C_Topic",
    Content = "PanelText_UI_Events_Panel_MagicStory_Text_C_Topic_Content|故事的魔法"
  },
  UI_Events_Panel_MagicStory_Text_C_Desc = {
    ID = "UI_Events_Panel_MagicStory_Text_C_Desc",
    Content = "PanelText_UI_Events_Panel_MagicStory_Text_C_Desc_Content|朵尔交待的任务，从来都不简单。\n即便她数次提醒大家「要玩得开心」，可首次带着一群唤醒体出门，守密人怎么能不胆战心惊？\n但，要记得「玩得开心」哦。"
  },
  UI_Team_Panel_Main_Text_C_Frequency = {
    ID = "UI_Team_Panel_Main_Text_C_Frequency",
    Content = "PanelText_UI_Team_Panel_Main_Text_C_Frequency_Content|次数"
  },
  UI_Dungeous_Panel_Melt_Erosion_Text_C_Title = {
    ID = "UI_Dungeous_Panel_Melt_Erosion_Text_C_Title",
    Content = "PanelText_UI_Dungeous_Panel_Melt_Erosion_Text_C_Title_Content|融灾禁区"
  },
  UI_Event_Panel_Challenge_Text_C_Creation = {
    ID = "UI_Event_Panel_Challenge_Text_C_Creation",
    Content = "PanelText_UI_Event_Panel_Challenge_Text_C_Creation_Content|关卡造物"
  },
  UI_Event_Panel_Challenge_Text_C_Double = {
    ID = "UI_Event_Panel_Challenge_Text_C_Double",
    Content = "PanelText_UI_Event_Panel_Challenge_Text_C_Double_Content|双倍挑战"
  },
  UI_Event_Panel_Challenge_Text_C_Resonance = {
    ID = "UI_Event_Panel_Challenge_Text_C_Resonance",
    Content = "PanelText_UI_Event_Panel_Challenge_Text_C_Resonance_Content|共鸣"
  },
  UI_Event_Panel_Challenge_Text_C_Record = {
    ID = "UI_Event_Panel_Challenge_Text_C_Record",
    Content = "PanelText_UI_Event_Panel_Challenge_Text_C_Record_Content|挑战"
  },
  UI_Event_Panel_Challenge_Text_C_MeltErosion = {
    ID = "UI_Event_Panel_Challenge_Text_C_MeltErosion",
    Content = "PanelText_UI_Event_Panel_Challenge_Text_C_MeltErosion_Content|融灾黑潮"
  },
  UI_Event_Panel_Challenge_Text_C_Monster = {
    ID = "UI_Event_Panel_Challenge_Text_C_Monster",
    Content = "PanelText_UI_Event_Panel_Challenge_Text_C_Monster_Content|怪物预览"
  },
  UI_Event_Panel_Challenge_Text_C_FristCreation = {
    ID = "UI_Event_Panel_Challenge_Text_C_FristCreation",
    Content = "PanelText_UI_Event_Panel_Challenge_Text_C_FristCreation_Content|初始造物"
  },
  UI_Event_Panel_Challenge_Text_C_Hint = {
    ID = "UI_Event_Panel_Challenge_Text_C_Hint"
  },
  UI_Event_Panel_Challenge_Text_C_RewardTitle = {
    ID = "UI_Event_Panel_Challenge_Text_C_RewardTitle",
    Content = "PanelText_UI_Event_Panel_Challenge_Text_C_RewardTitle_Content|任务报酬"
  },
  UI_Event_Panel_Challenge_Text_C_Title = {
    ID = "UI_Event_Panel_Challenge_Text_C_Title",
    Content = "PanelText_UI_Event_Panel_Challenge_Text_C_Title_Content|剧本迷思"
  },
  UI_Event_Reward_Item_Text_C_Receive = {
    ID = "UI_Event_Reward_Item_Text_C_Receive",
    Content = "PanelText_UI_Event_Reward_Item_Text_C_Receive_Content|领取"
  },
  UI_Event_Reward_Item_Text_C_Not = {
    ID = "UI_Event_Reward_Item_Text_C_Not",
    Content = "PanelText_UI_Event_Reward_Item_Text_C_Not_Content|未完成"
  },
  UI_Keeper_Skill_Item_Text_C_Current = {
    ID = "UI_Keeper_Skill_Item_Text_C_Current",
    Content = "PanelText_UI_Keeper_Skill_Item_Text_C_Current_Content|当前使用"
  },
  UI_Keeper_Skill_Item_Text_C_Disable = {
    ID = "UI_Keeper_Skill_Item_Text_C_Disable",
    Content = "PanelText_UI_Keeper_Skill_Item_Text_C_Disable_Content|无法使用"
  },
  UI_Awaker_Item_Weapon_Strengthen_Text_C_Backtrack = {
    ID = "UI_Awaker_Item_Weapon_Strengthen_Text_C_Backtrack",
    Content = "PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Backtrack_Content|回溯"
  },
  UI_Awaker_Item_Weapon_Strengthen_Text_C_Backtrack_Click = {
    ID = "UI_Awaker_Item_Weapon_Strengthen_Text_C_Backtrack_Click",
    Content = "PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Backtrack_Click_Content|回溯"
  },
  UI_Dbgcopy_Panel_Main_New_Text_C_Count = {
    ID = "UI_Dbgcopy_Panel_Main_New_Text_C_Count",
    Content = "PanelText_UI_Dbgcopy_Panel_Main_New_Text_C_Count_Content|融灾黑潮"
  },
  UI_Battle_Panel_Dbg_Text_C_Count = {
    ID = "UI_Battle_Panel_Dbg_Text_C_Count",
    Content = "PanelText_UI_Battle_Panel_Dbg_Text_C_Count_Content|融灾黑潮"
  },
  UI_Dungeous_Popup_Team_Tip_Text_C_Skill = {
    ID = "UI_Dungeous_Popup_Team_Tip_Text_C_Skill",
    Content = "PanelText_UI_Dungeous_Popup_Team_Tip_Text_C_Skill_Content|守密人技能"
  },
  UI_Dungeous_Popup_Team_Tip_Text_C_Prohibit = {
    ID = "UI_Dungeous_Popup_Team_Tip_Text_C_Prohibit",
    Content = "PanelText_UI_Dungeous_Popup_Team_Tip_Text_C_Prohibit_Content|本关禁用钥令"
  },
  UI_Dungeons_Item_Common_Tier2_Text_C_Current = {
    ID = "UI_Dungeons_Item_Common_Tier2_Text_C_Current",
    Content = "PanelText_UI_Dungeons_Item_Common_Tier2_Text_C_Current_Content|当前通关"
  },
  UI_Dungeous_Panel_Molten_Text_C_None = {
    ID = "UI_Dungeous_Panel_Molten_Text_C_None",
    Content = "PanelText_UI_Dungeous_Panel_Molten_Text_C_None_Content|尚未完成挑战"
  },
  UI_Dungeons_Panel_Out_Text_C_Integral = {
    ID = "UI_Dungeons_Panel_Out_Text_C_Integral",
    Content = "PanelText_UI_Dungeons_Panel_Out_Text_C_Integral_Content|调查评价"
  },
  UI_Dungeous_Panel_Molten_Text_C_Suppress = {
    ID = "UI_Dungeous_Panel_Molten_Text_C_Suppress",
    Content = "PanelText_UI_Dungeous_Panel_Molten_Text_C_Suppress_Content|融灾黑潮"
  },
  UI_Awaker_Item_Preview_Text_C_TipDesc = {
    ID = "UI_Awaker_Item_Preview_Text_C_TipDesc",
    Content = "PanelText_UI_Awaker_Item_Preview_Text_C_TipDesc_Content|「养成回溯」或「启灵回溯」后，无法再进行「黑池归还」"
  },
  UI_Dungeous_Popup_Awaker_List_Text_C_Title = {
    ID = "UI_Dungeous_Popup_Awaker_List_Text_C_Title",
    Content = "PanelText_UI_Dungeous_Popup_Awaker_List_Text_C_Title_Content|选择命轮"
  },
  UI_Dungeous_Popup_Awaker_List_Text_C_Hint = {
    ID = "UI_Dungeous_Popup_Awaker_List_Text_C_Hint",
    Content = "PanelText_UI_Dungeous_Popup_Awaker_List_Text_C_Hint_Content|*同一个唤醒体只能装备一个SSR命轮"
  },
  UI_Dungeous_Panel_Molten_Text_C_Creation = {
    ID = "UI_Dungeous_Panel_Molten_Text_C_Creation",
    Content = "PanelText_UI_Dungeous_Panel_Molten_Text_C_Creation_Content|关卡造物"
  },
  UI_Awaker_Popup_Backtrace_Tip_Text_C_Name_1 = {
    ID = "UI_Awaker_Popup_Backtrace_Tip_Text_C_Name_1",
    Content = "PanelText_UI_Awaker_Popup_Backtrace_Tip_Text_C_Name_1_Content|查看详情"
  },
  UI_Awaker_Popup_Backtrace_Tip_Text_C_Name_2 = {
    ID = "UI_Awaker_Popup_Backtrace_Tip_Text_C_Name_2",
    Content = "PanelText_UI_Awaker_Popup_Backtrace_Tip_Text_C_Name_2_Content|确认"
  },
  UI_Awaker_Popup_Backtrace_Tip_Text_C_Toggle_1 = {
    ID = "UI_Awaker_Popup_Backtrace_Tip_Text_C_Toggle_1",
    Content = "PanelText_UI_Awaker_Popup_Backtrace_Tip_Text_C_Toggle_1_Content|常驻唤醒体"
  },
  UI_Awaker_Popup_Backtrace_Tip_Text_C_Toggle_2 = {
    ID = "UI_Awaker_Popup_Backtrace_Tip_Text_C_Toggle_2",
    Content = "PanelText_UI_Awaker_Popup_Backtrace_Tip_Text_C_Toggle_2_Content|特殊唤醒体"
  },
  UI_Awaker_Item_Preview_Text_C_Confirm_1 = {
    ID = "UI_Awaker_Item_Preview_Text_C_Confirm_1",
    Content = "PanelText_UI_Awaker_Item_Preview_Text_C_Confirm_1_Content|黑池归还"
  },
  UI_Awaker_Item_Preview_Text_C_Confirm_2 = {
    ID = "UI_Awaker_Item_Preview_Text_C_Confirm_2",
    Content = "PanelText_UI_Awaker_Item_Preview_Text_C_Confirm_2_Content|养成回溯"
  },
  UI_Social_Panel_HelpList_Text_C_Time = {
    ID = "UI_Social_Panel_HelpList_Text_C_Time",
    Content = "PanelText_UI_Social_Panel_HelpList_Text_C_Time_Content|可使用与你互相关注守密人的助战唤醒体出战"
  },
  UI_Social_Panel_HelpList_Text_C_NoTask = {
    ID = "UI_Social_Panel_HelpList_Text_C_NoTask",
    Content = "PanelText_UI_Social_Panel_HelpList_Text_C_NoTask_Content|暂无契合的助战唤醒体，建议调整「筛选唤醒体」"
  },
  UI_Awaker_Item_Weapon_Refining_Text_C_Confirm_3 = {
    ID = "UI_Awaker_Item_Weapon_Refining_Text_C_Confirm_3",
    Content = "PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Confirm_3_Content|黑池归还"
  },
  UI_Awaker_Item_Weapon_Refining_Text_C_Confirm_4 = {
    ID = "UI_Awaker_Item_Weapon_Refining_Text_C_Confirm_4",
    Content = "PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Confirm_4_Content|叠位回溯"
  },
  UI_Battle_Popup_Furnace_Text_C_Title = {
    ID = "UI_Battle_Popup_Furnace_Text_C_Title",
    Content = "PanelText_UI_Battle_Popup_Furnace_Text_C_Title_Content|腥红熔炉"
  },
  UI_Battle_Popup_Furnace_Text_C_Name_1 = {
    ID = "UI_Battle_Popup_Furnace_Text_C_Name_1",
    Content = "PanelText_UI_Battle_Popup_Furnace_Text_C_Name_1_Content|取消"
  },
  UI_Battle_Popup_Furnace_Text_C_Name_2 = {
    ID = "UI_Battle_Popup_Furnace_Text_C_Name_2",
    Content = "PanelText_UI_Battle_Popup_Furnace_Text_C_Name_2_Content|确认"
  },
  UI_Events_Panel_MagicStory_Text_C_Diagonal = {
    ID = "UI_Events_Panel_MagicStory_Text_C_Diagonal",
    Content = "PanelText_UI_Events_Panel_MagicStory_Text_C_Diagonal_Content|/"
  },
  UI_Awaker_Item_Minihead_List_Text_C_Backtrace = {
    ID = "UI_Awaker_Item_Minihead_List_Text_C_Backtrace",
    Content = "PanelText_UI_Awaker_Item_Minihead_List_Text_C_Backtrace_Content|回溯"
  },
  UI_Awaker_Item_Minihead_List_Text_C_Backtrace_Click = {
    ID = "UI_Awaker_Item_Minihead_List_Text_C_Backtrace_Click",
    Content = "PanelText_UI_Awaker_Item_Minihead_List_Text_C_Backtrace_Click_Content|回溯"
  },
  UI_Team_Popup_Awaker_List_Text_C_Title = {
    ID = "UI_Team_Popup_Awaker_List_Text_C_Title",
    Content = "PanelText_UI_Team_Popup_Awaker_List_Text_C_Title_Content|选择唤醒体"
  },
  UI_Dungeous_Panel_Melt_Erosion_Text_C_Train = {
    ID = "UI_Dungeous_Panel_Melt_Erosion_Text_C_Train",
    Content = "PanelText_UI_Dungeous_Panel_Melt_Erosion_Text_C_Train_Content|当前特训值"
  },
  UI_Recharge_Courtesy_Item_Text_C_Additional = {
    ID = "UI_Recharge_Courtesy_Item_Text_C_Additional",
    Content = "PanelText_UI_Recharge_Courtesy_Item_Text_C_Additional_Content|额外赠送"
  },
  UI_Bag_Item_Detail_Text_C_KeeperSkill_Title = {
    ID = "UI_Bag_Item_Detail_Text_C_KeeperSkill_Title",
    Content = "PanelText_UI_Bag_Item_Detail_Text_C_KeeperSkill_Title_Content|钥令效果："
  },
  UI_Common_Item_Detail_Text_C_KeeperSkill_Title = {
    ID = "UI_Common_Item_Detail_Text_C_KeeperSkill_Title",
    Content = "PanelText_UI_Common_Item_Detail_Text_C_KeeperSkill_Title_Content|钥令效果："
  },
  UI_Recharge_Exchange_Text_C_Redeemed = {
    ID = "UI_Recharge_Exchange_Text_C_Redeemed",
    Content = "PanelText_UI_Recharge_Exchange_Text_C_Redeemed_Content|累计已兑换:"
  },
  UI_Task_Popup_Challenge2_Text_C_ReachName = {
    ID = "UI_Task_Popup_Challenge2_Text_C_ReachName",
    Content = "PanelText_UI_Task_Popup_Challenge2_Text_C_ReachName_Content|「全部」成就达成"
  },
  UI_Task_Popup_Challenge2_Text_C_Name_2 = {
    ID = "UI_Task_Popup_Challenge2_Text_C_Name_2",
    Content = "PanelText_UI_Task_Popup_Challenge2_Text_C_Name_2_Content|全部领取"
  },
  UI_Task_Popup_Challenge2_Text_C_OneKey = {
    ID = "UI_Task_Popup_Challenge2_Text_C_OneKey",
    Content = "PanelText_UI_Task_Popup_Challenge2_Text_C_OneKey_Content|一键领取"
  },
  UI_Chapter_Popup_Vibes_List_Text_C_Effect = {
    ID = "UI_Chapter_Popup_Vibes_List_Text_C_Effect",
    Content = "PanelText_UI_Chapter_Popup_Vibes_List_Text_C_Effect_Content|效果"
  },
  UI_Chapter_Popup_Vibes_List_Text_C_Story = {
    ID = "UI_Chapter_Popup_Vibes_List_Text_C_Story",
    Content = "PanelText_UI_Chapter_Popup_Vibes_List_Text_C_Story_Content|故事"
  },
  UI_Chapter_Panel_Spur_Text_C_Simple_01 = {
    ID = "UI_Chapter_Panel_Spur_Text_C_Simple_01",
    Content = "PanelText_UI_Chapter_Panel_Spur_Text_C_Simple_01_Content|普通"
  },
  UI_Chapter_Panel_Spur_Text_C_Difficulty_01 = {
    ID = "UI_Chapter_Panel_Spur_Text_C_Difficulty_01",
    Content = "PanelText_UI_Chapter_Panel_Spur_Text_C_Difficulty_01_Content|困难"
  },
  UI_Chapter_Panel_Spur_Text_C_Nightmare_01 = {
    ID = "UI_Chapter_Panel_Spur_Text_C_Nightmare_01",
    Content = "PanelText_UI_Chapter_Panel_Spur_Text_C_Nightmare_01_Content|癫狂"
  },
  Panel_Gm_Battle_Art_Entry_Text_C_Canel = {
    ID = "Panel_Gm_Battle_Art_Entry_Text_C_Canel",
    Content = "PanelText_Panel_Gm_Battle_Art_Entry_Text_C_Canel_Content|取消"
  },
  Panel_Gm_Battle_Art_Entry_Text_C_Confirm = {
    ID = "Panel_Gm_Battle_Art_Entry_Text_C_Confirm",
    Content = "PanelText_Panel_Gm_Battle_Art_Entry_Text_C_Confirm_Content|确认"
  },
  UI_Story_Portrait_Test_Text_C_Hide = {
    ID = "UI_Story_Portrait_Test_Text_C_Hide",
    Content = "PanelText_UI_Story_Portrait_Test_Text_C_Hide_Content|隐藏"
  },
  UI_Story_Portrait_Test_Text_C_Close = {
    ID = "UI_Story_Portrait_Test_Text_C_Close",
    Content = "PanelText_UI_Story_Portrait_Test_Text_C_Close_Content|关闭"
  },
  UI_Story_Portrait_Test_Text_C_Normal = {
    ID = "UI_Story_Portrait_Test_Text_C_Normal",
    Content = "PanelText_UI_Story_Portrait_Test_Text_C_Normal_Content|1"
  },
  UI_Story_Portrait_Test_Text_C_Vertical = {
    ID = "UI_Story_Portrait_Test_Text_C_Vertical",
    Content = "PanelText_UI_Story_Portrait_Test_Text_C_Vertical_Content|2"
  },
  UI_Story_Portrait_Test_Text_C_Horizontal = {
    ID = "UI_Story_Portrait_Test_Text_C_Horizontal",
    Content = "PanelText_UI_Story_Portrait_Test_Text_C_Horizontal_Content|3"
  },
  GmParamPanel_Text_C_Param = {
    ID = "GmParamPanel_Text_C_Param",
    Content = "PanelText_GmParamPanel_Text_C_Param_Content|配置"
  },
  Panel_Gm_Battle_Dbg_Entry_Text_C_Canel = {
    ID = "Panel_Gm_Battle_Dbg_Entry_Text_C_Canel",
    Content = "PanelText_Panel_Gm_Battle_Dbg_Entry_Text_C_Canel_Content|取消"
  },
  Panel_Gm_Battle_Dbg_Entry_Text_C_Enter = {
    ID = "Panel_Gm_Battle_Dbg_Entry_Text_C_Enter",
    Content = "PanelText_Panel_Gm_Battle_Dbg_Entry_Text_C_Enter_Content|挑战"
  },
  Panel_Gm_PVP_Text_C_Canel = {
    ID = "Panel_Gm_PVP_Text_C_Canel",
    Content = "PanelText_Panel_Gm_PVP_Text_C_Canel_Content|取消"
  },
  Panel_Gm_PVP_Text_C_Confirm = {
    ID = "Panel_Gm_PVP_Text_C_Confirm",
    Content = "PanelText_Panel_Gm_PVP_Text_C_Confirm_Content|确认"
  },
  Popup_Gm_Effect_Text_Cancel = {
    ID = "Popup_Gm_Effect_Text_Cancel",
    Content = "PanelText_Popup_Gm_Effect_Text_Cancel_Content|关闭"
  },
  Popup_Gm_Effect_Text_Confirm = {
    ID = "Popup_Gm_Effect_Text_Confirm",
    Content = "PanelText_Popup_Gm_Effect_Text_Confirm_Content|确认"
  },
  Popup_Gm_Effect_Side_Text = {
    ID = "Popup_Gm_Effect_Side_Text",
    Content = "PanelText_Popup_Gm_Effect_Side_Text_Content|编辑效果"
  },
  Simple_List_Panel_Text = {
    ID = "Simple_List_Panel_Text",
    Content = "PanelText_Simple_List_Panel_Text_Content|关闭"
  },
  UI_Chaper_Popup_Particulars_New_Text_C_Suppress = {
    ID = "UI_Chaper_Popup_Particulars_New_Text_C_Suppress",
    Content = "PanelText_UI_Chaper_Popup_Particulars_New_Text_C_Suppress_Content|融灾黑潮"
  },
  UI_Chapter_Panel_Main2_ItemBranch_Text_C_Free_Unlock = {
    ID = "UI_Chapter_Panel_Main2_ItemBranch_Text_C_Free_Unlock",
    Content = "PanelText_UI_Chapter_Panel_Main2_ItemBranch_Text_C_Free_Unlock_Content|限时免费解锁"
  },
  UI_Chapter_Panel_Main2_SmallBranch_Text_C_Free_Unlock = {
    ID = "UI_Chapter_Panel_Main2_SmallBranch_Text_C_Free_Unlock",
    Content = "PanelText_UI_Chapter_Panel_Main2_SmallBranch_Text_C_Free_Unlock_Content|限时免费解锁"
  },
  UI_Chapter_Panel_Main2_SmallBranch_Text_C_Award = {
    ID = "UI_Chapter_Panel_Main2_SmallBranch_Text_C_Award",
    Content = "PanelText_UI_Chapter_Panel_Main2_SmallBranch_Text_C_Award_Content|已达成"
  },
  UI_Passport_Reward_Item_New_Text_C_Ordinary_Title = {
    ID = "UI_Passport_Reward_Item_New_Text_C_Ordinary_Title",
    Content = "PanelText_UI_Passport_Reward_Item_New_Text_C_Ordinary_Title_Content|基础课题"
  },
  UI_Passport_Reward_Item_New_Text_C_Senior_Title = {
    ID = "UI_Passport_Reward_Item_New_Text_C_Senior_Title",
    Content = "PanelText_UI_Passport_Reward_Item_New_Text_C_Senior_Title_Content|高阶课题"
  },
  UI_Passport_Reward_Item_New_Text_C_Experience = {
    ID = "UI_Passport_Reward_Item_New_Text_C_Experience",
    Content = "PanelText_UI_Passport_Reward_Item_New_Text_C_Experience_Content|课题经验"
  },
  UI_Passport_Reward_Item_New_Text_C_Online = {
    ID = "UI_Passport_Reward_Item_New_Text_C_Online",
    Content = "PanelText_UI_Passport_Reward_Item_New_Text_C_Online_Content|本周上限"
  },
  UI_Passport_Reward_Item_New_Text_C_Full = {
    ID = "UI_Passport_Reward_Item_New_Text_C_Full",
    Content = "PanelText_UI_Passport_Reward_Item_New_Text_C_Full_Content|已满级"
  },
  UI_Passport_Reward_Item_New_Text_C_Timing = {
    ID = "UI_Passport_Reward_Item_New_Text_C_Timing",
    Content = "PanelText_UI_Passport_Reward_Item_New_Text_C_Timing_Content|本期"
  },
  UI_Passport_Reward_Item_New_Text_C_Senior = {
    ID = "UI_Passport_Reward_Item_New_Text_C_Senior",
    Content = "PanelText_UI_Passport_Reward_Item_New_Text_C_Senior_Content|课题进阶"
  },
  UI_Passport_Reward_Item_New_Text_C_Unlock = {
    ID = "UI_Passport_Reward_Item_New_Text_C_Unlock",
    Content = "PanelText_UI_Passport_Reward_Item_New_Text_C_Unlock_Content|解锁立即获得"
  },
  UI_Passport_Reward_Item_New_Text_C_Name = {
    ID = "UI_Passport_Reward_Item_New_Text_C_Name",
    Content = "PanelText_UI_Passport_Reward_Item_New_Text_C_Name_Content|一键领取"
  },
  UI_Awaker_Weapon_Refine_Success_Text_C_Info = {
    ID = "UI_Awaker_Weapon_Refine_Success_Text_C_Info",
    Content = "PanelText_UI_Awaker_Weapon_Refine_Success_Text_C_Info_Content|点击空白处关闭"
  },
  UI_Dungeous_Panel_Difficulty_Text_C_Suppress = {
    ID = "UI_Dungeous_Panel_Difficulty_Text_C_Suppress",
    Content = "PanelText_UI_Dungeous_Panel_Difficulty_Text_C_Suppress_Content|融灾黑潮"
  },
  UI_Dungeous_Panel_Lake_City_Text_C_Creation = {
    ID = "UI_Dungeous_Panel_Lake_City_Text_C_Creation",
    Content = "PanelText_UI_Dungeous_Panel_Lake_City_Text_C_Creation_Content|关卡造物"
  },
  UI_Dungeous_Panel_Lake_City_Text_C_Remuneration = {
    ID = "UI_Dungeous_Panel_Lake_City_Text_C_Remuneration",
    Content = "PanelText_UI_Dungeous_Panel_Lake_City_Text_C_Remuneration_Content|人物报酬"
  },
  UI_Dungeous_Panel_Lake_City_Text_C_Resonance = {
    ID = "UI_Dungeous_Panel_Lake_City_Text_C_Resonance",
    Content = "PanelText_UI_Dungeous_Panel_Lake_City_Text_C_Resonance_Content|共鸣"
  },
  UI_Dungeous_Panel_Lake_City_Text_C_Special = {
    ID = "UI_Dungeous_Panel_Lake_City_Text_C_Special",
    Content = "PanelText_UI_Dungeous_Panel_Lake_City_Text_C_Special_Content|初始造物"
  },
  UI_Events_Panel_Banquet_Text_C_Reward = {
    ID = "UI_Events_Panel_Banquet_Text_C_Reward",
    Content = "PanelText_UI_Events_Panel_Banquet_Text_C_Reward_Content|成就奖励"
  },
  UI_Events_Panel_Banquet_Text_C_Resonance = {
    ID = "UI_Events_Panel_Banquet_Text_C_Resonance",
    Content = "PanelText_UI_Events_Panel_Banquet_Text_C_Resonance_Content|共鸣：灵魂的岔路"
  },
  UI_Events_Panel_Banquet_Text_C_Diagonal = {
    ID = "UI_Events_Panel_Banquet_Text_C_Diagonal",
    Content = "PanelText_UI_Events_Panel_Banquet_Text_C_Diagonal_Content|/"
  },
  UI_Events_Panel_Banquet_Text_C_Record = {
    ID = "UI_Events_Panel_Banquet_Text_C_Record",
    Content = "PanelText_UI_Events_Panel_Banquet_Text_C_Record_Content|血的颜色"
  },
  UI_Events_Panel_Banquet_Text_C_RecordTip = {
    ID = "UI_Events_Panel_Banquet_Text_C_RecordTip",
    Content = "PanelText_UI_Events_Panel_Banquet_Text_C_RecordTip_Content|限时免费解锁"
  },
  UI_Events_Panel_Banquet_Text_C_Challenge = {
    ID = "UI_Events_Panel_Banquet_Text_C_Challenge",
    Content = "PanelText_UI_Events_Panel_Banquet_Text_C_Challenge_Content|圣堂之路"
  },
  UI_Events_Panel_Banquet_Text_C_ChallengeTip = {
    ID = "UI_Events_Panel_Banquet_Text_C_ChallengeTip",
    Content = "PanelText_UI_Events_Panel_Banquet_Text_C_ChallengeTip_Content|玩法限时开放"
  },
  UI_Events_Panel_Banquet_Text_C_Topic = {
    ID = "UI_Events_Panel_Banquet_Text_C_Topic",
    Content = "PanelText_UI_Events_Panel_Banquet_Text_C_Topic_Content|灵魂的牧人·复刻"
  },
  UI_Events_Panel_Banquet_Text_C_Shop = {
    ID = "UI_Events_Panel_Banquet_Text_C_Shop",
    Content = "PanelText_UI_Events_Panel_Banquet_Text_C_Shop_Content|圣堂义卖现场"
  },
  UI_Events_Item_Lake_City_Text_C_Diagonal = {
    ID = "UI_Events_Item_Lake_City_Text_C_Diagonal",
    Content = "PanelText_UI_Events_Item_Lake_City_Text_C_Diagonal_Content|/"
  },
  UI_Events_Item_Lake_City_Text_C_Fall = {
    ID = "UI_Events_Item_Lake_City_Text_C_Fall",
    Content = "PanelText_UI_Events_Item_Lake_City_Text_C_Fall_Content|掉落预览"
  },
  UI_Events_Panel_Lake_City_Text_C_Resonance = {
    ID = "UI_Events_Panel_Lake_City_Text_C_Resonance",
    Content = "PanelText_UI_Events_Panel_Lake_City_Text_C_Resonance_Content|共鸣"
  },
  UI_Events_Panel_Lake_City_Text_C_Title = {
    ID = "UI_Events_Panel_Lake_City_Text_C_Title",
    Content = "PanelText_UI_Events_Panel_Lake_City_Text_C_Title_Content|圣堂之路"
  },
  UI_Events_Panel_Lily_StageGroup_Text_C_Introduction = {
    ID = "UI_Events_Panel_Lily_StageGroup_Text_C_Introduction",
    Content = "PanelText_UI_Events_Panel_Lily_StageGroup_Text_C_Introduction_Content|朵尔交待的任务，从来都不简单。\n即便她数次提醒大家「要玩得开心」，可首次带着一群唤醒体出门，守密人怎么能不胆战心惊？\n但，要记得「玩得开心」哦。"
  },
  UI_Events_Panel_Lily_StageGroup_Text_C_Resonance = {
    ID = "UI_Events_Panel_Lily_StageGroup_Text_C_Resonance",
    Content = "PanelText_UI_Events_Panel_Lily_StageGroup_Text_C_Resonance_Content|共鸣"
  },
  UI_Events_Panel_Lily_StageGroup_Text_C_Title = {
    ID = "UI_Events_Panel_Lily_StageGroup_Text_C_Title",
    Content = "PanelText_UI_Events_Panel_Lily_StageGroup_Text_C_Title_Content|剧本迷思"
  },
  UI_Events_Panel_Lake_City_Text_C_Describe = {
    ID = "UI_Events_Panel_Lake_City_Text_C_Describe",
    Content = "PanelText_UI_Events_Panel_Lake_City_Text_C_Describe_Content|你目睹的不只是灵魂的选择，更是它飘忽摇摆的人生。"
  },
  UI_Events_Panel_Banquet_Text_C_Fundraising = {
    ID = "UI_Events_Panel_Banquet_Text_C_Fundraising",
    Content = "PanelText_UI_Events_Panel_Banquet_Text_C_Fundraising_Content|市民的善意"
  },
  UI_Events_Panel_Banquet_Text_C_Receive = {
    ID = "UI_Events_Panel_Banquet_Text_C_Receive",
    Content = "PanelText_UI_Events_Panel_Banquet_Text_C_Receive_Content|距离可领取"
  },
  UI_Events_Panel_Banquet_Text_C_Max = {
    ID = "UI_Events_Panel_Banquet_Text_C_Max",
    Content = "PanelText_UI_Events_Panel_Banquet_Text_C_Max_Content|Max"
  },
  UI_Events_Panel_Banquet_Text_C_Can_Unlockable = {
    ID = "UI_Events_Panel_Banquet_Text_C_Can_Unlockable",
    Content = "PanelText_UI_Events_Panel_Banquet_Text_C_Can_Unlockable_Content|可领取"
  },
  UI_Event_Activity_Main_Text_C_Title = {
    ID = "UI_Event_Activity_Main_Text_C_Title",
    Content = "PanelText_UI_Event_Activity_Main_Text_C_Title_Content|圣堂义卖现场"
  },
  UI_Event_Item_Return_Text_C_Finish = {
    ID = "UI_Event_Item_Return_Text_C_Finish",
    Content = "PanelText_UI_Event_Item_Return_Text_C_Finish_Content|已领取"
  },
  UI_Event_Item_Return_Text_C_Close = {
    ID = "UI_Event_Item_Return_Text_C_Close",
    Content = "PanelText_UI_Event_Item_Return_Text_C_Close_Content|点击屏幕关闭"
  },
  UI_Events_Item_Tab_Text_C_Return = {
    ID = "UI_Events_Item_Tab_Text_C_Return",
    Content = "PanelText_UI_Events_Item_Tab_Text_C_Return_Content|回归活动"
  },
  UI_Events_Panel_SurveyDiary_Text_C_Return = {
    ID = "UI_Events_Panel_SurveyDiary_Text_C_Return",
    Content = "PanelText_UI_Events_Panel_SurveyDiary_Text_C_Return_Content|返校奖励"
  },
  UI_Events_Panel_Lake_City_Text_C_illustrate = {
    ID = "UI_Events_Panel_Lake_City_Text_C_illustrate",
    Content = "PanelText_UI_Events_Panel_Lake_City_Text_C_illustrate_Content|玩法规则"
  },
  UI_Team_Item_MyTeam_List_Text_C_Current = {
    ID = "UI_Team_Item_MyTeam_List_Text_C_Current",
    Content = "PanelText_UI_Team_Item_MyTeam_List_Text_C_Current_Content|当前出战"
  },
  UI_Team_Item_Secret_Contract_Text_C_Hint = {
    ID = "UI_Team_Item_Secret_Contract_Text_C_Hint",
    Content = "PanelText_UI_Team_Item_Secret_Contract_Text_C_Hint_Content|*同个唤醒体只能装备一个SSR命轮"
  },
  UI_Team_Item_Secret_Contract_Text_C_Save = {
    ID = "UI_Team_Item_Secret_Contract_Text_C_Save",
    Content = "PanelText_UI_Team_Item_Secret_Contract_Text_C_Save_Content|保存"
  },
  UI_Team_Item_Secret_Contract_Text_C_Remove = {
    ID = "UI_Team_Item_Secret_Contract_Text_C_Remove",
    Content = "PanelText_UI_Team_Item_Secret_Contract_Text_C_Remove_Content|一键卸下"
  },
  UI_Team_Item_Secret_Contract_Text_C_Recommend = {
    ID = "UI_Team_Item_Secret_Contract_Text_C_Recommend",
    Content = "PanelText_UI_Team_Item_Secret_Contract_Text_C_Recommend_Content|推荐"
  },
  UI_Team_Item_Secret_Contract_Text_C_Guide = {
    ID = "UI_Team_Item_Secret_Contract_Text_C_Guide",
    Content = "PanelText_UI_Team_Item_Secret_Contract_Text_C_Guide_Content|推荐"
  },
  UI_Team_Item_Secret_Contract_Text_C_Uninstall = {
    ID = "UI_Team_Item_Secret_Contract_Text_C_Uninstall",
    Content = "PanelText_UI_Team_Item_Secret_Contract_Text_C_Uninstall_Content|一键卸下"
  },
  UI_Team_Item_Secret_Props_Text_C_Lv = {
    ID = "UI_Team_Item_Secret_Props_Text_C_Lv",
    Content = "PanelText_UI_Team_Item_Secret_Props_Text_C_Lv_Content|等级完成度"
  },
  UI_Team_Item_Secret_Props_Text_C_Refining = {
    ID = "UI_Team_Item_Secret_Props_Text_C_Refining",
    Content = "PanelText_UI_Team_Item_Secret_Props_Text_C_Refining_Content|转录完成度"
  },
  UI_Team_Item_Secret_Props_Text_C_Foundation = {
    ID = "UI_Team_Item_Secret_Props_Text_C_Foundation",
    Content = "PanelText_UI_Team_Item_Secret_Props_Text_C_Foundation_Content|属性"
  },
  UI_Team_Item_Secret_Props_Text_C_Suit_Title = {
    ID = "UI_Team_Item_Secret_Props_Text_C_Suit_Title",
    Content = "PanelText_UI_Team_Item_Secret_Props_Text_C_Suit_Title_Content|套装效果"
  },
  UI_Team_Item_Secret_Props_Text_C_Suit_Null = {
    ID = "UI_Team_Item_Secret_Props_Text_C_Suit_Null",
    Content = "PanelText_UI_Team_Item_Secret_Props_Text_C_Suit_Null_Content|暂无生效的套装效果"
  },
  UI_Team_Item_Suit_Text_C_Current = {
    ID = "UI_Team_Item_Suit_Text_C_Current",
    Content = "PanelText_UI_Team_Item_Suit_Text_C_Current_Content|当前使用"
  },
  UI_Team_Item_Suit_Bookmark_Text_C_Quantity = {
    ID = "UI_Team_Item_Suit_Bookmark_Text_C_Quantity",
    Content = "PanelText_UI_Team_Item_Suit_Bookmark_Text_C_Quantity_Content|方案数量"
  },
  UI_Team_Item_Suit_Bookmark_Text_C_Suit = {
    ID = "UI_Team_Item_Suit_Bookmark_Text_C_Suit",
    Content = "PanelText_UI_Team_Item_Suit_Bookmark_Text_C_Suit_Content|当前无可使用方案"
  },
  UI_Team_Item_Suit_Bookmark_Text_C_Null = {
    ID = "UI_Team_Item_Suit_Bookmark_Text_C_Null",
    Content = "PanelText_UI_Team_Item_Suit_Bookmark_Text_C_Null_Content|当前部位无可用密契"
  },
  UI_Team_Item_Suit_Bookmark_Text_C_Name_4 = {
    ID = "UI_Team_Item_Suit_Bookmark_Text_C_Name_4",
    Content = "PanelText_UI_Team_Item_Suit_Bookmark_Text_C_Name_4_Content|装备"
  },
  UI_Team_Item_Suit_Bookmark_Text_C_Save = {
    ID = "UI_Team_Item_Suit_Bookmark_Text_C_Save",
    Content = "PanelText_UI_Team_Item_Suit_Bookmark_Text_C_Save_Content|新增密契方案"
  },
  UI_Team_Item_Suit_Bookmark_Text_C_Added = {
    ID = "UI_Team_Item_Suit_Bookmark_Text_C_Added",
    Content = "PanelText_UI_Team_Item_Suit_Bookmark_Text_C_Added_Content|新增密契方案"
  },
  UI_Team_Item_Suit_Bookmark_Text_C_Name_2 = {
    ID = "UI_Team_Item_Suit_Bookmark_Text_C_Name_2",
    Content = "PanelText_UI_Team_Item_Suit_Bookmark_Text_C_Name_2_Content|卸下"
  },
  UI_Team_Item_Suit_Bookmark_Text_C_Name_3 = {
    ID = "UI_Team_Item_Suit_Bookmark_Text_C_Name_3",
    Content = "PanelText_UI_Team_Item_Suit_Bookmark_Text_C_Name_3_Content|强化"
  },
  UI_Team_Item_Trinket_Detail_Text_C_Lv = {
    ID = "UI_Team_Item_Trinket_Detail_Text_C_Lv",
    Content = "PanelText_UI_Team_Item_Trinket_Detail_Text_C_Lv_Content|等级完成度"
  },
  UI_Team_Item_Trinket_Detail_Text_C_Refining = {
    ID = "UI_Team_Item_Trinket_Detail_Text_C_Refining",
    Content = "PanelText_UI_Team_Item_Trinket_Detail_Text_C_Refining_Content|转录完成度"
  },
  UI_Team_Item_Trinket_Detail_Text_C_Foundation = {
    ID = "UI_Team_Item_Trinket_Detail_Text_C_Foundation",
    Content = "PanelText_UI_Team_Item_Trinket_Detail_Text_C_Foundation_Content|属性"
  },
  UI_Team_Item_Trinket_Detail_Text_C_Suit_Title = {
    ID = "UI_Team_Item_Trinket_Detail_Text_C_Suit_Title",
    Content = "PanelText_UI_Team_Item_Trinket_Detail_Text_C_Suit_Title_Content|套装效果"
  },
  UI_Team_Item_Trinket_Detail_Text_C_Suit_Null = {
    ID = "UI_Team_Item_Trinket_Detail_Text_C_Suit_Null",
    Content = "PanelText_UI_Team_Item_Trinket_Detail_Text_C_Suit_Null_Content|暂无生效的套装效果"
  },
  UI_Team_Item_Weapon_Full_Text_C_Empty = {
    ID = "UI_Team_Item_Weapon_Full_Text_C_Empty",
    Content = "PanelText_UI_Team_Item_Weapon_Full_Text_C_Empty_Content|左侧选择命轮装备"
  },
  UI_Team_Item_Weapon_Full_Text_C_Not = {
    ID = "UI_Team_Item_Weapon_Full_Text_C_Not",
    Content = "PanelText_UI_Team_Item_Weapon_Full_Text_C_Not_Content|未生效"
  },
  UI_Team_Popup_MyTeam_Awaker_List_Text_C_Name = {
    ID = "UI_Team_Popup_MyTeam_Awaker_List_Text_C_Name",
    Content = "PanelText_UI_Team_Popup_MyTeam_Awaker_List_Text_C_Name_Content|选择"
  },
  UI_Team_Panel_Weapon_Equip_Text_C_Hint = {
    ID = "UI_Team_Panel_Weapon_Equip_Text_C_Hint",
    Content = "PanelText_UI_Team_Panel_Weapon_Equip_Text_C_Hint_Content|*同个唤醒体只能装备一个SSR命轮"
  },
  UI_Team_Panel_Weapon_Equip_Text_C_Title = {
    ID = "UI_Team_Panel_Weapon_Equip_Text_C_Title",
    Content = "PanelText_UI_Team_Panel_Weapon_Equip_Text_C_Title_Content|选择命轮"
  },
  UI_Team_Panel_Weapon_Equip_Text_C_Null = {
    ID = "UI_Team_Panel_Weapon_Equip_Text_C_Null",
    Content = "PanelText_UI_Team_Panel_Weapon_Equip_Text_C_Null_Content|当前暂无命轮"
  },
  UI_Team_Panel_Weapon_Equip_Text_C_Guide = {
    ID = "UI_Team_Panel_Weapon_Equip_Text_C_Guide",
    Content = "PanelText_UI_Team_Panel_Weapon_Equip_Text_C_Guide_Content|推荐"
  },
  UI_Team_Panel_Weapon_Equip_Text_C_Uninstall = {
    ID = "UI_Team_Panel_Weapon_Equip_Text_C_Uninstall",
    Content = "PanelText_UI_Team_Panel_Weapon_Equip_Text_C_Uninstall_Content|一键卸下"
  },
  UI_Main_Panel_1_Text_C_Formation = {
    ID = "UI_Main_Panel_1_Text_C_Formation",
    Content = "PanelText_UI_Main_Panel_1_Text_C_Formation_Content|编队"
  },
  UI_Main_Panel_1_Text_C_Formation_EN = {
    ID = "UI_Main_Panel_1_Text_C_Formation_EN",
    Content = "PanelText_UI_Main_Panel_1_Text_C_Formation_EN_Content|Task"
  },
  UI_Team_Panel_Trinket_Equip_Text_C_Save = {
    ID = "UI_Team_Panel_Trinket_Equip_Text_C_Save",
    Content = "PanelText_UI_Team_Panel_Trinket_Equip_Text_C_Save_Content|保存为方案"
  },
  UI_Team_Panel_Trinket_Equip_Text_C_Remove = {
    ID = "UI_Team_Panel_Trinket_Equip_Text_C_Remove",
    Content = "PanelText_UI_Team_Panel_Trinket_Equip_Text_C_Remove_Content|一键卸下"
  },
  UI_Team_Panel_Trinket_Equip_Text_C_Recommend = {
    ID = "UI_Team_Panel_Trinket_Equip_Text_C_Recommend",
    Content = "PanelText_UI_Team_Panel_Trinket_Equip_Text_C_Recommend_Content|推荐装备"
  },
  UI_Team_Panel_Trinket_Equip_Text_C_Delete = {
    ID = "UI_Team_Panel_Trinket_Equip_Text_C_Delete",
    Content = "PanelText_UI_Team_Panel_Trinket_Equip_Text_C_Delete_Content|删除方案"
  },
  UI_Team_Panel_Trinket_Equip_Text_C_Edit = {
    ID = "UI_Team_Panel_Trinket_Equip_Text_C_Edit",
    Content = "PanelText_UI_Team_Panel_Trinket_Equip_Text_C_Edit_Content|编辑方案"
  },
  UI_Team_Panel_Weapon_Equip_Text_C_Name_3 = {
    ID = "UI_Team_Panel_Weapon_Equip_Text_C_Name_3",
    Content = "PanelText_UI_Team_Panel_Weapon_Equip_Text_C_Name_3_Content|叠位"
  },
  UI_Team_Panel_Weapon_Equip_Text_C_Name_2 = {
    ID = "UI_Team_Panel_Weapon_Equip_Text_C_Name_2",
    Content = "PanelText_UI_Team_Panel_Weapon_Equip_Text_C_Name_2_Content|卸下"
  },
  UI_Other_Physical_Tips_Text_C_Auto = {
    ID = "UI_Other_Physical_Tips_Text_C_Auto",
    Content = "PanelText_UI_Other_Physical_Tips_Text_C_Auto_Content|自动恢复"
  },
  UI_Other_Physical_Tips_Text_C_Next = {
    ID = "UI_Other_Physical_Tips_Text_C_Next",
    Content = "PanelText_UI_Other_Physical_Tips_Text_C_Next_Content|下次恢复："
  },
  UI_Other_Physical_Tips_Text_C_All = {
    ID = "UI_Other_Physical_Tips_Text_C_All",
    Content = "PanelText_UI_Other_Physical_Tips_Text_C_All_Content|全部恢复："
  },
  UI_Other_Physical_Tips_Text_C_Name_1 = {
    ID = "UI_Other_Physical_Tips_Text_C_Name_1",
    Content = "PanelText_UI_Other_Physical_Tips_Text_C_Name_1_Content|取消"
  },
  UI_Other_Physical_Tips_Text_C_Name_2 = {
    ID = "UI_Other_Physical_Tips_Text_C_Name_2",
    Content = "PanelText_UI_Other_Physical_Tips_Text_C_Name_2_Content|确定"
  },
  UI_Passport_Money_Item_New_Text_C_Name = {
    ID = "UI_Passport_Money_Item_New_Text_C_Name",
    Content = "PanelText_UI_Passport_Money_Item_New_Text_C_Name_Content|训令表彰"
  },
  ["UI_Passport_Money_Item_New_Text_C_Senior (1)"] = {
    ID = "UI_Passport_Money_Item_New_Text_C_Senior (1)",
    Content = "PanelText_UI_Passport_Money_Item_New_Text_C_Senior (1)_Content|高级"
  },
  UI_Passport_Money_Item_New_Text_C_Senior = {
    ID = "UI_Passport_Money_Item_New_Text_C_Senior",
    Content = "PanelText_UI_Passport_Money_Item_New_Text_C_Senior_Content|高阶课题"
  },
  UI_Passport_Money_Item_New_Text_C_Condition = {
    ID = "UI_Passport_Money_Item_New_Text_C_Condition",
    Content = "PanelText_UI_Passport_Money_Item_New_Text_C_Condition_Content|完成所有课题可累计获得"
  },
  UI_Passport_Money_Item_New_Text_C_Additional = {
    ID = "UI_Passport_Money_Item_New_Text_C_Additional",
    Content = "PanelText_UI_Passport_Money_Item_New_Text_C_Additional_Content|解锁立即获得"
  },
  UI_Passport_Money_Item_New_Text_C_Purchase_1 = {
    ID = "UI_Passport_Money_Item_New_Text_C_Purchase_1",
    Content = "PanelText_UI_Passport_Money_Item_New_Text_C_Purchase_1_Content|已购买"
  },
  ["UI_Passport_Money_Item_New_Text_C_Super (1)"] = {
    ID = "UI_Passport_Money_Item_New_Text_C_Super (1)",
    Content = "PanelText_UI_Passport_Money_Item_New_Text_C_Super (1)_Content|特级"
  },
  UI_Passport_Money_Item_New_Text_C_Super = {
    ID = "UI_Passport_Money_Item_New_Text_C_Super",
    Content = "PanelText_UI_Passport_Money_Item_New_Text_C_Super_Content|核心课题"
  },
  UI_Passport_Money_Item_New_Text_C_Purchase_2 = {
    ID = "UI_Passport_Money_Item_New_Text_C_Purchase_2",
    Content = "PanelText_UI_Passport_Money_Item_New_Text_C_Purchase_2_Content|已购买"
  },
  UI_Passport_Money_Item_New_Text_C_ThisIssue = {
    ID = "UI_Passport_Money_Item_New_Text_C_ThisIssue",
    Content = "PanelText_UI_Passport_Money_Item_New_Text_C_ThisIssue_Content|完成所有课题可累计获得"
  },
  UI_Passport_Money_Item_New_Text_C_Hoist_1 = {
    ID = "UI_Passport_Money_Item_New_Text_C_Hoist_1",
    Content = "PanelText_UI_Passport_Money_Item_New_Text_C_Hoist_1_Content|立即提升"
  },
  UI_Passport_Money_Item_New_Text_C_Hoist_2 = {
    ID = "UI_Passport_Money_Item_New_Text_C_Hoist_2",
    Content = "PanelText_UI_Passport_Money_Item_New_Text_C_Hoist_2_Content|10"
  },
  UI_Passport_Money_Item_New_Text_C_Hoist_3 = {
    ID = "UI_Passport_Money_Item_New_Text_C_Hoist_3",
    Content = "PanelText_UI_Passport_Money_Item_New_Text_C_Hoist_3_Content|级"
  },
  UI_Passport_Money_Item_New_Text_C_Hoist_4 = {
    ID = "UI_Passport_Money_Item_New_Text_C_Hoist_4",
    Content = "PanelText_UI_Passport_Money_Item_New_Text_C_Hoist_4_Content|课题等级"
  },
  UI_Passport_Money_Item_New_Text_C_Introduce = {
    ID = "UI_Passport_Money_Item_New_Text_C_Introduce",
    Content = "PanelText_UI_Passport_Money_Item_New_Text_C_Introduce_Content|解锁高阶课题并提升到40级，可在课题礼匣中选一个命轮或「流明之芯」×5作为奖励"
  },
  UI_Passport_Money_Item_New_Text_C_Prompt = {
    ID = "UI_Passport_Money_Item_New_Text_C_Prompt",
    Content = "PanelText_UI_Passport_Money_Item_New_Text_C_Prompt_Content|请适度娱乐，理性消费"
  },
  UI_Event_Activity_RewardList_Text_C_Reward = {
    ID = "UI_Event_Activity_RewardList_Text_C_Reward",
    Content = "PanelText_UI_Event_Activity_RewardList_Text_C_Reward_Content|义卖清单"
  },
  UI_Event_Activity_RewardResult_Text_C_Result = {
    ID = "UI_Event_Activity_RewardResult_Text_C_Result",
    Content = "PanelText_UI_Event_Activity_RewardResult_Text_C_Result_Content|交换结果"
  },
  UI_Event_Activity_RewardResult_Text_C_CoreReward = {
    ID = "UI_Event_Activity_RewardResult_Text_C_CoreReward",
    Content = "PanelText_UI_Event_Activity_RewardResult_Text_C_CoreReward_Content|特殊种子"
  },
  UI_Popup_DonationBox_Text_C_Reward = {
    ID = "UI_Popup_DonationBox_Text_C_Reward",
    Content = "PanelText_UI_Popup_DonationBox_Text_C_Reward_Content|物资"
  },
  UI_Popup_DonationBox_Text_C_SpeedTitle = {
    ID = "UI_Popup_DonationBox_Text_C_SpeedTitle",
    Content = "PanelText_UI_Popup_DonationBox_Text_C_SpeedTitle_Content|获取速度："
  },
  UI_Awaker_Item_Topped_Detail_Text_C_Title = {
    ID = "UI_Awaker_Item_Topped_Detail_Text_C_Title",
    Content = "PanelText_UI_Awaker_Item_Topped_Detail_Text_C_Title_Content|升格条件<WordSize20:（任选其一）>"
  },
  UI_Awaker_Item_Topped_Detail_Text_C_Condition_2 = {
    ID = "UI_Awaker_Item_Topped_Detail_Text_C_Condition_2",
    Content = "PanelText_UI_Awaker_Item_Topped_Detail_Text_C_Condition_2_Content|选项二"
  },
  UI_Awaker_Item_Topped_Detail_Text_C_Condition_3 = {
    ID = "UI_Awaker_Item_Topped_Detail_Text_C_Condition_3",
    Content = "PanelText_UI_Awaker_Item_Topped_Detail_Text_C_Condition_3_Content|选项三"
  },
  UI_Chapter_Spur_View_Text_C_Simple = {
    ID = "UI_Chapter_Spur_View_Text_C_Simple",
    Content = "PanelText_UI_Chapter_Spur_View_Text_C_Simple_Content|普通"
  },
  UI_Chapter_Spur_View_Text_C_Difficulty = {
    ID = "UI_Chapter_Spur_View_Text_C_Difficulty",
    Content = "PanelText_UI_Chapter_Spur_View_Text_C_Difficulty_Content|困难"
  },
  UI_Chapter_Spur_View_Text_C_Nightmare = {
    ID = "UI_Chapter_Spur_View_Text_C_Nightmare",
    Content = "PanelText_UI_Chapter_Spur_View_Text_C_Nightmare_Content|癫狂"
  },
  UI_Chapter_Spur_View_Text_C_Progress = {
    ID = "UI_Chapter_Spur_View_Text_C_Progress",
    Content = "PanelText_UI_Chapter_Spur_View_Text_C_Progress_Content|收集进度"
  },
  UI_Chapter_Spur_View_Text_C_Tab_Special = {
    ID = "UI_Chapter_Spur_View_Text_C_Tab_Special",
    Content = "PanelText_UI_Chapter_Spur_View_Text_C_Tab_Special_Content|限时活动"
  },
  UI_Chapter_Spur_View_Text_C_Resonance = {
    ID = "UI_Chapter_Spur_View_Text_C_Resonance",
    Content = "PanelText_UI_Chapter_Spur_View_Text_C_Resonance_Content|共鸣"
  },
  UI_Event_Panel_Activity_Fundraising_Text_C_Title = {
    ID = "UI_Event_Panel_Activity_Fundraising_Text_C_Title",
    Content = "PanelText_UI_Event_Panel_Activity_Fundraising_Text_C_Title_Content|圣堂区域"
  },
  UI_Event_Panel_Activity_Fundraising_Text_C_Resonance = {
    ID = "UI_Event_Panel_Activity_Fundraising_Text_C_Resonance",
    Content = "PanelText_UI_Event_Panel_Activity_Fundraising_Text_C_Resonance_Content|共鸣"
  },
  UI_Event_Panel_Challenge_Text_C_Leader = {
    ID = "UI_Event_Panel_Challenge_Text_C_Leader",
    Content = "PanelText_UI_Event_Panel_Challenge_Text_C_Leader_Content|首领预览<WordSize20:>"
  },
  UI_Passport_Reward_Item_New_Text_C_Name_2 = {
    ID = "UI_Passport_Reward_Item_New_Text_C_Name_2",
    Content = "PanelText_UI_Passport_Reward_Item_New_Text_C_Name_2_Content|购买等级"
  },
  UI_Passport_Panel_Main_New_Text_C_Title = {
    ID = "UI_Passport_Panel_Main_New_Text_C_Title",
    Content = "PanelText_UI_Passport_Panel_Main_New_Text_C_Title_Content|学期课题"
  },
  UI_Passport_Panel_Main_New_Text_C_Mail = {
    ID = "UI_Passport_Panel_Main_New_Text_C_Mail",
    Content = "PanelText_UI_Passport_Panel_Main_New_Text_C_Mail_Content|规则说明"
  },
  UI_Events_Panel_Banquet_Text_C_Not_unlocked = {
    ID = "UI_Events_Panel_Banquet_Text_C_Not_unlocked",
    Content = "PanelText_UI_Events_Panel_Banquet_Text_C_Not_unlocked_Content|<Gray:未解锁>"
  },
  UI_Awaker_Item_Weapon_Strengthen2_Text_C_Title = {
    ID = "UI_Awaker_Item_Weapon_Strengthen2_Text_C_Title",
    Content = "PanelText_UI_Awaker_Item_Weapon_Strengthen2_Text_C_Title_Content|命轮详情"
  },
  UI_Event_Activity_DonationBox_Text_C_Reward = {
    ID = "UI_Event_Activity_DonationBox_Text_C_Reward",
    Content = "PanelText_UI_Event_Activity_DonationBox_Text_C_Reward_Content|物资"
  },
  UI_Event_Activity_DonationBox_Text_C_None = {
    ID = "UI_Event_Activity_DonationBox_Text_C_None",
    Content = "PanelText_UI_Event_Activity_DonationBox_Text_C_None_Content|暂无募捐物资"
  },
  UI_Event_Activity_DonationBox_Text_C_Max = {
    ID = "UI_Event_Activity_DonationBox_Text_C_Max",
    Content = "PanelText_UI_Event_Activity_DonationBox_Text_C_Max_Content|Max"
  },
  UI_Event_Activity_DonationBox_Text_C_Full = {
    ID = "UI_Event_Activity_DonationBox_Text_C_Full",
    Content = "PanelText_UI_Event_Activity_DonationBox_Text_C_Full_Content|物资已达上限"
  },
  UI_Event_Activity_DonationBox_Text_C_SpeedTitle = {
    ID = "UI_Event_Activity_DonationBox_Text_C_SpeedTitle",
    Content = "PanelText_UI_Event_Activity_DonationBox_Text_C_SpeedTitle_Content|获取速度："
  },
  UI_Event_Activity_Thing_Item_Text_C_Sold_Out = {
    ID = "UI_Event_Activity_Thing_Item_Text_C_Sold_Out",
    Content = "PanelText_UI_Event_Activity_Thing_Item_Text_C_Sold_Out_Content|已售罄"
  },
  UI_Event_Activity_RewardPool_Text_C_Tip = {
    ID = "UI_Event_Activity_RewardPool_Text_C_Tip"
  },
  UI_Event_Activity_Main_Text_C_Normal_1 = {
    ID = "UI_Event_Activity_Main_Text_C_Normal_1",
    Content = "PanelText_UI_Event_Activity_Main_Text_C_Normal_1_Content|Ⅰ"
  },
  UI_Event_Activity_Main_Text_C_Select_1 = {
    ID = "UI_Event_Activity_Main_Text_C_Select_1",
    Content = "PanelText_UI_Event_Activity_Main_Text_C_Select_1_Content|Ⅰ"
  },
  UI_Event_Activity_Main_Text_C_Normal_2 = {
    ID = "UI_Event_Activity_Main_Text_C_Normal_2",
    Content = "PanelText_UI_Event_Activity_Main_Text_C_Normal_2_Content|Ⅱ"
  },
  UI_Event_Activity_Main_Text_C_Select_2 = {
    ID = "UI_Event_Activity_Main_Text_C_Select_2",
    Content = "PanelText_UI_Event_Activity_Main_Text_C_Select_2_Content|Ⅱ"
  },
  UI_Event_Activity_Main_Text_C_Normal_3 = {
    ID = "UI_Event_Activity_Main_Text_C_Normal_3",
    Content = "PanelText_UI_Event_Activity_Main_Text_C_Normal_3_Content|Ⅲ"
  },
  UI_Event_Activity_Main_Text_C_Select_3 = {
    ID = "UI_Event_Activity_Main_Text_C_Select_3",
    Content = "PanelText_UI_Event_Activity_Main_Text_C_Select_3_Content|Ⅲ"
  },
  UI_Event_Activity_Main_Text_C_Mail = {
    ID = "UI_Event_Activity_Main_Text_C_Mail",
    Content = "PanelText_UI_Event_Activity_Main_Text_C_Mail_Content|规则说明"
  },
  UI_Awaker_PanelStory_Main_Text_C_Story = {
    ID = "UI_Awaker_PanelStory_Main_Text_C_Story",
    Content = "PanelText_UI_Awaker_PanelStory_Main_Text_C_Story_Content|故事"
  },
  UI_Common_Item_Detail_Text_C_Close = {
    ID = "UI_Common_Item_Detail_Text_C_Close",
    Content = "PanelText_UI_Common_Item_Detail_Text_C_Close_Content|收起"
  },
  UI_Common_Item_Detail_Text_C_Equipped = {
    ID = "UI_Common_Item_Detail_Text_C_Equipped",
    Content = "PanelText_UI_Common_Item_Detail_Text_C_Equipped_Content|已装备"
  },
  UI_Event_Activity_Main_Text_C_Label = {
    ID = "UI_Event_Activity_Main_Text_C_Label",
    Content = "PanelText_UI_Event_Activity_Main_Text_C_Label_Content|格雷太太的小店"
  },
  UI_Event_Panel_Challenge_Text_C_Name = {
    ID = "UI_Event_Panel_Challenge_Text_C_Name"
  },
  UI_Event_Activity_Thing_Item_Text_C_Special_Tips = {
    ID = "UI_Event_Activity_Thing_Item_Text_C_Special_Tips",
    Content = "PanelText_UI_Event_Activity_Thing_Item_Text_C_Special_Tips_Content|特殊"
  },
  UI_Events_Panel_Main_Text_C_Pv = {
    ID = "UI_Events_Panel_Main_Text_C_Pv",
    Content = "PanelText_UI_Events_Panel_Main_Text_C_Pv_Content|播放影像"
  },
  UI_Events_Panel_Banquet_Text_C_Fill_Up = {
    ID = "UI_Events_Panel_Banquet_Text_C_Fill_Up",
    Content = "PanelText_UI_Events_Panel_Banquet_Text_C_Fill_Up_Content|(距离存储上限："
  },
  UI_Events_Panel_Banquet_Text_C_Pv = {
    ID = "UI_Events_Panel_Banquet_Text_C_Pv",
    Content = "PanelText_UI_Events_Panel_Banquet_Text_C_Pv_Content|溯梦"
  },
  UI_Event_Activity_RewardResult_Text_C_Close = {
    ID = "UI_Event_Activity_RewardResult_Text_C_Close",
    Content = "PanelText_UI_Event_Activity_RewardResult_Text_C_Close_Content|点击空白处返回"
  },
  UI_Events_Panel_Banquet_Text_C_Symbol = {
    ID = "UI_Events_Panel_Banquet_Text_C_Symbol",
    Content = "PanelText_UI_Events_Panel_Banquet_Text_C_Symbol_Content|)"
  },
  UI_Event_Activity_RewardPool_Text_C_Name = {
    ID = "UI_Event_Activity_RewardPool_Text_C_Name",
    Content = "PanelText_UI_Event_Activity_RewardPool_Text_C_Name_Content|重置"
  },
  UI_Awaker_Item_Minihead_List_Text_C_Talent = {
    ID = "UI_Awaker_Item_Minihead_List_Text_C_Talent",
    Content = "PanelText_UI_Awaker_Item_Minihead_List_Text_C_Talent_Content|天赋"
  },
  UI_Awaker_Item_Minihead_List_Text_C_TalentSelected = {
    ID = "UI_Awaker_Item_Minihead_List_Text_C_TalentSelected",
    Content = "PanelText_UI_Awaker_Item_Minihead_List_Text_C_TalentSelected_Content|天赋"
  },
  UI_Awaker_Popup_Talent_Main_Text_C_Current = {
    ID = "UI_Awaker_Popup_Talent_Main_Text_C_Current",
    Content = "PanelText_UI_Awaker_Popup_Talent_Main_Text_C_Current_Content|当前"
  },
  UI_Awaker_Popup_Talent_Main_Text_C_Lower = {
    ID = "UI_Awaker_Popup_Talent_Main_Text_C_Lower",
    Content = "PanelText_UI_Awaker_Popup_Talent_Main_Text_C_Lower_Content|下一级"
  },
  UI_Awaker_Popup_Talent_Main_Text_Require = {
    ID = "UI_Awaker_Popup_Talent_Main_Text_Require",
    Content = "PanelText_UI_Awaker_Popup_Talent_Main_Text_Require_Content|消耗材料"
  },
  UI_Awaker_Popup_Talent_Main_Text_C_Warning_EN = {
    ID = "UI_Awaker_Popup_Talent_Main_Text_C_Warning_EN",
    Content = "PanelText_UI_Awaker_Popup_Talent_Main_Text_C_Warning_EN_Content|preconditions"
  },
  UI_Battle_Popup_Record_Tip_New_Text_C_Talent = {
    ID = "UI_Battle_Popup_Record_Tip_New_Text_C_Talent",
    Content = "PanelText_UI_Battle_Popup_Record_Tip_New_Text_C_Talent_Content|天赋"
  },
  UI_Social_Panel_HelpList_Item_Text_C_Recent = {
    ID = "UI_Social_Panel_HelpList_Item_Text_C_Recent",
    Content = "PanelText_UI_Social_Panel_HelpList_Item_Text_C_Recent_Content|最近助战"
  },
  UI_Awaker_Popup_Talent_Main_Text_C_Lv = {
    ID = "UI_Awaker_Popup_Talent_Main_Text_C_Lv",
    Content = "PanelText_UI_Awaker_Popup_Talent_Main_Text_C_Lv_Content|Lv."
  },
  UI_Common_Melt_Disaster_Text_C_Suppress = {
    ID = "UI_Common_Melt_Disaster_Text_C_Suppress",
    Content = "PanelText_UI_Common_Melt_Disaster_Text_C_Suppress_Content|融灾黑潮"
  },
  UI_Team_Panel_Main_Text_C_Empty = {
    ID = "UI_Team_Panel_Main_Text_C_Empty",
    Content = "PanelText_UI_Team_Panel_Main_Text_C_Empty_Content|未装备钥令"
  },
  UI_Main_Panel_1_Text_C_Welfare = {
    ID = "UI_Main_Panel_1_Text_C_Welfare",
    Content = "PanelText_UI_Main_Panel_1_Text_C_Welfare_Content|海量福利，限时领取"
  },
  UI_Awaker_Popup_Talent_Main_Text_C_Condition = {
    ID = "UI_Awaker_Popup_Talent_Main_Text_C_Condition",
    Content = "PanelText_UI_Awaker_Popup_Talent_Main_Text_C_Condition_Content|解锁条件"
  },
  UI_Pvp_Popup_Expression_Manage_Text_C_Use = {
    ID = "UI_Pvp_Popup_Expression_Manage_Text_C_Use",
    Content = "PanelText_UI_Pvp_Popup_Expression_Manage_Text_C_Use_Content|对战表情"
  },
  UI_Pvp_Panel_Main_1_Text_C_Expression = {
    ID = "UI_Pvp_Panel_Main_1_Text_C_Expression",
    Content = "PanelText_UI_Pvp_Panel_Main_1_Text_C_Expression_Content|对战表情"
  },
  UI_Pvp_Panel_Main_1_Text_C_Integral = {
    ID = "UI_Pvp_Panel_Main_1_Text_C_Integral",
    Content = "PanelText_UI_Pvp_Panel_Main_1_Text_C_Integral_Content|赛季积分"
  },
  UI_Pvp_Panel_Main_1_Text_C_Victory = {
    ID = "UI_Pvp_Panel_Main_1_Text_C_Victory",
    Content = "PanelText_UI_Pvp_Panel_Main_1_Text_C_Victory_Content|胜场累计："
  },
  UI_Pvp_Panel_Main_1_Text_C_Award = {
    ID = "UI_Pvp_Panel_Main_1_Text_C_Award",
    Content = "PanelText_UI_Pvp_Panel_Main_1_Text_C_Award_Content|胜场奖励"
  },
  UI_Pvp_Panel_Main_1_Text_C_Ranking = {
    ID = "UI_Pvp_Panel_Main_1_Text_C_Ranking",
    Content = "PanelText_UI_Pvp_Panel_Main_1_Text_C_Ranking_Content|排行榜"
  },
  UI_Pvp_Popup_Tips2_Text_C_Highest = {
    ID = "UI_Pvp_Popup_Tips2_Text_C_Highest",
    Content = "PanelText_UI_Pvp_Popup_Tips2_Text_C_Highest_Content|历史最高对弈积分："
  },
  UI_Pvp_Popup_Tips2_Text_C_OneKey = {
    ID = "UI_Pvp_Popup_Tips2_Text_C_OneKey",
    Content = "PanelText_UI_Pvp_Popup_Tips2_Text_C_OneKey_Content|一键领取"
  },
  UI_Pvp_Panel_lineup_Show_Text_C_Point_01 = {
    ID = "UI_Pvp_Panel_lineup_Show_Text_C_Point_01",
    Content = "PanelText_UI_Pvp_Panel_lineup_Show_Text_C_Point_01_Content|分"
  },
  UI_Pvp_Panel_lineup_Show_Text_C_Point_02 = {
    ID = "UI_Pvp_Panel_lineup_Show_Text_C_Point_02",
    Content = "PanelText_UI_Pvp_Panel_lineup_Show_Text_C_Point_02_Content|分"
  },
  UI_Pvp_Panel_Settlement_Text_C_Point_01 = {
    ID = "UI_Pvp_Panel_Settlement_Text_C_Point_01",
    Content = "PanelText_UI_Pvp_Panel_Settlement_Text_C_Point_01_Content|分"
  },
  UI_Pvp_Panel_Settlement_Text_C_Point_02 = {
    ID = "UI_Pvp_Panel_Settlement_Text_C_Point_02",
    Content = "PanelText_UI_Pvp_Panel_Settlement_Text_C_Point_02_Content|分"
  },
  UI_Pvp_Item_Ranking_Text_C_Current = {
    ID = "UI_Pvp_Item_Ranking_Text_C_Current",
    Content = "PanelText_UI_Pvp_Item_Ranking_Text_C_Current_Content|当前奖励"
  },
  UI_Pvp_Item_Ranking_Text_C_Over = {
    ID = "UI_Pvp_Item_Ranking_Text_C_Over",
    Content = "PanelText_UI_Pvp_Item_Ranking_Text_C_Over_Content|~"
  },
  UI_Pvp_Panel_Out_Text_C_Integral = {
    ID = "UI_Pvp_Panel_Out_Text_C_Integral",
    Content = "PanelText_UI_Pvp_Panel_Out_Text_C_Integral_Content|赛季积分"
  },
  UI_Pvp_Popup_Tips_Text_C_Game1 = {
    ID = "UI_Pvp_Popup_Tips_Text_C_Game1",
    Content = "PanelText_UI_Pvp_Popup_Tips_Text_C_Game1_Content|本周排行"
  },
  UI_Pvp_Popup_Tips_Text_C_Game2 = {
    ID = "UI_Pvp_Popup_Tips_Text_C_Game2",
    Content = "PanelText_UI_Pvp_Popup_Tips_Text_C_Game2_Content|本周排行"
  },
  UI_Pvp_Popup_Tips_Text_C_Activity1 = {
    ID = "UI_Pvp_Popup_Tips_Text_C_Activity1",
    Content = "PanelText_UI_Pvp_Popup_Tips_Text_C_Activity1_Content|排行奖励"
  },
  UI_Pvp_Popup_Tips_Text_C_Activity4 = {
    ID = "UI_Pvp_Popup_Tips_Text_C_Activity4",
    Content = "PanelText_UI_Pvp_Popup_Tips_Text_C_Activity4_Content|排行奖励"
  },
  UI_Pvp_Popup_Tips_Text_C_Activity3 = {
    ID = "UI_Pvp_Popup_Tips_Text_C_Activity3",
    Content = "PanelText_UI_Pvp_Popup_Tips_Text_C_Activity3_Content|赛季排行"
  },
  UI_Pvp_Popup_Tips_Text_C_Activity2 = {
    ID = "UI_Pvp_Popup_Tips_Text_C_Activity2",
    Content = "PanelText_UI_Pvp_Popup_Tips_Text_C_Activity2_Content|赛季排行"
  },
  UI_Pvp_Popup_Tips_Text_C_Grade = {
    ID = "UI_Pvp_Popup_Tips_Text_C_Grade",
    Content = "PanelText_UI_Pvp_Popup_Tips_Text_C_Grade_Content|排名"
  },
  UI_Pvp_Popup_Tips_Text_C_Big = {
    ID = "UI_Pvp_Popup_Tips_Text_C_Big",
    Content = "PanelText_UI_Pvp_Popup_Tips_Text_C_Big_Content|守密人信息"
  },
  UI_Pvp_Popup_Tips_Text_C_Small = {
    ID = "UI_Pvp_Popup_Tips_Text_C_Small",
    Content = "PanelText_UI_Pvp_Popup_Tips_Text_C_Small_Content|对弈头衔"
  },
  UI_Pvp_Popup_Tips_Text_C_Reward = {
    ID = "UI_Pvp_Popup_Tips_Text_C_Reward",
    Content = "PanelText_UI_Pvp_Popup_Tips_Text_C_Reward_Content|赛季最高积分"
  },
  UI_Pvp_Popup_Tips_Text_C_Title_2 = {
    ID = "UI_Pvp_Popup_Tips_Text_C_Title_2",
    Content = "PanelText_UI_Pvp_Popup_Tips_Text_C_Title_2_Content|对弈头衔"
  },
  UI_Pvp_Popup_Tips_Text_C_Scope = {
    ID = "UI_Pvp_Popup_Tips_Text_C_Scope",
    Content = "PanelText_UI_Pvp_Popup_Tips_Text_C_Scope_Content|排名范围"
  },
  UI_Pvp_Popup_Tips_Text_C_Award = {
    ID = "UI_Pvp_Popup_Tips_Text_C_Award",
    Content = "PanelText_UI_Pvp_Popup_Tips_Text_C_Award_Content|奖励"
  },
  UI_Pvp_Panel_Main_1_Text_C_Record = {
    ID = "UI_Pvp_Panel_Main_1_Text_C_Record",
    Content = "PanelText_UI_Pvp_Panel_Main_1_Text_C_Record_Content|对弈纪录"
  },
  UI_Event_Panel_Activity_TwentyFour_Text_C_Title = {
    ID = "UI_Event_Panel_Activity_TwentyFour_Text_C_Title",
    Content = "PanelText_UI_Event_Panel_Activity_TwentyFour_Text_C_Title_Content|记忆编码"
  },
  UI_Event_Panel_Activity_TwentyFour_Text_C_Resonance = {
    ID = "UI_Event_Panel_Activity_TwentyFour_Text_C_Resonance",
    Content = "PanelText_UI_Event_Panel_Activity_TwentyFour_Text_C_Resonance_Content|共鸣"
  },
  UI_Event_Activity_TwentyFour_Text_C_Reward = {
    ID = "UI_Event_Activity_TwentyFour_Text_C_Reward",
    Content = "PanelText_UI_Event_Activity_TwentyFour_Text_C_Reward_Content|存储物质"
  },
  UI_Event_Activity_TwentyFour_Text_C_Max = {
    ID = "UI_Event_Activity_TwentyFour_Text_C_Max",
    Content = "PanelText_UI_Event_Activity_TwentyFour_Text_C_Max_Content|Max"
  },
  UI_Event_Activity_TwentyFour_Text_C_Full = {
    ID = "UI_Event_Activity_TwentyFour_Text_C_Full",
    Content = "PanelText_UI_Event_Activity_TwentyFour_Text_C_Full_Content|存储物质已达上限"
  },
  UI_Event_Activity_TwentyFour_Text_C_Finish = {
    ID = "UI_Event_Activity_TwentyFour_Text_C_Finish",
    Content = "PanelText_UI_Event_Activity_TwentyFour_Text_C_Finish_Content|活动已结束，已停止存储"
  },
  UI_Event_Activity_TwentyFour_Text_C_SpeedTitle = {
    ID = "UI_Event_Activity_TwentyFour_Text_C_SpeedTitle",
    Content = "PanelText_UI_Event_Activity_TwentyFour_Text_C_SpeedTitle_Content|存储速度:"
  },
  UI_Event_Activity_TwentyFour_Text_C_Title = {
    ID = "UI_Event_Activity_TwentyFour_Text_C_Title",
    Content = "PanelText_UI_Event_Activity_TwentyFour_Text_C_Title_Content|边缘储存"
  },
  UI_Pvp_Popup_Tips2_Text_C_Title = {
    ID = "UI_Pvp_Popup_Tips2_Text_C_Title",
    Content = "PanelText_UI_Pvp_Popup_Tips2_Text_C_Title_Content|对弈纪录"
  },
  UI_Pvp_Popup_Expression_Manage_Text_C_Title = {
    ID = "UI_Pvp_Popup_Expression_Manage_Text_C_Title",
    Content = "PanelText_UI_Pvp_Popup_Expression_Manage_Text_C_Title_Content|表情管理"
  },
  UI_Pvp_Popup_Tips_Text_C_Hint = {
    ID = "UI_Pvp_Popup_Tips_Text_C_Hint",
    Content = "PanelText_UI_Pvp_Popup_Tips_Text_C_Hint_Content|本赛季获胜一场即可在赛季结束时获得结算奖励。"
  },
  UI_Events_Panel_TwentyFour_Text_C_Reward = {
    ID = "UI_Events_Panel_TwentyFour_Text_C_Reward",
    Content = "PanelText_UI_Events_Panel_TwentyFour_Text_C_Reward_Content|成就奖励"
  },
  UI_Events_Panel_TwentyFour_Text_C_Resonance = {
    ID = "UI_Events_Panel_TwentyFour_Text_C_Resonance",
    Content = "PanelText_UI_Events_Panel_TwentyFour_Text_C_Resonance_Content|共鸣：分离性症候"
  },
  UI_Events_Panel_TwentyFour_Text_C_Diagonal = {
    ID = "UI_Events_Panel_TwentyFour_Text_C_Diagonal",
    Content = "PanelText_UI_Events_Panel_TwentyFour_Text_C_Diagonal_Content|/"
  },
  UI_Events_Panel_TwentyFour_Text_C_Record = {
    ID = "UI_Events_Panel_TwentyFour_Text_C_Record",
    Content = "PanelText_UI_Events_Panel_TwentyFour_Text_C_Record_Content|宁静的裂殖"
  },
  UI_Events_Panel_TwentyFour_Text_C_RecordTip = {
    ID = "UI_Events_Panel_TwentyFour_Text_C_RecordTip",
    Content = "PanelText_UI_Events_Panel_TwentyFour_Text_C_RecordTip_Content|限时免费解锁"
  },
  UI_Events_Panel_TwentyFour_Text_C_Challenge = {
    ID = "UI_Events_Panel_TwentyFour_Text_C_Challenge",
    Content = "PanelText_UI_Events_Panel_TwentyFour_Text_C_Challenge_Content|记忆编码"
  },
  UI_Events_Panel_TwentyFour_Text_C_ChallengeTip = {
    ID = "UI_Events_Panel_TwentyFour_Text_C_ChallengeTip",
    Content = "PanelText_UI_Events_Panel_TwentyFour_Text_C_ChallengeTip_Content|玩法限时开放"
  },
  UI_Events_Panel_TwentyFour_Text_C_Topic = {
    ID = "UI_Events_Panel_TwentyFour_Text_C_Topic",
    Content = "PanelText_UI_Events_Panel_TwentyFour_Text_C_Topic_Content|多重疗愈·复刻"
  },
  UI_Events_Panel_TwentyFour_Text_C_Shop = {
    ID = "UI_Events_Panel_TwentyFour_Text_C_Shop",
    Content = "PanelText_UI_Events_Panel_TwentyFour_Text_C_Shop_Content|人格解析"
  },
  UI_Events_Panel_TwentyFour_Text_C_Receive = {
    ID = "UI_Events_Panel_TwentyFour_Text_C_Receive",
    Content = "PanelText_UI_Events_Panel_TwentyFour_Text_C_Receive_Content|距离可领取"
  },
  UI_Events_Panel_TwentyFour_Text_C_Max = {
    ID = "UI_Events_Panel_TwentyFour_Text_C_Max",
    Content = "PanelText_UI_Events_Panel_TwentyFour_Text_C_Max_Content|Max"
  },
  UI_Events_Panel_TwentyFour_Text_C_Symbol = {
    ID = "UI_Events_Panel_TwentyFour_Text_C_Symbol",
    Content = "PanelText_UI_Events_Panel_TwentyFour_Text_C_Symbol_Content|)"
  },
  UI_Events_Panel_TwentyFour_Text_C_Fill_Up = {
    ID = "UI_Events_Panel_TwentyFour_Text_C_Fill_Up",
    Content = "PanelText_UI_Events_Panel_TwentyFour_Text_C_Fill_Up_Content|(距离存储上限："
  },
  UI_Events_Panel_TwentyFour_Text_C_Can_Unlockable = {
    ID = "UI_Events_Panel_TwentyFour_Text_C_Can_Unlockable",
    Content = "PanelText_UI_Events_Panel_TwentyFour_Text_C_Can_Unlockable_Content|可领取"
  },
  UI_Events_Panel_TwentyFour_Text_C_Not_unlocked = {
    ID = "UI_Events_Panel_TwentyFour_Text_C_Not_unlocked",
    Content = "PanelText_UI_Events_Panel_TwentyFour_Text_C_Not_unlocked_Content|<Gray:未解锁>"
  },
  UI_Events_Panel_TwentyFour_Text_C_Finished = {
    ID = "UI_Events_Panel_TwentyFour_Text_C_Finished",
    Content = "PanelText_UI_Events_Panel_TwentyFour_Text_C_Finished_Content|已结束"
  },
  UI_Events_Panel_TwentyFour_Text_C_Pv = {
    ID = "UI_Events_Panel_TwentyFour_Text_C_Pv",
    Content = "PanelText_UI_Events_Panel_TwentyFour_Text_C_Pv_Content|播放影像"
  },
  UI_Events_Item_TwentyFour_Text_C_Diagonal = {
    ID = "UI_Events_Item_TwentyFour_Text_C_Diagonal",
    Content = "PanelText_UI_Events_Item_TwentyFour_Text_C_Diagonal_Content|/"
  },
  UI_Events_Item_TwentyFour_Text_C_Fall = {
    ID = "UI_Events_Item_TwentyFour_Text_C_Fall",
    Content = "PanelText_UI_Events_Item_TwentyFour_Text_C_Fall_Content|掉落预览"
  },
  UI_Events_Item_TwentyFour_Text_C_LockTips = {
    ID = "UI_Events_Item_TwentyFour_Text_C_LockTips",
    Content = "PanelText_UI_Events_Item_TwentyFour_Text_C_LockTips_Content|完成特遣纪录前置关卡解锁"
  },
  UI_Events_Item_Lake_City_Text_C_LockTips = {
    ID = "UI_Events_Item_Lake_City_Text_C_LockTips",
    Content = "PanelText_UI_Events_Item_Lake_City_Text_C_LockTips_Content|关卡解锁提示"
  },
  UI_Event_Activity_DonationBox_Text_C_Finish = {
    ID = "UI_Event_Activity_DonationBox_Text_C_Finish",
    Content = "PanelText_UI_Event_Activity_DonationBox_Text_C_Finish_Content|活动已结束"
  },
  UI_Events_Panel_TwentyFour_Text_C_Finish = {
    ID = "UI_Events_Panel_TwentyFour_Text_C_Finish",
    Content = "PanelText_UI_Events_Panel_TwentyFour_Text_C_Finish_Content|已结束"
  },
  UI_Events_Panel_Banquet_Text_C_Finish = {
    ID = "UI_Events_Panel_Banquet_Text_C_Finish",
    Content = "PanelText_UI_Events_Panel_Banquet_Text_C_Finish_Content|已结束"
  },
  UI_Events_Panel_Banquet_Text_C_Finished = {
    ID = "UI_Events_Panel_Banquet_Text_C_Finished",
    Content = "PanelText_UI_Events_Panel_Banquet_Text_C_Finished_Content|已结束"
  },
  UI_Event_Panel_Activity_TwentyFour_Text_C_Introduction = {
    ID = "UI_Event_Panel_Activity_TwentyFour_Text_C_Introduction",
    Content = "PanelText_UI_Event_Panel_Activity_TwentyFour_Text_C_Introduction_Content|嘘……深呼吸，放松你的触手。 现在你将潜入「24」的意识深处，探寻隐秘的记忆……"
  },
  UI_Common_Awaker_Favor_Text_C_Sync = {
    ID = "UI_Common_Awaker_Favor_Text_C_Sync",
    Content = "PanelText_UI_Common_Awaker_Favor_Text_C_Sync_Content|唤醒体同调率提升"
  },
  UI_Pvp_Popup_Tips_Text_C_NoTask = {
    ID = "UI_Pvp_Popup_Tips_Text_C_NoTask",
    Content = "PanelText_UI_Pvp_Popup_Tips_Text_C_NoTask_Content|暂无记录"
  },
  UI_Pvp_Popup_Tips_Text_C_En = {
    ID = "UI_Pvp_Popup_Tips_Text_C_En",
    Content = "PanelText_UI_Pvp_Popup_Tips_Text_C_En_Content|fdshsjfgjgf"
  },
  UI_Pvp_Popup_Tips_Text_C_RankTip = {
    ID = "UI_Pvp_Popup_Tips_Text_C_RankTip",
    Content = "PanelText_UI_Pvp_Popup_Tips_Text_C_RankTip_Content|本赛季参与一场即可进入「赛季排行」。"
  },
  UI_Pvp_Panel_Formation_Text_C_Empty_1 = {
    ID = "UI_Pvp_Panel_Formation_Text_C_Empty_1",
    Content = "PanelText_UI_Pvp_Panel_Formation_Text_C_Empty_1_Content|请从左侧选择上场"
  },
  UI_Pvp_Panel_Formation_Text_C_Time = {
    ID = "UI_Pvp_Panel_Formation_Text_C_Time",
    Content = "PanelText_UI_Pvp_Panel_Formation_Text_C_Time_Content|可通过特定途径获取"
  },
  UI_Pvp_Panel_Formation_Text_C_None2 = {
    ID = "UI_Pvp_Panel_Formation_Text_C_None2",
    Content = "PanelText_UI_Pvp_Panel_Formation_Text_C_None2_Content|No material yet"
  },
  UI_Dungeons_Panel_Try_Text_C_Introduce = {
    ID = "UI_Dungeons_Panel_Try_Text_C_Introduce",
    Content = "PanelText_UI_Dungeons_Panel_Try_Text_C_Introduce_Content|能力介绍"
  },
  UI_Dungeons_Panel_Try_Text_C_Wake = {
    ID = "UI_Dungeons_Panel_Try_Text_C_Wake",
    Content = "PanelText_UI_Dungeons_Panel_Try_Text_C_Wake_Content|前往唤醒"
  },
  UI_Dungeons_Panel_Try_Text_C_Award = {
    ID = "UI_Dungeons_Panel_Try_Text_C_Award",
    Content = "PanelText_UI_Dungeons_Panel_Try_Text_C_Award_Content|完成奖励"
  },
  UI_Dungeons_Panel_Try_Text_C_Undone = {
    ID = "UI_Dungeons_Panel_Try_Text_C_Undone",
    Content = "PanelText_UI_Dungeons_Panel_Try_Text_C_Undone_Content|未完成"
  },
  UI_Chapter_Hard_Swich_Group_New_Text_C_Remember = {
    ID = "UI_Chapter_Hard_Swich_Group_New_Text_C_Remember",
    Content = "PanelText_UI_Chapter_Hard_Swich_Group_New_Text_C_Remember_Content|溯梦"
  },
  UI_Chapter_Hard_Swich_Group_New_Text_C_Simple = {
    ID = "UI_Chapter_Hard_Swich_Group_New_Text_C_Simple",
    Content = "PanelText_UI_Chapter_Hard_Swich_Group_New_Text_C_Simple_Content|简单"
  },
  UI_Chapter_Hard_Swich_Group_New_Text_C_Difficulty = {
    ID = "UI_Chapter_Hard_Swich_Group_New_Text_C_Difficulty",
    Content = "PanelText_UI_Chapter_Hard_Swich_Group_New_Text_C_Difficulty_Content|困难"
  },
  UI_Chapter_Hard_Swich_Group_New_Text_C_Nightmare = {
    ID = "UI_Chapter_Hard_Swich_Group_New_Text_C_Nightmare",
    Content = "PanelText_UI_Chapter_Hard_Swich_Group_New_Text_C_Nightmare_Content|噩梦"
  },
  UI_Chapter_Spur_View_Text_C_Remember = {
    ID = "UI_Chapter_Spur_View_Text_C_Remember",
    Content = "PanelText_UI_Chapter_Spur_View_Text_C_Remember_Content|溯梦"
  },
  UI_Main_Panel_1_Text_C_Collection = {
    ID = "UI_Main_Panel_1_Text_C_Collection",
    Content = "PanelText_UI_Main_Panel_1_Text_C_Collection_Content|秘典书库"
  },
  UI_Main_Panel_1_Text_C_Close_1 = {
    ID = "UI_Main_Panel_1_Text_C_Close_1",
    Content = "PanelText_UI_Main_Panel_1_Text_C_Close_1_Content|关闭中"
  },
  UI_Awaker_Popup_Whole_Body_Text_C_Reveal = {
    ID = "UI_Awaker_Popup_Whole_Body_Text_C_Reveal",
    Content = "PanelText_UI_Awaker_Popup_Whole_Body_Text_C_Reveal_Content|隐藏"
  },
  UI_Collection_Panel_World_Text_C_Label = {
    ID = "UI_Collection_Panel_World_Text_C_Label",
    Content = "PanelText_UI_Collection_Panel_World_Text_C_Label_Content|洪积世界"
  },
  UI_Collection_Panel_World_Text_C_Title = {
    ID = "UI_Collection_Panel_World_Text_C_Title",
    Content = "PanelText_UI_Collection_Panel_World_Text_C_Title_Content|秘典书库"
  },
  UI_Collection_Panel_World_Text_C_Chronicle = {
    ID = "UI_Collection_Panel_World_Text_C_Chronicle",
    Content = "PanelText_UI_Collection_Panel_World_Text_C_Chronicle_Content|编年史"
  },
  UI_Collection_Panel_World_Text_C_Organize = {
    ID = "UI_Collection_Panel_World_Text_C_Organize",
    Content = "PanelText_UI_Collection_Panel_World_Text_C_Organize_Content|组织势力"
  },
  UI_Collection_Panel_World_Text_C_Comprehensive = {
    ID = "UI_Collection_Panel_World_Text_C_Comprehensive",
    Content = "PanelText_UI_Collection_Panel_World_Text_C_Comprehensive_Content|洪积禁典"
  },
  UI_Dungeons_Panel_SurveyData_Text_C_Uid = {
    ID = "UI_Dungeons_Panel_SurveyData_Text_C_Uid",
    Content = "PanelText_UI_Dungeons_Panel_SurveyData_Text_C_Uid_Content|守密人ID:"
  },
  UI_Dungeons_Panel_SurveyData_Text_C_Team = {
    ID = "UI_Dungeons_Panel_SurveyData_Text_C_Team",
    Content = "PanelText_UI_Dungeons_Panel_SurveyData_Text_C_Team_Content|调查队伍"
  },
  UI_Dungeons_Panel_SurveyData_Text_C_TeamData = {
    ID = "UI_Dungeons_Panel_SurveyData_Text_C_TeamData",
    Content = "PanelText_UI_Dungeons_Panel_SurveyData_Text_C_TeamData_Content|队伍数据"
  },
  UI_Dungeons_Panel_SurveyData_Text_C_TeamProperty = {
    ID = "UI_Dungeons_Panel_SurveyData_Text_C_TeamProperty",
    Content = "PanelText_UI_Dungeons_Panel_SurveyData_Text_C_TeamProperty_Content|队伍属性"
  },
  UI_Dungeons_Panel_SurveyData_Text_C_KeyToken = {
    ID = "UI_Dungeons_Panel_SurveyData_Text_C_KeyToken",
    Content = "PanelText_UI_Dungeons_Panel_SurveyData_Text_C_KeyToken_Content|钥令"
  },
  UI_Dungeons_Panel_SurveyData_Text_C_Relic = {
    ID = "UI_Dungeons_Panel_SurveyData_Text_C_Relic",
    Content = "PanelText_UI_Dungeons_Panel_SurveyData_Text_C_Relic_Content|造物"
  },
  UI_Dungeons_Panel_SurveyData_Text_C_Null = {
    ID = "UI_Dungeons_Panel_SurveyData_Text_C_Null",
    Content = "PanelText_UI_Dungeons_Panel_SurveyData_Text_C_Null_Content|暂無造物"
  },
  UI_Dungeons_Panel_SurveyData_Text_C_Card2 = {
    ID = "UI_Dungeons_Panel_SurveyData_Text_C_Card2",
    Content = "PanelText_UI_Dungeons_Panel_SurveyData_Text_C_Card2_Content|（含刻印）"
  },
  UI_Dungeons_Panel_SurveyData_Text_C_Card = {
    ID = "UI_Dungeons_Panel_SurveyData_Text_C_Card",
    Content = "PanelText_UI_Dungeons_Panel_SurveyData_Text_C_Card_Content|卡牌统计"
  },
  UI_Dungeons_Panel_Out_Text_C_BattleData = {
    ID = "UI_Dungeons_Panel_Out_Text_C_BattleData",
    Content = "PanelText_UI_Dungeons_Panel_Out_Text_C_BattleData_Content|调查数据"
  },
  UI_Collection_Btn_Position_Text_C_Name = {
    ID = "UI_Collection_Btn_Position_Text_C_Name"
  },
  UI_Collection_Btn_Position_Text_C_Upgrade = {
    ID = "UI_Collection_Btn_Position_Text_C_Upgrade",
    Content = "PanelText_UI_Collection_Btn_Position_Text_C_Upgrade_Content|Character"
  },
  UI_Collection_Item_Comprehensive_Text_C_Placeholder = {
    ID = "UI_Collection_Item_Comprehensive_Text_C_Placeholder",
    Content = "PanelText_UI_Collection_Item_Comprehensive_Text_C_Placeholder_Content|搜索名词..."
  },
  UI_Collection_Panel_Organize_Text_C_Mail = {
    ID = "UI_Collection_Panel_Organize_Text_C_Mail",
    Content = "PanelText_UI_Collection_Panel_Organize_Text_C_Mail_Content|收集进度"
  },
  UI_Social_Popup_Awaker_Text_C_Owned = {
    ID = "UI_Social_Popup_Awaker_Text_C_Owned",
    Content = "PanelText_UI_Social_Popup_Awaker_Text_C_Owned_Content|已拥有"
  },
  UI_Social_Panel_RankList_Text_C_Rank = {
    ID = "UI_Social_Panel_RankList_Text_C_Rank",
    Content = "PanelText_UI_Social_Panel_RankList_Text_C_Rank_Content|排名"
  },
  UI_Social_Panel_RankList_Text_C_PlayerInfo = {
    ID = "UI_Social_Panel_RankList_Text_C_PlayerInfo",
    Content = "PanelText_UI_Social_Panel_RankList_Text_C_PlayerInfo_Content|达人"
  },
  UI_Social_Panel_RankList_Text_C_Interaction = {
    ID = "UI_Social_Panel_RankList_Text_C_Interaction",
    Content = "PanelText_UI_Social_Panel_RankList_Text_C_Interaction_Content|互動"
  },
  UI_Social_Panel_RankList_Text_C_NoTask = {
    ID = "UI_Social_Panel_RankList_Text_C_NoTask",
    Content = "PanelText_UI_Social_Panel_RankList_Text_C_NoTask_Content|暂无记录"
  },
  UI_Social_Panel_RankList_Text_C_En = {
    ID = "UI_Social_Panel_RankList_Text_C_En",
    Content = "PanelText_UI_Social_Panel_RankList_Text_C_En_Content|fdshsjfgjgf"
  },
  UI_Social_Panel_RankList_Text_C_Uid_Title = {
    ID = "UI_Social_Panel_RankList_Text_C_Uid_Title",
    Content = "PanelText_UI_Social_Panel_RankList_Text_C_Uid_Title_Content|UID :"
  },
  UI_Social_Item_Rank_Text_C_Attention = {
    ID = "UI_Social_Item_Rank_Text_C_Attention",
    Content = "PanelText_UI_Social_Item_Rank_Text_C_Attention_Content|关注"
  },
  UI_Social_Item_Rank_Text_C_Interrelated = {
    ID = "UI_Social_Item_Rank_Text_C_Interrelated",
    Content = "PanelText_UI_Social_Item_Rank_Text_C_Interrelated_Content|已互关"
  },
  UI_Social_Item_Rank_Text_C_Following = {
    ID = "UI_Social_Item_Rank_Text_C_Following",
    Content = "PanelText_UI_Social_Item_Rank_Text_C_Following_Content|已关注"
  },
  UI_Social_Item_Rank_Text_C_Uid = {
    ID = "UI_Social_Item_Rank_Text_C_Uid",
    Content = "PanelText_UI_Social_Item_Rank_Text_C_Uid_Content|UID:"
  },
  UI_Collection_Panel_Music_Play_Text_C_Title = {
    ID = "UI_Collection_Panel_Music_Play_Text_C_Title",
    Content = "PanelText_UI_Collection_Panel_Music_Play_Text_C_Title_Content|秘典书库"
  },
  UI_Collection_Panel_Music_Play_Text_C_Mail = {
    ID = "UI_Collection_Panel_Music_Play_Text_C_Mail",
    Content = "PanelText_UI_Collection_Panel_Music_Play_Text_C_Mail_Content|收集进度"
  },
  UI_Collection_Item_Music_Alone_Text_C_Label = {
    ID = "UI_Collection_Item_Music_Alone_Text_C_Label",
    Content = "PanelText_UI_Collection_Item_Music_Alone_Text_C_Label_Content|留声机"
  },
  UI_Collection_Item_Music_Alone_Text_C_Title = {
    ID = "UI_Collection_Item_Music_Alone_Text_C_Title",
    Content = "PanelText_UI_Collection_Item_Music_Alone_Text_C_Title_Content|秘典书库"
  },
  UI_Collection_Item_Music_Alone_Text_C_Mail = {
    ID = "UI_Collection_Item_Music_Alone_Text_C_Mail",
    Content = "PanelText_UI_Collection_Item_Music_Alone_Text_C_Mail_Content|收集进度"
  },
  UI_Collection_Item_Music_Text_C_Label = {
    ID = "UI_Collection_Item_Music_Text_C_Label",
    Content = "PanelText_UI_Collection_Item_Music_Text_C_Label_Content|留声机"
  },
  UI_Collection_Item_Music_Text_C_Title = {
    ID = "UI_Collection_Item_Music_Text_C_Title",
    Content = "PanelText_UI_Collection_Item_Music_Text_C_Title_Content|秘典书库"
  },
  UI_Collection_Item_Music_Text_C_Mail = {
    ID = "UI_Collection_Item_Music_Text_C_Mail",
    Content = "PanelText_UI_Collection_Item_Music_Text_C_Mail_Content|收集进度"
  },
  UI_Awaker_Item_List_3_Text_C_Got = {
    ID = "UI_Awaker_Item_List_3_Text_C_Got",
    Content = "PanelText_UI_Awaker_Item_List_3_Text_C_Got_Content|已唤醒"
  },
  UI_Event_Activity_XiaomaoGift_Text_C_Receive = {
    ID = "UI_Event_Activity_XiaomaoGift_Text_C_Receive",
    Content = "PanelText_UI_Event_Activity_XiaomaoGift_Text_C_Receive_Content|剩余唤醒次数："
  },
  UI_Collection_Panel_Main_Text_C_Title = {
    ID = "UI_Collection_Panel_Main_Text_C_Title",
    Content = "PanelText_UI_Collection_Panel_Main_Text_C_Title_Content|秘典书库"
  },
  UI_Collection_Panel_Main_Text_C_Role = {
    ID = "UI_Collection_Panel_Main_Text_C_Role",
    Content = "PanelText_UI_Collection_Panel_Main_Text_C_Role_Content|角色"
  },
  UI_Collection_Panel_Main_Text_C_World = {
    ID = "UI_Collection_Panel_Main_Text_C_World",
    Content = "PanelText_UI_Collection_Panel_Main_Text_C_World_Content|洪积世界"
  },
  UI_Collection_Panel_Main_Text_C_Image = {
    ID = "UI_Collection_Panel_Main_Text_C_Image",
    Content = "PanelText_UI_Collection_Panel_Main_Text_C_Image_Content|影像"
  },
  UI_Collection_Panel_Main_Text_C_Music = {
    ID = "UI_Collection_Panel_Main_Text_C_Music",
    Content = "PanelText_UI_Collection_Panel_Main_Text_C_Music_Content|留声机"
  },
  UI_Collection_Panel_Main_Text_C_Weapon = {
    ID = "UI_Collection_Panel_Main_Text_C_Weapon",
    Content = "PanelText_UI_Collection_Panel_Main_Text_C_Weapon_Content|命轮"
  },
  UI_Collection_Panel_Main_Text_C_Trinket = {
    ID = "UI_Collection_Panel_Main_Text_C_Trinket",
    Content = "PanelText_UI_Collection_Panel_Main_Text_C_Trinket_Content|密契"
  },
  UI_Collection_Panel_Main_Text_C_Creation = {
    ID = "UI_Collection_Panel_Main_Text_C_Creation",
    Content = "PanelText_UI_Collection_Panel_Main_Text_C_Creation_Content|造物"
  },
  UI_Collection_Panel_Main_Text_C_Event = {
    ID = "UI_Collection_Panel_Main_Text_C_Event",
    Content = "PanelText_UI_Collection_Panel_Main_Text_C_Event_Content|事件"
  },
  UI_Events_Panel_Thais_Text_C_Reward = {
    ID = "UI_Events_Panel_Thais_Text_C_Reward",
    Content = "PanelText_UI_Events_Panel_Thais_Text_C_Reward_Content|成就奖励"
  },
  UI_Events_Panel_Thais_Text_C_Record = {
    ID = "UI_Events_Panel_Thais_Text_C_Record",
    Content = "PanelText_UI_Events_Panel_Thais_Text_C_Record_Content|繁衍狂热"
  },
  UI_Events_Panel_Thais_Text_C_RecordTip = {
    ID = "UI_Events_Panel_Thais_Text_C_RecordTip",
    Content = "PanelText_UI_Events_Panel_Thais_Text_C_RecordTip_Content|限时优惠解锁"
  },
  UI_Events_Panel_Thais_Text_C_Challenge = {
    ID = "UI_Events_Panel_Thais_Text_C_Challenge",
    Content = "PanelText_UI_Events_Panel_Thais_Text_C_Challenge_Content|紊乱情欲"
  },
  UI_Events_Panel_Thais_Text_C_ChallengeTip = {
    ID = "UI_Events_Panel_Thais_Text_C_ChallengeTip",
    Content = "PanelText_UI_Events_Panel_Thais_Text_C_ChallengeTip_Content|玩法限时开放"
  },
  UI_Events_Panel_Thais_Text_C_Topic = {
    ID = "UI_Events_Panel_Thais_Text_C_Topic",
    Content = "PanelText_UI_Events_Panel_Thais_Text_C_Topic_Content|欲海翻波"
  },
  UI_Events_Panel_Thais_Text_C_Shop = {
    ID = "UI_Events_Panel_Thais_Text_C_Shop",
    Content = "PanelText_UI_Events_Panel_Thais_Text_C_Shop_Content|欲孽滋生"
  },
  UI_Events_Panel_Thais_Text_C_Pv = {
    ID = "UI_Events_Panel_Thais_Text_C_Pv",
    Content = "PanelText_UI_Events_Panel_Thais_Text_C_Pv_Content|播放影像"
  },
  UI_Awaker_Item_List_3_Text_C_Full = {
    ID = "UI_Awaker_Item_List_3_Text_C_Full",
    Content = "PanelText_UI_Awaker_Item_List_3_Text_C_Full_Content|启灵已满"
  },
  UI_Dungeons_Panel_Try_Text_C_Name_1 = {
    ID = "UI_Dungeons_Panel_Try_Text_C_Name_1",
    Content = "PanelText_UI_Dungeons_Panel_Try_Text_C_Name_1_Content|领取"
  },
  UI_Dungeons_Panel_Try_Text_C_Name = {
    ID = "UI_Dungeons_Panel_Try_Text_C_Name",
    Content = "PanelText_UI_Dungeons_Panel_Try_Text_C_Name_Content|开始试玩"
  },
  UI_Event_RewardGroup_Text_C_Reset = {
    ID = "UI_Event_RewardGroup_Text_C_Reset",
    Content = "PanelText_UI_Event_RewardGroup_Text_C_Reset_Content|剩余重置次数："
  },
  UI_Chapter_Vindicate_View_Text_C_StoryDesc = {
    ID = "UI_Chapter_Vindicate_View_Text_C_StoryDesc",
    Content = "PanelText_UI_Chapter_Vindicate_View_Text_C_StoryDesc_Content|随着「欲海翻波」的持续，唤醒体们受到了神秘力量影响，陷入了「繁衍狂热」状态……请各位守密人小心！"
  },
  UI_Chapter_Vindicate_View_Text_C_Need = {
    ID = "UI_Chapter_Vindicate_View_Text_C_Need",
    Content = "PanelText_UI_Chapter_Vindicate_View_Text_C_Need_Content|需要"
  },
  UI_Chapter_Vindicate_View_Text_C_Name = {
    ID = "UI_Chapter_Vindicate_View_Text_C_Name",
    Content = "PanelText_UI_Chapter_Vindicate_View_Text_C_Name_Content|进入剧情"
  },
  UI_Chapter_Vindicate_View_Text_C_Title = {
    ID = "UI_Chapter_Vindicate_View_Text_C_Title",
    Content = "PanelText_UI_Chapter_Vindicate_View_Text_C_Title_Content|晚会邀请"
  },
  UI_Chapter_Vindicate_View_Text_C_Tip = {
    ID = "UI_Chapter_Vindicate_View_Text_C_Tip",
    Content = "PanelText_UI_Chapter_Vindicate_View_Text_C_Tip_Content|「欲海翻波」活动期间限时优惠开放，可以无视同调率要求，使用 「现实起点」*1 即可解锁对应事件！"
  },
  UI_Chapter_Vindicate_View_Text_C_Condition = {
    ID = "UI_Chapter_Vindicate_View_Text_C_Condition",
    Content = "PanelText_UI_Chapter_Vindicate_View_Text_C_Condition_Content|未达解锁条件"
  },
  UI_Events_Panel_Thais_Text_C_Homology = {
    ID = "UI_Events_Panel_Thais_Text_C_Homology",
    Content = "PanelText_UI_Events_Panel_Thais_Text_C_Homology_Content|活动期间通过所有方式获取的同调率翻倍！"
  },
  UI_Collection_Panel_Main_Text_C_Special_1 = {
    ID = "UI_Collection_Panel_Main_Text_C_Special_1"
  },
  UI_Collection_Panel_Main_Text_C_Special_2 = {
    ID = "UI_Collection_Panel_Main_Text_C_Special_2"
  },
  UI_Collection_Panel_Main_Text_C_Special_3 = {
    ID = "UI_Collection_Panel_Main_Text_C_Special_3"
  },
  UI_Collection_Panel_Main_Text_C_Special_4 = {
    ID = "UI_Collection_Panel_Main_Text_C_Special_4"
  },
  UI_Collection_Panel_Main_Text_C_Special_5 = {
    ID = "UI_Collection_Panel_Main_Text_C_Special_5"
  },
  UI_Collection_Panel_Main_Text_C_Special_6 = {
    ID = "UI_Collection_Panel_Main_Text_C_Special_6"
  },
  UI_Collection_Panel_Main_Text_C_Special_7 = {
    ID = "UI_Collection_Panel_Main_Text_C_Special_7"
  },
  UI_Collection_Panel_Main_Text_C_Special_8 = {
    ID = "UI_Collection_Panel_Main_Text_C_Special_8"
  },
  UI_Vindicate_Popup_Reward_Text_C_Task = {
    ID = "UI_Vindicate_Popup_Reward_Text_C_Task",
    Content = "PanelText_UI_Vindicate_Popup_Reward_Text_C_Task_Content|首次完成事件后自动获得"
  },
  UI_Dungeons_Popup_AbyssRank_Text_C_NoTask = {
    ID = "UI_Dungeons_Popup_AbyssRank_Text_C_NoTask",
    Content = "PanelText_UI_Dungeons_Popup_AbyssRank_Text_C_NoTask_Content|暂无记录"
  },
  UI_Dungeons_Popup_AbyssRank_Text_C_En = {
    ID = "UI_Dungeons_Popup_AbyssRank_Text_C_En",
    Content = "PanelText_UI_Dungeons_Popup_AbyssRank_Text_C_En_Content|fdshsjfgjgf"
  },
  UI_Dungeons_Popup_AbyssRank_Text_C_Rank = {
    ID = "UI_Dungeons_Popup_AbyssRank_Text_C_Rank",
    Content = "PanelText_UI_Dungeons_Popup_AbyssRank_Text_C_Rank_Content|排名"
  },
  UI_Dungeons_Popup_AbyssRank_Text_C_Info = {
    ID = "UI_Dungeons_Popup_AbyssRank_Text_C_Info",
    Content = "PanelText_UI_Dungeons_Popup_AbyssRank_Text_C_Info_Content|守密人信息"
  },
  UI_Dungeons_Popup_AbyssRank_Text_C_Value = {
    ID = "UI_Dungeons_Popup_AbyssRank_Text_C_Value",
    Content = "PanelText_UI_Dungeons_Popup_AbyssRank_Text_C_Value_Content|特训值"
  },
  UI_Dungeons_Popup_AbyssRank_Text_C_More = {
    ID = "UI_Dungeons_Popup_AbyssRank_Text_C_More",
    Content = "PanelText_UI_Dungeons_Popup_AbyssRank_Text_C_More_Content|查看详情"
  },
  UI_Dungeons_Item_AbyssRank_Text_C_Uid = {
    ID = "UI_Dungeons_Item_AbyssRank_Text_C_Uid",
    Content = "PanelText_UI_Dungeons_Item_AbyssRank_Text_C_Uid_Content|UID:"
  },
  UI_Events_Panel_Thais_StageGroup_Text_C_illustrate = {
    ID = "UI_Events_Panel_Thais_StageGroup_Text_C_illustrate",
    Content = "PanelText_UI_Events_Panel_Thais_StageGroup_Text_C_illustrate_Content|玩法规则"
  },
  UI_Events_Panel_Thais_StageGroup_Text_C_Title = {
    ID = "UI_Events_Panel_Thais_StageGroup_Text_C_Title",
    Content = "PanelText_UI_Events_Panel_Thais_StageGroup_Text_C_Title_Content|紊乱情欲"
  },
  UI_Events_Panel_Thais_StageGroup_Text_C_Describe = {
    ID = "UI_Events_Panel_Thais_StageGroup_Text_C_Describe",
    Content = "PanelText_UI_Events_Panel_Thais_StageGroup_Text_C_Describe_Content|时间流转往复，凋零的花再度盛开。"
  },
  UI_Events_Panel_Thais_StageGroup_Text_C_Resonance = {
    ID = "UI_Events_Panel_Thais_StageGroup_Text_C_Resonance",
    Content = "PanelText_UI_Events_Panel_Thais_StageGroup_Text_C_Resonance_Content|共鸣"
  },
  UI_Dungeons_Panel_SurveyData_Text_C_Reset = {
    ID = "UI_Dungeons_Panel_SurveyData_Text_C_Reset",
    Content = "PanelText_UI_Dungeons_Panel_SurveyData_Text_C_Reset_Content|重置"
  },
  UI_Dungeons_Panel_SurveyData_Text_C_NoTask = {
    ID = "UI_Dungeons_Panel_SurveyData_Text_C_NoTask",
    Content = "PanelText_UI_Dungeons_Panel_SurveyData_Text_C_NoTask_Content|暂无记录"
  },
  UI_Dungeons_Panel_SurveyData_Text_C_En = {
    ID = "UI_Dungeons_Panel_SurveyData_Text_C_En",
    Content = "PanelText_UI_Dungeons_Panel_SurveyData_Text_C_En_Content|fdshsjfgjgf"
  },
  UI_Dungeous_Panel_Melt_Erosion_Optimized_Text_C_Title = {
    ID = "UI_Dungeous_Panel_Melt_Erosion_Optimized_Text_C_Title",
    Content = "PanelText_UI_Dungeous_Panel_Melt_Erosion_Optimized_Text_C_Title_Content|融灾禁区"
  },
  UI_Dungeous_Panel_Melt_Erosion_Optimized_Text_C_Weekly = {
    ID = "UI_Dungeous_Panel_Melt_Erosion_Optimized_Text_C_Weekly",
    Content = "PanelText_UI_Dungeous_Panel_Melt_Erosion_Optimized_Text_C_Weekly_Content|特训奖励"
  },
  UI_Dungeous_Panel_Melt_Erosion_Optimized_Text_C_Train = {
    ID = "UI_Dungeous_Panel_Melt_Erosion_Optimized_Text_C_Train",
    Content = "PanelText_UI_Dungeous_Panel_Melt_Erosion_Optimized_Text_C_Train_Content|当前特训值"
  },
  UI_Dungeous_Panel_Melt_Erosion_Optimized_Text_C_Hint = {
    ID = "UI_Dungeous_Panel_Melt_Erosion_Optimized_Text_C_Hint",
    Content = "PanelText_UI_Dungeous_Panel_Melt_Erosion_Optimized_Text_C_Hint_Content|*在融灾禁区中，已出战的唤醒体和命轮将无法在其他禁区中出战。"
  },
  UI_Dungeous_Panel_Melt_Erosion_Optimized_Text_C_Rank = {
    ID = "UI_Dungeous_Panel_Melt_Erosion_Optimized_Text_C_Rank",
    Content = "PanelText_UI_Dungeous_Panel_Melt_Erosion_Optimized_Text_C_Rank_Content|排行榜"
  },
  UI_Common_Popup_Tips_Small_Text_C_Scroll_Tips = {
    ID = "UI_Common_Popup_Tips_Small_Text_C_Scroll_Tips",
    Content = "PanelText_UI_Common_Popup_Tips_Small_Text_C_Scroll_Tips_Content|上下滑动可查看更多奖励"
  },
  UI_Other_Fund_Tips_Text_C_Title = {
    ID = "UI_Other_Fund_Tips_Text_C_Title",
    Content = "PanelText_UI_Other_Fund_Tips_Text_C_Title_Content|校友捐献基金"
  },
  UI_Other_Fund_Tips_Text_C_Donated = {
    ID = "UI_Other_Fund_Tips_Text_C_Donated",
    Content = "PanelText_UI_Other_Fund_Tips_Text_C_Donated_Content|当前总贡献"
  },
  UI_Other_Donate_Tips_Text_C_Title = {
    ID = "UI_Other_Donate_Tips_Text_C_Title",
    Content = "PanelText_UI_Other_Donate_Tips_Text_C_Title_Content|源液捐献"
  },
  UI_Other_Donate_Tips_Text_C_Fund = {
    ID = "UI_Other_Donate_Tips_Text_C_Fund",
    Content = "PanelText_UI_Other_Donate_Tips_Text_C_Fund_Content|校友捐献基金"
  },
  UI_Other_Donate_Tips_Text_C_Donated = {
    ID = "UI_Other_Donate_Tips_Text_C_Donated",
    Content = "PanelText_UI_Other_Donate_Tips_Text_C_Donated_Content|累计已捐献"
  },
  UI_Other_Donate_Tips_Text_C_Utmost = {
    ID = "UI_Other_Donate_Tips_Text_C_Utmost",
    Content = "PanelText_UI_Other_Donate_Tips_Text_C_Utmost_Content|最大"
  },
  UI_Other_Donate_Tips_Text_C_Least = {
    ID = "UI_Other_Donate_Tips_Text_C_Least",
    Content = "PanelText_UI_Other_Donate_Tips_Text_C_Least_Content|最小"
  },
  UI_Other_Donate_Tips_Text_C_Consume = {
    ID = "UI_Other_Donate_Tips_Text_C_Consume",
    Content = "PanelText_UI_Other_Donate_Tips_Text_C_Consume_Content|消耗"
  },
  UI_Social_Panel_Rank_Text_C_Uid_Title = {
    ID = "UI_Social_Panel_Rank_Text_C_Uid_Title",
    Content = "PanelText_UI_Social_Panel_Rank_Text_C_Uid_Title_Content|UID :"
  },
  UI_Social_Panel_Rank_Text_C_Rank = {
    ID = "UI_Social_Panel_Rank_Text_C_Rank",
    Content = "PanelText_UI_Social_Panel_Rank_Text_C_Rank_Content|排名"
  },
  UI_Social_Panel_Rank_Text_C_PlayerInfo = {
    ID = "UI_Social_Panel_Rank_Text_C_PlayerInfo",
    Content = "PanelText_UI_Social_Panel_Rank_Text_C_PlayerInfo_Content|守密人信息"
  },
  UI_Social_Panel_Rank_Text_C_Interaction = {
    ID = "UI_Social_Panel_Rank_Text_C_Interaction",
    Content = "PanelText_UI_Social_Panel_Rank_Text_C_Interaction_Content|互动"
  },
  UI_Social_Panel_Rank_Text_C_NoTask = {
    ID = "UI_Social_Panel_Rank_Text_C_NoTask",
    Content = "PanelText_UI_Social_Panel_Rank_Text_C_NoTask_Content|暂无记录"
  },
  UI_Social_Panel_Rank_Text_C_En = {
    ID = "UI_Social_Panel_Rank_Text_C_En",
    Content = "PanelText_UI_Social_Panel_Rank_Text_C_En_Content|fdshsjfgjgf"
  },
  UI_Social_Panel_Rank_Text_C_All = {
    ID = "UI_Social_Panel_Rank_Text_C_All",
    Content = "PanelText_UI_Social_Panel_Rank_Text_C_All_Content|全部"
  },
  UI_Social_Panel_Rank_Text_C_Friend = {
    ID = "UI_Social_Panel_Rank_Text_C_Friend",
    Content = "PanelText_UI_Social_Panel_Rank_Text_C_Friend_Content|关注"
  },
  UI_Events_Panel_Lily_Text_C_Reward = {
    ID = "UI_Events_Panel_Lily_Text_C_Reward",
    Content = "PanelText_UI_Events_Panel_Lily_Text_C_Reward_Content|成就奖励"
  },
  UI_Events_Panel_Lily_Text_C_Homology = {
    ID = "UI_Events_Panel_Lily_Text_C_Homology"
  },
  UI_Events_Panel_Lily_Text_C_Record = {
    ID = "UI_Events_Panel_Lily_Text_C_Record",
    Content = "PanelText_UI_Events_Panel_Lily_Text_C_Record_Content|特遣纪录"
  },
  UI_Events_Panel_Lily_Text_C_RecordTip = {
    ID = "UI_Events_Panel_Lily_Text_C_RecordTip",
    Content = "PanelText_UI_Events_Panel_Lily_Text_C_RecordTip_Content|限时免费解锁"
  },
  UI_Events_Panel_Lily_Text_C_Challenge = {
    ID = "UI_Events_Panel_Lily_Text_C_Challenge",
    Content = "PanelText_UI_Events_Panel_Lily_Text_C_Challenge_Content|剧本迷思"
  },
  UI_Events_Panel_Lily_Text_C_ChallengeTip = {
    ID = "UI_Events_Panel_Lily_Text_C_ChallengeTip",
    Content = "PanelText_UI_Events_Panel_Lily_Text_C_ChallengeTip_Content|玩法限时开放"
  },
  UI_Events_Panel_Lily_Text_C_Resonance = {
    ID = "UI_Events_Panel_Lily_Text_C_Resonance",
    Content = "PanelText_UI_Events_Panel_Lily_Text_C_Resonance_Content|共鸣：导演密码"
  },
  UI_Events_Panel_Lily_Text_C_Diagonal = {
    ID = "UI_Events_Panel_Lily_Text_C_Diagonal",
    Content = "PanelText_UI_Events_Panel_Lily_Text_C_Diagonal_Content|/"
  },
  UI_Events_Panel_Lily_Text_C_Topic = {
    ID = "UI_Events_Panel_Lily_Text_C_Topic",
    Content = "PanelText_UI_Events_Panel_Lily_Text_C_Topic_Content|故事的魔法·复刻"
  },
  UI_Events_Panel_Lily_Text_C_Shop = {
    ID = "UI_Events_Panel_Lily_Text_C_Shop",
    Content = "PanelText_UI_Events_Panel_Lily_Text_C_Shop_Content|魔法剧本商店"
  },
  UI_Events_Panel_Lily_Text_C_Pv = {
    ID = "UI_Events_Panel_Lily_Text_C_Pv",
    Content = "PanelText_UI_Events_Panel_Lily_Text_C_Pv_Content|播放影像"
  },
  UI_Other_Fund_Tips_Text_C_Describe = {
    ID = "UI_Other_Fund_Tips_Text_C_Describe",
    Content = "PanelText_UI_Other_Fund_Tips_Text_C_Describe_Content|捐献「源液」，积累贡献，您的善行将得到回馈。 您的「总贡献值」是累积捐献的「源液」之和。"
  },
  UI_Other_Fund_Tips_Text_C_illustrate = {
    ID = "UI_Other_Fund_Tips_Text_C_illustrate",
    Content = "PanelText_UI_Other_Fund_Tips_Text_C_illustrate_Content|规则说明"
  },
  UI_Alchemy_Popup_Break_Down_Text_C_Add = {
    ID = "UI_Alchemy_Popup_Break_Down_Text_C_Add",
    Content = "PanelText_UI_Alchemy_Popup_Break_Down_Text_C_Add_Content|+"
  },
  UI_Alchemy_Popup_Break_Down_Text_C_Wait = {
    ID = "UI_Alchemy_Popup_Break_Down_Text_C_Wait",
    Content = "PanelText_UI_Alchemy_Popup_Break_Down_Text_C_Wait_Content|="
  },
  UI_Pvp_Panel_Collection_Detail_Text_C_Source = {
    ID = "UI_Pvp_Panel_Collection_Detail_Text_C_Source",
    Content = "PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_Source_Content|来源"
  },
  UI_Chapter_Dream_View_Text_C_Remember = {
    ID = "UI_Chapter_Dream_View_Text_C_Remember",
    Content = "PanelText_UI_Chapter_Dream_View_Text_C_Remember_Content|溯梦"
  },
  UI_Chapter_Dream_View_Text_C_Simple = {
    ID = "UI_Chapter_Dream_View_Text_C_Simple",
    Content = "PanelText_UI_Chapter_Dream_View_Text_C_Simple_Content|普通"
  },
  UI_Chapter_Dream_View_Text_C_Difficulty = {
    ID = "UI_Chapter_Dream_View_Text_C_Difficulty",
    Content = "PanelText_UI_Chapter_Dream_View_Text_C_Difficulty_Content|困难"
  },
  UI_Chapter_Dream_View_Text_C_Nightmare = {
    ID = "UI_Chapter_Dream_View_Text_C_Nightmare",
    Content = "PanelText_UI_Chapter_Dream_View_Text_C_Nightmare_Content|癫狂"
  },
  UI_Chapter_Item_Dream_01_Text_C_Free_Unlock = {
    ID = "UI_Chapter_Item_Dream_01_Text_C_Free_Unlock",
    Content = "PanelText_UI_Chapter_Item_Dream_01_Text_C_Free_Unlock_Content|限时免费解锁"
  },
  UI_Awaker_Popup_Topped_Tip3_Text_C_Title = {
    ID = "UI_Awaker_Popup_Topped_Tip3_Text_C_Title",
    Content = "PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Title_Content|人格深化"
  },
  UI_Awaker_Popup_Topped_Tip3_Text_C_Unlock = {
    ID = "UI_Awaker_Popup_Topped_Tip3_Text_C_Unlock",
    Content = "PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Unlock_Content|属性提升"
  },
  UI_Awaker_Popup_Topped_Tip3_Text_C_Mad = {
    ID = "UI_Awaker_Popup_Topped_Tip3_Text_C_Mad",
    Content = "PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Mad_Content|等级上限提升"
  },
  UI_Awaker_Popup_Topped_Tip3_Text_C_Lv = {
    ID = "UI_Awaker_Popup_Topped_Tip3_Text_C_Lv",
    Content = "PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Lv_Content|等级上限提升"
  },
  UI_Awaker_Popup_Topped_Tip3_Text_C_Activation = {
    ID = "UI_Awaker_Popup_Topped_Tip3_Text_C_Activation",
    Content = "PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Activation_Content|已激活"
  },
  UI_Awaker_Popup_Topped_Tip3_Text_C_Not_Activation = {
    ID = "UI_Awaker_Popup_Topped_Tip3_Text_C_Not_Activation",
    Content = "PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Not_Activation_Content|未激活"
  },
  UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_WeaponNull = {
    ID = "UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_WeaponNull",
    Content = "PanelText_UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_WeaponNull_Content|尚无相关命轮"
  },
  UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_En = {
    ID = "UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_En",
    Content = "PanelText_UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_En_Content|fdshsjfgjgf"
  },
  UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_All = {
    ID = "UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_All",
    Content = "PanelText_UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_All_Content|全选"
  },
  UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_Cap = {
    ID = "UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_Cap",
    Content = "PanelText_UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_Cap_Content|已强化至当前等级上限"
  },
  UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_NormotopiaCap = {
    ID = "UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_NormotopiaCap",
    Content = "PanelText_UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_NormotopiaCap_Content|正位已达上限"
  },
  UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_Resolve = {
    ID = "UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_Resolve",
    Content = "PanelText_UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_Resolve_Content|分解获得"
  },
  UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_Null = {
    ID = "UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_Null",
    Content = "PanelText_UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_Null_Content|请选择要分解的物品"
  },
  UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_Sel = {
    ID = "UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_Sel",
    Content = "PanelText_UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_Sel_Content|已选"
  },
  UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_AmountLine = {
    ID = "UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_AmountLine",
    Content = "PanelText_UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_AmountLine_Content|/"
  },
  UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_GoodsNum = {
    ID = "UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_GoodsNum",
    Content = "PanelText_UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_GoodsNum_Content|数量"
  },
  UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_GoodsNumLine = {
    ID = "UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_GoodsNumLine",
    Content = "PanelText_UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_GoodsNumLine_Content|/"
  },
  UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_Mail = {
    ID = "UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_Mail",
    Content = "PanelText_UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_Mail_Content|规则说明"
  },
  UI_Alchemy_Popup_ResolveWeapon_Text_Time = {
    ID = "UI_Alchemy_Popup_ResolveWeapon_Text_Time",
    Content = "PanelText_UI_Alchemy_Popup_ResolveWeapon_Text_Time_Content|去其他地方看看吧"
  },
  UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_MaterialsNull = {
    ID = "UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_MaterialsNull",
    Content = "PanelText_UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_MaterialsNull_Content|尚无相关密契"
  },
  UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_En = {
    ID = "UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_En",
    Content = "PanelText_UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_En_Content|fdshsjfgjgf"
  },
  UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_Cap = {
    ID = "UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_Cap",
    Content = "PanelText_UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_Cap_Content|已强化至当前等级上限"
  },
  UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_NormotopiaCap = {
    ID = "UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_NormotopiaCap",
    Content = "PanelText_UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_NormotopiaCap_Content|正位已达上限"
  },
  UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_Resolve = {
    ID = "UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_Resolve",
    Content = "PanelText_UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_Resolve_Content|分解获得"
  },
  UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_All = {
    ID = "UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_All",
    Content = "PanelText_UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_All_Content|全选"
  },
  UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_Sel = {
    ID = "UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_Sel",
    Content = "PanelText_UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_Sel_Content|已选"
  },
  UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_AmountLine = {
    ID = "UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_AmountLine",
    Content = "PanelText_UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_AmountLine_Content|/"
  },
  UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_GoodsNum = {
    ID = "UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_GoodsNum",
    Content = "PanelText_UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_GoodsNum_Content|数量"
  },
  UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_GoodsNumLine = {
    ID = "UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_GoodsNumLine",
    Content = "PanelText_UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_GoodsNumLine_Content|/"
  },
  UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_Null = {
    ID = "UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_Null",
    Content = "PanelText_UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_Null_Content|请选择要分解的物品"
  },
  UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_Mail = {
    ID = "UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_Mail",
    Content = "PanelText_UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_Mail_Content|规则说明"
  },
  UI_Alchemy_Popup_ResolveMaterials_Text_Time = {
    ID = "UI_Alchemy_Popup_ResolveMaterials_Text_Time",
    Content = "PanelText_UI_Alchemy_Popup_ResolveMaterials_Text_Time_Content|去其他地方看看吧"
  },
  UI_Chapter_Item_Dream_01_Text_C_Chaoter = {
    ID = "UI_Chapter_Item_Dream_01_Text_C_Chaoter",
    Content = "PanelText_UI_Chapter_Item_Dream_01_Text_C_Chaoter_Content|Dream View"
  },
  UI_Battle_Panel_Dbg_Text_C_insufficient = {
    ID = "UI_Battle_Panel_Dbg_Text_C_insufficient",
    Content = "PanelText_UI_Battle_Panel_Dbg_Text_C_insufficient_Content|空间不足"
  },
  UI_Awaker_Item_Potency_Detail_Text_C_Mad = {
    ID = "UI_Awaker_Item_Potency_Detail_Text_C_Mad",
    Content = "PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Mad_Content|超限狂气爆发解锁"
  },
  UI_Awaker_Item_Potency_Detail_Text_C_Ranking = {
    ID = "UI_Awaker_Item_Potency_Detail_Text_C_Ranking",
    Content = "PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Ranking_Content|提升预览"
  },
  UI_Events_Panel_Miriam_Text_C_Reward = {
    ID = "UI_Events_Panel_Miriam_Text_C_Reward",
    Content = "PanelText_UI_Events_Panel_Miriam_Text_C_Reward_Content|成就奖励"
  },
  UI_Events_Panel_Miriam_Text_C_Resonance = {
    ID = "UI_Events_Panel_Miriam_Text_C_Resonance",
    Content = "PanelText_UI_Events_Panel_Miriam_Text_C_Resonance_Content|共鸣：海渊祭仪"
  },
  UI_Events_Panel_Miriam_Text_C_Diagonal = {
    ID = "UI_Events_Panel_Miriam_Text_C_Diagonal",
    Content = "PanelText_UI_Events_Panel_Miriam_Text_C_Diagonal_Content|/"
  },
  UI_Events_Panel_Miriam_Text_C_Record = {
    ID = "UI_Events_Panel_Miriam_Text_C_Record",
    Content = "PanelText_UI_Events_Panel_Miriam_Text_C_Record_Content|异梦视界"
  },
  UI_Events_Panel_Miriam_Text_C_RecordTip = {
    ID = "UI_Events_Panel_Miriam_Text_C_RecordTip",
    Content = "PanelText_UI_Events_Panel_Miriam_Text_C_RecordTip_Content|限时免费解锁"
  },
  UI_Events_Panel_Miriam_Text_C_Challenge = {
    ID = "UI_Events_Panel_Miriam_Text_C_Challenge",
    Content = "PanelText_UI_Events_Panel_Miriam_Text_C_Challenge_Content|神国诞临"
  },
  UI_Events_Panel_Miriam_Text_C_ChallengeTip = {
    ID = "UI_Events_Panel_Miriam_Text_C_ChallengeTip",
    Content = "PanelText_UI_Events_Panel_Miriam_Text_C_ChallengeTip_Content|玩法限时开放"
  },
  UI_Events_Panel_Miriam_Text_C_Topic = {
    ID = "UI_Events_Panel_Miriam_Text_C_Topic",
    Content = "PanelText_UI_Events_Panel_Miriam_Text_C_Topic_Content|沉渊之祀"
  },
  UI_Events_Panel_Miriam_Text_C_Shop = {
    ID = "UI_Events_Panel_Miriam_Text_C_Shop",
    Content = "PanelText_UI_Events_Panel_Miriam_Text_C_Shop_Content|沉渊的回应"
  },
  UI_Events_Panel_Miriam_Text_C_Receive = {
    ID = "UI_Events_Panel_Miriam_Text_C_Receive",
    Content = "PanelText_UI_Events_Panel_Miriam_Text_C_Receive_Content|距离可领取"
  },
  UI_Events_Panel_Miriam_Text_C_Max = {
    ID = "UI_Events_Panel_Miriam_Text_C_Max",
    Content = "PanelText_UI_Events_Panel_Miriam_Text_C_Max_Content|Max"
  },
  UI_Events_Panel_Miriam_Text_C_Symbol = {
    ID = "UI_Events_Panel_Miriam_Text_C_Symbol",
    Content = "PanelText_UI_Events_Panel_Miriam_Text_C_Symbol_Content|)"
  },
  UI_Events_Panel_Miriam_Text_C_Fill_Up = {
    ID = "UI_Events_Panel_Miriam_Text_C_Fill_Up",
    Content = "PanelText_UI_Events_Panel_Miriam_Text_C_Fill_Up_Content|(距离补满："
  },
  UI_Events_Panel_Miriam_Text_C_Can_Unlockable = {
    ID = "UI_Events_Panel_Miriam_Text_C_Can_Unlockable",
    Content = "PanelText_UI_Events_Panel_Miriam_Text_C_Can_Unlockable_Content|可领取"
  },
  UI_Events_Panel_Miriam_Text_C_Not_unlocked = {
    ID = "UI_Events_Panel_Miriam_Text_C_Not_unlocked",
    Content = "PanelText_UI_Events_Panel_Miriam_Text_C_Not_unlocked_Content|未解锁"
  },
  UI_Events_Panel_Miriam_Text_C_Finished = {
    ID = "UI_Events_Panel_Miriam_Text_C_Finished",
    Content = "PanelText_UI_Events_Panel_Miriam_Text_C_Finished_Content|已结束"
  },
  UI_Events_Panel_Miriam_StageGroup_Text_C_Title = {
    ID = "UI_Events_Panel_Miriam_StageGroup_Text_C_Title",
    Content = "PanelText_UI_Events_Panel_Miriam_StageGroup_Text_C_Title_Content|神国诞临"
  },
  UI_Events_Panel_Miriam_StageGroup_Text_C_Introduction = {
    ID = "UI_Events_Panel_Miriam_StageGroup_Text_C_Introduction",
    Content = "PanelText_UI_Events_Panel_Miriam_StageGroup_Text_C_Introduction_Content|踏上这条艰难又神圣的道路吧。在道路的尽头，那最后的门将为你敞开。"
  },
  UI_Events_Panel_Miriam_StageGroup_Text_C_Resonance = {
    ID = "UI_Events_Panel_Miriam_StageGroup_Text_C_Resonance",
    Content = "PanelText_UI_Events_Panel_Miriam_StageGroup_Text_C_Resonance_Content|共鸣"
  },
  UI_Events_Item_Miriam_Text_C_Diagonal = {
    ID = "UI_Events_Item_Miriam_Text_C_Diagonal",
    Content = "PanelText_UI_Events_Item_Miriam_Text_C_Diagonal_Content|/"
  },
  UI_Events_Item_Miriam_Text_C_Fall = {
    ID = "UI_Events_Item_Miriam_Text_C_Fall",
    Content = "PanelText_UI_Events_Item_Miriam_Text_C_Fall_Content|掉落预览"
  },
  UI_Events_Item_Miriam_Text_C_LockTips = {
    ID = "UI_Events_Item_Miriam_Text_C_LockTips",
    Content = "PanelText_UI_Events_Item_Miriam_Text_C_LockTips_Content|关卡解锁提示"
  },
  UI_Social_Panel_Rank_Text_C_Separator = {
    ID = "UI_Social_Panel_Rank_Text_C_Separator",
    Content = "PanelText_UI_Social_Panel_Rank_Text_C_Separator_Content|/"
  },
  UI_Event_Activity_Miriam_Text_C_Reward = {
    ID = "UI_Event_Activity_Miriam_Text_C_Reward",
    Content = "PanelText_UI_Event_Activity_Miriam_Text_C_Reward_Content|获得物资"
  },
  UI_Event_Activity_Miriam_Text_C_Max = {
    ID = "UI_Event_Activity_Miriam_Text_C_Max",
    Content = "PanelText_UI_Event_Activity_Miriam_Text_C_Max_Content|Max"
  },
  UI_Event_Activity_Miriam_Text_C_Full = {
    ID = "UI_Event_Activity_Miriam_Text_C_Full",
    Content = "PanelText_UI_Event_Activity_Miriam_Text_C_Full_Content|当前已达存储上限"
  },
  UI_Event_Activity_Miriam_Text_C_Finish = {
    ID = "UI_Event_Activity_Miriam_Text_C_Finish",
    Content = "PanelText_UI_Event_Activity_Miriam_Text_C_Finish_Content|活动已结束，已停止获取"
  },
  UI_Event_Activity_Miriam_Text_C_SpeedTitle = {
    ID = "UI_Event_Activity_Miriam_Text_C_SpeedTitle",
    Content = "PanelText_UI_Event_Activity_Miriam_Text_C_SpeedTitle_Content|获取速度"
  },
  UI_Awaker_Item_Potency_Detail_Text_C_Unsolved = {
    ID = "UI_Awaker_Item_Potency_Detail_Text_C_Unsolved",
    Content = "PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Unsolved_Content|未解锁"
  },
  UI_Awaker_Item_Potency_Detail_Text_C_Solved = {
    ID = "UI_Awaker_Item_Potency_Detail_Text_C_Solved",
    Content = "PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Solved_Content|已解锁"
  },
  UI_Awaker_Popup_Topped_Tip3_Text_C_Unsolved = {
    ID = "UI_Awaker_Popup_Topped_Tip3_Text_C_Unsolved",
    Content = "PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Unsolved_Content|未解锁"
  },
  UI_Awaker_Popup_Topped_Tip3_Text_C_Solved = {
    ID = "UI_Awaker_Popup_Topped_Tip3_Text_C_Solved",
    Content = "PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Solved_Content|已解锁"
  },
  UI_Pvp_Panel_Settlement_Text_C_Attention_1 = {
    ID = "UI_Pvp_Panel_Settlement_Text_C_Attention_1",
    Content = "PanelText_UI_Pvp_Panel_Settlement_Text_C_Attention_1_Content|关注"
  },
  UI_Pvp_Panel_Settlement_Text_C_Attention_2 = {
    ID = "UI_Pvp_Panel_Settlement_Text_C_Attention_2",
    Content = "PanelText_UI_Pvp_Panel_Settlement_Text_C_Attention_2_Content|关注"
  },
  UI_Pvp_Panel_Settlement_Text_C_Commend_1 = {
    ID = "UI_Pvp_Panel_Settlement_Text_C_Commend_1",
    Content = "PanelText_UI_Pvp_Panel_Settlement_Text_C_Commend_1_Content|称赞"
  },
  UI_Pvp_Panel_Settlement_Text_C_Commend_2 = {
    ID = "UI_Pvp_Panel_Settlement_Text_C_Commend_2",
    Content = "PanelText_UI_Pvp_Panel_Settlement_Text_C_Commend_2_Content|已称赞"
  },
  UI_Pvp_Panel_Settlement_Text_C_Respectable = {
    ID = "UI_Pvp_Panel_Settlement_Text_C_Respectable",
    Content = "PanelText_UI_Pvp_Panel_Settlement_Text_C_Respectable_Content|可敬的对手！"
  },
  UI_Events_Panel_Back_To_School_Text_C_Not_Unlocked = {
    ID = "UI_Events_Panel_Back_To_School_Text_C_Not_Unlocked",
    Content = "PanelText_UI_Events_Panel_Back_To_School_Text_C_Not_Unlocked_Content|暂未解锁"
  },
  UI_Events_Panel_Back_To_School_Text_C_Shop = {
    ID = "UI_Events_Panel_Back_To_School_Text_C_Shop",
    Content = "PanelText_UI_Events_Panel_Back_To_School_Text_C_Shop_Content|返校商店"
  },
  UI_Social_Panel_Rank_Text_C_Sign = {
    ID = "UI_Social_Panel_Rank_Text_C_Sign",
    Content = "PanelText_UI_Social_Panel_Rank_Text_C_Sign_Content|简介"
  },
  UI_Battle_Popup_Anger_Overrun_Text_C_Title = {
    ID = "UI_Battle_Popup_Anger_Overrun_Text_C_Title",
    Content = "PanelText_UI_Battle_Popup_Anger_Overrun_Text_C_Title_Content|超限爆发"
  },
  UI_Battle_Popup_Anger_Overrun_Text_C_CD = {
    ID = "UI_Battle_Popup_Anger_Overrun_Text_C_CD",
    Content = "PanelText_UI_Battle_Popup_Anger_Overrun_Text_C_CD_Content|冷却中"
  },
  UI_Battle_Popup_Anger_Overrun_Text_C_Cooling = {
    ID = "UI_Battle_Popup_Anger_Overrun_Text_C_Cooling",
    Content = "PanelText_UI_Battle_Popup_Anger_Overrun_Text_C_Cooling_Content|冷却中，下回合才可以再次使用"
  },
  UI_Battle_Popup_Record_Tip_New_Text_C_Deepen_Tag = {
    ID = "UI_Battle_Popup_Record_Tip_New_Text_C_Deepen_Tag",
    Content = "PanelText_UI_Battle_Popup_Record_Tip_New_Text_C_Deepen_Tag_Content|人格深化"
  },
  UI_Dbgcopy_Popup_Vibes_Text_C_Title = {
    ID = "UI_Dbgcopy_Popup_Vibes_Text_C_Title",
    Content = "PanelText_UI_Dbgcopy_Popup_Vibes_Text_C_Title_Content|融灾黑潮效果说明"
  },
  UI_Dbgcopy_Popup_Vibes_Text_C_Suppress = {
    ID = "UI_Dbgcopy_Popup_Vibes_Text_C_Suppress",
    Content = "PanelText_UI_Dbgcopy_Popup_Vibes_Text_C_Suppress_Content|繁育"
  },
  UI_Events_Item_Sorel_Text_C_Diagonal = {
    ID = "UI_Events_Item_Sorel_Text_C_Diagonal",
    Content = "PanelText_UI_Events_Item_Sorel_Text_C_Diagonal_Content|/"
  },
  UI_Events_Item_Sorel_Text_C_Fall = {
    ID = "UI_Events_Item_Sorel_Text_C_Fall",
    Content = "PanelText_UI_Events_Item_Sorel_Text_C_Fall_Content|掉落预览"
  },
  UI_Events_Item_Sorel_Text_C_LockTips = {
    ID = "UI_Events_Item_Sorel_Text_C_LockTips",
    Content = "PanelText_UI_Events_Item_Sorel_Text_C_LockTips_Content|关卡解锁提示"
  },
  UI_Events_Panel_Sorel_StageGroup_Text_C_Title = {
    ID = "UI_Events_Panel_Sorel_StageGroup_Text_C_Title",
    Content = "PanelText_UI_Events_Panel_Sorel_StageGroup_Text_C_Title_Content|蔷薇忆事"
  },
  UI_Events_Panel_Sorel_StageGroup_Text_C_Introduction = {
    ID = "UI_Events_Panel_Sorel_StageGroup_Text_C_Introduction",
    Content = "PanelText_UI_Events_Panel_Sorel_StageGroup_Text_C_Introduction_Content|多年以后，传记作家在一个黄昏叩响她的家门。\n那天她们聊了很多，从玛瑙石到蔷薇凋零的宅邸……\n如今，作家将这些零碎的话语编纂成书，献予在座的诸位。"
  },
  UI_Events_Panel_Sorel_StageGroup_Text_C_Resonance = {
    ID = "UI_Events_Panel_Sorel_StageGroup_Text_C_Resonance",
    Content = "PanelText_UI_Events_Panel_Sorel_StageGroup_Text_C_Resonance_Content|共鸣"
  },
  UI_Events_Panel_Sorel_Text_C_Reward = {
    ID = "UI_Events_Panel_Sorel_Text_C_Reward",
    Content = "PanelText_UI_Events_Panel_Sorel_Text_C_Reward_Content|成就奖励"
  },
  UI_Events_Panel_Sorel_Text_C_Homology = {
    ID = "UI_Events_Panel_Sorel_Text_C_Homology",
    Content = "PanelText_UI_Events_Panel_Sorel_Text_C_Homology_Content|活动期间通过所有方式获取的同调率翻倍！"
  },
  UI_Events_Panel_Sorel_Text_C_Record = {
    ID = "UI_Events_Panel_Sorel_Text_C_Record",
    Content = "PanelText_UI_Events_Panel_Sorel_Text_C_Record_Content|蔷薇礼赞"
  },
  UI_Events_Panel_Sorel_Text_C_RecordTip = {
    ID = "UI_Events_Panel_Sorel_Text_C_RecordTip",
    Content = "PanelText_UI_Events_Panel_Sorel_Text_C_RecordTip_Content|限时免费解锁"
  },
  UI_Events_Panel_Sorel_Text_C_Challenge = {
    ID = "UI_Events_Panel_Sorel_Text_C_Challenge",
    Content = "PanelText_UI_Events_Panel_Sorel_Text_C_Challenge_Content|蔷薇忆事"
  },
  UI_Events_Panel_Sorel_Text_C_ChallengeTip = {
    ID = "UI_Events_Panel_Sorel_Text_C_ChallengeTip",
    Content = "PanelText_UI_Events_Panel_Sorel_Text_C_ChallengeTip_Content|玩法限时开放"
  },
  UI_Events_Panel_Sorel_Text_C_Topic = {
    ID = "UI_Events_Panel_Sorel_Text_C_Topic",
    Content = "PanelText_UI_Events_Panel_Sorel_Text_C_Topic_Content|与蔷薇书"
  },
  UI_Events_Panel_Sorel_Text_C_Shop = {
    ID = "UI_Events_Panel_Sorel_Text_C_Shop",
    Content = "PanelText_UI_Events_Panel_Sorel_Text_C_Shop_Content|金红庆典"
  },
  UI_Events_Panel_Sorel_Text_C_Pv = {
    ID = "UI_Events_Panel_Sorel_Text_C_Pv",
    Content = "PanelText_UI_Events_Panel_Sorel_Text_C_Pv_Content|播放影像"
  },
  UI_Chapter_Item_StageAchieve_Text_C_Lost = {
    ID = "UI_Chapter_Item_StageAchieve_Text_C_Lost",
    Content = "PanelText_UI_Chapter_Item_StageAchieve_Text_C_Lost_Content|未达成"
  },
  UI_Awaker_Item_Skill_Training_Text_C_Text_Need = {
    ID = "UI_Awaker_Item_Skill_Training_Text_C_Text_Need",
    Content = "PanelText_UI_Awaker_Item_Skill_Training_Text_C_Text_Need_Content|需要"
  },
  UI_Awaker_Item_Potency_Detail_Text_C_Skill_Story = {
    ID = "UI_Awaker_Item_Potency_Detail_Text_C_Skill_Story",
    Content = "PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Skill_Story_Content|激活材料"
  },
  UI_Social_Popup_Introduction_Text_C_Placeholder = {
    ID = "UI_Social_Popup_Introduction_Text_C_Placeholder",
    Content = "PanelText_UI_Social_Popup_Introduction_Text_C_Placeholder_Content|请输入个人简介"
  },
  UI_Pvp_Panel_Settlement_Text_C_OwnRespectable = {
    ID = "UI_Pvp_Panel_Settlement_Text_C_OwnRespectable",
    Content = "PanelText_UI_Pvp_Panel_Settlement_Text_C_OwnRespectable_Content|可敬的对手！"
  },
  UI_Events_Panel_Horla_StageGroup_Text_C_Title = {
    ID = "UI_Events_Panel_Horla_StageGroup_Text_C_Title",
    Content = "PanelText_UI_Events_Panel_Horla_StageGroup_Text_C_Title_Content|花园往事"
  },
  UI_Events_Panel_Horla_StageGroup_Text_C_Introduction = {
    ID = "UI_Events_Panel_Horla_StageGroup_Text_C_Introduction",
    Content = "PanelText_UI_Events_Panel_Horla_StageGroup_Text_C_Introduction_Content|残败花房里囚禁着孤独的玫瑰。"
  },
  UI_Events_Panel_Horla_StageGroup_Text_C_Resonance = {
    ID = "UI_Events_Panel_Horla_StageGroup_Text_C_Resonance",
    Content = "PanelText_UI_Events_Panel_Horla_StageGroup_Text_C_Resonance_Content|共鸣"
  },
  UI_Event_Activity_Horla_Text_C_Reward = {
    ID = "UI_Event_Activity_Horla_Text_C_Reward",
    Content = "PanelText_UI_Event_Activity_Horla_Text_C_Reward_Content|储存信息"
  },
  UI_Event_Activity_Horla_Text_C_Max = {
    ID = "UI_Event_Activity_Horla_Text_C_Max",
    Content = "PanelText_UI_Event_Activity_Horla_Text_C_Max_Content|Max"
  },
  UI_Event_Activity_Horla_Text_C_Full = {
    ID = "UI_Event_Activity_Horla_Text_C_Full",
    Content = "PanelText_UI_Event_Activity_Horla_Text_C_Full_Content|当前储存已达上限"
  },
  UI_Event_Activity_Horla_Text_C_Finish = {
    ID = "UI_Event_Activity_Horla_Text_C_Finish",
    Content = "PanelText_UI_Event_Activity_Horla_Text_C_Finish_Content|活动已结束"
  },
  UI_Event_Activity_Horla_Text_C_SpeedTitle = {
    ID = "UI_Event_Activity_Horla_Text_C_SpeedTitle",
    Content = "PanelText_UI_Event_Activity_Horla_Text_C_SpeedTitle_Content|储存速度"
  },
  Com_RedDot_Text_C_GroupNew = {
    ID = "Com_RedDot_Text_C_GroupNew",
    Content = "PanelText_Com_RedDot_Text_C_GroupNew_Content|新"
  },
  UI_Recharge_Panel_Main_Optimized_Text_C_Flushed = {
    ID = "UI_Recharge_Panel_Main_Optimized_Text_C_Flushed",
    Content = "PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Flushed_Content|刷新"
  },
  UI_Recharge_Panel_Main_Optimized_Text_C_Cost_Tips = {
    ID = "UI_Recharge_Panel_Main_Optimized_Text_C_Cost_Tips",
    Content = "PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Cost_Tips_Content|消耗"
  },
  UI_Recharge_Panel_Main_Optimized_Text_C_OnekeyPurchase = {
    ID = "UI_Recharge_Panel_Main_Optimized_Text_C_OnekeyPurchase",
    Content = "PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_OnekeyPurchase_Content|一键购买"
  },
  UI_Recharge_Panel_Main_Optimized_Text_C_Buttom_Tips = {
    ID = "UI_Recharge_Panel_Main_Optimized_Text_C_Buttom_Tips",
    Content = "PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Buttom_Tips_Content|每档首充翻倍，仅限一次"
  },
  UI_Recharge_Panel_Main_Optimized_Text_C_Refresh = {
    ID = "UI_Recharge_Panel_Main_Optimized_Text_C_Refresh",
    Content = "PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Refresh_Content|联系客服"
  },
  UI_Recharge_Panel_Main_Optimized_Text_C_Bigitle = {
    ID = "UI_Recharge_Panel_Main_Optimized_Text_C_Bigitle",
    Content = "PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Bigitle_Content|月相观测"
  },
  UI_Recharge_Panel_Main_Optimized_Text_C_Get1_Title = {
    ID = "UI_Recharge_Panel_Main_Optimized_Text_C_Get1_Title",
    Content = "PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Get1_Title_Content|立即获得"
  },
  UI_Recharge_Panel_Main_Optimized_Text_C_Get2_Title = {
    ID = "UI_Recharge_Panel_Main_Optimized_Text_C_Get2_Title",
    Content = "PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Get2_Title_Content|每日赠送"
  },
  UI_Recharge_Panel_Main_Optimized_Text_C_Tips = {
    ID = "UI_Recharge_Panel_Main_Optimized_Text_C_Tips",
    Content = "PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Tips_Content|*累计可获得300银芯结晶+3000银芯"
  },
  UI_Recharge_Panel_Main_Optimized_Text_C_Need = {
    ID = "UI_Recharge_Panel_Main_Optimized_Text_C_Need",
    Content = "PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Need_Content|需要"
  },
  UI_Recharge_Panel_Main_Optimized_Text_C_Illustrate = {
    ID = "UI_Recharge_Panel_Main_Optimized_Text_C_Illustrate",
    Content = "PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Illustrate_Content|可累计购买"
  },
  UI_Recharge_Panel_Main_Optimized_Text_C_Expired = {
    ID = "UI_Recharge_Panel_Main_Optimized_Text_C_Expired",
    Content = "PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Expired_Content|已过期"
  },
  UI_Recharge_Panel_Main_Optimized_Text_C_Today = {
    ID = "UI_Recharge_Panel_Main_Optimized_Text_C_Today",
    Content = "PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Today_Content|今天已领取"
  },
  UI_Recharge_OnekeyPurchase_Text_C_Tips = {
    ID = "UI_Recharge_OnekeyPurchase_Text_C_Tips",
    Content = "PanelText_UI_Recharge_OnekeyPurchase_Text_C_Tips_Content|可以选择移除无需购买的物品"
  },
  UI_Recharge_OnekeyPurchase_Text_C_Cost_Tips = {
    ID = "UI_Recharge_OnekeyPurchase_Text_C_Cost_Tips",
    Content = "PanelText_UI_Recharge_OnekeyPurchase_Text_C_Cost_Tips_Content|总计消耗"
  },
  UI_Recharge_OnekeyPurchase_Text_C_Title = {
    ID = "UI_Recharge_OnekeyPurchase_Text_C_Title",
    Content = "PanelText_UI_Recharge_OnekeyPurchase_Text_C_Title_Content|购买确认"
  },
  UI_Recharge_Panel_Main_Text_C_OnekeyPurchase = {
    ID = "UI_Recharge_Panel_Main_Text_C_OnekeyPurchase",
    Content = "PanelText_UI_Recharge_Panel_Main_Text_C_OnekeyPurchase_Content|一键购买"
  },
  UI_Dungeons_Popup_List_Tip_Text_C_Information_2 = {
    ID = "UI_Dungeons_Popup_List_Tip_Text_C_Information_2",
    Content = "PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Information_2_Content|调查头衔"
  },
  UI_Dungeons_Popup_List_Tip_Text_C_En = {
    ID = "UI_Dungeons_Popup_List_Tip_Text_C_En",
    Content = "PanelText_UI_Dungeons_Popup_List_Tip_Text_C_En_Content|fdshsjfgjgf"
  },
  UI_Dungeous_Item_Reward_Text_C_Present = {
    ID = "UI_Dungeous_Item_Reward_Text_C_Present",
    Content = "PanelText_UI_Dungeous_Item_Reward_Text_C_Present_Content|当前"
  },
  UI_Dungeons_Panel_SurveyData_Text_Time = {
    ID = "UI_Dungeons_Panel_SurveyData_Text_Time",
    Content = "PanelText_UI_Dungeons_Panel_SurveyData_Text_Time_Content|去其他地方看看吧"
  },
  UI_Team_Panel_Main_Text_Madness = {
    ID = "UI_Team_Panel_Main_Text_Madness",
    Content = "PanelText_UI_Team_Panel_Main_Text_Madness_Content|癫狂难度仅可获得首通奖励"
  },
  UI_Events_Panel_Horla_Text_C_Shop = {
    ID = "UI_Events_Panel_Horla_Text_C_Shop",
    Content = "PanelText_UI_Events_Panel_Horla_Text_C_Shop_Content|柯蕾特的花房"
  },
  UI_Events_Panel_Horla_Text_C_Resonance = {
    ID = "UI_Events_Panel_Horla_Text_C_Resonance",
    Content = "PanelText_UI_Events_Panel_Horla_Text_C_Resonance_Content|共鸣：花园挽歌"
  },
  UI_Events_Panel_Horla_Text_C_Diagonal = {
    ID = "UI_Events_Panel_Horla_Text_C_Diagonal",
    Content = "PanelText_UI_Events_Panel_Horla_Text_C_Diagonal_Content|/"
  },
  UI_Events_Panel_Horla_Text_C_Reward = {
    ID = "UI_Events_Panel_Horla_Text_C_Reward",
    Content = "PanelText_UI_Events_Panel_Horla_Text_C_Reward_Content|成就奖励"
  },
  UI_Events_Panel_Horla_Text_C_Record = {
    ID = "UI_Events_Panel_Horla_Text_C_Record",
    Content = "PanelText_UI_Events_Panel_Horla_Text_C_Record_Content|特遣纪录"
  },
  UI_Events_Panel_Horla_Text_C_RecordTip = {
    ID = "UI_Events_Panel_Horla_Text_C_RecordTip",
    Content = "PanelText_UI_Events_Panel_Horla_Text_C_RecordTip_Content|限时免费解锁"
  },
  UI_Events_Panel_Horla_Text_C_Challenge = {
    ID = "UI_Events_Panel_Horla_Text_C_Challenge",
    Content = "PanelText_UI_Events_Panel_Horla_Text_C_Challenge_Content|花园往事"
  },
  UI_Events_Panel_Horla_Text_C_ChallengeTip = {
    ID = "UI_Events_Panel_Horla_Text_C_ChallengeTip",
    Content = "PanelText_UI_Events_Panel_Horla_Text_C_ChallengeTip_Content|玩法限时开放"
  },
  UI_Events_Panel_Horla_Text_C_Topic = {
    ID = "UI_Events_Panel_Horla_Text_C_Topic",
    Content = "PanelText_UI_Events_Panel_Horla_Text_C_Topic_Content|在春天凋零以前"
  },
  UI_Events_Panel_Horla_Text_C_Receive = {
    ID = "UI_Events_Panel_Horla_Text_C_Receive",
    Content = "PanelText_UI_Events_Panel_Horla_Text_C_Receive_Content|距离可领取"
  },
  UI_Events_Panel_Horla_Text_C_Max = {
    ID = "UI_Events_Panel_Horla_Text_C_Max",
    Content = "PanelText_UI_Events_Panel_Horla_Text_C_Max_Content|Max"
  },
  UI_Events_Panel_Horla_Text_C_Symbol = {
    ID = "UI_Events_Panel_Horla_Text_C_Symbol",
    Content = "PanelText_UI_Events_Panel_Horla_Text_C_Symbol_Content|)"
  },
  UI_Events_Panel_Horla_Text_C_Fill_Up = {
    ID = "UI_Events_Panel_Horla_Text_C_Fill_Up",
    Content = "PanelText_UI_Events_Panel_Horla_Text_C_Fill_Up_Content|(距离补满："
  },
  UI_Events_Panel_Horla_Text_C_Can_Unlockable = {
    ID = "UI_Events_Panel_Horla_Text_C_Can_Unlockable",
    Content = "PanelText_UI_Events_Panel_Horla_Text_C_Can_Unlockable_Content|可领取"
  },
  UI_Events_Panel_Horla_Text_C_Not_unlocked = {
    ID = "UI_Events_Panel_Horla_Text_C_Not_unlocked",
    Content = "PanelText_UI_Events_Panel_Horla_Text_C_Not_unlocked_Content|未解锁"
  },
  UI_Events_Panel_Horla_Text_C_Finished = {
    ID = "UI_Events_Panel_Horla_Text_C_Finished",
    Content = "PanelText_UI_Events_Panel_Horla_Text_C_Finished_Content|已结束"
  },
  UI_Team_Panel_Edit_Suit_Text_C_Save = {
    ID = "UI_Team_Panel_Edit_Suit_Text_C_Save",
    Content = "PanelText_UI_Team_Panel_Edit_Suit_Text_C_Save_Content|保存"
  },
  UI_Team_Panel_Edit_Suit_Text_C_Remove = {
    ID = "UI_Team_Panel_Edit_Suit_Text_C_Remove",
    Content = "PanelText_UI_Team_Panel_Edit_Suit_Text_C_Remove_Content|一键卸下"
  },
  UI_Team_Panel_Edit_Suit_Text_C_Recommend = {
    ID = "UI_Team_Panel_Edit_Suit_Text_C_Recommend",
    Content = "PanelText_UI_Team_Panel_Edit_Suit_Text_C_Recommend_Content|推荐"
  },
  UI_Alchemy_Popup_ResolveMaterials_SiftTitle_Text_C_Tips = {
    ID = "UI_Alchemy_Popup_ResolveMaterials_SiftTitle_Text_C_Tips",
    Content = "PanelText_UI_Alchemy_Popup_ResolveMaterials_SiftTitle_Text_C_Tips_Content|点击选择"
  },
  UI_Social_Popup_PlayerHead_Text_C_Head = {
    ID = "UI_Social_Popup_PlayerHead_Text_C_Head",
    Content = "PanelText_UI_Social_Popup_PlayerHead_Text_C_Head_Content|头像"
  },
  UI_Social_Popup_PlayerHead_Text_C_Head_Sel = {
    ID = "UI_Social_Popup_PlayerHead_Text_C_Head_Sel",
    Content = "PanelText_UI_Social_Popup_PlayerHead_Text_C_Head_Sel_Content|头像"
  },
  UI_Social_Popup_PlayerHead_Text_C_HeadFrame = {
    ID = "UI_Social_Popup_PlayerHead_Text_C_HeadFrame",
    Content = "PanelText_UI_Social_Popup_PlayerHead_Text_C_HeadFrame_Content|头像框"
  },
  UI_Social_Popup_PlayerHead_Text_C_HeadFrame_Sel = {
    ID = "UI_Social_Popup_PlayerHead_Text_C_HeadFrame_Sel",
    Content = "PanelText_UI_Social_Popup_PlayerHead_Text_C_HeadFrame_Sel_Content|头像框"
  },
  UI_Common_Popup_Tips_Confirm_L_Text_C_Title = {
    ID = "UI_Common_Popup_Tips_Confirm_L_Text_C_Title",
    Content = "PanelText_UI_Common_Popup_Tips_Confirm_L_Text_C_Title_Content|升格预览"
  },
  UI_Common_Popup_Tips_Confirm_L_Text_C_Material = {
    ID = "UI_Common_Popup_Tips_Confirm_L_Text_C_Material",
    Content = "PanelText_UI_Common_Popup_Tips_Confirm_L_Text_C_Material_Content|升格材料"
  },
  UI_Common_Popup_Tips_Confirm_L_Text_C_Need = {
    ID = "UI_Common_Popup_Tips_Confirm_L_Text_C_Need",
    Content = "PanelText_UI_Common_Popup_Tips_Confirm_L_Text_C_Need_Content|需要"
  },
  UI_Common_Popup_Tips_Confirm_L_Text_C_Reward = {
    ID = "UI_Common_Popup_Tips_Confirm_L_Text_C_Reward",
    Content = "PanelText_UI_Common_Popup_Tips_Confirm_L_Text_C_Reward_Content|升格奖励"
  },
  UI_Pvp_Popup_Tips_Text_Time = {
    ID = "UI_Pvp_Popup_Tips_Text_Time",
    Content = "PanelText_UI_Pvp_Popup_Tips_Text_Time_Content|去其他地方看看吧"
  },
  UI_Pvp_Team_Main_Text_Name = {
    ID = "UI_Pvp_Team_Main_Text_Name",
    Content = "PanelText_UI_Pvp_Team_Main_Text_Name_Content|快速编队"
  },
  UI_Dungeons_Popup_AbyssRank_Text_Title = {
    ID = "UI_Dungeons_Popup_AbyssRank_Text_Title",
    Content = "PanelText_UI_Dungeons_Popup_AbyssRank_Text_Title_Content|排行榜"
  },
  UI_Dungeons_Popup_Award_Optimized_Text_C_OneKey = {
    ID = "UI_Dungeons_Popup_Award_Optimized_Text_C_OneKey",
    Content = "PanelText_UI_Dungeons_Popup_Award_Optimized_Text_C_OneKey_Content|一键领取"
  },
  UI_Dungeons_Popup_Award_Text_C_OneKey = {
    ID = "UI_Dungeons_Popup_Award_Text_C_OneKey",
    Content = "PanelText_UI_Dungeons_Popup_Award_Text_C_OneKey_Content|一键领取"
  },
  UI_Events_Item_SurveyDiary_Text_Name = {
    ID = "UI_Events_Item_SurveyDiary_Text_Name",
    Content = "PanelText_UI_Events_Item_SurveyDiary_Text_Name_Content|领取"
  },
  UI_Chapter_Item_Success_List_Text_Lost = {
    ID = "UI_Chapter_Item_Success_List_Text_Lost",
    Content = "PanelText_UI_Chapter_Item_Success_List_Text_Lost_Content|未达成"
  },
  UI_Chapter_Item_Achievement_List_Text_Lost = {
    ID = "UI_Chapter_Item_Achievement_List_Text_Lost",
    Content = "PanelText_UI_Chapter_Item_Achievement_List_Text_Lost_Content|未达成"
  },
  UI_Research_Panel_Dispatch_Text_Title = {
    ID = "UI_Research_Panel_Dispatch_Text_Title",
    Content = "PanelText_UI_Research_Panel_Dispatch_Text_Title_Content|派遣"
  },
  UI_Collection_Panel_Organize_Text_Title = {
    ID = "UI_Collection_Panel_Organize_Text_Title",
    Content = "PanelText_UI_Collection_Panel_Organize_Text_Title_Content|秘典书库"
  },
  UI_Research_Panel_Dispatch_Content_Text_Underway = {
    ID = "UI_Research_Panel_Dispatch_Content_Text_Underway",
    Content = "PanelText_UI_Research_Panel_Dispatch_Content_Text_Underway_Content|派遣中…"
  },
  UI_Research_Popup_Report_Text_C_Title = {
    ID = "UI_Research_Popup_Report_Text_C_Title",
    Content = "PanelText_UI_Research_Popup_Report_Text_C_Title_Content|调查报告"
  },
  Battle_UltiSkill_Painting_EX_Text_C_UltiSkill = {
    ID = "Battle_UltiSkill_Painting_EX_Text_C_UltiSkill",
    Content = "PanelText_Battle_UltiSkill_Painting_EX_Text_C_UltiSkill_Content|超限爆发"
  },
  UI_Events_Item_Murphy_Text_C_Diagonal = {
    ID = "UI_Events_Item_Murphy_Text_C_Diagonal",
    Content = "PanelText_UI_Events_Item_Murphy_Text_C_Diagonal_Content|/"
  },
  UI_Events_Item_Murphy_Text_C_Fall = {
    ID = "UI_Events_Item_Murphy_Text_C_Fall",
    Content = "PanelText_UI_Events_Item_Murphy_Text_C_Fall_Content|掉落预览"
  },
  UI_Events_Item_Murphy_Text_C_LockTips = {
    ID = "UI_Events_Item_Murphy_Text_C_LockTips",
    Content = "PanelText_UI_Events_Item_Murphy_Text_C_LockTips_Content|关卡解锁提示"
  },
  UI_Events_Panel_Murphy_StageGroup_Text_C_Title = {
    ID = "UI_Events_Panel_Murphy_StageGroup_Text_C_Title",
    Content = "PanelText_UI_Events_Panel_Murphy_StageGroup_Text_C_Title_Content|黑暗子宫"
  },
  UI_Events_Panel_Murphy_StageGroup_Text_C_Introduction = {
    ID = "UI_Events_Panel_Murphy_StageGroup_Text_C_Introduction",
    Content = "PanelText_UI_Events_Panel_Murphy_StageGroup_Text_C_Introduction_Content|自祂@1黑暗的@2中，伟大的@3降临世界"
  },
  UI_Events_Panel_Murphy_StageGroup_Text_C_Resonance = {
    ID = "UI_Events_Panel_Murphy_StageGroup_Text_C_Resonance",
    Content = "PanelText_UI_Events_Panel_Murphy_StageGroup_Text_C_Resonance_Content|共鸣"
  },
  UI_Events_Panel_Murphy_Text_C_Reward = {
    ID = "UI_Events_Panel_Murphy_Text_C_Reward",
    Content = "PanelText_UI_Events_Panel_Murphy_Text_C_Reward_Content|成就奖励"
  },
  UI_Events_Panel_Murphy_Text_C_Shop = {
    ID = "UI_Events_Panel_Murphy_Text_C_Shop",
    Content = "PanelText_UI_Events_Panel_Murphy_Text_C_Shop_Content|圣胎孵化"
  },
  UI_Events_Panel_Murphy_Text_C_Homology = {
    ID = "UI_Events_Panel_Murphy_Text_C_Homology",
    Content = "PanelText_UI_Events_Panel_Murphy_Text_C_Homology_Content|活动期间通过所有方式获取的同调率翻倍！"
  },
  UI_Events_Panel_Murphy_Text_C_Record = {
    ID = "UI_Events_Panel_Murphy_Text_C_Record",
    Content = "PanelText_UI_Events_Panel_Murphy_Text_C_Record_Content|蔷薇礼赞"
  },
  UI_Events_Panel_Murphy_Text_C_RecordTip = {
    ID = "UI_Events_Panel_Murphy_Text_C_RecordTip",
    Content = "PanelText_UI_Events_Panel_Murphy_Text_C_RecordTip_Content|限时免费解锁"
  },
  UI_Events_Panel_Murphy_Text_C_Challenge = {
    ID = "UI_Events_Panel_Murphy_Text_C_Challenge",
    Content = "PanelText_UI_Events_Panel_Murphy_Text_C_Challenge_Content|黑暗子宫"
  },
  UI_Events_Panel_Murphy_Text_C_ChallengeTip = {
    ID = "UI_Events_Panel_Murphy_Text_C_ChallengeTip",
    Content = "PanelText_UI_Events_Panel_Murphy_Text_C_ChallengeTip_Content|玩法限时开放"
  },
  UI_Events_Panel_Murphy_Text_C_Topic = {
    ID = "UI_Events_Panel_Murphy_Text_C_Topic",
    Content = "PanelText_UI_Events_Panel_Murphy_Text_C_Topic_Content|群星正位·复刻"
  },
  UI_Events_Panel_Murphy_Text_C_Pv = {
    ID = "UI_Events_Panel_Murphy_Text_C_Pv",
    Content = "PanelText_UI_Events_Panel_Murphy_Text_C_Pv_Content|播放影像"
  },
  UI_Recharge_Panel_Main_Text_Get2_Title2 = {
    ID = "UI_Recharge_Panel_Main_Text_Get2_Title2",
    Content = "PanelText_UI_Recharge_Panel_Main_Text_Get2_Title2_Content|（30天）"
  },
  UI_Recharge_Panel_Main_Optimized_Text_Get2_Title2 = {
    ID = "UI_Recharge_Panel_Main_Optimized_Text_Get2_Title2",
    Content = "PanelText_UI_Recharge_Panel_Main_Optimized_Text_Get2_Title2_Content|（30天）"
  },
  UI_Address_Panel_NewMessage_Text_Title = {
    ID = "UI_Address_Panel_NewMessage_Text_Title",
    Content = "PanelText_UI_Address_Panel_NewMessage_Text_Title_Content|通讯器"
  },
  UI_Address_Panel_Main_Text_C_Title = {
    ID = "UI_Address_Panel_Main_Text_C_Title",
    Content = "PanelText_UI_Address_Panel_Main_Text_C_Title_Content|通讯器"
  },
  UI_Address_Panel_Main_Text_C_NoTask1 = {
    ID = "UI_Address_Panel_Main_Text_C_NoTask1",
    Content = "PanelText_UI_Address_Panel_Main_Text_C_NoTask1_Content|选择联络人"
  },
  UI_Address_Panel_Main_Text_C_En = {
    ID = "UI_Address_Panel_Main_Text_C_En",
    Content = "PanelText_UI_Address_Panel_Main_Text_C_En_Content|fdshsjfgjgf"
  },
  UI_Address_Panel_Main_Text_Time = {
    ID = "UI_Address_Panel_Main_Text_Time",
    Content = "PanelText_UI_Address_Panel_Main_Text_Time_Content|点击列表进行选择"
  },
  UI_Awaker_Popup_Topped_Tip_Text_Screening = {
    ID = "UI_Awaker_Popup_Topped_Tip_Text_Screening",
    Content = "PanelText_UI_Awaker_Popup_Topped_Tip_Text_Screening_Content|奖励已领取"
  },
  UI_Social_Item_FriendlyInvite_Text_C_Done = {
    ID = "UI_Social_Item_FriendlyInvite_Text_C_Done",
    Content = "PanelText_UI_Social_Item_FriendlyInvite_Text_C_Done_Content|已关注我"
  },
  UI_Social_Item_FriendlyInvite_Text_C_Mutual = {
    ID = "UI_Social_Item_FriendlyInvite_Text_C_Mutual",
    Content = "PanelText_UI_Social_Item_FriendlyInvite_Text_C_Mutual_Content|互相关注"
  },
  UI_Social_Item_FriendlyInvite_Text_C_Accept = {
    ID = "UI_Social_Item_FriendlyInvite_Text_C_Accept",
    Content = "PanelText_UI_Social_Item_FriendlyInvite_Text_C_Accept_Content|接受"
  },
  UI_Social_Item_FriendlyInvite_Text_C_Refuse = {
    ID = "UI_Social_Item_FriendlyInvite_Text_C_Refuse",
    Content = "PanelText_UI_Social_Item_FriendlyInvite_Text_C_Refuse_Content|拒绝"
  },
  UI_Social_Item_FriendlyInvite_Text_C_Cancel = {
    ID = "UI_Social_Item_FriendlyInvite_Text_C_Cancel",
    Content = "PanelText_UI_Social_Item_FriendlyInvite_Text_C_Cancel_Content|已取消"
  },
  UI_Social_Item_FriendlyInvite_Text_C_Timeout = {
    ID = "UI_Social_Item_FriendlyInvite_Text_C_Timeout",
    Content = "PanelText_UI_Social_Item_FriendlyInvite_Text_C_Timeout_Content|已超时"
  },
  UI_Social_Popup_FriendlyInvite_Text_Title = {
    ID = "UI_Social_Popup_FriendlyInvite_Text_Title",
    Content = "PanelText_UI_Social_Popup_FriendlyInvite_Text_Title_Content|友谊赛邀请"
  },
  UI_Social_Tips_InviteBubble_Text_Name = {
    ID = "UI_Social_Tips_InviteBubble_Text_Name",
    Content = "PanelText_UI_Social_Tips_InviteBubble_Text_Name_Content|友谊赛"
  },
  UI_Social_Popup_Match_Text_Title = {
    ID = "UI_Social_Popup_Match_Text_Title",
    Content = "PanelText_UI_Social_Popup_Match_Text_Title_Content|友谊赛"
  },
  UI_Social_Popup_Match_Text_Name = {
    ID = "UI_Social_Popup_Match_Text_Name",
    Content = "PanelText_UI_Social_Popup_Match_Text_Name_Content|取消"
  },
  UI_Social_Item_FriendlyInvite_Text_C_Refuse2 = {
    ID = "UI_Social_Item_FriendlyInvite_Text_C_Refuse2",
    Content = "PanelText_UI_Social_Item_FriendlyInvite_Text_C_Refuse2_Content|已拒绝"
  },
  UI_Social_Popup_Match_Text_C_Waiting = {
    ID = "UI_Social_Popup_Match_Text_C_Waiting",
    Content = "PanelText_UI_Social_Popup_Match_Text_C_Waiting_Content|正在等待"
  },
  UI_Collection_Panel_SetMainBg_Text_C_Normal = {
    ID = "UI_Collection_Panel_SetMainBg_Text_C_Normal",
    Content = "PanelText_UI_Collection_Panel_SetMainBg_Text_C_Normal_Content|设为宿舍背景"
  },
  UI_Collection_Panel_SetMainBg_Text_C_High = {
    ID = "UI_Collection_Panel_SetMainBg_Text_C_High",
    Content = "PanelText_UI_Collection_Panel_SetMainBg_Text_C_High_Content|重置宿舍背景"
  },
  UI_Collection_Panel_SetMainBg_Text_C_Hide = {
    ID = "UI_Collection_Panel_SetMainBg_Text_C_Hide",
    Content = "PanelText_UI_Collection_Panel_SetMainBg_Text_C_Hide_Content|隐藏唤醒体"
  },
  UI_Collection_Panel_SetMainBg_Text_C_Display = {
    ID = "UI_Collection_Panel_SetMainBg_Text_C_Display",
    Content = "PanelText_UI_Collection_Panel_SetMainBg_Text_C_Display_Content|显示唤醒体"
  },
  UI_Collection_Panel_SetMainBg_Text_C_Save = {
    ID = "UI_Collection_Panel_SetMainBg_Text_C_Save",
    Content = "PanelText_UI_Collection_Panel_SetMainBg_Text_C_Save_Content|保存"
  },
  UI_Collection_Panel_SetMainBg_Text_C_Cancel = {
    ID = "UI_Collection_Panel_SetMainBg_Text_C_Cancel",
    Content = "PanelText_UI_Collection_Panel_SetMainBg_Text_C_Cancel_Content|取消"
  },
  UI_Main_Favor_Tip_Text_C_Name = {
    ID = "UI_Main_Favor_Tip_Text_C_Name",
    Content = "PanelText_UI_Main_Favor_Tip_Text_C_Name_Content|同调率"
  },
  UI_Events_Panel_Ryker_Text_C_Reward = {
    ID = "UI_Events_Panel_Ryker_Text_C_Reward",
    Content = "PanelText_UI_Events_Panel_Ryker_Text_C_Reward_Content|成就奖励"
  },
  UI_Events_Panel_Ryker_Text_C_Homology = {
    ID = "UI_Events_Panel_Ryker_Text_C_Homology",
    Content = "PanelText_UI_Events_Panel_Ryker_Text_C_Homology_Content|活动期间通过所有方式获取的同调率翻倍！"
  },
  UI_Events_Panel_Ryker_Text_C_Record = {
    ID = "UI_Events_Panel_Ryker_Text_C_Record",
    Content = "PanelText_UI_Events_Panel_Ryker_Text_C_Record_Content|狩猎愉快！"
  },
  UI_Events_Panel_Ryker_Text_C_RecordTip = {
    ID = "UI_Events_Panel_Ryker_Text_C_RecordTip",
    Content = "PanelText_UI_Events_Panel_Ryker_Text_C_RecordTip_Content|限时免费解锁"
  },
  UI_Events_Panel_Ryker_Text_C_Challenge = {
    ID = "UI_Events_Panel_Ryker_Text_C_Challenge",
    Content = "PanelText_UI_Events_Panel_Ryker_Text_C_Challenge_Content|月夜传说"
  },
  UI_Events_Panel_Ryker_Text_C_ChallengeTip = {
    ID = "UI_Events_Panel_Ryker_Text_C_ChallengeTip",
    Content = "PanelText_UI_Events_Panel_Ryker_Text_C_ChallengeTip_Content|玩法限时开放"
  },
  UI_Events_Panel_Ryker_Text_C_Topic = {
    ID = "UI_Events_Panel_Ryker_Text_C_Topic",
    Content = "PanelText_UI_Events_Panel_Ryker_Text_C_Topic_Content|名侦探手册·复刻"
  },
  UI_Events_Panel_Ryker_Text_C_Shop = {
    ID = "UI_Events_Panel_Ryker_Text_C_Shop",
    Content = "PanelText_UI_Events_Panel_Ryker_Text_C_Shop_Content|好运俱乐部"
  },
  UI_Events_Panel_Ryker_Text_C_Pv = {
    ID = "UI_Events_Panel_Ryker_Text_C_Pv",
    Content = "PanelText_UI_Events_Panel_Ryker_Text_C_Pv_Content|播放影像"
  },
  UI_Events_Panel_Ryker_StageGroup_Text_C_Title = {
    ID = "UI_Events_Panel_Ryker_StageGroup_Text_C_Title",
    Content = "PanelText_UI_Events_Panel_Ryker_StageGroup_Text_C_Title_Content|月夜传说"
  },
  UI_Events_Panel_Ryker_StageGroup_Text_C_Introduction = {
    ID = "UI_Events_Panel_Ryker_StageGroup_Text_C_Introduction",
    Content = "PanelText_UI_Events_Panel_Ryker_StageGroup_Text_C_Introduction_Content|没错，现在已经不流行平平无奇的普通人侦探了。 \n如果你既不能飞天遁地、也没有一个科学家助理， 请重新制定你的职业规划。"
  },
  UI_Events_Panel_Ryker_StageGroup_Text_C_Resonance = {
    ID = "UI_Events_Panel_Ryker_StageGroup_Text_C_Resonance",
    Content = "PanelText_UI_Events_Panel_Ryker_StageGroup_Text_C_Resonance_Content|共鸣"
  },
  UI_Events_Item_Ryker_Text_C_Diagonal = {
    ID = "UI_Events_Item_Ryker_Text_C_Diagonal",
    Content = "PanelText_UI_Events_Item_Ryker_Text_C_Diagonal_Content|/"
  },
  UI_Events_Item_Ryker_Text_C_Fall = {
    ID = "UI_Events_Item_Ryker_Text_C_Fall",
    Content = "PanelText_UI_Events_Item_Ryker_Text_C_Fall_Content|掉落预览"
  },
  UI_Events_Item_Ryker_Text_C_LockTips = {
    ID = "UI_Events_Item_Ryker_Text_C_LockTips",
    Content = "PanelText_UI_Events_Item_Ryker_Text_C_LockTips_Content|关卡解锁提示"
  },
  UI_Events_Panel_Wanda_StageGroup_Text_C_illustrate = {
    ID = "UI_Events_Panel_Wanda_StageGroup_Text_C_illustrate",
    Content = "PanelText_UI_Events_Panel_Wanda_StageGroup_Text_C_illustrate_Content|玩法规则"
  },
  UI_Events_Panel_Wanda_StageGroup_Text_C_Title = {
    ID = "UI_Events_Panel_Wanda_StageGroup_Text_C_Title",
    Content = "PanelText_UI_Events_Panel_Wanda_StageGroup_Text_C_Title_Content|湖中之城"
  },
  UI_Events_Panel_Wanda_StageGroup_Text_C_Describe = {
    ID = "UI_Events_Panel_Wanda_StageGroup_Text_C_Describe",
    Content = "PanelText_UI_Events_Panel_Wanda_StageGroup_Text_C_Describe_Content|伊萨拉乌，湖中之城，据说是旺达故乡的所在。\n这次你将穿过梦境的大门，抵达那遍布钟舌的古老塔群……"
  },
  UI_Events_Panel_Wanda_StageGroup_Text_C_Resonance = {
    ID = "UI_Events_Panel_Wanda_StageGroup_Text_C_Resonance",
    Content = "PanelText_UI_Events_Panel_Wanda_StageGroup_Text_C_Resonance_Content|共鸣"
  },
  UI_Events_Item_Wanda_Text_C_Diagonal = {
    ID = "UI_Events_Item_Wanda_Text_C_Diagonal",
    Content = "PanelText_UI_Events_Item_Wanda_Text_C_Diagonal_Content|/"
  },
  UI_Events_Item_Wanda_Text_C_Fall = {
    ID = "UI_Events_Item_Wanda_Text_C_Fall",
    Content = "PanelText_UI_Events_Item_Wanda_Text_C_Fall_Content|掉落预览"
  },
  UI_Events_Item_Wanda_Text_C_LockTips = {
    ID = "UI_Events_Item_Wanda_Text_C_LockTips",
    Content = "PanelText_UI_Events_Item_Wanda_Text_C_LockTips_Content|关卡解锁提示"
  },
  UI_Events_Panel_Wanda_Text_C_Reward = {
    ID = "UI_Events_Panel_Wanda_Text_C_Reward",
    Content = "PanelText_UI_Events_Panel_Wanda_Text_C_Reward_Content|成就奖励"
  },
  UI_Events_Panel_Wanda_Text_C_Resonance = {
    ID = "UI_Events_Panel_Wanda_Text_C_Resonance",
    Content = "PanelText_UI_Events_Panel_Wanda_Text_C_Resonance_Content|共鸣：代行密令"
  },
  UI_Events_Panel_Wanda_Text_C_Diagonal = {
    ID = "UI_Events_Panel_Wanda_Text_C_Diagonal",
    Content = "PanelText_UI_Events_Panel_Wanda_Text_C_Diagonal_Content|/"
  },
  UI_Events_Panel_Wanda_Text_C_Record = {
    ID = "UI_Events_Panel_Wanda_Text_C_Record",
    Content = "PanelText_UI_Events_Panel_Wanda_Text_C_Record_Content|燃烧的群宴"
  },
  UI_Events_Panel_Wanda_Text_C_RecordTip = {
    ID = "UI_Events_Panel_Wanda_Text_C_RecordTip",
    Content = "PanelText_UI_Events_Panel_Wanda_Text_C_RecordTip_Content|限时免费解锁"
  },
  UI_Events_Panel_Wanda_Text_C_Challenge = {
    ID = "UI_Events_Panel_Wanda_Text_C_Challenge",
    Content = "PanelText_UI_Events_Panel_Wanda_Text_C_Challenge_Content|湖中之城"
  },
  UI_Events_Panel_Wanda_Text_C_ChallengeTip = {
    ID = "UI_Events_Panel_Wanda_Text_C_ChallengeTip",
    Content = "PanelText_UI_Events_Panel_Wanda_Text_C_ChallengeTip_Content|玩法限时开放"
  },
  UI_Events_Panel_Wanda_Text_C_Topic = {
    ID = "UI_Events_Panel_Wanda_Text_C_Topic",
    Content = "PanelText_UI_Events_Panel_Wanda_Text_C_Topic_Content|燃烧的群宴"
  },
  UI_Events_Panel_Wanda_Text_C_Shop = {
    ID = "UI_Events_Panel_Wanda_Text_C_Shop",
    Content = "PanelText_UI_Events_Panel_Wanda_Text_C_Shop_Content|旺达的奇珍宝匣"
  },
  UI_Events_Panel_Wanda_Text_C_Receive = {
    ID = "UI_Events_Panel_Wanda_Text_C_Receive",
    Content = "PanelText_UI_Events_Panel_Wanda_Text_C_Receive_Content|距离可领取"
  },
  UI_Events_Panel_Wanda_Text_C_Max = {
    ID = "UI_Events_Panel_Wanda_Text_C_Max",
    Content = "PanelText_UI_Events_Panel_Wanda_Text_C_Max_Content|Max"
  },
  UI_Events_Panel_Wanda_Text_C_Symbol = {
    ID = "UI_Events_Panel_Wanda_Text_C_Symbol",
    Content = "PanelText_UI_Events_Panel_Wanda_Text_C_Symbol_Content|)"
  },
  UI_Events_Panel_Wanda_Text_C_Fill_Up = {
    ID = "UI_Events_Panel_Wanda_Text_C_Fill_Up",
    Content = "PanelText_UI_Events_Panel_Wanda_Text_C_Fill_Up_Content|(距离补满："
  },
  UI_Events_Panel_Wanda_Text_C_Can_Unlockable = {
    ID = "UI_Events_Panel_Wanda_Text_C_Can_Unlockable",
    Content = "PanelText_UI_Events_Panel_Wanda_Text_C_Can_Unlockable_Content|可领取"
  },
  UI_Events_Panel_Wanda_Text_C_Not_unlocked = {
    ID = "UI_Events_Panel_Wanda_Text_C_Not_unlocked",
    Content = "PanelText_UI_Events_Panel_Wanda_Text_C_Not_unlocked_Content|未解锁"
  },
  UI_Events_Panel_Wanda_Text_C_Finished = {
    ID = "UI_Events_Panel_Wanda_Text_C_Finished",
    Content = "PanelText_UI_Events_Panel_Wanda_Text_C_Finished_Content|已结束"
  },
  UI_Events_Panel_Wanda_Text_C_Pv = {
    ID = "UI_Events_Panel_Wanda_Text_C_Pv",
    Content = "PanelText_UI_Events_Panel_Wanda_Text_C_Pv_Content|播放影像"
  },
  UI_Login_Text_C_Setting = {
    ID = "UI_Login_Text_C_Setting",
    Content = "PanelText_UI_Login_Text_C_Setting_Content|设置"
  },
  UI_Collection_Panel_EquipDetail_Text_C_Title = {
    ID = "UI_Collection_Panel_EquipDetail_Text_C_Title",
    Content = "PanelText_UI_Collection_Panel_EquipDetail_Text_C_Title_Content|故事"
  },
  UI_Collection_Panel_Event_Text_C_Placeholder = {
    ID = "UI_Collection_Panel_Event_Text_C_Placeholder",
    Content = "PanelText_UI_Collection_Panel_Event_Text_C_Placeholder_Content|搜索名词..."
  },
  UI_Collection_Panel_Relic_Text_C_Mail = {
    ID = "UI_Collection_Panel_Relic_Text_C_Mail",
    Content = "PanelText_UI_Collection_Panel_Relic_Text_C_Mail_Content|收集进度"
  },
  UI_Collection_Panel_Relic_Text_Title = {
    ID = "UI_Collection_Panel_Relic_Text_Title",
    Content = "PanelText_UI_Collection_Panel_Relic_Text_Title_Content|秘典书库"
  },
  UI_Collection_Panel_SetMainBg_Text_C_HideAwaker = {
    ID = "UI_Collection_Panel_SetMainBg_Text_C_HideAwaker",
    Content = "PanelText_UI_Collection_Panel_SetMainBg_Text_C_HideAwaker_Content|设置此图为宿舍背景后，来客立绘将隐藏"
  },
  UI_Social_Panel_Main_Item_Text_C_Unblock = {
    ID = "UI_Social_Panel_Main_Item_Text_C_Unblock",
    Content = "PanelText_UI_Social_Panel_Main_Item_Text_C_Unblock_Content|取消拉黑"
  },
  UI_Address_Panel_NewMessage_Text_C_NoTask = {
    ID = "UI_Address_Panel_NewMessage_Text_C_NoTask",
    Content = "PanelText_UI_Address_Panel_NewMessage_Text_C_NoTask_Content|暂无新讯息"
  },
  UI_Address_Panel_NewMessage_Text_C_En = {
    ID = "UI_Address_Panel_NewMessage_Text_C_En",
    Content = "PanelText_UI_Address_Panel_NewMessage_Text_C_En_Content|fdshsjfgjgf"
  },
  UI_Address_Panel_NewMessage_Text_Time = {
    ID = "UI_Address_Panel_NewMessage_Text_Time",
    Content = "PanelText_UI_Address_Panel_NewMessage_Text_Time_Content|去其他地方看看吧"
  },
  UI_Social_Item_PvpRecord_Text_Fail = {
    ID = "UI_Social_Item_PvpRecord_Text_Fail",
    Content = "PanelText_UI_Social_Item_PvpRecord_Text_Fail_Content|失败"
  },
  UI_Social_Item_PvpRecord_Text_Victory = {
    ID = "UI_Social_Item_PvpRecord_Text_Victory",
    Content = "PanelText_UI_Social_Item_PvpRecord_Text_Victory_Content|胜利"
  },
  UI_Social_Item_Pvp_Text_C_NoTask = {
    ID = "UI_Social_Item_Pvp_Text_C_NoTask",
    Content = "PanelText_UI_Social_Item_Pvp_Text_C_NoTask_Content|暂无相位对弈记录"
  },
  UI_Social_Item_Pvp_Text_Time = {
    ID = "UI_Social_Item_Pvp_Text_Time",
    Content = "PanelText_UI_Social_Item_Pvp_Text_Time_Content|去其他地方看看吧"
  },
  UI_Social_Item_PvpData_Text_C_Point_01 = {
    ID = "UI_Social_Item_PvpData_Text_C_Point_01",
    Content = "PanelText_UI_Social_Item_PvpData_Text_C_Point_01_Content|分"
  },
  UI_Social_Item_PvpData_Text_Victory = {
    ID = "UI_Social_Item_PvpData_Text_Victory",
    Content = "PanelText_UI_Social_Item_PvpData_Text_Victory_Content|胜利"
  },
  UI_Social_Item_PvpData_Text_Fail = {
    ID = "UI_Social_Item_PvpData_Text_Fail",
    Content = "PanelText_UI_Social_Item_PvpData_Text_Fail_Content|失败"
  },
  UI_Pvp_Popup_PlaybackAngle_Text_C_Copy = {
    ID = "UI_Pvp_Popup_PlaybackAngle_Text_C_Copy",
    Content = "PanelText_UI_Pvp_Popup_PlaybackAngle_Text_C_Copy_Content|复制"
  },
  UI_Pvp_Popup_PlaybackAngle_Text_Title = {
    ID = "UI_Pvp_Popup_PlaybackAngle_Text_Title",
    Content = "PanelText_UI_Pvp_Popup_PlaybackAngle_Text_Title_Content|选择视角"
  },
  UI_Pvp_Popup_PlaybackAngle_Text_Name = {
    ID = "UI_Pvp_Popup_PlaybackAngle_Text_Name",
    Content = "PanelText_UI_Pvp_Popup_PlaybackAngle_Text_Name_Content|观看回放"
  },
  UI_Pvp_Panel_Playback_Text_C_Angle = {
    ID = "UI_Pvp_Panel_Playback_Text_C_Angle",
    Content = "PanelText_UI_Pvp_Panel_Playback_Text_C_Angle_Content|切换视角"
  },
  UI_Chapter_Vindicate_View_Text_C_NoTask = {
    ID = "UI_Chapter_Vindicate_View_Text_C_NoTask",
    Content = "PanelText_UI_Chapter_Vindicate_View_Text_C_NoTask_Content|繁衍狂热暂未解锁"
  },
  UI_Chapter_Vindicate_View_Text_C_En = {
    ID = "UI_Chapter_Vindicate_View_Text_C_En",
    Content = "PanelText_UI_Chapter_Vindicate_View_Text_C_En_Content|fdshsjfgjgf"
  },
  UI_Chapter_Vindicate_View_Text_Time = {
    ID = "UI_Chapter_Vindicate_View_Text_Time",
    Content = "PanelText_UI_Chapter_Vindicate_View_Text_Time_Content|去其他地方看看吧"
  },
  UI_Events_Panel_GamePassport_Text_C_Senior = {
    ID = "UI_Events_Panel_GamePassport_Text_C_Senior",
    Content = "PanelText_UI_Events_Panel_GamePassport_Text_C_Senior_Content|高级纪行"
  },
  UI_Events_Panel_GamePassport_Text_C_Ordinary = {
    ID = "UI_Events_Panel_GamePassport_Text_C_Ordinary",
    Content = "PanelText_UI_Events_Panel_GamePassport_Text_C_Ordinary_Content|普通纪行"
  },
  UI_Events_Panel_GamePassport_Text_C_PassportUp = {
    ID = "UI_Events_Panel_GamePassport_Text_C_PassportUp",
    Content = "PanelText_UI_Events_Panel_GamePassport_Text_C_PassportUp_Content|纪行进阶"
  },
  UI_Events_Panel_GamePassport_Text_C_OneKey = {
    ID = "UI_Events_Panel_GamePassport_Text_C_OneKey",
    Content = "PanelText_UI_Events_Panel_GamePassport_Text_C_OneKey_Content|一键领取"
  },
  UI_Social_Item_Data_Overview_Left_Text_C_Ban = {
    ID = "UI_Social_Item_Data_Overview_Left_Text_C_Ban",
    Content = "PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Ban_Content|拉黑"
  },
  UI_Events_Item_GiftBag_Text_C_Free = {
    ID = "UI_Events_Item_GiftBag_Text_C_Free",
    Content = "PanelText_UI_Events_Item_GiftBag_Text_C_Free_Content|免费"
  },
  UI_Events_Item_GiftBag_Text_C_Noraml = {
    ID = "UI_Events_Item_GiftBag_Text_C_Noraml",
    Content = "PanelText_UI_Events_Item_GiftBag_Text_C_Noraml_Content|领取"
  },
  UI_Events_Item_GiftBag_Text_C_High = {
    ID = "UI_Events_Item_GiftBag_Text_C_High",
    Content = "PanelText_UI_Events_Item_GiftBag_Text_C_High_Content|免费"
  },
  UI_Events_Item_GiftBag_Text_C_Soldout = {
    ID = "UI_Events_Item_GiftBag_Text_C_Soldout",
    Content = "PanelText_UI_Events_Item_GiftBag_Text_C_Soldout_Content|已领取"
  },
  UI_Events_Panel_Hamline_Text_C_Shop = {
    ID = "UI_Events_Panel_Hamline_Text_C_Shop",
    Content = "PanelText_UI_Events_Panel_Hamline_Text_C_Shop_Content|安眠宫殿"
  },
  UI_Events_Panel_Hamline_Text_C_Resonance = {
    ID = "UI_Events_Panel_Hamline_Text_C_Resonance",
    Content = "PanelText_UI_Events_Panel_Hamline_Text_C_Resonance_Content|共鸣：无"
  },
  UI_Events_Panel_Hamline_Text_C_Diagonal = {
    ID = "UI_Events_Panel_Hamline_Text_C_Diagonal",
    Content = "PanelText_UI_Events_Panel_Hamline_Text_C_Diagonal_Content|/"
  },
  UI_Events_Panel_Hamline_Text_C_Reward = {
    ID = "UI_Events_Panel_Hamline_Text_C_Reward",
    Content = "PanelText_UI_Events_Panel_Hamline_Text_C_Reward_Content|成就奖励"
  },
  UI_Events_Panel_Hamline_Text_C_Record = {
    ID = "UI_Events_Panel_Hamline_Text_C_Record",
    Content = "PanelText_UI_Events_Panel_Hamline_Text_C_Record_Content|特遣纪录"
  },
  UI_Events_Panel_Hamline_Text_C_RecordTip = {
    ID = "UI_Events_Panel_Hamline_Text_C_RecordTip",
    Content = "PanelText_UI_Events_Panel_Hamline_Text_C_RecordTip_Content|限时免费解锁"
  },
  UI_Events_Panel_Hamline_Text_C_Challenge = {
    ID = "UI_Events_Panel_Hamline_Text_C_Challenge",
    Content = "PanelText_UI_Events_Panel_Hamline_Text_C_Challenge_Content|轰鸣之音"
  },
  UI_Events_Panel_Hamline_Text_C_ChallengeTip = {
    ID = "UI_Events_Panel_Hamline_Text_C_ChallengeTip",
    Content = "PanelText_UI_Events_Panel_Hamline_Text_C_ChallengeTip_Content|玩法限时开放"
  },
  UI_Events_Panel_Hamline_Text_C_Topic = {
    ID = "UI_Events_Panel_Hamline_Text_C_Topic",
    Content = "PanelText_UI_Events_Panel_Hamline_Text_C_Topic_Content|无形交响"
  },
  UI_Events_Panel_Hamline_Text_C_Receive = {
    ID = "UI_Events_Panel_Hamline_Text_C_Receive",
    Content = "PanelText_UI_Events_Panel_Hamline_Text_C_Receive_Content|距离可领取"
  },
  UI_Events_Panel_Hamline_Text_C_Max = {
    ID = "UI_Events_Panel_Hamline_Text_C_Max",
    Content = "PanelText_UI_Events_Panel_Hamline_Text_C_Max_Content|Max"
  },
  UI_Events_Panel_Hamline_Text_C_Symbol = {
    ID = "UI_Events_Panel_Hamline_Text_C_Symbol",
    Content = "PanelText_UI_Events_Panel_Hamline_Text_C_Symbol_Content|)"
  },
  UI_Events_Panel_Hamline_Text_C_Fill_Up = {
    ID = "UI_Events_Panel_Hamline_Text_C_Fill_Up",
    Content = "PanelText_UI_Events_Panel_Hamline_Text_C_Fill_Up_Content|(距离补满："
  },
  UI_Events_Panel_Hamline_Text_C_Can_Unlockable = {
    ID = "UI_Events_Panel_Hamline_Text_C_Can_Unlockable",
    Content = "PanelText_UI_Events_Panel_Hamline_Text_C_Can_Unlockable_Content|可领取"
  },
  UI_Events_Panel_Hamline_Text_C_Not_unlocked = {
    ID = "UI_Events_Panel_Hamline_Text_C_Not_unlocked",
    Content = "PanelText_UI_Events_Panel_Hamline_Text_C_Not_unlocked_Content|未解锁"
  },
  UI_Events_Panel_Hamline_Text_C_Finished = {
    ID = "UI_Events_Panel_Hamline_Text_C_Finished",
    Content = "PanelText_UI_Events_Panel_Hamline_Text_C_Finished_Content|已结束"
  },
  UI_Events_Panel_Hameln_StageGroup_Text_C_Title = {
    ID = "UI_Events_Panel_Hameln_StageGroup_Text_C_Title",
    Content = "PanelText_UI_Events_Panel_Hameln_StageGroup_Text_C_Title_Content|轰鸣之音"
  },
  UI_Events_Panel_Hameln_StageGroup_Text_C_Introduction = {
    ID = "UI_Events_Panel_Hameln_StageGroup_Text_C_Introduction",
    Content = "PanelText_UI_Events_Panel_Hameln_StageGroup_Text_C_Introduction_Content|轰鸣之音，在他游弋的棒尖奏响。\n沉浸长梦，直至毁灭终章。"
  },
  UI_Events_Panel_Hameln_StageGroup_Text_C_Resonance = {
    ID = "UI_Events_Panel_Hameln_StageGroup_Text_C_Resonance",
    Content = "PanelText_UI_Events_Panel_Hameln_StageGroup_Text_C_Resonance_Content|共鸣"
  },
  UI_Events_Item_Hamline_Text_C_Diagonal = {
    ID = "UI_Events_Item_Hamline_Text_C_Diagonal",
    Content = "PanelText_UI_Events_Item_Hamline_Text_C_Diagonal_Content|/"
  },
  UI_Events_Item_Hamline_Text_C_Fall = {
    ID = "UI_Events_Item_Hamline_Text_C_Fall",
    Content = "PanelText_UI_Events_Item_Hamline_Text_C_Fall_Content|掉落预览"
  },
  UI_Events_Item_Hamline_Text_C_LockTips = {
    ID = "UI_Events_Item_Hamline_Text_C_LockTips",
    Content = "PanelText_UI_Events_Item_Hamline_Text_C_LockTips_Content|关卡解锁提示"
  },
  UI_Events_Panel_GamePassport_Text_C_illustrate = {
    ID = "UI_Events_Panel_GamePassport_Text_C_illustrate",
    Content = "PanelText_UI_Events_Panel_GamePassport_Text_C_illustrate_Content|活动说明"
  },
  UI_Collection_Panel_Relic_Text_C_Title = {
    ID = "UI_Collection_Panel_Relic_Text_C_Title",
    Content = "PanelText_UI_Collection_Panel_Relic_Text_C_Title_Content|故事"
  },
  UI_Events_Panel_OriHelot_Text_C_Shop = {
    ID = "UI_Events_Panel_OriHelot_Text_C_Shop",
    Content = "PanelText_UI_Events_Panel_OriHelot_Text_C_Shop_Content|山峦巨口"
  },
  UI_Events_Panel_OriHelot_Text_C_Resonance = {
    ID = "UI_Events_Panel_OriHelot_Text_C_Resonance",
    Content = "PanelText_UI_Events_Panel_OriHelot_Text_C_Resonance_Content|共鸣：吞噬山脉"
  },
  UI_Events_Panel_OriHelot_Text_C_Diagonal = {
    ID = "UI_Events_Panel_OriHelot_Text_C_Diagonal",
    Content = "PanelText_UI_Events_Panel_OriHelot_Text_C_Diagonal_Content|/"
  },
  UI_Events_Panel_OriHelot_Text_C_Reward = {
    ID = "UI_Events_Panel_OriHelot_Text_C_Reward",
    Content = "PanelText_UI_Events_Panel_OriHelot_Text_C_Reward_Content|成就奖励"
  },
  UI_Events_Panel_OriHelot_Text_C_Record = {
    ID = "UI_Events_Panel_OriHelot_Text_C_Record",
    Content = "PanelText_UI_Events_Panel_OriHelot_Text_C_Record_Content|特遣纪录"
  },
  UI_Events_Panel_OriHelot_Text_C_RecordTip = {
    ID = "UI_Events_Panel_OriHelot_Text_C_RecordTip",
    Content = "PanelText_UI_Events_Panel_OriHelot_Text_C_RecordTip_Content|限时免费解锁"
  },
  UI_Events_Panel_OriHelot_Text_C_Challenge = {
    ID = "UI_Events_Panel_OriHelot_Text_C_Challenge",
    Content = "PanelText_UI_Events_Panel_OriHelot_Text_C_Challenge_Content|野兽雄心"
  },
  UI_Events_Panel_OriHelot_Text_C_ChallengeTip = {
    ID = "UI_Events_Panel_OriHelot_Text_C_ChallengeTip",
    Content = "PanelText_UI_Events_Panel_OriHelot_Text_C_ChallengeTip_Content|玩法限时开放"
  },
  UI_Events_Panel_OriHelot_Text_C_Topic = {
    ID = "UI_Events_Panel_OriHelot_Text_C_Topic",
    Content = "PanelText_UI_Events_Panel_OriHelot_Text_C_Topic_Content|雪山消融之时·复刻"
  },
  UI_Events_Panel_OriHelot_Text_C_Receive = {
    ID = "UI_Events_Panel_OriHelot_Text_C_Receive",
    Content = "PanelText_UI_Events_Panel_OriHelot_Text_C_Receive_Content|距离可领取"
  },
  UI_Events_Panel_OriHelot_Text_C_Max = {
    ID = "UI_Events_Panel_OriHelot_Text_C_Max",
    Content = "PanelText_UI_Events_Panel_OriHelot_Text_C_Max_Content|Max"
  },
  UI_Events_Panel_OriHelot_Text_C_Symbol = {
    ID = "UI_Events_Panel_OriHelot_Text_C_Symbol",
    Content = "PanelText_UI_Events_Panel_OriHelot_Text_C_Symbol_Content|)"
  },
  UI_Events_Panel_OriHelot_Text_C_Fill_Up = {
    ID = "UI_Events_Panel_OriHelot_Text_C_Fill_Up",
    Content = "PanelText_UI_Events_Panel_OriHelot_Text_C_Fill_Up_Content|(距离补满："
  },
  UI_Events_Panel_OriHelot_Text_C_Can_Unlockable = {
    ID = "UI_Events_Panel_OriHelot_Text_C_Can_Unlockable",
    Content = "PanelText_UI_Events_Panel_OriHelot_Text_C_Can_Unlockable_Content|可领取"
  },
  UI_Events_Panel_OriHelot_Text_C_Not_unlocked = {
    ID = "UI_Events_Panel_OriHelot_Text_C_Not_unlocked",
    Content = "PanelText_UI_Events_Panel_OriHelot_Text_C_Not_unlocked_Content|未解锁"
  },
  UI_Events_Panel_OriHelot_Text_C_Finished = {
    ID = "UI_Events_Panel_OriHelot_Text_C_Finished",
    Content = "PanelText_UI_Events_Panel_OriHelot_Text_C_Finished_Content|已结束"
  },
  UI_Events_OriHelot_Text_C_Diagonal = {
    ID = "UI_Events_OriHelot_Text_C_Diagonal",
    Content = "PanelText_UI_Events_OriHelot_Text_C_Diagonal_Content|/"
  },
  UI_Events_OriHelot_Text_C_Fall = {
    ID = "UI_Events_OriHelot_Text_C_Fall",
    Content = "PanelText_UI_Events_OriHelot_Text_C_Fall_Content|掉落预览"
  },
  UI_Events_OriHelot_Text_C_LockTips = {
    ID = "UI_Events_OriHelot_Text_C_LockTips",
    Content = "PanelText_UI_Events_OriHelot_Text_C_LockTips_Content|关卡解锁提示"
  },
  UI_Events_OriHelot_StageGroup_Text_C_Title = {
    ID = "UI_Events_OriHelot_StageGroup_Text_C_Title",
    Content = "PanelText_UI_Events_OriHelot_StageGroup_Text_C_Title_Content|野兽雄心"
  },
  UI_Events_OriHelot_StageGroup_Text_C_Introduction = {
    ID = "UI_Events_OriHelot_StageGroup_Text_C_Introduction",
    Content = "PanelText_UI_Events_OriHelot_StageGroup_Text_C_Introduction_Content|张大嘴巴，大口撕咬。\n吞食与被吞食，这是战斗的规则，这是野兽的命运。"
  },
  UI_Events_OriHelot_StageGroup_Text_C_Resonance = {
    ID = "UI_Events_OriHelot_StageGroup_Text_C_Resonance",
    Content = "PanelText_UI_Events_OriHelot_StageGroup_Text_C_Resonance_Content|共鸣"
  },
  UI_Events_Item_SignDiamond_Text_C_Receive = {
    ID = "UI_Events_Item_SignDiamond_Text_C_Receive",
    Content = "PanelText_UI_Events_Item_SignDiamond_Text_C_Receive_Content|已领取"
  },
  UI_Event_WeaponOptional_Text_C_Receive = {
    ID = "UI_Event_WeaponOptional_Text_C_Receive",
    Content = "PanelText_UI_Event_WeaponOptional_Text_C_Receive_Content|剩余唤醒次数："
  },
  UI_Event_Item_WeaponOptional_Text_C_Got = {
    ID = "UI_Event_Item_WeaponOptional_Text_C_Got",
    Content = "PanelText_UI_Event_Item_WeaponOptional_Text_C_Got_Content|已拥有"
  },
  UI_Dungeous_Panel_Difficulty_Optimized_Text_C_Difficulty = {
    ID = "UI_Dungeous_Panel_Difficulty_Optimized_Text_C_Difficulty",
    Content = "PanelText_UI_Dungeous_Panel_Difficulty_Optimized_Text_C_Difficulty_Content|下沉深度"
  },
  UI_Event_Activity_RewardPool_Text_Name = {
    ID = "UI_Event_Activity_RewardPool_Text_Name",
    Content = "PanelText_UI_Event_Activity_RewardPool_Text_Name_Content|全部交换"
  },
  UI_Login_Panel_ServerSelect_Text_Panel_Title = {
    ID = "UI_Login_Panel_ServerSelect_Text_Panel_Title",
    Content = "PanelText_UI_Login_Panel_ServerSelect_Text_Panel_Title_Content|服务器选择"
  },
  UI_Mail_Text_Time = {
    ID = "UI_Mail_Text_Time",
    Content = "PanelText_UI_Mail_Text_Time_Content|去其他地方看看吧"
  },
  UI_Alchemy_Popup_Break_Down_Placeholder = {
    ID = "UI_Alchemy_Popup_Break_Down_Placeholder",
    Content = "PanelText_UI_Alchemy_Popup_Break_Down_Placeholder_Content|点击输入答案"
  },
  UI_Research_Popup_Recall_Text_C_Extra = {
    ID = "UI_Research_Popup_Recall_Text_C_Extra",
    Content = "PanelText_UI_Research_Popup_Recall_Text_C_Extra_Content|[额外]"
  },
  UI_Mail_Text_C_En = {
    ID = "UI_Mail_Text_C_En",
    Content = "PanelText_UI_Mail_Text_C_En_Content|fdshsjfgjgf"
  },
  UI_Mail_Text_Time2 = {
    ID = "UI_Mail_Text_Time2",
    Content = "PanelText_UI_Mail_Text_Time2_Content|去其他地方看看吧"
  },
  UI_Event_Activity_TwentyFour_Text_Name = {
    ID = "UI_Event_Activity_TwentyFour_Text_Name",
    Content = "PanelText_UI_Event_Activity_TwentyFour_Text_Name_Content|领取"
  },
  UI_Event_Panel_Challenge_Text_C_SweepName = {
    ID = "UI_Event_Panel_Challenge_Text_C_SweepName",
    Content = "PanelText_UI_Event_Panel_Challenge_Text_C_SweepName_Content|扫荡"
  },
  UI_Social_Item_Data_Overview_Left_Placeholder = {
    ID = "UI_Social_Item_Data_Overview_Left_Placeholder",
    Content = "PanelText_UI_Social_Item_Data_Overview_Left_Placeholder_Content|请输入个人简介"
  },
  UI_Vindicate_Popup_Reward_Text_Title = {
    ID = "UI_Vindicate_Popup_Reward_Text_Title",
    Content = "PanelText_UI_Vindicate_Popup_Reward_Text_Title_Content|首通奖励"
  },
  UI_Event_Activity_Miriam_Text_None = {
    ID = "UI_Event_Activity_Miriam_Text_None",
    Content = "PanelText_UI_Event_Activity_Miriam_Text_None_Content|暂无物资"
  },
  UI_Event_Activity_TwentyFour_Text_None = {
    ID = "UI_Event_Activity_TwentyFour_Text_None",
    Content = "PanelText_UI_Event_Activity_TwentyFour_Text_None_Content|暂无物资"
  },
  UI_Events_Panel_Tawil_StageGroup_Text_C_Title = {
    ID = "UI_Events_Panel_Tawil_StageGroup_Text_C_Title",
    Content = "PanelText_UI_Events_Panel_Tawil_StageGroup_Text_C_Title_Content|最终测试"
  },
  UI_Events_Panel_Tawil_StageGroup_Text_C_Introduction = {
    ID = "UI_Events_Panel_Tawil_StageGroup_Text_C_Introduction",
    Content = "PanelText_UI_Events_Panel_Tawil_StageGroup_Text_C_Introduction_Content|跨越穷极之门，抵达无限智慧的领域。\n直面亵渎之物，了悟何为「自身」。\n这是祂赐予你的《最终测试》。"
  },
  UI_Events_Panel_Tawil_StageGroup_Text_C_Resonance = {
    ID = "UI_Events_Panel_Tawil_StageGroup_Text_C_Resonance",
    Content = "PanelText_UI_Events_Panel_Tawil_StageGroup_Text_C_Resonance_Content|共鸣"
  },
  UI_Events_Item_Tawil_Text_C_Diagonal = {
    ID = "UI_Events_Item_Tawil_Text_C_Diagonal",
    Content = "PanelText_UI_Events_Item_Tawil_Text_C_Diagonal_Content|/"
  },
  UI_Events_Item_Tawil_Text_C_Fall = {
    ID = "UI_Events_Item_Tawil_Text_C_Fall",
    Content = "PanelText_UI_Events_Item_Tawil_Text_C_Fall_Content|掉落预览"
  },
  UI_Events_Item_Tawil_Text_C_LockTips = {
    ID = "UI_Events_Item_Tawil_Text_C_LockTips",
    Content = "PanelText_UI_Events_Item_Tawil_Text_C_LockTips_Content|关卡解锁提示"
  },
  UI_Events_Panel_Tawil_Text_C_Shop = {
    ID = "UI_Events_Panel_Tawil_Text_C_Shop",
    Content = "PanelText_UI_Events_Panel_Tawil_Text_C_Shop_Content|回声"
  },
  UI_Events_Panel_Tawil_Text_C_Resonance = {
    ID = "UI_Events_Panel_Tawil_Text_C_Resonance",
    Content = "PanelText_UI_Events_Panel_Tawil_Text_C_Resonance_Content|共鸣：吞噬山脉"
  },
  UI_Events_Panel_Tawil_Text_C_Diagonal = {
    ID = "UI_Events_Panel_Tawil_Text_C_Diagonal",
    Content = "PanelText_UI_Events_Panel_Tawil_Text_C_Diagonal_Content|/"
  },
  UI_Events_Panel_Tawil_Text_C_Reward = {
    ID = "UI_Events_Panel_Tawil_Text_C_Reward",
    Content = "PanelText_UI_Events_Panel_Tawil_Text_C_Reward_Content|成就奖励"
  },
  UI_Events_Panel_Tawil_Text_C_Record = {
    ID = "UI_Events_Panel_Tawil_Text_C_Record",
    Content = "PanelText_UI_Events_Panel_Tawil_Text_C_Record_Content|特遣纪录"
  },
  UI_Events_Panel_Tawil_Text_C_RecordTip = {
    ID = "UI_Events_Panel_Tawil_Text_C_RecordTip",
    Content = "PanelText_UI_Events_Panel_Tawil_Text_C_RecordTip_Content|限时免费解锁"
  },
  UI_Events_Panel_Tawil_Text_C_Challenge = {
    ID = "UI_Events_Panel_Tawil_Text_C_Challenge",
    Content = "PanelText_UI_Events_Panel_Tawil_Text_C_Challenge_Content|最终测试"
  },
  UI_Events_Panel_Tawil_Text_C_ChallengeTip = {
    ID = "UI_Events_Panel_Tawil_Text_C_ChallengeTip",
    Content = "PanelText_UI_Events_Panel_Tawil_Text_C_ChallengeTip_Content|玩法限时开放"
  },
  UI_Events_Panel_Tawil_Text_C_Topic = {
    ID = "UI_Events_Panel_Tawil_Text_C_Topic",
    Content = "PanelText_UI_Events_Panel_Tawil_Text_C_Topic_Content|万象门扉"
  },
  UI_Events_Panel_Tawil_Text_C_Receive = {
    ID = "UI_Events_Panel_Tawil_Text_C_Receive",
    Content = "PanelText_UI_Events_Panel_Tawil_Text_C_Receive_Content|距离可领取"
  },
  UI_Events_Panel_Tawil_Text_C_Max = {
    ID = "UI_Events_Panel_Tawil_Text_C_Max",
    Content = "PanelText_UI_Events_Panel_Tawil_Text_C_Max_Content|Max"
  },
  UI_Events_Panel_Tawil_Text_C_Symbol = {
    ID = "UI_Events_Panel_Tawil_Text_C_Symbol",
    Content = "PanelText_UI_Events_Panel_Tawil_Text_C_Symbol_Content|)"
  },
  UI_Events_Panel_Tawil_Text_C_Fill_Up = {
    ID = "UI_Events_Panel_Tawil_Text_C_Fill_Up",
    Content = "PanelText_UI_Events_Panel_Tawil_Text_C_Fill_Up_Content|(距离补满："
  },
  UI_Events_Panel_Tawil_Text_C_Can_Unlockable = {
    ID = "UI_Events_Panel_Tawil_Text_C_Can_Unlockable",
    Content = "PanelText_UI_Events_Panel_Tawil_Text_C_Can_Unlockable_Content|可领取"
  },
  UI_Events_Panel_Tawil_Text_C_Not_unlocked = {
    ID = "UI_Events_Panel_Tawil_Text_C_Not_unlocked",
    Content = "PanelText_UI_Events_Panel_Tawil_Text_C_Not_unlocked_Content|未解锁"
  },
  UI_Events_Panel_Tawil_Text_C_Finished = {
    ID = "UI_Events_Panel_Tawil_Text_C_Finished",
    Content = "PanelText_UI_Events_Panel_Tawil_Text_C_Finished_Content|已结束"
  },
  UI_Events_Panel_WorldBoss_Text_C_Topic = {
    ID = "UI_Events_Panel_WorldBoss_Text_C_Topic",
    Content = "PanelText_UI_Events_Panel_WorldBoss_Text_C_Topic_Content|决胜：原初之影"
  },
  UI_Events_Panel_WorldBoss_Text_C_Challenge = {
    ID = "UI_Events_Panel_WorldBoss_Text_C_Challenge",
    Content = "PanelText_UI_Events_Panel_WorldBoss_Text_C_Challenge_Content|辰星安魂曲"
  },
  UI_Events_Panel_WorldBoss_Text_C_ProgressTitle = {
    ID = "UI_Events_Panel_WorldBoss_Text_C_ProgressTitle",
    Content = "PanelText_UI_Events_Panel_WorldBoss_Text_C_ProgressTitle_Content|再战原初进度"
  },
  UI_Events_Item_WorldBoss_Text_C_Progress = {
    ID = "UI_Events_Item_WorldBoss_Text_C_Progress",
    Content = "PanelText_UI_Events_Item_WorldBoss_Text_C_Progress_Content|残余分身数量"
  },
  UI_Events_Item_WorldBoss_Text_C_Fall = {
    ID = "UI_Events_Item_WorldBoss_Text_C_Fall",
    Content = "PanelText_UI_Events_Item_WorldBoss_Text_C_Fall_Content|掉落预览"
  },
  UI_Events_Item_WorldBoss_Text_C_Killed = {
    ID = "UI_Events_Item_WorldBoss_Text_C_Killed",
    Content = "PanelText_UI_Events_Item_WorldBoss_Text_C_Killed_Content|已消灭！"
  },
  UI_Events_Item_WorldBoss_Text_C_LockTips = {
    ID = "UI_Events_Item_WorldBoss_Text_C_LockTips",
    Content = "PanelText_UI_Events_Item_WorldBoss_Text_C_LockTips_Content|关卡解锁提示"
  },
  UI_Events_WorldBoss_StageGroup_Text_C_Title = {
    ID = "UI_Events_WorldBoss_StageGroup_Text_C_Title",
    Content = "PanelText_UI_Events_WorldBoss_StageGroup_Text_C_Title_Content|辰星安魂曲"
  },
  UI_Events_WorldBoss_StageGroup_Text_C_Introduction = {
    ID = "UI_Events_WorldBoss_StageGroup_Text_C_Introduction",
    Content = "PanelText_UI_Events_WorldBoss_StageGroup_Text_C_Introduction_Content|面对你们最原初的绝望。面对你们最原初的恐惧。 \n站在看不见的彼此身边，然后战胜祂。"
  },
  UI_Event_Panel_Challenge_Text_C_RemainNum = {
    ID = "UI_Event_Panel_Challenge_Text_C_RemainNum",
    Content = "PanelText_UI_Event_Panel_Challenge_Text_C_RemainNum_Content|残余分身数量"
  },
  UI_Events_Panel_Tulu_Text_C_Shop = {
    ID = "UI_Events_Panel_Tulu_Text_C_Shop",
    Content = "PanelText_UI_Events_Panel_Tulu_Text_C_Shop_Content|觉知海渊"
  },
  UI_Events_Panel_Tulu_Text_C_Resonance = {
    ID = "UI_Events_Panel_Tulu_Text_C_Resonance",
    Content = "PanelText_UI_Events_Panel_Tulu_Text_C_Resonance_Content|共鸣：吞噬山脉"
  },
  UI_Events_Panel_Tulu_Text_C_Diagonal = {
    ID = "UI_Events_Panel_Tulu_Text_C_Diagonal",
    Content = "PanelText_UI_Events_Panel_Tulu_Text_C_Diagonal_Content|/"
  },
  UI_Events_Panel_Tulu_Text_C_Reward = {
    ID = "UI_Events_Panel_Tulu_Text_C_Reward",
    Content = "PanelText_UI_Events_Panel_Tulu_Text_C_Reward_Content|成就奖励"
  },
  UI_Events_Panel_Tulu_Text_C_Record = {
    ID = "UI_Events_Panel_Tulu_Text_C_Record",
    Content = "PanelText_UI_Events_Panel_Tulu_Text_C_Record_Content|加冕之日"
  },
  UI_Events_Panel_Tulu_Text_C_RecordTip = {
    ID = "UI_Events_Panel_Tulu_Text_C_RecordTip",
    Content = "PanelText_UI_Events_Panel_Tulu_Text_C_RecordTip_Content|限时免费解锁"
  },
  UI_Events_Panel_Tulu_Text_C_Challenge = {
    ID = "UI_Events_Panel_Tulu_Text_C_Challenge",
    Content = "PanelText_UI_Events_Panel_Tulu_Text_C_Challenge_Content|深海凝视"
  },
  UI_Events_Panel_Tulu_Text_C_ChallengeTip = {
    ID = "UI_Events_Panel_Tulu_Text_C_ChallengeTip",
    Content = "PanelText_UI_Events_Panel_Tulu_Text_C_ChallengeTip_Content|玩法限时开放"
  },
  UI_Events_Panel_Tulu_Text_C_Topic = {
    ID = "UI_Events_Panel_Tulu_Text_C_Topic",
    Content = "PanelText_UI_Events_Panel_Tulu_Text_C_Topic_Content|神王复苏"
  },
  UI_Events_Panel_Tulu_Text_C_Receive = {
    ID = "UI_Events_Panel_Tulu_Text_C_Receive",
    Content = "PanelText_UI_Events_Panel_Tulu_Text_C_Receive_Content|距离可领取"
  },
  UI_Events_Panel_Tulu_Text_C_Max = {
    ID = "UI_Events_Panel_Tulu_Text_C_Max",
    Content = "PanelText_UI_Events_Panel_Tulu_Text_C_Max_Content|Max"
  },
  UI_Events_Panel_Tulu_Text_C_Symbol = {
    ID = "UI_Events_Panel_Tulu_Text_C_Symbol",
    Content = "PanelText_UI_Events_Panel_Tulu_Text_C_Symbol_Content|)"
  },
  UI_Events_Panel_Tulu_Text_C_Fill_Up = {
    ID = "UI_Events_Panel_Tulu_Text_C_Fill_Up",
    Content = "PanelText_UI_Events_Panel_Tulu_Text_C_Fill_Up_Content|(距离补满："
  },
  UI_Events_Panel_Tulu_Text_C_Can_Unlockable = {
    ID = "UI_Events_Panel_Tulu_Text_C_Can_Unlockable",
    Content = "PanelText_UI_Events_Panel_Tulu_Text_C_Can_Unlockable_Content|可领取"
  },
  UI_Events_Panel_Tulu_Text_C_Not_unlocked = {
    ID = "UI_Events_Panel_Tulu_Text_C_Not_unlocked",
    Content = "PanelText_UI_Events_Panel_Tulu_Text_C_Not_unlocked_Content|未解锁"
  },
  UI_Events_Panel_Tulu_Text_C_Finished = {
    ID = "UI_Events_Panel_Tulu_Text_C_Finished",
    Content = "PanelText_UI_Events_Panel_Tulu_Text_C_Finished_Content|已结束"
  },
  UI_Events_Panel_Tulu_StageGroup_Text_C_Title = {
    ID = "UI_Events_Panel_Tulu_StageGroup_Text_C_Title",
    Content = "PanelText_UI_Events_Panel_Tulu_StageGroup_Text_C_Title_Content|深海凝视"
  },
  UI_Events_Panel_Tulu_StageGroup_Text_C_Introduction = {
    ID = "UI_Events_Panel_Tulu_StageGroup_Text_C_Introduction",
    Content = "PanelText_UI_Events_Panel_Tulu_StageGroup_Text_C_Introduction_Content|祈祷、奉献、牺牲，人类的深刻，于祂而言，只是聒噪的闹剧。\n但这闹剧，偶尔也会留下痕迹，在神王的眸中……或心里。"
  },
  UI_Events_Panel_Tulu_StageGroup_Text_C_Resonance = {
    ID = "UI_Events_Panel_Tulu_StageGroup_Text_C_Resonance",
    Content = "PanelText_UI_Events_Panel_Tulu_StageGroup_Text_C_Resonance_Content|共鸣"
  },
  UI_Events_Item_Tulu_Text_C_Diagonal = {
    ID = "UI_Events_Item_Tulu_Text_C_Diagonal",
    Content = "PanelText_UI_Events_Item_Tulu_Text_C_Diagonal_Content|/"
  },
  UI_Events_Item_Tulu_Text_C_Fall = {
    ID = "UI_Events_Item_Tulu_Text_C_Fall",
    Content = "PanelText_UI_Events_Item_Tulu_Text_C_Fall_Content|掉落预览"
  },
  UI_Events_Item_Tulu_Text_C_LockTips = {
    ID = "UI_Events_Item_Tulu_Text_C_LockTips",
    Content = "PanelText_UI_Events_Item_Tulu_Text_C_LockTips_Content|关卡解锁提示"
  },
  UI_Events_Item_PreOrderGift_Text_C_Lock = {
    ID = "UI_Events_Item_PreOrderGift_Text_C_Lock",
    Content = "PanelText_UI_Events_Item_PreOrderGift_Text_C_Lock_Content|购买后可领取"
  },
  UI_Setting_Popup_ChooseLang_Text_C_Tip = {
    ID = "UI_Setting_Popup_ChooseLang_Text_C_Tip",
    Content = "PanelText_UI_Setting_Popup_ChooseLang_Text_C_Tip_Content|后续可在「设置-语言」中重新选择"
  },
  UI_Setting_Popup_ChooseLang_Text_Title = {
    ID = "UI_Setting_Popup_ChooseLang_Text_Title",
    Content = "PanelText_UI_Setting_Popup_ChooseLang_Text_Title_Content|选择语言"
  },
  UI_Setting_Popup_ChooseLang_Text_Name = {
    ID = "UI_Setting_Popup_ChooseLang_Text_Name",
    Content = "PanelText_UI_Setting_Popup_ChooseLang_Text_Name_Content|确定"
  },
  UI_Social_Item_Data_Overview_Left_Text_C_Gender = {
    ID = "UI_Social_Item_Data_Overview_Left_Text_C_Gender",
    Content = "PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Gender_Content|性别"
  },
  UI_Events_Panel_OriDoll_Text_C_Shop = {
    ID = "UI_Events_Panel_OriDoll_Text_C_Shop",
    Content = "PanelText_UI_Events_Panel_OriDoll_Text_C_Shop_Content|师长的教诲"
  },
  UI_Events_Panel_OriDoll_Text_C_Resonance = {
    ID = "UI_Events_Panel_OriDoll_Text_C_Resonance",
    Content = "PanelText_UI_Events_Panel_OriDoll_Text_C_Resonance_Content|共鸣：无"
  },
  UI_Events_Panel_OriDoll_Text_C_Diagonal = {
    ID = "UI_Events_Panel_OriDoll_Text_C_Diagonal",
    Content = "PanelText_UI_Events_Panel_OriDoll_Text_C_Diagonal_Content|/"
  },
  UI_Events_Panel_OriDoll_Text_C_Reward = {
    ID = "UI_Events_Panel_OriDoll_Text_C_Reward",
    Content = "PanelText_UI_Events_Panel_OriDoll_Text_C_Reward_Content|成就奖励"
  },
  UI_Events_Panel_OriDoll_Text_C_Record = {
    ID = "UI_Events_Panel_OriDoll_Text_C_Record",
    Content = "PanelText_UI_Events_Panel_OriDoll_Text_C_Record_Content|意识潜游"
  },
  UI_Events_Panel_OriDoll_Text_C_RecordTip = {
    ID = "UI_Events_Panel_OriDoll_Text_C_RecordTip",
    Content = "PanelText_UI_Events_Panel_OriDoll_Text_C_RecordTip_Content|限时免费解锁"
  },
  UI_Events_Panel_OriDoll_Text_C_Challenge = {
    ID = "UI_Events_Panel_OriDoll_Text_C_Challenge",
    Content = "PanelText_UI_Events_Panel_OriDoll_Text_C_Challenge_Content|虚无之门"
  },
  UI_Events_Panel_OriDoll_Text_C_ChallengeTip = {
    ID = "UI_Events_Panel_OriDoll_Text_C_ChallengeTip",
    Content = "PanelText_UI_Events_Panel_OriDoll_Text_C_ChallengeTip_Content|玩法限时开放"
  },
  UI_Events_Panel_OriDoll_Text_C_Topic = {
    ID = "UI_Events_Panel_OriDoll_Text_C_Topic",
    Content = "PanelText_UI_Events_Panel_OriDoll_Text_C_Topic_Content|半步之隔"
  },
  UI_Events_Panel_OriDoll_Text_C_Receive = {
    ID = "UI_Events_Panel_OriDoll_Text_C_Receive",
    Content = "PanelText_UI_Events_Panel_OriDoll_Text_C_Receive_Content|距离可领取"
  },
  UI_Events_Panel_OriDoll_Text_C_Max = {
    ID = "UI_Events_Panel_OriDoll_Text_C_Max",
    Content = "PanelText_UI_Events_Panel_OriDoll_Text_C_Max_Content|Max"
  },
  UI_Events_Panel_OriDoll_Text_C_Symbol = {
    ID = "UI_Events_Panel_OriDoll_Text_C_Symbol",
    Content = "PanelText_UI_Events_Panel_OriDoll_Text_C_Symbol_Content|)"
  },
  UI_Events_Panel_OriDoll_Text_C_Fill_Up = {
    ID = "UI_Events_Panel_OriDoll_Text_C_Fill_Up",
    Content = "PanelText_UI_Events_Panel_OriDoll_Text_C_Fill_Up_Content|(距离补满："
  },
  UI_Events_Panel_OriDoll_Text_C_Can_Unlockable = {
    ID = "UI_Events_Panel_OriDoll_Text_C_Can_Unlockable",
    Content = "PanelText_UI_Events_Panel_OriDoll_Text_C_Can_Unlockable_Content|可领取"
  },
  UI_Events_Panel_OriDoll_Text_C_Not_unlocked = {
    ID = "UI_Events_Panel_OriDoll_Text_C_Not_unlocked",
    Content = "PanelText_UI_Events_Panel_OriDoll_Text_C_Not_unlocked_Content|未解锁"
  },
  UI_Events_Panel_OriDoll_Text_C_Finished = {
    ID = "UI_Events_Panel_OriDoll_Text_C_Finished",
    Content = "PanelText_UI_Events_Panel_OriDoll_Text_C_Finished_Content|已结束"
  },
  UI_Events_Item_OriDoll_Text_C_Diagonal = {
    ID = "UI_Events_Item_OriDoll_Text_C_Diagonal",
    Content = "PanelText_UI_Events_Item_OriDoll_Text_C_Diagonal_Content|/"
  },
  UI_Events_Item_OriDoll_Text_C_Fall = {
    ID = "UI_Events_Item_OriDoll_Text_C_Fall",
    Content = "PanelText_UI_Events_Item_OriDoll_Text_C_Fall_Content|掉落预览"
  },
  UI_Events_Item_OriDoll_Text_C_LockTips = {
    ID = "UI_Events_Item_OriDoll_Text_C_LockTips",
    Content = "PanelText_UI_Events_Item_OriDoll_Text_C_LockTips_Content|关卡解锁提示"
  },
  UI_Dbgcopy_Panel_RelicPreview_Text_Name = {
    ID = "UI_Dbgcopy_Panel_RelicPreview_Text_Name",
    Content = "PanelText_UI_Dbgcopy_Panel_RelicPreview_Text_Name_Content|返回"
  },
  UI_Dbgcopy_Panel_RelicStrength_Text_C_Title = {
    ID = "UI_Dbgcopy_Panel_RelicStrength_Text_C_Title",
    Content = "PanelText_UI_Dbgcopy_Panel_RelicStrength_Text_C_Title_Content|强化造物"
  },
  UI_Dbgcopy_Popup_LevelChapter_Text_C_Title = {
    ID = "UI_Dbgcopy_Popup_LevelChapter_Text_C_Title",
    Content = "PanelText_UI_Dbgcopy_Popup_LevelChapter_Text_C_Title_Content|关卡篇章效果说明"
  },
  UI_Dbgcopy_Popup_LevelChapter_Text_C_Monster = {
    ID = "UI_Dbgcopy_Popup_LevelChapter_Text_C_Monster",
    Content = "PanelText_UI_Dbgcopy_Popup_LevelChapter_Text_C_Monster_Content|关卡造物"
  },
  UI_Dbgcopy_Popup_LevelChapter_Text_C_Tip = {
    ID = "UI_Dbgcopy_Popup_LevelChapter_Text_C_Tip",
    Content = "PanelText_UI_Dbgcopy_Popup_LevelChapter_Text_C_Tip_Content|请守密人留意，不同的关卡篇章会带来不同的环境特征和不同的初始造物。"
  },
  UI_Collection_Item_Music_Toggle_Text_C_Need = {
    ID = "UI_Collection_Item_Music_Toggle_Text_C_Need",
    Content = "PanelText_UI_Collection_Item_Music_Toggle_Text_C_Need_Content|需要"
  },
  UI_Collection_Item_Music_Toggle_Text_C_UnLock = {
    ID = "UI_Collection_Item_Music_Toggle_Text_C_UnLock",
    Content = "PanelText_UI_Collection_Item_Music_Toggle_Text_C_UnLock_Content|解锁"
  },
  UI_Event_Panel_Challenge_Text_Career = {
    ID = "UI_Event_Panel_Challenge_Text_Career",
    Content = "PanelText_UI_Event_Panel_Challenge_Text_Career_Content|要求界域1"
  },
  UI_Events_Panel_TeamSchool_Text_C_Challenge = {
    ID = "UI_Events_Panel_TeamSchool_Text_C_Challenge",
    Content = "PanelText_UI_Events_Panel_TeamSchool_Text_C_Challenge_Content|群猫乱舞"
  },
  UI_Events_Panel_TeamSchool_Text_C_ChallengeTip = {
    ID = "UI_Events_Panel_TeamSchool_Text_C_ChallengeTip",
    Content = "PanelText_UI_Events_Panel_TeamSchool_Text_C_ChallengeTip_Content|玩法限时开放"
  },
  UI_Events_Panel_TeamSchool_Text_C_Topic = {
    ID = "UI_Events_Panel_TeamSchool_Text_C_Topic",
    Content = "PanelText_UI_Events_Panel_TeamSchool_Text_C_Topic_Content|乌撒猫猫律"
  },
  UI_Events_Panel_TeamSchool_Text_C_Tip = {
    ID = "UI_Events_Panel_TeamSchool_Text_C_Tip",
    Content = "PanelText_UI_Events_Panel_TeamSchool_Text_C_Tip_Content|每天开放不同的校猫关卡，挑战成功可获得丰富奖励！"
  },
  UI_Events_TeamSchool_StageGroup_Text_C_Title = {
    ID = "UI_Events_TeamSchool_StageGroup_Text_C_Title",
    Content = "PanelText_UI_Events_TeamSchool_StageGroup_Text_C_Title_Content|群猫乱舞"
  },
  UI_Events_TeamSchool_StageGroup_Text_C_Introduction = {
    ID = "UI_Events_TeamSchool_StageGroup_Text_C_Introduction",
    Content = "PanelText_UI_Events_TeamSchool_StageGroup_Text_C_Introduction_Content|黑色，黑色的浪潮不停奔涌。\n癫狂的猫猫包围了你，它们从万千维度之中向你奔赴而来。"
  },
  UI_Team_Panel_Main_Text_Career = {
    ID = "UI_Team_Panel_Main_Text_Career",
    Content = "PanelText_UI_Team_Panel_Main_Text_Career_Content|要求界域"
  },
  UI_Events_Panel_OriDoll_StageGroup_Text_C_Title = {
    ID = "UI_Events_Panel_OriDoll_StageGroup_Text_C_Title",
    Content = "PanelText_UI_Events_Panel_OriDoll_StageGroup_Text_C_Title_Content|虚无之门"
  },
  UI_Events_Panel_OriDoll_StageGroup_Text_C_Introduction = {
    ID = "UI_Events_Panel_OriDoll_StageGroup_Text_C_Introduction",
    Content = "PanelText_UI_Events_Panel_OriDoll_StageGroup_Text_C_Introduction_Content|她注视着世界尽头的那扇大门，毫不犹豫地跨出了脚步。\n咔哒，她拧开把手，迫不及待地望向门后。\n然而门后空无一物，她一脚踩空，坠入了虚无。\n她早该知道，礼物来得太过直接， 便总会有些高昂的代价。"
  },
  UI_Events_Panel_OriDoll_StageGroup_Text_C_Resonance = {
    ID = "UI_Events_Panel_OriDoll_StageGroup_Text_C_Resonance",
    Content = "PanelText_UI_Events_Panel_OriDoll_StageGroup_Text_C_Resonance_Content|共鸣"
  },
  UI_Collection_Panel_History_Text_C_Label = {
    ID = "UI_Collection_Panel_History_Text_C_Label",
    Content = "PanelText_UI_Collection_Panel_History_Text_C_Label_Content|编年史"
  },
  UI_Collection_Panel_History_Text_C_Title = {
    ID = "UI_Collection_Panel_History_Text_C_Title",
    Content = "PanelText_UI_Collection_Panel_History_Text_C_Title_Content|秘典书库"
  },
  UI_Collection_Panel_History_Text_C_Mail = {
    ID = "UI_Collection_Panel_History_Text_C_Mail",
    Content = "PanelText_UI_Collection_Panel_History_Text_C_Mail_Content|收集进度"
  },
  UI_Collection_History_Details_Text_C_Lock = {
    ID = "UI_Collection_History_Details_Text_C_Lock",
    Content = "PanelText_UI_Collection_History_Details_Text_C_Lock_Content|暂未获得图像资料"
  },
  UI_Social_Popup_SwitchGender_Text_C_Cost = {
    ID = "UI_Social_Popup_SwitchGender_Text_C_Cost",
    Content = "PanelText_UI_Social_Popup_SwitchGender_Text_C_Cost_Content|消耗"
  },
  UI_Social_Popup_SwitchGender_Text_Title = {
    ID = "UI_Social_Popup_SwitchGender_Text_Title",
    Content = "PanelText_UI_Social_Popup_SwitchGender_Text_Title_Content|切换性别"
  },
  UI_Social_Popup_SwitchGender_Text_Cancel_Name = {
    ID = "UI_Social_Popup_SwitchGender_Text_Cancel_Name",
    Content = "PanelText_UI_Social_Popup_SwitchGender_Text_Cancel_Name_Content|取消"
  },
  UI_Social_Popup_SwitchGender_Text_Confirm_Name = {
    ID = "UI_Social_Popup_SwitchGender_Text_Confirm_Name",
    Content = "PanelText_UI_Social_Popup_SwitchGender_Text_Confirm_Name_Content|确定"
  },
  UI_Bag_Panel_AppearancePreview_Text_C_Name = {
    ID = "UI_Bag_Panel_AppearancePreview_Text_C_Name"
  },
  UI_Bag_Panel_AppearancePreview_Text_C_Head = {
    ID = "UI_Bag_Panel_AppearancePreview_Text_C_Head",
    Content = "PanelText_UI_Bag_Panel_AppearancePreview_Text_C_Head_Content|头像"
  },
  UI_Bag_Panel_AppearancePreview_Text_C_Emoji = {
    ID = "UI_Bag_Panel_AppearancePreview_Text_C_Emoji",
    Content = "PanelText_UI_Bag_Panel_AppearancePreview_Text_C_Emoji_Content|表情"
  },
  UI_Bag_Panel_AppearancePreview_Text_C_Title = {
    ID = "UI_Bag_Panel_AppearancePreview_Text_C_Title",
    Content = "PanelText_UI_Bag_Panel_AppearancePreview_Text_C_Title_Content|外观预览"
  },
  UI_Bag_Panel_OptionalAppearance_Text_C_Name = {
    ID = "UI_Bag_Panel_OptionalAppearance_Text_C_Name"
  },
  UI_Bag_Panel_OptionalAppearance_Text_C_Head = {
    ID = "UI_Bag_Panel_OptionalAppearance_Text_C_Head",
    Content = "PanelText_UI_Bag_Panel_OptionalAppearance_Text_C_Head_Content|头像"
  },
  UI_Bag_Panel_OptionalAppearance_Text_C_Emoji = {
    ID = "UI_Bag_Panel_OptionalAppearance_Text_C_Emoji",
    Content = "PanelText_UI_Bag_Panel_OptionalAppearance_Text_C_Emoji_Content|表情"
  },
  UI_Bag_Panel_OptionalAppearance_Text_C_Title = {
    ID = "UI_Bag_Panel_OptionalAppearance_Text_C_Title",
    Content = "PanelText_UI_Bag_Panel_OptionalAppearance_Text_C_Title_Content|外观预览"
  },
  UI_Bag_Panel_OptionalAppearance_Text_C_NoTask = {
    ID = "UI_Bag_Panel_OptionalAppearance_Text_C_NoTask",
    Content = "PanelText_UI_Bag_Panel_OptionalAppearance_Text_C_NoTask_Content|暂无数据"
  },
  UI_Bag_Panel_OptionalAppearance_Text_C_En = {
    ID = "UI_Bag_Panel_OptionalAppearance_Text_C_En",
    Content = "PanelText_UI_Bag_Panel_OptionalAppearance_Text_C_En_Content|fdshsjfgjgf"
  },
  UI_Bag_Item_Appearance_Text_C_Got = {
    ID = "UI_Bag_Item_Appearance_Text_C_Got",
    Content = "PanelText_UI_Bag_Item_Appearance_Text_C_Got_Content|已获得"
  },
  UI_Collection_Item_Video_Text_C_UnLock = {
    ID = "UI_Collection_Item_Video_Text_C_UnLock",
    Content = "PanelText_UI_Collection_Item_Video_Text_C_UnLock_Content|解锁"
  },
  UI_Events_Item_TeamSchool_Text_C_Finish = {
    ID = "UI_Events_Item_TeamSchool_Text_C_Finish",
    Content = "PanelText_UI_Events_Item_TeamSchool_Text_C_Finish_Content|已结束"
  },
  UI_Events_Item_TeamSchool_Text_C_Career = {
    ID = "UI_Events_Item_TeamSchool_Text_C_Career",
    Content = "PanelText_UI_Events_Item_TeamSchool_Text_C_Career_Content|队伍要求"
  },
  UI_Events_Item_TeamSchool_Text_CareerLimit = {
    ID = "UI_Events_Item_TeamSchool_Text_CareerLimit",
    Content = "PanelText_UI_Events_Item_TeamSchool_Text_CareerLimit_Content|不限"
  },
  UI_Passport_Money_Item_New_Text_C_TempUnlock = {
    ID = "UI_Passport_Money_Item_New_Text_C_TempUnlock",
    Content = "PanelText_UI_Passport_Money_Item_New_Text_C_TempUnlock_Content|立即获得核心课题限定奖励"
  },
  UI_Collection_Panel_Unlock_Text_C_Cost = {
    ID = "UI_Collection_Panel_Unlock_Text_C_Cost",
    Content = "PanelText_UI_Collection_Panel_Unlock_Text_C_Cost_Content|消耗"
  },
  UI_Bag_Panel_AppearancePreview_Text_C_RatePreview = {
    ID = "UI_Bag_Panel_AppearancePreview_Text_C_RatePreview",
    Content = "PanelText_UI_Bag_Panel_AppearancePreview_Text_C_RatePreview_Content|概率预览"
  },
  UI_Bag_Panel_OptionalAppearance_Text_C_BtnName = {
    ID = "UI_Bag_Panel_OptionalAppearance_Text_C_BtnName",
    Content = "PanelText_UI_Bag_Panel_OptionalAppearance_Text_C_BtnName_Content|领取"
  },
  UI_Common_Item_Detail_Text_C_Avatar_Info = {
    ID = "UI_Common_Item_Detail_Text_C_Avatar_Info",
    Content = "PanelText_UI_Common_Item_Detail_Text_C_Avatar_Info_Content|详情预览"
  },
  UI_Common_Item_Detail_Text_C_AavtarName = {
    ID = "UI_Common_Item_Detail_Text_C_AavtarName",
    Content = "PanelText_UI_Common_Item_Detail_Text_C_AavtarName_Content|头像与表情"
  },
  UI_Bag_Item_Detail_Text_C_Avatar_Info = {
    ID = "UI_Bag_Item_Detail_Text_C_Avatar_Info",
    Content = "PanelText_UI_Bag_Item_Detail_Text_C_Avatar_Info_Content|详情预览"
  },
  UI_Bag_Item_Detail_Text_C_AavtarName = {
    ID = "UI_Bag_Item_Detail_Text_C_AavtarName",
    Content = "PanelText_UI_Bag_Item_Detail_Text_C_AavtarName_Content|头像与表情"
  },
  UI_Bag_Item_Detail_Optimized_Text_C_Time = {
    ID = "UI_Bag_Item_Detail_Optimized_Text_C_Time",
    Content = "PanelText_UI_Bag_Item_Detail_Optimized_Text_C_Time_Content|剩余有效时间:"
  },
  UI_Bag_Item_Detail_Optimized_Text_C_Source = {
    ID = "UI_Bag_Item_Detail_Optimized_Text_C_Source",
    Content = "PanelText_UI_Bag_Item_Detail_Optimized_Text_C_Source_Content|来源"
  },
  UI_Bag_Item_Detail_Optimized_Text_C_Avatar_Info = {
    ID = "UI_Bag_Item_Detail_Optimized_Text_C_Avatar_Info",
    Content = "PanelText_UI_Bag_Item_Detail_Optimized_Text_C_Avatar_Info_Content|详情预览"
  },
  UI_Bag_Item_Detail_Optimized_Text_C_AavtarName = {
    ID = "UI_Bag_Item_Detail_Optimized_Text_C_AavtarName",
    Content = "PanelText_UI_Bag_Item_Detail_Optimized_Text_C_AavtarName_Content|头像与表情"
  },
  UI_Battle_Popup_KeyTokenAwaken_Txt_C_AwakenTitle = {
    ID = "UI_Battle_Popup_KeyTokenAwaken_Txt_C_AwakenTitle",
    Content = "PanelText_UI_Battle_Popup_KeyTokenAwaken_Txt_C_AwakenTitle_Content|银钥觉醒"
  },
  UI_Events_Panel_Daffodil_StageGroup_Text_C_Title = {
    ID = "UI_Events_Panel_Daffodil_StageGroup_Text_C_Title",
    Content = "PanelText_UI_Events_Panel_Daffodil_StageGroup_Text_C_Title_Content|魔女小店"
  },
  UI_Events_Panel_Daffodil_StageGroup_Text_C_Introduction = {
    ID = "UI_Events_Panel_Daffodil_StageGroup_Text_C_Introduction",
    Content = "PanelText_UI_Events_Panel_Daffodil_StageGroup_Text_C_Introduction_Content|这座海滨的小镇上，拥有一条繁华的商业街。海上贸易令这里汇集了无数时新的百货，只要付出足够的雷欧坊，你总能收获满意的商品。\n只有街角一间小小的店铺除外，那是一家充满了神奇古董的小店，在烟斗吐出的烟雾中，戴着宽檐帽子的老板娘会向你缓缓露出一个微笑。\n“欢迎来到解忧小店，这里能满足您的一切需要，只要付出足够的报酬……”\n“当然，当然，价格公道，童叟无欺。”"
  },
  UI_Events_Panel_Daffodil_StageGroup_Text_C_Resonance = {
    ID = "UI_Events_Panel_Daffodil_StageGroup_Text_C_Resonance",
    Content = "PanelText_UI_Events_Panel_Daffodil_StageGroup_Text_C_Resonance_Content|共鸣"
  },
  UI_Events_Item_Daffodil_Text_C_Diagonal = {
    ID = "UI_Events_Item_Daffodil_Text_C_Diagonal",
    Content = "PanelText_UI_Events_Item_Daffodil_Text_C_Diagonal_Content|/"
  },
  UI_Events_Item_Daffodil_Text_C_Fall = {
    ID = "UI_Events_Item_Daffodil_Text_C_Fall",
    Content = "PanelText_UI_Events_Item_Daffodil_Text_C_Fall_Content|掉落预览"
  },
  UI_Events_Item_Daffodil_Text_C_LockTips = {
    ID = "UI_Events_Item_Daffodil_Text_C_LockTips",
    Content = "PanelText_UI_Events_Item_Daffodil_Text_C_LockTips_Content|关卡解锁提示"
  },
  UI_Events_Panel_Daffodil_Text_C_Shop = {
    ID = "UI_Events_Panel_Daffodil_Text_C_Shop",
    Content = "PanelText_UI_Events_Panel_Daffodil_Text_C_Shop_Content|魔女的宝库"
  },
  UI_Events_Panel_Daffodil_Text_C_Resonance = {
    ID = "UI_Events_Panel_Daffodil_Text_C_Resonance",
    Content = "PanelText_UI_Events_Panel_Daffodil_Text_C_Resonance_Content|共鸣：吞噬山脉"
  },
  UI_Events_Panel_Daffodil_Text_C_Diagonal = {
    ID = "UI_Events_Panel_Daffodil_Text_C_Diagonal",
    Content = "PanelText_UI_Events_Panel_Daffodil_Text_C_Diagonal_Content|/"
  },
  UI_Events_Panel_Daffodil_Text_C_Reward = {
    ID = "UI_Events_Panel_Daffodil_Text_C_Reward",
    Content = "PanelText_UI_Events_Panel_Daffodil_Text_C_Reward_Content|成就奖励"
  },
  UI_Events_Panel_Daffodil_Text_C_Record = {
    ID = "UI_Events_Panel_Daffodil_Text_C_Record",
    Content = "PanelText_UI_Events_Panel_Daffodil_Text_C_Record_Content|特遣纪录"
  },
  UI_Events_Panel_Daffodil_Text_C_RecordTip = {
    ID = "UI_Events_Panel_Daffodil_Text_C_RecordTip",
    Content = "PanelText_UI_Events_Panel_Daffodil_Text_C_RecordTip_Content|限时免费解锁"
  },
  UI_Events_Panel_Daffodil_Text_C_Challenge = {
    ID = "UI_Events_Panel_Daffodil_Text_C_Challenge",
    Content = "PanelText_UI_Events_Panel_Daffodil_Text_C_Challenge_Content|魔女小店"
  },
  UI_Events_Panel_Daffodil_Text_C_ChallengeTip = {
    ID = "UI_Events_Panel_Daffodil_Text_C_ChallengeTip",
    Content = "PanelText_UI_Events_Panel_Daffodil_Text_C_ChallengeTip_Content|玩法限时开放"
  },
  UI_Events_Panel_Daffodil_Text_C_Topic = {
    ID = "UI_Events_Panel_Daffodil_Text_C_Topic",
    Content = "PanelText_UI_Events_Panel_Daffodil_Text_C_Topic_Content|雨镇幽影"
  },
  UI_Events_Panel_Daffodil_Text_C_Receive = {
    ID = "UI_Events_Panel_Daffodil_Text_C_Receive",
    Content = "PanelText_UI_Events_Panel_Daffodil_Text_C_Receive_Content|距离可领取"
  },
  UI_Events_Panel_Daffodil_Text_C_Max = {
    ID = "UI_Events_Panel_Daffodil_Text_C_Max",
    Content = "PanelText_UI_Events_Panel_Daffodil_Text_C_Max_Content|Max"
  },
  UI_Events_Panel_Daffodil_Text_C_Symbol = {
    ID = "UI_Events_Panel_Daffodil_Text_C_Symbol",
    Content = "PanelText_UI_Events_Panel_Daffodil_Text_C_Symbol_Content|)"
  },
  UI_Events_Panel_Daffodil_Text_C_Fill_Up = {
    ID = "UI_Events_Panel_Daffodil_Text_C_Fill_Up",
    Content = "PanelText_UI_Events_Panel_Daffodil_Text_C_Fill_Up_Content|(距离补满："
  },
  UI_Events_Panel_Daffodil_Text_C_Can_Unlockable = {
    ID = "UI_Events_Panel_Daffodil_Text_C_Can_Unlockable",
    Content = "PanelText_UI_Events_Panel_Daffodil_Text_C_Can_Unlockable_Content|可领取"
  },
  UI_Events_Panel_Daffodil_Text_C_Not_unlocked = {
    ID = "UI_Events_Panel_Daffodil_Text_C_Not_unlocked",
    Content = "PanelText_UI_Events_Panel_Daffodil_Text_C_Not_unlocked_Content|未解锁"
  },
  UI_Events_Panel_Daffodil_Text_C_Finished = {
    ID = "UI_Events_Panel_Daffodil_Text_C_Finished",
    Content = "PanelText_UI_Events_Panel_Daffodil_Text_C_Finished_Content|已结束"
  },
  UI_Events_Panel_PVPReRound_Text_C_Shop = {
    ID = "UI_Events_Panel_PVPReRound_Text_C_Shop",
    Content = "PanelText_UI_Events_Panel_PVPReRound_Text_C_Shop_Content|商店名字"
  },
  UI_Events_Panel_PVPReRound_Text_C_Resonance = {
    ID = "UI_Events_Panel_PVPReRound_Text_C_Resonance",
    Content = "PanelText_UI_Events_Panel_PVPReRound_Text_C_Resonance_Content|共鸣：吞噬山脉"
  },
  UI_Events_Panel_PVPReRound_Text_C_Diagonal = {
    ID = "UI_Events_Panel_PVPReRound_Text_C_Diagonal",
    Content = "PanelText_UI_Events_Panel_PVPReRound_Text_C_Diagonal_Content|/"
  },
  UI_Events_Panel_PVPReRound_Text_C_Reward = {
    ID = "UI_Events_Panel_PVPReRound_Text_C_Reward",
    Content = "PanelText_UI_Events_Panel_PVPReRound_Text_C_Reward_Content|成就奖励"
  },
  UI_Events_Panel_PVPReRound_Text_C_Record = {
    ID = "UI_Events_Panel_PVPReRound_Text_C_Record",
    Content = "PanelText_UI_Events_Panel_PVPReRound_Text_C_Record_Content|逆转回合"
  },
  UI_Events_Panel_PVPReRound_Text_C_RecordTip = {
    ID = "UI_Events_Panel_PVPReRound_Text_C_RecordTip",
    Content = "PanelText_UI_Events_Panel_PVPReRound_Text_C_RecordTip_Content|限时免费解锁"
  },
  UI_Events_Panel_PVPReRound_Text_C_Challenge = {
    ID = "UI_Events_Panel_PVPReRound_Text_C_Challenge",
    Content = "PanelText_UI_Events_Panel_PVPReRound_Text_C_Challenge_Content|相位对弈"
  },
  UI_Events_Panel_PVPReRound_Text_C_ChallengeTip = {
    ID = "UI_Events_Panel_PVPReRound_Text_C_ChallengeTip",
    Content = "PanelText_UI_Events_Panel_PVPReRound_Text_C_ChallengeTip_Content|限时联动"
  },
  UI_Events_Panel_PVPReRound_Text_C_Topic = {
    ID = "UI_Events_Panel_PVPReRound_Text_C_Topic",
    Content = "PanelText_UI_Events_Panel_PVPReRound_Text_C_Topic_Content|雨镇幽影"
  },
  UI_Events_Panel_Reward_Text_C_OneKey = {
    ID = "UI_Events_Panel_Reward_Text_C_OneKey",
    Content = "PanelText_UI_Events_Panel_Reward_Text_C_OneKey_Content|一键领取"
  },
  UI_Events_Panel_PVPReRound_Text_C_Receive = {
    ID = "UI_Events_Panel_PVPReRound_Text_C_Receive",
    Content = "PanelText_UI_Events_Panel_PVPReRound_Text_C_Receive_Content|距离可领取"
  },
  UI_Events_Panel_PVPReRound_Text_C_Max = {
    ID = "UI_Events_Panel_PVPReRound_Text_C_Max",
    Content = "PanelText_UI_Events_Panel_PVPReRound_Text_C_Max_Content|Max"
  },
  UI_Events_Panel_PVPReRound_Text_C_Symbol = {
    ID = "UI_Events_Panel_PVPReRound_Text_C_Symbol",
    Content = "PanelText_UI_Events_Panel_PVPReRound_Text_C_Symbol_Content|)"
  },
  UI_Events_Panel_PVPReRound_Text_C_Fill_Up = {
    ID = "UI_Events_Panel_PVPReRound_Text_C_Fill_Up",
    Content = "PanelText_UI_Events_Panel_PVPReRound_Text_C_Fill_Up_Content|(距离补满："
  },
  UI_Events_Panel_PVPReRound_Text_C_Can_Unlockable = {
    ID = "UI_Events_Panel_PVPReRound_Text_C_Can_Unlockable",
    Content = "PanelText_UI_Events_Panel_PVPReRound_Text_C_Can_Unlockable_Content|可领取"
  },
  UI_Events_Panel_PVPReRound_Text_C_Not_unlocked = {
    ID = "UI_Events_Panel_PVPReRound_Text_C_Not_unlocked",
    Content = "PanelText_UI_Events_Panel_PVPReRound_Text_C_Not_unlocked_Content|未解锁"
  },
  UI_Events_Panel_PVPReRound_Text_C_Finished = {
    ID = "UI_Events_Panel_PVPReRound_Text_C_Finished",
    Content = "PanelText_UI_Events_Panel_PVPReRound_Text_C_Finished_Content|已结束"
  },
  UI_Battle_Popup_KeyTokenAwaken_Text_C_KeeperSkill = {
    ID = "UI_Battle_Popup_KeyTokenAwaken_Text_C_KeeperSkill",
    Content = "PanelText_UI_Battle_Popup_KeyTokenAwaken_Text_C_KeeperSkill_Content|释放"
  },
  UI_Battle_Popup_KeyTokenAwaken_Text_C_KeyTokenAwaken = {
    ID = "UI_Battle_Popup_KeyTokenAwaken_Text_C_KeyTokenAwaken",
    Content = "PanelText_UI_Battle_Popup_KeyTokenAwaken_Text_C_KeyTokenAwaken_Content|释放"
  },
  UI_Battle_Popup_KeyTokenAwaken_Text_Title = {
    ID = "UI_Battle_Popup_KeyTokenAwaken_Text_Title",
    Content = "PanelText_UI_Battle_Popup_KeyTokenAwaken_Text_Title_Content|请选择指令"
  },
  UI_Pvp_Panel_Collection_Main_Text_C_Train_Name = {
    ID = "UI_Pvp_Panel_Collection_Main_Text_C_Train_Name",
    Content = "PanelText_UI_Pvp_Panel_Collection_Main_Text_C_Train_Name_Content|唤醒体试用"
  },
  UI_Pvp_Panel_Train_Text_C_Reset = {
    ID = "UI_Pvp_Panel_Train_Text_C_Reset",
    Content = "PanelText_UI_Pvp_Panel_Train_Text_C_Reset_Content|重置"
  },
  UI_Pvp_Panel_Train_Text_C_Position = {
    ID = "UI_Pvp_Panel_Train_Text_C_Position",
    Content = "PanelText_UI_Pvp_Panel_Train_Text_C_Position_Content|移位"
  },
  UI_Pvp_Panel_Train_Text_C_Weapons = {
    ID = "UI_Pvp_Panel_Train_Text_C_Weapons",
    Content = "PanelText_UI_Pvp_Panel_Train_Text_C_Weapons_Content|添加命轮"
  },
  UI_Pvp_Panel_Train_Text_C_KeeperSkills = {
    ID = "UI_Pvp_Panel_Train_Text_C_KeeperSkills",
    Content = "PanelText_UI_Pvp_Panel_Train_Text_C_KeeperSkills_Content|添加钥令"
  },
  UI_Events_Panel_Clementine_Text_C_Shop = {
    ID = "UI_Events_Panel_Clementine_Text_C_Shop",
    Content = "PanelText_UI_Events_Panel_Clementine_Text_C_Shop_Content|神经诊疗室"
  },
  UI_Events_Panel_Clementine_Text_C_Resonance = {
    ID = "UI_Events_Panel_Clementine_Text_C_Resonance",
    Content = "PanelText_UI_Events_Panel_Clementine_Text_C_Resonance_Content|共鸣：无"
  },
  UI_Events_Panel_Clementine_Text_C_Diagonal = {
    ID = "UI_Events_Panel_Clementine_Text_C_Diagonal",
    Content = "PanelText_UI_Events_Panel_Clementine_Text_C_Diagonal_Content|/"
  },
  UI_Events_Panel_Clementine_Text_C_Reward = {
    ID = "UI_Events_Panel_Clementine_Text_C_Reward",
    Content = "PanelText_UI_Events_Panel_Clementine_Text_C_Reward_Content|成就奖励"
  },
  UI_Events_Panel_Clementine_Text_C_Record = {
    ID = "UI_Events_Panel_Clementine_Text_C_Record",
    Content = "PanelText_UI_Events_Panel_Clementine_Text_C_Record_Content|意识潜游"
  },
  UI_Events_Panel_Clementine_Text_C_RecordTip = {
    ID = "UI_Events_Panel_Clementine_Text_C_RecordTip",
    Content = "PanelText_UI_Events_Panel_Clementine_Text_C_RecordTip_Content|限时免费解锁"
  },
  UI_Events_Panel_Clementine_Text_C_Challenge = {
    ID = "UI_Events_Panel_Clementine_Text_C_Challenge",
    Content = "PanelText_UI_Events_Panel_Clementine_Text_C_Challenge_Content|恐惧愈疗"
  },
  UI_Events_Panel_Clementine_Text_C_ChallengeTip = {
    ID = "UI_Events_Panel_Clementine_Text_C_ChallengeTip",
    Content = "PanelText_UI_Events_Panel_Clementine_Text_C_ChallengeTip_Content|玩法限时开放"
  },
  UI_Events_Panel_Clementine_Text_C_Topic = {
    ID = "UI_Events_Panel_Clementine_Text_C_Topic",
    Content = "PanelText_UI_Events_Panel_Clementine_Text_C_Topic_Content|埋于记忆之下"
  },
  UI_Events_Panel_Clementine_Text_C_Finished = {
    ID = "UI_Events_Panel_Clementine_Text_C_Finished",
    Content = "PanelText_UI_Events_Panel_Clementine_Text_C_Finished_Content|已结束"
  },
  UI_Events_Item_Clementine_Text_C_Diagonal = {
    ID = "UI_Events_Item_Clementine_Text_C_Diagonal",
    Content = "PanelText_UI_Events_Item_Clementine_Text_C_Diagonal_Content|/"
  },
  UI_Events_Item_Clementine_Text_C_Fall = {
    ID = "UI_Events_Item_Clementine_Text_C_Fall",
    Content = "PanelText_UI_Events_Item_Clementine_Text_C_Fall_Content|掉落预览"
  },
  UI_Events_Item_Clementine_Text_C_LockTips = {
    ID = "UI_Events_Item_Clementine_Text_C_LockTips",
    Content = "PanelText_UI_Events_Item_Clementine_Text_C_LockTips_Content|关卡解锁提示"
  },
  UI_Events_Panel_Clementine_StageGroup_Text_C_Title = {
    ID = "UI_Events_Panel_Clementine_StageGroup_Text_C_Title",
    Content = "PanelText_UI_Events_Panel_Clementine_StageGroup_Text_C_Title_Content|恐惧愈疗"
  },
  UI_Events_Panel_Clementine_StageGroup_Text_C_Introduction = {
    ID = "UI_Events_Panel_Clementine_StageGroup_Text_C_Introduction",
    Content = "PanelText_UI_Events_Panel_Clementine_StageGroup_Text_C_Introduction_Content|自那时起，她便不再落下一滴眼泪。\n独自一人游弋徘徊，徘徊在遍地异类的世界。\n一场盛大的计划即将开始，作为她谢幕的最后告别。\n她是最成功的心理医生，这是她最成功的一次治疗。"
  },
  UI_Awaker_Popup_Backtrace_Tip_Text_C_Toggle_3 = {
    ID = "UI_Awaker_Popup_Backtrace_Tip_Text_C_Toggle_3",
    Content = "PanelText_UI_Awaker_Popup_Backtrace_Tip_Text_C_Toggle_3_Content|命轮"
  },
  UI_Awaker_Popup_Backtrace_Tip_Text_C_En = {
    ID = "UI_Awaker_Popup_Backtrace_Tip_Text_C_En",
    Content = "PanelText_UI_Awaker_Popup_Backtrace_Tip_Text_C_En_Content|fdshsjfgjgf"
  },
  UI_Events_Panel_Clementine_Text_C_Receive = {
    ID = "UI_Events_Panel_Clementine_Text_C_Receive",
    Content = "PanelText_UI_Events_Panel_Clementine_Text_C_Receive_Content|距离可领取"
  },
  UI_Events_Panel_Clementine_Text_C_Max = {
    ID = "UI_Events_Panel_Clementine_Text_C_Max",
    Content = "PanelText_UI_Events_Panel_Clementine_Text_C_Max_Content|Max"
  },
  UI_Events_Panel_Clementine_Text_C_Symbol = {
    ID = "UI_Events_Panel_Clementine_Text_C_Symbol",
    Content = "PanelText_UI_Events_Panel_Clementine_Text_C_Symbol_Content|)"
  },
  UI_Events_Panel_Clementine_Text_C_Fill_Up = {
    ID = "UI_Events_Panel_Clementine_Text_C_Fill_Up",
    Content = "PanelText_UI_Events_Panel_Clementine_Text_C_Fill_Up_Content|(距离补满："
  },
  UI_Events_Panel_Clementine_Text_C_Can_Unlockable = {
    ID = "UI_Events_Panel_Clementine_Text_C_Can_Unlockable",
    Content = "PanelText_UI_Events_Panel_Clementine_Text_C_Can_Unlockable_Content|可领取"
  },
  UI_Events_Panel_Clementine_Text_C_Not_unlocked = {
    ID = "UI_Events_Panel_Clementine_Text_C_Not_unlocked",
    Content = "PanelText_UI_Events_Panel_Clementine_Text_C_Not_unlocked_Content|未解锁"
  },
  UI_Events_Panel_Karen_Text_C_Reward = {
    ID = "UI_Events_Panel_Karen_Text_C_Reward",
    Content = "PanelText_UI_Events_Panel_Karen_Text_C_Reward_Content|除尘津贴"
  },
  UI_Events_Panel_Karen_Text_C_Sign = {
    ID = "UI_Events_Panel_Karen_Text_C_Sign",
    Content = "PanelText_UI_Events_Panel_Karen_Text_C_Sign_Content|珈伦的谢礼"
  },
  UI_Events_Panel_Karen_Text_C_Diagonal = {
    ID = "UI_Events_Panel_Karen_Text_C_Diagonal",
    Content = "PanelText_UI_Events_Panel_Karen_Text_C_Diagonal_Content|/"
  },
  UI_Events_Panel_Karen_Text_C_Task = {
    ID = "UI_Events_Panel_Karen_Text_C_Task",
    Content = "PanelText_UI_Events_Panel_Karen_Text_C_Task_Content|扫除进度"
  },
  UI_Events_Panel_Karen_Text_C_Topic = {
    ID = "UI_Events_Panel_Karen_Text_C_Topic",
    Content = "PanelText_UI_Events_Panel_Karen_Text_C_Topic_Content|扫除奇旅"
  },
  UI_Event_Activity_SevenDaySign_Text_C_Desc = {
    ID = "UI_Event_Activity_SevenDaySign_Text_C_Desc",
    Content = "PanelText_UI_Event_Activity_SevenDaySign_Text_C_Desc_Content|主人今天也来帮珈伦一起打扫么？太好了，这是珈伦的一点小心意，还请主人务必收下！"
  },
  UI_Event_Activity_SevenDaySign_Text_Title = {
    ID = "UI_Event_Activity_SevenDaySign_Text_Title",
    Content = "PanelText_UI_Event_Activity_SevenDaySign_Text_Title_Content|珈伦的谢礼"
  },
  UI_Event_Activity_SevenDaySign_Text_Receive_1 = {
    ID = "UI_Event_Activity_SevenDaySign_Text_Receive_1",
    Content = "PanelText_UI_Event_Activity_SevenDaySign_Text_Receive_1_Content|已领取"
  },
  UI_Event_Activity_SevenDaySign_Text_N_1 = {
    ID = "UI_Event_Activity_SevenDaySign_Text_N_1",
    Content = "PanelText_UI_Event_Activity_SevenDaySign_Text_N_1_Content|1"
  },
  UI_Event_Activity_SevenDaySign_Text_Receive_2 = {
    ID = "UI_Event_Activity_SevenDaySign_Text_Receive_2",
    Content = "PanelText_UI_Event_Activity_SevenDaySign_Text_Receive_2_Content|已领取"
  },
  UI_Event_Activity_SevenDaySign_Text_N_2 = {
    ID = "UI_Event_Activity_SevenDaySign_Text_N_2",
    Content = "PanelText_UI_Event_Activity_SevenDaySign_Text_N_2_Content|2"
  },
  UI_Event_Activity_SevenDaySign_Text_Receive_3 = {
    ID = "UI_Event_Activity_SevenDaySign_Text_Receive_3",
    Content = "PanelText_UI_Event_Activity_SevenDaySign_Text_Receive_3_Content|已领取"
  },
  UI_Event_Activity_SevenDaySign_Text_N_3 = {
    ID = "UI_Event_Activity_SevenDaySign_Text_N_3",
    Content = "PanelText_UI_Event_Activity_SevenDaySign_Text_N_3_Content|3"
  },
  UI_Event_Activity_SevenDaySign_Text_Receive_4 = {
    ID = "UI_Event_Activity_SevenDaySign_Text_Receive_4",
    Content = "PanelText_UI_Event_Activity_SevenDaySign_Text_Receive_4_Content|已领取"
  },
  UI_Event_Activity_SevenDaySign_Text_N_4 = {
    ID = "UI_Event_Activity_SevenDaySign_Text_N_4",
    Content = "PanelText_UI_Event_Activity_SevenDaySign_Text_N_4_Content|4"
  },
  UI_Event_Activity_SevenDaySign_Text_Receive_5 = {
    ID = "UI_Event_Activity_SevenDaySign_Text_Receive_5",
    Content = "PanelText_UI_Event_Activity_SevenDaySign_Text_Receive_5_Content|已领取"
  },
  UI_Event_Activity_SevenDaySign_Text_N_5 = {
    ID = "UI_Event_Activity_SevenDaySign_Text_N_5",
    Content = "PanelText_UI_Event_Activity_SevenDaySign_Text_N_5_Content|5"
  },
  UI_Event_Activity_SevenDaySign_Text_Receive_6 = {
    ID = "UI_Event_Activity_SevenDaySign_Text_Receive_6",
    Content = "PanelText_UI_Event_Activity_SevenDaySign_Text_Receive_6_Content|已领取"
  },
  UI_Event_Activity_SevenDaySign_Text_N_6 = {
    ID = "UI_Event_Activity_SevenDaySign_Text_N_6",
    Content = "PanelText_UI_Event_Activity_SevenDaySign_Text_N_6_Content|6"
  },
  UI_Event_Activity_SevenDaySign_Text_Receive_7 = {
    ID = "UI_Event_Activity_SevenDaySign_Text_Receive_7",
    Content = "PanelText_UI_Event_Activity_SevenDaySign_Text_Receive_7_Content|已领取"
  },
  UI_Event_Task_Item_Text_C_Receive = {
    ID = "UI_Event_Task_Item_Text_C_Receive",
    Content = "PanelText_UI_Event_Task_Item_Text_C_Receive_Content|领取"
  },
  UI_Event_Task_Item_Text_C_Not = {
    ID = "UI_Event_Task_Item_Text_C_Not",
    Content = "PanelText_UI_Event_Task_Item_Text_C_Not_Content|未达成"
  },
  UI_Events_Panel_Task_Text_C_OneKeyName = {
    ID = "UI_Events_Panel_Task_Text_C_OneKeyName",
    Content = "PanelText_UI_Events_Panel_Task_Text_C_OneKeyName_Content|一键领取"
  },
  UI_Events_Panel_Reward_Text_Title = {
    ID = "UI_Events_Panel_Reward_Text_Title",
    Content = "PanelText_UI_Events_Panel_Reward_Text_Title_Content|任务奖励"
  },
  UI_Chapter_Item_Special_01_Text_C_Chaoter = {
    ID = "UI_Chapter_Item_Special_01_Text_C_Chaoter",
    Content = "PanelText_UI_Chapter_Item_Special_01_Text_C_Chaoter_Content|Dream View"
  },
  UI_Chapter_Item_Special_01_Text_C_Free_Unlock = {
    ID = "UI_Chapter_Item_Special_01_Text_C_Free_Unlock",
    Content = "PanelText_UI_Chapter_Item_Special_01_Text_C_Free_Unlock_Content|限时免费解锁"
  },
  UI_Chapter_Special_Spur_View_Text_C_Remember = {
    ID = "UI_Chapter_Special_Spur_View_Text_C_Remember",
    Content = "PanelText_UI_Chapter_Special_Spur_View_Text_C_Remember_Content|溯梦"
  },
  UI_Chapter_Special_Spur_View_Text_C_Simple = {
    ID = "UI_Chapter_Special_Spur_View_Text_C_Simple",
    Content = "PanelText_UI_Chapter_Special_Spur_View_Text_C_Simple_Content|普通"
  },
  UI_Chapter_Special_Spur_View_Text_C_Difficulty = {
    ID = "UI_Chapter_Special_Spur_View_Text_C_Difficulty",
    Content = "PanelText_UI_Chapter_Special_Spur_View_Text_C_Difficulty_Content|困难"
  },
  UI_Chapter_Special_Spur_View_Text_C_Nightmare = {
    ID = "UI_Chapter_Special_Spur_View_Text_C_Nightmare",
    Content = "PanelText_UI_Chapter_Special_Spur_View_Text_C_Nightmare_Content|癫狂"
  },
  UI_Chapter_Special_Spur_View_Text_C_Progress = {
    ID = "UI_Chapter_Special_Spur_View_Text_C_Progress",
    Content = "PanelText_UI_Chapter_Special_Spur_View_Text_C_Progress_Content|收集进度"
  },
  UI_Chapter_Special_Spur_View_Text_C_Tab_Special = {
    ID = "UI_Chapter_Special_Spur_View_Text_C_Tab_Special",
    Content = "PanelText_UI_Chapter_Special_Spur_View_Text_C_Tab_Special_Content|限时活动"
  },
  UI_Chapter_Special_Spur_View_Text_C_Resonance = {
    ID = "UI_Chapter_Special_Spur_View_Text_C_Resonance",
    Content = "PanelText_UI_Chapter_Special_Spur_View_Text_C_Resonance_Content|共鸣"
  },
  UI_Summon_Item_Probability_Text_Limit = {
    ID = "UI_Summon_Item_Probability_Text_Limit",
    Content = "PanelText_UI_Summon_Item_Probability_Text_Limit_Content|限定"
  },
  UI_Event_Item_SignDay_Text_C_Nor = {
    ID = "UI_Event_Item_SignDay_Text_C_Nor",
    Content = "PanelText_UI_Event_Item_SignDay_Text_C_Nor_Content|待领取"
  },
  UI_Event_Item_SignDay_Text_C_CanReceive = {
    ID = "UI_Event_Item_SignDay_Text_C_CanReceive",
    Content = "PanelText_UI_Event_Item_SignDay_Text_C_CanReceive_Content|可领取"
  },
  UI_Event_Item_SignDay_Text_C_Got = {
    ID = "UI_Event_Item_SignDay_Text_C_Got",
    Content = "PanelText_UI_Event_Item_SignDay_Text_C_Got_Content|已领取"
  },
  UI_Summon_Panel_Main_Text_C_Name = {
    ID = "UI_Summon_Panel_Main_Text_C_Name",
    Content = "PanelText_UI_Summon_Panel_Main_Text_C_Name_Content|Permanent ."
  },
  UI_Summon_Panel_Main_Text_C_Choose = {
    ID = "UI_Summon_Panel_Main_Text_C_Choose",
    Content = "PanelText_UI_Summon_Panel_Main_Text_C_Choose_Content|开始选择"
  },
  UI_Suummoon_Popup_AwakerWeapon_Text_C_InfoTitle = {
    ID = "UI_Suummoon_Popup_AwakerWeapon_Text_C_InfoTitle",
    Content = "PanelText_UI_Suummoon_Popup_AwakerWeapon_Text_C_InfoTitle_Content|玩法说明"
  },
  UI_Suummoon_Popup_AwakerWeapon_Text_C_Auto = {
    ID = "UI_Suummoon_Popup_AwakerWeapon_Text_C_Auto",
    Content = "PanelText_UI_Suummoon_Popup_AwakerWeapon_Text_C_Auto_Content|自动获取推荐命轮"
  },
  UI_Suummoon_Popup_AwakerWeapon_Text_C_Choose = {
    ID = "UI_Suummoon_Popup_AwakerWeapon_Text_C_Choose",
    Content = "PanelText_UI_Suummoon_Popup_AwakerWeapon_Text_C_Choose_Content|选择唤醒体"
  },
  UI_Suummoon_Popup_AwakerWeapon_Text_C_ChooseTitle = {
    ID = "UI_Suummoon_Popup_AwakerWeapon_Text_C_ChooseTitle",
    Content = "PanelText_UI_Suummoon_Popup_AwakerWeapon_Text_C_ChooseTitle_Content|选择唤醒体"
  },
  UI_Suummoon_Popup_AwakerWeapon_Text_Title = {
    ID = "UI_Suummoon_Popup_AwakerWeapon_Text_Title",
    Content = "PanelText_UI_Suummoon_Popup_AwakerWeapon_Text_Title_Content|选择唤醒体"
  },
  UI_Suummoon_Popup_AwakerWeapon_Text_C_Confirm = {
    ID = "UI_Suummoon_Popup_AwakerWeapon_Text_C_Confirm",
    Content = "PanelText_UI_Suummoon_Popup_AwakerWeapon_Text_C_Confirm_Content|确认选择"
  },
  UI_Summon_Panel_LuckyBag_Text_C_LuckyBag_1 = {
    ID = "UI_Summon_Panel_LuckyBag_Text_C_LuckyBag_1",
    Content = "PanelText_UI_Summon_Panel_LuckyBag_Text_C_LuckyBag_1_Content|必得其二"
  },
  UI_Summon_Panel_LuckyBag_Text_C_LuckyBag_2 = {
    ID = "UI_Summon_Panel_LuckyBag_Text_C_LuckyBag_2",
    Content = "PanelText_UI_Summon_Panel_LuckyBag_Text_C_LuckyBag_2_Content|必得其三"
  },
  UI_Events_OceanBoss_StageGroup_Text_C_Title = {
    ID = "UI_Events_OceanBoss_StageGroup_Text_C_Title",
    Content = "PanelText_UI_Events_OceanBoss_StageGroup_Text_C_Title_Content|异动海潮"
  },
  UI_Events_OceanBoss_StageGroup_Text_C_Introduction = {
    ID = "UI_Events_OceanBoss_StageGroup_Text_C_Introduction",
    Content = "PanelText_UI_Events_OceanBoss_StageGroup_Text_C_Introduction_Content|抛弃身躯，抛弃理智，在这纯粹的意志世界，感受祂的存在。\n祂是你的唯一。祂亦是你的全部。"
  },
  UI_Events_Panel_OceanBoss_Text_C_Topic = {
    ID = "UI_Events_Panel_OceanBoss_Text_C_Topic",
    Content = "PanelText_UI_Events_Panel_OceanBoss_Text_C_Topic_Content|神国上浮"
  },
  UI_Events_Panel_OceanBoss_Text_C_ProgressTitle = {
    ID = "UI_Events_Panel_OceanBoss_Text_C_ProgressTitle",
    Content = "PanelText_UI_Events_Panel_OceanBoss_Text_C_ProgressTitle_Content|异动海潮击杀进度"
  },
  UI_Events_Panel_OceanBoss_Text_C_Challenge = {
    ID = "UI_Events_Panel_OceanBoss_Text_C_Challenge",
    Content = "PanelText_UI_Events_Panel_OceanBoss_Text_C_Challenge_Content|异动海潮"
  },
  UI_Events_Item_OceanBoss_Text_C_Progress = {
    ID = "UI_Events_Item_OceanBoss_Text_C_Progress",
    Content = "PanelText_UI_Events_Item_OceanBoss_Text_C_Progress_Content|可挑战"
  },
  UI_Events_Item_OceanBoss_Text_C_Fall = {
    ID = "UI_Events_Item_OceanBoss_Text_C_Fall",
    Content = "PanelText_UI_Events_Item_OceanBoss_Text_C_Fall_Content|掉落预览"
  },
  UI_Events_Item_OceanBoss_Text_C_Killed = {
    ID = "UI_Events_Item_OceanBoss_Text_C_Killed",
    Content = "PanelText_UI_Events_Item_OceanBoss_Text_C_Killed_Content|已击杀！"
  },
  UI_Events_Item_OceanBoss_Text_C_LockTips = {
    ID = "UI_Events_Item_OceanBoss_Text_C_LockTips",
    Content = "PanelText_UI_Events_Item_OceanBoss_Text_C_LockTips_Content|关卡解锁提示"
  },
  UI_Events_Panel_StElmosFire_Text_C_Shop = {
    ID = "UI_Events_Panel_StElmosFire_Text_C_Shop",
    Content = "PanelText_UI_Events_Panel_StElmosFire_Text_C_Shop_Content|船员的秘宝"
  },
  UI_Events_Panel_StElmosFire_Text_C_Resonance = {
    ID = "UI_Events_Panel_StElmosFire_Text_C_Resonance",
    Content = "PanelText_UI_Events_Panel_StElmosFire_Text_C_Resonance_Content|共鸣：吞噬山脉"
  },
  UI_Events_Panel_StElmosFire_Text_C_Diagonal = {
    ID = "UI_Events_Panel_StElmosFire_Text_C_Diagonal",
    Content = "PanelText_UI_Events_Panel_StElmosFire_Text_C_Diagonal_Content|/"
  },
  UI_Events_Panel_StElmosFire_Text_C_Reward = {
    ID = "UI_Events_Panel_StElmosFire_Text_C_Reward",
    Content = "PanelText_UI_Events_Panel_StElmosFire_Text_C_Reward_Content|成就奖励"
  },
  UI_Events_Panel_StElmosFire_Text_C_Record = {
    ID = "UI_Events_Panel_StElmosFire_Text_C_Record",
    Content = "PanelText_UI_Events_Panel_StElmosFire_Text_C_Record_Content|最后的引航"
  },
  UI_Events_Panel_StElmosFire_Text_C_RecordTip = {
    ID = "UI_Events_Panel_StElmosFire_Text_C_RecordTip",
    Content = "PanelText_UI_Events_Panel_StElmosFire_Text_C_RecordTip_Content|限时免费解锁"
  },
  UI_Events_Panel_StElmosFire_Text_C_Challenge = {
    ID = "UI_Events_Panel_StElmosFire_Text_C_Challenge",
    Content = "PanelText_UI_Events_Panel_StElmosFire_Text_C_Challenge_Content|邃海迷航"
  },
  UI_Events_Panel_StElmosFire_Text_C_ChallengeTip = {
    ID = "UI_Events_Panel_StElmosFire_Text_C_ChallengeTip",
    Content = "PanelText_UI_Events_Panel_StElmosFire_Text_C_ChallengeTip_Content|玩法限时开放"
  },
  UI_Events_Panel_StElmosFire_Text_C_Topic = {
    ID = "UI_Events_Panel_StElmosFire_Text_C_Topic",
    Content = "PanelText_UI_Events_Panel_StElmosFire_Text_C_Topic_Content|于暴雨中摇曳"
  },
  UI_Events_Panel_StElmosFire_Text_C_Receive = {
    ID = "UI_Events_Panel_StElmosFire_Text_C_Receive",
    Content = "PanelText_UI_Events_Panel_StElmosFire_Text_C_Receive_Content|距离可领取"
  },
  UI_Events_Panel_StElmosFire_Text_C_Max = {
    ID = "UI_Events_Panel_StElmosFire_Text_C_Max",
    Content = "PanelText_UI_Events_Panel_StElmosFire_Text_C_Max_Content|Max"
  },
  UI_Events_Panel_StElmosFire_Text_C_Symbol = {
    ID = "UI_Events_Panel_StElmosFire_Text_C_Symbol",
    Content = "PanelText_UI_Events_Panel_StElmosFire_Text_C_Symbol_Content|)"
  },
  UI_Events_Panel_StElmosFire_Text_C_Fill_Up = {
    ID = "UI_Events_Panel_StElmosFire_Text_C_Fill_Up",
    Content = "PanelText_UI_Events_Panel_StElmosFire_Text_C_Fill_Up_Content|(距离补满："
  },
  UI_Events_Panel_StElmosFire_Text_C_Can_Unlockable = {
    ID = "UI_Events_Panel_StElmosFire_Text_C_Can_Unlockable",
    Content = "PanelText_UI_Events_Panel_StElmosFire_Text_C_Can_Unlockable_Content|可领取"
  },
  UI_Events_Panel_StElmosFire_Text_C_Not_unlocked = {
    ID = "UI_Events_Panel_StElmosFire_Text_C_Not_unlocked",
    Content = "PanelText_UI_Events_Panel_StElmosFire_Text_C_Not_unlocked_Content|未解锁"
  },
  UI_Events_Panel_StElmosFire_Text_C_Finished = {
    ID = "UI_Events_Panel_StElmosFire_Text_C_Finished",
    Content = "PanelText_UI_Events_Panel_StElmosFire_Text_C_Finished_Content|已结束"
  },
  UI_Events_Panel_StElmosFire_StageGroup_Text_C_Title = {
    ID = "UI_Events_Panel_StElmosFire_StageGroup_Text_C_Title",
    Content = "PanelText_UI_Events_Panel_StElmosFire_StageGroup_Text_C_Title_Content|邃海迷航"
  },
  UI_Events_Panel_StElmosFire_StageGroup_Text_C_Introduction = {
    ID = "UI_Events_Panel_StElmosFire_StageGroup_Text_C_Introduction",
    Content = "PanelText_UI_Events_Panel_StElmosFire_StageGroup_Text_C_Introduction_Content|老式六分仪确定星辰的夹角，古老的海图划定预期的航线，破旧的罗盘决定前进的方向……\n即使是位于深邃冰冷的黑海中，仍有探索者凭借无比凡俗的铜与铁，为众人指引前路。\n愿所有引导者，都不至陷入迷茫。"
  },
  UI_Events_Panel_StElmosFire_StageGroup_Text_C_Resonance = {
    ID = "UI_Events_Panel_StElmosFire_StageGroup_Text_C_Resonance",
    Content = "PanelText_UI_Events_Panel_StElmosFire_StageGroup_Text_C_Resonance_Content|共鸣"
  },
  UI_Events_Item_StElmosFire_Text_C_Diagonal = {
    ID = "UI_Events_Item_StElmosFire_Text_C_Diagonal",
    Content = "PanelText_UI_Events_Item_StElmosFire_Text_C_Diagonal_Content|/"
  },
  UI_Events_Item_StElmosFire_Text_C_Fall = {
    ID = "UI_Events_Item_StElmosFire_Text_C_Fall",
    Content = "PanelText_UI_Events_Item_StElmosFire_Text_C_Fall_Content|掉落预览"
  },
  UI_Events_Item_StElmosFire_Text_C_LockTips = {
    ID = "UI_Events_Item_StElmosFire_Text_C_LockTips",
    Content = "PanelText_UI_Events_Item_StElmosFire_Text_C_LockTips_Content|关卡解锁提示"
  },
  UI_Bag_Obtain_Awaken_Tips_Text_Cancel_Name = {
    ID = "UI_Bag_Obtain_Awaken_Tips_Text_Cancel_Name",
    Content = "PanelText_UI_Bag_Obtain_Awaken_Tips_Text_Cancel_Name_Content|查看详情"
  },
  UI_Bag_Obtain_Awaken_Tips_Text_Confirm_Name = {
    ID = "UI_Bag_Obtain_Awaken_Tips_Text_Confirm_Name",
    Content = "PanelText_UI_Bag_Obtain_Awaken_Tips_Text_Confirm_Name_Content|确定"
  },
  UI_Passport_Money_Item_New_Text_C_Hoist = {
    ID = "UI_Passport_Money_Item_New_Text_C_Hoist",
    Content = "PanelText_UI_Passport_Money_Item_New_Text_C_Hoist_Content|立即提升<color=#5EF2FF><size=32>10</size>级</color>课题等级"
  },
  UI_Events_Panel_ClotherLottery_Text_Free = {
    ID = "UI_Events_Panel_ClotherLottery_Text_Free",
    Content = "PanelText_UI_Events_Panel_ClotherLottery_Text_Free_Content|免费"
  },
  UI_Battle_Popup_RebirthTip_Text_C_Tips = {
    ID = "UI_Battle_Popup_RebirthTip_Text_C_Tips",
    Content = "PanelText_UI_Battle_Popup_RebirthTip_Text_C_Tips_Content|（兑换后将直接消耗并且复活，若撤退则会返还应急灵知体）"
  },
  UI_Battle_Popup_RebirthTip_Text_C_Cost = {
    ID = "UI_Battle_Popup_RebirthTip_Text_C_Cost",
    Content = "PanelText_UI_Battle_Popup_RebirthTip_Text_C_Cost_Content|消耗"
  },
  UI_Battle_Popup_RebirthTip_Text_Title = {
    ID = "UI_Battle_Popup_RebirthTip_Text_Title",
    Content = "PanelText_UI_Battle_Popup_RebirthTip_Text_Title_Content|复活确认"
  },
  UI_Battle_Popup_RebirthTip_Text_Cancel_Name = {
    ID = "UI_Battle_Popup_RebirthTip_Text_Cancel_Name",
    Content = "PanelText_UI_Battle_Popup_RebirthTip_Text_Cancel_Name_Content|取消"
  },
  UI_Battle_Popup_RebirthTip_Text_Confirm_Name = {
    ID = "UI_Battle_Popup_RebirthTip_Text_Confirm_Name",
    Content = "PanelText_UI_Battle_Popup_RebirthTip_Text_Confirm_Name_Content|确定"
  },
  UI_Battle_Popup_RebirthTip_Text_C_CostTips = {
    ID = "UI_Battle_Popup_RebirthTip_Text_C_CostTips",
    Content = "PanelText_UI_Battle_Popup_RebirthTip_Text_C_CostTips_Content|应急灵知体已耗尽，是否花费"
  },
  UI_Battle_Popup_RebirthTip_Text_C_CostTips2 = {
    ID = "UI_Battle_Popup_RebirthTip_Text_C_CostTips2",
    Content = "PanelText_UI_Battle_Popup_RebirthTip_Text_C_CostTips2_Content|进行兑换？"
  },
  UI_Summon_Panel_Main_Text_C_FirstLimit = {
    ID = "UI_Summon_Panel_Main_Text_C_FirstLimit",
    Content = "PanelText_UI_Summon_Panel_Main_Text_C_FirstLimit_Content|初回限定"
  },
  UI_Summon_Panel_Main_Text_C_LimitName = {
    ID = "UI_Summon_Panel_Main_Text_C_LimitName",
    Content = "PanelText_UI_Summon_Panel_Main_Text_C_LimitName_Content|唤醒五次"
  },
  UI_Summon_Panel_Main_Text_C_FreeLimit = {
    ID = "UI_Summon_Panel_Main_Text_C_FreeLimit",
    Content = "PanelText_UI_Summon_Panel_Main_Text_C_FreeLimit_Content|免费"
  },
  UI_Summon_Panel_Main_Text_C_TryName = {
    ID = "UI_Summon_Panel_Main_Text_C_TryName",
    Content = "PanelText_UI_Summon_Panel_Main_Text_C_TryName_Content|唤醒体试用"
  },
  UI_Summon_Panel_Main_Text_C_RecAwaker = {
    ID = "UI_Summon_Panel_Main_Text_C_RecAwaker",
    Content = "PanelText_UI_Summon_Panel_Main_Text_C_RecAwaker_Content|推荐的唤醒体"
  },
  UI_Events_Popup_GiftBag_Text_C_OptionWeapon = {
    ID = "UI_Events_Popup_GiftBag_Text_C_OptionWeapon",
    Content = "PanelText_UI_Events_Popup_GiftBag_Text_C_OptionWeapon_Content|查看全部可选命轮"
  },
  UI_Events_Popup_GiftBag_Text_C_Slogan = {
    ID = "UI_Events_Popup_GiftBag_Text_C_Slogan",
    Content = "PanelText_UI_Events_Popup_GiftBag_Text_C_Slogan_Content|仅限24小时！\n常驻唤醒体选择其一！"
  },
  UI_Events_Popup_GiftBag_Text_C_SpecialTime = {
    ID = "UI_Events_Popup_GiftBag_Text_C_SpecialTime",
    Content = "PanelText_UI_Events_Popup_GiftBag_Text_C_SpecialTime_Content|剩余"
  },
  UI_Events_Popup_GiftBag_Text_PayTip = {
    ID = "UI_Events_Popup_GiftBag_Text_PayTip",
    Content = "PanelText_UI_Events_Popup_GiftBag_Text_PayTip_Content|当前展示价格为默认货币价格，仅供参考。支付时请以实际货币和价格为准。"
  },
  UI_Events_Popup_GiftBag_Text_C_Desc = {
    ID = "UI_Events_Popup_GiftBag_Text_C_Desc",
    Content = "PanelText_UI_Events_Popup_GiftBag_Text_C_Desc_Content|活动描述"
  },
  UI_Events_Popup_GiftBag_Text_C_InfoTitle = {
    ID = "UI_Events_Popup_GiftBag_Text_C_InfoTitle",
    Content = "PanelText_UI_Events_Popup_GiftBag_Text_C_InfoTitle_Content|活动简介"
  },
  UI_Recharge_Panel_Extract_Text_C_Law1 = {
    ID = "UI_Recharge_Panel_Extract_Text_C_Law1",
    Content = "PanelText_UI_Recharge_Panel_Extract_Text_C_Law1_Content|特商法"
  },
  UI_Recharge_Panel_Extract_Text_C_Law2 = {
    ID = "UI_Recharge_Panel_Extract_Text_C_Law2",
    Content = "PanelText_UI_Recharge_Panel_Extract_Text_C_Law2_Content|资金结算法"
  },
  UI_Events_Panel_ClotherLottery_Text_C_Topic = {
    ID = "UI_Events_Panel_ClotherLottery_Text_C_Topic",
    Content = "PanelText_UI_Events_Panel_ClotherLottery_Text_C_Topic_Content|灵魂牧羊人"
  },
  UI_Events_Panel_ClotherLottery_Text_C_Tip = {
    ID = "UI_Events_Panel_ClotherLottery_Text_C_Tip",
    Content = "PanelText_UI_Events_Panel_ClotherLottery_Text_C_Tip_Content|<color=#e3c96e>银枢幻衣</color>有机会从第<color=#e3c96e>5</color>次抽取开始获得"
  },
  UI_Events_Panel_ClotherLottery_Text_C_Empty = {
    ID = "UI_Events_Panel_ClotherLottery_Text_C_Empty",
    Content = "PanelText_UI_Events_Panel_ClotherLottery_Text_C_Empty_Content|已获得所有奖励"
  },
  UI_Events_Panel_ClotherLottery_Text_C_Lottery = {
    ID = "UI_Events_Panel_ClotherLottery_Text_C_Lottery",
    Content = "PanelText_UI_Events_Panel_ClotherLottery_Text_C_Lottery_Content|抽取一次"
  },
  UI_Events_Panel_ClotherLottery_Text_C_Rate = {
    ID = "UI_Events_Panel_ClotherLottery_Text_C_Rate",
    Content = "PanelText_UI_Events_Panel_ClotherLottery_Text_C_Rate_Content|概率说明"
  },
  _Text_C_Reveal = {
    ID = "_Text_C_Reveal",
    Content = "PanelText__Text_C_Reveal_Content|隐藏"
  },
  _Text_C_Empty = {
    ID = "_Text_C_Empty",
    Content = "PanelText__Text_C_Empty_Content|已下架"
  },
  _Text_C_Have = {
    ID = "_Text_C_Have",
    Content = "PanelText__Text_C_Have_Content|已拥有"
  },
  _Text_C_Goto = {
    ID = "_Text_C_Goto",
    Content = "PanelText__Text_C_Goto_Content|前往购买"
  },
  _Text_C_Dressing = {
    ID = "_Text_C_Dressing",
    Content = "PanelText__Text_C_Dressing_Content|着装中"
  },
  _Text_C_Dress = {
    ID = "_Text_C_Dress",
    Content = "PanelText__Text_C_Dress_Content|换装"
  },
  UI_Battle_Panel_Dbg_Text_C_Auto = {
    ID = "UI_Battle_Panel_Dbg_Text_C_Auto",
    Content = "PanelText_UI_Battle_Panel_Dbg_Text_C_Auto_Content|AUTO"
  },
  UI_Battle_Panel_Dbg_Text_C_Setting = {
    ID = "UI_Battle_Panel_Dbg_Text_C_Setting",
    Content = "PanelText_UI_Battle_Panel_Dbg_Text_C_Setting_Content|设置"
  },
  UI_Battle_Panel_Dbg_Text_C_Insufficient = {
    ID = "UI_Battle_Panel_Dbg_Text_C_Insufficient",
    Content = "PanelText_UI_Battle_Panel_Dbg_Text_C_Insufficient_Content|空间不足"
  },
  UI_Events_Panel_ActivityPassport_Text_C_Senior = {
    ID = "UI_Events_Panel_ActivityPassport_Text_C_Senior",
    Content = "PanelText_UI_Events_Panel_ActivityPassport_Text_C_Senior_Content|高级纪行"
  },
  UI_Events_Panel_ActivityPassport_Text_PayTip = {
    ID = "UI_Events_Panel_ActivityPassport_Text_PayTip",
    Content = "PanelText_UI_Events_Panel_ActivityPassport_Text_PayTip_Content|当前展示价格为默认货币价格，仅供参考。支付时请以实际货币和价格为准。"
  },
  UI_Events_Panel_ActivityPassport_Text_C_Ordinary = {
    ID = "UI_Events_Panel_ActivityPassport_Text_C_Ordinary",
    Content = "PanelText_UI_Events_Panel_ActivityPassport_Text_C_Ordinary_Content|普通纪行"
  },
  UI_Events_Panel_ActivityPassport_Text_C_PassportUp = {
    ID = "UI_Events_Panel_ActivityPassport_Text_C_PassportUp",
    Content = "PanelText_UI_Events_Panel_ActivityPassport_Text_C_PassportUp_Content|纪行进阶"
  },
  UI_Events_Panel_ActivityPassport_Text_C_OneKey = {
    ID = "UI_Events_Panel_ActivityPassport_Text_C_OneKey",
    Content = "PanelText_UI_Events_Panel_ActivityPassport_Text_C_OneKey_Content|一键领取"
  },
  UI_Events_Panel_ActivityPassport_Text_C_illustrate = {
    ID = "UI_Events_Panel_ActivityPassport_Text_C_illustrate",
    Content = "PanelText_UI_Events_Panel_ActivityPassport_Text_C_illustrate_Content|活动说明"
  },
  UI_Events_Popup_ClotherLotteryRate_Text_C_CurRate = {
    ID = "UI_Events_Popup_ClotherLotteryRate_Text_C_CurRate",
    Content = "PanelText_UI_Events_Popup_ClotherLotteryRate_Text_C_CurRate_Content|当前概率"
  },
  UI_Events_Popup_ClotherLotteryRate_Text_C_InitRate = {
    ID = "UI_Events_Popup_ClotherLotteryRate_Text_C_InitRate",
    Content = "PanelText_UI_Events_Popup_ClotherLotteryRate_Text_C_InitRate_Content|初始概率"
  },
  UI_Events_Popup_ClotherLotteryRate_Text_C_Awards = {
    ID = "UI_Events_Popup_ClotherLotteryRate_Text_C_Awards",
    Content = "PanelText_UI_Events_Popup_ClotherLotteryRate_Text_C_Awards_Content|奖项"
  },
  UI_Events_Popup_ClotherLotteryRate_Text_C_Item = {
    ID = "UI_Events_Popup_ClotherLotteryRate_Text_C_Item",
    Content = "PanelText_UI_Events_Popup_ClotherLotteryRate_Text_C_Item_Content|奖励道具"
  },
  UI_Events_Popup_ClotherLotteryRate_Text_C_Rate = {
    ID = "UI_Events_Popup_ClotherLotteryRate_Text_C_Rate",
    Content = "PanelText_UI_Events_Popup_ClotherLotteryRate_Text_C_Rate_Content|概率"
  },
  UI_Events_Panel_Attendance_Text_C_GiftTitle = {
    ID = "UI_Events_Panel_Attendance_Text_C_GiftTitle",
    Content = "PanelText_UI_Events_Panel_Attendance_Text_C_GiftTitle_Content|完成任务领取幻衣兑换券"
  },
  UI_Summon_Panel_LuckyBag_Text_C_GiftTitle = {
    ID = "UI_Summon_Panel_LuckyBag_Text_C_GiftTitle",
    Content = "PanelText_UI_Summon_Panel_LuckyBag_Text_C_GiftTitle_Content|完成任务领取幻衣兑换券"
  },
  UI_Events_Panel_OceanBoss_Text_C_GiftTitle = {
    ID = "UI_Events_Panel_OceanBoss_Text_C_GiftTitle",
    Content = "PanelText_UI_Events_Panel_OceanBoss_Text_C_GiftTitle_Content|完成任务领取幻衣兑换券"
  },
  UI_Events_Panel_Castor_Text_C_Shop = {
    ID = "UI_Events_Panel_Castor_Text_C_Shop",
    Content = "PanelText_UI_Events_Panel_Castor_Text_C_Shop_Content|求知的愿望"
  },
  UI_Events_Panel_Castor_Text_C_Resonance = {
    ID = "UI_Events_Panel_Castor_Text_C_Resonance",
    Content = "PanelText_UI_Events_Panel_Castor_Text_C_Resonance_Content|共鸣：吞噬山脉"
  },
  UI_Events_Panel_Castor_Text_C_Diagonal = {
    ID = "UI_Events_Panel_Castor_Text_C_Diagonal",
    Content = "PanelText_UI_Events_Panel_Castor_Text_C_Diagonal_Content|/"
  },
  UI_Events_Panel_Castor_Text_C_Reward = {
    ID = "UI_Events_Panel_Castor_Text_C_Reward",
    Content = "PanelText_UI_Events_Panel_Castor_Text_C_Reward_Content|成就奖励"
  },
  UI_Events_Panel_Castor_Text_C_Record = {
    ID = "UI_Events_Panel_Castor_Text_C_Record",
    Content = "PanelText_UI_Events_Panel_Castor_Text_C_Record_Content|异梦视界"
  },
  UI_Events_Panel_Castor_Text_C_RecordTip = {
    ID = "UI_Events_Panel_Castor_Text_C_RecordTip",
    Content = "PanelText_UI_Events_Panel_Castor_Text_C_RecordTip_Content|限时免费解锁"
  },
  UI_Events_Panel_Castor_Text_C_Challenge = {
    ID = "UI_Events_Panel_Castor_Text_C_Challenge",
    Content = "PanelText_UI_Events_Panel_Castor_Text_C_Challenge_Content|飞跃青空"
  },
  UI_Events_Panel_Castor_Text_C_ChallengeTip = {
    ID = "UI_Events_Panel_Castor_Text_C_ChallengeTip",
    Content = "PanelText_UI_Events_Panel_Castor_Text_C_ChallengeTip_Content|玩法限时开放"
  },
  UI_Events_Panel_Castor_Text_C_Topic = {
    ID = "UI_Events_Panel_Castor_Text_C_Topic",
    Content = "PanelText_UI_Events_Panel_Castor_Text_C_Topic_Content|镜像囚徒"
  },
  UI_Events_Panel_Castor_Text_C_Receive = {
    ID = "UI_Events_Panel_Castor_Text_C_Receive",
    Content = "PanelText_UI_Events_Panel_Castor_Text_C_Receive_Content|距离可领取"
  },
  UI_Events_Panel_Castor_Text_C_Max = {
    ID = "UI_Events_Panel_Castor_Text_C_Max",
    Content = "PanelText_UI_Events_Panel_Castor_Text_C_Max_Content|Max"
  },
  UI_Events_Panel_Castor_Text_C_Symbol = {
    ID = "UI_Events_Panel_Castor_Text_C_Symbol",
    Content = "PanelText_UI_Events_Panel_Castor_Text_C_Symbol_Content|)"
  },
  UI_Events_Panel_Castor_Text_C_Fill_Up = {
    ID = "UI_Events_Panel_Castor_Text_C_Fill_Up",
    Content = "PanelText_UI_Events_Panel_Castor_Text_C_Fill_Up_Content|(距离补满："
  },
  UI_Events_Panel_Castor_Text_C_Can_Unlockable = {
    ID = "UI_Events_Panel_Castor_Text_C_Can_Unlockable",
    Content = "PanelText_UI_Events_Panel_Castor_Text_C_Can_Unlockable_Content|可领取"
  },
  UI_Events_Panel_Castor_Text_C_Not_unlocked = {
    ID = "UI_Events_Panel_Castor_Text_C_Not_unlocked",
    Content = "PanelText_UI_Events_Panel_Castor_Text_C_Not_unlocked_Content|未解锁"
  },
  UI_Events_Panel_Castor_Text_C_Finished = {
    ID = "UI_Events_Panel_Castor_Text_C_Finished",
    Content = "PanelText_UI_Events_Panel_Castor_Text_C_Finished_Content|已结束"
  },
  UI_Event_Activity_Castor_Text_None = {
    ID = "UI_Event_Activity_Castor_Text_None",
    Content = "PanelText_UI_Event_Activity_Castor_Text_None_Content|暂无物资"
  },
  UI_Events_Item_Castor_Text_C_Diagonal = {
    ID = "UI_Events_Item_Castor_Text_C_Diagonal",
    Content = "PanelText_UI_Events_Item_Castor_Text_C_Diagonal_Content|/"
  },
  UI_Events_Item_Castor_Text_C_Fall = {
    ID = "UI_Events_Item_Castor_Text_C_Fall",
    Content = "PanelText_UI_Events_Item_Castor_Text_C_Fall_Content|掉落预览"
  },
  UI_Events_Item_Castor_Text_C_LockTips = {
    ID = "UI_Events_Item_Castor_Text_C_LockTips",
    Content = "PanelText_UI_Events_Item_Castor_Text_C_LockTips_Content|关卡解锁提示"
  },
  UI_Events_Panel_Castor_StageGroup_Text_C_Title = {
    ID = "UI_Events_Panel_Castor_StageGroup_Text_C_Title",
    Content = "PanelText_UI_Events_Panel_Castor_StageGroup_Text_C_Title_Content|飞跃青空"
  },
  UI_Events_Panel_Castor_StageGroup_Text_C_Introduction = {
    ID = "UI_Events_Panel_Castor_StageGroup_Text_C_Introduction",
    Content = "PanelText_UI_Events_Panel_Castor_StageGroup_Text_C_Introduction_Content|飞鸟的一生，注定是自由的一生。你该看到它的破壳之时，它从死亡手中夺回生的自由。 你该看到它的学飞之时，它从安逸的温巢中夺回独自生存的自由。如今若将自由的钥匙丢入死亡的深渊，那么它必将毫不犹豫地一跃而下，在狭窄的生命与无限的自由中，选择直面死亡的暴风。"
  },
  UI_Events_Panel_Castor_StageGroup_Text_C_Resonance = {
    ID = "UI_Events_Panel_Castor_StageGroup_Text_C_Resonance",
    Content = "PanelText_UI_Events_Panel_Castor_StageGroup_Text_C_Resonance_Content|共鸣"
  },
  UI_Event_Activity_Castor_Text_C_Reward = {
    ID = "UI_Event_Activity_Castor_Text_C_Reward",
    Content = "PanelText_UI_Event_Activity_Castor_Text_C_Reward_Content|获得物资"
  },
  UI_Event_Activity_Castor_Text_C_Max = {
    ID = "UI_Event_Activity_Castor_Text_C_Max",
    Content = "PanelText_UI_Event_Activity_Castor_Text_C_Max_Content|Max"
  },
  UI_Event_Activity_Castor_Text_C_Full = {
    ID = "UI_Event_Activity_Castor_Text_C_Full",
    Content = "PanelText_UI_Event_Activity_Castor_Text_C_Full_Content|当前已达存储上限"
  },
  UI_Event_Activity_Castor_Text_C_Finish = {
    ID = "UI_Event_Activity_Castor_Text_C_Finish",
    Content = "PanelText_UI_Event_Activity_Castor_Text_C_Finish_Content|活动已结束，已停止获取"
  },
  UI_Event_Activity_Castor_Text_C_SpeedTitle = {
    ID = "UI_Event_Activity_Castor_Text_C_SpeedTitle",
    Content = "PanelText_UI_Event_Activity_Castor_Text_C_SpeedTitle_Content|存储速度:"
  },
  UI_Chapter_Item_Dream_03_Text_C_Free_Unlock = {
    ID = "UI_Chapter_Item_Dream_03_Text_C_Free_Unlock",
    Content = "PanelText_UI_Chapter_Item_Dream_03_Text_C_Free_Unlock_Content|限时免费解锁"
  },
  UI_Main_Panel_1_Text_C_Recruit_Nor = {
    ID = "UI_Main_Panel_1_Text_C_Recruit_Nor",
    Content = "PanelText_UI_Main_Panel_1_Text_C_Recruit_Nor_Content|唤醒"
  },
  UI_Summon_Panel_Main_Text_FreeTen = {
    ID = "UI_Summon_Panel_Main_Text_FreeTen",
    Content = "PanelText_UI_Summon_Panel_Main_Text_FreeTen_Content|免费"
  },
  UI_Battle_Item_CounterAwaker_Text_C_CounterAwaker = {
    ID = "UI_Battle_Item_CounterAwaker_Text_C_CounterAwaker",
    Content = "PanelText_UI_Battle_Item_CounterAwaker_Text_C_CounterAwaker_Content|特攻唤醒体"
  },
  UI_Battle_Tip_CounterAwaker_Text_C_Title = {
    ID = "UI_Battle_Tip_CounterAwaker_Text_C_Title",
    Content = "PanelText_UI_Battle_Tip_CounterAwaker_Text_C_Title_Content|敌人特性"
  },
  UI_Pvp_Popup_Expression_Manage_Text_C_Emoji = {
    ID = "UI_Pvp_Popup_Expression_Manage_Text_C_Emoji",
    Content = "PanelText_UI_Pvp_Popup_Expression_Manage_Text_C_Emoji_Content|表情管理"
  },
  UI_Pvp_Popup_Expression_Manage_Text_C_Emoji_Sel = {
    ID = "UI_Pvp_Popup_Expression_Manage_Text_C_Emoji_Sel",
    Content = "PanelText_UI_Pvp_Popup_Expression_Manage_Text_C_Emoji_Sel_Content|表情管理"
  },
  UI_Pvp_Popup_Expression_Manage_Text_C_Emoji_Overview = {
    ID = "UI_Pvp_Popup_Expression_Manage_Text_C_Emoji_Overview",
    Content = "PanelText_UI_Pvp_Popup_Expression_Manage_Text_C_Emoji_Overview_Content|表情故事"
  },
  UI_Pvp_Popup_Expression_Manage_Text_C_Emoji_Overview_Sel = {
    ID = "UI_Pvp_Popup_Expression_Manage_Text_C_Emoji_Overview_Sel",
    Content = "PanelText_UI_Pvp_Popup_Expression_Manage_Text_C_Emoji_Overview_Sel_Content|表情故事"
  },
  UI_Events_Panel_Doresain_Text_C_Shop = {
    ID = "UI_Events_Panel_Doresain_Text_C_Shop",
    Content = "PanelText_UI_Events_Panel_Doresain_Text_C_Shop_Content|王邸餐厅"
  },
  UI_Events_Panel_Doresain_Text_C_Resonance = {
    ID = "UI_Events_Panel_Doresain_Text_C_Resonance",
    Content = "PanelText_UI_Events_Panel_Doresain_Text_C_Resonance_Content|共鸣：吞噬山脉"
  },
  UI_Events_Panel_Doresain_Text_C_Diagonal = {
    ID = "UI_Events_Panel_Doresain_Text_C_Diagonal",
    Content = "PanelText_UI_Events_Panel_Doresain_Text_C_Diagonal_Content|/"
  },
  UI_Events_Panel_Doresain_Text_C_Reward = {
    ID = "UI_Events_Panel_Doresain_Text_C_Reward",
    Content = "PanelText_UI_Events_Panel_Doresain_Text_C_Reward_Content|成就奖励"
  },
  UI_Events_Panel_Doresain_Text_C_Record = {
    ID = "UI_Events_Panel_Doresain_Text_C_Record",
    Content = "PanelText_UI_Events_Panel_Doresain_Text_C_Record_Content|派遣记录"
  },
  UI_Events_Panel_Doresain_Text_C_RecordTip = {
    ID = "UI_Events_Panel_Doresain_Text_C_RecordTip",
    Content = "PanelText_UI_Events_Panel_Doresain_Text_C_RecordTip_Content|限时免费解锁"
  },
  UI_Events_Panel_Doresain_Text_C_Challenge = {
    ID = "UI_Events_Panel_Doresain_Text_C_Challenge",
    Content = "PanelText_UI_Events_Panel_Doresain_Text_C_Challenge_Content|噬灵之飨"
  },
  UI_Events_Panel_Doresain_Text_C_ChallengeTip = {
    ID = "UI_Events_Panel_Doresain_Text_C_ChallengeTip",
    Content = "PanelText_UI_Events_Panel_Doresain_Text_C_ChallengeTip_Content|玩法限时开放"
  },
  UI_Events_Panel_Doresain_Text_C_Topic = {
    ID = "UI_Events_Panel_Doresain_Text_C_Topic",
    Content = "PanelText_UI_Events_Panel_Doresain_Text_C_Topic_Content|死灵的美学"
  },
  UI_Events_Panel_Doresain_Text_C_Receive = {
    ID = "UI_Events_Panel_Doresain_Text_C_Receive",
    Content = "PanelText_UI_Events_Panel_Doresain_Text_C_Receive_Content|距离可领取"
  },
  UI_Events_Panel_Doresain_Text_C_Max = {
    ID = "UI_Events_Panel_Doresain_Text_C_Max",
    Content = "PanelText_UI_Events_Panel_Doresain_Text_C_Max_Content|Max"
  },
  UI_Events_Panel_Doresain_Text_C_Symbol = {
    ID = "UI_Events_Panel_Doresain_Text_C_Symbol",
    Content = "PanelText_UI_Events_Panel_Doresain_Text_C_Symbol_Content|)"
  },
  UI_Events_Panel_Doresain_Text_C_Fill_Up = {
    ID = "UI_Events_Panel_Doresain_Text_C_Fill_Up",
    Content = "PanelText_UI_Events_Panel_Doresain_Text_C_Fill_Up_Content|(距离补满："
  },
  UI_Events_Panel_Doresain_Text_C_Can_Unlockable = {
    ID = "UI_Events_Panel_Doresain_Text_C_Can_Unlockable",
    Content = "PanelText_UI_Events_Panel_Doresain_Text_C_Can_Unlockable_Content|可领取"
  },
  UI_Events_Panel_Doresain_Text_C_Not_unlocked = {
    ID = "UI_Events_Panel_Doresain_Text_C_Not_unlocked",
    Content = "PanelText_UI_Events_Panel_Doresain_Text_C_Not_unlocked_Content|未解锁"
  },
  UI_Events_Panel_Doresain_Text_C_Finished = {
    ID = "UI_Events_Panel_Doresain_Text_C_Finished",
    Content = "PanelText_UI_Events_Panel_Doresain_Text_C_Finished_Content|已结束"
  },
  UI_Events_Panel_Doresain_StageGroup_Text_C_Title = {
    ID = "UI_Events_Panel_Doresain_StageGroup_Text_C_Title",
    Content = "PanelText_UI_Events_Panel_Doresain_StageGroup_Text_C_Title_Content|噬灵之飨"
  },
  UI_Events_Panel_Doresain_StageGroup_Text_C_Introduction = {
    ID = "UI_Events_Panel_Doresain_StageGroup_Text_C_Introduction",
    Content = "PanelText_UI_Events_Panel_Doresain_StageGroup_Text_C_Introduction_Content|弦乐已升上中天，第十三道钟声已然奏响。\n今夜，诗人的餐刀将为我们吟诵。\n今夜，母亲的喉管将拥我们入怀。"
  },
  UI_Events_Panel_Doresain_StageGroup_Text_C_Resonance = {
    ID = "UI_Events_Panel_Doresain_StageGroup_Text_C_Resonance",
    Content = "PanelText_UI_Events_Panel_Doresain_StageGroup_Text_C_Resonance_Content|共鸣"
  },
  UI_Events_Item_Doresain_Text_C_Diagonal = {
    ID = "UI_Events_Item_Doresain_Text_C_Diagonal",
    Content = "PanelText_UI_Events_Item_Doresain_Text_C_Diagonal_Content|/"
  },
  UI_Events_Item_Doresain_Text_C_Fall = {
    ID = "UI_Events_Item_Doresain_Text_C_Fall",
    Content = "PanelText_UI_Events_Item_Doresain_Text_C_Fall_Content|掉落预览"
  },
  UI_Events_Item_Doresain_Text_C_LockTips = {
    ID = "UI_Events_Item_Doresain_Text_C_LockTips",
    Content = "PanelText_UI_Events_Item_Doresain_Text_C_LockTips_Content|关卡解锁提示"
  },
  UI_Passport_Task_Choose_Text_C_Double = {
    ID = "UI_Passport_Task_Choose_Text_C_Double",
    Content = "PanelText_UI_Passport_Task_Choose_Text_C_Double_Content|双倍经验"
  },
  UI_Dungeous_Popup_FailTip_Text_C_Title = {
    ID = "UI_Dungeous_Popup_FailTip_Text_C_Title",
    Content = "PanelText_UI_Dungeous_Popup_FailTip_Text_C_Title_Content|如何变强"
  },
  UI_Chapter_Item_Dream_02_Text_C_Free_Unlock = {
    ID = "UI_Chapter_Item_Dream_02_Text_C_Free_Unlock",
    Content = "PanelText_UI_Chapter_Item_Dream_02_Text_C_Free_Unlock_Content|限时免费解锁"
  },
  UI_Awaker_Item_Potency_Detail_Text_C_WillSolved = {
    ID = "UI_Awaker_Item_Potency_Detail_Text_C_WillSolved",
    Content = "PanelText_UI_Awaker_Item_Potency_Detail_Text_C_WillSolved_Content|此次解锁"
  },
  UI_Awaker_Popup_Topped_Tip3_Text_C_WillSolved = {
    ID = "UI_Awaker_Popup_Topped_Tip3_Text_C_WillSolved",
    Content = "PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_WillSolved_Content|此次解锁"
  },
  UI_Dungeons_Item_Level_Content_Text_C_Extra = {
    ID = "UI_Dungeons_Item_Level_Content_Text_C_Extra",
    Content = "PanelText_UI_Dungeons_Item_Level_Content_Text_C_Extra_Content|额外通关"
  },
  UI_Dungeons_Item_Level_Content_Text_C_Name_Extra = {
    ID = "UI_Dungeons_Item_Level_Content_Text_C_Name_Extra",
    Content = "PanelText_UI_Dungeons_Item_Level_Content_Text_C_Name_Extra_Content|重置"
  },
  UI_Dungeous_Panel_Molten_Optimized_Text_C_Extra = {
    ID = "UI_Dungeous_Panel_Molten_Optimized_Text_C_Extra",
    Content = "PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_C_Extra_Content|额外通关阵容"
  },
  UI_Dungeous_Panel_Molten_Optimized_Text_C_Name_Extra = {
    ID = "UI_Dungeous_Panel_Molten_Optimized_Text_C_Name_Extra",
    Content = "PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_C_Name_Extra_Content|重置"
  },
  UI_Events_Panel_Rome_Text_C_Shop = {
    ID = "UI_Events_Panel_Rome_Text_C_Shop",
    Content = "PanelText_UI_Events_Panel_Rome_Text_C_Shop_Content|敬献贡礼"
  },
  UI_Events_Panel_Rome_Text_C_Resonance = {
    ID = "UI_Events_Panel_Rome_Text_C_Resonance",
    Content = "PanelText_UI_Events_Panel_Rome_Text_C_Resonance_Content|共鸣：吞噬山脉"
  },
  UI_Events_Panel_Rome_Text_C_Diagonal = {
    ID = "UI_Events_Panel_Rome_Text_C_Diagonal",
    Content = "PanelText_UI_Events_Panel_Rome_Text_C_Diagonal_Content|/"
  },
  UI_Events_Panel_Rome_Text_C_Reward = {
    ID = "UI_Events_Panel_Rome_Text_C_Reward",
    Content = "PanelText_UI_Events_Panel_Rome_Text_C_Reward_Content|成就奖励"
  },
  UI_Events_Panel_Rome_Text_C_Record = {
    ID = "UI_Events_Panel_Rome_Text_C_Record",
    Content = "PanelText_UI_Events_Panel_Rome_Text_C_Record_Content|异梦视界"
  },
  UI_Events_Panel_Rome_Text_C_RecordTip = {
    ID = "UI_Events_Panel_Rome_Text_C_RecordTip",
    Content = "PanelText_UI_Events_Panel_Rome_Text_C_RecordTip_Content|限时免费解锁"
  },
  UI_Events_Panel_Rome_Text_C_Challenge = {
    ID = "UI_Events_Panel_Rome_Text_C_Challenge",
    Content = "PanelText_UI_Events_Panel_Rome_Text_C_Challenge_Content|神圣的猎食"
  },
  UI_Events_Panel_Rome_Text_C_ChallengeTip = {
    ID = "UI_Events_Panel_Rome_Text_C_ChallengeTip",
    Content = "PanelText_UI_Events_Panel_Rome_Text_C_ChallengeTip_Content|玩法限时开放"
  },
  UI_Events_Panel_Rome_Text_C_Topic = {
    ID = "UI_Events_Panel_Rome_Text_C_Topic",
    Content = "PanelText_UI_Events_Panel_Rome_Text_C_Topic_Content|罗马！特别活动"
  },
  UI_Events_Panel_Rome_Text_C_Receive = {
    ID = "UI_Events_Panel_Rome_Text_C_Receive",
    Content = "PanelText_UI_Events_Panel_Rome_Text_C_Receive_Content|距离可领取"
  },
  UI_Events_Panel_Rome_Text_C_Max = {
    ID = "UI_Events_Panel_Rome_Text_C_Max",
    Content = "PanelText_UI_Events_Panel_Rome_Text_C_Max_Content|Max"
  },
  UI_Events_Panel_Rome_Text_C_Symbol = {
    ID = "UI_Events_Panel_Rome_Text_C_Symbol",
    Content = "PanelText_UI_Events_Panel_Rome_Text_C_Symbol_Content|)"
  },
  UI_Events_Panel_Rome_Text_C_Fill_Up = {
    ID = "UI_Events_Panel_Rome_Text_C_Fill_Up",
    Content = "PanelText_UI_Events_Panel_Rome_Text_C_Fill_Up_Content|(距离补满："
  },
  UI_Events_Panel_Rome_Text_C_Can_Unlockable = {
    ID = "UI_Events_Panel_Rome_Text_C_Can_Unlockable",
    Content = "PanelText_UI_Events_Panel_Rome_Text_C_Can_Unlockable_Content|可领取"
  },
  UI_Events_Panel_Rome_Text_C_Not_unlocked = {
    ID = "UI_Events_Panel_Rome_Text_C_Not_unlocked",
    Content = "PanelText_UI_Events_Panel_Rome_Text_C_Not_unlocked_Content|未解锁"
  },
  UI_Events_Panel_Rome_Text_C_Finished = {
    ID = "UI_Events_Panel_Rome_Text_C_Finished",
    Content = "PanelText_UI_Events_Panel_Rome_Text_C_Finished_Content|已结束"
  },
  UI_Events_Item_Rome_Text_C_Diagonal = {
    ID = "UI_Events_Item_Rome_Text_C_Diagonal",
    Content = "PanelText_UI_Events_Item_Rome_Text_C_Diagonal_Content|/"
  },
  UI_Events_Item_Rome_Text_C_Fall = {
    ID = "UI_Events_Item_Rome_Text_C_Fall",
    Content = "PanelText_UI_Events_Item_Rome_Text_C_Fall_Content|掉落预览"
  },
  UI_Events_Item_Rome_Text_C_LockTips = {
    ID = "UI_Events_Item_Rome_Text_C_LockTips",
    Content = "PanelText_UI_Events_Item_Rome_Text_C_LockTips_Content|关卡解锁提示"
  },
  UI_Events_Panel_Rome_StageGroup_Text_C_Title = {
    ID = "UI_Events_Panel_Rome_StageGroup_Text_C_Title",
    Content = "PanelText_UI_Events_Panel_Rome_StageGroup_Text_C_Title_Content|神圣的猎食"
  },
  UI_Events_Panel_Rome_StageGroup_Text_C_Introduction = {
    ID = "UI_Events_Panel_Rome_StageGroup_Text_C_Introduction",
    Content = "PanelText_UI_Events_Panel_Rome_StageGroup_Text_C_Introduction_Content|我们是食肉者，我们是狼的后代。 那些美味的、流淌鲜血的肉块，终将落入我们的胃袋。"
  },
  UI_Events_Panel_Rome_StageGroup_Text_C_Resonance = {
    ID = "UI_Events_Panel_Rome_StageGroup_Text_C_Resonance",
    Content = "PanelText_UI_Events_Panel_Rome_StageGroup_Text_C_Resonance_Content|共鸣"
  },
  UI_Social_Item_Data_Overview_Left_Text_C_Hard = {
    ID = "UI_Social_Item_Data_Overview_Left_Text_C_Hard",
    Content = "PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Hard_Content|困难"
  },
  UI_Social_Item_Data_Overview_Left_Text_C_Normal = {
    ID = "UI_Social_Item_Data_Overview_Left_Text_C_Normal",
    Content = "PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Normal_Content|普通"
  },
  UI_Social_Item_Data_Overview_Left_Text_C_Abyss = {
    ID = "UI_Social_Item_Data_Overview_Left_Text_C_Abyss",
    Content = "PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Abyss_Content|融灾禁区"
  },
  UI_Events_Panel_Task_Text_Title = {
    ID = "UI_Events_Panel_Task_Text_Title",
    Content = "PanelText_UI_Events_Panel_Task_Text_Title_Content|扫除进度"
  },
  UI_Login_Popup_Tips_Text_Title = {
    ID = "UI_Login_Popup_Tips_Text_Title",
    Content = "PanelText_UI_Login_Popup_Tips_Text_Title_Content|公告"
  },
  UI_Login_Popup_Tips_Text_C_BugFix = {
    ID = "UI_Login_Popup_Tips_Text_C_BugFix",
    Content = "PanelText_UI_Login_Popup_Tips_Text_C_BugFix_Content|问题修复"
  },
  UI_Events_Item_Summer1_Text_C_Diagonal = {
    ID = "UI_Events_Item_Summer1_Text_C_Diagonal",
    Content = "PanelText_UI_Events_Item_Summer1_Text_C_Diagonal_Content|/"
  },
  UI_Events_Item_Summer1_Text_C_Fall = {
    ID = "UI_Events_Item_Summer1_Text_C_Fall",
    Content = "PanelText_UI_Events_Item_Summer1_Text_C_Fall_Content|掉落预览"
  },
  UI_Events_Item_Summer1_Text_C_LockTips = {
    ID = "UI_Events_Item_Summer1_Text_C_LockTips",
    Content = "PanelText_UI_Events_Item_Summer1_Text_C_LockTips_Content|关卡解锁提示"
  },
  UI_Events_Panel_Summer1_StageGroup_Text_C_Title = {
    ID = "UI_Events_Panel_Summer1_StageGroup_Text_C_Title",
    Content = "PanelText_UI_Events_Panel_Summer1_StageGroup_Text_C_Title_Content|沙滩排球赛"
  },
  UI_Events_Panel_Summer1_StageGroup_Text_C_Introduction = {
    ID = "UI_Events_Panel_Summer1_StageGroup_Text_C_Introduction",
    Content = "PanelText_UI_Events_Panel_Summer1_StageGroup_Text_C_Introduction_Content|友谊第一，比赛第二——才怪！\n在炽热的晴空下挥洒汗水，向着冠军进发！"
  },
  UI_Events_Panel_Summer1_StageGroup_Text_C_Resonance = {
    ID = "UI_Events_Panel_Summer1_StageGroup_Text_C_Resonance",
    Content = "PanelText_UI_Events_Panel_Summer1_StageGroup_Text_C_Resonance_Content|共鸣"
  },
  UI_Events_Panel_Summer1_Text_C_Shop = {
    ID = "UI_Events_Panel_Summer1_Text_C_Shop",
    Content = "PanelText_UI_Events_Panel_Summer1_Text_C_Shop_Content|海滨旅店"
  },
  UI_Events_Panel_Summer1_Text_C_Resonance = {
    ID = "UI_Events_Panel_Summer1_Text_C_Resonance",
    Content = "PanelText_UI_Events_Panel_Summer1_Text_C_Resonance_Content|共鸣：吞噬山脉"
  },
  UI_Events_Panel_Summer1_Text_C_Diagonal = {
    ID = "UI_Events_Panel_Summer1_Text_C_Diagonal",
    Content = "PanelText_UI_Events_Panel_Summer1_Text_C_Diagonal_Content|/"
  },
  UI_Events_Panel_Summer1_Text_C_Reward = {
    ID = "UI_Events_Panel_Summer1_Text_C_Reward",
    Content = "PanelText_UI_Events_Panel_Summer1_Text_C_Reward_Content|成就奖励"
  },
  UI_Events_Panel_Summer1_Text_C_Record = {
    ID = "UI_Events_Panel_Summer1_Text_C_Record",
    Content = "PanelText_UI_Events_Panel_Summer1_Text_C_Record_Content|异梦视界"
  },
  UI_Events_Panel_Summer1_Text_C_RecordTip = {
    ID = "UI_Events_Panel_Summer1_Text_C_RecordTip",
    Content = "PanelText_UI_Events_Panel_Summer1_Text_C_RecordTip_Content|限时免费解锁"
  },
  UI_Events_Panel_Summer1_Text_C_Challenge = {
    ID = "UI_Events_Panel_Summer1_Text_C_Challenge",
    Content = "PanelText_UI_Events_Panel_Summer1_Text_C_Challenge_Content|沙滩排球赛"
  },
  UI_Events_Panel_Summer1_Text_C_ChallengeTip = {
    ID = "UI_Events_Panel_Summer1_Text_C_ChallengeTip",
    Content = "PanelText_UI_Events_Panel_Summer1_Text_C_ChallengeTip_Content|玩法限时开放"
  },
  UI_Events_Panel_Summer1_Text_C_Topic = {
    ID = "UI_Events_Panel_Summer1_Text_C_Topic",
    Content = "PanelText_UI_Events_Panel_Summer1_Text_C_Topic_Content|夏日特别活动·上"
  },
  UI_Events_Panel_Summer1_Text_C_Receive = {
    ID = "UI_Events_Panel_Summer1_Text_C_Receive",
    Content = "PanelText_UI_Events_Panel_Summer1_Text_C_Receive_Content|距离可领取"
  },
  UI_Events_Panel_Summer1_Text_C_Max = {
    ID = "UI_Events_Panel_Summer1_Text_C_Max",
    Content = "PanelText_UI_Events_Panel_Summer1_Text_C_Max_Content|Max"
  },
  UI_Events_Panel_Summer1_Text_C_Symbol = {
    ID = "UI_Events_Panel_Summer1_Text_C_Symbol",
    Content = "PanelText_UI_Events_Panel_Summer1_Text_C_Symbol_Content|)"
  },
  UI_Events_Panel_Summer1_Text_C_Fill_Up = {
    ID = "UI_Events_Panel_Summer1_Text_C_Fill_Up",
    Content = "PanelText_UI_Events_Panel_Summer1_Text_C_Fill_Up_Content|(距离补满："
  },
  UI_Events_Panel_Summer1_Text_C_Can_Unlockable = {
    ID = "UI_Events_Panel_Summer1_Text_C_Can_Unlockable",
    Content = "PanelText_UI_Events_Panel_Summer1_Text_C_Can_Unlockable_Content|可领取"
  },
  UI_Events_Panel_Summer1_Text_C_Not_unlocked = {
    ID = "UI_Events_Panel_Summer1_Text_C_Not_unlocked",
    Content = "PanelText_UI_Events_Panel_Summer1_Text_C_Not_unlocked_Content|未解锁"
  },
  UI_Events_Panel_Summer1_Text_C_Finished = {
    ID = "UI_Events_Panel_Summer1_Text_C_Finished",
    Content = "PanelText_UI_Events_Panel_Summer1_Text_C_Finished_Content|已结束"
  },
  UI_Dungeous_Panel_Molten_Optimized_Text_Extra_None = {
    ID = "UI_Dungeous_Panel_Molten_Optimized_Text_Extra_None",
    Content = "PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_Extra_None_Content|尚未完成挑战"
  },
  UI_Awaker_Item_Skill_Training_Text_C_PressTip = {
    ID = "UI_Awaker_Item_Skill_Training_Text_C_PressTip",
    Content = "PanelText_UI_Awaker_Item_Skill_Training_Text_C_PressTip_Content|长按手牌可放大查看"
  },
  UI_Chapter_Spur_View_Text_C_Review = {
    ID = "UI_Chapter_Spur_View_Text_C_Review",
    Content = "PanelText_UI_Chapter_Spur_View_Text_C_Review_Content|序幕"
  },
  UI_Summon_Popup_Show_Ordinary_Text_Autofine = {
    ID = "UI_Summon_Popup_Show_Ordinary_Text_Autofine",
    Content = "PanelText_UI_Summon_Popup_Show_Ordinary_Text_Autofine_Content|自动叠位"
  },
  UI_Summon_Popup_Show_Legend_Text_Autofine = {
    ID = "UI_Summon_Popup_Show_Legend_Text_Autofine",
    Content = "PanelText_UI_Summon_Popup_Show_Legend_Text_Autofine_Content|自动叠位"
  },
  UI_Summon_Popup_Show_Rare_Text_Autofine = {
    ID = "UI_Summon_Popup_Show_Rare_Text_Autofine",
    Content = "PanelText_UI_Summon_Popup_Show_Rare_Text_Autofine_Content|自动叠位"
  },
  UI_Community_Steer_Tips_Text_Thanks_Name = {
    ID = "UI_Community_Steer_Tips_Text_Thanks_Name",
    Content = "PanelText_UI_Community_Steer_Tips_Text_Thanks_Name_Content|特别鸣谢"
  },
  UI_Community_ThanksLetter_Text_C_LetterTitle = {
    ID = "UI_Community_ThanksLetter_Text_C_LetterTitle",
    Content = "PanelText_UI_Community_ThanksLetter_Text_C_LetterTitle_Content|致尊敬的各位本地化志愿者："
  },
  UI_Community_ThanksLetter_Text_C_Signature = {
    ID = "UI_Community_ThanksLetter_Text_C_Signature",
    Content = "PanelText_UI_Community_ThanksLetter_Text_C_Signature_Content|弥萨格大学委员会"
  },
  UI_Community_ThanksLetter_Text_C_Name = {
    ID = "UI_Community_ThanksLetter_Text_C_Name",
    Content = "PanelText_UI_Community_ThanksLetter_Text_C_Name_Content|本地化志愿者"
  },
  UI_Community_ThanksLetter_Text_Prefix = {
    ID = "UI_Community_ThanksLetter_Text_Prefix",
    Content = "PanelText_UI_Community_ThanksLetter_Text_Prefix_Content|您以敏锐的语感和对游戏的热爱，将生硬的机译文本转化为鲜活的语言。正是这份无私的热忱，让全球守密人都能享受到原汁原味的《忘却前夜》。\n       弥萨格大学衷心感谢以下守密人们作出的卓越贡献："
  },
  UI_Community_ThanksLetter_Text_Suffix = {
    ID = "UI_Community_ThanksLetter_Text_Suffix",
    Content = "PanelText_UI_Community_ThanksLetter_Text_Suffix_Content|愿银钥指引我们。"
  },
  UI_Community_ThanksLetter_Text_Title = {
    ID = "UI_Community_ThanksLetter_Text_Title",
    Content = "PanelText_UI_Community_ThanksLetter_Text_Title_Content|特别鸣谢"
  },
  UI_PVP_Panel_Rotation_Adjust_Text_C_StandBy_My = {
    ID = "UI_PVP_Panel_Rotation_Adjust_Text_C_StandBy_My",
    Content = "PanelText_UI_PVP_Panel_Rotation_Adjust_Text_C_StandBy_My_Content|准备就绪！"
  },
  UI_PVP_Panel_Rotation_Adjust_Text_C_StandBy_Other = {
    ID = "UI_PVP_Panel_Rotation_Adjust_Text_C_StandBy_Other",
    Content = "PanelText_UI_PVP_Panel_Rotation_Adjust_Text_C_StandBy_Other_Content|准备就绪！"
  },
  UI_PVP_Panel_Rotation_Adjust_Text_C_Location_1 = {
    ID = "UI_PVP_Panel_Rotation_Adjust_Text_C_Location_1",
    Content = "PanelText_UI_PVP_Panel_Rotation_Adjust_Text_C_Location_1_Content|1"
  },
  UI_PVP_Panel_Rotation_Adjust_Text_C_Location_2 = {
    ID = "UI_PVP_Panel_Rotation_Adjust_Text_C_Location_2",
    Content = "PanelText_UI_PVP_Panel_Rotation_Adjust_Text_C_Location_2_Content|2"
  },
  UI_PVP_Panel_Rotation_Adjust_Text_C_Location_3 = {
    ID = "UI_PVP_Panel_Rotation_Adjust_Text_C_Location_3",
    Content = "PanelText_UI_PVP_Panel_Rotation_Adjust_Text_C_Location_3_Content|3"
  },
  UI_PVP_Panel_Rotation_Adjust_Text_C_Location_4 = {
    ID = "UI_PVP_Panel_Rotation_Adjust_Text_C_Location_4",
    Content = "PanelText_UI_PVP_Panel_Rotation_Adjust_Text_C_Location_4_Content|4"
  },
  UI_PVP_Panel_Rotation_Adjust_Text_C_Adjust = {
    ID = "UI_PVP_Panel_Rotation_Adjust_Text_C_Adjust",
    Content = "PanelText_UI_PVP_Panel_Rotation_Adjust_Text_C_Adjust_Content|点击更改唤醒体站位"
  },
  UI_PVP_Item_RotationTeamInfo_Text_C_Attack = {
    ID = "UI_PVP_Item_RotationTeamInfo_Text_C_Attack",
    Content = "PanelText_UI_PVP_Item_RotationTeamInfo_Text_C_Attack_Content|先手"
  },
  UI_PVP_Item_RotationTeamInfo_Text_C_Defend = {
    ID = "UI_PVP_Item_RotationTeamInfo_Text_C_Defend",
    Content = "PanelText_UI_PVP_Item_RotationTeamInfo_Text_C_Defend_Content|后手"
  },
  UI_PVP_Item_RotationTeamInfo_Text_C_Location_4 = {
    ID = "UI_PVP_Item_RotationTeamInfo_Text_C_Location_4",
    Content = "PanelText_UI_PVP_Item_RotationTeamInfo_Text_C_Location_4_Content|4"
  },
  UI_PVP_Item_RotationTeamInfo_Text_C_Location_3 = {
    ID = "UI_PVP_Item_RotationTeamInfo_Text_C_Location_3",
    Content = "PanelText_UI_PVP_Item_RotationTeamInfo_Text_C_Location_3_Content|3"
  },
  UI_PVP_Item_RotationTeamInfo_Text_C_Location_2 = {
    ID = "UI_PVP_Item_RotationTeamInfo_Text_C_Location_2",
    Content = "PanelText_UI_PVP_Item_RotationTeamInfo_Text_C_Location_2_Content|2"
  },
  UI_PVP_Item_RotationTeamInfo_Text_C_Location_1 = {
    ID = "UI_PVP_Item_RotationTeamInfo_Text_C_Location_1",
    Content = "PanelText_UI_PVP_Item_RotationTeamInfo_Text_C_Location_1_Content|1"
  },
  UI_PVP_Item_RotationPlayer_Text_C_HP = {
    ID = "UI_PVP_Item_RotationPlayer_Text_C_HP",
    Content = "PanelText_UI_PVP_Item_RotationPlayer_Text_C_HP_Content|血量"
  },
  UI_PVP_Panel_TeamRotation_Text_BtnName = {
    ID = "UI_PVP_Panel_TeamRotation_Text_BtnName",
    Content = "PanelText_UI_PVP_Panel_TeamRotation_Text_BtnName_Content|选定"
  },
  UI_Community_ThanksLetter_Text_C_Sincerely = {
    ID = "UI_Community_ThanksLetter_Text_C_Sincerely",
    Content = "PanelText_UI_Community_ThanksLetter_Text_C_Sincerely_Content|深表感谢"
  },
  UI_Events_Panel_Summer2_Text_C_Shop = {
    ID = "UI_Events_Panel_Summer2_Text_C_Shop",
    Content = "PanelText_UI_Events_Panel_Summer2_Text_C_Shop_Content|学生会办公楼"
  },
  UI_Events_Panel_Summer2_Text_C_Resonance = {
    ID = "UI_Events_Panel_Summer2_Text_C_Resonance",
    Content = "PanelText_UI_Events_Panel_Summer2_Text_C_Resonance_Content|共鸣：吞噬山脉"
  },
  UI_Events_Panel_Summer2_Text_C_Diagonal = {
    ID = "UI_Events_Panel_Summer2_Text_C_Diagonal",
    Content = "PanelText_UI_Events_Panel_Summer2_Text_C_Diagonal_Content|/"
  },
  UI_Events_Panel_Summer2_Text_C_Reward = {
    ID = "UI_Events_Panel_Summer2_Text_C_Reward",
    Content = "PanelText_UI_Events_Panel_Summer2_Text_C_Reward_Content|成就奖励"
  },
  UI_Events_Panel_Summer2_Text_C_Record = {
    ID = "UI_Events_Panel_Summer2_Text_C_Record",
    Content = "PanelText_UI_Events_Panel_Summer2_Text_C_Record_Content|异梦视界"
  },
  UI_Events_Panel_Summer2_Text_C_RecordTip = {
    ID = "UI_Events_Panel_Summer2_Text_C_RecordTip",
    Content = "PanelText_UI_Events_Panel_Summer2_Text_C_RecordTip_Content|限时免费解锁"
  },
  UI_Events_Panel_Summer2_Text_C_Challenge = {
    ID = "UI_Events_Panel_Summer2_Text_C_Challenge",
    Content = "PanelText_UI_Events_Panel_Summer2_Text_C_Challenge_Content|日光下新事"
  },
  UI_Events_Panel_Summer2_Text_C_ChallengeTip = {
    ID = "UI_Events_Panel_Summer2_Text_C_ChallengeTip",
    Content = "PanelText_UI_Events_Panel_Summer2_Text_C_ChallengeTip_Content|玩法限时开放"
  },
  UI_Events_Panel_Summer2_Text_C_Topic = {
    ID = "UI_Events_Panel_Summer2_Text_C_Topic",
    Content = "PanelText_UI_Events_Panel_Summer2_Text_C_Topic_Content|如果一切如常"
  },
  UI_Events_Panel_Summer2_StageGroup_Text_C_Title = {
    ID = "UI_Events_Panel_Summer2_StageGroup_Text_C_Title",
    Content = "PanelText_UI_Events_Panel_Summer2_StageGroup_Text_C_Title_Content|日光下新事"
  },
  UI_Events_Panel_Summer2_StageGroup_Text_C_Introduction = {
    ID = "UI_Events_Panel_Summer2_StageGroup_Text_C_Introduction",
    Content = "PanelText_UI_Events_Panel_Summer2_StageGroup_Text_C_Introduction_Content|暖和的阳光下，一切都如此温馨幸福。\n你望着像童话书中一样湛蓝的天空，决定亲手撕开画布，从虚假的世界破膛而出。"
  },
  UI_Events_Panel_Summer2_StageGroup_Text_C_Resonance = {
    ID = "UI_Events_Panel_Summer2_StageGroup_Text_C_Resonance",
    Content = "PanelText_UI_Events_Panel_Summer2_StageGroup_Text_C_Resonance_Content|共鸣"
  },
  UI_Events_Item_Summer2_Text_C_Diagonal = {
    ID = "UI_Events_Item_Summer2_Text_C_Diagonal",
    Content = "PanelText_UI_Events_Item_Summer2_Text_C_Diagonal_Content|/"
  },
  UI_Events_Item_Summer2_Text_C_Fall = {
    ID = "UI_Events_Item_Summer2_Text_C_Fall",
    Content = "PanelText_UI_Events_Item_Summer2_Text_C_Fall_Content|掉落预览"
  },
  UI_Events_Item_Summer2_Text_C_LockTips = {
    ID = "UI_Events_Item_Summer2_Text_C_LockTips",
    Content = "PanelText_UI_Events_Item_Summer2_Text_C_LockTips_Content|关卡解锁提示"
  },
  UI_Events_Panel_Summer2_StageGroup_Text_C_Progress = {
    ID = "UI_Events_Panel_Summer2_StageGroup_Text_C_Progress",
    Content = "PanelText_UI_Events_Panel_Summer2_StageGroup_Text_C_Progress_Content|星级进度"
  },
  UI_Events_Item_Summer2_Text_C_NormalTip = {
    ID = "UI_Events_Item_Summer2_Text_C_NormalTip",
    Content = "PanelText_UI_Events_Item_Summer2_Text_C_NormalTip_Content|普通难度待通关"
  },
  UI_Event_Panel_ChallengeDifficulty_Text_C_FristCreation = {
    ID = "UI_Event_Panel_ChallengeDifficulty_Text_C_FristCreation",
    Content = "PanelText_UI_Event_Panel_ChallengeDifficulty_Text_C_FristCreation_Content|初始造物"
  },
  UI_Event_Panel_ChallengeDifficulty_Text_C_Title = {
    ID = "UI_Event_Panel_ChallengeDifficulty_Text_C_Title",
    Content = "PanelText_UI_Event_Panel_ChallengeDifficulty_Text_C_Title_Content|剧本迷思"
  },
  UI_Event_Panel_ChallengeDifficulty_Text_C_Record = {
    ID = "UI_Event_Panel_ChallengeDifficulty_Text_C_Record",
    Content = "PanelText_UI_Event_Panel_ChallengeDifficulty_Text_C_Record_Content|挑战"
  },
  UI_Event_Panel_ChallengeDifficulty_Text_C_Leader = {
    ID = "UI_Event_Panel_ChallengeDifficulty_Text_C_Leader",
    Content = "PanelText_UI_Event_Panel_ChallengeDifficulty_Text_C_Leader_Content|首领预览"
  },
  UI_Event_Panel_ChallengeDifficulty_Text_C_Awaker = {
    ID = "UI_Event_Panel_ChallengeDifficulty_Text_C_Awaker",
    Content = "PanelText_UI_Event_Panel_ChallengeDifficulty_Text_C_Awaker_Content|试用唤醒体"
  },
  UI_Event_Panel_ChallengeDifficulty_Text_C_StarTitle = {
    ID = "UI_Event_Panel_ChallengeDifficulty_Text_C_StarTitle",
    Content = "PanelText_UI_Event_Panel_ChallengeDifficulty_Text_C_StarTitle_Content|星级目标"
  },
  UI_Bag_Panel_AppearancePreview_Text_C_BtnName = {
    ID = "UI_Bag_Panel_AppearancePreview_Text_C_BtnName",
    Content = "PanelText_UI_Bag_Panel_AppearancePreview_Text_C_BtnName_Content|领取"
  },
  UI_Events_Panel_Summer1_Text_C_Sign = {
    ID = "UI_Events_Panel_Summer1_Text_C_Sign",
    Content = "PanelText_UI_Events_Panel_Summer1_Text_C_Sign_Content|彻夏狂欢"
  },
  UI_Event_Activity_SummerSign_Text_C_Desc = {
    ID = "UI_Event_Activity_SummerSign_Text_C_Desc",
    Content = "PanelText_UI_Event_Activity_SummerSign_Text_C_Desc_Content|阳光，沙滩，海浪，还有无数张笑脸，在夏日的幻梦里，来一场充满活力的排球赛吧！"
  },
  UI_Event_Activity_SummerSign_Text_Title = {
    ID = "UI_Event_Activity_SummerSign_Text_Title",
    Content = "PanelText_UI_Event_Activity_SummerSign_Text_Title_Content|彻夏狂欢"
  },
  UI_Events_Panel_KathiguRa_Text_C_Shop = {
    ID = "UI_Events_Panel_KathiguRa_Text_C_Shop",
    Content = "PanelText_UI_Events_Panel_KathiguRa_Text_C_Shop_Content|隐秘的据点"
  },
  UI_Events_Panel_KathiguRa_Text_C_Resonance = {
    ID = "UI_Events_Panel_KathiguRa_Text_C_Resonance",
    Content = "PanelText_UI_Events_Panel_KathiguRa_Text_C_Resonance_Content|共鸣：吞噬山脉"
  },
  UI_Events_Panel_KathiguRa_Text_C_Diagonal = {
    ID = "UI_Events_Panel_KathiguRa_Text_C_Diagonal",
    Content = "PanelText_UI_Events_Panel_KathiguRa_Text_C_Diagonal_Content|/"
  },
  UI_Events_Panel_KathiguRa_Text_C_Reward = {
    ID = "UI_Events_Panel_KathiguRa_Text_C_Reward",
    Content = "PanelText_UI_Events_Panel_KathiguRa_Text_C_Reward_Content|成就奖励"
  },
  UI_Events_Panel_KathiguRa_Text_C_Record = {
    ID = "UI_Events_Panel_KathiguRa_Text_C_Record",
    Content = "PanelText_UI_Events_Panel_KathiguRa_Text_C_Record_Content|意识潜游"
  },
  UI_Events_Panel_KathiguRa_Text_C_RecordTip = {
    ID = "UI_Events_Panel_KathiguRa_Text_C_RecordTip",
    Content = "PanelText_UI_Events_Panel_KathiguRa_Text_C_RecordTip_Content|限时免费解锁"
  },
  UI_Events_Panel_KathiguRa_Text_C_Challenge = {
    ID = "UI_Events_Panel_KathiguRa_Text_C_Challenge",
    Content = "PanelText_UI_Events_Panel_KathiguRa_Text_C_Challenge_Content|烬灭追猎"
  },
  UI_Events_Panel_KathiguRa_Text_C_ChallengeTip = {
    ID = "UI_Events_Panel_KathiguRa_Text_C_ChallengeTip",
    Content = "PanelText_UI_Events_Panel_KathiguRa_Text_C_ChallengeTip_Content|玩法限时开放"
  },
  UI_Events_Panel_KathiguRa_Text_C_Topic = {
    ID = "UI_Events_Panel_KathiguRa_Text_C_Topic",
    Content = "PanelText_UI_Events_Panel_KathiguRa_Text_C_Topic_Content|坠临的万千耀光"
  },
  UI_Events_Panel_KathiguRa_Text_C_Can_Unlockable = {
    ID = "UI_Events_Panel_KathiguRa_Text_C_Can_Unlockable",
    Content = "PanelText_UI_Events_Panel_KathiguRa_Text_C_Can_Unlockable_Content|可领取"
  },
  UI_Events_Panel_KathiguRa_Text_C_Max = {
    ID = "UI_Events_Panel_KathiguRa_Text_C_Max",
    Content = "PanelText_UI_Events_Panel_KathiguRa_Text_C_Max_Content|Max"
  },
  UI_Events_Panel_KathiguRa_Text_C_Fill_Up = {
    ID = "UI_Events_Panel_KathiguRa_Text_C_Fill_Up",
    Content = "PanelText_UI_Events_Panel_KathiguRa_Text_C_Fill_Up_Content|(距离存储上限："
  },
  UI_Events_Panel_KathiguRa_Text_C_Symbol = {
    ID = "UI_Events_Panel_KathiguRa_Text_C_Symbol",
    Content = "PanelText_UI_Events_Panel_KathiguRa_Text_C_Symbol_Content|)"
  },
  UI_Events_Panel_KathiguRa_Text_C_Not_unlocked = {
    ID = "UI_Events_Panel_KathiguRa_Text_C_Not_unlocked",
    Content = "PanelText_UI_Events_Panel_KathiguRa_Text_C_Not_unlocked_Content|未解锁"
  },
  UI_Events_Panel_KathiguRa_Text_C_Finished = {
    ID = "UI_Events_Panel_KathiguRa_Text_C_Finished",
    Content = "PanelText_UI_Events_Panel_KathiguRa_Text_C_Finished_Content|已结束"
  },
  UI_Events_Panel_KathiguRa_Text_C_Receive = {
    ID = "UI_Events_Panel_KathiguRa_Text_C_Receive",
    Content = "PanelText_UI_Events_Panel_KathiguRa_Text_C_Receive_Content|距离可领取"
  },
  UI_Events_Panel_KathiguRa_StageGroup_Text_C_Title = {
    ID = "UI_Events_Panel_KathiguRa_StageGroup_Text_C_Title",
    Content = "PanelText_UI_Events_Panel_KathiguRa_StageGroup_Text_C_Title_Content|烬灭追猎"
  },
  UI_Events_Panel_KathiguRa_StageGroup_Text_C_Introduction = {
    ID = "UI_Events_Panel_KathiguRa_StageGroup_Text_C_Introduction",
    Content = "PanelText_UI_Events_Panel_KathiguRa_StageGroup_Text_C_Introduction_Content|她再次屹立于大地之上，烬灭一切的复仇便如约而至。\n\\n那是永不停息的追猎，那是爆燃之主的炙火。\n\\n她将行过每一个角落，猎杀所有与死神签订契约之徒。\n\\n逃吧，逃吧，逃到更深的黑暗中去吧，逃到自以为不会被找到的地方去吧。\n\\n尽管这毫无意义，因为祂终将踏过每一个世界。\n\\n祂会猎尽所有，直至一切烬灭如灰。"
  },
  UI_Events_Panel_KathiguRa_StageGroup_Text_C_Resonance = {
    ID = "UI_Events_Panel_KathiguRa_StageGroup_Text_C_Resonance",
    Content = "PanelText_UI_Events_Panel_KathiguRa_StageGroup_Text_C_Resonance_Content|共鸣"
  },
  UI_Events_Item_KathiguRa_Text_C_Diagonal = {
    ID = "UI_Events_Item_KathiguRa_Text_C_Diagonal",
    Content = "PanelText_UI_Events_Item_KathiguRa_Text_C_Diagonal_Content|/"
  },
  UI_Events_Item_KathiguRa_Text_C_Fall = {
    ID = "UI_Events_Item_KathiguRa_Text_C_Fall",
    Content = "PanelText_UI_Events_Item_KathiguRa_Text_C_Fall_Content|掉落预览"
  },
  UI_Events_Item_KathiguRa_Text_C_LockTips = {
    ID = "UI_Events_Item_KathiguRa_Text_C_LockTips",
    Content = "PanelText_UI_Events_Item_KathiguRa_Text_C_LockTips_Content|关卡解锁提示"
  },
  UI_Event_Activity_KathiguRa_Text_C_Reward = {
    ID = "UI_Event_Activity_KathiguRa_Text_C_Reward",
    Content = "PanelText_UI_Event_Activity_KathiguRa_Text_C_Reward_Content|获得物资"
  },
  UI_Event_Activity_KathiguRa_Text_C_Full = {
    ID = "UI_Event_Activity_KathiguRa_Text_C_Full",
    Content = "PanelText_UI_Event_Activity_KathiguRa_Text_C_Full_Content|当前已达存储上限"
  },
  UI_Event_Activity_KathiguRa_Text_C_Finish = {
    ID = "UI_Event_Activity_KathiguRa_Text_C_Finish",
    Content = "PanelText_UI_Event_Activity_KathiguRa_Text_C_Finish_Content|活动已结束，已停止获取"
  },
  UI_Event_Activity_KathiguRa_Text_C_Max = {
    ID = "UI_Event_Activity_KathiguRa_Text_C_Max",
    Content = "PanelText_UI_Event_Activity_KathiguRa_Text_C_Max_Content|Max"
  },
  UI_Event_Activity_KathiguRa_Text_C_SpeedTitle = {
    ID = "UI_Event_Activity_KathiguRa_Text_C_SpeedTitle",
    Content = "PanelText_UI_Event_Activity_KathiguRa_Text_C_SpeedTitle_Content|存储速度:"
  },
  UI_Event_Activity_KathiguRa_Text_None = {
    ID = "UI_Event_Activity_KathiguRa_Text_None",
    Content = "PanelText_UI_Event_Activity_KathiguRa_Text_None_Content|暂无物资"
  },
  UI_InvitationCode_Item_Player_Text_Name = {
    ID = "UI_InvitationCode_Item_Player_Text_Name",
    Content = "PanelText_UI_InvitationCode_Item_Player_Text_Name_Content|领取"
  },
  UI_InvitationCode_Popup_PlayerList_Text_C_Title = {
    ID = "UI_InvitationCode_Popup_PlayerList_Text_C_Title",
    Content = "PanelText_UI_InvitationCode_Popup_PlayerList_Text_C_Title_Content|邀请列表"
  },
  UI_InvitationCode_Popup_PlayerList_Text_C_OneKey = {
    ID = "UI_InvitationCode_Popup_PlayerList_Text_C_OneKey",
    Content = "PanelText_UI_InvitationCode_Popup_PlayerList_Text_C_OneKey_Content|一键领取"
  },
  UI_InvitationCode_Popup_Main_Text_C_Invite_Nor = {
    ID = "UI_InvitationCode_Popup_Main_Text_C_Invite_Nor",
    Content = "PanelText_UI_InvitationCode_Popup_Main_Text_C_Invite_Nor_Content|邀请活动"
  },
  UI_InvitationCode_Popup_Main_Text_C_Invite_High = {
    ID = "UI_InvitationCode_Popup_Main_Text_C_Invite_High",
    Content = "PanelText_UI_InvitationCode_Popup_Main_Text_C_Invite_High_Content|邀请活动"
  },
  UI_InvitationCode_Popup_Main_Text_C_Binding_Nor = {
    ID = "UI_InvitationCode_Popup_Main_Text_C_Binding_Nor",
    Content = "PanelText_UI_InvitationCode_Popup_Main_Text_C_Binding_Nor_Content|绑定邀请"
  },
  UI_InvitationCode_Popup_Main_Text_C_Binding_High = {
    ID = "UI_InvitationCode_Popup_Main_Text_C_Binding_High",
    Content = "PanelText_UI_InvitationCode_Popup_Main_Text_C_Binding_High_Content|绑定邀请"
  },
  UI_InvitationCode_Popup_Main_Text_C_Share = {
    ID = "UI_InvitationCode_Popup_Main_Text_C_Share",
    Content = "PanelText_UI_InvitationCode_Popup_Main_Text_C_Share_Content|分享"
  },
  UI_InvitationCode_Popup_Main_Text_C_illustrate = {
    ID = "UI_InvitationCode_Popup_Main_Text_C_illustrate",
    Content = "PanelText_UI_InvitationCode_Popup_Main_Text_C_illustrate_Content|活动说明"
  },
  UI_InvitationCode_Popup_Main_Text_C_Desc = {
    ID = "UI_InvitationCode_Popup_Main_Text_C_Desc",
    Content = "PanelText_UI_InvitationCode_Popup_Main_Text_C_Desc_Content|复制邀请码，引领无限宇宙中的灵魂共赴融蚀之旅。"
  },
  UI_InvitationCode_Popup_Main_Text_C_Condition = {
    ID = "UI_InvitationCode_Popup_Main_Text_C_Condition",
    Content = "PanelText_UI_InvitationCode_Popup_Main_Text_C_Condition_Content|被邀的守密人在等级达到5/10/15/20级后，可获得银钥辉光奖励。"
  },
  UI_InvitationCode_Popup_Main_Text_C_MyCode = {
    ID = "UI_InvitationCode_Popup_Main_Text_C_MyCode",
    Content = "PanelText_UI_InvitationCode_Popup_Main_Text_C_MyCode_Content|我的邀请码"
  },
  UI_InvitationCode_Popup_Main_Text_C_InviteCount = {
    ID = "UI_InvitationCode_Popup_Main_Text_C_InviteCount",
    Content = "PanelText_UI_InvitationCode_Popup_Main_Text_C_InviteCount_Content|已邀请人数"
  },
  UI_InvitationCode_Popup_Main_Text_C_Copy = {
    ID = "UI_InvitationCode_Popup_Main_Text_C_Copy",
    Content = "PanelText_UI_InvitationCode_Popup_Main_Text_C_Copy_Content|复制"
  },
  UI_InvitationCode_Popup_Main_Text_C_Value = {
    ID = "UI_InvitationCode_Popup_Main_Text_C_Value",
    Content = "PanelText_UI_InvitationCode_Popup_Main_Text_C_Value_Content|银钥辉光"
  },
  UI_InvitationCode_Popup_Main_Text_C_BindingTip = {
    ID = "UI_InvitationCode_Popup_Main_Text_C_BindingTip",
    Content = "PanelText_UI_InvitationCode_Popup_Main_Text_C_BindingTip_Content|绑定引路守密人，在无数银钥闪烁的宇宙中，你并不寂寞。"
  },
  UI_InvitationCode_Popup_Main_Text_C_InputTip = {
    ID = "UI_InvitationCode_Popup_Main_Text_C_InputTip",
    Content = "PanelText_UI_InvitationCode_Popup_Main_Text_C_InputTip_Content|填写好友专属邀请码，即可立即领取"
  },
  UI_InvitationCode_Popup_Main_Text_C_InvitedCount = {
    ID = "UI_InvitationCode_Popup_Main_Text_C_InvitedCount",
    Content = "PanelText_UI_InvitationCode_Popup_Main_Text_C_InvitedCount_Content|300！"
  },
  UI_InvitationCode_Popup_Main_Text_C_Tips = {
    ID = "UI_InvitationCode_Popup_Main_Text_C_Tips",
    Content = "PanelText_UI_InvitationCode_Popup_Main_Text_C_Tips_Content|输入邀请码"
  },
  UI_InvitationCode_Popup_Main_Text_C_Paste = {
    ID = "UI_InvitationCode_Popup_Main_Text_C_Paste",
    Content = "PanelText_UI_InvitationCode_Popup_Main_Text_C_Paste_Content|粘贴"
  },
  UI_InvitationCode_Popup_Main_Text_C_Clean = {
    ID = "UI_InvitationCode_Popup_Main_Text_C_Clean",
    Content = "PanelText_UI_InvitationCode_Popup_Main_Text_C_Clean_Content|清除"
  },
  UI_InvitationCode_Popup_Main_Text_Title = {
    ID = "UI_InvitationCode_Popup_Main_Text_Title",
    Content = "PanelText_UI_InvitationCode_Popup_Main_Text_Title_Content|邀请活动"
  },
  UI_InvitationCode_Popup_PlayerList_Text_C_Title2 = {
    ID = "UI_InvitationCode_Popup_PlayerList_Text_C_Title2",
    Content = "PanelText_UI_InvitationCode_Popup_PlayerList_Text_C_Title2_Content|去其他地方看看吧"
  },
  UI_InvitationCode_Popup_PlayerList_Text_C_Null = {
    ID = "UI_InvitationCode_Popup_PlayerList_Text_C_Null",
    Content = "PanelText_UI_InvitationCode_Popup_PlayerList_Text_C_Null_Content|暂无达到Lv.5的受邀守密人"
  },
  UI_Awaker_Popup_Exchange_Tip_Text_C_Need = {
    ID = "UI_Awaker_Popup_Exchange_Tip_Text_C_Need",
    Content = "PanelText_UI_Awaker_Popup_Exchange_Tip_Text_C_Need_Content|需要"
  },
  UI_Awaker_Popup_Exchange_Tip_Text_Title = {
    ID = "UI_Awaker_Popup_Exchange_Tip_Text_Title",
    Content = "PanelText_UI_Awaker_Popup_Exchange_Tip_Text_Title_Content|补全提示"
  },
  UI_Awaker_Popup_Exchange_Tip_Text_Cancel_Name = {
    ID = "UI_Awaker_Popup_Exchange_Tip_Text_Cancel_Name",
    Content = "PanelText_UI_Awaker_Popup_Exchange_Tip_Text_Cancel_Name_Content|取消"
  },
  UI_Awaker_Popup_Exchange_Tip_Text_Confirm_Name = {
    ID = "UI_Awaker_Popup_Exchange_Tip_Text_Confirm_Name",
    Content = "PanelText_UI_Awaker_Popup_Exchange_Tip_Text_Confirm_Name_Content|确定"
  },
  UI_Awaker_Popup_Trinket_Upgrade_Text_C_Exchange = {
    ID = "UI_Awaker_Popup_Trinket_Upgrade_Text_C_Exchange",
    Content = "PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_Exchange_Content|置换设置"
  },
  UI_Awaker_Popup_Trinket_Conversion_Text_C_Exchange = {
    ID = "UI_Awaker_Popup_Trinket_Conversion_Text_C_Exchange",
    Content = "PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_Exchange_Content|置换设置"
  },
  UI_Alchemy_Popup_MyTeam_Awaker_List_Optimize_Text_Btn_Save = {
    ID = "UI_Alchemy_Popup_MyTeam_Awaker_List_Optimize_Text_Btn_Save",
    Content = "PanelText_UI_Alchemy_Popup_MyTeam_Awaker_List_Optimize_Text_Btn_Save_Content|保存"
  },
  UI_Dungeons_Panel_Try_Text_C_Star_Awaker = {
    ID = "UI_Dungeons_Panel_Try_Text_C_Star_Awaker",
    Content = "PanelText_UI_Dungeons_Panel_Try_Text_C_Star_Awaker_Content|星辰篇·限定"
  },
  UI_Awaker_Popup_Backtrace_Tip_Text_Time = {
    ID = "UI_Awaker_Popup_Backtrace_Tip_Text_Time",
    Content = "PanelText_UI_Awaker_Popup_Backtrace_Tip_Text_Time_Content|去其他地方看看吧"
  },
  UI_Collection_Item_Music_Alone_Text_C_Normal = {
    ID = "UI_Collection_Item_Music_Alone_Text_C_Normal",
    Content = "PanelText_UI_Collection_Item_Music_Alone_Text_C_Normal_Content|设为背景音乐"
  },
  UI_Collection_Item_Music_Alone_Text_C_High = {
    ID = "UI_Collection_Item_Music_Alone_Text_C_High",
    Content = "PanelText_UI_Collection_Item_Music_Alone_Text_C_High_Content|重置背景音乐"
  },
  UI_Awaker_Popup_Exchange_Tip_Text_Tip = {
    ID = "UI_Awaker_Popup_Exchange_Tip_Text_Tip",
    Content = "PanelText_UI_Awaker_Popup_Exchange_Tip_Text_Tip_Content|当前所需材料不足，是否消耗以下材料进行补全？"
  },
  UI_Recharge_Courtesy_Item_Text_C_DiscountMultipleTitle = {
    ID = "UI_Recharge_Courtesy_Item_Text_C_DiscountMultipleTitle",
    Content = "PanelText_UI_Recharge_Courtesy_Item_Text_C_DiscountMultipleTitle_Content|超值"
  },
  UI_Recharge_Courtesy_Item_Text_C_Haved = {
    ID = "UI_Recharge_Courtesy_Item_Text_C_Haved",
    Content = "PanelText_UI_Recharge_Courtesy_Item_Text_C_Haved_Content|已拥有"
  },
  UI_Pvp_Panel_Main_1_Text_C_Pvp = {
    ID = "UI_Pvp_Panel_Main_1_Text_C_Pvp",
    Content = "PanelText_UI_Pvp_Panel_Main_1_Text_C_Pvp_Content|预组模式"
  },
  UI_Pvp_Panel_Main_1_Text_C_Pvp_Score = {
    ID = "UI_Pvp_Panel_Main_1_Text_C_Pvp_Score",
    Content = "PanelText_UI_Pvp_Panel_Main_1_Text_C_Pvp_Score_Content|积分"
  },
  UI_Pvp_Panel_Main_1_Text_C_RotationMode = {
    ID = "UI_Pvp_Panel_Main_1_Text_C_RotationMode",
    Content = "PanelText_UI_Pvp_Panel_Main_1_Text_C_RotationMode_Content|轮选模式"
  },
  UI_Pvp_Panel_Main_1_Text_C_RotationMode_Score = {
    ID = "UI_Pvp_Panel_Main_1_Text_C_RotationMode_Score",
    Content = "PanelText_UI_Pvp_Panel_Main_1_Text_C_RotationMode_Score_Content|积分"
  },
  UI_Pvp_Panel_Main_1_Text_C_Speed = {
    ID = "UI_Pvp_Panel_Main_1_Text_C_Speed",
    Content = "PanelText_UI_Pvp_Panel_Main_1_Text_C_Speed_Content|精准匹配"
  },
  UI_Pvp_Panel_Main_1_Text_C_Close_Speed = {
    ID = "UI_Pvp_Panel_Main_1_Text_C_Close_Speed",
    Content = "PanelText_UI_Pvp_Panel_Main_1_Text_C_Close_Speed_Content|关闭"
  },
  UI_Pvp_Panel_Main_1_Text_C_Open_Speed = {
    ID = "UI_Pvp_Panel_Main_1_Text_C_Open_Speed",
    Content = "PanelText_UI_Pvp_Panel_Main_1_Text_C_Open_Speed_Content|开启"
  },
  UI_Pvp_Panel_Main_1_Text_C_Robot = {
    ID = "UI_Pvp_Panel_Main_1_Text_C_Robot",
    Content = "PanelText_UI_Pvp_Panel_Main_1_Text_C_Robot_Content|模拟对手"
  },
  UI_Pvp_Panel_Main_1_Text_C_Close_Robot = {
    ID = "UI_Pvp_Panel_Main_1_Text_C_Close_Robot",
    Content = "PanelText_UI_Pvp_Panel_Main_1_Text_C_Close_Robot_Content|关闭"
  },
  UI_Pvp_Panel_Main_1_Text_C_Open_Robot = {
    ID = "UI_Pvp_Panel_Main_1_Text_C_Open_Robot",
    Content = "PanelText_UI_Pvp_Panel_Main_1_Text_C_Open_Robot_Content|开启"
  },
  UI_Pvp_Panel_Main_1_Text_C_CardEdit = {
    ID = "UI_Pvp_Panel_Main_1_Text_C_CardEdit",
    Content = "PanelText_UI_Pvp_Panel_Main_1_Text_C_CardEdit_Content|预组编队"
  },
  UI_Social_Panel_Main_Item_Text_Unfollow = {
    ID = "UI_Social_Panel_Main_Item_Text_Unfollow",
    Content = "PanelText_UI_Social_Panel_Main_Item_Text_Unfollow_Content|取消关注"
  },
  UI_Social_Popup_MatchMode_Text_C_FriendlyMatch_Name = {
    ID = "UI_Social_Popup_MatchMode_Text_C_FriendlyMatch_Name",
    Content = "PanelText_UI_Social_Popup_MatchMode_Text_C_FriendlyMatch_Name_Content|预组模式"
  },
  UI_Social_Popup_MatchMode_Text_C_FriendlyMatch_Desc = {
    ID = "UI_Social_Popup_MatchMode_Text_C_FriendlyMatch_Desc",
    Content = "PanelText_UI_Social_Popup_MatchMode_Text_C_FriendlyMatch_Desc_Content|<size=25>相位对弈的基础模式，双方使用预先准备的队伍进行对战。</size>"
  },
  UI_Social_Popup_MatchMode_Text_C_FriendlyMatch = {
    ID = "UI_Social_Popup_MatchMode_Text_C_FriendlyMatch",
    Content = "PanelText_UI_Social_Popup_MatchMode_Text_C_FriendlyMatch_Content|选择"
  },
  UI_Social_Popup_MatchMode_Text_C_RotationMode_Name = {
    ID = "UI_Social_Popup_MatchMode_Text_C_RotationMode_Name",
    Content = "PanelText_UI_Social_Popup_MatchMode_Text_C_RotationMode_Name_Content|轮选模式"
  },
  UI_Social_Popup_MatchMode_Text_C_RotationMode_Desc = {
    ID = "UI_Social_Popup_MatchMode_Text_C_RotationMode_Desc",
    Content = "PanelText_UI_Social_Popup_MatchMode_Text_C_RotationMode_Desc_Content|<size=25>相位对弈的进阶模式，双方轮流在随机卡池内选取卡牌，组成卡组进行对战。</size>"
  },
  UI_Social_Popup_MatchMode_Text_C_RotationMode = {
    ID = "UI_Social_Popup_MatchMode_Text_C_RotationMode",
    Content = "PanelText_UI_Social_Popup_MatchMode_Text_C_RotationMode_Content|选择"
  },
  UI_Social_Popup_MatchMode_Text_Title = {
    ID = "UI_Social_Popup_MatchMode_Text_Title",
    Content = "PanelText_UI_Social_Popup_MatchMode_Text_Title_Content|选择模式"
  },
  UI_Pvp_Popup_Tips_Text_C_Rank_Pvp = {
    ID = "UI_Pvp_Popup_Tips_Text_C_Rank_Pvp",
    Content = "PanelText_UI_Pvp_Popup_Tips_Text_C_Rank_Pvp_Content|预组模式"
  },
  UI_Pvp_Popup_Tips_Text_C_Rank_RotationMode = {
    ID = "UI_Pvp_Popup_Tips_Text_C_Rank_RotationMode",
    Content = "PanelText_UI_Pvp_Popup_Tips_Text_C_Rank_RotationMode_Content|轮选模式"
  },
  UI_Awaker_Item_Voice_Text_C_Pvp_Normal = {
    ID = "UI_Awaker_Item_Voice_Text_C_Pvp_Normal",
    Content = "PanelText_UI_Awaker_Item_Voice_Text_C_Pvp_Normal_Content|相位对弈"
  },
  UI_Awaker_Item_Voice_Text_C_Pvp_Select = {
    ID = "UI_Awaker_Item_Voice_Text_C_Pvp_Select",
    Content = "PanelText_UI_Awaker_Item_Voice_Text_C_Pvp_Select_Content|相位对弈"
  },
  UI_Social_Panel_Main_SubPanel_1_Text_C_Concern = {
    ID = "UI_Social_Panel_Main_SubPanel_1_Text_C_Concern",
    Content = "PanelText_UI_Social_Panel_Main_SubPanel_1_Text_C_Concern_Content|新增"
  },
  UI_Social_Item_Data_Overview_Left_Text_NickNamePre = {
    ID = "UI_Social_Item_Data_Overview_Left_Text_NickNamePre",
    Content = "PanelText_UI_Social_Item_Data_Overview_Left_Text_NickNamePre_Content|备注 :"
  },
  UI_Awaker_Item_Skill_Training_Text_C_High = {
    ID = "UI_Awaker_Item_Skill_Training_Text_C_High",
    Content = "PanelText_UI_Awaker_Item_Skill_Training_Text_C_High_Content|显示当前"
  },
  UI_Awaker_Item_Skill_Training_Text_C_Normal = {
    ID = "UI_Awaker_Item_Skill_Training_Text_C_Normal",
    Content = "PanelText_UI_Awaker_Item_Skill_Training_Text_C_Normal_Content|满级预览"
  },
  UI_Awaker_Item_Info_Text_C_Grade = {
    ID = "UI_Awaker_Item_Info_Text_C_Grade",
    Content = "PanelText_UI_Awaker_Item_Info_Text_C_Grade_Content|等级"
  },
  UI_Awaker_Item_Info_Text_C_High = {
    ID = "UI_Awaker_Item_Info_Text_C_High",
    Content = "PanelText_UI_Awaker_Item_Info_Text_C_High_Content|显示当前"
  },
  UI_Awaker_Item_Info_Text_C_Normal = {
    ID = "UI_Awaker_Item_Info_Text_C_Normal",
    Content = "PanelText_UI_Awaker_Item_Info_Text_C_Normal_Content|60级预览"
  },
  UI_Awaker_Popup_Talent_Main_Text_C_High = {
    ID = "UI_Awaker_Popup_Talent_Main_Text_C_High",
    Content = "PanelText_UI_Awaker_Popup_Talent_Main_Text_C_High_Content|显示当前"
  },
  UI_Awaker_Popup_Talent_Main_Text_C_Normal = {
    ID = "UI_Awaker_Popup_Talent_Main_Text_C_Normal",
    Content = "PanelText_UI_Awaker_Popup_Talent_Main_Text_C_Normal_Content|满级预览"
  },
  UI_Pvp_Panel_Main_1_Text_C_Password = {
    ID = "UI_Pvp_Panel_Main_1_Text_C_Password",
    Content = "PanelText_UI_Pvp_Panel_Main_1_Text_C_Password_Content|密码对战"
  },
  UI_Pvp_Popup_Fight_Text_Title = {
    ID = "UI_Pvp_Popup_Fight_Text_Title",
    Content = "PanelText_UI_Pvp_Popup_Fight_Text_Title_Content|密码对战"
  },
  UI_Pvp_Popup_PasswordMatch_Text_C_Wait = {
    ID = "UI_Pvp_Popup_PasswordMatch_Text_C_Wait",
    Content = "PanelText_UI_Pvp_Popup_PasswordMatch_Text_C_Wait_Content|等待中…"
  },
  UI_Pvp_Popup_PasswordMatch_Text_C_Cancel = {
    ID = "UI_Pvp_Popup_PasswordMatch_Text_C_Cancel",
    Content = "PanelText_UI_Pvp_Popup_PasswordMatch_Text_C_Cancel_Content|取消"
  },
  UI_Pvp_Popup_PasswordMatch_Text_C_Copy = {
    ID = "UI_Pvp_Popup_PasswordMatch_Text_C_Copy",
    Content = "PanelText_UI_Pvp_Popup_PasswordMatch_Text_C_Copy_Content|复制相位值"
  },
  UI_Pvp_Popup_PasswordMatch_Text_Title = {
    ID = "UI_Pvp_Popup_PasswordMatch_Text_Title",
    Content = "PanelText_UI_Pvp_Popup_PasswordMatch_Text_Title_Content|密码对战"
  },
  UI_Pvp_Popup_Fight_Text_C_Create = {
    ID = "UI_Pvp_Popup_Fight_Text_C_Create",
    Content = "PanelText_UI_Pvp_Popup_Fight_Text_C_Create_Content|创建对战"
  },
  UI_Pvp_Popup_Fight_Text_C_Joinin = {
    ID = "UI_Pvp_Popup_Fight_Text_C_Joinin",
    Content = "PanelText_UI_Pvp_Popup_Fight_Text_C_Joinin_Content|加入对战"
  },
  UI_Pvp_Popup_PasswordReady_Text_C_Wait = {
    ID = "UI_Pvp_Popup_PasswordReady_Text_C_Wait",
    Content = "PanelText_UI_Pvp_Popup_PasswordReady_Text_C_Wait_Content|等待对方准备…"
  },
  UI_Pvp_Popup_PasswordReady_Text_C_Cancel = {
    ID = "UI_Pvp_Popup_PasswordReady_Text_C_Cancel",
    Content = "PanelText_UI_Pvp_Popup_PasswordReady_Text_C_Cancel_Content|取消"
  },
  UI_Pvp_Popup_PasswordReady_Text_C_Ready = {
    ID = "UI_Pvp_Popup_PasswordReady_Text_C_Ready",
    Content = "PanelText_UI_Pvp_Popup_PasswordReady_Text_C_Ready_Content|准备"
  },
  UI_Pvp_Popup_PasswordReady_Text_C_Done = {
    ID = "UI_Pvp_Popup_PasswordReady_Text_C_Done",
    Content = "PanelText_UI_Pvp_Popup_PasswordReady_Text_C_Done_Content|已关注我"
  },
  UI_Pvp_Popup_PasswordReady_Text_C_Mutual = {
    ID = "UI_Pvp_Popup_PasswordReady_Text_C_Mutual",
    Content = "PanelText_UI_Pvp_Popup_PasswordReady_Text_C_Mutual_Content|互相关注"
  },
  UI_Pvp_Popup_PasswordCode_Text_C_Cancel = {
    ID = "UI_Pvp_Popup_PasswordCode_Text_C_Cancel",
    Content = "PanelText_UI_Pvp_Popup_PasswordCode_Text_C_Cancel_Content|取消"
  },
  UI_Pvp_Popup_PasswordCode_Text_C_Confirm = {
    ID = "UI_Pvp_Popup_PasswordCode_Text_C_Confirm",
    Content = "PanelText_UI_Pvp_Popup_PasswordCode_Text_C_Confirm_Content|确定"
  },
  UI_Pvp_Popup_PasswordCode_Text_Title = {
    ID = "UI_Pvp_Popup_PasswordCode_Text_Title",
    Content = "PanelText_UI_Pvp_Popup_PasswordCode_Text_Title_Content|输入相位值"
  },
  UI_Pvp_Popup_PasswordCode_Placeholder = {
    ID = "UI_Pvp_Popup_PasswordCode_Placeholder",
    Content = "PanelText_UI_Pvp_Popup_PasswordCode_Placeholder_Content|输入 6 位 <color=#5EF2FF>相位值</color>"
  },
  UI_Pvp_Popup_PasswordReady_Text_C_Reject = {
    ID = "UI_Pvp_Popup_PasswordReady_Text_C_Reject",
    Content = "PanelText_UI_Pvp_Popup_PasswordReady_Text_C_Reject_Content|拒绝"
  },
  UI_Collection_Panel_World_Text_Progress = {
    ID = "UI_Collection_Panel_World_Text_Progress",
    Content = "PanelText_UI_Collection_Panel_World_Text_Progress_Content|收集进度"
  },
  UI_Chaper_Popup_BsetPlot_Text_C_Joinin = {
    ID = "UI_Chaper_Popup_BsetPlot_Text_C_Joinin",
    Content = "PanelText_UI_Chaper_Popup_BsetPlot_Text_C_Joinin_Content|建议完成以下调查关卡"
  },
  UI_Chaper_Popup_BsetPlot_Text_C_Cancel = {
    ID = "UI_Chaper_Popup_BsetPlot_Text_C_Cancel",
    Content = "PanelText_UI_Chaper_Popup_BsetPlot_Text_C_Cancel_Content|退出"
  },
  UI_Chaper_Popup_BsetPlot_Text_C_Confirm = {
    ID = "UI_Chaper_Popup_BsetPlot_Text_C_Confirm",
    Content = "PanelText_UI_Chaper_Popup_BsetPlot_Text_C_Confirm_Content|仍要调查"
  },
  UI_Chaper_Popup_BsetPlot_Text_C_Screening = {
    ID = "UI_Chaper_Popup_BsetPlot_Text_C_Screening",
    Content = "PanelText_UI_Chaper_Popup_BsetPlot_Text_C_Screening_Content|今日不再提醒"
  },
  UI_Dungeons_Panel_Out_Text_C_Statistics = {
    ID = "UI_Dungeons_Panel_Out_Text_C_Statistics",
    Content = "PanelText_UI_Dungeons_Panel_Out_Text_C_Statistics_Content|战斗统计"
  },
  UI_Pvp_Item_Collection_Comment_Text_C_Done = {
    ID = "UI_Pvp_Item_Collection_Comment_Text_C_Done",
    Content = "PanelText_UI_Pvp_Item_Collection_Comment_Text_C_Done_Content|已关注我"
  },
  UI_Pvp_Item_Collection_Comment_Text_C_Mutual = {
    ID = "UI_Pvp_Item_Collection_Comment_Text_C_Mutual",
    Content = "PanelText_UI_Pvp_Item_Collection_Comment_Text_C_Mutual_Content|互相关注"
  },
  UI_Pvp_Tip_Comment_Text_C_Title = {
    ID = "UI_Pvp_Tip_Comment_Text_C_Title",
    Content = "PanelText_UI_Pvp_Tip_Comment_Text_C_Title_Content|评论详情"
  },
  UI_Pvp_Tip_Comment_Text_C_Done = {
    ID = "UI_Pvp_Tip_Comment_Text_C_Done",
    Content = "PanelText_UI_Pvp_Tip_Comment_Text_C_Done_Content|已关注我"
  },
  UI_Pvp_Tip_Comment_Text_C_Mutual = {
    ID = "UI_Pvp_Tip_Comment_Text_C_Mutual",
    Content = "PanelText_UI_Pvp_Tip_Comment_Text_C_Mutual_Content|互相关注"
  },
  UI_Pvp_Tip_Comment_Text_C_Proficiency = {
    ID = "UI_Pvp_Tip_Comment_Text_C_Proficiency",
    Content = "PanelText_UI_Pvp_Tip_Comment_Text_C_Proficiency_Content|累计胜场"
  },
  UI_Pvp_Tip_Comment_Text_C_Save = {
    ID = "UI_Pvp_Tip_Comment_Text_C_Save",
    Content = "PanelText_UI_Pvp_Tip_Comment_Text_C_Save_Content|删除"
  },
  UI_Pvp_Tip_Comment_Text_C_Remove = {
    ID = "UI_Pvp_Tip_Comment_Text_C_Remove",
    Content = "PanelText_UI_Pvp_Tip_Comment_Text_C_Remove_Content|编辑"
  },
  UI_Pvp_Panel_Collection_Comment_Text_C_NoTask = {
    ID = "UI_Pvp_Panel_Collection_Comment_Text_C_NoTask",
    Content = "PanelText_UI_Pvp_Panel_Collection_Comment_Text_C_NoTask_Content|暂无评论"
  },
  UI_Pvp_Panel_Collection_Comment_Text_C_En = {
    ID = "UI_Pvp_Panel_Collection_Comment_Text_C_En",
    Content = "PanelText_UI_Pvp_Panel_Collection_Comment_Text_C_En_Content|fdshsjfgjgf"
  },
  UI_Pvp_Panel_Collection_Comment_Text_Time = {
    ID = "UI_Pvp_Panel_Collection_Comment_Text_Time",
    Content = "PanelText_UI_Pvp_Panel_Collection_Comment_Text_Time_Content|作出第一个评论吧"
  },
  UI_Chapter_Item_Dream_04_Text_C_Free_Unlock = {
    ID = "UI_Chapter_Item_Dream_04_Text_C_Free_Unlock",
    Content = "PanelText_UI_Chapter_Item_Dream_04_Text_C_Free_Unlock_Content|限时免费解锁"
  },
  UI_Events_Panel_Pickman_StageGroup_Text_C_Title = {
    ID = "UI_Events_Panel_Pickman_StageGroup_Text_C_Title",
    Content = "PanelText_UI_Events_Panel_Pickman_StageGroup_Text_C_Title_Content|异界图卷"
  },
  UI_Events_Panel_Pickman_StageGroup_Text_C_Introduction = {
    ID = "UI_Events_Panel_Pickman_StageGroup_Text_C_Introduction",
    Content = "PanelText_UI_Events_Panel_Pickman_StageGroup_Text_C_Introduction_Content|理智与崩溃之间，诡谲的绘卷徐徐展开。\n你唾弃的幻觉，绘就绮丽的色彩，\n你畏惧的失控，构成忠诚的形式。\n在这里，疯狂是艺术的本能，是世界的根源，\n是唯一不会撒谎的真实。"
  },
  UI_Events_Panel_Pickman_StageGroup_Text_C_Resonance = {
    ID = "UI_Events_Panel_Pickman_StageGroup_Text_C_Resonance",
    Content = "PanelText_UI_Events_Panel_Pickman_StageGroup_Text_C_Resonance_Content|共鸣"
  },
  UI_Events_Item_Pickman_Text_C_Diagonal = {
    ID = "UI_Events_Item_Pickman_Text_C_Diagonal",
    Content = "PanelText_UI_Events_Item_Pickman_Text_C_Diagonal_Content|/"
  },
  UI_Events_Item_Pickman_Text_C_Fall = {
    ID = "UI_Events_Item_Pickman_Text_C_Fall",
    Content = "PanelText_UI_Events_Item_Pickman_Text_C_Fall_Content|掉落预览"
  },
  UI_Events_Item_Pickman_Text_C_LockTips = {
    ID = "UI_Events_Item_Pickman_Text_C_LockTips",
    Content = "PanelText_UI_Events_Item_Pickman_Text_C_LockTips_Content|关卡解锁提示"
  },
  UI_Events_Panel_Pickman_Text_C_Shop = {
    ID = "UI_Events_Panel_Pickman_Text_C_Shop",
    Content = "PanelText_UI_Events_Panel_Pickman_Text_C_Shop_Content|皮克曼的画室"
  },
  UI_Events_Panel_Pickman_Text_C_Resonance = {
    ID = "UI_Events_Panel_Pickman_Text_C_Resonance",
    Content = "PanelText_UI_Events_Panel_Pickman_Text_C_Resonance_Content|共鸣：吞噬山脉"
  },
  UI_Events_Panel_Pickman_Text_C_Diagonal = {
    ID = "UI_Events_Panel_Pickman_Text_C_Diagonal",
    Content = "PanelText_UI_Events_Panel_Pickman_Text_C_Diagonal_Content|/"
  },
  UI_Events_Panel_Pickman_Text_C_Reward = {
    ID = "UI_Events_Panel_Pickman_Text_C_Reward",
    Content = "PanelText_UI_Events_Panel_Pickman_Text_C_Reward_Content|成就奖励"
  },
  UI_Events_Panel_Pickman_Text_C_Record = {
    ID = "UI_Events_Panel_Pickman_Text_C_Record",
    Content = "PanelText_UI_Events_Panel_Pickman_Text_C_Record_Content|意识潜游"
  },
  UI_Events_Panel_Pickman_Text_C_RecordTip = {
    ID = "UI_Events_Panel_Pickman_Text_C_RecordTip",
    Content = "PanelText_UI_Events_Panel_Pickman_Text_C_RecordTip_Content|限时免费解锁"
  },
  UI_Events_Panel_Pickman_Text_C_Challenge = {
    ID = "UI_Events_Panel_Pickman_Text_C_Challenge",
    Content = "PanelText_UI_Events_Panel_Pickman_Text_C_Challenge_Content|异界图卷"
  },
  UI_Events_Panel_Pickman_Text_C_ChallengeTip = {
    ID = "UI_Events_Panel_Pickman_Text_C_ChallengeTip",
    Content = "PanelText_UI_Events_Panel_Pickman_Text_C_ChallengeTip_Content|玩法限时开放"
  },
  UI_Events_Panel_Pickman_Text_C_Topic = {
    ID = "UI_Events_Panel_Pickman_Text_C_Topic",
    Content = "PanelText_UI_Events_Panel_Pickman_Text_C_Topic_Content|画布的暗面"
  },
  UI_Chapter_Item_Dream_05_Text_C_Chaoter = {
    ID = "UI_Chapter_Item_Dream_05_Text_C_Chaoter",
    Content = "PanelText_UI_Chapter_Item_Dream_05_Text_C_Chaoter_Content|Dream View"
  },
  UI_Chapter_Item_Dream_05_Text_C_Free_Unlock = {
    ID = "UI_Chapter_Item_Dream_05_Text_C_Free_Unlock",
    Content = "PanelText_UI_Chapter_Item_Dream_05_Text_C_Free_Unlock_Content|限时免费解锁"
  },
  UI_Pvp_Panel_Collection_Detail_Text_C_Role_TotalWins = {
    ID = "UI_Pvp_Panel_Collection_Detail_Text_C_Role_TotalWins",
    Content = "PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_Role_TotalWins_Content|总胜场"
  },
  UI_Pvp_Panel_Collection_Detail_Text_C_TotalWins = {
    ID = "UI_Pvp_Panel_Collection_Detail_Text_C_TotalWins",
    Content = "PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_TotalWins_Content|总胜场"
  },
  UI_Pvp_Panel_Collection_Rank_Text_C_NoTask = {
    ID = "UI_Pvp_Panel_Collection_Rank_Text_C_NoTask",
    Content = "PanelText_UI_Pvp_Panel_Collection_Rank_Text_C_NoTask_Content|暂无记录"
  },
  UI_Pvp_Panel_Collection_Rank_Text_C_En = {
    ID = "UI_Pvp_Panel_Collection_Rank_Text_C_En",
    Content = "PanelText_UI_Pvp_Panel_Collection_Rank_Text_C_En_Content|fdshsjfgjgf"
  },
  UI_Pvp_Panel_Collection_Rank_Text_C_TotalWins = {
    ID = "UI_Pvp_Panel_Collection_Rank_Text_C_TotalWins",
    Content = "PanelText_UI_Pvp_Panel_Collection_Rank_Text_C_TotalWins_Content|总胜场"
  },
  UI_Pvp_Panel_Collection_Rank_Text_C_SeasonWins = {
    ID = "UI_Pvp_Panel_Collection_Rank_Text_C_SeasonWins",
    Content = "PanelText_UI_Pvp_Panel_Collection_Rank_Text_C_SeasonWins_Content|本月胜场"
  },
  UI_Dungeons_Popup_BattleStatistics_Text_C_Title = {
    ID = "UI_Dungeons_Popup_BattleStatistics_Text_C_Title",
    Content = "PanelText_UI_Dungeons_Popup_BattleStatistics_Text_C_Title_Content|战斗统计"
  },
  UI_Dungeons_Popup_BattleStatistics_Text_C_Awaker = {
    ID = "UI_Dungeons_Popup_BattleStatistics_Text_C_Awaker",
    Content = "PanelText_UI_Dungeons_Popup_BattleStatistics_Text_C_Awaker_Content|出战"
  },
  UI_Dungeons_Popup_BattleStatistics_Text_C_Damage = {
    ID = "UI_Dungeons_Popup_BattleStatistics_Text_C_Damage",
    Content = "PanelText_UI_Dungeons_Popup_BattleStatistics_Text_C_Damage_Content|造成伤害"
  },
  UI_Dungeons_Popup_BattleStatistics_Text_C_Shield = {
    ID = "UI_Dungeons_Popup_BattleStatistics_Text_C_Shield",
    Content = "PanelText_UI_Dungeons_Popup_BattleStatistics_Text_C_Shield_Content|造成护盾"
  },
  UI_Dungeons_Popup_BattleStatistics_Text_C_Heal = {
    ID = "UI_Dungeons_Popup_BattleStatistics_Text_C_Heal",
    Content = "PanelText_UI_Dungeons_Popup_BattleStatistics_Text_C_Heal_Content|造成治疗"
  },
  UI_Main_Popup_ActiveTasks_Text_C_Title = {
    ID = "UI_Main_Popup_ActiveTasks_Text_C_Title",
    Content = "PanelText_UI_Main_Popup_ActiveTasks_Text_C_Title_Content|常训任务"
  },
  UI_Main_Popup_ActiveTasks_Text_C_OneKey = {
    ID = "UI_Main_Popup_ActiveTasks_Text_C_OneKey",
    Content = "PanelText_UI_Main_Popup_ActiveTasks_Text_C_OneKey_Content|一键领取"
  },
  UI_Dungeons_Panel_SurveyData_Text_C_Name = {
    ID = "UI_Dungeons_Panel_SurveyData_Text_C_Name"
  },
  UI_Dungeons_Panel_SurveyData_Text_C_Resonance = {
    ID = "UI_Dungeons_Panel_SurveyData_Text_C_Resonance",
    Content = "PanelText_UI_Dungeons_Panel_SurveyData_Text_C_Resonance_Content|共鸣"
  },
  UI_Dungeons_Panel_SurveyData_Text_C_Tab_Double = {
    ID = "UI_Dungeons_Panel_SurveyData_Text_C_Tab_Double"
  },
  UI_Dungeons_Panel_SurveyData_Text_C_GroupNew = {
    ID = "UI_Dungeons_Panel_SurveyData_Text_C_GroupNew"
  },
  UI_Dungeons_Panel_SurveyData_Text_C_New = {
    ID = "UI_Dungeons_Panel_SurveyData_Text_C_New"
  },
  UI_Dbgcopy_Popup_ReplaceAwaker_Text_C_Title = {
    ID = "UI_Dbgcopy_Popup_ReplaceAwaker_Text_C_Title",
    Content = "PanelText_UI_Dbgcopy_Popup_ReplaceAwaker_Text_C_Title_Content|选择更换角色"
  },
  UI_Dbgcopy_Popup_ReplaceAwaker_Text_C_Replace = {
    ID = "UI_Dbgcopy_Popup_ReplaceAwaker_Text_C_Replace",
    Content = "PanelText_UI_Dbgcopy_Popup_ReplaceAwaker_Text_C_Replace_Content|替换角色"
  },
  UI_Dbgcopy_Popup_ReplaceAwaker_Text_C_TeamAwaker = {
    ID = "UI_Dbgcopy_Popup_ReplaceAwaker_Text_C_TeamAwaker",
    Content = "PanelText_UI_Dbgcopy_Popup_ReplaceAwaker_Text_C_TeamAwaker_Content|当前队内角色"
  },
  UI_Dbgcopy_Popup_ReplaceAwaker_Text_C_Confirm = {
    ID = "UI_Dbgcopy_Popup_ReplaceAwaker_Text_C_Confirm",
    Content = "PanelText_UI_Dbgcopy_Popup_ReplaceAwaker_Text_C_Confirm_Content|确定"
  },
  UI_Dungeons_RogueStage_View_Text_C_Title = {
    ID = "UI_Dungeons_RogueStage_View_Text_C_Title",
    Content = "PanelText_UI_Dungeons_RogueStage_View_Text_C_Title_Content|尖塔肉鸽"
  },
  UI_Dungeons_RogueStage_View_Text_C_Award = {
    ID = "UI_Dungeons_RogueStage_View_Text_C_Award",
    Content = "PanelText_UI_Dungeons_RogueStage_View_Text_C_Award_Content|奖励预览"
  },
  UI_Dungeons_RogueStage_View_Text_C_Resonance = {
    ID = "UI_Dungeons_RogueStage_View_Text_C_Resonance",
    Content = "PanelText_UI_Dungeons_RogueStage_View_Text_C_Resonance_Content|共鸣"
  },
  UI_Dungeons_RogueStage_View_Text_C_Resonance_2 = {
    ID = "UI_Dungeons_RogueStage_View_Text_C_Resonance_2",
    Content = "PanelText_UI_Dungeons_RogueStage_View_Text_C_Resonance_2_Content|共鸣"
  },
  UI_Dungeons_Rogue_View_Text_C_Name = {
    ID = "UI_Dungeons_Rogue_View_Text_C_Name",
    Content = "PanelText_UI_Dungeons_Rogue_View_Text_C_Name_Content|尖塔肉鸽"
  },
  UI_Dungeons_Rogue_View_Text_C_NoTask = {
    ID = "UI_Dungeons_Rogue_View_Text_C_NoTask",
    Content = "PanelText_UI_Dungeons_Rogue_View_Text_C_NoTask_Content|虚位以待"
  },
  UI_Dungeons_Rogue_View_Text_C_En = {
    ID = "UI_Dungeons_Rogue_View_Text_C_En",
    Content = "PanelText_UI_Dungeons_Rogue_View_Text_C_En_Content|fdshsjfgjgf"
  },
  UI_Dungeons_Rogue_View_Text_C_Award = {
    ID = "UI_Dungeons_Rogue_View_Text_C_Award",
    Content = "PanelText_UI_Dungeons_Rogue_View_Text_C_Award_Content|奖励预览"
  },
  UI_Dungeons_Rogue_View_Text_C_Challenge = {
    ID = "UI_Dungeons_Rogue_View_Text_C_Challenge",
    Content = "PanelText_UI_Dungeons_Rogue_View_Text_C_Challenge_Content|标准模式"
  },
  UI_Dungeons_Rogue_View_Text_C_Daily = {
    ID = "UI_Dungeons_Rogue_View_Text_C_Daily",
    Content = "PanelText_UI_Dungeons_Rogue_View_Text_C_Daily_Content|每日挑战"
  },
  UI_Dungeons_Panel_Daily_Challenge_Text_C_Record = {
    ID = "UI_Dungeons_Panel_Daily_Challenge_Text_C_Record",
    Content = "PanelText_UI_Dungeons_Panel_Daily_Challenge_Text_C_Record_Content|本周成绩"
  },
  UI_Dungeons_Panel_Daily_Challenge_Text_C_Highest = {
    ID = "UI_Dungeons_Panel_Daily_Challenge_Text_C_Highest",
    Content = "PanelText_UI_Dungeons_Panel_Daily_Challenge_Text_C_Highest_Content|本赛季最高分"
  },
  UI_Dungeons_Panel_Daily_Challenge_Text_C_Title = {
    ID = "UI_Dungeons_Panel_Daily_Challenge_Text_C_Title",
    Content = "PanelText_UI_Dungeons_Panel_Daily_Challenge_Text_C_Title_Content|调查等级头衔"
  },
  UI_Dungeons_Popup_List_Tip_Text_C_Season1 = {
    ID = "UI_Dungeons_Popup_List_Tip_Text_C_Season1",
    Content = "PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Season1_Content|赛季排行"
  },
  UI_Dungeons_Popup_List_Tip_Text_C_Season2 = {
    ID = "UI_Dungeons_Popup_List_Tip_Text_C_Season2",
    Content = "PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Season2_Content|赛季排行"
  },
  UI_Awaker_Item_Weapon_Strengthen2_Text_C_BackTraceTip = {
    ID = "UI_Awaker_Item_Weapon_Strengthen2_Text_C_BackTraceTip",
    Content = "PanelText_UI_Awaker_Item_Weapon_Strengthen2_Text_C_BackTraceTip_Content|使用「叠位回溯」后，无法再进行「黑池归还」。"
  },
  UI_Event_Activity_Pollux_Text_None = {
    ID = "UI_Event_Activity_Pollux_Text_None",
    Content = "PanelText_UI_Event_Activity_Pollux_Text_None_Content|暂无物资"
  },
  UI_Events_Item_Pollux_Text_C_Diagonal = {
    ID = "UI_Events_Item_Pollux_Text_C_Diagonal",
    Content = "PanelText_UI_Events_Item_Pollux_Text_C_Diagonal_Content|/"
  },
  UI_Events_Item_Pollux_Text_C_Fall = {
    ID = "UI_Events_Item_Pollux_Text_C_Fall",
    Content = "PanelText_UI_Events_Item_Pollux_Text_C_Fall_Content|掉落预览"
  },
  UI_Events_Item_Pollux_Text_C_LockTips = {
    ID = "UI_Events_Item_Pollux_Text_C_LockTips",
    Content = "PanelText_UI_Events_Item_Pollux_Text_C_LockTips_Content|关卡解锁提示"
  },
  UI_Events_Panel_Pollux_Text_C_Shop = {
    ID = "UI_Events_Panel_Pollux_Text_C_Shop",
    Content = "PanelText_UI_Events_Panel_Pollux_Text_C_Shop_Content|赐福仪式"
  },
  UI_Events_Panel_Pollux_Text_C_Symbol = {
    ID = "UI_Events_Panel_Pollux_Text_C_Symbol",
    Content = "PanelText_UI_Events_Panel_Pollux_Text_C_Symbol_Content|)"
  },
  UI_Events_Panel_Pollux_Text_C_Resonance = {
    ID = "UI_Events_Panel_Pollux_Text_C_Resonance",
    Content = "PanelText_UI_Events_Panel_Pollux_Text_C_Resonance_Content|共鸣：吞噬山脉"
  },
  UI_Events_Panel_Pollux_Text_C_Diagonal = {
    ID = "UI_Events_Panel_Pollux_Text_C_Diagonal",
    Content = "PanelText_UI_Events_Panel_Pollux_Text_C_Diagonal_Content|/"
  },
  UI_Events_Panel_Pollux_Text_C_Fill_Up = {
    ID = "UI_Events_Panel_Pollux_Text_C_Fill_Up",
    Content = "PanelText_UI_Events_Panel_Pollux_Text_C_Fill_Up_Content|(距离补满："
  },
  UI_Events_Panel_Pollux_Text_C_Finished = {
    ID = "UI_Events_Panel_Pollux_Text_C_Finished",
    Content = "PanelText_UI_Events_Panel_Pollux_Text_C_Finished_Content|已结束"
  },
  UI_Events_Panel_Pollux_Text_C_Max = {
    ID = "UI_Events_Panel_Pollux_Text_C_Max",
    Content = "PanelText_UI_Events_Panel_Pollux_Text_C_Max_Content|Max"
  },
  UI_Events_Panel_Pollux_Text_C_Not_unlocked = {
    ID = "UI_Events_Panel_Pollux_Text_C_Not_unlocked",
    Content = "PanelText_UI_Events_Panel_Pollux_Text_C_Not_unlocked_Content|未解锁"
  },
  UI_Events_Panel_Pollux_Text_C_Receive = {
    ID = "UI_Events_Panel_Pollux_Text_C_Receive",
    Content = "PanelText_UI_Events_Panel_Pollux_Text_C_Receive_Content|距离可领取"
  },
  UI_Events_Panel_Pollux_Text_C_Reward = {
    ID = "UI_Events_Panel_Pollux_Text_C_Reward",
    Content = "PanelText_UI_Events_Panel_Pollux_Text_C_Reward_Content|成就奖励"
  },
  UI_Events_Panel_Pollux_Text_C_Record = {
    ID = "UI_Events_Panel_Pollux_Text_C_Record",
    Content = "PanelText_UI_Events_Panel_Pollux_Text_C_Record_Content|天边之外·下"
  },
  UI_Events_Panel_Pollux_Text_C_RecordTip = {
    ID = "UI_Events_Panel_Pollux_Text_C_RecordTip",
    Content = "PanelText_UI_Events_Panel_Pollux_Text_C_RecordTip_Content|限时免费解锁"
  },
  UI_Events_Panel_Pollux_Text_C_Challenge = {
    ID = "UI_Events_Panel_Pollux_Text_C_Challenge",
    Content = "PanelText_UI_Events_Panel_Pollux_Text_C_Challenge_Content|交融的苦血"
  },
  UI_Events_Panel_Pollux_Text_C_ChallengeTip = {
    ID = "UI_Events_Panel_Pollux_Text_C_ChallengeTip",
    Content = "PanelText_UI_Events_Panel_Pollux_Text_C_ChallengeTip_Content|玩法限时开放"
  },
  UI_Events_Panel_Pollux_Text_C_Topic = {
    ID = "UI_Events_Panel_Pollux_Text_C_Topic",
    Content = "PanelText_UI_Events_Panel_Pollux_Text_C_Topic_Content|极昼的终夜"
  },
  UI_Events_Panel_Pollux_StageGroup_Text_C_Title = {
    ID = "UI_Events_Panel_Pollux_StageGroup_Text_C_Title",
    Content = "PanelText_UI_Events_Panel_Pollux_StageGroup_Text_C_Title_Content|交融的苦血"
  },
  UI_Events_Panel_Pollux_Text_C_Can_Unlockable = {
    ID = "UI_Events_Panel_Pollux_Text_C_Can_Unlockable",
    Content = "PanelText_UI_Events_Panel_Pollux_Text_C_Can_Unlockable_Content|可领取"
  },
  UI_Events_Panel_Pollux_StageGroup_Text_C_Introduction = {
    ID = "UI_Events_Panel_Pollux_StageGroup_Text_C_Introduction",
    Content = "PanelText_UI_Events_Panel_Pollux_StageGroup_Text_C_Introduction_Content|那些恨与爱，温情与伤害，曾拥有的与错过的，早已纠缠不能理清。\n就让我们相同的骨血流淌吧，它们将汇聚在一处，构成我们不可分割的命运。"
  },
  UI_Events_Panel_Pollux_StageGroup_Text_C_Resonance = {
    ID = "UI_Events_Panel_Pollux_StageGroup_Text_C_Resonance",
    Content = "PanelText_UI_Events_Panel_Pollux_StageGroup_Text_C_Resonance_Content|共鸣"
  },
  UI_Events_Panel_Try_Text_C_Summon = {
    ID = "UI_Events_Panel_Try_Text_C_Summon",
    Content = "PanelText_UI_Events_Panel_Try_Text_C_Summon_Content|前往唤醒"
  },
  UI_Dungeous_Panel_Difficulty_Optimized_Text_C_Creation = {
    ID = "UI_Dungeous_Panel_Difficulty_Optimized_Text_C_Creation",
    Content = "PanelText_UI_Dungeous_Panel_Difficulty_Optimized_Text_C_Creation_Content|关卡造物"
  },
  UI_Dungeous_Panel_Difficulty_Optimized_Text_C_Score = {
    ID = "UI_Dungeous_Panel_Difficulty_Optimized_Text_C_Score",
    Content = "PanelText_UI_Dungeous_Panel_Difficulty_Optimized_Text_C_Score_Content|本赛季最高分"
  },
  UI_Dungeous_Panel_Difficulty_Optimized_Text_C_Award = {
    ID = "UI_Dungeous_Panel_Difficulty_Optimized_Text_C_Award",
    Content = "PanelText_UI_Dungeous_Panel_Difficulty_Optimized_Text_C_Award_Content|首领预览"
  },
  UI_Dungeous_Panel_Difficulty_Optimized_Text_C_Reward = {
    ID = "UI_Dungeous_Panel_Difficulty_Optimized_Text_C_Reward",
    Content = "PanelText_UI_Dungeous_Panel_Difficulty_Optimized_Text_C_Reward_Content|奖励预览"
  },
  UI_Dungeous_Panel_Difficulty_Optimized_Text_C_Special = {
    ID = "UI_Dungeous_Panel_Difficulty_Optimized_Text_C_Special",
    Content = "PanelText_UI_Dungeous_Panel_Difficulty_Optimized_Text_C_Special_Content|初始造物"
  },
  UI_Dungeous_Panel_Difficulty_Optimized_Text_C_Boundaries_Tips = {
    ID = "UI_Dungeous_Panel_Difficulty_Optimized_Text_C_Boundaries_Tips",
    Content = "PanelText_UI_Dungeous_Panel_Difficulty_Optimized_Text_C_Boundaries_Tips_Content|推荐界域"
  },
  UI_Pvp_Tip_Comment_Text_C_Copy = {
    ID = "UI_Pvp_Tip_Comment_Text_C_Copy",
    Content = "PanelText_UI_Pvp_Tip_Comment_Text_C_Copy_Content|复制"
  },
  UI_Battle_Tip_Backtrack_Text_C_Title = {
    ID = "UI_Battle_Tip_Backtrack_Text_C_Title",
    Content = "PanelText_UI_Battle_Tip_Backtrack_Text_C_Title_Content|时序逆行"
  },
  UI_Battle_Tip_Backtrack_Text_C_Cancel = {
    ID = "UI_Battle_Tip_Backtrack_Text_C_Cancel",
    Content = "PanelText_UI_Battle_Tip_Backtrack_Text_C_Cancel_Content|取消"
  },
  UI_Battle_Tip_Backtrack_Text_C_Sure = {
    ID = "UI_Battle_Tip_Backtrack_Text_C_Sure",
    Content = "PanelText_UI_Battle_Tip_Backtrack_Text_C_Sure_Content|确定"
  },
  UI_Battle_Tip_Backtrack_Text_C_Lock = {
    ID = "UI_Battle_Tip_Backtrack_Text_C_Lock",
    Content = "PanelText_UI_Battle_Tip_Backtrack_Text_C_Lock_Content|时序逆行可将战斗倒退回过去回合"
  },
  UI_Social_Item_Data_Overview_Left_Text_C_Collection = {
    ID = "UI_Social_Item_Data_Overview_Left_Text_C_Collection",
    Content = "PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Collection_Content|典藏进度"
  },
  UI_Collection_Panel_Main_Text_C_Progress = {
    ID = "UI_Collection_Panel_Main_Text_C_Progress",
    Content = "PanelText_UI_Collection_Panel_Main_Text_C_Progress_Content|收集进度"
  },
  UI_Summon_Popup_Total_Show_Text_Confirm_Name = {
    ID = "UI_Summon_Popup_Total_Show_Text_Confirm_Name",
    Content = "PanelText_UI_Summon_Popup_Total_Show_Text_Confirm_Name_Content|确定"
  },
  UI_Summon_Popup_Total_Show_Text_Toggle = {
    ID = "UI_Summon_Popup_Total_Show_Text_Toggle",
    Content = "PanelText_UI_Summon_Popup_Total_Show_Text_Toggle_Content|快速唤醒"
  },
  UI_Summon_Popup_Total_Show_Text_ReSummon = {
    ID = "UI_Summon_Popup_Total_Show_Text_ReSummon",
    Content = "PanelText_UI_Summon_Popup_Total_Show_Text_ReSummon_Content|唤醒5次"
  },
  UI_Pvp_Popup_ImportTeam_Text_C_Title = {
    ID = "UI_Pvp_Popup_ImportTeam_Text_C_Title",
    Content = "PanelText_UI_Pvp_Popup_ImportTeam_Text_C_Title_Content|导入编队"
  },
  UI_Pvp_Popup_ImportTeam_Text_C_Location_4 = {
    ID = "UI_Pvp_Popup_ImportTeam_Text_C_Location_4",
    Content = "PanelText_UI_Pvp_Popup_ImportTeam_Text_C_Location_4_Content|4"
  },
  UI_Pvp_Popup_ImportTeam_Text_C_Location_3 = {
    ID = "UI_Pvp_Popup_ImportTeam_Text_C_Location_3",
    Content = "PanelText_UI_Pvp_Popup_ImportTeam_Text_C_Location_3_Content|3"
  },
  UI_Pvp_Popup_ImportTeam_Text_C_Location_2 = {
    ID = "UI_Pvp_Popup_ImportTeam_Text_C_Location_2",
    Content = "PanelText_UI_Pvp_Popup_ImportTeam_Text_C_Location_2_Content|2"
  },
  UI_Pvp_Popup_ImportTeam_Text_C_Location_1 = {
    ID = "UI_Pvp_Popup_ImportTeam_Text_C_Location_1",
    Content = "PanelText_UI_Pvp_Popup_ImportTeam_Text_C_Location_1_Content|1"
  },
  UI_Pvp_Popup_ImportTeam_Text_C_Cancel = {
    ID = "UI_Pvp_Popup_ImportTeam_Text_C_Cancel",
    Content = "PanelText_UI_Pvp_Popup_ImportTeam_Text_C_Cancel_Content|取消"
  },
  UI_Pvp_Popup_ImportTeam_Text_C_Confirm = {
    ID = "UI_Pvp_Popup_ImportTeam_Text_C_Confirm",
    Content = "PanelText_UI_Pvp_Popup_ImportTeam_Text_C_Confirm_Content|确定"
  },
  UI_Social_Panel_HelpList_Filter_Text_C_Selected = {
    ID = "UI_Social_Panel_HelpList_Filter_Text_C_Selected",
    Content = "PanelText_UI_Social_Panel_HelpList_Filter_Text_C_Selected_Content|已选"
  },
  UI_Summon_Popup_Total_Show_Text_Name = {
    ID = "UI_Summon_Popup_Total_Show_Text_Name",
    Content = "PanelText_UI_Summon_Popup_Total_Show_Text_Name_Content|重新唤醒"
  },
  UI_Battle_Panel_Dbg_Text_C_Auto_Nor = {
    ID = "UI_Battle_Panel_Dbg_Text_C_Auto_Nor",
    Content = "PanelText_UI_Battle_Panel_Dbg_Text_C_Auto_Nor_Content|AUTO"
  },
  UI_Battle_Panel_Dbg_Text_C_Auto_Dis = {
    ID = "UI_Battle_Panel_Dbg_Text_C_Auto_Dis",
    Content = "PanelText_UI_Battle_Panel_Dbg_Text_C_Auto_Dis_Content|AUTO"
  },
  UI_Recharge_Panel_Main_Text_C_Stamina_Title = {
    ID = "UI_Recharge_Panel_Main_Text_C_Stamina_Title",
    Content = "PanelText_UI_Recharge_Panel_Main_Text_C_Stamina_Title_Content|鞘内补给"
  },
  UI_Recharge_Panel_Main_Text_C_Stamina_Get1_Title = {
    ID = "UI_Recharge_Panel_Main_Text_C_Stamina_Get1_Title",
    Content = "PanelText_UI_Recharge_Panel_Main_Text_C_Stamina_Get1_Title_Content|立即获得"
  },
  UI_Recharge_Panel_Main_Text_C_Stamina_Tips = {
    ID = "UI_Recharge_Panel_Main_Text_C_Stamina_Tips",
    Content = "PanelText_UI_Recharge_Panel_Main_Text_C_Stamina_Tips_Content|每日随邮件赠送（30天）"
  },
  UI_Recharge_Panel_Main_Text_C_Stamina_Need = {
    ID = "UI_Recharge_Panel_Main_Text_C_Stamina_Need",
    Content = "PanelText_UI_Recharge_Panel_Main_Text_C_Stamina_Need_Content|需要"
  },
  UI_Recharge_Panel_Main_Text_C_Stamina_Illustrate = {
    ID = "UI_Recharge_Panel_Main_Text_C_Stamina_Illustrate",
    Content = "PanelText_UI_Recharge_Panel_Main_Text_C_Stamina_Illustrate_Content|玩法规则"
  },
  UI_Events_Panel_2ndAnnivWorldBoss_Text_C_ProgressTitle = {
    ID = "UI_Events_Panel_2ndAnnivWorldBoss_Text_C_ProgressTitle",
    Content = "PanelText_UI_Events_Panel_2ndAnnivWorldBoss_Text_C_ProgressTitle_Content|世界击杀进度"
  },
  UI_Events_Panel_2ndAnnivWorldBoss_Text_C_Challenge = {
    ID = "UI_Events_Panel_2ndAnnivWorldBoss_Text_C_Challenge",
    Content = "PanelText_UI_Events_Panel_2ndAnnivWorldBoss_Text_C_Challenge_Content|辰星安魂曲"
  },
  UI_Events_2ndAnnivWB_StageGroup_Text_C_Title = {
    ID = "UI_Events_2ndAnnivWB_StageGroup_Text_C_Title",
    Content = "PanelText_UI_Events_2ndAnnivWB_StageGroup_Text_C_Title_Content|辰星安魂曲"
  },
  UI_Events_2ndAnnivWB_StageGroup_Text_C_Introduction = {
    ID = "UI_Events_2ndAnnivWB_StageGroup_Text_C_Introduction",
    Content = "PanelText_UI_Events_2ndAnnivWB_StageGroup_Text_C_Introduction_Content|来，以疯狂、杀戮与痛苦为音符，颂奏这闪烁于辰星间的安魂曲吧。 \n那痴愚混沌的至高存在，不该苏醒，无论是此刻，还是未来。"
  },
  UI_Passport_Money_Item_New_Text_C_Privilege = {
    ID = "UI_Passport_Money_Item_New_Text_C_Privilege",
    Content = "PanelText_UI_Passport_Money_Item_New_Text_C_Privilege_Content|本期课题持续期间拥有特权"
  },
  UI_Passport_Money_Item_New_Text_C_Privilege_1 = {
    ID = "UI_Passport_Money_Item_New_Text_C_Privilege_1",
    Content = "PanelText_UI_Passport_Money_Item_New_Text_C_Privilege_1_Content|基础活性\n三倍奖励"
  },
  UI_Passport_Money_Item_New_Text_C_Privilege_2 = {
    ID = "UI_Passport_Money_Item_New_Text_C_Privilege_2",
    Content = "PanelText_UI_Passport_Money_Item_New_Text_C_Privilege_2_Content|战斗回合\n回溯"
  },
  UI_Passport_Money_Item_New_Text_C_Privilege_3 = {
    ID = "UI_Passport_Money_Item_New_Text_C_Privilege_3",
    Content = "PanelText_UI_Passport_Money_Item_New_Text_C_Privilege_3_Content|相位对弈\n全卡畅玩"
  },
  UI_Main_Helicopter_Tips_Text_ResetBg = {
    ID = "UI_Main_Helicopter_Tips_Text_ResetBg",
    Content = "PanelText_UI_Main_Helicopter_Tips_Text_ResetBg_Content|默认音画"
  },
  UI_Main_Panel_1_Text_Abyss = {
    ID = "UI_Main_Panel_1_Text_Abyss",
    Content = "PanelText_UI_Main_Panel_1_Text_Abyss_Content|融灾禁区"
  },
  UI_Main_Panel_1_Text_Diving = {
    ID = "UI_Main_Panel_1_Text_Diving",
    Content = "PanelText_UI_Main_Panel_1_Text_Diving_Content|幻梦深潜"
  },
  UI_Social_Item_Pvp_Text_C_En = {
    ID = "UI_Social_Item_Pvp_Text_C_En",
    Content = "PanelText_UI_Social_Item_Pvp_Text_C_En_Content|fdshsjfgjgf"
  },
  UI_Social_Item_Pvp_Text_C_Pve_Nor = {
    ID = "UI_Social_Item_Pvp_Text_C_Pve_Nor",
    Content = "PanelText_UI_Social_Item_Pvp_Text_C_Pve_Nor_Content|调查行动"
  },
  UI_Social_Item_Pvp_Text_C_Pve_Sel = {
    ID = "UI_Social_Item_Pvp_Text_C_Pve_Sel",
    Content = "PanelText_UI_Social_Item_Pvp_Text_C_Pve_Sel_Content|调查行动"
  },
  UI_Social_Item_Pvp_Text_C_Pvp_Nor = {
    ID = "UI_Social_Item_Pvp_Text_C_Pvp_Nor",
    Content = "PanelText_UI_Social_Item_Pvp_Text_C_Pvp_Nor_Content|相位对弈"
  },
  UI_Social_Item_Pvp_Text_C_Pvp_Sel = {
    ID = "UI_Social_Item_Pvp_Text_C_Pvp_Sel",
    Content = "PanelText_UI_Social_Item_Pvp_Text_C_Pvp_Sel_Content|相位对弈"
  },
  UI_Social_Item_Pvp_Text_C_Input = {
    ID = "UI_Social_Item_Pvp_Text_C_Input",
    Content = "PanelText_UI_Social_Item_Pvp_Text_C_Input_Content|输入「战斗记录」可查看回放"
  },
  UI_Social_Item_Pvp_Text_C_Search = {
    ID = "UI_Social_Item_Pvp_Text_C_Search",
    Content = "PanelText_UI_Social_Item_Pvp_Text_C_Search_Content|观看回放"
  },
  UI_Social_Item_PveRecord_Text_Victory = {
    ID = "UI_Social_Item_PveRecord_Text_Victory",
    Content = "PanelText_UI_Social_Item_PveRecord_Text_Victory_Content|胜利"
  },
  UI_Social_Item_PveRecord_Text_Fail = {
    ID = "UI_Social_Item_PveRecord_Text_Fail",
    Content = "PanelText_UI_Social_Item_PveRecord_Text_Fail_Content|失败"
  },
  UI_Dungeons_Popup_AbyssRank_Text_C_Replay = {
    ID = "UI_Dungeons_Popup_AbyssRank_Text_C_Replay",
    Content = "PanelText_UI_Dungeons_Popup_AbyssRank_Text_C_Replay_Content|记录回放"
  },
  UI_Event_Panel_Challenge_Text_C_Replay = {
    ID = "UI_Event_Panel_Challenge_Text_C_Replay",
    Content = "PanelText_UI_Event_Panel_Challenge_Text_C_Replay_Content|记录"
  },
  UI_Dungeous_Panel_Realms_New_Text_C_Special = {
    ID = "UI_Dungeous_Panel_Realms_New_Text_C_Special",
    Content = "PanelText_UI_Dungeous_Panel_Realms_New_Text_C_Special_Content|初始造物"
  },
  UI_Dungeous_Panel_Realms_New_Text_C_Cost_Tips = {
    ID = "UI_Dungeous_Panel_Realms_New_Text_C_Cost_Tips",
    Content = "PanelText_UI_Dungeous_Panel_Realms_New_Text_C_Cost_Tips_Content|队伍要求："
  },
  UI_Dungeous_Panel_Realms_New_Text_C_Award = {
    ID = "UI_Dungeous_Panel_Realms_New_Text_C_Award",
    Content = "PanelText_UI_Dungeous_Panel_Realms_New_Text_C_Award_Content|敌方详情"
  },
  UI_Dungeous_Panel_Realms_New_Text_C_Award2 = {
    ID = "UI_Dungeous_Panel_Realms_New_Text_C_Award2",
    Content = "PanelText_UI_Dungeous_Panel_Realms_New_Text_C_Award2_Content|密境法制"
  },
  UI_Dungeous_Panel_Realms_New_Text_C_Creation = {
    ID = "UI_Dungeous_Panel_Realms_New_Text_C_Creation",
    Content = "PanelText_UI_Dungeous_Panel_Realms_New_Text_C_Creation_Content|关卡造物"
  },
  UI_Dungeous_Panel_Realms_New_Text_C_Reward = {
    ID = "UI_Dungeous_Panel_Realms_New_Text_C_Reward",
    Content = "PanelText_UI_Dungeous_Panel_Realms_New_Text_C_Reward_Content|奖励预览"
  },
  UI_Dungeous_Panel_Realms_New_Text_C_Boundaries_Tips = {
    ID = "UI_Dungeous_Panel_Realms_New_Text_C_Boundaries_Tips",
    Content = "PanelText_UI_Dungeous_Panel_Realms_New_Text_C_Boundaries_Tips_Content|推荐界域"
  },
  UI_Dungeous_Panel_Realms_New_Text_C_Tishi = {
    ID = "UI_Dungeous_Panel_Realms_New_Text_C_Tishi",
    Content = "PanelText_UI_Dungeous_Panel_Realms_New_Text_C_Tishi_Content|奖励预览"
  },
  UI_Dungeous_Panel_Realms_New_Text_C_Progressline2 = {
    ID = "UI_Dungeous_Panel_Realms_New_Text_C_Progressline2",
    Content = "PanelText_UI_Dungeous_Panel_Realms_New_Text_C_Progressline2_Content|/"
  },
  UI_Dungeous_Panel_Realms_New_Text_C_Replay = {
    ID = "UI_Dungeous_Panel_Realms_New_Text_C_Replay",
    Content = "PanelText_UI_Dungeous_Panel_Realms_New_Text_C_Replay_Content|记录"
  },
  UI_Dungeons_Popup_Clearance_Text_C_Title = {
    ID = "UI_Dungeons_Popup_Clearance_Text_C_Title",
    Content = "PanelText_UI_Dungeons_Popup_Clearance_Text_C_Title_Content|通关记录"
  },
  UI_Dungeons_Popup_Clearance_Text_C_Refresh = {
    ID = "UI_Dungeons_Popup_Clearance_Text_C_Refresh",
    Content = "PanelText_UI_Dungeons_Popup_Clearance_Text_C_Refresh_Content|换一批"
  },
  UI_Dungeons_Popup_List_Tip_Text_C_Information_6 = {
    ID = "UI_Dungeons_Popup_List_Tip_Text_C_Information_6",
    Content = "PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Information_6_Content|记录"
  },
  UI_Chaper_Popup_Particulars_View_Text_C_Replay = {
    ID = "UI_Chaper_Popup_Particulars_View_Text_C_Replay",
    Content = "PanelText_UI_Chaper_Popup_Particulars_View_Text_C_Replay_Content|记录"
  },
  UI_Pvp_Panel_Main_1_Text_C_Precon = {
    ID = "UI_Pvp_Panel_Main_1_Text_C_Precon",
    Content = "PanelText_UI_Pvp_Panel_Main_1_Text_C_Precon_Content|预组等级"
  },
  UI_Pvp_Panel_Main_1_Text_C_DraftPick = {
    ID = "UI_Pvp_Panel_Main_1_Text_C_DraftPick",
    Content = "PanelText_UI_Pvp_Panel_Main_1_Text_C_DraftPick_Content|轮选等级"
  },
  UI_Dungeons_Panel_Daily_Challenge_New_Text_C_Store = {
    ID = "UI_Dungeons_Panel_Daily_Challenge_New_Text_C_Store",
    Content = "PanelText_UI_Dungeons_Panel_Daily_Challenge_New_Text_C_Store_Content|兑换商店"
  },
  UI_Dungeons_Panel_Daily_Challenge_New_Text_C_Rank = {
    ID = "UI_Dungeons_Panel_Daily_Challenge_New_Text_C_Rank",
    Content = "PanelText_UI_Dungeons_Panel_Daily_Challenge_New_Text_C_Rank_Content|排行榜"
  },
  UI_Dungeons_Panel_Daily_Challenge_New_Text_C_Experience = {
    ID = "UI_Dungeons_Panel_Daily_Challenge_New_Text_C_Experience",
    Content = "PanelText_UI_Dungeons_Panel_Daily_Challenge_New_Text_C_Experience_Content|深潜等级"
  },
  UI_Dungeons_Panel_Daily_Challenge_New_Text_C_Record = {
    ID = "UI_Dungeons_Panel_Daily_Challenge_New_Text_C_Record",
    Content = "PanelText_UI_Dungeons_Panel_Daily_Challenge_New_Text_C_Record_Content|本周成绩"
  },
  UI_Dungeons_Panel_Daily_Challenge_New_Text_C_Highest = {
    ID = "UI_Dungeons_Panel_Daily_Challenge_New_Text_C_Highest",
    Content = "PanelText_UI_Dungeons_Panel_Daily_Challenge_New_Text_C_Highest_Content|本赛季最高分"
  },
  UI_Dungeons_Panel_Daily_Challenge_New_Text_C_Title = {
    ID = "UI_Dungeons_Panel_Daily_Challenge_New_Text_C_Title",
    Content = "PanelText_UI_Dungeons_Panel_Daily_Challenge_New_Text_C_Title_Content|调查等级头衔"
  },
  UI_Dungeons_Panel_Daily_Challenge_New_Text_Diving_Record = {
    ID = "UI_Dungeons_Panel_Daily_Challenge_New_Text_Diving_Record",
    Content = "PanelText_UI_Dungeons_Panel_Daily_Challenge_New_Text_Diving_Record_Content|深潜纪录"
  },
  UI_Dungeons_Panel_Daily_Challenge_New_Text_Main_Title = {
    ID = "UI_Dungeons_Panel_Daily_Challenge_New_Text_Main_Title",
    Content = "PanelText_UI_Dungeons_Panel_Daily_Challenge_New_Text_Main_Title_Content|幻梦深潜"
  },
  UI_Events_Panel_OriMurphy_Text_C_Shop = {
    ID = "UI_Events_Panel_OriMurphy_Text_C_Shop",
    Content = "PanelText_UI_Events_Panel_OriMurphy_Text_C_Shop_Content|神母寝宫"
  },
  UI_Events_Panel_OriMurphy_Text_C_Reward = {
    ID = "UI_Events_Panel_OriMurphy_Text_C_Reward",
    Content = "PanelText_UI_Events_Panel_OriMurphy_Text_C_Reward_Content|成就奖励"
  },
  UI_Events_Panel_OriMurphy_Text_C_Topic = {
    ID = "UI_Events_Panel_OriMurphy_Text_C_Topic",
    Content = "PanelText_UI_Events_Panel_OriMurphy_Text_C_Topic_Content|神诞的祭礼"
  },
  UI_Events_Panel_OriMurphy_Text_C_Record = {
    ID = "UI_Events_Panel_OriMurphy_Text_C_Record",
    Content = "PanelText_UI_Events_Panel_OriMurphy_Text_C_Record_Content|特遣纪录"
  },
  UI_Events_Panel_OriMurphy_Text_C_RecordTip = {
    ID = "UI_Events_Panel_OriMurphy_Text_C_RecordTip",
    Content = "PanelText_UI_Events_Panel_OriMurphy_Text_C_RecordTip_Content|限时免费解锁"
  },
  UI_Events_Panel_OriMurphy_Text_C_Challenge = {
    ID = "UI_Events_Panel_OriMurphy_Text_C_Challenge",
    Content = "PanelText_UI_Events_Panel_OriMurphy_Text_C_Challenge_Content|创生七日"
  },
  UI_Events_Panel_OriMurphy_Text_C_ChallengeTip = {
    ID = "UI_Events_Panel_OriMurphy_Text_C_ChallengeTip",
    Content = "PanelText_UI_Events_Panel_OriMurphy_Text_C_ChallengeTip_Content|玩法限时开放"
  },
  UI_Events_Panel_OriMurphy_Text_C_Can_Unlockable = {
    ID = "UI_Events_Panel_OriMurphy_Text_C_Can_Unlockable",
    Content = "PanelText_UI_Events_Panel_OriMurphy_Text_C_Can_Unlockable_Content|可领取"
  },
  UI_Events_Panel_OriMurphy_Text_C_Max = {
    ID = "UI_Events_Panel_OriMurphy_Text_C_Max",
    Content = "PanelText_UI_Events_Panel_OriMurphy_Text_C_Max_Content|Max"
  },
  UI_Events_Panel_OriMurphy_Text_C_Fill_Up = {
    ID = "UI_Events_Panel_OriMurphy_Text_C_Fill_Up",
    Content = "PanelText_UI_Events_Panel_OriMurphy_Text_C_Fill_Up_Content|(距离补满："
  },
  UI_Events_Panel_OriMurphy_Text_C_Symbol = {
    ID = "UI_Events_Panel_OriMurphy_Text_C_Symbol",
    Content = "PanelText_UI_Events_Panel_OriMurphy_Text_C_Symbol_Content|)"
  },
  UI_Events_Panel_OriMurphy_Text_C_Not_unlocked = {
    ID = "UI_Events_Panel_OriMurphy_Text_C_Not_unlocked",
    Content = "PanelText_UI_Events_Panel_OriMurphy_Text_C_Not_unlocked_Content|未解锁"
  },
  UI_Events_Panel_OriMurphy_Text_C_Finished = {
    ID = "UI_Events_Panel_OriMurphy_Text_C_Finished",
    Content = "PanelText_UI_Events_Panel_OriMurphy_Text_C_Finished_Content|已结束"
  },
  UI_Events_Panel_OriMurphy_Text_C_Receive = {
    ID = "UI_Events_Panel_OriMurphy_Text_C_Receive",
    Content = "PanelText_UI_Events_Panel_OriMurphy_Text_C_Receive_Content|距离可领取"
  },
  UI_Events_Activity_StageGroup_Text_C_Title = {
    ID = "UI_Events_Activity_StageGroup_Text_C_Title",
    Content = "PanelText_UI_Events_Activity_StageGroup_Text_C_Title_Content|创生七日"
  },
  UI_Events_Activity_StageGroup_Text_C_Introduction = {
    ID = "UI_Events_Activity_StageGroup_Text_C_Introduction",
    Content = "PanelText_UI_Events_Activity_StageGroup_Text_C_Introduction_Content|那神允诺的已然近了。\n数千载的等待即将迎来欢欣的终局，应许之地将从海中升起。\n神明从神母的胸腔中苏生，七日终结之时，新的世界会降临。"
  },
  UI_Events_Item_OriMurphy_Text_C_Diagonal = {
    ID = "UI_Events_Item_OriMurphy_Text_C_Diagonal",
    Content = "PanelText_UI_Events_Item_OriMurphy_Text_C_Diagonal_Content|/"
  },
  UI_Events_Item_OriMurphy_Text_C_Fall = {
    ID = "UI_Events_Item_OriMurphy_Text_C_Fall",
    Content = "PanelText_UI_Events_Item_OriMurphy_Text_C_Fall_Content|掉落预览"
  },
  UI_Events_Item_OriMurphy_Text_C_LockTips = {
    ID = "UI_Events_Item_OriMurphy_Text_C_LockTips",
    Content = "PanelText_UI_Events_Item_OriMurphy_Text_C_LockTips_Content|关卡解锁提示"
  },
  UI_Event_Activity_OriMurphy_Text_C_Reward = {
    ID = "UI_Event_Activity_OriMurphy_Text_C_Reward",
    Content = "PanelText_UI_Event_Activity_OriMurphy_Text_C_Reward_Content|获得物资"
  },
  UI_Event_Activity_OriMurphy_Text_C_Max = {
    ID = "UI_Event_Activity_OriMurphy_Text_C_Max",
    Content = "PanelText_UI_Event_Activity_OriMurphy_Text_C_Max_Content|Max"
  },
  UI_Event_Activity_OriMurphy_Text_C_Full = {
    ID = "UI_Event_Activity_OriMurphy_Text_C_Full",
    Content = "PanelText_UI_Event_Activity_OriMurphy_Text_C_Full_Content|当前已达存储上限"
  },
  UI_Event_Activity_OriMurphy_Text_C_Finish = {
    ID = "UI_Event_Activity_OriMurphy_Text_C_Finish",
    Content = "PanelText_UI_Event_Activity_OriMurphy_Text_C_Finish_Content|活动已结束，已停止获取"
  },
  UI_Event_Activity_OriMurphy_Text_C_SpeedTitle = {
    ID = "UI_Event_Activity_OriMurphy_Text_C_SpeedTitle",
    Content = "PanelText_UI_Event_Activity_OriMurphy_Text_C_SpeedTitle_Content|存储速度:"
  },
  UI_Event_Activity_OriMurphy_Text_None = {
    ID = "UI_Event_Activity_OriMurphy_Text_None",
    Content = "PanelText_UI_Event_Activity_OriMurphy_Text_None_Content|暂无物资"
  },
  UI_Social_Panel_HelpList_Text_C_CommonlyAssist = {
    ID = "UI_Social_Panel_HelpList_Text_C_CommonlyAssist",
    Content = "PanelText_UI_Social_Panel_HelpList_Text_C_CommonlyAssist_Content|常用助战"
  },
  UI_Social_Popup_CommonlyAssist_Text_C_Title = {
    ID = "UI_Social_Popup_CommonlyAssist_Text_C_Title",
    Content = "PanelText_UI_Social_Popup_CommonlyAssist_Text_C_Title_Content|常用助战"
  },
  UI_Social_Popup_CommonlyAssist_Text_C_NoTask = {
    ID = "UI_Social_Popup_CommonlyAssist_Text_C_NoTask",
    Content = "PanelText_UI_Social_Popup_CommonlyAssist_Text_C_NoTask_Content|暂无助战伙伴"
  },
  UI_Social_Popup_CommonlyAssist_Text_C_En = {
    ID = "UI_Social_Popup_CommonlyAssist_Text_C_En",
    Content = "PanelText_UI_Social_Popup_CommonlyAssist_Text_C_En_Content|fdshsjfgjgf"
  },
  UI_Social_Popup_CommonlyAssist_Text_C_SearchTip = {
    ID = "UI_Social_Popup_CommonlyAssist_Text_C_SearchTip",
    Content = "PanelText_UI_Social_Popup_CommonlyAssist_Text_C_SearchTip_Content|输入UID查找守密人"
  },
  UI_Social_Popup_CommonlyAssist_Text_C_Search = {
    ID = "UI_Social_Popup_CommonlyAssist_Text_C_Search",
    Content = "PanelText_UI_Social_Popup_CommonlyAssist_Text_C_Search_Content|搜索"
  },
  UI_Social_Popup_CommonlyAssist_Text_Time = {
    ID = "UI_Social_Popup_CommonlyAssist_Text_Time",
    Content = "PanelText_UI_Social_Popup_CommonlyAssist_Text_Time_Content|去其他地方看看吧"
  },
  UI_Dungeons_Popup_Clearance_Text_C_No_Records = {
    ID = "UI_Dungeons_Popup_Clearance_Text_C_No_Records",
    Content = "PanelText_UI_Dungeons_Popup_Clearance_Text_C_No_Records_Content|暂无调查记录"
  },
  UI_Social_Panel_HelpList_Item_Text_C_Commonly = {
    ID = "UI_Social_Panel_HelpList_Item_Text_C_Commonly",
    Content = "PanelText_UI_Social_Panel_HelpList_Item_Text_C_Commonly_Content|常用助战"
  },
  UI_Events_Panel_OriMurphy_StageGroup_Text_C_Title = {
    ID = "UI_Events_Panel_OriMurphy_StageGroup_Text_C_Title",
    Content = "PanelText_UI_Events_Panel_OriMurphy_StageGroup_Text_C_Title_Content|创生七日"
  },
  UI_Events_Panel_OriMurphy_StageGroup_Text_C_Introduction = {
    ID = "UI_Events_Panel_OriMurphy_StageGroup_Text_C_Introduction",
    Content = "PanelText_UI_Events_Panel_OriMurphy_StageGroup_Text_C_Introduction_Content|那神允诺的已然近了。\n数千载的等待即将迎来欢欣的终局，应许之地将从海中升起。\n神明从神母的胸腔中苏生，七日终结之时，新的世界会降临。"
  },
  UI_Dungeons_Panel_WeekBOSS_Optimized_Text_C_AwardText = {
    ID = "UI_Dungeons_Panel_WeekBOSS_Optimized_Text_C_AwardText",
    Content = "PanelText_UI_Dungeons_Panel_WeekBOSS_Optimized_Text_C_AwardText_Content|本周可以领取奖励次数"
  },
  UI_Dungeons_Panel_WeekBOSS_Optimized_Text_C_Award = {
    ID = "UI_Dungeons_Panel_WeekBOSS_Optimized_Text_C_Award",
    Content = "PanelText_UI_Dungeons_Panel_WeekBOSS_Optimized_Text_C_Award_Content|任务报酬"
  },
  UI_Dungeons_Panel_WeekBOSS_Optimized_Text_C_ActivityAchievement = {
    ID = "UI_Dungeons_Panel_WeekBOSS_Optimized_Text_C_ActivityAchievement",
    Content = "PanelText_UI_Dungeons_Panel_WeekBOSS_Optimized_Text_C_ActivityAchievement_Content|成就奖励"
  },
  UI_Dungeons_Material_View_Text_C_ActivityAchievement = {
    ID = "UI_Dungeons_Material_View_Text_C_ActivityAchievement",
    Content = "PanelText_UI_Dungeons_Material_View_Text_C_ActivityAchievement_Content|成就奖励"
  },
  UI_Dungeons_Trinket_View_Text_C_ActivityAchievement = {
    ID = "UI_Dungeons_Trinket_View_Text_C_ActivityAchievement",
    Content = "PanelText_UI_Dungeons_Trinket_View_Text_C_ActivityAchievement_Content|成就奖励"
  },
  UI_Collection_History_Details_Text_Title = {
    ID = "UI_Collection_History_Details_Text_Title",
    Content = "PanelText_UI_Collection_History_Details_Text_Title_Content|记录"
  },
  UI_Main_Item_ActiveTasks_Text_C_Receive = {
    ID = "UI_Main_Item_ActiveTasks_Text_C_Receive",
    Content = "PanelText_UI_Main_Item_ActiveTasks_Text_C_Receive_Content|领取"
  },
  UI_Main_Item_ActiveTasks_Text_C_Not = {
    ID = "UI_Main_Item_ActiveTasks_Text_C_Not",
    Content = "PanelText_UI_Main_Item_ActiveTasks_Text_C_Not_Content|未完成"
  },
  UI_Main_Item_ActiveTasks_Text_C_Proxy = {
    ID = "UI_Main_Item_ActiveTasks_Text_C_Proxy",
    Content = "PanelText_UI_Main_Item_ActiveTasks_Text_C_Proxy_Content|代理凭证"
  },
  UI_Common_Popup_Tip_3_Text_Screening = {
    ID = "UI_Common_Popup_Tip_3_Text_Screening",
    Content = "PanelText_UI_Common_Popup_Tip_3_Text_Screening_Content|今日不再提示"
  },
  UI_Dungeous_Panel_Difficulty_Optimized_Text_StrongAwakers = {
    ID = "UI_Dungeous_Panel_Difficulty_Optimized_Text_StrongAwakers",
    Content = "PanelText_UI_Dungeous_Panel_Difficulty_Optimized_Text_StrongAwakers_Content|强化唤醒体"
  },
  UI_Dungeous_Panel_Difficulty_Optimized_Text_RewardShow = {
    ID = "UI_Dungeous_Panel_Difficulty_Optimized_Text_RewardShow",
    Content = "PanelText_UI_Dungeous_Panel_Difficulty_Optimized_Text_RewardShow_Content|奖励预览"
  },
  UI_Research_Panel_Challenge_Item_Text_C_Undone = {
    ID = "UI_Research_Panel_Challenge_Item_Text_C_Undone",
    Content = "PanelText_UI_Research_Panel_Challenge_Item_Text_C_Undone_Content|未完成"
  },
  UI_Social_Popup_WatchList_Text_Tip = {
    ID = "UI_Social_Popup_WatchList_Text_Tip",
    Content = "PanelText_UI_Social_Popup_WatchList_Text_Tip_Content|可查看近期新增的100名追随者"
  },
  UI_Events_Panel_WorldBoss_Text_C_Rank = {
    ID = "UI_Events_Panel_WorldBoss_Text_C_Rank",
    Content = "PanelText_UI_Events_Panel_WorldBoss_Text_C_Rank_Content|荣勋名录"
  },
  UI_Events_Panel_WorldBoss_Text_C_Record = {
    ID = "UI_Events_Panel_WorldBoss_Text_C_Record",
    Content = "PanelText_UI_Events_Panel_WorldBoss_Text_C_Record_Content|特遣纪录"
  },
  UI_Events_Popup_WorldBossRank_Text_C_Title = {
    ID = "UI_Events_Popup_WorldBossRank_Text_C_Title",
    Content = "PanelText_UI_Events_Popup_WorldBossRank_Text_C_Title_Content|荣勋名录"
  },
  UI_Events_Popup_WorldBossRank_Text_C_Kill = {
    ID = "UI_Events_Popup_WorldBossRank_Text_C_Kill",
    Content = "PanelText_UI_Events_Popup_WorldBossRank_Text_C_Kill_Content|抓捕次数榜"
  },
  UI_Events_Popup_WorldBossRank_Text_C_Assist = {
    ID = "UI_Events_Popup_WorldBossRank_Text_C_Assist",
    Content = "PanelText_UI_Events_Popup_WorldBossRank_Text_C_Assist_Content|协助次数榜"
  },
  UI_Events_Popup_WorldBossRank_Text_C_Rank_Kill = {
    ID = "UI_Events_Popup_WorldBossRank_Text_C_Rank_Kill",
    Content = "PanelText_UI_Events_Popup_WorldBossRank_Text_C_Rank_Kill_Content|排名"
  },
  UI_Events_Popup_WorldBossRank_Text_C_KillCount = {
    ID = "UI_Events_Popup_WorldBossRank_Text_C_KillCount",
    Content = "PanelText_UI_Events_Popup_WorldBossRank_Text_C_KillCount_Content|总抓捕数"
  },
  UI_Events_Popup_WorldBossRank_Text_C_Information_Kill = {
    ID = "UI_Events_Popup_WorldBossRank_Text_C_Information_Kill",
    Content = "PanelText_UI_Events_Popup_WorldBossRank_Text_C_Information_Kill_Content|守密人信息"
  },
  UI_Events_Popup_WorldBossRank_Text_C_Empty_Kill = {
    ID = "UI_Events_Popup_WorldBossRank_Text_C_Empty_Kill",
    Content = "PanelText_UI_Events_Popup_WorldBossRank_Text_C_Empty_Kill_Content|暂无记录"
  },
  UI_Events_Popup_WorldBossRank_Text_C_En = {
    ID = "UI_Events_Popup_WorldBossRank_Text_C_En",
    Content = "PanelText_UI_Events_Popup_WorldBossRank_Text_C_En_Content|fdshsjfgjgf"
  },
  UI_Events_Popup_WorldBossRank_Text_C_Rank_Assist = {
    ID = "UI_Events_Popup_WorldBossRank_Text_C_Rank_Assist",
    Content = "PanelText_UI_Events_Popup_WorldBossRank_Text_C_Rank_Assist_Content|排名"
  },
  UI_Events_Popup_WorldBossRank_Text_C_AssistCount = {
    ID = "UI_Events_Popup_WorldBossRank_Text_C_AssistCount",
    Content = "PanelText_UI_Events_Popup_WorldBossRank_Text_C_AssistCount_Content|助战次数"
  },
  UI_Events_Popup_WorldBossRank_Text_C_AssistAwaker = {
    ID = "UI_Events_Popup_WorldBossRank_Text_C_AssistAwaker",
    Content = "PanelText_UI_Events_Popup_WorldBossRank_Text_C_AssistAwaker_Content|助战角色"
  },
  UI_Events_Popup_WorldBossRank_Text_C_Information_Assist = {
    ID = "UI_Events_Popup_WorldBossRank_Text_C_Information_Assist",
    Content = "PanelText_UI_Events_Popup_WorldBossRank_Text_C_Information_Assist_Content|守密人信息"
  },
  UI_Events_Popup_WorldBossRank_Text_C_Empty_Assist = {
    ID = "UI_Events_Popup_WorldBossRank_Text_C_Empty_Assist",
    Content = "PanelText_UI_Events_Popup_WorldBossRank_Text_C_Empty_Assist_Content|暂无记录"
  },
  UI_Keeper_Skill_Panel_Text_C_NoTask = {
    ID = "UI_Keeper_Skill_Panel_Text_C_NoTask",
    Content = "PanelText_UI_Keeper_Skill_Panel_Text_C_NoTask_Content|暂无钥令"
  },
  UI_Keeper_Skill_Panel_Text_C_En = {
    ID = "UI_Keeper_Skill_Panel_Text_C_En",
    Content = "PanelText_UI_Keeper_Skill_Panel_Text_C_En_Content|fdshsjfgjgf"
  },
  UI_Keeper_Skill_Panel_Text_Time = {
    ID = "UI_Keeper_Skill_Panel_Text_Time",
    Content = "PanelText_UI_Keeper_Skill_Panel_Text_Time_Content|去其他地方看看吧"
  },
  UI_PVP_Item_RotationPlayer_Text_C_Wait = {
    ID = "UI_PVP_Item_RotationPlayer_Text_C_Wait",
    Content = "PanelText_UI_PVP_Item_RotationPlayer_Text_C_Wait_Content|等待轮选信息展示"
  },
  UI_Chapter_Item_Special_02_Text_C_Free_Unlock = {
    ID = "UI_Chapter_Item_Special_02_Text_C_Free_Unlock",
    Content = "PanelText_UI_Chapter_Item_Special_02_Text_C_Free_Unlock_Content|限时免费解锁"
  },
  UI_Chapter_Item_Special_03_Text_C_Free_Unlock = {
    ID = "UI_Chapter_Item_Special_03_Text_C_Free_Unlock",
    Content = "PanelText_UI_Chapter_Item_Special_03_Text_C_Free_Unlock_Content|限时免费解锁"
  },
  UI_Social_Panel_Main_SubPanel_2_Text_Name = {
    ID = "UI_Social_Panel_Main_SubPanel_2_Text_Name",
    Content = "PanelText_UI_Social_Panel_Main_SubPanel_2_Text_Name_Content|全部关注"
  },
  UI_Social_Popup_WatchList_Text_Name_FollowAll = {
    ID = "UI_Social_Popup_WatchList_Text_Name_FollowAll",
    Content = "PanelText_UI_Social_Popup_WatchList_Text_Name_FollowAll_Content|全部关注"
  },
  UI_Social_Panel_HelpList_Item_Text_C_Recommend = {
    ID = "UI_Social_Panel_HelpList_Item_Text_C_Recommend",
    Content = "PanelText_UI_Social_Panel_HelpList_Item_Text_C_Recommend_Content|推荐关注"
  },
  UI_Dungeons_Popup_Clearance_Text_C_En = {
    ID = "UI_Dungeons_Popup_Clearance_Text_C_En",
    Content = "PanelText_UI_Dungeons_Popup_Clearance_Text_C_En_Content|fdshsjfgjgf"
  },
  UI_Dungeons_Popup_Clearance_Text_C_FilterAwaker = {
    ID = "UI_Dungeons_Popup_Clearance_Text_C_FilterAwaker",
    Content = "PanelText_UI_Dungeons_Popup_Clearance_Text_C_FilterAwaker_Content|筛选唤醒体"
  },
  UI_Dungeons_Popup_Clearance_Text_Fliter_Type = {
    ID = "UI_Dungeons_Popup_Clearance_Text_Fliter_Type",
    Content = "PanelText_UI_Dungeons_Popup_Clearance_Text_Fliter_Type_Content|总回合数"
  },
  UI_Dungeous_Panel_Molten_Optimized_Text_C_Special = {
    ID = "UI_Dungeous_Panel_Molten_Optimized_Text_C_Special",
    Content = "PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_C_Special_Content|初始造物"
  },
  UI_Dungeous_Panel_Molten_Optimized_Text_C_Integral = {
    ID = "UI_Dungeous_Panel_Molten_Optimized_Text_C_Integral",
    Content = "PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_C_Integral_Content|通关积分"
  },
  UI_Dungeous_Panel_Molten_Optimized_Text_C_Monster = {
    ID = "UI_Dungeous_Panel_Molten_Optimized_Text_C_Monster",
    Content = "PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_C_Monster_Content|怪物预览"
  },
  UI_Dungeous_Panel_Molten_Optimized_Text_C_None = {
    ID = "UI_Dungeous_Panel_Molten_Optimized_Text_C_None",
    Content = "PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_C_None_Content|暂无阵容"
  },
  UI_Dungeous_Panel_Molten_Optimized_Text_C_LineUp = {
    ID = "UI_Dungeous_Panel_Molten_Optimized_Text_C_LineUp",
    Content = "PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_C_LineUp_Content|通关阵容"
  },
  UI_Dungeous_Panel_Molten_Optimized_Text_C_Name = {
    ID = "UI_Dungeous_Panel_Molten_Optimized_Text_C_Name",
    Content = "PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_C_Name_Content|重置"
  },
  UI_Dungeous_Panel_Molten_Optimized_Text_C_Creation = {
    ID = "UI_Dungeous_Panel_Molten_Optimized_Text_C_Creation",
    Content = "PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_C_Creation_Content|关卡造物"
  },
  UI_Dungeous_Panel_Molten_Optimized_Text_C_Replay = {
    ID = "UI_Dungeous_Panel_Molten_Optimized_Text_C_Replay",
    Content = "PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_C_Replay_Content|记录"
  },
  UI_Dungeons_Popup_List_Tip_Text_C_FilterAwaker = {
    ID = "UI_Dungeons_Popup_List_Tip_Text_C_FilterAwaker",
    Content = "PanelText_UI_Dungeons_Popup_List_Tip_Text_C_FilterAwaker_Content|筛选唤醒体"
  },
  UI_Setting_Popup_Main_Text_C_Tips = {
    ID = "UI_Setting_Popup_Main_Text_C_Tips",
    Content = "PanelText_UI_Setting_Popup_Main_Text_C_Tips_Content|内部GM"
  },
  UI_Recharge_Panel_OptionGift_Text_C_Title = {
    ID = "UI_Recharge_Panel_OptionGift_Text_C_Title",
    Content = "PanelText_UI_Recharge_Panel_OptionGift_Text_C_Title_Content|弥萨格商店"
  },
  UI_Recharge_Panel_OptionGift_Text_C_Disable = {
    ID = "UI_Recharge_Panel_OptionGift_Text_C_Disable",
    Content = "PanelText_UI_Recharge_Panel_OptionGift_Text_C_Disable_Content|购买"
  },
  UI_Recharge_Panel_OptionGift_Text_C_Normal = {
    ID = "UI_Recharge_Panel_OptionGift_Text_C_Normal",
    Content = "PanelText_UI_Recharge_Panel_OptionGift_Text_C_Normal_Content|购买"
  },
  UI_Recharge_Popup_OptionGift_Text_C_Title = {
    ID = "UI_Recharge_Popup_OptionGift_Text_C_Title",
    Content = "PanelText_UI_Recharge_Popup_OptionGift_Text_C_Title_Content|确认购买"
  },
  UI_Recharge_Popup_OptionGift_Text_C_Title_En = {
    ID = "UI_Recharge_Popup_OptionGift_Text_C_Title_En",
    Content = "PanelText_UI_Recharge_Popup_OptionGift_Text_C_Title_En_Content|title"
  },
  UI_Recharge_Popup_OptionGift_Text_C_Cost_Tips = {
    ID = "UI_Recharge_Popup_OptionGift_Text_C_Cost_Tips",
    Content = "PanelText_UI_Recharge_Popup_OptionGift_Text_C_Cost_Tips_Content|消耗"
  },
  UI_Recharge_Popup_OptionGift_Text_C_Cancel = {
    ID = "UI_Recharge_Popup_OptionGift_Text_C_Cancel",
    Content = "PanelText_UI_Recharge_Popup_OptionGift_Text_C_Cancel_Content|取消"
  },
  UI_Recharge_Popup_OptionGift_Text_C_Confirm = {
    ID = "UI_Recharge_Popup_OptionGift_Text_C_Confirm",
    Content = "PanelText_UI_Recharge_Popup_OptionGift_Text_C_Confirm_Content|购买"
  },
  UI_Collection_Panel_Equip_Text_C_None = {
    ID = "UI_Collection_Panel_Equip_Text_C_None",
    Content = "PanelText_UI_Collection_Panel_Equip_Text_C_None_Content|暂无相关收藏"
  },
  UI_Collection_Panel_Equip_Text_C_Time = {
    ID = "UI_Collection_Panel_Equip_Text_C_Time",
    Content = "PanelText_UI_Collection_Panel_Equip_Text_C_Time_Content|去其他地方看看吧"
  },
  UI_Collection_Panel_Equip_Text_C_None2 = {
    ID = "UI_Collection_Panel_Equip_Text_C_None2",
    Content = "PanelText_UI_Collection_Panel_Equip_Text_C_None2_Content|No material yet"
  },
  UI_Events_Panel_Mouchette_Text_C_Shop = {
    ID = "UI_Events_Panel_Mouchette_Text_C_Shop",
    Content = "PanelText_UI_Events_Panel_Mouchette_Text_C_Shop_Content|茉夏的小屋"
  },
  UI_Events_Panel_Mouchette_Text_C_Resonance = {
    ID = "UI_Events_Panel_Mouchette_Text_C_Resonance",
    Content = "PanelText_UI_Events_Panel_Mouchette_Text_C_Resonance_Content|共鸣：吞噬山脉"
  },
  UI_Events_Panel_Mouchette_Text_C_Diagonal = {
    ID = "UI_Events_Panel_Mouchette_Text_C_Diagonal",
    Content = "PanelText_UI_Events_Panel_Mouchette_Text_C_Diagonal_Content|/"
  },
  UI_Events_Panel_Mouchette_Text_C_Reward = {
    ID = "UI_Events_Panel_Mouchette_Text_C_Reward",
    Content = "PanelText_UI_Events_Panel_Mouchette_Text_C_Reward_Content|成就奖励"
  },
  UI_Events_Panel_Mouchette_Text_C_Record = {
    ID = "UI_Events_Panel_Mouchette_Text_C_Record",
    Content = "PanelText_UI_Events_Panel_Mouchette_Text_C_Record_Content|多维连接"
  },
  UI_Events_Panel_Mouchette_Text_C_RecordTip = {
    ID = "UI_Events_Panel_Mouchette_Text_C_RecordTip",
    Content = "PanelText_UI_Events_Panel_Mouchette_Text_C_RecordTip_Content|限时免费解锁"
  },
  UI_Events_Panel_Mouchette_Text_C_Challenge = {
    ID = "UI_Events_Panel_Mouchette_Text_C_Challenge",
    Content = "PanelText_UI_Events_Panel_Mouchette_Text_C_Challenge_Content|迷失的自我"
  },
  UI_Events_Panel_Mouchette_Text_C_ChallengeTip = {
    ID = "UI_Events_Panel_Mouchette_Text_C_ChallengeTip",
    Content = "PanelText_UI_Events_Panel_Mouchette_Text_C_ChallengeTip_Content|玩法限时开放"
  },
  UI_Events_Panel_Mouchette_Text_C_Topic = {
    ID = "UI_Events_Panel_Mouchette_Text_C_Topic",
    Content = "PanelText_UI_Events_Panel_Mouchette_Text_C_Topic_Content|雾境的燔礼"
  },
  UI_Events_Panel_Mouchette_StageGroup_Text_C_Title = {
    ID = "UI_Events_Panel_Mouchette_StageGroup_Text_C_Title",
    Content = "PanelText_UI_Events_Panel_Mouchette_StageGroup_Text_C_Title_Content|迷失的自我"
  },
  UI_Events_Panel_Mouchette_StageGroup_Text_C_Introduction = {
    ID = "UI_Events_Panel_Mouchette_StageGroup_Text_C_Introduction",
    Content = "PanelText_UI_Events_Panel_Mouchette_StageGroup_Text_C_Introduction_Content|突然有一天，你发现自己变得不一样了。\n没有人发现这一点，因为你有着一样的行为举止，一样的盛世容颜。\n但你很清楚，那颗原本鲜红的心，已经被覆上一张雾气构成的假面。 \n「如果我能一直伪装下去，那是否我依然是此前的我？」\n可喜可贺，这个问题并没有在你的大脑里停留超过一秒，反正在揭开那张假面之前，没有人知道你真实的想法。\n「那就，先出发吧~」"
  },
  UI_Events_Panel_Mouchette_StageGroup_Text_C_Resonance = {
    ID = "UI_Events_Panel_Mouchette_StageGroup_Text_C_Resonance",
    Content = "PanelText_UI_Events_Panel_Mouchette_StageGroup_Text_C_Resonance_Content|共鸣"
  },
  UI_Collection_Panel_SetMainBg_Text_C_DownLoadCG = {
    ID = "UI_Collection_Panel_SetMainBg_Text_C_DownLoadCG",
    Content = "PanelText_UI_Collection_Panel_SetMainBg_Text_C_DownLoadCG_Content|下载原图"
  },
  UI_Battle_Popup_AttachPost_Text_C_AttachPost = {
    ID = "UI_Battle_Popup_AttachPost_Text_C_AttachPost",
    Content = "PanelText_UI_Battle_Popup_AttachPost_Text_C_AttachPost_Content|追击"
  },
  UI_Event_Activity_SummonBenefits_Text_C_Summon = {
    ID = "UI_Event_Activity_SummonBenefits_Text_C_Summon",
    Content = "PanelText_UI_Event_Activity_SummonBenefits_Text_C_Summon_Content|免费召唤"
  },
  UI_Pvp_Panel_Train_Text_C_SelectRelic = {
    ID = "UI_Pvp_Panel_Train_Text_C_SelectRelic",
    Content = "PanelText_UI_Pvp_Panel_Train_Text_C_SelectRelic_Content|选择造物"
  },
  UI_Dungeons_Panel_SurveyData_Text_C_PlayerLevel = {
    ID = "UI_Dungeons_Panel_SurveyData_Text_C_PlayerLevel",
    Content = "PanelText_UI_Dungeons_Panel_SurveyData_Text_C_PlayerLevel_Content|守密人等级"
  },
  UI_Pvp_Popup_SelectCreation_Text_C_Title = {
    ID = "UI_Pvp_Popup_SelectCreation_Text_C_Title",
    Content = "PanelText_UI_Pvp_Popup_SelectCreation_Text_C_Title_Content|选择1个造物"
  },
  UI_Pvp_Popup_SelectCreation_Text_C_Confirm = {
    ID = "UI_Pvp_Popup_SelectCreation_Text_C_Confirm",
    Content = "PanelText_UI_Pvp_Popup_SelectCreation_Text_C_Confirm_Content|确定"
  },
  UI_Awaker_Popup_Trinket_Upgrade_Text_C_Title = {
    ID = "UI_Awaker_Popup_Trinket_Upgrade_Text_C_Title",
    Content = "PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_Title_Content|等级"
  },
  UI_Awaker_Popup_Trinket_Upgrade_Text_C_Consume = {
    ID = "UI_Awaker_Popup_Trinket_Upgrade_Text_C_Consume",
    Content = "PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_Consume_Content|消耗材料"
  },
  UI_Awaker_Popup_Trinket_Upgrade_Text_C_Fast_Normal = {
    ID = "UI_Awaker_Popup_Trinket_Upgrade_Text_C_Fast_Normal",
    Content = "PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_Fast_Normal_Content|升1级"
  },
  UI_Awaker_Popup_Trinket_Upgrade_Text_C_Fast_High = {
    ID = "UI_Awaker_Popup_Trinket_Upgrade_Text_C_Fast_High",
    Content = "PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_Fast_High_Content|升1级"
  },
  UI_Awaker_Popup_Trinket_Upgrade_Text_C_Max_Normal = {
    ID = "UI_Awaker_Popup_Trinket_Upgrade_Text_C_Max_Normal",
    Content = "PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_Max_Normal_Content|升至满级"
  },
  UI_Awaker_Popup_Trinket_Upgrade_Text_C_Max_High = {
    ID = "UI_Awaker_Popup_Trinket_Upgrade_Text_C_Max_High",
    Content = "PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_Max_High_Content|升至满级"
  },
  UI_Awaker_Popup_Trinket_Upgrade_Text_C_MaxLevel = {
    ID = "UI_Awaker_Popup_Trinket_Upgrade_Text_C_MaxLevel",
    Content = "PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_MaxLevel_Content|强化"
  },
  UI_Setting_Popup_PlatformBinding_Text_C_Title = {
    ID = "UI_Setting_Popup_PlatformBinding_Text_C_Title",
    Content = "PanelText_UI_Setting_Popup_PlatformBinding_Text_C_Title_Content|登录奖励"
  },
  UI_Setting_Popup_PlatformBinding_Text_C_UnDone_1 = {
    ID = "UI_Setting_Popup_PlatformBinding_Text_C_UnDone_1",
    Content = "PanelText_UI_Setting_Popup_PlatformBinding_Text_C_UnDone_1_Content|未达成"
  },
  UI_Setting_Popup_PlatformBinding_Text_C_Receive_1 = {
    ID = "UI_Setting_Popup_PlatformBinding_Text_C_Receive_1",
    Content = "PanelText_UI_Setting_Popup_PlatformBinding_Text_C_Receive_1_Content|领取"
  },
  UI_Setting_Popup_PlatformBinding_Text_C_UnDone_2 = {
    ID = "UI_Setting_Popup_PlatformBinding_Text_C_UnDone_2",
    Content = "PanelText_UI_Setting_Popup_PlatformBinding_Text_C_UnDone_2_Content|未达成"
  },
  UI_Setting_Popup_PlatformBinding_Text_C_Receive_2 = {
    ID = "UI_Setting_Popup_PlatformBinding_Text_C_Receive_2",
    Content = "PanelText_UI_Setting_Popup_PlatformBinding_Text_C_Receive_2_Content|领取"
  },
  UI_Awaker_Popup_Topped_Tip3_Text_C_Mad_Name = {
    ID = "UI_Awaker_Popup_Topped_Tip3_Text_C_Mad_Name",
    Content = "PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Mad_Name_Content|超限爆发"
  },
  UI_Awaker_Popup_Topped_Tip3_Text_C_MaxMad_Name = {
    ID = "UI_Awaker_Popup_Topped_Tip3_Text_C_MaxMad_Name",
    Content = "PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_MaxMad_Name_Content|最终法则"
  },
  UI_Awaker_Popup_Topped_Tip3_Text_C_MaxMad_Activation = {
    ID = "UI_Awaker_Popup_Topped_Tip3_Text_C_MaxMad_Activation",
    Content = "PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_MaxMad_Activation_Content|已激活"
  },
  UI_Awaker_Popup_Topped_Tip3_Text_C_Not_MaxMad_Activation = {
    ID = "UI_Awaker_Popup_Topped_Tip3_Text_C_Not_MaxMad_Activation",
    Content = "PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Not_MaxMad_Activation_Content|未激活"
  },
  UI_Awaker_Item_Potency_Detail_Text_MaxMad_Solved = {
    ID = "UI_Awaker_Item_Potency_Detail_Text_MaxMad_Solved",
    Content = "PanelText_UI_Awaker_Item_Potency_Detail_Text_MaxMad_Solved_Content|已解锁"
  },
  UI_Awaker_Item_Potency_Detail_Text_MaxMad_Unsolved = {
    ID = "UI_Awaker_Item_Potency_Detail_Text_MaxMad_Unsolved",
    Content = "PanelText_UI_Awaker_Item_Potency_Detail_Text_MaxMad_Unsolved_Content|未解锁"
  },
  UI_Common_Item_Potency_Text_C_Max = {
    ID = "UI_Common_Item_Potency_Text_C_Max",
    Content = "PanelText_UI_Common_Item_Potency_Text_C_Max_Content|MAX"
  },
  UI_Awaker_Item_Potency_Detail_Text_C_MaxMad_WillSolved = {
    ID = "UI_Awaker_Item_Potency_Detail_Text_C_MaxMad_WillSolved",
    Content = "PanelText_UI_Awaker_Item_Potency_Detail_Text_C_MaxMad_WillSolved_Content|此次解锁"
  },
  UI_Awaker_Item_Potency_Detail_Text_C_MaxMad_Solved = {
    ID = "UI_Awaker_Item_Potency_Detail_Text_C_MaxMad_Solved",
    Content = "PanelText_UI_Awaker_Item_Potency_Detail_Text_C_MaxMad_Solved_Content|已解锁"
  },
  UI_Awaker_Item_Potency_Detail_Text_C_MaxMad_Unsolved = {
    ID = "UI_Awaker_Item_Potency_Detail_Text_C_MaxMad_Unsolved",
    Content = "PanelText_UI_Awaker_Item_Potency_Detail_Text_C_MaxMad_Unsolved_Content|未解锁"
  },
  UI_Events_Panel_Xu_StageGroup_Text_C_Title = {
    ID = "UI_Events_Panel_Xu_StageGroup_Text_C_Title",
    Content = "PanelText_UI_Events_Panel_Xu_StageGroup_Text_C_Title_Content|玄女无相"
  },
  UI_Events_Panel_Xu_StageGroup_Text_C_Introduction = {
    ID = "UI_Events_Panel_Xu_StageGroup_Text_C_Introduction",
    Content = "PanelText_UI_Events_Panel_Xu_StageGroup_Text_C_Introduction_Content|由爱中生出怨，由怨中生出恨，黏稠的，绵连的，阴沉的……\n求天不应，遁地无门，于是那隐在夜雾中的笑语回应了你的呼唤，你不用付出任何代价。\n看向她，依从她，融于她，成为她。"
  },
  UI_Events_Panel_Xu_Text_C_Shop = {
    ID = "UI_Events_Panel_Xu_Text_C_Shop",
    Content = "PanelText_UI_Events_Panel_Xu_Text_C_Shop_Content|荒宅野奉"
  },
  UI_Events_Panel_Xu_Text_C_Reward = {
    ID = "UI_Events_Panel_Xu_Text_C_Reward",
    Content = "PanelText_UI_Events_Panel_Xu_Text_C_Reward_Content|成就奖励"
  },
  UI_Events_Panel_Xu_Text_C_Topic = {
    ID = "UI_Events_Panel_Xu_Text_C_Topic",
    Content = "PanelText_UI_Events_Panel_Xu_Text_C_Topic_Content|海城旧闻"
  },
  UI_Events_Panel_Xu_Text_C_Record = {
    ID = "UI_Events_Panel_Xu_Text_C_Record",
    Content = "PanelText_UI_Events_Panel_Xu_Text_C_Record_Content|意识潜游"
  },
  UI_Events_Panel_Xu_Text_C_RecordTip = {
    ID = "UI_Events_Panel_Xu_Text_C_RecordTip",
    Content = "PanelText_UI_Events_Panel_Xu_Text_C_RecordTip_Content|限时免费解锁"
  },
  UI_Events_Panel_Xu_Text_C_Challenge = {
    ID = "UI_Events_Panel_Xu_Text_C_Challenge",
    Content = "PanelText_UI_Events_Panel_Xu_Text_C_Challenge_Content|玄女无相"
  },
  UI_Events_Panel_Xu_Text_C_ChallengeTip = {
    ID = "UI_Events_Panel_Xu_Text_C_ChallengeTip",
    Content = "PanelText_UI_Events_Panel_Xu_Text_C_ChallengeTip_Content|玩法限时开放"
  },
  UI_Events_Panel_Main_Text_C_PermanentRule = {
    ID = "UI_Events_Panel_Main_Text_C_PermanentRule",
    Content = "PanelText_UI_Events_Panel_Main_Text_C_PermanentRule_Content|记忆回廊"
  },
  UI_Events_Panel_Main_Text_C_PermanentActivity = {
    ID = "UI_Events_Panel_Main_Text_C_PermanentActivity",
    Content = "PanelText_UI_Events_Panel_Main_Text_C_PermanentActivity_Content|记忆回廊"
  },
  UI_Dungeous_Panel_RailWay_Text_C_Title = {
    ID = "UI_Dungeous_Panel_RailWay_Text_C_Title",
    Content = "PanelText_UI_Dungeous_Panel_RailWay_Text_C_Title_Content|疾驰的欢愉专列"
  },
  UI_Dungeous_Panel_RailWay_Text_C_Rank = {
    ID = "UI_Dungeous_Panel_RailWay_Text_C_Rank",
    Content = "PanelText_UI_Dungeous_Panel_RailWay_Text_C_Rank_Content|贵宾名录"
  },
  UI_Dungeous_Panel_RailWay_Text_C_Resonance = {
    ID = "UI_Dungeous_Panel_RailWay_Text_C_Resonance",
    Content = "PanelText_UI_Dungeous_Panel_RailWay_Text_C_Resonance_Content|小「N」的协助"
  },
  UI_Dungeous_Panel_RailWay_Text_C_Record = {
    ID = "UI_Dungeous_Panel_RailWay_Text_C_Record",
    Content = "PanelText_UI_Dungeous_Panel_RailWay_Text_C_Record_Content|沿途留影"
  },
  UI_Dungeous_Panel_RailWay_Text_C_Experience = {
    ID = "UI_Dungeous_Panel_RailWay_Text_C_Experience",
    Content = "PanelText_UI_Dungeous_Panel_RailWay_Text_C_Experience_Content|雅室规格"
  },
  UI_Dungeous_Panel_RailWay_Text_C_Challenge = {
    ID = "UI_Dungeous_Panel_RailWay_Text_C_Challenge",
    Content = "PanelText_UI_Dungeous_Panel_RailWay_Text_C_Challenge_Content|挑战"
  },
  UI_Dungeous_Panel_RailWay_Text_C_Choose = {
    ID = "UI_Dungeous_Panel_RailWay_Text_C_Choose",
    Content = "PanelText_UI_Dungeous_Panel_RailWay_Text_C_Choose_Content|选择难度"
  },
  UI_Dungeous_Panel_RailWay_Text_C_Normal = {
    ID = "UI_Dungeous_Panel_RailWay_Text_C_Normal",
    Content = "PanelText_UI_Dungeous_Panel_RailWay_Text_C_Normal_Content|普通"
  },
  UI_Dungeous_Panel_RailWay_Text_C_Hard = {
    ID = "UI_Dungeous_Panel_RailWay_Text_C_Hard",
    Content = "PanelText_UI_Dungeous_Panel_RailWay_Text_C_Hard_Content|困难"
  },
  UI_Dungeous_Panel_RailWay_Text_C_Madness = {
    ID = "UI_Dungeous_Panel_RailWay_Text_C_Madness",
    Content = "PanelText_UI_Dungeous_Panel_RailWay_Text_C_Madness_Content|癫狂"
  },
  UI_Events_Panel_PermanentActivity_Text_C_Reward = {
    ID = "UI_Events_Panel_PermanentActivity_Text_C_Reward",
    Content = "PanelText_UI_Events_Panel_PermanentActivity_Text_C_Reward_Content|剩余奖励"
  },
  UI_Dungeons_Popup_RailWayRank_Text_C_Title = {
    ID = "UI_Dungeons_Popup_RailWayRank_Text_C_Title",
    Content = "PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Title_Content|贵宾名录"
  },
  UI_Dungeons_Popup_RailWayRank_Text_C_NoTask = {
    ID = "UI_Dungeons_Popup_RailWayRank_Text_C_NoTask",
    Content = "PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_NoTask_Content|暂无记录"
  },
  UI_Dungeons_Popup_RailWayRank_Text_C_En = {
    ID = "UI_Dungeons_Popup_RailWayRank_Text_C_En",
    Content = "PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_En_Content|fdshsjfgjgf"
  },
  UI_Dungeons_Popup_RailWayRank_Text_C_Rank = {
    ID = "UI_Dungeons_Popup_RailWayRank_Text_C_Rank",
    Content = "PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Rank_Content|排名"
  },
  UI_Dungeons_Popup_RailWayRank_Text_C_Info = {
    ID = "UI_Dungeons_Popup_RailWayRank_Text_C_Info",
    Content = "PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Info_Content|守密人信息"
  },
  UI_Dungeons_Popup_RailWayRank_Text_C_Exp = {
    ID = "UI_Dungeons_Popup_RailWayRank_Text_C_Exp",
    Content = "PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Exp_Content|最高进度"
  },
  UI_Dungeons_Popup_RailWayRank_Text_C_Round = {
    ID = "UI_Dungeons_Popup_RailWayRank_Text_C_Round",
    Content = "PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Round_Content|回合数"
  },
  UI_Dungeons_Item_RailWayRank_Text_C_Uid = {
    ID = "UI_Dungeons_Item_RailWayRank_Text_C_Uid",
    Content = "PanelText_UI_Dungeons_Item_RailWayRank_Text_C_Uid_Content|UID:"
  },
  UI_Dungeons_Item_RailWayRank_Text_C_Null = {
    ID = "UI_Dungeons_Item_RailWayRank_Text_C_Null",
    Content = "PanelText_UI_Dungeons_Item_RailWayRank_Text_C_Null_Content|暂无编队"
  },
  UI_Dungeons_Popup_RailWayRank_Text_C_Team = {
    ID = "UI_Dungeons_Popup_RailWayRank_Text_C_Team",
    Content = "PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Team_Content|编队"
  },
  UI_Events_Panel_RailWay_Text_C_Reward = {
    ID = "UI_Events_Panel_RailWay_Text_C_Reward",
    Content = "PanelText_UI_Events_Panel_RailWay_Text_C_Reward_Content|专列轨迹"
  },
  UI_Events_Panel_RailWay_Text_C_Topic = {
    ID = "UI_Events_Panel_RailWay_Text_C_Topic",
    Content = "PanelText_UI_Events_Panel_RailWay_Text_C_Topic_Content|疾驰的欢愉专列"
  },
  UI_Events_Panel_RailWay_Text_C_Record = {
    ID = "UI_Events_Panel_RailWay_Text_C_Record",
    Content = "PanelText_UI_Events_Panel_RailWay_Text_C_Record_Content|特遣纪录"
  },
  UI_Events_Panel_RailWay_Text_C_RecordTip = {
    ID = "UI_Events_Panel_RailWay_Text_C_RecordTip",
    Content = "PanelText_UI_Events_Panel_RailWay_Text_C_RecordTip_Content|限时免费解锁"
  },
  UI_Events_Panel_RailWay_Text_C_Challenge = {
    ID = "UI_Events_Panel_RailWay_Text_C_Challenge",
    Content = "PanelText_UI_Events_Panel_RailWay_Text_C_Challenge_Content|列车启程"
  },
  UI_Events_Panel_RailWay_Text_C_ChallengeTip = {
    ID = "UI_Events_Panel_RailWay_Text_C_ChallengeTip"
  },
  UI_Events_Panel_RailWay_Text_C_Resonance = {
    ID = "UI_Events_Panel_RailWay_Text_C_Resonance",
    Content = "PanelText_UI_Events_Panel_RailWay_Text_C_Resonance_Content|小「N」的协助"
  },
  UI_Events_Panel_RailWay_Text_C_Diagonal = {
    ID = "UI_Events_Panel_RailWay_Text_C_Diagonal",
    Content = "PanelText_UI_Events_Panel_RailWay_Text_C_Diagonal_Content|/"
  },
  UI_Events_Panel_RailWay_Text_C_Rank = {
    ID = "UI_Events_Panel_RailWay_Text_C_Rank",
    Content = "PanelText_UI_Events_Panel_RailWay_Text_C_Rank_Content|贵宾名录"
  },
  UI_Events_Panel_RailWay_StageGroup_Text_C_Title = {
    ID = "UI_Events_Panel_RailWay_StageGroup_Text_C_Title",
    Content = "PanelText_UI_Events_Panel_RailWay_StageGroup_Text_C_Title_Content|列车启程"
  },
  UI_Dungeons_Popup_RailWayRank_Text_C_Replay = {
    ID = "UI_Dungeons_Popup_RailWayRank_Text_C_Replay",
    Content = "PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Replay_Content|记录"
  },
  UI_Bag_Panel_AppearancePreview_Text_C_NoTask = {
    ID = "UI_Bag_Panel_AppearancePreview_Text_C_NoTask",
    Content = "PanelText_UI_Bag_Panel_AppearancePreview_Text_C_NoTask_Content|已获得所有外观"
  },
  UI_Bag_Panel_AppearancePreview_Text_C_En = {
    ID = "UI_Bag_Panel_AppearancePreview_Text_C_En",
    Content = "PanelText_UI_Bag_Panel_AppearancePreview_Text_C_En_Content|fdshsjfgjgf"
  },
  UI_Copy_Item_StoryChapter_Text_C_Free_Unlock = {
    ID = "UI_Copy_Item_StoryChapter_Text_C_Free_Unlock",
    Content = "PanelText_UI_Copy_Item_StoryChapter_Text_C_Free_Unlock_Content|限时免费解锁"
  },
  UI_Copy_Item_StoryChapter_Text_C_Award = {
    ID = "UI_Copy_Item_StoryChapter_Text_C_Award",
    Content = "PanelText_UI_Copy_Item_StoryChapter_Text_C_Award_Content|已归档"
  },
  UI_Events_Panel_Mosk_StageGroup_Text_C_Title = {
    ID = "UI_Events_Panel_Mosk_StageGroup_Text_C_Title",
    Content = "PanelText_UI_Events_Panel_Mosk_StageGroup_Text_C_Title_Content|莫丝与海"
  },
  UI_Events_Panel_Mosk_StageGroup_Text_C_Introduction = {
    ID = "UI_Events_Panel_Mosk_StageGroup_Text_C_Introduction",
    Content = "PanelText_UI_Events_Panel_Mosk_StageGroup_Text_C_Introduction_Content|天空~晴朗~大海~平静~\n莫丝~朋友~小煤球~出航！\n风暴，不怕，闪电，不怕，莫丝，朋友，小煤球~\n为了自由，要·出·发！"
  },
  UI_Events_Panel_Mosk_Text_C_Shop = {
    ID = "UI_Events_Panel_Mosk_Text_C_Shop",
    Content = "PanelText_UI_Events_Panel_Mosk_Text_C_Shop_Content|莫丝的宝库"
  },
  UI_Events_Panel_Mosk_Text_C_Reward = {
    ID = "UI_Events_Panel_Mosk_Text_C_Reward",
    Content = "PanelText_UI_Events_Panel_Mosk_Text_C_Reward_Content|成就奖励"
  },
  UI_Events_Panel_Mosk_Text_C_Topic = {
    ID = "UI_Events_Panel_Mosk_Text_C_Topic",
    Content = "PanelText_UI_Events_Panel_Mosk_Text_C_Topic_Content|默斯克斯的呼唤"
  },
  UI_Events_Panel_Mosk_Text_C_Record = {
    ID = "UI_Events_Panel_Mosk_Text_C_Record",
    Content = "PanelText_UI_Events_Panel_Mosk_Text_C_Record_Content|沉溺"
  },
  UI_Events_Panel_Mosk_Text_C_RecordTip = {
    ID = "UI_Events_Panel_Mosk_Text_C_RecordTip",
    Content = "PanelText_UI_Events_Panel_Mosk_Text_C_RecordTip_Content|限时免费解锁"
  },
  UI_Events_Panel_Mosk_Text_C_Challenge = {
    ID = "UI_Events_Panel_Mosk_Text_C_Challenge",
    Content = "PanelText_UI_Events_Panel_Mosk_Text_C_Challenge_Content|莫丝与海"
  },
  UI_Events_Panel_Mosk_Text_C_ChallengeTip = {
    ID = "UI_Events_Panel_Mosk_Text_C_ChallengeTip",
    Content = "PanelText_UI_Events_Panel_Mosk_Text_C_ChallengeTip_Content|玩法限时开放"
  },
  UI_Summon_Panel_SelectLimit_Text_C_Title = {
    ID = "UI_Summon_Panel_SelectLimit_Text_C_Title",
    Content = "PanelText_UI_Summon_Panel_SelectLimit_Text_C_Title_Content|已指定唤醒体"
  },
  UI_Summon_Popup_SelectLimit_Text_C_InfoTitle = {
    ID = "UI_Summon_Popup_SelectLimit_Text_C_InfoTitle",
    Content = "PanelText_UI_Summon_Popup_SelectLimit_Text_C_InfoTitle_Content|玩法说明"
  },
  UI_Summon_Popup_SelectLimit_Text_C_ChooseTitle = {
    ID = "UI_Summon_Popup_SelectLimit_Text_C_ChooseTitle",
    Content = "PanelText_UI_Summon_Popup_SelectLimit_Text_C_ChooseTitle_Content|选择唤醒体"
  },
  UI_Summon_Item_OptionalLimit_Text_C_Have = {
    ID = "UI_Summon_Item_OptionalLimit_Text_C_Have",
    Content = "PanelText_UI_Summon_Item_OptionalLimit_Text_C_Have_Content|已拥有"
  },
  UI_Summon_Item_OptionalLimit_Text_C_Full = {
    ID = "UI_Summon_Item_OptionalLimit_Text_C_Full",
    Content = "PanelText_UI_Summon_Item_OptionalLimit_Text_C_Full_Content|叠位已满"
  },
  UI_Summon_Item_OptionalLimit_Text_C_Max = {
    ID = "UI_Summon_Item_OptionalLimit_Text_C_Max",
    Content = "PanelText_UI_Summon_Item_OptionalLimit_Text_C_Max_Content|MAX"
  },
  UI_Summon_Popup_OptionalLimit_Text_C_Tip = {
    ID = "UI_Summon_Popup_OptionalLimit_Text_C_Tip",
    Content = "PanelText_UI_Summon_Popup_OptionalLimit_Text_C_Tip_Content|长按唤醒体查看详情"
  },
  UI_Summon_Popup_OptionalLimit_Text_C_Confirm = {
    ID = "UI_Summon_Popup_OptionalLimit_Text_C_Confirm",
    Content = "PanelText_UI_Summon_Popup_OptionalLimit_Text_C_Confirm_Content|完成选择"
  },
  UI_Summon_Panel_SelectLimit_Text_C_Choose = {
    ID = "UI_Summon_Panel_SelectLimit_Text_C_Choose",
    Content = "PanelText_UI_Summon_Panel_SelectLimit_Text_C_Choose_Content|开始选择"
  },
  UI_Summon_Item_SelectLimit_Text_C_Up = {
    ID = "UI_Summon_Item_SelectLimit_Text_C_Up",
    Content = "PanelText_UI_Summon_Item_SelectLimit_Text_C_Up_Content|UP!"
  },
  UI_Social_Item_Pvp_Text_C_Dispaly = {
    ID = "UI_Social_Item_Pvp_Text_C_Dispaly",
    Content = "PanelText_UI_Social_Item_Pvp_Text_C_Dispaly_Content|开放战斗记录"
  },
  UI_Summon_Popup_SelectLimit_Text_C_Choose = {
    ID = "UI_Summon_Popup_SelectLimit_Text_C_Choose",
    Content = "PanelText_UI_Summon_Popup_SelectLimit_Text_C_Choose_Content|开始选择"
  },
  UI_Recharge_Panel_Main_Text_C_RewardTip1 = {
    ID = "UI_Recharge_Panel_Main_Text_C_RewardTip1",
    Content = "PanelText_UI_Recharge_Panel_Main_Text_C_RewardTip1_Content|每日登录累计可得\n「银芯」<color=#57F8FE><size=38>×6000</size></color>！"
  },
  UI_Recharge_Panel_Main_Text_C_RewardTip2 = {
    ID = "UI_Recharge_Panel_Main_Text_C_RewardTip2",
    Content = "PanelText_UI_Recharge_Panel_Main_Text_C_RewardTip2_Content|每日登录累计可得\n「灵啡肽」<color=#57F8FE><size=38>×6000</size></color> 和「追念羽笔」<color=#57F8FE><size=38>×600</size></color>！"
  },
  UI_Passport_Popup_Recharge_Text_Title = {
    ID = "UI_Passport_Popup_Recharge_Text_Title",
    Content = "PanelText_UI_Passport_Popup_Recharge_Text_Title_Content|购买确认"
  },
  UI_Passport_Popup_Recharge_Text_Cancel_Name = {
    ID = "UI_Passport_Popup_Recharge_Text_Cancel_Name",
    Content = "PanelText_UI_Passport_Popup_Recharge_Text_Cancel_Name_Content|取消"
  },
  UI_Passport_Popup_Recharge_Text_Confirm_Name = {
    ID = "UI_Passport_Popup_Recharge_Text_Confirm_Name",
    Content = "PanelText_UI_Passport_Popup_Recharge_Text_Confirm_Name_Content|确定"
  },
  RedPoint_New_Text_C_New = {
    ID = "RedPoint_New_Text_C_New",
    Content = "PanelText_RedPoint_New_Text_C_New_Content|新"
  },
  UI_Pvp_Panel_Main_1_Text_C_Rule = {
    ID = "UI_Pvp_Panel_Main_1_Text_C_Rule",
    Content = "PanelText_UI_Pvp_Panel_Main_1_Text_C_Rule_Content|规则说明"
  },
  UI_Dungeons_Popup_RailWayRank_Text_C_Rank_Nor = {
    ID = "UI_Dungeons_Popup_RailWayRank_Text_C_Rank_Nor",
    Content = "PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Rank_Nor_Content|赛季排行"
  },
  UI_Dungeons_Popup_RailWayRank_Text_C_Rank_Sel = {
    ID = "UI_Dungeons_Popup_RailWayRank_Text_C_Rank_Sel",
    Content = "PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Rank_Sel_Content|赛季排行"
  },
  UI_Dungeons_Popup_RailWayRank_Text_C_RankAward_Nor = {
    ID = "UI_Dungeons_Popup_RailWayRank_Text_C_RankAward_Nor",
    Content = "PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_RankAward_Nor_Content|排行奖励"
  },
  UI_Dungeons_Popup_RailWayRank_Text_C_RankAward_Sel = {
    ID = "UI_Dungeons_Popup_RailWayRank_Text_C_RankAward_Sel",
    Content = "PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_RankAward_Sel_Content|排行奖励"
  },
  UI_Dungeons_Popup_RailWayRank_Text_C_Grade = {
    ID = "UI_Dungeons_Popup_RailWayRank_Text_C_Grade",
    Content = "PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Grade_Content|调查头衔"
  },
  UI_Dungeons_Popup_RailWayRank_Text_C_Big = {
    ID = "UI_Dungeons_Popup_RailWayRank_Text_C_Big",
    Content = "PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Big_Content|排名范围"
  },
  UI_Dungeons_Popup_RailWayRank_Text_C_Reward = {
    ID = "UI_Dungeons_Popup_RailWayRank_Text_C_Reward",
    Content = "PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Reward_Content|奖励"
  },
  UI_Main_Panel_1_Text_C_Recruit = {
    ID = "UI_Main_Panel_1_Text_C_Recruit",
    Content = "PanelText_UI_Main_Panel_1_Text_C_Recruit_Content|唤醒"
  },
  UI_Main_Panel_1_Text_C_Dengji = {
    ID = "UI_Main_Panel_1_Text_C_Dengji",
    Content = "PanelText_UI_Main_Panel_1_Text_C_Dengji_Content|Lv."
  },
  UI_Main_Panel_1_Text_C_Awaker = {
    ID = "UI_Main_Panel_1_Text_C_Awaker",
    Content = "PanelText_UI_Main_Panel_1_Text_C_Awaker_Content|唤醒体"
  },
  UI_Main_Panel_1_Text_C_Bag = {
    ID = "UI_Main_Panel_1_Text_C_Bag",
    Content = "PanelText_UI_Main_Panel_1_Text_C_Bag_Content|物资"
  },
  UI_Main_Panel_1_Text_C_Dbg = {
    ID = "UI_Main_Panel_1_Text_C_Dbg",
    Content = "PanelText_UI_Main_Panel_1_Text_C_Dbg_Content|幕间演习"
  },
  UI_Main_Panel_1_Text_C_Lesson = {
    ID = "UI_Main_Panel_1_Text_C_Lesson",
    Content = "PanelText_UI_Main_Panel_1_Text_C_Lesson_Content|学期课题"
  },
  UI_Main_Panel_1_Text_C_GamePassport = {
    ID = "UI_Main_Panel_1_Text_C_GamePassport",
    Content = "PanelText_UI_Main_Panel_1_Text_C_GamePassport_Content|守密纪行"
  },
  UI_Main_Panel_1_Text_C_Mission = {
    ID = "UI_Main_Panel_1_Text_C_Mission",
    Content = "PanelText_UI_Main_Panel_1_Text_C_Mission_Content|学籍档案"
  },
  UI_Main_Panel_1_Text_C_Recall = {
    ID = "UI_Main_Panel_1_Text_C_Recall",
    Content = "PanelText_UI_Main_Panel_1_Text_C_Recall_Content|记忆回廊"
  },
  UI_Main_Panel_1_Text_C_DungeonNote = {
    ID = "UI_Main_Panel_1_Text_C_DungeonNote",
    Content = "PanelText_UI_Main_Panel_1_Text_C_DungeonNote_Content|密境课室"
  },
  UI_Main_Panel_1_Text_C_Store = {
    ID = "UI_Main_Panel_1_Text_C_Store",
    Content = "PanelText_UI_Main_Panel_1_Text_C_Store_Content|弥萨格商店"
  },
  UI_GuideNote_Item_Task_Text_C_Recieve = {
    ID = "UI_GuideNote_Item_Task_Text_C_Recieve",
    Content = "PanelText_UI_GuideNote_Item_Task_Text_C_Recieve_Content|领取"
  },
  UI_Passport_Reward_Item_New_Text_C_GainExperience = {
    ID = "UI_Passport_Reward_Item_New_Text_C_GainExperience",
    Content = "PanelText_UI_Passport_Reward_Item_New_Text_C_GainExperience_Content|获取经验"
  },
  UI_GuideNote_Panel_AwakerStrength_Text_C_Change = {
    ID = "UI_GuideNote_Panel_AwakerStrength_Text_C_Change",
    Content = "PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_Change_Content|更换"
  },
  UI_GuideNote_Panel_AwakerStrength_Text_C_Detail = {
    ID = "UI_GuideNote_Panel_AwakerStrength_Text_C_Detail",
    Content = "PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_Detail_Content|详情"
  },
  UI_GuideNote_Panel_AwakerStrength_Text_C_More = {
    ID = "UI_GuideNote_Panel_AwakerStrength_Text_C_More",
    Content = "PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_More_Content|更多提升"
  },
  UI_GuideNote_Panel_AwakerStrength_Text_C_Level = {
    ID = "UI_GuideNote_Panel_AwakerStrength_Text_C_Level",
    Content = "PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_Level_Content|等级"
  },
  UI_GuideNote_Panel_AwakerStrength_Text_C_Skill = {
    ID = "UI_GuideNote_Panel_AwakerStrength_Text_C_Skill",
    Content = "PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_Skill_Content|技能"
  },
  UI_GuideNote_Panel_AwakerStrength_Text_C_ExcludeTalent = {
    ID = "UI_GuideNote_Panel_AwakerStrength_Text_C_ExcludeTalent",
    Content = "PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_ExcludeTalent_Content|天赋"
  },
  UI_GuideNote_Panel_AwakerStrength_Text_C_Talent = {
    ID = "UI_GuideNote_Panel_AwakerStrength_Text_C_Talent",
    Content = "PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_Talent_Content|天赋"
  },
  UI_GuideNote_Panel_AwakerStrength_Text_C_Choose = {
    ID = "UI_GuideNote_Panel_AwakerStrength_Text_C_Choose",
    Content = "PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_Choose_Content|点击选择唤醒体"
  },
  UI_GuideNote_Panel_AwakerStrength_Text_C_NoTask = {
    ID = "UI_GuideNote_Panel_AwakerStrength_Text_C_NoTask",
    Content = "PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_NoTask_Content|选择一名唤醒体"
  },
  UI_GuideNote_Panel_AwakerStrength_Text_C_Time = {
    ID = "UI_GuideNote_Panel_AwakerStrength_Text_C_Time",
    Content = "PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_Time_Content|去其他地方看看吧"
  },
  UI_GuideNote_Panel_AwakerStrength_Text_C_En = {
    ID = "UI_GuideNote_Panel_AwakerStrength_Text_C_En",
    Content = "PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_En_Content|fdshsjfgjgf"
  },
  UI_GuideNote_Item_Material_Text_C_Goto = {
    ID = "UI_GuideNote_Item_Material_Text_C_Goto",
    Content = "PanelText_UI_GuideNote_Item_Material_Text_C_Goto_Content|前往"
  },
  UI_GuideNote_Item_Material_Text_C_Sweep = {
    ID = "UI_GuideNote_Item_Material_Text_C_Sweep",
    Content = "PanelText_UI_GuideNote_Item_Material_Text_C_Sweep_Content|重现"
  },
  UI_GuideNote_Item_Trinket_Text_C_Source = {
    ID = "UI_GuideNote_Item_Trinket_Text_C_Source",
    Content = "PanelText_UI_GuideNote_Item_Trinket_Text_C_Source_Content|获取来源"
  },
  UI_GuideNote_Popup_ResSummary_Text_C_Title = {
    ID = "UI_GuideNote_Popup_ResSummary_Text_C_Title",
    Content = "PanelText_UI_GuideNote_Popup_ResSummary_Text_C_Title_Content|调查行动"
  },
  UI_GuideNote_Popup_ResSummary_Text_C_ProgressTitle = {
    ID = "UI_GuideNote_Popup_ResSummary_Text_C_ProgressTitle",
    Content = "PanelText_UI_GuideNote_Popup_ResSummary_Text_C_ProgressTitle_Content|玩法进度"
  },
  UI_GuideNote_Popup_ResSummary_Text_C_ItemsPreview = {
    ID = "UI_GuideNote_Popup_ResSummary_Text_C_ItemsPreview",
    Content = "PanelText_UI_GuideNote_Popup_ResSummary_Text_C_ItemsPreview_Content|剩余资源预览"
  },
  UI_GuideNote_Popup_ResSummary_Text_C_Null = {
    ID = "UI_GuideNote_Popup_ResSummary_Text_C_Null",
    Content = "PanelText_UI_GuideNote_Popup_ResSummary_Text_C_Null_Content|无剩余资源"
  },
  UI_GuideNote_PermTrainBase_Text_C_Goto = {
    ID = "UI_GuideNote_PermTrainBase_Text_C_Goto",
    Content = "PanelText_UI_GuideNote_PermTrainBase_Text_C_Goto_Content|前往"
  },
  UI_GuideNote_Panel_PermTrain_Text_C_Goto_Pvp = {
    ID = "UI_GuideNote_Panel_PermTrain_Text_C_Goto_Pvp",
    Content = "PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Goto_Pvp_Content|前往"
  },
  UI_GuideNote_Panel_PermTrain_Text_C_Title_Pvp = {
    ID = "UI_GuideNote_Panel_PermTrain_Text_C_Title_Pvp",
    Content = "PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Title_Pvp_Content|相位对弈 - 预组模式"
  },
  UI_GuideNote_Panel_PermTrain_Text_C_Score_Pvp = {
    ID = "UI_GuideNote_Panel_PermTrain_Text_C_Score_Pvp",
    Content = "PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Score_Pvp_Content|积分"
  },
  UI_GuideNote_Panel_PermTrain_Text_C_Reward_Pvp = {
    ID = "UI_GuideNote_Panel_PermTrain_Text_C_Reward_Pvp",
    Content = "PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Reward_Pvp_Content|排行奖励"
  },
  UI_GuideNote_Panel_PermTrain_Text_C_Goto_RotationMode = {
    ID = "UI_GuideNote_Panel_PermTrain_Text_C_Goto_RotationMode",
    Content = "PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Goto_RotationMode_Content|前往"
  },
  UI_GuideNote_Panel_PermTrain_Text_C_Title_RotationMode = {
    ID = "UI_GuideNote_Panel_PermTrain_Text_C_Title_RotationMode",
    Content = "PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Title_RotationMode_Content|相位对弈 - 轮选模式"
  },
  UI_GuideNote_Panel_PermTrain_Text_C_Score_RotationMode = {
    ID = "UI_GuideNote_Panel_PermTrain_Text_C_Score_RotationMode",
    Content = "PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Score_RotationMode_Content|积分"
  },
  UI_GuideNote_Panel_PermTrain_Text_C_Reward_RotationMode = {
    ID = "UI_GuideNote_Panel_PermTrain_Text_C_Reward_RotationMode",
    Content = "PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Reward_RotationMode_Content|排行奖励"
  },
  UI_GuideNote_Panel_PermTrain_Text_C_Goto_Abyss = {
    ID = "UI_GuideNote_Panel_PermTrain_Text_C_Goto_Abyss",
    Content = "PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Goto_Abyss_Content|前往"
  },
  UI_GuideNote_Panel_PermTrain_Text_C_Title_Abyss = {
    ID = "UI_GuideNote_Panel_PermTrain_Text_C_Title_Abyss",
    Content = "PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Title_Abyss_Content|融灾禁区"
  },
  UI_GuideNote_Panel_PermTrain_Text_C_Reward_Abyss = {
    ID = "UI_GuideNote_Panel_PermTrain_Text_C_Reward_Abyss",
    Content = "PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Reward_Abyss_Content|剩余奖励"
  },
  UI_GuideNote_Panel_PermTrain_Text_C_Goto_DailyChallenge = {
    ID = "UI_GuideNote_Panel_PermTrain_Text_C_Goto_DailyChallenge",
    Content = "PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Goto_DailyChallenge_Content|前往"
  },
  UI_GuideNote_Panel_PermTrain_Text_C_Title_DailyChallenge = {
    ID = "UI_GuideNote_Panel_PermTrain_Text_C_Title_DailyChallenge",
    Content = "PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Title_DailyChallenge_Content|幻梦深潜"
  },
  UI_GuideNote_Panel_PermTrain_Text_C_Score_DailyChallenge = {
    ID = "UI_GuideNote_Panel_PermTrain_Text_C_Score_DailyChallenge",
    Content = "PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Score_DailyChallenge_Content|积分"
  },
  UI_GuideNote_Panel_PermTrain_Text_C_Reward_DailyChallenge = {
    ID = "UI_GuideNote_Panel_PermTrain_Text_C_Reward_DailyChallenge",
    Content = "PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Reward_DailyChallenge_Content|排行奖励"
  },
  UI_GuideNote_Panel_PermTrain_Text_C_Goto_RailyWay = {
    ID = "UI_GuideNote_Panel_PermTrain_Text_C_Goto_RailyWay",
    Content = "PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Goto_RailyWay_Content|前往"
  },
  UI_GuideNote_Panel_PermTrain_Text_C_Title_RailyWay = {
    ID = "UI_GuideNote_Panel_PermTrain_Text_C_Title_RailyWay",
    Content = "PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Title_RailyWay_Content|疾驰的欢愉专列"
  },
  UI_GuideNote_Panel_PermTrain_Text_C_Score_RailyWay = {
    ID = "UI_GuideNote_Panel_PermTrain_Text_C_Score_RailyWay",
    Content = "PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Score_RailyWay_Content|赛季进度"
  },
  UI_GuideNote_Panel_PermTrain_Text_C_Reward_RailyWay = {
    ID = "UI_GuideNote_Panel_PermTrain_Text_C_Reward_RailyWay",
    Content = "PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Reward_RailyWay_Content|排行奖励"
  },
  UI_GuideNote_Panel_PermTrain_Text_C_Rank_Abyss = {
    ID = "UI_GuideNote_Panel_PermTrain_Text_C_Rank_Abyss",
    Content = "PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Rank_Abyss_Content|排名"
  },
  UI_GuideNote_Item_Material_Text_C_Full = {
    ID = "UI_GuideNote_Item_Material_Text_C_Full",
    Content = "PanelText_UI_GuideNote_Item_Material_Text_C_Full_Content|素材已满足"
  },
  UI_Dungeons_Popup_RailWayRank_Text_C_DivingTitle = {
    ID = "UI_Dungeons_Popup_RailWayRank_Text_C_DivingTitle",
    Content = "PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_DivingTitle_Content|调查头衔"
  },
  UI_Events_Panel_Arachne_Text_C_Shop = {
    ID = "UI_Events_Panel_Arachne_Text_C_Shop",
    Content = "PanelText_UI_Events_Panel_Arachne_Text_C_Shop_Content|剧院礼品店"
  },
  UI_Events_Panel_Arachne_Text_C_Reward = {
    ID = "UI_Events_Panel_Arachne_Text_C_Reward",
    Content = "PanelText_UI_Events_Panel_Arachne_Text_C_Reward_Content|成就奖励"
  },
  UI_Events_Panel_Arachne_Text_C_Topic = {
    ID = "UI_Events_Panel_Arachne_Text_C_Topic",
    Content = "PanelText_UI_Events_Panel_Arachne_Text_C_Topic_Content|织者自缚"
  },
  UI_Events_Panel_Arachne_Text_C_Record = {
    ID = "UI_Events_Panel_Arachne_Text_C_Record",
    Content = "PanelText_UI_Events_Panel_Arachne_Text_C_Record_Content|特遣纪录"
  },
  UI_Events_Panel_Arachne_Text_C_RecordTip = {
    ID = "UI_Events_Panel_Arachne_Text_C_RecordTip",
    Content = "PanelText_UI_Events_Panel_Arachne_Text_C_RecordTip_Content|限时免费解锁"
  },
  UI_Events_Panel_Arachne_Text_C_Challenge = {
    ID = "UI_Events_Panel_Arachne_Text_C_Challenge",
    Content = "PanelText_UI_Events_Panel_Arachne_Text_C_Challenge_Content|木偶的舞台"
  },
  UI_Events_Panel_Arachne_Text_C_ChallengeTip = {
    ID = "UI_Events_Panel_Arachne_Text_C_ChallengeTip",
    Content = "PanelText_UI_Events_Panel_Arachne_Text_C_ChallengeTip_Content|玩法限时开放"
  },
  UI_Events_Panel_Arachne_StageGroup_Text_C_Title = {
    ID = "UI_Events_Panel_Arachne_StageGroup_Text_C_Title",
    Content = "PanelText_UI_Events_Panel_Arachne_StageGroup_Text_C_Title_Content|木偶的舞台"
  },
  UI_Events_Panel_Arachne_StageGroup_Text_C_Introduction = {
    ID = "UI_Events_Panel_Arachne_StageGroup_Text_C_Introduction",
    Content = "PanelText_UI_Events_Panel_Arachne_StageGroup_Text_C_Introduction_Content|灯光亮起。掌声平息。观众们期待着。\n上台的时候到了，我亲爱的孩子们。去登台，去表演，去撕开你们的肺腑，出卖你们最深的隐秘。去用你们最惨烈的伤口，做成供人取悦的甜点。去贪婪地享受舞台上那道只为你点亮的光，直到帷幕将你与观众一同埋葬。\n这是你们命中注定的舞台，登上它吧！不要害怕，无需怯场。"
  },
  UI_Events_Panel_Arachne_StageGroup_Text_C_Resonance = {
    ID = "UI_Events_Panel_Arachne_StageGroup_Text_C_Resonance",
    Content = "PanelText_UI_Events_Panel_Arachne_StageGroup_Text_C_Resonance_Content|共鸣"
  },
  UI_GuideNote_Item_Material_Text_C_Source = {
    ID = "UI_GuideNote_Item_Material_Text_C_Source",
    Content = "PanelText_UI_GuideNote_Item_Material_Text_C_Source_Content|获取来源"
  },
  UI_GuideNote_Item_Trinket_Text_C_Goto = {
    ID = "UI_GuideNote_Item_Trinket_Text_C_Goto",
    Content = "PanelText_UI_GuideNote_Item_Trinket_Text_C_Goto_Content|前往"
  },
  UI_GuideNote_Item_Trinket_Text_C_Sweep = {
    ID = "UI_GuideNote_Item_Trinket_Text_C_Sweep",
    Content = "PanelText_UI_GuideNote_Item_Trinket_Text_C_Sweep_Content|重现"
  },
  UI_Collection_Panel_LoginPV_Text_Title = {
    ID = "UI_Collection_Panel_LoginPV_Text_Title",
    Content = "PanelText_UI_Collection_Panel_LoginPV_Text_Title_Content|修改登录背景"
  },
  UI_Collection_Panel_LoginPV_Text_Title_En = {
    ID = "UI_Collection_Panel_LoginPV_Text_Title_En",
    Content = "PanelText_UI_Collection_Panel_LoginPV_Text_Title_En_Content|Login PV Modify"
  },
  UI_Story_Panel_Main_Text_C_Normal = {
    ID = "UI_Story_Panel_Main_Text_C_Normal",
    Content = "PanelText_UI_Story_Panel_Main_Text_C_Normal_Content|设为登录背景"
  },
  UI_Story_Panel_Main_Text_C_High = {
    ID = "UI_Story_Panel_Main_Text_C_High",
    Content = "PanelText_UI_Story_Panel_Main_Text_C_High_Content|重置登录背景"
  },
  UI_GuideNote_Popup_ResSummary_Text_C_Goto = {
    ID = "UI_GuideNote_Popup_ResSummary_Text_C_Goto",
    Content = "PanelText_UI_GuideNote_Popup_ResSummary_Text_C_Goto_Content|前往"
  },
  UI_Recharge_Panel_GiftBag_Text_C_Desc = {
    ID = "UI_Recharge_Panel_GiftBag_Text_C_Desc",
    Content = "PanelText_UI_Recharge_Panel_GiftBag_Text_C_Desc_Content|活动描述"
  },
  UI_Recharge_Panel_GiftBag_Text_C_SpecialTime = {
    ID = "UI_Recharge_Panel_GiftBag_Text_C_SpecialTime",
    Content = "PanelText_UI_Recharge_Panel_GiftBag_Text_C_SpecialTime_Content|剩余"
  },
  UI_Recharge_Panel_GiftBag_Text_C_Slogan = {
    ID = "UI_Recharge_Panel_GiftBag_Text_C_Slogan",
    Content = "PanelText_UI_Recharge_Panel_GiftBag_Text_C_Slogan_Content|仅限24小时！\n常驻唤醒体选择其一！"
  },
  UI_Recharge_Panel_GiftBag_Text_PayTip = {
    ID = "UI_Recharge_Panel_GiftBag_Text_PayTip",
    Content = "PanelText_UI_Recharge_Panel_GiftBag_Text_PayTip_Content|当前展示价格为默认货币价格，仅供参考。支付时请以实际货币和价格为准。"
  },
  UI_Awaker_Popup_Topped_Tip_Text_C_Need = {
    ID = "UI_Awaker_Popup_Topped_Tip_Text_C_Need",
    Content = "PanelText_UI_Awaker_Popup_Topped_Tip_Text_C_Need_Content|需要"
  },
  UI_Summon_Popup_SelectLimit_Text_Title = {
    ID = "UI_Summon_Popup_SelectLimit_Text_Title",
    Content = "PanelText_UI_Summon_Popup_SelectLimit_Text_Title_Content|选择唤醒体"
  },
  UI_Copy_Item_StoryChapter_Text_C_Lock = {
    ID = "UI_Copy_Item_StoryChapter_Text_C_Lock",
    Content = "PanelText_UI_Copy_Item_StoryChapter_Text_C_Lock_Content|尚未解锁"
  },
  UI_Common_Item_WuPin_Type1_Text_C_UpperLimit = {
    ID = "UI_Common_Item_WuPin_Type1_Text_C_UpperLimit",
    Content = "PanelText_UI_Common_Item_WuPin_Type1_Text_C_UpperLimit_Content|已达上限"
  },
  UI_Dungeons_Panel_CopyStatistics_Text_C_Awaker = {
    ID = "UI_Dungeons_Panel_CopyStatistics_Text_C_Awaker",
    Content = "PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_Awaker_Content|出战"
  },
  UI_Dungeons_Panel_CopyStatistics_Text_C_Damage = {
    ID = "UI_Dungeons_Panel_CopyStatistics_Text_C_Damage",
    Content = "PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_Damage_Content|造成伤害"
  },
  UI_Dungeons_Panel_CopyStatistics_Text_C_Shield = {
    ID = "UI_Dungeons_Panel_CopyStatistics_Text_C_Shield",
    Content = "PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_Shield_Content|造成护盾"
  },
  UI_Dungeons_Panel_CopyStatistics_Text_C_Heal = {
    ID = "UI_Dungeons_Panel_CopyStatistics_Text_C_Heal",
    Content = "PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_Heal_Content|造成治疗"
  },
  UI_Dungeons_Panel_CopyStatistics_Text_C_BattleStatistics = {
    ID = "UI_Dungeons_Panel_CopyStatistics_Text_C_BattleStatistics",
    Content = "PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_BattleStatistics_Content|战斗统计"
  },
  UI_Dungeons_Panel_CopyStatistics_Text_C_RoundStatistics = {
    ID = "UI_Dungeons_Panel_CopyStatistics_Text_C_RoundStatistics",
    Content = "PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_RoundStatistics_Content|回合统计"
  },
  UI_Dungeons_Panel_CopyStatistics_Text_C_All = {
    ID = "UI_Dungeons_Panel_CopyStatistics_Text_C_All",
    Content = "PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_All_Content|全部"
  },
  UI_Common_Item_WuPin_Type2_Text_C_Full = {
    ID = "UI_Common_Item_WuPin_Type2_Text_C_Full",
    Content = "PanelText_UI_Common_Item_WuPin_Type2_Text_C_Full_Content|叠位已满"
  },
  UI_Events_Item_RAIDProgressGroup_Text_C_Kill = {
    ID = "UI_Events_Item_RAIDProgressGroup_Text_C_Kill",
    Content = "PanelText_UI_Events_Item_RAIDProgressGroup_Text_C_Kill_Content|抓捕总数"
  },
  UI_Events_Panel_RAID_Text_C_Reward = {
    ID = "UI_Events_Panel_RAID_Text_C_Reward",
    Content = "PanelText_UI_Events_Panel_RAID_Text_C_Reward_Content|黑猫抓捕记录"
  },
  UI_Events_Panel_RAID_Text_C_Challenge = {
    ID = "UI_Events_Panel_RAID_Text_C_Challenge",
    Content = "PanelText_UI_Events_Panel_RAID_Text_C_Challenge_Content|猫海淘银"
  },
  UI_Events_Panel_RAID_Text_C_ChallengeTip = {
    ID = "UI_Events_Panel_RAID_Text_C_ChallengeTip",
    Content = "PanelText_UI_Events_Panel_RAID_Text_C_ChallengeTip_Content|玩法限时开放"
  },
  UI_Events_Panel_RAID_Text_C_Topic = {
    ID = "UI_Events_Panel_RAID_Text_C_Topic",
    Content = "PanelText_UI_Events_Panel_RAID_Text_C_Topic_Content|猫的「报恩」"
  },
  UI_Events_Item_RAID_Text_C_Finish = {
    ID = "UI_Events_Item_RAID_Text_C_Finish",
    Content = "PanelText_UI_Events_Item_RAID_Text_C_Finish_Content|已结束"
  },
  UI_Events_Item_RAID_Text_C_Kill = {
    ID = "UI_Events_Item_RAID_Text_C_Kill",
    Content = "PanelText_UI_Events_Item_RAID_Text_C_Kill_Content|已抓捕"
  },
  UI_Events_Item_RAID_Text_Lock = {
    ID = "UI_Events_Item_RAID_Text_Lock",
    Content = "PanelText_UI_Events_Item_RAID_Text_Lock_Content|尚未开放"
  },
  UI_Events_Panel_RAID_Text_C_Rank = {
    ID = "UI_Events_Panel_RAID_Text_C_Rank",
    Content = "PanelText_UI_Events_Panel_RAID_Text_C_Rank_Content|抓捕排行"
  },
  UI_Dungeous_Popup_Swept_Tip2_Text_C_RewardPreview = {
    ID = "UI_Dungeous_Popup_Swept_Tip2_Text_C_RewardPreview",
    Content = "PanelText_UI_Dungeous_Popup_Swept_Tip2_Text_C_RewardPreview_Content|奖励预览"
  },
  UI_Events_RAID_StageGroup_Text_C_Title = {
    ID = "UI_Events_RAID_StageGroup_Text_C_Title",
    Content = "PanelText_UI_Events_RAID_StageGroup_Text_C_Title_Content|猫海淘银"
  },
  UI_Events_RAID_StageGroup_Text_C_Introduction = {
    ID = "UI_Events_RAID_StageGroup_Text_C_Introduction",
    Content = "PanelText_UI_Events_RAID_StageGroup_Text_C_Introduction_Content|黑色，黑色，黑色……\n漆黑的怪物嘶吼着，咆哮着，狂舞着，如潮水般向你冲来。\n 「噗嗤——」\n「这只银芯怎么这么少，下次记得多带一点再来。」"
  },
  UI_Events_Panel_Saya_StageGroup_Text_C_Title = {
    ID = "UI_Events_Panel_Saya_StageGroup_Text_C_Title",
    Content = "PanelText_UI_Events_Panel_Saya_StageGroup_Text_C_Title_Content|暗室手记"
  },
  UI_Events_Panel_Saya_StageGroup_Text_C_Introduction = {
    ID = "UI_Events_Panel_Saya_StageGroup_Text_C_Introduction",
    Content = "PanelText_UI_Events_Panel_Saya_StageGroup_Text_C_Introduction_Content|科学，无关紧要。\n伦理，无关紧要。\n道德，无关紧要。\n生命，死亡，希望，绝望……最终的最终，地下室的笔记本上，用两种笔迹留下同一个推演。\n祂们说：「看，爱是唯一的、永恒的主题。」"
  },
  UI_Events_Panel_Saya_StageGroup_Text_C_Resonance = {
    ID = "UI_Events_Panel_Saya_StageGroup_Text_C_Resonance",
    Content = "PanelText_UI_Events_Panel_Saya_StageGroup_Text_C_Resonance_Content|共鸣"
  },
  UI_Events_Panel_Saya_Text_C_Shop = {
    ID = "UI_Events_Panel_Saya_Text_C_Shop",
    Content = "PanelText_UI_Events_Panel_Saya_Text_C_Shop_Content|蒲公英园圃"
  },
  UI_Events_Panel_Saya_Text_C_Reward = {
    ID = "UI_Events_Panel_Saya_Text_C_Reward",
    Content = "PanelText_UI_Events_Panel_Saya_Text_C_Reward_Content|成就奖励"
  },
  UI_Events_Panel_Saya_Text_C_Topic = {
    ID = "UI_Events_Panel_Saya_Text_C_Topic",
    Content = "PanelText_UI_Events_Panel_Saya_Text_C_Topic_Content|颠倒的新生"
  },
  UI_Events_Panel_Saya_Text_C_Record = {
    ID = "UI_Events_Panel_Saya_Text_C_Record",
    Content = "PanelText_UI_Events_Panel_Saya_Text_C_Record_Content|被遗忘的爱之种"
  },
  UI_Events_Panel_Saya_Text_C_RecordTip = {
    ID = "UI_Events_Panel_Saya_Text_C_RecordTip",
    Content = "PanelText_UI_Events_Panel_Saya_Text_C_RecordTip_Content|限时免费解锁"
  },
  UI_Events_Panel_Saya_Text_C_Challenge = {
    ID = "UI_Events_Panel_Saya_Text_C_Challenge",
    Content = "PanelText_UI_Events_Panel_Saya_Text_C_Challenge_Content|暗室手记"
  },
  UI_Events_Panel_Saya_Text_C_ChallengeTip = {
    ID = "UI_Events_Panel_Saya_Text_C_ChallengeTip",
    Content = "PanelText_UI_Events_Panel_Saya_Text_C_ChallengeTip_Content|玩法限时开放"
  },
  UI_Dungeons_Panel_CopyStatistics_Text_C_Null_BattleStatistics = {
    ID = "UI_Dungeons_Panel_CopyStatistics_Text_C_Null_BattleStatistics",
    Content = "PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_Null_BattleStatistics_Content|暂无数据"
  },
  UI_Dungeons_Panel_CopyStatistics_Text_C_Time_BattleStatistics = {
    ID = "UI_Dungeons_Panel_CopyStatistics_Text_C_Time_BattleStatistics",
    Content = "PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_Time_BattleStatistics_Content|去其他地方看看吧"
  },
  UI_Dungeons_Panel_CopyStatistics_Text_C_Null_RoundStatistics = {
    ID = "UI_Dungeons_Panel_CopyStatistics_Text_C_Null_RoundStatistics",
    Content = "PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_Null_RoundStatistics_Content|暂无数据"
  },
  UI_Dungeons_Panel_CopyStatistics_Text_C_Time_RoundStatistics = {
    ID = "UI_Dungeons_Panel_CopyStatistics_Text_C_Time_RoundStatistics",
    Content = "PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_Time_RoundStatistics_Content|去其他地方看看吧"
  },
  UI_Events_Item_RAID_Text_C_Career = {
    ID = "UI_Events_Item_RAID_Text_C_Career",
    Content = "PanelText_UI_Events_Item_RAID_Text_C_Career_Content|队伍要求"
  },
  UI_Events_Item_RAID_Text_CareerLimit = {
    ID = "UI_Events_Item_RAID_Text_CareerLimit",
    Content = "PanelText_UI_Events_Item_RAID_Text_CareerLimit_Content|不限"
  },
  UI_Summon_Panel_Main_Text_C_Summon = {
    ID = "UI_Summon_Panel_Main_Text_C_Summon",
    Content = "PanelText_UI_Summon_Panel_Main_Text_C_Summon_Content|唤醒5次"
  },
  UI_Shop_Item_Commodity_Text_C_Head = {
    ID = "UI_Shop_Item_Commodity_Text_C_Head",
    Content = "PanelText_UI_Shop_Item_Commodity_Text_C_Head_Content|头像"
  },
  UI_Copy_Story_View_Text_C_ReadTip = {
    ID = "UI_Copy_Story_View_Text_C_ReadTip",
    Content = "PanelText_UI_Copy_Story_View_Text_C_ReadTip_Content|推荐顺序仅代表推荐阅读顺序，不代表严格时间顺序。"
  },
  UI_Events_Panel_Pontos_Text_C_Shop = {
    ID = "UI_Events_Panel_Pontos_Text_C_Shop",
    Content = "PanelText_UI_Events_Panel_Pontos_Text_C_Shop_Content|无边猎场"
  },
  UI_Events_Panel_Pontos_Text_C_Reward = {
    ID = "UI_Events_Panel_Pontos_Text_C_Reward",
    Content = "PanelText_UI_Events_Panel_Pontos_Text_C_Reward_Content|成就奖励"
  },
  UI_Events_Panel_Pontos_Text_C_Topic = {
    ID = "UI_Events_Panel_Pontos_Text_C_Topic",
    Content = "PanelText_UI_Events_Panel_Pontos_Text_C_Topic_Content|永远的厄波扬斯"
  },
  UI_Events_Panel_Pontos_Text_C_Record = {
    ID = "UI_Events_Panel_Pontos_Text_C_Record",
    Content = "PanelText_UI_Events_Panel_Pontos_Text_C_Record_Content|意识潜游"
  },
  UI_Events_Panel_Pontos_Text_C_RecordTip = {
    ID = "UI_Events_Panel_Pontos_Text_C_RecordTip",
    Content = "PanelText_UI_Events_Panel_Pontos_Text_C_RecordTip_Content|限时免费解锁"
  },
  UI_Events_Panel_Pontos_Text_C_Challenge = {
    ID = "UI_Events_Panel_Pontos_Text_C_Challenge",
    Content = "PanelText_UI_Events_Panel_Pontos_Text_C_Challenge_Content|高屋巡猎"
  },
  UI_Events_Panel_Pontos_Text_C_ChallengeTip = {
    ID = "UI_Events_Panel_Pontos_Text_C_ChallengeTip",
    Content = "PanelText_UI_Events_Panel_Pontos_Text_C_ChallengeTip_Content|玩法限时开放"
  },
  UI_Events_Panel_Pontos_StageGroup_Text_C_Title = {
    ID = "UI_Events_Panel_Pontos_StageGroup_Text_C_Title",
    Content = "PanelText_UI_Events_Panel_Pontos_StageGroup_Text_C_Title_Content|高屋巡猎"
  },
  UI_Events_Panel_Pontos_StageGroup_Text_C_Introduction = {
    ID = "UI_Events_Panel_Pontos_StageGroup_Text_C_Introduction",
    Content = "PanelText_UI_Events_Panel_Pontos_StageGroup_Text_C_Introduction_Content|当不祥的白光再次穿透高屋的窗扉，他已经向你发出邀约。\n包容、吞没、裹挟、拥挤…… \n回应来自海洋深处的呼唤，加入这不休的巡猎， 你的过往、你的自我，一切都已无关紧要。"
  },
  UI_Events_Panel_Pontos_StageGroup_Text_C_Resonance = {
    ID = "UI_Events_Panel_Pontos_StageGroup_Text_C_Resonance",
    Content = "PanelText_UI_Events_Panel_Pontos_StageGroup_Text_C_Resonance_Content|共鸣"
  },
  UI_Battle_Popup_CardGroup_Text_C_Title = {
    ID = "UI_Battle_Popup_CardGroup_Text_C_Title",
    Content = "PanelText_UI_Battle_Popup_CardGroup_Text_C_Title_Content|选择一组卡牌"
  },
  UI_Battle_Popup_CardGroup_Text_C_Confirm = {
    ID = "UI_Battle_Popup_CardGroup_Text_C_Confirm",
    Content = "PanelText_UI_Battle_Popup_CardGroup_Text_C_Confirm_Content|确认"
  },
  UI_Battle_Popup_KeyTokenAwaken_Text_C_KeyTokenNewChaos = {
    ID = "UI_Battle_Popup_KeyTokenAwaken_Text_C_KeyTokenNewChaos",
    Content = "PanelText_UI_Battle_Popup_KeyTokenAwaken_Text_C_KeyTokenNewChaos_Content|释放"
  },
  UI_Battle_Popup_KeyTokenAwaken_Txt_C_NewChaosTitle = {
    ID = "UI_Battle_Popup_KeyTokenAwaken_Txt_C_NewChaosTitle",
    Content = "PanelText_UI_Battle_Popup_KeyTokenAwaken_Txt_C_NewChaosTitle_Content|复合钥令"
  },
  UI_Alchemy_Panel_Main_Text_C_ResolveItem = {
    ID = "UI_Alchemy_Panel_Main_Text_C_ResolveItem",
    Content = "PanelText_UI_Alchemy_Panel_Main_Text_C_ResolveItem_Content|材料分解"
  },
  UI_Events_Panel_LotanCetarchon_StageGroup_Text_C_Title = {
    ID = "UI_Events_Panel_LotanCetarchon_StageGroup_Text_C_Title",
    Content = "PanelText_UI_Events_Panel_LotanCetarchon_StageGroup_Text_C_Title_Content|贪戮角逐"
  },
  UI_Events_Panel_LotanCetarchon_StageGroup_Text_C_Introduction = {
    ID = "UI_Events_Panel_LotanCetarchon_StageGroup_Text_C_Introduction",
    Content = "PanelText_UI_Events_Panel_LotanCetarchon_StageGroup_Text_C_Introduction_Content|力量，权力，金钱，自由……利维坦的土地上，祂将赐你渴望的一切。\n只要，你能成为最后站着的那个人。"
  },
  UI_Events_Panel_LotanCetarchon_StageGroup_Text_C_Resonance = {
    ID = "UI_Events_Panel_LotanCetarchon_StageGroup_Text_C_Resonance",
    Content = "PanelText_UI_Events_Panel_LotanCetarchon_StageGroup_Text_C_Resonance_Content|共鸣"
  },
  UI_Events_Panel_LotanCetarchon_Text_C_Shop = {
    ID = "UI_Events_Panel_LotanCetarchon_Text_C_Shop",
    Content = "PanelText_UI_Events_Panel_LotanCetarchon_Text_C_Shop_Content|斗兽场祭祀台"
  },
  UI_Events_Panel_LotanCetarchon_Text_C_Reward = {
    ID = "UI_Events_Panel_LotanCetarchon_Text_C_Reward",
    Content = "PanelText_UI_Events_Panel_LotanCetarchon_Text_C_Reward_Content|成就奖励"
  },
  UI_Events_Panel_LotanCetarchon_Text_C_Topic = {
    ID = "UI_Events_Panel_LotanCetarchon_Text_C_Topic",
    Content = "PanelText_UI_Events_Panel_LotanCetarchon_Text_C_Topic_Content|利维坦的游戏"
  },
  UI_Events_Panel_LotanCetarchon_Text_C_Record = {
    ID = "UI_Events_Panel_LotanCetarchon_Text_C_Record",
    Content = "PanelText_UI_Events_Panel_LotanCetarchon_Text_C_Record_Content|意识潜游"
  },
  UI_Events_Panel_LotanCetarchon_Text_C_RecordTip = {
    ID = "UI_Events_Panel_LotanCetarchon_Text_C_RecordTip",
    Content = "PanelText_UI_Events_Panel_LotanCetarchon_Text_C_RecordTip_Content|限时免费解锁"
  },
  UI_Events_Panel_LotanCetarchon_Text_C_Challenge = {
    ID = "UI_Events_Panel_LotanCetarchon_Text_C_Challenge",
    Content = "PanelText_UI_Events_Panel_LotanCetarchon_Text_C_Challenge_Content|贪戮角逐"
  },
  UI_Events_Panel_LotanCetarchon_Text_C_ChallengeTip = {
    ID = "UI_Events_Panel_LotanCetarchon_Text_C_ChallengeTip",
    Content = "PanelText_UI_Events_Panel_LotanCetarchon_Text_C_ChallengeTip_Content|玩法限时开放"
  },
  UI_Events_Panel_Caraboo_Text_C_Shop = {
    ID = "UI_Events_Panel_Caraboo_Text_C_Shop",
    Content = "PanelText_UI_Events_Panel_Caraboo_Text_C_Shop_Content|仙女典仪"
  },
  UI_Events_Panel_Caraboo_Text_C_Reward = {
    ID = "UI_Events_Panel_Caraboo_Text_C_Reward",
    Content = "PanelText_UI_Events_Panel_Caraboo_Text_C_Reward_Content|成就奖励"
  },
  UI_Events_Panel_Caraboo_Text_C_Topic = {
    ID = "UI_Events_Panel_Caraboo_Text_C_Topic",
    Content = "PanelText_UI_Events_Panel_Caraboo_Text_C_Topic_Content|新月与深雪"
  },
  UI_Events_Panel_Caraboo_Text_C_Record = {
    ID = "UI_Events_Panel_Caraboo_Text_C_Record",
    Content = "PanelText_UI_Events_Panel_Caraboo_Text_C_Record_Content|特遣记录"
  },
  UI_Events_Panel_Caraboo_Text_C_RecordTip = {
    ID = "UI_Events_Panel_Caraboo_Text_C_RecordTip",
    Content = "PanelText_UI_Events_Panel_Caraboo_Text_C_RecordTip_Content|限时免费解锁"
  },
  UI_Events_Panel_Caraboo_Text_C_Challenge = {
    ID = "UI_Events_Panel_Caraboo_Text_C_Challenge",
    Content = "PanelText_UI_Events_Panel_Caraboo_Text_C_Challenge_Content|乌摩钵蒂的宝物"
  },
  UI_Events_Panel_Caraboo_Text_C_ChallengeTip = {
    ID = "UI_Events_Panel_Caraboo_Text_C_ChallengeTip",
    Content = "PanelText_UI_Events_Panel_Caraboo_Text_C_ChallengeTip_Content|玩法限时开放"
  },
  UI_Events_Panel_Caraboo_StageGroup_Text_C_Title = {
    ID = "UI_Events_Panel_Caraboo_StageGroup_Text_C_Title",
    Content = "PanelText_UI_Events_Panel_Caraboo_StageGroup_Text_C_Title_Content|乌摩钵蒂的宝物"
  },
  UI_Events_Panel_Caraboo_StageGroup_Text_C_Introduction = {
    ID = "UI_Events_Panel_Caraboo_StageGroup_Text_C_Introduction",
    Content = "PanelText_UI_Events_Panel_Caraboo_StageGroup_Text_C_Introduction_Content|♪~~♫~~♪~~♫~~♪~~♫~~\n在雪山下，所有的向导都记得，所有的孩子都将它传唱。那是巍峨雪山意志的化身，那是慈悲的神女乌摩钵蒂。\n她的神力散落人间，她的宝物无从寻觅，它们近在咫尺，它们渺无踪迹。放弃一些什么吧，坚持一些什么吧。\n对神女的真身心有不诚者，将与死去的雪山一同，永远葬身在雪山。"
  },
  UI_Events_Panel_Caraboo_StageGroup_Text_C_Resonance = {
    ID = "UI_Events_Panel_Caraboo_StageGroup_Text_C_Resonance",
    Content = "PanelText_UI_Events_Panel_Caraboo_StageGroup_Text_C_Resonance_Content|共鸣"
  },
  UI_Dungeons_BattleTeaching_View_Text_C_Award = {
    ID = "UI_Dungeons_BattleTeaching_View_Text_C_Award",
    Content = "PanelText_UI_Dungeons_BattleTeaching_View_Text_C_Award_Content|任务报酬"
  },
  UI_Dungeons_BattleTeaching_View_Text_BtnName = {
    ID = "UI_Dungeons_BattleTeaching_View_Text_BtnName",
    Content = "PanelText_UI_Dungeons_BattleTeaching_View_Text_BtnName_Content|开始训练"
  },
  UI_Common_Popup_Consume_Text_C_Title = {
    ID = "UI_Common_Popup_Consume_Text_C_Title",
    Content = "PanelText_UI_Common_Popup_Consume_Text_C_Title_Content|道具使用确认"
  },
  UI_Common_Popup_Consume_Text_C_Cancel = {
    ID = "UI_Common_Popup_Consume_Text_C_Cancel",
    Content = "PanelText_UI_Common_Popup_Consume_Text_C_Cancel_Content|取消"
  },
  UI_Common_Popup_Consume_Text_C_Confirm = {
    ID = "UI_Common_Popup_Consume_Text_C_Confirm",
    Content = "PanelText_UI_Common_Popup_Consume_Text_C_Confirm_Content|确定"
  },
  UI_Awaker_Popup_Topped_Tip2_Text_C_Tips = {
    ID = "UI_Awaker_Popup_Topped_Tip2_Text_C_Tips",
    Content = "PanelText_UI_Awaker_Popup_Topped_Tip2_Text_C_Tips_Content|查看"
  },
  UI_Awaker_Popup_Topped_Tip2_Text_C_Breakthrough = {
    ID = "UI_Awaker_Popup_Topped_Tip2_Text_C_Breakthrough",
    Content = "PanelText_UI_Awaker_Popup_Topped_Tip2_Text_C_Breakthrough_Content|同调需求"
  },
  UI_Awaker_Popup_Trinket_Conversion_Text_C_No_Entries = {
    ID = "UI_Awaker_Popup_Trinket_Conversion_Text_C_No_Entries",
    Content = "PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_No_Entries_Content|暂无属性"
  },
  UI_Awaker_Popup_Trinket_Conversion_Text_C_AutoRefinement = {
    ID = "UI_Awaker_Popup_Trinket_Conversion_Text_C_AutoRefinement",
    Content = "PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_AutoRefinement_Content|自动转录"
  },
  UI_Awaker_Popup_Trinket_Conversion_Text_C_Skip = {
    ID = "UI_Awaker_Popup_Trinket_Conversion_Text_C_Skip",
    Content = "PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_Skip_Content|跳过动画"
  },
  UI_Dungeons_Tip_AwakerFavor_Text_C_UseCard = {
    ID = "UI_Dungeons_Tip_AwakerFavor_Text_C_UseCard",
    Content = "PanelText_UI_Dungeons_Tip_AwakerFavor_Text_C_UseCard_Content|出牌"
  },
  UI_Dungeons_Tip_AwakerFavor_Text_C_EnergyCost = {
    ID = "UI_Dungeons_Tip_AwakerFavor_Text_C_EnergyCost",
    Content = "PanelText_UI_Dungeons_Tip_AwakerFavor_Text_C_EnergyCost_Content|算力"
  },
  UI_Dungeons_Tip_AwakerFavor_Text_C_UltiEnergy = {
    ID = "UI_Dungeons_Tip_AwakerFavor_Text_C_UltiEnergy",
    Content = "PanelText_UI_Dungeons_Tip_AwakerFavor_Text_C_UltiEnergy_Content|狂气"
  },
  UI_Dungeons_Tip_AwakerFavor_Text_C_KeeperSkill = {
    ID = "UI_Dungeons_Tip_AwakerFavor_Text_C_KeeperSkill",
    Content = "PanelText_UI_Dungeons_Tip_AwakerFavor_Text_C_KeeperSkill_Content|银钥能量"
  },
  UI_Dungeons_Tip_AwakerFavor_Text_C_Manual = {
    ID = "UI_Dungeons_Tip_AwakerFavor_Text_C_Manual",
    Content = "PanelText_UI_Dungeons_Tip_AwakerFavor_Text_C_Manual_Content|手动战斗"
  },
  UI_Dungeons_Tip_AwakerFavor_Text_C_Extra = {
    ID = "UI_Dungeons_Tip_AwakerFavor_Text_C_Extra",
    Content = "PanelText_UI_Dungeons_Tip_AwakerFavor_Text_C_Extra_Content|额外加成"
  },
  UI_Awaker_Popup_Trinket_Bind_Text_C_Bind = {
    ID = "UI_Awaker_Popup_Trinket_Bind_Text_C_Bind",
    Content = "PanelText_UI_Awaker_Popup_Trinket_Bind_Text_C_Bind_Content|结合密契"
  },
  UI_Awaker_Popup_Trinket_Bind_Text_C_Foundation = {
    ID = "UI_Awaker_Popup_Trinket_Bind_Text_C_Foundation",
    Content = "PanelText_UI_Awaker_Popup_Trinket_Bind_Text_C_Foundation_Content|属性"
  },
  UI_Awaker_Popup_Trinket_Bind_Text_C_Empty_Suit = {
    ID = "UI_Awaker_Popup_Trinket_Bind_Text_C_Empty_Suit",
    Content = "PanelText_UI_Awaker_Popup_Trinket_Bind_Text_C_Empty_Suit_Content|暂无生效的套装效果"
  },
  UI_Awaker_Popup_Trinket_Bind_Text_C_Suit = {
    ID = "UI_Awaker_Popup_Trinket_Bind_Text_C_Suit",
    Content = "PanelText_UI_Awaker_Popup_Trinket_Bind_Text_C_Suit_Content|套装效果"
  },
  UI_Awaker_Popup_Trinket_Bind_Text_C_BindTip = {
    ID = "UI_Awaker_Popup_Trinket_Bind_Text_C_BindTip",
    Content = "PanelText_UI_Awaker_Popup_Trinket_Bind_Text_C_BindTip_Content|结合后密契主属性额外提升 50%！"
  },
  UI_Awaker_Popup_BindTrinket_Text_C_Title = {
    ID = "UI_Awaker_Popup_BindTrinket_Text_C_Title",
    Content = "PanelText_UI_Awaker_Popup_BindTrinket_Text_C_Title_Content|结合确认"
  },
  UI_Awaker_Panel_Trinket_BindDetail_Text_C_Title = {
    ID = "UI_Awaker_Panel_Trinket_BindDetail_Text_C_Title",
    Content = "PanelText_UI_Awaker_Panel_Trinket_BindDetail_Text_C_Title_Content|密契结合"
  },
  UI_Awaker_Panel_Trinket_BindDetail_Text_C_Null = {
    ID = "UI_Awaker_Panel_Trinket_BindDetail_Text_C_Null",
    Content = "PanelText_UI_Awaker_Panel_Trinket_BindDetail_Text_C_Null_Content|当前部位无可用密契"
  },
  UI_Awaker_Panel_Trinket_BindDetail_Text_C_Strengthen = {
    ID = "UI_Awaker_Panel_Trinket_BindDetail_Text_C_Strengthen",
    Content = "PanelText_UI_Awaker_Panel_Trinket_BindDetail_Text_C_Strengthen_Content|强化"
  },
  UI_Awaker_Panel_Trinket_BindDetail_Text_C_UnBindAll = {
    ID = "UI_Awaker_Panel_Trinket_BindDetail_Text_C_UnBindAll",
    Content = "PanelText_UI_Awaker_Panel_Trinket_BindDetail_Text_C_UnBindAll_Content|一键析离"
  },
  UI_Common_Popup_Tip_5_Text_C_Info = {
    ID = "UI_Common_Popup_Tip_5_Text_C_Info",
    Content = "PanelText_UI_Common_Popup_Tip_5_Text_C_Info_Content|点击空白处关闭"
  },
  UI_Awaker_Popup_UnBindTrinket_Text_C_Title = {
    ID = "UI_Awaker_Popup_UnBindTrinket_Text_C_Title",
    Content = "PanelText_UI_Awaker_Popup_UnBindTrinket_Text_C_Title_Content|析离密契"
  },
  UI_Awaker_Popup_UnBindTrinket_Text_C_NeedTrinket = {
    ID = "UI_Awaker_Popup_UnBindTrinket_Text_C_NeedTrinket",
    Content = "PanelText_UI_Awaker_Popup_UnBindTrinket_Text_C_NeedTrinket_Content|需要密契"
  },
  UI_Awaker_Popup_UnBindTrinket_Text_C_AutoSelect = {
    ID = "UI_Awaker_Popup_UnBindTrinket_Text_C_AutoSelect",
    Content = "PanelText_UI_Awaker_Popup_UnBindTrinket_Text_C_AutoSelect_Content|自动选择"
  },
  UI_Awaker_Popup_UnBindTrinket_Text_C_Cancel = {
    ID = "UI_Awaker_Popup_UnBindTrinket_Text_C_Cancel",
    Content = "PanelText_UI_Awaker_Popup_UnBindTrinket_Text_C_Cancel_Content|取消"
  },
  UI_Awaker_Popup_UnBindTrinket_Text_C_Confirm = {
    ID = "UI_Awaker_Popup_UnBindTrinket_Text_C_Confirm",
    Content = "PanelText_UI_Awaker_Popup_UnBindTrinket_Text_C_Confirm_Content|析离密契"
  },
  UI_Summon_Popup_MixPoolLimit_Text_C_InfoTitle = {
    ID = "UI_Summon_Popup_MixPoolLimit_Text_C_InfoTitle",
    Content = "PanelText_UI_Summon_Popup_MixPoolLimit_Text_C_InfoTitle_Content|玩法说明"
  },
  UI_Summon_Popup_MixPoolLimit_Text_C_ChooseTitle = {
    ID = "UI_Summon_Popup_MixPoolLimit_Text_C_ChooseTitle",
    Content = "PanelText_UI_Summon_Popup_MixPoolLimit_Text_C_ChooseTitle_Content|选择唤醒体"
  },
  UI_Summon_Popup_MixPoolLimit_Text_C_Change = {
    ID = "UI_Summon_Popup_MixPoolLimit_Text_C_Change",
    Content = "PanelText_UI_Summon_Popup_MixPoolLimit_Text_C_Change_Content|重选"
  },
  UI_Summon_Popup_MixPoolLimit_Text_C_Choose = {
    ID = "UI_Summon_Popup_MixPoolLimit_Text_C_Choose",
    Content = "PanelText_UI_Summon_Popup_MixPoolLimit_Text_C_Choose_Content|开始选择"
  },
  UI_Summon_Popup_MixPoolLimit_Text_Title = {
    ID = "UI_Summon_Popup_MixPoolLimit_Text_Title",
    Content = "PanelText_UI_Summon_Popup_MixPoolLimit_Text_Title_Content|选择唤醒体"
  },
  UI_Summon_Popup_OptionalMixPoolLimit_Text_C_Title = {
    ID = "UI_Summon_Popup_OptionalMixPoolLimit_Text_C_Title",
    Content = "PanelText_UI_Summon_Popup_OptionalMixPoolLimit_Text_C_Title_Content|选择唤醒体"
  },
  UI_Summon_Popup_OptionalMixPoolLimit_Text_C_Tip = {
    ID = "UI_Summon_Popup_OptionalMixPoolLimit_Text_C_Tip",
    Content = "PanelText_UI_Summon_Popup_OptionalMixPoolLimit_Text_C_Tip_Content|长按唤醒体查看详情"
  },
  UI_Summon_Popup_OptionalMixPoolLimit_Text_C_Confirm = {
    ID = "UI_Summon_Popup_OptionalMixPoolLimit_Text_C_Confirm",
    Content = "PanelText_UI_Summon_Popup_OptionalMixPoolLimit_Text_C_Confirm_Content|完成选择"
  },
  UI_Awaker_Popup_BindTrinket_Text_C_Tip = {
    ID = "UI_Awaker_Popup_BindTrinket_Text_C_Tip",
    Content = "PanelText_UI_Awaker_Popup_BindTrinket_Text_C_Tip_Content|确认结合以下密契？"
  },
  UI_Awaker_Popup_BindTrinket_Text_C_BindTip = {
    ID = "UI_Awaker_Popup_BindTrinket_Text_C_BindTip",
    Content = "PanelText_UI_Awaker_Popup_BindTrinket_Text_C_BindTip_Content|已被其他唤醒体装备或在编队/方案/助战中存在的密契被自动卸下"
  },
  UI_Awaker_Popup_Trinket_Bind_Text_C_Rule = {
    ID = "UI_Awaker_Popup_Trinket_Bind_Text_C_Rule",
    Content = "PanelText_UI_Awaker_Popup_Trinket_Bind_Text_C_Rule_Content|规则说明"
  }
})
return PanelText
