LuaS �

xV           (w@Y@../PublishResources/lua/product/components/ui/season/main/camera/season_camera_base.lua         X    @ A@  ��@ $@�@@  ��@@ l   
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
@ �@@ l  
@��@@ l@ 
@ �@@ l� 
@��@@ l� 
@ �@@ l  
@��@@ l@ 
@ �@@ l� 
@��@@ l� 
@ �@@ l  
@��@@ l@ 
@ �@@ l� 
@��& �    _classSeasonCameraBaseObjectConstructorDoCameraSizeScaleAniUpdateDisposeSwitchModeCamera
IsDragingFocus
Transform	PositionSetPositionSetPositionForceRenderTextureConstraintPositionSizeMinSizeMaxSizeSetSizeGetSizeSetRecordSizeGetRecordSizeTryResumeSize
FocusDone	SizeDone_CacheEffectRenderUnLockTweenV4           J    �   �@@ ��@��@ �� 
� �� @ � A�� @  ��A ��A�@ 
�����A �@B�@ 
� ��@A ��B
� ��@A �@C
� �� B ��C� D
� �� B ��C��D
���� B ��C� E
���� B ��C��E
���
 Ƌ
 ƌ
�F��@G ��G
� ��@G ��G
���
@H���H � I
� �
�ɒ
�ɓ
�I�
�ɔ
 D�� K �@K�� ��K� GAA G��� 
����@@ ��L��� 
���� M �@M
�����M � N�@N�� �� 
� ���M �@  � ���N � O�@ �@ ��M ��O ���
� ���M ��P
����@P �@N ���
�����P �   ����P �@G �J G�J ��J � ������P ��Q��Q� �@�
 D��   
�����R �@ � @ � S�� 
�����R ��S�� ��S�� 
����@P �@NA ���
� �� T �   ��� T ��O ���
� ���T ��T��M �@�̀�F�M G��G�OA���M ��U��V�AV�� 䀀
� ��@@ � �䀀 �@�l  �@����& � ^   _uiSeasonModuleGameGlobalGetUIModuleSeasonModuleGetSeasonID_cameraSeasonCfgCfgcfg_season_camera_seasonMapCfgcfg_season_map_cameraSizeMinCameraSizeMin_cameraSizeMaxCameraSizeMax	_mapLeftMapDragRange       _mapTop       
_mapRight       _mapBottom       _cameraSpeed{�G�zt?_cameraSizeSpeed_dragValue2       _startPositionVector3zero_endPosition	_draging _inputPhaseSeasonInputPhaseNone_touchFingerID _targetPosition_deltaPosition_recordSize_sizeTweenTime_cameraSizeSeasonToolGetInstanceGetLocalDBFloatSeasonCameraSizeDefaultSize_inputEngineInput_modeSeasonCameraModeFollow
_cameraGOUnityEngineGameObjectFindMain CameraLogfatal+SeasonCameraBase can not found MainCamera!_cameraGetComponentCamera_cameraTransform
transform_effectTransformEffectlocalScalegameObject
SetActive_unlockTweenTime_renderers_CacheEffectRender_seasonManagerSeasonManager_playerSeasonPlayerManager
GetPlayer_rtCameraGO	RTCamera
_rtCameratargetTexture
_cache_rtRenderTextureNewScreenwidth      �?height       TaskManager
StartTask         A   G       F @ �   d@ F@@ G�� G�� � � � Ad@�F@A� AJ� �F@@ G�� G � �@ �@Aǀ�d@�F@@ G�� G � �� �@Aǀ�d@�& �    YIELDUnityEngine	GraphicsBlit
_cache_rt
_rtCameratargetTextureShaderSetGlobalTexture_RTMask	_RTMask1             B   B   B   C   C   C   C   C   C   D   D   D   E   E   E   E   E   E   E   F   F   F   F   F   F   F   G      TT          _ENVrtself�                              	   	   	   	   
   
   
   
                                                                                                                                                                  !   !   !   #   #   #   #   #   #   $   $   $   %   %   %   %   (   (   (   (   (   *   *   *   ,   ,   ,   ,   ,   -   -   -   .   .   .   .   .   .   .   /   /   /   /   /   1   2   2   3   3   5   5   5   5   7   7   7   7   7   7   9   9   9   9   9   :   :   :   <   <   <   <   <   =   =   >   >   >   >   >   >   >   >   >   >   >   ?   >   ?   @   @   @   @   G   @   H   J      self    �   	seasonID    �   rt�   �      _ENV L   c    
   � @ �@    �& � 
���� @ �����FA GA��� ��  l  dA�FAB �� �� dA�
�& �    _camera_cameraAniPlayingorthographicSizeDoTweenHelperDoUpdateFloat��������       �������?YIELD�                X   _       F @ G@� �   d� ��@ ��@� �  @� �� � �ʀ��ƀ��   @ �ƀ�ʀ��& �    mathabsMathfLerp_cameraorthographicSize
_rtCamera             Y   Y   Y   Y   Z   Z   Z   Z   Z   Z   [   [   \   \   \   ]   ]   _      val       t      size
         _ENVtargetSizeoldSizeself   M   M   M   N   Q   R   R   S   T   T   U   V   W   _   T   a   a   a   a   b   c      self       TT       scale       oldSize      targetSize         _ENV e   ~    P   � @ �   @ ��   �  �@@ �   ����@ ��@�@@ � �AA G�A OA� �� �@@ ʀ ���A �   @ ���A ʀ �� B �    �� B �@BǀB �B C ����@C �C �C$� DGB GA�GA���C ��C�� ��D� � ��@C ���B AB@ ��D ��� � � � �ǀB �B E ����@E �    ��@C ���B ABGAE ��D ��� � � �� B �E � $��� ��& �    _cameraAniPlaying_cameraMathfLerporthographicSize_cameraSize_cameraSizeSpeed
_rtCamera_cameraTransform	position_modeSeasonCameraModeFollowVector3_player	Positionxyz_cameraSpeedDrag_targetPositionConstraintPosition         P   f   f   f   g   g   j   j   j   k   k   k   k   k   k   k   k   l   l   m   m   m   n   n   q   q   q   r   r   s   s   s   s   s   t   t   t   t   t   t   t   t   t   t   t   t   t   t   u   u   u   u   u   u   u   u   u   u   v   v   v   v   v   w   w   w   x   x   x   x   x   y   y   x   y   |   |   |   |   |   ~      self    P   
deltaTime    P   size      	position   O      _ENV �   �    "   G @ b@  ��F@@ L�� d� L�� �  AA �Ad@ G�A J@B�
�
�
�B�
�
�B�
�B�G�C b   ��F D G@� d�� L�� ��C d@�
�F�D G � �@E d@ & �    _recordSizeSeasonToolGetInstanceSetLocalDBFloatSeasonCameraSize_cameraorthographicSize_inputmultiTouchEnabled  _cameraTransform_player_targetPosition_deltaPosition_tweenTaskGameGlobalTaskManager	KillTasktableclear_renderers         "   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    "      _ENV �   �       
@ �& �    _mode           �   �      self       mode            �   �       G @ f  & �    _camera           �   �   �      self            �   �       G @ f  & �    	_draging           �   �   �      self            �   �       � @ A@ �@�@���@  � �@�& �    SwitchModeSeasonCameraModeDragSetPosition            �   �   �   �   �   �   �   �      self       	position          _ENV �   �       G @ f  & �    _cameraTransform           �   �   �      self            �   �       G @ G@� f  & �    _cameraTransform	position           �   �   �   �      self            �   �    	   �@@ ǀ� �@ AAAG�� �� 
� �& �    _targetPositionVector3x_cameraTransform	positionyz         	   �   �   �   �   �   �   �   �   �      self    	   	position    	      _ENV �   �       F @ �@@ ��@�� ��@� A �@�ǀ�A@ �@$� �Ad� � A � B @� 䀀����& � 	   Vector3_player	Positionx_cameraTransform	positionyzConstraintPosition            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       	position         _ENV �   �       G @ b   � �G @ G@� f  & �    
_rtCameratargetTexture           �   �   �   �   �   �   �      self            �   �    0   � @ �@@� @ ǀ���@���@ �  Y��� ��@  A ��� B MB��BAǂA !��� ���A �J�����A�B !�� ��B �BJ����B��BB !�� ��BB �J������ǂB !��� ���B �BJ���f  & �    _cameraaspectorthographicSizeVector3        x	_mapLeftz_mapTop
_mapRight_mapBottom         0   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   
   self    0   	position    0   aspect   0   size   0   width   0   height   0   topLeft   0   bottomRight   0   expectTopLeft   0   expectBottomRight   0      _ENV �   �       G @ G@� f  & �    _cameraorthographicSize           �   �   �   �      self            �   �       G @ f  & �    _cameraSizeMin           �   �   �      self            �   �       G @ f  & �    _cameraSizeMax           �   �   �      self            �   �       
@ �& �    _cameraSize           �   �      self       size            �   �       G @ f  & �    _cameraSize           �   �   �      self            �   �       
@ �& �    _recordSize           �   �      self       size            �   �       G @ f  & �    _recordSize           �   �   �      self            �   �       G @ b   ��L@@ � @ d@�L�@ �   d@�L�@ � A AA �A$� �AA �AA ��A�� �AB�  d@  & � 
   _recordSizeSetSizeSetRecordSizeFocusVector3_player	Positionx        z            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self          _ENV �         L @ �@@ d����@ ��@ � ��@�A@ �AG�@ G�G���� ƀ@ � � � @ 䀀a@�  ��@  � � �  & � 
   ConstraintPosition_targetPositionVector3_cameraTransform	positionxyz	Distance�������?            �   �   �   �   �   �   �   �   �   �   �   �   �                                      self       p1      p2         _ENV         F @ G@� ��@ ��@� A �� d� a@�   �C@  C � f  & �    mathabs_cameraorthographicSize_cameraSize333333�?                                         self          _ENV      
    G @ L@� ��  d��b    ���@ � A�@A �@ ��� ��AB FAB G��$ ��  ��B � ����  �BACAA � ���@ ǁ�BA G��A��@�& �    _cameraTransformFindEffect1tableclear_renderersgameObjectGetComponentsInChildrentypeofUnityEngine	RendererLength               insert             	  	  	  	  
  
                                                         self        effect       
renderers      (for index)      (for limit)      (for step)      i         _ENV   %   ,   � @ �@�� ̀�@� � � �@ GA $��"   �GBAb  @�GBAL���� d��b   �GBAL���  �dB GBAL���B d��b   �GBAL��B  �dB )�  ���
@ ��B $A & �    SeasonToolGetInstanceGetV4ByZoneMaskpairs_renderers	materialHasProperty_AreaUnlockMask
SetVector_AreaUnlockMask1
_zoneMaskTweenV4         ,                                                                                   #  $  $  %  	   self    ,   	zoneMask    ,   zoneID2Animation    ,   v4   ,   (for generator)
   (   (for state)
   (   (for control)
   (   _   &   	renderer   &      _ENV '  8      F@@ G�� d�� L�� �   d��
@ �& �    _tweenTaskGameGlobalTaskManager
StartTask         (  7   -   F @ �   d@ F@@ L�� d� L�� � � d���@A ƀ� �  ��  ����A�  ����A��AB 䁀�  @���A́�@� �B ��� �A���A��A 䁀�  @���A́�@� � ��� �A���  *�& �    YIELDSeasonToolGetInstanceGetV4ByZoneMask
_zoneMaskpairs_renderers	materialHasProperty_AreaUnlockMask	DOVector_unlockTweenTime_AreaUnlockMask1          -   )  )  )  *  *  *  *  *  *  +  +  +  +  ,  ,  -  -  -  .  .  .  .  .  .  /  /  /  /  /  /  1  1  1  1  1  1  2  2  2  2  2  2  +  +  7     TT    -   v4	   -   (for generator)   ,   (for state)   ,   (for control)   ,   _   *   	renderer   *      _ENVself   (  (  (  (  7  (  7  8     self          _ENVX                        J      L   c   L   e   ~   e   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �     �                 %    '  8  '  8         _ENV