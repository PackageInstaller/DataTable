LuaS �

xV           (w@\@../PublishResources/config/shared/skill/skill_view/role/1602041/cfg_skill_view_4002041.lua         &     
@@�
�@�
@A�
�A�
@B�
�B�
@C�
�C�K  � ��@  A  A �A  �  K� �B kB� �@�� ��  A�  � �A  B  A �� �� �B� �@�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam       PhasePosDir               �y       PlayAudio,audioID = 2655,audioType=1; DataSelectDamage,damageIndex=1,damageStageIndex = 1; Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; PlayEffectAtTargetPos,effectID=160204115; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=1,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=900; � DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd; PlayTargetAddBuff,buffID=3002040,remove=1,label=buffAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=buffAgain;         &                                                                                                                        key	   &   config!   &      _ENV