LuaS 

xV           (w@@E:/depot_matchsrpg/matchsrpg/b/1120/client/Assets/../PublishResources/lua/framework/core/core_game/world_pack_combat/components/attributes_component.lua         F    @ A@  @ $@@@  @@ l   
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
@ ÀD l  
@ ÀD l@ 
@ÀD l 
@ ÀD lÀ 
@ÀD l  
@ &     _classAttributesComponentObjectConstructorSetAttributeSetSimpleAttributeRemoveSimpleAttributeGetAttributeModifierGetAttributeModifyRemoveModifyClearModifyCloneAttributesSetModifierDic
CalcMaxHpGetDefence
GetAttackGetCurrentHPGetAIMobilityEntityAttributesHasAttributesAddAttributesRemoveAttributesReplaceAttributes           
       K   
@ &     modifierDic           	   	   
      self                      Ç @ Ê &     modifierDic                       self       	attrName       	modifier                      Ç @ A@ @ $Ê  &     modifierDicIModifyValueNew                                    self       	attrName       value          _ENV            @ @À &     modifierDic                        self       	attrName                       @ @ ¦  &     modifierDic                          self       	attrName               $        @ @ ¢    Ì@@å  æ   &     modifierDicValue                   !   !   "   "   "   $      self       	attrName       	modifier           &   -       G@ GAbA  @A@ @ÁÁ    ¤A&  Á  @ ¤A&     modifierDicLog
exception Modify attribute not configed! 
AddModify            '   '   (   (   )   )   )   )   )   *   ,   ,   ,   ,   ,   -      self       	attrName       	newValue       	modifyID       option       	modifier         _ENV /   4       Ç @ Ç@â    AÀ $A&     modifierDicRemoveModify           0   0   1   1   2   2   2   4      self       	attrName       	modifyID       	modifier           6   ;        @ @ ¢   @ Ì@@ä@ &     modifierDicClearModify           7   7   8   8   9   9   ;      self       	attrName       	modifier           =   D       K    @ Ç@@ ¤ Æ@   FÂ@ AGäJÀ©  *ýf  &     pairsmodifierDicsetmetatableClasses_className            >   ?   ?   ?   ?   @   @   @   @   @   @   A   ?   ?   C   D      self       attributsList      (for generator)      (for state)      (for control)      key      value      	modifier         _ENV F   H       
@ &     modifierDic           G   H      self       attributsList            L   V       L @ Á@  db@    A   @ Á  ¤Ì @ A ä  _@A _@Á MÁ OA FÁA GÂ e f  &  	   GetAttributeMaxHP        MaxHPConstantFixMaxHPPercentage        mathceil            M   M   M   M   M   M   N   N   N   O   O   O   P   Q   Q   Q   Q   R   R   R   U   U   U   U   U   V      self       
baseMaxHp      maxHpConstantFix	      maxHpPercentage      result         _ENV X   e       L @ Á@  d @   ¤¢@    À  Ì @ A äâ@    ÁÀ  Á  FA GÁÁ e f  &     GetAttributeDefenseDefenceConstantFix        DefencePercentage       mathceil            Y   Y   Y   Z   Z   Z   [   [   \   _   _   _   `   `   a   c   c   c   d   d   d   d   d   e      self       baseDefence      defenceConstantFix      defencePercentage      defence         _ENV g   x       L @ Á@  db@  @   ¦   @ Á  ¤¢@      Ì @ A äâ@    Á  Á  FA GÁÁ e f  &     GetAttributeAttack        AttackConstantFixAttackPercentage       mathceil            h   h   h   i   i   j   j   m   m   m   n   n   o   r   r   r   s   s   t   v   v   v   w   w   w   w   w   x      self       baseAttack      attackConstantFix
      attackPercentage      atk         _ENV z   }       L @ Á@  df  &     GetAttributeHP           {   {   {   |   }      self       baseHP                     L @ Á@  d @   ¤ÆÀ@ Ç Á  @ äÁ@ AA@% &  &     GetAttribute	MobilityMaxMobilitymathminceil                                                                  self       baseAIM      maxAIM      ret         _ENV           L @ Ç@@ ÇÀe f   &     GetComponentWEComponentsEnumAttributes                                self                      L @ Ç@@ ÇÀe f   &     HasComponentWEComponentsEnumAttributes                                self                   
   G @ G@À @ À@¤ Ì A @  ä@ &     WEComponentsEnumAttributesAttributesComponentNewAddComponent         
                                    self    
   index   
   
component   
      _ENV        	   L @ d b   À L@@ Ç@ ÇÀÀd@&     HasAttributesRemoveComponentWEComponentsEnumAttributes        	                                 self    	            ¢        @ A@ @@ ¤@ &     ReplaceComponentWEComponentsEnumAttributes           ¡   ¡   ¡   ¡   ¡   ¢      self       
component           F                        
                                             $      &   -   &   /   4   /   6   ;   6   =   D   =   F   H   F   L   V   L   X   e   X   g   x   g   z   }   z                                                    ¢       ¢          _ENV