LuaS �

xV           (w@Y@../PublishResources/config/shared/skill/skill_view/autobead/cfg_skill_view_20050028.lua         %   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� �A  B  A �� �B �B� �@�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               c PlayTeamTurnToDirByCenterPosArray; PlayTeamBindEffect,effectID=3082, mode=1; Wait,waitTime=1000; d       �{       DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; Wait,waitTime=30; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain;Wait,waitTime=400; DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=20031,label=buffAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=buffAgain;         %                                                                                                                     key   %   config    %      _ENV