LuaS 

xV           (w@@C:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/lua/product/components/ui/ui_guide/ui_guide_pop_controller.lua             @ A@  @ $@@@  @@ l   
@@@ l@  
@ @A l  
@ ÀA lÀ  
@ ÀA l  
@ÀA l@ 
@ ÀA l 
@&     _classUIGuidePopControllerUIControllerConstructorOnShowUIGuidePopController_LoopPointReachedUIGuidePopControllerRefreshOnHide	OnUpdatebtncloseOnClick           	       &                 	      self               3    p    @ @@Ã     ¤@ A ¤ @AAÁ ¤
À@  BA ¤@B ,  ¤@ C A A ¤ 
 C A A ¤ 
 C A A ¤ 
 C A A ¤ 
ÀD @EE ÁEA $ ¤@   A  ¤
 A  ¤
ÀF @G  ¤@ÀÇ  H
 ÀÇ @H
H ¤@ ÀH  I¤ @II ÁIA
 AFAJ GÊ¤ ÆÀJ Ç ËA @ ä@Ì C AÁ Á ä 
À ÇK Ç ÌÌ@ÇC ä@ÇK ÊÇK ÁL M$ AM $Ê ÇK ÌÀÍä@ ÇK K NGAN AÊ &  :   GuideHelperGuideLoadLockPopanimGetGameObject
transformGetComponent
AnimationPlayuieff_uiGuidePop_In
StartTask	titleTxtGetUIComponentUILocalizationTexttitledescTxtdesc	extraTxtextrabtnTxtbtntxtSetTextStringTableGetstr_guide_pop_closebtnGO	btncloseuiWeakKuangUIWeakKuang
SetActiveid       guideParamdataRefreshResourceManagerGetInstanceGetAssetPathcfgmovie.mp4	LoadType
VideoClipLogdebug[guide movie] move url _vpVideoPlayergameObjecturltargetCameraGameGlobalUIStateManagerGetControllerCameraUIGuidePopControllerPlayloopPointReached_LoopPointReached                	   F @    Á@  d@FÀ LÀÀ Á  d@&     YIELDè      animPlayuieff_uiGuidePop_HangOn          	                                 TT    	      _ENVselfp                                                                                                                                                                                     "   "   "   #   #   #   $   $   (   (   (   (   (   (   (   (   (   (   (   *   *   *   *   *   -   -   -   -   -   .   .   .   .   .   /   /   0   0   0   0   0   0   0   0   1   1   1   2   2   2   2   2   2   3      self    p   	uiParams    p   urlM   p      _ENV 4   :       F @ G@À d LÀ ÁÀ  db   @ Á @A¤@  Á A¤@ &     GameGlobalUIStateManagerGetControllerUIGuidePopController_vpStopPlay            5   5   5   5   5   5   6   6   7   7   7   8   8   8   :      self       controller         _ENV <   E    #   F@@ GÀ À@ G 
@ G A L@Á ÆA ÇÀÁ@ Bä  d@  G@B L@Á ÆA ÇÀÁ@ Bä  d@  GÀB L@Á ÆA ÇÀÁ@ Cä  d@  G@C LÃ Ã   d@
 Ä&     cfgCfgcfg_guide_popid	titleTxtSetTextStringTableGettitledescTxtdesc	extraTxtextrabtnGO
SetActivetime                 #   =   =   =   =   =   >   >   >   >   >   >   >   >   ?   ?   ?   ?   ?   ?   ?   ?   @   @   @   @   @   @   @   @   C   C   C   C   D   E      self    #      _ENV G   L       F @ G@À d LÀ ÆÀ@ Ç ÁAA Ad@ GÀA ÀA  BÇ@B À J &  
   GameGlobalEventDispatcher	DispatchGameEventTypeFinishGuideStep
GuideTypePop_vploopPointReached_LoopPointReached            H   H   H   H   H   H   H   H   H   I   I   I   I   I   I   L      self          _ENV N   _        @ @@  &   @ @ 
  @ ! À À@  A ¤@ @ !À A  A ¤@&     time ¸      btnGO
SetActive      uiWeakKuang           O   O   O   P   R   R   R   V   V   V   X   X   X   X   \   \   \   ]   ]   ]   ]   _      self       deltaTimeMS            a   p        @ @@Á  GÁ@ GÁbA    AA Á@ A¢A    A ÇÁ@ ÇÁ+A¤@ÀA  BA ¤@B ,  ¤@&     GameGlobalUAReportForceGuideEventGuideStepClickdataguideÿÿÿÿÿÿÿÿstepanimPlayuieff_uiGuidePop_Out
StartTask         j   m       F @    Á@  d@E  LÀ d@ &     YIELDô      CloseDialog             k   k   k   k   l   l   l   m      TT          _ENVself   c   c   c   c   d   d   d   d   d   e   e   e   e   e   f   g   g   c   h   h   h   h   i   m   i   p      self       go          _ENV                        	         3      4   :   4   <   E   <   G   L   G   N   _   N   a   p   a   p          _ENV