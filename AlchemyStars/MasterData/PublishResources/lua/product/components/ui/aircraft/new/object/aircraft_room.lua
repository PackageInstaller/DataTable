LuaS 

xV           (w@@E:/depot_matchsrpg/matchsrpg/b/150/client/Assets/../PublishResources/lua/product/components/ui/aircraft/new/object/aircraft_room.lua             @ A@  @ $@@@  @@ l   
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
@@@ l@ 
@ @@ l 
@@@ lÀ 
@ @@ l  
@@@ l@ 
@ @@ l 
@@@ lÀ 
@ @@ l  
@@@ l@ 
@ @@ l 
@@@ lÀ 
@ @@ l 	 
@@@ l@	 
@ @@ l	 
@@@ lÀ	 
@ @@ l 
 
@@@ l@
 
@ @@ l
 
@@@ lÀ
 
@ @@ l  
@@@ l@ 
@ &  1   _classAircraftRoomObjectConstructor
_initArea_Init	InitNaviInitRestRoomInitDefaultFurnitureGetDefaultFurniture_initClickObjectDisposeCheckGroundGetRoomGameObjectGetRoomLogicDataLogicRoomTypeStatusGetPointHolderGetGatherPointHolderGetRandomStoryPointHolderSpaceIDLevelGetRoomTagAreaFloorCenterPositionPetEnterWanderingPetLeaveWanderingIsWanderingPetFullPetInPetOutIsBelongPetFull
ClearPetsSetColliderEnableOnFocusOnExitGetFurnitureGetFurnitureByID_GetFurnitureGetFurnituresGetAllFurniture	RoomNameGetFirflys
GetWindowLoadLastGameObjectSwitchToNowReleaseAllPointsOnStartDecorateOnStopDecorate    .              
@ 

À @ AAA ÆA ÇÁÁ¤ $  
 @ ABBGÁ@ GÁÂA
 
@CC $A ÁC $A D $A &     _roomGO_roomLogicData_floor	colliderGetComponenttypeofUnityEngineBoxCollider_boxCenter
transform	positioncenter	_visible
_initArea_Init_initClickObject            
                                                                                 self       roomGameObject       roomLogicData       floor          _ENV    -    +   L @ d 
ÀÀ@  A À @A A
À@ ÀA À @A ÀA
À@  B À @A @B
À@ B À @A ÀB
À@  C  @A @C
&     LogicRoomType_area AirRoomTypeCentralRoomAirRestAreaTypeCenterRoom	RestRoomCoffeeRoomCoffeeHouseWaterBarRoomBar	GameRoomEntertainmentRoom         +           !   "   "   "   "   #   #   #   #   $   $   $   $   %   %   %   %   &   &   &   &   '   '   '   '   (   (   (   (   )   )   )   )   *   *   *   *   +   +   +   -      self    +   type   +      _ENV /   v    ¶   G @ L@À d    b     À À@ Æ A Ç@Á ä@ &  ÆÀA Ç Â  AA ä!B A AAAÁ $A &    A Á hÁFÂA GÂÁB dÃÃ_À@ÂC ÇÃ¤ ÌD ä _À  gûÀ@ FA GAÁA dA &  FA GÄÁ À dAFAE LÅd LÁÅÀ  ÝBF Fd 
@GE GÁÆÇ ¤AAÇGÂG BGC ¤A AÇÆAH  A  ä ÁAÇÆAH  A  ä Á
@ÁG AGÌAIA äÌÉAÂ	 ä
ÀÇI ÀÀÆA ÇÊB
 GÂG GÊäA&  ÁÁ
 BK KI I ¤ÇÂK  LD d C $
 Á BK KI I ¤ÇÂK  LD d  $
 I IB $"  @FÂM LËÀ ÃK d 
@G@ LÎd BN N  LÂN ÀdBG@ LÎd BN O LBO dB @ LBO dB &  >   _roomLogicData
GetConfigPrefab Logfatal%### aircraft -- modle param is nil !stringsplit|        '### aircraft -- modle param is error !       ,       	tonumberSpaceID$### aircraft -- modle name is nil !noticeå è½½æ¿é´æ¨¡å--_roomModleRequestResourceManagerGetInstanceSyncLoadAsset.prefab	LoadTypeGameObjectObj
SetActive
transform
SetParent_roomGOlocalPositionVector3localScale_roomPrefab
_naviRoot	GetChildFind	naviRoot
exception3æ¾ä¸å°æ¿é´ånaviRootï¼æ¿é´æ¨¡ååç§°ï¼namePoints_pointHolderAircraftPointHolderNew_floorç©ºé´
æ¼«æ¸¸ç¹GatherPoints_gatherPointHolderç¤¾äº¤èéç¹RandomStoryPoints_randomStoryPointHolderAircraftStoryPointHolderGetRoomTypeAirRoomTypeEmptySpace	InitNaviCentralRoomInitRestRoom         ¶   2   2   2   3   4   4   5   7   7   8   8   8   8   9   ;   ;   ;   ;   ;   <   <   <   =   =   =   =   >   @   A   A   A   A   B   B   B   B   B   C   D   D   D   D   D   D   D   D   D   D   A   H   H   I   I   I   I   J   L   L   L   L   L   M   M   M   M   M   M   M   M   M   M   M   O   O   P   P   P   Q   Q   Q   Q   Q   Q   R   R   R   R   R   R   R   S   S   S   S   S   S   S   T   V   V   W   W   W   W   W   W   W   X   X   X   Y   Y   Y   Y   Y   Y   Z   \   ^   ^   ^   ^   ^   ^   ^   ^   ^   ^   ^   ^   ^   ^   _   b   b   b   b   b   b   b   b   b   b   b   b   b   b   d   d   d   d   e   e   g   g   g   g   g   g   j   j   j   j   j   j   j   l   l   l   o   o   o   o   o   o   o   p   p   q   t   t   v      self    ¶   cfg   ¶   modleParam   ¶   modleNameArr   ¶   
modleName   ¶   (for index)   1   (for limit)   1   (for step)   1   i    0   PerfabAndSpace%   0   moduleJ   ¶   
rootTransd   ¶   	nodeNamev   ¶   randomPointRoot   ¶      _ENV x       $    @ @@¤ Æ@ ÇÀÀÀ À A @ AA$ FA GÁÁ@  A   ¤@À Â @B ¤ÀB ¤Ì@BAA äÇÃâ    ÁÃ  $A&     _roomLogicDataGetRoomTypeAirRoomType
AisleRoomSetColliderEnableGetSpaceStatusSpaceStateSpaceStateFull
transformFindmodel	GetChild        NavMeshRootgameObject
SetActive         $   y   y   y   y   y   y   y   z   z   z   z   z   z   z   z   z   z   z   z                                                         self    $   module    $   model   #   navmeshObj   #      _ENV    °    i   G @ L@À d    
    
 A @A @ÀA  B@BB
 ÀA  B@B C
C @A
  A ÀC @ÀA  B DB
 ÀA  B D C
C @D
 A D @ÀA  BÀDB
 ÀA  BÀD C
C  E
 
 A @E @ÀA  BEB
 ÀA  BE C
C ÀE
 A  F ÀA  B@FB
 ÀA  B@F C
ÀF ÀFÁ    AA G ¤ ¤@  ÀG ¤@ &      _roomLogicDataGetRoomType_wanderingPetList_belongPetListAirRoomType	RestRoom_walkCeilingCfgcfg_aircraft_rest_roomé      WalkCeiling_petCeilingPetCeiling	_roomTagAircraftRoomTagCoffeeRoomÑ      CoffeeHouseWaterBarRoom¹      Bar	GameRoom¡      GameCentralRoom'      Logfatal,[AircaftPet] ä¼æ¯åºæ¿é´ç±»åéè¯¯ï¼ï¼ç©ºé´IDï¼SpaceIDInitDefaultFurniture         i                                                                                                                                                    ¡   ¡   ¡   ¡   ¡   ¢   ¢   ¢   ¢   ¢   £   £   £   £   ¤   ¤   ¤   ¤   ¥   ¥   ¥   ¥   ¥   ¦   ¦   ¦   ¦   ¦   §   §   §   §   ¨   ¨   ¨   ¨   ©   ©   ©   ©   ©   ª   ª   ª   ª   ª   ª   ¬   ¬   ¬   ¬   ¬   ¬   ¬   ¬   ¯   ¯   °      self    i   	roomType   i      _ENV ³   ¿    "   G @ G@À LÀ ÁÀ  d_ Á  @Á A  &     
 Ç@Á Î Â ¨@AÂ  ¤BÆÁB ÌÃD   ÇBC C ä ÂA MÂ
Â§ ü&     _roomPrefab
transformFindfurnitureRoot childCount        _defaultFurnitures       	GetChildgameObjectAircraftFurnitureNew_floor_area         "   ´   ´   ´   ´   ´   µ   µ   µ   µ   µ   ¶   ¹   ¹   º   º   º   º   º   »   »   »   »   ¼   ¼   ¼   ¼   ¼   ¼   ¼   ½   ½   ½   º   ¿      self    "   furnitureRoot   "   (for index)   !   (for limit)   !   (for step)   !   i       fGo       
furniture          _ENV Â   Ä       G @ f  &     _defaultFurnitures           Ã   Ã   Ä      self            Æ   î    f   
@@G@ LÀÀ d  A @A @A ÀA BA ¤¢   @ÇB
À  A ÀB @A ÀA B ¤¢   ÀÇB
À   A @C @A ÀA B ¤¢   @ÇB
À  A ÀC @A ÀA B ¤¢   À
ÇB
À  
 A @D @A ÀA B ¤¢   @ÇB
À  A D @A ÀA B ¤¢   ÀÇB
À   A ÀD  A ÀA B ¤¢   @ ÇB
À &     _clickObject _roomLogicDataGetRoomTypeAirRoomTypeCoffeeRoom_roomPrefab
transformFindUIAircraftBookTipgameObject
SmeltRoomUIAircraftSmeltTipDispatchRoomUIAircraftDispatchTip
PrismRoomaward	MazeRoom
TowerRoomTacticRoomUIAircrafTacticTip         f   È   É   É   É   Ê   Ê   Ê   Ê   Ë   Ë   Ë   Ë   Ë   Ì   Ì   Í   Í   Î   Ï   Ï   Ï   Ï   Ð   Ð   Ð   Ð   Ð   Ñ   Ñ   Ò   Ò   Ó   Ô   Ô   Ô   Ô   Õ   Õ   Õ   Õ   Õ   Ö   Ö   ×   ×   Ø   Ù   Ù   Ù   Ù   Ú   Ú   Ú   Ú   Ú   Û   Û   Ü   Ü   Ý   Þ   Þ   Þ   Þ   ß   ß   ß   ß   ß   à   à   á   á   â   ã   ã   ã   ã   ä   ä   ä   ä   ä   å   å   æ   æ   ç   è   è   è   è   é   é   é   é   é   ê   ê   ë   ë   î   	   self    f   	roomType   f   
bookShelf      	smeltTip      dispatchTip)   -   award7   ;   awardE   I   awardS   W   tipa   e      _ENV ð   õ       G @ b   @F@@ GÀ d LÀÀ Ç @ d@G A L@Á d@ &     _awardTimerGameGlobalTimerCancelEvent_roomModleRequestDispose            ñ   ñ   ñ   ò   ò   ò   ò   ò   ò   ô   ô   ô   õ      self          _ENV ø   ú        @ _@   @    ¦  &     
_naviRoot           ù   ù   ù   ù   ù   ù   ú      self       trans            ý   ÿ       G @ f  &     _roomGO           þ   þ   ÿ      self                    G @ f  &     _roomLogicData                    self                    G @ L@À e  f   &     _roomLogicDataGetRoomType                        self            
        G @ L@À e  f   &     _roomLogicDataStatus                        self                    G @ f  &     _pointHolder                    self                    G @ f  &     _gatherPointHolder                    self                    G @ f  &     _randomStoryPointHolder                    self                    G @ L@À e  f   &     _roomLogicDataSpaceId                        self                    G @ L@À e  f   &     _roomLogicDataLevel                        self               "      G @ f  &     	_roomTag           !  !  "     self            $  &      G @ f  &     _area           %  %  &     self            (  *      G @ f  &     _floor           )  )  *     self            -  /      G @ f  &     _boxCenter           .  .  /     self            2  8       @ ¤ ¢    @@ @ÁÀ  ¤@ &   A @AÇA   ¤@&     IsWanderingPetFullLogfatal2[AircaftPet] å½åæ¿é´å·²æ»¡ï¼ä¸è½è¿å¥ï¼tableinsert_wanderingPetList            3  3  3  3  4  4  4  4  5  7  7  7  7  7  8     self       id          _ENV 9  ?       @   !@@ @ À@Á  ¤@ &  @A AÇ @   ¤@&     _wanderingPetList        Logfatal&[AircaftPet] å½åæ¿é´æçµä¸ºç©ºtableremovev            :  :  :  :  ;  ;  ;  ;  <  >  >  >  >  >  ?     self       id          _ENV @  B   	   G @ \  @@ a@   C@  C  f  &     _wanderingPetList_walkCeiling        	   A  A  A  A  A  A  A  A  B     self    	        F  K       @ ¤ ¢   À @@ @ÁÀ  ¤@  A @AÇA   ¤@&     IsBelongPetFullLogfatal[AircaftPet] æ¿é´å·²æ»¡tableinsert_belongPetList            G  G  G  G  H  H  H  H  J  J  J  J  J  K     self       id          _ENV L  Q       @   !@@À @ À@Á  ¤@ @A AÇ @   ¤@&     _belongPetList        Logfatal[AircaftPet] æ¿é´äººæ°ä¸º0tableremovev            M  M  M  M  N  N  N  N  P  P  P  P  P  Q     self       id          _ENV R  T   	   G @ \  @@ a@   C@  C  f  &     _belongPetList_petCeiling        	   S  S  S  S  S  S  S  S  T     self    	        V  X      K   
@ &     _belongPetList           W  W  X     self            Z  ^       @ ¢   @  @ @&     	colliderenabled           [  [  [  \  \  ^     self       enable            a  d      
@@L@ Ã   d@&     	_visibleSetColliderEnable           b  c  c  c  d     self            g  j      
@@L@ Ã  d@&     	_visible SetColliderEnable           h  i  i  i  j     self            m  v       @ @@Á  Á@ A$ ¤@  &     Log
exception.AircraftRoomçè·åå®¶å·æ¥å£å·²å é¤ãdebug
traceback            n  n  n  n  n  n  n  v     self       type          _ENV x         @ @@Á  Á@ A$ ¤@  &     Log
exception6AircraftRoomçéè¿idè·åå®¶å·æ¥å£å·²å é¤ãdebug
traceback            y  y  y  y  y  y  y       self       id          _ENV            Ç @ â   ÀÇ @ Ç@â   À   @ @$LÂ@d  @ \ MÁ )  ªý¦  &     _furnitureTab        ipairsAvailableCount                                                                       	   self       type       t      furs      (for generator)      (for state)      (for control)      _      fur         _ENV         F @ G@À   ÆÀ@ Ç Áä  d@  &     Log
exception/AircraftRoomçGetFurnituresæ¥å£å·²å é¤ãdebug
traceback                               self          _ENV   ¤      F @ G@À   ÆÀ@ Ç Áä  d@  &     Log
exception1AircraftRoomçGetAllFurnitureæ¥å£å·²å é¤ãdebug
traceback                          ¤     self          _ENV §  ©      F @ G@À @ À@¤  e   f   &     StringTableGet_roomLogicDataGetRoomName            ¨  ¨  ¨  ¨  ¨  ¨  ¨  ©     self          _ENV ­  ¿   $      b   ÀÇ @ Ç@ÀÇÀÌÀÀA ä @Ç@A ÇÀÌÀÀA ä ¢   ÀË    GÁA (Á BÁ$Ê 'þæ  À Æ@B ÇÂÁ ä@ &     	_lastReqObj
transformFindFirefly_roomPrefab       childCount	GetChildLogerroræ¾ä¸å°Fireflyèç¹         $   ¯  °  °  ±  ±  ±  ±  ±  ±  ±  ±  ³  ³  ³  ³  ³  ³  µ  µ  ¶  ·  ·  ·  ·  ¸  ¸  ¸  ¹  ·  »  »  ½  ½  ½  ½  ¿  	   self    $   test    $   firRoot   $   	fireflys      (for index)      (for limit)      (for step)      i      trans         _ENV Á  È      b   À @ @@@À@ ¥ ¦   @@A @À@ ¥ ¦   &     	_lastReqObj
transformFindWindow_roomPrefab           Ã  Ã  Ä  Ä  Ä  Ä  Ä  Ä  Ä  Ä  Æ  Æ  Æ  Æ  Æ  Æ  È     self       test            Ì  Ù   0   G @ L@À d GÀ À@  A@ @AÆÀA Ì Âä Ì@Â@  ]ÁB Cä 
À ÇA Ç@ÃÃÁCD C$AÃFD GÁÄ
AÃFAE GÅ
AÃFD GÆ
AAÆ $A
À ÁF ACAF  $A&     _roomLogicData
GetConfigPrevLevelIDCfgcfg_aircraft_roomPrefab	_lastReqResourceManagerGetInstanceSyncLoadAsset.prefab	LoadTypeGameObjectObj
transform
SetParent_roomGOlocalPositionVector3zerolocalRotationQuaternion	identitylocalScaleone
SetActive_lastGo_roomModleRequest         0   Í  Í  Í  Í  Î  Î  Î  Î  Ï  Ï  Ï  Ï  Ï  Ï  Ï  Ï  Ï  Ï  Ï  Ð  Ð  Ñ  Ñ  Ñ  Ñ  Ñ  Ò  Ò  Ò  Ò  Ó  Ó  Ó  Ó  Ô  Ô  Ô  Ô  Õ  Õ  Õ  Ö  Ø  Ø  Ø  Ø  Ø  Ù     self    0   lastID   0   name   0   go   0      _ENV Û  ß   
   G @ L@À Ã   d@G@ GÀÀ L@À Ã  d@&     _lastGo
SetActive_roomModleRequestObj        
   Ý  Ý  Ý  Ý  Þ  Þ  Þ  Þ  Þ  ß     self    
        â  å      G @ L@À d@ G@ L@À d@ &     _pointHolderReleaseAll_gatherPointHolder           ã  ã  ã  ä  ä  ä  å     self            ç  ë      G @ b   À G @ L@À Ã   d@&     _clickObject
SetActive           è  è  è  é  é  é  é  ë     self            í  ñ      G @ b   À G @ L@À Ã  d@&     _clickObject
SetActive           î  î  î  ï  ï  ï  ï  ñ     self                                            -      /   v   /   x      x      °      ³   ¿   ³   Â   Ä   Â   Æ   î   Æ   ð   õ   ð   ø   ú   ø   ý   ÿ   ý               
    
                                   "     $  &  $  (  *  (  -  /  -  2  8  2  9  ?  9  @  B  @  F  K  F  L  Q  L  R  T  R  V  X  V  Z  ^  Z  a  d  a  g  j  g  m  v  m  x    x                ¤    §  ©  §  ­  ¿  ­  Á  È  Á  Ì  Ù  Ì  Û  ß  Û  â  å  â  ç  ë  ç  í  ñ  í  ñ         _ENV