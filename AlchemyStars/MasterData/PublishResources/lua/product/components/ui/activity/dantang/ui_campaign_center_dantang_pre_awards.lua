LuaS 

xV           (w@j@../PublishResources/lua/product/components/ui/activity/dantang/ui_campaign_center_dantang_pre_awards.lua             @ A@  @ $@@@  @@ l   
@@@ l@  
@ @@ l  
@@@ lÀ  
@ @@ l  
@@@ l@ 
@ @@ l 
@&  
   _class!UICampaignCenterDanTangPreAwardsUIControllerLoadDataOnEnterOnShowInitWidget_OnClickAssetCollectBtnOnClick
_ReqAwardCloseBtnOnClick           #    
A   Æ @ Ç@À@ ä A AA$ 
 A $AÁ@ ÁA À B BBFB GÂÂ$A C$ "A  AC CAÁ D¤ $A  AÄD¤ Ã $A Á@ DB ÁB$"A  ÀAC ÁDA $A A  $A&  Á@ EB ÁB$
 AE F$ 
 ÁE FÁF
 &     GameGlobal
GetModuleCampaignModule
_campaignUIActivityCampaignNewSetSuccLoadCampaignInfoECampaignTypeCAMPAIGN_TYPE_INLAND_S0ECCampaignInlandS0ComponentIDTIME_REWARDGetSuccLogfatal&è¯·æ±ä¸¹æ£ é¢ç­æ´»å¨æ°æ®å¤±è´¥:
GetResultShowErrorToastCheckComponentOpenerror"ä¸¹æ£ é¢ç­å¥å±ç»ä»¶å·²å³é­
_awardCptGetComponent_awardCptInfoGetComponentInfo_awardInfom_reward_info                A               
   
   
   
                                                                                                                                                               "   "   "   "   #      self    A   TT    A   res    A   campaignModule   A      _ENV &   @    @    @ ¤@ @@ @ÇÀ@ Ì ÁAA  ä  \  (ÂÂAÂì  $B 'AþA@ ABFB GÁÂ_@  A   
 C ACB $AC ACB $AÁC ACB  $AA@ ABFB GÁÂ@   A@ ABFB GÄ@  @AD DAÁ E AB$AÁ 
 &     InitWidget_awardInforewardsawardsSpawnObjectsUIDanTangPreAwardsItem       SetData_canCollectrec_reward_statusETimeRewardRewardStatusE_TIME_REWARD_CAN_RECV_red
SetActive_collectBtn_collectedE_TIME_REWARD_RECVEDLogerror&ä¸¹æ£ é¢ç­å¥å±é¢åç¶æéè¯¯:_award_mainCampaignID         /   1           @   @ ¤@ &     _OnClickAsset           0   0   0   0   0   1      id       go          self@   '   '   )   )   +   +   +   +   +   ,   ,   ,   ,   -   -   .   1   -   ,   5   5   5   5   5   5   5   5   5   7   7   7   7   8   8   8   8   9   9   9   9   9   :   :   :   :   :   :   :   ;   ;   ;   ;   ;   ;   ;   =   =   =   =   =   =   ?   ?   @      self    @   	uiParams    @   assets   @   	uiAssets	   @   (for index)      (for limit)      (for step)      i         _ENV C   T    )   L@@ Á    d 
@ L@@ Á   d L@Á Á d
@GÀ@ LÀÁ Á  d@GÀ@ L@Â d Â ÀB ¤@@Á  ¤
 D A ¤
 D Á ¤
  D A ¤
 &     awardsGetUIComponentUISelectObjectPath_selectInfoselectInfoSpawnObjectUISelectInfoSetType       GetG3CustomPooldynamicInfoOfEngineSetObjectNameUISelectInfoDanTang.prefab_selectDetailUISelectInfoDantang_redGetGameObjectred_collectBtnCollectBtn_collected
Collected        )   F   F   F   F   F   I   I   I   I   I   I   I   I   K   K   K   K   L   L   L   M   M   M   M   O   O   O   O   Q   Q   Q   Q   R   R   R   R   S   S   S   S   T      self    )   
detailObj   )        V   Y    
   Ç @ Ì@À@ ä@Ç@ ÌÀÀGAGAÁä@&     _selectDetailSetData_selectInfo	OnlyShow
transform	position        
   W   W   W   W   X   X   X   X   X   Y      self    
   id    
   go    
        \   b    	    @ ¢@    &  @@ @ @  ¤@ &     _canCollect
StartTask
_ReqAward        	   ]   ]   ]   ^   a   a   a   a   b      self    	   go    	        d       Y    @ @@¤ Ç@ ÌÀÀ@  ÇA ÇAÁäA$ "A   ÁA B $ABB¤ ÇÁB $A B$ FC GAÃ@@ C $A &  ÁC DAD D$
 @ E$ 
 ÁD AEE
 A FFAF GÆ_@  A   
 ÁF GÁE $AAG GÁE $AG GÁE  $Aâ   À   H A À$A À H ÁHA	 $A AI I$ ÁIJ AJ$A&  *   AsyncRequestResNew
_awardCptHandleTakeTimeRewardReward_awardInfo
reward_idGetSucc
GetModuleCampaignModuleCheckErrorCode
GetResult_mainCampaignIDCampaignErrorType(E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_FINISHEDCloseDialog
_campaignGetComponentECCampaignInlandS0ComponentIDTIME_REWARD_awardCptInfoGetComponentInfom_reward_info       _canCollectrec_reward_statusETimeRewardRewardStatusE_TIME_REWARD_CAN_RECV_red
SetActive_collectBtn_collected        ShowDialogUIGetItemControllerLogerrorä¸¹æ£ é¢ç­å¥å±é¢åä¸ºç©ºGameGlobalEventDispatcher	DispatchGameEventTypeDanTangPreAwardCollected         Y   e   e   e   f   f   f   f   f   f   f   g   g   g   g   j   j   j   j   j   j   j   j   k   k   k   k   k   k   l   l   n   q   q   q   q   q   q   r   r   r   r   s   s   s   s   t   t   t   t   t   t   t   t   t   u   u   u   u   v   v   v   v   w   w   w   w   w   y   y   y   y   y   z   z   z   z   z   |   |   |   |                              self    Y   TT    Y   res   Y   assets
   Y      _ENV            @ ¤@ &     CloseDialog                       self       go                                   #      &   @   &   C   T   C   V   Y   V   \   b   \   d      d                      _ENV