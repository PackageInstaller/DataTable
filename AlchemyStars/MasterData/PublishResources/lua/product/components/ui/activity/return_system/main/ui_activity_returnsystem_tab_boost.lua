LuaS 

xV           (w@r@../PublishResources/lua/product/components/ui/activity/return_system/main/ui_activity_returnsystem_tab_boost.lua             @ A@  @ $@@@  @@ l   
@@@ l@  
@ @@ l  
@@@ lÀ  
@ @@ l  
@@@ l@ 
@ @@ l 
@&  
   _classUIActivityReturnSystemTabBoostUICustomWidgetOnShowOnHideSetDataFlushCancelTimerEventDropTimesbtnFightOnClick_RefreshTripleReward                  @@   A  ¤ 
  A Á  ¤
@@   AA ¤ 
@@ Á A ¤ 
  A  ¤
 &  	   txtDropTimesGetUIComponentUILocalizationText	btnFightGetGameObjecttxtDescbgRawImageLoadertripleDurationGo                                      	   	   	   	   	   
   
   
   
   
                     self       	uiParams                      L @ d@ &     CancelTimerEventDropTimes                       self               !    	   
@ F@ GÁÀ@ Á B d 
@
 LÁA dA "   GB LAÂÃ  dA GA@ LÂdA LÁB dA &     
_campaign_componentUIActivityReturnSystemHelperGetComponentByTabNameboost       remainingTimeCallbackFlush	btnFight
SetActiveCloseTodayRedPoint_RefreshTripleReward                                                                                   !      self       	campaign       remainingTimeCallback       tipsCallback       isBoostIntro          _ENV #   9    
    G @ L@À dÀ Î@ @ Á@A À $ GAA LÁÀ dAl  @ ÁA¤ ÆB ÇAÂ  ä  @$B B "   B @ $B &     _componentGetBoostTimesStringTableGet#str_return_system_extra_drop_timestxtDropTimesSetTextGetNextTimestampUICommonHelperCalcLeftSecondsremainingTimeCallback         )   2       E   L À d@ FÀ GÀÀ d L Á Ï@A ,  d @&     CancelTimerEventDropTimesteGameGlobalTimer	AddEventè                .   0            @ $@ &     Flush            /   /   /   0          self   *   *   *   ,   ,   ,   ,   -   0   ,   1   2      seconds          self_ENV    $   $   $   %   &   &   &   &   &   &   '   '   '   '   2   3   3   3   4   4   4   4   5   5   5   6   6   6   7   7   7   9      self        	curTimes       	maxTimex       
leftTimes       str
       RegisterTimeEvent       
resetTime       leftSeconds          _ENV ;   ?    
   G @ b   @F@@ GÀ d LÀÀ Ç @ d@&     teGameGlobalTimerCancelEvent         
   <   <   <   =   =   =   =   =   =   ?      self    
      _ENV A   W        @ @@¤À !À@ Á@FA GAÁ d $A  &  ÁA BFAB $ FB GÁÂ  ÌC@ äA ÌACäA &     _componentGetBoostTimesToastManager
ShowToastStringTableGet.str_return_system_extra_drop_times_not_enoughGameGlobalGetUIModuleQuestModuleUIJumpTypeUI_JumpResDungeonSetJumpUIDataJump            B   B   B   C   C   D   D   D   D   D   D   D   E   I   I   I   I   J   J   K   L   L   L   L   M   M   W      self       go       	curTimes      	maxTimex      uiJumpModule      jumpID      
jumpParam         _ENV Y   s    H   C    @ @@@À@Æ @ Ç@ÀÇ ÁÇÀÀ¢   â    AA AFÁA $ FAA GÁB d AB BÌÁÂä ÏÃ¤ ÌAC@ C ÂCä BCÆC ÇÂÃ$ !     C  D AD $Ab   ÀD ÁD $AAE EÁE FÁA ¤ $A  D ÁD $AAE EÁE FÁÁ ¤ $A  &     Cfgcfg_globalActiveBackFlowStartTime	StrValueActiveBackFlowEndTimeGameGlobal
GetModuleLoginModuleSvrTimeModulemathfloorGetServerTimeü©ñÒMbP?GetTimeStampByTimeStrEnum_DateTimeZoneTypeE_ZoneType_GMTtripleDurationGo
SetActivebg
LoadImagehuiliu_zhuli_bg1_1txtDescSetTextStringTableGetstr_return_system_desc_1huiliu_zhuli_bg1str_return_system_desc         H   Z   [   [   [   [   \   \   \   \   ^   ^   ^   ^   _   _   _   _   `   `   `   `   a   a   a   a   a   a   c   c   c   c   c   d   d   d   d   d   e   e   e   e   f   j   j   j   j   k   k   l   l   l   l   m   m   m   m   m   m   m   m   o   o   o   o   p   p   p   p   p   p   p   s   	   self    H   bTriple   H   	strBegin   H   strEnd	   H   loginModule   *   srvTime   *   curTime   *   
beginTime    *   endTime%   *      _ENV                                          !      #   9   #   ;   ?   ;   A   W   A   Y   s   Y   s          _ENV