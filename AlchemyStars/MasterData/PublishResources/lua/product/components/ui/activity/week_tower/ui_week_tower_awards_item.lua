LuaS �

xV           (w@a@../PublishResources/lua/product/components/ui/activity/week_tower/ui_week_tower_awards_item.lua             @ A@  ��@ $@�@@  ��@@ l   
@�� A l@  
@�� A l�  
@ � A l�  
@�� A l  
@ � A l@ 
@��& � 
   _classUIWeekTowerAwardsItemUICustomWidgetOnShowUIWeekTowerAwardsItemSetDataOnHideShowTipBtnCanGetOnClickDoTakeQuest               &   �@@ �  A�  �� 
� ��@@ �  AA �� 
� ��@@ � A �� 
� ���B � ���
�����B A ���
� ���B � ���
� ��@@ �  AA �� 
� ��@@ � A �� 
� �& �    _titleGetUIComponentUILocalizationTexttitle_starCount
starCount_itemsUISelectObjectPathitems_btnCanGetGetGameObject
BtnCanGet_btnGotBtnGot_needStars
needStars_needStarCountneedStarCount_anim
AnimationUIWeekTowerAwardsItem        &                  	   	   	   	   	                                                                                          self    &   	uiParams    &           T    }   
@ �
���L�@d� ��@ �ABA �AG��$ �A  �B �AB��A���B�� ��B ��� ��AC ́�C� �A���C ́�C  �A��D ́�C  �A�����B �A�� ��AC ́�C  �A���C ́�C� �A��D ́�C  �A����AC ́�C  �A���C ́�C  �A��D ́�C� �A�ǁD ��G��� �B�]�A��A��E �E� ��$� AB ���B hB�G��ƃF ������D�G����G��D��H 
�Ȑ
��GE�
E�
E��D���IJ ����DJ	l  �D����g��   �� �J �G�J L�dB G�J LB�dB G�J L��dB LL �B  d��
@��& � 1   _questCmpt_quest
QuestInfo_titleSetTextStringTableGet
QuestName_starCounttotal_progressStatusQuestStatusQUEST_Taken_btnGot
SetActive_btnCanGet_needStarsQUEST_Completed_needStarCountcur_progress/rewards_itemsSpawnObjectsUIAsset       Cfg	cfg_itemassetidIconColorSetDataSetItemDatashowBGicontextcountqualityAddComponentUIAssetComponentEventSetClickCallBack       _animPlaySampleStop
_animTask
StartTask         >   @       E   L � �@�    d@ & �    ShowTipassetid           ?   ?   ?   ?   ?   @      go          selfreward J   R       E   N �  @�� ���� �   �@ N �  ���@� A�@ ����& �                   YIELD_animPlay
_animTask              K   K   L   L   M   M   M   N   N   P   P   P   Q   R      TT       frame         index_ENVself}                                                !   !   "   "   "   "   #   #   #   #   $   $   $   $   %   %   %   %   %   &   &   &   &   '   '   '   '   (   (   (   (   )   )   )   )   )   +   +   +   +   ,   ,   ,   ,   -   -   -   -   .   .   .   .   .   .   .   1   3   3   3   3   3   4   4   4   4   5   6   7   7   7   7   8   9   :   :   :   ;   ;   ;   ;   ;   ;   ;   ;   <   <   <   =   @   =   A   4   E   E   E   E   F   F   F   G   G   G   H   H   H   J   R   J   R   T      self    }   
questCmpt    }   quest    }   playEnterAnim    }   index    }   
questInfo   }   status   }   rewardsG   }   	uiAssetsL   }   (for index)O   k   (for limit)O   k   (for step)O   k   iP   j   rewardQ   j   uiAssetR   j   cfgItemV   j   iconW   j   qualityX   j   eventComponentf   j      _ENV V   Z    
   G @ b   @�F@@ G�� d�� L�� � @ d@�& �    
_animTaskGameGlobalTaskManager	KillTask         
   W   W   W   X   X   X   X   X   X   Z      self    
      _ENV \   ^    	   � @ AA  ��  �� �@A�@ & �    CallUIMethodUIWeekTowerAwardsControllerShowAssetTips
transform	position           ]   ]   ]   ]   ]   ]   ]   ^      self       id       go            `   b       L @ �@@    d@ & �    
StartTaskDoTakeQuest           a   a   a   a   b      self            d   o    	$   � @ A  �@���@ ��@�� � A �@�@� � ǁA ���� ��  LBd� b   �LAB ��   dA L�B � B dA  �F�C G��� ��dA�LAD �A  dA�& �    Lock"UIWeekTowerAwardsItem:DoTakeQuestAsyncRequestResNew_questCmptHandleQuestTake_questIDGetSuccShowDialogUIGetItemControllerCallUIMethodUIWeekTowerAwardsController
RefreshUILogWrapper	LogFatalHandleQuestTake failed, ret:UnLock         $   e   e   e   f   f   f   g   g   g   g   g   g   g   g   h   h   h   h   i   i   i   i   j   j   j   j   j   l   l   l   l   l   n   n   n   o      self    $   TT    $   res   $   ret   $   rewards   $      _ENV                                 T      V   Z   V   \   ^   \   `   b   `   d   o   d   o          _ENV