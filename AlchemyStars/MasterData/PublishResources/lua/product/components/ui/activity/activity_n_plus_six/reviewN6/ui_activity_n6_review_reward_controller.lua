LuaS �

xV           (w@�@../PublishResources/lua/product/components/ui/activity/activity_n_plus_six/reviewN6/ui_activity_n6_review_reward_controller.lua         C    @ A@  ��@ $@�@@  ��@@ l   
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
@ �& �    _class#UIActivityN6ReviewRewardControllerUIControllerLoadDataOnEnterRefreshDataOnShowOnHide
CloseCoroShowBtnOnClick	ShowTipsRefresh
RefreshUIRefreshRedPointSelectRewardItemRefreshSelectItemLeftBtnOnClickRightBtnOnClickSetLastPageInfoPlayPageAnimationGetRewardBtnOnClickGetRewardsShowRewardsReviewBtnOnClick           $    
:   A@ �@F�@ $� 
 �AA �A$� 
 �A �A�� � B BBF�B G��$A �   ��C$� "A  ��@ AC��C�A ���� $A A "A    �& � A AD$� 
 �D "A    �& � D �D��B ��B$��
 �D AE��B ��B$��
 ��E $A & �    _campaignModuleGameGlobal
GetModuleCampaignModule
_campaignUIActivityCampaignNewLoadCampaignInfoECampaignTypeCAMPAIGN_TYPE_REVIEW_N6ECampaignReviewN6ComponentIDQUESTGetSuccCheckErrorCode	m_result_id_localProcessGetLocalProcess_questComponentGetComponent_questComponentInfoGetComponentInfoRefreshData         :                                                                                                                                                            "   "   "   "   "   "   #   #   $      self    :   TT    :   res    :   	uiParams    :      _ENV &   :    1   G@@ L�� d� 
@ �G@@ L�� � @ d@�A  ��A ��A� @ � ��@��� 
����@A ! B  �
@�   
� ��@ �@A A � ��  �A  � AB �A��@ C�C ����  � � CB����ǁB �B  BBʁ�@�& �    _questInfoList_questComponentGetQuestInfo#SortQuestInfoByCampaignQuestStatus       _pageCountmathceil               _pageDatas         1   '   '   '   '   (   (   (   (   *   +   +   +   +   +   +   +   ,   ,   ,   -   /   /   0   0   0   0   1   2   2   2   2   3   3   3   3   3   4   4   5   5   5   2   8   8   8   8   8   0   :      self    1   onePageCount	   1   (for index)   0   (for limit)   0   (for step)   0   i   /   	pageData   /   (for index)   *   (for limit)   *   (for step)   *   j   )   data$   )      _ENV <   a    [   
@@���@  ���
� ���@ � ���
�����@ ��A  �@��@A ��A� �@��@� 
� ��@B � A� �� �@CA� 䀀
� �� C ���l  �@��@B A� � � A��� $��
 ���@ � $��
 ���@ �� $��
 ���@ � $��
 ���@ �� $��
 ���@ � $��
 ��AB �� �� $� 
 ���@ �A $��
 �AB �� �A $� 
 �H �A�  $A�
@I��I $A �I �J �AJǁJ $A �I �J ��J�K $A & � -   _currentPage       	_showBtnGetGameObjectShowBtn
_btnPanel	BtnPanel
SetActive_buildingDatasGetUIComponentUISelectObjectPathTopBtn	_backBtnSpawnObjectUICommonTopButtonSetData	itemTips_tipsUISelectInfo_leftBtnGoLeftBtn_leftRedPointLeftRedPoint_rightBtnGo	RightBtn_rightRedPointRightRedPoint_rewardRedPointRewardRedPoint_pageLabelUILocalizationTextPage_buildingIconBuildingIcon_buildingIconLoaderRawImageLoader_currentSelectQuest 
RefreshUIAttachEventGameEventTypeShowItemTips	ShowTipsNPlusSixBuildingRewardGetRefresh         H   K         @ @@ $�� �@ ��@ � A$@� @ @A $�� �A ��� � � $@ & �    GameGlobalEventDispatcher	DispatchGameEventTypeNPlusSixBuildingMainRefreshTaskManager
StartTask
CloseCoro             I   I   I   I   I   I   I   J   J   J   J   J   J   J   K          _ENVself[   =   >   >   >   >   ?   ?   ?   ?   @   @   @   @   A   A   A   A   C   C   D   D   D   D   F   F   F   F   G   G   K   G   M   M   M   M   O   O   O   O   Q   Q   Q   Q   R   R   R   R   S   S   S   S   T   T   T   T   U   U   U   U   V   V   V   V   V   W   W   W   W   X   X   X   X   X   Y   Y   Y   Y   \   ^   ^   _   _   _   _   _   `   `   `   `   `   a      self    [   	uiParams    [   btns   [   s#   [      _ENV c   f       L @ �@@ ǀ��@ d@ L @ �@@ � �AA d@ & �    DetachEventGameEventTypeShowItemTips	ShowTipsNPlusSixBuildingRewardGetRefresh            d   d   d   d   d   e   e   e   e   e   f      self          _ENV h   l    	   � @ A  �@���@ �@ ��@ A  �@�& �    Lock+UIActivityNPlusSixMainController_CloseCoroCloseDialogUnLock        	   i   i   i   j   j   k   k   k   l      self    	   TT    	        o   r    	   G @ L@� �   d@�G�@ L@� � � d@�& �    	_showBtn
SetActive
_btnPanel        	   p   p   p   p   q   q   q   q   r      self    	        t   v       � @ �@�@� � �@ & �    _tipsSetData           u   u   u   u   u   v      self       itemId       pos            x   {       L @ d@ L@@ d@ & �    RefreshData
RefreshUI           y   y   z   z   {      self            }   �    C   G @ !@�  �G�@ L�� �   d@�� �G�@ L�� � � d@�G @ � A !@  �G@A L�� �   d@�� �G@A L�� � � d@�G�A L�� � @  GA �@�d@�L@B d@ G�B � @ G�� ��B  AA �� ̀CA� �� �@ �@D� 
� �� D �@    �& � �@  � AA  ���D ǁ�́�G�� ��D �  �A����� E �@ & �    _currentPage       _leftBtnGo
SetActive_pageCount_rightBtnGo_pageLabelSetText/RefreshRedPoint_pageDatasGetUIComponentUISelectObjectPathContentSpawnObjects!UIActivityNPlusSixRewardInfoItem_rewardItemsGetAllSpawnListRefresh_questComponentRefreshSelectItem        C   ~   ~   ~                  �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    C   	pageData%   C   	contents)   C   (for index)7   @   (for limit)7   @   (for step)7   @   i8   ?        �   �    a   G @ !@�  �G�@ L�� �   d@� �C   �@  � @ �@�A  �@��A �A�A   AB  ��ǂC�$� F�A G��@@ �C �   ��A�b@    �� ���@ ��@ � �@�G @ � B !@  �G@B L�� �   d@� �C   � @ �@@� B A  �@��A �A�A   AB  ��ǂC�$� F�A G��@@ �C �   ��A�b@    �� ��@B ��@ � �@�C   �@  ǀB � �A  �@���B �A�AA�� ƁA ����@ �C �   �� ���B ��@ � �@�& �    _currentPage       _leftRedPoint
SetActive_pageDatasStatusQuestStatusQUEST_Completed_pageCount_rightRedPoint_questInfoList_rewardRedPoint         a   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    a   hasRed	   %   (for index)   !   (for limit)   !   (for step)   !   i       	pageData       (for index)      (for limit)      (for step)      j      data      status      hasRed/   K   (for index)3   G   (for limit)3   G   (for step)3   G   i4   F   	pageData6   F   (for index)9   D   (for limit)9   D   (for step)9   D   j:   C   data;   C   status=   C   hasRedL   a   (for index)P   \   (for limit)P   \   (for step)P   \   iQ   [   statusU   [      _ENV �   �       
@ ��@@ �@ & �    _currentSelectQuestRefreshSelectItem           �   �   �   �      self       quest            �   �    0   G @ b@    �& � A@  � @ �  �@  h@�G@ G�L��d� ��@ ��@�G@ G�L��� dA� �G@ G�L��  dA�g �G�@ b   ��G@A L�� �   d@�G�@ L�� d� � B �@B�� �@�� �G@A L�� �   d@�& �    _rewardItems       	GetQuest_currentSelectQuestSetSelectStatus_buildingIcon
SetActive
QuestInfo_buildingIconLoader
LoadImageIcon        0   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    0   (for index)      (for limit)      (for step)      i	      
questInfo&   *        �   �       F @ G@� ��@ ��@d@ G A !@�   �& � L�A d@ G A N@� 
@ �L�A d@ L B d@ & � 	   AudioHelperControllerPlayUISoundAutoReleaseCriAudioIDConstN6PageTurn_currentPage       SetLastPageInfo
RefreshUIPlayPageAnimation            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self          _ENV �         F @ G@� ��@ ��@d@ G A �@A !@   �& � L�A d@ G A M�� 
@ �L B d@ L@B d@ & � 
   AudioHelperControllerPlayUISoundAutoReleaseCriAudioIDConstN6PageTurn_currentPage_pageCountSetLastPageInfo       
RefreshUIPlayPageAnimation            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �                  self          _ENV      &   L @ �@  �  d� ��� A AA ��A ��@���A � A �� � @ A �A � ���� � $A �$� "A    �& � AA � �A hA�GL����C @  dB�g�& �    GetUIComponentUILocalizationText	LastPageSetText_currentPage/_pageCount_pageDatasUISelectObjectPathLastContentSpawnObjects!UIActivityNPlusSixRewardInfoItemGetAllSpawnList       Refresh_questComponent        &                             	  	  	  	  
  
  
  
                                    	   self    &   lastPageLabel   &   	pageData   &   	contents   &   rewardItems   &   (for index)   %   (for limit)   %   (for step)   %   i   $                F @ G@� d�� L�� �      d@ & �    GameGlobalTaskManager
StartTask                 E   L � �@  d@�E   L�� ��   d� �@� � �@���� �    �@��   �@BA  �@�& � 
   Lock5UIActivityN6ReviewRewardController_PlayPageAnimationGetUIComponent
AnimationAnimPlayuieff_N6_reward_SwitchYIELD�      UnLock                                                          TT       
animation	         self_ENV                      self          _ENV    "      F @ G@� d�� L�� ��@    d@ & �    GameGlobalTaskManager
StartTaskGetRewards            !  !  !  !  !  !  !  "     self          _ENV $  I   Q   �   �   A@  A  � ��A@ ǁ�́�� �@ A � � @GB@ G���@�@��  !@�  �& � ̀A A� �@��   A A  � �  hA�FB LB�d� ��B ��B � @���C� ��  _@A@ �  ���   �  \��  (� ��@Gă�@'��g�@A� �LAC ��dA�� �F�C G��� dA FAD G��d�� L���E �A�dA�L�E �� dA�& �           _questInfoListStatusQuestStatusQUEST_Completed        Lock.UIActivityN6ReviewRewardController_GetRewardsAsyncRequestResNew_questComponentHandleQuestTakeIDShowRewardsLogerrorGetRewards errorGameGlobalEventDispatcher	DispatchGameEventTypeNPlusSixBuildingRewardGetUnLock         Q   %  &  &  &  &  &  '  '  '  '  (  (  (  (  )  )  )  )  )  &  -  -  -  .  1  1  1  2  3  4  4  4  4  5  5  5  6  6  6  6  6  6  6  6  7  7  8  8  ;  ;  <  <  <  <  =  =  =  =  <  4  B  B  C  C  C  C  E  E  E  E  G  G  G  G  G  G  G  H  H  H  I     self    Q   TT    Q   
questList   Q   (for index)      (for limit)      (for step)      i      status
      rewards   Q   ret   Q   (for index)    <   (for limit)    <   (for step)    <   i!   ;   res$   ;   tmpRet,   ;   tmpRewards,   ;   (for index)5   ;   (for limit)5   ;   (for step)5   ;   i6   :      _ENV K  `   &   �   � @ �@��@ � �@ @� $@�L��BAd��b   �F�A G��� � dB�)�  ����A B@ $�   ��@��B �� � ,  $A�& � C �A �� $A & �    GameGlobal
GetModule
PetModulepairsIsPetIDassetidtableinsertcount        ShowDialogUIPetObtainShowDialogUIGetItemController         X  [        @ @@ $�� �@ ��  $@� �  A �@ �  $@ & �    GameGlobalUIStateManagerCloseDialogUIPetObtainShowDialogUIGetItemController             Y  Y  Y  Y  Y  Y  Z  Z  Z  Z  Z  [         _ENVselfrewards&   L  N  N  N  N  O  O  O  O  P  P  P  P  P  Q  Q  Q  Q  Q  O  O  T  T  T  T  T  T  U  V  W  [  U  ]  _  _  _  _  `  	   self    &   rewards    &   
petIdList   &   
petModule   &   (for generator)      (for state)      (for control)      _	      reward	         _ENV b  �   h   G @ L@� d� _�� @���@ � A� � �� !@A����A ��A� B �@�� �  �@  & � �   ��B � �  � �    �A \� �A (�� �F�C L��d� �BDJ���B �BB��D�� J���B �BB�BE�� J���B �BB��E�� J���B �BB�BF�� J����F ��C�� �  CD���GAC � �C hC�FDG L��d� ���EC
GG��
�D ��@ �H	�� ��D�g���J��F�@ G�� ��dC�'��ACL�H �	   @ �  �� B CBAC	 $ dA  & � &   _buildingDatasGetCanReviewStory tablecount        ToastManager
ShowToastStringTableGet!str_discovery_no_can_review_plotCfg%cfg_component_n_plus_six_plot_review       DiscoveryStageNewidID	longDescDesnameName	stageIdxStageIndexTitle	fullname	FullNameDiscoveryStoryListstageId
StoryListDiscoveryStoryInit       insertliststoryShowDialogUIPlot'str_n_plus_six_plot_review_stage_title         h   c  c  c  d  d  d  d  d  d  d  d  e  e  e  e  e  e  e  f  h  i  i  i  i  j  j  k  k  k  k  l  l  n  n  n  o  o  p  p  p  p  p  q  q  q  q  q  r  r  r  r  r  s  s  s  s  s  u  u  u  v  w  w  x  y  y  y  y  z  z  z  {  {  {  {  {  {  |  |  |  |  |  y  ~    �  �  �  �  �  k  �  �  �  �  �  �  �  �  �  �  �  �  �     self    h   	storyIds   h   canReviewStages   h   cfgs   h   (for index)   [   (for limit)   [   (for step)   [   i   Z   cfg    Z   	curStage#   Z   
storyList<   Z   slist=   Z   storyListCfg@   Z   (for index)C   S   (for limit)C   S   (for step)C   S   iD   R   storyG   R   
tempStage\   h      _ENVC                        $      &   :   &   <   a   <   c   f   c   h   l   h   o   r   o   t   v   t   x   {   x   }   �   }   �   �   �   �   �   �   �   �   �   �   �   �   �     �                  "     $  I  $  K  `  K  b  �  b  �         _ENV