LuaS 

xV           (w@P@../PublishResources/lua/product/components/ui/season/s4/theme/ui_s4_go_btn.lua         "    @ A@  @ $@@@  @@ l   
@@@ l@  
@ @@ l  
@@@ lÀ  
@ @@ l  
@@@ l@ 
@ @@ l 
@@@ lÀ 
@ @@ l  
@&     _class
UIS4GoBtnUICustomWidgetOnShowOnHideSetData	_Refresh
_SetState	_CalcNew	_CalcRed_CheckPointBtnOnClick    	              F@@ GÀ À@ d L Á d 
@ &     _constBtnNameGameGlobalGetUIModuleSeasonModuleGetGoBtnKey                                       self          _ENV 	   
       &                 
      self                      
@ 
# @ @$ "   A bA    AA 
@LA ÇÁ@ dALÁA À dAâ    FB GAÂ  Á  AÂ  ÁB dA&     
_seasonId_componentComponentIsOpen_state              
_SetState	_RefreshUIWidgetHelperPlayAnimationInSequence_animuieffanim_UIS4_GoBtn_in                                                                                                                        self       	seasonId       
component       	playAnim       isOpen         _ENV    +    )    À   @    Ì@@ A  äÌÀÀ@ ä@¢@    &  Ì Á äÀ FAA GÁÁ À AB  ]dB ÁBÀ   @¤A AÃ ¤ ÆB ÇÃ   @ Â äA ÌD äA &      GetGameObject_topTip
SetActiveGetItemCountUIActivityHelperGetColorText#FFFFFF#F5B62F/UIWidgetHelperSetLocalizationText_text
GetItemIdSetItemIconSprite_icon_CheckPoint         )                                           #   #   $   $   $   $   $   $   $   $   $   %   %   %   %   %   %   '   '   (   (   (   (   (   (   *   *   +      self    )   
component    )   isShow   )   cur   )   ceil   )   str   )   itemId    )      _ENV -   /    
    @ A  ¤@_ÀÀ   A   ¤@&     GetGameObject_lock
SetActive               
   .   .   .   .   .   .   .   .   .   /      self    
   state    
        3   G    /   G @ b    G @ L@À d @ À@Ç A A ¤  ÆA ÇÀÁB ä Ì@Âä   b   â    FB GÁÂd  C  b   â    B CÀ¤ @ £  £A  £A   ¦ &     _componentComponentIsOpenUISeasonLocalDBHelperSeasonBtn_Has_constBtnNameNewGameGlobal
GetModuleSeasonModuleGetCurSeasonSampleUISeasonHelperTalentTreeNewTradeGameNew         /   8   8   8   8   8   8   :   :   :   :   :   :   ;   ;   ;   ;   ;   ;   <   =   =   =   =   >   >   >   >   >   B   C   C   C   C   D   D   D   D   D   F   F   F   F   F   F   F   F   G      self    /   isOpen   /   isNew   /   sample   /   
talentNew   /   	TradeNew   /      _ENV I   i    L   G @ b    G @ L@À d b@    f  @ À@Ç A A ¤ÆA ÇÀÁ @ ä@Æ@B ÌÂ@ ä@ ÁB$Á `   A   ã  À BC C$ ÂCD $BD$ FBC GÂÃD d LÂÄd   b   b   ÆE ÇBÅ ä Ã  b   b   E E@$ À #C #C  #C    & &     _componentComponentIsOpenUISeasonLocalDBHelperSeasonBtn_Get_constBtnNameRedLogdebug!UIS4GoBtn:_CalcRed() lastTime = HelperProxyIsCrossDayToGetItemCount        GameGlobal
GameLogic
GetModuleSeasonTaskModuleTaskListRedSeasonModuleGetCurSeasonSampleUISeasonHelperTalentTreeRedTradeGameRed         L   J   J   J   J   J   J   K   K   L   P   P   P   P   P   Q   Q   Q   Q   Q   R   R   R   R   T   T   T   U   U   U   U   W   W   W   Z   Z   Z   Z   Z   Z   Z   Z   \   \   \   \   \   \   ]   ^   ^   ^   ^   _   _   _   _   _   c   d   d   d   d   e   e   e   e   e   h   h   h   h   h   h   h   h   i      self    L   isOpen   L   	lastTime   L   isCross   L   cur   L   ceil   L   	haveItem   L   
isCoinRed!   L   
isTaskRed)   L   sample/   L   
talentRed0   L   	TradeRed:   L      _ENV k   o    	   L @ d @@ ¤ Æ@ ÇÀÀ   @  Á B ä@ &     	_CalcNew	_CalcRedUIWidgetHelperSetNewAndReds_new_red            l   l   m   m   n   n   n   n   n   n   n   n   o      self       new      red         _ENV u       4   F @ G@À   d@ FÀ@ G Á @A d Á ÁA ¤¢     &   B @BÀB ÀBÆ C Ç@Ã ä  ¤@  &  À@ ÀCÆ@A ¤  D¤@ @D DÇÀD  ¤@À@  AÆ@E ¤ E¤ ÀEÆ@D ÇÄÁD A  ä@ Ì@F ä@ &     LoginfoUIS4GoBtn:BtnOnClickGameGlobal
GetModuleSeasonModule!CheckSeasonClose_ShowClientError
_seasonId_state       ToastManager
ShowToastStringTableGetstr_season_s1_main_btn_overGetUIModuleEnterCurrentSeasonMainUIUISeasonLocalDBHelperSeasonBtn_Set_constBtnNameNewSvrTimeModuleGetServerTimeü©ñÒMbP?Red_CheckPoint         4   v   v   v   v   y   y   y   y   z   z   z   z   z   {   ~   ~   ~                                                                                                               self    4   seasonModule   4   now+   4      _ENV"                              	   
   	               +      -   /   -   3   G   3   I   i   I   k   o   k   u      u             _ENV