LuaS �

xV           (w@a@../PublishResources/config/shared/skill/skill_view/monster/2000541/cfg_skill_view_400054101.lua         %   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� �A  B  A �� �B �B� �@�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               �`       DataSelectDamage,damageIndex = 1; PlayCasterAnimation,animName = Skill01; Wait,waitTime=600; PlayAudio,audioID = 7023,audioType=1; PlayCasterBindEffect,effectID=PARAM.effectID1; Wait,waitTime=200; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=PARAM.effectID2,turnToTarget=1,deathClear=0; Wait,waitTime=100; PlaySummonTrap,trapID=60; Wait,waitTime=500;        � DataSelectResult,effectType=79,index=1; PlayDestroyTrap,delay=0,label=foreach; DataSelectNextResult,effectType=79; Jump,condition=CheckEffectResultIndex,param=79,goto=foreach;         %                                                                                                                     key   %   config    %      _ENV