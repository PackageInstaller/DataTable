LuaS 

xV           (w@u@../PublishResources/lua/product/components/ui/activity/cn17n46/fishing_game/ui_cn17_n46_fishing_game_order_item.lua         %    @ A@  @ $@@@  @@ l   
@@@ l@  
@ @@ l  
@@@ lΐ  
@ @@ l  
@@@ l@ 
@ @@ l 
@@@ lΐ 
@ @@ l  
@@@ l@ 
@ &     _classUICN17N46FishingGameOrderItemUICustomWidgetConstructorOnShowOnHide	CalBgPosInitWidgetSetData	_OnValuePlayAnimationEffectDoTweenResetWeight    
              
@@&     hadFinished                     self                       @ €@ @@ €@ &     InitWidget	CalBgPos           	   	   
   
         self       	uiParams                      G @ _@ΐ F@ Gΐΐ d L Α Η @ d@
@@&     taskid GameGlobalTaskManager	KillTask                                                self          _ENV           
@@G@ Gΐΐ G Α G@Α Α Η @ ΐ J   Ζ@B Β AΑ Γ δ ΐ Ζ@B Β A Γ δ ΐ
&     	_offsetY       _bggameObject
transformlocalPositiony_tmpPos        Vector3x       z                                                                                                     self       tmp         _ENV    *    +   L@@ Α  Α  d 
@ L@@ Α  A d 
@ LΐA Α  d
@ LB Αΐ C ACd 
@GΐC G Δ L@Δ Α d
@ LΐA Α  d
@LΐA Α d
@GΐD G Ζ G@Ζ 
@G@E LΖ Γ   d@&     _bgGetUIComponentImagebg	_fishImgfishImg_finishImgGetGameObject
finishImg_atlas	GetAssetUIN14FishingGame.spriteatlas	LoadTypeSpriteAtlas_animationviewgameObjectGetComponent
Animation
_effectGoeffect	_bgErrorbgError_effectOriPos
transformlocalPosition
SetActive         +                       !   !   !   !   !   "   "   "   "   #   #   #   #   #   #   $   $   $   $   $   $   %   %   %   %   &   &   &   &   '   '   '   '   (   (   (   (   *      self    +      _ENV +   8    3   @ €A 
@
 
ΐ
 
@ΑA BΛA  Κ€ B
ΑB €A C €A AC CΗA β  ΐΖD ΗAΔ AΒ  δ βA  @ ΖD ΗΕΑAE CΗA β  ΐΖD ΗAΔ AΒ  δ βA  @ ΖD ΗΕΑ&     ResetWeight_index_fishId_isCurrent
_isFinish_islastOrder	_fishCfgCfgcfg_fishing_fishID       InitWidget	_OnValue_bg
transformlocalRotationQuaternionEuler        ΄       	identity_finishImg         3   ,   ,   -   .   /   0   1   2   2   2   2   2   2   2   3   3   4   4   5   5   5   5   5   5   5   5   5   5   5   5   5   5   5   5   6   6   6   6   6   6   6   6   6   6   6   6   6   6   6   6   8      self    3   index    3   fishId    3   
isCurrent    3   	isFinish    3   islast    3      _ENV :   P    =   G @ @@ @ΐ@A _@A  A   €@A ΐ@A _ΐA  A   €@ B ΐ@ €@@B @BΗ C AC CΗ ΐΐC ’   @B Η@D ΜΔAΑ δΐ @@B Η@D ΜΔA δΐ @@ Η@D ΜΔGAE GΕδΐ ΐE ’@  ΐ  A ’     
ΐΑ&     _fishId	_fishImggameObject
SetActive
_isFinish _finishImg	_bgError_bg
transformlocalPosition_tmpPos_index       _isCurrentsprite_atlas
GetSpriten14_fish_huima2n14_fish_huima1	_fishCfgSpritehadFinished        =   ;   <   <   <   <   <   <   <   <   <   =   =   =   =   =   =   =   =   >   >   >   >   ?   ?   ?   ?   ?   ?   ?   ?   @   @   @   A   A   A   A   A   A   A   C   C   C   C   C   C   F   F   F   F   F   F   F   M   M   M   M   M   M   N   P      self    =   fishId   =        Q   p    	   Λ    AA    ΑΑ  λ@  @Α    LB μ     d 
@&  	   uieff_orderFinishuieff_orderRefreshuieff_errorfishuieff_orderRefresh_timeτ             °      taskid
StartTask         ^   m    &   E   L ΐ Α@  d@E   Lΐ d@ Fΐΐ    Α  d@F@A _Α  FΐA L Β Ε Ζΐ d@Fΐΐ    Ε  d@F@A _Α @E @Β  E   Lΐ d@ E   LΒ Α@  d@Α&     Lock,UICN17N46FishingGameOrderItem:PlayAnimationResetWeightYIELDd       taskid _animationPlay       UnLock          &   _   _   _   _   `   `   `   a   a   a   a   b   b   b   c   c   c   c   c   e   e   e   e   f   f   f   g   g   g   h   h   h   k   k   k   k   l   m      TT    &      self_ENV	aniNamesindexlast   R   T   U   V   X   X   Y   Z   Z   [   ]   m   o   ]   o   p      self       index       	needlast       	aniNames      last         _ENV r       !   K  @ A@Α  Β  €ΖA ΗAΑ G δAΖA ΗAΑ GΑ δAΗΑA ΜΒC δAΗΑA ΗAΒΜΒ@ δ ΜΑΒ@δΜΓl  δA&     mathrandom              tableinsert       
_effectGo
SetActive
transformDOPathSetEaseOnComplete         y              "       F ΐ G@ΐ Gΐ $@  ΐ ΐ@    $@ ΐ @@ F@Α 
@ &     
_effectGo
transform	position
SetActivelocalPosition_effectOriPos           z   z   z   {   {   {   {   {   |   |   |   |   }   }   }   }             	callbackself!   s   t   t   t   t   t   u   u   u   u   u   v   v   v   v   v   w   w   w   w   x   x   x   x   x   x   x   x   x   x      x         self    !   path    !   	duration    !   ease    !   	callback    !   usePath   !   next   !      _ENV        @   L @ Α@    d  A Α@ A AA  €JL @ Α@  Α d  A Α@ A AA  €JL @ Α@  A d  A Α@ A AA  €JGB GΐΒ @C CJ GB GΐΒ  D Α  A € JGB L@Δ Γ   d@GD GΐΒ @C CJ GD GΐΒ  D Α  A € J&     GetUIComponentImagebgcolorColor      π?       bgError        
finishImg_finishImg
transformlocalRotationQuaternion	identitylocalScaleVector3
SetActive	_fishImg         @                                                                                                                                                                                                      self    @      _ENV%                                                            *      +   8   +   :   P   :   Q   p   Q   r      r                      _ENV