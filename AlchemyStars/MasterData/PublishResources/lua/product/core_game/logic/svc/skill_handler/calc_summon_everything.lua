LuaS �

xV           (w@^@../PublishResources/lua/product/core_game/logic/svc/skill_handler/calc_summon_everything.lua         .    @ A@  ��@ $@�@@  ��@@ l   
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
@��& �    _class!SkillEffectCalc_SummonEverythingObjectConstructorDoSkillEffectCalculator!_CheckSummonEverythingLimitCount_CalSummonID_CalSummonID_Random_CalSummonID_RandomDifferent_CalSummonID_OutOfRangeTrap_CalSummonID_MirrorImage_CalTrapSommonPosExceptionAround4ExceptionAroundSquareRingAround4AndNearToFarNoRandomMirrorImagePos               %   
@ �� @ ��@�  ���
���� @ ��@A ���
� ���A � �@��   
�����A � B �@��B � ���A � B ���C � ���A � B �@��C � ���A � B ���D � �& �    _world_skillEffectServiceGetServiceSkillEffectCalc_mathServiceMath m_listFuncCalSummonIDSkillEffectEnum_SummonBehaviorRandom_CalSummonID_RandomRandomDifferent_CalSummonID_RandomDifferentOutOfGridRange_CalSummonID_OutOfRangeTrapMirrorImage_CalSummonID_MirrorImage         %   
                                                                                                                  self    %   world    %      _ENV    �    /  � @ �@@�� �����@� � K  �AA�� ́A� �A$� LBd� �BB�� ̂B� �B$� LCd� �CC�� ̃C� �C$� LDd� �DD�� ̄D� �  @��D$� "  @�FE �EE
� ��d�  bE    �A�  @��� ��� ��
�E� �   b  @ �FF E�
�   �G@ L��
�� d����
FGG�G�� @ L�G �  �@�d��� �EH ǅ��  ����    �� 	b  ��� �H$� "  � �I$� � E @�$� G@ L���F	 d����� �@ �� � �  �I J   ���   FFJ ��
d $�� �  ��"���J  	 \	��	 �	�
 
�@
 �� �  @ ���	  FIH G��@	� �G	� 	�@	�FIH GI�@	 �G	� 	�"  @�G	b	  ��I� �FIH G��@	@�L�K �	L�	 d�   	���G	� �    �GI� ��L ��L 
 @
��
��
   
@������ 	 "I   �F�I G	�@	@�LIM �	@  
 G
� �
��
   
d�  	�@�F�I G��@	 �LIM �	@  
 G
� �
��
   
d�  	�"I  ��L�M �	@  
 G
� �
��
   
d�  	� �F�I G	�@	 �G	� b	  � ��	�  H  �GI� �	N 
@ @
 �
��
�  @ 
�� ��� 	 "I  ��FIN G���� �	 
 dI  �"	  @�FIO L���	  
�@
��
 d� �	��	HJA	���i�  ��f & � ?   _worldGetEntityByIDcasterEntityIDGetGridPositionskillEffectParamGetSummonTypeGetSummonListGetSummonBehaviorGetSummonNumberGetSummonNumberRangeGetSummonMonsterLimitCountGetLimitCheckIDIsIgnoreBlockGetSummonExceptionTypeGetSummonCheckIgnoreBodyAreaGetCageSumOffPosListGetUseBuffLayerAsTimesGetSummonTimesForEachIDIsUseRecordIDAsSummonIDBuffComponent	tonumberGetBuffValueRecordSummonerCfgID        
BlockFlagNoneGetServiceRandomLogic
LogicRandminmax_CalSummonID       SkillEffectEnum_SummonBehavior
NonrandomHasSuperEntityGetSuperEntity
BuffLogicGetBuffLayer$SkillEffectEnum_SummonExceptionTypeRing9ipairs!_CheckSummonEverythingLimitCountOutOfGridRangeskillRangeCageMirrorImageMirrorImagePos
GetTrapIDwholeRange_skillEffectService_FindSummonPosAround4ExceptionAround4Around4AndNearToFarExceptionAroundSquareRingAround4AndNearToFarNoRandomLoginfoA[SkillEffectCalcService] SummonEverything: not enough space at [], skipping. #SkillEffectResult_SummonEverythingNew                             $   %   '   '   (   (   )   )   *   *   +   +   ,   ,   -   -   .   .   /   /   0   0   1   1   2   2   3   3   5   5   6   6   7   7   8   8   9   9   9   9   9   9   9   9   :   :   ;   ;   ;   ;   @   A   A   B   B   D   D   F   F   F   F   H   H   H   H   I   L   L   L   L   L   N   P   P   P   P   Q   T   T   U   W   W   X   Y   Y   Y   Y   Z   Z   Z   \   \   \   ^   ^   ^   ^   _   _   _   _   `   c   d   d   d   d   e   g   h   h   h   h   i   i   i   i   l   m   n   o   p   q   s   l   t   t   u   v   w   w   w   w   x   x   x   y   y   y   y   z   z   |   |   }   ~   ~      �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   i   h   h   �   �   1   self      skillEffectCalcParam      casterEntity     
posCaster     skillEffectParam     summonResArray     nSummonType
     nSummonList     nSummonBehavior     nSummonNumber     tSummonNumberRange     nSummonMonsterLimitCount     tLimitCheckID     bIgnoreBlock     exceptionType     bCheckIgnoreBodyArea     cageSumOffPosList     useBuffLayerAsTimes      summonTimesForEachID"     bUseRecordIDAsSummonID$     cBuff(   8   	recordID2   8   
blockType9     
randomSvcC   H   randomG   H   listSummonIDM     nSummonTimesN     buffHolderEntityY   l   buffEffectTypec   l   buffSvcg   l   layerk   l   searchRing9m     listPosHaveDowns     (for generator)v   
  (for state)v   
  (for control)v   
  keyw     vw     (for index)z     (for limit)z     (for step)z     i{     
canSummon�     curSummonID�     
posSummon�     offPos�   �   range�   �   range�   �   summonResult       _ENV �      `   ��  �  ��   �  � �\  @�  �  FB@ G����@	�A  @ ��@ �A�@ CA�A����   ���A B$ � ��D�$� "D  ����$� �B$� F�B G�� � d��b    �MB�!@�@ �C  f �  jC� 
�FB@ G���� 	�A  @ ��@ �A�@ CA�C����  ����A B$ � ��D�$� "D  ����$� �C$� F�B G�� � d��b    �MB�!@�@ �C  f �  jC�� & �            SkillEffectEnum_SummonTypeMonster_world	GetGroupBW_WEMatchers
MonsterIDipairsGetEntitiesHasDeadMarkGetMonsterIDtableintable       Trap
GetTrapID         `   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �                                                                	  	  
  
             self    `   casterEntity    `   hadSummonCount    `   nSummonType    `   
nSummonID    `   nSummonMonsterLimitCount    `   tLimitCheckID    `   
canSummon   `   	checkIDs   `   	hadCount   4   monsterGroup   4   (for generator)   4   (for state)   4   (for control)   4   _   2   monsterEntity   2   
monsterID&   2   	hadCount:   ^   
trapGroupA   ^   (for generator)G   ^   (for state)G   ^   (for control)G   ^   _H   \   trapEntityH   \   trapIDP   \      _ENV      	   @ A  ��  ��  @ �  �  �e f  & �    m_listFuncCalSummonID                                       self       nSummonBehavior       nSummonNumber       nSummonList       
pFunction             *      � @ �@�A�  䀀  F�@ G�� d�  @�� ��A �� B ������C @��� � �B��
����& & �    _worldGetServiceRandomLogictablecount       
LogicRand                    !  "  "  "  "  #  #  $  $  $  $  %  %  %  %  &  &  &  &  $  )  *     self       nSummonNumber       nSummonList       
randomSvc      listSummonID      nSummonTableNum	      (for index)      (for limit)      (for step)      i      nRandomIndex         _ENV -  >   $   � @ �@�A�  䀀  F�@ G�� d�  @������@ �A� ��  @  ����B @��� ǁ�@ �A@ ��$��"B  @� BAG�
A �& & �    _worldGetServiceRandomLogictablecount       
LogicRand
icontains         $   /  /  /  /  1  2  2  2  2  3  3  4  4  4  4  4  4  5  5  5  5  7  8  8  8  8  8  8  8  9  9  9  9  :  =  >     self    $   nSummonNumber    $   nSummonList    $   
randomSvc   $   listSummonID   $   nSummonTableNum	   $   nRandomIndex   !   
monsterID   !      _ENV @  B      �  & �                A  B     self       nSummonNumber       nSummonList            D  F      �  & �                E  F     self       nSummonNumber       nSummonList            I  b   ?     F@ GA�G���  b  ��Ɓ@ ��� �A FCA ���d� �CA ���� $�  FB GC�� � dC��  j��� �A� �A��A ǂ����BG��G�䂀  \  @�� �L�� ���C D@ �  d�  �@�LC� ���C Dd�  �"C  @ � �  ���& & �    Cfg	cfg_trapipairsAreaVector2	tonumber              tableinsertNewxy        IsPosBlockByArea
BlockFlagSummonTrapIsPosBlock         ?   J  K  K  K  L  M  M  N  N  N  N  O  O  O  O  O  O  O  O  P  P  P  P  P  N  N  T  T  T  T  U  U  U  U  U  U  U  V  W  W  W  X  X  X  X  X  X  X  X  X  Z  Z  Z  Z  Z  Z  \  \  ]  ]  T  a  b     self    ?   boardServiceLogic    ?   nTrapID    ?   listPosPlan    ?   
posSummon   ?   cfgTrap   ?   trapBodyArea   ?   (for generator)
      (for state)
      (for control)
      key      value      posTemp      (for index)   =   (for limit)   =   (for step)   =   i   <   posTemp%   <   	bIsBlock&   <      _ENV e  �   n     L� �B  d����@ �������@ AGDAM��䃀�@ GA�DA��A	$��F�@ �A��A	�DAd����@ �A΄�	EA������@�䄀�  ���B �D�	  @�䄀�D   ��B Ǆ�	  @��D����@ 䄀�  ���B �D�	  @ 䄀�D   ��B Ǆ�	  @ �D����@�䄀�  ���B �D�	  @�䄀�D   ��B Ǆ�	  @��D����@ 	䄀�  ���B �D�	  @ 	䄀�D   ��B Ǆ�	  @ 	�D���  *C���B �C  @ � ��  D� ��� �  & �    GetServiceBoardLogicipairsVector2xy       IsValidPiecePostableVector2Includeinsert_skillEffectService_FindSummonPos         n   n  p  p  p  q  q  q  q  r  r  r  r  r  s  s  s  s  s  t  t  t  t  t  u  u  u  u  u  v  v  v  v  v  v  v  v  v  v  v  v  w  w  w  w  w  y  y  y  y  y  y  y  y  y  y  y  y  z  z  z  z  z  |  |  |  |  |  |  |  |  |  |  |  |  }  }  }  }  }                          �  �  �  �  �  q  q  �  �  �  �  �  �  �  �  �  �  �  �     self    n   world    n   nSummonType    n   skillRange    n   curSummonID    n   listPosHaveDown    n   
blockType    n   	noRandom    n   exceptionRange   n   	boardSvc   n   (for generator)   b   (for state)   b   (for control)   b   _   `   pos   `   up   `   down   `   left   `   right   `      _ENV �  �   &   � �B  $��L�@d� �  ��@ ��A 䂀C @��C (��A �AGD��D ��� $��GB LD��   @ ��� � ��d� ���    �� 'C�� & � 
   GetServiceBoardLogicGetCurBoardMaxLen_world	UtilData       ComputeScopeRangeComputeRange_SquareRing_skillEffectService_FindSummonPos         &   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    &   world    &   nSummonType    &   skillRange    &   curSummonID    &   listPosHaveDown    &   
blockType    &   	noRandom    &   	boardSvc   &   maxLen   &   
posSummon   &   utilDataService
   &   (for index)   $   (for limit)   $   (for step)   $   i   #   posList   #      _ENV �  �      @ �� �  �@ ���  �$��"B  @�LB@ ��   @�� ��  @�d�� �& & �    ExceptionAround4ExceptionAroundSquareRing           �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  	   self       world       nSummonType       skillRange       curSummonID       listPosHaveDown       
blockType       	noRandom       
posSummon	           �  �   	   � @ �@@�� ��@�� ��@� @ A�A $��L�A�� d��b   �����  @������@� � & �  & �    _worldPlayerGetCurrentTeamEntityGetGridPositionGetService	UtilDataGetTrapByID                  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       trapID       teamEntity      
playerPos      utilDataSvc      trapEntities      trapEntity      
mirrorPos          .                                 �      �     �           *    -  >  -  @  B  @  D  F  D  I  b  I  e  �  e  �  �  �  �  �  �  �  �  �  �         _ENV