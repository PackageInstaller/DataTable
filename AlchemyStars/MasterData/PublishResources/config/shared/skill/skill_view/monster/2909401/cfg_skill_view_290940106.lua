LuaS �

xV           (w@a@../PublishResources/config/shared/skill/skill_view/monster/2909401/cfg_skill_view_290940106.lua         ;   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  � �A  B  AB ��  ��D��BE��@��AA �A �� B  AB  �� �� � �B� +A�K��� �� � AB  �B  �� � A +C� kA�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               �H       PlayCasterAnimation,animName =Skill3_2; PlayEntityLegacyAnimation,animNames=eff_2909401_skill03_out,casterEffectID=290940105; PlayEntityLegacyAnimation,animNames=eff_2909401_skill03_out,casterEffectID=290940106; Wait,waitTime=3767; PlayDeleteCasterEffect,effectIDList=290940105; PlayDeleteCasterEffect,effectIDList=290940106; 3       �      audioID�dW    isPlay �      � PlayAudio,audioID = 290940106; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain1; Wait,waitTime=33; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain1; � DataSelectResult,effectType=64,index=1; PlaySummonTrap,trapID=78,label=foreach; PlaySummonTrap,trapID=2000903; DataSelectNextResult,effectType=64; Jump,condition=CheckEffectResultIndex,param=64,goto=foreach;         ;                                                                                                                                                                                       key   ;   config6   ;      _ENV