LuaS �

xV           (w@a@../PublishResources/lua/product/core_game/logic/svc/skill_handler/calc_damage_after_hitback.lua             @ A@  $@ �@ A�  � A $@��@  ���@ l   
@���@ l@  
@ ��@ l�  
@��& �    require
calc_base_class#SkillEffectCalc_DamageAfterHitBackSkillEffectCalc_BaseConstructorDoSkillEffectCalculator_CalculateSingleTarget                  
@ �� @ ��@�  ���
���& �    _world_skillEffectServiceGetServiceSkillEffectCalc                                   self       world                       �   � � � A@ @�$��L�@ ��   d� b   ���@ �A�  ��B�)�  ����  & �    GetTargetEntityIDsipairs_CalculateSingleTargettableappendArray                                                                               
   self       skillEffectCalcParam       results      targets      (for generator)      (for state)      (for control)      _      	targetID      result         _ENV #   �    7�   � � A� �@� �� G�� +A� J ��A AA�� $��GA L���� d���A��� ��B�A�� ����$� G�� �  �A ���@ 䂀CC L��d� � ���� �$� LD�d� ����� ���� �$� LE�d� ����� ���� �$� LF�d� �  ̆�� ��$� "  ��G LGGd $  �F�G G��� �dH�)�  ��G� L�d� �G ��H �������� �HC ���@	 �	��	  
 @
 �
��
� �@�����  @�
� ��  L�d� � � 
	� �I��� �I�� ��$� _ �������  	��	�� @	�@��I��  	�̉�� @	���J �	�J @
��� �
 � LK�d� � ̋�� L @ �� ���I��	��L 
M��  �
���J	��ʉ�$��F�G G���
 �
�dJ�L
N�
�  @�� �K�   F�N G����d� �
O@ � ��  @�䊀�G �G@ ��$K����� & � =   skillEffectParamskillRange gridPos_worldGetServiceFormulaGetEntityByIDcasterEntityIDGridLocation	Position
Direction	BodyArea_skillEffectServiceGetCalcTypeGetDistanceGetDirTypeExcludeCasterPosGetExtraParamGetForceUseCasterPosGetUsePickPosIndexGetNotCalcBombGetIgnorePathBlockGetBackupDirectionPlanGetInteractTypeGetIgnorePlayerBlockGetTypeIsCasterPosAsBlockipairsGetAreatableinsert	GetTimes       GetGridPositionCalcHitbackEffectResultGetSkillTypeGetStartPosGetPosTargetGetHitBackPercentGetHitBackFormulaIDGetStopPercentGetStopFormulaIDLoginfoStageIndexdefenderPos：
StartPos:	 EndPos:
 Percent: formulaID:SkillDamageEffectParamNewpercent
formulaIDdamageStageIndexComputeSkillDamageskillIDSkillEffectTypeDamageAfterHitBackNewSkillDamageEffectResult         �   %   '   '   '   (   (   (   (   ,   ,   ,   ,   .   .   .   .   /   /   /   0   0   0   1   1   2   3   6   6   6   6   8   :   :   ;   <   <   =   =   >   >   ?   ?   @   @   A   A   B   B   C   C   D   D   E   E   F   F   G   H   H   I   I   I   I   J   J   J   J   J   K   K   K   K   K   J   J   O   P   P   Q   Q   Q   Q   R   R   U   U   V   W   X   Y   Z   [   \   ]   ^   _   `   a   b   c   d   e   f   f   h   U   i   j   j   k   k   k   k   k   k   l   l   l   m   m   m   m   o   o   o   p   p   p   r   r   r   r   r   r   r   r   r   r   r   r   s   s   s   s   r   t   v   v   v   x   y   z   v   }   }   }   }   }   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   Q   �   �   1   self    �   skillEffectCalcParam    �   defenderEntityID    �   effectParam   �   formulaService   �   	attacker   �   attackerPos   �   attackerDir   �   attackerBodyArea   �   gridPos   �   skillResultList   �   	defender   �   effectCalcSvc   �   	calcType!   �   beAttackEntityID"   �   hitbackDistance$   �   hitbackDirType&   �   excludeCasterPos(   �   extraParam*   �   bUseCasterPos,   �   usePickPosIndex.   �   notCalcBomb0   �   ignorePathBlock2   �   backupDirectionPlan4   �   interactType6   �   ignorePlayerBlock8   �   extraBlockPos9   �   type;   �   (for generator)C   K   (for state)C   K   (for control)C   K   _D   I   bodyD   I   skillRangeL   �   damageTimesN   �   (for index)Q   �   (for limit)Q   �   (for step)Q   �   iR   �   defenderPosT   �   hitBackEffectResultj   �   percentk   �   
formulaIDk   �   hitBackBeginPosm   �   damageStageIndex�   �   	tmpParam�   �   nTotalDamage�   �   listDamageInfo�   �   skillResult�   �      _ENV                        	   	                      #   �   #   �          _ENV