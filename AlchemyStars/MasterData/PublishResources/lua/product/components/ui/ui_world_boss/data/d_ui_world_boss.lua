LuaS 

xV           (w@V@../PublishResources/lua/product/components/ui/ui_world_boss/data/d_ui_world_boss.lua         (    @ A@  @ $@@@  @@ l   
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
@&     _classDUIWorldBossDanDetailCellObjectConstructor	GetDanIdGetDanRankLevelGetDanCondition_FormatNeedDamageNumStrGetDanExtraInfoGetDanBadgeBaseGetDanRewardsGetDanName
IsPlusDanIsPlayerCurDanData               
   
@ 

À@Ç @ â    Ç @ Ç Á
À &     _danCfg	_danInfo_danIdÿÿÿÿÿÿÿÿID        
   	                                 self    
   cfg    
   danInfo    
                  G @ f  &     _danId                       self                      G @ b    G @ G@À f  &     _danCfg
RankLevel                                   self            !   ,       G @ b   G @ G@À  @ @FÀ@ G Á @A AÁ  dÀA  BÁ@ ÁA B@ $ G@ GAÀ¤ ¦   LB Ç @ ÇÀÂdf  &     _danCfg
RankLevel        UIWorldBossHelperGetDanName_danId       StringTableGet,str_world_boss_dan_detail_lengend_condition_FormatNeedDamageNumStrNeedDamage            "   "   "   #   #   #   #   $   $   $   $   $   $   %   %   %   %   %   %   %   %   %   %   &   &   (   (   (   (   )   ,      self       topDanName      outStr      outStr         _ENV -   1        @ @@Á    ¤ÆÀ@ Ç ÁA @ A À ¤ ä  æ  &     UIActivityHelperGetZeroStrFrontNum       stringformat3<color=#696969>%s</color><color=#e7d3ac>%s</color>	tostring            .   .   .   .   .   /   /   /   /   /   /   /   /   0   1      self       num       preZero      fmtStr         _ENV 4   >       G @ b   @G @ G@À  @ @GÀ@ b   GÀ@ G Á  @ F@A GÁ À ÇÀ@ Ç Áe f   &     _danCfg
RankLevel        	_danInforank_first_damageStringTableGet(str_world_boss_dan_detail_top_one_score            5   5   5   6   6   6   6   7   7   7   8   8   8   8   9   9   9   9   9   9   9   >      self          _ENV A   E       G @ b    G @ G@À f  &     _danCfgDanBadgeBase           B   B   B   C   C   C   E      self            H   W       G @ b   ÀG @ G@À b   À   Æ@   ä ÀÂ@ A$ GÁ
BGÂ
BFBB GÂ À dBé  jAü¦  &     _danCfgRewardsipairs
RoleAssetNewassetid       count       tableinsert            I   I   I   J   J   K   K   L   M   M   M   M   O   O   O   P   P   Q   Q   R   R   R   R   R   M   M   T   W   	   self       
rewardVec      roleAssetList      (for generator)      (for state)      (for control)      index      value      asset         _ENV [   _       G @ b    G @ G@À f  &     _danCfgDanName           \   \   \   ]   ]   ]   _      self            `   j       C    @ ¢     @ @@¢     @ @@@  C  f  &     _danCfg
IsPlusDan                  a   b   b   b   c   c   c   c   d   d   d   d   e   i   j      self       bPlus           n   |    &   G @ G@À  @ @ÆÀ@ Ç Á  @ äâ   @ Ã   æ   @ÇA ÇÀÁ À@ Ã  æ  @AÀÇA ÇÀÁ@ÁÀÇA Ç Â_À   Ã@  Ã  æ  @ Ã   æ  &  	   	_danInfocur_danmy_rankUIWorldBossHelperIsNoDan        _danCfg
RankLevelID         &   o   o   p   p   q   q   q   q   q   q   q   r   r   t   t   t   t   t   t   u   u   w   w   w   w   w   w   x   x   x   x   x   x   x   x   z   z   |      self    &   curDan   &   curRank   &      _ENV(                                                !   ,   !   -   1   -   4   >   4   A   E   A   H   W   H   [   _   [   `   j   `   n   |   n   |          _ENV