LuaS �

xV           (w@`@../PublishResources/lua/product/core_game/view/svc/preview/skill_preview_effect_calc_svc_r.lua         F    @ A@  ��@ $@�@@  ��@@ l   
@��@@ l@  
@ �@@ l�  
@��@@ l�  
@ �@@ l  
@��@@ l@ 
@ �@@ l� 
@��@@ l� 
@ �@@ l  
@��@@ l@ 
@ �@@ l� 
@��@@ l� 
@ �@@ l  
@��@@ l@ 
@ �@@ l� 
@��@@ l� 
@ �@@ l  
@��@@ l@ 
@ �@@ l� 
@��@@ l� 
@ �@@ l  
@��& �    _classSkillPreviewEffectCalcServiceObjectConstructorInitialize_CreateSkillEffectCalcParamCreateSkillEffectParamCalcConvertGridElementCalcHitBackCalcMultiTractionCalcSerialKillerCalcForceMovement#CalcTargetFourDirForceMovementStepCalcTargetForceMovementStepCalcTransportByRange_GetNextPosGetNextPosGridGetNextPosCalcPickUpGridTogetherFindCanTogetherGridFindPickIndex
BuildDataIsPreviewGridElementMatchGetPreviewGridType                  
@ ���@ ��@�� 
���& �    _world_skillEffectParamParserSkillEffectParamParserNew               
   
   
   
         self       world          _ENV           G@@ L�� ��  d��
@ �G@@ L�� �@ d��
@ �& �    _configService_worldGetServiceConfig_utilDataService	UtilData                                               self                   
   F@ LA���   @���  � d��f & �    SkillEffectCalcParamNew                 
                                    self    
   	casterID    
   targetIDArray    
   effectParam    
   range    
   
calcParam   
      _ENV            � @ �@�@� � � �  & �    _skillEffectParamParserParseSkillEffectParam                                    self       effectType       effectParam       param           #   l    �    �L@d� �A@�� �    L�@d� b  � ���  � ��L�@d� b  ���� D  �� �� �  @��B� �� ��A�� @  ���� �� �    �@� ����   �  ��"  @�LBBd� _��@�LBBd� L��d� _����LBBd� L��d� ���  �C  ����_� �DC �C@ ��$D��  j��@ L�Cd� �D�� �    AC ��D ��D�� �E�� �    FDE � d ���E �
F�E G��� �    ��  �  @��EC ǅ�  @�
�E� ��EC ǅ� �@�
�E�i�  ��FC ��d@��EF  �
@��� �  ����ͅ��F G�
�F�
$����M��!@�@ �� @ �i�  ���F�G L����  @ d��f & �     GetSourceGridElementGetTargetGridElementIsConvertToCasterElementIsConvertToTeamLeaderElementHasPetPetGetOwnerTeamEntityHasTeamGetTeamLeaderPetEntityElement GetPrimaryTypeipairstableinsertGetTargetGridElementCountIsIgnoreBlock        _worldGetPreviewEntityPreviewEnvpairsIsPosBlock
BlockFlagChangeElementIsPreviewGridElementMatch       Vector2xy$SkillConvertGridElementEffectResultNew         �   %   &   &   '   '   )   *   +   +   +   +   ,   -   -   .   .   .   .   /   0   1   1   1   1   3   3   3   3   3   3   4   4   4   4   5   7   7   7   9   9   :   :   ;   ;   ;   ;   ;   ;   ;   ;   ;   ;   <   <   <   <   =   >   ?   ?   ?   ?   @   @   A   A   A   A   A   ?   ?   D   H   H   I   I   J   L   M   O   O   O   O   O   Q   R   S   S   S   S   T   T   T   T   T   U   U   V   X   X   Y   Y   Y   Y   Y   Y   [   [   [   [   [   S   S   ^   ^   ^   ^   _   _   _   _   `   `   a   a   a   a   a   a   a   b   c   c   d   d   ^   ^   j   j   j   j   j   j   k   l   &   self    �   casterEntity    �   scopeGridList    �   param    �   skillConvertEffectParam   �   sourceArray   �   targetElementType   �   useEntityElement   �   elementEntity   �   teamEntity   &   tarElement8   H   
newSource:   H   (for generator)=   G   (for state)=   G   (for control)=   G   _>   E   elementType>   E   targetMaxCountJ   �   ignoreBlockL   �   targetGridDicM   �   hasEnoughTargetN   �   currentTargetCountO   �   envT   �   skillRangePosListU   �   blockedPiecesV   �   (for generator)Y   q   (for state)Y   q   (for control)Y   q   kZ   o   vZ   o   cantConverPos_   o   (for generator)t   �   (for state)t   �   (for control)t   �   _u   �   gridPosu   �   isMatchy   �   skillConvertEffectResult�   �      _ENV q      .=  �@�� �A@� �@$� L�@d� ���� bB  � ��B�� @�̂�� ��$� L�d� �C��� ̃�� ��$� "   �FC � d� �� �DC	� �   ���	$� _@
  �& � G�C L���d��bD  @ ��  � �D��� �   ������ ��D ��	EE	$� _ �	  �& � ����� ���� �C F
$� EF
$� L�F
��d��b  ��F�F L�
��  	@ 	e�f  G�C LE�
�� d���  ��G ����@��EH ǅ� �� ������G ���������
@�� ��   �����E�
@�� � 	  @�	䅀��_�I� ���I ������  ���EJ ǅ���@���I ������K �E�� �E ��F ��@�� 	� 	���  ��K ����  �� �  �  ��FL$� "  ���  @�A� � �� h�\�M�����ʅ�gF��L	$� LF�	d� �� ��� ������L�G���	���F��M �FM̆�� �  @����� ��� GN �N�@ �M ��N��C ��� �F�� �C GG� $��A� � �� h��M��  �� 	�A� �
�ǉ��ɉJO �O@
��
�$��"J  ���O�
�$��"J  @ ��� @�
��
��
 $� "J  ��JP�
��
  �$��"
  @ ��� ����L�P�
  �@ d��b
  @ ���   ��H���P@	��	�� �  @ ��� � ��H  @ � �g��L��d� b  @���D �E�G�� ������Q@ �HQ ��Q�HQ ������ �    �  _����� �LH�d� L��d �G  ��� �@ �G ��F �G �@ 	� �   	�@	 �� � & � L   GetCasterPosGetCasterDirGetCasterBodyAreaGetHitBackDirTypeGetIgnorePlayerBlockGetDirTypeGetTypeGetDistanceGetCalcTypeExcludeCasterPosGetBackupDirectionPlanGetEnableByPickNum	tonumberPreviewPickUpComponentGetAllValidPickUpGridPosCount_worldGetEntityByID
HasTrapIDTrapRender	TrapTypeBombByHitBackGetTrapTypeGetGridPosition	BodyAreaGetPreviewEntityPreviewEnvIsImmuneHitbackSkillHitBackEffectResultNewGetService	UtilCalcHitBackDirectionTypeCrossGameHelperComputeLogicDirSelectCanUseDir_CalCanUseHitBackDir_CalcHitBackDir Vector2zeroHitBackDirectionBackupPlan	AlwaysUpupLogfatal"击退方向计算结果错误！HitBackType	PullBackGetArea       Clone
BlockFlagHitBackHasMonsterID
MonsterIDGetMonsterRaceTypeMonsterRaceTypeFlyHitBackFly	UtilDatatable
icontainsIsValidPiecePosIsPosBlockIsPosBlockWithEntityRaceCalcHitbackForTrapWallBlock)CalcHitbackForTrapWallBlockMultiBodyAreaIsHaveEntityEnumTargetEntityPetMonsterDelEntityBlockFlagGridLocationGetGridPosAddEntityBlockFlag         =  r   r   s   s   t   t   u   u   v   v   w   w   x   x   x   {   {   |   |   }   }   ~   ~         �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �     �                       	  
  
  
  
  
  
  
  
  
  
                                                    =   self    =  casterEntity    =  scopeGridList    =  	targetID    =  skillPreviewContext    =  param    =  attackerPos   =  attackerDir   =  attackerBodyArea   =  hitBackDirType   =  ignorePlayerBlock
   =  type   =  hitBackDistance   =  	calcType   =  excludeCasterPos   =  backupDirectionPlan   =  enableByPickNum   =  	checkNum    *   	attacker!   *   
component#   *   curPickNum'   *   	defender.   =  trapRenderCmpt8   ?   defenderPosA   =  defenderBodyAreaC   =  envH   =  utilCalcSvcX   =  dirY   =  excludePosList�   =  casterBodyArea�   �   (for index)�   �   (for limit)�   �   (for step)�   �   i�   �   
targetPos�   =  	bodyArea�   =  (for index)�   �   (for limit)�   �   (for step)�   �   i�   �   useCheckBlockFlag�   =  	raceType�   �   env�   =  	utilData�   =  (for index)�     (for limit)�     (for step)�     i�     tempPos�     
needBreak�     (for index)�     (for limit)�     (for step)�     i�     tempBodyPos�     checkTrapWallPosStart�     trapWallBlock�     trapWallBlock    trapRenderCmpt  =  posNext  %  hitbackResult;  =     _ENV   1   &   L@d� �A� �� �  � �́@� G��"  � ��A� @��AAF�A G��䁀B �B� �� �   �@�$� L�B��dB�� ÅFBC L����C d����  ���� & �    GetCasterPosPreviewPickUpComponentGetAllValidPickUpGridPos       GetScopeCenterPosListGetScopeResultSkillEffectTypeMultiTraction_CreateSkillEffectCalcParamGetIDSetGridPos_finalDamageIncreateRate SkillEffectCalc_MultiTractionNew_worldDoSkillEffectCalculator         &                      "  "  #  #  #  &  &  &  &  (  (  (  (  (  (  (  )  )  )  +  .  .  .  .  /  /  /  0  1     self    &   casterEntity    &   skillPreviewContext    &   param    &   transContextCenter    &   
centerPos   &   previewPickUpComponent   &   pickUpGridArray   	   scopeResult   &   
calcParam   &   skillEffectCalc!   &   result$   &      _ENV 4  U   @   G@ LA��� d������� ���� �$� LB�d� ����� ��A�� �@ ��AC 䂀��$� L�B� �  
��
�Æ@�� d� �  �@ ���� ��� b  @�D�$� F�D � d@��� �
���  ���D ��  @�
�E�i�  ���DE �E$� L�E� dD�& & �    _worldGetEntityByIDGetSerialScopeType
GetRadiusGetPieceTypeGetGridPosition	BodyAreaGetAreaGetServiceUtilScopeCalcGetSkillScopeCalcComputeScopeRange                      GetPreviewEntityPreviewEnvGetAttackRangepairstableinsertSkillSerialKillerResultNewSetAddPiecePosList         @   5  5  5  5  7  7  8  8  9  9  :  :  ;  ;  ;  ;  =  =  =  =  ?  ?  B  B  B  B  B  B  B  B  D  G  G  G  G  G  I  I  J  J  K  K  K  K  L  L  L  M  M  N  N  N  N  N  K  K  R  R  R  S  S  S  T  U     self    @   casterEntityID    @   nearestEntityIDs    @   skillEffectParam    @   skillID    @   	attacker   @   serialScopeType   @   radius   @   
pieceType
   @   
posCaster   @   casterBodyArea   @   utilScopeSvc   @   scopeCalculator   @   scopeResult   @   addPiecePosList   @   env$   @   array(   8   (for generator)+   8   (for state)+   8   (for control)+   8   _,   6   v,   6   pt/   6   res;   @      _ENV [  `   
   @ A@��@ $��L�@��   @�d��f & �    %PreviewSkillEffectCalc_ForceMovementNew_world
Calculate            ]  ]  ]  ]  ^  ^  ^  ^  ^  _  `     self       casterEntity       skillPreviewContext       skillEffectParam       skillEffectCalc      result	         _ENV b  h   	   � @ �@�G�@ 䀀���� �A BA $��& & �    %PreviewSkillEffectCalc_ForceMovementNew_world#CalcTargetFourDirForceMovementStepskillPreviewContextskillEffectParam            e  e  e  e  f  f  f  f  f  g  h     self       targetEntity       maxStep       skillEffectCalc      result	         _ENV i  n   
   @ A@��@ $��L�@��   @�d��f & �    %PreviewSkillEffectCalc_ForceMovementNew_worldCalcTargetForceMovementStep            k  k  k  k  l  l  l  l  l  m  n     self       casterEntity       v2Dir       maxStep       skillEffectCalc      result	         _ENV q  �   `   L@�A@ ǁ�d������� ��� BA �A$� D� �  ����A ��AC 䂀��� $À��@ �A B�� $��FC ��d���DC  �@ �� ̄C@�䄀�C �A
