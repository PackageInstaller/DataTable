LuaS �

xV           (w@�@E:/depot_matchsrpg/matchsrpg/b/1110/client/Assets/../PublishResources/lua/product/components/ui/activity/n21_crisis_contract/level/ui_activity_n21cc_level_detail.lua         F    @ A@  ��@ $@�@@  ��@@ l   
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
@��& �    _classUIActivityN21CCLevelDetailUIControllerLoadDataOnEnterOnShow	OnUpdateOnHideClose
CloseCoroGetCurrentLevel
RefreshUIPlayListEnterAnimPlayEnterAnimCoroRefreshItemListRefreshSelectedScoreRefreshRedAndNewBtnRestrainOnClickBtnEnemyOnClickBtnEventOnClickLevelPanelOnClickLevelSelectPanelOnClickBtnStartBattleOnClickStartBattleBtnCoroBtnClearOnClick           !    6   �@@@���
 �A�
 �
@@�@�
�A�B AB$� 
 �A �B�� � $A A �B$� �C �ABBC$� @��� �B ǁ�䁀 �C��$��
 �
 @�B ADG�@ L��d $�  "   �! ����G�@ L�� d��b    �
 �& �           _levelGroupData       _activityConst       _isNormalUI UIActivityN21CCConstNew	LoadDataGetChallengeComponentUIActivityN21CCLevelGroupsDataGetComponentCfgIdGetEnterBattleLevelIdGetLevelGroupDataByIndex_hardIndexGetHistoryLevelHard	GetIndex        IsHardOpen         6                  
   
                                                                                                                                             !   	   self    6   TT    6   res    6   	uiParams    6   challengeComponent   #   challengeCompInfo   #   levelGroupsData   #   index   #   
hardIndex*   6      _ENV #   H    
z   � @ A@ �@G�@ �@ � @ A@ AGAA �@ ��A � A �� �@BA� 䀀���  �� C  $A �A �A �� $� 
 ��A �A � $� 
 ���A �A �� $� 
 ��E � $��
 ��E �� $��
 ���A �� � $� 
 ��A �� �� $� 
 ��E � $��
 ��E �� $��
 ��AG �G�  $A��A �� �A $� 
 ��A �� �� $� 
 ��A �� �A	 $� 
 ��A �� ��	 $� 
 ��A �� �A
 $� 
 ��A �� ��
 $� 
 ��A �� �A $� 
 ��A �� �� $� 
 ��A �A �� $� 
 �L �L� $A�AM �� $A��M $A & � 7   AttachEventGameEventTypeN21CCRefreshRedAndNewRefreshRedAndNewN21CCRefreshItemListRefreshItemListGetUIComponentUISelectObjectPathTopBtnSpawnObjectUICommonTopButtonSetData_bossIconLoaderRawImageLoader	BossIcon_element1Loader	Element1_element2Loader	Element2_element1GoGetGameObject_element2Go_scoreLabelUILocalizationTextScore_bossNameLabel	BossName
_eventRed	EventRed_levelSelectPanelLevelSelectPanel
SetActive_hardItemListHardItemList_hardTitleLabel
HardTitle_baseScoreLabel
BaseScore_recommendLVrecommendLV_recommendLV2recommendLV2_selectedScoreLabelSelectedScore_affixGroupsAffixGroups_unOpenGroupsUnOpenGroups_anim
AnimationAnimPlayUIActivityN21CCLevelDetail_in
RefreshUIPlayListEnterAnim         +   -            @ $@ & �    Close           ,   ,   ,   -          selfz   $   $   $   $   $   %   %   %   %   %   '   '   '   '   )   )   )   *   -   .   1   *   2   2   2   2   2   3   3   3   3   3   4   4   4   4   4   5   5   5   5   6   6   6   6   7   7   7   7   7   8   8   8   8   8   9   9   9   9   :   :   :   :   ;   ;   ;   ;   <   <   <   <   <   =   =   =   =   =   >   >   >   >   >   ?   ?   ?   ?   ?   @   @   @   @   @   A   A   A   A   A   B   B   B   B   B   C   C   C   C   C   D   D   D   D   D   E   E   E   E   F   F   F   G   G   H      self    z   	uiParams    z   btns   z   backBtn   z      _ENV J   V       � @ �@    �& � �@@ ǀ@ ��� �� 
�����@ � A�@@ �� 
����@@ �@A !��� �
�A��@A 
�����A � BA@ �@�& � 	   
_playAnim_currentVaue_speedmathfloor_targetValue _scoreLabelSetText            K   K   K   L   O   O   O   O   O   P   P   P   P   P   Q   Q   Q   Q   R   S   S   U   U   U   U   V      self       deltaTimeMS          _ENV X   [       L @ �@@ ǀ��@ d@ L @ �@@ � �AA d@ & �    DetachEventGameEventTypeN21CCRefreshItemListRefreshItemListN21CCRefreshRedAndNewRefreshRedAndNew            Y   Y   Y   Y   Y   Z   Z   Z   Z   Z   [      self          _ENV ]   _       F @ G@� d�� L�� ��@    d@ & �    GameGlobalTaskManager
StartTask
CloseCoro            ^   ^   ^   ^   ^   ^   ^   _      self          _ENV a   l        � @ A  �@���@ �   @���@ � A��� �@A�A �A�@�� B �@B� �@���B � �  �@��@C �@ � ���C �C D�@��@D A  �@�& �    Lock%UIActivityN21CCLevelDetail_CloseCoro_isNormalUIGameGlobalEventDispatcher	DispatchGameEventTypeN21CCPlayMainFocusAnim_animPlayUIActivityN21CCLevelDetail_outYIELD�      CloseDialogSwitchStateUIStateTypeUIActivityN21CCMainControllerUnLock             b   b   b   c   c   c   d   d   d   d   d   d   d   e   e   e   e   f   f   f   f   g   g   g   i   i   i   i   k   k   k   l      self        TT           _ENV n       
   G @ L@� d� b@  @ ��   �  �   ��  � A�  ���ǁ� ��$� GA @@ �� �  ����  & �    _levelGroupData
GetLevels       
GetHardId_hardIndex           o   o   o   p   p   q   q   t   u   u   u   u   w   x   x   x   x   x   y   y   u   ~         self       levels      
levelData      (for index)      (for limit)      (for step)      i      level           �   �    �   � @ �� �@    �& � �@@ ̀�L�@d �@  � A� AA �A@�$� "   ��A B�  $A����A B�� $A�AB �@��$A��B$� FAA G��� d� b   �G�B L��  dA���G�B L��� dA�GC L��� dA�GAC L����C� dA  LD dA GAD L��ƁD ��� GBE B� dA  G�E L����E� dA  LFd� �AF�� _��@ ���@��G �A���C  �A�@��G �A���C� �A��G ́�F�D G���� d� ��]���A��  ����G ́�A � ]���A� ���G �A���C  �A��AH �A ́H� �H I�B	 ��$B �H �I$� 
 �
 G�I \��
 (���I �LCJ�Â� @� �  dC '���J$� G�J L��  dB G�J L��d� 
@��A
 �BK � �
 h��GCK G��  ��  ��ƃK ����  ��� ��L JDL$� a�  ��C  �� �C�G� �� ,E  �C g��& � 2   GetCurrentLevel_bossIconLoader
LoadImageGetMonsterBigIconGetElementIcon1stringisnullorempty_element1Go
SetActive_element1LoaderGetElementIcon2_element2Go_element2Loader_bossNameLabelSetTextGetMonsterNameRefreshRedAndNew_hardTitleLabelStringTableGet#str_n20_crisis_contract_hard_title_hardIndex_baseScoreLabelGetBaseScoreGetRecommendAwakenGetRecommendLV         _recommendLVgameObjectstr_pet_config_common_advance_recommendLV2LV.RefreshSelectedScoreGetCommonAffixGroups_affixGroupsSpawnObjects#UIActivityN21CCLevelAffixGroupItem_commonItemsGetAllSpawnList       RefreshGetScoreUnLockAffixGroups_unOpenGroups$UIActivityN21CCLevelAffixUnOpenItem_unOpenItemstablecount_selectedScoreGetUnLockScore         �   �            @ $@ & �    RefreshSelectedScore           �   �   �   �          self �   �            @ $@ & �    RefreshSelectedScore           �   �   �   �          self�   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    �   	playAnim    �   
levelData   �   elementIcon1   �   elementIcon2!   �   recommendAwakenK   �   recommendLVM   �   commonGroupsw   �   (for index)�   �   (for limit)�   �   (for step)�   �   i�   �   item�   �   scoreUnlockGroups�   �   (for index)�   �   (for limit)�   �   (for step)�   �   i�   �   item�   �   isOpen�   �      _ENV �   �       G @ L@� ��  d@�
 ��
���G B L@� d� 
@��G�A �@A R�� 
@ �
���L C �@C    d@ & �    _scoreLabelSetText        
_playAnim_length�      _targetValue_levelGroupDataGetMaxScore_speed_currentVaue
StartTaskPlayEnterAnimCoro           �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self            �   �    	   � @ A  �@���  ��@ � ��  � ���@ �A�A � �A��@���  �@A � ��  � ��AA �A�A � �A��@���A A  �@�& �    Lock-UIActivityN21CCLevelDetail_PlayEnterAnimCoro       _commonItems	PlayAnim_unOpenItemsUnLock           �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   
   self       TT       (for index)      (for limit)      (for step)      i      (for index)      (for limit)      (for step)      i           �   �    	   G @ b   ��A@  � @ �  �@  h �G@ G�����@ �A�g@�A@  � A �  �@  h �GA G�����@ �A�g@�& �    _commonItems       RefreshData_selectedScore_unOpenItems           �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       (for index)      (for limit)      (for step)      i      item
      (for index)      (for limit)      (for step)      i      item           �      G   L @ d� �@� �� ̀� � �  \���  (��A$� A�  � ��  h��G�C��� �  � ������ ��g��'���� $� A�  � ��  h��A�  �� ��  h�GG����� ��� �  \���  (D�ńLEA
d� b   �!� � �L�A
d� �@� �LEB
�  dE�'�gB�g��
� �G�B L�� dA�& �    GetCurrentLevelGetBaseScoreGetCommonAffixGroups       GetAffixDatasIsSelected	GetScroeGetScoreUnLockAffixGroupsGetUnLockScoreSetSelectStatus_selectedScore_selectedScoreLabelSetText        G   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �                                 	  	  
  
  
  
                              
                     self    G   
levelData   G   score   G   commonGroups   G   (for index)	      (for limit)	      (for step)	      i
      affixDatas      (for index)      (for limit)      (for step)      j      
affixData      scoreUnlockGroups   G   (for index)    A   (for limit)    A   (for step)    A   i!   @   (for index)%   @   (for limit)%   @   (for step)%   @   j&   ?   affixGroupData(   ?   unlockScore*   ?   affixDatas,   ?   (for index)/   ?   (for limit)/   ?   (for step)/   ?   j0   >   
affixData1   >                G @ L@� ǀ@ ����  d@  & �    
_eventRed
SetActive_activityConstIsShowEventnRed                            self            $  &      L @ �@  d@�& �    ShowDialogUIRestrainTips           %  %  %  &     self            (  >   3   K   � @ �� �@    �& � �@@ ̀�� ���LAd �  _@�� ���A ��A BAA $A @��B �B@�$� A � � h�F�B GB��� ��dB�gA�� !�A ��A �CA� $A & � D �A ��  $A�& �    GetCurrentLevelUICommonHelperGetInstanceGetOptimalEnemysGetFightId         Logfatal[Enemy] 怪物id列表为空tablecount       insertdebugmonster list is emptyShowDialogUIEnemyTip         3   )  +  +  ,  ,  -  /  /  /  /  /  /  /  0  0  0  0  0  1  1  1  1  1  3  3  3  3  4  4  4  4  5  5  5  5  5  4  9  9  9  :  :  :  :  ;  =  =  =  =  =  >  	   self    3   ids   3   
levelData   3   monsterIDs   3   count   %   (for index)   %   (for limit)   %   (for step)   %   i   $      _ENV @  N   &   G @ L@� d� b   ��F�@ G�� � A �@A�� �  d@  L�A � B �@�d@�& � G @ L�� d� b@  ��F�@ G�� � A �@A�� �  d@  & � L�B d� � C A L�� d �@  & �    _activityConstIsActivityEndToastManager
ShowToastStringTableGetstr_activity_finishedSwitchStateUIStateTypeUIMainIsProgressEnableGetCurrentLevelShowDialogUIActivityN21CCShopGetMissionId         &   A  A  A  A  A  B  B  B  B  B  B  B  C  C  C  C  D  G  G  G  G  G  H  H  H  H  H  H  H  I  L  L  M  M  M  M  M  N     self    &   
levelData    &      _ENV P  d   (   G @ L@� � � d@�G�@ L�� d� _ � � �� � !@A  �& � ��A ��A \� �@ ��A �@B�� ��  A� � �ǁ����� ǂ� ��� CC _ �  ��B  �� ,  $B��@�& �    _levelSelectPanel
SetActive_levelGroupData
GetLevels         _hardItemListSpawnObjectsUIActivityN21CCLevelHardItemGetAllSpawnList       Refresh
GetHardId_hardIndex         [  b      "   ��� @ _�� ���@� ��@��@ � ��  � �@�@ ��   �@A  �@��   ��A�@ & �    _hardIndexUIActivityN21CCConstSetHistoryLevelHard_levelGroupData	GetIndex
RefreshUILevelSelectPanelOnClick             \  \  \  \  \  ]  ]  ]  ]  ]  ]  ]  ^  _  _  _  _  a  a  a  b     success       hardId          self_ENV(   Q  Q  Q  Q  R  R  R  S  S  S  S  S  T  V  V  V  V  V  W  W  W  X  X  X  X  Z  [  [  [  [  [  [  [  [  [  [  b  [  X  d     self    (   levels   (   items   (   (for index)   '   (for limit)   '   (for step)   '   i   &   item   &      _ENV f  h      G @ L@� �   d@�& �    _levelSelectPanel
SetActive           g  g  g  g  h     self            j  q      G @ L@� d� b   ��F�@ G�� � A �@A�� �  d@  L�A � B �@�d@�& � F�B G�� d�� L � �@C    d@ & �    _activityConstIsActivityEndToastManager
ShowToastStringTableGetstr_activity_finishedSwitchStateUIStateTypeUIMainGameGlobalTaskManager
StartTaskStartBattleBtnCoro            k  k  k  k  k  l  l  l  l  l  l  l  m  m  m  m  n  p  p  p  p  p  p  p  q     self          _ENV s  �   �   � @ �@@ǀ@ �@ � @ ��@� A �@��  �@  ��A ��A�� B $� K  "   ��AB�� ��  A� �A�ǂ��$� A� � �� hC�G���� �   �����B	�D�� J�	g�����C ��C�� �DC� �A���!@���́D@� � ��D� �  �����E@� � ��D�  �� ���AE� �  @�ǁA ́�@� � �A ��E ��BF � ��$� G���  �� �A� ���ǃ��LDAd� @@ ���  ����BG@ �CA� �B  ̂G� �G$� K ��D�� �H� DH$� K��� ��  kD�kC ��H�H I@��C �@ �CI��D� �C  ��I  �C�����E ���I � ��BJ$B�& � *   UIActivityN21CCConstSetEnterBattleHardIndex_hardIndexSetEnterBattleLeveId_levelGroupData	GetIndex_activityConstGetChallengeComponentGetCurrentLevelGetAffixGroups       GetAffixDatasIsSelectedGetMissionAffixIdAsyncRequestResNewSetSucc        HandleClearAffixGetMissionIdHandleSelectAffixGetSucc	LoadDataGameGlobal
GetModuleMissionModuleTeamCtxformation_listidInitN21CCTeamsGetRecommendLVGetRecommendAwakenGetCampaignMissionComponentIdGetCampaignMissionParamKeyMapInitTeamOpenerTypeN21CCSaveHistoryScoreShowDialogUITeamsCampaignModuleCheckErrorCode	m_result         �   t  t  t  t  u  u  u  u  u  u  w  w  w  y  y  z  {  {  |  |  }  }  }  }    �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  }  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �      self    �   TT    �   challengeComponent   �   challengeComponentInfo   �   
levelData   �   
affixList   �   affixGroupDatas   +   (for index)   +   (for limit)   +   (for step)   +   i   *   affixGroupData   *   affixDatas   *   (for index)   *   (for limit)   *   (for step)   *   j   )   
affixData    )   res.   �   missiontModuleQ   �   ctxS   �   formationListT   �   teamU   �   (for index)X   b   (for limit)X   b   (for step)X   b   iY   a   
formationZ   a   leveli   �   awakek   �   paramx   �   campaignModule�   �      _ENV �  �   #   L @ d� b   ���@� �� ��   A�  ���ǁ��$� A�  � ��  h� �G��  �C�g�����@A ��A��� ��AB AB�@���B �@ ��B �@ & �    GetCurrentLevelGetAffixGroups       GetAffixDatasSetSelectStatusGameGlobalEventDispatcher	DispatchGameEventTypeN21CCClearAllSelectAffixRefreshSelectedScoreRefreshItemList         #   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    #   
levelData   #   affixGroupDatas      (for index)	      (for limit)	      (for step)	      i
      affixGroupData      affixDatas      (for index)      (for limit)      (for step)      j      
affixData         _ENVF                        !      #   H   #   J   V   J   X   [   X   ]   _   ]   a   l   a   n      n   �   �   �   �   �   �   �   �   �   �   �   �   �     �         $  &  $  (  >  (  @  N  @  P  d  P  f  h  f  j  q  j  s  �  s  �  �  �  �         _ENV