LuaS �

xV           (w@�@C:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/lua/product/components/ui/activity/common_campaign_gift_pack/ui_activity_gift_pack_detail.lua         O    @ A@  ��@ $@�@@  ��@@ l   
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
@��@@ l� 
@ �& �    _classUIActivityGiftPackDetailUIController_GetComponentsOnShowOnHide
_SetTitle	_SetTips_SetImg
_SetLimit
_SetPrice_FlushPrice_SetAwardsImmediately_SetAwardsDailyGetEndTimeGetLeftSecondsGetCycleTypeStrGetCountStrGetPriceTypeGetPriceIcon
bgOnClickbtnBuyOnClick_AttachEvents_DetachEvents_CheckActivityClose_OnCurrencyBuySuccess_OnNormalBuyResult           "    I   L@@ ��  �  d� 
@ �L@A �� d��
@ �L@@ ��   d� 
@��L@@ �� � d� 
@��L@A �@ d��
@ �G C L�� �   d@�L@@ ��   d� 
@��L@@ �� � d� 
@��L@@ ��  A d� 
@ �L@@ ��  d� 
@ �L@@ �� � d� 
@��L@A �  d��
@��L@@ �� � d� 
@��L@@ �@ � d� 
@ �L I �@	 �I �Id� 
@��& � (   	_txtNameGetUIComponentUILocalizationTexttxtName_goTipsGetGameObjecttips	_txtTipstxtTips	_imgIconRawImageLoaderimgIcon	_goLimitlimit
SetActive
_txtLimit	txtLimit
_imgPriceImage	imgPrice
_txtPrice	txtPrice_sopImmediatelyUISelectObjectPathsopImmediately
_sopDaily	sopDaily	_goDailydaily_btnBuyButtonbtnBuy_anim
AnimationuiAnim_atlas	GetAssetUICommon.spriteatlas	LoadTypeSpriteAtlas         I                              
   
   
   
   
                                                                                                                                                               !   !   !   !   !   !   "      self    I      _ENV )   <       � @ �@ ��� 
���� � 
������ 
���� � 
������ 
�����B �@ � C �@ �@C �@ ��C �@ ��C �@ � D �@ �@D �@ ��D �@ & �    _AttachEvents
_campaign       _component       _giftId       	_giftNum       
_callback       _GetComponents
_SetTitle	_SetTips_SetImg
_SetLimit
_SetPrice_SetAwardsImmediately_SetAwardsDaily           *   *   ,   ,   .   .   /   /   0   0   1   1   3   3   5   5   6   6   7   7   8   8   9   9   :   :   ;   ;   <      self       	uiParams            >   @       L @ d@ & �    _DetachEvents           ?   ?   @      self            B   G       G @ L@� ǀ@ d��b   � ���� � A�@    ��@ ǀA ���FB GA�� d �@  & � 
   _componentGetGiftCfgById_giftIdName       	_txtNameSetTextStringTableGet            C   C   C   C   D   D   D   D   D   D   D   F   F   F   F   F   F   F   G      self       gift      id         _ENV I   R       G @ b   ��G @ G@� b   ��L�@ d� ��@ � A � �@��@A ��A� �@�� �G@A L�� �   d@�& �    
_campaign_sampleGetCycleTypeStr	_txtTipsSetText_goTips
SetActive           J   J   J   J   J   J   J   K   K   M   M   M   M   N   N   N   N   N   P   P   P   P   R      self       strCycleType	           T   Y       G @ L@� ǀ@ d��b   � ���� �@    ��  �@A ̀�@ �@�& �    _componentGetGiftCfgById_giftIdIconDetail	_imgIcon
LoadImage           U   U   U   U   V   V   V   V   V   V   X   X   X   X   Y      self       gift      url
           [   c       L @ d� �@@ ��@� � �� �    ���@ � A  �@����@A ��A � �@���@ � A� �@�& �    GetCountStrstringisnullorempty	_goLimit
SetActive
_txtLimitSetText            \   \   ]   ]   ]   ]   ]   ]   ^   ^   ^   ^   ^   `   `   `   `   a   a   a   a   c      self       str         _ENV e   j    	   G @ ��@ ��@J���G A J���L�A d@ & �    
_txtPricecolorColorwhite_btnBuyinteractable_FlushPrice         	   f   f   f   f   g   g   i   i   j      self    	      _ENV l   |    6   G @ L@� ǀ@ d����@ �� � A �@�� @�ǀA ���� �C  �@��@B ̀�@� �@� �� A ����  �ǀA ���� �C  �@��@B ̀�FC GA��� d �@  ��ǀA ���� �C� �@�ǀA D AD��D � $�  � ���@B ̀�@� �@�& �    _componentGetGiftPriceForShowById_giftIdGetPriceTypeGiftPackType	Currency
_imgPricegameObject
SetActive
_txtPriceSetTextFreeStringTableGetstr_pay_freesprite_atlas
GetSpriteGetPriceIcon         6   n   n   n   n   p   p   q   q   q   q   r   r   r   r   r   s   s   s   s   s   t   t   t   t   u   u   u   u   u   v   v   v   v   v   v   v   v   x   x   x   x   x   y   y   y   y   y   y   y   z   z   z   z   |      self    6   price   6   
itemtType   6      _ENV ~   �    *   G @ L@� ǀ@ d���   ��@  � � @�A BA������$� FB GB�� � dB��  j��ǀB ���A �B ��A� � �@  ǀB �@�� �@ @�$� �L�C��dB�)�  ���& �    _componentGetGiftExtraAwardById_giftIdipairsGiftPackShopItemAwardNewassetidcounttableinsert_sopImmediatelySpawnObjectsUIActivityGiftPackGetItemGetAllSpawnListFlush         *               �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    *   lst   *   awardsImmediately   *   (for generator)      (for state)      (for control)      i	      item	      item      lstImmediately    *   (for generator)#   )   (for state)#   )   (for control)#   )   i$   '   ui$   '      _ENV �   �       G @ L@� �   d@�& �    	_goDaily
SetActive           �   �   �   �   �      self            �   �       G @ b    �G @ G@� b    �G @ G@� G�� b@    �A�  f  & �    
_campaign_sample	end_time                   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self            �   �       F @ G@� ��@ d� ��� �� � A�@A � ��& & �    GameGlobal
GetModuleSvrTimeModuleGetServerTime�      GetEndTime            �   �   �   �   �   �   �   �   �   �   �   �      self       	mSvrTime      nowTime      endTime	      leftSeconds
         _ENV �   �    F   A   �@@ �� !�@@���@ � �A � @ � �!�A@���A � ��@ AAA �� $��  @ � �!�B@�� C �@��A� �A BF�@ G��A ��d�$�  @   �!�C@�� C �@��B� �A BF�@ G��� ��d�$�  @   �� C �@��C� �A BF�@ G�� ��d�$�  @  f  & �    GetLeftSeconds        StringTableGetstr_pay_expired<       stringformatstr_pay_left_minute             mathceil�Q     str_pay_left_hourstr_pay_left_day         F   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    F   str   F   leftSeconds   F   leftMinutes   &   
leftHours-   6   	leftDays;   D      _ENV �   �       G @ L@� ǀ@ d����@ � �� @ ��@ �  �@ � @ �@��A BFAB G���� ��d�$�  & & �    _componentGetGiftBuyCount_giftIdSpecialNumMysteryGoodsUnlimitedNum/stringformatStringTableGet#str_pay_purchase_limitation_normal            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       	buyCount      
saleCount      n2m      	strLimit         _ENV �   �    '   G @ L@� ǀ@ d��b   � ���� �@  @ �� A �@A�  A �AF�A G��@AB �BF�A G���@AB CF�A GA��@A AAF�A G���@��"A  @ ��A �C& & �    _componentGetGoodCfgById_giftId	SaleTypeSpecialNumFreeGiftSaleTypeNeedPayMoneyGiftPackType	CurrencyRoleAssetIDRoleAssetDiamondYaojingRoleAssetGlowGuangpoFreeItem         '   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    '   good   '   	saleType   '   tb    '      _ENV �   �    
   G @ L@� ǀ@ d����� �    � ��  & �    _componentGetGoodCfgById_giftId	SaleType	toptoon_        
   �   �   �   �   �   �   �   �   �   �      self    
   good   
   	saleType   
        �   �       � @ A  �@���@ ��@ �@��@A ,  @  �@ & �    Lock UIActivityGiftPackDetail:OnHide_animPlay#Uieff_UIActivityGiftPackDetail_Out
StartTask         �   �       F @ �   �@  d@�E � L�� ��  d@�E � L � d@ & �    YIELD�      UnLock UIActivityGiftPackDetail:OnHideCloseDialog             �   �   �   �   �   �   �   �   �   �   �   �      TT          _ENVself   �   �   �   �   �   �   �   �   �   �   �   �      self       go          _ENV �   �       � @ �@@�@ G�@ �@ & �    _componentBuyGift_giftId	_giftNum           �   �   �   �   �   �      self       go            �   �       L @ �@@ ǀ��@ d@ L @ �@@ � �AA d@ L @ �@@ ǀ��A d@ & �    AttachEventGameEventTypeActivityCloseEvent_CheckActivityCloseActivityCurrencyBuySuccess_OnCurrencyBuySuccessActivityNormalBuyResult_OnNormalBuyResult            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self          _ENV �         L @ �@@ ǀ��@ d@ L @ �@@ � �AA d@ L @ �@@ ǀ��A d@ & �    DetachEventGameEventTypeActivityCloseEvent_CheckActivityCloseActivityCurrencyBuySuccess_OnCurrencyBuySuccessActivityNormalBuyResult_OnNormalBuyResult            �   �   �   �   �                                 self          _ENV         � @ �   ��� @ �@@@ � ���@ �@ A�@�& �    
_campaign_idSwitchStateUIStateTypeUIMain                                       self       id          _ENV 
        � @ @ @��@@ �    ���@ ��@�� � AC� �@��@@   �@ �@A �@ & �    _giftId
_callbackAsyncRequestResNewSetSucc
bgOnClick                                                   self       id       res	         _ENV          � @ @����@@ �   � ��@@   �@ ̀@ �@ & �    _giftId
_callback
bgOnClick                                       self       gift_id       res           O                        "      )   <   )   >   @   >   B   G   B   I   R   I   T   Y   T   [   c   [   e   j   e   l   |   l   ~   �   ~   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �     �         
    
                   _ENV