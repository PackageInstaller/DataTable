LuaS �

xV           (w@t@../PublishResources/lua/product/components/ui/activity/new_year_luck_bag/ui_activity_new_year_luck_bag_content.lua         U    @ A@  $@ �@ A�  � A $@��@  ���@ l   
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
@���@ l� 
@ ��@ l  
@���@ l@ 
@ ��@ l� 
@���@ l� 
@ ��@ l  
@��& �    require"ui_side_enter_center_content_base_class UIActivityNewYearLuckBagContentUISideEnterCenterContentBaseDoInitDoShow_GetRemainTimeDoHide
DoDestroyGetComponentsInitWidgetsRefreshCountdownGetDrawTypeOnCN12LuckBagDrawRefreshRefreshDrawResultFlushFirstDrawPanelFlushDrawedPanelOnItemSelectStartButtonOnClickDrawButtonOnClickCancelDrawButtonOnClickReDrawButtonOnClickConfirmButtonOnClick
GetRewardSetBriefIntroDrawActionGetActionPointAndNeedIntroBtnOnClickCheckActivityOver                  
@@���@ � A
� ���A ��A
����@B ��B
� �� C �@C
���� �   ���� 
� �
@D���D E ���
� ���E 
���& �    _timerName,UIActivityNewYearLuckBagContent_TimerHolder_campaignTypeECampaignType!CAMPAIGN_TYPE_INLAND_RANDOM_DRAW_randomLotteryComponentIdECampaignPetSkinComponentIDRANDOMLOTTERY_actionPointComponentIdECCampaignSeasonComponentIDACTION_POINT_storyComponentIdECampaignRandomDrawComponentIDSTORY_campaignIdcampaign_id_curSelectType _svrTimeModule
GetModuleSvrTimeModule
_campaign_data               	   	   	   
   
   
                                                            self       params          _ENV    +    .   L @ �   d@�F�@ G�� � A d� 
@��G�A L�� � B d��
@��G�A L�� ǀB d��
@��G�A L�� � C d��
@��G�A L�� � B d��
@��L�C d@ L D d@ L@D d@ F�D L � d� 
@ �L@E d@ L�E d� b     �& � & �    
StartTask_timeModuleGameGlobal
GetModuleSvrTimeModule_randomLotteryComponent
_campaignGetComponent_randomLotteryComponentId_actionPointComponent_actionPointComponentId_storyComponent_storyComponentId_randomLotteryComponentInfoGetComponentInfoGetComponentsInitWidgetsRefreshDrawResult_timerHolderUITimerHolderNewRefreshCountdownCheckActivityOver                   F @ L@� �   d@�& �    
_campaignClearCampaignNew                             TT          self.                                                                                            !   !   "   "   #   #   %   %   %   %   &   &   (   (   (   (   )   +      self    .      _ENV -   >    E   �  F@ GA���� d� � �F@ GA���� d� � �F@ GA��A� d� A�A�  ������ �B �A�� �  �FB GB��� d� ]A�� ��������B �A�� �   FB GB�� d� ]A@�  ����� �B �A� � ]� ��B �AB�A �� @ ��C ��C�B �A� �  ����  & �    mathfloor�Q                  <               StringTableGetstr_activity_common_daystr_activity_common_hourstr_activity_common_minute str_activity_common_less_minutestringformatstr_activity_common_over         E   .   /   /   /   /   /   0   0   0   0   0   1   1   1   1   1   2   3   3   4   4   4   4   4   4   4   4   4   4   4   4   5   5   6   7   7   7   7   7   7   7   7   7   7   7   8   8   9   9   9   9   9   9   9   ;   ;   ;   ;   ;   =   =   =   =   =   =   =   =   =   >      self    E   time    E   day   E   hour   E   minute   E   timestring   E      _ENV @   B       G @ L@� ǀ@ d@�& �    _timerHolder
StopTimer_timerName           A   A   A   A   B      self            D   E       & �                E      self            G   |    �   K�  J���J ��J���
@ �K�  J�@�J ��J�A�
@��
���K�  � @ �@@�@C A� 䀀J� � @ ��@�@C A� 䀀J� � @ �@A�@C A 䀀J� 
@ �K�  � @ �@@J�A� @ ��@J�D� @ �@AJ�D
@��L@E �� � d� 
@ �L@E �� A d� 
@ �L@E �� � d� 
@ �L@E �� A d� 
@ �L@E ��  d� 
@ �L@E �� � d� 
@��L@E �� 	 d� 
@��L@C ��	 d��
@��L@C � 
 d��
@��L@C ��
 d��
@��L@C �  d��
@��L@C �� d��
@��L@C �  d��
@��L@C �� d��
@��L@C �  d��
@��L@C �� d��
@��L@E �  A d� 
@��L@E �  � d� 
@ �K�  �@C A ���J� ��@C � ���J� ��@C � ���J� �
@ �& � @   
_DRAWTYPEFortune       Career       	Marriage       _DRAWResultBad	Ordinary
ExtremelyMAXDRAWTIME_drawTypeBtnGroupGetGameObjectDrawTypeButton1DrawTypeButton2DrawTypeButton3_drawTypeIDGroup              _nextFlushTimeTextGetUIComponentUILocalizationTextNextDrawTimeText_remainDrawTimeTextRemainDrawTimeText_activityRemainTimeTextActivityRemainTimeText_spineText
SpineText_DrawResultUISelectObjectPathDrawResult_selectInfoPoolselectInfoPool
_briefTip	BriefTip_firstRoot
FirstRoot_drawedRootDrawedRoot_startRoot
StartRoot_drawTypeRootDrawTypeRoot_drawedListDrawedList_drawedButtonGroupDrawedButtonGroup_reDrawButtonReDrawButton_btnGroupObj	btnGroup_chooseTipObj
chooseTip_sixFullAnim
AnimationSixFull_animanim_drawResultBtnGroupresultButton1resultButton2resultButton3        �   H   J   K   L   M   N   P   Q   R   S   U   V   X   X   X   X   X   X   Y   Y   Y   Y   Y   Y   Z   Z   Z   Z   Z   Z   [   ]   _   _   _   `   `   `   a   a   a   b   c   c   c   c   c   d   d   d   d   d   e   e   e   e   e   f   f   f   f   f   g   g   g   g   g   h   h   h   h   h   i   i   i   i   i   j   j   j   j   k   k   k   k   l   l   l   l   m   m   m   m   n   n   n   n   o   o   o   o   p   p   p   p   q   q   q   q   r   r   r   r   s   s   s   s   s   t   t   t   t   t   v   x   x   x   x   y   y   y   y   z   z   z   z   {   |      self    �        ~   �    )   
@@�F�@ ��@ d �����AA� �����A�B  �A�i�  �@�F�@ ��@ d @��AB �B �B@�$� FC GB��  �A�^��i�  ���G�C L�� �   d@�
@D�L�D d@ 
 ŉ
 Ŋ& �    _curSelectType pairs_drawTypeBtnGroup
transformFindselectgameObject
SetActiveAddUICustomEventListenerUICustomUIEventListenerGetUIEventClick_btnGroupObj
SetActive_curSelectDrawIndex       SetBriefIntro_hasGetReward _todayRefreshFlag         �   �    	1   F @ � � ��   �& � F@@G�� ��@� Ad@ F@A L�� � � d@�E � @ �E   L�� d@ F B�@B d �������B ����AC��A@ _   �B  � �A������C� ����DB �A��  ��D,  �A�i�  ��& �    _curSelectTypeAudioHelperControllerPlayUISoundAutoReleaseCriAudioIDConstSoundDefaultClick_btnGroupObj
SetActiveSetBriefIntropairs_drawTypeBtnGroup
transformFindselectgameObjectGetComponent
AnimationPlay;uieff_UIActivityNewYearLuckBagContent_SixFull_LuckBagGroup
StartTask          �   �       E   L � �@  d@�F�� �   ��  d@�E   L � �@  d@�& �    Lock;uieff_UIActivityNewYearLuckBagContent_SixFull_LuckBagGroupYIELDX      UnLock             �   �   �   �   �   �   �   �   �   �   �   �   �      TT          self_ENV1   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      go    1   (for generator)   0   (for state)   0   (for control)   0   t   .   v   .      selftype_ENV)      �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    )   (for generator)      (for state)      (for control)      t      v      (for generator)      (for state)      (for control)      type      obj         _ENV �   �    	   G @ G@� � @ ��@�    �$A� �@ A�AA ��  �$A�& �    _randomLotteryComponentInfodraw_refresh_timem_close_time_timerHolderStartTimerInfinite_timerName�               �   �     
B    @ @@ $� �@ E � N � �  �  ���� �AA � �     �& �  � �@� ��  ���A �@   � �   �@�l  �@�& � �@A ̀�F��G��A �  ́�@� ��d  �@  ��C ̀�F��G�� �  ́�@ ��d  �@  @��@A ̀�F��G��A d �@  ��C ̀�F��G��A d �@  & �    _timeModuleGetServerTime�      toluaisnull_nextFlushTimeText        _todayRefreshFlag
StartTaskSetTextStringTableGetstr_cn12_n41_game_time1_GetRemainTime_activityRemainTimeTextstr_cn12_n41_game_time2#str_activity_common_notice_content          �   �    &   F @ G@� d�� L�� ��  d��b   � �� � � �@��@A �   � �@���A � B�� �@� ̀�@  � �@ ��B� �   � �� � � ��@ @��@C ǀ�� LDd �@  & �    GameGlobalUIStateManagerGetController#UIActivityNewYearLuckBagController
SetExpireYIELD�      AsyncRequestResNew
_campaignReLoadCampaignInfo_ForceGetSuccOnCN12LuckBagDrawRefreshLogfatal(新年抽签强制刷新数据错误：
GetResult          &   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      TT    &   luckBagController   &   res   &      _ENVselfB   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      nowTime   B   remainTime   B   activituRemain   B      selfrefreshTimeactivityRemainTime_ENV   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       refreshTime      activityRemainTime      
countDown         _ENV �   �       � @ �@@ � � �@   �f ��  *���   �  & �    pairs_drawTypeIDGroup            �   �   �   �   �   �   �   �   �   �   �   �      self       cfgID       (for generator)   	   (for state)   	   (for control)   	   type      v         _ENV �   �       F @ G@� ��@ d� b     �& � F�@ G � �@A ��A�� �  d@  G B L@� �� d@�L�B d@ L C d@ L@C d@ & �    toluaisnull_nextFlushTimeTextToastManager
ShowToastStringTableGetstr_cn12_n41_game_tip6_animPlay)uieff_UIActivityNewYearLuckBagContent_inInitWidgetsRefreshDrawResultRefreshCountdown            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self          _ENV �      g   G @ G@� b    �G @ G@� \ �  @ ��	�F�@ � @ �@@d � ����    �
���i�  �@�G�A L � � � d@�G@B L � �   d@�A� �@A �     �A� � C �@C�@  �@ ��� ��B��C � �FAD G����Dd �@  � E �@ ��F C G@� �@  ��B�d� G�� ��C � DAD �DG�� $ �@  ��A � B  �@��@B � B� �@��@E �@ G�E ��E � F� @ �@��� N�� �� @��@ � � � � c@ ���� � �  G�E �� ���@D ǀ�A @ 䀀�G D��$A�& �    _randomLotteryComponentInfom_draw        pairsis_get_hasGetReward_drawedRoot
SetActive_firstRoot              Cfgcfg_luckbag_dialogStage_spineTextSetTextStringTableGetDialogFlushDrawedPanelFlushFirstDrawPanelMAXDRAWTIMEtablecount<color=#FF0000>	</color><color=#ffd257>/str_cn12_n41_game_tip2_remainDrawTimeText         g   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �                                                                          self    g   (for generator)      (for state)      (for control)      _      v      stage   0   
dialogCfg'   0   
dialogCfg7   H   	leftTimeO   g   tempRemindTime]   g   tempTxtb   g      _ENV 	     	   G @ L@� � � d@�G�@ L@� �   d@�& �    _startRoot
SetActive_drawTypeRoot        	   
  
  
  
               self    	          M   �   G @ G@� \ � ��@ ��@A  �@��@A ��@A  �@���A ��@A  �@���A ��@B  �   �A  � �@�� � �B �B� $��
 ��A G�C \��A (���C �G@ GB�G��C�DC �����D��@��  �C  � �B���C�D �����D��@_��  �C  � �B���C�DC �����E�E FF $ ��  b  ���BFF�F G��� �C���d �B  ��G  AC �� � ������BFF�F G���� d �B  ��G 	 AC	 ��	 � �����C��A�	 䂀ǂ����C  �B��  J �CJ ��F� �� ƃJ ���,D  $C�K "  ��b  ��C�"  � �$C� B�@�� � �$C�  ���'��& � .   _randomLotteryComponentInfom_draw_drawedList
SetActive_hasGetReward_chooseTipObj_drawedButtonGroup_reDrawButtonMAXDRAWTIME_drawResultPool_DrawResultSpawnObject#UIActivityNewYearLuckBagResultItem       _drawResultBtnGroup
transformFind	bgNormalgameObject 
bgNotDraw
resultTxtGetComponenttypeofUILocalizationTextSetTextStringTableGetstr_cn12_n41_game_luckrandom_typecolorColor�������?�������?�������?str_cn12_n41_game_luck_none�������?�������?�?	bgSelectAddUICustomEventListenerUICustomUIEventListenerUIEventClick_hasGetRewardis_get         '  9    6      "   @� � @@ �   � � �� l  $@   H ��  �& �  �"   @� � A �   $@���A� �  �@ $� ���B�B �  $��@C 	 ��B�B �� $���C � ��@��  $�  	   � A � � $@���A� �� �  $� ��& �    _drawResultPool
FlushData_hasGetReward_curSelectDrawIndex
SetActivecolorColor�������?�������?�������?
transformFind	bgSelectgameObject
resultTxtGetComponenttypeofUILocalizationText�������?�������?�������?   	       )  +      �   � @   @� �@ & �    OnItemSelect           *  *  *  *  *  +     id       pos          self6   (  (  (  )  )  )  )  )  +  )  ,  ,  ,  /  1  1  1  2  2  2  2  3  3  3  3  3  3  5  5  5  5  5  5  6  6  6  6  6  6  6  6  6  6  7  7  7  7  8  8  8  8  8  8  9         	drawInfoselfilastSelectObjlastSelectTxt_ENVobj =  ?      E   d@� & �               >  >  ?     go          	callback�                                                                                                                                                                                              "  "  "  "  "  "  #  #  #  #  #  #  %  %  %  %  %  %  %  %  9  :  ;  ;  ;  ;  <  <  ?  :  A  A  A  C  C  C  C  C  D  D  E  H  H  I  I  K  K    M     self    �   drawListLength   �   lastSelectObj   �   lastSelectTxt   �   (for index)$   �   (for limit)$   �   (for step)$   �   i%   �   obj'   �   	drawInfo*   �   txtI   �   	callbacko   �      _ENV O  U      � @ �@   ��@@ ̀�A�  䀀
� �� @ � �@� � �@ & �    _selectInfo_selectInfoPoolSpawnObjectUISelectInfoSetData           P  P  P  Q  Q  Q  Q  Q  T  T  T  T  T  U     self       id       pos            W  c      L @ d� b     �& � G@@ L�� �   d@�G�@ L�� � � d@�L A �   d@�& �    CheckActivityOver_startRoot
SetActive_drawTypeRoot
StartTask         ]  b      E   L � �@  d@�F�@ L�� �@  d@�F � �   �@ d@�E   L�� �@  d@�& �    Lock.uieff_UIActivityNewYearLuckBagContent_SixFull_sixFullAnimPlayYIELD�      UnLock             ^  ^  ^  ^  _  _  _  _  `  `  `  `  a  a  a  a  b     TT          self_ENV   X  X  X  X  Y  [  [  [  [  \  \  \  \  ]  b  ]  c     self          _ENV e  o      L @ d� b     �& � G@@ b@   �G�@ G�� b@    �& � L A �   d@�& �    CheckActivityOver_curSelectType_randomLotteryComponentInfom_drawDrawAction        l  n           @ �@  ƀ@   F�@ $@ & �    ShowDialog'UIActivityNewYearLuckBagAnimController_randomLotteryComponentInfo_storyComponent           m  m  m  m  m  m  m  n         self   f  f  f  f  g  i  i  i  i  i  i  i  j  l  n  l  o     self            q  {   	   L @ d� b     �& � 
���F�@ � A d ���A���A� ����B�AB  �A�i�  �@�G�B L@� �   d@�L�B d@ & �    CheckActivityOver_curSelectType pairs_drawTypeBtnGroup
transformFindselectgameObject
SetActive_btnGroupObjSetBriefIntro            r  r  r  r  s  u  v  v  v  v  w  w  w  w  w  w  w  w  v  v  y  y  y  y  z  z  {     self       (for generator)	      (for state)	      (for control)	      t
      v
         _ENV }  �   	   L @ d� b     �& � L@@ �   d@�& �    CheckActivityOverDrawAction        �  �           @ �@  ƀ@   F�@ $@ & �    ShowDialog'UIActivityNewYearLuckBagAnimController_randomLotteryComponentInfo_storyComponent           �  �  �  �  �  �  �  �         self	   ~  ~  ~  ~    �  �  �  �     self    	        �  �      L @ �@@ ,  d@ & �    
GetReward_curSelectDrawIndex        �  �    	   @@��@ "   � ��@ �@ � @ $@�& �    _hasGetReward_drawResultPoolSetFinishDrawState        	   �  �  �  �  �  �  �  �  �         self   �  �  �  �  �     self            �  �      � @ l  �@�& �    
StartTask         �  �   %   F @ L@� d� ��� ��@   @� � ���� � � A� $� "   ��A�AE� L��A   l  dA����B �BFC $� LAC�� � �� �ClB  ��  dA & �    AsyncRequestResNew_randomLotteryComponent'HandleRandomLotteryComponentDrawReward
GetResultGetSuccm_draw
m_rewardsShowDialogUIGetItemControllerGameGlobal
GetModuleCampaignModuleCheckErrorCode
_campaign_id          �  �    
      "   @ �   $@�  �  @ �   $@�& �    
StartTask           �  �      F @ L@� ��  d@�F�� �   �  d@�E   L@� d@ E   L�� d@ & �    _animPlay*uieff_UIActivityNewYearLuckBagContent_outYIELD      InitWidgetsRefreshDrawResult            �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     TT          self_ENV
   �  �  �  �  �  �  �  �  �  �         	callbackself_ENV �  �        @ @@ $�� �@ ��  $��"   @�F @ G@� d�� L � ��  d@�& �    GameGlobalUIStateManagerGetController#UIActivityNewYearLuckBagControllerCloseDialog            �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     luckBagController         _ENV �  �           @ $@ & �    CloseDialog           �  �  �  �         self%   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     TT    %   	asyncRes   %   respone	   %   replyResult   %   rewards      campaignModule   $      _ENVselfindex	callback   �  �  �  �     self       index       	callback          _ENV �  �      G @ b@  ��G@@ L�� ��@ � �A �  d@  & � A� ��@ � A� � @ � ��� ��@ � �� @ 䀀A@ �@��$A�& �    _curSelectType
_briefTipSetTextStringTableGetstr_cn12_n41_game_tip3str_cn12_n41_game_luck_txtstr_cn12_n41_game_tip4            �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       
commonTxt      typeTxt      tipTxt         _ENV �  �      � @ �� �   ���@@ ��@��� ��@ ����   @��@@ ǀ�䀀 �@�A �@�& � ��A �A � ��   @� �   �� �LB �  dA�& � 	   CheckActivityOverGameGlobalUIStateManagerGetController#UIActivityNewYearLuckBagControllerCloseDialogGetActionPointAndNeed_curSelectType
StartTask         �  �   
4   E   L � �@  d@�F�� L�� d� � A �@@   @� � �@��@� �� ̀� � �   ��� ��   @ �� ��@� ���    A �@��   �@�AA  �@��   ̀��@ �   ����@ ��� � �@��� � ���A� �� �D �A�,  lB  $A & �    Lock!HandleRandomLotteryComponentDrawAsyncRequestResNew_randomLotteryComponent
GetResultGetSuccYIELD�      UnLockInitWidgetsRefreshDrawResultGameGlobal
GetModuleCampaignModuleCheckErrorCode
_campaign_id          �  �        @ @@ $�� �@ ��  $��"   @�F @ G@� d�� L � ��  d@�& �    GameGlobalUIStateManagerGetController#UIActivityNewYearLuckBagControllerCloseDialog           �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     luckBagController         _ENV �  �           @ $@ & �    CloseDialog            �  �  �  �         self4   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     TT    4   	asyncRes   4   replyResult   4   campaignModule+   3      self_ENVcfgID	callback   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       	callback       luckBagController
      cur      need      cfgID         _ENV �  �      b@   �� @ �@@ǀ@ �����  A  �& � ��@ ��@�@AG�A@ ���A G@ � B �@B�@ �   @�ǀB   @���B�Cf �   �  & �    tablecount_randomLotteryComponentInfom_draw               draw_cfg_id_drawTypeIDGroupCfgcfg_component_random_lotteryMAXDRAWTIMEOneCostCountID            �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       type       lotteryCfg      cur      ceil         _ENV         L @ �@  �  d@ & �    ShowDialogUIIntroLoaderUIActivityNewYearLuckBagIntr                        self                    G @ G@� ��@ ��@�� � A΀�  @� ��A �AFB GA��� d $A  �B C$�� AC��C ��C�D $A � &   & & �    _randomLotteryComponentInfom_close_time_timeModuleGetServerTime�              ToastManager
ShowToastStringTableGet#str_activity_common_notice_contentGameGlobalEventDispatcher	DispatchGameEventTypeActivityCloseEvent_campaignId                        	  
  
                                             self       
closeTime      nowTime      activituRemain         _ENVU                                          +      -   >   -   @   B   @   D   E   D   G   |   G   ~   �   ~   �   �   �   �   �   �   �   �   �   �     �   	    	    M    O  U  O  W  c  W  e  o  e  q  {  q  }  �  }  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �                       _ENV