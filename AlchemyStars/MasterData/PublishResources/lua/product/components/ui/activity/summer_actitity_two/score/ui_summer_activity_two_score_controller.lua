LuaS �

xV           (w@�@C:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/lua/product/components/ui/activity/summer_actitity_two/score/ui_summer_activity_two_score_controller.lua         .    @ A@  ��@ $@�@@  ��@@ l   
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
@��& �    _class#UISummerActivityTwoScoreControllerUIControllerLoadDataOnEnterSortRewardDatasRefreshScoreDataOnShow
CloseCoro	ShowTipsInitTypeMissionInfoInitRewardListOnGetRewardItemRefreshRewardItemInfoCanGet
GetRewardShowRewards           <    W   
@@��@ �@FA $� F�A L��d� 
@��GAA L���   FBB G����B �C��B �B��B �CF�B G��dA��   @�LDd� bA  @�LADǁDBA �DD� dA GAA bA    �& � GAA LA�d� 
@�GE bA    �& � GE L����B ���d��
@�GE LA���B ���d��
@�F�F L��ǁE d��
@�GE L����B ��d��
@�G�E G��
@��G�E G�
@��LAH�� d������� 
��
@I��  
��& � '   _yieldGapTimeF       GameGlobal
GetModuleCampaignModule
_campaignUIActivityCampaignNewLoadCampaignInfoECampaignTypeCAMPAIGN_TYPE_SUMMER_IIECampaignSummerIIComponentIDECAMPAIGN_SUMMERII_MISSIONECAMPAIGN_SUMMERII_STORY$ECAMPAIGN_SUMMERII_CUMULATIVE_LOGIN%ECAMPAIGN_SUMMERII_PERSON_PROGRESS_1GetSuccCheckErrorCode	m_result_id_localProcessGetLocalProcess_personProgress1CompInfoGetComponentInfo_personProgress1ComponentGetComponent_scoreDatasUISummerActivityTwoScoreData_missionComInfo_current_valuem_current_progress	_item_id
m_item_idGetSummerTwoLevelData_levelDatasGetEntryLevelData_rewardItemCount        _rewardDatas         W      	   	   	   	                                                                                                                                     %   %   %   %   %   %   *   *   *   *   *   *   ,   ,   ,   ,   ,   .   .   .   .   .   .   1   1   1   2   2   2   6   6   6   8   8   8   :   ;   ;   <      self    W   TT    W   res    W   	uiParams    W   campaignModule   W   levelDatasP   W      _ENV >   H       F @ G@� ��@ �   d@�& �    tablesort_rewardDatas         D   F    
   � @ �� � � � `�   ��@  � � �  & �    GetPriority        
   E   E   E   E   E   E   E   E   E   F      a    
   b    
          B   B   C   F   B   H      self          _ENV J   R       G@@ L�� d� 
@ �G @ b@  @ �K   
@ �G @ \ � 
@��L A d@ & �    _rewardDatas_scoreDatasGetRewardDatas_rewardItemCountSortRewardDatas           K   K   K   K   L   L   L   M   M   O   O   O   Q   Q   R      self            T   v    
=   
@@���@  AA �� 
� ���@ � A �� 
� ���@ A A� �� � CAA 䀀
�����@ AA �� � �� $��
 ���C AD�  �� C� $A �A �D��D $A�E AEG�E A
 Ƌ"  � �GAF
@�� �F�F G��� ǁE dA�G�@ LA��AFdA�L�G dA L�G dA & �     _inited _scoreIconGetUIComponentRawImageLoader
scoreIcon_currentValueTexUILocalizationTextcurrentValueUISelectObjectPath	itemTips_tipsSpawnObjectUISelectInfoTopBtn	_backBtnUICommonTopButtonSetDataSetText_current_valueCfg	cfg_item	_item_id
_itemIconIconLogerrorB###[UISummerActivityTwoScoreController] cfg_item is nil ! id --> 
LoadImageInitTypeMissionInfoInitRewardList         b   d         @ @@ $�� �@ ��� � � $@ & �    GameGlobalTaskManager
StartTask
CloseCoro             c   c   c   c   c   c   c   d          _ENVself=   U   V   V   V   V   V   X   X   X   X   X   Y   Y   Y   Y   [   [   [   [   ^   ^   ^   ^   `   `   `   `   a   a   d   e   h   a   j   j   j   j   k   k   k   k   l   m   m   n   n   n   p   p   p   p   p   r   r   r   r   t   t   u   u   v      self    =   	uiParams    =   s   =   btns   =   	cfg_item)   =      _ENV x   ~       � @ �@ & �    CloseDialog           }   }   ~      self       TT            �   �       � @ �@�@� � �@ & �    _tipsSetData           �   �   �   �   �   �      self       itemId       pos            �   �       L @ �@  �  d� ���  AA �@ ��� �� ��  A� ��ǁ��@ �BB ��ǂB �A����& �    GetUIComponentUISelectObjectPath
ScoreInfoSpawnObjects'UISummerActivityTwoTypeMissionInfoItem       GetAllSpawnList       Refresh_levelDatas
_itemIcon           �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       loader      list
      (for index)      (for limit)      (for step)      i           �   �       L @ d@ L�@ ��   d� 
@��G@@ L@� ǀA ,  d@ 
 & � 	   RefreshScoreData_scrollViewGetUIComponentUIDynamicScrollViewRewardListInitListView_rewardItemCount_inited        �   �       �   � @   @� �  �   & �    OnGetRewardItem           �   �   �   �   �   �   �      scrollview       index          self   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self            �   �    *   � � AA  䀀�@ ��  ��$� GA��� �����LB�A � dA L�Bd� ����  @�́BC  �@�BC$� �C�  $B�� ��C � ��$B �D �A����� $��A  �  & �    NewListViewItemRowItemGetUIComponentDynamicUISelectObjectPathgameObjectIsInitHandlerCalled SpawnObjectsUISummerActivityTwoScoreItem       GetAllSpawnList_rewardItemCountGetGameObject
SetActiveRefreshRewardItemInfo	UIHelperRefreshLayoutGetComponentRectTransform         *   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    *   scrollView    *   index    *   item   *   rowPool   *   rowList   *   itemWidget   *   
itemIndex   "      _ENV �   �       � @ � �A@G�@ AL�� � A � GBA �  �B   �@ dA�& �    _inited       _yieldGapTimeRefresh_rewardDatas
_itemIcon        �   �       E   L � �   d@�& �    CanGet           �   �   �   �   �      idx          self �   �       �   � @   @� �@ & �    	ShowTips           �   �   �   �   �   �      itemId       pos          self   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       itemWidget       index       anim      
yieldTime           �   �       � @ �@@��   � �@���@ � A��� �@A�A @  �� �@�& �    Logdebug8###[UISummerActivityTwoScoreController] CanGet idx --> GameGlobalTaskManager
StartTask
GetReward            �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       idx          _ENV �   �    
:   � @ AA  �@�ƀ@ ���� A AA�� ���A � �A$ $A  �$� "  ���A � AB$� G�A G��L����B ��dA�LAC dA G�C L��dA LD �   dA FAD G��d�� L���E �A�  dA ��AD �EF�E $� LF�A�dA��F �A  $A�& �    Lock(UISummerActivityTwoScoreItem_GetRewardaAsyncRequestResNew_personProgress1ComponentHandleReceiveReward_rewardDatasGetScoreValueGetSuccGetRewards
SetStatus%UISummerActivityTwoScoreRewardStatusHasGetSortRewardDatas_scrollViewRefreshAllShownItemShowRewardsGameGlobalEventDispatcher	DispatchGameEventTypeSummerTwoRewardRefresh
GetModuleCampaignModuleCheckErrorCode	m_resultUnLock         :   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    :   TT    :   idx    :   res   :   rewards   .   campaignModule3   6      _ENV �   �    &   �   @ A@F�@ $� F�@ �� d@��AC�����   ���A ��A�� ��B�i�  ���F�A G���d�  @��@�L�B ��  �l  dA�& � LC �A  � dA & �    GameGlobal
GetModule
PetModulepairsIsPetIDassetidtableinsertcount        ShowDialogUIPetObtainShowDialogUIGetItemController         �   �         @ @@ $�� �@ ��  $@� �  A �@ �  $@ & �    GameGlobalUIStateManagerCloseDialogUIPetObtainShowDialogUIGetItemController             �   �   �   �   �   �   �   �   �   �   �   �          _ENVselfrewards&   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   
   self    &   rewards    &   idx    &   
petIdList   &   
petModule   &   (for generator)      (for state)      (for control)      _	      reward	         _ENV.                        <      >   H   >   J   R   J   T   v   T   x   ~   x   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �          _ENV