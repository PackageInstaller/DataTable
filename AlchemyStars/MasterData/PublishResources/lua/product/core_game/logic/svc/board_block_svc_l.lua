LuaS 

xV           (w@K@../PublishResources/lua/product/core_game/logic/svc/board_block_svc_l.lua         +    @ A@  $@ @ l   
@@ l@  
@ @ l  
@@ lÀ  
@ @ l  
@@ l@ 
@ @ l 
@@ lÀ 
@ @ l  
@@ l@ 
@ @ l 
@@ lÀ 
@ @ l  
@&     requireboard_svc_lBoardServiceLogicIsPosBlockByAreaIsPosBlockFindBlockByPosGetBlockFlagByBlockIdIsPosExistNegtiveBlockRemoveEntityBlockFlagRemovePosBlockUpdateEntityBlockFlagSetEntityBlockFlagSetPosBlockGetBlockFlagGetPosListByFlagIsMonsterPosBlock               1   G@ LAÀÁ  d  ÁÁ  AÂ  èÁÇÍÂ ÁÀ $ "  À"A  @  & CÁ$"  @ _ @ C f LÁÀd_ÀAB CBÀ  ¤¢  @  ¦ çöÃ  æ &  
   _worldGetService	UtilData       IsPosBlockGetMonsterAtPosGetTrapsAtPos        table
icontains         1                                    	   	   	   	   	   	   
   
                                                                                                self    1   pos    1   
blockFlag    1   	listArea    1   entityExcept    1   utilDataSvc   1   ret   1   (for index)   .   (for limit)   .   (for step)   .   i	   -   posWork   -   entityMonster   -   entityTrap!   -      _ENV    0       b@  @ Ã   æ  Ç @ Ì@ÀA  äÁÀ $"A  @  & ¢@  @   & A  $ @ C f LAÀ ef  &     _worldGetService	UtilDataIsValidPiecePosFindBlockByPos CheckBlock                         #   #   #   #   $   $   $   $   $   %   %   '   '   (   (   +   +   +   ,   ,   -   -   /   /   /   /   0      self       pos       
blockFlag       	utilData      pieceBlock           3   8    
    @ @@¤ Ì@ä ÁÀ %&  &     _worldGetBoardEntityBoardFindBlockByPos        
   4   4   4   6   6   7   7   7   7   8      self    
   pos    
   boardEntity   
   
cmptBoard   
        ;   O    )    @ ¢   À @ @ ¢   @ @ @ ¦  @    
 @@ @@ ¢   ÁÀ  A GAA$À FA  d Õ@)  ªAþ@ 
Á æ   ÆÀA Ç ÂA @ ä@ÁÀ  æ  &  
   _blockDictCfg
cfg_block        ipairs
BlockFlagGetBlockFlagByValueLogfatal'### no block id in cfg_block. blockId=         )   <   <   <   =   =   =   =   >   >   >   ?   A   A   C   C   C   D   D   E   F   F   F   F   G   G   G   G   F   F   I   I   J   J   L   L   L   L   L   N   N   O   	   self    )   blockId    )   cfgv   )   b       (for generator)      (for state)      (for control)      _      value         _ENV Q   T        @   ¤Ì@@å  æ   &     FindBlockByPosIsExistNegative           R   R   R   S   S   S   T      self       pos       block           X   b       Ì À ä â    Ì@À ä ÌÀä @ ÌÀÀ ä Ì Áä AA  $FA d ÂA   MC ¤Bi  êþ@ f&     HasPetPstIDPetGetOwnerTeamEntity	BodyAreaGetAreaGetBlockFlagipairsRemovePosBlock            Y   Y   Y   Y   Z   Z   Z   Z   Z   \   \   \   \   ]   ]   ]   ^   ^   ^   ^   _   _   _   _   _   ^   ^   a   a   a   b   
   self       e       posOld       	bodyArea      
