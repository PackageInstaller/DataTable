LuaS �

xV           (w@�@../PublishResources/lua/product/components/ui/ui_simple_haute_couture/common/pack_detail/ui_simple_haute_couture_gift_pack_detail.lua         R    @ A@  ��@ $@�@@  ��@@ l   
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
@ �@@ l  
@��& �    _class#UISimpleHauteCoutureGiftPackDetailUIController_GetComponentsOnShowOnHide
_SetTitle	_SetTips_SetImg
_SetLimit_FlushPrice_SetAwardsImmediately_SetAwardsDailyGetEndTimeGetLeftSecondsGetCycleTypeStrGetCountStrGetPriceIcon
BgOnClickBtnBuy1OnClickBtnBuy2OnClick_BuyConfirmForYaojing_GoBuyFunc_AttachEvents_DetachEvents_CheckActivityClose_OnCurrencyBuySuccess_OnNormalBuyResult           !    I   L@@ ��  �  d� 
@ �L@A �� d��
@ �L@@ ��   d� 
@��L@@ �� � d� 
@��L@A �@ d��
@ �G C L�� �   d@�L@@ ��   d� 
@��L@@ �� � d� 
@��L@@ ��  A d� 
@ �L@@ ��  � d� 
@ �L@@ �@ � d� 
@ �L@@ �@  d� 
@��L@A �� d��
@��L@@ �  A d� 
@��L�H � 	 AI �Id� 
@ �& � '   	_txtNameGetUIComponentUILocalizationTexttxtName_goTipsGetGameObjecttips	_txtTipstxtTips	_imgIconRawImageLoaderimgIcon	_goLimitlimit
SetActive
_txtLimit	txtLimit
_imgPriceImage	imgPrice_txtPrice1
txtPrice1_txtPrice2
txtPrice2_sopImmediatelyUISelectObjectPathsopImmediately
_sopDaily	sopDaily	_goDailydaily_anim
AnimationuiAnim_atlas	GetAssetUICommon.spriteatlas	LoadTypeSpriteAtlas         I                              
   
   
   
   
                                                                                                                                                                                       !      self    I      _ENV (   >    #   � @ �@ ��� 
���� � 
������ 
���� � 
������ 
�����B � C�@A �� ǀC
�����C �@ � D �@ �@D �@ ̀D �@ ��D �@ � E �@ �@E �@ ̀E �@ & �    _AttachEvents
_campaign       _component       	_gift2Id       	_giftNum       
_callback       Cfgcfg_shop_common_goods	_gift1IdCurrencySkinID_GetComponents
_SetTitle	_SetTips_SetImg
_SetLimit_FlushPrice_SetAwardsImmediately_SetAwardsDaily         #   )   )   +   +   -   -   .   .   /   /   0   0   2   2   2   2   3   3   5   5   7   7   8   8   9   9   :   :   ;   ;   <   <   =   =   >      self    #   	uiParams    #   cfg   #      _ENV @   B       L @ d@ & �    _DetachEvents           A   A   B      self            D   R       F @ G@� �@  ��@ �� �d� b    �� A � � �� @A ���A ��A�  �@ �@�G@� ��B ��BC ACG�� G���� �AB��C$��@  & �    Cfgcfg_component_buy_giftGiftID	_gift2Idnext Log
exception*cfg_component_buy_gift中找不到礼包:       	_txtNameSetTextStringTableGetName       ExtraAward            J   J   J   J   J   J   K   K   K   K   K   K   K   L   L   L   L   L   N   Q   Q   Q   Q   Q   Q   Q   Q   Q   Q   Q   R      self       cfg         _ENV T   ]       G @ G@� b   ��L�@ d� ��@ � A � �@��@A ��A� �@�� �G@A L�� �   d@�& �    _componentm_component_infoGetCycleTypeStr	_txtTipsSetText_goTips
SetActive           U   U   U   U   V   V   X   X   X   X   Y   Y   Y   Y   Y   [   [   [   [   ]      self       strCycleType           _   d       F @ G@� ��@ G�� ��� �   � �� A �@A�� �@�& �    Cfgcfg_shop_common_goods	_gift2IdIconDetail	_imgIcon
LoadImage            `   `   `   `   a   a   a   b   b   b   b   d      self       cfg         _ENV f   n       L @ d� �@@ ��@� � �� �    ���@ � A  �@����@A ��A � �@���@ � A� �@�& �    GetCountStrstringisnullorempty	_goLimit
SetActive
_txtLimitSetText            g   g   h   h   h   h   h   h   i   i   i   i   i   k   k   k   k   l   l   l   l   n      self       str         _ENV p   x       G @ L@� ǀ@ d����@ � A�@A �� ��A��A � �@� �@��@B �B C�AC � $�  � �ǀC � �@ �@�& �    _componentGetGiftPriceForShowById	_gift2IdCfgcfg_shop_common_goods	_gift1IdPrice_txtPrice2SetText
_imgPricesprite_atlas
GetSpriteGetPriceIcon_txtPrice1            r   r   r   r   s   s   s   s   s   u   u   u   u   v   v   v   v   v   v   v   w   w   w   w   x      self       price2      price1	         _ENV z   �    *   G @ L@� ǀ@ d���   ��@  � � @�A BA������$� FB GB�� � dB��  j��ǀB ���A �B ��A� � �@  ǀB �@�� �@ @�$� �L�C��dB�)�  ���& �    _componentGetGiftExtraAwardById	_gift1IdipairsGiftPackShopItemAwardNewassetidcounttableinsert_sopImmediatelySpawnObjects$UISimpleHauteCoutureGiftPackGetItemGetAllSpawnListFlush         *   {   {   {   {   }   ~   ~   ~   ~                  �   �   �   �   �   ~   ~   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    *   lst   *   awardsImmediately   *   (for generator)      (for state)      (for control)      i	      item	      item      lstImmediately    *   (for generator)#   )   (for state)#   )   (for control)#   )   i$   '   ui$   '      _ENV �   �       G @ L@� �   d@�& �    	_goDaily
SetActive           �   �   �   �   �      self            �   �       G @ b   � �G @ G@� G�� f  & �    _componentm_component_infom_close_time           �   �   �   �   �   �   �   �      self            �   �       F @ G@� ��@ d� ��� �� � A�@A � ��& & �    GameGlobal
GetModuleSvrTimeModuleGetServerTime�      GetEndTime            �   �   �   �   �   �   �   �   �   �   �   �      self       	mSvrTime      nowTime      endTime	      leftSeconds
         _ENV �   �    F   A   �@@ �� !�@@���@ � �A � @ � �!�A@���A � ��@ AAA �� $��  @ � �!�B@�� C �@��A� �A BF�@ G��A ��d�$�  @   �!�C@�� C �@��B� �A BF�@ G��� ��d�$�  @   �� C �@��C� �A BF�@ G�� ��d�$�  @  f  & �    GetLeftSeconds        StringTableGetstr_pay_expired<       stringformatstr_pay_left_minute             mathceil�Q     str_pay_left_hourstr_pay_left_day         F   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    F   str   F   leftSeconds   F   leftMinutes   &   
leftHours-   6   	leftDays;   D      _ENV �   �       G @ L@� ǀ@ d����@ � �� @ ��@ �  �@ � @ �@��A BFAB G���� ��d�$�  & & �    _componentGetGiftBuyCount	_gift1IdSpecialNumMysteryGoodsUnlimitedNum/stringformatStringTableGet#str_pay_purchase_limitation_normal            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       	buyCount      
saleCount      n2m      	strLimit         _ENV �   �    
   G @ L@� ǀ@ d����� �    � ��  & �    _componentGetGoodCfgById	_gift1Id	SaleType	toptoon_        
   �   �   �   �   �   �   �   �   �   �      self    
   good   
   	saleType   
        �   �       � @ A  �@���@ ��@ �@��@A ,  @  �@ & �    Lock*UISimpleHauteCoutureGiftPackDetail:OnHide_animPlay#Uieff_UIActivityGiftPackDetail_Out
StartTask         �   �       F @ �   �@  d@�E � L�� ��  d@�E � L � d@ & �    YIELD�      UnLock*UISimpleHauteCoutureGiftPackDetail:OnHideCloseDialog             �   �   �   �   �   �   �   �   �   �   �   �      TT          _ENVself   �   �   �   �   �   �   �   �   �   �   �   �      self       go          _ENV �   �       � @ �     �& � �@@ �@ & �    
_isBuying_BuyConfirmForYaojing           �   �   �   �   �   �   �      self       go            �   �       � @ �     �& � �@@ ��@�@ GA �AA �@�
�A�& �    
_isBuying_componentBuyGift	_gift2Id	_giftNum
_giftType           �   �   �   �   �   �   �   �   �   �   �   �      self       go            �   �    3   F @ G@� ��@ G�� G�� � @ � A�@  �A � ���� �    ���A   �  � ��@B ǀ�� G�A �@�� C�@C ǀ��CDGADG�G�䀀AC �CA� �� ��$� F�D G��A ƁE ���F BFA� � �   dA & �    Cfgcfg_shop_common_goods	_gift1IdPricecfg_component_buy_giftGiftID	_gift2Idnext Log
exception*cfg_component_buy_gift中找不到礼包:       StringTableGetName       ExtraAward$str_junior_skin_draw_confirm_to_buyPopupManagerAlertUICommonMessageBoxPopupPriorityNormalPopupMsgBoxType	OkCancel         �   �       E   L � d@ & �    _GoBuyFunc           �   �   �   �      param          self3   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    3   price   3   cfg   3   	giftName    3   strText&   3      _ENV �      	   F @ G@� ��@ G�� G�� � A AA ���̀A� ���� �� ,  $��"  ��B AB��@ ǁB �B $A�
@C���& �    Cfgcfg_shop_common_goods	_gift1IdPrice
GetModuleShopModuleGetClientShopCheckEnoughYJ_componentBuyGift	_giftNum
_giftType
_isBuying                  & �                             �   �   �   �   �                          	  	  
  
  
  
  
  
           self       price      shopModule      clientShop
         _ENV         L @ �@@ ǀ��@ d@ L @ �@@ � �AA d@ L @ �@@ ǀ��A d@ & �    AttachEventGameEventTypeActivityCloseEvent_CheckActivityCloseActivityCurrencyBuySuccess_OnCurrencyBuySuccessActivityNormalBuyResult_OnNormalBuyResult                                               self          _ENV         L @ �@@ ǀ��@ d@ L @ �@@ � �AA d@ L @ �@@ ǀ��A d@ & �    DetachEventGameEventTypeActivityCloseEvent_CheckActivityCloseActivityCurrencyBuySuccess_OnCurrencyBuySuccessActivityNormalBuyResult_OnNormalBuyResult                                               self          _ENV   !      � @ �   ��� @ �@@@ � ���@ �@ A�@�& �    
_campaign_idSwitchStateUIStateTypeUIMain                                  !     self       id          _ENV #  .      � @ @ ���@@ �    ���@ ��@�� � AC� �@��@@   �@ 
�����A �@ & �    	_gift2Id
_callbackAsyncRequestResNewSetSucc
_isBuying 
BgOnClick            %  %  %  &  &  &  '  '  '  (  (  (  )  )  )  +  ,  ,  .     self       id       res	         _ENV 0  9      � @ @� ��@@ �   � ��@@   �@ 
�@�� A �@ & �    	_gift1Id
_callback
_isBuying 
BgOnClick           2  2  2  3  3  3  4  4  4  6  7  7  9     self       gift_id       res           R                        !      (   >   (   @   B   @   D   R   D   T   ]   T   _   d   _   f   n   f   p   x   p   z   �   z   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �     �                 !    #  .  #  0  9  0  9         _ENV