LuaS �

xV           (w@a@../PublishResources/config/shared/skill/skill_view/monster/2902131/cfg_skill_view_290213103.lua         0   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K �� ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� �A  B  A �� �B �B� �@��AA �A �� B  AB  �� �� � �B� +A�k@�� � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               �       PlayCasterAnimation,animName=Atk02; PlayAudio,audioID =29021314,audioType=1; PlayAbsorbPieceEffect,flyEffectID=PARAM.effectID,offsetX=0,offsetY=0.5,offsetZ=0,flySpeed=150,targetPos=Hit,waitFlyEffectTime=800; PlayCasterBindEffect,effectID=290213107; Wait,waitTime=4200; �      � DataSelectDamage,damageIndex = 1; PlayTargetBeHitEffect,hitEffectID=290213108,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; �      � DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain;         0                                                                                                                                                      key   0   config+   0      _ENV