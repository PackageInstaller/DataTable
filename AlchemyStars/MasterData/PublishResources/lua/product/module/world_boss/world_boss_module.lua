LuaS �

xV           (w@I@../PublishResources/lua/product/module/world_boss/world_boss_module.lua         ^    @ A@  ��@ $@�@@  ��@@ l   
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
@��@@ l@ 
@ �@@ l� 
@��@@ l� 
@ �@@ l  
@��@@ l@ 
@ �@@ l� 
@��@@ l� 
@ �@@ l  
@��& �     _classWorldBossModuleGameModuleConstructorSetBossLevelDifficultyIndexGetBossLevelDifficultyIndexInitSetCurSelectTeamIndexGetCurSelectTeamIndexGetRecordByTeamIndexReqWorldBossData SetPlayerWorldBossFormationInfo ReqWorldBossChangeFormationInfoReqResetRecordReqGetDanInfoReqChoseRecordModule_ConvertMatchResultTeamMemberChangeHandleWorldBossRefreshCheckPetInRecordTeamCurSeasonEndGetWorldBossRedPointGetWorldBossRankDamageList CheckGetWorldBossRankDamageListSetUiOldDanGetUiOldDanAwardMultiOpenGetAwardMultipleGetWorldBossRankTopNGetRankOneDetailNeedRequestRankQuestHaveRedPoint                  
@@�
@@�
 ��
@��
�A�
@@�
@��K�  J ÅJ Æ
@ �K   
@ �G�C J ćG�C J ĈG�C J D�
 ��& �    m_world_boss_data m_dan_infom_cur_team_index       m_rank_damage_listrank_max_show�       m_cur_rank_topNm_last_rank_topNm_rank_stampboss_mission_id        time_stamp_uiRecordDanoldDan��������oldRankoldMissionId_bossLevelDifficultyIndex              	   
                                                            self            !   #       
@ �& �    _bossLevelDifficultyIndex           "   #      self       index            %   '       G @ f  & �    _bossLevelDifficultyIndex           &   &   '      self            )   +       G @ L@� ƀ@ �@ @  d@�& �    callerRegisterPushHandler!CEventMobilePushWorldBossRefreshHandleWorldBossRefresh            *   *   *   *   *   *   +      self          _ENV ,   .       
@ �& �    m_cur_team_index           -   .      self       index            /   1       G @ f  & �    m_cur_team_index           0   0   1      self            3   ?       � @ �@  @ ��   �  � @ �@@��@�   ������ A � @ �@�ǀ�� � ��AA��   �� ��  *A��   �  & �    m_world_boss_dataformation_infoformation_list        pairsid            4   4   4   5   5   7   7   7   7   7   7   8   8   8   8   8   8   9   9   9   :   8   8   >   >   ?      self       index       (for generator)      (for state)      (for control)      key      value         _ENV @   S    	*   � @ �@@�� ƀ@ ���� � �FAA 䀀�A �� ��$� G�A�B �AB_�� �L�B��B ��dA��  GAC�����B ����@��A�
����D� �A�� ���B���A�� �A���& �    AsyncRequestResNewNetMessageFactoryGetInstanceCreateMessageCEventApplyWorldBossInfoReqCallresCallResultTypeNormal
SetResultWorldBossErrorTypeE_WORLDBOSS_ERROR_UNLOCKmsgnRetE_WORLDBOSS_ERROR_TYPE_SUCCESSm_world_boss_dataDataSetSucc         *   A   A   A   C   C   C   C   C   C   E   E   E   E   F   F   F   F   F   G   G   G   G   H   K   L   L   L   L   L   M   M   N   N   N   N   P   P   P   R   R   R   S      self    *   TT    *   	AsyncRes   *   request	   *   reply   *   replyEvent   *      _ENV V   X       � @ �@@�@ �& �    m_world_boss_dataformation_info	pet_list           W   W   W   X      self       	pet_list            ^   w    
3   � @ �@�� �@ ����A �AA$A��  �A �A$� B�AB $��G�B 
A�
� �LAC ��   d� �����C ��_� ����A BA�A��  �A�ǁDA �D ����E @ �A��A�C� �A�� ����G�D�A��  & �    AsyncRequestResNew 
SetResultWorldBossErrorType#E_WORLDBOSS_FORMATION_DATA_INVALIDNetMessageFactoryGetInstanceCreateMessage'CEventApplyChangeWorldBossFormationReqnIdm_cur_team_indexformation_pet_listCallresCallResultTypeNormalmsgnFormationRetE_WORLDBOSS_ERROR_TYPE_SUCCESS SetPlayerWorldBossFormationInfoSetSucc         3   _   _   _   a   a   b   b   b   b   c   f   f   f   f   f   f   g   g   h   i   i   i   i   j   j   j   j   j   k   k   k   k   l   o   p   p   p   p   p   q   q   q   r   r   r   r   t   t   t   v   w      self    3   TT    3   formation_pet_list    3   	AsyncRes   3   request   3   reply   3   replyEvent"   3      _ENV {   �    B   � @ �@�� �@ �@$� A�AA $��
� �L�A ��   d� ���AB ǁ�_� ����C BC�A��  �����CC D ����AD D  �A��� �D EBE A� �����D ���B���"  @����E� @��E F@�� $C�  ����A�C� �A�� ����G�C�A��  & �    AsyncRequestResNewNetMessageFactoryGetInstanceCreateMessageCEventResetRecordReqnIdCallresCallResultTypeNormal
SetResultWorldBossErrorType#E_WORLDBOSS_FORMATION_DATA_INVALIDmsgnRetE_WORLDBOSS_ERROR_TYPE_SUCCESS SetPlayerWorldBossFormationInfo       m_world_boss_dataformation_infoformation_listidtableremoveSetSucc         B   |   |   |   ~   ~   ~   ~   ~   ~      �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    B   TT    B   nId    B   	AsyncRes   B   request	   B   reply   B   replyEvent   B   (for index)'   9   (for limit)'   9   (for step)'   9   i(   8   formation_list+   8      _ENV �   �    	(   � @ �@@�� ƀ@ ���� � �FAA 䀀�A �� ��$� G�A�B �AB_�� �L�B��B ��dA��  GAC�����B ����@��A�
����D� �A�� ���B���A��  & �    AsyncRequestResNewNetMessageFactoryGetInstanceCreateMessageCEventGetDanInfoReqCallresCallResultTypeNormal
SetResultWorldBossErrorTypeE_WORLDBOSS_DAN_INVALIDmsgnRetE_WORLDBOSS_ERROR_TYPE_SUCCESSm_dan_info	dan_infoSetSucc         (   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    (   TT    (   	AsyncRes   (   request	   (   reply   (   replyEvent   (      _ENV �   �    =   F@ LA�d� ��@ ��@�� �ABA ����� ������B @� � � B�F�B G��_@ ���BC ��C$B�f ��GD�BC �BD�� ��   ��F�D ��D �E�BEd�����������D �E�CE���D ������Ã�i�  ��L��� dB�� �L��DdB�f & �    AsyncRequestResNewNetMessageFactoryGetInstanceCreateMessageCEventChoseRecordReqselect_newnIdCallresCallResultTypeNormal
SetResultWorldBossErrorType#E_WORLDBOSS_FORMATION_DATA_INVALIDmsgnRetE_WORLDBOSS_ERROR_TYPE_SUCCESSpairsm_world_boss_dataformation_infoformation_listid	pet_listSetSucc         =   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    =   TT    =   bSelectNew    =   nId    =   damage    =   	AsyncRes   =   request	   =   reply   =   replyEvent   =   (for generator)&   4   (for state)&   4   (for control)&   4   key'   2   value'   2      _ENV �   �       � @ �@@�� ��@ � ��� �ǀ� ����� � �����@B ǀ��� � ��    �C ACG��$� � ���  & �    UI_MatchResultNewm_nMatchType
MatchTypeMT_WorldBossm_nIDmission_id	m_damagetotal_damageCfgcfg_world_boss_missionm_stShowNameStringTableGetMissionName            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       recvResult       uiMatchResult      cfg         _ENV �   �    L   L @ �@@ d����� �� ��@� � �LAAd �  �A ��A � $�  K  "  ��� �A  ��	�����B�  ������B ���������B����B  � �����BJB� �����BJC�BC�B�  ���BC�B ������BC�B����B  � ��BC�BJB� ��BC�BJC�����C ���� �  C@ ��� � ��  *B��  � & �    
GetModuleMissionModuleTeamCtxTeamsGetGetCurrTeamIdGetRecordByTeamIndexGetCurSelectTeamIndex              pets               	pet_listpairs         L   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    L   missionModule   L   teamsContext   L   newTeam   L   record   L   pets   L   (for index)   ?   (for limit)   ?   (for step)   ?   i   >   (for generator)B   I   (for state)B   I   (for control)B   I   keyC   G   valueC   G      _ENV �   �    
   
@@�
@@���@ � A��� �@A�A �A�@�& �    m_cur_rank_topN m_last_rank_topNGameGlobalEventDispatcher	DispatchGameEventTypeWorldBossDanResult         
   �   �   �   �   �   �   �   �   �   �      self    
   msg    
      _ENV �      !   �   ! �   ��  �@@ ǀ����� � � � �� A A@ �@�@�  �BA G��_@ ��A BGB��� $��"  @ �� � @ ��  j��  & � 
           m_world_boss_dataformation_infoformation_listpairsm_cur_team_indexidtable
icontains	pet_list         !   �   �   �                                                                   self    !   pstid    !   	inRecord   !   (for generator)      (for state)      (for control)      key      value         _ENV         G @ b   @�L@@ ƀ@ d��� @ ��@� � � �@��� a�A  ��@  � � �  C � f  & �    m_world_boss_data
GetModuleSvrTimeModule	end_timeGetServerTime����MbP?                                                               self       svrTimeModule         _ENV      
   G @ b@  � �F@@ L�� d� 
@ �G @ f  & �    _worldBossRedPointUIWorldBossRedPointNew         
                          self    
      _ENV   0   	+   � @ �@@�� ƀ@ ���� � �FAA 䀀�A �� ��$� G�A�B �AB_�� �L�B��B ��dA��  GAC�����B �������A�
�����
���E� �A�� �
@E���B���A��  & �    AsyncRequestResNewNetMessageFactoryGetInstanceCreateMessageCEventGetRankDamageListReqCallresCallResultTypeNormal
SetResultWorldBossErrorTypeE_WORLDBOSS_ERROR_TYPE_FAILUREmsgnRetE_WORLDBOSS_ERROR_TYPE_SUCCESSm_rank_damage_listdamage_listrank_max_showrank_max_numSetSucc�                +                                 !  !  !  !  !  "  "  "  "  #  &  '  '  '  '  '  (  (  )  )  *  *  *  *  ,  -  -  -  /  0     self    +   TT    +   	AsyncRes   +   request	   +   reply   +   replyEvent   +      _ENV 2  G   
(   �   �@@ F�@ 䀀��$� C  �A �A  @ �C� ���AA ��A�A ����  �  �C� b  @���A  � ����B� �    �
 �� ���AB ��B�� ��BC� �A�� & �    `�      
GetModuleSvrTimeModuleGetServerTime_getRankDamageListTimemathabsGetWorldBossRankDamageListGetSuccAsyncRequestResNewSetSucc         (   3  4  4  4  5  5  6  7  7  7  8  8  9  9  9  9  9  9  9  :  <  <  =  =  =  >  >  >  >  ?  A  A  C  C  C  D  D  D  E  G     self    (   TT    (   sendDeltaTimeMs   (   svrTimeModule   (   curTime   (   	bSendMsg   (   getListRes      	AsyncRes#   '      _ENV I  M      @ 
A��@ 
� �@ 
���& �    _uiRecordDanoldDanoldRankoldMissionId           J  J  K  K  L  L  M     self       dan       rank       
missionId            N  T      � @ �@@�� @�� @ ��@� @ ���� �� ��  �  � �& �    _uiRecordDanoldMissionIdoldDanoldRank��������           O  O  O  O  P  P  P  P  P  P  R  R  R  T     self       curMissionId            V  X      L @ d�  @��� �L�@ d� [ � @ �C@  C � f  & �    GetAwardMultiple       CurSeasonEnd           W  W  W  W  W  W  W  W  W  W  W  X     self            Z  c      G @ b   � �G @ G@� !�� @ �A�  f  F�@ G � � @ �@@G�� b   @ ��@� �  ��  �  & �    m_world_boss_databoss_mission_id        Cfgcfg_world_boss_missionAwardMulti            [  [  [  [  [  [  [  \  \  ^  ^  ^  ^  ^  _  _  `  `  b  b  c     self       cfg         _ENV e  �   <   � @ �@�䀀 ̀�F�@ 䀀�$� GAA ��A ��AJ��GAA J�FAB L��d� ��B �C�� �AC�C ��������D @� � � B�F�D G��_@ ���BE ��E$B�f ��GF�BE �BF�����   � �G�F
@�@ �G�F
@�LB��� dB�� �L��FdB�f & �    GameGlobal
GameLogic
GetModuleSvrTimeModuleGetServerTimem_rank_stampboss_mission_idm_world_boss_datatime_stampAsyncRequestResNewNetMessageFactoryGetInstanceCreateMessageCEventGetRankTopNReqis_cur_rankCallresCallResultTypeNormal
SetResultWorldBossErrorTypeE_WORLDBOSS_ERROR_TYPE_FAILUREmsgnRetE_WORLDBOSS_ERROR_TYPE_SUCCESSm_cur_rank_topN
show_listm_last_rank_topNSetSucc         <   f  f  f  f  f  f  g  g  i  i  i  i  j  j  l  l  l  n  n  n  n  n  n  o  p  p  p  p  q  q  q  q  q  r  r  r  r  s  v  w  w  w  w  w  x  x  y  y  y  {  {  }  }  }  }        �  �  	   self    <   TT    <   is_cur_rank    <   timeMod   <   
tmNowTime   <   	AsyncRes   <   request   <   reply   <   replyEvent'   <      _ENV �  �   
)   � @ �@�� �@ �@$� A�AA $��
� �L�A ��   d� ���AB ǁ�_� ����C BC�A��  �����CC D �� ��A�C� �A�� ����G�C�A����D��& �    AsyncRequestResNewNetMessageFactoryGetInstanceCreateMessageCEventRankOneDetailReqpstidCallresCallResultTypeNormal
SetResultWorldBossErrorTypeE_WORLDBOSS_ERROR_TYPE_FAILUREmsgnRetE_WORLDBOSS_ERROR_TYPE_SUCCESSSetSuccdetail_info         )   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    )   TT    )   pstid    )   	AsyncRes   )   request	   )   reply   )   replyEvent   )      _ENV �  �   /   G @ @� � �C � � � f �G @ G�� ��@ ��@_�� � �C � � � f �F A G@� d�� L�� ��A d��� � �� ��@ �@��� !� ���� � �B _@@  �A  � � �� C _@�  ��@  � � �B _@@  �A  � � �& �    m_world_boss_data boss_mission_idm_rank_stampGameGlobal
GameLogic
GetModuleSvrTimeModuleGetServerTimetime_stampx�      m_last_rank_topNm_cur_rank_topN         /   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    /   timeMod   /   
tmNowTime   /      _ENV �  �   -   C   � @ �@@ƀ@ ���ǀ�  _ � �GA�_ �@ �A�@ �K   �L�A ��A d���B � �@��B�@ 䂀  _ �� �L��d�  �_ A��G�B�C �CC��@ �C � @ ���  *��f  & �    m_world_boss_databoss_mission_idCfgcfg_world_boss_mission 
QuestList
GetModuleQuestModulepairs	GetQuest
QuestInfostatusQuestStatusQUEST_Completed         -   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    -   haveRedPoint   -   
idMission   -   cfg_mission   -   
QuestList   -   questModule   -   (for generator)   +   (for state)   +   (for control)   +   k   )   v   )   quest   )   qinfo   )      _ENV^                              !   #   !   %   '   %   )   +   )   ,   .   ,   /   1   /   3   ?   3   @   S   @   V   X   V   ^   w   ^   {   �   {   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �     �                 0    2  G  2  I  M  I  N  T  N  V  X  V  Z  c  Z  e  �  e  �  �  �  �  �  �  �  �  �  �         _ENV