LuaS �

xV           (w@�@C:/depot_matchsrpg/matchsrpg/b/170/client/Assets/../PublishResources/lua/product/core_game/logic/helper/ai/action_move_back_attack.lua             @ A@  $@ �@ A�  � A $@��@  ���@ l   
@���@ l@  
@ ��A l�  
@ ��A l�  
@���A l  
@ ��A l@ 
@��& �    requireaction_move_base_classActionMoveBackAttackActionMoveBaseConstructorResetActionMoveBackAttackInitTargetPosListComputeSkillRangeFindNewTargetPos_IsPosInList        
          F@@ L�� ��@ � �AA �Ad� 
@ �G @ L�� d@ F@@ L�� ��@ � �AA ABd� 
@ �G B L�� d@ & � 
   m_posListNearSelfSortedArrayNew
AlgorithmCOMPARE_CUSTOMAiSortByDistance_ComparerByNearAllowDuplicatem_posListMoveAttack_ComparerByFar                                                                                    self          _ENV           F @ G@� G�� �   d@ G�@ L � d@ G@A L � d@ & �    ActionMoveBackAttacksuperResetm_posListNearSelfClearm_posListMoveAttack                                                   self          _ENV    D    #e   � @ �@�� ǀ�@ A@$� �@LA �A d���@ ��A�� ��A��  �  �& � �@ �A�� ��$� L�B ��  C� d���C �BC�B ��C �BC�B ��C �� ����D @�� �   � A �D $��"D    � AD ���D hD
�G���D  �
�����   ����   ��D � ��
$� � E FEGC ����
  
$F��  ���   �F \��F (��ǆL�Ed� @����E �GEǇC   @����G�'��g���  *��& �    m_entityOwnGridLocation	Position
DirectionGetLogicData       	BodyAreaGetArea        AIGetMobilityValidComputeWalkRangem_posListNearSelfClearm_posListMoveAttackipairsComputeSkillRange��������IsPosAccessibleIsPosConnected
AINewNodeInsertSortedArrayGetPos         e                                                        !   !   "   %   %   %   &   &   '   '   '   '   '   *   *   *   +   +   +   ,   ,   ,   ,   -   -   -   -   -   -   /   /   /   /   /   /   0   0   0   0   1   2   2   2   3   4   4   4   4   5   5   5   5   5   7   7   7   7   7   7   7   8   8   8   8   9   9   9   9   ;   <   <   =   =   >   >   >   >   >   >   >   9   0   ,   ,   D      self    e   listPosTarget    e   targetEntityPosCenter    e   posSelf   e   dirSelf   e   	nSkillID   e   	bodyArea   e   aiComponent   e   nWalkTotal   e   
walkRange   e   (for generator)&   d   (for state)&   d   (for control)&   d   key'   b   
targetPos'   b   skillRange-   b   bCheckObstacle3   b   (for index)6   b   (for limit)6   b   (for step)6   b   i7   a   
posAttack8   a   
bValidPos;   a   bValidAttackPos<   a   (for index)S   a   (for limit)S   a   (for step)S   a   jT   `   posDataU   `   posWalkW   `      _ENV F   Z    P   G@ LA���  d����� � ����A� BA �A ����A �� �  �FB �C �� d�$�  L�A ��   @��B �C � ��d�  ��A  � @ ���B � AD ����  ��A @� � ��B A� �D $��    FC GC�� � dC�FC GC�� ��dC�FC GC�� � dC�FC GC�� ��dC�& ���A �� �  �@ % &  & �    _worldGetServiceConfigGetSkillConfigDataGetSkillScopeTypeSkillScopeTypeDirectLineExpand_ComputeSkillRangeVector2               ��������tableappendArray         P   H   H   H   H   J   J   J   K   K   L   L   L   L   M   M   M   M   M   M   M   M   M   N   N   N   N   N   N   N   N   N   O   O   O   O   O   O   O   O   O   P   P   P   P   P   P   P   P   P   Q   R   R   R   R   R   S   S   S   S   S   T   T   T   T   T   U   U   U   U   U   V   V   X   X   X   X   X   X   X   Z      self    P   skillID    P   
centerPos    P   	bodyArea    P   dir    P   configService   P   skillConfigData   P   
scopeType	   P   ret1   G   ret2   G   ret3(   G   ret41   G   ret2   G      _ENV ]   x    =   G @ L@� d� ��� �� � @ ���� � �  GAA b  @�GAA L��d�  @�� �GAA L��A d����_ ����LC �A �CA� �D�B dA�& L�D ��D   D  d�� �_ ����LC � �CA� �D�B dA�& LA� d�  �LC �� �CA� �D�B dA�& & �    m_entityOwnAIGetTargetPosCenterGridLocation	Positionm_posListMoveAttackSize        GetAt       data 	PrintLog5选择可以到达的有效进攻出发点，坐标(x,y)FindPosValidAndConnectedm_posListNearSelf;选择距离自己最近的有效进攻出发点，坐标(GetTargetPos2没有有效进攻出发点，选择玩家坐标(        =   _   _   _   `   `   a   a   a   a   b   d   d   d   d   d   d   d   d   g   g   g   g   h   j   j   k   k   k   k   k   k   k   l   o   o   o   o   o   o   p   p   q   q   q   q   q   q   q   r   u   u   u   v   v   v   v   v   v   v   w   x      self    =   aiComponent   =   
posTarget   =   posSelf	   =   
posReturn
   =   aiSortByDistance           |   �    	   � @ �@�  � �  @���  (�� � @ �� & 'A�  & & �    tablecount                   }   }   }   }   ~   ~   ~   ~            �   �   ~   �   �   �      self       posWork       posList       nListCount      (for index)      (for limit)      (for step)      i         _ENV                              
      
               D      F   Z   F   ]   x   ]   |   �   |   �          _ENV