LuaS �

xV           (w@M@../PublishResources/lua/product/components/ui/ui_chat/chat_data_manager.lua         4    @ A@  ��@ $@�@@  ��@@ l   
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
@��& �    _classChatDataManagerObjectConstructorSendMessageReceiveMessageAddChatDataDeleteChatDataGetChatDataRequestChatDataPushCurStoreMaxMsgId_RemoveChatDataGetAllChatDatas_ReadLocalChatDatas_RefreshChatDataTimeStatus_ReadServerChatDatasSaveAllChatDatas_GetChatDataKey                  
@@�
@@�& �    _chatDatas _chatDataKey                       self               !    4   �@ �A��@ � ���� ��  @�� $�A�� �   ��BA ��A��G��C�ǃ�� G���� �C @�� �B �BC @��B�����C�� ��C ��� ��@ �BD��� ��D�D E@��B � ��BE�C$ �B  & �    GameGlobal
GetModuleSocialModuleSendFriendMsgGetSucc	ChatDataNewmsg_idfriend_msg_typechat_message	emoji_id
chat_timeAddChatDataReceiveMessage
GetResultSocialErrorCodeSOCIAL_CHAT_PEER_NOT_FRIENDEventDispatcher	DispatchGameEventTypeChatFriendNotYourFriendHandleErrorMsgCode         4                                                                                                                                                            !      self    4   TT    4   chatFriendManager    4   	friendId    4   messageType    4   message    4   emojiId    4   socialModule   4   res   4   msgInfo   4   	chatData         _ENV $   &    
   � @ �@@��� ��@�@ A@� �� �@�& �    GameGlobalEventDispatcher	DispatchGameEventTypeReceiveChatMessage         
   %   %   %   %   %   %   %   %   %   &      self    
   	friendId    
      _ENV *   <    '   � @ �@�@�� �� @   � � �   @ A  A�  � ��  h��G@ GB�G������ ��@� �@ �� �   �g���@   �G@ GA��@ �A � ��@J� LA dA & �    _chatDatas        GetId_RefreshChatDataTimeStatus        '   +   +   +   +   ,   ,   ,   .   /   /   /   0   0   0   0   2   2   2   3   3   3   3   3   3   4   4   0   8   8   9   9   9   9   9   9   9   :   :   <   
   self    '   	friendId    '   	chatData    '   hasContain   '   
chatCount   '   (for index)      (for limit)      (for step)      i      tempChatData           ?   D    
   b   � �� @ �@ �@    �& � � @ �@� & �    _chatDatas         
   @   @   @   @   @   @   A   C   C   D      self    
   	friendId    
        G   P       � @ �   @ �b@  @ ��   �  �@@  � ����   @ �̀@ �@ � @ �@��  & �    _chatDatas_RemoveChatData_RefreshChatDataTimeStatus           H   H   H   H   H   I   I   K   K   K   L   L   M   M   O   O   O   P      self       	friendId       success
           S   t    ;   @ A@F�@ $� L�@��  �d� ��� �   ��  ��� B A� �A�ǂ�A B�C�ǃ���G��  �D�$� L�C ��  dC ����C@��A� ��DLB�d �A  & � �@ ǁ�䁀 ���FE GB��A�́E �A ��E @��A��F @����  & �    GameGlobal
GetModuleSocialModuleSelectChatFriendGetSucc       ��������	ChatDataNewmsg_idfriend_msg_typechat_message	emoji_id
chat_timeAddChatDataResetFriendUnReadMessageStatusHandleErrorMsgCode
GetResultEventDispatcher	DispatchGameEventTypeUpdateUnReadMessageStatusSaveAllChatDatasPushCurStoreMaxMsgIdGetChatData         ;   V   V   V   V   X   X   X   X   Y   Y   Y   Y   Z   Z   [   [   [   [   ]   ^   ^   ^   _   `   a   b   c   ^   d   d   d   d   [   g   g   g   g   i   i   i   i   j   m   m   m   m   m   m   m   o   o   q   q   q   s   s   s   s   t      self    ;   TT    ;   chatFriendManager    ;   	friendId    ;   socialModule   ;   res   ;   msgList   ;   (for index)   !   (for limit)   !   (for step)   !   i       	chatInfo       	chatData          _ENV v   �    	   � @ �@ �@    �& � � @ �@ �  !@@  �& � ��@ ��@� A �� � @ �@�@ A  � �AA�� ́�� $A  & �    _chatDatas        GameGlobal
GetModuleSocialModulePushCurStoreMaxMsgIdGetId            w   w   w   w   x   z   z   z   z   z   {   ~   ~   ~   ~   �   �   �   �   �   �   �   �   �   �   �   �      self       senderPstId       socialModule      	chatData         _ENV �   �       � @ �@ �@    �& � � @ �@ �  �@@ ǀ����� �!� @ �  & � @ ��  �A hA�F�A G���@ �B � dB�g�C� f & �    _chatDatasCfgcfg_friend_global       client_save_max_msg_count��������tableremove            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   	   self       	friendId       
chatCount      	maxCount      
moreCount      (for index)      (for limit)      (for step)      i         _ENV �   �    	   �   
� ��@@ @ �@�̀@ @� �@�& �    _chatDatas_ReadLocalChatDatas_ReadServerChatDatas        	   �   �   �   �   �   �   �   �   �      self    	   TT    	   friendList    	        �   �    Z   � @ �� �@@ ǀ����  � �   @ � �  �& � AA A� ��]��$� �A��FB GA����� � d� � �FB GA����  d� � �FAA �� ����d�  �K  _�A� �� ��� @ �  �AC  ����  @� � $��"   ��C ��A� ��C K  
C� \��� (�ăFD LD�ǄD�DGE�EEǅE�Ed� ��C ��	ǄC Ǆ�	��	���	�D�	'C��  j���F �A & �    _GetChatDataKeyUnityEnginePlayerPrefs
GetStringloadreturn stringgsub\\\
pairs_chatDatas       	ChatDataNew_id_messageType	_message	_emojiId_isSelf_date_RefreshChatDataTimeStatus         �   �    	   "@  @ ��   �  � @ �   � @��A@� �� @ ��� � ��  *���   �  & �    pairsGetFriendId            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      friendDatas       	friendId       (for generator)      (for state)      (for control)      k      v         _ENVZ   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    Z   friendList    Z   chatDataKey   Z   localChatDatasStr   Z   func   Z   chatDataTable(   Z   isContainFriendIdFunc.   Z   (for generator)1   W   (for state)1   W   (for control)1   W   	friendId2   U   
chatDatas2   U   (for index)B   U   (for limit)B   U   (for step)B   U   iC   T   dataD   T   	chatDataM   T      _ENV �   �    >   F @ �@@ d ���  ��  �A�  ��ǂ��@ ����� $C��� 
��@�FA �CA�� �C�� d�  b  ����A �CA� ��  ƃA D�$ �  �AG�����B��	�DB	�D	�	!�� ����C� �D��������C  �D�� ����� �C����A�i�  ��& �    pairs_chatDatas       SetShowTimeStatusSameDayGetDate_timeminhour<                       >   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    >   (for generator)   =   (for state)   =   (for control)   =   	friendId   ;   
chatDatas   ;   
firstData   ;   (for index)   ;   (for limit)   ;   (for step)   ;   i	   :   	chatData
   :   preChatData   :   
isSameDay   :   preDate   5   curDate#   5   preMin$   5   curMin%   5   min+   5      _ENV �   �       & �                �      self       TT            �   
   7   L @ d� �@@ �   @���@ ��@�@@ �� ! A@��@A ��A��A� � �@ & � � B �@@ � ���A  AB � �ǂ̂��B �����  *A���B �@@ �� � B A@ � ��B \��B (� �ÂC$C '���  jA��@A ǀ��@� � @ �@�& �    _GetChatDataKey_chatDatastablecount        UnityEnginePlayerPrefs
DeleteKeypairs       EncodeMessageecho_not_escapeDecodeMessage
SetString         7   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �            �   �   �                                     	  	  	  	  	  	  
     self    7   chatDataKey   7   (for generator)      (for state)      (for control)      k      v      (for index)      (for limit)      (for step)      i      chatDatasStr"   7   (for generator)%   0   (for state)%   0   (for control)%   0   k&   .   v&   .   (for index))   .   (for limit))   .   (for step))   .   i*   -      _ENV         G @ b   @ �G @ f  F@@ G�� ��@ d� � � �� �@   � �
� ��  & �    _chatDataKeyGameGlobal
GetModuleRoleModule	GetPstIdCHAT_DATA_KEY_1VERSION                                                 self       roleModule	      pstId      chatDataKey         _ENV4                                 !      $   &   $   *   <   *   ?   D   ?   G   P   G   S   t   S   v   �   v   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   
  �                  _ENV