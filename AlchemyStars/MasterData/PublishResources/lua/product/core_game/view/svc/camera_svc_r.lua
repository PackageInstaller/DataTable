LuaS 

xV           (w@E@../PublishResources/lua/product/core_game/view/svc/camera_svc_r.lua         7    @ A@  @ $@@@  @@ l   
@@@ l@  
@ @@ l  
@@@ lÀ  
@ @@ l  
@@@ l@ 
@ @@ l 
@@@ lÀ 
@ @@ l  
@@@ l@ 
@ @@ l 
@@@ lÀ 
@ @@ l  
@ @ A  @D $@ D    D l@ 
@&     _classCameraServiceBaseServiceConstructorPlayCameraShakeUpdateCameraShake
CalcShakeDamp
LinearVibEmitRandomVib_InitSceneCameraInitializeSceneCameraCameraFollowHeroBlinkMainCameraReplacePostProcessingProfileResetFov_ForFoldableDeviceCameraShakeParamsObject        	          
@  @ @Á  ¤
&     world_timeServiceGetServiceTime                                   self       world                   	    @ @@¤ @Á@ @   ¤@&     GameGlobalTaskManagerCoreGameStartTaskUpdateCameraShake         	                                 self    	   shakeParam    	      _ENV    /    2   Ç @A@A   À Á@ A¤  @ Á MÁÁ@ A¤ ÎAA À ¤A ûA ÁA¤ ÌBä ÇAÂÇÂ  ÀÂB À $ LCÀ  dB GÂ@ LÁd MAGÂ@ LÁd AFBA  dB @ú&     delay	duration        _timeServiceGetDeltaTimeMsYIELDworldMainCameraCamera
transform	position
CalcShakeShakeCamera         2                                       !   !   !   !   "   "   "   "   &   &   &   '   '   '   '   (   (   )   )   )   )   *   *   *   *   +   +   +   +   ,   ,   ,   ,   -   -   -   -   /   	   self    2   TT    2   shakeParam    2   delay   2   	duration   2   timeElapsed   2   mainCameraCmpt   2   oriPos   2   offset!   0      _ENV 3   >    +   Ì @ @  ä A@ @À $ FÁ@ GÁA ÁA Ad LÁÁÆB B AB B ä d  BÆB B AB B ä ÂB CGB$   À C  $À ÂÂ & &     Damp
LinearVibperiodQuaternionEuler        mainVibAngleMulVec3Vector3       intenseRandomnessMathfAbsíµ ÷Æ°>EmitRandomVib         +   4   4   4   4   5   5   5   5   6   6   6   6   6   6   6   6   6   6   6   6   6   7   7   7   9   9   9   9   9   :   :   :   :   :   :   ;   ;   ;   ;   =   =   =   >      self    +   timeElapsed    +   shakeParam    +   damp   +   offset   +   dir   +   mainVib   +   
randomVib   +      _ENV B   I       Á   AÀ   À AÀ  ÍÀ þÁ@ AGAÁ NA%&  &             period       MathfPow
decayRate            C   D   D   D   E   E   F   F   H   H   H   H   H   H   H   I      self       shakeParam       timeElapsed       periodElapsed         _ENV K   Y         @ @ ÀþÄ   A    AÏ @A   À A Î  A Í æ  &           Ð?             è?       üÿÿÿÿÿÿÿ           L   L   M   M   P   Q   Q   Q   R   R   R   S   S   S   T   T   T   T   V   V   V   X   Y      self       period       timeElapsed       offset           ]   h    +    @ @@  ¤ÌÀ@GÁ YÁ ä Á@AÁ  ÇAÁ $   À GÁÁ MÂÍÀ GÁÁ NÂÍÀFAB GÂ Á  d LÁÂÆC B A  ä d  C ÁCÀ ¤ Of &     _worldGetServiceRandomRenderRenderRandangleRandomnessintenseRandomness        mainVibAngleZ       QuaternionEulerMulVec3Vector3       MathfAbs         +   _   _   _   _   `   `   `   `   `   a   a   a   a   a   b   b   c   c   c   c   e   e   e   g   g   g   g   g   g   g   g   g   g   g   g   g   g   g   g   g   g   g   h      self    +   shakeParam    +   
randomSvc   +   angle	   +   intense   +      _ENV j   x       G @ L@À d À ¤ ÇÀ@ Ì Áä AÁ$ LÁAd 
ALABd 
ALÁBd 
AGCC¤ JGCD¤ J&     _configServiceGetLevelConfigDataGetCameraParam_worldMainCameraCamerafieldOfViewGetFovnearClipPlaneGetNearClipDistancefarClipPlaneGetFarClipDistance
transform	positionGetCameraPosition	rotationGetCameraRotation           l   l   l   m   m   p   p   p   r   r   s   s   s   t   t   t   u   u   u   v   v   v   v   w   w   w   w   x      self       levelConfigData      cameraParam      camera_cmpt      main_camera
           {          L @ d@ G@@ LÀ d ÀÀ ¤@  Á ¤@ @Á ¤@ Á ¤@ ÀÁ ¤@  Â ¤@ @B ¤@ B ÀB¤  C¤@ &     _InitSceneCamera_worldMainCameraLoadHUDCameraLoadDarkCameraLoadEffectCameraLoadSceneCameraLoadAuroraTimeFxAttachScreenEffPointReplacePostProcessingProfileHelperProxyGetInstanceInitCameraShake            |   |   ~   ~   ~                                                                  self       mainCameraCmpt         _ENV        )   Ç @ Ì@Àä À$ GÁ@GÁA ÆAA ÁGABGÂÁÂÇÂAÂä BB BAÂ C À ¤ ÁB C @ $ ]$B @ B@$ C$BÂ@LÂCÀ dB &     _worldMainCameraCamera
transform	positionVector3xyzLogerrorboard center 	tostring->SetCameraPosDOMove      à?         )                                                                                                                              	   self    )   oldPos    )   newPos    )   camera_cmpt   )   main_camera   )   camPos   )   diff   )   tarPos   )   trans$   )      _ENV     ¤        @ @@¤ Ì@ä Ê@&     _worldMainCameraCameraenabled           ¡   ¡   ¡   ¢   ¢   £   ¤      self       enabled       cMainCamera      camera           §   Á    /   A   @@ @À@À  ¤ ¢@    &  Ì AAA äÁGÁA LÂd AÂ  ¤AA@ @Á@ÆB ÇÁÂ¤ ¢  ÀÌCFBC B@ Cd  ä â  ÂÃAB $"    
ÌDC  äA&     	PostTempUnityEngineGameObjectFindGetComponent-UnityEngine.H3DPostProcessing.PostProcessingprofile_worldMainCameraSetPostProcessingProfileGameResourceConstEffRuchangActorpointGetComponentInChildrentypeofCameragameObject
SetActive         /   ¨   ©   ©   ©   ©   ©   ª   ª   «   ®   ®   ®   ¯   ²   ²   ²   ³   ³   ³   ¶   ¶   ¶   ¶   ¶   ¶   ·   ·   ¸   ¸   ¸   ¸   ¸   ¸   ¸   ¹   ¹   º   º   º   º   »   »   ¼   À   À   À   Á   	   self    /   postObjName   /   tmpObj   /   tmpPostProcessingCmpt   /   tmpProfile   /   mainCameraCmpt   /   goEffRuchangActorpoint   /   camera"   +   pp(   +      _ENV Ä   Ò       G @ L@À d À ¤ ÌÀ@ä@ Ç A Ì@Áä Á$ LBd 
AGA LAÁd AÂ¤A &  
   _configServiceGetLevelConfigDataGetCameraParam	ResetFov_worldMainCameraCamerafieldOfViewGetFovResetFov_ForFoldableDevice           Æ   Æ   Æ   Ç   Ç   È   È   Ë   Ë   Ë   Í   Í   Î   Î   Î   Ð   Ð   Ð   Ñ   Ñ   Ò      self       levelConfigData      cameraParam      camera_cmpt
      main_camera      camera_cmp           ä     	 
   
@ 

À 
 
@RB
@
GA  @@GA   Â GA RÂ
@
À
 &     delay
intensitymainVibAngle	durationvibratoperiod
decayRate       d       angleRandomnessintenseRandomness           î   ð   ò   ô   ö   ø   ø   ú   û   û   û   û   û   û   ü   ü   ü   ÿ       	   self       delay       
intensity       mainVibAngle       	duration       vibrato       
decayRate       angleRandomness       intenseRandomness           7                     	      	               /      3   >   3   B   I   B   K   Y   K   ]   h   ]   j   x   j   {      {                ¤       §   Á   §   Ä   Ò   Ä   Ø   Ø   Ø   Ø   Ù   Ù   ä     ä            _ENV