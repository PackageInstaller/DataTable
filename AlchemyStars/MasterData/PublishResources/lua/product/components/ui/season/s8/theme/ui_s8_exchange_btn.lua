LuaS 

xV           (w@V@../PublishResources/lua/product/components/ui/season/s8/theme/ui_s8_exchange_btn.lua         +    @ A@  @ $@@@  @@ l   
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
@ &     _classUIS8ExchangeBtnUICustomWidgetOnShowOnHideSetData	_Refresh
_SetState_SetIconText	_CalcNew	_CalcRed_CheckPointBtnOnClick_AttachEvents_DetachEvents                  L@@ d 
@ L@ d@ &     _constBtnNameGetName_AttachEvents                                self            
          L @ d@ &     _DetachEvents                       self                      
@ 
# @ @$ "   A bA    AA 
@LA ÇÁ@ dALÁA dA â   Àÿ&     
_seasonId_componentComponentIsOpen_state              
_SetState	_Refresh                                                                             self       	seasonId       
component       	playAnim       isOpen              )       G @ @À   &  G @ LÀ Ã  d @ @  ¤ÌÀ@ @  ÁA ä@ÌÀ@ @  ÁÁ ä@Ì B ä@ &  	   _component GetCostItemId_SetIconText_icon1_text1_icon2_text2_CheckPoint                       !   $   $   $   $   $   $   $   $   %   %   %   %   %   &   &   &   &   &   (   (   )      self       id1      id2           +   -    
    @ A  ¤@_ÀÀ   A   ¤@&     GetGameObject_over
SetActive               
   ,   ,   ,   ,   ,   ,   ,   ,   ,   -      self    
   state    
        /   5         AA   ]@ Á@À    @ ¤A@ AÀ    @¤A &     UICommon.spriteatlas	toptoon_UIWidgetHelperSetImageSpriteSetItemCount            0   1   1   1   3   3   3   3   3   3   3   4   4   4   4   4   4   5      self       itemId       widgetIcon       widgetText       
atlasName      spriteName         _ENV 9   A       F @ G@À @ ÁÀ  d[  f  &     UISeasonLocalDBHelperSeasonBtn_Has_constBtnNameNew            ?   ?   ?   ?   ?   ?   @   A      self       isNew         _ENV C   F       G @ b    G @ L@À d f  &     _componentHaveRedPoint           D   D   D   D   D   D   E   F      self       isRed           H   L    	   L @ d @@ ¤ Æ@ ÇÀÀ   @  Á B ä@ &     	_CalcNew	_CalcRedUIWidgetHelperSetNewAndReds_new_red            I   I   J   J   K   K   K   K   K   K   K   K   L      self       new      red         _ENV R   d    $   F @ G@À   d@ FÀ@ G Á @A d Á ÁA ¤¢     &   B @BÀB ÀBÆ C Ç@Ã ä  ¤@  &  ÀC  DÇ@D  ¤@ÀD ¤@  E @E¤@ &     LoginfoUIS8ExchangeBtn:BtnOnClickGameGlobal
GetModuleSeasonModule!CheckSeasonClose_ShowClientError
_seasonId_state       ToastManager
ShowToastStringTableGetstr_season_s1_main_btn_overUISeasonLocalDBHelperSeasonBtn_Set_constBtnNameNew_CheckPointUISeasonHelperShowCurSeasonExchange         $   S   S   S   S   V   V   V   V   W   W   W   W   W   X   [   [   [   \   \   \   \   \   \   \   ]   `   `   `   `   `   a   a   c   c   c   d      self    $   seasonModule   $      _ENV j   m       L @ Æ@@ ÇÀÁ@ d@ &     AttachEventGameEventTypeItemCountChanged	_Refresh            l   l   l   l   l   m      self          _ENV o   q       L @ Æ@@ ÇÀÁ@ d@ &     DetachEventGameEventTypeItemCountChanged	_Refresh            p   p   p   p   p   q      self          _ENV+                              
      
               )      +   -   +   /   5   /   9   A   9   C   F   C   H   L   H   R   d   R   j   m   j   o   q   o   q          _ENV