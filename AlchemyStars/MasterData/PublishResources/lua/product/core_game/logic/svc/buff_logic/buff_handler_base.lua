LuaS �

xV           (w@V@../PublishResources/lua/product/core_game/logic/svc/buff_logic/buff_handler_base.lua         g    @ A@  $@  @ A�  $@ �@ A  �@A $@� A   � A l   
@ � A l@  
@�� A l�  
@ � A l�  
@�� A l  
@ � A l@ 
@�� A l� 
@ � A l� 
@�� A l  
@ � A l@ 
@�� A l� 
@ ��@ A@ � A $@�@D  ��@D l� 
@ �@D l  
@ ��@ A� � A $@��D  ���D l@ 
@ ��D l� 
@ ��@ A  � A $@� E   � E l� 
@ � E l  
@ ��@ A@ � A $@�@E  ��@E l@ 
@ �@E l� 
@ ��@ A� � A $@��E   ��E l� 
@ �& �    requiretrigger_basetrigger_owner_classBuffHandlerBaseITriggerOwnerConstructorAttachDetach
SetActive
DoOverlapGetTriggerGetTriggerTypeGetNotifyTypeGetOwnerEntity	GetWorldPrintBuffHandlerLogBuffLoadHandler
OnTriggerBuffUnloadHandlerBuffActiveHandlerBuffDeactiveHandlerBuffExecuteHandler                  
@ �A� $� 
 �L�@� d����@B ������@  � � 䁀
���AB@� ��� 
��́B �A & �    _buffInstanceWorld_worldGetServiceTrigger
BuffLogic	_triggerCreateTrigger_logicCreateBuffLogicAttach           	   
   
                                                                     self       buffInstance       triggerCfg       	logicCfg       world      triggerSvc      bufflogicSvc
                  
   G @ L@� d� L�� ��  d��� � AA �@�& �    _buffInstanceWorldGetServiceTriggerAttach	_trigger        
                                    self    
   svc   
           #    
   G @ L@� d� L�� ��  d��� � AA �@�& �    _buffInstanceWorldGetServiceTriggerDetach	_trigger        
   !   !   !   !   !   !   "   "   "   #      self    
   svc   
        %   '       � @ �@@ � �@�& �    	_trigger
SetActive           &   &   &   &   '      self       active            )   F    K   � @ �   ��b    ��@@ @ � ���@ ��  ��� $B  BA �A$� L�A� �BB��B C$� ���C $� �C$� ����$� ��dB�LB�ǂ�   d� b   ���D ��D�C $� �C$� G�B L�d� ���� �CE ����  ����̂EG�B L�d �B  ��EA �B��BA �B�� ̂�F�F G��C � �B��  j��& �    _logicipairsPrintBuffHandlerLogbuff logic overlap ---- GetLogicName_worldGetSyncLoggerTracekeybuffOverlapbuffID_buffInstanceBuffID	entityIDGetOwnerEntityGetIDlogic
DoOverlapDataBuffLogicResultNewBuffSeqNTBuffLoad
SetBuffIDSetLogicTypeOverlapEventDispatcher	DispatchGameEventTypeDataLogicResult                 K   *   *   *   *   *   +   +   +   +   ,   ,   ,   ,   ,   -   -   -   .   .   0   1   1   1   1   2   2   2   2   2   3   3   3   .   6   6   6   6   7   7   9   9   :   :   :   :   ;   ;   ;   <   <   =   =   =   ?   9   @   @   @   @   @   A   A   A   B   B   B   B   B   B   B   B   B   +   +   F      self    K   logicParam    K   context    K   (for generator)   J   (for state)   J   (for control)   J   i	   H   logic	   H   logger   H   buffResult%   H   res7   H      _ENV H   J       G @ f  & �    	_trigger           I   I   J      self            L   N       G @ L@� e  f   & �    	_triggerGetTriggerType           M   M   M   M   N      self            P   R       G @ L@� e  f   & �    	_triggerGetNotifyType           Q   Q   Q   Q   R      self            T   V       G @ L@� e  f   & �    _buffInstanceEntity           U   U   U   U   V      self            X   Z       G @ L@� e  f   & �    _buffInstanceWorld           Y   Y   Y   Y   Z      self            \   `      G @ b    �G @ L@� d� b   � �F�@ G�� �   d@  & �    _worldIsDevelopEnvLogdebug            ]   ]   ]   ]   ]   ]   ]   ]   ^   ^   ^   ^   `      self          _ENV e   f       & �                f      self            h   �    m   � @ �    ��@@ ̀�� ��� $A�A���A ��A � ��� $A  AB G@ $��L�B �� C$ dB  GB@ LB�d� ��� 
ćG�A L��d� 
C��L�A d� L�d� 
C��LCd� 
C��B��B� �@ �B ���  �B���E � @ ������  ���F   � @�� �̂�@ �B�b   @��  ����F ��L�A d� L�d� ��A �CG�� �C�  � @ � � ����A ��D� $C  ��� $C�C@ CH$� �H��H �I�C	  �$C�̂��B )�  �A���$A & � (   _logic_worldGetDetailMatchLoggerBeginTriggerLogic加载逻辑RecordBuffInstance_buffInstanceGetOwnerEntityGetIDipairsPrintBuffHandlerLogbuff load trigger logic ---- GetLogicNameGetSyncLoggerTracekey	buffLoadbuffIDBuffID	entityIDlogicRecordTriggerLogicRecordBuffLogicDoLogictypetableRecordBuffResultDataBuffLogicResultNewBuffSeq
SetBuffIDSetLogicTypeLoadEventDispatcher	DispatchGameEventTypeDataLogicResult        EndRecordTriggerLogicEndTriggerLogic         m   i   i   i   k   k   k   l   l   l   m   m   m   m   m   m   m   n   n   n   n   o   o   o   o   o   p   p   p   q   q   s   t   t   t   t   u   u   u   u   u   v   v   v   q   y   y   y   y   z   z   z   {   {   {   {   {   |   |   |   |   |   |   |   }   }   }               �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   n   n   �   �   �      self    m   notify    m   	triggers    m   detailLogger   l   (for generator)   j   (for state)   j   (for control)   j   index   h   logic   h   logger   h   buffResult8   h   resU   f      _ENV �   �       & �                �      self            �   �    q   � @ �   ���@@ ̀�� ��� $A�A���A ��A � ��� $A  AB G@ $��L�B �� C$ dB  GB@ LB�d� ��� 
ćG�A L��d� 
C��L�A d� L�d� 
C��LCd� 
C��B��B� �@ �B ���  �B���E � @ �� �  ���F   � @�� �̂�@ �B�b   @��  ����F ��L�A d� L�d� ��A �CG�� �C�  � @ � � ����A ��D� $C  ��� $C�C@ CH$� �H��H �I�C	  �$C�̂��B )�  �����$A ǀA � �@� �� �@ & � (   _logic_worldGetDetailMatchLoggerBeginTriggerLogic卸载逻辑RecordBuffInstance_buffInstanceGetOwnerEntityGetIDipairsPrintBuffHandlerLog buff unload trigger logic ---- GetLogicNameGetSyncLoggerTracekeybuffUnloadbuffIDBuffID	entityIDlogicRecordTriggerLogicRecordBuffLogicDoLogictypetableRecordBuffResultDataBuffLogicResultNewBuffSeq
SetBuffIDSetLogicTypeUnloadEventDispatcher	DispatchGameEventTypeDataLogicResult        EndRecordTriggerLogicEndTriggerLogic         q   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    q   notify    q   	triggers    q   detailLogger   k   (for generator)   i   (for state)   i   (for control)   i   index   g   logic   g   logger   g   buffResult7   g   resT   e      _ENV �   �       & �                �      self            �   �    p   � @ �@�C� �@�ǀ@ �   ����@ � �� A��� $A����@ �B � �A�� $A  �B G�@ $��L�B � CC$ dB  G�@ L��d� ��� 
CD�G@ L��d� 
C�LB d� LC�d� 
C�LCCd� 
C���B���� �@ �B ���  �B��F � @ �� �  ���BF   � ��� ����@ �B�b   @��  ���G �B�LB d� LC�d� �@ ��G�� �CC�  � @ � � ���@ ��D� $C  ��C $C��@ �H$� �H�I �CI��	  �$C�����B )�  ����$A & � )   _buffInstance
SetActive_logic_worldGetDetailMatchLoggerBeginTriggerLogic激活逻辑RecordBuffInstanceGetOwnerEntityGetIDipairsPrintBuffHandlerLog buff active trigger logic ---- GetLogicNameGetSyncLoggerTracekeybuffActivebuffIDBuffID	entityIDlogicRecordTriggerLogicRecordBuffLogicDoLogictypetableRecordBuffResultDataBuffLogicResultNewBuffSeq
SetBuffIDSetLogicTypeActiveEventDispatcher	DispatchGameEventTypeDataLogicResult        EndRecordTriggerLogicEndTriggerLogic         p   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    p   notify    p   	triggers    p   detailLogger
   o   (for generator)   m   (for state)   m   (for control)   m   index   k   logic   k   logger    k   buffResult;   k   resX   i      _ENV �          & �                      self              .   p   � @ �@�C  �@�ǀ@ �   ����@ � �� A��� $A����@ �B � �A�� $A  �B G�@ $��L�B � CC$ dB  G�@ L��d� ��� 
CD�G@ L��d� 
C�LB d� LC�d� 
C�LCCd� 
C���B���� �@ �B ���  �B��F � @ �� �  ���BF   � ��� ����@ �B�b   @��  ���G �B�LB d� LC�d� �@ ��G�� �CC�  � @ � � ���@ ��D� $C  ��C $C��@ �H$� �H�I �CI��	  �$C�����B )�  ����$A & � )   _buffInstance
SetActive_logic_worldGetDetailMatchLoggerBeginTriggerLogic失活逻辑RecordBuffInstanceGetOwnerEntityGetIDipairsPrintBuffHandlerLog"buff deactive trigger logic ---- GetLogicNameGetSyncLoggerTracekeybuffDeactivebuffIDBuffID	entityIDlogicRecordTriggerLogicRecordBuffLogicDoLogictypetableRecordBuffResultDataBuffLogicResultNewBuffSeq
SetBuffIDSetLogicType	DeactiveEventDispatcher	DispatchGameEventTypeDataLogicResult        EndRecordTriggerLogicEndTriggerLogic         p                             	  	  	  	  	  	  	  
  
  
  
                                                                                                                            !  "  $    %  %  %  %  %  &  &  &  '  '  '  '  '  '  '  '  '  )  )  
  
  ,  ,  .     self    p   notify    p   	triggers    p   detailLogger
   o   (for generator)   m   (for state)   m   (for control)   m   index   k   logic   k   logger    k   buffResult;   k   resX   i      _ENV 4  ^   l   � @ �   ���@@ ̀�� ��� $A�A���A ��A � ��� $A  AB G@ $��L�B �� C$ dB  GB@ LB�d� ��� 
