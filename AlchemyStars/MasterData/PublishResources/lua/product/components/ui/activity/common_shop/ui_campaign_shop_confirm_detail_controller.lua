LuaS �

xV           (w@s@../PublishResources/lua/product/components/ui/activity/common_shop/ui_campaign_shop_confirm_detail_controller.lua         ;    @ A@  ��@ $@�@@  ���  F@@ �   J� �F@@ �@  J���F@@ ��  J� �F@@ ��  J���F@@ �  J� �F@@ �@ J���F@@ �� J� �F@@ �� J���F@@ �  J� �F@@ �@ J���F@@ �� J� �F@@ �� J���F@@ �  J� �F@@ �@ J���F@@ �� J� �F@@ �� J���F@@ �  J� �& �    _class&UICampaignShopConfirmDetailControllerUIControllerc       ConstructorOnShowInitWidgetSetTextColorRefresh
SetScrollDoAnimationOnHideBtnstarOnClickBtnbuyOnClickSetCountPriceTxtMinOnClickRemoveOnClickAddOnClickMaxOnClickBtnbgOnClickInitPlayerSpine                  & �                      self               
       � @  � �@�& �    InitWidget           	   	   	   
      self       	uiParams               C    
{   �@� 
� �� @ ��@��@�� �@A
� ���A
� �� @ ǀ��@�GAA��A� 
� ���� 
� �� @ �@�� 
� ���C A �A � 
� ���C A� � � 
� ���C A� � � 
�����C A� � � 
�����C A� � � 
�����C A �A � 
�����G A� 䀀
� ���G AA 䀀
� ���C A� �A � 
� ���C A� �	 � 
�����C A�	 ��	 � 
�����C A� �A
 � 
� ���C A� ��
 � 
� ���C A� �A � 
� ���G A� 䀀
� ���G A 䀀AL �L@�$� L�L � M BMl  dA�L�L � M �MlB  dA�L�L � M �Ml�  dA�LN dA & � 9   
goodsData       exchangeCmptGetComponentInfo_campaignIdm_campaign_id_componentIdm_component_id_componentFullIdGetComponetCfgIdsubTabType       isPetIsPetuiItemGetUIComponentRawImageLoaderuiitemnameTxtUILocalizationTextname
nameTrans
TransformdescTxtdesc	descRectRectTransformdescScrollScrollRectContentPanelbtnGoGetGameObjectcountGroupGOcountgroupcountGroupRect_currentCount
itemCount
moneyIconImage
moneyicon	priceTxtpricecountFollowTxtcountfollow
remainTxtremain	remainGO
remaintxtbtnbuyUICustomUIEventListenerGetAddUICustomEventListenerUIEventPress
UnhoveredReleaseRefresh         /   0       & �                0      go            5   7       E   L � d@ & �    SetTextColor           6   6   6   7      go          self <   >       E   L � d@ & �    SetTextColor           =   =   =   >      go          self{                                                                                                                                                                                  !   !   !   !   "   "   "   "   "   #   #   #   #   #   $   $   $   $   $   %   %   %   %   %   &   &   &   &   &   (   (   (   (   (   )   )   )   )   *   *   *   +   +   +   +   ,   -   .   .   0   ,   2   3   4   4   7   2   9   :   ;   ;   >   9   A   A   C      self    {   	uiParams    {   	cmptInfo   {   	btnBuyGOb   {   etlf   {      _ENV E   L       F @ G@� ��@ d� ��@ !@  �� A ƀA ���������� A ƀA  AA �� �� 䀀����& �    ClientCampaignShop	GetMoney	saleTypeprice	priceTxtcolorColorwhite      �?�������?�������?                   F   F   F   F   G   G   G   H   H   H   H   H   J   J   J   J   J   J   J   J   L      self       	ownMoney         _ENV O   ~    �   G @ b@    �& � F@@ G�� � @ ��@�� G�� b@    �& � 
@A�� @ ��A�� 
� �� � �@� �� G@ L��d� !@�� �� �A  @��AC ��C�� �� �����D �A�@��A�ǁD ���A �BC ��C�B� �� �� ]�A���E FF 䁀���@ 䁀BF �D�BC ��C��  ���$B  �F �D�BC ��C�� � $B  @ �G$� 
 ���G LBH �� �H Id� LB�ƂI ���CG � d�  
B�J "   �BJ �J�� $B�� �BJ �J�  $B�@ K$� 
 ��BK �J�� $B�@ �K$� "   ��K �J�  $B����K �J�  $B�L �D��J $B�BL $B �L $B �L $B & � 4   
goodsDataCfg	cfg_item
GetItemIdcount       singlePriceGetSalePriceIDIconColorGetItemCountStringTableGetstr_shop_good_countuiItem
LoadImagenameTxtSetText「Name」
GetModuleItemModule_currentCountstr_shop_current_item_countdescTxtIntro	saleTypeGetCostItemId
moneyIconsprite	GetAssetUICommon.spriteatlas	LoadTypeSpriteAtlas
GetSpriteClientShopGetCurrencyImageNameisPetbtnGo
SetActiveremainCountGetRemainCountcountGroupGO
IsUnLimit	remainGO
remainTxtSetCountPriceTxtDoAnimation
SetScroll         �   P   P   P   Q   S   S   S   S   S   S   T   T   U   W   X   X   X   X   Y   Z   [   \   \   \   ]   ]   ]   ]   ]   ]   ]   ]   ]   ]   ]   ^   ^   ^   ^   _   _   _   _   _   _   _   _   _   _   a   a   a   a   a   a   b   b   b   b   b   b   b   b   d   d   d   d   d   d   d   e   e   e   e   f   f   f   f   f   f   f   g   g   g   g   f   h   i   i   i   k   k   k   k   k   n   n   n   n   p   p   p   p   q   q   q   q   r   r   r   r   r   s   s   s   s   s   v   v   v   v   w   w   w   w   z   z   |   |   }   }   ~      self    �   cfgItem
   �   itemId   �   icon   �   quality   �   count   �   text1#   �   
