LuaS �

xV           (w@I@../PublishResources/lua/product/module/quest_chat/quest_chat_module.lua         s    @ A@  ��@ $@�@@  ��@@ l   
@��@@ l@  
@ �@A l�  
@ �@A l�  
@��@A l  
@ �@A l@ 
@��@A l� 
@ �@A l� 
@��@A l  
@ �@A l@ 
@��@A l� 
@ �@A l� 
@��@A l  
@ �@A l@ 
@��@A l� 
@ �@A l� 
@��@A l  
@ �@A l@ 
@��@A l� 
@ �@A l� 
@��@A l  
@ �@A l@ 
@��@A l� 
@ �@A l� 
@��@A l  
@ �@G l@ 
@ �@G l� 
@��@G l� 
@ �@G l  
@��@G l@ 
@ �@G l� 
@��@G l� 
@ �@G l  
@��@G l@ 
@ �@G l� 
@��@G l� 
@ �& � )   _classQuestChatModuleGameModuleConstructorDisposeQuestChatModuleInitUpdateGetPetChatStateFindUnReadCountFindActiveChatID_StatUnReadCount_IsChatWorking_FindSpeakerData_FindChatData_FindTalkData_FindChatDataBySpeakerData_SaveChatData_SaveSpeakerData_Request_PacketRequest_GetActiveChat!Request_GetActiveChatBySpeakerIDRequest_SpeakerHistoryRequest_AllHistoryRequest_UpdateChatAnswerRequest_UpdateSpeakerNameRequest_SetTalkReadedRequest_CompleteChatOnRecvMsg_QuestChatQuestChatModuleHandleQuestChatPushEventInitEachSpeakerUI_GetChatSummaryListUI_GetSpeakerChatUI_GetSpeakerHistoryUI_IsChatEndUI_TestDebugUI_StatCompleteTalkInChatUI_StatCompleteCountGetErrorMsgGetWeChatProxy    $              K   
@ �F�@ L�� �   d��
@��& �    m_mapChatDataweChatProxyWeChatProxyNew                  
   
   
   
   
         self          _ENV           G @ b   � �G @ L@� d@ 
