LuaS �

xV           (w@b@../PublishResources/lua/product/core_game/logic/svc/skill_handler/calc_rand_damage_same_half.lua             @ A@  ��@ $@�@@  ��@@ l   
@��@@ l@  
@ �@@ l�  
@��@@ l�  
@ �@@ l  
@��@@ l@ 
@ �@@ l� 
@��& � 
   _class"SkillEffectCalcRandDamageSameHalfObjectConstructorDoSkillEffectCalculator_CalcPreRepeatTargetDmgPer_InitFakeRandomGenerator_CalcFakeRandomIndexLocalLogicRand	Rounding                  
@ �� @ ��@�  ���
���& �    _world_skillEffectServiceGetServiceSkillEffectCalc           
                        self       world               �    *�   �   � � A�$� L��d� ��@ �AB� ���́� �   L��d� ���� �B�� ��$� L��d� ���� �   ��C�� �C ��$D���@ ���A 䃀�@ �C�D $��A� �� b  ��� E$� "   �EE$� �D 
  �� ��	$� "   ���	$� �E
$�   
��� �  @�EF @�	$� �F
 ��@ �C
� $��L�F
ǅ�	�	d� @�
EG ���� �$��\  @�
��D  "  ��M�D	�� @  �A� ��
 ��  @���G  �@ �� @  ����� \��� @ �E�ǅ�E    �
�D"   �ǅ
�  @ �ǅ

��  � G�@ L�� d��b  @������ �H�� �FH   ����H �H� ��	I$� @	 �I� �	� @
�$H �I� ���  Mɂ��O��
I��GI� 
I��
I�$��LHJ��dH�M��G�O��
BL�Jd� FF�F G����� dH�G�H L��  	�GI� �	 �I�  
 dH �  j��ƆK ���@ � �  ��  �D��@��  & � 0   skillEffectParamGetDamagePercentGetDamageFormulaID_worldGetEntityByIDcasterEntityIDGetTargetEntityIDsGetDamageCountGetDampPercentGetPercentAddGetIsSelTargetLoopIsKeepDampListGetIsFakeRandomGetFakeRandomSeed_InitFakeRandomGeneratorGetServiceRandomLogicCalcDamage               HasSuperEntityGetSuperEntitySkillContextGetDamageDampListGetDamageRandomCounttypetable
LogicRand       _CalcPreRepeatTargetDmgPer_CalcFakeRandomIndexGridLocationGetGridPosipairs_skillEffectServiceNotifyDamageBeginGetGridPositionskillIDDoCalcDamagepercent
formulaIDSetRandHalfDamageIndexGetDamageValueinsertNotifyDamageEnd
attackPosSkillDamageEffectResultNew         �                                                                          !   !   "   "   #   #   $   $   $   '   '   '   '   )   )   )   )   *   +   .   .   /   0   0   0   0   1   1   1   1   1   3   3   3   3   5   5   5   5   5   :   :   ;   ;   ;   ;   ;   ;   ;   =   =   =   =   >   >   >   >   ?   A   A   A   A   A   B   B   B   C   D   D   E   F   F   F   G   I   I   J   J   K   K   K   K   K   K   M   M   M   M   M   O   P   P   P   Q   S   S   S   S   S   T   T   V   W   Y   Y   Y   Y   Z   Z   [   [   [   [   \   \   \   \   ]   ]   ^   _   `   `   a   b   c   e   ]   h   i   j   j   l   l   l   l   m   m   n   h   q   q   q   r   t   t   t   u   u   u   v   v   v   v   v   w   w   x   y   z   {   |   ~   w   \   \   �   �   �   �   �   �   �   �   �   �   �   �   �   &   self    �   skillEffectCalcParam    �   results   �   skillDamageParam   �   	percents   �   damageFormulaID   �   	attacker
   �   targets   �   damageDampList   �   damageCount   �   dampPer   �   percentAddParam   �   isSelTargetLoop   �   isKeepDamageList   �   isFakeRandom   �   randomSeed       
randomSvc$   �   svcCalcDamage(   �   curDamageIndex)   �   
lastIndex*   �   super-   ?   damageRandomCountA   �   
randomSvcL   Q   randomCountP   Q   preCalTargetPerV   �   indexZ   �   	targetIDq   �   multiDamageInfo}   �   totalDamage~   �   target�   �   
targetPos�   �   (for generator)�   �   (for state)�   �   (for control)�   �   _�   �   percent�   �   damageInfo�   �   skillResult�   �      _ENV �   �    ;   � $� LA� d� ��� �� �  @�b  ���  �  A ��� h��A\   �  � G�CA ��A�� ��C�g��K  ��A �����ǃ��  � �ǃ���J�  �JA��  *C��  ��A   ���ă"  � �ă  �  ����  j��� & �    GetDampPercentGetIsSelTargetLoopIsRepeatAllSameHalf               tableinsertipairs         ;   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    ;   skillDamageParam    ;   targets    ;   damageCount    ;   dampPer   ;   isSelTargetLoop   ;   isRepeatAllSameHalf   ;   attackTargetArray   :   index   :   (for index)      (for limit)      (for step)      i      	targetID      targetCountDic   :   (for generator)    +   (for state)    +   (for control)    +   _!   )   	targetID!   )   preCalTargetPer,   :   (for generator)/   9   (for state)/   9   (for control)/   9   _0   7   	targetID0   7      _ENV �   �       �@@ � � �� 
� ���@ �    ���@ � A�@  � �@�& �    _randomGeneratorlcgEDITORLogdebug3RandDamageSameHalf:_CalcFakeRandomIndex, initSeed=            �   �   �   �   �   �   �   �   �   �   �   �   �      self       randomSeed          _ENV �   �    ]   � @ �   ���   A@ @� $��K�  J�J��A �BA�� ��B�)�  �A�  FA@ ��d@����ǂA ���@ 䂀�  ���$� CB$�   � �FA GC�� ��dC�i�  ���\ ��  � �K  �A@ � � �ǂ@�"C   �A CA@�� $C���  *����B  �@ ��B  \���  �B@ �� � ǁ����BC "  ��� F�C G��� � C @�dB�� @ ��  �  & �    _randomGeneratoripairsid	oriIndextableinsert_worldGetEntityByIDAttributesGetCurrentHP        LocalLogicRand       EDITORLogdebug5RandDamageSameHalf:_CalcFakeRandomIndex,targetCount= index:         ]   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    ]   targets    ]   damageDampList    ]   targetInfos   Y   (for generator)      (for state)      (for control)      index      	targetID      targetInfo      aliveTargetInfos   Y   (for generator)   +   (for state)   +   (for control)   +   index   )   targetInfo   )   	targetID   )   targetEntity   )   
currentHP"   )   firstLevelTargetInfos0   Y   (for generator)3   ?   (for state)3   ?   (for control)3   ?   index4   =   targetInfo4   =   	targetID5   =   validIndexG   Y   indexM   Y   targetCountQ   X      _ENV �   �    
   � @ �@  @ ��@  �  �@  �� ���@ �@ �@$� �  ��A �@ ��@ � @ � $�  �  �  & �    _randomGenerator�������� random	Rounding           �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       m       n       
randomNum           �   �       � @ �@@� � �� @ @ ��   �� @ �@��� �  �   & �    mathfloor      �?            �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       value       f         _ENV                                 �      �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �          _ENV