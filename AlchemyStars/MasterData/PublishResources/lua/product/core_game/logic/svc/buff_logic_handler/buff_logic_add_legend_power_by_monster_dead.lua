LuaS �

xV           (w@�@C:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/lua/product/core_game/logic/svc/buff_logic_handler/buff_logic_add_legend_power_by_monster_dead.lua             @ A@  $@ �@ A�  � A $@��@  ���@ l   
@���@ l@  
@ �& �    requirebuff_logic_base_class%BuffLogicAddLegendPowerByMonsterDeadBuffLogicBaseConstructorDoLogic        	          �@@�@    ���  
� �& �    
_addValue	addValue                   
   
   
   
   
         self       buffInstance       logicParam               j    �   � @ �@@�  �����  � $� LAAd� L��d� ���B BB����  � �� ��  �& � �  �B @ $ �@ ����� �@ ��@ 䃀�  ��D�$� "  ���C �C@���$��"D   ��C D@���$D�)�  ���B @�$��LCDd� L��d� ��  ����)�  �����  �& � E$� LBEd� �BD�� ̂EA� 䂀F � � �@  ��  C  �CF�� ��F�� �@ �C�A� 䃀�� $��G@ LD���  d���  �DG� ! �	@�̄�@ �� �D C� ��G ��	@ 䄀@ E@
�E $���H
��	$E���  �̄�@ ��  �D C  ��H ��	  �	@ ���H �	�DIA� � �D ƄI ��	@�� ��䄀�  � ���	�J� $E  � & � )   _worldGetService
BuffLogic        GetAttackerEntitySkillContextGetResultContainerGetEffectResultsAsArraySkillEffectTypeDamageipairsGetTargetIDGetEntityByIDHasMonsterIDtableintableinsertAttributesGetCurrentHP       	PetPstID	GetPstIDGetAttributeLegendPower
_addValue
SkillInfoGetActiveSkillIDConfigGetSkillConfigDataGetSkillTriggerParamChangePetActiveSkillReadyNTPowerReadyNewTriggerNotifyBattleConstLegendPowerMaxModify&BuffResultAddLegendPowerByMonsterDeadRequireNTPowerReadyGetID         �                                                    "   "   "   "   "   #   %   &   &   &   &   (   )   )   *   *   *   *   ,   ,   ,   ,   ,   ,   ,   ,   ,   ,   ,   ,   ,   -   -   -   -   -   &   &   0   0   0   0   3   3   3   3   3   3   4   0   0   8   8   9   =   =   >   >   @   @   A   A   A   C   C   C   D   D   E   H   J   J   J   J   L   L   L   L   N   N   N   Q   Q   Q   Q   S   T   T   T   T   U   U   U   U   V   X   X   X   X   Y   Y   Y   Y   Y   Y   Y   Z   Z   \   \   \   \   ]   _   _   _   _   `   `   b   b   b   b   d   d   d   d   d   d   e   e   f   f   f   f   i   j   "   self    �   notify    �   svc   �   	addLayer   �   casterEntity   �   skillEffectResultContainer   �   damageResultArray   �   targetEntityList   �   (for generator)   5   (for state)   5   (for control)   5   _   3   v   3   damageResult   3   targetEntityID   3   targetEntity!   3   (for generator)8   B   (for state)8   B   (for control)8   B   _9   @   entity9   @   petPstIDComponentG   �   	petPstIDI   �   curAttributeCmptK   �   curLegendPowerN   �   	newPowerQ   �   readyU   �   activeSkillIDY   �   configService]   �   skillConfigData`   �   blsvcd   �   requireNTPowerReadye   �   notifyr   z   buffResult�   �      _ENV                              	      	      j      j          _ENV