LuaS 

xV           (w@i@E:/depot_matchsrpg/matchsrpg/b/190/client/Assets/../PublishResources/lua/framework/helper/h3d_timer.lua         D     
@@
À@F A @ À   d@FA À Æ B d@FÀA @FÀA ¬   JFÀA ¬@  J FÀA ¬  JFÀA ¬À  J FÀA ¬  JFÀA ¬@ J FÀA ¬ JFA   Æ B d@F D @ F D ¬À JF D ¬  JF D ¬@ J F D ¬ JF D ¬À J F D ¬  JF D ¬@ J F D ¬ JF D ¬À J &     Once       	Infiniteÿàõ    _enumTimerTriggerCount_class	H3DTimerObjectConstructor	AddEventAddEventTimesCancelEvent_GetCurrentTimeUpdateClearH3DTimerEventCancel	IsCancelReset	GetTimesReduceTimesCall	CompletePriorityComparer                  
@ @ À@@ AFAA GÁ¤ 
 B À@¤ 
 B À@¤ 
&  
   _worldeventQueueHeapNewCPM_CUSTOMH3DTimerEventPriorityComparer_newEventList
ArrayList_delEventList                                                                     self       world          _ENV    !   	   Ì @ @ A  À -  å   æ   &     AddEventTimes                                              !      self       delayMS       func            "   '      @ $ FA@ LÀÀ   @ í  d  Á@ A ¤Af &     _GetCurrentTimeH3DTimerEventNew_newEventList	PushBack            #   #   $   $   $   $   $   $   $   $   %   %   %   %   &   '      self       delayMS       times       func       curTime      event
         _ENV *   4    *    À ¤@ @@ @  ¤À@  Á  @AÀÁ ÀA  B @BÁ Á FB GÁÂd ¤@  @ Á  Á  CÀ B @BÁ@ Á FB GÁÂd ¤@  C ÀC  ¤@&     Cancel_newEventListRemoveÿÿÿÿÿÿÿÿ_heap_index        
_Complete Logerror4H3DTimer:CancelEvent _Complete ==false error index 
traceback3H3DTimer:CancelEvent _Complete ==true error index _delEventList	PushBack         *   +   +   ,   ,   ,   ,   ,   ,   -   -   -   -   -   -   .   .   .   .   .   .   .   .   .   /   /   /   /   /   /   0   0   0   0   0   0   0   0   2   2   2   2   4      self    *   event    *      _ENV 6   >       G @ b   ÀG @ L@À Á  dÀÀ ¥  ¦   @F A L@Á d LÁ e  f   &     _worldGetServiceTimeGetCurrentTimeMsGameGlobalGetInstanceGetCurrentTime            7   7   7   9   9   9   9   :   :   :   :   <   <   <   <   <   <   >      self       timeService   
      _ENV @           @ @@¤ Ç @ Ì@Àä  À @ÁÀ  @ A@$ AÁ  èÀÇ@ ÌÁ@ äBÁ$ AÀ ÂA B$BçüÇ @ Ì@Âä@ ÇB Ì@Àä B A@$   @Á  GB LAÀd Á  (ÁB A$GÂA LÂÂÀ dB'ýB AB$A ÁA LC d ÁA A@¤ ÌACä â   Ã    &  ÂC$B BÁ$ A@Ä$B BÄ$B Ä$   @úÂÄC ¤ $B  @ E$B øÀ÷BE EAÂ $B öÇF @Æ  
@ÇF @Æ  
@ÇF ÍA
ÀÇF F Î À  &  ÇF 
ÀÆAE ÇÁÆ @ B À  @äA&     _newEventListSize               GetAt	IsCancel eventQueueEnqueueClear_delEventListRemove_GetCurrentTimePeeknextExecutionTimeDequeue	CompleteCallReduceTimesReset	PushBackLogerrorH3dTimererror IsCancel true _last_update_time 
_cur_timedebugtime size queue_size  newevent_size  delevent_size             B   B   B   C   C   C   C   C   D   D   D   D   D   D   E   E   E   E   F   F   F   F   G   G   G   G   D   J   J   J   M   M   M   O   O   O   O   O   P   P   P   P   P   P   Q   Q   Q   Q   R   R   R   R   P   T   T   T   W   X   X   e   e   e   g   g   h   h   h   h   h   i   l   l   m   m   m   m   n   n   o   o   p   p   p   p   q   q   q   q   r   r   r   r   r   t   v   v   v   v   w   z   z   z   {   }   }   }   ~                                                                     self       deltaTimeMS       newevent_size      (for index)      (for limit)      (for step)      i      con      delevent_size!      (for index)+   5   (for limit)+   5   (for step)+   5   i,   4   con0   4   queue9      currentTime;      queue_size>      event@   b      _ENV        
   G @ L@À d@ G@ L@À d@ GÀ@ L@À d@ &     _newEventListClear_delEventListeventQueue        
                                    self    
           ¤   	   
@@
À@
@@
À
@ 
M bA    AA 
@
À@FC LAÃd LÃÀ -  d  
@&     _heap_indexÿÿÿÿÿÿÿÿ
_Complete _insertion_index_timesaddTime	_delayMsnextExecutionTime        _cancel	callbackGameHelperGetInstanceCreateCallback                              ¡   ¡   ¡   ¡   ¡   ¢   £   £   £   £   £   £   £   £   ¤      self       currentTime       delayMS       times       func          _ENV ¥   §       
@@&     _cancel           ¦   §      self            ¨   ª       G @ f  &     _cancel           ©   ©   ª      self            «   ³       
@@
@@
 Á
@ÀA  ¢@      
 &  	   _heap_indexÿÿÿÿÿÿÿÿ_insertion_index
_Complete addTimenextExecutionTime	_delayMs                   ¬   ­   ®   °   ²   ²   ²   ²   ²   ²   ³      self       currentTime            ´   ¶       G @ f  &     _times           µ   µ   ¶      self            ·   º       G @ N@À 
@ G @ f  &     _times                  ¸   ¸   ¸   ¹   ¹   º      self            »   ¿      G @ b   À G @ L@À í   d@  &     	callbackCall           ¼   ¼   ¼   ½   ½   ½   ½   ¿      self            À   Â       
@@&     
_Complete           Á   Â      self            Ã   Ë        @ Ç À  À  @  ¦    @ Ç À     ¦  @ À  ¦  &     nextExecutionTime       ÿÿÿÿÿÿÿÿ                   Ä   Ä   Ä   Ä   Å   Å   Å   Æ   Æ   Æ   Æ   Ç   Ç   Ç   É   É   Ë      a       b           D      	   
                                             !      "   '   "   *   4   *   6   >   6   @      @                                 ¤      ¥   §   ¥   ¨   ª   ¨   «   ³   «   ´   ¶   ´   ·   º   ·   »   ¿   »   À   Â   À   Ã   Ë   Ë   Ë      TimerTriggerCount   D      _ENV