LuaS �

xV           (w@j@C:/depot_matchsrpg/matchsrpg/b/170/client/Assets/../PublishResources/lua/framework/base/task_manager.lua         h   �  
@@�
�@�
@A�F�A �� �   d@�F B �@ ƀB d@�F@B @��F@B �   J���F@B �@  J� �F@B ��  J���F B �� ��C d@�F�C @ �F D G@� ��C ��  ������C �  ������C �@ �� ���C � ������C �� �� ���C �  ������C �@ �� ���C � ������C �� �� ���C �  ������C �@ �� ���C � ������C �� �� ���C �  ������C �@ �� ���C � ������ � ��  ����@ � ��� ����� � ��  ����@ � ��� ����� � ��  ����@ � ��� ���& � ,   Running       Suspend       Stop       _enum
TaskState_classTaskObjectConstructorJoinUpdateTaskManager
Singletontableunpack	FindTask
StartTaskStartStoppableTaskStartTaskInternalCoreGameStartTaskIsAnyCoreGameTaskKillCoreGameTasks	KillTaskKillAllTasksWaitCoreGameTaskFinishSuspendTaskResumeTaskExpirationYieldStopTaskUnSafeGetCurTaskGetCurTaskIdYIELDYIELD_FRAMESUSPENDRESUMEJOINYieldInternalSuspendInternalResumeInternalJoinInternalJOIN_TASK_ARRAY               
   
@ ��@ �@@ $� 
 ��A� 
 �
� �& �    idco
coroutinecreatestateRunningtoken          
                                    self    
   id    
   func    
   token    
      _ENV
TaskState    &       � @ �@@�� ��@ � ����@    �& � ��@�@  @ ��   ������@A �@A
@ �� @ �@�� ���GA �@�& �    TaskManagerGetInstance	FindTask
joinTasksid       joinedTaskIDSuspendTask                                                        "   "   "   $   %   %   %   %   %   %   &      self       id       task         _ENV )   D   N   F @ L@� d� G�� � @ �@@�� �  ���@ � A�@A -  ��  @ A@$� 
A ��   @��@ �AGAA $� �A@�B "  � �B GAB ��B $A��B "  ��C G�B �  @�F@ LB�d� LB���dB�)�  ����� 
 �  & � & D AD$�� �D��D �E$A�D AE$�� �E$A �E FGAA ��$���  AF �F@�$A   & & �    TaskManagerGetInstancecurTask
coroutineresumecostatusdeadfinishCallbackdataid
joinTasksnextResumeTaskstateStopGameGlobalEventDispatcher	DispatchGameEventType
TaskErrorGameRecorderStopRecorddebug
tracebackLog
exception          N   *   *   *   *   +   +   +   +   -   -   -   -   -   .   .   .   .   /   /   0   0   0   0   0   0   1   1   1   2   2   2   2   4   4   4   5   5   5   5   6   6   6   6   6   6   5   5   9   9   :   :   <   <   ?   ?   ?   ?   ?   ?   ?   @   @   @   @   @   A   A   A   A   A   A   B   B   B   B   C   C   D   	   self    N   	lastTask   N   ret   N   msg   N   (for generator)&   /   (for state)&   /   (for control)&   /   id'   -   _'   -      _ENV
TaskState P   g       K   
@ �K   
@��K   
@ �
 ��F�A L�� d� 
@��F@B L�� d� 
@ �K   
@ �K   
@��
 A�
