LuaS �

xV           (w@g@../PublishResources/lua/product/components/ui/season/main/ui/finalplot/ui_season_final_plot_enter.lua         4    @ A@  ��@ $@�@@  ��@@ l   
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
@��& �    _classUISeasonFinalPlotEnterUICustomWidgetOnShowOnHideAttachEventsSetDataOnUIGetItemCloseInQuestBtnGoOnClick
EnterPlotOnPlotEndTmp
OnPlotEnd_RefreshByQuestStatusRefreshReqTakeAwards_OnRecvRewardsWithAnim_OnCollectAwardFinish_OnShareFinish                  �@@ �  ���
� �� @ ��@  �@��@@ A ���
� ��@@ � ���
� ��@@ A ���
� ���B �@ & �    rootGoGetGameObjectRoot
SetActivebaseGo
BaseImage
canTakeGoCanTakeImagefirstShowGoFirstShowImageAttachEvents                                               	   	   	   	   
   
   
   
               self       	uiParams                      G @ b   ��F@@ G�� d�� L�� � @ d@�
 A�& �    _firstShowTaskGameGlobalTaskManager	KillTask                                                 self          _ENV           L @ �@@ ǀ��@ d@ & �    AttachEventGameEventTypeOnUIGetItemCloseInQuest                                 self          _ENV    *       
@ �
���� @ � A�� 
����@A ��A��@ �� �   � ���A
��� �� B �@�C  �@�& � � @ ���FC GA�䀀
� �̀C �@ & �    _seasonObj_story        	seasonIdGetSeasonIDCfgcfg_season_campaign_clientFinalStoryIDrootGo
SetActive
questCmptGetComponentECCampaignSeasonComponentIDQUEST_STORYRefresh                                                  !   !   !   #   #   #   #   $   '   '   '   '   '   '   )   )   *      self       obj       cfg
         _ENV ,   1       � @ �@ �@@ �   @ ���@ �@ & �    Refresh_finalPlotCg_OnCollectAwardFinish           -   -   .   .   .   /   /   1      self       type            3   5       L @ d@ & �    
EnterPlot           4   4   5      self            7   H       G @ b@    �& � G @ @�   �& � G�@ b   ��F�@ G � d�� L@� ǀ@ d@�
�A�F�A G � �@B d@ L�B d@ l   ��B � C� @  � �@�& �    _story        _firstShowTaskGameGlobalTaskManager	KillTask UISeasonLocalDBHelperSeasonFinalPlotBtnShowed_Set	seasonIdRefreshUISeasonHelperPlayStoryInSeasonScence         E   E            @ $@ & �    
OnPlotEnd           E   E   E   E          self   8   8   8   9   ;   ;   ;   <   >   >   >   ?   ?   ?   ?   ?   ?   @   B   B   B   B   C   C   E   G   G   G   G   G   H      self       cb         _ENV J   T       F @ L@� d� ��� � �@��   ��@ �@�� �@A���A�B AB@ ��$A��B �� � $A & �    AsyncRequestResNewSetSucc
RoleAssetassetid.�j     count       tableinsert_OnRecvRewardsWithAnim            L   L   L   M   M   M   N   O   O   O   P   Q   R   R   R   R   R   S   S   S   S   T      self       res      rewards      
roleAsset
         _ENV V   c       G @ b@    �& � G @ L@� ǀ@ ���d��� A �@A��  ���A �@ �@�@�@ ���A �@ & �    
questCmptCheckCampaignQuestStatus_quest_questInfoCampaignQuestStatusCQS_CompletedReqTakeAwardsRefresh            W   W   W   X   [   [   [   [   [   \   \   \   \   ^   ^   ^   ^   ^   `   `   c      self       questStatus	         _ENV f   p       � @ �@@��  ���@ ��@� �@�� A ��@� �@� �� @ �@A��  ���@ ��@  �@�� ���@ ��@  �@�& �    CampaignQuestStatusCQS_CompletedrootGo
SetActivebaseGo
CQS_Taken            g   g   g   g   h   h   h   h   j   j   j   j   j   k   k   k   k   l   l   l   l   l   n   n   n   n   p      self       questStatus          _ENV �   �    .   G @ b@    �& � G @ b   @�G @ L�� d� 
@��G�@ L � d� �   �@A ǀ��@��     ����B GA@ $@�LBBd� ��@ �
 �@ �)�  ���G�B b@    �& � G @ L�� ǀB � �d���@C  � �@�& �    
questCmpt_questListGetQuestInfo_seasonObjGetSeasonIDCfgcfg_season_campaign_clientFinalStoryQuestIDipairsID_questCheckCampaignQuestStatus_questInfo_RefreshByQuestStatus         .   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   
   self    .   	seasonId   !   finalStoryQuestId   !   seasonClientCfg   !   (for generator)   !   (for state)   !   (for control)   !   i      quest      questStatus*   .      _ENV �   �       � @ �@@�� l  �@ & �    
questCmptStart_HandleQuestTake	quest_id        �   �       �   � @   @� �@ & �    _OnRecvRewardsWithAnim           �   �   �   �   �   �      res       rewards          self   �   �   �   �   �   �      self       
questInfo            �   �        � @ �@    �& � b   ���@� � �   ��ƀ@ ���A � �A�"    �
�A�B AB@ $A �B $A @���B � �GA� �  �A  �@�& �    viewGetSuccCfgcfg_season_campaign_client	seasonIdFinalStoryCg_finalPlotCgUISeasonHelperShowUIGetRewardsRefresh_seasonObjCheckErrorCode	m_result         �   �            @ $@ & �    Refresh           �   �   �   �          self �   �        & �                �               �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self        res        rewards        cfg         _ENV �   �       L @ �@  �@ G�@ L��AA ǁ�d���  d@ & �    ShowDialogUISeasonFinalPlotShare	seasonId_seasonObjGetComponentECCampaignSeasonComponentIDSTORY         �   �            @ $@ & �    _OnShareFinish           �   �   �   �          self   �   �   �   �   �   �   �   �   �   �   �      self          _ENV �   �       
@@�& �    _finalPlotCg            �   �      self           4                                                   *      ,   1   ,   3   5   3   7   H   7   J   T   J   V   c   V   f   p   f   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �          _ENV