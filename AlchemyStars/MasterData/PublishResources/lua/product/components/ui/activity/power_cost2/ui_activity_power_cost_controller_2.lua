LuaS �

xV           (w@l@../PublishResources/lua/product/components/ui/activity/power_cost2/ui_activity_power_cost_controller_2.lua         L    @ A@  ��@ $@�@@  ��@@ l   
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
@��& �    _classUIActivityPowerCostController2UIController_BackLoadDataOnEnterGetComponentsCloseBtnOnClickIconOnClickOnValue	SetQuestSetTime	SetTime1SetTime1Tex	SetTime2SetTime2TexGetDataOnShowOnHide_ReLoadData	_Refresh_CheckQuestDailyResetShowBtnOnClickClaimBtnOnClick_AttachEvents_DetachEvents_CheckActivityClose                  L @ d@ & �    CloseDialog                       self            
        
"   A@ �@
 �A AA
 ���A B$� 
 ��A AB�� � @ G�@ $A �   @��B$� "A  @��A �B�C�� $A�& � �A AC�� $A�& �    _campaignTypeECampaignTypeCAMPAIGN_TYPE_POWERCOST_componentIdECampaignPowerCostComponentIDECAMPAIGN_POWERCOST_QUEST
_campaignUIActivityCampaignNewLoadCampaignInfoGetSuccCheckErrorCode	m_resultClearCampaignNew         "                                                                                                             self    "   TT    "   res    "   	uiParams    "      _ENV !   .    0   L@@ ��  �  d� 
@ �L@@ ��  A d� 
@ �L@@ ��  d� 
@ �L@@ �� � d� 
@��L@@ �@ � d� 
@ �L@@ �@  d� 
@��L@@ �@ � d� � � A ���
�����E  ���
� ��@@ �  A� �� 
���& �    _descGetUIComponentUILocalizationTextdesc_txtProgresstxtProgress	_imgFillImageimgFill_IconRawImageLoaderIcon_time1RollingTexttime1_time2time2UISelectObjectPathitemTipsPool_tipsSpawnObjectUISelectInfo_lockGetGameObjectlock_txttxt        0   "   "   "   "   "   #   #   #   #   #   $   $   $   $   $   %   %   %   %   %   &   &   &   &   &   '   '   '   '   '   (   (   (   (   *   *   *   *   ,   ,   ,   ,   -   -   -   -   -   .      self    0   s"   0        /   1       � @ �@ & �    _Back           0   0   1      self       go            2   7       � @ �   ���@� ��@� @ ���GA � �@ & �    _tips
transform	positionSetDataitemId           3   3   3   4   4   5   5   5   5   5   7      self       go       pos   
        8   <       L @ d@ L@@ d@ L�@ d@ & �    GetDataSetTime	SetQuest           9   9   :   :   ;   ;   <      self            =   U    =   F @ G@� ��@ G�� ��� � A �@�@ �@�ǀA ��� G�A GA��@��B �B��$A��A �AG�A GA�AGC J��F�C G��� d� �AD ��B ��A���A ��D��D ��FBE G��@  �CB  C� �A��  BE �E @ ��   ��A �F �B��C ��C��� $B  & �    Cfg	cfg_itemitemIdIcon_Icon
LoadImage_questcur_progress/total_progress_txtProgressSetText	_imgFillfillAmountStringTableGet!str_activity_powercost_intro_n29_descstatus_lock
SetActiveQuestStatusQUEST_CompletedQUEST_Taken"str_activity_powercost_2_get_btn2!str_activity_powercost_2_get_btn_txt         =   >   >   >   >   ?   @   @   @   @   B   B   B   B   B   B   C   C   C   C   E   E   E   E   E   F   F   H   H   H   H   I   I   I   I   K   K   L   L   L   L   L   L   L   L   L   N   O   O   O   O   P   P   R   T   T   T   T   T   T   T   U      self    =   cfg   =   icon   =   	progress   =   rate   =   desc   =   status$   =   tex.   =      _ENV V   Y       L @ d@ L@@ d@ & �    	SetTime2	SetTime1           W   W   X   X   Y      self            Z   f       G @ b   @�F@@ G�� d�� L�� � @ d@�F@@ G�� d�� L � �@ �A �Al  d��
@ �L B d@ & � 	   _timer1GameGlobalTimerCancelEventAddEventTimes�      TimerTriggerCount	InfiniteSetTime1Tex         a   c            @ $@ & �    SetTime1Tex           b   b   b   c          self   [   [   [   \   \   \   \   \   \   ^   ^   ^   ^   _   `   `   c   ^   d   e   e   f      self          _ENV g   z    
=   F @ G@� ��@ ��@�� � Ad� �@A �@  �A@���A �   @�� B �@�䀀 ̀�G�A �@���B �   @�� B �@�䀀 ̀�G�B �@��  AC �C��C �D��� $A  AD �C��C �D��� $A  ��ƀD ���� � �@ 䀀A GAC L����C ��  @���dA  & �    mathfloor_svrTimeModuleGetServerTime����MbP?endTime        _timer1GameGlobalTimerCancelEvent_timer2str_activity_error_107_time1RefreshTextStringTableGet_time2HelperProxyGetInstance	Time2Tex#str_activity_powercost_2_time_tex1         =   h   h   h   h   h   h   h   i   i   j   j   k   k   k   l   l   l   l   l   l   n   n   n   o   o   o   o   o   o   r   s   s   s   s   s   s   s   t   t   t   t   t   t   t   t   v   v   v   v   v   v   w   x   x   x   x   x   x   x   x   z      self    =   svrTime   =   sec	   =   tex   ,   timeStr3   <   tex4   <      _ENV {   �       G @ b   @�F@@ G�� d�� L�� � @ d@�F@@ G�� d�� L � �@ �A �Al  d��
@ �L B d@ & � 	   _timer2GameGlobalTimerCancelEventAddEventTimes�      TimerTriggerCount	InfiniteSetTime2Tex         �   �            @ $@ & �    SetTime2Tex           �   �   �   �          self   |   |   |   }   }   }   }   }   }               �   �   �   �      �   �   �   �      self          _ENV �   �    7   G @ G@� ��@ ��@�� � A�@ �@A�A �AGB LA�d� O��$� N� �� ��C �AC�� �A ��C �  @��D �AD��� ��D�C �A���D  �A��AE ,  @  �A ����E ��E�� �F �����A �F �F�G �BG��  ��$B  & �    _quest	quest_id_component_questGetComponentInfom_quest_time_param_mapm_end_timemathfloor_svrTimeModuleGetServerTime����MbP?        Logfatal7###[UIActivityPowerCostController2] 刷新任务信息_timer2GameGlobalTimerCancelEventLockRefreshQuestInfo
StartTaskHelperProxyGetInstance	Time2Tex#str_activity_powercost_2_time_tex2_time2RefreshTextStringTableGet         �   �       F @ L@� d� ��� ��@   @� �@ � � � AA �@���� �� �    �� � ��A   @� �@ & �    AsyncRequestResNew_component_questHandleCamQuestDailyResetUnLockRefreshQuestInfoGetSucc_ReLoadData             �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      TT       res         _ENVself7   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    7   questId   7   	timeInfo   7   endTime   7   svrTime   7   sec   7   timeStr-   6   tex.   6      _ENV �   �    '   
@@�F�@ G � �@A d� 
@ �G�A L � �@B d��
@ �G�A L�� d� 
@ �G�A L@� ǀB d��
@ �A� ��B �@ � D�� 
�����A ��D�� ��D
�����C �@E
� �� E ��C��E
� �& �    isOpen_svrTimeModuleGameGlobal
GetModuleSvrTimeModule_component_quest
_campaignGetComponent_componentId_questListGetQuestInfo_questStatusGetCampaignQuestStatus       _quest
QuestInfoendTimeGetComponentInfom_close_time_awardsrewardsitemIdassetid         '   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    '   questIndex   '   reward$   '      _ENV �   �       � @ �@ �@@ �@ ��@ �@ & �    GetComponentsOnValue_AttachEvents           �   �   �   �   �   �   �      self       	uiParams            �   �       
@@�G�@ b   @�F�@ G � d�� L@� ǀ@ d@�G�A b   @�F�@ G � d�� L@� ǀA d@�& �    isOpen _timer1GameGlobalTimerCancelEvent_timer2            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self          _ENV �   �       � @ �@�@� � �@ � @ ̀�� �@  � ���@ �@ & � � A �@ & �    
_campaignReLoadCampaignInfo_ForceCheckCampaignOpen_Back	_Refresh           �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       TT       res            �   �       L @ d@ L@@ d@ & �    _CheckQuestDailyResetOnValue           �   �   �   �   �      self            �      
   F @ G@� ��@ d� ��@ � A�@� � π��� ��A �@   �B ABA� $A & � ��$� N� !@�  �& � �AC ,  @  �A & �    GameGlobal
