LuaS 

xV           (w@g@../PublishResources/lua/product/components/ui/homeland/minimap/ui/ui_homeland_minimap_icon_player.lua             @ A@  @ $@@@  @@ l   
@@@ l@  
@ @@ l  
@@@ lภ  
@ @@ l  
@@@ l@ 
@ &  	   _classUIHomelandMinimapIconPlayerUIHomelandMinimapIconBaseOnShowOnHideOnInitDoneOnMinimapSwitchUpdateArrowGetAnimationName                  L @ ฦ@@ วภม@ d@ L@A ม d
@ L B ม@  d 
@FภB G ร @C d ร ค ฬภCไ Aฤ$ 
 &     AttachEventGameEventTypeMinimapSwitchOnMinimapSwitch_areaGetGameObjectArea_viewGetUIComponent
TransformViewGameGlobalGetUIModuleHomelandModule
GetClientCameraManager_followCameraControllerFollowCameraController                                                      
   
   
   
                              self       homeLandModule      homelandClient      
cameraMgr         _ENV           L @ ฦ@@ วภม@ d@ &     DetachEventGameEventTypeMinimapSwitchOnMinimapSwitch                                 self          _ENV            @   ค@&     OnMinimapSwitch                          self       minimapStatus               "        @ @@  @ ภ@ ค@ภ @ ภ@  ค@&     MinimapStatusMini_area
SetActive                                                       "      self       status          _ENV $   *    	    @ @@  @ ภ@ค ว AAA FA ม มม ย BBd 
A&  
   MinimapStatusMini_followCameraController	RotationeulerAngles_viewVector3        yด                   %   %   %   %   &   &   &   '   (   (   (   (   (   (   (   (   (   *      self       status       	rotation      angle         _ENV ,   4        @ ข@  @   
  @ ฦ@@ วภภภ @ ฦ@@ ว ม@ม @ @ ฆ  &     _animationNamesMinimapIconAnimationTypeINUIHomelandMinimapPlayerIcon_inOUT UIHomelandMinimapPlayerIcon_out            -   -   -   .   .   /   /   /   /   0   0   0   0   3   3   3   4      self       	animType          _ENV                                                   "      $   *   $   ,   4   ,   4          _ENV