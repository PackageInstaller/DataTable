LuaS �

xV           (w@=@../PublishResources/lua/product/module/mail/mail_module.lua         C    @ A@  ��@ $@�@@  ��@@ l   
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
@ �& �    _classMailModuleGameModuleConstructorInit_DeleteOneMail_SetMailInfoByMailIdGetAllMailDataHaveNewMailCheckHaveNewMailHandleNotifyNewMailHandleNotifyExpiredMailParseAppendixLoadAllMailsRequestSendMailByModuleRequestReadMailRequestDeleteMailRequestBatchDeleteMailRequestReceiveAppendixRequestBatchReceiveAppendixRequestLoadMailPrintAppendix
PrintMail               
   K   
@ �K   
@��K   
@ �
 ��K   
@��& �    m_mail_mapm_collect_mail_mapm_expired_mailhave_new_mail         
               
   
                  self    
                  G @ L@� ƀ@ �@ @  d@�G @ L@� � A AA @  d@�& �    callerRegisterPushHandlerCEventMobileNotifyNewMailHandleNotifyNewMailCEventMobileNotifyExpiredMailHandleNotifyExpiredMail                                                      self          _ENV     6    	'   �   � @ A@ �  ���@ @ ��  @ ��  j�_�@ �� A �@�A@ @ �@��   � @ �A �  ���@ @ ��  @ ��  j�_�@ �� A �@��A @ �@�& �    ipairsm_mail_mapmail_id tableremovem_collect_mail_map         '   !   "   "   "   "   #   #   #   $   $   "   "   (   (   )   )   )   )   )   ,   -   -   -   -   .   .   .   /   /   -   -   3   3   4   4   4   4   4   6      self    '   mail_id    '   delete_index   '   (for generator)      (for state)      (for control)      i   
   v   
   (for generator)      (for state)      (for control)      i      v         _ENV 9   P    
!   _ � � �_ @@ � �@ �  & A@ G�@ $ �G�@@�@ �
� & )�  ��A@ GA $ �G�@@�@ �
� & )�  ��  & & �     ipairsm_mail_mapmail_idm_collect_mail_map         !   :   :   :   :   :   :   ;   ;   >   >   >   >   ?   ?   ?   @   C   >   >   F   F   F   F   G   G   G   H   K   F   F   O   O   P      self    !   mail_id    !   	dataName    !   value    !   (for generator)      (for state)      (for control)      i      v      (for generator)      (for state)      (for control)      i      v         _ENV S   U       G @ �@@ f �& �    m_mail_mapm_collect_mail_map           T   T   T   U      self            X   |    	B   C   � @ �@@ � ��ǁ@_��@��A �A��@� !�� ���A �@ �C � @��A �A��@�  ��� ��AB �  �C � ��  *A�� @ ǀB � ��ǁ@_��@��A �A��@� !�� ���A �@ �C � @��A �A��@�  ��� ��AB �  �C � ��  *A� �   �G�B f  & �    ipairsm_mail_map	appendix tablecount        is_read is_gainm_collect_mail_maphave_new_mail         B   Y   a   a   a   a   b   b   b   b   b   b   b   b   b   b   b   b   d   d   e   e   e   e   e   e   e   e   e   g   a   a   k   k   k   k   l   l   l   l   l   l   l   l   l   l   l   l   n   n   o   o   o   o   o   o   o   o   o   q   k   k   u   u   v   {   |      self    B   
isNewMail   B   (for generator)      (for state)      (for control)      i      v      (for generator)"   =   (for state)"   =   (for control)"   =   i#   ;   v#   ;      _ENV    �        � @ ��@@ �@ & �    HandleNotifyNewMail           �   �   �   �   �      self       bHaveNewMail            �   �    	   
@@�F�@ G�� d�� L � �@A ǀ�d@�& �    have_new_mailGameGlobalEventDispatcher	DispatchGameEventTypeModuleMailNotifyNewMail         	   �   �   �   �   �   �   �   �   �      self    	      _ENV �   �       � � @@  �& � � � 
� ���@ � A��� �@A�A �A�@�& �    expired_mail_vec m_expired_mailGameGlobalEventDispatcher	DispatchGameEventTypeModuleMailNotifyExpiredMail            �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       msg          _ENV �   �    
    �   �& � �   �@@  � �  �� �@� ��@ AAB $B �A �A$� GB�
B�G��
B�\ MB�� ��  j��  & �     pairs       Logerror&MailModule:ParseAppendix error config
RoleAssetNewassetID       count            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   	   self       appendixconfig       appendixlist      (for generator)      (for state)      (for control)      num      asset      ra         _ENV �   �    	/   � @ �@@�� ��@�@ ���� A �@�� �A �� � $� G�A�B �AB_��� �L���� dA��  L��� dA�GAC������A������C ������A��   ��A�
����
���
�Ŋ��ǁD �D � & �    NetMessageFactoryGetInstanceCreateMessageCEventMobileReqMailAsyncRequestResNewCallresCallResultTypeNormal
SetResult��������SetSuccmsgretMailErrorCode
MAIL_SUCC	mail_vecm_mail_mapm_collect_mail_mapcollect_mail_vechave_new_mail          /   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    /   TT    /   request   /   res	   /   reply   /   replyEvent   /      _ENV �   �         & & �                �   �   �      self       TT       receiver_id       
module_id            �      3   � @ �@�� �@ �@$� A�AA $��
� �L�A ��   d� ���AB ǁ�_�� ���� �A��  �A�� �A������CD BD �@�́D G�A�� �� 䁀����CD E �� ��AE G�A�A����G�C�A��  & �    AsyncRequestResNewNetMessageFactoryGetInstanceCreateMessageCEventMobileReadMailmail_idCallresCallResultTypeNormal
SetResult��������SetSuccmsgretMailErrorCode
MAIL_SUCC_SetMailInfoByMailIdis_readMAIL_ERR_MAIL_EXPIRED_DeleteOneMail         3   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �           self    3   TT    3   mail_id    3   res   3   request	   3   reply   3   replyEvent   3   
mail_info%   %      _ENV      
1   � @ �@�� ̀�F�@ 䀀ʀ �AA �A$� L�A ��  �d� ���AB ǁ�_�� ���B �A�& �AC� �A������BG�C�A���CD BD �� �́D GA�A�����CD �D �� �́D GA�A�& & �    NetMessageFactoryGetInstanceCreateMessageCEventMobileDeleteMailmail_idAsyncRequestResNewCallresCallResultTypeNormal
SetResult��������SetSuccmsgretMailErrorCode
MAIL_SUCC_DeleteOneMailMAIL_ERR_MAIL_EXPIRED         1                       	  	  	  	  
  
  
  
  
                                                                 self    1   TT    1   mail_id    1   request   1   res
   1   reply   1   replyEvent   1      _ENV   /   	*   � @ �@@�� ��@�@ ���� A �@�� �A �� � $� G�A�B �AB_��� �L���� dA��  L��� dA�GAC������A������C ���@��A��  � ��A�
��
 ŉ�  & �    NetMessageFactoryGetInstanceCreateMessageCEventMobileDeleteAllMailAsyncRequestResNewCallresCallResultTypeNormal
SetResult��������SetSuccmsgretMailErrorCode
MAIL_SUCC	mail_vecm_mail_maphave_new_mail          *                        !  !  !  !  "  "  "  "  "  #  #  #  $  &  &  &  (  )  )  )  *  *  *  *  *  *  *  *  +  +  ,  .  /     self    *   TT    *   request   *   res	   *   reply   *   replyEvent   *      _ENV 2  P   T   � @ �@�� ̀�F�@ 䀀ʀ �AA �A$� L�A ��  �d� ���AB ǁ�_�� ���B �A�& �AC� �A������BG�C�A���CD BD ���́D GA�� �� �A�́D GA� �� �A��AE�  ���� BE A� �� ���E GCEG���B�������CD F �� ��AF GA�A�ƁF ��� G�C�A�ƁF ���B F�G G���BEd �A  � BE��& �     NetMessageFactoryGetInstanceCreateMessageCEventMobileGetOneMailmail_idAsyncRequestResNewCallresCallResultTypeNormal
SetResult��������SetSuccmsgretMailErrorCode
MAIL_SUCC_SetMailInfoByMailIdis_gainis_readreward_vec       PrintAppendixMAIL_ERR_MAIL_EXPIRED_DeleteOneMailLogdebug%_____________________replyEvent.ret:1_____________________replyEvent.reward_vec.size:tablecount         T   4  4  4  4  4  4  5  6  6  6  7  7  7  7  8  8  8  8  8  9  9  9  :  <  <  <  >  ?  ?  ?  @  @  @  @  @  A  A  A  A  A  B  B  B  B  B  C  C  C  D  D  D  D  D  E  E  E  E  D  G  H  H  H  H  H  I  I  I  L  L  L  L  L  M  M  M  M  M  M  M  M  O  O  O  P     self    T   TT    T   mail_id    T   request   T   res
   T   reply   T   replyEvent   T   (for index)4   :   (for limit)4   :   (for step)4   :   i5   9      _ENV T  {   ]   � @ �@�� ̀�F�@ 䀀ʀ �AA �A$� L�A ��  �d� ���AB ǁ�_�� ���B �A�& �AC� �A������BG�C�A���CD BD � �ǁD�  @��� �D A� �� ��E G�DG���B����@   ��AE�  � ��AE
�����  
�����AE�  � ��AE
���@ ��  
���
@F�ƁF ��� G�C�A�ƁF ���B F�G G����E d �A  ƁF ��� F�G G���BEd �A  � �D��& � !   NetMessageFactoryGetInstanceCreateMessageCEventMobileGetAllMailget_collectAsyncRequestResNewCallresCallResultTypeNormal
SetResult��������SetSuccmsgretMailErrorCode
MAIL_SUCCreward_vec       PrintAppendix	mail_vecm_mail_mapm_collect_mail_maphave_new_mail Logdebug+_____________________________________ret: 2_____________________________________m_mail_map: tablecount0_____________________________________mail_vec:          ]   V  V  V  V  V  V  W  X  X  X  Y  Y  Y  Y  Z  Z  Z  Z  Z  [  [  [  \  ^  ^  ^  `  a  a  a  b  b  b  b  b  c  c  c  d  d  d  d  d  e  e  e  e  d  i  i  j  j  j  k  k  k  m  m  n  p  p  p  q  q  q  s  s  v  w  w  w  w  w  x  x  x  x  x  x  x  x  y  y  y  y  y  y  y  y  z  z  z  {     self    ]   TT    ]   get_collect    ]   request   ]   res
   ]   reply   ]   replyEvent   ]   (for index)*   0   (for limit)*   0   (for step)*   0   i+   /      _ENV }  �      D   f  & �                �  �  �     self            �  �      b@   �� @ �@@��  �@ & � � @ ��@�  A� A� ��� �@�& �    Logfatal
not assetdebugid: assetID	 count: count            �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       asset          _ENV �  �      b@   �� @ �@@��  �@ & � � @ ��@�  A� A� ��� � B� A� ��� �@�& �    Logfatal
not assetwarn	mail_id mail_id sender_id 
sender_id receiver_id receiver_id remain_time remain_time            �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       mail          _ENVC                                           6       9   P   9   S   U   S   X   |   X      �      �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �     �           /    2  P  2  T  {  T  }  �  }  �  �  �  �  �  �  �         _ENV