LuaS �

xV           (w@W@../PublishResources/lua/product/core_game/logic/svc/skill_handler/calc_push_board.lua             @ A@  ��@ $@�@@  ��@@ l   
@��@@ l@  
@ �@@ l�  
@��@@ l�  
@ �@@ l  
@��@@ l@ 
@ �@@ l� 
@��@@ l� 
@ �& �    _classSkillEffectCalc_PushBoardObjectConstructorDoSkillEffectCalculator_SortByFunSortGridByPushDirPushBoardOneStep_TriggerTraps_DestroyTrap_CalculatePushStep                  
@ �� @ ��@�� 
���& �    _world_boardEntityGetBoardEntity           
                     self       world               ;    z   � @  � ���@@  �& � ̀� � ��$� LA � d����A �A  B  ���
�����A �A  B  ���
�����A �A   ��������A �  ���
�����A �  ���
���@���A �A  B ��������A � B  ���
�����A � B ���
��� ���A � B  ��������A �  ���
�����A �  ���
�������A �A B  ����@���A �A   ���
�����A �A  ���
����  �   A ���ƂB ���� C @�$@�FDC G����d� _@�  �CD  C� ��C  �@ � ���D )�  �������� & �    _CalculatePushStep        GetSkillEffectParamGetDirSortGridByPushDir_fourAreaFixPosVector2_nineAreaFixPos       ��������SkillEffectPushBoardResultNewpairstablecountPushBoardOneStep         z                                                              !   !   !   !   !   "   "   "   "   "   "   #   #   #   #   #   $   $   $   $   $   $   %   %   %   %   %   %   &   &   &   &   &   '   '   '   '   '   '   (   (   (   (   (   (   )   )   )   )   )   *   *   *   *   *   *   +   +   +   +   +   +   ,   ,   ,   ,   ,   -   -   -   -   -   0   1   1   1   1   2   2   2   3   3   3   3   4   4   4   4   4   4   4   4   5   5   5   5   5   5   3   3   7   1   :   ;      self    z   skillEffectCalcParam    z   	pushStep   z   skillEffectParam   z   
direction
   z   
