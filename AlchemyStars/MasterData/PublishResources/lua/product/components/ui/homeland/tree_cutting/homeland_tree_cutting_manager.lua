LuaS �

xV           (w@�@E:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/lua/product/components/ui/homeland/tree_cutting/homeland_tree_cutting_manager.lua         :    @ A@  ��@ $@�@@  ��@@ l   
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
@��& �    _classHomelandTreeCuttingManagerObjectConstructorInitDisposeRefreshTreeDropInfoResetTimerRefreshAxeInfoHaveAxeCutTree
IsCuttingCutTreeProcessPlayHitEffPlayDropEff
CheckDropStopCutTaskOnItemUpgradeOnItemChangeRefreshTreeInfoProcess           '    .   K   
@ �
���
 ��
���
 
�
 Å
 Æ
 C�
 ć
 È
 C�F E L@� d� L�� ��E    d� 
@��F F G@� d�� L�� ��F ����D d@ F E L@� d� L�� �@G    d� 
@ �F F G@� d�� L�� ��F ǀ�G d@ & �    _trees_interactCfgID       _takeOutAxePeriod�      _beforeHitPeriod�      _beforeDropPeriod      _afterDropPeriodT      _lastCutTreeID _currentTaskID_timerEvent_dropNeedCutTimes        _hitEffect_dropEffect_itemUpgradeCallbackGameHelperGetInstanceCreateCallbackOnItemUpgradeGameGlobalEventDispatcherAddCallbackListenerGameEventType_itemChangeCallbackOnItemChangeItemCountChanged         .         
                                  "   "   "   "   "   "   "   "   #   #   #   #   #   #   #   #   %   %   %   %   %   %   %   %   &   &   &   &   &   &   &   &   '      self    .      _ENV *   J    C   
@ �� @ ��@�� 
���� @ � A�� �@A�� 
���� @ ��A�� � B�� 
� ��@� �� ̀B� ���A 䀀�   @�A G��N���� (�����$��FBD ��Dd� b  ����D �E�B�  ���BE ̂�@���E�    � C@ F����DF $C��F 
Â'���F $A G $A AG $A & �    _homelandClient_interactPointManagerInteractPointManager
_charCtrlCharacterManagerMainCharacterController	_camCtrlCameraManagerFollowCameraControllerSceneManagerSceneRootTransFindTrees        childCount       	GetChild	tonumbernameCfgcfg_homeland_treeHomelandTreeNewgameObjectAddBuildInteractPoint_interactCfgID_treesRefreshTreeDropInfoResetTimerRefreshAxeInfo         C   ,   .   .   .   .   0   0   0   0   0   0   3   3   3   3   3   3   5   5   6   6   6   6   6   8   8   9   9   9   9   9   :   :   :   ;   ;   ;   <   <   =   =   =   >   >   ?   ?   ?   ?   ?   ?   ?   @   @   @   @   @   @   A   A   9   G   G   H   H   I   I   J      self    C   homelandClient    C   sceneManager   C   
treesRoot   C   (for index)   <   (for limit)   <   (for step)   <   i   ;   
treeTrans"   ;   treeID%   ;   treeCfg*   ;   tree3   ;      _ENV L   \    $   F @ G@� d�� L�� ��@ � �AA d@ F @ G@� d�� L�� ��@ ǀ��A d@ G B b   � �G B L@� d@ G�B b   � �G�B L@� d@ G�B L � d@ 
@ÅL�C d@ 
@Ç& �    GameGlobalEventDispatcherRemoveCallbackListenerGameEventTypeOnItemUpgrade_itemUpgradeCallbackItemCountChanged_itemChangeCallback_hitEffectDispose_dropEffect_timerEventCancel StopCutTask_trees         $   M   M   M   M   M   M   M   M   N   N   N   N   N   N   N   N   P   P   P   Q   Q   Q   T   T   T   U   U   U   X   X   X   Y   Z   Z   [   \      self    $      _ENV ^   p    #   F @ G@� ��@ d� L�� d� � � �@A�   � \ �� (� ���AG��@'��B GAB $@�Gb  � ���B���B�� ���B �B�)�  ���& �    GameGlobal
GetModuleHomelandModuleGetHomelandInfo
fell_infoinfos       tree_idpairs_treesSetDropTimesfell_times                 #   `   `   `   `   `   `   b   b   c   d   d   d   d   e   e   e   e   d   h   h   h   h   i   j   j   k   k   k   k   m   m   m   h   h   p      self    #   homelandInfo   #   treeInfoList   #   treeInfoDic	   #   (for index)      (for limit)      (for step)      i      (for generator)   "   (for state)   "   (for control)   "   id       tree       	treeInfo          _ENV r   �       F @ G@� ��@ d� b@   ���@ � A�@ �@ & � ��� �� ��A� B�@B� @ �@��B � ���� @ AC$�� �C�� �  $� 
 �& �    GameGlobal
GetModuleHomelandModuleLogfatal&HomelandModule is nil, may need loginGetHomelandInfo
fell_infonext_refresh_time�      SvrTimeModuleGetServerTime_timerEventTimer	AddEvent         }            @ @@ $�� �@ ��� � � $@ & �    GameGlobalTaskManager
StartTaskRefreshTreeInfoProcess             ~   ~   ~   ~   ~   ~   ~             _ENVself   t   t   t   t   u   u   v   v   v   v   w   z   z   z   z   z   {   {   {   {   {   {   }   }   }   }   }      }      �      self       homelandModule      nextRefreshTime      now         _ENV �   �       G @ �@@ ��@��@ �� � AAA �A����   � ���A
� �  �
 B�� @ _@����@B �B � ��   @ ���$A & �    _dropNeedCutTimesGameGlobalGetUIModuleHomelandModuleGetCurrentToolCfg	ToolTypeTT_AXEparam        _trees_lastCutTreeIDClearCutTimes            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       lastDropNeedCutTimes      axeCfg	      tree         _ENV �   �       G @ `@��  �C@  C � f  & �    _dropNeedCutTimes                   �   �   �   �   �   �   �      self            �   �       � @ �@@�� ƀ@ ����   �& � �@A ��A��� ��AB @  �� ���
� �& � 	   
_charCtrlStateHomelandActorStateTypeDash_currentTaskIDGameGlobalTaskManager
StartTaskCutTreeProcess            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       tree          _ENV �   �       G @ @�   �C@  C � f  & �    _currentTaskID            �   �   �   �   �   �   �      self            �   �    �   � @� A@ �@$� � ���$� L�d� �AA�� ́A @���΁�́���B@ �@$� ��B@ �A�� ��$� "B  @ �
@B�& � �A@ ́�C� �� �A �@� B@ �@$� ���ÅB@ BC��$B�B@ �C$� F�C G�_@��B@ BD$B �D @� ��D $B�B@ E�B $B��D @� ��E $B��E �F� $B  BF �F$B �F GFBG G��$B �G � $��"  � �H �F� $B  �D @� �BH $B��H$� G�H _ ���GI ��H G��b  @ ��B��B 
 ��L�Id� ��I �J�B
   A�
 ��݂��B ��J !@���K �BKƂK �� ��K@� � ���L�d� b  ��LCIdC LCLdC G�L��L �M�C����K ǃ�䃀 ���FN GD���N ��N	� �N �N
GEO$� G���� ��O�C���F ��DG P�C ��LC�d� ��P ��P_��@�F�I G��C �C�� ��dC @ ���Q�B ��D �� �Q �B��B@ ��B  �B�
@B�& � H   GetInteractPosition
_charCtrl	Position
Normalize
MagnitudeGetCutRadius�������?NavigateToPos_currentTaskID SetForbiddenMovey        SetForwardStateHomelandActorStateTypeAxeSetHoldAxeYIELD_takeOutAxePeriodSetAnimatorTriggerWaveAxe_beforeHitPeriodPlayHitEffGetTreeRootTrans	_camCtrlDoShakeAudioHelperControllerPlayUISoundAutoReleaseCriAudioIDConstHomelandAudioCutTree
CheckDropPlayDropEff_beforeDropPeriodID_lastCutTreeID_treesClearCutTimesIncreaseCutTimesLoginfoFelling tree  id: total times:_dropNeedCutTimesGameGlobal
GetModuleHomelandModuleHomelandFellGetSuccIncreaseDropTimes       Cfg	cfg_itemassetidEventDispatcher	DispatchGameEventTypeHomeShowUIBubbleStringTableGetstr_homeland_collect_itemNamecountIconHomelandAudioJumpOutGift
GetResultHomeLandErrorTypeE_DROP_TIMES_LIMITfatalM[Homeland] HomelandTreeCuttingManager:CutTreeProcess HomelandFell fail, res:ResetClearTimer_afterDropPeriod         �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    �   TT    �   tree    �   vec   �   normal   �   dis
   �   radius   �   target      success      forward*   �   treeID`   �   treef   k   	cutTimesm   �   homelandModule|   �   res�   �   
assetList�   �   asset�   �   itemCfg�   �      _ENV   	      � @ �@   ��@@ ��@�� ��@ FAA G���� 
� �� @ ��A� B  �@�� @ ��A�@B��B � C  �@ � @ ��A� B� �@�& �    _hitEffectResourceManagerGetInstanceSyncLoadAsseteff_jy_log_axe_hit.prefab	LoadTypeGameObjectObj
SetActive
transform
SetParent                                                                      	     self       root          _ENV         � @ �@   ��@@ ��@�� ��@ FAA G���� 
� �� @ ��A� B  �@�� @ ��A�@B��B � C  �@ � @ ��A� B� �@�& �    _dropEffectResourceManagerGetInstanceSyncLoadAsseteff_jy_log_axe_leaf.prefab	LoadTypeGameObjectObj
SetActive
transform
SetParent                                                                           self       root          _ENV   "      � � �� �   @ ��   �  �@� �� ��  �@ � � �� $� �  A�G�A a �  �A  � & & �    ForbiddenCutID        _lastCutTreeIDGetCutTimes       _dropNeedCutTimes                                         !  !  !  !  !  !  !  "     self       tree       treeID      	cutTimes	           $  )      G @ b   ��F@@ G�� d�� L�� � @ d@�
 A�& �    _currentTaskIDGameGlobalTaskManager	KillTask             %  %  %  &  &  &  &  &  &  '  )     self          _ENV +  4      � @ �@@�@ �@    �& � ǀ@�@ �@ �@ �� A �@ & �    Cfgcfg_item_tool_upgrade	ToolTypeTT_AXERefreshAxeInfo            ,  ,  ,  -  -  .  1  1  1  1  1  2  2  4     self       tplID       axeCfg         _ENV 6  8      L @ d@ & �    RefreshAxeInfo           7  7  8     self            :  P   (   � @ �@@ƀ@ �� �@   ���@ � �A �@ & � ̀A@� 䀀�A _ B ��A AB$� "    �& � ��$� "  � ��B $A ���@ AA �A��� ]��$A �C $A & �    GameGlobal
GetModuleHomelandModuleLogfatal&HomelandModule is nil, may need loginHomelandGetFellInfo_timerEvent 	IsCancelGetSuccRefreshTreeDropInfoV[Homeland] HomelandTreeCuttingManager:RefreshTreeInfoProcess get fell info fail, res:
GetResultResetTimer         (   <  <  <  <  =  =  >  >  >  >  ?  B  B  B  E  E  E  E  E  E  E  E  F  I  I  I  I  J  J  J  L  L  L  L  L  L  L  O  O  P     self    (   TT    (   homelandModule   (   res   (      _ENV:                        '      *   J   *   L   \   L   ^   p   ^   r   �   r   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �     	            "    $  )  $  +  4  +  6  8  6  :  P  :  P         _ENV