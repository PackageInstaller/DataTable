LuaS �

xV           (w@K@../PublishResources/lua/product/module/match/serial_auto_fight_module.lua         y    @ A@  ��@ $@�@@  ��@@ l   
@��@@ l@  
@ �@@ l�  
@��@@ l�  
@ �@@ l  
@��@@ l@ 
@ �@@ l� 
@��@@ l� 
@ �@@ l  
@�� C l@ 
@���C l� 
@�� D l� 
@�� D l  
@ � D l@ 
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
@ � D l� 
@�� D l  
@ � D l@ 
@�� D l� 
@ � D l� 
@�� D l 	 
@ � D l@	 
@��& � ,   _classSerialAutoFightModuleGameModuleConstructorResetModuleDataResetAutoPickStuffGetApsDataGetJumpDataDisposeSetAutoFightDatasSetSerialAutoFightQuickSetDataSerialAutoFightModuleQuickSetData_CampaignSerialAutoFightModuleQuickSetData_TowerSerialAutoFightModuleCancelSerialAutoFightGetTicketCountGetTicketCountByIndexGetAutoFightDatas_TowerGetMatchType	IsInited
IsRunningGetWinCountGetFightCountGetTotalCountGetRewardList
GetResultGetActivityRewardListGetReturnHelpRewardListGetWaitTimeSetBattleResultComplatedOnUIShowEndWaitForUIShowStartSerialFight_DoAutoFight_CheckRunning_NextFightInBattleResult_CalcRewardsMergeRewardsGetMergedActivityRewardsGetMergedReturnHelpRewardsGetTotalRewards    &       	    
   L @ d@ L@@ d@ L�@ ��@ � �AA d@ & �    ResetModuleDataResetAutoPickStuffAttachEventGameEventType
UIShowEndOnUIShowEnd         
                              	      self    
      _ENV           
@@�
�@�
�@�
���
���
�@�
���
�A�
���K   
@ �K   
@��K   
@ �K   
@��
@D�
@@�
@��K   
@ �& �    _matchType _missionId        _taskId	_running 
_winCount_fightCount_totalCount_battleResultComplated_inited_rewardList_activityRewardList_returnHelpRewardList_waitingUI
_waitTime       _campaignWaitUI_autoDatas_matchResult                                                                                   self                #    	   F@@ L�� d� 
@ �F A L�� d� 
@��& �    	_apStuffSerialAutoPickStuffDataNew
_jumpDataSerialAutoFightJumpData         	   !   !   !   !   "   "   "   "   #      self    	      _ENV %   '       G @ f  & �    	_apStuff           &   &   '      self            )   +       G @ f  & �    
_jumpData           *   *   +      self            -   4       F @ G@� �   d@ G�@ L@� d@ 
�@�G A L@� d@ 
�@�& �    GameModuleDispose	_apStuff 
_jumpData            .   .   .   .   0   0   0   1   2   2   2   3   4      self          _ENV :   B    
   @ $A 
@��
� �
���
@A��A �A$A & �    ResetModuleData_matchType_totalCount_autoDatas_inited	_apStuffSetAutoFight        
   ;   ;   <   =   >   ?   A   A   A   B      self    
   
matchType    
   totalCount    
   	autoData    
        E   Q       L@ dA 
@��
� �
 ��
���
 �G�A L�dA & � 	   ResetModuleData_matchType_totalCount_inited_campaignWaitUI_towerData	_apStuffSetAutoFight           F   F   G   H   I   L   N   P   P   P   Q      self       
matchType       totalCount       campWaitUI       
towerData            T   \       F@ GA���@ d� "   ����� � @ ��� �A @ ����A & �    GameGlobal
GetModuleSerialAutoFightModuleSetSerialAutoFightResetModuleData            V   V   V   V   W   W   X   X   X   X   X   X   X   Z   Z   \      active       
matchType       totalCount       campWaitUI       
towerData       module         _ENV _   b       @ A@@� $� ��@ ��@�    @����A�& �    CampaignConstGetCampaignAutoFightInfoSerialAutoFightModuleQuickSetData            `   `   `   `   a   a   a   a   a   a   a   b      active       campaignType       
matchType       totalCount       campStageUI      campWaitUI         _ENV e   g       � @ �@@�   �@ �@A �  �A  �A���@ & �    SerialAutoFightModuleQuickSetData
MatchType	MT_Tower��     id            f   f   f   f   f   f   f   f   f   f   g      active       id          _ENV i   m       F @ G@� d�� L�� ��@ d@�L A d@ F @ G@� d�� L�� ��A � �d@�& � 	   GameGlobalTaskManager	KillTask_taskIdResetModuleDataEventDispatcher	DispatchGameEventTypeCancelSerialAutoFight            j   j   j   j   j   j   k   k   l   l   l   l   l   l   l   m      self          _ENV q   }       G @ b@  @ �A@  f  G�@ b@  @ �A@  f  G�@ ��@ � AG�� b@  @ ��@  �  �@� �  & �    _inited        _autoDatas_fightCount       ticketCount           r   r   r   s   s   u   u   u   v   v   x   x   x   x   y   y   z   z   |   |   }      self       	autoData              �       � @ �@  @ ��@  �  ��@ �@  @ ��@  �  ��@ �@ �@  @ ��@  �  ��@�  & �    _inited        _autoDatasticketCount           �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       idx       	autoData           �   �       G @ b   @ �G @ G@� f  & �    _towerDataid           �   �   �   �   �   �   �      self            �   �       G @ f  & �    _matchType           �   �   �      self            �   �       G @ f  & �    _inited           �   �   �      self            �   �       G @ f  & �    	_running           �   �   �      self            �   �       G @ f  & �    
_winCount           �   �   �      self            �   �       G @ f  & �    _fightCount           �   �   �      self            �   �       G @ f  & �    _totalCount           �   �   �      self            �   �       G @ f  & �    _rewardList           �   �   �      self            �   �       G @ f  & �    _matchResult           �   �   �      self            �   �       G @ f  & �    _activityRewardList           �   �   �      self            �   �       G @ f  & �    _returnHelpRewardList           �   �   �      self            �   �       G @ f  & �    
_waitTime           �   �   �      self            �   �       
@@�& �    _battleResultComplated           �   �      self            �   �    
   � @ �@��    � �@ $A @ 
