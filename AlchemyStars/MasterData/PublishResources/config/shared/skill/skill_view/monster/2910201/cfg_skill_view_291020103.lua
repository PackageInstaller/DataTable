LuaS �

xV           (w@a@../PublishResources/config/shared/skill/skill_view/monster/2910201/cfg_skill_view_291020103.lua         0   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K �� ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� �A  B  A �� �B �B� �@��AA �A �� �  A�  �B �� � �B� +A�k@�� � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               _ PlayCasterTurnToPlayer; PlayCasterAnimation,animName = skill1; PlayAudio,audioID = 29102012; �      �       DataSelectDamage,damageIndex = 1; PlayFlyEffectCasterToTarget,flyEffectID = 291020101,flyTime = 250,flyTrace = 1,offsetx = 0.08,offsety = 0.94,offsety = 0.27,isBlock = 0,finalWaitTime=500,targetPos=Hit,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=250; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=291020102,turnToTarget=1,deathClear=0,label=doAgain1; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain1; � DataSelectSummonThing,index=1; ShowSummonThing,label=redoShow; DataSelectNextSummonThing; Wait,waitTime=10; Jump,condition=CheckSummonThingValid,goto=redoShow;         0                                                                                                                                                      key   0   config+   0      _ENV