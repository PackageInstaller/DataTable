LuaS 

xV           (w@b@../PublishResources/lua/product/core_game/view/svc/instruction/play_matai_chain_damage_ins_r.lua             @ A@  @ $@@@  @@ l   
@@@ l@  
@ @@ l  
@@@ lΐ  
@ &     _class PlayMataiChainDamageInstructionBaseInstructionConstructorGetCacheResourceDoInstruction_Play               2   
@ @ Ηΐΐ € 
@ Η@Α € 
 @ ΗΐΑ € 
 @ Η@Β € 
 @ ΗΐΒ € 
 @Γ 
 @ ΗΐΒ € 
 @ ΗΐΓ € 
 @ Η@Δ € 
 @ ΗΐΔ € ’@      
 @ ΗΕ € ’@    ΐ 
&     _paramList_casterEffectID	tonumbercasterEffectID_defenderEffectDelayMsdefenderEffectDelayMs_defenderEffectIDdefenderEffectID_hitDelayMshitDelayMs_hitEffectIDhitEffectID_hitAnimNamehitAnimName_turnToTargetturnToTarget_deathCleardeathClear_trapNotPlayHitEffecttrapNotPlayHitEffect        _waitBeHitFinishwaitBeHitFinish                2                  
   
   
   
                                                                                                                                 self    2   
paramList    2      _ENV        
   K   @ A@ €Μ @ G@ δ k@  f  &     GetEffectResCacheInfo_casterEffectID_defenderEffectID        
                                    self    
        !   (    
   @ @@ @ Α@$ AAA ΐ    @$ LΑΐ dA AA  ΐ  $A&     _waitBeHitFinish       TaskManagerGetInstanceCoreGameStartTask_PlayAddPhaseTask            "   "   "   #   #   #   #   #   #   #   #   #   $   $   $   $   &   &   &   &   &   (      self       TT       casterEntity       phaseContext       tid         _ENV *   x    !   @$ LA@Α  dΑ@€ A€ ΜAAδ Α$ _ΐA@   B  &  LBBΐ dΒ€ ΜΒΒδ Γ$ LCCΖC ΗΓΓ  d DC ΔC€ΗDΔ$"D  FD GΔΔ ΐ  dD &  LDΕd Ε  @ €ΗΔE F @F
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
 $LE@ΑΕ
 dE@  €ΜK@δFΛ
Λ$LΖKd NFF@ €ΜFLGL ΗK€ ΐδΗL @ M $GGLGM ΜΗKδ  $FΗL  ΗM dGLΗMΐ   
dG &  8   GetOwnerWorldGetService
PlaySkillSkillRoutineGetResultContainerGetSkillIDGetCurTargetEntityID         GetEntityByIDGetCurDamageResultIndexGetCurDamageInfoIndexGetCurDamageResultStageIndexGetEffectResultsAsArraySkillEffectTypeDamageGetEffectResultsStageCountGetDamageInfoLogfatal;### damageInfo is nil. curDamageIndex, curDamageInfoIndex=GetGridPosGetFinalAttack_hitEffectID_trapNotPlayHitEffect       TrapIDHandleBeHitParamNew!SetHandleBeHitParam_CasterEntity!SetHandleBeHitParam_TargetEntity SetHandleBeHitParam_HitAnimName_hitAnimName SetHandleBeHitParam_HitEffectIDSetHandleBeHitParam_DamageInfoSetHandleBeHitParam_DamagePos"SetHandleBeHitParam_HitTurnTarget_turnToTargetSetHandleBeHitParam_DeathClear_deathClearSetHandleBeHitParam_IsFinalHitSetHandleBeHitParam_SkillID SetHandleBeHitParam_DamageIndexBoardRenderGetEntityRenderHitTransform BoardRenderPos2FloatGridPos_New	positionGetRenderGridPositionEffect#CreateWorldPositionDirectionEffect_casterEffectIDYIELD_defenderEffectDelayMs_defenderEffectID_hitDelayMsHandleBeHit            ,   ,   .   .   .   1   1   1   1   3   3   4   4   5   5   5   5   6   :   :   :   ;   ;   <   <   =   =   @   @   @   @   @   B   B   B   B   D   F   F   F   G   G   H   H   H   H   H   H   I   L   L   N   N   N   N   N   P   Q   Q   Q   Q   Q   Q   Q   R   V   V   V   W   W   V   X   X   V   Y   Y   V   Z   Z   V   [   [   V   \   \   V   ]   ]   V   ^   ^   V   _   _   V   `   `   V   a   a   V   d   d   d   g   g   g   h   h   h   i   i   i   k   k   k   n   n   n   o   o   o   o   o   o   q   q   q   q   s   s   s   s   s   s   u   u   u   u   w   w   w   w   x      self       TT       casterEntity       phaseContext       world      playSkillService      skillEffectResultContainer	      skillID      targetEntityID      targetEntity      curDamageIndex      curDamageInfoIndex      curDamageResultStageIndex      damageResultArray       damageResultStageCount$      damageResult%      damageInfo(      damageGridPos3      playFinalAttack8      playHitEffectID9      beHitParame      boardServiceRenderh      playSkillServicek      targetHitObjn      targetHitGridPosq      casterFxGridDirt      fxSvcw      casterEffect}      defenderEffect         _ENV                                       !   (   !   *   x   *   x          _ENV