LuaS 

xV           (w@b@../PublishResources/lua/product/components/ui/activity/crazy_login_v2/ui_crazy_login_v2_cell.lua         1    @ A@  @ $@@@  @@ l   
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
@ &     _classUICrazyLoginV2CellUICustomWidgetOnShowOnHide_SetUI_ByCfg_SetStageUI_ByCfgSetData
_SetState
_SetItems_SetDayText_SetEffShowSetSelected_SetSpecial
_SetAlphaOnAwardGotBgBtnOnClick                  
@@@   ¤@&     _dayNum       SetSelected                             self       	uiParams            
          G @ b   À G @ L@À d@ 
@GÀ@ b   À GÀ@ L@À d@ 
À&     _resFDispose _resB                                                           self               *    @   F @ G@À @ ÁÀ  d @ @AÀ    @ A ¤
  @ @@Ç@ Á ¤@   @ @AÀ   A @ B ¤
  @ @@Ç@  ¤@  ÀB  CÀ   A @ ¤@  @ @@Ç@  ¤@  ÀB  CÀ   Á @ ¤@  @ @@Ç@  ¤@  ÀB  CÀ   A @ ¤@ &     UICrazyLoginV2Helper	GetValue
_campaignAwardParticecleF_resFSetEffByCfg
eff_frontAwardParticecleB_resB	eff_back
LockImageUIWidgetHelperSetRawImage	_imgLock
SpecialBg_fgSpecialSelectedBg_fgSelected         @                                                                                                            !   !   !   !   !   !   $   $   $   $   $   $   %   %   %   %   %   %   (   (   (   (   (   (   )   )   )   )   )   )   *      self    @   value   @      _ENV ,   9    	+    @ @@Ç@   AÁ  ¤ Æ A Ç@Á   A  ä@ Æ @ Ç@À@ @ Á ä @ B@  A À$A A Á Á +AF@ GAÀ@ À B d À F@ GÂ  ÇA  dA &     UICrazyLoginV2HelperGetStateValue
_campaignbgUIWidgetHelperSetRawImage_bgdaySetTextColorByCfg_txtDayStateCanGetTextStateGotTextStateLockedTextdesc         +   .   .   .   .   .   .   /   /   /   /   /   /   2   2   2   2   2   2   3   3   3   3   3   3   6   6   6   6   6   7   7   7   7   7   7   7   8   8   8   8   8   8   9      self    +   state    +   value   +   color   +   widget   +      _ENV =   Q   	 !   
@ 

À 
 
@

ÀFB GBÂ@ Á dbB    C  
@LÂB dB LC ÇBÃdBLC ÇÂÃdBFB GBÄÄd 
@LÂD ÇD dB&     
_campaign_idx_data
_lastCell_selectCallback_getCallback_tipCallback_lastFixedUICrazyLoginV2Helper	GetValue
LastFixed_SetUI_ByCfg
_SetItems
m_rewards_SetDayTextm_login_days_state
SafeStatem_reward_status
_SetState         !   ?   @   B   C   D   E   F   I   I   I   I   I   I   I   I   I   K   K   L   L   L   M   M   M   O   O   O   O   O   P   P   P   Q   	   self    !   	campaign    !   idx    !   data    !   	lastCell    !   selectCallback    !   getCallback    !   tipCallback    !   lastDay    !      _ENV S   g    3   Æ @ Ç@À   K Á  «A Ë Â  ëA  A +B kAä@ AA@ $AA ÁA@ $ LB À dA¢     &  FAB b    [ B  ¤A"   Á ¢A     ÌAC @ äAÇC ÂC $B&     UIWidgetHelperGetObjGroupByWidgetNameStateCanGet	StateGotStateLockedSetObjGroupShowUICrazyLoginV2HelperIsStateRecved_SetStageUI_ByCfg
isSpecial_SetEffShow      à?       
_SetAlpha
_lastCell_SetSpecial         3   T   T   T   T   T   T   T   T   T   T   T   T   T   T   T   U   U   U   U   U   W   W   W   W   Y   Y   Y   [   [   \   _   _   _   _   `   `   `   b   b   b   b   b   b   c   c   c   e   f   f   f   g      self    3   state    3   
forEffect    3   objs   3   isGot   3   effShow"   3   value+   3   
isSpecial/   3      _ENV i   n        @ @@À     AÁ   ¤Æ A   ä À BÁ ÇA $B é  jAþ&     UIWidgetHelperSpawnObjects
_itemPoolUICrazyLoginV2ItemipairsSetData_tipCallback            j   j   j   j   j   j   j   k   k   k   k   l   l   l   l   k   k   n      self       	itemData       objs      (for generator)
      (for state)
      (for control)
      i      v         _ENV p   s        @ @@Á    ¤ÆÀ@ Ç Á   AA  ä@ &     StringTableGetstr_temp_sign_in_day_textUIWidgetHelperSetLocalizationText_txtDay            q   q   q   q   q   r   r   r   r   r   r   s      self       dayNum       text         _ENV u   x        @ A  ¤@  ¤@ @ Á  ¤@  ¤@&     GetGameObject
eff_front
SetActive	eff_back           v   v   v   v   v   v   w   w   w   w   w   w   x      self       effShow            z   |        @ A  ¤@  ¤@&     GetGameObject_fgSelected
SetActive           {   {   {   {   {   {   |      self       show            ~           @ A  ¤@  ¤@&     GetGameObject_fgSpecial
SetActive                                   self       show                       @ A  A  ¤ @Ì @ AA   ä Ê@&     GetUIComponentCanvasGroup
AlphaAreaalpha
StateArea                                               self       value       cg      cg2	                  	    @ A@ @C ¤@ À  Æ A Ç@Á   A  ÁÁ ,  ä@ &     
_SetStateECumulativeLoginRewardStatus!E_CUMULATIVE_LOGIN_REWARD_RECVED+uieff_UIActivityCrazyLoginContent_Cell_GetUIWidgetHelperPlayAnimation_animM                           @ @@ E  $@ &     UIActivityHelperShowUIGetRewards                                  _ENVrewards                                                   self       rewards       	animName         _ENV             @ Ç@@ â    Ç@@   ä@ Æ@ ÇÀÀA AAä â   @A "   A @ $A &     _idx_selectCallbackUICrazyLoginV2HelperIsStateCanRecv_datam_reward_status_getCallback                                                                               self       go       idx      canRecv         _ENV1                              
      
      *      ,   9   ,   =   Q   =   S   g   S   i   n   i   p   s   p   u   x   u   z   |   z   ~      ~                                          _ENV