LuaS �

xV           (w@W@../PublishResources/lua/product/components/ui/homeland/movie/cls/movie_father_son.lua         7    @ A@  ��@ $@�@@  ��@@ l   
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
@ �& �    _classMovieFatherSonObjectConstructorDisposeGetBuildManagerTestFnOnEnterMovieOnExitMovieAddFixedBuildingRemoveBuildingOnShowFreeAreaOnClearFreeAreaOnClearMovieOnRestoreHomeBuildingGetArchitectureOnSavePlaybackOnEnterPlaybackOnExitPlayback                  & �                      self                      
@@�
�@�& �    testID       homeBuildManager            	   
         self                      G @ @�  �F�@ G � �@A d� 
@ �G�@ L�� d� 
@ �G�A L@� d� 
@ �G B L�� d� 
@ �G @ f  & �    homeBuildManager 
mHomelandGameGlobal
GetModuleHomelandModulemUIHomelandGetUIModulehomelandClient
GetClientBuildManager                                                                                    self          _ENV    /    %   L @ d� �@� �  �����@  �  �
@����@ @� ���A @ 䀀
� �����@  ����@B @ �@�̀B @ �@�@���@ ��� �� C @ �@���@ �@�
���& �    GetBuildManagerFindBuildingByCfgID�mP     testID        	dataListOnSavePlayback       OnClearFreeAreaOnClearMovie       OnRestoreHomeBuilding        %                              !   $   $   $   %   %   %   %   %   &   &   &   '   '   '   (   (   (   (   )   )   )   +   +   +   .   .   .   /      self    %   	buildMgr   %   fatherBuilding   %        4   D       �   � � � A@ @�$��L�� ��d������� �LA�  dB�LB� � dB�)�  �A��  & �    GetAllChildrenpairsGetFreeChild ShowBuildingRemoveChild            5   7   7   8   8   8   8   9   9   9   9   9   :   <   <   <   =   =   =   8   8   C   D   	   self       fatherBuilding       restoreList      	children      (for generator)      (for state)      (for control)      k      v         _ENV G   [    $   �   � $� FA@ � d@����   ����@  ��@i�  ���LA d� �A@ �������  *B��A@ � �@��BAC� �B�̂� @ �B���  *��& �    GetAllChildrenpairsGetFreeChild GetBuildManagerShowBuilding	AddChild         $   H   J   J   K   K   K   K   L   L   L   L   L   M   K   K   Q   Q   S   S   S   S   S   S   W   W   W   W   X   X   X   Y   Y   Y   W   W   [      self    $   fatherBuilding    $   restoreList    $   
clearList   $   	children   $   (for generator)      (for state)      (for control)      k      v      	buildMgr   $   (for generator)      (for state)      (for control)      k      v      (for generator)   #   (for state)   #   (for control)   #   k   !   v   !      _ENV ^   �    S   � @ �@�ǀ���F@ G���  d� G� �@��AA ��   ���A & � �� �  �A$� GB�B�_ A� ���BC�����  �  �� ���B��B����C�LCC� d��_ �@ �����C ������C D$� 
���L�Dd� 
D�FDE G����Ed� 
D�FDE G���Cd� 
D�FDE G����Fd� 
D��FG GD���d� 
D��
�G�LH d� �D�  ���� & � "   Cfgcfg_item_son_architectureFatherSlot%cfg_homeland_building_fixed_position BuildErrorM拍电影找不到固定家具位置cfg_homeland_building_fixed_position ：
Transform	positionFixedPositionFindRecursivelyeulerAnglesyGetFixedChildDeleteArchitectureNew	asset_idparentGetBuildIdpos_xBuildHelperToIntxpos_ypos_zzrotmathfloorpstid        GetBuildManager_CreateBuilding         S   _   _   _   `   a   a   a   a   a   b   b   c   c   c   c   c   d   g   j   k   k   l   m   m   m   n   n   n   n   q   q   r   u   u   v   v   w   w   w   {   {   {   |   |   }   }   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    S   fatherBuilding    S   id    S   childBuildingCfg   S   fatherSlot   S   cfg_fixed_position	   S   theNearestFather   S   fixedTransform   S   fatherTransform   S   fatherPosition   S   relationPosition"   S   
fatherYaw$   S   relationYaw'   S   replacedBuilding*   S   worldPosition/   S   	worldYaw0   S   data3   S   	buildMgrN   S   	buildingQ   S      _ENV �   �        �   �& �  @  �& � �@@ � �� � $A���� $A�A$A & �     GetBuildManagerRemoveChildRemoveBuildingDispose           �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       fatherBuilding       	building       	buildMgr           �   �       � � � A  F�@ ��d@ � �@ �i�  ���L�� �   C� dA�& �    GetAllFreeArea��������pairsShowBuildingArea            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   
   self       fatherBuilding       isShow       allFreeArea      areaID      (for generator)      (for state)      (for control)      k   	   v   	      _ENV �   �       �   � � � A@ @�$  �� �)�  ���@ $� FA@ � d�����  ��B��A ��B��B��B i�  �A�& �    GetAllFreeChildrenpairsGetBuildManagerRemoveChildRemoveBuildingDispose            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       fatherBuilding       restoreList      	children      (for generator)   
   (for state)   
   (for control)   
   k      v      	buildMgr      (for generator)      (for state)      (for control)      k      v         _ENV �   �        �   � � � A@ @�$@�L�� ��d����  �� �)�  ���A $� FA@ � d���B�  ��B���A ��B�����B i�  �A�& �    GetAllChildrenpairsGetFreeChild GetBuildManagerRemoveChildRemoveBuildingDispose             �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self        fatherBuilding        restoreList       	children       (for generator)      (for state)      (for control)      k      v      	buildMgr       (for generator)      (for state)      (for control)      k      v         _ENV �   �       � @ �� �@@�@ & �    GetBuildManagerrefreshBuilding           �   �   �   �   �      self       fatherBuilding       	buildMgr           �   �    
%   � � �� �@@ ̀�� �@ @ $  �� �)�  ��� $� LA� d� ��A �B�AB�� ʀ���A �B��B�� ʀ���A �B�AC�� ʀ��@��� �� ʀ���  & �    GetArchitectureArchitectureNewpairsPosRotYpos_xBuildHelperToIntxpos_yypos_zzrotparentGetParentAssetID         %   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    %   	building    %   archServer   %   arch   %   (for generator)      (for state)      (for control)      k	   
   v	   
   buildingPos   %   buildingYaw   %      _ENV �      <   �   � @ @� 䀀A� $� F�@ � d 
������ �B   	��@  �����A �B�� �A���A���BG�C��CBGC�C����BG��C���BG��C���C��CC����C���C D@ ��$C�i�  ��F�C G�� ��dA��  & �    GetArchitectureGetAllChildrenpairs	IsDeleteArchitectureNew	asset_idskinpos_xpos_ypos_zrotpstidstatusparenttableinsert         <   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �                  �   �                    self    <   fatherBuilding    <   	dataList   <   father   <   	children   <   (for generator)	   5   (for state)	   5   (for control)	   5   k
   3   v
   3   child   3   data   3      _ENV   "   3   � @ � A@ �� $��F�@ � d�	������ � �  � ����BA ̂�� �@����A���BGBC��CBGCBC����BG�BC���BG�BC���C��CC����C������$��i�  ��& �    GetBuildManagerGetArchitecturepairs	asset_idGetBuildIdArchitectureNewskinpos_xpos_ypos_zrotpstidstatusparent_CreateBuilding         3                                                                                                       "     self    3   fatherBuilding    3   	dataList    3   	buildMgr   3   father   3   (for generator)   2   (for state)   2   (for control)   2   k	   0   v	   0   child   0   data   0   	building0   0      _ENV $  &      & �                &     self       fatherBuilding           7                                                   /      4   D   4   G   [   G   ^   �   ^   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �     �     "    $  &  $  &         _ENV