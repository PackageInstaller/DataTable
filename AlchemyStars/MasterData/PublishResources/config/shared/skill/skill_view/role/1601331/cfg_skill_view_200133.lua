LuaS 

xV           (w@@E:/depot_matchsrpg/matchsrpg/b/1505/client/Assets/../PublishResources/config/shared/skill/skill_view/role/1601331/cfg_skill_view_200133.lua         0   À 
@@
À@
@A
ÀA
@B
ÀB
@CK  Á@  A  A A  Á  K Â kB «@Ë Á  AÁ   ÁÁ  B  A  ÁB «B ë@AA A Á Â  AB   Ë Ã ëB +Ak@  Á      ¦  &     ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               k PlayCasterAnimation,animName = AtkChain1; PlayCasterBindEffect,effectID =3232; PlayAudio,audioID = 2388; °      ÿ       DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayCasterTurnToTarget,label=doAgain; PlayFlyEffectCasterToTarget,flyEffectID=3234,flyTime=200,flyTrace=1,offsety=1,targetPos=Hit; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=3235,turnToTarget=1,deathClear=0; PlayCasterBindEffect,effectID =3233; PlayAudio,audioID = 2389; Wait,waitTime=100; PlayCasterAnimation,animName = AtkChain2; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; PlayCasterAnimation,animName = AtkChain3; Wait,waitTime=2000; ª      ÿ4       DataSelectResult,effectType=80,index=1,damageStageIndex=2; PlaySelectedSplashDamage,hitAnimName=Hit,hitEffectID=0,turnToTarget=true,gridEffectID=-1,label=splashAgain; DataSelectNextResult,effectType=80,damageStageIndex=2; Wait,waitTime=380; Jump,condition=CheckEffectResultIndex,param=80,goto=splashAgain;         0                                                                                                                                                      key   0   config+   0      _ENV