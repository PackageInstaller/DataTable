LuaS �

xV           (w@�@E:/depot_matchsrpg/matchsrpg/b/1905/client/Assets/../PublishResources/config/shared/skill/skill_view/role/1501571/cfg_skill_view_300157.lua         ;   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� ��  B  A� �� � �B� �@��AA �A �� �  AB  �B �� � �B� +A�K��� �� � A�  �B  �� � A +C� kA�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               � PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID =1501571,waitTime =2000; ��       PlayTurnToPickUpPosDirection,pickUpIndex=1,waitTime=0; PlayAudio,audioID = 2481,audioType=1; PlayCasterAnimation,animName = AtkUlt; PlayCasterBindEffect,effectID =3699; PlayCasterBindEffect,effectID =3700; PlayCasterBindEffect,effectID =3701; PlayCasterBindEffect,effectID =3702; Wait,waitTime=666; PlayTrapAsMoving,time=100,summonOffset=0.5,moveAni=dash,moveEffID=3703,jumpAni=ult01,jumpEffID=0,jumpTime=166,fallAni=ult02,fallEffID=0,fallTime=2100; Wait,waitTime=1800; �      � DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=3704,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain;�      ��       DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffEffectType =4001571,label=doAgain; PlayTargetAddBuff,buffEffectType =300157; PlayTargetAddBuff,buffEffectType =310157; PlayTargetAddBuff,buffEffectType =320157; PlayTargetAddBuff,buffEffectType =330157; PlayTargetAddBuff,buffEffectType =302157; PlayTargetAddBuff,buffEffectType =312157; PlayTargetAddBuff,buffEffectType =322157; PlayTargetAddBuff,buffEffectType =332157; PlayTargetAddBuff,buffEffectType =305157; PlayTargetAddBuff,buffEffectType =315157; PlayTargetAddBuff,buffEffectType =325157; PlayTargetAddBuff,buffEffectType =335157; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain;         ;                                                                                                                                                                                       key   ;   config6   ;      _ENV