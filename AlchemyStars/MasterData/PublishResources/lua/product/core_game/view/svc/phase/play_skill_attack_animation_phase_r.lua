LuaS �

xV           (w@b@../PublishResources/lua/product/core_game/view/svc/phase/play_skill_attack_animation_phase_r.lua             @ A@  $@ �@ A�  � A $@��@  ���@ l   
@���@ l@  
@ ��@ l�  
@���@ l�  
@ �& � 	   requireplay_skill_phase_base_r_classPlaySkillAttackAnimationPhasePlaySkillPhaseBasePlayFlight_PlayAttack_WaitPlayHandleBeHit_PermanentEffectPlayAnim        
   K    `    �L@d� LA�d� ����� ����   LAd� b  ���B��A �A@���    ����A �A���  "B    �& � �  �    
�
 ÅAC � �C h�G����C$ ��  ��� E�$� G�D L��
� 
d��b  @����� @E  �
 ������� �  @������ 
�����E	�B �E��F �EF�  �
�E��F �EF��  	�E��F �EF�  �	�E�gC�L�F ��   @ � �� �@ � ��dC�& �    SkillRoutineGetResultContainerGetSkillIDIsFinalAttackGetSkillStageIndexGetEffectResultsAsArraySkillEffectTypeDamageGetEffectResultByArrayAll_normalAttackDoubleIndex        _normalAttackIndex        GetDamageInfoGetDamageIndexGetGridPosGetTargetID_worldGetEntityByIDGetNormalAttackDoubleGetNormalAttackIndexSetNormalAttackIndextableinsert_PlayAttack         `                                                                                          "   #   $   &   '   )   )   )   )   *   -   -   -   -   .   .   /   /   0   0   0   0   1   1   2   2   2   2   3   6   6   6   6   7   7   7   8   8   8   :   :   :   :   :   ;   ;   ;   ;   ;   <   <   <   <   <   )   @   A   B   C   D   E   F   G   H   J   @   K      self    `   TT    `   casterEntity    `   phaseParam    `   attackAnimParam   `   skillEffectResultContainer   `   skillID   `   isFinalAttack	   `   damageResultAll
   `   skillStageIndex   `   targetEntityList   `   castDamageList   `   damagePosList    `   (for index)%   T   (for limit)%   T   (for step)%   T   i&   S   damageResult'   S   castDamage+   S   
damagePos-   S   beAttackEntityID/   S   targetEntity3   S      _ENV O   �   
  �   ���  ���B@ � �@ �@� $��LCA�@d����@ ��@� �����A@ � �   ��C �  B$� G@b  ��GCB�@�CB_��@�G�B�@��B_�� �L�Bd� b    ��� L�d� �CC �@��� �   �̃C� �  ����C� D � �  �$D� ��CDK� � kD� �C�̃D@�䃀�   � �����E����$� FDE G��d�� L���  dD�^��F����$� "D    �D L�F��d��bD    �AD   ��� ���F ��   �D��  �G� �  ���D�F�G G��
䄀�D�	@ ��  ��	���   \��  (��ƅG��ƅ�  _ � �GH �H@ 	$� ` ��� ��H �  ��� #  ��_ �  �G  � FGE G��d�� L���G  d�� ���'��I��$��N
�EI ��  �
�E��I ��EI �� �I J�E�& � )          SkillService_worldGetServiceBoardRenderGridPos2RenderPosRenderEntityTurnToTargetGetRenderGridPositionxyGetSlantCastEffectIDIsLastNormalAttackAtOnGridGetAnimationNameIsUsePermanentEffectPlayAnimGetPermanentEffSpecialAnimRoot_PermanentEffectPlayAnimSetAnimatorControllerTriggersGetCastEffectID        GetHitEffectDelayGameGlobalTaskManagerCoreGameStartTaskGetHitPointDelay        GetHitPointDelaySecondYIELDHasPetPstIDGetEffectResultsAsArraySkillEffectTypeAddComboNumGetNormalAttackBeAttackOriPostablecount_normalAttackDoubleIndexGetCastTotalTimeYIELDBattleConstFreezeDuration         �   �           _ @ � �@� E  �   $@����@ �  $��E  ��A �������  �E  b   � ���A �@� �@ & �            YIELD_worldGetServiceEffecttargetGetEffectHolderCreateEffect      
       �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      
