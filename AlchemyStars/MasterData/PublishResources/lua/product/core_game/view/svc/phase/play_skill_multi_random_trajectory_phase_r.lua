LuaS �

xV           (w@i@../PublishResources/lua/product/core_game/view/svc/phase/play_skill_multi_random_trajectory_phase_r.lua             @ A@  $@ �@ A�  � A $@��@  ���@ l   
@���@ l@  
@ ��@ l�  
@���@ l�  
@ �& � 	   requireplay_skill_phase_base_r_class$PlaySkillMultiRandomTrajectoryPhasePlaySkillPhaseBasePlayFlight
_TooClose_PlayOneTrajectory_OnPlayHit           d    �    �LA@d� 
@�L�@d� 
@�LAAd� 
@�L�Ad� 
@�LABd� 
@�L�Bd� 
@�LACd� 
@�
�C�
�C�
�ÈL�Dd� 
@�LAEd� 
@�L�Ed� 
@�
� �
�ƌLGd� 
@��K  �AG�� ́G� ���� �$� LB�ƂH ���d�� �  �& � �BI�� ̂IA�	 䂀�I�
 $��GCJ L����
 d������� �  
���C �C  ��� DK A� �� $��FDK �� �� d���DK � E ����DK E A� 䄀EK A� �� $��C  
���� M @�$��K  � 
�EM� �M��$��"  E
�L�Md� _��	� ��N �� B �F��C ���FN @ ��� �   �̓��C �ƃ̓�  �̓��F   �ƆN � A� 䆀���O �F�䆀 ̆�l  䆀�O PGK ��$G� ���)�  ���DP �P$� �P�K $��"D  � �N @� $D ��N @� $D & � D   _startPosEffectIDGetStartPosEffectID_bulletEffectIDGetBulletEffectID_flyDelayTimeGetFlyDelayTime	_flyTimeGetFlyTime_intervalTimeGetSpawnIntervalTime_bulletOffSetV3GetBulletOffSetV3_startPosListGetStartPosList_lastHitPointTime        _hitPointDelay_destroyBulletDelay_targetHitGetTargetHit_hitAnimNameGetHitAnimName_hitEffectIDGetHitEffectID_casterEntity_needLookAt       _hitSoundIDGetHitSoundIDGetRenderGridPositionSkillRoutineGetResultContainerGetSkillIDGetEffectResultsAsArraySkillEffectTypeDamage GetOwnerWorldGetServiceEffect
PlaySkill_worldTimeGetCurrentTimeMs_flyTaskIDListVector2                     	                     ipairsGetTargetIDGetEntityByIDGetGridPositionYIELD
_TooCloseVector       GameGlobalTaskManagerCoreGameStartTasktableinsertTaskHelperGetInstanceIsAllTaskFinished         Y   [       E   L � �   � E ��d@ & �    _PlayOneTrajectory           Z   Z   Z   Z   Z   Z   Z   [      TT          selfiv	posStart�   	                                                                                                                        #   #   &   &   &   &   '   '   (   (   (   (   +   +   ,   0   0   2   2   2   4   4   4   7   7   7   7   8   8   :   :   <   <   <   =   =   =   =   =   =   =   =   =   =   =   =   =   =   =   =   =   =   =   =   =   =   =   @   A   A   A   A   B   D   E   E   F   F   F   G   G   H   H   I   I   J   J   J   J   L   L   M   M   M   M   M   M   N   O   O   P   P   R   T   T   U   U   U   U   U   X   X   X   X   [   X   ]   ]   ]   ]   ]   ]   ^   A   A   `   `   `   `   `   `   `   `   a   a   a   a   c   c   c   d      self    �   TT    �   casterEntity    �   phaseParam    �   effectParam   �   	listTask(   �   castPos*   �   skillEffectResultContainer.   �   skillID0   �   damageResultArray4   �   world9   �   effectService<   �   playSkillService?   �   timeServiceC   �   
startTimeE   �   posStartIndexb   �   (for generator)e   �   (for state)e   �   (for control)e   �   if   �   vf   �   formatg   �   damageResulth   �   targetEntityIDj   �   targetEntitym   �   targetEntityPosq   �   	posStarty   �   taskID�   �      _ENV e   m    	   � � ��F@ GA��@ ��@��@�� �@ ǁ�A� d�  !@�@ ��� � �  � & �    mathmaxabsxy                   f   g   h   h   h   h   h   h   h   h   h   h   h   i   i   j   j   l   l   m      self       posA       posB       nearest      	relative      	distance         _ENV n   �    �   L�d� �A@ ��@ �����A    �& � ��@� � � �FA �B �� d�� �GB@ L��� d���  �BB �   ��BB  ��@�̂�GCB � � 䂀���B    �& � ��B� C @� �CC $C�C@ �A�� $��D  ��C �  �	���C  �� 	��  �D �   ��C@ ̃�@�䃀�  @�DD$� �D$� �DLE�D d���� �DE� $��� � ��CE@ 䃀��̃�G�C � � @����@ �C�bC    �& � ����� �C�� ̃�� ��LDE��d���F �GEF R��
�  �����F	G EG
�G
�G
�D��C �� EF �D��H  � @�� � �D & � !   GetTargetID_worldGetEntityByIDGetGridPositionVector2               GetServiceEffect_startPosEffectID#CreateWorldPositionDirectionEffectGetIDYIELD_flyDelayTimeBoardRender_bulletEffectID_bulletOffSetV3ViewGetGameObject
transformTransformPointGridPos2RenderPosCreatePositionEffectSetDirectionDOMove	_flyTime�      SetEaseDG	TweeningEaseLinear_OnPlayHit         �   o   o   p   p   p   p   q   q   r   t   t   u   v   v   w   w   w   w   w   {   {   {   {   |   }   }   }   }   }   }   ~   ~   ~   ~   ~   ~   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    �   TT    �   index    �   damageResult    �   	posStart    �   targetEntityID   �   targetEntity   �   
targetPos   �   dir   �   effectService   �   startEffect   �   startEffectEntityID)   �   boardServiceRender1   �   bulletEffect2   �   
posBullet9   ]   startEffectEntity@   P   startEntityTransformG   K   bulletEffectEntityIDb   �   trajectoryObjectf   �   
transWorkg   �   targetRenderPosj   �      _ENV �   �    r   G@ LA���d��b  ������� ��@�� �A�A��A$� G@ L��� d���AB ��B�� ��B�� �C� BC�� $��L�Cd� �  �@ ���A 䂀CD �D$� �D�CB $��E� $��CE��E $���E�F $��CF� $���F��$���F�G $��CG�� $���G� $��H��$��LC���   dC G�H b  ��G�H  @�� �F�H G���H dC GCI b  @�GCI  @���F�I �� �CI dC�G@ LC���d��b  ���@ ��I ��C�@�G@ LC���d��b  � ��@ ��I ��C�& � (   _worldGetEntityByIDViewGetGameObject
transform	positionGetIDGetServiceEffect_casterEntitySkillRoutineGetResultContainerGetSkillIDGetDamageInfo       GetGridPos
PlaySkillHandleBeHitParamNew!SetHandleBeHitParam_CasterEntity!SetHandleBeHitParam_TargetEntity SetHandleBeHitParam_HitAnimName_hitAnimName SetHandleBeHitParam_HitEffectID_hitEffectIDSetHandleBeHitParam_DamageInfoSetHandleBeHitParam_DamagePos"SetHandleBeHitParam_HitTurnTarget_turnToTargetSetHandleBeHitParam_DeathClear        SetHandleBeHitParam_IsFinalHitSetHandleBeHitParam_SkillIDHandleBeHit_hitSoundIDAudioHelperControllerPlayInnerGameSfx_destroyBulletDelayYIELDDestroyEntity         r   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    r   TT    r   damageResult    r   bulletEffectEntityID    r   targetEntity    r   effectEntity   r   go
      
effectPos      targetEntityID      effectService      skillEffectResultContainer   r   skillID   r   damageInfo   r   damageGridPos   r   playFinalAttack   r   playSkillService#   r   beHitParamD   r   effectEntity`   f   effectEntityk   q      _ENV                                 d      e   m   e   n   �   n   �   �   �   �          _ENV