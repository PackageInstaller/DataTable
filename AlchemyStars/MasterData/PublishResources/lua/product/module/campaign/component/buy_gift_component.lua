LuaS �

xV           (w@R@../PublishResources/lua/product/module/campaign/component/buy_gift_component.lua         ^    @ A@  $@ �@ A�  � A $@��@  ���@ l   
@���@ l@  
@ ��@ l�  
@���@ l�  
@ ��@ l  
@���@ l@ 
@ ��@ l� 
@���@ l� 
@ ��@ l  
@���@ l@ 
@ ��@ l� 
@���@ l� 
@ ��@ l  
@���@ l@ 
@ ��@ l� 
@���@ l� 
@ ��@ l  
@���@ l@ 
@ ��@ l� 
@���@ l� 
@ ��@ l  
@���@ l@ 
@ ��@ l� 
@���@ l� 
@ ��@ l  
@���@ l@ 
@ ��@ l� 
@���@ l� 
@ �& � !   requirecomponent_base_classBuyGiftComponentICampaignComponentConstructorComponentInfoGetComponentInfoGetComponentTypeInitComponentInfoGetGiftTypeKeyHandleApplyBuyGiftCampaignComponentPushNotifyOnBuyStateChangedGetAllGiftIDByTypeGetFirstGiftIDByTypeGetAllGiftMidasIdGetGiftMidasIdByIdGetAllGiftLocalPriceGetGiftPriceByIdGetGiftPriceForShowByIdGetGiftPriceForBuyByIdGetGiftExtraAwardByIdGetGiftBuyCountGetGiftCfgByIdGetGiftCfgShowAwardByIdGetGoodCfgByIdBuyGiftBuyGift_RoleAssetBuyGift_DirectAMidas
CanChargeCanChargeCoroBuyGoodsTask           	       F@@ L�� d� 
@ �& �    m_component_infoBuyGiftComponentInfoNew                        	      self          _ENV        
   G @ b@  � �F@@ L�� d� 
@ �G @ f  & �    m_component_infoBuyGiftComponentInfoNew         
                                    self    
      _ENV           L @ e  f   & �    ComponentInfo                          self                      F @ G@� f  & �    CampaignComTypeE_CAMPAIGN_COM_BUY_GIFT                           self          _ENV            � @ �@@ǀ� �@ ����  & �    ComponentDataHelper
ParseDatam_datam_component_info                                     self       a_load_info       ret         _ENV #   *       ��  � @ �@����� @ ���� �� @ �@�� ��@ �  & �    CampaignGiftTypeECGT_ADVANCEDstr_activity_battlepass_eliteECGT_LUXURYstr_activity_battlepass_deluxeECGT_ADDITIONALBUY            $   %   %   %   &   &   &   '   '   '   )   )   *      self       
gift_type       type2id
         _ENV 1   I    #   F@ LA�d� ��@ �A@�� J���J��AA � �A �A�� � �GC���� $B �B �BGC_@��BC �CA� �C$B�  & D�� $B�& �    BuyGiftComponentApplyBuyReqNewBuyGiftComponentApplyBuyRep
m_gift_idm_buy_countComponentInfom_campaign_com_moduleCampaignComProtoRequestm_campaign_idm_component_idCampaignErrorTypeE_CAMPAIGN_ERROR_TYPE_SUCCESS	m_resultLogerror8[CampaignCom][BuyGiftComponent] HandleApplyBuyGift ret:SetSucc         #   2   2   2   3   3   3   4   5   7   7   8   8   9   :   ;   <   =   ?   8   A   A   A   A   A   B   B   B   B   B   C   C   H   H   H   I      self    #   TT    #   	asyncRes    #   gift_id    #   count    #   request   #   	response   #   ComponentInfo
   #      _ENV M   X       � @ �@@ǀ� � ����@ � A�� �@A ǀ��� @ 䀀�   � �B � $A� �AB �BA� ��$A�& �    BuyGiftComponentNotifyType'BuyGiftComponentNotify_BuyStateChangedm_notify_type%NotifyBuyGiftComponentBuyStateChangeNewComponentDataHelper
ParseDatam_dataOnBuyStateChangedLogerrorR[CampaignCom][BuyGiftComponent] CampaignComponentPushNotify ParseData error! ret:            N   N   N   N   N   P   P   P   Q   Q   Q   Q   Q   R   R   S   S   S   S   U   U   U   U   U   X      self       notify_data       ev      ret         _ENV [   _       � @ �@� ����� @ ǀ� �� �& �    m_component_infom_buy_gift_mapm_buy_state           ]   ]   ]   ^   ^   ^   _      self       ev            f   o       �   � @ A@ �@� ����@ ��A BA@ ���$B��A BAB �� �� ��$B��  j���  & �    ipairsm_component_infom_campaign_gift_listm_gift_typetableinsert
m_gift_idLogdebug3BuyGiftComponent:GetAllGiftIDByType() gift_type = , gift_id =             g   h   h   h   h   h   i   i   i   j   j   j   j   j   k   k   k   k   k   k   k   h   h   n   o      self       
gift_type       tb      (for generator)      (for state)      (for control)      index      value         _ENV u   x    	   � @  � ����@@�@    ���  �  & �    GetAllGiftIDByType                       	   v   v   v   w   w   w   w   w   x      self    	   
gift_type    	   list   	        |   �       K   � @ �@@ ǀ�� ���A@ ����  � ��A�A    ��AA�A �A@�$� "B   �B BB@� ��$B���  *��f  & � 
   ipairsm_component_infom_campaign_gift_listm_is_usm_us_midas_idm_midas_idstringisnulloremptytableinsert            }   ~   ~   ~   ~   ~                           �   �   �   �   �   �   �   �   �   �   �   ~   ~   �   �      self       tb      (for generator)      (for state)      (for control)      index      value      midasId         _ENV �   �       � @ �@@ ǀ�� ����@@� ��A@ ���  � ��AA�A    �ǁA� ��  *A�& �    ipairsm_component_infom_campaign_gift_list
m_gift_idm_is_usm_us_midas_idm_midas_id            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       gift_id       (for generator)      (for state)      (for control)      index      value         _ENV �   �    
   L @ d� �@@ ��@��@ �� � A@� �@�& �    GetAllGiftMidasIdGameGlobal
GetModule
PayModuleGetLocalPrice         
   �   �   �   �   �   �   �   �   �   �      self    
   tb   
   mPay   
      _ENV �   �       � @  � ����@@ ǀ��@ � �$� FAA G���� �  dA FAB � d���BA ��A��   A� ���B�i�  ��G� f & �    GetGiftMidasIdByIdGameGlobal
GetModule
PayModuleGetGoodPriceListLogdebug/BuyGiftComponent:GetGiftPriceById() midasId =  goodPriceList = pairsk : v :             �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   
   self       gift_id       midasId      mPay      goodPriceList	      (for generator)      (for state)      (for control)      k      v         _ENV �   �       � @  � ����   � ��@@�@    ���  �  & �    GetGiftPriceByIdprice           �   �   �   �   �   �   �   �   �   �   �      self       gift_id       
giftPrice           �   �       � @  � ����   � ��@@Ҁ��@    ���  �  & �    GetGiftPriceByIdmicroprice@B                        �   �   �   �   �   �   �   �   �   �   �   �      self       gift_id       
giftPrice           �   �       � @ �@@ ǀ��  ���@@�@ ��A� ��  *��   �  & �    ipairsm_component_infom_campaign_gift_list
m_gift_idm_extra_award            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       gift_id       (for generator)      (for state)      (for control)      index   
   value   
      _ENV �   �       � @  � ����@@ ǀ��@��@    ���  �   � �A"A    ��  @�� f�& �    GetGoodCfgByIdm_component_infom_buy_gift_map        SaleNum           �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       gift_id       gift      	buyCount	      
saleCount           �   �       � @ �� �@@ ǀ��  
���
A �� A�& & �    GetComponentCfgIdCfgcfg_component_buy_giftComponentIDGiftID                   �   �   �   �   �   �   �   �   �   �   �      self       gift_id       componentCfgId      gifts         _ENV �   �       � @  � ����   �   @�A  G�@\��A  (���  G�@G
B�G�@G
B��FA GB���� dB�'���  & �    GetGiftCfgById       	ShowIcon	ShowDesctableinsert            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   	   self       gift_id       gift      tb      (for index)
      (for limit)
      (for step)
      i      info         _ENV �   �       � @ �@@�@ �  & �    Cfgcfg_shop_common_goods            �   �   �   �   �      self       gift_id          _ENV �      
   @ �� $��GA@�� ���@  � @��A � ��A  � @ �A & �    GetGoodCfgById	SaleTypex      BuyGift_DirectAMidasBuyGift_RoleAsset                                 
  
  
  
       self       gift_id       	gift_num       
gift_type       good      	saleType                   � @ �@�䀀 ̀�l  �  �@ & �    GameGlobalTaskManager
StartTask                 F @ L@� d� � � ��@   @� � ���� ��@ � �䀀 �@�F�A G��� �� �@�& �    AsyncRequestResNewHandleApplyBuyGiftGameGlobalEventDispatcher	DispatchGameEventTypeActivityNormalBuyResult                                                        TT       res      ret
         _ENVselfgift_id	gift_num                      self       gift_id       	gift_num          _ENV   V   �   � @ @� 䀀A@ �� $��F�@ L���� d���� ��A��A�  �A���A ��� �A  � ���A ��� �  @��B �AB� ���B  � �����B ��B @� �A��  ����B ��� F�C G��BD��Dd �A  ���F�C G��BD��Dd �A  �E @� 䁀B���$B� �_�E����E   �����C ��  � E �� $��F�C G�� d� �B�  �B���� �@�C�B�����B  � �����B ��B @� �A��  ����B ��� F�C G��BD��Dd �A  ���F�C G��BD��Dd �A  �E @� 䁀B���$B��AF ��F���� �  ����F �G�AG �� ��G�G HC  �B �� �A ��B ��H�	 �A & � ��F �AI��� ��I,  @  �A & � '   GetGiftMidasIdByIdGetGiftPriceForBuyByIdUIActivityPayItemNewSetMidasId	SetPriceIsPcIsUnityEditorCampaignGiftTypeECGT_SENIOR_SKINGetGiftCfgByIdLogdebugBuyGift_DirectAMidas gift_id: #BuyGift_DirectAMidas giftCfg.Name:StringTableGetName       SetNameGetGiftPriceForShowByIdSetPriceWithCurrencySymbol GetGiftTypeKey&str_activity_battlepass_n5_main_titlestringisnulloremptyGameGlobalGetUIModuleShopModuleReportPayStepPayStepClickPurchaseButton��������midasId_is_emptyfatal ### [Pay]midasId can't be emptyTaskManager
StartTask         M  S   	   F @ L@� d� � � ��@   @� � ��@�� � ��� ��  �@� � �   � �� � ̀�E �@�& �    AsyncRequestResNewHandleApplyBuyGiftGetIdGetBuyCountGetSucc
CanCharge             N  N  N  O  O  O  O  O  O  O  O  O  O  O  P  P  P  P  Q  Q  Q  Q  S     TT       res      ret         _ENVselfitem�            "  "  "  #  #  #  #  $  $  $  %  %  %  &  &  &  &  &  &  &  &  '  '  '  '  )  )  )  *  *  *  *  *  +  +  ,  ,  ,  ,  ,  ,  ,  ,  ,  -  -  -  -  -  -  -  /  /  /  0  0  0  0  1  1  3  3  3  4  4  4  4  5  5  5  6  6  6  6  7  7  7  8  8  8  8  8  8  ;  ;  ;  <  <  <  <  <  =  =  >  >  >  >  >  >  >  >  >  ?  ?  ?  ?  ?  ?  ?  A  A  A  B  B  B  E  E  E  E  E  E  F  F  F  F  F  F  F  F  F  F  F  G  G  G  G  I  L  L  L  L  S  U  L  V     self    �   gift_id    �   
gift_type    �   midasId   �   price   �   item
   �   giftCfg   <   
showPrice9   <   typeKeyB   U   	typeNameF   U   
showPriceI   U   	giftNameM   U   giftCfgY   v   
showPrices   v      _ENV X  [      � @ �@@��� ��@�  �@�� @ � A��� �@A�A @  �� �@�& �    GameGlobalUIStateManagerLockBuyGiftComponent:CanChargeTaskManager
StartTaskCanChargeCoro            Y  Y  Y  Y  Y  Y  Z  Z  Z  Z  Z  Z  Z  Z  [     self       item          _ENV ]  k   
'   � @ �@��@ � @ A@F�@ $� L�d� b  ��LAA�� d��b  ��F@ G��d�� L��� dA���F@ GA�d�� L����B    @ dA�F@ G��d�� L��A dA�& �    GameGlobal
GetModuleRoleModule
PayModuleIsJapanZoneNeedSelectAgeUIStateManagerShowDialogUISetAgeConfirmControllerTaskManager
StartTaskBuyGoodsTaskUnLockBuyGiftComponent:CanCharge         '   _  _  _  _  a  a  a  a  d  d  d  d  d  d  d  d  d  e  e  e  e  e  e  e  g  g  g  g  g  g  g  g  j  j  j  j  j  j  k     self    '   TT    '   item    '   roleModule   '   
payModule   '      _ENV m  �   s   � @ �@��@ � �@ $�� "A  ��A $�� "A  � �AA $�� "  ���A �AFB GA�@������ ��B� C$ $�  �AC ��C�� D�A��AD�� �A   ��DƁD ����@��E �AE�� �E FFBF G���� �G �B�� � �A   ��E �AE�� �E FFBF G���� �G �B�� � �A  �
�bA   ��AC ��C� �A ���DƁD �A����������BC �CA	 � �B	  �$B������ $B  ��A �AFB G��@���� $A���AJ $�� "  � ��� $A�& � *   GameGlobal
GetModule
PayModule
IsAndroidIsUnityEditorIsPcH3DGCloudLuaHelperMsdkStatusMSDKStatus
MS_InlandSendBuyGoodsRequestGetMidasIdGetBuyCountLogdebug3BuyGiftComponent:BuyGoodsTask IsAndroid start res 	m_resultGetSuccPayErrorCodePAY_ERROR_NOT_USE_MIDASPopupManagerAlertUICommonMessageBoxPopupPriorityNormalPopupMsgBoxTypeOkStringTableGet$str_pay_direct_buy_need_open_switch"str_pay_direct_buy_fail_try_later3BuyGiftComponent:BuyGoodsTask failed no replyEvent	PAY_SUCCtokenurl_params-BuyGiftComponent:BuyGoodsTask success token  url BuyCampaignGoodsByUrlMS_InternationalBuyCampaignGoodsIsIos         s   o  o  o  o  q  q  q  q  q  q  q  q  q  q  q  q  r  r  r  r  r  r  s  s  s  s  s  s  s  t  t  t  t  t  v  v  v  v  w  w  w  w  w  x  x  y  z  z  {  {  |  }  }  }  }  x  ~  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    s   TT    s   item    s   mPay   s   res   `   replyEvent   `   tokenT   `   urlU   `      _ENV^                                 	                                           #   *   #   1   I   1   M   X   M   [   _   [   f   o   f   u   x   u   |   �   |   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �     �           V    X  [  X  ]  k  ]  m  �  m  �         _ENV