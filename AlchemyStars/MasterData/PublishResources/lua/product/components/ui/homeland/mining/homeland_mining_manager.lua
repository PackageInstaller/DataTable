LuaS �

xV           (w@[@../PublishResources/lua/product/components/ui/homeland/mining/homeland_mining_manager.lua         =    @ A@  ��@ $@�@@  ��@@ l   
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
@ �& �    _classHomelandMiningManagerObjectConstructorInitDisposeRefreshOreInfoResetTimerRefreshPickAxeInfoHavePickAxeCutOre
IsCutting_GetNearestPointGetNearestOreCanCutCutOreProcessOnTaskOverStopDigTaskOnItemUpgradeOnItemChangeCallOresRefreshPlayHitEff           &    K   K   
@ �
���
 ��
���
 
�
�
�B�
�ÆF D L@� d� L�� ��D    d� 
@��F E G@� d�� L�� ��E ����C d@ F D L@� d� L�� �@F    d� 
@ �F E G@� d�� L�� ��E ǀ�F d@ F D L@� d� L�� � G    d� 
@��F E G@� d�� L�� ��E �@��F d@ F D L@� d� L�� ��G    d� 
@ �F E G@� d�� L�� ��E � ��G d@ & � !   _ores_interactCfgID       _beforeDropPeriod�      _afterDropPeriodX      _aniPeriod      _lastCutOreID _currentTaskID_timerEvent_dropNeedCutTimes        _itemUpgradeCallbackGameHelperGetInstanceCreateCallbackOnItemUpgradeGameGlobalEventDispatcherAddCallbackListenerGameEventType_itemChangeCallbackOnItemChangeItemCountChanged_callOresRefreshCallOresRefreshHomelandOreRefresh_refreshOreInfoRefreshOreInfoHomelandRefreshOreInfo         K         
                                                                                                                        !   !   !   !   !   !   !   !   "   "   "   "   "   "   "   "   $   $   $   $   $   $   $   $   %   %   %   %   %   %   %   %   &      self    K      _ENV )   I    E   
@@�
@ ���@ � A�� 
�����@ ��A�� ��A�� 
����@B ��B��B �� 
� �� � �� �@C� ̀�A� 䀀�   @	� GA�N���� (������$��FE �BEd� b  ����E ��E�B�  ���F �B��B  ���BF ̂�@���F�    � �@ G����DG $C�F 
Â'���G $A �G $A & �     
_isActive_homelandClient_interactPointManagerInteractPointManager
_charCtrlCharacterManagerMainCharacterController_homelandModuleGameGlobal
GetModuleHomelandModuleSceneManagerSceneRootTransFindOres        childCount       	GetChild	tonumbernameCfgcfg_homeland_mine_oresHomelandOreNewgameObjectAddBuildInteractPoint_interactCfgIDRefreshOreInfoRefreshPickAxeInfo         E   *   ,   .   .   .   .   0   0   0   0   0   0   2   2   2   2   2   3   3   4   4   4   4   4   6   6   7   7   7   7   7   8   8   8   9   9   9   :   :   ;   ;   ;   <   <   =   =   =   =   >   >   >   >   >   >   >   ?   ?   ?   ?   ?   ?   @   @   7   G   G   H   H   I      self    E   homelandClient    E   sceneManager   E   	oresRoot   E   (for index)   @   (for limit)   @   (for step)   @   i   ?   	oreTrans"   ?   oreID%   ?   oreCfg*   ?   ore7   ?      _ENV K   U    %   F @ G@� d�� L�� ��@ � �AA d@ F @ G@� d�� L�� ��@ ǀ��A d@ F @ G@� d�� L�� ��@ � �AB d@ F @ G@� d�� L�� ��@ ǀ��B d@ L C d@ 
�Æ
 ć& �    GameGlobalEventDispatcherRemoveCallbackListenerGameEventTypeOnItemUpgrade_itemUpgradeCallbackItemCountChanged_itemChangeCallbackHomelandOreRefresh_callOresRefreshHomelandRefreshOreInfo_refreshOreInfoStopDigTask_ores 
_isActive          %   L   L   L   L   L   L   L   L   M   M   M   M   M   M   M   M   N   N   N   N   N   N   N   N   O   O   O   O   O   O   O   O   R   R   S   T   U      self    %      _ENV W   q    	   K   � @ �@@�� ��@,  @  �@ & �    TaskManagerGetInstance
StartTask         [   n    4   F @ G@� d�� L�� ��  d@�F � L@� �   d����� �� �   ���   � � ���� ��@��  ��   A� �� �Ɓ����� ���� C A� � @��"  � �L��� dB��  j��� � ����@ � @ �@@��� � D�  �@�& �    GameGlobalUIStateManagerLock%HomelandMiningManager:RefreshOreInfo_homelandModuleHomelandGetMiningInfoGetSuccm_homeland_infomining_infoinfos       mine_idpairs_oresSetOreServerDataCallOresRefreshUnLock          4   \   \   \   \   \   \   ]   ]   ]   ]   ^   ^   ^   ^   _   `   `   `   `   `   a   a   a   a   a   b   b   b   b   a   e   e   e   e   f   g   g   h   h   h   e   e   k   k   k   m   m   m   m   m   m   n      TT    4   res
   4   oreInfoDic   -   (for index)      (for limit)      (for step)      i      (for generator)!   *   (for state)!   *   (for control)!   *   id"   (   ore"   (   oreInfo#   (      _ENVselforeInfoList	   Y   Z   Z   Z   Z   n   p   Z   q      self    	   oreInfoList   	      _ENV s   }       & �                }      self               �       G @ �@@ ��@��@ �� � AAA �A����   � ���A
� �  �
 B�� @ _@����@B �B � ��   @ ���$A & �    _dropNeedCutTimesGameGlobalGetUIModuleHomelandModuleGetCurrentToolCfg	ToolTypeTT_PICKparam        _ores_lastCutOreIDClearCutTimes            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       lastDropNeedCutTimes      pickAxeCfg	      ore         _ENV �   �       G @ `@��  �C@  C � f  & �    _dropNeedCutTimes                   �   �   �   �   �   �   �      self            �   �    #   � @ �@    �& � � @ �@@�� ƀ@ ����   �& � � � �� �@   ��@A ��A�� � $� AA �@��@ & � ��B � C��� �@C�C @  �� ���
� �& �    
_charCtrlStateHomelandActorStateTypeDashCheckCanCutLogfatalMining ore  id:ID total times max_currentTaskIDGameGlobalTaskManager
StartTaskCutOreProcess         #   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    #   ore    #      _ENV �   �       G @ @�   �C@  C � f  & �    _currentTaskID            �   �   �   �   �   �   �      self            �   �    +   � @ �@    �& � � @ �@�� �@ �@D  � ��  �A��B� �BA� �   � ���$� @ �C  � L�A��d��b  ��"   �LB��d�� @��� �  �@ � �@ ��f & � 
   
_charCtrl	Positionmathhuge       	GetBuildCheckCanCut
IsTriggerGetDistance                 +   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    +   points    +   check    +   charPos   +   nearestDis	   +   nearestPoint
   +   (for index)   )   (for limit)   )   (for step)   )   i   (   point   (   ore   (   	checkRet   (   dis"   (      _ENV �   �       G @ L@� ƀ@ ���d��� A  � C� �� �   � ��@A�  �   � A @� �  � �   � �A�% &    & & �    _interactPointManager
GetPointsInteractPointTypeMining_GetNearestPoint	GetBuild            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       points      point	      point         _ENV �   !   �   � @ �@�� �@    �& � �@$� G@ L��d� ALAd� �AA�� ́A� �� �@���A�G@ L��d� BG@ L���   d� bB  � �
���B �B & � @ C�� �� $B BC�@ $��G@ L��� dB�G@ L��d� �D �BD_����G@ L��dB F�D �� �E dB�G@ LB��� dB�L�E�@ d���F  ��B��BF ��F��F ��C �B���D �� �G �B���G�� �H _�����BH H ���  @ ���$C 
����H� I CIA�	 � ��	  �]�$C J !���CJ �JF�J $� LK��   @�dÀ�CF �C��F �K�C ���� �  @�̃H�C �L�C �CL   ����L MGD�DFDJ G��d�� L���N �D�	�N �N
A ��N ��N�EO�� ǅ�$� G�OdD�@��I �C� LD�d� D�C @ ��P$C �D @� ��P $C�@ C�  $C��B $C 
�& � D   
_charCtrl
TransformGetInteractPosition	Position
Normalize
MagnitudeGetCutRadius�������?NavigateToPos_currentTaskID OnTaskOverSetForbiddenMoveGetPlayerDirectionSetForwardStateHomelandActorStateTypePickSetHoldPickYIELD_aniPeriodSetAnimatorTrigger	WavePickGetOreEffectPosPlayHitEffAudioHelperControllerPlayUISoundAutoReleaseDelayCriAudioIDConstHomelandAudioMining�      _beforeDropPeriodID_lastCutOreID_oresClearCutTimesIncreaseCutTimesLogfatalFelling ore  id: total times:_dropNeedCutTimesGameGlobal
GetModuleHomelandModuleHomelandMiningPlayUISoundAutoReleaseHomelandAudioJumpOutGiftGetSuccIncreaseDropTimes               Cfg	cfg_itemassetidEventDispatcher	DispatchGameEventTypeHomeShowUIBubbleStringTableGetstr_homeland_collect_itemNamecountIconI[Homeland] HomelandMiningManager:CutOreProcess HomelandMining fail, res:
GetResultResetClearTimer_afterDropPeriod         �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �                                                                       	  	  
                                                                                               !     self    �   TT    �   ore    �   player   �   vec   �   normal   �   dis   �   radius   �   target   '   success!   '   forward/   �   transH   �   oreIDW   �   ore]   b   	cutTimesd   �   homelandModules   �   resx   �   
assetListx   �   asset�   �   itemCfg�   �      _ENV #  (      G @ b   � �G @ L@� d@ 
�@�& �    _hitEffectDispose            $  $  $  %  %  %  &  (     self            *  /      G @ b   ��F@@ G�� d�� L�� � @ d@�
 A�& �    _currentTaskIDGameGlobalTaskManager	KillTask             +  +  +  ,  ,  ,  ,  ,  ,  -  /     self          _ENV 1  :      � @ �@@�@ �@    �& � ǀ@�@ �@ �@ �� A �@ & �    Cfgcfg_item_tool_upgrade	ToolTypeTT_PICKRefreshPickAxeInfo            2  2  2  3  3  4  7  7  7  7  7  8  8  :     self       tplID       pickAxeCfg         _ENV <  >      L @ d@ & �    RefreshPickAxeInfo           =  =  >     self            @  \   	   K   � @ �@@�� ��@,  @  �@ & �    TaskManagerGetInstance
StartTask         C  Y   -   F @ b@    �& � F@@ L�� �   d��� @ �@    �& � ��� �� �   ���   �@@ � ��@�ǀ�� � �� �  A� �� �Ɓ� ���� � ����@B�B � @��"  � �L���CdB��  j��& �    
_isActive_homelandModuleHomelandGetMiningInfoGetSuccm_homeland_infomining_infoinfos       mine_idpairs_oresSetRefreshTimenext_refresh_time          -   D  D  D  E  G  G  G  G  H  H  H  I  K  K  K  K  L  M  M  M  M  M  N  N  N  N  N  O  O  O  O  N  R  R  R  R  S  T  T  U  U  U  R  R  Y     TT    -   res   -   oreInfoDic   ,   (for index)       (for limit)       (for step)       i      (for generator)#   ,   (for state)#   ,   (for control)#   ,   id$   *   ore$   *   oreInfo%   *      selforeInfoList_ENV	   A  B  B  B  B  Y  [  B  \     self    	   oreInfoList   	      _ENV ^  j   	3   � @ �@   ��@@ ��@�� ��@ FAA G���� 
� ���A � B�� �@B@� 䀀�   @�@ �B"  @�@ �B�B�  $A�@ �BCAC���  $A @ �B�B�� $A�@ �BCF�C � �A � d� 
A�& �    _hitEffectResourceManagerGetInstanceSyncLoadAsseteff_jy_mine_axe_hit.prefab	LoadTypeGameObject
_charCtrl
TransformFindObj
SetActive
transform
SetParentlocalPositionVector3HP�s�ҿ�I+����t�V�?         3   _  _  _  `  `  `  `  `  `  `  `  `  b  b  b  c  c  c  d  d  d  d  d  d  e  e  e  e  e  f  f  f  f  f  f  f  g  g  g  g  g  h  h  h  h  h  h  h  h  h  j     self    3   root    3   player   3   
effectTra   3      _ENV=                        &      )   I   )   K   U   K   W   q   W   s   }   s      �      �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   !  �   #  (  #  *  /  *  1  :  1  <  >  <  @  \  @  ^  j  ^  j         _ENV