LuaS �

xV           (w@Z@../PublishResources/lua/product/components/ui/season/s1/exchange/ui_s1_exchange_cell.lua         %    @ A@  ��@ $@�@@  ��@@ l   
@��@@ l@  
@ �@@ l�  
@��@@ l�  
@ �@@ l  
@��@@ l@ 
@ �@@ l� 
@��@@ l� 
@ �@@ l  
@��@@ l@ 
@ �& �    _classUIS1ExchangeCellUICustomWidgetSetDataPlayAnimationInSequence	_GetType_SetBg_SetRemain_SetDiscount	_SetItem	_SetCoin_SetSoldoutBtnOnClick    
           
   
@ �
���
� �
 ��
@��AA �� ́A @ �A���A �A �B �A �AB @ �A�́B �A ��B �A & �    _index_info
_seasonId_component_tipsCallback	_GetType_SetBg_SetRemain_SetDiscount	_SetItem	_SetCoin_SetSoldout                 	                                                               self       index       info       	seasonId       
component       tipsCallback       type              "       � �ˀ  �@@���@��  
A�
�@�K�  JA�J�@��@��@A � � @G� G����� ��A ��   AB �B �   @��A�& � 
   	animNameuieff_UIS1Exchange_Cell_Large	durationX      uieff_UIS1Exchange_Cell_Small	_GetType<       UIWidgetHelperPlayAnimationInSequence_anim                                                                   !   !   !   !   !   !   !   !   !   "      self       index       tb      type      	animName      	duration      delay         _ENV $   *       G @ G@� ��@ ��@� A @ AA���b   � ��� �@  @��   � ��� �@    ��  �  & � 	   _infom_is_specialUISeasonExchangeHelperGetBold_componentm_id                                 %   %   &   &   &   &   &   &   (   (   (   (   (   (   (   (   (   (   (   )   *      self       special      bold      type         _ENV ,   6    
   ��  �@@���@��@A��� A F�A G��  �A  �@ dA�& � 
          exp_s1_shop_shizhuangtu1       exp_s1_shop_tuchudaoju1       exp_s1_shop_putongdaoju1UIS1Exchange.spriteatlasUIWidgetHelperSetImageSprite_bg            -   .   /   0   3   4   5   5   5   5   5   5   5   6      self       type       tb      
atlasName      spriteName         _ENV 8   >       A   �@@ ��@�@ @� �� � A �@�� @ 䀀�A B@  �A ��$A �B �� $��C @  ��A  �� $A�& �            _componentGetCanExchangeCount_infoStringTableGetstr_season_s1_exchange_remainUIWidgetHelperSetLocalizationText_remainTextGetGameObject
_remainBg
SetActive            9   :   :   :   :   :   ;   ;   ;   ;   ;   <   <   <   <   <   <   =   =   =   =   =   =   =   =   =   >      self       
constHide      remain      str         _ENV @   E       F @ G@� ��@ ��@ � �d���@ � � � � ��A � �   AA � �@ ̀B A� 䀀� �@�   �CA  C� �@�& �    UISeasonExchangeHelperGetDiscount_component_infom_id-%UIWidgetHelperSetLocalizationText_discountTextGetGameObject_discountBg
SetActive                    A   A   A   A   A   A   B   B   B   B   C   C   C   C   C   C   D   D   D   D   D   D   D   D   D   E      self       	discount      str
         _ENV G   T    !   � @ �@@ƀ@ ���   GA�A �@ ƀ@ ǀ�   A� �B�@ ƀ@ �@�   GA�� �@ ��  � ÅʀÆ� ćAD �DKA  �A�J����  �� $A & �    _info	m_rewardUIWidgetHelperSetItemIconassetid_iconSetLocalizationText_countcountSetItemText_title       #FFFFFF       #865737       #4e2929UIStyleHelperFitStyle_Widgetcolor         !   H   H   I   I   I   I   I   I   J   J   J   J   J   J   L   L   L   L   L   L   N   O   P   Q   S   S   S   S   S   S   S   S   T      self    !   type    !   
roleAsset   !   tb   !      _ENV V   b    
.   G @ L@� ǀ@ ���d���  �@  � � ��A �A@  � �  �$A�AB �BG@ ��@ ��B$��F�A G��  �A   dA L�C �A d��L�� D  ��A  �� dA�G�@ GA���A �C�  � @��A & �    _componentGetCostItemId_infom_is_specialUICommon.spriteatlas	toptoon_UIWidgetHelperSetImageSprite_coinUISeasonExchangeHelper	GetPricem_idSetLocalizationText_price1GetGameObject
SetActive        m_cost_count_price2         .   W   W   W   W   W   X   Y   Y   Y   Z   Z   Z   Z   Z   Z   Z   \   \   \   \   \   \   ]   ]   ]   ]   ]   ]   ^   ^   ^   ^   ^   ^   ^   ^   ^   `   `   a   a   a   a   a   a   b      self    .   itemId   .   
atlasName   .   spriteName	   .   price1   .   price2'   .      _ENV d   g       G @ L@� ǀ@ d����@  ����@A � �@�& �    _componentIsExchangeItemSoldout_infoGetGameObject	_soldout
SetActive           e   e   e   e   f   f   f   f   f   f   g      self       
isSoldout           k   s       F @ G@� ��  ��@ d@�G A L@� ǀA d��b   ����A � B�@B ǀ�� �  �@  @�� C A G�C �A ǁA �@ & �    Loginfo%UIS1ExchangeCell:BtnOnClick index = _index_componentIsExchangeItemSoldout_infoToastManager
ShowToastStringTableGet&str_activity_common_shop_sold_out_msgShowDialogUIS1ExchangeConfirm
_seasonId            l   l   l   l   l   m   m   m   m   n   n   o   o   o   o   o   o   o   o   q   q   q   q   q   q   s      self       
isSoldout	         _ENV%                                 "      $   *   $   ,   6   ,   8   >   8   @   E   @   G   T   G   V   b   V   d   g   d   k   s   k   s          _ENV