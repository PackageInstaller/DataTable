LuaS �

xV           (w@d@../PublishResources/lua/product/core_game/logic/svc/buff_logic_handler/buff_logic_shield_to_hp.lua             @ A@  ��@ $@�@@  ��@@ l   
@��@@ l@  
@ �@@ l�  
@��@@ l�  
@ �& �    _classBuffLogicShieldToHPBuffLogicBaseConstructorDoLogicCalcLostHpGetBuffOwnerMaxHp                  �@@
� ���@
� ��@A�@    ��   
� ���A�@    ��   
� �& �    _recoverPersentrecoverPersent_clearShieldclearShield_lessThanLostHplessThanLostHp_lessThanPetMaxHplessThanPetMaxHp                 	   	   
   
   
   
   
                        self       buffInstance       logicParam               O    z   G @ L@� d� � � ̀� � �    ���� � � �� � ��@A� ��  �& � ��� $��"A    �A @B  �& � G�B OA��� �� �CB ����A    ��A ƁC ������� @���BD "  ���D "   ��D � $��LE �� d����C �BE��  ���ƂC �B� �@ 䂀��B G�E b   �L���   dB ��� @B  �B L���   dB L�Bd� L�� d��b   �FBF G���� dB & � GG LB��� d����G �H �FCH G���� ���LId� � �B �BI� @�ƂI ��@�� � 䂀� & � '   _buffInstanceEntity	PetPstIDPetGetOwnerTeamEntityBuffComponent GetBuffValue	HPShield        _recoverPersentAttributesGetAttributeAddBloodRatemathfloor       _lessThanPetMaxHp_lessThanLostHpCalcLostHpGetBuffOwnerMaxHpmin_clearShieldSetBuffValueBuffForbidCureLognotice$BuffForbidCure , 諾爾無法回血_worldGetServiceCalcDamageDamageInfoNewDamageTypeRecoverAddTargetHPGetIDGetDamageValueBuffResultShieldToHP         z                                                                                     $   $   %   %   %   %   %   %   %   %   &   &   &   &   &   &   )   *   *   *   *   *   *   ,   ,   ,   .   .   .   0   0   0   0   0   1   1   1   1   1   1   4   6   6   6   7   7   7   7   7   9   :   :   ;   >   >   >   >   B   B   B   B   B   B   B   C   C   C   C   D   H   H   H   H   J   J   J   J   J   J   K   K   K   K   K   L   L   L   M   M   M   M   M   M   N   O      self    z   e   z   recoverEntity   z   	buffCmpt   z   curShieldValue   z   addHp   z   rate%   z   shieldToHpVal,   z   lostHp5   C   ownerMaxHp8   C   maxShieldToHp=   C   
curShieldD   z   calcDamageSvcd   z   damageInfoj   z   resultx   z      _ENV R   X       � � �� �@@�� � � � ̀�� ��& & �    AttributesGetCurrentHP
CalcMaxHp           T   T   T   T   U   U   U   U   V   W   X      self       recoverEntity       
currentHp      maxHp      lostHp	           [   l    	%   �   �@� � �   ��̀� � ���� A AA��$��L�Ad� � �@���� � �   @�� A � �AA 䀀��$� L�� d� L�d� �A� � ����  �  & �            HasPetPstID	PetPstID	GetPstID_worldGetPetDataGetPetHealthHasMonsterIDGetServiceConfigGetMonsterConfigData
MonsterIDGetMonsterIDGetMonsterHealth        %   \   ]   ]   ]   ]   ^   ^   ^   ^   _   _   _   _   `   `   `   `   a   a   a   a   c   c   c   c   e   e   f   f   f   f   g   g   g   h   k   l   	   self    %   e    %   ownerMaxHp   %   pstid	      petData      configService   #   monsterConfigData   #   
monsterid   #   maxhp"   #                                        O      R   X   R   [   l   [   l          _ENV