LuaS �

xV           (w@Z@../PublishResources/config/shared/skill/skill_view/autobead/cfg_skill_view_200500271.lua         1     
@@�
�@�
@A�
�A�
@B�
�B�
@C�
�C�K �� ��@  A  A �A  � B K� �� kB� �@�� ��  A�  � �A  B  AB �� �� �B� �@��AA �A � B  AB  �B ˂  ʂŊ�B��+A�k@�� � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam       PhasePosDir               .      + PlayCasterBindEffect,effectID=200500107; ��       DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=21050274,remove=1,label=doAgain; PlayTargetAddBuff,buffID=21050275,remove=1; PlayTargetAddBuff,buffID=21050276,remove=1; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=3; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=1,label=playRangeEffect; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; Wait,waitTime=2000; +       audioID�	      
audioType        1                                                                                                                                                         key	   1   config,   1      _ENV