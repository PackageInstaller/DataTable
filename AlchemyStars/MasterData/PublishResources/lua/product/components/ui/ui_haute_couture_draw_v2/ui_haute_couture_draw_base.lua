LuaS 

xV           (w@g@../PublishResources/lua/product/components/ui/ui_haute_couture_draw_v2/ui_haute_couture_draw_base.lua         @    @ A@  @ $@@@  @@ l   
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
@ @@ l 
@@@ lÀ 
@ @@ l  
@@@ l@ 
@ @@ l 
@&     _classUIHauteCoutureDrawBaseUICustomWidgetConstructorInitWidgetsBase
CloseSelf
GetCoinIdOnHideSetEndTimeCheckEndTime
LoadVideoRuleBtnOnClickHandleRuleBtnClickBuyBtnOnClickHandleBuyBtnClickDrawBtnOnClickHandleDrawBtnClickProbabilityBtnOnClickHandleProbabilityBtnClick
FgOnClickHandleFgBtnClickOnRootActiveChange           	       
@@LÀ@ Á  AA Ad 
@ &     controller _uiCommonAtlas	GetAssetUICommon.spriteatlas	LoadTypeSpriteAtlas                                 	      self          _ENV    8    Y   G@@ 
@ LÀ@ Á  d
@ LA ÁÀ  d 
@LA ÁÀ  d 
@LÀ@ Á  d
@LÀ@ Á d
@LÀ@ Á  d
@LÀ@ Á d
@LÀ@ Á  d
@LÀ@ Á d
@LA Á  A d 
@GÀE GÆ LÀÆ Ã   d@LA Á  A d ÀÇ  ¤
 G @H  LH d +A  C  ¤@ G  IH $ ¤  
ÀH @I,  ¤@A  A	 ¤ ÌÀGA
 ä
ÀÇÀI Ì@ÈlA  ä@&  )   controlleruiOwner_videoPlayerGetGameObjectVideoPlayer	_endtimeGetUIComponentUILocalizationTextendtime
_moneyNum	moneyNum_freeGofree_redGored_countParentnormalSingleGo_drawBtnOjdrawbtn_probalityBtnprobabilityBtn_buyBtnbuybtn
_prizeEff
Transform	PrizeEffgameObject
SetActiveUISelectObjectPathcurrencyMenu	_topTipsSpawnObjectUINewCurrencyMenuSetData
GetCoinId_seniorSkinItemGetItemByTypeIdSetAddCallBack	backBtns	_backBtnUINewCommonTopButton        ,   .           @¤@ &     BuyBtnOnClick           -   -   -   .      id       go          self 4   6            @ $@ &     
CloseSelf           5   5   5   6          selfY                                                                                                                                               !   !   !   !   !   $   $   $   $   &   &   &   &   (   (   (   (   (   (   (   (   *   *   *   *   *   *   +   +   .   +   1   1   1   1   2   2   2   2   3   3   6   3   8      self    Y   	currency6   Y   btnsP   Y        9   ;       G @ L@À d@ &     controllerCloseDialog           :   :   :   ;      self            ?   B       F @ G@À   d@ AÀ  f  &     Logerror5UIHauteCoutureDrawBase:GetCoinId should be inheritedÿÿÿÿÿÿÿÿ            @   @   @   @   A   A   B      self          _ENV D   E       &                 E      self            H   L        @ ¢   À  @ @@  ¤@&     	_endtimeSetText           I   I   I   J   J   J   J   L      self       timeStr            P   a    	0   G @ G@À GÀ À@  AÌ@A FA äÌÀÁä Ò Â¤   Æ@B ÇÂÁ ä C $A
À & ÀÆC ÌÀÃä Ì ÄN A ä AC _À ÀC AB BÁ  ¤$A  
À  & Ã  æ  &     controller_componentInfom_close_timemathfloor
GetModuleSvrTimeModuleGetServerTimeè      StringTableGetstr_activity_finishedSetEndTime	_timeStrHelperProxyGetInstanceFormatTime_3#ffd009str_senior_skin_draw_end_time         0   Q   Q   Q   R   R   R   R   R   R   R   R   R   S   S   T   T   T   T   U   U   U   V   W   W   W   Y   Y   Y   Y   Y   Y   Y   Z   Z   Z   [   [   [   [   [   [   [   \   ^   ^   `   `   a      self    0   time   0   now   0   timeStr      timeStr    -      _ENV d   q    2    @ @@Á    ¤@ A A AA ¤ 
À@ AÀA ¤@À@ @ @B BÀB¤ ¢    À@ Æ@C ÇÃä ÌÀÃA äÀ ÀÀ@ Æ@C ÇÃä ÌÀÃAA äÀ À@ D¤@ À@ ÇÀ@ ÇÀÄE Í À&     Logdebug[guide movie] move url _vpGetUIComponentVideoPlayergameObject
SetActiveurlcontrollerCtxData	IsReviewtargetCameraGameGlobalUIStateManagerGetControllerCamera%UIHauteCoutureDrawV2ReviewControllerUIHauteCoutureDrawV2ControllerPlayloopPointReached_LoopPointReached         2   f   f   f   f   f   g   g   g   g   g   h   h   h   h   h   i   i   j   j   j   j   j   j   k   k   k   k   k   k   k   k   k   m   m   m   m   m   m   m   m   o   o   o   p   p   p   p   p   p   q      self    2   url    2      _ENV t   v        @ ¤@ &     HandleRuleBtnClick           u   u   v      self       go            y          G @ G@À b   ÀF@ GÀÀ  A @AÁ ¤  d@  &  LÀA Á  @ ABd@ &  
   controller_closedToastManager
ShowToastStringTableGetstr_activity_finishedShowDialog$UIHauteCoutureDrawRulesV2ControllerCtxData            z   z   z   z   {   {   {   {   {   {   {   |                        self          _ENV            @ ¤@ &     HandleBuyBtnClick                       self       go                      G @ G@À b   ÀF@ GÀÀ  A @AÁ ¤  d@  &  FÀA G Â d L@Â Á @ ÁBG@ GÃ@ ACd@ &     controller_closedToastManager
ShowToastStringTableGetstr_activity_finishedGameGlobalUIStateManagerShowDialog%UIHauteCoutureDrawChargeV2ControllerhcType_buyComponetCtxData                                                                                          self          _ENV            @ ¤@ &     HandleDrawBtnClick                       self       go                      &                       self               ¡        @ ¤@ &     HandleProbabilityBtnClick                   ¡      self       go            £   ­    
   L @ Á@  @ Á@G@ GÁ@ AAAÇ@ ÇAÁÇÁÁ@ BG@ GBÂd@&  
   ShowDialog0UIHauteCoutureDrawDynamicProbablityV2ControllercontrollerhcType_prizes_componentInfo
shake_numshake_win_ids_componentIdCtxData           ¤   ¥   ¦   ¦   §   §   ¨   ¨   ¨   ©   ©   ©   ª   ª   «   ¬   ¤   ­      self            °   ²        @ ¤@ &     HandleFgBtnClick           ±   ±   ²      self       go            µ   ·       L @ Á@  @ Á@d@ &     ShowDialog$UIHauteCoutureDrawVideoV2ControllercontrollerCtxData           ¶   ¶   ¶   ¶   ¶   ·      self            »   Â       b     @ ¢   @  @ ¤@ &     _LoadVideo           ¼   ¼   ¾   ¾   ¾   ¿   ¿   Â      self       flag           @                        	         8      9   ;   9   ?   B   ?   D   E   D   H   L   H   P   a   P   d   q   d   t   v   t   y      y                                          ¡      £   ­   £   °   ²   °   µ   ·   µ   »   Â   »   Â          _ENV