LuaS �

xV           (w@\@../PublishResources/config/shared/skill/skill_view/role/1602291/cfg_skill_view_2002291.lua         Q     
@@�
�@�
@A�
�A�
@B�
�B�
@C�
�C�K � �  �  A �@ k@� � �� �A  AA  �� �A  � A� �� �� �B� �@� A�  ��  �� B  AB  � �� C �B� C� +A K �A �A � AB  �B  � � A� +C� GC� kA � �� � A� �B  �B   K� �� kC� �C� �A � B AB �� �B  C  A �� � �C� �C� �A �@��    @  �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam       PhasePosDir       1,0        � PlayAudio,audioID = 160229102,audioType=1; PlayCasterTurnToTarget; PlayCasterAnimation,animName = AtkChain; PlayCasterBindEffect,effectID =160229108; Wait,waitTime=3000; �      �m       Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; DataSelectDamage,damageIndex = 1; PlayFlyEffectCasterToTarget,flyEffectID = 160229109,flyTime = 500,flyTrace = 1,isBlock = 0,beginFlyWaitTime=100,offsetWithRotate=1; Wait,waitTime=500; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=160229110,turnToTarget=0,deathClear=0; �m       Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; DataSelectDamage,damageIndex = 2; PlayFlyEffectCasterToTarget,flyEffectID = 160229109,flyTime = 500,flyTrace = 1,isBlock = 0,beginFlyWaitTime=100,offsetWithRotate=1; Wait,waitTime=500; DataSelectDamage,damageIndex = 2; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=160229110,turnToTarget=0,deathClear=0; �l       Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; DataSelectDamage,damageIndex =3; PlayFlyEffectCasterToTarget,flyEffectID = 160229109,flyTime = 500,flyTrace = 1,isBlock = 0,beginFlyWaitTime=100,offsetWithRotate=1; Wait,waitTime=500; DataSelectDamage,damageIndex = 3; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=160229110,turnToTarget=0,deathClear=0; �m       Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; DataSelectDamage,damageIndex = 4; PlayFlyEffectCasterToTarget,flyEffectID = 160229109,flyTime = 500,flyTrace = 1,isBlock = 0,beginFlyWaitTime=100,offsetWithRotate=1; Wait,waitTime=500; DataSelectDamage,damageIndex = 4; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=160229110,turnToTarget=0,deathClear=0;         Q                                                                                                                                                                                                                                    	   
   
   
   
   
      key	   Q   common   Q   configL   Q      _ENV