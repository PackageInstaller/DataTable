LuaS �

xV           (w@R@../PublishResources/lua/product/components/ui/ui_player_info/ui_change_title.lua         7    @ A@  ��@ $@�@@  ��@@ l   
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
@ �& �    _classUIChangeTitleControllerUIControllerOnShow_GetComponents	_OnValue_InitTitleSrollView_GetItemFromOrderGetRowCountInitTitleListShowTitleItemOnHideGetNoTitleItemData_ChooseOneTitleRefreshChangeBtnStatusbackOnClickchangeBtnOnClick_ChangeTitleTask
_LockAnim               	   �@� 
� ��   
� ���@ �@ � A �@ & �    _playerInfo       _timeEvents_GetComponents	_OnValue        	               
   
               self    	   	uiParams    	           ,    B   L@@ ��  �  d� 
@ �L@@ �@ � d� 
@ �L B �@ d��
@��L B �� d��
@ �L B �@ d��
@ �L B �� d��
@ �L@@ �@ � d� 
@ �L B �  d��
@��L B �� d��
@��L B �  d��
@��L B �� d��
@��L@@ �  A d� 
@��L@@ �� � d� �@� � ���
� �� H ��H,  D  �@ & � $   _animGetUIComponent
Animationanim_unlockTextUILocalizationTextunlockText
_LockIconGetGameObject	LockIcon_changeBtn
changeBtn_condition
condition
_showLine	showLine_showTitleIconRawImageLoadershowTitleIcon_showTitleIconObjshowTitleIconObj_noTitleIconObjnoTitleIconObj_UsingIconObj
UsingIcon_noTitleShownoTitleShow_titleScrollViewUIDynamicScrollViewtitleScrollViewUISelectObjectPath
LeftUpper
_backBtnsSpawnObjectUICommonTopButtonSetData         #   )         @ @@ ��  $@�   �@ �  $@�@� �A $�� �A �  �   $@ & �    _animPlayuieff_UIChangeTitle_out
_LockAnim�       GameGlobalTimer	AddEvent          &   (            @ $@ & �    CloseDialog            '   '   '   (          self   $   $   $   $   %   %   %   %   &   &   &   &   &   (   &   )          self_ENVB                                                                                                                                                                           !   !   !   !   "   "   )   +   "   ,      self    B   _leftUpper8   B      _ENV .   w    }   
@@�
�@�
@A�L�A � B d��
@ �L�A ƀB d��
@��K   ��B �� ǀ@ J���  AC �CK  $� K  ��C � �@ ��DJ����  *��b  @��AD ���� �   ���C ����
��   �  �	�C� ���� �ǃA ���@ 䃀�  � � ���  �C  E "    �C  
���DC �E�F
�
� �
C��DC �C��F
�DG �G_�  �D  � 
�,  
��J ��  *���@  �� �� �@ ��� ����  �����B������J������AH ��H�@  ����
��
@���I BI $� ��A���I �A �AG ��G_ J� ��AJ BG �G�A�& � *   _titleHoldCount       _noTitleItemID        _itemCountPerRow       _itemModule
GetModuleItemModule_roleModuleRoleModuleGetNoTitleItemData       Cfgcfg_item_titlepairsOrdernextIDGetItemCountGameSingleitemidiconcfg_item_title_extendChangeTitleIconlockdescDescusing_playerInfom_title_used	callback_itemTotalCountmathmax_datas
_LockAnimGetRowCountd       _InitTitleSrollView��������_ChooseOneTitle         [   ]       E   L � �   d@�& �    _ChooseOneTitle           \   \   \   \   ]      itemid          self}   0   2   4   6   6   6   6   7   7   7   7   9   <   <   =   =   ?   @   @   @   @   A   B   B   B   B   C   C   B   B   F   F   F   F   F   F   F   G   G   G   G   H   I   J   J   K   L   M   N   N   N   N   O   O   O   O   P   R   R   R   S   U   V   V   V   V   V   W   X   Y   Y   Y   Y   Y   Z   Z   Z   Z   Z   Z   Z   ]   ]   ^   G   G   c   c   c   d   d   d   d   d   e   f   f   g   g   h   h   d   m   m   m   m   m   m   n   p   p   p   p   p   q   q   t   t   t   t   u   u   u   u   w      self    }   datas   }   noTitleItemData   }   idx   }   	cfgTitle   }   
cfg_Title   }   (for generator)      (for state)      (for control)      k      v      (for generator)(   V   (for state)(   V   (for control)(   V   k)   T   v)   T   title*   T   data+   T   lock.   T   itemid/   T   
itemcount4   T   (for index)]   f   (for limit)]   f   (for step)]   f   i^   e   data_   e      _ENV y   �       G @ L@� ̀@ � ,  d@ & �    _titleScrollViewInitListViewGetRowCount        |   ~       �   � @   @� �  �   & �    InitTitleList           }   }   }   }   }   }   ~      scrollView       index          self   z   z   {   {   ~   z   �      self            �   �       � @ �@@ � � �ǁ@@�  �� ��  *A��   �  & �    pairs_datasOrder            �   �   �   �   �   �   �   �   �   �   �   �   �      self       order       (for generator)   
   (for state)   
   (for control)   
   _      v         _ENV �   �       F @ G@� ��@ ��@ �� d� f  & �    mathceil_itemTotalCount_itemCountPerRow            �   �   �   �   �   �   �   �      self       row         _ENV �   �    ,     @@ ��   �  �@� A�  䀀�@ � �A�$� G���� �� B�FAB G��d�� L���C,  dA ��LAC�� �C dA LDd� �A ��C B ����B���C ���B��D � ��$C ����  & �            NewListViewItemRowItemGetUIComponentDynamicUISelectObjectPathgameObjectIsInitHandlerCalled GameGlobalTimer	AddEventd       SpawnObjectsUITitleItem_itemCountPerRowGetAllSpawnList       ShowTitleItem         �   �            @ �@  ƀ� $@    �@ $� A  ��� �  h@�G � Ɓ� ����� �A�@�� �A g �& �    SpawnObjectsUITitleItem_itemCountPerRowGetAllSpawnList       ShowTitleItem           �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      rowList      (for index)      (for limit)      (for step)      i      
heartItem      
itemIndex         rowPoolselfindex,   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    ,   scrollView    ,   index    ,   item   ,   rowPool   ,   rowList   *   (for index)    *   (for limit)    *   (for step)    *   i!   )   
heartItem"   )   
itemIndex%   )      _ENV �   �    	   � @ @ 䀀�   ��A� $� �@�� $A��� �@   ��$A   �A� $� �@�  $A�& �    _GetItemFromOrderGetGameObject
SetActiveSetData           �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       item       index       	itemData           �   �    	   F @ �@@ d @���@ ��@��� �A ��A�i�  ���& �    pairs_timeEventsGameGlobalTimerCancelEvent            �   �   �   �   �   �   �   �   �   �   �   �   �      self       (for generator)      (for state)      (for control)      key   
   value   
      _ENV �   �       K   �@@ J� �J�@�J@A���A � B�@@ _�   ��@  � � J� ��   J���f  & � 
   itemid_noTitleItemIDlock Order       using_playerInfom_title_used	callback        �   �       E   L � �   d@�& �    _ChooseOneTitle           �   �   �   �   �      itemid          self   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       data           �   �    :   � @ @   �& � 
