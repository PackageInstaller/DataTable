LuaS �

xV           (w@\@../PublishResources/lua/product/share/ui/activity/collect_card/ui_collect_card_content.lua         �    @ A@  $@ �@ A�  � A $@��@  ���@ l   
@���@ l@  
@ ��@ l�  
@���@ l�  
@ ��@ l  
@���@ l@ 
@ ��@ l� 
@���@ l� 
@ ��@ l  
@���@ l@ 
@ ��@ l� 
@���@ l� 
@ ��@ l  
@���@ l@ 
@ ��D l� 
@ ��D l� 
@���E l  
@�� F l@ 
@�� F l� 
@ � F l� 
@�� F l  
@ � F l@ 
@�� F l� 
@ � F l� 
@�� F l  
@ � F l@ 
@�� F l� 
@ � F l� 
@�� F l  
@ � F l@ 
@�� F l� 
@ � F l� 
@�� F l  
@ � F l@ 
@�� F l� 
@ � F l� 
@�� F l 	 
@ � F l@	 
@�� F l�	 
@ � F l�	 
@�� F l 
 
@ � F l@
 
@�� F l�
 
@ �& � 3   require"ui_side_enter_center_content_base_classUICollectCardContentUISideEnterCenterContentBaseDoInitCreateData	IsInlandBigAwardBtnOnClick	GetAwardCheckCardCompleteOnGetAwardBigAwardInfoBtnOnClickBigAwardInfoBtn2OnClickBigCfgSendBtnOnClickWebBtnOnClickWebBtn2OnClickSetOpenUrlRedUICollectCardContentIsAllCollectedOpenUrlUICollectCardContentSaveLocalDB_Enter_WebViewUICollectCardContentCheckLocalDB_Enter_WebViewDoShowDoHide
DoDestroy	_RefreshSetOnlyWebSetBigAward
SetWebBtnSetDescGo2SetActivePointOnQuestItemClickOnHandleOneKeyTakeQuestGetCardBtnOnClickHandleDropCardReqOnHandleDropCardReqGetNewCostItemCountGetUseCostItemGetCostItemCountGetQuestListSetCardListGetCardHaveCountGetCardAwardStatusOnCardClickOnCardClickAwardCheckComOpen	SetTimer    +       $    U   L@@ ��  �  d� 
@ �L@@ ��  A d� 
@ �L@@ ��  d� 
@ �L@@ ��  � d� 
@��L C �@ d��
@��L C �� d��
@ �L C �@ d��
@ �L C �� d��
@ �L C �@ d��
@ �L C �� d��
@ �L C �@ d��
@ �L@@ �� A d� 
@ �L@@ �� A d� 
@ �L@@ �� � d� 
@ �L C �@ d��
@ �F�H G � �@I d� 
@ �F�H G � ��I d� 
@ �F�H G � �@J d� 
@ �G�J 
@ �& � ,   _poolGetUIComponentUISelectObjectPathPool_activePoolActivePool_activeImgImage
ActiveImg_timerPool
TimerPool_bigAwardBtnGetGameObjectBigAwardBtn_bigAwardGotBigAwardGot	_descGo2DescGo2_webBtnWebBtn
_normalGoComOpen_onlyWebGo	ComClose_redGoGetCardRed_desc2UILocalizationText_desc3DescGo3_GetCardBtnTexGetCardBtnTex_WebBtnRed
WebBtnRed_questModuleGameGlobal
GetModuleQuestModule_itemModuleItemModule_svrTimeModuleSvrTimeModule
_campaign_data         U                  	   	   	   	   	   
   
   
   
   
                                                                                                                                                                                                                 #   #   $      self    U      _ENV %   2       G @ L@� d� ��� A AA���
� ���� A �A���
� ���@ �@B�� 
� ���� A AA���
� ���� A �A���
� �& �    
_campaignGetLocalProcess	_cardComGetComponent ECampaignCollectCardComponentIDCOLLECT_CARD
_questComQUEST_cardCfgIDGetComponentCfgId_cardComInfoGetComponentInfo_questComInfo            &   &   &   )   )   )   )   )   *   *   *   *   *   ,   ,   ,   ,   /   /   /   /   /   1   1   1   1   1   2      self       localProcess         _ENV 3   9       F @ b   @ �C � f  C   f  & �    	IsInland            4   4   4   6   6   8   8   9      self          _ENV :   >       � @ �� �@@ G�@�@�& �    BigCfg	GetAwardID           <   <   =   =   =   >      self       go       cfg           ?   G       b   @�� @  � ����@@ ǀ�� ����@  �@��@A ��A��� ��AB @  �� �@�& � 	   GetCardAwardStatusQuestStatusQUEST_CompletedLockUICollectCardContent:GetAwardGameGlobalTaskManager
StartTaskOnGetAward            @   @   B   B   B   B   B   B   B   C   C   C   D   D   D   D   D   D   D   D   G      self       awardid          _ENV H   Y       � @ �@@�@ ǀ@  F�@ ��d���A �BA�B�    �@ �� @ �i�  �A�"  @ �C  f C� f & �    Cfg"cfg_component_collect_card_reward	CardListpairs_cardComInfocard            I   I   I   J   L   M   M   M   M   N   N   N   N   N   N   Q   Q   M   M   U   U   V   V   X   X   Y   
   self       awardid       cfg      	cardList      notHave      (for generator)      (for state)      (for control)      key	      value	         _ENV Z   o    
