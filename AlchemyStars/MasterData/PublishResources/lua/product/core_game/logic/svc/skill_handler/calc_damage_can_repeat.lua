LuaS 

xV           (w@@E:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/lua/product/core_game/logic/svc/skill_handler/calc_damage_can_repeat.lua             @ A@  $@ @ Aΐ   A $@ΐ@  ΐ@ l   
@ΐ@ l@  
@ ΐ@ l  
@ΐ@ lΐ  
@ ΐ@ l  
@&  
   require
calc_base_class SkillEffectCalc_DamageCanRepeatSkillEffectCalc_DamageConstructorDoSkillEffectCalculatorCalculateEffect_CalcDamageResultGetTargetIDByPos        
          
@  @ @Α  €
 @ @A €
 &     _world_skillEffectServiceGetServiceSkillEffectCalc_configServiceConfig                                                  self       world                   	    @ @@ΐ €Ηΐΐ A  ΗAΑ  %&  &     _worldGetEntityByIDcasterEntityIDskillIDCalculateEffectskillEffectParam                                                  self       skillEffectCalcParam       casterEntity      skillID              B    $S     Lΐ d LAΐd ΐ€ ΗΑ@ ΜΑ@ δ BΑ$ GΒA LΒΑB d
@
 K  
@GΒA LΓd LBΓΐ   @ d C€ ΜΒCδ D$ Lΐ d LCΐd CD ΐ €@ΗD	ΐΔ	 ΜE @ 	ΐ   @ ΐ  @ δD @ΖDD   	δΐE ΐ  @ ΐ   @ ΐ$F ι  jEό©  *Δφ& &     SkillContextGetResultContainerGetScopeResult_configServiceGetSkillConfigDataGetSkillTargetType_buffLogicSvc_worldGetService
BuffLogic_effectParam	_dampMapGetSkillScopeTargetSelectorDoSelectSkillTargetGetAttackRangeGetWholeGridRangeGetCenterPosipairs_classNameVector2_CalcDamageResult         S                      "   "   $   $   $   $   $   %   %   '   '   '   '   '   )   *   *   -   -   -   -   -   -   -   -   -   .   .   /   /   0   0   2   2   2   2   3   3   3   3   4   4   4   5   5   5   5   6   6   6   7   7   7   7   5   7   9   9   9   9   :   :   :   :   ;   ;   ;   <   <   <   <   :   9   9   3   3   A   B      self    S   casterEntity    S   skillEffectCalcParam    S   skillID    S   results   S   skillResult   S   scopeResult   S   skillConfigData   S   targetType   S   targetEntityIDArray   S   skillRange!   S   wholeRange#   S   scopeCenter%   S   skillEffectResultContainer)   S   (for generator),   Q   (for state),   Q   (for control),   Q   _-   O   targetGridPos-   O   (for generator)@   O   (for state)@   O   (for control)@   O   iA   M   posA   M      _ENV D   s    Y   Μ@ @  δ β  @C@ @Γΐ€ Λ  λC   @ ΜΑδ ΜDΑ	δ   @ $GA LΓΑd A B€ ΗA ΜCΒδ β  B Δ"D   B 
ΔΒ B GB GΔMD
DB Δ @ B 
C DCΖC ΗΔΓ	 GB GΕ
$D D  ΐ$ β  GC LDΔΐC ΕC
@dD"  GDb  ΐFΔD GΕΐ dDLDEΗDdD&     GetTargetIDByPosSkillEffectCalcParamNewGetIDGridLocationGetGridPos_effectParamGetDampPerGetDampMaxGetFinalEffectType	_dampMap        _buffLogicSvcChangeSkillFinalParamSkillEffectTypeDamageCanRepeat_CalculateSingleTargetRemoveSkillFinalParam       tableappendArrayAddEffectResult         Y   J   J   J   J   K   K   L   L   M   M   M   N   N   O   P   Q   R   R   R   R   S   T   V   L   W   W   W   X   X   X   Y   Y   Y   Z   Z   [   [   [   [   \   \   \   ^   ^   ^   ^   ^   `   `   `   `   a   a   c   c   d   e   e   f   g   h   c   j   j   j   j   k   k   l   l   l   l   l   l   l   n   n   n   n   n   o   o   o   o   o   p   p   p   s      self    Y   targetEntityIDArray    Y   pos    Y   casterEntity    Y   skillEffectCalcParam    Y   skillID    Y   skillRange    Y   scopeCenter    Y   wholeRange    Y   results    Y   skillEffectResultContainer    Y   	targetID   Y   
calcParam   X   dampPer   X   dampPerMax   X   finalEffectType!   X   resultB   X      _ENV u       /   Ζ @   δ @	B@ @$LΒ@d A€ ’  ΜBAδ @ @$@MDΑΗAΐ	 ΔΑΗΔAΐ	  ζ )  ͺΓό ΗΑA  ΗΒΑΓA   ζ ι  jΑυΔ   ζ  &     ipairs_worldGetEntityByIDGetGridPosition	BodyAreaGetAreaxy         /   v   v   v   v   x   x   x   x   z   z   {   {   |   |   }   }   ~   ~   ~   ~                                 ~   ~                                 v   v               self    /   targetIDList    /   pos    /   (for generator)   ,   (for state)   ,   (for control)   ,   i   *   	targetID   *   targetEntity   *   
targetPos
   *   bodyAreaComponent   *   bodyAreaArray       (for generator)       (for state)       (for control)       _      areaPos      gridPos         _ENV                              
      
               B      D   s   D   u      u             _ENV