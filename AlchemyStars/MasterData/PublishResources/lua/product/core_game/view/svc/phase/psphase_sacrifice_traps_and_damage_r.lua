LuaS �

xV           (w@c@../PublishResources/lua/product/core_game/view/svc/phase/psphase_sacrifice_traps_and_damage_r.lua             @ A@  $@ �@ A�  � A $@��@  ���@ l   
@���@ l@  
@ �& �    requireplay_skill_phase_base_r_class&PlaySkillSacrificeTrapsAndDamagePhasePlaySkillPhaseBasePlayFlight_DoFly           �    :[  @$� A@$� L�@��@ ��d��bA    �& � �  �  B�$� L��d� ����� ��� C�$� G�B L��� d���CC�� ƃC ���DGDD䃀����C ��C	�D���	ED�D
��$�  � D�L��d� D����B �B� $��LDE�  ��$ �D  dD�\  @��� �L�d� bD  @ �LD�d� ��F �@ �D ��F��$� @ �D �G �� E�$ �D  ��B ��B	� ���� �G @ $ 	�G�B L�� d���F��� ̆�F�C G���D�GDd��  G�LG�d� G���GH����$� K J�JG���GIJ��J��Jǃ�J�E�Jǂ�J���J �K�  ��G�)�  ��G @� $E �G @ $��F�J G���ǆB ��@ ��dF  )�  �E�EK	�� ��$E �G @�$@�L�Gd� b  @ �����F )�  ���  F�G � d����J �K� 
�K L$�� GL��L �   �$��F  i�  �E�F�L L�
d� LE�
� 
d��bE  � �FG �� dE ��FG �� ̅�� dE  L��ƅC ���D�DGFDM����d�  �E�
���� ��J�����B �N�� �EN�� �EC� ����C ��C��G���$�  GFD����� M��
F��L��d� ���� �FH@ ��
� G @� $G  L��d� 
G�L��d� 
G��OG�
G�
G�
��
�E�
���
��F�K G�d�� LG�ǇL    @ dG�LG�d� ����� ���� P $� LHPd� ��P�� ���� �G @	�$	 �L
Qd� ��B �
H �����JQ� �Q � $��L�Q � d����G ��� 
���Q @� � ��  @��L��R ���� �L�@ 䌀̌�@ 䌀���@�䌀��@ 䌀�L�@ 䌀̌�@�䌀���C  䌀��@�䌀�L�@ 䌀�T�� ��$M ��  *�)�  �	�& � S   SkillRoutineGetResultContainerGetEffectResultByArraySkillEffectTypeSacrificeTrapsAndDamageGetTrapStartHeightGetTrapEndHeightGetTrapFlyTotalTimeGetTrapTrajectoryIDGetTrapIDArray_worldGetServiceBoardRenderGetGridPositionVector2NewxyGridPos2RenderPos      �?EffectSetAnimatorControllerTriggersGetCasterAnimName        GetSuccessCasterEffectIDGetNoTrapCasterEffectIDCreateEffectGetCastEffectIDYIELDGetTrapStartDelayTrapRenderipairsGetEntityByIDCreatePositionEffectstartHeight
endHeight
totalTime����MbP?totalTimeMstargetRenderPoscurrentTimetrajectoryIDtrajectoryEntitytableinsertDestroyTrapListSetHadPlayDeadGameGlobalTaskManagerCoreGameStartTask_DoFlyTaskHelperGetInstanceIsAllTaskFinishedGetBowlderStartDelayGetBowlderStartHeightPlayerGetCurrentTeamEntityGetBowlderEndHeightGetBowlderFlyTotalTimeGetBowlderTrajectoryIDGetHitAnimationNameGetHitEffectIdGetHitDelayTimeSkillServiceIsFinalAttackGetSkillIDGetDamageResultArrayGetTargetIDGetDamageInfoArray_GetEntityBasePos_PlayEffectHandleBeHitParam!SetHandleBeHitParam_CasterEntity!SetHandleBeHitParam_TargetEntity SetHandleBeHitParam_HitAnimName SetHandleBeHitParam_HitEffectIDSetHandleBeHitParam_DamageInfoSetHandleBeHitParam_DamagePosSetHandleBeHitParam_DeathClearSetHandleBeHitParam_IsFinalHitSetHandleBeHitParam_SkillIDHandleBeHit         [  	   	   	   	                                                                                                                                     !   !   !   !   !   $   $   $   $   &   &   &   &   &   &   (   (   (   (   (   (   (   (   (   )   )   )   )   *   *   *   *   *   ,   ,   ,   ,   ,   /   /   /   /   1   2   2   2   2   3   3   3   3   4   4   5   5   5   5   5   5   5   6   6   6   6   6   7   7   7   7   9   :   ;   <   <   =   >   ?   @   A   C   C   C   C   C   2   2   F   F   F   H   H   H   H   I   I   I   I   I   I   I   I   H   H   K   K   K   K   L   L   L   L   N   N   O   O   P   P   L   L   T   U   U   U   U   V   V   V   V   V   V   V   V   V   V   V   V   U   U   Y   Y   Y   Y   Y   Y   Y   Y   Z   Z   Z   Z   ]   ]   ]   ]   ]   `   `   `   `   `   `   `   `   `   a   a   a   a   a   c   c   c   c   c   d   d   e   e   e   e   e   e   e   f   f   f   f   f   h   h   i   i   j   j   j   j   l   l   l   o   p   p   p   q   q   q   r   r   s   t   u   v   w   z   z   z   z   z   z   z   z   |   |   }   }   ~   ~   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   N   self    [  TT    [  casterEntity    [  phaseParam    [  routineComponent   [  result   [  trapTrajectoryInfoArray   [  removeTrapEntityArray   [  trapStartHeight   [  trapEndHeight   [  trapFlyTime   [  trapTrajectoryID   [  trapIDArray   [  boardServiceRender   [  
casterPos   [  trapTargetPos"   [  effectService5   [  	effectIDD   [  trapServiceRenderV   [  
trapCountW   [  (for generator)Z   �   (for state)Z   �   (for control)Z   �   _[   �   trapEntityID[   �   trapEntity_   �   trapEntityPosa   �   trapBeginPosh   �   effectEntityq   �   trajectoryInfo{   �   (for generator)�   �   (for state)�   �   (for control)�   �   _�   �   trapEntityID�   �   (for generator)�   �   (for state)�   �   (for control)�   �   _�   �   e�   �   trapRenderCmpt�   �   trapTaskIDs�   [  (for generator)�   �   (for state)�   �   (for control)�   �   _�   �   trajectoryInfo�   �   bowlderBeginRenderPos�   [  teamEntity�   [  
playerPos�   [  bowlderTargetPos�   [  bowlderTime�   [  
bowlderID�   [  bowlderEffectEntity�   [  bowlderTrajectoryInfo  [  hitAnimName  [  hitFxID  [  
delayTime  [  skillService  [  isFinalHit  [  skillID  [  damageResultArray  [  (for generator)  Z  (for state)  Z  (for control)  Z  _  X  damageResult  X  targetEntityID  X  targetEntity!  X  damageInfoArray#  X  posCast&  X  
posTarget)  X  (for generator),  X  (for state),  X  (for control),  X  __-  V  damageInfo-  V  beHitParamR  V     _ENV �   �       � @A�$� L�@d� ����A���B���A��A  $��B�BB ��B��B�C$��FBC �� ǂCdB�G�C L��@dB�& �    trajectoryEntityViewGetGameObject
transform	positionDOMovetargetRenderPos
totalTimeSetEaseDG	TweeningEase
InOutSineYIELDtotalTimeMs_worldDestroyEntity            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   	   self       TT       trajectoryInfo       entity      effectViewCmpt      effectObject      
posEffect      
transWork      
_easeWork         _ENV                                 �      �   �   �   �          _ENV