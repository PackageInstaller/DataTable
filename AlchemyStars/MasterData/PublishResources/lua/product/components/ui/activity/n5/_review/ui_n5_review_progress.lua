LuaS �

xV           (w@]@../PublishResources/lua/product/components/ui/activity/n5/_review/ui_n5_review_progress.lua             @ A@  ��@ $@�@@  ��@@ l   
@��@@ l@  
@ �@@ l�  
@��@@ l�  
@ �@@ l  
@��@@ l@ 
@ �@@ l� 
@��@@ l� 
@ �& �    _classUIN5ReviewProgressUICustomWidgetOnShowInitWidgetSetDataCollectOnClickReqGetAwardAwardIconOnClickDetailBtnOnClickBtnOnClick                  � @ �@ & �    InitWidget                       self       	uiParams            
       *   L@@ ��    d� 
@ �L@@ �  A d� 
@��L@@ �� � d� 
@ �L@@ �@  d� 
@ �L�B �� d��
@ �L�B �@ d��
@ �L�B �� d��
@ �L�B �@ d��
@ �L@@ �  � d� 
@ �& �    
awardIconGetUIComponentRawImageLoaderselectInfoPoolUISelectObjectPathselectInfo	progressImagepercentUILocalizationTextsliderGetGameObjectcollectCollect
collected
CollectedcantCollectCantCollectawards        *                                                                                                                                    self    *           �    �   
@ �� @ ��@�� 
����@@ � AAA �AA� �� 
�����@ �@B�� 
� ���B ��B�  B ACA� �B ��C��@�� B �@C� B ���� l  �  
���  �AD �D �D����@E� ��E A� � $C�  
��
Â�
�F�OG!@@�@�� d� bC  � ��� 
CG�� �
E�  �
�G�F�G G��D ��  ʃ����H���F��dC��  jB���G �A�D lB  �A�
�I��J D �@��G CJG�D G�����$��"C  @ �
��@ ��  j���F @ BK$� G��ǁK ���G@ LB�d� � ]���A��AL ́�A� �D � �  FJ ��d ��C�  G�I �D �	��J	�@ �D�	� D 
I
�C����  �C��Mi�  ��G�I ��@�
@N�G�N L���� dB�GO L���  dB�GBO L���  dB�G�O L���P �B�D GD \�C�H��ǂ�dB� �GD ��I G��G��
@��G�O L���P �B��P ��ǂ�dB�G@ LB�d� �D ǂI ����J!@@�
 Q�G�N L���  dB�GO L���� dB�GBO L���  dB� �
@N�G�N L���  dB�GO L���  dB�GBO L���� dB�LBQ �     dB & � F   _reviewData
_campaignGetDetailInfo_progressComGetComponentByTypeCampaignComTypeE_CAMPAIGN_COM_POINT_PROGRESS       _progressInfoGetComponentInfoLogdebug[Review] 当前进度为:m_current_progress/m_total_progress_allAwardspairs_progressInfom_progress_rewards        ReviewError&进度奖励配置错误，无奖励:	progressrewardsstatus        d                     tableinsert	ProgressAwardIDassetidStatussort_curAwardIdx��������ipairs
icontainsm_received_progress	ProgressfillAmountProgressPercentpercentSetText%awardsSpawnObjectsUIN5ReviewProgressAward�      SetDataPlayEnterAni       _canCollect 
collected
SetActivecollectcantCollect
awardIcon
LoadImageCfg	cfg_itemIcon	_awardID
StartTask         4   ;       A   �@@ ��@�  �   h��FA@ G��G� �@ �C� f g��C   f  & �           _progressInfom_received_progress           5   5   5   5   5   5   6   6   6   6   6   7   7   5   :   :   ;      p       (for index)      (for limit)      (for step)      i         self k   m       � @ � � `�   ��@  � � �  & �    	Progress           l   l   l   l   l   l   l   m      a       b            �   �       A   �   �@@ � �@���� �    �@��   ��@ � �@�& �    UIN5ReviewProgressEnterAniLockYIELDUnLock             �   �   �   �   �   �   �   �   �   �   �   �   �   �      TT       	lockName         self_ENVdelay�      !   !   !   !   #   #   #   #   #   #   #   %   %   %   %   '   '   '   '   '   '   '   '   '   '   0   0   1   1   2   ;   R   R   S   T   T   T   T   T   U   U   U   V   V   V   V   X   Y   Z   [   \   \   \   ]   ]   ]   ]   ]   ^   _   _   a   b   d   g   g   g   g   g   g   g   g   g   g   g   T   T   i   i   j   m   i   r   s   s   s   s   t   t   t   t   t   t   t   t   u   u   s   s   z   z   z   z   z   z   {   {   {   {   {   {   {   {   }   }   }   }   }   }   ~               �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �         �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    �   data    �   currentProgress   �   totalProgress   �   process   �   isProgressGet    �   hasRewards#   �   (for generator)'   N   (for state)'   N   (for control)'   N   	progress(   L   award(   L   data0   L   (for generator)W   d   (for state)W   d   (for control)W   d   idxX   b   awardX   b   	uiAwardsx   �   delayy   �   (for generator)|   �   (for state)|   �   (for control)|   �   index}   �   ui}   �      _ENV �   �    	   � @ �@    �& � �@@ �@ @  �@ & �    _canCollect
StartTaskReqGetAward        	   �   �   �   �   �   �   �   �   �      self    	   go    	        �   �    H   � @ �@@�� ̀@C  �@���@ A �@��@A ̀�@� � ��A B ���A�䀀�B � $A��B$� "  �	�
@C�  F�C G���D d� �AD ���@�̂�G�D䂀�   ��E �B�  @ �B���  *���E ��E� ��  ���@��F B @ �  �A�����F � @��B  �A�@�G AGA� ��G� $A  & �     AsyncRequestResNewSetSuccLockUIN5ReviewProgress:Collect_progressComHandleReceiveReward_allAwards_curAwardIdx	ProgressUnLockGetSucc_canCollect GameGlobal
GetModule
PetModulepairsIsPetIDassetidtableinsertcount        ShowDialogUIPetObtainShowDialogUIGetItemControllerLogfatalCollect final award failed:
GetResult         �   �         @ @@ $�� �@ ��  $@� �  A �@ �  ,  $@�& �    GameGlobalUIStateManagerCloseDialogUIPetObtainShowDialogUIGetItemController          �   �            @ �@@ $@�& �    SetData_reviewData           �   �   �   �   �          self   �   �   �   �   �   �   �   �   �   �   �   �   �          _ENVselfassets �   �            @ �@@ $@�& �    SetData_reviewData           �   �   �   �   �          selfH   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    H   TT    H   res   H   assets   H   
petIdList   @   
petModule   @   (for generator)"   /   (for state)"   /   (for control)"   /   _#   -   reward#   -      _ENV �   �       � @ �@   ��@@ ��@�  ���
� �� @ � AAA G�� G���@ & �    selectInfoselectInfoPoolSpawnObjectUISelectInfoSetData	_awardID
transform	position           �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       go            �   �       L @ �@  ,  d@ & �    ShowDialogUIN5ReviewProgressAwardDetail        �   �            @ �@@ $@�& �    SetData_reviewData           �   �   �   �   �          self   �   �   �   �   �      self            �   �       L @ �@  ,  d@ & �    ShowDialogUIN5ReviewProgressAwardDetail        �   �            @ �@@ $@�& �    SetData_reviewData           �   �   �   �   �          self   �   �   �   �   �      self                                         
      
      �      �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �          _ENV