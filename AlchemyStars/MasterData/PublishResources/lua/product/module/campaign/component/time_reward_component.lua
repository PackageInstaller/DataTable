LuaS 

xV           (w@U@../PublishResources/lua/product/module/campaign/component/time_reward_component.lua         .    @ A@  @ $@@@  @@ l   
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
@&     _classTimeRewardComponentICampaignComponentConstructorComponentInfoGetComponentInfoGetComponentTypeInitComponentInfoHandleTakeTimeRewardReward!Start_HandleTakeTimeRewardRewardGetReviewRewardsGetTimeRewardsClientRefreshRewardsGetTimeRewardsListGetTimeRewardStateGetTimeRewardId                  F@@ LÀ d 
@ &     _componentInfoTimeRewardComponentInfoNew                              self          _ENV 
       
   G @ b@  À F@@ LÀ d 
@ G @ f  &     _componentInfoTimeRewardComponentInfoNew         
                                    self    
      _ENV           L @ e  f   &     ComponentInfo                          self                      F @ G@À f  &     CampaignComTypeE_CAMPAIGN_COM_TIME_REWARD                           self          _ENV            @ @@ÇÀ Á@ ¤¦  &     ComponentDataHelper
ParseDatam_data_componentInfo                                    self       a_load_info       ret         _ENV $   E    0   @ A@$ 
Á FÁ@ LAÀd A ¤ ÇAA ÌÁ@  ÇÂAB@ äA ÆAB ÇÂÂB_ ÆC ÇAÃ GÂBäAÄ  æ ÇÁC ÇÄÇÁâA  C BCAB $B  & ÂD EÊBÅ& &     TakeRewardReqNew
reward_idTakeRewardRepComponentInfom_campaign_com_moduleCampaignComProtoRequestm_campaign_idm_component_idCampaignErrorTypeE_CAMPAIGN_ERROR_TYPE_SUCCESS	m_resultLogerrorC[CampaignCom][TimeRewardComponent] HandleTakeTimeRewardReward ret:_componentInfom_reward_info?[CampaignCom][TimeRewardComponent] no reward info, reward id: rec_reward_statusETimeRewardRewardStatusE_TIME_REWARD_RECVED
m_rewards         0   &   &   &   '   )   )   )   ,   ,   .   .   /   0   1   2   3   5   .   7   7   7   7   7   8   8   8   8   8   9   9   =   =   =   >   >   ?   ?   ?   ?   ?   @   @   B   B   B   D   D   E      self    0   TT    0   	asyncRes    0   	rewardID    0   request   0   	response   0   componentInfo	   0   timeRewardInfo!   0      _ENV I   T       Á   A@ @$ Á@$AA AA$ A¬  $A&     !Start_HandleTakeTimeRewardRewardGameGlobalUIStateManagerLockTaskManagerGetInstance
StartTask         M   R       F @ L@À d   @   @  ¤ÆÀ@ Ç Áä Ì@ÁEä@Å    @ ä@&     AsyncRequestResNewHandleTakeTimeRewardRewardGameGlobalUIStateManagerUnLock             N   N   N   O   O   O   O   O   O   P   P   P   P   P   P   Q   Q   Q   Q   R      TT       res      rewards	         _ENVself	rewardID	lockName	callback   J   K   K   K   K   K   K   L   L   L   L   R   L   T      self       	rewardID       	callback       	lockName         _ENV V   i    /   K    @ ¤ Æ@@ @ä B@ GÂÀ$ GAA ¢C    C JGAA ÇAÃJ)  ªüé  júË   A@ @ $@FÂA LÂd JÂJBB BÀ ¤B)  ªÁüæ  &     GetComponentInfopairsm_reward_inforewardsassetid        count
RoleAssetNewtableinsert         /   W   Y   Y   Z   Z   Z   Z   [   [   [   [   \   \   \   \   \   \   \   ]   ]   ]   ]   ]   ]   [   [   Z   Z   a   b   b   b   b   c   c   c   d   e   f   f   f   f   f   b   b   h   i      self    /   tb   /   info   /   (for generator)      (for state)      (for control)      _      v      (for generator)
      (for state)
      (for control)
      __      vv      ra   /   (for generator)    -   (for state)    -   (for control)    -   k!   +   v!   +   
roleAsset$   +      _ENV k   o       L @ d @À ¦  &     GetComponentInfom_reward_info           m   m   n   n   o      self       info           q   ~    (   L @ d @@ @ÆÀ@ ¤ Æ@@ ÇÀA ä AA ALÁÁd OÂ$ FAB Â dÂBÃFCC GÃ¤ ÇÂÃD CD  ! ÆD ÇÄJÂi  êûGÂ f &     GetComponentInfoGameGlobal
GetModuleLoginModuleSvrTimeModulemathfloorGetServerTimeü©ñÒMbP?pairsm_reward_infoGetTimeStampByTimeStrunlock_timeEnum_DateTimeZoneTypeE_ZoneType_GMTrec_reward_statusETimeRewardRewardStatusE_TIME_REWARD_LOCKE_TIME_REWARD_CAN_RECV         (   r   r   t   t   t   t   u   u   u   u   v   v   v   v   v   v   w   w   w   w   x   x   x   x   x   y   y   y   y   y   y   y   z   z   z   w   w   }   }   ~      self    (   info   (   loginModule   (   srvTime
   (   curTime   (   (for generator)   %   (for state)   %   (for control)   %   _   #   v   #   unlock_time   #      _ENV           L @ d @@ @ÇÀÀ ¤ Ü   ÁÀ Æ@A ÇÁÁ ä@ ¦  &     GetComponentInfotablecollectm_reward_info        LogerrorUTimeRewardComponent:GetTimeRewardsList() TimeRewardComponentInfo.m_reward_info = nil                                                            self       info      tb         _ENV            @ ¤ Ç@ â@   Æ@@ ÇÀÁ  @ ä@Ç@ â   À Ç@ Ç Áâ@    Á@ æ  &     GetTimeRewardsListLogerrorETimeRewardComponent:GetTimeRewardState() list[index] = nil, index = rec_reward_status                                                                                   self       index       list         _ENV            @ ¤ Ç@ â@   Æ@@ ÇÀÁ  @ ä@Ç@ â   À Ç@ Ç Áâ@    Á@ æ  &     GetTimeRewardsListLogerrorBTimeRewardComponent:GetTimeRewardId() list[index] = nil, index = 
reward_id                                                                                   self       index       list         _ENV.                              
      
                              $   E   $   I   T   I   V   i   V   k   o   k   q   ~   q                                        _ENV