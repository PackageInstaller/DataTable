LuaS �

xV           (w@l@../PublishResources/lua/product/components/ui/ui_haute_couture_draw_plm/ui_haute_couture_draw_main_plm.lua         I    @ A@  ��@ $@�@@  ��@@ l   
@��@@ l@  
@ �@@ l�  
@��@@ l�  
@ �@@ l  
@��@@ l@ 
@ �@@ l� 
@��@@ l� 
@ �@@ l  
@��@@ l@ 
@ �@@ l� 
@��@@ l� 
@ �@@ l  
@��@@ l@ 
@ �@@ l� 
@��@@ l� 
@ �@@ l  
@��@@ l@ 
@ �@@ l� 
@��@@ l� 
@ �@@ l  
@��@@ l@ 
@ �& �    _classUIHauteCoutureDrawMainPLMUIHauteCoutureDrawBaseConstructorOnShowOnHideGetEnterAniKeyInitWidgets
CloseSelfSetEndTime
GetCoinId	_OnValue_LoadVideo_LoadPrize_RefreshRewardItemCountChangedIsAllAwardCollectedHandleDrawBtnClickCanDrawSpecialAward	DrawAnimCheckAllPrizeCollectedCheckAndDoEnterAni_EnterRootVideoMaskOnClickVideoMaskOnClick1                  K   
@ �
���& �    _allPrizes_EnterAniKey                           self            
          � @ �@ �@@ �@ ��@ �@ AGA �@ �@A �@ ��A �@ ��A B @  �@ & � 	   InitWidgets	_OnValueAttachEventGameEventTypeItemCountChanged_LoadPrizeCheckAllPrizeCollected
StartTaskCheckAndDoEnterAni                                                                     self       	uiParams          _ENV           L @ �@@ ǀ��@ d@ & �    DetachEventGameEventTypeItemCountChanged                                 self          _ENV            G @ b@  @�F@@ G�� ��@ d� � � �� �  A � �
� �G @ f  & �    _EnterAniKeyGameGlobal
GetModuleRoleModule	GetPstIdLashShowCoutureEnter                                                                self       roleModule      pstId	         _ENV "   >    A   L @ d@ L�@ ��   d� 
@��L�@ ��  � d� 
@��L�@ ��   d� 
@��L�B �� d��
@��L�@ �@ � d� 
@ �L�@ ��   d� 
@��L�B �  d��
@��L�B �� d��
@ �G�D L � �   d@�L�B �� d��
@��L�B �  d��
@��L�B �� d��
@��L�@ �@  d� 
@��G@E J�ǎG�E J�ǎ& �    InitWidgetsBase
_prizeTopGetUIComponentUISelectObjectPathPrizeListTop_prizeBottomPrizeListBottom_specialItemSpecialItem_rootGoGetGameObjectRoot	_rootAni
AnimationRootAni_enterAniPoolEnterAnimation_enterAniGo_endTimeImgOtherendTimeImgOther
SetActive_particleSystemParticleSystem_particleSystem2ParticleSystem2_effeff_animanimlayer
               A   $   $   (   (   (   (   (   *   *   *   *   *   +   +   +   +   +   -   -   -   -   .   .   .   .   .   0   0   0   0   0   2   2   2   2   5   5   5   5   6   6   6   6   7   7   7   7   8   8   8   8   9   9   9   9   ;   ;   ;   ;   ;   <   <   =   =   >      self    A        @   M       L @ �   d@�& �    
StartTask         C   I       F @ L@� ��  d@�F�� G � d�� L@� ƀ� ���d@�F � �   �@ d@�F�B L�� d@ & �    _animPlay$uieff_UIHauteCoutureDrawMainPLM_outGameGlobalEventDispatcher	DispatchGameEventTypeUIHauteCoutureDrawBgPLMAnimOutYIELD�       controllerCloseDialog             E   E   E   E   F   F   F   F   F   F   F   G   G   G   G   H   H   H   I      TT          self_ENV   B   I   B   M      self          _ENV O   U       � @ �    �� @ �@@ � �@���@  AA �� 
� ���@ �@@ � �@�& �    	_endtimeSetText_endtimeOtherGetUIComponentUILocalizationTextendtimeOther           P   P   P   Q   Q   Q   Q   R   R   R   R   R   S   S   S   S   U      self       timeStr            W   Y       A   f  & �    
�-                X   X   Y      self            [   ^       & �                ^      self            a   d       F @ L@� d� L�� ��@ � ��@�� � ��A Bd� �@B  � �@�& � 
   ResourceManagerGetInstanceGetAssetPathcontroller_cfg
VideoName.mp4	LoadType
VideoClip
LoadVideo            b   b   b   b   b   b   b   b   b   b   b   b   c   c   c   d      self       url         _ENV g   �    l   A   �@@ ��@�   @ ��@@ G�@�@@ ��@�    FAA G��� d� � (��G�A_@�  �FBA G�����AdB�'A�A G�B L���   dA GAC L��� �dA G�B L��d� � �� ����B��B��C���C@ ��  GD@ GD�$C CA BG�D � $C�����AC ��C�� �  A ���ǂ�L��� D@ DC  �D@ �DD	dC FCA G���D ��dC���b    ���D ��A 䁀���� �B@ ��� GC@ GC�$B BA BG�D ��$B��AE �A & �            controller_specialIdx_prizes       tablecountRewardSortOrderinsert       
_prizeTopSpawnObjectsUIHauteCoutureDrawPrizeItemPLM_prizeBottomGetAllSpawnListSetData_componentIdCtxData_allPrizes_specialItemSpawnObject_RefreshReward         l   h   i   i   i   i   j   j   m   m   n   o   o   o   o   o   o   o   p   q   q   q   r   r   r   r   r   o   w   x   x   x   x   x   z   z   z   z   z   z   |   |   |   }   }   }   }   ~      �   �   �   �   �   �   �   �   �   �   �   �   �   }   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    l   specialIndex   l   prizes	   l   idList
   l   (for index)      (for limit)      (for step)      i      prize      topItemNum   l   	topPools*   l   (for index)-   >   (for limit)-   >   (for step)-   >   i.   =   item/   =   idx0   =   bottomPoosA   l   (for index)D   V   (for limit)D   V   (for step)D   V   iE   U   itemF   U   idxH   U   item\   i      _ENV �   �    d   G @ b    �F@@ � @ d ������� ��@ ��BA �A�A@ 䁀���$B�B��  $B�i�  ��L�B d� b    �G�B L � �   d@�G@C L � � � d@�@�F�C G�� ��  �@A �@��� ��@A ǀ����� ��� �d� b@    �& � � � �@E ǀ��E � ��AF$��G�F @��G�F L��A �FA� �A�dA�� �G�F L�ǁFdA�G�G L�ǁFa �  ��A  �� dA�GAH L�ǁFa �  ��A  �� dA�G�H L�ǁF`��  ��A  �� dA�& � #   _allPrizespairs	GetCfgIDtable
icontainscontroller_componentInfoshake_win_idsFlushSetGrayIsAllAwardCollected_drawBtnOj
SetActive_endTimeImgOtherCfgcfg_component_senior_skin_costComponentID_componentIdSeqID
shake_num       GameGlobal
GetModuleItemModuleGetItemCountCostItemIDCostItemCount
_moneyNumSetText<color=#f64b39>	</color>_freeGo        _redGo_countParent         d   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    d   (for generator)      (for state)      (for control)      k      v      itemId	      state      tmp1   c   curDrawCost5   c   itemModule9   c   count<   c      _ENV �   �       L @ d@ & �    _RefreshReward           �   �   �      self            �   �       G @ G@� G�� \ � ��@ �  _��   �C@  C � f  & �    controller_componentInfoshake_win_ids_allPrizes           �   �   �   �   �   �   �   �   �   �   �   �      self            �   �    	<   G @ G@� b   ��F�@ G�� � A �@A�� �  d@  & � F�A G � ��  � @ ǀ������ @ � ��@�̀�����d� G�� ��� � D FAD 䀀̀�@ 䀀��   ���ƀ@ ���A AAA $ �@  �@E ǀ�䀀 ���A �@ �AF�@ ǁ�@ �F�@ & � � G GAG �  �@ & �    controller_closedToastManager
ShowToastStringTableGetstr_activity_finishedCfgcfg_component_senior_skin_costComponentID_componentIdSeqID_componentInfo
shake_num       CostItemID
GetModuleRoleModuleGetAssetCountCostItemCountstr_item_not_enough_plmGameGlobalUIStateManagerShowDialog%UIHauteCoutureDrawChargeV2ControllerhcType_buyComponetCtxData
StartTask	DrawAnim         <   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    <   	nextDraw   <   id   <      _ENV �   �    	   G @ G@� G�� a@��  �C@  C � f  & �    controller_componentInfo
shake_num               	   �   �   �   �   �   �   �   �   �      self    	        �   �   \  � @ A  �@���@ ��@�� � A �@�̀�@� � �� �   � �L��d� bA  � �LB �A  dA�& � FAB G���� � dA�@ �  �C A BC�C�  �����  j��    FD �BD d�
������ ǃ�C  ��@@ �� ���A ����@��E � �  ���CE ǃ�  @ �C� ��CE ǃ�  @ �C��A ���� ����LE d �C  �����C� �C�� ����C  �C�i�  �B�\  �  ���FBE GB�� dB FBE G��� ��  �dB K  � �� � @��� (��DE �E@��G �DG	΄�  �����F	��$D�'��  A� ���� h�N�M��GD�"   ��DD �	��E	� �D��DD �D	��E	  �D� �� ���G �� � �D�@���  	 ���G �� E �D�@����  	 ���G �� � �D�@� H ���G �� 	 �D����F ���G �� E	 �D�� ���G �� � �D�gC�G�I �BD ���J�� �BJ��IJ���G�I G��L���� dB�F�G �� � dB�G�I G��L���  dB�GA ��K ��@�� J���F�@ L��d� �A �BK��K � @��L �CLƃL ����L M�B��A �BK�BM � @��B �A �A �B����� ������A �A �B����� ǂ����A �A �B����� ������A �A �B����� �����A �BC�BO�F����O ��O��� �PCP �P�B���P �Q��B  @��BB �B�� @ �B�& � �  �Q �@$� GCR
C�G�R
C�FCE G����� dC�GSb  ��GS @� �F�Q L��d� �CS ��SJ���SJ���CE ��E�� ��C�GA G����@�F�Q L��d� �CR��SJ����RJ���T D @��  �C� �L�T ��  �D  �� �D  U EU
dC LB �C  dC�& � V   Lock)UIHauteCoutureDrawMainPLM:drawBtnOnClickAsyncRequestResNewcontroller_componentHandleApplySeniorSkinGetSuccUnLockLogdebug高级时装抽奖结果:pairs_componentInfoshake_win_idsipairs_allPrizes	GetCfgID_specialIdxCanDrawSpecialAwardtableinsertSetGray        shuffle              MathfRepeatYIELDd              �                   �       �      
_prizeEff	positionGetGameObject
transformgameObject
SetActive�      
_campaignUIActivityCampaignLoadCampaignInfoECampaignTypeCAMPAIGN_TYPE_SENIOR_SKINECampaignSeniorSkinComponentIDECAMPAIGN_BUY_GIFTECAMPAIGN_SENIOR_SKINReLoadCampaignInfo_Force_buyComponetGetLocalProcess_buyGiftComponent_buyComponetInfo_buyGiftComponentInfo_seniorSkinComponent_seniorSkinComponentInfo
shake_numGameGlobalEventDispatcher	DispatchGameEventTypeQuestUpdateCfg!cfg_component_senior_skin_weighterror7###[UIHauteCoutureDrawController] cfg is nil ! id --> 
RoleAssetassetid	RewardIDcountRewardCountAppendGlowRoleAssetIDRoleAssetGlow 	=     ShowDialogUIPetSkinObtainControllerShowDialog&UIHauteCoutureDrawGetItemV2ControllercontrollerCtxData         v  �        @ @@ $�� �@ ��  $@� �  A �@ �    C� �  Ɓ� ���$@ & �    GameGlobalUIStateManagerCloseDialogUIPetSkinObtainControllerShowDialog&UIHauteCoutureDrawGetItemV2ControllercontrollerCtxData          }  �           @ $@    @@ $@ & �    _RefreshRewardCheckAllPrizeCollected           ~  ~  ~        �         self   w  w  w  w  w  w  x  x  y  z  {  |  �  �  �  x  �         _ENVselfreawrdList �  �           @ $@    @@ $@ & �    _RefreshRewardCheckAllPrizeCollected           �  �  �  �  �  �  �         self\  �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �                                       	  	  	  	                                                                                              !  "  #  $  $  $  $  %  %  %  %  %  %  %  %  %  %  %  $  '  (  (  (  (  )  )  )  *  *  +  +  +  +  +  -  -  -  -  -  .  /  /  0  0  0  0  0  1  1  1  2  2  2  2  2  3  3  3  4  4  4  4  4  5  5  6  6  6  6  6  7  7  8  8  8  8  8  :  :  :  :  (  ?  ?  ?  ?  ?  ?  ?  ?  @  @  @  @  @  A  A  A  A  B  B  B  B  B  E  E  E  E  E  F  F  F  G  G  G  H  I  J  J  K  K  L  M  G  N  N  N  N  N  N  P  P  P  P  P  P  P  Q  Q  Q  Q  Q  Q  Q  S  S  S  S  S  S  S  U  U  U  U  U  U  U  W  W  W  W  W  Y  Y  Y  Y  Y  Y  Y  \  \  \  ]  ]  ^  ^  ^  ^  ^  _  a  b  b  b  c  c  d  d  e  e  e  e  e  f  f  f  f  f  f  g  g  g  h  h  h  i  i  j  j  j  j  j  m  m  m  m  o  o  o  q  q  q  r  r  s  t  u  �  s  �  �  �  �  �  �  �  �  �  �  �  �  �  �  '   self    \  TT    \  res   \  result   \  rewards   \  	targetid   \  collectedAwards   \  (for generator)"   &   (for state)"   &   (for control)"   &   _#   $   id#   $   
targetidx'   \  idxs(   \  (for generator)+   Z   (for state)+   Z   (for control)+   Z   idx,   X   item,   X   id.   X   rdmIdxi   �   countj   �   flashCountk   �   (for index)n   {   (for limit)n   {   (for step)n   {   io   z   last|   �   (for index)   �   (for limit)   �   (for step)   �   i�   �   idx�   �   resC�   \  
weightCfg  \  reawrdList  \  reward!  \  	rewardGp3  =  skinD  N     _ENV �  �      L @ d� b   ��G@@ L�� ��@ �  d�  � � �@ �@A ��A� �@���A ��A  �@�� B ��A  �@��@B ��A  �@�& � 
   IsAllAwardCollected	_topTipsGetItemByTypeId
GetCoinIdCloseAddBtn_endTimeImgOther
SetActive_drawBtnOj_probalityBtn_buyBtn           �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       	currency	           �  �   	M   � @ �� �@@ ǀ����  � �    ��@@ ǀ�� �  � AA �AF�A $� B$� N�  @���G�B L���  dA�LC dA GAC L���� dA�& � �@A ǀ��C � ���� � �A@ �@AD@ ��$A��D �B�  $A��D E�A $��L�Ed� ��E �� �BF�A��C �A ��E �� � �A���B ��B  �A��AC ��B� �A�& �    GetEnterAniKeyUnityEnginePlayerPrefsHasKey	GetFloatGameGlobal
GetModuleLoginModuleGetSignRefreshTime�Q     _enterAniGo
SetActive_EnterRoot_effSvrTimeModuleGetServerTime����MbP?	SetFloat_rootGo_enterAniPoolSpawnObjectUIHauteCoutureDrawEnterAniPLMGetClipLengthYIELD�      X      ,               M   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    M   TT    M   key   M   	lastShow   "   nextRefresh   "   now)   M   	enterAni7   M   clipLength9   M      _ENV �  �   *   G @ L@� � � d@�G�@ L�� �  d@�F@A G�� d�� L�� � B �@�d@�G�B L�� d� �  � �  �� ��A� �AC@��A������C ��B�� �   A �� �ǁB���C$B���� D �@ & �    _rootGo
SetActive	_rootAniPlay#uieff_UIHauteCoutureDrawMainPLM_inGameGlobalEventDispatcher	DispatchGameEventTypeUIHauteCoutureDrawBgPLMAnimIn
_prizeTopGetAllSpawnList       	PlayAnim_prizeBottom       _LoadVideo         *   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    *   	topPools   *   (for index)      (for limit)      (for step)      i      item      bottomPoos   *   (for index)!   '   (for limit)!   '   (for step)!   '   i"   &   item#   &      _ENV �  �      � @ �@ & �    HandleFgBtnClick           �  �  �     self       go            �  �      � @ �   @ �
@@�  �
�@�� @ �   � ���@ � A�@ � ���@ �@A�@ ��A ��A@  �@�& �    	_playing _vpPlayPause_pause
SetActive           �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       go           I                              
      
                      "   >   "   @   M   @   O   U   O   W   Y   W   [   ^   [   a   d   a   g   �   g   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �  �   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �         _ENV