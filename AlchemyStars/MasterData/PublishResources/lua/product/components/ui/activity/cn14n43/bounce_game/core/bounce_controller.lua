LuaS �

xV           (w@g@../PublishResources/lua/product/components/ui/activity/cn14n43/bounce_game/core/bounce_controller.lua         g    @ A@  $@ �@ A�  � A $@��@  ���@ l   
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
@���@ l@ 
@ ��@ l� 
@���@ l� 
@ ��@ l  
@���@ l@ 
@ ��@ l� 
@��& � $   requirebounce_obj_mgr_classBounceControllerObjectConstructorInitOnQuickOnRestartGameGetDataGetUIController
GetObjMgrGetMonsterPoolGetMonsterGeneratorGetObjectsRoot
IsOvering	OnUpdateOnJump	OnAttackCheckKeyOperateChgFsmStateGetPlayerPrefabNameMonsterDead
StartOverGetOverParam	AddScoreShowHPProgressHideHPProgressHPProgressChangeGetGameDataGetGuideRtSetGuideStepShowSetGuidePositionOnTrigerGuideStep!SetPlayerChangeStateRefUICallFunPlayerChangeState           )    "   F@@ L�� d� 
@ �F A L�� d� 
@��F�A L�� d� 
@��K   
@��K ��@ �� � A �A k@�
@ �K ��� �  A k@�
@ �F�D G � �@E d� 
@ �& �    bounceDataBounceDataNewmonsterPoolBounceMonsterPoolobjMgrBounceObjMgrmonsterGeneratorfirstGuideStepPositionKeysguide5420082guide5420083guide5420085guide5420086guide5420087secondGuideStepPositionKeysguide5420092guide5420093guide5420094guideModuleGameGlobal
GetModuleGuideModule         "   
   
   
   
                                                         !   #   $   &   &   &   (   (   (   (   (   )      self    "      _ENV +   ;    
)   
@ �GA@ L���  �@ dA�F�@ G��dA� FA G��dA� GAA L���  dA�G@ L����A ǁ�dA�FAB L��d� L���� �A d� 
@�GB L��  dA�GB L����A ǁ�dA�
�Æ& �    uiControllerbounceDataInitMonsterFactoryEffectManagerobjMgrSetViewVisibleByBouceStateStateBouncefsmStateMachineManagerGetInstanceCreateStateMachineSetDataplayerChangeStateRefUICallFun          )   -   .   .   .   .   .   .   /   /   /   0   0   0   2   2   2   2   4   4   4   4   4   7   7   7   7   7   7   7   7   8   8   8   8   9   9   9   9   9   :   ;      self    )   uiController    )   levelId    )   selectPlayer    )   historyBestScore    )      _ENV >   E       G @ L@� �   d@�F�@ L�� d� L � � @ �@�d@�
�A�F�A G � d@� F@B G � d@� F�B J���& �    fsmSetDataStateMachineManagerGetInstanceDestroyStateMachineId MonsterFactoryDestroyEffectManagerBouncePlayerData	DebugIns            ?   ?   ?   ?   @   @   @   @   @   @   @   A   B   B   B   C   C   C   D   D   E      self          _ENV G   J       G @ L@� d@ L�@ ��@ � �d@�& �    objMgrResetChgFsmStateStateBouncePrepare            H   H   H   I   I   I   I   J      self          _ENV L   N       G @ f  & �    bounceData           M   M   N      self            Q   S       G @ f  & �    uiController           R   R   S      self            V   X       G @ f  & �    objMgr           W   W   X      self            [   ]       G @ f  & �    monsterPool           \   \   ]      self            `   b       G @ f  & �    monsterGenerator           a   a   b      self            e   g       G @ L@� e  f   & �    uiControllerGetCanvasRt           f   f   f   f   g      self            i   k       G @ G@� f  & �    bounceData
isOvering           j   j   j   k      self            n   �    :   � @ �@@� � �@ ��@ ��@�   @�� A �@A��� �     �& � ��@ ��@�    ���A ��A�@ B���ǀ@ �@�@ �@���@ ��B�   ����@ ǀ@ ����@�������@ ��B! C@���@ �@C���C �� ��C FD GA�� �@ & � ��D �   � ���D ��D � �@�& �    EffectManagerUpdatebounceData
isGuidingGuideHelperIsUIGuideShowguideModuleIsGuideProcess
guidingIdSetIsGuiding
isOvering	overTime         GetOverParamChgFsmStateStateBounceOverfsm	OnUpdate         :   o   o   o   o   p   p   p   p   p   p   p   p   p   q   t   t   t   t   u   u   u   u   u   v   v   v   v   y   y   y   y   z   z   z   z   z   {   {   {   {   |   |   }   }   ~   ~   ~   ~   ~      �   �   �   �   �   �   �   �      self    :   deltaTimeMS    :   
isGuiding      params,   2      _ENV �   �    !   � @ �@@�   @���@ ��@��� �@    �& � � @ � A�     �& � b   @�� @ �@@�   @��@A � ����@    �& � ��A � B�� �@B�@ & � 
   bounceData
isGuidingGuideHelperIsUIGuideShow
isOveringCheckKeyOperateJumpBtnfsmGetCurStateOnJump         !   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    !   fromPC    !   res      	curState   !      _ENV �   �    !   � @ �@@�   @���@ ��@��� �@    �& � � @ � A�     �& � b   @�� @ �@@�   @��@A � ����@    �& � ��A � B�� �@B�@ & � 
   bounceData
isGuidingGuideHelperIsUIGuideShow
isOveringCheckKeyOperate
AttackBtnfsmGetCurState	OnAttack         !   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    !   fromPC    !   res      	curState   !      _ENV �   �    )   � @ �@@�� �@  @ ��   �  ƀ@   �  ���$� "   �GAb  @�GBAb  ��GBAG��@���F�A G�d�� LB�ƂB ���C CCdB C� f �  j��   �  & �    guideModuleGetCurGuidespairsGetCurStepshowbtnGuideCfg
guideAreaGameGlobalEventDispatcher	DispatchGameEventTypeForceFinishGuideStep
GuideTypeButton         )   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   	   self    )   	btnEvent    )   guides   )   (for generator)
   &   (for state)
   &   (for control)
   &   _   $   guide   $   curStep   $      _ENV �   �       � @ �@��  @� A�@ ��@ �@    �& � � A �@�@� � �@ ��@ ̀�@� �@�& �    Logdebug'[bounce] BounceController chgfsmState fsmuiControllerSetViewVisibleByBouceStateChangeState            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       	newState       params          _ENV �   �       G @ G@� f  & �    bounceData
palyerRes           �   �   �   �      self            �      �   � @ �@@�@ �@  @ ��   �  ǀ@�   � ���@ G�@�@�� A �@�@� �@�ǀA ��� � ���ǀA ���@����@B �@ ǀA ̀�C� �@� �ǀA ����A C! �� ��@B �@ & � ǀA �@��@  ��ǀA ǀ��   ��ǀA ����A C! �@�ǀA � ĆǀA ǀ�AD �D��$��L�D�  dA�LE�AE ǁ��� d�  b  � ����F $ �A  �EBF �E$� ��  �  � �́FG�A G���A��G �A�@ �A�ƁG ���H BH�A ǁA ǁ��� ��I �A�F�I G��䁀�A  @��J �A�䁀 ́�F�J G��K �BK�A ǁA �I �I���I ���F�I G��䁀�A L��$B��A �A��A & � 2   Cfgcfg_bounce_monsterScore	AddScoreuiControllerMonsterDeadbounceDatatargetMonster        
StartOverSetKilledBosstargetScorescorehasGenBoss
genBossIdgenBossScoremonsterPoolGetSetCoreControllerGetBehaviorMonsterBeHaviorViewName
SetParentGetObjectsRootMonsterBeHaviorPositionSetPositiongenBossPosobjMgrAddMonsterAudioHelperControllerPlayUISoundAutoReleaseCriAudioIDConstN28BoucneAccBossEnterlevelId       guideModuleIsGuideDoneBounceConstGuideBoss1GameGlobalEventDispatcher	DispatchGameEventTypeGuideOpenUIUIBounceMainControllerBoss1
guidingIdIsGuideProcessSetIsGuidingPauseMoveBOSSBG_ShowBoss         �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �                                            self    �   
monsterId    �   monsterCfg   �   
monsterId;   �   monster?   �   viewG   �   posBehaviourR   �   
isGuiding~   �      _ENV 	        G @ J���G @ J ��& �    bounceData
isOvering	overTime�                 
  
           self                    K   �@@ ��@J� ��@@ � AJ���& �    ScorebounceDatascoreHistoryBestScorehistoryBestScore                              self       param                   � @ �@@ � �@���@ ��@@ A$ �@  & �    bounceData	AddScoreuiControllerScoreChange	GetScore                                    self       score                    � @ �@�@� � �@ & �    uiControllerShowHPProgress                          self       serializeId       	maxValue            !  #      � @ �@@ � �@�& �    uiControllerHideHPProgress           "  "  "  "  #     self       serializeId            &  (   	   @ A@�� �  �$A�& �    uiControllerHPProgressChange           '  '  '  '  '  '  (     self       serializeId       currentValue       	maxValue            +  -      G @ f  & �    bounceData           ,  ,  -     self            /  1      � @ �@@ � � ��   & �    uiControllerGetGuideRt           0  0  0  0  0  1     self       guideStepKey            3  5      � @ �@@ � �@�& �    uiControllerSetGuideStepShow           4  4  4  4  5     self       guideStepKey            7  9      � @ �@�@� � �@ & �    uiControllerSetGuidePosition           8  8  8  8  8  9     self       key       	position            ;  ?      � @ �@@��   � � ��@ ��@ � A��� �@A�A �A@� �@ � B  � �@�& � 	   Logdebug%[bounce] Guide_CheckMonsterPosition GameGlobalEventDispatcher	DispatchGameEventTypeN28BounceGameArriveTargetSetGuideStepShow            <  <  <  <  <  <  =  =  =  =  =  =  =  =  >  >  >  ?     self       guideStepKey          _ENV A  C      
@ �& �    playerChangeStateRefUICallFun           B  C     self       fun            E  I      � @ �   � �� @ � � �@ & �    playerChangeStateRefUICallFun           F  F  F  G  G  G  I     self       isLeaveGround           g                                 )      +   ;   +   >   E   >   G   J   G   L   N   L   Q   S   Q   V   X   V   [   ]   [   `   b   `   e   g   e   i   k   i   n   �   n   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �     �   	    	                    !  #  !  &  (  &  +  -  +  /  1  /  3  5  3  7  9  7  ;  ?  ;  A  C  A  E  I  E  I         _ENV