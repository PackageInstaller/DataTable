LuaS �

xV           (w@y@../PublishResources/lua/product/components/ui/ui_haute_couture_draw_gl/_Review/ui_haute_couture_draw_main_gl_review.lua         @    @ A@  ��@ $@�@@  ��@@ l   
@��@@ l@  
@ �@A l�  
@ �@@ l�  
@��@@ l  
@ �@@ l@ 
@��@@ l� 
@ �@@ l� 
@��@@ l  
@ �@@ l@ 
@��@@ l� 
@ �@@ l� 
@��@@ l  
@ �@@ l@ 
@��@@ l� 
@ �@@ l� 
@��@@ l  
@ �@@ l@ 
@��@@ l� 
@ �& �    _class UIHauteCoutureDrawMainGL_ReviewUIHauteCoutureDrawBaseConstructorOnShowUIHauteCoutureDrawBgGLOnHideGetEnterAniKeyInitWidgets
GetCoinId	_OnValue_LoadVideo_LoadPrize_RefreshRewardItemCountChangedIsAllAwardCollectedHandleDrawBtnClickCanDrawSpecialAward	DrawAnimCheckAllPrizeCollectedCheckAndDoEnterAni_EnterRootDuplicateTipOnClick                  K   
@ �
���& �    _allPrizes_EnterAniKey            
   
            self                      � @ �@ �@@ �@ ��@ �@ AGA �@ �@A �@ ��A �@ ��A B @  �@ & � 	   InitWidgets	_OnValueAttachEventGameEventTypeItemCountChanged_LoadPrizeCheckAllPrizeCollected
StartTaskCheckAndDoEnterAni                                                                     self       	uiParams          _ENV           L @ �@@ ǀ��@ d@ & �    DetachEventGameEventTypeItemCountChanged                                 self          _ENV    $       G @ b@  @�F@@ G�� ��@ d� � � �� �  A � �
� �G @ f  & �    _EnterAniKeyGameGlobal
GetModuleRoleModule	GetPstIdLashShowCoutureEnter                                         !   !   !   !   #   #   $      self       roleModule      pstId	         _ENV &   8    )   L @ d@ L�@ ��   d� 
@��L�@ ��  � d� 
@��L�@ ��   d� 
@��L�B �� d��
@��L�@ �@ � d� 
@ �L�@ ��   d� 
@��L�B �  d��
@��L�@ �� � d� 
@ �& �    InitWidgetsBase
_prizeTopGetUIComponentUISelectObjectPathPrizeListTop_prizeBottomPrizeListBottom_specialItemSpecialItem_rootGoGetGameObjectRoot	_rootAni
AnimationRootAni_enterAniPoolEnterAnimation_enterAniGo
drawTitleRollingText        )   (   (   ,   ,   ,   ,   ,   .   .   .   .   .   /   /   /   /   /   1   1   1   1   2   2   2   2   2   4   4   4   4   4   5   5   5   5   7   7   7   7   7   8      self    )        :   <       F @ G@� f  & �    RoleAssetID!RoleAssetDrawCardSeniorSkinGL_Re            ;   ;   ;   <      self          _ENV >   A       G @ L@� ƀ@ ��� �  d@  & �    
drawTitleRefreshTextStringTableGetstr_senior_skin_draw_des_gl            @   @   @   @   @   @   @   A      self          _ENV D   G       F @ L@� d� L�� ��@ � ��@�� � ��A Bd� �@B  � �@�& � 
   ResourceManagerGetInstanceGetAssetPathcontroller_cfg
VideoName.mp4	LoadType
VideoClip
LoadVideo            E   E   E   E   E   E   E   E   E   E   E   E   F   F   F   G      self       url         _ENV J   �    �   F @ G@� ��@ d� ��� �� �@A � �
� ��@A ǀ�
� �� B �@�A  GA 
A�� 
�����B � ��A l  �@�̀� G�A ��A � 
����� AA �AK  �� ��B ��  � � �A��B�B �D_ � ��B �D@���D$C���� �AE ́�A� � �A �F ́�A� �����A �AE �A�� � \��� (�ÂGÂ�C����C̃F@��DA �A	�    F�B G��
�EC � d��C  ��B ���G @ �C�'B�F BF$� A� � �� hB�G�����΃�������� �DA ��	  @ ��B ��F�EC  ���$D  �B �DGG ��$D�g��   @�GBG L���� d���B ̂�@ �CA �A��   F�B G���DC ��d��B  ��B ���G @��B�L�G dB LH �B d��L���BC ��`���  ��B  �� dB�& � $   GameGlobal
GetModuleCampaignModuleGetCurHauteCouture_Review_componentIdcontroller_componentInfo_prizesCfg!cfg_component_senior_skin_weightComponentIDtablesort_replaceIdxs#GetSeniorSkinDuplicateRewardIndexs       count
       RewardSortOrderinsert       
_prizeTopSpawnObjectsUIHauteCoutureDrawPrizeItemGL_prizeBottomGetAllSpawnListSetData
icontains_allPrizes_specialItemSpawnObject_RefreshRewardGetGameObjectduplicateTip
SetActive                 S   U       � @ � � `��  ��@  � � �  & �    RewardSortOrder           T   T   T   T   T   T   T   U      a       b           �   K   K   K   K   L   L   N   N   N   O   O   O   P   P   P   P   P   P   P   Q   Q   R   U   Q   X   X   X   X   X   Z   \   \   ]   ^   ^   ^   ^   ^   ^   ^   _   a   b   b   b   c   c   c   c   c   ^   h   i   i   i   i   i   k   k   k   k   k   k   n   n   n   o   o   o   o   p   q   r   r   s   s   s   s   s   s   s   s   s   s   s   s   t   t   t   t   t   o   x   x   x   y   y   y   y   z   {   {   |   |   }   }   }   }   }   }   }   }   }   }   }   }   ~   ~   ~   ~   ~   y   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    �   campaignModule   �   ctx   �   specialIndex   �   prizes    �   idList!   �   (for index)'   3   (for limit)'   3   (for step)'   3   i(   2   prize)   2   specailPrizeOrder*   2   topItemNum4   �   	topPoolsB   �   (for index)E   \   (for limit)E   \   (for step)E   \   iF   [   itemG   [   
sortOrderH   [   idxJ   [   bottomPoos_   �   (for index)b   z   (for limit)b   z   (for step)b   z   ic   y   itemd   y   
sortOrderf   y   idxh   y   item�   �   
sortOrder�   �      _ENV �   �    `   G @ b    �F@@ � @ d ������� ��@ ��BA �A�A@ 䁀���$B�B��  $B�i�  ��L�B d� b    �G�B L � �   d@�@�F@C G�� ��  �@A � ������@A ǀ�ǀ��������d� b@    �& � ��� � E �@��E � ���F$��GAF @��G�F L��� BFAB �A�dA�� �G�F L���AFdA�G�G L��AFa��  ��A  �� dA�GH L��AFa��  ��A  �� dA�GAH L��AF`���  ��A  �� dA�& � "   _allPrizespairs	GetCfgIDtable
icontainscontroller_componentInfoshake_win_idsFlushSetGrayIsAllAwardCollected_drawBtnOj
SetActiveCfgcfg_component_senior_skin_costComponentID_componentIdSeqID
shake_num       GameGlobal
GetModuleItemModuleGetItemCountCostItemIDCostItemCount
_moneyNumSetText<color=#f83e13>	</color>_freeGo        _redGo_countParent         `   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    `   (for generator)      (for state)      (for control)      k      v      itemId	      state      tmp-   _   curDrawCost1   _   itemModule5   _   count8   _      _ENV �   �       L @ d@ & �    _RefreshReward           �   �   �      self            �   �       G @ G@� G�� \ � ��@ �  _��   �C@  C � f  & �    controller_componentInfoshake_win_ids_allPrizes           �   �   �   �   �   �   �   �   �   �   �   �      self            �   �    	<   G @ G@� b   ��F�@ G�� � A �@A�� �  d@  & � F�A G � ��  � @ ǀ������ @ � ��@�̀�����d� G�� ��� � D FAD 䀀̀�@ 䀀��   ���ƀ@ ���A AAA $ �@  �@E ǀ�䀀 ���A �@ �AF�@ ǁ�@ �F�@ & � � G GAG �  �@ & �    controller_closedToastManager
ShowToastStringTableGetstr_activity_finishedCfgcfg_component_senior_skin_costComponentID_componentIdSeqID_componentInfo
shake_num       CostItemID
GetModuleRoleModuleGetAssetCountCostItemCountstr_item_not_enough_glGameGlobalUIStateManagerShowDialog%UIHauteCoutureDrawChargeV2ControllerhcType_buyComponetCtxData
StartTask	DrawAnim         <   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    <   	nextDraw   <   id   <      _ENV �   �    	   G @ G@� G�� a@��  �C@  C � f  & �    controller_componentInfo
shake_num               	   �   �   �   �   �   �   �   �   �      self    	        �   �   C  � @ A  �@���@ ��@�� � A �@�̀�@� � �� �   � �L��d� bA  � �LB �A  dA�& � FAB G���� � dA�@ �  �C A BC�C�  �����  j��    FD �BD d�
������ ǃ�C  ��@@ �� ������ �  @��E � �  ���CE ǃ�  @ �C� ��CE ǃ�  @ �C����� �   ����LE d �C  �����C� �C�� ����C  �C�i�  �B�\  �  ���FBE GB�� dB FBE G��� ��  �dB K  � �� � @��� (��DE �E@��G �DG	΄�  �����F	��$D�'��  A� ���� h�N�M��GD�"   ��DD �	��E	� �D��DD �D	��E	  �D� �� ���G �� � �D�@���  	 ���G �� E �D�@����  	 ���G �� � �D�@� H ���G �� 	 �D����F ���G �� E	 �D�� ���G �� � �D�gC�G�I �BD ���J�� �BJ��IJ���G�I G��L���� dB�F�G �� � dB�G�I G��L���  dB�GA ��K ��@�� J���F�@ L��d� �A �BK��K � @��L �CLƃL ����L M�B��A �BK�BM � @��B �A �A �B����� ������A �A �B����� ǂ����A �A �B����� ������A �A �B����� �����A �BC�BO�F����O ��O��� �PCP �P�B���P �Q��B  @��BB �B�� @ �B�& � �BD ����CD �R$� "  ��CR �@$� G�R�S �CSN��
C�G�S
C�LT �C   l  dC� ��T �� ��  C� �D  �U �D�	$C B �C  $C�& � V   Lock/UIHauteCoutureDrawMainGL_Review:drawBtnOnClickAsyncRequestResNewcontroller_componentHandleApplySeniorSkinGetSuccUnLockLogdebug高级时装抽奖结果:pairs_componentInfoshake_win_idsipairs_allPrizes	GetCfgIDIsSpecailPrizeCanDrawSpecialAwardtableinsertSetGray        shuffle              MathfRepeatYIELDd              �                   �       �      
_prizeEff	positionGetGameObject
transformgameObject
SetActive�      
_campaignUIActivityCampaignLoadCampaignInfoECampaignTypeCAMPAIGN_TYPE_SENIOR_SKIN_COPYECampaignSeniorSkinComponentIDECAMPAIGN_BUY_GIFTECAMPAIGN_SENIOR_SKINReLoadCampaignInfo_Force_buyComponetGetLocalProcess_buyGiftComponent_buyComponetInfo_buyGiftComponentInfo_seniorSkinComponent_seniorSkinComponentInfo
shake_numGameGlobalEventDispatcher	DispatchGameEventTypeQuestUpdateCfg!cfg_component_senior_skin_weighterror7###[UIHauteCoutureDrawController] cfg is nil ! id --> _assetListIsHauteCouture
RoleAssetassetid	RewardIDRoleAssetIDRoleAssetPetSkinBegincountRewardCountShowDialogUIPetSkinObtainControllerShowDialog&UIHauteCoutureDrawGetItemV2ControllercontrollerCtxData         h  u        @ @@ $�� �@ ��  $@� �  A �@ �    C� �  Ɓ� ���$@ & �    GameGlobalUIStateManagerCloseDialogUIPetSkinObtainControllerShowDialog&UIHauteCoutureDrawGetItemV2ControllercontrollerCtxData          o  r           @ $@    @@ $@ & �    _RefreshRewardCheckAllPrizeCollected           p  p  p  q  q  q  r         self   i  i  i  i  i  i  j  j  k  l  m  n  r  s  t  j  u         _ENVselfreawrdList }  �           @ $@    @@ $@ & �    _RefreshRewardCheckAllPrizeCollected           ~  ~  ~        �         selfC  �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �                                                
  
  
  
  
                                  �   �                                                 !  !  !  !  !  !  !  !  !  !  !     #  $  $  $  $  %  %  %  &  &  '  '  '  '  '  )  )  )  )  )  *  +  +  ,  ,  ,  ,  ,  -  -  -  .  .  .  .  .  /  /  /  0  0  0  0  0  1  1  2  2  2  2  2  3  3  4  4  4  4  4  6  6  6  6  $  ;  ;  ;  ;  ;  ;  ;  ;  <  <  <  <  <  =  =  =  =  >  >  >  >  >  A  A  A  A  A  B  B  B  C  C  C  D  E  F  F  G  G  H  I  C  J  J  J  J  J  J  L  L  L  L  L  L  L  M  M  M  M  M  M  M  O  O  O  O  O  O  O  Q  Q  Q  Q  Q  Q  Q  S  S  S  S  S  U  U  U  U  U  U  U  X  X  X  Y  Y  Z  Z  Z  Z  Z  [  ]  ]  ]  _  _  _  _  _  _  a  a  a  c  c  c  c  c  d  d  e  f  g  u  e  v  x  y  z  {  |  �  �  �  x  �  �  �  �  %   self    C  TT    C  res   C  result   C  rewards   C  	targetid   C  collectedAwards   C  (for generator)"   &   (for state)"   &   (for control)"   &   _#   $   id#   $   
targetidx'   C  idxs(   C  (for generator)+   Z   (for state)+   Z   (for control)+   Z   idx,   X   item,   X   id.   X   rdmIdxi   �   countj   �   flashCountk   �   (for index)n   {   (for limit)n   {   (for step)n   {   io   z   last|   �   (for index)   �   (for limit)   �   (for step)   �   i�   �   idx�   �   resC�   C  
weightCfg  C  reawrdList   C  skin)  5     _ENV �  �      L @ d� b   ��G@@ L�� ��@ �  d�  � � �@ �@A ��A  �@���A ��A  �@�� B ��A  �@�& � 	   IsAllAwardCollected	_topTipsGetItemByTypeId
GetCoinIdCloseAddBtn_drawBtnOj
SetActive_probalityBtn_buyBtn           �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       	currency	           �  �   	A   � @ �� �@@ ǀ����  � �    ��@@ ǀ�� �  � AA �AF�A $� B$� N�  @���G�B L���  dA�LC dA & � �@A ǀ�AC � ̀�� ���A@ �@D@ ��$A�AD �B�  $A��D �D� $��LAEd� ��E �� ��F�A���B ��B  �A��C �A & �    GetEnterAniKeyUnityEnginePlayerPrefsHasKey	GetFloatGameGlobal
GetModuleLoginModuleGetSignRefreshTime�Q     _enterAniGo
SetActive_EnterRootSvrTimeModuleGetServerTime����MbP?	SetFloat_rootGo_enterAniPoolSpawnObjectUIHauteCoutureDrawEnterAniGetClipLengthYIELD�      �                A   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    A   TT    A   key   A   	lastShow      nextRefresh      now%   A   	enterAni3   A   clipLength5   A      _ENV �  �      G @ L@� � � d@�G�@ L�� �  d@�L@A d@ & �    _rootGo
SetActive	_rootAniPlayUIHauteCoutureDrawMainGL_LoadVideo           �  �  �  �  �  �  �  �  �  �  �     self            �  �      L @ �@  �@ G�@ d@�& �    ShowDialogUIHauteCoutureDuplicateReward_prizes_replaceIdxs           �  �  �  �  �  �     self           @                                                   $      &   8   &   :   <   :   >   A   >   D   G   D   J   �   J   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �  �   �  �  �  �  �  �  �  �  �  �  �  �  �         _ENV