LuaS �

xV           (w@p@../PublishResources/lua/product/core_game/logic/svc/buff_logic_handler/bl_addhp_by_target_buff_effect_type.lua             @ A@  ��@ $@�@@  ��@@ l   
@��@@ l@  
@ �& �    _class%BuffLogicAddHPByTargetBuffEffectTypeBuffLogicBaseConstructorDoLogic                  
@@�ǀ@�   @ �ǀ@
� �� A
���ǀA
���� B
���& � 	   
_baseType       	baseType_buffEffectTypebuffEffectType
_mulValue	mulValue_mulValueHighmulValueHigh           	   
   
   
                                 self       buffInstance       logicParam               s    �   � @ �@@�� ̀@� �@ A�A $��G�@ L��� d�����  ��� �GB LB�d� b  ��G�B ����GB LB�d� L�d� ��@ �BC ����̂C�  �A� �   � ��� ��    �R��  �BD� �  @ ��  �̂D� �   ���D� ��� ���  ��̂@� �B�A� 䂀�    �& � � �� $� K  �  �F   � ��@ EF
��	$��@ ��� 
d��bE  ��L�F
d� bE  � �\�M��
J�
�  j���F� ��AD 䃀�C    ��� F @�$��L�G� 
�G d� b  @� @�����@
�� �H�� ̅@
� �E�� �G�H   �  �Oƃ�F�F͂�)�  �D��@$� DE�� $��"D    � LDBd� b    ��  L�@d� L�d�  �  �& � M���B�FI GD���d� ��G�@ L���	 d����I �J	 �FEJ G��
�� ���LKd� � 	�D �DK ��	@�� 	� � & � .   _buffInstanceEntityAttributes_worldGetService
BuffLogicBattleGetCasterHP_entity	PetPstID
_baseType       	GetPstIDGetPetDataGetPetHealth               HasTeamHasPetPstIDPetGetOwnerTeamEntityGetAttributeBuffForbidCureGetDefenderEntityIDListipairsGetEntityByIDTrapBuffComponentGetBuffValueAddHPRateByTargetHPGetBuffLayer_buffEffectTypeGetCurrentHP
CalcMaxHp
_mulValueAddBloodRatemathceilCalcDamageDamageInfoNewDamageTypeRecoverAddTargetHPGetID&BuffResultAddHPByTargetBuffEffectType         >   F    
   � � �� �@@    � @��$� � @ �� & �  j���   �  & �    GetIDipairs            ?   ?   @   @   @   @   A   A   A   A   B   B   @   @   E   E   F      list       entity       	entityId      (for generator)      (for state)      (for control)      _      v         _ENV�                                                       !   !   !   !   !   "   "   "   #   #   #   #   #   %   %   %   %   &   &   &   *   +   +   +   +   +   +   ,   0   1   1   1   1   2   2   3   3   3   3   4   4   4   4   4   6   6   6   6   6   6   6   6   6   7   :   ;   ;   <   F   H   H   H   H   I   I   I   I   K   K   K   K   K   K   K   K   K   K   L   L   L   H   H   P   P   P   P   P   P   P   P   Q   Q   Q   Q   R   R   R   R   S   S   S   S   T   T   T   T   U   U   U   U   V   W   X   X   Y   [   [   [   Q   Q   _   _   _   _   _   _   _   _   a   a   a   a   b   e   e   e   e   e   e   f   i   i   j   j   j   j   j   l   l   l   l   n   n   n   n   n   n   o   o   o   o   o   q   q   q   q   q   r   s   &   self    �   notify    �   e   �   	attrCmpt   �   buffSvc	   �   battleService   �   calcPercentHp   �   calcPercentMaxHp   �   calcValueMaxHP   �   pstId   %   petData"   %   
hpPercent&   �   teamEntity.   �   
recoverHpH   �   targetEntityListJ   �   entityListK   �   isContainEntityFuncL   �   (for generator)O   c   (for state)O   c   (for control)O   c   _P   a   	entityidP   a   entityT   a   addHPRateByTargetHPk   �   (for generator)n   �   (for state)n   �   (for control)n   �   _o   �   targetEntityo   �   layers   �   	targetHp{   �   targetMaxHp   �   p�   �   	mulValue�   �   rate�   �   svc�   �   damageInfo�   �   result�   �      _ENV                                 s      s          _ENV