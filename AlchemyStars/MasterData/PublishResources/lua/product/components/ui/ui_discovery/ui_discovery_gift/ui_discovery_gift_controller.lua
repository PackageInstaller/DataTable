LuaS �

xV           (w@o@../PublishResources/lua/product/components/ui/ui_discovery/ui_discovery_gift/ui_discovery_gift_controller.lua         @    @ A@  ��@ $@�@@  ��@@ l   
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
@��& �    _classUIDiscoveryGiftControllerUIControllerConstructorOnShowCancelGiftRedCheckBuyState
ShowTimerShowTimeTexOnCurrencyBuySuccessOnCurrencyBuyErrorOnItemClickLst2GiftPackShopItemAwardGetItemDataCheckOutTimeBuyBtnOnClick
CanChargeCanChargeCoroBuyGoodsTaskOnHide
BgOnClickCloseBtnOnClick                  & �                      self               9    m   �@� 
� ���� 
� ��@A �� 
� ���A  AA �� 
� ���A � A �� 
� ���A  A� �� 
�����A � A �� 
�����C ��D� ���
����@E � ���
� ���A  A �� 
����@E  ���
����� ��F � �@ AG� ���F�G G�� d� ��B �AH� \��A ��B ��H�� �A  �AB  ��ǂ��OIMC�C�  l  ���C��A�ǁ��A �I�J �BJ��� $B  A �J$� GBC L��� dB�
 ˕LBK ƂK ���L dB LBK ƂK �B��L dB L�L dB LM dB & � 5   _good       _cfgv       
_itemDataGetItemData
_titleTexGetUIComponentUILocalizationText	titleTex_awardsPoolUISelectObjectPathpool
_priceTex	priceTex
_itemInfo	itemInfo_selectInfoSpawnObjectUISelectInfo_buyBtnGetGameObjectBuyBtn
_timerTex	timerTex	_timerGod       Cfgcfg_shop_giftmarket_goodsgift_idDirectAssetListGiftPackShopDataItemString2ListSpawnObjectsUIDiscoveryGiftControllerAwardGetAllSpawnList!       SetDataNameSetTextStringTableGetGetPriceWithCurrencySymbol_buying AttachEventGameEventTypeActivityCurrencyBuySuccessOnCurrencyBuySuccessMidasPayErrorOnCurrencyBuyErrorCheckBuyStateCancelGiftRed         $   &       �   � @   @� �@ & �    OnItemClick           %   %   %   %   %   &      id       pos          selfm   
   
                                                                                                                                                                                                             !   "   #   #   $   $   &   &   $       )   *   *   *   *   *   *   *   ,   ,   ,   -   -   -   -   /   2   2   2   2   2   3   3   3   3   3   6   6   8   8   9      self    m   	uiParams    m   yieldTimeStart.   m   cfg3   m   
awardsStr4   m   awards8   m   pools@   m   (for index)C   N   (for limit)C   N   (for step)C   N   iD   M   itemE   M   awardF   M   
yieldTimeH   M   titleO   m   priceY   m      _ENV :   C       G @ b   ��G @ G@� ��@ ��@� A �� �@A� � @��� �F�A G�� �A dA�F�@ G��d�� L���C �A�dA�& �    _goodgift_idGameGlobal
GetModuleRoleModule	GetPstIdUIDiscoveryGiftItemLocalDBSetInt       EventDispatcher	DispatchGameEventTypeOnDisGiftCheckRed            ;   ;   ;   <   <   =   =   =   =   >   >   ?   ?   ?   ?   @   @   @   @   @   A   A   A   A   A   A   A   C      self       gidtid      roleModule	      pstid      key         _ENV D   _    8   F @ G@� ��@ d� ��� �� � A� @ �@��A � 
����@A �@��� 
 �
�����A ǀ�  F�B G��  d� �AC �����ǂC�C �C�@ �  @ ���  *���  "  ���D ���� ��D �  ��� ǁD ���@ �A��E @ � �A & �    GameGlobal
GetModuleSvrTimeModuleGetServerTime����MbP?_shopModuleShopModule
_GiftData	_GiftCfgGetGiftMarketDatagoodsCfgcfg_shop_giftmarket_goodspairsgift_id_gooddeadline_time        _buyBtn
SetActive
ShowTimer         8   E   E   E   E   F   F   F   G   G   G   G   G   H   H   H   H   H   L   L   M   N   N   N   N   O   O   O   O   P   Q   Q   Q   Q   R   R   O   O   V   W   W   X   X   X   X   X   X   Y   \   \   \   \   ^   ^   ^   ^   _      self    8   svrTimeModule   8   svrTime   8   	giftList   8   data   8   cfgs   8   (for generator)   %   (for state)   %   (for control)   %   k   #   v   #   giftid   #   show&   8      _ENV `   n       � @ �@�@� �@�ǀ@ �   @���@ � �䀀 �@�G�@ �@�b   @���A
� ���@ � �䀀 � �AA ��B ��B�  䀀
� �� C �@ & �    	_timerGo
SetActive_timerGameGlobalTimerCancelEvent	_endTimedeadline_timeAddEventTimes�      TimerTriggerCount	InfiniteShowTimeTex         i   k            @ $@ & �    ShowTimeTex           j   j   j   k          self   a   a   a   a   b   b   b   c   c   c   c   c   c   f   f   g   g   i   i   i   i   i   i   i   k   i   k   l   l   n      self       show       data          _ENV o   w    
   F @ G@� ��@ d� ��� �� � A�@A ǀ��A � �  � �@�AB �B$� �B��$��GC LA�ƁC ��� @ ��dA  & �    GameGlobal
GetModuleSvrTimeModuleGetServerTime����MbP?mathfloor	_endTime        HelperProxyGetInstance	Time2Tex
_timerTexSetTextStringTableGet#str_shop_discovery_gift_c_time_str            p   p   p   p   q   q   q   r   r   r   r   r   s   s   t   t   t   t   t   t   u   u   u   u   u   u   u   u   w      self       svrTimeModule      svrTime      gap      timeStr         _ENV x   �       � @ �@@��   � �@���@ � A�� ��� @ �@@�@ �@ 
�A�� B �@ & � 	   Logdebug0###[UIDiscoveryGiftController] 购买成功,id:_goodgift_id9###[UIDiscoveryGiftController] 购买成功,刷新状态_buying CloseDialog            y   y   y   y   y   {   {   {   {   |   |   |   |   }   �   �   �      self       giftid          _ENV �   �       F @ G@� ��  d@ 
 ��& �    Logdebug,###[UIDiscoveryGiftController] 购买失败_buying             �   �   �   �   �   �      self          _ENV �   �    	   � @ �    �� @ �@�@� � �@ & �    _selectInfoSetData        	   �   �   �   �   �   �   �   �   �      self    	   id    	   pos    	        �   �       �   � @  � � @�B@ �@�����$� FBA G��� � dB��  j���  & �    ipairsGiftPackShopItemAwardNewtemplateIdcounttableinsert            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   	   self       lst       items      (for generator)      (for state)      (for control)      i      item      item
         _ENV �   �    �   F @ L@� ǀ@ ���d��� A �@Aǀ@ ����� ǀA �A B� �A� ��$A��� �� $A�� �AC$A��CF�C G�� d� �AD  ����́� @ �A�ǁA �A �D���C D@�$� LBD � d����  ��B���A ��A �B���̂� C  �B���� C  �B��� C  �B�J�ƌ��F �A F�A G�C� C� ��$C��F G�A ��A ��GG��$� L�� � dC�L� ǃ@ �C�dC�F�F ��A ��A ǃ���d� ���  ��C��I��F �A F�A GD�D� �I �I �	�� �DJ ��J	$D��� �  $D�� �  $D�D� ��$D��K �KFL $� LDLd� ��L ��L	�  ��D��Ā�D �   ��M	"  @ �ǄM	� ��L �M
A $E E� ��	$E��F G�A ��A ��N	G��$� J �� �DO ��O	��O� $D  � �DP$D��� ��P$D�f  & � D   GiftPackShopItemNew_goodgift_idCfgcfg_shop_giftmarket_goods_cfgv
ConfigKeyConfigKey_MidasItemIdSetMidasIdSetBuyCount       SetMaxBuyCountSaleNumDirectAssetListGiftPackShopDataItemString2ListLst2GiftPackShopItemAwardSetAwardsImmediatelyConfigKey_CycleAcceptAssetListSetAwardsDailyConfigKey_ShopGiftTypeSetIsMonthCardSetBattlePassGiftSetRechargeGiftisWeekCard 	tonumberConfigKey_RefreshMethodSetCycleTypeConfigKey_RefreshIntervalSetCycleDayCountSetRefreshTimedeadline_timeConfigKey_ShowEndTimeSetEndTime	SaleTypeConfigKey_NowPriceSpecialNumNeedPayMoneySetTypeGiftPackType	CurrencySetPriceIconSetPriceItemId	SetPriceGameGlobal
GetModule
PayModuleGetGoodPriceListLogdebug###[lxs] price 8 midasId:priceerror8###[UIDiscoveryGiftController] goodPrice.price is nil !SetPriceWithCurrencySymbol
_discountConfigKey_DiscountSetNameStringTableGetNameSetIconIconSetIconDetailIconDetail         �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    �   item   �   cfg
   �   midasId   �   strOneTime   �   lstOneTime   �   awardsImmediately   �   	strCycle&   �   	lstCycle*   �   awardsDaily-   �   strShopGiftType4   �   refreshMethodD   �   refreshIntervalM   �   showEndTimeZ   �   	saleType^   �   priceNotCashd   �   mPayy   �   goodPriceList{   �   
goodPrice�   �   	priceTex�   �      _ENV �   �    2   F @ G@� ��@ d� ��� �� � A� @ �@��A � 
����@A �@��� 
 �
�����A ǀ�  F�B G��  d� �AC �����ǂC�C �C�@ �  @ ���  *���  "  ���D ���� ��D �  ��� � � & �    GameGlobal
GetModuleSvrTimeModuleGetServerTime����MbP?_shopModuleShopModule
_GiftData	_GiftCfgGetGiftMarketDatagoodsCfgcfg_shop_giftmarket_goodspairsgift_id_gooddeadline_time                 2   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    2   svrTimeModule   2   svrTime   2   	giftList   2   data   2   cfgs   2   (for generator)   %   (for state)   %   (for control)   %   k   #   v   #   giftid   #   show&   2      _ENV �      
:   � @ �� �    ��@@ ��@��  �@ �  �@A ǀ��A B@ $ �@  & � �@B ��B��B � ��� �@C�C �C@�$� "  ��D ADF�D $� �D�E �AE�  � A� $A A@ FAA $A & � �F "   �A@ �@A� $A & � G �  �  $A & �    CheckOutTimeLogdebug,###[UIDiscoveryGiftController] 礼包过期#str_shop_discovery_gift_c_out_timeToastManager
ShowToastStringTableGetCfgcfg_shop_giftmarket_goods_goodgift_idDirectAMidasIDstringisnulloremptyGameGlobalGetUIModuleShopModuleReportPayStepPayStepClickPurchaseButton��������midasId_is_emptyfatal ### [Pay]midasId can't be empty_buying+###[UIDiscoveryGiftController] is buying !
StartTask         	     $   E   L � �@  d@��@�F � G@� ��� d� ���    FB GA��� ƀ� ���  � �   � ��   � �E �@�� � �@�䀀 ̀�F�� G��@��   �@�AA  �@�& �    Lock(UIDiscoveryGiftController:BuyBtnOnClick_buyingGameGlobal
GetModuleShopModuleBuyGift_goodgift_idClientShopCheckShopCode
CanChargeEventDispatcher	DispatchGameEventTypeShopNewUnLock          $   
  
  
  
                                                                     TT    $   shopModule	   $   ret   $      self_ENVmidasId:   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �                                              self    :   go    :   tips	      cfg   :   midasId   :      _ENV         � @ A  �@���@ ��@��� � AAA @  �� �@�& �    Lock(UIDiscoveryGiftController:CanChargeCoroGameGlobalTaskManager
StartTaskCanChargeCoro                                       self       midasId          _ENV   1   ,   � @ �@��@ � ��$� "A  @�A �AA �    A� $A �A � $A�& � @ A@FAB $� L�B�� d��b  ��L�B � dA�L�A � dA�& � LA �AA    @ �� dA L�A � dA�& �    GameGlobal
GetModuleRoleModuleIsJapanZone
StartTaskBuyGoodsTask       UnLock(UIDiscoveryGiftController:CanChargeCoro
PayModuleNeedSelectAgeShowDialogUISetAgeConfirmController         ,                       !  !  !  !  !  !  "  "  "  #  '  '  '  '  )  )  )  )  )  *  *  *  +  +  +  ,  /  /  /  /  /  /  0  0  0  1     self    ,   TT    ,   midasId    ,   roleModule   ,   
payModule   ,      _ENV 3  f   r   @ �A@ $��F�@ d�� bA  ��F�@ d�� bA  � �FA d�� b  @�FAA G����A �B�� �LAB��   @�d��ƁB ��� GB��A�́�� �A   ��A��C D �@��AD ǁ�� FE GB���E ��E� CF �FA� $ �A  ���AD ǁ�� FE GB���E ��E� CF �FA $ �A   ��A   �ƁB ���B �A @	��A��C �G � ���GHF�B G���B ��� @ dB�L�H� I dB ��FAA G����A �AI�� �L�I�I  �dA ��F�I d�� b  � �L�I�I  �dA & � (   
GetModule
PayModule
IsAndroidIsUnityEditorIsPcH3DGCloudLuaHelperMsdkStatusMSDKStatus
MS_InlandSendBuyGoodsRequestLogdebug<UIDiscoveryGiftController:BuyGoodsTask IsAndroid start res 	m_resultGetSuccPayErrorCodePAY_ERROR_NOT_USE_MIDASPopupManagerAlertUICommonMessageBoxPopupPriorityNormalPopupMsgBoxTypeOkStringTableGet$str_pay_direct_buy_need_open_switch"str_pay_direct_buy_fail_try_later<UIDiscoveryGiftController:BuyGoodsTask failed no replyEvent	PAY_SUCCtokenurl_params6UIDiscoveryGiftController:BuyGoodsTask success token  url BuyGoodsByUrl
_itemDataMS_InternationalBuyGoodsByGiftPackShopItemIsIos         r   4  4  4  5  5  5  5  5  5  5  5  5  5  5  5  6  6  6  6  6  6  7  7  7  7  7  8  8  8  8  8  9  9  9  9  :  :  :  :  :  ;  ;  <  =  =  >  >  ?  @  @  @  @  ;  A  C  C  D  E  E  F  F  G  H  H  H  H  C  J  K  K  L  L  L  L  L  M  M  M  M  M  N  O  P  P  P  P  P  P  P  Q  Q  Q  Q  R  S  S  S  S  S  S  T  T  T  T  U  V  V  V  V  W  W  W  W  f  	   self    r   TT    r   itemId    r   
itemCount    r   mPay   r   res   ]   replyEvent   ]   tokenQ   ]   urlR   ]      _ENV h  l   
   G @ b   @�F@@ G�� d�� L�� � @ d@�& �    _timerGameGlobalTimerCancelEvent         
   i  i  i  j  j  j  j  j  j  l     self    
      _ENV n  p      � @ �@ & �    CloseDialog           o  o  p     self       go            q  s      � @ �@ & �    CloseDialog           r  r  s     self       go           @                                 9      :   C   :   D   _   D   `   n   `   o   w   o   x   �   x   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �     �           1    3  f  3  h  l  h  n  p  n  q  s  q  s         _ENV