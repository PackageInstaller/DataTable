LuaS �

xV           (w@P@../PublishResources/config/shared/skill/skill_view/cfg_skill_view_16013311.lua         0   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K �� ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� ��  B  A �� �B �B� �@��AA �A �� �  A�  �� �� � �B� +A�k@�� � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               k PlayCasterAnimation,animName = AtkChain1; PlayCasterBindEffect,effectID =3232; PlayAudio,audioID = 2388; �      �       DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayCasterTurnToTarget,label=doAgain; PlayFlyEffectCasterToTarget,flyEffectID=3234,flyTime=200,flyTrace=1,offsety=1,targetPos=Hit; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=3235,turnToTarget=1,deathClear=0; PlayCasterBindEffect,effectID =3233; PlayAudio,audioID = 2389; Wait,waitTime=100; PlayCasterAnimation,animName = AtkChain2; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; PlayCasterAnimation,animName = AtkChain3; Wait,waitTime=1000; ��       DataSelectScopeGridRange,effectType=58; DataSortScopeGridRange,sortType=0; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeConvert,dataSource=58,label=playConvert; PlayGridRangeEffect,effectID=480; Wait,waitTime=100; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playConvert; Wait,waitTime=500;         0                                                                                                                                                      key   0   config+   0      _ENV