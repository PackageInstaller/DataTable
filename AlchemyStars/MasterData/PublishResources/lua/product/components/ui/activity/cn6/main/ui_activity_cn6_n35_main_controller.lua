LuaS �

xV           (w@i@../PublishResources/lua/product/components/ui/activity/cn6/main/ui_activity_cn6_n35_main_controller.lua         L    @ A@  $@ �@ A�  � A $@��@  ���@ l   
@���@ l@  
@ ��@ l�  
@���@ l�  
@ ��@ l  
@���@ l@ 
@ ��@ l� 
@���@ l� 
@ ��@ l  
@���@ l@ 
@ ��@ l� 
@���@ l� 
@ ��@ l  
@���@ l@ 
@ ��@ l� 
@���@ l� 
@ ��@ l  
@���@ l@ 
@ ��@ l� 
@�� F l� 
@�� F l  
@ � F l@ 
@��& �    requireui_activity_main_base_classUIActivityCN6N35MainControllerUIActivityMainBaseInitTopButtonOnInit_ItemCountChanged	OnUpdateRefreshActivityRemainTime
OnRefreshGetCampaignTypeGetComponentIdsGetLoginComponentIdGetCustomTimeStrGetButtonStatusConfigNormalLevelOnClickHardLevelOnClickGameOnClickShopOnClickPlotOnClickSetPanelStatusPlayAnimEnterCoroCheckGuideUIActivityCN6N35MainControllerInfoOnClickReplaceMaterialClose               	   L @ �@  �  d� � � A ���
�����@ ��A,  D� �  ,B  �@�& �    GetUIComponentUISelectObjectPathTopBtn	_backBtnSpawnObjectUICommonTopButtonSetData                     @ @@ $�� �@ ��� � � $@ & �    GameGlobalTaskManager
StartTask
CloseCoro                                            _ENVself         	    @ @@ $�� �@ ��� � �   $@�& �    GameGlobalTaskManager
StartTaskSetButtonShowStatusCoro          	                                     _ENVself                                                      self       btns         _ENV    *    :   F@@ G�� d�� 
@ �F@@ G�� � A �@Ad@ L�A �  A d� 
@ �L�A �  � d� 
@ �L�A �@ � d� 
@ �L�A �  A d� 
@��L�A �@ A d� 
@ �L�A �@  d� 
@��L�A �� � d� 
@��L F d@ L@F d@ L�F ��F    d@ L G �@G ǀ��G d@ & �     	_playingAudioHelperControllerGetCurrentBgmPlayBGMCriAudioIDConst
BGMCN6N35_shopCountLabelGetUIComponentUILocalizationText
ShopCount_timeLabelTime_anim
AnimationAnim_rawImageLoaderRawImageLoader	RawImage
_rawImage_photoImagephoto_screenShotH3DUIBlurHelperscreenShotReplaceMaterialRefreshActivityRemainTime
StartTaskPlayAnimEnterCoroAttachEventGameEventTypeItemCountChanged_ItemCountChanged         :                                                                                !   !   !   !   !   "   "   "   "   "   #   #   #   #   #   $   $   $   $   $   %   %   &   &   '   '   '   '   )   )   )   )   )   *      self    :      _ENV ,   .       L @ d@ & �    
OnRefresh           -   -   .      self            1   <       � @ �@ & �    RefreshActivityRemainTime           2   2   <      self       deltaTimeMS            >   ^    2   G @ L@� d� b   ��G�@ L�� � A �@�� �  d@  & � D   �� � B �@�� Ҁ��B CG@ LA�d� N��$� @  ��  � !�C  �� FD GA�� �� � A �B d� �A �AA�  ����ǁ@ ���@ �A�& �    _activityConstIsActivityEnd_timeLabelSetTextStringTableGetstr_cn6&n35_activity_end_timeModuleGetServerTime�      mathfloorGetActiveEndTime!str_cn6&n35_activity_remain_time        UIActivityCustomHelperGetTimeStringstr_cn6&n35_daystr_cn6&n35_hourstr_cn6&n35_minusstr_cn6&n35_less_one_minus         2   ?   ?   ?   ?   ?   A   A   A   A   A   A   A   B   P   Q   R   R   R   R   S   S   S   S   S   S   S   S   T   V   W   W   X   [   [   [   [   [   [   [   [   \   \   \   \   \   ]   ]   ]   ]   ^      self    2   endTime   2   tipsStr   2   nowTime   2   seconds   2   timeStr(   2   	timeTips-   2      _ENV `          D � � @ �@�F�@ G������  @ �� � ��   ��  �A G�A L���B �A�� @ �� � ��dA  & �    _activityConstGetComponentECampaignCN6ComponentIDECAMPAIGN_N6_SHOPGetCostItemIconText��     _shopCountLabelSetTextUIActivityCustomHelperGetItemCountStr       #7E91B6#FFFFFF            b   e   e   e   e   e   e   e   g   g   m   m   n   p   p   p   p   p   p   p   p   p   p         self       com      comInfo      icon
      count
         _ENV �   �       F @ G@� f  & �    ECampaignTypeCAMPAIGN_TYPE_INLAND_N6            �   �   �   �      self          _ENV �   �    5   K   � � � @�@@ ǀ�J� � � � @�@@ ���J� � � � @�@@ � �J� � � � @�@@ �@�J� � � � @�@@ ǀ�J� � � � @�@@ ���J� � � � @�@@ � �J� � � � @�@@ �@�J� � � � @�@@ ǀ�J� � � � @�@@ ���J� f  & �           ECampaignCN6ComponentIDECAMPAIGN_N6_CUMULATIVE_LOGINECAMPAIGN_N6_POWER2ITEMECAMPAIGN_N6_LINE_MISSIONECAMPAIGN_N6_DIFFICULT_MISSIONECAMPAIGN_N6_SHOPECAMPAIGN_N6_SHAREDECAMPAIGN_N6_SMELTITEMECAMPAIGN_N6_QUESTECAMPAIGN_N6_PERSON_PROCESSECAMPAIGN_N6_HEIXIA         5   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    5   componentIds   5      _ENV �   �       F @ G@� f  & �    ECampaignCN6ComponentIDECAMPAIGN_N6_CUMULATIVE_LOGIN            �   �   �   �      self          _ENV �   �       A   �@  ��  �  f �& �    str_cn6&n35_daystr_cn6&n35_hourstr_cn6&n35_minusstr_cn6&n35_less_one_minus           �   �   �   �   �   �      self            �   �    	I   K   �   �@@���@ � ��� ������   �����@B���B��@C�� � ̀�J���   ��C��@ D� � F�@ G���@ �AD+A � ��,A  � ��ʀD���D�� E�� �CJ�   
AE�F�@ G��
A�
���l�  
A��
�E�
F�
AF�\� M��J �K  J�F���@ ��FJ��� ��@ ����@ G�A J�����  J���JAG�J�G�J�G�� J���� ��CJ@f  & � !   NameNormalLevelComponentIdECampaignCN6ComponentIDECAMPAIGN_N6_LINE_MISSIONCheckRedComponentIds 	CallbackRemainTimeStr.str_cn6&n35_activity_normal_level_remain_timeUnlockTimeStr1str_cn6&n35_activity_normal_level_lock_time_tipsUnlockMissionStr4str_cn6&n35_activity_normal_level_lock_mission_tips       
HardLevelECAMPAIGN_N6_DIFFICULT_MISSIONECAMPAIGN_N6_HEIXIA,str_cn6&n35_activity_hard_level_remain_time/str_cn6&n35_activity_hard_level_lock_time_tips2str_cn6&n35_activity_hard_level_lock_mission_tipsShopECAMPAIGN_N6_SHOP&str_cn6&n35_activity_shop_remain_time)str_cn6&n35_activity_shop_lock_time_tips,str_cn6&n35_activity_shop_lock_mission_tipsGameECAMPAIGN_N6_SMELTITEMECAMPAIGN_N6_PERSON_PROCESS"str_n33_activity_game_remain_time%str_n33_activity_game_lock_time_tips(str_n33_activity_game_lock_mission_tipsExtraCustomCheckRed         �   �            @ �@  ��  � $@�& �    ShowDialogUICN6N35Line                  �   �   �   �   �   �   �          self �   �            @ �@  ��  $@ & �    ShowDialogUIActivityCN6N35HardLevelMain                  �   �   �   �   �   �          self �   �            @ �@  ��  � $@�& �    ShowDialogUIActivityCN6N35Shop                  �   �   �   �   �   �   �          self �   �            @ �@  $@�& �    ShowDialogUI_CN6_N35_GameController           �   �   �   �   �          self �   �         @ @@ % � &   & �    UI_CN6_N35_GameControllerCheckQuestRed            �   �   �   �   �          _ENVI   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    I   configs   I   normalLevel   I   
hardLevel   I   shop$   I   game2   I      _ENV �   �       L @ �@  d@�& �    ClickButtonNormalLevel           �   �   �   �      self            �   �       L @ �@  d@�& �    ClickButton
HardLevel           �   �   �   �      self            �   �       L @ �@  d@�& �    ClickButtonGame           �   �   �   �      self            �   �       L @ �@  d@�& �    ClickButtonShop           �   �   �   �      self            �   �       & �                �      self            �   �       � @ �@�[ �@�ǀ@ �   ���    �ǀ@ ���A �@� �ǀ@ ���AA �@���� @ �@�[ �@�ǀA �@�@ �@�& �    	_showBtn
SetActive_animPlay*uieff_UIActivityCN6N35MainController_show*uieff_UIActivityCN6N35MainController_hide
_btnPanel           �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       TT       isShow            �          � @ �@ & �    CheckGuide           �   �         self       TT                 
   F @ G@� d�� L�� ��@ � �A AAd@ & �    GameGlobalEventDispatcher	DispatchGameEventTypeGuideOpenUIUIActivityCN6N35MainController         
                          self    
      _ENV      
   G @ L@� d� ��� �� �@��� A �@��A �AA $ �@  & � �@B�B �B� LC �A �CF�C G�dA�& �    _activityConstGetCampaign
GetSample ToastManager
ShowToastStringTableGetstr_activity_finishedidCfg cfg_activity_intro_in_discoveryShowDialogUIIntroLoaderIntroLoaderKey	MaskTypeMT_BlurMask            	  	  	                                                   self       	campaign      sample      campId      	introCfg         _ENV      %   G@@ G�� 
@ �F A L@� d� L�� ��  � �AB �Bd� 
@��G�@ b@    �& � G�@ G � 
@��G@C L�� �� �B C  d@�G@@ G�� L�� �  @ AD� $�d@  & �    _lastMaterial
_rawImage	material_reqEffectMatResourceManagerGetInstanceSyncLoadAssetuieff_N35N6_rongjie01.mat	LoadTypeMat_effectMatObj_rawImageLoaderSetMatSetTexture	_MainTexGetTexture         %                                                                                self    %      _ENV    4   P   � @ �@@��� ��@�@ A�@�� @ �@A��� ��A�� ��A � �� ���@B � �@���B � @ �@�䀀 �@�L�C d �  �� ���B ��C�� � D �@�̀�FD G��G��D ��D�AE�� 䀀�E @� $A D FAF@ ��$A��F 
���G AG�� $A��E @� �� $A�H $A AH �HG�H $A I �� $A����@H ��H��H �@ �@I �A B�@�& � &   GameGlobalEventDispatcher	DispatchGameEventTypeOnCN6N35MainQuitUIStateManagerCurUIStateTypeUIStateTypeUIMainLock%UIActivityCN6N35MainController_Close_screenShotOwnerCameraGetControllerCameraGetNameRefreshBlurTextureUnityEngineRenderTextureNewScreenwidthheight       YIELD	GraphicsBlit_photoImagetexture_animPlay)uieff_UIActivityCN6N35MainController_out,      CloseDialogAudioHelperControllerPlayBGM	_playingUnLockSwitchState         P   "  "  "  "  "  "  "  #  #  #  #  #  #  #  #  #  $  $  $  %  %  %  %  %  %  %  %  %  &  &  &  '  '  '  '  '  '  '  '  '  '  '  (  (  (  )  )  )  )  )  )  *  *  +  +  +  +  ,  ,  ,  ,  -  -  .  .  .  .  /  /  /  /  1  1  1  1  2  2  2  2  4     self    P   TT    P   rt   F   	cache_rt*   F      _ENVL                                          *      ,   .   ,   1   <   1   >   ^   >   `      `   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      �                        4     4         _ENV