3   � @ �@��  @ �@���@ � ��   GAA L����  �@ d��  � �L�A � dA��    �LA�d� b   �"  @�F�B G��� d�  @�� �LAC ��   dA L�C dA LD dA ��LA�d� �@ ��D��  ��A�& �    Logdebug.###[UICollectCardContent] OnGetAward awardid:AsyncRequestResNew	_cardComHandleTakeRewardReqUnLockUICollectCardContent:GetAwardGetSucctablecount        ShowDialogUIGetItemControllerCreateData	_Refresh
GetResulterror<###[UICollectCardContent] HandleTakeRewardReq fail! result:         3   [   [   [   [   [   ]   ]   ]   ^   _   _   _   _   _   _   _   _   `   `   `   a   a   a   a   a   a   b   b   b   b   b   b   b   b   c   d   f   c   i   i   j   j   j   l   l   m   m   m   m   m   o      self    3   TT    3   awardid    3   res   3   rewards	   3   result-   2      _ENV p   s       � @ A  L�@ d �@  & �    ShowDialogUICollectCardAwardViewBigCfg           r   r   r   r   r   s      self       go            t   w       � @ A  L�@ d �@  & �    ShowDialogUICollectCardAwardViewBigCfg           v   v   v   v   v   w      self       go            x   |    
   F @ G@� ��  ��@ �� ��@A�d� ��� �  & �    Cfg"cfg_component_collect_card_rewardComponentID_cardCfgIDRewardType                       
   y   y   y   y   y   y   y   z   {   |      self    
   cfgs   
   cfg   
      _ENV }   �       � @ A  G�@ ��@ �A�@�& �    ShowDialogUICollectCardSend	_cardCom
_campaign_id                             �      self       go            �   �       � @ �@ & �    OpenUrl           �   �   �      self       go            �   �       � @ �@ & �    OpenUrl           �   �   �      self       go            �   �       C   � @ �@@��� �@   ���@ ��@� A �@�� π�!�  ��A $� "    �C � � B �@B � �@�& � 
   UICollectCardContentCheckLocalDB_Enter_WebView_questComInfom_close_time_svrTimeModuleGetServerTime����MbP?IsAllCollected_WebBtnRed
