LuaS �

xV           (w@X@../PublishResources/lua/product/module/aircraft/aircraft_room/aircraft_tactic_room.lua         a    @ A@  $@ �@ A�  � A $@��@  ���@ l   
@���@ l@  
@ ��@ l�  
@���@ l�  
@ ��@ l  
@���@ l@ 
@ ��@ l� 
@���@ l� 
@ ��@ l  
@���@ l@ 
@ ��@ l� 
@���@ l� 
@ ��@ l  
@���@ l@ 
@ ��@ l� 
@���@ l� 
@ ��@ l  
@���@ l@ 
@ ��@ l� 
@���@ l� 
@ ��@ l  
@���@ l@ 
@ ��@ l� 
@���@ l� 
@ ��@ l  
@���@ l@ 
@ ��@ l� 
@���@ l� 
@ ��@ l  
@��& � "   requireaircraft_room_base_classAircraftTacticRoomAircraftRoomBaseConstructorSetClientDataSetExtDataGetRoomConfigGetPetRemainFightNumGetCartridgeLimitGetNextResetTimeCanOpenCartridgeGiftBoxIsCartridgeLimitGetCartridgeListGetCartridgeGiftCountIsReceivedCanReceiveWeeklyRewardNavMenuCanCollectCanCollectGetCartridgeCountDownGetCartridgeDeltaTimeGetWeeklyPassTimesGetWeeklyFreeMakeCountGetWeeklyFreeMakeLimitGetRoomResCDGetOneCartridgeSpeedGetDegradeInfoGetUpgradeInfoTacticPeakRewardedListSetPeakRewardedListGetThemeListSetThemeListGetCartridgeExtraAwards                  
@@�
�@�
�@�& �    _room_ext_data _cartridge_cd        _pet_cd           
               self                      �@� 
� ���� 
� �& �    _cartridge_cd       _pet_cd                                    self       client_data               !       b   ���@@ ��@�� 
� ���@ � A� @ �@� � G@ �� �A@��A BAA ��$A���& � 
   _room_ext_dataTacticRoomExtDataNewlua_dcLoadStream_className Logfatal7AircraftTacticRoom:SetExtData lua_dc.LoadStream fail!                                                                            !      self       data       ret      msg         _ENV $   '       F @ G@� ��@ G�� f  & �    Cfgcfg_aircraft_tactic_room_roomid            %   %   %   %   &   '      self       cfg         _ENV ,   :    	   � @ �@@ƀ@ ����� � A�@A �A �A� ��@  ��  B  � & �  j���  & � 	   Cfgcfg_aircraft_valuesAirValueIDWeekPetFightNumLimit	IntValuepairs_room_ext_datapet_fight_list                    .   .   .   .   .   .   /   /   /   /   /   0   0   2   3   3   4   6   /   /   9   :   	   self       	petTPSID       	numLimit      (for generator)
      (for state)
      (for control)
      key      value      
remainNum         _ENV >   C       L @ d� �@� �  & �    GetRoomConfigCartridgeLimit           ?   ?   A   B   C      self       cfgTacticRoom      	numLimit           G   L    	   G @ b   � �G @ G@� f  A�  f  & �    _room_ext_datanext_reset_time                	   H   H   H   I   I   I   K   K   L      self    	        P   U    	   L @ d�  @��@ �C � f  C   f  & �    GetCartridgeGiftCount                	   Q   Q   Q   Q   R   R   T   T   U      self    	        Y   a       L @ d� �@@ �� �  �@ $� � �!�� @ �� &   & & �    GetCartridgeLimitGetCartridgeListGetCartridgeGiftCount           Z   Z   [   [   \   \   \   \   ]   ]   ^   ^   `   `   a      self       	maxCount      cartridgeList      count           e   k    
   F @ G@� ��@ d� ��� A AA����  & �    GameGlobal
GetModuleItemModuleGetItemListBySubTypeItemSubTypeItemSubType_Cartridge         
   g   g   g   g   i   i   i   i   j   k      self    
   itemModule   
   list   
      _ENV o   w       F @ G@� ��@ d� ��@ � A�@A ǀ��� ��A� � @ 䀀�  & � 	   GameGlobal
GetModuleItemModuleCfgcfg_aircraft_valuesAirValueIDCartridgeGiftID	IntValueGetItemCount            q   q   q   q   s   s   s   s   s   s   u   u   u   v   w      self       itemModule      giftID
      count         _ENV |   �       � @ �@@��   A�  � �ǁ�� @ ��� � �@��   �  & �    _room_ext_datareceived_week_award_list                  }   }   ~   ~   ~   ~            �   �   ~   �   �   �      self       num       receiveList      (for index)      (for limit)      (for step)      i           �   �    0   C   f  K   � @ �@@ƀ@ ����� � A�@A ǀ�  A� 䀀 \�� (�BA �AG�B $��F�B �Bd� J@�'A��B CA �� � hA�G� ! ���LBC �� d��bB  @ �C� f g�C  f & �    Cfgcfg_aircraft_valuesAirValueIDWeekPassAwardStringValuestringsplit|       ;	tonumber_room_ext_dataweek_pass_numIsReceived         0   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    0   awardItems   0   weeklyAward	   0   a   0   (for index)      (for limit)      (for step)      i      b      passNum   0   (for index)!   -   (for limit)!   -   (for step)!   -   i"   ,      _ENV �   �       L @ d� � � �@@ � �� `� �� ���@ � @ ��@  � � �  & �    GetCartridgeListGetCartridgeGiftCount        CanReceiveWeeklyReward           �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       cartridgeList      
cardCount           �   �       L @ d� b@  @ �L@@ d� f  & �    CanOpenCartridgeGiftBoxCanReceiveWeeklyReward           �   �   �   �   �   �   �   �      self            �   �       G @ G@� �� @ �A�  f  G @ G@� ��@ M�� � A �@A� � �  �   & �    _room_ext_datacartridge_cd_time        _cartridge_cdmathceil            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       countdownTime
         _ENV �   �       L @ d� b   @ �A@  f  L�@ d� ��@ � A�@A ǀ��A � � �� �@��� ΀� �  & � 
   IsCartridgeLimit��������GetCartridgeCountDownmathfloorGameGlobal
GetModuleSvrTimeModuleGetServerTime�                  �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       time      now         _ENV �   �    	   G @ b   � �G @ G@� f  A�  f  & �    _room_ext_dataweek_pass_num                	   �   �   �   �   �   �   �   �   �      self    	        �   �    	   G @ b   � �G @ G@� f  A�  f  & �    _room_ext_dataremain_free_prod_times                	   �   �   �   �   �   �   �   �   �      self    	        �   �       L @ d� �@� �  & �    GetRoomConfig
FreeCount           �   �   �   �   �      self       cfgTacticRoom           �   �       L @ d� �@� ǀ@ � �& �    GetRoomConfigCD_pet_cd           �   �   �   �   �   �      self       cfgTacticRoom           �   �       G @ f  & �    _cartridge_cd           �   �   �      self            �      *   L @ d� �@@ ��@��� �� �@@ ǀ�� � �@�@ �  & �K ��A ��A�B �A��BG��kA � ƁA ���B CGBC�B��A � �A �CFB GB���C����A +A�& & �    
GetConfigCfgcfg_aircraft_tactic_roomIDPrevLevelID AirLevelInfoTitleTacticTapeStorageCountAirRoomChangeLevelDataType
NumberIntCartridgeLimitTacticTapeMakeTimeTimeCDTacticTapeWeeklyFreeTimes
FreeCount         *   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �              self    *   	room_cfg   *   cur_cfg   *   	next_cfg
   *      _ENV       *   L @ d� �@@ ��@��� �� �@@ ǀ�� � �@�@ �  & �K ��A ��A�B �A��BG��kA � ƁA ���B CGBC�B��A � �A �CFB GB���C����A +A�& & �    
GetConfigCfgcfg_aircraft_tactic_roomIDNextLevelID AirLevelInfoTitleTacticTapeStorageCountAirRoomChangeLevelDataType
NumberIntCartridgeLimitTacticTapeMakeTimeTimeCDTacticTapeWeeklyFreeTimes
FreeCount         *                           	  	                                                              self    *   	room_cfg   *   cur_cfg   *   	next_cfg
   *      _ENV "  $      G @ G@� f  & �    _room_ext_datareceived_peak_lv_list           #  #  #  $     self            &  (      � @ �@��& �    _room_ext_datareceived_peak_lv_list           '  '  (     self       lv_list            *  ,      G @ G@� f  & �    _room_ext_datatheme_list           +  +  +  ,     self            .  0      � @ �@��& �    _room_ext_datatheme_list           /  /  0     self       theme_list            5  <   	   � @ �@@�@ �     ��  �   �  & �    _room_ext_datacartridge_extra_award_list        	   7  7  7  8  8  9  ;  ;  <     self    	   cartridge_pstid    	   awards   	       a                                                   !      $   '   $   ,   :   ,   >   C   >   G   L   G   P   U   P   Y   a   Y   e   k   e   o   w   o   |   �   |   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �     �          "  $  "  &  (  &  *  ,  *  .  0  .  5  <  5  <         _ENV