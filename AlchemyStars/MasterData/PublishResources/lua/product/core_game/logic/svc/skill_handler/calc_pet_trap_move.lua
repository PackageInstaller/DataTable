LuaS �

xV           (w@Z@../PublishResources/lua/product/core_game/logic/svc/skill_handler/calc_pet_trap_move.lua         :    @ A@  ��@ $@�@@  ��@@ l   
@��@@ l@  
@ �@@ l�  
@��@@ l�  
@ �@@ l  
@ �@@ l@ 
@��@@ l� 
@ �@@ l� 
@��@@ l  
@ �@@ l@ 
@��@@ l� 
@ �@@ l� 
@��@@ l  
@ �@@ l@ 
@��@@ l� 
@ �@@ l� 
@��@@ l  
@ �& �    _classSkillEffectCalc_PetTrapMoveSkillEffectCalc_BaseConstructorDoSkillEffectCalculator_CalcPreviewRange_OnArrivePosCalMoveResultList_CalcMovePosFindNewTargetPosFindPosValidIsPosAccessibleComputeWalkRangeFindNewWalkPosFindPosByNearCenterComputeSkillRange_ComputeSkillRangeCalculateSkillRange_CalculateSkillScope                  
@ ���@ ��@A AAF�A G���� 
����@@ � B�@ & � 	   _worldm_nextPosListSortedArrayNew
AlgorithmCOMPARE_CUSTOMAiSortByDistance_ComparerByNearAllowDuplicate            
                                          self       world          _ENV       *  � � �� �@@ ̀�@ 䀀
����$� LA� d� �  ƁA ��� �� !��  ����A@ ́�@ 䁀B� L�Bd� ��B�� �C� CC$� L�d� �C@ ��C�� ��C�� �A� D@ D�D $��GD@ L��� d���  
����D@ �E	E@ EE
�E
�����E F	$ � ��F�$� "F  ����$� L�Fd� ��A ��F�  �����F   ����� _�  ��F��� ��G�� ��� �E @ $ �F�A G����D ��dH�)�  ���  jE��    GH LE�
dE K  
 ���H �I� ��EI   @��� ƅA ǅ�  @ �E��  A ���ǆ�I JGH ����  $G����  �A �	��FJ @�����B� �����A �A@�
$� �J  �ǆH _�� ��H K$� N��GK ��K  @ ���� 	 �����K@ �G�
��ƇA ��� �
@ �G��E� X���H �L�@��EI   @��� ƅA ǅ�  @ �E��E�  ���
 FL �K��L ��L�M �F�$� 
 �H �M$F  @�� (��M ��H � � $������F�I G��H ���H A�
 dG�A � � h�G���� �HN @	 䈀�   �_���� � ��� �_ ����I ��	H @	��	 �	 �H�gG�L�N �H �H d� ��H �K�� ·�HK �K� �  	�@	��	 $��L�K� dH�
@�F�A G����
� dH�'F��?���H ��N����O �����FO���   �& � �  �A ����M G�H � �� 䆀�I JGH � ǇH �
 $G� \�� (��ȇLNd� �HN  	�����  ����I �J�H  	 @	��	��H�'���N �H ǇH $� G�H L�d� �G�GK ̇�@ ���  	 @	 䇀��� $H�
 ��A �G@�
��$H��E��,���H ��O�@��EI   @��� ƅA ǅ�  @ �E���F�$� L�O �� �L�Gd d�  � �� ���G��GN @ 䇀�  ����I ��H @ � ���G��F�
 ��  �   @�� (	�HJ ���ȇ��$� �J��F�A G����
d� ��  ��H _�J �G�H L�d� �H�HK ̈�@	 �	��	  
 @
 䈀���	 $I�
 ��A �G@	�
�	�$I�'G� ���H �P� ��  ��E  �� �O G��G�$��F�A G��� � dG��  j���
  @�� (F��F�A G��� � dG�'�  F�E � d � ���������A ��G�  ��G�_�� � �  ���i�  ��F�E � d���G� �F�P G���� �G  @���A ��F��D  �����G  ����H �K�� ·�HK �K� �  	�@	��	 $��L�K��dH�
@�F�A G����
� dH�i�  ��f & � D   GetCasterEntityID_worldGetEntityByIDcasterEntityGetGridPositionGetTargetEntityIDstablecount       skillEffectParamGetMoveStepGetMoveTypeGetMoveParamGetCanMoveTrapLevelPlayerGetLocalTeamEntityGetService	UtilCalcBoardLogic_needBypassPosList	GetGroupBW_WEMatchersTrapipairsGetEntitiesHasDeadMarkGetTrapLevelintableGetID	BodyAreaGetAreainsertm_nextPosListClear	_lastPosPetTrapMoveTypeCloseToTeam_CalcPreviewRangeremovev
AINewNodeInsertSortedArray_CalcMovePos         CloneSkillEffectResultPetTrapMoveNewSetPreviewRangeAwayFromTeamSortedArray
AlgorithmCOMPARE_CUSTOMAiSortByDistance_ComparerByFarAllowDuplicateComputeWalkRangeGetPosIsPosAccessibleFindPosValid	FixedPosVector2       	SkillPos_ComputeSkillRangeLoopIsPosBlock
BlockFlagMonsterLand                                                                    !   !   !   !   $   &   &   '   '   (   (   )   )   +   +   -   -   -   -   -   .   .   1   1   1   1   3   3   3   3   6   6   7   7   7   7   7   7   8   8   8   8   8   9   9   9   9   ;   ;   <   <   =   =   =   =   =   =   =   =   =   =   =   >   >   >   >   ?   ?   @   @   @   @   A   A   A   A   A   @   @   8   8   H   I   K   K   K   M   N   P   P   P   P   Q   Q   Q   Q   R   R   R   R   R   r   r   r   r   s   u   u   u   u   u   u   u   r   y   y   y   y   {   {   {   {   {   }   }   }   }   }   }   }   }   ~   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   y   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �                  �                                                                                                                                 �   self      skillEffectCalcParam      casterEntityID     casterEntity     
casterPos	     targetIDList     	targetID     targetEntity     skillParam     	moveStep     	moveType     
moveParam     canMoveTrapLevel      targetCenterPos"     teamEntity'     teamPos)     utilCalcSvc-     boardServiceLogic1     
trapGroup9     (for generator)=   d   (for state)=   d   (for control)=   d   _>   b   e>   b   	trapCmptD   b   levelF   b   	bodyAreaU   b   gridPosW   b   (for generator)Z   b   (for state)Z   b   (for control)Z   b   _[   `   v[   `   posWalkResultListe     isCasterDeadf     resultListj     previewRanges   �   (for index){   �   (for limit){   �   (for step){   �   i|   �   posWork}   �   (for index)�   �   (for limit)�   �   (for step)�   �   i�   �   posWalk�   �   posOld�   �   dirNew�   �   result�   �   previewRange�     bExcludeSelf�     (for index)�     (for limit)�     (for step)�     i�     
walkRange�     (for index)�   �   (for limit)�   �   (for step)�   �   i�   �   posData�   �   posWalk�   �   posFind�     posOld�     dirNew�     result    
targetPos  ]  (for index)"  ]  (for limit)"  ]  (for step)"  ]  i#  \  
walkRange(  \  (for index)2  C  (for limit)2  C  (for step)2  C  i3  B  posData4  B  posWalk6  B  posFindG  \  posOldJ  \  dirNewK  \  resultS  \  previewRangef  �  skillIDl  �  bodyAreaCmptn  �  
walkRanget  �  (for index)w  �  (for limit)w  �  (for step)w  �  ix  �  posWorky  �  isCasterDead�  �  posWalkResultList�  �  (for index)�  �  (for limit)�  �  (for step)�  �  i�  �  posWalk�  �  posOld�  �  dirNew�  �  result�  �  posList�    (for generator)�  �  (for state)�  �  (for control)�  �  _�  �  param�  �  pos�  �  canMoveSetp�    (for index)�  �  (for limit)�  �  (for step)�  �  i�  �  addPos�  �  calcPosList�    (for generator)�  �  (for state)�  �  (for control)�  �  _�  �  pos�  �  (for generator)�    (for state)�    (for control)�    _�    pos�    posOld�    dirNew�    result       _ENV !  ,      �   @ �� � � $��AA  � �A  h��G����� ��@ �� �@ �B�g���  & �    ComputeWalkRange       GetPostableinsert            "  #  #  #  #  #  %  %  %  %  '  (  (  )  )  )  )  )  %  +  ,     self       
casterPos       	moveStep       previewRange      
walkRange      (for index)	      (for limit)	      (for step)	      i
      posData      posWalk         _ENV .  9      �   @ �� � � $��AA  � �A  h��G����� ��@ �� �@ �B�g���  & �    ComputeWalkRange       GetPostableinsert            /  0  0  0  0  0  2  2  2  2  4  5  5  6  6  6  6  6  2  8  9     self       
casterPos       	moveStep       previewRange      
walkRange      (for index)	      (for limit)	      (for step)	      i
      posData      posWalk         _ENV =  K      @ A@��  $��L�@�� A BAd� ƁA  �� � �G���A �B�� �CB@��C�̃BL�Bd� � �C �  j�& �    _worldGetService
TrapLogicTriggerTrapByEntityTrapTriggerOriginMoveipairsAISkillResultNewSetResultContainerAddWalkTrapGetID            ?  ?  ?  ?  A  A  A  A  A  B  B  B  B  D  F  G  G  G  H  H  H  I  I  I  I  I  B  B  K     self       casterEntity       walkRes       skillParam       trapServiceLogic      listTrapWork	      listTrapResult	      (for generator)      (for state)      (for control)      i      e      trapEntity      skillEffectResultContainer      	aiResult         _ENV O  z   L   �$� LA�d� ����� � �@$� L�� d� �A�� �BA ̂�A� 䂀CA �A� $��K� � kC� �CB ��B�C ��B  �@ �C� ��  �C  AD ��Ǆ�C ��	$��"  ���C D
GEB ����	  	$E��C�
@���    AD � �D h��L�D �� FCd� _��
����� �� 
@���E �E�  @�
�E�g��& & �    GetMoveStepGetMoveTypeGetMoveParamGetGridPosition	BodyArea_worldGetService	UtilCalcBoardLogicm_nextPosListClear_ComputeSkillRangeGetArea       IsPosAccessible
AINewNodeInsertSortedArray	_lastPos_CalcMovePos tableinsert         L   P  P  Q  Q  R  R  S  V  V  W  W  Y  Y  \  \  \  \  ^  ^  ^  ^  `  `  `  a  a  a  c  c  c  c  c  c  d  d  d  d  e  f  f  f  f  f  g  g  g  g  g  g  g  d  k  l  n  o  o  o  o  q  q  q  q  q  s  s  t  t  u  v  v  v  v  v  o  y  z     self    L   casterEntity    L   targetEntity    L   skillParam    L   	moveStep   L   	moveType   L   
moveParam   L   skillID   L   targetCenterPos	   L   
casterPos   L   bodyAreaCmpt   L   utilCalcSvc   L   sBoard   L   listPosTarget   L   
walkRange!   L   (for index)$   3   (for limit)$   3   (for step)$   3   i%   2   posWork&   2   isCasterDead5   L   posWalkResultList6   L   (for index)9   J   (for limit)9   J   (for step)9   J   i:   I   posWalk?   I   posSelfC   I      _ENV ~  �      � @ A@ ��$�� �@ �D  f L�@ ��  C� d����@  �@ ������  � �� @ ��  � � & �    	_lastPosFindNewTargetPosComputeWalkRangeFindNewWalkPos           �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       entityWork       nWalkTotal       posSelf      
posTarget      posWalkList      posWalk           �  �      � @ A@ @� �  �   & �    FindPosValidm_nextPosList           �  �  �  �  �  �     self       posDefault            �  �      _@ �� ��@� � !��  ��  �   �LA� d� ��  ���  �A���  �����BA G�A䂀���@ ��A  ���& & �     Size               GetAtIsPosAccessibledata           �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       planPosList       defPos       posSelf      
posReturn	      
nPosCount      (for index)      (for limit)      (for step)      i      posWork      bAccessible           �  �   6   �@@ ��@�� � �@ �� � �  ��@ � A�@A  � ����   @ ��   �  ��A ��A ����@B ǀ�A@ �B�� $��GA@ L���C d���A � B ����B��@ ǂ� �@ 䂀�B  ����C@ ��� �  @ ��  � ����� � & �     casterEntityHasBodyAreatableintable_needBypassPosList_worldGetServiceBoardLogic
BlockFlagMonsterLandGetCoverAreaList	_lastPos       
icontainsIsPosBlock         6   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    6   pos    6   boardServiceLogic   6   
blockFlag   6   
coverList   6   coverListSelf   6   (for index)!   3   (for limit)!   3   (for step)!   3   i"   2   posWork#   2      _ENV �  �   
   �@    ��     �   ��F@ LA���  �@ @  d�� �FA GA��� ��    @ e�f  & �    	CallbackNew       IsPosAccessibleComputeScopeRangeComputeRange_WalkMathPos            �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       
centerPos       
nWalkStep       bFilter       	cbFilter         _ENV �  �   
   @ �� �  �AB  % &  & �    FindPosByNearCenter                  �  �  �  �  �  �  �  �     self       
walkRange       
posCenter       posDef            �  �   >   _@ �@�FA@ G���� d� !��  ��  GA LA��� d����A �BBB �BF�B G��� �AC�A ǁC � \� �� (��Â LDd� _����_ �� ��CD�� � ���� �@���D ���_��@� E���CE ǃ�  @ �����C���'���E � ��% &  & �     tablecount        _worldGetService	UtilDataSortedArrayNew
AlgorithmCOMPARE_CUSTOMAiSortByDistance_ComparerByNearAllowDuplicate	_lastPos       GetPosGetStepIsBlockMoveWithTrapWallcasterEntity 
AINewNodeInsertSortedArrayFindPosValid         >   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    >   listPlanPos    >   
posCenter    >   posDef    >   nCheckStep    >   utilDataSvc   >   	listWalk   >   lastMovePos   >   (for index)   8   (for limit)   8   (for step)   8   i   7   posData   7   posWalk   7   isBlockMoveWithTrapWall+   7      _ENV �     P   G@ LA���  d����� � ����A� BA �A ����A �� �  �FB �C �� d�$�  L�A ��   @��B �C � ��d�  ��A  � @ ���B � AD ����  ��A @� � ��B A� �D $��    FC GC�� � dC�FC GC�� ��dC�FC GC�� � dC�FC GC�� ��dC�& ���A �� �  �@ % &  & �    _worldGetServiceConfigGetSkillConfigDataGetSkillScopeTypeSkillScopeTypeDirectLineExpand_ComputeSkillRangeVector2               ��������tableappendArray         P   �  �  �  �                                                                                                           	  	  	  	  	  
  
  
  
  
                                   self    P   skillID    P   
centerPos    P   	bodyArea    P   dir    P   configService   P   skillConfigData   P   
scopeType	   P   ret1   G   ret2   G   ret3(   G   ret41   G   ret2   G      _ENV   #       � @ �K  f @ �����@���@ ��  �  ���M�������� ���@ �A B ���M����A  � @�� ��� �  & �                   Vector2��������	       ��������CalculateSkillRange                                                             "  "  "  "  "  "  "  #     self       	nSkillID       
posCenter       	bodyArea       dir       workCenter         _ENV &  8   !   L@ ��   @�� d� bA  @ ��  � �A��� �  �  \ ��  (��FA GC���� d��@�� �FA G����� dC�'B�� & �    _CalculateSkillScopeGetAttackRange        table
icontainsinsert         !   (  (  (  (  (  (  *  *  +  +  /  /  0  1  1  1  1  2  3  3  3  3  3  3  3  4  4  4  4  4  1  7  8     self    !   skillID    !   
centerPos    !   dir    !   bodyAreaList    !   skillResult   !   skillRange   !   listReturn   !   (for index)      (for limit)      (for step)      i      posWork         _ENV :  G      �@ �A@�  �����@@� 䁀@ B@� $��LBAd� �@   ���A ��  ����  �B� �@ ���  ����� & � 
   _worldGetServiceConfigGetSkillConfigDataUtilScopeCalcGetSkillScopeCalcVector2               CalcSkillScope            <  <  <  <  >  >  >  @  @  @  @  B  B  C  C  C  C  C  C  C  E  E  E  E  E  E  E  F  G     self       skillID       
centerPos       dir       bodyAreaList       entityCaster       configService      skillConfigData      utilScopeSvc      skillCalculater      skillResult         _ENV:                                      !  ,  !  .  9  .  =  K  =  O  z  O  ~  �  ~  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �    �    #    &  8  &  :  G  :  G         _ENV