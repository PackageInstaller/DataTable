LuaS �

xV           (w@h@../PublishResources/lua/product/core_game/view/svc/phase/play_skill_range_attack_animation_phase_r.lua             @ A@  $@ �@ A�  � A $@��@  ���@ l   
@���@ l@  
@ ��@ l�  
@���@ l�  
@ ��@ l  
@���@ l@ 
@ �& �    requireplay_skill_phase_base_r_class#PlaySkillRangeAttackAnimationPhasePlaySkillPhaseBasePlayFlight_HandleBeHit_TrajectoryAction_DoTweenCompleteCall_PlayTrajectoryOverEffect_PlayHitEffect           S    +�    �L@d� �A@�� ́@�   L�@d� b  ��LAd� b  � �LBAd�  �L�A ��   @�� ��dB�F�A G��B dB F�B G��d�� L��BC ǂ�CC L�Cd� �D� dB  LBDd� L��d� ����� ��� C���E ��E$��LF ��   @ � ��  d� �  @����"C    �& � ̃F� �F$� LGd� �DG�� ƄG   �@	��G H�F�� $�  "  ��L�Hd� G����G	 ���̆�� �B �B$�� C��I �    @ ���  	 @	 	�	��	� 
 @
��
 $��  �� �\ MG����  j��ƃB �C�� ̃�� �J � $D��B DJ$� �J$� FK GD��
 ̄K� ���	d����A �B	��  ��D��L ��  ��D�& � 1   GetCastAnimationGetCastEffectIDGetHitDelayTimeIsPlayOnSuperEntityHasSuperEntityGetSuperEntity_PlayAnimationEffectLogdebug,[RangeAttackAnimation] play anim effect endGameGlobalTaskManagerCoreGameStartTask_skillServicePlayCastAudioGetAudioIDGetAudioWaitTimeSkillRoutineGetResultContainerGetSkillIDIsFinalAttackGetEffectResultByArrayAllSkillEffectTypeDamage_TrajectoryAction GetHitAnimationGetHitEffectIDGetHpDelayGetTargetEffectIDpairs_worldGetEntityByIDGetTargetIDGridLocation	PositionGetDamageInfo       GetGridPos_HandleBeHit        GetInstanceGetCurrentTime_WaitSonTaskmathmaxGetFinishDelayTime([RangeAttackAnimation] finishDelayTime:YIELD         �   	                                                                                                                                                      !   !   !   !   #   #   #   #   #   #   #   #   &   '   '   (   (   )   +   +   ,   ,   -   -   .   .   0   0   0   0   1   1   1   1   1   2   2   3   3   3   4   4   4   5   5   7   7   7   7   8   9   :   ;   <   =   >   ?   @   A   B   C   E   7   F   F   G   G   G   0   0   L   L   L   L   L   M   M   M   N   N   N   N   N   P   P   P   P   P   P   P   P   Q   Q   Q   Q   Q   R   R   R   R   S       self    �   TT    �   casterEntity    �   phaseParam    �   param   �   castAnimationName   �   castEffectID   �   hitDelayTime   �   animatedEntity   �   skillEffectResultContainer.   �   skillID0   �   isFinalHit2   �   results6   �   	bHaveBit>   �   taskIDs?   �   hitAnimationNameF   x   hitEffectIDH   x   hpDelayTimeJ   x   targetEffectIDL   x   (for generator)O   x   (for state)O   x   (for control)O   x   _P   v   resP   v   targetEntityU   v   posZ   v   targetDamage]   v   
damagePos_   v   nTaskIDq   v   nWaitStart}   �   	nWaitEnd�   �   finishDelayTime�   �      _ENV U   u    4   �  ��G@ LC���  d��L���� �dC FA �� � dC�LCA d� ��A ��A�� �B  ����CB ������B  �����B �����C  ����CC ������C�C$ ��  �D �����CD  ���̃�@� � �C & �    _worldGetServiceEffectCreateEffectYIELDSkillServiceHandleBeHitParamNew!SetHandleBeHitParam_CasterEntity!SetHandleBeHitParam_TargetEntity SetHandleBeHitParam_HitAnimName SetHandleBeHitParam_HitEffectIDSetHandleBeHitParam_DamageInfoSetHandleBeHitParam_DamagePosSetHandleBeHitParam_DeathClearIsClearBodyNowSetHandleBeHitParam_IsFinalHitSetHandleBeHitParam_SkillIDHandleBeHit         4   b   b   c   c   c   c   c   c   c   c   e   e   e   e   g   g   i   i   i   j   j   i   k   k   i   l   l   i   m   m   i   n   n   i   o   o   i   p   p   p   i   q   q   i   r   r   i   t   t   t   t   u      self    4   TT    4   casterEntity    4   targetEntity    4   hitAnimationName    4   hitEffectID    4   targetDamage    4   targetEffectID    4   hpDelayTime    4   isFinalHit    4   param    4   
damagePos    4   skillID    4   playSkillService   4   beHitParam/   4      _ENV x   �    -  ��� ���@ �  & _ ��@��@ �@@ $� ! A@ �  & B�$� L��d� ��A�� �B�BB ̂�A� 䂀CB �B� $��K  �CC � � 
��DB ̄�	L�C	d �  �  @�D	$� N�
�E��� � �  ���D �DF�D G��F�
d� ��D �Eǆ�
�� �� $� FF �F�
�ǆ�
��d���FͅFF� �� �
$��J
��  *����  DC @ $�&�GEB L��
��C
� d�  b  �$��D
�� � �D EGF��FEN��$� F�D G����ǆE��d� ��D ��F�G����� ǆ���$� "G  � �FG GG��� dG OGR���  "  ���H� H�L����d����H �I� ��HI 	�@	��	  �����I�I 	JIJ�J���� �
���H ��J� ��K�HK ǈ������
����D ��F�H�� ��K@	��	 ��  
�C
  䈀����I �	J�IJ��J$��� ����H �L����HL 	 @	��� ̈IF�I G	�GI�G��䈀���   �ƇL ���䇀 ��GHM �  �  	�
@	��	 �	� 
 
@
��
 �
� �� ��E����ƇL ���䇀 ��GHM �  �  	�
@	��	 �	� 
 
@
��
 �
� �� ��E�� @  ���)�  ����L �M$� �M$� �F�L L��d� L��d�   �� �FN �� dD  �FN �� dD LDN ��dD�FG GD��� dD C� f & � ;   GetTrajectoryType tablecount        GetTrajectoryEffectIDGetTrajectoryTimeGridLocation	Position_worldGetServiceBoardRenderEffectpairsGetEntityByIDGetTargetIDGetGridPosGetTrajectoryEffectOffsetmathmaxabsxy       Vector2#CreateWorldPositionDirectionEffectsqrtViewLogdebug#[RangeAttackAnimation] eff no view     @�@GetGameObject
transformGridPos2RenderPos+SkillPhaseParam_RangeAttack_TrajectoryTypeLineDOMoveSetEaseDG	TweeningEase
InOutSine	Parabola	positionVector3upDOJumpLaser	DOScaleZGameGlobalTaskManagerCoreGameStartTask_DoTweenCompleteCallGetInstanceGetCurrentTimeYIELD_WaitSonTask/[RangeAttackAnimation] TrajectoryAction finish                 �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   5   self      TT      casterEntity      phaseParam      results      isFinalHit      	nSkillID      nTrajectoryType     nTrajectoryEffectID     nTrajectoryTime     castPos     boardServiceRender     effectService     effectEntities      (for generator)#   O   (for state)#   O   (for control)#   O   _$   M   res$   M   targetEntity)   M   
posDamage-   M   posDirectory.   M   nEffectOffset0   M   
posCreate1   M   nDirectoryLen?   G   effectDirectorE   G   effectEntityL   M   	nMaxTimeP     needWaitTaskIdsQ     (for generator)T   �   (for state)T   �   (for control)T   �   _U   �   resU   �   targetEntityZ   �   
posDamage^   �   
attachPos_   �   disxe   �   disyk   �   disq   �   entityEffectr   �   effViewt   �   
nFlayTime|   �   	easeWork}   �   trajectoryObject�   �   
transWork�   �   gridWorldpos�   �   
jumpPower�   �   	sequence�   �   	sequence�   �   taskId�   �   taskId�   �   endtime�        _ENV          @ @� �C@$C��@ �@��$C�A �� �CA� �A$� @�� $C��A �� �  �@ ���  �$C�& �    YIELD�      _worldDestroyEntity_PlayTrajectoryOverEffectGetTargetEffectIDGetHpDelay_PlayHitEffect                                                                     self       TT       casterEntity       targetEntity       phaseParam       castPos       
attachPos       res       isFinalHit       	nSkillID       
nFlayTime       entityEffect          _ENV   "      _� �@ �!@@  �& � ��@ ��@ �����BA� �� �$��F�A �� ��dB�& �             _worldGetServiceEffect#CreateWorldPositionDirectionEffectYIELD                                                  "  	   self       TT       
nEffectID       
nShowTime       posCast       posGrid       effectService	      posDirectory
      entityEffect         _ENV %  @   /   @$� LB@d� ����  ������ CA $� F�A L��d� L�� d��LC���d��L��� d��L����d��L�� d��LC���d��L����C� d�  L�� d��LC���d����D � @��C & �    GetHitAnimationGetHitEffectIDGetDamageInfo       GetGridPosSkillServiceHandleBeHitParamNew!SetHandleBeHitParam_CasterEntity!SetHandleBeHitParam_TargetEntity SetHandleBeHitParam_HitAnimName SetHandleBeHitParam_HitEffectIDSetHandleBeHitParam_DamageInfoSetHandleBeHitParam_DamagePosSetHandleBeHitParam_DeathClearIsClearBodyNowSetHandleBeHitParam_IsFinalHitSetHandleBeHitParam_SkillIDHandleBeHit         /   -  -  .  .  /  /  /  0  0  2  2  4  4  4  5  5  4  6  6  4  7  7  4  8  8  4  9  9  4  :  :  4  ;  ;  ;  4  <  <  4  =  =  4  ?  ?  ?  ?  @     self    /   TT    /   entityCast    /   entityTarget    /   phaseParam    /   result    /   isFinalHit    /   	nSkillID    /   hitAnimationName   /   hitEffectID   /   targetDamage   /   
damagePos	   /   skillService   /   beHitParam*   /      _ENV                                 S      U   u   U   x   �   x             "    %  @  %  @         _ENV