LuaS 

xV           (w@c@../PublishResources/lua/product/components/ui/season/common/tasklist/ui_season_task_list_navi.lua         :    @ A@  @ $@@@  @@ l   
@@@ l@  
@ @@ l  
@@@ lΐ  
@ @@ l  
@@@ l@ 
@ @@ l 
@@@ lΐ 
@ @@ l  
@@@ l@ 
@ @@ l 
@@@ lΐ 
@ @@ l  
@@@ l@ 
@ @@ l 
@@@ lΐ 
@ @@ l  
@&     _classUISeasonTaskListNaviUICustomWidget_GetAnimInfoOnShowOnHide	_Refresh_CheckShow	_SetShow_SetActive
_SetTitle	_SetDesc_BrowseTaskBtnOnClick_AttachEvent_DetachEventOnSeasonTaskResetOnSeasonTaskRefreshedOnSeasonModeChangedOnAfterUIRootActive        	       
    @ @@Η@ Α  έ A AA$ €@  &     Log
exception_className$εΏι‘»ιε _GetAnimInfo() ζΉζ³:debug
traceback         
   
   
   
   
   
   
   
   
   
         self    
   key    
      _ENV           @@ @€ ΐ@A €
 @A €@ A €@ ΐA  €Μ@B FB GΑΒ d C ACμ  δ@&     _seasonTaskModuleGameGlobal
GameLogic
GetModuleSeasonTaskModule	_Refresh_AttachEventGetGameObjectDescAddUICustomEventListenerUICustomUIEventListenerGetUIEventClick                   E   L ΐ d@ &     _BrowseTask                          go          self                                                                              self       	uiParams       obj         _ENV !   #       L @ d@ &     _DetachEvent           "   "   #      self            %   1       G @ b@    &  G@@ Lΐ d ΐ@  Aΐ  € Μ@A @ δ@ΜA @ δ@ΜΐA @ δ@&     view_seasonTaskModuleGetCurNodeUISeasonTaskListHelperGetCurQuestId_CheckShow
_SetTitle	_SetDesc            &   &   &   '   +   +   +   ,   ,   ,   ,   .   .   .   /   /   /   0   0   0   1      self       node      questId         _ENV 3   =    ,    @ @@Ζ@ € ΐ@€  A€ @A€ ΖA ΗΐΑ_ΐ   Γ@  Γ   Β   A   FAB GΒ d £ £   ΖΑB ΗΓB @  ΐΓ @  ΐδAΜAD @ δA&     GameGlobalGetUIModuleSeasonModuleSeasonManagerSeasonMapManagerModeSeasonMapModeMode2        UISeasonTaskListHelperCheckQuestFinLoginfo-UISeasonTaskListNavi:_CheckShow(), questId =isTravel =isHaveQuest =isFin =	_SetShow         ,   4   4   4   4   4   4   4   4   4   4   5   5   5   5   5   5   7   7   7   7   8   8   8   8   :   :   :   :   :   ;   ;   ;   ;   ;   ;   ;   ;   ;   ;   ;   <   <   <   =      self    ,   questId    ,   mode
   ,   	isTravel   ,   isHaveQuest   ,   isFin   ,   isShow   ,      _ENV ?   ^    ;    @    &  
@  @ @@  @    γ@   ΐ  β   b      "A    Α  l  A   €ΑBA A@ $ "B  ΐΒA  $BB BBA $B ΒB C@  B ΐ  @$B  $B ΐB ABA  $AΑA  $A&     _isShow inout_GetAnimInfostringisnullorempty_SetActiveLoginfo2UISeasonTaskListNavi:_SetShow(), play start, trueUIWidgetHelperPlayAnimation_anim5UISeasonTaskListNavi:_SetShow(), play false isShow =         I   O           F ΐ _@  ΐ @@@ Aΐ  $@ @@@ A   ΐ $@  @A  ΐ $@&     _isShowLoginfo7UISeasonTaskListNavi:_SetShow(), isShow was Change !!!;UISeasonTaskListNavi:_SetShow(), play stop, self._isShow =_SetActive             J   J   J   J   K   K   K   K   M   M   M   M   M   N   N   N   N   O          isShowself_ENV;   @   @   @   A   C   E   E   E   E   E   F   F   F   G   G   H   H   H   H   H   H   O   Q   Q   Q   R   R   R   R   R   R   S   S   S   T   T   T   T   V   V   V   V   V   V   V   V   V   X   X   Y   [   [   [   [   [   \   \   \   ^      self    ;   isShow    ;   change
   ;   play   ;   name   1   func   1   	animName   1   	duration   1      _ENV `   b        @ € @@  €@&     GetGameObject
SetActive           a   a   a   a   a   b      self       isShow            d   g        @ @@ΐ    €Ζΐ@ Η Α   AA  δ@ &     UISeasonTaskListHelperGetQuestText
QuestNameUIWidgetHelperSetLocalizationText
_txtTitle            e   e   e   e   e   f   f   f   f   f   f   g      self       questId       text         _ENV i   m        @ @@ΐ    €Μΐ@ A A δ Α $A&     UISeasonTaskListHelperGetQuestText
QuestDescGetUIComponentUIRichText	_txtDescSetText            j   j   j   j   j   k   k   k   k   l   l   l   m      self       questId       text      obj	         _ENV o   q       F @ G@ΐ d@ &     UISeasonTaskListHelper	GoToTask            p   p   p   q      self          _ENV s   u        @ €@ &     _BrowseTask           t   t   u      self       go            x   }       L @ Ζ@@ Ηΐ@ d@ L @ Ζ@@ ΗΐΐΑ@ d@ L @ Ζ@@ Η ΑA d@ &     AttachEventGameEventTypeOnSeasonTaskResetOnSeasonTaskRefreshedOnSeasonModeChanged            y   y   y   y   y   z   z   z   z   z   {   {   {   {   {   }      self          _ENV           L @ Ζ@@ Ηΐ@ d@ L @ Ζ@@ ΗΐΐΑ@ d@ L @ Ζ@@ Η ΑA d@ &     DetachEventGameEventTypeOnSeasonTaskResetOnSeasonTaskRefreshedOnSeasonModeChanged                                                               self          _ENV           L @ d@ &     	_Refresh                       self                      L @ d@ &     	_Refresh                       self                      L @ d@ &     	_Refresh                       self                      &                       self       flag       uiName           :                     	      	            !   #   !   %   1   %   3   =   3   ?   ^   ?   `   b   `   d   g   d   i   m   i   o   q   o   s   u   s   x   }   x                                                          _ENV