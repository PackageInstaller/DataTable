LuaS 

xV           (w@Y@../PublishResources/lua/product/components/ui/ui_temp_sign_in/ui_temp_sign_in_enter.lua         7    @ A@  $@ @ Aΐ   A $@ΐ@  ΐ@ l   
@A l@  
@ B l  
@ B lΐ  
@  B l  
@ B l@ 
@  B l 
@C lΐ 
@C l  
@ C l@ 
@C l 
@ ΐD lΐ 
@ ΐD l  
@ΐD l@ 
@ ΐD l 
@&     requireui_side_enter_item_base_classUITempSignInEnterUISideEnterItem_Base
CheckOpenUITempSignInEnter	CheckRedUITempSignInEnterCheckDayStatusOnShowOnHideSetData_CheckOpenUITempSignInEnterGetSideEnterRawImageDoShow	_CalcNew	_CalcRedUITempSignInEnter	_Refresh
_SetTitle_SetBgBtnOnClick        	        $    @ @@ @ ΐ@ F A G@Α A d ΐΑ    €’@  @ Γ   ζ  Λ  B ABFB GΒλ@ ΑB C@$ @C@FC GΑΓ dA C  f C f &     Cfgcfg_globalsignInPassMissionID	IntValueGameGlobal
GetModuleMissionModuleIsPassMissionIDNewPlayerLoginStatusNPLS_UnReachNPLS_UnAcceptUITempSignInEnterCheckDayStatus        Logdebug3UITempSignInEnter:CheckOpen() temp sign is close !         $                                                                                                                  isPassMissionID   $   missionModule   $   isPass   $   tb   $   isOpen   $      _ENV               F @ G@ΐ +@ F@ Gΐΐ    d  Α   @    ¦  &     NewPlayerLoginStatusNPLS_UnAcceptUITempSignInEnterCheckDayStatus                                                                  tb      idx         _ENV "   ,    
   F @ G@ΐ    d @ ΐ@Ζ A € Μ@Aδ A @$ΐ G _ΐΑ  ζ )  ͺAώ & &  	   tablereverseGameGlobal
GetModuleSignInModuleGetNewPlayerSignupStatusipairs                     #   #   #   #   $   $   $   $   %   %   &   &   &   &   '   '   '   (   &   &   +   +   ,   	   target       dic      signInModule      dayInfo
      (for generator)      (for state)      (for control)      index      value         _ENV 0   2       L @ Ζ@@ ΗΐΑ@ d@ &     AttachEventGameEventTypeOnTempSignInAwardGot	_Refresh            1   1   1   1   1   2      self          _ENV 4   6       L @ Ζ@@ ΗΐΑ@ d@ &     DetachEventGameEventTypeOnTempSignInAwardGot	_Refresh            5   5   5   5   5   6      self          _ENV 8   ;       
@ &     _btnCfg           :   ;      self       btnCfg            @   B        @ @@₯  ¦   &     UITempSignInEnter
CheckOpen            A   A   A   A   B      self       TT          _ENV F   H       A   f  &     gh_xsqd_di09           G   G   H      self            J   M       L @ d@ L@@ d@ &     
_SetTitle_SetBg           K   K   L   L   M      self            O   Q       C   f  &                 P   P   Q      self            S   U       F @ G@ΐ e  f   &     UITempSignInEnter	CheckRed            T   T   T   T   U      self          _ENV [   ]       L @ d@ &     _CheckPoint           \   \   ]      self            _   e       A   @  b   ’    Ζ@ Ηΐΐ   @ A AAΐ € δ@  &     	txtTitlestr_sign_in_btn_str_newUIWidgetHelperSetLocalizationTextStringTableGet            `   a   b   b   b   b   c   c   c   c   c   c   c   c   c   e      self       widgetName      strId         _ENV g   m       A   @@ € b   ΐ’   @Ζ@ Ηΐΐ   @  δ@ &     bgGetSideEnterRawImageUIWidgetHelperSetRawImage            h   i   i   j   j   j   j   k   k   k   k   k   k   m      self       widgetName      sideEnterIcon         _ENV o   q       &                 q      self       go           7                              	      	             "   ,   "   0   2   0   4   6   4   8   ;   8   @   B   @   F   H   F   J   M   J   O   Q   O   S   U   S   [   ]   [   _   e   _   g   m   g   o   q   o   q          _ENV