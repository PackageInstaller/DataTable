LuaS �

xV           (w@]@../PublishResources/lua/product/components/ui/season/s8/map/ui_season_main_oval_area_s8.lua         @    @ A@  ��@ $@�@@  ��@@ l   
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
@��& �    _classUISeasonMainOvalAreaS8UICustomWidgetOnShowInitWidgetSetDataOnHide
AddTargetRemoveTargetGetTipByTypeUpdate_LoadPrefab_ReleaseTip_ScreenToOval_OnTipClick_RefreshMainLevelTarget_RefreshDailyLevelTarget_RefreshBoxTarget_RefreshPlayer_RefreshTarget_OnModeChanged_RefreshTask           !    
j   � @ �@ ��@ �� ��@A FAA G��$ ��  
����@@ ��A� B�@@ ����@��B RC��$��
 ��C �CFD $� AD$� 
 ���D �DGAC AFAE L���C�EF���G�EG�Bd� 
@�K  
@��K  
@�F�C G��D d� 
@��G�F L��d� L��d� L�d� 
@��F�C G��d�� L���I �A��� d�  
@��G�F L��d� 
@�L�I dA LJ dA LAJ dA L�J dA L�J dA LK �AK ǁ��I dA LK �AK ���L dA LK �AK �A��L dA LK �AK ����J dA & � 4   InitWidget_rectGetGameObjectGetComponenttypeofUnityEngineRectTransformrectwidthheight_ovalCenterVector2       
_seasonIDGameGlobal
GetModuleSeasonModuleGetCurSeasonIDCfgcfg_season_campaign_client_oval
OvalShapeNewOvalTipPadding       _arrowPool_tips
_uiModuleGetUIModule_cameraSeasonManagerSeasonCameraManagerCamera
_uiCameraUIStateManagerGetControllerCameraUISeasonHelperCurSeasonSceneUI_seasonManager_RefreshMainLevelTarget_RefreshDailyLevelTarget_RefreshBoxTarget_RefreshPlayer_RefreshTaskAttachEventGameEventTypeUISeasonOnLevelDiffChangedOnEventPointProgressChange_RefreshTargetOnSeasonModeChanged_OnModeChangedOnSeasonTaskRefreshed         j                                    	   	   	   
   
   
                                                                                                                                                                                                                                                                                !      self    j   	uiParams    j   width   j   height   j   cfg!   j      _ENV $   '       L@@ ��  �  d� 
