LuaS 

xV           (w@@C:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/lua/product/components/ui/ui_lost_land/ui_lost_land_main_controller.lua         7    @ A@  @ $@@@  @@ l   
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
@ &     _classUILostLandMainControllerUIControllerOnShowGetComponentsCloseController
ResetAnimOnLostLandTimeResetOnValueInitEnterDataEnterItemClickChooseEnterUnLockEnter_OnUnLockEnterOnHide
InitTimerSetTimerTex
TimeResetweekBtnOnClick               "   @@ @ÆÀ@ ¤ 
 @@ @AÆÀ@ ¤ 
 @@ @ÆÀA ¤ 
  A @B¤ 
 B ¤@ ÀÂ ¢   @ Ì C ä@ Ì@C ä@ ÌC FÁC GÄD ä@ &     _moduleGameGlobal
GetModuleLostAreaModule
_uiModuleGetUIModule_svrTimeModuleSvrTimeModule_enterDataGetEnterDataGetComponents       
ResetAnimOnValueAttachEventGameEventTypeOnLostLandTimeReset         "                  
   
   
   
   
                                                                              self    "   	uiParams    "   
resetTime   "      _ENV    +       L @ Á@    d  Á A ¤
À@ A,  ¤@ B A ¤
ÀA B  ¤@ @  AA ¤ 
 @ A  AÁ ¤ 
 &     GetUIComponentUISelectObjectPathbtnBack	_backBtnSpawnObjectUICommonTopButtonSetData	_resetGoGetGameObjectreset
SetActive
_timerTexUILocalizationText	timerTex_enterPool
enterPool            "            @ $@ &     CloseController           !   !   !   "          self                                 "      %   %   %   %   &   &   &   &   (   (   (   (   (   *   *   *   *   *   +      self       ltBtns           -   /       L @ Æ@@ ÇÀd@&     SwitchStateUIStateTypeUIDiscovery            .   .   .   .   /      self          _ENV 2   <       G @ L@À Ã  d@F@ GÀÀ d L Á Á@ ,  d@ &     	_resetGo
SetActiveGameGlobalTimer	AddEvent¸               6   :         @ "   À  @ @@    $@&     	_resetGo
SetActive           7   7   7   8   8   8   8   :          self   3   3   3   3   4   4   4   4   5   :   4   <      self          _ENV ?   A       L @ d@ &     OnValue           @   @   A      self            C   F       L @ d@ L@@ d@ &     
InitTimerInitEnterData           D   D   E   E   F      self            I   X       G @ \  @@ @Á  @ ¤@ @@ @A¤ 
  Ç A Ü  ¨ÀA AÌÁA@@ Bì  äA§ý&     _enterData_enterPoolSpawnObjectsUILostLandMainItem_enterPoolsGetAllSpawnList       SetData        S   U       E   L À À   d@&     EnterItemClick           T   T   T   T   U      idx          self   J   J   K   K   K   K   K   M   M   M   M   N   N   N   N   N   O   O   P   Q   R   R   U   P   N   X      self       count      (for index)      (for limit)      (for step)      i      item           [   z    6    @ @ Ì@@ä @ Á@ @A AAA ÁA BÆAB ÇÂÂ FC GBÃ d ¬  Ä  ,C  D  $A @ ÁC À D  $A@ AD ÀD ÁDFC GAÃ d $A  @ AE  E  $A&     _enterDataGetLockStateUILostLandEnterLockTypeUNLOCKPopupManagerAlertUICommonMessageBoxPopupPriorityNormalPopupMsgBoxType	OkCancelStringTableGet$str_lost_land_choose_enter_pop_tips
CANUNLOCKUnLockEnterLOCKToastManager
ShowToaststr_lost_land_enter_lock_tipsCHOOSEChooseEnter         g   j    
   F @ G@À   Å  d@E  LÀÀ Å d@&     Logdebug+###[UILostLandMainController] é¾åº¦éæ©ChooseEnter          
   h   h   h   h   h   i   i   i   i   j      param    
      _ENVidxself
enterData l   n       F @ G@À   d@ &     Logdebug1###[UILostLandMainController] åæ¶é¾åº¦éæ©            m   m   m   m   n      param          _ENV6   ]   ]   ^   ^   _   _   _   _   a   a   b   c   c   d   d   e   f   f   f   f   j   k   n   p   a   p   q   q   q   q   s   s   s   s   t   t   t   t   v   v   v   v   v   v   v   v   w   w   w   w   x   x   x   z      self    6   idx    6   
enterData   6   state   6      _ENV }           @ @@  ¤@&     
_uiModuleChooseEnter           ~   ~   ~   ~         self       
enterdata                       @ @@Á    ¤@À@  A¤ @AA @   ¤@&     Logdebug4###[UILostLandMainController] å¼å§è§£é idx --> GameGlobalTaskManager
StartTask_OnUnLockEnter                                                         self       idx          _ENV        
#   Ç @ ÇAÀ$ G@ LÁÀÀ   d Á¤ ¢  AA AÁÁ ¤A @  B¤A AB  B@  ¤A@AA AÁÁ Ã$ ¤A  &     _enterDataGetEnterID_module#RequestLostAreaUnlockOnedifficultyGetSuccLogdebug+###[UILostLandMainController] è§£éæåUnLock_enterPools
FlushData2###[UILostLandMainController] è§£éå¤±è´¥,res-->
GetResult         #                                                                                                               self    #   TT    #   idx    #   
enterData   #   	unlockid   #   res	   #      _ENV           G @ b   F@@ GÀ d LÀÀ Ç @ d@
 A&     _timerEventGameGlobalTimerCancelEvent                                                 self          _ENV    ­       G@@ LÀ d 
@ GÀ@ b   F A G@Á d LÁ ÇÀ@ d@
ÀÁF A G@Á d L Â Á@ B ÁBl  d
@L C d@ &     _resetTime
_uiModuleGetResetTime_timerEventGameGlobalTimerCancelEvent AddEventTimesè      TimerTriggerCount	InfiniteSetTimerTex         ¨   ª            @ $@ &     SetTimerTex           ©   ©   ©   ª          self                           ¡   ¡   ¡   ¡   ¡   ¡   ¢   ¥   ¥   ¥   ¥   ¦   §   §   ª   ¥   «   ¬   ¬   ­      self          _ENV ®   ·    	   F @ G@À @ À@¤  Ad @A @  A ÌÀA ä@ ÀÇ B Ì@Â@ äB ÁBC ACÁ  ¤$A  &     mathfloor_svrTimeModuleGetServerTimeü©ñÒMbP?_resetTime        
TimeReset
_uiModule	Time2Tex
_timerTexSetTextStringTableGetstr_lost_land_reset_time_tips            ¯   ¯   ¯   ¯   ¯   ¯   ¯   °   °   ±   ±   ²   ²   ²   ´   ´   ´   ´   µ   µ   µ   µ   µ   µ   µ   µ   ·      self       svrTime      sec	      timeTex         _ENV ¹   Ä       F @ G@À   d@ GÀ@ b   F A G@Á d LÁ ÇÀ@ d@
ÀÁL B d@ G@B LÂ ÆÀB Ç Ãd@&     Logdebug=###[UILostLandMainController] æ¶é´å°ï¼è¿·å¤±ä¹å°éç½®_timerEventGameGlobalTimerCancelEvent 
ResetAnim
_uiModule
ResetTimeUILostLandResetTimeDialogMain            º   º   º   º   ¼   ¼   ¼   ½   ½   ½   ½   ½   ½   ¾   Á   Á   Ã   Ã   Ã   Ã   Ã   Ä      self          _ENV Æ   È       L @ Á@  d@&     ShowDialogUILostLandWeekInfoController           Ç   Ç   Ç   È      self           7                                 +      -   /   -   2   <   2   ?   A   ?   C   F   C   I   X   I   [   z   [   }      }                                 ­      ®   ·   ®   ¹   Ä   ¹   Æ   È   Æ   È          _ENV