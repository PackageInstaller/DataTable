LuaS 

xV           (w@l@../PublishResources/lua/product/components/ui/activity/common_widget/ui_activity_common_remaining_time.lua         C    @ A@  @ $@@@  @@ l   
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
@@@ lÀ 
@ &     _classUIActivityCommonRemainingTimeUICustomWidget_GetComponentsOnShowOnHideDestroySetDataSetTimeColorSetAdvanceTextSetExtraTextSetExtraRollingTextSetExtraSpriteSetIconSetTextSetLocalizedTMPMaterialSetCustomTimeStrSetCustomTimeStr_Common_1SetCustomTimeStr_Common_2
_SetTimer_SetRemainingTimer_SetTimeText_SetColorText                  L@@ Á  Á  d 
@ G A b    L@@ Á@ Á  d 
@ &     	_txtTimeGetUIComponentUILocalizationTexttxtTime_useLocalizedTMPUILocalizedTMP                          	   	   	                        self                      
@@L@ d@ &     _isOpenSetCustomTimeStr_Common_1                          self                      
@@FÀ@ G Á @ d 
@ &     _isOpen _timeEventUIActivityHelperCancelTimerEvent                                    self          _ENV           F@@ GÀ  @ d 
@ &     _matReqUIWidgetHelperDisposeLocalizedTMPMaterial                                 self          _ENV    &       @ $A 
@
 
ÀA $A &     _GetComponents	_endTime_tickCallback_stopCallback
_SetTimer                 !   "   #   %   %   &      self       endTime       tickCallback       stopCallback            0   2       
@ &     _timeColor           1   2      self       
timeColor            8   :       
@ &     _descId           9   :      self       descId            >   G       b@    A   A@   À $ FÁ@ GÁd bA  ÀLAA À   FA GÂÁd dA  &     txtDescGetUIComponentUILocalizationTextstringisnullorempty_SetColorTextStringTableGet            ?   ?   ?   B   B   B   B   D   D   D   D   D   D   E   E   E   E   E   E   E   E   G      self       widgetName       
textColor       textId       	txtExtra         _ENV K   N    	   b@    A   @ Á  @ ¤ 
&     txtTime_rollingTextGetUIComponentRollingText        	   L   L   L   M   M   M   M   M   N      self    	   widgetName    	        R   W    	   b@    A   Ì@@ A   ä Ê&     iconGetUIComponentImagesprite        	   S   S   S   U   U   U   U   V   W      self    	   widgetName    	   sprite    	   icon   	        Y   _       b@    A   Ì@@ A   ä ÁÀ $A&     iconGetUIComponentRawImageLoader
LoadImage           Z   Z   Z   ]   ]   ]   ]   ^   ^   ^   _      self       widgetName       icon       obj           a   g       b@    A   Ì@@ A   ä ÁÀ $A&     textGetUIComponentUILocalizationTextSetText           b   b   b   e   e   e   e   f   f   f   g      self       widgetName       str       obj           i   l    
   
@@À@  AÀ   A @ @ ¤
 &     _useLocalizedTMP_matReqUIWidgetHelperSetLocalizedTMPMaterialtxtTime         
   j   k   k   k   k   k   k   k   k   l      self    
   matName    
      _ENV w   y       
@ &     _customStr           x   y      self       
customStr            |       	   L @ Ë@ ÊÀÊ ÁÊÁÊ ÂÊÂd@&     SetCustomTimeStrdaystr_activity_common_dayhourstr_activity_common_hourminstr_activity_common_minutezero str_activity_common_less_minuteoverstr_activity_error_107        	   }   }                  }         self    	               	   L @ Ë@ ÊÀÊ ÁÊÁÊ ÂÊ Âd@&  
   SetCustomTimeStrdaystr_activity_common_dayhourstr_activity_common_hourminstr_activity_common_minutezero str_activity_common_less_minuteover        	                                 self    	           ¨       
@@FÀ@ G Á @ ì   d
@ G@A b   À G@A LÁ Ä   d@&     _first_timeEventUIActivityHelperStartTimerEvent_rollingTextRefreshText                         @ %  &   &     _SetRemainingTimer                                  self                      ¡   ¥   ¥   ¥   ¦   ¦   ¦   ¦   ¨      self          _ENV ª   É    	7   G @ b@    &  L@@ Æ@ dÀ@  AÌ@Á ä ÏÁ¤ ÇÀA  _@Â FB GÁÂ ÇC dAC  ¤AGC b  @ GC dA ! BÀFB GÄÁC d 
@GAD b   GAD D dA LAC ÆÁD ÇÅC BEä dA  C f 
E&     _isOpen
GetModuleSvrTimeModulemathfloorGetServerTimeü©ñÒMbP?	_endTime         UIActivityHelperGetFormatTimerStr_customStr_SetTimeText_tickCallback_timeEventCancelTimerEvent_stopCallback_firstStringTableGetover          7   «   «   «   ¬   °   °   °   ±   ±   ±   ±   ±   ±   ²   ³   ´   ´   µ   ·   ·   ·   ·   ·   ¸   ¸   ¸   »   »   »   ¼   ¼   ¿   ¿   À   À   À   À   À   Á   Á   Á   Â   Â   Â   Ä   Ä   Ä   Ä   Ä   Ä   Ä   Å   Å   È   É      self    7   svrTimeModule   7   curTime   7   endTime   7   stamp   7   timeStr         _ENV Ï   Ô        @ @@Ç@ ¤ ¢@  @À@  AÇ@   ¤@  @A A GÁA  ¤@&     stringisnullorempty_descIdStringTableGet_SetColorText	_txtTime_timeColor            Ð   Ð   Ð   Ð   Ð   Ð   Ñ   Ñ   Ñ   Ñ   Ñ   Ñ   Ó   Ó   Ó   Ó   Ó   Ô      self       content          _ENV Ö   á    
    F@ GAÀ d bA  ÀA  @ Á@À  @¤   b    LÁ À dA&     stringisnullorempty<color=#%s>%s</color>formatSetText            ×   Ù   Ù   Ù   Ù   Ù   Ù   Ú   Û   Û   Û   Û   Û   Û   Û   Þ   Þ   ß   ß   ß   á      self       uiText       	colorStr       content       showStr      
formatStr         _ENVC                                                            &      0   2   0   8   :   8   >   G   >   K   N   K   R   W   R   Y   _   Y   a   g   a   i   l   i   w   y   w   |      |               ¨      ª   É   ª   Ï   Ô   Ï   Ö   á   Ö   á          _ENV