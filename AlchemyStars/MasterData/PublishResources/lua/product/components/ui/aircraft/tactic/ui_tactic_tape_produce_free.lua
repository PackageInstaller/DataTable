LuaS 

xV           (w@@C:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/lua/product/components/ui/aircraft/tactic/ui_tactic_tape_produce_free.lua             @ A@  @ $@@@  @@ l   
@@@ l@  
@ @@ l  
@@@ lΐ  
@ @@ l  
@@@ l@ 
@ @@ l 
@@@ lΐ 
@ &     _classUITacticTapeProduceFreeUIControllerOnShowOnHidetickInitWidgetcancelBtnOnClickokBtnOnClick	makeFreeblankOnClick               	*    @ €@ @ Α@ €
@@ @AA ΑA€
 @ AB €
 B ΐBC ACA A ΑC€ ΗA ΜΔδ $  €@  D ΐD€ 
@D  EA A ¬  €@ΐE €@ &     InitWidget_airModule
GetModuleAircraftModule_tacticRoomGetRoomByRoomTypeAirRoomTypeTacticRoom_timeModuleSvrTimeModuletimesSetTextStringTableGet$str_aircraft_tactic_free_make_countGetWeeklyFreeMakeCountGetWeeklyFreeMakeLimit_timerHolderUITimerHolderNewStartTimerInfinite
Countdownθ      tick                        @ $@ &     tick                              self*                                       	   	   	   	                                                                                    self    *   	uiParams    *      _ENV           G @ L@ΐ d@ &     _timerHolderDispose                          self            !   (       F @ G@ΐ @ ΐ@€  Ad @A A€ ΐAB AB$ A €ΗB _ 
 ΗΐB Μ ΓFAC GΓΑ ΐ dδ@  &     mathfloor_timeModuleGetServerTimeθ      HelperProxyGetInstanceFormatTime_3_tacticRoomGetNextResetTime	_timeStr
countdownSetTextStringTableGet#str_aircraft_tactic_free_make_time            "   "   "   "   "   "   "   #   #   #   #   #   #   #   #   #   $   $   $   %   &   &   &   &   &   &   &   &   (      self       now      timeStr         _ENV *   1       L@@ Α    d 
@ L@@ Α  Α  d 
@&     timesGetUIComponentUILocalizationText
countdown           -   -   -   -   -   /   /   /   /   /   1      self            2   4        @ €@ &     CloseDialog           3   3   4      self       go            5   K    %    @ @@€   Η @ Μΐδ ΐ Η @ Μΐΐδ Ξ Αΐ @Ζ@A ΗΑΑ FB GAΒB ΑBΑ BC CAΒ $ l    μB    δ@ ΐ Μ D GAD   δ@ &     _tacticRoomGetCartridgeListGetCartridgeGiftCountGetCartridgeLimit       PopupManagerAlertUICommonMessageBoxPopupPriorityNormalPopupMsgBoxType	OkCancelStringTableGet#str_aircraft_tactic_free_make_tip2
StartTask	makeFree         >   A       E   L ΐ Ζ@@   d@ &     
StartTask	makeFree           @   @   @   @   @   A      param          self C   E       &                 E      param           %   6   6   6   6   6   6   6   6   7   7   7   7   7   7   8   8   9   :   :   ;   ;   <   =   =   =   =   A   B   E   G   8   G   I   I   I   I   K      self    %   go    %   count   %      _ENV M   Z    1    @ A@ $ €@  @ ΐ@  €Μ A LA@ d δ@  Μ@Aδ β   ΖA ΗΐΑB ABA $ δ@  ΖΐB Η Γδ Μ@ΓFC GΑΓδ@ΖΐB Η Γδ Μ@ΓFC GΔAD D€ δ@  ΜΐD δ@  Η@ Μ ΕLAEd δ@  &     LockGetName_airModuleRequestMakeCartridgeFreeUnLockGetSuccToastManager
ShowToastStringTableGet&str_aircraft_tactic_free_make_successGameGlobalEventDispatcher	DispatchGameEventTypeAircraftTacticRefreshTapeListAircraftRefreshRoomUI_tacticRoomSpaceIdCloseDialogGetErrorMsg
GetResult         1   N   N   N   N   O   O   O   O   P   P   P   P   Q   Q   Q   Q   R   R   R   R   R   R   R   S   S   S   S   S   S   S   U   U   U   U   U   U   U   U   U   U   V   V   V   X   X   X   X   X   Z      self    1   TT    1   res   1      _ENV \   ^        @ €@ &     CloseDialog           ]   ]   ^      self       go                                                  !   (   !   *   1   *   2   4   2   5   K   5   M   Z   M   \   ^   \   ^          _ENV