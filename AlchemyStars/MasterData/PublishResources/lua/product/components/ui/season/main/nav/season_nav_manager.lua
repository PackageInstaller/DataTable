LuaS 

xV           (w@V@../PublishResources/lua/product/components/ui/season/main/nav/season_nav_manager.lua         4    @ A@  @ $@@@  @@ l   
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
@&     _classSeasonNavManagerObjectConstructorHasMoreAsland
SetPlayerSetAreaMaskGetAreaMaskClearAddTransPointFindOtherIslandPathFindBestTransPointFindTrasnsPathCheckTransPath	_CalCost_CalcCostByPathInitOffMeshLinkDataGetOffMeshLinkData                  K   
@ 
À
 Á
Á
 ÂK   
@K@  J Ã
@ &     _allNavTransPoint_useLineValueWhenNonePass _transCostBias{®Gáz?_navAreaMask       _player _offMeshLinksData_moreIslandSeasonF                       	   
                              self                       @ @ ¦  &     _moreIslandSeason                          self       	seasonId                      
@ &     _player                    self       player               %        @ _ À
@ @@ ¢   À @@ @  ¤@&     _navAreaMask_playerSetNavAreaMask                        !   !   !   "   "   "   "   %      self       mask            '   )       G @ f  &     _navAreaMask           (   (   )      self            +   .       K   
@ 
À&     _allNavTransPoint_navAreaMask                  ,   ,   -   .      self            0   3       Æ @ Ì@À@  ä @ Á@GA $A&     SeasonNavTransPointNewtableinsert_allNavTransPoint            1   1   1   1   1   2   2   2   2   2   3      self       zoneId       eventPoint       point         _ENV 5   :    
   
@@   @ ¤ 
@  @ ¤ 
A@ ÇÁ@ ¦&     
_areaMaskstartTransPointFindBestTransPointendTransPoint           6   7   7   7   7   7   8   8   8   8   8   9   9   9   :      self       
startZone       	startPos       endZone       endPos       	areaMask            <   L       Ä     FA@ @ dÀÂÀ¤ @ ÀA   LCÁd ¤  ¢B       @   À i  êAûæ  &     @B     pairs_allNavTransPoint
GetZoneID	_CalCostGetNavPositionè                  =   >   ?   ?   ?   ?   @   @   @   @   A   A   A   A   A   B   B   C   E   E   F   G   ?   ?   K   L      self       zoneId       pos       point      minCost      (for generator)      (for state)      (for control)      k      	subPoint      cost         _ENV P   ~    O   
À A@   @  &  D  Á@ AÆAA ¤ A¤ ÌÁA @ ä@ÌAB @  ä 
ÀÇB âA    &  
ÀB
ÀBÁA BCAB èA
ÇB@ ÇÃ$ "  ÀCC@ C (D@ ÄLCd b   C b  ÀÄÃ¤ ÌÄCä _À	  CD  C b  ÀD   @ À ¤D D   @ À ¤D 'Ã÷çõÇB C æ&     
_areaMask_allNavTransPoint       GameGlobalGetUIModuleSeasonModuleGetSeasonIDHasMoreAslandminCost	_CalCoststartTransPoint endTransPoint       	IsUnLock
GetZoneIDCheckTransPath         O   Q   R   R   S   S   T   V   W   W   W   W   W   W   X   X   X   X   ^   ^   ^   ^   ^   _   _   _   `   c   d   f   f   f   f   g   g   h   h   h   h   i   i   i   i   j   j   k   k   k   k   l   m   m   n   n   n   n   n   n   n   n   q   q   s   s   s   s   s   s   v   v   v   v   v   v   i   f   }   }   }   ~      self    O   originPostion    O   targetPosition    O   	areaMask    O   len   O   hasMoreIsland   O   	seasonId   O   (for index)   K   (for limit)   K   (for step)   K   i    J   firstPoint"   J   (for index))   J   (for limit))   J   (for step))   J   j*   I   secondPint,   I   
checkZone1   I      _ENV        $   L@d JÀÁ@   @¤ ¢A    &  ÌÀä @JÀÌÁ@ @ ä âA    &  ÂGA  @@FBA GÁÂ ÇA  @ dB
 

À &     GetPositiony        	_CalCostminCostLoginfo,seaonNav SeasonNavManager cost replace old  new startTransPointendTransPoint         $                                                                                                               	   self    $   
originPos    $   startTransPoint    $   endTransPoint    $   
targetPos    $   pos   $   c1   $   c2   $   sum   $      _ENV    ·    K   b   @ ¢@   Æ @ Ç@À  ä@ &  ÆÀ@ Ç ÁÇ@ÁÌÁä ÁA FÁ@ GÁGÂGAÂ À   @dÁ@ AAAA¤ ÆÁ@ ÇÁÇÂÇAÂ  @  À äbA  @âA  ÀB "  ÀÂÂ GÂÂ BGCCOB& &  B AB b  À C  ¤  â  À C   ¤@ ÂC DÀ  ¥¦  &     LogerrorSeasonNavManager:_CalCost UnityEngineAINavMeshPathNew
_areaMaskNavMeshCalculatePath_useLineValueWhenNonePassxz'      _CalcCostByPathmathmin         K                                                                                    ¢   ¢   ¢   ¢   ¢   £   £   £   £   £   £   £   £   £   ¤   ¤   ¤   ¤   ¥   ¥   ¥   §   §   §   §   §   §   §   ¨   ª   ­   ®   ¯   ¯   °   °   °   °   ²   ²   ³   ³   ³   ³   ¶   ¶   ¶   ¶   ¶   ¶   ·      self    K   originPostion    K   targetPosition    K   path1   K   mask   K   pass1   K   path2   K   pass2&   K   approxCost4   5   cost17   K   cost28   K      _ENV ¹   Ç        À Ç@@  A  ÁÀÁ hGAJÀÀÆA ÇÂÁ @ äÁgÁü& &     cornersLength                      yVector3	Distance            º   »   ¼   ½   ½   ½   ½   ¾   ¿   ¿   À   Á   Ä   Ä   Ä   Ä   Ä   Ä   ½   Æ   Ç      self       path       corners      len      cost      (for index)      (for limit)      (for step)      i      p1      p2
         _ENV É   Ó    
   K   
@ F@@ GÀ À@ d L Á d @A AË@  Ê@¤ ¢@    &  Æ B   ä  @ GBÂ
Âé  jþ&  
   _offMeshLinksDataGameGlobalGetUIModuleSeasonModuleGetSeasonIDCfgcfg_season_map_nav_link	SeasonIDpairsName            Ê   Ê   Ë   Ë   Ë   Ë   Ë   Ë   Ì   Ì   Ì   Ì   Ì   Í   Í   Î   Ð   Ð   Ð   Ð   Ñ   Ñ   Ñ   Ð   Ð   Ó      self       	seasonId      cfgs      (for generator)      (for state)      (for control)      _      cfg         _ENV Õ   ×        @ @ ¦  &     _offMeshLinksData           Ö   Ö   Ö   ×      self       name           4                                                   %      '   )   '   +   .   +   0   3   0   5   :   5   <   L   <   P   ~   P               ·      ¹   Ç   ¹   É   Ó   É   Õ   ×   Õ   ×          _ENV