LuaS �

xV           (w@C@../PublishResources/lua/product/module/sign_in/sign_in_module.lua         �    @ A@  ��@ $@�@@  ��@@ l   
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
@���E l� 
@���E l  
@ ��E l@ 
@���E l� 
@ ��E l� 
@���E l  
@ ��E l@ 
@���E l� 
@ ��E l� 
@���E l  
@ ��E l@ 
@���E l� 
@ ��E l� 
@���E l  
@ ��E l@ 
@���E l� 
@ ��E l� 
@���E l 	 
@ ��E l@	 
@���E l�	 
@ ��E l�	 
@���E l 
 
@ ��E l@
 
@���E l�
 
@ �& � /   _classSignInModuleGameModuleConstructorInitGetNextSignInTimeSetIsSignInTodayGetNextRefreshTotalLoginTimeSetCurChangeDayTotalLoginDaysSetTotalLoginNextRefreshTimeSetNextTotalLoginRewardDaysHaveTotalLoginRewardIsSignInTodayIsReSignInTodayNeedReSignInTodayGetActivityTimeReSignInNeedVigPointGetCurMonthDataSignInTodayReqTotalLoginReqRecvTotalLoginRewardReqDisposeSignInModuleFillNewPlayerSignupStatusRequestNewPlayerSignupStatusGetNewPlayerSignupStatusRequestAcceptNewPlayerRewardGetTotalSignInDayNumPassedDayNeedRequestHandleNotifyPredictionHandleNotifyPredictionDataGetPredictionDataPredictionReqPredictionAwardReqGetMainDressUpGetMainDressUpCurIndexSetMainDressUpCurIndexGetDressInfosGameSingleLoadMainDressUpGameSingleHandleGetMainDressUpHandleGetMainDressUpReqGameSingleHandleSetMainDressUpGameSingleSaveMainDressUpHandleSetMainDressUpReqGameSingleHandleCurMainDressUp"GameSingleHandleGetCurMainDressUpHandleCurMainDressUpReq    +              
@@�
�@�
@@�
���
 
���
�@�F C L@� d� 
@��F�C L@� d� 
@ �& �    m_is_sign_in_today m_next_sign_in_time        m_can_re_sign_in_ex_vig m_next_accept_login_reward_days��������m_total_login_info m_cur_total_login_days m_next_total_login_refresh_timepredictionDataPetForecastDataNewmain_dressupMainDressUpMap                  	   
                                          self          _ENV           G @ L@� ƀ@ �@ @  d@�G @ L@� � A AA @  d@�& �    callerRegisterPushHandlerCEventNotifyPredictionHandleNotifyPredictionCEventNotifyPredictionDataHandleNotifyPredictionData                                                      self          _ENV    !       G @ f  & �    m_next_sign_in_time                   !      self            #   '       
@ �
���
� �& �    m_is_sign_in_todaym_next_sign_in_timem_can_re_sign_in_ex_vig           $   %   &   '      self       is_sign_in       next_sign_inTime       b_can_re_sign_in_ex_vig            *   ,       G @ f  & �     m_next_total_login_refresh_time           +   +   ,      self            /   1       
@ �& �    m_cur_total_login_days           0   1      self       login_day_change_day            3   5       
@ �& �     m_next_total_login_refresh_time           4   5      self       bNextRefreshTime            7   9       
@ �& �     m_next_accept_login_reward_days           8   9      self       nNextTotalLoginRewardDays            A   Y    
:   G @ �@@ ��@��� ��@A ����@A ǀ��A$� B� AB $� !�  �AA �BLAB d� NA�R��$� CM � AC _�C ��C GAC $��GD!@� �GBD��@ �C� f )�  �A�  & ���D  E@ �  & �D a@   �A  � & & �    m_cur_total_login_daysGameGlobal
GameLogic
GetModuleSvrTimeModulemathmodfGetServerTime�      GetNextRefreshTotalLoginTimefloor�Q            m_total_login_info pairsnDay
bIsAccept  m_next_accept_login_reward_days��������         :   B   D   D   D   D   D   D   E   E   E   E   E   E   F   F   F   F   H   H   H   H   H   H   H   H   I   L   L   L   M   M   M   M   N   N   N   N   N   N   O   O   M   M   R   R   R   T   T   T   U   U   W   W   W   W   W   W   Y   
   self    :   l_cur_total_login_days   :   	time_mod   :   
