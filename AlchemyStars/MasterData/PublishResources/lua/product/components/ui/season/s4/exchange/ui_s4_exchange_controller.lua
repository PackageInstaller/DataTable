LuaS �

xV           (w@`@../PublishResources/lua/product/components/ui/season/s4/exchange/ui_s4_exchange_controller.lua         L    @ A@  ��@ $@�@@  ��@@ l   
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
@��& �    _classUIS4ExchangeControllerUIController_SetRemainingTime_SetCommonTopButton_Back
_SetSpine
_SetImgRT
_PlayAnim_CheckGuideLoadDataOnEnterOnShowOnHide	_Refresh
_SetTaken_SetTopTips_SetDynamicListData_SetDynamicList_RefreshList_SpawnListItem_SetListItemData_DynamicListPlayAnimationSkinBtnOnClick_AttachEvents_DetachEvents_CheckActivityClose               
   @ A@@  �� ��  $� L�@d� L�@�  ��A  �� dA�L�A� dA�L�A��  l  dA�F@ G�� �A � dA & �    UIWidgetHelperSpawnObjectUIActivityCommonRemainingTimeGetGameObject
SetActive SetAdvanceTextSetDataSetAnimationPlay_animuieff_UIS4TimeExchange                        @ $@ & �    	_Refresh                              self   	   	   	   	   	   	   
   
   
   
   
   
   
   
                                                   self       widgetName       descId       endTime       obj         _ENV    (    	   F @ G@� �   ��  �  d� � � ,  lA  �  �    �@�& �    UIWidgetHelperSpawnObject
_backBtnsUICommonTopButtonSetData                         @ $@ & �    _Back                               self !   #         @ @@ F�@ G�� $@ & �    UISeasonHelperShowSeasonHelperBookUISeasonHelperTabIndexS1Exchange            "   "   "   "   "   #          _ENV                            #   $   %   '      (      self       obj         _ENV *   .       L @ �@  ,  d@ & �    
_PlayAnimout        +   -            @ $@ & �    CloseDialog           ,   ,   ,   -          self   +   +   -   +   .      self            0   3       L @ �@  �  d� ���  �@�& �    GetUIComponentSpineLoader_spine
LoadSpine1500994_spine_idle           1   1   1   1   2   2   2   3      self       obj           5   >       _ � ���@@ �  A�  �� �@ �� � �  �   �  & �     GetUIComponent	RawImagerttexture           6   6   8   8   8   8   9   ;   ;   =   =   >      self       imgRT       rt   	        @   F    
   ˀ  �  
���
��� ��  
���
���� ��B AB@  �� �A��A�B��@@ $A & �    in	animName uieff_UIS4ExchangeController_in	duration�      out!uieff_UIS4ExchangeController_out7      UIWidgetHelperPlayAnimation_anim            A   B   B   B   B   C   C   C   C   E   E   E   E   E   E   E   E   E   E   F      self       type       	callback       tb	         _ENV H   J       & �                J      self            R   e    
!   A@ �@F�@ $� 
 �@ A�� $��G@ L��d� 
@��G@ L�d� 
@��"   �LABd� bA   �G@ L����B� dA�LC�  dA�& � & �    _seasonModuleGameGlobal
GetModuleSeasonModuleForceRequestCurSeasonData
_seasonIdGetCurSeasonID_componentGetCurSeasonExchangeComponentGetSuccCheckErrorCode	m_resultSetSucc         !   T   T   T   T   T   U   U   U   U   W   W   W   W   Z   Z   Z   Z   ]   ]   ]   ]   ]   ]   ^   ^   ^   ^   ^   _   _   _   `   e      self    !   TT    !   res    !   	uiParams    !   reqRes	   !      _ENV g   z       �   
� ��@@ �@  �& � �@@ ��@�� � A�@A A� �� � �@�� B �@ �@B �@ ̀B A� �@�� C C� �@��@C �@ & �    _tipsCallback_component GetComponentInfom_close_time_SetRemainingTime_timestr_season_main_time_exchange_SetCommonTopButton
_SetSpine
_PlayAnimin	_Refresh_AttachEvents         h   j       � @ �@@� � �  @  �� �@�& �    UIWidgetHelperSetAwardItemTips
_tipsPool             i   i   i   i   i   i   i   j      matid       pos          _ENVself   j   j   l   l   l   m   p   p   p   p   q   q   q   q   q   s   s   t   t   v   v   v   w   w   w   y   y   z      self       	uiParams       time
         _ENV |   ~       L @ d@ & �    _DetachEvents           }   }   ~      self            �   �    
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
CellSmallUIS4ExchangeCellNewListViewItemGetUIComponentDynamicUISelectObjectPathgameObjectIsInitHandlerCalled SpawnObjectsGetAllSpawnList_dynamicListSizeGetGameObject
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
itemIndex!   $      _ENV �   �    	   � @ �@@�� ǀ@���A @�$A & �    _componentGetExchangeItemSpecial	m_rewardassetid_tipsCallback        	   �   �   �   �   �   �   �   �   �      self    	   go    	   item   	   itemId   	                 L @ �@@ ǀ��@ d@ L @ �@@ � �AA d@ & �    AttachEventGameEventTypeOnUIGetItemCloseInQuest	_RefreshActivityCloseEvent_CheckActivityClose                                     self          _ENV         L @ �@@ ǀ��@ d@ L @ �@@ � �AA d@ & �    DetachEventGameEventTypeOnUIGetItemCloseInQuest	_RefreshActivityCloseEvent_CheckActivityClose                                     self          _ENV 
        � @ @ @ ��@@ �@ & �    
_seasonIdCloseDialog                          self       id           L                                 (      *   .   *   0   3   0   5   >   5   @   F   @   H   J   H   R   e   R   g   z   g   |   ~   |   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �                 
    
           _ENV