LuaS �

xV           (w@\@../PublishResources/config/shared/skill/skill_view/role/1501001/cfg_skill_view_4301001.lua         &     
@@�
�@�
@A�
�A�
@B�
�B�
@C�
�C�K  � ��@  A  A ��  �  K� �B kB� �@�� ��  A�  � ��  B  A� �� �� �B� �@�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam       PhasePosDir               ��       Wait,waitTime=200; DataSelectDamage,damageStageIndex = 2,damageIndex=1; Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; PlayCommonBeHit,turnToTarget=0,deathClear=0,label=doAgain1; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain1; Wait,waitTime=100; DataSelectDamage,damageStageIndex = 1,damageIndex=1; PlayCommonBeHit,turnToTarget=0,deathClear=0,label=doAgain2; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain2; d       �       DataSelectDamage,damageStageIndex = 2,damageIndex=1; PlayEffectRotateTrajectory,start=Target,end=Caster,effectID=2293,block=0,startWait=0,moveSpeed=600,rotateSpeed=270,label=doAgain2; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain2;         &                                                                                                                        key	   &   config!   &      _ENV