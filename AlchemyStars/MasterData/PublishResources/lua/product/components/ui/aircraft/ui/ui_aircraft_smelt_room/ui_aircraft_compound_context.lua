LuaS �

xV           (w@s@../PublishResources/lua/product/components/ui/aircraft/ui/ui_aircraft_smelt_room/ui_aircraft_compound_context.lua         .    @ A@  ��@ $@�@@  ��@@ l   
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
@��& �    _classUIAircraftCompoundContextObjectConstructorClear
InitIdMapInitWithTargetItem_AddMaterialDataCalcWithTargetNum_CheckComTarget_CheckMaterialGetComListDataGetCostIsCostEnoughIsMaterialEnoughReCalcOnlyUseBaseMaterial           	       
@@�F�@ G � �@A d� 
@ �F�@ G � ��A d� 
@ �& �    	maxLimit�      itemModuleGameGlobal
GetModuleItemModule_roleModuleRoleModule                                             	      self          _ENV           
@@�
�@�
�@�K   
@��
@@�K   
@��
�@�
�
�& �    
maxComNum        
curComNum       materialTypesNummaterialData_costcomList_atomDiscountmaterailNotEnough coinNotEntenough                                                  self                      
@ �& �    idMap                    self       idMap               9    
5   � @ �@ 
@��
� ���@ A �A� ǁ� �@�� B � �
����@B ǀ��B C�  G�B ` �@�`�����A ́C @�䁀�   ��AB ǁ�C� ����
������AB ǁ��C� ���N��  ���D �AD�� �C �A�& �    Clear
targetCfg_atomDiscount_AddMaterialData       InputSInputmaterialTypesNummaterialDatamathceil	maxLimit               CalcWithTargetNum
maxComNumLogdebug&UIAircraftCompoundContext , maxComNum         5                                          "   "   "   "   "   #   $   '   '   '   '   +   ,   ,   ,   ,   ,   .   .   .   .   .   .   /   0   0   3   3   3   3   3   3   4   6   6   8   8   8   8   8   9      self    5   
targetCfg    5   atomDiscount    5   mid   5   left   5   right   5   
nextIndex   .      _ENV ;   R    '     G@ J� FA@ � d ��  �������B������A���A�ǂ@
���@@��BB �@���   ��B �B�"  ��GCb   �LCC ��� CG�CdC�i�  ��& �    materialDataipairsID       NeedNum       
SelectNum        HaveNumidMapCfgcfg_item_smeltInput_AddMaterialDataSInput         '   <   =   =   >   >   >   >   ?   @   @   A   A   B   C   E   E   G   G   H   H   H   I   I   J   J   J   K   K   K   K   K   L   L   L   L   L   >   >   R      self    '   
typeLevel    '   input    '   sInput    '   	inputCfg   '   (for generator)   &   (for state)   &   (for control)   &   i   $   v   $   mat   $   
nextCfgId   $   
cfg_smelt   $      _ENV U   e    "   
� �
�����@ � �AA �@ 
�A�
�A��@B �B � ���B @�$@�GCC L����Cd��
C�
�@�)�  ����  jA��@D G�D G���� �� � ��   & �    _continueCalWhenCostNotEnough_cost        tableclearcomListcoinNotEntenough materailNotEnoughipairsmaterialDatapairsHaveNumitemModuleGetItemCountID
SelectNum_CheckComTarget
targetCfg                "   V   W   X   X   X   X   Y   Z   ]   ]   ]   ]   ^   ^   ^   ^   _   _   _   _   _   `   ^   ^   ]   ]   d   d   d   d   d   d   d   e      self    "   num    "   continueCalWhenCostNotEnough    "   (for generator)      (for state)      (for control)      level      matList      (for generator)      (for state)      (for control)      k      mat         _ENV g   �    C   @ A@A A�  "  ����@�  ��� ���@�AGAA��A �� ��A B BBOB���B O��$� ��
�����B   �@�C �C�� ��� $��"C  @ �  & �  j����C ��FBD G��䁀�A   �@�
 ŉ�AE �A  @ ��  � ǁE �A��  � ��E M
B� @ ��E 
 � & & �    Cfgcfg_item_smelt        SInput              materialData_costmathceil_atomDiscountpairs_CheckMaterialIDNeedNum_roleModuleGetAssetCountRoleAssetIDRoleAssetAtomcoinNotEntenough_continueCalWhenCostNotEnoughcomList         C   i   i   i   j   k   k   k   k   k   k   l   l   l   o   o   q   q   q   q   q   q   q   q   q   s   s   s   s   t   t   t   t   t   t   t   t   u   u   s   s   y   y   y   y   y   y   y   y   z   {   {   {   |   |         �   �   �   �   �   �   �   �   �   �   �      self    C   targetCfgId    C   level    C   comNum    C   
cfg_smelt   C   targetCost   C   matList   C   (for generator)   (   (for state)   (   (for control)   (   k   &   mat   &   
hasComNum8   C      _ENV �   �    3   @ � "A  @ �C  f GA@ GA��A ǁ@�@�� !�� �G�@M�A��C� f G�@�A��MBA�@ �B�B  � �
�A��  � �B �B��B��B G��$� �GDAGD�DCJ��)�  �C��C ����  %�&  & �    materialDataidMapHaveNum
SelectNum               materailNotEnoughCfgcfg_item_smeltpairsInputNeedNum       _CheckComTarget         3   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    3   targetGoodsId    3   level    3   needNum    3   matList   3   targetCfgId   3   mat	   3   
remainNum   3   needAppend   3   
nextLevel   3   nextMatList   3   
cfg_smelt"   3   (for generator)%   ,   (for state)%   ,   (for control)%   ,   k&   *   v&   *   mat(   *      _ENV �   �       K   � @ �@@ � @�Ɓ@ ���� �A�ʁ���A �A@� ��$B���  *��f  & �    pairscomList
RoleAssetNewassetidcounttableinsert            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       id_num_list      (for generator)      (for state)      (for control)      id      count      asset         _ENV �   �       G @ f  & �    _cost           �   �   �      self            �   �       G @ [ � f  & �    coinNotEntenough           �   �   �   �      self            �   �       G @ [ � f  & �    materailNotEnough           �   �   �   �      self            �   �    9   � @ �@@ � ����@���@   �� �C�C ���  j������@   �  �ʂA��  j���  *����A � B�@B ǀ��� �� �   ���B   �� ��B�@� C�C �CO�� �D O��$� 
 ��AD �D��D �E$��GAC  @  �
�Ŋ& �    ipairsmaterialData       pairs
SelectNumNeedNum        Cfgcfg_item_smelt
targetCfgIDSInput       _costmathceil_atomDiscount_roleModuleGetAssetCountRoleAssetIDRoleAssetAtomcoinNotEntenough         9   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    9   count    9   (for generator)      (for state)      (for control)      i      input      (for generator)	      (for state)	      (for control)	      k
      mat
      (for generator)      (for state)      (for control)      k      mat      
cfg_smelt   9   targetCost   9      _ENV.                        	                           9      ;   R   ;   U   e   U   g   �   g   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �          _ENV