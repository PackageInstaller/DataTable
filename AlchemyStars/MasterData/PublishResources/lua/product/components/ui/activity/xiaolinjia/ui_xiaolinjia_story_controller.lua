LuaS �

xV           (w@f@../PublishResources/lua/product/components/ui/activity/xiaolinjia/ui_xiaolinjia_story_controller.lua         C    @ A@  ��@ $@�@@  ��@@ l   
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
@ �& �    _classUIXiaoLinJiaStoryControllerUIControllerOnShowHandleStartQuestionSessionGetOtherPlayerIsSelectFinishAfterPlayerSelectOptionHandleStartDialogSessionHandleEndQuestionSessionHandleEndDialogSessionShowClosingPanel
_DoEscapeOnSessionStartOnSessionEnd	OnUpdateOnHideOnExitClosingPanelBtnOnClickQuestionResultBtnOnClickFullScreenBtnOnClickRecordBtnOnClickAutoBtnOnClickJumpBtnOnClick           }      �@� 
� ���� 
� �� A �@A�@  @ � ��� �   � ��@@
��� �� B �@�� G@ �@�ǀ@ � �� 
���ǀ@ �@�� A �CKA  J� �$� 
 ��D �DG�A G�$� 
 ��
�Ŋ
 Ƌ  
 ��
�F�
@G�
@@�H �A ƁH ���$� 
 ��AI �I��A ��I�  $� 
 � FAJ L��́J A�
 � �    G�G �B  d� 
A��FAJ L��́J A�
 �B �    G�G ��  d� 
A��FAJ L��́J A�
 �� �    G�G �� d� 
A�FAJ L��́J A�
 � �    G�G �� d� 
A��
 ��J �� �� $� 
 ��AM � $��
 �AM �� $��
 �AM �� $��
 ��AM � $��
 �AM �A $��
 ��AM �� $��
 ��J � �� $� 
 ���J � �A $� 
 ���J � �� $� 
 ��J � �� $� 
 ���J � �A $� 
 ��J � �� $� 
 �AM �� $��
 ���J �A � $� 
 �AM �� $��
 �AM �� $��
 ���J � � $� 
 ��J � �A $� 
 ���J �A �� $� 
 ��J � �� $� 
 ���J � � $� 
 �AM �A $��
 ���J �� �� $� 
 ��J �� � $� 
 ��J �� �A $� 
 ���J �� �� $� 
 ��J �� �� $� 
 ���J �� � $� 
 ��J �� �A $� L�U� d��
@�G�U LA��  � �  � dA�GI L��d� �A  �J ��B  �A��J �B��V�C�B����AW ,B  �A�& � ^   
missionID       uiMainController       Cfgcfg_xiaolinjia_missionIDmissionCfgLog
exceptionstory cfg is nil
_campaignGetCampaignGetTacitTestComponentCfgIdcollectionCfgcfg_xiaolinjia_collectionComponentID	roleNameStringTableGet	RoleNameMAX_QUESTION_COUNT       curGetStarCount        curAnswerRightRecordcurAnswerIsRight 
getReward 
recordPosatlas	GetAssetXiaoLinJia.spriteatlas	LoadTypeSpriteAtlasstoryManagerXiaoLinJiaStoryManagerNewStoryCfgNameplayerCtrlMapUIXiaoLinJiaPlayerGetUIComponentUIViewplayer1player2player3       player4optionsPoolUISelectObjectPathoptionsquestionStartGetGameObjectquestionRootquestionShowquestionResultfullScreenBtnlcBtnGroupquestionStartText1UILocalizationTextquestionStartText2questionTitleText1questionTitleText2questionTitleStr	titleStrquestionResultTitlequestionResultStarquestionResultHeadImage	endPanelendPanelStarendPanelEvaluateText1endPanelEvaluateText2endPanelHeadIconendPanelTitleendPanelContent	autoShowanim
AnimationquestionRootAnimquestionStartAnimquestionShowAnimquestionResultAnimendPanelAnim	backBtns
_backBtnsSpawnObjectUINewCommonTopButtonSetDataGetFirstMissionDataSetFaceIcon	FaceIcon
StartTask         U   o     
    @ @@ A�  ��@ � A�@A ǀ�� FB GA��� d� �  �  ,B  D  $@ & �    PopupManagerAlertUICommonMessageBoxPopupPriorityNormalPopupMsgBoxType	OkCancelStringTableGetstr_xiaolinjia_text_quit_2          \   h       E   L � �@  d@�F�@ L�� �  d@�E   L@� �   d@�& �    Lock"UIXiaoLinJiaStoryController_CloseanimPlay*uieffanim_UIXiaoLinJiaStoryController_out
StartTask          _   g       F @ �   �@  d@�E � L�� d@ E � L�� �  d@�E � L�� �@ d@�F�� L�� d� b     �& � & �    YIELDM      CloseDialogUnLock"UIXiaoLinJiaStoryController_CloseWaitForOtherPlayerSelectFinish
_campaign#CheckCampaignClose_ShowClientError             `   `   `   `   a   a   a   b   b   b   b   c   c   c   c   d   d   d   d   d   e   g      TT          _ENVself   ]   ]   ]   ]   ^   ^   ^   ^   _   _   g   _   h      param          self_ENV j   l       F @ G@� ��  d@ & �    Logdebug(###[UIXiaoLinJiaStoryController] 取消            k   k   k   k   l      param          _ENV   V   V   W   X   X   Y   Y   Z   [   [   [   [   h   i   l   n   V   o          _ENVself v   |       E   L � �@  d@�F�� �   ��  d@�E   L � �@  d@�F@A L�� d@ & �    Lock)UIXiaoLinJiaStoryController_StartSessionYIELD       UnLockstoryManagerStartSession             w   w   w   w   x   x   x   x   y   y   y   y   {   {   {   |      TT          self_ENV                                	   	   
   
   
                                                                                                                        "   "   "   "   "   "   "   $   &   &   &   &   &   &   &   &   &   &   &   '   '   '   '   '   '   '   '   '   '   '   (   (   (   (   (   (   (   (   (   (   (   )   )   )   )   )   )   )   )   )   )   )   *   ,   ,   ,   ,   ,   .   .   .   .   /   /   /   /   0   0   0   0   1   1   1   1   2   2   2   2   3   3   3   3   5   5   5   5   5   6   6   6   6   6   7   7   7   7   7   8   8   8   8   8   9   9   9   9   9   ;   ;   ;   ;   ;   <   <   <   <   =   =   =   =   =   >   >   >   >   ?   ?   ?   ?   @   @   @   @   @   A   A   A   A   A   B   B   B   B   B   C   C   C   C   C   D   D   D   D   D   E   E   E   E   F   F   F   F   F   G   G   G   G   G   H   H   H   H   H   I   I   I   I   I   J   J   J   J   J   K   K   K   K   K   Q   Q   Q   Q   S   S   S   S   T   T   o   o   o   o   T   r   r   r   s   s   s   s   s   t   t   t   t   t   t   s   v   |   v   }   
   self      	uiParams      cfg
     componentID     	backBtns�     firstMission    (for index)    (for limit)    (for step)    i       _ENV    �       G @ L@� d� ��� ��@@ A$� GAA L���  dA�LB �  d��
@��& � 	   storyManagerGetCurSessionData       OtherPlayerAnswerGetCurQuestionIndexlcBtnGroup
SetActivequestionSessionTask
StartTask         �   �    �   F @ L@� ƀ� ��� E � �d@  F@A L@� ƀ� ��� E � �d@  F�A L@� ƀ� ��� E � �d@  F�A L@� ƀ� ��� E � �d@  F B L@� � � d@�F�� �   �� d@�F � G@� ��C d� b     �& � F�C L�� �  d@�F�� �   �@ d@�F � G@� � B d� b     �& � F B L@� �   d@�F�D L@� � � d@�F�D L@� ƀ� �����  d@  F@E L�� �� � d@ F@E L�� d� @��A� � G �  �� h��FG G�LA�ƁG �����dA�g��A  � G �  �� h@�FG G�LA���F��dA�FG G�L��dA g �F�� � �d  ��AF ��I  @��B�ƂG ,  �A�i�  � ��I�& � (   questionStartText1SetTextStringTableGet!str_xiaolinjia_text_question_numquestionStartText2questionTitleText1questionTitleText2questionStart
SetActiveYIELD       toluaisnullquestionStartAnimPlay8uieffanim_UIXiaoLinJiaStoryController_QuestionStart_out,      questionRootquestionTitleStrTopicoptionsPoolSpawnObjectsUIXiaoLinJiaStoryOptionItemOptionsoptionsGetAllSpawnList       playerCtrlMapSetFaceIconmissionCfgSelectingFaceIcon       SetPlayerSelectDoSelectingAnimpairsSetDataOtherPlayerAnswerquestionSessionTask           �   �    8   F @ L@� �   d@�F�@ G�� L � �   d@�F@� @   �F�A �  �@� J� F�A M�� @��@B�  ��B�E  ��B �� @�F C L@� ƀC �A l  d@�F C L�� ƀC d��b   ��� �� � � @ �ƁA ʁ���  *��� C �@D�C F�A �@ � �E   L�� d@ & �    storyManagerSetCurPlayerSelectIndexplayerCtrlMap       SetPlayerSelectAnswercurAnswerRightRecordcurGetStarCountcurAnswerIsRight MAX_QUESTION_COUNTuiMainControllerSaveTacitTestResult
missionIDGetMissionQuestionRecordpairsUpdateTacitTestAnswerAfterPlayerSelectOption            �   �         �E   L@� d@ & �    
getRewardAfterPlayerSelectOption            �   �   �   �   �      reward          self8   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      index    8   record$   3   (for generator))   .   (for state))   .   (for control))   .   idx*   ,   v*   ,      selfcurQuestionDatacurQuestionIndex_ENV�   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      TT    �   (for index)[   d   (for limit)[   d   (for step)[   d   i\   c   (for index)h   t   (for limit)h   t   (for step)h   t   ii   s   (for generator)w   �   (for state)w   �   (for control)w   �   ix   �   vx   �      self_ENVcurQuestionIndexcurQuestionDataotherPlayerSelects   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       curSessionData      curQuestionData      otherPlayerSelects      curQuestionIndex         _ENV �   �       C � �   �@@ � ��  � ��A@ �A��@�� @  �@�f  & �           playerCtrlMap       IsFinishSelect           �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       	isFinish      (for index)      (for limit)      (for step)      i           �   �    	   G @ L@� d� ��� � A l  䀀
���& �    storyManagerGetCurSessionData       afterQuestionSessionTask
StartTask         �   �    
k   E   L � �@  d@�E   L�� d� b@  � �F�� �   d@ ��F A L@� � � d@�F�� �   �� d@�F�A L � �@ d@�F�� �   �� d@�F A L@� �   d@�F�� � C d @ ��A��A i�  ���F�� ��C d @ �����A i�  ���F D b   � �A@ b@    �A� ��D � EA� �E@� ��E $��@  � F ƀF ���FG GA�䀀������ ��G � ����H �AH��H�������HA	 䁀�A��A�C� �A������� �   � �@���I �@A� �@���� � J�@� ǀ��@ �   ��JA  �@�@K�& � .   LockWaitForOtherPlayerSelectFinishGetOtherPlayerIsSelectFinishYIELDquestionShow
SetActive�      questionShowAnimPlay7uieffanim_UIXiaoLinJiaStoryController_QuestionShow_outM      pairsplayerCtrlMapChangeToSelectBGoptionsShowAllSelectResultcurAnswerIsRight str_xiaolinjia_text_good_resultstr_xiaolinjia_text_bad_resultquestionResultTitleSetTextStringTableGet	roleNamequestionResultHeadspriteatlas
GetSpritemissionCfgClosingHeadIcon       curGetStarCountquestionResultStar
transform	GetChildFindstargameObjectquestionResultAudioHelperController!RequestAndPlayUIVoiceAutoReleaseCriAudioIDConstHomelandAudioBubbleUnLockafterQuestionSessionTask           k   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      TT    k   (for generator)$   )   (for state)$   )   (for control)$   )   _%   '   v%   '   (for generator),   1   (for state),   1   (for control),   1   _-   /   v-   /   	titleStr8   k   (for index)J   X   (for limit)J   X   (for step)J   X   iK   W   transP   W      self_ENV	   �   �   �   �   �   �   �   �   �      self    	   curSessionData   	   curQuestionData   	      _ENV �   �    %   G @ L@� d� ��@ � � � ����  A  A�  ���BA���̂A F�A G��CBd �  A ��B����B$C �A ǂ���GCCG���B��A���  *��& �    storyManagerGetCurSessionDatapairs       playerCtrlMapSpeaker
_DoEscapeStringTableGetContentSetSpeakContent
ContentBGSetFaceIcon	FaceIcon         %   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    %   curSessionData   %   (for generator)   $   (for state)   $   (for control)   $   _   "   data   "   (for index)   "   (for limit)   "   (for step)   "   i   !   content         _ENV      	   � @ �@@�� 
� ���@ � �C� �@�& �    storyManagerGetCurSessionID
recordPoslcBtnGroup
SetActive        	                        self    	   TT    	   curSession   	             "   � @ �@@�� ƀ@   � @��@ G�BLBA�  dB��  j��ƀA  � A� �@�ƀ@   � ���@ G�B"  � �LB�  dB��  jA�& � 	   storyManagerGetCurSessionDatapairsplayerCtrlMapSpeakerShowDialogAnimYIELDM      ShowDialog         "         	  	  	  	  
  
  
        	  	                                           self    "   TT    "   curSessionData   "   (for generator)      (for state)      (for control)      _      data      player
      (for generator)   !   (for state)   !   (for control)   !   _      data      player         _ENV   $   
