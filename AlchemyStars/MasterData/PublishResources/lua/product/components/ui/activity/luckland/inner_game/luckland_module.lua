LuaS 

xV           (w@`@../PublishResources/lua/product/components/ui/activity/luckland/inner_game/luckland_module.lua             @ A@  @ $@@@  @@ l   
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
@@@ l@ 
@ @@ l 
@@@ lÀ 
@ @@ l  
@@@ l@ 
@ @@ l 
@@@ lÀ 
@ @@ l  
@@@ l@ 
@ @@ l 
@@@ lÀ 
@ @@ l  
@@@ l@ 
@ @@ l 
@@@ lÀ 
@ @@ l  
@@@ l@ 
@ @@ l 
@@@ lÀ 
@ @@ l  
@@@ l@ 
@ @@ l 
@@@ lÀ 
@ @@ l 	 
@@@ l@	 
@ @@ l	 
@@@ lÀ	 
@ @@ l 
 
@@@ l@
 
@ @@ l
 
@@@ lÀ
 
@ @@ l  
@@@ l@ 
@ &  1   _classLuckLandModuleObjectConstructorDisposeInitGetConfigMngGetEntityMngGetBuffMngGetTriggerMngRoundStartMonsterTurn	RoundEndClearTmpDataGenFightPetsInitFightPetsDoPetLogicGetAllBuildingsDoBuildingLogic
OnProductDoPetAttackDoMonsterLogic	DrawCardIsGoldEnoughAddGold	CostGoldGetGold	GetCurHP	AddMaxHpAddHP	ReduceHPCheckHasExtraDrawCardSelectCardSkipSelectCardResetReDrawCountGetReDrawCostReDrawCardBuildingUpgradeBuildingUpgradeDrawCardGetDelCardCountGetDeleteCardCostDeleteCardGetDrawCardResultGetRoundProductionGetCurRoundCountPosList	GetWordsRandomCards_DrawCardInPool    .       #    "   F@@ LÀ d 
@ F A LÀ d 
@FA LÀ d 
@F B LÀ d 
@
Â
Â
B
Â
B
Â
B
ÄK   
@
B
ÂK   
@ 
Â
B
Â&     _configMngLLConfigMngNew_entityMngLLEntityMng	_buffMng
LLBuffMng_triggerMngLLTriggerMng_maxHP        _curHP_gold_atk_gameRound
_posCount
_curRound_isRunning_drawCardPool_reDrawCount_delCardCount_drawCardResult_roundGold
_roundAtk_roundRecover         "               	   	   	   	                                                                         !   "   #      self    "      _ENV %   1       G @ L@À d@ 
@GÀ@ L@À d@ 
ÀG A L@À d@ 
@G@A L@À d@ 
À&     _configMngDispose _entityMng	_buffMng_triggerMng           &   &   &   '   )   )   )   *   ,   ,   ,   -   /   /   /   0   1      self            3   B    '    @ @@  ¤@@ @@   ¤@ @ À@¤ Ì@Aä @ A$ Í 
À Ç A 
ÀÌ@Bä 
À ÌÀBä 
À 
@CÇ@ ÌÀÃä 
À Ç@ Ì@Ää 
À ÌÀDä 
À &     _configMngInit_entityMngGetLevelConfigData_maxHPGetInitMaxHPGetBuildingMaxHPIncrease_curHP_goldGetInitGold_gameRoundGetLevelRoundCount
_curRound       
_posCountGetPosCount	_posListGetPosList_affixListGetAffixList        '   4   4   4   4   5   5   5   5   9   9   9   :   :   :   :   :   :   :   ;   ;   <   <   <   =   =   =   >   ?   ?   ?   ?   @   @   @   @   A   A   A   B      self    '   
missionID    '   levelCfgData   '        D   F       G @ f  &     _configMng           E   E   F      self            H   J       G @ f  &     _entityMng           I   I   J      self            L   N       G @ f  &     	_buffMng           M   M   N      self            P   R       G @ f  &     _triggerMng           Q   Q   R      self            T   k       G @ M@À 
@ L@ d@ LÀ@ d  A   ¤@@A ¤@ A ¤@ ÀA ¤@ &     
_curRound       ClearTmpDataGenFightPetsInitFightPetsDoPetLogicDoBuildingLogic
OnProduct           V   V   V   X   X   [   [   ^   ^   ^   a   a   d   d   g   g   k      self       petIDs           m   p       L @ d@ &     DoMonsterLogic           o   o   p      self            r   u       L @ d@ &     	DrawCard           t   t   u      self            x       
   
@@
@@
@ÀG A L@Á d@ G A LÁ d@ &     _roundGold        
_roundAtk_roundRecover_entityMngDestroyEntityClearEntityTmpData        
   y   z   {   ~   ~   ~                  self    
               1   G @ L@À d    Æ@   ä @Â@ A@ BÁ¤ $B  é  jÁýÇ @ ÌÀÁä 
À Ç @ Ì@Âä 
À Ë    GA  (   @C BCA  $GBÊ@Â@ CÀ  ¤B'Aûæ  &     _entityMngGetBackpackPetsipairstableinsertID
_posCountGetPosCount	_posListGetPosList               mathrandomremovev         1                                                                                                                                                         self    1   backpackPets   1   
petIDList   1   (for generator)      (for state)      (for control)      _      pet      randomIDResult   1   (for index)   /   (for limit)   /   (for step)   /   i   .   randVal%   .   randID&   .      _ENV    ª        @ @@¤@ @ À  ¤ @Ç@ ÌÁÀ@ äÁ$B@ BA$BA ÂAB BB ¤$B  ©  *Áú&  
   _entityMngClearFightPetsipairsGetPetByIDSetGenIndexAddFightPet_triggerMngNotifyLLNTPetEnterNew                        ¡   ¡   ¡   ¡   £   £   £   £   ¤   ¤   ¤   ¦   ¦   ¦   ¦   ¨   ¨   ¨   ¨   ¨   ¨   ¨   ¡   ¡   ª      self       petIDs       (for generator)      (for state)      (for control)      index      petID      pet         _ENV ­   ä       K    @ @@À  @ Á@$ ¤@   @ @@À  @ A$ ¤@   @ @@À  @ AA$ ¤@  A À  ¤ ÇÁA ÌÂFBB LÂÀ däA  ©  *ýA À  ¤ ÇÁA ÌÂFÂB LÂÀ däA  ©  *ýA À  ¤ ÇÁA ÌÂFC LÂÀ däA  ©  *ý@ À@¤ ÆA   ä BÃ$ "B  Ã$B ÂÃ$  D ÂA BBD B ¤$B  Ä$B é  júÇ@ ÌÀÄä   FA d@@ EÀ CÅ$ ¤B  i  êÁýFA  d @ E ¤¢  ÌÂEä âB  ÇÂA ÌÂFF LÂÀ däB  i  êû&     tableappendArray_entityMngGetFightPetsGetBuildingsGetFightMonstersipairs_triggerMngNotifyLLNTPetTurnStartNewLLNTPetTurnLLNTPetTurnEndHasDeleteFlagCostCountDownGetCountDown        LLNTCountDownResetCountDownGetBackpackPetsinsertIDGetPetByIDIsFightLLNTBackpackTurn            ¯   °   °   °   °   °   °   °   ±   ±   ±   ±   ±   ±   ±   ²   ²   ²   ²   ²   ²   ²   µ   µ   µ   µ   ¶   ¶   ¶   ¶   ¶   ¶   ¶   µ   µ   º   º   º   º   »   »   »   »   »   »   »   º   º   ¿   ¿   ¿   ¿   À   À   À   À   À   À   À   ¿   ¿   Ä   Ä   Ä   Å   Å   Å   Å   Æ   Æ   Æ   Æ   Ç   Ç   É   É   É   É   Ë   Ë   Ë   Ë   Ë   Ë   Ë   Î   Î   Å   Å   Ô   Ô   Ô   Ö   ×   ×   ×   ×   Ø   Ø   Ø   Ø   Ø   Ø   ×   ×   Û   Û   Û   Û   Ý   Ý   Ý   Ý   Þ   Þ   ß   ß   ß   ß   à   à   à   à   à   à   à   Û   Û   ä   $   self       entityArray      (for generator)   #   (for state)   #   (for control)   #   _   !   entity   !   (for generator)&   0   (for state)&   0   (for control)&   0   _'   .   entity'   .   (for generator)3   =   (for state)3   =   (for control)3   =   _4   ;   entity4   ;   
fightPets@      (for generator)C   Y   (for state)C   Y   (for control)C   Y   _D   W   petD   W   backpackPets\      ids]      (for generator)`   i   (for state)`   i   (for control)`   i   _a   g   peta   g   (for generator)l      (for state)l      (for control)l      _m   ~   idm   ~   petq   ~      _ENV ç   ñ    
   K    @ @@¤ Æ@   ä À ÂÀ$ PAJ@é  jAþf  &     _entityMngGetBuildingsipairsGetTemplateIDd                   è   é   é   é   ë   ë   ë   ë   ì   ì   í   î   ë   ë   ð   ñ   
   self       
buildList      
buildings      (for generator)      (for state)      (for control)      _      entity      id
      level         _ENV ô      &   G @ L@À d @ À  ¤ ÇÁ@ ÌÁFBA LÁÀ däA  ©  *ý@ À  ¤ ÌÁAäA ÌBä @Â ÇÁ@ ÌÁFB LÁÀ däA  ÌÁBäA ©  *û&     _entityMngGetBuildingsipairs_triggerMngNotifyLLNTBuildingTurnNewCostCountDownGetCountDown        LLNTCountDownResetCountDown         &   õ   õ   õ   ÷   ÷   ÷   ÷   ø   ø   ø   ø   ø   ø   ø   ÷   ÷   ü   ü   ü   ü   ý   ý   þ   þ   þ   þ                            ü   ü        self    &   
buildings   &   (for generator)      (for state)      (for control)      _      entity      (for generator)   %   (for state)   %   (for control)   %   _   #   entity   #      _ENV 	     
F   K    @ @@À  @ Á@$ ¤@   @ @@À  @ A$ ¤@  @A À  ¤ À	ÌAä ÂA B @ÇAB B$ Í
ÀÌAä ÂA ÂB @ÇC B$ Í
ÀÌAä ÂA BC  ÇC B$ Í
ÀÇAB ÂC$ Í
À©  *Aõ D AB ¤@@D C ¤@C 
 &     tableappendArray_entityMngGetFightPetsGetBuildingsipairsGetResTypeLuckLandCardResTypeMoney_roundGoldCalculateResHP_roundRecoverAttack
_roundAtkGetDirectGoldAddGoldAddHP_atk         F   
                                                                                                                                               self    F   prodEntityArray   F   (for generator)   =   (for state)   =   (for control)   =   _   ;   entity   ;      _ENV   A   9   G @ L@À d  @ @¤ ÆÀ@   ä À
Á$ "B  À	BÁ$ GA NB ÀÁ@ÂÃ ¤BBÂ ¤BB ÂBÀ¤ 
Â@ À ¤ÀÌCä âC  ÀÇCC ÌÃFÄC LÄÀ  d äC  ©  *CüÀ Â ¤B@ é  jAô&     _entityMngGetFightPetsGetFightMonstersipairsIsDead	GetCurHP_atk        	SetCurHPSetDeadmathabsHasDeleteFlag_triggerMngNotifyLLNTDefeatMonsterNew         9            "  "  "  #  #  #  #  $  $  $  $  %  %  '  '  (  (  )  )  )  *  *  *  ,  ,  ,  ,  ,  2  2  2  2  3  3  3  3  4  4  4  4  4  4  4  4  2  2  6  8  8  8  8  #  #  A     self    9   
fightPets   9   	monsters   9   (for generator)	   8   (for state)	   8   (for control)	   8   _
   6   monster
   6   curHP   6   	subValue   6   (for generator)"   1   (for state)"   1   (for control)"   1   _#   /   pet#   /      _ENV D     P   G @ L@À d @ À  ¤ ÇÁ@ ÌÁFBA LÁÀ däA  ©  *ý@ À  ¤ ÇÁ@ ÌÁFÂA LÁÀ däA  ©  *ý@ À  ¤ À
ÌBä âA  À	ÌABä  À ÌÁBäA  ÌCä BC !  C$BÂC $BBC Â
 @ D$ G@ LBÄË   @ ëB D dB CBC $B
ÂÂD  $B©  *Aô&     _entityMngGetFightMonstersipairs_triggerMngNotifyLLNTMonsterTurnStartNewLLNTMonsterTurnIsDeadGetDemandRound        DecreaseDemandRoundGetDemandMoney_goldDecreaseDemandMoneySetDeadGetNextMonstersSetFightMonsters
_curRound	ReduceHP                P   E  E  E  H  H  H  H  I  I  I  I  I  I  I  H  H  M  M  M  M  N  N  N  N  N  N  N  M  M  R  R  R  R  S  S  S  S  V  V  V  V  W  W  W  Y  Y  Z  Z  Z  [  [  [  \  \  \  ]  ]  ]  _  _  _  `  `  `  `  `  `  `  `  `  b  b  b  c  e  e  e  R  R       self    P   	monsters   P   (for generator)      (for state)      (for control)      _      entity      (for generator)      (for state)      (for control)      _      entity      (for generator)    O   (for state)    O   (for control)    O   _!   M   monster!   M   money.   M   nextMonster=   E      _ENV   ¡      G @ b@    &  F@@ GÀ À@ d@ F A L@Á d LÁ d b    ÀÁ ¤ 
&     _isRunningtableclear_drawCardResultLuckLandDataGetInstanceCurBuildingDatas
DrawCards                                                ¡     self       buildDataLevel         _ENV ¤  ¦       @ a   @    ¦  &     _gold           ¥  ¥  ¥  ¥  ¥  ¥  ¦     self       costVal            ¨  ª       @ @ 
 &     _gold           ©  ©  ©  ª     self       addVal            ¬  ³       @  @  @@ @ÁÀ  @ A  ¤@   ¦   @ @ 
   ¦  &     _goldLogfatal'[LuckLand] Gold is not enough, gold = 
, cost =             ­  ­  ­  ®  ®  ®  ®  ®  ®  ®  ¯  ¯  ±  ±  ±  ²  ²  ³     self       val          _ENV µ  ·      G @ f  &     _gold           ¶  ¶  ·     self            »  ½      G @ @@ f &     _curHP_maxHP           ¼  ¼  ¼  ½     self            À  Â       @ @ 
 &     _maxHP           Á  Á  Á  Â     self       addVal            Ä  É   
    @ @ 
  @ Ç@@  @ @@ 
 &     _curHP_maxHP        
   Å  Å  Å  Æ  Æ  Æ  Æ  Ç  Ç  É     self    
   addVal    
        Ë  Ó       @ @ 
  @  @@@ 
@@
À@ @ ¦  &     _curHP        _isRunning            Ì  Ì  Ì  Í  Í  Í  Î  Ï  Ò  Ò  Ó     self       val            Õ  Þ   
   G @ L@À d @ À  ¤ ÀÌÁ@FA GBÁäâ  @ Ã æ ©  *Aý   ¦  &     _entityMngGetBuildingsipairsGetTempValueLuckLandConstBVK_ExtraDrawCard            Ö  Ö  Ö  ×  ×  ×  ×  Ø  Ø  Ø  Ø  Ø  Ø  Ù  Ù  ×  ×  Ý  Ý  Þ     self       
buildings      (for generator)      (for state)      (for control)      _      	building         _ENV à  ê      Ç @ Ì@À@  ä@ Ì@ ä â    ÌÀ@ ä@ @ Ë   
À &     _entityMngSelectCardCheckHasExtraDrawCard	DrawCard_drawCardPool           á  á  á  á  á  ä  ä  ä  ä  å  å  å  è  è  ê     self       petTemplateID       pos            ì  ô   
   L @ d b    L@@ d@ @ K   
@ &     CheckHasExtraDrawCard	DrawCard_drawCardPool        
   î  î  î  î  ï  ï  ï  ò  ò  ô     self    
        ÷  ù      
@@&     _reDrawCount                   ø  ù     self            û  ÿ   
   G @ M@À @ ÇÀ@ Ì Á@  å  æ   &     _reDrawCount       
_curRound_configMngGetReDrawCost        
   ü  ü  ý  þ  þ  þ  þ  þ  þ  ÿ     self    
   reDrawCount   
   roundCount   
                L @ d b   @@@   ¤¢    @ À@
  A ¤@ &     GetReDrawCost	CostGold_reDrawCount       	DrawCard                                            self       reDrawCost           
     +    @ @@  ¤Ì@ä Á@ $"  @ A $AAA AÁA B  ¤$A  @ AB$ FB  dÂÂ¤ ¢B  BA AÃA B$¤B  i  êü&     _entityMngGetBuildingByIDGetUpgradeCost	CostGoldBuildingUpgrade_triggerMngNotifyLLNTBuildingUpgradeNewGetFightPetsipairsHasDeleteFlag         +                                                                                         
   self    +   buildingID    +   	building   +   costVal   +   
fightPets   *   (for generator)   *   (for state)   *   (for control)   *   _   (   pet   (      _ENV   "       @ @@ @ @ ¤@ &     LuckLandBuildingTypeMain	DrawCard                          "     self       
buildtype          _ENV $  &      G @ f  &     _delCardCount           %  %  &     self            (  +      G @ M@À @ À@  ¥ ¦   &     _delCardCount       _configMngGetDeleteCardCost           )  )  *  *  *  *  *  +     self       	delCount           -  4       @ ¤ ¢   ÀÌ@@ @ äâ   Ç@ ÍÀÀ
À Ç A Ì@Á@ ä@&     GetDeleteCardCost	CostGold_delCardCount       _entityMngDeleteCard           .  .  0  0  0  0  0  0  0  1  1  1  2  2  2  2  4     self       petID       delCost           8  :      G @ f  &     _drawCardResult           9  9  :     self            <  >      G @ @@ Ç@ f  &     _roundGold
_roundAtk_roundRecover           =  =  =  =  >     self            A  C      G @ @@ f &     
_curRound_gameRound           B  B  B  C     self            F  H      G @ f  &     	_posList           G  G  H     self            K  M      G @ f  &     _affixList           L  L  M     self            P        Ë     K  A@ À ¤ Æ@ ÇÂÀÇâ  À  K  ÇCÁÍÃkC 
CGÃÁ
CFB GCÂÀ dCGCÁA©  *ú À  ¨Á  ÆÂB ÇÃ @ ä \ (ÄAB ÀÀÄADC!  ÄA  'Cü¢  @  FC LÃÃd LÄd C@ À ¤ Æ@ ÇDÄ	Ç	â  ÀÄ	"  ÀÄ	B
 b  ÀÅÄ 	$"E  B EB
@  	$E B EB
@  	$E©  *øB CBÀE  À  $¤C  §ì  ÆA@  ä B CB@ CE E  @¤ $C  é  jý¦ &             pairsCfgcfg_luckland_client_card_poolwightWightcardsCardstableinsert       mathrandom       LuckLandDataGetInstanceCurCardDatascfg_luckland_client_card	IsUniqueContainPet_DrawCardInPoolUILuckLandCardDataNew            Q  R  S  U  U  U  U  V  V  V  W  W  X  Y  Y  Y  Y  Y  Y  Z  Z  [  [  [  [  [  \  \  U  U  _  _  _  _  `  a  a  a  a  a  b  b  b  b  c  c  c  c  c  c  c  c  c  c  d  d  d  b  h  h  j  l  l  l  l  l  m  m  m  m  n  n  n  o  o  p  p  p  p  p  p  q  q  q  q  q  q  q  r  r  r  r  r  s  u  u  u  u  u  m  m  y  y  y  y  y  y  y  y  y  _  }  ~  ~  ~  ~                    ~  ~      %   self       	poolList       count       
resultIDs      totalWight      wightArray      (for generator)      (for state)      (for control)      _      cardPoolID      cardPoolCfg
      t      (for index)!   o   (for limit)!   o   (for step)!   o   i"   n   cards#   n   randomWight(   n   (for index)+   :   (for limit)+   :   (for step)+   :   j,   9   
