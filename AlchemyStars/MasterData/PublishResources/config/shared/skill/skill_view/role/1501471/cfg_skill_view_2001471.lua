LuaS �

xV           (w@�@E:/depot_matchsrpg/matchsrpg/b/1705/client/Assets/../PublishResources/config/shared/skill/skill_view/role/1501471/cfg_skill_view_2001471.lua         F   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K �� ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� �A  B  A �� �B �B� �@��AA �A �� B  AB  �� �� � �B� +A�K��� �� � AB  �B  � � AC +C� kA����A B A� �B  �B  � K� �� kC� �A�k@�� � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               � PlayCasterAnimation,animName = AtkChain; PlayCasterBindEffect,effectID = 3458; PlayCasterBindEffect,effectID = 3459; PlayAudio,audioID = 2422,audioType=1; Wait,waitTime=3800; �	      �       DataSelectDamage,damageIndex=1; PlayFlyEffectCasterToTarget,flyEffectID = 3460,flyTime = 500,jumpPower= 3,flyTrace = 2,offsetx=-0.25,offsety=0.085,offsetz=0.1,isBlock=0 Wait,waitTime=500; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=3461,turnToTarget=1,deathClear=0;  
      �       DataSelectDamage,damageIndex=2; PlayFlyEffectCasterToTarget,flyEffectID = 3460,flyTime = 500,jumpPower= 3,flyTrace = 2,offsetx=-0.25,offsety=0.085,offsetz=0.1,isBlock=0; Wait,waitTime=500; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=3461,turnToTarget=1,deathClear=0; d
      �J       DataSelectDamage,damageIndex=3; Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; PlayFlyEffectCasterToTarget,flyEffectID = 3460,flyTime = 500,jumpPower= 3,flyTrace = 2,offsetx=-0.25,offsety=0.085,offsetz=0.1,isBlock=0; Wait,waitTime=500; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=3461,turnToTarget=1,deathClear=0; �
      �J       DataSelectDamage,damageIndex=4; Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; PlayFlyEffectCasterToTarget,flyEffectID = 3460,flyTime = 500,jumpPower= 3,flyTrace = 2,offsetx=-0.25,offsety=0.085,offsetz=0.1,isBlock=0; Wait,waitTime=500; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=3461,turnToTarget=1,deathClear=0;         F                                                                                                                                                                                                      	   	   	   	   	      key   F   configA   F      _ENV