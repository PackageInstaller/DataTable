LuaS �

xV           (w@e@../PublishResources/lua/product/core_game/view/svc/phase/play_skill_circular_trajectory_phase_r.lua             @ A@  $@ �@ A�  � A $@��@  ���@ l   
@���@ l@  
@ ��@ l�  
@��& �    requireplay_skill_phase_base_r_class!PlaySkillCircularTrajectoryPhasePlaySkillPhaseBasePlayFlight_OnGetRandomAngle_OnPlayHit           �    ,�    �L@d� �A@�� ́@� �@$� LAd� �BA�� ̂A� �A$� LCBd� 
@�L�Bd� �C�� 
�����C�� 
����D�� 
���
����  ̃D� ���� �$� LD�ƄE ���	d�� �  �& � �D���F	�� ��F ��	@ 	䄀�D    �& � EG$� L�Gd� ���
 ������
AF 䅀�F �G�� $��L�Hd� �� �	@��� �FI ǆ� ��   
 ��J @�$��L��  	�d� �HJ  	�@	��� ƈJ ��� 	 @	 
䈀	K IKO�K���$���KG���	L �IL����		M��@� ���L�� ��L�� �	M�IM 
 ���@	 ��M 
�@
��� ̉L� ���� �KG
�G��J
L�M�
 dJ�FJI G
���I �
 dJ�FJN G��d�� L���
  dJ�F
O �
� �
 dJ� ���)�  �G�GI �IG�I $�   ��� �O @� $G @�O @� $G & � >   GetEffectIDGetSpawnRadiusMinGetSpawnRadiusMaxGetSpawnIntervalTimeGetSpawnCenterBoneGetOneArrowOffsetGetWaitFireTimeGetFlyTime_destroyBulletDelayGetdestroyBulletDelayGetTargetHit_turnToTargetGetTurnToTarget_hitAnimNameGetHitAnimName_hitEffectIDGetHitEffectID_casterEntitySkillRoutineGetResultContainerGetSkillIDGetEffectResultsAsArraySkillEffectTypeDamage        GetTargetID_worldGetEntityByIDGetDirectionGetOwnerWorldGetServiceEffect
PlaySkillTimeGetCurrentTimeMs#GetEntityRenderSelectBoneTransformtablecount_eftEntityListipairs_OnGetRandomAngleQuaternion
AngleAxismathrandom�      	positionVector3upViewGetGameObject
transformTransformPointCreatePositionEffectSetDirectioninsertGameGlobalTaskManagerCoreGameStartTaskYIELD                 d   q    
(   F @ �   � � d@�E  L@� d� L�� d� ��� � AFA�� ��A�  䀀���FB GA�G��G���@�� @    E �@�� � _ �  ��@  � � �C�  �  @�$A & �    YIELDViewGetGameObject
transformDOMove	position�      SetEaseDG	TweeningEaseLinear_OnPlayHit	     &      (   e   e   e   e   h   h   h   h   h   i   j   j   j   j   j   j   j   j   j   j   j   j   l   l   l   l   n   n   n   n   n   n   p   p   p   p   p   p   p   q      TT    (   trajectoryObject	   (   
transWork
   (   playFinalAttack    (   	   _ENVwaitFireTime
eftEntitytargetBoneTransformflyTimeidamageCountselfdamageResult�   	                                                                                                   %   %   %   %   &   &   '   '   '   '   *   *   +   .   .   .   0   0   0   0   1   1   2   6   6   9   9   ;   ;   ;   =   =   =   @   @   @   @   A   A   D   D   D   D   F   F   F   F   G   G   I   I   I   I   N   N   N   N   P   P   P   P   Q   Q   Q   Q   Q   R   R   R   R   R   R   U   U   U   U   U   U   V   V   W   W   W   W   W   W   W   W   W   [   [   [   [   \   \   \   \   ^   ^   ^   ^   _   _   _   a   a   a   a   a   c   c   c   c   q   c   t   t   t   t   t   t   I   I   �   �   �   �   �   �   �   �   �   �   �   �   �   �   )   self    �   TT    �   casterEntity    �   phaseParam    �   effectParam   �   	effectID   �   spawnRadiusMin   �   spawnRadiusMax   �   spawnIntervalTime	   �   spawnCenterBone   �   oneArrowOffset   �   waitFireTime   �   flyTime   �   
targetHit   �   	listTask!   �   skillEffectResultContainer%   �   skillID'   �   damageResultArray+   �   beAttackEntityID1   �   targetEntity5   �   
casterDir:   �   world<   �   effectService?   �   playSkillServiceB   �   timeServiceF   �   
startTimeH   �   targetBoneTransformL   �   damageCountP   �   (for generator)U   �   (for state)U   �   (for control)U   �   iV   �   damageResultV   �   casterBoneTransformZ   �   	curAngle^   �   curRotationc   �   curDistancei   �   posWorko   �   
eftEntity~   �   go�   �   dir�   �      _ENV �   �    	   � @ �@�� �� �� �OA��@ �A�  ����� & �    mathfloorh             random            �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       index       count       
angleEcah      	angleMin      	angleMax      angle         _ENV �   �    o   G@ LA�d� L��d� ����� �AAB 䁀�A �A�B� $�  LBBd� �  ̂�� �  � �"    ��� �@ ���� �   ��@ ���� ��� �  ��@ CC$� L�Cd� ��A ��A ����
���@ �C�� ̃�� @����� ���A �C� $��FCD L��d� L���@ d��L�� d��LC�ǃE d��L���F d��LC���d��L����d��L���G d��LC��� d��L��� d��L�� d���CH � @��C ��H �� �H �C��I �CIǃI  ��C���A ��I ��C�& � (   _casterEntitySkillRoutineGetResultContainerGetSkillIDGetDamageInfo       _worldGetEntityByIDGetTargetIDGetGridPosIsFinalAttackEntityTypeIsPetShadowPetShadowRenderGetOwnerEntityIDGetService
PlaySkillHandleBeHitParamNew!SetHandleBeHitParam_CasterEntity!SetHandleBeHitParam_TargetEntity SetHandleBeHitParam_HitAnimName_hitAnimName SetHandleBeHitParam_HitEffectID_hitEffectIDSetHandleBeHitParam_DamageInfoSetHandleBeHitParam_DamagePos"SetHandleBeHitParam_HitTurnTarget_turnToTargetSetHandleBeHitParam_DeathClear        SetHandleBeHitParam_IsFinalHitSetHandleBeHitParam_SkillIDHandleBeHitYIELD_destroyBulletDelaytableremovev_eftEntityListDestroyEntity         o   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    o   TT    o   damageResult    o   effectEntity    o   finalAttack    o   skillEffectResultContainer   o   skillID   o   damageInfo
   o   targetEntity   o   damageGridPos   o   playFinalAttack   o   isPetShadow#   o   petShadowRenderComponent(   8   ownerEntityID*   8   ownerEntity.   8   playSkillService<   o   beHitParam]   o      _ENV                                 �      �   �   �   �   �   �   �          _ENV