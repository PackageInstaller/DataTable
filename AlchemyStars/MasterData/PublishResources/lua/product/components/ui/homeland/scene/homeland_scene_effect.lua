LuaS 

xV           (w@@E:/depot_matchsrpg/matchsrpg/b/190/client/Assets/../PublishResources/lua/product/components/ui/homeland/scene/homeland_scene_effect.lua         .    @ A@  @ $@@@  @@ l   
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
@&     _classHomelandSceneEffectObjectConstructor	SetScaleSetVisibleUpdatePosRotaSetPosSetRotaExecuteExit	KillSelfDisposePlayIn	PlayLoopPlayOut               
&   
@ @ Á@¤ A  FBA GÁ¤ 
A@ ÀA B ABÁ   ¤AA@ C

ÃÁB ÁCBC ¤A
À 
 
@ÁB EB ¤

ÀA
ÀÁ
ÀA&     _Ids_ReqResourceManagerGetInstanceSyncLoadAsset	LoadTypeGameObject Logerror)HomelandSceneEffect SyncLoadAsset error _ObjObj	_visible 
SetActive_InAni	_LoopAni_OutAni_EftAniGetComponent
Animation	_InTimer_LoopTimer
_OutTimer         &                                                                                                                        self    &   ids    &   effectName    &   inAni    &   loopAni    &   outAni    &      _ENV "   $        @ @@@ &     _Obj
transformlocalScale           #   #   #   $      self       value            '   .    
    @ @   &  
@ @@ @@ ¤@&     	_visible_Obj
SetActive        
   (   (   (   )   ,   -   -   -   -   .      self    
   value    
        1   8       Ç @ @À  &  Ç@ ÇÀÀÊ@ Ç@ ÇÀÀÊ&     	_visible _Obj
transform	position	rotation           2   2   2   3   6   6   6   7   7   7   8      self       pos       rota            ;   =        @ @@@ &     _Obj
transform	position           <   <   <   =      self       pos            ?   A        @ @@@ &     _Obj
transform	rotation           @   @   @   A      self       rota            D   H       L @ Ã  d@L@@ d@ &     SetVisiblePlayIn           E   E   E   G   G   H      self            K   O       L @ d @À @ L@ d@ &     PlayOut 	KillSelf           L   L   L   L   M   M   O      self            R   W       F @ G@À @ d ÀÀ ¤ Ì Aä AÁA $A&     GameGlobalGetUIModuleHomelandModule
GetClientGetHomelandSceneEffectManagerDeletEffect_Ids            S   S   S   S   T   T   U   U   V   V   V   W      self       homeModule      homeClient      effMng         _ENV Z   n    )   G @ _@À @F@ GÀÀ d L Á Ç @ d@G@A _@À @F@ GÀÀ d L Á Ç@A d@GA _@À @F@ GÀÀ d L Á ÇA d@GÀA _@À G B L@Â Ã   d@GÀA LÂ d@ 
 Ã
@@
@À&     	_InTimer GameGlobalTimerCancelEvent_LoopTimer
_OutTimer_Req_Obj
SetActiveDispose	_visible          )   \   \   \   ]   ]   ]   ]   ]   ]   _   _   _   `   `   `   `   `   `   b   b   b   c   c   c   c   c   c   f   f   f   g   g   g   g   h   h   h   k   l   m   n      self    )      _ENV q   z       G @ _@À @G@ _@À G@ _ÀÀ ÀG @ L Á Ç@ d@Á @G @ LÁ Ç@ dGÀÁ O Â B ÀB¤  C  l  ¤ 
&     _EftAni _InAniPlayGetCliplengthè      	_InTimerGameGlobalTimer	AddEvent         u   w        @@   @ $@ &     	_InTimer 	PlayLoop           v   w   w   w   w          self   r   r   r   r   r   r   r   r   r   s   s   s   s   s   s   t   t   t   t   t   t   u   u   u   u   u   w   u   w   z      self       tt         _ENV }          G @ _@À @G@ _@À G@ _ÀÀ ÀG @ L Á Ç@ d@Á @G @ LÁ Ç@ dGÀÁ O Â B ÀB¤  C  l  ¤ 
&     _EftAni 	_LoopAniPlayGetCliplengthè      _LoopTimerGameGlobalTimer	AddEvent                    @@&     _LoopTimer                         self   ~   ~   ~   ~   ~   ~   ~   ~   ~                                                                     self       tt         _ENV        '   G @ @À @ C   f  G@ _@À  G@ _ÀÀ @G @ L Á Ç@ d@Á ÀG @ LÁ Ç@ dGÀÁ O Â B ÀB¤  C  l  ¤ 
  ¦  G @ L@Ã d@ C   f  &     _EftAni _OutAniPlayGetCliplengthè      
_OutTimerGameGlobalTimer	AddEventStop                    @@   @ $@ &     
_OutTimer 	KillSelf                                 self'                                                                                                                           self    '   tt   !      _ENV.                              "   $   "   '   .   '   1   8   1   ;   =   ;   ?   A   ?   D   H   D   K   O   K   R   W   R   Z   n   Z   q   z   q   }      }                      _ENV