����	  	$��LD� 
dE�i�  �C��  �
��B��A �D��$��G�A L��� d��"  �����  ����C  ���E�� �CE� ̃�� @����E � � $� G�A L��� d����  @ �� �   ��DF �@ � �D�& & �    GetTargetEntityIDListSkillEffectTypeTransportByRange	IsPickUpIsTransportTarget"SkillEffectResultTransportByRangeNew_worldGetServiceUtilScopeCalcCalcRangeByPickUpPosList	UtilDataipairsGridGetNextPosGetPieceTypeTransportByRangePieceDataAddPieceData       GetEntityByIDCheckForceMoveImmunityGetGridPosition	BodyAreaGetAreaCountGetNextPosIsMonsterCanTel2TargetPosAddTargetData         `   r  r  r  r  s  s  t  t  v  v  v  w  x  x  z  z  z  z  {  {  {  {  {  }  }  }  }  ~  ~  ~  ~          �  �  �  �  �  �  �  �  �  �  �  �  ~  ~  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    `   casterEntity    `   skillPreviewContext    `   effectParam    `   pickUpList    `   
targetIDs   `   	isPickUp   `   isTransportTarget   `   result   `   range   `   dirType   `   utilScopeSvc   1   utilDataSvc   1   (for generator)   1   (for state)   1   (for control)   1   i   /   v   /   nextPos#   /   
pieceType&   /   
pieceData,   /   	targetID4   ^   targetEntity8   ^   utilDatSvc<   ^   posE   ^   bodyAreaCountI   ^   nextPosO   ^   utilDataSvcS   ^      _ENV �  �   .     F@ GA�@���F�@ ��@�A�A�d�� ���F@ GA�@���F�@ ��@�A�A�d�� � �F@ G��@���F�@ ��@�A �Ad�� �@�F@ G��@�@�F�@ ��@�A �Ad�� �& & �    DirectionTypeUpVector2xyDownLeftRight         .   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    .   i    .   pos    .   dirType    .   nextPos   .      _ENV �  �   A   �   @ A@��  $��D  ��@ �A_�� ���@ �AA�� ���A�� �  ����@ ��A_�� ���@ �B�� ��AB�� �  �@ �A@� ����@ �A�A�  䁀� @��� (�C ����   $��LCC� d�����  ����C    �& b   ���C �D_��  �& 'B�f & �    _worldGetServiceUtilScopeCalcDirectionTypeUpDownGetCurBoardMaxYLeftRightGetCurBoardMaxX	UtilData       _GetNextPosGetPieceTypeIsValidPiecePos
PieceTypeNone         A   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    A   pos    A   dirType    A   max   A   utilScopeCalcSvc   A   nextPos   A   utilDataSvc!   A   utilScopeSvc%   A   (for index)(   ?   (for limit)(   ?   (for step)(   ?   i)   >   tmpPos.   >   
pieceType1   >      _ENV �  �   F   �   @ A@��  $��D  ��@ �A_�� ���@ �AA�� ���A�� �  ����@ ��A_�� ���@ �B�� ��AB�� �  �@ �A@� ����@ �A�A�  䁀� @��� (B�C ����   $��LCC� d�����  ����C    �& b  @���C �D_��@��CD  ����    �& '�f & �    _worldGetServiceUtilScopeCalcDirectionTypeUpDownGetCurBoardMaxYLeftRightGetCurBoardMaxX	UtilData       _GetNextPosGetPieceTypeIsValidPiecePos
PieceTypeNoneIsPosCanConvertGridElement         F   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    F   pos    F   dirType    F   max   F   utilScopeCalcSvc   F   nextPos   F   utilDataSvc!   F   utilScopeSvc%   F   (for index)(   D   (for limit)(   D   (for step)(   D   i)   C   tmpPos.   C   
pieceType1   C      _ENV �  '   �   L@d� ���A@�@ ����$� L��d� �A  �����   @ �C  (���L�@d� @�@�LDAd� b  @
�_���	�@ ��A ��A	�  �AE ��@�� �� �B$ �D  ��!�	���C @ � 	��F  � �  @��A �A
AE ��	�� ƄA� ���� $E  ��B�	@ 
��	�D@	@��B�'���   AC  � (���L�@d� @��
�LDAd� b  �	�_�� 	�F�A G��� ��E L�Bd dD  @ ��!�����C @ � 	�� � �  @��A �A
A� ��	�� ƄA� ���� $E  ��B�	@ 
��	�D@	@��B�'���D @�$� �G�L�� dD�)�  �C�CE �E� $��& & �    GetScopeResult       FindPickIndexGetGridType
BuildDataIsCanConvertLoginfoReplaceIndex:Type:
 GridPos:GetGridPosFindCanTogetherGridDownToUp Index:Pos:
 NewType:��������	GridPos:UpToDown Index:ipairsSetGridPos%SkillEffectResult_PickUpGridTogetherNew         �   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �        �            
                                                                                                  !  !  !  !  "  "  "  "  !  !  %  %  %  %  &  '  $   self    �   casterEntity    �   skillPreviewContext    �   effectParam    �   pickUpList    �   skillRange   �   rangeCount   �   
pickupPos   �   pickupIndex   �   
pieceType
   �   gridDataList   �   replaceIndex   �   (for index)   F   (for limit)   F   (for step)   F   i   E   	gridData   E   tmpData   E   j*   E   tmpR2   C   tempGridData?   B   (for index)J   |   (for limit)J   |   (for step)J   |   iK   {   	gridDataL   {   tmpData_   {   j`   {   tmpRh   y   tempGridDatau   x   (for generator)   �   (for state)   �   (for control)   �   i�   �   pos�   �   results�   �      _ENV -  4      @ ��� hA�G� ���� �    �& g�& �    IsCanConvert           .  .  .  .  /  0  0  0  0  1  .  4  
   self       gridDataList       beginIndex       	endIndex       step       (for index)      (for limit)      (for step)      i   
   	gridData   
        7  =   
   � @  � �  �B�GB@@ ���G�@@  �� �  j�& �    ipairsxy            8  8  8  8  9  9  9  9  9  9  9  9  :  8  8  =     self       range       pickPos       (for generator)      (for state)      (for control)      i      v         _ENV @  X   ,   �   � @ �@�A�  䀀@ �@$� LAd� �AA �� �@�̂�@ 䂀��$� B$� LC�� d����B ��B�  �C  �C �CC  @ �����ƃC ���  @ �C���  *���  & �    _worldGetService	UtilDataGetRenderBoardEntityRenderBoardipairsGetGridRenderEntityPieceGetPieceTypeIsPosCanConvertGridElement
PieceTypeNonePickUpGridTogetherDataNewtableinsert         ,   B  D  D  D  D  F  F  F  H  H  I  I  I  I  K  K  K  L  L  L  L  M  M  M  N  N  N  N  O  S  S  S  S  S  S  T  T  T  T  T  I  I  W  X     self    ,   skillRange    ,   ret   ,   utilDataSvc   ,   renderBoardEntity   ,   renderBoardCmpt
   ,   (for generator)   *   (for state)   *   (for control)   *   i   (   pos   (   gridEntity   (   
pieceType   (   canConvert   (   data#   (      _ENV [  d      � @ @� 䀀A@ @ $��F�@ � d� ��@ ��� � )�  ���  & & �    GetPreviewGridTypeipairs	tonumber            \  \  \  ]  ]  ]  ]  ^  ^  ^  _  _  `  `  ]  ]  c  c  d  
   self       	checkPos       convertGridTypeArray       checkPosType      (for generator)      (for state)      (for control)      k      v      curGridType
         _ENV h  s   
   � @ �@@�� ��@�� ��@@� � ��   & �    _worldGetPreviewEntityPreviewEnvGetPieceType        
   i  i  i  i  i  j  j  j  j  s     self    
   pos    
   env   
       F                                                          #   l   #   q     q     1    4  U  4  [  `  [  b  h  b  i  n  i  q  �  q  �  �  �  �  �  �  �  �  �  �  '  �  -  4  -  7  =  7  @  X  @  [  d  [  h  s  h  s         _ENV