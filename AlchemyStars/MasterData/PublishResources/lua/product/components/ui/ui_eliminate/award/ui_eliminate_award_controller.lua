LuaS �

xV           (w@d@../PublishResources/lua/product/components/ui/ui_eliminate/award/ui_eliminate_award_controller.lua         %    @ A@  ��@ $@�@@  ��@@ l   
@��@@ l@  
@ �@@ l�  
@��@@ l�  
@ �@@ l  
@��@@ l@ 
@ �@@ l� 
@��@@ l� 
@ �@@ l  
@��@@ l@ 
@ �& �    _classUIEliminateAwardControllerUIControllerConstructorOnShowOnHide_GetComponentInitComponentOnItemSelectFullBtnOnClick_CloseGetAllRewardCheckAwardCanReceive    
              & �                      self            	          �@@ �  F�@ G��� 
� ��@A �@ ��A �@ & �    atlas	GetAssetUIEliminate.spriteatlas	LoadTypeSpriteAtlas_GetComponentInitComponent            
   
   
   
   
   
                     self       	uiParams          _ENV           F @ G@� d�� L�� ��@ � �d@�& �    GameGlobalEventDispatcher	DispatchGameEventTypeAniPopRoundRes                                       self          _ENV           L@@ ��  �  d� 
@ �L@@ �@ � d� 
@ �L@@ �  A d� 
@��& � 
   
_scoreTxtGetUIComponentUILocalizationText	scoreTxt_awardAreaUISelectObjectPath
awardArea_anim
Animationanim                                                              self               5    4   F @ G@� ��@ d� ��� �� � AA�F�A G��G��B �ABǁ�������   AB ����� ����C D$�� GBD L����D ��C @���dB  G�E L��B  d� 
@�F�F ��E d@����@ �  �D  �C i�  ���& �    GameGlobal
GetModuleAnipopModuleGetAniPopInfo
week_infohard_idCfgcfg_anipop_hardmathmintotal_score	MaxScore<color=#ffe288>/	</color>EliminateHelperGetAwardList
_scoreTxtSetTextStringTableGetstr_eliminate_award_title_1_awards_awardAreaSpawnObjectsUIEliminateAwardItempairsSetData         ,   0       E   L � �     d@ & �    
StartTask        -   /       E   L � �   d@�& �    GetAllReward            .   .   .   .   /      TT          self   -   -   /   /   -   0      cfgID          self 1   3       �   � @   @� �@ & �    OnItemSelect           2   2   2   2   2   3      id       pos          self4                        !   "   "   "   #   #   #   #   #   $   $   $   $   $   $   %   %   %   '   '   '   '   '   '   '   '   )   )   )   )   )   )   +   +   +   +   ,   ,   ,   0   3   ,   +   +   5      self    4   anipopModule   4   anipopInfo   4   	weekInfo   4   scoreHardID   4   scoreHardCfg   4   showTotalScore   4   scoreProcess   4   
awardList   4   (for generator)*   3   (for state)*   3   (for control)*   3   i+   1   award+   1      _ENV 7   >       � @ �@  ���@@ A�  ��  � ��A $��
 �� @ ̀�@� � �@ & �    _selectInfoGetUIComponentUISelectObjectPathselectInfoPoolSpawnObjectUISelectInfoSetData           8   8   8   9   9   9   9   :   :   :   :   =   =   =   =   =   >      self       id       pos       selectInfoPool           @   B       L @ d@ & �    _Close           A   A   B      self            D   L       L @ �   d@�& �    
StartTask         E   K       E   L � �@  d@�F�@ L�� �@  d@�F � �   �@ d@�E   L�� �@  d@�E   L�� d@ & �    Lock%uieff_UIEliminateAwardController_out_animPlayYIELD�      UnLockCloseDialog             F   F   F   F   G   G   G   G   H   H   H   H   I   I   I   I   J   J   J   K      TT          self_ENV   E   K   E   L      self          _ENV O   f    ;   �   � @ �@��@ � �@ � $A�AA G�A $��L�Ad� �B�� �BB @ ��� �  @�̂�@� � �� L��d� b  ��FCA � d ��C �DC	�  ��D�i�  ��@�F�C G��� �C�� dC  )�  �A��D � $A��D � � ,  $A�& �    GameGlobal
GetModuleAnipopModuleLock%UIEliminateAwardController_GetRewardpairs_awards	GetScore	GetCfgIDCheckAwardCanReceive
GetRewardGetSucctableinsertLogfatal奖励领取失败：
GetResultUnLockShowDialogUIGetItemController         b   e            @ $@ @� �@ $�� �@ � � �@A$@�& �    InitComponentGameGlobalEventDispatcher	DispatchGameEventTypeAniPopRefreshRedPoint             c   c   c   d   d   d   d   d   d   d   e          self_ENV;   P   Q   Q   Q   Q   R   R   R   S   S   S   S   T   T   U   U   V   V   V   V   V   V   W   W   W   W   X   X   X   X   Y   Y   Y   Y   Z   Z   Z   Z   Z   Y   Y   [   ]   ]   ]   ]   ]   ]   S   S   a   a   a   b   b   b   e   b   f      self    ;   TT    ;   showReward   ;   anipopModule   ;   (for generator)   2   (for state)   2   (for control)   2   _   0   award   0   score   0   cfgID   0   res   0   rewards   0   (for generator)!   )   (for state)!   )   (for control)!   )   _"   '   v"   '      _ENV i   t    	   � @ �@��@ � ��$� GA�A�!�@���A ��A�� � ����A  � ��� � @ ��  � & � 	   GameGlobal
GetModuleAnipopModuleGetAniPopInfo
week_infototal_scoretable
icontainsscore_received            j   j   j   j   k   k   l   n   n   n   n   n   n   n   n   n   n   p   p   p   r   r   t      self       cfgID       score       anipopModule      anipopInfo      	weekInfo         _ENV%                              	      	                        5      7   >   7   @   B   @   D   L   D   O   f   O   i   t   i   t          _ENV