LuaS �

xV           (w@�@E:/depot_matchsrpg/matchsrpg/b/1805/client/Assets/../PublishResources/lua/product/components/ui/activity/n16/main/ui_activity_n16_main_controller.lua         d    @ A@  ��@ $@�@@  ��@@ l   
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
@�� D l@ 
@�� D l� 
@ � D l� 
@�� D l  
@ � D l@ 
@�� D l� 
@ � D l� 
@�� D l  
@ � D l@ 
@�� D l� 
@ � D l� 
@�� D l  
@ � D l@ 
@�� D l� 
@ � D l� 
@�� D l  
@ � D l@ 
@�� D l� 
@ �& � #   _classUIActivityN16MainControllerUIController_SpawnObject_SetRemainingTime
_PlayAnim_InitWidgetLoadDataOnEnterOnShowOnHide	_Refresh_SetBg
_SetSpine_UpdateRemainingTime_SetBattlePassBtn_SetExchangeBtnUIActivityN16MainController_RefeshCount_SetLoginRewardBtn_SetLineMissionBtn_SetHardLevelBtn_SetSubjectBtnShowBtnOnClickHideBtnOnClickInfoBtnOnClick_AttachEvents_DetachEvents_CheckActivityClose_GetRoleId_SetEffect_SetMainTex_SetSpineEffect_HandelSpineMaterial_HandelRawImageMaterial_CheckGuide               	   � @ AA  �� � ��� $��& & �    GetUIComponentUISelectObjectPathSpawnObject        	               	   	   	   
         self    	   widgetName    	   
className    	   pool   	   obj   	                  �@  � AB  �� b  @ �́@�A ��@A �  � �A��AA@��A�́A@ �  �  �A�& �    _SpawnObjectUIActivityCommonRemainingTimeSetCustomTimeStr_Common_1SetExtraTexttxtDescSetAdvanceTextSetData                       @ $@ & �    _UpdateRemainingTime                              self                                                                        self       widgetName       extraId       descId       endTime       customTimeStr       obj           !   0    
   L@ �A   � d� ��@   �A����  �A��A ,  @  �A & �    GetUIComponent
AnimationLockPlay
StartTask         '   -       F @ �   � � d@�E  L@� � �d@�E  b   @ �E  d@� & �    YIELDUnLock             (   (   (   (   )   )   )   )   *   *   *   +   +   -      TT          _ENVtimeself	animName	callback   "   "   "   "   $   $   $   %   %   %   &   -   /   &   0      self       widgetName       	animName       time       	callback       anim         _ENV 3   D    	   L@@ ��    d� 
@ �L@@ ��   d� �@� � ���
� �� A ��A,  D� �  ,B  �@�& �    _mainBgGetUIComponentRawImageLoaderUISelectObjectPath
_backBtnsSpawnObjectUICommonTopButtonSetData         :   <            @ �@� ��@$@�& �    SwitchStateUIStateTypeUIMain             ;   ;   ;   ;   ;   <          self_ENV @   B            @ $@ & �    HideBtnOnClick           A   A   A   B          self   4   4   4   4   4   6   6   6   6   8   8   8   8   9   9   <   =   ?   B   9   D      self       	backBtns	         _ENV H   d    .   A@ �@
 �A AA$� 
 ���@ �A�� � @ F�A G���A �BB��A ǂ��A �BF�A G���A �CC��A ǃ��A �C$A��   @�D$� "A  @��@ AD��D�� $A�& � �@ �D�� $A�& �    _campaignTypeECampaignTypeCAMPAIGN_TYPE_N16
_campaignUIActivityCampaignNewLoadCampaignInfoECampaignN16ComponentIDECAMPAIGN_N16_SHOPECAMPAIGN_N16_CUMULATIVE_LOGINECAMPAIGN_N16_LEVEL_COMMONECAMPAIGN_N16_LEVEL_HARDECAMPAIGN_N16_LEVEL_FIXTEAMECAMPAIGN_N16_ACTION_POINTECAMPAIGN_N16_STORYECAMPAIGN_N16_ANSWER_GAMEGetSuccCheckErrorCode	m_resultClearCampaignNew         .   I   I   I   M   M   M   M   N   N   O   P   Q   R   R   S   S   T   T   U   U   V   V   W   W   X   X   Y   Z   N   ]   ]   ]   ]   ]   ]   ^   ^   ^   ^   ^   _   c   c   c   c   d      self    .   TT    .   res    .   	uiParams    .      _ENV f   �    	0   �@@ �  F�@ G��� 
� ��@A �@ ��A B ���
� �
���B �@ � C �@ �@C �@ ��C �@ ��C �@ �@� 
� ��� � D _������ � E AA � �� ,  �@ ��E � ��@� ���@ � E AA � �� ,B  �@ & �    _atlas	GetAssetUIN16.spriteatlas	LoadTypeSpriteAtlas_AttachEvents_svrTimeModule
GetModuleSvrTimeModule_isOpen_InitWidget
_SetSpine_UpdateRemainingTime_SetEffect	_RefreshimgRT       uieffanim_N16_main_show 
_PlayAnim_anim�      CutsceneManagerExcuteCutsceneOutuieffanim_N16_main_in         �   �            @ $@ & �    _CheckGuide           �   �   �   �          self �   �            @ $@ & �    _CheckGuide           �   �   �   �          self0   g   g   g   g   g   g   h   h   k   k   k   k   m   o   o   p   p   r   r   s   s   u   u   x   x   y   z   z   z   ~      �   �   �   �      �   �   �   �   �   �   �   �   �   �   �   �      self    0   	uiParams    0   entermodel   0      _ENV �   �       L @ d@ 
���& �    _DetachEvents_isOpen            �   �   �   �      self            �   �       L @ d@ L@@ d@ L�@ d@ L�@ d@ L A d@ L@A d@ & �    _SetBattlePassBtn_SetExchangeBtn_SetLoginRewardBtn_SetLineMissionBtn_SetHardLevelBtn_SetSubjectBtn           �   �   �   �   �   �   �   �   �   �   �   �   �      self            �   �       F @ G@� ��@ ��  d��b   � �� A �@A � �@�& �    UIActivityHelperGetCampaignMainBg
_campaign       _mainBg
LoadImage            �   �   �   �   �   �   �   �   �   �   �   �      self       url         _ENV �   �       L @ �@  �  d� ���  �@�& �    GetUIComponentSpineLoader_spine
LoadSpinen16_kv_1_spine_idle           �   �   �   �   �   �   �   �      self       obj           �   �    2   F @ G@� ��@ d� ��@ � A�@� � π��� ��A � �FAB G���� � �$� ACN�  @�����C  AB �  � � �A�& � ��A �BBB �DA� �� �C� A�N�  @�����C A �� �    �A & � & �    GameGlobal
GetModuleSvrTimeModulemathfloorGetServerTime����MbP?
_campaignGetComponentByTypeCampaignComTypeE_CAMPAIGN_COM_LINE_MISSION       GetComponentInfom_close_time        _SetRemainingTime_remainingTimePool&str_activity_n16_main_remaintime_descE_CAMPAIGN_COM_EXCHANGE_ITEM str_activity_n16_main_time_desc         2   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    2   svrTimeModule   2   curTime
   2   lineComponent   2   endTime   2   stamp   2   exchangeItemComponent$   2      _ENV �   �    !   F @ G@� ��  ��    FA LA�d� ��� � �A������ �  ���B AB � � ����$��L�B��  dB �C @ 䁀B�� $B�& �    ECampaignTypeCAMPAIGN_TYPE_BATTLEPASS_battlePassBtnUIActivityCommonCampaignEnterUIActivityCampaignNewLoadCampaignInfo_LocalCheckCampaignOpenGetUIComponentUISelectObjectPathSpawnObjectSetDataGetGameObject
