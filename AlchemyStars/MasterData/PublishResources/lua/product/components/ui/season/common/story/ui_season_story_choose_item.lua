LuaS 

xV           (w@c@../PublishResources/lua/product/components/ui/season/common/story/ui_season_story_choose_item.lua             @ A@  @ $@@@  @@ l   
@@@ l@  
@ @@ l  
@@@ lΐ  
@ @@ l  
@@@ l@ 
@ &  	   _classUISeasonStoryChooseItemUICustomWidgetOnShowActiveSetDataSetNewStatus
BgOnClickInitButtonClickAnim                  @@   AΑ  € 
 @@ A A € 
 @@  AA € 
ΐB  €
 ΐB € 
ΐB Α €
  D A A €@ &     _textGetUIComponentUILocalizationTexttext
_layoutRtRectTransformlayout_anim
Animationanim_typeGoGetGameObjecttypeGo_go_newNewInitButtonClickAnimBgselect                                         	   	   	   	   	                                                      self       	uiParams                       @ @@  €@&     _go
SetActive                             self       active               '    
(   
@ 
ΐG@ LΑΐΐ dAC  "    C A AA €A@ A @B ΖB Β AΒ δΑ@ AC@ ΖΑC ΗΔΗAΔΑ@ D@ ΖΑC ΗΔΗΑΔΑ&     _idx
_callback_textSetText_typeGo
SetActivepreferredWidthB      
_layoutRt
sizeDeltaVector2d       resizeTextForBestFitverticalOverflowUnityEngineVerticalWrapMode	Truncate 	Overflow         (                                                                                 !   !   "   "   "   "   "   "   $   $   %   %   %   %   %   '      self    (   idx    (   txt    (   	callback    (   type    (   	showType   (      _ENV )   +        @ @@  €@&     _new
SetActive           *   *   *   *   +      self       status            -   8        @ ,  €@&     
StartTask         .   6       E   L ΐ Α@  d@F@ Lΐΐ Α@  d@F Α    Α@ d@FA b    FA ΐA d@ E   L Β Α@  d@&  	   Lock)uianim_UISeasonStoryChooseItem_xuanzhong_animPlayYIELD      
_callback_idxUnLock             /   /   /   /   0   0   0   0   1   1   1   1   2   2   2   3   3   3   5   5   5   5   6      TT          self_ENV   .   6   .   8      self       go          _ENV :   K    
   Μ @ @ δ@  $LA@ Ζ@ ΗΑΐ δ A BAl  dALA@ Ζ@ ΗΑΐ δ A AlB  dA&     GetGameObjectAddUICustomEventListenerUICustomUIEventListenerGetUIEventPressRelease         @   B       E   L ΐ Γ  d@&     
SetActive          A   A   A   A   B      go          
clickedGo G   I       E   L ΐ Γ   d@&     
SetActive          H   H   H   H   I      go          
clickedGo   ;   ;   ;   <   <   <   =   >   >   >   >   ?   ?   B   =   D   E   E   E   E   F   F   I   D   K      self       btnName       clickedGoName       btnGo      
clickedGo         _ENV                                          '      )   +   )   -   8   -   :   K   :   K          _ENV