GetModuleSvrTimeModulemathfloorGetServerTime����MbP?_component_questLoginofHUIActivityPowerCostController2:_CheckQuestDailyReset() component == nilGetEarliestEndTimeInDailyQuest        
StartTask         �         F @ L@� d� � � ��@   @� �@ ��� �� �    ��  � A   @� �@ & �    AsyncRequestResNewHandleCamQuestDailyResetGetSucc_ReLoadData             �   �   �   �   �   �   �   �   �   �   �   �                       TT       res         _ENV
componentself   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �       �        self       svrTimeModule      curTime
      
component      	nextTime      stamp         _ENV   	      � @ �@ & �    _ShowUI               	     self       go              (      � @ �@@ƀ@ ���_�  �� A �@�� �@ & � ��A � �G@ GA��  �@ & � 
   _queststatusQuestStatusQUEST_CompletedLogdebugZ###[UIActivityPowerCostController2] ClaimBtnOnClick status~=QuestStatus.QUEST_Completed !_component_questStart_HandleQuestTake	quest_id           &      � @ �@    �& � "    ��@@ �� �    ���� ��@� � �@  �� A �@A��A�A FA G��  �A  �@ & � 	   isOpenGetSuccUIActivityHelperShowUIGetRewards
_campaign_campaign_moduleCheckErrorCode	m_result_id                        @ $@ & �    	_Refresh                            self !  #           @ $@ & �    _Back            "  "  "  #         self                                                #    &     res       rewards          self_ENV                                 &    (     self       go       status         _ENV +  /      L @ �@@ ǀ��@ d@ L @ �@@ � �AA d@ & �    AttachEventGameEventTypeActivityCloseEvent_CheckActivityCloseOnUIGetItemCloseInQuest	_Refresh            ,  ,  ,  ,  ,  -  -  -  -  -  /     self          _ENV 2  5      L @ �@@ ǀ��@ d@ L @ �@@ � �AA d@ & �    DetachEventGameEventTypeActivityCloseEvent_CheckActivityCloseOnUIGetItemCloseInQuest	_Refresh            3  3  3  3  3  4  4  4  4  4  5     self          _ENV 8  <      � @ �   ��� @ �@@@ � ���@ �@ A�@�& �    
_campaign_idSwitchStateUIStateTypeUIMain            9  9  9  9  9  9  9  :  :  :  :  <     self       id          _ENVL                              
       
   !   .   !   /   1   /   2   7   2   8   <   8   =   U   =   V   Y   V   Z   f   Z   g   z   g   {   �   {   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �     �     	      (    +  /  +  2  5  2  8  <  8  <         _ENV