LuaS 

xV           (w@p@../PublishResources/lua/product/components/ui/activity/return_system/common/ui_activity_returnsystem_board.lua         1    @ A@  @ $@@@  @@ l   
@@@ l@  
@ @@ l  
@@@ lÀ  
@ @@ l  
@@@ l@ 
@ @@ l 
@@@ lÀ 
@ @@ l  
@@@ l@ 
@ @@ l 
@@@ lÀ 
@ @@ l  
@@@ l@ 
@ &     _classUIActivityReturnSystemBoardUICustomWidget_GetComponentsOnShowOnHideSetData_SetBg
_SetState
_SetPress
_SetLimit	_SetFree_SetBuyBtn	_SetTextOnBuyResultBuyBtnOnClick_SetPressEvent           :    	h   K    Ì@@ A  äA@ Á  $LA@ Á d«@  Ë  A@ A $LA@ Á dA@ Â ¤ë@  k@ 
@ K     Ì@@ AA ä «@  Ë   A@  $ë@  k@ 
@ K     Ì@@ A ä «@  k@ 
@K     Ì@@ A ä «@  Ë   A@ Á $ë@  k@ 
@K  @D  AÁ ¤ Ì@D A  ä AD  ÁA $ k@  
@ K  @D  AÁ ¤ Ì@D A  ä AD  ÁA $ k@  
@ L@D Á Á d 
@ L@D Á@  d 
@ L@@ Á  d
@&  !   
_stateObjGetGameObject
bg_normalbg_limit_normaltitle_gift_normalbg_soldoutbg_limit_soldouttitle_gift_soldout
_pressObjbg_click_normalbg_click_pressed
_limitObjlimit	_freeObjtitle_gift_freetitle_gift_cost_textGiftNameGetUIComponentUILocalizationTexttxtGiftName_freetxtGiftName_costtxtGiftName_soldout_textGiftPricetxtGiftPrice_freetxtGiftPrice_costtxtGiftPrice_soldout
_txtLimit	txtLimit_buyBtnButtonbuyBtn_redred        h         
   
   
                                                                                                                              "   "   #   #   #   #   #   $   $   $   $   %   %   (   )   )   )   )   *   *   *   *   +   +   +   +   ,   ,   -   .   .   .   .   /   /   /   /   0   0   0   0   1   1   5   5   5   5   5   7   7   7   7   7   9   9   9   9   :      self    h        <   A       
@@L@ d@ LÀ@ d@ &     _isOpen_GetComponents_SetPressEvent           =   >   >   @   @   A      self            C   E       
@@&     _isOpen            D   E      self            H   Y       
@ 

À 
 GA@ LÁÇ@ dÁ

@LÁA dA LB dA LAB dA LB dA LÁB dA LC dA LAC dA &     
_campaign_component_giftId
_callback
_buyCount_saleCountGetGiftBuyCount_SetBg
_SetState
_SetPress
_SetLimit	_SetFree_SetBuyBtn	_SetText           I   K   L   M   O   O   O   O   O   O   Q   Q   S   S   T   T   U   U   V   V   W   W   X   X   Y      self       	campaign       
component       gift_id       	callback            [   y    
%   KÀ  J@@JÀ@J@AÀ  AÀA BËÀ  Ê@BÊBÊÀBC A Á $ LÁCÇD ÇÁ dALC ÁA B d ÁÃD ¤AC B A ¤ ÌÁCGD GBäA&          shop_libao_back_1000     shop_libao_back_1001     shop_libao_back_1002shop_libao_back_1000_selshop_libao_back_1001_selshop_libao_back_1002_selshop_libao_back_1000_sodshop_libao_back_1001_sodshop_libao_back_1002_sodGetUIComponentRawImageLoaderbg_click_normal
LoadImage_giftIdbg_click_pressedbg_soldout        %   \   ]   ^   _   b   c   d   e   h   i   j   k   o   o   o   o   p   p   p   p   s   s   s   s   t   t   t   t   w   w   w   w   x   x   x   x   y      self    %   	normalBg   %   pressBg   %   
soldoutBg   %   bg_click_normal   %   bg_click_pressed   %   bg_soldout    %        {          G@@ @    AÀ  b@    A  
@ F@A GÁ ÀA Ç @ d@&     _state
_buyCount_saleCount              UIWidgetHelperSetObjGroupShow
_stateObj            |   |   |   |   |   |   |   |   |   ~   ~   ~   ~   ~         self          _ENV           F @ G@À @ ÁÀ  d@&     UIWidgetHelperSetObjGroupShow
_pressObj                                        self          _ENV        $   G@@ @ À@_  A  b@    A@ 
@ FA GÀÁ  B Ç @ d@F@B GÂ À Ç@@ C Î A@ d @B BÆ@C ÇÃÁ @ ä ¤  Ç D Ì@Ä@ ä@&     _limit_saleCountSpecialNumMysteryGoodsUnlimitedNum              UIWidgetHelperSetObjGroupShow
_limitObjstringformat %s/%s
_buyCountStringTableGet#str_pay_purchase_limitation_normal
_txtLimitSetText         $                                                                                                                  self    $   n2m   $   	strLimit   $      _ENV           G @ L@À Ç@ dÀÀ @A Á â@    ÁÀ 
À Æ B Ç@ÂB GA ä@ÇÀB C   @ _@A  Ã@  Ã  AC C$A&     _componentGetGoodCfgById_giftId	SaleType_free                      UIWidgetHelperSetObjGroupShow	_freeObj
_buyCount_saleCount_red
SetActive                                                                                                         self       good      	saleType      red         _ENV        	   G @ @ ÇÀ@ `À   @    J&     _buyBtninteractable
_buyCount_saleCount        	                                 self    	           ®    ,   G @ L@À Ç@ dÀÀ  AÆ@A A ä @ÂÁB BBÀ ¤ $B  é  jÁýÇ @ ÌÂG@ ä@ ÁB@ $GC@Ã FB GAÂ d À FAA ÁC d ÂÁ ¤Bi  êþ&     _componentGetGiftCfgById_giftIdName       pairs_textGiftNameSetTextStringTableGetGetGiftPriceForShowByIdGetGoodCfgById	SaleType        str_pay_recharge_label_3_textGiftPrice         ,                                     ¡   ¡   ¡   ¡   ¡   ¡           ¤   ¤   ¤   ¤   ¦   ¦   ¦   ¦   §   §   §   ¨   ¨   ¨   ¨   ¨   «   «   «   «   ¬   ¬   ¬   «   «   ®      self    ,   gift   ,   name   ,   (for generator)	      (for state)	      (for control)	      _
      v
      price   ,   good   ,   (for generator)%   +   (for state)%   +   (for control)%   +   _&   )   v&   )      _ENV °   ¸    	    À ¤ ¢    @@ @Á@ ¤Æ A Ç@Á  ä@ A ÀAÆ B ¤ Ì@BGÂ ÁB CÇAC   ä@ &     GetSucc_componentGetGiftExtraAwardById_giftIdUIActivityHelperShowUIGetRewardsGameGlobal
GetModuleCampaignModuleCheckErrorCode	m_result
_campaign_id
_callback            ±   ±   ±   ±   ²   ²   ²   ²   ³   ³   ³   ³   ³   µ   µ   µ   µ   ¶   ¶   ¶   ¶   ¶   ¶   ¶   ¸      self       res       rewards      campaignModule         _ENV »   Ê    
   
@@@ À@¢   À A @AÁ ¤@ ÀA  GAB B ÇÁB @ l  ¤@ &     	_giftNum       _buyBtninteractableLoginfo*UIActivityReturnSystemBoard:BuyBtnOnClickShowDialogUIActivityGiftPackDetail
_campaign_component_giftId         Å   Ç       E   L À À   d@&     OnBuyResult           Æ   Æ   Æ   Æ   Ç      res          self   ¼   ½   ½   ½   ½   ¾   ¾   ¾   ¾   ¿   À   Á   Â   Ã   Ä   Ç   ¿   Ê      self       go          _ENV Ì   Ý       L @ Á@  d@ Á@ A@ $ FAA GÁ¬  ¤@@ Á@ A@ $ FAA GÁÁ¬A  ¤@&     GetGameObjectbuyBtnAddUICustomEventListenerUICustomUIEventListenerGetUIEventPressRelease         Ò   Ô       F @ G@À À ÁÀ  d@&     UIWidgetHelperSetObjGroupShow
_pressObj                    Ó   Ó   Ó   Ó   Ó   Ô      go          _ENVself Ù   Û       F @ G@À À ÁÀ  d@&     UIWidgetHelperSetObjGroupShow
_pressObj                    Ú   Ú   Ú   Ú   Ú   Û      go          _ENVself   Í   Í   Í   Ï   Ð   Ð   Ð   Ð   Ñ   Ñ   Ô   Ï   Ö   ×   ×   ×   ×   Ø   Ø   Û   Ö   Ý      self       obj         _ENV1                        :      <   A   <   C   E   C   H   Y   H   [   y   [   {      {                                          ®      °   ¸   °   »   Ê   »   Ì   Ý   Ì   Ý          _ENV