@ ��@@ ��@��� ��@A AAG@ �@ ��A ��A  �@�� B ��A� �@��@B ��A� �@�� @ ǀB �  ���B ��A� �@�� C ��A  �@�����B ��A  �@�� C ��A� �@��@C ��C�@ ��C� D �@�@ �@���D  � �@�& �    _currentChooseItemIDGameGlobalEventDispatcher	DispatchGameEventTypeOnTitleItemSelect_noTitleShow
SetActive_condition
_showLine_noTitleItemID_noTitleIconObj_showTitleIconObjCfgcfg_item_title_extendChangeTitleIcon_showTitleIcon
LoadImageRefreshChangeBtnStatus         :   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    :   itemid    :   PreviewTitleIcon2   6      _ENV �   �    &   � @ �@@_@   ��@  � � ǀ@ �@����A AA��$A��A AA�@  @ ���@ ��A  �� $A��A AA�   ���$A�B AB��B ��Bǁ@ �A���� $A  & �    _playerInfom_title_used_dataslock
_LockIcon
SetActive_changeBtn_UsingIconObj_unlockTextSetTextStringTableGetdesc         &   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    &   itemid    &   isUsing   &   isLock	   &      _ENV �   �       L @ d@ & �    CloseDialog           �   �   �      self            �   �       L @ �@  d@�L�@ ��@    d@ & �    Lock)UIChangeTitleController:changeBtnOnClick
StartTask_ChangeTitleTask           �   �   �   �   �   �   �   �      self            �      3   � @ �@@ � A�  ��@ ���� A AA �@��   ��̀A� �   ����A � �AB �BA� $ �@  � C �@�䀀 ̀�F�C G���@ �@ � @ ̀�� 
�����D G�@ �@�����A � � LAEd �@  ƀE ��� LAEd �@  & �    _roleModuleRequest_TitleAndFifure       _currentChooseItemIDUnLock)UIChangeTitleController:changeBtnOnClickGetSuccToastManager
ShowToastStringTableGet"str_player_info_change_title_succGameGlobalEventDispatcher	DispatchGameEventTypeOnPlayerTitleInfoChanged_playerInfoUI_GetPlayerInfoRefreshChangeBtnStatusA###[UIChangeTitleController] changeBtnOnClick fail ! result --> 
GetResultLogerror         3   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �                                            self    3   TT    3   res   3      _ENV         � @ A  �@���@ ��@��� � A � l  �� �@A ǀ��A @ �@�& �    Lock!UIChangeTitleController_LockAnimGameGlobalTimer	AddEventtableinsert_timeEvents                      @ �@  $@�& �    UnLock!UIChangeTitleController_LockAnim                            self         	  	  	  	  
    	                 self       timeLen       te
         _ENV7                                 ,      .   w   .   y   �   y   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �     �                  _ENV