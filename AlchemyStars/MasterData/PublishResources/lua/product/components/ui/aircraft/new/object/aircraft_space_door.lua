LuaS �

xV           (w@�@E:/depot_matchsrpg/matchsrpg/b/1130/client/Assets/../PublishResources/lua/product/components/ui/aircraft/new/object/aircraft_space_door.lua         K    @ A@  $@   K�  J@A�J�@�� B �@BJ���
@��K�  J�B�J�@�� B �@BJ���
@ �K�  J@C�J�@�� B �@BJ���
@ �K�  J�C�J D�� B �@DJ���
@ �  �  
���
�B�
 C�
�C�
�D�
�ĉ
�D�
@Ŋ
�E�
 D�
�ŋ
�E�
@ƌ
�F�
�ƍ
 G�F@G �� ��G d@�F�G @ �F�G �   J� �F�G �@  J���F�G ��  J� �F�G ��  J���F�G �  J� �F�G �@ J���& � &   requirecri_audio_help_controllerAircraftDoorCfg       namefc_door_white.prefabscaleYaudioIdCriAudioIDConstAircraftStoneDoorBUDC       fc_door_black.prefab       fc_door_gray.prefab       fc_door_nys.prefab
       AircraftAirDoorBUDC                            	                                                 _classAircraftSpaceDoorObjectConstructorDisposeSetDoorMatOpenClose	AnimStop        $   V    ~   
@ ��@@ ǀ��@ � A AAA G�A��A �A�A   ��B �A�� @��A���BCGBC
@��F�C G���BC dB FBD L��d� L����E CEd� 
@�GD G��
@�G�E G�LB��   dB G�E G���F �GJ��G�E G���F �GJ���G�E G���F ��GJ��G�E G�L��B d����E �F�H� �����AC	 䂀
���ǂI�B   ��B �B��	 @� �B���F �I�H@ ��I�J� ����BJ @��B��IF�J ��J �Kd �  �J CK�K$� G��L��C @ � dC L��� dC�L���@ d��b   ���E �M  �C�� ���E �M� �C�& � 5   spaceIdGameGlobal
GetModuleAircraftModuleCfgcfg_aircraft_spaceMatAircraftDoorCfgLog
exception%[AircraftDoor] 找不到门配置：namescaleYaudioIdAudioHelperControllerRequestUISoundSyncdoorRequestResourceManagerGetInstanceSyncLoadAsset	LoadTypeGameObjectdoorGOObj
transform
SetParentlocalPositionVector3zerolocalEulerAngleslocalScaleone	GetChild               acGetComponent	AnimatorSize找不到门尺寸配置：       SetDoorMattypeofUnityEngineMeshRendererMaterialPropertyBlockNew	materialSetInt_StencilRefSetPropertyBlockGetRoom
SetActive          ~   %   &   &   &   &   (   (   (   )   *   *   +   +   ,   ,   ,   ,   ,   .   /   0   0   2   2   2   2   4   4   4   4   4   4   4   4   4   5   5   5   6   6   6   6   6   6   7   7   7   7   7   8   8   8   8   8   9   9   9   9   9   :   :   :   :   :   ;   ;   ;   ;   ;   <   <   <   <   =   =   =   >   >   >   >   >   @   @   @   @   @   @   @   @   F   F   F   J   J   J   J   J   J   K   K   K   K   L   L   L   L   L   L   M   M   M   P   P   P   Q   Q   R   R   R   R   R   T   T   T   T   V      self    ~   spaceId    ~   parentTrans    ~   aircraftModule   ~   cfg   ~   type	   ~   uiCfg   ~   prefab   ~   scaleY   ~   doorAniTrans@   ~   doorMaskTransE   ~   doorMaskMeshb   ~   _mpbf   ~   	roomDatar   ~      _ENV
MaskLayer X   c       G @ b   � �G @ L@� d@ F�@ G�� � A d@ 
@A�
@A�
@��& �    doorRequestDisposeAudioHelperControllerReleaseUISoundByIdaudioId doorGOac            [   [   [   \   \   \   _   _   _   _   `   a   b   c      self          _ENV e   u    .   � � FA@ ��@ ��@d �  �  ��@�A G�N���� (��G�AL��B �B � dB '��@�� �A@ Ɓ@ ���� $�  GA @�� �AA �A��A�� h��G����BC G�B FC� �B g��& �    GetComponentsInChildrentypeofUnityEngineSkinnedMeshRendererLength               	materialSetInt_StencilRefspaceIdMeshRenderer          .   f   f   f   f   f   f   g   g   g   h   h   h   h   h   i   j   j   j   j   j   j   h   k   m   m   m   m   m   m   n   n   n   o   o   o   o   o   p   q   q   q   q   q   q   o   u      self    .   doorAniTrans    .   mat    .   components   .   (for index)      (for limit)      (for step)      i      skinnedMesh      components2   -   (for index)$   -   (for limit)$   -   (for step)$   -   i%   ,   mesh&   ,      _ENV
MaskLayer x   ~       G @ L@� � � d@�G�@ L�� �  A d@ F�A G�� � B d@ A@ f  & � 
   doorGO
SetActiveac
CrossFadeopen        AudioHelperControllerPlayRequestedUISoundaudioId�                  y   y   y   y   z   z   z   z   z   |   |   |   |   }   }   ~      self          _ENV    �       G @ L@� � � d@�G�@ L�� �  A d@ A� f  & �    doorGO
SetActiveac
CrossFadeclose        �                 �   �   �   �   �   �   �   �   �   �   �   �      self            �   �    
   G @ L@� �   d@�F�@ G�� � A �@ d@�& �    doorGO
SetActiveAudioHelperControllerStopUIVoiceaudioId                 
   �   �   �   �   �   �   �   �   �   �      self    
      _ENVK                                                         	   	   	   	   	   	   	   
   
   
   
   
   
   
                                                         !   !   !   !   "   "   $   V   $   X   c   X   e   u   e   x   ~   x      �      �   �   �   �      
MaskLayer2   K      _ENV