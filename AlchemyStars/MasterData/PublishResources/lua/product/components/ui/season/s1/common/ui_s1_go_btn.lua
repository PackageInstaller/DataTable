LuaS 

xV           (w@Q@../PublishResources/lua/product/components/ui/season/s1/common/ui_s1_go_btn.lua         "    @ A@  @ $@@@  @@ l   
@@@ l@  
@ @@ l  
@@@ lÀ  
@ @@ l  
@@@ l@ 
@ @@ l 
@@@ lÀ 
@ @@ l  
@&     _class
UIS1GoBtnUICustomWidgetOnShowOnHideSetData	_Refresh
_SetState	_CalcNew	_CalcRed_CheckPointBtnOnClick    	              F@@ GÀ À@ d L Á d 
@ &     _constBtnNameGameGlobalGetUIModuleSeasonModuleGetGoBtnKey                                       self          _ENV 	   
       &                 
      self                      
@ 
ã  @ Ì@ä â     "A    A 
 A Á@ $AÁA  $A&     
_seasonId_componentComponentIsOpen_state              
_SetState	_Refresh                                                                          self       	seasonId       
component       isOpen              )    +    À   @    Ì@@ A  äÌÀÀ@ ä@¢@    &  Ì Á äÀ FAA GÁÁ À  d B ABÀ   @¤A ÁÂ ¤ Á B @ BFB GÃ  ÁÂ  @ dBLD dB &      GetGameObject_topTip
SetActiveGetItemCountstringformat<color=#ff9d32>%s</color>/%sUIWidgetHelperSetLocalizationText_text
GetItemIdUICommon.spriteatlas	toptoon_SetImageSprite_icon_CheckPoint         +                                                                        !   !   !   !   !   !   #   #   $   %   %   %   &   &   &   &   &   &   &   (   (   )   	   self    +   
component    +   isShow   +   cur   +   ceil   +   str   +   itemId   +   
atlasName   +   spriteName!   +      _ENV +   0        @ A  ¤@_ÀÀ   A   ¤@ÀÀ    ¢@    @ ÌA AÁ  ä Ê&  
   GetGameObject_lock
SetActive             à?       GetUIComponentCanvasGroup_alphaGroupalpha           ,   ,   ,   ,   ,   ,   ,   ,   ,   -   -   -   -   -   -   .   .   .   .   /   0      self       state       alpha      obj           4   =       G @ b    G @ L@À d @ À@Ç A A ¤  ã    À  æ  &     _componentComponentIsOpenUISeasonLocalDBHelperSeasonBtn_Has_constBtnNameNew            9   9   9   9   9   9   ;   ;   ;   ;   ;   ;   <   <   <   <   =      self       isOpen      isNew         _ENV ?   L    $   G @ b    G @ L@À d b@    f  @ À@Ç A A ¤ÆA ÇÀÁ @ ä@Æ@B ÌÂ@ ä@ ÁB$Á £ @£À `   A   ¦ &     _componentComponentIsOpenUISeasonLocalDBHelperSeasonBtn_Get_constBtnNameRedLogdebug!UIS1GoBtn:_CalcRed() lastTime = HelperProxyIsCrossDayToGetItemCount                 $   @   @   @   @   @   @   A   A   B   E   E   E   E   E   F   F   F   F   F   G   G   G   G   I   I   I   K   K   K   K   K   K   K   K   K   L      self    $   isOpen   $   	lastTime   $   isRed   $   cur   $   ceil   $      _ENV N   R    	   L @ d @@ ¤ Æ@ ÇÀÀ   @  Á B ä@ &     	_CalcNew	_CalcRedUIWidgetHelperSetNewAndReds_new_red            O   O   P   P   Q   Q   Q   Q   Q   Q   Q   Q   R      self       new      red         _ENV X   m    4   F @ G@À   d@ FÀ@ G Á @A d Á ÁA ¤¢     &   B @BÀB ÀBÆ C Ç@Ã ä  ¤@  &  À@ ÀCÆ@A ¤  D¤@ @D DÇÀD  ¤@À@  AÆ@E ¤ E¤ ÀEÆ@D ÇÄÁD A  ä@ Ì@F ä@ &     LoginfoUIS1GoBtn:BtnOnClickGameGlobal
GetModuleSeasonModule!CheckSeasonClose_ShowClientError
_seasonId_state       ToastManager
ShowToastStringTableGetstr_season_s1_main_btn_overGetUIModuleEnterCurrentSeasonMainUIUISeasonLocalDBHelperSeasonBtn_Set_constBtnNameNewSvrTimeModuleGetServerTimeü©ñÒMbP?Red_CheckPoint         4   Y   Y   Y   Y   \   \   \   \   ]   ]   ]   ]   ]   ^   a   a   a   b   b   b   b   b   b   b   c   f   f   f   f   f   f   g   g   g   g   g   h   h   h   h   h   h   h   i   i   i   i   i   i   j   j   m      self    4   seasonModule   4   now+   4      _ENV"                              	   
   	               )      +   0   +   4   =   4   ?   L   ?   N   R   N   X   m   X   m          _ENV