itemCount7   �      _ENV �   �    
   G @ G@�  �� � ���@ �@A�@ ���@ ��A�& �    descTxtpreferredHeight�       descScroll	vertical         
   �   �   �   �   �   �   �   �   �   �      self    
   perferredH   
        �   �       L@@ ��  �  d� 
@ �L@@ �@ � d� 
@ �L@@ �  A d� 
@��G @ J�B�L C �      d@ & �    _cgGetUIComponentCanvasGroup	UICanvas_panelRectTransformpanel_infoTrans
Transforminfoalpha        
StartTask         �   �    *   F @ �   d@ F @ �   d@ F@� L�� ��   d@ F@� ��A �   A �� J� �F@� G�� G�� �@� � C�A A�  ��  ��  $� A �� �@C,  �@��@� ��C�� A �� �@C,A  �@�& �    YIELD_cgDOFade       333333�?_panellocalScaleVector3      �?_infoTranslocalPositionyDOScaleOnCompleteDOLocalMoveY       �������?          �   �        & �                �            �   �         @ @@ � � ��@��  $@ & �    _infoTransDOLocalMoveY       �������?           �   �   �   �   �   �   �          selfy*   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      TT    *   y   *      _ENVself   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self          _ENV �   �       G @ b   � �G @ L@� d@ 
�@�& �    _spineDestroyCurrentSpine            �   �   �   �   �   �   �   �      self            �   �       � @ A  G�@ L��d �@  & �    ShowDialogUIShopPetDetailController
goodsData
GetItemId           �   �   �   �   �   �   �      self       go            �          � @ �@@ǀ@ �@ ����@  ����@ � A �@�� @ ���A �@ ��A � B�@ �� ƀB ���  �@ & � � C �@C�   � �̀C l  �  �@ & �    ClientCampaignShop	CheckBuy	saleTypepriceRoleAssetIDRoleAssetGlowCloseDialogStringTableGetstr_pay_item_not_enoughToastManager
ShowToast
goodsDataexchangeCmpt
StartTask         �   �    
[   E   L � �@  d@�F�� L�� d� �  � A   @� �AA ��A�� ��A �� �   � �AA  �@��@� � �   @	��   ���   � � ���B  E  L��A� d��L�����d��b  ��E  L��A   l  dA��
�E  L����   lB  dA�E  L�dA ����   � ��@ ���@� � �� �E ���� � �@�䀀 ̀�F�� G��AG �@ � � � ��� � ���A� �� �H ,�  D  $A   E$A & � !   Lock4UICampaignShopConfirmDetailController:btnbuyOnClickAsyncRequestResNewHandleExchangeItem
goodsDataGetGoodsIdcountUnLockGetSucc               
GetModule
PetModuleIsPetIDassetidShowDialogUIPetObtainShowDialogUIGetItemControllerCloseDialog
GetResultCampaignErrorType&E_CAMPAIGN_ERROR_TYPE_COMPONENT_CLOSEGameGlobalEventDispatcher	DispatchGameEventTypeActivityComponentCloseEvent_componentFullIdCampaignModuleCheckErrorCode_campaignId          �   �         @ @@ $�� �@ ��  $@� �  A �@ �  ,  $@� � �@ $@ & �    GameGlobalUIStateManagerCloseDialogUIPetObtainShowDialogUIGetItemController          �   �         @ @@ $�� �@ ��@ � A�@� ̀��  $@  & �    GameGlobalEventDispatcher	DispatchGameEventTypeActivityShopBuySuccess
goodsDataGetGoodsId             �   �   �   �   �   �   �   �   �   �   �          _ENVself   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �          _ENVself
assetList �   �         @ @@ $�� �@ ��@ � A�@� ̀��  $@  & �    GameGlobalEventDispatcher	DispatchGameEventTypeActivityShopBuySuccess
goodsDataGetGoodsId             �   �   �   �   �   �   �   �   �   �   �          _ENVself �   �     	    @ @@ $�� �@ ��@ � A�@� $@ & �    GameGlobalEventDispatcher	DispatchGameEventTypeActivityShopNeedRefresh_campaignId          	   �   �   �   �   �   �   �   �   �          _ENVself[   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      TT    [   res   [   rewards   [   
roleAsset   9   
assetList   9   campaignModuleP   Z      self_ENVexchangeCmpt    �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �     �        self        go        tips      exchangeCmpt          _ENV   
      G @ L@� ǀ@ d@�G�@ � A �@AO�� 
@��G�A L@� ��@ d@�L�A d@ & �    countFollowTxtSetTextcountprice
goodsData
costCount	priceTxtSetTextColor                                     	  	  
     self                 	   
@@���@ ��@� A �@��@ ��A �@ & �    count       AudioHelperControllerPlayUISoundAutoReleaseCriAudioIDConstSoundDecDownSetCountPriceTxt         	                        self    	   go    	      _ENV         � @  ���� �� @ �@@
� �  �
@@���@ ��@� A �@��@ ��A �@ & �    count       AudioHelperControllerPlayUISoundAutoReleaseCriAudioIDConstSoundDecDownSetCountPriceTxt                                               self       go          _ENV   /   ,   � @ �@@ǀ@ �� ��@ � �AA �A� !��@ �
@B�@�B AB
 �B ! �  �
� ��B ! ��@�B G�B ! �@ ��B 
 �B E� ! �@ �� 
 ��B CFAC G��$A �C $A & �    ClientCampaignShop	GetMoney	saleTypemathfloor
goodsData
costCount        count       remainCountAudioHelperControllerPlayUISoundAutoReleaseCriAudioIDConstSoundAddUpSetCountPriceTxt          ,                                 "  "  "  #  #  #  $  &  &  &  &  &  &  &  '  '  )  )  )  )  *  *  -  -  -  -  -  .  .  /     self    ,   go    ,   	ownMoney   ,   	maxCount
   ,      _ENV
MAX_COUNT 1  A   "   � @ �@@ǀ@ �� ��@ � �AA �A� !��@ ��  ��AB ! ��� �AB !�   ��@B � !�   �� � �B �BFC GA�$A 
� ��C $A & �    ClientCampaignShop	GetMoney	saleTypemathfloor
goodsData
costCount               remainCountAudioHelperControllerPlayUISoundAutoReleaseCriAudioIDConstSoundAddUpcountSetCountPriceTxt          "   2  2  2  2  3  3  3  3  3  3  4  4  5  5  7  7  7  7  7  7  8  :  :  :  ;  >  >  >  >  >  ?  @  @  A     self    "   go    "   	ownMoney   "   	maxCount
   "      _ENV
MAX_COUNT C  E      � @ �@ & �    CloseDialog           D  D  E     self       go            G  K      L@@ ��  �  d� 
@ �L@A ��  d��
@ �G @ L�� �� d@�& �    _spineGetUIComponentSpineLoaderspine	_spineGoGetGameObject
LoadSpineduya_spine_idle           H  H  H  H  H  I  I  I  I  J  J  J  J  K     self           ;                                    
         C      E   L   E   O   ~   O   �   �   �   �   �   �   �   �   �   �   �   �   �     �     
                  /    1  A  1  C  E  C  G  K  G  K     
MAX_COUNT   ;      _ENV