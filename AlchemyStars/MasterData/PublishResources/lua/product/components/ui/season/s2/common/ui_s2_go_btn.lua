LuaS 

xV           (w@Q@../PublishResources/lua/product/components/ui/season/s2/common/ui_s2_go_btn.lua         "    @ A@  @ $@@@  @@ l   
@@@ l@  
@ @@ l  
@@@ lÀ  
@ @@ l  
@@@ l@ 
@ @@ l 
@@@ lÀ 
@ @@ l  
@&     _class
UIS2GoBtnUICustomWidgetOnShowOnHideSetData	_Refresh
_SetState	_CalcNew	_CalcRed_CheckPointBtnOnClick    	              F@@ GÀ À@ d L Á d 
@ &     _constBtnNameGameGlobalGetUIModuleSeasonModuleGetGoBtnKey                                       self          _ENV 	   
       &                 
      self                   	   
@ 
ã  @ Ì@ä Á@ A@  A Á $ LÁAÌB ä dA  â    A bA    AÁ 
@LC ÇAB dALAC À dA&     
_seasonId_componentComponentIsOpenUIWidgetHelperSpawnObject_iconGroupUIS2BtnIconSetDataGetName_state              
_SetState	_Refresh                                                                                                         self       	seasonId       
component       isOpen      obj         _ENV    *    )    À   @    Ì@@ A  äÌÀÀ@ ä@¢@    &  Ì Á äÀ FAA GÁÁ À AB  ]dB ÁBÀ   @¤A AÃ ¤ ÆB ÇÃ   @ Â äA ÌD äA &      GetGameObject_topTip
SetActiveGetItemCountUIActivityHelperGetColorText#FFFFFF#F5B62F/UIWidgetHelperSetLocalizationText_text
GetItemIdSetItemIconSprite_icon_CheckPoint         )                                          "   "   #   #   #   #   #   #   #   #   #   $   $   $   $   $   $   &   &   '   '   '   '   '   '   )   )   *      self    )   
component    )   isShow   )   cur   )   ceil   )   str   )   itemId    )      _ENV ,   1        @ A  ¤@_ÀÀ   A   ¤@ÀÀ    ¢@    @ ÌA AÁ  ä Ê&  
   GetGameObject_lock
SetActive             à?       GetUIComponentCanvasGroup_alphaGroupalpha           -   -   -   -   -   -   -   -   -   .   .   .   .   .   .   /   /   /   /   0   1      self       state       alpha      obj           5   >       G @ b    G @ L@À d @ À@Ç A A ¤  ã    À  æ  &     _componentComponentIsOpenUISeasonLocalDBHelperSeasonBtn_Has_constBtnNameNew            :   :   :   :   :   :   <   <   <   <   <   <   =   =   =   =   >      self       isOpen      isNew         _ENV @   U    7   G @ b    G @ L@À d b@    f  @ À@Ç A A ¤ÆA ÇÀÁ @ ä@Æ@B ÌÂ@ ä@ ÁB$Á `   A   ã  À BC C$ ÂCD $BD$ FA GÄÂ À @C À dBcB  @ f &     _componentComponentIsOpenUISeasonLocalDBHelperSeasonBtn_Get_constBtnNameRedLogdebug!UIS2GoBtn:_CalcRed() lastTime = HelperProxyIsCrossDayToGetItemCount        GameGlobal
GameLogic
GetModuleSeasonTaskModuleTaskListRedinfo UIS2GoBtn:_CalcRed() isCross = , isCoinRed = , isTaskRed =          7   A   A   A   A   A   A   B   B   C   G   G   G   G   G   H   H   H   H   H   I   I   I   I   K   K   K   L   L   L   L   N   N   N   Q   Q   Q   Q   Q   Q   Q   Q   S   S   S   S   S   S   S   S   S   T   T   T   T   U   	   self    7   isOpen   7   	lastTime   7   isCross   7   cur   7   ceil   7   	haveItem   7   
isCoinRed!   7   
isTaskRed)   7      _ENV W   [    	   L @ d @@ ¤ Æ@ ÇÀÀ   @  Á B ä@ &     	_CalcNew	_CalcRedUIWidgetHelperSetNewAndReds_new_red            X   X   Y   Y   Z   Z   Z   Z   Z   Z   Z   Z   [      self       new      red         _ENV a   t    4   F @ G@À   d@ FÀ@ G Á @A d Á ÁA ¤¢     &   B @BÀB ÀBÆ C Ç@Ã ä  ¤@  &  À@ ÀCÆ@A ¤  D¤@ @D DÇÀD  ¤@À@  AÆ@E ¤ E¤ ÀEÆ@D ÇÄÁD A  ä@ Ì@F ä@ &     LoginfoUIS2GoBtn:BtnOnClickGameGlobal
GetModuleSeasonModule!CheckSeasonClose_ShowClientError
_seasonId_state       ToastManager
ShowToastStringTableGetstr_season_s1_main_btn_overGetUIModuleEnterCurrentSeasonMainUIUISeasonLocalDBHelperSeasonBtn_Set_constBtnNameNewSvrTimeModuleGetServerTimeü©ñÒMbP?Red_CheckPoint         4   b   b   b   b   e   e   e   e   f   f   f   f   f   g   j   j   j   k   k   k   k   k   k   k   l   o   o   o   o   o   o   p   p   p   p   p   q   q   q   q   q   q   q   r   r   r   r   r   r   s   s   t      self    4   seasonModule   4   now+   4      _ENV"                              	   
   	               *      ,   1   ,   5   >   5   @   U   @   W   [   W   a   t   a   t          _ENV