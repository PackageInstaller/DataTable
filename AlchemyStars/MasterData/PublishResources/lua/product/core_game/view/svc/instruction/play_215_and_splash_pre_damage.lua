LuaS �

xV           (w@c@../PublishResources/lua/product/core_game/view/svc/instruction/play_215_and_splash_pre_damage.lua         (    @ A@  $@ �@ A�  � A $@��@  ���@ l   
@���@ l@  
@ ��@ l�  
@���@ l�  
@ ��@ l  
@���@ l@ 
@ ��@ l� 
@���@ l� 
@ ��@ l  
@���@ l@ 
@ �& �    requirebase_ins_r_class%Play215AndSplashPreDamageInstructionBaseInstructionConstructorGetCacheAudioGetCacheResourceDoInstruction
PlayAudio_PlayDamageInfoPlayBeHitEffectPlayBeHitAnimTurnToTargetPlayDamageText    
           &   �@@ ǀ� �� 
� ��@@ � � �� 
����@@ ǀ� �� 
����@@ � � �� 
����@@ ǀ� �@    ��� �� 
����@@ �@� �� 
� ��@@ ��� �@    ��� �� 
� ��@� 
� �
@ �& �    _damageStageIndex	tonumberdamageStageIndex_splashDamageStageIndexsplashDamageStageIndex_damageHitEffectdamageHitEffect_splashHitEffectsplashHitEffect_damageWaitTimedamageWaitTime        _beHitAudioIDbeHitAudioID_hitEffectWaitTimehitEffectWaitTime_hitAnimNamehitAnimName_paramList         &   	   	   	   	   
   
   
   
                                                                                                self    &   
paramList    &      _ENV           K   � @ �   ��� @  ��� ���@ ��@� � @ �@�f  & �    _beHitAudioID        tableinsert                                                         self       t         _ENV    ,       K   � @ A@ ����    �ƀ@ ��� � @ �@�� @ GA 䀀�    ��@ �@@� ��$A�f  & �    GetEffectResCacheInfo_damageHitEffecttableinsert_splashHitEffect               !   !   !   "   "   #   #   #   #   #   &   &   &   '   '   (   (   (   (   (   +   ,      self       t      damageHitEffectPath      splashHitEffectPath         _ENV .   `     �   A@$� 
 ��@$� �@$� LA�AA ǁ��A d� �ABA BGBB �� ́B� @ C�B $��
 ��@ C�� $��
 �@ C�B $��
 �@ C�� $���D��$��L�Dd� �  � CE @�$��L�Ed�  @�� �L�Ed� ��)�  ��� @�� (C�  K  �DE ��� �̅E� �� ���E ��  @ �E���  *��DE � � ��EF� FE @�$ �L�Ed� �� �F�E G���� dG�)�  ����  *���F  � @ ��� #�� �_��  �F  � @�� �����E ���	  @ 	�D��G  ���� �ƄG  � GG �D�'��G H$� CH� $��"C  � ��G @� $C ��& � "   _worldGetOwnerWorldSkillRoutineGetResultContainerGetEffectResultsAsArraySkillEffectTypeDamage_damageStageIndexSplashDamage_splashDamageStageIndexGetSkillID_playSkillServiceGetService
PlaySkill_playDamageServicePlayDamage_effectServiceEffectSingleOrGridIsFinalAttack       ipairsGetDamageIndextableinsertGetDamageResults_PlayDamageInfoappendArray_damageWaitTime        YIELDTaskHelperGetInstanceIsAllTaskFinished         �   /   /   /   1   1   1   1   3   3   3   3   3   5   5   5   5   5   6   6   8   8   8   8   8   :   :   :   :   :   <   <   <   <   <   =   =   =   =   =   =   =   >   >   ?   @   A   A   A   A   B   B   B   B   C   C   C   A   A   F   F   F   F   G   H   I   I   I   I   J   J   J   J   K   K   K   K   K   I   I   N   N   N   N   O   O   P   P   P   P   Q   Q   Q   Q   R   R   R   R   R   P   P   N   N   V   V   V   V   V   W   W   W   W   W   W   W   W   V   X   X   X   X   X   Y   Y   Y   Z   Z   Z   Z   F   ]   ]   ]   ]   ]   ]   ]   ]   ^   ^   ^   ^   `   (   self    �   TT    �   casterEntity    �   phaseContext    �   resContainer   �   damageResults   �   splashResults   �   skillID   �   damageShowType)   �   isFinalHit+   �   taskIDList,   �   maxDamageIndex-   �   (for generator)0   :   (for state)0   :   (for control)0   :   i1   8   results1   8   (for index)=   �   (for limit)=   �   (for step)=   �   i>   �   playNormalDamageResult?   �   playSplashDamageResult@   �   (for generator)C   O   (for state)C   O   (for control)C   O   _D   M   resultsD   M   (for generator)R   f   (for state)R   f   (for control)R   f   _S   d   splashResultS   d   splashDamageResultsU   d   (for generator)X   d   (for state)X   d   (for control)X   d   _Y   b   splashDamageResultY   b   taskIDst   �      _ENV c   n       � @ �    ��@@ ��@� @ �� ��� � �@   �� $A �� $� �  A��@ � $A & �    _beHitAudioIDAudioHelperControllerPlayInnerGameSfxEffectHolderAddEffectHolderAttachAudioID            d   d   d   e   e   e   e   g   g   h   h   i   i   j   j   j   l   l   l   l   n      self       casterEntity       
playingID      effectCpmt	         _ENV r   �    �   @$� FB@ � d ������ ��@ ��@ 䃀D��� $��L��d� �B  �@ � ���D i�  ��GBB  @�� �F�B �� �BB dB�K  �  �C @ �B��B@   � ���$� G�@ L�� d���D�� ������� �@ EC
�� $��L�C
��   @ ���  �	@ 	dE�b  ���B  @��� LDd� LE�
d� ���
�� �   ����� � ��E �E�@��E�� ��E �E�@��E�L�E �  �dE L�E ��  	@�� dE LF ��  �@ 	���   d� �EF ��F�� �
�E��  j��B@  �� ���$� G�@ L�� d���D�� ������� �@ EC
�� $��L�C
��   @ ���  �	@ 	dE�b  ���B  @��� LDd� LE�
d� ���
�� �   ����� � ��E �E�@��E�� ��E �E�@��E�L�E �  �dE L�E ��  	@�� dE LF ��  �@ 	���   d� �EF ��F�� �
�E��  j�f & �    GetRenderGridPositionipairsGetTargetID_worldGetEntityByIDGetDamageInfo       GetGridPosPlayBeHitEffect_hitEffectWaitTime        YIELD
PlayAudioGetService	PlayBuff_OnAttackStartSkillRoutineGetResultContainerGetFinalAttackEntityIDGetID_playSkillServiceFreezeFrameTurnToTargetPlayDamageTextPlayBeHitAnimtableinsert         �   t   t   u   u   u   u   v   v   w   w   w   w   y   y   y   z   z   {   {   {   {   {   {   u   u   }   }   }   ~   ~   ~   ~   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   .   self    �   TT    �   playNormalDamageResult    �   playSplashDamageResult    �   casterEntity    �   finalAttack    �   skillID    �   damageShowType    �   
casterPos   �   (for generator)      (for state)      (for control)      _      damageResult      	targetID      targetEntity      damageInfo      damageGridPos      totalTaskID!   �   hasFinalAttack"   �   (for generator)(   t   (for state)(   t   (for control)(   t   _)   r   damageResult)   r   	targetID+   r   targetEntity/   r   damageInfo2   r   damageGridPos4   r   playBuffSvc8   r   skillEffectResultContainerJ   [   finalAttackEntityIDL   [   nTaskIDm   r   (for generator)w   �   (for state)w   �   (for control)w   �   _x   �   damageResultx   �   	targetIDz   �   targetEntity~   �   damageInfo�   �   damageGridPos�   �   playBuffSvc�   �   skillEffectResultContainer�   �   finalAttackEntityID�   �   nTaskID�   �      _ENV �   �       G@ LA�ǁ@  � @ ��d� _��@����� _�@@�_�@� ��AAL�Ad �A  & �    _effectServiceCreateBeHitEffect_damageHitEffect EffectControllerSetEffectCasterIDGetID           �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       targetEntity       casterEntity       damageGridPos       damageShowType       beHitEffectEntity      effectCtrl           �   �    ?   ��� B@ �@_ �  ��A  �� �$� FB@ G��_@  �B  � �A  @�"B  ��GA b   �LB�d� bB   �L�A�� A �B� dB�L�Ad� ���� �BB� �B �B� $��LCC��   @�� �  �@�dC�F�C G��d�� L��CD ǃ�DD @�� d� f & �    GetDamageTypeDamageTypeGuardMiss_hitAnimNameIsHPShieldGuardSetAnimatorControllerTriggersGetSkillEffectScopeResultGetRenderGridPositionGetGridPos_worldGetService	PlayBuff_OnAttackEndGameGlobalTaskManagerCoreGameStartTask_playSkillServicePlayHitTrap         ?   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    ?   TT    ?   damageResult    ?   damageInfo    ?   targetEntity    ?   casterEntity    ?   skillID    ?   guard   ?   miss   ?   scopeResult"   ?   
attackPos$   ?   beAttackPos&   ?   playBuffSvc*   ?   nTaskID=   ?      _ENV �   �    	   � @ �@�A�  䀀��� �� $A & �    _worldGetServiceRenderEntityTurnToTarget        	   �   �   �   �   �   �   �   �   �      self    	   casterEntity    	   targetEntity    	   resvc   	        �   �       L� d� �A@ ��@  �����@@ �A��A@��A��A@ �A�@�� �A ́�� �  @ ���$B & �    GetGridPos_playDamageServiceSingleOrGridSetShowTypeSetRenderGridPosAsyncUpdateHPAndDisplayDamageMaterialAnimationComponentPlayHit           �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       damageResult       damageInfo       targetEntity       skillID       damageGridPos      damageShowType      mtrAni          (                                                   ,      .   `   .   c   n   c   r   �   r   �   �   �   �   �   �   �   �   �   �   �   �   �          _ENV