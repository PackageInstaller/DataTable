LuaS �

xV           (w@a@../PublishResources/config/shared/skill/skill_view/monster/2002001/cfg_skill_view_200200102.lua         %   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� �A  B  A �� �B �B� �@�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               �O       PlayCasterAnimation,animName = skill01; Wait,waitTime=700; PlayFlyEffectCasterToTarget,flyEffectID=200200101,flyTrace=1,flySpeed = 300,offsety=0.4,targetPos=Hit,isBlock=0; Wait,waitTime=500; DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; x      ��       DataSelectResult,effectType=80,index=1; PlaySplashDamage,hitAnimName=Hit,hitEffectID=0,turnToTarget=true,gridEffectID=200200102,label=splashAgain; DataSelectNextResult,effectType=80; Jump,condition=CheckEffectResultIndex,param=80,goto=splashAgain; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=200200103,turnToTarget=1,deathClear=0; Wait,waitTime=500; DataSelectBuff,buffIndex=1; PlayAddBuffView,buffID=20021,label=doAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain;         %                                                                                                                     key   %   config    %      _ENV