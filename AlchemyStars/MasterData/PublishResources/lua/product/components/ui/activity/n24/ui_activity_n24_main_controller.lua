LuaS �

xV           (w@`@../PublishResources/lua/product/components/ui/activity/n24/ui_activity_n24_main_controller.lua         O    @ A@  ��@ $@�@@  ��@@ l   
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
@��@@ l� 
@ �@@ l  
@��@@ l@ 
@ �@@ l� 
@��@@ l� 
@ �@@ l  
@��@@ l@ 
@ �@@ l� 
@��@@ l� 
@ �& �    _classUIActivityN24MainControllerUIControllerLoadDataOnEnterOnShowOnHide	OnUpdate
CloseCoroSetButtonShowStatusPlayEnterAnimPlayEnterAnimCoroInitUI
RefreshUIRefreshButtonStatusRefreshShopBtnStatusRefreshActivityRemainTimeRefreshRedAndNewForceUpdateReLoadDataShowBtnOnClickEventOnClickLoginOnClickPetOnClickFishOnClickShopOnClickInfoBtnOnClickCheckGuide                   A@ �@F�@ $� 
 �AA �A$� 
 �A �A�� � $A �   ��B$� "A  ��A@ �@FAB $� L�B��BA C$� D� dA & �    _timeModuleGameGlobal
GetModuleSvrTimeModule_activityConstUIActivityN24ConstNew	LoadDataGetSuccCampaignModuleCheckErrorCode	m_resultGetCampaignId                            	   	   	   	   
   
   
   
   
                                                            self        TT        res        	uiParams        campModule         _ENV    G    
n   L@@ ��  �  d� 
@ �L@A �� d��
@ �L@A �  d��
@��L@A �� d��
@��L@A �  d��
@��L@A �� d��
@��L@A �  d��
@��L@A �� d��
@��L@A �  d��
@��L@@ �� � d� 
@��L@@ �@ � d� 
@ �L@@ ��  d� 
@��L@@ �� � d� 
@��L@A �  d��
@��L@A �� d��
@��G@H L�� �   d@�L@A �@	 d��
@ �L@@ ��	 A	 d� ��� 
 ����@Jl  ��   lB  �@�̀J F�J G��AK �@ ̀J F�J G���AK �@ ��K �@ � L �@��@� ̀L l�  �@��@@ A �A � 
���& � 6   _shotGetUIComponentH3DUIBlurHelperscreenShot
_eventRedGetGameObject	EventRed
_loginRed	LoginRed_petRedPetRed	_fishRedFishRed	_shopRedShopRed	_fishNewFishNew
_fishLock	FishLock_fishLockTipsPanelFishLockTipsPanel_fishLockTipsLabelUILocalizationTextFishLockTips_shopIconLoaderRawImageLoader	ShopIcon_shopCountLabel
ShopCount_timeLabelTime
_btnPanel	BtnPanel	_showBtnShowBtn
SetActive_topBtnTopBtnUISelectObjectPathSpawnObjectUICommonTopButtonSetDataAttachEventGameEventTypeOnActivityTotalAwardGotForceUpdateCampaignComponentStepChangeInitUIUIActivityN24ConstClearEnterNewStatus
StartTask_anim
AnimationAnim         +   -         @ @@ $�� �@ ��� � � $@ & �    GameGlobalTaskManager
StartTask
CloseCoro             ,   ,   ,   ,   ,   ,   ,   -          _ENVself 1   3            @ �   $@�& �    SetButtonShowStatus           2   2   2   2   3          self >   D       A   �   �@@�� �@���� �    �@��   �@A � �@��   ��A�@ & �    UIActivityN25CheckGuideLock
localNameYIELD�      UnLockCheckGuide             ?   @   @   @   @   A   A   A   A   B   B   B   B   C   C   C   D      TT       	lockName         self_ENVn                                                                                                                                                     !   !   !   !   !   "   "   "   "   "   #   #   #   #   $   $   $   $   %   %   %   %   &   &   &   &   '   '   '   '   )   )   )   *   -   .   0   3   *   6   6   6   6   6   7   7   7   7   7   9   9   :   :   :   =   D   =   F   F   F   F   F   G      self    n   btnsM   n   backBtnP   n      _ENV I   P       G @ b   � �G @ L@� d@ 
�@�L�@ � A �@��A d@ L�@ � A ����A d@ & �    _shotCleanRenderTexture DetachEventGameEventTypeOnActivityTotalAwardGotForceUpdateCampaignComponentStepChange            J   J   J   K   K   K   L   N   N   N   N   N   O   O   O   O   O   P      self          _ENV R   T       � @ �@ & �    
RefreshUI           S   S   T      self       deltaTimeMS            V   Z       � @ A  �@���@ �@ A�@��@A A  �@�& �    Lock(UIActivityN21CCMainController_CloseCoroSwitchStateUIStateTypeUIMainUnLock            W   W   W   X   X   X   X   Y   Y   Y   Z      self       TT          _ENV \   d       b    �� @ �@@�  �@�� �� @ �@@�  �@�� A �@A� �@�& �    _animPlay*uieffanim_UIActivityN24MainController_in2-uieffanim_UIActivityN24MainController_middle	_showBtn
SetActive           ]   ]   ^   ^   ^   ^   ^   `   `   `   `   b   b   b   b   d      self       isShow            f   h       L @ �@@    d@ & �    
StartTaskPlayEnterAnimCoro           g   g   g   g   h      self            j   n       � @ A  �@���@ A  �@�& �    Lock.UIActivityN24MainController_PlayEnterAnimCoroUnLock           k   k   k   m   m   m   n      self       TT            p   w       G @ L@� ǀ@ ����  d@  L A d@ L@A d@ L�A d@ L�A d@ L B d@ & � 	   	_fishNew
SetActive_activityConstIsShowHomelandTaskNewRefreshShopBtnStatus
RefreshUIRefreshRedAndNewPlayEnterAnimRefreshButtonStatus           q   q   q   q   q   q   r   r   s   s   t   t   u   u   v   v   w      self            {   ~       L @ d@ L@@ d@ & �    RefreshActivityRemainTimeRefreshButtonStatus           |   |   }   }   ~      self            �   �    -   G @ L@� d� b    �G�@ L�� �   d@�G A L�� �   d@�@�G�@ L�� � � d@�G A L�� � � d@�G @ L@� d� b   ��G�A L�� � B �@�� �  d@   �G�A L�� ��B � �@ AC$ �   d@  & �    _activityConstIsHomelandTaskEnable
_fishLock
SetActive_fishLockTipsPanelIsHomelandTaskEnd_fishLockTipsLabelSetTextStringTableGetstr_n24_activity_endUIActivityN24ConstGetTimeStringGetHomelandRemaindOpenSeconds         -   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    -      _ENV �   �       G @ L@� d� ǀ@�@ A@�$� FAA G��G����A �BB��A���B ��BC BC@ �� �� $ �A  & �    _activityConstGetShopComponentm_cost_item_idClientCampaignDrawShop	GetMoneyCfg	cfg_item_shopIconLoader
LoadImageIcon_shopCountLabelSetTextUIActivityN24ConstGetItemCountStr#DD4D1#D9BF68            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       com      comInfo      itemId      count      cfgItem         _ENV �   �    E   G @ L@� d� ��@ ��@�� � A�@A ǀ��� � !��  ��� @ B$� "  ��AB �B��B �C�A � $A  & � @ �C$� �����C �G@ L��A dA�& � F�D G����d� � �@ ́�� �����B CAB ��$��� ��@�@��B CA� ��$��� BB �B� $B�& �    _activityConstGetActiveEndTime_timeModuleGetServerTime�      mathfloor        IsActivityEnd_timeLabelSetTextStringTableGetstr_n24_activity_end
GetStatus       
SetStatus       UIActivityN24ConstGetTimeStringstr_n24_activity_remain_time(str_n24_activity_remain_get_reward_time         E   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    E   endTime   E   nowTime   E   seconds   E   status   E   timeStr+   E   	timeTips,   E   status/   E      _ENV �   �       G @ L@� ǀ@ ����  d@  G A L@� ǀ@ �@��  d@  G�A L@� ǀ@ ����  d@  G B L@� ǀ@ �@��  d@  G�B L@� ǀ@ ����  d@  & �    
_eventRed
SetActive_activityConstIsShowBattlePassRed
_loginRedIsShowLoginRed_petRedIsShowTryPetRed	_fishRedIsShowHomelandTaskRed	_shopRedIsShowShopRed           �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self            �   �       L @ �@@    d@ & �    
StartTaskReLoadData           �   �   �   �   �      self            �   �       � @ A  �@���@ ��@�� � AC� �@��@A ̀�@� � �@ ��A �@ � B �@ �@B AA  �@�& � 
   Lock'UIActivityN24MainController_ReLoadDataAsyncRequestResNewSetSucc_activityConst	LoadDataRefreshRedAndNewRefreshShopBtnStatusUnLock            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       TT       res         _ENV �   �       L @ � � d@�& �    SetButtonShowStatus           �   �   �   �      self            �   �       F @ G@� d@� & �    UIActivityBattlePassHelperOpenMainController            �   �   �   �      self          _ENV �   �       G @ L@� d� b@  ��F�@ G�� � A �@A�� �  d@  & � L�A �    FAB G����B �Cd@ & �    _activityConstIsLoginEnableToastManager
ShowToastStringTableGetstr_n24_activity_endShowDialog$UIActivityTotalLoginAwardControllerECampaignTypeCAMPAIGN_TYPE_N24ECampaignN24ComponentIDECAMPAIGN_N24_CUMULATIVE_LOGIN            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self          _ENV �      "   G @ L@� d� b@  ��F�@ G�� � A �@A�� �  d@  & � G @ L�� d� � B�@    ��   ,  LAB ƁB d����B  FBC G����C �D� ,C  �A�& �    _activityConstIsTryPetEnableToastManager
ShowToastStringTableGetstr_n24_activity_endGetTryPetComponentm_pass_mission_info
GetModuleMissionModuleShowDialogUIActivityPetTryControllerECampaignTypeCAMPAIGN_TYPE_N24ECampaignN24ComponentIDECAMPAIGN_N24_FIRST_MEET         �   �       F    �   �C@  C � f  & �               �   �   �   �   �   �   �      mid          	passInfo         E   L � d� �  �   � A@$� E� L��d �@  ��� FAGA�� �@ ̀� C  �@�& �    TeamCtxGetCampaignMissionComponentIdGetCampaignMissionParamKeyMapInitTeamOpenerType	CampaignShowDialogUITeams                  	  
                                     
missionid       ctx      param         missionModulecom_ENV"   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �                          self    "   com   "   comInfo   "   	passInfo   "   isTryoutLevelPass   "   missionModule   "      _ENV   +   1   G @ L@� d� b@  ��G @ L�� d� b   ��F�@ G � �@A ��A�� �  d@  @�F@A G�� �  �@B ǀ�@ �B$ �   d�  ��@ � A� � �@ & � L C �@ � F�C G��AD ��Dd@ F@B G�� d@� G E L@� �   d@�& �    _activityConstIsHomelandTaskEnableIsHomelandTaskEndToastManager
ShowToastStringTableGetstr_n24_activity_endstr_n24_open_tipsUIActivityN24ConstGetTimeStringGetHomelandRemaindOpenSecondsShowDialog$UIHomelandStoryTaskSimpleController       ECampaignTypeCAMPAIGN_TYPE_N24ECampaignN24ComponentIDECAMPAIGN_N24_PANGOLINClearHomelandTaskNewStatus	_fishNew
SetActive         1                                                                   !  #  $  %  &  &  '  (  #  )  )  )  *  *  *  *  +     self    1   str          _ENV .  ;       G @ L@� d� b@  ��F�@ G�� � A �@A�� �  d@  & � F�A G � �@B ̀B A� � � �@�ǀ��C D$�� AD��D � $�  l  d@�& �    _activityConstIsShopEnableToastManager
ShowToastStringTableGetstr_n24_activity_endUIActivityHelperSnap_shotGetUIComponentRectTransform	SafeArearectsizeGameGlobalUIStateManagerGetControllerCameraGetName         7  9      E   L � �@� ǀ�   d@ & �    SwitchStateUIStateType
UIN24Shop             8  8  8  8  8  8  9     	cache_rt          self_ENV    /  /  /  /  /  0  0  0  0  0  0  0  1  3  3  4  5  5  5  5  5  5  6  6  6  6  6  6  6  9  3  ;     self           _ENV >  @      L @ �@  �  d@ & �    ShowDialogUIIntroLoaderUIN24Intro           ?  ?  ?  ?  @     self            C  E   
   F @ G@� d�� L�� ��@ � �A AAd@ & �    GameGlobalEventDispatcher	DispatchGameEventTypeGuideOpenUIUIActivityN24MainController         
   D  D  D  D  D  D  D  D  D  E     self    
      _ENVO                                 G      I   P   I   R   T   R   V   Z   V   \   d   \   f   h   f   j   n   j   p   w   p   {   ~   {   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �     �     +    .  ;  .  >  @  >  C  E  C  E         _ENV