LuaS �

xV           (w@`@../PublishResources/lua/product/components/ui/season/s3/exchange/ui_s3_exchange_controller.lua         L    @ A@  ��@ $@�@@  ��@@ l   
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
@ �@@ l  
@��@@ l@ 
@ �@@ l� 
@��& �    _classUIS3ExchangeControllerUIController_SetRemainingTime_SetCommonTopButton_Back
_SetSpine
_SetImgRT
_PlayAnim_CheckGuideLoadDataOnEnterOnShowOnHide	_Refresh
_SetTaken_SetTopTips_SetDynamicListData_SetDynamicList_RefreshList_SpawnListItem_SetListItemData_DynamicListPlayAnimationSkinBtnOnClick_AttachEvents_DetachEvents_CheckActivityClose               
   @ A@@  �� ��  $� L�@d� L�@�  ��A  �� dA�L�A� dA�L�A��  l  dA�F@ G�� �A � dA & �    UIWidgetHelperSpawnObjectUIActivityCommonRemainingTimeGetGameObject
SetActive SetAdvanceTextSetDataSetAnimationPlay_animuieff_UIS2TimeExchange                        @ $@ & �    	_Refresh                              self   	   	   	   	   	   	   
   
   
   
   
   
   
   
                                                   self       widgetName       descId       endTime       obj         _ENV    (    	   F @ G@� �   ��  �  d� � � ,  lA  �  �    �@�& �    UIWidgetHelperSpawnObject
_backBtnsUICommonTopButtonSetData                         @ $@ & �    _Back                               self !   #         @ @@ F�@ G�� $@ & �    UISeasonHelperShowSeasonHelperBookUISeasonHelperTabIndexS1Exchange            "   "   "   "   "   #          _ENV                            #   $   %   '      (      self       obj         _ENV *   0       L @ d@ & �    CloseDialog           +   +   0      self            2   5       L @ �@  �  d� ���  �@�& �    GetUIComponentSpineLoader_spine
LoadSpine1600234_spine_idle           3   3   3   3   4   4   4   5      self       obj           7   @       _ � ���@@ �  A�  �� �@ �� � �  �   �  & �     GetUIComponent	RawImagerttexture           8   8   :   :   :   :   ;   =   =   ?   ?   @      self       imgRT       rt   	        B   H    
   ˀ  �  
���
��� ��  
���
���� ��B AB@  �� �A��A�B��@@ $A & �    in	animName uieff_UIS3ExchangeController_in	durationX      out!uieff_UIS3ExchangeController_out7      UIWidgetHelperPlayAnimation_anim            C   D   D   D   D   E   E   E   E   G   G   G   G   G   G   G   G   G   G   H      self       type       	callback       tb	         _ENV J   L       & �                L      self            T   g    
!   A@ �@F�@ $� 
 �@ A�� $��G@ L��d� 
@��G@ L�d� 
@��"   �LABd� bA   �G@ L����B� dA�LC�  dA�& � & �    _seasonModuleGameGlobal
GetModuleSeasonModuleForceRequestCurSeasonData
_seasonIdGetCurSeasonID_componentGetCurSeasonExchangeComponentGetSuccCheckErrorCode	m_resultSetSucc         !   V   V   V   V   V   W   W   W   W   Y   Y   Y   Y   \   \   \   \   _   _   _   _   _   _   `   `   `   `   `   a   a   a   b   g      self    !   TT    !   res    !   	uiParams    !   reqRes	   !      _ENV i   |       �   
� ��@@ �@  �& � �@@ ��@�� � A�@A A� �� � �@�� B �@ �@B �@ ̀B A� �@�� C C� �@��@C �@ & �    _tipsCallback_component GetComponentInfom_close_time_SetRemainingTime_remainingTimestr_season_main_time_exchange_SetCommonTopButton
_SetSpine
_PlayAnimin	_Refresh_AttachEvents         j   l       � @ �@@� � �  @  �� �@�& �    UIWidgetHelperSetAwardItemTips
_tipsPool             k   k   k   k   k   k   k   l      matid       pos          _ENVself   l   l   n   n   n   o   r   r   r   r   s   s   s   s   s   u   u   v   v   x   x   x   y   y   y   {   {   |      self       	uiParams       time
         _ENV ~   �       L @ d@ & �    _DetachEvents                 �      self            �   �    
   � @ �@ �@@ �@ ��@ �@ ��@  � �@�& �    
_SetTaken_SetTopTips_SetDynamicList_DynamicListPlayAnimation        
   �   �   �   �   �   �   �   �   �   �      self    
   isFirst    
        �   �       G @ L@� d� � @ ��@ � �����@ A 䀀�@�@ �@�& �    _componentGetExchangeItemSpecialIsExchangeItemSoldoutGetGameObject_taken
SetActive           �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       	itemInfo      show           �   �       G @ L@� � � d��� @ �@@  ����   � @ �@ �@ �@@  � �A �$��F�A � d� ������B�i�  ��& �    _componentGetCostItemIdUIWidgetHelperSpawnObjects	_topTipsUIS1TopTipsipairsSetData            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   
   self       id1      id2      tb      objs      (for generator)      (for state)      (for control)      i      v         _ENV �   �       F@@ G�� ��@ d� 
@ �
@A�F�A G � �@B ��B� @ �� �@A� A �� �@Ad� 
@ �& �    _infosUISeasonExchangeHelperGetExchangeItemList_Sort_component_itemCountPerRow       _dynamicListSizemathfloortablecount            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self          _ENV �   �       L @ d@ G@@ b@  ��
���L A �@ � d� 
@��G�@ L�� � B ,  d@ � �L@B � B �@ d@ & � 
   _SetDynamicListData_isDynamicInited_dynamicListGetUIComponentUIDynamicScrollViewDynamicListInitListView_dynamicListSize_RefreshList        �   �       �   � @   @� �  �   & �    _SpawnListItem           �   �   �   �   �   �   �      scrollView       index          self   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self            �   �       � @�@�ǀ��@�� $A�A�A �A $A @A@
� �& �    ScrollRectcontentlocalPositionSetListItemCountMovePanelToItemIndex                   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       count       list       contentPos           �   �    ?     @@ ��   �  �@@ �� ̀��@ � A"  � �AA bA    �A� �� �� @�䁀BB �� ���$� G�@� �ʁC�L�C� C@ dB LDd� ��  �B@ �  �B��C��C@ ���C�DD  �@��D$� �D�  $D� ��D$� �D�� $D�E � ��$D ��� & �            _itemCountPerRow       _infosm_is_special
CellLarge
CellSmallUIS3ExchangeCellNewListViewItemGetUIComponentDynamicUISelectObjectPathgameObjectIsInitHandlerCalled SpawnObjectsGetAllSpawnList_dynamicListSizeGetGameObject
SetActive_SetListItemData        ?   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    ?   scrollView    ?   index    ?   idx   ?   isLarge
   ?   prefabName   ?   
className   ?   item   ?   rowPool   ?   rowList"   ?   (for index)%   =   (for limit)%   =   (for step)%   =   i&   <   	listItem'   <   
itemIndex*   <        �   �    
   � @ ǀ�A� � ���@ G�@ �A $A�& �    _infosSetData
_seasonId_component_tipsCallback        
   �   �   �   �   �   �   �   �   �   �      self    
   item    
   index    
   info   
        �   �    '   _ �   �& � �@@ ��@�� ��  AAAAA �@�ƁA ����� B@ B��$��LBB �� �Bd� ���� �B CC AC ��ǃDC �L��� dD����� �& �    _dynamicListGetVisibleItemIDsInScrollView        Count       mathfloorGetShownItemByItemIndexGetUIComponentDynamicUISelectObjectPathgameObjectGetAllSpawnList_itemCountPerRowPlayAnimationInSequence         '   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    '   isPlay    '   showTabIds   '   (for index)
   &   (for limit)
   &   (for step)
   &   index   %   id   %   item   %   rowPool   %   rowList   %   (for index)   %   (for limit)   %   (for step)   %   i   $   	listItem   $   
itemIndex!   $      _ENV �   �    	   � @ �@@�� ǀ@���A @�$A & �    _componentGetExchangeItemSpecial	m_rewardassetid_tipsCallback        	   �   �   �   �   �   �   �   �   �      self    	   go    	   item   	   itemId   	                L @ �@@ ǀ��@ d@ L @ �@@ � �AA d@ & �    AttachEventGameEventTypeOnUIGetItemCloseInQuest	_RefreshActivityCloseEvent_CheckActivityClose                                     self          _ENV         L @ �@@ ǀ��@ d@ L @ �@@ � �AA d@ & �    DetachEventGameEventTypeOnUIGetItemCloseInQuest	_RefreshActivityCloseEvent_CheckActivityClose            	  	  	  	  	  
  
  
  
  
       self          _ENV         � @ @ @ ��@@ �@ & �    
_seasonIdCloseDialog                          self       id           L                                 (      *   0   *   2   5   2   7   @   7   B   H   B   J   L   J   T   g   T   i   |   i   ~   �   ~   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �                              _ENV