LuaS 

xV           (w@X@../PublishResources/lua/product/core_game/logic/svc/buff_logic_handler/bl_curse_hp.lua         ;    @ A@  $@ @ Aภ   A $@ภ@  ภ@ l   
@@ A  A $@A   A l@  
@  
 ย
ย
 ร
รFภC   ภ   d@F@ @ ฦ A d@F@D @F@D ฌ  J Aภ @D ์ภ  ภ@D ์  ภ @ ม@ A ค@@E @E ์@ ภ @E ์ ภ&     requirebuff_logic_base_classBuffLogicEnableCurseHPChargeBuffLogicBaseDoLogicBuffLogicDisableCurseHPChargeCasterMaxHP       OwnerMaxHP       CasterAttack       OwnerAttack       _enumChargeCurseHpPercentSourceTypeBuffLogicChargeCurseHPConstructorBuffLogicChargeCurseHP: _CalcSourceParamValue!BuffLogicSetTransDamageToCurseHp           '    	3    @ ค ฬ@@ไ โ    ฬ@ไ  ฬภ@ไ โ   ฬ Aไ Aม$ "    &  ฬAไ มม$ "    &  ย $AAB B$ "  @AB B$ มB"A      "  ภ LรฬACไ dA  K  f &     
GetEntityHasSuperEntityGetSuperEntityHasMonsterID
MonsterIDIsWorldBossBuffComponentIsCurseHPEnabledSetCurseHPEnable_buffInstanceContextcasterEntitySetCurseHPSourceEntityIDGetID        3                                                                                    !   !   !   "   "   "   "   "   "   "   "   "   "   "   "   #   #   $   $   $   $   &   &   '      self    3   _    3   e   3   monsterIDCmpt      cBuff   3   casterEntity*   3        .   8        @ ค ฬ@@ไ โ    ฬ@ไ  ฬภ@ไ ม  $AAม$A   & &     
GetEntityHasSuperEntityGetSuperEntityBuffComponentSetCurseHPEnableClearCurseHPValue           /   /   0   0   0   0   1   1   1   4   4   5   5   5   6   6   7   7   8      self       _       e      cBuff           G   S       ว@@
ภ วภ@
ภ ว@A
ภ วภA
ภ ว@B
ภ วภB
ภ 
@CวCโ   ภ วCภร  
 DวDโ@  @ ฦภD ว ล
ภ&     _basePercentbasePercent_basePercentSourceTypebasePercentSourceType_extraPercentextraPercent_extraPercentSourceTypeextraPercentSourceType_extraMinPercentextraMinPercent_extraMinPercentSourceTypeextraMinPercentSourceType_showDamage showDamage       _showDamageElementTypeshowDamageElementTypeElementTypeElementType_None            H   H   I   I   J   J   K   K   L   L   M   M   N   O   O   O   O   O   O   P   R   R   R   R   R   R   S      self       _       logicParam          _ENV W       p    @ ค ฬ@@ไ โ    ฬ@ไ  ฬภ@ไ โ   ฬ Aไ Aม$ "    &  ภ  A$ "  @มA$ B$   ภ  AB B$ มBA  ม  A  ฬBC GC  ภ ไ@ฬBC GรC  ภ ไฬBC GD  ภ ไภวBD โ  ภฦD วยฤE GCD $ ไ  วBE โ  ภฦD วยฤE GCE $ ไ @วE โ  ภฦD วยฤE GE $ ไ    @ อBรE Fภ$ FCF Lฦฬรฦไ   @G วDG df &     
GetEntityHasSuperEntityGetSuperEntityHasMonsterID
MonsterIDIsWorldBossHasPetPetGetOwnerTeamEntity_buffInstanceContextcasterEntity        _CalcSourceParamValue_basePercentSourceType_extraPercentSourceType_extraMinPercentSourceType_basePercentmathceil	tonumber_extraPercent_extraMinPercent_buffLogicServiceChangeCurseHPBuffResultChargeCurseHPNewGetID_showDamage_showDamageElementType         p   X   X   Y   Y   Y   Y   Z   Z   Z   ]   ]   ]   ]   _   _   `   `   `   `   a   e   f   f   f   f   g   g   g   g   h   i   k   k   k   k   l   m   n   o   p   q   r   r   r   r   r   r   s   s   s   s   s   s   t   t   t   t   t   t   u   u   u   v   v   v   v   v   v   v   v   x   x   x   y   y   y   y   y   y   y   y   {   {   {   |   |   |   |   |   |   |   |   ~   ~                                                            self    p   notify    p   entity   p   monsterIDCmpt      buffResultEntity   p   eTeam      casterEntity#   p   basePercentParamValue$   p   extraPercentParamValue%   p   extraMinPercentParamValue&   p   
baseValue'   p   extraValue(   p   extraMinValue)   p   val`   p   currentVale   p   resultn   p      _ENV        ,     b   	FA@ @ ภโ   @Lภd Lมภd  ภFA @ @L@d Lมภd  FAA @ ภโ   @Lภd Lมd  ภFมA @  L@d Lมd  & &             CasterMaxHPAttributes
CalcMaxHpOwnerMaxHPCasterAttack
GetAttackOwnerAttack        ,                                                                                                                                          self    ,   sourceType    ,   ownerEntity    ,   casterEntity    ,   value   ,      ChargeCurseHpPercentSourceType ก   ค    
   ว@@โ@    ม  
ภ ฦ A AAไ 
ภ&     _setisSet       _transPercent	tonumbertransPercent         
   ข   ข   ข   ข   ข   ฃ   ฃ   ฃ   ฃ   ค      self    
   _    
   logicParam    
      _ENV ฅ   ด    	    @ ค ฬ@@ไ โ    ฬ@ไ  ฬภ@ไ โ     GAA ม Lมมภ B dA ภ Lมมภ   dA &  	   
GetEntityHasSuperEntityGetSuperEntityBuffComponentTransDamageToCurseHp_set       SetBuffValue_transPercent           ฆ   ฆ   ง   ง   ง   ง   จ   จ   จ   ซ   ซ   ฌ   ฌ   ญ   ฎ   ฎ   ฎ   ฏ   ฏ   ฏ   ฏ   ฏ   ฑ   ฑ   ฑ   ฑ   ด      self       _       e      cBuff      key          ;            	   	   	   	            '      )   )   )   )   +   +   .   8   .   ;   <   =   >   ?   A   A   A   A   C   C   C   C   E   E   G   S   G   U   W      W                              ก   ค   ก   ฅ   ด   ฅ   ด      ChargeCurseHpPercentSourceType   ;   BuffLogicChargeCurseHPTag(   ;      _ENV