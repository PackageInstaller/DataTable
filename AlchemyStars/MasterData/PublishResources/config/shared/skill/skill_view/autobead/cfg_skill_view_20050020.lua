LuaS �

xV           (w@Y@../PublishResources/config/shared/skill/skill_view/autobead/cfg_skill_view_20050020.lua         0   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K �� ��@  A  A� �A  �� � K�  JBD�JB@��@�� ��  A�  �� �A  B  A� �� �� �B� �@��AA �A �� B  AB  � �� C �B� +A�k@�� � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam       +               audioID�	      
audioType� DataSelectDamage,damageIndex=1; PlayFlyEffectCasterToTarget,flyEffectID = 160167107,flyTime = 150,flyTrace = 1,isBlock =0,label=doAgain; Wait,waitTime=50; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=800; �       �       DataSelectDamage,damageIndex=1; PlayTargetBeHitEffect,hitEffectID=160167106,; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=160167106,turnToTarget=1,deathClear=0,label=doAgain; Wait,waitTime=50; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=800;         0                                                                                                                                                      key   0   config+   0      _ENV