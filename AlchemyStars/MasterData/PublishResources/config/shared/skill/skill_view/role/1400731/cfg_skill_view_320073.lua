LuaS �

xV           (w@�@C:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/config/shared/skill/skill_view/role/1400731/cfg_skill_view_320073.lua         %   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� ��  B  A� �� � �B� �@�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               ~ PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_red.prefab,petID = 1400731,waitTime = 2000;�s       PlayCasterAnimation,animName=AtkUlt; PlayAudio,audioID = 3018,audioType=1; PlayCasterBindEffect,effectID=1081; PlaySelectCenterGridEffect,effectID=1080,intervalTime=0; Wait,waitTime=1600; DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=0,deathClear=0,label=doAgain1; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain1; DataSelectDamage,damageIndex = 1,damageStageIndex=2; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=0,deathClear=0,label=doAgain2; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain2; DataSelectDamage,damageIndex = 1,damageStageIndex=3; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=0,deathClear=0,label=doAgain3; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain3; PlayGridRangeConvert; Wait,waitTime=5400;         %                                                                                                                     key   %   config    %      _ENV