LuaS �

xV           (w@K@../PublishResources/lua/product/core_game/share/sys/mirage_end_system.lua         .    @ A@  $@ �@ A�  � A $@��@  ���@ l   
@���@ l@  
@ ��@ l�  
@���@ l�  
@ ��@ l  
@���@ l@ 
@ ��@ l� 
@���@ l� 
@ ��@ l  
@���@ l@ 
@ ��@ l� 
@���@ l� 
@ �& �    requiremain_state_sys_classMirageEndSystemMainStateSystem_GetMainStateID_OnMainStateEnter_IsMirageForceEnd_DoLogicForceCastTrapSkill_DoLogicSwitchMainFsmState_DoLogicMirageCastTrapDieSkill_DoLogicMirageBossReturn _DoRenderMirageClearWarningArea_DoRenderForceCastTrapSkill _DoRenderMiragePlayTrapDieSkill_DoRenderMirageBossReturn_DoRenderMirageEndUI                  F @ G@� f  & �    GameStateID
MirageEnd                           self          _ENV    :    -   � @ �� �   � ��@@ �@ & � ̀@ @� �@���@ @� �@�� A � �   @�AA $� L�A ��   dA @ $� "  � �LA@ dA & � L�A d� �B  � @��A �AB �� ́B @� � �A �A@ �A & �    _IsBattleEnd_DoLogicSwitchMainFsmState_DoRenderMirageEndUI _DoRenderMirageClearWarningArea_IsMirageForceEnd_DoLogicForceCastTrapSkill_DoRenderForceCastTrapSkill_DoLogicMirageCastTrapDieSkill _DoRenderMiragePlayTrapDieSkill_DoLogicMirageBossReturn_DoRenderMirageBossReturn        -                                          !   !   "   "   $   $   %   %   %   %   )   )   *   *   +   +   ,   1   1   2   2   2   2   6   6   7   7   7   7   9   9   :      self    -   TT    -   battleResult   -   isForceEnd   -   eTraps      battleResult   -   eTraps    -   bossEntity&   -        <   @       G @ L@� ��  d����� �  �   & �    _worldGetServiceMirageLogicIsMirageForceClose           >   >   >   >   ?   ?   ?   @      self       
mirageSvc           B   G       G @ L@� ��  d����� �  �   & �    _worldGetServiceMirageLogicDoMirageCastTrapSkill           D   D   D   D   F   F   F   G      self       
mirageSvc           I   O       G @ L@� d� L�� ��@ � �  d@ G @ L@� d� L�� ��@ �@�� d@ G @ L�� �  d���@� �@ & � 
   _worldEventDispatcher	DispatchGameEventTypeBanAutoFightBtnMirageEndFinish       GetServiceMirageLogicSetMirageOver            J   J   J   J   J   J   J   J   K   K   K   K   K   K   K   K   M   M   M   M   N   N   O      self       
mirageSvc         _ENV Q   U       G @ L@� ��  d����� �  �   & �    _worldGetServiceMirageLogicDoMirageCastTrapDieSkill           S   S   S   S   T   T   T   U      self       
mirageSvc           W   [       G @ L@� ��  d����� �  �   & �    _worldGetServiceMirageLogicDoMirageBossReturn           Y   Y   Y   Y   Z   Z   Z   [      self       
mirageSvc           ^   _       & �                _      self       TT            a   b       & �                b      self       TT       eTraps            d   e       & �                e      self       TT       eTraps            g   h       & �                h      self       TT       bossEntity            j   k       & �                k      self       TT           .                        	   	               :      <   @   <   B   G   B   I   O   I   Q   U   Q   W   [   W   ^   _   ^   a   b   a   d   e   d   g   h   g   j   k   j   k          _ENV