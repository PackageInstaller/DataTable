LuaS 

xV           (w@l@../PublishResources/lua/product/components/ui/activity/cn15n44/VigorousReward/ui_vigorous_reward_enter.lua         .    @ A@  $@ @ AÀ   A $@À@  À@ l   
@À@ l@  
@ À@ l  
@À@ lÀ  
@ @B l  
@ @B l@ 
@@B l 
@ @B lÀ 
@@B l  
@ @B l@ 
@@B l 
@ @B lÀ 
@&     requireui_side_enter_item_base_classUIVigorousRewardEnterUISideEnterItem_BaseGetOpenCfgOnShowOnHide_CheckOpenUIVigorousRewardEnterGetSideEnterRawImageDoShow	_CalcNew_AttachEvents_DetachEvents	_CalcRed
_CheckNew	_Refresh                #    @ @@ $ A     Á  h@G ÁÀÇÁBÁA ÂA B@ $"   f BÁ@ÀÂA BB@ $"    f g ù&  
   Cfgcfg_quest_daily_extra_activity       
StartTimeEndTimeTimeTransform        UISideEnterItem_FixedTime
CheckOpenCheckServerTimeOpen         #            	   	   	   	   
                                                                              	      
   cfgs   #   (for index)   "   (for limit)   "   (for step)   "   i   !   cfg   !   st
   !   ed
   !   isOpen      isOpen   !      _ENV           &                       self                       L @ d@ &     _DetachEvents                        self            %   8    	&   @@ @¤ 
 À  Æ A Ç@ÁÇâ@  @A ÁAA $A   & AB BFÁB $ LCÀ d@ ¢  @ bA  A ACÁ Â ¤A  ¦  ¦ &     _cfgUIVigorousRewardEnterGetOpenCfg       Cfgcfg_module_unlockLogdebugdon't have function configGameGlobal
GetModuleRoleModuleCheckModuleUnlockfatal0###[UIVigorousRewardEnter] cfg is nil ! id -->                 &   &   &   &   &   )   *   *   *   +   +   ,   ,   ,   ,   -   -   /   /   /   /   0   0   0   2   2   2   2   2   3   3   3   3   3   4   4   7   7   8      self    &   TT    &   functionId   &   functionLockCfg   &   module   &   ispass   &      _ENV <   >       G @ G@À f  &     _cfgMainSideIcon           =   =   =   >      self            @   E       F @ G@À    Á  Á@ AGAA GÁ$ d@  F @ GÀÁ    Á  AB $ d@  LB d@ LÀB d@ &     UIWidgetHelperSetLocalizationTexttitleStringTableGet_cfgMainSideStrSetRawImagebgGetSideEnterRawImage_AttachEvents
_CheckNew            A   A   A   A   A   A   A   A   A   A   B   B   B   B   B   B   B   C   C   D   D   E      self          _ENV G   J       F @ G@À @ d LÀÀ d  A @AÁ   Ý Á ¤ÀA   ¢@    À ¦  &  	   GameGlobal
GetModuleRoleModule	GetPstIdLocalDBGetIntUIVigorousRewardEnter_New                           H   H   H   H   H   H   I   I   I   I   I   I   I   I   I   I   I   I   I   I   J      self       pstID         _ENV K   M       L @ Æ@@ ÇÀÁ@ d@ &     AttachEventGameEventTypeSideEnterTabRefresh
_CheckNew            L   L   L   L   L   M      self          _ENV O   Q       L @ Æ@@ ÇÀÁ@ d@ &     DetachEventGameEventTypeSideEnterTabRefresh
_CheckNew            P   P   P   P   P   Q      self          _ENV R   T       C   f  &                 S   S   T      self            U   X       F @ G@À    Ì@ ä Á@ $ A A d@ LA d@ &     UIWidgetHelperSetNewAndReds	_CalcNew	_CalcRed_newred	_Refresh            V   V   V   V   V   V   V   V   V   V   W   W   X      self          _ENV Z   c       L @ d b@  @@@ @ÆÀ@ Ç ÁA ä  ¤@  A À  ¤@ &     _CheckOpenToastManager
ShowToastStringTableGetstr_activity_error_109_setShowCallback            \   \   ]   ]   ^   ^   ^   ^   ^   ^   ^   _   _   _   c      self       isOpen         _ENV.                                                          %   8   %   <   >   <   @   E   @   G   J   G   K   M   K   O   Q   O   R   T   R   U   X   U   Z   c   Z   c          _ENV