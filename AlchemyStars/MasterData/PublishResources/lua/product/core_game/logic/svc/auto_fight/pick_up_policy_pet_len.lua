LuaS �

xV           (w@[@../PublishResources/lua/product/core_game/logic/svc/auto_fight/pick_up_policy_pet_len.lua             @ A@  $@ �@ A�  � A $@��@  ���@ l   
@���@ l@  
@ �& �    requirepick_up_policy_base_classPickUpPolicy_PetLenPickUpPolicy_BaseCalcAutoFightPickUpPolicy_CalPickPosPolicy_PetLen                  � � �@� �� L�@d� G��  �    LBA �  �d� ̂A @ � �B��  @�� ��& �    
petEntityactiveSkillIDpolicyParamGridLocation	Position_CalcPickUpValidGridList_CalPickPosPolicy_PetLen           	   
                                                                     self       
calcParam       
petEntity      activeSkillID      policyParam      
casterPos      pickPosList      attackPosList      targetIdList	      validPosIdxList      validPosList      pickPosList      atkPosList      
targetIds      extraParam              �    4|  �     K  �  �    K  �B@ ��@C@ �@A����B@ �B�� CA �A ����  �A$� B$� CB$� �B$ �B  ���B@ ���A 䂀C�$� F�C � d ��� ���� �  ����� �D�	F�D G��
䄀��	��� �D   
��  �	��D�� ̄�	� ��$� F
$� LE�d� ����� �  �C @ 
$@�M�
��F �G�  �����G  @��GG ��G���� J��� )�  ����  � � ��@ ���	 �i�  ��"B  @�F�G G��CH �� dC�@�� ��  f�L�Fd� ��G �H�CH � @��C �CF�� ��F ��  @ 䃀�  �	�� �E$� F$� K  ��C � � �ͅ��F G@ ��$��"F   ��F I@���$F���  *��� ������F �DI	��,  �D���� ����  �@ ���C@ ���A 䃀  A  ��	 �� �	 �D ��E� ͅ�
�Ņ JGFJ���ƅGG �J@ ��$��L��� d��b   �LK �   d� bG  ��M��K J��J@�JG��J�J���JG�Jǆ��  J���GM ��M�   ����GM ���  @ 䇀HM �M@���$��FHM G������d��� ���	 �H��	 �	��	 �	��JG ��J�
� �����
�@ �KN ��N� K@ KA$� FKA G��@ ��A$� B$� KB$� �B$� LKFd� �� �K  ��F� kK  �
��C @�$ �F�F G����� d��bL   �F�F G���� dL�@� �GL�M��JG��� �G��M��JG�)�  ���I�����F �I�  	��H�����F �DI	� ,E  �D���I�DG Ǆ�	L	G�L	䄀EG �J
GEL	��L	$��FEM G��
��	�J
d���EM ��M��	J
����EM ǅ�F�	GFJ
䅀FM �MGF�	�FJ
$��@�
� ��	 h��@�� ��	 h��FHG G��� � d����� 	�����   ���F �I�  	��H�g��g��K ��	� 
kF � �M	  f�& � <           _worldGetGroupEntitiesBW_WEMatchers
MonsterID
MatchTypeMT_BlackFistPetGetOwnerTeamEntityTeamGetEnemyTeamEntityGetService	UtilDataGetExtraBoardPosListipairsHasBuffBuffComponentHasBuffEffectBuffEffectTypeNotBeSelectedAsSkillTargetHasDeadMarkAttributesGetCurrentHP	BodyAreaGetAreaGetGridPositionGetIDtableintableVector2
Pos2IndexLogdebug_className%自动主动技释放：场上没怪.自动主动技释放：必然包含目标：insertsort              xyNewIsValidPiecePos_IsPosInExtraBoardgreatestHPValEntityCountotherMonsterEntityCountindexx1x2y1y2
targetIDsmathminmaxFindEntityByPosAndTypeEnumTargetEntityMonster
icontains         e   k       � @ � � _� ��� @ � � `�   ��@  � � �  ���@@ �@� `�   ��@  � � �  & �    xy           f   f   f   f   g   g   g   g   g   g   g   g   i   i   i   i   i   i   i   k      a       b            �   �        � @ � � _� ��� @ � � `��  ��@  � � �  ���@@ �@� _� ���@@ �@� `��  ��@  � � �  ����@ ǀ� `�   ��@  � � �  & �    greatestHPValEntityCountotherMonsterEntityCountindex            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      a        b            |               "   $   %   '   '   '   '   '   '   (   (   (   (   (   (   (   )   )   )   )   )   )   )   )   )   )   )   -   -   -   -   .   .   /   /   /   /   0   1   1   1   1   2   2   2   2   2   2   2   4   4   4   4   4   4   5   5   5   5   6   6   6   6   7   7   8   8   9   :   :   :   :   <   =   =   =   =   =   =   =   >   >   >   >   ?   @   :   :   D   D   E   E   F   G   /   /   M   M   N   N   N   N   N   O   O   O   O   O   R   R   S   S   S   S   S   S   U   U   V   V   V   V   V   V   V   X   Y   Y   Y   Y   Z   [   [   [   [   ]   ^   ^   ^   ^   ^   ^   ^   _   _   _   _   _   [   [   c   c   c   d   d   d   k   d   m   m   o   o   o   o   o   t   t   t   t   u   v   x   x   x   x   y   z   z   {   |   }   ~                  �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   x   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   ]   self    |  policyParam    |  
petEntity    |  pickPosList   |  atkPosList   |  
targetIds   |  extraParam   |  greatestHPVal   |  greatestHPValEntity   |  posIndexEntityIDDic   |  monsterGlobalEntityGroup   |  	utilData#   |  extraBoardPosRange%   |  (for generator)(   d   (for state)(   d   (for control)(   d   _)   b   e)   b   isSelectable*   b   hp?   b   tv2BodyAreaC   b   
v2GridPosE   b   eidG   b   hasValidBodyPosH   b   (for generator)K   \   (for state)K   \   (for control)K   \   _L   Z   v2RelativeL   Z   v2M   Z   indexX   Z   greatestHPValEntityIDr   |  greatestHPValGridPosz   |  
v2GridPos�   �   tv2BodyArea�   �   
validList�   �   (for generator)�   �   (for state)�   �   (for control)�   �   _�   �   v2Relative�   �   v2�   �   	utilData�   |  testResult�   |  resultIndex�   |  (for index)�   6  (for limit)�   6  (for step)�   6  i�   5  policyXOffset�   5  policyYOffset�   5  	gridPosX�   5  	gridPosY�   5  gridPosOffsetX�   5  gridPosOffsetY�   5  	pickPos2�   5  result�   5  minX�   5  maxX�   5  minY�   5  maxY�   5  (for index)�   0  (for limit)�   0  (for step)�   0  x�   /  (for index)�   /  (for limit)�   /  (for step)�   /  y�   .  v2�   .  tMonsterList�   .  eTeam
    (for generator)  .  (for state)  .  (for control)  .  _  ,  eid  ,  finalResult<  |  	pickPosAA  |  	pickPosBF  |  minXK  |  maxXP  |  minYU  |  maxYZ  |  (for index)]  s  (for limit)]  s  (for step)]  s  x^  r  (for index)a  r  (for limit)a  r  (for step)a  r  yb  q  v2g  q     _ENV                                          �      �          _ENV