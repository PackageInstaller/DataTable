LuaS �

xV           (w@]@../PublishResources/lua/product/components/ui/homeland/task/homeland_story_task_manager.lua         �    @ A@  ��@ $@�@@  ��@@ l   
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
@��@@ l@ 
@ �@@ l� 
@��@@ l� 
@ �@@ l 	 
@��@@ l@	 
@ �@@ l�	 
@��@@ l�	 
@ �@@ l 
 
@��@@ l@
 
@ �@@ l�
 
@��@@ l�
 
@ �@@ l  
@��& � 0   _classHomelandStoryTaskManagerObjectConstructorInitDispose	CheckRun	StartRunStopRunUpdateReceiveStoryTaskInfosGetStoryTaskCountCreateServerDataGetTaskGroupDataCreateStoryTasksStartStoryTaskManagerSwitchStoryTaskSetRunningStoryTaskGetNextSrotyTaskRefreshTaskInfoGetRuningStoryTaskGetRuningTaskroupGetRuningTaskItemGetHomelandTaskManagerHelperGetHomelandClientGetHomelandModuleGetTaskManagerOnStoryTaskFinishOnTaskGroupFinishOnTaskGroupFinishAfterRewardOnTaskItemFinishNextTaskItemOnStoryTaskStartOnStoryTaskEndOnModeChangedGetClientModeSetNpcsVisibleOnHomeLandSpecialCheckCheckStoryTaskGroupFinishedGetRunningTaskCheckStoryTaskFinishedGetStoryGroupInfoGetFinishedStoryTaskCountReceiveLastStoryTaskRewardsGetStoryTaskUpdateHandleStoryTaskUpdateCheckGroupFinishedCountPrintStoryTaskInfos    -           	   K   
@ �
���
���
�@�F�A G�� 
@��& �    _storyTasks_runingStoryTask _runingTaskGroup_runingTask_modeHomelandModeNormal         	         
                        self    	      _ENV    0    5   
