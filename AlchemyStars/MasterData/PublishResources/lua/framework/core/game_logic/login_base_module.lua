LuaS �

xV           (w@I@../PublishResources/lua/framework/core/game_logic/login_base_module.lua         ]   �  
 @�
@��
�@�F�@ �  �   d@�F@A �� ��A d@�F�A @ �F�A �   J� �F�A �@  J���F�B ��  J���F C ��  J���F�C �  J���F�C �@ J� �F�C �� J���F�C �� J� �F�C �  J���F�C �@ J� �F�C �� J���F�C �� J� �F�C �  J���F�C �@ J� �F�C �� J���F�C �� J� �F�C �  J���F�C �@ J� �F�C �� J���F�C �� J� �F�C �  J���F�C �@ J� �F�C �� J���F�C �� J� �F�C �  J���F�C �@ J� �& � %   UnsetRetryResetDuringResetDuring_enumModuleStateType_classLoginBaseModuleGameModuleConstructorInitLoginBaseModuleDisposeLoginBaseModuleUpdateLoginBaseModuleKeyIsLoginResetRetryStartRetryProcCancelRetryTimer
RetryProc
RetryTaskLoginLogoutHandleLogoutHandleNotificationStartFastCheckStopFastCheckOnFastCheckFailedOnConnectDoneOnConnectFailedOnConnectClosedOnCallBegin
OnCallEndOnCallTimelongOnCallTimeout                  
@@�
�@�
@@�
���
 
�
@��
@@�F�C 
@��
���G@B R@� 
@ �G@B 
@ �
���K   
@ �& �    svrId        isLogin 
curTaskIdretryTimer retryDelayCD�      retryTimeout@      startRetryTimelastRetryTime
stateTypeUnsetfastCheckTimerfastCheckTimelong       fastCheckTimeoutisBusy	tempList                                                                          self          ModuleStateType    -    6   F @ G@� G�� �   d@ G�@ L � �@A �A @  d@�G�@ L � ��A B @  d@�L@B ƀB ���C d@ L@B ƀB �@��C d@ L@B ƀB ���D d@ L@B ƀB �@��D d@ L@B ƀB ���E d@ L@B ƀB �@��E d@ L@B ƀB ���F d@ 
�ƌ& �    LoginBaseModulesuperInitcallerRegisterPushHandlerCEventSvrPushLogoutHandleLogoutCEventSvrPushNotificationHandleNotificationAttachEventGameEventTypeConnectDoneOnConnectDoneConnectFailOnConnectFailedConnectCloseOnConnectClosed
CallBeginOnCallBeginCallEnd
OnCallEndCallTimelongOnCallTimelongCallTimeoutOnCallTimeoutisLogin          6                       !   !   !   !   !   !   "   "   "   "   "   "   $   $   $   $   $   %   %   %   %   %   &   &   &   &   &   '   '   '   '   '   (   (   (   (   (   )   )   )   )   )   *   *   *   *   *   ,   -      self    6      _ENV 0   8       
@@�L�@ d@ L�@ d@ G A L@� ƀA d@�G A L@� ��A d@�F B G@� G�� �   d@ & �    isLogin StopFastCheckCancelRetryTimercallerUnRegisterPushHandlerCEventSvrPushLogoutCEventSvrPushNotificationLoginBaseModulesuperDispose            1   2   2   3   3   5   5   5   5   6   6   6   6   7   7   7   7   7   8      self          _ENV =   ?       � @ �@@��@�    � �@�& �    LoginBaseModulesuperUpdate            >   >   >   >   >   >   ?      self       curTime          _ENV D   F       G @ b    �G @ L@� d� b@    �A�  f  & �    callerKey<disposed module>           E   E   E   E   E   E   E   E   E   E   F      self            K   M       G @ f  & �    isLogin           L   L   M      self            R   ]    *   � @ �@@̀@ � �  @� �@ �A�� �@  ��� 
���
 �@B �@ ��B �@ ��B  � �@�� C �@C��� ��C�C D�@��@D ��D�D E�@��@D �@E � �@�� C ��E��� ��E�@ & �    LogdebugKey Reset, reason: 
