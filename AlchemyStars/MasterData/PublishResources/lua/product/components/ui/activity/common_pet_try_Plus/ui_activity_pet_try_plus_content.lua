LuaS �

xV           (w@q@../PublishResources/lua/product/components/ui/activity/common_pet_try_Plus/ui_activity_pet_try_plus_content.lua         C    @ A@  $@ �@ A�  � A $@��@  ���@ l   
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
@��& �    require"ui_side_enter_center_content_base_classUIActivityPetTryPlusContentUISideEnterCenterContentBaseConstructorDoInitDoShowDoHide
DoDestroyLoadDataOnEnterGetComponentsOnShowCreateOffsetTabCreateData	InitListOnValue	SetState	ShowTips_SetRemainingTimeOnHide
BgOnClickBtnGotoOnClickBtnTryOnClick           	       L @ d@ & �    CreateOffsetTab                 	      self                      � �   ��@� 
� �b   � ���� �@    ��   
� �� �   ��@� 
� ���A � B
� ���B 
���& �    _campaignTypecampaign_type_componentIdscomponent_ids_campaignIdcampaign_id_componentId$ECCampaignInlandFirstPetComponentIDLine_MISSION
_campaign_data                                                                              self       params          _ENV    #       L @ �   d@�L�@ ��  A AAd� 
@��G�A L � �@B d��
@ �L�B d@ L�B d@ L C d@ & �    
StartTaskatlasProperty	GetAssetProperty.spriteatlas	LoadTypeSpriteAtlas_component
_campaignGetComponent_componentIdGetComponentsCreateDataOnValue                   F @ L@� �   d@�& �    
_campaignClearCampaignNew                             TT          self                                                     !   !   "   "   #      self          _ENV %   *       G @ b   ��F@@ G�� d�� L�� � @ d@�
 A�& �    _eventGameGlobalTimerCancelEvent             &   &   &   '   '   '   '   '   '   (   *      self          _ENV ,   -       & �                -      self            /   K    4   A�
 ���
 �A AAF�A $� FB LA�d� 
@��G�A L����   G@ ��@ dA L�Bd� b  ��G�A L�ǁ@ d��bA  @���C ��C�����DBCC� �A �AD �A & � ��D� �A���L�D�AC�A ED� dA LAD dA & �    _campaignTypeId       _componentTypeId       GameGlobal
GetModuleCampaignModule
_campaignUIActivityCampaignNewLoadCampaignInfoGetSuccCheckComponentOpen	m_resultCampaignErrorType'E_CAMPAIGN_ERROR_TYPE_COMPONENT_UNLOCKShowErrorToastCloseDialogSetSuccCheckErrorCode_id         4   0   0   1   1   3   3   3   3   6   6   6   6   7   7   7   7   7   7   7   8   8   8   8   9   9   9   9   :   :   ;   ;   ;   =   =   =   =   >   >   ?   E   E   E   E   H   H   H   H   H   H   I   I   K      self    4   TT    4   res    4   	uiParams    4   campaignModule   4   open   *      _ENV M   W    +   L@@ ��  �  d� 
@ �L@@ �@ �  d� 
@ �L@@ ��  d� 
@ �L@@ �� � d� 
@��L@@ �  A d� 
@��L�C �  d��
@ �L�C �@ d��
@��L�C �� d��
@ �L@@ �@ � d� 
@ �& �    	_petPoolGetUIComponentUISelectObjectPathpetPool_petPoolGroupGridLayoutGroup_tipsUILocalizationTexttips_awardCountawardCount
_itemIconRawImageLoader	itemIcon_passGoGetGameObjectpassGo_red_notPassGo
notPassGo_anim
AnimationUIActivityPetTryController        +   N   N   N   N   N   O   O   O   O   O   P   P   P   P   P   Q   Q   Q   Q   Q   R   R   R   R   R   S   S   S   S   T   T   T   T   U   U   U   U   V   V   V   V   V   W      self    +        Y   r    *   � @ �@@_�@ �� @ �@@�   �@ & � � � 
�����@ �@   ��@A ��A�� �@ & � �@A � B�@ �@ �@���B  FAC G���� 
� �
 ���@� 
� ���� 
� �� E �@ �@E �@ ��E �@ & �    UISideEnterCenterContentBaseOnShow _CampaignId       Logerror;###[UIActivityPetTryPlusContent] self._CampaignId is nil !debug7###[UIActivityPetTryPlusContent] self._CampaignId --> atlasProperty	GetAssetProperty.spriteatlas	LoadTypeSpriteAtlas	_currIdx_getPassCallback       _goBattleCallback       GetComponentsCreateDataOnValue         *   Z   Z   Z   Z   [   [   [   [   \   _   _   `   `   `   a   a   a   a   b   d   d   d   d   d   g   g   g   g   g   g   j   l   l   m   m   o   o   p   p   q   q   r      self    *   	uiParams    *      _ENV t   �    k   K ��  �@  �  A�  �� �@ �   A�  �A �� �@  A� ��  ��   +A K � ��  B C  kA � �� �  A� �  �A k@�
@ �K �� � �  A A�  �@ �@� �   A� ��  +A K �� ��  kA �@ �K � ��  kA � � �  �A �  A�  �A +A�K � �A �  �A � B A�  �A  AB ��  +B K �B ��  kB kA ��� �  A�  �A  A�  ��  +B K ��  ��  kB � ��  �  �B � �  A�  �B �A�k@�
@ �& �    _itemSizeTab       +              �      s�������      o�������C      r�������      t�������_offsetTab�      �       x       n       (               k   v   v   x   x   x   x   x   x   y   y   y   y   y   y   z   z   z   z   z   z   {   {   {   {   {   {   |   |   |   |   |   }   }         �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    k        �   �    c   G @ L@� d� ��@ ��@�@  �@ ��� �@  ���@A ǀ�� @� � �@ & � @ ��@B
� �ƀ@ ���  � �@ CK  $� G�C
@��G@ L��AC d��
@��K  
@��AA ��D� �A h��K  ��D�J����BE�J����E�J���������B  @��BA ǂ� G���B�& � Ƃ@ ǂ�C  GG
C��� �B��B�J�ǂGH CH��H ��H�� �I�DG��$�  J���I �IGJ$� J���JJ��KJ��CK �KGCD ��$C�g��& � /   _componentGetComponentCfgIdCfgcfg_activity_pet_try_contentComponetntIDLogerrorGUIActivityPetTryPlusContent:CreateData() cfg_activity_pet_try_content[] is nil !       
_cfg_datacfg_petcfg_pet_element_missionidCampaignMissionId_passIsPassCamMissionID_dataPetIDpetidcgPetCGsortidSortId9###[UIActivityPetTryPlusContent] cfgPet is nil ! id --> iconcfg_pet_tagsIDTagsIconFirstElementelementatlasProperty
GetSpriteUIPropertyHelperGetInstanceGetColorBlindSpritenameStringTableGetNamestarStarlogoLogotableinsert         c   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    c   componentCfgId   c   	cfg_data   c   cfg_pet   c   cfg_pet_element   c   (for index))   b   (for limit))   b   (for step))   b   i*   a   data+   a   cfgPet6   a   fH   a      _ENV �   �    6   F @ G@� ��@ d� ��@ �@ � A �@�A� �� �@ � A � �� 
����@B �@�� G�A \��� (A��A �!@���L�B�� dB�LC���@ �GÁ�CCdB � �L�B�  dB�'��C FD ��B�ADd��
A���C FD ��D� d��
A�& �    tablecount_data_itemSizeTab	_petPoolSpawnObjectsUIActivityPetTryPlusItem_poolsGetAllSpawnList_offsetTab       ActiveSetData       _petPoolGroup	cellSizeVector2       spacing                        6   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   	   self    6   count   6   	sizedate   6   offset   6   (for index)   )   (for limit)   )   (for step)   )   i   (   item   (      _ENV �   �       L @ d@ L@@ d@ G�@ L�� d� G � �@A � A� �� �� �@ & �    	InitList	ShowTips_componentGetComponentInfom_close_time_SetRemainingTime
_timePool$str_activity_common_remainingtime_3           �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       endTime           �   �       G @ �@@ ��@ � �@���@ ��@� �@�� A ��@� �@�& �    _pass_passGo
SetActive_notPassGo_red           �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       pass           �   �    =   G @ �@@ ��@�@ �@  @���@ � �A @� �@�& � ǀA� A� �    ����  @����B��A��A@ ǁ�ǁ��A  @��@ AA� � $B�& � G�BC �CG��$� FBC G��� �   d� �BD ��D ��B���D ��D  �A��E �AE ��A���E �A & �    _missionidCfgcfg_campaign_missionLogerrorC###[UIActivityPetTryPlusContent] cfg_camp_misison is nil ! id --> ClientShowAward                      	cfg_item;###[UIActivityPetTryPlusContent] cfg_item is nil ! id --> IconStringTableGetName&str_activity_common_pet_try_down_tips_tipsSetText_awardCount
_itemIcon
LoadImage	SetState         =   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   
   self    =   
missionid   =   cfg_camp_misison   =   clientShowAward   =   
itemcount   =   	itemicon   =   itemid   2   	cfg_item   2   	itemname(   2   tipsTex.   2      _ENV �   	      F@ GA��  �� �  d� "  @ �����A ��  �A��A� �D� �A�& �    UIWidgetHelperSpawnObjectUIActivityCommonRemainingTimeSetCustomTimeStr_Common_1SetAdvanceTextSetData            �   �   �   �   �   �                         	     self       widgetName       descId       endTime       customTimeStr       obj         _ENV         G @ b   ��F@@ G�� d�� L�� � @ d@�
 A�& �    _eventGameGlobalTimerCancelEvent                                      self          _ENV   $      � @ A  �@���@ �   � ���@ ��@ �@��@A �   ����A ��A��� � BAA �@�
@��A ��A��� ��B� l  �� 
���& �    Lock&UIActivityPetTryPlusContent:bgOnClick_animPlayuieff_PetTry_Out_eventGameGlobalTimerCancelEvent 	AddEventM                 "    	       @ �@  $@��@�    A $@ & �    UnLock&UIActivityPetTryPlusContent:bgOnClick_event CloseDialog        	              !  !  !  "         self                                                     "    #  $     self       go          _ENV &  2   	   � @ �@@�� �     �& � ��@ ��@� A �� �@AǀA ���B�AB ��B��  ��A� $A �B$A & �    
_campaign#CheckCampaignClose_ShowClientErrorGameGlobal
GetModuleQuestModule	uiModule
_cfg_dataPrizePoolIdSetJumpUIDataUIJumpTypeUI_JumpDrawJump            (  (  (  (  (  )  -  -  -  -  -  /  /  0  0  0  0  0  0  0  1  1  2     self       go       jumpModule      jumpParams         _ENV 5  F   	   � @ �@@�� �     �& � ��@ �@ ���� A�  GAA ��A ��A�� ǁA ��� +A  LA�ƁB ���  dA L��  dA�& �    
_campaign#CheckCampaignClose_ShowClientError
GetModuleMissionModuleTeamCtx_missionid_componentGetCampaignMissionComponentIdGetCampaignMissionParamKeyMapInitTeamOpenerType	CampaignShowDialogUITeams            7  7  7  7  7  8  <  <  <  >  >  ?  @  A  A  A  B  B  B  C  D  D  D  D  D  E  E  E  F     self       go       missionModule	      ctx      param         _ENVC                                 	                  #      %   *   %   ,   -   ,   /   K   /   M   W   M   Y   r   Y   t   �   t   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   	  �           $    &  2  &  5  F  5  F         _ENV