@ �
�����@ � �AA � 
� ��@@ ���� 
� �� @ �@�� 
� �̀B �@ ��B �@ � C �@ ƀC ���� � �GAD �  � 
�����D ���� � �GAE �  � 
� ���@ ǀ�䀀 ���FF GA���D �@ ƀF ���� 
���� G �@ 
�ǎ& �    _homelandClient_taskManager_homelandModuleGameGlobal
GetModuleHomelandModule_homelandTaskManagerHelperGetHomelandTaskManagerHelper_homelandTraceManagerGetHomelandTraceManagerReceiveStoryTaskInfosCreateServerDataCreateStoryTasks
_taskCoreTaskManagerGetInstance
StartTaskReceiveLastStoryTaskRewards_onHomeLandStoryTaskUpdateGameHelperCreateCallbackHandleStoryTaskUpdateEventDispatcherAddCallbackListenerGameEventType_storyTaskLocalDataUIHomelandStoryTaskLocalDataNew	CheckRun_lastStoryTaskLen                 5                                                    "   "   #   #   $   $   &   &   &   &   &   &   &   &   (   (   (   (   (   (   (   (   )   )   )   )   )   )   )   )   +   +   +   +   -   -   /   0      self    5   homelandClient    5   taskManager    5      _ENV 2   J    )   G @ b    �F@@ G�� d�� L�� � A �@�@ d@ 
�A�G�A b   ��F@@ G � d�� L@� ��A d@�
���G�B \ �  @��@�A  ��B �  �  h� �G�B G�LA�dA g��
�A�
�A�
���
�A�& �    _onHomeLandStoryTaskUpdateGameGlobalEventDispatcherRemoveCallbackListenerGameEventTypeHandleStoryTaskUpdate 
_taskCoreTaskManager	KillTask_storyTasks               Dispose_runingStoryTask_runingTaskGroup_runingTask         )   4   4   4   5   5   5   5   5   5   5   5   6   9   9   9   :   :   :   :   :   :   ;   >   >   >   >   ?   ?   ?   ?   ?   @   @   @   @   ?   C   E   G   I   J      self    )   (for index)   $   (for limit)   $   (for step)   $   i   #      _ENV K   P       G@@ G�� G�� 
@ �G @ b   ��G @ G �  @��� �L�A � @ � �d@�& �    _storyTaskInfos_homelandModulem_homeland_infostory_task_infocfg_id        	StartRun           L   L   L   L   M   M   M   M   M   M   M   N   N   N   N   P      self            R   U       � @  � �@��@@ ��@��� ��@A AAC� �@ & �    StartStoryTaskManagerGameGlobalEventDispatcher	DispatchGameEventTypeStoryTaskChangeState            S   S   S   T   T   T   T   T   T   T   T   U      self       taskId          _ENV W   m    6   b   ���   �@@ � �  � ��A@ �A��@�� @ ���A@ �A��@�A 
@A�
@A� ��@���� A �   ��� A ��@�@ ��A �   ����A � B�A AB$� F�B G���@ 
@A�
@A�� C �@C��� ��C�C DC  �@ �@D ��D�� �@ & �           _storyTasksGetStoryTaskIDEndRun_runingStoryTask _runingTask_homelandTraceManagerDisposeTrace
GetGuidId
TraceEnumTaskGameGlobalEventDispatcher	DispatchGameEventTypeStoryTaskChangeStateLogfatal!HomelandStoryTaskManager:StopRun         6   X   X   Y   Y   Y   Y   Y   Z   Z   Z   Z   Z   Z   [   [   [   [   \   ]   ]   Y   `   b   b   b   c   c   c   d   d   d   e   e   e   e   e   e   e   e   g   h   k   k   k   k   k   k   k   k   l   l   l   l   m      self    6   taskId    6   (for index)      (for limit)      (for step)      i         _ENV o   s       � @ �   � �� @ �@@ � �@�& �    _runingStoryTaskUpdate           p   p   p   q   q   q   q   s      self       deltaTimeMS            w   |    
   G@@ L�� ��@ � �d��
@ �L@A � @ d@�& �    _storyTaskServerData_homelandModuleGetHomelandGroupTaskInfo
QuestTypeQT_Homeland_Story_TaskPrintStoryTaskInfos         
   z   z   z   z   z   z   {   {   {   |      self    
      _ENV ~   �    
   A   �@@ ǀ@ �   �M�� ��  *�f  & �            pairs_storyTaskServerData                
      �   �   �   �   �   �   �   �   �      self    
   len   
   (for generator)      (for state)      (for control)      key      value         _ENV �   �       K   
@ �G@@ L�� d� ��@ � � � ���A@ GBA�  
���A ��$��G@ �BAJ��  *����A � B�@ �@ & � 
   _serverData_homelandTaskManagerHelperGetStoryTaskAllCfgpairsStoryTaskGroupTbIDGetTaskGroupDataLogfatalCreateServerData            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   	   self       allCfg      (for generator)      (for state)      (for control)      key	      value	      tb
      res         _ENV �   �       �   � @  � �  �B@ G�@ $� ���  �� �)�  ����  j��  & �    ipairspairs_storyTaskServerData            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       tb       data      (for generator)      (for state)      (for control)      key      value      (for generator)      (for state)      (for control)      i	      v	         _ENV �   �    /   G @ \ �  @����A�  � @ �  ��  h� �G@ G�L��dA g��K   
@ �G A L@� d� ��A � � �  ���A �A��   ��B �A�@�� �  �A C� �B �BG@ ��$B���  *�� C �@C�� �@ & �    _storyTasks               Dispose_homelandTaskManagerHelperGetStoryTaskAllCfgpairs_serverDataHomeStoryTaskNewtableinsertLogfatalCreateStoryTasks         /   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    /   (for index)      (for limit)      (for step)      i	      allCfg   /   (for generator)   *   (for state)   *   (for control)   *   storytaskId   (   cfg   (   
storyTask#   (      _ENV �   �    	>   b   ��� @ �   � �� @ �@@�@ ��@ �   ��� ��   �  �@  A ��ǁ@ ǁ��A�� @� �ǁ@ ǁ�́�� �A  � �ǁ@ ���  ������A @ �@�����@ �   ������   �  �@  A � �ǁ@ ǁ�́�� �A  � �ǁ@ ���  ��@���A @ �@�& �    _runingStoryTaskEndRun_storyTasks               GetStoryTaskIDCheckFinishedSetRunningStoryTask        >   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    >   taskId    >   runningTask   %   (for index)   "   (for limit)   "   (for step)   "   i   !   runningTask+   =   (for index)/   :   (for limit)/   :   (for step)/   :   i0   9        �   �    	   � @ �   ������   ��  @  A�  � ��@ ǁ����� @�� ��@ ���  ��@�� A @ �@�& �    _storyTasks               GetStoryTaskIDSetRunningStoryTask           �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       taskId       runningTask      (for index)	      (for limit)	      (for step)	      i
           �   �    *   � @ �  @@ ���@ ��@�  �@ & � b@   ���@ ��@�@ �@ & � ��A _�A� ���A � B�@ 
@ ���A �@B�@ ��A ��B�� 
� ���B �   � ���B �@C�� 
� ���@ ��@�� �@ & �    _storyTasks        Logfatal=当前无剧情任务！！！！！！！！！！！！！8当前无任务！！！！！！！！！！！！！:_runingStoryTask EndRun	StartRun_runingTaskGroupGetRuningTaskGroup_runingTaskGetRuningTask         *   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    *   
storyTask    *      _ENV �   �       L @ d@ L@@ d@ L�@ d@ & �    ReceiveStoryTaskInfosCreateServerDataCreateStoryTasks           �   �   �   �   �   �   �      self            �      	'   L @ d� �@@ ��@_��   �& � L�@ d@ L A d@ G@A b@  � �L�A d@ L�A d@ F B �@B d ���AA �   ��AA ��B��  � ��AA ��B ��A�i�  �@�L C d@ & �    GetClientModeHomelandModeNormalReceiveStoryTaskInfosCreateServerData_runingStoryTaskCreateStoryTasks	CheckRunpairs_serverDataGetStoryTaskIDSetServerDataCheckGroupFinishedCount         '   �   �   �   �   �   �   �   �   �                                                           
  
       self    '   (for generator)   $   (for state)   $   (for control)   $   storyTaskId   "   groups   "      _ENV         G @ f  & �    _runingStoryTask                    self                    G @ f  & �    _runingTaskGroup                    self                    G @ f  & �    _runingTask                    self                    G @ f  & �    _homelandTaskManagerHelper                    self                     G @ f  & �    _homelandClient                     self            "  $      G @ f  & �    _homelandModule           #  #  $     self            '  )      G @ f  & �    _taskManager           (  (  )     self            +  4      � @ �@    �& � 
@��� @ �    �� @ ��@�� �� � �� @ ��@�@ 
 A�& �    _runingStoryTask_lastTaskStoryTaskIdGetStoryTaskIDEndRun            ,  ,  ,  -  /  0  0  0  0  0  0  0  0  1  1  1  2  4     self       storyTaskId            6  M   0   � @ �@    �& � �@@ �    ��@@ ��@�� _��   �& � � @ ��@�� �   ��� @ � A�@ 
@A�
@��
@A�@�� @ ��A�@ � @ � B�� 
����@@ �@   �� @ � A�@ 
@A�& � �@@ �@B�@ �@@ ��B�� 
� �& �    _runingStoryTask_runingTaskGroupGetGroupIDCheckFinishedEndRun _runingTaskMoveNextTaskGroupGetRuningTaskGroup	StartRunGetRuningTask        0   7  7  7  8  :  :  :  :  :  :  :  :  ;  =  =  =  =  =  >  >  >  ?  @  A  A  C  C  C  D  D  D  D  E  E  E  F  F  F  G  H  J  J  J  K  K  K  K  M     self    0   groupId    0        O  ^   #   � @ �@@ � ��́@�   G��_ ���G��\�����B_@   �B  � "  ��FBA G�����d� �B �BB�BA ǂ�� @����B  ��  *A�& �    pairs_storyTasksGetStoryTaskCfgStoryTaskGroupTb StringTableGetGroupsListTitleToastManager
ShowToast'str_homeland_storytask_mission_allover         #   P  P  P  P  Q  Q  S  T  T  T  U  U  V  V  V  V  V  V  Y  Y  Z  Z  Z  Z  [  [  [  [  [  [  [  [  P  P  ^     self    #   groupId    #   (for generator)   "   (for state)   "   (for control)   "   k       storyV       storyTaskCfg       theLastGroupId       groupTabCount      	taskName          _ENV a  r   #   � @ �@    �& � � @ �@�� _@�  �& � ǀ@ ���� _��  �& � � @ � �� �   � �@ AA$A @ ��A $A �A B$�� AB��B ��B$A�& �    _runingTaskGroupGetGroupID_runingTask
GetTaskIDCheckFinishAllOnTaskGroupFinishedNextTaskItemGameGlobalEventDispatcher	DispatchGameEventTypeOnHomelandTaskItemChanged         #   b  b  b  c  e  e  e  e  e  f  h  h  h  h  h  i  k  k  k  l  l  m  m  m  m  o  o  q  q  q  q  q  q  q  r     self    #   groupId    #   taskId    #   
allFinish   #      _ENV t  y      G@@ L�� d� 
@ �G @ b   � �G @ L�� d@ & �    _runingTask_runingTaskGroupMoveNextTask	StartRun           u  u  u  u  v  v  v  w  w  w  y     self            |  ~      & �                ~     self       storyTaskID            �  �      & �                �     self       storyTaskID            �  �   %   
@ �� @ �@@ ǀ��  ���@ �   ����@ � A�� �  @A@���@ ��A  �@���@ ��A�@ ��@ � B�@ �@B �@ ��B @ FA@ G��_@  �A  � �@�& �    _modeHomelandModeNormal_runingTaskGetTaskNpcs        CreateTaskHangPointNpcDisposeTrace
OpenTraceRefreshTaskInfoSetNpcsVisible         %   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    %   mode    %      _ENV �  �      G @ f  & �    _mode           �  �  �     self            �  �      � @ �   � �� @ �@@ � �@�& �    _runingTaskSetNpcsVisible           �  �  �  �  �  �  �  �     self       visible            �  �      � @ �   � �� @ �@@ � �@�& �    _runingTaskOnHomeLandSpecialCheck           �  �  �  �  �  �  �  �     self       pstid            �  �      � @ A@ � @���$� @ @�@ L��d $ ��LAd� ��� �LCAe f  )�  ����  j���   �  & �    pairs_storyTasksGetStoryTaskIDGetTaskGroupsGetGroupIDCheckFinished            �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       taskId       groupId       (for generator)      (for state)      (for control)      key      value      (for generator)      (for state)      (for control)      i      j         _ENV �  �      � @ A@ � @���$� @ @�@ L��d $ ��LAd� ����LCAd� bC  � �L�Ae f  )�  ����  j��& � & �    pairs_storyTasksGetStoryTaskIDGetTaskGroupsGetGroupIDCheckFinishedGetRunTaskItem            �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       taskId       groupId       (for generator)      (for state)      (for control)      key      value      (for generator)      (for state)      (for control)      i      j         _ENV �  �   	   � @ �@@ �  �@�� �́@� �  ��  *��   �  & �    pairs_storyTasksCheckFinished            �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       taskId       (for generator)      (for state)      (for control)      key   	   value   	      _ENV �  �      & �                �     self       groupId            �  �   	   A   �@@ ǀ@ �  ���@� �    �M � ��  *�f  & �            pairs_storyTasksCheckFinished                   �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       count      (for generator)      (for state)      (for control)      key   
   value   
      _ENV �     �   �   �@@ � �  � #��A@ �A��@�� �  ���   A  ��ǂ���� �  @�  \��  (�ăA$� "  ��ăA$� DA$� F�A G��@��ăB$� DBF�B G��@�	�C $� DC�� �ă̄�	� $�  ��C�� �  ���D �DD	�� Ń�C
$� ��	�D ���� 	 �����D �D�	� L�Ed� E
�D ���D �DE	� �E$� ��	�D 'C������ A  � �  h�GLC�d� b  ��LC d� L������� d�  bC  �	�LC d� L��� �F$ d�    ��L��d� b   �GL��d� b   �FD GC��C ����� ��dC ��G�D�� �����D �CE�� ��$� ���C gB��@�& �           _storyTasksGetTaskGroupsGetTaskItemsGetTaskServerInfoStatusQuestStatusQUEST_CompletedGetTaskConditionCfgFinishTypeFinishConditionEnumOtherGetHomelandModuleHandleHomelandTaskQuestTakeReq
GetTaskIDGetSuccLoginfo>[HomelandStoryTaskManager]任务结束 领奖成功 任务id:rewards        fatal9[HomelandStoryTaskManager] ReceiveLastRewards succ, res:
GetResult9[HomelandStoryTaskManager] ReceiveLastRewards fail, res:CheckFinishedIsRecvGroupTaskRewardGetGroupIDHandleHomelandTaskGroupTakeReq5[HomelandTask]任务组结束 领奖成功 任务id:C[HomelandStoryTaskManager] ReceiveLastRewards taskGroup succ, res:         �   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �       self    �   TT    �   (for index)   �   (for limit)   �   (for step)   �   i   �   groupitems	   �   (for index)   W   (for limit)   W   (for step)   W   v   V   items   V   (for index)   V   (for limit)   V   (for step)   V   k   U   res6   U   replyEvent6   U   
assetListC   M   resX   �   replyEventX   �   (for index)[   �   (for limit)[   �   (for step)[   �   i\   �   
assetList�   �      _ENV   	      G @ G@� G�� G�� f  & �    _homelandModulem_homeland_infostory_task_infoid_list                     	     self                    G @ G@� G�� G�� b@    �& � �  � �  ����AA ��A�A� �� �A    �
 ����@B �@ ��B �@ & �    _homelandModulem_homeland_infostory_task_infoid_list       _storyTaskLocalDataHasPrefsStoryTask_isNewCheckGroupFinishedCount	CheckRun                                                              self       data      (for index)
      (for limit)
      (for step)
      i             (   	   A   �@@ �    ���@ �@@ � � ���@� M�� ��  *��� A �@A��� _@  �
�A�� A � � � �@ � A �@�� �@ & �            _storyTaskspairsGetFinishedCount_storyTaskLocalDataGetPrefsStoryTaskGroup_isNewSetPrefsStoryTaskGroupSetPrefsStoryTaskGroupNew                                             "  "  "  #  #  $  %  %  %  %  &  &  &  &  (     self       count      (for generator)      (for state)      (for control)      key      value      
lastcount         _ENV -  5      � @ �@@��  �@ ��@ � � � ����@   �@�@ C@A �C���A$C��  j����  *A�� @ �@@�� �@ & �    Logdebug;HomelandStoryTaskManager:PrintStoryTaskInfos() Start -----pairs;HomelandStoryTaskManager:PrintStoryTaskInfos() quest_id = _questInfo	quest_id9HomelandStoryTaskManager:PrintStoryTaskInfos() End -----            .  .  .  .  /  /  /  /  0  0  0  0  1  1  1  1  1  1  0  0  /  /  4  4  4  4  5     self       storyTaskServerData       (for generator)      (for state)      (for control)      i      v      (for generator)      (for state)      (for control)      ii      vv         _ENV�                                 0      2   J   2   K   P   K   R   U   R   W   m   W   o   s   o   w   |   w   ~   �   ~   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �     �                                  "  $  "  '  )  '  +  4  +  6  M  6  O  ^  O  a  r  a  t  y  t  |  ~  |  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �    �    	            (    -  5  -  5         _ENV