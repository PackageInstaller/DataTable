LuaS �

xV           (w@P@../PublishResources/lua/product/components/ui/season/main/ui_season_module.lua         �    @ A@  ��@ $@�@@  ��@@ l   
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
@��@@ l@ 
@ �@@ l� 
@��@@ l� 
@ �@@ l  
@�� 	 F@@ �@ J���F@@ �� J� �F@@ �� J���F@@ � 	 J� �F@@ �@	 J���F@@ ��	 J� �F@@ ��	 J���F@@ � 
 J� �F@@ �@
 J���F@@ ��
 J� �F@@ ��
 J���F@@ �  J� �F@@ �@ J���F@@ �� J� �F@@ �� J���F@@ �  J� �F@@ �@ J���F@@ �� J� �F@@ �� J���F@@ �  J� �F@@ �@ J���F@@ �� J� �F@@ �� J���& � <   _classUISeasonModule	UIModuleConstructorDisposeEnterSeasonGameExitSeasonGameExitSeasonToSeasonMainExitSeasonToSeasonBackTrackGetEnterSeasonParam_SnapNormalSeasonDataGetSnapNormalSeasonData_InitBackTrackDataGetTrackPermanentMissonCfgsGetTrackEventpointStatusUpdateBackTrackEventpointDataOnTrackEventpointDataChgedBackToCurSeasonUpdateSeasonManagerInSeasaonRunningIsBackTrackBackTrackIDClearBackTrackGetSeasonIDGetLatestSeasonIDEnterSeasonSystemUIOpenSeasonThemeUIEnterCurrentSeasonMainUIEnterExchangeShopSeasonTabGetCurrentSeasonLevelDiffSetCurrentSeasonLevelDiffGetCollageDataGetCurrentSeasonNewGetCurrentSeasonRedUISeasonMainEnterGetSeasonNewSetSeasonNewGetGoBtnKeyGetSeasonRedAppendWaitShowBubbleCallback!EraseFirstWaitShowBubbleCallbackClearWaitShowBubbleCallbacksGetWaitShowBubbleCallbacksSetTalentTreeLineSelectMissionGetTalentTreeLineSelectMissionGetTalentTreeSkillClientTagSetTalentTreeSkillClientTagGetTalentTreeTreeClientTagSetTalentTreeTreeClientTagSaveFinishLineMissionListGetSaveFinishLineMissionListSavePassLineMissionListGetSavePassLineMissionListSetTalentTreeBattleOutGetTalentTreeBattleOutSetDefaultDialog_AfterSceneUIShowGetCurOnceMissionUI    8              F@@ L�� d� 
@ �
 ��K�  ��A � BJ� ���A ��BJ���
@��L�B � C �@��C d@ & �    _seasonManagerSeasonManagerNew_backTrackID _seaonMainMapC      UIStateType	UIS3MainD      	UIS4MainAttachEventGameEventTypeAfterSeasonSceneUIShow_AfterSceneUIShow                           	                                             self          _ENV           G @ G@� �   d@ G�@ b   � �G�@ L@� d@ 
 A�
���
���& �    superDispose	_running_seasonManager _backTrackID _talentBattleOut                                                        self               #       � @ �@ �@@ ��@��@ �� � A�� �@@ ǀ��A � ����  @ � �A ���
���ǀB ���@ �� �@ ǀB � ��@ 
�Æ& �    ClearWaitShowBubbleCallbacksGameGlobal
GetModuleSeasonModuleGetCurSeasonID_levelDiffKeyRoleModule	GetPstId_
LevelDiff_seasonManagerInit
AfterInit	_running                                                                                            !   !   !   "   #      self       params       curSeasonID         _ENV %   -       � � _ �   ��   �@@ ̀�@ �@�
 ��
@A�& �     _seasonManagerDispose_levelDiffKey	_running            &   '   '   (   *   *   *   *   +   ,   -      self       isBackTrack       isExit           /   6       � @ �@ �@  @��@@ ǀ��  @� �@�& � � A @� �@�& �    _seaonMainMapLogerror/UISeasonModule can't find uiState by seasonId ExitSeasonToSeasonMain            0   0   1   1   2   2   2   2   2   3   5   5   5   6      self       	seasonId       state         _ENV :   A       � @ �@  ���@@ ��@��  A AA$� �@  & � ��A ��A��� � BAB �B�@���A ��B��� � CAC �CA� �� �@�& �    	_runningLogerror赛季已经退出debug
tracebackGameGlobalEventDispatcher	DispatchGameEventTypeSeasonLeaveToMainLoadingManagerStartLoadingLoadingHandlerNameSeason_ExitUI            ;   ;   ;   <   <   <   <   <   <   <   =   ?   ?   ?   ?   ?   ?   ?   @   @   @   @   @   @   @   @   @   A      self       
exitParam          _ENV E   S       
� � @����ǀ@ �@  @ ���@ �@ 
@ �� A C� �@��@A ǀ��@��    ���"  @�B $A AB �B$�� �B�C �AC���$A & �    _enterSeaonParam        _backTrackID_SnapNormalSeasonDataExitSeasonGameCfgcfg_season_mapMapRes_InitBackTrackDataGameGlobalLoadingManagerStartLoadingLoadingHandlerNameSeason_Enter            F   G   G   H   H   H   I   I   K   L   L   L   M   M   M   N   N   N   N   N   O   O   P   P   P   P   P   P   P   P   S      self       backTrackID       param       cfg         _ENV U   W       G @ f  & �    _enterSeaonParam           V   V   W      self            Z   c       F @ G@� ��  d@ K   
@��G A L@� d� L�� d� �   ��A  � �  �B BB@ ��$B��  j���@ ʀ �& �    Loginfo正常赛季快照数据....._snapNormSeasonData_seasonManagerSeasonMapManagerUnlockZoneIDspairstableinsertUnlockZoneIds            [   [   [   [   \   \   ]   ]   ]   ]   ]   ^   _   _   _   _   `   `   `   `   `   _   _   b   b   c      self       unlockZones      
snapZones      (for generator)      (for state)      (for control)      _      zoneID         _ENV e   g       � @ �@ �  & �    _snapNormSeasonData           f   f   f   g      self       key            j   z    
'   K   
@ �K   
@��K   
@ �F�@ G � �@  ǀA ����d� b   @���A � � � ���@ Bʁ�A@ BGBBbB    �A� �A��B�  � �ǁ@ Bʁ��  *A�� C �@ & �    _allTrackEventMissionCfgs_allTrackEventPointStatus_allTrackPermanentMissionCfgsCfgcfg_season_missionBackTrackID_backTrackIDpairsIDBackTrackProgress       BackTrackPermanentUpdateBackTrackEventpointData         '   k   k   l   l   m   m   o   o   o   o   o   o   p   p   q   q   q   q   r   r   r   s   s   s   s   s   s   s   t   t   t   u   u   u   q   q   y   y   z      self    '   cfgs   '   (for generator)   $   (for state)   $   (for control)   $   _   "   cfg   "      _ENV }          G @ f  & �    _allTrackPermanentMissionCfgs           ~   ~         self            �   �       G @ f  & �    _allTrackEventPointStatus           �   �   �      self            �   �       F @ G@� d�� L�� ��@ d��� � �@AƀA   � ����G��BB ��  @ ��BB �B�  jA�& � 
   GameGlobal
GameLogic
GetModuleSeasonTaskModuleclient_quest_progress_infoeventpoint_infopairs	event_idstatus_allTrackEventPointStatus            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   
   self       taskModule      pInfo      (for generator)      (for state)      (for control)      k      v      id      status         _ENV �   �       b   � �� @ �@    �& � � @ �@� �� � �& �    _allTrackEventPointStatus	event_idstatus           �   �   �   �   �   �   �   �   �   �   �      self       einfo            �   �    	   � @ �@ �@@ � �@���@  � �@�& �    ClearBackTrackExitSeasonGameEnterCurrentSeasonMainUI        	   �   �   �   �   �   �   �   �   �      self    	   param    	        �   �       � @ �   ���@@ ��@�@ A$� AA$ �@  & �    	_running_seasonManagerUpdateGameGlobalGetInstanceGetDeltaTime            �   �   �   �   �   �   �   �   �   �   �   �      self       curTick          _ENV �   �       G @ f  & �    _seasonManager           �   �   �      self            �   �       G @ f  & �    	_running           �   �   �      self            �   �       G @ @�   �C@  C � f  & �    _backTrackID            �   �   �   �   �   �   �      self            �   �       G @ f  & �    _backTrackID           �   �   �      self            �   �       
@@�& �    _backTrackID            �   �      self            �   �       G @ b   � �G @ f  @�L@@ ƀ@ d��L�� e  f   & �    _backTrackID
GetModuleSeasonModuleGetCurSeasonID            �   �   �   �   �   �   �   �   �   �   �   �   �      self          _ENV �   �    
   A   �@@ ƀ@ � @���@ �� � @ 䁀@ ���  *��f  & �    ��������pairsUISeasonIDmathmax            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       id      (for generator)      (for state)      (for control)      _      value         _ENV �   �       L @ �@@ d����� �@ A����   ���@A ��A��� ��AB AB�@�@���B ��B�� � C,  �@�& �    
GetModuleSeasonModuleCheckExtMaskESeasonExtInfoSeasonFirstPlotReadStateGameGlobalUIStateManagerSwitchStateUIStateTypeUISeasonExploreMainControllerTaskManagerGetInstance
StartTask         �   �       E   L � �@� ǀ�d���   ��@   @� �@ � � �@A��A��A� � �@�䀀 ̀�A� � �  �@�& �    AppendExtMaskDataESeasonExtInfoSeasonFirstPlotReadStateReqCEventSeasonStoryCfgcfg_globalseason_system_first_plot	IntValueGameGlobalUIStateManagerShowDialogUIStoryController         �   �         @ @@ $�� �@ ��@ � A$@�& �    GameGlobalUIStateManagerSwitchStateUIStateTypeUISeasonExploreMainController           �   �   �   �   �   �   �   �          _ENV   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      TT       mask      plotId         seasonModule_ENV   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       seasonModule         _ENV �   �      F @ G@� �   d@  & �    UISeasonHelperShowCurSeasonMainController            �   �   �   �   �      self          _ENV �   �    
1   
@ ��@@ �@ �����@� A A@FAA $� �A$� �A�   @�L�� d��b    � �FAB G���� d� �C �AC���A & � F�C G���D�� G��b  ���A��  ���A ��D��� ��DE BEGB��A & �    _enterSeaonParam
GetModuleSeasonModuleGetCurSeasonSampleGameGlobalSvrTimeModuleGetServerTime����MbP?IsShowStringTableGetstr_activity_error_109ToastManager
ShowToastCfgcfg_season_mapGetCurSeasonIDMapResLoadingManagerStartLoadingLoadingHandlerNameSeason_Enter         1   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    1   param    1   seasonModule   1   sample   1   svrTime   1   tips      cfg#   1      _ENV         F @ G@� d�� L�� ��   FAA G����A �Bd@ & � 	   GameGlobalUIStateManagerShowDialogUIShopController       ShopMainTabTypeSecretMarketTypeShop_Season                                       self          _ENV   	      F @ G@� ��@ ��@ � �e �f   & �    LocalDBGetInt_levelDiffKeyUISeasonLevelDiffHard                          	     self          _ENV         � @ �@@ǀ@  � �@���@ � A � �@��@A ��A��� ��AB AB@� �@ & � 
   LocalDBSetInt_levelDiffKey_seasonManagerSwitchDiffGameGlobalEventDispatcher	DispatchGameEventTypeUISeasonOnLevelDiffChanged                                                   self       diff          _ENV      &   G @ b@  ��F@@ L�� ��@ � �AA � ̀��  d�  
@ � �F�@ G � �@A d� L�� d� � @ ��A�� _�� @��@@ ��@�@ AFAA $� �A$ ��  
� �G @ f  & �    _seasonCollageDataUISeasonCollageDataNewGameGlobal
GetModuleSeasonModuleGetCurSeasonIDGetSeasonID         &                                                                                  self    &   	seasonID   #      _ENV %  '      L @ e  f   & �    GetSeasonNew           &  &  &  '     self            )  +      L @ e  f   & �    GetSeasonRed           *  *  *  +     self            .  W   I   C   � @ A@ �����@�� � @ F�@ 䀀� �� �@��    ��A��$��"  ���A B@ $� "A  ��ABF�B G���B d� ���� ��   @ �A�BC �C@��� $���C  �C � b@  ���A D@ $� "    �C � b@  ���A AD@ $� "    �C � b@  ���A �D@ $� "    �C � f  & �    
GetModuleSeasonModuleGetCurSeasonSampleSvrTimeModuleGetServerTime����MbP?IsShowUISeasonHelperIsMissionCptClosedidGameGlobalRoleModule	GetPstIdLocalDBGetInt        TalentTreeNewTradeGameNewSeasonMazeNew          I   /  0  0  0  0  0  1  1  1  1  1  1  2  2  2  2  2  2  2  3  3  3  3  3  3  4  5  5  5  5  6  6  7  7  7  7  8  8  8  8  8  9  9  :  =  =  >  >  >  >  ?  ?  @  C  C  D  D  D  D  E  E  F  O  O  P  P  P  P  Q  Q  R  V  W     self    I   new   I   sample   I   svrTime   I   	seasonid   ,   roleModule   ,   pstid    ,   key$   ,   val)   ,   
talentNew2   5   	TradeNew;   >   seasonMazeNewD   G      _ENVMainEnterKey Y  c   
#   L @ �@@ d��L�� d� � @ �@ ���� A�� �@Ab    �̀� @ 䀀�   ����� B @FAB $� L�Bd� �� �� ����B ��  AB �A�& �    
GetModuleSeasonModuleGetCurSeasonSampleSvrTimeModuleGetServerTime����MbP?IsShowidGameGlobalRoleModule	GetPstIdLocalDBSetInt                 #   Z  Z  Z  Z  Z  [  [  [  [  [  [  \  \  \  \  \  \  \  ]  ^  ^  ^  ^  _  _  `  `  `  `  a  a  a  a  a  c     self    #   sample   #   svrTime   #   	seasonid   "   roleModule   "   pstid   "   key   "      _ENVMainEnterKey e  l      A   �@@ �� �     �@  � � �  � ��  & �            GetSeasonID	GoBtnKey           f  g  g  h  h  i  k  k  k  k  l     self       	seasonid      curid           n  �   h   C   � @ A@ �����@�� � @ F�@ 䀀� �� �@��   ���A��$��"  ���A�B �AB$��@  b@  �
��B �B@ $� "A  @	�C ACL�C d� �� $��FD LA�� d���  ƁD ��B@ � ��$� "  ��FE GB�G�b  �����ƂD ���E � �� $��  ��  ��� c �  �@  b@   ��D �F$�� @��F $��G$� @  b@   ��B AG@ $� @  b@   ��B �G@ $� @  b@   ��B �G@ $� @  f  & �     
GetModuleSeasonModuleGetCurSeasonSampleSvrTimeModuleGetServerTime����MbP?IsShowGetStepStatusECampaignStep!CAMPAIGN_STEP_SEASONQUEST_REWARDUISeasonHelperIsMissionCptClosedUISeasonLocalDBHelperSeasonBtn_GetGetGoBtnKeyRedHelperProxyIsCrossDayToGameGlobalGetCurSeasonIDCfgcfg_season_campaign_clientItemIDItemModuleGetItemCount        
GameLogicSeasonTaskModuleTaskListRedTalentTreeRedTradeGameRedSeasonMazeRed         h   o  p  p  p  p  p  q  q  q  q  q  q  r  r  r  r  r  r  r  s  s  s  s  s  v  v  w  w  w  w  w  w  y  y  y  y  y  y  z  z  z  z  |  }  }  }  }  ~  ~      �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    h   red   h   sample   h   svrTime   h   	lastTime&   F   mapRed*   F   itemRed+   F   seasonModule/   F   	seasonid1   F   cfg6   C   itemid9   C   itemModule=   C   
itemCount@   C      _ENV �  �      � @ �@  @ ��   
� ��@@ ��@� @  � �@�& �    _waitShowBubbleCallbackstableinsert            �  �  �  �  �  �  �  �  �  �  �     self       	callback          _ENV �  �      G @ b@  @ �K   
@ �F@@ G�� � @ ��  d@�& �    _waitShowBubbleCallbackstableremove                   �  �  �  �  �  �  �  �  �  �  �     self          _ENV �  �      K   
@ �& �    _waitShowBubbleCallbacks           �  �  �     self            �  �      G @ f  & �    _waitShowBubbleCallbacks           �  �  �     self            �  �      
@ �
���& �    _talentTreeLineSelectMissionID_info_cur_id           �  �  �     self       id       info_cur_id            �  �      G @ �@@ f �& �    _talentTreeLineSelectMissionID_info_cur_id           �  �  �  �     self            �  �      G @ f  & �    _talentTreeClick           �  �  �     self            �  �      
@ �& �    _talentTreeClick           �  �     self       val            �  �      G @ f  & �    _talentTreeLine           �  �  �     self            �  �      
@ �& �    _talentTreeLine           �  �     self       val            �  �   J   � @ �@@��   � �@���@ � A�@A �� ��A�� ��@ � ��A � � �� A @�� �L�B d� �  b   ��� � �A ���ǂ�@� �@ C@AC $C & � �C @�$� @ � ���\�_@� �@ �� ������ � F�C �� d� �A�� �ƁC  � � ���@ �A� @ �A��AD ǁ�  @ �A�& �    Logdebug?###[UISeasonModule] SaveFinishLineMissionList start save , id:GameGlobal
GetModuleRoleModule	GetPstIdSeasonModuleGetCurSeasonIDTalentTreeFinishMissionGetSaveFinishLineMissionList       J###[UISeasonModule] SaveFinishLineMissionList save id is saved , return !	tostring,>###[UISeasonModule] SaveFinishLineMissionList save end , val:LocalDB
SetString         J   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    J   id    J   openid   J   currSeasonID   J   key   J   	saveList   J   saveStr   J   (for index)   4   (for limit)   4   (for step)   4   i   3   num    3   str*   3      _ENV �     8   F @ G@� ��  d@ F�@ G � �@A d� L�� d� ��@ � A��A �� � B�� �@   @� �@��B �B@�� $��FAC G��� d� b  @�F@ GA��� dA D  f K  �AC �D� B �����  A� �A�ǂ�D E@���$C���f & �    LogdebugC###[UISeasonModule] SaveFinishLineMissionList start get client valGameGlobal
GetModuleRoleModule	GetPstIdSeasonModuleGetCurSeasonIDTalentTreeFinishMissionLocalDB
GetStringstringisnulloremptyH###[UISeasonModule] SaveFinishLineMissionList not client val , return !split,       tableinsert         8   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �                                    self    8   openid
   8   currSeasonID   8   key   8   val   8   list&   8   strList+   8   (for index).   6   (for limit).   6   (for step).   6   i/   5   num0   5      _ENV   #   J   � @ �@@��   � �@���@ � A�@A �� ��A�� ��@ � ��A � � �� A @�� �L�B d� �  b   ��� � �A ���ǂ�@� �@ C@AC $C & � �C @�$� @ � ���\�_@� �@ �� ������ � F�C �� d� �A�� �ƁC  � � ���@ �A� @ �A��AD ǁ�  @ �A�& �    Logdebug=###[UISeasonModule] SavePassLineMissionList start save , id:GameGlobal
GetModuleRoleModule	GetPstIdSeasonModuleGetCurSeasonIDTalentTreePassMissionGetSavePassLineMissionList       H###[UISeasonModule] SavePassLineMissionList save id is saved , return !	tostring,<###[UISeasonModule] SavePassLineMissionList save end , val:LocalDB
SetString         J   	  	  	  	  	  
  
  
  
  
  
                                                                                                          !  !  !  !  !  "  "  "  "  "  #     self    J   id    J   openid   J   currSeasonID   J   key   J   	saveList   J   saveStr   J   (for index)   4   (for limit)   4   (for step)   4   i   3   num    3   str*   3      _ENV %  6   8   F @ G@� ��  d@ F�@ G � �@A d� L�� d� ��@ � A��A �� � B�� �@   @� �@��B �B@�� $��FAC G��� d� b  @�F@ GA��� dA D  f K  �AC �D� B �����  A� �A�ǂ�D E@���$C���f & �    LogdebugA###[UISeasonModule] SavePassLineMissionList start get client valGameGlobal
GetModuleRoleModule	GetPstIdSeasonModuleGetCurSeasonIDTalentTreePassMissionLocalDB
GetStringstringisnulloremptyF###[UISeasonModule] SavePassLineMissionList not client val , return !split,       tableinsert         8   &  &  &  &  '  '  '  '  '  '  (  (  (  (  (  (  )  )  )  )  *  *  *  *  *  +  +  +  +  +  +  ,  ,  ,  ,  -  -  /  0  0  0  0  0  1  1  1  1  2  3  3  3  3  3  1  5  6     self    8   openid
   8   currSeasonID   8   key   8   val   8   list&   8   strList+   8   (for index).   6   (for limit).   6   (for step).   6   i/   5   num0   5      _ENV 9  ;      
@ �& �    _talentBattleOut           :  ;     self       val            =  A      G @ 
@@�f  & �    _talentBattleOut            >  ?  @  A     self       val           C  G     � @ �@@��   � �@�
@���   �   �@  
� �& �    Logdebug设置赛季默认退局ui:_defaultDialog_dialogParam            D  D  D  D  D  E  F  F  F  F  G     self       dialog          _ENV I  P      G @ b    �F@@ G�� ��  � @ d@�F A G@� d�� L�� � @ �A BGAB $ d@  
�B�
�& �    _defaultDialogLogdebug打开赛季退局默认ui:GameGlobalUIStateManagerShowDialogtableunpack_dialogParam             J  J  J  K  K  K  K  K  L  L  L  L  L  L  L  L  L  L  M  N  P     self          _ENV R  Y      F @ G@� ��@ d� L�� d� !@ �� ��@ �  @ ��� �  & �    GameGlobal
GetModuleSeasonModuleGetCurSeasonIDF      UISeasonOnceMissionControllerUISeasonOnceMission            S  S  S  S  S  S  T  T  U  U  U  W  W  Y     self       currSeasonID         _ENV�                                          #      %   -   %   /   6   /   :   A   :   E   S   E   U   W   U   Z   c   Z   e   g   e   j   z   j   }      }   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �           	                %  '  %  )  +  )  -  .  W  .  Y  c  Y  e  l  e  n  �  n  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �    �    #    %  6  %  9  ;  9  =  A  =  C  G  C  I  P  I  R  Y  R  Y     MainEnterKeyj   �      _ENV