SetActive            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       red      
closeTime      svrTime         _ENV �   �       G @ G@� ��@ ��@ˀ  AA � ���A��� � BA�C� ��B � �@�ǂ� �    �@ �C  @ ���  *��f & �    _cardComInfocardCfg"cfg_component_collect_card_rewardComponentID_cardCfgIDRewardType              	CardListpairs            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       cards      cfgs	      cfg
      	cardList      isAllCollected      (for generator)      (for state)      (for control)      key      value         _ENV �   �    L   G @ G@� ��@ ��@�� � A @  ��@A ǀ�� � B AB@�$A & � ǀB ���C ACK�  ��C J��JAD�$� G�D����� E @ $@�G�b    �@ ��  @ �)�  ����A   �BA �AAB $� FB GB�� dB & � �E �E$�� FGBF�  ƂF �����@ ��   ��B ƂG ���� ��@ �C �B ƂH ����B� & � $   _questComInfom_close_time_svrTimeModuleGetServerTime����MbP?StringTableGetstr_collect_card_packet_lockedToastManager
ShowToast_cardComInfocardCfg"cfg_component_collect_card_rewardComponentID_cardCfgIDRewardType              	CardListpairsstr_collect_card_packet_emptyGameGlobal
GameLogicClientInfom_login_sourceMobileClientLoginChannelMCLC_WX�)      https://game.weixin.qq.com/cgi-bin/comm/openlink?noticeid=90303934&auth_appid=wx4fa1b8651cf789f1&url=https%3A%2F%2Fgame.weixin.qq.com%2Fcgi-bin%2Factnew%2Fnewportalact%2F187964%2FHnIJLwWBCCjBe4Ka2piAWw%2Fmain_page%3Fact_id%3D187964%26k%3DHnIJLwWBCCjBe4Ka2piAWw%26pid%3Dmain_page%23wechat_redirectRhttps://youxi.gamecenter.qq.com/m/act/3e308e3780a87062_10178708.html?_wv=1&_wwv=4	SDKProxyGetInstanceOpenUrl	PortraitUICollectCardContentSaveLocalDB_Enter_WebView         L   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    L   
closeTime   L   svrTime   L   tips      cards   L   cfgs   L   cfg   L   	cardList   L   isAllCollected   L   (for generator)    )   (for state)    )   (for control)    )   key!   '   value!   '   tips/   4   info8   L   source9   L   www:   L      _ENV �   �         @ @@ $�� "@  @��@ �@ F A $� @A $� A� �   ]�� ��A � B� � A �@�& � 
   UICollectCardContentCheckLocalDB_Enter_WebViewGameGlobal
GetModuleRoleModule	GetPstIdCollectCardWebViewLocalDBSetInt                   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      pstid      key         _ENV �   �         @ @@ F�@ $� �@ $� A  �   ]�� �@A ��A� � � ����A  ��@  � � �  & �    GameGlobal
GetModuleRoleModule	GetPstIdCollectCardWebViewLocalDBGetInt                    �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      pstid      key	      val         _ENV �   �       G @ L@� d� b   � �L�@ �   d@�L�@ d@ L A d@ G@A L�� d� b    �� �  ���@�� B A @� �A  ǁB �@ 
 Å& �    
_campaignCheckCampaignNew
StartTaskCreateData	_Refresh	_cardComGetReceiveCardsInfo        ShowDialogUICollectCardReceive	_cardCom_inited        �   �       F @ L@� �   d@�& �    
_campaignClearCampaignNew           �   �   �   �   �      TT          self �   �         @ @@ $@ & �    	_cardComClearReceiveCardsInfo           �   �   �   �          self   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       reveiceInfo           �   �       
@@�& �    _inited            �   �      self            �   �       & �                �      self            �         L @ d� �@@  � �@���@ �@ b   ����@ �@ � A �@ �@A �@ ��A �@ ��A �@ @ �� B �@ & � 	   CheckComOpenSetOnlyWebSetDescGo2	SetTimerSetActivePointSetBigAward
SetWebBtnSetCardListSetOpenUrlRed           �   �   �   �   �   �   �   �   �                                    self       
comIsOpen           	     	   � @ �@@ � �@���@ �@@� �@�& �    
_normalGo
SetActive_onlyWebGo        	   
  
  
  
               self    	   open    	                L @ d� �@@ �� �����@ � �FAA G��_@  �CA  C� �@���A � �FAA G�_@  �CA  C� �@�& � 	   BigCfgGetCardAwardStatusID_bigAwardBtn
