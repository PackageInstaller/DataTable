LuaS 

xV           (w@@C:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/lua/product/components/ui/aircraft/new/manager/aircraft_whisper_manager.lua         %    @ A@  @ $@@@  @@ l   
@@@ l@  
@ @@ l  
@@@ lÀ  
@ @@ l  
@@@ l@ 
@ @@ l 
@@@ lÀ 
@ @@ l  
@@@ l@ 
@ &     _classAircraftWhisperManagerObjectConstructorInitRandomNextWaitTimeResetNextWaitTimeRandomWhisperPetCountUpdateDisposePlayBubbleRandomActionPetsGetBubbleId    
    	       !   
@ 
À A @AAÀA
 A @BBÀA¢@    À 
 
@ A @A@CCÇ D
ÀÇD
ÀÆ A Ç@ÁÇÀÄÇÃÄ
 Ä
 &     _main_nextWaitTime        _whisperActionGapsCfgcfg_globalAircraftWhisperActionGaps	IntValue_onePetWhisperTimeGapscfg_aircraft_constAircraftWhisperSeamPetGaps'      _startTimeAircraftWhisperNextWaitTimeArrayValue_minNextTime       _maxNextTime       AircraftWhisperRandomPetCount_minWhisperCount_maxWhisperCount         !   
                                                                                                      self    !   aircraftMain    !   nextTimeCfg   !   whisperPetCount   !      _ENV            L@@ d 
@ &     _nextWaitTimeRandomNextWaitTime                           self            #   %       F @ G@À @ ÇÀ@ e f   &     mathrandom_minNextTime_maxNextTime            $   $   $   $   $   $   %      self          _ENV (   *       L@@ d 
@ &     _nextWaitTimeRandomNextWaitTime           )   )   )   *      self            -   /       F @ G@À @ ÇÀ@ e f   &     mathrandom_minWhisperCount_maxWhisperCount            .   .   .   .   .   .   /      self          _ENV 1   :        @ @ 
  @ Ç@@ ! 
@À@ ¤@  A ¤@ &     _startTime_nextWaitTime        ResetNextWaitTimePlayBubble           2   2   2   3   3   3   3   4   6   6   8   8   :      self       deltaTimeMS            ;   <       &                 <      self            ?       h   G @ L@À d    Ç @ ÌÀl   ä  À@À A AA $A &  A $ \ @@LÁA À  d     FB GAÂ d !Â FÁB GÃA dA &  AÁ   ÁÁ  hGÃ¤ À ÃC D  CÄ$ À ÂÃB DAÃ Å¤ $C  	CE À$ FE GÃÅGbC  ÃB DÁ   ¤C&  CF ÎÃ@ÃÌÅä A A ÁÄ   $DG DGÀ   $LÇÀ dDLÄÇÀ dDgÁð&      _mainTimeGetPets       AirLog%æ²¡æå¯è¿è¡èªè¨èªè¯­çæçµRandomWhisperPetCountRandomActionPetstablecount        Logdebug(###AircraftWhisperManager pets is nil !	GetStateAirPetStateOnFurnitureGetFurnitureTypefatal###æçµè¡ä¸ºä¸ºç©º--TemplateIDGetBubbleIdCfgcfg_aircraft_pet_face"###æ¾ä¸å°éç½®è¡¨æéç½®ï¼_whisperActionGapsæçµèªè¨èªè¯­:ï¼æ°æ³¡idï¼AirActionFaceNewStartViceActionSetWisperTime         F   R       @    À ¤ Æ@@ ÇÀ_À ÀÆ@@ ÇÀÀ_À À Æ@@ Ç ÁÀ @Ì@Á ä  Á FA`   A   & Ã   æ  &     	GetStateAirPetState
WanderingOnFurnitureWaitingElevatorGetWisperTime_onePetWhisperTimeGaps             H   I   I   K   K   K   K   K   K   K   K   L   L   L   L   N   N   O   O   O   O   O   O   O   O   Q   Q   R      _pet       pet      state      wisperTime         _ENVtimeselfh   A   A   A   B   E   E   R   T   E   V   V   V   W   W   W   X   \   \   ^   ^   ^   _   _   _   _   _   _   a   d   d   d   d   d   d   e   e   e   e   f   i   i   i   i   k   l   l   m   n   n   n   n   o   o   o   q   q   r   r   r   r   r   r   r   u   u   u   u   w   w   w   x   x   y   y   y   y   y   z   z   |   |   |   ~   ~                                                         i         self    h   time   h   actionPets   h   pets	   h   count   h   (for index)*   g   (for limit)*   g   (for step)*   g   i+   f   pet,   f   state.   f   wid/   f   bubbleC   f   cfgF   f   gapTimeR   f   
tempPetIDT   f   whisperAction`   f      _ENV    ª    5   Ë     @   (B  D    Á   A  èBÇ À$ "   K  JÄJDA A	À  ¤DçüÆÂA ÇÂ  @ ä  \   (ÄA!  ÄGÂ@  'ÃýÊ@CA CB@ $C'Aôæ  &  
                  WisperWeightpetweighttableinsertmathrandomremovev         5                                                                                                                               ¡   ¡   ¡      ¥   §   §   §   §   §      ©   ª      self    5   pets    5   count    5   actionPets   5   (for index)   3   (for limit)   3   (for step)   3   i   2   all   2   outpet   2   
weightTab   2   (for index)      (for limit)      (for step)      j      pet      weight      weightTabItem      randomNumber    2   (for index)#   ,   (for limit)#   ,   (for step)#   ,   i$   +      _ENV ­   Á    (   Æ @ Ç@ÀÇâ    ÀD  "A  @ Á@ÌÁ ä Á¢   ÌAÁ GAä@ÆÁA ÇÂB LÁ d äA  À AÁ   ¤@ f  ÁA BA  $A&     Cfgcfg_aircraft_furniture_bubble
BubbleIDscfg_aircraft_petTemplateIDGetIDWithRandomWeightCharactorFaceLogfatal=###[AircraftWhisperManager] cfg_aircraft_pet is nil ! id -> 8###[AircraftWhisperManager] cfg_whisper is nil ! id ->          (   ®   ®   ®   ¯   ¯   °   ±   ³   ³   ´   ´   ´   ´   ´   µ   µ   ¶   ¶   ¶   ¶   ¶   ¸   ¸   ¸   ¸   ¸   ¸   ¹   »   »   »   »   ½   ½   ¿   ¿   ¿   ¿   ¿   Á      self    (   pet    (   wid    (   cfg_whisper   (   bubbles   !   showId   !   cfg_pet         _ENV%                     	      	             #   %   #   (   *   (   -   /   -   1   :   1   ;   <   ;   ?      ?      ª      ­   Á   ­   Á          _ENV