LuaS 

xV           (w@s@../PublishResources/lua/product/components/ui/activity/battle_pass_cn1/main/ui_battlepass_cn1_main_controller.lua         C    @ A@  @ $@@@  @@ l   
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
@ &     _classUIBattlePassCN1MainControllerUIController_SetCommonTopButtonConstructorLoadDataOnEnterOnShowOnHide_SetTabBtns_SetTabPages_SetTabSelect_SwitchTabPage_RefreshTabPage_AttachEvents_DetachEvents_CheckActivityClose_OnComponentStepChange_CheckRedPointAll_OnActivityQuestAwardItemClickOnUIGetItemCloseInQuest_OnQuestUpdate	PlayAnimBattlePassBtnOnClick                  F @ G@À    Á  Á  d  Á ,  lA  ¤@ &     UIWidgetHelperSpawnObject	backBtnsUINewCommonTopButtonSetData         	               @ $@ &     CloseDialog           
   
   
             self                @ @  Á  $@ &     ShowDialogUIHelpController#UIActivityBattlePassMainController                                    self                                       self       obj         _ENV        
   l   
@ 
À
 ÁK   ÁÀ k@ 
@&     _tipsCallback_tabIndex_Reward       _tabIndex_Quest       _tabTitles)str_activity_battlepass_tab_reward_title(str_activity_battlepass_tab_quest_title                    @ @@Å    @   ¤@&     UIWidgetHelperSetAwardItemTips
_tipsPool                                        matid       pos          _ENVself
                                    self    
      _ENV    0       A@ @@  $
 @ Á@ À $A ¢    A$ "A    &  A@ AAG@ $A @ A $A&     
_campaignUIActivityBattlePassHelperLoadDataOnEnterReLoadCampaignInfo_ForceGetSuccGetAllGiftLocalPriceClearCampaignNew            !   !   !   !   !   !   $   $   $   $   $   '   '   '   '   '   '   (   ,   ,   ,   ,   /   /   /   /   0      self       TT       res       	uiParams          _ENV 2   A       @À 
 @ ¤@ À@  AÇ@A    ¤@A ¤@ ÀA ¤@ 
@BB ÁB ¤@ C ¤@ @C ¤@ &     
_callBack       _SetCommonTopButtonUIBattlePassStyleHelperFitStyle_Widget
_campaign_SetTabBtns_SetTabPages
_tabIndex        _SetTabSelect_tabIndex_Reward_CheckRedPointAll_AttachEvents            3   3   5   5   6   6   6   6   6   8   8   9   9   ;   <   <   <   >   >   @   @   A      self       	uiParams          _ENV C   I       G @ b   @ G @ d@ F@@ GÀ d LÀÀ Æ A Ç@Ád@LA d@ &     
_callBackGameGlobalEventDispatcher	DispatchGameEventTypeBattlePassRedPoint_DetachEvents            D   D   D   E   E   G   G   G   G   G   G   G   H   H   I      self          _ENV M   j    9   G @ @ À@À   A  A  ¤
@A Ç@@ ¤ ÀÌA@Â Ë  ÂË  AC +C K  kC ëB ÂË   K  ëB ÂË C ëB ÂÆÂC ÇÄC ä Âì  ÂÂDäA ©  *A÷  Ì@E A äAE Á $«@  
 &     _tabTitles	_tabBtnsUIWidgetHelperSpawnObjectsUIActivityCommonTextTabBtnipairsSetDataindexWidgetsonoffWidgetsOnBtnOffBtnlockWidgetstitleWidgets	txtTitle
titleTextStringTableGet	callbacklockCallback _tabBtnImageGetGameObject_tabSelect1_tabSelect2         [   _       b   À     @   ¤@&     _SetTabSelect           \   \   ]   ]   ]   ]   _      index       isOffBtnClick          self9   N   Q   Q   Q   Q   Q   Q   Q   Q   R   R   R   R   S   T   T   V   V   W   W   W   W   W   W   W   W   W   X   X   X   X   X   Y   Y   Y   Y   Z   Z   Z   Z   Z   _   _   `   S   R   R   f   g   g   g   h   h   h   i   i   j      self    9   title   9   (for generator)   /   (for state)   /   (for control)   /   i   -   v   -      _ENV l   v       F @ G@À    Á  Á  d  Á AA GA   ¤@ @ @@À   Á A ¤ Ì AGAA A À  ä@Ë    @ ë@ 
À&  
   UIWidgetHelperSpawnObject_tabRewardUIBattlePassCN1RewardMainSetData
_campaign_tipsCallback
_tabQuestUIBattlePassCN1QuestMain
_tabPages            n   n   n   n   n   n   o   o   o   o   o   r   r   r   r   r   r   s   s   s   s   s   u   u   u   u   u   v      self       
tabReward      	tabQuest         _ENV x       &    @ @@Æ@ ÇÀÀ¤@  A    &  @A    ¢@    À Ì B @ ä@Ç@B â    Ç@B A Ç â   Â"  À Â¬  $A ÁB  $A&     AudioHelperControllerPlayUISoundAutoReleaseCriAudioIDConstSoundSwitch
_tabIndex_tabIndex_Reward
quest_out	quest_in	PlayAnim
_tabPagesPlayAnimOut_SwitchTabPage                        @   $@&     _SwitchTabPage                                 selfindex&   y   y   y   y   y   z   z   z   {   ~   ~   ~   ~   ~   ~   ~                                                                        self    &   index    &   	animType   &   page   &      _ENV        	    
@ @  Ç@ Ü A  ¨À@ AÁ@_@  B   ¤AA AAA_@  B   ¤A§ûA A 
Â
Â
ÁB
B
Â¤@&     
_tabIndex       	_tabBtnsSetSelected_tabBtnImage
SetActive_RefreshTabPage	resetPosexpDataexpUpgrade anim_PlayInanim_ListItem                                                                                                               self        index        (for index)      (for limit)      (for step)      i              ¢    
    @ Ç@@ ¤  Ì@ä ÌÁÀGA _@  CB  C äA©  *ý@@ Ç A À @A  ¤@&     ipairs
_tabPagesGetGameObject
SetActive
_tabIndexRefresh_ByParams                                                         ¡   ¡   ¡   ¡   ¡   ¡   ¢      self       params       (for generator)      (for state)      (for control)      i      v         _ENV «   ±       L @ Æ@@ ÇÀÁ@ d@ L @ Æ@@ Ç ÁAA d@ L @ Æ@@ ÇÁÁA d@ L @ Æ@@ Ç ÂB d@ L @ Æ@@ Ç@ÂB d@ &     AttachEventGameEventTypeActivityCloseEvent_CheckActivityCloseCampaignComponentStepChange_OnComponentStepChangeActivityQuestAwardItemClick_OnActivityQuestAwardItemClickOnUIGetItemCloseInQuestQuestUpdate_OnQuestUpdate            ¬   ¬   ¬   ¬   ¬   ­   ­   ­   ­   ­   ®   ®   ®   ®   ®   ¯   ¯   ¯   ¯   ¯   °   °   °   °   °   ±      self          _ENV ³   ¹       L @ Æ@@ ÇÀÁ@ d@ L @ Æ@@ Ç ÁAA d@ L @ Æ@@ ÇÁÁA d@ L @ Æ@@ Ç ÂB d@ L @ Æ@@ Ç@ÂB d@ &     DetachEventGameEventTypeActivityCloseEvent_CheckActivityCloseCampaignComponentStepChange_OnComponentStepChangeActivityQuestAwardItemClick_OnActivityQuestAwardItemClickOnUIGetItemCloseInQuestQuestUpdate_OnQuestUpdate            ´   ´   ´   ´   ´   µ   µ   µ   µ   µ   ¶   ¶   ¶   ¶   ¶   ·   ·   ·   ·   ·   ¸   ¸   ¸   ¸   ¸   ¹      self          _ENV »   ¿        @ ¢   À @ @@@ À @ Á@ A¤@&     
_campaign_idSwitchStateUIStateTypeUIMain            ¼   ¼   ¼   ¼   ¼   ¼   ¼   ½   ½   ½   ½   ¿      self       id          _ENV Á   Å    
   @ "  @@ A@@ @ @ $A &     
_campaign_id_CheckRedPointAll        
   Â   Â   Â   Â   Â   Â   Â   Ã   Ã   Å      self    
   campaign_id    
   component_id    
   component_step    
        Ç   Ï    	*   G @ @@ G LÀ ÁÀ  d A ¢   @@A AÇ A ¤ ¢@       ÌÀÁ @ ä@Ç @ B Ç ÌÀAÁ  äA "   AA ABGA  ÁÁ  $"A      LÁÁÀ dA&     	_tabBtns_tabIndex_RewardGetGameObjectred
_campaignUIActivityBattlePassHelperCalcRed_Reward
SetActive_tabIndex_QuestCalcRed_Quest                              *   È   È   È   È   È   È   É   É   É   É   É   É   É   É   É   É   Ê   Ê   Ê   Ì   Ì   Ì   Ì   Ì   Ì   Í   Í   Í   Í   Í   Í   Í   Í   Í   Í   Í   Í   Í   Î   Î   Î   Ï      self    *   obj   *   show   *   obj   *   show&   *      _ENV Ñ   Ó       Ç @   @ ä@&     _tipsCallback           Ò   Ò   Ò   Ò   Ó      self       matid       pos            Õ   Þ    	    @ A 
À
À
@
Á
Á¤@&     _RefreshTabPage	resetPosexpDataexpUpgradeanim_PlayIn anim_ListItem        	   ×   ×   Ø   Ù   Ú   Û   Ü   ×   Þ      self    	   type    	        à   é    	   L @ Ë@ ÊÀÊÀÊ@ÊÀÊ@d@&     _RefreshTabPage	resetPos expDataexpUpgradeanim_PlayInanim_ListItem        	   â   â   ã   ä   å   æ   ç   â   é      self    	        í   ú    %   Ç @ â@    &  Ë@   
Á@
AAÊ   
ÁA
AAÊ   
AB
BÊ   
C
ACÊ   
ÁC
ACÊ D AD@   ÇAÇÀBA@  $A&     viewin	animName'UIeff_UIBattlePassCN1MainController_in	duration      buy_in*UIeff_UIBattlePassCN1MainController_buyinbuy_out+UIeff_UIBattlePassCN1MainController_buyout§       	quest_in,UIeff_UIBattlePassCN1MainController_QuestinÈ       
quest_out-UIeff_UIBattlePassCN1MainController_QuestoutUIWidgetHelperPlayAnimation_anim         %   î   î   î   ï   ò   ó   ó   ó   ó   ô   ô   ô   ô   õ   õ   õ   õ   ö   ö   ö   ö   ÷   ÷   ÷   ÷   ù   ù   ù   ù   ù   ù   ù   ù   ù   ù   ù   ú      self    %   type    %   	callback    %   tb   %      _ENV ü   þ       F @ G@À d LÀ ÁÀ    FA GAÁA ÁAd@ &     GameGlobalUIStateManagerShowDialogUIShopControllerShopMainTabTypeSecretMarketTypeShop_BattlePass            ý   ý   ý   ý   ý   ý   ý   ý   ý   ý   ý   þ      self          _ENVC                                          0      2   A   2   C   I   C   M   j   M   l   v   l   x      x               ¢      «   ±   «   ³   ¹   ³   »   ¿   »   Á   Å   Á   Ç   Ï   Ç   Ñ   Ó   Ñ   Õ   Þ   Õ   à   é   à   í   ú   í   ü   þ   ü   þ          _ENV