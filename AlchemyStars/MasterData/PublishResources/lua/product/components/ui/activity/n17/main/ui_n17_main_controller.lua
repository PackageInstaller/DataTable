LuaS �

xV           (w@�@E:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/lua/product/components/ui/activity/n17/main/ui_n17_main_controller.lua         s    @ A@  ��@ $@�@@  ��@@ l   
@��@@ l@  
@ �@@ l�  
@��@@ l�  
@ �@@ l  
@��@@ l@ 
@ �@@ l� 
@��@@ l� 
@ �@@ l  
@�� C l@ 
@�� C l� 
@ � C l� 
@�� C l  
@ � C l@ 
@�� C l� 
@ � C l� 
@�� C l  
@ � C l@ 
@�� C l� 
@ � C l� 
@�� C l  
@ � C l@ 
@�� C l� 
@ � C l� 
@�� C l  
@ � C l@ 
@�� C l� 
@ � C l� 
@�� C l  
@ � C l@ 
@�� C l� 
@ � C l� 
@�� C l  
@ � C l@ 
@�� C l� 
@ � C l� 
@��& � (   _classUIN17MainControllerUIController_SetRemainingTime_SetCommonTopButton_Back_HideUI_ShowUI_SetBg
_SetSpine
_SetImgRT_CheckGuideUIN17MainControllerLoadDataOnEnterOnShowOnHideDestroy	_Refresh_CheckNewsignal_UpdateTime_SetIntroBtn_SetReviewBtn_SetTryoutBtn_SetBattlePassBtn_SetLoginRewardBtn_SetMiniGameBtn_SetLotteryBtn_SetDailyPlanBtnShowBtnOnClickIntroBtnOnClickReviewBtnOnClick_AttachEvents_DetachEvents_CheckActivityClose_GetRoleId_SetEffect_SetMainTex_SetSpineEffect_HandelSpineMaterial_HandelRawImageMaterial    $              �@ �A@�   � A�  �� b  @ ���@�A �AAB �  � �A�́A@��A���A@ �  �  �A�& �    UIWidgetHelperSpawnObjectUIActivityCommonRemainingTimeSetCustomTimeStr_Common_1SetExtraTexttxtDescSetAdvanceTextSetData                        @ $@ & �    _UpdateTime                              self   	   	   	   	   	   	                                                            self       widgetName       extraId       descId       endTime       customTimeStr       obj         _ENV    ,    	   F @ G@� �   ��  �  d� � � ,  D� �  ,B  �@�& �    UIWidgetHelperSpawnObject
_backBtnsUICommonTopButtonSetData         "   $            @ $@ & �    _Back           #   #   #   $          self (   *            @ $@ & �    _HideUI           )   )   )   *          self                           !   $   %   '   *   !   ,      self       obj         _ENV /   1       L @ �@@ ǀ�d@�& �    SwitchStateUIStateTypeUIMain            0   0   0   0   1      self          _ENV 4   :       L @ �@  d��L�� �   d@�L @ ��  d��L�� � � d@�L @ �  d��L�� �   d@�& �    GetGameObject
_backBtns
SetActive	_showBtn_uiElements           5   5   5   5   5   5   6   6   6   6   6   6   8   8   8   8   8   8   :      self            =   C       L @ �@  d��L�� � � d@�L @ ��  d��L�� �   d@�L @ �  d��L�� � � d@�& �    GetGameObject
_backBtns
SetActive	_showBtn_uiElements           >   >   >   >   >   >   ?   ?   ?   ?   ?   ?   A   A   A   A   A   A   C      self            F   K       F @ G@� ��@ ��  d��b   @�� A �@A�   � @� �@ & �    UIActivityHelperGetCampaignMainBg
_campaign       UIWidgetHelperSetRawImage_mainBg            G   G   G   G   G   H   H   I   I   I   I   I   I   K      self       url         _ENV N   Q       L @ �@  �  d� ���  �@�& �    GetUIComponentSpineLoader_spine
LoadSpinen17_kv_1_spine_idle           O   O   O   O   P   P   P   Q      self       obj           T   ]       _ � ���@@ �  A�  �� �@ �� � �  �   �  & �     GetUIComponent	RawImagerttexture           U   U   W   W   W   W   X   Z   Z   \   \   ]      self       imgRT       rt   	        `   b    
   F @ G@� d�� L�� ��@ � �A AAd@ & �    GameGlobalEventDispatcher	DispatchGameEventTypeGuideOpenUIUIN17MainController         
   a   a   a   a   a   a   a   a   a   b      self    
      _ENV i   �    8   A@ �@
 �A AA$� 
 ���@ �A�� � @ F�A G���A �BB��A ǂ��A �BF�A G���A �CC$A��   @��C$� "A  @��@ �C�D�� $A�& � �@ AD�� $A�A AA$� 
 ��D AA$� G�D L����   FB@ G�dA�& �    _campaignTypeECampaignTypeCAMPAIGN_TYPE_N17
_campaignUIActivityCampaignNewLoadCampaignInfoECampaignN17ComponentIDECAMPAIGN_N17_CYCLE_QUESTECAMPAIGN_N17_LOTTERYECAMPAIGN_N17_CUMULATIVE_LOGINECAMPAIGN_N17_STORYECAMPAIGN_N17_MINI_GAMEECAMPAIGN_N17_LEVEL_FIXTEAMGetSuccCheckErrorCode	m_resultClearCampaignNew_bp_campaignAsyncRequestResCAMPAIGN_TYPE_BATTLEPASS         8   j   j   j   n   n   n   n   o   o   p   q   r   s   s   t   t   u   u   v   v   w   w   x   y   o   |   |   |   |   |   |   }   }   }   }   }   ~   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    8   TT    8   res    8   	uiParams    8   bp_res0   8      _ENV �   �    $   � @ �@ 
�����@ �@ � A �@ �@A �@ ��A �@ ��A �@ � B �@ �@B �@ ��B �� ����    �� C �@C�   � A� � �  �@ � ��@D �@ ��D �@ & �    _AttachEvents_isOpen_SetBg_SetCommonTopButton
_SetSpine_UpdateTime_SetIntroBtn_SetReviewBtn	_Refresh
_SetImgRT       UIWidgetHelperPlayAnimation_animUIN17MainController_anim�      _CheckGuide_CheckNewsignal         �   �            @ $@    @@ $@ & �    _CheckGuide_CheckNewsignal           �   �   �   �   �   �   �          self$   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    $   	uiParams    $      _ENV �   �       L @ d@ 
���& �    _DetachEvents_isOpen            �   �   �   �      self            �   �       F@@ G�� � @ d� 
@ �& �    _matReqUIWidgetHelperDisposeLocalizedTMPMaterial            �   �   �   �   �   �      self          _ENV �   �       L @ d@ L@@ ǀ@ d@�L�@ d@ L A d@ L@A d@ L�A d@ & �    _SetTryoutBtn_SetBattlePassBtn_bp_campaign_SetLoginRewardBtn_SetMiniGameBtn_SetLotteryBtn_SetDailyPlanBtn           �   �   �   �   �   �   �   �   �   �   �   �   �   �      self            �   �       G @ L@� d� ��� �� �    ���@  �@��@� �@ & �    
_campaignGetLocalProcessHaveNewHighEquipShowDialogUIN17MainTipsControllerOnEnterMiniGame           �   �   �   �   �   �   �   �   �   �   �   �   �      self       localProcess           �   �    1   F @ G@� ��@ d� ��@ � A�@� � π��� ��A � �FAB G��䀀�A B�AB ��B$��F�@ G��A��ACd����A ��C�� ��C @���D AB �� ��  �C� �A� � ����D AB �� �   C  �A�& �    GameGlobal
GetModuleSvrTimeModulemathfloorGetServerTime����MbP?
_campaignGetComponentInfoECampaignN17ComponentIDECAMPAIGN_N17_CYCLE_QUESTECAMPAIGN_N17_STORYmaxm_close_time
GetSample	end_time_SetRemainingTime_remainingTimePoolstr_n17_main_remaining_timestr_n17_main_remaining_time_2         1   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    1   svrTimeModule   1   curTime
   1   info1   1   info2   1   stop1   1   stop2   1      _ENV �   �    	   F@@ G�� �   ��   G@ d��
@ �& �    _matReqUIWidgetHelperSetLocalizedTMPMaterial_introTitleUIN17_Material.mat         	   �   �   �   �   �   �   �   �   �      self    	      _ENV �   �       & �                �      self            �      	   F @ G@� ��@ ��@�    AA �� ̀AA� �  �@ � B �@�@� 䀀�B�B �� ,B  $A�& �    ECampaignN17ComponentIDECAMPAIGN_N17_LEVEL_FIXTEAMUIWidgetHelperSpawnObject_tryoutBtn#UIActivityCommonComponentEnterLockSetRedred
_campaignGetComponentSetData         �   �         @ @@ $� �@ %  &   & �    
_campaignGetLocalProcessGetFixMissionRedDot           �   �   �   �   �   �   �          self �       	       @ �@  ƀ@ � l  �A  $@�& �    ShowDialogUIActivityPetTryController_campaignType          �         E   L � �   e �f   & �    IsPassCamMissionID                               mid          
component      	   E   L � �@� d����� �� ��@ � �E 䀀 @  �A��� ́�� +A  L�A�� �A�  dA L�B�  dA�& �    
GetModuleMissionModuleTeamCtx
_campaignGetComponentGetCampaignMissionComponentIdGetCampaignMissionParamKeyMapInitTeamOpenerType	CampaignShowDialogUITeams                                    	  
  
                             
missionid       missionModule      ctx      missionComponent
      param         self_ENVcomponentId	   �   �   �   �   �       �            selfcomponentId
component_ENV   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �     �        self       componentId      obj      
component         _ENV   )      �   �@    L�� d� b  ����@  @ �� �AA@�䁀���� � $B ��A   ����B@��A�& � 	   _battlePassBtnUIActivityCommonCampaignEnterCheckCampaignOpenGetUIComponentUISelectObjectPathSpawnObjectSetDataGetGameObject
SetActive                           "  "  "  "  #  #  #  $  $  $  $  '  '  '  (  (  (  )  	   self       bp_campaign       widgetName      
className      useStateUI      open_sample      pool      obj      obj           ,  >      F @ G@� ��@ ��@�    AA �� ̀AA� �  �@ � BGAB �A  �@ & � 
   ECampaignN17ComponentIDECAMPAIGN_N17_CUMULATIVE_LOGINUIWidgetHelperSpawnObject_loginRewardBtnUIActivityCommonComponentEnterSetRedredSetData
_campaign         3  5        @ @@ $� �@ %  &   & �    
_campaignGetLocalProcessAccumulateLoginReddot           4  4  4  4  4  4  5         self :  <           @ �@  �   �@ E� $@ & �    ShowDialog$UIActivityTotalLoginAwardController_campaignType           ;  ;  ;  ;  ;  ;  ;  <         selfcomponentId   -  -  /  /  /  /  /  /  1  2  5  1  8  9  <  8  >     self       componentId      obj         _ENV A  j   :   F @ G@� ��@ ��@ � ���� A �@�   A� �� � ��A �  $A ���� � ,B  $A��   � �AC$� "A    �� L��� B @ �� dA K � �� � �A �� � �A� � A +B� K� �B kB� kA ��� ��A����F @� ��  �A�& �    ECampaignN17ComponentIDECAMPAIGN_N17_MINI_GAME
_campaignGetComponentUIWidgetHelperSpawnObject_miniGameBtn#UIActivityCommonComponentEnterLockSetNew_newSetRedCount
_redCount_redCountTxtComponentUnLockTime        SetActivityCommonRemainingTime_timePool_lock str_n17_minigame_remaining_timestate_lock
time_lockstate_unlockstate_closeSetWidgetNameGroupSetData
_campaign         H  J        @ @@ $� �@ %  &   & �    
_campaignGetLocalProcessWeiSiExploreReddot           I  I  I  I  I  I  J         self P  S        @ @@ $�� f  & �    HomelandFindTreasureConstGetSingleCount            Q  Q  Q  R  S     primaryCount      seniorCount         _ENV e  h    
       @ �@  � � �� �@F� GA�$@ & �    ShowDialogUIFindTreasureDetailECampaignTypeCAMPAIGN_TYPE_N17ECampaignN17ComponentIDECAMPAIGN_N17_MINI_GAME          
   f  f  f  f  f  f  g  g  f  h         self_ENV:   B  B  C  C  C  C  E  E  E  E  E  E  G  G  J  G  M  N  O  S  M  W  W  W  W  W  W  W  X  X  X  X  X  X  Z  Z  [  [  [  [  \  \  \  ]  ]  ]  ^  ^  _  `  `  `  b  c  d  h  b  j     self    :   componentId   :   