A� & �    _waitingUI         
   �   �   �   �   �   �   �   �   �   �      self    
   uiName    
   	uiParams    
   cb   
        �   �       @ 
� @ � "   �A@ @� ��  $A���& �    _waitingUIYIELD�                   �   �   �   �   �   �   �   �   �   �   �   �      self       TT       uiName       	callback          _ENV �         G @ b@    �& � G@@ b     �& � 
���F A G@� d�� L�� �   d��
@��& �    _inited	_running_taskIdGameGlobalTaskManager
StartTask         �      P   F @ �@� ��@�� ��E   L�� �   d@�E   L � �   A l  d@���F @ �@� ��A�� ��E   L�� �   d@�E   L � �   � lA  d@���F @ �@� � B�� ��E   L�� �   d@�E   L � �   A l�  d@���F @ �@� ��B�� ��E   L�� �   d@�E   L � �   �B l�  d@���F @ �@� � C�� @�E   L�� �   d@�E   L � �   AC l d@�& �    _matchType
MatchTypeMT_Mission_DoAutoFightWaitForUIShowUIDiscovery	MT_TowerUITowerLayerControllerMT_ResDungeonUIResDetailControllerMT_Campaign_campaignWaitUI
MT_Season_campaignWaitUI          �   �         @ @@ $�� �@ ��@ � A��  ʀ���   � ��$@ & � 
   GameGlobalEventDispatcher	DispatchGameEventType
FakeInputuiUIDiscoveryinputShowSerialRewardsargs           �   �   �   �   �   �   �   �   �   �   �   �   �          _ENV �   �         @ @@ $�� �@ ��@ � A��  ʀ���   � ��$@ & � 
   GameGlobalEventDispatcher	DispatchGameEventType
FakeInputuiUITowerLayerControllerinputShowSerialRewardsargs           �   �   �   �   �   �   �   �   �   �   �   �   �          _ENV �           @ @@ $�� �@ ��@ � A��  ʀ���   � ��$@ & � 
   GameGlobalEventDispatcher	DispatchGameEventType
FakeInputuiUIResDetailControllerinputShowSerialRewardsargs           �   �   �   �   �   �   �   �   �   �   �   �            _ENV           @ @@ $�� �@ ��@ � A��  �� � ���   � ��$@ & � 
   GameGlobalEventDispatcher	DispatchGameEventType
FakeInputui_campaignWaitUIinputShowSerialRewardsargs             	  	  	  	  
  
  
            	           _ENVself           @ @@ $�� �@ ��@ � A��  �� � ���   � ��$@ & � 
   GameGlobalEventDispatcher	DispatchGameEventType
FakeInputui_campaignWaitUIinputShowSerialRewardsargs                                                _ENVselfP   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �     �                                                                        TT    P      self_ENV   �   �   �   �   �   �   �   �   �   �   �   �   �     �          self          _ENV    Q   f   � @ �@@  �  ���@ �@   ���@ � �  �@���
@A�� @ ��A��A @ �@�� B � �@  ��
@��ƀB ���䀀 � �FAC G����  �ć��Ĉ�  �����@ � @ ̀�
� �� @ 
���& � �  � AA � �
��ƁB ���䁀 ��FBC G��� �A ��@  � A �A��@��@F �@ 
 E���@  � A �@��  � AA � �
��ƁB ���䁀 ��FBC G��� �A ��@  � A �A��@�
 E�� @ ̀�
� �ƀB ���䀀 � �FAC G����  ��Ƈ��ƈ�  �����@ ��& �    _fightCount_totalCount_battleResultComplatedYIELDd               _CalcRewards_CheckRunning	_runningGameGlobalEventDispatcher	DispatchGameEventType
FakeInputuiUIBattleResultCompleteinput
bgOnClickargs       ��������
_waitTimeSerialAutoFightWaitTime�      _NextFightInBattleResultUITeamsbtnFightOnClick         f   !  !  !  !  #  #  #  $  $  $  $  $  &  (  (  )  )  )  +  +  +  +  ,  .  .  .  .  /  /  /  0  0  0  0  .  2  2  2  3  3  4  8  8  8  8  9  :  :  :  :  :  :  :  :  ;  ;  ;  ;  8  >  >  @  A  A  A  A  E  E  E  E  F  G  G  G  G  G  G  G  G  H  H  H  H  E  J  K  K  K  L  L  L  L  M  M  M  N  N  N  N  L  O  Q     self    f   TT    f   count   d   (for index),   ;   (for limit),   ;   (for step),   ;   	waitTime-   :   (for index)E   T   (for limit)E   T   (for step)E   T   	waitTimeF   S      _ENV S  d   	$   � @ �@@ ǀ�� @���@ A ����@A� ��F�A G���B d� �A�������B  ��A  �� #   � �& ��� C �@CǀC `�   ��@  � � �  & �    _matchType
MatchType	MT_Tower
GetModuleGameMatchModuleGetMachResultm_bVictoryGameGlobalTowerModuleGetNextStageCfgm_nID _fightCount       _totalCount         $   T  T  T  T  T  V  V  V  X  X  Y  \  \  \  \  ]  ]  ]  ^  ^  ^  ^  `  `  `  `  `  b  b  b  b  b  b  b  b  d     self    $   count    $   gameMatchModule      matchResult
      
isVictory      towerModule      nextCfg      	haveNext         _ENV f  l      G @ �@@ ��@�� � �A�  b@    �A  �@A ��A��� ��AB ABK�  J�B�JA ��  J����@ & �    _matchType
MatchType	MT_TowerNextFightTeams_ToweragainFightBtnOnClickGameGlobalEventDispatcher	DispatchGameEventType
FakeInputuiUIBattleResultCompleteinputargs            g  g  g  g  g  g  g  g  g  h  h  h  h  i  i  i  j  j  j  j  h  l     self       func	         _ENV n  �   
i   � @ A@ ���̀@� �@ AGAA ���$A���"   ��A B
 ���@ ABG��$�   ��@�C G��$� �F�C G��
B��)�  ���  F�@ G�� ǁ�dA�GAD J� @ �AD 
�� �@ ABG��$�   ��@�C G��$� �F�C G��
B��)�  ���  F�@ G�� ���dA�GE J� @ �E 
��   F�@ G�� �A�dA�F�@ G�� ǁ�dA�F�@ G�� ���dA�F�@ G�� ��dA�F�@ G�� �A�dA�F�@ G��� �  dA�G�F J� @ ��F 
�� & �    
GetModuleGameMatchModuleGetMachResulttableinsert_matchResultm_bVictory
_winCount       countm_activity_rewards        ipairstypeStageAwardType	ActivityappendArray_activityRewardList m_back_rewards_returnHelpRewardListm_vecAwardNormalm_vecAwardPerfectm_vecExtAwardm_vecDoubleExtAwardm_vecFirstPassAwardsort_rewardList         �  �      � @ �@@ǀ@ �� ��@� @ �@��� � ����� ���@ G�� `@  �A  � & `��  �A  � & & �    Cfg	cfg_itemassetidColor            �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     a       b       qa      qb
         _ENVi   p  p  p  r  r  s  s  s  s  s  t  t  t  u  u  u  w  w  w  w  w  w  x  x  x  x  y  y  y  x  x  {  |  |  |  |  |  }  }  }      �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    i   count    i   gameMatchModule   i   matchResult   i   (for generator)      (for state)      (for control)      index      value      activityAwards    '   (for generator)3   9   (for state)3   9   (for control)3   9   index4   7   value4   7   returnAwards:   A   normalAwardsE   e      _ENV �  �   8   G @ �   �   
�����  �@ A�  ��ǁ� �  ��A @�$@�GCAGCbC  � �GCA��A���@�GCA�CA��ǃA�����)�  ��������A   � @�B BB$� 
���
��GB@ �B@ � ��@J�  j��ƀB ���A@ l  �@��@@ �  & �    _rewardList_mergedAwardList       _totalCountipairsassetidcountpairs
RoleAssetNewtablesort         �  �      � @ �@@ǀ@ �� ��@� @ �@��� � ����� ���@ G�� `@  �A  � & `��  �A  � & & �    Cfg	cfg_itemassetidColor            �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     a       b       qa      qb
         _ENV8   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    8   	original   8   map   8   (for index)       (for limit)       (for step)       i      awards	      (for generator)      (for state)      (for control)      i      reward      (for generator)#   0   (for state)#   0   (for control)#   0   id$   .   cnt$   .   asset'   .      _ENV �  �   ;   G @ �   �   
�����  �@ A�  ��ǁ� �  ��A @�$@�GCAGCbC  � �GCA��A���@�GCA�CA��ǃA�����)�  ��������A   �  �B BB$� 
���
��F�B G�
B�GB@ �B@ � ��@J�  j��@C ǀ�A@ l  �@��@@ �  & �    _activityRewardList_mergedActivityRewardList       _totalCountipairsassetidcountpairs
RoleAssetNewtypeStageAwardType	Activitytablesort         �  �      � @ �@@ǀ@ �� ��@� @ �@��� � ����� ���@ G�� `@  �A  � & `��  �A  � & & �    Cfg	cfg_itemassetidColor            �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     a       b       qa      qb
         _ENV;   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    ;   	original   ;   map   ;   (for index)       (for limit)       (for step)       i      awards	      (for generator)      (for state)      (for control)      i      reward      (for generator)#   3   (for state)#   3   (for control)#   3   id$   1   cnt$   1   asset'   1      _ENV �     ;   G @ �   �   
�����  �@ A�  ��ǁ� �  ��A @�$@�GCAGCbC  � �GCA��A���@�GCA�CA��ǃA�����)�  ��������A   �  �B BB$� 
���
��F�B G�
B�GB@ �B@ � ��@J�  j��@C ǀ�A@ l  �@��@@ �  & �    _returnHelpRewardList_mergedReturnHelpRewardList       _totalCountipairsassetidcountpairs
RoleAssetNewtypeStageAwardTypeNormaltablesort                 � @ �@@ǀ@ �� ��@� @ �@��� � ����� ���@ G�� `@  �A  � & `��  �A  � & & �    Cfg	cfg_itemassetidColor                                                                 a       b       qa      qb
         _ENV;   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �                    �  �  �                  	  
  
  
                                   self    ;   	original   ;   map   ;   (for index)       (for limit)       (for step)       i      awards	      (for generator)      (for state)      (for control)      i      reward      (for generator)#   3   (for state)#   3   (for control)#   3   id$   1   cnt$   1   asset'   1      _ENV   <   B   G @ b@    �K   �@@ �@    ��   ǀ@ �@    ��   �@� � ��+A�K  ��@ � �����@   � ��@ @�$��GA
�EA
�E��E   �ƅA  �
@ 䅀J��
�E��A
��� ��E�F�FA����)�  ����  j���  *���B �AB���� �B ǁ�  l  �A�� & �    _rewardList_activityRewardList_returnHelpRewardListpairsassetidcountNewRoleAssettypetabletoArraysort         3  :      � @ �@@ǀ@ �� ��@� @ �@��� � ����� ���@ G�� `@  �A  � & `��  �A  � & & �    Cfg	cfg_itemassetidColor            4  4  4  4  4  5  5  5  5  5  6  6  7  7  7  7  7  7  7  9  9  9  9  9  :     a       b       qa      qb
         _ENVB                               !  !  !  !  !  #  $  $  $  $  %  %  %  %  &  &  &  &  '  (  )  )  )  *  *  *  *  *  +  +  +  +  -  -  -  -  -  &  &  %  %  $  $  2  2  2  2  3  3  3  :  3  ;  <     self    B   normal   B   	activity   B   
returnSys   B   all   B   total   B   (for generator)   7   (for state)   7   (for control)   7   _   5   rewards   5   (for generator)   5   (for state)   5   (for control)   5   __   3   assets   3   (for generator)   3   (for state)   3   (for control)   3   ___   1   asset   1   id   1   count    1   total;   B      _ENVy                        	                   #       %   '   %   )   +   )   -   4   -   :   B   :   E   Q   E   T   \   T   _   b   _   e   g   e   i   m   i   q   }   q      �      �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �     �      Q     S  d  S  f  l  f  n  �  n  �  �  �  �  �  �  �    �    <    <         _ENV