LuaS 

xV           (w@k@../PublishResources/lua/product/components/ui/season/main/ui/talent/common/ui_season_talent_time_base.lua         %    @ A@  @ $@@@  @@ l   
@@@ l@  
@ @@ l  
@@@ lÀ  
@ @@ l  
@@@ l@ 
@ @@ l 
@@@ lÀ 
@ @@ l  
@@@ l@ 
@ &     _classUISeasonTalentTimeBaseUICustomWidgetSetDataShowTex	AddTimerOnHideRichTextTag_Out_LeftRichTextTag_Out_RightRichTextTag_Num_LeftRichTextTag_Num_RightSet_Time_Tex	Time_Tex    
              Ì@@ A  Á  ä 
À Æ@A ÇÁÁA ä 
À 
@ 
ÌB ä@ ÌÀB ä@ &     	_timeTexGetUIComponentUILocalizationTexttxtTime_svrTimeModuleGameGlobal
GetModuleSvrTimeModule	_endTime
_callbackShowTex	AddTimer                                             	                     self       endTime       	callback          _ENV    5    f   F @ G@À @ À@¤  Ad @A @ Á !ÀBPBBÐABBB"     â  @ ÀÀFB GÂÂ À  d À @FB GÂÂB À dÀ â    Àb  @ @ÀFB GÂÂ À d À FB GÂÂÂ ÀdÀ Àb    @FB GÂÂ ÀdÀ  FB GÂÂB d À B ÁBAA $ À  D "   D $A 
ÀDB ÁBLE d $GAE LÅÀ dA&     mathceil_svrTimeModuleGetServerTimeü©ñÒMbP?	_endTime        <              StringTableGet'str_week_tower_reset_time_day_and_hourstr_week_tower_reset_time_day'str_week_tower_reset_time_hour_and_minstr_week_tower_reset_time_hour#str_week_tower_reset_time_only_min#str_week_tower_reset_time_only_sec
_callback 	Time_Tex	_timeTexSetText         f                                                                                                                                                       !   !   !   !   !   !   !   !   #   #   #   #   #   #   $   %   %   %   %   &   &   &   &   &   &   &   (   (   (   (   (   )   +   +   +   +   +   ,   ,   ,   -   -   .   2   2   2   2   2   2   4   4   4   4   5   
   self    f   nowTime   f   gap	   f   timeTex
   f   minAll   O   min   O   hourAll   O   hour   O   day   O   showTexa   f      _ENV 6   =       G @ b   @F@@ GÀ d LÀÀ Ç @ d@F@@ GÀ d L Á Á@ A ÁAl  d
@ &     _timerGameGlobalTimerCancelEventAddEventTimesè      TimerTriggerCount	Infinite         :   <            @ $@ &     ShowTex           ;   ;   ;   <          self   7   7   7   8   8   8   8   8   8   :   :   :   :   :   :   :   <   :   <   =      self          _ENV >   B    
   G @ b   @F@@ GÀ d LÀÀ Ç @ d@&     _timerGameGlobalTimerCancelEvent         
   ?   ?   ?   @   @   @   @   @   @   B      self    
      _ENV C   E       A   f  &                D   D   E      self            F   H       A   f  &                G   G   H      self            I   K       A   f  &                J   J   K      self            L   N       A   f  &                M   M   N      self            O   Q       
@ &     _timeTexStr           P   Q      self       texStr            R   W       G @ b   @ G @ f  A@  f  &     _timeTexStr%str_season_talent_tree_line_time_tex           S   S   S   T   T   V   V   W      self           %                                 5      6   =   6   >   B   >   C   E   C   F   H   F   I   K   I   L   N   L   O   Q   O   R   W   R   W          _ENV