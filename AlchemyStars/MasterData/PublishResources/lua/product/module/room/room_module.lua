LuaS �

xV           (w@n@C:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/lua/product/module/room/room_module.lua             @ A@  ��@ $@�@@  ��@@ l   
@��@@ l@  
@ �@A l�  
@ ��A l�  
@ �@B l  
@ �@B l@ 
@��@B l� 
@ �@B l� 
@��& �    _classRoomModuleLoginBaseModuleConstructorInitRoomModuleDisposeRoomModuleLoginRoomModule
EnterRoomEnterMatchHandleCEventPushEnterMatchHandlePushRoomChatMessage                  
@@�F�@ L � d� 
@ �& �    m_login_lock authGroupAuthInfoNew                                 self          _ENV 
          F @ G@� G�� �   d@ G�@ L � �@A �A @  d@�G�@ L � ��A B @  d@�& � 	   RoomModulesuperInitcallerRegisterPushHandlerCEventPushEnterMatchHandleCEventPushEnterMatchCEventPushChatMessageToChannelHandlePushRoomChatMessage                                                                     self          _ENV           G @ L@� ƀ@ d@�G @ L@� ��@ d@�F A G@� G�� �   d@ & �    callerUnRegisterPushHandlerCEventPushEnterMatchCEventPushChatMessageToChannelRoomModulesuperDispose                                                         self          _ENV    k      F@ LA�d� ��@ �  ����@ �A�AA � � �A�f ��A � ���B �� �  ���AB ��B�� �  @���@ �A�AA � � �A���� �A�f �AC ��C��� ��C�A  ����@ �D�AA � B �A�f 
�D���A � � ��B �� �A   �
���
 ŉ�AB �AE�E B@��E �F�B �A $��A� �A �AB ��F�A �AG ��� 
����@ ��G�AA � � FBC G��d�� L�d� �B �� �  � ��B �B    ��� ��A �A ��H �I�� �AI�I ����B � �����AC ǁ�䁀 �������AC ǁ�䁀 ǁ������K �����AK ǁ�� A �BL  � @ ��� �� ̂�G�L�B��M� �B  ����@ ��CA $� AC ��L�B ��ƂM �M� ��C�$C���$� F�N G�@��F�@ G���CA �� �C   A� dC�
�ĉGCB L��dC L��� dC�FP �C�dC ����F�N G��@��! ����F�@ G��CA �� �C   A � �D dC�FCC G��d�� L���  �Q A �DR ���� �� ER @ $� A� ]D�dC� �SF�@ G���CA �� �C   A � �D  �A� dC�F�S �� ��dC���F�@ G��CA �� �C   A dC�FCC G��d�� L���  �Q AD �DR ���� �� ER @ $� A� ]D�dC�  ���
�K�
 E���@ ��G�BA � � �B�f & � S   AsyncRequestResNewm_login_lockLogwarnKey login room lock is lockedsvrIdIsLogincallerHasAuth  already pass login room verifySetSuccGameGlobal