SetActiveQuestStatusQUEST_Completed_bigAwardGotQUEST_Taken                                                               self       cfg      status         _ENV         G @ L@� ̀@ �  d@  & �    _webBtn
SetActive	IsInland                          self              2   	7   G @ L@� ̀@ �  d@  F�@ G � �@ d@ L�@ d� b    
�F�@ G � �� d@ F�A G � d�� G@� ��� � � F�B G�@��A �� F�@ G��� dA @� �@ F�@ G��� dA G�D L��AE ǁ� �� dA  G�E L��AE ǁ�  � dA  & �    	_descGo2
SetActive	IsInlandLogdebug'###[UICollectCardContent] IsInland() 1'###[UICollectCardContent] IsInland() 2GameGlobal
GameLogicClientInfom_login_sourceMobileClientLoginChannelMCLC_WX$str_collect_card_close_money_wechatstr_collect_card_money_wechat'###[UICollectCardContent] IsInland() 3 str_collect_card_close_money_qqstr_collect_card_money_qq'###[UICollectCardContent] IsInland() 4_desc2SetTextStringTableGet_desc3         7                                                  #  #  #  #  $  %  &  &  &  &  &  )  *  +  +  +  +  /  /  /  /  /  /  /  0  0  0  0  0  0  0  2     self    7   info   6   source   6   desc2   6   desc3   6      _ENV 3  Z   V   G @ L@� d� ��@ �� ��@ � �AA � �@ ��@ ̀�� � A �A � B ����B��B@ �B��$��L�Bd� �C �@��  �  ��C�����AC ��C ��B R� 䁀����  �AD �� �A  @ �"   ��� G�D L��BE ǂ�  � dB  G�E L��� dB���LBF d� bB  @ ��   ��� ��D ��FCE G��� d �B  ��E ��C� �B�� ���E ��C  �B�& �    _questModuleGetDailyQuestVigorousGetQuestList_activePoolSpawnObjectsUICollectCardActivePointGetAllSpawnListd       f             	GetQuest
QuestInfoSetData_activeImgfillAmountmathminGetNewCostItemCountstr_collect_card_box_btn_GetCardBtnTexSetTextStringTableGet_redGo
SetActiveGetCostItemCountstr_collect_card_reget_button         A  C      E   L � �   d@�& �    OnQuestItemClick           B  B  B  B  C     idx          selfV   4  4  4  5  5  6  6  6  6  6  8  8  8  9  :  <  <  <  <  =  >  ?  ?  ?  ?  @  @  A  A  A  C  C  C  A  <  F  F  F  F  F  F  F  J  K  K  L  L  L  L  M  N  N  N  N  N  N  N  O  O  O  O  O  Q  Q  R  R  R  R  S  T  T  T  T  T  T  T  U  U  U  U  U  W  W  W  W  Z     self    V   
activeVal   V   
questList   V   pools   V   	maxPoint   V   sliderWidth   V   (for index)   #   (for limit)   #   (for step)   #   i   "   item   "   questid   "   quest   "   
questInfo   "   getCardTexStr+   V   	itemNew1-   V   	itemNew2-   V   item1@   U   item2@   U      _ENV [  a      � @ �@@��  �@ ��@  �@��@A ��A��� ��AB @  �@ & � 	   Logdebug1###[UICollectCardContent] start get quest awardsLock&UICollectCardContent:OnQuestItemClickGameGlobalTaskManager
StartTaskOnHandleOneKeyTakeQuest            ^  ^  ^  ^  _  _  _  `  `  `  `  `  `  `  a     self       idx          _ENV b  t   	-   � @ �@@�� ǀ@ ���@� � �@ � A AA �@��   ��̀A� �   ����A � �A �@ ̀B �� �@  @ �"   �L�B ��  dA ��F�A G��A dA ��̀C� �A CA� ��$A�& �    AsyncRequestResNew
_questComHandleOneKeyTakeQuestUnLock&UICollectCardContent:OnQuestItemClickGetSuccLogdebug6###[UICollectCardContent] start get quest awards overGetUseCostItemHandleDropCardReqerror9###[UICollectCardContent] get quest awards,item is nil !
GetResultA###[UICollectCardContent] OnHandleOneKeyTakeQuest fail ! result:         -   c  c  c  d  d  d  d  d  e  e  e  g  g  g  g  g  g  h  h  h  h  j  j  k  k  k  k  l  l  l  l  l  n  n  n  n  o  q  q  r  r  r  r  r  t     self    -   TT    -   res   -   item1   $   item2   $   result'   ,      _ENV u  ~      � @ �� �@  @ ��    �A@ � ��$A � ��@ �@A $A & �    GetUseCostItemHandleDropCardReqLogdebug:###[UICollectCardContent] GetCardBtnOnClick,item is nil !            x  x  y  y  y  y  z  z  z  z  z  |  |  |  |  ~     self       go       item1      item2         _ENV �  �   	   � @ AA  �@�ƀ@ ���䀀 � �GAA �  ��   �@ & �    Lock'UICollectCardContent:HandleDropCardReqGameGlobalTaskManager
StartTaskOnHandleDropCardReq            �  �  �  �  �  �  �  �  �  �  �  �  �     self       item1       item2          _ENV �  �   3   @ A@A�  $A �@ A$� D  �AA ��A � @ � ���� @�  ��A  �A�"   ��AB�� �   �b  @���B ��B����  ��� ��AC � @��A ��C �A �D �A ���AD�� �@ ǁ�� @ �A�& �    Logdebug4###[UICollectCardContent] start OnHandleDropCardReqAsyncRequestResNew	_cardComHandleDropCardReqUnLock'UICollectCardContent:HandleDropCardReqGetSucctablecount        ShowDialogUICollectCardOpenCreateData	_Refresh
GetResulterror:###[UICollectCardContent] HandleDropCardReq fail! result:         3   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    3   TT    3   item1    3   item2    3   res   3   cards   3   result-   2      _ENV �  �   5   F @ G@� ��  ��@ �� ��@A��@A�d� � @ �@@��  �@ � ���A��@A��� �@� AAD� �    ���BB �B��$��  ��@�FC LB�d� @�J��J��"   ��BBB �B��$��  ��@�FC LB�d� ����������  ��& �    Cfgcfg_component_collect_itemComponentID_cardCfgIDType       Mail       ID_itemModuleGetItemCount        
RoleAssetNewassetidcount         5   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    5   cfgs1   5   cfgs2   5   cfg1   5   cfg2   5   RoleAsset1   5   RoleAsset2   5   id   "   count   "   id%   1   count)   1      _ENV �  �      L @ d� b@  ���     �� ��@@ �� �  @ �� �   � �& �    GetNewCostItemCountGetCostItemCount           �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       item1      item2           �  �   5   F @ G@� ��  ��@ �� ��@A���A�d� � @ �@@��  �@ � �� B���A��� �@� AAD� �    ��A��B �B��$��  ��@�FC LB�d� @�J��J��"   ��AB�B �B��$��  ��@�FC LB�d� ����������  ��& �    Cfgcfg_component_collect_itemComponentID_cardCfgIDType       Mail               ID_itemModuleGetItemCount
RoleAssetNewassetidcount         5   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    5   cfgs1   5   cfgs2   5   cfg1   5   cfg2   5   RoleAsset1   5   RoleAsset2   5   id   "   count   "   id%   1   count)   1      _ENV �  �      G @ G@� f  & �    _questComInfom_accept_cam_quest_list           �  �  �  �     self       
questList           �  �   ;   F @ G@� ��  ��@ �� ��@A�d� �   
� ��@ � � A � ���A �BǁA B� �A��@���A �@BǀA ,  �@���B ��B G�A \��@ ��B �@C�� �@ �A  AA ��ǁA ǁ��L�C ���d���D ���CD� ��  @����D  ,�  G�D $C ���& �    Cfg"cfg_component_collect_card_rewardComponentID_cardCfgIDRewardType       
_cardListtableinsertsort_poolSpawnObjectsUICollectCardItemGetAllSpawnListGetCardAwardStatusIDGetCardHaveCountSetData_inited         �  �      � @ � � `�   ��@  � � �  & �    ID           �  �  �  �  �  �  �  �     a       b            �  �      E   L � �   d@�& �    OnCardClick           �  �  �  �  �     idx          self �  �      E   L � �   d@�& �    OnCardClickAward           �  �  �  �  �     idx          self;   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    ;   cfgs   ;   (for index)      (for limit)      (for step)      i      pools!   ;   (for index)%   :   (for limit)%   :   (for step)%   :   i&   9   cfg(   9   item)   9   status,   9   
haveCount/   9   	allCount/   9      _ENV �        � @ �@@�@ ǀ@�  FA ��d@��BA ��A�B�    ��Ai�  ���@ ��f�& �    Cfg"cfg_component_collect_card_reward	CardList        pairs_cardComInfocard                                                        
  
  
    
   self       awardid       cfg      	cardList      count      (for generator)      (for state)      (for control)      key	      value	         _ENV         � @ �@@ƀ@ ���  @� 䀀�   � �� A �@��  ��̀A @� 䀀�   � �� A ����  � �� A � ��  & � 	   _cardComInforeceived_rewardstable
