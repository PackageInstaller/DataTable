LuaS �

xV           (w@�@E:/depot_matchsrpg/matchsrpg/b/1505/client/Assets/../PublishResources/lua/product/core_game/logic/svc/skill_handler/calc_damage_base_on_sector_angle.lua             @ A@  $@ �@ A�  � A $@��@  ���@ l   
@���@ l@  
@ ��@ l�  
@���@ l�  
@ �& � 	   require
calc_base_class)SkillEffectCalc_DamageBasedOnSectorAngleSkillEffectCalc_BaseConstructorDoSkillEffectCalculator_CalculateSingleTarget_CalculateAngleDamageRate        
          
@ �� @ ��@�  ���
���& �    _world_skillEffectServiceGetServiceSkillEffectCalc                                   self       world                       �   � � A� $� F�@ � d����@  � @��� �   ��A �B�  @ �B�i�  ���  & �    skillEffectParamGetTargetEntityIDsipairs_CalculateSingleTargettableappendArray                                                                                     self       skillEffectCalcParam       results      skillEffectParam      targets      (for generator)      (for state)      (for control)      _      	targetID      result         _ENV #   e    _   � � A@ �@� $���@��FA GA��� � dA�G�A L��  B A� �� d���� ���A� � G�� ��� �K� �� kA� J@��GA@ L���A� d����� ���� D$� BD$� L�Dd� L��d� ��A �  E @ $�	�M��DE   @��� ���̄�@ 	�D���E ��	�� @�䄀�  ����EF���   @�	��� ���F G@�$� �B �	@ � 
��
 ������E �E� �@ �E�)�  �C�� & �    skillEffectParam_worldGetEntityByID Lognotice+CalculationForeachTarget defender is null _skillEffectServiceNewSkillDamageEffectResult��������        skillRangegridPoscasterEntityID
attackPosGetSkillEffectDamageStageIndex	BodyAreaGetAreaGridLocationGetGridPosipairs_CalculateAngleDamageRateSetAngleDamageRatetableintableComputeSkillDamageskillIDSkillEffectTypeDamageinsert         _   %   (   (   (   (   )   )   *   *   *   *   *   ,   ,   ,   ,   ,   ,   ,   -   -   -   -   0   0   0   1   1   1   1   5   5   5   5   6   7   7   ;   ;   ;   ;   <   <   <   <   A   B   D   D   D   D   E   G   G   G   G   G   H   H   H   J   J   J   J   J   J   J   K   M   N   O   P   Q   R   S   T   T   V   M   Y   Z   [   \   ]   _   Y   a   a   a   a   a   D   D   d   e      self    _   skillEffectCalcParam    _   defenderEntityID    _   skillDamageParam   _   	defender   _   skillResult      	attacker"   _   
attackPos#   _   damageStageIndex%   _   area)   _   locationPos-   _   effectCalcSvc.   _   skillResultList/   _   (for generator)2   ]   (for state)2   ]   (for control)2   ]   i3   [   	bodyArea3   [   workPos4   [   damageRate9   [   gridPosD   [   nTotalDamageO   [   listDamageInfoO   [   skillResultV   [      _ENV f   y    !   �$� \  @�� �GA@�A��A �@ �@@ ��$��FA GB���Ad�  �G������ �B��  �� �Â�R�O�NC��f AA  f & �    GetCenterPos       Vector2Anglemathfloor      �?skillEffectParamGetMaxAngleGetMinDamageRate                 !   g   g   h   h   h   i   j   k   l   l   l   l   l   m   m   m   m   m   o   p   p   q   q   r   r   s   t   t   t   u   x   x   y      self    !   
casterPos    !   
targetPos    !   skillEffectCalcParam    !   centerPosVec   !   selPos      mainDir      
targetDir      
diffAngle      skillDamageParam      	maxAngle      minRate      decRateRange      resRate         _ENV                              
      
             #   e   #   f   y   f   y          _ENV