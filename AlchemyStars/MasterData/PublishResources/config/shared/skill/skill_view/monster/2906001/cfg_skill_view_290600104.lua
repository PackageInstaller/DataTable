LuaS �

xV           (w@a@../PublishResources/config/shared/skill/skill_view/monster/2906001/cfg_skill_view_290600104.lua         1     
@@�
�@�
@A�
�A�
@B�
�B�
@C�
�C�K �� ��@  A  A �A  �  K� �B kB� �@�� ��  A�  � ��  B  A �� �� �B� �@��AA �A � B  A�  �� ��  �B� +A�k@�� � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam       PhasePosDir               �      PlayCasterBindEffect,effectID=290600115; PlayCasterAnimation,animName =skill05; DataSelectResult,effectType=5,index=1; PlayFlyEffectCasterToTarget,flyEffectID=290600118,flyTime=500,flyTrace=1,isBlock=0,caster=Target,target=Caster,label=goo; PlayTargetAddBuff,buffID=290600101; PlayTargetMaterialAnim,animName=eff_2000602_skill05_healing_mat; DataSelectNextResult,effectType=5; Jump,condition=CheckEffectResultIndex,param=5,goto=goo; Wait,waitTime=1000; PlayCasterMaterialAnim,animName=eff_2906001_skill05_mat; PlayAddHpText; � PlayCasterAnimation,animName=skill02; PlayAudio,audioID = 290600120,audioType=1; PlayEffectAGridPos,effectID=290600107,gridPosX=5,gridPosY=5; PlayCameraEffect,effectID=290600108; Wait,waitTime=1000; Wait,waitTime=1000;       �       DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; DataSelectDamage,damageIndex = 1,damageStageIndex=2; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; DataSelectDamage,damageIndex = 1,damageStageIndex=3; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; DataSelectDamage,damageIndex = 1,damageStageIndex=4; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0;         1                                                                                                                                                         key	   1   config,   1      _ENV