LuaS �

xV           (w@�@C:/depot_matchsrpg/matchsrpg/b/170/client/Assets/../PublishResources/lua/product/core_game/logic/svc/skill_handler/calc_teleport_and_summontrap.lua             @ A@  ��@ $@�@@  ��@@ l   
@��@@ l@  
@ �@@ l�  
@��& �    _class&SkillEffectCalc_TeleportAndSummonTrapObjectConstructorDoSkillEffectCalculator_CalculateSingleTarget                  
@ �� @ ��@�  ���
���& �    _world_skillEffectServiceGetServiceSkillEffectCalc           
                        self       world               7    P   �   � � �   
 ���@ �@�� � $�  LAAd� ����� ���� �L� d� �B�  ����B  ��  ����   FC ��d ��DC ��C	�   �D�i�  ��G�@ L��� d���C � D �C����E \ �� Ǆ�D E
AE ��	$E��E �� _��  ��E  ��  �	$��"   �FEC G��
� � 
dE�FEC G��
� ��	dE����  & �    GetTargetEntityIDs_trapPosList_worldGetEntityByIDGetCasterEntityIDAttributesGetCurrentHP
CalcMaxHpGetSkillEffectParamGetTeleportCountByHPPercent        GetGridAreaArrayipairstableinsertGetServiceRandomLogic       
LogicRandLogdebugTeleportIndex:_CalculateSingleTargetremovev         P                                                                             !   $   $   %   &   &   &   &   '   '   '   '   '   &   &   *   *   *   *   +   +   +   +   ,   ,   ,   ,   -   .   .   .   .   .   /   /   /   /   /   /   /   /   0   0   1   1   1   1   1   3   3   3   3   3   +   6   7      self    P   skillEffectCalcParam    P   results   P   targets   P   casterEntity
   P   	attrCmpt   P   hp   P   maxHP   P   
hpPercent   P   effectParam   P   telePortCount   P   gridAreaList   P   tmpList   P   (for generator)   '   (for state)   '   (for control)   '   i    %   _    %   randomServiceLogic+   P   (for index).   N   (for limit).   N   (for step).   N   i/   M   index3   M   randAreaIndex4   M   resultA   M      _ENV :   t    �   @ A@��� � $�  L�� d� ���� �A�� @ �A�� $��G@ L��� d���  �  ÀFCB � d����B ��B	� �$ �D  ��B ��B	���$ �D  i�  �C�K  @� �FCC G���� ��dC�C  �D�� �@ ̃�AD 䃀  b  � �\ ����L��� �d� �D�ƄB �D�	 �@��D�̄�@ 	��E� �  �D  @�  	C� ��L�d� �  `��� �� ��	�����A � � �F�B GE�
� ��	dE�LEF� 
 �d� b  ��F�B G��
��F � 
d��bE  ��F�B G��
� 	� 
dE�F�B G��
��F � 
dE��E���   ��� EF��	��$� "   ��B �F
G�F ��	$��"E  @��B �B
@ 	��	$E��B �B
G�F ��	$E��G �D�	@ 	� � � & �    _worldGetEntityByIDGetCasterEntityIDGetSkillEffectParamGetTrapCountGetGridAreaArrayGetService
TrapLogicRandomLogicipairstableinsertCloneLogfatal!teleportGridList is empty Index:
MonsterID	UtilData        
LogicRand       removeIsPosBlockGetMonsterBlockData
GetTrapIDCanSummonTrapOnPosVector2Include_trapPosList'SkillEffectTeleportAndSummonTrapResultNew         �   <   <   <   <   <   >   >   ?   ?   A   A   B   B   B   B   D   D   D   D   E   F   G   H   H   H   H   I   I   I   I   I   I   J   J   J   J   J   J   H   H   L   L   L   M   M   M   M   M   O   Q   Q   R   R   R   R   T   U   U   U   U   U   V   V   V   V   W   X   X   X   X   X   Y   Y   Y   Y   Y   Y   Y   Z   [   \   _   _   `   a   a   a   a   a   b   b   b   b   c   d   d   d   d   d   e   e   e   e   e   e   e   e   e   e   e   e   e   f   f   f   f   f   g   g   g   g   g   h   i   k   k   l   m   m   m   m   m   m   m   m   m   m   m   m   m   n   n   n   n   n   o   o   o   o   o   r   r   r   r   r   s   t      self    �   skillEffectCalcParam    �   isLast    �   randAreaIndex    �   casterEntity   �   effectParam   �   
trapCount	   �   gridAreaList   �   trapSvc   �   randomServiceLogic   �   tempGridList   �   teleportGridList   �   	gridArea   �   (for generator)   (   (for state)   (   (for control)   (   i   &   pos   &   bFind1   �   monsterIDCmpt3   �   utilDataSvc7   �   teleportPos8   �   indexA   P   posB   P   trapIDS   �   trapPosListT   �   index]   {   pos^   {   pos   �   result�   �      _ENV                                 7      :   t   :   t          _ENV