tempCards=   n   curCardDatasB   n   (for generator)E   e   (for state)E   e   (for control)E   e   _F   c   idF   c   cfgI   c   
tempTablep      (for generator)s      (for state)s      (for control)s      _t   }   cardIDt   }      _ENV      &     À À @ A@A  $A ,  K  Á@ À ¤@À   ä âB   ÆA ÇBÁ @ äB©  *Âü!ÁA BÁ ¤¦   ¦ &  	   LogfatalInsufficient card poolpairstableinsert       mathrandom                 E   b   @F À    d À  @  ¦ i  ê@þC   f  &     pairs                                               id       (for generator)      (for state)      (for control)      _      	filterID         
filterIDs_ENV&                                                                                  self    &   IDs    &   
filterIDs    &   count    &   contain   &   t	   &   (for generator)      (for state)      (for control)      _      ID         _ENV                        #      %   1   %   3   B   3   D   F   D   H   J   H   L   N   L   P   R   P   T   k   T   m   p   m   r   u   r   x      x               ª      ­   ä   ­   ç   ñ   ç   ô     ô   	    	    A    D    D    ¡    ¤  ¦  ¤  ¨  ª  ¨  ¬  ³  ¬  µ  ·  µ  »  ½  »  À  Â  À  Ä  É  Ä  Ë  Ó  Ë  Õ  Þ  Õ  à  ê  à  ì  ô  ì  ÷  ù  ÷  û  ÿ  û        
    
    "    $  &  $  (  +  (  -  4  -  8  :  8  <  >  <  A  C  A  F  H  F  K  M  K  P    P                 _ENV