LuaS �

xV           (w@a@../PublishResources/lua/product/core_game/logic/svc/skill_handler/calc_coffin_musume_candle.lua             @ A@  $@ �@ A�  � A $@��@  ���@ l   
@��& �    require
calc_base_class#SkillEffectCalc_CoffinMusumeCandleSkillEffectCalc_BaseDoSkillEffectCalculator           �     '  � � �@@�   A�  ��@ �A�@ BA�A�����A   � ��$� "   ���$� C@$� � ��C�$� �B��B �C$��@C@ �MA� ��C �C@ ��$C��  j��D� BD$� L�Dd� ��D�� �E�   D !��@�DE �E\ � $��G�@ L��� d���D � E ����E�F \ �� ƅC ǅ�  @ 䅀�C �C@ ���� $F  ����G�� � 	�  @0���@ �DG	�� ��G	�� ��G ��	G�@ 䄀EH H
��� �� �  �F	$ �E   �L�� d� �� �� �F� � �� $� L�� d� �� � $�  LE�	� 
d���C�
@'�!@�@�DE �E\ � $��G�@ L��� d���D � E ����E�F \ �� ƅC ǅ�  @ 䅀�C �C@ ���� $F  �����J�� � 	�  @���@ �DG	�� ��G	�� ��G ��	G�@ 䄀EH H
��� �� �  �F	$ �E   �L�� d� �� �� �F� � �� $� L�� d� �� � $�  LE�	� 
d���C�
@��J$� � �  ���@ DG$� �G$� F�G L���@ d���DH �H	�� $� K  ��F� kE  ����� � � $� LF� d� ��� �� ��� � � $ ��  �D�@ 	䄀�C�	 ��@ K�D� $��F�K L���K ��	 �LELd� �� ��L� d�  @�L�Ld� ���� �DE �D�	�	� ���E� ��	$E �@ �M
$� LN
��F� � 
�Μ
ϝGF� 
F��
��
Ƃ�O�	
F�
Ƅ�dE   F�P L��  �@ ��d +D  & & � C   skillEffectParam
GetTrapID        _worldGetGroupEntitiesBW_WEMatchersTrapipairsHasBuffBuffComponentGetBuffValueBattleConstCandleLightKey       tableinsertGetStage1CountGetStage1ParamGetStage2CountGetStage2ParamGetStage3ParammathminGetServiceRandomLogic
LogicRandremoveGetIDGetStage1DamageParamPlayerGetLocalTeamEntitySkillEffectCalc_DamageNewSkillEffectCalcParamGetCasterEntityIDGetSkillIDGetSkillRangeGetAttackPosGetGridPosGetCenterPosGetWholeRangeDoSkillEffectCalculatorGetStage2DamageParamGetStage3DamageParamGetEntityByIDcasterEntityIDSkillEffectResult_AddBloodAddBlood_TypePercentGetGridPositionGetSkillEffectDamageStageIndexAttributes
CalcMaxHpfloorSetAddDataGetMatchLoggerAddBloodLogkeyCalcAddBlooddesc�棺材娘专属【CoffinMusumeCandle】技能加血 受益者[attacker] 最大生命值[maxHP] * 系数[stage3Param] = 增加值[val] => 取整[floorVal]	attackermaxHPstage3Paramval	floorVal%SkillEffectResult_CoffinMusumeCandle         '  
                                                                                                                                          !   !   "   "   $   $   &   (   -   -   /   /   /   /   /   1   1   1   1   2   2   2   2   3   3   3   3   4   4   4   4   4   5   5   5   5   5   5   2   8   8   8   9   9   :   :   :   :   :   <   <   <   <   =   =   >   >   >   ?   ?   ?   @   A   A   B   B   C   C   D   D   E   E   F   F   =   H   H   H   I   J   K   K   M   M   M   M   M   O   O   O   O   P   P   P   P   Q   Q   Q   Q   R   R   R   R   R   S   S   S   S   S   S   P   V   V   V   W   W   X   X   X   X   X   Z   Z   Z   Z   [   [   \   \   \   ]   ]   ]   ^   _   _   `   `   a   a   b   b   c   c   d   d   [   f   f   f   g   h   j   j   j   k   k   l   l   l   l   l   n   n   n   n   o   o   p   p   p   q   q   q   r   s   s   t   t   u   u   v   v   w   w   x   x   o   z   z   z   {   {   ~   ~   ~   ~         �   �   �   �   �   �   �   �      �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   6   self    '  skillEffectCalcParam    '  sep   '  trapID   '  
lightsOff   '  lightCount   '  globalTrapEntities   '  (for generator)   *   (for state)   *   (for control)   *   _   (   e   (   stage1Count,   '  stage1Param.   '  stage2Count0   '  stage2Param2   '  stage3Param4   '  selectedLights5   '  addHPResult6   '  damageResult6   '  damageParam6   '  max=   }   randsvcA   }   (for index)D   U   (for limit)D   U   (for step)D   U   iE   T   randI   T   eLuckyTrapN   T   playerTeamEntity_   }   damageCalcc   }   damageCalcParamy   }   tDamageResults|   }   max�   �   randsvc�   �   (for index)�   �   (for limit)�   �   (for step)�   �   i�   �   rand�   �   eLuckyTrap�   �   playerTeamEntity�   �   damageCalc�   �   damageCalcParam�   �   tDamageResults�   �   playerTeamEntity�   �   damageCalc�   �   damageCalcParam�   �   tDamageResults�   �   casterEntity�     cAttributes    maxHP    val    logger       _ENV                                 �      �          _ENV