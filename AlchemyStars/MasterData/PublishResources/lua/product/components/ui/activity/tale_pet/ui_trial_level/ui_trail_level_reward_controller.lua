LuaS �

xV           (w@�@C:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/lua/product/components/ui/activity/tale_pet/ui_trial_level/ui_trail_level_reward_controller.lua         !   �  
@@�
�@�
@A�F�A �� �   d@�F B �@ ƀB d@�F@B @��F@B �   J���F@B �@  J� �F@B ��  J���F@B ��  J� �F@B �  J���F@B �@ J� �& �    UnComplete       UnGet        HasGet       _enumTrailLevelRewardStatus_classUITrailLevelRewardControllerUIControllerLoadDataOnEnterOnShow_InitScrollView_OnGetRewardItem_RefreshRewardItemInfoMaskOnClick           !    5   @ A@F�@ $� LAAd� 
��
@��K  
@�L�Ad� � �� ����B��  B����B��C CCGC�CG�C�B�GCD�B�G�D�B�FCE G����Ed� �B�FCE G���CFǃ�d���B�G�A ��A � �BJ������A � 
��& �    GameGlobal
GetModuleTalePetModule_level
_maxLevelGetLevelCount_rewardDataGetTrailLevelRewardList       idstatus       Cfgcfg_tale_stage_rewardcountCounticonIcondropIdDropIdnameStringTableGetNamedesDesc_rewardCount         5                                                                                                                                                                  !      self    5   TT    5   res    5   	uiParams    5   talePetModule   5   rewardDatas   5   (for index)   1   (for limit)   1   (for step)   1   i   0   data   0   rewardData   0   cfg   0      _ENV #   )       �@@ �  A�  �� 
� �� A �@ �A A� �@� @ � �FAB G���� � d��@  �@@ AA �� � 
� ���C �@ & �    _levelLabelGetUIComponentUILocalizationTextLevel_level/<color=#FF7800>
_maxLevel	</color>SetTextStringTableGet)str_tale_pet_trail_level_reward_progress_scrollViewUIDynamicScrollViewRewardList_InitScrollView            $   $   $   $   $   %   %   %   %   %   &   &   &   &   &   &   &   &   '   '   '   '   '   (   (   )      self       	uiParams       param
         _ENV ,   3       G @ L@� ǀ@ ,  d@ & �    _scrollViewInitListView_rewardCount        /   1       �   � @   @� �  �   & �    _OnGetRewardItem           0   0   0   0   0   0   1      scrollview       index          self   -   -   .   1   -   3      self            5   I    /   � � AA  䀀�@ ��  ��$� GA��� �����LB�A � dA L�Bd� ����  ��́BC  �@�BC$� �C�  $B� �BC$� �C�� $B��C � ��$B �D �A����� $��A  �  & �    NewListViewItemRowItemGetUIComponentDynamicUISelectObjectPathgameObjectIsInitHandlerCalled SpawnObjectsUITrailLevelRewardItem       GetAllSpawnList_rewardCountGetGameObject
SetActive_RefreshRewardItemInfo	UIHelperRefreshLayoutGetComponentRectTransform         /   6   6   6   7   7   7   7   8   8   8   9   :   :   :   :   <   <   =   >   >   ?   @   @   @   A   A   A   A   A   A   C   C   C   C   C   D   D   D   D   G   G   G   G   G   G   H   I      self    /   scrollView    /   index    /   item   /   rowPool   /   rowList   /   itemWidget   /   
itemIndex   '      _ENV K   N       � � GA@ G���@�& �    Refresh_rewardData           M   M   M   M   N      self       itemWidget       index            P   T       F @ G@� d�� L�� ��@ � �d@�F @ G@� d�� L�� ��@ �@�d@�L�A d@ & �    GameGlobalEventDispatcher	DispatchGameEventTypeTalePetTrailLevelRewardChangeTalePetRedStatusChangeCloseDialog            Q   Q   Q   Q   Q   Q   Q   R   R   R   R   R   R   R   S   S   T      self          _ENV!                           
   
   
   
            !      #   )   #   ,   3   ,   5   I   5   K   N   K   P   T   P   T      TrailLevelRewardStatus   !      _ENV