GameLogicClientInfofatal  login room client info is nullisLogin SetPipe2Conn	NetTokenNetTokenTypeTOKEN_ROOMRMgateway	LostAuth
curTaskIdGetCurTaskIddebug	 player 
GetOpenId reconn to  login room to NetMessageFactoryGetInstanceCreateMessageCEventRequestLoginVerifym_is_loginm_client_infom_login_infomsdkAuthorityInfom_group_authauthEnum_Login_Step E_Login_Step_RequestLoginVerify        �      CallSetCallErrresSucc login room room reply failed CEventReplyLoginVerifymsg
SetResultm_ret
GetResultMOBILE_LOGIN_ERRORMOBILE_LOGIN_OK login room , resend request	GainAuthAdjustTimeCSm_server_timeMOBILE_LOGIN_RETRY       	, retry  limitBackToLoginRoomModuleretry limit: LoginRoom[	tostring, ]        times after  msYIELD, resetlogin failed: LoginRoom[ login room end                                                     !   #   #   #   #   #   #   #   #   #   #   #   #   $   $   $   $   $   $   %   %   %   &   (   (   (   (   (   (   )   )   )   )   )   )   *   -   .   .   .   .   .   .   .   /   0   1   1   1   1   1   1   1   1   1   1   1   3   3   3   4   4   4   6   6   7   7   8   9   9   9   9   9   :   :   :   :   :   :   :   :   <   6   =   =   =   =   =   =   >   >   >   ?   ?   ?   ?   ?   @   @   @   @   @   A   A   C   C   D   E   G   G   G   G   G   G   H   H   H   I   I   I   I   J   J   J   J   J   J   J   J   M   M   M   N   N   N   O   O   P   P   P   P   Q   Q   Q   Q   Q   Q   Q   Q   R   S   S   S   T   T   T   U   U   U   U   V   W   W   W   W   X   X   Y   Y   Y   Y   Y   Y   Y   Y   Y   Y   Z   Z   Z   Z   Z   Z   Z   Z   Z   Z   Z   Z   Z   Z   Z   Z   Z   Z   ]   ^   ^   ^   ^   ^   ^   ^   ^   ^   ^   ^   ^   _   _   _   _   _   a   a   a   a   a   a   a   a   b   b   b   b   b   b   b   b   b   b   b   b   b   b   b   b   b   b   d   g   h   i   i   i   i   i   i   j   k      self      TT      svrId      silent      timeout      res     requeste     nLoginStepv     retry_timesw     	retry_msx     
replyInfo~   �   reply�   �   ret�   �      _ENV s   �    8   @ A@A�  $A �@ A$� LAA�  dA�F�A L��d� L��AB d��J� �J����C  � @��� �AC� �A   ��@ ǁ�� �A & �D BD� �� �@ �CA� $B & �_@E��@ �CA� ��]��$B & BA�� $B�& & �    Logdebugsending CEventRequestEnterRoomAsyncRequestResNewSetSuccNetMessageFactoryGetInstanceCreateMessageCEventRequestEnterRoomm_room_to_enterm_player_idCallSuccfatal/RoomModule:EnterRoom failed with !reply:Succ()CEventReplyEnterRoommsg 3RoomModule:EnterRoom failed with replyEvent == nilm_ret        'RoomModule:EnterRoom failed with ret=          8   t   t   t   t   u   u   u   v   v   v   x   x   x   x   x   x   y   z   |   |   |   |   }   }   }   }   ~   ~   ~   ~      �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    8   TT    8   
player_id    8   room_to_enter    8   res   8   request   8   reply   8   replyEvent"   8      _ENV �   �    >   � @ �@��  �@ ��@ FA 䀀�@ �AA $��G�A��J���G�A��BJ���G�A�CJ���LAC�� �B�CC  d������� �A  ���@ �A@� B L��d� �� ��� �A  & � �AE � G���B���@ ����� �A   ��@ �A@�� �A & � ��E �A���EB �A�& �    LogfatalRoomModule:EnterMatch
GetModuleLoginModuleMatchModuleauth
player_idPstIDtokenm_match_to_entervkeym_vkeyLogin
server_idGetSucc8RoomModule:EnterMatch failed due to match:Login failure	, call: GetCallErr, ret: 
GetResultEnterMatch=RoomModule:EnterMatch failed due to match:EnterMatch failureLoading2       d                >   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    >   TT    >   	push_msg    >   login   >   match
   >   res   >      _ENV �   �       � @ �@@��  �@ ��@ � � �� � @ �@� �@ �@A ǀ�䀀 ���GB �  � �@�� @ �@� �@ & � 	   Logfatal&RoomModule:HandleCEventPushEnterMatchCEventPushEnterMatch*HandleCEventPushEnterMatch self:StartTaskGameGlobalTaskManager
StartTaskEnterMatch            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       msg       	push_msg         _ENV �   �       � @ A@ ���̀@@� �@�& �    
GetModuleChatModuleReceiveChatMessage            �   �   �   �   �   �   �      self       msg       chat         _ENV                              
      
               k      s   �   s   �   �   �   �   �   �   �   �   �   �          _ENV