�Æ
�Ç& �    tasks	runningsnewRunningsseq        TT
TaskTokenNewSTStoppableTaskTokenyieldEvents_coreGameTaskIDs_lastLogTaskListTick_timer curTask            R   R   T   T   V   V   W   X   X   X   X   Y   Y   Y   Y   \   \   _   _   `   c   f   g      self          _ENV k   �    	C   G @ \ �  @�� �A�  � @ �  !�� �	�� @ �@ ��@ ǀ��   @���A�$��
�A�"A  @�G�@ J�AFB GA��@ � dA�FB GA���B � dA�N�� ��G���� ����N�� @�B ABG@ � $A�N�� M�� ��G@C \ �  @�� ���  � � �  �@��B ��C�@ BC B�A�� ��   
���& �    	runnings               tasksUpdatetokencurTask tableremovev_coreGameTaskIDsstateSuspendnewRunningsinsert          C   l   l   l   l   m   n   n   n   n   o   o   p   p   q   q   r   r   r   s   t   t   u   u   w   w   w   w   w   x   x   x   x   x   y   y   z   z   z   z   {   |   ~   ~   ~   ~   ~      �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   
   self    C   i   1   id   0   task   0   ret   (   total3   C   (for index)8   @   (for limit)8   @   (for step)8   @   i9   ?      _ENV
TaskState �   �       � @ �@ �  & �    tasks           �   �   �   �      self       id            �   �      � @  � GA@ �  �   �   & �    StartTaskInternalTT           �   �   �   �   �   �   �      self       func            �   �      � @  � GA@ �  �   �   & �    StartTaskInternalST           �   �   �   �   �   �   �      self       func            �   �   L   � @ �@� ��  ��@  
� ��@ A����   $��K  �A  �� - "B    ��  �A  @ �J� �A@B  FBA �� �  d�  �B  (��CA @��  $�  J�A@�  � �@�@ �J� �A@'���A BGBB ��$B��B 
��B�� ��C  F�A G���d �  $�  "B   �F�A GB��BB ��dB�G�B J��A� f FD b  ���  & �    seq               TaskNewselect#tableinsertnewRunningstasksUpdatemaxnremovev ��������EDITOR         L   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    L   func    L   token    L   id   L   task   L   args   L   index   L   	hasParam   L   (for index)   +   (for limit)   +   (for step)   +   i   *   ret<   L      _ENVunpack �   �      � @  � m  ��   ��� �ƀ@ ���A @ �@��  & �    
StartTask        tableinsert_coreGameTaskIDs            �   �   �   �   �   �   �   �   �   �   �   �   �      self       func       id         _ENV �   �       F @ �@@ e  f   & �    next_coreGameTaskIDs            �   �   �   �   �      self          _ENV �   �    	   F @ �@@ d ����@ ��@�A  ��A���@ ��@�AA  ��A���A ���i�  �@�K   
@��F B G@� �� d@ & �    ipairs_coreGameTaskIDstableremovev	runningsnewRunningstasks LogdebugKillCoreGameTasks Finished!!            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       (for generator)      (for state)      (for control)      _      taskid         _ENV �      "   � @ �@@ǀ@  � �@�� @ �@@��@  � �@�� A �@� �   ƀA �A � @�@ ��� � B BB$�� �B��$B�@ ��  j���   @ ���A �@� & �    tableremovev	runningsnewRunningstasks pairsyieldEventsGameGlobalTimerCancelEvent         "   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �                self    "   taskid    "   found   "   (for generator)      (for state)      (for control)      id      yieldEvent         _ENV      	%   F @ �@@ d ����@ ��@�A  ��A���@ ��@�AA  ��A��A@ ���i�  �@�F�A � B d ��b  @��AB ��B��� ��B ��A�i�  �@�K   
@ �K   
@ �& �    ipairstaskstableremovev	runningsnewRunnings pairsyieldEventsGameGlobalTimerCancelEvent_coreGameTaskIDs         %           	  	  	  	  	  
  
  
  
  
                                                   self    %   (for generator)      (for state)      (for control)      _      taskid      (for generator)       (for state)       (for control)       id      yieldEvent         _ENV   <  #   � @ �  @@ �� � �   �@  ��  �  �   ��  �  FA �A �  d�  ��  (��A @��  $�  � ������� ��A � ����'���A �  %�&  & �    _coreGameTaskIDs        ��������       select#TT
StartTask         &  :   0   A   �@@ ��@�� ��@�� � A A� � �    �ƀA ��� FAB G���A� �� d��@  � C    �@ �@@ ̀�� ���� ΀�a��   �@��@� � �_@�� �� � ̀��@ �  �    ��  �E $ �@  & �    '      GameGlobalGetInstanceGetCurrentTimenext_coreGameTaskIDsLogdebugWaitCoreGameTaskFinish tasks: tableconcat YIELD        KillCoreGameTasks           0   '  (  (  (  (  (  *  *  *  *  *  +  +  +  +  +  +  +  +  +  ,  ,  ,  .  .  .  .  .  .  .  .  0  2  2  2  2  3  3  3  7  7  7  8  8  8  8  8  :     TT    0   
wait_tick   0   start_tick   0      _ENVself	onfinishunpackargs#                                                         !  !  "    %  :  %  ;  <     self    #   	onfinish    #   args
   #   index   #   (for index)      (for limit)      (for step)      i         _ENVunpack @  I      � @ �@ �   @��@@ ǀ��@ @� �@��@@ ǀ�A @� �@�ƀ� ������A �@� & �    taskstableremovev	runningsnewRunningsstateSuspendYIELD             A  A  B  B  C  C  C  C  C  D  D  D  D  D  E  E  F  F  I     self       id       task         _ENV
TaskState N  p   	F   � @ �@ �   ���@@ ǀ�䀀 ���@ �@�� @ � � �@A �@��@   ��A �AA �� �A �B �B$� $A  �   �	�C ACG�C �� $��"A   �C ACG�C $� "    �& � C DG�C �� $A��� � ������$��"A  @�GAA J� FC GA���E �� dA�FC GA���C �� dA�C  f   & & �    yieldEventsGameGlobalTimerCancelEvent tasksLogfatal6TaskManager Resume Error!!! cannot find task with id=), Please Check if called STOP_ST_UNSAFE,debug
tracebacktableikey	runningsnewRunningsinsertstateRunningUpdatetokenremovev_coreGameTaskIDs          F   O  O  P  P  Q  Q  Q  Q  Q  Q  R  R  T  T  U  U  V  V  W  X  Y  Z  Z  Z  V  ]  ]  ]  ]  ]  ]  ]  ]  ]  ^  ^  ^  ^  ^  ^  _  a  a  a  a  a  b  b  g  g  g  h  h  i  i  j  j  j  j  j  k  k  k  k  k  l  l  o  o  p     self    F   id    F   yieldEvent   F   task   F   ret3   C      _ENV
TaskState s  �       � �  �� �A@ �@$�� �@���  $� GA G��bA  � �GA J� �FAA G���� dA FB dA� & � 	          GameGlobalTimer	AddEventyieldEventsLogfatalATaskManager:ExpirationYield Error, Expiration Yield When SuspendSuspendInternal         }  �        @ E � 
@� �@E � $@ & �    yieldEvents ResumeInternal             ~  ~  ~  �  �  �  �         selfid_ENV   v  v  w  {  {  {  {  |  �  {  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       token       id       ms       event
         _ENV �  �   
@   � @ ǀ��@  ��A@ �@A�  � � BA �A$� $A    & ��"  ����B_@B��FA@ G���� �  FBA G��d� dA  C  f �B � "  ��FC GA�d�� L��� dA�G�B J�CG@ ��G��b  @ ��A���C��� ʀ��@ ��C�E �AEǁE   �A��� � & �    tasksLogfatal(StopTaskUnSafe Error, cannot find task,,debug
tracebacktoken_classNameStoppableTaskToken7StopTaskUnSafe Error, token is not StoppableTaskToken,yieldEventsGameGlobalTimerCancelEvent joinedTaskID
joinTasksstateStoptableremovevnewRunnings          @   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    @   ST    @   id    @   task   @   
className   !   yieldEvent#   @   joinedTask0   @      _ENV
TaskState �  �        @ @@ $� �@ &  & �    TaskManagerGetInstancecurTask            �  �  �  �  �  �         _ENV �  �        @ @@ $� �@ "   � �G�@ b@    �D   f  & �    TaskManagerGetInstancecurTaskid            �  �  �  �  �  �  �  �  �  �  �  �     task         _ENV �  �      � @ �    � �@�& �    YieldInternal            �  �  �  �  �     TT       ms          _ENV �  �   	   �   � � A  �� ���@ �  �A ���& �                   YieldInternal         	   �  �  �  �  �  �  �  �  �     TT    	   frame    	   (for index)      (for limit)      (for step)      i         _ENV �  �      F @ d@� & �    SuspendInternal            �  �  �     TT          _ENV �  �      � @ � � �  �   & �    ResumeInternal            �  �  �  �  �     TT       id          _ENV         � @ � � �@ & �    JoinInternal                       TT       child          _ENV         b@  � �� @ �@@�@�  ���@ ��� �    ���@ � �� �@�@  � �� �@�� �ƀA ��� �@ & � 	   
coroutineyieldGetCurTaskIdTaskManagerGetInstanceExpirationYieldLogfatal$YIELD Error, current task id is nil                                                               token       ms       id         _ENV    #    	    @ $�� F@@ L�� d� L�� �   d@�& �    GetCurTaskIdTaskManagerGetInstanceSuspendTask         	   !  !  "  "  "  "  "  "  #     id   	      _ENV &  (      F @ L@� d� L�� �   e �f   & �    TaskManagerGetInstanceResumeTask            '  '  '  '  '  '  '  (     id          _ENV +  .      F @ L@� d� G�� ���    �@�& �    TaskManagerGetInstancecurTaskJoin            ,  ,  ,  ,  -  -  -  .     child       task         _ENV 2  6      � @ �@@�� ��@ � ����@  � ���@ �   �@ ��& �    TaskHelperGetInstanceIsAllTaskFinishedYIELD            3  3  3  3  3  3  3  3  4  4  4  4  6     TT       childArray          _ENVh               	   	   	   	                                 &      )   D   )   J   J   J   J   K   K   L   L   P   g   P   k   �   k   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �     �           <    @  I  @  N  p  N  s  �  s  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �          #     (  &  .  +  6  2  6     
TaskState   h   unpack   h      _ENV