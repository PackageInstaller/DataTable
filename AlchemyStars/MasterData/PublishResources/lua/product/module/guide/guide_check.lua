LuaS 

xV           (w@>@../PublishResources/lua/product/module/guide/guide_check.lua         ;   À 
@@
À@
@A
ÀA
@B
ÀB
@CFC +@ FÀC   À   d@F@D  ÆÀD d@FD ¬   J F@D @ ÆÀD d@F@E ¬@  J F@E ¬  J F@E ¬À  JF@E ¬  J F@E ¬@ JF@E ¬ J F@E ¬À JF@E ¬  J F@E ¬@ JF@E ¬ J F@E ¬À J&       GCT_ITEM_COUNT_EQUAL_OR_GREATER       GCT_MODULE_UNLOCK       GCT_MISSION_PASS       GCT_AIRCRAFT_ROOM_BUILD       GCT_HOMELAND_FREE_BUIND       GCT_WECHAT_TALKED       GCT_HAS_PET       GUIDE_CHECK_TYPE_END_enumGUIDE_CHECK_TYPE_classGuideCheckParamObjectConstructorGuideCheckCheckGuideStartCondition_Check_Config2CheckParam_CheckItemCountEqualOrGreater_CheckModuleUnlock_ChecMissionPassed_ChecAircraftRoom_ChecHomelandFreeBuild_CheckWeChatTalked_CheckHasPet                  
@@
@@
@À
@@
@À&     
CheckType        CheckParam1CheckParam2CheckParam3CheckParam4                                self                "       
@ &     _guideModule           !   "      self       guideModule            #   0        @ @@@ @@ Ã  æ  ÌÀ@ GAäA LÁd A (AÂÁ$LB À d@Â@ C  f 'ý & &  
   Cfgcfg_guide_check _Config2CheckParamCheckStartCondition       SizeGetAt_Check             $   $   $   %   %   &   &   (   (   (   )   )   )   )   )   *   *   *   +   +   +   +   +   ,   ,   )   /   /   0   	   self       guideID       check_config      
paramList
      (for index)      (for limit)      (for step)      i      param         _ENV 2   D    B    À Æ@@ À  @   ¥ ¦   À À ÆÀ@ À   A   ¥ ¦    À Æ@A À  A   ¥ ¦   @	 À ÆÀA À   B   ¥ ¦     À Æ@B À  B   ¥ ¦   À À ÆÀB À   C   ¥ ¦    À Æ@C À  C   ¥ ¦   @    ¦  &     
CheckType GCT_ITEM_COUNT_EQUAL_OR_GREATER_CheckItemCountEqualOrGreaterGCT_MODULE_UNLOCK_CheckModuleUnlockGCT_MISSION_PASS_ChecMissionPassedGCT_AIRCRAFT_ROOM_BUILD_ChecAircraftRoomGCT_HOMELAND_FREE_BUIND_ChecHomelandFreeBuildGCT_WECHAT_TALKED_CheckWeChatTalkedGCT_HAS_PET_CheckHasPet        B   3   3   3   3   4   4   4   4   4   5   5   5   5   6   6   6   6   6   7   7   7   7   8   8   8   8   8   9   9   9   9   :   :   :   :   :   ;   ;   ;   ;   <   <   <   <   <   =   =   =   =   >   >   >   >   >   ?   ?   ?   ?   @   @   @   @   @   B   B   D      self    B   param    B      GUIDE_CHECK_TYPE F   _    9    @ @@¤ À   ¦  ÆÀ@   ä 
A BA@ $FÂA LBÀd BB ÇB¤ JÂB_@À BB ÇÂB¤ JBC_@À BB ÇBC¤ JÂC_@À BB ÇÂC¤ JBD_@À BB ÇBD¤ JÂD ¤Bé  jô¦  &     
ArrayListNew ipairsstringsplit,GuideCheckParam
CheckType	tonumber              CheckParam1       CheckParam2       CheckParam3       CheckParam4	PushBack         9   G   G   G   H   H   I   L   L   L   L   M   M   M   M   M   N   N   N   O   O   O   O   P   P   P   Q   Q   Q   Q   S   S   S   T   T   T   T   V   V   V   W   W   W   W   Y   Y   Y   Z   Z   Z   Z   \   \   \   L   L   ^   _   
   self    9   CheckStartCondition    9   
paramList   9   (for generator)	   7   (for state)	   7   (for control)	   7   _
   5   
condition
   5   content   5   param   5      _ENV `   h        @ @@Æ@ ¤ ÌÀ@GÁ äAÁ !À   & @   & &     GameGlobal
GetModuleItemModuleGetItemCountCheckParam1CheckParam2            a   a   a   a   b   b   b   c   c   c   d   d   d   f   f   h      self       param       itemModule      
itemCount         _ENV i   q        @ @@Æ@ ¤ ÌÀ@GÁ äâ     & @   & &     GameGlobal
GetModuleRoleModuleCheckModuleUnlockCheckParam1            j   j   j   j   k   k   k   l   l   m   m   m   o   o   q      self       param       roleModule      bUnlock         _ENV r   z        @ @@Æ@ ¤ ÌÀ@GÁ äâ     & @   & &     GameGlobal
GetModuleMissionModuleIsPassMissionIDCheckParam1            s   s   s   s   t   t   t   u   u   v   v   v   x   x   z      self       param       missionModule      bpassed         _ENV {           @ @@Æ@ ¤ ÇÀÀ Á LAAÇÁÀ dÁ@   ¦ ÁÁ¤    ¦ @   ¦ &     GameGlobal
GetModuleAircraftModuleCheckParam1CheckParam2GetRoom RoomId            |   |   |   |   }   ~                                                         self       param       
airModule      spaceid      roomid      room	         _ENV        
    @ @@Æ@ ¤ ÌÀ@GÁ äAÁ   @   & @ AFÁA $ LBd AÂ¤ ÌBGÁ äBÁ aÀ  B   & &     GameGlobal
GetModuleItemModuleGetItemCountCheckParam1CheckParam2GetUIModuleHomelandModule
GetClientBuildManagerGetBuildCount                                                                                                         self       param       itemModule      
itemCount      homelandModule      homelandClient      buildManager      unPutCount         _ENV    ©        À Ç@À @ Á@FA $ LAAd Á  ¤Ü  ÀÆB   ä CÂÀ @   & é  jþÃ æ &  
   CheckParam1CheckParam2GameGlobal
GetModuleQuestChatModuleGetWeChatProxy	GetTalks        pairstalkId                                                ¡   ¡   ¡   ¢   ¢   ¢   ¢   £   £   £   ¤   ¤   ¢   ¢   ¨   ¨   ©      self       param       
speakerId      talkId      questChatModule      weChatProxy      talks      (for generator)      (for state)      (for control)      _      value         _ENV «   ®    	    @ @@Æ@ ¤ ÌÀ@GÁ å æ   &     GameGlobal
GetModule
PetModuleHasPetCheckParam1         	   ¬   ¬   ¬   ¬   ­   ­   ­   ­   ®      self    	   param    	   
petModule   	      _ENV;               
                                                                   "       #   0   #   2   D   2   F   _   F   `   h   `   i   q   i   r   z   r   {      {               ©      «   ®   «   ®      GUIDE_CHECK_TYPE
   ;      _ENV