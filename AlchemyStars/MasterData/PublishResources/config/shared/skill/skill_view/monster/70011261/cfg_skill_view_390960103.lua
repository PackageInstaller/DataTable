LuaS �

xV           (w@b@../PublishResources/config/shared/skill/skill_view/monster/70011261/cfg_skill_view_390960103.lua         0   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K �� ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� �A  B  A �� �B �B� �@��AA �A �� �  A�  �� �� � �B� +A�k@�� � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               j PlayCasterAnimation,animName = AtkChain; PlayCasterBindEffect,effectID =1099; PlayAudio,audioID = 3020;        ��       DataSelectDamage,damageIndex = 1; PlayFlyEffectCasterToTarget,flyEffectID = 1100,flySpeed = 66,flyTrace = 1,offsety = 0.5,isBlock = 0,label=doAgain; Wait,waitTime=33; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=166; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=1101,turnToTarget=1,deathClear=0,label=doAgain1; Wait,waitTime=33; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain1;  Wait,waitTime=1500;         0                                                                                                                                                      key   0   config+   0      _ENV