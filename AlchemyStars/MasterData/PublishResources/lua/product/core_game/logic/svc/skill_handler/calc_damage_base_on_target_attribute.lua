LuaS �

xV           (w@�@E:/depot_matchsrpg/matchsrpg/b/140/client/Assets/../PublishResources/lua/product/core_game/logic/svc/skill_handler/calc_damage_base_on_target_attribute.lua             @ A@  $@ �@ A�  � A $@��@  ���@ l   
@���@ l@  
@ ��@ l�  
@���@ l�  
@ �& � 	   require
calc_base_class-SkillEffectCalc_DamageBasedOnTargetAttributeSkillEffectCalc_BaseConstructorDoSkillEffectCalculator_OnGetCompareAttribute_CalculateSingleTarget        
          
@ �� @ ��@�  ���
���& �    _world_skillEffectServiceGetServiceSkillEffectCalc                                   self       world                      �   � � � A@ @�$��L�@ ��   d� b   ���@ �A�  ��B�)�  ����  & �    GetTargetEntityIDsipairs_CalculateSingleTargettableappendArray                                                                              
   self       skillEffectCalcParam       results      targets      (for generator)      (for state)      (for control)      _      	targetID      result         _ENV !   8    
&   �   �@ ��  �@�@ ���  �Ɓ@ ��� @��A�@A@�́A� ���� B BBOB�$� � � ́A� ́�@ 䁀B BBOB�$� � � & �    SkillTargetSelfLognotice4_OnGetCompareAttribute entity is null.  entityTag =MaxHPAttributes
CalcMaxHpmathfloorGetAttribute         &   '   (   (   )   )   *   *   +   +   -   -   -   -   -   /   /   0   0   0   0   1   1   1   1   1   2   4   4   4   4   4   5   5   5   5   5   7   8   	   self    &   	attacker    &   	defender    &   
entityTag    &   
attribute    &   param    &   entity   &   maxHP      entityAttribute   &      _ENV ;   �    !�   � � A@ �@� $���@��FA GA��� � dA�G�A L��  B A� �� d���� ���A� � GA@ L����� d������ �A�� ��$� L��d� ���� �BD @�� �  �A� 䂀CD ���   @�� $��L��d� �  �E �C��� �_ �  ��C  �� �
��E ǃ��� � �  ��C  �� ���E ����� �`�  ��C  �� @��E ���� �a�  ��C  ��  ��E �C��� �` �  ��C  �� ���E ǃ���� �a �  ��C  �� �C    �& � ���� �  ���$� DG��$��"D    �& � ��$� L��d� b  ������ �DH	�� ̄H	F�H G�
��� �  @�EI �I
@�	$� �B
  �& �   F�I ��	d�����J� ��@ �  @ �i�  ��"E    �& � �D� �@	� ��� Ǆ� �D� J����D@ ��J	 ����D� �� L��d� ��A ̅K@���	�   
G�� ����H �� �
�� LB� 
  @�� ��
d���  �FI ��  @��F�� & � 1   skillEffectParam_worldGetEntityByID Lognotice+CalculationForeachTarget defender is null _skillEffectServiceNewSkillDamageEffectResult��������        casterEntityID
GetTargetGetTargetAttributeGetCompareGetCompareAttributeGetCompareParam_OnGetCompareAttribute       GetCompareSymbolComparisonOperatorEQNEGTGELTLEGetOwnerBuffEffectBuffComponentHasBuffEffectGetSkillEffectDamageStageIndexGetPreDamageStageIndexSkillContextGetResultContainerGetEffectResultsAsArraySkillEffectTypeDamagetablecountipairsGetTargetIDskillRangegridPosGetServiceFormula
attackPosComputeSkillDamageskillIDinsert         �   =   A   A   A   A   B   B   C   C   C   C   C   E   E   E   E   E   E   E   F   F   F   F   L   L   L   L   N   N   O   O   P   P   Q   Q   R   R   T   T   T   T   T   T   T   U   U   U   U   U   U   U   W   W   X   Y   Y   Y   Y   Z   Z   Z   Z   Z   [   [   [   [   \   \   \   \   \   ]   ]   ]   ]   ^   ^   ^   ^   ^   _   _   _   _   `   `   `   `   `   a   a   a   a   b   b   b   b   b   c   c   c   c   d   d   d   d   g   g   h   l   l   m   m   n   n   n   n   n   n   n   o   t   t   u   u   v   v   x   x   x   x   z   z   z   z   z   |   |   |   |   |   |   |   |   }   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   &   self    �   skillEffectCalcParam    �   defenderEntityID    �   skillDamageParam   �   	defender   �   skillResult      	attacker   �   
targetTag   �   argetAttribute   �   compareTag!   �   compareAttribute#   �   compareParam%   �   targetAttribute,   �   compareAttribute3   �   compareSymbol5   �   
satisfied6   �   ownerBuffEffectp   �   damageStageIndex|   �   preDamageStageIndex~   �   skillEffectResultContainer�   �   damageResultArray�   �   defenderDamageResult�   �   (for generator)�   �   (for state)�   �   (for control)�   �   _�   �   v�   �   damageResult�   �   targetEntityID�   �   formulaService�   �   
attackPos�   �   gridPos�   �   damageStageIndex�   �   effectCalcSvc�   �   nTotalDamage�   �   listDamageInfo�   �   skillResult�   �   skillResultList�   �      _ENV                              
      
            !   8   !   ;   �   ;   �          _ENV