SetActive         !   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   
   self    !   campaignType   !   widgetName   !   
className   !   useStateUI   !   	campaign   !   open_sample   !   pool      obj      obj   !      _ENV �      1   F @ G@� ��@  AA �� 
� ���@ ��A� l  �@ � B �@B � ���̀B�� �    �G�@ L���  �dA FAC G���� � d���D �AD��  �F�D � d ��  ǁ@ ��AB � �A ǁ@ ́�GB �B  �A & �    ECampaignN16ComponentIDECAMPAIGN_N16_SHOPexchangeobj_SpawnObject_exchangeBtnUIActivityCommonComponentEnterSetRedred
_campaignGetComponentGetCostItemIconTextSetIconiconUIActivityHelperGetZeroStrFrontNum       stringformat3<color=#4c4c4c>%s</color><color=#d1b24c>%s</color>	tostringSetTexttextSetData         �   �         @ @@ � � $��"   � � @ �@ � � $��&  & �    
_campaignCheckComponentOpenCheckComponentRed           �   �   �   �   �   �   �   �   �   �   �   �          selfcomponentId �       	    @ @@ F�� G�� ��� � A�   $@ & �    ClientCampaignShopOpenCampaignShop
_campaign_type_id          �              @ �@� ��@$@�& �    SwitchStateUIStateTypeUIActivityN16MainController                                     self_ENV	   �   �   �   �   �   �     �            _ENVself1   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �     �        self    1   componentId   1   
component   1   icon   1   count   1   preZero   1   fmtStr&   1      _ENV         F @ G@� ��@ ��@ � ���� A�� FAA G���� � d���B �AB��  �F�B � d ��  �C �A�A� � �A & �    ECampaignN16ComponentIDECAMPAIGN_N16_SHOP
_campaignGetComponentGetCostItemIconTextUIActivityHelperGetZeroStrFrontNum       stringformat3<color=#4c4c4c>%s</color><color=#d1b24c>%s</color>	tostringexchangeobjSetTexttext                	  	  	  	  
  
                                           self       componentId      
