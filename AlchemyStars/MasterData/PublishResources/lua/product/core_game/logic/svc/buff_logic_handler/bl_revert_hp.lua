LuaS 

xV           (w@@E:/depot_matchsrpg/matchsrpg/b/150/client/Assets/../PublishResources/lua/product/core_game/logic/svc/buff_logic_handler/bl_revert_hp.lua             @ A@  $@ @ Aΐ   A $@ΐ@  ΐ@ l   
@@ A  A $@A   A l@  
@A l  
@A lΐ  
@ &  	   requirebuff_logic_base_classBuffLogicSaveRevertHPBuffLogicBaseDoLogicBuffLogicDoRevertHP_LogicRecover_LogicDamage                   @ € @@€ @€ Μΐ@ δ Μ ΑAA  δ@ ΖA ΜΐΑ@ ε ζ   &     
GetEntityAttributesGetCurrentHPGetBuffComponentSetBuffValueSaveRevertHPBuffResultSaveRevertHPNew                              	   	   	   	   	   	                        self       notify       
currentHP         _ENV    (    
/    @ € @@  €’@  @Ζΐ@ Η ΑAA A δ@&  ΜΐA δ Μ Βδ Μ@Βδ B ΑB $D   @AC   @€ @  C   @€ @ B ΑB €ΖΑC ΜΔ@εζ  &     GetBuffComponentGetBuffValueSaveRevertHPLogerror_classNameRun SaveRevertHP before this! 
GetEntityAttributesGetCurrentHP_worldGetServiceCalcDamage_LogicRecover_LogicDamageBuffResultDoRevertHPNew         /                                                                                                                       $   $   $   $   '   '   '   '   '   (      self    /   notify    /   savedHP   /   
currentHP   /   dmgsvc   /   damageInfo   /   calcDamage)   /      _ENV *   2    	   Ζ @ Μ@ΐN @ Α@δ A AA $LΑAΜB δ ΜAΒδ  dA ζ  &  
   DamageInfoNewDamageTypeRecover_worldGetServiceCalcDamageAddTargetHP
GetEntityGetID            +   +   +   +   +   +   .   .   .   .   /   /   /   /   /   /   /   1   2      self       savedHP       
currentHP       damageInfo      dmgsvc
         _ENV 4   <    
   Ζ @ Μ@ΐNA @ Α@δ A AA $LΑAΜB δ B $ @dAζ  &  	   DamageInfoNewDamageTypeReal_worldGetServiceCalcDamage_DoDamageModifyHP
GetEntity            5   5   5   5   5   5   8   8   8   8   9   9   9   9   9   9   9   ;   <      self       savedHP       
currentHP       damageInfo      dmgsvc
         _ENV                                                            (      *   2   *   4   <   4   <          _ENV