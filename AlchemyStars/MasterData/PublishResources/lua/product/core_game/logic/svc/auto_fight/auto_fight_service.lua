LuaS �

xV           (w@W@../PublishResources/lua/product/core_game/logic/svc/auto_fight/auto_fight_service.lua         =   @ A@  $@ �@ A�  � A $@��@  ���@ l   
@���@ A� ��A $@��A   ��A l@  
@���A l�  
@ ��A l�  
@���A l  
@ ��A l@ 
@���A l� 
@ ��A l� 
@���A l  
@ ��A l@ 
@���A l� 
@ ��A l� 
@���A l  
@ ��A l@ 
@���A l� 
@ ��A l� 
@���A l  
@ ��A l@ 
@���A l� 
@ ��A l� 
@���A l  
@ ��A l@ 
@���A l� 
@ ��A l� 
@���A l  
@ ��A l@ 
@���A l� 
@ ��A l� 
@���A l  
@ ��A l@ 
@���A l� 
@ ��A l� 
@���A l  
@ ��A l@ 
@���A l� 
@ ��A l� 
@���A l 	 
@ ��A l@	 
@���A l�	 
@ ��A l�	 
@���A l 
 
@ ��A l@
 
@���A l�
 
@ ��A l�
 
@���A l  
@ ��A l@ 
@��,� F�A �� J� �F�A �  J���F�A �@ J� �F�A �� J� �F�A �� J���F�A �  J� �F�A �@ J���F�A �� J� �F�A �� J���F�A �  J� �F�A �@ J���F�A �� J� �F�A �� J���F�A �  J� �F�A �@ J���F�A �� J� �F�A �� J���F�A �  J� �F�A �@ J���F�A �� J� �F�A �� J���F�A �  J� �F�A �@ J���F�A �� J� �F�A �� J���F�A �  J� �F�A �@ J���F�A �� J� �F�A �� J���F�A �  J� �F�A �@ J���F�A �� J� �F�A �� J���F�A �  J� �F�A �@ J���F�A �� J� �F�A �� J���F�A �  J� �F�A �@ J���F�A �� J� �F�A �� J���F�A �  J� �F�A �@ J���F�A �� J� �F�A �� J���F�A �  J� �F�A �@ J���F�A �� J� �F�A �� J���F�A �  J� �F�A �@ J���F�A �� J� �F�A �� J���F�A �  J� �& � i   requirebase_service_classAutoSkillCastDataObjectConstructorAutoFightServiceBaseServiceInitializeEnableAutoMove
IsRunningSetCastPetTrapSkillPetEntityGetCastActiveSkillCountSetCastActiveSkillCount
AutoFight_DoAutoFightOnAutoFight_BeginOnAutoFight_EndHandle_MovePathHandle_PickUpChainSkillTargetHandle_CastTrapSkillHandle_CastPetTrapSkillHandle_CastActiveSkill_IsFeatureSkill_IsPersonaSkillMissionCanCast_TryInsertSkillToSortList_FindActiveSkill_GetFsmStateID_FindTrapSkill_FindPetTrapSkill_FindAircraftCoreSkillID_FindRoundkillID_FindQingTongTrapSkillID_CanCastTrapSkill_CastTrapSkill_CastActiveSkill_LocalPlayerCastActiveSkill_CheckIsMultiActiveSkill_CheckIsVariantActiveSkill%_CheckLocalCastActiveSkillPickEnough!_RecordLocalCastActiveSkillError(_CheckLocalCastActiveSkillErrorCurRound_RemotePlayerCastActiveSkill_CalcPickupPosList!_CalcTrapPickupPosList_YiSiTaWan_CalcTrapPickupPosList_CalcPickUpColor_CalcPickUpPosAndRange_CalcPickUpPosAndTeleport_CalcPickUpDirection_CalcPickUpPosAndDirection_CalcPickUpLineAndDirection_CalcPickUpPosAndRotate_CalcPickUpSwitch_IsCrossDir_IsXDir_CalcSkillScopeResult _CalcSkillScopeResultAndTargets_CheckSkillCondition_CheckFeatureSkillCondition_CalPickPosPolicyPetXiNuoPu_CalPickPosPolicy_NearestPos!_CalPickPosPolicy_MovePathEndPos_CalPickPosPolicy_PetJiaBaiLie_CalPickPosPolicy_PetLuoYi_CalPickPosPolicy_PetLen_CalPickPosPolicyPetYuSen_CheckSubSkillCondition_CanAttack_IsNeedSummonTrap_CalcMatchPickPos_CalPickPosPolicyPetQingTong_CalPickPosPolicy_PetGilesGetPosListAroundBodyArea_IsPosCanPick_IsPosBadGrid_IsPosInExtraBoard_CalPickPosPolicy_PetVice%_CalPickPosPolicy_FeatureMasterSkill_PetKaLian_CanGridConvertToRed'_CalPickPosPolicy_PetSPKaLian_NoDamage)_CalPickPosPolicy_PetSPKaLian_WithDamage_GetReinhardtRange_CalPickPosPolicy_PetReinhardt_CastFeatureSkill_LocalPlayerCastFeatureSkill_CalPickPosPolicyPetFeiYa_FindFeatureCardSkillID_FindFeatureShopSkillID_FindFeatureBanPetSkillID_CalPickPosPolicyPetJudge_CalPickPosPolicyPet1601701_CalPickPosPolicyPet1601751,_CalPickupPosPolicyPet1601751SummonHealTrap _OnLocalCastActivePickSkillFailClearPetActiveSkillTempData!_CalPickPosPolicy_PetZhongxuMain"_CalPickPosPolicy_PetZhongxuExtra _CalPickPosPolicy_PetYeliyaMain!_CalPickPosPolicy_PetYeliyaExtra!_YeliyaFindValidPosWithSuperGrid&_YeliyaFindValidPosWithMaxTargetCount!_YeliyaFindValidPosNearToMonster%Handle_NotifyClientUnscaledCountDown    e    	          
@ �
���
� �
 ��
@�
���
��& �    
m_pCasterm_nSkillID	m_nPetIDm_listPickUpPosm_listSelectTeamPosm_pickExtraParamm_clientSelectInfo           
                           self       pCaster       	nSkillID       nPetID       listPickUpPos       selectTeamPos       pickExtraParam       clientSelectInfo               %       F@@ L�� d� 
@ �
 ��
���K   
@��
@B�
@B�
���
@B�
 ��
�C�L D d@ & �    _scopeFilterDeviceSkillScopeFilterDeviceNew_lastConvertColor        _randPieceColor _lastCastSkillPetIds_env _envPickUp_autoMoving_castPetTrapSkillPetEntity_castActiveSkillCount_usePickCheckRegistPickUpPolicyCalculator                                                    !   $   $   %      self          _ENV '   4       G@@ L�� ��  d��
@ �G@@ L�� �@ d��
@ �G@@ L�� �� d��
@ �G@@ L�� �@ d��
@ �G@@ L�� �� d��
@ �G@@ L�� �@ d��
@ �& �    _boardServiceLogic_worldGetServiceBoardLogic_boardServiceRenderBoardRender_configServiceConfig_battleServiceBattle	_utilSvc	UtilData_utilScopeSvcUtilScopeCalc           )   )   )   )   )   +   +   +   +   +   -   -   -   -   -   /   /   /   /   /   1   1   1   1   1   3   3   3   3   3   4      self            6   8       � � 
� �& �    _autoMoving           7   7   8      self       enabled            :   <       G @ f  & �    _autoMoving           ;   ;   <      self            >   @       
@ �& �    _castPetTrapSkillPetEntity           ?   @      self       entity            B   D       G @ f  & �    _castActiveSkillCount           C   C   D      self            E   G       
@ �& �    _castActiveSkillCount           F   G      self       count            J   X       � @ �     �& � �@@ @ �@�ƀ@ �    ���@ @� � �@ � �� A @� � �@ �@A @ �@�& �    _autoMovingOnAutoFight_BeginDEBUG_AUTO_FIGHT_AutoMovePath_DoAutoFightOnAutoFight_End            K   K   K   L   P   P   P   Q   Q   Q   R   R   R   R   R   T   T   T   T   W   W   W   X      self       TT       teamEntity          _ENV \   �    	J   � @ �@@ @� 䀀�     �& � ̀@G�@ G�䀀�   � �AA �� $A�& � �A �� $��"    �& � �A �� $��"    �& � B "  ���@ AFAB G����B�� �C�� �B d��bA    �
@C�L�C �� B d� b  � �
@C�& � ��
@C�@��C �� $��"    �& � D $A �C �� $��"    �& � AA �� $A�& �    _battleServiceHandle_PickUpChainSkillTargetCheckAllMonstersDead_envTeamEntityHandle_MovePath%Handle_NotifyClientUnscaledCountDownHandle_CastTrapSkill_castPetTrapSkillPetEntitytable
icontainsTeamGetTeamPetEntities Handle_CastPetTrapSkillHandle_CastActiveSkillClearPetActiveSkillTempData         J   ]   `   `   `   `   `   a   c   c   c   c   d   d   e   e   e   f   i   i   i   i   i   j   m   m   m   m   m   n   r   r   r   t   t   u   u   u   u   u   u   u   u   u   u   v   y   y   y   y   y   y   z   {   {   }   ~                  �   �   �   �   �   �   �   �   �   �   �   �   �      self    J   TT    J   battleService   J   allMonsterDead   J   teamEntity"   7      _ENV �   �       
@@���@ ��@�� � AAA �AC� �@ ��A  � �@���@ � BAB �B���� B ���� � �� C  � �@�& �    _autoMoving_worldEventDispatcher	DispatchGameEventTypeBanAutoFightBtn_BuildMoveEnv
MatchTypeGetMatchTypeTypeNoLinkLineMT_PopStarPro_BuildPopStarProPickUpEnv            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       teamEntity          _ENV �   �       
@@�
@@�
 ��G@A L�� d� L�� � B �@�  d@ & � 
   _env _envPickUp_autoMoving _worldEventDispatcher	DispatchGameEventTypeBanAutoFightBtn            �   �   �   �   �   �   �   �   �   �   �   �      self          _ENV �   �       � @  � � ��   & �    _AutoMovePath           �   �   �   �   �      self       TT            �   �       � @ �@@̀@ � � ����@ � A��� �@A�A �AK�  JAB�J�B��� �  �A� J���@ �@C � � � �@�� � �  & �    GameStateIDPickUpChainSkillTarget_GetFsmStateIDGameGlobalEventDispatcher	DispatchGameEventType
FakeInputuiUIChainSkillPreviewinputbtnCancelOnClickargsYIELD�                  �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       TT          _ENV �   �    	   � @ �� ���  �& � ̀@ @� ��@�ABA�  �   & �    _FindTrapSkill _CastTrapSkill
m_pCasterm_nSkillIDm_listPickUpPos           �   �   �   �   �   �   �   �   �   �   �   �   �      self       TT       pSkillData           �   �    
   � @ @ 䀀���  �& � �@ �� ����GB�% &  & �    _FindPetTrapSkill _CastTrapSkill
m_pCasterm_nSkillIDm_listPickUpPos           �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       TT       
petEntity       pSkillData           �   �    2   � @ �� @@  �& � ��@ ��@��� � A @� 䀀���  �& � �@ �@$�� F�A G��� ΁ �A�dA�L�B ���d��b  ��LC ��  �dA GAC ���J�C��LD �� B�G�����ǂ���G�dA�GAC ���J�C�  & �    MissionCanCast osclock_FindActiveSkill Logdebug'[AutoFight]FindActiveSkill() use time=�      _IsFeatureSkillm_nSkillID_CastFeatureSkill_lastCastSkillPetIds	m_nPetID_CastActiveSkill
m_pCasterm_listPickUpPosm_listSelectTeamPosm_pickExtraParam         2   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    2   TT    2   t1   2   pSkillData   2   t2   2      _ENV �   �       � @ �@@�  �����@@� 䀀�   @��$� FAA G��@@ �C� f L��d� �B �AB����  & & � 
   _worldGetServiceConfigGetSkillConfigDataGetSkillType
SkillTypeFeatureSkillGetAutoFightPickPosPolicyPickPosPolicy
PetBatiya            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       skillID       configService      skillConfigData      
skillType         _ENV �         � @ �@@�  �����@FA GA�䀀�   ��̀AFA GA�䀀@�@ �� & �   �  & �    _worldGetServiceFeatureLogicHasFeatureTypeFeatureTypePersonaSkillGetFeatureSkillID            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �                  self       skillID       lsvcFeature      personSkillID         _ENV         F @ G@� ��@ d� ��� �� � A� AA �A �����A� � �AB �B� �B@ �C� f GCf � � �  & �    GameGlobal
GetModuleMatchModuleGetMatchEnterDataGetMatchType
MatchTypeMT_MissionGetMissionCreateInfomission_idCfgcfg_mission CastSkillLimit                        	  	  	  	  	  	  
  
  
                             self       matchModule      
enterData      currentMissionId      current_mission_cfg      missionCanCast         _ENV   a   �   �@ �  ���A@ ́�� �@ A � ��AA� �A ��� $� "    �& � ��A ��@�� � �    �& � B�� $��C  ��B�� ��B ������BC�� ��C� ����D� �A CD� ��  A� �� $��a�  �CB  C� @���B�� ��B ����@��E�� �BEC@ �E�� $��LF�  �d� �D�� a@  �CB  C� @���B�� ��B �B�� ���A ��F �����BC� ̂�A� 䂀C@ �E� $��LDd� !�� ��CG  ���[ @�CB  C� ����B�� ��B ǂ������G�� �   ���G� @� ���A �H  @ �� _�D  �CB  C� �  ��A �B�@�� � �  ����A ̂�@�䂀�    ��� ��A ���@ � � I�CI ��I$��"  @ ���	 C� LJd� bC  ��b   ������B   �FCJ G���� ��  @ ���C�dC�& � +   _usePickCheck_worldGetGameTurnGameTurnTypeLocalPlayerTurnGetLevelTotalRoundCount(_CheckLocalCastActiveSkillErrorCurRound	_utilSvc%IsBuffSetExtraActiveSkillCanNotReadyGetSkillConfigDataGetSkillTriggerTypeSkillTriggerTypeLegendEnergyAttributesGetAttributeLegendPowerGetSkillTriggerParam#CalcMinCostLegendPowerByExtraParam        
BuffLayerGetSkillTriggerExtraParambuffEffectTypeGetService
BuffLogicGetBuffLayerAlchemyEnergyGetEntityByPstIDAlchemyPower	UtilCalcIsPetCurRoundCastActiveSkillColorPalette
IsSatisfyGetPetPowerAttr&IsSkillDisabledWhenCasterIsTeamLeaderIsPetCurrentTeamLeaderGetPetSkillReadyAttrHasBuffFlag
BuffFlagsCanOverdraw       HasPetDeadMarktableinsert         �                                                        !  !  "  %  %  %  (  )  )  )  )  )  )  +  +  +  +  +  .  .  /  /  /  /  /  /  /  /  0  0  0  0  0  1  1  1  1  1  1  2  2  3  5  5  5  5  6  6  6  6  7  7  8  8  8  8  8  9  9  9  9  9  9  :  :  :  :  <  <  <  <  <  >  >  >  >  @  @  A  A  A  A  A  A  A  A  A  A  B  B  B  B  B  B  C  C  D  D  E  E  E  F  I  I  I  I  I  K  K  K  K  M  O  O  O  O  O  O  O  P  P  P  P  P  P  Q  U  U  U  U  U  X  X  X  X  Y  Y  Z  [  ^  ^  ^  ^  ^  ^  ^  ^  ^  ^  _  _  _  _  _  _  _  _  _  a     self    �   sorted_skills    �   e    �   petId    �   skillId    �   configService    �   battleStatCmpt    �   	curRound      isBuffSetCanNotReady   �   skillConfigData   �   powerEligibility   �   legendPower*   8   defaultCost,   8   minCost4   8   extraParamA   P   buffEffectTypeB   P   blsvcF   P   currentValJ   P   requiredValL   P   
petEntity[   o   alchemyPower`   o   utilCalcSvcd   o   defaultCostf   o   colorPalettex   }   power�   �   disWhenIsTeamLeader�   �   ready�   �   canOverdraw�   �      _ENV j     #�  � @ �@@�  �����@ �FAA G���@ ��A�� �B�   FBB ��B�� ��B� d ������ �CC�� ̃C� �C  � ��C    �����FD GD�D"  @�@ �D$� �D$� LEd� �DE ��E	_������E �F	��� �DF	�F �F
KE  �EE ��EJ���D �DG �� � �D���$� H$� GDH L��� d��bD  �����I EI
����D   ��DH ��I	��$ ��  _ J	@��DH �D�	@ 䄀�D  �
���$� �J
$� "E  ��G@ L�
� d���E�
��   L�K �  �@ � 
�   dE L��d� L��
d� b   ���
 ��@��EB ��
���̆K @ ���   @ � �F ��  *F�i�  �B�G@ LB�d� ��L ��L�� (�G@ LB�� d���B�D �M����   ����D �M��  �� � � L��C��D ��M$��F�N G��� �   @ � �D Ǆ�	�C dC��B�D O����   ����D O��  �� � � L��C��D �O$��F�N G��� �   @ � �D ��	�C dC��B�D CO����   ����D CO��  �� � � L��C��D �CO$��F�N G��� �   @ � �D �D�	�C dC��B�D �O����  ����O �� �  ��ƂN ���  K �  �  FD G��kC �B��B�D P����  ���BP �� �  ���N �N@ �C �    A �D �P	����C $C��B�D �P����  ���Q �� �  ��ƂN ���  K �  �  FD G��kC �B�GBQ ��N ��Q� ,  �B��  �� � D  �CB � ����N	R	GER	��P	̅�@ 
䅀��$� LS � 
d��b  @�LFS ��  �	@ 
��d� b  @���	� 
 �
@ ����\  @�� �L�S ��  �	@ ��d� b   ���	��� �
����LT ��  �	@ 
��d� b  � ���	� 
 �
@ ���  *D�������S  �����C  @ ��  � ��T ��T  @�� ��E�G�������  & � W   _worldGetServiceConfig_envTeamEntitySkillPickUpTypeNoneBattleStatGetLevelTotalRoundCountipairsTeamGetTeamPetEntities	MatchPetGetMatchPetGetFeatureListfeatureFeatureTypeScanGetBoardEntityLogicFeatureGetScanActiveSkillTypeScanFeatureActiveSkillTypeSummonTrapGameGlobalEventDispatcher	DispatchGameEventTypeScanFeatureSaveInfo
skillTypeYIELD�       	PetPstID	GetPstID	_utilSvcIsSilenceStateHasBuffFlag
BuffFlagsSealedCurseOnCheckPetCanCastActiveSkillGetID  IsBuffSetActiveSkillCanNotReady
SkillInfoGetActiveSkillIDGetPetDataGetPetActiveSkill_TryInsertSkillToSortListGetExtraActiveSkillIDList        GetGameTurnGameTurnTypeLocalPlayerTurnFeatureLogicHasFeatureTypePersonaSkillGetFeatureSkillCurPower       GetFeatureSkillIDtableinsertMasterSkillRecoverMasterSkillCard_FindFeatureCardSkillIDShop_FindFeatureShopSkillIDselectInfoBanPetSkill_FindFeatureBanPetSkillID_configServicesort                      GetSkillConfigDataGetSubSkillIDList_IsFeatureSkill_CheckFeatureSkillCondition_CheckSubSkillConditionsubSkillID_CheckSkillCondition AutoSkillCastDataNewPickUpGridPosSelectTeamPosPickUpExtraParam         �  �   	(   �   � @A@ �����@�� �   � �GA� 䀀̀�� � ��� �@$� LA�AA d��bA    �A� �AB� ����A    ��� `��  ��A  �� � `�   �A  � & & �    GetSkillConfigData       GetAutoFightSkillOrderTeamGetTeamIndexByPetPstID                  	    (   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     a    (   b    (   order1   (   order2   (   	teamCmpt   "   	teamIdx1   "   	teamIdx2   "      svcCfgteamEntity�  l  l  l  l  m  o  p  p  r  r  r  s  s  t  u  u  u  u  u  u  u  v  v  v  v  w  w  w  w  w  w  w  x  x  x  x  x  x  y  y  y  y  y  z  z  {  {  {  {  |  |  |  |  |  |  |  }  }  }  |  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  u  u  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �                                                        	  	  �  �                                            <   self    �  TT    �  configService   �  env   �  teamEntity   �  pickUpType   �  battleStatCmpt   �  	curRound   �  sorted_skills   �  (for generator)   �   (for state)   �   (for control)   �   i   �   e   �   	matchPet   �   featureList    �   featureLogicComponent+   @   scanActiveSkillType-   @   petIdD   �   
isSilenceH   �   petCanActiveAttackU   �   isBuffSetCanNotReady[   �   skillIda   �   petDatag   j   extraSkillListv   �   (for generator)~   �   (for state)~   �   (for control)~   �   index   �   extraSkillId   �   lsvcFeature�   3  	curPower�   �   ready�   �   skillId�   �   	curPower�   �   ready�   �   skillId�   �   	curPower�   �   ready�   �   skillId�   �   skillId�     skillId    selectInfo    skillId&  3  svcCfg4  �  caster:  �  skillID;  �  petID<  �  clientSelectInfo=  �  (for generator)@  {  (for state)@  {  (for control)@  {  _A  y  vA  y  eB  y  skillIdC  y  petIdD  y  selectInfoE  y  skillCfgDataH  y  subSkillListJ  y     _ENV         G @ L@� d� b   � ���� �  �   ��@ � A�  & �    _worldGameFSMCurStateIDGameStateIDInvalid                                       self       gameFsmCmpt         _ENV "  K   a   G @ L@� � @ ǀ����d���   � A A� $ �  @���$� �A� $��"B    �B L��d� ����� _�B ������ _@B  ��B  ��   ��� ��  @ �� �@ ��  j�����  �& � �@ �    ��@$� C$� "  ��AC � $���  �C � ��$� "A    �& � �C �   @�L�@d� L�d� b  ��LAD � d��� �L�C �  �@ d��bA    �& � D  ��D ��D  @��  �ECEG�E�����  & �    _world	GetGroupBW_WEMatchersTrapipairsGetEntitiesAttributesGetAttribute
TrapPower        GetCantAutoSkill IsAircraftCore_FindAircraftCoreSkillID_CanCastTrapSkill_envIsCastSkillByRound_FindRoundkillIDAutoSkillCastDataNewPickUpGridPosSelectTeamPosPickUpExtraParam         a   $  $  $  $  $  $  &  '  '  '  '  '  (  (  (  (  (  (  (  (  *  *  +  +  +  +  +  +  +  +  +  +  ,  ,  ,  ,  -  -  '  '  2  2  3  7  9  9  9  9  9  9  9  9  :  :  :  :  ;  ;  ;  ;  ;  ;  <  A  B  B  B  B  B  B  B  B  C  C  C  C  D  D  D  D  D  D  D  E  I  J  J  J  J  J  J  J  J  J  J  J  K     self    a   group   a   caster   a   (for generator)   (   (for state)   (   (for control)   (   i   &   e   &   power   &   trapComponent   &   canAutoSkill    &   skillID,   a   env@   a   clientSelectInfoU   a      _ENV P  �   �   �   �   b   ��@ A@@���� � $A  @��@ AAA$� �A$� F�A � d@��@ �B@����$ �B  i�  ���B AB�B ��B��B$��F�A �C� d @��B��� �B  @������ ��C�� �  ������� �  ������ �BD�� ̂�� �   ���$� "   ��$� "   ��$� �@$� � @ CE@�� $��"  ��  L��d� ��E �F �����    �� �C��� ��F� ����C    ��  ��� �"C  @ �� �@ �i�  ������  �& � G�@ � ́G @ 䁀����G @ � �� �� �A    �& � ��@   FH LB��   D  �������@ e�f  & � %   tableinsertGetID_envTeamEntityTeamGetTeamPetEntitiesipairs_world	GetGroupBW_WEMatchersTrapGetEntitiesHasDeadMarkIsPetTrapCastSkillHasSummoner	SummonerGetSummonerEntityIDGetSummonerEntityHasSuperEntityGetSuperEntity
icontainsGetGridPosition_utilScopeSvcIsPosHaveMonsterOrPetAttributesGetAttribute
TrapPower         _FindQingTongTrapSkillID_CanCastTrapSkillAutoSkillCastDataNewPickUpGridPosSelectTeamPosPickUpExtraParam         �   S  U  V  V  W  W  W  W  W  W  W  Y  Y  Y  Y  Y  Y  Z  Z  Z  Z  [  [  [  [  [  [  Z  Z  _  _  _  _  _  _  `  `  `  `  `  a  a  a  a  a  a  a  a  a  a  a  a  a  a  b  b  b  b  d  d  f  f  f  f  f  f  f  f  f  f  g  g  g  g  g  i  i  i  i  i  i  i  k  l  l  m  m  m  m  m  m  n  p  p  p  p  p  p  p  p  q  q  q  q  r  r  `  `  y  y  z  ~  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    �   
petEntity    �   caster   �   petEntityIDList   �   pets      (for generator)      (for state)      (for control)      _      
petEntity      
trapGroup#   �   (for generator)'   l   (for state)'   l   (for control)'   l   _(   j   e(   j   summonEntityID:   j   summonEntity<   j   
isCoveredS   j   trapPosU   j   powerd   j   envp   �   skillIDq   �   env   �   clientSelectInfo�   �      _ENV �  �   L   � @ �@@�� ƀ@ ���� @ ��  �  �  �@� � ��$� G�A�B�AB�B �� ��$� �� ������B ���@��@ ��@ 䃀D�$� �C$� LD�d� L��� d���D� �@ �� ��  ��  *����� �� �  ����DFE GC�䂀�B  @ �� ��  �B� � ̂�� C� $� �C� $��R� ��@ ��  �  �  & �    _worldLinkLineTypeELinkLineTypeELLT_LINE_NoElementCostStep        TrapGetActiveSkillID                      _CalcSkillScopeResultAndTargetsipairsGetEntityByIDAttributesGetCurrentHPGetAttributeMaxHP�������?BuffComponentHasBuffEffectBuffEffectTypeLayerShieldffffff�?         L   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    L   caster    L   skillID
   L   	trapCmpt   L   activeSkillID   L   damageSkillID   L   healSkillID   L   shieldSkillID   L   _   L   
targetIds   L   (for generator)   0   (for state)   0   (for control)   0   i   .   id   .   e    .   hp$   .   maxhp)   .   com2   L   hp@   L   hpMaxE   L      _ENV �  �      � � �� �@@A�  䀀�� $� LAd� ����A    ��A � & �    AttributesGetAttributeCurrentRoundTrapGetActiveSkillID                   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       caster       	attrCmpt      	curRound      	trapCmpt      activeSkillID	      skillID
           �  �   '   �   �@� � ��$� G�@bA    �A  �A�A    ��  �AA ́�@�䁀��$� FB GB�@  �f �� $� F�B G��BC ��C  ���_��@ ��    �� ��  & �            TrapGetActiveSkillID              _configServiceGetSkillConfigDataGetAutoFightPickPosPolicyPickPosPolicyPetYisitawanTrapGetGridPosition
PieceTypeBlue_boardServiceLogicGetPieceType         '   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  	   self    '   caster    '   skillID   '   	trapCmpt   '   activeSkillIDs   '   damageSkillID	   '   convertSkillID   '   skillConfigData   '   trapPos   '      _ENV �     a   ! @@ �C  f GA@ L��� d����� �� �AB ����A    ��  ��� � ��A� 䁀�A    ��  ��$� !�@� ���� L�� d� L��B d����B ��B�� �C� CC @�$� ��  �B)�  ���  �@
���$� F�C G�@  � �F�C GC�@ �L��d� ��D �E��DE �E����  @���E  � @ �Cʀ��@������� ��F ������CG  � @ � �C�ʀ��@��C� f   & & �            _configServiceGetSkillConfigDataAttributesGetAttribute
TrapPowerSkillCountGetSkillTriggerParam       CastSkillRound_worldBattleStatGetLevelTotalRoundCountipairsGetSkillPickTypeSkillPickUpTypeNoneInstructionGetSkillTagtable
icontainsPetSkillTagFixedPieceColor_CalcTrapPickupPosListPickUpGridPosPickUpExtraParamGetAutoFightPickPosPolicyPickPosPolicyPetYisitawanTrap!_CalcTrapPickupPosList_YiSiTaWan         a   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �                                                       	                                         self    a   caster    a   skillID    a   env    a   petEntityIDList    a   skillConfigData   a   power   a   count   a   oneRoundLimit   ^   castSkillRound$   ^   battleStatCmpt'   ^   	curRound)   ^   (for generator),   2   (for state),   2   (for control),   2   _-   0   round-   0   pickUpType6   ^   
skillTagsA   \   posListM   O   	gridListM   O   tarListM   O   pickUpExtraParamM   O   posListZ   \   	gridListZ   \   tarListZ   \   pickUpExtraParamZ   \      _ENV   d   �   ! �@ �C  f FA@ G����  ��dA�FA GA�d�� L����A ��� LBBd dA  F�B G���C �� _�� �FAC �� �� dA� �FA GA�d�� L����A ����  
BD�
�D�K� ��kB� 
B�dA FAC �� �A dA�FA GA�d�� L����A ����  
BD�
�E�K  
B�dA G�E L�d� �A��� ǁF ����$��LGd� �BG ��G��  ����BG ��G���
�"  @��H � ����C@ ǃ�D F�H G��� d �C  �I@��C��CI@ �C�̃I@���	 �C ���C �CC  � AD �C���  *C��A �BA��� ��A�A �CK�  JCJ�J�J��  J���B �BC �� C �B���B ��J�C � _� ��BC �� � �B� ��� � & � ,           Logdebug#[AutoFight] CastTrapSkill skillID=GameGlobalEventDispatcher	DispatchGameEventTypeUITrapSkillVisibleGetIDGameStateIDPreviewActiveSkill_GetFsmStateIDYIELDd       
FakeInputuiUIWidgetTrapSkillinput_OnShowSelectSkillargs�      btnGoOnClick_worldGetRenderBoardEntityPickUpTarget_configServiceGetSkillConfigDataGetSkillPickTypeSkillPickUpTypeNoneInstructionipairspickup pos Vector2
Pos2IndexSetPickUpTargetTypeSetPickUpGridPosSetCurActiveSkillInfo��������ReplacePickUpTargetUIWidgetChooseTargetHandleActiveSkillConfirmActiveSkill         �                     "  "  "  "  "  "  "  "  "  "  %  %  %  %  %  %  &  &  &  &  &  )  )  )  )  *  *  *  ,  -  .  .  .  .  )  2  2  2  2  5  5  5  5  6  6  6  8  9  :  :  5  @  @  @  B  B  D  F  F  F  H  H  J  J  J  J  J  K  K  K  K  L  L  M  M  M  M  N  N  N  N  N  N  N  N  O  O  O  P  P  P  Q  Q  Q  Q  R  R  S  S  S  S  M  M  W  W  W  W  X  X  X  Y  Y  Y  Y  W  ]  ]  ]  ]  _  _  _  _  _  _  `  `  `  `  `  c  c  d     self    �   TT    �   caster    �   skillID    �   pickUpGridPos    �   renderBoardEntity?   �   pickUpTargetCmptA   �   
configSvcB   �   skillConfigDataE   �   pickUpTypeG   �   (for generator)U   p   (for state)U   p   (for control)U   p   iV   n   posV   n      _ENV g  �   A   @ B@A�  ��@�� �  �$B�BA �A$� F�A G�@ �BB �� �  �@ ��� $B  ��B �� �  �@ ���  �$B��B CLBC d� _@ ��C "B  @��B �CLBC d� @��
 D�BA BD$� L�Dd� ��D  �@��B  �E @� �B $B� �& �    Logdebug$[AutoFight] CastActiveSkill caster=GetID
 skillID=_worldGetGameTurnGameTurnTypeLocalPlayerTurn_LocalPlayerCastActiveSkill_RemotePlayerCastActiveSkillGameStateIDActiveSkill_GetFsmStateID_localLastCastActiveError
WaitInputBattleStatGetLevelTotalRoundCount!_RecordLocalCastActiveSkillErrorYIELDd                A   h  h  h  h  h  h  h  h  j  j  j  j  j  j  j  l  l  l  l  l  l  l  l  l  o  o  o  o  o  o  o  o  o  r  r  r  r  r  r  s  s  s  v  v  v  v  v  v  w  y  y  y  z  z  {  {  {  {  {  ~  ~  ~  ~  ~  �  
   self    A   TT    A   caster    A   skillID    A   petID    A   pickUpGridPos    A   selectTeamPos    A   pickExtraParam    A   battleStatCmpt4   ;   	curRound6   ;      _ENV �  '   g  �@ �A�� ́�F�@ G��B �A ƁA ���B $� _ � ��AB  � A� �A� ��AB  � A� �A��C �A�䁀 ́�F�@ GB�� �A �AB  � A� �A�ǁC ����$��LDd� �@ �BD�� ̂D� �D E ��
��  @�   �����E$� F�E G�@ �CF$� �F$� L�Fd� L�d� �CG ��G��G�  �GH�� �@ �C�� ̃�@ �C�C C@$�� �@��@ ��H�� �@ $C  �D I � �C C@$�� �@��@ �CI� ��I�@ DJ� $��J����J�  ��$C CB @� �C $C��K � ��$� "  @��C �C@��� ��@�@ DIK�  J�K�JL��� ���D� J���C �CB �� D �C��@ �CL�� �@ ̃�A� 䃀  FM ��d@� H
@��E� ��E���� �
�E���M �N�  �
�E��EN  F�N G����N �E�E����E �EB �� � �E�i�  ���G@ L���D d������D �DB �� � �D��C �D@	��� ��@	�@ EI
K�  J�O�JP��  J���D ����D CP � �C C@$�� �@��@ �CI� ��I�@ DJ� $��J����J�  ��$C CB @� �C $C��K � ��$� "  @��C �C@��� ��@�@ DIK�  J�K�JL��� ���D� J���C �CB �� D �C��@ �CL�� �@ ̃�A� 䃀  FM ��d@� H
@��E� ��E���� �
�E���M �N�  �
�E��EN  F�N G����N �E�E����E �EB �� � �E�i�  ���G@ L���D d������D �DB �� � �D��C �D@	��� ��@	�@ EI
K�  J�O�JP��  J���D ����D �P � �C C@$�� �@��@ �CI� ��I�@ DJ� $��J����J�  ��$C CB @� �C $C��K � ��$� "  @��C �C@��� ��@�@ DIK�  J�K�JL��� ���D� J���C �CB �� D �C��M ������D�@��D�̄�@ 	�D����@�� �D �Q�D �DB  � A� �D���  *D��CB �� � �C��C �C@��� ��@�@ DIK�  J�O�JP��  J���C @s��D CQ �  �C C@$�� �@��@ �CI� ��I�@ DJ� $��J����J�  ��$C CB @� �C $C��K � ��$� "C  @���Q   @��� @�  "  ���C �C@��� ��@�@ DIK�  J�K�JL��� ���D� J���C �CB �� D �C��C �C@��� ��@�@ DIK�  J�K�J�Q��  J���C �CB �� D �C�@��C �C@��� ��@�@ DIK�  JR�JDR��� ���D� J���C �CB �� D �C���R�C �C�䃀 ̃�F�@ GD�� ��I��@ �D�	GH䄀��	�����J��  ����C �CB  � AD �C��CB  � A� �C��C �C�䃀 ̃�F�@ GD���  ��O��P��  ����C  R��D �R � �C C@$�� �@��@ �CI� ��I�@ DJ� $��J����J�  ��$C CB @� �C $C��K � ��$� "  @��C �C@��� ��@�@ DIK�  J�K�JL��� ���D� J���C �CB �� D �C��@ �CL�� �@ ̃�A� 䃀  FM ��d@� H
@��E� ��E���� �
�E���� �@ �E ��M �N�  �
�E��EN  F�N G����N �E�E����E �EB �� � �E�i�  ���G@ L���D d������D �DB �� � �D��C �D@	��� ��@	�@ EI
K�  J�O�JP��  J���D �4�C C@$�� �@��@ �CI� ��I�@ DJ� $��J����J�  ��$C CB @� �C $C��K � ��$� "C  @���Q   @��� @�  "  @��C �C@��� ��@�@ DIK�  J�K�JL��� ���D� J���C �CB �� D �C��  ��M @�$��FS GE�
�� ��S ��  
� dE  LE���dE�L��� 
dE�L����  dE LQdE FEB �� �� dE�GET b   �L�T ��	  @�d��bE  @ ��� @ �)�  �D�DB @� �� $D�DT "  ���T ���  �$��C  ��A ��T	�B � �	  �C� 
@U�bD  @�"  ���C   ��C �D@	��� ��@	�@ EI
K�  J�O�JP��  J���D  ��S ��U	�� �D �C �D@	��� ��@	�@ EI
K�  J�O�JV��  J���D 
@V���V ��V	�D �  � �W �DW
� �"D  @ �W �DW
�W � 	��	 �@ ��$E���
@V���V ��W	�W ��	�W � 	��	 �@ ��$E��U �  @��@ �DX	�� ̄X	� �X ��	��$E ��C D@$�� �@��@ �DI	��  ��O��P�  ��$D & � d   _worldEventDispatcher	DispatchGameEventTypeWaitInputFinish       GameStateIDPreviewActiveSkill_GetFsmStateIDYIELDd       �      GameGlobalAutoFightCheckSwitchPetColumn_configServiceGetSkillConfigDataGetSkillPickTypeGetRenderBoardEntityPickUpTargetSkillPickUpTypeNone        GetAutoFightPickPosPolicyPickPosPolicy	PetBonaiPetGetOwnerTeamEntity	PetPstID	GetPstID#CastSelectTeamOrderPositionCommandGenerateCommandGetID       PlayerSendCommandAutoFightCastSkill	LinkLine
FakeInputuiUIWidgetBattlePetuiidGetPetDatainputOnUpargs�      _CheckIsMultiActiveSkillUIWidgetPetMultiActiveSkillSubSkillOnClickGetPreviewEntityGetServicePreviewLinkLineipairsSetPickUpTargetTypeSetPickUpGridPostableinsertReplacePreviewLinkLine
PieceTypeBlueNotifyPickUpTargetChangeLinkageRenderDestroyTouchPosEffectUIWidgetChooseTargetHandleActiveSkillConfirmLinkLineSPPuzzleSetCurActiveSkillInfoReplacePickUpTargetPickUpUIAndTrap_CheckIsVariantActiveSkillBtnGoOnClickUIWidgetPetSkillbtnGoOnClick       MoyeLogdebugpickup pos Vector2
Pos2Index_usePickCheck%_CheckLocalCastActiveSkillPickEnough
WaitInput_localLastCastActiveError errorautofight pick error!!!HandleActiveSkillCancelActivePickSkillCheckErrorStepAutoPickOnPickErrorActivePickSkillCheckErrorTypeAutoPickFail _OnLocalCastActivePickSkillFailAutoPickOnStateErrorAutoPickStateErrorBattleStatGetLevelTotalRoundCount!_RecordLocalCastActiveSkillError         g  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �                                             	  	  	  	  	                                                                                                                        !  "  "    &  &  &  &  (  (  (  (  )  )  *  *  *  *  +  +  +  ,  ,  ,  ,  ,  ,  *  .  .  .  .  1  1  1  1  2  2  2  3  3  3  4  4  4  4  5  5  6  6  6  6  1  1  A  A  A  A  B  B  B  B  C  C  C  D  D  D  D  B  E  F  F  F  F  G  G  G  G  H  H  H  J  K  K  K  K  K  K  L  M  M  G  Q  Q  Q  Q  S  S  S  S  T  T  V  V  V  V  V  V  X  X  Y  Y  Y  Y  Z  Z  Z  [  [  [  [  [  [  Y  ]  ]  ]  ]  ^  ^  ^  ^  _  _  _  `  `  `  `  ^  b  b  b  b  b  d  d  d  d  e  e  e  f  f  f  f  f  f  d  h  h  h  h  l  m  m  m  m  n  n  n  p  q  q  q  q  q  q  r  s  s  m  v  v  v  v  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �                   �                                    	  
  
                                                                                        !  !  !  !  "  "  "  #  #  #  #  !  '  L   self    g  TT    g  
petEntity    g  skillID    g  petID    g  pickUpGridPos    g  selectTeamPos    g  
configSvc$   g  skillConfigData'   g  pickUpType)   g  renderBoardEntity,   g  pickUpTargetCmpt.   g  eTeamA   R   	petPstIDE   R   cmdL   R   isMultiSkill{   �   skillIndex{   �   previewEntity�   �   linkLineSvc�   �   	showPath�   �   (for generator)�   �   (for state)�   �   (for control)�   �   i�   �   pos�   �   linkageSvc�   �   isMultiSkill�   >  skillIndex�   >  previewEntity  >  linkLineSvc  >  	showPath  >  (for generator)  (  (for state)  (  (for control)  (  i  &  pos  &  linkageSvc,  >  isMultiSkill]  �  skillIndex]  �  (for generator)t  �  (for state)t  �  (for control)t  �  _u  �  posu  �  isMultiSkill�    skillIndex�    index�    isMultiSkill;  �  skillIndex;  �  previewEntityR  �  linkLineSvcV  �  	showPathW  �  (for generator)Z  {  (for state)Z  {  (for control)Z  {  i[  y  pos[  y  linkageSvc  �  isMultiSkill�  f  skillIndex�  f  findPickError�  f  tryPickCount�  f  (for generator)�  �  (for state)�  �  (for control)�  �  i�  �  pos�  �  curPickEnough�  �  pickEnough   Y  stateError  Y  
errorStep/  @  
errorType0  @  
errorStepD  M  
errorTypeF  M  battleStatCmptS  Y  	curRoundU  Y     _ENV (  =       �     LA� d� ����� ���� �  @��  ���� � �@ �  @�BA @�$� � @ ��@ �)�  �B� �@ &�& �           
SkillInfoGetActiveSkillIDGetExtraActiveSkillIDList        ipairs             )  *  ,  ,  -  -  .  .  /  /  /  /  /  0  1  1  2  2  4  4  4  4  5  5  6  6  4  4  <  <  <  =     self        
petEntity        skillId        isMultiSkill       skillIndex       skillInfoCmpt       activeSkillID       extraSkillList       (for generator)      (for state)      (for control)      index      extraSkillId         _ENV >  W   !   �     LA� d� ����� ���� �  ��� � �@ �  @���"  ��FA � d� �@@ �@� �i�  �B��� �@ &�& �           
SkillInfoGetActiveSkillIDGetVariantActiveSkillInfoipairs         !   ?  @  B  B  C  C  D  D  E  E  F  G  G  H  H  J  K  K  L  L  L  L  M  M  N  N  L  L  Q  V  V  V  W     self    !   
petEntity    !   skillId    !   isMultiSkill   !   skillIndex   !   skillInfoCmpt   !   activeSkillID   !   variantSkillInfo   !   variantSkillList      (for generator)      (for state)      (for control)      index      variantSkillId         _ENV X  r   
$   � �   ��L@d� b  @�LA@d� ����� �  @ ��� � ���� �"  @�_@ ��FA GB�@� �_�A  �A  � � �    �  & & �    HasPreviewPickUpComponentPreviewPickUpComponentIsIgnorePickCheckGetAllValidPickUpGridPosSkillPickUpTypePickOnePosAndRotate                $   Y  Z  Z  [  [  [  [  ]  ]  ^  ^  _  _  `  `  b  b  c  d  d  e  e  f  f  f  f  g  g  g  g  g  i  l  n  q  r  	   self    $   tryPickCount    $   
petEntity    $   pickUpType    $   pickEnough   $   previewPickUpComponent	       ignoreCheck       
pickGrids       pickGridsCount          _ENV s  |      � @ �@  @ ��   
� �� @ �@��@  � �� @   � � � @ �@�A@ �@@�� $A�& �    _localActiveErrorRecordtableinsert            t  t  t  u  u  w  w  w  w  x  x  x  z  z  {  {  {  {  {  |     self       	curRound       skillID       roundReceod         _ENV }  �      � @ �   ��� @ �@��   ��� @ �@�A@ �@@�� $��"  @ �� & �   �  & �    _localActiveErrorRecordtable
icontains            ~  ~  ~          �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       	curRound       skillID       roundReceod	         _ENV �  �   }   @ B@��$��L�@d� ��@ �A�����  @��  �������A�� ��A ��� ��BB�� ��B�� ��B�� �CGCC�B���C ��C�� �D@��B��BD@ �B�ǂD ���� ��@ �B�@��BE�� �B   �̂E�B �BE� ��ǂD ���A 䂀C�$� F�F ��d����F �GG GE�
�� ̄G@��D���G@ 	���D i�  �C�LH��dC�FCH L��d� �� ��C��C�  �C���� ��C����I$� LDId� ��I� �C  ���J$ �C  �C��J$ �C  ��D ��D�� �E ��C���J �K��� �BK�K �K@ �B & � 0   _configServiceGetSkillConfigDataGetSkillPickTypeSkillPickUpTypeNone        GetAutoFightPickPosPolicyPickPosPolicy	PetBonaiPetGetOwnerTeamEntityTeamSetSelectedTeamOrderPosition       CastActiveSkillCommandNewSetCmdActiveSkillIDSetCmdCasterPstID_worldPlayerSendCommandPreviewPickUpComponentAddPreviewPickUpComponentGetServiceUtilScopeCalcGetSkillScopeCalcipairsGetDirection_env
PlayerPosAddGridPosAddDirectionAddPickExtraParamListCastPickUpActiveSkillCommandSetCmdPickUpResultSetPickUpDirectionResultGetPickUpDirectionPosGetAllDirectionGetLastPickUpDirectionSetReflectDirGetReflectDirSetCmdPickUpExtraParamResultGetAllPickExtraParamGameGlobalEventDispatcher	DispatchGameEventTypeEnemyPetCastActiveSkill         }   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    }   TT    }   
petEntity    }   skillID    }   	petPstID    }   pickUpGridPos    }   selectTeamPos    }   pickExtraParam    }   skillConfigData   }   pickUpType   }   cTeam      cmd!   -   previewPickUpComponent0   t   utilScopeSvc;   t   scopeCalculator=   t   (for generator)@   O   (for state)@   O   (for control)@   O   iA   M   posA   M   
directionF   M   cmdU   t      _ENV �     #�   @ GA@ L����  d���A@ ��@ ����AA ́�@�䁀��$� L��B�  d� ����@ �� �B@ ̂�A� 䂀�$� FCC � d ���C ��C	�  ��D�i�  ��L�d� �C��� ƃD ��E� D�$� L�Ed� G���F  �����DF� ̄�	�   FEC � d� ��F  ����
�Fi�  �E�K  �  �EC  ��@�F ��$��G
bG  � �J�F\ M��ņ�  j��ƅC ��  � @�@�ƅC ��  
�  ���� ��    K  � �@ ǅ��G H � ��C FH@ ��H ��H$��"   
�@ I"   	�  G@ G��F��F�����I�������ц����FC   � �H�GH�H�IG�����N��Q��H �@ ��  ��  j���   �F�   K  � J �� �  �@�� $F�"  @�  @�� ��&�� �  K  �  & & � )   _env_worldGetServiceUtilScopeCalcBoardLogic_configServiceGetSkillConfigDataGetSkillTagBuildScopeGridList_pickUpValidScopeList_pickUpInvalidScopeList	UtilDataGetExtraBoardPosListipairstableinsertGetAutoFightPickPosPolicyGetAutoFightPickPosPolicyParam	tonumber_pickUpParam       GetSkillPickTypeGridLocation	Position_Pos2IndexElementGetPrimaryTypecount        LevelPolicyLevelPosPolicyGotoExitPos
icontainsPetSkillTag
TransportExitPosx       yCalcPickUpByPolicy         �   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �                                                                 
  
  
  
  
  
                                          5   self    �   TT    �   
petEntity    �   activeSkillID    �   env   �   utilScopeSvc   �   boardService	   �   skillConfigData   �   
skillTags   �   validGirdList   �   invalidGridList   �   	utilData   �   extraBoardPosRange   �   (for generator)    (   (for state)    (   (for control)    (   _!   &   	extraPos!   &   policy*   �   policyParam,   �   
pickUpNum0   �   pickUpType2   �   
casterPos5   �   casterPosIndex8   �   	petColor<   �   invalidGridDict=   �   (for generator)@   G   (for state)@   G   (for control)@   G   _A   E   invalidPosA   E   validPosIdxListH   �   validPosListI   �   (for generator)L   Y   (for state)L   Y   (for control)L   Y   _M   W   	validPosM   W   validPosIdxP   W   levelPolicyk   �   
targetPos|   �   exitPos~   �   neareastDistance�   �   (for generator)�   �   (for state)�   �   (for control)�   �   i�   �   pos�   �   dis�   �   pickPosList�   �   attackPosList�   �   targetIdList�   �   extraParam�   �      _ENV         @ A@��@ $��F�@ LA��   � @ �  d� �A �@�� �  & �    PickUpPolicy_YiSiTaWanTrapNew_worldPickUpPolicy_CalcParamCalcAutoFightPickUpPolicy                                                 self       trapEntity       activeSkillID       petEntityIDList       pickUpPolicyObject      
calcParam         _ENV    M   P   � @ A@ �@��  $��GA@ L��� d���AA ��A  �����A� B�BB�� $� LBǂB � d� ��B �C�B��� ̂C� � K  �D ���� ��DD @ 	䄀J��	��  *D��  �  D @ $@�LED � 
d���E��E  � ����
���EC�)�  ���@ �DLEd� GD��  �    L�E ��   @�� �   d �
@ ��& & �    _env_worldGetServiceUtilScopeCalcBoardLogic_configServiceGetSkillConfigDataGetSkillTagBuildScopeGridList_pickUpValidScopeList_pickUpInvalidScopeList	tonumber_pickUpParam       GetSkillPickType        ipairs_Pos2IndexTeamEntityGridLocation	Position_CalPickPosPolicy_NearestPos         P   !  #  #  #  #  $  $  $  $  &  &  &  &  '  '  )  )  )  )  +  +  +  +  .  .  .  .  /  /  0  2  3  3  3  3  4  4  4  4  3  3  6  7  8  8  8  8  9  9  9  :  :  :  ;  <  <  <  8  8  A  A  B  B  B  E  F  G  K  K  K  K  K  K  K  K  L  L  L  L  M  #   self    P   trapEntity    P   activeSkillID    P   env   P   utilScopeSvc   P   boardService	   P   skillConfigData   P   
skillTags   P   validGirdList   P   invalidGridList   P   
pickUpNum   P   pickUpType   P   	petColor   P   invalidGridDict   P   (for generator)"   )   (for state)"   )   (for control)"   )   _#   '   invalidPos#   '   validPosIdxList*   P   validPosList+   P   (for generator).   ;   (for state).   ;   (for control).   ;   _/   9   	validPos/   9   validPosIdx2   9   teamEntity=   P   
casterPos@   P   pickPosListA   P   targetIdListB   P   attackPosListC   P   posListK   P   attackPosListK   P   targetIdListK   P      _ENV P  b   &   @ K  �  �A@  �����@ ��$��G�@G��C�C  �����CA  � @ ���À�  �@��A B@�� �� �LEBd �D  $D��  j��f & � 
   _envipairs_Pos2IndexBoardPosPieces _CalcSkillScopeResultAndTargets        tableinsertGetAttackRange         &   Q  R  S  T  T  T  T  U  U  U  V  V  W  W  W  X  Y  Y  Y  Y  Y  [  [  [  \  \  \  \  \  \  \  \  \  \  T  T  a  b     self    &   
petEntity    &   activeSkillID    &   validGirdList    &   env   &   results   &   selectedColor   &   (for generator)   $   (for state)   $   (for control)   $   _   "   pos   "   posIdx
   "   color   "   scope_result   "   target_ids   "      _ENV e  w   '   @ K  �A@ ��@���A ��@ ��� ��A @ 䂀CA�"  @��A �� �   $À�� ���@��C@ �B�� @ ���DB� +D  �C���  *�f & � 
   _envtableshuffleipairs_Pos2IndexBoardPosPieces _CalcSkillScopeResultAndTargets        insertGetAttackRange         '   f  g  j  j  j  j  k  k  k  k  l  l  l  m  m  m  m  n  n  n  n  n  p  p  p  q  q  q  q  q  q  q  q  q  q  k  k  v  w     self    '   
petEntity    '   activeSkillID    '   validGirdList    '   env   '   results   '   (for generator)	   %   (for state)	   %   (for control)	   %   _
   #   pos
   #   posIdx   #   scope_result   #   target_ids   #      _ENV z  �   @   @ K  �A@ ��@���A ��@ A����A��A    �f   G�A L��� d���BB���B � AC ��ǃ�  @��B ��$��"   �L�� d����@C	��_ � ���B  ����  	  ��B�"  @��B@ ǂ� �K ���� D �C� � @�+D� @ kC �B�f & �    _envtableshuffle_Pos2Index
PlayerPos       _worldGetServiceBattleConnectMap       _Index2PosFindMonsterEntityInPos        insert         @   {  }          �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    @   
petEntity    @   activeSkillID    @   validGirdList    @   env   @   results   @   playerPosIdx	   @   firstPickUpPos
   @   
secondPos   @   
battleSvc   @   connect   @   (for index)   .   (for limit)   .   (for step)   .   i   -   posIdx   -   pos   -   targetEntityList#   -      _ENV �  �   A   @ GA@ L����  d������ �  B� $� F�A G����dB K  �B ���@
��CB @ 䃀�B� � $� F�A G����� d��b    ���GCGăb  ��F�A GD���� dD�L�C ��   @ dĀ� 	 ���@�ƄA �D�	 �K � � 	�$ kE  �D���  *��� & �    _env_worldGetServiceUtilScopeCalcGetSkillScopeCalcGetGridPositiontableshuffleipairs_Pos2IndexGetDirection
icontainsBoardPosPiecesinsert _CalcSkillScopeResultAndTargets        GetAttackRange         A   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    A   
petEntity    A   activeSkillID    A   validGirdList    A   env   A   utilScopeSvc   A   scopeCalculator   A   results   A   
casterPos
   A   selectedDirection   A   (for generator)   ?   (for state)   ?   (for control)   ?   _   =   pos   =   posIdx   =   
direction   =   scope_result0   =   target_ids0   =      _ENV �  �   b   @ GA@ L����  d������ �  B� $� F�A G����dB FB ��d���  ƃA �C�  F�B ����C	�D�̈́�	d��C  ƃA �C�  F�B �����C	�D���	d��C  ƃA �C�  F�B ����C	�D�΄�	d��C  ƃA �C�  F�B �����C	�D���	d��C  �B   � ��C ��	$��GDG�
b  @�LED ��   K ����	kF dŀ�  ����ƅA �E� �K ��� ��
$� @�	kF �E��  j�i�  �B�� & �    _env_worldGetServiceUtilScopeCalcGetSkillScopeCalcGetGridPositiontableshuffleipairsinsertVector2x        y       _Pos2IndexBoardPosPieces _CalcSkillScopeResultAndTargetsGetAttackRange         b   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    b   
petEntity    b   activeSkillID    b   validGirdList    b   env   b   utilScopeSvc   b   scopeCalculator   b   results   b   
casterPos
   b   (for generator)   `   (for state)   `   (for control)   `   _   ^   firstPickUpPos   ^   directionGridList   ^   (for generator)>   ^   (for state)>   ^   (for control)>   ^   _?   \   
secondPos?   \   posIdxB   \   scope_resultN   \   target_idsN   \      _ENV �  �   .   �   � � _@���ƀ@ ���  FA �@ �AA ́�d��@  ƀ@ ���  FA �@ �AA ΁�d��@   ��@� _@�@�ƀ@ ���  FA �@ ��A�AA d��@  ƀ@ ���  FA �@ ��A�AA d��@  �  & �    x        tableinsertVector2y                .   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     
centerPos    .   dir    .   ret   .      _ENV �      J   @ GA@ L����  d������ �  B� $� F�A G����dB FB ��d���  ��� @���$��FB � d ���A �EB�  �
�E�i�  ��FB � d ���B  �
�����Bǅ��  @��C @� � �  �@�
�F �ŀ\  @����F�A GF����  �@ ����� ��
�F dF�i�  ��i�  �B�� & �    _env_worldGetServiceUtilScopeCalcGetSkillScopeCalcGetGridPositiontableshuffleipairsinsert_Pos2IndexBoardPosPieces _CalcSkillScopeResultAndTargets        GetAttackRange          J   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �                                            	  	  	  
  
  
  
                                                  �  �         self    J   
petEntity    J   activeSkillID    J   validGirdList    J   env   J   utilScopeSvc   J   scopeCalculator   J   results   J   
casterPos
   J   (for generator)   H   (for state)   H   (for control)   H   _   F   firstPickUpPos   F   directionGridList   F   mainDir   F   sidePos   F   (for generator)   #   (for state)   #   (for control)   #   _   !   	sideGrid   !   (for generator)&   F   (for state)&   F   (for control)&   F   _'   D   
secondPos'   D   posIdx*   D   scope_result6   D   target_ids6   D      _ENVGetTwoSideOffset   :   ?   G@ �A@ ��@�  ����A�   LB� d� ��A ��A���B �� �B �B� �� � � A� �B  C@ ��BÆ�C��C @�$ �L�C� dD�F�C ��d���D  � @ ��
�ŀ�  �����A �D@ � ��
 �L�Dd� � �F $F�& i�  �D�)�  ��& & �    _env_worldGetServiceUtilScopeCalcGetSkillScopeCalcGetGridPositiontableshuffleAddPreviewPickUpComponentPreviewPickUpComponent                            ipairsSetReflectDir _CalcSkillScopeResultAndTargets        insertGetAttackRange         ?                 !  "  "  $  $  $  $  %  %  &  &  '  '  '  '  (  (  )  *  -  -  -  -  .  .  .  /  /  /  /  0  0  0  0  0  2  2  2  3  3  3  3  3  3  3  3  3  3  3  4  /  /  -  -  9  :     self    ?   
petEntity    ?   activeSkillID    ?   validGirdList    ?   	dirCount    ?   env   ?   utilScopeSvc   ?   scopeCalculator   ?   results   ?   
casterPos
   ?   pickUpCmpt   ?   dirs   ?   (for generator)   =   (for state)   =   (for control)   =   _   ;   dir   ;   (for generator)$   ;   (for state)$   ;   (for control)$   ;   _%   9   
pickUpPos%   9   scope_result*   9   target_ids*   9      _ENV >  h   `   @ GA@ L����  d������ �  B� $� K  �    ���A ����	���A@ � � B DB�   �L�B ��d��b  ��FB ��K ��� kD JB@�LC ��d��b  ��FB D�K ��� kD JB �FB D�@ �F�C ����  *���� �B �B� �� � � A� �B E @�$@�LDEǄE�DdD L�E ��   @ dĀ� 	 ��@��DF Ǆ�	 �K ��D� 	��$ kE  �D�)�  ���� & �    _env_worldGetServiceUtilScopeCalcGetSkillScopeCalcGetGridPositionipairsGetDirectionPickDirTypeForScopeNONE_IsCrossDirCROSS_IsXDirXSHAPEscopeParamdefaultDirTypeAddPreviewPickUpComponentPreviewPickUpComponent              pairsAddDirection        _CalcSkillScopeResultAndTargets        tableinsertGetAttackRange         `   ?  A  A  A  A  B  B  D  E  E  F  G  G  H  H  H  H  I  I  I  I  J  J  K  K  L  L  L  L  L  M  M  N  N  N  N  N  N  O  O  O  O  O  P  P  Q  Q  Q  Q  Q  Q  S  S  T  V  V  H  H  Z  Z  \  \  ^  ^  ^  ^  _  _  _  _  `  `  `  `  a  a  a  a  a  c  c  c  d  d  d  d  d  d  d  d  d  d  _  _  g  h     self    `   
petEntity    `   activeSkillID    `   validGridList    `   env   `   utilScopeSvc   `   scopeCalculator   `   results   `   
casterPos
   `   pickDirPos   `   (for generator)   :   (for state)   :   (for control)   :   _   8   gridPos   8   hitBackDirType   8   pickDirType   8   pickUpCmpt>   `   dirsB   `   (for generator)E   ^   (for state)E   ^   (for control)E   ^   dirTypeF   \   recordF   \   scope_resultO   \   target_idsO   \      _ENV j  |   '   @ K  �A@ ��@���A ��@ ��� ��A @ 䂀CA�"  @��A �� �   $À�� ���@��C@ �B�� @ ���DB� +D  �C���  *�f & � 
   _envtableshuffleipairs_Pos2IndexBoardPosPieces _CalcSkillScopeResultAndTargets        insertGetAttackRange         '   k  l  o  o  o  o  p  p  p  p  q  q  q  r  r  r  r  s  s  s  s  s  u  u  u  v  v  v  v  v  v  v  v  v  v  p  p  {  |     self    '   
petEntity    '   activeSkillID    '   validGirdList    '   env   '   results   '   (for generator)	   %   (for state)	   %   (for control)	   %   _
   #   pos
   #   posIdx   #   scope_result   #   target_ids   #      _ENV ~  �      � @ �@@_�� ��� @ ��@_�� ��� @ ��@_�� � �� @ � A�� @ �� � �  �   �  & �    HitBackDirectionTypeDownUpLeftRight                            �  �  �  �  �  �  �  �  �  �  �  �  �     self       dirType          _ENV �  �      � @ �@@_�� ��� @ ��@_�� ��� @ ��@_�� � �� @ � A�� @ �� � �  �   �  & �    HitBackDirectionTypeRightUp
RightDownLeftUp	LeftDown            �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       dirType          _ENV �  �   3   � $� B@$� L�� d� L��d� ��� �� �A�A    �� �BA  �� �  @ �ƂA ����B �B�� �����  �@ ���   @� $� F�B L���  ʃ����D ���d���CD ��D  L�Dd� ���C�& & �    	BodyAreaGetAreaGridLocationGetGridDir	PositionIsRandomSkillScopeTypeSkillScopeTypeFullScreen_utilScopeSvcGetSkillScopeCalcComputeScopeRangeSkillScopeFilterPassParamNew
casterPoscasterBodyAreaArrayworld_world_scopeFilterDevice	DoFilterGetScopeFilterParam         3   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    3   
petEntity    3   skillConfigData    3   
scopeType    3   scopeParam    3   centerType    3   targetType    3   
centerPos    3   playerBodyArea   3   
casterDir   3   
casterPos   3   scopeCalculator   3   result"   3   filterPassParam*   3      _ENV �  �   n   @ A@��  $��G�@ L�� d���A��� ́�� ��$� L�d� �B��� �  @�ǂB�B C_ � �ǂB�B CC �� ���C��CDGBDƂD �����@ �ƂD G��BE @� ���  �@ ����䂀@ �E$� L�E��  �@�� d� ��� D �C��D��@ ̄�	@ 	䄀�  ����	$� "  ��G�� ��	$� "E   �EG �G
@���$E����  ����B��B �C��@���G�H@ D@�D $��L�H� d���� �	@ ��  @ 	������& � #   _worldGetService
BuffLogic_configServiceGetSkillConfigDataGetSkillScopeTypeGetSkillScopeParamGetSkillScopeCenterTypeGetSkillTargetType(GetAutoFightSkillScopeTypeAndTargetTypeuseTypeAutoFightScopeUseTypeReplaceReplaceTargetAndTrapCount
scopeTypescopeParamcenterTypetargetTypeSkillTargetTypeBoardMonster_CalcSkillScopeResultGetSkillScopeTargetSelectorDoSelectSkillTarget       ��������GetEntityByIDHasBuffCheckCanBeMagicAttacktableremovetrapID
trapCount
TrapLogicFindTrapPosByTrapID         n   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    n   
petEntity    n   activeSkillID    n   
centerPos    n   buffLogicSvc   n   skillConfigData   n   
scopeType
   n   scopeParam   n   centerType   n   targetType   n   skillScopeAndTarget   n   result1   n   targetSelector4   n   
targetIds:   n   (for index)=   U   (for limit)=   U   (for step)=   U   i>   T   	targetID?   T   targetEntityC   T   trapID]   j   count^   j   trapSvcb   j   trapPosListe   j      _ENV   	   %7  G@ LA���d������� ���� �$� LB�d� ����� ��A� ��� 
��B CFCC G������C ��d��b  ��FCD G����D d� L�d� bC  ��GCE bC  � �G�E  @��@ �C  f FCC G������C ��d��b   �FCD G����D d� L�d� bC   �GCE b  @ �C  f G�E  @�� �G�E _��@ �C  f A� �� �    K  �  �  EF �F
 �	��F � ��$� \�
�G
�� @ ���EG ̅G
� �  ���G @ 䆀H�"  @�G�bG    �A� MG��C��  *������ ��H ����
��� F �E� 
����	��I �I
$�� LJ ��   @�dE�� ��@  �
F�I G��
d�� �EJ ��J��
 �
KAF ���E�� �E@ ��  � ����� ��H ǅ��  �
�����\ 	
��
���B EL
F�L G��
@
@�EC �C
@���C �M$��"  @��B EM
"  @ �� & EC �C
@���C ��M$��"  ����@�ED �D
F�D $� E
$� "E  @ �  & EC �C
@���C �F$��"  ���E@�ED �D
F�D $� E
$� "E  @ �  & � �  @@�F�M �Nd >�@N� ��N��N�<��N� ��N�O�;�@O����O�� ��O�� ̆O� ��� GP �P�� $��LQ� dǀ�N���@6�_@Q@ ��Q���FP ��QGP RGR����F � FGG ��R� d ������� ��O�� ̈�� ��� � �  ��   	  �  i�  ��GNJǆ�GNJ��,��R� ��N��@+� S� ��N�F *�@S���N̆S� ���LTd �  �F    ��� ���&�@T@
��   �����  @���T   @������H�G���� �  ���FG G$ �  ��G ��$��GHG�b  @��H��H    ��� �HHʃ��  j��N�Ƃ�F    ��� �����U���V  � @ �GNJ@�@V ���V�� ��V�� �NT$� LTd� _@� � "G    �� ��� W�
��FP ��PG ����  ����W� �� �$��"G  � �N
�E��X� �� �$ǀ�GX�� !� ���� ��N�GH@��GP ̇�A� 䇀�� $Ȁ�H����H�Nʈ 	��X ��N��X � ��@� Y���N�FY @ ��� �� ��Y@��N��Y @ 䆀�� � Z����O�� ��O�� ̆O� ��� NR�
Gi�  ��LEZd�  �
FED G��
��D d� L��
d� b  @�FED G��
��D d� L��
d� b  @�FED G��
��D d� L�
��d��b  � �C� f @ �C  f FED G��
��D d� L�
d� b    �� "E  @ �C  f FEC G��
����C ��d��b  @�FED G��
��D d� L�
d� bE  @ �
@ۊ
�FEC G��
����C ��d��b  @�FED G��
��D d� L�
d� bE  @ �
��
�C� f & � n   _configServiceGetSkillConfigDataGetAutoFightCondition(GetAutoFightSkillScopeTypeAndTargetTypeGetSkillScopeTypeGetSkillTagGetSkillPickTypeElementGetPrimaryTypeMVP _envTeamEntitytable
icontainsPetSkillTagRandPieceColorGameGlobal
GetModuleSkillPerfModuleIsPerfCoreGame_randPieceColor_lastConvertColor        FixedPieceColorSkillPickUpTypeNone _CalcSkillScopeResultAndTargetsGetAttackRangeipairsGetWholeGridRange_Pos2IndexBoardPosPieces       GetAutoFightPickPosPolicyPickPosPolicy	PetBonaiSelectTeamPososclock_CalcPickupPosListLogdebug*[AutoFight]_CalcPickupPosList() use time=�      
 skillID=PetYisitawanPickUpGridPosPickUpExtraParamLevelPolicyLevelPosPolicyGotoExitPos
TransportExitPosAttackpairscondsAlwaysFalsefalseAlwaysTruetrue	PlayerHPAttributesGetCurrentHP
CalcMaxHp_worldGetServiceCalcDamageGetTeamLogicHPMonsterMinHPMonsterMaxHP	GetGroupBW_WEMatchers
MonsterIDGetEntitiesAttackGridAttackTargetPowerfullRoundActiveSkillGetPowerfullRoundCountGetIDScopeGridCount
scopeType_CalcSkillScopeResultscopeParamcenterTypetargetTypeChainPathEvalueGetAutoChainPathNotTeamLeaderTeamGetTeamLeaderEntitySanHPPercentFeatureLogicscopeGridCountIsActiveSkillCanCastCalcActiveSkillSanCostGetSanValueCheckJiero_CheckCondition_PetJieroCheckLingEn_CheckCondition_PetLingEnCheckLegendEnergy_CheckCondition_LegendEnergyPetHP	callbackIsBeginPerfHasAppointSkillIsAppointSkill         7                                                                                            #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  $  $  $  %  %  (  (  (  (  (  (  )  )  -  .  /  0  1  2  3  4  4  4  4  5  5  5  5  6  7  7  7  8  :  :  :  :  :  ;  ;  ;  <  <  =  =  >  >  >  >  >  >  :  :  B  B  C  C  C  C  D  D  D  D  E  G  G  G  H  H  H  H  H  H  H  H  H  I  I  I  J  J  J  J  J  J  J  J  L  L  L  M  M  P  P  Q  Q  Q  Q  R  T  U  W  X  \  \  \  \  \  \  \  \  \  \  \  \  \  \  ]  ]  ^  ^  _  _  c  c  c  c  c  c  c  c  c  c  c  c  c  c  c  c  c  c  d  d  h  h  h  h  h  h  h  h  h  h  h  h  h  h  h  h  h  h  i  i  z  {  {  |  |  |  |  }  }  ~  ~  ~      �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  |  |  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  	  	  	  N   self    7  TT    7  caster    7  skillID    7  env    7  skillConfigData   7  
condition   7  skillScopeAndTarget   7  
scopeType
   7  
skillTags   7  pickUpType   7  	petColor   7  teamEntity   7  attackTargetCntK   7  attackGridCntL   7  gridColorCntM   7  posListN   7  	gridListO   7  tarListP   7  pickUpExtraParamQ   7  resultY   |   
targetIdsY   |   (for generator)b   r   (for state)b   r   (for control)b   r   _c   p   posc   p   posIdxf   p   
pieceTypeh   p   policyt   |   t1�   �   t2�   �   policy�   �   checkResult�   7  (for generator)�   �  (for state)�   �  (for control)�   �  k�   �  v�   �  	playerHP�     maxHP�     lsvcCalcDamage�     teamHP    
teamMaxHP    group  ,  	minblood  ,  	maxblood  ,  (for generator)  (  (for state)  (  (for control)  (  i  &  e  &  hp  &  maxhp  &  p   &  effScopeResultT  j  (for generator)Z  j  (for state)Z  j  (for control)Z  j  _[  h  pos[  h  posIdx^  h  
pieceType`  h  
chainPathw  y  
pieceTypew  y  evaluew  y  teamLeaderEntity�  �  lsvcFeature�  �  context�  �  requireSanVal�  �  requireHPPercent�  �  currentVal�  �  lsvcCalcDamage�  �  teamHP�  �  
teamMaxHP�  �  percent�  �  petHP�  �  	petMaxHP�  �     _ENV 	  :	   j   G@ LA���d������� ���� �$� LB�d� ����� ���� 
AB��B �BA � �  DC �C�� $��K  �  �    FD GE�
�  ����D �D����  � ���D �DG���D �ED@� ��� � @��D ��D@� ��� � ���D �E@���EE �
����  ��E  � @ ���E� �� ��@ �� C@ ��  � � 	\�	
A��
����D �EF@� ��� �  ��D ��F@� ��� � @��D ��F@@ ��� � �� � & �    _configServiceGetSkillConfigDataGetAutoFightCondition(GetAutoFightSkillScopeTypeAndTargetTypeGetSkillScopeTypeGetSkillTagGetSkillPickTypeGetSkillTriggerExtraParamMVP _envTeamEntity        _worldGetServiceFeatureLogicFeatureTypePersonaSkillSkillTriggerTypeExtraParamMasterSkillRecoverMasterSkillGetFeatureSkillHolderEntity_CalcPickupPosListPickUpGridPosPickUpExtraParamCardShopBanPetSkill         j   	  	  	  	  	  	  	  	  
	  
	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	  	   	   	   	   	  !	  !	  !	  "	  "	  "	  "	  #	  #	  #	  $	  $	  $	  $	  &	  &	  &	  &	  '	  '	  '	  '	  '	  '	  '	  '	  '	  )	  )	  )	  *	  *	  -	  .	  0	  1	  1	  2	  2	  2	  2	  3	  3	  3	  4	  4	  4	  4	  5	  5	  5	  6	  6	  6	  6	  7	  7	  9	  9	  :	     self    j   TT    j   caster    j   skillID    j   env    j   skillConfigData   j   
condition   j   skillScopeAndTarget   j   
scopeType
   j   
skillTags   j   pickUpType   j   triggerExtraParam   j   teamEntity   j   attackTargetCnt   j   attackGridCnt   j   gridColorCnt   j   lsvcFeature   j   posList   j   	gridList   j   tarList   j   pickUpExtraParam   j   featureType    j      _ENV @	  �	   $�   @ GA@ L����  d���A@ ��@ ����AA� �A �A� $��GB�BB  �����    K  �� ���-�����C� DC �C ��+���C� �  �*���FD LD�� �D��EE���E��EF��d������F�D���� @�+E� @� �� ��GEG�� �   F�G ��	d� ��FB  ����
�Gi�  �E�K  �  ƅG   	�@�GB ��$��G
bG  � �J�G\ M���ņ�  j���  �G @�$��LH �   d� �G�
�   ��GH  ����ǇH�G��  @��H I_ �@ �� @ �)�  �F��  ��D�D FD� ��D����FE�����E����FF���$��L�F��FdF�L����   �F�  � K� ��kG� d����K  �  ƆG   	�@�HB ��$��G
bH  � �J�G\ M���Ƈ�  j���  �G @ $@�_ ����F    �� LHB � d����H�H�  @���H ��_�@ �� @ �)�  ����   ��I J@���$G��I J@���$G�GJ �� �  �$ǀ@�  ���  �� & � *   _env_worldGetServiceUtilScopeCalcBoardLogicGetCurBoardRingMax_configServiceGetSkillConfigData_pickUpValidScopeList_Pos2Index               GetScopeTypeSkillScopeTypeScopeByPickNumGetScopeParamDataSkillPreviewScopeParamNewTargetTypetargetType
ScopeType
scopeTypeScopeCenterTypescopeCenterTypeTargetTypeParamtargetTypeParamSetScopeParamDatascopeParamBuildScopeGridList_pickUpInvalidScopeListipairs_PosIndexAddOffset_Index2PosBoardPosPieces
PieceTypeGreen       BuildScopeGridListMultiPicktableinsert _CalcSkillScopeResultAndTargets         �   A	  C	  C	  C	  C	  D	  D	  D	  D	  E	  E	  G	  G	  G	  G	  H	  I	  I	  I	  K	  L	  M	  O	  O	  O	  P	  Q	  Q	  Q	  Q	  Q	  Q	  R	  R	  S	  S	  U	  Y	  Y	  Y	  [	  [	  \	  \	  ]	  ]	  ^	  ^	  Y	  a	  a	  a	  c	  c	  c	  c	  c	  c	  e	  e	  e	  e	  f	  g	  g	  g	  g	  h	  h	  h	  h	  g	  g	  j	  k	  l	  l	  l	  l	  m	  m	  m	  n	  n	  n	  o	  p	  p	  p	  l	  l	  s	  t	  t	  t	  t	  u	  u	  u	  u	  v	  v	  v	  w	  w	  w	  x	  x	  y	  y	  y	  y	  y	  y	  z	  z	  t	  t	  	  	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  <   self    �   
petEntity    �   activeSkillID    �   
casterPos    �   env   �   utilScopeSvc   �   boardService	   �   ringMax   �   skillConfigData   �   scopeParamList   �   casterPosIndex   �   pickPosList   �   retScopeResult   �   retTargetIds   �   totalScopeParam   �   subScopeParamList"   �   	subParam%   �   validScopeParam1   �   validGirdList:   �   invalidGridList>   �   invalidGridDict?   �   (for generator)B   I   (for state)B   I   (for control)B   I   _C   G   invalidPosC   G   validPosIdxListJ   �   validPosListK   �   (for generator)N   [   (for state)N   [   (for control)N   [   _O   Y   	validPosO   Y   validPosIdxR   Y   firstPickPos\   �   (for generator)_   v   (for state)_   v   (for control)_   v   _`   t   off`   t   posIdxd   t   posj   t   colorl   t   validScopeParam�   �   validPosIdxList�   �   validPosList�   �   (for generator)�   �   (for state)�   �   (for control)�   �   _�   �   	validPos�   �   validPosIdx�   �   secondPickPos�   �   (for generator)�   �   (for state)�   �   (for control)�   �   _�   �   pos�   �   posIdx�   �   color�   �      _ENV �	  �	   @   �@ �A�A�  䁀��$� LA ��d���BA �    K  ��A � ��	���A @�� 	� �"   �B ��	$��GEBGń
b  @�G�BGń
_��
@�L�B ��   @ 
dŀ�C �E� �L��
d �E  �C �E�  @ �E����������a��@ ���  *D�����  � & �    _worldGetServiceBoardLogicGetCurBoardRingMax_Pos2Index_envipairs_PosIndexAddOffset_Index2PosBoardPosCanMoveBoardPosPieces _CalcSkillScopeResultAndTargetstableappendArrayGetAttackRange                @   �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	     self    @   
petEntity    @   activeSkillID    @   
casterPos    @   validPosIdxList    @   
pickUpNum    @   	petColor    @   boardService   @   ringMax   @   casterPosIndex	   @   env
   @   posList   @   targetIdList   @   attackPosList   @   (for generator)   ;   (for state)   ;   (for control)   ;   _   9   off   9   posIdx   9   pos   9   result(   9   
targetIds(   9      _ENV �	  �	   .   @ K  �A@  � G�@�\ GB��@ �A �FCA G���� ��@ ��@��CA ��A�  _ B� ��B  @ ��  � �  K  �  & CB � �� �$À��B�� @ �� ���C� �� �� & �    _envGetAutoChainPathTeamEntity_boardServiceLogicIsPosBlock
BlockFlagMonsterLand	LinkLine        _CalcSkillScopeResultAndTargetsGetAttackRange         .   �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	     self    .   TT    .   
petEntity    .   activeSkillID    .   env   .   attackPosList   .   
chainPath   .   
pieceType   .   evalue   .   pos   .   isBlockedSummonTrap   .   isBlockedLinkLine   .   result$   .   
targetIds$   .      _ENV �	  
   4   � @ �   �AA  �A  �A  B  AB  +A�K  ��@ �� �����@ @ 䂀A�"  ��FCA G��_@� �GM��
AJ���  *���A  �  �@ @ $� �  @ �� ���)�  �B�� @�+B� K� ��kB� ��& & �    _env        ipairs_Pos2IndexBoardPosPieces
PieceTypeGreen                4   �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	  �	   
   
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
     self    4   validPosList    4   env   4   targetIdList   4   
_pieceCnt	   4   	_pickPos
   4   (for generator)      (for state)      (for control)      _      pos      posIdx      color      maxCnt!   4   maxPos!   4   (for generator)$   +   (for state)$   +   (for control)$   +   color%   )   cnt%   )      _ENV 
  ]
   %�   �@ �A@ ́�A�  䁀B@ �@� $��LBAd� �B@ ��@� �����A ��@ 䂀CB ��$��C  �� ��$� "  @�F�B G�GDb   �C� F�B G��CLD�d� ��C ��C	��� ����� �CD	A� b  ����� �� �  � ��E	AE 䄀@�	�  �  �E @�$��L�E �   d� �F��  ���F  �����FF�F��   
��F �F_ � 	�b   �  LG� d��b  @���E ������HG� ̈�� ��@ �� @ ���  *H�"G   �!@��� ��G �H� 	�B C�G� �@ �� @ �)�  ����  @�� @�	+E� K� ��	kE� �  � 	&� �  K  �  �  &�& � !   _env_worldGetServiceUtilScopeCalcBoardLogicGetCurBoardRingMax	UtilData_configServiceGetSkillConfigData_Pos2IndexGetSkillTriggerExtraParamSkillTriggerTypeExtraParamPickPosNoCfgTrapGetSkillPickTypeSkillPickUpTypePickDiffPowerInstructionGetSkillPickParam               AttributesGetAttributeLegendPoweripairs_PosIndexAddOffset_Index2PosBoardPosPieces
PieceTypeYellowGetTrapsAtPosTrap
GetTrapIDtableinsert         �   
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  !
  !
  "
  "
  #
  #
  #
  #
  #
  $
  %
  %
  %
  &
  &
  '
  '
  '
  '
  (
  (
  )
  -
  .
  .
  0
  0
  1
  1
  2
  2
  2
  2
  6
  7
  8
  8
  8
  8
  9
  9
  9
  9
  :
  :
  :
  ;
  ;
  ;
  <
  <
  =
  =
  =
  =
  =
  =
  ?
  ?
  @
  A
  A
  A
  B
  B
  C
  C
  C
  C
  D
  D
  D
  D
  D
  D
  E
  E
  C
  C
  J
  J
  K
  K
  L
  M
  M
  M
  M
  M
  M
  M
  P
  R
  R
  8
  8
  X
  X
  Y
  Y
  Y
  Y
  Y
  Y
  Y
  Y
  Y
  Y
  [
  [
  [
  [
  [
  ]
  &   self    �   
petEntity    �   activeSkillID    �   
casterPos    �   validPosList    �   validPosIdxList    �   env   �   utilScopeSvc   �   boardService	   �   ringMax   �   udsvc   �   skillConfigData   �   casterPosIndex   �   needCheckPower   �   powerIfNoTrap   �   
tarTrapId   �   extraParam   �   	pickType'   .   pickParams-   .   legendPower/   �   attributeCmpt3   9   pickExtraParam:   �   firstPickPos;   �   (for generator)>   x   (for state)>   x   (for control)>   x   _?   v   off?   v   posIdxC   v   posI   v   colorK   v   
bPickTrapT   s   trapsW   s   (for generator)\   g   (for state)\   g   (for control)\   g   index]   e   e]   e      _ENV b
     8|  �    K  �  �    K  �C@ ��@D@ �@A����C@ �C�� DA �A ����  �A$� B$� DB$� �B$ �C  ���C@ ���A 䃀D�$� F�C � d ��� ���
� �  ����
� �E�F�D G��䅀����
� �E   
��  �	��E�
� ̅�� ��
$� F$� LF�
d� ���
�� �  �C @ $@�M���F �G�  	�����H  @��HG ��G���� J��� )�  ����  � � ��@ ��� �
i�  ��"C  @�F�G G��DH �� dD�@�� ��  f�L�Fd� ��G �H	�DH � @��D �DF�� ��F ��	  @ 	䄀�  �	�� 	�E$� F
$� K  ��C � 
� �͆�	�F G@ ��$��"G   ��F I@�
��$G���  *���
 ������F �EI��
,  �E����
 ����  �@ ���D@ ���	A 䄀  A  ��	 �� �	 �E ��F� ͆��Ɔ J	GGJ	���ǆHG �J@ ��$��L��	� d��b   �LK �  	 d� bH  ��M��
K J��J@�JH��J�J���JH�Jȇ��  J���HM ��M�  	 ����HM ��� 	 @	 䈀IM �M@	��	�$��FIM G���	��	�d���	 �	��	 �I��
 �
��	 �
��KG ��J�� ������	@ �LN ��N� L@ LA$� FLA G��@ ��A$� B$� LB$� �B$� LLFd� �� �K  ��F� kL  ���C @�$ �F�F G����� d��bM   �F�F G���� dM�@� �GM�M��JH��� �G��M��JH�)�  ���J��	���F �	I�	 
 
��I�����F �EI� 
,F  �E���I
�EG ǅ�LG�L䅀FG �JGFL��L$��FFM G�����Jd���FM ��M��J����FM ǆ�G�GGJ䆀GM �MGG��GJ$��@�� ��	 h��@�� ��	 h��FIG G���	 �	 d�����	 
�����	   ���F �	I�	  
��I�g��g��K ��� kG � �M  f�& � <           _worldGetGroupEntitiesBW_WEMatchers
MonsterID
MatchTypeMT_BlackFistPetGetOwnerTeamEntityTeamGetEnemyTeamEntityGetService	UtilDataGetExtraBoardPosListipairsHasBuffBuffComponentHasBuffEffectBuffEffectTypeNotBeSelectedAsSkillTargetHasDeadMarkAttributesGetCurrentHP	BodyAreaGetAreaGetGridPositionGetIDtableintableVector2
Pos2IndexLogdebug_className%自动主动技释放：场上没怪.自动主动技释放：必然包含目标：insertsort              xyNewIsValidPiecePos_IsPosInExtraBoardgreatestHPValEntityCountotherMonsterEntityCountindexx1x2y1y2
targetIDsmathminmaxFindEntityByPosAndTypeEnumTargetEntityMonster
icontains         �
  �
      � @ � � _� ��� @ � � `�   ��@  � � �  ���@@ �@� `�   ��@  � � �  & �    xy           �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
     a       b            �
         � @ � � _� ��� @ � � `��  ��@  � � �  ���@@ �@� _� ���@@ �@� `��  ��@  � � �  ����@ ǀ� `�   ��@  � � �  & �    greatestHPValEntityCountotherMonsterEntityCountindex            �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
                            a        b            |  c
  d
  e
  f
  h
  j
  k
  m
  m
  m
  m
  m
  m
  n
  n
  n
  n
  n
  n
  n
  o
  o
  o
  o
  o
  o
  o
  o
  o
  o
  o
  s
  s
  s
  s
  t
  t
  u
  u
  u
  u
  v
  w
  w
  w
  w
  x
  x
  x
  x
  x
  x
  x
  z
  z
  z
  z
  z
  z
  {
  {
  {
  {
  |
  |
  |
  |
  }
  }
  ~
  ~
  
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  u
  u
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
  �
    �
                        
  
  
  
  
                                                                                                    a   self    |  policyParam    |  
petEntity    |  activeSkillID    |  
casterPos    |  validPosList    |  validPosIdxList    |  pickPosList   |  atkPosList   |  
targetIds   |  extraParam   |  greatestHPVal   |  greatestHPValEntity   |  posIndexEntityIDDic   |  monsterGlobalEntityGroup   |  	utilData#   |  extraBoardPosRange%   |  (for generator)(   d   (for state)(   d   (for control)(   d   _)   b   e)   b   isSelectable*   b   hp?   b   tv2BodyAreaC   b   
v2GridPosE   b   eidG   b   hasValidBodyPosH   b   (for generator)K   \   (for state)K   \   (for control)K   \   _L   Z   v2RelativeL   Z   v2M   Z   indexX   Z   greatestHPValEntityIDr   |  greatestHPValGridPosz   |  
v2GridPos�   �   tv2BodyArea�   �   
validList�   �   (for generator)�   �   (for state)�   �   (for control)�   �   _�   �   v2Relative�   �   v2�   �   	utilData�   |  testResult�   |  resultIndex�   |  (for index)�   6  (for limit)�   6  (for step)�   6  i�   5  policyXOffset�   5  policyYOffset�   5  	gridPosX�   5  	gridPosY�   5  gridPosOffsetX�   5  gridPosOffsetY�   5  	pickPos2�   5  result�   5  minX�   5  maxX�   5  minY�   5  maxY�   5  (for index)�   0  (for limit)�   0  (for step)�   0  x�   /  (for index)�   /  (for limit)�   /  (for step)�   /  y�   .  v2�   .  tMonsterList�   .  eTeam
    (for generator)  .  (for state)  .  (for control)  .  _  ,  eid  ,  finalResult<  |  	pickPosAA  |  	pickPosBF  |  minXK  |  maxXP  |  minYU  |  maxYZ  |  (for index)]  s  (for limit)]  s  (for step)]  s  x^  r  (for index)a  r  (for limit)a  r  (for step)a  r  yb  q  v2g  q     _ENV   �   !  @ AA  �  ǁ@ ���@ 䁀�$� FBA � d ������ ��A ��������CB�� @ ��B ���� �B� �G�@ �i�  ��K  �BC ��C�� ƂC ����@��� �� �BD�� ̂D� ���� �B E@���$C�@��BC �BECC �E�E����BA F$ �  �D�$� "D   ��B E@���$D��  j��  �BC �B�GCC G��G��䂀CA L�d $ ��LDFd� bD  ��L�Fd� LD�d� @� �LGd� b   �LDGd� L��d� ��� �� �� �F�B G�� � dD�)�  ���  FH ��d@��DH  �A �� �H   �����$� �H$� F�B G�� 	� d��b   �GFC LF�d� L��d� ���  l  �� � @� ��J �F�@ ��J ��J� �F   ���B ��  @ �F��  jE�i�  ���K  �  ��B ��  L�� d �C  �  ���@���B ��  A 䃀@��� �@ � �CK ̃�� DC �K$� GL LD�d� ��L ��L	M EM
@� ������ ̄M@� ��M �N� 	䄀�	  C
� � �@�� & �	GEC LE�
� 
d���EH  �
A �� �H   ���GC �N�� $��LOd� _@�@�LGO�� �d� b   �F�B G�� ��dG��  j��ƅO ���@�� �E �  A � �
CP�E��   @ � & � B   _env        _configServiceGetSkillConfigDataGetSkillEffectipairsGetEffectTypeSkillEffectTypeSummonTrap
GetTrapIDtypetable       _world
MatchTypeMT_BlackFistPetGetOwnerTeamEntityTeamGetEnemyTeamEntityinsert	GetGroupBW_WEMatchers
MonsterIDGetEntitiesHasDeadMarkTrapTrapIDHasSummoner	SummonerGetSummonerEntityIDGetIDpairsGetPosListAroundBodyAreaGridLocationGetGridPos
icontainsGetBoardEntityBoardGetPieceEntities_boardServiceLogicIsPosBlock
BlockFlag	LinkLinerandomn_utilScopeSvcGetSkillScopeCalcGetSkillScopeTargetSelector	_utilSvcGetCloneBoardGridPosSkillScopeResultNewSkillScopeTypeNoneDoSelectSkillTargetSkillTargetTypeNearestMonsterGetEntityByIDGetService
TrapLogic	GetBlockCanSummonTrapOnPosHelperProxySortPosByCenterPosDistance                 _  a      L @ d� b@  @ �L@@ d� f  & �    HasTeamHasMonsterID           `  `  `  `  `  `  `  a     e               "  $  &  &  &  &  '  '  (  (  (  (  )  )  )  )  )  )  *  +  +  +  ,  ,  ,  ,  ,  -  .  (  (  5  6  6  6  6  6  6  6  8  8  8  8  :  :  :  :  ;  ;  ;  ;  ;  ;  =  =  =  =  =  =  >  >  >  >  >  ?  ?  ?  ?  @  @  @  @  @  >  >  G  H  H  H  H  H  H  I  I  I  I  I  J  J  J  J  J  J  J  J  J  J  J  J  J  J  K  K  K  K  K  K  K  K  M  M  M  M  M  I  I  R  S  S  S  S  U  U  U  U  V  V  V  V  X  X  X  X  Y  Y  Y  Y  Y  Y  Y  [  [  [  [  [  ]  ^  a  ]  c  c  c  c  c  c  c  c  c  c  c  d  d  d  d  d  V  V  S  S  j  l  m  m  m  m  m  m  p  p  p  q  q  q  q  q  q  r  r  r  r  w  w  w  y  y  y  z  z  z  |  |  |  |  |  |  |  |  }  }  }  }  }  }  ~  ~  ~          �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  A   self      
petEntity      activeSkillID      
casterPos      env     trapID     stpSummonTrap     skillConfigData     skillEffectArray	     (for generator)       (for state)       (for control)       _      skillEffect      targetEntityList!     teamEntity,   5   
enemyTeam0   5   monsterGroup<   L   (for generator)@   L   (for state)@   L   (for control)@   L   _A   J   monsterEntityA   J   trapEntityListM     
trapGroupS     (for generator)W   u   (for state)W   u   (for control)W   u   iX   s   eX   s   pickupPosListv     (for generator)y   �   (for state)y   �   (for control)y   �   _z   �   targetEntityz   �   posList~   �   (for generator)�   �   (for state)�   �   (for control)�   �   _�   �   trapEntity�   �   trapPos�   �   
boardCmpt�   �   es�   �   pickPosList�     
targetIDs�     scopeCalculator�     tarSelector�     posList�     skillScopeResult�     nearstTargetIDs�     	targetID�     targetEntity�     posList�     (for generator)�   �   (for state)�   �   (for control)�   �   _�   �   pickPos�   �   trapSvc�   �   (for index)  
  (for limit)  
  (for step)  
  i  	     _ENV �  �   R   G@ � �A@� ́��   A�  ����  h�
�G��� �����CA� �  @��A �A�"  ��GB LD��� d�����  @��� �D   ��C �DC	�  @ ����  +E �D�@�C DC@ � �  �@�� �D $D�g��FC G��� �  dB�F�C � d�����CD @� � �   � �  � �
���� � i�  �B�C  f & �    _configService	PetPstID	GetPstID       GetSkillConfigDataGetSkillTriggerExtraParamSkillTriggerTypeExtraParamTrapID_worldGetService
TrapLogicIsTrapCoveredtableinsertsortipairs       _CheckSkillConditionsubSkillID         �  �      �   � @A@ �����@�� �   � �GA� 䀀̀�� � ���@ G�� `@  �A  � & `�   �A  � & & �    GetSkillConfigData       GetAutoFightSkillOrder                 �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     a       b       order1      order2         svcCfgR   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    R   TT    R   e    R   subSkillList    R   env    R   svcCfg   R   
petEntity   R   	petPstID   R   sorted_skills   R   (for index)
   8   (for limit)
   8   (for step)
   8   i   7   skillId   7   skillConfigData   7   cfgExtraParam   7   trapID   ,   trapServiceLogic   ,   (for generator)@   O   (for state)@   O   (for control)@   O   _A   M   vA   M   skillIdB   M      _ENV �  �   	   � @ �@�� ����@ �A�� B �A�  � $��L�Ad� ��A �B��  ���� @�@ ��  � �� � & � 
   _utilScopeSvcGetSkillScopeCalcComputeScopeRangeSkillScopeTypeRhombus       GetAttackRangetableunion                    �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       trapPos       targetPosList       scopeCalculator      scopeResult      attackRange      targetInRange         _ENV �     n   K  �@ �A@@ �@�@����A BA$ � �
���$� "C  �	���$� B$� � @�C�$� "  @���$� �B$� L�d� b   ��C��� �   ������ �   ������ ��C��   ��� �� � ��D �CD�� ��C��  jB������ ���   ������$� GBE L��� d��b  � �C� � f�GBE L��� F CFd� b  � �C� � f�G�F L��� d��@�� �C� � �� f LG �   d� bB  � �C� � f�C  � f�& �    _world	GetGroupBW_WEMatchersTrapipairsGetEntitiesHasDeadMarkTrapID
GetTrapIDHasSummoner	SummonerGetSummonerEntityIDGetSummonerEntityHasSuperEntityGetSuperEntityGetIDtableinsert               GetGridPosition_utilScopeSvcIsPosHaveMonsterOrPetIsPosBlock
BlockFlag	LinkLine_boardServiceLogicGetPieceType_CanAttack         n   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �                                  	  	  	             self    n   
petEntity    n   trapID    n   
pieceType    n   targetPosList    n   trapEntityList   n   
trapGroup   n   (for generator)   :   (for state)   :   (for control)   :   i   8   e   8   summonEntityID   8   summonEntity    8   trapEntityA   n   trapPosC   n      _ENV   &   /   F@ � d@	��B@ ��@���� @ ��@ �A � @��B �BA ��A� ����B  ��@�DB����$� "  ��"A    �� "  ���B �B��$��_   �� �  j��i�  ���D  f & �    ipairstableuniqueHelperProxySortPosByCenterPosDistance_worldGetService
TrapLogicpairsCanSummonTrapOnPos_boardServiceLogicGetPieceType         /                                                                                           %  %  &     self    /   
casterPos    /   posListTab    /   trapID    /   
pieceType    /   (for generator)   ,   (for state)   ,   (for control)   ,   _   *   posList   *   trapSvc   *   (for generator)   *   (for state)   *   (for control)   *   _   (   pickPos   (      _ENV .  �    
    K  �@ �A@���� $ �A  ��  ��    GA LB�� d������� �  ����AB CB �� ���B��BC�  CC �C$� F�C G��@@�� $� CD$� L�Dd� L��d� �@ �C@�� ��C�@�CC E�CC �CE��E$��F�E �F� d  ��D��� �D   ��@ �D@	�� ��D�i�  ��  K  �  ƃF  ��@	���	$� G
$� LE�	d� L��
d� ��F ��
�@�͆
@ G@@ ��$G���  *����G  �	A �� �@ �E� �@ �E���G @�	�� � @ FH@ ��$F��  j����H @� � ��  �"   ��C  ��"   ��@ �D@	�   �D�� �  �� �  �@ �D�	  	@��D��@ �D�	  	@ �D��I @�� 	�  �� �   �@ E@
@ ��	$E�  @ ��& "   ��  ��"   �b  ��EI � � $� "   �@ E@
@ � $E�  @ ��& I ��� 	  $��� 
�   �@ E@
@ ��	$E�  @ ��&   G�I L��
d� ��E ��
� ��J HG�H䆀@ G@@ 
��$G���  *��@ �EJ� 
 ��E���J ��J �@ 
�E �EC �KF ���ƅF   
����K��� $� "   �@ G@@ ��$G�  @ ��& �  j���   @�� & � /   tableinsertGetID        _configServiceGetSkillConfigData(GetAutoFightSkillScopeTypeAndTargetTypeuseTypeAutoFightScopeUseTypePickPosPolicytrapID
pieceTypecanPickTrap_world
MatchTypeMT_BlackFistPetGetOwnerTeamEntityTeamGetEnemyTeamEntity	GetGroupBW_WEMatchers
MonsterIDipairsGetEntitiesHasDeadMarkpairsGridLocationGetGridPos	BodyAreaGetAreaGetPosListAroundBodyArea       appendArray       _IsNeedSummonTrap_CalcMatchPickPos_CanAttack_boardServiceLogicGetCurBoardRingMaxVector2removevHelperProxySortPosByCenterPosDistanceGetService
TrapLogicCanSummonTrapOnPos         
  /  1  2  2  2  2  2  2  5  6  7  9  9  9  9  :  :  ;  ;  ;  ;  ;  ;  ;  <  =  >  C  D  D  D  D  D  D  D  F  F  F  F  H  H  H  H  I  I  I  I  I  I  K  K  K  K  K  K  L  L  L  L  L  M  M  M  M  N  N  N  N  N  L  L  T  U  V  W  W  W  W  X  X  X  X  Y  Y  Y  Y  Z  Z  Z  Z  [  \  \  \  \  \  Z  Z  ^  ^  ^  ^  _  _  _  _  _  `  `  `  `  a  a  a  a  a  W  W  e  e  e  e  e  e  f  f  f  f  f  f  h  h  h  h  h  i  i  i  i  l  m  m  m  m  m  n  n  n  n  n  q  q  q  q  q  q  r  r  s  s  s  s  s  t  t  t  t  x  x  x  x  x  x  x  x  y  y  y  y  y  y  z  z  z  z  z  {  {  {  {  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  9   self    
  
petEntity    
  activeSkillID    
  
casterPos    
  pickPosList   
  
targetIDs   
  trapID	   
  
pieceType
   
  canPickTrap   
  skillConfigData   
  pickPosPolicyParam   
  targetEntityList   
  teamEntity'   0   
enemyTeam+   0   monsterGroup7   G   (for generator);   G   (for state);   G   (for control);   G   _<   E   monsterEntity<   E   targetPosListH   
  squareRing1PosListI   
  squareRing2PosListJ   
  (for generator)M   v   (for state)M   v   (for control)M   v   _N   t   targetEntityN   t   
targetPosR   t   	bodyAreaV   t   (for generator)Y   b   (for state)Y   b   (for control)Y   b   _Z   `   valueZ   `   workPos[   `   ring1f   t   ring2o   t   needSummon|   
  trapPos|   
  matchPieceType|   
  squareRingListTab�   
  pickPos�   
  vec2BoardMax�   
  boardRingMax�   
  (for generator)�   �   (for state)�   �   (for control)�   �   _�   �   	boardPos�   �   vec2Pos�   �   trapSvc�   
  (for generator)�     (for state)�     (for control)�     _�     pickPos�        _ENV �  �   �   �@ �A@@ �@�@����   FBA ��A� d @������ �C  @����� �CB�� "  @ � �@ ��  �i�  ���G@ L��d� ��B ��B�� �L� d� LB�d� L��d� L��d�  �"B  � �K  �  �  f K  �  �  D$� CD$� L�Dd� L��d� ���E D A 䃀E A �D $��FE �D �� d���E �� E ���C  �CA  ��@��FEA � d ��F
� @ �� @ �i�  ���B  @ ��  j���@ ���A 䃀D�$� �B  ��G@ L��� d���DA � �@�ͅ����$��"  ���F ��� $� "F  @ ���@ ���  *��LG ��   @�dĀ� 	@�K� ��kD� �D��� � f & �    _world	GetGroupBW_WEMatchers
MonsterID       ipairsGetEntitiesHasDeadMarkAttributesGetCurrentHP
MatchTypeMT_BlackFistPetGetOwnerTeamEntityTeamGetEnemyTeamEntityGridLocationGetGridPos	BodyAreaGetAreaVector2        ��������GetService	UtilDataGetExtraBoardPosListIsValidPiecePos_IsPosInExtraBoard _CalcSkillScopeResultAndTargetsGetAttackRange         �   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  *   self    �   
petEntity    �   activeSkillID    �   
casterPos    �   validPosList    �   validPosIdxList    �   group   �   minHp   �   targetEntity   �   (for generator)      (for state)      (for control)      i      e      hp      retScopeResult4   �   retTargetIds5   �   pickPos6   �   targetGridPos:   �   	bodyArea>   �   dirsP   �   (for generator)S   d   (for state)S   d   (for control)S   d   _T   b   valueT   b   workPosU   b   (for generator)X   `   (for state)X   `   (for control)X   `   _Y   ^   dirY   ^   
targetPosZ   ^   	utilDatah   �   extraBoardPosRangej   �   utilDataSvcp   �   (for generator)s   �   (for state)s   �   (for control)s   �   _t   �   dirt   �   
targetPosu   �      _ENV �  �      � � � A� $� �@$� L�� d� �A �AA�A �����AFB GB�� ��   �B ��  @���B �C��䁀B�% &  & �    GetGridPosition	BodyAreaGetAreaGetGridDirectionSkillScopeCalculatorNew_utilScopeSvcComputeScopeRangeSkillScopeTypeAroundBodyArea        SkillTargetTypeMonsterGetAttackRange            �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       entity       
ringCount       v2SelfGridPos      	bodyArea      
v2SelfDir      
scopeCalc      scopeResult         _ENV       
   �   ���@  � @ �� �  @ ��  � �   ���A@  � @��� �  @ ��  � �� � & �    _IsPosBadGrid_IsPosInExtraBoard                                                            self       pos       checkBadGrid       checkExtraBoard       utilSvc       extraBoardPosRange                    �@   �� @ �@�A�  䀀� ���@@� 䀀�   @ �� � �  �   �  & �    _worldGetService	UtilDataIsBadGridPos                                                self       pos       utilSvc              !      �@  ��� @ �@�A�  䀀��$� �  � A �@�  @� 䀀�   @ �� � �  �   �  & �    _worldGetService	UtilDataGetExtraBoardPosListtableintable                                                      !     self       pos       extraBoardPosRange       	utilData   	      _ENV &  �   $�   �  �@ �A�A�  䁀@ B@��  $��L�@d� �@ �A�� �A �B��@���� �� ��A�� �B�� �BB�� � ���  �  @ C@�� $��L�B�� dÀ�C  ���
�E�	$� �C
$� L��	d� L�
d� �  �ED  �
����
L�D � � C� ����d��b  @ ��� @ ��  jF��  @����	� �   ��E �E�  @�	�E��E �E� �@�	�E��  j���E ǃ�  �  ���  �� �F �C�@ 䃀��$� FC ��d�����
�� �  ���GFG��$��"  @ ���
@ �i�  �D��A   �A� �C ���@�̅G� ���� �  @ � ��@ �@�� ��  *���A  � ��  �    � �  �  CC$� �C$� L�D � � C� ����d��bC  @�L�Cd� L�d� �CD �����̈́�D ��	�� � @���$��"  @ � �	@ ���  *D�LH ��   @ dÀ� ��K� � kC� �CH�� ��f & � "   _worldGetService	UtilDataGetExtraBoardPosList
MatchTypeMT_BlackFistPetGetOwnerTeamEntityTeamGetEnemyTeamEntityUtilScopeCalcSelectAllMonsteripairsGridLocationGetGridPos	BodyAreaGetAreapairs_IsPosCanPickHasBosstableinsertcount        _configServiceGetSkillConfigDataGetAutoFightPickPosPolicyParamBuffComponent       HasBuffEffectAttributesGetCurrentHP _CalcSkillScopeResultAndTargetsGetAttackRange         �   '  )  )  )  )  +  +  +  +  ,  ,  .  .  .  .  .  .  .  /  /  /  /  /  /  /  /  /  /  2  3  5  5  5  5  6  6  6  7  7  7  7  8  8  8  8  9  9  9  9  :  ;  ;  ;  ;  <  =  =  =  =  =  =  =  =  =  >  >  ;  ;  C  C  D  D  D  D  E  E  E  E  E  G  G  G  G  G  7  7  K  K  K  K  K  K  L  P  P  P  P  Q  Q  T  T  T  T  V  V  W  W  X  Y  Y  Y  Y  Y  Z  Z  T  T  a  a  b  c  c  c  c  d  d  d  d  e  e  e  e  f  g  c  c  m  m  n  n  n  n  q  r  s  s  s  s  u  u  u  u  u  u  u  u  u  v  v  v  v  w  w  w  w  x  y  y  y  y  y  y  y  z  z  {  {  w  w  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  8   self    �   
petEntity    �   activeSkillID    �   
casterPos    �   validPosList    �   validPosIdxList    �   targetEntity   �   utilSvc   �   	utilData	   �   extraBoardPosRange   �   bossEntityList   �   targetEntityList   �   utilScopeSvc"   �   monsterList%   �   monsterPosList%   �   (for generator)(   V   (for state)(   V   (for control)(   V   i)   T   e)   T   gridPos-   T   	bodyArea1   T   hasCacPickPos2   T   (for generator)5   D   (for state)5   D   (for control)5   D   _6   B   value6   B   workPos7   B   skillConfigDataa   �   policyParamc   �   (for generator)f   u   (for state)f   u   (for control)f   u   ig   s   eg   s   buffCmpi   s   buffEffectl   s   maxHPx   �   (for generator){   �   (for state){   �   (for control){   �   i|   �   e|   �   hp�   �   retScopeResult�   �   retTargetIds�   �   pickPos�   �   	bodyArea�   �   (for generator)�   �   (for state)�   �   (for control)�   �   _�   �   value�   �   workPos�   �   isCanPickPos�   �      _ENV �  �   M   �@ �A@ ́�A�  䁀�$� FBA G�����@ ����  ���$� CB$� L�Bd� L��d� @�L�d� ��CC �C� $��L�C � d���  �  D @ $@�LED ��  
d� �E��  ����D  �
�����D�E��  � �_@�@ �� @ �)�  ����  @�� @�+D� K� ��kD� �  � &� �  K  �  �  &�& �    _env_worldGetServiceBoardLogicGetCurBoardRingMax
PieceTypeYellowTeamEntityTeamGetTeamLeaderEntityElementGetPrimaryTypeGetGridPosition_configServiceGetSkillConfigData_Pos2Indexipairs_PosIndexAddOffset_Index2PosBoardPosPieces         M   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    M   
petEntity    M   activeSkillID    M   
casterPos    M   validPosList    M   validPosIdxList    M   env   M   boardService   M   ringMax   M   
teamColor	   M   teamPos
   M   teamEntity   M   teamLeaderEntity      skillConfigData   M   casterPosIndex!   M   pickExtraParam"   M   firstPickPos#   M   (for generator)&   ;   (for state)&   ;   (for control)&   ;   _'   9   off'   9   posIdx+   9   pos1   9   color3   9      _ENV �  �   &   � @ �@�A�  䀀@ A@��  $��L��� d��bA  @ �C  f �� @ �C� f LAA�� d��bA  @ �C  f L�A�� d����A �B��@ �C  f C� f & � 	   _worldGetServiceUtilScopeCalcBoardLogicIsValidPiecePosGetCanConvertGridElementGetPieceType
PieceTypeRed         &   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    &   pos    &   
casterPos    &   
utilScope   &   
lsvcBoard   &      _ENV �        �@ �A�A�  䁀@ B@��  $��K  �A ���@��C   L���d���D�D�A � 	� $� "  @���EB �B
@ � 	$E��A ��	� $� "  @���EB �B
@ ��	$E� ��� �� �@ ��B�� ��B ��_����E�  A �� @�   ���C�� ��C�� �D�� �ED�� ��   �E�  ��  �D$ �E  @��� ���Ņ�����Ń���� 
�Ņ���
 ������EF ǅ�  G�
䅀�E    ��  ����EB ǅ� �@ �E���  *����@A ��  �    K  ���BB ��F��,  �B����� E�B� �EK  �  ��& �    _worldGetServiceUtilScopeCalcBoardLogicipairs        GetStandardDirection8D_PetKaLian_CanGridConvertToRed       tableinsert
MatchTypeMT_BlackFistSelectNearestMonsterOnPosPetGetOwnerTeamEntityTeamGetEnemyTeamEntityGetGridPositionindexposconvertCountconvertPosnearestMonsterCountnearestMonsterDistanceVector2	Distancesort         �        � @ � � _� ��� @ � � `��  ��@  � � �  �@@ �@� _� ���@@ �@� `�   ��@  � � �  ��@ ǀ� `�   ��@  � � �  & �    convertCountnearestMonsterDistanceindex           �  �  �  �  �  �  �  �  �  �  �                                           a       b              �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �    �    
  
  
  
  
  
  
       self       TT       
petEntity       activeSkillID       
casterPos       validPosList       validPosIdxList       
utilScope      
lsvcBoard      tInfo	      (for generator)   i   (for state)   i   (for control)   i   _   g   v2   g   convertCount   g   convertPos   g   dir   g   posForward   g   posBackward   g   
tMonsters/   g   tMonsterPos/   g   enemyTeamEntityE   N   candidateInfob   g   finalw         _ENV   k   "�   �@ �A�A�  䁀@ B@��  $��GA �B� �����  �A @�$@�A� �����̈́�LEB ��	  d� b    �M��LEB � 
  d� b    �M�� @����D� �@ ���� �B C_ �@��E�@ �� �� � @�ƅC  � �E  ���C� ��� �E�� ̅�� � @�+F� @   L��d +F  � ��� F���E ��Eˆ  ʆB�ʆ  L�Fd� L��d� �G�� �GG Ǉ��D$� @ $� L�Gd� bF    �K  �@ �H�� �FH@ �GG ��H�  �� �F    ��  � \�
G��
�
G��\�

G�\  @����FJ GG�� ǇBd��bG    �D  
G��
G�
ǆ�FK GG���� dG�)�  �����A �  K  �  �  &�K �K@��  $C���F�C �� dC K� �IkC� ��J��K  f�& � 0   _worldGetServiceUtilScopeCalcBoardLogic_configServiceGetSkillConfigDataipairs        GetStandardDirection8D_PetKaLian_CanGridConvertToRed       
MatchTypeMT_BlackFistSelectNearestMonsterOnPosYIELDPetGetOwnerTeamEntityTeamGetEnemyTeamEntityGetGridPositionGetSkillScopeCalcComputeScopeRangeSkillScopeTypeAngleFreeLinewidthThreshold	noExtend	BodyAreaGetAreaGetGridDirectionSkillTargetTypeMonsterTrapGetAttackRangeGetSkillScopeTargetSelectorDoSelectSkillTargetMonsterindexposconvertCountnearestMonsterCountnearestMonsterDistanceVector2	DistanceattackRange
targetIdstableinsertsort
targetIds         V  e      � @ � � _� ��� @ � � `��  ��@  � � �  �@@ �  �@� � �_�  �`��  �A  � & �@ G�� `@  �A  � & & �    convertCount
targetIdsindex           X  X  X  X  Y  Y  Y  Y  Y  Y  Y  \  \  ]  ]  `  `  a  a  a  a  a  d  d  d  d  d  d  d  e     a       b       countA      countB          �                                                  !  !  !  !  !  !  "  $  $  $  $  $  $  %  (  (  )  *  *  *  *  *  *  *  +  +  +  +  +  +  ,  ,  ,  ,  .  .  .  .  .  .  .  .  /  /  /  /  0  0  0  0  0  4  4  5  6  6  6  7  7  8  9  9  9  9  :  :  ;  ;  <  <  >  5  ?  ?  ?  ?  ?  B  B  B  C  C  C  C  C  C  C  C  C  C  E  F  F  G  H  I  I  J  J  J  J  J  J  J  J  J  J  J  J  K  L  N  N  N  N  N      R  R  R  S  S  S  S  S  V  V  V  e  V  g  h  h  h  j  j  j  j  j  j  j  k     self    �   TT    �   
petEntity    �   activeSkillID    �   
casterPos    �   validPosList    �   validPosIdxList    �   
utilScope   �   
lsvcBoard   �   
configSvc	   �   skillConfigData   �   tInfo   �   (for generator)   �   (for state)   �   (for control)   �   _   �   v2   �   convertCount   �   dir   �   posForward   �   posBackward   �   
tMonsters(   �   tMonsterPos(   �   enemyTeamEntityA   J   scopeCalculatorL   �   attackRangeScopeResult_   �   attackRanged   �   targetSelectorg   �   
targetIdsq   �   candidateInfo�   �   final�   �      _ENV n  v   0   �   � @ �@�  F�@ ��  ��  d��MA� �@�� @ �@�  F�@ ��  � d��MA� �@�� @ �@�  F�@ ��  �A d��MA� �@�� @ �@�  F�@ � ��  d��MA� �@�� @ �@�  F�@ �A ��  d��MA� �@��  & �    tableinsertVector2               ��������         0   o  p  p  p  p  p  p  p  p  p  q  q  q  q  q  q  q  q  q  r  r  r  r  r  r  r  r  r  s  s  s  s  s  s  s  s  s  t  t  t  t  t  t  t  t  t  u  v     self    0   pos    0   retPos   0      _ENV |  �   �     K  �@ �B@�� �B@ ǂ������� �� �A�� �BA�� ��A��   ��A�� �B �B�  � �B$� J����@ ��B@ CCC���ƂC   �����$� L��d� �D�� ƄC   	���F�FB GF�� d� ����� J���  jE��  jC��   ��� ��B   F�C ��d ���D  �����D �C @ 	$��FB GF�� d� �F��    ����	)�  �E� �� �E EE
@ ��$��"E  @ ���	 �i�  ��"C  ��"C   �\���E ��E��  ����ǃ�E DE@ ��$��"D  �� �  � ����FE G�� � dC� ��   K  � & �    _world
MatchTypeMT_BlackFistPetGetOwnerTeamEntityTeamGetEnemyTeamEntityGetGridPositionVector2
Pos2IndexGetIDGetGroupEntitiesBW_WEMatchers
MonsterIDipairs	BodyAreaGetArea        _GetReinhardtRange       tableVector2Includemathrandominsert         �   }  ~  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  /   self    �   
petEntity    �   activeSkillID    �   policyParam    �   
casterPos    �   validPosList    �   validPosIdxList    �   
pickUpNum    �   targetEntity   �   targetPosList   �   pos      	posIndex      groupEntities"   <   (for generator)%   <   (for state)%   <   (for control)%   <   i&   :   v&   :   	areaCmpt(   :   pos*   :   	areaList,   :   (for generator)/   :   (for state)/   :   (for control)/   :   i0   8   area0   8   newPos1   8   	posIndex5   8   pickPos=   �   attackPosCount@      
pickUpPosA      (for generator)D   d   (for state)D   d   (for control)D   d   iE   b   posE   b   rangeH   b   tmpAPCI   b   (for generator)L   W   (for state)L   W   (for control)L   W   iM   U   vM   U   indexQ   U   counti   x   indexn   x   poso   x      _ENV �  �      � @ �@��  G�@�@�� A �@�� �A �A � �� B @� � �@ ���@B ǀ��B $� _ � �� C  � AA �@� �& �    Logdebug'[AutoFight] _CastFeatureSkill skillID=m_nSkillID_worldGetGameTurnGameTurnTypeLocalPlayerTurn_LocalPlayerCastFeatureSkillGameStateIDPersonaSkill_GetFsmStateIDYIELDd                   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       TT       
skillData          _ENV �  U   6  � @ A���@$��L�@d� �A�� �AA ǁ��  ���A BA"  � ��A BA�BA B�  ���BB �B$� �B�C �BC�� $B �C DLBD d� _@ ��D @� �� $B� ��D @� � $B�BA �A���BE �B$�� �B�C ��E$B� >�BA �E� �BE �B$�� �B�C ��E��$B �:�BA F�@�BFGBB L��d� ����� �BE ǂ�䂀 ���FC G���  ��ǎ�ȏ�  �Ã��B ƂD  � A� �B���H   � �I DIA�	 ��I �J	��� $D  DJ��$D��J��$D��
 LKǄ@  dD LD�dD F�D �� � dD��  j�ƂD  � A �B��BE ǂ�䂀 ���FC G���  ��ˎ��ˏ�  �Ã��B @(�BA L� ��A BL"   &�GBB L���� d����CA L����BM� � A� �N �CN��@ �� A� ��  ����  @ ��CE ǃ�䃀 ���FC G���  ����ȏ�  �Ą��C ƃD  � A� �C���H   �@�EE �B
$�� �B
�C �G��  �E���EϏ� @�	+F� ���$E �D @� � $E��  j��ƃD  � A �C��CE ǃ�䃀 ���FC G���  �D����Ϗ�  �Ą��C  �BA �O� �  FP GB�d�� ��H ǂP�����P �� �@ 䃀�C   ���P �C�  @ �C���  *C���P ��Q� ��  ��� ���P ��Q��  �B��P �R���B �BE ��B��� ��BC CRG�@��P�B��BE ��B��� ��BC �R�B���D �� �B ��BA B���BE �B$�� �B�C ��Rǂ@$B & � L   _configServiceGetSkillConfigDatam_nSkillIDGetSkillPickTypeGetSkillTriggerExtraParamFeatureTypePersonaSkillSkillTriggerTypeExtraParamBanPetSkill_worldEventDispatcher	DispatchGameEventTypeWaitInputFinish       GameStateIDPreviewActiveSkill_GetFsmStateIDYIELDd       �      GameGlobalAutoFightCastPersonaSkillMasterSkillRecoverMasterSkillm_listPickUpPosGetRenderBoardEntityPickUpTarget
FakeInputuiUIWidgetFeatureMasterSkillinput
OnClickUIargs�      ipairsLogdebugpickup pos Vector2
Pos2IndexSetPickUpTargetTypeSetPickUpGridPos        SetCurActiveSkillInfoReplacePickUpTargetUIWidgetChooseTargetHandleActiveSkillConfirmCard	CardCostGetServiceFeatureLogicGetFeatureData
GetUiTypeUIWidgetFeatureCardUIWidgetFeatureCardInfoFeatureCardUiTypeSkin1UIWidgetFeatureCard_LUIWidgetFeatureCardInfo_LGetCostCardListByTypeAutoCardImgOnClickOnCastClickShopFeatureServiceHelperGetShopUIHadSeeUnlockCellListm_clientSelectInfotable
icontainsinsertcountappendArraySetShopUIHadSeeUnlockCellListCastShopSkillUIResetLastPreviewPetId FeatureAutoFightCastBanPetSkill         6  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �                                                            �  �  	  	  	  	                                                                                                             "  #  $  $    '  '  '  '  (  (  (  (  )  )  )  )  *  *  *  ,  -  .  .  .  .  )  1  1  1  1  (  (  3  3  3  3  4  4  4  4  5  5  5  7  8  9  9  4  =  >  >  >  >  @  A  A  A  B  B  B  B  C  C  C  C  C  C  C  D  D  D  D  D  B  B  H  H  H  H  H  H  I  I  I  I  I  J  J  J  J  N  N  N  N  N  N  N  N  N  P  P  P  P  P  P  P  Q  Q  Q  Q  R  R  R  R  S  S  S  S  S  S  S  S  U  $   self    6  TT    6  
skillData    6  
configSvc   6  skillConfigData   6  pickUpType   6  triggerExtraParam   6  featureType
   6  pickUpGridPosN   �   renderBoardEntityQ   �   pickUpTargetCmptS   �   (for generator)f   �   (for state)f   �   (for control)f   �   ig   �   posg   �   petIDv   �   cardCostType�   �   lsvcFeature�   �   featureData�   �   cardUiType�   �   cardUiName�   �   cardInfoUiName�   �   	costList�   �   (for generator)�   �   (for state)�   �   (for control)�   �   _�   �   	cardType�   �   newUnlockCellList�   (  shopUIHadSeeUnlockCellList�   (  (for generator)�     (for state)�     (for control)�     index�     cellID�        _ENV Z  �   $�   �     G@ LA�� d����@ �@ ����� �AA ǁ������� �� �BB ���́�� ����a��  ��A  �� �A   �
�@� �@�� & �  �C �A�GC G��G��䁀D LB�d $  �L�Dd� bC   �F�D G�� � dC�)�  ��C BE$� �E$� b   ��L�� d� b  @ � �  �L� d� b   �LB� d� L��d�  �GC L��d� ��F �G����F�D G�� �BG� ̂�� dB  GC L��� d���B��� ��  �H D  �D � �@���H	� �	$� LE�� 
d��b   �L�I � 
� C� ��� d��bE  ����I	�� �J�� �EJ   � ��
L�I � � C� ��� d��@�b  @ �  @ ��  j�b  ����A	�� ��J��    �  @ 
��J	� ����  *��b   ���D �E�� ��C���D �E�  ��C���@ �K
����@ �B  �
�@�����  � & � -   _configServiceGetSkillConfigData_castActiveSkillCount        GetSkillTriggerTypeSkillTriggerTypeLegendEnergyAttributesGetAttributeLegendPowerGetSkillTriggerParam       _world	GetGroupBW_WEMatchers
MonsterIDipairsGetEntitiesHasDeadMarktableinsertPlayerGetCurrentTeamEntityHasTeamHasPetPetGetOwnerTeamEntity
MatchTypeMT_BlackFistTeamGetEnemyTeamEntityGetService	UtilDataGetExtraBoardPosListMAX_INT_32GridLocationGetGridPosIsValidPiecePos_IsPosCanPick	BodyAreaGetAreapairsGetCurrentHPGetID                �   [  \  ^  ^  ^  ^  `  `  `  b  b  b  b  b  b  c  c  c  c  c  d  d  d  d  d  d  d  e  e  f  g  g  g  g  n  o  o  o  o  o  o  p  p  p  p  p  q  q  q  q  r  r  r  r  r  p  p  w  w  w  w  w  x  x  y  y  y  y  z  z  {  {  {  {  |  |  |  |  |                �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  %   self    �   
petEntity    �   activeSkillID    �   pickPosList   �   
targetIDs   �   skillConfigData   �   legendPower   "   canCast   "   enemyEntities#   �   monsterGroup)   �   (for generator)-   9   (for state)-   9   (for control)-   9   i.   7   e.   7   teamEntity>   �   	utilDatab   �   extraBoardPosRanged   �   minHPEntityIDe   �   minHPf   �   minHPEntityPosg   �   (for generator)j   �   (for state)j   �   (for control)j   �   _k   �   ek   �   gridLocCmptm   �   pickPoso   �   isCanPickPos{   �   	bodyArea�   �   (for generator)�   �   (for state)�   �   (for control)�   �   _�   �   value�   �   workPos�   �   hp�   �      _ENV �  �      G @ L@� ��  d����� �� �   @��   � �� ��@A�    �& � & �    _worldGetServiceFeatureLogicGetAvailableCardSkillList                          �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       lsvcFeature      
skillList           �  �      G @ L@� ��  d����� �� �   @� � �� �  @�&�  �& � & �    _worldGetServiceFeatureLogicGetAvailableShopSkill                   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       lsvcFeature      skillID      selectInfo           �  �      G @ L@� ��  d����� �� �   � � � �@ ��    �& � & �    _worldGetServiceFeatureLogic OnGetAutoFightCastBanPetSkillID                   �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       lsvcFeature      skillID           �  !   �   �@ �A� �   G�@ L��ǂ@ ���B�d����A ���� � @��B� �C  @��CB� �  @�̃B� �  ����$� "  � ��$� � �   �D�$�  � �FDC G��� � dD���  *����  �C@� LCD ��   d� �CC ��D���C ��A �������D @ 	䄀ń"  @ �� 	@ ���  *D��  ���E  � @ � �ÀDE$� � ��CC �D@ $C   F�A � d ���D  ����ǄEǄ�	�  @��E @� � ���Ā\ 
 @��@�FEC G��
� �  �@ 
�F�	� �E  dE�i�  ��\  @����FCC G��� �  dC�GF���B��   �� @ +C� @��� ���C� & � �  K  �  & & �    _envGetID_world	GetGroupBW_WEMatchersTrapipairsGetEntitiesHasDeadMarkHasSummonerGetSummonerEntityHasSuperEntityGetSuperEntitytableinsert               GetPosListAroundBodyAreashuffle_Pos2Index _CalcSkillScopeResultAndTargetsGetAttackRangeBoardPosPiecessort                            
   � @ �  � � � �`��  ��@  � � �  & �                   
                          a    
   b    
       �   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �                                            
  
  
                                                                              !  '   self    �   
petEntity    �   activeSkillID    �   
casterPos    �   validPosList    �   validPosIdxList    �   env   �   petEntityID   �   	petTraps   �   
trapGroup
   �   (for generator)   /   (for state)   /   (for control)   /   _   -   e   -   summonEntity   -   summonEntityID&   -   pickPos0   �   pickScopeRange0   �   ringNum4   T   posList8   T   (for generator)?   J   (for state)?   J   (for control)?   J   _@   H   pos@   H   posIdxC   H   scope_resultQ   T   target_idsQ   T   resultsZ   �   (for generator)]   y   (for state)]   y   (for control)]   y   _^   w   pos^   w   posIdxa   w   scope_resultj   w   target_idsj   w   
tarResult�   �      _ENV #  i   �   G@ �A� �� �� G��N�������@�A �B�A� 䂀��$� K  �  �  G�@��  � �  ��
��EB �� �
���̅�@ 䅀�  ���B C_ ���FC �C@�� $F�@�  ����FB @ ��
$��� ��� $��� �  ���B C_ ���FC �C@ � $F�@�  ��@����   �@ ���  �� � 	 �	@��� ��@ ���  �� �  A EA
�� $��FD � 	d���FD
 ����� _ �  ���i�  ���D  @�F�D G��
��  � 	d���D	L�d� ��D �EEǅ�	�Ņ
����� ƅD �E���	�
�@�    ���FFB ���	��@ǆ�	d�� �@�FFB ���	��@ǆ�	d�� �K ��	� kF � ��	  �F �  f & �    _envGetIDx       _worldGetServiceBoardLogicGetCurBoardMaxY        Vector2GetPieceType
PieceTypeNonetableinsertBattleipairsFindMonsterEntityInPosmathrandomGetCurBoardMaxXabsy         �   $  %  %  '  )  )  *  *  ,  ,  ,  ,  -  -  .  .  /  /  0  1  1  1  1  2  2  2  2  3  3  3  4  4  4  4  4  4  5  5  5  5  5  6  6  7  :  :  :  :  :  ;  ;  ;  ;  <  <  <  <  <  <  =  =  =  =  =  >  >  ?  1  C  D  D  E  E  G  I  I  I  J  J  J  K  K  M  P  R  R  R  R  S  S  S  S  T  T  T  U  U  U  V  S  S  Y  Y  Z  Z  Z  Z  Z  \  _  _  `  `  `  `  `  `  a  a  a  a  a  a  b  c  c  d  d  d  d  d  d  d  f  f  f  f  f  f  h  h  h  h  h  h  h  h  h  h  i  &   self    �   
petEntity    �   activeSkillID    �   
casterPos    �   policyParam    �   env   �   petEntityID   �   pickPos   �   pickScopeRange   �   leftPos   �   	rightPos   �   	boardSvc   �   maxY   �   	leftLine   �   
rightLine   �   
leftCount   �   rightCount   �   spPieceType   �   (for index)   D   (for limit)   D   (for step)   D   i   C   newPos   C   
pieceType   C   curLineE   �   
pickUpPosT   �   
battleSvcX   �   (for generator)[   e   (for state)[   e   (for control)[   e   i\   c   pos\   c   targetEntityList_   c   indexl   m   maxXo   �   leftEdgeLenu   �   rightEdgeLen{   �   dirPos|   �      _ENV l  �   n   �� � �A�� �@ �@� $��LBA��d҂�!������ $� B$�   ��� �K  �  �  f L�B ��   @�� ��  d�� $� �B$D  �@ ��& ���@ C��@ �CC��C$��K  ��C � ����D	� �D  ���DD	� ̄�	� �� �	 ��E �D�	 �L�E	d �  �   ��E ���	 �@ 	�D���  *D��� ������E �F��D ���̃E� � @�+D� K� ��kD� �  & ����B  � @ ���  �@ �@ ��� f & �    PetGetOwnerTeamEntity_worldGetServiceCalcDamageGetTeamLogicHP      �?
PetRender-GetPet1601751HPAboveLimitAutoCastActiveCount        ,_CalPickupPosPolicyPet1601751SummonHealTrap.TickPet1601751HPAboveLimitAutoCastActiveCountGetGroupEntitiesBW_WEMatchersTrapipairsHasDeadMarkTrapID
GetTrapIDhealTrapIDtableVector2IncludeGetGridPositioninsertremove                n   m  m  m  m  o  o  o  o  p  p  p  q  r  r  s  s  s  s  u  u  v  v  v  v  y  y  y  y  y  y  y  y  z  z  z  z  {  {  {  {  {  ~  ~  ~  ~  ~  ~    �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    n   
petEntity    n   activeSkillID    n   policyParam    n   
casterPos    n   validPosList    n   validPosIdxList    n   eTeam   n   lsvcCalcDamage   n   teamHP   n   
teamMaxHP   n   percent   n   autoActiveSkillCount   (   pickPos    (   atkPos    (   targetList    (   globalTrapGroupEntities/   m   tSelectedTrap0   m   (for generator)3   N   (for state)3   N   (for control)3   N   _4   L   e4   L   
firstTrapV   `   trapGridPosX   `   pickPosi   m   atkPosi   m   targetListi   m      _ENV �  �   1   �@ �A�A�  䁀  F�@ ��d���� �GD��� � �� ���A ��  @��C�i�  �B�\ ��� �K  �  �  f FBB G���� � d����A �C�  ������   �B� � @ +C� K  � & �    _worldGetService	UtilDataipairs GetAllTrapEntitiesAtPosByTrapIDhealTrapID        tableinsertmathrandom       remove         1   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    1   
petEntity    1   activeSkillID    1   policyParam    1   
casterPos    1   validPosList    1   validPosIdxList    1   	utilData   1   pool   1   (for generator)      (for state)      (for control)      _	      v2	      tTrapEntities      luckyPosIndex#   1   	luckyPos(   1      _ENV �  �      �  "  ���@� �  ���A@� �  � ���$� � ��@ �� �@� � �  �� BA �A$�� �A�B �BB��$B & � 
   HasPreviewPickUpComponentPreviewPickUpComponentGetAllValidPickUpGridPosClientExceptionReportCommandCreateAutoFightPickErrorReportGameGlobalEventDispatcher	DispatchGameEventTypeClientExceptionReport            �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  	   self       
errorStep       
errorType       activeSkillID       
petEntity       pickUpGridPos       pickPosList      previewPickUpComponent	      cmd         _ENV �  �   
   G @ L@� � @ ǀ����d��� A � � � @��AA� �  @ ���$B ��  *��& �    _worldGetGroupEntitiesBW_WEMatchersPetipairs
PetRender/ClearPet1601751HPAboveLimitAutoCastActiveCount            �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       globalPetRenderEntities      (for generator)	      (for state)	      (for control)	      _
      e
      cPetRender         _ENV �  �   h   �@ �A@ ́�A�  䁀B@ �@� $��LBAd� �B@ ��@� �����A ��@ 䂀CB ��$��D� �C@ ̃�� �B �B ����� � �  ���C� � ̃�� ���� ��� D�$� � ƃD  �� 	��D � ��	$� G�b  @�LE � 
d���EE��  ��ƅE ���_����E@ ̅�� �B �B � �_@@�@�
@�����@�
�ŀ�E  @ �@�
@ ��  j�b   ���  ��C� � @�+D� K  � � ��    K  � & �    _env_worldGetServiceUtilScopeCalcBoardLogicGetCurBoardRingMax	UtilData_configServiceGetSkillConfigData_Pos2Index
MatchTypeMT_BlackFistHasPetPetGetOwnerTeamEntityTeamGetEnemyTeamEntityGetGridPositionipairs_PosIndexAddOffset_Index2PosBoardPosPieces
PieceTypeRedIsPosHasMonster         h   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    h   
petEntity    h   activeSkillID    h   
casterPos    h   validPosList    h   validPosIdxList    h   env   h   utilScopeSvc   h   boardService	   h   ringMax   h   udsvc   h   skillConfigData   h   casterPosIndex   h   firstPickPos   h   blackFistEnemyPos   h   enemy*   -   (for generator)0   X   (for state)0   X   (for control)0   X   _1   V   off1   V   posIdx5   V   pos;   V   color=   V   isHasMonsterR   V   
monsterIDR   V      _ENV �  B   �   �  �@ �A�G@ G��G��䁀A LB�d $ @�L�Ad� bC  @�L�Ad� b  @�LBd� LC�d� ��� �� ��@ �� @ �)�  ����A  � �  K  �  & �B C� $��FBC G��� L�Cd� b  �����CD ǃ��@ ����� ��  �    � �E�� � DE �� �  �@ ���   $��"  @�L�Ed� ���A ������  � ���E�E	 �  �� �  � ���E��	  �  �� "  � ��FF
  �  �  b  � ��F�
 �  �@ ��  *F��  �   ��EF ǅ�  @ 	�E��   ��EF ǅ�  @�	�E�"   ��EF ǅ�  @ 
�E�b   ��EF ǅ�  @�
�E�� ��� �  K  �  & G FGA� ��$��G�  �FF ǆ�  @��F��FF ǆ�  @��F��   K  � K  �  �  f & �    _world	GetGroupBW_WEMatchersTrapipairsGetEntitiesHasDeadMarkHasSummoner	SummonerGetSummonerEntityIDGetID_configServiceGetSkillConfigDataSkillScopeTypeZhongxuForceMovementPickRange(GetAutoFightSkillScopeTypeAndTargetTypeuseTypeAutoFightScopeUseTypePickPosPolicyScopeParamGetGridPosition_CalcSkillScopeResultGetAttackRangeyxtableinsert        mathrandom                �   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �                            
  
                                                                                                   "  "  "  "  "  "  #  %  %  %  %  %  %  &      )  *  *  +  +  +  +  +  -  -  .  .  .  .  .  0  0  1  1  1  1  1  3  3  4  4  4  4  4  6  7  7  8  8  8  8  :  :  :  :  :  ;  <  =  =  =  =  =  >  >  >  >  >  ?  ?  ?  ?  A  A  A  A  B  %   self    �   
petEntity    �   activeSkillID    �   
casterPos    �   validPosList    �   validPosIdxList    �   trapEntity   �   
trapGroup   �   (for generator)       (for state)       (for control)       i      e      skillConfigData*   �   
scopeType,   �   scopeParam-   �   centerType-   �   targetType-   �   skillScopeAndTarget/   �   
centerPos>   �   firstPickPos?   �   resultH   �   attackRangeL   �   upPosM   �   downPosM   �   leftPosM   �   	rightPosM   �   (for generator)P   o   (for state)P   o   (for control)P   o   indexQ   m   	rangePosQ   m   secondPickRangep   �   secondPickRangeCount�   �   secondPosIndex�   �   secondPickPos�   �   pickPosList�   �      _ENV D  �   1  �@ �A@ ́�A�  䁀B@ �@� $��GB@ L���B d������� ��A ��@ 䂀C�L�B ��d���� ��� �  ��D�"  � ��C GD�$� �   K  �  �     �� :�DLED
d� ��D ��D��
@8�LE
d� b  @7���
�EE ̅�K �FJ�����FJ����GJ�����GJ���䅀���H$F�F��� ���F� �� $� LF�ǆ� � d� �  ��H  ��� ��B ��$���I�  jG��    F�H � d@���B  	����ǈ�H  � ��I� ��
G�i�  ���D� �    LHI ��  	�@	��	�	d�  �"   �@ � �� F�I G����	��dH���LJ ��  	�@	��	�	�	 d�� �"   �@ � �  F�I G����	��dH�� �K  �  �  f b   ��G    ���C  �H
 �� ���
IE �E�	 �	F�ɉ�ǉF�ɉ��	G�ɉ�ǉG�ɉ�$��L�G�	HdI�bH  ���� �@ �C� @��  ��G�J L	��	  
 @
� d���I��� �	  
  F�H �
 d
@���B  ����ǋ�K  � ��	I� ��
J�i�  ���D
  �JI  � @ ����	��   "   �@
 � �� ��I ��I�
�	 ��J�@��
J  � @ ����	  ���  "   �@
 � �  ��I ��I�
�	 ��J�@���K  � @ ���  �	���  "  ��@
 � �  ��I ��I�
�	 ��J�C� ���  � �\�	 @��  � �	  @�� 	& & � /   _env_worldGetServiceUtilScopeCalc	UtilDataBoardLogicGetCurBoardRingMax_configServiceGetSkillConfigData_pickUpValidScopeList_Pos2Indexk�    GetAutoFightPickPosPolicyParamcheckDamageSkillID	tonumber               GetScopeTypeSkillScopeTypeScopeByPickNumGetScopeParamDataSkillPreviewScopeParamNewTargetTypetargetType
ScopeType
scopeTypeScopeCenterTypescopeCenterTypeTargetTypeParamtargetTypeParamSetScopeParamDatascopeParamBuildScopeGridList_pickUpInvalidScopeListipairs!_YeliyaFindValidPosWithSuperGridtableinsert&_YeliyaFindValidPosWithMaxTargetCount              _utilScopeSvcCalcSKillPreviewScopeResultGetAttackRange!_YeliyaFindValidPosNearToMonster           E  G  G  G  G  I  I  I  I  J  J  J  J  K  K  M  M  M  M  N  O  O  O  P  Q  Q  R  R  S  S  S  T  T  T  T  X  Y  Z  \  ^  ^  ^  _  `  `  `  `  `  `  a  a  b  b  d  h  h  h  j  j  k  k  l  l  m  m  h  p  p  p  r  r  r  r  r  r  t  t  t  t  u  v  v  v  v  w  w  w  w  v  v  y  z  {  {  {  {  |  |  |  }  }  }  ~        {  {  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  ;   self      
petEntity      activeSkillID      
casterPos      validPosList      validPosIdxList      env     utilScopeSvc     utilDataSvc	     boardService     ringMax     skillConfigData     scopeParamList     casterPosIndex     checkDamageSkillID     policyParam     pickPosList$     retScopeResult%     retTargetIds&     tmpPickList'     totalScopeParam+     subScopeParamList3     	subParam6     validScopeParamB     validGirdListK     invalidGridListO     invalidGridDictP     (for generator)S   Z   (for state)S   Z   (for control)S   Z   _T   X   invalidPosT   X   validPosIdxList[     validPosList\     (for generator)_   l   (for state)_   l   (for control)_   l   _`   j   	validPos`   j   validPosIdxc   j   firstPickPosm     lastPickPosm     lastPickSuperGridn     testPickPoso     subPickFinish�     maxFindTimes�     findNextTimes�     validScopeParam�     subScopeResult�     validGirdList�     validPosIdxList�     validPosList�     (for generator)�   �   (for state)�   �   (for control)�   �   _�   �   	validPos�   �   validPosIdx�   �   nextPickPos�        _ENV �     2   �@ �A@�  �����@ ��@ 䁀B L��d� b  ������  � ��B �����   �  �    D  �  �CB @� ����  @ 䃀@�b  @�ƃB ���  @��C�� ��    K  � �  �@ � & �    _worldGetServiceBoardLogic_configServiceGetSkillConfigDatak�    GetAutoFightPickPosPolicyParamcheckDamageSkillID	tonumber&_YeliyaFindValidPosWithMaxTargetCounttableinsert         2   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �                                         self    2   
petEntity    2   activeSkillID    2   
casterPos    2   validPosList    2   validPosIdxList    2   boardService   2   skillConfigData   2   checkDamageSkillID	   2   policyParam   2   pickPosList   2   retScopeResult   2   retTargetIds   2   testPickPos   2   tmpPickList   2      _ENV   $   ;   D  �@ �A@ ��$� L�@ � d���A � ��
��CA @�� � ă"  ���A ��$��F�A G�� � d��bD  @�LD�� �B �B
d� bD  ���C  ����  @��A   	���F�$� �C$� "  @ �@ @ ��  jE���  *��f & �    	_utilSvc_boardServiceLogicGetCurBoardRingMax_Pos2Indexipairs_PosIndexAddOffset_Index2Postable
icontainsIsPosBlock
BlockFlag	LinkLineGetTrapsAtPosTrapIsSuperGrid         ;     
                                                                                                                #  $     self    ;   
petEntity    ;   
centerPos    ;   validPosIdxList    ;   alreadyPickList    ;   pickPos   ;   utilDataSvc   ;   boardService   ;   ringMax   ;   centerPosIndex   ;   (for generator)   9   (for state)   9   (for control)   9   _   7   off   7   posIdx   7   pos   7   isBlockedLinkLine"   7   traps'   7   (for generator),   7   (for state),   7   (for control),   7   index-   5   e-   5      _ENV %  F   9   �  A  �A@ ��$� L�@ � d��� �  CA @ $��L�A ��  d� �D��   ���A  �����B �D�	  @ 	䄀�D  ��̄�@ 	��B �C� �D  ��EC �� ��  	$ŀb   ���
 �@ �� � 	)�  �C��    ���� & �    k�    _boardServiceLogicGetCurBoardRingMax_Pos2Index        ipairs_PosIndexAddOffset_Index2Postable
icontainsIsPosBlock
BlockFlag	LinkLine _CalcSkillScopeResultAndTargets         9   &  (  *  +  +  ,  ,  ,  -  .  /  /  /  /  0  0  0  0  1  1  1  2  2  2  3  3  3  3  3  3  3  4  4  4  4  4  5  5  6  6  6  6  6  7  7  8  9  9  :  ;  /  /  B  B  C  E  F     self    9   
petEntity    9   
centerPos    9   validPosIdxList    9   alreadyPickList    9   checkDamageSkillID    9   pickPos   9   boardService   9   ringMax   9   centerPosIndex   9   maxTargetCount	   9   maxTargetPos
   9   (for generator)   4   (for state)   4   (for control)   4   _   2   off   2   posIdx   2   pos   2   isBlockedLinkLine$   2   result+   2   
targetIds+   2   targetCount.   2      _ENV G  x   z   �  �@ �A�A�  䁀�@ G@ L��@ �B�ǂ�d���  �@ ���� �A B �@��B� � ̂�� ���� ��� CC �C@ ��$C�����C �$ �  �D�$� "D   �DC �C@ ��$D��  j��  ���  �� ��  �C @ $@�L�Dd� �E�� �DE	�� ��C   	�@�ƅFFC G����� dF��  j��)�  ����E �E� ��$� "   �\  @�@�GF��E ��E �@ �� �  @���C   ���EC EF
@���	$��"E   ��F��	��F ��$� "E  @ ���	@ ��  jD�� & �    _worldGetService
BuffLogic_boardServiceLogic	GetGroupBW_WEMatchers
MonsterID
MatchTypeMT_BlackFistPetGetOwnerTeamEntityTeamGetEnemyTeamEntitytableinsertipairsGetEntitiesHasDeadMark        GetGridPosition	BodyAreaGetAreaHelperProxySortPosByCenterPosDistance       
icontainsIsPosBlock
BlockFlag	LinkLine         z   H  K  K  K  K  M  N  N  N  N  N  N  O  P  P  P  P  P  P  P  Q  Q  Q  Q  Q  Q  Q  Q  R  R  R  R  R  R  T  T  T  T  T  U  U  U  U  V  V  V  V  V  T  T  Z  Z  Z  Z  Z  \  ]  ]  ]  ]  ^  ^  _  _  _  _  `  `  `  `  b  c  c  c  c  c  `  `  ]  ]  f  f  f  f  f  g  g  g  g  g  h  i  i  i  i  i  j  j  k  k  k  k  l  l  l  l  l  l  l  m  m  m  m  m  n  n  o  o  k  k  w  x  (   self    z   
petEntity    z   
centerPos    z   validPosIdxList    z   validPosList    z   alreadyPickList    z   pickPos   z   buffLogicSvc   z   boardService   z   monsterGroup   z   validEnemyList   z   
enemyTeam   !   (for generator)&   2   (for state)&   2   (for control)&   2   _'   0   monsterEntity'   0   enemyPosList8   x   (for generator);   P   (for state);   P   (for control);   P   index<   N   enemyEntity<   N   	enemyPos>   N   tv2BodyAreaB   N   (for generator)E   N   (for state)E   N   (for control)E   N   _F   L   v2RelativeF   L   v2G   L   sortedEnemyPosListU   x   nearestPos[   x   sortedValidPosList`   x   (for generator)e   x   (for state)e   x   (for control)e   x   indexf   v   posf   v   isBlockedLinkLiner   v      _ENV {  �   E   �   �   @ A@�@ ��@��@$��FA �AA� d  ������ ̂A� �  ����A� �  � �� � �  @ �i�  ���@  @ �C  f L�d� �A ƁB ���䁀 ��FBC G����� �A����C  �A���C� �A��AD ǁ�� @��A��E �A��E $� _ � ���E  � A �A� ��� � & �    _world	GetGroupBW_WEMatchersUnscaledCountDownRenderipairsGetEntitiesGetIsActiveGetIsWaitTrigger
GetFlagID       GameGlobalEventDispatcher	DispatchGameEventType"SyncClientUnscaledCountDownFinishSetIsWaitTriggerSetWaitPlayNotifyLoginfo/autoFight UnscaledCD _CountDownFinish, flagID:GameStateIDUnscaledCountDownFinishNotify_GetFsmStateIDYIELDd                E   |  }  ~  ~  ~  ~  ~  ~            �  �  �  �  �  �  �  �  �  �  �  �  �      �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    E   TT    E   isWaitTrigger   E   waitTriggerCmpt   E   group   E   (for generator)      (for state)      (for control)      i      e      cmpt      flagID"   E   state#   E      _ENV=                             	      	                        %      '   4   '   6   8   6   :   <   :   >   @   >   B   D   B   E   G   E   J   X   J   \   �   \   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �     �           a    j    j        "  K  "  P  �  P  �  �  �  �  �  �  �  �  �  �    �    d    g  �  g  �  '  �  (  =  (  >  W  >  X  r  X  s  |  s  }  �  }  �  �  �  �    �           M     P  b  P  e  w  e  z  �  z  �  �  �  �  �  �  �  �    �    :    >  h  >  j  |  j  ~  �  ~  �  �  �  �  �  �  �  �  �    	    	  :	  	  @	  �	  @	  �	  �	  �	  �	  �	  �	  �	  
  �	  
  ]
  
  b
    b
    �    �  �  �  �  �  �  �    �    &    .  �  .  �  �  �  �  �  �                  !    &  �  &  �  �  �  �  �  �  �    �    k    n  v  n  |  �  |  �  �  �  �  U  �  Z  �  Z  �  �  �  �  �  �  �  �  �  �  !  �  #  i  #  l  �  l  �  �  �  �  �  �  �  �  �  �  �  �  �  B  �  D  �  D  �    �    $    %  F  %  G  x  G  {  �  {  �     GetTwoSideOffset�   =     _ENV