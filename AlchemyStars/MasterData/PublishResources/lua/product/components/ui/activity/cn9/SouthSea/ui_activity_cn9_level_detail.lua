LuaS 

xV           (w@f@../PublishResources/lua/product/components/ui/activity/cn9/SouthSea/ui_activity_cn9_level_detail.lua         >     
@@
À@F A @ À   d@FA À Æ B d@FÀA @FÀA ¬   JFÀA ¬@  J FÀA ¬  JFÀA ¬À  J FÀA ¬  JFÀA ¬@ J FÀA ¬ JFÀA ¬À J FÀA ¬  JFÀA ¬@ J FÀA ¬ JFÀA ¬À J FÀA ¬  JFÀA ¬@ J FÀA ¬ JFÀA ¬À J &     Normal       Special       _enumCN9SouthSeaRoadType_classUIActivityCN9LevelDetailUIControllerLoadDataOnEnterOnShowInitWidgetOnHide	ShowTips
SetDetail
SetNormalSetSpecialRefreshCloseBtnOnClickSpecialStartBtnOnClickNormalStartBtnOnClick
StartGameOnFinishGameHandleScoreShowRewards                  Ì @C ä@&     SetSucc                          self       TT       res                      @À 
 ÀÀ 
 @Á 
 ÀÁ 
 @Â 
 ÀÂ 
 @ @CC
 ÀC ¤@  D ¤@ &     _ASheepCom       _ASheeoComInfo       _id       _passmission       _refreshPoint       _refreshBookRed       _BestScorem_infom_max_scoreInitWidget
SetDetail                                                                             self       	uiParams               ,    /   L@@ Á  d
@ L A Á@  d 
@L A Á  A d 
@L A Á  Á d 
@ L@@ Á@ d
@ L A Á@ Á d 
@ L A Á  A d 
@ LD ÆÀD Ç ÅAE d@ L A Á@  d  Æ A ¤
&     _SpecialDetailGetGameObjectSpecialDetail_SpecialContentGetUIComponentUISelectObjectPathSpecialContent_LevelNameSUILocalizationTextLevelNameS_BestScoreTxt
BestScore_NormalDetailNormalDetail_NormalContentNormalContent_LevelNameNLevelNameNAttachEventGameEventTypeShowItemTips	ShowTips	itemTips_tipsSpawnObjectUISelectInfo         /                                   !   !   !   !   !   "   "   "   "   "   %   %   %   %   &   &   &   &   &   '   '   '   '   '   )   )   )   )   )   *   *   *   *   +   +   +   +   ,      self    /   s*   /      _ENV .   0       L @ Æ@@ ÇÀÁ@ d@ &     DetachEventGameEventTypeShowItemTips	ShowTips            /   /   /   /   /   0      self          _ENV 2   4       Ç @ Ì@À@  ä@ &     _tipsSetData           3   3   3   3   3   4      self       itemId       pos            6   F    /   F@@ GÀ À@ G 
@ G @ G Á  @ A
ÀA  BAB B@ $ ¤@  ÀB  BAB B@ $ ¤@   @  CÆ@Ã À C ÀC ¤@ D ¤@ @@D  BD ¤@ÀD ÀC ¤@ E ¤@ &     cfgCfgcfg_component_asheep_mission_idMissionName_MissionID
MissionID_LevelNameSSetTextStringTableGet_LevelNameNTypeNormal_NormalDetail
SetActive
SetNormal_BestScoreTxt_BestScore_SpecialDetailSetSpecial          /   7   7   7   7   7   8   8   9   9   9   :   :   :   :   :   :   :   ;   ;   ;   ;   ;   ;   ;   >   >   >   >   >   ?   ?   ?   ?   @   @   @   B   B   B   B   C   C   C   C   D   D   F      self    /   name   /      _ENVCN9SouthSeaRoadType H   [    (   G @ L@À Á  Á  d@ D    A ¢@  @ C    @A Ç A ¤ ÇA @ C  À   C   ©  *ý @  B¤ 
@B ÇÀA ¤  ÌBFÂÂ C À äA©  *þ&     _NormalContentSpawnObjectsUIACtivityCN9LevelAwardItem       _passmissionpairs_MissionID_NormalNodesGetAllSpawnListipairsSetDataNormal_id          (   I   I   I   I   I   J   K   K   K   L   L   N   N   N   N   O   O   O   P   P   Q   S   N   N   W   W   W   W   X   X   X   X   Y   Y   Y   Y   Y   X   X   [      self    (   pass   (   (for generator)      (for state)      (for control)      i      v      (for generator)   '   (for state)   '   (for control)   '   i    %   v    %      _ENVCN9SouthSeaRoadType ]   k    "   F@@ GÀ 
@ GÀ@ L Á Á@  d@ GÀ@ L Â d 
@F@B ÀA d @ BÄ  ÂB ! @ Ã   Ã  ÃBÃ À  $Bi  êû&     SpecialCfgCfg$cfg_component_asheep_mission_reward_SpecialContentSpawnObjectsUIACtivityCN9LevelAwardItem       _SpecialNodesGetAllSpawnListipairsScoreLimit_BestScoreSetDataSpecial          "   ^   ^   ^   _   _   _   _   _   `   `   `   `   a   a   a   a   b   b   b   c   d   d   d   e   e   g   i   i   i   i   i   a   a   k      self    "   (for generator)   !   (for state)   !   (for control)   !   i      v      ScoreLimit      get         _ENVCN9SouthSeaRoadType m       .    @ ¢   @  @ ¤@ @@ @ÆÀ@ À @ Á Ç@A ¤  ÌAC äA©  *þ ÀA  @ À  B @B  ¤@ Á ÇB ¤ ÀÇÁB ÇAÇÃ  !@@      LAÀ dB©  *Aü&     _refreshPointcfgTypeNormalipairs_NormalNodesSetPass_BestScore_BestScoreTxtSetText_SpecialNodesSpecialCfgScoreLimit          .   n   n   n   o   o   q   q   q   q   q   r   r   r   r   s   s   s   r   r   t   v   v   v   w   w   w   w   z   z   z   z   {   {   {   |   }   }   ~   ~               z   z         self    .   score    .   (for generator)      (for state)      (for control)      i      v      (for generator)   -   (for state)   -   (for control)   -   i   +   v   +   ScoreLimit"   +   get#   +      CN9SouthSeaRoadType_ENV        
   @@   AÁ  ¤ 
   Ì@A l  ä@&     _AnimGetUIComponent
AnimationAnim!UIActivityCN9LevelDetail_AnimOUT
StartTask                   E   L À Å  d@F@@ LÀ ÁÀ  d@F A   Á@ d@E   LÁ d@ E   LÀÁ Å  d@&     Lock_AnimPlay$uianim_UIActivityCN9LevelDetail_outYIELDô      CloseDialogUnLock                                                                            TT          self	LockName_ENV
                                    self    
   go    
   	LockName   
      _ENV            @ ¤@ &     
StartGame                       self       go                        @ ¤@ &     
StartGame                        self       go            ¢   ¨       F @ G@À d @ Á@ AGAA ¬  À ¤@ &     AudioHelperControllerGetCurrentBgmShowDialogUIStateTypeUICN9MainGame_MissionID         ¤   §    
       @   @ ¤@    @@  ¤@&     OnFinishGameRefresh        
   ¥   ¥   ¥   ¥   ¥   ¦   ¦   ¦   ¦   §      id    
   score    
      self   £   £   £   ¤   ¤   ¤   ¤   §   §   ¤   ¨      self       bgmid         _ENV ª   ¬    	   Ì @ GA@   À   ä@ &     
StartTaskHandleScore           «   «   «   «   «   «   ¬      self       
missionId       score            ®   ½          LA@ À dAF@ LÁÀd A AA  @ À¤Á A  $BÂÁ$ "  À B $B@BB BAÂ Ã¤ $B  &     %UIActivityCN9LevelDetail:HandleScoreLockAsyncRequestResNew_ASheepComHandleCompleteASheepMissionUnLockGetSuccShowRewardsLogerror8###[UIActivityCN9LevelDetail] HandleScore fail, result:
GetResult             °   ±   ±   ±   ³   ³   ³   ´   ´   ´   ´   ´   ´   ´   µ   µ   µ   ·   ·   ·   ·   ¸   ¸   ¸   ¸   º   º   º   º   º   º   ½      self        TT        id        score        	lockName       res       ret       rewards          _ENV ¿   Æ       b   @ @ @@À   ¤@@ ¢   @ @ ¤@ &     UIActivityHelperShowUIGetRewards_refreshBookRed            À   À   Á   Á   Á   Á   Á   Â   Â   Â   Ã   Ã   Æ      self       rewards          _ENV>                        	   	   	   	   
   
                        ,      .   0   .   2   4   2   6   F   6   H   [   H   ]   k   ]   m      m                               ¢   ¨   ¢   ª   ¬   ª   ®   ½   ®   ¿   Æ   ¿   Æ      CN9SouthSeaRoadType   >      _ENV