component      icon      count      preZero      fmtStr         _ENV   "      F @ G@� ��@ �  A �� �@AA� �  �@ ��AGB �A  �@ & � 	   ECampaignN16ComponentIDECAMPAIGN_N16_CUMULATIVE_LOGIN_SpawnObject_loginRewardBtnUIActivityCommonComponentEnterSetRedredSetData
_campaign                   @ @@ � � $��"   � � @ �@ � � $��&  & �    
_campaignCheckComponentOpenCheckComponentRed                                          selfcomponentId               @ �@  �   �@ E� $@ & �    ShowDialog$UIActivityTotalLoginAwardController_campaignType                                   selfcomponentId                                "     self       componentId      obj         _ENV $  M   c   F @ G@� � @ ��@��@ � �@� 䀀AA �� �� $� LB�A ,  dA �   � �L��d� bA    �A� �CB D  ���� �A � �� � �A� � A� +B� K� �� kB� �� � �B� �A �AD@ �A�́DG�D �� �B  �A��E�A�A� �� � �D F�� $��"  � �AB bB    �A� "  ����F �G�B � A� �� �B  @���F �G�  A �� ǂH ���@�䂀�����E�B�A	 �C	 � ��A��	 $��
�ʂ��& � *   ECampaignN16ComponentIDECAMPAIGN_N16_LEVEL_COMMONECAMPAIGN_N16_LEVEL_FIXTEAM
_campaignGetComponent_SpawnObject_lineMissionBtn#UIActivityCommonComponentEnterLockSetRedredComponentUnLockTime        SetActivityCommonRemainingTime_remainingTimePool_lockstate_lockstate_unlockstate_closeSetWidgetNameGroupSetData
_campaignviewGetUIComponentImagebgstateCheckComponentOpenn16_zjm_di2n16_zjm_di02ColorNewyyyyyy�?�?�������?�?sprite_atlas
GetSpriteUILocalizationTexttxt
transformOutlineenabledcolor         .  1        @ @@ � � �  $� "    � @ �@ � � �  $� &  & �    
_campaignCheckComponentOpenCheckComponentRed           /  /  /  /  /  /  /  0  0  0  0  0  0  1         selfcomponentIdcomponentId2 @  B           @ �@� ��@$@�& �    SwitchStateUIStateType#UIActivityN16LineMissionController             A  A  A  A  A  B         self_ENVc   %  %  &  &  (  (  (  (  *  *  *  *  ,  -  1  ,  4  4  4  4  4  4  4  5  5  5  5  5  5  :  :  :  :  :  :  :  :  :  :  :  :  :  :  ;  ;  ;  =  >  ?  B  =  D  D  D  D  D  E  E  E  E  F  F  F  F  F  F  G  G  G  G  G  G  G  G  G  G  G  G  G  G  G  G  H  H  H  H  H  I  I  I  I  I  J  J  J  J  K  L  M     self    c   componentId   c   componentId2   c   
component   c   obj   c   unlockTime   c   tb+   c   img8   c   isOpen<   c   spnameB   c   colorR   c   text\   c   outline`   c      _ENV O  �   k   F @ G@� ��@ ��@ � ���� A AA �� � �A $� L��A ,  dA L���� ,B  dA �   � �LCd� bA    �AA ���� D  ���� �A � �� AB �� �A� A �� +B K� �� kB� � ��  �B �A �A�@ �A�́�G�E �� �  �A����A�A� �� � �E G�� $��"  � �AB bB    �A� "  ����G �H�B � A� �� �B  @���G �H�	 	 A	 �� ǂI ���@�䂀�������B�A
 �C
 � ���@��
 $��
�ʂ��& � .   ECampaignN16ComponentIDECAMPAIGN_N16_LEVEL_HARD
_campaignGetComponent_SpawnObject_hardLevelBtn#UIActivityCommonComponentEnterLock_GetRoleIdSetNewnewSetRedredComponentUnLockTime        SetActivityCommonRemainingTime_remainingTimePool_lock
icon_lock
time_lockbg_lockstate_unlockstate_closeSetWidgetNameGroupSetData
_campaignviewGetUIComponentImagebgstateCheckComponentOpenn16_zjm_di01n16_zjm_di1ColorNewyyyyyy�?�?�������?�?sprite_atlas
GetSpriteUILocalizationTexttxt
transformOutlineenabledcolor         X  Z           @ $� "   ��@� �@ A�  �  ]�� $�    &  & �    ComponentIsOpenLocalDBHasKeyUIActivityN16HardLevel            Y  Y  Y  Y  Y  Y  Y  Y  Y  Y  Y  Y  Y  Z         
component_ENVroleId _  a        @ @@ � � $��"   � � @ �@ � � $��&  & �    
_campaignCheckComponentOpenCheckComponentRed           `  `  `  `  `  `  `  `  `  `  `  a         selfcomponentId u  w           @ �@� ��@� �  C  �  �@�$@ & �    SwitchStateUIStateTypeUIN16HardLevel             v  v  v  v  v  v  v  v  v  v  w         self_ENVk   P  P  Q  Q  Q  Q  S  S  S  S  U  U  V  W  Z  V  ]  ^  a  ]  d  d  d  d  d  d  d  e  e  e  e  e  e  j  j  k  k  k  k  k  l  l  l  l  m  m  m  n  n  n  o  p  p  p  r  s  t  w  r  z  z  z  z  z  {  {  {  {  |  |  |  |  |  |  }  }  }  }  }  }  }  }  }  }  }  }  }  }  }  }  ~  ~  ~  ~  ~            �  �  �  �  �  �  �     self    k   componentId   k   
component   k   obj
   k   roleId   k   unlockTime   k   tb3   k   img@   k   isOpenD   k   spnameJ   k   colorZ   k   textd   k   outlineh   k      _ENV �  �   <   F @ G@� ��@ ��@ � ���� A AA �� � �A $� L��A ,  dA L���� ,B  dA �   � �LCd� bA    �AA ���� D  ���� �A � �� AB �� �A� A �� +B K� �� kB� � ��  �B �A �A�@ �A�́�G�@ �� �  �A�& �    ECampaignN16ComponentIDECAMPAIGN_N16_ANSWER_GAME
_campaignGetComponent_SpawnObject_subjectBtn#UIActivityCommonComponentEnterLock_GetRoleIdSetNewnewSetRedredComponentUnLockTime        SetActivityCommonRemainingTime_remainingTimePool_lock
icon_lock
time_lockbg_lockstate_unlockstate_closeSetWidgetNameGroupSetData         �  �           @ $� "   ��@� �@ A�  �  ]�� $�    &  & �    ComponentIsOpenLocalDBHasKeyUIActivityN16Subject            �  �  �  �  �  �  �  �  �  �  �  �  �  �         
component_ENVroleId �  �        @ @@ E � L�� d  $�  &  & �    UIN16ConstHasNewOpenSubjectLevelGetComponentInfo            �  �  �  �  �  �  �  �     red         _ENV
component �  �        @ @@ � � $��"@  ���@�@ F AG@� �� d  $@  & �    �A �  �   $@ & � 	   
_campaignCheckComponentOpenToastManager
ShowToastStringTableGetstr_activity_error_110ShowDialogUIN16SubjectMainController          �  �           @ $@ & �    _SetSubjectBtn            �  �  �  �         self   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �         selfcomponentId_ENV<   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    <   componentId   <   
component   <   obj
   <   roleId   <   unlockTime   <   tb3   <      _ENV �  �      L @ �@  d����� � �@�� @ �  ���̀@C  �@�� @ A 䀀���� $A�& �    GetGameObject
