LuaS 

xV           (w@O@../PublishResources/lua/product/components/ui/season/s3/main/ui_s3_go_btn.lua         "    @ A@  @ $@@@  @@ l   
@@@ l@  
@ @@ l  
@@@ lÀ  
@ @@ l  
@@@ l@ 
@ @@ l 
@@@ lÀ 
@ @@ l  
@&     _class
UIS3GoBtnUICustomWidgetOnShowOnHideSetData	_Refresh
_SetState	_CalcNew	_CalcRed_CheckPointBtnOnClick    	              F@@ GÀ À@ d L Á d 
@ &     _constBtnNameGameGlobalGetUIModuleSeasonModuleGetGoBtnKey                                       self          _ENV 	   
       &                 
      self                      
@ 
ã  @ Ì@ä â     "A    A 
 A Á@ $AÁA  $A&     
_seasonId_componentComponentIsOpen_state              
_SetState	_Refresh                                                                          self       	seasonId       
component       isOpen              '    /    À   @    Ì@@ A  äÌÀÀGA _@Á@ @ @ CA  C ä@¢@    &  ÌÁ äÀ FÁA GÂA ÀB A  ]dÁB CÀ  B @¤A Ã ¤ ÆÁB ÇÁÃ   @  äA ÌAD äA &      GetGameObject_topTip
SetActive_state       GetItemCountUIActivityHelperGetColorText#FFFFFF/UIWidgetHelperSetLocalizationText_text
GetItemIdSetItemIconSprite_icon_CheckPoint         /                                                                                                      !   !   !   !   !   !   #   #   $   $   $   $   $   $   &   &   '      self    /   
component    /   isShow   /   cur   /   ceil   /   str   /   itemId&   /      _ENV )   /        @ A  ¤@_ÀÀ   A   ¤@ @  ¤@ÀÀ   A   ¤@ÀÀ  @ ¢@     ÌÀA A A ä Ê &     GetGameObject_lock
SetActive       _topTip      à?       GetUIComponentCanvasGroup_alphaGroupalpha           *   *   *   *   *   *   *   *   *   +   +   +   +   +   +   +   +   +   ,   ,   ,   ,   ,   ,   -   -   -   -   .   /      self       state       alpha      obj           3   <       G @ b    G @ L@À d @ À@Ç A A ¤  ã    À  æ  &     _componentComponentIsOpenUISeasonLocalDBHelperSeasonBtn_Has_constBtnNameNew            8   8   8   8   8   8   :   :   :   :   :   :   ;   ;   ;   ;   <      self       isOpen      isNew         _ENV >   R    .   G @ b    G @ L@À d b@    f  @ À@Ç A A ¤ÆA ÇÀÁ @ ä@Æ@B ÌÂ@ ä@ ÁB$Á `   A   ã  À BC C$ ÂCD $BD$ cB  @ f &     _componentComponentIsOpenUISeasonLocalDBHelperSeasonBtn_Get_constBtnNameRedLogdebug!UIS3GoBtn:_CalcRed() lastTime = HelperProxyIsCrossDayToGetItemCount        GameGlobal
GameLogic
GetModuleSeasonTaskModuleTaskListRed         .   ?   ?   ?   ?   ?   ?   @   @   A   E   E   E   E   E   F   F   F   F   F   G   G   G   G   I   I   I   J   J   J   J   L   L   L   O   O   O   O   O   O   O   O   Q   Q   Q   Q   R   	   self    .   isOpen   .   	lastTime   .   isCross   .   cur   .   ceil   .   	haveItem   .   
isCoinRed!   .   
isTaskRed)   .      _ENV T   X    	   L @ d @@ ¤ Æ@ ÇÀÀ   @  Á B ä@ &     	_CalcNew	_CalcRedUIWidgetHelperSetNewAndReds_new_red            U   U   V   V   W   W   W   W   W   W   W   W   X      self       new      red         _ENV ^   q    4   F @ G@À   d@ FÀ@ G Á @A d Á ÁA ¤¢     &   B @BÀB ÀBÆ C Ç@Ã ä  ¤@  &  À@ ÀCÆ@A ¤  D¤@ @D DÇÀD  ¤@À@  AÆ@E ¤ E¤ ÀEÆ@D ÇÄÁD A  ä@ Ì@F ä@ &     LoginfoUIS3GoBtn:BtnOnClickGameGlobal
GetModuleSeasonModule!CheckSeasonClose_ShowClientError
_seasonId_state       ToastManager
ShowToastStringTableGetstr_season_s1_main_btn_overGetUIModuleEnterCurrentSeasonMainUIUISeasonLocalDBHelperSeasonBtn_Set_constBtnNameNewSvrTimeModuleGetServerTimeü©ñÒMbP?Red_CheckPoint         4   _   _   _   _   b   b   b   b   c   c   c   c   c   d   g   g   g   h   h   h   h   h   h   h   i   l   l   l   l   l   l   m   m   m   m   m   n   n   n   n   n   n   n   o   o   o   o   o   o   p   p   q      self    4   seasonModule   4   now+   4      _ENV"                              	   
   	               '      )   /   )   3   <   3   >   R   >   T   X   T   ^   q   ^   q          _ENV