blockFlag      (for generator)      (for state)      (for control)      _      area         _ENV f   y    (   @ A@  $LÁ@À dbA    &  LA À d@  &  Á ¤ ¢   ÁÁ ¤ B¤ @  AÂÂ $ @¤A @ ÁB¤ C¤ ÌAC@  äA &     _worldGetService	UtilDataIsValidPiecePosFindBlockByPos HasPetPstIDPetGetOwnerTeamEntity	DelBlockGetIDGetBoardEntityBoardRemovePieceEntity        (   h   h   h   h   i   i   i   i   i   j   m   m   m   n   n   o   r   r   r   r   s   s   s   s   s   v   v   v   v   v   w   w   w   w   w   x   x   x   x   y      self    (   e    (   pos    (   
blockFlag    (   	utilData   (   pieceBlock   (   
boardCmpt#   (        ~          À $ "   AÀ $ @$ @  Á@  À $Á A À ¤ ÌBA @ ÀäB©  *þ&     HasPetPstIDPetGetOwnerTeamEntityRemoveEntityBlockFlagipairsSetPosBlock                                                                                          self       e       posOld       posNew       	bodyArea      
blockFlag      (for generator)      (for state)      (for control)      _      area         _ENV           À $ "   AÀ $ @$ @  ÁÀ $ A$ FAA  d A   MC¤Bi  êþ&     HasPetPstIDPetGetOwnerTeamEntity	BodyAreaGetAreaipairsSetPosBlock                                                                                       
   self       e       pos       
blockFlag       	bodyArea      (for generator)      (for state)      (for control)      _      area         _ENV    ¨    %   @ A@  $LÁ@À dbA    &  G@ LÁd LAÁd Á  @ ¤A ÁA   ¤ B  &  â@  À ÌAB @ äÀ ÌBLÂÂ d äA &     _worldGetService	UtilDataIsValidPiecePosGetBoardEntityBoardAddPieceEntityFindBlockByPos GetBlockFlag	AddBlockGetID        %                                                            ¢   ¢   ¢   £   £   ¤   ¦   ¦   ¦   ¦   ¦   ¦   §   §   §   §   §   ¨      self    %   entity    %   pos    %   
blockFlag    %   	utilData   %   
boardCmpt   %   pieceBlock   %        «   Ã    S    À ¤ ¢   À@À ¤ @¤ ÇÀ@ Ì Á@ äâ   À AA %&  A ÁAA AÂ ¤ ¢   AÂ ¤ BÀ $A Á &  Ã ¤ ¢   À@Ã ¤ @¤ ÇÀ@ Ì Á@ äâ   À AA %&  A ÁAA AÂ ¤ ¢   AÂ ¤ BÀ $A Á & ÀÃ ¤ ¢     Ä ¤ @A¥  ¦   A ÀAÁ@ Ä $ ÁD¤@À ¦  &     	HasGhostGhostGetOwnerID_worldGetEntityByIDGetBlockFlagLogfatal### Ghost has not owner.GridLocation	Position        HasGuideGhostGuideGhost### Guide Ghost has not owner.HasBlockFlag
BlockFlag+### RemoveEntityBlockFlag new entity type.EntityTypeValue         S   ¬   ¬   ¬   ¬   ­   ­   ­   ­   ®   ®   ®   ®   ¯   ¯   °   °   °   °   ²   ²   ²   ²   ²   ²   ²   ²   ²   ²   ²   ²   ³   ³   µ   µ   µ   µ   ¶   ¶   ¶   ¶   ·   ·   ·   ·   ¸   ¸   ¹   ¹   ¹   ¹   »   »   »   »   »   »   »   »   »   »   »   »   ¼   ¼   ¾   ¾   ¾   ¾   ¿   ¿   ¿   ¿   ¿   Á   Á   Á   Á   Á   Á   Á   Â   Â   Ã      self    S   e    S   ownerId       eOwner       ownerId(   @   eOwner,   @      _ENV Ç   Ì    
    @ @@¤ Ì@ä ÁÀ %&  &     _worldGetBoardEntityBoardGetPosListByFlag        
   È   È   È   Ê   Ê   Ë   Ë   Ë   Ë   Ì      self    
   
blockFlag    
   boardEntity   
   cBoard   
        Ï   ×       b   À À $ "A  @   & AÀ $ L@d Á@   @¥¦  &     GetID	BodyAreaGetAreaIsPosBlockByArea           Ð   Ð   Ð   Ð   Ð   Ð   Ñ   Ñ   Ô   Ô   Õ   Õ   Ö   Ö   Ö   Ö   Ö   Ö   ×      self       monsterEntity       newPos       
blockFlag       	areaCmpt
      	areaList          +                        0      3   8   3   ;   O   ;   Q   T   Q   X   b   X   f   y   f   ~      ~               ¨      «   Ã   «   Ç   Ì   Ç   Ï   ×   Ï   ×          _ENV