LuaS 

xV           (w@G@../PublishResources/lua/framework/core/ui_manager/ui_lock_manager.lua         /    @ A@  @ $@@@ l   
@@@ l@  
@ @@ l  
@@@ lÀ  
@ @@ l  
@@@ l@ 
@ @@ l 
@@@ lÀ 
@ ÀB l  
@ ÀB l@ 
@ÀB l 
@ ÀB lÀ 
@ÀB l  
@ ÀB l@ 
@&     _classUILockManagerObjectConstructorDispose	IsLockedHasLockLockedSizeLockUnLockExpirationLockUILockManagerCancelExpirationLock
UnLockAllUnLockAfterTime	ShowBusy
ClearBusyGetLocksNameString        
          @@ @¤ 
    

@AÀA @Â ¤
 &  	   
nameLocks
FastArrayNewlockName2EventshowBusyCount        lockManagerHelperUILockManagerHelperlayerManagerHelper                                                      self       uiLayerManager          _ENV           G @ L@À d@ &     lockManagerHelperDispose                          self                   	   G @ L@À d À   C@  C  f  &     
nameLocksSize                	                                 self    	               
    @ @@  ¤@  @    ¦  &     
nameLocksFindÿÿÿÿÿÿÿÿ        
                                    self    
   name    
        !   #       G @ L@À e  f   &     
nameLocksSize           "   "   "   "   #      self            (   7    ,    @ @@À  ¤ ¢   @@ À@Á  ¤@    ¦  @A   ¤¢   À@ À@Á   AÁ ¤@    ¦   B @B  ¤@@ BÁÀ   A B AC¤ ¤@  C ÀC¤@   ¦  &     stringisnulloremptyLogfatal[UI] [Lock] lock_name is emptyHasLock&[UI] [Lock] lock name already exist ''
nameLocksInsertdebug[UI] [Lock] '' lock count: SizelockManagerHelperLock         ,   )   )   )   )   )   )   *   *   *   *   +   +   -   -   -   -   -   .   .   .   .   .   .   /   /   2   2   2   2   3   3   3   3   3   3   3   3   3   5   5   5   6   6   7      self    ,   name    ,      _ENV :   I    	'    @ @@À  ¤ ¢    @ À@Á  ¤@ &  @A A  ¤_ÀA Ç@A Ì Â@ ä@Æ@ Ç@Â @ Á ÇAA ÌÃä ä@  Ç@A Ì Ãä @Ã ÇC ÌÀÃä@ &     stringisnulloremptyLogfatal![UI] [UnLock] lock_name is empty
nameLocksFindÿÿÿÿÿÿÿÿRemoveByIndexdebug[UI] [UnLock] '' lock count: Size        lockManagerHelperUnLock         '   ;   ;   ;   ;   ;   ;   <   <   <   <   =   @   @   @   @   A   A   B   B   B   B   C   C   C   C   C   C   C   C   C   F   F   F   F   F   G   G   G   I      self    '   name    '   index   '      _ENV N   X    	   Æ @   ä @À@ !@ ÆÀ@ Ç ÁA ä@ &  ÌA @ äÀÁÀÆ B Ç@Âä ÌÂ@ ÁB CÀ    ä AC 
Á &     typenumber        Logfatal-[UI] [ExpirationLock] lockMs is empty or <=0LockGameGlobalTimer	AddEventUILockManagerUnLockAfterTimelockName2Event            O   O   O   O   O   O   O   P   P   P   P   Q   T   T   T   T   T   U   U   U   U   U   U   U   U   U   U   V   V   X      self       name       lockMs       event         _ENV [   i        @ @@À  ¤ ¢    @ À@Á  ¤@ &  @A @ A  &  ÆÀA Ç Âä Ì@Â@ ä@Ç@A ÊÁ ÌB @ ä@&     stringisnulloremptyLogfatal/[UI] [CancelExpirationLock] lock_name is emptylockName2Event GameGlobalTimerCancelEventUnLock            \   \   \   \   \   \   ]   ]   ]   ]   ^   a   a   b   b   c   f   f   f   f   f   f   g   g   h   h   h   i      self       name       expirationEvent         _ENV k   t    	   F @ G@À   d@ GÀ@ L Á d@ G@A LÁ d@ FÀA  B d @AB B¤ ÁB ¤Ai  êÀýF C G@Ã  B d@ &     Logdebug[UI] [UnLockAll] Done
nameLocksClearlockManagerHelper
UnLockAllpairslockName2EventGameGlobalTimerCancelEventtableclear            l   l   l   l   m   m   m   n   n   n   p   p   p   p   q   q   q   q   q   q   p   p   s   s   s   s   t      self       (for generator)      (for state)      (for control)      _      event         _ENV w          b   À @   ¤@@@ À À@  AÁ@   A ¤@ À À@ ÀAÁ  ¤@ &  	   UnLocklockName2Event Logdebug'[UI] [ExpirationLock] event callback ''fatal+UILockManager:UnLockAfterTime params error            x   x   y   y   y   z   z   {   {   {   {   {   {   {   }   }   }   }         self       name          _ENV        !   b   @ @ @@
  @ @@À@ Á  ¤@ A @A ¤@À @     @ @@
  @ AÀA Á  ¤@ A @A  ¤@&     showBusyCount       Lock	showbusylockManagerHelperSetHighDepthObjectActive        UnLock        !                                                                                                         self    !   flag    !               	   L @ Á@  d@G@ LÀÀ Ã   d@
@A&     UnLock	showbusylockManagerHelperSetHighDepthObjectActiveshowBusyCount                	                                 self    	           ¢       A   @@ @,  ¤@f  &      : 
nameLocksForEach                   E      Á   ]À I   &      ;                                 ele          
retString                   ¡   ¢      self       
retString          /               
      
                              !   #   !   (   7   (   :   I   :   N   X   N   [   i   [   k   t   k   w      w                        ¢      ¢          _ENV