effectSvc      e         atkEffectDelay_ENVTTselfcasterEntityattackEffectIDtargetEntity �   �       E   _ � ��E   _@�  �E � _�� @�F�@�   � � �� �d@�E  L � �   �E ��� �E ��� �E d@�& �                          YIELD_WaitPlayHandleBeHit             �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      TT          ihitPointDelaySecond_ENVhitPointDelayselfcasterEntitytargetEntityattackAnimParamisSlantAttackdamage
damagePoscurIsFinalAttackskillIDisAddCombooriBeAttackPos�   Z   ]   ]   ^   ^   a   a   a   a   b   b   b   d   d   d   d   e   e   e   e   e   e   j   k   k   m   m   m   m   m   m   m   m   m   m   m   m   m   n   n   o   o   p   s   s   t   t   t   t   u   u   v   v   v   v   w   w   x   x   x   x   x   x   z   z   z   z   z            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   &   self    �   TT    �   casterEntity    �   targetEntityList    �   attackAnimParam    �   damageList    �   isFinalAttack    �   skillID    �   damagePosList    �   skillEffectResultContainer    �   targetEntity   �   skillService      boardServiceRender	      gridRenderPos      resvc      isSlantAttack   �   
attackPos   �   isLastNormalAttack-   �   attackAnimName1   �   	rootName9   >   attackEffectIDG   �   atkEffectDelayO   V   hitPointDelay]   �   hitPointDelaySecondc   �   resultAddComboNumj   �   oriBeAttackPosx   �   (for index){   �   (for limit){   �   (for step){   �   i|   �   targetEntity}   �   
damagePos~   �   damage   �   isAddCombo�   �   curIsFinalAttack�   �   taskid�   �   castTotalTime�   �   remainTime�   �      _ENV �   B   �   @$� "   '�C@ �@$� L�@d� L��CA ǃ�d����A�� ��@���� 䃀�  @�D@ DB�� $��L�����D�	d����C�� ��   b  ��G�LE�
ƅD ���d�� �
"  @�\ 
GE
��
FE$ ��  ̅E� �� �G�LE�
ƅD ���d�� �
"   �\ 
GE
��
FE$ ��  ̅E� ��G� @����G���
 ���	��"   �FEF �� dE L�����E�d��@�
 �L�Cd� ����@�
�E �  ��D@ DB�� $��LGd� MD��DG ��D���G ��G	  @�� ���� �H	@��D��DH	F�H G��
�D��I	GEI �D��D@ �D�	A�	 䄀���	@� � 	�D �  ���J ���	@ ���  �� �	��$E�E�	��H ��H$E��	�EI $E�E@ EB
��	 $���I
�� ��	$E   �  CJ$� L�J��d����J�� �K ���� �C�@ 䃀̃�@�䃀���@ 䃀��@�䃀�C�@ 䃀̃�@�䃀���@ 䃀��C  䃀�C�@ 䃀̃�@�䃀�M $� N�� ��$D & � 9   HasPetPstID_worldGetRenderBoardEntityLogicResultGetLogicResultLogicStepTypeNormalAttackGetRenderGridPosition)GetNormalSkillSequenceWithAttackGridDataGetServiceTime GetNormalSkillSequenceWithOrderorder       GetCurrentTimeMs        attackGridDataGetEffectResultByArrayAllSkillEffectTypeDamageGetDamageInfoGetDamageIndexGetDamageValue	AddBloodplayStartTimeYIELD#SetCurPlayNormalSkillPlayStartTimeRenderBattleGetComboNumSetComboNumNTNormalAttackCalcEndNewSetSkillIDSetSkillType
SkillTypeNormalSetNormalAttackIndex_normalAttackIndex	PlayBuffPlayBuffViewNTNormalAttackCalcEndUseOriPosGetHitAnimationGetHitEffectIDHitTurnToTargetHandleBeHitParam!SetHandleBeHitParam_CasterEntity!SetHandleBeHitParam_TargetEntity SetHandleBeHitParam_HitAnimName SetHandleBeHitParam_HitEffectIDSetHandleBeHitParam_DamageInfoSetHandleBeHitParam_DamagePos"SetHandleBeHitParam_HitTurnTargetSetHandleBeHitParam_DeathClearSetHandleBeHitParam_IsFinalHitSetHandleBeHitParam_SkillIDSkillServiceHandleBeHit         �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �                                     
  
  
  
  
  
  
  
                                                                                                                      !  !  "  "  "  "  "  "  "  #  #  #  $  $  $  $  %  %  %  &  &  &  &  &  &  &  &  (  +  /  /  1  1  1  2  2  5  5  5  6  6  5  7  7  5  8  8  5  9  9  5  :  :  5  ;  ;  5  <  <  5  =  =  5  >  >  5  ?  ?  5  A  A  A  A  A  A  B  "   self    �   TT    �   casterEntity    �   targetEntity    �   attackAnimParam    �   isSlantAttack    �   damage    �   
damagePos    �   isFinalAttack    �   skillID    �   isAddCombo    �   oriBeAttackPos    �   renderBoardEntity   �   normalAtkResultCmpt   �   
attackPos   �   curNormalSkill   �   timeService   `   preNormalSkill   `   beforeWaitTime    `   preDamageValue!   `   preDamageResult"   `   preDamageResultLast.   5   preDamageInfo2   5   preDamageResultLast@   G   preDamageInfoD   G   afterWaitTime\   `   renderBattleSvcf   �   curComboNumh   �   nts   �   nt1�   �   hitAnimName�   �   hitEffectID�   �   hitTurn2Target�   �   beHitParam�   �      _ENV C  U   !   � $� "  ��GA@ L����  d���A�� �AA   ���C@ �A��$��"  @��   � �L�A��dC�LB��   �C� dC��  jB�& � 	   EffectHolder_worldGetServiceRenderBattleGetPermanentEffectipairsGetEntityByIDSetSpecialAnimRootSetAnimatorControllerTriggers         !   E  E  F  F  H  H  H  H  I  I  J  J  J  J  K  K  K  K  L  L  M  M  N  N  N  P  P  P  P  P  J  J  U     self    !   casterEntity    !   	animName    !   	rootName    !   effectHolderCmpt   !   renderBattle       permanentEffectList
       (for generator)       (for state)       (for control)       index      	effectID      effectEntity         _ENV                              
   K   
   O   �   O   �   B  �   C  U  C  U         _ENV