traceback
stateTypeUnsetisLogin StopFastCheckCancelRetryTimerLogoutGameGlobalEventDispatcher	DispatchGameEventTypeLoginResetcaller
ResetCallCallResultType
CallResetDisconnect
GameLogicGoBack          *   S   S   S   S   S   S   S   S   S   S   T   T   U   V   V   W   W   X   X   X   Y   Y   Y   Y   Y   Y   Y   Z   Z   Z   Z   Z   [   [   [   [   \   \   \   \   \   ]      self    *   reason    *      _ENVModuleStateType b   z    5   � @ �@@̀@ � �  @� �@ �A�� �@  ��� 
�����A � B �� �@B ̀�� ���� �� � C �@�� �    �� C ̀��@ ��  �� C � �� �   @ ��� @�� C �@�� �   @ ��� � �!�D  ��� ��D @ �� �@ & �    LogdebugKey Retry, reason: 
traceback
stateTypeUnsetlastRetryTimeretryDelayCDGameGlobalGetInstanceGetCurrentRealTimecallerIsCallTimeoutResetCallTimeout(       HasSyncCallIsConnected        StartRetryProc          5   c   c   c   c   c   c   c   c   c   c   d   d   e   e   e   e   e   e   e   e   e   f   f   f   f   f   h   h   h   j   j   k   k   k   k   k   n   n   o   o   o   o   o   r   r   s   s   v   y   y   y   y   z      self    5   reason    5   
delayTime   5      _ENVModuleStateType {   �       � @ �@��@ $� A�  �� �@ �@A ǀ�䀀 ���@� �B �  B @ �� ��B  � � �� 
� �& �    LogdebugKey Retry after: retryTimerGameGlobal
RealTimer	AddEvent
RetryProc	reason: , before: 	tostring            |   |   |   |   |   |   |   ~   ~   ~   ~      �   �   �   �   �   �   �   �   �   ~   �   �      self       
delayTime       reason          _ENV �   �       G @ @�   �& � F�@ G�� � A �� �@ �@ �A$� d@  F�A G � d�� L@� � @ d@�
@@�& � 
   retryTimer LogdebugKey CancelRetryTimer
tracebackGameGlobal
RealTimerCancelEvent            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self          _ENV �   �    K   � @ �@@̀@ � �  @� �@ �A�� �@  �@A �@ ��A ��A�� �   ��� @ � B̀@ � A �@�& � ��B � C�� �@C�� 
� ���C �C@�� D �@D �    �ǀA ̀�� �D !� @ �� E  �E G�D N��! �� ��D ��   �� E ��B �@�䀀 ̀�G�E �  � �@�����B � F��� �@F�F �F�@���A � G�C �@�& �    LogdebugKey RetryProc, reason: 
tracebackCancelRetryTimercallerHasAuthwarn has auth, need not retrylastRetryTimeGameGlobalGetInstanceGetCurrentRealTime
curTaskId        retryTimeoutfastCheckTimerLastRecvElapsedTickfastCheckTimeoutfastCheckTimelongTaskManager
StartTask
RetryTaskEventDispatcher	DispatchGameEventTypeNetWorkRetryStart
RetryCall         K   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    K   reason    K   timeout"   >   elapsed(   6      _ENV �   �    
Z   � @ �@�䀀 ̀�F�@ G��@�ǀA 
�����A � �AB $� A� � ��A ����� �@  � C @� �AC ��   � �C $A ��$� "  ���A BLAB d� � $A��
�A�$� "  ���A �DLAB d� �� �E B�$ �  $A  ���E $� "  ���A �DLAB d� �� �E �$ �  $A  @ AF$�� �F�F�  � $A  �AG �G��G �H$A�
@Ȃ@ A@$�� �@��@ ��H$A�& � #   GameGlobalEventDispatcher	DispatchGameEventTypeNetWorkRetryStartstartRetryTimelastRetryTimeLogdebugKey RetryTask, timeout: 
tracebackLoginsvrIdCancelRetryTimerGetSucc retry doneGetCallSuccfatal retry failed, msg: 	tostring
GetResultIsLogin retry failed, call: GetCallErr
GameLogicNetworkMonitorCallRetryResetcall login timeoutcaller
ResetCallCallResultTypeCallTimeout        NetWorkRetryEnd         Z   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    Z   TT    Z   timeout    Z   res   Z      _ENV �   �       F@ LA�e f  & �    AsyncRequestResNew            �   �   �   �   �      self       TT       svrId       silent       timeout          _ENV �   �       � @ �@@�� �@    �& � ��@ ��@� A � A @� ��@ ��A�� �@  ��A � B�� �@B�B �����B @ �@�& �    callerIsConnectedLogdebugKey Logout, reason: 
tracebackNetMessageFactoryGetInstanceCreateMessageCEventCliPushLogoutPush            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       reason       msg         _ENV �   �    
#   � @ �@@̀@ � �  FA �A� d� �� ��� @ B$� �@  �@B ��B��� ��B  @  � �A B� � � G�� �A�AC � B� F@ G�d� �@  & �    LogdebugKey HandleLogout, err: 	tostringm_err
 reason: 	m_reason
tracebackGameGlobal
GameLogicBackToLoginserver logout, err: IsLogin         #   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    #   msg    #      _ENV �   �       � @ �@@̀@ � �  FA �A� d� �@ ��A�� �@  ��A � B��� �@B�B �BGA� �� �@�& �    LogdebugKey) HandleNotification, notification_type: 	tostringm_notification_type
tracebackGameGlobalEventDispatcher	DispatchGameEventTypePushNotificationm_hot_update_res_ver            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       msg          _ENV   (   =   @ A@$� "A    �& � �@ $A 
���
� �@ AA$� G@ L��d� ��A �B�AB � � @ �� �� @� �C � � @���A ��C	�� �A  !@�� �  ��@ �DB �A�& � ! � � ��@ ��D�A �E �AE��� ��E � G�E �  ��   @��� 
���& �    callerHasAuthStopFastCheckfastCheckTimelongfastCheckTimeoutLastSendElapsedTickLastRecvElapsedTickLogdebugKey  StartFastCheck, send elapsed: , recv elapsed: , interval: , timelong: , timeout: 
tracebackDisconnectLinkfast check timelongAlivefastCheckTimerGameGlobal
RealTimer	AddEventStartFastCheck         =               	  	  
                                                                      !  !  #  #  #  '  '  '  '  '  '  '  '  '  '  '  '  (     self    =   	interval    =   	timelong    =   timeout    =   lastSendElapsedTick   =   lastRecvElapsedTick   =      _ENV ,  5      G @ @�   �& � F�@ G�� d�� L � � @ d@�
@@�G�A R�� 
@��G�A 
@ �& � 	   fastCheckTimer GameGlobal
RealTimerCancelEventfastCheckTimelongretryTimeout       fastCheckTimeout            -  -  -  .  1  1  1  1  1  1  2  3  3  3  4  4  5     self          _ENV 9  B      � @ �@@̀@ � �  @� �@ �A�� �@  �@A ��A�� ��A  � � �� B  � �@����@B ��B��� ��B� C   @� �@ & �    LogdebugKey OnFastCheckFailed, reason: 
tracebackcallerLastRecvElapsedTickfastCheckTimeoutRetryGameGlobal
GameLogicNetworkMonitorConnectRetryReset            :  :  :  :  :  :  :  :  :  :  ;  ;  ;  ;  ;  ;  =  =  =  =  @  @  @  @  @  @  @  @  B     self       reason          _ENV F  K      � @ _��   �& � �@@ �  �@�& �    callerRetryconnect done           G  G  G  H  J  J  J  K     self       caller            O  h   >   � @ _��   �& � � @ �@�� �     ���̀@ � �@  @�� @ ���FA GA��@� 
�ǀA �   � ���A @ �@�@�� @ � �� �   � ��@B @ �@� �ǀB _��@�� C �@�� ̀�� �B � ��C   �� ��@B @ �@���� C � �䀀 �@�̀�@  � �@ & �    callerIsCallTimeoutIsLogin
ResetCallCallResultTypeConnectFailedfastCheckTimerOnFastCheckFailedHasSyncCallRetrystartRetryTime        GameGlobalGetInstanceGetCurrentRealTimeretryTimeout
GameLogicNetworkMonitorConnectRetryReset         >   P  P  P  Q  S  S  S  S  S  S  U  U  U  U  W  W  W  W  W  W  X  X  X  Z  Z  Z  Z  [  [  [  [  [  ]  ]  ]  ]  _  _  _  `  `  `  `  `  `  `  `  `  `  c  c  c  c  f  f  f  f  f  f  f  f  h     self    >   caller    >   reason    >      _ENV l  �   A   � @ _��   �& � � @ �@��@ � @ ̀�� �     �����@ � �@  @�� @ � �FAA G���@� 
���A �   � �� B @ �@�@�� @ �@�� �   � �̀B @ �@� ���B _ �@��@C ̀�� ���� �B � �D   �� �̀B @ �@����@C �@�䀀 ǀ����@  � �@ & �    caller	LostAuthIsCallTimeoutIsLogin
ResetCallCallResultTypeConnectClosedfastCheckTimerOnFastCheckFailedHasSyncCallRetrystartRetryTime        GameGlobalGetInstanceGetCurrentRealTimeretryTimeout
GameLogicNetworkMonitorConnectRetryReset         A   m  m  m  n  p  p  p  q  q  q  q  q  q  s  s  s  s  u  u  u  u  u  u  v  v  v  x  x  x  x  y  y  y  y  y  {  {  {  {  }  }  }  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  �  �  �  �  �  �  �  �  �  �  �  �  �     self    A   caller    A   reason    A      _ENV �  �      � @ _��   �& � & �    caller           �  �  �  �  �     self       caller       msg            �  �      � @ _��   �& � �@@ �   ��ƀ@ ���䀀 � �C  �@�
@��& �    callerisBusyGameGlobalUIStateManager	ShowBusy             �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       caller       msg          _ENV �  �      � @ _��   �& � �@@ ����
���� A �@�䀀 ̀�C� �@�& �    callerisBusy GameGlobalUIStateManager	ShowBusy            �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       caller       msg          _ENV �  �   "   � @ _��   �& � 
�����@ � A��� �@A  �@�� @ ��A� �@�� B �� �@  @�� @ �@B�B �B�@�����@ � C��� �@C��C   A� �@ & �    callerisBusy GameGlobalUIStateManager	ShowBusyDisconnectLinkcall timeoutIsLogin
ResetCallCallResultTypeCallTimeout
GameLogicNetworkMonitorCallRetryReset         "   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    "   caller    "      _ENV]                                                         -      0   8   0   =   ?   =   D   F   D   K   M   K   R   ]   R   b   z   b   {   �   {   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �     (    ,  5  ,  9  B  9  F  K  F  O  h  O  l  �  l  �  �  �  �  �  �  �  �  �  �  �  �  �     ModuleStateType   ]      _ENV