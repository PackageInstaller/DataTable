LuaS 

xV           (w@^@../PublishResources/lua/product/components/ui/activity/n39/exchange/ui_n39_exchange_item.lua             @ A@  @ $@@@  @@ l   
@@@ l@  
@ @@ l  
@@@ lÀ  
@ @@ l  
@@@ l@ 
@ @@ l 
@@@ lÀ 
@ &     _classUIN39ExchangeItemUICustomWidgetSetData	PlayAnimOnHidePlayAnimationInSequencetmp_SetRemainCount_SetReward	_SetCostBtnOnClick                  
@ 

À 
 
@AA ¤A A ¤A ÁA ¤A B ¤A &  	   _data_component_tipsCallback	_animIdx
_planAnim_SetRemainCount_SetReward	_SetCost	PlayAnim                 	   
                                    self       data       
component       tipsCallback       animIdx       	planAnim               %    (   L @ Á@    d À@ ¢@  @ J@A&   @  AÁ ¤ Ç B Î@ÁÏ@ÂÂ ÁB$A @C "  @AC C$ ÁCC $AJBAC C$ Dì  $ 
 &     GetUIComponentCanvasGroup_root
_planAnimalpha       
Animation_anim	_animIdx<               Play_animTimerGameGlobalTimerCancelEvent	AddEvent         !   #            @ $@ &     Play          "   "   "   #          anim(                                                                                                 !   !   !   !   !   #   !   #   %      self    (   alpha   (   anim   (   
yieldTime   (      _ENV &   *    
   G @ b   @F@@ GÀ d LÀÀ Ç @ d@&     _animTimerGameGlobalTimerCancelEvent         
   '   '   '   (   (   (   (   (   (   *      self    
      _ENV +   3         K  JÀJÁ
AK  JÁJÁÁ
AG GAÀ Á@ÎÂ ÏAÂÍÁB ÂB@   ÁB  @ Ä   $B&     Big	animNameuieff_UIN39Exchange_ItemBig_in	duration      Small!uieff_UIN39Exchange_ItemSmall_inM             B       UIWidgetHelperPlayAnimationInSequence_anim_root            ,   -   -   -   -   .   .   .   .   0   0   0   0   1   1   1   2   2   2   2   2   2   2   2   2   2   2   3      self       index       type       wait       tb	      	animName      	duration      delay         _ENV 5   B    
-   G @ G@À À   C@  C   @ À@Æ A Ç@Á ä   Ý A AAAÁ $ b   @ cA  @ b   @  BÀÿAB BÀ  Â @¤A C B ¤C# À _ B  B   ¤A&     _datam_exchange_limit_countÿÿÿÿÿÿÿÿm_can_exchange_countStringTableGetstr_n39_item_remain_titlestr_n31_item_unlimit_count        UIWidgetHelperSetLocalizationTextRemainCountGetGameObject	_soldout
SetActive         -   6   6   6   6   6   6   7   7   9   9   9   9   9   9   :   :   :   :   ;   ;   ;   ;   ;   <   <   <   <   ?   ?   ?   ?   ?   ?   A   A   A   A   A   A   A   A   A   A   A   B      self    -   isLimit   -   count   -   
limitText   -   unlimitText   -   text   -      _ENV D   f    [   G @ @À @Ç@À ÇÀÀA A Á $ FB A ÁA d
AGÂ ÁB  ¤AC ¤AÁB  ¤AC¤Ab   
ÁC D ¢   ÇAâ  @ÆAD ÇÄ   A AäA ÇÁDâ  @ÆE ÇAÅÂDA äÂE GÆ$ FÂE BÆd B À  ¤
 ÆAD ÇÆ   @  äA @AD FÀ    AÂ ¤A AD GÀ    AB ¤A AD GÀ  Â A ]¤A &  !   _data	m_rewardassetidcountGetUIComponentRectTransformSpecialIcon
sizeDeltaVector2      m_is_specialGetGameObjectSpecialIconGo
SetActiveRewardIconGoCfg+cfg_activity_shop_special_item_icon_clientUIWidgetHelperSetRawImageSizeInBigCellstringsplit|	tonumber              SetItemIconRewardIconSetItemTextTitleSetLocalizationTextRewardCountx         [   E   F   F   G   G   I   I   I   I   J   J   J   J   J   L   M   M   M   M   M   M   N   N   N   N   N   N   O   O   P   P   P   Q   Q   Q   Q   Q   R   R   R   R   R   R   T   T   T   U   U   U   U   U   V   V   V   W   W   W   Y   Y   Y   Y   Y   Z   \   \   \   \   \   \   ]   _   _   _   _   _   _   d   d   d   d   d   d   e   e   e   e   e   e   e   e   f   
   self    [   data   [   itemId   [   count   [   	iconRect	   [   
isSpecial   [   cfg    E   b3   >   w6   >   h9   >      _ENV h   r        G @ G@À @ À@Æ A ¤ @A  ¤Ç @ ÇÁÁ A  À @ £A   ÆAB ÇÂ  FÂB d ä  C BC@   À$B &     _datam_cost_item_idGameGlobal
GetModuleItemModuleGetItemCountm_cost_count#fa5144#faf6fdUIActivityHelperGetColorText	tostringUIWidgetHelperSetLocalizationText
CostCount             i   i   j   j   j   j   j   j   j   l   l   m   n   o   o   o   o   o   p   p   p   p   p   p   p   q   q   q   q   q   q   r      self        costid       count	       need       	colorRed       colorNormal       color       str          _ENV t       	#    @ @@¤ Ì@GÁ@ A ä@ Ã   AA$ "A  A$ !ÀAÀFB GAÂB ÁBÁ ¤ dA  &  @C  Ã    
ÁC
ADLD ÇÁ   dA &     DCampaignShopItemBaseNewRefresh_data_component
IsUnLimitGetRemainCount        ToastManager
ShowToastStringTableGetstr_n31_item_has_empty_tips       &UICampaignShopConfirmNormalController &UICampaignShopConfirmDetailControllerShowDialog         #   v   v   v   w   w   w   w   x   y   y   y   y   z   z   {   {   |   |   |   |   |   |   |   }                                       self    #   go    #   uiItemData   #   useNormalDlg   #   remainCount      tb   #      _ENV                                 %      &   *   &   +   3   +   5   B   5   D   f   D   h   r   h   t      t             _ENV