LuaS �

xV           (w@n@../PublishResources/lua/product/components/ui/activity/n29/activity/main/ui_activity_n29_main_controller.lua         =    @ A@  ��@ $@�@@  ��@@ l   
@��@@ l@  
@ �@@ l�  
@��@@ l�  
@ �@@ l  
@��@@ l@ 
@ �@@ l� 
@��@@ l� 
@ �@@ l  
@��@@ l@ 
@ �@@ l� 
@��@@ l� 
@ �@@ l  
@��@@ l@ 
@ �@@ l� 
@���D l� 
@���D l  
@ ��D l@ 
@��& �    _classUIActivityN29MainControllerUIActivityMainBaseOnInit	OnUpdateRefreshActivityRemainTime
OnRefreshGetCampaignTypeGetComponentIdsGetLoginComponentIdGetCustomTimeStrGetButtonStatusConfigNormalLevelOnClickHardLevelOnClickChessGameOnClickDetectiveGameOnClickShopOnClickCheckGuideUIActivityN29MainControllerSetPanelStatusPlayAnimEnterCoroOnPlayPlot                  L@@ ��  �  d� 
@ �L@@ ��  A d� 
@ �L@@ ��  d� 
@ �L@B d@ L�B ��B    d@ & �    _shopCountLabelGetUIComponentUILocalizationText
ShopCount_timeLabelTime_anim
AnimationAnimRefreshActivityRemainTime
StartTaskPlayAnimEnterCoro                                                        	   	   
   
   
   
         self                      � @ �@ & �    RefreshActivityRemainTime                       self       deltaTimeMS               *    G   G @ L@� d� b   ��G�@ L�� � A �@�� �  d@  & � A� � @ � BAB �B����B C ��AC �C@��� � B A� $� FA GA��� � d��@ ���@ E$� GAE L��d� R���F �AF�A�� !�F  ��� �AC ǁ�  A� � �B � � A BAA� ��$��@  �@ �@�� $A�& �    _activityConstIsActivityEnd_timeLabelSetTextStringTableGetstr_n29_activity_endGetComponentStatusECampaignN29ComponentIDECAMPAIGN_N29_LINE_MISSIONActivityComponentStatusOpenUIActivityCustomHelperGetTimeStringstr_n29_daystr_n29_hourstr_n29_minusstr_n29_less_one_minusstr_n29_activity_remain_timeGetActiveEndTime_timeModuleGetServerTime�      mathfloor        (str_n29_activity_get_reward_remain_time         G                                                                                                                                                          !   !   "   %   %   %   %   %   %   %   %   &   &   &   &   &   &   )   )   )   )   *   	   self    G   	timeTips   G   status   G   time   G   timeStr   %   endTime)   B   nowTime-   B   seconds1   B   timeStr<   B      _ENV ,   4       D � � @ �@�F�@ G������  @ �� � �� GAA L����A ��B @ �� �� ��dA  & �    _activityConstGetComponentECampaignN29ComponentIDECAMPAIGN_N29_LOTTERYGetLotteryCostItemIconText_shopCountLabelSetTextUIActivityCustomHelperGetItemCountStr       #2B2218#F2E6DA            .   1   1   1   1   1   1   1   2   2   3   3   3   3   3   3   3   3   3   3   4      self       com      comInfo      icon
      count
         _ENV 5   7       F @ G@� f  & �    ECampaignTypeCAMPAIGN_TYPE_N29            6   6   6   7      self          _ENV 9   E    0   K   � � � @�@@ ǀ�J� � � � @�@@ ���J� � � � @�@@ � �J� � � � @�@@ �@�J� � � � @�@@ ǀ�J� � � � @�@@ ���J� � � � @�@@ � �J� � � � @�@@ �@�J� � � � @�@@ ǀ�J� f  & �           ECampaignN29ComponentIDECAMPAIGN_N29_CUMULATIVE_LOGINECAMPAIGN_N29_FIRST_MEETECAMPAIGN_N29_POWER2ITEMECAMPAIGN_N29_LINE_MISSION ECAMPAIGN_N29_DIFFICULT_MISSION&ECAMPAIGN_N29_BLACK_DIFFICULT_MISSIONECAMPAIGN_N29_LOTTERYECAMPAIGN_N29_CHESSECAMPAIGN_N29_DETECTIVE         0   :   ;   ;   ;   ;   ;   <   <   <   <   <   =   =   =   =   =   >   >   >   >   >   ?   ?   ?   ?   ?   @   @   @   @   @   A   A   A   A   A   B   B   B   B   B   C   C   C   C   C   D   E      self    0   componentIds   0      _ENV G   I       F @ G@� f  & �    ECampaignN29ComponentIDECAMPAIGN_N29_CUMULATIVE_LOGIN            H   H   H   I      self          _ENV K   M       A   �@  ��  �  f �& �    str_n29_daystr_n29_hourstr_n29_minusstr_n29_less_one_minus           L   L   L   L   L   M      self            O   �    Q   K   �   �@@���@ � ��� �� � �@ �A�@� �����   �����@B���B���B�� � �@�J���   ʀC��@ �C� �� F�@ G�+A� � ��,A  � ���@D�ʀD���D�� ACJ�   
E�F�@ GA�
A�
�łl�  
A��
�E�
F�
AF�\� MA�J �K  J�F���@ ��FJ��J�ł��  J���JG�JAG�J�G��� �ACJ@�  ��G���@ �������ł� �����AH���B���B��� �A�J��f  & � "   NameNormalComponentIdECampaignN29ComponentIDECAMPAIGN_N29_LINE_MISSIONCheckRedComponentIdsECAMPAIGN_N29_FIRST_MEET	CallbackRemainTimeStr*str_n29_activity_normal_level_remain_timeUnlockTimeStrUnlockMissionStr       Hard ECAMPAIGN_N29_DIFFICULT_MISSION&ECAMPAIGN_N29_BLACK_DIFFICULT_MISSION(str_n29_activity_hard_level_remain_time+str_n29_activity_hard_level_lock_time_tips.str_n29_activity_hard_level_lock_mission_tips
ChessGameECAMPAIGN_N29_CHESS (str_n29_activity_chess_game_remain_time+str_n29_activity_chess_game_lock_time_tips.str_n29_activity_chess_game_lock_mission_tipsDetectiveGameECAMPAIGN_N29_DETECTIVE,str_n29_activity_detective_game_remain_time/str_n29_activity_detective_game_lock_time_tips2str_n29_activity_detective_game_lock_mission_tipsShopECAMPAIGN_N29_LOTTERY"str_n29_activity_shop_remain_time         W   Y            @ �@  $@�& �    ShowDialogUIActivityN29LineLevel           X   X   X   X   Y          self d   f            @ �@  $@�& �    ShowDialogUIActivityN29HardLevelMain           e   e   e   e   f          self q   s            @ �@  $@�& �    SwitchStateUIN29ChessController           r   r   r   r   s          self ~   �            @ �@� ��@$@�& �    SwitchStateUIStateTypeUIN29DetectiveLogin                            �          self_ENV �   �            @ �@� ��@��� $@ & �    SwitchStateUIStateType
UIN29Shop	cache_rt             �   �   �   �   �   �   �          self_ENVQ   P   S   T   U   U   U   V   V   V   V   V   Y   Y   Z   [   \   ]   ]   ]   `   a   b   b   b   c   c   c   c   c   f   f   g   h   i   j   j   j   m   n   o   o   o   p   s   s   t   u   v   w   w   w   z   {   |   |   |   }   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    Q   configs   Q   normalLevel   Q   
hardLevel   Q   chess&   Q   
detective4   Q   shopB   Q      _ENV �   �       L @ �@  d@�& �    ClickButtonNormal           �   �   �   �      self            �   �       L @ �@  d@�& �    ClickButtonHard           �   �   �   �      self            �   �       L @ �@  d@�& �    ClickButton
ChessGame           �   �   �   �      self            �   �       L @ �@  d@�& �    ClickButtonDetectiveGame           �   �   �   �      self            �   �       L @ �@  d@�& �    ClickButtonShop           �   �   �   �      self            �   �    
   F @ G@� d�� L�� ��@ � �A AAd@ & �    GameGlobalEventDispatcher	DispatchGameEventTypeGuideOpenUIUIActivityN29MainController         
   �   �   �   �   �   �   �   �   �   �      self    
      _ENV �   �       � @ �@�[ �@��    �ǀ@ ���A �@�� �ǀ@ ���AA �@�& �    	_showBtn
SetActive_animPlay*uieff_UIActivityN29MainController_chuxian*uieff_UIActivityN29MainController_yincang           �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       TT       isShow            �   �       � @ ,  �@�& �    	PlayPlot         �   �     2       @ �@  $@�   �@ ��  �  $� E   L�� �@  d� �� ��A @ �@�� � A��� $��E  L����  d� �A��  � �́CA� � �A ��C ��AB �A�Ɓ�  A� �A��  ���A �  �A�AB  �A�& �    Lock.UIActivityN29MainController_PlayAnimEnterCoroGetUIComponentRawImageLoaderLoader	RawImagen29_kng_bg03
LoadImage	materialGetTexture	_MainTexMeshRendererQuadsharedMaterialSetTexture_animPlayUIActivityN29MainController_inYIELD�      CheckGuideUnLock          2   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      loader	   2   
loaderImg   2   nameImg   2   mat   2   mainTex   2   quad   2   quadmat   2      self_ENVTT   �   �   �   �      self       TT          _ENV �   �       & �                �      self           =                                          *      ,   4   ,   5   7   5   9   E   9   G   I   G   K   M   K   O   �   O   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �          _ENV