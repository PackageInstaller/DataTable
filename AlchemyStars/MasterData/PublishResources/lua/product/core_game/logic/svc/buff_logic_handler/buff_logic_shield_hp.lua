LuaS �

xV           (w@a@../PublishResources/lua/product/core_game/logic/svc/buff_logic_handler/buff_logic_shield_hp.lua         0     
@@�
�@�
@A�
�A�
@B�
�B�
@C�
�C�
@D�
�D�
@E�
�E�F F �@ �   d@�F�F �� � G d@�F�F @��F�F �   J���F�F �@  J� �F�F ��  J���F�F �  � G d@�F H @ �F H ��  J���F H �  J���F H �@ J���& � "   OwnerHP       	CasterHP       LastDamage       SpecificPet       
SpilledHP       OwnerMaxHP       OwnerDefence       OwnerBaseDefence       OwnerBaseAttack	       OwnerAttack
       OwnerLostHPPercent       OwnerMaxHPMulPopCount       _enumHPShieldFromType_classBuffLogicAddHPShieldBuffLogicBaseConstructorDoLogic
DoOverlapBuffLogicRemoveHPShieldDoLogic                  �@@
� ���@�@    �� A 
� �ǀA
���� B
���& � 	   _shieldPercentshieldPercent_shieldFromTypeshieldFromTypeOwnerHP_shieldFromParamshieldFromParam_mulChangeLayermulChangeLayer                                                  self       buffInstance       logicParam          HPShieldFromType !   P       �   � @ �@�� ��$� "  @ �� �@��@ A$� AA$� �  �A �A�� �B BB @��@ $��G�B O���B �  @��� �  ���� �� �AC ǁ�  � O����A ��C  @��� �D �A�A� ��D �E� B�� $B����� $B��@ �E$� F�BF ��F�� �@ ���� $B  �@ �E$� LG�BF ̂�� � 
�ǎ
ȏGCF L��d� 
C��L�Fd� 
C�
C��
��dB G�@ L��d� LB��BF ̂�� dB  F�I LB�̂F�  �d� b   @���� �� �J �B�_�@���� �� �J ǂ��@���� �� ��L�Fd �B  �B�L�� d �B  f & � /   _buffInstanceEntityHasMonsterID_worldPlayerGetCurrentTeamEntity_buffLogicServiceCalcShieldFormValue_shieldFromType_shieldFromParam_shieldPercent_mulChangeLayerGetChangeLayermathabsAddHPShieldDamageInfoNew        DamageTypeRecoverSetHPShieldIsInitShieldGetMatchLogger
BeginBuff_entityGetIDBuffIDAddHPShieldLogkeyCalcAddHPShielddescjBUFF加血条盾 攻击者[attacker] 被击者[defender] 加盾值[addShield] 当前血条盾[curShield] 	attacker	defender
addShield
curShieldEndBuffBuffResultAddHPShieldGetNotifyTypeNotifyTypeSingleChainSkillAttackBeginSinglePetChainSkillAttackBeginGetNotifyEntitySetChainPetEntityIDSetNotifyChainSkillTimeIndexGetChainSkillTimeIndex            $   &   &   &   '   '   '   '   (   (   *   *   *   *   *   *   ,   ,   ,   ,   ,   ,   ,   ,   .   .   /   /   /   /   /   /   0   0   1   1   1   1   1   4   4   4   4   4   5   5   5   5   5   5   6   6   6   7   7   7   9   9   9   9   9   9   9   9   9   9   9   :   :   :   ;   <   <   <   <   >   ?   @   @   @   @   A   A   A   B   C   ;   F   F   F   F   F   F   F   F   H   H   H   H   H   H   I   I   I   I   I   I   I   I   J   J   J   J   J   J   K   K   L   L   L   L   M   M   M   M   O   P      self       notify       buffResultEntity      entity      value      
addShield      layer"   '   curHpSh,      damageInfo2      loggerF      buffResulte      
petEntityu   }      _ENV R   U       �@� 
� ���@ �  �   & �    _shieldPercentshieldPercentDoLogic           S   S   T   T   T   U      self       logicParam            Z   \       �@@
� �& �    	_isOwnerisOwner           [   [   \      self       buffInstance       logicParam            ]   s    
C   � @ �@@�� ��@�� ��@ �   � �� A �@�� � �̀A� ���FB GA�䀀�@  @�̀A� ̀�A� � �@ �@C ̀�A ��C �D� A�� $A��D �C��D�� ��$� b   @�L� d� �AE ��E_��@�L� d� �AE ��E��@�L� d� �AF��$ �A  ��F�� $ �A  & & �    _worldPlayerGetCurrentTeamEntity	_isOwner_buffInstanceEntityBuffComponentHasBuffEffectBuffEffectTypeShieldToHPSetBuffValue	HPShield        DamageInfoNewDamageTypeRecoverSetHPShieldBuffResultRemoveHPShieldGetIDGetNotifyTypeNotifyTypeSingleChainSkillAttackBeginSingleChainSkillAttackFinishGetNotifyEntitySetChainPetEntityIDSetNotifyChainSkillTimeIndexGetChainSkillTimeIndex         C   _   _   _   _   _   `   `   `   a   a   a   a   d   d   d   d   d   d   d   d   e   e   e   e   e   e   g   g   g   g   g   g   h   h   h   j   j   j   j   j   j   k   k   k   k   k   k   k   k   l   l   l   l   l   l   m   m   n   n   n   n   o   o   o   o   r   s      self    C   notify    C   entity   C   damageInfo    C   buffResult)   C   
petEntity9   A      _ENV u   v       & �                v      self           0               	   
                                                               !   P   !   R   U   R   X   X   X   X   Y   Y   Z   \   Z   ]   s   ]   u   v   u   v      HPShieldFromType   0      _ENV