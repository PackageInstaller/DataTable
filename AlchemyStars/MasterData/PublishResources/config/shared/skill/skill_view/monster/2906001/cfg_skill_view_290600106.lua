LuaS �

xV           (w@a@../PublishResources/config/shared/skill/skill_view/monster/2906001/cfg_skill_view_290600106.lua         0   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K �� ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� ��  B  A� �� � �B� �@��AA �A �� �  A�  �� �� C �B� +A�k@�� � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               �9      PlayCasterBindEffect,effectID=290600115; PlayCasterAnimation,animName =skill05; PlayAudio,audioID = 290600118,audioType=1; DataSelectResult,effectType=5,index=1; PlayFlyEffectCasterToTarget,flyEffectID=290600118,flyTime=500,flyTrace=1,isBlock=0,caster=Target,target=Caster,label=goo; PlayTargetAddBuff,buffID=290600101; PlayTargetMaterialAnim,animName=eff_2000602_skill05_healing_mat; DataSelectNextResult,effectType=5; Jump,condition=CheckEffectResultIndex,param=5,goto=goo; Wait,waitTime=1000; PlayCasterMaterialAnim,animName=eff_2906001_skill05_mat; PlayAddHpText; �h       DataSelectDamage,damageIndex = 1; PlayCasterAnimation,animName =skill04; PlayAudio,audioID = 290600122,audioType=1; PlayCasterBindEffect,effectID=290600109; PlayCasterBindEffect,effectID=290600110; PlayTargetBeHitEffect,hitEffectID=290600111; Wait,waitTime=4000; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=2000; �(      PlayCasterBindEffect,effectID=290600115; PlayCasterAnimation,animName =skill05; DataSelectResult,effectType=5,index=1,damageStageIndex=2; PlayTargetAddBuff,buffID=290600106,label=go2; DataSelectNextResult,effectType=5; Jump,condition=CheckEffectResultIndex,param=5,goto=go2; Wait,waitTime=1000;         0                                                                                                                                                      key   0   config+   0      _ENV