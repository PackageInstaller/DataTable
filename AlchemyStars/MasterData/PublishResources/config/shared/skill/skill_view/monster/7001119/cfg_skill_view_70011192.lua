LuaS �

xV           (w@`@../PublishResources/config/shared/skill/skill_view/monster/7001119/cfg_skill_view_70011192.lua         %   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� ��  B  A� �� � �B� �@�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               ��       PlayCasterAnimation,animName=Skill02; PlayAudio,audioID=6179,audioType=1; Wait,waitTime=300; PlayCasterBindEffect,effectID=3414; Wait,waitTime=30; PlayCasterMaterialAnim,animName=eff_2902101_skill02_main; Wait,waitTime=700; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=3413,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; � DataSelectResult,effectType=120,index=1; PlayDestroyMonster,label=foreach; DataSelectNextResult,effectType=120; Jump,condition=CheckEffectResultIndex,param=120,goto=foreach; Wait,waitTime=800;         %                                                                                                                     key   %   config    %      _ENV