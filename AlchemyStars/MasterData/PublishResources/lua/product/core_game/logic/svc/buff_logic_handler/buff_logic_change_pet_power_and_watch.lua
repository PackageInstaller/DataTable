LuaS 

xV           (w@r@../PublishResources/lua/product/core_game/logic/svc/buff_logic_handler/buff_logic_change_pet_power_and_watch.lua             @ A@  @ $@@@  @@ l   
@@@ l@  
@ @@ l  
@&     _class BuffLogicChangePetPowerAndWatchBuffLogicBaseConstructorDoLogic_OnChangePetPower        	          Η@@β@    Α  
ΐ &     
_addValue	addValue                   
   
   
   
   
         self       buffInstance       logicParam                      K    @ @@€ Η @ Μΐδ β@    &  Α@ ΐ $A A @ $ "   AA A $& &     _buffInstanceWorldEntity_OnChangePetPowernext!BuffResultChangePetPowerAndWatchNew                                                                                          self       petPowerStateList      world      
petEntity      buffResult         _ENV !   y    ¨   Μ ΐ δ Aΐ$ Lΐ d Αΐ €!@A@ Γ  ζ ΗA ΞΑ  C  ΒA BC €ΗΒA ΜΒδ ΓΒ $LΓd   ΜCΓ δ ΜΓδ β  ΐ   DΓ $ ΔC$ LΔΐ  d b  @DD D	ΐ€  ΐDD ΔD	ΐ  €’      ΔΒ $LΓd "   @   ’   E DE$ A Δ ΖF  δ E FF F d ]DΔF € G	ΗA ΞDΗ	ΞΑΜG@ δD ΜΔΗ@   δD !@Α@ΑA H ΑD $D  DH H $GΔA LΒΑΔ dLΙΐ dDC ΔA DI$ IΔ  ΚΜΚ δ ΔΔ$D"D  @    LΚ d 
D

Δ

DL D ΜΚ δ  @$D ΔΜ ΐ$D  & &  4   	PetPstID	GetPstIDAttributesGetAttributePower        
_addValue_worldGetService
BuffLogicBattleStatGetLastDoActiveSkillRoundGetLevelTotalRoundCount
SkillInfoGetExtraActiveSkillIDListGetActiveSkillIDGetPetDoActiveSkillRecordtablecount
icontains_entityBuffComponentHadSaveSkillGrayWatch_Round_	tostring_Skill_activeSkillIDGetBuffValue        SetBuffValueSetLastDoActiveSkillRoundChangePetActiveSkillReadyNTPowerReadyNewTriggerNotifyGetSyncLoggerTracekey BuffLogicChangePetPowerAndWatchpetEntityIDGetID	newPower	petPstIDpowerreadyrequireNTPowerReadyPrintBuffLogicLogChangePetPower() pet entity= power=Modify         ¨   "   "   #   #   &   &   '   '   '   (   (   )   )   ,   ,   .   /   2   2   2   2   5   5   5   6   6   6   7   7   :   <   <   <   <   =   =   =   =   =   >   >   >   >   @   @   @   @   A   A   A   A   A   A   A   A   B   B   B   B   B   B   B   C   E   H   I   I   I   J   J   K   K   K   K   L   Q   Q   S   S   S   T   T   T   T   T   T   T   T   T   T   U   U   U   W   W   X   X   X   Y   Y   Y   Y   Z   Z   Z   Z   _   _   `   a   a   a   a   b   d   d   d   d   e   e   e   e   e   e   e   f   i   i   i   i   i   j   j   j   j   j   i   m   m   m   n   n   p   p   p   p   q   q   r   r   s   s   t   t   u   u   u   u   u   u   u   v   v   v   v   x   x   y      self    ¨   
petEntity    ¨   petPowerStateList    ¨   petPstIDComponent   ¨   	petPstID   ¨   curAttributeCmpt   ¨   	curPower	   ¨   	newPower   ¨   ready   ¨   requireNTPowerReady   ¨   blsvc   ¨   battleStatComponent   ¨   lastDoActiveSkillRound   ¨   	curRound   ¨   curRoundHadCastTargetSkill   ¨   extraSkillIDList"   ¨   activeSkillID+   ?   curRoundHadCastSkillList/   ?   lastDoActiveSkillRoundD   K   	curRoundF   K   buffComponentP   j   keyStrZ   j   hadSaveSkillGrayWatch]   j   notifyv   ~      _ENV                     	      	            !   y   !   y          _ENV