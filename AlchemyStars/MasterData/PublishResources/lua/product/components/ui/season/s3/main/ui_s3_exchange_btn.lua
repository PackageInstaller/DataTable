LuaS 

xV           (w@U@../PublishResources/lua/product/components/ui/season/s3/main/ui_s3_exchange_btn.lua         +    @ A@  @ $@@@  @@ l   
@@@ l@  
@ @@ l  
@@@ lภ  
@ @@ l  
@@@ l@ 
@ @@ l 
@@@ lภ 
@ @@ l  
@@@ l@ 
@ @@ l 
@@@ lภ 
@ &     _classUIS3ExchangeBtnUICustomWidgetOnShowOnHideSetData	_Refresh
_SetState_SetIconText	_CalcNew	_CalcRed_CheckPointBtnOnClick_AttachEvents_DetachEvents                  L@@ d 
@ L@ d@ &     _constBtnNameGetName_AttachEvents                                self            
          L @ d@ &     _DetachEvents                       self                      
@ 
ใ  @ ฬ@ไ โ     "A    A 
 A ม@ $AมA $A &     
_seasonId_componentComponentIsOpen_state              
_SetState	_Refresh                                                                       self       	seasonId       
component       isOpen              %       G @ @ภ   &  G @ Lภ ร  d @ @  คฬภ@ @  มA ไ@ฬภ@ @  มม ไ@ฬ B ไ@ &  	   _component GetCostItemId_SetIconText_icon1_text1_icon2_text2_CheckPoint                                                       !   !   !   !   !   "   "   "   "   "   $   $   %      self       id1      id2           '   -        @ A  ค@_ภภ   A   ค@ @  ค@ภภ   A   ค@ภภ  @ ข@     ฬภA A A ไ ส &     GetGameObject_over
SetActive       _group      เ?       GetUIComponentCanvasGroup_alphaGroupalpha           (   (   (   (   (   (   (   (   (   )   )   )   )   )   )   )   )   )   *   *   *   *   *   *   +   +   +   +   ,   -      self       state       alpha      obj           /   5         AA   ]@ ม@ภ    @ คA@ Aภ    @คA &     UICommon.spriteatlas	toptoon_UIWidgetHelperSetImageSpriteSetItemCount            0   1   1   1   3   3   3   3   3   3   3   4   4   4   4   4   4   5      self       itemId       widgetIcon       widgetText       
atlasName      spriteName         _ENV 9   A       F @ G@ภ @ มภ  d[  f  &     UISeasonLocalDBHelperSeasonBtn_Has_constBtnNameNew            ?   ?   ?   ?   ?   ?   @   A      self       isNew         _ENV C   F       G @ b    G @ L@ภ d f  &     _componentHaveRedPoint           D   D   D   D   D   D   E   F      self       isRed           H   L    	   L @ d @@ ค ฦ@ วภภ   @  ม B ไ@ &     	_CalcNew	_CalcRedUIWidgetHelperSetNewAndReds_new_red            I   I   J   J   K   K   K   K   K   K   K   K   L      self       new      red         _ENV R   d    $   F @ G@ภ   d@ Fภ@ G ม @A d ม มA คข     &   B @BภB ภBฦ C ว@ร ไ  ค@  &  ภC  Dว@D  ค@ภD ค@  E @Eค@ &     LoginfoUIS3ExchangeBtn:BtnOnClickGameGlobal
GetModuleSeasonModule!CheckSeasonClose_ShowClientError
_seasonId_state       ToastManager
ShowToastStringTableGetstr_season_s1_main_btn_overUISeasonLocalDBHelperSeasonBtn_Set_constBtnNameNew_CheckPointUISeasonHelperShowCurSeasonExchange         $   S   S   S   S   V   V   V   V   W   W   W   W   W   X   [   [   [   \   \   \   \   \   \   \   ]   `   `   `   `   `   a   a   c   c   c   d      self    $   seasonModule   $      _ENV j   m       L @ ฦ@@ วภม@ d@ &     AttachEventGameEventTypeItemCountChanged	_Refresh            l   l   l   l   l   m      self          _ENV o   q       L @ ฦ@@ วภม@ d@ &     DetachEventGameEventTypeItemCountChanged	_Refresh            p   p   p   p   p   q      self          _ENV+                              
      
               %      '   -   '   /   5   /   9   A   9   C   F   C   H   L   H   R   d   R   j   m   j   o   q   o   q          _ENV