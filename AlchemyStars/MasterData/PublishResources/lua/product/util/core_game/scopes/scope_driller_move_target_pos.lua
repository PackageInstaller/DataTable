LuaS �

xV           (w@Y@../PublishResources/lua/product/util/core_game/scopes/scope_driller_move_target_pos.lua             @ A@  $@ �@ A�  � A $@��@  ���@ l   
@���@ l@  
@ ��@ l�  
@���@ l�  
@ ��@ l  
@��& � 
   requirescope_base_class*SkillScopeCalculator_DrillerMoveTargetPosSkillScopeCalculator_Base
CalcRange_CheckPosHasTrap_CalcAreasTrapCount_FindMinTrapAreas_CalcTarPosInMinAreas        	   3   	 j   G@ GB�G����� ������AC 䂀���� $��G�A�  ��� 
�
Å
�
C�
ć
ĈK� J�JÅJ�ĆJ�D�JćJň�� ���Å�Dņ��E��ć��ň˄ ʄĄ��ąʄ�C��Ň�Ĉ� 
�Ą
�ą
�Ć
�D�
Ň
ňK� J�ĄJ�ąJEņJ�E�JŇJ�ň�� �Eń��Ņ���C���Ň�Ĉ˅ �EńʅŅʅĆ��D���Ň�ň� 
Fń
�Ņ
Fņ
�E�
�Ň
�ň�C�
���F @���� DF ��$��L�F �  �d� ��F �G	�  ��D��DG ��G	�G H
@�� � �� � & � !   _hub_gridFilter_worldGetServiceUtilScopeCalc	UtilDataRandomLogictrapIDList_areasmin_x       max_x       min_ymax_y	center_x       	center_y                            	              _CalcAreasTrapCount_FindMinTrapAreas_CalcTarPosInMinAreastableinsertSkillScopeResultNewSkillScopeTypeDrillerMoveTargetPos         j                                             !   !   "   "   "   "   "   "   "   #   #   #   #   #   #   #   $   $   $   $   $   $   $   %   %   %   %   %   %   %   &   &   &   &   &   &   &   '   '   '   '   '   '   '   (   (   (   (   (   (   (   )   )   )   )   )   )   )   *   *   *   *   *   *   +   +   ,   ,   ,   ,   -   -   -   .   .   .   .   /   /   /   /   /   1   1   1   1   1   1   1   1   2   3      self    j   
scopeType    j   scopeParam    j   
centerPos    j   	bodyArea    j   
casterDir    j   nTargetType    j   
casterPos    j   casterEntity    j   world   j   utilScopeSvc   j   	utilData	   j   
randomSvc   j   trapIDList   j   resultPosList   j   areaTrapCountT   j   	minAreasW   j   tarPos[   j   resulth   j      _ENV 4   B    #   �   @ A@L�@��  d���� � ����AA   �@���$� "  @�L��d� bC  @�FB GC�� ̃B� d�  b  @ �� � @ ��  j���  & �    _gridFilter_worldGetService	UtilDataGetTrapsAtPosipairsTrapHasDeadMarktable
icontains
GetTrapID         #   5   6   6   8   8   8   9   9   9   :   :   :   :   ;   ;   <   <   <   <   <   <   <   <   <   <   <   <   <   <   =   =   :   :   A   B      self    #   pos    #   trapIDList    #   
bFindTrap   #   world   #   utilSvc   #   array	   #   (for generator)   !   (for state)   !   (for control)   !   _      eTrap      cTrap         _ENV C   X    5   �   @ GA@ $�
�A�  ��@�A!������@�BA!�����A��A!��� ���A�Ba�  ��B  �� �B   ��ACAAC ����ABAD �C�̄B F�B � � 	d���� � �    �MB������  �A �@�)�  �A��  & �    ipairs_areas        xmin_xmax_xymin_ymax_y       _CheckPosHasTrapVector2��������         5   D   E   E   E   E   F   G   G   G   G   G   G   G   G   H   H   H   H   H   H   H   H   H   H   I   I   J   J   J   J   K   K   K   K   L   L   L   L   L   L   L   M   M   N   K   J   Q   S   U   E   E   W   X      self    5   trapIDList    5   
casterPos    5   areaTrapCount   5   (for generator)   3   (for state)   3   (for control)   3   
areaIndex   1   	areaInfo   1   
trapCount   1   isCasterInArea   1   (for index)   .   (for limit)   .   (for step)   .   posX   -   (for index)!   -   (for limit)!   -   (for step)!   -   posY"   ,   hasTrap)   ,      _ENV Y   g       �   �   A@ @� $ �! ��� � @�K� ��kB� � ��  ���  �F�@ G�����dB�)�  ���  & �    �      ipairs        tableinsert            Z   [   \   \   \   \   ]   ]   ^   ^   _   _   _   _   `   `   a   a   b   b   b   b   b   \   \   f   g   	   self       areaTrapCount       minTrapCount      	minAreas      (for generator)      (for state)      (for control)      
areaIndex      
trapCount         _ENV h   |    (   �  �   �@�A  A�  �  ��@  � ���A �FCA ��A��Ad���B �CBǃ��B���� �B �C���G�BD� ��  � �  @����  jB��  �  & �            �      ��������ipairs_areasVector2	center_x	center_ymathabsxy         (   i   j   j   j   l   m   n   o   o   o   o   p   p   q   q   q   q   r   r   r   r   r   r   r   r   r   r   r   r   r   s   s   t   u   v   o   o   y   {   |      self    (   	minAreas    (   
casterPos    (   tarPos   (   minDis   &   nearestAreaIndex   &   nearestAreaCenter   &   (for generator)
   %   (for state)
   %   (for control)
   %   index   #   
areaIndex   #   	areaInfo   #   areaCenter   #   	crossDis   #      _ENV                              	   3   	   4   B   4   C   X   C   Y   g   Y   h   |   h   |          _ENV