icontainsQuestStatusQUEST_TakenCheckCardCompleteQUEST_CompletedQUEST_Accepted                                                                   self       id       gotList         _ENV      
   � @ �@ �@@ G�@䀀�@ � �  �GBA $A & �    
_cardListGetCardHaveCountIDShowDialogUICollectCardInfo_cardComInfo                                      self       idx       cfg      
haveCount                   � @ �@ �@@ G�@�@�& �    
_cardList	GetAwardID                          self       idx       cfg              )      G @ L@� d� O�� ��@ � A �� @ �� � �  �   �  & �    _svrTimeModuleGetServerTime����MbP?_cardComInfom_close_time           #  #  #  #  $  $  %  %  &  &  (  (  )     self       svrTime      endTime           *  6      G @ G@� ��@ � AA ���
� ���@ ��A� �@���@ � B � l  �@ & � 	   _cardComInfom_close_time
_timerObj_timerPoolSpawnObjectUISeasonTalentTimeBaseSet_Time_Texstr_collect_card_timeSetData         /  5        @ @@ A�  $� F�@ G � �   d@ F@A G�� d�� L�� � B �@��� �Bd@ & �    StringTableGetstr_activity_error_107ToastManager
ShowToastGameGlobalEventDispatcher	DispatchGameEventTypeActivityCloseEvent
_campaign_id             0  0  0  0  1  1  1  1  4  4  4  4  4  4  4  4  4  5     tips         _ENVself   +  +  -  -  -  -  -  .  .  .  .  /  /  /  5  /  6     self       endTime         _ENV�                                 $      %   2   %   3   9   3   :   >   :   ?   G   ?   H   Y   H   Z   o   Z   p   s   p   t   w   t   x   |   x   }   �   }   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �     �   	    	                2    3  Z  3  [  a  [  b  t  b  u  ~  u  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �    �                       )     *  6  *  6         _ENV