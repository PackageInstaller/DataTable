LuaS �

xV           (w@\@../PublishResources/config/shared/skill/skill_view/role/1601781/cfg_skill_view_2001781.lua         0   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K �� ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� �A  B  A� �� � �B� �@��AA �A �� B  AB  �B �� � �B� +A�k@�� � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               � PlayCasterAnimation,animName = AtkChain; PlayAudio,audioID = 2573,audioType=1; PlayCasterBindEffect,effectID =160178108; Wait,waitTime=2000; ��       DataSelectDamage,damageIndex = 1; Jump,condition=CheckDamageIndexValid,result=0,goto=result2; PlayTargetBeHitEffect,hitEffectID=160178105; DataSelectDamage,damageIndex = 2,label=result2; Jump,condition=CheckDamageIndexValid,result=0,goto=result3; PlayTargetBeHitEffect,hitEffectID=160178106; DataSelectDamage,damageIndex = 3,label=result3; Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; PlayTargetBeHitEffect,hitEffectID=160178107,label=doAgain3; �      ��       DataSelectDamage,damageIndex = 1; Jump,condition=CheckDamageIndexValid,result=0,goto=result2; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,deathClear=0; DataSelectDamage,damageIndex = 2,label=result2; Jump,condition=CheckDamageIndexValid,result=0,goto=result3; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,deathClear=0; DataSelectDamage,damageIndex = 3,label=result3; Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,deathClear=0,label=doAgain3;         0                                                                                                                                                      key   0   config+   0      _ENV