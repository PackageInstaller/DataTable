LuaS �

xV           (w@l@../PublishResources/lua/product/core_game/logic/svc/buff_logic_handler/buff_logic_steal_pet_attributes.lua             @ A@  $@  @ A�  $@ �@ A  �@A $@� A   � A l   
@ � A l@  
@���@ A  �@A $@� B   � B l�  
@ � B l�  
@��& � 	   require
buff_typebuff_logic_base_classBuffLogicStealPetAttributesBuffLogicBaseConstructorDoLogic!BuffLogicResetStealPetAttributes        
          � @�@    ��@  
� �ǀ@�@    ��@  
� ���@�@    ��@  
���& �    
hpPercent        atkPercentdefPercent                                                              self       buffInstance       logicParam               �    �   � @ �@@�� ̀@� �@  � ���@� �     �& � � A � @ AA$� "  @�@ AA$� �A"A    �  D  ��A �BB ���́B� �  @���B� ��� �A BC��$��L�Cd� ��C�� �D� �B�� @�ƂD ���E C� �D �DGCE O��$� G�E L���  �FF GD���dC G�E L���  �FF GD���dC G�E L���  �F�F G�� dC G�E L���  �F�F G�� dC LCG��dC�́G� �  ����G _ ���@ �A�� ���� $��F�D G����G �d� ���� �B�� �D �DR��O��M��$� �INC  �@ �A
 NB_ �����D ��D����   J  ��
 ǃE �C�@���ƄJ ���	��C ��AD � �C ̃K@��C�΃�DH$� LId� �DI�� ǄE �D�	@ ��ƅJ ��� ��D �D	E�LK�E  �	dE F�K L�
�  �@�	� 
d� f & � 1   _buffInstanceEntityHasDeadMarkHasPetDeadMarkGetBuffSeqContextcasterEntity_worldGetServiceBattleHasPetPstID	PetPstID	GetPstIDGetPetDataGetPetAttackGetPetDefencePetGetOwnerTeamEntitymathflooratkPercentdefPercent_buffLogicServiceChangeBaseAttackModifyBaseAttackTypeAttackConstantFixChangeBaseDefenceModifyBaseDefenceTypeDefenceConstantFixUpdateTeamDefenceLogicHasTeam
hpPercent        AttributesGetAttributeMaxHP
CalcMaxHpGetCurrentHP'            �?       ChangeBaseMaxHPModifyBaseMaxHPTypeMaxHPConstantFixModifyHPUpdateTeamHPLogicBuffResultStealPetAttributesNew         �                                                                                                                            "   "   "   "   #   #   $   $   &   &   &   &   &   )   )   )   )   )   *   *   *   *   *   ,   ,   ,   ,   ,   ,   ,   ,   -   -   .   /   0   0   2   -   4   4   5   6   7   7   8   4   :   :   ;   <   =   =   ?   :   A   A   A   D   D   D   D   D   D   D   E   J   J   L   L   L   N   N   N   N   N   P   P   Q   Q   S   S   S   S   S   S   S   V   W   W   X   Y   ]   ]   _   _   _   _   `   `   a   e   e   f   g   h   h   i   e   l   l   l   l   m   m   m   o   s   s   t   t   u   u   x   x   y   z   {   {   }   x      �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    �   notify    �   entity   �   
buffSeqID   �   casterEntity   �   teamEntity   �   battleService   �   pstId'   a   petData+   a   atk-   a   def/   a   
atkChange9   a   
defChange>   a   attributeComponentk   �   
maxHpBasen   �   hpReduceCeilings   �   maxHpu   �   curHpw   �   curHpPercent~   �   	newHPMax   �   newHp�   �   	hpDamage�   �   casterAttributeCmpt�   �   maxHpCaster�   �   curHpCaster�   �   newHpCaster�   �   newHPMaxCaster�   �   buffResult�   �      _ENV �   �       � @�@    ��@  
� �ǀ@�@    ��@  
� ���@�@    ��@  
���& �    
hpPercent        atkPercentdefPercent           �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       buffInstance       logicParam            �   �    �   G @ L@� d� ��� �� �@  � ���� �� �     �& � � @ � A�� �   @�� @ � A�� �@A�@    ��   �   �A $� G�A L��A d����A �B� ������ � �  ���C �A�@� � ƂC ����A��C ��@� � �BD ǂ��A���� � ��� � ��C �A�@ � ƂC ����A��C ��@ � �BD ǂ��A��AE@��A�́� � �  ��� � �C ���@�� � �A    �& � B�� $��L��d� ����� ��� CG �GR��O��M�$� �GN�CG ��G���� �C�A� � �C �C ���@�� �I ��	�C��CI@��C�̃F� ��$� L�d� �C ��H	  @ �I �F�D����E��� � 	$E �I �I
� ��  	@�	$� & & � (   _buffInstanceEntityHasDeadMarkHasPetDeadMarkContextcasterEntityGetBuffSeq_worldGetServiceCalcDamageBattleHasPetPstID_buffLogicServiceRemoveBaseAttackModifyBaseAttackTypeAttackConstantFixRemoveBaseDefenceModifyBaseDefenceTypeDefenceConstantFixPetGetOwnerTeamEntityUpdateTeamDefenceLogicHasTeam_GetAttributeModifierMaxHPConstantFixGetModifyValueAttributes
CalcMaxHpGetCurrentHPmathfloor'            �?ModifyHPRemoveBaseMaxHPModifyBaseMaxHPTypeUpdateTeamHPLogic"BuffResultResetStealPetAttributesNew         �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    �   entity   �   casterEntity   �   teamEntity   �   
buffSeqID   �   calcDamageService   �   battleService#   �   teamModifierU   �   alreadyAbsorbValue[   �   attributeComponent]   �   maxHp_   �   curHpa   �   curHpPercenth   �   	newHPMaxi   �   newHpm   �   casterAttributeCmpt}   �   maxHpCaster   �   curHpCaster�   �   newHpCaster�   �   newHPMaxCaster�   �   buffResult�   �      _ENV                                       
      
      �      �   �   �   �   �   �   �   �   �   �   �   �   �          _ENV