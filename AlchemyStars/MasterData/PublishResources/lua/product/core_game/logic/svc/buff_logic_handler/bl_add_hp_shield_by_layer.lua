LuaS �

xV           (w@f@../PublishResources/lua/product/core_game/logic/svc/buff_logic_handler/bl_add_hp_shield_by_layer.lua         "    @ A@  $@ �@ A�  � A $@��@  ���@ l   
@���@ l@  
@ ��@ l�  
@���@ A  � A $@� B   � B l�  
@�� B l  
@�� B l@ 
@��& � 
   requirebuff_logic_shield_hp_classBuffLogicAddHPShieldByLayerBuffLogicBaseConstructorDoLogic
DoOverlapBuffLogicRemoveHPShieldByLayerDoLogic                  �@@�@  � �ǀ@ ���� 
� ��@A
� ���A�@  @ �� B �@�
� ���B
� �& �    _layerType
layerType_buffInstanceGetBuffEffectType_shieldPercentshieldPercent_shieldFromTypeshieldFromTypeHPShieldFromTypeOwnerHP_shieldFromParamshieldFromParam                                 	   	   
   
   
   
   
   
               self       buffInstance       logicParam          _ENV    Q    �   �   � @ �@�� �   @ �� @ ��� @ ̀�� �   @�� @ ���� � �� � ��@ �A F�A G�@��@ AB$� �B$� �  ���A F�A G��@@
�C AC$� �CL�Cd� b  ��LDd� LA�d� ��D ��D �����E� � �@�LAEd� b  ���  G�D L���� d������ �AF� ́�� ��� $���  @��@ ���A F�A G�@� �A� $� �  ���A F�A G��@���G$� H$� FAH � d ����� ǂH �H$�  �@��B�� ̂�� � � 	�i�  ��@��A F�A G�@ �C AC$� �@I���A F�A G��@��@ AB$� L�Id� � ����A F�A G�@��@ AB$� LAJ��
 d��� ��J K�@ �AK $� F�K G���L �� �d� ��J �AL  @��� ƁL ���AB �M �BM� ��� $B��M NAB �@ ��N�� ��  �A � $B�BO �L��N�� ��$� & & � >   _entityHasTeamHasPetPetGetOwnerTeamEntity        _shieldFromTypeHPShieldFromTypeOwnerHPAttributesGetCurrentHP	CasterHP_buffInstanceContextcasterEntityHasPetPstID	PetPstID	GetPstID_worldGetPetDataGetPetHealthHasMonsterIDGetServiceConfigGetMonsterConfigData
MonsterIDGetMonsterIDGetMonsterHealthLastDamage
GetDamageSpecificPetTeamGetTeamPetEntitiesipairs_shieldFromParamGetTemplateID
SpilledHP
hpSpilledOwnerDefenceGetDefenceOwnerBaseDefenceGetAttributeDefense_buffLogicServiceGetBuffLayer_layerTypemathfloor_shieldPercentAddHPShieldDamageInfoNewDamageTypeRecoverSetHPShieldLogdebug"Buff AddShieldByLayer, entityID: GetID addShield:  setShield: BuffResultAddHPShield         �                                                                                                                                                                      !   !   !   !   "   "   "   "   $   '   '   '   '   )   )   *   *   *   *   +   +   +   ,   ,   .   /   0   0   0   0   0   1   1   1   1   2   2   2   2   2   3   3   3   3   4   4   4   4   5   5   6   6   6   6   6   7   7   7   7   7   7   4   4   :   ;   ;   ;   ;   ;   <   <   <   <   <   =   =   =   =   =   ?   ?   ?   @   @   A   A   B   B   B   B   B   D   D   D   E   E   E   F   H   H   H   H   H   J   J   J   J   J   J   K   K   K   K   K   L   L   L   L   L   L   M   M   M   N   N   N   N   N   N   N   N   N   N   N   O   O   O   O   O   O   P   Q      self    �   notify    �   teamEntity   �   value   �   casterEntity)   N   pstid1   8   petData5   8   configServiceB   L   monsterConfigDataD   L   
monsteridH   L   maxhpK   L   petsa   t   (for generator)d   t   (for state)d   t   (for control)d   t   ie   r   ee   r   
cPetPstIDg   r   attributesComponent�   �   totalDefence�   �   attributesComponent�   �   baseDefence�   �   curMarkLayer�   �   
addShield�   �   curHpSh�   �   damageInfo�   �   buffResult�   �      _ENV S   V       �@� 
� ���@ �  �   & �    _shieldPercentshieldPercentDoLogic           T   T   U   U   U   V      self       logicParam            [   ^       �@@
� ���@
� �& �    	_isOwnerisOwner_ignoreCheckShieldToHPEffectignoreCheckShieldToHPEffect           \   \   ]   ]   ^      self       buffInstance       logicParam            _   t    @   D   � @ �   � ��@@ ��@�� @  ��@ � A�� �   @ �G�@  ���@ �@A�� �   � ���� �� ��A�@ � B _@B����� �� ��BC AC����@  @���� �� ��C� A �@ �@D ��D F�D G��� �@EA �@�ƀE ��� LA� d �@  ƀF ̀�LA� d� � � �  & �    	_isOwner_buffInstanceEntity_entityHasTeamHasPetPetGetOwnerTeamEntity_ignoreCheckShieldToHPEffect       BuffComponentHasBuffEffectBuffEffectTypeShieldToHPSetBuffValue	HPShield        DamageInfoNewDamageTypeRecoverSetHPShieldLogdebug$Buff RemoveShieldByLayer,entityID: GetIDBuffResultRemoveHPShield         @   a   b   b   b   c   c   c   c   e   e   e   e   e   f   f   g   g   g   g   g   h   h   h   h   k   k   k   k   k   k   k   k   k   k   k   l   l   l   l   l   l   o   o   o   o   o   o   p   p   p   q   q   q   q   q   q   r   r   r   r   r   r   s   t      self    @   entity   @   damageInfo/   @   buffResult>   @      _ENV u   v       & �                v      self       logicParam           "                                          Q      S   V   S   Y   Y   Y   Y   Z   Z   [   ^   [   _   t   _   u   v   u   v          _ENV