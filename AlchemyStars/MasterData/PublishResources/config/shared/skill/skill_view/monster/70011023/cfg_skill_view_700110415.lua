LuaS �

xV           (w@b@../PublishResources/config/shared/skill/skill_view/monster/70011023/cfg_skill_view_700110415.lua         ;   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� ��  B  A �� �B �B� �@��AA �A �� �  A�  �� �� � �B� +A�K��� �� � A�  ��  � � AC +C� kA�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               � PlayCasterAnimation,animName = AtkUlt01; PlayAudio,audioID = 2172,audioType=1; PlayCasterBindEffect,effectID =1755; Wait,waitTime=500; PlayCasterBindEffect,effectID =452; PlayCasterVisible,visible=0; �      �"       DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayCasterEffectAtTargetPos,effectID=453,randomDir=1,label=doAgain; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=200; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; L      � PlayCasterVisible,visible=1; PlayCasterAnimation,animName = AtkUlt02; PlayCasterBindEffect,effectID =454; Wait,waitTime=3500;       � DataSelectDamage,damageIndex = 1,damageStageIndex=2; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain;         ;                                                                                                                                                                                       key   ;   config6   ;      _ENV