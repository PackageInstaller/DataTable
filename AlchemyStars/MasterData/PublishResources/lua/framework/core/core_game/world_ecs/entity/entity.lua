LuaS 

xV           (w@N@../PublishResources/lua/framework/core/core_game/world_ecs/entity/entity.lua         R    @ A@  @ $@@@  @@ l   
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
@@@ l@ 
@ @@ l 
@@@ lÀ 
@ @@ l  
@@@ l@ 
@ @@ l 
@@@ lÀ 
@ @@ l  
@@@ l@ 
@ @@ l 
@@@ lÀ 
@ @@ l  
@&     _classEntityObjectConstructor
isEnabledInitializeDestroy"RemoveAllOnEntityReleasedHandlersReactivateAddComponentRemoveComponentReplaceComponentGetComponentGetComponentsGetComponentIndicesHasComponentHasComponentsHasAnyComponentRemoveAllComponentsGetCreationIndexRetainReleaseGetIDSetIDSetOwnerWorldGetOwnerWorld_CheckAvailableInRenderSide_GetComponentNameByIndex                  
@@
À@
À@FA LÀÁ d 
@F@B LÀÁ d 
@ F@B LÀÁ d 
@ F@B LÀÁ d 
@F@B LÀÁ d 
@ F@C GÃ ÀÃ @ 
@@  
ÀC&     _isEnabled _retainCount        _id_componentsSortedDictionaryNewEv_OnComponentAddedDelegateEventEv_OnComponentRemovedEv_OnComponentReplacedEv_OnEntityReleased_GEnalbeProfLog_checkCrossSide                  	   
   
   
   
                                                                              self          _ENV           G @ f  &     _isEnabled                       self               "       Ì @ @ ä@
&     ReactivateworldContextInfo                       !   "      self       creationIndex       contextInfo            %   ,       L @ d@ 
ÀGÀ@ L Á d@ G@A L Á d@ GA L Á d@ GÀA L Á d@ &     RemoveAllComponents_isEnabled Ev_OnComponentAddedClearEv_OnComponentReplacedEv_OnComponentRemovedEv_OnEntityReleased           &   &   '   (   (   (   )   )   )   *   *   *   +   +   +   ,      self            .   0       G @ L@À d@ &     Ev_OnEntityReleasedClear           /   /   /   0      self            2   5       
@@
@ &     _isEnabled_creationIndex           3   4   5      self       creationIndex            :   H       Ç @ â@   Æ@@ ÇÀÁ  ä@ &  Ì A @ äâ     &   ÇA ÌÀÁ@  ä@ Ç B    @  ä@ &  	   _isEnabledLogdebug5Entity:AddComponent Error! entity._isEnabled = falseHasComponent_entity_componentsInsertEv_OnComponentAdded            ;   ;   ;   <   <   <   <   =   @   @   @   @   @   B   E   F   F   F   F   F   G   G   G   G   G   H      self       index       
component          _ENV J   [    !    @ ¢@   @@ @ÁÀ  ¤@ &   A   ¤¢@    &  @A A  ¤Ç@A ÌÀÁ@ ä@Ç B    @  ä@ Ç@Bâ   @ Ì@Bä@ &  
   _isEnabledLogdebug8Entity:RemoveComponent Error! entity._isEnabled = falseHasComponent_componentsFindRemoveEv_OnComponentRemovedDispose         !   K   K   K   L   L   L   L   M   P   P   P   P   P   R   U   U   U   U   V   V   V   V   W   W   W   W   W   X   X   X   Y   Y   [      self    !   index    !   previousComponent   !      _ENV ]   w    	9   Ç @ â@   Æ@@ ÇÀÁ  ä@ &  Ì A @ äâ@   Ì@A @  ä@ &  ÇA ÌÀÁ@ ä_@  A AB À $A _BÁB @   À  $A C @   À$A AÃ"   AÃ$A @ÁB @   À  $A&     _isEnabledLogdebug9Entity:ReplaceComponent Error! entity._isEnabled = falseHasComponentAddComponent_componentsFind_entityModify Ev_OnComponentReplacedEv_OnComponentRemovedDispose         9   ^   ^   ^   _   _   _   _   `   c   c   c   c   c   d   d   d   d   e   h   h   h   h   i   i   j   k   k   k   k   k   l   l   m   m   m   m   m   m   m   o   o   o   o   o   p   p   p   q   q   s   u   u   u   u   u   u   w      self    9   index    9   
component    9   previousComponent   9      _ENV y       
     @ ¢   @@ ¢   À@   ¤¢@  ÌÀ@ @ ä A AFAA GÁ ÁÁ  FBB GÂd dA  ÀB  C  ¥ ¦   &     EDITOR_checkCrossSide_CheckAvailableInRenderSide_GetComponentNameByIndex
ComponentLog
exception not available in render side. debug
traceback_componentsFind             z   z   z   z   z   z   {   {   {   |   |   }   }   }   ~   ~   ~                                                   self        index        
available	      	cmptName      fullCmptName         _ENV           G @ G@À f  &     _componentsdictionary                          self                      G @ G@À f  &     _componentssorted_key                          self                   
$    @ ¢   @@ ¢   À@   ¤¢@  ÌÀ@ @ ä A AFAA GÁ ÁÁ  FBB GÂd dA  ÀB  C  ¤@C  @    ¦  &     EDITOR_checkCrossSide_CheckAvailableInRenderSide_GetComponentNameByIndex
ComponentLog
exception not available in render side. debug
traceback_componentsFind          $                                                                                                                  self    $   index    $   
available	      	cmptName      fullCmptName         _ENV    ¢    
    @ À  ¤ ÀÇA@ ÌÀ@ äÀÀ@ Ã  æ ©  *Aý  ¦  &     pairs_componentsFind                                                       ¡   ¡   ¢      self       indices       (for generator)      (for state)      (for control)      _      v         _ENV ¤   «    
    @ À  ¤ ÀÇA@ ÌÀ@ ä_ÀÀ@ Ã æ ©  *Aý   ¦  &     pairs_componentsFind             ¥   ¥   ¥   ¥   ¦   ¦   ¦   ¦   ¦   ¦   §   §   ¥   ¥   ª   ª   «      self       indices       (for generator)      (for state)      (for control)      _      v         _ENV ­   ³       G @ L@À d  @ ÀG @ LÀÀ Á  d@A   ¤@üG @ LÁ d@ &     _componentsSize        	GetKeyAt       RemoveComponentClear           ®   ®   ®   ®   ®   ¯   ¯   ¯   ¯   °   °   °   °   ²   ²   ²   ³      self       index	           ¸   º       G @ f  &     _creationIndex           ¹   ¹   º      self            ¼   ¾        @ @@
 &     _retainCount                  ½   ½   ½   ¾      self       owner            À   Å    
    @ @@
  @ @ À@ À   ¤@ &     _retainCount               Ev_OnEntityReleased        
   Á   Á   Á   Â   Â   Â   Ã   Ã   Ã   Å      self    
   owner    
        È   Ê       G @ f  &     _id           É   É   Ê      self            Ì   Î       
@ &     _id           Í   Î      self       id            Ð   Ö    
   
@  @ @@¤ Æ@ ÇÀÀÀ   
@A&     _worldGetRunningPositionWorldRunPostionPerformance_checkCrossSide          
   Ò   Ó   Ó   Ó   Ó   Ó   Ó   Ó   Ô   Ö      self    
   world    
      _ENV Ù   Û       G @ f  &     _world           Ú   Ú   Û      self            Ý   ï    	    @ @@Á  Á  ¤ A@ Ã  æ  Ç@AA ÁA@ $LAB d ÂÁB  ¤"    ¦ Ã æ &     debuggetinfo       S 
short_srcstringfind_r.luaGetOwnerWorldBW_WorldInfoAvailableInRender            Þ   Þ   Þ   Þ   Þ   ß   ß   à   à   ã   ä   ä   ä   ä   ä   ç   ç   è   è   è   è   ê   ê   ë   î   î   ï      self       index       
debugInfo      	filePath
      isRenderFile      world      
available         _ENV ñ   ø        @ ¤ Ç@@ÇÀÇÀÀÇ@æ  &     GetOwnerWorldBW_WorldInfoBWCC_EComponentsEnumEL_RawStrArray           ó   ó   õ   õ   õ   õ   ÷   ø      self       index       world      	cmptName          R                                          "      %   ,   %   .   0   .   2   5   2   :   H   :   J   [   J   ]   w   ]   y      y                                 ¢      ¤   «   ¤   ­   ³   ­   ¸   º   ¸   ¼   ¾   ¼   À   Å   À   È   Ê   È   Ì   Î   Ì   Ð   Ö   Ð   Ù   Û   Ù   Ý   ï   Ý   ñ   ø   ñ   ø          _ENV