LuaS 

xV           (w@v@../PublishResources/lua/product/core_game/logic/svc/skill_handler/calc_sacrifice_target_nearest_traps_and_damage.lua             @ A@  @ $@@@  @@ l   
@@@ l@  
@ @@ l  
@&     _class5SkillEffectCalc_SacrificeTargetNearestTrapsAndDamageObjectConstructorDoSkillEffectCalculator_CalculateSingleTarget                  
@  @ @Α  €
&     _world_skillEffectServiceGetServiceSkillEffectCalc           
                        self       world                         Μ ΐ δ A@ @$L@ ΐ   d b   Β@ Aΐ  €B)  ͺό¦  &     GetTargetEntityIDsipairs_CalculateSingleTargettableinsert                                                                              
   self       skillEffectCalcParam       results      targets      (for generator)      (for state)      (for control)      _      	targetID      result         _ENV         %   Η ΐ A@ @ $LΑ@d A@ AB €ΗA@ ΜΑA δΒΑ$ LΒd BΒ @ €\ C@ @Β €Λ  ΔΒ$ "  ΐLΓd ΜDΓδ Γ	  ΑΔ D ED
 Λ   λE ΕΕΕ$LΕE
d F EF  LΖ@d  ΜΖ@δ Ζ @ 
ΗF Gΐ
€Ε F FGΐ   @
$FG GΖΗΐ dFLΘd DΘ€ ΐ 	Θ$ C
  Ε FD LEΔ
Λ  @+F ΚΚΕΚΚΕdΕΕ
€ Α  A θΗF ΜFΖ@ Η@€ ΐ Θ@$ GΖ 
ΖΘF ΗΗ 	 δΖ GF LGΗΐ  @ ΐ dG ΗGΐ €GηΕψΖΕH ΜEΔ@ ε ζ  &  $   skillEffectParam_worldGetEntityByIDGetGridPositionGetService	UtilDataUtilScopeCalcGetTrapLimitGetCheckTrapIDListSelectNearestTrapsOnPoscasterEntityIDGetMainBasePercentGetMainAddValueGetMainFormulaID d       SkillDamageEffectParamNewpercentaddPercent
formulaIDdamageStageIndex       GetSkillEffectDamageStageIndex_skillEffectServiceComputeSkillDamageskillIDSkillEffectType%SacrificeTargetNearestTrapsAndDamageNewSkillDamageEffectResulttableinsertGetBasePercentGetAddValueGetSacrificeFormulaID6SkillEffectSacrificeTargetNearestTrapsAndDamageResult            "   $   $   $   $   %   %   '   '   '   '   )   )   )   )   *   *   +   +   ,   ,   ,   ,   ,   -   /   /   /   /   1   4   4   5   5   6   6   8   9   9   :   :   ;   ?   ?   ?   A   A   A   A   B   C   D   ?   H   H   I   I   J   K   K   L   M   M   N   O   P   P   R   I   T   T   U   V   W   X   Z   T   [   [   [   [   [   _   _   `   `   b   c   c   d   d   e   i   i   i   k   k   k   k   l   m   n   i   r   r   s   s   s   s   t   t   u   v   v   w   x   x   y   z   {   {   }   t                                          s                        &   self       skillEffectCalcParam       	targetID       param      defenderEntity      defenderPos      utilSvc      utilScopeSvc      limitCount      checkTrapIDList      traps      findTrapPosList      trapIDs      
trapCount      casterEntity      damageResults      mainBasePercent       mainAddVal$   R   mainAddPercent%   R   mainFormulaID'   R   mainSkillDamageParam5   R   mainDamageStageIndex7   R   nMianTotalDamageE   R   mainListDamageInfoE   R   mainDamageResultM   R   basePercentT      addValV      addPercentW      curFormulaIDY      skillDamageParamg      damageStageIndexi      (for index)l      (for limit)l      (for step)l      im      nTotalDamage{      listDamageInfo{      damageResult         _ENV                                                            _ENV