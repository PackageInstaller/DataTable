LuaS 

xV           (w@@C:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/lua/product/components/ui/aircraft/old/camera/aircraft_interactive_camera_controller.lua         "    @ A@  @ $@@@  @@ l   
@@@ l@  
@ @@ l  
@@@ lÀ  
@ @@ l  
@@@ l@ 
@ @@ l 
@@@ lÀ 
@ @@ l  
@&     _class$AircraftInteractiveCameraControllerObjectConstructorInit
SetActiveUpdateHandleDragCamera	_HandleXFadeInSetTargetPetHandleFadeObjects    	              
@@
@@
@À
@@
@À
@@&     _mainCamera _targetPet_initCamRot_initCamPos_initCamOffsetY_initCamOffsetZ              	                     self                      
@ 
Ç@@ ÌÀÀä 
À &     _mainCamera_aircraft3DManager_cameraMngCameraManager                                   self       camera       aircraft3DManager                      &                       self       active                6    3    @ @@¤ @¤À ¢    Á@ A$FAA GÁGÁÁ Ä  dÁb   ÇB â  @ÇABÇÂB ÂB$   ÇB ÌÃäA @ A@$ AC$"  À ÌC @ äA ÌÁC äA ÇD ÌAÄ@ D äA &     _aircraft3DManagerInputManager	GetClick_mainCameraScreenPointToRayUnityEnginePhysicsRaycast_targetPet
transformgameObjectPetGameObjectInteractiveClickGetDragHandleDragCameraHandleFadeObjects_cameraMngHandleWallFade
targetPos         3   "   "   "   "   "   #   #   $   $   $   $   %   %   %   %   %   %   &   &   &   &   &   '   '   '   '   '   '   '   (   (   (   .   .   .   .   .   /   /   0   0   0   0   3   3   5   5   5   5   5   6   
   self    3   deltaTimeMS    3   clicked   3   	clickPos   3   	clickRay       castRes       hitInfo       	dragging%   3   dragStartPos%   3   dragEndPos%   3      _ENV 8   P    >   Î@ @ Ï A@ GAÀAG@ ÀNÁ@   ¤  A  @  GA AA AÀ  AÂ ¤ ÇB BB AÂ Â ÇB Ù$ ÍÀGÂB  @ G@ BA A@ ÁÂ $  B FBB Â ÁÂ B  d OBÍA
 
@C BC
ÂC BC
&     rotateSpeedxy	_HandleX
maxAngleYQuaternionEuler        
targetPosVector3	distancebottomY_mainCamera
transform	position	rotation         >   9   9   9   ;   ;   ;   <   <   <   >   >   >   >   @   @   @   A   D   D   D   D   D   D   E   E   E   E   E   E   E   E   E   G   G   G   G   H   I   I   I   I   I   I   I   J   J   J   J   J   J   J   J   J   L   M   N   N   N   O   O   O   P      self    >   dragStartPos    >   dragEndPos    >   rotVec   >   x   >   y	   >   	rotation   >   target    >      _ENV S   f    *    @ Ç@@  À  @ @ NÀÀ    Á   MÀÀ @A AÀ  @ GA@ ¤ @    @ Ç@@  À ÀÁ @ MÀÀ   @  NÀÀ @A AÀ  @ GA@ MÁÀ¤ @    G @ f  &     	minAngle	maxAngle´       h      LÿÿÿÿÿÿÿMathfClamp                 *   T   T   T   T   U   U   V   V   W   W   X   Z   Z   Z   Z   Z   Z   Z   Z   [   [   [   [   \   \   ]   ]   ^   ^   _   a   a   a   a   a   a   a   a   a   c   e   f      self    *   x    *      _ENV h   z    5    @ @@@À@ AÁ@ A ÁA$ B$ GAB GÂGÁÂAB BC  ÆA ÌÁÁä ÌÂä Î  À   À  ÇAB ÇÂBC C@ÂC Ò$ ÊÇAB ÇÂD C@ BD Ò$ ÊÌD äA ÆÁD   äA  ÷&     Cfgcfg_aircraft_cameratranslateTimeValueè              GameGlobalGetInstanceGetCurrentTime_mainCamera
transform	position	rotationVector3Lerp_initCamPosQuaternion_initCamRotHandleFadeObjectsYIELD         5   i   i   i   i   i   j   k   k   k   k   k   l   l   l   m   m   m   o   o   p   p   p   p   p   p   q   q   r   u   u   u   u   u   u   u   u   u   v   v   v   v   v   v   v   v   v   w   w   x   x   x   x   z      self    5   TT    5   
totalTime   5   	duration   5   
startTime   5   
camOrgPos   5   
camOrgRot   5      _ENV }   ´       
 Ì@ä ÇÀÀÇ ÁAA A Á Á $ Í 
ÀÆ@A Ç ÂAB Á@AGA@ Aä B ÁBLÃ d LAÃd AGCA@ ÏAÁ
AD DÇA@ ÂC ÎBA ÂD¤
AA AEÇA@ ÂC ¤
D ÁEF
D ÁEE
 ÇA@ ÇÆÍ
ÀÆB ÇÁÆÇÇÇAÇ
ÀÆB ÇÁÆÇÁÇÇAÇ
ÀÆB ÇÁÆÇAÈÇAÇ
ÀÇD ÇÁÅÇÆ À  ÎÁÈH BI
 I  I I ÂH
 H BI
 ÂI    ÂI ÂH
   GJb   AB
 J ÁB
 hGJG  ÆCA ÊDJGÊGDÉÊÄJ	ä ÃÇCËÇCÊÃÇCËÇCÉÃ
gÂú
 LÌ d   
b   L À¤ÇCL ÄLM ÆDM ¤ $  Ê©  *ý&  6   _targetPet
targetPosPetGameObject
transform	positionVector3        é?
Normalize_mainCameraCfgcfg_aircraft_room_cameraGetRoomLogicDataSpaceIdInteractDistance_initCamPos_initCamRotQuaternionLookRotationup	distance	DistancexeulerAnglesybottomY
maxAngleYcfg_aircraft_camerainterCameraMaxXValuerotateSpeedinterCameraRotateSpeedangleRangeinterCameraAngleRange´       h      	minAngle       Lÿÿÿÿÿÿÿ	maxAngleFadeObjects       pos       
minRadiusradius
maxRadiusfadeObjectsCfgGetFadeObjectsfadeObjectspairsAddComponenttypeofFadeComponent            ~                                                                                                                                                                                                                                                                                                                              ¡   ¡   ¡   ¡   ¡   ¢   ¢   £   ¤   ¤   ¤   ¤   ¤   ¤   ¤   ¤   ¤   ¥   ¥   ¥   ¦   ¦   ¦   §   ¡   ª   «   «   ­   ­   ®   ®   ¯   ¯   ¯   ¯   °   °   °   °   °   °   °   ¯   ¯   ´      self       room       pet       dir      cfg      	distance      
minHeight8      _yN      fadeObjectsf      (for index)m      (for limit)m      (for step)m      in      datap      foq      objs      (for generator)      (for state)      (for control)      idx      obj         _ENV ¶   Ç    ,   G @ b   À	G@@ GÀ GÀÀ  A Ç@A ¤ Ç@ ÇAÁÂAGÂQÂÁÂÀ BB  ÇB ÀÂ@ ÁB   ÇB À@ CÀ @ @À ÎÒÁ©  *÷&     fadeObjectsCfg_mainCamera
transform	positionpairsfadeObjects
minRadius       
maxRadiussqrMagnitudeAlpha                        ,   ·   ·   ·   ¸   ¸   ¸   ¹   ¹   ¹   ¹   º   º   »   »   ¼   ¼   ½   ½   ½   ¾   ¾   ¾   ¾   ¾   ¿   ¿   À   À   À   À   À   Á   Á   Â   Â   Â   Â   Ã   Ã   Ã   Ã   ¹   ¹   Ç      self    ,   pos   +   (for generator)	   +   (for state)	   +   (for control)	   +   idx
   )   fadeCpt
   )   cfg   )   min   )   max   )   sqrMagnitude   )      _ENV"                                                    6       8   P   8   S   f   S   h   z   h   }   ´   }   ¶   Ç   ¶   Ç          _ENV