component   :   obj   :   unlockTime   :   tb1   :      _ENV m  �   5   F @ G@� ��@ ��@�    AA �� ̀AA� �  �@ � BAA �A  �@ ǀB ���@� 䀀�$� �AC ��C� � A � ���A � �� B �A� � AB +B� K� �B kB� �� �� �B� �A ��D@ �A��EG�B �� �  �A�& �    ECampaignN17ComponentIDECAMPAIGN_N17_LOTTERYUIWidgetHelperSpawnObject_lotteryBtn#UIActivityCommonComponentEnterLockSetNewnewSetRedred
_campaignGetComponentGetLotteryCostItemIconTextUIN17LotteryControllerSetLotteryIconTexticontextBtn
Btn_CloseSetWidgetNameGroupSetData         u  w        @ @@ $� �@ %  &   & �    
_campaignGetLocalProcessGetIntegratedCalculation           v  v  v  v  v  v  w         self |  ~        @ @@ $� �@ %  &   & �    
_campaignGetLocalProcessLotteryShopReddot           }  }  }  }  }  }  ~         self �  �        @ @@ �@ � � ��� � ��� AAD  �@ ��A$@�& �    
_campaign_campaign_moduleCampaignSwitchStateUIStateTypeUIN17LotteryControllerUIMain_id             �  �  �  �  �  �  �  �  �  �  �  �  �         self_ENV5   n  n  p  p  p  p  p  p  s  t  w  s  z  {  ~  z  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    5   componentId   5   obj   5   
component   5   icon   5   count   5   tb,   5      _ENV �  �   	#   F @ G@� ��@ ��@�    AA �� ̀AA� �  �@ �  � A +A� K� � kA� �� � �A� �� B �A� �@ �B��$A��B�C �� ,B  $A�& �    ECampaignN17ComponentIDECAMPAIGN_N17_CYCLE_QUESTUIWidgetHelperSpawnObject_dailyPlanBtn#UIActivityCommonComponentEnterLockSetNewnewBtn
Btn_CloseSetWidgetNameGroupSetData
_campaign         �  �        @ @@ $� �@ %  &   & �    
_campaignGetLocalProcessGetPlanListRedDot           �  �  �  �  �  �  �         self �  �           @ �@  $@�& �    ShowDialogUIN17DailyPlanController           �  �  �  �  �         self#   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    #   componentId   #   obj   #   tb   #      _ENV �  �      � @ �@ & �    _ShowUI           �  �  �     self       go            �  �      � @ A  A�  �@ & �    ShowDialogUIN17IntroControllerUIN17IntroController_Main           �  �  �  �  �     self       go            �  �   
   � @ �@@ǀ@ �  ���� A AA � �@ & �    UIActivityHelperGetCampaignFirstEnterStoryID
_campaign       ShowDialogUIStoryController         
   �  �  �  �  �  �  �  �  �  �     self    
   go    
   	story_id   
      _ENV �  �      L @ �@@ ǀ��@ d@ L @ �@@ � �AA d@ & �    AttachEventGameEventTypeActivityCloseEvent_CheckActivityCloseAfterUILayerChanged	_Refresh            �  �  �  �  �  �  �  �  �  �  �     self          _ENV �  �      L @ �@@ ǀ��@ d@ L @ �@@ � �AA d@ & �    DetachEventGameEventTypeActivityCloseEvent_CheckActivityCloseAfterUILayerChanged	_Refresh            �  �  �  �  �  �  �  �  �  �  �     self          _ENV �  �      � @ �   ��� @ �@@@ � ���@ �@ A�@�& �    
_campaign_idSwitchStateUIStateTypeUIMain            �  �  �  �  �  �  �  �  �  �  �  �     self       id          _ENV �  �      F @ G@� ��@ d� ��� �� �  & �    GameGlobal
GetModuleRoleModule	GetPstId            �  �  �  �  �  �  �  �     self       roleModule      pstId         _ENV �  �      L @ d@ & �    _SetMainTex           �  �  �     self            �     
   L @ �@  �  d� ��@  ����@AF�A ��A �Bd �  A��B�� �A� ��A� ��$A  & �    GetUIComponent	RawImageTitleImg_RawImageGetGameObject	TitleImgGetComponenttypeofUnityEngineMeshRenderer	materialSetTexture	_MainTexGetTexture                                                               self       	rawImage      obj      meshRender         _ENV         & �                     self       widgetName                    & �                     self       	material            !  '      & �                '     self       widgetName           s                                 ,      /   1   /   4   :   4   =   C   =   F   K   F   N   Q   N   T   ]   T   `   b   `   i   �   i   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �     �     )    ,  >  ,  A  j  A  m  �  m  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �    �              !  '  !  '         _ENV