F   F @ G@� ��@ ��@A � �d�  �@A ��A � �@���A ��A � �@�� B ��A@ A@AA ��B $��@  ��B ��A@ A@A �A ]��$ �@  �@C ��C � �GAD G��䀀�� ��� � A � ����E �AE��E�������EA 䁀�A�́�C� �A������F ��F� �@�� G ��F  �@��@G ��G��G � ��@ & � !   StringTableGetuiMainControllerGetEvaluatecurGetStarCountendPanelEvaluateText1SetTextendPanelEvaluateText2endPanelTitle str_xiaolinjia_text_rank_result	roleNameendPanelContentstr_xiaolinjia_rankdesc_endPanelHeadIconspriteatlas
GetSpritemissionCfgClosingHeadIcon       endPanelStar
transform	GetChildFindstargameObject
SetActive	endPanellcBtnGroupAudioHelperController!RequestAndPlayUIVoiceAutoReleaseCriAudioIDConstSoundXiaoLinJiaClosing         F                                                                                                                   !  !  !  !  "  "  "  "  #  #  #  #  #  $     self    F   str   F   (for index)*   8   (for limit)*   8   (for step)*   8   i+   7   trans0   7      _ENV &  .   !   � @ �@@� � �  A�  �� @  � A �@AƀA �� ��A�� � @ � �  � �    ��@B ǀ�� � � �� @ �@� � A � � @ �f  & �    stringgsub$$$GameGlobal
GetModuleRoleModuleGetNameisnulloremptyStringTableGetstr_guide_moren_namePlayerName         !   '  '  '  '  '  '  '  (  (  (  (  (  (  )  )  )  )  )  )  *  *  *  *  *  ,  ,  ,  ,  ,  ,  ,  -  .     self    !   strContent    !   name   !      _ENV 2  9      G @ L@� d� b   � ���@ �@ @ ���@ �@ & �    storyManagerGetCurSessionIsQuestionHandleStartQuestionSessionHandleStartDialogSession           3  3  3  4  4  5  5  5  7  7  9     self       isQuestion           ;  B      � @ �@@�� �   � �̀@ @� �@�� ���@ @� �@�& �    storyManagerGetCurSessionIsQuestionHandleEndQuestionSessionHandleEndDialogSession           <  <  <  =  =  >  >  >  >  @  @  @  B     self       TT       isQuestion           D  F      � @ �@@ � �@�& �    storyManagerUpdate           E  E  E  E  F     self       deltaTimeMS            H  U       G @ b   ��F@@ G�� d�� L�� � @ d@�
 A�G@A b   ��F@@ G�� d�� L�� �@A d@�
 ��F�A ��A d @ ����A i�  ���G@B L � d@ & � 
   afterQuestionSessionTaskGameGlobalTaskManager	KillTask questionSessionTaskpairsplayerCtrlMap
