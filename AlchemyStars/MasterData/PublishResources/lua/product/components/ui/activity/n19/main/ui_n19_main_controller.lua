LuaS �

xV           (w@�@E:/depot_matchsrpg/matchsrpg/b/1120/client/Assets/../PublishResources/lua/product/components/ui/activity/n19/main/ui_n19_main_controller.lua         I    @ A@  ��@ $@�@@  ��@@ l   
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
@��& �    _classUIN19MainControllerUIController_SetRemainingTime_SetCommonTopButton_Back_HideUI_ShowUI_SetBg
_SetSpine
_SetImgRT_CheckGuideUIN19MainControllerLoadDataOnEnterOnShowOnHideDestroy	_Refresh_UpdateTime_SetBattlePassBtn_SetLineLevelBtn_SetMiniGameBtnShowBtnOnClick_AttachEvents_DetachEvents_CheckActivityClose                  �@ �A@�   � A�  �� b  @ ���@�A �AAB �  � �A�́A@��A���A@ �  �  �A�& �    UIWidgetHelperSpawnObjectUIActivityCommonRemainingTimeSetCustomTimeStr_Common_1SetExtraTexttxtDescSetAdvanceTextSetData                        @ $@ & �    _UpdateTime                              self   	   	   	   	   	   	                                                            self       widgetName       extraId       descId       endTime       customTimeStr       obj         _ENV    ,    	   F @ G@� �   ��  �  d� � � ,  D� �  ,B  �@�& �    UIWidgetHelperSpawnObject
_backBtnsUICommonTopButtonSetData         "   $            @ $@ & �    _Back           #   #   #   $          self (   *            @ $@ & �    _HideUI           )   )   )   *          self                           !   $   %   '   *   !   ,      self       obj         _ENV /   1       L @ �@@ ǀ�d@�& �    SwitchStateUIStateTypeUIMain            0   0   0   0   1      self          _ENV 4   @    +   L @ �@  d��L�� �   d@�L @ ��  d��L�� � � d@�F A G@� �   �� � A �  d@ G@B b   ��F A G@� �@B �� � A �  d@ G�B b   ��F A G@� ��B ��  A �  d@ & �    GetGameObject
_backBtns
SetActive	_showBtnUIWidgetHelperPlayAnimation_animeff_UIN19MainController_out�      _lineLevelBtneff_UIN19LineLevelBtn_out_miniGameBtneff_UIN19MiniGameBtn_out         +   5   5   5   5   5   5   6   6   6   6   6   6   9   9   9   9   9   9   9   9   :   :   :   ;   ;   ;   ;   ;   ;   ;   ;   =   =   =   >   >   >   >   >   >   >   >   @      self    +      _ENV C   O    +   L @ �@  d��L�� � � d@�L @ ��  d��L�� �   d@�F A G@� �   �� � A �  d@ G@B b   ��F A G@� �@B �� � A �  d@ G�B b   ��F A G@� ��B ��  A �  d@ & �    GetGameObject
_backBtns
SetActive	_showBtnUIWidgetHelperPlayAnimation_animeff_UIN19MainController_in2�      _lineLevelBtneff_UIN19LineLevelBtn_in_miniGameBtneff_UIN19MiniGameBtn_in         +   D   D   D   D   D   D   E   E   E   E   E   E   H   H   H   H   H   H   H   H   I   I   I   J   J   J   J   J   J   J   J   L   L   L   M   M   M   M   M   M   M   M   O      self    +      _ENV R   W       F @ G@� ��@ ��  d��b   @�� A �@A�   � @� �@ & �    UIActivityHelperGetCampaignMainBg
_campaign       UIWidgetHelperSetRawImage_mainBg            S   S   S   S   S   T   T   U   U   U   U   U   U   W      self       url         _ENV Z   ]       L @ �@  �  d� ���  �@�& �    GetUIComponentSpineLoader_spine
LoadSpinen19_kv_2_spine_idle           [   [   [   [   \   \   \   ]      self       obj           `   i       _ � ���@@ �  A�  �� �@ �� � �  �   �  & �     GetUIComponent	RawImagerttexture           a   a   c   c   c   c   d   f   f   h   h   i      self       imgRT       rt   	        l   n    
   F @ G@� d�� L�� ��@ � �A AAd@ & �    GameGlobalEventDispatcher	DispatchGameEventTypeGuideOpenUIUIN19MainController         
   m   m   m   m   m   m   m   m   m   n      self    
      _ENV u   �    2   A@ �@
 �A AA$� 
 ���@ �A�� � @ F�A G���A �BB��A ǂ�$A �   @��B$� "A  @��@ C�AC�� $A�& � �@ �C�� $A�A AA$� 
 ��D AA$� G�C L����   FB@ GB�dA�& �    _campaignTypeECampaignTypeCAMPAIGN_TYPE_N19_COMMON
_campaignUIActivityCampaignNewLoadCampaignInfoECampaignN19CommonComponentIDHARD_LEVELCOMMON_LEVEL	PANGOLINGetSuccCheckErrorCode	m_resultClearCampaignNew_bp_campaignAsyncRequestResCAMPAIGN_TYPE_BATTLEPASS         2   v   v   v   z   z   z   z   {   {   |   }   ~         �   �   �   �   {   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    2   TT    2   res    2   	uiParams    2   bp_res*   2      _ENV �   �       � @ �@ 
�����@ �@ � A �@ �@A �@ ��A �@ ��A �@ � B �@B�   � A� � �  �@ & �    _AttachEvents_isOpen_SetBg_SetCommonTopButton
_SetSpine_UpdateTime	_RefreshUIWidgetHelperPlayAnimation_animeff_UIN19MainController_in�               �   �            @ $@ & �    _CheckGuide           �   �   �   �          self   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       	uiParams          _ENV �   �       L @ d@ 
���& �    _DetachEvents_isOpen            �   �   �   �      self            �   �       F@@ G�� � @ d� 
@ �& �    
_bpMatReqUIWidgetHelperDisposeLocalizedTMPMaterial            �   �   �   �   �   �      self          _ENV �   �       L @ �@@ d@�L�@ d@ L�@ d@ & �    _SetBattlePassBtn_bp_campaign_SetLineLevelBtn_SetMiniGameBtn           �   �   �   �   �   �   �   �      self            �   �       F @ G@� ��@ d� ��@ � A�@� � π��� ��A � �� �@� � ���B �� � B @��� $A�& �    GameGlobal
GetModuleSvrTimeModulemathfloorGetServerTime����MbP?
_campaign
GetSample	end_time_SetRemainingTime_remainingTimePoolstr_n19_main_remaining_time            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       svrTimeModule      curTime
      stop         _ENV �   �    
   �   � � � �   @�A@ �@@  ��  � $� LAA��   dA FA@ G��� � B G�A d��
@��B ��B $��LC��dA�& �    CheckCampaignOpenUIWidgetHelperSpawnObject_battlePassBtnUIActivityCommonCampaignEnterSetData
_bpMatReqSetLocalizedTMPMaterial
_txtTitle uieff_uin19_main_battlepass.matGetGameObjectwidgetName
SetActive            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       bp_campaign       useStateUI      open_sample      obj      obj         _ENV �      
)   F @ G@� ��@ ��@ � ���� A �@�   A� �� � ��A �  $A  K �� �� kA �� �� �A� ��  �A� � AB +B� +A L��� dA�L��ǁ@  � lB  dA�
� �& �    ECampaignN19CommonComponentIDCOMMON_LEVEL
_campaignGetComponentUIWidgetHelperSpawnObject_lineLevelBtn#UIActivityCommonComponentEnterLockSetRed_redstate_lock
time_lockstate_unlockstate_closeSetWidgetNameGroupSetData         �   �            @ %  &   & �    HaveRedPoint          �   �   �   �   �          
component           @ @@ �@ � � ��� � ��� AAD  �@ ��A$@�& �    
_campaign_campaign_moduleCampaignSwitchStateUIStateTypeUIN19LineMissionControllerUIMain_id                   	  
  
                       self_ENV)   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �                                  self    )   componentId   )   
component   )   obj   )   tb   )      _ENV   B   :   F @ G@� ��@ ��@ � ���� A �@�   A� �� � ��A �  $A ���� �A  $A �   � �C$� "A    �A L����  @ �� dA K � �A � �A �� B �A� � A� +B� K� � kB� kA �A� ��A�����@ @� ��  �A�
� �& �    ECampaignN19CommonComponentID	PANGOLIN
_campaignGetComponentUIWidgetHelperSpawnObject_miniGameBtn#UIActivityCommonComponentEnterLockSetNew_newSetRed_redComponentUnLockTime        SetActivityCommonRemainingTime_timePool_lock str_n19_minigame_remaining_timestate_lock
time_lockstate_unlockstate_closeSetWidgetNameGroupSetData           "           @ �@  ��  $� E   L�� �@  d��_ A @ �` ��� �`��   ��@  � � �  & �    NewTaskRedN19TaskCompredGetPrefsComponentNew                                                !  !  !  !  !  !  !  !  !  "     new      comNew	         
component '  )           @ %  &   & �    HaveRedPoint          (  (  (  (  )         
component ;  >           @ �@  ��  �@ E� $@ & �    ShowDialog$UIHomelandStoryTaskSimpleController       _campaignType           =  =  =  =  =  =  =  >         selfcomponentId:                               "    %  &  )  %  -  -  -  -  -  -  -  .  .  .  .  .  .  0  0  1  1  1  1  2  2  2  3  3  3  4  4  5  6  6  6  8  9  :  >  8  A  B     self    :   componentId   :   
component   :   obj   :   unlockTime   :   tb0   :      _ENV I  K      � @ �@ & �    _ShowUI           J  J  K     self       go            Q  T      L @ �@@ ǀ��@ d@ L @ �@@ � �AA d@ & �    AttachEventGameEventTypeActivityCloseEvent_CheckActivityCloseAfterUILayerChanged	_Refresh            R  R  R  R  R  S  S  S  S  S  T     self          _ENV V  Y      L @ �@@ ǀ��@ d@ L @ �@@ � �AA d@ & �    DetachEventGameEventTypeActivityCloseEvent_CheckActivityCloseAfterUILayerChanged	_Refresh            W  W  W  W  W  X  X  X  X  X  Y     self          _ENV [  _      � @ �   ��� @ �@@@ � ���@ �@ A�@�& �    
_campaign_idSwitchStateUIStateTypeUIMain            \  \  \  \  \  \  \  ]  ]  ]  ]  _     self       id          _ENVI                                 ,      /   1   /   4   @   4   C   O   C   R   W   R   Z   ]   Z   `   i   `   l   n   l   u   �   u   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �     �     B    I  K  I  Q  T  Q  V  Y  V  [  _  [  _         _ENV