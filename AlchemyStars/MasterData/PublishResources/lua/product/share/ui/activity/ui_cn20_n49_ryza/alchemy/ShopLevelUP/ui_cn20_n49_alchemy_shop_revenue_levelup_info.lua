LuaS �

xV           (w@�@../PublishResources/lua/product/share/ui/activity/ui_cn20_n49_ryza/alchemy/ShopLevelUP/ui_cn20_n49_alchemy_shop_revenue_levelup_info.lua         .    @ A@  ��@ $@�@@  ��@@ l   
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
@��& �    _class'UICN20N49AlchemyShopRevenueLevelUpInfoUIControllerLoadDataOnEnterOnShowInitWidget_InitBackBtnInitUI_RefreshList_SpawnListItem_SetListItemDataListItemOnClick_OnReceiveRewards	_Refresh
BgOnClickCloseBtnOnClick               	3   �@@ F�@ 䀀
� �� A �@�
����@@ F�A 䀀
� ��@B �@��B � 
� �� C �@�� 
���� � �C �C�@� D AD@� � ��@  �$��
 ���   ���D$� "  ��E AEG�B �� $��
 ��E FG�B �� $��
 ��& �    _campaignModule
GetModuleCampaignModule_campaignTypeECampaignTypeCAMPAIGN_TYPE_INLAND_N20_svrTimeModuleSvrTimeModule_questModuleGameGlobalQuestModule
_campaignUIActivityCampaignNewECampaignCN20ComponentIDECN20_ALCHEMYUIActivityHelperLoadDataOnEnterGetSuccpersonProcessInfoUICN20N49HelperGetComponentInfoalchemyShoppersonProcessGetComponent         3               	   	   	   
   
   
   
                                                                                                                              self    3   TT    3   res    3   componentIds   3      _ENV    &       �@@ ��@��@� A
� ���A ��A� B �� 
����@B �@ ��B �@ ��B �@ & �    _goldItemIDCfgcfg_globalAlchemyMoneyItemID	IntValueitemModuleGameGlobal
GetModuleItemModuleInitWidgetInitUI_InitBackBtn                                "   "   "   "   "   #   #   $   $   %   %   &      self       	uiParams          _ENV (   ?    3   L@@ �   d��
@ �L@@ ��  d��
@ �L@A �� � d� 
@ �L@A �@ � d� 
@ �L@A ��  d� 
@��F�C G�� �   �@  d� 
@��L@A �� � d� 
@��L@A �� A d� 
@ �L@A �� � d� 
@ �L@A �@  d� 
@ �& �    _animGetGameObject
titleText
TitleText	itemTipsGetUIComponentUISelectObjectPath	ItemTips	closeBtnImage	CloseBtn
questPool
QuestPool	backBtnsUIWidgetHelperSpawnObjectUINewCommonTopButton	goldTextUILocalizationText	GoldTextcurLevelTextTitleLevelcurNeedText	NeedTextsliderImage         3   +   +   +   +   -   -   -   -   /   /   /   /   /   1   1   1   1   1   3   3   3   3   3   5   5   5   5   5   5   5   7   7   7   7   7   9   9   9   9   9   ;   ;   ;   ;   ;   =   =   =   =   =   ?      self    3      _ENV B   V    

   G @ L@� �   � �� �    D  d@�& �    	backBtnsSetData         D   N        @� �@ $�� �@ �  �@� ǀ�,  $��  �& �    _timerHandlerGameGlobalTimerAddEventTimes�       TimerTriggerCountOnce          J   L            @ $@ & �    CloseDialog            K   K   K   L          self   G   G   G   G   H   I   I   L   G   M   N          self_ENV
   C   C   N   O   Q   R   S   U   C   V      self    
      _ENV X   �    	^   G@@ L�� ��@ d��
@ �G A L@� ƀA @ �  d@  G�A L@� ƀA B AB$ �   d@  G B L�� d� 
@ �G B L@� �  d��� B �@C�� !�C ���C �@�A �@�����C �@�FAD G���� � d��@  � E B �E$� � ��� B ���� 
���B F��E $A��F �FG�E $� 
 ��
 C��G �GGAF N��G R��M�$� 
 ��H "A  ��
@H��H �	 �A	 $� 
 ��H �I�AG �  $A  ��I �AG ǁH   $A�& � (   _golditemModuleGetItemCount_goldItemID	goldTextSetText	tostringcurLevelTextpersonProcessGetCurProgress_progressListGetProgressList       GetNextLevelNeedProgress        curNeedTextStringTableGet)str_cn20_n49_shop_progress_cur_need_goldsliderImagefillAmountGetCurLevelProgressRate_dynamicListInfo/SortProgressListByCampaignPersonProgressStatus_dynamicListSizetablecount_itemCountPerRow_dynamicListRowSizemathfloor_isDynamicInited
_taskListGetUIComponentUIDynamicScrollView	taskListInitListView_RefreshList         }          �   � @   @� �  �   & �    _SpawnListItem           ~   ~   ~   ~   ~   ~         scrollView       index          self^   Y   Y   Y   Y   Y   Z   Z   Z   Z   Z   Z   [   [   [   [   [   [   [   [   \   \   \   \   ]   ]   ]   ]   _   _   _   `   `   a   a   a   a   a   c   c   c   c   c   c   c   c   f   f   f   f   f   n   n   n   o   p   p   p   p   q   q   q   q   q   r   s   s   s   s   s   s   s   s   s   u   u   u   v   y   y   y   y   y   {   {   |      {   �   �   �   �   �   �   �      self    ^   curProgressLevel   ^   needLevelUPGold   ^   	progress5   ^      _ENV �   �    	   @A@�@L�@�� dA�LA�A B dA �@  � �G@GA�J�& �    ScrollRectcontentlocalPositionSetListItemCountMovePanelToItemIndex                   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       count       list       	resetPos       contentPos           �   �    2     @@ ��   �  �@� A�  䀀�@ � �A�$� G���� �� B�LAB�� �B dA LCd� �A ��B B �A��B���B ���B��C  �@��C$� D�  $C� ��C$� D�� $C�CD � ��$C ���  & �            NewListViewItemRowItemGetUIComponentDynamicUISelectObjectPathgameObjectIsInitHandlerCalled SpawnObjects+UICN20N49AlchemyShopRevenueLevelUpInfoItem_itemCountPerRowGetAllSpawnList       _dynamicListSizeGetGameObject
SetActive_SetListItemData        2   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    2   scrollView    2   index    2   item   2   rowPool   2   rowList   2   (for index)   0   (for limit)   0   (for step)   0   i   /   	listItem   /   
itemIndex   /        �   �       � @ ǀ�A@ �@��$��L�� �A   @��  �B    dA & �    _dynamicListInfopersonProcessGetProgressLevelSetData
_campaign         �   �       E   L � �   d@�& �    ListItemOnClick           �   �   �   �   �      v          self �   �       � @ �@@� � �  @  �� �@�& �    UIWidgetHelperSetAwardItemTips	ItemTips             �   �   �   �   �   �   �   �      matid       pos          _ENVself   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       	listItem       index       	progress      level         _ENV �   �       � @ �@@�� �    ���@ ��@�  �� �@A ǀ�  �@ ��A FB GA��@�& � � @ ��B � l  �@ & �    personProcessComponentIsCloseStringTableGetstr_activity_error_107ToastManager
ShowToastSwitchStateUIStateTypeUIMainStart_HandleReceiveReward         �   �       �   � @   @� �@ & �    _OnReceiveRewards           �   �   �   �   �   �      res       rewards          self   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       	progress       tips	         _ENV �   �       � @ @�  �& � ̀� � �   ����@ � �  �@ �@A �@ @�ǀA ���G� �  �A  �@�& � 	   view GetSuccUIActivityHelperShowUIGetRewards	_Refresh
_campaignCheckErrorCode	m_result         �   �            @ $@ & �    	_Refresh           �   �   �   �          self �   �            @ $@ & �    CloseDialog           �   �   �   �          self   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       res       rewards          _ENV �   �       L @ d@ & �    InitUI           �   �   �      self            �   �       � @ �@ & �    CloseDialog           �   �   �      self       go            �         � @ �@ & �    CloseDialog                    self       go           .                                 &      (   ?   (   B   V   B   X   �   X   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �     �            _ENV