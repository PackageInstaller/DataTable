LuaS 

xV           (w@f@C:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/lua/tolua/UnityEngine/Plane.lua              @ F@@ @ Ë   ,  Ê ,A  Ê ,  Ê ,Á  Ê , Ê ,A Ê , Ê ,Á Ê , Ê ,A Ê AC 
Á    @$Aæ  &     setmetatableMathfVector3__index__callNewGetRaycastSetNormalAndPositionSet3PointsGetDistanceToPointGetSide	SameSideUnityEnginePlane    
               @ Å    ¥ ¦   &     rawget                                 t       k          _ENVPlane            @ À  ¥  ¦   &     New                            t       v          Plane        
      Ë  A@ $ Ê Ê@  ¥ ¦   &     normal
Normalize	distance        
                                    normal    
   d    
      setmetatablePlane           G @ @@ f &     normal	distance                          self               &        @ Ç@À @ ¤Æ @ ÁÀ G@ äÙ A Î AÁ @  $"     A &`   CA  C  f&     Dot
directionnormalorigin	distanceApproximately                                                                           !   !   !   $   %   %   %   %   %   %   &      self       ray       a      num2      enter         Vector3Mathf (   +    
   Ì@À ä 
À ÆÀ@   @ äÙ 
À &     normal
Normalize	distanceDot       
   )   )   )   *   *   *   *   *   *   +      self    
   	inNormal    
   inPoint    
      Vector3 -   0       A@ F@ A ÎAd$  
 A G@  $ 
 &     normal
NormalizeCross	distanceDot          .   .   .   .   .   .   .   /   /   /   /   /   /   0      self       a       b       c          Vector3 2   4        @ Ç@@   ¤Ç@ À ¦  &     Dotnormal	distance          3   3   3   3   3   3   3   4      self       inPt          Vector3 6   8        @ Ç@@   ¤Ç@ À `  @    ¦  &     Dotnormal	distance                  7   7   7   7   7   7   7   7   7   7   7   8      self       inPt          Vector3 :   >       Ì @ @ ä@  $ À@ `  !@À@ a@@  CA  C f &     GetDistanceToPoint                   ;   ;   ;   <   <   <   =   =   =   =   =   =   =   =   =   =   =   >      self       inPt0       inPt1       distanceToPoint      num2                       
                           &      +   (   0   -   4   2   8   6   >   :   @   @   A   A   A   A   B   B      setmetatable       Mathf       Vector3       Plane          _ENV