LuaS �

xV           (w@`@../PublishResources/config/shared/skill/skill_view/monster/2908901/cfg_skill_view_29089014.lua         0   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K �� ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� �A  B  A �� �B �B� �@��AA �A �� �  AB  �� �� � �B� +A�k@�� � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               �P       PlayCasterTurnToRoundBeginPlayerPos; PlayCasterAnimation,animName=Skill01; PlayCasterBindEffect,effectID =290890105; PlayAudio,audioID = 290890104,audioType=1; PlayVoice,voiceID=8910047; Wait,waitTime=1200; DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=1000; �      ��      DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=3; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=290890107,isRotate=1,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=100; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect;5 PlaySummonTrap,trapID=2908921; Wait,waitTime=1000;         0                                                                                                                                                      key   0   config+   0      _ENV