LuaS �

xV           (w@e@../PublishResources/lua/product/components/ui/activity/cn12n41/main/ui_cn12_n41_main_controller.lua         U    @ A@  ��@ $@�@@  ��@@ l   
@��@@ l@  
@ �@A l�  
@ �@A l�  
@��@A l  
@ �@A l@ 
@��@A l� 
@ �@A l� 
@��@A l  
@ �@A l@ 
@��@A l� 
@ �@A l� 
@��@A l  
@ �@A l@ 
@��@A l� 
@ �@A l� 
@��@A l  
@ �@A l@ 
@��@A l� 
@ �@A l� 
@��@A l  
@ �@A l@ 
@��@A l� 
@ �@A l� 
@��@A l  
@ �@A l@ 
@��& �    _classUICN12N41MainControllerUIController_SetCommonTopButton_BackUICN12N41MainController_HideUI_ShowUI_SetRemainingTime_SetBg
_SetSpine
_SetImgRT_CheckGuide
_PlayAnimLoadDataOnEnterOnShowOnHide	_Refresh_UpdateRemainingTime_SetLoginBtn_SetLineBtn_SetHardBtn_HardBtnUnlockLocalDBIntroBtnOnClickShowBtnOnClick_AttachEvents_DetachEvents_AfterUILayerChanged_CheckActivityClose_OnItemChanged                  L @ �@  d��L�� �   d@�l   �@  ��@ � �   AA �� � ���� �� C  � $A�& �    GetGameObject	shareTip
SetActiveUIWidgetHelperSpawnObject
_backBtnsUINewCommonTopButtonSetData            
            @ $@ & �    _Back           	   	   	   
          self                @ $@ & �    _HideUI                              self                     
                                                self       closeCallback      hideCallback      obj         _ENV           L @ d� L@� d� ��@ ��@��  �L A ƀ@ �@�d@�� �L�A �� ,  d@ & �    ManagerCurUIStateTypeUIStateTypeUICN12N41MainControllerSwitchStateUIMain
_PlayAnimout                        @ $@ & �    CloseDialog                              self                                                            self          _ENV    $       L @ �@  ,  d@ & �    
_PlayAnimhide           #            @ �@  $���@ �   $@�    @ ��  $���@ � � $@�    @ �  $���@ �   $@�& �    GetGameObject
_backBtns
SetActive	_showBtn_uiElements                                                            "   "   "   "   "   "   "   #          self         #      $      self            &   -       L @ �@  d��L�� � � d@�L @ ��  d��L�� �   d@�L @ �  d��L�� � � d@�L@A �� ,  d@ & �    GetGameObject
_backBtns
SetActive	_showBtn_uiElements
_PlayAnimshow        *   ,        & �                ,              '   '   '   '   '   '   (   (   (   (   (   (   )   )   )   )   )   )   *   *   ,   *   -      self            /   6       �@ �A@�   � A�  �� ��@@ �A��A@�� ���A�& �    UIWidgetHelperSpawnObjectUIActivityCommonRemainingTimeSetAdvanceTextSetData            1   1   1   1   1   1   3   3   3   5   5   5   5   5   6      self       widgetName       descId       endTime       tickCallback       stopCallback       obj         _ENV 8   A       F @ G@� �   ��  �  d@ F A L@� d� L�� �� B ABd� b   @���B � FB GA��� ��B A �A � ���C� �AD$A & �    UIWidgetHelperSetRawImage_mainBgN41_zjm_bgResourceManagerGetInstanceSyncLoadAssetN41_zjm_tx05.mat	LoadTypeMat	GetAssetGetUIComponent	RawImage
MainTitle	materialSetTexture	_MainTexmainTexture            9   9   9   9   9   9   :   :   :   :   :   :   :   :   ;   ;   <   <   <   <   <   >   >   >   >   ?   ?   ?   ?   ?   A      self       req      srcMat      
mainTitle         _ENV C   O    	,   L @ �@  d��L�� �   d@�L @ ��  d��L�� � � d@�L A �@ �  d� ��� � �@�� B �@B�� ��B� FC GA��� �   @�̀C A� �C �AC� A �� � $� GADL���� �dA & �    GetGameObject_mainBg
SetActive_spineGetUIComponentSpineLoader
LoadSpinen41_kv_1_spine_idleResourceManagerGetInstanceSyncLoadAssetN41_zjm_tx05.mat	LoadTypeMat	GetAsset	RawImage
MainTitle	materialSetTexture	_MainTexmainTexture         ,   D   D   D   D   D   D   E   E   E   E   E   E   F   F   F   F   G   G   G   H   H   H   H   H   H   H   H   I   I   J   J   J   J   J   L   L   L   L   M   M   M   M   M   O      self    ,   obj   ,   req   ,   srcMat"   +   
mainTitle&   +      _ENV Q   Z       _ � ���@@ �  A�  �� �@ �� � �  �   �  & �     GetUIComponent	RawImagerttexture           R   R   T   T   T   T   U   W   W   Y   Y   Z      self       imgRT       rt   	        \   ^    
   F @ G@� d�� L�� ��@ � �A AAd@ & �    GameGlobalEventDispatcher	DispatchGameEventTypeGuideOpenUIUICN12N41MainController         
   ]   ]   ]   ]   ]   ]   ]   ]   ]   ^      self    
      _ENV `   m    
$   �  �  
���
��� ��  
���
���� ���  
A
�� ��  
À
AÁ� ��A�_�C���C D@  �A �A��A�B��@@ $A � �_�C@ �  $A� & �    in	animName!uieff_UICN12N41MainController_in	duration      hide$uieff_UINCN12N41MainController_hide�      show$uieff_UINCN12N41MainController_show�      out"uieff_UICN12N41MainController_outo       UIWidgetHelperPlayAnimation_anim         $   a   b   b   b   b   c   c   c   c   d   d   d   d   e   e   e   e   h   h   h   i   i   i   i   i   i   i   i   i   i   i   j   j   k   k   m      self    $   idx    $   	callback    $   tb   $      _ENV s   �       @ A@$�� K  ��@ �A��   @ �����
����@ �AA � �A���A �B�� 
���AB �B�� ǁA ́�@� � ��B ���A�& �    UICN12N41HelperGetCampaignType
_campaignUIActivityHelperLoadDataOnEnterClearCampaignNew_bp_campaignUIActivityCampaignNewAsyncRequestResLoadCampaignInfoECampaignTypeCAMPAIGN_TYPE_BATTLEPASS            t   t   t   u   y   y   y   y   y   y   y   y   |   |   |   |   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       TT       res       	uiParams       campaignType      componentIds      bp_res         _ENV �   �       � @ �@ �@@ �@ ��@ �@ ��@ �@ � A A �����A  �@���A  l  �@ & � 	   _AttachEvents_SetCommonTopButton
_SetSpine_UpdateRemainingTimeGetGameObjectrt
SetActive
_PlayAnimin        �   �            @ $@    @@ $@ & �    _CheckGuide	_Refresh           �   �   �   �   �   �   �          self   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       	uiParams            �   �       L @ d@ & �    _DetachEvents           �   �   �      self            �   �       F @ G@� �   ��  �@ d@ F @ G � �   �@ �A d@ L�A d@ L B d@ L@B d@ & � 
   UICN12N41HelperSetBattlePassBtn_battlePassBtn_bp_campaignSetExchangeBtn_exchangeBtn
_campaign_SetLoginBtn_SetLineBtn_SetHardBtn            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self          _ENV �   �    +   F @ G@� ��@ d� ��@ � A�@� � π��� ��A � �AB A� 䀀��N�  @����AC � A� � �  ,  �A�& � ��A �B�AB  ����BN�  @�@��AC A� �� � �A�& � & �    GameGlobal
GetModuleSvrTimeModulemathfloorGetServerTime����MbP?UICN12N41HelperGetComponentInfo
_campaignlinem_close_time        _SetRemainingTime_time"str_cn12_n41_shop_close_time_tips	exchange         �   �       E   L � d@ & �    	_Refresh           �   �   �   �      first          self+   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    +   svrTimeModule   +   curTime
   +   lineComponentInfo   +   endTime   +   stamp   +   exchangeItemComponent    +      _ENV �   �       A   �@@ ��@� � �� ��@ � �   AA �� � ,  L���   dA lA  �A�� @��A ��  ���GC � �A & �    loginUICN12N41HelperGetComponentIdUIWidgetHelperSpawnObject
_loginBtnUIActivityCommonComponentEnterSetNewnewSetRedredSetData
_campaign         �   �         @ @@ F�� �  $��&  & �    UICN12N41HelperCalcNew_Component
_campaign             �   �   �   �   �   �   �      new         _ENVselfname �   �         @ @@ F�� �  $��&  & �    UICN12N41HelperCalcRed_Component
_campaign             �   �   �   �   �   �   �      red         _ENVselfname �   �         @ @@ E � ��  $@� @ �@ $�� E  L � �@   @  ��d@ & �    UICN12N41HelperLocalDB_SetNewGetCampaignTypeShowDialog$UIActivityTotalLoginAwardController             �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      campaignType         _ENVnameselfcmptId   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       name      cmptId      obj      newCallback      redCallback      clickCallback         _ENV �      Q   A   �@@ ��@� � �� �@@ ���A @� 䀀AA �A@  �� � $� l  �AB� @��A �A  ��BA � �A �   � ��A�� �A    ��� �    ���$� D"B    �� LBD�� � @ �� dB K �� � �B� ��  �B� � AC +C� K� �� kC� kB ��E ��B���  �  ,�  LF�  �@ dC�FCF G��� ��FGG � � �C�& �    lineUICN12N41HelperGetComponentIdGetComponent
_campaignUIWidgetHelperSpawnObject	_lineBtn*UIActivityCN12N41CommonComponentEnterLockSetNew_newSetRed_redComponentUnLockTime        GetComponentInfom_close_timeSetActivityCommonRemainingTime_time_unlock"str_cn12_n41_shop_close_time_tipsstate_lockstate_unlockstate_closeSetWidgetNameGroupSetLockStateCallbackUIStateTypeUICN12N41LineControllerSetData
_campaign         �   �         @ @@ F�� �  $��&  & �    UICN12N41HelperCalcNew_Component
_campaign             �   �   �   �   �   �   �      new         _ENVselfname �   �         @ @@ F�� �  $��&  & �    UICN12N41HelperCalcRed_Component
_campaign             �   �   �   �   �   �   �      red         _ENVselfname �   �         @ @@ F�@ G�� �  d  $@  & �    ToastManager
ShowToastStringTableGetstr_activity_error_110            �   �   �   �   �   �   �   �          _ENV           @ @@ F�@ G�� �  d  $@  & �    ToastManager
ShowToastStringTableGetstr_activity_error_107                                   _ENV           @ @@ E � ��  $@� @ �@ E � �  $@�@A �A F�AG � � ��    $��F�AG@� L�� � � � @  +A� d@ & �    UICN12N41HelperLocalDB_SetNewLocalDB_Set_CrossDayRedCampaignConstGetSafeStateInfo
_campaign_id_campaign_moduleSwitchState_Safe                       	  	  	  	  	                                       componentMain         _ENVnameselfcmptIdstateQ   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �                                       self    Q   name   Q   cmptId   Q   
component
   Q   obj   Q   newCallback   Q   redCallback   Q   unlockTime!   Q   
closeTime)   Q   tb=   Q   lockWithTimeCallbackA   Q   lockCallbackB   Q   closedCallbackC   Q   stateJ   Q   clickCallbackK   Q      _ENV   g   �   A   �@@ ��@� � �� �@@ ���A @� 䀀AA �A@  �� � $� l  �AB� @��A �A  ��BA � �A �   � ��A�� �A    ��� �C �D $��FBD G����D�� �Ed� �B��� �B    ��� �BCE �EG�E � $��GCF����� ��FG��_��  �CC  C� �GD A� �� ��G ����$� �F���C��H �H@�$� F�H G���	 � d���DI ��D�bC  @ � �� � �� ���I�	 A
 ����   l�  �D @ �b  ��� � E
 A�	 �D  AE
 �� +E K� ��
 kE� �� ��
 �E� �D �K@ 	�D��    ��D�� Ǆ�	�D    ��� �I�� �  �	C  $E ,�  l �E �EL@ 
��
� �E�ƅL ���,� LM�FM   @ dF�& � 6   hardUICN12N41HelperGetComponentIdGetComponent
_campaignUIWidgetHelperSpawnObject	_hardBtn*UIActivityCN12N41CommonComponentEnterLockSetNew_newSetRed_redComponentUnLockTime        
GetModuleSvrTimeModulemathfloorGetServerTime����MbP?UICN12N41HelperGetComponentInfo
_campaignlinem_pass_mission_infom_need_mission_id GetUIComponentUILocalizedTMP_pass_lockCfgcfg_campaign_missionNameStringTableGet"str_cn12_n41_hard_level_lock_tipsSetTextSetActivityCommonRemainingTime_time_lock!str_cn12_n41_line_lock_time_tipsstate_lockstate_unlockstate_closeSetWidgetNameGroupGetComponentInfom_close_time_time_unlock"str_cn12_n41_shop_close_time_tipsSetLockStateCallbackUIStateTypeUICN12N41HardControllerSetData
_campaign                   @ @@ F�� �  $��F @ G@� ��� ��  d���@    �� � �  & �    UICN12N41HelperCalcNew_Component
_campaignblack                                              new      	newblack
         _ENVselfname "  &        @ @@ F�� �  $��F @ G@� ��� ��  d���@    �� � �  & �    UICN12N41HelperCalcRed_Component
_campaignblack             #  #  #  #  #  $  $  $  $  $  %  %  %  %  &     red      	redblack
         _ENVselfname ;  F      F @ � � �@@�� ��@G�� _�� ��E  L � �@ d��L�� � � d@�F��G � �  �@ � A� �  d@ � �E  L � d@ & �    m_pass_mission_infoGetComponentInfom_need_mission_id GetGameObjectstate_lock
SetActiveUIWidgetHelperPlayAnimation_anime)uieff_UINCN12N41MainController_BtnUnlock�      	_Refresh          @  B           @ $@ & �    	_Refresh           A  A  A  B         self   <  <  <  <  <  <  <  <  >  >  >  >  >  >  >  ?  ?  ?  ?  ?  ?  B  ?  B  D  D  D  F     first          lineComponentInfo
componentobj_ENVself Q  S        @ @@ F�@ G�� �  d  $@  & �    ToastManager
ShowToastStringTableGetstr_activity_error_110            R  R  R  R  R  R  R  S         _ENV T  X        @ @@ E � L�� d� G�� @   A F@A G�� �   d� ��A � B�@A ǀ�A @� � ��@  & � 
   Cfgcfg_campaign_missionGetComponentInfom_need_mission_idNameStringTableGetToastManager
ShowToast"str_cn12_n41_hard_level_lock_tips            U  U  U  U  U  U  U  U  V  V  V  V  W  W  W  W  W  W  W  W  X     missionName      lvName         _ENV
component Y  [        @ @@ F�@ G�� �  d  $@  & �    ToastManager
ShowToastStringTableGetstr_activity_error_107            Z  Z  Z  Z  Z  Z  Z  [         _ENV _  e        @ @@ E � ��  $@� @ �@ E � �  $@�@A �A F�AG � � ��    $��F�AG@� L�� � � � @  +A� d@ & �    UICN12N41HelperLocalDB_SetNewLocalDB_Set_CrossDayRedCampaignConstGetSafeStateInfo
_campaign_id_campaign_moduleSwitchState_Safe             `  `  `  `  `  a  a  a  a  a  c  c  c  c  c  c  c  c  d  d  d  d  d  d  d  d  e     componentMain         _ENVnameselfcmptIdstate�                                                 &  '  '  '  '  *  *  *  *  *  *  *  +  +  +  ,  ,  ,  ,  ,  ,  -  -  -  -  -  .  /  /  /  /  /  0  0  0  0  0  0  0  0  0  2  2  2  2  3  3  3  3  3  3  3  4  4  4  4  5  5  5  5  5  6  6  6  7  7  7  7  9  9  :  :  :  :  :  :  F  :  F  G  G  L  L  L  L  L  L  L  L  L  L  L  L  L  L  L  L  M  M  M  N  N  N  N  N  N  N  N  O  O  O  O  O  O  S  X  [  \  \  \  \  \  ^  ^  e  f  f  f  f  f  g     self    �   name   �   cmptId   �   
component
   �   obj   �   newCallback   �   redCallback   �   unlockTime!   �   svrTimeModule$   �   curTime*   �   endTime/   �   stamp0   �   lineComponentInfo5   �   isMissionLock>   �   	passlockB   �   missionNameI   �   lvNameM   �   textR   �   tbv   �   
closeTime�   �   lockWithTimeCallback�   �   lockCallback�   �   closedCallback�   �   state�   �   clickCallback�   �      _ENV j  q      � @ �@@��  �� b   @���@ � �  AA �@� ���@ ǀ�  �  �   & �    UIActivityHelperGetLocalDBKeyWithPstIdHardBtnUnlockLocalDBSetInt       HasKey            k  k  k  k  l  l  m  m  m  m  m  m  o  o  o  o  o  q     self       save       key         _ENV x  z      � @ A  A�  �@ & �    ShowDialogUIIntroLoaderUICN12N41Intro           y  y  y  y  z     self       go            |  ~      L @ d@ & �    _ShowUI           }  }  ~     self            �  �      L @ �@@ ǀ��@ d@ L @ �@@ � �AA d@ L @ �@@ ǀ��A d@ & �    AttachEventGameEventTypeAfterUILayerChanged_AfterUILayerChangedActivityCloseEvent_CheckActivityCloseItemCountChanged_OnItemChanged            �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self          _ENV �  �      L @ �@@ ǀ��@ d@ L @ �@@ � �AA d@ L @ �@@ ǀ��A d@ & �    DetachEventGameEventTypeAfterUILayerChanged_AfterUILayerChangedActivityCloseEvent_CheckActivityCloseItemCountChanged_OnItemChanged            �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self          _ENV �  �      F @ G@� d�� L�� ��@ �  d�  b   @ �� A �@ & �    GameGlobalUIStateManagerIsTopUIGetName	_Refresh            �  �  �  �  �  �  �  �  �  �  �  �     self       topui         _ENV �  �      � @ �   ��� @ �@@@ � ���@ �@ A�@��@A �   ���@A �@@@ � ���@ �@ A�@�& �    
_campaign_idSwitchStateUIStateTypeUIMain_ny_campaign            �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       id          _ENV �  �      � @ �@ & �    	_Refresh           �  �  �     self       id           U                                          $      &   -   &   /   6   /   8   A   8   C   O   C   Q   Z   Q   \   ^   \   `   m   `   s   �   s   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �     �     g    j  q  j  x  z  x  |  ~  |  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �         _ENV