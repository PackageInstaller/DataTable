LuaS �

xV           (w@\@../PublishResources/config/shared/skill/skill_view/role/1502081/cfg_skill_view_1522081.lua         %   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� �A  B  A �� �B �B� �@�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               � PlayCasterAnimation,animName = skill01; PlayCasterBindEffect,effectID=150208111; PlayCasterMaterialAnim,animName=effanim_15020811_skill_03_m; PlayAudio,audioID = 2678,audioType=1; Wait,waitTime=900; PlayMultiTraction; 4      �       DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=150208110,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime = 2000; DataSelectResult,effectType=79,index=1; PlayDestroyTrap;         %                                                                                                                     key   %   config    %      _ENV