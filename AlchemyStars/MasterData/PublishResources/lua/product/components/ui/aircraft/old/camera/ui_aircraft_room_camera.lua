LuaS �

xV           (w@�@C:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/lua/product/components/ui/aircraft/old/camera/ui_aircraft_room_camera.lua         (    @ A@  ��@ $@�@@  ��@@ l   
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
@��& �    _classUIAircraftRoomCameraObjectConstructorInit
SetActiveFadeInSwitchFromInteractSetTargetRoomDisposeUpdate
SetActiveHandleFadeObjectsHandleDragPet           /    .   
@@�
�@�F@A L�� d� 
@ �F B L�� d� 
@��F�B G�� G � G@� 
@��
�@�K  J@D�J�D�J@E�J�E�
@��G�C G � 
@ �
���
�F�F�B G�� G@� G@� 
@ �K   
@ �G�G J ȏG�G J@ĐG�G J�H�
�@�
���
�@�
���
�@�& � )   _enable _controller _sphereCameraAircraftCameraSphereNew_strangeCameraAircraftCameraStrange_lerpParamCfgcfg_aircraft_camera
lerpParamValue
_roomDataPressStateNone       Timing       	Pressing       	Dragging       pressStatepressingPetpressStartTime'      pickUpTimepetLongPressTime_layersground        petaward       
zhanliReqbukezhanliReq
zhanliEffbukezhanliEffcurEff         .      	                                                                           !   #   #   #   #   #   %   %   &   &   '   '   (   (   *   +   ,   -   .   /      self    .      _ENV 1   >    !   
@ �
����@@ ���� 
� ��@A ̀�� ���A �AB ��B� 
� ��@A ̀�� ���A �AB ��B� 
���� A ǀ�
�����B ǀ�
����@C 
� �& �    _camera_3dManager_inputInputManager
zhanliReqResourceManagerGetInstanceSyncLoadAsseteff_bukezhanli.prefab	LoadTypeGameObjectbukezhanliReqeff_kezhanli.prefab
zhanliEffObjbukezhanliEffcurEff         !   3   5   7   7   7   7   9   9   9   9   9   9   9   9   9   :   :   :   :   :   :   :   :   :   ;   ;   ;   <   <   <   =   =   >      self    !   camera    !   _3dmanager    !      _ENV @   B       
@ �& �    _enable           A   B      self       active            D   q    �   �   �@@ ̀�� ���� A AA$� F�A G���A �B�� �AB�� G����B �������BCG��G���� ��C ���A��C D�DM��  ��D ��� CE �E �@�ƂB ��CG��GC������C� F CF@�$� �  �F��C@ �@$� �@$� �� �C DF�B G�������Fd� 
C��G @� $C ���C D
C���   C@ �@$� �@$� �   @G �C@ �@$� �@$� �� �C DFF G��� � DGd� 
C�G @� $C �� ���D ��� CE �G �@�ƂB ��CG��GC������C� ��F HNC���B �CH$���  �F��C@ �@$� �@$� �� �C DF�B G�������Fd� 
C���C DFF G��� � �Fd� 
C�G @� $C @���C ���B����C ��ʂ��B@ ǂ��H � & � $           GameGlobalGetInstanceGetCurrentTime
_roomDataGetGroundPosCfgcfg_aircraft_room_cameraGetRoomLogicDataSpaceIdVector3CamDeltaPos                     _camera
transform	position	rotation_controllerGetTypeAircraftCameraTypeStrangeCamInitRotQuaternionEuler�      LerpYIELD�      SphereSphereOffsetLookRotationup
GetModuleGuideModule         �   E   F   F   F   F   F   G   G   G   I   I   I   I   I   I   I   I   J   J   J   J   J   J   J   J   K   K   K   L   L   L   M   N   P   P   P   P   P   P   P   Q   Q   Q   Q   Q   Q   Q   Q   R   R   R   R   R   S   S   T   T   T   T   T   T   V   V   V   V   V   V   V   V   V   W   W   W   W   Y   Y   Y   [   \   \   \   \   \   \   ]   ]   ^   ^   ^   ^   ^   ^   _   _   _   _   _   _   _   _   _   `   `   `   `   a   b   b   b   b   b   b   b   c   c   c   c   c   c   c   c   c   d   d   d   d   d   d   d   e   e   f   f   f   f   f   f   h   h   h   h   h   h   h   h   h   i   i   i   i   i   i   i   i   i   j   j   j   j   n   n   n   o   o   o   p   p   p   p   q      self    �   TT    �   	duration   �   
startTime   �   
groundPos	   �   cfg   �   offset   �   
originPos   �   
originRot   �   
targetPos    �   
targetRot!   �   rot0   i   
lookAtPosz   �   guideModule�   �      _ENV s   �    ;   � @ �@@��@��@� A�@ �A �A$� B$� GAB G��G���AB ��B�C ����ƁA ���� ��� � � �   ��  �AB ǁ�BC �C@���C ҂�$� ����AB ǁ�D �C@ �BD ҂�$� ��ƁD  � �A ���AB ǁ��C ����AB ǁ�BD ��& �    Cfgcfg_aircraft_cameratranslateTimeValue�              GameGlobalGetInstanceGetCurrentTime_camera
transform	position	rotationVector3Lerp_currentPosQuaternion_currentRotYIELD         ;   t   t   t   t   t   u   v   v   v   v   v   w   w   w   x   x   x   y   y   z   z   z   z   z   z   {   {   |                              �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    ;   TT    ;   
totalTime   ;   	duration   ;   
startTime   ;   
camOrgPos   ;   
camOrgRot   ;      _ENV �   �    T   
@ �� @ �@@�� ��@�� ��@ � �ǀ��@   �AA �AA� � $A��@B� ��B 
 � �� C@ �AC 
 ��B �C��C �D  � $A�  GA�b   �AA �A�� �A h��GB�G��  ��D �CBG�G����CE� �������B������������
�g��
 ��G@ L��d� �  
���b   ��G �������F CG��G ��G � $�  ����  *��& �     
_roomDataGetRoomLogicDataSpaceIdCfgcfg_aircraft_room_cameraLog
exception'找不到相机控制器，空间id：CamController       _controller_sphereCamera       _strangeCameraInit_camera_3dManagerFadeObjects	positionVector3pos       
minRadiusradius
maxRadiusfadeObjectsCfgGetFadeObjectsfadeObjectspairsAddComponenttypeofFadeComponent         T   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    T   room    T   spaceID   T   cfg	   T   fadeObjects"   T   (for index))   >   (for limit))   >   (for step))   >   i*   =   data,   =   fo-   =   objsB   T   (for generator)I   S   (for state)I   S   (for control)I   S   idxJ   Q   objJ   Q      _ENV �   �       G @ L@� d@ G�@ L@� d@ 
 ��G@A L@� d@ G�A L@� d@ 
 ��& �    
zhanliReqDisposebukezhanliReq_controller _sphereCamera_strangeCamera
_roomData           �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self            �      �   � @ �@    �& � �@@ ��@�� �   @
��@ A��$��FAA G��G��� �   GBB G���BB ��BU��d��b  ���C �A�G�CG��䁀�    �& � ǁC����������AD ́�� ���GC L�d �  �    �& � A@ AE$ǁE �E F �@�"   #���@ ��@ 䁀BA �A�A@��  � CB �B$"  @��C �BF���C����  ��̂F� �F G_ � ���E �B�
��
��ǂG ����B 
@��BD �B�C� ��G ��H� �B   �ǁE �E BG � 	��H ���"   ��H   �@�BD I��H ���$B����E BI
 ��G �I$B BD BH�  �  $B ���E F
 ��G �I$B BD BH�  �  $B ��ǁE �E BI �@��AD ��� �A���  � ���E ��J
���	��A   	�"A  ����G ��J�B ��E �F
����ǁE �E �J ����AD ��� �A���   ��K   @��B ����E �F
����G �BK�B 
�K���K �L  �B�ǁE �E F �@
��AL ́�@� �A���@ ǁ����A�� 
�����@ ǁ�����A�� 
���N �A��L GBL L��d� ��N � 
����O �A��M GBL LB�d� ��N � 
����@ ǁ��L ����@ ǁ��M ���́O �A & � ?   _enable_input	GetClick_cameraScreenPointToRayUnityEnginePhysicsRaycast�      _layerspetaward
_roomDataTryClickPet
transformgameObjectname_3dManagerSceneManagerTryCollectAwardInRoomSpaceIDGetLongPresspressStatePressStateNone
TryGetPetCurrentStateAircraftPetActionStateRespondingTimingpressingPetOnPressBeginpressStartTimeSetPressSliderCalSliderWorldPospickUpTimeSetPressSliderValue	PressingPickUpOnCountEndInputManagerGetDrag	DraggingOnPressEndHandleDragPetOnDrop curEff
SetActive_controllerUpdate_currentPos	positionClone_currentRot	rotationVector3LerpGetPos_lerpParamQuaternionGetRotHandleFadeObjects         �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �                                                                                                                                                                                self    �   
deltaTime    �   clicked   �   	clickPos   �   	clickRay   3   castRes   3   hitInfo   3   longPressing6   �   
pressTime6   �   	pressPos6   �   	pressRayA   h   castResJ   h   hitInfoJ   h   petQ   h   curPressTimep   �   	dragging�   �   dragStartPos�   �   dragEndPos�   �   	dragging�   �   dragStartPos�   �   dragEndPos�   �      _ENV    "      
@ �& �    _enable           !  "     self       active            $  5   ,   G @ G@� G�� ��@ �    	�� A �@A � ����@ �A����AG�Q�������� �BB �� �ǂB ��@ ���B���   �ǂB ��@ ��C��� �@� @� ����������  *��& �    _camera
transform	positionfadeObjectsCfgpairsfadeObjects
minRadius       
maxRadiussqrMagnitudeAlpha                        ,   %  %  %  &  &  &  '  '  '  '  (  (  )  )  *  *  +  +  +  ,  ,  ,  ,  ,  -  -  .  .  .  .  .  /  /  0  0  0  0  1  1  1  1  '  '  5     self    ,   pos   ,   (for generator)	   +   (for state)	   +   (for control)	   +   idx
   )   fadeCpt
   )   cfg   )   min   )   max   )   sqrMagnitude   )      _ENV 7  J   C   � @ �@�@ 䀀�@ �@A@��  �A �A �A$��"  ���B �AB������   ���@ ��B�C�ACǁ�  A� ��@ ��B�C�D����  ���AD ́�C  �A���D 
���@��AD ́�C  �A��E 
����AD ́�C� �A��AD ǁ���F�E �� � � d� B����AF ́�G���A�& �    _cameraScreenPointToRayUnityEnginePhysicsRaycast�      _layersground
_roomDataCheckGround
transformAINavMeshSamplePositionpoint      �?	AllAreascurEff
SetActive
zhanliEffbukezhanliEff	positionVector3        �������?pressingPetOnDrag         C   8  8  8  8  :  :  :  :  :  :  :  :  :  <  <  <  <  <  <  <  <  =  =  =  =  =  =  =  =  =  =  =  =  ?  ?  @  @  @  @  A  A  A  C  C  C  C  D  D  F  F  F  F  G  G  G  G  G  G  G  G  G  G  H  H  H  H  J     self    C   dragStartPos    C   dragEndPos    C   dragRay   C   castRes   C   hitInfo   C   canStay!   B      _ENV(                        /      1   >   1   @   B   @   D   q   D   s   �   s   �   �   �   �   �   �   �     �      "     $  5  $  7  J  7  J         _ENV