LuaS �

xV           (w@K@../PublishResources/lua/product/util/core_game/skill_scope_calculator.lua         L    @ A@  $@ �@ A�  � A $@��@  ���@ l   
@���@ l@  
@ ��@ l�  
@���@ l�  
@ ��@ l  
@���@ l@ 
@ ��@ l� 
@���@ l� 
@ ��@ l  
@���@ l@ 
@ ��@ l� 
@���@ l� 
@ ��@ l  
@���@ l@ 
@ ��@ l� 
@���@ l� 
@ ��@ l  
@���@ l@ 
@ ��@ l� 
@���@ l� 
@ ��@ l  
@���@ l@ 
@ �& �    requireskill_scope_filter_pass_param_classSkillScopeCalculatorObjectConstructorCalcSkillPreviewScopeCalcSkillEffectScopeCalcSkillScope#CalcSkillScopeForChainSkillPreviewCalcSkillScopeWithParamsComputeScopeRange_InsertPosToResultArea_InsertTargetGrid_InsertTargetGridIntoOneArea_CopyTable_GetAroundPosOfPos_CalcDirectLineExpandCalcMultiCenterCrossList!_CalcLeftDownColumnsAndRowsRangeGetDirection_ComputeHalfStartPos_CalcCrossExceptBlock!_CalcCrossExceptBlock_checkBlock_CalcXShapeExceptBlock"_CalcNRowMColSpread_IsGridBlocked_CalcNRowMColSpread                  
@@�@�  ���@ ��@�� 
� �  �
@ ��@A ��@�� 
� ���A �@ & �    _gridFilter SkillScopeDefaultFilterNew_scopeFilterDeviceSkillScopeFilterDeviceRegistSkillScopeCalculator                                                               self       gridFilter          _ENV #   S    0   �@�� �A@� �@$� L�@d� �A �BA  @� ���� ���A � ��  @�� �� � @�$� GA G��b  ��FB LC���  �C ��À�A �A��d���CC ��C  L�Cd� ���C�& & �    GetScopeTypeGetScopeParamDataGetScopeCenterTypeGetScopeTargetType_gridFilter CalcPreviewCenterPosAndBodyAreaComputeScopeRange_worldSkillScopeFilterPassParamNew
casterPoscasterBodyAreaArrayworld_scopeFilterDevice	DoFilterGetScopeFilterParam         0   *   *   +   +   ,   ,   -   -   1   1   2   3   4   5   7   1   :   ;   <   =   >   ?   @   A   C   :   E   E   E   E   G   G   G   I   J   K   K   K   G   O   O   O   O   O   O   O   R   S      self    0   
casterPos    0   
casterDir    0   casterBodyArea    0   skillPreviewScopeParam    0   casterEntity    0   
scopeType   0   scopeParam   0   centerType   0   targetType   0   
centerPos   0   	bodyArea   0   result   0   filterPassParam'   .      _ENV Z       0   �@�� �A@� �@$� L�@d� �A �BA  @� ���� ���A � ��  @�� �� � @�$� GA G��b  ��FB LC���  �C ��À�A �A��d���CC ��C  L�Cd� ���C�& & �    GetSkillEffectScopeTypeGetSkillEffectScopeParamGetSkillEffectScopeCenterTypeGetSkillEffectTargetType_gridFilterCalcCenterPosAndBodyAreaComputeScopeRange_worldSkillScopeFilterPassParamNew
casterPoscasterBodyAreaArrayworld_scopeFilterDevice	DoFilterGetScopeFilterParam         0   \   \   ]   ]   ^   ^   _   _   c   c   c   c   c   c   c   c   f   g   h   i   j   k   l   m   o   f   q   q   q   q   s   s   s   u   v   w   w   w   s   {   {   {   {   {   {   {   ~         self    0   
casterPos    0   
casterDir    0   casterBodyArea    0   skillEffectParam    0   casterEntity    0   
scopeType   0   scopeParam   0   centerType   0   targetType   0   
centerPos   0   	bodyArea   0   result   0   filterPassParam'   .      _ENV �   �       �� �� �A� � �� $� L�� d� �� �� �BA @ ���  �@ � ��  @����  & �    GetSkillScopeTypeGetSkillScopeParamGetSkillScopeCenterTypeGetSkillTargetTypeGetScopeFilterParamCalcSkillScopeWithParams           �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       skillConfigData       playerGridPos       
casterDir       playerBodyArea       casterEntity       
scopeType      scopeParam      centerType      nTargetType      scopeFilterParam
           �   �    P   � $� LA� d� ��� �� ��� � � $� LB� d� ����� ���� ��� �   ��C�$� "  �
���$� �B� � ��$��"  @�FCC � d� ����K  ��C � �  �J����  *��D � �� ��D�̈́�	JÄ��  *����@�FCC � d� @� �G�DbC    �A� �AE ���  �@ ���   @���%�&  & �    GetIDGetSkillScopeTypeGetSkillScopeParamGetSkillScopeCenterTypeGetSkillTargetTypeGetScopeFilterParamGetGridDirection	BodyAreaGetAreaHasBuffBuffComponentGetBuffValue$ChainSkillPreviewScopeParamAppendertypetablepairsipairsnumber               CalcSkillScopeWithParams         P   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    P   skillConfigData    P   playerGridPos    P   casterEntity    P   skillID   P   
scopeType   P   scopeParam   P   centerType   P   nTargetType
   P   scopeFilterParam   P   
casterDir   P   playerBodyArea   P   scopeParamAppender   C   copyScopeParam'   8   (for generator)*   .   (for state)*   .   (for control)*   .   k+   ,   v+   ,   (for generator)1   7   (for state)1   7   (for control)1   7   index2   5   val2   5   
appendValB   C      _ENV �   �   
 &   �@ �B@ �@ � � �� �@ �� �   @����   @�$� G@ G��b  ��FA LC���  ʃ����@ �@��d���CB ��B  @����C�& & �    _gridFilterCalcCenterPosAndBodyAreaComputeScopeRange_worldSkillScopeFilterPassParamNew
casterPoscasterBodyAreaArrayworld_scopeFilterDevice	DoFilter         &   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    &   
scopeType    &   scopeParam    &   centerType    &   nTargetType    &   scopeFilterParam    &   playerGridPos    &   
casterDir    &   playerBodyArea    &   casterEntity    &   
centerPos   &   	bodyArea   &   result   &   filterPassParam   $      _ENV �   �   	 +   G@ GB�b  @�G@ GB�L���� d��@ �G�@ GB��A �BA_�� @ �bB   ���A ��A�  � �B��BB ��BA CA@��� � �  ��� � @ ���  �@ ��� �� � & �    _gridFilter_worldReplaceSkillScopeType_calculatorDicSkillScopeTypeNoneLog
exceptionNo ScopeCalculator ScopeType:SkillScopeResultNew
CalcRange         +   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    +   
scopeType    +   scopeParam    +   
centerPos    +   	bodyArea    +   
casterDir    +   nTargetType    +   
casterPos    +   casterEntity    +   calculator   +   result)   +      _ENV         � @ �@�@� 䀀�   ���� �@� �K   �G�� � �G�� GA�� JA & �    _gridFilterIsValidPiecePosx y                                   	  	               self       pos       resultArea       isValid      array                   @ A@� $��"  @�F�@ G���� � d��bA  � ��� �AJ� �   @�F�@ G����� d��bA  � ����Aʀ & �    _gridFilterIsValidPiecePostable
icontains                                                                                self       targetArea       newGridPos       
wholeArea       isValid      contain      contain         _ENV !  &      � @ �@�  @� 䀀�@  � � �@�@ & �    table
icontains                   "  "  "  "  "  #  #  $  $  $  &     self       newGridPos       area       contain         _ENV )  0      _� �@ �@ �  �& � �@@   �  ��@ �@@� ��$B��  j�& �     pairstableinsert            *  *  *  *  +  -  -  -  -  .  .  .  .  .  -  -  0     self       tableA       tableB       (for generator)      (for state)      (for control)      key	      value	         _ENV 2  <      �    @ �  (A� @ �  (�@�@ �_@� ��@ �@@��A �� ������� $C�'B�'��  & �                   tableinsertVector2            3  4  4  4  4  5  5  5  5  6  6  6  6  7  7  7  7  7  7  7  7  7  5  4  ;  <     self       pos       n       arrPos      (for index)      (for limit)      (for step)      i      (for index)      (for limit)      (for step)      j	         _ENV >  �   "�   ���A    ��A  �  �@ @ $ �F�@ �A�CAd����A ��A�� ��C�)�  ���GB�_@@ ��B �BB� �� �_@� ��B �BB���� R����@ ��  �����@ �Y 䂀�@ @ $ �A� � �� h��OME������B �� �@�
䅀�E   �ƅA ��� �@�
�E���B �� �@ 䅀�E   �ƅA ��� �@ �E�g��)�  ��  F�@ ��d����@ ��E������B ��	 �M� 	䄀�D   �ƄA ���	  @ 	�D�i�  �C�K  ��@ � ���ƄA ���	 �F�@ �� �A	���E� FA	��d��D  ��  *D��  �  D�"D    �D  G��bD    �AD  ��@ ���@��AFAA� � �� h��MG��@ �G�ǇH����ƇA ��� �@ �G�ǇC ���@ 䇀�   �ƇA ���  @ �G�g����  *���D �DD	�D �D
@� � ���� � & �                   ipairsVector2xytableinsertmathabs       BodyAreaHelperIsPosInBodyArea       _gridFilterIsValidPiecePosSkillScopeResultNewSkillScopeTypeDirectLineExpand         �   ?  ?  ?  ?  @  A  A  A  A  B  B  B  B  C  C  C  C  C  A  A  F  G  H  H  I  I  I  I  I  K  K  L  L  L  L  L  O  O  O  O  O  O  O  O  P  P  P  P  Q  Q  Q  Q  R  R  S  S  T  T  T  T  T  T  T  U  U  U  U  U  W  W  W  W  W  W  W  X  X  X  X  X  Q  P  P  \  ]  ]  ]  ]  ^  ^  ^  ^  _  _  _  _  _  _  _  `  `  `  `  `  ]  ]  c  d  d  d  d  e  e  e  e  e  e  e  e  e  e  e  e  d  d  i  j  k  k  k  k  l  l  l  l  m  m  m  m  n  o  p  p  p  p  q  r  r  r  r  r  r  s  s  s  s  s  t  t  t  t  t  t  u  u  u  u  u  p  m  m  ~  ~  ~  ~  ~  ~  ~  ~    �  <   self    �   
casterPos    �   bodyAreaArray    �   
casterDir    �   effectDirType    �   param    �   expandWidth   �   expandArea   �   (for generator)      (for state)      (for control)      i	      v	      p      casterDirX   �   casterDirY   �   
vertical1,   �   
vertical2,   �   (for generator)/   S   (for state)/   S   (for control)/   S   i0   Q   p0   Q   (for index)3   Q   (for limit)3   Q   (for step)3   Q   i4   P   l6   P   r8   P   exceptBackT   �   (for generator)W   j   (for state)W   j   (for control)W   j   iX   h   vX   h   p\   h   absAreak   �   (for generator)n   }   (for state)n   }   (for control)n   }   io   {   po   {   cross_area~   �   
wholeArea   �   size�   �   offset�   �   (for generator)�   �   (for state)�   �   (for control)�   �   i�   �   p�   �   	center_x�   �   	center_y�   �   (for index)�   �   (for limit)�   �   (for step)�   �   index�   �   
offsetIdx�   �   
directpos�   �   result�   �      _ENV �  �   j   � @   �   K  �A� ǁ� �  @���  (��A @ �Â$��FA � �Âd���A �� �����A �@�䃀DA �A@�� $D�DA �A@���$D�DA �A@�� $D�DA �A@���$D��A B� $��"   �DA �A@ � $D��A B��$��"   �DA �A@ ��$D��A B��$��"   �DA �A@ ��$D��A B� $��"   �DA �A@ � $D�'��BA �A@ �� $B�BA �A@��� $B�  @�&�& � 	   	tonumberxy       Vector2tableinsert_gridFilterIsValidPiecePos         j   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    j   
centerPos    j   scopeParam    j   size   j   cross_area   j   
wholeArea   j   	center_x   j   	center_y   j   (for index)
   \   (for limit)
   \   (for step)
   \   index   [   upPos   [   downPos   [   leftPos   [   	rightPos   [      _ENV �  �   !     A  �A@�A  h�A  �B��B  h��F�@ ��� ��� ��d���CA ��A �����C  � ��  �  ���A �B�  ��C�g��gA�& & � 	                  Vector2xy_gridFilterIsValidPiecePostableinsert         !   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    !   leftDownPos    !   columns    !   rows    !   retGridPosList   !   (for index)      (for limit)      (for step)      y      (for index)      (for limit)      (for step)      x	      gridPos         _ENV �  �   U   ΀� �@@����!�@� �A AA&  ��@@����! �� �A �A& ����@@���! �� �A B&  ���@@���!�@� �A AB& �
���! ����!�@� �A �B&  ���! ����! �� �A �B& ����!�@���! �� �A C&  ���!�@���!�@� �A AC& � �A �C& & �    x        y��������HitBackDirectionTypeDown       UpRightLeftLeftUpRightUp
RightDown	LeftDownNone         U   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    U   gridpos    U   
casterPos    U   deltal   U      _ENV �  �      �@� � � �� � �@@��@�  � ���� �  �@@�  �   �  & �                                     �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       nData            �  +   6�   K  �  �  �G� �B� �B    ���  ��� �B    ���    FA � d@��D��DA Ǆ�	  @ 	�D�i�  ���G�A L�d� �  �� @ ���A �CB�� @ ��A ��B��B�� �C�� �CC� DA �C@���$D��A � �����C	D	C  �  �    C  �  �    @����� �A  ���  "  � �@��  �H  	�@	 �	�(���D @
�	��	
$��F�D �
�	��	
d����D �ʉ	  
���ƊD ˉ	@ 
䊀�D � ��
 �@����  �@ $@ @�@ �D � �   @ ���� �@ $� ��� �D � �� �@����  �@ $� ��� �D � �   @ ���� �@ $   �  '����  *����� ��& �                                 ipairstableinsert_gridFilterGetBlockGridTrapPosListGetBlockMovePosList_worldPlayerGetCurrentTeamEntityGetGridPositionremovevxy��������Vector2!_CalcCrossExceptBlock_checkBlock         �   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �                        	                                                                      !  !  !  !  #  #  #  #  #  #  #  #  #  #  #  #  #  $  $  $  $  $  $  $  $  $  $  $  $  $  %  %  %  %  %  %  %  %  %  %  %  %  %  &  &  &  &  &  &  &  &  &  &  &  &  &          *  *  *  +  4   self    �   scopeParam    �   
centerPos    �   	bodyArea    �   	bReverse    �   cross_area   �   
wholeArea   �   
casterPos   �   bodyAreaArray   �   size   �   blockMonsterMove	   �   ignoreCount   �   target_area_grid   �   (for generator)      (for state)      (for control)      i      p      
targetPos      blockGridTrapPosList   �   teamLeader+   2   teamPos-   2   (for generator)5   �   (for state)5   �   (for control)5   �   i6   �   p6   �   	center_x7   �   	center_y8   �   
upBlocked9   �   downBlocked:   �   leftBlocked;   �   rightBlocked<   �   
upFindOne=   �   downFindOne>   �   leftFindOne?   �   rightFindOne@   �   upIgnoreCountA   �   downIgnoreCountB   �   leftIgnoreCountC   �   rightIgnoreCountD   �   startIndexE   �   finalIndexF   �   	moveStepG   �   (for index)O   �   (for limit)O   �   (for step)O   �   indexP   �   upPosT   �   downPosX   �   leftPos\   �   	rightPos`   �      _ENV ,  T  	 >   �@  ��F@ GB���� d��bB  ��\���@  �@ � �B��� ���	��  	� �����b   ��"   �� ���@�� � � �� ���  �� � L�@ ��  @ dB���b   � �"  � �� �   �� � LBA �   dB � �LBA �   dB @ ��� f & �    table
icontains_InsertTargetGrid               _InsertTargetGridIntoOneArea         >   -  -  .  .  .  .  .  .  .  /  0  0  0  0  0  1  2  2  3  4  6  6  7  7  8  8  9  :  :  ;  =  ?  @  @  A  D  D  D  D  D  D  F  F  G  G  H  I  K  M  M  M  M  O  Q  Q  Q  Q  S  S  S  S  T     self    >   	bReverse    >   curBlocked    >   ignoreCount    >   curDirFindOne    >   blockGridTrapPosList    >   	checkPos    >   cross_area    >   
wholeArea    >   countBefore
      	countEnd         _ENV U  �   7�   K  �  �  �G� �B� �B    ���  ��� �B    ���  � "C    ��  K  �CA � �@�̈́��A �A
