LuaS 

xV           (w@]@../PublishResources/lua/product/core_game/view/svc/instruction/play_common_be_hit_ins_r.lua             @ A@  $@ @ Aΐ   A $@ΐ@  ΐ@ l   
@ΐ@ l@  
@ ΐ@ l  
@  
@B
ΐB
@C
ΐCF D @ ΐ   d@&     requirebase_ins_r_classPlayCommonBeHitInstructionBaseInstructionConstructorDoInstruction_HandleBeHitTaskNone        Caster       
PickupPos       Maxc       _enumTurnToTargetType               2   @ΐ 
 ΐ@ Η Α € 
 ΐ@ ΗΑ € 
ΐ@ Η Β € 
ΐ@ ΗΒ € ’@    ΐ 
ΐ@ Η@Γ € ’@     
 ΐ@ Η Δ € ’@    ΐ 
@Δ ’   ΐ ΐ@ Η@Δ € 
 ΐ@ Η Ε € ’@    ΐ 
&     _hitAnimNamehitAnimName_hitEffectID	tonumberhitEffectID_turnToTargetturnToTarget_deathCleardeathClear_trapNotPlayHitEffecttrapNotPlayHitEffect        _waitBeHitFinishwaitBeHitFinish       _hitBackUseDamageIndexhitBackUseDamageIndexhitBackSpeed_hitBackSpeed_hitBackUseDamagePoshitBackUseDamagePos         2                     	   	   	   	   
   
   
   
                                                                                                                  self    2   
paramList    2      _ENV    W       @$ LA@Α  dΑ@€ A€ ΜAAδ Α$ _ΐA@   B  &  LBBΐ dΒ€ ΜΒΒδ Γ$ LCCΖC ΗΓΓ  d DC ΔC€ΗDΔ$"D  FD GΔΔ ΐ  dD &  LDΕd Ε  @ €ΗΔE F @F
 Ζ$ "    Α ΕF G
$ EG
 $G
$ΕG
H $EH
	$H
 $ΕH
$I
EI $I
ΕI $J
 	$EJ
$J
 $ΕJ
K $EK
K $ΕK
L $GEL @Ζ
 LΜΐ   
dE ΐFΕL LΝ
d LEΝ
ΗM    @ 
d ΕΝ 
€E&  8   GetOwnerWorldGetService
PlaySkillSkillRoutineGetResultContainerGetSkillIDGetCurTargetEntityID         GetEntityByIDGetCurDamageResultIndexGetCurDamageInfoIndexGetCurDamageResultStageIndexGetEffectResultsAsArraySkillEffectTypeDamageGetEffectResultsStageCountGetDamageInfoLogfatal;### damageInfo is nil. curDamageIndex, curDamageInfoIndex=GetGridPosGetFinalAttack_hitEffectID_trapNotPlayHitEffect       TrapIDHandleBeHitParamNew!SetHandleBeHitParam_CasterEntity!SetHandleBeHitParam_TargetEntity SetHandleBeHitParam_HitAnimName_hitAnimName SetHandleBeHitParam_HitEffectIDSetHandleBeHitParam_DamageInfoSetHandleBeHitParam_DamagePos"SetHandleBeHitParam_HitTurnTarget_turnToTargetSetHandleBeHitParam_DeathClear_deathClearSetHandleBeHitParam_IsFinalHitSetHandleBeHitParam_SkillID SetHandleBeHitParam_DamageIndex!SetHandleBeHitParam_HitBackSpeed_hitBackSpeed*SetHandleBeHitParam_HitBackUseDamageIndex_hitBackUseDamageIndex(SetHandleBeHitParam_HitBackUseDamagePos_hitBackUseDamagePos_waitBeHitFinishHandleBeHitTaskManagerGetInstanceCoreGameStartTask_HandleBeHitTaskAddPhaseTask                                               !   !   "   "   "   "   #   %   %   %   &   &   '   '   (   (   +   +   +   +   +   -   -   -   -   0   2   2   2   3   3   4   4   4   4   4   4   5   7   7   9   9   9   9   9   ;   <   <   <   <   <   <   <   =   A   A   A   B   B   A   C   C   A   D   D   A   E   E   A   F   F   A   G   G   A   H   H   A   I   I   A   J   J   A   K   K   A   L   L   A   M   M   A   N   N   A   O   O   A   P   P   P   Q   Q   Q   Q   Q   S   S   S   S   T   T   T   T   S   U   U   U   W      self       TT       casterEntity       phaseContext       world      playSkillService      skillEffectResultContainer	      skillID      targetEntityID      targetEntity      curDamageIndex      curDamageInfoIndex      curDamageResultStageIndex      damageResultArray       damageResultStageCount$      damageResult%      damageInfo(      damageGridPos3      playFinalAttack8      playHitEffectID9      beHitParamn      hitBackTaskID         _ENV Y   [       @ ΐ$A &     HandleBeHit           Z   Z   Z   Z   [      self       TT       playSkillService       beHitParam                                                     W      Y   [   Y   ^   _   `   a   b   d   d   d   d   d      TurnToTargetType         _ENV