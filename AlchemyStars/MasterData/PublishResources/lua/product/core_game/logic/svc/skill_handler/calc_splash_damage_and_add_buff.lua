LuaS �

xV           (w@g@../PublishResources/lua/product/core_game/logic/svc/skill_handler/calc_splash_damage_and_add_buff.lua         "    @ A@  $@ �@ A�  � A $@��@  ���@ l   
@���@ l@  
@ ��@ l�  
@���@ l�  
@ ��@ l  
@���@ l@ 
@ ��@ l� 
@���@ l� 
@ �& �    require
calc_base_class'SkillEffectCalc_SplashDamageAndAddBuffSkillEffectCalc_BaseConstructorDoSkillEffectCalculator_CalculateNoTarget_CalculateSingleTarget_CalculateDamageAndAddBuff_GetTargetAreaMap_CalculateDamageResult_CalculateAddBuffResult        
          
@ �� @ ��@�  ���
���& �    _world_skillEffectCalcSvcGetServiceSkillEffectCalc                                   self       world               (    )   �   � � � �    ��@@@�A��@���@ �� $��"  ��FA GA�� � dA� ��A @�$��L�A ��   d� b   ��A �BA�  ��B�)�  ����  & �    GetTargetEntityIDs       ��������_CalculateNoTargettableappendArrayipairs_CalculateSingleTarget         )                                                                                                 !   !   "   "   "   "   "         '   (      self    )   skillEffectCalcParam    )   results   )   
targetIDs   )   result      (for generator)   '   (for state)   '   (for control)   '   _   %   	targetID   %   result   %      _ENV ,   9       � � �� �@@ ̀�@ 䀀��$� L�d� �A� �� ́A� L�A ��   e f  & �    GetCasterEntityID_worldGetEntityByIDGetGridPositionGetGridDirectionGetSkillEffectParamGetSplashOffset_CalculateDamageAndAddBuff           -   -   /   /   /   /   0   0   1   1   4   4   5   5   6   6   8   8   8   8   8   9   	   self       skillEffectCalcParam       	casterID      caster      
casterPos      
casterDir
      param      offset      splashCenterPos           >   D    	   � @ �@�@ 䀀��$� L�@ ��   e f  & �    _worldGetEntityByIDGetGridPosition_CalculateDamageAndAddBuff           @   @   @   @   A   A   C   C   C   C   C   D      self       skillEffectCalcParam       	targetID       	defender      splashCenterPos           I   |    Y   � @ �@�A�  䀀��$� L� d� �A��� ́�� ��$� FB LB�d� ��� �@ ��   �@ ��B� $ ��  �BC� ̂�� �C$� L�Cd� �D �@ � ��  @ ��� �� �@ �C�� ��� �   $��F�D G�� dD F�D GD�� ̄E� dD  L�Ed� ��D �DE	��  �D��F  � @�� ����DF @� � �   F�F LE�
�   	@�	d�+E  & & �    _worldGetServiceUtilScopeCalcGetSkillScopeCalcGetSkillEffectParamGetSplashTargetTypeGetSplashScopeTypeGetSplashScopeParamSkillScopeParamParserNewParseScopeParamGetEntityByIDGetCasterEntityID	BodyAreaGetAreaGetGridDirectionComputeScopeRangeGetSkillScopeTargetSelectorDoSelectSkillTargettableuniqueremovevGetIDGetAttackRange_CalculateDamageResult_CalculateAddBuffResult(SkillEffectSplashDamageAndAddBuffResult         Y   K   K   K   K   M   M   P   P   Q   Q   R   R   S   S   T   T   T   U   U   U   U   U   X   X   X   X   X   Y   Y   Y   Y   Z   Z   [   [   ^   _   `   a   b   c   d   e   g   ^   j   j   j   k   k   k   k   k   m   m   m   m   n   n   n   n   n   n   p   p   q   q   q   q   q   u   u   u   u   u   y   y   y   y   {   {   {   {   {   {   {   {   {   |      self    Y   skillEffectCalcParam    Y   
centerPos    Y   utilScopeSvc   Y   
calcScope   Y   param   Y   targetType
   Y   
scopeType   Y   scopeParam   Y   parser   Y   caster   Y   casterBodyArea   Y   casterDirection!   Y   
casterPos#   Y   splashScopeResult-   Y   targetSelector0   Y   targetArray5   Y   attackRangeA   Y   damageResultsK   Y   buffResultsO   Y      _ENV ~   �    5   �   � @  � � �
�B@ �@��$��"  @	�L�@d� �A�� �   ��BA� @ @�$��MD������D  � �����  ��	���������ā	)�  �C���ǂ����B  � �ǂ�  � �ǂ��������  jA��  & �    ipairs_worldGetEntityByIDGetGridPosition	BodyAreaGetAreaxy         5      �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    5   targetArray    5   targetGridAreaMap   5   (for generator)   3   (for state)   3   (for control)   3   _   1   targetEntityID   1   targetEntity	   1   targetCenterPos   1   bodyAreaComponent   1   bodyAreaArray   %   (for generator)   %   (for state)   %   (for control)   %   _   #   areaPos   #   absAreaPos   #      _ENV �   �    D     L� d� �A� �� ǁ@ ���L� d �  B�$� L��d� ��A  �����B   ��
�D�"  �	�D�G��D"   �D�G��DG�@ L��� d����B �C	 �@ ����  @��FC ��C���� �B �C
���   	@�	��$��FD GE�
� � 
dE��  j��& & �    GetSkillEffectParamGetSkillID_worldGetEntityByIDGetCasterEntityIDGetGridPositionGetSkillEffectDamageStageIndex_GetTargetAreaMapipairsxy_skillEffectCalcSvcComputeSkillDamageSkillEffectTypeSplashDamageAndAddBuffNewSkillDamageEffectResulttableinsert         D   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    D   param    D   attackRange    D   targetArray    D   resultArray   D   skillDamageParam   D   skillID   D   caster
   D   
attackPos   D   damageStageIndex   D   targetGridAreaMap   D   (for generator)   B   (for state)   B   (for control)   B   _   @   
damagePos   @   defenderEntityID#   @   	defender'   @   nTotalDamage3   @   listDamageInfo3   @   skillResult;   @      _ENV �   �    S   � � � A� $� L�� d� ����� �A �A�G�� 䁀A �A� $��GA L���B d���  ƂB   �@�A DA��$��F�B L��DC� d�  ��C ��C	��	�  �	���FED L�
�� �@ � d �D  ̄D@ � �E  �Ł�䄀  �  ��L�	d�  �
LE�� 
dE�F�E G��
� ��dE�L��F ��@����   @ � 
� dE  �  j��� & �    GetSkillIDGetSkillRangeGetSkillEffectParam
GetBuffID_worldGetEntityByIDcasterEntityIDGetService
BuffLogicTriggeripairsSkillBuffEffectResultNewGetIDCfg	cfg_buffNotifyNTEachAddBuffStartAddBuffcasterEntityBuffSeqAddBuffResulttableinsertNTEachAddBuffEnd         S   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    S   skillEffectCalcParam    S   targetArray    S   skillID   S   attackRange   S   param   S   buffID   S   casterEntity   S   buffLogicService   S   triggerSvc   S   buffResultArray   S   (for generator)   Q   (for state)   Q   (for control)   Q   _   O   	targetID   O   defenderEntity   O   buffResult"   O   cfgNewBuff%   O   buff6   O   seqID7   O      _ENV"                              
      
      (      ,   9   ,   >   D   >   I   |   I   ~   �   ~   �   �   �   �   �   �   �          _ENV