LuaS �

xV           (w@l@../PublishResources/lua/product/core_game/view/svc/phase/play_skill_caster_rotation_trajectory_phase_r.lua             @ A@  $@ �@ A�  � A $@��@  ���@ l   
@���@ l@  
@ �& �    requireplay_skill_phase_base_r_class'PlaySkillCasterRotationTrajectoryPhasePlaySkillPhaseBasePlayFlight_OnPlayHit           �    $�    �L@d� �A@�� ́@� �@$� LAd� �BA�� ��A� 
���BB� 
����B� 
���BC� 
����C� 
��
� ��BD� ̂�� ��$� L��CE ǃ�d����  �& � �F�� �CFA� 䃀DF�� $��LGd� LD�d� ��G �� � A �� ����D	  FEH ��d����̆H� �H��$��"  ��LGd� LG�d� �G�ƇG �� �	@ 䇀H�GH� @  �����I J@ 
��  �����������$H�i�  ��F�I G�
� 
d� ��
  �& � F�I GE�
� 
�  dE�F�I G�
� 
d� 
@�FEH � 
d���F������L�Hd� ��H �����L@ �H � ��F�L G�d�� LH��H  dH����i�  �E�G�K  @�� �F�M �� dE  �F�M �� dE & � 8   GetEffectIDGetFireEffectIDGetSpawnHighGetSpawnRadiusGetRotationTimeGetFlyOneTime_destroyBulletDelayGetdestroyBulletDelay_disableRootGetDisableRoot_turnToTargetGetTurnToTarget_hitAnimNameGetHitAnimName_hitEffectIDGetHitEffectID_casterEntitySkillRoutineGetResultContainerGetSkillIDGetEffectResultsAsArraySkillEffectTypeDamage GetOwnerWorldGetServiceEffect
PlaySkill	LocationGetPositionVector3               ipairsGetTargetIDGetEntityByIDAnglexh      tableinsertdamageResultangledircountsort_remainCountangle#GetEntityRenderSelectBoneTransformHit	positionGameGlobalTaskManagerCoreGameStartTask        YIELD         P   R       � @ � � `�   ��@  � � �  & �    angle           Q   Q   Q   Q   Q   Q   Q   R      a       b            c   �    Y   E   R � � � O�� �@@�    � �@�� �ƀ@�� ��� ��@ E � � �� � �΀� AA��� $� L�A��dA�L�Ad� L�d� �AB�  @������BBB����  � ��C�A�C� �A�� �AA�@ �� ́A@��A���@ǁ��@ 䁀 �L�Ad� L�d� �����CE��D�  䂀�B�F�DG��G�GC��B��B@   @ �B�� ̂�@  ���   �B & �    h      YIELDnormalizedVector3        CreatePositionEffectSetDirectionViewGetGameObject_disableRoot
transformFindgameObject
SetActive	DistanceDOMove�      SetEaseDG	TweeningEaseLinear_OnPlayHit   	    
    Y   e   e   e   e   g   g   g   g   j   j   j   j   j   k   k   k   k   k   k   l   l   o   o   o   o   o   p   p   p   q   q   q   q   r   r   r   s   s   s   s   t   t   u   u   u   u   z   z   z   z   z   {   {   {   }   }   }   }   }   ~   ~   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      TT    Y   waitFireTime   Y   firePos   Y   fireDir   Y   effectEntity   Y   go!   Y   disableTransform(   .   fireEffectEntity3   Y   flyDis;   Y   flyTime=   Y   trajectoryObjectA   Y   
transWorkB   Y      anglerotationTime_ENVcasterRenderPosdirspawnRadius
spawnHigh
targetPoseffectService	effectIDselffireEffectIDflyOneTimedamageResult�   	                                                                                       !   !   !   !   "   "   #   #   #   #   &   &   '   +   +   -   -   -   /   /   /   2   2   2   2   3   3   3   3   3   3   4   6   7   7   7   7   9   :   :   ;   ;   ;   =   =   >   >   >   >   ?   @   @   @   @   @   A   A   A   A   B   E   E   E   E   E   E   E   E   7   7   I   I   I   I   I   I   J   N   N   O   R   N   U   U   U   U   U   W   W   W   W   Y   Z   [   ]   ]   ^   ^   ^   _   _   _   _   `   b   b   b   b   �   b   �   W   W   �   �   �   �   �   �   �   �   �   �   �   ,   self    �   TT    �   casterEntity    �   phaseParam    �   effectParam   �   	effectID   �   fireEffectID   �   
spawnHigh   �   spawnRadius	   �   rotationTime   �   flyOneTime   �   skillEffectResultContainer!   �   skillID#   �   damageResultArray'   �   world,   �   effectService/   �   playSkillService2   �   casterRenderPos6   �   targetDirPos<   �   baseDir=   �   hasTargetDamageResultArray>   �   (for generator)A   c   (for state)A   c   (for control)A   c   _B   a   vB   a   damageResultC   a   targetEntityIDE   a   targetEntityH   a   targetRenderPosN   a   curDirO   a   angleT   a   (for generator)w   �   (for state)w   �   (for control)w   �   _x   �   vx   �   damageResulty   �   anglez   �   dir{   �   targetEntityID}   �   targetEntity�   �   targetBoneTransform�   �   
targetPos�   �      _ENV �   �    q   G@ LA�d� L��d� ����� �AAB 䁀�A �A�B� $�  LBBd� �  ̂�� �  � ���B @�  ��� ǂA ��AC 䂀�C �C$� D�@ $��CD� $���D��D $��E�C $���E��$���E��$��F�CF $���F�C $���F� $��G� $��LC���   dC G�A L��� d�����  A �� �CH����H ��$� N��I ��D��D��� ��I	�� ��I �  @��J	�D�	G�I 䄀�  � ���	�J
�  $E��K  � GEK �D�ǄA ̄�	@��D���B �D�	
���& � /   _casterEntitySkillRoutineGetResultContainerGetSkillIDGetDamageInfo       _worldGetEntityByIDGetTargetIDGetGridPosIsFinalAttack_remainCountGetService
PlaySkillHandleBeHitParamNew!SetHandleBeHitParam_CasterEntity!SetHandleBeHitParam_TargetEntity SetHandleBeHitParam_HitAnimName_hitAnimName SetHandleBeHitParam_HitEffectID        SetHandleBeHitParam_DamageInfoSetHandleBeHitParam_DamagePos"SetHandleBeHitParam_HitTurnTarget_turnToTargetSetHandleBeHitParam_DeathClearSetHandleBeHitParam_IsFinalHitSetHandleBeHitParam_SkillIDHandleBeHitEffect#GetEntityRenderSelectBoneTransformHit	positionCreatePositionEffect_hitEffectIDSetDirectionViewGetGameObject_disableRoot
transformFindgameObject
SetActiveYIELD_destroyBulletDelayDestroyEntity         q   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    q   TT    q   damageResult    q   effectEntity    q   firePos    q   skillEffectResultContainer   q   skillID   q   damageInfo
   q   targetEntity   q   damageGridPos   q   playFinalAttack   q   playSkillService   q   beHitParam?   q   effectServiceG   q   targetBoneTransformK   q   hitPosL   q   hitEffectEntityP   q   hitDirQ   q   goX   q   disableTransform_   e      _ENV                                 �      �   �   �   �          _ENV