LuaS 

xV           (w@@C:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/lua/product/components/ui/ui_chat/ui_chat_friend_list_panel.lua         1    @ A@  @ $@@@  @@ l   
@@@ l@  
@ @@ l  
@@@ lภ  
@ @@ l  
@@@ l@ 
@ @@ l 
@@@ lภ 
@ @@ l  
@@@ l@ 
@ @@ l 
@@@ lภ 
@ @@ l  
@@@ l@ 
@ &     _classUIChatFriendListPanelUICustomWidgetOnShowOnHideInitExist_HidePanel	_Refresh_RefreshPanelStatus_RefreshDatas_RequestDatas_IsPanelActive_InitScrollView_OnGetFriendItem_RefreshFriendItemInfoBlackListBtnOnClick               1   @@   Aม  ค 
 @A  ค
 @A  ค
@@  Aม ค 
@@  AA ค 
 @A ม ค
 C  D  ค@C  D ค@
ฤภD E AEGE ค@ ภD E มEGE ค@  F ค@ &     _scrollViewGetUIComponentUIDynamicScrollViewFriendList_friendPanelGetGameObjectLeftStretchAnchor_noFriendPanelCenterAnchor_tipsLabelUILocalizationTextTipsCH_friendCountLabelFriendCount_blackListBtnGoBlackListBtn
SetActive
_isInited AttachEventGameEventTypeDeleteFriendUI	_RefreshUpdateFriendInfo_HidePanel         1                                          	   	   	   	   	   
   
   
   
   
                                                                                    self    1   	uiParams    1      _ENV           L @ ฦ@@ วภม@ d@ L @ ฦ@@ ว มม@ d@ &     DetachEventGameEventTypeDeleteFriendUI	_RefreshUpdateFriendInfo                                                self          _ENV    /        @ @@ 
@ @  Aค 
@ Aค 
ภA ค@  B ,  ค@&  	   
_isInited _uiChatController_chatFriendManagerGetChatFriendManager_panelTypeGetCurrentPanelType_HidePanel_RefreshDatas        %   .            @ $@ @@ @ ภ    ภ@ $@ ภ A @A A ร   $@  A ภA $@  ย&  	   _RefreshPanelStatus
_isInited _InitScrollView_scrollViewSetListItemCount_friendCountRefreshAllShownItem           &   &   &   '   '   '   (   (   (   (   *   *   *   *   *   +   +   +   -   .          self                           !   !   !   !   #   #   %   .   %   /      self       uiChatController            1   5       L @ d b@    &  &     _IsPanelActive           2   2   2   2   3   5      self            7   :    	   G @ L@ภ ร   d@G@ L@ภ ร   d@&     _friendPanel
SetActive_noFriendPanel        	   8   8   8   8   9   9   9   9   :      self    	        <   E    	   L @ d b@    &  L@@ ์   d@&     _IsPanelActive_RefreshDatas        @   D         @ @@ @ ร   $@    ภ@ $@  @  A $@ &     _scrollViewSetListItemCount_friendCount_RefreshPanelStatusRefreshAllShownItem           A   A   A   A   A   B   B   B   C   C   C   D          self	   =   =   =   =   >   @   D   @   E      self    	        G   R    #   G @ !@ภ G@ Lภภ ร   d@G A Lภภ ร  d@G@A ภA  Bม@ ค J ภG@ Lภภ ร  d@G A Lภภ ร   d@G @  วภB ฬ รไ ]ภ @C @ &     _friendCount        _friendPanel
SetActive_noFriendPanel_tipsLabeltextStringTableGetstr_chat_no_friend_tips_ch/_chatFriendManagerGetMaxFriendCount_friendCountLabel         #   H   H   H   I   I   I   I   J   J   J   J   K   K   K   K   K   K   K   M   M   M   M   N   N   N   N   P   P   P   P   P   P   Q   Q   R      self    #   str    #      _ENV T   V    	    @ @@ค @ม@ @   ค@&     GameGlobalTaskManager
StartTask_RequestDatas         	   U   U   U   U   U   U   U   U   V      self    	   	callback    	      _ENV X   a       ฬ @ AA  ไ@ว@ ฬภภ@ ไ@ว@ ฬ@มC ไ
ภ ฦภA ว ยA ไ 
ภ ข   @ ภ  ไ@ ฬ@B AA  ไ@&  
   Lock_RequestDatas_chatFriendManagerRequestFriendList_friendListGetFriendList_friendCounttablecountUnLock            Y   Y   Y   Z   Z   Z   Z   [   [   [   [   [   \   \   \   \   \   ]   ]   ^   ^   `   `   `   a      self       TT       	callback          _ENV c   n       G @ b@  @ C   f  G@@ b@  @ C   f  G@ @@ ภ@ค _ @ C   f  C  f  &     
_isInited_uiChatController_panelTypeGetCurrentPanelType           d   d   d   e   e   g   g   g   h   h   j   j   j   j   j   j   k   k   m   m   n      self            p   w       G @ L@ภ ว@ ,  d@ &     _scrollViewInitListView_friendCount        s   u           @   @ ฅ  ฆ   &     _OnGetFriendItem           t   t   t   t   t   t   u      scrollview       index          self   q   q   r   u   q   w      self            y       *   ฬ ภ AA  ไ@ ม  วม$ GAมม สภมLBมA  dA LมBd ยข  @อBC  ภ@BC$ C  $Bภ ยC  ภ$B ฦD วAฤฤย $ไA  ๆ  &     NewListViewItemRowItemGetUIComponentDynamicUISelectObjectPathgameObjectIsInitHandlerCalled SpawnObjectsUIChatFriendItem       GetAllSpawnList_friendCountGetGameObject
SetActive_RefreshFriendItemInfo	UIHelperRefreshLayoutGetComponentRectTransform         *   z   z   z   {   {   {   {   |   |   |   }   ~   ~   ~   ~                                                                                       self    *   scrollView    *   index    *   item   *   rowPool   *   rowList   *   itemWidget   *   
itemIndex   "      _ENV        	   ฬ ภ GA@ G@ วม@ A ไ@ &     Refresh_friendList_panelType_chatFriendManager_uiChatController                                      self       itemWidget       index                       @ A  G@ ค@ &     ShowDialogUIChatBlackListController_chatFriendManager                             self       go           1                                          /      1   5   1   7   :   7   <   E   <   G   R   G   T   V   T   X   a   X   c   n   c   p   w   p   y      y                               _ENV