LuaS 

xV           (w@d@../PublishResources/lua/product/share/ui/activity/ui_cn16_n45/main/ui_cn16_n45_main_controller.lua         R    @ A@  $@ @ AÀ   A $@À@  À@ l   
@À@ l@  
@ À@ l  
@À@ lÀ  
@ À@ l  
@À@ l@ 
@ À@ l 
@À@ lÀ 
@ À@ l  
@À@ l@ 
@ À@ l 
@À@ lÀ 
@ À@ l  
@À@ l@ 
@ À@ l 
@À@ lÀ 
@ À@ l  
@À@ l@ 
@ À@ l 
@À@ lÀ 
@ À@ l  
@À@ l@ 
@ À@ l 
@À@ lÀ 
@ &     requireui_share_controller_classUICN16N45MainControllerUIShareController_SetCommonTopButton_Back_HideUI_ShowUI_SetRemainingTime
_SetSpine
_SetImgRT_CheckGuide
_PlayAnimLoadDataOnEnterOnShowOnHide	_Refresh_UpdateRemainingTime_SetLoginBtn_SetLineBtn_SetBlackBtnIntroBtnOnClickShowBtnOnClick_AttachEvents_DetachEvents_AfterUILayerChanged_CheckActivityClose_OnItemChanged           #       F @ G@À @ ÁÀ  d A   ¤@¬   ì@   l  AA AÀ  Â A ¤ ÌAB@    @ ÀäA&  
   UICN16N45HelperGetComponent
_campaignshare
InitShareUIWidgetHelperSpawnObject
_backBtnsUINewCommonTopButtonSetData                        @ $@ &     _Back                              self                @ $@ &     _HideUI                              self                @ ¬   ì@  $@ &     OnShare                       @ $@    @@   $À@    $@   @@   $À@   $@   @@ @ $À@    $@&     _HideUIGetGameObject
_backBtns
SetActive	_showBtn_uiElements                                                                                              self                @ $@ &     _ShowUI                               self                            self   	   	   	   	   	   
   
   
               !   !   !   !   !   !   "   "   "   "   "   "   "   "   #      self       shareComponent      closeCallback	      hideCallback
      
showShare      shareCallback      obj         _ENV %   .       L @ d L@À d @ À@  L A Æ@ Ç@Ád@@ LA d@ &     ManagerCurUIStateTypeUIStateTypeUICN16N45MainControllerSwitchStateUIMainCloseDialog            &   &   &   &   &   &   &   &   '   '   '   '   '   ,   ,   .      self          _ENV 0   7       L @ Á@  ,  d@ &     
_PlayAnimhide        1   6            @ @  $@    $@    @ À  $@   $@    @   $@    $@&     GetGameObject
_backBtns
SetActive	_showBtn_uiElements           2   2   2   2   2   2   2   3   3   3   3   3   3   3   5   5   5   5   5   5   5   6          self   1   1   6   1   7      self            9   A       L @ Á@  dLÀ Ã  d@L @ ÁÀ  dLÀ Ã   d@L @ Á  dLÀ Ã  d@L@A Á ,  d@ &     GetGameObject
_backBtns
SetActive	_showBtn_uiElements
_PlayAnimshow        >   @        &                 @              :   :   :   :   :   :   ;   ;   ;   ;   ;   ;   =   =   =   =   =   =   >   >   @   >   A      self            C   J       @ A@À    A  ¤ ÌÁ@@ äAÌA@ ÀäA&     UIWidgetHelperSpawnObjectUIActivityCommonRemainingTimeSetAdvanceTextSetData            E   E   E   E   E   E   G   G   G   I   I   I   I   I   J      self       widgetName       descId       endTime       tickCallback       stopCallback       obj         _ENV L   o    ;   L @ Á@    d À@  AÆ@A ÇÁÇâ   ÁÁ"   LÂ À dAGAÂb  @	Á@ BÂB CAB $ ¤  ÇC  \Â Á hGCD ÇÃÃ¤ Çâ  @ Ä  gBý"   D  ÂÄ ¢  @ GÂÄ   GÅ BÅEÃ @  ¤B&     GetUIComponentSpineLoader_spine
_campaign_idCfgcfg_campaign_main_spine
SpineName
LoadSpine
SpineAnimGetComponentInfoUICN16N45HelperGetComponentIdlinem_pass_mission_info       ÿÿÿÿÿÿÿÿ	tonumber       CurrentSkeletonCurrentMultiSkeletonAnimationStateSetAnimation                 ;   M   M   M   M   N   N   O   O   O   P   P   Q   R   R   S   S   S   V   W   W   X   X   X   X   X   X   X   Y   Z   [   [   [   [   \   ]   ]   ]   ^   ^   ^   _   _   [   d   d   e   f   f   f   g   g   i   k   k   k   k   k   k   o      self    ;   spine   ;   campid   ;   cfg	   ;   
spineName   :   
spineAnim   :   lineComInfo   :   	passInfo   :   showSpineAnim   :   (for index)    +   (for limit)    +   (for step)    +   i!   *   data"   *   
missionid%   *   	skeleton.   :      _ENV q   z       _ À @@   AÁ  ¤ @ Ã  æ     ¦  &      GetUIComponent	RawImagerttexture           r   r   t   t   t   t   u   w   w   y   y   z      self       imgRT       rt   	        |   ~       &                 ~      self                   
   Ë    
À
ÁÊ   
Á
ÁÁÊ A_ BAB B@  Á ÇAÇAÀBÂ@@ $A À _ B@   $A &     hide	animName"uieff_UICN16N45MainController_out	duration±      show!uieff_UICN16N45MainController_inô       UIWidgetHelperPlayAnimation_anim                                                                                                   self       idx       	callback       tb	         _ENV    ¥        @ A@$ K  Á@ AÀ   @ ¤
@ AAÁ Â ¤AAB ÁA¤ 
B ÁA¤ ÇB ÌÁÂ@  ÆC ÇBÃäA&     UICN16N45HelperGetCampaignType
_campaignUIActivityHelperLoadDataOnEnterLocalDB_SetmainNew_bp_campaignUIActivityCampaignAsyncRequestResLoadCampaignInfoECampaignTypeCAMPAIGN_TYPE_BATTLEPASS                                                                ¡   ¡   ¡   ¡   ¢   ¢   ¢   £   £   £   £   £   £   £   ¥      self        TT        res        	uiParams        campaignType       componentIds       bp_res          _ENV §   ¸        @ ¤@ @@ ¤@ @ ¤@ À@ ¤@  A ¤@ @A ¤@ 
ÀA&     _AttachEvents_SetCommonTopButton
_SetSpine_UpdateRemainingTime_CheckGuide	_RefreshoverFirstTime           ¨   ¨   ª   ª   «   «   ­   ­   ´   ´   µ   µ   ·   ¸      self       	uiParams            º   ¼       L @ d@ &     _DetachEvents           »   »   ¼      self            ¾   Å       F @ G@À    Á  Á@ d@ F @ G Á    Á@ A d@ LÀA d@ L B d@ L@B d@ &  
   UICN16N45HelperSetBattlePassBtn_battlePassBtn_bp_campaignSetExchangeBtn_exchangeBtn
_campaign_SetLoginBtn_SetLineBtn_SetBlackBtn            ¿   ¿   ¿   ¿   ¿   ¿   À   À   À   À   À   À   Â   Â   Ã   Ã   Ä   Ä   Å      self          _ENV Ç   Ý       F @ G@À @ d À@  AÌ@Á ä ÏÁ¤ ÆÀA Ç ÂAB A äÁÂN  @@AC  AÂ  ¤A&  &     GameGlobal
GetModuleSvrTimeModulemathfloorGetServerTimeü©ñÒMbP?UICN16N45HelperGetComponentInfo
_campaign	exchangem_close_time        _SetRemainingTime_time"str_cn16_n45_shop_close_time_tips            É   É   É   É   Ê   Ê   Ê   Ê   Ê   Ê   Ö   Ö   Ö   Ö   Ö   ×   Ø   Ù   Ù   Ú   Ú   Ú   Ú   Ú   Û   Ý      self       svrTimeModule      curTime
      exchangeItemComponent      endTime      stamp         _ENV à   ú       A   @@ @À  ¤ ÆÀ@ Ç Á   AA  ä ,  LÁÁÁ   dA lA  AÂ @¤A ¬  ÌÁÂGC  äA &     loginUICN16N45HelperGetComponentIdUIWidgetHelperSpawnObject
_loginBtnUIActivityCommonComponentEnterSetNewnewSetRedredSetData
_campaign         ç   ê         @ @@ FÀ   $&  &     UICN16N45HelperCalcNew_Component
_campaign             è   è   è   è   è   é   ê      new         _ENVselfname í   ð         @ @@ FÀ   $&  &     UICN16N45HelperCalcRed_Component
_campaign             î   î   î   î   î   ï   ð      red         _ENVselfname ó   ø         @ @@ E    $@ @ À@ $ E  L Á Á@   @  d@ &     UICN16N45HelperLocalDB_SetNewGetCampaignTypeShowDialog$UIActivityTotalLoginAwardController             ô   ô   ô   ô   ô   ö   ö   ö   ÷   ÷   ÷   ÷   ÷   ÷   ÷   ø      campaignType         _ENVnameselfcmptId   á   ã   ã   ã   ã   æ   æ   æ   æ   æ   æ   ê   ë   ë   ë   ë   ð   ñ   ñ   ñ   ñ   ø   ù   ù   ù   ù   ú      self       name      cmptId      obj      newCallback      redCallback      clickCallback         _ENV ü   5   Q   A   @@ @À  ¤ Æ@@ ÇÀÀA @ äAA A@  Á Á $ l  AB @¤A ¬A  ÌÁBA  äA â   À ÌAÃä âA    Á â    ÂÃ$ D"B     LBDÁ Ã @  dB K  Á «B Ë  ëB  AC +C K  kC kB ÂE ¤B¬  Ä  ,Ã  LFÀ  @ dCFCF GÆ¬ ÌÃFGG  À äC&     lineUICN16N45HelperGetComponentIdGetComponent
_campaignUIWidgetHelperSpawnObject	_lineBtn*UIActivityCN16N45CommonComponentEnterLockSetNew_newSetRed_redComponentUnLockTime        GetComponentInfom_close_timeSetActivityCommonRemainingTime_time_unlock%str_cn16_n45_remain_time_in_activitystate_lockstate_unlockstate_closeSetWidgetNameGroupSetLockStateCallbackUIStateTypeUICN16N45LineControllerSetData
_campaign           	        @ @@ FÀ   $&  &     UICN16N45HelperCalcNew_Component
_campaign                         	     new         _ENVselfname           @ @@ FÀ   $&  &     UICN16N45HelperCalcRed_Component
_campaign                              red         _ENVselfname !  #        @ @@ F@ GÀÀ   d  $@  &     ToastManager
ShowToastStringTableGetstr_activity_error_110            "  "  "  "  "  "  "  #         _ENV %  '        @ @@ F@ GÀÀ   d  $@  &     ToastManager
ShowToastStringTableGetstr_activity_error_107            &  &  &  &  &  &  &  '         _ENV +  3        @ @@ E    $@ @ À@ E    $F@A GÁ    d@ FÀA G Â @BBÅ  D  d@BÀB C K  kA ¤@ &     UICN16N45HelperLocalDB_SetNew_LocalDB_GetKeyRedUIActivityHelperSetCmptRedViewedCampaignConstGetSafeStateInfo
_campaign_id_campaign_moduleSwitchState_Safe             ,  ,  ,  ,  ,  -  -  -  -  -  .  .  .  .  1  1  1  1  1  1  1  1  2  2  2  2  2  2  2  2  3     lineKey
      componentMain         _ENVnameselfcmptIdstateQ   ý   ÿ   ÿ   ÿ   ÿ                         	  
  
  
  
                                                                                        #  $  '  (  (  (  (  (  *  *  3  4  4  4  4  4  5     self    Q   name   Q   cmptId   Q   
component
   Q   obj   Q   newCallback   Q   redCallback   Q   unlockTime!   Q   
closeTime)   Q   tb=   Q   lockWithTimeCallbackA   Q   lockCallbackB   Q   closedCallbackC   Q   stateJ   Q   clickCallbackK   Q      _ENV 7        A   @@ @À  ¤ Æ@@ ÇÀÀA @ äAA A@  Á Á $ l  AB @¤A ¬A  ÌÁBA  äA â   À ÌAÃä âA    Á ÂC D $FBD GÄÂD¤ Ed BÃ¤ ¢B     ÎBCE EGÃE  $GCFÅ¤ FG_ÀÆ  CC  C bC  @  À  À GD A Ã   l  ¤C @ b  Àÿ Ë Ä AD ëC  AÄ  +D K D kD  Á «D «C ÌÃH@ äCâ    ÌÉä ÇCÉâC    Á IÄ	 Á
  C  $D ,Ä  l ¬D ÌDJ@ À 	äDÆJ ÇÄÊ	, LKÇEK   @ 
dE&  .   blackUICN16N45HelperGetComponentIdGetComponent
_campaignUIWidgetHelperSpawnObject	_hardBtn*UIActivityCN16N45CommonComponentEnterLockSetNew_newSetRed_redComponentUnLockTime        
GetModuleSvrTimeModulemathfloorGetServerTimeü©ñÒMbP?UICN16N45HelperGetComponentInfo
_campaignlinem_pass_mission_infom_need_mission_id  SetActivityCommonRemainingTime2_time_lockstr_activity_start_instate_lock_pass_lockstate_unlockstate_closeSetWidgetNameGroupGetComponentInfom_close_timeSetActivityCommonRemainingTime_time_unlock%str_cn16_n45_remain_time_in_activitySetLockStateCallbackUIStateTypeUICN16N45HardLevelSetData
_campaign         A  D        @ @@ FÀ   $&  &     UICN16N45HelperCalcNew_Component
_campaign             B  B  B  B  B  C  D     new         _ENVselfname G  J        @ @@ FÀ   $&  &     UICN16N45HelperCalcRed_Component
_campaign             H  H  H  H  H  I  J     red         _ENVselfname ^  h      F @   @@¤ @G _ÀÀ ÀE  L Á Á@ dLÁ Ã  d@FÀÁG Â   Á@  AÁ ¬  d@  E  L Ã d@ &     m_pass_mission_infoGetComponentInfom_need_mission_id GetGameObjectstate_lock
SetActiveUIWidgetHelperPlayAnimation_anime)uieff_UINCN16N45MainController_BtnUnlock      	_Refresh          b  d           @ $@ &     	_Refresh           c  c  c  d         self   _  _  _  _  _  _  _  _  `  `  `  `  `  `  `  a  a  a  a  a  a  d  a  d  f  f  f  h     first          lineComponentInfo
componentobj_ENVself q  s        @ @@ F@ GÀÀ   d  $@  &     ToastManager
ShowToastStringTableGetstr_activity_error_110            r  r  r  r  r  r  r  s         _ENV t  x        @ @@ E  LÀ d GÀÀ @   A F@A GÁ    d ÀA  BÆ@A ÇÁA @ ä ¤@  &  
   Cfgcfg_campaign_missionGetComponentInfom_need_mission_idNameStringTableGetToastManager
ShowToast"str_activity_hard_level_lock_tips            u  u  u  u  u  u  u  u  v  v  v  v  w  w  w  w  w  w  w  w  x     missionName      lvName         _ENV
component y  {        @ @@ F@ GÀÀ   d  $@  &     ToastManager
ShowToastStringTableGetstr_activity_error_107            z  z  z  z  z  z  z  {         _ENV           @ @@ E    $@ @ À@ E    $F@A GÁ    d@ FÀA G Â @BBÅ  D  d@BÀB C K  kA ¤@ &     UICN16N45HelperLocalDB_SetNew_LocalDB_GetKeyRedUIActivityHelperSetCmptRedViewedCampaignConstGetSafeStateInfo
_campaign_id_campaign_moduleSwitchState_Safe                                                                              	blackKey
      componentMain         _ENVnameselfcmptIdstate   8  :  :  :  :  <  <  <  <  <  ?  ?  ?  ?  ?  ?  D  E  E  E  E  J  K  K  K  K  N  N  N  N  N  N  N  O  O  O  P  P  P  P  P  P  Q  Q  Q  Q  Q  R  S  S  S  S  S  T  T  T  T  T  T  T  T  T  [  [  [  [  \  \  ]  ]  ]  ]  ]  ]  h  ]  h  i  i  l  l  l  l  l  l  l  l  l  l  l  l  l  l  l  l  m  m  m  n  n  n  n  n  n  n  n  o  o  o  o  o  o  s  x  {  |  |  |  |  |  ~  ~                   self       name      cmptId      
component
      obj      newCallback      redCallback      unlockTime!      svrTimeModule$      curTime*      endTime/      stamp0      lineComponentInfo5      isMissionLock>      tb_      
closeTimej      lockWithTimeCallbackq      lockCallbackr      closedCallbacks      statez      clickCallback{         _ENV          @ A  A  Á@ A¤@&     ShowDialogUIIntroLoaderUICN16N45Intro	MaskTypeMT_BlurMask                             self       go          _ENV         L @ d@ &     _ShowUI                    self                    L @ Æ@@ ÇÀÁ@ d@ L @ Æ@@ Ç ÁAA d@ L @ Æ@@ ÇÁÁA d@ &     AttachEventGameEventTypeAfterUILayerChanged_AfterUILayerChangedActivityCloseEvent_CheckActivityCloseItemCountChanged_OnItemChanged                                               self          _ENV         L @ Æ@@ ÇÀÁ@ d@ L @ Æ@@ Ç ÁAA d@ L @ Æ@@ ÇÁÁA d@ &     DetachEventGameEventTypeAfterUILayerChanged_AfterUILayerChangedActivityCloseEvent_CheckActivityCloseItemCountChanged_OnItemChanged                                               self          _ENV   £      F @ G@À d LÀ ÌÀ@ ä  d  b   @  A ¤@ &     GameGlobalUIStateManagerIsTopUIGetName	_Refresh                                ¡  ¡  £     self       topui         _ENV ¥  ¬       @ ¢   À @ @@@ À @ Á@ A¤@@A ¢   À@A @@@ À @ Á@ A¤@&     
_campaign_idSwitchStateUIStateTypeUIMain_ny_campaign            ¦  ¦  ¦  ¦  ¦  ¦  ¦  §  §  §  §  ©  ©  ©  ©  ©  ©  ©  ª  ª  ª  ª  ¬     self       id          _ENV ­  ¯       @ ¤@ &     	_Refresh           ®  ®  ¯     self       id           R                                 #      %   .   %   0   7   0   9   A   9   C   J   C   L   o   L   q   z   q   |   ~   |               ¥      §   ¸   §   º   ¼   º   ¾   Å   ¾   Ç   Ý   Ç   à   ú   à   ü   5  ü   7    7                            £    ¥  ¬  ¥  ­  ¯  ­  ¯         _ENV