LuaS 

xV           (w@¦@E:/depot_matchsrpg/matchsrpg/b/1100/client/Assets/../PublishResources/lua/product/components/ui/activity/yx/_review/ui_activity_evesinsa_switch_level_btn_review.lua         %    @ A@  @ $@@@  @@ l   
@@@ l@  
@ @@ l  
@@@ lΐ  
@ @@ l  
@@@ l@ 
@ @@ l 
@@@ lΐ 
@ @@ l  
@@@ l@ 
@ &     _class(UIActivityEveSinsaSwitchLevelBtn_ReviewUICustomWidget_GetComponentsOnShowOnHideSetData_CheckNewFlagRedPoint
_SetTitle_CheckUnlockLevelbtnOnClick_SetFirstPlot_OpenDialog    
               L@@ Α  d
@ L@@ Α  d
@LA Αΐ A d 
@LA Αΐ  d 
@ LA Αΐ A d 
@L@@ Αΐ d
@ L@@ Α@ d
@ &     	_lockObjGetGameObject_lock_normalObj_normal_remainingTextGetUIComponentUILocalizationText_titleText_title2Text	_newFlagnewFlag
_redPoint	redPoint                                                                                                               self                       
@@L@ d@ &     _isOpen_GetComponents                          self                $       
@@Fΐ@ G Α @ d 
@ Fΐ@ G Α @A d 
@&     _isOpen _timeEventUIActivityHelperCancelTimerEvent_timeEventForClose            !   "   "   "   "   "   #   #   #   #   #   $      self          _ENV '   8       
@ 

ΐ A AAG@ $ 
 A ΑA  $AB ΑA $AAB $A B $A A@ FΑB GΓ@@ AC $A &     
_campaign_type_isMain_phase UIActivityEveSinsaHelper_ReviewCheckTimePhase	_lockObj
SetActive_normalObj
_SetTitle_CheckNewFlagRedPointEActivityEveSinsaLevelBtnTypeEType_B_CheckUnlockLevel            (   )   *   +   +   +   +   +   .   .   .   .   /   /   /   /   1   1   3   3   5   5   5   5   5   6   6   8      self       	campaign       type       isMain          _ENV 9   I    '   F @ G@ΐ @ d ΐΐ €  AAA A€ΜΐAδ B FAB GΒ@ΑΒ$ GC LAΓΓ  dA@B FAB GΓ@ ΑC ACΔ€ $A  C AC  $A&     GameGlobalGetUIModuleCampaignModuleGetReviewDataGetActivityByTypeECampaignTypeCAMPAIGN_TYPE_REVIEW_N1GetRedAndNewData_typeEActivityEveSinsaLevelBtnTypeEType_AP1SStageUnLockNew
_redPoint
SetActiveEType_B	_newFlagP2StageUnLockNew         '   ;   ;   ;   ;   =   =   =   =   =   =   >   >   ?   ?   ?   ?   ?   B   B   D   D   D   D   D   E   E   E   E   E   F   F   F   F   F   G   G   G   G   I      self    '   	uiModule   '   reviewData
   '   data   '   showNew         _ENV J   [       K     Α@  k@ @  Ηΐ@ Μ ΑFAA GΑ d δ@  ΗΐA β   @Λ  A A λ@B  ΑA AAA Aΐ € $A  &     %str_activity_evesinsa_main_levelabtn%str_activity_evesinsa_main_levelbbtn_type_titleTextSetTextStringTableGet_title2Text(str_activity_evesinsa_main_actionsecondstr_activity_error_107_phase            K   L   N   N   O   O   P   P   P   P   P   P   P   R   R   R   S   T   U   W   W   X   X   Y   Y   Y   Y   Y   Y   Y   [      self       type2id      id      	phase2id         _ENV ]   s    +   G @ L@ΐ Ζ@ Ηΐΐd Α € ’    @A A  €@ΐA A €@ΐ B Α@  AΑ C ACΐ  FC GΒΓd €  ΜD@ δAΗAA ΜΑC δAΗΑA ΜΑC  δA&     
_campaignGetComponent(ECampaignReviewEvaRescuePlanComponentID,ECAMPAIGN_REVIEW_EVARESCUEPLAN_TREE_MISSIONComponentIsUnLock	_lockObj
SetActive_normalObj_remainingText<color=#%s>%s</color>DECE00)str_activity_evesinsa_main_lockbtn_levelstringformatStringTableGetSetText         +   `   `   `   `   `   b   b   b   b   d   d   d   d   e   e   e   e   e   g   h   i   m   n   n   n   n   n   n   n   n   n   o   o   o   p   p   p   p   q   q   q   q   s      self    +   	componet   +   uiText   *   
formatStr   *   	colorStr   *   strId   *   showStr   *      _ENV v          F @ G@ΐ   d@ F A G@Α A d 
@GΐA  B @B  Gΐ@ B ΐB ΐF C G@Γ C ΐCd@ L D d@ @ L@D d@ &     Loginfo3UIActivityEveSinsaSwitchLevelBtn_Review:btnOnClick_phase UIActivityEveSinsaHelper_ReviewCheckTimePhase
_campaign_typeEActivityEveSinsaLevelBtnTypeEType_BEActivityEveSinsaTimePhaseEPhase_TreeAudioHelperControllerPlayUISoundAutoReleaseCriAudioIDConstGoHome_SetFirstPlot_OpenDialog            w   w   w   w   y   y   y   y   y   z   z   z   z   z   z   z   z   z   z   {   {   {   {   {   |   |   |   ~   ~         self          _ENV    £    2   F @ G@ΐ @ d ΐΐ € Ζ A Η@Α GΑA GΒ δ AB B@$ "  ΐΑB CAA $AC $A &  AB ΑC@ $AA FD GΑΔΑA BGb  @ ΕAE_@D E Β @ ¬  €A&     GameGlobal
GetModuleRoleModule	GetPstIdstringformat'UIActivityEveSinsa_LevelBtn_Plot_%s_%s
_campaign_idLocalDBHasKeyLoginfoBUIActivityEveSinsaSwitchLevelBtn_Review:_SetFirstPlot() keyStr = _OpenDialogSetInt               Cfgcfg_campaignFirstEnterStoryID       ShowDialogUIStoryController                         @ ¬   Ε   $@ &     
StartTask                  E   L ΐ d@ &     _OpenDialog                           TT          self                             self2                                                                                                                                                       £      self    2   roleModule   2   pstId   2   keyStr   2   storyID!   2   cfg_campaign&   2      _ENV ₯   ΄    
(   G @ @@ @ @Fΐ@ G Α @A Ad@ @G @ @@ ΐA  Fΐ@ G Α @A  Bd@ K  @ Α k@ ΐB  CΖ@C € ΜCC @  ΖΑC ΗΔ  GBD GΔδ@&     _typeEActivityEveSinsaLevelBtnTypeEType_AAudioHelperControllerPlayUISoundAutoReleaseCriAudioIDConst
WindPlaceEType_BGoHome*UIActivityEveSinsaLevelAController_Review*UIActivityEveSinsaLevelBController_ReviewGameGlobal
GetModuleCampaignModuleCampaignSwitchStateUIStateTypeUIMain
_campaign_id         (   ¦   ¦   ¦   ¦   ¦   §   §   §   §   §   §   ¨   ¨   ¨   ¨   ¨   ©   ©   ©   ©   ©   ¬   ­   ―   ―   ²   ²   ²   ²   ³   ³   ³   ³   ³   ³   ³   ³   ³   ³   ΄      self    (   
type2show   (   campaignModule   (      _ENV%                                           $       '   8   '   9   I   9   J   [   J   ]   s   ]   v      v      £      ₯   ΄   ₯   ΄          _ENV