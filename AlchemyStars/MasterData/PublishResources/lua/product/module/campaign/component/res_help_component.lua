LuaS 

xV           (w@R@../PublishResources/lua/product/module/campaign/component/res_help_component.lua         .    @ A@  @ $@@@  @@ l   
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
@&     _classResHelpComponentICampaignComponentConstructor_GetLocalNextRefreshTime_SetLocalNextRefrehTimeComponentInfoGetComponentInfoGetComponentTypeInitComponentInfoHaveRedPointCloseTodayRedPointCampaignComponentPushNotifyOnUpdateBaseInfoGetBoostTimesGetNextTimestamp           	       F@@ LÀ d 
@ 
 Á&     m_component_infoCResHelpComponentInfoNewm_local_next_refresh_timeÿÿÿÿÿÿÿÿ                           	      self          _ENV           G @  @À @F@ GÀÀ  A d @Á ¤ À   Ý ÁA B@A $FB  d 
@G @ f  &     m_local_next_refresh_time        GameGlobal
GetModuleRoleModule	GetPstIdResHelpNextRefreshTimeLocalDB
GetString0	tonumber                                                                                       self       roleModule      pstid	      l_key      strNextRefreshTime      lNextRefreshTime         _ENV        	   
@ @@ @ÆÀ@ ¤ Ì Aä  AA AFA GÁÁ ÆB   ä dA  &  	   m_local_next_refresh_timeGameGlobal
GetModuleRoleModule	GetPstIdResHelpNextRefreshTimeLocalDB
SetString	tostring                                                                     self       _next_refreshTime_       roleModule      pstid      l_key
         _ENV "   '    
   G @ b@  À F@@ LÀ d 
@ G @ f  &     m_component_infoCResHelpComponentInfoNew         
   #   #   #   $   $   $   $   &   &   '      self    
      _ENV *   ,       L @ e  f   &     ComponentInfo           +   +   +   ,      self            /   1       F @ G@À f  &     CampaignComTypeE_CAMPAIGN_COM_RES_HELP            0   0   0   1      self          _ENV 3   6        @ @@ÇÀ Á@ ¤¦  &     ComponentDataHelper
ParseDatam_datam_component_info            4   4   4   4   4   5   6      self       a_load_info       ret         _ENV 9   P    *   F @ G@À d LÀ ÆÀ@ db@  @    ¦   A @AÌÁ ä ÒÀÁ¤ Ì B ä AÂ!  B GB GAÂMÁÂ
AC $ GAÂ@@ C  f GAÃÃ @ C f C  f &     GameGlobal
GameLogic
GetModuleSvrTimeModulemathmodfGetServerTimeè      GetComponentInfotmNextRefreshTimesTimem_component_infoQ     _GetLocalNextRefreshTimenTodayHelpTimesnHelpDayLimitTimes         *   :   :   :   :   :   :   ;   ;   <   <   >   >   >   >   >   >   ?   ?   A   A   A   B   B   B   B   B   E   E   F   F   F   G   G   K   K   K   K   L   L   O   O   P      self    *   	time_mod   *   
tmNowTime   *   l_component_info   *   l_local_refresh_time   *      _ENV S   ^       L @ d @@ À ¤@À@  A¤ @AA ÁAGÂ  ¤@ &  	   GetComponentInfo_SetLocalNextRefrehTimetmNextRefreshTimesTimeGameGlobalEventDispatcher	DispatchGameEventTypeCampaignComponentStepChangem_campaign_id            T   T   U   U   U   X   X   X   X   Y   Y   Z   [   X   ^      self       l_component_info         _ENV b   l        @ @@ÇÀ À À@  A¤ Æ@A ÇÁÁÁ @ äâ   À B  $A AB BAÁ $A&     CResHelpComponentNotifyType.CResHelpComponentNotifyType_ResHelpInfoChangem_notify_type!NotifyResHelpComponentInfoChangeNewComponentDataHelper
ParseDatam_dataOnUpdateBaseInfoLogerrorR[CampaignCom][ResHelpComponent] CampaignComponentPushNotify ParseData error! ret:            c   c   c   c   c   d   d   d   e   e   e   e   e   f   f   g   g   g   g   i   i   i   i   i   l      self       notify_data       ev      ret         _ENV o   v        @ ¤@ @@ ÇÀ À @@ ÇÀÀ À@@ Ç Á À &     GetComponentInfom_component_infonTodayHelpTimestmNextRefreshTimesTimenHelpDayLimitTimes           q   q   s   s   s   t   t   t   u   u   u   v      self       ev            z   }       L @ d @À ÇÀ ¦ &     GetComponentInfonTodayHelpTimesnHelpDayLimitTimes           {   {   |   |   |   }      self       cInfo                     L @ d @À ¦  &     GetComponentInfotmNextRefreshTimesTime                             self       cInfo          .                        	                        "   '   "   *   ,   *   /   1   /   3   6   3   9   P   9   S   ^   S   b   l   b   o   v   o   z   }   z                      _ENV