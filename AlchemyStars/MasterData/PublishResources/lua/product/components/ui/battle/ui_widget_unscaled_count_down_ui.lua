LuaS 

xV           (w@[@../PublishResources/lua/product/components/ui/battle/ui_widget_unscaled_count_down_ui.lua         %    @ A@  @ $@@@  @@ l   
@@@ l@  
@ @@ l  
@@@ lÀ  
@ @@ l  
@@@ l@ 
@ @@ l 
@@@ lÀ 
@ @@ l  
@@@ l@ 
@ &     _classUIWidgetUnscaledCountDownUIUICustomWidgetOnShowInitWidgetOnResetRegisterEventIsAutoFightingShowAutoFightForbiddenMsgUIShowUnscaledCountDownUIEnableUnscaledCountDown	OnUpdateRefreshCountDownNum    
               @ ¤@ &     InitWidget                       self       	uiParams            
          L@@ Á  d
@ L A Á@  d 
@LÀA d@ L B d@ &  	   _countDownObjGetGameObject
CountDown_countDownTimeTextGetUIComponentUILocalizationTextCountDownTimeOnResetRegisterEvent                                                        self                      
@@F@  @ d À  ]  A @A  ¤@ @ ÀA
 
@B&  
   _countDownNum       	tostrings_countDownTimeTextSetText_countDownMsè      _enableCountDown                                                             self       strNum         _ENV            L @ Æ@@ ÇÀ@ d@ L @ Æ@@ ÇÀÀÁ@ d@ &     AttachEventGameEventTypeUIShowUnscaledCountDownUIEnableUnscaledCountDown                                                 self          _ENV "   $       F @ G@À @ d LÀÀ e  f   &     GameGlobalGetUIModuleMatchModuleIsAutoFighting            #   #   #   #   #   #   #   $      self          _ENV &   (       F @ G@À @ d LÀÀ e  f   &     GameGlobalGetUIModuleMatchModuleShowAutoFightForbiddenMsg            '   '   '   '   '   '   '   (      self          _ENV *   /    	    @ @@  ¤@b@  @ @ ¤@ &     _countDownObj
SetActiveOnReset        	   +   +   +   +   ,   ,   -   -   /      self    	   show    	        0   2       
@ &     _enableCountDown           1   2      self       bEnable            4   E        @ ¢   @@@ @¢   @À@  A¤ 
ÌA ä@ &     _enableCountDown_countDownObjactiveSelfInnerGameHelperRender$UIGetCurGlobalUnscaledCoundDownTime_countDownMsRefreshCountDownNum            5   5   5   6   6   6   6   7   7   7   8   9   9   E      self       deltaTimeMS       restTimeMs
         _ENV G   S       A   @@   @@ A   @@ À@Ç@@ Ò Á¤ @  @A _@ @
@A Ç@A ¤ ÁÀ À Ç B Ì@Â@ ä@&  
           _countDownMsmathceilè      _countDownNum	tostrings_countDownTimeTextSetText            H   I   I   I   J   J   L   L   L   L   L   L   N   N   N   O   P   P   P   P   P   Q   Q   Q   Q   S      self       refreshNumSec      timeNumStr         _ENV%                              
      
                      "   $   "   &   (   &   *   /   *   0   2   0   4   E   4   G   S   G   S          _ENV