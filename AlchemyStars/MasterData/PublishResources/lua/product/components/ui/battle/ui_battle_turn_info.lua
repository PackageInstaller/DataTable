LuaS 

xV           (w@N@../PublishResources/lua/product/components/ui/battle/ui_battle_turn_info.lua         .    @ A@  @ $@@@  @@ l   
@@@ l@  
@ @@ l  
@@@ lÀ  
@ @@ l  
@@@ l@ 
@ @@ l 
@@@ lÀ 
@ @@ l  
@@@ l@ 
@ @@ l 
@@@ lÀ 
@ @@ l  
@&     _classUIBattleTurnInfoUICustomWidgetOnShowOnHideDisposeInitInitRoundCountSetRoundCountUpdateLeftTurnNumUpdateLeftTurnNumByDiffUpdateOutOfRoundPunishCancelRoundWarningState_DoRoundWarning_DoLeftTurnWarningAnimationPlayRemainRoundCount2Power           =       L@@ Á  d
@ L A Á@  d 
@L A Á@  d 
@L@@ Á d
@L A Á@  d 
@L A Á@  d 
@L A Á@  d 
@L A Á  d 
@L A Á@  d 
@L@@ Á d
@L A Á@  d 
@FF GÀÆ G Ç G@Ç 
@
ÀG
@H
@HL@@ ÁÀ dG É    
   
 
 Ê@
 ÇÀI A
 ¨ÀJ A@ÁÁ
 ¤ ÇIÌË@   äA ÌAKC  äAÌKAÂ äILB $KB $FL GÂÌBI ÀdBFL GÂÌI À dB§÷ M ¤@ @M M ÁMGÁM ¤@ @M M NGAN ¤@ @M M NGÁN ¤@ @M M OGO ¤@ @M M AOGO ¤@ &  ?   _leftTurnNormalGOGetGameObjectNormal_leftTurnNumGetUIComponentUILocalizationTexttxtTurnCount_leftTurnLittleNumtxtLittleTurnCount_leftTurnWarningGOWarning_leftTurnWarningNumwarningtxtTurnCount_leftTurnWarningNumBGwarningtxtTurnCountBG_leftTurnWarningLittleNumwarningtxtLittleTurnCount_leftTurnWarningOutLineNumOutline_roundDescTexttext_outOfOrderGOOutOfOrder_damagePercentTextdamagePercent_warningRoundCountCfgcfg_globalinner_game_warning_round_count	IntValue_warningRoundState _doTweenSequence _roundWarningTaskIDUP_Eff
transform_arrAnimEffUp_arrTextEffUp_effArrLen              	UIHelperUIEff_TurnInfo_tiaodong.prefab
SetParent
SetActiveGetComponent
AnimationFindnumbertableinsertInitAttachEventGameEventTypeInitRoundCountUpdateRoundCountUpdateLeftTurnNumUpdateRoundCountByDiffUpdateLeftTurnNumByDiffUpdateOutOfRoundPunishRemainRoundCount2PowerPlayRemainRoundCount2Power                        	   	   	   	   	                                                                                                                                                   !   #   %   '   '   '   '   )   )   *   *   +   ,   ,   ,   ,   -   -   -   -   .   .   .   .   .   /   /   /   0   0   0   1   1   1   1   1   1   1   2   2   2   2   2   3   3   3   3   3   ,   6   6   8   8   8   8   8   9   9   9   9   9   :   :   :   :   :   ;   ;   ;   ;   ;   <   <   <   <   <   =   	   self       
tranUpEff@      (for index)H   j   (for limit)H   j   (for step)H   j   iI   i   goAnimEffUpM   i   animX   i   txt_   i      _ENV ?   G       
@@
@@LÀ@ Æ A Ç@ÁAA d@ LÀ@ Æ A ÇÁÁA d@ LÀ@ Æ A Ç ÂAB d@ LÀ@ Æ A ÇÂB d@ LÀ@ Æ A ÇÀÂC d@ &     _arrAnimEffUp _arrTextEffUpDetachEventGameEventTypeInitRoundCountUpdateRoundCountUpdateLeftTurnNumUpdateRoundCountByDiffUpdateLeftTurnNumByDiffUpdateOutOfRoundPunishRemainRoundCount2PowerPlayRemainRoundCount2Power            @   A   B   B   B   B   B   C   C   C   C   C   D   D   D   D   D   E   E   E   E   E   F   F   F   F   F   G      self          _ENV I   M    
   G @ b   @F@@ GÀ d LÀÀ Ç @ d@&     _roundWarningTaskIDGameGlobalTaskManager	KillTask         
   J   J   J   K   K   K   K   K   K   M      self    
      _ENV O   Q       G @ L@À Ã   d@&     _leftTurnWarningGO
SetActive           P   P   P   P   Q      self            U   [       @@ @¤ 
 À@ ¤@  A   ¤@@A   ¤@&     _outOfRoundTypeBattleStatHelperGetLevelOutOfRoundTypeCancelRoundWarningStateSetRoundCountUpdateLeftTurnNum            V   V   V   V   X   X   Y   Y   Y   Z   Z   Z   [      self       
turnCount          _ENV _   f        
@ @@ @Á@ @ $ ¤@   A @Á@ @ $ ¤@  @A @Á@ @ $ ¤@  A @Á@ @ $ ¤@  ÀA @Á@ @ $ ¤@  &     _recordLeftTurnCount_leftTurnNumSetText	tostring_leftTurnLittleNum_leftTurnWarningNum_leftTurnWarningLittleNum_leftTurnWarningNumBG             `   a   a   a   a   a   a   b   b   b   b   b   b   c   c   c   c   c   c   d   d   d   d   d   d   e   e   e   e   e   e   f      self        
turnCount           _ENV i   u        @  @ @@@ ¢    @ ¤@ À @ !  @@ ¢@  @ À@ ¤@  A @AÀ A   ¤@  @ A   ¤@&     _warningRoundCount_warningRoundStateCancelRoundWarningState_DoRoundWarning_outOfRoundType        SetRoundCount           j   j   j   j   j   j   k   k   k   l   l   l   l   l   l   m   m   p   p   p   q   q   q   q   r   r   s   s   s   u      self       leftTurnNum            v   }    	    @ ¢@    &  Í@ A@ $A&     _recordLeftTurnCountUpdateLeftTurnNum        	   w   x   x   y   {   |   |   |   }      self    	   leftTurnNumDiff    	   curUiRecordTurn   	   leftTurnNum   	               	'    @ @@  &  @ À@ A  ¤@@A  A  ¤@A  A  ¤@ÀA  A ¤@ B @BÀ  ¤ ÇB ÌÀÂFC GAÃ ÆC ÇÁÃDä B «A d ä@  &     _outOfRoundType        _roundDescTextgameObject
SetActive_leftTurnNormalGO_leftTurnWarningGO_outOfOrderGOBattleStatHelperGetOutOfRoundPunishHPPercent_damagePercentTextSetTexttableconcatmathfloord       %         '                                                                                                                           self    '   
isPreview    '   percent   '      _ENV        
   
@@G@ LÀÀ Ã  d@G A LÀÀ Ã   d@&     _warningRoundState _leftTurnNormalGO
SetActive_leftTurnWarningGO        
                                    self    
                  
@@G@ LÀÀ Ã   d@G A LÀÀ Ã  d@FA GÀÁ d L Â Ç@B    d 
@&  
   _warningRoundState_leftTurnNormalGO
SetActive_leftTurnWarningGO_roundWarningTaskIDGameGlobalTaskManagerCoreGameStartTask_DoLeftTurnWarningAnimation                                                                     self          _ENV    ³    	B   @@ @À@ A¤ 
 @A  ¤ÇÀA â    Ç BÌ@ÂFB Á ÁÁ  d A ä@ ÇC ÌÀÃA A ä@ ÇÀA â@    &  ÆD   AÁ ä@Æ E Ì@Åä ÌÅä ÁE F  AF FAÁ $A  ÁA "A    &  C ÁC Á $A BFB  Á  d 
AÀñ&     _DoTweenSequenceDG	TweeningDOTween	SequenceGetGameObjectwarningtxtTurnCountBG_warningRoundState
transformDOScaleVector3ÍÌÌÌÌÌô?       É?_leftTurnWarningNumBGDOFade        ¹?YIELDÈ       GameGlobalGetInstanceCoreGameStateIDGameStateIDInvalidLognoticequit game alreadyÿ       localScale         B                                          ¡   ¡   ¡   ¡   ¡   ¡   ¡   ¡   ¡   £   £   £   £   £   ¤   ¤   ¤   ¥   §   §   §   §   ¨   ¨   ¨   ¨   ¨   ©   ©   ©   ©   ª   ª   ª   ª   ª   ­   ­   ­   ®   °   °   °   °   °   ±   ±   ±   ±   ±   ±   ±   ±   ³      self    B   TT    B   sss	   B   coreGameStateID'   @      _ENV ¸   Ô       ! @  &  Æ@@ ÌÀä ÇÀÀA ä Ì@Áä A ÁA_ À A B   &  AB ¬  À  $A &  
           GameGlobalGetInstance
GetModuleMatchModuleGetMatchType
MatchTypeMT_MazeMT_SeasonMaze
StartTask         Â   Ñ    6   E     R   Á   A  ¨ @@ÆÁ@ÇÇÁÌAÁC äAÆÁ@ÇÌÁäA ÆÁAÇBÂ@$ ÊÅ ÌÂNÀäAÆÁÂÇÃä ÌAÃFÃGÂÃ äA ÆÄ   AB äAÆÁ@âA    &  ÆÁ@ÇÇÁÌAÁC  äA§@ô&            ÿÿÿÿÿÿÿÿ_effArrLen_arrAnimEffUpgameObject
SetActivePlay_arrTextEffUptext	tostringSetRoundCountGameGlobalEventDispatcher	DispatchGameEventTypeRemainRoundCount2PowerPetYIELDd                 6   Ã   Ã   Ã   Ä   Ä   Ä   Ä   Å   Å   Å   Æ   Æ   Æ   Æ   Æ   Æ   Ç   Ç   Ç   Ç   È   È   È   È   È   È   É   É   É   É   Ê   Ê   Ê   Ê   Ê   Ê   Ê   Ê   Ë   Ë   Ë   Ë   Ì   Ì   Ì   Í   Ï   Ï   Ï   Ï   Ï   Ï   Ä   Ñ      TT    6   
perEnergy   6   (for index)   5   (for limit)   5   (for step)   5   i   4   idx
   4      
energyNumcurRemainRoundself_ENV   ¹   ¹   º   ¼   ¼   ¼   ¼   ¼   ¼   ¼   ¼   ½   ½   ½   ½   ½   ½   ½   ½   ¾   Á   Ñ   Ó   Á   Ô      self       
energyNum       curRemainRound       
matchType         _ENV.                        =      ?   G   ?   I   M   I   O   Q   O   U   [   U   _   f   _   i   u   i   v   }   v                                 ³      ¸   Ô   ¸   Ô          _ENV