LuaS �

xV           (w@�@C:/depot_matchsrpg/matchsrpg/b/170/client/Assets/../PublishResources/config/shared/skill/skill_view/role/1600191/cfg_skill_view_111.lua         N     
@@�
�@�
@A�
�A�
@B�
�B�
@C�
�C�K �� ��@  A  A �A  �  K� �B kB� �@�� ��  A�  � ��  B  A �� �� �B� �@��AA �A � �  A�  �� ��  �B� +A�K��� ��  A�  �B  �B � A� +C� kA����A B A� ��  �B   KC JC��JC@�JǍJ�ǎJ�ǏJCH�J�H�JD�JĒ�A�k@�� � �      �  & � &   ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam       PhasePosDir               ~ PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_red.prefab,petID = 1600191,waitTime = 2000;�-       PlayCasterAnimation,animName = AtkUlt; PlayAudio,audioID = 3038,audioType=1; PlayCasterBindEffect,effectID=1603; Wait,waitTime=3200; PlayCasterMeshVisible,visible=0,objs=1600191_body_d|1600191_face|1600191_weapon_d; PlayCasterMeshVisible,visible=0,objs=1600192_body_d|1600192_face|1600192_weapon_d; �      � PlayCasterMeshVisible,visible=1,objs=1600191_body_d|1600191_face|1600191_weapon_d; PlayCasterMeshVisible,visible=1,objs=1600192_body_d|1600192_face|1600192_weapon_d; PlayAddHpText; Wait,waitTime=2500; �      �s       DataSelectDamage,damageIndex = 1; Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; PlayFlyEffectCasterToTarget,flyEffectID =1604,flyTime = 500,flyTrace = 1,isBlock =0,offsety=1.5,offsetz=0.3,label=doAgain; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=1605,turnToTarget=1,deathClear=0; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain;        \      targetTypetrajectoryTypegridEffectIDD      
startHigh�(\����?endHighflyTotalTime�      	flySpeed2       finishDelayTimedeltaAngle        N                                                                                                                                                                                                                              	   	   	   	   	      key	   N   configI   N      _ENV