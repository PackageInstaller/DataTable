LuaS 

xV           (w@Y@../PublishResources/lua/product/components/ui/activity/n29/lottery/ui_n29_shop_item.lua         "    @ A@  @ $@@@  @@ l   
@@@ l@  
@ @A l  
@ @A lÀ  
@@A l  
@ @A l@ 
@@A l 
@ @A lÀ 
@@A l  
@ &     _classUIN29ShopItemUICustomWidgetConstructorOnShowUIN29ShopItemOnHide	InitDataFillUi	ShowHide	PlayAnimPlayOutAnim
BgOnClick    	       
       K  @ ÁÀ   ¤J@ Á Á ¤J
@ &     sizebigVector2i      X      small+      D                                                   	   
      self          _ENV    5    Z   @@   FÁ@ GÁ¤ 
 A ¤ 
@A ÀA  ¤@@B  AÁ ¤ 
 A  ¤
 @B  AA ¤ 
@B  AÁ ¤ 
@B  AA ¤ 
@B  AÁ ¤ 
@B  A ¤ 
 A  ¤
A Á ¤
@B  A ¤ 
 @B  AA ¤ 
@B  A ¤ 
 @B  AÁ ¤ 
A A ¤
 @B  A ¤ 
 @B  AÁ ¤ 
&      atlas	GetAssetUIN29Lottery.spriteatlas	LoadTypeSpriteAtlasgoGetGameObject
SetActiveanimGetUIComponent
AnimationUIN29ShopItembigbgBigImageimgIconBigRawImageLoadertxtCountItemBigUILocalizationTexttxtCountAwardBigimgBigFlag
bigMaskGobigMasksmallbgSmallimgIconSmalltxtCountItemSmalltxtCountAwardSmallsmallMaskGo
smallMaskimgIconBigShadowimgIconSmallShadow         Z                                                                                                                                                     !   !   !   !   $   $   $   $   &   &   &   &   &   (   (   (   (   (   *   *   *   *   *   ,   ,   ,   ,   ,   -   -   -   -   0   0   0   0   0   2   2   2   2   2   5      self    Z   	uiParams    Z      _ENV 6   9       G @ L@À d@ G@ L@À d@ &     imgIconBigDestoryLastImageimgIconSmall           7   7   7   8   8   8   9      self            <   D       
@ 
À@ Á@
 @ AA
 @ ÁA
 
 AB $A &  
   _data_unlock_itemId
m_item_id_itemCountm_lottery_limit_count_itemRestCountm_lottery_count_itemInfoCallbackFillUi           =   >   ?   ?   ?   @   @   @   A   A   A   B   C   C   D      self       data       itemInfoCallback       unlock            E       b   F @ G@À @ G b   ÀÀ Ç A `À  Ã@  Ã  A ÁAA  ]  ÇAB â    ÀA B"  ÀÂ GA  ÁB C A AÂC D $BBD D  $BD ÂD $BE ÂD $BBE E$BÂE E $BF D$BB GA  Á C A AÂC D  $BBD D $BÂF ÂD $BG ÂD $BBG E$BG E $BÂG D$B&      Cfg	cfg_item_itemIdIcon_itemRestCount        _datam_countx_unlockm_is_big_reward<color=#fffae7>	</color><color=#b9b2aa>/_itemCountbig
SetActivesmallimgIconBig
LoadImageimgIconBigShadowtxtCountItemBigSetTexttxtCountAwardBig
bigMaskGo<color=#9a7c5f><color=#292624>/imgIconSmallimgIconSmallShadowtxtCountItemSmalltxtCountAwardSmallsmallMaskGo         b   F   F   F   F   G   G   H   I   I   I   I   I   K   K   N   N   N   O   Q   Q   Q   Q   f   f   f   f   g   g   g   g   g   g   g   j   j   j   j   k   k   k   k   l   l   l   l   m   m   m   m   n   n   n   n   o   o   o   o   p   p   p   p   p   v   v   v   v   v   v   v   y   y   y   y   z   z   z   z   {   {   {   {   |   |   |   |   }   }   }   }   ~   ~   ~   ~                     self    b   itemCfg   b   res   a   hasRest   a   
itemCount   a   showNumberTex   a   showTimesTex   a   canGet   a      _ENV            @ @@  ¤@&     go
SetActive                             self       isShow                       @ ,  @  ¤@ &     
StartTask                *   E    @ @F@À    Å   Î ÀÏÀd@FÀ@L Á Ã  d@A@ A]   ÀA  ¤@ B@B¢    BÀB ¤@À BÀBA ¤@@À À    ¤@  ÀC  ¤@&            YIELD<       go
SetActiveUIN29ShopItemPlayAnim_itemIdLock_datam_is_big_rewardanimPlayuieff_UIN29ShopItem_biguieff_UIN29ShopItem_smallc      UnLock          *                                                                                                                                    TT    *   key   *      idx_ENVself                     self       idx          _ENV     ¢       G @ L@À Á  d@&     animPlayuieff_UIN29ShopItem_out           ¡   ¡   ¡   ¡   ¢      self            ¤   ¨    
    @ ¢   @ @ Ç@@ ÇÀÁÀ A¤@&     _itemInfoCallback_data
m_item_id
transform	position        
   ¥   ¥   ¥   ¦   ¦   ¦   ¦   ¦   ¦   ¨      self    
   go    
       "                        
         5      6   9   6   <   D   <   E      E                         ¢       ¤   ¨   ¤   ¨          _ENV