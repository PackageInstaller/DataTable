LuaS �

xV           (w@V@../PublishResources/lua/product/components/ui/activity_review/ui_review_progress.lua         (    @ A@  ��@ $@�@@  ��@@ l   
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
@��& �    _classUIReviewProgressUICustomWidgetInitWidgetOnShowOnHideSetData_OnUIChanged	_RefreshCollectOnClick_OnReceiveRewardsAwardIconOnClickDetailBtnOnClickBtnOnClick               %   L@@ ��    d� 
@ �L@@ �  A d� 
@��L@@ �� � d� 
@ �L@@ �@  d� 
@ �L�B �� d��
@ �L�B �@ d��
@ �L�B �� d��
@ �L�B �@ d��
@ �& �    
awardIconGetUIComponentRawImageLoaderselectInfoPoolUISelectObjectPathselectInfo	progressImagepercentUILocalizationTextsliderGetGameObjectcollectCollect
collected
CollectedcantCollectCantCollect        %   	   	   	   	   	                                                                                                      self    %                  � @ A@ �@G�@ �@ � A �@ & �    AttachEventGameEventTypeAfterUILayerChanged_OnUIChangedInitWidget                                       self       	uiParams          _ENV            L @ �@@ ǀ��@ d@ & �    DetachEventGameEventTypeAfterUILayerChanged_OnUIChanged                                  self          _ENV #   ;    )   
� ��   � �ǀ@�@    ���  
���
@ �̀� � 
���� A � �� 
�����A ̀�F�B G��A � 
����@B ���� 
� �� D �@�� G�C G��� ǁC �A�]���@�̀E C� �@�& �    _cfg_awardPrefabNamePrefabProgressAwardUIReviewProgressAward.prefab_reviewData_campaignTypeActivityType
_campaignGetDetailInfo_progressComGetComponentByTypeCampaignComTypeE_CAMPAIGN_COM_POINT_PROGRESS       _progressInfoGetComponentInfoLogdebug[Review] 当前进度为:m_current_progress/m_total_progress	_Refresh         )   $   %   %   %   %   %   %   %   (   )   )   )   +   +   +   +   -   -   -   -   -   -   -   /   /   /   /   1   1   1   1   1   1   1   1   1   1   :   :   :   ;      self    )   data    )   cfg    )      _ENV =   ?       L @ d@ & �    	_Refresh           >   >   ?      self            A   �    �   �   
� ��@@ ǀ@ ���� ���A@�� �ƁA � @��A��B �A�@ K�  JB��A�CJ����A���  *A�� B �@C� @ ,  �@�
�C�� D � @ � @��B �A��@ �DG�D䁀�A  @ �
@�@ ���  *��� E ǀE ���� � ������@F ��F�E �E$� A� A�@�� G �@G�   � A� �@ � �H �� �@  D @ $ �LBH���C G�H GÁG����E ��E�� �� �� dB  b   @�GIb  � �LI��dB�)�  ���C _�C  �A  � "  � �G�H \�bA    �G�C 
@�G�H ��C G��G��
@��G�I L���J �A�BI ��ǁ�dA�"  @�
 ˕GAK L���� dA�G�K L���  dA�GL L���  dA���G�E L��d� ��H ǁC ����H!@@�
@̕GAK L���  dA�G�K L���� dA�GL L���  dA� �
 ˕GAK L���  dA�G�K L���  dA�GL L���� dA�& � 2   _allAwardspairs_progressInfom_progress_rewards        ReviewError&进度奖励配置错误，无奖励:tableinsert	ProgressAwardIDassetidsort_curAwardIdx��������ipairs
icontainsm_received_progress	Progress	progressfillAmount_reviewDataProgressPercentd       percentSetText%UIWidgetHelperSpawnObjectsawardsUIReviewProgressAward_awardPrefabNameSetData_allAwards	ProgressPlayEnterAni	_awardID
awardIcon
LoadImageCfg	cfg_itemIcon_canCollect 
collected
SetActivecollectcantCollect         K   M       � @ � � `�   ��@  � � �  & �    	Progress           L   L   L   L   L   L   L   M      a       b            ^   d       C   � @ �@@ƀ� ����  AA����     �C � f  & �    table
icontains_progressInfom_received_progress_allAwards	Progress             _   `   `   `   `   `   `   `   `   `   `   a   c   d      index       	received         _ENVself�   B   B   C   C   C   C   C   D   D   D   E   E   E   E   G   G   G   G   G   G   G   G   G   C   C   I   I   J   M   I   Q   R   R   R   R   S   S   S   S   S   S   S   S   T   T   R   R   Y   Y   Y   Y   Y   Y   Z   Z   Z   Z   Z   Z   Z   Z   \   \   \   \   \   \   \   \   \   d   g   g   g   g   h   h   h   h   h   h   h   h   h   h   h   h   h   i   i   i   i   i   j   j   j   g   g   n   n   n   n   n   o   o   o   o   o   o   o   o   p   p   p   p   p   q   q   q   q   q   q   q   q   r   r   t   u   u   u   u   v   v   v   v   w   w   w   w   w   y   y   y   y   y   y   y   y   y   z   {   {   {   {   |   |   |   |   }   }   }   }   }      �   �   �   �   �   �   �   �   �   �   �   �   �      self    �   	playAnim    �   (for generator)      (for state)      (for control)      	progress      award      (for generator)"   /   (for state)"   /   (for control)"   /   idx#   -   award#   -   	uiAwardsF   �   	checkFunG   �   (for generator)J   b   (for state)J   b   (for control)J   b   indexK   `   uiK   `   	isAllGetg   �      _ENV �   �       � @ �@    �& � �@@ ��@�@ GA AAAl  �@ & �    _canCollect_progressComStart_HandleReceiveReward_allAwards_curAwardIdx	Progress        �   �       �   � @   @� �@ & �    _OnReceiveRewards           �   �   �   �   �   �      res       rewards          self   �   �   �   �   �   �   �   �   �   �   �   �   �      self       go            �   �       � @ @�  �& � ̀� � �   ����@ � �  �@ �@A �@ @�ǀA ���G� �  �A  �@�& � 	   view GetSuccUIActivityHelperShowUIGetRewards	_Refresh
_campaignCheckErrorCode	m_result         �   �            @ $@ & �    	_Refresh           �   �   �   �          self �   �        & �                �              �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       res       rewards          _ENV �   �       � @ �@   ��@@ ��@�  ���
� �� @ � AAA G�� G���@ & �    selectInfoselectInfoPoolSpawnObjectUISelectInfoSetData	_awardID
transform	position           �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       go            �   �       L @ �@  �@ G�@ d@�& �    ShowDialogUIReviewProgressAwardDetail_campaignType_cfg           �   �   �   �   �   �      self            �   �       L @ �@  �@ G�@ d@�& �    ShowDialogUIReviewProgressAwardDetail_campaignType_cfg           �   �   �   �   �   �      self           (                                                 #   ;   #   =   ?   =   A   �   A   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �          _ENV