LuaS �

xV           (w@�@C:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/lua/product/core_game/view/svc/instruction/play_caster_change_mat_ins_r.lua         *    @ A@  $@ �@ A�  � A $@��@  ���  
���
 F@B �� �   d@�K�  J���J B��@B �@  � �@���@ �   �� ���@ �@  ������@ �  �� ���@ ��  ������@ �  �� ���@ �@ ����& �    requirebase_ins_r_class$PlayCasterChangeMaterialInstructionBaseInstructionModify        Revert       _enumChangeMaterialTypeBodyWeaponModelPartTypeConstructorDoInstruction_ModifyMaterial_SetNewMaterial_RevertMaterialFindWeaponSkinnedMeshRender                   �@@ ǀ� �� 
� ��@@ � � �� 
������ 
���� � 
���& � 	   _changeType	tonumbertype_partpart_matResNamemat
_nodeName	nodeName                                                       self       
paramList          _ENV $   *       @ FA@ @� ��@ � $A���@ F�@ @� �A � $A�& �    _changeTypeModify_ModifyMaterialRevert_RevertMaterial           %   %   %   %   &   &   &   &   '   '   '   '   (   (   (   *      self       TT       casterEntity       phaseContext          ChangeMaterialType -   C    	+   � � �� @@ �̀� �@ � � � � ���� � � ��@��A F�A @��� AB@�$� _@@��L�B �   dA @��A F�B @@�C �A�ǁC $� _@@� �L�B �   dA & �    BackUpMaterial AddBackUpMaterialViewViewWrapperGameObject_partBodyGameObjectHelperFindFirstSkinedMeshRender_SetNewMaterialWeaponFindWeaponSkinnedMeshRender
transform
_nodeName         +   /   /   0   0   1   1   2   2   2   5   5   5   5   6   6   6   6   8   8   8   8   9   9   :   :   :   :   ;   <   <   <   <   >   >   >   >   ?   ?   @   @   @   @   C      self    +   casterEntity    +   backupCmpt   +   
casterObj   +   bodyRender      weaponRender$   *      ModelPartType_ENV F   X    
#   � @GA@ 䀀�@  @��@ �@$� A�AA ƁA ���$� FB GA�L����Bd��� �LC�AA   dA A� G�C��CB@ @��A �  � �����J���& �    GetBackUpMaterial_partResourceManagerGetInstanceSyncLoadAsset_matResName	LoadTypeMatUnityEngine	MaterialNewObjSetBackUpRequestsharedMaterials        SetBackUpMaterial                #   G   G   G   H   H   J   J   J   J   J   J   J   J   K   K   K   K   K   K   L   L   L   L   P   Q   R   R   R   R   U   V   V   V   W   X      self    #   render    #   backupCmpt    #   newBodyMat   #   matResRequest      sharedMaterials   #   curMat   #   newMats   #      _ENV Z   l    	$   � � �� �@� � ǀ����A FAA @���� �A@�$� _ B��LAB �   dA @�A F�B @@��B ���AC $� _ B� �LAB �   dA & �    BackUpMaterialViewViewWrapperGameObject_partBodyGameObjectHelperFindFirstSkinedMeshRender _SetNewMaterialWeaponFindWeaponSkinnedMeshRender
transform
_nodeName         $   \   \   ]   ]   ]   ]   _   _   _   _   a   a   a   a   b   b   c   c   c   c   d   e   e   e   e   g   g   g   g   h   h   i   i   i   i   l      self    $   casterEntity    $   backupCmpt   $   
casterObj   $   bodyRender      weaponRender   #      ModelPartType_ENV n   v       � @ �@� � @ 䀀�@  @ �  & ���@�A �AA ǁ�� $�  & & �    GameObjectHelper
FindChildgameObjectGetComponenttypeofUnityEngineSkinnedMeshRenderer            o   o   o   o   o   p   p   q   q   t   t   t   t   t   t   t   u   v      self       
casterObj       weaponName       
transform      render         _ENV*                                    	                                              $   *   $   -   C   -   F   X   F   Z   l   Z   n   v   n   v      ChangeMaterialType   *   ModelPartType   *      _ENV