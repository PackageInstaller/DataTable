LuaS 

xV           (w@o@../PublishResources/lua/product/components/ui/activity/ui_activity_time_login/ui_activity_time_login_cell.lua         F    @ A@  @ $@@@  @@ l   
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
@&     _classUIActivityTimeLoginCellUICustomWidgetOnShowOnHideSetData	_Refresh_SetRemainingTime	_SetDesc_GetFormatStr	_SetText	_SetItem
_SetState_SetState_LockTime_SetState_RecvTime_SetState_ExpireProgress_SetSelected
_SetAlpha_OnRecvClick_OnReceiveRewards
BgOnClickCanRecvBtnOnClickExpireCanRecvBtnOnClickPlayAnimationInSequence                  &                       self       	uiParams               	       &                 	      self                  	    
@ 

À 
@

À
 LÂA dB LB À dB&  	   
_campaign_component_cfg_componentProgress_refreshCallback_selectCallback_tipsCallback	_Refresh_SetSelected                                                  	   self       	campaign       
component       cfg       isSelected       componentProgress       refreshCallback       selectCallback       tipsCallback               '       L @ d@ L@@ d@ L@ d@ GÀ@ L Á Ç@A ÇÁdÀA   ¤@ B   ¤@&  	   	_SetDesc	_SetText	_SetItem_componentGetCellState_cfgID
_SetState
_SetAlpha                         !   !   $   $   $   $   $   %   %   %   &   &   &   '      self       state           )   5       F@ GAÀ  À   d "  @ ÁÀ¤A Á  ¤AAÁ D  A ¤A&     UIWidgetHelperSpawnObjectUIActivityCommonRemainingTimeSetCustomTimeStr_Common_2SetAdvanceTextSetData_refreshCallback            +   +   +   +   +   +   -   -   .   .   2   2   2   4   4   4   4   4   5      self       widgetName       descId       endTime       customTimeStr       obj         _ENV 7   @    
   G @ G@À  @ @ÌÀ@ @ äÁ@  $FA GAÁ À  d ÁA BÀ  B @¤A &  
   _cfg
StartTime
CloseTime_GetFormatStrStringTableGet"str_activity_time_login_cell_descUIWidgetHelperSetLocalizationText_desc            8   8   9   9   ;   ;   ;   <   <   <   >   >   >   >   >   >   ?   ?   ?   ?   ?   ?   @      self       start      close      	startStr      	closeStr
      str         _ENV B   G    	    @ @@Æ@ ¤ ÌÀ@@ A AAä A @$ FÁA GÂA ÇBÂBe f  &     GameGlobal
GetModuleLoginModuleGetTimeStampByTimeStrEnum_DateTimeZoneTypeE_ZoneType_GMT_timeStringTableGet)str_activity_time_login_cell_time_formatmonthday            C   C   C   C   D   D   D   D   D   E   E   E   F   F   F   F   F   F   F   G      self       timeStr       loginModule      t	      d         _ENV I   U       K@ J@@JÀ@J@AJ@AJ Â@B À  ¤  Á ÂB C@ $ AB ÝAC ÂC@  À$B ©  *ü&     _txt_stateCanReceivestr_activity_common_can_get_txt_stateReceived"str_activity_common_state_taken_3_txt_stateExpireShow)str_activity_time_login_cell_expire_lock_txt_stateExpireLock_txt_stateCan(str_activity_time_login_cell_expire_getpairs- StringTableGet -UIWidgetHelperSetLocalizationText            J   K   L   M   N   O   Q   Q   Q   Q   R   R   R   R   R   R   R   S   S   S   S   S   S   Q   Q   U      self       tb      (for generator)	      (for state)	      (for control)	      widgetName
      id
      str         _ENV W   f    +   K    @ Ç@@ ÇÀ¤ ÀÆÁ@ ÌÁä AÊBÊBB B@ $B©  *AüÀB  C  ¤@  @C CÀ   Á A  ¤Æ @   ä À BÄ ÇD $B é  jAþ&     ipairs_cfgRewards
RoleAssetNewassetid       count       tableinsert_componentProgressRemoveProgressItemInTableUIWidgetHelperSpawnObjects
_itemPoolUIActivityTimeLoginCellItemSetData_tipsCallback         +   X   Y   Y   Y   Y   Y   Z   Z   Z   [   [   \   \   ]   ]   ]   ]   ]   Y   Y   `   `   `   `   `   b   b   b   b   b   b   b   c   c   c   c   d   d   d   d   c   c   f      self    +   rewards   +   (for generator)      (for state)      (for control)      _      v      
roleAsset	      objs    +   (for generator)#   *   (for state)#   *   (for control)#   *   i$   (   v$   (      _ENV h   {    E    Æ @ Ç@À A  +A  Æ @ ÇÀÀ A +A  Æ @ Ç@Á A Á +A  Æ @ Ç Â AA +A  Æ @ ÇÂ AÁ +A  Æ @ Ç Ã AA +A  ÆC ÇÀÃ   @ äC D@ $A@ A@   AD $A  @ Á@   D $A @@ B  @ ÁD $A &     ETimeLoginRewardStatusE_TIME_LOGIN_REWARD_LOCK_state_lockE_TIME_LOGIN_REWARD_CAN_RECV_state_canReceiveE_TIME_LOGIN_REWARD_RECVED_state_received_txt_stateReceived E_TIME_LOGIN_REWARD_EXPIRE_SHOW_state_expireShow E_TIME_LOGIN_REWARD_EXPIRE_LOCK_state_expireLockE_TIME_LOGIN_REWARD_EXPIRE_CAN_state_expireCanUIWidgetHelperGetObjGroupByWidgetNameSetObjGroupShow_SetState_LockTime_SetState_RecvTime_SetState_ExpireProgress         E   i   j   j   j   j   j   j   k   k   k   k   k   k   l   l   l   l   l   l   l   m   m   m   m   m   m   n   n   n   n   n   n   o   o   o   o   o   o   q   q   q   q   q   r   r   r   r   r   t   t   t   t   u   u   u   v   v   v   v   w   w   w   x   x   x   x   y   y   {      self    E   state    E   tb&   E   objs+   E      _ENV }       
   G @ G@À @ À@Æ A ¤ Ì@A@ A ÁAä B A Á  C $A &     _cfg
StartTimeGameGlobal
GetModuleLoginModuleGetTimeStampByTimeStrEnum_DateTimeZoneTypeE_ZoneType_GMT_SetRemainingTime
_timePool&str_activity_time_login_cell_wait_get            ~   ~                                                      self       start      loginModule      endTime         _ENV        
   G @ G@À @ À@Æ A ¤ Ì@A@ A ÁAä B A Á  C $A &     _cfg
CloseTimeGameGlobal
GetModuleLoginModuleGetTimeStampByTimeStrEnum_DateTimeZoneTypeE_ZoneType_GMT_SetRemainingTime
_timePool&str_activity_time_login_cell_wait_get                                                                     self       start      loginModule      endTime         _ENV        	   G @ L@À Ç@ ÇÀÀd@  AÆ@A ÇÁ   AÁ  Á   ä@ &  	   _componentGetCellPointCount_cfgIDPointCountUIWidgetHelperSetLocalizationText_txt_stateExpireShowProgress/                                                                  self       count      	maxCount         _ENV            @ A  ¤@  ¤@&     GetGameObject_selectedFg
SetActive                                   self       isSelected                       @ @@    ¢@    À  Ì A AA  ä Ê&     ETimeLoginRewardStatusE_TIME_LOGIN_REWARD_RECVED      à?       GetUIComponentCanvasGroup_alphaGroupalpha                                                         self       state       alpha      obj         _ENV    ©       G @ G@À b@    A  À@  A  l  ¤@ &     _cfgIDÿÿÿÿÿÿÿÿ_component#Start_HandleReceiveTimeLoginReward         ¢   §        À @@@ @ÁÀ   A ¤@   @A   @ ¤@ &      Logerror-UIActivityTimeLoginCell:_OnRecvClick() id = , rewards = nil_OnReceiveRewards             £   £   ¤   ¤   ¤   ¤   ¤   ¤   ¦   ¦   ¦   ¦   ¦   §      res       rewards          _ENVidself                          ¡   §       ©      self       id         _ENV «   Á    
   Ç @ @À  &  ÌÀ ä â   @ÌÀ@ FA GAÁä@Á ÁA B@  A À l  $A @ÇÀB Ì ÃGAÃ ¬A  ì  ä@&     view GetSucc
_SetStateETimeLoginRewardStatusE_TIME_LOGIN_REWARD_RECVED(uieff_UIActivityTimeLogin_Cell_Cell_GetUIWidgetHelperPlayAnimation_animM      
_campaignCheckErrorCode	m_result         ³   ¶     
    À @@    $	   @À@ E   $@ &     _componentProgressRemoveProgressItemInTableUIActivityHelperShowUIGetRewards          
   ´   ´   ´   ´   ´   µ   µ   µ   µ   ¶          rewardsself_ENV º   ¼            @ $@ &     	_Refresh           »   »   »   ¼          self ½   ¾        &                 ¾              ¬   ¬   ¬   ­   ¯   ¯   ¯   ¯   °   °   °   °   ²   ³   ³   ³   ³   ³   ³   ¶   ³   ¶   ¸   ¸   ¹   ¼   ¾   ¸   Á      self       res       rewards       	animName         _ENV Å   É        @ ¢   @  @ ¤@ &     _selectCallback           Æ   Æ   Æ   Ç   Ç   É      self       go            Ë   Í        @ ¤@ &     _OnRecvClick           Ì   Ì   Í      self       go            Ï   Ñ        @ ¤@ &     _OnRecvClick           Ð   Ð   Ñ      self       go            Ô   ×    	    À @@ ÆÀ@ Ç Á   AA A Á   ä@ &                           UIWidgetHelperPlayAnimationInSequence_anim"uieff_UIActivityTimeLogin_Cell_in            Õ   Õ   Õ   Ö   Ö   Ö   Ö   Ö   Ö   Ö   Ö   ×      self       index       delay         _ENVF                                 	                  '      )   5   )   7   @   7   B   G   B   I   U   I   W   f   W   h   {   h   }      }                                          ©      «   Á   «   Å   É   Å   Ë   Í   Ë   Ï   Ñ   Ï   Ô   ×   Ô   ×          _ENV