ćG�A L��d� 
C��L�A d� L�d� 
C��LCd� 
C��B��B� �@ �B ���  �B���E � @ �� �  ���F   � @�� �̂�@ �B�b   @��  ����F ��L�A d� L�d� ��A �CG�� �C�  � @ � � ����A ��D� $C  ��� $C�C@ CH$� �H��H �I�C	  �$C�̂��B )�  �����$A & � (   _logic_worldGetDetailMatchLoggerBeginTriggerLogic执行逻辑RecordBuffInstance_buffInstanceGetOwnerEntityGetIDipairsPrintBuffHandlerLogbuff exec trigger logic ---- GetLogicNameGetSyncLoggerTracekey	buffExecbuffIDBuffID	entityIDlogicRecordTriggerLogicRecordBuffLogicDoLogictypetableRecordBuffResultDataBuffLogicResultNewBuffSeq
SetBuffIDSetLogicTypeExecEventDispatcher	DispatchGameEventTypeDataLogicResult        EndRecordTriggerLogicEndTriggerLogic         l   5  5  5  7  7  7  8  8  8  9  9  9  9  9  9  9  :  :  :  :  ;  ;  ;  ;  ;  <  <  <  =  =  ?  @  @  @  @  A  A  A  A  A  B  B  B  =  E  E  E  E  F  F  F  G  G  G  G  H  H  H  H  H  H  H  I  I  I  K  K  K  K  M  M  N  N  N  N  O  O  O  P  P  Q  R  T  M  U  U  U  U  U  V  V  V  W  W  W  W  W  W  W  W  W  Y  Y  :  :  \  \  ^     self    l   notify    l   	triggers    l   detailLogger   k   (for generator)   i   (for state)   i   (for control)   i   index   g   logic   g   logger   g   buffResult7   g   resT   e      _ENVg                                                            #      %   '   %   )   F   )   H   J   H   L   N   L   P   R   P   T   V   T   X   Z   X   \   `   \   c   c   c   c   d   d   e   f   e   h   �   h   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      �     .    1  1  1  1  2  2  4  ^  4  ^         _ENV