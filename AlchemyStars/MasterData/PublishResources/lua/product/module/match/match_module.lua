LuaS �

xV           (w@?@../PublishResources/lua/product/module/match/match_module.lua         ^    @ A@  ��@ $@�@@  ��@@ l   
@��@@ l@  
@ �@A l�  
@ �@A l�  
@�� B l  
@�� B l@ 
@ � B l� 
@�� B l� 
@ � B l  
@�� B l@ 
@ � B l� 
@�� B l� 
@ �@D l  
@ �@D l@ 
@�� E l� 
@�� E l� 
@ � E l  
@�� F l@ 
@�� F l� 
@ � F l� 
@�� G l  
@�� G l@ 
@ � G l� 
@�� G l� 
@ � G l  
@�� G l@ 
@ � G l� 
@�� G l� 
@ � G l  
@��& � &   _classMatchModuleLoginBaseModuleConstructorInitMatchModuleHandleLogoutResetMatchModuleSetMatchResultGetMatchResultGetMatchEnterDataGetMatchEnterPreferenceDataGetMatchTypeGetSubMatchTypeClearMatchEnterDataDisposeMatchModuleStartEnterMatchLoginMatchModuleEnterMatchSetMatchEnterDataLoadingMatchModuleWaitMatchStartTaskHandleMatchEndMsg	GameOverMatchModuleWaitSendGameOverTaskHandleCEventMatchStartLoadingHandleCEventMatchStartSendBattleLogHandlePushMatchChatMessageHandleLuaCommandHandleWaveEndSetReStartMatchStateIsQuickReStartMatch                  
@@�F�@ L � d� 
@ �
���
���
@@�
@��
�B�
@C�
�C�
@@�& �    m_login_lock authGroupAuthInfoNewm_match_enter_data m_match_enter_preference_datam_have_match_resultm_have_match_start_wait_for_net_result_tick N      _check_net_result_tickd       	_matchID        _bRestartMatch                           	   
                           self          _ENV        $   F @ G@� G�� �   d@ G�@ L � �@A �A @  d@�G�@ L � ��A B @  d@�G�@ L � �@B �B @  d@�G�@ L � ��B C @  d@�G�@ L � �@C �C @  d@�& �    MatchModulesuperInitcallerRegisterPushHandlerCEventMatchStartLoadingHandleCEventMatchStartLoadingCEventMatchStartHandleCEventMatchStartCEventSvrPushLogoutHandleLogoutCEventPushChatMessageToChannelHandlePushMatchChatMessageCEventLuaCommandHandleLuaCommand         $                                                                                                                  self    $      _ENV    #       � @ �@@̀@ � �  FA �A� d� �� ��� �@ � B �@ �@B �� �@�& � 
   LogdebugKey MatchModule HandleLogout, err: 	tostringm_err
 reason: 	m_reasonStopFastCheckReset                                                        !   !   "   "   "   #      self       msg          _ENV (   0       � @ �� �@   ��@@ ��@�� �    ��@@ ��@�� @ ��@  � � � A �@�ǀ�   @� �@��     �& � ��A � �䀀 �@��@ & � 
   IsLogincallerIsConnectedHasAuthMatchModulesuperResetGameGlobal
GameLogicGoBack            )   )   )   )   )   )   )   )   )   )   )   )   )   )   )   *   *   *   *   *   *   +   +   ,   /   /   /   /   /   0      self       reason       	isNormal         _ENV 2   4       
@ �& �    _match_result           3   4      self       result            6   8       G @ f  & �    _match_result           7   7   8      self            <   >       G @ f  & �    m_match_enter_data           =   =   >      self            @   B       G @ f  & �    m_match_enter_preference_data           A   A   B      self            E   G       G @ L@� e  f   & �    m_match_enter_dataGetMatchType           F   F   F   F   G      self            I   K       G @ L@� e  f   & �    m_match_enter_dataGetSubMatchType           J   J   J   J   K      self            N   Q       
@@�
@@�& �    m_match_enter_data m_match_enter_preference_data           O   P   Q      self            S   Z       G @ L@� ƀ@ d@�G @ L@� ��@ d@�G @ L@� � A d@�G @ L@� �@A d@�G @ L@� ƀA d@�F�A G � G@� �   d@ & � 
   callerUnRegisterPushHandlerCEventMatchStartLoadingCEventMatchStartCEventSvrPushLogoutCEventPushChatMessageToChannelCEventLuaCommandMatchModulesuperDispose            T   T   T   T   U   U   U   U   V   V   V   V   W   W   W   W   X   X   X   X   Y   Y   Y   Y   Y   Z      self          _ENV \   ^       
@@�& �    m_have_match_start            ]   ^      self            g   �       F@ LA�d� ��@ �  ����@ �A�AA � � �A�f ��A � ���B �� �  ���AB ��B�� �  @���@ �A�AA � � �A���� �A�f �AC ��C��� ��C�A  ����@ �D�AA � B �A�f 
�D���A � � ��B �� �A   �
���
 ŉ�AB �AE�E B@��E �F�B �A $��A� �A �AB ��F�A �AG ��� 
����@ ��G�AA � � FBC G��d�� L�d� �B �� �  � ��B �B    ��� ��A �A ��H �I�� �AI�I ����B � �����AC ǁ�䁀 �������JBC �J����AC ǁ�䁀 ������ǁK ������K ��B A� ��L  � @ ��� �� ��GCM�B�̂M� �B  ����@ ��CA $� A� �CM�B @��N CN� �����@ DLCA d� �� $C�@���C�$C���$� F�O G�@��F�@ G���CA �� �C   A� dC�
�ĉGCB L��dC L��� dC�FQ �C�dC @�@�F�O G��@��! ����F�@ G��CA �� �C   A � �D dC�FCC G��d�� L���  �R A �DS ���� �� ES @ $� A� ]D��� �T �D�	dC����TF�@ G���CA �� ��   A � �  �AE dC�F�U �� ��dC���F�@ G��CA �� �C   A� dC�FCC G��d�� L���  �R A �DS ���� �� ES @ $� A� ]D��� �T �D�	dC�  � �
@L��BC �BV��� ��V�V W�B�
 E���@ ��G�BA � C �B�f & � ^   AsyncRequestResNewm_login_lockLogwarnKey login match lock is lockedsvrIdIsLogincallerHasAuth! already pass login match verifySetSuccGameGlobal
GameLogicClientInfofatal! login match client info is nullisLogin SetPipe2Conn	NetTokenNetTokenTypeTOKEN_MATCHMTgateway	LostAuth
curTaskIdGetCurTaskIddebug	 player 
GetOpenId reconn to  login match to NetMessageFactoryGetInstanceCreateMessageCEventRequestLoginVerifym_is_loginm_client_infoclient_versionVersionm_login_infomsdkAuthorityInfom_group_authauthEnum_Login_Step E_Login_Step_RequestLoginVerify        �      CallSetCallErrresSucc login match reply failed CEventReplyLoginVerifymsg  login match reply msg is null
SetResultm_ret
GetResultMOBILE_LOGIN_ERRORMOBILE_LOGIN_OK login match , resend request	GainAuthAdjustTimeCSm_server_timeMOBILE_LOGIN_RETRY       	, retry  limitBackToLoginMatchModuleretry limit: LoginMatch[	tostring, ]MOBILE_LOGOUT_ERRORMOBILE_LOGOUT_MATCH_ERROR        login  times after  msYIELD, resetlogin failed: : LoginMatch[EventDispatcher	DispatchGameEventTypeNetWorkRetryEnd login match end            h   h   h   i   i   i   j   j   j   j   j   j   k   m   m   m   m   m   m   m   m   m   m   m   m   n   n   n   n   n   n   o   o   o   p   r   r   r   r   r   r   s   s   s   s   s   s   t   w   x   x   x   x   x   x   x   y   z   {   {   {   {   {   {   {   {   {   {   {   }   }   }   ~   ~   ~   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       TT       svrId       silent       timeout       res      requeste      nLoginStepz      retry_times{      	retry_ms|      
replyInfo�     reply�     ret�        _ENV �      d   @ A@$� L�@�  dA�F�@ L�d� LA�ƁA d��J���J� ��AB  � @��� ́B� �A  ����B ��B �A ́CA� �A�& �D BD� �����B CA� $B �C�� $B�& �_@E@��B CA� ��]��$B �C��$B�& �@�� $B�F B@� �B���$��
 ��G B@��E �BG$��
 ���G �G$�� H$B �G �G$�� BH��H ��H�B  CI G�E $� ��$B ��
 ��B JAB
 � ��
 ��$B�& & � +   AsyncRequestResNewSetSuccNetMessageFactoryGetInstanceCreateMessageCEventRequestEnterMatchm_match_to_enterm_player_idCallSuccLogfatal1MatchModule:EnterMatch failed with !reply:Succ()
SetResult��������CEventReplyEnterMatchmsg 5MatchModule:EnterMatch failed with replyEvent == nilm_ret        (MatchModule:EnterMatch failed with ret=m_match_enter_dataMatchEnterDatacreate_infoplayer_listm_match_enter_preference_dataMatchEnterPreFerenceData_joined_playersGameGlobalGameRecorderStartRecordRecordActionGameRecordActionStartMatchmatch_enter_datatable_to_class	_matchID	group_iddebug+MatchModule:EnterMatch succeeded PlayerID:
 MatchID:         d   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �          self    d   TT    d   
player_id    d   match_to_enter    d   res   d   request   d   reply   d   replyEvent!   d      _ENV         
@ ���@ ��@@ A���
���& �    m_match_enter_datam_match_enter_preference_dataMatchEnterPreFerenceDataNew_joined_players                               self       match_enter_data          _ENV      /   � @ �@@��   � � ��@ !@�� �� A �@A�� ��A�� �   @�
 
�� A ��B��� � CAC �C�@�& � ��C �@A�� � DAD �����D��@ ��@E @ �@�!@����ƀE �@�� ���FF GA��  �@ & �    Logdebug$sending CEventUpdateLoadingProgressd       GameGlobalGetInstanceIsOfflineMatchm_have_match_result m_have_match_startEventDispatcher	DispatchGameEventTypeMatchStartNetMessageFactoryCreateMessageCEventUpdateLoadingProgresstestaaaaaa       m_progressPushTaskManager
StartTaskMatchModuleWaitMatchStartTask         /                                                                                                    self    /   	progress    /   msg   /      _ENV   1   	4   � @ �@@�� ��@�� �@  �& � � A �@  @��@ ǀA �A � �A ����B �� �A �A��@ �A@�� ��@�� �@ ��AB ��B�� �A & � �A �A    ����� A �@  ���@B ��B�  �@ � @ �@C��� ��C�C D�@�& �    GameGlobalGetInstanceIsCoreGameRunning m_have_match_start       _wait_for_net_result_tick_check_net_result_tickYIELDLogerror-WaitMatchStartTask() IsCoreGameRunning false WaitMatchStartTask() timeout !!EventDispatcher	DispatchGameEventTypeMatchError         4                   !  !  !  "  "  "  "  "  "  #  #  #  #  $  $  $  $  $  $  $  %  %  %  %  &  (  (  (  "  -  -  -  .  .  .  .  /  /  /  /  /  /  /  1     self    4   TT    4   (for index)   %   (for limit)   %   (for step)   %   i   $      _ENV 3  5      
@@�& �    m_have_match_result           4  5     self       msg            8  G   	-   � @ �@@��  �@ ��@ �     �& � � A �@A�� ��A�� �   ��� A ��A��� � BAB �B�@�& � ��B C ����@C ̀�� D� ���@���D ��$A��D AA$� E�AE ��E�   � $A�& �    LognoticeGameOver -------------GameSingleGameGlobalGetInstanceIsOfflineMatchLoadingManagerStartLoadingLoadingHandlerNameExit_Core_Game
GetModuleLoginModuleCEventGameOverNewm_player_pstidPstID	m_resultPushTaskManager
StartTaskMatchModuleWaitSendGameOverTask         -   9  9  9  9  :  :  :  ;  =  =  =  =  =  =  =  >  >  >  >  >  >  >  ?  A  A  A  B  B  B  C  C  D  E  E  E  F  F  F  F  F  F  F  F  F  G     self    -   result    -   login   -   msg   -      _ENV I  ^   
8   � @ �@�� ̀�� �� �� A �@�� �@ & � ��A �@  @��  AB G�B AA ����B  � G�B �A��@ �A�� ́�� �� ��A ��B �A & � ��A �A    ������A �@  ��� A � �� �@ � @ ���䀀 � �FAD G���@�& �    GameGlobalGetInstanceIsCoreGameRunning Logdebug-leave GameOverTask for coregamerunning falsem_have_match_result       _wait_for_net_result_tick_check_net_result_tickYIELDerror/WaitSendGameOverTask() IsCoreGameRunning false"WaitSendGameOverTask() timeout !!EventDispatcher	DispatchGameEventTypeMatchError         8   J  J  J  J  J  J  J  K  K  K  K  L  N  N  N  O  O  O  O  O  O  P  P  P  P  Q  Q  Q  Q  Q  Q  Q  R  R  R  R  S  U  U  U  O  Z  Z  Z  [  [  [  [  \  \  \  \  \  \  \  ^     self    8   TT    8   result    8   (for index)   )   (for limit)   )   (for step)   )   i   (      _ENV c  f      � @ �@@��   � �@�& �    LogfatalCEventMatchStartLoading :             e  e  e  e  e  f     self       msg          _ENV k  p      � @ �@@�� ��@�  ���� AA �@�
�A�
@B�� @ ��B��� ��BC AC�@�& �    GameGlobalGetInstanceGetCollectorCoreGameLoadingSample%MatchModule:HandleCEventMatchStart()m_have_match_result m_have_match_startEventDispatcher	DispatchGameEventTypeMatchStart            l  l  l  l  l  l  l  l  l  m  n  o  o  o  o  o  o  o  p     self       msg          _ENV r  y      � @ �@@��  �@ ��@ � A�� �@��̀A @ �@�& �    LognoticeSendBattleLog --------------CEventBattleLogNewm_data_point_logPush            s  s  s  s  u  u  u  v  x  x  x  y     self       
logString       logMsg         _ENV |        � @ A@ ���̀@@� �@�& �    
GetModuleChatModuleReceiveChatMessage            }  }  }  ~  ~  ~       self       msg       chat         _ENV �  �      � @ �@@�� ��@�� �@   ���@ � �A �@ & � ̀AA� 䀀��� $A�& � 	   GameGlobalGetInstanceGetMainWorldLogerror'HandleLuaCommand not find main world!!GetServiceNetworkReceiveMessage            �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       msg       
mainWorld      networkService         _ENV �  �      � @ �@@��   � �@���@ � A�� �@��̀A @ �@�& �    Lognotice!WaveEnd ------------- WaveIndex:CEventWaveEndNewwave_indexPush            �  �  �  �  �  �  �  �  �  �  �  �  �     self       
waveIndex       msg         _ENV �  �      
@ �& �    _bRestartMatch           �  �     self       state            �  �      G @ f  & �    _bRestartMatch           �  �  �     self           ^                                          #      (   0   (   2   4   2   6   8   6   <   >   <   @   B   @   E   G   E   I   K   I   N   Q   N   S   Z   S   \   ^   \   g   �   g   �     �                 1    3  5  3  8  G  8  I  ^  I  c  f  c  k  p  k  r  y  r  |    |  �  �  �  �  �  �  �  �  �  �  �  �  �         _ENV