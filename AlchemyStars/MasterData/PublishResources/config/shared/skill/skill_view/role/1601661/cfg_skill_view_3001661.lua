LuaS 

xV           (w@@E:/depot_matchsrpg/matchsrpg/b/1110/client/Assets/../PublishResources/config/shared/skill/skill_view/role/1601661/cfg_skill_view_3001661.lua         1     
@@
Ą@
@A
ĄA
@B
ĄB
@C
ĄCK  Į@  A  A A  Į  K B kB «@Ė Į  AĮ   ĮĮ  B  A  Į «B ė@AA A Į Ā  AB   Ė Ć ėB +Ak@  Į      ¦  &     ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam       PhasePosDir                PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_red.prefab,petID = 1500551,waitTime = 2000; ’’       DataSelectResult,effectType=169,index=1; Jump,condition=CheckEffectResultIndex,param=169,goto=phaseEnd; DataSelectResult,effectType=5,index=1; Jump,condition=CheckEffectResultIndex,param=5,goto=phaseEnd; DataSelectResult,effectType=11,index=1; PlayTurnToPickUpPosDirection,pickUpIndex=1; PlayCasterAnimation,animName = AtkUlt; PlayAudio,audioID = 2426,audioType=1; PlayCasterBindEffect,effectID=3858; PlayCasterBindEffect,effectID=3859; Wait,waitTime=1100; PlaySummonTrap,trapID=16016611; Wait,waitTime=1000; ’       DataSelectResult,effectType=11,index=1; Jump,condition=CheckEffectResultIndex,param=11,goto=phaseEnd; PlayTurnToPickUpPosDirection,pickUpIndex=1; PlayCasterAnimation,animName = AtkUlt; PlayAudio,audioID = 2426,audioType=1; PlayCasterBindEffect,effectID=3858; PlayCasterBindEffect,effectID=3859; Wait,waitTime=1300; PlayEffectAtPickUpGridByTrapBuffLayer, effectIDList=3861|3861|3861|3861, effectScaleList=0.45|0.45|0.65|1, trapIDList=16016611, checkBuffEffectType=40016611,dirX=0,dirY=1; DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; DataSelectResult,effectType=5,index=1; DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=4061662,label=buffAgain; PlayTargetAddBuff,buffID=4061661; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=buffAgain;         1                                                                                                                                                         key	   1   config,   1      _ENV