LuaS �

xV           (w@�@E:/depot_matchsrpg/matchsrpg/b/1505/client/Assets/../PublishResources/lua/product/components/ui/aircraft/tactic/ui_aircraft_tactic_tape_list.lua         "    @ A@  ��@ $@�@@  ��@@ l   
@��@@ l@  
@ �@@ l�  
@��@@ l�  
@ �@@ l  
@��@@ l@ 
@ �@@ l� 
@��@@ l� 
@ �@@ l  
@��& �    _classUIAircraftTacticTapeListUICustomWidgetOnShowInitWidgetSetDataplayBtnOnClick	onScroll	_newItem
tryScroll	openGiftopenGiftN8    	              � @ �@ �@@ ��@�  l  �@ 
@A���A ��A  �@�
@B�& � 
   InitWidgetscrollViewInitListView        _tipIsShown _scrollTip
SetActive_isInit        
          �   � @   @� �  �   & �    	_newItem                                   scrollview       index          self               	                                 self       	uiParams               #       L@@ ��  �  d� 
@ �L@@ �@ �  d� 
@ �G A G�� 
@ �G A G@� G�� G�� 
@ �L@C �� d��
@ �G A G�� L � �   d@�& �    scrollViewGetUIComponentUIDynamicScrollViewScrollView_scrollRectScrollRect	_contentcontent_scrollWidth	viewportrectwidth_scrollTipGetGameObjecttiponValueChangedAddListener           !       E   L � �   d@�& �    	onScroll                           !      pos          self                                                                              !      #      self            %   N    M   
� �
���
@ �,  
 ���@  � GA LA��   dA GA L��dA G�A b  ��C  �B �� � ���A ��@ �C� @ ���  *�bA    �
@G�B G�GA���C  @@ �` ��  �CA  C� 
@�G�B bA   �GD b  @�GAD L���  dA�
�D���G�B b  ��GD bA   �GAD L���� dA�
 E�LAE ǁE ���dA�GF b    �
�D�& �    _activityN8_packCount
_tapeList	_onClickscrollViewSetListItemCountRefreshAllShownItem
_curSelctipairs 	_showTip	_contentrectwidth_scrollWidth        _tipIsShown_scrollTip
SetActive 	onScroll_scrollRectnormalizedPosition_isInit         +   -       �   � @A@ E  �� �  �@ & �    
StartTask
tryScroll           ,   ,   ,   ,   ,   ,   ,   -      data       index          selfM   &   (   )   -   -   .   .   .   0   0   0   0   0   1   1   1   3   3   3   4   5   5   5   5   6   6   6   7   7   5   5   <   <   =   A   A   A   A   A   A   A   A   A   A   A   B   B   B   B   B   B   C   C   C   C   D   D   E   E   E   E   E   E   F   F   F   F   G   I   I   I   I   K   K   K   L   N      self    M   	tapeList    M   
packCount    M   activityN8    M   count   M   found   "   (for generator)      (for state)      (for control)      i      data         _ENV P   W       � @ �@  ���@@ ��@��@ � �A �  �@  & � ��A � G@ �B �@��@B ��B��B � ��@ & �    
_curSelctToastManager
ShowToastStringTableGet&str_aircraft_tactic_select_tape_firstShowDialogUITacticTapeInfo_activityN8AudioHelperControllerPlayUISoundAutoReleaseCriAudioIDConstN8DefaultClick            Q   Q   Q   R   R   R   R   R   R   R   S   U   U   U   U   U   V   V   V   V   V   W      self       go          _ENV Y   a       � @ �   ���@�  � � ���@ �   @�� A �@A  �@�
���@�� @ �   ���@�  �@����@ �@   �� A �@A� �@�
���& �    	_showTipx�C�l���?_tipIsShown_scrollTip
SetActive            Z   Z   Z   Z   Z   Z   Z   Z   Z   [   [   [   [   \   \   ]   ]   ]   ]   ]   ]   ]   ]   ]   ^   ^   ^   ^   _   a      self       pos            c   �    S     @@ ��   �  �@@̀� A�  䀀A �A ǁ�$� G��bA    �� LAB�� d����B !�����  @ �BC �  �C �A�����C ��B ������@ � �BC D _�  �C  � G�C �A��A��� ��D�  ���A��� ��D ����AEA� �A���E�A ���A��� �F� �A��A��� ��D ����AEA� �A���E�A �A�� ��C  �A��  & �                   NewListViewItemitemGetUIComponentDynamicUISelectObjectPathgameObjectIsInitHandlerCalledSpawnObjectUITacticTapeItem_packCountSetData	_onClick_isInit
_tapeList
_curSelctGetGameObjectactiveSelfGetComponent
AnimationPlayuieff_Tape_InStop
SetActive        S   d   d   e   e   g   h   h   h   i   i   i   i   j   j   j   k   n   n   n   o   o   o   p   p   p   p   p   p   p   p   r   r   r   r   s   s   s   s   s   s   s   s   s   s   s   u   u   u   u   u   v   v   v   v   v   w   w   w   x   x   x   z   z   z   z   z   {   {   {   {   {   |   |   |   }   }   ~   ~   ~   ~   ~   �   �   	   self    S   scrollview    S   index    S   item   S   	cellPool   S   itemWidget   S   data"   -   anim7   <   animG   Q        �   �    V   @ A@$A �  A�  �A� �A���AA BB���A �ABD  �� @B@ �@  ��� ��@ �@���b  ����B � �B���A �C �AC �� �B���C �� � �B��D � �B��    ��BD ��D�� �B �E �   �& � �@ �B@�B 
� ��BE ��E��� ��EF CF@��B ���BD ��D�� �B ��F �   ��G CG @  �B � ��G �G @  �B & �    _scrollRectStopMovement�                     _scrollWidth	_contentanchoredPositionx��������Lock
FocusTapeDOLocalMoveX      �?YIELD�      UnLockLogfatal点击1个卡带
_curSelctGameGlobalEventDispatcher	DispatchGameEventType"AircraftTacticOnSelectItemChanged点击1个礼包_activityN8
StartTaskopenGiftN8	openGift         V   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   
   self    V   TT    V   idx    V   data    V   
tapeWidth   V   padding   V   left	   V   right   V   x   V   target   V      _ENV �   �    <   � @ A@ ���̀@ A�  �@�� A A �@ ̀A@� ���L�A ��  dA�L�d� b   �LAB �� �BCdA FAC G��d�� L���D �A�dA�L�D��D ��d���AC ��C��� ��CD BEL��d �A  �AC ��C��� ��CD �E�A���FF GA���F��$ �  dA  & �    
GetModuleAircraftModuleLockReqOpenTacticGiftAirLog打开礼包RequestOpenCartridgeGiftUnLockGetSuccShowDialogUITacticTapeObtainm_reward_list       GameGlobalEventDispatcher	DispatchGameEventTypeAircraftTacticRefreshTapeListGetRoomByRoomTypeAirRoomTypeTacticRoomAircraftRefreshRoomUISpaceIdRefreshNavMenuDataToastManager
ShowToastGetErrorMsg
GetResult         <   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    <   TT    <   module   <   ack   <   msg   <   room#   3      _ENV �   �    
@   � @ �@   ��@@ ��@�� 
� �� @ ��@A AA�@�� @ ��A�A BAA �� ̀B A� �@�� C ̀�� AC�� ��$� F�C G��� � dA�LAD �� dA�L��d� b   �F�D L��d� J�JA��E � @��A �F �AF��� ��F�F G�A�@�G@ LA�ǁ�  l  dA�& �    
_campaignUIActivityCampaignNewLoadCampaignInfo_LocalECampaignTypeCAMPAIGN_TYPE_N8GetComponentByTypeCampaignComTypeE_CAMPAIGN_COM_CombatSimulator       LockReqOpenTacticGiftAsyncRequestRes'HandleCombatSimulatorComponentOpenGiftLoginfo<UIAircraftTacticTapeList:openGiftN8() 打开礼包N8, id = UnLockGetSucc
RoleAssetassetidcountShowDialogUITacticTapeObtainGameGlobalEventDispatcher	DispatchGameEventTypeAircraftTacticRefreshTapeListCheckErrorCode	m_result         �   �         @ @@ �@ � � ��� � ��� AAD  �@ ��A$@�& �    
_campaign_campaign_moduleCampaignSwitchStateUIStateTypeUIActivityN8MainControllerUIMain_id             �   �   �   �   �   �   �   �   �   �   �   �   �          self_ENV@   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    @   TT    @   
component   @   res   @   id   @   
roleAsset+   8      _ENV"                                 #      %   N   %   P   W   P   Y   a   Y   c   �   c   �   �   �   �   �   �   �   �   �   �          _ENV