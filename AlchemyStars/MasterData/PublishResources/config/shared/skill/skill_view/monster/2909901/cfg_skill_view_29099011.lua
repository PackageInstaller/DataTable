LuaS 

xV           (w@`@../PublishResources/config/shared/skill/skill_view/monster/2909901/cfg_skill_view_29099011.lua            Ŕ 
@@
Ŕ@
@A
ŔA
@B
ŔB
@CK   Á@  A  A A  Á  K Â kB Ť@k@   Á      Ś  &     ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               ˙ń       DataSelectDamage,damageIndex = 1; PlayCasterAnimation,animName = Skill01; PlayAudio,audioID=29099015,audioType=1; PlayCasterBindEffect,effectID= 290990106; PlayCasterBindEffect,effectID= 290990108; PlayCasterMaterialAnim,animName=effanim_2909901_skill02_mat; Wait,waitTime=1150; DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=1; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=290990107,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=200; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; Wait,waitTime=1000;                                                                                             key      config         _ENV