OnDisposestoryManager             I  I  I  J  J  J  J  J  J  K  M  M  M  N  N  N  N  N  N  O  Q  Q  Q  Q  R  R  Q  Q  T  T  T  U     self        (for generator)      (for state)      (for control)      _      v         _ENV W  a      F @ G@� d�� L�� ��@ � �� d@ L@A �� d@�G�A L � �@ d@�L�B �   d@�& �    GameGlobalEventDispatcher	DispatchGameEventTypeOnXiaoLinJiaMainPanelRefreshLock"UIXiaoLinJiaStoryController_CloseanimPlay*uieffanim_UIXiaoLinJiaStoryController_out
StartTask         [  `      F @ �   �@  d@�E � L�� d@ E � L�� �  d@�E � L�� �@ d@�& �    YIELDM      CloseDialogUnLock"UIXiaoLinJiaStoryController_CloseWaitForOtherPlayerSelectFinish             \  \  \  \  ]  ]  ]  ^  ^  ^  ^  _  _  _  _  `     TT          _ENVself   X  X  X  X  X  X  X  X  Y  Y  Y  Z  Z  Z  Z  [  `  [  a     self          _ENV f  �      L @ �@  d@�G�@ L�� �  d@�L@A �   d@�& �    Lock3UIXiaoLinJiaStoryController_ClosingPanelBtnOnClickendPanelAnimPlay3uieffanim_UIXiaoLinJiaStoryController_endPanel_out
StartTask         i  �   )   F @ �   �@  d@�E � L�� ��  d@�F � L@� �   d@�F�� �� @�F � L@� d@ F�B G�� � C d� L@� ƀ� ���,  C� d@���F � L@� � � d@�F � L@� d@ F � L�� d� H@ �& �    YIELD�      UnLock3UIXiaoLinJiaStoryController_ClosingPanelBtnOnClick	endPanel
SetActivecurGetStarCount       storyManager	ForceEndGameGlobal
GetModuleStoryModuleStartStorymissionCfgEndingStorylcBtnGroup-TouchQuestionResultPanelAndJumpToNextSession
recordPosGetCurSessionID          r  �    	)    @ "   @� @      ��@� @ �@ �@ D   � � �@A � � �ǁA �  �@  ��  *A�� B �@B�B �B�������   � CA l  �� ƁB ����C �@���   �C $@ & �    
getReward               assetidpairscollectionCfgItemIDquestionResultHeadatlas
GetSpritemissionCfgClosingHeadIconShowDialog$UIXiaoLinJiaGetCollectionController	roleNameOnExit          }         & �                          )   s  s  s  s  s  s  s  u  u  u  v  w  w  w  w  x  x  x  y  w  w  |  |  |  |  |  |  }  }  }            }    �  �  �  �     id
   $   cfg   $   (for generator)      (for state)      (for control)      _      v         self_ENV)   j  j  j  j  k  k  k  k  l  l  l  l  n  n  n  o  o  o  p  p  p  p  p  q  q  �  �  p  �  �  �  �  �  �  �  �  �  �  �  �  �     TT    )      _ENVself   g  g  g  h  h  h  h  i  �  i  �     self          _ENV �  �      L @ �@  d@�G�@ L�� �  d@�L@A �   d@�& �    Lock/UIXiaoLinJiaStoryController_QuestionResult_outquestionResultAnimPlay9uieffanim_UIXiaoLinJiaStoryController_QuestionResult_out
StartTask         �  �      F @ �   �@  d@�F�� L�� �   d@�F � L�� �   d@�F@� L�� d@ F�A � � d @ ��A��A i�  ���E � L�� �� d@�& �    YIELD,      questionResult
SetActivequestionRootstoryManager-TouchQuestionResultPanelAndJumpToNextSessionpairsplayerCtrlMapResetSelectBGUnLock/UIXiaoLinJiaStoryController_QuestionResult_out             �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     TT       (for generator)      (for state)      (for control)      _      v         _ENVself   �  �  �  �  �  �  �  �  �  �  �     self          _ENV �  �      G @ L@� d� b    �G @ L�� �   d@�G�@ L � �   d@�� �G @ L@� d@ & �    storyManagerGetAutoSetAuto	autoShow
SetActive TouchScreenAndJumpToNextSession           �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self            �  �      G @ L@� d� b   ��� @ ��@  �@���@ � A  �@�� @ �@A�� � @ ̀�� @ �A$� LB �A  �@ ��B �  dA�& �    storyManagerGetAutoSetAuto	autoShow
SetActiveGetDialogListGetCurSessionIDGetCurQuestionIndexShowDialogUIXiaoLinJiaReview
recordPos        �  �          "   �� � @@ � � $@��� �@ � � $@�& �    storyManagerSetAuto	autoShow
SetActive           �  �  �  �  �  �  �  �  �  �  �  �         autoself   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       auto      dialogList      curSession      curQuestionIndex           �  �      G @ L@� d� � @ ��@� �@���@ � A� �@�& �    storyManagerGetAutoSetAuto	autoShow
SetActive           �  �  �  �  �  �  �  �  �  �  �  �     self       auto           �  �      G @ L@� d� b    �F�@ G�� �  �@A ǀ��A BAA ��B ��B� �� �    lB  �  d@ & �    storyManagerGetCanJumpSessionPopupManagerAlertUICommonMessageBoxPopupPriorityNormalPopupMsgBoxType	OkCancelStringTableGetstr_story_skip_confirm         �  �      F @ L@� d� b   ��� @ ��@  �@���@ � A  �@�� @ �@A�@ & �    storyManagerGetAutoSetAuto	autoShow
SetActiveJumpSession           �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     param       auto         self �  �      F @ G@� ��  d@ & �    Logdebug(###[UIXiaoLinJiaStoryController] 取消            �  �  �  �  �     param          _ENV   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self          _ENVC                        }         �      �   �   �   �   �   �   �   �   �                 $    &  .  &  2  9  2  ;  B  ;  D  F  D  H  U  H  W  a  W  f  �  f  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �         _ENV