LuaS 

xV           (w@y@C:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/lua/product/module/aircraft/aircraft_room_base.lua         |    @ A@  @ $@@@  @@ l   
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
@&  *   _classAircraftRoomBaseObjectConstructorSetDataSetExtDataSetClientDataGetSpaceStatusSetSpaceStatusRoomIdSpaceIdLevel
NextLevel	MaxLevel
GetConfigGetSpaceConfigGetCfgByIdGetPets
GetPetsIdGetPetGetPetCountGetPetCountLimitGetRoomTypeGetRoomNameGetRoomEnglishNameGetRoomIcon1GetRoomIcon2GetRoomTypeIcon1GetRoomTypeIcon2GetRoomIcon3GetMaxFireflyToBuildGetRoomDescriptionGetUpgradeNeedGetDegradeRecycleGetNeedRoomsGetUpgradeNeedTimeGetCurrentPowerGetUpgradeNeedPowerGetDegradeNeedPowerEnoughPowerToUpgradeBuildRemainTimeCanCollect    '       	       F@@ GÀ À@ d 
@ &     _moduleGameGlobal
GetModuleAircraftModule                           	      self          _ENV    %    7   
@ À 
 Á 
Á 
 Â 
   
   
    
 C @CÆC ¤ ÆÀC Ä ä _@ÄÀD$"B  @FÂD GÅB ÀdB&  FE GÂÅBB À dBÂB GÂB \MÆ
Âé  jùÌ@F GÆ ä@ÌÀF GÇ ä@&     _space_info	_spaceid	space_id_roomidroom_id_space_statusspace_status_pstidroom_pstid_pets_pet_infos	_pets_idGameGlobal
GetModule
PetModuleipairspets        GetPetLogerrornot find pet tableinsert       SetClientDataclient_dataSetExtData	ext_data         7                                                                                                                                                        #   #   #   $   $   $   %   	   self    7   space_info    7   pet_module   7   (for generator)   0   (for state)   0   (for control)   0   i   .   pstid   .   pet   )      _ENV '   (       &                 (      self       	ext_data            *   +       &                 +      self       client_data            -   /       G @ f  &     _space_status           .   .   /      self            1   3       
@ &     _space_status           2   3      self       eSpaceStatus            5   7       G @ f  &     _roomid           6   6   7      self            9   ;       G @ f  &     	_spaceid           :   :   ;      self            =   C       G @ @@ @ @ AÀ  f  F A G@Á A G ÀÁ ¦  &     _space_statusSpaceStateSpaceStateBuilding        Cfgcfg_aircraft_room_roomidLevel            >   >   >   >   >   ?   ?   A   A   A   A   B   B   C      self       cfg         _ENV E   H       F @ G@À @ G ÀÀ ¦  &     Cfgcfg_aircraft_room_roomidNextLevelID            F   F   F   F   G   G   H      self       cfg         _ENV J   S    	   F @ G@À @  ÌÀ@ ä À d   Æ@A   ä À Á    Áé  jAþ¦  &     Cfgcfg_aircraft_room	RoomTypeGetRoomType       pairsLevel            K   K   K   K   K   K   K   L   M   M   M   M   N   N   N   O   M   M   R   S      self       cfgs      max      (for generator)      (for state)      (for control)      _      c         _ENV V   \       F @ G@À @ G ÀÀ   A @AÁ @ ¤@f  &     Cfgcfg_aircraft_room_roomid Logerror[aircraft] cfg is nil, roomid=            W   W   W   W   X   X   Y   Y   Y   Y   Y   [   \      self       cfg         _ENV _   b       F @ G@À @ G f  &     Cfgcfg_aircraft_space	_spaceid            `   `   `   `   a   b      self       cfg         _ENV d   j        @ @@@ @ ÆÀ@ Ç ÁA @ ä@¦  &     Cfgcfg_aircraft_room Logerror[aircraft] cfg is nil, roomid=            e   e   e   f   f   g   g   g   g   g   i   j      self       room_id       cfg         _ENV n   p       G @ f  &     _pets           o   o   p      self            t   v       G @ f  &     	_pets_id           u   u   v      self            y       	    @ ¢   @@ Ç @ ¤  Ì@ä @  ¦ ©  *þ   ¦  &     _petspairs	GetPstID            z   z   z   {   {   {   {   |   |   |   |   }   {   {               self       pstid       (for generator)      (for state)      (for control)      index      pet         _ENV           G @ \  f  &     _pets                          self                      L @ d @À ¦  &     
GetConfigPetNum                             self       cfg                     L @ d @À ¦  &     
GetConfig	RoomType                             self       cfg                     L @ d @À ¦  &     
GetConfigName                             self       cfg                     L @ d @À ¦  &     
GetConfigEnglishName                             self       cfg           ¢   ¥       L @ d @À ¦  &     
GetConfig
RoomIcon1           £   £   ¤   ¤   ¥      self       cfg           ¨   «       L @ d @À ¦  &     
GetConfig
RoomIcon2           ©   ©   ª   ª   «      self       cfg           ®   ·    
   F @ G@À @ À  ¤ @ÇÁ@ ÁÇAAA $  @ ÇÁAæ ©  *Áü&     Cfgcfg_aircraft_roompairsLevel       	RoomTypeGetRoomTypeRoomTypeIcon1            ¯   ¯   °   °   °   °   ±   ±   ±   ²   ²   ²   ²   ²   ³   ³   °   °   ·      self       	room_cfg      (for generator)      (for state)      (for control)      id      	room_cfg         _ENV º   Ã    
   F @ G@À    d @ À  ¤ @ÇÁ@ ÁÇAAA $  @ ÇÁAæ ©  *Áü&     Cfgcfg_aircraft_roompairsLevel       	RoomTypeGetRoomTypeRoomTypeIcon2            »   »   »   »   ¼   ¼   ¼   ¼   ½   ½   ½   ¾   ¾   ¾   ¾   ¾   ¿   ¿   ¼   ¼   Ã      self       	room_cfg      (for generator)      (for state)      (for control)      id      	room_cfg         _ENV Æ   Ï    
   F @ G@À    d @ À  ¤ @ÇÁ@ ÁÇAAA $  @ ÇÁAæ ©  *Áü&     Cfgcfg_aircraft_roompairsLevel       	RoomTypeGetRoomTypeRoomTypeIcon3            Ç   Ç   Ç   Ç   È   È   È   È   É   É   É   Ê   Ê   Ê   Ê   Ê   Ë   Ë   È   È   Ï      self       	room_cfg      (for generator)      (for state)      (for control)      id      	room_cfg         _ENV Ò   Ú       F @ G@À @ d ÀÀ ¤  AÇ@A ÎA ÁAFB GAÂABFÁB GÃd f &     GameGlobal
GetModuleSvrTimeModuleGetServerTimeè      _build_finish_timeCfgcfg_aircraft_valuesAirValueIDFireflyToTimeRate	IntValuemathfloor            Ô   Ô   Ô   Ô   Õ   Õ   Õ   Ö   Ö   ×   ×   ×   ×   ×   ×   Ø   Ø   Ø   Ø   Ù   Ú      self       timemd      now      left	      
unit_time      count         _ENV Ü   ß       L @ d @@ @ÇÀÀ ¥  ¦   &     
GetConfigStringTableGetDescription            Ý   Ý   Þ   Þ   Þ   Þ   Þ   ß      self       cfg         _ENV â   ë       L @ d @À @@ À@Á  ¤@    ¦  @A   ¤ÇAæ  &     
NextLevel        Logfatal[aircraft] room was max levelGetCfgByIdNeed            ã   ã   ä   ä   å   å   å   å   æ   æ   é   é   é   ê   ê   ë      self       next_level      	room_cfg         _ENV î   ñ       L @ d @À ¦  &     
GetConfigRecycle           ï   ï   ð   ð   ñ      self       	room_cfg           ô   ÷       L @ d @À ¦  &     
GetConfig	NeedRoom           õ   õ   ö   ö   ÷      self       	room_cfg           ù   ü       L @ d @À ¦  &     
GetConfigLevelUpTime           ú   ú   û   û   ü      self       	room_cfg           ÿ         L @ d G@À f  &     
GetConfig
NeedPower                            self                 	   L @ d @@ @ÇÀÀ À Ç Aæ  &     
GetConfigCfgcfg_aircraft_roomNextLevelID
NeedPower         	                        self    	   	room_cfg   	   next_level_cfg   	      _ENV      	   L @ d @@ @ÇÀÀ À Ç Aæ  &     
GetConfigCfgcfg_aircraft_roomPrevLevelID
NeedPower         	                        self    	   	room_cfg   	   prev_level_cfg   	      _ENV         G @ L@À d @ ¤ ÌÀ@ ä Ç ÁÁ !@   & @   & &     _module	GetPowerGetUpgradeNeedPower
GetConfig
NeedPower                                                self       power_leave      next_level_need_power      current_level_need_power             '      F @ G@À @ d ÀÀ ¤  AÇ@A ÇÁÎ À@ æ  @ Á & &     GameGlobal
GetModuleSvrTimeModuleGetServerTimeè      _space_infobuild_finish_time                                     !  !  !  "  "  #  #  %  %  '     self       timemd      now      remain_time
         _ENV *  ,      C   f  &                 +  +  ,     self           |                        	         %      '   (   '   *   +   *   -   /   -   1   3   1   5   7   5   9   ;   9   =   C   =   E   H   E   J   S   J   V   \   V   _   b   _   d   j   d   n   p   n   t   v   t   y      y                                                ¢   ¥   ¢   ¨   «   ¨   ®   ·   ®   º   Ã   º   Æ   Ï   Æ   Ò   Ú   Ò   Ü   ß   Ü   â   ë   â   î   ñ   î   ô   ÷   ô   ù   ü   ù   ÿ     ÿ                       '    *  ,  *  ,         _ENV