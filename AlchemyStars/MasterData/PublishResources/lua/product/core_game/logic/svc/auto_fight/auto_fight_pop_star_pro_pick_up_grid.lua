LuaS �

xV           (w@i@../PublishResources/lua/product/core_game/logic/svc/auto_fight/auto_fight_pop_star_pro_pick_up_grid.lua             @ A@  $@ �@ l   
@���@ l@  
@ ��@ l�  
@���@ l�  
@ ��@ l  
@���@ l@ 
@ �& � 	   requireauto_fight_serviceAutoFightService_AutoPopGrid_GetAutoPickUpData_CalcPosPickUpValue_GetConnectPieces_GetCanPickUpPosList_CalcChainAttackVal           D    �   �   � @ �@�� ̀�� �@ AF�@ GA�A � @�ƀA ��� F�@ G���@ �AAG���A �@ � @ �@�� ̀�� � �� @ �@�� ̀�F�@ G���@ �AAG���@�
 Å
�Æ�   
���� D A�L�D ��   d� ��D ��� �  ���AE ́�� F$� ���B���$B���� $B��F��$B�& � ��D ��AB 䁀����$��G�D L��d� ��  �B���D �BH�D �H�G�����D ���G�D G��G��� �B �I  � AC	 �B���@ �B���D �B�G�D G��G��䂀�D �H��D ��H��G��$C I @� �C	 $C��   @��A �AA�	 $C @ C@$� �B� $C��D �I$� LJd� �CJ ��J�� �FI �� ��
 dC� �& � ,   HelperProxyGetInstanceGetGameTimeScaleBattleConstTimeSpeedListSpeed2IndexLogfatalAutoFight SetTimeSpeed  SetGameTimeScale_lastConvertColor        _randPieceColor _lastCastSkillPetIds_envTeamEntity_GetAutoPickUpData_worldRunAtServerPopStarPickUpCommandNew	EntityIDGetIDSetCmdPickUpPosSetCmdConnectPiecesReceiveCommandGetServiceBoardRenderGridPos2RenderPosPopStarPickUpSetPopStarClickPosGetUniqueComponentBW_UniqueComponentsEnumSetUniqueComponentYIELD�       AutoFight ResumeSpeedGameFSMCurStateIDGameStateID
WaitInputd                �      
   
   
   
   
   
   
   
   
   
   
   
                                                                                                                                                                     !   !   !   "   '   '   '   '   (   (   (   +   +   +   .   .   .   /   /   /   /   /   /   0   0   0   0   0   0   0   1   1   1   1   4   4   4   5   5   5   5   5   5   6   6   6   6   6   6   6   7   7   7   7   9   9   :   :   :   :   ;   ;   ;   ;   ;   ;   @   @   @   A   A   A   A   A   A   B   B   B   B   B   D      self    �   TT    �   	tmpSpeed   �   env,   �   teamEntity-   �   pickUpGrid1   �   connectPieces1   �   cmd9   F   
boardSvcRJ   �   
renderPosM   �   popStarPickUpCmptP   �   
componentY   �   
componentm   �   gameFsmCmpt�   �      _ENV G   \    '   � @ �   � ��@@ �@  � �̀@ @ �@�� @ �@ G�$��"   �GB�G��A  ��B�)�  �����"  ����BLAB �����d�&  ��LAB ǁ�d�&  & �    _envPickUp_autoMoving_BuildPopStarProPickUpEnvpairsBoardPosCanPick
Index2Pos_CalcPosPickUpValueMvp       _GetConnectPieces
PlayerPos         '   I   I   I   I   I   I   J   J   J   M   P   P   P   P   Q   Q   R   R   S   S   S   P   P   W   W   W   X   X   X   X   X   X   X   [   [   [   [   [   \   
   self    '   TT    '   teamEntity    '   env
   '   (for generator)      (for state)      (for control)      key      value      pos         _ENV ^   ~    J   � @ A  ���̀@@� 䀀�@ �� $��K� �� kA� �ABA �A@� � ����   ���A �B��  �A��AB �@� �����B@���� C �� �� �$��AB ��C  � ����BA ���ǂ��  � �D CDO�CGCA G��b  ��GCA G��G��  � �GCA � ��   �C J��@�GCA � ��   �C J��& �    GetService	UtilDataGetPieceType_GetConnectPiecesCanCastChainSkill_envPickUpTeamEntitytableappendArray_world	UtilCalcGetChainDamageRateAtIndex_CalcChainAttackVal        _Pos2IndexMonsterAttackPosPopStarConstMonsterAttackParamMvp                J   `   `   `   a   a   a   c   c   c   f   f   f   g   g   g   g   g   g   g   g   h   h   h   h   h   k   k   k   k   l   l   l   l   n   n   n   n   n   p   q   q   q   r   r   r   s   s   t   t   t   v   w   w   w   w   x   x   x   x   x   y   y   y   y   y   y   z   |   |   |   |   |   |   ~      self    J   pos    J   utilDataSvc   J   
pieceType   J   connectPieces	   J   
chainPath   J   utilCalcSvc   J   
chainRate!   J   chainAttackVal&   J   monsterVal'   J   	posIndex*   J   beAttackCnt-   J   posVal3   J      _ENV �   �    	   � @ �@@�  �����@@� � ��   & �    _worldGetServicePopStarProLogicCalculatePopStarConnectPieces        	   �   �   �   �   �   �   �   �   �      self    	   gridPos    	   popStarLSvc   	        �   �    8   � @ �@@�  �����@� @ A@� $��K  �A ��B �A	���A  � @��� �  ���  ��� ��B   ���DB��ƄB ���	$� "D  ��C���DC Ǆ�	$� "D   ��C D@���$D��  j���� ���  �f ��f & �    _worldGetServiceBoardLogicGetCurBoardMaxLen	UtilData       GetPosListAroundBodyArea        ipairsIsHaveEntityEnumTargetEntityPetIsPosBlock
BlockFlag	LinkLinetableinsert         8   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    8   monsterEntity    8   boardService   8   ringMax   8   utilDataSvc
   8   resPosList   8   (for index)   6   (for limit)   6   (for step)   6   ringNum   5   squareRingPosList   5   (for generator)   1   (for state)   1   (for control)   1   _   /   pos   /      _ENV �   �    '�   @ A@� _�@� �\ ��@ �A�  f FA GA�d�� ��A ��A ��AB 䁀�A �B$� G�A L��� d����A �B ����BC� �  � �̂C@ 䂀� ���A ��A� 䂀�  FD � d���D�̄D	� ���	A 䄀�LE�� 	� d� ��E	�� ��@ 	� 
��
䅀 �����FF��$��L���   	d�  �L�Fd� ��  @� � 	����FG@ 	���  �� �  FD ��d ���A ��G 	�����  ����G� �  ����@	 	�	 � �    �GHi�  ��A�  ����  @�����  � ��I GGI������  � ��I GGI �����  @ ��I G�I���i�  �C�FA GC�d�� ��I �J�C
 �J �J@� $� A �D��DK	�C�& & � .   _envPickUpPieceTypeOutPets         osclock_configService_worldGetServiceUtilScopeCalcGetSkillScopeTargetSelector
BuffLogicAffixHasAddChainPathNumProcessAddChainPathNum	UtilDataipairs
petEntityAttributesGetAttributeChainSkillReleaseFixGetEntityBuffValue(ChangeExtraChainSkillReleaseFixForSkill
SkillInfoGetChainSkillByChainCountGetSkillConfigDataProcessChianSkillConfigGetSkillTargetTypeCalcSkillScopeDoSelectSkillTargetGetEntityByIDHasBuffCheckCanBeMagicAttack       	priMatch	secMatchPopStarConstPrimaryParamSecondaryParamLogdebug)[AutoFight] _CalcChainAttackCount() pos=Vector2
Pos2Index use time=�               �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   %   self    �   	skillPos    �   chainCount    �   
pieceType    �   outPetEntities   �   t1   �   
configSvc   �   utilScopeSvc   �   targetSelector   �   buffLogicSvc   �   affixService   �   	utilData)   �   chainAttackVal*   �   (for generator)-   �   (for state)-   �   (for control)-   �   _.   �   value.   �   e/   �   chainCountFix4   �   finalChainCount5   �   chainExtraFix9   �   skillInfoCmpt;   �   chainSkillID@   �   skillConfigDataE   �   skillTargetTypeL   �   scopeResultQ   �   targetEntityIDArrayW   �   hitCntX   �   (for generator)[   o   (for state)[   o   (for control)[   o   _\   m   	targetID\   m   targetEntity`   m   petValp   �   t2�   �      _ENV               D      G   \   G   ^   ~   ^   �   �   �   �   �   �   �   �   �   �          _ENV