LuaS �

xV           (w@�@E:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/config/shared/skill/skill_view/monster/4900063/cfg_skill_view_490006301.lua         %   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� �A  B  A �� �B �B� �@�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               �'       PlayCasterBindEffect, effectID=273; PlayCasterAnimation,animName = Skill01; PlayAudio, audioID = 2008; Wait,waitTime=800; DataSelectDamage,damageIndex = 1; DataSelectDamageInfo,damageInfoIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=2100; �      � DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd,label=buffLoop; PlayTargetAddBuff,buffID=PARAM.buffID1; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=buffLoop;         %                                                                                                                     key   %   config    %      _ENV