LuaS �

xV           (w@�@E:/depot_matchsrpg/matchsrpg/b/150/client/Assets/../PublishResources/config/shared/skill/skill_view/role/1500151/cfg_skill_view_200151.lua         %   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� �A  B  A �� �B �B� �@�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               � PlayCasterAnimation,animName = AtkChain; PlayCasterBindEffect,effectID =3145; PlayAudio,audioID = 2366,audioType=1; Wait,waitTime=5000;       �B       DataSelectDamage,damageIndex = 1; PlayFlyEffectCasterToTarget,flyEffectID = 3146,flyTime = 50 ,offsetx=-0.816,offsety=0.856,offsetz=-3.56,flyTrace = 1,isBlock = 1,targetPos=Hit; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=3147,turnToTarget=1; DataSelectDamage,damageIndex = 2; PlayFlyEffectFromLastTargetToTarget,flyEffectID = 3146,flyTime = 50,flyTrace = 1,isBlock = 1,originalBoneName=Hit,targetPos=Hit,label=doAgain; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=3147,turnToTarget=1; Wait,waitTime=50; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain;         %                                                                                                                     key   %   config    %      _ENV