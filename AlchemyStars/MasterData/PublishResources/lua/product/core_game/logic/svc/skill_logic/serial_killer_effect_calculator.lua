LuaS �

xV           (w@e@../PublishResources/lua/product/core_game/logic/svc/skill_logic/serial_killer_effect_calculator.lua             @ A@  ��@ $@�@@  ��@@ l   
@��@@ l@  
@ �@@ l�  
@��@@ l�  
@ �& �    _classSerialKillerEffectCalculatorObjectConstructorDoSerialKillerCalc_CalcSkillSerialKillerEffect_CalExtraAttackCount                  
@ �� @ ��@�  ���
���� @ ��@A ���
� �� @ ��@� ���
� �& �    _world_configServiceGetServiceConfig_skillLogicServiceSkillLogic_skillEffectCalcServiceSkillEffectCalc                                                                 self       world               <    K   � � � �@�� ��$� L��d� ���� �AA L�� d� � �   � �A BLB�d $�  F�B �B�� d �
���� ����CCL�� d �C  ̃�@��C���C ��AD 䃀�C �D��C ��D	�E	$��F�B �DE� d � ���� �
�E�i�  ��G�C L��� d������ �  @� � ��D�� �D�@ �i�  �B�� & �    SkillContextGetResultContainerGetSkillIDGetScopeResultGetTargetIDs_CalcSkillSerialKillerEffectGetIDtablecountGetKilledArrayipairsGetDamageInfo       SetAttackerEntityIDAddEffectResult_worldGetServiceMonsterShowLogic	GetGroupBW_WEMatchers
MonsterIDGetEntitiesAddMonsterDeadMarkBattleIsFinalAttackSetFinalAttack         K                                   #   #   #   #   #   #   #   $   $   $   $   $   %   %   %   %   %   '   '   '   (   (   (   (   )   )   )   ,   ,   ,   ,   -   -   -   -   -   -   .   .   .   .   .   /   /   /   .   .   3   3   3   3   5   5   5   5   5   5   6   6   6   6   %   %   ;   <      self    K   casterEntity    K   skillEffectParam    K   skillEffectResultContainer   K   skillID   K   scopeResult   K   
targetIDs
   K   result   K   count   K   (for generator)   I   (for state)   I   (for control)   I   index   G   res   G   damageInfo   G   sMonsterShowLogic)   G   monsterGroup/   G   (for generator)3   9   (for state)3   9   (for control)3   9   _4   7   e4   7   battleService=   G      _ENV @   �    -�   @����� �A�� ��$� L��d� �A �BA� ����A ���@� 䂀B CB$� L�B �� �d� ��B@ �C�MB�� � �  �    FEC � d ��A ��A ����̆C� ����  ��� ��	D�Di�  ��GA LE�
d� ���
�� �A �E�A� 䅀A E$� FFE G��_@ (�GA LF��� d���A �FA ����  �A ��$�"D   ���	! ���� 	a � #��G�A � 	� �	GA L��� d�� �@ ���G�A ��	� ȇ	GA L��� d�� �@ � H
"H    ��ǁA HA�� $��L�F�� 	 L	�d� �	G�� �	 dH�FHG LH���d������� J��J��J��J��J��J����� J�����I 	�@	 �	������I@	��	 �	�� 
G$� @
 �
 �
J �J�  �H �H
�H  � ��  �H��Õ
ň�H
��L	Kd� I	���IK IB�	G�� �	�
K$� K
� �
 kJ� $� L�K�	 dI�L�Cd� L��d� ! ���A	 �	�	�	 h	�G
�	@�@�F�K G
��
�	�
 dJ�  �gI�C	  �	 �	 	
 �	��J
	@@ �C	�   ��I�bI   ���K �IL�	 	 
��I�� ��& & � 2   GetPercentGetMultipleGetFormulaIDGetKillCount_worldGetServiceFormulaGetEntityByIDSkillSerialKillerResultNew_CalExtraAttackCountSetAddPiecePosList        ipairsAttributesGetCurrentHP       GameFSMCurStateIDRandomLogicBattleStatGameStateIDPreviewActiveSkillMathCalcDamage
LogicRandSkillEffectCalcNotifyDamageBeginGetGridPositionSkillDamageEffectParam_pureDamageGetPureDamage	_percent_formulaIDpercentskillID
formulaID
attackPosDoCalcDamageNotifyDamageEndSkillEffectTypeSerialKilleriddamageGetDamageValueSkillDamageEffectResultAddOneKilledtableremoveinsert         �   F   G   G   H   H   I   I   J   J   M   M   M   M   N   N   N   N   O   O   O   Q   Q   Q   Q   R   R   R   S   T   U   X   Y   Z   [   [   [   [   ]   ]   ]   ]   ^   ^   ^   ^   _   _   `   `   `   [   [   c   c   c   d   d   g   g   g   g   i   i   i   j   j   j   j   k   k   k   k   m   m   m   m   o   o   o   o   q   q   r   r   r   s   s   s   w   w   w   w   x   y   y   y   y   y   z   z   }   }   }   }   ~                  �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   o   �   �   :   self    �   casterEntityID    �   nearestEntityIDs    �   skillEffectParam    �   skillID    �   param   �   percent   �   firstMultiple   �   damageFormulaID   �   
killCount	   �   formulaService   �   	attacker   �   res   �   extraAttackCount   �   addPiecePosList   �   
hasDamage   �   curDefendEntity   �   curDefendEntityId   �   deadDefnderIdList   �   defenderIdList    �   damageList!   �   (for generator)$   4   (for state)$   4   (for control)$   4   k%   2   defenderEntityID%   2   	defender)   2   curHp-   2   gameFsmCmpt7   �   gameFsmStateID9   �   
randomSvc=   �   battleStatCmpt@   �   mathServiceH   �   svcCalcDamageL   �   (for index)O   �   (for limit)O   �   (for step)O   �   iP   �   randomIndex\   c   defenderId]   c   randomIndexh   o   defenderIdi   o   tmpPercentp   �   effectCalcServicex   �   _damageParam�   �   damageInfo�   �   damageSaveData�   �   curDamageSaveData�   �   damageResult�   �   (for index)�   �   (for limit)�   �   (for step)�   �   i�   �   isFind�   �   (for index)�   �   (for limit)�   �   (for step)�   �   i�   �      _ENV �   
   A   � � � A� $� L�@d� ��@�� �A�� �AA ́�A� 䁀�$� LBB���  
�
Å@�� d� �BA �BC�� ��C�� � CA �A�� $��L� d� �  b  ���C�� �D @�$��LD� 
d��@�
@�͂���D �E�   
�E�)�  ����C� � � �@ &�& �    GetSerialScopeType
GetRadiusGetGridPosition	BodyAreaGetArea_worldGetServiceUtilScopeCalcGetSkillScopeCalcComputeScopeRange                      GetBoardEntityBoardBoardRenderGetPieceTypeGetAttackRangeipairstableinsertGetOnePieceAddAttackCount         A   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �                            �   �         	  	  	  
     self    A   param    A   	attacker    A   serialScopeType   A   radius   A   
posCaster   A   casterBodyArea
   A   utilScopeSvc   A   scopeCalculator   A   scopeResult   A   board   A   extraAttackCount   A   boardService"   A   
pieceType$   A   addPiecePosList%   A   array)   :   (for generator),   :   (for state),   :   (for control),   :   _-   8   v-   8   pt0   8   onPieceAddAttackCount<   A      _ENV                                 <      @   �   @   �   
  �   
         _ENV