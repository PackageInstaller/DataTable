LuaS �

xV           (w@�@E:/depot_matchsrpg/matchsrpg/b/1120/client/Assets/../PublishResources/lua/product/components/ui/activity/n22/main/ui_activity_n22_main_controller.lua         ^    @ A@  ��@ $@�@@  ��@@ l   
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
@ �@F l@ 
@ �@F l� 
@��@F l� 
@ �@F l  
@��@F l@ 
@ �@F l� 
@��@F l� 
@ �@F l  
@��& � "   _classUIActivityN22MainControllerUIController_SpawnObject_SetRemainingTime
_PlayAnim_InitWidgetLoadDataOnEnterOnShowOnHide	_Refresh_SetBg
_SetSpine_UpdateRemainingTime_SetBattlePassBtn_SetExchangeBtnUIActivityN22MainController_RefeshCount_SetLoginRewardBtn_SetLineMissionBtn_SetHardLevelBtn_SetEntrustBtnShowBtnOnClickHideBtnOnClickInfoBtnOnClickUIActivityN22MainController_AttachEvents_DetachEvents_CheckActivityClose_GetRoleId_SetEffect_SetMainTex_SwitchEntrust_CheckGuide           
    	   � @ AA  �� � ��� $��& & �    GetUIComponentUISelectObjectPathSpawnObject        	                        	   
      self    	   widgetName    	   
className    	   pool   	   obj   	                  �@  � AB  �� b  @ �́@�A ��@A �  � �A��AA@��A�́A@ �  �  �A�& �    _SpawnObjectUIActivityCommonRemainingTimeSetCustomTimeStr_Common_1SetExtraTexttxtDescSetAdvanceTextSetData                       @ $@ & �    _UpdateRemainingTime                              self                                                                        self       widgetName       extraId       descId       endTime       customTimeStr       obj              .    
   L@ �A   � d� ��@   �A����  �A��A ,  @  �A & �    GetUIComponent
AnimationLockPlay
StartTask         %   +       F @ �   � � d@�E  L@� � �d@�E  b   @ �E  d@� & �    YIELDUnLock             &   &   &   &   '   '   '   '   (   (   (   )   )   +      TT          _ENVtimeself	animName	callback                   "   "   "   #   #   #   $   +   -   $   .      self       widgetName       	animName       time       	callback       anim         _ENV 0   J    	   L@@ ��    d� 
@ �L@@ ��   d� �@� � ���
� �� A ��A,  D� �  ,B  �@�& �    _mainBgGetUIComponentRawImageLoaderUISelectObjectPath
_backBtnsSpawnObjectUICommonTopButtonSetData         7   9            @ �@� ��@$@�& �    SwitchStateUIStateTypeUIMain             8   8   8   8   8   9          self_ENV =   H     	      E   L@� ��     A�  �  d@ & �    uieff_UIN22MainController_out
_PlayAnim_anim�              C   E            @ $@ & �    HideBtnOnClick            D   D   D   E          self	   >   ?   ?   @   A   B   E   ?   H      entermodel   	      self   1   1   1   1   1   3   3   3   3   5   5   5   5   6   6   9   :   <   H   6   J      self       	backBtns	         _ENV N   f    ,   A@ �@
 �A AA$� 
 ���@ �A�� � @ F�A G���A �BB��A ǂ��A �BF�A G���A �CC��A ǃ�$A �   @��C$� "A  @��@ D�AD�� $A�& � �@ �D�� $A�& �    _campaignTypeECampaignTypeCAMPAIGN_TYPE_N22
_campaignUIActivityCampaignNewLoadCampaignInfoECampaignN22ComponentIDECAMPAIGN_N22_CUMULATIVE_LOGINECAMPAIGN_N22_FIRST_MEETECAMPAIGN_N22_LINE_MISSION ECAMPAIGN_N22_DIFFICULT_MISSIONECAMPAIGN_N22_POWER2ITEMECAMPAIGN_N22_SHOPECAMPAIGN_N22_ENTRUSTGetSuccCheckErrorCode	m_resultClearCampaignNew         ,   O   O   O   R   R   R   R   S   S   T   U   V   W   W   X   X   Y   Y   Z   Z   [   [   \   \   ]   ^   S   `   `   `   `   `   `   a   a   a   a   a   b   e   e   e   e   f      self    ,   TT    ,   res    ,   	uiParams    ,      _ENV h   �    	/   � @ �@@�@� ��@ �@ 
 ����A � FB GA��� 
�����B C ���
� ��@C �@ ��C �@ ��C �@ � D �@ ��� 
����� �@D _ �@��@E A� � �� ,  �@ � F �@��@� @��@E A� � �� ,B  �@ & �    N22DataSetPrefsMain_AttachEvents_isOpen_atlas	GetAssetUIN22.spriteatlas	LoadTypeSpriteAtlas_svrTimeModule
GetModuleSvrTimeModule_InitWidget
_SetSpine_UpdateRemainingTime	_RefreshimgRT       uieff_UIN22MainController_in 
_PlayAnim_anim�      CutsceneManagerExcuteCutsceneOut         �   �            @ $@ & �    _CheckGuide           �   �   �   �          self �   �            @ $@ & �    _CheckGuide           �   �   �   �          self/   i   i   i   j   j   k   m   m   m   m   m   m   o   o   o   o   p   p   q   q   s   s   t   t   w   w   x   y   y   y   }   ~      �   �   }   �   �   �   �   �   �   �   �   �   �   �      self    /   	uiParams    /   entermodel   /      _ENV �   �       L @ d@ 
���& �    _DetachEvents_isOpen            �   �   �   �      self            �   �       L @ d@ L@@ d@ L�@ d@ L�@ d@ L A d@ L@A d@ & �    _SetBattlePassBtn_SetExchangeBtn_SetLoginRewardBtn_SetLineMissionBtn_SetHardLevelBtn_SetEntrustBtn           �   �   �   �   �   �   �   �   �   �   �   �   �      self            �   �       F @ G@� ��@ ��  d��b   � �� A �@A � �@�& �    UIActivityHelperGetCampaignMainBg
_campaign       _mainBg
LoadImage            �   �   �   �   �   �   �   �   �   �   �   �      self       url         _ENV �   �       L @ �@  �  d� & �    GetUIComponentSpineLoader_spine           �   �   �   �   �      self       obj           �   �    2   F @ G@� ��@ d� ��@ � A�@� � π��� ��A � �FAB G���� � �$� ACN�  @�����C  AB �  � � �A�& � ��A �BBB �DA� �� �C� A�N�  @�����C A �� �    �A & � & �    GameGlobal
GetModuleSvrTimeModulemathfloorGetServerTime����MbP?
_campaignGetComponentByTypeCampaignComTypeE_CAMPAIGN_COM_LINE_MISSION       GetComponentInfom_close_time        _SetRemainingTime_remainingTimePoolstr_n22_activity_main_lasttimeE_CAMPAIGN_COM_EXCHANGE_ITEMstr_n22_exchange_lasttime_desc         2   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    2   svrTimeModule   2   curTime
   2   lineComponent   2   endTime   2   stamp   2   exchangeItemComponent$   2      _ENV �   �    !   F @ G@� ��  ��    FA LA�d� ��� � �A������ �  ���B AB � � ����$��L�B��  dB �C @ 䁀B�� $B�& �    ECampaignTypeCAMPAIGN_TYPE_BATTLEPASS_battlePassBtnUIActivityCommonCampaignEnterUIActivityCampaignNewLoadCampaignInfo_LocalCheckCampaignOpenGetUIComponentUISelectObjectPathSpawnObjectSetDataGetGameObject
SetActive         !   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   
   self    !   campaignType   !   widgetName   !   
className   !   useStateUI   !   	campaign   !   open_sample   !   pool      obj      obj   !      _ENV �      1   F @ G@� ��@  AA �� 
� ���@ ��A� l  �@ � B �@B � ���̀B�� �    �G�@ L���  �dA FAC G���� � d���D �AD��  �F�D � d ��  ǁ@ ��AB � �A ǁ@ ́�GB �B  �A & �    ECampaignN22ComponentIDECAMPAIGN_N22_SHOPexchangeobj_SpawnObject_exchangeBtnUIActivityCommonComponentEnterSetRedred
_campaignGetComponentGetCostItemIconTextSetIconiconUIActivityHelperGetZeroStrFrontNum       stringformat3<color=#d4cdc8>%s</color><color=#f2d385>%s</color>	tostringSetTexttextSetData         �   �         @ @@ � � $��"   � � @ �@ � � $��&  & �    
_campaignCheckComponentOpenCheckComponentRed           �   �   �   �   �   �   �   �   �   �   �   �          selfcomponentId �   �     	    @ @@ F�� G�� ��� � A�   $@ & �    ClientCampaignShopOpenCampaignShop
_campaign_type_id          �   �            @ �@� ��@$@�& �    SwitchStateUIStateTypeUIActivityN22MainController             �   �   �   �   �   �          self_ENV	   �   �   �   �   �   �   �   �   �          _ENVself1   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �        self    1   componentId   1   
component   1   icon   1   count   1   preZero   1   fmtStr&   1      _ENV   
      F @ G@� ��@ ��@ � ���� A�� FAA G���� � d���B �AB��  �F�B � d ��  �C �A�A� � �A & �    ECampaignN22ComponentIDECAMPAIGN_N22_SHOP
_campaignGetComponentGetCostItemIconTextUIActivityHelperGetZeroStrFrontNum       stringformat3<color=#4c4c4c>%s</color><color=#d1b24c>%s</color>	tostringexchangeobjSetTexttext                                                      	  	  	  	  	  
     self       componentId      
component      icon      count      preZero      fmtStr         _ENV         F @ G@� ��@ �  A �� �@AA� �  �@ ��AGB �A  �@ & � 	   ECampaignN22ComponentIDECAMPAIGN_N22_CUMULATIVE_LOGIN_SpawnObject_loginRewardBtnUIActivityCommonComponentEnterSetRedredSetData
_campaign                   @ @@ � � $��"   � � @ �@ � � $��&  & �    
_campaignCheckComponentOpenCheckComponentRed                                          selfcomponentId              @ �@  �   �@ E� $@ & �    ShowDialog$UIActivityTotalLoginAwardController_campaignType                                  selfcomponentId                                    self       componentId      obj         _ENV    L   :   F @ G@� � @ ��@��@ � �@� 䀀AA �� �� $� LB�A ,  dA L�B d� ��B lB  �A �   � ��A��� �A    ��� ��CA �  � � �A � � AB +B� K� �� kB� �� �� �B� ��  �B� �A BE��$B��E��E �� ,�  $B�& �    ECampaignN22ComponentIDECAMPAIGN_N22_LINE_MISSIONECAMPAIGN_N22_FIRST_MEET
_campaignGetComponent_SpawnObject_lineMissionBtn#UIActivityCommonComponentEnterLockSetRedred_GetRoleIdSetNewnewComponentUnLockTime        SetActivityCommonRemainingTime_timePool_lock
time_lockstate_lockstate_unlockstate_closeSetWidgetNameGroupSetData
_campaign         *  -        @ @@ � � �  $� "    � @ �@ � � �  $� &  & �    
_campaignCheckComponentOpenCheckComponentRed           +  +  +  +  +  +  +  ,  ,  ,  ,  ,  ,  -         selfcomponentIdcomponentId2 2  5           @ $� "   ��@� �@ A�  �  ]�� $�    &  & �    ComponentIsOpenLocalDBHasKeyUIActivityN22lineMission            3  3  3  3  3  3  3  3  3  3  3  3  4  5     isNew         
component_ENVroleId E  I           @ �@� ��@$@���  A A@ �  ]�� �� $@���  B $@� & � 	   SwitchStateUIStateType#UIActivityN22LineMissionControllerLocalDBSetIntUIActivityN22lineMission       N22DataSetPrefsMission             F  F  F  F  F  G  G  G  G  G  G  G  H  H  H  I         self_ENVroleId:   !  !  "  "  $  $  $  $  &  &  &  &  (  )  -  (  /  /  0  1  5  0  8  8  8  8  8  8  8  9  9  9  9  9  9  ;  ;  <  <  <  =  =  =  >  >  >  ?  ?  ?  @  @  @  B  C  D  I  B  L     self    :   componentId   :   componentId2   :   
component   :   obj   :   roleId   :   unlockTime   :   tb1   :      _ENV N  y   8   F @ G@� ��@ ��@ � ���� A AA �� � �A $� L��A ,  dA L���� ,B  dA �   � �LCd� bA    �AA ���� D  ���� �A � ��  �A� � AB +B� K� �� kB� �� �� �B� �A ��@ �A��A�G�E �� �  �A�& �    ECampaignN22ComponentID ECAMPAIGN_N22_DIFFICULT_MISSION
_campaignGetComponent_SpawnObject_hardLevelBtn#UIActivityCommonComponentEnterLock_GetRoleIdSetNewnewSetRedredComponentUnLockTime        SetActivityCommonRemainingTime_timePool_lock
time_lockstate_lockstate_unlockstate_closeSetWidgetNameGroupSetData
_campaign         W  Y           @ $� "   ��@� �@ A�  �  ]�� $�    &  & �    ComponentIsOpenLocalDBHasKeyUIActivityN22HardLevel            X  X  X  X  X  X  X  X  X  X  X  X  X  Y         
component_ENVroleId ^  `        @ @@ � � $��"   � � @ �@ � � $��&  & �    
_campaignCheckComponentOpenCheckComponentRed           _  _  _  _  _  _  _  _  _  _  _  `         selfcomponentId t  w        @ @@ $@�  � �@ ��@ � A� �  C  �  �@�$@ & �    N22DataSetPrefsHardSwitchStateUIStateType!UIActivtiyN22HardLevelController             u  u  u  v  v  v  v  v  v  v  v  v  v  w         _ENVself8   O  O  P  P  P  P  R  R  R  R  T  T  U  V  Y  U  \  ]  `  \  c  c  c  c  c  c  c  d  d  d  d  d  d  i  i  j  j  j  k  k  k  l  l  l  m  m  n  o  o  o  q  r  s  w  q  y     self    8   componentId   8   
component   8   obj
   8   roleId   8   unlockTime   8   tb/   8      _ENV {  �   8   F @ G@� ��@ ��@ � ���� A AA �� � �A $� L��A ,  dA L���� ,B  dA �   � �LCd� bA    �AA ���� D  ���� �A � ��  �A� � AB +B� K� �� kB� �� �� �B� �A ��@ �A��A�G�@ �� �  �A�& �    ECampaignN22ComponentIDECAMPAIGN_N22_ENTRUST
_campaignGetComponent_SpawnObject_subjectBtn#UIActivityCommonComponentEnterLock_GetRoleIdSetNewnewSetRedredComponentUnLockTime        SetActivityCommonRemainingTime_timePool_lock
time_lockstate_lockstate_unlockstate_closeSetWidgetNameGroupSetData         �  �           @ %  &   & �    HasNew          �  �  �  �  �         
component �  �          &  & �                �  �  �           �  �           @ $@ & �    _SwitchEntrust           �  �  �  �         self8   |  |  }  }  }  }          �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    8   componentId   8   
component   8   obj
   8   roleId   8   unlockTime   8   tb/   8      _ENV �  �      L @ �@  d����� � �@�� @ �  ���̀@C  �@�� @ A 䀀���� $A�A L�A ��   A �  dA & � 	   GetGameObject
_backBtns
SetActive	_showBtn_uiElementsuieff_UIN22MainController_in2
_PlayAnim_anim�              �  �       & �                �             �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       hideBtn      showBtn	      uiElements      entermodel           �  �      L @ �@  d�����   �@�� @ �  ���̀@C� �@�� @ A 䀀���  $A�& �    GetGameObject
_backBtns
SetActive	_showBtn_uiElements           �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       hideBtn      showBtn	      uiElements           �  �      � @ �@@��  �@ & �    UIActivityHelperShowActivityIntroUIActivityN22MainController            �  �  �  �  �     self       go          _ENV �  �      L @ �@@ ǀ��@ d@ L @ �@@ � �AA d@ & �    AttachEventGameEventTypeActivityCloseEvent_CheckActivityCloseAfterUILayerChanged_RefeshCount            �  �  �  �  �  �  �  �  �  �  �     self          _ENV �  �      L @ �@@ ǀ��@ d@ L @ �@@ � �AA d@ & �    DetachEventGameEventTypeActivityCloseEvent_CheckActivityCloseAfterUILayerChanged_RefeshCount            �  �  �  �  �  �  �  �  �  �  �     self          _ENV �  �      � @ �   ��� @ �@@@ � ���@ �@ A�@�& �    
_campaign_idSwitchStateUIStateTypeUIMain            �  �  �  �  �  �  �  �  �  �  �  �     self       id          _ENV �  �      F @ G@� ��@ d� ��� �� �  & �    GameGlobal
GetModuleRoleModule	GetPstId            �  �  �  �  �  �  �  �     self       roleModule      pstId         _ENV �  �      & �                �     self            �  �   
   L @ �@  �  d� ��@  ����@AF�A ��A �Bd �  A��B�� �A� ��A� ��$A  & �    GetUIComponent	RawImageTitleImg_RawImageGetGameObject	TitleImgGetComponenttypeofUnityEngineMeshRenderer	materialSetTexture	_MainTexGetTexture            �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       	rawImage      obj      meshRender         _ENV �  �      L @ �@  �  d� � A �@A��� ��A�A $ ��  J���� � �� �@B ǀ����FAB G�GA��AB �C��C�� 䀀D �  $A�& �    GetUIComponentH3DUIBlurHelperscreenShotOwnerCameraGameGlobalUIStateManagerGetControllerCameraGetNameRefreshBlurTextureUnityEngineRenderTextureNewScreenwidthheight       
StartTask         �  �      F @ �   d@ F@@ G�� G�� � � �  d@�E �L � �@A ǀ� C� d@�F�A G � d@� & � 	   YIELDUnityEngine	GraphicsBlitSwitchStateUIStateTypeUIN22EntrustStageControllerN22DataSetPrefsEntrust             �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     TT          _ENVrt	cache_rtself   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       screenShot      rt      	cache_rt         _ENV      
   F @ G@� d�� L�� ��@ � �A AAd@ & �    GameGlobalEventDispatcher	DispatchGameEventTypeGuideOpenUIUIActivityN22MainController         
                          self    
      _ENV^                        
                  .      0   J   0   N   f   N   h   �   h   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �     �     
             L     N  y  N  {  �  {  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �                 _ENV