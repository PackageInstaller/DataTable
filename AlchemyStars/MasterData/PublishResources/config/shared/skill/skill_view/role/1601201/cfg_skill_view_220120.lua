LuaS �

xV           (w@[@../PublishResources/config/shared/skill/skill_view/role/1601201/cfg_skill_view_220120.lua         <     
@@�
�@�
@A�
�A�
@B�
�B�
@C�
�C�K  � ��@  A  A �A  �  K� �B kB� �@�� ��  A�  �� �A  B  A ��  �ŉ�B���@��AA �A � B  AB  �� �� � �B� +A�K��� ��  A�  �B � � A +C� kA�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam       PhasePosDir               � PlayCasterAnimation,animName = AtkChain; PlayCasterMaterialAnim,animName=eff_1601201_atkchain_skin; PlayCasterBindEffect,effectID = 3133; Wait,waitTime = 1000; +       audioID<	      
audioType�      �DataSelectDamage,damageIndex = 1,damageStageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=3132,turnToTarget=0,deathClear=0,label=doAgain; Wait,waitTime=20; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain;�DataSelectDamage,damageIndex = 1,damageStageIndex = 2; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=3132,turnToTarget=0,deathClear=0,label=doAgain; Wait,waitTime=20; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain;        <                                                                                                                                                                                          key	   <   config7   <      _ENV