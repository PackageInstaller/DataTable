LuaS �

xV           (w@c@../PublishResources/lua/product/core_game/logic/svc/buff_logic_handler/bl_hp_shield_by_notify.lua             @ A@  ��@ $@�@@  ���  
 ��
���F�A �  �   d@�F@@ �   J���F@@ �@  J� �F@@ ��  J���& �    _classBuffLogicAddHPShieldByNotifyBuffLogicBasePercent       Value       _enumHPShieldByNotifyCalcTypeConstructorDoLogic
DoOverlap                  �@@
� ���@
� ��@A�@  @ �ƀA ���
� ��@B
� ���B
� �& �    _shieldNumbershieldNumber_shieldCalcTypeshieldCalcType_shieldFromTypeshieldFromTypeHPShieldFromTypeOwnerHP_shieldFromParamshieldFromParam_shieldTeleportMulshieldTeleportMul                                                            self       buffInstance       logicParam          _ENV    f    �   �   � @ �@�� ��$� "  @ �� �@��@ A$� AA$� �  � G�A b   �GB LA��� �A G�B ���@ d�� �D  ��� �� �C �A��@���@ ��C� ����D �A��D$� L�Dd �  � $� LB� d� ��� �� ��E� ���   _@��AC ���C h��F�F G��� ��  d� �G �DG	�� �����  @ �    �g��G�G OA@ �� A� F�G G��C � � @��� ǄG dC�bA    �& � �I �  BI F�� @��B́�G HA�	 � �
   AC
 �I ��
  �A�
 $B ��BI F� @��́��G HAB � �B
 I A�
 ���� $B �A    �& � B �K� ��$� FL LB��� �L �Ld� ��  �B��B�� �B���@ ��M�� ��MN CN$� G@ L��d �B  ��@ ��M�� ��NGN LC�d� �C �CO���O��N �C�� ����Á����B ��@ ̂�� ���GN LC�d �B  �Q �B�LCNd� ��� � & � E   _buffInstanceEntityHasMonsterID_worldPlayerGetCurrentTeamEntity        _shieldFromType_buffLogicServiceCalcShieldFormValue_shieldFromParamGetNotifyTypeNotifyType	TeleportGetServiceBoardLogicmathmaxGetCurBoardMaxXGetCurBoardMaxY
GetPosOld
GetPosNewGetNotifyEntity	BodyAreaGetArea       ComputeScopeRangeComputeRange_SquareRingtableVector2Include_shieldTeleportMulLogfatal瞬移圈数：瞬移加成值：瞬移每圈加成值：_shieldNumber_shieldCalcTypePercent类型1 基础护盾值=基础取值：配置数值：最终值：` 公式=瞬移圈数 * 每瞬移一圈提升的数值 * 基准值类型取值 + 基础护盾值Value类型2 基础护盾值=H 公式=瞬移圈数 * 每瞬移一圈提升的数值 + 基础护盾值AddHPShieldDamageInfoNewDamageTypeRecoverSetHPShieldIsInitShieldGetMatchLogger
BeginBuff_entityGetIDBuffIDAddHPShieldLogkeyAddHPShieldByNotifydesc[BUFF瞬移加血条盾 施法者[caster]  加盾值[addShield] 当前血条盾[curShield] caster
addShield
curShieldEndBuffBuffResultAddHPShield          �                                                       !   !   !   "   "   "   "   "   "   "   "   "   $   %   %   %   %   %   %   '   '   '   '   (   (   (   (   (   (   (   )   )   *   *   +   +   ,   ,   ,   ,   -   .   .   /   /   /   /   1   1   1   1   1   1   2   2   2   2   2   2   2   3   3   /   7   7   7   9   :   <   <   <   <   <   <   <   <   <   >   >   ?   A   B   C   C   C   C   D   D   E   E   E   E   E   E   E   E   E   E   F   E   F   G   G   G   G   H   I   I   I   I   I   I   I   I   J   I   M   M   N   Q   Q   Q   Q   Q   R   R   R   R   R   R   S   S   S   T   T   T   V   V   V   V   V   V   V   V   V   V   V   W   W   W   X   Y   Y   Y   Y   [   \   ]   ]   ]   ]   ^   _   X   b   b   b   b   b   b   b   b   d   d   d   d   d   d   e   f      self    �   notify    �   buffResultEntity   �   entity   �   value   �   notifyValue   �   	boardSvr(   ^   maxTeleportRing/   ^   oldPos1   ^   teleportPos3   ^   casterEntity5   ^   	bodyArea9   ^   teleportDis:   ^   (for index)?   P   (for limit)?   P   (for step)?   P   i@   O   
ringRangeF   O   baseShieldValueb   �   finalShieldValuec   �   curHpSh�   �   damageInfo�   �   logger�   �   buffResult�   �      _ENVHPShieldByNotifyCalcType h   k       �@� 
� ���@ �  �   & �    _shieldPercentshieldPercentDoLogic           i   i   j   j   j   k      self       logicParam                                      	                           f      h   k   h   k      HPShieldByNotifyCalcType	         _ENV