LuaS �

xV           (w@a@../PublishResources/config/shared/skill/skill_view/monster/2002001/cfg_skill_view_200200101.lua         %   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� �A  B  A �� �B �B� �@�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               �O       PlayCasterAnimation,animName = skill01; PlayAudio,audioID = 7038,audioType=1; Wait,waitTime=1000; DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=200200103,turnToTarget=1,deathClear=0,label=doDamageAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doDamageAgain; �      ��       PlayAudio,audioID = 7039,audioType=1; PlaySplashDamageAndAddBuff,flyEffectID=200200101,flyTotalTime=300,flyEffectHeight=0.4,gridEffectDelayTime=200,gridEffectID=200200102,hitDelayTime=300,hitAnimName=Hit,hitEffectID=200200103,turnToTarget=1,deathClear=0,buffID=20021,buffEffectType=2002; DataSelectBuff,buffIndex=1; PlayAddBuffView,buffID=20021,label=doAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain;         %                                                                                                                     key   %   config    %      _ENV