@ �& �    _tipsParentGetUIComponent
Transformtips           &   &   &   &   &   '      self            *   +       & �                +      self            -   6       F @ �@@ d @ �����A i�  ���
���F A �@A d @ �����A i�  ���
���& �    ipairs_arrowPoolDispose pairs_tips            .   .   .   .   /   /   .   .   1   2   2   2   2   3   3   2   2   5   6      self       (for generator)      (for state)      (for control)      _      req      (for generator)      (for state)      (for control)      _      tip         _ENV 9   H    	   � @ �@��    ��@@ ǀ��  �@ & � � A � AA �A��A ��,  $��LB��   dA G@ J� & � 	   _tipsLogerrorduplicate target_LoadPrefabUISeasonMainOvalTipS8New
_seasonIDResetTarget         B   D       E   L � �   d@�& �    _OnTipClick           C   C   C   C   D      tip          self   :   :   :   :   ;   ;   ;   ;   <   >   >   ?   ?   @   A   D   ?   F   F   F   F   G   G   H      self       target       type       prefab      tip         _ENV J   T       � @ �@ �@   ��@@ ��@��  �@ & � � @ �@ � A� AA ��$A��A$A @ 
�� & �    _tipsLogerrortarget not foundGetReq_ReleaseTipDelete             K   K   K   K   L   L   L   L   M   O   O   P   P   Q   Q   Q   R   R   S   S   T      self       obj       tip      req         _ENV W   ]    	   � @ �@@ �  �́@� @�  �� ��  *�& �    pairs_tipsType            X   X   X   X   Y   Y   Y   Y   Z   X   X   ]      self       type       (for generator)      (for state)      (for control)      _   	   tip   	      _ENV _   �    W   � @ �@@ � ��ǁ@ ���LAd �  BA �A�AGB ���BB   $�� ǂB ���@�䂀C��@ �CC$��F�C G������d��  �  ��  G�B L���d��bC  @ ��B  ��LCDd� bC  @	�L�DdC ��LCDd� b  @ �L�DdC �B   �G�B L����d����FE �C��C���ǃ������ d� �F �CF�E ǃ� �����   �� �F����$D ��  *A�& �    pairs_tips_cameraWorldToScreenPointTargetWorldPosUnityEngineRectTransformUtility#ScreenPointToLocalPointInRectangle_rect
_uiCamera_ovalCrossPointGetCanShowDistanceorthographicSizeVector2	Distance	IsInside	IsInOvalHideShowVector3xy        QuaternionLookRotationforwardSync         W   `   `   `   `   a   a   a   a   a   b   b   b   c   d   e   g   b   i   j   j   j   j   k   k   k   k   l   l   l   l   l   l   l   m   p   p   p   p   p   p   p   p   q   q   q   q   r   r   s   u   u   u   u   v   v   x   x   y   y   y   y   y   {   {   {   {   {   {   {   {   {   |   |   |   |   |   |   }   }   ~               `   `   �      self    W   dt    W   (for generator)   V   (for state)   V   (for control)   V   _   T   tip   T   
screenPos	   T   res   T   pos   T   canShow   T   	arrowPos   T   	distance   T   dirG   T   lookRotM   T   rotP   T      _ENV �   �    '   G @ \ � @�  �F�@ L�� d� L � �@ �A �Ad� � � �@B̀BG�B �  �@ �@C ǀ��� �� D �@������@C ����� �f   �G @ � @ �  G�� � @ � @ � �� �f  & �    _arrowPool        ResourceManagerGetInstanceSyncLoadAssetUISeasonMainOvalTip.prefab	LoadTypeGameObjectObj
transform
SetParent_tipsParentlocalPositionVector3zerolocalRotationQuaternion	identitylocalScaleone          '   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    '   req      tr      req!   &      _ENV �   �       � � �@ & �    Dispose           �   �   �      self       req            �   �       � @ ��� �  & �    _ovalCenter           �   �   �   �      self       
screenPos            �   �    W   � @ �@@ƀ@ �� ��� � A AA � �̀A� ���� � �FAB G���@������ � A �B ���̀A� ���� � �� �@�L�� d �@  @���� � A �C ���̀A� ���� � �� �@�L�� d �@   ���� � A D ���̀A� ���� � �� �@�L�� d �@  ����� � A AD �@�̀A� ���� � �� �@�L�� d �@  & �    GameGlobalGetUIModuleSeasonModuleTypeUISeasonOvalTipTypePlayerSeasonManagerSeasonCameraManagerSwitchModeSeasonCameraModeFollowMissionSeasonCameraFocusTargetWorldPosBoxDailyTask         W   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    W   tip    W   	uiModule   W      _ENV �   �    c   G @ L@� d� L�� ��@ � �d��� @ �@@�� ��@�@ AA���� � F�A �� d@������ �  @ �� �@ �i�  ���F�A � d@����� �  @ � �@ �i�  ���D  �   � �"A  @ �@�@��@  � �"  @ �@ ���   @�"  ���A��� ��B�AB� ǁ� ��@ �@�@ �@ ��b  @���B C BC����  @�́C@��C �BC�A ����C @��C �BC�A @���B C BC����  � ��D LBDd �A  & �    _seasonManagerSeasonMapManagerGetEventPointsByTypeSeasonEventPointType
MainLevel
MainStoryipairsIsLastMainLevelGroupIsLastStoryGetMissionCfgIDGetTipByTypeUISeasonOvalTipTypeMissionResetTarget
AddTargetRemoveTargetTarget         c   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    c   levelPoints   c   storyPoints   c   level   c   story   c   (for generator)      (for state)      (for control)      _      point      (for generator)   '   (for state)   '   (for control)   '   _   %   point   %   target(   c   tipJ   W   tip\   b      _ENV �   �       L @ �@@ ǀ�d��b   � ���@ � $ �@  �@A ��A�� ��AB AB����   ��ƀB   �  ��B ���B@ ǂ�$B �  j�& �    GetTipByTypeUISeasonOvalTipTypeDailyRemoveTargetTarget_seasonManagerSeasonMapManagerGetEventPointsByTypeSeasonEventPointTypeDailyLevelipairs
AddTarget            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       tip      dailyLevels      (for generator)      (for state)      (for control)      _      point         _ENV �   *   �   G @ L@� d� L�� ��@ � �d��� @ �@@�� ��@�@ AA���� @ �@�� ̀�F�@ G��䀀@ A@$� �@��@ ��A$��FB GA��� � dA�FB GA��� ��dA�FB GA��� � dA�K  ��B �� �@���B� �  @���CC ��C$À"  �
�b  @
�����   �����D� �@��C��  �����DC �D����C   �̃�FDC G�䃀���  @��CE   �����	$� @ 
��FF GE�
@
� �\�M��
J��
@ ��  jD���  *���  �AE �F ����$� FCG G�@ �B �G@ ��$C��  j��ƁB  ����   ����B H@ �� $��LCH��DG AdC  ��H ���CG ��$C �  j��ƁB   �� ��H ��� $C  �  jB�& � %   _seasonManagerSeasonMapManagerGetEventPointsByTypeSeasonEventPointTypeBoxSubBox
MechanismSubMechanismtableappendArrayipairsCurProgressExpressContainExpressSeasonExpressTypeShowidGetIDshowGetExpressesSign	FunctionpairsContenttypeSeasonExpressTimingBefore       _tipsTypeUISeasonOvalTipTypeinsert        removeResetTarget
AddTargetRemoveTargetTarget         �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �                                                                         
                      �   �                                                                    !  !  !  !  !  !  #  #  #  #  #      '  '  '  '  (  (  (  (  '  '  *  &   self    �   
boxPoints   �   subBoxPoints   �   trapPoints   �   subTrapPoints   �   boxTargets,   �   (for generator)/   h   (for state)/   h   (for control)/   h   _0   f   point0   f   curProgressExpress2   f   result8   f   content8   f   
expressesK   f   (for generator)W   f   (for state)W   f   (for control)W   f   _X   d   expressX   d   	signType\   d   tipsi   �   (for generator)l   z   (for state)l   z   (for control)l   z   _m   x   tipm   x   (for generator)}   �   (for state)}   �   (for control)}   �   _~   �   target~   �   tip�   �   (for generator)�   �   (for state)�   �   (for control)�   �   _�   �   tip�   �      _ENV ,  3      L @ �@@ ǀ�d��b   @���� A AA$� �A$� FA@ G���@  ���A A AA$� �A$� FA@ G���@ & �    GetTipByTypeUISeasonOvalTipTypePlayerResetTarget_seasonManagerSeasonPlayerManager
GetPlayer
AddTarget            -  -  -  -  .  .  /  /  /  /  /  /  /  /  /  /  1  1  1  1  1  1  1  1  1  3     self       tip         _ENV 5  9      L @ d@ L@@ d@ L�@ d@ & �    _RefreshMainLevelTarget_RefreshBoxTarget_RefreshTask           6  6  7  7  8  8  9     self            ;  A      L @ d@ L@@ d@ L�@ d@ L�@ d@ L A d@ & �    _RefreshMainLevelTarget_RefreshDailyLevelTarget_RefreshBoxTarget_RefreshPlayer_RefreshTask           <  <  =  =  >  >  ?  ?  @  @  A     self            C  i   ]   K   � @ �@@ � ��́@� �@ A � ��AA ǁ� � @ �A���  *��� @ � � � � ���A LBd �A  ��  *A��@B ��B�� ��BC A����   ���@C   �  ���$� "   �L�C�D �B�db  �	��   	�ǂD�   �ǂD��$�  � ��E�  @��BEFD G��䂀�  ��@ @�$@�L�Ed� ��GF�DF ��F	��@���F  �F�@ G�
�D @ �)�  ����  j�& �    pairs_tipsTypeUISeasonOvalTipTypeTasktableinsertRemoveTargetTarget_seasonManagerSeasonMapManagerGetEventPointsByTypeSeasonEventPointTypeipairsCurProgressExpressContainExpressSeasonExpressTypeShowidGetIDshowGetExpressesSignContenttypeSeasonExpressTimingBefore
AddTarget         ]   D  E  E  E  E  F  F  F  F  F  F  G  G  G  G  G  E  E  J  J  J  J  K  K  K  K  J  J  N  N  N  N  N  N  N  O  O  P  P  P  P  Q  Q  R  R  S  S  S  S  T  T  T  T  U  U  U  U  U  U  U  U  V  V  V  W  W  W  W  X  X  Y  Y  Y  Y  Z  Z  Z  \  ]  ]  ]  ]  ^  ^  ^  ^  ^  ^  Y  Y  P  P  i     self    ]   oldTips   ]   (for generator)      (for state)      (for control)      _      tip      (for generator)      (for state)      (for control)      _      tip      tasks#   ]   (for generator)(   \   (for state)(   \   (for control)(   \   _)   Z   point)   Z   curProgressExpress+   Z   result1   Z   content1   Z   
expressesD   Z   (for generator)I   Z   (for state)I   Z   (for control)I   Z   _J   X   expressJ   X   	signTypeN   X      _ENV@                        !      $   '   $   *   +   *   -   6   -   9   H   9   J   T   J   W   ]   W   _   �   _   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   *  �   ,  3  ,  5  9  5  ;  A  ;  C  i  C  i         _ENV