LuaS �

xV           (w@�@E:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/config/shared/skill/skill_view/monster/2900601/cfg_skill_view_490060103.lua         %   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� �A  B  A �� �B �B� �@�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               ��       PlayCasterAnimation,animName = Skill03; PlayAudio,audioID =6063,audioType=1; PlayCasterBindEffect,effectID=PARAM.effectID3; Wait,waitTime=2000; DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=8; DataSelectScopeGridRangeIndex,index=1; PlayGridRangeEffect,effectID=PARAM.effectID1,step=4,offset=0.5|0.5,label=playRangeEffect; PlayAudio,audioID =6064,audioType=1; Wait,waitTime=200; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=PARAM.effectID2,turnToTarget=1,deathClear=0; Wait,waitTime=100; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; Wait,waitTime=2000; �	      ��       DataSelectResult,effectType=64,index=1; PlaySummonTrap,trapID=PARAM.trapID1,label=foreach; DataSelectNextResult,effectType=64; Jump,condition=CheckEffectResultIndex,param=64,goto=foreach; DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd,label=buffLoop; PlayTargetAddBuff,buffID=PARAM.buffID2; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=buffLoop; Wait,waitTime=100;         %                                                                                                                     key   %   config    %      _ENV