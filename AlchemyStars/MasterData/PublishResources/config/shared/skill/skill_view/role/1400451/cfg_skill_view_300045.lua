LuaS �

xV           (w@[@../PublishResources/config/shared/skill/skill_view/role/1400451/cfg_skill_view_300045.lua         %   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� ��  B  A� �� � �B� �@�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               ~ PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_red.prefab,petID = 1400451,waitTime = 2000;�9       PlayCasterAnimation,animName = AtkUlt; PlayCasterBindEffect,effectID=1643; PlayAudio,audioID = 3060,audioType=1; Wait,waitTime=333; DataSelectResult,effectType=85,index=1; PlayCostCasterHP; Wait,waitTime=767; PlayEffectAtPickUpIndexGrid,effectID=1644,pickUpIndex=1; Wait,waitTime=1350; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; PlayTargetAddBuff,buffID=20031; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; PlayCasterAddBuff,buffID=430045; Wait,waitTime=1250;         %                                                                                                                     key   %   config    %      _ENV