LuaS �

xV           (w@Y@../PublishResources/config/shared/skill/skill_view/autobead/cfg_skill_view_20050019.lua         %   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� �A  B  A �� �B �B� �@�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               �!       DataSelectDamage,damageIndex=1; PlayFlyEffectCasterToTarget,flyEffectID=3234,flyTime=200,flyTrace=1,offsety=1,targetPos=Hit,label=doAgain; PlayAudio,audioID = 2396,audioType=1; Wait,waitTime=50; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=800; �       ��       DataSelectDamage,damageIndex=1; PlayTargetBeHitEffect,hitEffectID=3235,; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=3235,turnToTarget=1,deathClear=0,label=doAgain; Wait,waitTime=50; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=20011,label=buffAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=buffAgain; Wait,waitTime=800;         %                                                                                                                     key   %   config    %      _ENV