LuaS �

xV           (w@\@../PublishResources/lua/product/components/ui/activity/n30/Shop/ui_n30_shop_award_cell.lua             @ A@  ��@ $@�@@  ��@@ l   
@��@@ l@  
@ �@@ l�  
@��@@ l�  
@ �@@ l  
@��@@ l@ 
@ �@@ l� 
@��@@ l� 
@ �& �    _classUIN30ShopAwardCellUICustomWidgetOnShow_GetComponents	InitDataFillUiOnHide
BgOnClickSmallOnClick	ShowAnim                  ��  �  �  A�  �@ �����  A A�  �@ �� ��  � A �@ �� �
� ���B � FC GA��� 
�����C �@ & �    	_animCfg       uieff_UIN30ShopAwardCell_bigffffff�?       uieff_UIN30ShopAwardCell_small       uieff_UIN30ShopAwardCell_out�K7�A`�?atlas	GetAssetUIN21.spriteatlas	LoadTypeSpriteAtlas_GetComponents                                             	   	   	   	   	   
                                 self       	uiParams          _ENV    '    U   L@@ ��  d��
@ �L@@ �  d��
@��G�A G�� L � �@ d��
@��L�B �  A d� 
@ �L�B �� � d� 
@��L�B �@ � d� 
@ �L@@ �  d��
@��L�B �@ � d� 
@��L@@ �  d��
@��L�B �� � d� 
@��L�B �@  d� 
@��L@@ �� d��
@��L�B �@  d� 
@��L@@ �� d��
@��K�  �  �@C D GAE ��E �@ J� ��  �@F �F G�G �AH �@ J���
@��L@@ d� 
@ �& � '   _bigGetGameObjectBig_smallSmall_animationviewgameObjectGetComponent
Animation_canvasGroupGetUIComponentCanvasGroup
_itemIconRawImageLoader	ItemIcon_itemNumTextUILocalizationTextItemNumText_itemNumAreaItemNumArea_restNumTextRestNumText_maskMask_itemIconSmItemIconSm_itemNumTextSmItemNumTextSm_itemNumAreaSmItemNumAreaSm_restNumTextSmRestNumTextSm_maskSmMaskSm_nodes              go        U                                                                                                                                                                                                      !   #   #   #   #   #   #   #   $   $   $   $   $   $   $   %   &   &   &   '      self    U        )   5       
@ �
���G@ G��
@�G@ GA�
@�G@ G��
@�
� �LAB dA "  @�L�B �@ ����  � �� �A    ��A dA�& �    _data_unlock_itemId
m_item_id_itemCountm_lottery_limit_count_itemRestCountm_lottery_count_itemInfoCallbackFillUi	ShowAnimm_is_big_reward                         *   ,   -   -   -   .   .   .   /   /   /   0   1   1   2   2   3   3   3   3   3   3   3   3   3   3   5      self       data       itemInfoCallback       unlock       needShowAnim            6   N    U   G @ L@� ǀ@ ���d@�G A L@� ǀ@ ���� �d@�F@A G�� ��A G�� � B �@@AB a�B� ��B  @ �A  � �@�� C �@@AB a�B� ��B  @ �A  � �@�b    ���@ �@C� � A� �� �  � �A� �AB � B A� ��D � ��G�B b  � �GAB  @���G�@ G��b  � �A bA    �AA ��E �A��� EF��$B�BEBF��$B��FBF� $B�& �    _big
SetActive_datam_is_big_reward_smallCfg	cfg_item_itemId_mask_itemRestCount        _unlock_maskSmm_count<color=#efede7>x	</color><color=#8c887a>/_itemCount              _nodesIcon
LoadImageSetText                U   7   7   7   7   7   8   8   8   8   8   8   9   9   9   9   :   :   :   :   :   :   :   :   :   :   :   ;   ;   ;   ;   ;   ;   ;   ;   ;   ;   ;   <   <   >   >   ?   A   A   A   A   A   B   B   B   B   B   B   B   B   C   C   C   C   C   C   F   F   F   F   F   F   F   F   G   G   H   J   J   J   J   K   K   K   K   L   L   L   L   N      self    U   itemCfg   U   
itemCount)   T   showNumberTex*   T   showTimesTex*   T   indexE   T   nodeG   T   resH   T      _ENV O   T       G @ b   ��F@@ G�� d�� L�� � @ d@�
 A�& �    _timerGameGlobalTimerCancelEvent             P   P   P   Q   Q   Q   Q   Q   Q   R   T      self          _ENV U   Y    
   � @ �   @�� @ �@@ ǀ��� A�@�& �    _itemInfoCallback_data
m_item_id
transform	position        
   V   V   V   W   W   W   W   W   W   Y      self    
   go    
        [   _    
   � @ �   @�� @ �@@ ǀ��� A�@�& �    _itemInfoCallback_data
m_item_id
transform	position        
   \   \   \   ]   ]   ]   ]   ]   ]   _      self    
   go    
        a   l       � @ �@�A@ �  $A�& �    	_animCfg
StartTask         c   k       E   L � �@  d@�F�@ L�� � � d@�F@A�   ƀ� d@�E   L�� �@  d@�E �b   @ �E �d@� & �    LockUIN30ShopAwardCell:ShowAnim_animationPlay       YIELD       UnLock             d   d   d   d   e   e   e   e   f   f   f   f   g   g   g   g   h   h   h   i   i   k      TT          selfdata_ENV	callback   b   b   c   k   c   l      self       id       	callback       data         _ENV                                 '      )   5   )   6   N   6   O   T   O   U   Y   U   [   _   [   a   l   a   l          _ENV