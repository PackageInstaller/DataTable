LuaS �

xV           (w@b@../PublishResources/lua/product/core_game/logic/svc/skill_handler/calc_dynamic_center_damage.lua             @ A@  $@ �@ A�  � A $@��@  ���@ l   
@���@ l@  
@ �& �    requirecalc_damage_class$SkillEffectCalc_DynamicCenterDamageSkillEffectCalc_DamageSelectCenterDoSkillEffectCalculator           &    E   L@d� �A@�� ǁ@ ���A 䁀BA �A��$��L�A��  @��� �� �CB�� ̃� � �B CLD� d� �� d� ��� � @ �����B ��C ��A�@ ����D@� ��B �C��䂀�_@D���D �D@�� $��"  ��  FCE L��ƃE ���F DFK  �  d &   �@�&�& �    GetCenterScopeTypeGetCenterScopeParam_worldGetServiceUtilScopeCalcSkillScopeCalculatorNewComputeScopeRange	BodyAreaGetAreaGetGridDirectionSkillTargetTypeMonsterTrapGetGridPositionExpandMaxChainSkillScopeSkillScopeTargetSelectorDoSelectSkillTarget        table
icontains��������SkillScopeResultSkillScopeTypeNoneVector2zero         E   
   
                                                                                                                                 !   !   !   !   !   !   !   !   !   !   "   "   "   "   "   "   "   "   "   "   "   %   %   %   &      self    E   casterEntity    E   effectParam    E   
centerPos    E   skillID    E   centerScopeType   E   centerScopeParam   E   utilScopeSvc   E   	scopeCal   E   centerScope   E   	selector&   E   
tTargetID,   E      _ENV )   �    6X  � � �� �@� � �@ �@��$��LA �   LB� d� ��� � d�  �A  @ ��  � ��A� �A    ��  B$� K  �  �BB  �� ��@ �@��$��LBd� ��ƄB ���	CG�E
� �B �B
GEC�E�N��
$� ��	�C$� �C
$� \ 
 @���AE � 
� hE�G
MF���D ��D�� �����   ���B ��B�C����� ƆB ���GCGG�G� �� �@ �� ��g�LEd� ��  �Ń�����ń�b  @�ƅD ��  @ �E� �ƅD �� �@ �E��  j���@���� _@�@ �@ @ ��  � �  ��EFCB ��d������@���D �F	�� ��D������  	�����  � 	��D �F	�� ��D�i�  �C�G�@ L�����C�d������E�C �  ���DB @�$ �GEE
��@ ��@ �
���̅F� ��$� L�d� �F ��� �@ ��E
� )�  ���@ DG�� $���G��� �� � $� LHd� �DH�� Ǆ@ �D�	A� 䄀�H I
��	$��LEI
��  	@ �� ƆI ����F� ��� GJ$� @ ��d� ��J �I�@ �����J@ �FJ�� ��
�� $� LKd �    G�@ LF��F d���  �FB  �����D �K@ ��$��"H   ��D F@ ��$H��  jG����
� �F    ��  GB @ $��G�@ L��� d������ ̈�� ���� �H  � ��� �I �I�H� IB @	�$	 
�M

��D ��D�
� �����
   ���K �
I� K  �K�� kK  ��� ��� ��
$� G� ���L� ��
$ ��  ��M �
��J�   @ 䊀�
  ���  �� ��D �N@ ��$K�)�  �	�)�  ����N I��
�   $��K� � kG� f & � <   GetSkillEffectParamGetCasterEntityID_worldGetEntityByIDSelectCenterGetCenterPosGetSkillIDGetAttackRangeGetGridPositionipairsmathabsxy	BodyAreaGetArea              tableVector2IncludeHasTrapeidv2	distanceinsert        AttributesGetCurrentHP
CalcMaxHpGetServiceConfigGetSkillConfigDataGetSkillScopeTypeGetSkillScopeParamUtilScopeCalcSkillScopeCalculatorNewComputeScopeRangeVector2zeroGetGridDirectionGetSkillTargetTypeSkillScopeTargetSelectorDoSelectSkillTargetGetSkillTargetTypeParam	UtilData
icontainsSkillEffectCalcParamcasterEntityIDGetIDskillEffectParamskillID
attackPos
centerPosGetWholeGridRange$SkillEffectCalc_DynamicCenterDamagesuperDoSkillEffectCalculatorappendArray&SkillEffectResult_DynamicCenterDamage         X  +   +   -   -   .   .   .   .   0   0   0   0   0   0   0   0   2   2   3   3   6   6   6   6   6   8   8   9   :   ;   ;   ;   ;   <   <   <   <   =   =   >   ?   ?   ?   ?   ?   ?   ?   ?   ?   ?   ?   ?   ?   @   @   @   @   A   A   A   B   B   B   B   C   C   E   E   E   E   E   E   E   F   F   F   F   F   F   F   F   F   F   F   F   F   G   G   H   I   B   O   O   P   P   P   P   Q   Q   R   R   R   R   R   R   T   T   T   T   T   ;   ;   Y   Y   Y   Z   Z   Z   [   [   ]   ]   b   c   c   d   d   d   d   e   e   e   f   f   f   f   f   f   g   g   g   h   i   i   j   j   j   j   j   d   d   n   n   n   n   n   o   o   p   s   s   s   t   t   t   t   u   v   v   v   v   w   w   x   x   y   y   z   {   {   |   }   ~   t   t   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   T   self    X  skillEffectCalcParam    X  effectParam   X  casterEntityID   X  casterEntity   X  
tTargetID   X  centerScope   X  centerScopeAttackRange   X  
casterPos   X  candidates   X  trapCandidates   X  (for generator)    p   (for state)    p   (for control)    p   _!   n   eid!   n   e%   n   gridPos'   n   nearestGrid(   n   nearestDistance5   n   	bodyArea9   n   (for index)?   [   (for limit)?   [   (for step)?   [   i@   Z   v2B   Z   disV   Z   isTrap]   n   dataa   n   nearestCandidates{   X  dis}   X  (for generator)�   �   (for state)�   �   (for control)�   �   _�   �   data�   �   finalCenterEntity�   X  finalCenterPos�   X  
hpPercent�   X  (for generator)�   �   (for state)�   �   (for control)�   �   _�   �   data�   �   eid�   �   e�   �   attr�   �   hp�   �   maxHP�   �   pct�   �   skillConfigData�   X  damageScopeType�   X  damageScopeParam�   X  utilScopeSvc�   X  	scopeCal�   X  damageScope�   X  	selector�   X  
targetIDs�   X  damageResults�   X  	utilData�   X  targets�   X  (for generator)�     (for state)�     (for control)�     _�     id�     attackRange  X  (for generator)  M  (for state)  M  (for control)  M  _  K  id  K  e  K  gridPos  K  	bodyArea  K  (for generator)  K  (for state)  K  (for control)  K  _   I  v2Body   I  v2!  I  
calcParam9  I  r?  I  resultS  X     _ENV                                 &      )   �   )   �          _ENV