LuaS �

xV           (w@[@../PublishResources/lua/product/components/ui/activity/active_task/ui_active_task_cls.lua         ^    @ A@  ��@ $@�@@  ��@@ l   
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
@��& �     _classActiveTaskDataObjectConstructorSetCampaignGetCampaignGetCampaignID
GetSampleGetCampaignLocalProgressGetCampaignEndTimeCheckFlipRedCheckMissionRedGetFlipCompGetFlipCompInfoGetMissionCompGetMissionCompInfo_GetAllTaskGetDailyTaskEndTimeGetDailyTaskGetAccumTask
_SortTaskGetActiveTaskCfgGetTurnCardCfgCheckTaskStatusCheckTaskIsOverCheckFlipIsOverCheckDailyTaskIsOverGetMatrixIndexGetTurnCardInfoReloadCampaignInfoCheckDailyTaskRedCancelDailyTaskRed                  
@@�
@@�
@��& �    _dailyTaskList _accumTaskList_matrixIndex              	   
         self                      
@ �& �    
_campaign                    self       	campaign                      G @ f  & �    
_campaign                       self                      F @ G@� f  & �    ECampaignTypeCAMPAIGN_TYPE_N32_VIG_QUEST                           self          _ENV           G @ L@� e  f   & �    
_campaign
GetSample                             self               $       L @ d� b   � ��@� �  �   & �    GetCampaignGetLocalProcess                   !   !   "   "   "   $      self       	campaign           '   *       L @ d� �@� �  & �    
GetSample	end_time           (   (   )   )   *      self       sample           -   1       L @ d� �@� �� �  & �    GetFlipCompHaveRedPoint           .   .   /   /   0   1      self       comp      hasRed           4   8    
   L @ d� �@� �� �@ @ �̀@ � �  & �    GetMissionCompHaveRedPointCheckDailyTaskRed        
   5   5   6   6   7   7   7   7   7   8      self    
   comp   
   hasRed   
        <   A    
   L @ d� b    ��@� �@ �@� ��   & �    GetCampaignLocalProgressGetComponentECampaignVigQuestComponentIDECAMPAIGN_VIGQUEST_TURNCARD         
   =   =   >   >   ?   ?   ?   ?   ?   A      self    
   localProcess   
      _ENV E   J    
   L @ d� b    ��@� �@ �@� ��   & �    GetCampaignLocalProgressGetComponentInfoECampaignVigQuestComponentIDECAMPAIGN_VIGQUEST_TURNCARD         
   F   F   G   G   H   H   H   H   H   J      self    
   localProcess   
      _ENV N   S    
   L @ d� b    ��@� �@ �@� ��   & �    GetCampaignLocalProgressGetComponentECampaignVigQuestComponentIDECAMPAIGN_VIGQUEST_QUEST         
   O   O   P   P   Q   Q   Q   Q   Q   S      self    
   localProcess   
      _ENV W   \    
   L @ d� b    ��@� �@ �@� ��   & �    GetCampaignLocalProgressGetComponentInfoECampaignVigQuestComponentIDECAMPAIGN_VIGQUEST_QUEST         
   X   X   Y   Y   Z   Z   Z   Z   Z   \      self    
   localProcess   
      _ENV ^   o       K   �   � @ � A�G����@ � ���ǂ��"  @�CA �A@� � $C� �CA �A@ � $C���  *���� � ��& �    GetMissionCompInfom_accept_cam_quest_listm_quest_time_param_mappairsm_need_daily_resettableinsert            _   `   a   a   b   c   e   e   e   e   f   g   g   g   h   h   h   h   h   h   j   j   j   j   j   e   e   n   n   n   o      self       dailyTaskList      accumTaskList      	compInfo      
questList      timeMap      (for generator)	      (for state)	      (for control)	      i
      v
      item         _ENV r   u       L @ d� �@� �  �   & �    GetMissionCompGetEarliestEndTimeInDailyQuest           s   s   t   t   t   u      self       comp           x   |       L @ d� �@@ @� 䀀@ �f  & �    _GetAllTask
_SortTask           y   y   z   z   z   z   {   |      self       dailyTaskList      accumTaskList              �       L @ d� �@@ @ 䀀� ��  & �    _GetAllTask
_SortTask           �   �   �   �   �   �   �   �      self       dailyTaskList      accumTaskList           �   �    G   � @ �@@ƀ@ �� �     K  ��@ �� �@��A@ 䂀C�$� F�A G��@@�FB GC�� ��dC���F�A G��@@�FB GC�����dC� �F�A G��@ �FB GC�����dC���  *����@ � � ��B �B� �@ �B���  *���@ ��� ��B �B� �@ �B���  *��  & �    GameGlobal
GetModuleQuestModulepairs	GetQuestStatusQuestStatusQUEST_AcceptedtableinsertQUEST_CompletedQUEST_Taken         G   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    G   	taskList    G   questModule   G   
resTaskTb   G   	unFinish   G   	received   G   (for generator)
   /   (for state)
   /   (for control)
   /   _   -   taskId   -   task   -   status   -   (for generator)2   :   (for state)2   :   (for control)2   :   _3   8   task3   8   (for generator)=   E   (for state)=   E   (for control)=   E   _>   C   task>   C      _ENV �   �       L @ d� �@@ ��@�@  � $� � ���� �@A�  & �    GetFlipCompCfgcfg_active_task_mainComponentIDGetComponentCfgId                   �   �   �   �   �   �   �   �   �   �   �   �      self       comp      cfg
         _ENV �   �       L @ d� �@@ ��@�@  � $� � ���� �@A�  & �    GetFlipCompCfgcfg_component_turn_cardComponentIDGetComponentCfgId                   �   �   �   �   �   �   �   �   �   �   �   �      self       comp      cfg
         _ENV �   �    	   � @ �@@ƀ@ �� ��@@� 䀀�@    �& � A $� LAA́�� d�  f & �    GameGlobal
GetModuleQuestModule	GetQuestGetMissionCompCheckCampaignQuestStatus
QuestInfo            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       questId       questModule      quest      questComponent      status         _ENV �   �    	   F @ G@� ��@ d� ��@ � A�@� � π��� ��A � � � ��GAB L����B ��d���AB �AC ��A��� � @ �C  f & �    GameGlobal
GetModuleSvrTimeModulemathfloorGetServerTime����MbP?GetMissionCompInfom_close_time
_campaignCheckComponentOpenClientErrorECampaignVigQuestComponentIDECAMPAIGN_VIGQUEST_QUESTCheckErrorCode            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       svrTimeModule      curTime
      
questInfo      
closeTime      result         _ENV �   �    	   F @ G@� ��@ d� ��@ � A�@� � π��� ��A � � � ��GAB L����B ��d���AB �AC ��A��� � @ �C  f & �    GameGlobal
GetModuleSvrTimeModulemathfloorGetServerTime����MbP?GetFlipCompInfom_close_time
_campaignCheckComponentOpenClientErrorECampaignVigQuestComponentIDECAMPAIGN_VIGQUEST_QUESTCheckErrorCode            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       svrTimeModule      curTime
      
questInfo      
closeTime      result         _ENV �   �       L @ d� �@@ ��@��@ �� � A �@��A$� �A�  �� � �� & @ �  & & �    GetDailyTaskEndTimeGameGlobal
GetModuleSvrTimeModulemathfloorGetServerTime����MbP?            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       
closeTime      svrTimeModule      curTime         _ENV �   �       G @ b@  ��L@@ d� ��@ ��� � � �
@��@ � ��  *��G @ f  & �    _matrixIndexGetFlipCompInfopairs	m_matrix            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       	flipInfo      (for generator)      (for state)      (for control)      i	      v	         _ENV �      @   L @ d� �   �@@ �� � @ ����@ ��  j���     FA@ � d 
��  �B������A��B�����B@ C�����B"D  @ ����@��B CG�B� $����  
��
ă�G�Ab    �@��B�F�C G��� � dD��  jC�ƂC ��� �@ �B�i�  ��@�� f�& �    GetFlipCompInfopairs	m_matrixm_matrix_itemidm_idisGet	maskList
m_is_turnindexmathminisFliptableinsert         @                               
  
  
  
                                                                                    
  
             self    @   	flipInfo   @   	m_matrix   @   (for generator)      (for state)      (for control)      _   	   v   	   	itemList   @   	maskList   @   (for generator)   <   (for state)   <   (for control)   <   _   :   v   :   item   :   (for generator)   5   (for state)   5   (for control)   5   i   3   isFlip   3   mask'   3      _ENV "  4   
&   � @ �@@�� ̀@C� �@�� A �@�� 
�����@ �@�@� � ƁA ���B BBFB G���@��   @���B� �@  @���@ � �FB G��䀀�@ AC��$A�& � & �    AsyncRequestResNewSetSucc
_campaignUIActivityCampaignLoadCampaignInfoECampaignTypeCAMPAIGN_TYPE_N32_VIG_QUESTECampaignVigQuestComponentIDECAMPAIGN_VIGQUEST_TURNCARDECAMPAIGN_VIGQUEST_QUESTGetSuccCheckComponentOpenClientErrorCheckErrorCode         &   #  #  #  $  $  $  '  '  '  '  (  (  )  *  +  +  ,  ,  -  .  (  /  /  /  /  /  /  0  0  0  0  0  1  1  1  1  2  4     self    &   TT    &   res   &   result    %      _ENV 7  B      L @ d� �@� ƀ@ ���䀀 � �� A @�� �F�A G��� d� _@�� ��� � @ ��  � & �    _GetAllTask       GameGlobal
GameLogic
GetOpenId!ActiveTaskData_CheckDailyTaskRedLocalDBGetInt            8  8  9  :  :  :  :  :  ;  ;  ;  ;  <  <  <  <  =  =  >  >  >  @  @  B     self       
dailyTask      firstTaskID      open_id      str      v         _ENV D  J      L @ d� �@� ƀ@ ���䀀 � �� A @�� �F�A G��� �A  dA�& �    _GetAllTask       GameGlobal
GameLogic
GetOpenId!ActiveTaskData_CheckDailyTaskRedLocalDBSetInt            E  E  F  G  G  G  G  G  H  H  H  H  I  I  I  I  I  J     self       
dailyTask      firstTaskID      open_id      str         _ENV^                                                                     $      '   *   '   -   1   -   4   8   4   <   A   <   E   J   E   N   S   N   W   \   W   ^   o   ^   r   u   r   x   |   x      �      �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �     �   "  4  "  7  B  7  D  J  D  J         _ENV