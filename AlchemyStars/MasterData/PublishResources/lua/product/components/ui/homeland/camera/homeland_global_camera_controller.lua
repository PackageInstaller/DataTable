LuaS �

xV           (w@�@E:/depot_matchsrpg/matchsrpg/b/1140/client/Assets/../PublishResources/lua/product/components/ui/homeland/camera/homeland_global_camera_controller.lua         @    @ A@  ��@ $@�@@  ��@@ l   
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
@��& �    _classHomelandGlobalCameraControllerObjectConstructorInitDispose
CameraCmpCameraFowardRayGetFocusPosGetCamHeightSetLockCameraHandleRotateHandleScale
UpdatePosUpdatePosXZMove
SetActive	RotationFocusFocusDirectScalePercentForceSetRotation                  
@@�
�@�
@A�
�A�
@B�F�B G � G@� 
@ �F�B G � G�� 
@ �
@B�
�Ĉ
 ŉ& �    	_resNameHomelandGlobalCamControl_rotateFacor       _minXAngle       _maxXAngleZ       _focusHeightOffset        
_minScaleBuildConfigCamera	ScaleMin
_maxScale	ScaleMax_xAngle_defaultFocusTime      �?_lockCamera                   
                                                self          _ENV    3    B   �@@ ��@�� ��@A AA AF�A G���� 
� �� @ �@B
� �� B ��B
� ���B �@C� ���
� �� C �@C� ���
�����C �@D
� �� D 
� ���C � E
���� C ��E��E
���� � �� �@F�� ǀB ̀�@ �@�� B ���C  �@�� B �@�F�G ��G �Hd� �  � 
� �̀� � ���� 
���& � $   _resReqResourceManagerGetInstanceSyncLoadAsset	_resName.prefab	LoadTypeGameObject_camRootGOObj_camRootTrans
transform_camAxisXTrans	GetChild        
_camTrans_camLocalPoslocalPosition_initCamLocalPos_intCamLocalRotationlocalRotation_xAnglelocalEulerAnglesxSceneManagerRuntimeRootTrans
SetParent
SetActive_camGetComponentInChildrentypeofUnityEngineCamera_focusHeightOffsetBuildManagerGetBuildHeight         B                                               "   "   "   $   $   $   &   &   &   &   &   (   (   (   (   (   )   )   )   *   *   +   +   +   -   -   -   -   .   .   .   .   /   /   /   /   0   0   0   0   1   1   1   1   1   1   1   1   1   2   2   2   2   2   3      self    B   homelandClient    B   runtimeRootTrans+   B      _ENV 5   ;       G @ L@� d@ 
�@�
���
�@�
���& �    _resReqDispose _camRootGO_camRootTrans_camAxisXTrans           6   6   6   7   8   9   :   ;      self            >   @       G @ f  & �    _cam           ?   ?   @      self            B   F    	   G @ G@� ��@ ��@� � A� � ��   & �    _cam
transformRayNewforward	position         	   D   D   E   E   E   E   E   E   F      self    	   	camTrans   	      _ENV I   K       G @ G@� f  & �    _camRootTrans	position           J   J   J   K      self            N   P       G @ G@� G�� f  & �    
_camTrans	positiony           O   O   O   O   P      self            R   T       
@ �& �    _lockCamera           S   T      self       lock            X   k    	&   � @ �     �& � _@� ��ǀ@ ���AA  �A ��� �A  �@�_@@@��@A A � ��A  � @ �ǀA � ��A   �  ���A B F�B G�����A  B  d� 
A��
���& �    _lockCamera        _camRootTransRotate_rotateFacor_xAngle_maxXAngle_minXAngle_camAxisXTranslocalRotationQuaternionEuler         &   Y   Y   Y   Z   \   \   ]   ]   ]   ]   ]   ]   ]   `   `   a   a   a   a   b   b   b   c   c   d   d   d   e   h   h   h   h   h   h   h   h   i   k      self    &   mx    &   my    &   xAngle   %      _ENV n   {       � @ �     �& � �@@ ��@�@ ��@  � @ ���@ � �� A  ��  �� A �@@ ʀ ��@A A@ � �& �    _lockCamera_camLocalPosz
_minScale
_maxScale
_camTranslocalPosition           o   o   o   p   r   r   r   s   s   s   t   t   u   u   u   v   y   y   z   z   z   {      self       scale       newZ           ~   �    	.   � @ �     �& � �@@ �@ G� �AA ǁ� $� � ��   ��� B 
����@B �A � ��@B C � ���   AC G�C ` �� �AC G�C  @���C G�C ��C N��O��@AD F�D G�����  d� 
A��
���& �    _lockCamera_camRootTrans	positionVector3x_focusHeightOffsetz_camLocalPos_initCamLocalPos
_camTranslocalPositionlocalRotation_intCamLocalRotation_xAngle_maxXAngle_minXAngle{�G�z�?_camAxisXTransQuaternionEuler                 .            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    .   pos    .   checkValid    .   xAngle   -      _ENV �   �       � @ �     �& � �@@ �@ @� �A � $� � �& �    _lockCamera_camRootTrans	positionVector3_focusHeightOffset            �   �   �   �   �   �   �   �   �   �   �   �      self       x       z          _ENV �   �       � @ �     �& � �@@ ��@ � F�@ G�GA��@ & �    _lockCamera_camRootTrans
TranslateUnityEngineSpaceSelf            �   �   �   �   �   �   �   �   �   �   �   �      self       	movement          _ENV �   �       � @ �@@ � �@�& �    _camRootGO
SetActive           �   �   �   �   �      self       active            �   �       G @ G@� f  & �    _camRootTrans	rotation           �   �   �   �      self            �   �          "A    �@ GA� ��� ��� � G� 
���J����B �BB��� ��B� �B��C �BC �@ �  �B��C ��C  @ �� ��C,  �B�& �    _defaultFocusTime	position	rotationforwardeulerAnglesx        yGameGlobalUIStateManagerLock%HomelandGlobalCameraController:Focus
_camTransDOMoveDORotateQuaternionOnComplete         �   �     <    @ @@ F�� ��@� A� � �@AA����A ���A� �A �@ ����@� �� F�@GA�䀀Ҁ�@ O�� ��M��
A��@ E 
A��B E�
A�AC E�
A��AC E 
A�AC D ���B C�D ����D� �䀀 �@�A� �@�� ��   @ �� ��@� & �    _camRootTrans	positionnormalizedVector3Dotup        LogfatalFocus 焦点配置点不合法eulerAngles_camAxisXTranslocalEulerAngles
_camTrans	rotation_camLocalPoslocalPosition_xAnglexGameGlobalUIStateManagerUnLock%HomelandGlobalCameraController:Focus      	    <   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      planePoint   <   forward   <   dot	   <   d   0      selfforward_ENV	position
rotationY
rotationX	rotation	callback    �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   
   self        
transform        time        	callback        
focusTime       	position       	rotation       forward       
rotationY       
rotationX	          _ENV �   �    6   � � �@� �� G�� ��� JAA��AA���A ʁ ���A �����B ��BBF�B G��� ƂB ��d��@� ��BC ��C�� �B @���B ��B΂��B C����B�B �� ���B �B���D ʂ����A ʂ ���A ����A ���
���D �B���
��& �    	position	rotationforwardeulerAnglesx        y
_camTrans_camRootTransnormalizedVector3DotupLogfatal%FocusDirect 焦点配置点不合法_camAxisXTranslocalEulerAngles_camLocalPoslocalPosition_xAngle         6   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    6   
transform    6   	position   6   	rotation   6   forward   6   
rotationY   6   
rotationX   6   planePoint   6   forward   6   dot   6   d"   5      _ENV �       
   G @ �@@ ��@N�� � @ ��@ �� R�� f  & �    
_maxScale_camLocalPosz
_minScale        
   �   �   �   �   �   �   �   �   �         self    
                � @ �@ �@@ � � $� � ���@A �A A �� � $� � �& �    _camAxisXTranslocalRotationQuaternionEuler        _camRootTranseulerAnglesVector3                                               self       mx       my          _ENV@                                 3      5   ;   5   >   @   >   B   F   B   I   K   I   N   P   N   R   T   R   X   k   X   n   {   n   ~   �   ~   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      �                  _ENV