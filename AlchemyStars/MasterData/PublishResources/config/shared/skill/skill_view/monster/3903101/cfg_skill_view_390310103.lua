LuaS �

xV           (w@�@E:/depot_matchsrpg/matchsrpg/b/1905/client/Assets/../PublishResources/config/shared/skill/skill_view/monster/3903101/cfg_skill_view_390310103.lua         <     
@@�
�@�
@A�
�A�
@B�
�B�
@C�
�C�K  � ��@  A  A �A  �  K� �B kB� �@�� ��  A�  � �A  B  A� �� �� �B� �@��AA �A � B  AB  �� ��  �B� +A�K��� ��  AB  �B  �� � AC +C� kA�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam       PhasePosDir               � PlayCasterBindEffect,effectID=1701; PlayCasterAnimation,animName = Skill01; Wait,waitTime=500; PlayAudio,audioID = 3105,audioType=1; Wait,waitTime=5300; �
      � DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=1,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain;� DataSelectResult,effectType=79,index=1; PlayDestroyTrap,label=foreach; DataSelectNextResult,effectType=79; Jump,condition=CheckEffectResultIndex,param=79,goto=foreach; D DataSelectResult,effectType=64,index=1; PlaySummonTrap,trapID=60;         <                                                                                                                                                                                          key	   <   config7   <      _ENV