LuaS �

xV           (w@\@../PublishResources/config/shared/skill/skill_view/role/1400731/cfg_skill_view_3100731.lua         %   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� ��  B  A �� �B �B� �@�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               ~ PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_red.prefab,petID = 1400731,waitTime = 2000;�      �7       PlayCasterAnimation,animName=AtkUlt; PlayAudio,audioID = 3018,audioType=1; PlayCasterBindEffect,effectID=10811; PlaySelectCenterGridEffect,effectID=1080,intervalTime=0; Wait,waitTime=1600; DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=0,deathClear=0,label=doAgain1; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain1; DataSelectDamage,damageIndex = 1,damageStageIndex=2; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=0,deathClear=0,label=doAgain2; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain2; DataSelectDamage,damageIndex = 1,damageStageIndex=3; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=0,deathClear=0,label=doAgain3; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain3; DataSelectDamage,damageIndex = 1,damageStageIndex=4; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=0,deathClear=0,label=doAgain4; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain4; Wait,waitTime=4400;         %                                                                                                                     key   %   config    %      _ENV