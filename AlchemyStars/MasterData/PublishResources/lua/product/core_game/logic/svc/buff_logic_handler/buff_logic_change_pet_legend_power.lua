LuaS �

xV           (w@o@../PublishResources/lua/product/core_game/logic/svc/buff_logic_handler/buff_logic_change_pet_legend_power.lua             @ A@  ��@ $@�@@  ��@@ l   
@��@@ l@  
@ �@@ l�  
@��@@ l�  
@ �& �    _classBuffLogicChangePetLegendPowerBuffLogicBaseConstructorDoLogic_OnChangePetPower_CalcModifyValue                  �@@�@    ���  
� �� A�@    ��@ 
�����A�@    ��@ 
� ��@B
� ���B
� ��@C
� ���C�@    ���  
� �& �    _enableenable       
_addValue	addValue        
_maxValue	maxValue_addPercentaddPercent_addPercentMinAbsValueaddPercentMinAbsValue_checkExtraSkillIDcheckExtraSkillID_autoCheckExtraautoCheckExtra                                                                                               self       buffInstance       logicParam               .    )   � @ _@@  �& � ��@ ��@�� �@    �& � �   A � ��$A AA �A��$��b   @�G�� b   �G� b  @�L�� d� 
A��L� d� 
A�G�� b  � �L�� d� 
A�& & �    _enable       _buffInstanceEntity_OnChangePetPowerBuffResultChangePetLegendPowerNewGetAttackPosGetTargetPos
attackPos
targetPosGetNormalAttackIndexnormalAttackIndex         )                                     !   !   !   !   #   #   #   #   $   $   %   %   %   %   %   %   &   &   &   '   '   '   )   )   )   *   *   *   -   .      self    )   notify    )   
petEntity   )   petPowerStateList   )   buffResult   )      _ENV 0   �    $  � � � �@    �& � A@ �@��  $��L� d� LA�d� ��A �  ����A _�A��G�A �B � @��� �A    �& � �A@ ��@B ���́B@��� � ��$� FC GB�_@  �& � L��d� ��� �� �DAC 䂀�D ��$��M� ��  �A� ��D _�A� ���D  @  �G�D �  �E   LD���  �d� !@������ � A� ���D��� �F �DF	 � ����D@ ̄�	A� 䄀���	@ 	�D�� @���� � A� ���D��  �G �DG	 @	@ ��G GCG	a��  ��D  �� ̄GAE ���D �D�D  @ ��  ����D� $� ����D�D���D�D��Dʄ���Dʄ��D����D�D _�A
@ ��D @ �E  � ���D�A ����J �D�	�
 L� d� ��
 �� @ �D�ǄA �  � �ǄA _��	  � ��DK �  @��DK ��	���� � ̄�	� � $� �  ��\�	 @����F�K ��	d@���B �@� �� ��B� C GC ����  G��� ��$� a�  �CG  C� �  !@��̇�@� �� ���G��� �F �G�@� 䇀H@ �@�� $���F��$H��� @�̇�@� �� ���G��  ���"H  @ �  � ��L� d� 
H���
H���
H��
����
H��
Ȇ��G�D _��@ �G�D @ �CH  C� 
H��
H��i�  ����� � & � 0   	PetPstID_worldGetService	UtilData
SkillInfoGetActiveSkillID_checkExtraSkillID        IsPetExtraActiveSkillConfigGetSkillConfigDataGetSkillTriggerTypeSkillTriggerTypeLegendEnergy	GetPstIDAttributesGetAttributeLegendPower_CalcModifyValue
_maxValue_buffLogicServiceCalcMinCostByExtraParamChangePetActiveSkillReady       NTPowerReadyNewTriggerNotifyBattleConstLegendPowerMaxModifypetEntityIDGetID	petPstIDpowerreadypreviouslyReadyrequireNTPowerReady	maxValueextraSkillIDLogdebug*BuffLogicChangePetLegendPower pet entity= power= ready=_autoCheckExtraGetExtraActiveSkillIDListipairs           1   1   2   2   3   6   6   6   6   8   8   8   8   9   9   9   9   9   9   :   ;   ;   ;   ;   <   <   =   A   A   A   A   C   C   C   C   D   D   E   E   E   E   F   I   I   K   K   L   L   L   M   M   M   N   O   O   P   T   T   T   T   T   T   U   X   [   ]   _   _   _   _   `   `   a   a   a   a   a   b   d   d   d   d   e   e   e   e   e   e   e   f   f   h   h   h   h   h   i   l   l   l   l   m   m   p   p   p   p   q   q   q   q   s   s   s   t   t   v   v   v   v   w   w   x   x   y   y   z   z   {   {   }   }   }   }   }   }   }   }   }            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   $   self      
petEntity      petPowerStateList      petPstIDComponent     	utilData	     activeSkillID     isExtraSkill      extraSkillIndex      configService     skillConfigData#     skillTriggerType%     	petPstID,     curAttributeCmpt.     curLegendPower1     	addValue4     	newPower5     ready@     blsvcA     requireNTPowerReadyB     minCostF     notifyR   Z   previouslyReadyk     extraSkillIDList�     skillInfoCmpt�     (for generator)�     (for state)�     (for control)�     index�     extraSkillID�     skillConfigData�     extraRequireNTPowerReady�     extraMinCost�     extrPreviousReady�     extraReady�     notify�   �   	indexKey�        _ENV �   �       � @ �@@ �   ���@@ ��� �@ �@@�$� F�@ G�� d�  �GAA b  � �GAA  @  �AA  ��@ �� ��  ��  �  & �    
_addValue_addPercentmathabsfloor_addPercentMinAbsValue        ��������            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       curLegendPower       	addValue      oriModifyVal      absModifyVal
         _ENV               	   	               .      0   �   0   �   �   �   �          _ENV