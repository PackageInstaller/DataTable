LuaS �

xV           (w@d@../PublishResources/lua/product/core_game/view/svc/instruction/play_target_be_hit_effect_ins_r.lua             @ A@  $@ �@ A�  � A $@��@  ���@ l   
@���@ l@  
@ ��@ l�  
@��& �    requirebase_ins_r_class!PlayTargetBeHitEffectInstructionBaseInstructionConstructorGetCacheResourceDoInstruction               "   �@@ ǀ� �� 
� ��@@ � � �� 
������ �A  ��@  � � 
����@@ �@� �� 
� ��@@ ��� �� 
� ��@@ �@� �� �@    ��� 
� ��@@ � � �� 
���& �    _hitEffectID	tonumberhitEffectID _hitEffectIDBodyAreaMoreThanOnehitEffectIDBodyAreaMoreThanOne_randomDir
randomDir _randomMin
randomMin_randomMax
randomMax_targetHitOffsetMintargetHitOffsetMin        _targetHitOffsetMaxtargetHitOffsetMax         "                           
   
   
   
   
   
                                                                  self    "   
paramList    "      _ENV        '   K   � @ �   ��� @  �������@ ��@� �  FA GA��@ G��G���� +A �@�� B �   ��� B  �������@ ��@� �  FA GA��B G��G���� +A �@�f  & � 	   _hitEffectID        tableinsertCfgcfg_effectResPath        _hitEffectIDBodyAreaMoreThanOne         '                                                                                                                           self    '   t   '      _ENV    v    �   @ "  � �A�"A    �ʀ���@$� LA�A d���A� �����A� ��� B�$� L��d� ��B ������� C�$� L��d� ���D DD@��� ����� $��"D  ��F�D G��D ��  dD & � L��d� ��E�� �F �D�	_�	  ��D  �� ̄�@ 䄀�F GG b  @�GG  @���LEGd� L��
d�  @��  �G "   �  ���LH� 
  @�	��d� _@�
�����
�� _@H@�_@H� ���HLId �E  �@ �  ���EIC� �E�ƅI ���J GFJ 䅀�J �J�GF�FL�
d� LF�d� G���L �FLJ������  �F��F���Gʀ����L �  ��ƅI ���M FMG�L OF�䅀�E�A�� $��L�M�  d� �F�ƆN ������ƅ���F�
@ �F�& � >   _randomDir!__PlayTargetBeHitEffect_RandTime        GetOwnerWorldGetServicePlayDamageEffectSkillRoutineGetResultContainerGetSkillIDGetCurTargetEntityIDGetEntityByIDGetCurDamageResultIndexGetCurDamageInfoIndexGetCurDamageResultStageIndexGetEffectResultsAsArraySkillEffectTypeDamageGetDamageInfoLogfatalT### PlayTargetBeHitAnimation DamageInfo is nil. curDamageIndex, curDamageInfoIndex=GetGridPosGetDamageTypeDamageTypeGuardSingleOrGrid_hitEffectID _hitEffectIDBodyAreaMoreThanOne	BodyAreaGetAreaCount       CreateBeHitEffect EffectControllerSetEffectCasterIDGetIDSetNoResetRotationOnCreatedmathrandom_randomMin_randomMaxVector3upViewGetGameObject
transform	rotationQuaternion	identityRotate_targetHitOffsetMax_targetHitOffsetMin�      
PlaySkill#GetEntityRenderSelectBoneTransformHit	positionUnityEngineRandomonUnitSphereSetPosition         �               !   !   !   "   &   &   (   (   (   *   *   *   -   -   -   -   .   .   /   /   0   0   0   2   2   3   3   4   4   7   7   7   7   7   :   <   <   <   =   =   >   >   ?   @   B   >   C   E   E   F   F   F   F   F   F   F   F   H   H   H   J   L   L   L   L   L   L   M   M   M   M   N   N   O   S   S   S   S   U   U   U   U   U   U   V   V   X   X   Y   Y   Y   Y   Z   Z   Z   Z   ]   ]   ]   ^   ^   ^   `   `   `   `   `   a   a   a   a   a   c   c   c   c   c   d   d   d   e   e   e   g   g   g   j   j   j   k   k   k   k   k   k   k   k   n   n   n   o   o   o   o   p   p   p   p   p   p   r   r   r   v      self    �   TT    �   casterEntity    �   phaseContext    �   world	   �   playDamageService   �   effectService   �   skillEffectResultContainer   �   skillID   �   targetEntityID   �   targetEntity   �   curDamageIndex   �   curDamageInfoIndex   �   curDamageResultStageIndex    �   damageResultArray%   �   damageResult&   �   damageInfo)   �   damageGridPos4   �   guard<   �   damageShowType?   �   curHitEffectID@   �   bodyAreaCountJ   M   beHitEffectEntityW   �   effectCtrl[   �   randn   �   v3s   �   transx   �   targetHitOffset�   �   playSkillService�   �   targetBoneTransform�   �   
targetPos�   �      _ENV                                                   v      v          _ENV