LuaS �

xV           (w@^@../PublishResources/lua/product/components/ui/activity/n37/exchange/ui_n37_exchange_item.lua             @ A@  ��@ $@�@@  ��@@ l   
@��@@ l@  
@ �@@ l�  
@��@@ l�  
@ �@@ l  
@��@@ l@ 
@ �& � 	   _classUIN37ExchangeItemUICustomWidgetSetDataPlayAnimationInSequence_SetRemainCount_SetReward	_SetCostBtnOnClick               	   
@ �
���
� �
 ���A �A �AA �A ��A �A ��A  ����AB ��A�& � 
   _index_data_component_tipsCallback_SetRemainCount_SetReward	_SetCostGetGameObject_bg
SetActive                 	   
                                             self       index       data       
component       tipsCallback       	isShowBg                      �  K�  J���J��
A�K�  J���J���
A��G� GA��� ��@�� �A�����B �B@  � �B  �@�� �  � $B�& �    Big	animNameuieff_UIN37Exchange_ItemBig_in	duration      Small!uieff_UIN37Exchange_ItemSmall_inM             B       UIWidgetHelperPlayAnimationInSequence_anim_root                                                                                                   self       index       type       wait       tb	      	animName      	duration      delay         _ENV    )    
3   G @ G@� ��   �C@  C � � @ ��@� A �@�� �   � �A AAA� $� b   @ �cA�  �@ b   �� B@��AB ��B��  ����@ �C �AC�  � @��A ��C  ����AD#� � �_ B  �B  � �A�& �    _datam_exchange_limit_count��������m_can_exchange_countStringTableGetstr_n37_item_remain_titlestr_n31_item_unlimit_count        UIActivityHelperGetColorText#9C4343UIWidgetHelperSetLocalizationTextRemainCountGetGameObject	_soldout
SetActive         3                                                   !   !   !   !   "   "   "   "   "   #   #   #   #   $   $   $   $   $   $   &   &   &   &   &   &   (   (   (   (   (   (   (   (   (   (   (   )      self    3   isLimit   3   count   3   
limitText   3   unlimitText   3   text   3      _ENV +   >    D   G @ �@� ��@�@� ���� _@A  �A  � L�A �� d��L�� dA�L�A �A d��L�� dA�"   �F�B G��G���A�  ��  ��A�A    �� �AC ǁ�   A� � �A @�FAC G���  � B dA FAC G��  � B A� �� dA FAC G��  � B dA FAC G���  ��  �dA & �    _data	m_rewardassetidcountm_id       GetGameObjectSpecialIcon
SetActiveRewardIconCfg+cfg_activity_shop_special_item_icon_clientUIWidgetHelperSetRawImageSetItemIconSetItemIconColor_colorUIN37Main.spriteatlasn37_shop_pinzhi0SetItemTextTitleSetLocalizationTextRewardCount         D   ,   -   -   .   .   0   0   0   0   0   1   1   1   1   1   1   2   2   2   2   2   2   3   3   4   4   4   5   5   5   5   5   5   5   6   6   6   6   6   6   6   8   8   8   8   8   8   ;   ;   ;   ;   ;   ;   ;   ;   <   <   <   <   <   <   =   =   =   =   =   =   >      self    D   data   D   itemId   D   count   D   
isSpecial
   D   cfg   (   url"   (      _ENV @   J       G @ L@� d� ǀ@ ��� AA  � @ ��A   ���ƁA ���  FB ��d �  BB �B@  �� ��$B & �    _componentGetCostItemIconText_datam_cost_count#F84757#F9F4F6UIActivityHelperGetColorText	tostringUIWidgetHelperSetLocalizationText
CostCount            A   A   A   D   D   E   F   G   G   G   G   G   H   H   H   H   H   H   H   I   I   I   I   I   I   J      self       icon      count      need      	colorRed      colorNormal      color      str         _ENV L   a    	#   � @ �@@�� ̀@G�@ �A �@ �   AA$� "A  ���A$� !�A��FB GA���B ��B� � dA  & � @C  �� � �  
�C�
AD�L�D ��   dA & �    DCampaignShopItemBaseNewRefresh_data_component
IsUnLimitGetRemainCount        ToastManager
ShowToastStringTableGetstr_n31_item_has_empty_tips       &UICampaignShopConfirmNormalController &UICampaignShopConfirmDetailControllerShowDialog         #   N   N   N   O   O   O   O   P   Q   Q   Q   Q   R   R   S   S   T   T   T   T   T   T   T   U   W   W   X   \   ]   ^   `   `   `   `   a      self    #   go    #   uiItemData   #   useNormalDlg   #   remainCount      tb   #      _ENV                                          )      +   >   +   @   J   @   L   a   L   a          _ENV