tmNowTime   :   	l_addDay      (for generator)    +   (for state)    +   (for control)    +   key!   )   value!   )      _ENV \   d       F @ G@� d�� L�� ��@ d��� A �@A̀� � ����� � B �   @��@B  � � �� � �  @ ��   �  & � 
   GameGlobal
GameLogic
GetModuleSvrTimeModulemathmodfGetServerTime�      m_is_sign_in_todaym_next_sign_in_time            ]   ]   ]   ]   ]   ]   ^   ^   ^   ^   ^   ^   _   _   _   _   _   _   `   `   `   b   b   d      self       	time_mod      
tmNowTime         _ENV h   x    #   L @ d� �@@ �@ �����@�  @�@ �  & A AA$�� A@��A $��F�A G��AB�� ��Bd� ��B �  @��C  ��� ��� � @ ��  � & �    ReSignInNeedVigPoint
GetModuleQuestModuleGetDailyQuestVigorousGameGlobal
GameLogicSvrTimeModulemathmodfGetServerTime�      m_can_re_sign_in_ex_vigm_next_sign_in_time         #   j   j   k   k   k   l   l   m   m   n   n   q   q   q   q   q   q   r   r   r   r   r   r   s   s   s   s   s   s   t   t   t   v   v   x      self    #   nNeedPoint   #   l_quest_mod   #   nCurVigPoint   #   	time_mod   #   
tmNowTime   #      _ENV z   �       F @ G@� d�� L�� ��@ d��� A �@A̀� � ����� � B �   @��@B  � � �� � �  @ ��   �  & � 
   GameGlobal
GameLogic
GetModuleSvrTimeModulemathmodfGetServerTime�      m_can_re_sign_in_ex_vigm_next_sign_in_time            {   {   {   {   {   {   |   |   |   |   |   |   }   }   }   }   }   }   ~   ~   ~   �   �   �      self       	time_mod      
tmNowTime         _ENV �   �       � @ �@@��� ��@�@ ���� AFAA G���� �  �   & �    GameGlobal
GameLogic
GetModuleLoginModuleGetCommonActivityTimeCommonActivityTypeCAT_SignIn            �   �   �   �   �   �   �   �   �   �   �   �   �      self       dataStr       lm         _ENV �   �       F @ G@� G�� G�� f  & �    Cfgcfg_globalre_sign_in_vig_point	IntValue            �   �   �   �   �   �      self       re_sign_in_vig_point         _ENV �   �    0   � @ �@@�� ƀ@ ���� � �FAA 䀀�A �� ��$� G�A�B �AB_����L�B��B ��dA�@ �  f�GAC���́B@ �A���B ����@����A��D �����C�$B��E�� $B��  ���& �    AsyncRequestResNewNetMessageFactoryGetInstanceCreateMessageCEventCurMonthSignDataReqCallresCallResultTypeNormal
SetResultSIGN_IN_RESULT_CODESIGN_IN_INVALIDmsgnRetSIGN_IN_SUCCEEDsign_in_base_infoRoleSignInStateSetIsSignInTodayis_sign_in_todaynext_sign_in_timeb_can_re_sign_in_ex_vigSetSucc         0   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    0   TT    0   	AsyncRes   0   request	   0   reply   0   
reply_msg   0   nRet   0   l_sign_in_state$   ,      _ENV �   �    >   � @ �@�� �@ �@$� A�AA $��
� �L�A ��   d� ���AB ǁ�_������C BC�A����  �������C����$B�C D ���BD�DL�D �ECEG�EdB�L���� dB����@  @�C F �@��D �� �BF ͂�  $B� �@ &�& �    AsyncRequestResNewNetMessageFactoryGetInstanceCreateMessageCEventSignInReqbIsReSignInCallresCallResultTypeNormal
SetResultSIGN_IN_RESULT_CODESIGN_IN_INVALIDmsgnRetSIGN_IN_SUCCEEDsign_in_base_infoRoleSignInStateSetIsSignInTodayis_sign_in_todaynext_sign_in_timeb_can_re_sign_in_ex_vigSetSuccSIGN_IN_FULLm_next_sign_in_time�Q              >   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   	   self    >   TT    >   bIsReSignIn    >   	AsyncRes   >   request	   >   reply   >   
reply_msg   >   nRet   >   l_sign_in_state%   -      _ENV �   �    	*   � @ �@@�� ƀ@ ���� � �FAA 䀀�A �� ��$� G�A�B �AB_����L�B��B ��dA�@ �  f�GAC��B� �A���C� �A��A�
�����
���A�
��� ����& �    AsyncRequestResNewNetMessageFactoryGetInstanceCreateMessageCEventTotalLoginReqCallresCallResultTypeNormal
SetResultSIGN_IN_RESULT_CODESIGN_IN_INVALIDmsg        SetSuccm_total_login_infototal_login_infom_cur_total_login_daysnTotalLoginDays m_next_total_login_refresh_timetmNextRefreshTime         *   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    *   TT    *   	AsyncRes   *   request	   *   reply   *   
reply_msg   *      _ENV �      :   � @ �@�� �@ �@$� A�AA $��
� �L�A ��   d� ���AB ǁ�_������C BC�A����  �������C����$B�C D ���B��� $B��D _�D ��D G�AB�D� ��D G�A�  
���D G�AB
BE� �G�A&�& �    AsyncRequestResNewNetMessageFactoryGetInstanceCreateMessageCEventRecvTotalLoginRewardReq
nRecvDaysCallresCallResultTypeNormal
SetResultSIGN_IN_RESULT_CODESIGN_IN_INVALIDmsgnRetSIGN_IN_SUCCEEDSetSuccm_total_login_info 
bIsAccept         :   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �                                                     
  
  
       self    :   TT    :   
nRecvDays    :   	AsyncRes   :   request	   :   reply   :   
reply_msg   :   nRet   :      _ENV         G @ L@� ƀ@ d@�G @ L@� ��@ d@�F A G@� G�� �   d@ & �    callerUnRegisterPushHandlerCEventNotifyPredictionCEventNotifyPredictionDataSignInModulesuperDispose                                           self          _ENV         
@ �
���& �    _newPlayerLoginStatus_rewardCfg                    self       acceptStatus       
rewardCfg              -   .   � @ �@@�� ƀ@ ���� � �FAA 䀀�A �� ��$� G�A�B �AB_����L�B�  dA�L�B� dA��  L�B�� dA�L�B�ACǁ�dA�GACG����C �D��@�GACG��
@��GACG�
@���  & �    AsyncRequestResNewNetMessageFactoryGetInstanceCreateMessageCEventNewPlayerLoginStatusReqCallresCallResultTypeNormalSetSucc
SetResult��������msgretSIGN_IN_RESULT_CODESIGN_IN_SUCCEED_newPlayerLoginStatusaccept_status_rewardCfgreward_cfg         .                                                      !  $  $  $  %  %  %  %  &  &  &  &  &  &  (  (  (  *  *  *  ,  -     self    .   TT    .   res   .   request	   .   reply   .      _ENV 0  2      G @ �@@ f �& �    _newPlayerLoginStatus_rewardCfg           1  1  1  2     self            5  G   	-   � @ �@�� �@ �@$� A�AA $��
� �L�A ��   d� ���AB ǁ�_������  �A���B �A��  ���� �A������C�A������C�D �A��� ���D ��D �����  & �    AsyncRequestResNewNetMessageFactoryGetInstanceCreateMessageCEventAcceptNewPlayerRewardReqday_numCallresCallResultTypeNormalSetSucc
SetResult��������msgretSIGN_IN_RESULT_CODESIGN_IN_SUCCEED_newPlayerLoginStatusNewPlayerLoginStatusNPLS_Accepted         -   6  6  6  7  7  7  7  7  7  8  9  9  9  9  ;  ;  ;  ;  ;  <  <  <  =  =  =  >  A  A  A  B  B  B  B  C  C  C  C  C  C  D  D  D  D  F  G     self    -   TT    -   dayNum    -   res   -   request	   -   reply   -      _ENV J  R      A   �@@ ǀ@ �  ���@ ��_�  �M@� ��  *�f  & �            pairs_newPlayerLoginStatusNewPlayerLoginStatusNPLS_UnReach                   K  L  L  L  L  M  M  M  M  N  L  L  Q  R     self       ret_day      (for generator)      (for state)      (for control)      k   
   v   
      _ENV U  ]      F @ G@� d�� L�� ��@ d��� A �@A̀� � ����� � B � !��� �� � �  @ ��   �  & � 	   GameGlobal
GameLogic
GetModuleSvrTimeModulemathmodfGetServerTime�      GetNextRefreshTotalLoginTime            V  V  V  V  V  V  W  W  W  W  W  W  X  X  X  X  Y  Y  Y  [  [  ]     self       	time_mod      
tmNowTime         _ENV a  f      � � �@@ǀ@ ���@ �� �@ �@A ǀ�䀀 ���FB GA�� �@ & � 
   index       predictionDataUpdateStatestatusGameGlobalEventDispatcher	DispatchGameEventTypePredictionStateChanged            c  c  d  d  d  d  d  e  e  e  e  e  e  e  e  f     self       info       day         _ENV h  l      � @ �@@�� �@���@ � A��� �@A�A �A�@�& �    predictionDataInitinfoGameGlobalEventDispatcher	DispatchGameEventTypePredictionDataChanged            j  j  j  j  k  k  k  k  k  k  k  l     self       info          _ENV p  r      G @ f  & �    predictionData           q  q  r     self            v  �   	&   � @ �@@�� ƀ@ ���� � �FAA 䀀�A �� ��$� G�A�B �AB_�� �L�B�  dA�L�B� dA�@ �  f�L�B�� dA�GAC��B���A�� ����& �    AsyncRequestResNewNetMessageFactoryGetInstanceCreateMessageCEventPredictionReqCallresCallResultTypeNormalSetSucc
SetResult��������msgret         &   w  w  w  y  y  y  y  y  y  z  z  z  z  {  {  {  {  {  |  |  |  }  }  }  ~  ~  ~  �  �  �  �  �  �  �  �  �  �  �     self    &   TT    &   res   &   request	   &   reply   &   replyEvent   &      _ENV �  �   )   @ A@$� F�@ L��d� L��AA d����AJ��J� ��AB  � @��� ǁB�B C_ � ��ACC  �A�́CA� �A��   ���ACC� �A��D�C�B�$B�  @�&�& �    AsyncRequestResNewNetMessageFactoryGetInstanceCreateMessageCEventPredictionAwardReqday       idCallresCallResultTypeNormalSetSucc
SetResult��������msgret         )   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    )   TT    )   day    )   id    )   res   )   request	   )   reply   )   replyEvent"   )      _ENV �  �      � @ �@@�@ �  & �    main_dressupinfo           �  �  �  �  �     self       index            �  �      G @ G@� f  & �    main_dressup
cur_index           �  �  �  �     self            �  �      � @ �@��& �    main_dressup
cur_index           �  �  �     self       index            �  �      F @ b    �G@@ _�� � �G@@ G�� �� @ �L A d@ G@@ G�� f  & �    GameSinglemain_dressup infoGameSingleHandleGetMainDressUp            �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self          _ENV �  �      A   �@@ � �   ���_�@@ ��@  ��  �@A ǀ�� @ �@�� B �@�  � �  & � 
   MainDressUpPlayerPrefsGetPersonString �      {"cur_index":1,"_className":"MainDressUpMap","info":[{"is_static":false,"pet_y":0,"_className":"MainDressUpInfo","spine_id":0,"bg_x":0,"pet_grade":0,"pet_cfg_id":0,"is_hand_operate":false,"range_select":1,"bg_type":1,"pet_scale":1,"bg_id":2,"bg_scale":1,"pet_x":0,"pet_skin_id":0,"board_pet":0,"bg_y":0},{"is_static":false,"pet_y":0,"_className":"MainDressUpInfo","spine_id":1,"bg_x":0,"pet_grade":0,"pet_cfg_id":0,"is_hand_operate":false,"bg_y":0,"bg_type":1,"range_select":0,"bg_id":2,"bg_scale":1,"pet_x":0,"pet_skin_id":0,"board_pet":0,"pet_scale":1},{"is_static":false,"pet_y":0,"_className":"MainDressUpInfo","spine_id":1,"bg_x":0,"pet_grade":0,"pet_cfg_id":0,"is_hand_operate":false,"bg_y":0,"bg_type":1,"range_select":0,"bg_id":2,"bg_scale":1,"pet_x":0,"pet_skin_id":0,"board_pet":0,"pet_scale":1},{"is_static":false,"pet_y":0,"_className":"MainDressUpInfo","spine_id":1,"bg_x":0,"pet_grade":0,"pet_cfg_id":0,"is_hand_operate":false,"bg_y":0,"bg_type":1,"range_select":0,"bg_id":2,"bg_scale":1,"pet_x":0,"pet_skin_id":0,"board_pet":0,"pet_scale":1},{"is_static":false,"pet_y":0,"_className":"MainDressUpInfo","spine_id":1,"bg_x":0,"pet_grade":0,"pet_cfg_id":0,"is_hand_operate":false,"bg_y":0,"bg_type":1,"range_select":0,"bg_id":2,"bg_scale":1,"pet_x":0,"pet_skin_id":0,"board_pet":0,"pet_scale":1}]}Logdebug#GameSingleLoadMainDressUp jsonStr=cjsondecode            �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       saveKey      jsonStr      	jsonData         _ENV �  �      L@@ d� 
@ �F�@ G�� � @ d� � A �@A��  � �@���A � @ � �& �    main_dressupGameSingleLoadMainDressUpcjsonencodeLogdebug(GameSingleHandleGetMainDressUp jsonstr=	EmptyRes            �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       jsonStr         _ENV �  �   0   � @ �   � ��@@ �  �   ��@ ��@�� � A �@�� ̀�F�A 䀀B �� ��$� FAB G���� �CdA�GAC��C ��C_�� �LD�  dA�LAD�� dA�@ �  f�LD�� dA�G�D��
��� ����& �    GameSingleGameSingleHandleGetMainDressUpAsyncRequestResNewNetMessageFactoryGetInstanceCreateMessageCEventGetMainDressUpReqCallLogdebug=======================inforesCallResultTypeNormalSetSucc
SetResult��������msgmain_dressup         0   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    0   TT    0   res	   0   request   0   reply   0   replyEvent*   0      _ENV �  �      � @  � �@��@@ �   � �& �    GameSingleSaveMainDressUp	EmptyRes            �  �  �  �  �  �  �     self       tableDatas          _ENV �        � @ � � � � ��A@ ǁ�ʁ���  *����  � A �@�A@ � �A @ ��$A�& �    pairsmain_dressupinfoMainDressUpcjsonencodePlayerPrefsSetPersonString            �  �  �  �  �  �  �  �  �  �                    	   self       tableDatas       (for generator)   	   (for state)   	   (for control)   	   key      value      saveKey
      jsonStr         _ENV 
  &   <   � @ �   � ��@@ @ � ��   ƀ@ ���� A AA$� �A��A $��
� �LAB ��   d� �����B ��_� ��A�  �A����� �A����  ����́�GBD�A��AD�D �D � ��E   �� �CE B
��  j���A�C� �A���  ��& �    GameSingleGameSingleHandleSetMainDressUpAsyncRequestResNewNetMessageFactoryGetInstanceCreateMessageCEventSetMainDressUpReqinfoCallresCallResultTypeNormalSetSucc
SetResult��������msgretROLE_RESULT_CODEROLE_SUCCESSpairsmain_dressup         <                                                                                                       !  !  !        $  $  $  %  %  %  &     self    <   TT    <   tableDatas    <   res
   <   request   <   reply   <   replyEvent$   <   (for generator)/   5   (for state)/   5   (for control)/   5   key0   3   value0   3      _ENV +  0      �   �@@   @� �@�ǀ@ �@��� A   � �& �    CurMainDressUpPlayerPrefsSetPersonIntmain_dressup
cur_index	EmptyRes            ,  -  -  -  -  .  .  /  /  /  0     self       index       saveKey         _ENV 2  5      A   �@@ � � �  � ��   & �    CurMainDressUpPlayerPrefsGetPersonInt                   3  4  4  4  4  4  5     self       saveKey         _ENV ;  T   
5   � @ �   � ��@@ @ � ��   ƀ@ ���� A AA$� �A��A $��
� �LAB ��   d� �����B ��_� ��A�  �A����� �A����  ����́�GBD�A��AD�D �D �@ ��E ʁ ��A�C� �A���  ��& �    GameSingleGameSingleHandleCurMainDressUpAsyncRequestResNewNetMessageFactoryGetInstanceCreateMessageCEventCurMainDressUpReq
cur_indexCallresCallResultTypeNormalSetSucc
SetResult��������msgretROLE_RESULT_CODEROLE_SUCCESSmain_dressup         5   =  =  =  >  >  >  >  @  @  @  B  B  B  B  B  B  C  E  E  E  E  F  F  F  F  F  G  G  G  H  H  H  I  I  I  L  M  M  M  O  O  O  O  O  P  P  R  R  R  S  S  S  T     self    5   TT    5   index    5   res
   5   request   5   reply   5   replyEvent$   5      _ENV�                                          !      #   '   #   *   ,   *   /   1   /   3   5   3   7   9   7   A   Y   A   \   d   \   h   x   h   z   �   z   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �     �                 -    0  2  0  5  G  5  J  R  J  U  ]  U  a  f  a  h  l  h  p  r  p  v  �  v  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �    �  
  &  
  +  0  +  2  5  2  ;  T  ;  T         _ENV