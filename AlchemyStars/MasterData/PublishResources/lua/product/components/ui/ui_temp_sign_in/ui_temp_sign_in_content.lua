LuaS 

xV           (w@[@../PublishResources/lua/product/components/ui/ui_temp_sign_in/ui_temp_sign_in_content.lua         1    @ A@  $@ @ Aΐ   A $@ΐ@  ΐ@ l   
@ΐ@ l@  
@ ΐ@ l  
@ΐ@ lΐ  
@ ΐ@ l  
@ΐ@ l@ 
@ ΐ@ l 
@ΐ@ lΐ 
@ ΐ@ l  
@ΐ@ l@ 
@ ΐ@ l 
@ΐ@ lΐ 
@ ΐ@ l  
@&     require"ui_side_enter_center_content_base_classUITempSignInContentUISideEnterCenterContentBaseDoInitDoShowDoHide
DoDestroy	_Refresh_SetItemDatas_InitScrollPos_CheckCanGetIndex
_SetItemsGetAwardReq_AttachEvent_DetachEventOnUIGetItemCloseInQuest           	    	   F@@ Gΐ    Αΐ   G@ d
@ &     _matReqUIWidgetHelperSetLocalizedTMPMaterial	_descTmpUITempSignIn_Material.mat         	                           	      self    	      _ENV           L @ d@ L@ Ζΐ@ d
@Kΐ  @A AJΐA@A  BJ@B@A BJΐB
@ L C d@ &     _AttachEvent_signInModule
GetModuleSignInModuleresult2strSIGN_IN_RESULT_CODESIGN_DAY_NUM_ERROR$str_temp_sign_in_SIGN_DAY_NUM_ERRORSIGN_DAY_NUM_ACCEPTED'str_temp_sign_in_SIGN_DAY_NUM_ACCEPTEDSIGN_DAY_NUM_NOT_ENOUGH)str_temp_sign_in_SIGN_DAY_NUM_NOT_ENOUGH	_Refresh                                                                           self          _ENV           L @ d@ F@@ Gΐ    Αΐ  d@&     _DetachEventUIWidgetHelperClearWidgets	itemInfo                                       self          _ENV    !       F@@ Gΐ  @ d 
@ &     _matReqUIWidgetHelperDisposeLocalizedTMPMaterial                                !      self          _ENV %   2    	   @@ @€ 
  A € 
@A €@ ΐ@   ΖA ΗΐΑ   A AB BΑΑ   €δ@  b@  @ Μ C δ@ &     _currentDay_signInModuleGetTotalSignInDayNum_itemDatas_SetItemDatas
_SetItemsUIWidgetHelperSetLocalizedTMPText	_descTmpStringTableGetstr_temp_sign_in_title_InitScrollPos            '   '   '   '   )   )   )   *   *   ,   ,   -   -   -   -   -   -   -   -   -   -   /   /   0   0   2      self       notMove       maxDay         _ENV 4   D       K    @ @@€ΐ @ @ $@K  JΒJΒJA ΒAΐ  €B)  ͺΑόf  &     _signInModuleGetNewPlayerSignupStatusipairsdaygot
awardListtableinsert            5   8   8   8   :   :   :   :   ;   <   =   >   >   @   @   @   @   @   :   :   C   D   
   self       tb_out      dayInfo      rewardInfo      (for generator)      (for state)      (for control)      index      value      item	         _ENV F   N       L @ d _@ΐ ΐ@ Α  A € Ξ@Α ΟΑB GΑAGAΒ$ &  
   _CheckCanGetIndex        GetUIComponentRectTransformContent              anchoredPositionVector2x            H   H   I   I   J   J   J   J   K   K   L   L   L   L   L   L   N      self       
canGetIdx      content      height
         _ENV P   T    
   K   @ @@k@ @ ΐ@ΐ  € ¦  &     NewPlayerLoginStatusNPLS_UnAcceptUITempSignInEnterCheckDayStatus         
   Q   Q   Q   Q   R   R   R   R   S   T      self    
   tb   
   idx   
      _ENV V   t    -   F @ G@ΐ    Α  Α  GA \NAΑd @ Aΐ   Α AΑ  € Ζ B Η@Β  @ δ@
@ ΖΐB B δ  A GB \_@  CB  C Γ  @ CC μ  ,D  l  €Bι  jϋ&     UIWidgetHelperSpawnObjectsContentUITempSignInItem_itemDatas       SpawnObjectlastDataPooltableinsert_itemsipairsSetData_currentDay         f   j    	   F @ @ΐ d @ΐ_    B   €Ai  κΐύ&     ipairs_itemsSetSelected             g   g   g   g   h   h   h   h   h   h   g   g   j      idx       (for generator)      (for state)      (for control)      i   
   v   
      _ENVself k   m       E   L ΐ ΐ   d@&     GetAwardReq           l   l   l   l   m      idx          self n   p        @ @@Ε    @   €@&     UIWidgetHelperSetAwardItemTips	itemInfo             o   o   o   o   o   o   o   p      matid       pos          _ENVself-   X   X   X   X   X   X   X   X   X   [   [   [   [   [   [   \   \   \   \   \   ^   _   _   _   _   `   `   a   a   a   a   a   a   b   c   d   e   j   m   p   r   b   _   _   t   
   self    -   items	   -   	lastItem   -   (for generator)   ,   (for state)   ,   (for control)   ,   i   *   v   *   	itemData   *   
isLastDay!   *      _ENV v           @ @@Α  €@ 
@ A A €@A ,  €@&     Logdebug3###[UITempSignInContent] temp sign in get reward !_getIdxLock UITempSignInContent:GetAwardReq
StartTask         {       7   F @ @@ G @ ΐ@   GΑ € Ε   Μ@ΑA δ@ΜΐAδ β   @Ζ Β Η@Β δ@ Ζ Γ Η@ΓJΐΖΓ ΗΐΓδ Μ ΔFAΔ GΔΑ δ@ ΖΐD  Η Μ Ε@ δ@ΐΜ@Eδ Β EAΑ $AF Α FAΖ GΖΑΖ Gΐ € dA  &     _itemDatas_getIdx_signInModuleRequestAcceptNewPlayerRewarddayUnLock UITempSignInContent:GetAwardReqGetSuccLogdebug ###[UITempSignInContent] succ !gotNewPlayerLoginStatusNPLS_AcceptedGameGlobalEventDispatcher	DispatchGameEventTypeOnTempSignInAwardGot_itemsOnAwardGot
GetResulterror5###[UITempSignInItem] getOnClick fail -- result --> result2strToastManager
ShowToastStringTableGet          7   |   |   |   }   }   }   }   }   ~   ~   ~   ~                                                                                                                                       TT    7   data   7   res   7   result(   6   	toastStr/   6      self_ENVidx   w   w   w   w   x   y   y   y   z      z         self       idx          _ENV           L @ Ζ@@ Ηΐ@ d@ &     AttachEventGameEventTypeOnUIGetItemCloseInQuest                                 self          _ENV           L @ Ζ@@ Ηΐ@ d@ &     DetachEventGameEventTypeOnUIGetItemCloseInQuest                                 self          _ENV           L @ Γ  d@&     	_Refresh                          self           1                                 	                           !      %   2   %   4   D   4   F   N   F   P   T   P   V   t   V   v      v                                        _ENV