_backBtns
SetActive	_showBtn_uiElements           �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       hideBtn      showBtn	      uiElements           �  �      L @ �@  d�����   �@�� @ �  ���̀@C� �@�� @ A 䀀���  $A�& �    GetGameObject
_backBtns
SetActive	_showBtn_uiElements           �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       hideBtn      showBtn	      uiElements           �  �      � @ �@@��  �@ & �    UIActivityHelperShowActivityIntroUIN16Intro            �  �  �  �  �     self       go          _ENV �  �      L @ �@@ ǀ��@ d@ L @ �@@ � �AA d@ & �    AttachEventGameEventTypeActivityCloseEvent_CheckActivityCloseAfterUILayerChanged_RefeshCount            �  �  �  �  �  �  �  �  �  �  �     self          _ENV �  �      L @ �@@ ǀ��@ d@ L @ �@@ � �AA d@ & �    DetachEventGameEventTypeActivityCloseEvent_CheckActivityCloseAfterUILayerChanged_RefeshCount            �  �  �  �  �  �  �  �  �  �  �     self          _ENV �  �      � @ �   ��� @ �@@@ � ���@ �@ A�@�& �    
_campaign_idSwitchStateUIStateTypeUIMain            �  �  �  �  �  �  �  �  �  �  �  �     self       id          _ENV �  �      F @ G@� ��@ d� ��� �� �  & �    GameGlobal
GetModuleRoleModule	GetPstId            �  �  �  �  �  �  �  �     self       roleModule      pstId         _ENV �  �      & �                �     self            �  �   
   L @ �@  �  d� ��@  ����@AF�A ��A �Bd �  A��B�� �A� ��A� ��$A  & �    GetUIComponent	RawImageTitleImg_RawImageGetGameObject	TitleImgGetComponenttypeofUnityEngineMeshRenderer	materialSetTexture	_MainTexGetTexture            �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       	rawImage      obj      meshRender         _ENV         & �                     self       widgetName                    & �                     self       	material                    & �                     self       widgetName               "   
   F @ G@� d�� L�� ��@ � �A AAd@ & �    GameGlobalEventDispatcher	DispatchGameEventTypeGuideOpenUIUIActivityN16MainController         
   !  !  !  !  !  !  !  !  !  "     self    
      _ENVd                                       !   0   !   3   D   3   H   d   H   f   �   f   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �     �           "    $  M  $  O  �  O  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �                       "     "         _ENV