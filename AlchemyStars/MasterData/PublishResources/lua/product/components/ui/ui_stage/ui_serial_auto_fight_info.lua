LuaS �

xV           (w@V@../PublishResources/lua/product/components/ui/ui_stage/ui_serial_auto_fight_info.lua         H    @ A@  ��@ $@�@@  ���  
@A�
�A�
@B� ��@@ l   
@ �@@ l@  
@��@@ l�  
@ �@@ l�  
@��@@ l  
@ �@@ l@ 
@��@@ l� 
@ �@@ l� 
@��@@ l  
@ �@@ l@ 
@��@@ l� 
@ �@@ l� 
@��@@ l  
@ �@@ l@ 
@��@@ l� 
@ �@@ l� 
@��@@ l  
@ �@@ l@ 
@��@@ l� 
@ �@@ l� 
@��& �    _classUISerialAutoFightInfoUIControllerOpenUISerialFightInfoStateInGame       OutGame       	Finished       ShowOverviewShowDetailOnShowShowGetRewards_InitListView_GetListItemTitle	ShowTipsOnSerialAutoFightWaitTimefinishConfirmBtnOnClickFinishWithTimeBtnOnClickFinishBtnOnClickCloseBtnOnClickShowDetailBtnOnClickShowOverviewBtnOnClickSetItemDataGetChildComponentChkAutoPickReturnBtnOnClickContinueBtnOnClick           !    H   G @ L@� �   d@�G�@ L@� � � d@�G�@ b@  @�
 ��L�A ��  d� 
@��L�B �� d��
@��L�A �  A d� ��C �   ����� D ADA� $ �@  @���� D ADA� $ �@  F E G@� ��E d� ��� �� �@A � �AA � � �F @ $ �G��F  �@ �B )�  ��AB A@� _ G  ��A  �� $A�& �    _detail
SetActive
_overview_overviewInited_overviewItemPoolGetUIComponentUISelectObjectPathOverviewItems_overviewEmptyGetGameObjectoverview_emptyUILocalizationTextoverview_title
_finishedSetTextStringTableGet"str_battle_auto_fight_total_awardstr_battle_auto_fight_got_nowGameGlobal
GetModuleSerialAutoFightModuleGetTotalRewardsSpawnObjectsUIItemipairsSetItemData                 H                                                                                                                                                                                                                                !      self    H   overviewTitle   )   md-   H   rewards/   H   items4   H   (for generator)7   ?   (for state)7   ?   (for control)7   ?   i8   =   asset8   =   item9   =      _ENV #   ^    �   G @ L@� �   d@�G�@ L@� � � d@�F�@ G � �@A d� ��� �� ��A� � �  ��  �� �  LA� d� ��� �� �� � 
�����   A� �A��  �G��"   ��CC ��C��  �C�b   ��CC ��C�� ��C�
���
 ���D �A  @�
@D���D A �B � 
����D A� �B � 
��ǁD ��@ �  �A ��D A� �� � 
����AG A� 䁀
����D A� � � BH "  ������H �I�B	 � $B  ������H �I��	 � $B  ��ǁD ���@ �� �A ǁD ���A �A� � BF �J��
 ��$� FK ��d ���CK @ ���C i�  ��GG LB���_��  ��B  �� dB�& � /   
_overview
SetActive_detailGameGlobal
GetModuleSerialAutoFightModuleGetFightCount       GetTotalCountGetRewardListGetActivityRewardList_matchResult
GetResulttableappendArray_detailAwards_detailInited
_detailSvGetUIComponentUIDynamicScrollViewDetailScrollView_detailScrollRectScrollRectInitListView_detailItemPoolUISelectObjectPathtotal_awards_detailEmptyGetGameObjectdetail_emptyUILocalizationTexttotal_title
_finishedSetTextStringTableGet"str_battle_auto_fight_total_awardstr_battle_auto_fight_got_nowSetListItemCountRefreshAllShownItemGetTotalRewardsSpawnObjectsUIItemipairsSetItemData                 G   I       �   � @   @� �  �   & �    _InitListView           H   H   H   H   H   H   I      scrollView       index          self�   $   $   $   $   %   %   %   %   '   '   '   '   (   (   (   )   )   *   *   +   .   /   /   0   0   1   1   1   2   2   2   2   3   4   5   6   6   7   7   7   7   7   9   9   :   :   :   :   :   <   2   >   @   @   @   A   C   C   C   C   C   D   D   D   D   D   E   E   F   I   E   K   K   K   K   K   L   L   L   L   M   M   M   M   N   N   N   O   O   O   O   O   O   O   Q   Q   Q   Q   Q   Q   R   T   T   T   T   T   U   U   U   W   W   X   X   X   X   X   Y   Y   Y   Y   Z   [   [   [   [   Y   Y   ]   ]   ]   ]   ]   ]   ]   ]   ^      self    �   md   �   	fightCnt   �   	totalCnt   �   rewardList   �   normalRewardList   �   activityRewardList   �   (for index)   3   (for limit)   3   (for step)   3   i    2   awards!   2   	activity"   2   normal#   2   totalTitleT   d   rewardso   �   itemst   �   (for generator)w      (for state)w      (for control)w      ix   }   assetx   }   itemy   }      _ENV `   �       �@@ �  ���
� ��@@  ���
����@A ��A��A �� �@B A� �� � 
� �
@C�ǀ� �C D �@	�
@D�A@ �� $���D�� $A�A@ � $���D�� $A�A@ �A $���D�� $A�A@ �� $���D�  $A�A@ �� $���D�  $A�A@ � $���D�  $A� ��C AF � 	�A@ �� $���D�  $A�A@ � $���D�  $A�A@ �A $���D�  $A�A@ �� $���D�  $A�A@ �� $���D�� $A�A@ � $���D�� $A��
��C �F ��	�A@ �� $���D�  $A�A@ � $���D�  $A�A@ �A $���D�  $A�A@ �� $���D�� $A��F �G� $A  A@ �� $���D�  $A�A@ � $���D�� $A��G$� 
 ��A@ �� $���D�AG �H �A�_�  ��A  �� $A�A@ �� $���D�C $A�A@ �� $���D�C � $A��C AF �� �AI$� �C
 �  
 �� L�Id� �� (��I LJ��d��
B�'A�AJ ��J ��J��F $A AB � �A $� L�K� d��
@�LAL dA L�L dA GC b  �	�L�Ld� �� �� �����AM�� �  ���M N�"  @�GBNb  ��_�� ���N ��N���� � �N �NA $� LBO ��  �l  �  ��  dB @ ���O �A & � @   
_overviewGetGameObject	Overview_detailDetailGameGlobal
GetModuleSerialAutoFightModule	_txtTimeGetUIComponentUILocalizationTexttime
_finished        OpenUISerialFightInfoState	FinishedConfirmBtn
SetActive
ReturnBtnContinueBtnFinishWithTimeBtn
FinishBtn	CloseBtnInGameOutGameOnSerialAutoFightWaitTimeGetWaitTime_matchTypeGetMatchType_towerDesc
MatchType	MT_Towertitle_finishtitle_fighting_fightingNumberGetFightCount_doubleListGetTotalCountGetTicketCountByIndexAttachEventGameEventTypeSerialAutoFightWaitTimeUISelectObjectPath	itemTips_tipsSpawnObjectUISelectInfoShowOverviewChkAutoPickGetMergedActivityRewards        assetidCfg'cfg_activity_drop_item_get_tips_clientGetItemTipsStringTableGetstr_sakura_get_activity_itemShowDialogUIGetItemControllerShowGetRewards         �   �            @ $@ & �    ShowGetRewards           �   �   �   �          self   a   a   a   a   b   b   b   b   c   c   c   c   d   d   d   d   d   g   h   i   i   i   i   j   k   k   k   k   k   k   l   l   l   l   l   l   m   m   m   m   m   m   n   n   n   n   n   n   o   o   o   o   o   o   p   p   p   p   p   p   p   q   q   q   q   r   r   r   r   r   r   s   s   s   s   s   s   t   t   t   t   t   t   u   u   u   u   u   u   v   v   v   v   v   v   w   w   w   w   w   w   w   x   x   x   x   y   y   y   y   y   y   z   z   z   z   z   z   {   {   {   {   {   {   |   |   |   |   |   |   }   }   }   }                     �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       	uiParams       md      st      (for index)�   �   (for limit)�   �   (for step)�   �   i�   �   s�      activityRewardList�   �   itemId�   �   	tipsText�   �   tipsCfg�   �   tipsId�   �   
titleText�   �      _ENV �   �    )   F @ G@� ��@ d� ��� �� �   � ����@Aǀ�� A� �   ���B �AB�� �  @�ǁB�  ��_�� ��B C@�$�   ��B �C�A �� ́C A� � � � �A & �    GameGlobal
GetModuleSerialAutoFightModuleGetMergedReturnHelpRewards               assetidCfg'cfg_activity_drop_item_get_tips_clientGetItemTipsStringTableGet!str_return_system_btn_assistanceShowDialogUIGetItemController         )   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   	   self    )   md   )   returnRewardList   )   itemId   (   	tipsText   (   tipsId   (   tipsCfg      tipsId      
titleText"   (      _ENV �   �    '     @@ ��   �  �@� A�  䀀�@ � �A�$� G����  �� B�LAB�� d����B��BC @ ��C �� ��C ǂ�D LCD � d����D �� �  �A ���E �A��  & �            NewListViewItemRowItemGetUIComponentDynamicUISelectObjectPathgameObjectIsInitHandlerCalled SpawnObjectUIAutoFightAwardsItem       SetData_matchType_doubleList_detailAwards_fightingNumber_GetListItemTitle_matchResultParentParentSr_detailScrollRect        �   �       �   � @   @� �@ & �    	ShowTips           �   �   �   �   �   �      id       pos          self'   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    '   scrollView    '   index    '   row   '   rowPool   '   item   '        �      "   �   �@@ �@ �@ ���� A �@��A � AA ��A $��L�d� �AB �����B �BA �B��BC$���  @�ƀB ���� @� 䀀� ��  & �    _matchType
MatchType	MT_TowerGameGlobal
GetModuleSerialAutoFightModuleTowerModuleGetAutoFightDatas_TowerGetTowerNameByIDStringTableGet'str_battle_auto_fight_tower_name_level       str_battle_auto_fight_number         "   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �                            self    "   index    "   str   "   md
      towerModule      id      name      stage         _ENV         � @ �@�@� � �@ & �    _tipsSetData                          self       itemId       pos            	     	   � @ �@@�@ �@A �� $��@  & �    	_txtTimeSetTextStringTableGetstr_common_ss         	   
  
  
  
  
  
  
  
       self    	   	waitTime    	      _ENV         F @ G@� ��@ d� ��� �@ � A �@ �@A ��A��A � �A �  �@  & � 
   GameGlobal
GetModuleSerialAutoFightModuleCancelSerialAutoFightCloseDialogToastManager
ShowToastStringTableGet!str_battle_serial_fight_finished                                               self       md         _ENV         L @ d@ & �    finish                    self                    L @ d@ & �    finish                    self                    L @ d@ & �    finish                    self            !  $      L @ d@ & �    CloseDialog           #  #  $     self            &  (      L @ d@ & �    ShowDetail           '  '  (     self            *  ,      L @ d@ & �    ShowOverview           +  +  ,     self            0  G   	*   � @ �@�� ����@�A$A A� ��A ��A�B �A�$A � G�B�C �AC����G�B�@��F�C G��� d�  �LA� �A ��������B���������dA�LA� �  dA�& �    AwardNewInitWithCountassetidcountSetFormUIItemFormBaseUIItemScaleLevel3typeStageAwardType	ActivityStringTableGetstr_item_xianshiSetDataicontext1qualitycoloritemIdidactivityTextSetClickCallBack         C  E      E   L � �@� �@ �@d@ & �    	ShowTipsid
transform	position           D  D  D  D  D  D  E     go          selfaward*   1  1  1  2  2  2  2  3  3  3  3  3  3  4  5  5  5  5  5  6  6  7  7  7  7  7  9  9  ;  ;  <  <  =  =  >  >  ?  9  B  E  B  G     self    *   item    *   asset    *   award   *   activityText   *      _ENV I  P      � A@��$���@@ �D  f L�@� e�f  & �    
transformFind GetComponent           J  J  J  J  K  K  L  L  O  O  O  O  P     self       parent       componentTypeName       name       child           R  �   �   L@@ ��  �  d� 
@ �L@@ ��  A d� 
@ �L@@ ��  � d� 
@ �L@@ ��  A d� 
@ �F�B G�� � C d� L@� d� ���   ����@   �� A D AA �� $��� ��ǀA D A� �� $��� ��� B D A� � $��� ��� B D A� �� $��� ����� A D AA � $��� ��ǀA D A� �A $��� ��� B D A� �� $��� ��� B D A� �� $��� ���@  @�� @ � ��@�C  �@����@@ A�  �� � 
� �ǀG � ��@�L� d� [��@��@@ A� �� � 
����@H �@�A�	 䀀
� �� I ���A
 �@��@J G�G ��  ��
 䀀AJ ��G ��
  $��LAJ ǁG �  AB d���� �� LN�OB�N�� @����D ��� ���ʀ���D ��� ���J��������BG  �B����BG  �B�& � 3   _uiAutoPickGetUIComponentRectTransformuiAutoPick_uiovContent
ovContent	_uiTotaltotal_uiDetailScrollViewDetailScrollViewGameGlobal
GetModuleSerialAutoFightModuleGetApsData	IsEnableanchoredPositionVector2      @        �            pa�
sizeDelta�      �      ��������<            �g�X      gameObject
SetActive_uiNotEnoughuiNotEnoughIsPowerEnough_uiAutoPickItemUISelectObjectPathuiAutoPickItem_widgetAutoPickItemSpawnObjectUISerialAutoPickStuffSetTips	itemTipsGetChildComponentLeftSeparatorUILocalizationTexttxtNotEnoughRightSeparator       �      preferredWidth      �?                �   S  S  S  S  S  T  T  T  T  T  U  U  U  U  U  V  V  V  V  V  X  X  X  X  X  X  Y  Y  Y  \  \  ]  ]  ]  ]  ]  ]  ^  ^  ^  ^  ^  ^  _  _  _  _  _  _  `  `  `  `  `  `  `  b  b  b  b  b  b  c  c  c  c  c  c  d  d  d  d  d  d  e  e  e  e  e  e  i  i  j  j  j  j  j  j  l  l  l  l  l  m  m  m  m  m  m  m  n  n  n  n  n  o  o  o  o  o  p  p  p  p  r  r  r  r  r  s  s  s  s  s  t  t  t  t  t  v  w  x  y  y  y  z  z  {  {  {  {  {  |  |  |  |  |  |  ~  ~  ~  ~          �  
   self    �   aps   �   	isEnable   �   leftw   �   txt|   �   right�   �   space�   �   total�   �   txtPreferredWidth�   �   width�   �      _ENV �  �      � @ �@@ƀ@ �� ��@�� � AC  䀀�   � ��@A �@ ̀A�@ & �    GameGlobal
GetModuleSerialAutoFightModuleGetApsData	IsEnablefinishReturnSpirit            �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       go       aps         _ENV �  �      � @ �@@ƀ@ �� ��@�� � AC  䀀�   @�� @ �@��@ � A�$A �A $A �A$A & �    GameGlobal
GetModuleSerialAutoFightModuleGetApsData	IsEnableCancelSerialAutoFightCloseDialogContinueBattle            �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       go       aps      md         _ENVH                                 	      !      #   ^   #   `   �   `   �   �   �   �   �   �   �     �         	    	                          !  $  !  &  (  &  *  ,  *  0  G  0  I  P  I  R  �  R  �  �  �  �  �  �  �         _ENV