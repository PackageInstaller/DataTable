LuaS 

xV           (w@@E:/depot_matchsrpg/matchsrpg/b/1140/client/Assets/../PublishResources/lua/product/components/ui/activity/n24/shop/ui_n24_shop_item.lua             @ A@  @ $@@@  @@ l   
@@@ l@  
@ @A l  
@ @A lÀ  
@@A l  
@ @A l@ 
@@A l 
@ @A lÀ 
@&     _classUIN24ShopItemUICustomWidgetConstructorOnShowUIN24ShopItemOnHide	InitDataFillUi	ShowHide	PlayAnim
BgOnClick           
       K  @ ÁÀ   ¤J@ Á Á ¤J
@ &     sizebigVector2a      r      small      2                                                   	   
      self          _ENV    +    M   @@   FÁ@ GÁ¤ 
 A ¤ 
@A ÀA  ¤@@B  AÁ ¤ 
 @B A AÁ ¤ 
 A  ¤
 @B  AÁ ¤ 
@B  AA ¤ 
@B  AÁ ¤ 
@B  AA ¤ 
@B  A ¤ 
 A Á ¤
@B  A ¤ 
 @B  AA ¤ 
@B  A ¤ 
 @B  AÁ ¤ 
&     atlas	GetAssetUIN24.spriteatlas	LoadTypeSpriteAtlasgoGetGameObject
SetActiveanimGetUIComponent
AnimationUIN24ShopItemloeLayoutElementbigbgBigImageimgIconBigRawImageLoadertxtCountItemBigUILocalizationTexttxtCountAwardBigimgBigFlagsmallbgSmallimgIconSmalltxtCountItemSmalltxtCountAwardSmall         M                                                                                                                                                                    "   "   "   "   $   $   $   $   $   &   &   &   &   &   (   (   (   (   (   *   *   *   *   *   +      self    M   	uiParams    M      _ENV ,   /       G @ L@À d@ G@ L@À d@ &     imgIconBigDestoryLastImageimgIconSmall           -   -   -   .   .   .   /      self            2   :       
@ 
À@ Á@
 @ AA
 @ ÁA
 
 AB $A &  
   _data_unlock_itemId
m_item_id_itemCountm_lottery_limit_count_itemRestCountm_lottery_count_itemInfoCallbackFillUi           3   4   5   5   5   6   6   6   7   7   7   8   9   9   :      self       data       itemInfoCallback       unlock            ;   r    ®   F @ G@À @ G b   )ÀÀ Ç A `À  Ã@  Ã  A ÁAD Á   Ý BB ¢  Àâ   @B ÁB ÀC Ý ÇA Ã GD C A BD¢    cA   AÁ A ÀB ÁB C AC  ¤ Â ÀC ÝA   ÇA Ã GD C @B ÇA  GD C A BD¢   Â cA   A AB A BD¢  G ÇH ÇBÈÇÂÂG ÇH ÇBÈÇÂÈÂBH I ¤BBI I  ¤BI ÇJ ÌBÊ@äÂJ ÇJ ÌBÊ@äÂÂJ K  ¤BÂJ BK  ¤BK ÂK ¤BL ÂK  ¤BÀ	G ÇH ÇBÉÇÂÂG ÇH ÇBÉÇÂÈÂBH I  ¤BBI I ¤BBL ÇJ ÌBÊ@äÂL K  ¤BL BK  ¤BÂL ÂK ¤BM ÂK  ¤B&  5   Cfg	cfg_item_itemIdIcon_itemRestCount        _datam_countx_unlockColorwhite<color=#f0ede9>	</color><color=#f7e2c4>/_itemCountm_is_big_rewardn24_shop_di2n24_shop_di4n24_shop_icon1             à?<color=#a1a1a1><color=#606060><color=#9a9a9a></color><color=#606060>/n24_shop_di3n24_shop_di5n24_shop_icon2loepreferredWidthsizebigpreferredHeighty
SetActivesmallbgBigspriteatlas
GetSpriteimgBigFlagimgIconBig
LoadImage	SetColortxtCountItemBigSetTexttxtCountAwardBigbgSmallimgIconSmalltxtCountItemSmalltxtCountAwardSmall         ®   <   <   <   <   =   =   >   ?   ?   ?   ?   ?   A   A   B   D   D   D   E   G   G   G   G   G   H   H   I   I   I   I   J   J   J   J   J   J   K   K   K   K   K   K   K   K   L   L   N   N   N   N   N   N   N   O   O   O   O   P   P   P   Q   Q   Q   Q   Q   Q   Q   T   U   U   U   U   U   W   W   W   W   W   W   W   W   X   [   [   [   [   \   \   \   \   \   ]   ]   ]   ]   ]   ^   ^   ^   ^   _   _   _   _   `   `   `   `   `   `   a   a   a   a   a   a   b   b   b   b   c   c   c   c   d   d   d   d   e   e   e   e   e   g   g   g   g   g   h   h   h   h   h   i   i   i   i   j   j   j   j   k   k   k   k   k   k   l   l   l   l   m   m   m   m   n   n   n   n   o   o   o   o   r   
   self    ®   itemCfg   ®   res   ­   hasRest   ­   
itemCount   ­   	bgSprite   ­   imgIconColor   ­   showNumberTex   ­   showTimesTex   ­   starSprite   ­      _ENV t   v        @ @@  ¤@&     go
SetActive           u   u   u   u   v      self       isShow            x           @ ,  @  ¤@ &     
StartTask         z       *   E    @ @F@À    Å   Î ÀÏÀd@FÀ@L Á Ã  d@A@ A]   ÀA  ¤@ B@B¢    BÀB ¤@À BÀBA ¤@@À À    ¤@  ÀC  ¤@&            YIELD<       go
SetActiveUIN24ShopItemPlayAnim_itemIdLock_datam_is_big_rewardanimPlayuieffanim_UIN24ShopItem_biguieffanim_UIN24ShopItem_smallc      UnLock          *   {   {   {   |   |   |   |   |   |   ~   ~   ~   ~                                                                                             TT    *   key   *      idx_ENVself   y         y         self       idx          _ENV        
    @ ¢   @ @ Ç@@ ÇÀÁÀ A¤@&     _itemInfoCallback_data
m_item_id
transform	position        
                                    self    
   go    
                               
         +      ,   /   ,   2   :   2   ;   r   ;   t   v   t   x      x                      _ENV