LuaS �

xV           (w@[@../PublishResources/config/shared/skill/skill_view/role/1602271/cfg_skill_view_220227.lua         0   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K �� ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� ��  B  A� �� � �B� �@��AA �A �� �  AB  �� �� C �B� +A�k@�� � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               - PlayAudio,audioID = 160227102,audioType=1; ��       Jump,condition=CheckDamageSkillResultTargetCount,param=2|1|5,goto=phaseEnd; DataSelectBuff,buffIndex=1; PlayCasterAnimation,animName = AtkChain1; PlayCasterTurnToTarget; PlayCasterBindEffect,effectID =160227101; Wait,waitTime=800; PlayTargetBindEffect,effectID=160227103; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd; PlayTargetAddBuff,buffID=420227101; PlayTargetAddBuff,buffID=420227102; PlayTargetAddBuff,buffID=420227103; Wait,waitTime=1000; �w       Jump,condition=CheckDamageSkillResultTargetCount,param=6|1|5,goto=phaseEnd; DataSelectBuff,buffIndex=1; PlayCasterAnimation,animName = AtkChain1; PlayCasterTurnToTarget; PlayCasterBindEffect,effectID =160227101; PlayCasterBindEffect,effectID =160227102; Wait,waitTime=800; PlayTargetBindEffect,effectID=160227103; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd; PlayTargetAddBuff,buffID=420227101; PlayTargetAddBuff,buffID=420227102; PlayTargetAddBuff,buffID=420227103; Wait,waitTime=1200; DataSelectBuff,buffIndex=2; PlayAudio,audioID = 160227102,audioType=1; PlayCasterAnimation,animName = AtkChain2; PlayCasterTurnToTarget; Wait,waitTime=500; PlayTargetBindEffect,effectID=160227103; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd; PlayTargetAddBuff,buffID=420227101; PlayTargetAddBuff,buffID=420227102; PlayTargetAddBuff,buffID=420227103; Wait,waitTime=2000;         0                                                                                                                                                      key   0   config+   0      _ENV