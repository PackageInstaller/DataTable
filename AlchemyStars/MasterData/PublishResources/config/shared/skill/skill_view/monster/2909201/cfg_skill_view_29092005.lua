LuaS �

xV           (w@`@../PublishResources/config/shared/skill/skill_view/monster/2909201/cfg_skill_view_29092005.lua         0   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K �� ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� ��  B  A� �� � �B� �@��AA �A �� �  A�  �� �� C �B� +A�k@�� � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               �       PlayAudio,audioID = 290920103,audioType=1; PlayCasterAnimation,animName=Atk02; Wait,waitTime=567; PlayCasterBindEffect,effectID=290920101; PlayTeleportAsMoving,speed=33,stageIndex=1,moveUseResDir=1; Wait,waitTime=100; PlayCasterAnimation,animName=Atk02_2; Wait,waitTime=1500; ��       PlayAudio,audioID = 290920103,audioType=1; PlayCasterBindEffect,effectID=290920101; PlayCasterAnimation,animName=Atk02; PlayTeleportAsMoving,speed=33,stageIndex=2,moveUseResDir=1; Wait,waitTime=100; DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=290920112,turnToTarget=0,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; PlayCasterAnimation,animName=Atk02_2; �DataSelectResult,effectType=5,index=1,damageStageIndex=1; PlayAddBuffView,buffID=29092006,label=doAgain1; PlayAddBuffView,buffID=20021; DataSelectNextResult,effectType=5; Jump,condition=CheckEffectResultIndex,param=5,goto=doAgain1;         0                                                                                                                                                      key   0   config+   0      _ENV