@���	$E���  *���B �CB�� �  �� @ ��B ̃�� ���B ������ �C�� ��$� F�A G��� � dD��CA  �� ��	GE�	�  �    C  �  �    C  ���� �@��  ��	  "  � ����  � @	 �	��	 h��F�D �


�
�
d����D �


�
�����D 

N�
䊀�D M

��
$��LE �   @ � �  �@�� d��� ��LE �  �@����   @�� d��� ��LE �   @ � �  �@�� d �   �LE �  �@����   @�� d@�@ @�g�� @��G	B LI��	�d��b	  @�F�A G���	��	�dI�F�A G���	 �	�dI��  j���  ��& �                                        ipairstableinsert_gridFilterGetBlockGridTrapPosListGetBlockMovePosList_worldPlayerGetCurrentTeamEntityGetGridPositionremovevxy��������Vector2!_CalcCrossExceptBlock_checkBlockIsValidPiecePos         �   V  W  Z  [  \  ]  ]  ]  ]  ^  ^  ^  ^  _  _  _  _  a  b  b  b  b  c  d  d  d  d  d  b  b  g  g  g  i  i  i  i  j  j  j  j  l  l  l  l  l  l  m  m  n  n  n  n  n  q  q  q  q  s  u  w  x  y  z  |  }  ~    �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  q  q  �  �  �  �  5   self    �   scopeParam    �   
centerPos    �   	bodyArea    �   	bReverse    �   cross_area   �   
wholeArea   �   
casterPos   �   bodyAreaArray   �   size   �   blockMonsterMove	   �   ignoreCount   �   selectCenter   �   target_area_grid   �   (for generator)      (for state)      (for control)      i      p      
targetPos      blockGridTrapPosList!   �   teamLeader/   6   teamPos1   6   (for generator)9   �   (for state)9   �   (for control)9   �   i:   �   p:   �   	center_x;   �   	center_y<   �   leftUpBlocked=   �   rightUpBlocked>   �   leftDownBlocked?   �   rightDownBlocked@   �   leftUpFindOneA   �   rightUpFindOneB   �   leftDownFindOneC   �   rightDownFindOneD   �   leftUpIgnoreCountE   �   rightUpIgnoreCountF   �   leftDownIgnoreCountG   �   rightDownIgnoreCountH   �   startIndexI   �   finalIndexJ   �   	moveStepK   �   (for index)S   �   (for limit)S   �   (for step)S   �   indexT   �   
leftUpPosX   �   rightUpPos\   �   leftDownPos`   �   rightDownPosd   �      _ENV �  �   W   F@ GA��@ ��@�@ ���@ AN�� �BA �����ǃA ���@ 䃀�   �΃� �N� ��@	 �@ ��� � @��	 ��@��� � ���	 ���
��� � �	� 	 � ���� �  �@B��Ǆ� ��� ��@��� � ��Ǆ� ��	��@@��� � ���� ��� ��@��� � ���� ��	� � @ ��� � ��  *��& �    Vector2leftrightupdownipairs_gridFilterIsValidPiecePosnormalized       x        y         W   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    W   gridPos    W   
centerPos    W   blockGrids    W   spreadDirFlag    W   vLeft   W   vRight   W   vUp   W   vDown   W   vCG	   W   (for generator)   V   (for state)   V   (for control)   V   k   T   
blockGrid   T   vBG   T   vBGNormalized   T   vCB   T   vCBNormalized   T      _ENV �  �   3   @ A@G�� $� F@ GA���� d� �� �    GBA L��d� �����  ���� � �  �����A �� �������B @ 	� ��  � �   ��DB @ 	� �D  �̄B @�� 	� �D���������� ��& �    mathfloor                     _gridFilterGetBlockGridTrapPosListVector2"_CalcNRowMColSpread_IsGridBlocked_InsertTargetGridIntoOneArea_InsertTargetGrid         3   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    3   scopeParam    3   
centerPos    3   	bodyArea    3   row   3   col   3   spreadDirFlag	   3   targetArea
   3   
wholeArea   3   blockGrids   3   (for index)   /   (for limit)   /   (for step)   /   i   .   (for index)   .   (for limit)   .   (for step)   .   j   -   gridPos   -      _ENVL            
   
   
   
                  #   S   #   Z      Z   �   �   �   �   �   �   �   �   �   �   �   �               !  &  !  )  0  )  2  <  2  >  �  >  �  �  �  �  �  �  �  �  �  �  �  �  �  +  �  ,  T  ,  U  �  U  �  �  �  �  �  �  �         _ENV