sortRange   z   results[   z   (for index)^   x   (for limit)^   x   (for step)^   x   i_   w   resultb   w   (for generator)e   v   (for state)e   v   (for control)e   v   indexf   t   posListf   t   isLastn   t      _ENV =   J       �     F@ �� d ��B@ ��@�   �B�i�  ��FA@ G��� � dA�A � � h�\�M����� ʀ�gA��  & �    pairstableinsertsort                   >   ?   @   @   @   @   A   A   A   A   A   @   @   D   D   D   D   D   E   E   E   E   F   F   F   F   F   E   I   J      self       posDic       sortFun       newDic      keyList      (for generator)      (for state)      (for control)      k      _      (for index)      (for limit)      (for step)      i         _ENV L   u    W   � @ �@@�  �����@ � �� A�$� K  ��A � �@�ƂA   ��
��A @�� $��LB� EB �B
d� bD   �G�� _ �@�G�BGD�bD  � �G�B�  J��FDC G����B���� dD���G�� _ � �G�CGD�bD  � �G�C�  J��FDC G����C���� dD��  jC���  *���  ��A  A 䁀_�� @���A  A 䁀�� @ ��A  ���AD @�� � �  & �    _worldGetServiceBoardLogic_boardEntityBoardClonePieceTablepairsVector2IsPosBlock
BlockFlag
SkillSkipx        tableinserty��������_SortByFun         k   m       ` �   ��@  � � �  & �                l   l   l   l   l   m      a       b            o   q       `@    ��@  � � �  & �                p   p   p   p   p   q      a       b           W   N   N   N   N   P   P   P   Q   Q   T   U   U   U   U   V   V   V   V   W   W   W   W   X   X   X   X   X   X   X   Y   Y   Y   [   [   [   [   \   \   \   ^   ^   ^   ^   ^   ^   ^   _   _   _   a   a   a   a   b   b   b   d   d   d   d   d   d   V   V   U   U   m   n   n   n   n   n   n   n   n   n   n   n   n   q   q   t   t   t   t   t   u      self    W   
direction    W   boardServiceLogic   W   board   W   boardBlockArray	   W   skillRange
   W   (for generator)   B   (for state)   B   (for control)   B   x   @   col   @   (for generator)   @   (for state)   @   (for control)   @   y   >   _   >   grid   >   sortFunC   W      _ENV y   �   -�  G@ LA���  d����@ �A�� �@ �A�AB 䁀  K  ��A � ��W�� � L�A� d����  ����DB@ 䄀�B� $���   �L�B� d��bE    �D  �  �C@ � � �  �F�F� ��� $F �A @�$�5�C� ��C ��C�  D$� "   �HD$� �D$� � �D$� K  �  �E �H� 	��  ����ƈA  	�����	F
E G���
 �
 dJ�M� �
E ��E�
� ��J��  jI���"   ��� 	� @	�+I� @ 	� @	 +I� � �� �  �C  ƈA  	����
E JF@
 �
�$��"J   �
��
�$��"
  @����
��
 $� "
  @ �C  @ ��  jI���F� �  ��bG  @�̈C� ��� �C IG	� F  �C� b  ���E �H� 	�� ������� L	Hd� �IH ����IH ��	�H�̈HGIH NI	�H����@	 �IH ����IH ��	�H��	��E �H� 	��  ������ L	Hd� �II ����II ��	�H�̈HGII NI	�H����@	 �II ����II ��	�H�@���� L	Hd� �	��	 �H�̈H@	 �H����@	 �	��	 �H�̈I� �  @���I� ��� �A @	�$	� �L�H�
 dJ�)�  ���@���F� �  @��  	C�	 �I  $� \	  @	�  �ǈE�  ��\	 M���	 �	  
��I 
������D� I� �	H�� �	�$I )�  ���@ �J$� �J$� L�Dd� �@ �F@�  ����K� �   ������F�K� � kG� 䆀��G�K�� � ��$G  �@��L GD���� @ ���F ̆�@�� �F �  ��� ������ @��  ��
  �F �C���� @�� ��
  
�F ��	�� ��$F��  @��� ���   �
D  $F �A @�$ �L�Fd� b  @�LG��  �dG FE G����� dG���L�Dd� �G� H$� @��G )�  �������  *����A ̂� � � @�ǃE�M��$D�NGDN��G"   �̄N@ � 	���D���  *��"  �	���@ ��N�� �O� ͂�CO��$C��O A ��$��G��_ � �F�O ��� d�� �F�A � d �����A@ 	䄀� ����	  	$E�����	��$E i�  ����A � � ��CP @� ��E�N�C���  *���A ���� �̃P @� � �C ��  *C�& � C   _worldGetService	UtilData_boardEntityBoardBoardLogicipairsGetPieceTypeIsValidPiecePosIsSpecialPieceEffectGetBoardPieceEffectTypeGetPrismEntityIDAtPosGetPieceEntitiesAddMoveBoardPiece
BlockFlagMonsterLandHasBodyArea	BodyAreaGetAreaGetGridPositiontablecount       insert        intableIsPosBlock
HasTrapIDGetBlockFlag	LinkLine       AddLogicMoveEntityGetID_fourAreaFixPosSetGridPositionUpdateEntityBlockFlag	       _nineAreaFixPosHasTeamTeamGetTeamPetEntitiesAddRenderMoveEntityPlayerGetCurrentTeamEntityCanChangePieceToGraySupplyPieceListcolorAddConvertInfo
PieceTypeNoneSetPieceTypeLogicAddMoveBoardPrismAddRemoveBoardPieceRemoveEntityBlockFlagGetMoveBoardPrismsRemoveBoardPieceEffectType              SetBoardPieceEffectType
BoardPushGetPushIndexSetPushIndexVector2xAddNewBoardPiece_TriggerTraps_DestroyTrap         �   �    5   L @ d� b   @ �C   f  C � �@@ �� �   �	�̀@� �@ A@�$�   �����A $� F�@ G���d� ����F� MA� _����C    �F�@ G���d� @���F�� MA� _��@�C   � �E _@  �C   f  & �    HasDeadMark	BodyAreaGetAreatablecount       GetGridPosition       _fourAreaFixPos	       _nineAreaFixPos          5   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      e    5   moreAreaCanMove   5   	bodyArea	   5   area   3   gridPos   3      _ENVselfpos         L @ d� b@  � �L@@ d� b   � �L�@ d� [ � f  & �    HasTeamHasMonsterIDHasDeadMark                                        e           �  {   {   {   {   }   }   }               �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �         �                                                                                                     !  !  !  !  !  !  !  #  &  &  '  '  '  '  '  �   �   ,  ,  ,  ,  ,  -  -  1  1  1  1  2  2  2  2  4  4  5  5  5  5  5  6  6  8  8  8  8  :  :  ;  ;  =  =  =  =  B  B  B  B  E  E  F  F  H  H  H  H  H  H  H  J  J  J  J  J  J  L  O  O  O  R  R  S  S  S  S  S  S  V  V  V  V  W  W  W  W  Y  Y  Y  Y  Z  Z  Z  Z  Z  Z  ]  ]  ^  ^  ^  ^  ^  V  V  a  �   �   e  e  e  e  e  f  g  g  g  h  i  j  k  k  l  l  l  l  l  e  e  p  p  r  r  r  s  s  s  t  t  t  u  u  u  u  v  v  v  w  w  w  w  w  y  y  y  y  z  {  {  {  }  }  }  }  }  ~  ~  ~  ~  y  y  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  a   self    �  result    �  posList    �  
direction    �  isLast    �  	utilData   �  
boardCmpt   �  boardServiceLogic   �  toTriggerTraps   �  toDestroyTraps   �  (for generator)   r  (for state)   r  (for control)   r  _   p  pos   p  curPos   o  
targetPos   o  
pieceType   o  isValid   o  isPieceEffect   o  pieceEffectType   o  prismEntityID'   o  filter(   o  es,   o  (for generator)5     (for state)5     (for control)5     i6     e6     canMove7     
blockFlag9     	bodyArea:     gridPosE     targetPosListF     bodyAreaPosListG     (for generator)P   _   (for state)P   _   (for control)P   _   _Q   ]   areaQ   ]   workPosR   ]   areaPosX   ]   areaPosc   k   (for generator)r   �   (for state)r   �   (for control)r   �   _s   �   poss   �   curBlockFlag�   �   pets�   �   (for generator)�   �   (for state)�   �   (for control)�   �   i�   �   e�   �   targetEntity�     blockEntities�     gridPos    teamEntity  H  teamPos  H  utilDataSvc  H  pieceFillTable%  +  (for generator)W  o  (for state)W  o  (for control)W  o  iX  m  entityX  m  gridPosh  m  (for generator)v  �  (for state)v  �  (for control)v  �  iw  �  vw  �  oldPosx  �  newPos|  �  prismEntityID}  �  pieceEffectType~  �  boardPushCmpt�  �  	curIndex�  �  offsetVec2�  �  (for generator)�  �  (for state)�  �  (for control)�  �  i�  �  pos�  �  gridPos�  �  newPieceType�  �  (for generator)�  �  (for state)�  �  (for control)�  �  i�  �  v�  �  (for generator)�  �  (for state)�  �  (for control)�  �  i�  �  entity�  �     _ENV �  �      �$� "    �& � A@ �@��  $��LA�  �d� b  @��AA  �����L�� ����   L��d dC  �  jB�& �    
HasTrapID_worldGetService
TrapLogicCalcTrapTriggerSkillipairsAddTrapSkillResultGetID            �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       result       trapEntity       triggerEntity       trapServiceLogic	      triggerTraps      triggerResults      (for generator)      (for state)      (for control)      i      trap      skillResult         _ENV �  �   	   � @ �@�A�  䀀�@$� A�A �� $A � L���   dA L� �AB� dA  & � 
   _worldGetService
TrapLogicAttributesModifyHP        AddTrapDeadMarkAddTrapDestroyListGetID           �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       result       trapEntity       trapServiceLogic      disableDieSkill           �  �   }   � � �� �@@� �@ �@$� "A  @ � & �@ AA$� L�Ad� !@�@ �� � ��A�� �B� BB$� "   �L�� d� ��B �C �����BC� �B �C�� $��LD�C�d��������D��$��G�D��D� EE A �� $�� ����E F
G�NE�$� � 
@	�EE A �E $�� ����E F
G�NE$� � 
 �EE A� � $�� ����E F
GE�NE	$� � 
��EE AE � $�� �@��E F
GE�NE�$� � 
! �	 ��F �F
A ��	�E   $E� & �	!�
  ���	F�E G��� �B�d����� & �    GetSkillEffectParamGetTargetIndex_boardEntityHasBoardPush        
BoardPushGetPushIndexGetPushStepGetDirGetDisFromBoardEdgeGetCasterEntityID_worldGetEntityByIDGetGridPositionGetServiceUtilScopeCalcGetMinMaxGridYByGridXxminmaxyVector2       mathabs��������Logerror7[PushBoard] Distance between caster and board edge is , expect =          }   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    }   skillEffectCalcParam    }   skillEffectParam   }   targetIndex   }   boardPushComponent   }   	curIndex   }   	pushStep   }   pushDir   }   disFromBoardEdge   }   	casterID   u   caster"   u   
casterPos$   u   
utilScope(   u   dataY+   u   minY,   u   maxY-   u   dataX0   u   minX1   u   maxX2   u   tempDis3   u      _ENV                                 ;      =   J   =   L   u   L   y   �  y   �  �  �  �  �  �  �  �  �  �         _ENV