�@�G�@ L � �@A d@�F�A G�� G@� �   d@ & �    weChatProxyDispose callerUnRegisterPushHandler CEventQuestChat_PushSpeakerDataQuestChatModulesuper                                                                  self          _ENV           G @ L@� ƀ@ �@ @  d@�& �    callerRegisterPushHandler CEventQuestChat_PushSpeakerDataOnRecvMsg_QuestChat                                    self          _ENV           & �                      self       deltaTimeMS                '       � @ @� � � @�� ��@ �@& �& & �    _FindChatData QuestChatStatusE_ChatState_NotFind
m_nStatus            "   "   "   "   #   #   $   $   $   &   &   '      self       nSpeakerID       nChatID       
chat_data         _ENV )   0       � @ @� � � ���@ ��  & �@ ��%�&  & �    _FindChatData         _StatUnReadCount           +   +   +   +   ,   ,   -   -   /   /   /   /   0      self       nSpeakerID       nChatID       pFindChatData           2   A    !   � @  � ������� ���  �  � ���@ � �AA� � @��� (��BA�L�A � d��b   �GB�BB   ��f  '���  A�  &�& � 
   _FindSpeakerData         tablecountm_vecChatData       _IsChatWorking
m_nChatID_StatUnReadCount         !   4   4   4   5   5   6   6   6   8   8   8   8   9   9   9   9   ;   ;   <   <   <   <   <   =   =   =   =   =   9   @   @   @   A   	   self    !   nSpeakerID    !   pFindSpeaker   !   nChatCount   !   (for index)      (for limit)      (for step)      i      	chatData         _ENV D   O    
   � @ �@@ǀ� �� ��   @ � (A��� �G�A@��  �� �'��  & �    tablecountm_vecTalkData                
m_bReaded            E   E   E   E   F   G   G   G   G   I   I   J   J   J   K   G   N   O   	   self       	chatData       nTalkCount      nReturn      (for index)      (for limit)      (for step)      i	      	talkData         _ENV R   Z       � � �@@ ǀ� ����� � �@@ ��� � @ �� � �  �   �  & �    
m_nStatusQuestChatStatusE_ChatState_ReadyE_ChatState_Completed            T   T   T   T   T   U   U   U   U   U   W   W   Y   Y   Z      self       	chatData          _ENV ]   _       � @ �@ �  & �    m_mapChatData           ^   ^   ^   _      self       nSpeakerID            d   j       � @ @� 䀀���@ �  & �@ ��� % &  & �    _FindSpeakerData _FindChatDataBySpeakerData           e   e   e   f   f   g   g   i   i   i   i   i   j      self       nSpeakerID       nChatID       pSpeakerData           m   |       @ �� � $�  ��@ �D  f F�@ G���Ad� �A ��B �A��A�BǂA��  �� ���  � & �    _FindChatData tablecountm_vecTalkData       
m_nTalkID            o   o   o   o   p   p   q   q   s   s   s   s   t   t   t   t   v   v   w   w   w   x   t   {   {   |      self       nSpeakerID       nChatID       nTalkID       
pChatData      nTalkCount      (for index)      (for limit)      (for step)      i      	talkData         _ENV �   �    
   � @ �@��� � �  @���  (A��� �GA��  �& '�  & & �    tablecountm_vecChatData       
m_nChatID            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   	   self       pSpeakerData       nChatID       nChatCount      (for index)      (for limit)      (for step)      i      	chatData
         _ENV �   �    
(   @ �� �A@$�  ���F�@ G��A� � dA�G�A L����   @�dA�FAB G���� ��  GB@dA�& �   G�A LA���   @�dA�FAB G���� ��  GB@dA�& �    _FindChatDataBySpeakerData
m_nChatID tableinsertm_vecChatDataweChatProxyAddChatm_nSpeakerIDLogdebug,[QuestChat] AddChat ChatData, nSpeakerID = , nChatID = UpdateChat/[QuestChat] UpdateChat ChatData, nSpeakerID =          (   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    (   pSpeakerData    (   recvChatData    (   nDataSource    (   pChatData_Chat   (      _ENV �   �    h   � @ @�  �& � ǀ� �@ ��$�� ����C  �A �A� ���ǂA�A B�"  @ �C� @ ���  *B�b   
��AB ��B�� ��   ��B ���C B� ����   ���C   GB� � �A�
A���C���A� � ��  �A��B� �B�BD �D ��BB ��D�B�  ��B����@ �E �@� �A & � �C��GA� \��� � hA�GB� G�GB� �� �FBB G���B� � dB�g�FAB GA��A� d� �� ��� ����B� �B̂C @ � � �B����& �    weChatProxy m_nSpeakerID_FindSpeakerDatapairsm_vecChatData
m_nChatIDCfgcfg_quest_chattable
cloneconfm_mapChatData_IsChatWorkingm_randomChat_SaveChatData       ��������
m_nStatus       removeUpdateRolecount         h   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    h   recvSpeakerData    h   nDataSource    h   nSpeakerID   h   pSpeakerData   h   inner   E   (for generator)      (for state)      (for control)      key      value      chatid      (for index)3   ?   (for limit)3   ?   (for step)3   ?   i4   >   (for index)K   W   (for limit)K   W   (for step)K   W   iL   V   nChatCount[   h   (for index)^   g   (for limit)^   g   (for step)^   g   i_   f   	chatDataa   f      _ENV �   �    "   � @ �@�� �@ �� � $� G�@�A �AA_����G�Ab   �L��ǁA��dA�� �L���AB ǁ�dA�@��  f�L���� dA�@���Af�& �    AsyncRequestResNewCallresCallResultTypeNormalmsg
SetResult
m_nResultEnumErrorCode_QuestChatE_Error_QuestChat_FailSetSucc         "   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    "   TT    "   packetRequest    "   res   "   reply   "      _ENV �   �       � @  � AA  �  �   & �    !Request_GetActiveChatBySpeakerID                   �   �   �   �   �   �      self       TT            �         � @ �@�� ̀�F�@ 䀀ʀ �AA �� ��$� b  ����ƁA �A�� �B ���C $C �  jB�& & � 
   NetMessageFactoryGetInstanceCreateMessageCEventQuestChat_GetActiveReqm_nSpeakerID_Request_Packetpairsm_mapQuestChatData_SaveSpeakerData                    �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �          self       TT       nSpeakerID       request      res      	replyMsg      recvPacket      (for generator)      (for state)      (for control)      key      value         _ENV         � @ �@�� ̀�F�@ 䀀ʀ �ʀ���A �� ��$� b   ����B GBB�� �A & & �    NetMessageFactoryGetInstanceCreateMessage"CEventQuestChat_SpeakerHistoryReqm_nSpeakerID
m_nChatID        _Request_Packet_SaveSpeakerDatam_speakerChatData                                           	  	                   self       TT       nSpeakerID       request      res      	replyMsg      recvPacket         _ENV         � @ �@@�� ��@�@ ����@A�̀A @� � �� "  ��@ ��A ���� ��BB @ �C �B ��  *B��  & � 
   NetMessageFactoryGetInstanceCreateMessageCEventQuestChat_AllHistoryReqm_nSpeakerID        _Request_Packetpairsm_mapQuestChatData_SaveSpeakerData                                                                   self       TT       request      res      	replyMsg      recvPacket      (for generator)      (for state)      (for control)      key      value         _ENV   V   X   �@ �A@�� ��@�@ ����� ��������A���B @� � �� "  @�@ �B�ƂB �������C �GC��� �  @��BC ̂�� �B���BD��D �DGE��$C�C�����E �E���C�DEGF���  $C �D CFG��$� �F �G�E L���� dC AC � �C h�FDC L��d� ����	J���J�G���D ��D	�E ��D���E ��E	�GE��EE�F �C� �D gC�� & �    NetMessageFactoryGetInstanceCreateMessage$CEventQuestChat_UpdateChatAnswerReqm_nSpeakerID
m_nChatIDm_nQuestionIDm_nAnswerID_Request_Packet
m_nResultEnumErrorCode_QuestChatE_Error_QuestChat_Succ_FindChatDataDQuestChatData_TalkNew
m_nTalkID
m_bReadedtableinsertm_vecTalkData
m_nStatusweChatProxyAddTalk	m_nCountcountm_vecTalkID        SetInitState                 X                     !  "  #  $  %  %  %  %  &  &  (  )  )  )  )  )  +  +  +  +  ,  ,  .  .  .  /  0  1  1  1  1  1  2  2  4  4  5  6  7  8  9  ;  4  =  =  =  =  ?  ?  @  @  @  @  @  B  B  B  B  D  D  D  E  E  E  F  G  G  G  G  G  I  I  J  K  L  M  N  P  I  B  U  V     self    X   TT    X   nSpeakerID    X   nChatID    X   nQuestionID    X   
nAnswerID    X   request   X   res   X   	replyMsg   X   recvPacket   V   pFindChatData   V   talkAnswer   V   nRecvCount5   V   (for index)?   V   (for limit)?   V   (for step)?   V   i@   U   	talkDataC   U      _ENV X  i   #   @ A@$� �@��@ $��
� �
���L�A ��   d� �  ����A @ 䁀�  @ �����@�B BBA� � �� $B  �GC&���BC �C��& �    NetMessageFactoryGetInstanceCreateMessage%CEventQuestChat_UpdateSpeakerNameReqm_nSpeakerIDm_stSpeakerName_Request_Packet_FindSpeakerDataLogdebug3[QuestChat] 修改SpeakerName时没有找到对应的交互信息
m_nResultEnumErrorCode_QuestChatE_Error_QuestChat_Fail         #   Y  Y  Y  Y  Y  Y  Z  [  ]  ]  ]  ]  ^  ^  `  `  `  a  a  b  b  d  d  d  d  d  d  f  f  f  h  h  h  h  i     self    #   TT    #   nSpeakerID    #   stSpeakerName    #   request   #   res   #   	replyMsg   #   pSpeakerData         _ENV k  �   1   �@ �A@�� ��@�@ ����� ���������A @� � �� "   �@ �B �BBǂ������B   @�� ����  ���BC�ǂC ���@ ���  ��B �D @ ��� �  @ �C����L���� dB�� & �    NetMessageFactoryGetInstanceCreateMessage!CEventQuestChat_SetTalkReadedReqm_nSpeakerID
m_nChatID
m_nTalkID_Request_PacketEnumErrorCode_QuestChatE_Error_QuestChat_Succ
m_nResult_FindTalkData
m_bReadedweChatProxySetTalkReaded_FindChatData
m_nStatusSetSucc         1   l  l  l  l  l  l  m  n  o  p  p  p  p  q  q  s  t  t  t  t  t  v  v  v  v  v  w  w  x  y  y  y  y  y  y  y  |  |  |  |  }  }  ~  ~  �  �  �  �  �     self    1   TT    1   nSpeakerID    1   nChatID    1   nTalkID    1   triggerIndex    1   request   1   res   1   	replyMsg   1   recvPacket   ,   
pTalkData   ,   
pChatData(   ,      _ENV �  �   
   @ A@$� �@��@ $��cA�@ �FAA G��
A�
���LB ��   d� �    �� �A�C� �A�f & � 
   NetMessageFactoryGetInstanceCreateMessageCEventQuestChat_CompleteReq
m_nStatusQuestChatStatusE_ChatState_Completed
m_nChatID_Request_PacketSetSucc            �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       TT       nChatID       nStatus       request      res      	replyMsg      recvPacket         _ENV �  �   
   � @ �@@��� ��@�@ A@  �� �@�& �    GameGlobalTaskManager
StartTaskQuestChatModuleHandleQuestChatPushEvent         
   �  �  �  �  �  �  �  �  �  �     self    
   msg    
      _ENV �  �   \   � @ @�  �& � ǀ@ �   ����@ � �� �@�G�@ 䀀������A  � �@ ��@ � �� �@�G�@ 䀀��� ���A  � �@ ��� B @� � �@ @�� @ �@�G�B䀀
� �ǀ@ �   @���@ � �� �@�G�@ 䀀��@���@ � �� �@�G�@ 䀀��� ���A  � �@ ��
@@�� �� B @� � �@ ��B � �䀀 �@�A� 䀀�   @��B �C$�� D�AD ��D$A��B �C$�� D�AD ��D$A�& �    weChatProxy allHistoryTaskIdTaskHelperGetInstanceIsTaskFinished YIELDInitEachSpeakerInitAllLocalSpeakerm_persistidGameGlobalUIStateManagerIsShowUIMainLobbyControllerEventDispatcher	DispatchGameEventTypeUpdateWeChatRedUpdateWeChatMainTalk         \   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    \   TT    \   msg    \   isShowK   \      _ENV �  �   E   � @ �@    �& � �   A@ G�@$��G@ L����A@ d��b  �� @�� ���A ��A�� �B ����@B� ���B �� �B ����B �C�� ��B�)�  ����  ����F�A L��d� LA���d��bA  � �F�B �� dA ��FA@ ��@d ���C  �AC �B �@ ��C�GC��B i�  ��& �    weChatProxypairsm_mapQuestChatDataInitLocalSpeakerm_persistid        TaskHelperGetInstanceIsTaskFinished YIELDtableinsertIsAllTaskFinished_SaveSpeakerDataUpdateRoleNamem_nSpeakerIDm_stSpeakerName         E   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    E   TT    E   msg    E   waitHistoryTaskId   E   (for generator)   &   (for state)   &   (for control)   &   nSpeakerID	   $   speakerData	   $   taskId   $   count'   E   (for generator)8   D   (for state)8   D   (for control)8   D   nSpeakerID9   B   speakerData9   B      _ENV �  �      & �                �     self            �  �      & �                �     self       nSpeakerID       nChatID            �  �      & �                �     self       nSpeakerID            �     
6   � @ �@@�@ � �����@ � �A @� �@��   �  ǀA�A ���� $�  �@�GAB L���� � d� @�@ �C� f F�@ G���A ��  @�dA�C  f GAC��C ��C ��@ �C  f GAC��C �D @@ �C  f C� f & �    Cfgcfg_quest_chat Logerror5[Quest_Chat] UI_IsChatEnd中发现错误的ChatID = 
SpeakerID_FindChatDataweChatProxyIsChatInHistoryinfo, SpeakerID = 
m_nStatusQuestChatStatusE_ChatState_CompletedE_ChatState_Taken         6   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �                               self    6   nChatID    6   cfgChat   6   nSpeakerID   6   pFindChatData   6      _ENV       #   A   �@  ��     ���@�FA GA�� ��dA�F�A G��G��_@�� ��@�_� �  ���A� � �� h�G��B �C�� �BC,  �B�^ �^��gA�& �    �      ^v      1_�            tableinsertCfgcfg_quest_talk 	NextWord       TaskManagerGetInstance
StartTask              	   E   L � �   � E ��� d@�& �    Request_SetTalkReaded    	    	                        TT    	      selfnSpeakerIDnChatIDnTalkIDi#   	  
                                                                        self    #   nSpeakerID   #   nChatID   #   nFindTalkID   #   listTalkID   #   
pFindTalk      (for index)   "   (for limit)   "   (for step)   "   i   !   nTalkID          _ENV #  H   7   � @ �@��@��@  ���@ �@A �� $A�  & A�G�A L��� d��b  �����  ���A  AB ��ǂ�  ����@  �G��b  ���C ��D ����D��   ��C	��	@�EC	"  @�� & � ����  ����& �    Cfgcfg_quest_chatLogerror5###[QuestChatModule] cfg_quest_chat is nil ! id --> 
SpeakerIDweChatProxyGetRolechats       chatIdtalkstalkIdreaded         7   $  $  $  %  %  &  &  &  &  &  '  '  )  *  *  *  *  +  +  ,  -  -  .  .  .  .  /  0  0  1  2  2  3  4  4  5  5  5  5  6  7  7  8  9  9  :  :  :  ;  ;  <  5  A  .  H     self    7   chaitd    7   talkid    7   cfg   7   
speakerid   7   role   7   chats   6   (for index)   6   (for limit)   6   (for step)   6   i   5   chat   5   _chatid   5   talks!   5   (for index)&   4   (for limit)&   4   (for step)&   4   j'   3   talk(   3   _talkid+   3      _ENV K  a   (   �   �@@ ǀ���  ��  A @�$@�_@ �� �GBA@�  �L�Ad� �A �������AB DB!�@���AB �B! �  ���B��  *��@ �@ �)�  ����  & �            weChatProxyroles pairs
speakerId	GetChatsstateQuestChatStatusE_ChatState_CompletedE_ChatState_Taken                (   L  M  M  N  N  O  Q  Q  Q  Q  R  R  R  R  R  S  S  T  T  T  T  U  U  U  U  U  V  V  V  V  V  W  T  T  [  [  Q  Q  `  a     self    (   nFindSpeakerID    (   nCount   (   role   (   (for generator)	   &   (for state)	   &   (for control)	   &   vid
   $   speakerData
   $   chats   $   (for generator)   "   (for state)   "   (for control)   "   key       value          _ENV d  q   $   �  � @ �@��@ �@A $� � �� @ �@��@ �@A� $� � �� @ ����@ �@A $� � �� @ �@��@ �@A� $� � ��@ ���@ � & �  & �    EnumErrorCode_QuestChatE_Error_QuestChat_SuccStringTableGet str_extra_mission_error_successE_Error_QuestChat_Unknownstr_extra_mission_error_failE_Error_QuestChat_SpeakerName%str_guide_ROLE_ERROR_CHANGE_NICK_SPE"E_Error_QuestChat_SpeakerNameWord str_guide_ROLE_ERROR_DIRTY_NICK Unknown ErrorCode         $   e  f  f  f  f  f  f  f  g  g  g  g  g  g  g  h  h  h  h  h  h  h  i  i  i  i  i  i  i  l  m  m  n  n  p  q     self    $   nErrorCode    $   vecErrorMsg   $   stErrorMsg   $      _ENV s  u      G @ f  & �    weChatProxy           t  t  u     self           s                                                             '       )   0   )   2   A   2   D   O   D   R   Z   R   ]   _   ]   d   j   d   m   |   m   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �     �                 V    X  i  X  k  �  k  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �    �         #  H  #  K  a  K  d  q  d  s  u  s  u         _ENV