LuaS �

xV           (w@M@../PublishResources/lua/product/editor/auto_test/auto_test_checker_buff.lua         J   � 
���
 ��
���
 
�
 Å
�Æ
 ć
�Ĉ
 ŉ
�Ŋ
 Ƌ
�ƌ
 Ǎ
�ǎ
 ȏ
�Ȑ
 ɑ
�ɒ  �� l   
@ �l@  
@ �l�  
@ �l�  
@ �l  
@ �l@ 
@ �l� 
@ �l� 
@ �l  
@ �l@ 
@ �l� 
@ �l� 
@ �l  
@ �l@ 
@ �l� 
@ �l� 
@ �l  
@ �l@ 
@ �l� 
@ � �� J A@
 ��J $@�@J  ��@J l� 
@��@J l  
@ �& � -   AutoTestBuffLogicTable眩晕ATBuffStun恐惧ATBuffSCared睡眠ATBuffSleep灼烧ATBuffBurn中毒ATBuffPoision流血ATBuffBleed麻痹ATBuffBenumb免控ATBuffImmuneControll致盲ATBuffAddMiss闪避ATBuffAddDodge无敌ATBuffInvincible锁血ATBuffLockHP禁疗ATBuffForbidAddHP诅咒ATBuffSealed
层数盾ATBuffLayerShield
血条盾ATBuffBloodShield免疫普攻ATBuffImmuneNormal免疫技能ATBuffImmnueSkill二次连锁ATBuffDoubleChainAutoTestBuffLogicCheckTable_classCheckBuffLogic_TestAutoTestCheckPointBaseBeforeCheckCheck                  � � � �@�F�@ G��� ��   & �    BuffComponentHasFlag
BuffFlags	SkipTurn                                       notify       entity       world          _ENV            � � � �@�F�@ G��� ��   & �    BuffComponentHasBuffEffectBuffEffectTypeFear                                        notify       entity       world          _ENV !   #       � � � �@�F�@ G��� ��   & �    BuffComponentHasBuffEffectBuffEffectTypeSleep            "   "   "   "   "   "   "   #      notify       entity       world          _ENV $   &       � � � �@�F�@ G��� ��   & �    BuffComponentHasBuffEffectBuffEffectTypeBurn            %   %   %   %   %   %   %   &      notify       entity       world          _ENV '   )       � � � �@�F�@ G��� ��   & �    BuffComponentHasBuffEffectBuffEffectTypePoison            (   (   (   (   (   (   (   )      notify       entity       world          _ENV *   ,       � � � �@�F�@ G��� ��   & �    BuffComponentHasBuffEffectBuffEffectTypeBleed            +   +   +   +   +   +   +   ,      notify       entity       world          _ENV -   1       � � � �@�F�@ G��� ��   & �    BuffComponentHasFlag
BuffFlagsBenumb            0   0   0   0   0   0   0   1      notify       entity       world          _ENV 2   4       � � � �@�F�@ G��� ��   & �    BuffComponentHasBuffEffectBuffEffectTypeControlImmunized            3   3   3   3   3   3   3   4      notify       entity       world          _ENV 5   7       � � � �@�F�@ G��� ��   & �    BuffComponentHasFlag
BuffFlagsSealedCurse            6   6   6   6   6   6   6   7      notify       entity       world          _ENV 8   ;       � � � �@�A�  䀀#�� �`���  �A  � & & �    BuffComponentGetBuffValueMiss                   9   9   9   9   9   :   :   :   :   :   :   :   ;      notify       entity       world       
buffValue           <   ?       � � � �@�A�  䀀#�� �`���  �A  � & & �    BuffComponentGetBuffValueEvade                   =   =   =   =   =   >   >   >   >   >   >   >   ?      notify       entity       world       
buffValue           @   B       � � � �@�F�@ G��� ��   & �    BuffComponentHasBuffEffectBuffEffectTypeInvincible            A   A   A   A   A   A   A   B      notify       entity       world          _ENV C   F       � @AA  䀀���� %�&  & �    GetService
BuffLogicCheckEntityLockHP           D   D   D   E   E   E   E   F      notify       entity       world       svc           G   L       � � � �    ��@� � ̀�� @ ���� � � �AA 䀀_��  ��@  � � �  & �    HasPetPstIDPetGetOwnerTeamEntityAttributesGetAttributeBuffForbidCure                  H   H   H   H   I   I   I   I   I   K   K   K   K   K   K   K   K   K   K   L      notify       entity       world            M   O       � � � �@�F�@ G��� ��   & �    BuffComponentHasBuffEffectBuffEffectTypeLayerShield            N   N   N   N   N   N   N   O      notify       entity       world          _ENV P   R       � � � �@�F�@ G��� ��   & �    BuffComponentHasBuffEffectBuffEffectTypeHealthShield            Q   Q   Q   Q   Q   Q   Q   R      notify       entity       world          _ENV S   U       � � � �@�F�@ G��� ��   & �    BuffComponentHasBuffEffectBuffEffectTypeAttackImmuned            T   T   T   T   T   T   T   U      notify       entity       world          _ENV V   X       � � � �@�F�@ G��� ��   & �    BuffComponentHasBuffEffectBuffEffectTypeSkillImmuned            W   W   W   W   W   W   W   X      notify       entity       world          _ENV Y   [       � � � �@�F�@ G��� ��   & �    BuffComponentHasBuffEffectBuffEffectTypedoubleChain            Z   Z   Z   Z   Z   Z   Z   [      notify       entity       world          _ENV b   h       G @ G@� ��  ]�� ��@ �@ �    ��  AA G�A 䀀
� �& �    _argslogic_BeforeAutoTestBuffLogicCheckTable_before_entity_world            c   c   c   c   d   d   e   e   f   f   f   f   f   h      self       logic      f         _ENV j   u    
   � @ �@@� @ ǀ��@ � "   �@ �� �A BA G�A d��b    ��  [�f & �    _argslogicexistAutoTestBuffLogicCheckTable_entity_world_before            k   k   l   l   m   m   n   n   o   o   o   o   o   o   p   p   q   t   t   u      self       notify       logic      exist      f      ret         _ENVJ                        	   
                                                        #   #   &   &   )   )   ,   ,   1   1   4   4   7   7   ;   ;   ?   ?   B   B   F   F   L   L   O   O   R   R   U   U   X   X   [   [   \   _   _   _   _   `   `   b   h   b   j   u   j   u          _ENV