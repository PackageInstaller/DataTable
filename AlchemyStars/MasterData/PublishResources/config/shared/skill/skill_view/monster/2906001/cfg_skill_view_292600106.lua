LuaS �

xV           (w@a@../PublishResources/config/shared/skill/skill_view/monster/2906001/cfg_skill_view_292600106.lua         %   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� ��  B  A� �� � �B� �@�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               �3       PlayCasterBindEffect,effectID=290600115; PlayCasterAnimation,animName =skill05; PlayAudio,audioID = 290600118,audioType=1; DataSelectBuff,buffIndex=1; PlayFlyEffectCasterToTarget,flyEffectID=290600118,flyTime=500,flyTrace=1,isBlock=0,caster=Target,target=Caster,label=goo; PlayTargetAddBuff,buffID=292600112,remove=1; PlayTargetAddBuff,buffID=292600102; PlayTargetMaterialAnim,animName=eff_2000602_skill05_healing_mat; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=goo; Wait,waitTime=1000; PlayCasterMaterialAnim,animName=eff_2906001_skill05_mat; �c       DataSelectDamage,damageIndex = 1; PlayCasterAnimation,animName =skill04; PlayAudio,audioID = 290600122,audioType=1; PlayVoice,voiceID=290600110; PlayCasterBindEffect,effectID=290600109; PlayCasterBindEffect,effectID=290600110; PlayTargetBeHitEffect,hitEffectID=290600111; Wait,waitTime=4000; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; PlayVoice,voiceID=290600111; DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=292600105,remove=1,label=goo; PlayTargetAddBuff,buffID=292600115,remove=1; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=goo; Wait,waitTime=2000;         %                                                                                                                     key   %   config    %      _ENV