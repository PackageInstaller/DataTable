LuaS �

xV           (w@Y@../PublishResources/lua/product/core_game/logic/svc/skill_handler/calc_stamp_damage.lua             @ A@  ��@ $@�@@  ��@@ l   
@��@@ l@  
@ �@@ l�  
@��& �    _classSkillEffectCalc_StampDamageObjectConstructorDoSkillEffectCalculator_CalculateSingleTarget                  
@ �� @ ��@�  ���
���& �    _world_skillEffectServiceGetServiceSkillEffectCalc           
                        self       world                      �   � � � A@ @�$��L�@ ��   d� b   ���@ �A�  ��B�)�  ����  & �    GetTargetEntityIDsipairs_CalculateSingleTargettableappendArray                                                                              
   self       skillEffectCalcParam       results      targets      (for generator)      (for state)      (for control)      _      	targetID      result         _ENV     �    .�   � � A�$� L��d� ��@ �AB� �����@ ��@ 䁀��@��A BAB � $B��B �B�  � C AC �  $��& ��$� �CK  ���� �BD� �D @�$��F�D �E�E��	�DEEE��	d������E	JB	)�  ����� �A��  J ���� G�� \�M���� 
���@ CF�� $��L�F�� d���C��� ƃG ���H DH @ ��G ǃH  F�D ��� d�����
�A@���D ��
���ƆD  �� ��� � �E
��  j���  *������D ��� ���
� �� ͆�
D���  *�i�  �D�G� L�d� �� �DI	�� ��@ �D�	A�	 䄀�@ EF
��	 $��G�@ LE�
�
 d����@ �EJ�� �  �D @ $��AG ����� ��J@ 	䇀�  � ��$� OG @�� ��A HKA� ��$H���	� ��  	�@	�$H �$� GHL L��� �� @	��	 �	�  
�F
M GJ��
 �
� @ dȀ̈�	@	 �� �	��H�ƈB ���@	 �	 �	� 
 � 	��E��)�  ���� & � 7   skillEffectParamGetDamagePercentGetDamageFormulaID_worldGetEntityByIDcasterEntityID Lognotice+CalculationForeachTarget defender is null SkillDamageEffectResultNew��������        GridLocation	Position	BodyAreaGetAreaipairsVector2xy       skillRangegridPosGetServiceConfigGetSkillConfigDataskillIDGetSkillTypeModifySkillParamTypeChainSkill
SkillTypeActiveActiveSkill_classNameGetAddDamageByStamp
GetBuffID
BuffLogicFormulaCalcDamageBattleStatBuffComponentGetBuffByIdGetLayerCountdebug+Buff have stamp , and DamageCoefficient = ChangeSkillFinalParamGetSkillEffectDamageStageIndex_skillEffectServiceComputeSkillDamage
attackPosSkillEffectTypeDamageRemoveSkillFinalParam         �   "   #   #   $   $   &   &   &   &   (   (   (   (   )   )   *   *   *   *   *   ,   ,   ,   ,   ,   ,   ,   ,   -   1   1   1   3   5   5   6   6   7   7   7   7   8   8   8   8   8   8   8   8   9   9   9   7   7   <   <   <   =   =   >   >   >   >   >   >   A   A   A   A   C   C   C   D   D   E   E   F   F   F   F   G   G   I   K   K   K   K   L   L   L   N   N   N   N   O   O   O   O   P   P   Q   Q   Q   O   O   N   N   T   V   V   V   V   W   W   X   X   X   V   V   K   K   ^   ^   ^   _   _   _   b   b   b   b   d   d   d   d   f   f   f   f   h   h   h   i   j   j   j   j   k   l   l   m   m   m   n   n   o   o   p   r   r   s   s   s   s   s   x   x   x   x   x   x   y   y   z   z   {   |   }   ~      �   �   �   �   �   �   z   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   j   j   �   �   @   self    �   skillEffectCalcParam    �   defenderEntityID    �   skillDamageParam   �   	percents   �   damageFormulaID   �   	attacker	   �   	defender   �   skillResult      defenderPos    �   defenderAreaList!   �   defenderAreaCmpt#   �   defenderArea%   �   (for generator)(   6   (for state)(   6   (for control)(   6   _)   4   areaOffset)   4   areaPos1   4   configServiceE   �   skillConfigDataH   �   
skillTypeJ   �   attrModifyTypeL   �   attackRangeListS   �   (for generator)V   y   (for state)V   y   (for control)V   y   _W   w   skillRangePosW   w   (for generator)]   k   (for state)]   k   (for control)]   k   _^   i   curPos^   i   (for generator)a   i   (for state)a   i   (for control)a   i   _b   g   areaPosb   g   (for generator)o   w   (for state)o   w   (for control)o   w   _p   u   areaPosp   u   addDamageRate|   �   addDamageBuffId   �   buffService�   �   formulaService�   �   svcCalcDamage�   �   battleStatCmpt�   �   skillResultList�   �   (for generator)�   �   (for state)�   �   (for control)�   �   _�   �   
damagePos�   �   DamageCoefficient�   �   defenderBuffComp�   �   buffInstance�   �   count�   �   damageStageIndex�   �   totalDamage�   �   listDamageInfo�   �   skillResult�   �      _ENV                                           �       �          _ENV