LuaS �

xV           (w@�@E:/depot_matchsrpg/matchsrpg/b/190/client/Assets/../PublishResources/lua/product/components/ui/homeland/find_treasure/ui/ui_find_treasure_start_game.lua             @ A@  ��@ $@�@@  ��@@ l   
@��@@ l@  
@ �@@ l�  
@��@@ l�  
@ �& �    _classUIFindTreasureStartGameUIControllerOnShowOnHide
TimerDownStart               ?   � @ �@@ƀ@ �� ��@� A�$� 
 �A �A��� $A�@ B$�� AB��B ��B�  $A A� 
 ��C � �A $� 
 ��C �� � $� 
 ��E �E$� F�A ƁF ���$� 
 ��AE AG
 ��C �GG�C �G J��G�C G��L��� BH� $�dA  L�H ��H    dA & � $   GameGlobalGetUIModuleHomelandModule
GetClient_findTreasureManagerFindTreasureManagerEnterFindTreasure       EventDispatcher	DispatchGameEventTypePlayerControllerUIStatus
_isReplay       _timerLabelGetUIComponentUILocalizedTMPTimer_anim
AnimationAnim_EMIMatResRequestResourceManagerGetInstanceSyncLoadAsset"uieff_n17_start_game_timedown.mat	LoadTypeMat_EMIMatObjfontMaterialSetTexture	_MainTexGetTexture
StartTask
TimerDown         ?               	   	                                                                                                                                                                                 self    ?   	uiParams    ?   homeLandModule   ?   homelandClient   ?   mat/   ?      _ENV           
@@�
@@�& �    _EMIMatResRequest _EMIMat                       self                J    	l   � @ A  �@���@ ��@�@ � A �   ���@A ��A� �@�� B �@ �@B � � � �@�@��@A ��A� �@��@B � �  �@�� B �@ �@B � � A �@���C ��C� D �@��D �D�@���C � E� D �@��@ �� !������@A � ��@ �@A ̀�AA �@�ǀF ���@ � ]���@��@B  � A� �@���E���@A � ��@ �@A ̀�AA �@�ǀF ���FAG G���� d �@  �@B  � A� �@�� H �@ �@H A� �@���H � �AI � ��$� L�Id� L�d� �A�  �A���J B  �A�& � +   Lock"UIFindTreasureStartGame_TimerDown_findTreasureManagerAttachModel
_isReplay_animPlay'uieffanim_N17_UIFindTreasureStartGame3StartYIELD�      'uieffanim_N17_UIFindTreasureStartGame2�      x      AudioHelperControllerPlayBGMCriAudioIDConstBGMMiniGameAudioConstValueBGMCrossFadeTimePlayUISoundAutoReleaseSummer1GameStart              Stop&uieffanim_N17_UIFindTreasureStartGame_timerLabelSetTextStringTableGet#str_homeland_find_treasure_game_goCloseDialogShowDialogUIFindTreasureMainGameGlobalGetUIModuleHomelandModule
GetClientCharacterManagerMainCharacterControllerSetForbiddenMoveUnLock         l   !   !   !   #   #   #   %   %   %   &   &   &   &   '   '   (   (   (   (   (   *   *   *   *   +   +   +   +   ,   ,   -   -   -   -   /   /   /   /   /   /   /   0   0   0   0   0   1   2   2   3   3   3   4   4   4   4   5   5   5   5   5   5   6   6   6   6   7   7   9   9   9   :   :   :   :   ;   ;   ;   ;   ;   ;   ;   <   <   <   <   >   >   ?   ?   ?   B   B   B   B   D   D   F   F   F   F   G   G   G   I   I   I   J      self    l   TT    l   time/   l   homeLandModule_   l   homelandClienta   l   characterControllere   l      _ENV L   ]    *   F @ G@� ��@ d� ��� �� � A� �@�� ���� $A���$� L��AB ǁ�䁀 �B CFBB GB�d� $  dA  FAB G��d� �C$� LDd� �B� �@ ���B�����D�B�& �    GameGlobalGetUIModuleHomelandModule
GetClientCharacterManagerMainCharacterControllerSetForbiddenMove
TransformSetLocationHomelandFindTreasureConstGetStartPositionQuaternionLookRotationGetStartDirectionGetStartCameraCameraManagerFollowCameraControllerSetCamLocation
UpdatePos	position         *   N   N   N   N   P   P   R   R   R   R   S   S   S   T   T   U   U   U   U   U   U   U   U   U   U   U   W   W   W   X   X   Z   Z   [   [   [   [   [   \   \   \   ]   
   self    *   homeLandModule   *   homelandClient   *   characterController
   *   tran   *   angleX   *   angleY   *   scale   *   
cameraMgr   *   followCameraController!   *      _ENV                                           J       L   ]   L   ]          _ENV