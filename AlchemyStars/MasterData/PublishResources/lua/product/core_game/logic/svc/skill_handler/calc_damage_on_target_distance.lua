LuaS 

xV           (w@@E:/depot_matchsrpg/matchsrpg/b/1405/client/Assets/../PublishResources/lua/product/core_game/logic/svc/skill_handler/calc_damage_on_target_distance.lua             @ A@  $@ @ AÀ   A $@À@  À@ l   
@À@ l@  
@ À@ l  
@&     require
calc_base_class'SkillEffectCalc_DamageOnTargetDistanceSkillEffectCalc_BaseConstructorDoSkillEffectCalculator_CalculateSingleTarget        
          
@  @ @Á  ¤
&     _world_skillEffectServiceGetServiceSkillEffectCalc                                   self       world               I    G      
@@
À@Ç A Ì@ÁGÁ äÁÁ $ GÂ AÂ¤ ÇA ÌÂAÂ äC BC$FC LBÃÀ dÂÃD CDA  ÌÃÄä ÌÅä DÅ$ FE GÄÅ ¤ÇA ÌÆä CÆÆE ÇÆ  D   À «D $FÃF  dG   @¤ ¢   ÆDG ÇÇ	  @ 	äDi  êü¦  &     _curPos _gridRingNum        _worldGetEntityByIDcasterEntityIDGetCenterPosskillEffectParamGetTargetCountGetServiceUtilScopeCalcSkillScopeCalculatorNew SkillScopeCalculator_FullScreen
CalcRangeSkillScopeTypeFullScreen       	BodyAreaGetAreaGetGridDirectionSkillTargetTypeBoardGetSkillScopeTargetSelectorDoSelectSkillTargetNearestMonsterOneByOneipairs_CalculateSingleTargettableappendArray         G                                #   $   $   '   '   '   '   (   (   (   (   )   )   )   )   -   .   .   /   0   1   1   1   1   2   2   3   3   5   -   7   7   7   9   :   ;   ;   <   =   =   >   >   9   A   A   A   A   B   B   B   B   C   C   D   D   D   D   D   A   A   H   I      self    G   skillEffectCalcParam    G   results   G   	attacker   G   
centerPos	   G   skillDamageParam
   G   targetCount   G   utilScopeSvc   G   skillCalculater   G   fullScreenCalc   G   platformScopeResult'   G   targetSelector*   G   targetArray4   G   (for generator)7   E   (for state)7   E   (for control)7   E   _8   C   	targetID8   C   result<   C      _ENV L   ¡    w   Ç À A@ @ $À@ÀFA GAÁ À dAGÁA LÂÄ  B A  d À«A ¦ GA@ LÀÇÁÂ dÃ¤ ÌAÃä Ã$ LÂÃd Ä¤ BD¤ ÌDFÃD GÅäCÅ À@À  GÅ +C J C@ ÃE $GCÆ Å ÇF âC    
@ÌÃFä D@ ÄE $LDGÇF  d G D	

ÀG D	ÇD@ ÌÄÅ	AÅ äÈ	À    @ 	$E ÅA LEH
À @  ÇÈ  FÇD GÅdÅ ÌÅÈ	@  À äEÌB
@  À
  @ä  FI GFÉ ÀdF& &  &   skillEffectParam_worldGetEntityByID Lognotice+CalculationForeachTarget defender is null _skillEffectServiceNewSkillDamageEffectResultÿÿÿÿÿÿÿÿ        casterEntityIDGetSkillIncreaseTypeGetSkillEffectDamageStageIndexGetBaseValueGetChangeValueSkillContextGetResultContainerGetEffectResultsAsArraySkillEffectTypeDamageskillRangegridPosGetServiceFormula
attackPos_curPosGetGridPosition	UtilCalcGetGridRingNum_gridRingNum
BuffLogicChangeSkillIncreaseComputeSkillDamageskillIDRemoveSkillIncreasetableinsert         w   N   R   R   R   R   S   S   T   T   T   T   T   V   V   V   V   V   V   V   W   W   W   W   \   \   \   \   ]   ]   ^   ^   _   _   `   `   d   d   d   d   e   e   e   e   g   g   g   h   h   h   h   l   l   l   l   m   n   q   q   q   r   t   t   w   w   w   w   x   x   x   x   y   y   y   |   ~   ~   ~                                                                                                                               ¡      self    w   skillEffectCalcParam    w   defenderEntityID    w   skillDamageParam   w   	defender   w   skillResult      	attacker   w   modifySkillIncreaseType   w   damageStageIndex   w   
baseValue!   w   changeValue#   w   skillEffectResultContainer'   w   damageResultArray+   w   formulaService6   w   
attackPos7   w   gridPos8   w   
targetPos>   w   utilCalcSvcB   w   currentRingNumF   w   damageParamM   w   buffLogicSvcQ   w   effectCalcSvcX   w   nTotalDamagec   w   listDamageInfoc   w   skillResulto   w   skillResultListp   w      _ENV                              
      
      I      L   ¡   L   ¡          _ENV